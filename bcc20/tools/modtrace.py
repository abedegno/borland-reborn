"""Run Borland's BCC.EXE over the test corpus in a tracing emu2, and report what it shows.

    python3 tools/modtrace.py [--emu2 PATH] [--jobs N]

The tracing emu2 (Exhume's tools/emu2-trace, built by tools/setup-emu2-trace.sh) marks every
byte of memory with the program-file offset it was loaded from and follows those marks
through registers and copies.  For each compile it writes which words of BCC.EXE were used
as addresses of data-segment items, which as code addresses, and which instructions ran.
This runs the corpus of tools/modtest.py (each source with its own switches and steps),
merges the traces and writes:

- map/traced-pointers.tsv: the data-segment words used as DGROUP addresses or as code
  addresses at run time, with use counts: evidence that tools/findptrs.py reads when it
  writes map/data-pointers.tsv (words of far pointers, which have relocations, are listed
  too and ignored there);
- build-source/MODTRACE/coverage.tsv: for every module and function, the share of its code
  bytes that ran (an instruction's bytes count from its first byte to the next one that ran
  or the function's end), and docs/COVERAGE.md, the summary.

A data word counts as a DGROUP address when a register loaded from it still holds about
the stored value (plus under 100h, so a pointer moved through its item) and forms the
address of a memory access through DGROUP with a displacement under 100h.
"""
import argparse
import os
import re
import shutil
import struct
import subprocess
import sys
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402
import modtest  # noqa: E402

ROOT = modlink.ROOT
WORK = ROOT / "build-source" / "MODTRACE"
ORIGINAL = ROOT / "toolchain" / "BC20" / "BIN" / "BCC.EXE"
DGROUP_PARA = 0x0DEF        # DGROUP's paragraph from the load segment
DATA_END = modlink.DATA_END
# modules linked as code that hold data: the message texts, read as an image by MSGGET
NOT_CODE = {"MESSAGES"}
RUNS = [0, 0]               # compiles and files of the last run, for the summary


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--emu2", default=str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2"))
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    args = ap.parse_args()
    if WORK.exists():
        shutil.rmtree(WORK)
    WORK.mkdir(parents=True)
    shutil.copytree(ROOT / "toolchain" / "BC20" / "INCLUDE", WORK / "INCLUDE")
    shutil.copytree(ROOT / "src" / "include", WORK / "PROJ")
    shutil.copy(ORIGINAL, WORK / "BCC.EXE")
    shutil.copy(ORIGINAL.parent / "TLINK.EXE", WORK / "TLINK.EXE")
    jobs, i = [], 0
    for name, path, opts, steps in modtest.corpus():
        for modes in steps:
            jobs.append((args.emu2, i, name, path, opts, modes))
            i += 1
    # each run needs its own working directory for T.C and its outputs
    def run_in_dir(job):
        emu2, index, name, path, opts, modes = job
        d = WORK / "runs" / f"{index:04d}"
        d.mkdir(parents=True, exist_ok=True)
        for sub in ("INCLUDE", "PROJ"):
            link = d / sub
            if not link.exists():
                link.symlink_to(WORK / sub, target_is_directory=True)
        for exe in ("BCC.EXE", "TLINK.EXE"):    # TLINK: for the tests that link (modtest.py)
            if not (d / exe).exists():
                (d / exe).symlink_to(WORK / exe)
        src = d / ("T" + path.suffix.upper())
        shutil.copy(path, src)
        os.utime(src, (modtest.STAMP, modtest.STAMP))
        for step, mode in enumerate(modes):
            env = dict(os.environ, EMU2_TRACE=str(d / f"trace{step}"), EMU2_TRACE_DGROUP=f"{DGROUP_PARA:X}")
            try:
                subprocess.run([emu2, "BCC.EXE", *modtest.command(mode, opts, src.name)],
                               cwd=d, env=env, capture_output=True, timeout=300)
            except subprocess.TimeoutExpired:
                return f"{name} {mode} timeout"
        return None
    RUNS[:] = [len(jobs), len({j[3] for j in jobs})]
    with ThreadPoolExecutor(args.jobs) as pool:
        for problem in pool.map(run_in_dir, jobs):
            if problem:
                print(problem)
    report()


def report():
    data = ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    dgroup_file = header + DGROUP_PARA * 16
    P, C, E = defaultdict(int), defaultdict(int), set()
    for f in (WORK / "runs").glob("*/trace*.*"):
        for line in f.read_text().splitlines():
            kind, off, *n = line.split()
            off = int(off, 16)
            if kind == "P":
                P[off] += int(n[0])
            elif kind == "C":
                C[off] += int(n[0])
            else:
                E.add(off)
    # pointers in the data segment
    lines = ["# DS offset\tvalue\tkind\tuses  (tools/modtrace.py: words of BCC.EXE's data used as"
             " addresses by the test corpus)"]
    for off in sorted(set(P) | set(C)):
        if dgroup_file <= off < dgroup_file + DATA_END:
            ds = off - dgroup_file
            value = struct.unpack_from("<H", data, off)[0]
            if off in P:
                lines.append(f"{ds:04X}\t{value:04X}\tdata\t{P[off]}")
            if off in C:
                lines.append(f"{ds:04X}\t{value:04X}\tcode\t{C[off]}")
    (ROOT / "map" / "traced-pointers.tsv").write_text("\n".join(lines) + "\n")
    # coverage by module and function
    modules = modlink.load_modules()
    original = modlink.Original()
    rows = ["# module\tfunction\tbytes\tran\tshare"]
    totals = []
    for m in sorted(modules, key=lambda m: (m.overlay, m.base if m.overlay else original.block_para[m.block] * 16 + m.org)):
        if m.stem in NOT_CODE:
            continue
        start = m.base if m.overlay else header + original.block_para[m.block] * 16 + m.org
        starts = sorted(off for _, off in m.functions)
        ran_module = 0
        for name, off in m.functions:
            size = m.sizes.get(off, 0)
            ran = ran_bytes(E, start + off, size)
            ran_module += ran
            rows.append(f"{m.stem}\t{name}\t{size}\t{ran}\t{(100 * ran // size) if size else 0}%")
        totals.append((m, m.size, ran_module))
    (WORK / "coverage.tsv").write_text("\n".join(rows) + "\n")
    write_summary(totals, len(modules))
    print(f"pointers: {len(lines) - 1} data-segment words in map/traced-pointers.tsv; coverage: build-source/MODTRACE/coverage.tsv, docs/COVERAGE.md")


def ran_bytes(executed, start, size):
    """Bytes of [start, start+size) inside instructions that ran: from each executed start to the
    next executed start or the end, capped at 15 bytes (the longest 8086 instruction is 6, but
    a run of prefixes or a following unexecuted instruction is not counted beyond that)."""
    marks = sorted(o for o in range(start, start + size) if o in executed)
    total = 0
    for i, o in enumerate(marks):
        nxt = marks[i + 1] if i + 1 < len(marks) else start + size
        total += min(nxt - o, 6)
    return min(total, size)


def write_summary(totals, count):
    resident = [(m, s, r) for m, s, r in totals if not m.overlay]
    overlaid = [(m, s, r) for m, s, r in totals if m.overlay]

    def share(group):
        s = sum(x[1] for x in group)
        r = sum(x[2] for x in group)
        return s, r, (100 * r // s) if s else 0

    lines = ["# Code coverage of the test corpus", "",
             "Which of BCC.EXE's code the modding build's test corpus runs (`tools/modtrace.py`):",
             f"Borland's BCC.EXE runs the {RUNS[0]} compiles of `tools/modtest.py` ({RUNS[1]} files, each",
             "with its own switches) in a tracing emu2, which records every instruction that runs.",
             "The modding build is checked by these compiles, so code they never run is not checked",
             "by them.",
             "", "| Part | Code bytes | Ran | Share |", "|---|---|---|---|"]
    for label, group in (("resident", resident), ("overlays", overlaid), ("all", totals)):
        s, r, p = share(group)
        lines.append(f"| {label} | {s} | {r} | {p}% |")
    lines += ["", "Modules by share of code that ran (lowest first):", "",
              "| Module | Code bytes | Share |", "|---|---|---|"]
    for m, s, r in sorted(totals, key=lambda x: (x[2] / x[1] if x[1] else 0, -x[1])):
        lines.append(f"| {m.stem} | {s} | {(100 * r // s) if s else 0}% |")
    lines += ["", "MESSAGES, the message texts linked as an overlay and read as an image, is left out.",
              "", "Per function: `build-source/MODTRACE/coverage.tsv` after a run."]
    (ROOT / "docs" / "COVERAGE.md").write_text("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()

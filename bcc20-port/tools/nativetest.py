"""Compare the native build (build/bcc) with BCC.EXE over the corpus (README.md, "Plan",
step 4): every step of every corpus test (tools/record.py's corpus_steps: -c, -S, a link or
BCC alone, several modes of a step in order in one directory) runs in BCC.EXE under emu2
and in build/bcc, each in its own staged directory, and after each mode the output files
(T.OBJ, T.ASM; a precompiled header file by its size, since it holds BCC's addresses), the
exit status and the console text must be the same.  TLINK, which a link runs, goes
through emu2 in both (BCC_DOS_RUNNER).  The port runs with
BCC_EMU2_FIND set, so that like emu2 it neither cuts a name longer than 8.3 when it opens a
file nor finds such a name with find first (DOS cuts it in both).  The console's "Available
memory" figure comes from the heap and is left out of the comparison.

    python3 tools/nativetest.py [--runs N] [--only NAME] [--jobs J] [--keep] [--lib]

With --lib the port side runs through the library (include/bcc20.h, build/bcc20run): the
source is given from memory, the run directory is the job's root for the headers, the
clock is pinned to the source's time, and each compile runs twice in one process, which
must give the same output both times.  Link steps are left out there (TLINK, a separate
program, cannot see files that are only in memory).
"""
import argparse
import os
import shutil
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import record   # noqa: E402

modtest = record.modtest
PORT = Path(__file__).resolve().parents[1]
WORK = PORT / "build" / f"nativetest-{os.getpid()}"


def console(text):
    return "\n".join(line for line in text.replace("\r\n", "\n").split("\n")
                     if "Available memory" not in line).strip()


def run_one(job, emu2, keep, lib=False):
    index, (name, path, opts, modes) = job
    if lib and "link" in modes:
        return name, " ".join(modes), None
    base = WORK / "runs" / f"{index:04d}"
    results = {}
    for side in ("orig", "port"):
        d = base / side
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        (d / "TLINK.EXE").symlink_to(WORK / "TLINK.EXE")    # what BCC runs for `link`
        src = d / modtest.source_name(path)
        shutil.copy2(path, src)
        record.stage_config(d, path)
        if side == "orig":
            (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
        # emu2's find first (native.c); DOS programs the port runs go through emu2
        env = dict(os.environ, BCC_EMU2_FIND="1", BCC_HEAP_CUT=os.environ.get("BCC_HEAP_CUT", "0"),
                   BCC_DOS_RUNNER=emu2)
        steps = []
        for mode in modes:      # in order, in one directory (a precompiled header file)
            args = modtest.command(mode, opts, src.name)
            if side == "orig":
                cmd = [emu2, "BCC.EXE", *args]
            elif lib:
                cmd = [str(PORT / "build" / "bcc20run"), "--file", f"{src.name}={src.name}", "--root", ".",
                       "--time", str(int(src.stat().st_mtime)), "--repeat", "2", "--", *args]
            else:
                cmd = [str(PORT / "build" / "bcc"), *args]
            try:
                # one stream, so that a child program's text keeps its place
                done = subprocess.run(cmd, cwd=d, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                      timeout=300, env=env)
                out, rc = done.stdout.decode("latin1"), done.returncode
            except subprocess.TimeoutExpired:
                out, rc = "TIMEOUT", -1
            # a precompiled header file holds BCC's own addresses: compared by size alone
            files = {p.name.upper(): p.read_bytes() if p.suffix.upper() != ".SYM" else len(p.read_bytes())
                     for p in d.iterdir()
                     if p.is_file() and p.suffix.upper() in (".OBJ", ".ASM", ".SYM")}
            steps.append((console(out), rc, files))
        results[side] = steps
    problems = []
    for step, (o, p) in enumerate(zip(results["orig"], results["port"])):
        at_step = f"step {step + 1} ({modes[step]}): " if len(modes) > 1 else ""
        # emu2 buffers BCC's console text while the program a link runs (TLINK) writes its
        # own, in the same process, so there the order of the two differs from DOS's (and
        # the port's): a link's lines are compared in any order
        same = sorted(o[0].split("\n")) == sorted(p[0].split("\n")) if modes[step] == "link" else o[0] == p[0]
        if not same:
            problems.append(f"{at_step}console differs:\n--- BCC.EXE\n{o[0]}\n--- port\n{p[0]}")
        if o[1] != p[1]:
            problems.append(f"{at_step}exit status {o[1]} (BCC.EXE) and {p[1]} (port)")
        for f in sorted(set(o[2]) | set(p[2])):
            if f not in o[2] or f not in p[2]:
                problems.append(f"{at_step}{f} written only by {'the port' if f in p[2] else 'BCC.EXE'}")
            elif o[2][f] != p[2][f]:
                a, b = o[2][f], p[2][f]
                if isinstance(a, int) or isinstance(b, int):
                    problems.append(f"{at_step}{f} has size {a} (BCC.EXE) and {b} (port)")
                    continue
                at = next((i for i in range(min(len(a), len(b))) if a[i] != b[i]), min(len(a), len(b)))
                problems.append(f"{at_step}{f} differs at byte {at:#x} (sizes {len(a)} and {len(b)})")
    if not keep and not problems:
        shutil.rmtree(base)
    return name, " ".join(modes), problems


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--runs", type=int, default=0)
    ap.add_argument("--only")
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--keep", action="store_true", help="keep the directories of every run")
    ap.add_argument("--lib", action="store_true", help="the port through the library (build/bcc20run)")
    ap.add_argument("--emu2", default=str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2"))
    args = ap.parse_args()
    jobs = record.corpus_steps()
    if args.only:
        jobs = [j for j in jobs if j[0] == args.only]
    if args.runs and args.runs < len(jobs):
        jobs = [jobs[i * len(jobs) // args.runs] for i in range(args.runs)]
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    shutil.copy(modtest.ORIGINAL.parent / "TLINK.EXE", WORK / "TLINK.EXE")
    same = skipped = 0
    failed = []
    with ThreadPoolExecutor(args.jobs) as pool:
        for name, mode, problems in pool.map(lambda j: run_one(j, args.emu2, args.keep, args.lib), enumerate(jobs)):
            if problems is None:
                skipped += 1
            elif problems:
                failed.append(name)
                print(f"{name} {mode}: " + "\n  ".join(problems))
            else:
                same += 1
    print(f"{same} of {len(jobs) - skipped} compiles the same as BCC.EXE" +
          (f" ({skipped} link steps left out)" if skipped else ""))
    if not failed:
        shutil.rmtree(WORK, ignore_errors=True)
    else:
        print(f"run directories of the differing compiles: {WORK / 'runs'}")
    return 0 if not failed else 1


if __name__ == "__main__":
    sys.exit(main())

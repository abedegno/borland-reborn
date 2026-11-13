"""Record calls of BCC.EXE functions over the test corpus, for build/replay.

    python3 tools/record.py FUNCTION... [--per-run N] [--max N] [--runs N] [--emu2 PATH]
    python3 tools/record.py --all ...      every function the port declares (include/*.h)

Runs Borland's BCC.EXE over the corpus of ../bcc20/tools/modtest.py in the tracing emu2 with
its call recorder on (EMU2_RECORD), and writes records/FUNCTION.rec: up to --max different
calls of each function (default 500; identical calls are kept once).  --per-run caps the
calls kept from one compile (default 40), so the records come from many inputs; --runs
limits the number of compiles (default all; they are spread evenly over the corpus).

A function is found by its name in the matched tree (../bcc20/src, the target tables): its
first instruction's offset in BCC.EXE, which holds for overlay code too.  Inside each
recorded call, the calls it makes to functions the port does not define yet (directly, or
through translated functions) are recorded as its children (EMU2_RECORD_INNER), so replay
can answer them; they follow their parent in the file, named on their CALL lines.  The
overlay manager's work (OVRMGR, OVRLOAD: loading an overlay when one calls into another) is
not recorded (EMU2_RECORD_IGNORE): no translation does it.  The compile and
-S steps are recorded; steps that link are not (TLINK would run in the same emulator).
The records hold memory of Borland's program, so records/ is never committed.
"""
import argparse
import hashlib
import os
import re
import shutil
import struct
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]
BCC20 = PORT.parent / "bcc20"
sys.path.insert(0, str(BCC20 / "tools"))
sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402
import modtest  # noqa: E402
import genadapters  # noqa: E402

WORK = PORT / "build" / f"record-{os.getpid()}"   # one per run: agents record in parallel


def function_offsets():
    """name -> offset of its first instruction in BCC.EXE.  From ../bcc20/symbols.tsv: a
    resident function's segment:offset, or an overlay function's stub entry (CD 3F and the
    offset in the overlay), whose overlay starts at the stub's file offset; then the target
    tables, whose older names some functions still have there."""
    data = modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    out = {}
    for line in (BCC20 / "symbols.tsv").read_text().splitlines():
        parts = line.split("\t")
        if len(parts) < 2 or not re.fullmatch(r"[0-9A-F]{4}:[0-9A-F]{4}", parts[1]):
            continue
        seg, off = (int(x, 16) for x in parts[1].split(":"))
        at = header + seg * 16
        if data[at:at + 2] == b"\xcd\x3f" and data[at + off:at + off + 2] == b"\xcd\x3f":
            out[parts[0]] = (original.stub_file_offset(seg) + modlink.OVERLAY_BASE
                             + struct.unpack_from("<H", data, at + off + 2)[0])
        else:
            out[parts[0]] = at + off
    for m in modlink.load_modules():
        start = m.base if m.overlay else header + original.block_para[m.block] * 16 + m.org
        for name, off in m.functions:
            out.setdefault(name, start + off)
    return out


def ignored_code():
    """the overlay manager's code, as EMU2_RECORD_IGNORE ranges of file offsets"""
    data = modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    ranges = []
    for m in modlink.load_modules():
        if m.stem in ("OVRMGR", "OVRLOAD"):
            start = header + original.block_para[m.block] * 16 + m.org
            ranges.append(f"{start:X}-{start + m.size - 1:X}")
    return ",".join(ranges)


def boundary(functions):
    """the functions the port does not define that these reach directly or through
    translated functions, and every untranslated function whose address is taken (it may
    be called through a pointer): what their translations call as stand-ins"""
    import ready
    where, _, graph = ready.call_graph()
    done = set(genadapters.prototypes())
    out, seen, todo = set(), set(), list(functions)
    # functions called through pointers (callbacks, hook tables) are not in the call graph:
    # every function whose address is taken somewhere may be called that way
    names = set(where)
    for path in set(where.values()):
        if path.suffix.upper() == ".C":
            text = re.sub(r"/\*.*?\*/", " ", path.read_text(encoding="latin1"), flags=re.S)
            out |= {m.group(1) for m in re.finditer(r"\b([A-Za-z_]\w*)\b(?!\s*\()", text)
                    if m.group(1) in names and m.group(1) not in done}
    # and the code pointers in the data segment's initial values
    dgroup = (BCC20 / "src" / "data" / "DGROUP.ASM").read_text(encoding="latin1")
    out |= {m.group(1) for m in re.finditer(r"^\s+dd\s+([A-Za-z_@][\w@]*)", dgroup, re.M)} - done
    while todo:
        f = todo.pop()
        for c in graph.get(f, ()):
            if c in done:
                if c not in seen:
                    seen.add(c)
                    todo.append(c)
            else:
                out.add(c)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("functions", nargs="*")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--per-run", type=int, default=40)
    ap.add_argument("--max", type=int, default=500)
    ap.add_argument("--runs", type=int, default=0)
    ap.add_argument("--emu2", default=os.environ.get("EMU2_TRACE_BIN",
                    str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2")))
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    args = ap.parse_args()

    if args.all:
        args.functions = sorted(genadapters.prototypes())
    if not args.functions:
        raise SystemExit("record: name the functions, or --all")
    offsets = function_offsets()
    missing = [f for f in args.functions if f not in offsets]
    if missing:
        raise SystemExit(f"record: not in the matched tree: {' '.join(missing)}")
    wanted = {offsets[f]: f for f in args.functions}
    # children by offset; where names share an address, the one the port declares (the name
    # replay's stand-in and code_function() use)
    declared = genadapters.definitions()
    inner = {}
    for f in sorted(boundary(args.functions), key=lambda f: f not in declared):
        if f in offsets:
            inner.setdefault(offsets[f], f)
    for name, off in offsets.items():
        if off in inner and name in declared and inner[off] not in declared:
            inner[off] = name

    jobs = [(name, path, opts, mode) for name, path, opts, steps in modtest.corpus()
            for modes in steps for mode in modes if mode in ("-c", "-S")]
    if args.runs and args.runs < len(jobs):
        jobs = [jobs[i * len(jobs) // args.runs] for i in range(args.runs)]
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    env_at = ",".join(f"{o:X}" for o in wanted)
    env_inner = ",".join(f"{o:X}" for o in inner)
    env_ignore = ignored_code()

    def run(job):
        index, (name, path, opts, mode) = job
        d = WORK / "runs" / f"{index:04d}"
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
        src = d / modtest.source_name(path)
        shutil.copy(path, src)
        env = dict(os.environ, EMU2_RECORD=str(d / "rec"), EMU2_RECORD_AT=env_at,
                   EMU2_RECORD_INNER=env_inner, EMU2_RECORD_IGNORE=env_ignore,
                   EMU2_RECORD_MAX=str(args.per_run))
        try:
            subprocess.run([args.emu2, "BCC.EXE", *modtest.command(mode, opts, src.name)],
                           cwd=d, env=env, capture_output=True, timeout=300)
        except subprocess.TimeoutExpired:
            pass
        text = "".join(f.read_text() for f in d.glob("rec.*"))
        shutil.rmtree(d)
        return text

    calls = {f: {} for f in args.functions}
    with ThreadPoolExecutor(args.jobs) as pool:
        for text in pool.map(run, enumerate(jobs)):
            children = {}
            for rec in re.findall(r"^CALL .*?^END\n", text, re.M | re.S):
                head, body = rec.split("\n", 1)
                off = int(head.split()[1], 16)
                if body.startswith("PARENT "):
                    parents = []
                    while body.startswith("PARENT "):
                        parent, body = body.split("\n", 1)
                        parents.append(parent.split()[1:])
                    for p_off, p_seq, index in parents:
                        children.setdefault((int(p_off, 16), int(p_seq)), []).append(
                            (int(index), f"CALL {off:X} 0 {inner[off]}\nPARENT\n{body}"))
                    continue
                name = wanted[off]
                kids = "".join(k for _, k in sorted(children.pop((off, int(head.split()[2])), [])))
                if len(calls[name]) < args.max:
                    calls[name].setdefault(hashlib.sha1((body + kids).encode()).hexdigest(), body + kids)
    out = PORT / "records"
    out.mkdir(exist_ok=True)
    for name, found in calls.items():
        (out / f"{name}.rec").write_text("".join(
            f"CALL {offsets[name]:X} {i}\n{body}" for i, body in enumerate(found.values())))
        print(f"{name}: {len(found)} different calls from {len(jobs)} compiles -> records/{name}.rec")


if __name__ == "__main__":
    main()

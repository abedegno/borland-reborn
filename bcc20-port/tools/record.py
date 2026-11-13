"""Record calls of BCC.EXE functions over the test corpus, for build/replay.

    python3 tools/record.py FUNCTION... [--per-run N] [--max N] [--runs N] [--emu2 PATH]

Runs Borland's BCC.EXE over the corpus of ../bcc20/tools/modtest.py in the tracing emu2 with
its call recorder on (EMU2_RECORD), and writes records/FUNCTION.rec: up to --max different
calls of each function (default 500; identical calls are kept once).  --per-run caps the
calls kept from one compile (default 20), so the records come from many inputs; --runs
limits the number of compiles (default all; they are spread evenly over the corpus).

A function is found by its name in the matched tree (../bcc20/src, the target tables): its
first instruction's offset in BCC.EXE, which holds for overlay code too.  The compile and
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
import modlink  # noqa: E402
import modtest  # noqa: E402

WORK = PORT / "build" / "record"


def function_offsets():
    """name -> offset of its first instruction in BCC.EXE"""
    data = modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    out = {}
    for m in modlink.load_modules():
        start = m.base if m.overlay else header + original.block_para[m.block] * 16 + m.org
        for name, off in m.functions:
            out.setdefault(name, start + off)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("functions", nargs="+")
    ap.add_argument("--per-run", type=int, default=20)
    ap.add_argument("--max", type=int, default=500)
    ap.add_argument("--runs", type=int, default=0)
    ap.add_argument("--emu2", default=os.environ.get("EMU2_TRACE_BIN",
                    str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2")))
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    args = ap.parse_args()

    offsets = function_offsets()
    missing = [f for f in args.functions if f not in offsets]
    if missing:
        raise SystemExit(f"record: not in the matched tree: {' '.join(missing)}")
    wanted = {offsets[f]: f for f in args.functions}

    jobs = [(name, path, opts, mode) for name, path, opts, steps in modtest.corpus()
            for modes in steps for mode in modes if mode in ("-c", "-S")]
    if args.runs and args.runs < len(jobs):
        jobs = [jobs[i * len(jobs) // args.runs] for i in range(args.runs)]
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    env_at = ",".join(f"{o:X}" for o in wanted)

    def run(job):
        index, (name, path, opts, mode) = job
        d = WORK / "runs" / f"{index:04d}"
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
        src = d / modtest.source_name(path)
        shutil.copy(path, src)
        env = dict(os.environ, EMU2_RECORD=str(d / "rec"), EMU2_RECORD_AT=env_at,
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
            for rec in re.findall(r"^CALL .*?^END\n", text, re.M | re.S):
                head, body = rec.split("\n", 1)
                name = wanted[int(head.split()[1], 16)]
                key = hashlib.sha1(body.encode()).hexdigest()
                if len(calls[name]) < args.max:
                    calls[name].setdefault(key, body)
    out = PORT / "records"
    out.mkdir(exist_ok=True)
    for name, found in calls.items():
        (out / f"{name}.rec").write_text("".join(
            f"CALL {offsets[name]:X} {i}\n{body}" for i, body in enumerate(found.values())))
        print(f"{name}: {len(found)} different calls from {len(jobs)} compiles -> records/{name}.rec")


if __name__ == "__main__":
    main()

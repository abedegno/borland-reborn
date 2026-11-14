"""Compare the native build (build/bcc) with BCC.EXE over the corpus (README.md, "Plan",
step 4): every compile step of every corpus test (-c and -S) runs in BCC.EXE under emu2 and
in build/bcc, each in its own staged directory (tools/record.py's staging), and the output
files (T.OBJ, T.ASM) and the console text must be the same.  The console's "Available
memory" figure comes from the heap and is left out of the comparison.

    python3 tools/nativetest.py [--runs N] [--only NAME] [--jobs J] [--keep]
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


def run_one(job, emu2, keep):
    index, (name, path, opts, mode) = job
    base = WORK / "runs" / f"{index:04d}"
    results = {}
    for side in ("orig", "port"):
        d = base / side
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        src = d / modtest.source_name(path)
        shutil.copy2(path, src)
        args = modtest.command(mode, opts, src.name)
        if side == "orig":
            (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
            cmd = [emu2, "BCC.EXE", *args]
        else:
            cmd = [str(PORT / "build" / "bcc"), *args]
        try:
            done = subprocess.run(cmd, cwd=d, capture_output=True, timeout=300)
            out, rc = done.stdout.decode("latin1") + done.stderr.decode("latin1"), done.returncode
        except subprocess.TimeoutExpired:
            out, rc = "TIMEOUT", -1
        files = {p.name.upper(): p.read_bytes() for p in d.iterdir()
                 if p.is_file() and p.suffix.upper() in (".OBJ", ".ASM")}
        results[side] = (console(out), rc, files)
    o, p = results["orig"], results["port"]
    problems = []
    if o[0] != p[0]:
        problems.append(f"console differs:\n--- BCC.EXE\n{o[0]}\n--- port\n{p[0]}")
    if o[1] != p[1]:
        problems.append(f"exit status {o[1]} (BCC.EXE) and {p[1]} (port)")
    for f in sorted(set(o[2]) | set(p[2])):
        if f not in o[2] or f not in p[2]:
            problems.append(f"{f} written only by {'the port' if f in p[2] else 'BCC.EXE'}")
        elif o[2][f] != p[2][f]:
            a, b = o[2][f], p[2][f]
            at = next((i for i in range(min(len(a), len(b))) if a[i] != b[i]), min(len(a), len(b)))
            problems.append(f"{f} differs at byte {at:#x} (sizes {len(a)} and {len(b)})")
    if not keep and not problems:
        shutil.rmtree(base)
    return name, mode, problems


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--runs", type=int, default=0)
    ap.add_argument("--only")
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--keep", action="store_true", help="keep the directories of every run")
    ap.add_argument("--emu2", default=str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2"))
    args = ap.parse_args()
    jobs = [(name, path, opts, mode) for name, path, opts, steps in modtest.corpus()
            for modes in steps for mode in modes if mode in ("-c", "-S")]
    if args.only:
        jobs = [j for j in jobs if j[0] == args.only]
    if args.runs and args.runs < len(jobs):
        jobs = [jobs[i * len(jobs) // args.runs] for i in range(args.runs)]
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    same = 0
    failed = []
    with ThreadPoolExecutor(args.jobs) as pool:
        for name, mode, problems in pool.map(lambda j: run_one(j, args.emu2, args.keep), enumerate(jobs)):
            if problems:
                failed.append(name)
                print(f"{name} {mode}: " + "\n  ".join(problems))
            else:
                same += 1
    print(f"{same} of {len(jobs)} compiles the same as BCC.EXE")
    if not failed:
        shutil.rmtree(WORK, ignore_errors=True)
    else:
        print(f"run directories of the differing compiles: {WORK / 'runs'}")
    return 0 if not failed else 1


if __name__ == "__main__":
    sys.exit(main())

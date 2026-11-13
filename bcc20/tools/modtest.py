"""Check a modding build of BCC.EXE against Borland's: both compile the same files with the
same switches, and every output must be identical.

    python3 tools/modtest.py [EXE] [NAME ...] [--jobs N]
                                default build-source/MODLINK/run/BCC.EXE; NAMEs limit the
                                run to those sources; N compiles at once (default: CPUs)

The corpus is the project's own C sources (each with the switches its /* opts: */ line
gives, as object code and with -S as assembly) plus the C++ tests in tests/modbuild/.
The runs go through emu2 (Exhume's tools/emu2, built by tools/setup-emu2.sh), one compile
per process, each in its own scratch directory under build-source/MODTEST/runs (kept when
the compilers differ).  A compile that crashes or
hangs in one compiler and not the other counts as a difference.
"""
import os
import re
import shutil
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXHUME = next(p for p in (ROOT / "exhume", ROOT.parent / "exhume") if (p / "tools").is_dir())
EMU2 = EXHUME / "tools" / "emu2" / "emu2"
WORK = ROOT / "build-source" / "MODTEST"
ORIGINAL = ROOT / "toolchain" / "BC20" / "BIN" / "BCC.EXE"
STAMP = 671371200  # 1991-04-23 12:00 UTC, the date of Borland's BCC.EXE


def corpus():
    """(name, file, switches) for every test compile."""
    out = []
    for path in sorted((ROOT / "src").rglob("*.C")):
        head = path.read_bytes()[:4000].decode("latin1")
        if re.search(r"compiler:\s*TC201", head):
            continue  # built by Turbo C 2.01, not BCC
        opts = re.search(r"opts:\s*([^*\n]*)", head).group(1).split()
        opts = [o for o in opts if not o.startswith("-T") and o != "-B"]  # -B, -T: TASM steps
        out.append((path.stem, path, opts))
    for path in sorted((ROOT / "tests" / "modbuild").glob("*.C*")):
        out.append((path.stem, path, ["-ml", "-O", "-G"]))
    return out


def run(exe, args, cwd, timeout=120):
    try:
        r = subprocess.run([str(EMU2), exe, *args], cwd=cwd, capture_output=True, timeout=timeout)
        return r.returncode, r.stdout
    except subprocess.TimeoutExpired:
        return "timeout", b""


def compare(job):
    """Compile one file with both compilers in its own directory; None if all is identical,
    else a line saying how they differ."""
    index, name, path, opts, mode = job
    d = WORK / "runs" / f"{index:04d}"
    d.mkdir(parents=True)
    for sub in ("INCLUDE", "PROJ"):
        (d / sub).symlink_to(WORK / sub, target_is_directory=True)
    src = "T" + path.suffix.upper()
    results = {}
    for exe in ("ORIG.EXE", "NEW.EXE"):
        for stale in d.iterdir():   # t.obj, t.asm: DOS writes lower case names
            if stale.stem.upper() == "T":
                stale.unlink()
        if not (d / exe).exists():
            (d / exe).symlink_to(WORK / exe)
        shutil.copy(path, d / src)
        # the object and the -S listing record the source's date and time: pin it
        os.utime(d / src, (STAMP, STAMP))
        code, text = run(exe, [mode, *opts, r"-IC:\INCLUDE;C:\PROJ", src], d)
        output = d / ("T.OBJ" if mode == "-c" else "T.ASM")
        # the console text names the compiler's free memory, which differs by design
        text = re.sub(rb"Available memory \d+", b"", text)
        results[exe] = (code, text, output.read_bytes() if output.exists() else None)
    if results["ORIG.EXE"] == results["NEW.EXE"]:
        shutil.rmtree(d)
        return None
    why = [f"{exe}: exit {r[0]}, {len(r[1])} chars of console, "
           f"{'no output' if r[2] is None else str(len(r[2])) + ' bytes'}"
           for exe, r in results.items()]
    return f"DIFFERS {name} {mode} {opts} | {'; '.join(why)}  (build-source/MODTEST/runs/{index:04d})"


def main():
    args = sys.argv[1:]
    jobs_n = os.cpu_count() or 4
    if "--jobs" in args:
        i = args.index("--jobs")
        jobs_n = int(args[i + 1])
        del args[i:i + 2]
    only = set(a for a in args if not a.upper().endswith(".EXE"))
    exes = [a for a in args if a.upper().endswith(".EXE")]
    new = Path(exes[0]) if exes else ROOT / "build-source" / "MODLINK" / "run" / "BCC.EXE"
    if not EMU2.exists():
        raise SystemExit("emu2 is missing: run sh exhume/tools/setup-emu2.sh")
    if WORK.exists():
        shutil.rmtree(WORK)
    WORK.mkdir(parents=True)
    shutil.copytree(ROOT / "toolchain" / "BC20" / "INCLUDE", WORK / "INCLUDE")
    shutil.copytree(ROOT / "src" / "include", WORK / "PROJ")
    shutil.copy(ORIGINAL, WORK / "ORIG.EXE")
    shutil.copy(new, WORK / "NEW.EXE")
    jobs = []
    for name, path, opts in corpus():
        if only and name not in only:
            continue
        for mode in ("-c", "-S"):
            jobs.append((len(jobs), name, path, opts, mode))
    differ = 0
    with ThreadPoolExecutor(jobs_n) as pool:
        for line in pool.map(compare, jobs):
            if line:
                differ += 1
                print(line, flush=True)
    print(f"{len(jobs) - differ}/{len(jobs)} compiles identical")
    if differ:
        raise SystemExit(1)


if __name__ == "__main__":
    main()

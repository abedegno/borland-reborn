"""Check a modding build of BCC.EXE against Borland's: both compile the same files with the
same switches, and every output must be identical.

    python3 tools/modtest.py [EXE] [NAME ...]   default build-source/MODLINK/run/BCC.EXE;
                                                NAMEs limit the run to those sources

The corpus is the project's own C sources (each with the switches its /* opts: */ line
gives, as object code and with -S as assembly) plus the C++ tests in tests/modbuild/.
The runs go through emu2 (Exhume's tools/emu2, built by tools/setup-emu2.sh), one compile
per process, in a scratch directory under build-source/MODTEST.  A compile that crashes or
hangs in one compiler and not the other counts as a difference.
"""
import os
import re
import shutil
import subprocess
import sys
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


def main():
    only = set(a for a in sys.argv[1:] if not a.upper().endswith(".EXE"))
    sys.argv = [sys.argv[0]] + [a for a in sys.argv[1:] if a.upper().endswith(".EXE")]
    new = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / "build-source" / "MODLINK" / "run" / "BCC.EXE"
    if not EMU2.exists():
        raise SystemExit("emu2 is missing: run sh exhume/tools/setup-emu2.sh")
    if WORK.exists():
        shutil.rmtree(WORK)
    WORK.mkdir(parents=True)
    shutil.copytree(ROOT / "toolchain" / "BC20" / "INCLUDE", WORK / "INCLUDE")
    shutil.copytree(ROOT / "src" / "include", WORK / "PROJ")
    shutil.copy(ORIGINAL, WORK / "ORIG.EXE")
    shutil.copy(new, WORK / "NEW.EXE")
    differ, total = [], 0
    for name, path, opts in corpus():
        if only and name not in only:
            continue
        for mode in ("-c", "-S"):
            total += 1
            results = {}
            for exe in ("ORIG.EXE", "NEW.EXE"):
                for stale in WORK.glob("T.*"):
                    stale.unlink()
                shutil.copy(path, WORK / ("T" + path.suffix.upper()))
                # the object and the -S listing record the source's date and time: pin it
                os.utime(WORK / ("T" + path.suffix.upper()), (STAMP, STAMP))
                code, text = run(exe, [mode, *opts, r"-IC:\INCLUDE;C:\PROJ", "T" + path.suffix.upper()], WORK)
                output = WORK / ("T.OBJ" if mode == "-c" else "T.ASM")
                # the console text names the compiler's free memory, which differs by design
                text = re.sub(rb"Available memory \d+", b"", text)
                results[exe] = (code, text, output.read_bytes() if output.exists() else None)
            if results["ORIG.EXE"] != results["NEW.EXE"]:
                differ.append(f"{name} {mode}")
                why = [f"{exe}: exit {r[0]}, {len(r[1])} chars of console, "
                       f"{'no output' if r[2] is None else str(len(r[2])) + ' bytes'}"
                       for exe, r in results.items()]
                print("DIFFERS", name, mode, opts, "|", "; ".join(why), flush=True)
    print(f"{total - len(differ)}/{total} compiles identical")
    if differ:
        raise SystemExit(1)


if __name__ == "__main__":
    main()

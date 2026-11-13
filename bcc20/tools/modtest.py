"""Check a modding build of BCC.EXE against Borland's: both compile the same files with the
same switches, and every output must be identical.

    python3 tools/modtest.py [EXE] [NAME ...] [--jobs N] [--work DIR]
                                default build-source/MODLINK/run/BCC.EXE; NAMEs limit the
                                run to those sources; N compiles at once (default: CPUs);
                                DIR for the runs (default build-source/MODTEST)

The corpus is the project's own C sources (each with the switches its /* opts: */ line
gives, as object code and with -S as assembly), Borland's own example programs and class
library where scripts/setup-toolchains.py installed them (tests/modbuild/BORLAND.TSV lists
them with their switches), files of GCC's and cfront's test suites where
tools/fetch-testsuites.py fetched them (tests/modbuild/EXTERNAL.TSV), and the tests in
tests/modbuild/.  A test
there gives its switches in its first lines, `/* modtest: SWITCHES */` (or `// modtest:` in
C++; default -ml -O -G), and may give its steps, `/* modes: STEP ... */`: each step is -c,
-S or `link` (no switch: BCC compiles and runs Borland's TLINK, which stops for want of the
C libraries) or `alone` (BCC with no arguments, which prints its usage text); the
default is -c and -S, each run on its own.  Several steps given together run one after the
other in the same directory, so a later step sees what an earlier one left (a precompiled
header file).
The runs go through emu2 (Exhume's tools/emu2, built by tools/setup-emu2.sh), one compile
per process, each in its own scratch directory under build-source/MODTEST/runs (kept when
the compilers differ: the line names it).  Everything a run leaves (the object or assembly file, a
precompiled header file) is compared, with its exit status and its console text; a precompiled
header file only by its size, since it holds BCC's own addresses (see settle).  A
compile that crashes or hangs in one compiler and not the other counts as a difference.
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


CPP_FILES = set()     # .C files of GCC and cfront: C++ by their convention


def source_name(path):
    """The name a test's source gets in its run directory: T.C or T.CPP."""
    return "T.CPP" if path in CPP_FILES else "T" + path.suffix.upper()


def corpus():
    """(name, file, switches, steps) for every test compile.  steps is a list of runs, each
    a list of modes run one after the other in one directory."""
    out = []
    for path in sorted((ROOT / "src").rglob("*.C")):
        head = path.read_bytes()[:4000].decode("latin1")
        if re.search(r"compiler:\s*TC201", head):
            continue  # built by Turbo C 2.01, not BCC
        opts = re.search(r"opts:\s*([^*\n]*)", head).group(1).split()
        opts = [o for o in opts if not o.startswith("-T") and o != "-B"]  # -B, -T: TASM steps
        out.append((path.stem, path, opts, [["-c"], ["-S"]]))
    # Borland's examples and class library, where setup-toolchains.py installed them
    bc20 = ROOT / "toolchain" / "BC20"
    for line in (ROOT / "tests" / "modbuild" / "BORLAND.TSV").read_text().splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        rel, switches, *steps = line.split("\t")
        path = bc20 / rel
        if path.exists():
            out.append((f"BC20:{rel}", path, switches.split(),
                        [steps[0].split()] if steps and steps[0].strip() else [["-c"], ["-S"]]))
    # files of outside test suites, where tools/fetch-testsuites.py fetched them
    for line in (ROOT / "tests" / "modbuild" / "EXTERNAL.TSV").read_text().splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        suite, rel, switches = line.split("\t")[:3]
        path = ROOT / "testsuites" / suite / rel
        if path.exists():
            if path.suffix == ".C":
                CPP_FILES.add(path)
            out.append((f"{suite}:{rel}", path, switches.split(), [["-c"], ["-S"]]))
    for path in sorted((ROOT / "tests" / "modbuild").glob("*.C*")):
        head = path.read_bytes()[:1000].decode("latin1")
        found = re.search(r"modtest:\s*([^*\n]*)", head)
        opts = found.group(1).split() if found else ["-ml", "-O", "-G"]
        modes = re.search(r"modes:\s*([^*\n]*)", head)
        steps = [modes.group(1).split()] if modes else [["-c"], ["-S"]]
        out.append((path.stem, path, opts, steps))
    return out


def run(exe, args, cwd, timeout=120):
    try:
        r = subprocess.run([str(EMU2), exe, *args], cwd=cwd, capture_output=True, timeout=timeout)
        return r.returncode, r.stdout
    except subprocess.TimeoutExpired:
        return "timeout", b""


def command(mode, opts, src):
    """BCC's arguments for one step: -c or -S, `link` (none: compile and link), or `alone`
    (BCC with no arguments at all, which prints its usage text).  C:\\SRC is the source's own
    folder and C:\\CLASSINC Borland's class library headers (stage)."""
    if mode == "alone":
        return []
    return [*([] if mode == "link" else [mode]), *opts, r"-IC:\SRC;C:\INCLUDE;C:\PROJ;C:\CLASSINC", src]


def headers(work):
    """Copy the compilers' headers to work/INCLUDE and the project's to work/PROJ.  DOS cuts a
    name to 8.3 when it opens a file and emu2 does not, so <strstream.h> (STRSTREA.H on the
    disks) gets a copy under its long name."""
    shutil.copytree(ROOT / "toolchain" / "BC20" / "INCLUDE", work / "INCLUDE")
    shutil.copytree(ROOT / "src" / "include", work / "PROJ")
    if (work / "INCLUDE" / "STRSTREA.H").exists():
        shutil.copy(work / "INCLUDE" / "STRSTREA.H", work / "INCLUDE" / "STRSTREAM.H")


def stage(d, path, work):
    """Link a run directory to what its compiles read: the headers, the source's folder (for
    its own headers) and the class library's headers."""
    links = {"INCLUDE": work / "INCLUDE", "PROJ": work / "PROJ", "SRC": path.parent,
             "CLASSINC": ROOT / "toolchain" / "BC20" / "CLASSLIB" / "INCLUDE"}
    for name, target in links.items():
        if target.is_dir() and not (d / name).exists():
            (d / name).symlink_to(target.resolve(), target_is_directory=True)


def settle(name, data):
    """A precompiled header file (TCDEF.SYM) is BCC's tables as they are in memory: they hold
    near addresses of BCC's own data, which move with the layout, and bytes never written
    (MACRO_DEFINE, MACROS.C, pads each macro to an even size without filling the pad).  So
    only its size is compared; what is in it is checked by a later step that reads it."""
    if name.endswith(".SYM"):
        return f"{len(data)} bytes, not compared".encode()
    return data


def compare(job):
    """Compile one file with both compilers in its own directory; None if all is identical,
    else a line saying how they differ."""
    index, name, path, opts, modes = job
    d = WORK / "runs" / f"{index:04d}"
    d.mkdir(parents=True)
    keep = {"INCLUDE", "PROJ", "SRC", "CLASSINC", "ORIG.EXE", "NEW.EXE", "TLINK.EXE"}
    stage(d, path, WORK)
    # BCC runs TLINK for a test that links: it finds it here, and stops for want of the
    # libraries, so both compilers run the same program the same way
    (d / "TLINK.EXE").symlink_to(WORK / "TLINK.EXE")
    src = source_name(path)
    results = {}
    for exe in ("ORIG.EXE", "NEW.EXE"):
        for stale in d.iterdir():   # all the other compiler left (DOS writes lower case names)
            if stale.name.upper() not in keep:
                stale.unlink()
        if not (d / exe).exists():
            (d / exe).symlink_to(WORK / exe)
        shutil.copy(path, d / src)
        # the object and the -S listing record the source's date and time: pin it
        os.utime(d / src, (STAMP, STAMP))
        steps = []
        for mode in modes:
            code, text = run(exe, command(mode, opts, src), d)
            # the console text names the compiler's free memory, which differs by design
            text = re.sub(rb"Available memory \d+", b"", text)
            text = text.replace(exe.encode(), b"BCC.EXE")
            files = {f.name.upper(): settle(f.name.upper(), f.read_bytes()) for f in sorted(d.iterdir())
                     if f.name.upper() not in keep and f.name.upper() != src and f.is_file()}
            steps.append((code, text, files))
        results[exe] = steps
    if results["ORIG.EXE"] == results["NEW.EXE"]:
        shutil.rmtree(d)
        return None
    why = []
    for exe, steps in results.items():
        code, text, files = steps[-1]
        why.append(f"{exe}: exit {code}, {len(text)} chars of console, "
                   + (", ".join(f"{n} {len(b)} bytes" for n, b in files.items()) or "no output"))
    return f"DIFFERS {name} {' '.join(modes)} {opts} | {'; '.join(why)}  ({d})"


def main():
    args = sys.argv[1:]
    jobs_n = os.cpu_count() or 4
    if "--jobs" in args:
        i = args.index("--jobs")
        jobs_n = int(args[i + 1])
        del args[i:i + 2]
    global WORK
    if "--work" in args:    # to run several builds' tests at once
        i = args.index("--work")
        WORK = Path(args[i + 1]).resolve()
        del args[i:i + 2]
    only = set(a for a in args if not a.upper().endswith(".EXE"))
    exes = [a for a in args if a.upper().endswith(".EXE")]
    new = Path(exes[0]) if exes else ROOT / "build-source" / "MODLINK" / "run" / "BCC.EXE"
    if not EMU2.exists():
        raise SystemExit("emu2 is missing: run sh exhume/tools/setup-emu2.sh")
    if WORK.exists():
        shutil.rmtree(WORK)
    WORK.mkdir(parents=True)
    headers(WORK)
    shutil.copy(ORIGINAL, WORK / "ORIG.EXE")
    shutil.copy(ORIGINAL.parent / "TLINK.EXE", WORK / "TLINK.EXE")
    shutil.copy(new, WORK / "NEW.EXE")
    jobs = []
    for name, path, opts, steps in corpus():
        if only and name not in only:
            continue
        for modes in steps:
            jobs.append((len(jobs), name, path, opts, modes))
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

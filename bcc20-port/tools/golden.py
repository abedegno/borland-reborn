"""Golden outputs: what BCC.EXE writes for the corpus sources that need no Borland header, so
that the native build and the library can be checked where BCC.EXE and the Borland
toolchain are not available (CI, a fresh clone).

    python3 tools/golden.py make      # with BCC.EXE and the tracing emu2: (re)writes tests/golden/
    python3 tools/golden.py check     # build/bcc and build/bcc20run against tests/golden/

The cases are the port's tests and ../bcc20's own sources that include no <...> header (the
project headers they use, ../bcc20/src/include, are in the repository): -c for all, -S too
for the port's tests; link steps are left out (they need TLINK). Each runs in a fresh
directory staged as tools/nativetest.py does, with an empty INCLUDE, the source's time
and its headers' times
pinned and the time zone UTC (object files record the files' local times), and
BCC_EMU2_FIND set, as the reference was made in emu2.
check runs each case in build/bcc and, through the library, twice in one process in
build/bcc20run, and compares the files written, the exit status and the console text (the
"Available memory" line left out).  The golden files are BCC.EXE's output (see ../NOTICE.md).
"""
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]
BCC20 = PORT.parent / "bcc20"
GOLDEN = PORT / "tests" / "golden"
STAMP = 946684800            # 2000-01-01 00:00 UTC, the sources' time in every run
INCLUDES = r"-IC:\SRC;C:\INCLUDE;C:\PROJ"


def opts_of(path):
    head = path.read_bytes()[:4000].decode("latin1")
    if path.parent == PORT / "tests":
        found = re.search(r"modtest:\s*([^*\n]*)", head)
        modes = re.search(r"modes:\s*([^*\n]*)", head)
        return (found.group(1).split() if found else ["-ml", "-O", "-G"],
                modes.group(1).split() if modes else ["-c", "-S"])
    if re.search(r"compiler:\s*TC201", head):
        return None
    found = re.search(r"opts:\s*([^*\n]*)", head)
    if not found:
        return None
    return [o for o in found.group(1).split() if not o.startswith("-T") and o != "-B"], ["-c"]


def cases():
    """(name, source, switches, modes) of every golden case"""
    out = []
    for path in sorted(p for p in (PORT / "tests").iterdir() if p.suffix.upper() in (".C", ".CPP")):
        out.append(path)
    out += sorted((BCC20 / "src").rglob("*.C"))
    found = []
    for path in out:
        if re.search(rb"#include[ \t]*<", path.read_bytes()):
            continue
        spec = opts_of(path)
        if not spec:
            continue
        opts, modes = spec
        if "link" in modes:
            continue
        name = ("port-" if path.parent == PORT / "tests" else "bcc20-") + path.stem + \
               ("-cpp" if path.suffix.upper() == ".CPP" else "")
        found.append((name, path, opts, modes))
    return found


def stage(d, path):
    """the run directory: the source as T.C or T.CPP, C:\\SRC its folder, an empty INCLUDE,
    C:\\PROJ ../bcc20's project headers"""
    (d / "INCLUDE").mkdir()
    shutil.copytree(path.parent, d / "SRC", ignore=shutil.ignore_patterns("*.OBJ", "*.obj"))
    shutil.copytree(BCC20 / "src" / "include", d / "PROJ")
    src = d / ("T.CPP" if path.suffix.upper() == ".CPP" else "T.C")
    shutil.copy(path, src)
    # objects record the time of the source and of every header it reads: pin them all, as a
    # checkout gives files its own time
    for f in [src, *d.rglob("*")]:
        if f.is_file():
            os.utime(f, (STAMP, STAMP))
    cfg = path.with_suffix(".CFG")
    if path.parent == PORT / "tests" and cfg.exists():
        shutil.copy(cfg, d / "TURBOC.CFG")
    return src


def console(text):
    return "\n".join(l for l in text.replace("\r\n", "\n").split("\n") if "Available memory" not in l).strip()


def outputs(d, before):
    return {p.name.upper(): p.read_bytes() for p in d.iterdir()
            if p.is_file() and p.name not in before and p.suffix.upper() in (".OBJ", ".ASM")}


def run(cmd, d, env):
    try:
        done = subprocess.run(cmd, cwd=d, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=120, env=env)
        return console(done.stdout.decode("latin1")), done.returncode
    except subprocess.TimeoutExpired:
        return "TIMEOUT", -1


def make():
    sys.path.insert(0, str(PORT / "tools"))
    import record
    emu2 = str(record.modtest.EXHUME / "tools" / "emu2-trace" / "emu2")
    exe = record.modtest.ORIGINAL
    shutil.rmtree(GOLDEN, ignore_errors=True)
    GOLDEN.mkdir(parents=True)
    index = {}
    for name, path, opts, modes in cases():
        for mode in modes:
            with tempfile.TemporaryDirectory() as tmp:
                d = Path(tmp)
                src = stage(d, path)
                (d / "BCC.EXE").symlink_to(exe)
                before = {p.name for p in d.iterdir()}
                text, status = run([emu2, "BCC.EXE", mode, *opts, INCLUDES, src.name], d,
                                   dict(os.environ, TZ="UTC0"))
                files = outputs(d, before)
            case = f"{name}{mode}"
            for fname, data in files.items():
                (GOLDEN / f"{case}.{fname.split('.')[-1]}").write_bytes(data)
            index[case] = {"source": str(path.relative_to(PORT.parent)), "args": [mode, *opts, INCLUDES, src.name],
                           "status": status, "console": text, "files": sorted(files)}
    (GOLDEN / "index.json").write_text(json.dumps(index, indent=1, sort_keys=True) + "\n")
    print(f"tests/golden: {len(index)} cases")


def check():
    index = json.loads((GOLDEN / "index.json").read_text())
    bcc, run_lib = PORT / "build" / ("bcc.exe" if os.name == "nt" else "bcc"), PORT / "build" / ("bcc20run.exe" if os.name == "nt" else "bcc20run")
    env = dict(os.environ, BCC_EMU2_FIND="1", TZ="UTC0")
    failures = 0
    for case, want in sorted(index.items()):
        path = PORT.parent / want["source"]
        for side in ("native", "library"):
            with tempfile.TemporaryDirectory() as tmp:
                d = Path(tmp)
                src = stage(d, path)
                before = {p.name for p in d.iterdir()}
                if side == "native":
                    cmd = [str(bcc), *want["args"]]
                else:
                    cmd = [str(run_lib), "--file", f"{src.name}={src.name}", "--root", ".", "--time", str(STAMP),
                           "--repeat", "2", "--", *want["args"]]
                text, status = run(cmd, d, env)
                files = outputs(d, before)
            problems = []
            if status != want["status"]:
                problems.append(f"exit status {status}, BCC.EXE {want['status']}")
            if text != want["console"]:
                problems.append(f"console differs:\n--- BCC.EXE\n{want['console']}\n--- {side}\n{text}")
            if sorted(files) != want["files"]:
                problems.append(f"wrote {sorted(files)}, BCC.EXE {want['files']}")
            for fname in want["files"]:
                golden = (GOLDEN / f"{case}.{fname.split('.')[-1]}").read_bytes()
                if fname in files and files[fname] != golden:
                    problems.append(f"{fname} differs from BCC.EXE's")
            if problems:
                failures += 1
                print(f"{case} ({side}): " + "\n  ".join(problems))
    total = 2 * len(index)
    print(f"{total - failures} of {total} runs the same as BCC.EXE ({len(index)} cases, native and library)")
    return 1 if failures else 0


if __name__ == "__main__":
    if sys.argv[1:2] == ["make"]:
        make()
    elif sys.argv[1:2] == ["check"]:
        sys.exit(check())
    else:
        print(__doc__)
        sys.exit(2)

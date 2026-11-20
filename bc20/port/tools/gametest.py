r"""A game's own build as a test: every C module a Borland MAKE makefile compiles, in BCC.EXE
under emu2 and in the native build, with the object files and console text compared.

    python3 tools/gametest.py GAME/BUILD/MAKEFILE [--game GAME] [--only NAME ...] [--keep DIR]

The game's tree (by default the makefile's grandparent) is copied twice under a scratch
directory standing for drive C:, with Borland's headers as C:\BC\INCLUDE ($(BC) in the
makefile).  Configuration files the makefile writes inline (copy &&| ... | NAME.CFG) are
written out; each rule's compiles run in its directory (a "cd" line is followed), with TASM
beside them for -B compiles, and the native build gets BCC_ROOT and BCC_DOS_RUNNER so that
it sees the same drive.  Assembly rules are left out.  The game's sources are the user's
own clone and are never committed.  First used on Ultima 7 (Kitrinx/Ultima7_Decomp): all
922 C compiles of Black Gate and Serpent Isle the same.
"""
import argparse
import concurrent.futures
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PORT / "tools"))
import record                                                   # noqa: E402

BC20 = record.modtest.ORIGINAL.parents[1]                       # toolchain/BC20
EMU2 = record.modtest.EXHUME / "tools" / "emu2-trace" / "emu2"
NATIVE = PORT / "build" / ("bcc.exe" if os.name == "nt" else "bcc")


def parse_makefile(text):
    """([(object stem, build directory relative to the makefile's, bcc arguments)],
    {config file name: text}) for every C rule of a Borland MAKE makefile"""
    text = text.replace("\\\n", " ")
    configs = {m.group(1): m.group(2) for m in re.finditer(r"^(\S+\.CFG):.*\n\tcopy &&\|\n(.*?)\n\|\s*\1", text, re.M | re.S)}
    groups = {m.group(1): m.group(2).split() for m in re.finditer(r"^(\w+)\s*=\s*(.*)$", text, re.M)}
    compilers = {k: " ".join(v) for k, v in groups.items() if v and v[0].lower().endswith("\\bcc")}
    jobs = []
    for m in re.finditer(r"^\$\((\w+)\):\s*\n((?:\t.*\n)+)", text, re.M):
        name, body = m.group(1), m.group(2)
        objs = [o[:-4] for o in groups.get(name, []) if o.lower().endswith(".obj")]
        cd, cmd = ".", None
        for l in (l.strip() for l in body.splitlines()):
            for k, v in compilers.items():
                l = l.replace(f"$({k})", v)
            if l.startswith("cd ") and cmd is None:
                cd = l[3:].strip().replace("\\", "/")
            elif l.split() and l.split()[0].lower().endswith("bcc"):
                cmd = l
        if cmd:
            for stem in objs:
                jobs.append((stem, cd, cmd.replace("$&", stem).split()[1:]))
    return jobs, configs


def stage(root, game):
    shutil.copytree(game, root / "G", ignore=shutil.ignore_patterns("*.OBJ", "*.obj", "*.EXE", ".git"))
    shutil.copytree(BC20 / "INCLUDE", root / "BC" / "INCLUDE")


def run(cmd, cwd, env):
    try:
        done = subprocess.run(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=300, env=env)
        out = done.stdout.decode("latin1").replace("\r\n", "\n")
        return "\n".join(l for l in out.split("\n") if "Available memory" not in l).strip(), done.returncode
    except subprocess.TimeoutExpired:
        return "TIMEOUT", -1


def compile_one(root, build, side, stem, cd, words):
    main = root / "G" / build
    cwd = (main / cd).resolve()
    args = [w.replace("$(BC)", "C:\\BC") for w in words]     # the makefile's absolute form
    env = dict(os.environ, TZ="UTC0")
    if side == "emu2":
        exe = root / "BCC.EXE"
        cmd = [str(EMU2), str(exe), *args]
        env.update(EMU2_DRIVE_C=str(root), EMU2_CWD="C:\\" + str(cwd.relative_to(root)).replace("/", "\\"))
    else:
        cmd = [str(NATIVE), *args]
        env.update(BCC_EMU2_FIND="1", BCC_DOS_RUNNER=str(EMU2), BCC_ROOT=str(root))
    out = [w[2:] for w in args if w.startswith("-n")]
    outdir = (cwd / out[-1].replace("\\", "/")).resolve() if out else cwd
    obj = outdir / f"{stem.upper()}.OBJ"
    for p in outdir.glob("*"):
        if p.name.upper() == obj.name:
            p.unlink()
    text, status = run(cmd, cwd, env)
    found = [p for p in outdir.glob("*") if p.name.upper() == obj.name]
    return text, status, found[0].read_bytes() if found else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("makefile", help="a MAKEFILE inside the game's tree")
    ap.add_argument("--game", help="the tree to stage (default: the makefile's grandparent)")
    ap.add_argument("--only", nargs="*")
    ap.add_argument("--jobs", type=int, default=os.cpu_count())
    ap.add_argument("--keep", help="stage here and keep it (default: build/gametest, removed after)")
    a = ap.parse_args()
    mk = Path(a.makefile).resolve()
    game = Path(a.game).resolve() if a.game else mk.parent.parent
    build = mk.parent.relative_to(game)
    jobs, configs = parse_makefile(mk.read_text(errors="replace"))
    if a.only:
        jobs = [j for j in jobs if j[0] in a.only]
    tmp = Path(a.keep).resolve() if a.keep else PORT / "build" / f"gametest-{os.getpid()}"
    roots = {}
    for side in ("emu2", "native"):
        r = tmp / side
        shutil.rmtree(r, ignore_errors=True)
        r.mkdir(parents=True)
        stage(r, game)
        for name, body in configs.items():
            (r / "G" / build / name).write_bytes(body.replace("$(BC)", "C:\\BC").replace("\n", "\r\n").encode() + b"\r\n")
        (r / "BCC.EXE").symlink_to(BC20 / "BIN" / "BCC.EXE")
        for d in {(r / "G" / build / j[1]).resolve() for j in jobs}:   # -B compiles run TASM
            if not (d / "TASM.EXE").exists():
                (d / "TASM.EXE").symlink_to(BC20 / "BIN" / "TASM.EXE")
        roots[side] = r
    print(f"{len(jobs)} C modules; staged in {tmp}")
    results = {}
    with concurrent.futures.ThreadPoolExecutor(a.jobs) as pool:
        futs = {pool.submit(compile_one, roots[side], build, side, *job): (job[0], side) for job in jobs for side in roots}
        for f in concurrent.futures.as_completed(futs):
            results[futs[f]] = f.result()
    same = bad = 0
    for stem, cd, words in jobs:
        e, n = results[(stem, "emu2")], results[(stem, "native")]
        problems = []
        if e[1] != n[1]:
            problems.append(f"status {n[1]} vs BCC.EXE {e[1]}")
        # emu2 prints BCC.EXE's own text after a child's (TASM, for -B): then any order
        child = "Turbo Assembler" in e[0]
        lines = lambda t: sorted(l for l in t.split("\n") if l.strip())
        if (lines(e[0]) != lines(n[0])) if child else e[0] != n[0]:
            problems.append(f"console:\n--- BCC.EXE\n{e[0]}\n--- native\n{n[0]}")
        if e[2] is None:
            problems.append("BCC.EXE wrote no object")
        if (e[2] is None) != (n[2] is None) or (e[2] is not None and e[2] != n[2]):
            problems.append("object differs" if e[2] and n[2] else f"object written: BCC.EXE {e[2] is not None}, native {n[2] is not None}")
        if problems:
            bad += 1
            print(f"{stem} ({cd} {' '.join(words)}): " + "\n  ".join(problems))
        else:
            same += 1
    print(f"{same} of {len(jobs)} the same (objects and console)")
    if not a.keep:
        shutil.rmtree(tmp)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())

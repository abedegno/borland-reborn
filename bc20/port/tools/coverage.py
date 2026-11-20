"""Which functions BCC.EXE runs at all over the corpus: for the functions `make check` lists
as not reached, whether BCC.EXE ever executes their first instruction (the tracing emu2's
EMU2_TRACE coverage, by program-file offset).  RUNS: BCC.EXE runs it, but no call was
recorded (it encloses the overlay loads of a whole compile, or ends in a long jump or in
the program's exit), so only the native corpus checks it.  NEVER: the corpus never takes
that path (unreachable from the driver, or a path no test exercises yet).

    python3 tools/coverage.py [NAME ...]        (default: the names in build/check.txt)
"""
import os
import re
import shutil
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import record   # noqa: E402

modtest = record.modtest
PORT = Path(__file__).resolve().parents[1]
WORK = PORT / "build" / f"coverage-{os.getpid()}"


def main():
    names = sys.argv[1:]
    if not names:
        text = (PORT / "build" / "check.txt").read_text()
        names = re.search(r"not checked:(.*)", text).group(1).split()
    offsets = record.function_offsets()
    want = {offsets[n]: n for n in names}
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    shutil.copy(modtest.ORIGINAL.parent / "TLINK.EXE", WORK / "TLINK.EXE")
    emu2 = str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2")

    def run(job):
        index, (name, path, opts, modes) = job
        d = WORK / "runs" / f"{index:04d}"
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
        (d / "TLINK.EXE").symlink_to(WORK / "TLINK.EXE")
        src = d / modtest.source_name(path)
        shutil.copy(path, src)
        record.stage_config(d, path)
        hit = set()
        for mode in modes:
            for f in d.glob("cov.*"):
                f.unlink()
            try:
                subprocess.run([emu2, "BCC.EXE", *modtest.command(mode, opts, src.name)], cwd=d,
                               env=dict(os.environ, EMU2_TRACE=str(d / "cov")),
                               capture_output=True, timeout=300)
            except subprocess.TimeoutExpired:
                pass
            for f in d.glob("cov.*"):
                for m in re.finditer(r"^E ([0-9A-Fa-f]+)", f.read_text(errors="replace"), re.M):
                    if int(m.group(1), 16) in want:
                        hit.add(want[int(m.group(1), 16)])
        shutil.rmtree(d)
        return name, hit

    first = {}
    with ThreadPoolExecutor(os.cpu_count() or 4) as pool:
        for name, hit in pool.map(run, enumerate(record.corpus_steps())):
            for h in hit:
                first.setdefault(h, name)
    for n in sorted(names, key=lambda n: (n not in first, n)):
        print(f"RUNS   {n}  (first in {first[n]})" if n in first else f"NEVER  {n}")
    shutil.rmtree(WORK, ignore_errors=True)


if __name__ == "__main__":
    main()

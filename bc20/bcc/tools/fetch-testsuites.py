"""Fetch the outside test suites the modding build's tests compile, at pinned versions.

    python3 tools/fetch-testsuites.py

Downloads into testsuites/ (git ignores it), only the folders used:

- gcc: GCC's gcc.c-torture (small C programs, compile-only and run tests) and g++.old-deja
  (the g++ tests of the 1990s, written against the ARM-era C++ that Borland C++ 2.0
  implements), from the GCC 13.2.0 release tag of the GitHub mirror; old-deja has hardly
  changed since the 1990s.  GPL: they are compiler input here, never committed.
- cfront: the demos and libraries of AT&T's cfront 3.0.3 (seyko2/cfront-3, no licence given:
  AT&T's code, kept for historical research).

tests/modbuild/EXTERNAL.TSV lists the files tools/modtest.py compiles from them: the ones
that reach code of BCC.EXE the rest of the corpus does not, chosen by tracing Borland's
compiler over every file.  Needs git.
"""
import shutil
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / "testsuites"
SUITES = {
    "gcc": ("https://github.com/gcc-mirror/gcc", "refs/tags/releases/gcc-13.2.0",
            "c891d8dc23e1a46ad9f3e757d09e57b500d40044",
            ["/gcc/testsuite/gcc.c-torture/", "/gcc/testsuite/g++.old-deja/"]),
    "cfront": ("https://github.com/seyko2/cfront-3", "e2cb662de6f0eb312759aac8ac48dd8c5d7c623b",
               "e2cb662de6f0eb312759aac8ac48dd8c5d7c623b",
               ["/demo/", "/lib/complex/", "/lib/generic/", "/lib/stream/", "/lib/string/", "/lib/task/"]),
}


def git(cwd, *args):
    r = subprocess.run(["git", *args], cwd=cwd, capture_output=True, text=True)
    if r.returncode:
        raise SystemExit(f"git {' '.join(args)}: {r.stderr.strip()}")
    return r.stdout.strip()


def fetch(name, url, ref, commit, paths):
    d = DEST / name
    if (d / ".git").exists() and git(d, "rev-parse", "HEAD") == commit:
        print(f"{name}: already at {commit[:10]}")
        return
    shutil.rmtree(d, ignore_errors=True)
    d.mkdir(parents=True)
    git(d, "init", "-q")
    git(d, "remote", "add", "origin", url)
    git(d, "fetch", "-q", "--depth", "1", "--filter=blob:none", "origin", ref)
    git(d, "sparse-checkout", "set", "--no-cone", *paths)
    git(d, "checkout", "-q", "FETCH_HEAD")
    got = git(d, "rev-parse", "HEAD")
    if got != commit:
        raise SystemExit(f"{name}: expected commit {commit}, got {got}")
    print(f"{name}: {commit[:10]}, {sum(1 for _ in d.rglob('*') if _.is_file())} files")


def main():
    for name, spec in SUITES.items():
        fetch(name, *spec)


if __name__ == "__main__":
    main()

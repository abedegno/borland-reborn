"""Build GREP.COM from src/GREP.ASM with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. Borland C++ 2.0's TASM 2.51 assembles src/GREP.ASM (one pass, its default).
2. Borland C++ 2.0's TLINK 4.0 links it as a .COM (/t).
3. SHA-256 of build/out/GREP.COM against the original, toolchains/BC20/BIN/GREP.COM. Exit
   status 0 when they are identical."""
import hashlib, os, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
TC = os.path.join(R, '..', '..', 'toolchains')
EXHUME = os.path.join(R, '..', '..', 'exhume')
B = os.path.join(R, 'build')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'GREP.COM')
ORIGINAL_SHA = 'a4c9faa6988bc6fd59abd367bfee501a4aad525549a77c2e534887d4bb0f0e43'


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '120',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(R, 'src', 'GREP.ASM'),
           '-c', 'TASM GREP.ASM', '-c', 'TLINK /t GREP', '-o', 'GREP.COM', '-o', 'GREP.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'GREP.COM')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('bc20/grep: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'GREP.COM: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'GREP.COM: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

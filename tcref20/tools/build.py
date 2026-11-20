"""Build TCREF.EXE from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. Borland C++ 2.0's TASM 2.51 assembles each module (/ml: case-sensitive names).
2. Turbo C 2.01's TLINK 2.0 links them, MAIN first: its EXE header and the order of the
   relocations (module by module) are TCREF.EXE's.
3. SHA-256 of build/out/TCREF.EXE against the original, toolchains/BC20/BIN/TCREF.EXE. Exit
   status 0 when they are identical."""
import hashlib, os, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
TC = os.path.join(R, '..', 'toolchains')
EXHUME = os.path.join(R, '..', 'exhume')
B = os.path.join(R, 'build')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TCREF.EXE')
ORIGINAL_SHA = '78570a175e80662ebd73f378ba0e6e0c3594efad26496f57f3ad10603db2ad08'
MODULES = ['MAIN', 'REPORT', 'CREF', 'DOSIO']


def main():
    for need in (ORIGINAL, os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE')):
        if not os.path.exists(need):
            sys.exit(f'no {need}: run scripts/setup-toolchains.py with --bc20 and --tc201 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '120',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'), '-f', os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE')]
    for m in MODULES:
        cmd += ['-f', os.path.join(R, 'src', m + '.ASM'), '-c', f'TASM /ml {m}.ASM']
    cmd += ['-c', 'TLINK /m ' + ' '.join(MODULES) + ',TCREF,TCREF', '-o', 'TCREF.EXE', '-o', 'TCREF.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'TCREF.EXE')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('tcref20: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'TCREF.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'TCREF.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

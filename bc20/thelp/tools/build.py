"""Build THELP.COM from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. Borland C++ 2.0's TASM 2.51 assembles each of the three files (one pass, its default).
2. Borland C++ 2.0's TLINK 4.0 links them as a .COM (/t), in the order of their code in
   THELP.COM: the TesSeRact kernel (TESS), THELP itself, then TesSeRact's installer
   (TSRINST).
3. SHA-256 of build/out/THELP.COM against the original, toolchains/BC20/BIN/THELP.COM. Exit
   status 0 when they are identical."""
import hashlib, os, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
TC = os.path.join(R, '..', '..', 'toolchains')
EXHUME = os.path.join(R, '..', '..', 'exhume')
B = os.path.join(R, 'build')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'THELP.COM')
ORIGINAL_SHA = 'f25591824c4416d10460c9ae49580dd3bc7ff93a51cd7fe45325ba6ccd484930'
FILES = ['TESS', 'THELP', 'TSRINST']


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '120',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE')]
    for f in FILES:
        cmd += ['-f', os.path.join(R, 'src', f + '.ASM'), '-c', 'TASM ' + f + '.ASM']
    cmd += ['-c', 'TLINK /t ' + ' '.join(FILES) + ',THELP', '-o', 'THELP.COM', '-o', 'THELP.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'THELP.COM')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('bc20/thelp: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'THELP.COM: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'THELP.COM: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

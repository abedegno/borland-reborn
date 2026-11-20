"""Build TASM.EXE (Turbo Assembler 2.51, Borland C++ 2.0) from src/ with the original tools,
then compare it with Borland's.

    python3 tools/build.py

1. TASM 2.51 assembles M1.ASM .. M7.ASM (/ml).
2. TLINK 2.0 (Turbo C 2.01's linker) links them in that order: TASM.EXE's header is TLINK
   2.0's (relocation table at 22h, version byte 20h), not TLINK 4.0's.
3. SHA-256 of build/link/out/TASM.EXE against toolchains/BC20/BIN/TASM.EXE. Exit status 0
   when they are identical."""
import hashlib, os, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
B = os.path.join(R, 'build', 'link')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE')
MODULES = ['M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7']


def main():
    if not os.path.exists(ORIGINAL) or not os.path.exists(os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE')):
        sys.exit('needs toolchains/BC20 and toolchains/TC201: run scripts/setup-toolchains.py (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cmd = ['node', os.path.join(rtl.EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '600',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE') + '=TASM251.EXE',
           '-f', os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE') + '=TLINK20.EXE']
    for m in MODULES:
        cmd += ['-f', os.path.join(R, 'src', m + '.ASM'), '-c', 'TASM251 /ml %s.ASM' % m]
    cmd += ['-c', 'TLINK20 %s,TASM,TASM' % ' '.join(MODULES), '-o', 'TASM.EXE', '-o', 'TASM.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    out = os.path.join(B, 'out', 'TASM.EXE')
    log = os.path.join(B, 'out', 'RUN.LOG')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('tasm20: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print('TASM.EXE: byte-identical to the original (SHA-256 %s)' % sha(out))
        return 0
    print('TASM.EXE: differs from the original (cmp %s %s)' % (out, ORIGINAL))
    return 1


if __name__ == '__main__':
    sys.exit(main())

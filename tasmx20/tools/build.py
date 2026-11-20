"""Build TASMX.EXE (Borland C++ 2.0's protected-mode Turbo Assembler) from src/ with the
original tools and our NE writer, then compare it with Borland's.

    python3 tools/build.py

1. TASM 2.51 assembles src/STUB.ASM and TLINK 4.0 links it: the DOS stub (it starts
   DPMILOAD.EXE, or TASM.EXE when there is no DPMI host).
2. TASM 2.51 assembles src/TASMX.ASM and TLINK 4.0 links it as a DOS program: the five
   segments of the protected-mode assembler, one after another.
3. tools/mz2ne.py writes the New Executable from the two, with the segments, entry point
   and names of tools/necfg.py. TLINK 4.0 can write NE files itself (/Twe), but not this
   layout: TASMX.EXE's header is what Microsoft's LINK 5.10 writes (the NE header at a
   512-byte boundary, the stub's size field ending at the NE tables, a checksum). The NE
   writer is our own; it is the one step of the build that is not Borland's or Microsoft's.
4. SHA-256 against toolchains/BC20/BIN/TASMX.EXE. Exit status 0 when identical."""
import hashlib, os, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
B = os.path.join(R, 'build', 'link')
BIN = os.path.join(TC, 'BC20', 'BIN')
ORIGINAL = os.path.join(BIN, 'TASMX.EXE')


def link(name):
    out = os.path.join(B, name)
    r = subprocess.run(['node', os.path.join(rtl.EXHUME, 'tools', 'dosrun.mjs'), out, '-t', '600',
                        '-f', os.path.join(BIN, 'TASM.EXE'), '-f', os.path.join(BIN, 'TLINK.EXE'),
                        '-f', os.path.join(R, 'src', name + '.ASM'),
                        '-c', 'TASM /ml %s.ASM' % name, '-c', 'TLINK %s,%s,%s' % (name, name, name),
                        '-o', name + '.EXE'], capture_output=True, text=True)
    exe = os.path.join(out, name + '.EXE')
    if not os.path.exists(exe):
        log = os.path.join(out, 'RUN.LOG')
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('tasmx20: building %s failed' % name)
    return exe


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    stub = link('STUB')
    prog = link('TASMX')
    out = os.path.join(B, 'TASMX.EXE')
    subprocess.run([sys.executable, os.path.join(R, 'tools', 'mz2ne.py'), os.path.join(R, 'tools', 'necfg.py'),
                    prog, stub, out], check=True)
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print('TASMX.EXE: byte-identical to the original (SHA-256 %s)' % hashlib.sha256(open(out, 'rb').read()).hexdigest())
        return 0
    print('TASMX.EXE: differs from the original (cmp %s %s)' % (out, ORIGINAL))
    return 1


if __name__ == '__main__':
    sys.exit(main())

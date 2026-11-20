"""Build EMSTEST.COM (Borland C++ 2.0's expanded-memory test) from src/EMSTEST.PAS, then compare
it with Borland's.

    python3 tools/build.py

EMSTEST.COM is a Turbo Pascal 3 program, and no released Turbo Pascal 3 has its runtime: it is
TP 3.02A's without a 14-byte window check in the cursor routine at 215h. So:

1. tools/mkturbo.py makes a patched TP 3.02A (toolchains/TP302A/TURBO.COM): the compiler's
   constants for where a program starts, and the runtime addresses it emits calls to
   (tools/compiler.tsv), lowered by 14; and the runtime EMSTEST.COM carries, TP 3.02A's with
   tools/rt302.tsv applied.
2. The patched compiler compiles src/EMSTEST.PAS in emu2, driven by keystrokes through a
   pseudo-terminal (TP3 has no command-line compiler): compiler options Com-file and
   "mAximum free dynamic memory" 1000h.
3. The runtime the compiler wrote (its own copy, cut to 2C3Fh bytes) is replaced by the patched
   runtime, and the two words of the parameter block that record where the compiler was loaded
   when Borland built the program (47C9h, 518Ch at 2C44h) are set: they come from the machine
   that built it, not from the source.
4. SHA-256 against toolchains/BC20/BIN/EMSTEST.COM. Exit status 0 when identical.

Steps 1 and 3 are the native differences of this build; ../NOTES.md has the evidence."""
import hashlib, os, shutil, struct, subprocess, sys, time

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
TC = os.path.join(R, '..', 'toolchains')
B = os.path.join(R, 'build')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'EMSTEST.COM')
TP = os.path.join(TC, 'TP302A')
LOAD_WORDS = (0x47C9, 0x518C)   # parameter block words 2C44h, 2C46h of Borland's build


def emu2():
    for p in (os.environ.get('EMU2', ''), os.path.join(R, '..', 'exhume', 'tools', 'emu2', 'emu2'),
              os.path.expanduser('~/Exhume/tools/emu2/emu2')):
        if p and os.path.exists(p):
            return p
    sys.exit('no emu2: build it with exhume/tools/setup-emu2.sh, or set EMU2')


def compile_tp3(work, name):
    """compile NAME.PAS in WORK with the TURBO.COM there; TP3's menus, typed through a pty"""
    keys = [(1, 'N'), (1, 'O'), (0.4, 'C'), (0.4, 'A1000\r'), (0.6, 'Q'), (0.4, 'M'), (0.4, name + '\r'),
            (0.4, 'C'), (8, ' '), (0.5, 'Q'), (1.5, '')]
    p = subprocess.Popen(['script', '-q', os.path.join(work, 'TP3.LOG'), emu2(), 'TURBO.COM'], cwd=work,
                         stdin=subprocess.PIPE, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    for wait, k in keys:
        time.sleep(wait)
        if k:
            p.stdin.write(k.encode()); p.stdin.flush()
    try:
        p.stdin.close(); p.wait(timeout=20)
    except subprocess.TimeoutExpired:
        p.kill()
    for n in (name + '.COM', name.lower() + '.com'):
        if os.path.exists(os.path.join(work, n)):
            return os.path.join(work, n)
    print(open(os.path.join(work, 'TP3.LOG'), encoding='latin1', errors='replace').read()[-2000:])
    sys.exit('emstest20: the compile failed')


def main():
    if not os.path.exists(os.path.join(TP, 'TURBO.COM')):
        sys.exit('needs Turbo Pascal 3.02A: put its TURBO.COM and TURBO.MSG in toolchains/TP302A (NOTES.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    turbo = os.path.join(B, 'TURBO.COM')
    subprocess.run([sys.executable, os.path.join(R, 'tools', 'mkturbo.py'), os.path.join(TP, 'TURBO.COM'),
                    os.path.join(R, 'tools', 'rt302.tsv'), turbo], check=True)
    shutil.copy(os.path.join(TP, 'TURBO.MSG'), B)
    shutil.copy(os.path.join(R, 'src', 'EMSTEST.PAS'), B)
    com = bytearray(open(compile_tp3(B, 'EMSTEST'), 'rb').read())
    rt = open(os.path.join(B, 'TURBO.RT'), 'rb').read()
    com[:len(rt)] = rt
    struct.pack_into('<HH', com, 0x2C44, *LOAD_WORDS)
    out = os.path.join(B, 'EMSTEST.COM')
    open(out, 'wb').write(com)
    if bytes(com) == open(ORIGINAL, 'rb').read():
        print('EMSTEST.COM: byte-identical to the original (SHA-256 %s)' % hashlib.sha256(com).hexdigest())
        return 0
    print('EMSTEST.COM: differs from the original (cmp %s %s)' % (out, ORIGINAL))
    return 1


if __name__ == '__main__':
    sys.exit(main())

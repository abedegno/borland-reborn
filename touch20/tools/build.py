"""Build TOUCH.COM from src/TOUCH.C with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. The startup module: ../scripts/interim_rtl.py writes build/C0.ASM (Borland C++ 2.0's
   C0.ASM with Turbo C++ 1.01's banner); TASM assembles it for the tiny model with the
   switches of Borland's BUILD-C0.BAT.
2. The library modules, taken from the two products' CS.LIB: most are Turbo C++ 1.01's, and
   FPUTS, FSEEK and NEARHEAP are Borland C++ 2.0's (MODULES below). They are linked as
   objects, in the order of the original.
3. In DOS (Exhume's tools/dosrun.mjs): TCC -c -mt -O -Z (Turbo C++ 1.01), TASM 2.51, and
   TLINK /t /c /m (Turbo C++ 1.01's TLINK 3.01; TLINK 2.0 and 4.0 give the same file).
4. SHA-256 of build/out/TOUCH.COM against the original, toolchains/BC20/BIN/TOUCH.COM.
   Exit status 0 when they are identical."""
import hashlib, os, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build')

ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TOUCH.COM')
ORIGINAL_SHA = '8a7077f35a0e11dbb7116107fd61372cc89d04b0610555fc8755850cee59d909'

# The library modules in TOUCH.COM, in its order: the order of the libraries themselves,
# with the data-only modules (FILES, FILES2, HEAPLEN, STKLEN) in their places, which puts
# __heaplen and __stklen where C0 reads them. Each module's code was found in TOUCH.COM
# with its fixups masked; FPUTS and FSEEK differ between the two libraries and TOUCH.COM
# has Borland C++ 2.0's, and NEARHEAP is the same code in both but only Borland C++ 2.0's
# is byte-aligned, as TOUCH.COM's is. Borland's own library at the time evidently sat
# between the two releases (../scripts/interim_rtl.py). The source calls _open and _close,
# so the link takes them from OPENA and CLOSEA.
MODULES = [('TC101', m) for m in 'ATEXIT EXIT FFLUSH FILES FILES2 FLUSHALL'.split()] + \
          [('BC20', 'FPUTS'), ('BC20', 'FSEEK')] + \
          [('TC101', m) for m in ('GETDATE HEAPLEN PUTC PUTS SETUPIO SETVBUF STKLEN TELL WRITE '
                                  'XFFLUSH BRK CLOSEA FINDFIRS IOERROR ISATTY LSEEK MEMCPY OPENA '
                                  'SETFTIME STRCPY STRLEN WRITEA').split()] + \
          [('BC20', 'NEARHEAP'), ('TC101', 'SETARGV')]



def main():
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    open(os.path.join(B, 'C0.ASM'), 'wb').write(rtl.c0_source(TC))
    for lib in ('TC101', 'BC20'):
        rtl.extract(os.path.join(TC, lib, 'LIB', 'CS.LIB'), {m for l, m in MODULES if l == lib}, os.path.join(B, lib))
    objs = ' '.join(['C0T', 'TOUCH'] + [f'{l}\\{m}' for l, m in MODULES])
    open(os.path.join(B, 'LINK.RSP'), 'w', newline='\r\n').write(objs + ',TOUCH,TOUCH;\n')
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '300',
           '-f', os.path.join(TC, 'TC101', 'BIN', 'TCC.EXE'), '-f', os.path.join(TC, 'TC101', 'INCLUDE') + '=INCLUDE',
           '-f', os.path.join(TC, 'TC101', 'BIN', 'TLINK.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'),
           '-f', os.path.join(B, 'C0.ASM'), '-f', os.path.join(TC, 'BC20', 'STARTUP', 'RULES.ASI'),
           '-f', os.path.join(R, 'src', 'TOUCH.C'), '-f', os.path.join(B, 'LINK.RSP'),
           '-f', os.path.join(B, 'TC101') + '=TC101', '-f', os.path.join(B, 'BC20') + '=BC20',
           '-c', 'TCC -c -mt -O -Z -IC:\\INCLUDE TOUCH.C', '-c', rtl.TASM_C0.format(model='TINY', obj='C0T'),
           '-c', 'TLINK /t /c /m @LINK.RSP', '-o', 'TOUCH.COM', '-o', 'TOUCH.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
    out = os.path.join(B, 'out', 'TOUCH.COM')
    if r.returncode or not os.path.exists(out):
        sys.exit('touch20: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'TOUCH.COM: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'TOUCH.COM: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

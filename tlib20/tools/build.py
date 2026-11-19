"""Build TLIB.EXE from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. The library: ../scripts/interim_rtl.py writes every module of Borland C++ 2.0's CC.LIB
   to build/M, with GETW, PUTC and OPEN taken from Turbo C++ 1.01's CC.LIB instead, and
   leaves out the four modules no released library has (FFLUSH, FGETS, FREAD, GETC): BCC
   compiles those from ../interim-rtl/src. TLIB then puts the modules back together, in
   Borland C++ 2.0's order, as CCI.LIB. TLINK searches it, which reproduces the order of the
   library code in TLIB.EXE.
2. The startup module: Borland C++ 2.0's C0.ASM with Turbo C++ 1.01's banner, assembled for
   the compact model as BUILD-C0.BAT does.
3. TLIB's own files, each with the switches of its /* opts: */ line: Turbo C 2.01's TCC, in
   the compact model (CMDLINE.C and ERROR.C go through TASM, -B).
4. Turbo C 2.01's TLINK 2.0 (/c /m): TLINK 3.01 and 4.0 write another EXE header.
5. SHA-256 of build/out/TLIB.EXE against the original, toolchains/BC20/BIN/TLIB.EXE. Exit
   status 0 when they are identical."""
import hashlib, os, re, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')

ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TLIB.EXE')
ORIGINAL_SHA = 'b06333a799afde9f2070d199c94108e25a0e671dca462927d23c570c7ffc7ce4'

# TLIB's object files in link order: the startup module, then TLIB's own files in the order
# of their code in TLIB.EXE. GLOBALS.C has no code; its data sits between FNAME.C's and
# DEMANGLE.C's, so it is linked there.
FILES = ['STUBS', 'CMDLINE', 'OMF', 'HASH', 'SYMTAB', 'WALK', 'ERROR', 'FNAME', 'GLOBALS', 'DEMANGLE']
# library modules TLIB.EXE has in Turbo C++ 1.01's version rather than Borland C++ 2.0's
TC101_MODULES = ('GETW', 'PUTC', 'OPEN')


def opts(path):
    m = re.search(r'/\* opts: (.*?) \*/', open(path, encoding='latin1').read())
    return m.group(1).split() if m else []


def main():
    if not os.path.isdir(os.path.join(TC, 'TC201')):
        sys.exit('no toolchains/TC201: run scripts/setup-toolchains.py with --tc201 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    names = rtl.library(TC, 'compact', os.path.join(B, 'M'), TC101_MODULES)
    rsp = ['+' + (n if n in rtl.INTERIM else 'M\\' + n) + '.OBJ' for n in names]
    open(os.path.join(B, 'CCI.RSP'), 'w', newline='\r\n').write(' &\n'.join(rsp) + '\n')
    open(os.path.join(B, 'C0.ASM'), 'wb').write(rtl.c0_source(TC))
    open(os.path.join(B, 'LINK.RSP'), 'w', newline='\r\n').write(
        'C0C ' + ' '.join(FILES) + ',TLIB,TLIB,CCI\n')

    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '600',
           '-f', os.path.join(TC, 'TC201', 'BIN', 'TCC.EXE'), '-f', os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(TC, 'TC201', 'INCLUDE') + '=INCLUDE',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'BCC.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'),
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLIB.EXE'), '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=BCINC',
           '-f', os.path.join(TC, 'BC20', 'STARTUP', 'RULES.ASI'), '-f', os.path.join(B, 'C0.ASM'),
           '-f', os.path.join(B, 'M') + '=M', '-f', os.path.join(B, 'CCI.RSP'), '-f', os.path.join(B, 'LINK.RSP')]
    for n, o in rtl.INTERIM.items():
        cmd += ['-f', os.path.join(rtl.RTL_SRC, n + '.C'), '-c', f'BCC -c -mc {o} -IBCINC {n}.C']
    cmd += ['-c', 'TLIB CCI.LIB @CCI.RSP', '-c', rtl.TASM_C0.format(model='COMPACT', obj='C0C')]
    cmd += ['-f', os.path.join(R, 'src', 'include', 'TLIB.H')]
    for f in FILES:
        src = os.path.join(R, 'src', f + '.C')
        cmd += ['-f', src, '-c', 'TCC -c ' + ' '.join(opts(src)) + ' -IINCLUDE ' + f + '.C']
    cmd += ['-c', 'TLINK /c /m @LINK.RSP', '-o', 'TLIB.EXE', '-o', 'TLIB.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'TLIB.EXE')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('tlib20: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'TLIB.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'TLIB.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

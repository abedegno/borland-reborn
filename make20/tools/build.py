"""Build MAKE.EXE from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. The library: ../scripts/interim_rtl.py writes every module of Borland C++ 2.0's CC.LIB
   to build/link/M, with PUTC, OPEN and VPRINTER taken from Turbo C++ 1.01's CC.LIB instead,
   and leaves out the modules no released library has (../interim-rtl/src): BCC compiles
   those. TLIB then puts the modules back together, in Borland C++ 2.0's order, as CCI.LIB.
   TLINK searches it, which reproduces the order of the library code in MAKE.EXE.
2. The startup module: Borland C++ 2.0's C0.ASM with Turbo C++ 1.01's banner, assembled for
   the compact model as BUILD-C0.BAT does.
3. MAKE's own files: Borland C++ 2.0's BCC, each C file with the switches of its
   /* opts: */ line, and SWAP.ASM with TASM.
4. The link, in the order of the code in MAKE.EXE: the startup module, MAKE's files, then
   the interim fnsplit(), Borland C++ 2.0's own FNMERGE module and the swapping code, which
   come before the rest of the library, and last the library itself.
5. SHA-256 of build/link/out/MAKE.EXE against the original, toolchains/BC20/BIN/MAKE.EXE.
   Exit status 0 when they are identical."""
import hashlib, os, re, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')

ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'MAKE.EXE')
ORIGINAL_SHA = 'cdcc73cc5ec3cbfd4db81e7c331dcb8311411f5518f39eb7a17a35ae0d1ca1f4'

# MAKE's own files in the order of their code in MAKE.EXE. MSGS.C has no code; its data
# sits between MACRO.C's and IFEXPR.C's.
FILES = ['BUILD', 'MAKEIN', 'MAIN', 'PARSE', 'EXEC', 'MACRO', 'MSGS', 'IFEXPR', 'CONFIG', 'ERRORS',
         'VMSG']
# linked as objects after them, before the library: the interim fnsplit(), Borland C++
# 2.0's FNMERGE module (from build/link/M) and the swapping code
AFTER = ['FNSPLIT', 'M\\FNMERGE', 'SPAWN', 'SWAP']
# library modules MAKE.EXE has in Turbo C++ 1.01's version rather than Borland C++ 2.0's
TC101_MODULES = ('PUTC', 'OPEN', 'VPRINTER')
# interim modules MAKE.EXE has besides the four of ../scripts/interim_rtl.py's INTERIM, with
# their BCC switches: rebuilt from ../interim-rtl/src in place of Borland C++ 2.0's (TLIB.EXE
# links Borland C++ 2.0's own fnsplit(), so they are not in the shared list)
MAKE_INTERIM = {'FNSPLIT': '-O -Z -a', 'SEARCHP': '-B -O -Z'}


def opts(path):
    m = re.search(r'/\* opts: (.*?) \*/', open(path, encoding='latin1').read())
    return m.group(1).split() if m else []


def main():
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    names = rtl.library(TC, 'compact', os.path.join(B, 'M'), TC101_MODULES)
    interim = dict(rtl.INTERIM, **MAKE_INTERIM)
    rsp = ['+' + (n if n in interim else 'M\\' + n) + '.OBJ' for n in names]
    open(os.path.join(B, 'CCI.RSP'), 'w', newline='\r\n').write(' &\n'.join(rsp) + '\n')
    open(os.path.join(B, 'C0.ASM'), 'wb').write(rtl.c0_source(TC))
    objs = ['C0C'] + FILES + AFTER
    open(os.path.join(B, 'LINK.RSP'), 'w', newline='\r\n').write(
        ' +\n'.join(objs) + '\nMAKE\nMAKE\nCCI\n')

    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '900',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(TC, 'BC20', 'BIN', 'BCC.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'),
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLIB.EXE'), '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=BCINC',
           '-f', os.path.join(TC, 'BC20', 'STARTUP', 'RULES.ASI'), '-f', os.path.join(B, 'C0.ASM'),
           '-f', os.path.join(B, 'M') + '=M', '-f', os.path.join(B, 'CCI.RSP'), '-f', os.path.join(B, 'LINK.RSP')]
    for n, o in interim.items():
        cmd += ['-f', os.path.join(rtl.RTL_SRC, n + '.C'), '-c', f'BCC -c -mc {o} -IBCINC {n}.C']
    cmd += ['-c', 'TLIB CCI.LIB @CCI.RSP', '-c', rtl.TASM_C0.format(model='COMPACT', obj='C0C')]
    cmd += ['-f', os.path.join(R, 'src', 'include', 'MAKE.H')]
    for f in FILES + ['SPAWN']:
        src = os.path.join(R, 'src', f + '.C')
        cmd += ['-f', src, '-c', 'BCC -c ' + ' '.join(opts(src)) + ' -IBCINC ' + f + '.C']
    cmd += ['-f', os.path.join(R, 'src', 'SWAP.ASM'), '-c', 'TASM /ml SWAP.ASM']
    cmd += ['-c', 'TLINK /c /m @LINK.RSP', '-o', 'MAKE.EXE', '-o', 'MAKE.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'MAKE.EXE')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('make20: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if ORIGINAL_SHA and sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'MAKE.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'MAKE.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

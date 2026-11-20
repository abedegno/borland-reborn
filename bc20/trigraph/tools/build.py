"""Build TRIGRAPH.EXE from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. The library: every module of Borland C++ 2.0's CS.LIB, in that library's order, with
   FFLUSH, PUTC, GETC and OPEN taken from Turbo C++ 1.01's CS.LIB instead, and FREAD, which
   neither library has, compiled from src/FREAD.C (Turbo C++ 1.01's fread built by Borland
   C++ 2.0's BCC); TLIB puts them together as CSI.LIB. (Each module's code was found in
   TRIGRAPH.EXE with its fixups masked.)
2. Borland C++ 2.0's BCC compiles FILEIO.CPP and TRIGRAPH.CPP, as C++, small model, each
   with the switches of its /* opts: */ line.
3. The startup module: the interim C0S, Borland C++ 2.0's C0.ASM with Turbo C++ 1.01's banner
   (../../scripts/interim_rtl.py), assembled for the small model as BUILD-C0.BAT does. Its code
   is Turbo C++ 1.01's C0S, but its segments come in Borland C++ 2.0's order, which puts the
   _INIT_ table after _DATA as in TRIGRAPH.EXE.
4. Borland C++ 2.0's TLINK 4.0 links the startup module, FILEIO, TRIGRAPH,
   Borland C++ 2.0's WILDARGS.OBJ (wildcards in the command line, which brings in the WILD
   module) and the library.
5. SHA-256 of build/link/out/TRIGRAPH.EXE against toolchains/BC20/BIN/TRIGRAPH.EXE. Exit status 0
   when they are identical."""
import hashlib, os, re, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TRIGRAPH.EXE')
ORIGINAL_SHA = 'b9810f093f6a279845547fcb4d03ef538ad7a18f2160fb1fe5d8e650cb741e1b'
TC101_MODULES = ('FFLUSH', 'PUTC', 'GETC', 'OPEN')


def opts(path):
    m = re.search(r'/\* opts: (.*?) \*/', open(path, encoding='latin1').read())
    return m.group(1).split() if m else []


def main():
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(os.path.join(B, 'M'))
    old = dict(rtl.lib_modules(os.path.join(TC, 'TC101', 'LIB', 'CS.LIB')))
    names = []
    for name, data in rtl.lib_modules(os.path.join(TC, 'BC20', 'LIB', 'CS.LIB')):
        if name in TC101_MODULES:
            data = old[name]
        if name != 'FREAD':
            open(os.path.join(B, 'M', name + '.OBJ'), 'wb').write(data)
        names.append(name)
    open(os.path.join(B, 'CSI.RSP'), 'w', newline='\r\n').write(
        ' &\n'.join('+' + ('' if n == 'FREAD' else 'M\\') + n + '.OBJ' for n in names) + '\n')
    srcs = [os.path.join(R, 'src', f + '.CPP') for f in ('FILEIO', 'TRIGRAPH')]
    open(os.path.join(B, 'C0.ASM'), 'wb').write(rtl.c0_source(TC))
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '300',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'BCC.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLIB.EXE'), '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=INCLUDE',
           '-f', os.path.join(B, 'C0.ASM'), '-f', os.path.join(TC, 'BC20', 'STARTUP', 'RULES.ASI'),
           '-f', os.path.join(B, 'M') + '=M',
           '-f', os.path.join(B, 'CSI.RSP'), '-f', os.path.join(TC, 'BC20', 'LIB', 'WILDARGS.OBJ'),
           '-f', os.path.join(R, 'src', 'include', 'TRIGRAPH.H'),
           '-f', os.path.join(R, 'src', 'FREAD.C'),
           '-c', 'BCC -c ' + ' '.join(opts(os.path.join(R, 'src', 'FREAD.C'))) + ' -IINCLUDE FREAD.C',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'),
           '-c', 'TLIB CSI.LIB @CSI.RSP', '-c', rtl.TASM_C0.format(model='SMALL', obj='C0S')]
    for src in srcs:
        cmd += ['-f', src, '-c', 'BCC -c ' + ' '.join(opts(src)) + ' -IINCLUDE ' + os.path.basename(src)]
    cmd += [
           '-c', 'TLINK /c /m C0S FILEIO TRIGRAPH WILDARGS,TRIGRAPH,TRIGRAPH,CSI', '-o', 'TRIGRAPH.EXE', '-o', 'TRIGRAPH.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'TRIGRAPH.EXE')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('bc20/trigraph: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'TRIGRAPH.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'TRIGRAPH.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

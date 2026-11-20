"""Build TRANCOPY.EXE from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. The library: every module of Borland C++ 2.0's CL.LIB, in that library's order, with PUTC
   compiled from src/PUTC.C instead (TRANCOPY.EXE's fputc and __fputn differ from the
   released library's in one instruction); TLIB puts them together as CLI.LIB.
2. Borland C++ 2.0's BCC compiles TRANCOPY.CPP and PRJFILE.CPP, as C++, large model, each
   with the switches of its /* opts: */ line.
3. Borland C++ 2.0's TLINK 4.0 links C0L.OBJ, TRANCOPY, PRJFILE and the library. The library
   modules' code is all in _TEXT, after the startup code, so it comes before TRANCOPY's own
   segments.
4. SHA-256 of build/link/out/TRANCOPY.EXE against toolchains/BC20/BIN/TRANCOPY.EXE. Exit
   status 0 when they are identical."""
import hashlib, os, re, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TRANCOPY.EXE')
ORIGINAL_SHA = 'bb66a1e924f5f9d68fa50fbb8123692ac829774da6d8fb490978c8fdb7f3d0d9'
FILES = ['TRANCOPY', 'PRJFILE']


def opts(path):
    m = re.search(r'/\* opts: (.*?) \*/', open(path, encoding='latin1').read())
    return m.group(1).split() if m else []


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(os.path.join(B, 'M'))
    names = []
    for name, data in rtl.lib_modules(os.path.join(TC, 'BC20', 'LIB', 'CL.LIB')):
        if name != 'PUTC':
            open(os.path.join(B, 'M', name + '.OBJ'), 'wb').write(data)
        names.append(name)
    open(os.path.join(B, 'CLI.RSP'), 'w', newline='\r\n').write(
        ' &\n'.join('+' + ('' if n == 'PUTC' else 'M\\') + n + '.OBJ' for n in names) + '\n')
    putc = os.path.join(R, 'src', 'PUTC.C')
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '300',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'BCC.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLIB.EXE'), '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=INCLUDE',
           '-f', os.path.join(TC, 'BC20', 'LIB', 'C0L.OBJ'), '-f', os.path.join(B, 'M') + '=M',
           '-f', os.path.join(B, 'CLI.RSP'), '-f', os.path.join(R, 'src', 'include', 'PRJFILE.H'),
           '-f', putc, '-c', 'BCC -c ' + ' '.join(opts(putc)) + ' -IINCLUDE PUTC.C',
           '-c', 'TLIB CLI.LIB @CLI.RSP']
    for f in FILES:
        src = os.path.join(R, 'src', f + '.CPP')
        cmd += ['-f', src, '-c', 'BCC -c ' + ' '.join(opts(src)) + ' -IINCLUDE ' + f + '.CPP']
    cmd += ['-c', 'TLINK /c /m C0L ' + ' '.join(FILES) + ',TRANCOPY,TRANCOPY,CLI',
            '-o', 'TRANCOPY.EXE', '-o', 'TRANCOPY.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'TRANCOPY.EXE')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('bc20/trancopy: the build failed')
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'TRANCOPY.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'TRANCOPY.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

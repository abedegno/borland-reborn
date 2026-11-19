"""Build OBJXREF.COM from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. OBJXREF's three files, each with the switches of its /* opts: */ line: Turbo C 2.01's
   TCC, compact model.
2. Turbo C 2.01's TLINK 2.0 (/c /m), with Turbo C 2.01's own startup module (C0C.OBJ) and
   library (CC.LIB): OBJXREF.EXE.
3. tools/compack.py packs the EXE into a .COM the way Borland packed OBJXREF.COM.
4. SHA-256 of build/link/out/OBJXREF.COM against the original,
   toolchains/BC20/BIN/OBJXREF.COM. Exit status 0 when they are identical."""
import hashlib, os, re, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
sys.path.insert(0, os.path.join(R, 'tools'))
import interim_rtl as rtl
import compack
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')

ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'OBJXREF.COM')
ORIGINAL_SHA = '835a536ac3c01b2f8633fb6e98980f45b55dfa924215023fc2087d494d1152e1'

# OBJXREF's object files in link order: its own file, then the demangler (TLIB's, the same
# source) and the reader of Turbo C project files
FILES = ['OBJXREF', 'DEMANGLE', 'PRJ']


def opts(path):
    m = re.search(r'/\* opts: (.*?) \*/', open(path, encoding='latin1').read())
    return m.group(1).split() if m else []


def main():
    tc201 = os.path.join(TC, 'TC201')
    for need in ('BIN/TCC.EXE', 'BIN/TLINK.EXE', 'LIB/C0C.OBJ', 'LIB/CC.LIB'):
        if not os.path.exists(os.path.join(tc201, need)):
            sys.exit(f'no toolchains/TC201/{need}: run scripts/setup-toolchains.py with --tc201 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '600',
           '-f', os.path.join(tc201, 'BIN', 'TCC.EXE'), '-f', os.path.join(tc201, 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(tc201, 'INCLUDE') + '=INCLUDE',
           '-f', os.path.join(tc201, 'LIB', 'C0C.OBJ'), '-f', os.path.join(tc201, 'LIB', 'CC.LIB')]
    for f in FILES:
        src = os.path.join(R, 'src', f + '.C')
        cmd += ['-f', src, '-c', 'TCC -c ' + ' '.join(opts(src)) + ' -IINCLUDE ' + f + '.C']
    cmd += ['-c', 'TLINK /c /m C0C ' + ' '.join(FILES) + ',OBJXREF,OBJXREF,CC',
            '-o', 'OBJXREF.EXE', '-o', 'OBJXREF.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    exe = os.path.join(B, 'out', 'OBJXREF.EXE')
    if r.returncode or not os.path.exists(exe):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('objxref20: the build failed')
    out = os.path.join(B, 'out', 'OBJXREF.COM')
    open(out, 'wb').write(compack.pack(open(exe, 'rb').read()))
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if ORIGINAL_SHA and sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'OBJXREF.COM: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'OBJXREF.COM: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

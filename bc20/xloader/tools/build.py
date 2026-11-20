"""Build TLINKX.EXE and BCCX.EXE (the real-mode loaders of Borland C++ 2.0's protected-mode
linker and compiler) from src/ with the original tools, then compare them with Borland's.

    python3 tools/build.py [tlinkx|bccx]

For each program:
1. The library: every module of Borland C++ 2.0's CL.LIB (large model), in that library's
   order, with PUTC compiled from ../trancopy/src/PUTC.C instead (the loaders have the
   same fputc as TRANCOPY.EXE); TLIB puts them together as CLI.LIB.
2. TASM 2.51 assembles the five modules of src/<program>/.
3. M1 holds main and the functions after it, which Borland compiled with BCC. BCC writes one
   data record per function (records of at most 1 KB) and each record's fixups in
   descending order; TASM writes 1 KB records and ascending fixups. tools/revfix.py re-cuts
   M1.OBJ's records where BCC's were and sorts each record's fixups as BCC does, so that
   TLINK writes the relocation table in the original's order. It changes no byte of code.
4. TLINK 4.0 links C0L.OBJ, M1, M2, M2B, M3, M3B and CLI.LIB.
5. SHA-256 against toolchains/BC20/BIN/<program>.EXE. Exit status 0 when all are identical."""
import hashlib, os, re, shutil, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
B = os.path.join(R, 'build', 'link')
BIN = os.path.join(TC, 'BC20', 'BIN')
MODULES = ['M1', 'M2', 'M2B', 'M3', 'M3B']
# where BCC started a new data record in M1 (offsets in M1's segment), from the original's
# relocation order; past these, records are cut every 1 KB
CUTS = {'tlinkx': ['3FF'], 'bccx': ['3FD']}
DOSRUN = os.path.join(rtl.EXHUME, 'tools', 'dosrun.mjs')


def run(out, args):
    r = subprocess.run(['node', DOSRUN, out, '-t', '300'] + args, capture_output=True, text=True)
    log = os.path.join(out, 'RUN.LOG')
    return r, (open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)


def library():
    lib = os.path.join(B, 'lib')
    os.makedirs(os.path.join(lib, 'M'))
    names = []
    for name, data in rtl.lib_modules(os.path.join(TC, 'BC20', 'LIB', 'CL.LIB')):
        if name != 'PUTC':
            open(os.path.join(lib, 'M', name + '.OBJ'), 'wb').write(data)
        names.append(name)
    open(os.path.join(lib, 'CLI.RSP'), 'w', newline='\r\n').write(
        ' &\n'.join('+' + ('' if n == 'PUTC' else 'M\\') + n + '.OBJ' for n in names) + '\n')
    putc = os.path.join(R, '..', 'trancopy', 'src', 'PUTC.C')
    opts = re.search(r'/\* opts: (.*?) \*/', open(putc, encoding='latin1').read()).group(1)
    r, log = run(os.path.join(lib, 'out'), [
        '-f', os.path.join(BIN, 'BCC.EXE'), '-f', os.path.join(BIN, 'TLINK.EXE'), '-f', os.path.join(BIN, 'TLIB.EXE'),
        '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=INCLUDE', '-f', os.path.join(lib, 'M') + '=M',
        '-f', os.path.join(lib, 'CLI.RSP'), '-f', putc,
        '-c', 'BCC -c %s -IINCLUDE PUTC.C' % opts, '-c', 'TLIB CLI.LIB @CLI.RSP', '-o', 'CLI.LIB'])
    out = os.path.join(lib, 'out', 'CLI.LIB')
    if not os.path.exists(out):
        print(log)
        sys.exit('bc20/xloader: building CLI.LIB failed')
    return out


def build(prog, cli):
    name = prog.upper()
    src = os.path.join(R, 'src', prog)
    w = os.path.join(B, prog)
    args = ['-f', os.path.join(BIN, 'TASM.EXE')]
    for m in MODULES:
        args += ['-f', os.path.join(src, m + '.ASM'), '-c', 'TASM /ml %s.ASM' % m, '-o', m + '.OBJ']
    r, log = run(os.path.join(w, 'obj'), args)
    objs = [os.path.join(w, 'obj', m + '.OBJ') for m in MODULES]
    if not all(os.path.exists(o) for o in objs):
        print(log)
        sys.exit('bc20/xloader: assembling %s failed' % prog)
    subprocess.run([sys.executable, os.path.join(R, 'tools', 'revfix.py'), objs[0]] + CUTS[prog], check=True)
    args = ['-f', os.path.join(BIN, 'TLINK.EXE'), '-f', os.path.join(TC, 'BC20', 'LIB', 'C0L.OBJ'), '-f', cli]
    for o in objs:
        args += ['-f', o]
    args += ['-c', 'TLINK /c /m C0L %s,%s,%s,CLI' % (' '.join(MODULES), name, name), '-o', name + '.EXE', '-o', name + '.MAP']
    r, log = run(os.path.join(w, 'out'), args)
    exe = os.path.join(w, 'out', name + '.EXE')
    if not os.path.exists(exe):
        print(log)
        sys.exit('bc20/xloader: linking %s failed' % prog)
    orig = os.path.join(BIN, name + '.EXE')
    if open(exe, 'rb').read() == open(orig, 'rb').read():
        print('%s.EXE: byte-identical to the original (SHA-256 %s)' % (name, hashlib.sha256(open(exe, 'rb').read()).hexdigest()))
        return True
    print('%s.EXE: differs from the original (cmp %s %s)' % (name, exe, orig))
    return False


OVY = {'tlinkx.ovy': 'tlinkx', 'bccx.ovy': 'bccx'}


def build_ovy(prog):
    """the protected-mode image: TASM 2.51 assembles src/ovy/<program>/*.ASM, TLINK 4.0 links
    them as a DOS program (the image, then the overlay block), and tools/mz2yo.py writes the YO
    file with the descriptors and header values of tools/<program>_ovy.py"""
    name = OVY[prog]
    src = os.path.join(R, 'src', 'ovy', name)
    mods = sorted(f[:-4] for f in os.listdir(src) if f.upper().endswith('.ASM'))
    w = os.path.join(B, name + '_ovy')
    args = ['-f', os.path.join(BIN, 'TASM.EXE'), '-f', os.path.join(BIN, 'TLINK.EXE')]
    for m in mods:
        args += ['-f', os.path.join(src, m + '.ASM'), '-c', 'TASM /ml %s.ASM' % m]
    open(os.path.join(B, name + '_ovy.rsp'), 'w', newline='\r\n').write(' +\n'.join(mods) + ',IMAGE,IMAGE\n')
    args += ['-f', os.path.join(B, name + '_ovy.rsp') + '=IMAGE.RSP', '-c', 'TLINK @IMAGE.RSP', '-o', 'IMAGE.EXE']
    r, log = run(w, args)
    exe = os.path.join(w, 'IMAGE.EXE')
    if not os.path.exists(exe):
        print(log)
        sys.exit('bc20/xloader: building %s failed' % prog)
    out = os.path.join(w, name.upper() + '.OVY')
    subprocess.run([sys.executable, os.path.join(R, 'tools', 'mz2yo.py'), os.path.join(R, 'tools', name + '_ovy.py'), exe, out], check=True)
    orig = os.path.join(BIN, name.upper() + '.OVY')
    if open(out, 'rb').read() == open(orig, 'rb').read():
        print('%s.OVY: byte-identical to the original (SHA-256 %s)' % (name.upper(), hashlib.sha256(open(out, 'rb').read()).hexdigest()))
        return True
    print('%s.OVY: differs from the original (cmp %s %s)' % (name.upper(), out, orig))
    return False


def main():
    progs = sys.argv[1:] or ['tlinkx', 'bccx', 'tlinkx.ovy', 'bccx.ovy']
    if not os.path.exists(os.path.join(BIN, 'TLINKX.EXE')):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cli = library() if any(p in CUTS for p in progs) else None
    ok = [build(p, cli) for p in progs if p in CUTS]
    ok += [build_ovy(p) for p in progs if p in OVY]
    return 0 if all(ok) else 1


if __name__ == '__main__':
    sys.exit(main())

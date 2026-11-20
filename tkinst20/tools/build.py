"""Build TKINST.EXE from src/ with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. The library: every module of Borland C++ 2.0's CH.LIB (huge model), in that library's
   order, with PUTC compiled from src/PUTC.C instead; TLIB puts them together as CHI.LIB.
2. Borland C++ 2.0's BCC compiles TKINST.C, huge model, with the switches of its
   /* opts: */ line; TASM 2.51 assembles ANALYZE.ASM.
3. Borland C++ 2.0's TLINK 4.0 links C0H.OBJ, TKINST, ANALYZE and the library.
4. The header: TKINST.EXE's header has 512 bytes more than its relocation table needs.
   TLINK sizes the header for every segment fixup it meets, including those that resolve
   to absolute values and need no relocation entry (`seg` of an AT segment, for example),
   so the original analysis module had about a hundred such fixups that ANALYZE.ASM writes
   as plain numbers. Which ones cannot be told from the EXE (TKERNEL.EXE, which shares
   the module, has the same 512 extra bytes), so the build adds the 512 zero bytes to the
   header after the link and sets the header's size fields to match.
5. SHA-256 of build/link/out/TKINST.EXE against toolchains/BC20/BIN/TKINST.EXE. Exit
   status 0 when they are identical."""
import hashlib, os, re, shutil, struct, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TKINST.EXE')
ORIGINAL_SHA = '6f84a44c7334d01974a71cd06d75db50e8fe69a5fdf91802769eff50ca85afbd'
EXTRA_HEADER = 0x200


def opts(path):
    m = re.search(r'/\* opts: (.*?) \*/', open(path, encoding='latin1').read())
    return m.group(1).split() if m else []


def pad_header(exe, extra):
    """the EXE with EXTRA zero bytes added to its header"""
    h = bytearray(exe[:0x1C])
    hdr = struct.unpack_from('<H', h, 8)[0] * 16
    out = bytearray(exe[:hdr]) + bytes(extra) + exe[hdr:]
    struct.pack_into('<H', out, 8, (hdr + extra) // 16)
    n = len(out)
    struct.pack_into('<HH', out, 2, n % 512, (n + 511) // 512)
    return bytes(out)


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(os.path.join(B, 'M'))
    names = []
    for name, data in rtl.lib_modules(os.path.join(TC, 'BC20', 'LIB', 'CH.LIB')):
        if name != 'PUTC':
            open(os.path.join(B, 'M', name + '.OBJ'), 'wb').write(data)
        names.append(name)
    open(os.path.join(B, 'CHI.RSP'), 'w', newline='\r\n').write(
        ' &\n'.join('+' + ('' if n == 'PUTC' else 'M\\') + n + '.OBJ' for n in names) + '\n')
    putc = os.path.join(R, 'src', 'PUTC.C')
    tkinst = os.path.join(R, 'src', 'TKINST.C')
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '300',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'BCC.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLIB.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'),
           '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=INCLUDE',
           '-f', os.path.join(TC, 'BC20', 'LIB', 'C0H.OBJ'), '-f', os.path.join(B, 'M') + '=M',
           '-f', os.path.join(B, 'CHI.RSP'),
           '-f', putc, '-c', 'BCC -c ' + ' '.join(opts(putc)) + ' -IINCLUDE PUTC.C',
           '-c', 'TLIB CHI.LIB @CHI.RSP',
           '-f', tkinst, '-c', 'BCC -c ' + ' '.join(opts(tkinst)) + ' -IINCLUDE TKINST.C',
           '-f', os.path.join(R, 'src', 'ANALYZE.ASM'), '-c', 'TASM /ml ANALYZE.ASM',
           '-c', 'TLINK /c /m C0H TKINST ANALYZE,TKINST,TKINST,CHI',
           '-o', 'TKINST.EXE', '-o', 'TKINST.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    linked = os.path.join(B, 'out', 'TKINST.EXE')
    if r.returncode or not os.path.exists(linked):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('tkinst20: the build failed')
    out = os.path.join(B, 'out', 'TKINST.PAD.EXE')
    open(out, 'wb').write(pad_header(open(linked, 'rb').read(), EXTRA_HEADER))
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'TKINST.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'TKINST.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

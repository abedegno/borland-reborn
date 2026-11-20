"""Build DPMILOAD.EXE from src/DPMILOAD.ASM with the original tools, then compare it with Borland's.

    python3 tools/build.py

1. Borland C++ 2.0's TASM 2.51 assembles src/DPMILOAD.ASM (/ml).
2. Borland C++ 2.0's TLINK 4.0 links it. The source refers to __SEGTABLE__, so TLINK
   writes the segment table (FBOV) into the program.
3. The relocation table is moved from 3Eh to 40h. Borland's DPMILOAD.EXE has it where TLINK
   puts it in an EXE it copies in as the stub of a New Executable (the layout of the
   protected-mode programs DPMILOAD is the stub of); linking any NE with STUB 'DPMILOAD.EXE'
   gives the same header, apart from the file size and the NE offset.
4. SHA-256 of build/out/DPMILOAD.EXE against toolchains/BC20/BIN/DPMILOAD.EXE. Exit status 0
   when they are identical."""
import hashlib, os, shutil, struct, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
TC = os.path.join(R, '..', 'toolchains')
EXHUME = os.path.join(R, '..', 'exhume')
B = os.path.join(R, 'build')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'DPMILOAD.EXE')
ORIGINAL_SHA = '9a84d9da9077f6d9d59b535c5c2dce7f81766703f005ef8421a1e2a4ff30715b'


def stub_layout(e):
    """the relocation table at 40h, as in a New Executable's stub"""
    e = bytearray(e)
    n, ro = struct.unpack_from('<H', e, 6)[0], struct.unpack_from('<H', e, 0x18)[0]
    table = bytes(e[ro:ro + 4 * n])
    e[ro:ro + 4 * n + 2] = bytes(4 * n + 2)
    e[0x40:0x40 + 4 * n] = table
    struct.pack_into('<H', e, 0x18, 0x40)
    return bytes(e)


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '120',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE'), '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE'),
           '-f', os.path.join(R, 'src', 'DPMILOAD.ASM'), '-c', 'TASM /ml DPMILOAD.ASM',
           '-c', 'TLINK /m DPMILOAD,DPMILOAD,DPMILOAD', '-o', 'DPMILOAD.EXE', '-o', 'DPMILOAD.MAP']
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(B, 'out', 'RUN.LOG')
    out = os.path.join(B, 'out', 'DPMILOAD.EXE')
    if r.returncode or not os.path.exists(out):
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('dpmiload20: the build failed')
    data = stub_layout(open(out, 'rb').read())
    open(out, 'wb').write(data)
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if sha(ORIGINAL) != ORIGINAL_SHA:
        print(f'note: {ORIGINAL} is not the expected file (SHA-256 {sha(ORIGINAL)})')
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print(f'DPMILOAD.EXE: byte-identical to the original (SHA-256 {sha(out)})')
        return 0
    print(f'DPMILOAD.EXE: differs from the original (cmp {out} {ORIGINAL})')
    return 1


if __name__ == '__main__':
    sys.exit(main())

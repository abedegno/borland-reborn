"""Build TKERNEL.EXE (Borland C++ 2.0's protected-mode kernel) from src/ with the original
tools, then compare it with Borland's.

    python3 tools/build.py

TKERNEL.EXE is two DOS programs, bound together:
1. the driver (src/driver/M0..M4.ASM): the real-mode program DOS runs, the A.I. Architects
   protected-mode driver. TASM 2.51 assembles the five modules and TLINK 2.0 links them.
2. the kernel (src/kernel/KERNEL.ASM): the protected-mode kernel, assembled and linked the
   same way into a program of its own (it has no stack segment; TLINK warns).
3. The bind step: the driver's header grows by 512 bytes, and at the old end of the header
   (600h) goes the binder's record: 'AI', two zero bytes, the offset of the kernel in the
   file (the driver's new size) as a doubleword, and eight FFh bytes. The kernel is appended.
4. SHA-256 against toolchains/BC20/BIN/TKERNEL.EXE. Exit status 0 when identical."""
import hashlib, os, shutil, struct, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', 'scripts'))
import interim_rtl as rtl
TC = rtl.toolchains(R)
B = os.path.join(R, 'build', 'link')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TKERNEL.EXE')
DRIVER = ['M0', 'M1', 'M2', 'M3', 'M4']


def link(out, files, name):
    cmd = ['node', os.path.join(rtl.EXHUME, 'tools', 'dosrun.mjs'), out, '-t', '600',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE') + '=TASM251.EXE',
           '-f', os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE') + '=TLINK20.EXE']
    stems = []
    for f in files:
        stem = os.path.basename(f)[:-4].upper(); stems.append(stem)
        cmd += ['-f', f, '-c', 'TASM251 /ml %s.ASM' % stem]
    cmd += ['-c', 'TLINK20 %s,%s,%s' % (' '.join(stems), name, name), '-o', name + '.EXE']
    r = subprocess.run(cmd, capture_output=True, text=True)
    exe = os.path.join(out, name + '.EXE')
    if r.returncode or not os.path.exists(exe):
        log = os.path.join(out, 'RUN.LOG')
        print(open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr)
        sys.exit('tkernel20: building %s failed' % name)
    return open(exe, 'rb').read()


def bind(driver, kernel):
    hdr = struct.unpack_from('<H', driver, 8)[0] * 16
    out = bytearray(driver[:hdr]) + bytes(0x200) + driver[hdr:]
    struct.pack_into('<H', out, 8, (hdr + 0x200) // 16)
    n = len(out)
    struct.pack_into('<HH', out, 2, n % 512, (n + 511) // 512)
    struct.pack_into('<4sI8s', out, hdr, b'AI\0\0', n, b'\xff' * 8)
    return bytes(out) + kernel


def main():
    if not os.path.exists(ORIGINAL) or not os.path.exists(os.path.join(TC, 'TC201', 'BIN', 'TLINK.EXE')):
        sys.exit('needs toolchains/BC20 and toolchains/TC201: run scripts/setup-toolchains.py (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(B)
    drv = link(os.path.join(B, 'driver'), [os.path.join(R, 'src', 'driver', m + '.ASM') for m in DRIVER], 'DRIVER')
    krn = link(os.path.join(B, 'kernel'), [os.path.join(R, 'src', 'kernel', 'KERNEL.ASM')], 'KERNEL')
    out = os.path.join(B, 'TKERNEL.EXE')
    open(out, 'wb').write(bind(drv, krn))
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if open(out, 'rb').read() == open(ORIGINAL, 'rb').read():
        print('TKERNEL.EXE: byte-identical to the original (SHA-256 %s)' % sha(out))
        return 0
    print('TKERNEL.EXE: differs from the original (cmp %s %s)' % (out, ORIGINAL))
    return 1


if __name__ == '__main__':
    sys.exit(main())

#!/usr/bin/env python3
"""Prepare the generated inputs of the exact link from your own BCC.EXE and toolchain.

    python3 scripts/prepare.py            (run from bcc20/, after scripts/setup-toolchains.py)

Nothing here is copied from the original program into the repository: every file it writes
is derived on your machine from toolchain/BC20/BIN/BCC.EXE (checked by its SHA-256) and the
sources in this directory.

1. memory_blocks/*.bin: the original's code blocks as DOS would load them at segment 1000h
   (a slice of the EXE image with its relocations applied), listed in memory_blocks/index.csv.
   The link uses a few of them to check where native code is placed.
2. groupobj/*.OBJ: every link-group source in linkgroups/ assembled with TASM /la /mx
   (linkgroups/native/ holds the whole-file version where the link's piecewise source differs).
3. linktest/*.OBJ: the small objects the link uses to read TLINK's behaviour (linktest/*.ASM
   and reconstructed/OVRREF.ASM).
Objects are normalised after assembly: TASM writes the source file's DOS date and time into
a comment record, and that time is whenever the file was copied into DOS. It is set to a fixed
value (1991-04-23 02:00, the BC 2.0 release files' date) so that every machine produces the
same bytes, which the link's integrity checks pin."""
import hashlib
import os
import shutil
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parents[1]
EXE = HERE / 'toolchain/BC20/BIN/BCC.EXE'
EXE_SHA = 'dd5744b99c6fa61dc1d95c580a1f1d6f1b3e97ae8b920dd6e9cfedce29f82fb6'
DOSRUN = HERE.parent / 'exhume/tools/dosrun.mjs'
DOS_TIME, DOS_DATE = 0x1000, 0x1697      # 02:00:00, 1991-04-23


def die(msg):
    sys.exit('prepare: ' + msg)


def check_exe():
    if not EXE.exists():
        die(f'{EXE} not found: run scripts/setup-toolchains.py first (see docs/SETUP.md)')
    data = EXE.read_bytes()
    if hashlib.sha256(data).hexdigest() != EXE_SHA:
        die(f'{EXE} is not the BCC.EXE of Borland C++ 2.0 this project rebuilds (SHA-256 differs)')
    return data


def memory_blocks(exe):
    last, pages, nrel, hp = struct.unpack_from('<4H', exe, 2)
    header = hp * 16
    rt = struct.unpack_from('<H', exe, 24)[0]
    relocs = {header + seg * 16 + off for off, seg in (struct.unpack_from('<HH', exe, rt + 4 * i) for i in range(nrel))}
    out = HERE / 'memory_blocks'
    rows = (out / 'index.csv').read_text().splitlines()[1:]
    n = 0
    for row in rows:
        block, start, end, size, name = row.split(',')
        if not block.startswith('CODE_'):
            continue                    # overlays and the header are listed but not needed
        seg, off = (int(x, 16) for x in start.split(':'))
        base = header + (seg - 0x1000) * 16 + off
        data = bytearray(exe[base:base + int(size)])
        for i in range(len(data) - 1):
            if base + i in relocs:
                v = struct.unpack_from('<H', data, i)[0]
                struct.pack_into('<H', data, i, (v + 0x1000) & 0xFFFF)
        (out / name).write_bytes(bytes(data))
        n += 1
    print(f'memory_blocks: {n} blocks')


def normalise(obj):
    """Set the DOS date/time of TASM's dependency comment records (class E9) to a fixed value."""
    data = bytearray(obj)
    i = 0
    while i + 3 <= len(data):
        kind = data[i]
        length = struct.unpack_from('<H', data, i + 1)[0]
        body = i + 3
        end = body + length            # checksum byte at end - 1
        if kind == 0x88 and length >= 7 and data[body + 1] == 0xE9:
            struct.pack_into('<HH', data, body + 2, DOS_TIME, DOS_DATE)
            data[end - 1] = (-sum(data[i:end - 1])) & 0xFF
        i = end
        if kind in (0x8A, 0x8B):
            break
    return bytes(data)


def omf_records(data):
    out, i = [], 0
    while i + 3 <= len(data):
        kind = data[i]
        length = struct.unpack_from('<H', data, i + 1)[0]
        out.append((kind, data[i + 3:i + 3 + length - 1]))
        i += 3 + length
        if kind in (0x8A, 0x8B):
            break
    return out


def omf_record(kind, body):
    rec = bytes((kind,)) + struct.pack('<H', len(body) + 1) + body
    return rec + bytes(((-sum(rec)) & 0xFF,))


def apply_records(obj, spec):
    """Rebuild an object with the public and relocation records listed in linkgroups/records/:
    the earlier pipeline calibrated overlay entry publics and restored original relocations
    after assembling, and the link depends on those exact records.  Every other record (code,
    data, names, segments, externals) comes from the fresh assembly, in its own order."""
    fresh = omf_records(obj)
    head = []
    for kind, body in fresh:
        if kind not in (0x80, 0x88):
            break
        head.append((kind, body))
    rest = iter([r for r in fresh[len(head):] if r[0] not in (0x80, 0x88, 0x90, 0x91, 0x9C, 0x9D)])
    out = [omf_record(k, b) for k, b in head]
    for line in spec.read_text().splitlines():
        if not line or line.startswith('#'):
            continue
        tag, value = line.split(' ', 1)
        if tag == '--':
            kind, body = next(rest)
            if kind != int(value, 16):
                die(f'{spec.name}: record layout no longer matches the assembled object')
            out.append(omf_record(kind, body))
        else:
            out.append(omf_record(int(tag, 16), bytes.fromhex(value)))
    if next(rest, None) is not None:
        die(f'{spec.name}: the assembled object has more records than the layout')
    return b''.join(out)


def assemble(jobs, outdir, label):
    """jobs: [(source path, OBJ name)] assembled in one DOS session with TASM /la /mx."""
    outdir.mkdir(exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        cmd = ['node', str(DOSRUN), tmp, '-t', '3600', '--stage', str(HERE / 'toolchain/BC20/BIN/TASM.EXE')]
        for src, name in jobs:
            cmd += ['-f', f'{src}={name}.ASM', '-c', f'TASM /la /mx {name}.ASM,{name}.OBJ,{name}.LST > {name}.LOG',
                    '-o', f'{name}.OBJ', '-O', f'{name}.LST', '-O', f'{name}.LOG']
        r = subprocess.run(cmd, capture_output=True, text=True)
        if r.returncode != 0:
            die(f'{label}: DOS run failed:\n{r.stdout[-2000:]}{r.stderr[-2000:]}')
        for src, name in jobs:
            obj = Path(tmp) / f'{name}.OBJ'
            if not obj.exists():
                die(f'{label}: {name}.OBJ was not produced; see {name}.LOG')
            data = obj.read_bytes()
            spec = HERE / 'linkgroups/records' / f'{name}.txt'
            if outdir.name == 'groupobj' and spec.exists():
                data = apply_records(data, spec)
            (outdir / f'{name}.OBJ').write_bytes(normalise(data))
            for ext in ('LST', 'LOG'):
                p = Path(tmp) / f'{name}.{ext}'
                if p.exists():
                    shutil.copy(p, outdir / p.name)
    print(f'{label}: {len(jobs)} objects')


def main():
    if shutil.which('node') is None:
        die('node is needed (it drives the DOS emulator); see docs/SETUP.md')
    exe = check_exe()
    memory_blocks(exe)
    # linkgroups/native/X.ASM, when present, is the whole-file source of groupobj/X.OBJ; the
    # link itself cuts linkgroups/X.ASM into pieces (some of those files only assemble once the
    # regions now supplied by recovered sources are cut out)
    native = {p.stem.upper(): p for p in (HERE / 'linkgroups/native').glob('*.ASM')}
    groups = [(native.get(p.stem.upper(), p), p.stem.upper()) for p in sorted((HERE / 'linkgroups').glob('*.ASM'))]
    batch = 15                          # assemble in batches so one DOS session stays short
    for k in range(0, len(groups), batch):
        assemble(groups[k:k + batch], HERE / 'groupobj', f'groupobj {k // batch + 1}')
    tests = [(p, p.stem.upper()) for p in sorted((HERE / 'linktest').glob('*.ASM'))]
    tests += [(HERE / 'reconstructed/OVRREF.ASM', 'OVRREF')]   # linktest/DDATA.ASM is in the glob above
    assemble(tests, HERE / 'linktest', 'linktest')
    print('prepare: done. Next: python3 ../exhume/tools/gate.py check --all')


if __name__ == '__main__':
    main()

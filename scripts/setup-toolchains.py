#!/usr/bin/env python3
"""Install the Borland toolchains this repository needs from the WinWorld downloads.

    python3 scripts/setup-toolchains.py --bc20 PATH --tc201 PATH

PATH is the downloaded .7z archive, or a folder holding its floppy images:
  --bc20   Borland C++ 2.0, the "Borland CPP 2.0 (1991) (3.5-720k)" set (DISK01.IMG ... DISK11.IMG)
           https://winworldpc.com/product/borland-c/20
  --tc201  Borland Turbo C 2.01, 3.5" 720k images (Compiler.img, Header.img, ...)
           https://winworldpc.com/product/borland-turbo-c/2x
The files are unpacked into toolchains/BC20 and toolchains/TC201 at the repository root, and
every file is checked against scripts/toolchain-manifest.sha256: the build reproduces
BCC.EXE byte for byte only with exactly these compilers, assembler, linker and headers.
Needs: 7z (p7zip) for .7z archives, mtools (mcopy, mdir) and unzip.

Borland's installer splits some archives across disks (CMDLINE.CA1 on disk 3, CMDLINE.CA2 on
disk 8): each part is a 4-byte header followed by a piece of an ordinary ZIP, so the parts are
joined without their headers and unzipped; no DOS installer is run."""
import argparse
import hashlib
import shutil
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / 'toolchains'
MANIFEST = Path(__file__).with_name('toolchain-manifest.sha256')
REQUIRED = {'BC20/BIN/BCC.EXE', 'BC20/BIN/TASM.EXE', 'BC20/BIN/TLINK.EXE',
            'TC201/BIN/TCC.EXE', 'TC201/BIN/CPP.EXE', 'TC201/BIN/TLINK.EXE'}


def die(msg):
    sys.exit('setup-toolchains: ' + msg)


def need(tool):
    if shutil.which(tool) is None:
        die(f'{tool} is needed (see docs/SETUP.md)')


def images(path, work):
    """the floppy images of a download (.7z or folder), extracted under work"""
    p = Path(path).expanduser()
    if p.is_file():
        need('7z')
        out = work / p.stem
        subprocess.run(['7z', 'x', '-y', f'-o{out}', str(p)], check=True, capture_output=True)
        p = out
    imgs = sorted(q for q in p.rglob('*') if q.suffix.lower() == '.img')
    if not imgs:
        die(f'no .img floppy images found in {path}')
    return imgs


def copy_all(img, out):
    """every file of a FAT floppy image into out (mtools, recursive)"""
    need('mcopy')
    out.mkdir(parents=True, exist_ok=True)
    subprocess.run(['mcopy', '-s', '-n', '-o', '-i', str(img), '::*', str(out)], check=True, capture_output=True)


def unzip(archive, out, members=None):
    need('unzip')
    out.mkdir(parents=True, exist_ok=True)
    cmd = ['unzip', '-o', '-qq', '-C', str(archive)] + (members or []) + ['-d', str(out)]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode not in (0, 1, 11):      # 11: some of the named members are not in this archive
        die(f'unzip {archive.name} failed: {r.stderr.strip()}')


def find(root, name):
    hits = [p for p in root.rglob('*') if p.name.upper() == name.upper()]
    return hits[0] if hits else None


def setup_bc20(path, work):
    disks = work / 'bc20-disks'
    for img in images(path, work):
        copy_all(img, disks / img.stem.upper())
    bc = DEST / 'BC20'
    for sub in ('BIN', 'INCLUDE'):
        (bc / sub).mkdir(parents=True, exist_ok=True)
    # the command-line tools: CMDLINE.CA1 + CMDLINE.CA2, a ZIP split across two disks
    ca1, ca2 = find(disks, 'CMDLINE.CA1'), find(disks, 'CMDLINE.CA2')
    if not ca1 or not ca2:
        die('CMDLINE.CA1/CMDLINE.CA2 not found: is this the 3.5" "Borland CPP 2.0 (1991)" set?')
    joined = work / 'CMDLINE.ZIP'
    joined.write_bytes(ca1.read_bytes()[4:] + ca2.read_bytes()[4:])
    unzip(joined, bc / 'BIN')
    for name, sub in (('TASM.ZIP', 'BIN'), ('BIN.ZIP', 'BIN'), ('BCC.ZIP', 'BIN'), ('INCLUDE.ZIP', 'INCLUDE')):
        z = find(disks, name)
        if not z:
            die(f'{name} not found on the Borland C++ 2.0 disks')
        unzip(z, bc / sub)
    # some archives keep a SYS/ or nested folder: flatten headers that landed one level down
    for h in list((bc / 'INCLUDE').rglob('*.H')):
        if h.parent.name.upper() == 'SYS' or h.parent == bc / 'INCLUDE':
            continue
        shutil.move(str(h), bc / 'INCLUDE' / h.name)
    install_examples(disks, bc)


# Borland's example programs and class library: source the modding build's tests compile
# (bcc20/tools/modtest.py, bcc20/tests/modbuild/BORLAND.TSV).  Only the C and C++ sources
# and headers are installed, where Borland's installer puts them; WINCLUDE.ZIP holds
# WINDOWS.H, which the Windows examples include.
EXAMPLES = [('EXAMPLES.ZIP', 'EXAMPLES'), ('WEXAMPLE.ZIP', 'EXAMPLES/WIN'),
            ('CHAPXMPL.ZIP', 'EXAMPLES/CHAPXMPL'), ('TCALC.ZIP', 'EXAMPLES/TCALC'),
            ('BGI.ZIP', 'EXAMPLES/BGI'), ('TFEXMPL.ZIP', 'EXAMPLES/TF'),
            ('TDEXMPL.ZIP', 'EXAMPLES/TD'), ('TDWEXMPL.ZIP', 'EXAMPLES/TDW'),
            ('CLASSSRC.ZIP', 'CLASSLIB/SOURCE'), ('CLASSINC.ZIP', 'CLASSLIB/INCLUDE'),
            ('CLASSEXM.ZIP', 'CLASSLIB/EXAMPLES'), ('WINCLUDE.ZIP', 'INCLUDE')]


def install_examples(disks, bc):
    for name, sub in EXAMPLES:
        z = find(disks, name)
        if not z:
            die(f'{name} not found on the Borland C++ 2.0 disks')
        (bc / sub).mkdir(parents=True, exist_ok=True)
        unzip(z, bc / sub, ['*.C', '*.CPP', '*.H', '*.HPP'])


def setup_tc201(path, work):
    disks = work / 'tc201-disks'
    for img in images(path, work):
        copy_all(img, disks / img.stem.upper())
    # archives on the disks, if any, are unpacked in place first
    for z in list(disks.rglob('*')):
        if z.suffix.upper() == '.ZIP' and zipfile.is_zipfile(z):
            unzip(z, z.parent)
    tc = DEST / 'TC201'
    for sub in ('BIN', 'INCLUDE'):
        (tc / sub).mkdir(parents=True, exist_ok=True)
    for name in ('TCC.EXE', 'CPP.EXE', 'TLINK.EXE'):
        f = find(disks, name)
        if not f:
            die(f'{name} not found on the Turbo C 2.01 disks')
        shutil.copy(f, tc / 'BIN' / name)
    for h in disks.rglob('*'):
        if h.suffix.upper() == '.H':
            target = tc / 'INCLUDE' / ('SYS' if h.parent.name.upper() == 'SYS' else '') / h.name.upper()
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy(h, target)


def verify():
    bad, missing, ok = [], [], 0
    for line in MANIFEST.read_text().splitlines():
        sha, rel = line.split(None, 1)
        p = DEST / rel
        if not p.exists():
            (bad if rel in REQUIRED else missing).append(rel + ' (missing)')
            continue
        if hashlib.sha256(p.read_bytes()).hexdigest() != sha:
            bad.append(rel + ' (differs)')
        else:
            ok += 1
    for m in missing:
        print('note: optional file not installed:', m)
    if bad:
        die('these files do not match the manifest:\n  ' + '\n  '.join(bad) +
            '\nThe build needs exactly the WinWorld releases named in docs/SETUP.md.')
    print(f'toolchains: {ok} files verified in {DEST}')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--bc20', help='Borland C++ 2.0 download (.7z) or folder of its floppy images')
    ap.add_argument('--tc201', help='Turbo C 2.01 download (.7z) or folder of its floppy images')
    ap.add_argument('--verify-only', action='store_true', help='only check an existing toolchains/ folder')
    a = ap.parse_args()
    if not a.verify_only:
        if not a.bc20 or not a.tc201:
            ap.error('--bc20 and --tc201 are both needed (or --verify-only)')
        with tempfile.TemporaryDirectory() as tmp:
            setup_bc20(a.bc20, Path(tmp))
            setup_tc201(a.tc201, Path(tmp))
    verify()
    link_projects()


def link_projects():
    """Each version's directory (one holding an exhume.toml) refers to its toolchain as
    toolchain/: point that at the shared toolchains/ folder."""
    for cfg in sorted(ROOT.glob('*/exhume.toml')):
        link = cfg.parent / 'toolchain'
        if link.is_symlink() or link.exists():
            continue
        link.symlink_to(Path('..') / 'toolchains', target_is_directory=True)
        print(f'linked {link.relative_to(ROOT)} -> ../toolchains')


if __name__ == '__main__':
    main()

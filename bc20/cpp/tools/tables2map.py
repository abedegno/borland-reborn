"""Rewrite map/modules.tsv from the target tables (the tables are now the map) and check
that they tile CPP.EXE's code (0..0x122A0) without gaps or overlaps.
    python3 tools/tables2map.py"""
import os, re, glob
R = os.path.join(os.path.dirname(__file__), '..')
matched = set(open(os.path.join(R, 'matched.txt')).read().split())
src = {}
for p in glob.glob(os.path.join(R, 'src', '**', '*.*'), recursive=True):
    if p.upper().endswith(('.C', '.ASM')) and '/include/' not in p:
        m = re.search(r'target: (\S+) \*/', open(p, encoding='latin1').read(300))
        if m: src[m.group(1)] = os.path.relpath(p, R)
rows = []
for t in glob.glob(os.path.join(R, 'targets', '*.tsv')):
    n = os.path.basename(t)[:-4]
    if n.startswith('PROOF'): continue
    L = open(t).read().split('\n')
    h = re.match(r'# segment \S+ base (\S+) size (\S+) org (\S+)', L[0])
    b, s, o = (int(x, 16) for x in h.groups())
    rows.append((b - 0x1600, s, o, n, len([l for l in L[1:] if l.strip()])))
rows.sort()
problems = []; at = 0
for b, s, o, n, k in rows:
    if b > at and not any(open(os.path.join(R, 'toolchain/BC20/BIN/CPP.EXE'), 'rb').read()[0x1600 + at:0x1600 + b]):
        print(f'zero fill (alignment) {at:#x}..{b:#x} before {n}')
    elif b != at: problems.append(f'{"gap" if b > at else "overlap"} at {at:#x}..{b:#x} before {n}')
    at = max(at, b + s)
if at != 0x122A0 and any(open(os.path.join(R, 'toolchain/BC20/BIN/CPP.EXE'), 'rb').read()[0x1600 + at:0x1600 + 0x122A0]): problems.append(f'code ends at {at:#x}')
with open(os.path.join(R, 'map', 'modules.tsv'), 'w') as f:
    f.write('# module\tframe\timage start\timage end\tsize\torg\tfunctions\tmatched\tsource\n')
    for b, s, o, n, k in rows:
        f.write(f'{n}\t{(b - o) >> 4:04X}\t{b:#x}\t{b + s:#x}\t{s:#x}\t{o:#x}\t{k}\t{"yes" if n in matched else "no"}\t{src.get(n, "-")}\n')
print(len(rows), 'modules;', len(matched), 'matched;', 'problems:', problems or 'none')

"""Show where the linked EXE's relocation order differs from CPP.EXE's, by module.
    python3 tools/reldiff.py [LINKED.EXE]"""
import sys, os, bisect, struct
here = os.path.dirname(os.path.abspath(__file__)); R = os.path.join(here, '..'); sys.path.insert(0, here)
import mzinfo
d, h, e, ra = mzinfo.load(os.path.join(R, 'toolchain/BC20/BIN/CPP.EXE')); img = d[h:e]
_, _, _, rb = mzinfo.load(sys.argv[1] if len(sys.argv) > 1 else os.path.join(R, 'build/LINK/out/CPP.EXE'))
mods = [l.rstrip('\n').split('\t') for l in open(os.path.join(R, 'map/modules.tsv')) if not l.startswith('#')]
st = [int(m[2], 16) for m in mods]
def mod(x): return mods[bisect.bisect_right(st, x) - 1][0][6:] if x < 0x122a0 else ('DG%04x' % (x - 0x122a0) if x < 0x1b2d0 else 'FAR')
def kind(x):
    v = struct.unpack_from('<H', img, x)[0]
    return ('DG' if v == 0x122a else 'call' if x < 0x122a0 and img[x - 3] == 0x9a else 'seg') + f'{v:04x}'
k = 0; n = len(ra)
while k < n:
    if ra[k] == rb[k]: k += 1; continue
    j = k
    while j < n and sorted(ra[k:j + 1]) != sorted(rb[k:j + 1]): j += 1
    print(f'#{k}-{j}: orig', ' '.join(f'{ra[i]:x}/{mod(ra[i])}/{kind(ra[i])}' for i in range(k, j + 1)))
    print(f'        link', ' '.join(f'{rb[i]:x}/{mod(rb[i])}/{kind(rb[i])}' for i in range(k, j + 1)))
    k = j + 1

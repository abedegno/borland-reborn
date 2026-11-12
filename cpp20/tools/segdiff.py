"""Instruction diff of a built object's code segment against CPP.EXE, whole segment.

    python3 tools/segdiff.py SRC [--context N] [--max HUNKS]

Uses the last build (build/STEM/STEM.OBJ) and the source's target table. Each line is
`offset  instruction`; branch targets and fixup-written operands are shown as `*` so
only real differences remain. Table function names label the exe side."""
import sys, os, re, difflib
here = os.path.dirname(os.path.abspath(__file__)); R = os.path.join(here, '..')
EXHUME = next((p for p in (os.path.join(R, 'exhume'), os.path.join(R, '..', 'exhume')) if os.path.exists(os.path.join(p, 'tools', 'gate.py'))), os.path.join(R, 'exhume'))   # ./exhume here, ../exhume in the borland-reborn repo
sys.path.insert(0, os.path.join(EXHUME, 'tools'))
import config
from omf import module_masked
from iced_x86 import Decoder, Formatter, FormatterSyntax, OpKind, Mnemonic
cfg = config.load(os.path.join(R, 'exhume.toml'))
a = sys.argv[1:]; src = a[0]
ctx = int(a[a.index('--context') + 1]) if '--context' in a else 3
mx = int(a[a.index('--max') + 1]) if '--max' in a else 12
seg, _ = cfg.directives(src); stem = cfg.stem(src)
_, segs, data, mask, _ = module_masked(open(cfg.obj(stem), 'rb').read())
ci = next(i for i, (sn, cn, ln) in enumerate(segs, 1) if ln and cfg.is_code_class(cn))
code, cm = bytes(data[ci]), mask[ci]
base, size, rows, org = cfg.load_targets(seg); exe = cfg.exe
starts = {off: n for n, _, off, _ in rows}
f = Formatter(FormatterSyntax.MASM)
def lines(buf, m):
    out = []
    for i in Decoder(16, buf):
        t = f.format(i)
        if i.op_count and i.op0_kind in (OpKind.NEAR_BRANCH16, OpKind.FAR_BRANCH16): t = t.split()[0] + ' *'
        elif m is not None and any(m[k] for k in range(i.ip, min(i.next_ip, len(m)))):
            t = re.sub(r'\b[0-9A-F]+h\b', '*', t)
        out.append((i.ip, t))
    return out
A = lines(exe[base:base + max(size, len(code))][:size], None)
B = lines(code, cm)
# exe side: mask the operands where the object has a fixup at the same offset only after alignment; simpler: hide hex constants that look like addresses (memory operands without base)
def norm(t): return re.sub(r'\[([0-9A-F]+h)\]', '[*]', re.sub(r'ptr (\w+):\[([0-9A-F]+h)\]', r'ptr \1:[*]', t))
an = [norm(t) for _, t in A]; bn = [norm(t) for _, t in B]
sm = difflib.SequenceMatcher(None, an, bn, autojunk=False)
h = 0
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal': continue
    h += 1
    if h > mx: print('...'); break
    lab = max((o for o in starts if o <= (A[i1][0] if i1 < len(A) else size)), default=0)
    print(f'@@ exe +{A[i1][0] if i1 < len(A) else size:04X} ({starts.get(lab, "?")}+{(A[i1][0] if i1 < len(A) else size) - lab:X})  obj +{B[j1][0] if j1 < len(B) else len(code):04X}')
    for k in range(max(0, i1 - ctx), i1): print(f'   {A[k][0]:04X} {A[k][1]}')
    for k in range(i1, i2): print(f' - {A[k][0]:04X} {A[k][1]}')
    for k in range(j1, j2): print(f' + {B[k][0]:04X} {B[k][1]}')
print(f'-- {h} hunks; exe {size:#x} bytes, obj {len(code):#x}')
# raw byte differences outside the object's fixups
bad = [k for k in range(min(len(code), size)) if not cm[k] and code[k] != exe[base + k]]
print('-- raw differing bytes outside fixups:', ' '.join(f'+{k:X}:{exe[base+k]:02X}/{code[k]:02X}' for k in bad[:24]), '(exe/obj)' if bad else 'none')

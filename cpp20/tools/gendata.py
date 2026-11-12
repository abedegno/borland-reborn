"""Write CPP.EXE's data as TASM sources from the original image: src/data/*.ASM.

    python3 tools/gendata.py

Only two matched objects define data of their own (TOKADV.C at DS:03AE, PREPROC.C at
DS:4FA2); everything else in DGROUP, the stack and the two far data segments after it is
written here, in pieces, so each piece can be linked where its relocations show it belongs:

  ORDER.ASM     linked first: empty segments in CPP.EXE's order (code, DGROUP's _DATA and
                _BSS, the stack, the far data), so TLINK lays out the classes that way.
  Dnnnn.ASM     a run of DGROUP _DATA starting at DS:nnnn. Each is linked right after the
                module that owns its relocated words in CPP.EXE's relocation table (the
                table lists relocations module by module in link order), see PIECES.
  DBSS.ASM      DGROUP's _BSS (labels only, C0 clears it up to BSS_CLEAR_END) and the
                0x1800-byte stack segment (SS:SP 19AD:1800 in the header).
  DFAR.ASM      the far data segments at 1B2Dh and 1B41h (OVREXMEM's extended-memory data;
                its relocations follow OVREXMEM's).

Every symbols.tsv name in DGROUP (outside the two objects' own data) or in a far data
segment is public at its original offset. Relocated words are written as what they are: a
segment word of DGROUP or of a far segment by name, a far pointer to code as `dd NAME`
(the symbols.tsv name at that address), the offset half of a far pointer into DGROUP as
`offset DGROUP:NAME` when a name is there. Other bytes stay bytes (text quoted). A label
inside a 2- or 4-byte item is `NAME equ $-k`."""
import os, sys, struct, collections, re
here = os.path.dirname(os.path.abspath(__file__)); R = os.path.join(here, '..')
EXHUME = next((p for p in (os.path.join(R, 'exhume'), os.path.join(R, '..', 'exhume')) if os.path.exists(os.path.join(p, 'tools', 'gate.py'))), os.path.join(R, 'exhume'))   # ./exhume here, ../exhume in the borland-reborn repo
sys.path.insert(0, here); import mzinfo
d, hdr, end, rels = mzinfo.load(os.path.join(R, 'toolchain/BC20/BIN/CPP.EXE'))
img = d[hdr:end]
DG = 0x122A; DGB = DG * 16
FAR = {0x1B2D: ('FAR46', 'BCC_SEG_46', 0x140), 0x1B41: ('FAR50', 'BCC_SEG_50', 0x44)}
OWNED = [(0x3AE, 0x7A9, 'TOKADV'), (0x4FA2, 0x502E, 'PREPROC')]
DATA_END = 0x5744          # ERROR_COUNT, the first _BSS item (C0 clears from there)
BSS_END = 0x782A           # BSS_CLEAR_END
STACK_PARA = 0x19AD; STACK_SIZE = 0x1800
# (start, owner stem that the piece is linked after); a piece runs to the next start or owned range
# pieces whose owner is compiled C: BC writes a module's fixups in descending order, so these
# pieces emit their relocated items last-first (TASM writes fixups in source order)
REVERSED = {'INITTYPE', 'OPTIONS', 'SEGNAMES', 'SIMPLIFY', 'DRVLINK'}
PIECES = [(0x0000, 'C0'), (0x07A9, 'TOKADV'), (0x0BDA, 'INITTYPE'), (0x0E2E, 'OPTIONS'),
          (0x1A22, 'SEGNAMES'), (0x502E, 'SIMPLIFY'), (0x54B0, 'DRVLINK')]
relset = set(rels)
syms = {}
for l in open(os.path.join(R, 'symbols.tsv')):
    if l.startswith('#') or not l.strip(): continue
    n, a, *_ = l.rstrip('\n').split('\t'); syms[n] = a
ds_names = collections.defaultdict(list); far_names = collections.defaultdict(list); code_at = {}
for n, a in syms.items():
    s, o = a.split(':')
    if s == 'DS': ds_names[int(o, 16)].append(n)
    elif int(s, 16) in FAR: far_names[(int(s, 16), int(o, 16))].append(n)
    else: code_at[(int(s, 16), int(o, 16))] = n
import tomllib
aliases = tomllib.loads(open(os.path.join(R, 'exhume.toml')).read()).get('names', {}).get('extern_aliases', {})
for alias, canon in aliases.items():
    if canon in syms and syms[canon].startswith('DS:') and alias not in syms:
        ds_names[int(syms[canon][3:], 16)].append(alias)
for k in ds_names: ds_names[k].sort()
# names inside an object's own data that the object does not make public (a C table
# indexed from a virtual base, for instance): defined by the next piece as `equ $-k`
sys.path.insert(0, os.path.join(EXHUME, 'tools'))
import omf
owner_pubs = set()
for a, b, stem in OWNED:
    owner_pubs |= set(omf.publics(open(os.path.join(R, 'build', stem, stem + '.OBJ'), 'rb').read()))
inner = {}   # owned-range end -> [(name, offset)]
for o, ns in ds_names.items():
    for a, b, _ in OWNED:
        if a <= o < b:
            for n in ns:
                if n not in owner_pubs: inner.setdefault(b, []).append((n, o))

def owned(o): return any(a <= o < b for a, b, _ in OWNED)
def word(x): return struct.unpack_from('<H', img, x)[0]

class Piece:
    def __init__(self, base, start, stop, labels, segname):
        self.base, self.start, self.stop, self.labels, self.seg = base, start, stop, labels, segname
        self.externs = set(); self.publics = []
    def items(self):
        """{offset: (size, text)} for relocated words and far pointers."""
        it = {}
        for o in range(self.start, self.stop):
            x = self.base + o
            if x not in relset: continue
            para = word(x)
            if para == DG:
                tgt = word(x - 2) if o - 2 >= self.start and (x - 2) not in relset and o - 2 not in it else None
                if tgt is not None and ds_names.get(tgt):
                    n = ds_names[tgt][0]
                    if not (self.base == DGB and self.start <= tgt < self.stop): self.externs.add((n, 'byte'))
                    it[o - 2] = (4, f'dw\toffset DGROUP:{n},DGROUP')
                else:
                    it[o] = (2, 'dw\tDGROUP')
            elif para in FAR:
                it[o] = (2, f'dw\tseg {FAR[para][1]}'); self.externs.add((FAR[para][1], 'far'))
            else:
                off = word(x - 2); n = code_at.get((para, off))
                if n is None: sys.exit(f'{self.seg}+{o:#x}: far pointer {para:04X}:{off:04X} has no name')
                it[o - 2] = (4, f'dd\t{n}'); self.externs.add((n, 'far'))
        return it
    def lines(self, reverse=False):
        if reverse:
            it = self.items()
            cuts = sorted(it) or []
            bounds = [self.start] + [c for c in cuts if c > self.start] + [self.stop]
            chunks = []
            for a, b in zip(bounds, bounds[1:]):
                sub = Piece(self.base, a, b, self.labels, self.seg)
                body = sub.lines(); self.externs |= sub.externs
                chunks.append([f'\t\torg\t{a - self.start:04X}h'] + body)
            mine = {n for o2, ns in self.labels.items() if self.start <= o2 < self.stop for n in ns}
            self.externs = {e for e in self.externs if e[0] not in mine}
            out = []
            for c in reversed(chunks): out += c
            return out
        it = self.items(); out = []; o = self.start; buf = []
        def flush():
            nonlocal buf
            if buf: out.extend(dbytes(buf)); buf = []
        while o < self.stop:
            labs = self.labels.get(o, [])
            if labs: flush(); out += [f'{n}\tlabel\tbyte' for n in labs]
            if o in it:
                flush(); sz, t = it[o]
                out.append('\t\t' + t)
                for k in range(1, sz):
                    out += [f'{n}\tequ\t$-{sz - k}' for n in self.labels.get(o + k, [])]
                o += sz; continue
            buf.append(img[self.base + o]); o += 1
        flush(); return out

def dbytes(b):
    """db lines: printable runs quoted, the rest hex, at most ~60 columns per line."""
    out = []; parts = []; i = 0
    while i < len(b):
        j = i
        while j < len(b) and 32 <= b[j] < 127 and b[j] not in (39,): j += 1
        if j - i >= 3:
            parts.append("'" + bytes(b[i:j]).decode('latin1') + "'"); i = j
        else:
            parts.append(f'0{b[i]:02X}h'); i += 1
    line = []
    for p in parts:
        if sum(len(x) + 1 for x in line) + len(p) > 60 and line: out.append('\t\tdb\t' + ','.join(line)); line = []
        line.append(p)
    if line: out.append('\t\tdb\t' + ','.join(line))
    return out

HEAD = """; {name}: {what}
; Written by tools/gendata.py from CPP.EXE's image (see its docstring); regenerate rather
; than edit by hand until the data has real owners. Every name is symbols.tsv's.
"""
os.makedirs(os.path.join(R, 'src', 'data'), exist_ok=True)
def write(name, text):
    open(os.path.join(R, 'src', 'data', name), 'w', encoding='latin1', newline='').write(text.replace('\n', '\r\n'))

# ORDER.ASM
write('ORDER.ASM', HEAD.format(name='ORDER.ASM', what='linked first; declares CPP.EXE\'s segments, empty, in their order') + """;
; TLINK lays segments out by class in the order it first meets each class, and a segment
; where it first meets its name; this module is first in the link, so the code (CODE0, the
; start-up's segment, at 0000), DGROUP (_DATA at a paragraph, then _BSS), the stack and the
; two far data segments come out in CPP.EXE's order. RFILEIO.C and POOLS.C put their code in
; class FCODE (-zAFCODE), which comes after all the CODE segments, the run-time library's
; too, although those are linked after them (see their link notes).
CODE0		segment byte public 'CODE'
CODE0		ends
RFILEIO_TEXT	segment para public 'FCODE'
RFILEIO_TEXT	ends
DGROUP		group	_DATA,_BSS
_DATA		segment para public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
_STACK		segment para stack 'STACK'
_STACK		ends
FAR46		segment para public 'FAR_DATA'
FAR46		ends
FAR50		segment para public 'FAR_DATA'
FAR50		ends
		end
""")

# DGROUP _DATA pieces
bounds = [p[0] for p in PIECES] + [DATA_END]
manifest = []
total_pub = 0
for k, (start, after) in enumerate(PIECES):
    stop = bounds[k + 1]
    # cut at owned ranges: a piece stops where an owned range starts
    for a, b, _ in OWNED:
        if start < a < stop: stop = a
    labels = {o: ds_names[o] for o in ds_names if start <= o < stop}
    p = Piece(DGB, start, stop, labels, f'D{start:04X}')
    body = p.lines(after in REVERSED)
    pre = [f'{n}\tequ\t$-{start - o}\t\t; inside the previous module\'s data (DS:{o:04X})' for n, o in sorted(inner.get(start, []))]
    body = pre + body
    pubs = sorted([n for o in labels for n in labels[o]] + [n for n, o in inner.get(start, [])])
    total_pub += len(pubs)
    nm = f'D{start:04X}.ASM'
    txt = HEAD.format(name=nm, what=f'DGROUP _DATA DS:{start:04X}..{stop:04X}, linked after {after}') + '\n'
    txt += "_DATA\t\tsegment byte public 'DATA'\n_DATA\t\tends\n_BSS\t\tsegment word public 'BSS'\n_BSS\t\tends\nDGROUP\t\tgroup\t_DATA,_BSS\n"
    txt += ''.join(f'\t\textrn\t{n}:{t}\n' for n, t in sorted(p.externs))
    txt += ''.join(f'\t\tpublic\t{n}\n' for n in pubs)
    txt += "_DATA\t\tsegment byte public 'DATA'\n" + '\n'.join(body) + '\n_DATA\t\tends\n\t\tend\n'
    write(nm, txt); manifest.append((nm, after))

# _BSS and the stack
labels = {o: ds_names[o] for o in ds_names if DATA_END <= o <= BSS_END}
bl = []; cur = DATA_END
for o in sorted(labels) + [BSS_END]:
    if o > cur: bl.append(f'\t\tdb\t{o - cur} dup (?)'); cur = o
    if o in labels: bl += [f'{n}\tlabel\tbyte' for n in labels[o]]
late = [ds_names[o] for o in ds_names if o > BSS_END]
if late: sys.exit(f'DGROUP names past BSS_CLEAR_END: {late}')
pubs = sorted(n for o in labels for n in labels[o]); total_pub += len(pubs)
write('DBSS.ASM', HEAD.format(name='DBSS.ASM', what=f'DGROUP _BSS DS:{DATA_END:04X}..{BSS_END:04X} and the stack') + """;
; C0 clears _BSS from ERROR_COUNT up to BSS_CLEAR_END. The stack is its own segment
; (class STACK, the header's SS:SP 19AD:1800); C0 moves SS:SP to DGROUP:9030h, the same
; address.
_DATA		segment byte public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
DGROUP		group	_DATA,_BSS
""" + ''.join(f'\t\tpublic\t{n}\n' for n in pubs) + "_BSS\t\tsegment word public 'BSS'\n" + '\n'.join(bl) +
      f"\n_BSS\t\tends\n_STACK\t\tsegment para stack 'STACK'\n\t\tdb\t{STACK_SIZE} dup (?)\n_STACK\t\tends\n\t\tend\n")

# far data
fl = []; fpubs = []
for para, (seg, label, size) in FAR.items():
    labels = collections.defaultdict(list)
    labels[0].append(label)
    if para == 0x1B2D: labels[0].append('CPP_FAR_DATA')
    for (s, o), ns in far_names.items():
        if s == para: labels[o] += sorted(ns)
    p = Piece(para * 16, 0, size, labels, seg)
    fpubs += [n for o in labels for n in labels[o]]
    fl.append(f"{seg}\t\tsegment para public 'FAR_DATA'")
    fl += p.lines()
    if para == 0x1B41:
        # the header asks for one paragraph more than the file holds (min alloc 1): the
        # segment goes on past its initialised bytes; 12 bytes fill its last paragraph
        # (the exact length is not known: any 1..16 gives the same header)
        fl.append('\t\tdb\t12 dup (?)')
    fl.append(f'{seg}\t\tends')
    ext = sorted(e for e in p.externs if e[0] not in fpubs)
    fl = [f'\t\textrn\t{n}:{t}' for n, t in ext] + fl
total_pub += len(fpubs)
write('DFAR.ASM', HEAD.format(name='DFAR.ASM', what='the far data segments 1B2Dh and 1B41h, linked after OVREXMEM') + """;
; OVREXMEM.ASM's extended-memory and EMS data (BCC keeps it in the overlay manager's
; segment, __OVRGROUP); C0 also takes the paragraph of 1B2Dh as the heap's start
; (CPP_FAR_DATA). The descriptor table holds the "VDISK" signature.
_DATA		segment byte public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
DGROUP		group	_DATA,_BSS
""" + ''.join(f'\t\tpublic\t{n}\n' for n in sorted(fpubs)) + '\n'.join(fl) + '\n\t\tend\n')
manifest.append(('DFAR.ASM', 'OVREXMEM'))

manifest.append(('DBSS.ASM', None))
with open(os.path.join(R, 'src', 'data', 'PIECES.TSV'), 'w') as f:
    f.write('# data module\tlinked right after (None = last)\n')
    for n, a in manifest: f.write(f'{n}\t{a}\n')
print(f'{len(manifest) + 1} data modules, {total_pub} public names')

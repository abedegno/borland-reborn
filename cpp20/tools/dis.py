"""Disassemble CPP.EXE code: python3 tools/dis.py IMAGE_START IMAGE_END [FRAME]
Shows segment offsets (relative to FRAME, default the start's paragraph), bytes, MZ-relocated words marked R."""
import sys, os, struct
sys.path.insert(0, os.path.dirname(__file__)); import mzinfo
from iced_x86 import Decoder, Formatter, FormatterSyntax
d, hdr, end, rels = mzinfo.load(os.path.join(os.path.dirname(__file__), '..', 'toolchain/BC20/BIN/CPP.EXE'))
img = d[hdr:end]; a, b = int(sys.argv[1], 16), int(sys.argv[2], 16)
fr = int(sys.argv[3], 16) * 16 if len(sys.argv) > 3 else a & ~15
rs = set(rels); f = Formatter(FormatterSyntax.MASM)
for i in Decoder(16, img[a:b], ip=a - fr):
    x = i.ip + fr
    r = 'R' if any(x <= q < x + i.len for q in rs) else ' '
    print(f'{i.ip:04X} {img[x:x+i.len].hex():18s}{r} {f.format(i)}')

"""MZ facts for a DOS EXE: relocations, the segment frames they hold, far-call targets.
    python3 tools/mzinfo.py EXE"""
import struct, sys, collections
def load(path):
    d = open(path, 'rb').read()
    pages, last, nrel, hdrp = struct.unpack_from('<HHHH', d, 2)[0], None, None, None
    cblp, cp, nrel, hdrp = struct.unpack_from('<HHHH', d, 2)
    end = (cp - 1) * 512 + (cblp or 512)
    relo = struct.unpack_from('<H', d, 0x18)[0]
    hdr = hdrp * 16
    rels = []
    for i in range(nrel):
        o, s = struct.unpack_from('<HH', d, relo + 4 * i)
        rels.append(s * 16 + o)
    return d, hdr, end, rels
if __name__ == '__main__':
    d, hdr, end, rels = load(sys.argv[1])
    img = d[hdr:end]
    frames = collections.Counter(struct.unpack_from('<H', img, r)[0] for r in rels)
    print(f'hdr {hdr:#x} image {len(img):#x} relocs {len(rels)} in-order={rels==sorted(rels)}')
    for f, n in sorted(frames.items()): print(f'frame {f:#06x} file {hdr+f*16:#x}  refs {n}')

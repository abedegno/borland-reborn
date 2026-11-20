"""mz2yo.py CONFIG.py PROGRAM.EXE OUT.OVY: write a protected-mode image in the YO format of
the A.I. Architects extender (TKERNEL.EXE), as Borland C++ 2.0's TLINKX.OVY, from a DOS
program linked with TLINK that holds the image.

The file: a 64h-byte header; the descriptor table (8-byte 286 descriptors, a data and a code
descriptor for each segment, their bases relative to the image); the image; then the
overlay block TLINK writes for overlaid programs (`FBOV`, the size of the overlay data,
the offset of the segment table in the image, the number of segments, and the overlay
data).

The header:
    00h  'YO', version (word)
    04h  offset of the descriptor table      08h  number of descriptors
    0Ch  offset of the image                 10h  size of the image  14h  its memory size
    18h..63h  the start-up values (CONFIG's HEADER_TAIL: selectors, stack size, entry), as
         they are in the original; their meaning is not yet worked out in full.
The DOS program holds the image (CONFIG's IMAGE_SIZE bytes) and then the overlay block.
CONFIG gives the descriptors and the header's start-up values."""
import struct, sys

cfg = {}
exec(open(sys.argv[1]).read(), cfg)
exe = open(sys.argv[2], 'rb').read()
whole = exe[struct.unpack_from('<H', exe, 8)[0] * 16:]
img = whole[:cfg['IMAGE_SIZE']]
desc = b''.join(struct.pack('<HHBBH', lim, base & 0xFFFF, base >> 16, acc, 0) for lim, base, acc in cfg['DESCRIPTORS'])
hdr = bytearray(0x64)
dt = 0x64; io = dt + len(desc)
struct.pack_into('<2sHIIIII', hdr, 0, b'YO', cfg.get('VERSION', 6), dt, len(cfg['DESCRIPTORS']), io, len(img),
                 cfg.get('MEMSIZE', len(img)))
hdr[0x18:0x64] = bytes.fromhex(cfg['HEADER_TAIL'])
tail = whole[cfg['IMAGE_SIZE']:]
open(sys.argv[3], 'wb').write(bytes(hdr) + desc + img + tail)

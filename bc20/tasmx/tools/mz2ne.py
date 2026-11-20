"""mz2ne.py CONFIG.py PROGRAM.EXE STUB.EXE OUT.EXE: write a New Executable (NE) from a DOS
program linked with TLINK, laid out as Borland's NE programs of 1991 are (TASMX.EXE).

The DOS program holds the NE program's segments one after another, each at a paragraph,
and its relocation table holds the places where a segment's paragraph is used. Each such
place becomes a selector fixup in the NE file: for every pair of segments (the segment
holding the places, the segment they name) one relocation record, whose places are chained
through the segment's data from the highest offset down (the last holds FFFFh).

The file: the stub, padded with zeros to a 512-byte boundary, with its relocation table
offset set to 40h, its NE offset at 3Ch, and its size field set to the end of the NE
header's tables; the NE header, its segment table, resident names, an empty module
reference, import and entry table, and the non-resident names; then each segment at a
multiple of 1 << ALIGN, followed by its relocation records. The CRC field is the 32-bit sum
of the file's doublewords, computed with the field zero.

CONFIG names the segments (start in the DOS image, length, memory size, data or code), the
entry and stack (segment number and offset), the module name and description, and the
header's flags."""
import struct, sys

cfg = {}
exec(open(sys.argv[1]).read(), cfg)
exe = open(sys.argv[2], 'rb').read()
stub = bytearray(open(sys.argv[3], 'rb').read())
hdr = struct.unpack_from('<H', exe, 8)[0] * 16
img = bytearray(exe[hdr:])
SEGS = cfg['SEGS']          # [(start, length, memory size, is_data)]
ALIGN = cfg.get('ALIGN', 9)

def segno(a):
    for k, (s, n, m, dt) in enumerate(SEGS):
        if s <= a < s + max(n, m): return k
    raise SystemExit('address %X is in no segment' % a)
frames = {s >> 4: k for k, (s, n, m, dt) in enumerate(SEGS)}

# relocations -> chains
nrel = struct.unpack_from('<H', exe, 6)[0]; ro = struct.unpack_from('<H', exe, 0x18)[0]
chains = {}
for i in range(nrel):
    o, s = struct.unpack_from('<HH', exe, ro + 4 * i)
    a = s * 16 + o; k = segno(a)
    t = frames[struct.unpack_from('<H', img, a)[0]]
    chains.setdefault(k, {}).setdefault(t, []).append(a - SEGS[k][0])
data = []
for k, (s, n, m, dt) in enumerate(SEGS):
    b = bytearray(img[s:s + n])
    b += bytes(n - len(b))
    recs = b''
    for t in sorted(chains.get(k, {})):
        locs = sorted(chains[k][t], reverse=True)
        for x, y in zip(locs, locs[1:] + [0xFFFF]):
            struct.pack_into('<H', b, x, y)
        recs += struct.pack('<BBHBBH', 2, 0, locs[0], t + 1, 0, 0)
    data.append((bytes(b), struct.pack('<H', len(recs) // 8) + recs if recs else b''))

# the NE header and its tables
def pstr(s): return bytes([len(s)]) + s.encode('latin1')
segtab_off = 0x40
resnames = pstr(cfg['NAME']) + b'\0\0' + b'\0'
entry = b'\0\0'
nonres = pstr(cfg['DESCRIPTION']) + b'\0\0' + b'\0'
res_off = segtab_off + 8 * len(SEGS)
mod_off = res_off + len(resnames)
ent_off = mod_off
ne_off = (len(stub) + 511) & ~511
nonres_file = ne_off + ent_off + len(entry)
tables_end = nonres_file + len(nonres)
pos = (tables_end + (1 << ALIGN) - 1) >> ALIGN << ALIGN
segtab = b''; body = bytearray()
for k, (s, n, m, dt) in enumerate(SEGS):
    d, r = data[k]
    fl = cfg.get('SEGFLAGS', 0x0C40) | (0x100 if r else 0) | (1 if dt else 0)
    segtab += struct.pack('<4H', pos >> ALIGN, n & 0xFFFF, fl, m & 0xFFFF)
    blob = d + r
    end = pos + len(blob)
    body += bytes(pos - (tables_end + len(body))) + blob
    pos = (end + (1 << ALIGN) - 1) >> ALIGN << ALIGN if k + 1 < len(SEGS) else end
ne = bytearray(0x40)
cs, ip = cfg['ENTRY']; ss, sp = cfg['STACK']
struct.pack_into('<2sBBHHIHHHHHHHHHHHHHHHHIHHHBB', ne, 0, b'NE', 5, 10, ent_off, len(entry), 0,
                 cfg.get('FLAGS', 2), cfg['AUTODATA'], cfg.get('HEAP', 0), cfg.get('STACKSIZE', 0),
                 ip, cs, sp, ss, len(SEGS), 0, len(nonres),
                 segtab_off, res_off, res_off, mod_off, mod_off, nonres_file, 0, ALIGN, 0,
                 cfg.get('OS', 2), 0)
out = bytearray(stub) + bytes(ne_off - len(stub))
struct.pack_into('<HH', out, 2, tables_end % 512, (tables_end + 511) // 512)
struct.pack_into('<H', out, 0x18, 0x40)
struct.pack_into('<I', out, 0x3C, ne_off)
out += ne + segtab + resnames + entry + nonres + body
z = out + bytes((-len(out)) % 4)
struct.pack_into('<I', out, ne_off + 8, sum(struct.unpack_from('<%dI' % (len(z) // 4), z)) & 0xFFFFFFFF)
open(sys.argv[4], 'wb').write(out)

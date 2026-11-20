"""Pack an EXE into a self-relocating .COM the way Borland packed OBJXREF.COM, and unpack one.

    python3 pack.py pack OBJXREF.EXE OBJXREF.COM
    python3 pack.py unpack OBJXREF.COM OBJXREF.EXE

The packed file is the EXE's load image with three changes:

- Above a cut point the image is stored as a stream that a decompressor expands backwards,
  in place, from the top of the image down: each item is a count, then that many literal
  bytes, or a run of zeros (any run of 3 or more). Below the cut the image is stored as it
  is. The cut is the lowest zero run that leaves the decompressor room: reading the stream
  must never overtake writing the image.
- Each relocation's word holds a link to the next site with the same segment value, by file
  offset, highest first, ending in FFFFh. The trailer lists one chain per value, in the order
  each value first appears in the EXE's relocation table.
- The first 19h bytes are a stub that jumps to the trailer; the trailer keeps the bytes it
  replaced, the chains, and the code that restores, relocates and expands the image and
  starts it with the EXE's CS:IP and SS:SP.

The trailer's code is Borland's (TRAILER below); the fields marked in FIELDS are what depends
on the program."""
import re, struct, sys

STUB = bytes.fromhex('9c55568ccd83c5108db6000056be000056cb') + b'MEMORY$'
STUB_T, STUB_ENTRY = 0x0A, 0x0E      # words in STUB: the trailer's paragraph, its entry

TRAILER = bytes.fromhex(
    '57512ea32e01fca102002bc58cd78cde3bf7eb098bc42de500b104d3e83d6109'
    '7311b8084ccd211e2bc050ba1201b409cd21cb1ebe0e000e1f8ec52bffb91900'
    'f3a41f2e012e33012e012e26019090909090909090908d8651098ec5595f5e5d'
    '9d8ed0bc00019c5351525657551e1e8cc5b90200e31fbe27000e1fac8ae02ac0'
    '03c58ec0ad03c597ad97268b15ab8bfa4275f7e2e6beea000e1f16072bffb94b'
    '00f3a48d8600008ed8be1d938d8600008ec0bf0f95fd1651cbd1e772078cc02d'
    '00088ec0d1e672078cd82d00088ed8f9d1def9d1dfacd0e873038ae8ac8ac8d1'
    'f97304b000f3aaf3a475ce071f5d5f5e5a595b9db82e0c8ed0bce600b83412ea'
    '00000000')
ORG = 0x31                           # where TRAILER was assembled in OBJXREF.COM's trailer
# words in TRAILER, by index: offsets within the trailer (moved with the code) ...
MOVED = (0x04, 0x35, 0x46, 0x4B, 0x77, 0x96)
# ... and values
F_NEED, F_PARAS, F_GROUPS = 0x1E, 0x58, 0x72
F_SRCSEG, F_SRC, F_DSTSEG, F_DST = 0xA5, 0xAA, 0xAE, 0xB3
F_SS, F_SP, F_IP, F_CS = 0xF5, 0xFA, 0x100, 0x102
SAVED = 0x19                         # bytes the stub replaces


def enc(count, zero):
    v = count << 1 | zero
    return bytes([v << 1]) if v < 0x80 else bytes([v & 0xFF, (v >> 8) << 1 | 1])


def runs(img):
    out, i = [], 0
    for m in re.finditer(rb'\x00{3,}', img):
        if m.start() > i:
            out.append((i, m.start() - i, 0))
        out.append((m.start(), m.end() - m.start(), 1))
        i = m.end()
    if i < len(img):
        out.append((i, len(img) - i, 0))
    return out


def stream(img, rs, k):
    """The stream for runs k.. upward, with the file offset of each literal image byte;
    None if the decompressor would overtake itself."""
    out, where, saved = bytearray(enc(0, 0)), {}, -1
    base = rs[k][0]
    for st, ln, z in rs[k:]:
        for c0 in range(0, ln, 0x3FFF):
            c = min(0x3FFF, ln - c0)
            if not z:
                for j in range(c):
                    where[st + c0 + j] = base + len(out) + j
                out += img[st + c0:st + c0 + c]
            e = enc(c, z)
            out += e
            saved += (c if z else 0) - len(e)
            if saved < 0:
                return None
    return base, out, where


def pack(exe):
    (sig, last, pages, nrel, hdr, _, _, ss, sp, _, ip, cs, relofs) = struct.unpack_from('<2s12H', exe)
    size = pages * 512 - (512 - last if last else 0)
    img = bytearray(exe[hdr * 16:size])
    sites = [o + s * 16 for o, s in (struct.unpack_from('<HH', exe, relofs + 4 * i) for i in range(nrel))]
    rs = runs(bytes(img))
    for k in range(len(rs)):
        if rs[k][2] and (r := stream(img, rs, k)):
            break
    base, out, where = r
    f = bytearray(img[:base]) + out
    groups = {}
    for a in sites:
        groups.setdefault(struct.unpack_from('<H', img, a)[0], []).append(a)
    table = bytearray()
    for val, addrs in groups.items():
        link = 0xFFFF
        for a in sorted(addrs):
            fa = where.get(a, a)
            assert where.get(a + 1, a + 1) == fa + 1 and fa < 0x10000
            struct.pack_into('<H', f, fa, link)
            link = fa
        table += struct.pack('<BHH', 0, val, link)
    t = len(f) >> 4
    tofs = len(f) - t * 16           # where the saved bytes start in the trailer
    entry = tofs + SAVED + len(table)
    code = bytearray(TRAILER)
    for i in MOVED:
        struct.pack_into('<H', code, i, struct.unpack_from('<H', code, i)[0] - ORG + entry)
    paras = (len(img) + 15) >> 4
    for i, v in ((F_NEED, paras + 0x10), (F_PARAS, paras), (F_GROUPS, len(groups)),
                 (F_SRCSEG, 0), (F_SRC, len(f) - 1), (F_DSTSEG, 0), (F_DST, len(img) - 1),
                 (F_SS, ss), (F_SP, sp), (F_IP, ip), (F_CS, cs)):
        struct.pack_into('<H', code, i, v)
    assert len(img) <= 0x10000 and struct.unpack_from('<H', code, 0x35)[0] == tofs
    stub = bytearray(STUB)
    struct.pack_into('<H', stub, STUB_T, t)
    struct.pack_into('<H', stub, STUB_ENTRY, entry)
    trailer = f[:SAVED] + table + code
    f[:SAVED] = stub
    return bytes(f + trailer)


def unpack(com):
    t = struct.unpack_from('<H', com, STUB_T)[0]
    entry = struct.unpack_from('<H', com, STUB_ENTRY)[0]
    tr = com[t * 16:]
    code = tr[entry:]
    w = lambda i: struct.unpack_from('<H', code, i)[0]
    tofs = w(0x35)                   # mov si,tofs: the saved bytes
    mem = bytearray(0x10000)
    mem[:t * 16 + tofs] = com[:t * 16 + tofs]
    mem[:SAVED] = tr[tofs:tofs + SAVED]
    sites, si = [], tofs + SAVED
    for _ in range(w(F_GROUPS)):
        hi, val, a = struct.unpack_from('<BHH', tr, si)
        si += 5
        while a != 0xFFFF:
            nxt = struct.unpack_from('<H', mem, hi * 0x1000 + a)[0]
            struct.pack_into('<H', mem, hi * 0x1000 + a, val)
            sites.append(hi * 0x1000 + a)
            a = nxt
    s, d = w(F_SRC), w(F_DST)
    fileofs = {}
    while True:
        b = mem[s]; s -= 1
        if b & 1:
            v = (b >> 1) << 8 | mem[s]; s -= 1
        else:
            v = b >> 1
        c = v >> 1
        for _ in range(c):
            if v & 1:
                mem[d] = 0
            else:
                fileofs[s] = d
                mem[d] = mem[s]; s -= 1
            d -= 1
        if c == 0:
            break
    img = bytes(mem[:w(F_DST) + 1])
    sites = sorted(fileofs.get(a, a) for a in sites)
    hdrpara = max(2, (0x1C + 4 * len(sites) + 15) >> 4)
    total = hdrpara * 16 + len(img)
    hdr = bytearray(hdrpara * 16)
    struct.pack_into('<2s13H', hdr, 0, b'MZ', total % 512, (total + 511) // 512, len(sites), hdrpara,
                     0, 0xFFFF, w(F_SS), w(F_SP), 0, w(F_IP), w(F_CS), 0x1C, 0)
    for i, a in enumerate(sites):
        struct.pack_into('<HH', hdr, 0x1C + 4 * i, a & 15, a >> 4)
    return bytes(hdr) + img


if __name__ == '__main__':
    op, src, dst = sys.argv[1:4]
    data = open(src, 'rb').read()
    open(dst, 'wb').write(pack(data) if op == 'pack' else unpack(data))

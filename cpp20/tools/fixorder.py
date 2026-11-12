"""Put the fixups of one object in CPP.EXE's order before the link (the one link step that
is not a plain TLINK run).

    python3 tools/fixorder.py IN.OBJ OUT.OBJ STEM     (tools/link.py calls reorder())

TLINK writes the relocation table in the order of the objects' fixups. For one object,
HPSHRINK (src/heap/HPSHRINK.C), no source we can write gives CPP.EXE's order; tools/
fixorder.tsv gives the order and the evidence. This step changes only the order of the
fixup subrecords inside that object's FIXUPP record: never a byte of a subrecord, a target,
a LEDATA record or any other record. It refuses (exit 1) when:
  - the object's fixups are not exactly the set in the table (a changed source must be
    looked at again, not silently reordered);
  - the fixups are spread over more than one FIXUPP record, or the record holds THREAD
    subrecords (neither happens for HPSHRINK; a THREAD would change how later subrecords
    read, so they could not be moved freely).
The record checksum is a byte sum, so a permutation keeps it valid."""
import os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
TABLE = os.path.join(HERE, 'fixorder.tsv')

def load_table(path=TABLE):
    """{object stem: [data offsets in the wanted order]} from the table."""
    t = {}
    for line in open(path):
        line = line.split('#', 1)[0].strip()
        if not line: continue
        stem, offs = line.split('\t', 1)
        t[stem.upper()] = [int(x, 16) for x in offs.split()]
    return t

def _index(b, i):
    return (i + 2) if b[i] & 0x80 else (i + 1)

def _subrecords(body):
    """Split a FIXUPP body into (data offset within the LEDATA, bytes) subrecords."""
    out = []; i = 0
    while i < len(body):
        lo = body[i]
        if not lo & 0x80: raise ValueError('THREAD subrecord in the FIXUPP record')
        start = i; off = ((lo & 0x03) << 8) | body[i + 1]; i += 2
        fixdat = body[i]; i += 1
        if not fixdat & 0x80:                  # frame given here, not by a thread
            fm = (fixdat >> 4) & 7
            if fm in (0, 1, 2): i = _index(body, i)
            elif fm == 3: i += 2
        if not fixdat & 0x08:                  # target given here, not by a thread
            tm = fixdat & 3
            if tm in (0, 1, 2): i = _index(body, i)
            else: i += 2
        if not fixdat & 0x04: i += 2           # P=0: a displacement follows
        out.append((off, body[start:i]))
    if i != len(body): raise ValueError('FIXUPP record does not parse')
    return out

def reorder(data, want):
    """Return the object bytes with its one FIXUPP record's subrecords in the order of
    `want` (data offsets). Raises ValueError when the object does not fit the table."""
    recs = []; i = 0
    while i < len(data):
        t = data[i]; n = data[i + 1] | data[i + 2] << 8
        recs.append((i, t, n)); i += 3 + n
    fix = [r for r in recs if r[1] in (0x9C, 0x9D)]
    if len(fix) != 1: raise ValueError(f'{len(fix)} FIXUPP records, the table needs exactly one')
    if fix[0][1] != 0x9C: raise ValueError('32-bit FIXUPP record')
    k = recs.index(fix[0])
    led = recs[k - 1]
    if led[1] != 0xA0: raise ValueError('the FIXUPP record does not follow a LEDATA record')
    base = data[led[0] + 4] | data[led[0] + 5] << 8   # LEDATA offset (segment index < 80h)
    if data[led[0] + 3] & 0x80: raise ValueError('two-byte segment index in LEDATA')
    at, _, n = fix[0]
    body = data[at + 3:at + 3 + n - 1]
    subs = _subrecords(body)
    have = [base + off for off, _ in subs]
    if sorted(have) != sorted(want) or len(set(have)) != len(have):
        raise ValueError('the object\'s fixups differ from the table: object '
                         + ' '.join(f'{x:X}' for x in have))
    by = {base + off: raw for off, raw in subs}
    new = b''.join(by[o] for o in want)
    assert len(new) == len(body) and sorted(new) == sorted(body)
    return data[:at + 3] + new + data[at + 3 + n - 1:]

def main(argv):
    if len(argv) != 3: sys.exit(__doc__)
    src, dst, stem = argv
    t = load_table()
    if stem.upper() not in t: sys.exit(f'{stem} is not in {TABLE}')
    try: out = reorder(open(src, 'rb').read(), t[stem.upper()])
    except ValueError as e: print(f'fixorder: {stem}: {e}'); return 1
    open(dst, 'wb').write(out); return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))

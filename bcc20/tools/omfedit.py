"""Small OMF editing helpers for the modding link (tools/modlink.py).

An object is a list of (type, body) records.  The helpers rename segment names, add
public definitions and read what an object defines and references; write() puts the
records back with fresh lengths and checksums.
"""
from pathlib import Path


def read(path):
    data = Path(path).read_bytes()
    out, i = [], 0
    while i + 3 <= len(data):
        kind = data[i]
        length = data[i + 1] | data[i + 2] << 8
        out.append((kind, data[i + 3:i + 3 + length - 1]))
        i += 3 + length
        if kind in (0x8A, 0x8B):
            break
    return out


def write(records, path):
    blob = bytearray()
    for kind, body in records:
        rec = bytearray([kind]) + (len(body) + 1).to_bytes(2, "little") + body
        rec.append((-sum(rec)) & 0xFF)
        blob += rec
    Path(path).write_bytes(bytes(blob))


def index(body, j):
    v = body[j]
    if v & 0x80:
        return ((v & 0x7F) << 8) | body[j + 1], j + 2
    return v, j + 1


def put_index(v):
    return bytes([v]) if v < 0x80 else bytes([0x80 | v >> 8, v & 0xFF])


def lnames(records):
    names = [None]
    for kind, body in records:
        if kind == 0x96:
            j = 0
            while j < len(body):
                n = body[j]
                names.append(body[j + 1:j + 1 + n].decode("latin1"))
                j += 1 + n
    return names


def segments(records):
    """[(name, class, length)] in SEGDEF order (segment index = position + 1)."""
    names = lnames(records)
    out = []
    for kind, body in records:
        if kind == 0x98:
            attr = body[0]
            j = 1 + (3 if attr >> 5 == 0 else 0)
            length = body[j] | body[j + 1] << 8
            j += 2
            name, j = index(body, j)
            cls, j = index(body, j)
            out.append((names[name], names[cls], length))
    return out


def groups(records):
    names = lnames(records)
    out = []
    for kind, body in records:
        if kind == 0x9A:
            g, _ = index(body, 0)
            out.append(names[g])
    return out


def externs(records):
    out = []
    for kind, body in records:
        if kind in (0x8C, 0xB4):  # EXTDEF, LEXTDEF
            j = 0
            while j < len(body):
                n = body[j]
                out.append(body[j + 1:j + 1 + n].decode("latin1"))
                j += 1 + n
                _, j = index(body, j)
    return out


def publics(records):
    """[(name, segment index, offset)]"""
    out = []
    for kind, body in records:
        if kind in (0x90, 0xB6):
            group, j = index(body, 0)
            seg, j = index(body, j)
            if seg == 0:
                j += 2
            while j < len(body):
                n = body[j]
                name = body[j + 1:j + 1 + n].decode("latin1")
                j += 1 + n
                off = body[j] | body[j + 1] << 8
                j += 2
                _, j = index(body, j)
                out.append((name, seg, off))
    return out


def rename_lnames(records, mapping):
    """Rename LNAMES strings: mapping old -> new.  Returns the new record list."""
    out = []
    for kind, body in records:
        if kind == 0x96:
            parts, j = [], 0
            while j < len(body):
                n = body[j]
                name = body[j + 1:j + 1 + n].decode("latin1")
                name = mapping.get(name, name)
                parts.append(bytes([len(name)]) + name.encode("latin1"))
                j += 1 + n
            body = b"".join(parts)
        out.append((kind, body))
    return out


def add_publics(records, defs, group=0):
    """Add PUBDEF records: defs = [(name, segment index, offset)], before MODEND."""
    new = []
    for name, seg, off in defs:
        new.append((0x90, put_index(group) + put_index(seg) + bytes([len(name)])
                    + name.encode("latin1") + off.to_bytes(2, "little") + b"\x00"))
    end = next(i for i, (k, _) in enumerate(records) if k in (0x8A, 0x8B))
    # PUBDEFs must precede the first data record in Borland objects only by convention;
    # TLINK accepts them anywhere before MODEND.
    return records[:end] + new + records[end:]




def set_alignment(records, segment_index, align):
    """Set a SEGDEF's alignment (1 byte, 2 word, 3 paragraph); segment_index counts from 1."""
    out, seen = [], 0
    for kind, body in records:
        if kind == 0x98:
            seen += 1
            if seen == segment_index:
                body = bytes([(body[0] & 0x1F) | (align << 5)]) + body[1:]
        out.append((kind, body))
    return out


def _fixups(body):
    """Yield (start, end, locat, target_method, target_index_span) for each FIXUP subrecord."""
    j = 0
    while j < len(body):
        start = j
        b = body[j]
        if not b & 0x80:          # THREAD subrecord
            method = (b >> 2) & 7
            j += 1
            if not (b & 0x40 and method >= 4):
                if (b & 0x40) or method < 3:
                    _, j = index(body, j)
            continue
        locat = (b << 8) | body[j + 1]
        j += 2
        fixdat = body[j]
        j += 1
        if not fixdat & 0x80 and ((fixdat >> 4) & 7) < 3:
            _, j = index(body, j)
        span = None
        if not fixdat & 0x08:
            k = j
            _, j = index(body, j)
            span = (k, j)
        if not fixdat & 0x04:
            j += 2
        yield start, j, locat, fixdat & 0x03 | (fixdat & 0x04), span


def retarget_offsets(records, extern_name, new_name):
    """Point the 16-bit offset fixups (not base or pointer ones) that target extern_name at a
    new external new_name, added to the object.  Returns (records, count)."""
    names = externs(records)
    old = names.index(extern_name) + 1
    new = len(names) + 1
    out, count = [], 0
    last_ext = max(i for i, (k, _) in enumerate(records) if k in (0x8C, 0xB4))
    for i, (kind, body) in enumerate(records):
        if kind == 0x9C:
            pieces, cursor = [], 0
            for start, end, locat, method, span in _fixups(body):
                location = (locat >> 10) & 0x0F
                if span and method & 3 == 2 and location == 1 and index(body, span[0])[0] == old:
                    pieces.append(body[cursor:span[0]] + put_index(new))
                    cursor = span[1]
                    count += 1
            body = b"".join(pieces) + body[cursor:]
        out.append((kind, body))
        if i == last_ext:
            out.append((0x8C, bytes([len(new_name)]) + new_name.encode("latin1") + b"\x00"))
    return out, count

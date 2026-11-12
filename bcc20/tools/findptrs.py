"""Find the near pointers in BCC.EXE's initialised data, for map/data-pointers.tsv.

    python3 tools/findptrs.py            print the table (redirect it to map/data-pointers.tsv)

Near pointers carry no relocation, so the data alone does not say which words are
addresses.  This looks for them where the evidence is structural:

- inside each named data item (from its offset to the next name), a word field that repeats
  with a fixed stride, at least three records in a row, every record's value either 0 or
  an address of the kind below (all of one kind, at least three different addresses, no
  word of two equal bytes, and at most half of them ending in a 0 byte: a table of small
  words read one byte out of step looks like that); words inside text are skipped;
- a named item that is a single word holding such an address.

Kinds: `data`, the start of a 0-terminated string (the byte before it is 0, or it is a named
item) or of a named item, in _DATA or _BSS; `code`, the start of a function of a module
that refers to the item (the table's own users call through it, near, inside their own
segment), as an offset in that module's segment (its code block, or its overlay).

Each line: offset, target, kind, evidence.  Code targets are written as function names and
resolved by tools/modlink.py at link time; data targets as names (DATA_xxxx when the item
has none).  The modding build's --pad-data and --pad-code tests check the result.
"""
import re
import struct
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402
import omfedit  # noqa: E402

DATA_END = modlink.DATA_END
# Items read and found to be byte tables, whose consecutive bytes (0A 0B, 10 11) pass for
# addresses: the operator code of each token.
NOT_POINTERS = {"TOKEN_OPERATOR_CODE", "OPERATOR_BY_TOKEN"}
BSS_END = DATA_END + 12208


def main():
    modules = modlink.load_modules()
    original = modlink.Original()
    layout = modlink.Layout(modules, original)
    ds = original.dgroup
    image = original.image
    syms = modlink.symbols()
    names = defaultdict(list)
    for n, a in syms.items():
        if a.startswith("DS:"):
            names[int(a[3:], 16)].append(n)
    starts = sorted(names)
    relocated = set()
    for r in original.relocations:
        if ds <= r < ds + DATA_END:
            relocated.update(range(r - ds - 2, r - ds + 2))
    # who refers to each data name
    users = defaultdict(set)
    for m in modules:
        for name in omfedit.externs(omfedit.read(modlink.ROOT / "build-source" / m.stem / f"{m.stem}.OBJ")):
            users[name].add(m)

    # bytes of text: printable runs of three or more that end in a 0 (a word there is text)
    text = set()
    run = 0
    for off in range(0, DATA_END):
        b = image[ds + off]
        if 0x20 <= b < 0x7F or b in (9, 10, 13):
            run += 1
        else:
            if b == 0 and run >= 3:
                text.update(range(off - run, off + 1))
            run = 0

    def word(off):
        return struct.unpack_from("<H", image, ds + off)[0]

    def data_target(v):
        if v in names and v >= 0x40:
            return names[v][0]
        if 0x40 <= v < DATA_END and image[ds + v - 1] == 0 and 0x20 <= image[ds + v] < 0x7F:
            end = image.index(b"\0", ds + v)
            if all(0x20 <= b < 0x7F or b in (9, 10, 13) for b in image[ds + v:end]):
                return f"DATA_{v:04X}"
        return None

    def code_targets(item_users):
        """{segment-relative offset: function name} over the modules that use the item."""
        out = {}
        for m in item_users:
            if m.overlay:
                para = layout.overlay_of[m.stem]
                base = original.stub_file_offset(para) + modlink.OVERLAY_BASE
                origin = m.base - base
            else:
                origin = m.org
            for name, off in m.functions:
                out[origin + off] = name
        return out

    found = {}
    runs = []
    fields = []
    record_size = {}   # item -> {stride: entries} of its code-pointer fields (its record size)
    for i, start in enumerate(starts):
        if start >= DATA_END:
            break
        stop = min(starts[i + 1] if i + 1 < len(starts) else DATA_END, DATA_END)
        if set(names[start]) & NOT_POINTERS:
            continue
        item_users = set().union(*(users.get(n, set()) for n in names[start]))
        codes = code_targets(item_users)
        size = stop - start
        if size == 2 and start not in relocated and start not in text:
            v = word(start)
            t = data_target(v)
            if t:
                found[start] = (t, "data", "a one-word item")
            elif v and v in codes:
                found[start] = (codes[v], "code", "a one-word item")
            continue
        for stride in range(2, 33):
            for phase in range(0, stride):
                run = []
                off = start + phase
                while off + 2 <= stop:
                    if off in relocated or off in text or off + 1 in text:
                        run = []
                        off += stride
                        continue
                    v = word(off)
                    kind = None
                    if v and (v & 0xFF) == v >> 8:
                        kind = None   # a repeated byte, as in byte tables, not an address
                    elif v and data_target(v):
                        kind = ("data", data_target(v))
                    elif v and v in codes:
                        kind = ("code", codes[v])
                    elif v == 0:
                        kind = ("zero", None)
                    if kind is None:
                        run = []
                    else:
                        run.append((off, kind))
                        real = [k for _, k in run if k[0] != "zero"]
                        round_ = sum(1 for o, k in run if k[0] != "zero" and word(o) & 0xFF == 0)
                        if (len(real) >= 3 and len({k[0] for k in real}) == 1
                                and len({k[1] for k in real}) >= 3 and round_ * 2 <= len(real)):
                            for o, k in run:
                                if k[0] != "zero" and o not in found:
                                    found[o] = (k[1], k[0], f"field of a {stride}-byte record in {names[start][0]}")
                            if real[0][0] == "code":
                                sizes = record_size.setdefault(start, {})
                                sizes[stride] = max(sizes.get(stride, 0), len(real))
                            if real[0][0] == "data":
                                runs.append((start, stop, stride, [o for o, k in run if k[0] != "zero"]))
                                fields.append((start, stop, stride, phase))
                    off += stride
    # Within one item, a stride far weaker than the item's strongest is chance (a few words
    # of a record table that happen to fit a second stride): drop it.
    by_item = defaultdict(lambda: defaultdict(list))
    for off, (target, kind, why) in found.items():
        m = re.match(r"field of a (\d+)-byte record in (\S+)", why)
        if m:
            by_item[m.group(2)][int(m.group(1))].append(off)
    for item, strides in by_item.items():
        best = max(len(v) for v in strides.values())
        for stride, offs in strides.items():
            if len(offs) < 4 and len(offs) * 4 < best:
                for off in offs:
                    del found[off]
    runs = [r for r in runs if all(o in found for o in r[3])]
    # Extend each plain array of data pointers (stride 2, four or more found) or long record
    # table (six or more) to its neighbours in the same item whose values lie in its address
    # range: pointers to byte tables, and to string tails (BCC shares the tails of strings).
    for start, stop, stride, offsets in runs:
        if not (stride == 2 and len(offsets) >= 4 or len(offsets) >= 6):
            continue    # plain arrays of pointers, or long record tables
        values = [word(o) for o in offsets]
        low, high = min(values) - 0x40, max(values) + 0x40
        for direction in (-stride, stride):
            o = min(offsets) - stride if direction < 0 else max(offsets) + stride
            while start <= o and o + 2 <= stop and o not in text and o + 1 not in text and o not in relocated:
                v = word(o)
                if v & 0xFF == 0 or not low <= v <= high:
                    break
                if o not in found:
                    found[o] = (names[v][0] if v in names else f"DATA_{v:04X}", "data",
                                f"next to a pointer field of {names[start][0]}, in its range")
                o += direction
    # Fill each data-pointer field of a plain array (stride 2) or of a record table whose
    # record size its code pointers show: every record has a pointer in that field, so a word
    # there that lies in DGROUP (and is not text) is one too, though it points at neither a
    # string nor a named item (a sub-table, say).
    for start, stop, stride, phase in set(fields):
        sizes = record_size.get(start, {})
        best = max(sizes.values()) if sizes else 0
        size = min((k for k, n in sizes.items() if n * 2 >= best), default=0)
        if not (stride == 2 or stride == size):
            continue    # only plain arrays, and records whose size the code pointers show
        if not any(o in found for o in range(start + phase, stop, stride)):
            continue    # the field was dropped above
        off = start + phase
        while off + 2 <= stop:
            v = word(off)
            if (off not in found and off - 1 not in found and off + 1 not in found and v >= 0x100
                    and v < BSS_END and v & 0xFF != v >> 8 and off not in text and off + 1 not in text
                    and off not in relocated):
                found[off] = (names[v][0] if v in names else f"DATA_{v:04X}", "data",
                              f"in a pointer field of {names[start][0]} ({stride}-byte records)")
            off += stride
    # two candidates may overlap by a byte (records of odd stride): keep the earlier
    for off in sorted(found):
        if off in found and off + 1 in found:
            del found[off + 1]
    print("# offset\ttarget\tkind\tevidence  (tools/findptrs.py)")
    for off in sorted(found):
        target, kind, why = found[off]
        print(f"{off:04X}\t{target}\t{kind}\t{why}")


if __name__ == "__main__":
    main()

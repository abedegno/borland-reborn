"""Write src/data/DGROUP.ASM, BCC.EXE's data segment as assembly source, from the original.

    python3 tools/gendata.py

No recovered source defines BCC's data: every C and assembly module refers to it by name.
This writes it once, as a source the modding build assembles (tools/modlink.py) and a
person can edit: _DATA's bytes in their original order, text quoted, every name of
symbols.tsv public at its original offset, far pointers written as the functions they
point at, segment words as DGROUP, and the near pointers listed in map/data-pointers.tsv
written as the items they point at.  Then the _BSS layout and the stack.

The result is checked by the modding build: with nothing edited, its data comes out equal
to the original's, but for the relocated words (tools/modlink.py, "data check").

map/data-pointers.tsv: offset (hex, DS) of a word in _DATA, the name it points at (a
symbols.tsv name, or DATA_xxxx for an unnamed item, which gets a label), and the evidence.
"""
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402

ROOT = modlink.ROOT
TARGET = ROOT / "src" / "data" / "DGROUP.ASM"
POINTERS = ROOT / "map" / "data-pointers.tsv"
PAD_POINT = 0x0100   # tools/modlink.py --pad-data inserts its test padding at the first item from here

HEADER = """\
; DGROUP.ASM: BCC.EXE's data segment (DGROUP), as source.
;
; Not matched by the gate (it has no target line): the exact link takes the data from the
; layout sources in linkgroups/.  The modding build (tools/modlink.py) assembles this file
; instead, and checks that with nothing edited it gives the original's data.
;
; Written by tools/gendata.py from the original image.  Every name of symbols.tsv is public
; at its original DGROUP offset: the C and assembly sources refer to their data by these
; names, never by number.  Far pointers are written as the functions they point at (TLINK
; points them through the overlay stubs for overlaid code), segment words as DGROUP, and
; the near pointers of map/data-pointers.tsv as the items they point at (a pointer into code
; stays a number tagged "; @code FUNCTION": the modding build writes the function's offset
; in the new layout there, from a first link's map).  Other words are
; kept as bytes: their types are not known, and a near pointer that is still a number stays
; right only while what it points at keeps its offset.  So add data at the end of _DATA (or
; of _BSS), or first write every pointer into the region you change as a name.
"""


def pointers():
    """{offset: (target, kind)} from map/data-pointers.tsv."""
    out = {}
    if POINTERS.exists():
        for line in POINTERS.read_text().splitlines():
            if line and not line.startswith("#"):
                offset, name, kind, *_ = line.split("\t")
                out[int(offset, 16)] = (name, kind)
    return out


def main():
    modules = modlink.load_modules()
    original = modlink.Original()
    layout = modlink.Layout(modules, original)
    syms = modlink.symbols()
    import tomllib
    aliases = tomllib.loads((ROOT / "exhume.toml").read_text()).get("names", {}).get("extern_aliases", {})
    data_names = {}
    for name, address in syms.items():
        if address.startswith("DS:"):
            data_names[name] = int(address[3:], 16)
        elif not address.startswith("OVL:") and int(address.split(":")[0], 16) * 16 == original.dgroup:
            data_names[name] = int(address.split(":")[1], 16)
    for alias, canonical in aliases.items():
        if canonical in data_names:
            data_names[alias] = data_names[canonical]
    invented = {}
    region = modlink.Region(original, layout, invented, original.dgroup, modlink.DATA_END, origin=original.dgroup)
    by_offset = defaultdict(list)
    for name, offset in data_names.items():
        by_offset[offset].append(name)
    near = pointers()
    for offset, (name, kind) in near.items():
        if kind == "code":
            # a near pointer into code: kept as its number, which tools/modlink.py rewrites
            # with the function's offset in the new layout (TLINK cannot be given an offset
            # into an overlay without making it a stub entry)
            value = int.from_bytes(original.image[original.dgroup + offset:original.dgroup + offset + 2], "little")
            region.items[offset] = (2, f"dw\t0{value:04X}h\t; @code {name}")
            continue
        if name.startswith("DATA_") and name not in data_names:
            target = int(name[5:], 16)
            data_names[name] = target
            by_offset[target].append(name)
        region.items[offset] = (2, f"dw\toffset DGROUP:{name}")
    # targets of map/code-numbers.tsv: labelled so the modding build can find them
    for line in (ROOT / "map" / "code-numbers.tsv").read_text().splitlines():
        if line and not line.startswith("#"):
            target = int(line.split("\t")[2], 16)
            name = f"DATA_{target:04X}"
            if name not in data_names:
                data_names[name] = target
                by_offset[target].append(name)
    # far pointers into DGROUP itself: the segment word follows the offset word, which is
    # written as the item it points at, so both halves follow the layout
    image = original.image
    for offset, (length, text) in sorted(region.items.items()):
        if text == "dw\tDGROUP" and offset - 2 not in region.items:
            target = int.from_bytes(image[original.dgroup + offset - 2:original.dgroup + offset], "little")
            name = by_offset[target][0] if by_offset.get(target) else f"DATA_{target:04X}"
            if name not in data_names:
                data_names[name] = target
                by_offset[target].append(name)
            del region.items[offset]
            region.items[offset - 2] = (4, f"dw\toffset DGROUP:{name},DGROUP")
    for offset, names in by_offset.items():
        if offset < modlink.DATA_END:
            region.labels[offset].extend(sorted(names))
    if invented:
        raise SystemExit(f"far pointers into code with no name: {invented}")
    bss_end = modlink.DATA_END + 12208
    lines = HEADER.splitlines()
    lines.append("DGROUP\t\tgroup\t_DATA,_BSS,_BSSEND,_STACK")
    lines += [f"\t\textrn\t{n}:far" for n in sorted(region.externs)]
    lines += [f"\t\tpublic\t{n}" for n in sorted(data_names)]
    lines.append("_DATA\t\tsegment para public 'DATA'")
    # the padding goes between two items: before the first named one from PAD_POINT on (a
    # DATA_xxxx label may be inside a table or a string)
    pad = min(o for o, names in region.labels.items()
              if o >= PAD_POINT and any(not n.startswith("DATA_") for n in names))
    lines += region.lines(0, pad)
    lines.append("; PAD-POINT (tools/modlink.py --pad-data inserts its test padding here)")
    lines += region.lines(pad, modlink.DATA_END)
    lines.append("; END-OF-DATA (new initialised data goes here; tools/modlink.py --pad-at END tests it)")
    lines += ["_DATA\t\tends", "_BSS\t\tsegment word public 'DATA'"]
    start = modlink.Region(original, layout, invented, original.dgroup + modlink.DATA_END, 6)
    for offset in range(modlink.DATA_END, modlink.DATA_END + 6):
        start.labels[offset - modlink.DATA_END].extend(sorted(by_offset.get(offset, ())))
    lines += start.lines()
    cursor = modlink.DATA_END + 6
    for offset in sorted(o for o in by_offset if modlink.DATA_END + 6 <= o < bss_end) + [bss_end]:
        if offset > cursor:
            lines.append(f"\t\tdb\t{offset - cursor} dup (?)")
            cursor = offset
        if offset < bss_end:
            lines += [f"{n}\tlabel\tbyte" for n in sorted(by_offset[offset])]
    # _BSSEND (16 bytes, cleared by C0 up to BSS_CLEAR_END) and the stack (from STACK_BOTTOM)
    lines += ["_BSS\t\tends", "_BSSEND\t\tsegment word public 'DATA'"]
    cursor = bss_end
    for offset in sorted(o for o in by_offset if bss_end <= o < bss_end + 16) + [bss_end + 16]:
        if offset > cursor:
            lines.append(f"\t\tdb\t{offset - cursor} dup (0)")
            cursor = offset
        if offset < bss_end + 16:
            lines += [f"{n}\tlabel\tbyte" for n in sorted(by_offset[offset])]
    lines += ["_BSSEND\t\tends", "_STACK\t\tsegment word stack 'STACK'"]
    lines += [f"{n}\tlabel\tbyte" for n in sorted(by_offset.get(bss_end + 16, ()))]
    lines += ["\t\tdb\t4500 dup (?)", "_STACK\t\tends", "\t\tend"]
    late = [o for o in by_offset if o > bss_end + 16]
    if late:
        raise SystemExit(f"data names past the stack's start: {[by_offset[o] for o in late]}")
    TARGET.parent.mkdir(exist_ok=True)
    TARGET.write_bytes(("\r\n".join(lines) + "\r\n").encode("latin1"))
    print(f"{TARGET.relative_to(ROOT)}: {len(data_names)} names, {len(near)} near pointers, "
          f"{len(region.externs)} far pointer targets")


if __name__ == "__main__":
    main()

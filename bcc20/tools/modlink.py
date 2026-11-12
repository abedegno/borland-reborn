"""The modding link: BCC.EXE from the recovered sources, laid out by TLINK itself.

The exact link (tools/integrate_sources.py) rebuilds Borland's BCC.EXE byte for byte by
pinning every reference to its original address.  That proves the sources but fixes the
layout: no function may change size.  This link instead hands TLINK the compiled objects
as they are and lets it lay the program out, so any source may change.

    python3 tools/modlink.py [--src DIR] [--out DIR]
        link build-source/MODLINK/run/BCC.EXE (or DIR/run/BCC.EXE); with --src, the files of
        DIR (a copy of src/) that differ from src/ are compiled and used instead

docs/MODDING.md explains the build, how it is checked (tools/modtest.py) and its limits.

It needs the objects the gate compiles (build-source/<module>/<module>.OBJ) and the
original BCC.EXE (to read the data segment and the far pointers in it).  What it adds:

- one code segment name per original code block: modules that shared a block in the
  original (and call each other near) get the block's name, CODE_n for resident code and
  OVR_n for an overlay, so TLINK puts them in one segment again;
- public names for the labels other modules use inside a module (mid-function entry
  points, the overlay manager's internals), at the offsets the target tables give;
- MODDATA.ASM, the data segment: the original's initialised data and BSS layout with every
  data name public, far pointers written as the functions they point at, and segment
  words as DGROUP;
- MODORDER.ASM, the segment order (DOSSEG, then the code blocks in original order).

Near pointers inside the data stay numbers: the data segment keeps its original layout,
so they stay right as long as nothing is inserted into it (add new data at its end).
"""
import csv
import re
import shutil
import struct
import subprocess
import sys
import tomllib
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import omfedit  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "build-source" / "MODLINK"
ORIGINAL = ROOT / "toolchain" / "BC20" / "BIN" / "BCC.EXE"
OVERLAY_BASE = 0x18CF0  # target-table base of an overlay = its stub's file offset + this
DATA_END = 0x5C90       # _DATA is DGROUP:0000..5C8F; _BSS follows
EXHUME = next(p for p in (ROOT / "exhume", ROOT.parent / "exhume") if (p / "tools").is_dir())


def rows(path):
    with open(path, newline="") as f:
        return list(csv.DictReader(f))


# ---------------------------------------------------------------- the sources

class Module:
    def __init__(self, stem, target):
        self.stem, self.target = stem, target
        head, *body = (ROOT / "targets" / f"{target}.tsv").read_text().splitlines()
        m = re.search(r"segment (\S+) base (0x[0-9A-Fa-f]+) size (0x[0-9A-Fa-f]+) org (0x[0-9A-Fa-f]+)", head)
        self.segment = m.group(1)
        self.base, self.size, self.org = (int(m.group(i), 16) for i in (2, 3, 4))
        self.functions = []
        self.sizes = {}   # function start -> size, from the target table
        for line in body:
            if line and not line.startswith("#"):
                parts = line.split("\t")
                self.functions.append((parts[0], int(parts[2], 16)))
                self.sizes[int(parts[2], 16)] = int(parts[3], 16)
        self.overlay = target.startswith("ovr")
        self.block = None if self.overlay else re.match(r"(CODE_\d+)", self.segment).group(1)


def load_modules():
    out = []
    for path in sorted((ROOT / "src").rglob("*")):
        if path.suffix.upper() not in (".C", ".ASM") or "include" in path.parts:
            continue
        head = path.read_bytes()[:4000].decode("latin1")
        found = re.search(r"/\*\s*target:\s*(\S+)", head)
        if found:   # src/data/DGROUP.ASM has none: the link takes it separately
            out.append(Module(path.stem.upper(), found.group(1)))
    return out


# ---------------------------------------------------------------- the original EXE

class Original:
    def __init__(self):
        data = ORIGINAL.read_bytes()
        count, header = struct.unpack_from("<HH", data, 6)
        table = struct.unpack_from("<H", data, 0x18)[0]
        self.image = data[header * 16:]
        self.relocations = sorted(o + s * 16 for o, s in
                                  (struct.unpack_from("<HH", data, table + 4 * i) for i in range(count)))
        self.segments = {int(r["segment"], 16): r for r in rows(ROOT / "original-exeinfo.csv")}
        info = rows(ROOT / "memory_blocks" / "index.csv")
        self.block_para = {r["block"]: int(r["start"].split(":")[0], 16) - 0x1000
                           for r in info if r["block"].startswith("CODE_")}
        self.dgroup = next(s for s, r in self.segments.items() if r["flags"] == "0" and int(r["size"]) > 30000) * 16

    def word(self, linear):
        return struct.unpack_from("<H", self.image, linear)[0]

    def stub_file_offset(self, para):
        return struct.unpack_from("<I", self.image, para * 16 + 4)[0]


# ---------------------------------------------------------------- address lookup

class Layout:
    """Where each original address lives: (module, offset in the module)."""

    def __init__(self, modules, original):
        self.original = original
        self.resident = defaultdict(list)   # block paragraph -> modules
        self.overlaid = []
        for m in modules:
            if m.overlay:
                self.overlaid.append(m)
            else:
                self.resident[original.block_para[m.block]].append(m)
        self.overlaid.sort(key=lambda m: m.base)
        self.stub_by_index = {int(r["index"]): s for s, r in original.segments.items() if r["flags"] == "3"}
        # each overlay stub covers the modules from its file offset to the next stub's
        self.stubs = sorted((original.stub_file_offset(s) + OVERLAY_BASE, s) for s in self.stub_by_index.values())
        self.overlay_of = {}
        for m in self.overlaid:
            self.overlay_of[m.stem] = max((b, p) for b, p in self.stubs if b <= m.base)[1]

    def resident_at(self, para, offset):
        for m in self.resident.get(para, ()):
            if m.org <= offset < m.org + m.size:
                return m, offset - m.org
        return None, None

    def overlay_at(self, linear):
        for m in self.overlaid:
            if m.base <= linear < m.base + m.size:
                return m, linear - m.base
        return None, None

    def overlay_offset(self, para, offset):
        return self.overlay_at(self.original.stub_file_offset(para) + OVERLAY_BASE + offset)

    def far_pointer(self, segment, offset):
        """(module, offset) for a far pointer of the original image; overlay code is
        reached through its stub, whose entry holds the target's offset."""
        row = self.original.segments.get(segment)
        if row is None:
            return None, None
        if row["flags"] == "3":
            return self.overlay_offset(segment, self.original.word(segment * 16 + offset + 2))
        return self.resident_at(segment, offset)

    def address(self, text):
        """(module, offset) for a symbols.tsv address: SSSS:OOOO or OVL:index:offset."""
        if text.startswith("OVL:"):
            _, index, offset = text.split(":")
            para = self.stub_by_index.get(int(index, 16))
            return (None, None) if para is None else self.overlay_offset(para, int(offset, 16))
        seg, off = (int(x, 16) for x in text.split(":"))
        return self.far_pointer(seg, off)


def name_at(module, offset, invented):
    """The function name at an offset of a module, else a label made for it."""
    for name, start in module.functions:
        if start == offset:
            return name
    label = f"{module.stem}_AT_{offset:04X}"
    invented[(module.stem, offset)] = label
    return label


# ---------------------------------------------------------------- generated assembly

def symbols():
    out = {}
    for line in (ROOT / "symbols.tsv").read_text().splitlines():
        if line and not line.startswith("#"):
            name, address, _ = line.split("\t")
            out[name] = address
    return out


def db_lines(chunk):
    """db lines for a byte run, quoting printable text, at most 60 columns of values."""
    lines, items, width = [], [], 0
    text = ""

    def put(item):
        nonlocal width
        items.append(item)
        width += len(item) + 1
        if width >= 60:
            lines.append("\t\tdb\t" + ",".join(items))
            items.clear()
            width = 0

    for b in chunk:
        if 0x20 <= b < 0x7F and b != 0x27:
            text += chr(b)
            if len(text) >= 40:
                put("'" + text + "'")
                text = ""
            continue
        if text:
            put("'" + text + "'")
            text = ""
        put(f"0{b:02X}h")
    if text:
        put("'" + text + "'")
    if items:
        lines.append("\t\tdb\t" + ",".join(items))
    return lines


class Region:
    """A run of original bytes written as assembly: labels, far pointers by name,
    segment words, and near words given as names."""

    def __init__(self, original, layout, invented, base, size, origin=None):
        """origin: when given, each label is preceded by "; @XXXX", its offset from origin."""
        self.base, self.size, self.origin = base, size, origin
        self.image = original.image[base:base + size]
        self.labels = defaultdict(list)
        self.items = {}   # offset -> (length, text)
        self.externs = set()
        for linear in original.relocations:
            if not base <= linear < base + size:
                continue
            offset = linear - base
            segment = original.word(linear)
            row = original.segments.get(segment)
            if row and row["flags"] == "0":
                self.items[offset] = (2, "dw\tDGROUP" if segment * 16 == original.dgroup else f"dw\t{segment:04X}h")
                continue
            if segment in SEGMENT_LABELS:
                # a pointer into the overlay manager's own segments: the offset stays a number
                self.externs.add(SEGMENT_LABELS[segment])
                self.items[offset] = (2, f"dw\tseg {SEGMENT_LABELS[segment]}")
                continue
            module, at = layout.far_pointer(segment, original.word(linear - 2))
            if module is None:
                raise SystemExit(f"far pointer at {(base + offset - 2):05X} -> {segment:04X}: no module")
            name = name_at(module, at, invented)
            self.externs.add(name)
            self.items[offset - 2] = (4, f"dd\t{name}")

    def near(self, offset, name):
        self.externs.add(name)
        self.items[offset] = (2, f"dw\toffset {name}")

    def lines(self, start=0, stop=None):
        stop = self.size if stop is None else stop
        out, cursor = [], start
        inside = {o for m, (n, _) in self.items.items() for o in range(m + 1, m + n)}
        marks = sorted(set(o for o in self.labels if start <= o < stop and o not in inside)
                       | set(o for o in self.items if start <= o < stop))
        for mark in marks + [stop]:
            if mark > cursor:
                out.extend(db_lines(self.image[cursor:mark]))
                cursor = mark
            if mark >= stop:
                break
            if self.labels.get(mark):
                out.append(f"; @{self.base + mark - self.origin:04X}") if self.origin is not None else None
            out += [f"{n}\tlabel\tbyte" for n in self.labels.get(mark, ())]
            if mark in self.items:
                length, text = self.items[mark]
                out.append("\t\t" + text)
                cursor = mark + length
                # a name that falls inside the item (one of its bytes): placed after it
                for inner in range(mark + 1, mark + length):
                    for n in self.labels.get(inner, ()):
                        out.append(f"{n}\tequ\t$-{mark + length - inner}")
        return out


def write_asm(name, lines):
    (OUT / "src" / f"{name}.ASM").write_text("\r\n".join(lines) + "\r\n")


def write_data_module(original, layout, data_names, invented):
    """MODDATA.ASM: DGROUP with every data name public at its original offset."""
    region = Region(original, layout, invented, original.dgroup, DATA_END)
    for name, offset in data_names.items():
        if offset < DATA_END:
            region.labels[offset].append(name)
    bss_end = DATA_END + 12208
    late = {n: o for n, o in data_names.items() if o >= bss_end}
    if late:
        raise SystemExit(f"data names beyond _BSS: {late}")
    lines = ["; MODDATA.ASM: the data segment for the modding link (generated by tools/modlink.py).",
             "; The original layout: every name at its original DGROUP offset, far pointers",
             "; written as the functions they point at, segment words as DGROUP.",
             "DGROUP\t\tgroup\t_DATA,_BSS,_BSSEND,_STACK"]
    lines += [f"\t\textrn\t{n}:far" for n in sorted(region.externs)]
    lines += [f"\t\tpublic\t{n}" for n in sorted(data_names)]
    lines.append("_DATA\t\tsegment para public 'DATA'")
    lines += region.lines()
    lines += ["_DATA\t\tends", "_BSS\t\tsegment word public 'DATA'"]
    # _BSS: six initialised bytes at its start in the original, then zeros
    start = Region(original, layout, invented, original.dgroup + DATA_END, 6)
    for name, offset in data_names.items():
        if DATA_END <= offset < DATA_END + 6:
            start.labels[offset - DATA_END].append(name)
    lines += start.lines()
    cursor = DATA_END + 6
    bss = defaultdict(list)
    for name, offset in data_names.items():
        if DATA_END + 6 <= offset < bss_end:
            bss[offset].append(name)
    for offset in sorted(bss) + [bss_end]:
        if offset > cursor:
            lines.append(f"\t\tdb\t{offset - cursor} dup (?)")
            cursor = offset
        lines += [f"{n}\tlabel\tbyte" for n in bss.get(offset, ())]
    lines += ["_BSS\t\tends",
              "_BSSEND\t\tsegment word public 'DATA'", "\t\tdb\t16 dup (0)", "_BSSEND\t\tends",
              "_STACK\t\tsegment word stack 'STACK'", "\t\tdb\t4500 dup (?)", "_STACK\t\tends",
              "\t\tend"]
    write_asm("MODDATA", lines)


# The overlay manager's own segments.  _OVERLAY_ (class OVRINFO) holds its variables and a
# table of near entry points into OVRMGR.ASM (the heap callbacks, the stub rewriters);
# _EXEINFO_ is filled by TLINK with the segment table; the empty BSS-class segments and
# CODE_52 (OVRDATA) mark places the manager takes segment values of.
OVERLAY_PARA = 0x0B1E
OVERLAY_SIZE = 0x1B0
OVRDATA_PARA = 0x0B98
OVRTRAP = 0x120
SEGMENT_LABELS = {0x0B1E: "BCC_SEG_46", 0x0B98: "BCC_SEG_52"}
OVRMGR_NEAR = range(0x76, 0x84, 2)   # words in _OVERLAY_ that are offsets into OVRMGR's code


def write_glue_module(original, layout, invented, ovrmgr, names):
    """names: symbols.tsv names that live in _OVERLAY_ (the manager's variables)."""
    region = Region(original, layout, invented, OVERLAY_PARA * 16, OVERLAY_SIZE)
    region.labels[0].append("BCC_SEG_46")
    # TLINK recognises the overlay manager by __OVRTRAP__ and writes INT 3Fh there: the
    # start of the second part of _OVERLAY_ (the original's bytes CD 3F at 0120h).
    region.labels[OVRTRAP].append("__OVRTRAP__")
    for name, offset in names.items():
        region.labels[offset].append(name)
    for offset in OVRMGR_NEAR:
        target = original.word(OVERLAY_PARA * 16 + offset)
        region.near(offset, name_at(ovrmgr, target - ovrmgr.org, invented))
    tail = Region(original, layout, invented, OVRDATA_PARA * 16, 16)
    tail.labels[0].append("BCC_SEG_52")
    externs = sorted((region.externs | tail.externs) - {"BCC_SEG_46", "BCC_SEG_52"})
    lines = ["; MODGLUE.ASM: the overlay manager's segments for the modding link (generated by",
             "; tools/modlink.py from the original image)."]
    lines += [f"\t\textrn\t{n}:far" for n in externs]
    lines += [f"\t\tpublic\t{n}" for n in sorted(names)]
    lines.append("\t\tpublic\t__OVRTRAP__")
    lines += ["\t\tpublic\tZERO_OFFSET", "ZERO_OFFSET\t=\t0"]
    lines += ["\t\tpublic\tBCC_SEG_46", "\t\tpublic\tBCC_SEG_47", "\t\tpublic\tBCC_SEG_50",
              "\t\tpublic\tBCC_SEG_52"]
    # _OVERLAY_ is several paragraph-aligned pieces in the original: the manager takes the
    # segment values of the pieces at 0120h (BCC_SEG_47, which starts with __OVRTRAP__)
    # and 0160h (BCC_SEG_50), so each piece is a segment of its own here.
    pieces = [("_OVERLAY_", 0, 0x120, None), ("OVRSEG47", 0x120, 0x140, "BCC_SEG_47"),
              ("OVRSEG48", 0x140, 0x150, None), ("OVRSEG49", 0x150, 0x160, None),
              ("OVRSEG50", 0x160, OVERLAY_SIZE, "BCC_SEG_50")]
    for seg, start, stop, label in pieces:
        lines.append(f"{seg}\tsegment para public 'OVRINFO'")
        if label:
            lines.append(f"{label}\tlabel\tfar")
        lines += region.lines(start, stop)
        lines.append(f"{seg}\tends")
    lines += ["_EXEINFO_\tsegment byte public 'OVRINFO'",
              "\t\tpublic\t__SEGTABLE__", "\t\tpublic\t__SEGTABEND__",
              "\t\tpublic\t__EXENAME__", "\t\tpublic\t__EXEDATE__",
              "__SEGTABLE__\tlabel\tbyte", "__SEGTABEND__\tlabel\tbyte",
              "__EXENAME__\tlabel\tbyte", "__EXEDATE__\tlabel\tbyte",
              "_EXEINFO_\tends",
              "CODE_52\t\tsegment para public 'OVRDATA'"]
    lines += tail.lines()
    lines += ["CODE_52\t\tends", "\t\tend"]
    write_asm("MODGLUE", lines)


# Four one-byte overlays with no code of their own: the driver hands the segments of
# their stubs to the heap (OPTIONS.C, ADOPT_EXTERNAL_REGIONS), which takes over the stubs
# between them - those of the C++ overlays in a C compile, and so on.  They must stay in
# their original places among the overlays.
MARKS = {"CO044": ["INIT_END_C_START_MARK"], "CO051": ["CPP_REGION_START_MARK"],
         "CO067": ["C_REGION_END_MARK"], "CO068": ["CPP_REGION_END_MARK"]}


def write_marks(layout, overlay_objects):
    out = []
    for obj, names in MARKS.items():
        para = overlay_objects[obj]
        base = layout.original.stub_file_offset(para) + OVERLAY_BASE
        stem = f"MRK{obj[2:]}"
        lines = [f"; {stem}.ASM: the placeholder overlay {obj} (generated by tools/modlink.py)."]
        lines += [f"\t\tpublic\t{n}" for n in names]
        lines += [f"OVR_{para:04X}\tsegment byte public 'CODE'"]
        lines += [f"{n}\tlabel\tfar" for n in names]
        lines += ["\t\tdb\t0", f"OVR_{para:04X}\tends", "\t\tend"]
        write_asm(stem, lines)
        out.append(((base, stem), para))
    return out


# Five overlays of the original are empty (CZ000-CZ004): stubs with no entries.  They are
# kept so that the stub segments, and DGROUP after them, keep their original places.
EMPTY_OVERLAYS = ("CZ000", "CZ001", "CZ002", "CZ003", "CZ004")


def write_empty_overlays(layout, overlay_objects):
    out = []
    for obj in EMPTY_OVERLAYS:
        para = overlay_objects[obj]
        base = layout.original.stub_file_offset(para) + OVERLAY_BASE
        stem = f"EMPTY{obj[2:]}"
        write_asm(stem, [f"; {stem}.ASM: the empty overlay {obj} (generated by tools/modlink.py).",
                         f"OVR_{para:04X}\tsegment byte public 'CODE'", f"OVR_{para:04X}\tends", "\t\tend"])
        out.append(((base, stem), para))
    return out


def overlay_objects(original):
    """Original overlay object name (CO000.., CZ000..) -> its stub paragraph."""
    response = (ROOT / "reconstructed" / "BCCEI3.RSP").read_text()
    names = re.findall(r"H:\\(\w+)\.OBJ", response)
    names = names[names.index("OVRORDER") + 1:names.index("CB0B4")]
    stubs = sorted((int(r["index"]), s) for s, r in original.segments.items() if r["flags"] == "3")
    return {names[i]: s for i, (_, s) in enumerate(stubs)}


# ---------------------------------------------------------------- objects

def alignments(modules, original):
    """Modules the original placed after a gap: word (1-byte gap) or paragraph alignment."""
    out, prev = {}, None
    for start, m in sorted((original.block_para[m.block] * 16 + m.org, m) for m in modules if not m.overlay):
        if prev is not None and start != prev:
            out[m.stem] = 2 if start - prev == 1 and start % 2 == 0 else 3
        prev = start + m.size
    return out


def object_path(m):
    return CHANGED.get(m.stem, ROOT / "build-source" / m.stem / f"{m.stem}.OBJ")


def compile_changed(src_dir):
    """Compile the sources under src_dir whose text differs from the matched tree's, into
    build-source/MODLINK/build (the matched objects are not touched)."""
    matched = {p.stem.upper(): p for p in (ROOT / "src").rglob("*") if p.suffix.upper() in (".C", ".ASM")}
    changed = [p for p in sorted(Path(src_dir).rglob("*"))
               if p.suffix.upper() in (".C", ".ASM") and "include" not in p.parts
               and (p.stem.upper() not in matched or p.read_bytes() != matched[p.stem.upper()].read_bytes())]
    new = [p for p in changed if p.stem.upper() not in matched]
    if new:
        raise SystemExit(f"new source files need a place in the link: {[p.name for p in new]}")
    if not changed:
        return
    bc20 = ROOT / "toolchain" / "BC20"
    for p in changed:
        head = p.read_bytes()[:4000].decode("latin1")
        if re.search(r"/\*\s*context:", head):
            raise SystemExit(f"{p.name} is compiled with a context source (tools/compile_context.py); "
                             "changing it is not supported yet")
        opts = re.search(r"opts:\s*([^*\n]*)", head).group(1).strip()
        stem = p.stem.upper()
        out_dir = OUT / "build" / stem
        out_dir.mkdir(parents=True, exist_ok=True)
        args = ["--stage", str(bc20 / "BIN"), "--stage", str(bc20 / "INCLUDE")]
        if p.suffix.upper() == ".ASM":
            command = f"TASM {opts} {stem}.ASM"
        elif re.search(r"compiler:\s*TC201", head):
            args = ["--stage", str(ROOT / "toolchain" / "TC201" / "BIN"),
                    "--stage", str(ROOT / "toolchain" / "TC201" / "INCLUDE"), "--stage", str(bc20 / "BIN" / "TASM.EXE")]
            command = f"TCC -c {opts} -IC:\\ {stem}.C"
        else:
            command = f"BCC -c {opts} -IC:\\ {stem}.C"
        for header in (ROOT / "src" / "include").iterdir():
            args += ["-f", str(header)]
        args += ["-f", f"{p}={stem}{p.suffix.upper()}", "-c", f"{command} > BUILD.LOG",
                 "-o", "BUILD.LOG", "-O", f"{stem}.OBJ"]
        dos(out_dir, args)
        if not (out_dir / f"{stem}.OBJ").exists():
            raise SystemExit(f"{p.name} did not compile:\n" + (out_dir / "BUILD.LOG").read_text(errors="replace"))
        CHANGED[stem] = out_dir / f"{stem}.OBJ"
    print("recompiled: " + ", ".join(p.name for p in changed))


CHANGED = {}
_IMAGES = {}
# test aid: limit --pad-code to these blocks (CODE_n, OVR_xxxx), from MODLINK_PAD_ONLY
PAD_ONLY = set(__import__("os").environ.get("MODLINK_PAD_ONLY", "").split())


def _image(path):
    if path not in _IMAGES:
        records = omfedit.read(path)
        index = next(i for i, s in enumerate(omfedit.segments(records), 1) if s[1] == "CODE")
        _IMAGES[path] = omfedit.code_image(records, index)
    return _IMAGES[path]


def _matches(module, start, limit=None):
    """Offsets in the changed object where the original function at start occurs."""
    size = module.sizes[start]
    old, old_fixed = _image(ROOT / "build-source" / module.stem / f"{module.stem}.OBJ")
    new, new_fixed = _image(CHANGED[module.stem])
    body = old[start:start + size]
    masked = {i - start for i in old_fixed if start <= i < start + size}
    found = []
    for at in range(0, len(new) - size + 1):
        if all(i in masked or (at + i) in new_fixed or new[at + i] == body[i] for i in range(size)):
            found.append(at)
            if limit and len(found) >= limit:
                break
    return found


def relocate(module, offset, name):
    """Where an original offset of a changed module is now.  A label other modules use sits
    at a fixed distance into its function: find that function in the new object by its
    bytes (fixup positions masked) and keep the distance.  A function whose bytes occur
    more than once is taken at the shift of the nearest earlier function found once.
    Refuses when the function itself was edited, since its labels then have no safe place."""
    starts = sorted(s for s in module.sizes if s <= offset)
    if not starts:
        raise SystemExit(f"{name}: offset {offset:04X} of {module.stem} is in no function")
    start = starts[-1]
    found = _matches(module, start)
    if len(found) > 1:
        for earlier in reversed(starts[:-1]):
            unique = _matches(module, earlier, limit=2)
            if len(unique) == 1:
                shift = unique[0] - earlier
                found = [f for f in found if f == start + shift]
                break
    if len(found) != 1:
        raise SystemExit(f"{name} is used by another module inside {module.stem}, in the function at "
                         f"{start:04X}, which {'was changed' if not found else 'cannot be told apart'}: "
                         "it has no safe place in the changed module")
    return found[0] + offset - start


# References whose offset half must be 0 although the symbol is in an overlay: TLINK sends
# both halves of a far reference to an overlaid name to its stub entry (offset 20h and up),
# but MSGGET hands BCC_MESSAGE_IMAGE to OVR_ENSURE_IMAGE_LOADED, which keeps the offset and
# returns the loaded image's segment with it.  The offset half is pointed at ZERO_OFFSET,
# an absolute 0 (MODGLUE.ASM), as the exact link binds it.
OFFSET_ZERO = {"MSGGET": [("BCC_MESSAGE_IMAGE", "ZERO_OFFSET")]}


def prepare_objects(modules, layout, defines, aligned):
    """Copy each object with its code segment renamed to its block, plus added publics."""
    for m in modules:
        records = omfedit.read(object_path(m))
        segs = omfedit.segments(records)
        code_index = next(i for i, s in enumerate(segs, 1) if s[1] == "CODE")
        new_name = f"OVR_{layout.overlay_of[m.stem]:04X}" if m.overlay else m.block
        records = omfedit.rename_lnames(records, {segs[code_index - 1][0]: new_name})
        if m.stem in aligned:
            records = omfedit.set_alignment(records, code_index, aligned[m.stem])
        for extern_name, absolute in OFFSET_ZERO.get(m.stem, ()):
            records, count = omfedit.retarget_offsets(records, extern_name, absolute)
            if count != 1:
                raise SystemExit(f"{m.stem}: expected one offset reference to {extern_name}, found {count}")
        extra = defines.get(m.stem, [])
        if extra:
            records = omfedit.add_publics(records, [(n, code_index, o) for n, o in extra])
        omfedit.write(records, OUT / "obj" / f"{m.stem}.OBJ")


def write_order(blocks, pad=0):
    lines = ["; MODORDER.ASM: segment order for the modding link (generated by tools/modlink.py)",
             "\t\tDOSSEG"]
    for b in blocks:
        lines.append(f"{b}\t\tsegment byte public 'CODE'")
        if pad and (not PAD_ONLY or b in PAD_ONLY):
            lines.append(f"\t\tdb\t{pad} dup (90h)\t; --pad-code test padding")
        lines.append(f"{b}\t\tends")
    lines.append("\t\tend")
    write_asm("MODORDER", lines)


def dos(outdir, args, timeout=900):
    r = subprocess.run(["node", str(EXHUME / "tools" / "dosrun.mjs"), str(outdir), *args, "-t", str(timeout)],
                       capture_output=True, text=True)
    if r.returncode:
        raise SystemExit(r.stdout + r.stderr)


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Link BCC.EXE from the sources, laid out by TLINK.")
    parser.add_argument("--src", help="a copy of src/ with changes: changed files are recompiled")
    parser.add_argument("--out", help="output directory (default build-source/MODLINK)")
    parser.add_argument("--pad-data", type=int, default=0, metavar="N",
                        help="test: insert N bytes early in _DATA, moving every data item after it")
    parser.add_argument("--pad-code", type=int, default=0, metavar="N",
                        help="test: insert N bytes at the start of every code block and overlay")
    parser.add_argument("--pad-at", metavar="XXXX",
                        help="with --pad-data: insert the padding before the data item at DS:XXXX, "
                             "or at the end of _DATA (END)")
    args = parser.parse_args()
    global OUT
    if args.out:
        OUT = Path(args.out).resolve()
    if OUT.exists():
        shutil.rmtree(OUT)
    for d in ("src", "obj", "run"):
        (OUT / d).mkdir(parents=True)
    if args.src:
        compile_changed(args.src)
    modules = load_modules()
    original = Original()
    layout = Layout(modules, original)
    syms = symbols()
    config = tomllib.loads((ROOT / "exhume.toml").read_text())
    aliases = config.get("names", {}).get("extern_aliases", {})
    by_stem = {m.stem: m for m in modules}
    objects = overlay_objects(original)

    # data names: DS:offset, DGROUP-paragraph addresses, aliases of either
    data_names = {}
    for name, address in syms.items():
        if address.startswith("DS:"):
            data_names[name] = int(address[3:], 16)
        elif not address.startswith("OVL:") and int(address.split(":")[0], 16) * 16 == original.dgroup:
            data_names[name] = int(address.split(":")[1], 16)
    for alias, canonical in aliases.items():
        if canonical in data_names:
            data_names[alias] = data_names[canonical]

    publics, needed = {}, set()
    for m in modules:
        records = omfedit.read(object_path(m))
        for name, _, _ in omfedit.publics(records):
            publics[name] = m.stem
        needed.update(omfedit.externs(records))
    where = {}  # function name -> (stem, offset), from the target tables
    for m in modules:
        for name, off in m.functions:
            where.setdefault(name, (m.stem, off))

    invented = {}
    defines = defaultdict(list)

    def define(name, stem, offset):
        """offset is in the original module; a changed module's is found by relocate()."""
        if name not in publics and stem in CHANGED:
            offset = relocate(by_stem[stem], offset, name)
        if name not in publics:
            defines[stem].append((name, offset))
            publics[name] = stem

    data_source = Path(args.src or ROOT / "src") / "data" / "DGROUP.ASM"
    text = data_source.read_bytes().decode("latin1")
    if args.pad_data:
        mark = ("; END-OF-DATA" if args.pad_at and args.pad_at.upper() == "END"
                else f"; @{args.pad_at.upper()}\r\n" if args.pad_at else "; PAD-POINT")
        if text.count(mark) != 1:
            raise SystemExit(f"DGROUP.ASM has no single {mark.strip()} line for --pad-data")
        text = text.replace(mark, f"\t\tdb\t{args.pad_data} dup (0)\t; --pad-data test padding\r\n" + mark)
    (OUT / "src" / "MODDATA.ASM").write_bytes(text.encode("latin1"))
    ovrmgr = by_stem["OVRMGR"]
    overlay_names = {n: int(a.split(":")[1], 16) for n, a in syms.items()
                     if a.startswith(f"{OVERLAY_PARA:04X}:")}
    write_glue_module(original, layout, invented, ovrmgr, overlay_names)
    marks = write_marks(layout, objects) + write_empty_overlays(layout, objects)
    write_order(sorted({m.block for m in modules if not m.overlay}, key=lambda b: original.block_para[b]),
                args.pad_code)
    generated = ["MODORDER", "MODDATA", "MODGLUE"] + [stem for (_, stem), _ in marks]
    for stem in generated:
        text = (OUT / "src" / f"{stem}.ASM").read_text(errors="replace")
        needed.update(re.findall(r"extrn\t(\S+):far", text))
        needed.update(re.findall(r"\t; @code (\S+)", text))
        for name in re.findall(r"public\t(\S+)", text):
            publics.setdefault(name, stem)
    for (stem, offset), label in invented.items():
        define(label, stem, offset)

    unresolved = []
    for name in sorted(needed):
        if name in publics:
            continue
        target = aliases.get(name, name)
        if target in where:
            define(name, *where[target])
        elif target in syms:
            m, at = layout.address(syms[target])
            if m is None:
                unresolved.append((name, syms[target]))
            else:
                define(name, m.stem, at)
        else:
            unresolved.append((name, None))
    prepare_objects(modules, layout, defines, alignments(modules, original))
    # Labels other modules use inside these modules: a changed copy of one of them must
    # make the label public itself (in C that means splitting the function there).
    (OUT / "run" / "ADDED-PUBLICS.TXT").write_text(
        "".join(f"{stem}\t{name}\t{offset:04X}\n" for stem in sorted(defines)
                for name, offset in sorted(defines[stem], key=lambda x: x[1])))

    resident = sorted((m for m in modules if not m.overlay), key=lambda m: (original.block_para[m.block], m.org))
    # TLINK makes the overlay stubs in link order, and the stubs' order matters (the heap
    # adopts the span between two marks), so link overlays in original stub order.
    stub_index = {p: int(original.segments[p]["index"]) for p in layout.stub_by_index.values()}
    overlaid = sorted([((stub_index[layout.overlay_of[m.stem]], m.base), m.stem) for m in modules if m.overlay]
                      + [((stub_index[para], base), stem) for (base, stem), para in marks])
    if args.pad_code:
        # test: N bytes at the start of every overlay that holds recovered code
        padded, seen = [], set()
        for key, stem in overlaid:
            para = layout.overlay_of.get(stem)
            if para == layout.overlay_of["MESSAGES"]:
                para = None   # the message image is read from offset 0 of its overlay
            if para is not None and PAD_ONLY and f"OVR_{para:04X}" not in PAD_ONLY:
                para = None
            if para is not None and para not in seen:
                seen.add(para)
                pad_stem = f"PAD{para:04X}"
                write_asm(pad_stem, [f"OVR_{para:04X}\tsegment byte public 'CODE'",
                                     f"\t\tdb\t{args.pad_code} dup (90h)\t; --pad-code test padding",
                                     f"OVR_{para:04X}\tends", "\t\tend"])
                generated.append(pad_stem)
                padded.append((key, pad_stem))
            padded.append((key, stem))
        overlaid = padded
    lines = ["/m /s /c O\\MODORDER"] + [f"O\\{m.stem}" for m in resident] + ["O\\MODGLUE", "O\\MODDATA"]
    lines += ["/o O\\" + overlaid[0][1]] + [f"O\\{stem}" for _, stem in overlaid[1:]]
    response = " +\r\n".join(lines) + "\r\nBCC.EXE\r\nBCC.MAP\r\n\r\n"
    (OUT / "run" / "MOD.RSP").write_text(response)
    print(f"modules: {len(resident)} resident, {len(overlaid)} overlaid; "
          f"added publics: {sum(len(v) for v in defines.values())}; unresolved: {len(unresolved)}")
    for item in unresolved:
        print("  unresolved", *item)

    bin_dir = str(ROOT / "toolchain" / "BC20" / "BIN")
    assemble(bin_dir, generated)
    link(bin_dir)
    # Second pass: the near pointers into code that DGROUP.ASM tags "; @code NAME" take the
    # function's offset from the first link's map (the data's size does not change, so
    # neither does the layout).
    offsets = map_offsets(OUT / "run" / "BCC.MAP")
    text = (OUT / "src" / "MODDATA.ASM").read_bytes().decode("latin1")

    def code_word(m):
        name = m.group(2)
        if name not in offsets:
            raise SystemExit(f"@code {name}: not in the map")
        return f"dw\t0{offsets[name]:04X}h\t; @code {name}"

    new_text = re.sub(r"dw\t(0[0-9A-F]+h)\t; @code (\S+)", code_word, text)
    relink = False
    if new_text != text:
        (OUT / "src" / "MODDATA.ASM").write_bytes(new_text.encode("latin1"))
        assemble(bin_dir, ["MODDATA"])
        relink = True
    # The numbers of map/code-numbers.tsv: DGROUP addresses in compiled code that cannot be
    # names; each takes its target's offset in the new layout (its DATA_xxxx label).
    by_stem = {m.stem: m for m in modules}
    for stem, offset, target, *_ in code_numbers():
        value = offsets.get(f"DATA_{target:04X}")
        if value is None:
            raise SystemExit(f"code-numbers: DATA_{target:04X} is not in the map")
        if value != target:
            if stem in CHANGED:
                offset = relocate(by_stem[stem], offset, f"the number at {stem}+{offset:04X}")
            path = OUT / "obj" / f"{stem}.OBJ"
            records = omfedit.read(path)
            index = next(i for i, s in enumerate(omfedit.segments(records), 1) if s[1] == "CODE")
            omfedit.write(omfedit.patch_word(records, index, offset, value), path)
            relink = True
    if relink:
        link(bin_dir)
        print("second pass: near code pointers and code numbers updated for the new layout")
    print((OUT / "run" / "LINK.TXT").read_text()[-3000:])
    if not args.pad_data:
        data_check(original, offsets)


def data_check(original, offsets):
    """Compare the linked _DATA with the original's.  Far pointers (relocated words and the
    offsets before them) and near code pointers may differ with the layout; any other
    difference comes from an edit of src/data/DGROUP.ASM, and is listed."""
    data = (OUT / "run" / "BCC.EXE").read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    text = (OUT / "run" / "BCC.MAP").read_text()
    m = re.search(r"^ ([0-9A-F]{5})H \S+ \S+ _DATA ", text, re.M)
    new = data[header + int(m.group(1), 16):]
    old = original.image[original.dgroup:]
    loose = set()
    for r in original.relocations:
        if original.dgroup <= r < original.dgroup + DATA_END:
            loose.update(range(r - original.dgroup - 2, r - original.dgroup + 2))
    source = (OUT / "src" / "MODDATA.ASM").read_bytes().decode("latin1")
    for line in (ROOT / "map" / "data-pointers.tsv").read_text().splitlines():
        if line and not line.startswith("#") and line.split("\t")[2] == "code":
            off = int(line.split("\t")[0], 16)
            loose.update((off, off + 1))
    differ = [i for i in range(DATA_END) if i not in loose and old[i] != new[i]]
    if differ:
        print(f"data check: _DATA differs from the original at {len(differ)} bytes, from DS:{differ[0]:04X} "
              "(expected only where src/data/DGROUP.ASM was edited)")
    else:
        print("data check: _DATA equals the original's, but for far pointers and code pointers")


def code_numbers():
    """(module, offset, DGROUP target) from map/code-numbers.tsv."""
    out = []
    for line in (ROOT / "map" / "code-numbers.tsv").read_text().splitlines():
        if line and not line.startswith("#"):
            stem, offset, target, *_ = line.split("\t")
            out.append((stem, int(offset, 16), int(target, 16)))
    return out


def assemble(bin_dir, stems):
    args = ["--stage", bin_dir]
    for stem in stems:
        args += ["-f", str(OUT / "src" / f"{stem}.ASM"), "-c", f"TASM /ml {stem}.ASM > {stem}.TXT",
                 "-o", f"{stem}.TXT", "-O", f"{stem}.OBJ"]
    dos(OUT, args)
    for stem in stems:
        made = OUT / f"{stem}.OBJ"
        if not made.exists():
            raise SystemExit((OUT / f"{stem}.TXT").read_text())
        shutil.move(made, OUT / "obj" / f"{stem}.OBJ")


def link(bin_dir):
    for stale in ("BCC.EXE", "BCC.MAP"):
        (OUT / "run" / stale).unlink(missing_ok=True)
    dos(OUT / "run", ["--stage", bin_dir, "-f", f"{OUT / 'obj'}=O", "-f", str(OUT / "run" / "MOD.RSP"),
                      "-c", "TLINK @MOD.RSP > LINK.TXT", "-o", "LINK.TXT", "-O", "BCC.EXE", "-O", "BCC.MAP"])
    if not (OUT / "run" / "BCC.EXE").exists():
        raise SystemExit((OUT / "run" / "LINK.TXT").read_text())


def map_offsets(path):
    """{public name: offset} from a TLINK map (the offset in the segment the code runs in)."""
    out = {}
    for seg, off, name in re.findall(r"^ ([0-9A-F]{4}):([0-9A-F]{4})\s+(?:idle\s+|Abs\s+)?(\S+)\s*$", Path(path).read_text(), re.M):
        out.setdefault(name, int(off, 16))
    return out

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Emit an Exhume target table for a recovered BCC module.

The existing module map describes logical overlay addresses. Exhume compares
against file offsets in the original EXE, so this translates resident offsets
and FBOV overlay body offsets without copying any original code into a target.
"""
from pathlib import Path
import argparse
import csv
import struct

ROOT = Path(__file__).resolve().parent.parent
from compare_tasm_listing import listing_bytes
from source_spans import load_source_spans, validate_source_span


def rows(path):
    with (ROOT / path).open(newline="") as stream:
        return list(csv.DictReader(stream))


def overlay_segment_fixups(exe, fbov, body, code_size, fixup_size, relative, recovered):
    """Validate original FBOV segment words against the Ghidra loaded image.

    Only flags-zero segment relocations are supported. The original word is a
    segment-table index shifted left three bits; Ghidra replaces it with that
    segment's paragraph plus this project's fixed 1000h load paragraph.
    """
    if fbov < 0 or fbov + 16 > len(exe) or exe[fbov:fbov + 4] != b"FBOV":
        raise ValueError("Invalid original FBOV header")
    table, count = struct.unpack_from("<IH", exe, fbov + 8)
    if not table or table + count * 8 > fbov:
        raise ValueError("Invalid original segment table bounds")
    if (body < fbov + 16 or code_size < 0 or fixup_size < 0 or fixup_size % 2
            or body + code_size + fixup_size > len(exe)):
        raise ValueError("Invalid original overlay relocation table bounds")
    if relative < 0 or relative + len(recovered) > code_size:
        raise ValueError("Invalid recovered overlay bounds")
    validated = set()
    for position in range(body + code_size, body + code_size + fixup_size, 2):
        offset = struct.unpack_from("<H", exe, position)[0]
        if offset + 2 > code_size:
            raise ValueError("Original overlay relocation word exceeds code bounds")
        encoded = struct.unpack_from("<H", exe, body + offset)[0]
        if encoded & 7:
            raise ValueError("Unsupported original overlay relocation flags")
        target_index = encoded >> 3
        if target_index >= count:
            raise ValueError("Invalid original overlay relocation target index")
        start = offset - relative
        if start >= len(recovered) or start + 2 <= 0:
            continue
        if start < 0 or start + 2 > len(recovered):
            raise ValueError("Original overlay relocation crosses module bounds")
        segment = struct.unpack_from("<H", exe, table + target_index * 8)[0]
        loaded = struct.unpack_from("<H", recovered, start)[0]
        if loaded != (segment + 0x1000) & 0xFFFF:
            raise ValueError("Recovered overlay segment disagrees with original relocation")
        validated.update((start, start + 1))
    return validated


def resident_mz_fixups(exe, base, recovered):
    """Validate original MZ segment WORDs against the fixed1000h loaded image.

    These masks are earned only by complete original relocation records and
    exact loaded-WORD arithmetic. Literal data and unrelated fixed bytes do
    not become relocations merely because the listing used a loaded address.
    """
    if len(exe)<28 or exe[:2]!=b'MZ':
        raise ValueError('Invalid original MZ header')
    last,pages,count,header_paras=struct.unpack_from('<4H',exe,2)
    header=header_paras*16
    end=(pages-1)*512+last if last else pages*512
    table=struct.unpack_from('<H',exe,0x18)[0]
    if (pages==0 or last>=512 or header<28 or header>end or end>len(exe)
            or (count and (table<28 or table+count*4>header))):
        raise ValueError('Invalid original MZ bounds or relocation table')
    size=len(recovered)
    if type(base) is not int or size<=0 or base<header or base+size>end:
        raise ValueError('Invalid recovered resident module bounds')
    positions=[]
    for k in range(count):
        offset,segment=struct.unpack_from('<HH',exe,table+k*4)
        at=header+segment*16+offset
        if at<header or at+2>end:
            raise ValueError('Original MZ relocation WORD exceeds loaded image')
        positions.append(at)
    positions.sort()
    if any(a+2>b for a,b in zip(positions,positions[1:])):
        raise ValueError('Duplicate or overlapping original MZ relocation WORDs')
    validated=set()
    for at in positions:
        if at>=base+size or at+2<=base:
            continue
        relative=at-base
        if relative<0 or relative+2>size:
            raise ValueError('Original MZ relocation WORD crosses module bounds')
        original=struct.unpack_from('<H',exe,at)[0]
        loaded=struct.unpack_from('<H',recovered,relative)[0]
        if loaded!=(original+0x1000)&0xffff:
            raise ValueError('Recovered resident segment disagrees with original MZ relocation')
        validated.update((relative,relative+1))
    return validated


def locate(module):
    # A declaration is authoritative; invalid metadata must never enter the
    # legacy manual-target KeyError fallback (including a missing owner row).
    declared = load_source_spans(ROOT / "source-partitions.json")
    checked = {m: validate_source_span(ROOT, span, resident_mz_fixups)
               for m, span in declared.items()}
    if module.upper() in checked:
        span = checked[module.upper()].span
        return (f"{span.parts[0].block}_{span.module}", span.source_base,
                span.source_size, span.source_org)
    modules = {Path(row["listing"]).stem.upper(): row for row in rows("module-addresses.csv")}
    row = modules[module.upper()]
    blocks = {item["block"]: item for item in rows("memory_blocks/index.csv")}
    block = blocks[row["block"]]
    block_segment, block_offset = block["start"].split(":")
    relative = int(row["offset"], 16) - int(block_offset, 16)
    if relative < 0:
        raise ValueError(f"{module}: module starts before its containing block")

    groups = rows("group-layout.csv")
    # Empty overlay objects also occupy entries in the original segment table.
    overlay_objects = [item for item in groups if item["overlay"] == "1"]
    object_by_block = {item["block"]: item for item in overlay_objects}
    exe = (ROOT / "toolchain/BC20/BIN/BCC.EXE").read_bytes()
    header = struct.unpack_from("<H", exe, 8)[0] * 16
    last, pages = struct.unpack_from("<HH", exe, 2)
    end = (pages - 1) * 512 + last if last else pages * 512
    if exe[end:end + 4] != b"FBOV":
        raise ValueError("original executable has no FBOV block")

    overlay = None
    org = relative
    if row["block"] in object_by_block:
        object_row = object_by_block[row["block"]]
        overlay_index = overlay_objects.index(object_row)
        info = [item for item in rows("original-exeinfo.csv") if int(item["flags"]) == 3]
        segment = int(info[overlay_index]["segment"], 16)
        stub = header + segment * 16
        _, _, file_offset, code_size, fixup_size, _, _ = struct.unpack_from("<2sHI4H", exe, stub)
        if relative + int(row["size"]) > code_size:
            raise ValueError(f"{module}: invalid overlay body mapping")
        overlay = (end + 16 + file_offset, code_size, fixup_size)
        base = overlay[0] + relative
        target = f"ovr{56 + overlay_index:03d}_{module.upper()}"
    else:
        # Memory slices count from block.start; resident IP and file offsets
        # count from the original paragraph, even when block.start is nonzero.
        org = int(row["offset"], 16)
        base = header + (int(block_segment, 16) - 0x1000) * 16 + org
        target = f"{row['block']}_{module.upper()}"

    size = int(row["size"])
    original = exe[base:base + size]
    recovered = (ROOT / "memory_blocks" / block["file"]).read_bytes()[relative:relative + size]
    _, fixups = listing_bytes(ROOT / "reconstructed" / f"{module.upper()}.LST")
    if overlay is not None:
        fixups |= overlay_segment_fixups(exe, end, *overlay, relative, recovered)
    else:
        fixups |= resident_mz_fixups(exe, base, recovered)
    differences = [index for index, (old, new) in enumerate(zip(original, recovered))
                   if old != new and index not in fixups]
    if len(original) != size or len(recovered) != size or differences:
        raise ValueError(f"{module}: mapped EXE fixed bytes disagree with the existing module map")
    return target, base, size, org


def emit(module, name, write, retain=False):
    try:
        target, base, size, org = locate(module)
    except KeyError:
        # Recovered helper routines can share an original listing with another
        # function. Their exact file bounds live only in a manual target table.
        manual = sorted((ROOT / "targets").glob(f"*_{module.upper()}.tsv"))
        if len(manual) != 1:
            raise
        print(f"target: {manual[0].stem} (manual bounds retained)")
        return
    out = ROOT / "targets" / f"{target}.tsv"
    if retain and write and out.exists():
        # Batch regeneration must not truncate verified compiler-emitted tables
        # or other manual bounds attached to a recovered module.
        print(f"target: {target} (existing bounds retained)")
        return
    name = name or module.upper()
    text = (f"# segment {target} base 0x{base:X} size 0x{size:X} org 0x{org:X}\n"
            f"{name}\t{module.upper()}\t0x0\t0x{size:X}\n")
    if write:
        out.parent.mkdir(exist_ok=True)
        out.write_text(text)
    print(f"target: {target}")
    print(text, end="")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module", nargs="?", help="module stem from module-addresses.csv")
    parser.add_argument("--name", help="public C function name (defaults to the module stem)")
    parser.add_argument("--all", action="store_true", help="emit every row in source-modules.csv")
    parser.add_argument("--write", action="store_true", help="write targets/TARGET.tsv")
    args = parser.parse_args()
    if args.all == bool(args.module) or (args.all and args.name):
        parser.error("give one module, or --all without --name")
    jobs = rows("source-modules.csv") if args.all else [{"module": args.module, "name": args.name}]
    for job in jobs:
        emit(job["module"], job["name"], args.write, retain=args.all)


if __name__ == "__main__":
    main()

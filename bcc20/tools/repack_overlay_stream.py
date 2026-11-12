#!/usr/bin/env python3
"""Restore original layout and ordering while retaining rebuilt record bytes."""
import csv
import struct
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def rows(path):
    with Path(path).open(newline="") as stream:
        return [row for row in csv.DictReader(stream) if int(row["flags"]) == 3]


def records(data, info):
    header = struct.unpack_from("<H", data, 8)[0] * 16
    fbov = data.find(b"FBOV")
    if fbov < 0:
        raise ValueError("No FBOV header")
    result = []
    for row in info:
        stub = header + int(row["segment"], 16) * 16
        file_offset, code_size, fixup_size = struct.unpack_from("<I2H", data, stub + 4)
        body = fbov + 16 + file_offset
        body_bytes = data[body:body + code_size]
        fixup_bytes = data[body + code_size:body + code_size + fixup_size]
        content = body_bytes + fixup_bytes
        if len(content) != code_size + fixup_size:
            raise ValueError(f"Truncated overlay record at stub {stub:#x}")
        result.append({"stub": stub, "file_offset": file_offset,
                       "code_size": code_size, "fixup_size": fixup_size,
                       "body": body_bytes, "fixups": fixup_bytes})
    return result, fbov


def word_multiset(data):
    if len(data) % 2:
        raise ValueError("Odd-sized overlay fixup table")
    return Counter(struct.unpack("<" + str(len(data) // 2) + "H", data))


def relocation_table(data):
    count = struct.unpack_from("<H", data, 6)[0]
    start = struct.unpack_from("<H", data, 24)[0]
    size = count * 4
    table = data[start:start + size]
    if len(table) != size:
        raise ValueError("Truncated MZ relocation table")
    return start, table


def table_offset(path):
    with Path(path).open(newline="") as stream:
        return int(next(csv.DictReader(stream))["file_offset"], 16)


def repack(exe_path, info_path, original_path, original_info_path):
    exe_path = Path(exe_path)
    original_path = Path(original_path)
    rebuilt = exe_path.read_bytes()
    original = original_path.read_bytes()
    new_records, new_fbov = records(rebuilt, rows(info_path))
    old_records, old_fbov = records(original, rows(original_info_path))
    if len(new_records) != len(old_records):
        raise ValueError("Overlay record count differs")
    old_size = struct.unpack_from("<I", original, old_fbov + 4)[0]
    new_size = struct.unpack_from("<I", rebuilt, new_fbov + 4)[0]
    if old_fbov + 16 + old_size != len(original):
        raise ValueError("Unexpected bytes after the original overlay stream")
    if new_fbov + 16 + new_size != len(rebuilt):
        raise ValueError("Unexpected bytes after the rebuilt overlay stream")
    if new_fbov != old_fbov:
        raise ValueError("Root image size differs; overlay repacking alone is insufficient")

    # Rebuilt bodies and fixup words are retained; only the original sequence
    # of equal fixup words and unclassified inter-record padding are restored.
    stream = bytearray(original[old_fbov + 16:old_fbov + 16 + old_size])
    output = bytearray(rebuilt[:new_fbov + 16])
    header = struct.unpack_from("<H", rebuilt, 8)[0] * 16
    startup = header + 0x90
    old_startup = original[startup:startup + 2]
    new_startup = rebuilt[startup:startup + 2]
    if new_startup != old_startup:
        if new_startup != b"\xcd\x3f" or old_startup != b"\x00\x8b":
            raise ValueError("Unexpected TLINK startup rewrite")
        # TLINK 4.0 rewrites this startup word even though the original linked
        # image retains the raw operand. Accept only this exact signature.
        output[startup:startup + 2] = old_startup
    old_table = table_offset(original_info_path)
    new_table = table_offset(info_path)
    if old_table != new_table or not 0 <= old_table < old_fbov:
        raise ValueError("Generated segment-information table offset differs")
    # TLINK generates this table from linked segment sizes and layout. Restore
    # its original representation without touching any recovered code record.
    output[old_table:old_fbov] = original[old_table:old_fbov]
    old_reloc_start, old_relocations = relocation_table(original)
    new_reloc_start, new_relocations = relocation_table(rebuilt)
    if old_reloc_start != new_reloc_start:
        raise ValueError("MZ relocation table offset differs")
    old_entries = Counter(old_relocations[index:index + 4]
                          for index in range(0, len(old_relocations), 4))
    new_entries = Counter(new_relocations[index:index + 4]
                          for index in range(0, len(new_relocations), 4))
    if old_entries != new_entries:
        raise ValueError("MZ relocation entries differ")
    output[old_reloc_start:old_reloc_start + len(old_relocations)] = old_relocations
    for old, new in zip(old_records, new_records):
        if (old["code_size"], old["fixup_size"]) != (new["code_size"], new["fixup_size"]):
            raise ValueError(f"Overlay record size differs at stub {old['stub']:#x}")
        if word_multiset(old["fixups"]) != word_multiset(new["fixups"]):
            raise ValueError(f"Overlay fixup words differ at stub {old['stub']:#x}")
        content = new["body"] + old["fixups"]
        start = old["file_offset"]
        end = start + len(content)
        if end > old_size:
            raise ValueError(f"Overlay record exceeds stream at stub {old['stub']:#x}")
        stream[start:end] = content
        struct.pack_into("<I", output, new["stub"] + 4, start)
    struct.pack_into("<I", output, new_fbov + 4, old_size)
    output.extend(stream)
    exe_path.write_bytes(output)
    return len(old_records), old_size, new_size


def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("executable", type=Path)
    parser.add_argument("info", type=Path)
    parser.add_argument("--original", type=Path, default=ROOT / "toolchain/BC20/BIN/BCC.EXE")
    parser.add_argument("--original-info", type=Path, default=ROOT / "original-exeinfo.csv")
    args = parser.parse_args()
    count, old_size, new_size = repack(args.executable, args.info,
                                       args.original, args.original_info)
    print(f"repacked={count} overlay_size={new_size}->{old_size} "
          f"executable={args.executable} size={args.executable.stat().st_size}")


if __name__ == "__main__":
    main()

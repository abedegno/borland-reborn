#!/usr/bin/env python3
"""Compare original Ghidra bytes with a TASM listing, accounting for relocations."""

import argparse
import re

MNEMONIC = re.compile(
    r"(?<=\t)\s*\b(?:aaa|aas|adc|add|and|call|cbw|clc|cld|cli|cmc|cmp|cmpsb|cwd|daa|das|db|dec|div|dw|idiv|imul|inc|int|ja|jbe|jc|jcxz|je|jg|jge|jl|jle|jmp|jna|jnae|jnb|jnbe|jnc|jne|jng|jnge|jnl|jnle|jno|jnp|jns|jnz|jo|jp|jpe|jpo|js|jz|jae|jb|lds|lea|les|lodsb|lodsw|loopnz|loopz|loop|mov|movsb|movsw|mul|neg|nop|not|or|popf|pop|pushf|push|repne|repe|rep|ret|retf|retn|rcl|rcr|rol|ror|sar|sbb|scasb|shl|shr|stc|std|sti|stosb|stosw|sub|test|xchg|xlat|xor)\b",
    re.I,
)


def original_bytes(path, instruction_limit=None):
    data = bytearray()
    pattern = re.compile(r"^[0-9a-f]+:[0-9a-f]+\s+((?:[0-9A-F]{2}\s+)+)")
    instructions = 0
    for line in open(path, encoding="utf-8"):
        match = pattern.match(line.strip())
        if match:
            data.extend(int(token, 16) for token in match.group(1).split())
            instructions += 1
            if instructions == instruction_limit:
                break
    return bytes(data)


def listing_bytes(path):
    data = bytearray()
    relocations = []
    continuation = False
    current_segment = None
    for line in open(path, encoding="utf-8", errors="ignore"):
        segment = re.search(r"\b([A-Za-z_]\w*)\s+segment\s", line, re.I)
        if segment:
            current_segment = segment.group(1).upper()
        suppressed = current_segment in ("_DATA", "_BSS")
        # Byte columns can contain values such as DB; the source mnemonic is last.
        matches = list(MNEMONIC.finditer(line))
        match = matches[-1] if matches else None
        if continuation and (not line.strip() or line.lstrip("\f").startswith("Turbo Assembler")
                             or line.strip().upper().endswith(".ASM")):
            continue
        if continuation:
            continued = re.match(r"^\s*\d+\s+((?:(?:[0-9A-F]{4}|[0-9A-F]{2})(?=\s|$)\s*)+)", line)
            if continued:
                if not suppressed:
                    for token in continued.group(1).split():
                        value = int(token, 16)
                        if len(token) == 2:
                            data.append(value)
                        else:
                            data.extend((value & 0xFF, value >> 8))
                continuation = "+" in line
                continue
            continuation = False
        if suppressed or not match or "\t" not in line:
            continue
        field = line.split("\t", 1)[1]
        if len(field) < 6 or not re.match(r"[0-9A-F]{4}  ", field):
            continue
        # The mnemonic position is in the full line; recover its position in field.
        byte_text = field[6:match.start() - (len(line) - len(field))]
        continuation = "+" in byte_text
        tokens = byte_text.replace(":", " ").replace(">", " ").replace("+", " ").split()
        for token in tokens:
            reloc = token.lower().endswith(("e", "s")) and len(token) == 5
            local_relative = token.lower().endswith("r") and len(token) == 5
            if reloc or local_relative:
                token = token[:-1]
            if not re.fullmatch(r"[0-9A-F]+", token) or len(token) not in (2, 4):
                continue
            value = int(token, 16)
            if len(token) == 2:
                data.append(value)
                if reloc:
                    relocations.append(len(data) - 1)
            else:
                data.extend((value & 0xFF, value >> 8))
                if reloc or local_relative:
                    relocations.extend((len(data) - 2, len(data) - 1))
    return bytes(data), set(relocations)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("original")
    parser.add_argument("listing")
    parser.add_argument("instructions", type=int, nargs="?")
    args = parser.parse_args()
    original = original_bytes(args.original, args.instructions)
    generated, relocations = listing_bytes(args.listing)
    if len(original) != len(generated):
        print(f"LENGTH MISMATCH: original={len(original)}, generated={len(generated)}")
        raise SystemExit(1)
    mismatches = [i for i, (a, b) in enumerate(zip(original, generated)) if a != b and i not in relocations]
    if mismatches:
        print(f"BYTE MISMATCH at offsets: {', '.join(hex(i) for i in mismatches)}")
        raise SystemExit(1)
    changed_relocations = sum(original[i] != generated[i] for i in relocations)
    print(
        f"MATCH {len(original)} bytes: {len(original) - len(relocations)} fixed bytes, "
        f"{len(relocations)} relocation bytes ({changed_relocations} address-dependent)"
    )


if __name__ == "__main__":
    main()

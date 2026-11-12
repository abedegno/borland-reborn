"""Write the C sources' numeric DGROUP addresses as names (a one-off rewrite, kept for the record).

    python3 tools/namestrings.py [--write]

The recovered C reaches many of its strings by number: TEXT(0x5537), (char near *)0x5537,
MK_FP(_DS,0x5537).  The bytes are the same with a name (a fixup in place of the number),
but a number breaks as soon as the data moves.  This finds each such use and writes:

- the symbols.tsv name when one starts there;
- otherwise a name made from the text of the string it points into (STR_TC86_BORLAND_...),
  as NAME or NAME+n for a pointer into a string's tail (BCC shares string tails);
- otherwise the nearest earlier named item plus the distance.

New names are declared in src/include/DATA.H (extern char NAME[], with their text) and
must be added to symbols.tsv (verify.py --update) and src/data/DGROUP.ASM (gendata.py).
HEAPMAIN.C's 0x1e0 is an offset in the heap's own segment, not DGROUP, and stays a number.
Without --write it only prints what it would change.
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402

ROOT = modlink.ROOT
DATA_H = ROOT / "src" / "include" / "DATA.H"
SKIP = {"HEAPMAIN.C"}
KEEP = {("EXTDECL.C", 0x702), ("EXTDECL.C", 0x709)} | {("ASMCODE.C", v) for v in (0x54E7, 0x54EE, 0x54F5, 0x54FC, 0x5503, 0x550A, 0x5511, 0x5518, 0x551F)}   # a name changes the code there (see the source)
PATTERN = re.compile(r"(TEXT\(|near \*\)\s*|MK_FP\(_DS,\s*)(0x[0-9A-Fa-f]{2,4})\b")
# file-local macros that take a DGROUP address
LOCAL = {"ASMCODE.C": r"COMMENT\(", "ASMTEXT.C": r"\bS\(", "INPUT.C": r"SEGMENT_OF\("}


def name_for_text(text, taken):
    special = {"\r\n": "CRLF", "\n": "NL", "\t": "TAB", " ": "SPACE", ",": "COMMA", ":": "COLON"}
    if text in special:
        base = special[text]
    else:
        base = re.sub(r"[^A-Za-z0-9]+", "_", text).strip("_").upper()[:28]
        if not base:   # punctuation only: name the characters
            words = {"]": "RBRACKET", "[": "LBRACKET", ",": "COMMA", '"': "QUOTE", "@": "AT", "+": "PLUS",
                     "(": "LPAREN", ")": "RPAREN", ":": "COLON", ".": "DOT", "\r": "CR", "\n": "NL",
                     "\t": "TAB", " ": "SPACE", "-": "MINUS", "*": "STAR", "/": "SLASH", "?": "QUERY"}
            base = "_".join(words.get(c, f"X{ord(c):02X}") for c in text)[:28]
    name = "STR_" + base
    n = 2
    while name in taken:
        name = f"STR_{base}_{n}"
        n += 1
    return name


def main():
    write = "--write" in sys.argv
    original = modlink.Original()
    image, ds = original.image, original.dgroup
    syms = modlink.symbols()
    by_addr = {}
    for n, a in syms.items():
        if a.startswith("DS:"):
            by_addr.setdefault(int(a[3:], 16), n)
    declared = DATA_H.read_text(encoding="latin1")
    array_decl = set(re.findall(r"extern\s+[^;(]*?\b(\w+)\s*\[\]", declared))
    taken = set(syms)
    new_names = {}   # address -> (name, text)

    def expression(v):
        """(expression usable as a char/near pointer, needs_declaration)."""
        if v in by_addr:
            name = by_addr[v]
            return (name if name in array_decl or name in new_names.values() else "&" + name), name
        if v < modlink.DATA_END:
            def is_text(b):
                return 0x20 <= b < 0x7F or b in (9, 10, 13)
            start = v
            while start > 0 and is_text(image[ds + start - 1]):
                start -= 1
            end = image.index(b"\0", ds + v)
            text = image[ds + start:end].decode("latin1")
            if text and all(is_text(b) for b in image[ds + start:end]):
                if start in by_addr:
                    name = by_addr[start]
                else:
                    if start not in new_names:
                        new_names[start] = (name_for_text(text, taken), text)
                        taken.add(new_names[start][0])
                    name = new_names[start][0]
                if start in by_addr and name not in array_decl:
                    base = f"(char near *)&{name}"
                else:
                    base = name
                return (base if v == start else f"{base}+{v - start}"), name
        earlier = max(a for a in by_addr if a <= v)
        return f"(char near *)&{by_addr[earlier]}+{v - earlier}", by_addr[earlier]

    changes = 0
    for path in sorted((ROOT / "src").rglob("*.C")):
        if path.name in SKIP:
            continue
        raw = path.read_bytes().decode("latin1")
        parts = re.split(r"(/\*.*?\*/)", raw, flags=re.S)
        changed = False
        for i in range(0, len(parts), 2):
            def fix(m):
                nonlocal changed, changes
                v = int(m.group(2), 16)
                if v < 0x40 or (path.name, v) in KEEP:
                    return m.group(0)
                expr, _ = expression(v)
                changed = True
                changes += 1
                if m.group(1).startswith("MK_FP"):
                    return f"{m.group(1)}(unsigned)({expr})"
                if m.group(1).startswith("near"):
                    return f"{m.group(1)}({expr})"
                return f"{m.group(1)}{expr}"
            parts[i] = PATTERN.sub(fix, parts[i])
            if path.name in LOCAL:
                local = re.compile(f"({LOCAL[path.name]})(0x[0-9A-Fa-f]{{2,4}})\\b")
                parts[i] = local.sub(fix, parts[i])
        if changed:
            print(path.relative_to(ROOT))
            if write:
                path.write_bytes("".join(parts).encode("latin1"))
    print(f"{changes} uses rewritten; {len(new_names)} new names")
    for addr, (name, text) in sorted(new_names.items()):
        print(f"  {name}\tDS:{addr:04X}\t{text!r}")
    if write and new_names:
        lines = ["", "/* Strings the code reaches by address (names made from their text by",
                 "   tools/namestrings.py; the original passes their DS offsets). */"]
        for addr, (name, text) in sorted(new_names.items()):
            shown = text.replace("*/", "*\\/").encode("unicode_escape").decode("ascii")[:40]
            lines.append(f"extern char {name}[];".ljust(52) + f"/* DS:{addr:04X} \"{shown}\" */")
        nl = "\r\n" if "\r\n" in declared else "\n"
        body = declared.rstrip()
        assert body.endswith("#endif")
        DATA_H.write_bytes((body[:-len("#endif")].rstrip() + nl + nl.join(lines) + nl + nl + "#endif" + nl)
                           .encode("latin1"))


if __name__ == "__main__":
    main()

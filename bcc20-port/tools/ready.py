"""List the functions ready to translate: every function they call can be answered in replay.

    python3 tools/ready.py [--dir lexer] [--all] [--limit N]

A translated function is checked against its recorded calls; the functions it calls run as
translations or, when not translated yet, as stand-ins answered from the recording, which
needs their prototype (include/protos.h, variadic.h).  This reads the original sources
(../bcc20/src), finds each function's body and the known functions it names (calls, or
addresses taken), and prints the functions not yet in the port whose callees all are
translated or have prototypes, smallest first, with their file, size and how much of them
the corpus runs (../bcc20/build-source/MODTRACE/coverage.tsv when present).

--dir limits the list to one source directory; --all lists every untranslated function with
what it still waits for.  Functions written in TASM are listed by their module, not looked
into: their callees are not parsed.
"""
import argparse
import re
import sys
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]
BCC20 = PORT.parent / "bcc20"
sys.path.insert(0, str(BCC20 / "tools"))
sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402
import genadapters  # noqa: E402


def bodies(text, names):
    """function name -> body text, for the definitions in one C file"""
    text = re.sub(r"/\*.*?\*/", " ", text, flags=re.S)
    out = {}
    for m in re.finditer(r"^(?!\s)[^;{}()#=\n]*?\b(\w+)\s*\([^;{]*\)\s*\{", text, re.M):
        name = m.group(1)
        if name not in names:
            continue
        depth, i = 1, m.end()
        while depth and i < len(text):
            depth += {"{": 1, "}": -1}.get(text[i], 0)
            i += 1
        out[name] = text[m.end():i]
    return out


def call_graph():
    """(function -> its source, function -> its size, function -> the functions it names),
    by the names the sources use: C functions from their definitions, TASM ones from the
    target tables and symbols.tsv; sizes from the target table row at the same place"""
    import record
    offsets = record.function_offsets()
    data = record.modtest.ORIGINAL.read_bytes()
    header = record.struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    where, size, row_size = {}, {}, {}
    for m in modlink.load_modules():
        path = next(p for p in (BCC20 / "src").rglob(m.stem + ".*") if p.suffix.upper() in (".C", ".ASM"))
        start = m.base if m.overlay else header + original.block_para[m.block] * 16 + m.org
        for name, off in m.functions:
            row_size[start + off] = m.sizes.get(off, 0)
            if path.suffix.upper() == ".ASM":
                where[name] = path
    texts = {}
    for path in sorted((BCC20 / "src").rglob("*.C")):
        text = path.read_text(encoding="latin1")
        texts[path] = text
        for m in genadapters.HEAD.finditer(re.sub(r"/\*.*?\*/", " ", text, flags=re.S)):
            if m.group(2) not in genadapters.KEYWORDS:
                where.setdefault(m.group(2), path)
    names = set(where)
    for name in names:
        size[name] = row_size.get(offsets.get(name), 0)
    # other names for a defined function (a body label called directly, X_BODY): the
    # function defined at the same address
    at = {}
    for name in names:
        if name in offsets:
            at.setdefault(offsets[name], name)
    alias = {n: at[o] for n, o in offsets.items() if n not in names and o in at}
    calls = {}
    for path, text in texts.items():
        for name, body in bodies(text, names).items():
            words = set(re.findall(r"\b[A-Za-z_]\w*\b", body))
            calls[name] = {alias.get(w, w) for w in words if w in names or w in alias} - {name}
    return where, size, calls


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dir")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--limit", type=int, default=40)
    args = ap.parse_args()

    where, size, calls = call_graph()
    names = set(where)
    cov = {}
    cov_file = BCC20 / "build-source" / "MODTRACE" / "coverage.tsv"
    if cov_file.exists():
        for line in cov_file.read_text().splitlines()[1:]:
            parts = line.split("\t")
            if len(parts) == 5:
                cov[parts[1]] = parts[4]
    done = set(genadapters.prototypes())
    answerable = done | set(genadapters.definitions()) | {
        m.group(1) for m in re.finditer(r"\b(\w+)\s*\(", (PORT / "include" / "variadic.h").read_text())}

    rows = []
    for name in sorted(names - done):
        path = where[name]
        if args.dir and path.parent.name != args.dir:
            continue
        waits = sorted(calls.get(name, set()) - answerable) if path.suffix.upper() == ".C" else ["(TASM)"]
        if waits and not args.all:
            continue
        rows.append((size[name], name, path.relative_to(BCC20 / "src"), cov.get(name, "?"), waits))
    rows.sort()
    for sz, name, path, c, waits in rows[: args.limit if not args.all else None]:
        print(f"{name:32} {str(path):24} {sz:5} bytes  ran {c:>4}" + (f"  waits for {' '.join(waits)}" if waits else ""))
    print(f"{len(rows)} functions" + ("" if args.all else " ready") + f"; {len(done)} translated")


if __name__ == "__main__":
    main()

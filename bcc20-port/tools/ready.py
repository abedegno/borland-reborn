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
    """(function -> its source, function -> its size, function -> the functions it names)"""
    where, size = {}, {}
    for m in modlink.load_modules():
        path = next(p for p in (BCC20 / "src").rglob(m.stem + ".*") if p.suffix.upper() in (".C", ".ASM"))
        for name, off in m.functions:
            where[name] = path
            size[name] = m.sizes.get(off, 0)
    names = set(where)
    calls = {}
    for path in sorted(set(where.values())):
        if path.suffix.upper() != ".C":
            continue
        for name, body in bodies(path.read_text(encoding="latin1"), names).items():
            calls[name] = {w for w in re.findall(r"\b[A-Za-z_]\w*\b", body) if w in names and w != name}
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

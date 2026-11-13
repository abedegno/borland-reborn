"""List calls in src/ written with another name of a function, a stub or body label (such
as EXPECT_TOKEN_ELSE_REPORT for TREE_INVOKE): the port uses the original definition's
name, which is also the name the recorder gives the call.  Exits 1 when it finds one."""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import ready    # noqa: E402
import record   # noqa: E402

PORT = Path(__file__).resolve().parents[1]


def main():
    offsets = record.function_offsets()
    where, _, _ = ready.call_graph()
    at = {}
    for name in where:
        if name in offsets:
            at.setdefault(offsets[name], name)
    alias = {n: at[o] for n, o in offsets.items() if n not in where and o in at}
    found = 0
    for path in sorted((PORT / "src").rglob("*.c")):
        text = re.sub(r"/\*.*?\*/", " ", path.read_text(), flags=re.S)
        for name in sorted(set(re.findall(r"\b([A-Z_][A-Z0-9_]*)\s*\(", text)) & set(alias)):
            print(f"{path.relative_to(PORT)}: {name} is {alias[name]} (use the definition's name)")
            found = 1
    return found


if __name__ == "__main__":
    sys.exit(main())

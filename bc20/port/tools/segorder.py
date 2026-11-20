"""Finds pool accesses whose segment C may read before a call that can move the pool.

A pool accessor (TYPE_W(r, F), HLINK_W(n, F) and the rest, include/pool.h) reads the pool's
segment word each time.  Where its offset contains a call, as in HLINK_W(CREATE(name), F),
or a value it stores comes from one, as in TYPE_W(r, F) = NEW_X(), C does not order the
segment read against the call.  BCC.EXE always makes the call first; if the call grows the
pool, the heap may move it, and a segment read first is stale.  The replay check sees this
only when a recorded call moved the pool, so this scan looks for the shape: an accessor
whose offset or stored value calls a function that can reach an allocator (in src/'s call
graph; a call through a code pointer counts).

    python3 tools/segorder.py          # lists the places; exits 1 if there are any

Fix a place by making the call in a statement of its own, before the access.
"""
import re
import sys
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]

# calls that cannot allocate although the call graph cannot show it: hooks that only read
PURE = {"type_kind", "token_convert"}
# host helpers and machine-model macros that are not calls into BCC
SAFE = {"at", "W", "B", "D", "SB", "SW", "MK_FP", "FP_SEG", "FP_OFF", "fp_add", "NEAR", "LIN",
        "sizeof", "if", "while", "for", "switch", "return"}
ALLOCATORS = {"POOL_ALLOC", "POOL_ALLOC_REUSE", "RESIZE_POOL_BLOCK", "POOL_INIT", "MALLOC",
              "HEAP_ALLOC_HANDLE", "CALL_FAR", "CALL_FAR0", "CALL_NEAR"}


def strip_comments(text):
    return re.sub(r"/\*.*?\*/", lambda m: re.sub(r"[^\n]", " ", m.group(0)), text, flags=re.S)


def defines(text):
    """{name: body} of the #defines in text, and the names of the function-like ones"""
    out, fnlike = {}, set()
    for m in re.finditer(r"^\s*#\s*define\s+(\w+)(\()?(?:[^)\n]*\))?[ \t]*(.*)$", text, re.M):
        out[m.group(1)] = m.group(3)
        if m.group(2):
            fnlike.add(m.group(1))
    return out, fnlike


def balanced(text, i):
    """the text inside the parenthesis at i, and the index after its closing one"""
    depth = 0
    for j in range(i, len(text)):
        depth += {"(": 1, ")": -1}.get(text[j], 0)
        if depth == 0:
            return text[i + 1:j], j + 1
    return text[i + 1:], len(text)


def main():
    macros, fnlike = {}, set()
    for h in (PORT / "include").glob("*.h"):
        m, f = defines(h.read_text(errors="replace"))
        macros.update(m)
        fnlike |= f
    files = {f: strip_comments(f.read_text(errors="replace")) for f in sorted((PORT / "src").rglob("*.c"))}

    # the call graph of src/, and which functions can reach an allocator
    graph = {}
    for src in files.values():
        for m in re.finditer(r"^[A-Za-z_][\w \*]*?\b(\w+)\s*\([^;{)]*\)\s*\{", src, re.M):
            body, _ = balanced(src.replace("{", "(").replace("}", ")"), m.end() - 1)
            graph.setdefault(m.group(1), set()).update(re.findall(r"\b([A-Za-z_]\w*)\s*\(", body))
    can_alloc = set(ALLOCATORS)
    changed = True
    while changed:
        changed = False
        for name, calls in graph.items():
            if name not in can_alloc and calls & can_alloc:
                can_alloc.add(name)
                changed = True

    def is_pool(name, local, seen=()):
        """name is a macro that addresses a pool (MK_FP on a segment other than DGROUP)"""
        body = local.get(name, macros.get(name))
        if body is None or name in seen:
            return False
        if re.search(r"MK_FP\(\s*(?!DGROUP\b)", body):
            return True
        return any(is_pool(i, local, seen + (name,)) for i in re.findall(r"\b([A-Z_][A-Z0-9_]*)\s*\(", body))

    def calls(text, local, seen=()):
        out = []
        for c in re.findall(r"\b([A-Za-z_]\w*)\s*\(", text):
            if c in SAFE:
                continue
            body = local.get(c, macros.get(c))
            if body is not None:
                if c not in seen:
                    out += calls(body, local, seen + (c,))
                continue
            if c not in PURE and (c in can_alloc or c not in graph):
                out.append(c)
        return out

    found = 0
    for path, src in files.items():
        local, local_fn = defines(src)
        for m in re.finditer(r"\b([A-Z_][A-Z0-9_]*)\s*\(", src):
            name = m.group(1)
            if name not in fnlike | local_fn or not is_pool(name, local):
                continue
            if re.search(r"#\s*define\s+$", src[max(0, m.start() - 40):m.start()]):
                continue
            inner, end = balanced(src, m.end() - 1)
            where = calls(inner, local)
            kind = "offset"
            if not where:
                stored = re.match(r"\s*([-+|&^]?=)(?!=)([^;\n]*);", src[end:])
                if stored:
                    where, kind = calls(stored.group(2), local), "stored value"
            if where:
                found += 1
                line = src.count("\n", 0, m.start()) + 1
                print(f"{path.relative_to(PORT)}:{line}: {name}(...): its {kind} calls "
                      f"{', '.join(sorted(set(where)))} (call first, then access the pool)")
    return 1 if found else 0


if __name__ == "__main__":
    sys.exit(main())

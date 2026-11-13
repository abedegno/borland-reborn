"""Generate the port's prototypes and replay's adapters and stand-ins.

    python3 tools/genadapters.py protos            include/protos.h
    python3 tools/genadapters.py adapters OUT.c    build/adapters.c

include/protos.h declares every function of the original (../bcc20/src) in the port's
types, from its definition: unsigned char u8, char and signed char i8, unsigned and
unsigned short u16, int, short and enums i16, unsigned long u32, long i32, a far pointer
(data or code) farptr, a near pointer u16 (an offset in DGROUP, or in the segment the
function uses).  Functions written in TASM get theirs from the C sources' extern
declarations, when all of them agree.  Functions with float, struct or variable arguments
are left out (they need hand-written declarations), as are names declared in different
ways.

build/adapters.c holds, for each function the port defines (src/), an adapter that reads
its arguments where BCC.EXE's caller put them and stores its result where BCC.EXE returns
it; and for each function the port does not define, a stand-in with the same prototype that
replay answers from the recorded calls of that function made inside the call being replayed
(replay.c, "children").  The calling convention comes from the original definition: every
file is compiled -mm -p, so a function is far pascal unless declared near (a 2-byte return
address) or cdecl (arguments pushed right to left and left on the stack for the caller).
u8 to i16 arguments take a word, u32, i32 and farptr two; a u8 or i8 result is AL, u16 or
i16 AX, u32, i32 or farptr DX:AX.  replay/functions.c holds hand-written adapters, for
functions that pass values in other registers; they take precedence.
"""
import re
import sys
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]
BCC20_SRC = PORT.parent / "bcc20" / "src"
SIZE = {"u8": 2, "i8": 2, "u16": 2, "i16": 2, "u32": 4, "i32": 4, "farptr": 4}
RESULT = {"void": None, "u8": "AL", "i8": "AL", "u16": "AX", "i16": "AX",
          "u32": "DXAX", "i32": "DXAX", "farptr": "DXAX"}
ATTRS = {"far", "near", "huge", "pascal", "cdecl", "_loadds", "interrupt", "static", "extern",
         "_saveregs", "_fastcall"}
SCALAR = {"unsigned char": "u8", "char": "i8", "signed char": "i8",
          "unsigned": "u16", "unsigned int": "u16", "unsigned short": "u16",
          "unsigned short int": "u16", "int": "i16", "short": "i16", "signed": "i16",
          "signed int": "i16", "short int": "i16", "unsigned long": "u32",
          "unsigned long int": "u32", "long": "i32", "long int": "i32", "signed long": "i32"}
HEAD = re.compile(r"^(?!extern|typedef|\s)([^;{}()#=\n]*?)\b([A-Za-z_]\w*)\s*\(([^;{}]*)\)\s*\{", re.M)
# functions the original declares void that return a value in AX (a documented fall-off-end):
# the port gives them the result their callers through pointers expect
# functions that take a structure by value: their arguments as the words on the stack, in
# the order of a pascal call's pushes (the structure's words from the highest down)
STRUCT_ARGUMENTS = {
    # expr/EXPRPOOL.C MAKE_MEMBER_NODE(member, struct C21Location {file, line, word3})
    "MAKE_MEMBER_NODE": ("u16", ["u16", "u16", "u16", "u16"], False, False),
}
RETURN_OVERRIDES = {
    "PARSE_PP_IF_EXPRESSION": "i16",    # CPRAGFN.C: EVAL_EXPRESSION hook, PARSE_CONSTANT_EXPR's AX
}
KEYWORDS = {"if", "while", "for", "switch", "return", "sizeof", "char", "int", "short", "long",
            "unsigned", "signed", "void", "far", "near", "huge", "pascal", "cdecl", "struct",
            "union", "enum", "interrupt", "_loadds"}


_TYPEDEFS = None


def typedefs():
    """typedef name -> port type, for the sources' pointer and scalar typedefs"""
    global _TYPEDEFS
    if _TYPEDEFS is None:
        _TYPEDEFS = {}
        for path in sorted(BCC20_SRC.rglob("*.[CH]")):
            text = re.sub(r"/\*.*?\*/", " ", path.read_text(encoding="latin1"), flags=re.S)
            for m in re.finditer(r"\btypedef\s+([^;{}]*?);", text):
                body = m.group(1)
                f = re.search(r"\(\s*((?:far|near|pascal|cdecl|\s)*)\*\s*(\w+)\s*\)\s*\(", body)
                if f:                                   # a function pointer
                    _TYPEDEFS.setdefault(f.group(2), "farptr" if "far" in f.group(1) else "u16")
                    continue
                n = re.match(r"^(.*?)\b(\w+)\s*$", body)
                if n and n.group(1).strip():
                    t = port_type(n.group(1))
                    if t:
                        _TYPEDEFS.setdefault(n.group(2), t)
    return _TYPEDEFS


def port_type(text):
    """the port type of a C type (no name), or None if it has none"""
    t = re.sub(r"\b(register|const|volatile)\b", " ", text)
    t = re.sub(r"\s+", " ", t).strip()
    if re.fullmatch(r"\w+", t) and t not in SCALAR and _TYPEDEFS is not None and t in _TYPEDEFS:
        return _TYPEDEFS[t]
    if "(" in t:                                    # a function pointer
        return "farptr" if re.search(r"\bfar\b", t) else "u16"
    if "[" in t:
        return "u16"
    if "*" in t:
        before = t[: t.rindex("*")].split()
        return "farptr" if before and before[-1] in ("far", "huge") else "u16"
    if t.startswith("enum "):
        return "i16"
    return SCALAR.get(t)


def split_head(prefix):
    """(return type text, near?, cdecl?) from the text before a function's name"""
    words = prefix.replace("*", " * ").split()
    if "*" in words:
        last = len(words) - 1 - words[::-1].index("*")
        attrs, type_words = words[last + 1:], words[: last + 1]
    else:
        attrs = [w for w in words if w in ATTRS]
        type_words = [w for w in words if w not in ATTRS]
    type_words = [w for w in type_words if w not in ("static", "extern", "_loadds")]
    return " ".join(type_words) or "int", "near" in attrs, "cdecl" in attrs


def split_params(text):
    """a parameter list split at its top-level commas (a function pointer parameter has
    commas of its own inside parentheses)"""
    out, depth, start = [], 0, 0
    for i, c in enumerate(text):
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
        elif c == "," and depth == 0:
            out.append(text[start:i])
            start = i + 1
    out.append(text[start:])
    return out


def param_type(param):
    """the port type of one parameter declaration (with or without its name)"""
    p = param.strip()
    if "(" in p:
        return port_type(p)
    m = re.match(r"^(.*?)\b([A-Za-z_]\w*)\s*(\[[^\]]*\])?$", p)
    # an unnamed parameter whose type ends in a type word ("unsigned long"): no name
    if m and m.group(2) in ("int", "long", "short", "char", "signed", "unsigned"):
        m = None
    if m and m.group(1).strip() and port_type(m.group(1)) is not None:
        return port_type(m.group(1) + (m.group(3) or ""))
    return port_type(p)


def definitions():
    """name -> (result, [argument types], near, cdecl) for the original's functions"""
    typedefs()
    found, dup = {}, set()
    for path in sorted(BCC20_SRC.rglob("*.C")):
        text = re.sub(r"/\*.*?\*/", " ", path.read_text(encoding="latin1"), flags=re.S)
        for prefix, name, params in HEAD.findall(text):
            if name in KEYWORDS:
                continue
            ret_text, near, cdecl = split_head(prefix)
            ret = "void" if ret_text == "void" else port_type(ret_text)
            ps = params.strip()
            if ps in ("", "void"):
                args = []
            elif "..." in ps:
                args = None
            else:
                args = [param_type(p) for p in split_params(ps)]
            if ret is None or args is None or None in args:
                found.setdefault(name, None)
                continue
            d = (ret, args, near, cdecl)
            if found.get(name) not in (None, d):
                dup.add(name)
            found.setdefault(name, d)
    # functions written in TASM: their prototype from the C sources' extern declarations,
    # when every declaration agrees
    ext = re.compile(r"^\s*extern\s+([^;{}()#=\n]*?)\b([A-Za-z_]\w*)\s*\(([^;{}]*)\)\s*;", re.M)
    seen = {}
    for path in sorted(BCC20_SRC.rglob("*.[CH]")):
        text = re.sub(r"/\*.*?\*/", " ", path.read_text(encoding="latin1"), flags=re.S)
        for prefix, name, params in ext.findall(text):
            if name in found or name in KEYWORDS or "(" in prefix:
                continue
            ret_text, near, cdecl = split_head(prefix)
            ret = "void" if ret_text == "void" else port_type(ret_text)
            ps = params.strip()
            args = [] if ps in ("", "void") else None if "..." in ps else [param_type(x) for x in split_params(ps)]
            d = None if ret is None or args is None or None in args else (ret, tuple(args), near, cdecl)
            seen.setdefault(name, set()).add(d)
    for name, ds in seen.items():
        if len(ds) == 1 and None not in ds:
            ret, args, near, cdecl = ds.pop()
            found[name] = (ret, list(args), near, cdecl)
    found.update(STRUCT_ARGUMENTS)
    dup -= set(STRUCT_ARGUMENTS)
    for name, ret in RETURN_OVERRIDES.items():
        if name in found and found[name]:
            found[name] = (ret,) + tuple(found[name][1:])
    return {n: d for n, d in found.items() if d is not None and n not in dup}


def defined_in_port():
    names = set()
    for path in (PORT / "src").rglob("*.c"):
        text = re.sub(r"/\*.*?\*/", " ", path.read_text(), flags=re.S)
        names |= {m.group(2) for m in HEAD.finditer(text) if "static" not in m.group(1).split()} - KEYWORDS
    return names


def write_protos():
    defs = definitions()
    out = ["/* protos.h: every function of the original in the port's types, generated by",
           "   tools/genadapters.py from the definitions in ../bcc20/src; do not edit. */",
           "#ifndef PORT_PROTOS_H", "#define PORT_PROTOS_H", '#include "port.h"', ""]
    for name, (ret, args, near, cdecl) in sorted(defs.items()):
        out.append(f"{ret} {name}({', '.join(args) or 'void'});")
    out += ["", "#endif", ""]
    (PORT / "include" / "protos.h").write_text("\n".join(out))
    print(f"include/protos.h: {len(defs)} functions")


def offsets(args, near, cdecl):
    """argument offsets from SP at entry, and the bytes of return address plus arguments"""
    offs, at = [0] * len(args), 2 if near else 4
    for i in (range(len(args)) if cdecl else reversed(range(len(args)))):
        offs[i] = at
        at += SIZE[args[i]]
    return offs, at


def write_adapters(target):
    defs, mine = definitions(), defined_in_port()
    missing = sorted(n for n in mine - set(defs) if not n.islower())   # lower case: port helpers
    if missing:
        print(f"genadapters: no generated adapter (hand-write one): {' '.join(missing)}")
    lines = ["/* adapters.c: generated by tools/genadapters.py; do not edit. */",
             '#include "replay.h"', '#include "protos.h"', ""]
    table, all_table, stand_ins = [], [], []
    index = {}
    for name, (ret, args, near, cdecl) in sorted(defs.items()):
        offs, at = offsets(args, near, cdecl)
        res = RESULT[ret]
        outs = {None: "0", "AL": "OUT_AL", "AX": "OUT(R_AX)", "DXAX": "OUT(R_DX) | OUT(R_AX)"}[res]
        call = f"{name}({', '.join(f'({t})arg{32 if SIZE[t] == 4 else 16}(r, {o})' for t, o in zip(args, offs))})"
        body = {None: f"{call};", "AL": f"r[R_AX] = (r[R_AX] & 0xFF00) | (u8){call};",
                "AX": f"r[R_AX] = (u16){call};", "DXAX": f"ret32(r, (u32){call});"}[res]
        unused = "" if args or res else "(void)r; "
        lines.append(f"static void call_{name}(u16 *r) {{ {unused}{body} }}")
        entry = f'{{"{name}", call_{name}, {outs}, {at if cdecl else 0}, {2 if near else 4}}}'
        index[name] = len(all_table)
        all_table.append(f"    {entry},")
        if name in mine:
            table.append(f"    {entry},")
        else:
            params = ", ".join(f"{t} a{i}" for i, t in enumerate(args)) or "void"
            items = ", ".join(f"{{{o}, {SIZE[t]}, {1 if t in ('u8', 'i8') else SIZE[t]}, (u32)a{i}}}"
                              for i, (t, o) in enumerate(zip(args, offs)))
            arr = f"const StandInArg args[] = {{{items}}}" if args else "const StandInArg *args = 0"
            scall = f'stand_in("{name}", {outs}, args, {len(args)})'
            sbody = f"{scall};" if res is None else f"return ({ret}){scall};"
            stand_ins.insert(0, f"{ret} {name}({params}) {{ {arr}; {sbody} }}")
    lines[3:3] = ["/* stand-ins for the functions the port does not define (replay.c: stand_in) */"] + \
        sorted(stand_ins) + [""]
    lines += ["", "const Function GENERATED_FUNCTIONS[] = {"] + table + ["    {0, 0, 0, 0, 0},", "};", "",
              "const Function ALL_FUNCTIONS[] = {"] + all_table + ["    {0, 0, 0, 0, 0},", "};", ""]
    # BCC's functions by code address (symbols.tsv: resident code or an overlay stub entry),
    # for calls through code pointers: index into ALL_FUNCTIONS
    lines += ["typedef struct { u16 seg, off, function; } CodeName;", "const CodeName CODE_NAMES[] = {"]
    lines += [f"    {{0x{seg:04X}, 0x{off:04X}, {index[name]}}}," for (seg, off), name in
              sorted(code_addresses(defs).items())]
    lines += ["    {0, 0, 0xFFFF},", "};", ""]
    # near code pointers (handler tables hold offsets in their code segment): each module's
    # code segment, and the functions by file offset, for near_function()
    bases, at = segment_bases(), {}
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import record
    for name, off in record.function_offsets().items():
        if name in defs:
            at.setdefault(off, name)
    lines += ["typedef struct { const char *module; u32 base; } ModuleBase;",
              "const ModuleBase MODULE_BASES[] = {"]
    lines += [f'    {{"{stem}", 0x{base:X}}},' for stem, base in sorted(bases.items())]
    lines += ["    {0, 0},", "};", "typedef struct { u32 at; u16 function; } CodeAt;", "const CodeAt CODE_AT[] = {"]
    lines += [f"    {{0x{off:X}, {index[name]}}}," for off, name in sorted(at.items())]
    lines += ["    {0, 0xFFFF},", "};", ""]
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text("\n".join(lines))


def segment_bases():
    """module -> file offset of its code segment's start (an overlay's segment, or the
    resident code block), what a near code pointer in it is relative to"""
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import struct
    import record
    data = record.modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = record.modlink.Original()
    out = {}
    for m in record.modlink.load_modules():
        out[m.stem] = m.base - m.org if m.overlay else header + original.block_para[m.block] * 16
    return out


def code_addresses(defs):
    """(segment from the load segment, offset) -> declared function: the addresses BCC's code
    is called at, from symbols.tsv and from every entry of every overlay stub segment (an
    overlay function's address as data is its stub entry; symbols.tsv names only some)"""
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import struct
    import record
    offsets = record.function_offsets()
    by_offset = {}
    for name, off in offsets.items():
        if name in defs:
            by_offset.setdefault(off, name)
    out = {}
    for line in (PORT.parent / "bcc20" / "symbols.tsv").read_text().splitlines():
        parts = line.split("\t")
        if len(parts) >= 2 and parts[0] in defs and re.fullmatch(r"[0-9A-F]{4}:[0-9A-F]{4}", parts[1]):
            seg, off = (int(x, 16) for x in parts[1].split(":"))
            out[(seg, off)] = parts[0]
    data = record.modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = record.modlink.Original()
    for para in range((len(data) - header) // 16):
        at = header + para * 16
        if data[at:at + 4] != b"\xcd\x3f\x00\x00":
            continue
        count = struct.unpack_from("<H", data, at + 12)[0]
        entries = [at + 0x20 + 5 * i for i in range(count)]
        if not count or count > 400 or any(data[e:e + 2] != b"\xcd\x3f" for e in entries):
            continue
        base = original.stub_file_offset(para) + record.modlink.OVERLAY_BASE
        for e in entries:
            name = by_offset.get(base + struct.unpack_from("<H", data, e + 2)[0])
            if name:
                out.setdefault((para, e - at), name)
    return out


def prototypes():
    """the translated functions: name -> (result, args)"""
    defs, mine = definitions(), defined_in_port()
    return {n: (d[0], d[1]) for n, d in defs.items() if n in mine}


if __name__ == "__main__":
    if sys.argv[1:2] == ["protos"]:
        write_protos()
    elif sys.argv[1:2] == ["adapters"]:
        write_adapters(Path(sys.argv[2]))
    else:
        raise SystemExit(__doc__)

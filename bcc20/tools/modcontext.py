"""Context sources in the modding build: compile them as Borland did, keep their own code.

Seven sources are compiled with other sources in front of them (`/* context: FILE.C */`
lines): Borland compiled those helpers in the same file, so the primary's calls to them are
near calls (`push cs; call near`) with no fixup.  The exact build proves this with Exhume's
tools/compile_context.py, which needs the original's sizes and call offsets.  An edited
source has other sizes and offsets, so the modding build finds them itself:

1. the helpers are the closure of the context lines, in their original address order;
2. the composed source (helpers, then the primary) is compiled;
3. each helper's part must equal that helper's own object, with fixup positions masked
   (its object from the gate, or from this build when the helper was changed too), which
   proves where each part ends;
4. the primary's part is cut out (Exhume's context_omf slicer), and each near call or jump
   from it into a helper becomes a near reference to the helper's name: the helper's
   public at that offset, or, for a static entry at its start, the body alias that the
   `context-call:` lines give (for instance RVECSET_BODY, an alias of RVECSET in
   exhume.toml).

Anything else that crosses from the primary into a helper (a short jump, an address of a
helper's code) is refused, as is data defined by the composed source.
"""
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXHUME = next(p for p in (ROOT / "exhume", ROOT.parent / "exhume") if (p / "tools").is_dir())
sys.path.insert(0, str(EXHUME / "tools"))

CONTEXT = re.compile(r"/\*\s*context:\s*(\S+?)\s*\*/")
CALL = re.compile(r"/\*\s*context-call:\s*\S+\s+(\S+)\s+(\S+)\s*\*/")


def head(path):
    return Path(path).read_bytes()[:4000].decode("latin1")


def helpers_of(path, find):
    """The context helpers of path, nested ones included, as paths; find(name) -> path."""
    out, seen = [], set()

    def visit(p):
        for name in CONTEXT.findall(Path(p).read_text(encoding="latin1")):
            helper = find(name)
            if helper is None:
                raise SystemExit(f"{Path(p).name}: context source {name} not found")
            if helper.stem.upper() not in seen:
                seen.add(helper.stem.upper())
                visit(helper)
                out.append(helper)
    visit(path)
    # in the order Borland's file had them: their original addresses (each helper's own
    # helpers come before it there)
    return sorted(out, key=original_base)


def original_base(path):
    m = re.search(r"/\*\s*target:\s*(\S+)", head(path))
    if not m:
        raise SystemExit(f"{Path(path).name}: a context source must be a matched source with a target")
    first = (ROOT / "targets" / f"{m.group(1)}.tsv").read_text().splitlines()[0]
    return int(re.search(r"base (0x[0-9A-Fa-f]+)", first).group(1), 16)


def compose(primary, helpers):
    return "\n".join(Path(p).read_text(encoding="latin1") for p in [*helpers, primary])


def body_aliases(src_dirs):
    """Helper entry name -> the alias its callers name, from every context-call line."""
    out = {}
    for d in src_dirs:
        for p in Path(d).rglob("*.C"):
            for entry, alias in CALL.findall(p.read_text(encoding="latin1")):
                out.setdefault(entry, alias)
    return out


def private_entries(primary_text, helpers):
    """Helper stem -> the static entry name its context-helper-entry line gives."""
    out = {}
    for value in re.findall(r"/\*\s*context-helper-entry:\s*(.*?)\s*\*/", primary_text):
        parts = value.split()
        if len(parts) == 2:
            out[Path(parts[0]).stem.upper()] = parts[1]
        elif len(helpers) == 1:
            out[helpers[0].stem.upper()] = parts[0]
    return out


def _masked(obj):
    mask = set()
    for f in obj.fixups:
        mask.update(range(f.offset, f.offset + f.width))
    return mask


def split(raw, primary, helpers, helper_objects, aliases, find):
    """The primary's object from the composed compile's object raw.  helper_objects[i] is
    the object bytes of helpers[i] compiled on its own (in its own context)."""
    from context_omf import inspect_object, _slice_multi, SplitError
    from iced_x86 import Decoder, FlowControl, OpKind
    try:
        obj = inspect_object(raw)
    except SplitError as e:
        raise SystemExit(f"{primary.name}: the composed object cannot be split ({e})")
    regions, cursor = [], 0
    for helper, data in zip(helpers, helper_objects):
        hobj = inspect_object(data)
        size = len(hobj.code)
        mask = _masked(hobj)
        part = obj.code[cursor:cursor + size]
        if len(part) != size or any(part[i] != hobj.code[i] for i in range(size) if i not in mask):
            raise SystemExit(f"{primary.name}: the code of context source {helper.name} in the composed "
                             "compile differs from its own object, so the parts cannot be told apart")
        names = {off: name for name, (_, off) in hobj.publics.items()}
        regions.append((cursor, size, helper, names))
        cursor += size
    start, end = cursor, len(obj.code)
    if start >= end:
        raise SystemExit(f"{primary.name}: no code left after its context sources")
    entries = private_entries(Path(primary).read_text(encoding="latin1"), helpers)
    for h in helpers:   # nested helpers name their own helpers' entries
        entries.update(private_entries(Path(h).read_text(encoding="latin1"), helpers_of(h, find)))

    def name_at(target, ip):
        for base, size, helper, names in regions:
            if base <= target < base + size:
                off = target - base
                if off in names:
                    return names[off]
                entry = entries.get(helper.stem.upper())
                if off == 0 and entry and entry in aliases:
                    return aliases[entry]
                raise SystemExit(f"{primary.name}: code at {ip - start:04X} goes to {helper.name}+{off:04X}, "
                                 "which has no name to link it by")
        raise SystemExit(f"{primary.name}: code at {ip - start:04X} goes before the code")

    # A call to a helper is `push cs; call near` (the far call Borland makes to a function
    # of the same file).  Any other branch from the primary into a helper (a jump shared
    # with a helper's tail, say) cannot be cut, and is refused.
    fixed = _masked(obj)
    code = obj.code
    additions = {}
    for ins in Decoder(16, code[start:end], ip=start):
        if ins.is_invalid or ins.op0_kind != OpKind.NEAR_BRANCH16 or ins.near_branch_target >= start:
            continue
        if ins.next_ip - 2 in fixed:
            continue    # already an external reference
        if ins.flow_control != FlowControl.CALL or ins.len != 3 or ins.ip == start or code[ins.ip - 1] != 0x0E:
            raise SystemExit(f"{primary.name}: the {ins} at {ins.ip - start:04X} goes into a context "
                             "source, and only push cs; call near can be cut")
        additions[ins.ip] = (ins.ip, name_at(ins.near_branch_target, ins.ip), ins.near_branch_target)
    # Data in the code (a switch table) can put the linear decoding out of step; a call it
    # skipped would be left pointing at nothing, so look for the bytes as well.
    entries_at = {base for base, *_ in regions} | {base + off for base, _, _, names in regions for off in names}
    for at in range(start + 1, end - 2):
        target = (at + 3 + struct.unpack_from("<h", code, at + 1)[0]) & 0xFFFF
        if code[at - 1] == 0x0E and code[at] == 0xE8 and target in entries_at and at not in additions \
                and at + 1 not in fixed:
            raise SystemExit(f"{primary.name}: bytes at {at - start:04X} look like a call to a context "
                             "source that the decoding did not see")
    try:
        return _slice_multi(obj, start, end, additions)
    except SplitError as e:
        raise SystemExit(f"{primary.name}: its code cannot be cut from its context sources ({e})")

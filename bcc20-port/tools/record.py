"""Record calls of BCC.EXE functions over the test corpus, for build/replay.

    python3 tools/record.py FUNCTION... [--per-run N] [--max N] [--runs N] [--emu2 PATH]
    python3 tools/record.py --all ...      every function the port declares (include/*.h)

Runs Borland's BCC.EXE over the corpus of ../bcc20/tools/modtest.py in the tracing emu2 with
its call recorder on (EMU2_RECORD), and writes records/FUNCTION.rec: up to --max different
calls of each function (default 500; identical calls are kept once).  --per-run caps the
calls kept from one compile (default 40), so the records come from many inputs; --runs
limits the number of compiles (default all; they are spread evenly over the corpus).

A function is found by its name in the matched tree (../bcc20/src, the target tables): its
first instruction's offset in BCC.EXE, which holds for overlay code too.  Inside each
recorded call, the calls it makes to functions the port does not define yet (directly, or
through translated functions) are recorded as its children (EMU2_RECORD_INNER), so replay
can answer them; they follow their parent in the file, named on their CALL lines.  The
overlay manager's work (OVRMGR, OVRLOAD: loading an overlay when one calls into another) is
not recorded (EMU2_RECORD_IGNORE): no translation does it.  The compile and
-S steps are recorded; steps that link are not (TLINK would run in the same emulator).
The records hold memory of Borland's program, so records/ is never committed.
"""
import argparse
import hashlib
import os
import re
import shutil
import struct
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

PORT = Path(__file__).resolve().parents[1]
BCC20 = PORT.parent / "bcc20"
sys.path.insert(0, str(BCC20 / "tools"))
sys.path.insert(0, str(Path(__file__).resolve().parent))
import modlink  # noqa: E402
import modtest  # noqa: E402
import genadapters  # noqa: E402

WORK = PORT / "build" / f"record-{os.getpid()}"   # one per run: agents record in parallel


def function_offsets():
    """name -> offset of its first instruction in BCC.EXE.  From ../bcc20/symbols.tsv: a
    resident function's segment:offset, or an overlay function's stub entry (CD 3F and the
    offset in the overlay), whose overlay starts at the stub's file offset; then the target
    tables, whose older names some functions still have there."""
    data = modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    out = {}
    overlay_seg = {}     # overlay number -> its code segment's file offset
    for m in modlink.load_modules():
        n = re.match(r"ovr(\d+)_", m.target)
        if n:
            overlay_seg.setdefault(int(n.group(1)), m.base - m.org)
    for line in (BCC20 / "symbols.tsv").read_text().splitlines():
        parts = line.split("\t")
        ovl = len(parts) >= 2 and re.fullmatch(r"OVL:([0-9A-F]{4}):([0-9A-F]{4})", parts[1])
        if ovl:              # OVL:nn:off, an offset in overlay nn (a body label)
            number, off = (int(x, 16) for x in ovl.groups())
            if number in overlay_seg:
                out[parts[0]] = overlay_seg[number] + off
            continue
        if len(parts) < 2 or not re.fullmatch(r"[0-9A-F]{4}:[0-9A-F]{4}", parts[1]):
            continue
        seg, off = (int(x, 16) for x in parts[1].split(":"))
        at = header + seg * 16
        if data[at:at + 2] == b"\xcd\x3f" and data[at + off:at + off + 2] == b"\xcd\x3f":
            out[parts[0]] = (original.stub_file_offset(seg) + modlink.OVERLAY_BASE
                             + struct.unpack_from("<H", data, at + off + 2)[0])
        else:
            out[parts[0]] = at + off
        if parts[0].startswith("_") and not parts[0].startswith("__"):
            out.setdefault(parts[0][1:], out[parts[0]])    # a cdecl function's C name
    for m in modlink.load_modules():
        start = m.base if m.overlay else header + original.block_para[m.block] * 16 + m.org
        for name, off in m.functions:
            out.setdefault(name, start + off)
    # static functions inside another function's row of the target table, at the offset in
    # that row where their frame starts (the comments of the source give the offsets)
    for name, (row, off) in INNER_BODIES.items():
        at = out[row] + off
        assert data[at:at + 3] == b"\x55\x8b\xec" or data[at:at + 4] == b"\x45\x55\x8b\xec", name
        out.setdefault(name, at)
    return out


INNER_BODIES = {
    "C78_special_symbol": ("RESOLVE_SYMBOL_REFERENCE", 0x88),      # EXPRDISP.C
    "C78_reconcile_pair": ("RESOLVE_SYMBOL_REFERENCE", 0xD3),
    "C78_lower_value": ("RESOLVE_SYMBOL_REFERENCE", 0x4E5),
    "C78_apply_value_type": ("RESOLVE_SYMBOL_REFERENCE", 0x56A),
    "REASSOCIATE_OPERANDS": ("BCC_EXPR_6CC3", 0),                 # CONSTFLD.C, under its row name
    "COUNT_SYMBOL_USES": ("IS_TRIVIAL_ARGUMENT", 0x63),           # INLINEXP.C
    "MAKE_VOID_ZERO_NODE": ("SIMPLIFY_BINARY", 0x23F),            # SIMPLIFY.C, after the switch table
    "BEGIN_SOURCE_FILE": ("SCAN_FILE_SYMBOLS_C", 0x258),          # SYMSCANC.C, after the switch table
    "BCC_STMT_CHECK_TYPE_NEAR": ("STCTYPE", 0),                   # CDECL.C, under its row name
    "CTORBODY": ("C11FIND", 0),                                   # CTORBODY.C, under its row name
    "IMPLMEMB": ("C12CHECK", 0),                                  # IMPLMEMB.C, under its row name
    "HANDLE_NEGATED_FLAG_OPTION": ("HANDLE_FLAG_OPTION", 0x79),   # OPTIONS.C, after the switch table
    "COPY_TO_END": ("FNSPLIT", 0x1A5),                            # RFNSPLIT.C, after FNSPLIT's retf
    "INITTYPE": ("C9BANKS", -0x182),                              # INITTYPE.C, at the overlay's start
}


def ignored_code():
    """the overlay manager's code, as EMU2_RECORD_IGNORE ranges of file offsets"""
    data = modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    ranges = []
    for m in modlink.load_modules():
        if m.stem in ("OVRMGR", "OVRLOAD"):
            start = header + original.block_para[m.block] * 16 + m.org
            ranges.append(f"{start:X}-{start + m.size - 1:X}")
    return ",".join(ranges)


def boundary(functions):
    """the functions the port does not define that these reach directly or through
    translated functions, and every untranslated function whose address is taken (it may
    be called through a pointer): what their translations call as stand-ins"""
    import ready
    where, _, graph = ready.call_graph()
    done = set(genadapters.prototypes())
    out, seen, todo = set(), set(), list(functions)
    # functions called through pointers (callbacks, hook tables) are not in the call graph:
    # every function whose address is taken somewhere may be called that way
    names = set(where)
    taken = set()
    for path in set(where.values()):
        if path.suffix.upper() == ".C":
            text = re.sub(r"/\*.*?\*/", " ", path.read_text(encoding="latin1"), flags=re.S)
            taken |= {m.group(1) for m in re.finditer(r"\b([A-Za-z_]\w*)\b(?!\s*\()", text)
                      if m.group(1) in names}
    # and the code pointers in the data segment's initial values
    dgroup = (BCC20 / "src" / "data" / "DGROUP.ASM").read_text(encoding="latin1")
    taken |= {m.group(1) for m in re.finditer(r"^\s+dd\s+([A-Za-z_@][\w@]*)", dgroup, re.M)}
    # near code pointers (handler tables), which DGROUP.ASM gives as numbers named in comments
    taken |= {m.group(1) for m in re.finditer(r";\s*@code\s+([A-Za-z_]\w*)", dgroup)} & names
    out |= taken - done
    # a translated function reached through a pointer runs in the port, so what it calls
    # is reached too
    todo += sorted(taken & done)
    while todo:
        f = todo.pop()
        for c in graph.get(f, ()):
            if c in done:
                if c not in seen:
                    seen.add(c)
                    todo.append(c)
            else:
                out.add(c)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("functions", nargs="*")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--per-run", type=int, default=40)
    ap.add_argument("--max", type=int, default=500)
    ap.add_argument("--runs", type=int, default=0)
    ap.add_argument("--emu2", default=os.environ.get("EMU2_TRACE_BIN",
                    str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2")))
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--only", help="record only the compiles of this corpus test name")
    ap.add_argument("--out", help="write the records here instead of records/")
    args = ap.parse_args()

    if args.all:
        args.functions = sorted(genadapters.prototypes())
    if not args.functions:
        raise SystemExit("record: name the functions, or --all")
    offsets = function_offsets()
    missing = [f for f in args.functions if f not in offsets]
    if missing:
        raise SystemExit(f"record: not in the matched tree: {' '.join(missing)}")
    wanted = {offsets[f]: f for f in args.functions}
    # children by offset; where names share an address, the one the port declares (the name
    # replay's stand-in and code_function() use)
    declared = genadapters.definitions()
    inner = {}
    for f in sorted(boundary(args.functions), key=lambda f: f not in declared):
        if f in offsets:
            inner.setdefault(offsets[f], f)
    for name, off in offsets.items():
        if off in inner and name in declared and inner[off] not in declared:
            inner[off] = name
    # an address of a translated function is never a child, whatever name reached it
    translated = {offsets[f] for f in genadapters.prototypes() if f in offsets}
    inner = {off: name for off, name in inner.items() if off not in translated}

    jobs = [(name, path, opts, mode) for name, path, opts, steps in modtest.corpus()
            for modes in steps for mode in modes if mode in ("-c", "-S")]
    if args.only:
        jobs = [j for j in jobs if j[0] == args.only]
    if args.runs and args.runs < len(jobs):
        jobs = [jobs[i * len(jobs) // args.runs] for i in range(args.runs)]
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    env_at = ",".join(f"{o:X}" for o in wanted)
    env_inner = ",".join(f"{o:X}" for o in inner)
    env_ignore = ignored_code()
    env_unwind = f"{offsets['C45_LONGJUMP']:X}"     # the run-time library's long jump

    def run(job):
        index, (name, path, opts, mode) = job
        d = WORK / "runs" / f"{index:04d}"
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
        src = d / modtest.source_name(path)
        shutil.copy(path, src)
        env = dict(os.environ, EMU2_RECORD=str(d / "rec"), EMU2_RECORD_AT=env_at,
                   EMU2_RECORD_UNWIND=env_unwind,
                   EMU2_RECORD_INNER=env_inner, EMU2_RECORD_IGNORE=env_ignore,
                   EMU2_RECORD_MAX=str(args.per_run))
        try:
            done = subprocess.run([args.emu2, "BCC.EXE", *modtest.command(mode, opts, src.name)],
                                  cwd=d, env=env, capture_output=True, timeout=300)
            # the recorder refuses lists it cannot hold; never take that run as no calls
            if b"emu2 record:" in done.stderr:
                raise SystemExit(done.stderr.decode(errors="replace").strip())
        except subprocess.TimeoutExpired:
            pass
        text = "".join(f.read_text() for f in d.glob("rec.*"))
        shutil.rmtree(d)
        return text

    # only each call's hash stays in memory; the bodies go to one spool file per function
    # (holding them all took several GB once the port had 1500 functions)
    calls = {f: set() for f in args.functions}
    spool = WORK / "spool"
    spool.mkdir()
    out = Path(args.out) if args.out else PORT / "records"
    out.mkdir(exist_ok=True)
    for name in args.functions:     # the new records replace them; free the disk first
        (out / f"{name}.rec").unlink(missing_ok=True)
    with ThreadPoolExecutor(args.jobs) as pool:
        for text in pool.map(run, enumerate(jobs)):
            children = {}
            for rec in re.findall(r"^CALL .*?^END\n", text, re.M | re.S):
                head, body = rec.split("\n", 1)
                off = int(head.split()[1], 16)
                if body.startswith("PARENT "):
                    parents = []    # each parent with its external writes (X lines)
                    while body.startswith("PARENT "):
                        parent, body = body.split("\n", 1)
                        xs = ""
                        while body.startswith("X "):
                            x, body = body.split("\n", 1)
                            xs += x + "\n"
                        parents.append((*parent.split()[1:], xs))
                    for p_off, p_seq, index, xs in parents:
                        children.setdefault((int(p_off, 16), int(p_seq)), []).append(
                            (int(index), f"CALL {off:X} 0 {inner[off]}\nPARENT\n{xs}{body}"))
                    continue
                name = wanted[off]
                kids = "".join(k for _, k in sorted(children.pop((off, int(head.split()[2])), [])))
                if len(calls[name]) < args.max:
                    key = hashlib.sha1((body + kids).encode()).hexdigest()
                    if key not in calls[name]:
                        calls[name].add(key)
                        with open(spool / name, "a") as f:
                            f.write(f"CALL {offsets[name]:X} {len(calls[name]) - 1}\n{body}{kids}")
    for name, found in calls.items():
        target = out / f"{name}.rec"
        target.unlink(missing_ok=True)
        if (spool / name).exists():
            shutil.move(spool / name, target)
        else:
            target.write_text("")
        print(f"{name}: {len(found)} different calls from {len(jobs)} compiles -> records/{name}.rec")
    shutil.rmtree(WORK, ignore_errors=True)


if __name__ == "__main__":
    main()

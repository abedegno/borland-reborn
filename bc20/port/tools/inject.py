"""Records calls of functions BCC.EXE never makes over the corpus (tools/coverage.py lists
them), so that they are checked like every other function (README.md, "How a translation
is checked").  For a target, a trigger is a function in the same code segment (overlay, or
resident segment) that the corpus does run; a far function with an entry in the load
module (resident, or an overlay stub) is also called through it from triggers anywhere.  BCC.EXE compiles a corpus test in the tracing emu2 with
EMU2_RECORD_INJECT: at the trigger's HIT-th entry (BCC's state is that of a real compile)
the tracer pushes arguments in the target's calling convention and calls it; when it
returns, the program ends.  The call is recorded as any other, children included, into
records/TARGET.rec, and `make check` replays it.

The arguments are the trigger's own (in a module, a sibling usually takes nodes, symbols
or types of the same pools), small constants and random words, over many variants; a far
pointer is one of the trigger's or a DGROUP address.  A variant that hangs or crashes in
BCC.EXE gives no record (a call cut short with no long jump or exit to end it is left out,
and so is one that ran bytes the program never loaded, a call through a null pointer, or
whose stack went below BCC's own limit, 8F0Ch, over its data).

    python3 tools/inject.py [NAME ...] [--variants N] [--jobs J]
                            (default: the functions build/check.txt lists as not reached)
"""
import argparse
import hashlib
import os
import random
import re
import shutil
import struct
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import genadapters   # noqa: E402
import record        # noqa: E402

modtest, modlink = record.modtest, record.modlink
PORT = Path(__file__).resolve().parents[1]
WORK = PORT / "build" / f"inject-{os.getpid()}"
DGROUP_SEG = 0x0E86          # DGROUP's segment when BCC.EXE runs in emu2 (the records' DS)
WIDE = {"farptr", "u32", "i32"}


def modules():
    """(start, end, key) of every code module, by file offset; the key names its code
    segment: an overlay's number, or a resident block and segment"""
    data = modtest.ORIGINAL.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    original = modlink.Original()
    out = []
    for m in modlink.load_modules():
        start = m.base if m.overlay else header + original.block_para[m.block] * 16 + m.org
        number = re.match(r"ovr(\d+)_", m.target)
        key = ("ovr", int(number.group(1))) if number else ("res", m.block, m.segment)
        out.append((start, start + m.size, key))
    return out


def far_entries():
    """name -> (segment, offset) of a far entry in the load module (symbols.tsv: a resident
    function, or an overlay function's stub)"""
    out = {}
    for line in (record.BCC20 / "symbols.tsv").read_text().splitlines():
        parts = line.split("\t")
        if len(parts) >= 2 and re.fullmatch(r"[0-9A-F]{4}:[0-9A-F]{4}", parts[1]):
            seg, off = (int(x, 16) for x in parts[1].split(":"))
            out[parts[0]] = (seg, off)
    return out


def recorded(name):
    path = PORT / "records" / f"{name}.rec"
    return path.exists() and path.stat().st_size > 0


def triggers(target, offsets, defs, mods):
    """functions of target's module that the corpus runs, with whether each is far"""
    at = offsets[target]
    key = next((k for s, e, k in mods if s <= at < e), None)
    if not key:
        return []
    spans = [(s, e) for s, e, k in mods if k == key]
    found = []
    for name, off in offsets.items():
        if name != target and any(s <= off < e for s, e in spans) and name in defs and recorded(name):
            found.append((name, off, not defs[name][2]))
    found.sort(key=lambda t: -(PORT / "records" / f"{t[0]}.rec").stat().st_size)
    seen, unique = set(), []
    for t in found:                # one name per address
        if t[1] not in seen:
            seen.add(t[1])
            unique.append(t)
    return unique[:4]


def argument_words(types, cdecl, rng):
    """the words to push, in push order: pascal left to right, cdecl right to left; a
    4-byte argument's high word first"""
    def word():
        return rng.choice(["T0", "T1", "T2", "T3", "T0", "T1", "0", "1", "2", "10",
                           f"{rng.randrange(0, 0x800) * 2:X}"])
    values = []
    for t in types:
        if t == "farptr":
            if rng.random() < 0.5:
                values.append(["T1", "T0"] if rng.random() < 0.5 else ["T3", "T2"])
            else:
                values.append([f"{DGROUP_SEG:X}", word()])
        elif t in ("u32", "i32"):
            values.append(["0" if rng.random() < 0.7 else word(), word()])
        else:
            values.append([word()])
    if cdecl:
        values.reverse()
    return [w for v in values for w in v]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("functions", nargs="*")
    ap.add_argument("--variants", type=int, default=24)
    ap.add_argument("--tests", type=int, default=3, help="corpus tests each variant runs on")
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--max", type=int, default=200)
    ap.add_argument("--seed", type=int, default=1)
    ap.add_argument("--emu2", default=str(modtest.EXHUME / "tools" / "emu2-trace" / "emu2"))
    args = ap.parse_args()
    targets = args.functions or re.search(r"not checked:(.*)", (PORT / "build" / "check.txt").read_text()).group(1).split()
    offsets = record.function_offsets()
    defs = genadapters.definitions()
    mods = modules()
    corpus = record.corpus_steps()
    rng = random.Random(args.seed)
    shutil.rmtree(WORK, ignore_errors=True)
    WORK.mkdir(parents=True)
    modtest.headers(WORK)
    shutil.copy(modtest.ORIGINAL, WORK / "BCC.EXE")
    shutil.copy(modtest.ORIGINAL.parent / "TLINK.EXE", WORK / "TLINK.EXE")
    env_ignore = record.ignored_code()
    env_unwind = f"{offsets['C45_LONGJUMP']:X}"
    translated = {offsets[f] for f in genadapters.prototypes() if f in offsets}

    entries = far_entries()
    # triggers for a call through a far entry: the far functions the corpus runs most
    anywhere = sorted(((n, offsets[n], True) for n in defs if n in offsets and not defs[n][2] and recorded(n)),
                      key=lambda t: -(PORT / "records" / f"{t[0]}.rec").stat().st_size)[:4]
    plans = []      # (target, inject spec, corpus job)
    for target in targets:
        if target not in defs or target not in offsets:
            print(f"{target}: no definition or offset, skipped")
            continue
        _, types, near, cdecl = defs[target]
        trig = triggers(target, offsets, defs, mods)
        # a far function with an entry in the load module can be called from anywhere
        via_entry = not near and target in entries
        if not trig and not via_entry:
            print(f"{target}: nothing in its code segment runs over the corpus, skipped")
            continue
        for v in range(args.variants):
            entry = via_entry and (not trig or v % 2)
            name, off, far = (anywhere if entry else trig)[v % len(anywhere if entry else trig)]
            words = argument_words(types, cdecl, rng)
            hit = rng.choice([1, 1, 2, 3, 5, 10, 30, 100])
            flags = (0 if near else 1) | (2 if far else 0)
            where = "S%X:%X" % entries[target] if entry else f"{offsets[target]:X}"
            spec = ",".join([f"{off:X}", where, f"{hit:X}", f"{flags:X}", *words])
            for _ in range(args.tests):
                plans.append((target, spec, corpus[rng.randrange(len(corpus))]))

    inner_of = {}
    for target in {p[0] for p in plans}:
        inner = {}
        # the program's exit too, reached through pointers the call graph does not show:
        # a call that ends the program then records how (its last child)
        for f in [*record.boundary([target]), "C0_TERMINATE"]:
            if f in offsets and offsets[f] not in translated:
                inner.setdefault(offsets[f], f)
        inner_of[target] = inner

    def run(job):
        index, (target, spec, (name, path, opts, modes)) = job
        d = WORK / "runs" / f"{index:05d}"
        d.mkdir(parents=True)
        modtest.stage(d, path, WORK)
        (d / "BCC.EXE").symlink_to(WORK / "BCC.EXE")
        (d / "TLINK.EXE").symlink_to(WORK / "TLINK.EXE")
        src = d / modtest.source_name(path)
        shutil.copy(path, src)
        record.stage_config(d, path)
        env = dict(os.environ, EMU2_RECORD=str(d / "rec"), EMU2_RECORD_AT=f"{offsets[target]:X}",
                   EMU2_RECORD_INNER=",".join(f"{o:X}" for o in inner_of[target]),
                   EMU2_RECORD_IGNORE=env_ignore, EMU2_RECORD_UNWIND=env_unwind,
                   EMU2_RECORD_MAX="100000", EMU2_RECORD_INJECT=spec)
        texts = []
        for mode in modes:
            try:
                subprocess.run([args.emu2, "BCC.EXE", *modtest.command(mode, opts, src.name)],
                               cwd=d, env=env, capture_output=True, timeout=60)
            except subprocess.TimeoutExpired:
                pass
            texts += [f.read_text() for f in sorted(d.glob("rec.*"))]
            for f in d.glob("rec.*"):
                f.unlink()
            if texts and "CALL " in "".join(texts):
                break
        shutil.rmtree(d)
        return target, texts

    calls = {t: [] for t in targets}
    keys = {t: set() for t in targets}
    with ThreadPoolExecutor(args.jobs) as pool:
        for target, texts in pool.map(run, enumerate(plans)):
            for text in texts:
                children = {}
                for rec in re.findall(r"^CALL .*?^END\n", text, re.M | re.S):
                    head, body = rec.split("\n", 1)
                    off = int(head.split()[1], 16)
                    if body.startswith("PARENT "):
                        parents = []
                        while body.startswith("PARENT "):
                            parent, body = body.split("\n", 1)
                            xs = ""
                            while body.startswith("X "):
                                x, body = body.split("\n", 1)
                                xs += x + "\n"
                            parents.append((*parent.split()[1:], xs))
                        for p_off, p_seq, idx, xs in parents:
                            children.setdefault((int(p_off, 16), int(p_seq)), []).append(
                                (int(idx), f"CALL {off:X} 0 {inner_of[target][off]}\nPARENT\n{xs}{body}"))
                        continue
                    kids = "".join(k for _, k in sorted(children.pop((off, int(head.split()[2])), [])))
                    # a call that never returned without a long jump or exit to end it: BCC.EXE
                    # crashed on these arguments (emu2 stopped), nothing to compare with
                    if "\nNORETURN\n" in "\n" + body and "\nNORETURN\n" not in kids:
                        continue
                    # one that ran bytes BCC never loaded (through a null pointer): the same
                    if "\nWILD\n" in "\n" + body:
                        continue
                    # one whose stack went below BCC's own limit (8F0Ch, its stack checks):
                    # it wrote over its data (DGROUP is the stack segment), so what it did
                    # depends on that and is no reference
                    frame = re.search(r"^FRAME ([0-9A-F]+)$", body, re.M)
                    if frame and int(frame.group(1), 16) < 0x8F0C:
                        continue
                    key = hashlib.sha1((body + kids).encode()).hexdigest()
                    if key not in keys[target] and len(calls[target]) < args.max:
                        keys[target].add(key)
                        calls[target].append(body + kids)
    for target in targets:
        if not calls[target]:
            print(f"{target}: no call recorded")
            continue
        out = PORT / "records" / f"{target}.rec"
        with open(out, "w") as f:
            for i, body in enumerate(calls[target]):
                f.write(f"CALL {offsets[target]:X} {i}\n{body}")
        print(f"{target}: {len(calls[target])} different calls injected -> records/{target}.rec")
    shutil.rmtree(WORK, ignore_errors=True)


if __name__ == "__main__":
    main()

"""Test the modding build's handling of edits it used to refuse: new source files, and
changed sources that are compiled with context sources.

    python3 tools/modedits.py [--jobs N]

It copies src/ to build-source/MODEDIT/src and changes the copy:

- two new files, tests/modedit/MODNOTE.C (resident, joining RMAIN13C's code segment) and
  tests/modedit/MODOVL.C (in NAMEPOOL's overlay), each with initialised and zeroed data;
- RVECSET.C, a context source of five other files, calls MOD_NOTE: so its static entry
  moves within its function and those five files are compiled again with the new helper;
- RMAIN13C.C and DIAGFMT.C, compiled with context sources, call MOD_NOTE and MOD_OVL_NOTE.

The calls only count and mix values in the new files' own data, so the program's output
must not change: the build is linked with tools/modlink.py and compared with Borland's
BCC.EXE by tools/modtest.py over the whole corpus.  Then one compile runs in the tracing
emu2 (Exhume's tools/emu2-trace), and the instructions of MOD_NOTE and MOD_OVL_NOTE must be
among those executed: the new code ran, in the resident part and in an overlay.
"""
import os
import re
import shutil
import struct
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import modtest  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "build-source" / "MODEDIT"
TRACE_EMU2 = modtest.EXHUME / "tools" / "emu2-trace" / "emu2"

def edit(tree):
    files = {p.name.upper(): p for p in tree.rglob("*") if p.suffix.upper() in (".C", ".ASM")}

    def change(name, old, new, declare):
        p = files[name]
        text = p.read_bytes().decode("latin1")
        if text.count(old) != 1:
            raise SystemExit(f"modedits: {name} no longer has the text the test edits")
        text = text.replace(old, new)
        # the declaration goes before the first function
        first = re.search(r"^(static |extern )?(void|int|unsigned|char)[^;]*\)\s*\n\{", text, re.M)
        text = text[:first.start()] + declare + text[first.start():]
        p.write_bytes(text.encode("latin1"))

    note = "extern void far pascal MOD_NOTE(unsigned int);\n"
    ovl = "extern void far pascal MOD_OVL_NOTE(unsigned int);\n"
    change("RVECSET.C", "{\n    if(DOS_HOST_MODE!=8)", "{\n    MOD_NOTE(vector);\n    if(DOS_HOST_MODE!=8)", note)
    change("RMAIN13C.C", "    long available;\n", "    long available;\n\n    MOD_NOTE(argc);\n", note + ovl)
    # overlays load into the heap: call into one once the memory manager is set up
    change("RMAIN13C.C", "    INIT_EMS_EXT_BANKS();\n", "    INIT_EMS_EXT_BANKS();\n    MOD_OVL_NOTE(argc);\n", "")
    change("DIAGFMT.C", "{\n    RTL_DPRINTF(format);", "{\n    MOD_OVL_NOTE(error);\n    RTL_DPRINTF(format);", ovl)
    for name in ("MODNOTE.C", "MODOVL.C"):
        shutil.copy(ROOT / "tests" / "modedit" / name, tree / "driver" / name)


def main():
    jobs = sys.argv[sys.argv.index("--jobs") + 1] if "--jobs" in sys.argv else str(os.cpu_count() or 4)
    if OUT.exists():
        shutil.rmtree(OUT)
    OUT.mkdir(parents=True)
    tree = OUT / "src"
    shutil.copytree(ROOT / "src", tree)
    edit(tree)
    build = OUT / "build"
    py = sys.executable
    subprocess.run([py, str(ROOT / "tools" / "modlink.py"), "--src", str(tree), "--out", str(build)], check=True)
    exe = build / "run" / "BCC.EXE"
    test = subprocess.run([py, str(ROOT / "tools" / "modtest.py"), str(exe), "--jobs", jobs,
                           "--work", str(OUT / "test")])
    ran = traced(exe, build / "run" / "BCC.MAP")
    print(f"traced: MOD_NOTE ran {'yes' if ran['MOD_NOTE'] else 'NO'}, "
          f"MOD_OVL_NOTE ran {'yes' if ran['MOD_OVL_NOTE'] else 'NO'}")
    if test.returncode or not all(ran.values()):
        raise SystemExit(1)
    print("modedits: passed")


def traced(exe, map_path):
    """Run one compile of the edited build in the tracing emu2; for each new function, whether
    an instruction of its first bytes ran."""
    if not TRACE_EMU2.exists():
        raise SystemExit("the tracing emu2 is missing: run sh exhume/tools/setup-emu2-trace.sh")
    run = OUT / "trace"
    run.mkdir()
    shutil.copy(exe, run / "BCC.EXE")
    shutil.copytree(ROOT / "toolchain" / "BC20" / "INCLUDE", run / "INCLUDE")
    (run / "T.C").write_text("int f(int x) { return x + 1; }\nint g = 3 / 0 ? 1 : 2;\n")
    env = dict(os.environ, EMU2_TRACE=str(run / "trace"))
    subprocess.run([str(TRACE_EMU2), "BCC.EXE", "-c", r"-IC:\INCLUDE", "T.C"], cwd=run, env=env,
                   capture_output=True, timeout=300)
    executed = set()
    for f in run.glob("trace.*"):
        executed |= {int(line.split()[1], 16) for line in f.read_text().splitlines() if line.startswith("E ")}
    data = exe.read_bytes()
    header = struct.unpack_from("<H", data, 8)[0] * 16
    text = map_path.read_text()
    out = {}
    for name in ("MOD_NOTE", "MOD_OVL_NOTE"):
        seg, off = re.search(rf"^ ([0-9A-F]{{4}}):([0-9A-F]{{4}})\s+(?:idle\s+)?{name}\s*$", text, re.M).groups()
        start = file_offset(data, header, text, int(seg, 16), int(off, 16))
        out[name] = any(start + i in executed for i in range(8))
    return out


def file_offset(data, header, map_text, seg, off):
    """File offset of seg:off from a TLINK map.  Resident code is in the load image.  An
    overlay's code follows the load image: after it comes TLINK's 16-byte FBOV header, and
    the overlay's stub holds, at +4, the overlay's offset from the end of that header."""
    m = re.search(rf"^ {seg:04X}0H \S+ \S+ (\S+)\s+(\S+)", map_text, re.M)
    if m and m.group(1).startswith("OVR_"):
        last, pages = struct.unpack_from("<HH", data, 2)
        image_end = pages * 512 - (512 - last if last else 0)
        if data[image_end:image_end + 4] != b"FBOV":
            raise SystemExit("modedits: no FBOV header after the load image")
        stub = header + seg * 16
        return image_end + 16 + struct.unpack_from("<I", data, stub + 4)[0] + off
    return header + seg * 16 + off


if __name__ == "__main__":
    main()

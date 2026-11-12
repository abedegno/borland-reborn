# The modding build

The exact link (`tools/integrate_sources.py`, run by `gate.py check --all`) proves the sources:
it rebuilds Borland's `BCC.EXE` byte for byte. It does that by pinning every reference to its
original address, so nothing in it may change size. The **modding build** links the same
compiled objects the way a normal build would: TLINK lays the program out, so a source may
change and the program still works.

```sh
../.venv/bin/python ../exhume/tools/gate.py check --all       # compiles the objects (and proves them)
../.venv/bin/python tools/modlink.py                          # build-source/MODLINK/run/BCC.EXE
../.venv/bin/python tools/modtest.py                          # compare it with Borland's BCC.EXE
```

To build with changes, copy `src/` somewhere, edit the copy, and pass it:

```sh
cp -R src ../my-src
# edit ../my-src/...
../.venv/bin/python tools/modlink.py --src ../my-src --out build-source/MYBUILD
../.venv/bin/python tools/modtest.py build-source/MYBUILD/run/BCC.EXE
```

Only the files that differ from `src/` are compiled (with the switches on their `opts:` line,
into `--out`'s `build/`); every other module uses the matched object. The matched tree and its
objects are never touched.

## What it proves

`tools/modtest.py` compiles 239 files with both compilers, each with its own switches, as
object code (`-c`) and as assembly (`-S`): the project's own C sources (every
C file BCC builds, which exercises the C and C++ front ends, the optimiser and both back
ends) and the tests in `tests/modbuild/`. Every object, listing and console message must be
identical, except for the "Available memory" line. Results:

| Build | Compiles identical |
|---|---|
| unchanged sources | 478 / 478 |
| `OPPREC.C` (an overlay, the expression parser) with a new function at its start | 478 / 478 |

A resident change was also tested by hand. `RPUTS.C` was changed to write every string
twice: the banner and file names print twice, the resident code after it moves by up to 2Ah
bytes and the data segment by 10h, and the compiler's objects and messages stay identical.
The runs use emu2 (`sh ../exhume/tools/setup-emu2.sh`); the program also runs in DOSBox-X.

## How it works

`tools/modlink.py` takes the objects the gate compiled and adds what TLINK needs to lay the
program out itself. Everything it adds is generated, so a rerun after any change starts
fresh.

- **Code segments.** Modules that shared a code block in the original call each other near,
  so they must share a segment again: each object's code segment is renamed to its block
  (`CODE_n` for resident code, `OVR_xxxx` for an overlay). `MODORDER.ASM` declares the blocks
  in the original order, after `DOSSEG`. Where the original left a gap between two modules
  (one byte, after the overlay manager), the next module's segment is word-aligned.
- **Overlays.** Overlay modules are linked in the original stub order. The order matters
  because the heap takes over the stubs between two marks (`ADOPT_EXTERNAL_REGIONS`,
  OPTIONS.C). The four one-byte mark overlays (CO044, CO051, CO067, CO068) and the five
  empty ones (CZ000 to CZ004) are generated as tiny modules in their original places.
- **The data segment.** No source defines data: every C and assembly module refers to its data
  by name (`extern`). `MODDATA.ASM` is generated from the original image: `_DATA`, the
  `_BSS` layout and the stack, with every data name from `symbols.tsv` public at its
  original offset. Each far pointer in the data is written as the function it points at
  (`dd NAME`), and each segment word as `DGROUP`. TLINK fills these in for the new layout,
  through the overlay stub for an overlaid function.
- **The overlay manager's segments.** `MODGLUE.ASM` holds `_OVERLAY_` (the manager's
  variables, in five paragraph-aligned pieces whose segment values the manager uses:
  `BCC_SEG_46`, `BCC_SEG_47`, `BCC_SEG_50`), `__OVRTRAP__` at `_OVERLAY_:0120` (TLINK writes
  `INT 3Fh` there and recognises the manager by it), the `_EXEINFO_` segment table TLINK
  fills, and `CODE_52`. The manager's table of near entry points into `OVRMGR.ASM` is written
  as labels.
- **Labels used from other modules.** 107 names that other modules use sit inside a module
  without a public there: static functions, and entry points in the middle of a function. They
  are added to the objects as publics at the offsets the target tables give. The list is
  written to `run/ADDED-PUBLICS.TXT`.
- **One offset reference.** `MSGGET` hands `BCC_MESSAGE_IMAGE` (the message overlay) to
  `OVR_ENSURE_IMAGE_LOADED`, which returns the loaded image with the offset it was given. TLINK
  would make that offset a stub entry (20h), so that one fixup is pointed at an absolute 0.

## Limits

- **Data is not source yet.** `MODDATA.ASM` is regenerated from the original image every
  time, so data (strings, tables) cannot be edited through `--src`. Near pointers inside the
  data stay numbers. They stay right because the data keeps its layout. The next step is to
  keep `MODDATA.ASM` as a real source, with its near pointers written as names.
- **Modules with outside labels.** A changed copy of one of the 71 modules in
  `ADDED-PUBLICS.TXT` must make those labels public itself. For a static function, that
  means dropping `static`. For an entry in the middle of a function, it means splitting the
  function there. `modlink.py` refuses until it has.
- **Context sources.** The seven files compiled with a `/* context: */` helper
  (`tools/compile_context.py`) cannot be changed through `--src` yet.
- **New files** need a place in the link and are refused for now.
- The output is not byte-identical to Borland's even with nothing changed: the stubs differ
  in their entry order and the data segment starts 40h later. That is expected. The exact
  link is the byte-for-byte proof, and this build is checked by what it does.

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
into `--out`'s `build/`). Every other module uses the matched object. The matched tree and
its objects are never touched.

## What it proves

`tools/modtest.py` compiles 239 files with both compilers, each with its own switches, as
object code (`-c`) and as assembly (`-S`). The files are the project's own C sources (every
C file BCC builds, which exercises the C and C++ front ends, the optimiser and both back
ends) and the tests in `tests/modbuild/`. Every object, listing and console message must be
identical, except for the "Available memory" line. Results:

| Build | Compiles identical |
|---|---|
| unchanged sources | 478 / 478 |
| `OPPREC.C` (an overlay, the expression parser) with a new function at its start | 478 / 478 |
| `LEXER.C` and `CLASSDEF.C` with a new function at their start (19 labels other modules use move with their functions) | 478 / 478 |
| `--pad-code 16`: every code block and overlay starts 16 bytes later | 478 / 478 |
| `--pad-data 16 --pad-at END`: 16 new bytes at the end of `_DATA` (`_BSS` and the stack move) | 478 / 478 |
| `--pad-data 16`: 16 new bytes at DS:0100, so nearly all the data moves | 478 / 478 |
| `--pad-data 1` and `--pad-data 256` at DS:0100 (an odd and a large shift) | 478 / 478 |
| `--pad-data 16 --pad-at 3308`: 16 new bytes in the middle of `_DATA` | 478 / 478 |

A resident change was also tested by hand. `RPUTS.C` was changed to write every string
twice: the banner and file names print twice, the resident code after it moves by up to 2Ah
bytes and the data segment by 10h, and the compiler's objects and messages stay identical.
The runs use emu2 (`sh ../exhume/tools/setup-emu2.sh`), one compile per process and as many at once as
there are processors (`--jobs N`), so the 478 compiles take about ten seconds on eight cores; the
program also runs in DOSBox-X.

Two layout tests move everything of one kind:

- `--pad-code N` puts N bytes at the start of every code block and every overlay (but the
  message overlay, which is read as an image from its offset 0), so every code offset moves.
  It found the inline assembler reading its ModR/M table at `cs:[bx+1164h]`, now a name.
- `--pad-data N --pad-at END` adds N bytes at the end of `_DATA`, so `_BSS` and the stack move:
  new initialised data goes there.
- `--pad-data N` alone inserts them at DS:0100, early in `_DATA`, so nearly all data moves.
  It found the last pointers that were numbers, and some words wrongly taken for pointers
  (see "Tracing" below).

## How it works

`tools/modlink.py` takes the objects the gate compiled and adds what TLINK needs to lay the
program out itself. Everything it adds is generated afresh each run.

- **Code segments.** Modules that shared a code block in the original call each other near,
  so they must share a segment again: each object's code segment is renamed to its block
  (`CODE_n` for resident code, `OVR_xxxx` for an overlay). `MODORDER.ASM` declares the blocks
  in the original order, after `DOSSEG`. Where the original left a gap between two modules
  (one byte, after the overlay manager), the next module's segment is word-aligned.
- **Overlays.** Overlay modules are linked in the original stub order. The order matters
  because the heap takes over the stubs between two marks (`ADOPT_EXTERNAL_REGIONS`,
  OPTIONS.C). The four one-byte mark overlays (CO044, CO051, CO067, CO068) and the five
  empty ones (CZ000 to CZ004) are generated as tiny modules in their original places.
- **The data segment** is a source file, [`src/data/DGROUP.ASM`](../src/data/DGROUP.ASM).
  No recovered source defines data; every module refers to it by name. `tools/gendata.py`
  wrote the file from the original image:
  - the bytes of `_DATA` in their original order, with text quoted;
  - every `symbols.tsv` name public at its original offset;
  - far pointers written as the functions they point at, and far pointers into the data as
    `dw offset DGROUP:NAME,DGROUP`;
  - the 876 near pointers to data that `tools/findptrs.py` found
    ([`map/data-pointers.tsv`](../map/data-pointers.tsv)), written as the items they point at
    (the run-time trace below is part of its evidence);
  - the 185 near pointers into code, kept as numbers tagged `; @code FUNCTION`.

  The build assembles the file. With nothing edited, the data comes out equal to the original
  except for the words TLINK relocates. Near pointers into code cannot be names: TLINK would
  make an offset into an overlay a stub entry. So the build links twice and writes each
  function's new offset, read from the first link's map, into the second link.
- **Code that names data by number.** The C sources now reach their data by name
  everywhere a name compiles to the same bytes: about 190 places that used numbers
  (`TEXT(0x55C2)`, `(char near *)0x5537`, `MK_FP(_DS,0x8680)`) were rewritten
  (`tools/namestrings.py`), with names made from the strings' text. `C0.ASM` clears the BSS
  from `BSS_START` to `BSS_CLEAR_END`, takes the stack from `STACK_BOTTOM` and names
  `HEAP_STATUS` and `HEAP_HOOK_CALLSITE`. `RPOW10.ASM` takes its tables by name, and
  `OVRMGR.ASM` the overlay data size (`OVERLAY_DATA_SIZE`). Eleven numbers must stay: a name changes the code there (BC no
  longer merges common tails), and the sources say so. They are listed in
  [`map/code-numbers.tsv`](../map/code-numbers.tsv), and the build patches them with their
  targets' new offsets.
- **The overlay manager's segments.** `MODGLUE.ASM` holds the following:
  - `_OVERLAY_`, the manager's variables, in five paragraph-aligned pieces whose segment values
    the manager uses (`BCC_SEG_46`, `BCC_SEG_47`, `BCC_SEG_50`);
  - `__OVRTRAP__` at `_OVERLAY_:0120`: TLINK writes `INT 3Fh` there and recognises the manager
    by it;
  - the `_EXEINFO_` segment table, which TLINK fills;
  - `CODE_52`.

  The manager's table of near entry points into `OVRMGR.ASM` is written as labels.
- **Labels used from other modules.** 107 names that other modules use sit inside a module
  with no public there: static functions, and entry points in the middle of a function. They
  are added to the objects as publics. A module that was changed with `--src` still provides
  them. Each label stays at its distance into its function, and the function is found in the
  new object by its original bytes, with fixup positions masked. When two copies match, the
  shift of the nearest earlier function decides. If the function holding a label was itself
  edited, the label has no safe place and the build stops with its name. The list is
  written to `run/ADDED-PUBLICS.TXT`.
- **One offset reference.** `MSGGET` hands `BCC_MESSAGE_IMAGE` (the message overlay) to
  `OVR_ENSURE_IMAGE_LOADED`, which returns the loaded image with the offset it was given. TLINK
  would make that offset a stub entry (20h), so that one fixup is pointed at an absolute 0.

## Tracing: pointers and coverage

`tools/modtrace.py` runs Borland's BCC.EXE over the same corpus in a tracing emu2
(`sh ../exhume/tools/setup-emu2-trace.sh` builds it into `../exhume/tools/emu2-trace`). The tracer
marks every byte of memory with the offset in BCC.EXE it was loaded from, overlays included,
and carries those marks through registers, the stack and copies. A register keeps the mark
of the word it was loaded from while it is moved, or moved on by add, sub, inc or dec; a
byte written into it, a shift, a logic operation or a multiply clears it. The run takes
about ten seconds on eight cores and writes:

- [`map/traced-pointers.tsv`](../map/traced-pointers.tsv): every word of the data that the
  corpus used as a near address of a DGROUP item (a register still holding that word, give
  or take under 100h, forms the address of an access through DGROUP with a displacement
  under 100h) or as a code address (a call or jump through it), with the number of uses.
  `findptrs.py` reads it: a traced word is never taken for text, a record field that holds
  one is filled for every record of its table, and a traced word nothing else finds is
  added on its own. This found 65 pointers of the inline assembler's keyword table that the
  text test had hidden (a pointer such as 2F0Ah before a small token number reads as text).
  Every traced word is now in `map/data-pointers.tsv`; the reverse does not hold, since the
  corpus does not run every table.

  The early `--pad-data` test then found what tracing cannot: words wrongly taken for
  pointers, which move with the data when they must not. A 4-byte record's second word (a
  token and its flags, such as 0A78 or 1778, the address of `OPTION_FLAG`) passed for a
  pointer at stride 2, as did byte pairs beside a pointer table; and the `#pragma` handler
  of `PREAMBLE_DIRECTIVE_TABLE`, at code offset 0E4F, was taken for a pointer to the string
  at DS:0E4F. `findptrs.py` now keeps a plain array's gaps between its found pointers,
  drops a weaker stride's entries that fall on another field of an item's records, trims a
  run's end that points far from the rest, and takes a word beside code pointers whose
  value starts a function for a code pointer. `LEXER.C` also wrote one address as a number
  (`0x2301`, the macro-expanding character class table); it is a name now, with the same
  bytes. To find such faults, bisect with `--pad-at` over named items only (padding inside
  a table breaks its indexing by design), then compare the failing and passing builds: the
  words that differ outside the moved range are the culprits. The tracer's
  `EMU2_TRACE_READ=LO-HI` lists the instructions that read a range of the file's bytes.
- [`docs/COVERAGE.md`](COVERAGE.md), and per function `build-source/MODTRACE/coverage.tsv`:
  the share of each module's code that the corpus runs. About half the code runs; what
  never runs (debug information, the messages, some C++ and inline assembler paths) is not
  checked by `modtest.py` either.

To see why a word was traced, run one compile by hand with `EMU2_TRACE_WATCH` set to the
word's file offset: the tracer prints the offset of each instruction behind its first uses.

## Limits

- **Data in the middle of `_DATA`.** New data may now go anywhere between two items: the
  corpus passes with data inserted at DS:0100, in the middle and at the end. Some items must
  stay next to each other, because the code reaches one from another's address: the
  pseudo-register names `_AX`..`_ES` (a base plus four times an index), and
  `MIRROR_COMPARE_TABLE`, read as `INVERT_COMPARE_TABLE` plus 0Ch. Padding between such
  items, or inside a table, breaks it. The pointer table is still found by heuristics, each
  entry with its evidence, and the corpus runs about half the code (`docs/COVERAGE.md`), so a
  table no test reaches may still hold a wrong entry.
- **Context sources.** The seven files compiled with a `/* context: */` helper
  (`tools/compile_context.py`) cannot be changed through `--src` yet.
- **New files** need a place in the link and are refused for now.
- The output is not byte-identical to Borland's even with nothing changed: the stubs differ
  in their entry order and the data segment starts 40h later. That is expected. The exact
  link is the byte-for-byte proof, and this build is checked by what it does.

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
into `--out`'s `build/`), and the files compiled with a changed context source (below).
Every other module uses the matched object. The matched tree and its objects are never
touched. A new file names the module whose code segment it joins on a line of its own:

```c
/* opts: -mm -G -O -Z -p */
/* link: with RMAIN13C */
```

Its code goes at the end of that module's segment (resident, or that module's overlay, in
which case compile it with `-Y` as the overlaid sources are), and its data after all of the
original's data, so nothing original moves within its segment. `tools/modedits.py` tests
both kinds of edit (below).

## What it proves

`tools/modtest.py` runs 1836 compiles of 923 files with both compilers. The files are:

- the project's own C sources, every C file BCC builds, each with its own switches, as
  object code (`-c`) and as assembly (`-S`);
- 110 of Borland's own example programs and its container class library, which shipped on
  the Borland C++ 2.0 disks and were written for this compiler:
  - DOS and Windows examples (`-W`, `-WD`);
  - the manual's chapter examples;
  - TCALC;
  - the Turbo Profiler and Turbo Debugger examples.

  `scripts/setup-toolchains.py` installs them from your own disks, as it does the
  compilers. They are not in this repository.
  [`tests/modbuild/BORLAND.TSV`](../tests/modbuild/BORLAND.TSV) lists them with their
  switches, taken from Borland's build files where there are any. A few fail in both
  compilers alike, for instance where an example is meant to be built with assembly
  modules. emu2 does not cut names to 8.3 as DOS does, so the test's copy of the headers
  also holds `STRSTREAM.H`;
- 545 files of outside test suites that `tools/fetch-testsuites.py` downloads at pinned
  versions into `testsuites/` (git ignores it):
  - from GCC's test suites (GPL): `gcc.c-torture`, small C programs, and `g++.old-deja`, the
    g++ tests of the 1990s, written against the ARM-era C++ this compiler implements;
  - from AT&T cfront 3.0.3: the demos and libraries (seyko2/cfront-3).

  They were chosen by tracing Borland's compiler over all of the suites' files (6968 from
  GCC, 81 from cfront) and keeping each file that reaches code the rest of the corpus does
  not. [`tests/modbuild/EXTERNAL.TSV`](../tests/modbuild/EXTERNAL.TSV) lists them. Most
  stop with errors in Borland C++ 2.0 (GCC extensions, templates, AT&T's headers), which
  exercises its error paths; both compilers must report them alike. Two files are left
  out: their output in Borland's own compiler changes with its layout
  (`docs/FINDINGS.md`);
- the tests in [`tests/modbuild/`](../tests/modbuild/), each aimed at code the sources do
  not reach, with its switches on its first line (`/* modtest: ... */`).

The tests cover these areas:
- bitfields;
- initialiser lists;
- C++ classes, operators, member pointers and huge arrays;
- debug information (`-v`), in C and C++;
- 8087, fast and emulated floating point;
- the huge model, and far and huge data;
- inline assembly in C and C++;
- diagnostics in C and C++, with all warnings on;
- two sets of many switches;
- precompiled headers (`-H`), written in one step and read in the next;
- a compile that runs TLINK;
- BCC with no arguments;
- every `#pragma`, well-formed and malformed, also in strict ANSI mode (`-A`), `#error`,
  and strings made by macro expansion, with escapes and unterminated literals (added for
  the port's checks: `PRAGMAS.C`, `PRAGMAA.C`, `ERRDIR.C`, `STRINGS.C`).

Three of them record faults of Borland's compiler, which both compilers must reproduce
(`docs/FINDINGS.md`). Every object, listing, console message and exit status must be
identical, except for the "Available memory" line. A precompiled header file is compared
only by size: it holds BCC's own data addresses, and bytes BCC never writes. The second
compile then checks it by reading it back. Results:

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
| *after the corpus grew to 522:* unchanged, `--pad-code 16`, and `--pad-data 1`, `16` and `256` early (at DS:069C, see below), in the middle and at the end | 522 / 522 each |
| `tools/modedits.py`: two new files (one resident, one in an overlay, each with data), a changed context source of five files, and two changed files compiled with context sources | 522 / 522; the tracer shows both new functions ran |
| *with Borland's examples, 742 compiles:* unchanged, `--pad-code 16`, and `--pad-data 1`, `16` and `256` early, in the middle and at the end; and `tools/modedits.py` | 742 / 742 each; the tracer shows both new functions ran |
| *with the outside suites, 1832 compiles:* the same builds, and `tools/modedits.py` | 1832 / 1832 each; the tracer shows both new functions ran |
| *with the preprocessor tests, 1836 compiles:* all seven builds rebuilt, and `tools/modedits.py` | 1836 / 1836 each; the tracer shows both new functions ran |

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
- `--pad-data N` alone inserts them early in `_DATA`, so nearly all data moves: before the
  first named item from DS:0100 on, DS:069C. Until the corpus printed BCC's usage text the
  point was DS:0100 itself, which is inside that text, and the test split it.
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
  them. Each label stays at its distance into its function. The function is found in the new
  object by its original bytes; a fixup must sit at the same place in both, and those bytes
  are not compared. When two copies match, the shift of the nearest earlier function
  decides. If the function holding a label was itself edited, the label has no safe place
  and the build stops with its name. The exception is a label at a module's start, such as a
  context source's static entry, which stays at the start. The list is written to
  `run/ADDED-PUBLICS.TXT`. (The first version accepted a byte that was a fixup in either
  object, so the edited RVECSET matched 8 bytes late, over a call's address; every compile
  of that build hung, and the test caught it.)
- **Context sources** (`tools/modcontext.py`). Seven sources are compiled with others in
  front of them (`/* context: FILE.C */`): in Borland's source they shared a file, so the
  calls between them are `push cs; call near` with no fixup. The exact build proves the
  split with Exhume's `compile_context.py`, from the original's sizes and call offsets. An
  edited file has other sizes and offsets, so the modding build finds them itself:
  1. it compiles the helpers and the file together, as Borland did;
  2. it checks that each helper's part equals that helper's own object, with fixup
     positions masked, which proves where each part ends;
  3. it cuts out the file's own part with Exhume's slicer, and turns each call into a
     helper into a near reference to the helper's name.

  When a helper changes, every file compiled with it is compiled again. A branch from the
  file into a helper that is not such a call, or data the composed source defines, stops
  the build.
- **New sources** are linked after the original's modules. Their code segment is renamed to
  the segment of the module they name, and their `_BSS` gets `DGROUP.ASM`'s class (`DATA`, not
  the compiler's `BSS`). Otherwise TLINK would put their zeroed data after `_BSSEND`, outside
  what the start-up code clears. Their initialised data comes after the original's, so
  `_BSS` moves by its size. The data check expects that shift in pointers to `_BSS`.
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
  the share of each module's code that the corpus runs: 83% (65% of the resident code, 85%
  of the overlays). It was 56% before the tests in `tests/modbuild/` were added, 70% before
  Borland's examples and 75% before the outside suites. Modules that
  never run hold 0.4% of the code (1695 bytes). Most handle extended and expanded memory,
  the heap under memory pressure, and the Ctrl-C and Ctrl-Break handlers, which the
  emulator does not exercise. The rest are a few run-time helpers. Most of the code that
  does not run is branches inside modules that do: error paths and rare cases. The widened corpus found one more number in the code that should
  have moved with the data: CGOPER chose six huge-pointer helper names (`padd@` and the
  rest) by `?:` between two numbers. With data inserted, the huge model's output named the
  wrong helpers. Names would change BC's code there, so they are listed in
  `map/code-numbers.tsv`. Borland's Windows examples found the last one so far: the first
  entry of `OPCODE_DESCRIPTOR_TABLE` (19-byte records, each starting with a pointer to its
  mnemonic) points to `nop` at DS:504C. Its bytes read as the text "LP" and labels split
  the record, so only the tracer saw it. With the old table, 14 of the 36 Windows compiles
  differ once data moves; with it in the table, none do. The outside suites found one more:
  the last entry of `STORAGE_CLASS_NAMES` points to `register` at DS:3811, and its bytes
  read as 11h and "8".

To see why a word was traced, run one compile by hand with `EMU2_TRACE_WATCH` set to the
word's file offset: the tracer prints the offset of each instruction behind its first uses.

## Limits

- **Data in the middle of `_DATA`.** New data may go anywhere between two items: the corpus
  passes with data inserted early (DS:069C), in the middle and at the end. Some items must stay
  next to each other, because the code reaches one from another's address: the
  pseudo-register names `_AX`..`_ES` (a base plus four times an index), and
  `MIRROR_COMPARE_TABLE`, read as `INVERT_COMPARE_TABLE` plus 0Ch. Padding between such
  items, or inside a table, breaks it. The pointer table is still found by heuristics, each
  entry with its evidence, and the corpus runs 70% of the code (`docs/COVERAGE.md`), so a
  table no test reaches may still hold a wrong entry.
- **New files** take their place from the module they name. Their code goes at the end of
  that segment, not next to the module. A new file's data cannot go between the original's
  items: put such data in `src/data/DGROUP.ASM`.
- **Context sources** may be edited, but the file's calls into its helpers must stay plain
  calls (no jump shared with a helper's tail), and the composed source may not define data.
  A changed helper's static entry must stay the first function of its file.
- The output is not byte-identical to Borland's even with nothing changed: the stubs differ
  in their entry order and the data segment starts 40h later. That is expected. The exact
  link is the byte-for-byte proof, and this build is checked by what it does.

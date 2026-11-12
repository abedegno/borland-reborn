# How it works

The goal is source code that rebuilds a published executable **exactly**: same compiler, same
switches, same bytes. Byte-identical output is the only test that cannot be argued with. If
the rebuilt program equals the original, the source is a faithful account of it. Every later
change, including all the renaming and commenting, is checked against the same test.

The work used [Exhume](https://github.com/abedegno/Exhume), a toolkit for byte-matching
decompilation of DOS programs (and some firmware). This page describes the method as it was
applied to Borland C++ 2.0's `BCC.EXE`.

## 1. Identify the toolchain

`BCC.EXE` was built by Borland C++ 2.0 itself, with TASM 2.51 for the hand-written parts and
TLINK 4.0 with Borland's VROOMM overlay manager. A function only matches when the compiler,
its version and every switch are right (`-mm -G -O -Z -p`, with `-Y` for overlaid code). The
identification was proved by compiling a function to the same bytes. Later, 29 run-time
library modules turned out to be built by an older compiler, **Turbo C 2.01**: they copy far
pointers through `es:bx` and build `dx:ax` before a push, which BC 2.0 never does.

## 2. Map the program

The executable was split into its segments and overlays, then into procedures and into the
original source files where the evidence showed module boundaries. The evidence was padding
between modules, the order of relocations, and segment names. Each piece got a target table:
which bytes of the original a source file must reproduce.

## 3. Match, one file at a time

For each file: write C (or TASM), compile it in DOS with the original compiler, compare every
function with the original, read the instruction diff, and change the source until nothing
differs. The compiler's habits decide how the source must be written. For example, BC 2.0
removes unreachable jumps *before* merging common code tails, so some functions only match
with an early `return` or a repeated statement where a human would have written it that way.
Those spots carry `match:` comments. Two rules held throughout:

- **Keep the original's language.** Modules that were hand-written assembly stay TASM.
  Modules that were compiled C are C, even where an assembly rendering would have been easier
  (`DVPRINTF.C` was recovered this way at the end).
- **No tricks.** No inline assembly standing in for compiled code, no byte patches. Where the
  original evidently had odd code (dead stores, redundant tests), the source reproduces it
  and says so.

## 4. Verify what matching cannot see

Byte comparison masks the places a relocation will fill in, so `verify` checks each of them:
that every external reference resolves to the right symbol at the right address, that data
and BSS are laid out the same, and that names agree with the global symbol table
(`symbols.tsv`). That table is rebuilt from scratch by every full check.

## 5. Link the whole program

All objects are linked with TLINK into a new `BCC.EXE`, overlays included, and compared with
Borland's. Parts of the program that are not compiled code (start-up glue, the data segment,
overlay plumbing) live in **link-group sources** (`linkgroups/`). These are assembly files
holding the original layout. The link cuts out the regions now supplied by recovered sources
and assembles the rest. The final check is a SHA-256 comparison of the whole executable.

## 6. Make it readable

With every byte proved, the source was rewritten for people, one step at a time, with the
full check after each step:

1. one build command and gate;
2. shared headers instead of per-file declarations;
3. named constants: messages, tokens, type kinds and operators, named from BCC's own tables;
4. record fields: about 300 field names for BCC's pool records (`FIELDS.H`), read through
   shared accessors (`POOL.H`), and the 40 record layouts as structs (`RECORDS.H`);
5. file names and a subsystem directory tree;
6. comments on every file and routine, and the findings.

Names were never guessed. Each one records its basis (`descriptive` or `inferred`) and the
evidence in [`bcc20/map/names.tsv`](../bcc20/map/names.tsv). A name says what the code does,
even where the purpose stayed unclear (`CODEGEN_UNUSED_POOL_ONE`). Comments were checked by
comparing the token stream with comments stripped, so they cannot change code.

## What the gate guarantees

`gate.py check --all` compiles every source, matches and verifies each one, rebuilds the
symbol table, links, and compares the executable. A pass means the repository's sources, built
with the original toolchain, produce Borland's `BCC.EXE` exactly. See [SETUP.md](SETUP.md) to
run it yourself.

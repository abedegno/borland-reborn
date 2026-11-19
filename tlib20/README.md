# tlib20: Borland C++ 2.0's TLIB.EXE, as source

TLIB 3.01 is Borland's librarian: it adds, removes, replaces and extracts the object modules
of a `.LIB` file, writes its dictionary, and with `/E` the extended dictionary that TLINK
`/E` reads. It shipped with Borland C++ 2.0 (1991) as a 34,864-byte `.EXE`. The C files in
[src](src) rebuild it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/TLIB.EXE` of Borland C++ 2.0, 34,864 bytes, SHA-256 `b06333a799afde9f2070d199c94108e25a0e671dca462927d23c570c7ffc7ce4` |
| Source | 11 C files and a header, 2,750 lines; four library modules in [../interim-rtl](../interim-rtl) |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0, Turbo C 2.01 and Turbo C++ 1.01 with `scripts/setup-toolchains.py`
(`--bc20`, `--tc201` and `--tc101`; [../docs/SETUP.md](../docs/SETUP.md)), then:

```sh
cd tlib20
make check          # or: ../.venv/bin/python tools/build.py
```

It ends with `TLIB.EXE: byte-identical to the original (SHA-256 b06333a7...)`. The new file
is `build/link/out/TLIB.EXE`, with TLINK's map beside it. `tools/gate.sh` also matches
every source file against its part of the original with Exhume (`tools/match.py`).

## The source

| File | What it does |
|---|---|
| [src/STUBS.C](src/STUBS.C) | three empty functions linked after the startup code |
| [src/CMDLINE.C](src/CMDLINE.C) | the command line, response files, `main()` |
| [src/OMF.C](src/OMF.C) | reading modules and libraries, writing the new library, its dictionary, the extended dictionary and the listing |
| [src/HASH.C](src/HASH.C), [src/SYMTAB.C](src/SYMTAB.C), [src/WALK.C](src/WALK.C) | the public-symbol table |
| [src/ERROR.C](src/ERROR.C) | the console mode and every message |
| [src/FNAME.C](src/FNAME.C) | file-name extensions |
| [src/GLOBALS.C](src/GLOBALS.C) | the program-wide variables |
| [src/DEMANGLE.C](src/DEMANGLE.C) | C++ names for the listing |
| [src/include/TLIB.H](src/include/TLIB.H) | what the files share |

The files are in link order, which is the order of their code in TLIB.EXE. TLIB.EXE keeps
no symbols, so every name is descriptive.

## How Borland built it

The evidence is the bytes of TLIB.EXE. [tools/build.py](tools/build.py) repeats each step.

- **Compiler: Turbo C 2.01**, compact model, each file with its own switches (its
  `/* opts: */` line). Turbo C 2.01 has no `#pragma`, so switches change only between files,
  and that is why the symbol table is three files: `lookup()` was compiled with register
  variables and `hash()` and `walk()` without (`-r-`).
- **Through the assembler, for two files.** CMDLINE.C and OMF.C were compiled with `-B`:
  Turbo C wrote assembly and TASM assembled it in one pass. TASM gives the original's
  sign-extended immediates (`83 /1`, which Turbo C never writes in its own objects) and its
  short jumps padded with a NOP. ERROR.C has inline assembler, which has the same effect.
  The demangler was compiled straight to an object: it keeps redundant `ss:` prefixes that
  every TASM drops. Turbo C++ 1.00 and Turbo C 1.5 were tried too; neither fits.
- **Startup code: the interim C0C**, Borland C++ 2.0's `C0.ASM` with Turbo C++ 1.01's
  banner, as for TOUCH ([../scripts/interim_rtl.py](../scripts/interim_rtl.py)).
- **Library: the interim library**, searched by the linker. Its modules are Borland C++
  2.0's `CC.LIB`, in that library's order, with GETW, PUTC and OPEN from Turbo C++ 1.01's
  and four modules that neither library has: FFLUSH, FGETS, FREAD and GETC, rebuilt from C
  with Borland C++ 2.0's BCC ([../interim-rtl](../interim-rtl)). The build puts the library
  together with TLIB itself. Searching it reproduces the order of the library code in
  TLIB.EXE: one pass through the library, then a second for what the first pass pulled in.
- **Linker: Turbo C 2.01's TLINK 2.0**, `/c /m`. TLINK 3.01 and 4.0 link the same code and
  data but write another EXE header.

## What the code shows

- **Where each file's variables are.** Turbo C 2.01 puts a file's function-local statics
  first in its `_BSS`, in source order, and then its file-scope variables in ascending order
  of a hash of the name, (first char + 4 &times; last char + 32 &times; length) &amp; 1023.
  So the file-scope names were chosen to fall in the original's order (TLIB.H says so too),
  and the variables are split between the files whose part of `_BSS` they are in: the
  parser's own in CMDLINE.C, the reader's and writer's in OMF.C, the symbol table's current
  table in SYMTAB.C, and the program's options, files and command list in GLOBALS.C, a file
  of data only that links between FNAME.C and DEMANGLE.C (`pagesize` and `pageshift` are its
  initialised data, just before the demangler's).
- **`word` locals.** With register variables on, Turbo C 2.01 puts `int` and `unsigned`
  locals in SI and DI of its own accord, but never `unsigned short` ones. OMF.C's locals
  that stay on the stack in the original are `word`, an `unsigned short`.
- **Spellings kept for their code** are marked `match:` in the source. None changes what
  TLIB does. One test is kept as the original has it although it can never be true
  (`room < 0` on an unsigned in `unmangle()`), and `listlnames()` in OMF.C is never called.
- **The library header.** TLIB writes its header record first with the page size and
  rewrites it at the end with the dictionary's position; a library needing more pages than
  16-bit page numbers can reach stops with "library too large, please restart with /P".
- **Not known:** the names of STUBS.C's three functions (nothing calls them; empty
  functions are what they compile from), and what reads CMDLINE.C's unreferenced
  `"$*$*$*...TLIB"` bytes.

# Borland C++ 2.0 (1991)

Every executable of Borland C++ 2.0, recovered as source that rebuilds it byte for byte with
Borland's own tools. One directory per program. The shared tooling is [`../scripts/`](../scripts/) and
[Exhume](https://github.com/abedegno/Exhume) (`../exhume`); the toolchains are installed in
`../toolchains` ([../docs/SETUP.md](../docs/SETUP.md)).

Each directory has its own README, with its status, how to build it and what the code shows, and a
`make check` that rebuilds the program and compares it with the original.

## The compiler

| Directory | Program | Status |
|---|---|---|
| [`bcc/`](bcc/) | **Borland C++ 2.0** (1991), `BCC.EXE`, the command-line compiler | Complete: rebuilds byte-identical (SHA-256 `dd5744b9...`) |
| [`cpp/`](cpp/) | **Borland C++ 2.0** (1991), `CPP.EXE`, the standalone preprocessor | Complete: rebuilds byte-identical (SHA-256 `39879c60...`) |

## Linker, assembler and librarian

| Directory | Program | Status |
|---|---|---|
| [`tlink/`](tlink/) | **Borland C++ 2.0** (1991), `TLINK.EXE` 4.0, the linker (assembler, C and the far-memory heap) | Rebuilds byte-identical (SHA-256 `81701462...`); the assembler core is decoded and partly named |
| [`tasm/`](tasm/) | **Borland C++ 2.0** (1991), `TASM.EXE` 2.51, the assembler (assembler) | Rebuilds byte-identical (SHA-256 `712e4127...`); the source is still the generated draft (address labels, undecoded code, no comments) |
| [`tlib/`](tlib/) | **Borland C++ 2.0** (1991), `TLIB.EXE` 3.01, the librarian | Complete: rebuilds byte-identical (SHA-256 `b06333a7...`) |

## Protected mode

| Directory | Program | Status |
|---|---|---|
| [`tkernel/`](tkernel/) | **Borland C++ 2.0** (1991), `TKERNEL.EXE`, the protected-mode kernel of BCCX, TLINKX and TASMX (assembler) | Rebuilds byte-identical (SHA-256 `ffe579ec...`); the source is the generated draft |
| [`tkinst/`](tkinst/) | **Borland C++ 2.0** (1991), `TKINST.EXE` 2.0, the installer of the protected-mode kernel (C and assembler) | Complete: rebuilds byte-identical (SHA-256 `6f84a44c...`; header padded after the link) |
| [`dpmiload/`](dpmiload/) | **Borland C++ 2.0** (1991), `DPMILOAD.EXE` 1.000, the loader of the protected-mode tools (assembler) | Complete: rebuilds byte-identical (SHA-256 `9a84d9da...`) |
| [`tasmx/`](tasmx/) | **Borland C++ 2.0** (1991), `TASMX.EXE` 2.51, the protected-mode assembler (assembler, NE) | Rebuilds byte-identical with our NE writer (SHA-256 `d1cf3399...`); the source is the generated draft |
| [`xloader/`](xloader/) | **Borland C++ 2.0** (1991), `TLINKX.EXE`/`.OVY` and `BCCX.EXE`/`.OVY`, the protected-mode linker and compiler with their loaders (C and assembler) | Both, and TLINKX.OVY and BCCX.OVY (with our YO writer), rebuild byte-identical; the sources are generated drafts, the `.OVY` ones mostly bytes |
| [`emstest/`](emstest/) | **Borland C++ 2.0** (1991), `EMSTEST.COM`, the expanded-memory test (Turbo Pascal 3) | Rebuilds byte-identical (SHA-256 `eb811fd7...`) with a patched TP 3.02A; the source is recovered in full |

## Utilities

| Directory | Program | Status |
|---|---|---|
| [`make/`](make/) | **Borland C++ 2.0** (1991), `MAKE.EXE` 3.5, the program maintainer | Complete: rebuilds byte-identical (SHA-256 `cdcc73cc...`) |
| [`grep/`](grep/) | **Borland C++ 2.0** (1991), `GREP.COM` 3.0, the file searcher (assembler) | Complete: rebuilds byte-identical (SHA-256 `a4c9faa6...`) |
| [`touch/`](touch/) | **Borland C++ 2.0** (1991), `TOUCH.COM` 3.0, sets files' date and time | Complete: rebuilds byte-identical (SHA-256 `8a7077f3...`) |
| [`objxref/`](objxref/) | **Borland C++ 2.0** (1991), `OBJXREF.COM` 3.0, the cross-reference of object modules | Complete: rebuilds byte-identical (SHA-256 `835a536a...`) |
| [`tcref/`](tcref/) | **Borland C++ 2.0** (1991), `TCREF.EXE` 2.0, the cross-reference reporter for TASM (assembler) | Complete: rebuilds byte-identical (SHA-256 `78570a17...`) |
| [`trigraph/`](trigraph/) | **Borland C++ 2.0** (1991), `TRIGRAPH.EXE` 1.0, the converter of ANSI trigraphs (C++) | Complete: rebuilds byte-identical (SHA-256 `b9810f09...`) |
| [`thelp/`](thelp/) | **Borland C++ 2.0** (1991), `THELP.COM` 2.0, the help TSR (assembler) | Complete: rebuilds byte-identical (SHA-256 `f2559182...`) |
| [`trancopy/`](trancopy/) | **Borland C++ 2.0** (1991), `TRANCOPY.EXE` 2.0, the copier of the IDE's Transfer menu (C++) | Complete: rebuilds byte-identical (SHA-256 `bb66a1e9...`) |

## Support

| Directory | Program | Status |
|---|---|---|
| [`rtl/`](rtl/) | the run-time library Borland linked its own 1990-91 utilities with | The modules no released library has, as C (used by `bc20/tlib` and `bc20/make`) |
| [`port/`](port/) | `BCC.EXE` as a native compiler and library, for decompiling Borland-built games | Complete: every function checked against BCC.EXE; 1874 of 1880 corpus compiles identical; native binaries and a library |

## The compiler at a glance

- **298 sources** in 15 subsystem directories: 265 C files (Borland C++ 2.0 and Turbo C 2.01)
  and 33 hand-written TASM modules. The original's own split into compiled C and hand-written
  assembly is kept: assembly was never forced into C, and compiled code was never left as
  assembly.
- **Every name is recovered or descriptive**: about 3,100 functions, globals and labels, 300
  record fields (`src/include/FIELDS.H`), 40 record layouts (`src/include/RECORDS.H`),
  message, token, type-kind and operator constants.
- **Every file is documented**: a role line, an overview and function comments
  (about 10,000 lines of comments), with [a source map](bcc/docs/SOURCE-MAP.md) and
  [how the compiler is organised](bcc/docs/SUBSYSTEMS.md).
- **Findings**: likely bugs in the original, duplicated code, dead code, and how Borland's
  compiler worked inside: [bcc/docs/FINDINGS.md](bcc/docs/FINDINGS.md). Some highlights:
  the parser is hand-written recursive descent with an operator-precedence expression parser
  (no yacc); the code generator's tail merging shaped how the original source had to be
  written; `strrchr` reads one byte before an empty string; freed precompiled-header file
  space is never reused.

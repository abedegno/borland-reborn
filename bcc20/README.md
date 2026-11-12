# Borland C++ 2.0: BCC.EXE

The command-line compiler of Borland C++ 2.0 (1991), recovered as C and TASM source that
rebuilds Borland's `BCC.EXE` byte for byte (502,432 bytes, SHA-256
`dd5744b99c6fa61dc1d95c580a1f1d6f1b3e97ae8b920dd6e9cfedce29f82fb6`).

| | |
|---|---|
| Sources | 298: 236 C files built with Borland C++ 2.0, 29 with Turbo C 2.01, 33 TASM modules |
| Lines | about 71,000 lines of C, a fifth of them comments |
| Names | about 3,100 functions, globals and labels; 300 record fields; 40 record layouts |
| Status | every function matches, every relocation verifies, the linked EXE is byte-identical |
| Modding | the sources also link into a BCC.EXE whose layout may change; it compiles 478 test cases exactly as Borland's does ([docs/MODDING.md](docs/MODDING.md)) |

## Layout

| Path | What it is |
|---|---|
| [`src/`](src/) | the recovered sources, one directory per part of the compiler ([src/README.md](src/README.md)) |
| [`src/include/`](src/include/) | shared headers: data, prototypes, record fields and layouts, named constants |
| [`docs/SUBSYSTEMS.md`](docs/SUBSYSTEMS.md) | how BCC.EXE is organised, from the command line to the object file |
| [`docs/SOURCE-MAP.md`](docs/SOURCE-MAP.md) | every source with its role and functions |
| [`docs/FINDINGS.md`](docs/FINDINGS.md) | likely bugs, duplicated and dead code, engine findings, open questions |
| [`map/`](map/) | every rename with its evidence (`names.tsv`), file names (`filenames.tsv`), directories |
| `targets/`, `symbols.tsv` | what each source must reproduce, and the global symbol table |
| `linkgroups/`, `reconstructed/`, the CSV/JSON tables | the original layout the exact link needs |
| `scripts/prepare.py` | makes the link inputs that are derived from your own BCC.EXE |
| `tools/` | the exact link and its helpers; the modding build (`modlink.py`, `modtest.py`) |
| [`docs/MODDING.md`](docs/MODDING.md) | building with changed sources, and how that build is checked |

## Build

See [../docs/SETUP.md](../docs/SETUP.md). After the toolchains are installed:

```sh
../.venv/bin/python scripts/prepare.py
../.venv/bin/python ../exhume/tools/gate.py check --all
```

## A tour of the source

- **Start here**: [`driver/RMAIN13C.C`](src/driver/RMAIN13C.C) (main), then
  [`driver/OPTIONS.C`](src/driver/OPTIONS.C) (command line) and
  [`driver/DRVLINK.C`](src/driver/DRVLINK.C) (compiling each file, running TASM and TLINK).
- **Front end**: [`lexer/LEXER.C`](src/lexer/LEXER.C), [`preproc/PREPROC.C`](src/preproc/PREPROC.C),
  the statement parsers [`parser/STMTCPP.C`](src/parser/STMTCPP.C) and
  [`parser/STMTC.C`](src/parser/STMTC.C), and the operator-precedence expression parser
  [`parser/OPPREC.C`](src/parser/OPPREC.C).
- **C++**: classes [`cpp/CLASSDEF.C`](src/cpp/CLASSDEF.C), overloading
  [`cpp/OVERLOAD.C`](src/cpp/OVERLOAD.C), name mangling [`cpp/MANGLE.C`](src/cpp/MANGLE.C).
- **Back end**: [`codegen/CGEXPR.C`](src/codegen/CGEXPR.C), switch lowering
  [`codegen/SWITCH.C`](src/codegen/SWITCH.C), the register allocator
  [`codegen/REGALLOC.C`](src/codegen/REGALLOC.C), cross-jumping
  [`codegen/CROSSJMP.C`](src/codegen/CROSSJMP.C).
- **Memory**: BCC keeps everything in far pools with its own virtual-memory heap (EMS,
  extended memory, swap file): [`heap/HEAPMAIN.C`](src/heap/HEAPMAIN.C) explains it.
- **Built-in assembler** for inline `asm`: [`inlasm/INLINASM.ASM`](src/inlasm/INLINASM.ASM).

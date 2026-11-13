# borland-reborn

**Borland's DOS compilers, rebuilt from their own binaries.**

This repository recovers the source code of classic Borland compilers from the published
executables, so that the recovered C and assembly rebuild each executable **byte for byte**
with the original Borland toolchain. Then it makes that source readable: real names, named
record fields, comments on every file, and notes on what the compiler does and where it goes
wrong.

| Directory | Program | Status |
|---|---|---|
| [`bcc20/`](bcc20/) | **Borland C++ 2.0** (1991), `BCC.EXE`, the command-line compiler | Complete: rebuilds byte-identical (SHA-256 `dd5744b9...`) |
| [`cpp20/`](cpp20/) | **Borland C++ 2.0** (1991), `CPP.EXE`, the standalone preprocessor | Complete: rebuilds byte-identical (SHA-256 `39879c60...`) |

More Borland and Turbo versions will join as further top-level directories, sharing the
[`scripts/`](scripts/) and the [Exhume](https://github.com/abedegno/Exhume) build tools.

## Borland C++ 2.0 at a glance

- **298 sources** in 15 subsystem directories: 265 C files (Borland C++ 2.0 and Turbo C 2.01)
  and 33 hand-written TASM modules. The original's own split into compiled C and hand-written
  assembly is kept: assembly was never forced into C, and compiled code was never left as
  assembly.
- **Every name is recovered or descriptive**: about 3,100 functions, globals and labels, 300
  record fields (`src/include/FIELDS.H`), 40 record layouts (`src/include/RECORDS.H`),
  message, token, type-kind and operator constants.
- **Every file is documented**: a role line, an overview and function comments
  (about 10,000 lines of comments), with [a source map](bcc20/docs/SOURCE-MAP.md) and
  [how the compiler is organised](bcc20/docs/SUBSYSTEMS.md).
- **Findings**: likely bugs in the original, duplicated code, dead code, and how Borland's
  compiler worked inside: [bcc20/docs/FINDINGS.md](bcc20/docs/FINDINGS.md). Some highlights:
  the parser is hand-written recursive descent with an operator-precedence expression parser
  (no yacc); the code generator's tail merging shaped how the original source had to be
  written; `strrchr` reads one byte before an empty string; freed precompiled-header file
  space is never reused.

## Rebuild it yourself

You need the original Borland programs (not included: see [NOTICE.md](NOTICE.md)). The full
guide is [docs/SETUP.md](docs/SETUP.md); in short:

```sh
git clone --recurse-submodules https://github.com/abedegno/borland-reborn
cd borland-reborn
# 1. download Borland C++ 2.0 and Turbo C 2.01 from WinWorld (links in docs/SETUP.md)
python3 scripts/setup-toolchains.py --bc20 "Borland CPP 2.0 (1991) (3.5-720k).7z" --tc201 "<Turbo C 2.01>.7z"
# 2. Python packages and the DOS emulator (dosbox-x), node
python3 -m venv .venv && .venv/bin/pip install -r exhume/tools/requirements.txt
# 3. generate the link inputs from your own BCC.EXE, then compile, verify and link everything
cd bcc20
../.venv/bin/python scripts/prepare.py
../.venv/bin/python ../exhume/tools/gate.py check --all
```

The last command compiles all 298 sources in DOS, checks every function against the
original byte for byte, verifies every relocation and name, and links a new `BCC.EXE` that is
identical to Borland's.

To change the compiler, use the **modding build**. It links the same sources with a layout
TLINK chooses, so any function may grow or shrink, new data may go between any two data
items, and new source files may be added. It is checked by running 522 compiles with both
compilers and comparing every output, with the code and the data moved in several ways and
with new and edited files. A tracing emulator shows which words of the data the compiler
uses as addresses, and which of its code the tests run: 70%
([bcc20/docs/COVERAGE.md](bcc20/docs/COVERAGE.md)). See [bcc20/docs/MODDING.md](bcc20/docs/MODDING.md).

## How it works

[docs/HOW-IT-WORKS.md](docs/HOW-IT-WORKS.md) explains the method: identifying the exact
compiler and switches, matching each function, verifying what matching cannot see, linking
the whole program with TLINK, and the readability pass that followed, all checked by the
same byte-for-byte gate.

## Contributing, licence and notice

Corrections to names, comments and findings are welcome: see [CONTRIBUTING.md](CONTRIBUTING.md).
The project's own scripts and documentation are MIT-licensed ([LICENSE](LICENSE)). The
recovered sources are derived from Borland's copyrighted programs and are provided for study
and preservation, with no rights claimed: read [NOTICE.md](NOTICE.md).

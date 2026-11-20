# borland-reborn

**Borland's DOS compilers, rebuilt from their own binaries.**

This repository recovers the source code of classic Borland compilers from the published
executables, so that the recovered C and assembly rebuild each executable **byte for byte**
with the original Borland toolchain. Then it makes that source readable: real names, named
record fields, comments on every file, and notes on what the compiler does and where it goes
wrong.

| Directory | Product | Status |
|---|---|---|
| [`bc20/`](bc20/) | **Borland C++ 2.0** (1991): the compiler `BCC.EXE`, `CPP`, `TLINK`, `TASM`, `TLIB`, `MAKE`, the protected-mode tools (`TKERNEL`, `BCCX`, `TLINKX`, `TASMX`) and the utilities, 22 executables in all; plus its run-time library modules and a native port of the compiler | Every program rebuilds byte-identical; [bc20/README.md](bc20/README.md) lists each one |

More Borland and Turbo versions will join as further top-level directories (`tc201/`, ...), sharing the
[`scripts/`](scripts/) and the [Exhume](https://github.com/abedegno/Exhume) build tools.

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
# 3. generate the link inputs from your own BCC.EXE (Borland C++ 2.0's compiler), then compile, verify and link everything
cd bc20/bcc
../../.venv/bin/python scripts/prepare.py
../../.venv/bin/python ../../exhume/tools/gate.py check --all
```

The last command compiles all 298 sources in DOS, checks every function against the
original byte for byte, verifies every relocation and name, and links a new `BCC.EXE` that is
identical to Borland's.

To change the compiler, use the **modding build**. It links the same sources with a layout
TLINK chooses, so any function may grow or shrink, new data may go between any two data
items, and new source files may be added. It is checked by running 1836 compiles with both
compilers (Borland's own example programs and old GCC and cfront tests among them) and comparing every output, with the code and the data moved in several ways and
with new and edited files. A tracing emulator shows which words of the data the compiler
uses as addresses, and which of its code the tests run: 83%
([bc20/bcc/docs/COVERAGE.md](bc20/bcc/docs/COVERAGE.md)). See [bc20/bcc/docs/MODDING.md](bc20/bcc/docs/MODDING.md).

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

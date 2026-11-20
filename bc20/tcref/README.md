# bc20/tcref: Borland C++ 2.0's TCREF.EXE, as source

Turbo CREF 2.0 turns the `.XRF` cross-reference files TASM writes into a `.REF` report:
every global symbol with where it is defined and used, and with `/r` a report per module.
It shipped with Borland C++ 2.0 (1991) as a 7,856-byte `.EXE`, written in assembler. The
four TASM modules in [src](src) rebuild it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/TCREF.EXE` of Borland C++ 2.0, 7,856 bytes, SHA-256 `78570a175e80662ebd73f378ba0e6e0c3594efad26496f57f3ad10603db2ad08` |
| Source | 4 TASM modules, 3,071 lines |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 and Turbo C 2.01 with `scripts/setup-toolchains.py` (`--bc20` and
`--tc201`; [../../docs/SETUP.md](../../docs/SETUP.md)), then:

```sh
cd bc20/tcref
make check          # or: ../../.venv/bin/python tools/build.py
```

## The source

| File | What it does |
|---|---|
| [src/MAIN.ASM](src/MAIN.ASM) | the start, the command line and response files, the messages and the data |
| [src/REPORT.ASM](src/REPORT.ASM) | writing the REF file: pages, headings, numbers, the date and time |
| [src/CREF.ASM](src/CREF.ASM) | reading the XRF files into the tables, and driving the reports |
| [src/DOSIO.ASM](src/DOSIO.ASM) | the DOS calls, as far procedures (some never called) |

TCREF.EXE keeps no symbols. Routines and strings whose job is clear have descriptive
names; the rest are named by address (`L01624` is linear address 1624h in the image,
`v_0380` offset 380h in DATA).

## How Borland built it

- **Assembler: TASM 2.51**, one pass, case-sensitive (`/ml`). Calls between routines of
  the same segment are written `call far ptr` under `nosmart`: the original keeps those as
  far calls, which TASM's smart mode would turn into `push cs` and a near call.
- **Linker: Turbo C 2.01's TLINK 2.0**: its EXE header (the `FB 20` marker).
- **Four modules, MAIN linked first.** The relocations in the EXE come module by module:
  MAIN's first although its code is last in memory, then the two modules of the CODE
  segment, split where the linker padded the second to a word (one zero byte at 71Fh).
  MAIN declares the other segments first, which puts them first in memory.
- TCREF sets SS to its data segment and keeps its stack there; the stack segment in the
  header is never used.

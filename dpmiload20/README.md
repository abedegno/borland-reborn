# dpmiload20: Borland C++ 2.0's DPMILOAD.EXE, as source

The DPMI Loader 1.000 runs Borland C++ 2.0's protected-mode tools (BCCX, TLINKX): under a
DPMI host it loads a program linked by TLINK `/2`, bringing its segments in on demand
through the segment-not-present exception, and hooks INT 21h and INT 2Fh. It shipped as a
10,864-byte `.EXE` written in assembler. [src/DPMILOAD.ASM](src/DPMILOAD.ASM) rebuilds it
byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/DPMILOAD.EXE` of Borland C++ 2.0, 10,864 bytes, SHA-256 `9a84d9da9077f6d9d59b535c5c2dce7f81766703f005ef8421a1e2a4ff30715b` |
| Source | one TASM file, 2,063 lines |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py --bc20`
([../docs/SETUP.md](../docs/SETUP.md)), then `make check` (or `../.venv/bin/python
tools/build.py`).

## How Borland built it

- **Assembler: TASM 2.51**, one pass, `.286` (`pusha`, `enter` and DPMI calls through
  INT 31h). Forward jumps written without `short` keep the `nop` a single pass leaves.
- **Linker: Borland C++ 2.0's TLINK 4.0.** The source refers to `__SEGTABLE__`, a name
  TLINK defines itself: it writes the segment table, `FBOV` and four entries, into the
  program as a segment of its own.
- **The header of a stub.** The relocation table is at 40h, where TLINK puts it when it
  copies an EXE in as the stub of a New Executable; linking any New Executable with
  `STUB 'DPMILOAD.EXE'` gives Borland's header exactly, apart from the file size and the
  NE offset. The build moves the table to 40h after the link
  ([tools/build.py](tools/build.py)).

## What the code shows

- The entry point starts with `int 3`, a breakpoint left in.
- The two far jumps at the ends of the INT 2Fh and INT 21h hooks hold the old vectors,
  written through a data alias of the code segment.
- The code segment holds two messages of its own.
- DPMILOAD.EXE keeps no symbols: routines whose job is clear have names, the rest are
  named by address.

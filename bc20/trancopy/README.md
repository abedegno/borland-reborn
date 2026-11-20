# bc20/trancopy: Borland C++ 2.0's TRANCOPY.EXE, as source

TRANCOPY 2.0 copies the Transfer menu from one Turbo C++ or Borland C++ project file
(`.PRJ`) into another. It can merge the two menus, or with `-r` replace the destination's.
It shipped as a 17,620-byte `.EXE` written in C++. The files in [src/](src/) rebuild it
byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/TRANCOPY.EXE` of Borland C++ 2.0, 17,620 bytes, SHA-256 `bb66a1e924f5f9d68fa50fbb8123692ac829774da6d8fb490978c8fdb7f3d0d9` |
| Source | two C++ files and a header: [TRANCOPY.CPP](src/TRANCOPY.CPP) (the sections, the merge and `main`), [PRJFILE.CPP](src/PRJFILE.CPP) with [PRJFILE.H](src/include/PRJFILE.H) (the project file); and the library module [PUTC.C](src/PUTC.C) |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py --bc20`
([../../docs/SETUP.md](../../docs/SETUP.md)). Then run `make check` (or `../../.venv/bin/python
tools/build.py`). `make gate` also matches each file against its part of the original
with Exhume. Exhume needs two small additions for C++ objects, which are in this tree's
`exhume/` checkout: its fixup reader has to accept Borland C++'s virtual segments, and it
must not cut mangled names to 32 characters.

## How Borland built it

- **Compiler: Borland C++ 2.0's BCC, as C++**, large model, without `-O`. Every `return`
  jumps to the function's exit, as unoptimised code does. Inline expansion was off
  (`-vi-`), so `PrjFile::tell()` is a call. Its out-of-line copy is a "virtual segment" in
  the object, and TLINK places it after TRANCOPY's code.
- **The library: Borland C++ 2.0's own** (`C0L.OBJ` and `CL.LIB`, with the 1991 banner)
  with one exception. TRANCOPY's PUTC module differs from the released library's in a
  single instruction in `__fputn`: `fp->level += n` is one `add` to memory where the
  released module loads, adds and stores. [src/PUTC.C](src/PUTC.C) gives both from the
  same source; the cast `(int)n` makes the difference. It is compiled into `_TEXT`
  (`-zC_TEXT`) like Borland's own library modules, so it lands among them.
- **Linker: TLINK 4.0.** The library's code is all in `_TEXT` after the startup code, so it
  comes before TRANCOPY's two segments.

## What the code shows

- A project file is a header, then sections from offset 20h on, each with an id, a size and
  its data. TRANCOPY keeps the sections it knows (ids 32h to 37h, the transfer items
  (10), and the end marker) and writes them back in its own order.
- A transfer item is 323 bytes: a flag byte, the title, the program, the options and the
  hot key. Merging matches items by title, replaces those that differ, adds the rest
  before the destination's last item, and stops adding at 16 items. A hot key that the
  destination already uses is cleared ("Unassigned").
- The merge's table of used hot keys has 10 entries indexed by the hot key plus 56. A hot
  key outside -56 to -47 would land outside it.
- When the destination cannot be opened, or is not a project file, the source is left
  open.
- `PrjFile` has four bytes that nothing uses.
- TRANCOPY.EXE keeps no symbols. The class, member and function names are descriptive.

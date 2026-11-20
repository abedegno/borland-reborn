# trigraph20: Borland C++ 2.0's TRIGRAPH.EXE, as source

TRIGRAPH 1.0 converts C source files between ANSI trigraphs and plain characters. By
default it replaces each trigraph (`??=`, `??(`, `??/` and the rest) with the character it
stands for and joins lines spliced by a backslash. With `-u` it does the opposite. It
shipped as a 12,150-byte `.EXE` written in C++. The files in [src/](src/) rebuild it byte for
byte.

## Status

| | |
|---|---|
| The original | `BIN/TRIGRAPH.EXE` of Borland C++ 2.0, 12,150 bytes, SHA-256 `b9810f093f6a279845547fcb4d03ef538ad7a18f2160fb1fe5d8e650cb741e1b` |
| Source | two C++ files and a header: [FILEIO.CPP](src/FILEIO.CPP) (buffers and files), [TRIGRAPH.CPP](src/TRIGRAPH.CPP) (command line and filters), [TRIGRAPH.H](src/include/TRIGRAPH.H); and the library module [FREAD.C](src/FREAD.C) |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 and Turbo C++ 1.01 with `scripts/setup-toolchains.py --bc20 ... --tc101 ...`
([../docs/SETUP.md](../docs/SETUP.md)), then `make check` (or `../.venv/bin/python
tools/build.py`). `make gate` also matches each file against its part of the original with
Exhume.

## How Borland built it

- **Compiler: Borland C++ 2.0's BCC, as C++**, small model, `-O`. The names are mangled,
  and `*p++` increments before it loads, which BCC 2.0 does only in C++ mode.
- **Two files.** FILEIO's string literals come before TRIGRAPH's initialised data in the
  data segment, so the code was split in two where the file functions end.
- **Library: an in-between one**, as in the other Borland C++ 2.0 utilities: Borland C++
  2.0's CS.LIB with FFLUSH, PUTC, GETC and OPEN from Turbo C++ 1.01, and an `fread` that
  neither library has. [src/FREAD.C](src/FREAD.C) is Turbo C++ 1.01's `fread` compiled by
  BCC 2.0 with `-B -O -Z`; it is older than the `fread` TLIB.EXE has, and reads nothing for a
  request of 64K or more.
- **Startup: Borland C++ 2.0's C0.ASM with Turbo C++ 1.01's banner**, small model. Its exit
  code checks for null pointer writes by summing the banner's bytes, so the checksum constant
  changes with the banner (0CA5h); `../scripts/interim_rtl.py` makes both changes.
- **Linker: Borland C++ 2.0's TLINK 4.0**, with WILDARGS.OBJ, so the file names on the
  command line may hold wildcards.

## What the code shows

- With `-n` or `-x` the output is written to a temporary file that nothing renames to the
  output name, so those options leave the result in the temporary file. On an error the
  program removes the output name rather than the temporary file.
- The input buffer marks its end with the character 0xFF, so a 0xFF byte in the input ends
  the conversion there.
- A 10-byte block, `$*$*$*` and four bytes, sits in the data unused.
- `tmpname` is 14 or 15 bytes (the BSS shows which only up to the word alignment); `L_tmpnam`
  is 13.
- TRIGRAPH.EXE keeps no symbols; all names are descriptive.

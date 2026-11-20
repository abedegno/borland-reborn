# bc20/objxref: Borland C++ 2.0's OBJXREF.COM, as source

OBJXREF 3.0 is Borland's cross-reference of object modules: it reads object files,
libraries, linker response files and Turbo C project files, links them as TLINK would, and
reports who defines and who uses each public symbol, and how big each module's part of
each segment and class is. It shipped with Borland C++ 2.0 (1991) as a 37,957-byte `.COM`.
The C files in [src](src) rebuild it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/OBJXREF.COM` of Borland C++ 2.0, 37,957 bytes, SHA-256 `835a536ac3c01b2f8633fb6e98980f45b55dfa924215023fc2087d494d1152e1` |
| Source | 3 C files, 2,935 lines |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 and Turbo C 2.01 with `scripts/setup-toolchains.py` (`--bc20` and
`--tc201`; [../../docs/SETUP.md](../../docs/SETUP.md)), then:

```sh
cd bc20/objxref
make check          # or: ../../.venv/bin/python tools/build.py
```

It ends with `OBJXREF.COM: byte-identical to the original (SHA-256 835a536a...)`. The new
file is `build/link/out/OBJXREF.COM`, with the linked `OBJXREF.EXE` and TLINK's map beside
it. `tools/gate.sh` also matches every source file against its part of the original with
Exhume (`tools/match.py`).

## The source

| File | What it does |
|---|---|
| [src/OBJXREF.C](src/OBJXREF.C) | everything of OBJXREF's own: reading, the tables, linking, sorting, the reports, `main()` |
| [src/DEMANGLE.C](src/DEMANGLE.C) | C++ names for the reports: TLIB's demangler, the same file |
| [src/PRJ.C](src/PRJ.C) | reading a Turbo C project file in its binary form |

They are in link order, which is the order of their code in OBJXREF.COM. OBJXREF.COM keeps
no symbols, so every name is descriptive.

## How Borland built it

The evidence is the bytes of OBJXREF.COM. [tools/build.py](tools/build.py) repeats each
step.

- **A packed EXE.** OBJXREF.COM is an EXE squeezed into a `.COM` that unpacks itself: a
  stub jumps to a trailer that restores the stub's bytes, relocates the image (the
  relocations are chained through the file, one chain per segment value) and expands it
  backwards in place (runs of literal bytes and runs of zeros), then starts it with the
  EXE's registers. [tools/compack.py](tools/compack.py) packs and unpacks it; packing the
  unpacked file gives OBJXREF.COM again, and the same holds for Turbo C++ 1.01's
  OBJXREF.COM, an earlier build, so the packer's rules are known, not guessed.
- **Compiler: Turbo C 2.01**, compact model, `-G -O -Z -d` for all three files. `-G` shows
  in the stack cleaned up with `add sp,N`, `-d` in duplicate strings kept once. The
  demangler is TLIB's file; TLIB compiled it without `-G` and `-d`.
- **One source file for OBJXREF's own code.** Turbo C 2.01 word-aligns each object's data,
  and the string literals of functions from all over OBJXREF's code follow its messages at
  odd offsets, in one pool. OBJXREF.C was 15,127 bytes of code in one file.
- **Startup code and library: Turbo C 2.01's own** `C0C.OBJ` and `CC.LIB`, unchanged.
- **Linker: Turbo C 2.01's TLINK 2.0**, `/c /m`.

## What the code shows

- **Where the variables are.** Turbo C 2.01 lays out a file's uninitialised variables in
  ascending order of a hash of the name, (first char + 4 &times; last char + 32 &times;
  length) &amp; 1023, ties in order of first sight. The names in OBJXREF.C were chosen to
  fall in the original's order and are declared in that order; a few (`numcls`, `modcnt`,
  `prjtxtbuf`, `allmodules`) are shaped by that rather than by style.
- **Spellings kept for their code** are marked `match:` in the source. One is a `goto` into
  a loop in PRJ.C, in two functions: the only spelling found that tests a field straight
  after `fread()` as the original does. None changes what OBJXREF does.
- **Found in the code, kept as it is:**
  - `segpiece()` takes a segment index as a `char`: in a module with more than 127
    segments, LEDATA for index 128 or more reads before the start of `segindex[]`.
  - After each library module, `load()` skips to the next page from the position in its
    8 KB buffer, which is right only for library pages up to 8 KB.
  - `O_CPUTS` (bit 15 of the flags) sends console messages through `cputs()`, but nothing
    sets it.
  - The sorts compare names ignoring case whether or not `/I` was given, and so does `/N`.
  - The usage text says "extentions" and the segment report "ABSOULTE"; the limit messages
    say "Modules defines".
  - `adddef()` has no `return`, and `resolve()` stores what it leaves in DX:AX in a variable
    it never reads.
  - These come from reading the code; they have not been run.
- **Never used:** PRJ.C's `prjstring()` and the "Turbo C Configuration File" signature, and
  the `$*$*$*` ID block at the start of the data.

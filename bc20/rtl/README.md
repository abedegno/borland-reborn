# bc20/rtl: the run-time library Borland's own utilities were linked with

Borland's utilities of 1990-91 (TOUCH, TLIB and MAKE of Borland C++ 2.0, so far) were not linked
with a library that Borland released. Their startup code is Borland C++ 2.0's with Turbo
C++ 1.01's banner, and their library modules are a mix: most are identical to Borland C++
2.0's, some to Turbo C++ 1.01's, and a few to neither.

[../../scripts/interim_rtl.py](../../scripts/interim_rtl.py) puts that library back together from
the two products' own files, and this folder holds the modules neither product has, as C:

| Module | Functions | BCC switches | In |
|---|---|---|---|
| [src/FFLUSH.C](src/FFLUSH.C) | `fflush` | `-mc -O -Z` | TLIB |
| [src/FGETS.C](src/FGETS.C) | `fgets` | `-mc -O -Z` | TLIB |
| [src/FREAD.C](src/FREAD.C) | `fread` | `-mc -B -O -Z` | TLIB |
| [src/GETC.C](src/GETC.C) | `_fgetc`, `fgetc`, `fgetchar` | `-mc -B -O -Z -k-` | TLIB |
| [src/FNSPLIT.C](src/FNSPLIT.C) | `fnsplit` | `-mc -O -Z -a` | MAKE |
| [src/SEARCHP.C](src/SEARCHP.C) | `searchpath`, `__searchpath` | `-mc -B -O -Z` | MAKE |

FFLUSH.C is in MAKE.EXE too. The library was not the same for every utility: MAKE.EXE has
Turbo C++ 1.01's VPRINTER and the FNSPLIT and SEARCHP above, where TLIB.EXE has Borland C++
2.0's VPRINTER and FNSPLIT. So TLIB's build takes the shared list in
[../../scripts/interim_rtl.py](../../scripts/interim_rtl.py), and MAKE's adds its own two
([../make/tools/build.py](../make/tools/build.py)).

## What the code shows

- They are Turbo C++ 1.01's library source, changed a little, compiled with **Borland C++
  2.0's BCC**. Their code follows Turbo C++ 1.01's modules instruction for instruction
  except where a compiler decides (register choice, the order of a far pointer's two
  stores). FFLUSH.C with `fp->level -= count` compiles with Turbo C++ 1.01 to its library's
  FFLUSH exactly; as written here, with BCC, to TLIB.EXE's.
- The source differs from the released one in small ways: `level` is decremented as
  `level = level - 1` (in `getc()` too, so the headers of the time differed), and FREAD and
  GETC went through the assembler (`-B`), which gives sign-extended immediates.
- GETC.C has three statements kept only for their code, each marked `match:`. The compiler
  that built the original left two jumps that BCC optimises away, and one unreachable jump
  that BCC never writes; `(void)0` keeps the first two, and one line of inline assembler
  stands in for the third. The names of the static helpers (`_flushout`, `_ffill`,
  `__fread`) are guesses.
- FNSPLIT.C is an older `fnsplit()` than Borland C++ 2.0's: its helper takes the whole
  buffer size and clears the source itself, and a '.' always ends the extension. SEARCHP.C
  is Borland C++ 2.0's module but for the drive letter, which it stores with one conditional
  expression. Its one `match:` statement is an empty `asm` line: the original reloads a
  pointer at that point, as code after inline assembler does. Their `/* target: */` lines
  are MAKE's, so `bc20/make/tools/gate.sh` matches them against MAKE.EXE.

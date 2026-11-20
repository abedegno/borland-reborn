# emstest20: Borland C++ 2.0's EMSTEST.COM, as source

EMSTEST.COM is the "Borland C++ EMS Test Program Version 2.0" (1991), a test of expanded memory
written in Turbo Pascal 3. It shipped as a 19,664-byte `.COM`.
[src/EMSTEST.PAS](src/EMSTEST.PAS) rebuilds it byte for byte with a patched Turbo Pascal 3.02A.

## Status

| | |
|---|---|
| The original | `BIN/EMSTEST.COM` of Borland C++ 2.0, 19,664 bytes, SHA-256 `eb811fd7c038e34bcb7699c10c629ed30c5d7cb15ddf0bb5b7fbf5ad734dea73` |
| Build | **byte-identical** to the original, with two documented native differences (below) |
| Source | [src/EMSTEST.PAS](src/EMSTEST.PAS), recovered in full. |

## Building

The build needs Turbo Pascal 3.02A, which is not in `scripts/setup-toolchains.py`. Put its
`TURBO.COM` (39,731 bytes, SHA-256 `480dcdd3...`) and `TURBO.MSG` in `toolchains/TP302A`. Borland's
freeware Turbo Pascal 3.02 has the same TURBO.COM. You also need emu2: build it with
`exhume/tools/setup-emu2.sh`, or set `EMU2` to it. Then run `make check` (or `python3
tools/build.py`).

TP3 has no command-line compiler. The build therefore runs TURBO.COM in emu2 and types its menu
keys through a pseudo-terminal: Options, Com-file, "mAximum free dynamic memory" 1000h, Main
file, Compile.

## What the program does

1. **Part one, detection.** It checks the INT 67h vector and the `EMMXXXX0` device name, then
   prints the manager's version, the handler's address, the page frame and the page count. It
   also lists the handles and their pages.
2. **Part two, basic functions.** It allocates up to 128 pages, saves the page map, fills every
   page with a pattern and checks it, then restores the map and frees the pages.
3. **Part three, I/O.** It does the same, then makes 250 rounds of random page swaps that also
   write and read the pages to a temporary file, `EMSTEST.$$$`.

Every step is reported with the LIM error messages, and `Esc` between the parts stops the test.

## How Borland built it, and the native differences

- **The compiler.** EMSTEST.COM's runtime, which TP3 copies from TURBO.COM into every program,
  matches no released Turbo Pascal 3. The ones tried were 3.0 generic MS-DOS, 3.00B, 3.01A,
  3.01A with 8087 and BCD, 3.02A, and Borland's freeware 3.02, which is the same as 3.02A. It is
  3.02A's runtime without a 14-byte window check in the cursor routine at 215h, so everything
  after that point sits 14 bytes lower. Its display settings are TINST's "Default display mode".
- **Native difference 1: a patched TP 3.02A.** [tools/mkturbo.py](tools/mkturbo.py) makes it:
  - it lowers by 14 the compiler's constants for where a program starts, and the runtime
    addresses it emits calls to ([tools/compiler.tsv](tools/compiler.tsv), 47 words);
  - it makes the runtime from 3.02A's with [tools/rt302.tsv](tools/rt302.tsv), each change
    with its reason;
  - the build puts that runtime in place of the one the compiler writes.

  The program part, everything the compiler generates from the source, comes from the
  compiler unchanged apart from those addresses.
- **Native difference 2: two words of the start-up block.** The words at 2C44h and 2C46h
  record where the compiler was loaded in memory when Borland compiled it (47C9h and 518Ch). A
  build in emu2 writes other values, and so do Borland's own 1985 TP3 programs. The build sets
  them.
- **Options and directives the bytes show:** `{$P512}`, a 512-byte output buffer, which is why
  the program's variables start at 462h; and maximum free dynamic memory 1000h.
- **Source shapes the bytes force:** these choices are what reproduce the original's code.
  - `Pred(x)` and `Succ(Succ(x))` where TP3 would otherwise emit `sub` and `add`;
  - an unused local in `MapAndCheck`;
  - the INT 67h vector as an integer pair overlaid by an `absolute` pointer, because TP3 has no
    pointer constants.

## Tools

- [tools/build.py](tools/build.py): the build and the comparison.
- [tools/mkturbo.py](tools/mkturbo.py), [tools/rt302.tsv](tools/rt302.tsv),
  [tools/compiler.tsv](tools/compiler.tsv): the patched compiler and runtime.
- [tools/tp3c.sh](tools/tp3c.sh): compiles a `.PAS` with the TURBO.COM in the current directory
  (the keystroke recipe).
- [tools/emscmp.py](tools/emscmp.py): compares a stock-3.02A build's program part with
  EMSTEST.COM's, allowing for the 14-byte runtime shift. The source was recovered with it.
- [tools/outline.py](tools/outline.py), [tools/outline2.py](tools/outline2.py): EMSTEST.COM
  disassembled between two addresses, with inline strings and routine names.
- [tools/PROBE.PAS](tools/PROBE.PAS): maps runtime addresses to TP3 built-ins.

# grep20: Borland C++ 2.0's GREP.COM, as source

Turbo GREP 3.0 searches files for lines that match a string or a regular expression. It
shipped with Borland C++ 2.0 (1991) as a 7,023-byte `.COM`, written in assembler.
[src/GREP.ASM](src/GREP.ASM) rebuilds it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/GREP.COM` of Borland C++ 2.0, 7,023 bytes, SHA-256 `a4c9faa6988bc6fd59abd367bfee501a4aad525549a77c2e534887d4bb0f0e43` |
| Source | one TASM file, 1,919 lines |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py --bc20`
([../docs/SETUP.md](../docs/SETUP.md)), then:

```sh
cd grep20
make check          # or: ../.venv/bin/python tools/build.py
```

It ends with `GREP.COM: byte-identical to the original (SHA-256 a4c9faa6...)`. The new file
is `build/out/GREP.COM`.

## How Borland built it

- **Assembler: TASM 2.51, one pass** (its default). Two forward jumps written without
  `short` carry the `nop` that a single pass leaves after a jump it later finds short;
  every other forward jump is written `short`.
- **Linker: TLINK `/t`**, straight to a `.COM` from `org 100h`.
- No C and no library: GREP.COM has no startup code and calls DOS directly.

## What the code shows

- **One buffer, laid over the start-up text.** The search buffer runs from `buffer` to the
  end of memory, over the help text and the messages that only the command line needs.
  The `[ ]` sets of a pattern are stored at the start of the buffer, 32 bytes each.
- **The anchor.** A pattern with a literal character is searched for through its rarest
  literal (the `rarity` table) with `repne scasb`, and the rest of the pattern is tried on
  each side of it; other patterns are tried at every position.
- **`-u` rewrites the program.** It stores the options in `defopts`, finds GREP.COM's path
  in the environment (DOS 3 and later) or asks for a name, and writes the program from
  100h to `progend`. That includes the 80-byte path buffer after the end of the original
  file, so an updated GREP.COM is 7,103 bytes.
- **The stack** is the 512 bytes after the code, filled with FFh in the file; the recursive
  matcher checks it (`stackchk`).
- **Found in the code, kept as it is:**
  - `putnum` divides a 32-bit line number by 10 with a 16-bit `div`: with `-n`, a line
    number of 655,360 or more overflows the division.
  - 14 bytes in `compile` are never reached.
  - The help text says "preceeded".
  - These come from reading the code; they have not been run.
- **Never used:** the `$*$*$*` ID block, as MAKE, TLIB and OBJXREF have.

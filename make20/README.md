# make20: Borland C++ 2.0's MAKE.EXE, as source

MAKE 3.5 is Borland's program maintainer: it reads a makefile of targets, dependencies,
implicit rules, macros and `!if` directives, and runs the commands that bring the targets up
to date. It shipped with Borland C++ 2.0 (1991) as a 41,174-byte `.EXE`. The files in
[src](src) rebuild it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/MAKE.EXE` of Borland C++ 2.0, 41,174 bytes, SHA-256 `cdcc73cc5ec3cbfd4db81e7c331dcb8311411f5518f39eb7a17a35ae0d1ca1f4` |
| Source | 12 C files and one assembler file; three library modules in [../interim-rtl](../interim-rtl) |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 and Turbo C++ 1.01 with `scripts/setup-toolchains.py` (`--bc20` and
`--tc101`; [../docs/SETUP.md](../docs/SETUP.md)), then:

```sh
cd make20
make check          # or: ../.venv/bin/python tools/build.py
```

It ends with `MAKE.EXE: byte-identical to the original (SHA-256 cdcc73cc...)`. The new file
is `build/link/out/MAKE.EXE`, with TLINK's map beside it. `tools/gate.sh` also matches and
verifies every source file against its part of the original with Exhume (`tools/match.py`,
`tools/verify.py`).

## The source

| File | What it does |
|---|---|
| [src/BUILD.C](src/BUILD.C) | deciding what is out of date and running its commands: `{ }` batches, `&&` in-line files, `.AUTODEPEND` checks of object files |
| [src/MAKEIN.C](src/MAKEIN.C) | reading the makefile a character at a time |
| [src/MAIN.C](src/MAIN.C) | `main()`, the macro table, and the lists of targets, extensions and rules |
| [src/PARSE.C](src/PARSE.C) | the makefile parser: rules, dependencies, commands, `!include`, `!if` and the other directives |
| [src/EXEC.C](src/EXEC.C) | running one command: the search for the program, COMMAND.COM for DOS's own commands, `<` and `>` |
| [src/MACRO.C](src/MACRO.C) | expanding `$(...)`, `$d(...)`, `$*`, `$<`, `$:`, `$.` and `$&` |
| [src/MSGS.C](src/MSGS.C) | the messages, a file of data only |
| [src/IFEXPR.C](src/IFEXPR.C) | the expressions of `!if` and `!elif` |
| [src/CONFIG.C](src/CONFIG.C) | the command line options, and `-W`, which writes them into MAKE.EXE |
| [src/ERRORS.C](src/ERRORS.C), [src/VMSG.C](src/VMSG.C) | fatal errors, errors and messages, with MAKE's own small `printf` |
| [src/SPAWN.C](src/SPAWN.C), [src/SWAP.ASM](src/SWAP.ASM) | `-S`: writing MAKE out to a swap file while a command runs |
| [src/include/MAKE.H](src/include/MAKE.H) | what the files share: targets, rules, macros, options and messages |

The files are in link order, which is the order of their code in MAKE.EXE. MAKE.EXE keeps
no symbols, so every name is descriptive; the assertions name two files of the original,
`makein.c` and `config.c`.

## How Borland built it

The evidence is the bytes of MAKE.EXE. [tools/build.py](tools/build.py) repeats each step.

- **Compiler: Borland C++ 2.0's BCC**, compact model, `-O -Z -d -a -y` (VMSG.C without
  `-a`). `-y` writes line numbers into the object files and changes the code too: a jump
  that carries line information (a `goto`, `break`, `continue` or the jump over an `else`)
  is never merged with another or threaded through, which is what many of the original's
  jumps show. `-a` shows in the padding before switch tables and between the fields and
  arrays of the data.
- **Assembler: TASM**, for SWAP.ASM: a stub that DOS runs the command from while MAKE's
  image is in the swap file, copied below MAKE at run time, so it addresses its own data
  from offset 0.
- **Startup code: the interim C0C**, Borland C++ 2.0's `C0.ASM` with Turbo C++ 1.01's
  banner, as for TOUCH and TLIB ([../scripts/interim_rtl.py](../scripts/interim_rtl.py)).
- **Library: the interim library**: Borland C++ 2.0's `CC.LIB` in that library's order,
  with PUTC, OPEN and VPRINTER from Turbo C++ 1.01's, and FFLUSH, FNSPLIT and SEARCHP
  rebuilt from C ([../interim-rtl](../interim-rtl)). FNSPLIT, Borland C++ 2.0's FNMERGE and
  the swap code come before the rest of the library in MAKE.EXE, so they are linked as
  objects.
- **Linker: TLINK** 3.0 or 4.0, `/c /m` (Turbo C++ 1.01's and Borland C++ 2.0's give the
  same file; Turbo C 2.01's TLINK 2.0 writes another EXE header).

## What the code shows

- **Where each file's variables are.** Borland C++ 2.0 lays out a file's uninitialised
  variables in order of a hash of the name, and the names were chosen to fall in the
  original's order. MAIN.C also sets the stack size, `_stklen = 0x2400`.
- **Spellings kept for their code** are marked `match:` in the source. Most are `(void)N`
  statements: they keep two pieces of identical code apart, as the original has them, and
  each N differs because two identical markers would match each other. None changes what
  MAKE does.
- **Bugs in the original, kept as they are:**
  - `.IGNORE` in a makefile turns on what `-n` does (print the commands, run nothing), not
    what `-i` does: PARSE.C sets `noexec`.
  - In `$(name )`, a space before the `)` makes `getmacro()` in MACRO.C loop for ever: its
    loop that drops trailing spaces never moves its pointer.
  - A target such as `dir\name` with no extension gets the extension `ir\name`:
    `definefile()` in MAIN.C points at the name itself where it should point before it.
  - After the first `$(name:old=new)`, every macro expanded later has the same replacement
    made in it: MACRO.C sets `subst` and never clears it.
  - A makefile whose last line is a comment after blanks, with no newline at the end, makes
    `nextch()` in MAKEIN.C loop for ever: that comment loop does not stop at the end of the
    file, where the one for a comment at the start of a line does.
  - `-W` on a file without MAKE's signature never ends: `findsig()` in CONFIG.C compares
    `read()`'s result with 1 where -1 was meant, and goes on reading nothing at the end.
  - MAKE's own `printf` (VMSG.C) prints nothing for 0 with `%d` or `%x`.
  - These come from reading the code; they have not been run.
- **Not known:** what reads the 22 bytes `$*$*$*` ... `Turbo Make` at the start of MAIN.C's
  data, and `_heaplen`, which the compact model does not use.

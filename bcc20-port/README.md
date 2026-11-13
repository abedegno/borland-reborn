# bcc20-port: Borland C++ 2.0's compiler as a native tool

A port of BCC.EXE, Borland C++ 2.0's command-line compiler, to modern hosts, for decompiling
and preserving early-1990s DOS games built with Borland C++. Matching a game's code byte for
byte means compiling candidate C again and again with the exact compiler that built it. The
aim is a compiler that writes exactly the object files and listings BCC.EXE writes, and that:

- compiles in-process, as a library call (source in, object bytes out), so a tool such as a
  permuter can try thousands of variants;
- explains its choices where a matcher needs them: which register the allocator took and
  what ruled out the others, which tails cross-jumping merged, what the peephole pass
  removed;
- runs natively, without a DOS emulator.

It is translated from the byte-matched source in [../bcc20](../bcc20/README.md), which stays
as it is and remains the reference. [../bcc20/docs/PORT.md](../bcc20/docs/PORT.md) lists
what that source assumes about DOS and the 8086, with counts.

**Status:** the checking machinery and the first six run-time functions. Nothing compiles
yet.

## How a translation is checked

Two checks, both against Borland's own BCC.EXE:

1. **Function by function.** The tracing emu2 (Exhume's `tools/emu2-trace`, built by
   `sh ../exhume/tools/setup-emu2-trace.sh`) records calls of chosen functions while BCC.EXE
   compiles the test corpus: for each call, the registers at entry and at return, every byte
   the call read before writing it with the value it had, and every byte it left written.
   `build/replay` runs the translated function from the same state and compares: the
   registers it returns in, and every byte of memory. A byte it reads that the original never
   read holds poison, which shows up as a difference; a call that does not return within two
   seconds fails. Calls are recorded by where their code came from in BCC.EXE, so overlay
   functions are found wherever they load.
2. **Output for output.** The corpus of `../bcc20/tools/modtest.py`, 1,832 compiles, run
   natively and compared with what BCC.EXE writes in emu2: every file, the exit code and the
   console text. (To come: it needs a port that compiles.)

The function-by-function check needs the port to keep BCC's memory exactly as the DOS
program laid it out. That is the first stage's machine model
([include/port.h](include/port.h)): one array for the 8086's address space, far pointers as
32-bit segment:offset values, BCC's data at its own offsets. Later stages replace it with
host data structures under the corpus check alone.

## Use

Needs the Borland C++ 2.0 toolchain installed for `../bcc20` (docs/SETUP.md at the
repository root), the tracing emu2, Python 3 and a C compiler.

```sh
make                                            # build/replay
python3 tools/record.py COMPARE_NAME --runs 300 # records/COMPARE_NAME.rec, from 300 compiles
build/replay COMPARE_NAME records/COMPARE_NAME.rec
make check                                      # every translated function against its records
```

`tools/record.py --emu2 PATH` picks the tracing emu2 (default: `../exhume/tools/emu2-trace/emu2`
or `$EMU2_TRACE_BIN`). Records hold memory of Borland's program, so `records/` is never
committed; make them again from your own BCC.EXE.

## Layout

| Path | What it holds |
|---|---|
| `include/port.h` | the machine model: the address space, far pointers, byte and word access |
| `include/rtl.h` | the run-time library functions translated so far |
| `src/rtl/` | translations of `../bcc20/src/rtl/`, one file per original file, lower-case names |
| `replay/replay.c` | the harness: reads records, runs a function, compares |
| `replay/functions.c` | how the harness calls each function: where its arguments are, which registers it returns in |
| `tools/record.py` | records calls over the corpus |

Each translated file starts with a comment naming the original file and anything the
translation keeps on purpose (an original bug the output depends on, for example).

## Translating a function

1. Read the original in `../bcc20/src`, its comments and its assembly where it has any.
2. Write the C in the matching file under `src/`, with fixed-size types (`u8`, `i16`,
   `u32`...), far pointers as `farptr` and memory through `B()`, `W()` and `D()`. Far
   pointer arithmetic changes only the offset: use `fp_add`.
3. Add an entry to `replay/functions.c`: for a far pascal function the return address takes
   4 bytes at SP and the arguments follow with the last one first; `outs` names the
   registers it returns in (AX, or DX:AX for a long or a far pointer).
4. `python3 tools/record.py NAME`, then `make check`.

Prove the check can fail: a wrong translation should be caught. On the first function, a
loop that missed the terminator hung (caught by the time limit) and a sign error failed 383
of 500 calls.

## Plan

1. **Checking machinery** (done): the call recorder, the replay harness, six run-time
   functions.
2. **Translate what `-c` on plain C reaches first**: the rest of the run-time library the
   compiler uses, then the lexer and input, preprocessor, parser, expressions, code
   generator and object writer, each function checked against its recorded calls. Coverage
   decides the order (`../bcc20/docs/COVERAGE.md`).
3. **First native compile**: a driver with host file I/O, no overlays, memory banks or
   interrupt handlers; `HELLO.C` with `-c` writes the same `T.OBJ` as BCC.EXE. Then `-S`,
   then the whole corpus.
4. **The compiler work written in TASM**: the 80-bit real arithmetic (`../bcc20/src/float/`)
   and the inline assembler (`INLINASM.ASM`), in C.
5. **The library interface**: compile from memory to memory, with state reset between
   compiles; then explanation output; then a permuter in Exhume that uses them.
6. **Restructure**: host data structures in place of the 8086 memory model, under the corpus
   check.

A game is matched only with the exact compiler that built it. This port gives Borland C++
2.0; Turbo C++ 1.0 and Borland C++ 3.x very likely share much of its code generator, so it
is the base for recovering those too, which is unproven.

## Licence

The translations (`src/` and the headers declaring them, such as `include/rtl.h`) derive
from Borland's copyrighted BCC.EXE (now Embarcadero), like `../bcc20`: no rights are claimed
in them. The machine model, the harness and the tools (`include/port.h`, `replay/`,
`tools/`, the Makefile) are project material under the MIT licence. See
[../NOTICE.md](../NOTICE.md).

# How the port is checked

Two checks, both against Borland's own BCC.EXE running in the tracing emu2 (Exhume's
`tools/emu2-trace`, built by `sh ../exhume/tools/setup-emu2-trace.sh`):

Where BCC.EXE is not available (CI, a fresh clone), `python3 tools/golden.py check` compares
the native build and the library with BCC.EXE's stored outputs for the 118 corpus cases that
need no Borland header (`tests/golden/`, made locally by `tools/golden.py make`).

1. **Function by function** (`make check`). Every translated function is replayed against
   calls recorded from BCC.EXE; 1629 functions, every recorded call matching.
2. **Output for output** (`tools/nativetest.py`). Every compile step of the corpus runs in
   BCC.EXE and in the native build; the object or assembly files, the exit status and the
   console text must be the same (1874 of 1880 steps; the other six are
   [accepted known differences](NATIVE.md#known-differences)).

## Recording and replaying calls

`tools/record.py` runs BCC.EXE over the corpus with the recorder on. For each call of a
chosen function it keeps the registers at entry and at return, every byte the call read
before writing it (with the value it had) and every byte it left written. Calls are found
by where their code came from in BCC.EXE, so overlay functions are recorded wherever they
load.

`build/replay` runs the translation from the same state and compares the registers it
returns and every byte of memory. A byte the translation reads that the original never read
holds poison, which shows up as a difference; a call that does not return within two
seconds fails.

A translated function may call one that is not translated (or that the native build
replaces, such as the heap or a DOS call). The recording carries the calls the original
made to such functions inside each call, in order; when the translation makes one, the next
recorded call must go to the same function with the same arguments, from the same memory,
and the original's writes and result are applied. So the check does not have to go from the
leaves up.

What makes the comparison exact:

- a call through a pointer (a callback, a hook table) is resolved through a table of every
  resident function and every overlay stub entry;
- a local whose address the original passes on lives in a scratch area, and replay maps the
  original's stack address onto it; a pointer to a local stored inside memory a callee
  reads (an argument block) is mapped the same way;
- the overlay manager's own work (loading an overlay) is not recorded as calls, but what it
  writes is kept and applied at the next stand-in call;
- DOS's memory, the callers' frames and a call's own frame are left out of the comparison;
- a call that never returns (a long jump unwinds it, or the program exits inside it) is
  recorded up to its last child, the jump or the exit (NORETURN), and replay compares
  memory at that point; so whole compiles are checked call by call too.

Values the original leaves unset (stack garbage passed on, a register returned without being
set) are marked in the translation (`UNSET_ARGS`, `UNSET_BYTES`, `UNSET_RESULT`,
`UNSET_RETURN`, `include/port.h`) and skipped by the comparison.

## Recording everything

```sh
python3 tools/record.py --all --max 200       # every translated function, one pass (~15 min, 12 cores)
make check > build/check.txt                  # lists the functions with no recorded call
python3 tools/record.py NAME ... --max 200    # those, each on its own
make check > build/check.txt
python3 tools/inject.py NAME ... --variants 120   # those BCC.EXE never calls: made calls
make check
```

A run follows recorded calls 32 deep; a call deeper than that leaves the calls around it
unrecorded, which is why the functions reached only that deep are recorded on their own.
Records hold memory of Borland's program, so `records/` is never committed: make them from
your own BCC.EXE. `--emu2 PATH` picks the tracing emu2 (default
`../exhume/tools/emu2-trace/emu2`, or `$EMU2_TRACE_BIN`).

### Functions BCC.EXE never calls

`tools/coverage.py` reports which functions BCC.EXE runs at all over the corpus. For those it
never runs, `tools/inject.py` makes the calls itself: BCC.EXE compiles a corpus test, and at
the entry of a function in the same code segment (or anywhere, for a far function with an
entry point, called through it) the tracer pushes arguments in the target's calling
convention and calls it (`EMU2_RECORD_INJECT`). The arguments are the trigger's own (live
nodes, symbols and types), small constants and random words. Calls BCC.EXE does not finish
sanely are left out, as there is nothing to compare: one cut short with no long jump or exit
to end it, one that ran 0000:0000 (a null pointer), one whose stack went below BCC's own
limit (8F0Ch). One real port difference turned up this way and was fixed: addresses past 1 MB
wrap, as on the 8086.

## The corpus

The corpus is `../bcc20`'s (`tools/modtest.py`: the bcc20 sources themselves, Borland's
example programs and class library, GCC and cfront test suites) plus the port's own tests
in `tests/`, which reach paths the corpus does not: precompiled headers, the memory and
linker options, response and configuration files, `__emit__`, dynamic dispatch numbers,
based pointers and others. A test names its switches and steps in its first lines, as
modtest's do (`/* modtest: -ml -H */`, `/* modes: -c -c */`); the modes of a step run in
order in one directory, so a second compile can load what the first saved. A test `NAME.C`
with a `NAME.CFG` beside it gets that file as `TURBOC.CFG`.

## A game's own build

`tools/gametest.py GAME/BUILD/MAKEFILE` takes a decompiled game's Borland MAKE makefile and
runs every C compile it lists in BCC.EXE and in the native build, each in a copy of the
game's tree standing for drive C:, and compares the objects and console text. The game's
sources stay in your own clone.

Ultima 7 ([Kitrinx/Ultima7_Decomp](https://github.com/Kitrinx/Ultima7_Decomp), built with
Borland C++ 2.0) was the first: all 922 C compiles of its eight programs (Black Gate and
Serpent Isle) are the same. On the way it found three port bugs the corpus had not reached,
each now covered by a port test:

- the native heap moved the malloc pool, which BCC fixes, so a long `-I` list in a
  configuration file lost its directories (`tests/IPATH.C`);
- four accesses read a pool's segment before a call that can move the pool, which C allows
  and BCC.EXE never does; `MACRO_DEFINED` lost include guards that way (`tests/MACGROW.C`;
  `tools/segorder.py`, run by `make check`, finds the shape);
- the native build passed host descriptors to BCC as DOS handles, and left directories of
  finished searches open; handles are now numbered as DOS numbers them.

It also showed what the port needed to build a game's tree as it stands: `BCC_ROOT`
([NATIVE.md](NATIVE.md#environment-switches)) for absolute paths and `..\` out of the build
directory.

## Looking into a failing call

- `REPLAY_ONLY=N build/replay NAME records/NAME.rec` replays only call N.
- `REPLAY_TRACE=1` prints each stand-in call the translation makes beside the one BCC.EXE
  made.
- `REPLAY_WATCH=ADDR` (linear, hex) prints that byte before each stand-in call, which
  brackets the translated code that changed it.
- `record.py NAMES --only TEST --out DIR --per-run 100000 --max 100000` records one corpus
  test with every call kept.
- `make check` also runs `tools/aliascheck.py`, which finds calls written with a stub's or
  a body label's name instead of the definition's.

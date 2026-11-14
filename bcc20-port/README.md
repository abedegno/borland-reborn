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

**Status:** the checking machinery, the shared definitions, the run-time library's string
functions, the record pools, the lexer (input stack, token streams, token reader, comments,
string literals, the scanner), the preprocessor (directives, pragmas, the macro table,
conditional compilation, the #if evaluators), types and symbols (the identifier table, type
records, sizes and compatibility, struct layout, the C symbol table) and all the expression
files of `../bcc20/src/expr` (the C++ analyser and its checkers, conversions, call checking,
inline expansion, the simplifier, constant folding, lowering for the back end, and the C
front end's expression parser and node builders), and most of the parser (`../bcc20/src/parser`:
all of it: both front ends' declarations, declarators, statements and expressions,
initializers, function definitions, look-ahead and inline asm statements), and most of the
C++ front end (`../bcc20/src/cpp`: member pointers, inline bodies, access checks,
initializers, casts, constructor bodies, C++ expressions and their checks, overloading,
special and implicit members, name mangling, class bodies and definitions, function
declarations, calls, base conversions, constructors and destructors, end-of-file work and
virtual tables, the type and scope tables), and the first part of the code generator
(`../bcc20/src/codegen`: code ops and the variable table, conversions, bit fields, storage
queries, the back-end driver, the byte pool, initialised data, the instruction emitter,
register variables, calls, operators, statement blocks, switches, intrinsics, the
peephole, cross-jump and jump optimisers, frames, register allocation, expression code and
the code passes), the object and assembly writers (`../bcc20/src/output`), the driver
(options, configuration, the link and TASM steps, start-up of the front ends), the inline
assembler's C side (operands, symbol encoding, the instruction encoder), precompiled headers,
the diagnostics (message printing, through `include/variadic.h`, and type spelling), the
80-bit real arithmetic of `../bcc20/src/float` (the assembly modules, in C) and more of the
run-time library: 1457 functions checked, each matching every call recorded over the whole
corpus (at most 200 different calls a function). A few are never reached by the corpus and are not checked
yet (`make check` lists them). Nothing compiles yet.

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

   A translated function may call functions that are not translated yet. Those are
   **stand-ins** (generated from `include/protos.h`), and the recording carries the calls the
   original made to them inside each recorded call, in order. When the translation calls a
   stand-in, the next recorded call must be to the same function with the same arguments,
   made from the same memory; then the original's writes are applied and its result
   returned. So translation does not have to go from the leaves up: the heap, the overlay
   manager and the DOS calls can stay untranslated while everything above them is checked.

   What makes this exact:
   - a function called through a pointer (a callback, a hook table) is found through the
     code-address table: every resident function and every overlay stub entry;
   - a local whose address the original passes on lives in a scratch area of the address
     space, and replay maps the original's stack address onto it;
   - the overlay manager's own work (loading an overlay when one calls into another) is not
     recorded as calls, but what it writes is kept and applied at the next call to a
     stand-in, so its effect on the heap is reproduced;
   - DOS's own memory, the callers' stack frames and a call's own frame are left out of the
     comparisons: none of them are the translation's business.
2. **Output for output.** The corpus of `../bcc20/tools/modtest.py`, 1,836 compiles, run
   natively and compared with what BCC.EXE writes in emu2: every file, the exit code and the
   console text. (To come: it needs a port that compiles.)

The function-by-function check needs the port to keep BCC's memory exactly as the DOS
program laid it out. That is the first stage's machine model
([include/port.h](include/port.h)): one array for the 8086's address space, far pointers as
32-bit segment:offset values, BCC's data at its own offsets. Later stages replace it with
host data structures under the corpus check alone.

## Use

Needs the Borland C++ 2.0 toolchain installed for `../bcc20` (docs/SETUP.md at the
repository root), the tracing emu2 with nested call recording (Exhume's
`tools/setup-emu2-trace.sh`), Python 3 and a C compiler.

```sh
make                                            # build/replay
python3 tools/record.py COMPARE_NAME --runs 300 # records/COMPARE_NAME.rec, from 300 compiles
build/replay COMPARE_NAME records/COMPARE_NAME.rec
make check                                      # every translated function against its records
```

`tools/record.py --emu2 PATH` picks the tracing emu2 (default: `../exhume/tools/emu2-trace/emu2`
or `$EMU2_TRACE_BIN`). Records hold memory of Borland's program, so `records/` is never
committed; make them again from your own BCC.EXE.

`--all` records every translated function in one pass over the corpus (about five minutes
with 12 cores). A run follows recorded calls 32 deep; a call deeper than that leaves the
calls around it unrecorded, so a function reached only that deep gets no calls from `--all`
and must be recorded on its own. `--runs N` samples N compiles, which can miss the functions
only the targeted tests reach.

To look into one failing call: `REPLAY_ONLY=N build/replay NAME records/NAME.rec` replays
only the recorded call N, and `REPLAY_TRACE=1` prints each call the translation makes to a
function not yet translated, beside the one BCC.EXE made. `REPLAY_WATCH=ADDR` (a linear hex
address) prints that byte before each such call, which brackets the translated code that
changed it. To record one corpus test on its own, with every call kept, use `record.py NAMES
--only TEST --out DIR --per-run 100000 --max 100000`. `make check` also runs
`tools/aliascheck.py`, which finds calls written with a stub's or body label's name instead
of the definition's.

## Layout

| Path | What it holds |
|---|---|
| `include/port.h` | the machine model: the address space, far pointers, byte and word access |
| `include/data.h`, `globals.h` | BCC's global data at its DGROUP offsets: `NAME`, `NAME_AT(i)`, `NAME_P` (globals.h is generated from DATA.H; data.h holds the items sources declare for themselves) |
| `include/pool.h` | the record pool accessors (`TYPE_W(r, TYPE_KIND)`...), generated from POOL.H |
| `include/fields.h`, `msg.h`, `token.h`, `kind.h`, `exprop.h` | the original's constants, copied |
| `include/protos.h` | every function of the original in the port's types, generated from the original definitions (and the TASM functions' extern declarations); `variadic.h` the few with variable arguments |
| `src/rtl/` | translations of `../bcc20/src/rtl/`, one file per original file, lower-case names |
| `replay/replay.c` | the harness: reads records, runs a function, compares |
| `replay/functions.c` | hand-written adapters and stand-ins: variadic functions, and functions that pass values in other registers |
| `tools/record.py` | records calls over the corpus (`--all`: every translated function) |
| `tools/genadapters.py` | generates include/protos.h, and build/adapters.c: an adapter for each translated function and a stand-in for each other one, with the original's calling convention |
| `tools/genheaders.py` | regenerates the copied headers, pool.h and globals.h |
| `tools/ready.py` | the work queue: untranslated functions whose callees all have prototypes, smallest first |
| `tools/check.sh` | `make check`: every translated function against its records |
| `src/rtl/scratch.c` | port material: the scratch area for address-taken locals, and the code-address lookup |

Each translated file starts with a comment naming the original file and anything the
translation keeps on purpose (an original bug the output depends on, for example).

## Translating a function

1. Pick a function from `python3 tools/ready.py` (its callees are translated or have
   prototypes, so its recorded calls can be replayed).
2. Read the original in `../bcc20/src`, its comments and its assembly where it has any.
3. Write the C in the matching file under `src/`, with fixed-size types (`u8`, `i16`,
   `u32`...), far pointers as `farptr` and memory through `B()`, `W()` and `D()`; globals
   by name (`globals.h`), records through `pool.h` and the field constants. Far pointer
   arithmetic changes only the offset: use `fp_add`. Far pointers compare by offset with
   `<` and `>`, as in Borland C. Pseudo-registers become locals.
   - A store into a pool record whose value comes from a call that may allocate must put
     the value in a variable first: the call can move the pool, and C does not say whether
     the record's address is formed before or after it (Turbo C forms it after).
   - Calls through BCC's code pointers use `CALL_FAR` / `CALL_NEAR` (`calls.h`), never a C
     function pointer cast.
   - A local whose address is passed on lives in the scratch area (`scratch_alloc`). When
     several are passed, keep the original frame's layout among them (read it from the
     pointer arguments of a recorded child): the replay maps a window around each pointer,
     so a stand-in that reads a neighbouring local finds it where BCC.EXE had it.
   - A function that takes a structure by value is listed in genadapters'
     `STRUCT_ARGUMENTS`: the port passes the structure as its words in the order a pascal
     call pushes them, its last word first (MAKE_MEMBER_NODE(member, word3, line, file)).
   - What the original reads from the 8086 flags (`_FLAGS`, or a TASM helper that reports
     in OF) is computed: a signed overflow test, or a port global the helper's
     translation sets (`include/overflow.h`). Shift counts are taken modulo 32, as the
     80186 does (and emu2).
   - An argument the original passes from a local it never set cannot be reproduced: pass
     0 and say so with `UNSET_ARGS(mask)` just before the call of the stand-in (bit 0 the
     first argument), so the replay skips it; list the place below. A scratch local the
     original never sets before a stand-in reads it gets `UNSET_BYTES(p, n)` instead, and
     memory a translated callee fills with such a value `UNSET_RESULT(p, n)`. A register
     the original returns without having set it gets `UNSET_RETURN(mask)` in the function
     that returns it (bit 0 AX, bit 3 DX); the replay skips it for that function only.
   - Where several arguments of one call are themselves calls, put them in variables in
     Turbo C's order: left to right for a pascal function, right to left for cdecl. C
     leaves the order open, and the replay checks the order of the calls.
4. Its prototype is already in `include/protos.h`, generated from the original; keep the
   original's argument order and types. The adapter is generated too; a function that passes
   a value in another register gets a hand-written one in `replay/functions.c` instead. The
   original's static functions are external in the port, so they can be checked.
5. `python3 tools/record.py NAME`, then `build/replay NAME records/NAME.rec`, and at the end
   `make check`.

A function the corpus never calls cannot be checked. Some code is reached only in a mode the
corpus never gives it: CALLCHK.C runs only for C++ (EXPRPARS.C checks a C call's arguments
itself), so its C branches, C5ARG among them, are translated but unchecked. If nothing calls it at all (search
`../bcc20/src`), leave it out and say so in the file's comment, as `src/rtl/rscat.c` does for
STRING_APPEND_N.

Prove the check can fail: a wrong translation should be caught. On the first function, a
loop that missed the terminator hung (caught by the time limit) and a sign error failed 383
of 500 calls.

## Decisions for the native build

Places where the original's behaviour depends on something a port does not have:

- **NEXT_POOL_CHARACTER** (LEXER.C) reads its `quote` register uninitialised unless `reset`
  is 0: it holds whatever the caller left in that register, which depends on the caller's
  register allocation. It affects escapes and quotes in macro-produced string text (a
  stringized argument, `__FILE__` with backslashes). It stays a stand-in until the native
  build decides: keep `quote` across calls (most likely what the original meant), or work
  out what each caller leaves there.
- **FIND_NAMED_FUNCTION** (CPRAGFN.C) tests whether a #pragma startup or exit function
  takes parameters, but on the path where the test fails it returns the symbol anyway (what
  is left in AX), so the test changes nothing. The port reproduces that; a fix would refuse
  such functions.
- **LOWER_EXPR_TREE** (LOWEREXP.C), **ANALYZE_EXPRESSION** (EXPRDISP.C), **FOLD_EXPRESSION**
  (CONSTFLD.C), **SUBSTITUTE_PARAMETERS** (INLINEXP.C), **SIMPLIFY_NODE** (SIMPLIFY.C),
  **STEVALN** (EXPRPARS.C) and **PARSE_DECLARATOR_TREE** (CDECLR.C) stop with "out of memory" when the 8086 stack pointer drops below
  8F0Ch, which only a very deeply nested expression reaches. The port has no such stack and
  leaves the check out; the native build could limit the nesting depth instead, if it wants
  the same error.
- **PARSE_INLINE_STATEMENT** (INLINEXP.C) returns an unset register (the caller's SI) for a
  stray "else" or a token that cannot start a statement in an inline body. The port returns
  0; the native build should do the same, or report the error and stop expanding.
- **PARSE_STATEMENT_C** (STMTC.C) passes an unset local (the line where a for loop's test
  ends) to NEW_BRANCH_BLOCK when the test starts on the line of the loop's initialisation,
  as in `for (i = 0; i < n; i++)`. The value is whatever an earlier call left in that stack
  slot. The port passes 0 and tells the replay not to compare it (`UNSET_ARGS`, port.h). The
  native build must find out whether the value reaches the output (a debug line number?)
  and, if it does, what the original's stack held there.
- **DECLARE_VARIABLE** (EXTDECL.C) redeclaring a far array without an initializer in C++
  passes an unset local (prepared) to the segment hook when automatic far data did not set
  it. The port passes 0.
- **DECLARE_FUNCTION** (EXTDECL.C) leaves its `changed` flag unset when it passes it to
  MERGE_FUNCTION_DECLARATION, and in C++ BCC_TYPE_MATCH may read it before setting it. The
  port marks the byte unset for the replay (`UNSET_BYTES`, port.h); the native build must
  check what BCC_TYPE_MATCH does with it.
- **BCC_STMT_PARSE_NEXT** (CDECL.C) passes its `linkage` local unset to DECLARE_SYMBOL for a
  typedef, which keeps it as the symbol's segment word (PCH.C's typedefs end up with 1
  there in BCC.EXE), and **PARSE_DECLARATOR** (DECLSPEC.C) lets TYPE_PATH read its unset
  `retain` flag as the fourth byte after the modifier triple. The port passes 0 and marks
  them for the replay (`UNSET_ARGS`, `UNSET_RESULT`); the native build should confirm that
  neither value is used. A far pointer the original leaves pointing at a dead local (as
  CURRENT_LOOP_CONTEXT after an error in a loop) is accepted by the replay when the port's
  points into the scratch area.
- **GENERATE_BITFIELD_STORE** and **GENERATE_BITFIELD_INC_DEC** (BITFIELD.C) return a
  result whose low word was never set when the caller does not keep the value (whatever the
  stack held there). The port returns 0 and marks AX unset for the replay (`UNSET_RETURN`,
  port.h); callers that pass keep 0 discard the result, so the native build can return 0.
- **PARSE_EXPRESSION_PREC** (OPPREC.C) reads its paren and bracket counts unset in its error
  recovery when the expression did not start with an expression token (`if ()`), so
  whether it steps over a closing parenthesis there depends on an earlier call's stack. The
  port uses 0 (never steps over); the native build should do the same.
- **The "Available memory" line** BCC prints is computed from its heap. The native heap must
  report the same figure, or the console text of every compile differs.

## Plan

1. **Checking machinery** (done): the call recorder, the replay harness, generated adapters,
   globals and headers, the work queue, and the run-time library's string and character
   functions.
2. **Translate what `-c` on plain C reaches**: the lexer and input, preprocessor, parser,
   expressions, code generator and object writer, each function checked against its
   recorded calls, with stand-ins for what is not translated yet. The heap, overlay manager
   and DOS calls stay stand-ins in this stage.
3. **A native heap and platform layer**: a simple heap that gives pools the same behaviour
   (a pool that grows, its handle word rewritten), host file I/O, no overlays. These are
   checked by the corpus as a whole, not call by call: their segment values need not match.
4. **First native compile**: a driver with host file I/O, no overlays, memory banks or
   interrupt handlers; `HELLO.C` with `-c` writes the same `T.OBJ` as BCC.EXE. Then `-S`,
   then the whole corpus.
5. **The compiler work written in TASM**: the 80-bit real arithmetic (`../bcc20/src/float/`)
   and the inline assembler (`INLINASM.ASM`), in C.
6. **The library interface**: compile from memory to memory, with state reset between
   compiles; then explanation output; then a permuter in Exhume that uses them.
7. **Restructure**: host data structures in place of the 8086 memory model, under the corpus
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

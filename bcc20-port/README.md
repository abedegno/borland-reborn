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
run-time library: 1588 functions checked, each matching every call recorded over the whole
corpus (at most 200 different calls a function), and the inline assembler's engine
(`INLINASM.ASM`) in C, matching every recorded statement.

`make check` lists the translated functions that have no recorded call (41), and
`tools/coverage.py` shows that BCC.EXE itself never runs any of them over the corpus: every
function BCC.EXE runs is checked. Many are unreachable from BCC 2.0's driver: the C++ front
end's C mode (BUILD_MEMBER_ACCESS, TYPE_CHECK2, BCC_TYPE_FINISH, C5ARG, C10PROMOTE ...) runs
only for a C++ compile with option bit 0 clear, which every route to the C++ front end sets;
HANDLE_NEGATED_FLAG_OPTION is in no option table and PCH_PUSH_BACK_DIRECTIVE_NOW in no
directive table. Others hang off paths or table entries no input selects: APPLY_BASED_POINTER, APPLY_BASED_POINTER_C, ASM_COLON_LABEL_STUB, ASM_FLUSH_KIND2_STUB, BCC_NODE_CONVERT, BCC_NODE_ERROR, BCC_STRING_CONCAT_NEAR, BCC_TYPE_FINISH, BUILD_MEMBER_ACCESS, C0FINAL, C0RELINK, C10DEFAULTS, C10PROMOTE, C13SPECIAL, C51_EMIT_PATH_CALLBACK, C5ARG, CONTEXT_DIAGNOSTIC, COPY_VECTOR_ELEMENTS, EMIT_COMM_DECLARATION, EMIT_DB_LINE, EMIT_HELPER_CALL_FOR_NODE, EMIT_INSN_NODE_REG, EXPAND_POST_INC_DEC, FIND_BASE_SYMBOL, FLUSH_PENDING_POOL, FOLD_SUB_UNSIGNED, HANDLE_NEGATED_FLAG_OPTION, HIGH_BIT_INDEX, IS_BASED_NEAR_PTR, IS_STRING_LITERAL_STORAGE, LINE_HOOK, MAKE_ADDRESS_OF_TYPED, NO_REAL_FOLD, PARSE_IDENTIFIER, PCH_PUSH_BACK_DIRECTIVE_NOW, REQUIRED_TYPE_TEXT, SET_PREPARED_SYMBOL_FLAGS, STBIN10, STORAGE_IDENTITY, TREE_HAS_SIDE_EFFECTS_ALT, TYPE_CHECK2.

The native build (`make native`, `build/bcc`) compiles: with the heap, overlay manager and
DOS services replaced by `native/`, 1868 of the corpus's 1874 compile steps (`-c`, `-S`,
precompiled headers written and loaded, links, BCC alone) give the same object or assembly
file, exit status and messages as BCC.EXE (`tools/nativetest.py`).
The other 6 are listed under "Decisions for the native build".

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
     comparisons: none of them are the translation's business;
   - a call that never returns (a long jump unwinds it, or the program exits inside it) is
     recorded up to that point (NORETURN): its last recorded child is the jump or the exit,
     and replay stops the translation there and compares memory;
   - so whole compiles are checked call by call too: RMAIN13C, COMPILE_ONE_FILE and the
     front ends' entries match every recorded call.

   One recorded call is wrong rather than the translation: PARSE_CV_QUALIFIERS' call 92 in
   the current records runs 12 instructions, makes a BIOS call (the function makes none)
   and "returns" to segment 0, the recorder having credited the function with other code.
2. **Output for output.** The corpus of `../bcc20/tools/modtest.py` and `tests/`, run
   natively and compared with what BCC.EXE writes in emu2: every file, the exit code and the
   console text (`tools/nativetest.py`).

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

`--all` records every translated function in one pass over the corpus (about fifteen
minutes with 12 cores). A run follows recorded calls 32 deep; a call deeper than that
leaves the calls around it unrecorded, so a function reached only that deep gets no calls
from `--all` and must be recorded on its own: after `--all`, record the functions
`make check` lists as not reached in a second pass (`record.py NAME ...`). `--runs N` samples N compiles, which can miss the functions
only the targeted tests reach.

The native build is self-contained: BCC's initial data (DGROUP), the inline assembler's
tables and the message texts are compiled in (`native/image.c`, generated from BCC.EXE by
`tools/genimage.py`), and BCC.EXE is not needed to run it. It runs like BCC.EXE in a DOS
directory: the drive's root is the current directory, names are cut to 8.3 when the host
has no file under the full name, and the command line is cut to DOS's 126 characters.

```sh
make native                                     # build/bcc
build/bcc -c -IC:\\INCLUDE HELLO.C               # as BCC.EXE would, writes hello.obj
python3 tools/nativetest.py [--only TEST]       # build/bcc against BCC.EXE over the corpus
```

The library (`make lib`: `build/libbcc20.a`, `include/bcc20.h`) runs one BCC command line
in-process from memory to memory: the source and any headers come from the job, every file
BCC writes comes back in the result, with the console text, and each call starts BCC afresh
(the whole memory image reloaded), so compiles never share state. Other files are read from
the job's root directory; the host is never written. `build/bcc20run` drives it from the
command line, and `tools/nativetest.py --lib` runs the corpus through it, each compile twice
in one process (1865 of the 1871 compile steps identical to BCC.EXE, link steps left out).

```c
bcc20_file source = {"T.C", text, length};
const char *args[] = {"-c", "-ml", "-O", "-IC:\\INCLUDE", "T.C"};
bcc20_job job = {5, args, &source, 1, "/path/to/BC20", 0, 1};
bcc20_result result;
bcc20_compile(&job, &result);     /* result.outputs[0]: T.OBJ */
bcc20_free(&result);
```

The compiler can explain its choices (`include/explain.h`): the job's `explain` callback,
or `BCC_EXPLAIN=1` on the command line (stderr), gets one line per event, read from BCC's
memory without changing it (`nativetest.py --lib` runs the whole corpus with it on):

```
function name=sum
regvar_candidate var=i score=12 reg=si
regvar var=i reg=si score=12
regvar var=total reg=di score=11
reg op=17 preferred=bx,si,di allowed=ax,dx,bx,cx,si,di,bp,sp,es,ds,cs,ss free=dx,bx,cx narrowed_to=bx,si,di chose=bx
spill op=40 pushed_value=31
crossjump merged=3 ops left_block=12 right_block=20 tail_block=44
peephole removed_load op=52 value_in=ax
```

A register pick shows the registers the value's users preferred, those its class allows,
those free at that point, the set the allocator then chose from and the register it took
(the lowest-numbered of that set): what ruled the others out. Register variables show
every candidate's score for each free register in turn.

`BCC_TRACE=1` shows each file the native build opens or looks for; `BCC_SCRATCH_FILL=n`
fills every new translated local with byte n, which finds code whose result depends on a
local the original never set. `BCC_DOS_RUNNER=emu2` runs the DOS programs BCC calls
(TLINK for a link, TASM for `-B`) in that emulator. `BCC_STACK_LIMIT=0` turns off the model
of BCC.EXE's stack, so a source nested too deeply for BCC.EXE ("Out of memory") compiles.

The corpus is `../bcc20`'s (tools/modtest.py) and the port's own tests in `tests/`, which
reach paths the corpus does not (precompiled headers, the memory and linker options, a
response file, `__emit__`, Borland's dynamic dispatch numbers ...). A test names its
switches and steps in its first lines as modtest's do (`/* modtest: -ml -H */`, `/* modes:
-c -c */`); the modes of a step run in order in one directory, so the second compile of a
precompiled header test loads what the first saved.

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
| `native/` | the native build's platform layer: start-up in place of `../bcc20/src/driver/C0.ASM` and DOS (loading the data image, the PSP, argc/argv, the BSS), DOS file and directory services on the host, and a heap with the pools' behaviour in place of the DOS heap and overlay manager |
| `tests/` | the port's own tests, for paths the corpus does not reach (see "Use") |
| `tools/nativetest.py` | the native build against BCC.EXE over the corpus |
| `native/image.c`, `native/stack_table.c` | generated data: the parts of BCC.EXE's image the translations read (`tools/genimage.py`) and BCC.EXE's stack as measured over the corpus (`tools/genstack.py`) |
| `include/bcc20.h`, `native/lib.c`, `tools/bcc20run.c` | the library interface: one compile in-process, memory to memory |
| `include/explain.h`, `native/explain.c` | the compiler explaining its choices (register variables and registers, spills, cross-jumps, removed loads) |
| `tools/coverage.py` | which of the unchecked functions BCC.EXE runs at all over the corpus |

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

- **NEXT_POOL_CHARACTER** (LEXER.C) reads its `quote` register (DI) uninitialised unless
  `reset` is 0. Every caller reads a literal with `NEXT_LITERAL_CHAR(index++)`, the index in
  DI, so it is then `reset + 1`, as every recorded call shows; the port starts from that.
  (So `__FILE__`'s doubled backslashes stay doubled, as in BCC.EXE.)
- **PARSE_ARRAY_DECLARATOR** (DECLSPEC.C) keeps an unset count when the bound is not a
  constant: BCC.EXE's stack garbage. The port uses 2, which gives BCC.EXE's follow-on
  messages over the corpus except in `mangle10.C` (two compiles), where the slot held a
  huge value.
- **FIND_NAMED_FUNCTION** (CPRAGFN.C) tests whether a #pragma startup or exit function
  takes parameters, but on the path where the test fails it returns the symbol anyway (what
  is left in AX), so the test changes nothing. The port reproduces that; a fix would refuse
  such functions.
- **The stack checks**: LOWER_EXPR_TREE (LOWEREXP.C), ANALYZE_EXPRESSION (EXPRDISP.C),
  FOLD_EXPRESSION (CONSTFLD.C), SUBSTITUTE_PARAMETERS (INLINEXP.C), SIMPLIFY_NODE
  (SIMPLIFY.C), STEVALN (EXPRPARS.C), PARSE_DECLARATOR_TREE (CDECLR.C) and
  GENERATE_EXPRESSION (CGEXPR.C) stop with "Out of memory" when the 8086 SP is below 8F0Ch,
  which a deeply nested source reaches. A matcher must not accept a candidate BCC.EXE
  cannot compile, so the native build models BCC.EXE's stack (`native/stack.c`): each call
  between translated functions lowers a virtual SP by the drop BCC.EXE showed for that
  caller and callee (measured over the corpus, `tools/record.py --sp`, generated into
  `native/stack_table.c` by `tools/genstack.py`), from the SP BCC.EXE's start-up code
  enters the compiler with (which depends on the command line), and STACK_CHECK compares
  it at each check. `BCC_STACK_LIMIT=0` turns the checks off.
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
- **The "Available memory" line** BCC prints is computed from its heap; the native heap's
  figure differs (`tools/nativetest.py` leaves the line out).
- **Error cascades** in two cfront sources (`sin.C`, `sqrt.C`, four compiles) lose one
  follow-on message, "Left side must be a structure". After an earlier error a member
  access is left with no left operand (node 0), and CHECK_DOT_MEMBER (EXPRCHK.C) analyses
  node 0: the first bytes of the expression pool, which no record ever uses. In BCC.EXE
  they hold 0100h, memory left there before the pool's block was allocated and carried
  along each time the heap moved the block, so node 0 looks like an expression of a type
  that is not a structure. The native heap's blocks start zeroed, node 0 reads as no
  expression, and the message is not given. (Every call of the translated functions over
  these compiles matches its recording.)
- **Names longer than 8.3**: DOS cuts them; emu2, which runs the reference BCC.EXE for the
  checks, does not cut a name it opens and does not find such a name with find first. The
  native build follows DOS, or emu2 with `BCC_EMU2_FIND` set (which `tools/nativetest.py`
  sets).
- **DOS programs** (TASM, TLINK) cannot run natively. With `BCC_DOS_RUNNER` naming a DOS
  emulator (emu2) the native build runs them there and passes on the exit code
  (`tools/nativetest.py` sets it, so a link runs Borland's TLINK in both); without it EXEC
  fails as for a missing file.
- **PARSE_RECORD_SPECIFIER** (DECLSPEC.C) saves the 44-byte parse state around a nested
  class definition when its nesting count was already set, and restores it whenever the
  count is still set afterwards. A malformed inner definition returns without lowering the
  count, so an outer definition can restore a buffer it never saved: BCC.EXE's stack
  garbage. The port then leaves the state as it is (marked unset for the replay).
- **A macro called with too few arguments** (COLLECT_MACRO_ARGUMENTS, LEXER.C) is reported
  and expanded anyway, and the missing argument is read past the end of what was written to
  POOL_A: memory this compile never wrote, whose contents come from BCC.EXE's DOS heap
  (a run of "Illegal character" errors follows). The native heap's memory differs there.

## Plan

1. **Checking machinery** (done): the call recorder, the replay harness, generated adapters,
   globals and headers, the work queue, and the run-time library's string and character
   functions.
2. **Translate what `-c` on plain C reaches** (done): the lexer and input, preprocessor, parser,
   expressions, code generator and object writer, each function checked against its
   recorded calls, with stand-ins for what is not translated yet. The heap, overlay manager
   and DOS calls stay stand-ins in this stage.
3. **A native heap and platform layer** (done, `native/`): a simple heap that gives pools the same behaviour
   (a pool that grows, its handle word rewritten), host file I/O, no overlays. These are
   checked by the corpus as a whole, not call by call: their segment values need not match.
4. **First native compile** (done: 1823 of 1837 corpus compiles): a driver with host file I/O, no overlays, memory banks or
   interrupt handlers; `HELLO.C` with `-c` writes the same `T.OBJ` as BCC.EXE. Then `-S`,
   then the whole corpus.
5. **The compiler work written in TASM** (done): the 80-bit real arithmetic (`../bcc20/src/float/`)
   and the inline assembler (`INLINASM.ASM`), in C.
6. **The library interface**: compile from memory to memory, with state reset between
   compiles (done: `include/bcc20.h`); then explanation output (done:
   `include/explain.h`); then a permuter in Exhume that uses them.
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

# The native build

`make native` builds `build/bcc`, which behaves like BCC.EXE run in a DOS directory:

```sh
build/bcc -c -ml -O -IC:\\INCLUDE HELLO.C     # writes hello.obj, as BCC.EXE would
```

It is self-contained. BCC's initial data (DGROUP), the inline assembler's tables and the
message texts are compiled in (`native/image.c`, generated from BCC.EXE by
`tools/genimage.py`); a corpus run with the rest of the image overwritten shows nothing
else is read. BCC's code is not needed: all of it is translated.

## The platform layer (`native/`)

- **Start-up** (`native.c`) does what DOS and C0.ASM do: places the image, builds the PSP,
  the environment and argc/argv (the command line cut to DOS's 126 characters), clears the
  BSS and calls the driver. BCC's exit comes back to the caller, so the same code serves the
  library.
- **Files**: DOS handles are numbered as DOS numbers them (the lowest free one from 5),
  each standing for a host descriptor; BCC never sees the host's numbers. Drive C:'s root is
  the current directory, or `BCC_ROOT` (below); a name is cut to 8.3 when the host has no
  file under the full name. Find first and next read host directories.
- **Heap** (`heap.c`): one bank of conventional memory, no EMS, extended memory or swap
  files, no overlays; pools grow and move as BCC expects (their handle words rewritten).
  The malloc pool is fixed, as BCC fixes it (FIX_HEAP_NODE_LOW): its items point at one
  another, so when it grows the blocks after it move instead.
- **Stack model** (`stack.c`): see below.
- **DOS programs** (TASM, TLINK) cannot run natively. With `BCC_DOS_RUNNER=emu2` they run in
  that emulator and their exit code comes back; without it the exec fails as for a missing
  file, and BCC reports so.

## Environment switches

| Variable | Effect |
|---|---|
| `BCC_TRACE=1` | print every file the native build opens or looks for |
| `BCC_EXPLAIN=1` | print the compiler's explanation of its choices ([LIBRARY.md](LIBRARY.md#explain-output)) |
| `BCC_STACK_LIMIT=0` | no model of BCC.EXE's stack: a source nested too deeply for BCC.EXE compiles |
| `BCC_DOS_RUNNER=emu2` | run TLINK and TASM in that DOS emulator |
| `BCC_ROOT=DIR` | DIR stands for drive C:'s root, and the current directory is the DOS one under it: a makefile's `C:\BORLANDC\INCLUDE` or a `..\` out of the build directory work as in DOS, and TASM run through emu2 sees the same drive |
| `BCC_SCRATCH_FILL=n` | fill each new translated local with byte n (finds results that depend on unset locals) |
| `BCC_EMU2_FIND=1` | find and open names longer than 8.3 as emu2 does (the reference for the checks) |

## The stack model

Eight recursive functions of BCC (the expression analyser, simplifier, constant folder,
lowering, inline expansion, the C expression and declarator parsers and the code generator)
stop with "Out of memory" when the 8086 SP drops below 8F0Ch. A matcher must not accept a
candidate BCC.EXE cannot compile, so the native build models BCC.EXE's stack: the
translations are compiled with `-finstrument-functions`, each call between translated
functions lowers a virtual SP by the drop BCC.EXE showed for that caller and callee
(measured over the corpus with `tools/record.py --sp`, generated into `native/stack_table.c`
by `tools/genstack.py`), starting from the SP BCC.EXE's start-up code enters the compiler
with (it depends on the command line), and each check compares it with 8F0Ch. Long jumps
restore the shadow stack. The deeply nested torture tests of the corpus stop exactly where
BCC.EXE does.

## Decisions

Places where BCC's behaviour depends on something the port does not have, and what the port
does:

- **Unset values that do not reach the output.** NEXT_POOL_CHARACTER's `quote` register (it
  is always `reset + 1` in practice), the line passed by PARSE_STATEMENT_C for a `for` test,
  DECLARE_VARIABLE's prepared flag for a C++ far array, DECLARE_FUNCTION's `changed` flag,
  BCC_STMT_PARSE_NEXT's typedef linkage, PARSE_DECLARATOR's `retain` flag,
  GENERATE_BITFIELD_STORE's and GENERATE_BITFIELD_INC_DEC's discarded result,
  PARSE_INLINE_STATEMENT's result for a stray `else`, PARSE_EXPRESSION_PREC's counts in its
  error recovery: the port uses 0 (marked unset for the replay). No corpus output depends on
  them.
- **FIND_NAMED_FUNCTION** (CPRAGFN.C) tests whether a `#pragma startup` function takes
  parameters, then returns the symbol either way; the port does the same.
- **PARSE_ARRAY_DECLARATOR** (DECLSPEC.C) keeps an unset count when the bound is not a
  constant (an error): the port uses 2.
- **PARSE_RECORD_SPECIFIER** (DECLSPEC.C) can restore a parse-state block it never saved
  after a malformed nested class: the port leaves the state as it is.
- **The "Available memory" line** comes from the heap and differs; the corpus comparison
  leaves it out.
- **Names longer than 8.3**: DOS cuts them, emu2 does not; the native build follows DOS, or
  emu2 with `BCC_EMU2_FIND`.

## Known differences

Accepted on 2026-11-14. Six of the corpus's 1880 compile steps differ, all in compiles that
fail in both, and only in their follow-on error messages, because BCC.EXE reads bytes it
never set whose contents come from its DOS memory history. No compile that succeeds
differs, so matching is not affected.

- `mangle10.C` (2 steps): the unset array count above held a huge value in BCC.EXE.
- cfront's `sin.C` and `sqrt.C` (4 steps): after an earlier error a member access has no
  left operand, and CHECK_DOT_MEMBER analyses node 0, the first bytes of the expression pool.
  In BCC.EXE they hold leftover memory carried along each time the heap moved the block, so
  one more message ("Left side must be a structure") appears.

Found by the Ultima 7 test (CHECKING.md): BCC.EXE loses or hangs on a long `-I` list (in our
tests from 13 directories of 9 characters in one option). Its malloc pool is fixed at the low end
of the heap and can grow only while nothing else fixed lies above it; when it cannot, the
directory nodes already made are lost or BCC loops in its out-of-memory handling. Ultima 7's
makefiles give one directory a line for that reason. The port's heap always grows the pool,
so the port compiles what BCC.EXE fails on; for a list BCC.EXE accepts the two agree.

A macro called with too few arguments is the same kind of case: BCC.EXE expands the missing
argument from pool memory the compile never wrote. The port's tests avoid it.

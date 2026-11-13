# Porting BCC.EXE to modern hosts

The port is a tool for decompiling and preserving early-1990s DOS games built with Borland
C++. Matching a game's code byte for byte means compiling candidate C again and again with
the exact compiler that built it. A native Borland C++ 2.0 that writes exactly the object
files BCC.EXE writes makes that faster: a library call instead of a DOS emulator, so a tool
can compile thousands of variants. Being source, it can also explain its choices (which
register the allocator took, which tails cross-jumping merged, what the peephole pass
removed), which is what a matcher most needs when the bytes differ.

The port is its own tree, [../../bcc20-port](../../bcc20-port/README.md), free to change
anything. This tree stays as it is: it rebuilds BCC.EXE byte for byte and is the reference.
The port is judged by what it writes (the test corpus) and, function by function, by calls
recorded in Borland's BCC.EXE (bcc20-port/README.md).

This page lists what the recovered source assumes about DOS and the 8086, which a
translation has to deal with, with counts measured on the tree. The counts come from simple
searches of `src/` (the commands are at the end), so treat them as sizes, not exact totals.

## Starting point

- The tree rebuilds BCC.EXE byte for byte (the exact link), and the modding build links
  changed sources of any size (docs/MODDING.md).
- The test corpus: 1,832 compiles from 919 files. The modding build's output must equal
  that of Borland's BCC.EXE running in emu2: the files written, the exit code and the
  console text. It runs 83% of BCC.EXE's code (docs/COVERAGE.md).
- A compiler is a good program to port. Everything it reads and writes is a file plus a
  command line, so the same corpus can judge a native build, with no screens or sessions to
  record.

## What the source still assumes

### 1. Every record is a far pointer into a 64 KB pool

BCC keeps its symbols, types, expression nodes, code nodes and names in far memory pools.
Each pool is one segment, held in a variable such as `TYPE_POOL` or `EXPR_POOL_SEG`. A
record is a 16-bit offset in that segment. This is the core data model of the whole
compiler.

- Field access goes through the accessor macros of `include/POOL.H`, such as
  `TYPE_W(type, TYPE_KIND)`. They are used about 7,800 times, and each one expands to
  `*(unsigned int far *)MK_FP(segment, record + offset)`.
- Besides those, `MK_FP` appears directly about 1,100 times in C files, mostly through the
  `ES_x` form below.
- No C file does arithmetic on a segment value (no `segment + n`). That matters: the
  segment can become a handle in a port.

**For the port:** the first stage keeps the records as 16-bit offsets in their segments and
the whole 8086 address space as one array (bcc20-port/include/port.h), so a translated
function can be run from a state recorded in BCC.EXE. The second stage can turn each pool
into a host block, or records into structures; with no segment arithmetic, the segment is
only ever a handle.

### 2. Register pseudo-variables

Much of the C is written with Borland's register pseudo-variables. There are about 3,400
uses in 93 files, most of them in the code generator (22 files), the heap (26), the
run-time library (12), expressions (6) and output (6):

| Name | Uses |
|---|---|
| `_SI` | 1,285 |
| `_ES` | 1,202 |
| `_BX` | 911 |
| `_DI` | 620 |
| `_AX` | 438 |
| others | about 250 |

Most of them work as ordinary local variables (`_BX=node; count=ES_W(_BX,...)`). The hard
cases are values that pass through a register between functions:
- a segment left in ES by a callee and read through `ES_W` (1,478 uses of `ES_x`);
- functions that return a register value by falling off the end (allowed when matching:
  see the fall-off-end policy);
- arguments passed in registers to the TASM modules.

**For the port:** a translation writes the pseudo-variables as ordinary locals. A value
that passes between functions in a register becomes a real parameter or return value, and
the recorded calls show which registers each function really returns in. A scan for
functions that read a pseudo-variable before writing it, or after a call, gives the size of
that work in advance.

### 3. 16-bit `int`

`int` is 16 bits and `long` is 32 throughout, and `unsigned int` alone appears on about
8,300 lines. On a host, `int` is 32 bits, so sizes, overflow, shifts, sign extension and
the promotion of `unsigned` values all change. A compiler cannot afford that: its constant
folding, sizes and offsets must wrap exactly as BCC's did, or the object files differ.

**For the port:** the translation uses fixed-size types (`u16`, `i16`, `u32`, `i32`). On a
host, a 16-bit value is still promoted to a 32-bit `int` in arithmetic, so expressions whose
result is used before being stored back into a 16-bit variable (comparisons, divisions,
right shifts, array indexes) need a cast where the 8086 would have wrapped. The recorded
calls catch the cases they reach; the compiler's warnings (`-Wconversion`, `-Wsign-compare`)
and UBSan find others.

### 4. The data segment is still bytes

No recovered C source defines data. All 2,071 named items of the data segment are in
`src/data/DGROUP.ASM`, written as bytes with names at their offsets, and the C code reaches
them through declarations in `include/DATA.H`. It holds:
- 1,063 near pointers to data, written as the items they point at;
- 185 near pointers into code, kept as numbers tagged with their function;
- far pointers written as the functions or data they point at.

Some tables are reached from another item's address, for example the pseudo-register names
`_AX`..`_ES` (a base plus four times an index) and `MIRROR_COMPARE_TABLE` (read as
`INVERT_COMPARE_TABLE` plus 0Ch). docs/MODDING.md, "Limits", lists the known ones.

**For the port:** turn DGROUP.ASM into C definitions with real types: the keyword tables,
the opcode descriptors, the message table, the option table and so on. On a host a pointer
is 8 bytes, so any table holding pointers changes size, and every place that steps through
a table by a byte count (`base + 4 * index`) has to become an array index. This can be
partly generated, from DATA.H's types and the pointer tables. The first stage needs none of
this: the data stays at its offsets in the address space, loaded from the program's own
data segment.

### 5. Platform code

These files do the DOS and hardware work. The port replaces the few it needs (files, the
command line, the environment) with host code and drops the rest: a tool that compiles to
object files needs no expanded memory, overlays, interrupt handlers or precompiled headers.

- **Start-up:** `driver/C0.ASM` (Turbo C start-up).
- **DOS calls** (INT 21h, interrupt vectors, files, dates, exec): in `rtl/` RCHMOD, RCLOSE,
  RCREAT, RDATE, RDOSAH, RDOSPTR, REXEC, RFFIND, RLSEEK, ROPEN, RREAD, RWRITE, RVECGET,
  RVECSET, RVECT, SETTOP and DVPRINTF; also `driver/DRVLINK.C` and `driver/RMAIN13C.C`.
- **Interrupt handlers** (Ctrl-C, critical error and similar): RMAIN13C, RHINIT, REXEC,
  RIRQ1B, RVECT, RVECGET and RVECSET. (The `interrupt` keyword in the parser and code
  generator is BCC compiling interrupt functions, not platform code.)
- **Memory banks:** the heap keeps records in conventional memory (bank 0), EMS (3),
  extended memory (4) or a swap file (1 and 2): `heap/EMSBANK.C`, `EXTBANK.C`,
  `HPDOSIO.ASM`, `HPDOSCLS.C`, `HPDOSDEL.C` and `RHINIT.C`. 24 heap files use inline
  assembly. A port needs only bank 0, backed by host memory.
- **Overlays:** `overlay/OVRMGR.ASM`, `OVRLOAD.ASM` and `OVREXMEM.ASM` (Borland's VROOMM
  manager). A port has no overlays: the 144 overlaid modules link as ordinary code. A
  function address stored as data points at an overlay stub, which in the port is just the
  function.
- **Running other programs:** the driver runs TASM and TLINK (`RDRV388.C`, `RTL_EXEC`),
  shrinking its memory first. A port has to run them too, either in an emulator or as
  native ports later.
- **Run-time library helpers in TASM:** long multiply, divide and shifts, block copy and
  fill, the stack check, `ltoa` (RAHELP, RCOPY, RDIV, RLMUL, RLSHL, RLSHR, RLTOA, RMSET0,
  RSHAR, RSTACK, ULDIV10). On a host the C compiler does these itself.
- **The rest of the run-time library** is Turbo C 2.01's (29 modules marked `compiler:
  TC201`). Host libc can replace most of it, but not where the output depends on the
  exact behaviour: number formatting in assembly listings, and `strcmp`'s sign (FINDINGS).

### 6. Code that is part of the compiler but written in TASM

These modules are not platform code. They do compiler work, so the port needs a C version of
each, written in the port's own files. The DOS build keeps the TASM, which is how Borland
wrote it.
- **`inlasm/INLINASM.ASM`** (4,229 lines, 8,119 bytes): BCC's built-in assembler for `asm`
  statements: the operand parser, an expression evaluator, instruction encoding, and the
  opcode and register tables. This is the biggest single job of the port.
- **`float/`** (16 modules, about 2,000 lines): 80-bit real arithmetic used for floating
  constants: unpacking, arithmetic, comparison, rounding to `float` and `double`, conversion
  to and from integers, powers of ten and `strtod`. A host's `long double` is not the 8087
  format on most machines (on ARM it is 64 or 128 bits), so the port needs a software 80-bit
  real that rounds exactly as these routines do. Otherwise floating constants in the object
  files differ.

### 7. Formats that hold host details

- **Precompiled headers (`TCDEF.SYM`, `-H`)** hold near addresses of BCC's own data and
  bytes that were never written (FINDINGS). A port cannot read files the DOS compiler wrote,
  or write files it can read. The port's own format only has to round-trip, and the
  corpus already compares these files by size.
- **Object files** are written byte by byte, so host byte order does not matter if the
  writer keeps doing that. Any place that writes a whole `int` or structure with `write`
  must be found (step 1 of the plan adds a scan of the `RTL_WRITE` calls).

### 8. Odd behaviour the port must decide on

From docs/FINDINGS.md. For each one, the port either copies the behaviour (and the corpus
expects it) or fixes it (and the corpus's expected output needs an exception).
- A bitfield post-increment through a far pointer stops with "Register allocation failure".
  This can be copied, since the corpus has a test for it.
- Enumeration constants fail in C++ inline assembly. Can be copied.
- Output that depends on BCC's own memory layout (two g++ tests, probably memory that was
  never set up). The port cannot copy this; those two files stay out of the corpus.
- `strrchr` reads before an empty string. Fix it.
- The `-#` switch can never be used. Copy it (it is an error).
- Uninitialised pad bytes in `TCDEF.SYM`. The port's format writes zeros.

## Plan and checks

[bcc20-port/README.md](../../bcc20-port/README.md) has the plan, the order of translation and
how each step is checked: calls recorded in Borland's BCC.EXE replayed against each
translated function, then the whole corpus of 1,832 compiles compared output for output.
The corpus runs 83% of BCC.EXE's code, and the recorded calls the same 83%; code no test
reaches needs new tests before its translation can be trusted (docs/COVERAGE.md lists it).

## How the counts were measured

Run from `src/`, over `*.C` and `*.H` unless noted:

```
grep -rhoE '\b(EXPR|TYPE|SYM|NAME|MEMBER|SCOPE|FAR|AT|CNODE|CONS|TSEG|LINK|PARAM|SYM2|STMT|CSYM|FORMAL|BASE|TAG|MINIT|TDTOR|P[0-9A-F]{4})_(B|W|L|I|SC|UL)\(' --include='*.C' . | wc -l
grep -rhoE 'MK_FP' --include='*.C' . | wc -l
grep -rhoE '\bES_[A-Z]+\(' --include='*.C' . | wc -l
grep -rhoE '\b_(AX|BX|CX|DX|SI|DI|ES|DS|SS|SP|BP|AH|AL|BH|BL|CH|CL|DH|DL|FLAGS)\b' --include='*.C' . | sort | uniq -c
grep -rlE 'int\s+21h|geninterrupt|int\s+0?(33|67|2f|15|23|24)h' --include='*.ASM' --include='*.C' .
grep -rnE '(SEG[A-Z_]*|FP_SEG\([^)]*\))\s*[-+]\s*(0x)?[0-9]' --include='*.C' .
```

# Porting BCC.EXE to modern hosts

The goal is a version of Borland C++ 2.0's command-line compiler that runs natively on
modern systems (Linux, macOS, Windows) and still writes the same DOS output: the same object
files, assembly listings and messages as BCC.EXE. This page lists what the recovered source
still assumes about DOS and the 8086, with counts measured on the tree as it is now. It ends
with a plan and the checks that keep the port honest. Nothing here has been changed yet.

The counts come from simple searches of `src/` (the commands are at the end), so treat them
as sizes, not exact totals.

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

**For the port:** keep the records as 16-bit offsets into 64 KB blocks, so record layouts,
sizes and the 64 KB limits stay as they are. Redefine `MK_FP(s, o)` in the port's own header
as `pool_base[s] + o`, where `s` is a pool handle. This is one header change, not a rewrite.

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

**For the port:** in the port's header, define the pseudo-variables as locals of each
function that uses them. Then find, with a new scan, every function that reads a
pseudo-variable before it writes it, or reads one after a call. Each of those is a value
passing between functions, and needs a real parameter or return value in the port. The scan
gives the size of the hand work before any of it starts.

### 3. 16-bit `int`

`int` is 16 bits and `long` is 32 throughout, and `unsigned int` alone appears on about
8,300 lines. On a host, `int` is 32 bits, so sizes, overflow, shifts, sign extension and
the promotion of `unsigned` values all change. A compiler cannot afford that: its constant
folding, sizes and offsets must wrap exactly as BCC's did, or the object files differ.

**For the port:** in the shared sources, write the integer types as typedefs (`int16`,
`uint16`, `int32`) that are `int`, `unsigned` and `long` in the DOS build. The gate proves
each such change keeps every byte. The port then defines them as `int16_t` and so on. A
second audit is still needed: on a host, a `uint16_t` value is promoted to a 32-bit `int` in
arithmetic, so expressions whose result is used before being stored back into a 16-bit
variable (comparisons, divisions, right shifts, array indexes) must be checked. The
compiler's warnings (`-Wconversion`, `-Wsign-compare`) and UBSan over the corpus find most
of them.

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
partly generated, from DATA.H's types and the pointer tables. The DOS build keeps
DGROUP.ASM until a C version of the data compiles to the same bytes.

### 5. Platform code

These files do the DOS and hardware work, and the port replaces them with host code. They
are the port's platform layer.

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

## Plan

One tree, two builds. The DOS build and the port compile the same C sources. Each change to
a shared source must still produce the original's bytes, and the gate proves it. Anything
that cannot be written that way goes in the port's own files. The exact link stays the
reference the whole time.

1. **Measure.** Write `tools/portscan.py`. It reports the counts on this page per file,
   and adds the two scans that need more than a search: pseudo-variables whose values pass
   between functions, and binary writes of whole integers or structures. It is rerun after
   each step, so progress can be tracked.
2. **Types.** Add the integer typedefs and the port's headers: the pool macros, `MK_FP`
   and the pseudo-variables as locals. Change only shared sources whose bytes stay the same.
3. **Values that pass between functions.** Fix each case the scan lists, in a way that keeps
   the DOS bytes, or else in a port-only version of that function.
4. **Platform layer.** Host versions of the DOS calls, memory (bank 0 only), no overlays, no
   interrupt handlers, and exec of TASM and TLINK through an emulator.
5. **Data.** Generate C for the data segment, starting with the tables the front end needs.
6. **Compiler work written in TASM.** The 80-bit real arithmetic in C first, since constant
   folding needs it and it is small. Then the inline assembler, with the corpus's asm tests
   (ASM.C, ASMCPP.CPP, ASMENUM.CPP) as its first checks.
7. **First compile.** The port compiles `tests/modbuild/HELLO.C` with `-c` and writes the
   same `T.OBJ` as BCC.EXE. Then `-S`, then the whole corpus.

## Checks that keep the port honest

- **The corpus is the test.** For every one of the 1,832 compiles, record what Borland's
  BCC.EXE writes in emu2 once (the files, the exit code and the console text) and keep it
  as the expected result. The port runs the same compiles natively and must match. This is
  the comparison `tools/modtest.py` already makes, with the port in place of the modding
  build.
- **The DOS build keeps matching.** The gate (`tools/gate.py check`) runs on every change to
  a shared source.
- **Host hazards.** DOS let BCC read past arrays, read through null pointers and write into
  string literals, with no crash. Build the port with AddressSanitizer and UBSan and run the
  corpus under them. Every overrun found is noted here, with whether the original read
  something that mattered.
- **Coverage.** The corpus runs 83% of BCC.EXE. A port bug in the other 17% will not show,
  so add tests for any code the port touches that the corpus never runs (docs/COVERAGE.md
  lists it).

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

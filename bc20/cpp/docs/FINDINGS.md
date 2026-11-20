# Findings: how CPP.EXE was built

These are facts recovered while matching CPP.EXE byte for byte, each tested as described.
Inferences say "probably". docs/FINDINGS.md.

## The binary

- **CPP.EXE:** 117,332 bytes, MZ header 0x1600 bytes, 1,338 relocations, entry 0000:0000,
  SS:SP 19AD:1800. Not overlaid: no FBOV block, no VROOMM stubs.
- **Code:** image 0x0..0x122A0. The modules sit in 66 code frames, a paragraph each, named by
  relocations. Frames are shared where several files share one code segment name: the heap,
  the start-up's CODE0 and the run-time groups.
- **DGROUP:** paragraph 122Ah. Initialised data runs to DS:5743 and _BSS to DS:782A. The stack
  is a separate STACK segment (19AD:0000, 0x1800 bytes) at the same address as DGROUP:7830.
  C0 moves SS:SP to DGROUP:9030h.
- **Far data:** two far segments follow the stack (1B2Dh and 1B41h): OVREXMEM's EMS and
  extended-memory data, with the "VDISK" descriptor table. The header asks for one more
  paragraph than the file holds (min alloc 1), so the last segment runs on past its
  initialised bytes.

## One source tree, two programs

CPP.EXE is built from the same source files as BCC.EXE, conditionally compiled.
- Where CPP keeps a function, the source is BCC's. It compiles to identical bytes once BCC's
  overlay switch `-Y` is dropped, so CPP.EXE was not overlaid.
- Functions CPP does not need are removed in place, and the rest keep BCC's order and
  statement shapes. Some empty switch cases and dead stores remain where code was cut away,
  for example RTL_STRUPR calls on segment-name variables that nothing sets any more.

**Removed:**
- C++ mode, typedef names, struct/union/enum specifiers and type canonicalisation
  (DECLSPEC, TYPESIZE, EXPRCHK, CONVERT, UNARYOP, OPPREC);
- the member, assignment, comma and pointer folds (SIMPLIFY);
- the code generator and object writer;
- precompiled headers;
- `#pragma startup/exit/option/...` (CPP copies `#pragma` lines through);
- the TASM and TLINK steps;
- the overlay manager;
- the swap-file heap bank;
- the C front end's hook table.

**Hooks became direct calls:** TOKEN_CONVERT became CODE_MASK, BEGIN_BACKEND_OUTPUT_HOOK
became BEGIN_BACKEND_PHASE, and FINISH_COMPILATION_HOOK became END_SESSION. CPP's start-up
exports a cdecl `exit` (0000:00B1), which every driver file calls where BCC calls a pascal
EXIT.

**Kept for `#if`:** the whole expression machinery. EVAL_CONSTANT_CONDITION parses with the
compiler's operator-precedence parser, analyses and simplifies the tree, and needs sizes, so
type sizes and basic types stay too.

**Added or changed for a preprocessor:**
- WRITE_PREPROCESSED_TOKENS (TOKADV.C) writes every token. It owns a 0x83-entry table of
  token spellings, and its literal pool needs `-d`.
- The lexer writes the output text itself: blanks through OUTPUT_CHAR, and the
  `file line: ` markers when OPTION_LINE_NUMBERS (-P) is on.
- SEGNAMES.C defines the predefined macros, builds the `.i` name and creates the output file.
- Option handlers for options a preprocessor ignores are `return 1`. The option block is
  0x8B bytes (BCC 0x90).
- The stack limit check in SIMPLIFY and EXPRDISP is 0x7AEC (BCC 0x8F0C).
- The heap has 5 banks of 40h-byte records, with 14h-byte descriptors from 140h. Bank 2 is
  EMS, 3 extended memory, 4 the null bank. There is no swap bank.

## Compilers and switches

- **Borland C++ 2.0**, `-mm -O -p` with register variables on, never `-Y`. `-G`/`-G-` and
  `-Z` vary per file, as in BCC. Proved by `proof/CFGPROOF.C`: with `-Y` or `-O-` it fails,
  and with `-r-` BCC_LINE_READ fails.
- **Turbo C 2.01:** most of the run-time library (the same objects as BCC.EXE's), CPP's own
  C45JUMP.C (setjmp/longjmp), and about half of the heap files.
  - Turbo C has no `_loadds`. Its files get the same prologue from `huge pascal`, or from
    inline `asm push ds; mov ax,DGROUP; mov ds,ax` where register variables are needed.
  - How to tell the compilers apart: Turbo C writes `sub sp,2` for a 2-byte frame (BC 2.0:
    `dec sp; dec sp`), leaves out the frame of empty or argument-less functions, and writes
    `or dx,ax` where BC writes `or ax,dx`.
- **TASM 2.51** (`/ml`): C0.ASM (a cut-down version of BCC's start-up), OVREXMEM.ASM, the
  float helpers and the long-arithmetic helpers.
- **Through TASM or not:** whether a C file went through TASM (`-B`, or `#pragma inline` for
  Turbo C) shows in the relocation table.
  - Objects written by the compiler list a module's fixups in descending order. TASM lists
    those with a target inside the module first, then those to externs and to
    forward-referenced procedures, each group ascending. TLINK keeps module order.
  - By that evidence ten files that BCC's reconstruction compiled through TASM were compiled
    directly in CPP.EXE: INITTYPE, TYPESIZE, DIAG, INITPOOL, SEGNAMES, CPPIFEXP, DRVLINK,
    CONVERT, EXPRDISP and DECLSPEC. The last three needed documented `(void)0;` barriers,
    because the direct backend merges identical code tails that the `-B` path keeps.
  - MEMINIT, OOMHAND and HPHSIZE (Turbo C) went through TASM.
- **TOKADV.C** dropped `-B` and gained `-d`. **CONFIG.C** and **CPPMAIN.C** need `-G-`. Most
  Turbo C heap files drop BCC's `-r-`.
- **Stand-ins:** a few Turbo C heap functions keep a value on the stack where a register is
  free. With `-r`, Turbo C 2.01 puts any `int` whose address is not taken into a free SI or
  DI, so these values are declared `volatile` or `short`; HANDLE_ITEM_POINTER uses a small
  struct. Each is documented in its file. The original source form there is unknown.

## Module boundaries

- **Code segments:** a medium-model C file gets its own code segment and frame. Files that
  share a frame share a segment name, given here with `-zC`:
  - CODE2: the heap and OVREXMEM;
  - CODE5: MEMINIT, POOLMARK, R5ALLOC, OOMHAND;
  - CODE9: LDISNAN with the float assembly;
  - CODE36: TOLOWER, RTOUPPER;

  The names themselves are not in the EXE.
- **The run-time library** modules (float helpers through RSCAT) were linked after every
  other module, as a library's would be. RFILEIO.C and POOLS.C were linked before them but
  lie after them, starting on a paragraph: they use a code class of their own (`-zAFCODE`).
- **The relocation table splits and joins files:**
  - FREE_OWNER_TAG belongs with HANDLE_BLOCK_SIZE and HANDLE_IN_BANK_5 in one Turbo C `-B`
    file (HPHSIZE.C).
  - TASSERT, TYPSTART, TCHECK, TCALL, STRLIT and CONSTVAL (six files in BCC's overlay 118)
    are one file in CPP (PARSEUTL.C).
  - The directive processor with the comment scanners is one file (PREPROC.C).
  - BCC's four diagnostic files are one file (DIAGFMT.C).
  - main, puts, usage and strupr are one file (CPPMAIN.C).
  - DPRINTF and DVPRINTF are one directly compiled Turbo C file (DVPRINTF.C).
- **Heap stubs:** each `push bp; mov bp,sp; pop bp; ret` in the heap frame is a one-function
  BC 2.0 stub file. It sits where BCC.EXE has a self-calling stub.
- **Data owners:** the relocation table lists each module's data relocations right after
  its code relocations. So DGROUP belongs to particular C files, in link order:
  - C0, TOKADV, INITTYPE, OPTIONS, SEGNAMES, PREPROC, SIMPLIFY and DRVLINK (in DGROUP);
  - OVREXMEM (the far data).

  TOKADV and PREPROC define their data in their sources. The rest is generated by
  `tools/gendata.py` into one assembly piece per owner, linked right after that owner.
  Moving those pieces into their C files is still to do.
- **Names for the link:**
  - about 25 functions that BCC's reconstruction had as `static` are called from other
    files, so they are public here;
  - the run-time helpers define both Turbo C and BC spellings (LXMUL@ and F_LXMUL@ ...);
  - overlay-stub names (*_BODY) are replaced by the names the callers use.

## The 2 bytes

The link is byte-identical to CPP.EXE. The last 2 bytes to close were the order of 2
relocation-table entries (#33-34, file offsets 0xC2 and 0xC6) in the heap code at frame 0054h.
They are now reached by one documented link step, `tools/fixorder.py`.

- **The target order:** CPP.EXE lists entries #33-#36 as 16A5h (SHRINK_HEAP_FULLY's far call
  to SHRINK_HEAP_TO, the call's segment word), then 167Bh, 169Ah and 16B3h. The last three are
  the DGROUP loads of GATHER_ALL_FREE_SPACE, SHRINK_HEAP_FULLY and SHRINK_HEAP_TO.
- **The source:** the three functions are one Turbo C 2.01 file compiled with `-B`
  (src/heap/HPSHRINK.C), and every byte matches. They must be one object, because TLINK keeps
  object order: with separate files, GATHER_ALL_FREE_SPACE's 167Bh would come before the far
  call. The two static entries were `_loadds` in BCC's source, which Turbo C 2.01 lacks, so the
  DS save and DGROUP load are inline asm. The call is wrapped in `asm NOSMART` so that TASM
  keeps the far call.
- **What TASM gives:** TASM 2.51 writes these fixups as 167Bh, 169Ah, 16B3h, 16A5h. TASM only
  puts a far call before such segment fixups when the call's target is already declared at
  the call. Here the target is a later function of the same file, and Turbo C writes all its
  extrns at the end of its `-B` output, so no source we can write gives CPP.EXE's order.
- **The link step:** `tools/fixorder.py`, run by `tools/link.py`, copies HPSHRINK's object
  with the subrecords of its one FIXUPP record in the order of `tools/fixorder.tsv`, which
  moves the far call's fixup to the front. It changes only that order: no subrecord byte, no
  target, no LEDATA or other record. The record checksum is a byte sum, so it stays valid.
  The step refuses if the object's fixups are not exactly the set in the table, and it
  touches no other object.
- **Ruled out:**
  - BC 2.0 and Turbo C 2.01 compiled directly both give fully descending order.
  - Through TASM (BC `-B`, Turbo C `-B`, hand-written modules), these tries all keep address
    order: the far call as an instruction, or as `db 9Ah` with a separate segment word;
    DGROUP, or `seg` of an extern variable; a forward local or extern callee; `GLOBAL` or
    `public` declared before the code; `/m2`; later uses of the variable in code, in a
    reopened segment or in data. Declaring the callee extrn and then defining it is an
    assembly error.
  - TASM 1.0, 2.0 and 2.51 give the same orders. TLINK 3.0 copies object order like 4.0.
    Turbo C++ 1.01 and BC's built-in assembler give descending order.
- **BCC.EXE** has the same order for the same functions. So this is how the original was
  built, not something peculiar to CPP.EXE. The original step that gave it is not known.

**DPRINTF/DVPRINTF.** The two were one Turbo C 2.01 file compiled
directly with -O (CPP.EXE's descending relocation run proves one object). `asm int 21h` is
written as `geninterrupt(0x21)`, and three documented `(void)` statements keep -O from
merging the identical `mov ah,2; int 21h; jmp` tails that CPP.EXE keeps apart.

## Map facts

- **Code:** 154 sources cover the whole code area. The only gaps are 2 zero alignment bytes
  before RFILEIO's paragraph and 8 before DGROUP.
- **Same as BCC:** 56 modules are BCC's sources unchanged apart from switches and link
  notes. All but a handful of CPP's functions exist in BCC.EXE.
- **New in CPP.EXE:**
  - WRITE_PREPROCESSED_TOKENS, PARSE_PRAGMA's copy-through and the lexer's output code;
  - C45JUMP (setjmp/longjmp);
  - two `return 1` option handlers;
  - two empty stubs;
  - CPP's C0.

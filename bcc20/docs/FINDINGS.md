# Findings

Things learnt about BCC.EXE while recovering and reading its source. Each item says how sure
it is: **confirmed** (a second witness: the data, a table, or the code path itself),
**likely** (clear from the code, not tested), **possible** (an inference). Items found by
the naming agents were checked against the code where marked.

## Likely bugs and odd behaviour (kept as they are: the source reproduces the original)
- **strrchr reads before the string** (confirmed, `RSTRCHR.C`): for an empty string it
  looks at `string[-1]`. Effect: harmless in practice; a port should not copy it.
- **strcmp returns a byte difference sign-extended with cbw** (confirmed, `RSCMP.C`): the
  sign is wrong when two characters differ by more than 127. Effect: name comparisons only
  use equality, so likely harmless.
- **A routine that calls itself forever** (likely): `CALL_SELF_FOREVER` (`RHAPI.C`) and the
  heap stubs `RH_SELF_CALL_*` (seven of them) and `CALL_SELF_FOREVER_RG2BEND` only call
  themselves; nothing calls them. Probably
  placeholders in Borland's source that the compiler kept.
- **Post-increment of a bitfield through a far pointer fails** (confirmed by running
  Borland's BCC.EXE, `tests/modbuild/BITFAIL.C`): `return f->count++;` for a bitfield of a
  structure reached through a pointer stops the compile with "Fatal: Register allocation
  failure" in the compact, large and huge models, with or without `-O`; post-decrement
  fails alike. Pre-increment, the small model, and a global structure compile. Effect: such
  code cannot be compiled; a port need not reproduce the failure.
- **Enumeration constants fail in C++ inline assembly** (confirmed by running Borland's
  BCC.EXE, `tests/modbuild/ASMENUM.CPP`): `asm mov cx, second`, where `second` is an
  enumerator, stops with "Improper use of a typedef symbol" in C++, while C takes it.
  `ENCODE_ASM_SYMBOL_ALT` (`ASMENC2.C`, the C++ twin of the asm name encoder) has a branch
  that writes an enumerator's value, which this error keeps from being reached. Effect:
  write the number instead; a port could fix it.
- **Precompiled header files hold uninitialised bytes** (confirmed, `MACROS.C`):
  MACRO_DEFINE rounds each macro definition up to an even size and never writes the pad
  byte, and `-H` writes the macro pool to `TCDEF.SYM` as it is in memory. So the file holds
  whatever that heap memory held before, which depends on the program's memory layout
  The file also holds near addresses of BCC's own data, so it only suits the compiler that
  wrote it (`tools/modtest.py` compares its size, and checks it by reading it back).
  Effect: harmless; the byte is never read.
- **The -# switch cannot be used** (confirmed by running BCC.EXE, `RARGV0F0.C`): it is read
  before the memory manager starts and sets the heap size in paragraphs, but the option
  parser then rejects it ("Incorrect command line option"). With a small value it goes
  wrong sooner: `-#60` printed an empty "Error:", and `-#1500` had not finished after ten
  minutes in emu2. Probably a leftover debugging switch.
- **Stubs that return 0** (likely): `ASM_FLUSH_KIND2_STUB`, `ASM_COLON_LABEL_STUB`, and
  `RETURN_MINUS_ONE_STUB` (-1).
- **A declaration that drops a return value** (confirmed, `LEXER.C`): `RTL_SCAN_LDOUBLE` is
  declared `void`, but the routine (RSTRTOD.ASM) returns the number of characters it consumed.
  Effect: none in BCC; a port should declare it properly.
- **Code nothing calls** (confirmed by search of src/ and linkgroups/): the three decimal
  wrappers in `RLTOA.ASM`; a preamble-directive handler in `PCH.C` that is not in
  `PREAMBLE_DIRECTIVE_TABLE`; nine pools set up by `INIT_CODEGEN_POOLS` and never used
  (`CODEGEN_UNUSED_POOL_ONE`..`NINE`).

## Duplicated code (confirmed: identical bodies)
- `STAOV198` (`ASMDATA.C`) and `BCC_FAR_06A5` (`OBJSEGS.C`).
- `GET_TYPE_FLAGS` and `GET_TYPE_FLAGS_ALT` (`TYPEREC.C`): both return the byte at
  record+8.
- `FIND_INIT_BY_MEMBER` and `FIND_INIT_BY_BASE` (`CPPCTOR.C`).
- `RESET_EXPR_POOL` (`EXPRMAKE.C`) and `RESET_EXPR_POOL_ALT` (`EXPRPOOL.C`).
- `ADD_JUMP_18_NEXT_FRAGMENT` (`ASMDATA.C`) and `ADD_JUMP_18_NEXT_FRAGMENT_ALT` (`OBJSEGS.C`).
- Parallel implementations of the same job: the inline-assembly encoders in `ASMENC.C` and
  `ASMENC2.C` (`_ALT` names), the end-of-file symbol scans `SCAN_FILE_SYMBOLS` (`SYMSCAN.C`)
  and `SCAN_FILE_SYMBOLS_C` (`SYMSCANC.C`), and the statement parsers for C++ and C mode
  (`STMTCPP.C`, `STMTC.C`).

## Engine findings
- **No parser generator** (confirmed): recursive descent for statements and declarations,
  operator precedence for expressions, panic-mode recovery to synchronizing tokens; no yacc
  strings or tables. See [SUBSYSTEMS.md](SUBSYSTEMS.md).
- **Two record layouts for types** (likely): `TYPEREC.C` reads the target at +3 and flags at
  +7/+8 where `TYPESIZE.C` uses `TYPE_TARGET` (+7) and byte 12. Names keep them apart
  (`TYPE_SIZE` / `SIZE_OF_TYPE_CHECKED`).
- **Heap banks** (likely): conventional, swap file, EMS, extended memory and an empty bank,
  each with its own hooks; nodes moved between banks are locked with flag 8000h
  (`LOCK_HEAP_NODE`).
- **Precompiled headers** (confirmed by the file magic): `PCH.C`, magic 0xEDFE, version 6;
  `#pragma hdrfile` and `hdrstop`; the preamble's directives are saved and replayed.
- **Code-generator optimisations shaped the source** (confirmed): BC 2.0 removes unreachable
  jumps before its tail merging, so jumps left by tail merging survive. Matching the last
  functions needed the original's early returns, repeated statements and separate
  `return` statements.

- **Front-end hook table** (confirmed): the C front end copies a 196-byte table
  (`C_FRONTEND_HOOK_TABLE`) over the hook slots at DS:80AC, so the same back end serves C and
  C++ through function pointers (`*_HOOK`).
- **Flag-bit tests** (likely, `CGEXPR.C`): `FLAGS_BIT_TEST_JUMP_KIND` turns `(x & 2^n) != 0`
  into a direct conditional jump for n = 0, 2, 6, 7, 11, the CF, PF, ZF, SF and OF bits.
- **Static locals with constructors** (likely, `STMTCPP.C`): `GUARD_STATIC_LOCAL_INIT` wraps
  the initialiser in a test of a new flag variable and registers a destructor that runs only
  when the flag is set.
- **The built-in assembler** (`INLINASM.ASM`): its opcode table entries select an encoder by
  form number (`ASM_ENCODE_*`); error exits `ASM_FAIL_*` map to the messages
  `EMIT_ASM_STATEMENT` reports.

- **dvprintf was compiled C** (confirmed by the match): `DVPRINTF.C` is Turbo C 2.01 C. Its
  loop is written with goto, the step and test sitting inside the switch after the last case;
  the same loop as a for statement with `default: return` is 4 bytes longer, which is why it
  had stayed TASM. `%x` of 0 prints nothing.
- **What stays TASM is hand-written**: the floating-point helpers (carry-flag loops such as
  `shr si,1 / jae`, argument pushes shared by two calls, a 64-bit mantissa in four
  registers), the inline assembler, the overlay manager and the start-up code.

- **Record layouts** (confirmed by the field naming, src/include/FIELDS.H): the type pool holds
  two layouts, the C++ front end's and the C front end's 10-byte records with the same items
  4 bytes lower; in both an array keeps its element type at 0x07. Function flag 4 marks a
  variadic function (EXPRPARS.C accepts `...` in an expression only then, as va_start
  needs). The code generator's "code nodes" are flow-graph blocks, operations are 4-byte
  tuples with their operands at the same index in a parallel pool, and the C front end's
  symbols live in the pool once called the statement pool.

## Found by the comment pass (each noted in its file; kept, the bytes depend on it)
Likely bugs or odd behaviour in the original (likely: read from the byte-matched code):
- **SEARCHP** reads one byte past the PATH value when it does not end in ';'.
- **RMMOVE** (memmove) picks its copy direction by comparing segments first, so overlapping
  blocks are only handled within one segment.
- **DISCARD_OUTPUT_FILE** always deletes the file at ASM_OUTPUT_PATH, even when the open file
  is the linker response file.
- **Ctrl-Break** goes through LINE_HOOK to EXIT(0x100); C0_TERMINATE passes only AL, so the
  exit code is 0.
- **ADOPT_EXTERNAL_REGIONS** (RHAPI.C): the bank 0 branch tests the gathered free space, not
  the resolved node offset.
- **Heap flag 8000h** ("locked") stops tagging and eviction but not compaction.
- **SWAP_FILE_PREPARED** is one counter for both swap banks, so only the first gets its file
  pre-extended. OUT_OF_MEMORY_HANDLER never returns, so the allocators' retry paths are dead.
- **Precompiled headers** (PCH.C): FREE_PCH_FILE_SPACE never links freed blocks into the free
  list, ALLOC_PCH_FILE_SPACE's best fit also accepts smaller blocks, and SAVE_MACRO_SNAPSHOT
  reads macro text from POOL_E even for odd offsets (POOL_F).
- **PRAGMA_WARN** silently ignores an unknown warning name (the entry is never null).
- **RUN_LINKER**'s second argument pass treats any option other than -Y as -v.
- **INTRINS.C**: a long or far constant in `__emit__` falls into MSG_BAD_CALL_INTRINSIC after
  emitting its two words; CHECK_EMIT_ARGUMENT_LIST loops on the same node after
  MSG_ILLEGAL_PARAMETER_EMIT (endless without an error limit); the POP DS flag is never set.
- **SPECMEMB.C**: CHECK_MEMBER_CLASS_CALLABLE returns 0 for an array member even when the
  member is found.

More duplicated code: BCC_INTEGER_COERCE (TYPEREC.C) and CODE_MASK (TRUNCVAL.C); EXPRNOD2.C
copies nine EXPRMAKE.C functions (the `_ALT` names). Never called: RTL_ATOI, RTL_STRCHR,
STRING_APPEND_N.

Engine notes: C++ mode is CPP_MODE (from -P or a .cpp file); NO_ERRORS_YET gates code and
data output; VTABLE_MODE (probably -V) chooses no tables, all tables, or tables in their own
segments; the constructor, destructor, `this` and vtable-pointer names are TOKEN_NAMES
entries (CTOR_NAME, DTOR_NAME, THIS_NAME, VTABLE_PTR_NAME); the code generator's register
numbers are 0 AX, 1 AH, 2 DX, 4 BX, 6 CX, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 14 CS, 15 SS
(probably, from the interrupt prologue and SEGMENT_REGISTER_CODE).

## Names that were misleading
Corrected in the readability pass: PRAGMA_WARN, PRAGMA_STARTUP, PRAGMA_EXIT (from the pragma
table at DS:1F5C), NAME_TEXT_COPY, FIND_PARAM_INDEX, DEFINE_HUGE_DATA_SEGMENTS, EMIT_HUGE_DATA.
The field pass renamed seven pools after what they hold (CSYM_POOL_SEG, SRCFILE_POOL_SEG,
FLOW_BLOCK_POOL_SEG, BASE_LIST_SEG, SYMBOL_POOL_SEG, FORMAL_POOL_SEG, TAG_BODY_POOL_SEG) and
NEW_RETURN_BLOCK to NEW_SWITCH_BLOCK. Pass 3 corrected `BCC_TYPE_INT` (it holds the plain char type: now `CHAR_TYPE`, with
`CHAR_POINTER_TYPE` and `FAR_CHAR_POINTER_TYPE`), `TYPE_SIZE1`/`TYPE_SIZE2` (pointers to int
functions: `INT_NEAR_FUNC_PTR_TYPE`/`INT_FAR_FUNC_PTR_TYPE`), the INLINASM label
`CLAIM_REGISTERS` (the RET encoder: `ASM_ENCODE_RETURN`), and the swapped `line`/`file`
locals in `STMTC.C`. File names that mislead: `RMSET0.ASM` holds an int-to-decimal routine,
not memset; `LD2LONG.ASM` returns a long; `SAVEREGS.C` is mostly the 8087 evaluation stack.
INLINASM.ASM's section comments keep the old listing names, several of them wrong.
Still to check:
- `BCC_STMT_NEW` (`CDECL.C`) builds a TK_ENUM record.
- `TABLE_145A`, now `COMPARE_NEGATE_TABLE`: it negates comparisons where `CHECK_COMPARE_RANGE`
  would be expected to swap operands.

## Open questions
- Pass 3 named every remaining placeholder. Where the code did not show a purpose, the
  name says literally what the code does (basis `descriptive`, evidence in names.log).
- Operators 1, 3-7, 0x33 and 0x42 have no name (EXPROP.H): their printed token
  is an identifier or nothing.
- The six names the proof tools pinned are renamed too (`HEAP_ALLOC_ITEM`, `HEAP_FREE_ITEM`,
  `HEAP_ALLOC_NODE`, `HEAP_ALLOC_HANDLE`, `SWAP_GROW_FILE_ALLOWED`, `HEAP_STATUS`), with the
  link-group sources CB002/CO056/CB0B4 rebuilt (contents identical) and the proof tools'
  pins brought up to date: native object and parser hashes, and the external order, which
  Turbo C sets by a hash of the name. The 2-byte link difference seen when R4F8.C was renamed
  came from native-placements.json, which is keyed by listing name while the link matched
  placements to source modules by name; the link now maps them through LISTING_STEMS.
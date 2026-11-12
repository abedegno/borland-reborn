# How BCC.EXE is organised

This is a map of Borland C++ 2.0's command-line compiler as recovered here, from the
command line to the object file. The sources are grouped the same way, one directory per
part under src/ (driver, lexer, preproc, parser, cpp, types, expr, diag, codegen, inlasm,
output, heap, overlay, rtl, float; see [src/README.md](../src/README.md)). Every file has a
descriptive 8.3 name (map/filenames.tsv records the old ones) and a header comment giving its
role and entry points; [SOURCE-MAP.md](SOURCE-MAP.md) lists them all. What a part does is
read from the code; where a role is an inference from callers or data, the file's notes say
so.

## Resident part (always in memory)
- **Start-up and driver**: `C0.ASM` (start-up), `RMAIN13C.C` (main), `RDRV388.C` (runs a
  compile, spawns TASM/TLINK through `RTL_EXEC`, shrinking memory around it with
  `SHRINK_MEMORY_FOR_EXEC` / `RESTORE_MEMORY_AFTER_EXEC`).
- **Run-time library**: the `R*` modules and the run-time files in
  CODE_0..CODE_45 (`RTL_*` names: open, read,
  write, lseek, getenv, searchpath, memmove, memset, string functions). Most are Turbo C 2.01
  C, some C with inline assembly in Borland's .CAS style, some TASM.
- **Far-memory heap** (CODE_2: the `HP*` files, `HEAPMAIN.C`, `EMSBANK.C`,
  `EXTBANK.C`, `RHAPI.C`): BCC keeps its records in far
  pools. Memory is a set of banks, each with its own read, write, move and find-free hooks:
  bank 0 conventional memory, 3 EMS, 4 extended memory, 1/2 a swap file, 5 an empty bank
  (`INIT_MAIN_HEAP`, `INIT_EMS_BANK`, `INIT_EXT_BANK`, `INIT_SWAP_BANK`). Nodes carry owner
  tags (`HPOWNTAG.C`: allocate and free a tag).
- **Overlay manager** (`OVRMGR.ASM`, Borland's VROOMM) loads the overlay units below.

## Front end (overlays)
- **Lexer and input**: `LEXER.C` (lexer), `INPUT.C` (the input stack: source files,
  macro-expansion contexts, buffer refill, position), `TOKSTRM.C` (token record and playback stream). The current token is
  `CURRENT_TOKEN`; token codes are `TOK_*` (TOKEN.H), named from BCC's own keyword table.
- **Preprocessor**: `PREPROC.C` (directives, `#pragma` handlers `PRAGMA_*`), `PCH.C`
  (precompiled headers, `PCH_*`).
- **Inline assembly statements**: `ASMSTMT.C` scans `asm` statements and hands them to
  the assembler (`INLINASM.ASM`, resident, TASM).
- **Parser**: hand-written, no parser generator. Statements and declarations are recursive
  descent: `STMTCPP.C` (C++ mode) and `STMTC.C` (C mode) dispatch on the current token
  (`case TOK_IF: PARSE_IF_STATEMENT()`), with panic-mode recovery through
  `SKIP_TO_SYNC_TOKEN`. Expressions use an operator-precedence parser with operator and
  operand stacks (`OPPREC.C`: `PUSH_OPERATOR`, `REDUCE_OPERATOR`). C++ expressions (new,
  member selection, qualified names) are in `CPPEXPR.C`.
- **Diagnostics**: every message is a number in BCC's message table (`MESSAGES.C`; names
  `MSG_*` in MSG.H). `REPORT_ERROR`, `REPORT_WARNING` and `REPORT_FATAL` print with the
  prefixes "Error", "Warning" and "Fatal"; `DIAG.C` holds the helpers that add a
  position or a name (`REPORT_DIAGNOSTIC_*`).
- **Types and symbols**: type records (TYPE_POOL, accessed with `TYPE_W(type, TYPE_KIND)`,
  kinds `TK_*` named from BCC's type-name table), `TYPESIZE.C` (sizes, compatibility),
  `CPPSCOPE.C`/`CPPCTOR.C` (C++ scopes, constructors, destructors, virtual bases),
  `SPECMEMB.C` (compiler-generated special members).
- **Expressions**: expression nodes (EXPR_POOL_SEG; fields `EXPR_OP`, `EXPR_TYPE`,
  `EXPR_LEFT`, `EXPR_RIGHT`, operators `EOP_*` named from BCC's operator-to-token table),
  semantic checks in `EXPRCHK.C`, constant folding in `CONSTFLD.C` (`FOLD_EXPRESSION`:
  x*2^n becomes a shift, x%2^n a mask) and `SIMPLIFY.C` (`SIMPLIFY_*`, constant arithmetic),
  inline function expansion in `INLINEXP.C`.

## Back end (overlays)
- **Driver**: `CGDRIVER.C` (`GENERATE_FUNCTION_CODE`, per function).
- **Code generation**: `CGEXPR.C` (x86 expression generator), `CGCALL.C` (calls and
  arguments), `SWITCH.C` (switch lowering: compare tree, table scan, jump table),
  `INTRINS.C` (intrinsics, `__emit__`), `BITFIELD.C` (bitfields), `FRAME.C`/`SAVEREGS.C`
  (prologue, epilogue, frame).
- **Registers**: `REGALLOC.C` (register allocator), `REGVARS.C` (register variables).
- **Code nodes and passes**: `CODENODE.C` (code-node pools), `PEEPHOLE.C` (peephole:
  register contents, redundant loads), `JUMPOPT.C` (jumps), `CROSSJMP.C` (cross-jumping:
  merging common tails, the optimisation whose leftovers made some functions hard to match),
  `FLOWBLK.C`/`BLKLAYOT.C` (flow-graph blocks, layout, jump shortening).
- **Inline assembly**: `ASMCODE.C` (instruction encoder and code bytes); `ASMENC.C` and
  `ASMENC2.C` are the C and C++ front ends' versions of the same asm-statement hooks.
- **Output**: `OMFWRITE.C` (OMF object writer, `OBJ_*`), `OBJSEGS.C` (segments and groups),
  `OBJSYMS.C` (C front end) and `OBJPUBS.C`/`DEBUGREC.C` (C++ front end) write symbols and Turbo
  Debugger records; `ASMEXTRN.C`/`ASMSYMS.C` are the same C/C++ pair for assembly output, with
  `ASMDATA.C` and `ASMTEXT.C` (assembly text for -S).

## Options and initialisation
`OPTIONS.C` (command-line option handlers), `INITPOOL.C` (pools and keywords),
`INITTYPE.C` (basic types and token tables), `SYMSCANC.C` and `SYMSCAN.C` (end-of-file symbol
scans: undefined, unused, zero-size symbols).

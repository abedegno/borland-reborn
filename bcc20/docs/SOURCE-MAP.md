# Source map

What each source in src/ does, by directory (src/README.md describes the directories). Every
file has a descriptive 8.3 name; map/filenames.tsv records the names used during matching. The
role column comes from each file's header comment, the functions column from its definitions.

| File | Segment | Role | Functions (first few) |
|---|---|---|---|
| codegen/BITFIELD.C | ovr177_C215UNIT | bitfield load, store and increment | GENERATE_BITFIELD_LOAD, GENERATE_BITFIELD_STORE, GENERATE_BITFIELD_OP_ASSIGN, GENERATE_BITFIELD_INC_DEC, NEW_SHIFT_NODE |
| codegen/BLKLAYOT.C | ovr153_C114UNIT | block layout, jump shortening, assembly or object byte output | BEGIN_CODE_STREAM, NEW_CODE_FRAGMENT, CLOSE_CODE_FRAGMENT, START_NEXT_FRAGMENT, ADD_FIXUP ... |
| codegen/BYTEPOOL.C | ovr149_C221UNIT | code generation: the data byte pool: appends bytes and merges a byte string with an earlier identical copy (probably string literals) | BYTE_POOL_LENGTH, EMIT_VALUE, MERGE_DUPLICATE_BYTES |
| codegen/CGCALL.C | ovr178_C208UNIT | calls and argument passing | GENERATE_CALL, SPLIT_ARG_LIST_BY_COUNT, PUSH_ARGUMENT_LIST, PUSH_ARGUMENT_CHAIN, EMIT_CALL_INSTRUCTION ... |
| codegen/CGCONV.C | CODE_7_R7HELP | code generation: GENERATE_CONVERSION generates code for a type conversion node through the CONVERSION_RULES table | GENERATE_CONVERSION |
| codegen/CGDRIVER.C | ovr151_C220UNIT | per-function back-end driver (GENERATE_FUNCTION_CODE) | GENERATE_FUNCTION_CODE, BACKEND_NOOP_HOOK, LOWER_SWITCHES |
| codegen/CGEXPR.C | ovr148_C203UNIT | x86 code generation: expression generator | GENERATE_EXPRESSION, EMIT_RETURN_VALUE, EMIT_TEST_ZERO, SEGMENT_REGISTER_CODE, EMIT_COMPARE ... |
| codegen/CGOPER.C | CODE_7_R7MAIN | code generation: GENERATE_OPERATOR generates code for one operator node through the OPERATOR_RULES table, sending conversions to GENERATE_CONVERSION | GENERATE_OPERATOR |
| codegen/CODENODE.C | ovr147_C216UNIT | code-node allocators | NEW_CODE_NODE, NEW_VARIABLE_NODE, NEW_PLAIN_CODE_NODE, NEW_CONSTANT_NODE, MARK_VARIABLE_ACCESS |
| codegen/CODEOP.C | ovr176_C223UNIT | code generation: maps an expression node to its code operation number through operand-kind tables; probably refines register-variable operands | CODE_OP_FOR_NODE, REFINE_KIND_10_OPERAND |
| codegen/CODEPASS.C | ovr155_C205UNIT | code-node passes and register masks | SIMPLIFY_ZERO_CONST_INSNS, SIMPLIFY_BLOCK_ZERO_CONSTS, RESERVE_ALL_REGISTERS, RESTORE_RESERVED_REGISTERS, FREE_REGISTER_MASK ... |
| codegen/CROSSJMP.C | ovr172_C106UNIT | cross-jumping (merging common code tails) | OPERAND_TREES_EQUAL, COUNT_BLOCK_HISTORY_ENTRIES, SPLIT_COMMON_TAIL, CROSS_JUMP_PASS |
| codegen/EMITBIN.C | ovr162_STAOV0F6 | code generation: emits a binary operation using the registers assigned to its operands, adding register moves as needed | EMIT_REG_ASSIGNED_BINARY |
| codegen/EMITBLK.C | ovr162_STAOV0F4 | code generation: emits the x86 instructions for one block's code nodes, dispatching on code op and replaying register history | EMIT_BLOCK_INSTRUCTIONS |
| codegen/EMITFPU.C | ovr162_STAOV0F7 | code generation: emits an instruction whose operand is on the 8087 stack, with fast-float and stored-symbol variants (probably floating point) | EMIT_EVAL_STACK_INSN |
| codegen/EMITFUNC.C | ovr162_STAOV0F3 | code generation: emits a function body block by block (instruction blocks, inline asm, scope debug hooks, jumps and returns) | EMIT_FUNCTION_BODY |
| codegen/EMITHELP.C | ovr162_STAOV0F5 | code generation: replaces a code node with a call to a named run-time helper and emits the near or far call | EMIT_HELPER_CALL_FOR_NODE |
| codegen/EMITHIST.C | ovr162_STAOV0F8 | code generation: replays the register history entries for an instruction (register moves, pushes, pops, spills) before emitting it | EMIT_REGISTER_HISTORY |
| codegen/EMITINSN.C | ovr161_C104UNIT | instruction emitters (EMIT_INSN_*) | EMIT_INSN_NO_OPERANDS, EMIT_INSN_STACK_REG, EMIT_INSN_REG_STACK, EMIT_INSN_REG, EMIT_INSN_NODE ... |
| codegen/FLOWBLK.C | ovr146_C113UNIT | flow-graph blocks for the code generator | NEW_BLOCK, NEW_ASM_STATEMENT_BLOCK, INIT_FUNCTION_STATE, NEW_SCOPE_ENTER_BLOCK, NEW_SWITCH_BLOCK ... |
| codegen/FRAME.C | ovr159_C207UNIT | prologue/epilogue and frame offsets | EMIT_FRAME_SETUP, EMIT_WINDOWS_PROLOGUE, EMIT_WINDOWS_EPILOGUE, EMIT_PROLOGUE, EMIT_FRAME_TEARDOWN ... |
| codegen/INITDATA.C | ovr175_STAOV15F | code generation: emits the bytes of a constant initialiser (integers, float/double from long double, addresses through hooks); reports illegal initialisation | EMIT_INITIALIZER_VALUE |
| codegen/INTRINS.C | ovr181_C214UNIT | intrinsic calls, __emit__ | GENERATE_ARGUMENTS_BY_WEIGHT, GENERATE_INTRINSIC_CALL, EMIT_INLINE_ARGUMENTS, CHECK_EMIT_ARGUMENTS, CHECK_EMIT_ARGUMENT_LIST |
| codegen/JUMPOPT.C | ovr171_C105UNIT | jump optimisation | RESOLVE_JUMP_TARGETS, OPTIMIZE_JUMPS, IS_JUMP_ONLY_BLOCK, IS_BLOCK_EMPTY, IS_SKIPPABLE_JUMP_TARGET ... |
| codegen/OUTINIT.C | ovr140_STOVR141 | code generation: initialises the code-output pools and opens the object file or the assembly output file | INIT_CODEGEN_POOLS |
| codegen/PEEPHOLE.C | ovr173_C101UNIT | peephole pass over the code-node list: tracks register contents, drops redundant loads | CLEAR_REGISTER_SLOTS, CLEAR_SLOTS_BY_MASK, REGISTER_HOLDS_VALUE, FIND_ASSIGNED_REGISTER, MARK_REDUNDANT_OPERAND ... |
| codegen/REGALLOC.C | ovr157_C204UNIT | register allocator | ALLOCATE_REGISTERS, TREE_USES_REGISTER_MASK, COLLECT_REGISTER_HINTS, NARROW_REGISTER_HINT, ALLOCATE_BLOCK_REGISTERS ... |
| codegen/REGMOVOP.C | ovr162_STAG001 | code generation: picks one of two register-to-register opcodes for a code op from the opcode descriptor table | REG_MOVE_OPCODE |
| codegen/REGVARS.C | ovr156_C212UNIT | register variable allocation | ASSIGN_REGISTER_VARIABLES, FIND_BEST_REGISTER_VARIABLE, MARK_BLOCK_TREE_REGISTERS, LOWEST_SET_BIT_INDEX, REGISTER_VARIABLE_SCORE ... |
| codegen/SAVEREGS.C | ovr158_C109UNIT | code generation: 8087 support (floating-point operations, compares, stores, the 8087 register stack) and the saved-register pushes | OPERAND_KIND_OPCODE_DELTA, SWAP_OPERAND_OPCODE, GEN_FPU_BINARY_OP, GEN_FPU_COMPARE, FPU_STORE_NODE_6C ... |
| codegen/STMTBLK.C | ovr058_C77UNIT | code generation: parser-to-back-end interface; appends function, scope, jump, return and expression blocks to the flow graph only while code generation is enabled | NEW_LABEL_IF_ENABLED, START_FUNCTION_STATE, FINISH_FUNCTION_STATE, APPEND_SCOPE_ENTER_BLOCK, APPEND_SCOPE_EXIT_BLOCK ... |
| codegen/STORAGE.C | ovr057_C76UNIT | code generation: queries and setters for symbol storage records and type classes, runtime helper symbol declaration, parameter counts; probably called through back-end hooks | STORAGE_INTRINSIC_NUMBER, STORAGE_SEGMENT, SYMBOL_CATEGORY, TYPE_CLASS_BYTE, STORAGE_TYPE_CLASS ... |
| codegen/SWITCH.C | ovr152_C209UNIT | switch lowering (compare tree, table scan, jump table) | LINK_NODE, LOWER_SWITCH, LOWER_SWITCH_TABLE_SCAN, LOWER_SWITCH_COMPARES, LOWER_SWITCH_JUMP_TABLE ... |
| codegen/VARUSES.C | ovr154_STAOV087 | registers: tallies loop-weighted uses of each variable over the code-node list, probably to score register-variable candidates | TALLY_WEIGHTED_USES |
| cpp/ACCESS.C | ovr168_C112UNIT | C++ classes: member lookup through base classes (ambiguity report), friend tests and access checks for members and symbols | MEMBER_RESULT_TYPE, FIND_MEMBER_IN_BASES, FIND_MEMBER_REPORT, FIND_MEMBER_QUIET, ACCESS_MODE_VIA_BASES ... |
| cpp/BASECONV.C | ovr166_C116UNIT | C++ expressions: reference binding and dereference, derived-to-base and base-to-derived pointer conversion, virtual base pointers, base offsets, temporary objects | STRIP_REFERENCE, MAKE_REFERENCE, DEREF_REFERENCE_EXPR, MAKE_VBASE_POINTER_EXPR, BUILD_BASE_ADJUST_EXPR ... |
| cpp/CLASSDEF.C | ovr120_C201UNIT | C++ classes: parses class definitions: base-class lists, access specifiers, member, friend and virtual function declarations, pure specifiers, member type finishing | PARSE_STATE_CHECK, BCC_TYPE_RESOLVE_NAME, TYPE_PATH, TYPE_OPERATOR, LIST_FIND ... |
| cpp/CLSMEMB.C | ovr121_C131UNIT | C++ classes: struct/class body members: data members and bitfields, layout and size checks, closing a class type, enum bodies | ADD_BITFIELD_MEMBER, ADD_DATA_MEMBER, TYPE_REVERSE, BCC_TYPE_FINISH, TYPE_LOOP_FAR ... |
| cpp/CPPCALL.C | ovr074_C18UNIT | C++ expressions: function calls: overloaded call resolution, virtual calls through the vtable, operator function calls, member-pointer calls, argument conversion and defaults | ADJUST_THIS_ARGUMENT, RESOLVE_OVERLOADED_CALL, VIRTUAL_TABLE_ENTRY, LOWER_VIRTUAL_CALL, CHECK_CONST_THIS ... |
| cpp/CPPCAST.C | ovr076_C229UNIT | C++ expressions: resolves symbol references (overloaded names), casts, and class-to-integral or class-to-scalar conversion through conversion functions | RESOLVE_SYMBOL_NODE, ANALYZE_TEMP_OBJECT_NODE, CAST_EXPRESSION, CONVERT_CLASS_TO_INTEGRAL, CONVERT_CLASS_TO_SCALAR |
| cpp/CPPCTOR.C | ovr071_C236UNIT | C++ constructors, destructors, virtual bases | FREE_PARAM_LIST, LIST_CONTAINS_VALUE, QUEUE_DEFERRED_SYMBOL, CANNOT_CONVERT_TYPES, BUILD_BASE_ADDRESS ... |
| cpp/CPPEXPCK.C | ovr077_C230UNIT | C++ expressions: class assignment, initialization and return checks, member selection and .*, member-pointer comparison, new and delete expressions | CHECK_CPP_ASSIGNMENT, CHECK_CPP_INITIALIZATION, CHECK_CPP_RETURN_VALUE, RESOLVE_CONVERSION_MEMBER, ANALYZE_MEMBER_SELECT ... |
| cpp/CPPEXPR.C | ovr075_C228UNIT | C++ expression parsing: new, member selection, qualified names | PARSE_MEMBER_SELECTOR, PARSE_QUALIFIED_NAME, PARSE_TYPE_CONSTRUCTOR_CALL, PARSE_NEW_EXPRESSION |
| cpp/CPPFINAL.C | ovr069_C13UNIT | C++ classes: end-of-file processing: static initializer and destructor functions, virtual tables (with this-adjust thunks), pending inline and deferred definitions | C13NEW, C13PENDING, C13VALUES, C13INITIALIZE, C13DECLARATIONS ... |
| cpp/CPPINIT.C | ovr085_C29UNIT | C++ initialization: references, class objects through constructors, constant initializers, array element construction, queued initializer expressions | QUEUE_INIT_EXPR, PAD_TO_POSITION, INIT_REFERENCE, PARSE_OBJECT_INIT, INIT_CLASS_OBJECT ... |
| cpp/CPPSCOPE.C | ovr101_C235UNIT | C++ type and scope tables | C9_ALLOC_MEMBER, COPY_TYPE_RECORD, FIND_EQUIVALENT_TYPE, INTERN_QUALIFIED_TYPE, TOKEN_FROM_NAME ... |
| cpp/CTORBODY.C | ovr067_C11FIND | C++ classes: parses constructor member-initializer lists and compiles constructor and destructor bodies with base, virtual-base, member and vptr setup | C11FLUSH, CTORBODY, C11MEMBER, C11BASE, C11UNNAMED ... |
| cpp/FUNCDECL.C | ovr119_C103UNIT | C++ declarations: checks function and member declarations: storage classes, overloading and extern "C", main, operator new/delete signatures, constructor/destructor rules, global anonymous unions | BCC_TYPE_RELATION, DEFINE_STATIC_DATA_MEMBER, BCC_TYPE_LINK, BCC_TYPE_COMPARE, BCC_TYPE_MATCH ... |
| cpp/IMPLMEMB.C | ovr068_C12CHECK | C++ classes: declares the implicit special members (default and copy constructor, assignment, destructor) at class end; checks const/reference members and pure functions | IMPLMEMB, C12SCAN, C12CHECK8, C12SCAN8, C12SPECIAL ... |
| cpp/INLINEBD.C | ovr082_C26UNIT | C++ inline functions: records the tokens of an inline body for later and compiles the recorded body; rejects asm in inline functions | RECORD_INLINE_BODY, COMPILE_INLINE_BODY |
| cpp/MANGLE.C | ovr070_C14UNIT | C++ names: name mangling for symbols, member functions, operators, conversions and argument types; decimal output used by type spelling | C14CHAR, C14TEXT, C14SYMBOL, APPEND_DECIMAL, C14LENGTH ... |
| cpp/MEMBPTR.C | ovr079_C23UNIT | C++ expressions: builds pointer-to-member values (&X::m) and initialized temporary objects | MAKE_MEMBER_POINTER, MAKE_INITIALIZED_TEMP |
| cpp/OVERLOAD.C | ovr097_C39UNIT | C++ expressions: overload resolution: ranks argument conversions, picks the best candidate, finds and applies user conversion functions | IS_STANDARD_CONVERSION, IS_PROMOTION, MATCH_RANK, NEEDS_REFERENCE_TEMP, FIND_MATCHING_OVERLOAD ... |
| cpp/SPECMEMB.C | ovr167_C132UNIT | C++ compiler-generated special members (constructors, assignment) | CHECK_MEMBER_CLASS_CALLABLE, CHECK_COPY_CTOR_MEMBERS, CHECK_ASSIGN_MEMBERS, MAKE_MEMBER_ACCESS, INIT_VECTOR_ELEMENTS ... |
| diag/DIAG.C | ovr081_C25UNIT | diagnostic helpers (REPORT_DIAGNOSTIC_*, SKIP_TO_SYNC_TOKEN) | APPEND_NAME_BYTE, APPEND_NAME_TEXT, REPORT_DIAGNOSTIC_AT, REPORT_DIAGNOSTIC, REPORT_DIAGNOSTIC_LINE ... |
| diag/DIAGFMT.C | CODE_4_RG4A | diagnostics: BCC_FORMAT_DIAGNOSTIC prints one message line: kind, file name, line number, message text with arguments, and the function name | BCC_FORMAT_DIAGNOSTIC |
| diag/ERRREPT.C | CODE_4_R5B8B | diagnostics: REPORT_ERROR prints an error message, counts it, and stops the compile through a long jump when the error limit is reached | REPORT_ERROR |
| diag/FATAL.C | CODE_4_R5B44 | diagnostics: REPORT_FATAL, prints a fatal message and ends the compilation | REPORT_FATAL |
| diag/MESSAGES.C | ovr095_C71MSG | diagnostic message table |  |
| diag/MSGGET.C | CODE_4_MSGGET | diagnostics: returns the text of a message number from BCC's message table, loading its overlay image first | BCC_MESSAGE_TEXT |
| diag/TYPESPEL.C | ovr089_C33UNIT | diagnostics: spells types, symbols, members, operators and call signatures as text for messages | APPEND_CHAR, APPEND_TEXT, APPEND_SYMBOL_NAME, APPEND_PARAM_LIST, APPEND_TYPE_SPELLING ... |
| diag/WARNREPT.C | CODE_4_R5BED | diagnostics: REPORT_WARNING prints a warning when that warning is enabled, counts it, and stops the compile when the warning limit is reached | REPORT_WARNING |
| driver/BACKINIT.C | ovr139_C219UNIT | back end: initialisation and shutdown: owner tags and the code-generation pools (code nodes, operands, data bytes, line numbers, variables) | CLEAR_BACKEND_STATE, INIT_BACKEND, SHUT_DOWN_BACKEND |
| driver/C0.ASM | CODE_0_C0 | CODE_0:0000..02C9, hand-written assembly: BCC's start-up code (C0). |  |
| driver/CONFIG.C | ovr111_C53UNIT | options and initialisation: reads TURBOC.CFG (from the current or BCC.EXE directory) and command-line options, locates the default precompiled-header file | READ_CONFIG_AND_ARGS, BCC_LINE_READ, FILE_TEST, FILE_FATAL |
| driver/DRVLINK.C | ovr109_C51UNIT | driver: handles each command-line file (compile .C/.CPP, assemble .ASM through TASM), builds the TASM command and TLINK response file, expands @response files | LG0A1, ADD_DEFAULT_EXTENSION, BCC_STRING_CONCAT_NEAR, PROCESS_FILE_ARGUMENT, PATH_PROCESS ... |
| driver/INITPOOL.C | ovr087_C31UNIT | compiler initialisation: pools, keywords | BEGIN_SESSION, END_SESSION, OPEN_SESSION_SOURCE, BEGIN_BACKEND_PHASE, INIT_POOLS_AND_KEYWORDS |
| driver/INITTYPE.C | ovr065_C9INIT | basic types and token tables initialisation | INITTYPE, C9BANKS, C9SCALAR, C9POINTER, C9PARAMETER ... |
| driver/OPTIONS.C | ovr103_C238UNIT | command-line option handlers | COMPILE_ONE_FILE, MODE_FALLBACK, RECORD_SOURCE_NAME, RESET_WARNINGS_TO_DEFAULT, SAVE_WARNINGS_AS_DEFAULT ... |
| driver/RDRV388.C | CODE_1_RDRV388 | run-time library | RUN_PROGRAM |
| driver/RMAIN13C.C | CODE_1_RMAIN13C | run-time library | RMAIN13C |
| driver/SEGNAMES.C | ovr110_C52UNIT | options and initialisation: per-module setup of segment, group and class names from memory model and -z options, predefined macros, far data segments, #pragma startup/exit records | REGISTER_NAME, BCC_TOKEN_FLAG, INIT_SEGMENT_NAMES, BCC_INTERN_STRING, DEFINE_FAR_SEGMENT ... |
| driver/USAGE.C | CODE_1_R4F8 | driver: PRINT_USAGE_AND_EXIT writes the "Syntax is: BCC [options]" usage text to stdout and terminates the program | PRINT_USAGE_AND_EXIT |
| expr/CALLCHK.C | ovr061_C5UNIT | expressions: function call analysis; checks call arguments against the prototype (count, types, void values, structures passed by value, const/volatile this) | C5WRAP, C5CHECK, REPORT_ARGUMENT_MISMATCH, C5ARG, C5VALUE ... |
| expr/COMMAEXP.C | ovr060_C4FLAT | expressions: analyses chains of comma expressions iteratively (no recursion), setting each comma node's type from its right operand | ANALYZE_COMMA_EXPR |
| expr/CONSTFLD.C | ovr130_C123UNIT | constant folding | FOLD_STATEMENT_EXPR, HOIST_SIDE_EFFECTS, FOLD_EXPRESSION, FOLD_CONSTANT_NODE, REPORT_CONSTANT_TOO_LARGE ... |
| expr/CONSTVAL.C | ovr118_TVALUE | expressions: parses a constant expression and returns its long value, else reports "Constant expression required" | CONST_EXPR_VALUE_BODY |
| expr/CONVERT.C | ovr063_C7UNIT | expressions: conversions; dereference, address-of, array/function decay, rvalue, casts, enum to int, usual arithmetic conversions, with pointer-conversion warnings | MAKE_DEREF_NODE, MAKE_DEREFERENCE, C7CHAIN, MAKE_ADDRESS_OF, CONVERT_EXPR_TO_TYPE ... |
| expr/EXPRCHK.C | ovr060_C120UNIT | expression semantic checks (subscripts, pointers, integral operands) | SCALE_BY_ELEMENT_SIZE, CHECK_OPERAND_KINDS, PREPARE_BINARY_OPERANDS, SCALE_POINTER_OPERAND, ELIDE_COPY_ASSIGN ... |
| expr/EXPRDISP.C | ovr059_C78UNIT | expression builder dispatch | RESOLVE_SYMBOL_REFERENCE, C78_special_symbol, C78_reconcile_pair, C78_lower_value, C78_apply_value_type ... |
| expr/EXPRMAKE.C | ovr133_C85UNIT | expressions: expression-node constructors (binary, leaf, constant, real, bitfield), retyping and narrowing, compound assignment and post-increment expansion, side-effect test | EXPR_POOL_IS_RESET, RESET_EXPR_POOL, NEW_EXPR_NODE, NEW_EXPR_LEAF, NEW_EXPR_NODE_MODE ... |
| expr/EXPRNOD2.C | ovr116_C58UNIT | expressions: second set of expression-node constructors and rewriting of compound assignment and post-increment trees with temporaries; probably reached through back-end hooks | BCC_NODE_RESET, BCC_NODE_BINARY, BCC_NODE_MODE, BCC_NODE_INTEGER, NEW_BITFIELD_NODE_ALT ... |
| expr/EXPRPACK.C | ovr100_C42UNIT | expressions: packs expression trees into compact records in a separate pool and rebuilds them; used for inline bodies and default arguments, with pool mark/reset | PACK_EXPR_TREE, UNPACK_EXPR_TREE, EXPR_BANK_MARK, EXPR_BANK_RESET |
| expr/EXPRPARS.C | ovr128_C119UNIT | expressions: precedence parser (PARSE_EXPRESSION), unary operators, identifiers, subscripts, calls and arguments, assignment and pointer compatibility checks, conversions (STCVT*) | PARSE_EXPRESSION, STEVALN, STUNARY, STDEFARG, PARSE_TYPE_NAME_PAREN ... |
| expr/EXPRPOOL.C | ovr091_C234UNIT | expressions: expression node pool: allocate/free nodes and trees, constants, temporaries, null pointer constants, copying and comparing trees | TOKEN_TO_OPERATOR, ALLOC_EXPR_NODE, RESET_EXPR_POOL_ALT, FREE_EXPR_TREE, FREE_EXPR_NODE ... |
| expr/INLINEXP.C | ovr093_C233UNIT | inline function expansion | PARSE_INLINE_STATEMENTS, APPEND_EXPR_CHAIN, APPEND_TAIL_TO_BRANCHES, PARSE_INLINE_IF, PARSE_INLINE_STATEMENT ... |
| expr/LOWEREXP.C | ovr098_C40UNIT | expressions: lowers expression trees before code generation, probably turning member-pointer constants into initialized temporaries | LOWER_OP48_TO_TEMP_SYMBOL, MAKE_STEP_CONSTANT, LOWER_EXPR_TREE, LOWER_EXPRESSION |
| expr/SIMPLIFY.C | ovr099_C239UNIT | tree simplifier and constant arithmetic (SIMPLIFY_*, FOLD_*) | FOLD_ADD_SIGNED, FOLD_ADD_UNSIGNED, FOLD_SUB_SIGNED, FOLD_SUB_UNSIGNED, FOLD_MUL_SIGNED ... |
| expr/TRUNCVAL.C | ovr113_CODEMASK | expressions: truncates a long constant to a given width, with or without sign extension, using the int, char and long masks | CODE_MASK |
| expr/UNARYOP.C | ovr062_C6BUILD | unary-operator expression builders | C6PRE, BUILD_DEREF, C6PRED, C6KIND, BUILD_ADDRESS_OF ... |
| float/I642LD.ASM | CODE_12_R12EXT | CODE_12:0006..0084, Borland run-time library (hand-written assembly). | RTL_INT64_TO_LDOUBLE |
| float/LD2DBL.ASM | CODE_11_R11P64 | CODE_11:012B..01D5, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_TO_DOUBLE |
| float/LD2FLOAT.ASM | CODE_11_R11P32 | CODE_11:0060..00D5, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_TO_FLOAT |
| float/LD2I64.ASM | CODE_12_R12TRUNC | CODE_12:0084..010D, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_TO_INT64 |
| float/LD2LONG.ASM | CODE_12_R12I16 | CODE_12:010D..0141, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_TO_LONG |
| float/LD2ULONG.ASM | CODE_12_R12I32 | CODE_12:0141..016F, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_TO_ULONG |
| float/LDARITH.ASM | CODE_9_R9UNIT | CODE_9 (from 0067h): software arithmetic on 80-bit extended reals, used | RTL_LDOUBLE_ADDSUB, RTL_LDOUBLE_ADD, RTL_LDOUBLE_SUB, RTL_LDOUBLE_MUL, RTL_LDOUBLE_DIV |
| float/LDCMP.ASM | CODE_10_R10CMP | CODE_10:0004..0075, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_COMPARE |
| float/LDISNAN.C | CODE_9_R9SPEC | run-time library: BCC_EXTENDED_HAS_PAYLOAD tests whether an 80-bit real is a NaN (exponent 7FFFh with a mantissa other than infinity's) | BCC_EXTENDED_HAS_PAYLOAD |
| float/LDRNDDBL.ASM | CODE_11_R11ROUND | CODE_11:00D5..012B, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_ROUND_TO_DOUBLE |
| float/LDRNDFLT.ASM | CODE_11_R11NORM | CODE_11:0006..0060, Borland run-time library (hand-written assembly). | RTL_LDOUBLE_ROUND_TO_FLOAT |
| float/LDUNPACK.ASM | CODE_9_R9UNPACK | CODE_9:000B, hand-written assembly.  Unpacks an 80-bit extended real at | RTL_LDOUBLE_UNPACK |
| float/LMULOVF.ASM | ovr135_C141UNIT | CO04E: LMUL_WITH_OVERFLOW, the signed 32-bit multiply used by constant folding | LMUL_WITH_OVERFLOW |
| float/LONG2LD.ASM | CODE_12_R12FROMI | CODE_12:016F..019D, Borland run-time library (hand-written assembly). | RTL_LONG_TO_LDOUBLE |
| float/RPOW10.ASM | CODE_13_RPOW10 | Segment 0A1A:000C..0087 (CODE_13 through CODE_14:0007), Borland run-time | RTL_LDOUBLE_SCALE_POW10 |
| float/RSTRTOD.ASM | CODE_14_RSTRTOD | Segment 0A22:0008..0128 (CODE_14 through CODE_15:0008), Borland run-time | RTL_SCAN_LDOUBLE |
| float/ULONG2LD.ASM | CODE_12_R12FROMU | CODE_12:019D..01CB, Borland run-time library (hand-written assembly). | RTL_ULONG_TO_LDOUBLE |
| heap/BANKINIT.C | CODE_5_R5CLEAN | far-memory heap: INIT_EMS_EXT_BANKS sets up the EMS and extended-memory banks when their limits allow | INIT_EMS_EXT_BANKS |
| heap/EMSBANK.C | CODE_2_RG2BEND | far-memory heap: the EMS bank; read, write and move nodes and find free space in EMS pages, INIT_EMS_BANK, and the empty null bank | INIT_NULL_BANK, CALL_SELF_FOREVER_RG2BEND, EMS_READ_NODE, EMS_WRITE_NODE, EMS_MOVE_NODE ... |
| heap/EXTBANK.C | CODE_2_RG2BMID | far-memory heap: the extended-memory bank; read, write and move nodes and find free space there, and INIT_EXT_BANK sets the bank up | EXT_READ_NODE, EXT_WRITE_NODE, EXT_MOVE_NODE, EXT_FIND_FREE_NODE, INIT_EXT_BANK |
| heap/GETSTAT.C | CODE_2_GETSTAT | far-memory heap: returns HEAP_STATUS, the result of the last heap call | BCC_READ_STATUS |
| heap/HEAPMAIN.C | CODE_2_RG2BTAIL | far-memory heap: main heap set-up (INIT_MAIN_HEAP), conventional bank, swap-file bank, handle pointers, segment pinning and block moves | HANDLE_ITEM_POINTER, PIN_SEGMENT, UNPIN_SEGMENT, CONV_FIND_FREE_NODE, RH_ROUND_REQUEST ... |
| heap/HPADDFRE.C | CODE_2_RHFADD | far-memory heap: ADD_FREE_NODE links a node into the free list | ADD_FREE_NODE |
| heap/HPALLOC.C | CODE_2_RH110A | far-memory heap: HEAP_ALLOC_NODE allocates a node: rounds the request, reclaims or extends space, first fit on the free list, then the request bank | HEAP_ALLOC_NODE |
| heap/HPALLOCH.C | CODE_2_RH1B9A | far-memory heap: the far allocation entry: allocates a node and a handle item pointing at it | HEAP_ALLOC_HANDLE |
| heap/HPAVAIL.C | CODE_2_RH0D8E | far-memory heap: RH_AVAILABLE_SPACE returns the free space in the active heap, probably less a reserve kept for overlay code nodes | RH_AVAILABLE_SPACE |
| heap/HPCOPYD.C | CODE_2_RG2A4 | far-memory heap: RH_COPY_DESCRIPTOR copies a node descriptor's data bytes from one bank's descriptor table to another's | RH_COPY_DESCRIPTOR |
| heap/HPDEFTAG.C | CODE_2_R3504 | far-memory heap: returns the default owner tag for new heap nodes | GET_DEFAULT_OWNER_TAG |
| heap/HPDESC.C | CODE_2_RG2A | far-memory heap: the descriptor table: grow it, release flagged entries, prepare it for a request | RH_GROW_DESCRIPTORS, RH_RELEASE_FLAGGED, RH_PREPARE_DESCRIPTORS |
| heap/HPDISP.C | CODE_2_RG2B | far-memory heap: RH_HEAP_DISPATCH calls a bank's operation, RH_UPDATE_NODE_ADDRESS reports a node's address, BCC_POOL_RESOLVE_WORD finds a handle's node and bank | RH_HEAP_DISPATCH, RH_UPDATE_NODE_ADDRESS, BCC_POOL_RESOLVE_WORD |
| heap/HPDOSCLS.C | CODE_2_RH4674 | far-memory heap: RH_DOS_CLOSE closes a file handle (DOS 3Eh), used for the swap file | RH_DOS_CLOSE |
| heap/HPDOSDEL.C | CODE_2_RH4664 | far-memory heap: RH_DOS_DELETE deletes a file (DOS 41h), used for the swap file | RH_DOS_DELETE |
| heap/HPDOSIO.ASM | CODE_2_RG2CREST | CODE_2:45E6..4664, hand-written assembly: DOS file wrappers used by the | RH_DOS_OPEN, RH_DOS_CREATE, RH_DOS_READ, RH_DOS_WRITE, RH_DOS_SEEK |
| heap/HPEMSREL.C | CODE_2_RH3CDD | far-memory heap: RELEASE_EMS_BANK frees the EMS bank's handle | RELEASE_EMS_BANK |
| heap/HPEVICT.C | CODE_2_RG2A6 | far-memory heap: moves a node's contents out to another bank (RH_TRY_FLAG20) or to bank 5 (RH_TRY_FLAG40) and frees its place; clears ring entries | RH_TRY_FLAG20, RH_TRY_FLAG40, RH_CLEAR_TAG_ENTRY |
| heap/HPEXTEND.C | CODE_2_RH180E | far-memory heap: EXTEND_HEAP grows the heap by an amount and returns the new free node | EXTEND_HEAP |
| heap/HPEXTREL.C | CODE_2_RH3F7E | far-memory heap: RH_CALL_EXT_RELEASE releases the extended-memory bank through the overlay manager's OVR_RELEASE_EXT_MEMORY | RH_CALL_EXT_RELEASE |
| heap/HPFIXHI.C | CODE_2_RH12D3 | far-memory heap: ALLOC_FIXED_HIGH allocates a node fixed at the high end of the heap, reclaiming and gathering free space as needed | ALLOC_FIXED_HIGH |
| heap/HPFIXLO.C | CODE_2_RH1222 | far-memory heap: ALLOC_FIXED_LOW allocates a node fixed at the low end of the heap, reclaiming and gathering free space as needed | ALLOC_FIXED_LOW |
| heap/HPFREEHB.C | CODE_2_RH1C4F | far-memory heap: frees a handle's block (FREE_HANDLE_BLOCK) | FREE_HANDLE_BLOCK |
| heap/HPFREETG.C | CODE_2_R25FF | far-memory heap: FREE_TAG_NODES releases every heap node owned by a given tag | FREE_TAG_NODES |
| heap/HPGATHER.C | CODE_2_RH19FB | far-memory heap: GATHER_ALL_FREE_SPACE moves nodes so all free space forms one block at the high end | GATHER_ALL_FREE_SPACE |
| heap/HPGATHHI.C | CODE_2_RH0F0A | far-memory heap: GATHER_FREE_AT_HIGH_END moves nodes to collect a free block of the needed size at the high end of the heap | GATHER_FREE_AT_HIGH_END |
| heap/HPGATHLO.C | CODE_2_RH100A | far-memory heap: GATHER_FREE_AT_LOW_END moves nodes to collect a free block of the needed size at the low end of the heap | GATHER_FREE_AT_LOW_END |
| heap/HPGETITM.C | CODE_2_RH0349 | far-memory heap: takes a free handle item from the first heap page with room, adding a page when needed | HEAP_ALLOC_ITEM |
| heap/HPGROW.C | CODE_2_RH1AE0 | far-memory heap: GROW_HEAP_TO grows the heap up to a requested top, used after TASM or TLINK has run | GROW_HEAP_TO |
| heap/HPHSIZE.C | CODE_2_RH2C48 | far-memory heap: HANDLE_BLOCK_SIZE returns the size of the block behind a handle | HANDLE_BLOCK_SIZE |
| heap/HPINBNK5.C | CODE_2_RH2C7B | far-memory heap: HANDLE_IN_BANK_5 tells whether a handle's node currently lives in bank 5 | HANDLE_IN_BANK_5 |
| heap/HPINITBK.C | CODE_2_RH1893 | far-memory heap: INIT_BANK builds the descriptor table and free list of a newly set-up bank | INIT_BANK |
| heap/HPNEWB5.C | CODE_2_RH19BD | far-memory heap: NEW_BANK5_NODE allocates a node in bank 5 | NEW_BANK5_NODE |
| heap/HPNEWPG.C | CODE_2_RG2A2 | far-memory heap: RH_NEWPAGE allocates a heap node of the active heap's page size | RH_NEWPAGE |
| heap/HPOWNTAG.C | CODE_2_R3513 | far-memory heap: allocates and frees the owner tags that group heap nodes for release together | ALLOCATE_OWNER_TAG, FREE_OWNER_TAG |
| heap/HPPUTITM.C | CODE_2_RH03B6 | far-memory heap: returns a handle item to its page and frees the page when it empties | HEAP_FREE_ITEM |
| heap/HPRCLNOD.C | CODE_2_RH0DCB | far-memory heap: RH_RECLAIM_NODE decides whether a node can be given up to make room, moving it to another bank (flag 20h) or discarding it (flag 40h) | RH_RECLAIM_NODE |
| heap/HPRCLSPC.C | CODE_2_RG2A7 | far-memory heap: RECLAIM_FOR_SPACE walks the nodes, giving up reclaimable ones until the needed space is free | RECLAIM_FOR_SPACE |
| heap/HPRELCB.C | CODE_2_R19EC | far-memory heap: BCC_RESIDENT_RELEASE_CALLBACK, a release callback that unlinks a pool node and returns 0 | BCC_RESIDENT_RELEASE_CALLBACK |
| heap/HPRELFIX.C | CODE_2_RH0826 | far-memory heap: RH_RELEASE_SPECIAL releases a fixed node through UNFIX_LOW_NODE or UNFIX_HIGH_NODE | RH_RELEASE_SPECIAL |
| heap/HPRELND.C | CODE_2_RH0845 | far-memory heap: RH_RELEASE_DESCRIPTOR frees a node: drops its bank copy and ring entry, unfixes it, and returns it to the free list | RH_RELEASE_DESCRIPTOR |
| heap/HPRESIZE.C | CODE_2_RG2A9 | far-memory heap: RESIZE_NODE grows or shrinks a node in place or by moving it, with SWAP_WITH_FREE_NODE exchanging a node with a free one | RESIZE_NODE |
| heap/HPRESIZH.C | CODE_2_RH1441 | far-memory heap: RESIZE_HANDLE_BLOCK changes the size of the block behind a handle | RESIZE_HANDLE_BLOCK |
| heap/HPRING.C | CODE_2_RG2A8 | far-memory heap: the 256-slot handle ring; RING_PUSH_NODE records a node as newest and tags or untags older ones, RING_ADVANCE_CURSOR moves the tag cursor | RING_PUSH_NODE, RING_ADVANCE_CURSOR |
| heap/HPSHRINK.C | CODE_2_RH1A2F | far-memory heap: shrinks the heap to a given size (SHRINK_HEAP_TO) | SHRINK_HEAP_TO |
| heap/HPSHRNKH.C | CODE_2_R1A1A | far-memory heap: SHRINK_HEAP_FULLY shrinks the heap as far as it will go and returns the new top | SHRINK_HEAP_FULLY |
| heap/HPSHRNKN.C | CODE_2_RH1399 | far-memory heap: SHRINK_NODE shrinks a node and returns the freed tail to the free list | SHRINK_NODE |
| heap/HPSHUTDN.C | CODE_2_RH2D67 | far-memory heap: at exit releases the swap, EMS and extended-memory banks and shuts the overlay manager down | SHUTDOWN_HEAP_BANKS |
| heap/HPSLICE.C | CODE_2_RG2A1 | far-memory heap: RHSLICE splits a free node to a requested size; RH_COALESCE_FREE and RH_MARK_FREE_AND_MERGE merge free neighbours | RHSLICE, RH_COALESCE_FREE, RH_MARK_FREE_AND_MERGE |
| heap/HPSPACE.C | CODE_2_R36F7 | far-memory heap: HEAP_SPACE_BELOW_LIMIT returns the heap space still available below the limit | HEAP_SPACE_BELOW_LIMIT |
| heap/HPSTUBEM.C | CODE_2_RH3CE7 | far-memory heap: RH_SELF_CALL_AFTER_EMS_BANK, an uncalled stub that only calls itself, probably a placeholder kept from Borland's source | RH_SELF_CALL_AFTER_EMS_BANK |
| heap/HPSTUBIN.C | CODE_2_RH2CA7 | far-memory heap: RH_SELF_CALL_BEFORE_INIT, an uncalled stub that only calls itself, probably a placeholder kept from Borland's source | RH_SELF_CALL_BEFORE_INIT |
| heap/HPSTUBIO.C | CODE_2_RH45DE | far-memory heap: RH_SELF_CALL_BEFORE_DOS_IO, an uncalled stub that only calls itself, probably a placeholder kept from Borland's source | RH_SELF_CALL_BEFORE_DOS_IO |
| heap/HPSTUBOV.C | CODE_2_RH45D6 | far-memory heap: RH_SELF_CALL_AFTER_OVR_CODE, an uncalled stub that only calls itself, probably a placeholder kept from Borland's source | RH_SELF_CALL_AFTER_OVR_CODE |
| heap/HPSTUBSW.C | CODE_2_RH38FB | far-memory heap: RH_SELF_CALL_AFTER_SWAP_BANK, an uncalled stub that only calls itself, probably a placeholder kept from Borland's source | RH_SELF_CALL_AFTER_SWAP_BANK |
| heap/HPSWPDIS.C | CODE_2_RH38C7 | far-memory heap: DISCARD_SWAP_BANK closes and deletes a swap-file bank | DISCARD_SWAP_BANK |
| heap/HPTAG.C | CODE_2_RH0C40 | far-memory heap: TAG_NODE marks a node as tagged, adds its size to the tagged total and tells its bank | TAG_NODE |
| heap/HPUNFXHI.C | CODE_2_RH07D4 | far-memory heap: UNFIX_HIGH_NODE releases a node that was fixed at the high end of the heap | UNFIX_HIGH_NODE |
| heap/HPUNFXLO.C | CODE_2_RH077F | far-memory heap: UNFIX_LOW_NODE releases a node that was fixed at the low end of the heap | UNFIX_LOW_NODE |
| heap/HPUNTAG.C | CODE_2_RH0C86 | far-memory heap: UNTAG_NODE clears a node's tagged flag and tells its bank | UNTAG_NODE |
| heap/INITMARK.C | ovr123_C70S42 | far-memory heap: one-byte marker at the start of a memory region that INIT_MEMORY_MANAGER passes to the heap; no code |  |
| heap/MEMINIT.C | CODE_5_C5INIT | far-memory heap: start-up memory initialisation; sets up the main heap with the out-of-memory handler, probably adopts the start-up code region as heap space | INIT_MEMORY_MANAGER |
| heap/OOMHAND.C | CODE_5_C5CB | far-memory heap: out-of-memory callback; frees the name and hash pools, then reports "Out of memory" and exits or reports it as fatal | OUT_OF_MEMORY_HANDLER |
| heap/OWNERTAG.C | CODE_2_R34F0 | far-memory heap: SET_DEFAULT_OWNER_TAG stores the owner tag the heap gives new nodes | SET_DEFAULT_OWNER_TAG |
| heap/POOLINIT.C | CODE_2_RH1B1C | far-memory heap: POOL_INIT allocates a pool's bank-0 block and keeps its segment in the pool's handle word | POOL_INIT |
| heap/POOLMARK.C | CODE_5_STPAIR | far-memory heap: saves and restores the length mark of the malloc pool (mark and release) | SAVE_MALLOC_POOL_MARK_BODY, RESTORE_MALLOC_POOL_MARK |
| heap/POOLS.C | ovr124_C237UNIT | memory: growable near pools (segment, capacity, used, free list): allocate, reuse, free, trim; reports compiler table limit | POOL_ALLOC_REUSE, POOL_FREE_ITEM, POOL_ALLOC, POOL_TRIM, POOL_SET_USED |
| heap/RHAPI.C | CODE_2_RHAPI | CODE_2 far-memory heap: nodes, banks (conventional, EMS, extended, swap file), overlay support | SET_NODE_INFO, RH_HANDLE_TRY_FLAG40, ALLOC_BANK5_NODE, C31_SET_MEMORY_LIMIT, C31_MEMORY_LIMIT ... |
| heap/RHCYCLE.C | CODE_2_RHCYCLE | far-memory heap: a stub that only calls itself (nothing calls it) | RHCYCLE |
| heap/RHINIT.C | CODE_2_RHINIT | far-memory heap: INIT_HEAP, the heap's start-up entry (banks, handle-item pages, hooks) | INIT_HEAP |
| heap/RHLINK.C | CODE_2_RHLINK | far-memory heap: inserts a node into the active bank's address-ordered node chain | RHLINK |
| heap/RHSETCUR.C | CODE_2_RHSETCUR | far-memory heap: moves the active bank's roving cursor past the node just allocated | RHSETCUR |
| heap/RHSWAP.C | CODE_2_RHSWAP | far-memory heap: exchanges a node with the next one in the address chain | RHSWAP |
| heap/RHUNLINK.C | CODE_2_RHUNLINK | far-memory heap: takes a free node off the free list (it stays in the address chain) | RHUNLINK |
| heap/RNEWNODE.C | CODE_2_RNEWNODE | far-memory heap: takes a descriptor from the shared free-descriptor list | RNEWNODE |
| heap/RNOOPS.C | CODE_2_RNOOPS | far-memory heap: the empty bank's do-nothing hooks | BANK5_NOOP_NODE_HOOK, BANK5_NOOP_REQUEST_HOOK |
| heap/RRETNDES.C | CODE_2_RRETNDES | far-memory heap: unlinks a node from the address chain and gives back its descriptor | RRETNDES |
| heap/RT2F09.C | CODE_2_RT2F09 | far-memory heap: far wrapper that resolves a heap handle word to its bank and node | RESOLVE_HANDLE_FAR |
| inlasm/ASMCODE.C | ovr142_C84UNIT | code-byte emitter and inline-asm instruction encoder | EMIT_CODE_BYTE, EMIT_CODE_WORD, REGISTER_ENCODING, DEFINE_ASM_LABEL, ADD_ASM_JUMP ... |
| inlasm/ASMENC.C | ovr170_C222UNIT | inline assembly encoder | ENCODE_ASM_SYMBOL, PARSE_ASM_MEMBER_ALT, PARSE_ASM_JUMP_LABEL_ALT |
| inlasm/ASMENC2.C | ovr088_C227UNIT | inline assembly encoder (second copy, other pools) | FIND_ASM_MEMBER, ENCODE_ASM_SYMBOL_ALT, PARSE_ASM_MEMBER, PARSE_ASM_JUMP_LABEL |
| inlasm/ASMOPND.C | ovr182_C213UNIT | inline assembly: operand helpers for the encoder in INLINASM.ASM: decodes symbol operands, emits bytes, fixup operands and segment-override prefixes | DECODE_ASM_SYMBOL, ASM_COLON_LABEL_STUB, EMIT_ASM_BYTE, EMIT_ASM_FIXUP_OPERAND, ASM_FLUSH_KIND2_STUB ... |
| inlasm/INLINASM.ASM | CODE_8_R8UNIT | CODE_8: BCC's built-in inline assembler (resident).  Hand-written | ASM_ASSEMBLE_STATEMENT, ASM_INIT_STATE, ASM_FLUSH_EMIT_RECORDS, ASM_PARSE_PREFIXES, ASM_PARSE_DATA_DIRECTIVE ... |
| lexer/COMMENT.C | ovr105_C138UNIT | lexer: comment skipping (block and line comments) in the input buffer, written as inline assembly | COMMENT_BLOCK, COMMENT_LINE, SCAN_EMPTY |
| lexer/INPUT.C | ovr107_C133UNIT | lexer and input: the input stack: opening source files, macro-expansion and argument contexts, buffer refill, string literal copying, input position, source echo | BCC_INPUT_POP, BCC_INPUT_PUSH, OPEN_SOURCE_FILE, RETURN_MINUS_ONE_STUB, POP_INPUT_CONTEXT ... |
| lexer/LEXER.C | ovr106_C226UNIT | lexer | INIT_LEXER_POOLS, INIT_LEXER_STATE, LEX_NEXT_TOKEN, LEX_HASH, LEX_READ ... |
| lexer/STRLIT.C | ovr118_EARGS | lexer: joins adjacent string-literal tokens into one byte string in the data pool, counting characters and merging duplicate strings | EMIT_ARGS |
| lexer/TOKADV.C | ovr102_C44UNIT | lexer: token advance; reads the next token from nested playback streams or the lexer, records tokens, and drains unread string-literal characters | NEXT_LITERAL_CHAR, PEEK_TOKEN, ADVANCE_TOKEN |
| lexer/TOKSTRM.C | ovr084_C28UNIT | token record/playback stream | STREAM_PUT_BYTE, STREAM_PUT_INT, STREAM_PUT_LONG, STREAM_PUT_REAL, STREAM_ENCODE_TOKEN ... |
| output/ASMDATA.C | ovr180_C102UNIT | assembly text output (-S) | EMIT_PROC_BEGIN, RESERVE_DATA_BYTES, ALIGN_ASM_DATA_EVEN, EMIT_DB_DATA, EMIT_PROC_OR_LABEL ... |
| output/ASMEXTRN.C | ovr169_C218UNIT | assembly text output (-S): externals and COMM declarations, function debug information, hex byte lists, symbol names | EMIT_HEX_BYTE_LIST, EMIT_ASM_EXTERNALS, EMIT_ASM_FUNCTION_DEBUG, EMIT_ASM_SYMBOL_NAME |
| output/ASMSYMS.C | ovr114_C56UNIT | assembly text output (-S): end-of-module symbol declarations (EXTRN, PUBLIC, COMM, EQU), ?debug hex records and symbol name text | NEEDS_CPP_MANGLING, DEBUG_NUMBERS, DUMP_ONE, DUMP_ALL, DUMP_NODE ... |
| output/ASMTEXT.C | ovr179_C107UNIT | assembly text output (-S): instruction and operand text | EMIT_HEX_BYTE, EMIT_DEBUG_B_DIRECTIVE, EMIT_DEBUG_E_DIRECTIVE, DEFINE_LABEL_ASM, ADD_JUMP_ASM ... |
| output/DEBUGREC.C | ovr122_C127UNIT | debug information records | TYPE_MEMCHECK, BCC_SYMBOL_SWEEP, EMIT_DEBUG_TYPE, EMIT_DEBUG_MEMBER_PTR_TYPE, EMIT_DEBUG_METHOD_TYPE ... |
| output/HUGEDATA.C | ovr073_C17UNIT | data output: huge and far arrays: defines the data segments a huge object needs and emits array data bank by bank | C17MEASURE, DEFINE_HUGE_DATA_SEGMENTS, EMIT_HUGE_DATA, BEGIN_ARRAY_DATA, NEXT_DATA_BANK ... |
| output/OBJPUBS.C | ovr115_C231UNIT | object output: EXTDEF and PUBDEF records with mangled names, and function debug records | EMIT_EXTDEF_PUBDEF_RECORDS, EMIT_FUNCTION_DEBUG_RECORD, ADD_EXTDEF_ENTRY, EMIT_PUBDEF_RECORD, OBJ_PUT_SYMBOL_NAME |
| output/OBJSEGS.C | ovr145_C108UNIT | object output: segment, group and data-buffer manager | DEFINE_SEGMENT, DEFINE_SEGMENT_FIXED_ID, SELECT_SEGMENT, CURRENT_SEGMENT_SIZE, FIND_SEGMENT ... |
| output/OBJSYMS.C | ovr137_C100UNIT | object output: OMF symbol records and Turbo Debugger comment records | EMIT_OBJ_SYMBOLS, EMIT_TYPE_DEBUG_INFO, EMIT_ENUM_DEBUG_INFO, EMIT_STRUCT_DEBUG_INFO, EMIT_DEBUG_SYMBOL_ENTRY ... |
| output/OMFWRITE.C | ovr144_C117UNIT | OMF object-file writer (OBJ_*) | OBJ_RESET_RECORD, OBJ_PUT_BYTE, OBJ_PUT_INDEX, OBJ_RECORD_LENGTH, OBJ_PUT_NAME ... |
| output/SRCSEGS.C | ovr160_C82UNIT | object output: numbered records tying source files to code segments (new, clone on segment change, find by serial); probably for line-number debug records | NEW_SERIAL_NODE, CLONE_NODE_KEEP_SERIAL, CLONE_NODE_NEW_SERIAL, FIND_NODE_BY_SERIAL |
| overlay/OVREXMEM.ASM | CODE_2_RG2BREST | CODE_2:3F88..45D6, hand-written assembly: the overlay manager's EMS and |  |
| overlay/OVRLOAD.ASM | CODE_3_R3OVR | Segment 059A:0004..00DD (CODE_3 through CODE_4:000D), part of the overlay | OVR_ENSURE_IMAGE_LOADED |
| overlay/OVRMGR.ASM | CODE_2_RG2CEND | CODE_2:4682..5060, hand-written assembly: the overlay manager (Borland's |  |
| parser/ASMSTMT.C | ovr117_C129UNIT | parser: inline assembly statements (asm keyword): scans asm tokens, mnemonics and operands and hands each statement to the assembler encoder | BCC_PARSE_DIAGNOSTIC, BCC_NODE_ERROR, BCC_NAME_COMPARE, SCAN_ASM_TOKEN, PARSE_ASM_STATEMENT ... |
| parser/CDECL.C | ovr127_C202UNIT | parser (C mode): external and local declarations: storage classes, struct fields and bitfields, initializers and their data, function definitions | BCC_STATEMENT_MAIN, TOKEN_STARTS_TYPE, BCC_STMT_BUILD, BCC_STMT_SPECIAL_CHECK, BCC_STMT_ALLOC ... |
| parser/CDECLR.C | ovr134_C125UNIT | parser (C mode): declarators: parameter and abstract declarators, declarator trees, parameter lists, binding a declarator to its type, building function types | BCC_STMT_DECL_NEW, PARSE_PARAM_DECLARATOR, PARSE_ABSTRACT_DECLARATOR, BCC_STMT_BEGIN, PARSE_DECLARATOR_TREE ... |
| parser/DECLSPEC.C | ovr072_C16UNIT | parser (C++ mode): declarations: declaration specifiers, pointer/array/function declarators, type modifiers, struct/union/class and enum specifiers, tags, cv-qualifiers | PARSE_OLD_STYLE_PARAMS, IS_VOID_PARAM_LIST, PARSE_PARAM_LIST, PARSE_POINTER_DECLARATOR, PARSE_ARRAY_DECLARATOR ... |
| parser/EXTDECL.C | ovr056_C83UNIT | parser: external (file-level) declarations; declares functions, typedefs and variables, merges redeclarations, parses declaration initialisers | C0RELINK, C0SELECT, SET_FUNCTION_SYMBOL_TYPE, MERGE_FUNCTION_DECLARATION, DECLARE_FUNCTION ... |
| parser/FUNCDEF.C | ovr083_C27UNIT | parser (C++ mode): function definitions: old-style parameters, parameter declaration, hidden return parameter, function body begin and end | PARSE_KR_PARAMETERS, COMPILE_FUNCTION_DEFINITION, DECLARE_PARAMETERS, DECLARE_HIDDEN_RETURN_PARAM, BEGIN_FUNCTION_BODY ... |
| parser/INITLIST.C | ovr092_C36UNIT | parser: initializers: brace lists, sized and unsized arrays, struct members and packed bitfields, scalar initializers and their data output | END_BRACE_INIT, PAD_INIT_DATA, IS_CONSTANT_INITIALIZER, INIT_SCALAR, INIT_UNSIZED_ARRAY ... |
| parser/LOOKAHD.C | ovr086_C30UNIT | parser (C++ mode): lookahead that decides whether tokens form a type or declaration, skipping balanced token groups | SKIP_BALANCED_TOKENS, SCAN_TYPE_SPECIFIERS, SCAN_DECLARATOR, BCC_PARSE_QUERY, IS_PAREN_TYPE_NAME |
| parser/OPPREC.C | ovr090_C232UNIT | operator-precedence expression parser (operator and operand stacks) | INIT_EXPR_PARSER, END_EXPR_PARSER, POP_OPERAND, PUSH_OPERATOR, POP_OPERATOR ... |
| parser/STMTC.C | ovr132_C122UNIT | statement parser, C mode | PARSE_BLOCK_BODY, ENTER_LOOP_WEIGHT, LEAVE_LOOP_WEIGHT, WARN_IF_UNREACHABLE, PARSE_STATEMENT_C ... |
| parser/STMTCPP.C | ovr064_C121UNIT | statement parser, C++ mode; declarations | RELEASE_SCOPE_OBJECTS, IS_DECLARATION_AHEAD, CHECK_SWITCH_SELECTOR, CHECK_CONDITION_EXPR, REVERSE_LIST_TO_COMMA ... |
| parser/SYMSCAN.C | ovr078_C22UNIT | end-of-file symbol scan: undefined, unused, zero-size symbols | SCAN_FILE_SYMBOLS, CHECK_FILE_SYMBOLS |
| parser/SYMSCANC.C | ovr126_C240UNIT | end-of-file symbol scan (C mode); initialisation | COMPILE_C_SOURCE, FINISH_COMPILATION, SCAN_FILE_SYMBOLS_C, BEGIN_SOURCE_FILE, BEGIN_BACKEND_OUTPUT ... |
| parser/TASSERT.C | ovr118_TASSERT | parser: accepts a comma separator, or the given closing token, else reports ", expected" | TREE_ASSERT |
| parser/TCALL.C | ovr118_TCALL | parser: requires the expected token and advances, otherwise reports a three-argument diagnostic and sets an error flag | TREE_INVOKE |
| parser/TCHECK.C | ovr118_TCHECK | parser: requires the current token to be the expected one and advances, otherwise reports the given error | REQUIRE_TOKEN_BODY |
| parser/TYPSTART.C | ovr118_TINT | parser: tests whether a token starts a type (a type keyword or an identifier naming a type) | TOKEN_IS_TYPE_START_BODY |
| preproc/CPPIFEXP.C | ovr080_C24UNIT | preprocessor (C++ mode): evaluates a #if constant condition, and looks up the function named in #pragma startup/exit | EVAL_CONSTANT_CONDITION, FIND_NAMED_FUNCTION_PREPARED |
| preproc/CPRAGFN.C | ovr129_C224UNIT | preprocessor (C mode): #if expression parsing hook, and looking up the function named in #pragma startup/exit | PARSE_PP_IF_EXPRESSION, FIND_NAMED_FUNCTION |
| preproc/DIRTAIL.C | ovr105_C137UNIT | preprocessor: checks the rest of a directive line, skipping blanks, comments and line splices and reporting extra characters | CHECK_DIRECTIVE_END |
| preproc/MACROS.C | ovr108_C49UNIT | preprocessor: macro table; define (warns on incompatible redefinition), undefine, test if defined, and find a name in a macro's parameter list | BCC_PACKED_LIST_LENGTH, BCC_COUNTED_COMPARE, MACRO_DEFINE, MACRO_REMOVE, MACRO_DEFINED ... |
| preproc/PCH.C | ovr165_C128UNIT | precompiled headers (PCH_*): hdrfile, hdrstop, saved preamble | ADD_PCH_DEPENDENCY, NEW_PREAMBLE_TRIE_NODE, FIND_OR_ADD_PREAMBLE, APPEND_DIRECTIVE_LIST, FIND_PREAMBLE ... |
| preproc/PREPROC.C | ovr105_C130UNIT | preprocessor directives and #pragma handlers (PRAGMA_*) | REPORT_PRAGMA_ERROR, DIRECTIVE_START, PRAGMA_WARN, CHECK_NAME_CONTEXT, PARSE_STARTUP_EXIT ... |
| preproc/SKIPLINE.C | ovr105_C139UNIT | precompiled headers: skips to end of line past comments, splices and quoted strings (used by PCH.C when scanning directives) | BCC_SCAN_FINISH_FAR |
| rtl/DPRINTF.C | CODE_39_RABBB | run-time library: dprintf (Turbo C 2.01), builds the argument list by hand and passes it to the small console printf RTL_DVPRINTF | RTL_DPRINTF |
| rtl/DVPRINTF.C | CODE_39_RG39A | run-time library: RTL_DVPRINTF, a small console printf with pascal calling: %d, %x, %c and %s with an l modifier; a newline prints CR LF; an unknown conversion ends the output | RTL_DVPRINTF |
| rtl/EXECMEM.C | CODE_5_R5PAIR | run-time library: shrinks BCC's memory (heap fully, then program top) before running TASM or TLINK, and grows it back afterwards | SHRINK_MEMORY_FOR_EXEC, RESTORE_MEMORY_AFTER_EXEC |
| rtl/FILETIME.C | ovr112_FILETIME | run-time library: returns a file's DOS date and time stamp through findfirst, or 0; used by precompiled headers and object output | FILE_TIME |
| rtl/R5ALLOC.C | CODE_5_R5ALLOC | run-time library: MALLOC allocates a word-rounded block from the malloc pool and returns a far pointer to it | MALLOC |
| rtl/RADDSL.C | CODE_16_RADDSL | run-time library | ADD_TRAILING_BACKSLASH |
| rtl/RAHELP.ASM | CODE_40_RAHELP | CODE_40:002E..0084, Borland run-time library (hand-written assembly). | RTL_ULTOA_CORE, RTL_LTOA_CORE |
| rtl/RARGV0F0.C | CODE_1_RARGV0F0 | run-time library | RARGV0F0 |
| rtl/RATOL.C | CODE_15_RATOL | run-time library | RTL_ATOL, RTL_ATOI |
| rtl/RBSRCH.C | CODE_20_RBSRCH | run-time library | BCC_BINARY_SEARCH |
| rtl/RCHMOD.C | CODE_21_RCHMOD | run-time library | _chmod |
| rtl/RCLOSE.C | CODE_22_RCLOSE | run-time library | RTL_CLOSE |
| rtl/RCOPY.ASM | CODE_0_RCOPY | CODE_0:0402..0418, Borland run-time library (hand-written assembly). | BCC_RUNTIME_COPY |
| rtl/RCREAT.C | CODE_23_RCREAT | run-time library | RTL_CREAT |
| rtl/RCTRL23.C | CODE_1_RCTRL23 | run-time library | RCTRL23 |
| rtl/RDATE.C | CODE_26_RDATE | run-time library | RTL_GETDATE, RTL_GETTIME |
| rtl/RDIV.ASM | CODE_0_RDIV | CODE_0:02C9..036C, Borland run-time library (hand-written assembly). |  |
| rtl/RDOSAH.C | CODE_17_RDOSAH | run-time library | DOS_CALL_AH |
| rtl/RDOSPTR.C | CODE_18_RDOSPTR | run-time library | RTL_DOS_CALL_PTR |
| rtl/REXEC.C | CODE_24_REXEC | run-time library | RTL_EXEC |
| rtl/REXIT09F.C | CODE_1_REXIT09F | run-time library | EXIT |
| rtl/RFFIND.C | CODE_25_RFFIND | run-time library | FINDFIRST, FINDNEXT |
| rtl/RFILEIO.C | CODE_6_RFILEIO | run-time library | CREATE_OUTPUT_FILE, BCC_OUTPUT_STRING, OUTPUT_CHAR, CLOSE_OUTPUT_FILE, DISCARD_OUTPUT_FILE |
| rtl/RFNSPLIT.C | CODE_19_RFNSPLIT | run-time library | SLICE_TEXT, FNSPLIT, COPY_TO_END, FNMERGE |
| rtl/RGETENV.C | CODE_27_RGETENV | run-time library: getenv (Turbo C 2.01), finds a variable in the DOS environment and returns a far pointer to its value | RTL_GETENV |
| rtl/RINIT.C | CODE_1_RINIT | run-time library | LINE_HOOK |
| rtl/RIRQ1B.C | CODE_1_RIRQ1B | run-time library | RIRQ1B |
| rtl/RLMUL.ASM | CODE_0_RLMUL | CODE_0:03A9..03C2, Borland run-time library (hand-written assembly). |  |
| rtl/RLSEEK.C | CODE_29_RLSEEK | run-time library | RTL_LSEEK |
| rtl/RLSHL.ASM | CODE_0_RLSHL | CODE_0:036C..038B, Borland run-time library (hand-written assembly). |  |
| rtl/RLSHR.ASM | CODE_0_RLSHR | CODE_0:03E3..0402, Borland run-time library (hand-written assembly). |  |
| rtl/RLTOA.ASM | CODE_40_RLTOA | CODE_40:0084..00CC, Borland run-time library (hand-written assembly): | RTL_ULTOA10, RTL_LTOA10, RTL_UTOA10 |
| rtl/RMMOVE.C | CODE_44_RMMOVE | run-time library | RTL_MEMMOVE |
| rtl/RMSET.C | CODE_41_RMSET | run-time library | RTL_MEMSET |
| rtl/RMSET0.ASM | CODE_40_RMSET0 | CODE_40:00CC..00E3, Borland run-time library (hand-written assembly). | RTL_ITOA10 |
| rtl/ROPEN.C | CODE_30_ROPEN | run-time library | RTL_OPEN |
| rtl/RPUTS.C | CODE_1_RPUTS | run-time library | WRITE_STDOUT_STRING |
| rtl/RREAD.C | CODE_31_RREAD | run-time library | RTL_READ |
| rtl/RSCAT.C | CODE_45_RSCAT | run-time library | STRING_APPEND, STRING_APPEND_N |
| rtl/RSCMP.C | CODE_33_RSCMP | run-time library | COMPARE_NAME |
| rtl/RSCPY.C | CODE_43_RSCPY | run-time library | STRING_COPY, RTL_STRNCPY |
| rtl/RSHAR.ASM | CODE_0_RSHAR | CODE_0:038B..03A9, Borland run-time library (hand-written assembly). |  |
| rtl/RSLEN.C | CODE_35_RSLEN | run-time library | STRING_LENGTH |
| rtl/RSTACK.ASM | CODE_0_RSTACK | CODE_0:03C2..03E3, Borland run-time library (hand-written assembly). | BCC_RUNTIME_BUILD |
| rtl/RSTRCHR.C | CODE_32_RSTRCHR | run-time library | RTL_STRCHR, STRING_FIND_CHAR |
| rtl/RSTRICMP.C | CODE_34_RSTRICMP | run-time library | STRING_COMPARE |
| rtl/RSTRLOW.C | CODE_1_RSTRLOW | run-time library | RTL_STRUPR |
| rtl/RTOUPPER.C | CODE_36_RTOUPPER | run-time library | RTL_TOUPPER |
| rtl/RUNLINK.C | CODE_37_RACCESS | run-time library | DELETE_FILE |
| rtl/RVECGET.C | CODE_1_RVECGET | run-time library | RVECGET |
| rtl/RVECSET.C | CODE_1_RVECSET | run-time library | RVECSET |
| rtl/RVECT.C | CODE_28_RVECT | run-time library: getvect and setvect (DOS functions 35h and 25h) | RTL_SETVECT |
| rtl/RWRITE.C | CODE_38_RWRITE | run-time library | RTL_WRITE |
| rtl/SEARCHP.C | CODE_42_SEARCHP | run-time library: searchpath(); finds a file in the current directory or along PATH | RTL_SEARCHPATH |
| rtl/SETTOP.C | CODE_5_R5SETBLK | run-time library: SET_PROGRAM_TOP resizes BCC's memory block (DOS 4Ah, or the DOS extender's call) so the program ends at a paragraph | SET_PROGRAM_TOP |
| rtl/TOLOWER.C | CODE_36_TOLOWER | run-time library: tolower() using the _ctype table | TOLOWER |
| rtl/ULDIV10.ASM | CODE_40_RAE41 | CODE_40:0001..002E, Borland run-time library (hand-written assembly). | RTL_ULDIV10 |
| types/CSYMTAB.C | ovr131_C124UNIT | types and symbols (C mode): scopes and symbol table: lookup, declaring locals and globals, member lookup, unused/never-used/use-before-assign warnings | CREATE_SCOPE, LOOKUP_SYMBOL, BCC_STMT_FIND2, DECLARE_SYMBOL, DECLARE_GLOBAL_VARIABLE ... |
| types/FLDPLACE.C | ovr096_C38UNIT | types: places struct members and bitfields at offsets (honouring word alignment); builds the hidden return slot address | PLACE_STRUCT_MEMBER, PLACE_BITFIELD_MEMBER, MAKE_RETURN_SLOT |
| types/NAMEPOOL.C | ovr104_C140UNIT | types and symbols: the symbol-name pool: hashes and interns names, copying new name text into pool banks | COPY_NAME_TO_BANK, BCC_SYMBOL_CREATE |
| types/PTRMOD.C | ovr134_STOVR95 | types: builds the pointer type for a near, far, huge or _seg modifier, defaulting by memory model and function type | PTR_TYPE_FOR_MODIFIER |
| types/TLOOK.C | ovr118_TLOOK | types: looks up an identifier as a type name (typedef or, with CPP_MODE, a class) in scopes and the current class | TYPE_LOOKUP |
| types/TYPEREC.C | ovr136_C111UNIT | types: builds array, function, pointer and struct type records, type sizes, alignment, flags and compatibility, and reserves array storage | KIND_TIMES_10, NEW_ARRAY_TYPE, MAKE_ENUM_TYPE, NEW_FUNCTION_TYPE, NEW_POINTER_TYPE ... |
| types/TYPESIZE.C | ovr066_C10TYPE | type size and compatibility | MAKE_POINTER_TYPE, C10PROMOTE, C10DEFAULTS, TYPES_COMPATIBLE, TYPE_ALIGNMENT ... |

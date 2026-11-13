; DGROUP.ASM: BCC.EXE's data segment (DGROUP), as source.
;
; Not matched by the gate (it has no target line): the exact link takes the data from the
; layout sources in linkgroups/.  The modding build (tools/modlink.py) assembles this file
; instead, and checks that with nothing edited it gives the original's data.
;
; Written by tools/gendata.py from the original image.  Every name of symbols.tsv is public
; at its original DGROUP offset: the C and assembly sources refer to their data by these
; names, never by number.  Far pointers are written as the functions they point at (TLINK
; points them through the overlay stubs for overlaid code), segment words as DGROUP, and
; the near pointers of map/data-pointers.tsv as the items they point at (a pointer into code
; stays a number tagged "; @code FUNCTION": the modding build writes the function's offset
; in the new layout there, from a first link's map).  Other words are
; kept as bytes: their types are not known, and a near pointer that is still a number stays
; right only while what it points at keeps its offset.  So add data at the end of _DATA (or
; of _BSS), or first write every pointer into the region you change as a name.
DGROUP		group	_DATA,_BSS,_BSSEND,_STACK
		extrn	ADD_ASM_JUMP:far
		extrn	ADD_JUMP_18_NEXT_FRAGMENT:far
		extrn	ADD_JUMP_18_NEXT_FRAGMENT_ALT:far
		extrn	ADD_JUMP_ASM:far
		extrn	ADD_LINENUM_ENTRY:far
		extrn	ALIGN_ASM_DATA_EVEN:far
		extrn	ALIGN_SEGMENT_EVEN:far
		extrn	BASIC_TYPE_FOR_KIND:far
		extrn	BCC_DEBUG_VALUE_MARK:far
		extrn	BCC_INTEGER_COERCE:far
		extrn	BCC_NAME_COMPARE:far
		extrn	BCC_NODE_BINARY:far
		extrn	BCC_NODE_CONVERT:far
		extrn	BCC_NODE_INTEGER:far
		extrn	BCC_NODE_MODE:far
		extrn	BCC_NODE_RESET:far
		extrn	BEGIN_BACKEND_OUTPUT:far
		extrn	BEGIN_BACKEND_PHASE:far
		extrn	C56_EMIT_NAME:far
		extrn	CODE_MASK:far
		extrn	COUNT_PARAMETERS:far
		extrn	DEBUG_FLUSH:far
		extrn	DEBUG_NUMBERS:far
		extrn	DECLARE_NAMED_GLOBAL:far
		extrn	DECLARE_RUNTIME_SYMBOL:far
		extrn	DECLARE_UNNAMED_SYMBOL:far
		extrn	DEFINE_ASM_LABEL:far
		extrn	DEFINE_LABEL_ASM:far
		extrn	DEFINE_LABEL_ENTRY:far
		extrn	DUMP_ALL:far
		extrn	EMIT_ASM_EXTERNALS:far
		extrn	EMIT_ASM_INSTRUCTION:far
		extrn	EMIT_ASM_LINE_MARK:far
		extrn	EMIT_ASM_SYMBOL_NAME:far
		extrn	EMIT_ASM_TRAILER:far
		extrn	EMIT_CS_JMP_BX_DISP:far
		extrn	EMIT_CS_JMP_BX_DISP_ASM:far
		extrn	EMIT_DATA_BYTE:far
		extrn	EMIT_DB_DATA:far
		extrn	EMIT_DD_ADDRESS:far
		extrn	EMIT_DEBUG_B_DIRECTIVE:far
		extrn	EMIT_DEBUG_E_DIRECTIVE:far
		extrn	EMIT_DEBUG_GLOBALS:far
		extrn	EMIT_DEBUG_SCOPE_SYMBOLS:far
		extrn	EMIT_DEPENDENCY_RECORD:far
		extrn	EMIT_DWORD_RELOC:far
		extrn	EMIT_DW_ADDRESS:far
		extrn	EMIT_EXTDEF_PUBDEF_RECORDS:far
		extrn	EMIT_GLOBALS_DEBUG_INFO:far
		extrn	EMIT_HEX_BYTE_LIST:far
		extrn	EMIT_LOAD_DATA_SEGMENT:far
		extrn	EMIT_LOAD_DATA_SEGMENT_ASM:far
		extrn	EMIT_LOCALS_DEBUG_INFO:far
		extrn	EMIT_LOCAL_LABEL:far
		extrn	EMIT_OBJ_SYMBOLS:far
		extrn	EMIT_PROC_BEGIN:far
		extrn	EMIT_PROC_ENDP:far
		extrn	EMIT_PROC_OR_LABEL:far
		extrn	EMIT_PUSH_RETURN_ADDRESS:far
		extrn	EMIT_PUSH_RETURN_ADDRESS_ASM:far
		extrn	EMIT_SCOPE_DEBUG_INFO:far
		extrn	EMIT_SWITCH_JUMP:far
		extrn	EMIT_SWITCH_JUMP_ASM:far
		extrn	EMIT_SWITCH_TABLE_LOAD:far
		extrn	EMIT_SWITCH_TABLE_LOAD_ASM:far
		extrn	EMIT_THIS_ADJUST_THUNK:far
		extrn	EMIT_THIS_ADJUST_THUNK_ASM:far
		extrn	EMIT_WORD_RELOC:far
		extrn	ENCODE_ASM_INSTRUCTION:far
		extrn	ENCODE_ASM_SYMBOL:far
		extrn	ENCODE_ASM_SYMBOL_ALT:far
		extrn	END_SESSION:far
		extrn	EVAL_CONSTANT_CONDITION:far
		extrn	EXPAND_COMPOUND_ASSIGN:far
		extrn	EXPAND_COMPOUND_ASSIGN_ALT:far
		extrn	EXPAND_POST_INC_DEC:far
		extrn	FIND_NAMED_FUNCTION:far
		extrn	FIND_NAMED_FUNCTION_PREPARED:far
		extrn	FINISH_COMPILATION:far
		extrn	FOLD_ADD_SIGNED:far
		extrn	FOLD_ADD_UNSIGNED:far
		extrn	FOLD_AND_LONG:far
		extrn	FOLD_DIV_SIGNED:far
		extrn	FOLD_DIV_UNSIGNED:far
		extrn	FOLD_MOD_SIGNED:far
		extrn	FOLD_MOD_UNSIGNED:far
		extrn	FOLD_MUL_SIGNED:far
		extrn	FOLD_MUL_UNSIGNED:far
		extrn	FOLD_OR_LONG:far
		extrn	FOLD_SHIFT_SIGNED:far
		extrn	FOLD_SHIFT_UNSIGNED:far
		extrn	FOLD_SUB_SIGNED:far
		extrn	FOLD_SUB_UNSIGNED:far
		extrn	FOLD_XOR_LONG:far
		extrn	GET_STRING_LITERAL_SYMBOL:far
		extrn	GET_SYMBOL_KIND:far
		extrn	GET_SYMBOL_OFFSET:far
		extrn	GET_SYMBOL_SEGMENT:far
		extrn	GET_SYMBOL_TYPE:far
		extrn	GET_SYMBOL_WORD_10:far
		extrn	GET_TYPE_FLAGS:far
		extrn	GET_TYPE_FLAGS_ALT:far
		extrn	GET_TYPE_KIND:far
		extrn	GET_TYPE_QUALIFIERS:far
		extrn	INSERT_NODE_MARK_FRAGMENT:far
		extrn	INSERT_OFFSET_MARK_FRAGMENT:far
		extrn	IS_BASED_NEAR_PTR:far
		extrn	IS_BASED_POINTER:far
		extrn	IS_STRING_LITERAL_STORAGE:far
		extrn	KIND_TIMES_10:far
		extrn	MAKE_ADDRESS_OF_TYPED:far
		extrn	NEAR_PTR_SUBKIND:far
		extrn	NEW_BITFIELD_NODE:far
		extrn	NEW_BITFIELD_NODE_ALT:far
		extrn	NEW_CONSTANT_EXPR:far
		extrn	NEW_EXPR_NODE:far
		extrn	NEW_EXPR_NODE_MODE:far
		extrn	NO_REAL_FOLD:far
		extrn	OBJ_NOP:far
		extrn	OBJ_WRITE_FILE_STAMP:far
		extrn	OBJ_WRITE_MODULE:far
		extrn	PARAMETER_COUNT:far
		extrn	PARSE_ASM_JUMP_LABEL:far
		extrn	PARSE_ASM_JUMP_LABEL_ALT:far
		extrn	PARSE_ASM_MEMBER:far
		extrn	PARSE_ASM_MEMBER_ALT:far
		extrn	PARSE_PP_IF_EXPRESSION:far
		extrn	RESERVE_BYTES:far
		extrn	RESERVE_DATA_BYTES:far
		extrn	RESET_EXPR_POOL:far
		extrn	RTL_LDOUBLE_ADD:far
		extrn	RTL_LDOUBLE_DIV:far
		extrn	RTL_LDOUBLE_MUL:far
		extrn	RTL_LDOUBLE_SUB:far
		extrn	SCAN_EMIT:far
		extrn	SCAN_EMPTY:far
		extrn	SELECT_SEGMENT:far
		extrn	SET_STORAGE_ARG_COUNT:far
		extrn	SET_STORAGE_FIRST_WORD:far
		extrn	SET_STORAGE_FLAG_20:far
		extrn	SET_STORAGE_SEGMENT:far
		extrn	SET_STORAGE_SEGMENT_FLAG_8:far
		extrn	SET_SYMBOL_AT_CURRENT_POS:far
		extrn	SET_SYMBOL_FLAG_20:far
		extrn	SET_SYMBOL_OFFSET:far
		extrn	SET_SYMBOL_SEGMENT:far
		extrn	SET_SYMBOL_SEGMENT_FLAGGED:far
		extrn	SET_SYMBOL_WORD_10:far
		extrn	SIZE_OF_TYPE_CHECKED:far
		extrn	STBIN10:far
		extrn	STCVTD:far
		extrn	STORAGE_FIRST_WORD:far
		extrn	STORAGE_INTRINSIC_NUMBER:far
		extrn	STORAGE_SEGMENT:far
		extrn	STORAGE_TYPE_CLASS:far
		extrn	STORAGE_TYPE_SIZE:far
		extrn	STRING_LITERAL_STORAGE:far
		extrn	SYMBOL_CATEGORY:far
		extrn	SYMBOL_ELEMENT_KIND:far
		extrn	SYMBOL_TYPE_OF_STORAGE:far
		extrn	TEMP_STORAGE_FOR_TYPE:far
		extrn	TREE_HAS_SIDE_EFFECTS:far
		extrn	TREE_HAS_SIDE_EFFECTS_ALT:far
		extrn	TYPE_ALIGNMENT:far
		extrn	TYPE_ALIGNMENT_OR_HUGE_PAD:far
		extrn	TYPE_ATTR_BYTE_0B:far
		extrn	TYPE_ATTR_BYTE_0C:far
		extrn	TYPE_CLASS_BYTE:far
		extrn	TYPE_EMIT_FINISH:far
		public	ACTIVE_HEAP
		public	ACTIVE_LIST
		public	ALIGN_OUTPUT_HOOK
		public	ALLOCATABLE_REGISTER_MASK
		public	ALT_HOOK
		public	ARGUMENT_LIST
		public	ARGUMENT_LIST_TAIL
		public	ASM_IDENTIFIER_HOOK
		public	ASM_INSTRUCTION_HOOK
		public	ASM_KEYWORD_COMPARE_FUNC
		public	ASM_KEYWORD_TABLE
		public	ASM_MNEMONIC_FLAGS
		public	ASM_OPERAND_FORMAT_MAP
		public	ASM_OUTPUT_FLAGS
		public	ASM_OUTPUT_PATH
		public	ASM_STATEMENT_BUFFER
		public	ASM_STATEMENT_CURSOR
		public	ASM_STATEMENT_FLAG
		public	ASM_TEXT_DEFAULT_HOOKS
		public	ASM_TOKEN_2F_HOOK
		public	ASM_TRAILER_HOOK
		public	ASM_TYPE_NAME_TABLE
		public	BACKEND_MODE3_TYPE
		public	BACKEND_OUTPUT_BEGUN_FLAG
		public	BACKEND_OWNER_TAG
		public	BACKEND_SPARE_POOL_SEG
		public	BASE_LIST_SEG
		public	BASE_PATH_POOL_SEG
		public	BCC_DEBUG_EMPTY
		public	BCC_DEBUG_NAME
		public	BCC_ENUM_LIMIT_LO
		public	BCC_ENUM_MAX_LO
		public	BCC_ENUM_MIN_LO
		public	BCC_LINE_OFFSET
		public	BCC_LINE_SEGMENT
		public	BCC_PACK_FLAG
		public	BCC_PARSE_BUFFER
		public	BCC_TREE_FLAG
		public	BCC_TREE_LINK
		public	BCC_TREE_SPECIAL
		public	BCC_TYPE_PTR
		public	BEGIN_BACKEND_OUTPUT_HOOK
		public	BINARY_PRECEDENCE_BY_TOKEN
		public	BINARY_PRIORITY_BY_TOKEN
		public	BITFIELD_ALIGN_BITS
		public	BITFIELD_INIT_BITS
		public	BITFIELD_INIT_OFFSET
		public	BITFIELD_INIT_PENDING
		public	BITFIELD_UNIT_BYTES
		public	BLOCK_CLAIMED_REG_MASK
		public	BLOCK_FREE_REGISTER_MASK
		public	BLOCK_JUMP_HOOK
		public	BLOCK_NEST_LEVEL
		public	BLOCK_START_HOOK
		public	BREAK_POLL_COUNTER
		public	BSS_CLASS_NAME
		public	BSS_CLEAR_END
		public	BSS_GROUP_NAME
		public	BSS_SEGMENT_ID
		public	BSS_SEGMENT_NAME
		public	BSS_SEGMENT_SEPARATE
		public	BSS_START
		public	BYTE_HOOK
		public	C13_BIND_BANK
		public	C13_ORDER_BANK
		public	C14_ARGUMENT_CODES
		public	C14_NAME_BUFFER
		public	C14_TYPE_ENCODINGS
		public	C18_OPERATOR_TOKENS
		public	C25_EMPTY_NAME
		public	C26_SCOPE_STACK
		public	C27_STATIC_TEXT
		public	C28_LITERAL_PATCH
		public	C31_BANKS
		public	C31_DEFAULT_DISPATCH
		public	C31_KEYWORD_GROUPS
		public	C31_MEMORY_OPTION
		public	C33_POINTER_QUALIFIERS
		public	C33_TYPE_NAMES
		public	C51_DIGIT_LINK_OPTIONS
		public	C51_DLL_MODEL
		public	C51_DOS_LIBRARIES
		public	C51_SKIP_LINK
		public	C51_T_LINK_OPTIONS
		public	C51_UPPER_LINK_OPTIONS
		public	C51_WINDOWS_LIBRARIES
		public	C51_WINDOWS_RUNTIME
		public	C51_Y_LINK_OPTIONS
		public	C52_BSS_CLASS_OPTION
		public	C52_BSS_GROUP_OPTION
		public	C52_BSS_NAME_OPTION
		public	C52_CODE_CLASS_OPTION
		public	C52_CODE_GROUP_OPTION
		public	C52_CODE_NAME_OPTION
		public	C52_DATA_CLASS_OPTION
		public	C52_DATA_GROUP_OPTION
		public	C52_DATA_NAME_OPTION
		public	C52_DLL_OPTION
		public	C52_FAR_CLASS_OPTION
		public	C52_FAR_GROUP_OPTION
		public	C52_FAR_NAME_OPTION
		public	C52_FAR_SERIAL
		public	C52_MODEL_INFO
		public	C52_MODULE_NAME
		public	C52_MULTITHREAD_OPTION
		public	C52_OS2_OPTION
		public	C53_COMMAND_LINE
		public	C53_CONFIG_FILE
		public	C53_DEFAULT_FILE
		public	C53_OPTION_PATH
		public	C53_VI_OFF
		public	C53_V_OFF
		public	C53_YO_OFF
		public	C56_DATA_MARK
		public	C56_EQU
		public	C56_EXTERN
		public	C56_NEAR
		public	C56_PLUS
		public	C56_PUBLIC
		public	C56_PUBLIC_DLL
		public	C56_STACK_EQU
		public	C56_VERSION_BASE
		public	C56_VERSION_EXTENDED
		public	C56_WORD_MARK
		public	C9_TOKEN_END
		public	C9_TOKEN_NAMES
		public	C9_TYPE_GRID
		public	C9_TYPE_SIZES
		public	CACHE_HEAD
		public	CACHE_POOL
		public	CALL_ARGUMENT_NUMBER
		public	CALL_ARG_SPLIT_COUNT
		public	CALL_ARG_SPLIT_HOOK
		public	CALL_FUNCTION_EXPR
		public	CALL_KIND_HOOK
		public	CASE_ENTRY_POOL_SEG
		public	CASE_ENTRY_POOL_UNIT
		public	CASE_ENTRY_POOL_USED
		public	CHAR_CLASS
		public	CHAR_CLASS_PTR
		public	CHAR_POINTER_TYPE
		public	CHAR_TYPE
		public	CLASS_KEY_TOKEN
		public	CLASS_VTABLE_SIZE
		public	CODEGEN_CALL_CONV
		public	CODEGEN_FUNCTION_FLAGS
		public	CODEGEN_FUNCTION_SYMBOL
		public	CODEGEN_PARAMS_SIZE
		public	CODEGEN_PARAM_LIST
		public	CODEGEN_RETURN_TYPE
		public	CODEGEN_UNUSED_POOL_EIGHT
		public	CODEGEN_UNUSED_POOL_FIVE
		public	CODEGEN_UNUSED_POOL_FOUR
		public	CODEGEN_UNUSED_POOL_NINE
		public	CODEGEN_UNUSED_POOL_ONE
		public	CODEGEN_UNUSED_POOL_SEVEN
		public	CODEGEN_UNUSED_POOL_SIX
		public	CODEGEN_UNUSED_POOL_THREE
		public	CODEGEN_UNUSED_POOL_TWO
		public	CODEGEN_USED_REG_MASK
		public	CODE_BLOCK_LIST_HEAD
		public	CODE_BLOCK_LIST_TAIL
		public	CODE_BYTE_POOL_FREE_LIST
		public	CODE_BYTE_POOL_SEG
		public	CODE_CLASS_NAME
		public	CODE_FRAGMENT_POOL_FREE_LIST
		public	CODE_FRAGMENT_POOL_SEG
		public	CODE_FRAGMENT_POOL_USED
		public	CODE_GROUP_NAME
		public	CODE_NODE_POOL_UNIT
		public	CODE_NODE_POOL_USED
		public	CODE_OPERAND_POOL_SEG
		public	CODE_OPERAND_POOL_UNIT
		public	CODE_OPERAND_POOL_USED
		public	CODE_OP_INFO_TABLE
		public	CODE_OP_NEXT_INDEX
		public	CODE_OP_POOL_SEG
		public	CODE_OP_POOL_UNIT
		public	CODE_OP_POOL_USED
		public	CODE_OUTPUT_FLAGS
		public	CODE_SEGMENT_ID
		public	CODE_SEGMENT_NAME
		public	CODE_UNREACHABLE
		public	COMMAND_OPTION_TABLE
		public	COMMENT_NESTED
		public	COMPARE_NEGATE_TABLE
		public	COMPARE_NEGATION_TABLE
		public	COMPILER_MODE
		public	COMPILER_TABLES_INIT_FLAG
		public	COMPILE_FAILED
		public	COMPILE_FILE_COUNT
		public	CONDITIONAL_ARM_DEPTH
		public	CONDITION_MARK
		public	CONDITION_STATE
		public	CONS_CELL_POOL_SEG
		public	CONTEXT_PTR
		public	CONTEXT_SEG
		public	CONTEXT_SEG_STEP
		public	CONTEXT_SEG_UNIT
		public	CONTEXT_SEG_USED
		public	CONVERSION_FUNC_NAME
		public	CONVERSION_RULES
		public	CPP_BODY_END_LABEL
		public	CPP_MODE
		public	CPU_IS_286
		public	CPU_LEVEL_1_FLAG
		public	CROSS_JUMP_CHANGED
		public	CSYM_POOL_SEG
		public	CTOR_CHECK_THIS_ASSIGN
		public	CTOR_DTOR_MODE
		public	CTOR_NAME
		public	CTOR_THIS_ASSIGNED
		public	CTOR_THIS_SYMBOL
		public	CTRL_BREAK_SEEN
		public	CTYPE_BY_CHAR
		public	CURRENT_BANK_INDEX
		public	CURRENT_CLASS_TYPE
		public	CURRENT_CODE_BLOCK
		public	CURRENT_CODE_FRAGMENT
		public	CURRENT_DATE
		public	CURRENT_DECLARATOR_NAME
		public	CURRENT_FILE_CONTEXT
		public	CURRENT_FILE_NAME
		public	CURRENT_FUNCTION_TYPE
		public	CURRENT_INSN_INDEX
		public	CURRENT_LINE
		public	CURRENT_LINKAGE
		public	CURRENT_LOOP_CONTEXT
		public	CURRENT_OWNER_TAG
		public	CURRENT_SCOPE
		public	CURRENT_SCOPE_BLOCK
		public	CURRENT_SOURCE_FILE
		public	CURRENT_SWITCH
		public	CURRENT_SWITCH_CONTEXT
		public	CURRENT_SYMBOL
		public	CURRENT_TIME
		public	CURRENT_TOKEN
		public	CURRENT_TOKEN_FILE
		public	CURRENT_TOKEN_FLAGS
		public	CURRENT_TOKEN_LINE
		public	CURRENT_TOKEN_LOC_WORD3
		public	CURRENT_TOKEN_RECORD
		public	CURRENT_TOKEN_VALUE
		public	C_CURRENT_FUNCTION_SYMBOL
		public	C_DECLARATOR_NAME
		public	C_DECL_CALL_CONVENTION
		public	C_DECL_DISTANCE
		public	C_DECL_MODIFIERS
		public	C_DECL_SCOPE
		public	C_DECL_SOURCE_FILE
		public	C_DECL_SOURCE_LINE
		public	C_DECL_START_POSITION
		public	C_DECL_START_POSITION_HIGH
		public	C_DECL_STORAGE_CLASS
		public	C_DECL_SYMBOL_FLAGS
		public	C_FRONTEND_HOOK_TABLE
		public	C_FUNCTION_NAME_BUFFER
		public	C_FUNCTION_SCOPE
		public	C_FUNC_DEF_SET_ONLY_FLAG
		public	C_FUNC_START_CLEARED_WORD
		public	C_GLOBAL_SCOPE
		public	C_HELPER_FUNC_TYPE
		public	C_OLD_STYLE_PARAM_LIST
		public	C_PARAM_POOL_SEG
		public	C_STRING_LITERAL_SYMBOL
		public	C_UNNAMED_GLOBAL_LIST
		public	DATA_0702
		public	DATA_0709
		public	DATA_0B94
		public	DATA_0C1F
		public	DATA_0C29
		public	DATA_0C2E
		public	DATA_0C3C
		public	DATA_0C42
		public	DATA_0C51
		public	DATA_0C55
		public	DATA_0C62
		public	DATA_0C67
		public	DATA_0C75
		public	DATA_0C7B
		public	DATA_0C82
		public	DATA_0C8E
		public	DATA_0C93
		public	DATA_0C98
		public	DATA_0C9D
		public	DATA_0CA1
		public	DATA_0CA6
		public	DATA_0CAE
		public	DATA_0CC2
		public	DATA_0CCA
		public	DATA_0CD1
		public	DATA_0E2C
		public	DATA_0E2F
		public	DATA_0E32
		public	DATA_0E34
		public	DATA_0E37
		public	DATA_0E39
		public	DATA_0E3C
		public	DATA_0E3E
		public	DATA_0E41
		public	DATA_0E43
		public	DATA_0E45
		public	DATA_0E47
		public	DATA_0E49
		public	DATA_0E4C
		public	DATA_0E4F
		public	DATA_110A
		public	DATA_1110
		public	DATA_1116
		public	DATA_111C
		public	DATA_14FE
		public	DATA_15C2
		public	DATA_15F2
		public	DATA_164A
		public	DATA_1656
		public	DATA_165E
		public	DATA_16FD
		public	DATA_193E
		public	DATA_195E
		public	DATA_1996
		public	DATA_19C6
		public	DATA_19DE
		public	DATA_19F6
		public	DATA_1A2E
		public	DATA_1A46
		public	DATA_1A76
		public	DATA_1AB6
		public	DATA_1AF6
		public	DATA_1B2E
		public	DATA_1B7E
		public	DATA_1B96
		public	DATA_1BC6
		public	DATA_1C2E
		public	DATA_1C5E
		public	DATA_1CAE
		public	DATA_1CDE
		public	DATA_1CFE
		public	DATA_1CFF
		public	DATA_1D01
		public	DATA_1D02
		public	DATA_1D04
		public	DATA_1D06
		public	DATA_1D08
		public	DATA_1D0A
		public	DATA_1D0C
		public	DATA_1D0E
		public	DATA_1D10
		public	DATA_1D12
		public	DATA_1D15
		public	DATA_1D18
		public	DATA_1D1B
		public	DATA_1D1E
		public	DATA_1D21
		public	DATA_1D24
		public	DATA_1D27
		public	DATA_1D2A
		public	DATA_1D2B
		public	DATA_1D2E
		public	DATA_1D2F
		public	DATA_1D32
		public	DATA_1D34
		public	DATA_1D36
		public	DATA_1D38
		public	DATA_1D3A
		public	DATA_1D3C
		public	DATA_1D3E
		public	DATA_1D40
		public	DATA_1D42
		public	DATA_1D43
		public	DATA_1D45
		public	DATA_1D46
		public	DATA_1D48
		public	DATA_1D4A
		public	DATA_1D4C
		public	DATA_1D4F
		public	DATA_1D52
		public	DATA_1D55
		public	DATA_1D58
		public	DATA_1D5A
		public	DATA_1D5C
		public	DATA_1D5F
		public	DATA_1D62
		public	DATA_1D65
		public	DATA_1D68
		public	DATA_1D6C
		public	DATA_1D6F
		public	DATA_1D75
		public	DATA_1D7C
		public	DATA_1D83
		public	DATA_1D8A
		public	DATA_1D8E
		public	DATA_1D97
		public	DATA_1DA0
		public	DATA_1DA8
		public	DATA_1DB2
		public	DATA_1DB9
		public	DATA_1DBE
		public	DATA_1DC6
		public	DATA_1DCA
		public	DATA_1DCE
		public	DATA_1DD2
		public	DATA_1DD7
		public	DATA_1DDB
		public	DATA_1DDF
		public	DATA_1DE4
		public	DATA_1DEA
		public	DATA_1DF1
		public	DATA_1DF9
		public	DATA_1DFD
		public	DATA_1E02
		public	DATA_1E07
		public	DATA_1E0D
		public	DATA_1E17
		public	DATA_1E22
		public	DATA_1E2A
		public	DATA_1E2F
		public	DATA_1E35
		public	DATA_1E3C
		public	DATA_1E44
		public	DATA_1E4E
		public	DATA_1E54
		public	DATA_1E5B
		public	DATA_1E64
		public	DATA_1E69
		public	DATA_1E6E
		public	DATA_1E73
		public	DATA_1E79
		public	DATA_1E7E
		public	DATA_1E83
		public	DATA_1E8C
		public	DATA_1E94
		public	DATA_1E97
		public	DATA_1E9E
		public	DATA_1EA3
		public	DATA_1EAA
		public	DATA_1EB0
		public	DATA_1EB4
		public	DATA_1EB9
		public	DATA_1EBC
		public	DATA_1EC0
		public	DATA_1EC5
		public	DATA_1ECE
		public	DATA_1ED5
		public	DATA_1EDB
		public	DATA_1EE2
		public	DATA_1EE9
		public	DATA_1EF0
		public	DATA_1EF7
		public	DATA_1EFF
		public	DATA_1F05
		public	DATA_1F0E
		public	DATA_1F8B
		public	DATA_1F91
		public	DATA_1FA0
		public	DATA_1FA6
		public	DATA_1FA9
		public	DATA_1FAF
		public	DATA_1FB6
		public	DATA_1FBB
		public	DATA_1FC0
		public	DATA_1FF8
		public	DATA_1FFD
		public	DATA_2004
		public	DATA_200D
		public	DATA_2014
		public	DATA_201C
		public	DATA_2021
		public	DATA_202A
		public	DATA_2033
		public	DATA_24CF
		public	DATA_24D0
		public	DATA_24D9
		public	DATA_24DB
		public	DATA_2516
		public	DATA_251E
		public	DATA_2525
		public	DATA_252F
		public	DATA_2537
		public	DATA_253F
		public	DATA_2546
		public	DATA_2550
		public	DATA_2558
		public	DATA_255F
		public	DATA_2569
		public	DATA_2571
		public	DATA_2578
		public	DATA_2582
		public	DATA_258A
		public	DATA_2591
		public	DATA_259B
		public	DATA_25A4
		public	DATA_25AD
		public	DATA_25B6
		public	DATA_25BF
		public	DATA_25C8
		public	DATA_25D1
		public	DATA_25DA
		public	DATA_25E3
		public	DATA_25EC
		public	DATA_25F5
		public	DATA_25FE
		public	DATA_2607
		public	DATA_2611
		public	DATA_261B
		public	DATA_2625
		public	DATA_262F
		public	DATA_2639
		public	DATA_2642
		public	DATA_2852
		public	DATA_285B
		public	DATA_2865
		public	DATA_2870
		public	DATA_287C
		public	DATA_2886
		public	DATA_288F
		public	DATA_2893
		public	DATA_2897
		public	DATA_289B
		public	DATA_289F
		public	DATA_28A3
		public	DATA_28A7
		public	DATA_28AB
		public	DATA_28AF
		public	DATA_28B3
		public	DATA_28B7
		public	DATA_28BB
		public	DATA_28BF
		public	DATA_28C3
		public	DATA_28C7
		public	DATA_28CB
		public	DATA_28CF
		public	DATA_28D3
		public	DATA_28D7
		public	DATA_28DB
		public	DATA_28DF
		public	DATA_2E86
		public	DATA_2E88
		public	DATA_2E8C
		public	DATA_2E90
		public	DATA_2E94
		public	DATA_2E98
		public	DATA_2E9C
		public	DATA_2E9D
		public	DATA_2EA0
		public	DATA_2EA3
		public	DATA_2EA6
		public	DATA_2EAA
		public	DATA_2EAF
		public	DATA_2EB2
		public	DATA_2EB5
		public	DATA_2EB8
		public	DATA_2EBE
		public	DATA_2EC1
		public	DATA_2EC4
		public	DATA_2EC9
		public	DATA_2ECD
		public	DATA_2ED0
		public	DATA_2ED3
		public	DATA_2ED7
		public	DATA_2EDB
		public	DATA_2EDF
		public	DATA_2EE3
		public	DATA_2EE7
		public	DATA_2EEC
		public	DATA_2EF2
		public	DATA_2EF8
		public	DATA_2EFB
		public	DATA_2EFF
		public	DATA_2F02
		public	DATA_2F06
		public	DATA_2F0A
		public	DATA_2F0D
		public	DATA_2F11
		public	DATA_2F14
		public	DATA_2F17
		public	DATA_2F1B
		public	DATA_2F1E
		public	DATA_2F21
		public	DATA_2F24
		public	DATA_2F25
		public	DATA_2F2A
		public	DATA_2F2D
		public	DATA_2F33
		public	DATA_2F36
		public	DATA_2F3C
		public	DATA_2F42
		public	DATA_2F47
		public	DATA_2F4C
		public	DATA_2F52
		public	DATA_2F56
		public	DATA_2F5B
		public	DATA_2F61
		public	DATA_2F66
		public	DATA_2F6C
		public	DATA_2F71
		public	DATA_2F77
		public	DATA_2F7E
		public	DATA_2F86
		public	DATA_2F89
		public	DATA_2F8C
		public	DATA_2F91
		public	DATA_2F97
		public	DATA_2F9D
		public	DATA_2FA4
		public	DATA_2FA9
		public	DATA_2FAF
		public	DATA_2FB5
		public	DATA_2FBB
		public	DATA_2FC2
		public	DATA_2FC3
		public	DATA_2FC8
		public	DATA_2FCF
		public	DATA_2FD4
		public	DATA_2FD5
		public	DATA_2FD6
		public	DATA_2FDA
		public	DATA_2FE2
		public	DATA_2FE8
		public	DATA_2FED
		public	DATA_2FF3
		public	DATA_2FF5
		public	DATA_2FF9
		public	DATA_3000
		public	DATA_3004
		public	DATA_3009
		public	DATA_300F
		public	DATA_3016
		public	DATA_301D
		public	DATA_3024
		public	DATA_302B
		public	DATA_3032
		public	DATA_3038
		public	DATA_303D
		public	DATA_3042
		public	DATA_3048
		public	DATA_304F
		public	DATA_3056
		public	DATA_305C
		public	DATA_3063
		public	DATA_3064
		public	DATA_3068
		public	DATA_306F
		public	DATA_3076
		public	DATA_307E
		public	DATA_3085
		public	DATA_308C
		public	DATA_3092
		public	DATA_3098
		public	DATA_309C
		public	DATA_30A0
		public	DATA_30A4
		public	DATA_30A7
		public	DATA_30AD
		public	DATA_30B4
		public	DATA_30BA
		public	DATA_30BE
		public	DATA_30C4
		public	DATA_30CB
		public	DATA_30D0
		public	DATA_30D6
		public	DATA_30DB
		public	DATA_30E1
		public	DATA_30E7
		public	DATA_30EE
		public	DATA_30F3
		public	DATA_30F4
		public	DATA_30F9
		public	DATA_30FE
		public	DATA_3103
		public	DATA_310B
		public	DATA_3111
		public	DATA_3119
		public	DATA_311D
		public	DATA_3120
		public	DATA_3124
		public	DATA_3128
		public	DATA_312D
		public	DATA_3132
		public	DATA_3137
		public	DATA_3138
		public	DATA_313C
		public	DATA_313F
		public	DATA_3143
		public	DATA_3146
		public	DATA_314A
		public	DATA_314D
		public	DATA_3152
		public	DATA_3155
		public	DATA_3158
		public	DATA_315C
		public	DATA_315F
		public	DATA_3163
		public	DATA_3167
		public	DATA_316B
		public	DATA_3170
		public	DATA_3174
		public	DATA_3179
		public	DATA_317D
		public	DATA_3181
		public	DATA_3185
		public	DATA_318A
		public	DATA_318E
		public	DATA_3193
		public	DATA_3197
		public	DATA_319B
		public	DATA_319F
		public	DATA_31A3
		public	DATA_31A6
		public	DATA_31A9
		public	DATA_31AD
		public	DATA_31B1
		public	DATA_31B4
		public	DATA_31B7
		public	DATA_31BC
		public	DATA_31C0
		public	DATA_31C4
		public	DATA_31C8
		public	DATA_31CE
		public	DATA_31D2
		public	DATA_31D7
		public	DATA_31DC
		public	DATA_31E2
		public	DATA_31E8
		public	DATA_31ED
		public	DATA_31F3
		public	DATA_31FA
		public	DATA_3201
		public	DATA_3207
		public	DATA_320B
		public	DATA_320F
		public	DATA_3214
		public	DATA_321A
		public	DATA_3220
		public	DATA_3225
		public	DATA_3229
		public	DATA_322D
		public	DATA_3231
		public	DATA_3236
		public	DATA_323C
		public	DATA_3242
		public	DATA_3246
		public	DATA_324B
		public	DATA_3250
		public	DATA_3254
		public	DATA_3259
		public	DATA_325F
		public	DATA_3265
		public	DATA_3269
		public	DATA_326D
		public	DATA_3271
		public	DATA_3276
		public	DATA_327C
		public	DATA_3282
		public	DATA_3287
		public	DATA_328B
		public	DATA_328F
		public	DATA_3294
		public	DATA_3298
		public	DATA_329C
		public	DATA_32A0
		public	DATA_32A5
		public	DATA_32AB
		public	DATA_32B1
		public	DATA_32B5
		public	DATA_32BB
		public	DATA_32BF
		public	DATA_32C4
		public	DATA_32C7
		public	DATA_32CA
		public	DATA_32CE
		public	DATA_32D2
		public	DATA_32D6
		public	DATA_32DB
		public	DATA_32E1
		public	DATA_32E7
		public	DATA_32EC
		public	DATA_32F1
		public	DATA_32F6
		public	DATA_32FB
		public	DATA_3300
		public	DATA_3460
		public	DATA_3467
		public	DATA_346F
		public	DATA_3476
		public	DATA_3479
		public	DATA_347F
		public	DATA_3486
		public	DATA_348B
		public	DATA_3490
		public	DATA_37F6
		public	DATA_37FD
		public	DATA_3804
		public	DATA_3809
		public	DATA_5050
		public	DATA_5051
		public	DATA_5054
		public	DATA_5059
		public	DATA_505D
		public	DATA_5061
		public	DATA_5066
		public	DATA_506C
		public	DATA_5070
		public	DATA_5075
		public	DATA_507A
		public	DATA_507B
		public	DATA_507F
		public	DATA_5084
		public	DATA_508A
		public	DATA_508E
		public	DATA_5092
		public	DATA_5096
		public	DATA_509A
		public	DATA_509D
		public	DATA_50A1
		public	DATA_50A5
		public	DATA_50AA
		public	DATA_50AE
		public	DATA_50B2
		public	DATA_50B6
		public	DATA_50BC
		public	DATA_50C0
		public	DATA_50C4
		public	DATA_50C9
		public	DATA_50CF
		public	DATA_50D4
		public	DATA_50D8
		public	DATA_50DC
		public	DATA_50E1
		public	DATA_50E5
		public	DATA_50E8
		public	DATA_50EC
		public	DATA_50F2
		public	DATA_50F7
		public	DATA_50FC
		public	DATA_50FF
		public	DATA_5102
		public	DATA_5108
		public	DATA_510C
		public	DATA_5110
		public	DATA_5116
		public	DATA_511B
		public	DATA_5120
		public	DATA_5125
		public	DATA_512A
		public	DATA_5130
		public	DATA_5137
		public	DATA_513D
		public	DATA_514B
		public	DATA_5159
		public	DATA_515F
		public	DATA_5164
		public	DATA_5168
		public	DATA_516C
		public	DATA_5170
		public	DATA_5175
		public	DATA_5179
		public	DATA_517E
		public	DATA_5182
		public	DATA_5186
		public	DATA_518B
		public	DATA_5190
		public	DATA_5194
		public	DATA_5198
		public	DATA_519C
		public	DATA_51A1
		public	DATA_51A7
		public	DATA_51AD
		public	DATA_51B3
		public	DATA_51B9
		public	DATA_51BF
		public	DATA_51C5
		public	DATA_51CB
		public	DATA_51CF
		public	DATA_51D3
		public	DATA_51D7
		public	DATA_51DB
		public	DATA_528B
		public	DATA_5292
		public	DATA_5298
		public	DATA_529F
		public	DATA_52A5
		public	DATA_52AC
		public	DATA_52B3
		public	DATA_52BA
		public	DATA_53B0
		public	DATA_53B4
		public	DATA_53B7
		public	DATA_53BA
		public	DATA_53BD
		public	DATA_53C0
		public	DATA_53C4
		public	DATA_53C8
		public	DATA_53CC
		public	DATA_53D0
		public	DATA_53D3
		public	DATA_53D7
		public	DATA_53DA
		public	DATA_53DE
		public	DATA_53E1
		public	DATA_53E5
		public	DATA_53E8
		public	DATA_53EC
		public	DATA_53EF
		public	DATA_53F3
		public	DATA_53F9
		public	DATA_5400
		public	DATA_5405
		public	DATA_54E7
		public	DATA_54EE
		public	DATA_54F5
		public	DATA_54FC
		public	DATA_5503
		public	DATA_550A
		public	DATA_5511
		public	DATA_5518
		public	DATA_551F
		public	DATA_597A
		public	DATA_5984
		public	DATA_598A
		public	DATA_5A78
		public	DATA_5A80
		public	DATA_5A88
		public	DATA_5A95
		public	DATA_5AA1
		public	DATA_5AAE
		public	DATA_7856
		public	DATA_785E
		public	DATA_7866
		public	DATA_786E
		public	DATA_7876
		public	DATA_787E
		public	DATA_7886
		public	DATA_82D4
		public	DATA_BSS_GROUPS_DIFFER
		public	DATA_BYTE_POOL_LENGTH
		public	DATA_BYTE_POOL_SEG
		public	DATA_BYTE_POOL_WORD6
		public	DATA_CLASS_NAME
		public	DATA_GROUP_NAME
		public	DATA_SEGMENT_ID
		public	DATA_SEGMENT_NAME
		public	DEBUG_CLASS_INDEX_NEXT
		public	DEBUG_HEADER_DONE_HOOK
		public	DEBUG_MEMBER_COUNTER
		public	DEBUG_MORE
		public	DEBUG_NODE_PREFIX
		public	DEBUG_PREFIX
		public	DEBUG_STATE
		public	DEBUG_SUFFIX
		public	DEBUG_TYPE_COUNTER
		public	DECAY_TO_POINTER_HOOK
		public	DECLARATOR_NAME
		public	DECLARATOR_NAME_FILE
		public	DECLARATOR_NAME_LINE
		public	DECLARATOR_NAME_TOKEN
		public	DECLARATOR_NODE_POOL_SEG
		public	DECLARE_NAMED_GLOBAL_HOOK
		public	DECL_INIT_SERIAL
		public	DEFAULT_CALL_CONVENTION
		public	DEFAULT_CODE_SEGMENT_ID
		public	DEFAULT_SOURCE_EXT
		public	DEFINE_LIST_HEAD
		public	DEFINE_LIST_TAIL
		public	DEFINE_NODE_LABEL_HOOK
		public	DEFINE_SYMBOL_HERE_HOOK
		public	DELETE_OPERATOR_SYMBOL
		public	DESTRUCTOR_ENTRY_SERIAL
		public	DIAGNOSTIC_COUNT
		public	DIAG_FUNC_NAME_HIGH
		public	DIAG_NAME_BUFFER
		public	DIRECTIVE_MODE
		public	DIRECTIVE_TABLE
		public	DISCARD_CHAR_EMIT_FN
		public	DISPATCH_NUMBER
		public	DISPATCH_NUMBER_GIVEN
		public	DOS_HOST_MODE
		public	DOUBLED_CHAR_TOKEN_TABLE
		public	DOUBLE_TYPE
		public	DOUBLE_TYPE_SIZE
		public	DTOR_NAME
		public	DUPLICATE_TYPE_FREE_LIST
		public	ECHO_NEXT_LINE
		public	EMIT_DEPENDENCY_HOOK
		public	EMIT_INSTRUCTION_HOOK
		public	EMIT_INTRINSIC_SYMBOL
		public	EMIT_LABEL_WORD_HOOK
		public	EMIT_LIMIT
		public	EMIT_LOAD_DGROUP_HOOK
		public	EMIT_LOCALS_DEBUG_HOOK
		public	EMIT_OP_76_HOOK
		public	EMIT_OP_AF_HOOK
		public	EMIT_OP_B0_HOOK
		public	EMIT_THIS_ADJUST_THUNK_HOOK
		public	EMS_PAGE_LIMIT
		public	ENCLOSING_STATEMENT_KIND
		public	END_OF_INPUT_SEEN
		public	ENUMS_AS_INT_FLAG
		public	ENUM_BODY_TREE_FLAG
		public	ENVIRONMENT_SEG
		public	ENV_BUFFER
		public	EOF_BUFFER_TEXT
		public	EPILOGUE_DONE_HOOK
		public	ERRNO
		public	ERROR_COUNT
		public	ERROR_JUMP_BUFFER
		public	EVAL_EXPRESSION
		public	EVAL_STACK_MAX
		public	EVAL_STACK_SPILLED
		public	EVAL_STACK_TEMP_NODES
		public	EVAL_STACK_TOP
		public	EVAL_STACK_VALUES
		public	EXPAND_COMPOUND_ASSIGN_HOOK
		public	EXPAND_INC_DEC_HOOK
		public	EXPAND_INLINES_FLAG
		public	EXPR_CURRENT2
		public	EXPR_FLAGS
		public	EXPR_NARROW_SHAPE
		public	EXPR_OFFSET2
		public	EXPR_OP_FLAGS
		public	EXPR_OP_HAS_EFFECT
		public	EXPR_POOL_SEG
		public	EXPR_POOL_UNIT
		public	EXPR_POOL_USED
		public	EXPR_RETYPE_SHAPE
		public	EXPR_START_FLAG_MASK
		public	EXPR_TEMP2
		public	EXTENDER_BASE
		public	EXTENDER_HEAP_TOP
		public	EXT_MEMORY_BANK_SIZE
		public	EXT_MEMORY_BASE
		public	FAR_CHAR_POINTER_TYPE
		public	FAR_DATA_THRESHOLD
		public	FAR_PURE_ERROR_SYMBOL
		public	FAR_SEGMENT_COUNT
		public	FAR_VOID_PTR_TYPE
		public	FAR_VTABLE_ENTRY_PTR_TYPE
		public	FILE_INIT_EXPR_QUEUE
		public	FINISH_COMPILATION_HOOK
		public	FINISH_OUTPUT_HOOK
		public	FIRST_ASM_OPERAND
		public	FIRST_OPERAND_INDEX_REG
		public	FIRST_OPERAND_REG
		public	FIRST_OPERAND_SEG_REG
		public	FIRST_OPERAND_VALUE
		public	FIXUP_CODE_TABLE
		public	FLAG_HOOK
		public	FLOW_BLOCK_POOL_SEG
		public	FNBODY_CLEARED_WORD_A
		public	FNBODY_CLEARED_WORD_B
		public	FNBODY_WORD_A
		public	FNBODY_WORD_A_SAVE
		public	FNBODY_WORD_B
		public	FNBODY_WORD_B_SAVE
		public	FOLD_ADD_SIGNED_FN
		public	FOLD_ADD_UNSIGNED_FN
		public	FOLD_AND_LONG_FN
		public	FOLD_DIV_SIGNED_FN
		public	FOLD_DIV_UNSIGNED_FN
		public	FOLD_MOD_SIGNED_FN
		public	FOLD_MOD_UNSIGNED_FN
		public	FOLD_MUL_SIGNED_FN
		public	FOLD_MUL_UNSIGNED_FN
		public	FOLD_OR_LONG_FN
		public	FOLD_SHIFT_SIGNED_FN
		public	FOLD_SHIFT_UNSIGNED_FN
		public	FOLD_SUB_SIGNED_FN
		public	FOLD_SUB_UNSIGNED_FN
		public	FOLD_XOR_LONG_FN
		public	FORMAL_POOL_SEG
		public	FOR_STEP_CLEARED_FLAG
		public	FRAME_HEADER_SIZE
		public	FRAME_LOCALS_SIZE
		public	FRAME_PUSHED_REG_BYTES
		public	FRAME_SYMBOL_MARK_HOOK
		public	FREE_MACRO_CONTEXT_LIST
		public	FUNCTION_BODY_DEPTH
		public	FUNCTION_CLAIMED_REG_MASK
		public	FUNCTION_CODE_SEGMENT
		public	FUNCTION_DEF_LINE
		public	FUNCTION_DEF_POSITION
		public	FUNCTION_NAME_TEXT
		public	FUNCTION_OUTER_SCOPE_BLOCK
		public	FUNCTION_RETURN_LABEL
		public	FUNCTION_SERIAL
		public	FUNCTION_SOURCE_FILE
		public	FUNCTION_SOURCE_POS_HIGH
		public	FUNCTION_SOURCE_POS_LOW
		public	FUNCTION_START_LINE
		public	FUNC_START_CLEARED_WORD
		public	GET_SYMBOL_KIND_HOOK
		public	GET_SYMBOL_SEGMENT_HOOK
		public	GET_SYMBOL_VARIABLE_HOOK
		public	GET_TYPE_FLAGS_ALT_HOOK
		public	GET_TYPE_KIND_HOOK
		public	GLOBAL_SCOPE
		public	GLOBAL_SCOPE_NAMES
		public	GLOBAL_SCOPE_TAGS
		public	GROUP_COUNT
		public	GROUP_LIST_HEAD
		public	GROUP_LIST_TAIL
		public	HANDLE_RING_NEWEST
		public	HANDLE_RING_NODES
		public	HANDLE_RING_TAG_CURSOR
		public	HANDLE_RING_UNTAG_CURSOR
		public	HASH_CHAIN_LINK_SEG
		public	HEAP_CPU_TYPE
		public	HEAP_DEFAULT_OWNER_TAG
		public	HEAP_DESCRIPTOR_SEGMENTS
		public	HEAP_END_SEG
		public	HEAP_HOOK_CALLSITE
		public	HEAP_RESERVE_BYTES
		public	HEAP_SAVED_TOP_KEY
		public	HEAP_SIZE_PARAS
		public	HEAP_START_SEG
		public	HEAP_STATUS
		public	HIDDEN_RETURN_PARAM_NAME
		public	HIDDEN_RETURN_PARAM_RECORD
		public	HISTORY_END_OFFSET
		public	HUGE_PTR_AHSHIFT_MODE
		public	IMPLICIT_FUNCTION_TYPE
		public	IMPLICIT_FUNC_PTR_TYPE
		public	IMPLICIT_FUNC_TYPE
		public	INCLUDE_DIR_LIST
		public	INCLUDE_OPTION_TEXT_PTR
		public	INITIAL_TYPE_POOL_IMAGE
		public	INIT_OPTION
		public	INIT_RECORD_POOL_SEG
		public	INLINE_BODY_QUEUE
		public	INLINE_EXPANSION_DEPTH
		public	INLINE_FUNCTION_STACK
		public	INLINE_OPTION_BLOCK_FLAG
		public	INLINE_TOKEN_STREAM
		public	INPUT_ACTIVE
		public	INPUT_BUFFER
		public	INPUT_FILE_POS
		public	INPUT_INDEX
		public	INPUT_LIMIT
		public	INPUT_UNGET_CHAR
		public	INPUT_UNGET_FLAG
		public	INSN_57_PENDING
		public	INSN_9C_DEFERRED
		public	INSN_9C_DEFERRED_OPERAND
		public	INTEGRAL_PROMOTION_KIND
		public	INTRINSIC_TABLE
		public	INT_FAR_FUNC_PTR_TYPE
		public	INT_FAR_FUNC_TYPE
		public	INT_LIMIT
		public	INT_NEAR_FUNC_PTR_TYPE
		public	INT_NEAR_FUNC_TYPE
		public	INT_TYPE
		public	INT_TYPE_SIZE
		public	INVERTED_JUMP_KIND
		public	INVERT_COMPARE_TABLE
		public	IN_ERROR_RECOVERY
		public	IS_BASED_POINTER_HOOK
		public	JUMP_CONDITION_INVERSE_TABLE
		public	JUMP_KIND_REMAP_TABLE
		public	JUMP_MNEMONIC_TEXT
		public	JUMP_OPCODE_BYTE
		public	JUMP_OPT_CHANGED
		public	JUMP_OPT_KEEP_EMPTY_BLOCKS
		public	KIND_INFO_TABLE
		public	KIND_SIZE_TABLE
		public	LABEL_LIST_HEAD
		public	LABEL_POOL_SEG
		public	LANGUAGE_MODE
		public	LAST_LINE_MARK_ID
		public	LEAF_OPCODE_KIND_OFFSET
		public	LEVEL_ASSOCIATIVITY
		public	LEXER_INIT_CLEARED_WORD
		public	LEX_FILE_SERIAL_NODE
		public	LEX_READ_MODE0_CLASSES
		public	LEX_READ_MODE1_CLASSES
		public	LINE_MARK_LAST_FILE
		public	LINE_NUMBER_HOOK
		public	LINE_NUMBER_POOL_SEG
		public	LINE_NUMBER_POOL_USED
		public	LINE_POOL
		public	LINE_POOL_STEP
		public	LINE_RECORD
		public	LINKAGE_STACK
		public	LINKAGE_STACK_POOL_SEG
		public	LINKER_SWITCH_FLAGS
		public	LINKER_T_SWITCH_FLAGS
		public	LINKER_Y_SWITCH_FLAGS
		public	LINK_LIBRARY_ARG_SEEN
		public	LINK_OUTPUT_NAME
		public	LIST_CELL_POOL_SEG
		public	LITERAL_CHAR_EMIT_PTR
		public	LIVE_VALUE_END
		public	LIVE_VALUE_POOL_FREE_LIST
		public	LIVE_VALUE_POOL_SEG
		public	LIVE_VALUE_POOL_USED
		public	LIVE_VALUE_SPILL_END
		public	LOCAL_INIT_EXPR_LIST
		public	LOCAL_LABEL_SERIAL
		public	LOGICAL_LINE
		public	LONG_MAX_VALUE
		public	LONG_MIN_DIGITS
		public	LONG_TYPE
		public	LOOP_BLOCK_WEIGHT
		public	LOOP_BREAK_SCOPE
		public	LOOP_CONTEXT
		public	LOOP_NEST_FACTOR
		public	MACRO_EXPANSION_DEPTH
		public	MACRO_MARK_FC_PENDING
		public	MACRO_MARK_FE_SEEN
		public	MACRO_MODE
		public	MACRO_NAME_UNEXPANDED
		public	MACRO_SNAPSHOT_POOL_CAPACITY
		public	MACRO_SNAPSHOT_POOL_FREE
		public	MACRO_SNAPSHOT_POOL_SEG
		public	MACRO_SNAPSHOT_POOL_USED
		public	MAIN_SYMBOL
		public	MALLOC_POOL_LENGTH
		public	MALLOC_POOL_LENGTH_MARK
		public	MALLOC_POOL_SEG
		public	MALLOC_POOL_WORD6
		public	MASK_B
		public	MASK_C
		public	MEMBER_CACHE_MEMBERS
		public	MEMBER_CACHE_NAMES
		public	MEMBER_CACHE_TYPES
		public	MEMBER_DECL_ATTRIBUTES
		public	MEMBER_DECL_FRIEND
		public	MEMBER_DECL_TYPE_NAMED
		public	MEMBER_FLAG_200_SWITCH
		public	MEMBER_INIT_EXPR
		public	MEMBER_PTR_CLASS_TYPE
		public	MEMBER_PTR_DELTA_MEMBER
		public	MEMBER_PTR_FAR_FUNC_MEMBER
		public	MEMBER_PTR_NEAR_FUNC_MEMBER
		public	MEMBER_PTR_OFFSET_MEMBER
		public	MEMBER_PTR_PAD_MEMBER
		public	MEMBER_PTR_VINDEX_MEMBER
		public	MEMBER_QUALIFIER_CLASS
		public	MEMBER_RECORD_SIZE
		public	MEMBER_SEGMENT
		public	MIN_FREE_HEAP
		public	MIRROR_COMPARE_TABLE
		public	MODEL_FAR_CODE
		public	MODEL_FAR_DATA
		public	MODE_HOOK
		public	MONTH_ABBREVIATIONS
		public	NAME_A1
		public	NAME_A2
		public	NAME_B1
		public	NAME_B2
		public	NAME_BUFFER
		public	NAME_HASH_TABLE
		public	NAME_HOOK
		public	NAME_LIMIT
		public	NAME_POOL_SEG
		public	NAME_TABLE_END
		public	NEAR_HELPER_CALLS
		public	NEAR_PURE_ERROR_SYMBOL
		public	NEW_BITFIELD_NODE_HOOK
		public	NEW_CONST_NODE_HOOK
		public	NEW_EXPR_NODE_HOOK
		public	NEW_OPERATOR_SYMBOL
		public	NEW_SYMBOL_NODE_HOOK
		public	NEW_TEMPORARY_HOOK
		public	NODE_COUNT
		public	NODE_SERIAL_COUNTER
		public	NON_CPP_CLEARED_WORD_A
		public	NON_CPP_CLEARED_WORD_B
		public	NOT_ANSI_FLAG
		public	NO_ERRORS_YET
		public	NO_REAL_FOLD_FN
		public	NO_SOURCE_LOCATION
		public	NO_THIS_PARAMETER
		public	OBJ_EXTERN_INDEX
		public	OBJ_FRAGMENT_LABEL_HOOK
		public	OBJ_FRAGMENT_NODE_HOOK
		public	OBJ_OUTPUT_DEFAULT_HOOKS
		public	OBJ_RECORD_CHECKSUM
		public	OBJ_RECORD_CURSOR
		public	OBJ_RECORD_HOOK
		public	OBJ_WRITE_MODULE_HOOK
		public	OPCODE_DESCRIPTOR_TABLE
		public	OPCODE_DESC_BYTE8
		public	OPERAND_BASE_BY_KIND
		public	OPERAND_KIND_MASK
		public	OPERAND_KIND_MESSAGE
		public	OPERAND_LIST_BASE
		public	OPERAND_LIST_HEAD
		public	OPERATOR_BY_TOKEN
		public	OPERATOR_DELETE_NAME
		public	OPERATOR_HELPER_NAME_TABLE
		public	OPERATOR_NEW_NAME
		public	OPERATOR_RULES
		public	OPERATOR_STACK_DEPTH
		public	OPERATOR_STACK_OFFSET
		public	OPERATOR_STACK_POOL
		public	OPER_OPCODE_KIND_OFFSET
		public	OPTIMIZE_ENABLED
		public	OPTION_AUTO_FAR_DATA
		public	OPTION_BLOCK
		public	OPTION_CALLING_CONVENTION
		public	OPTION_COMDEFS
		public	OPTION_COMPILE_VIA_ASM
		public	OPTION_DS_NOT_SS
		public	OPTION_ENUMS_AS_INT
		public	OPTION_ERROR_LIMIT
		public	OPTION_EXPAND_INLINES
		public	OPTION_FAST_FLOAT
		public	OPTION_FLAG
		public	OPTION_FLAGS
		public	OPTION_FLOAT_MODE
		public	OPTION_LINE_NUMBERS
		public	OPTION_LINK_OVERLAY
		public	OPTION_MEMORY_MODEL
		public	OPTION_MERGE_STRINGS
		public	OPTION_NO_AUTODEPEND
		public	OPTION_OBJECT_NAME
		public	OPTION_OPTIMIZE_SPEED
		public	OPTION_OUTPUT_DIR
		public	OPTION_OVERLAY_CODE
		public	OPTION_REGISTER_VARS
		public	OPTION_SOURCE_DEBUG
		public	OPTION_SS_EQUALS_DS
		public	OPTION_STACK_CHECK
		public	OPTION_STANDARD_FRAME
		public	OPTION_SUPPRESS_RELOADS
		public	OPTION_TARGET_CPU
		public	OPTION_UNDERSCORES
		public	OPTION_WARNING_LIMIT
		public	OPTION_WINDOWS_MODE
		public	OPT_TEXT_V
		public	OPT_TEXT_VI
		public	OPT_TEXT_YO
		public	OP_ASSIGN_TOKEN_TABLE
		public	OUTER_SCOPE_EXIT_VALUE
		public	OUTPUT_BUFFER_FILL
		public	OUTPUT_BUFFER_LIMIT
		public	OUTPUT_BUFFER_POS
		public	OUTPUT_BUFFER_SEG
		public	OUTPUT_FILE_HANDLE
		public	OVERLAY_DATA_SIZE
		public	OWNER_TAG_BITMAP
		public	PACKED_EXPR_POOL_SEG
		public	PACKED_INIT_EXPR
		public	PARAM_FRAME_BASE
		public	PARAM_LIST_DEPTH
		public	PARAM_LIST_KIND
		public	PARAM_NAME
		public	PARAM_SCOPE_MARK
		public	PARAM_SCOPE_MARK_AUX
		public	PARSER_INIT_MARK_A5
		public	PARSER_RESET_BYTE_A
		public	PARSER_RESET_BYTE_B
		public	PARSE_CLASS
		public	PARSE_FLAG2
		public	PCH_COLLECT_DEPENDENCIES
		public	PCH_DEPENDENCY_HEAD
		public	PCH_DEPENDENCY_POOL_CAPACITY
		public	PCH_DEPENDENCY_POOL_FREE
		public	PCH_DEPENDENCY_POOL_SEG
		public	PCH_DEPENDENCY_POOL_USED
		public	PCH_DEPENDENCY_TAIL
		public	PCH_DIAGNOSTIC_ISSUED
		public	PCH_FILE_HANDLE
		public	PCH_FILE_MAGIC
		public	PCH_FILE_NAME
		public	PCH_HEADER_VERSION
		public	PCH_INDEX_FILE_OFFSET
		public	PCH_INDEX_FILE_SIZE
		public	PCH_INDEX_POOL_CAPACITY
		public	PCH_INDEX_POOL_FREE
		public	PCH_INDEX_POOL_SEG
		public	PCH_INDEX_POOL_USED
		public	PCH_OPTION_FLAG_PTRS
		public	PCH_OPTION_MODE
		public	PCH_SAVE_PENDING
		public	PEEPHOLE_MEMORY_STORE_STAMP
		public	PEEPHOLE_STORE_STAMP
		public	PENDING_DEFINITION_LIST
		public	PENDING_EXTERN_RECORD_TYPE
		public	PENDING_GOTO_LIST
		public	PENDING_INIT_LIST
		public	PENDING_POOL
		public	PENDING_REGISTER_MASK
		public	PENDING_REQUESTS
		public	PENDING_REQUEST_COUNT
		public	PENDING_RESULT_REGISTER
		public	PENDING_STRING_TEXT
		public	PLAIN_CHAR_KIND
		public	PLAIN_CHAR_TYPE
		public	PLAIN_INT_TYPE
		public	POINTER_TEXT
		public	POOLED_NODE_STACK
		public	POOLED_NODE_TOP
		public	POOL_A
		public	POOL_A_STEP
		public	POOL_A_UNIT
		public	POOL_A_USED
		public	POOL_BANK_TABLE
		public	POOL_E
		public	POOL_E_STEP
		public	POOL_E_UNIT
		public	POOL_E_USED
		public	POOL_F
		public	POOL_F_STEP
		public	POOL_F_UNIT
		public	POOL_F_USED
		public	POOL_HASH
		public	POST_TO_ASSIGN_OP
		public	POW10_LARGE
		public	POW10_SMALL
		public	PRAGMA_ARGSUSED_PENDING
		public	PRAGMA_CODESEG_SEEN
		public	PRAGMA_FUNC_LOOKUP_HOOK
		public	PRAGMA_NORETVAL_PENDING
		public	PRAGMA_SAVEREGS_PENDING
		public	PRAGMA_TABLE
		public	PREAMBLE_DIRECTIVE_TABLE
		public	PREAMBLE_IF_DEPTH
		public	PREAMBLE_LIST_HEAD
		public	PREAMBLE_LIST_TAIL
		public	PREAMBLE_MISMATCH_NODE
		public	PREAMBLE_POOL_CAPACITY
		public	PREAMBLE_POOL_FREE_LIST
		public	PREAMBLE_POOL_SEG
		public	PREAMBLE_POOL_USED
		public	PREAMBLE_PUSHBACK_BUFFER
		public	PREAMBLE_REMAINDER_NODE
		public	PREAMBLE_REPLAY_NODE
		public	PREDEFINED_1
		public	PRED_NAME_1
		public	PRED_NAME_2
		public	PRED_NAME_3
		public	PRED_NAME_4
		public	PRED_NAME_5
		public	PRED_NAME_6
		public	PREFIX_PRECEDENCE_BY_TOKEN
		public	PROGRAM_PSP
		public	PSEUDO_REGISTER_TABLE
		public	PSEUDO_REG_BP_SYMBOL
		public	PSEUDO_REG_SP_SYMBOL
		public	PTRDIFF_TYPE
		public	QUEUED_WORD_POOL_FREE
		public	QUEUED_WORD_POOL_SEG
		public	QUEUED_WORD_POOL_USED
		public	REAL_ADD_FN
		public	REAL_DIV_FN
		public	REAL_MINUS_ONE
		public	REAL_MUL_FN
		public	REAL_ONE
		public	REAL_SUB_FN
		public	REAL_ZERO
		public	RECORDING_TOKENS
		public	REGALLOC_SCOPE_NODE
		public	REGISTER_ENCODING_TABLE
		public	REGISTER_HISTORY_CURSOR
		public	REGISTER_MASK_TABLE
		public	REGISTER_NEED_TABLE
		public	REGVAR_ASSIGNED_HOOK
		public	REG_CLASS_IS_WORD
		public	REG_CLASS_MASK_TABLE
		public	REG_HISTORY_POOL_FREE_LIST
		public	REG_HISTORY_POOL_SEG
		public	REG_MASK_BX_SI_DI
		public	REG_MASK_CX
		public	REG_MASK_ES
		public	REG_MASK_HIGH_BYTES
		public	REG_MASK_LOW_BYTES
		public	REG_MASK_SI_DI
		public	RELOCATION_POOL_SEG
		public	REPLAY_STREAM_1
		public	REPLAY_STREAM_2
		public	REPLAY_STREAM_3
		public	REPLAY_STREAM_4
		public	RESERVE_BYTES_HOOK
		public	RESET_EXPR_POOL_HOOK
		public	RESOLVED_REQUEST_COUNT
		public	RETURN_BLOCK_WORD20_HOOK
		public	RETURN_FORM_SEEN
		public	RETURN_TYPE_OMITTED
		public	RUNTIME_HELPER_FUNC_TYPE
		public	SAVED_INT18_VECTOR
		public	SAVED_INT1B_VECTOR
		public	SAVED_INT23_VECTOR
		public	SAVED_OPTION_BLOCK
		public	SAVED_OPTION_POOL_CAPACITY
		public	SAVED_OPTION_POOL_FREE
		public	SAVED_OPTION_POOL_SEG
		public	SAVED_OPTION_POOL_USED
		public	SAVED_REG_MASK
		public	SAVE_SP
		public	SAVE_SS
		public	SAW_RETURN_WITHOUT_VALUE
		public	SAW_RETURN_WITH_VALUE
		public	SCOPE_ENTER_DEBUG_HOOK
		public	SCOPE_EXIT_DEBUG_HOOK
		public	SCOPE_LINK10_MARK
		public	SCOPE_LINK10_MARK_HIGH
		public	SCOPE_POOL_SEG
		public	SCOPE_STACK_DEPTH
		public	SCOPE_STATE
		public	SCRATCH_TEMP_VARIABLE
		public	SEARCH_BUFFER
		public	SEARCH_LIST
		public	SEARCH_PATH_NAME
		public	SEARCH_SEPARATOR
		public	SECOND_ASM_OPERAND
		public	SECOND_OPERAND_INDEX_REG
		public	SECOND_OPERAND_REG
		public	SECOND_OPERAND_SEG_REG
		public	SECOND_OPERAND_VALUE
		public	SEGDEF_POOL_SEG
		public	SEGMENT_COUNT
		public	SEGMENT_LIST_HEAD
		public	SEGMENT_LIST_TAIL
		public	SEGMENT_POOL_FREE_LIST
		public	SEGMENT_POOL_USED
		public	SEG_DATA_BLOCK_POOL_SEG
		public	SELECTED_SEGDEF_COPY
		public	SELECTED_SEGDEF_ENTRY
		public	SELECTED_SEGMENT_ID
		public	SESSION_PHASE
		public	SETARGV_SYMBOL
		public	SETENVP_SYMBOL
		public	SET_SYMBOL_OFFSET_HOOK
		public	SET_SYMBOL_SEGMENT_HOOK
		public	SET_SYMBOL_VARIABLE_HOOK
		public	SHORT_TYPE
		public	SINGLE_CHAR_TOKEN_TABLE
		public	SIZE_OF_TYPE_CHECKED_HOOK
		public	SIZE_T_TYPE
		public	SOURCE_FILE_LIST
		public	SPECIAL_MEMBER_KIND
		public	SPECIAL_NAME
		public	SPILLED_REQUEST_COUNT
		public	SRCFILE_POOL_SEG
		public	STACK_BALANCE_NEEDED
		public	STACK_BOTTOM
		public	STACK_PRECEDENCE_BY_OP
		public	STARTUP_BODY_ACTIVE
		public	STARTUP_SS_DS_NAMES
		public	STATEMENT_LABELED_FLAG
		public	STATEMENT_NEST_DEPTH
		public	STMT_NO_GOTO_OR_LABEL_FLAG
		public	STMT_SCOPE_BLOCK
		public	STORAGE_CLASS_NAMES
		public	STORAGE_CLASS_TOKEN
		public	STORAGE_POOL_SEG
		public	STORAGE_RECORD_COUNT
		public	STREAM_HOOK
		public	STRING_CHAR_TYPE
		public	STRING_DATA
		public	STRING_LITERAL_SYMBOL
		public	STRING_LITERAL_SYMBOL_HOOK
		public	STRING_POOL_SEG
		public	STRING_POOL_USED
		public	STRING_TOKEN_PENDING
		public	STRUCT_BODY_TYPE
		public	STRUCT_RETURN_PARAM
		public	STR_0
		public	STR_01
		public	STR_0X0200
		public	STR_0X0297
		public	STR_1
		public	STR_286
		public	STR_286P
		public	STR_287
		public	STR_ADD
		public	STR_ADD_SS_BX
		public	STR_ADR
		public	STR_AHSHIFT
		public	STR_AHSHIFT_2
		public	STR_AND
		public	STR_AN_ARITHMETIC_TYPE
		public	STR_AN_INTEGRAL_TYPE
		public	STR_AROW
		public	STR_ARRAY_BOUNDS
		public	STR_ARRAY_BOUNDS_2
		public	STR_ARWM
		public	STR_ASG
		public	STR_ASM
		public	STR_ASM_2
		public	STR_ASM_EXT
		public	STR_ASM_STATEMENT_CRLF
		public	STR_ASSUME_CS
		public	STR_ASSUME_CS_2
		public	STR_AVAILABLE_MEMORY
		public	STR_AX_AX
		public	STR_A_MEMBER_FUNCTION
		public	STR_A_POINTER_TYPE
		public	STR_A_SCALAR_TYPE
		public	STR_A_SIMPLE_TYPE
		public	STR_A_STANDARD_CONVERSION
		public	STR_B
		public	STR_BACKSLASH
		public	STR_BLANK_COMMENT_LINE
		public	STR_BORLAND_C_VERSION_2_0
		public	STR_BP
		public	STR_BREAK
		public	STR_BRKLVL
		public	STR_BSS
		public	STR_BSS_BASE_LABEL
		public	STR_BX
		public	STR_BYTE
		public	STR_BYTE_2
		public	STR_B_LABEL_BYTE_B_W_LABEL_WORD
		public	STR_C
		public	STR_CALL
		public	STR_CLOSE_BRACE
		public	STR_CMP
		public	STR_CODE
		public	STR_COLON
		public	STR_COLON_2
		public	STR_COLON_COLON
		public	STR_COLON_CRLF
		public	STR_COLON_CR_NL
		public	STR_COLON_SPACE
		public	STR_COMA
		public	STR_COMM
		public	STR_COMMENT_INDENT
		public	STR_COMM_2
		public	STR_CONST
		public	STR_CONST_2
		public	STR_CONST_3
		public	STR_CONTINUE
		public	STR_CPP
		public	STR_CPP_EXT
		public	STR_CRLF
		public	STR_CRLF_2
		public	STR_CRLF_3
		public	STR_CRLF_ECHO
		public	STR_CR_NL
		public	STR_CS_DGROUP
		public	STR_CTR
		public	STR_C_2
		public	STR_C_3
		public	STR_C_4
		public	STR_C_5
		public	STR_C_6
		public	STR_C_7
		public	STR_C_8
		public	STR_D
		public	STR_DATA
		public	STR_DB
		public	STR_DB_0CBH
		public	STR_DB_2
		public	STR_DB_LINE_CRLF
		public	STR_DD
		public	STR_DEBUG_B
		public	STR_DEBUG_C
		public	STR_DEBUG_C_2
		public	STR_DEBUG_C_3
		public	STR_DEBUG_C_4
		public	STR_DEBUG_C_E9
		public	STR_DEBUG_E
		public	STR_DEBUG_F
		public	STR_DEBUG_L
		public	STR_DEC
		public	STR_DEF
		public	STR_DEFINE
		public	STR_DEFINED
		public	STR_DEFINE_2
		public	STR_DEFINE_3
		public	STR_DELE
		public	STR_DELETE
		public	STR_DELTA
		public	STR_DGROUP
		public	STR_DGROUP_2
		public	STR_DIAG_NEWLINE
		public	STR_DIV
		public	STR_DLL
		public	STR_DOT_DOT_DOT
		public	STR_DOUBLE_QUOTE
		public	STR_DO_WHILE
		public	STR_DO_WHILE_2
		public	STR_DS
		public	STR_DTR
		public	STR_DUP
		public	STR_DUP_0
		public	STR_DW
		public	STR_DWORD
		public	STR_DW_2
		public	STR_DYNAMIC_DISPATCH_CONSTAN
		public	STR_D_CDECL
		public	STR_D_COMPACT
		public	STR_D_FASTCALL
		public	STR_D_HUGE
		public	STR_D_LABEL_BYTE_D_W_LABEL_WORD
		public	STR_D_LARGE
		public	STR_D_MEDIUM
		public	STR_D_PASCAL
		public	STR_D_SMALL
		public	STR_D_TINY
		public	STR_E
		public	STR_EMIT
		public	STR_EMPTY
		public	STR_EMPTY_2
		public	STR_EMPTY_3
		public	STR_EMPTY_MACRO_VALUE
		public	STR_EMU_LIB
		public	STR_ENDIF
		public	STR_ENDP
		public	STR_ENDS
		public	STR_END_CRLF_EOF
		public	STR_ENUM
		public	STR_ENUM_2
		public	STR_EQL
		public	STR_EQU
		public	STR_EQU_S
		public	STR_ERROR
		public	STR_ERRORS_IN_COMPILE
		public	STR_EXTERN
		public	STR_EXTERN_2
		public	STR_EXTERN_3
		public	STR_EXTRN
		public	STR_EXTRN_DGROUP_WORD
		public	STR_EXTRN_TURBOFLOAT_WORD
		public	STR_F
		public	STR_FAR
		public	STR_FAR_2
		public	STR_FAR_3
		public	STR_FAR_4
		public	STR_FAR_5
		public	STR_FAR_DATA
		public	STR_FAR_FUNC
		public	STR_FAR_PTR
		public	STR_FATAL
		public	STR_FCOMPP
		public	STR_FIARQQ
		public	STR_FICRQQ
		public	STR_FIDRQQ
		public	STR_FIERQQ
		public	STR_FISRQQ
		public	STR_FJARQQ
		public	STR_FJCRQQ
		public	STR_FJSRQQ
		public	STR_FMT_SPACE_LONG
		public	STR_FMT_SPACE_STRING
		public	STR_FOR
		public	STR_FOR_2
		public	STR_FP87_LIB
		public	STR_FRIEND
		public	STR_FRIEND_2
		public	STR_FRIEND_3
		public	STR_FRIEND_4
		public	STR_FTOL
		public	STR_F_CHKSTK
		public	STR_GEQ
		public	STR_GOTO
		public	STR_GOTO_2
		public	STR_GREATER
		public	STR_GROUP
		public	STR_GTR
		public	STR_HASH
		public	STR_HDRFILE
		public	STR_HDRSTOP
		public	STR_IF
		public	STR_IFDEF
		public	STR_IFNDEF
		public	STR_IFNDEF_VERSION_DEBUG_MACRO_E
		public	STR_IF_2
		public	STR_IF_3
		public	STR_IF_4
		public	STR_IMPORT_LIB
		public	STR_INC
		public	STR_INCLUDE
		public	STR_INCLUDE_2
		public	STR_INCLUDE_GIVEN_MARK
		public	STR_IND
		public	STR_IN_FUNCTION
		public	STR_JMP
		public	STR_JMP_FAR_PTR
		public	STR_JMP_NEAR_PTR
		public	STR_JMP_WORD_PTR_CS
		public	STR_JMP_WORD_PTR_CS_BX
		public	STR_LABEL
		public	STR_LABEL_WORD
		public	STR_LAND
		public	STR_LEQ
		public	STR_LINE
		public	STR_LOADED_PRE_COMPILED
		public	STR_LOCAL_DESTRUCTORS
		public	STR_LOR
		public	STR_LPAREN_RPAREN
		public	STR_LSH
		public	STR_LSS
		public	STR_MAIN
		public	STR_MAIN_2
		public	STR_MISSING_FUNCTION
		public	STR_ML
		public	STR_MOD
		public	STR_MOV
		public	STR_MOV_BX_OFFSET
		public	STR_MOV_BX_SP
		public	STR_MOV_CX_OFFSET_7_PUSH
		public	STR_MUL
		public	STR_N
		public	STR_NEAR
		public	STR_NEAR_2
		public	STR_NEAR_3
		public	STR_NEAR_4
		public	STR_NEAR_5
		public	STR_NEAR_6
		public	STR_NEAR_FUNC
		public	STR_NEAR_PTR
		public	STR_NEQ
		public	STR_NEW
		public	STR_NEWLINE
		public	STR_NEWLINE_INPUT
		public	STR_NEW_2
		public	STR_NON_INLINE_FUNCTION
		public	STR_NOT
		public	STR_N_CHKSTK
		public	STR_O
		public	STR_OBJ
		public	STR_OBJ_2
		public	STR_OBJ_3
		public	STR_OFFSET
		public	STR_OPERATOR
		public	STR_OPERATOR_2
		public	STR_OPERATOR_3
		public	STR_OPERATOR_4
		public	STR_OPERATOR_5
		public	STR_OPERATOR_DELETE
		public	STR_OPERATOR_NEW
		public	STR_OR
		public	STR_OVERFLOW
		public	STR_OVERLAY_LIB
		public	STR_O_2
		public	STR_O_3
		public	STR_PAD
		public	STR_PARA
		public	STR_PASCAL
		public	STR_PASCAL_2
		public	STR_PCMP
		public	STR_PDEA
		public	STR_PINA
		public	STR_PLUS_CRLF
		public	STR_PRAGMA
		public	STR_PRAGMA_2
		public	STR_PRAGMA_DIRECTIVE
		public	STR_PROC
		public	STR_PUBLIC
		public	STR_PUBLICDLL
		public	STR_PUBLIC_2
		public	STR_PUSH_CS_CALL
		public	STR_PUSH_OFFSET_6
		public	STR_P_ST
		public	STR_QUEST
		public	STR_QUOTE
		public	STR_QUOTE_CRLF
		public	STR_QUOTE_CR_NL
		public	STR_QUOTE_OPEN_BRACE
		public	STR_QWORD
		public	STR_R
		public	STR_RAND
		public	STR_RBRACKET_COMMA
		public	STR_RDIV
		public	STR_REFERENCE
		public	STR_RETURN
		public	STR_RLSH
		public	STR_RMIN
		public	STR_RMOD
		public	STR_RMUL
		public	STR_ROR
		public	STR_RPAREN
		public	STR_RPLU
		public	STR_RRSH
		public	STR_RSH
		public	STR_RXOR
		public	STR_S
		public	STR_SCOPY
		public	STR_SCOPY_2
		public	STR_SEG
		public	STR_SEGMENT
		public	STR_SEGMENT_VIRTUAL
		public	STR_SETARGV
		public	STR_SETARGV_2
		public	STR_SETENVP
		public	STR_SETENVP_2
		public	STR_SHORT
		public	STR_SLXMUL
		public	STR_SPACE
		public	STR_SPACE_COMMA
		public	STR_SPACE_SLASH
		public	STR_SPACE_SPACE_SEMI
		public	STR_SPUSH
		public	STR_STAR_RPAREN
		public	STR_STATIC
		public	STR_STATIC_2
		public	STR_STATIC_MEMBER
		public	STR_STATIC_VARIABLES
		public	STR_STKLEN
		public	STR_STKLEN_2
		public	STR_STRUCT
		public	STR_ST_0
		public	STR_ST_0_ST
		public	STR_SUB
		public	STR_SUBS
		public	STR_SUBSCRIPTING
		public	STR_SUBSCRIPTING_2
		public	STR_SWITCH
		public	STR_SWITCH_2
		public	STR_SYNTAX_IS_BCC_OPTIONS
		public	STR_S_2
		public	STR_S_LABEL_BYTE
		public	STR_T
		public	STR_TAB_AT_AT
		public	STR_TBYTE
		public	STR_TC86_BORLAND_TURBO_C_2_0
		public	STR_TEXT
		public	STR_TEXT_2
		public	STR_TLINK_EXE
		public	STR_TURBOC_LN
		public	STR_TURBOC_LN_2
		public	STR_TURBOFLOAT
		public	STR_TURBOFLOAT_2
		public	STR_TWD
		public	STR_TYPE_CONVERSION
		public	STR_UNION
		public	STR_V
		public	STR_VINDEX
		public	STR_VIRTUAL
		public	STR_VIRTUAL_2
		public	STR_VIRTUAL_3
		public	STR_VIRTUAL_4
		public	STR_VOID
		public	STR_VOLATILE
		public	STR_VOLATILE_2
		public	STR_VOLATILE_3
		public	STR_VSF
		public	STR_VSN
		public	STR_V_2
		public	STR_WARNING
		public	STR_WHILE
		public	STR_WHILE_2
		public	STR_WORD
		public	STR_X
		public	STR_X5F_2
		public	STR_XFB
		public	STR_Y
		public	STR_ZI
		public	STR_ZYXWVUTSRQPONMLKJIHGFEDC
		public	STR__
		public	STR__FAR
		public	STR__FPURE_ERROR_
		public	STR__NPURE_ERROR_
		public	STR__SETARGV__
		public	STR__SETENVP__
		public	STR__STCON_
		public	STR__STDES_
		public	STR__TEXT
		public	STR__VECTOR_APPLY_
		public	STR__VECTOR_DELETE_
		public	STR__VECTOR_NEW_
		public	STR__VECTOR_VAPPLY_
		public	STR__VECTOR_VNEW_
		public	STR__WINDOWS
		public	STR___BCPLUSPLUS__
		public	STR___BORLANDC__
		public	STR___CDECL__
		public	STR___DLL__
		public	STR___EMIT__
		public	STR___FASTCALL__
		public	STR___MSDOS__
		public	STR___MULTI_THREAD__
		public	STR___OS2__
		public	STR___OVERLAY__
		public	STR___PASCAL__
		public	STR___SETARGV__
		public	STR___SETENVP__
		public	STR___SINGLE_THREAD__
		public	STR___TCPLUSPLUS__
		public	STR___TURBOC__
		public	SUPPRESS_WARNINGS_DEPTH
		public	SWAP_EXCHANGE_ALLOWED
		public	SWAP_FILE_PREPARED
		public	SWAP_GROW_FILE_ALLOWED
		public	SWAP_OPCODE_FLAG
		public	SWITCH_BIT_200_FLAG
		public	SWITCH_CASE_LIST
		public	SWITCH_DEFAULT_LABEL
		public	SWITCH_STATE_SCOPE
		public	SWITCH_TABLE_LIST
		public	SYMBOL_A1
		public	SYMBOL_A2
		public	SYMBOL_B1
		public	SYMBOL_B2
		public	SYMBOL_ELEMENT_KIND_HOOK
		public	SYMBOL_INDEX_HOOK
		public	SYMBOL_POOL_SEG
		public	SYMBOL_RECORD_SIZE
		public	TAG_BODY_POOL_SEG
		public	TASM_PROGRAM_NAME
		public	TEMP_DESTRUCTOR_LIST
		public	TEMP_ENTRY_POOL_SEG
		public	TEMP_NAME_COUNTER
		public	TERNARY_ELSE_LEVEL
		public	THIS_NAME
		public	TOKEN_AUX
		public	TOKEN_CONST_VALUE
		public	TOKEN_CONVERT
		public	TOKEN_FILE_NODE
		public	TOKEN_LENGTH
		public	TOKEN_LIMIT
		public	TOKEN_LINE
		public	TOKEN_MASK
		public	TOKEN_NAMES
		public	TOKEN_OPERATOR_CODE
		public	TOKEN_POOL
		public	TOKEN_POOL_STEP
		public	TOKEN_POOL_UNIT
		public	TOKEN_POOL_USED
		public	TOKEN_POSITION
		public	TOKEN_PTR
		public	TOKEN_PUSHED_BACK
		public	TOKEN_RECORD_STREAM
		public	TOKEN_START_FLAGS
		public	TOKEN_STREAM_HANDLE
		public	TOKEN_STREAM_POOL_SEG
		public	TOKEN_STREAM_POS
		public	TOKEN_TEXT
		public	TOKEN_TEXT_BUFFER
		public	TOKEN_TYPE
		public	TREE_HAS_SIDE_EFFECTS_HOOK
		public	TYPECHECK_OP_FLAGS
		public	TYPE_ALIGNMENT_HOOK
		public	TYPE_DEBUG_ID_COUNTER
		public	TYPE_EXPR
		public	TYPE_FLAGS
		public	TYPE_HOOK
		public	TYPE_LOCAL
		public	TYPE_POOL
		public	TYPE_POOL_LENGTH
		public	TYPE_POOL_LENGTH_MARK
		public	TYPE_POOL_WORD6
		public	TYPE_RANGE_TABLE
		public	TYPE_RECORD_SIZE
		public	TYPE_SIZE_LOW
		public	UNSIGNED_CHAR
		public	UNSIGNED_INT_TYPE
		public	VARIABLE_TABLE_END
		public	VARIABLE_TABLE_FREE_LIST
		public	VARIABLE_TABLE_SEG
		public	VECTOR_APPLY_SYMBOL
		public	VECTOR_DELETE_SYMBOL
		public	VECTOR_NEW_SYMBOL
		public	VECTOR_VAPPLY_SYMBOL
		public	VECTOR_VNEW_SYMBOL
		public	VOID_NOARG_FUNC_TYPE
		public	VOID_POINTER_TYPE
		public	VOID_TYPE
		public	VTABLE_CLASS_LIST
		public	VTABLE_ENTRY_CLASS_TYPE
		public	VTABLE_ENTRY_PTR_TYPE
		public	VTABLE_FAR_FUNC_MEMBER
		public	VTABLE_MODE
		public	VTABLE_NEAR_FUNC_MEMBER
		public	VTABLE_PTR_NAME
		public	WARNING_ENABLED_TABLE
		public	WARNING_SWITCH_STATE
		public	WARNING_SWITCH_TABLE
		public	WARN_PRO_FLAG
		public	WORD_HOOK
		public	_CTYPE
		public	_PSP
_DATA		segment para public 'DATA'
; @0000
ACTIVE_HEAP	label	byte
ERRNO	label	byte
		db	000h,000h,000h,000h
; @0004
HEAP_START_SEG	label	byte
		db	000h,000h,000h,000h
; @0008
HEAP_END_SEG	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @0012
_PSP	label	byte
		db	000h,000h
; @0014
ENVIRONMENT_SEG	label	byte
		db	000h,000h
; @0016
PROGRAM_PSP	label	byte
		db	000h,000h,'N',08Ch
; @001A
DOS_HOST_MODE	label	byte
		db	000h
; @001B
EXTENDER_HEAP_TOP	label	byte
		db	000h,000h
; @001D
EXTENDER_BASE	label	byte
		db	000h,000h,000h
; @0020
STR_BORLAND_C_VERSION_2_0	label	byte
		db	'Borland C++  Version 2.0 Copyright (c) 1','991 Borland International'
		db	00Dh,00Ah,000h
; @0064
STR_AVAILABLE_MEMORY	label	byte
		db	00Dh,00Ah,009h,'Available memory %ld',00Dh,00Ah,000h
; @007E
STR_SYNTAX_IS_BCC_OPTIONS	label	byte
		db	'Syntax is: BCC [ options ] file[s]     *',' = default; -x- = turn switch x off'
		db	00Dh,00Ah,'  -1      80186/286 Instructions    -2  ','    80286 Pro'
; PAD-POINT (tools/modlink.py --pad-data inserts its test padding here)
		db	'tected Mode Inst.',00Dh,00Ah,'  -Ax     Disable extensions        -B  '
		db	'    Compile via assembly',00Dh,00Ah,'  -C      Allow nested comments     -Dxx'
		db	'x   Define macro',00Dh,00Ah,'  -Exxx   Alternate Assembler name  -G  '
		db	'    Generate for speed',00Dh,00Ah,'  -Hxxx   Use pre-compiled headers  -Ixx'
		db	'x   Include files directory',00Dh,00Ah,'  -K      Default char is unsigned  -Lxx'
		db	'x   Libraries directory',00Dh,00Ah,'  -M      Generate link map         -N  '
		db	'    Check stack overflow',00Dh,00Ah,'  -O      Optimize jumps            -P  '
		db	'    Force C++ compile',00Dh,00Ah,'  -Qxxx   Memory usage control      -S  '
		db	'    Produce assembly output',00Dh,00Ah,'  -Txxx   Set assembler option      -Uxx'
		db	'x   Undefine macro',00Dh,00Ah,'  -Vx     Virtual table control     -Wxx'
		db	'x   Create Windows application',00Dh,00Ah,'  -X      Suppress autodep. output  -Yx '
		db	'    Overlay control',00Dh,00Ah,'  -Z      Optimize register usage   -a  '
		db	'    Generate word alignment',00Dh,00Ah,'  -b    * Treat enums as integers   -c  '
		db	'    Compile only',00Dh,00Ah,'  -d      Merge duplicate strings   -exx'
		db	'x   Executable file name',00Dh,00Ah,'  -fxx    Floating point options    -gN '
		db	'    Stop after N warnings',00Dh,00Ah,'  -iN     Max. identifier length    -jN '
		db	'    Stop after N errors',00Dh,00Ah,'  -k      Standard stack frame      -lx '
		db	'    Set linker option',00Dh,00Ah,'  -mx     Set Memory Model          -nxx'
		db	'x   Output file directory',00Dh,00Ah,'  -oxxx   Object file name          -p  '
		db	'    Pascal calls',00Dh,00Ah,'  -r    * Register variables        -u  '
		db	'  * Underscores on externs',00Dh,00Ah,'  -v      Source level debugging    -wxx'
		db	'x   Warning control',00Dh,00Ah,'  -y      Produce line number info  -zxx'
		db	'x   Set segment names',000h
; @069C
STR_ASM	label	byte
		db	'.asm',000h
; @06A1
STR_OBJ	label	byte
		db	'.obj',000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	'$*$*$*',000h,001h,000h,006h,'YOM',000h
; @06BE
SWAP_FILE_PREPARED	label	byte
		db	000h,000h
; @06C0
HEAP_DEFAULT_OWNER_TAG	label	byte
		db	000h,000h
; @06C2
HEAP_STATUS	label	byte
		db	000h,000h
; @06C4
HEAP_SAVED_TOP_KEY	label	byte
		db	000h,000h
; @06C6
HANDLE_RING_NEWEST	label	byte
		db	000h
; @06C7
HANDLE_RING_TAG_CURSOR	label	byte
		db	'P'
; @06C8
HANDLE_RING_UNTAG_CURSOR	label	byte
		db	0BFh,000h
; @06CA
HEAP_DESCRIPTOR_SEGMENTS	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h
; @06DA
OWNER_TAG_BITMAP	label	byte
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h
; @06FA
HEAP_CPU_TYPE	label	byte
		db	000h
; @06FB
SWAP_GROW_FILE_ALLOWED	label	byte
		db	001h
; @06FC
SWAP_EXCHANGE_ALLOWED	label	byte
		db	000h,000h
; @06FE
OVERLAY_DATA_SIZE	label	byte
		db	000h,000h,000h,000h
; @0702
DATA_0702	label	byte
		db	'friend',000h
; @0709
DATA_0709	label	byte
		db	'virtual',000h
; @0711
STR_C_7	label	byte
		db	'C++',000h
; @0715
STR_C_8	label	byte
		db	'C',000h,000h
; @0718
NO_SOURCE_LOCATION	label	byte
		db	000h,000h,000h,000h,000h,000h
; @071E
POINTER_TEXT	label	byte
		db	'pointer',000h
; @0726
STR_STATIC_VARIABLES	label	byte
		db	'static variables',000h
; @0737
STR_FRIEND	label	byte
		db	'friend',000h
; @073E
STR_VIRTUAL	label	byte
		db	'virtual',000h
; @0746
STR_GOTO	label	byte
		db	'Goto',000h
; @074B
STR_IF	label	byte
		db	'If',000h
; @074E
STR_SWITCH	label	byte
		db	'Switch',000h
; @0755
STR_WHILE	label	byte
		db	'While',000h
; @075B
STR_DO_WHILE	label	byte
		db	'Do-while',000h
; @0764
STR_FOR	label	byte
		db	'For',000h
; @0768
EXPR_OP_FLAGS	label	byte
		db	004h,004h,004h,004h,004h,004h,004h,004h,002h,000h,002h,000h
		db	000h,000h,000h,002h,002h,002h,001h,001h,001h,001h,001h,001h
		db	001h,001h,001h,001h,001h,008h,008h,008h,008h,008h,008h,000h
		db	000h,000h,000h,008h,008h,000h,000h,000h,000h,000h,000h,000h
		db	008h,000h,000h,004h,000h,000h,001h,000h,004h,004h,000h,000h
		db	000h,000h,000h,001h,001h,001h,000h,001h,000h,000h,001h,001h
		db	005h,000h,004h
; @07B3
TYPE_FLAGS	label	byte
		db	000h,002h,'P',01Dh,000h,018h,010h,01Ch,000h,018h,000h,007h,000h
		db	002h,000h,003h,000h,014h,'@',019h,000h,000h,000h,01Ch,000h,01Ch
		db	000h,01Ch,000h,01Ch,000h,01Ch,000h,01Ch,000h,01Ch,000h,01Ch
		db	000h,01Ch,000h,01Ch,000h,01Ch,'@',01Dh,'@',01Dh,'P',01Dh,000h
		db	01Ch,000h,01Ch,'P',01Dh,000h,01Ch,000h,01Ch,000h,01Ch,000h,01Ch
		db	000h,018h,000h,01Bh,000h,01Ch,000h,01Ch,000h,01Ch,000h,01Ch
		db	000h,01Ch,000h,01Ch,000h,01Ch,000h,01Ch,'@',01Dh,'`',01Dh,'@'
		db	019h,'@',01Dh,'@',01Dh,000h,018h,000h,01Ch,'X',019h,'@',019h
		db	'@',019h,'@',019h,009h,012h,009h,012h,009h,012h,009h,012h,009h
		db	012h,00Eh,01Ah,00Eh,01Ah,00Eh,01Ah,00Eh,01Ah,00Eh,01Ah,00Eh
		db	01Ah,00Eh,01Ah,00Eh,01Ah,00Ah,01Ah,00Ah,01Ah,00Ah,01Ah,00Eh
		db	01Ah,010h,'0',010h,'0',010h,'0',000h,'0',00Ah,01Ah,00Ah,01Ah
		db	010h,'0',010h,'0',010h,'0',010h,'0',010h,'0',010h,'0',010h,'0'
		db	010h,'0',010h,'0',010h,'0',010h,'0',080h,003h,080h,003h,000h
		db	003h,000h,003h,080h,003h,080h,003h,080h,003h,080h,003h,000h
		db	007h,000h,003h,000h,003h,000h,003h,000h,001h,000h,000h,'@',019h
		db	000h,004h,'@',019h,00Ah,01Ah,'@',01Dh,009h,012h,009h,012h,'@'
		db	01Dh,'P',019h,009h,012h,' ',000h,' ',000h,' ',000h,'@',019h
		db	009h,012h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h
; @08B9
WARNING_SWITCH_TABLE	label	byte
		db	'att',001h,'bbf',000h,'bdf',001h,'bei',001h,'scp',001h,'lin'
		db	001h,'lvc',001h,'lvc',001h,'lvc',001h,'lvc',001h,'ret',001h
		db	'nci',001h,'inl',001h,'obi',001h,'ofp',001h,'ovl',001h,'pin'
		db	000h,'omf',001h,'pad',000h,'dcl',001h,'amb',000h,'amp',000h
		db	'par',001h,'asc',001h,'asm',000h,'bgt',001h,'pro',000h,'pro'
		db	000h,'cln',000h,'cpt',001h,'def',000h,'rng',001h,'dup',001h
		db	'pia',001h,'rvl',001h,'sig',000h,'nod',000h,'eff',001h,'aus'
		db	001h,'ill',001h,'sus',001h,'rch',001h,'rpt',001h,'stv',000h
		db	'vrt',001h,'big',001h,'ucp',000h,'use',000h,'zdi',001h,'bcs'
		db	001h,'stu',001h,'ext',001h,'bfs',001h,'dpu',001h,'fdt',001h
		db	'eas',001h,'hid',001h,'ncf',001h,'ncf',001h,'ias',001h,000h
		db	000h,000h,000h
; @09AD
REAL_ZERO	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @09B7
REAL_ONE	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,080h,0FFh,'?'
; @09C1
REAL_MINUS_ONE	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,080h,0FFh
; @09CA
EXPR_FLAGS	label	byte
		db	0BFh,001h,'!',001h,'!',001h,'!',001h,'!',002h,002h,002h,000h
		db	00Ch,018h,00Ch,00Ch,000h,000h,'@@',001h
; @09E0
C9_TOKEN_NAMES	label	byte
		db	000h,000h,082h,000h,000h,000h,001h,000h,000h,000h,002h,000h
		db	000h,000h,003h,000h,000h,000h,004h,000h,000h,000h,005h,000h
		db	000h,000h,006h,000h,000h,000h,007h,000h,000h,000h,008h,000h
		db	000h,000h,009h,000h,000h,000h,00Bh,000h,000h,000h,00Ch,000h
		db	000h,000h,00Dh,000h,000h,000h,00Eh,000h,000h,000h,00Fh,000h
		db	000h,000h,010h,000h,000h,000h,011h,000h,000h,000h,012h,000h
		db	000h,000h,013h,000h,000h,000h,014h,000h,000h,000h,015h,000h
		db	000h,000h,016h,000h,000h,000h,017h,000h,000h,000h,018h,000h
		db	000h,000h,019h,000h,000h,000h,01Ah,000h,000h,000h,01Bh,000h
		db	000h,000h,01Ch,000h,000h,000h,01Dh,000h,000h,000h,01Eh,000h
		db	000h,000h,01Fh,000h,000h,000h,' ',000h,000h,000h,'!',000h,000h
		db	000h,'"',000h,000h,000h,'#',000h,000h,000h,'$',000h,000h,000h
		db	'%',000h,000h,000h,'&',000h,000h,000h,027h,000h,000h,000h,'('
		db	000h,000h,000h,')',000h,000h,000h,'*',000h,000h,000h,'+',000h
		db	000h,000h,',',000h,000h,000h,'-',000h,000h,000h,'.',000h,000h
		db	000h,'/',000h,000h,000h,'0',000h,000h,000h,'5',000h,000h,000h
		db	'6',000h,000h,000h,'7',000h,000h,000h,'8',000h,000h,000h,'9'
		db	000h,000h,000h,':',000h,000h,000h,';',000h,000h,000h,'<',000h
		db	000h,000h,'=',000h,000h,000h,'>',000h,000h,000h,'?',000h,000h
		db	000h,'@',000h,000h,000h,'A',000h,000h,000h,'B',000h,000h,000h
		db	'C',000h,000h,000h,'D',000h,000h,000h,'E',000h,000h,000h,'F'
		db	000h,000h,000h,'G',000h,000h,000h,'H',000h,000h,000h,'I',000h
		db	000h,000h,'J',000h,000h,000h,'K',000h,000h,000h,'L',000h,000h
		db	000h,'M',000h,000h,000h,'N',000h,000h,000h,'O',000h,000h,000h
		db	'P',000h,000h,000h,'Q',000h,000h,000h,'R',000h,000h,000h,'S'
		db	000h,000h,000h,'T',000h,000h,000h,'U',000h,000h,000h,'V',000h
		db	000h,000h,'X',000h,000h,000h,'Y',000h,000h,000h,'Z',000h,000h
		db	000h,'[',000h,000h,000h,'\',000h,000h,000h,']',000h,000h,000h
		db	'^',000h,000h,000h,'_',000h,000h,000h,'`',000h,000h,000h,'a'
		db	000h,000h,000h,'b',000h,000h,000h,'c',000h,000h,000h,'d',000h
		db	000h,000h,'e',000h,000h,000h,'f',000h,000h,000h,'g',000h,000h
		db	000h,'h',000h,000h,000h,'i',000h,000h,000h,'j',000h,000h,000h
		db	'k',000h,000h,000h,'l',000h,000h,000h,'m',000h,000h,000h,'n'
		db	000h,000h,000h,'o',000h,000h,000h,'p',000h,000h,000h,'q',000h
		db	000h,000h,'r',000h
; @0B94
DATA_0B94	label	byte
		db	000h,000h,'s',000h
; @0B98
C9_TOKEN_END	label	byte
		dw	offset DGROUP:DATA_0B94,DGROUP
; @0B9C
C9_TYPE_SIZES	label	byte
		db	000h,002h,008h,004h,00Ah,004h,00Ah,006h,00Ch,00Eh,00Fh,010h
		db	001h
; @0BA9
C33_TYPE_NAMES	label	byte
		dw	offset DGROUP:DATA_0C1F
		dw	offset DGROUP:DATA_0C29
		dw	offset DGROUP:DATA_0C2E
		dw	offset DGROUP:DATA_0C3C
		dw	offset DGROUP:DATA_0C42
		dw	offset DGROUP:DATA_0C51
		dw	offset DGROUP:DATA_0C55
		dw	offset DGROUP:DATA_0C62
		dw	offset DGROUP:DATA_0C67
		dw	offset DGROUP:DATA_0C75
		dw	offset DGROUP:DATA_0C7B
		dw	offset DGROUP:DATA_0C82
		dw	offset DGROUP:DATA_0C8E
		dw	offset DGROUP:DATA_0C93
		dw	offset DGROUP:DATA_0C98
		dw	offset DGROUP:DATA_0C9D
		dw	offset DGROUP:DATA_0CA1
		dw	offset DGROUP:DATA_0CA6
		dw	offset DGROUP:DATA_0CAE
		dw	offset DGROUP:DATA_0CC2
		dw	offset DGROUP:DATA_0CCA
		dw	offset DGROUP:DATA_0CD1
; @0BD5
C18_OPERATOR_TOKENS	label	byte
		db	082h,'123111',009h,016h,017h,018h,019h,01Ah,01Eh,01Fh,01Bh,01Ch
		db	01Dh,00Bh,00Ch,00Dh,00Eh,00Fh,010h,014h,015h,011h,012h,013h
		db	'$%',027h,'&)(',082h,082h,' !#"',082h,008h,082h,082h,082h,017h
		db	'+*',018h,01Bh,082h,082h,082h,082h,082h,082h,082h,003h,'/d0f-.l'
		db	01Bh,'i,k',082h,005h,082h,016h
; @0C1F
DATA_0C1F	label	byte
		db	'undefined',000h
; @0C29
DATA_0C29	label	byte
		db	'char',000h
; @0C2E
DATA_0C2E	label	byte
		db	'unsigned char',000h
; @0C3C
DATA_0C3C	label	byte
		db	'short',000h
; @0C42
DATA_0C42	label	byte
		db	'unsigned short',000h
; @0C51
DATA_0C51	label	byte
		db	'int',000h
; @0C55
DATA_0C55	label	byte
		db	'unsigned int',000h
; @0C62
DATA_0C62	label	byte
		db	'long',000h
; @0C67
DATA_0C67	label	byte
		db	'unsigned long',000h
; @0C75
DATA_0C75	label	byte
		db	'float',000h
; @0C7B
DATA_0C7B	label	byte
		db	'double',000h
; @0C82
DATA_0C82	label	byte
		db	'long double',000h
; @0C8E
DATA_0C8E	label	byte
		db	'void',000h
; @0C93
DATA_0C93	label	byte
		db	'near',000h
; @0C98
DATA_0C98	label	byte
		db	'_seg',000h
; @0C9D
DATA_0C9D	label	byte
		db	'far',000h
; @0CA1
DATA_0CA1	label	byte
		db	'huge',000h
; @0CA6
DATA_0CA6	label	byte
		db	'array [',000h
; @0CAE
DATA_0CAE	label	byte
		db	'function returning',009h,000h
; @0CC2
DATA_0CC2	label	byte
		db	'struct ',000h
; @0CCA
DATA_0CCA	label	byte
		db	'union ',000h
; @0CD1
DATA_0CD1	label	byte
		db	'enum ',000h
; @0CD7
STR___EMIT__	label	byte
		db	'__emit__',000h
; @0CE0
STR_S_2	label	byte
		db	's@',000h
; @0CE3
STR_MAIN_2	label	byte
		db	'main',000h
; @0CE8
STR__SETARGV__	label	byte
		db	'_setargv__',000h
; @0CF3
STR___SETARGV__	label	byte
		db	'__setargv__',000h
; @0CFF
STR__SETENVP__	label	byte
		db	'_setenvp__',000h
; @0D0A
STR___SETENVP__	label	byte
		db	'__setenvp__',000h
; @0D16
STR_NEW	label	byte
		db	'new',000h
; @0D1A
STR__VECTOR_NEW_	label	byte
		db	'_vector_new_',000h
; @0D27
STR__VECTOR_VNEW_	label	byte
		db	'_vector_vnew_',000h
; @0D35
STR_DELETE	label	byte
		db	'delete',000h
; @0D3C
STR__VECTOR_DELETE_	label	byte
		db	'_vector_delete_',000h
; @0D4C
STR__VECTOR_APPLY_	label	byte
		db	'_vector_apply_',000h
; @0D5B
STR__VECTOR_VAPPLY_	label	byte
		db	'_vector_vapply_',000h
; @0D6B
STR__FPURE_ERROR_	label	byte
		db	'_fpure_error_',000h
; @0D79
STR__NPURE_ERROR_	label	byte
		db	'_npure_error_',000h
; @0D87
STR_FAR_FUNC	label	byte
		db	'far_func',000h
; @0D90
STR_NEAR_FUNC	label	byte
		db	'near_func',000h
; @0D9A
STR_DELTA	label	byte
		db	'delta',000h
; @0DA0
STR_VINDEX	label	byte
		db	'vindex',000h
; @0DA7
STR_OFFSET	label	byte
		db	'offset',000h
; @0DAE
STR_PAD	label	byte
		db	'pad',000h
; @0DB2
STR_EMPTY_2	label	byte
		db	000h,000h
; @0DB4
STR__STCON_	label	byte
		db	'_STCON_',000h
; @0DBC
STR__STDES_	label	byte
		db	'_STDES_',000h
; @0DC4
STR_VSF	label	byte
		db	'$vsf',000h
; @0DC9
STR_VSN	label	byte
		db	'$vsn',000h
; @0DCE
C14_TYPE_ENCODINGS	label	byte
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:DATA_0E2C,DGROUP
		dw	offset DGROUP:DATA_0E2F,DGROUP
		dw	offset DGROUP:DATA_0E32,DGROUP
		dw	offset DGROUP:DATA_0E34,DGROUP
		dw	offset DGROUP:DATA_0E37,DGROUP
		dw	offset DGROUP:DATA_0E39,DGROUP
		dw	offset DGROUP:DATA_0E3C,DGROUP
		dw	offset DGROUP:DATA_0E3E,DGROUP
		dw	offset DGROUP:DATA_0E41,DGROUP
		dw	offset DGROUP:DATA_0E43,DGROUP
		dw	offset DGROUP:DATA_0E45,DGROUP
		dw	offset DGROUP:DATA_0E47,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:DATA_0E49,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:DATA_0E4C,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
		dw	offset DGROUP:STR_QUEST,DGROUP
; @0E26
C14_ARGUMENT_CODES	label	byte
		dw	offset DGROUP:DATA_0E4F,DGROUP
; @0E2A
STR_QUEST	label	byte
		db	'?',000h
; @0E2C
DATA_0E2C	label	byte
		db	'zc',000h
; @0E2F
DATA_0E2F	label	byte
		db	'uc',000h
; @0E32
DATA_0E32	label	byte
		db	's',000h
; @0E34
DATA_0E34	label	byte
		db	'us',000h
; @0E37
DATA_0E37	label	byte
		db	'i',000h
; @0E39
DATA_0E39	label	byte
		db	'ui',000h
; @0E3C
DATA_0E3C	label	byte
		db	'l',000h
; @0E3E
DATA_0E3E	label	byte
		db	'ul',000h
; @0E41
DATA_0E41	label	byte
		db	'f',000h
; @0E43
DATA_0E43	label	byte
		db	'd',000h
; @0E45
DATA_0E45	label	byte
		db	'g',000h
; @0E47
DATA_0E47	label	byte
		db	'v',000h
; @0E49
DATA_0E49	label	byte
		db	'ur',000h
; @0E4C
DATA_0E4C	label	byte
		db	'up',000h
; @0E4F
DATA_0E4F	label	byte
		db	'0123456789abcdefghijklmnopqrstuvwxyz',000h
; @0E74
STR_ADD	label	byte
		db	'add',000h
; @0E78
STR_SUB	label	byte
		db	'sub',000h
; @0E7C
STR_MUL	label	byte
		db	'mul',000h
; @0E80
STR_DIV	label	byte
		db	'div',000h
; @0E84
STR_MOD	label	byte
		db	'mod',000h
; @0E88
STR_X	label	byte
		db	'x'
; @0E89
STR_OR	label	byte
		db	'or',000h
; @0E8C
STR_AND	label	byte
		db	'and',000h
; @0E90
STR_CMP	label	byte
		db	'cmp',000h
; @0E94
STR_ASG	label	byte
		db	'asg',000h
; @0E98
STR_LSS	label	byte
		db	'lss',000h
; @0E9C
STR_GTR	label	byte
		db	'gtr',000h
; @0EA0
STR_RPLU	label	byte
		db	'rplu',000h
; @0EA5
STR_RMIN	label	byte
		db	'rmin',000h
; @0EAA
STR_RMUL	label	byte
		db	'rmul',000h
; @0EAF
STR_RDIV	label	byte
		db	'rdiv',000h
; @0EB4
STR_RMOD	label	byte
		db	'rmod',000h
; @0EB9
STR_RXOR	label	byte
		db	'rxor',000h
; @0EBE
STR_RAND	label	byte
		db	'rand',000h
; @0EC3
STR_ROR	label	byte
		db	'ror',000h
; @0EC7
STR_LSH	label	byte
		db	'lsh',000h
; @0ECB
STR_RSH	label	byte
		db	'rsh',000h
; @0ECF
STR_RLSH	label	byte
		db	'rlsh',000h
; @0ED4
STR_RRSH	label	byte
		db	'rrsh',000h
; @0ED9
STR_EQL	label	byte
		db	'eql',000h
; @0EDD
STR_NEQ	label	byte
		db	'neq',000h
; @0EE1
STR_LEQ	label	byte
		db	'leq',000h
; @0EE5
STR_GEQ	label	byte
		db	'geq',000h
; @0EE9
STR_LAND	label	byte
		db	'land',000h
; @0EEE
STR_LOR	label	byte
		db	'lor',000h
; @0EF2
STR_CALL	label	byte
		db	'call',000h
; @0EF7
STR_SUBS	label	byte
		db	'subs',000h
; @0EFC
STR_NEW_2	label	byte
		db	'new',000h
; @0F00
STR_DELE	label	byte
		db	'dele',000h
; @0F05
STR_AROW	label	byte
		db	'arow',000h
; @0F0A
STR_COMA	label	byte
		db	'coma',000h
; @0F0F
STR_ARWM	label	byte
		db	'arwm',000h
; @0F14
STR_IND	label	byte
		db	'ind',000h
; @0F18
STR_ADR	label	byte
		db	'adr',000h
; @0F1C
STR_NOT	label	byte
		db	'not',000h
; @0F20
STR_INC	label	byte
		db	'inc',000h
; @0F24
STR_DEC	label	byte
		db	'dec',000h
; @0F28
STR_CTR	label	byte
		db	'ctr',000h
; @0F2C
STR_DTR	label	byte
		db	'dtr',000h
; @0F30
STR_ZYXWVUTSRQPONMLKJIHGFEDC	label	byte
		db	'zyxwvutsrqponmlkjihgfedcba0123456789ABCD','EFGHIJKLMNOPQRSTUVWXYZ_'
		db	000h
; @0F70
STR_LOCAL_DESTRUCTORS	label	byte
		db	'local destructors',000h
; @0F82
STR_ARRAY_BOUNDS	label	byte
		db	'Array bounds',000h,000h
; @0F90
STR_A_MEMBER_FUNCTION	label	byte
		db	'a member function',000h
; @0FA2
STR_FRIEND_2	label	byte
		db	'friend',000h
; @0FA9
STR_VIRTUAL_2	label	byte
		db	'virtual',000h
; @0FB1
STR_OPERATOR	label	byte
		db	'Operator []',000h
; @0FBD
STR_OPERATOR_2	label	byte
		db	'Operator',009h,'[]',000h,000h
; @0FCA
STR_REFERENCE	label	byte
		db	'reference',000h
; @0FD4
C25_EMPTY_NAME	label	byte
		db	000h,000h
; @0FD6
C27_STATIC_TEXT	label	byte
		db	'static',000h,000h
; @0FDE
C31_DEFAULT_DISPATCH	label	byte
		dd	DEBUG_NUMBERS
		dd	NEW_BITFIELD_NODE_ALT
		dd	BCC_NODE_INTEGER
		dd	BCC_NODE_BINARY
		dd	BCC_NODE_MODE
		dd	C56_EMIT_NAME
		dd	TEMP_STORAGE_FOR_TYPE
		dd	BCC_NODE_RESET
		dd	ENCODE_ASM_SYMBOL_ALT
		dd	PARAMETER_COUNT
		dd	TYPE_ATTR_BYTE_0C
		dd	TYPE_EMIT_FINISH
		dd	END_SESSION
		dd	TYPE_ALIGNMENT
		dd	FIND_NAMED_FUNCTION_PREPARED
		dd	TREE_HAS_SIDE_EFFECTS_ALT
		dd	EVAL_CONSTANT_CONDITION
		dd	CODE_MASK
		dd	IS_BASED_NEAR_PTR
		dd	IS_STRING_LITERAL_STORAGE
		dd	TYPE_ATTR_BYTE_0B
		dd	BEGIN_BACKEND_PHASE
		dd	NEAR_PTR_SUBKIND
		dd	BASIC_TYPE_FOR_KIND
		dd	EMIT_DEBUG_GLOBALS
		dd	DEBUG_FLUSH
		dd	EMIT_DEBUG_SCOPE_SYMBOLS
		dd	STORAGE_INTRINSIC_NUMBER
		dd	DUMP_ALL
		dd	EMIT_EXTDEF_PUBDEF_RECORDS
		dd	PARSE_ASM_MEMBER
		dd	PARSE_ASM_JUMP_LABEL
		dd	EXPAND_COMPOUND_ASSIGN_ALT
		dd	BCC_NODE_CONVERT
		dd	STORAGE_SEGMENT
		dd	SET_STORAGE_FLAG_20
		dd	SET_STORAGE_ARG_COUNT
		dd	SET_STORAGE_SEGMENT
		dd	SET_STORAGE_SEGMENT_FLAG_8
		dd	SET_STORAGE_FIRST_WORD
		dd	DECLARE_RUNTIME_SYMBOL
		dd	SYMBOL_CATEGORY
		dd	STRING_LITERAL_STORAGE
		dd	MAKE_ADDRESS_OF_TYPED
		dd	TYPE_CLASS_BYTE
		dd	STORAGE_TYPE_CLASS
		dd	STORAGE_TYPE_SIZE
		dd	SYMBOL_TYPE_OF_STORAGE
		dd	STORAGE_FIRST_WORD
; @10A2
STR_COLON	label	byte
		db	':',000h
; @10A4
STR_ERRORS_IN_COMPILE	label	byte
		db	'*** %d errors in Compile ***',00Ah,000h
; @10C2
STR_FATAL	label	byte
		db	'Fatal',000h
; @10C8
STR_IN_FUNCTION	label	byte
		db	' in function %s',000h
; @10D8
STR_WARNING	label	byte
		db	'Warning',000h
; @10E0
STR_ERROR	label	byte
		db	'Error',000h
; @10E6
DIAGNOSTIC_COUNT	label	byte
		db	000h,000h
; @10E8
STR_FMT_SPACE_STRING	label	byte
		db	' %s',000h
; @10EC
STR_FMT_SPACE_LONG	label	byte
		db	' %ld',000h
; @10F1
STR_COLON_SPACE	label	byte
		db	': ',000h
; @10F4
STR_DIAG_NEWLINE	label	byte
		db	00Ah,000h
; @10F6
C33_POINTER_QUALIFIERS	label	byte
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_110A,DGROUP
		dw	offset DGROUP:DATA_1110,DGROUP
		dw	offset DGROUP:DATA_1116,DGROUP
		dw	offset DGROUP:DATA_111C,DGROUP
; @110A
DATA_110A	label	byte
		db	' _es ',000h
; @1110
DATA_1110	label	byte
		db	' _cs ',000h
; @1116
DATA_1116	label	byte
		db	' _ss ',000h
; @111C
DATA_111C	label	byte
		db	' _ds ',000h
; @1122
STR_VOID	label	byte
		db	'void',000h
; @1127
STR_DOT_DOT_DOT	label	byte
		db	'...',000h
; @112B
STR_CONST	label	byte
		db	'const ',000h
; @1132
STR_VOLATILE	label	byte
		db	'volatile ',000h
; @113C
STR_ENUM	label	byte
		db	'enum ',000h
; @1142
STR_ENUM_2	label	byte
		db	'enum',000h
; @1147
STR_FAR	label	byte
		db	' far ',000h
; @114D
STR_NEAR	label	byte
		db	' near ',000h
; @1154
STR_COLON_COLON	label	byte
		db	'::',000h
; @1157
STR_PASCAL	label	byte
		db	' pascal',000h
; @115F
STR_STAR_RPAREN	label	byte
		db	'*)',000h
; @1162
STR_CONST_2	label	byte
		db	' const ',000h
; @116A
STR_VOLATILE_2	label	byte
		db	' volatile ',000h
; @1175
STR_STRUCT	label	byte
		db	'struct',000h
; @117C
STR_UNION	label	byte
		db	'union',000h
; @1182
STR_OPERATOR_3	label	byte
		db	'operator ',000h
; @118C
STR_LPAREN_RPAREN	label	byte
		db	'()',000h
; @118F
STR_CONST_3	label	byte
		db	' const',000h
; @1196
STR_VOLATILE_3	label	byte
		db	' volatile',000h
; @11A0
STR_OPERATOR_4	label	byte
		db	'operator=',000h
; @11AA
STR_AN_INTEGRAL_TYPE	label	byte
		db	'an integral type',000h
; @11BB
STR_A_POINTER_TYPE	label	byte
		db	'a pointer type',000h
; @11CA
STR_A_SCALAR_TYPE	label	byte
		db	'a scalar type',000h
; @11D8
STR_AN_ARITHMETIC_TYPE	label	byte
		db	'an arithmetic type',000h
; @11EB
STR_A_SIMPLE_TYPE	label	byte
		db	'a simple type',000h
; @11F9
STR_C_3	label	byte
		db	'C++',000h
; @11FD
STR_C_4	label	byte
		db	'C',000h
; @11FF
STR_PASCAL_2	label	byte
		db	'Pascal',000h
; @1206
STR_TYPE_CONVERSION	label	byte
		db	'type conversion',000h
; @1216
BINARY_PRECEDENCE_BY_TOKEN	label	byte
		db	'~',004h,'x',006h,'x~~~(~~&&&&&&&&&&&',012h,012h,010h,010h,010h
		db	01Ah,01Eh,01Ch,014h,014h,'$*" ',018h,018h,016h,016h,016h,016h
		db	'~~',00Ah,00Ah,00Ah,006h,006h,'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
		db	'~~~~~~~~~~',00Ah,00Eh,'~',00Eh,'~~',00Ah,'~~',00Ah,'~~~~~~~~~~~~~~~~~~~~~~'
; @1299
STACK_PRECEDENCE_BY_OP	label	byte
		db	07Fh,'|',001h,'z',001h,07Fh,07Fh,07Fh,'(',07Fh,07Fh,027h,027h
		db	027h,027h,027h,027h,027h,027h,027h,027h,027h,012h,012h,010h
		db	010h,010h,01Ah,01Eh,01Ch,014h,014h,'+*" ',018h,018h,016h,016h
		db	016h,016h,00Bh,00Bh,00Bh,00Bh,00Bh,006h,006h,07Fh,07Fh,07Fh
		db	07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh
		db	07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh
		db	07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh
		db	07Fh,005h,005h,00Bh,00Bh,00Bh,00Bh,001h,'z',00Bh,07Fh,00Bh,00Eh
		db	07Fh,00Eh,07Fh,07Fh,00Bh,07Fh,07Fh,00Ah,07Fh,07Fh,07Fh,07Fh
		db	07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh
		db	07Fh,'~~~~',07Fh
; @131C
PREFIX_PRECEDENCE_BY_TOKEN	label	byte
		db	'~||||~~~|~~|||||||||||',00Ah,00Ah,00Ah,'||',00Ah,'||||||||||||||'
		db	00Ah,00Ah,00Ah,00Ah,00Ah,'||~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
		db	'~~||',00Ah,00Ah,00Ah,00Ah,'|||~~|~|~~',00Ah,'~~',00Ah,'~~~~~~~~~~~~~~~~~~~~~~'
; @139F
STR_SUBSCRIPTING	label	byte
		db	'Subscripting',000h
; @13AC
STR_FRIEND_3	label	byte
		db	'friend',000h
; @13B3
STR_VIRTUAL_3	label	byte
		db	'virtual',000h,000h
; @13BC
TOKEN_OPERATOR_CODE	label	byte
		db	000h,'6',000h,':',000h,'G',000h,000h,'*',007h,000h,012h,013h
		db	014h,015h,016h,017h,01Ah,01Bh,01Ch,018h,019h,008h,009h,00Ah
		db	00Bh,00Ch,00Fh,010h,011h,00Dh,00Eh,'%&(',027h,01Dh,01Eh,' '
		db	01Fh,'"!0/D?@;=',001h,002h,003h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,'F',000h,000h,000h,000h
; @1420
COMPARE_NEGATION_TABLE	label	byte
		db	'<',000h,'>',000h,000h,'C',000h,'EA',000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h
; @1440
STR_IF_2	label	byte
		db	'If',000h,000h
; @1444
STR_A_STANDARD_CONVERSION	label	byte
		db	'a standard conversion',000h
; @145A
COMPARE_NEGATE_TABLE	label	byte
		db	01Eh,000h,01Dh,000h,'"',000h,'!',000h,' ',000h,01Fh,000h
; @1466
FOLD_ADD_SIGNED_FN	label	byte
		dd	FOLD_ADD_SIGNED
; @146A
FOLD_ADD_UNSIGNED_FN	label	byte
		dd	FOLD_ADD_UNSIGNED
; @146E
FOLD_SUB_SIGNED_FN	label	byte
		dd	FOLD_SUB_SIGNED
; @1472
FOLD_SUB_UNSIGNED_FN	label	byte
		dd	FOLD_SUB_UNSIGNED
; @1476
FOLD_MUL_SIGNED_FN	label	byte
		dd	FOLD_MUL_SIGNED
; @147A
FOLD_MUL_UNSIGNED_FN	label	byte
		dd	FOLD_MUL_UNSIGNED
; @147E
FOLD_DIV_SIGNED_FN	label	byte
		dd	FOLD_DIV_SIGNED
; @1482
FOLD_DIV_UNSIGNED_FN	label	byte
		dd	FOLD_DIV_UNSIGNED
; @1486
FOLD_MOD_SIGNED_FN	label	byte
		dd	FOLD_MOD_SIGNED
; @148A
FOLD_MOD_UNSIGNED_FN	label	byte
		dd	FOLD_MOD_UNSIGNED
; @148E
FOLD_AND_LONG_FN	label	byte
		dd	FOLD_AND_LONG
; @1492
FOLD_OR_LONG_FN	label	byte
		dd	FOLD_OR_LONG
; @1496
FOLD_XOR_LONG_FN	label	byte
		dd	FOLD_XOR_LONG
; @149A
FOLD_SHIFT_SIGNED_FN	label	byte
		dd	FOLD_SHIFT_SIGNED
; @149E
FOLD_SHIFT_UNSIGNED_FN	label	byte
		dd	FOLD_SHIFT_UNSIGNED
; @14A2
REAL_MUL_FN	label	byte
		dd	RTL_LDOUBLE_MUL
; @14A6
REAL_DIV_FN	label	byte
		dd	RTL_LDOUBLE_DIV
; @14AA
REAL_ADD_FN	label	byte
		dd	RTL_LDOUBLE_ADD
; @14AE
REAL_SUB_FN	label	byte
		dd	RTL_LDOUBLE_SUB
; @14B2
NO_REAL_FOLD_FN	label	byte
		dd	NO_REAL_FOLD
; @14B6
TYPE_RECORD_SIZE	label	byte
		db	00Fh,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h
		db	008h,00Eh,00Eh,00Eh,00Eh,010h,00Eh,008h,008h,008h
; @14CC
MEMBER_RECORD_SIZE	label	byte
		db	00Ch,00Ch,008h,008h
; @14D0
DUPLICATE_TYPE_FREE_LIST	label	byte
		db	000h,000h
; @14D2
SYMBOL_RECORD_SIZE	label	byte
		db	017h,017h,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,012h,012h,00Ah,00Ah
		db	00Eh,018h,010h,018h,00Ch,00Ch
; @14E4
SESSION_PHASE	label	byte
		db	000h,000h,'$*$*$*',00Ch,088h,00Ah,003h,'BORLANDC',000h
; @14F9
DEFAULT_SOURCE_EXT	label	byte
		db	'.cpp',000h
; @14FE
DATA_14FE	label	byte
		db	001h,000h
		dw	offset DGROUP:DATA_1CFE
		db	002h,000h
		dw	offset DGROUP:DATA_1CFF
		db	003h,000h
		dw	offset DGROUP:DATA_1D01
		db	004h,000h
		dw	offset DGROUP:DATA_1D02
		db	005h,000h
		dw	offset DGROUP:DATA_1D04
		db	006h,000h
		dw	offset DGROUP:DATA_1D06
		db	007h,000h
		dw	offset DGROUP:DATA_1D08
		db	008h,000h
		dw	offset DGROUP:DATA_1D0A
		db	009h,000h
		dw	offset DGROUP:DATA_1D0C
		db	00Bh,000h
		dw	offset DGROUP:DATA_1D10
		db	00Ch,000h
		dw	offset DGROUP:DATA_1D12
		db	00Dh,000h
		dw	offset DGROUP:DATA_1D15
		db	00Eh,000h
		dw	offset DGROUP:DATA_1D18
		db	00Fh,000h
		dw	offset DGROUP:DATA_1D1B
		db	010h,000h
		dw	offset DGROUP:DATA_1D1E
		db	011h,000h
		dw	offset DGROUP:DATA_1D21
		db	012h,000h
		dw	offset DGROUP:DATA_1D24
		db	013h,000h
		dw	offset DGROUP:DATA_1D27
		db	014h,000h
		dw	offset DGROUP:DATA_1D2A
		db	015h,000h
		dw	offset DGROUP:DATA_1D2E
		db	016h,000h
		dw	offset DGROUP:DATA_1D32
		db	017h,000h
		dw	offset DGROUP:DATA_1D34
		db	018h,000h
		dw	offset DGROUP:DATA_1D36
		db	019h,000h
		dw	offset DGROUP:DATA_1D38
		db	01Ah,000h
		dw	offset DGROUP:DATA_1D3A
		db	01Bh,000h
		dw	offset DGROUP:DATA_1D3C
		db	01Ch,000h
		dw	offset DGROUP:DATA_1D3E
		db	01Dh,000h
		dw	offset DGROUP:DATA_1D40
		db	01Eh,000h
		dw	offset DGROUP:DATA_1D42
		db	01Fh,000h
		dw	offset DGROUP:DATA_1D45
		db	' ',000h
		dw	offset DGROUP:DATA_1D48
		db	'!',000h
		dw	offset DGROUP:DATA_1D4A
		db	'"',000h
		dw	offset DGROUP:DATA_1D4C
		db	'#',000h
		dw	offset DGROUP:DATA_1D4F
		db	'$',000h
		dw	offset DGROUP:DATA_1D52
		db	'%',000h
		dw	offset DGROUP:DATA_1D55
		db	'&',000h
		dw	offset DGROUP:DATA_1D43
		db	027h,000h
		dw	offset DGROUP:DATA_1D46
		db	'(',000h
		dw	offset DGROUP:DATA_1D2B
		db	')',000h
		dw	offset DGROUP:DATA_1D2F
		db	'*',000h
		dw	offset DGROUP:DATA_1D58
		db	'+',000h
		dw	offset DGROUP:DATA_1D5A
		db	'-',000h
		dw	offset DGROUP:DATA_1D5C
		db	'.',000h
		dw	offset DGROUP:DATA_1D5F
		db	'/',000h
		dw	offset DGROUP:DATA_1D0E
		db	'0',000h
		dw	offset DGROUP:DATA_1D62
		db	'd',000h
		dw	offset DGROUP:DATA_1D65
		db	'f',000h
		dw	offset DGROUP:DATA_1D68
		db	'g',000h
		dw	offset DGROUP:DATA_1D6C
; @15C2
DATA_15C2	label	byte
		db	'h',000h
		dw	offset DGROUP:DATA_1D6F
		db	'i',000h
		dw	offset DGROUP:DATA_1D75
		db	'j',000h
		dw	offset DGROUP:DATA_1D7C
		db	'k',000h
		dw	offset DGROUP:DATA_1D83
		db	'l',000h
		dw	offset DGROUP:DATA_1D8A
		db	'm',000h
		dw	offset DGROUP:DATA_1D8E
		db	'n',000h
		dw	offset DGROUP:DATA_1D97
		db	'o',000h
		dw	offset DGROUP:DATA_1DA0
		db	'p',000h
		dw	offset DGROUP:DATA_1DA8
		db	'q',000h
		dw	offset DGROUP:DATA_1DB2
		db	'r',000h
		dw	offset DGROUP:DATA_1DB9
		db	's',000h
		dw	offset DGROUP:DATA_1DBE
; @15F2
DATA_15F2	label	byte
		db	'Q',000h
		dw	offset DGROUP:DATA_1DC6
		db	'R',000h
		dw	offset DGROUP:DATA_1DCA
		db	'S',000h
		dw	offset DGROUP:DATA_1DCE
		db	'U',000h
		dw	offset DGROUP:DATA_1DD2
		db	'T',000h
		dw	offset DGROUP:DATA_1DD7
		db	'W',000h
		dw	offset DGROUP:DATA_1DDB
		db	'W',000h
		dw	offset DGROUP:DATA_1DDF
		db	'H',000h
		dw	offset DGROUP:DATA_1DE4
		db	'H',000h
		dw	offset DGROUP:DATA_1DEA
		db	'N',000h
		dw	offset DGROUP:DATA_1DF1
		db	'P',000h
		dw	offset DGROUP:DATA_1DF9
		db	'P',000h
		dw	offset DGROUP:DATA_1DFD
		db	'V',000h
		dw	offset DGROUP:DATA_1E02
		db	'V',000h
		dw	offset DGROUP:DATA_1E07
		db	'F',000h
		dw	offset DGROUP:DATA_1E0D
		db	'F',000h
		dw	offset DGROUP:DATA_1E17
		db	'L',000h
		dw	offset DGROUP:DATA_1E22
		db	'O',000h
		dw	offset DGROUP:DATA_1E2A
		db	'O',000h
		dw	offset DGROUP:DATA_1E2F
		db	'G',000h
		dw	offset DGROUP:DATA_1E35
		db	'G',000h
		dw	offset DGROUP:DATA_1E3C
		db	'M',000h
		dw	offset DGROUP:DATA_1E44
; @164A
DATA_164A	label	byte
		db	'J',000h
		dw	offset DGROUP:DATA_1E4E
		db	'>',000h
		dw	offset DGROUP:DATA_1E54
		db	'K',000h
		dw	offset DGROUP:DATA_1E5B
; @1656
DATA_1656	label	byte
		db	'D',000h
		dw	offset DGROUP:DATA_1E64
		db	'E',000h
		dw	offset DGROUP:DATA_1E69
; @165E
DATA_165E	label	byte
		db	'9',000h
		dw	offset DGROUP:DATA_1E6E
		db	'`',000h
		dw	offset DGROUP:DATA_1E73
		db	'c',000h
		dw	offset DGROUP:DATA_1E79
		db	':',000h
		dw	offset DGROUP:DATA_1E7E
		db	'a',000h
		dw	offset DGROUP:DATA_1E83
		db	'b',000h
		dw	offset DGROUP:DATA_1E8C
		db	']',000h
		dw	offset DGROUP:DATA_1E94
		db	'A',000h
		dw	offset DGROUP:DATA_1E97
		db	'Z',000h
		dw	offset DGROUP:DATA_1E9E
		db	'6',000h
		dw	offset DGROUP:DATA_1EA3
		db	'@',000h
		dw	offset DGROUP:DATA_1EAA
		db	'[',000h
		dw	offset DGROUP:DATA_1EB0
		db	'X',000h
		dw	offset DGROUP:DATA_1EB4
		db	'Y',000h
		dw	offset DGROUP:DATA_1EB9
		db	'<',000h
		dw	offset DGROUP:DATA_1EBC
		db	'?',000h
		dw	offset DGROUP:DATA_1EC0
		db	'8',000h
		dw	offset DGROUP:DATA_1EC5
		db	'_',000h
		dw	offset DGROUP:DATA_1ECE
		db	';',000h
		dw	offset DGROUP:DATA_1ED5
		db	',',000h
		dw	offset DGROUP:DATA_1EDB
		db	'5',000h
		dw	offset DGROUP:DATA_1EE2
		db	'B',000h
		dw	offset DGROUP:DATA_1EE9
		db	'^',000h
		dw	offset DGROUP:DATA_1EF0
		db	'7',000h
		dw	offset DGROUP:DATA_1EF7
		db	'C',000h
		dw	offset DGROUP:DATA_1EFF
		db	'=',000h
		dw	offset DGROUP:DATA_1F05
		db	'\',000h
		dw	offset DGROUP:DATA_1F0E
; @16CA
C31_KEYWORD_GROUPS	label	byte
		dw	offset DGROUP:DATA_15F2,DGROUP
		db	016h,000h
		dw	offset DGROUP:DATA_164A,DGROUP
		db	003h,000h
		dw	offset DGROUP:DATA_1656,DGROUP
		db	002h,000h
		dw	offset DGROUP:DATA_165E,DGROUP
		db	01Bh,000h
		dw	offset DGROUP:DATA_14FE,DGROUP
		db	'1',000h
		dw	offset DGROUP:DATA_15C2,DGROUP
		db	00Ch,000h
; @16EE
OPTION_BLOCK	label	byte
		db	000h
; @16EF
OPTION_MEMORY_MODEL	label	byte
		db	001h
; @16F0
OPTION_TARGET_CPU	label	byte
		db	000h
; @16F1
NEAR_HELPER_CALLS	label	byte
		db	000h
; @16F2
BCC_PACK_FLAG	label	byte
		db	000h
; @16F3
OPTION_FLOAT_MODE	label	byte
		db	001h
; @16F4
OPTION_FAST_FLOAT	label	byte
		db	001h
; @16F5
LANGUAGE_MODE	label	byte
		db	000h
; @16F6
UNSIGNED_CHAR	label	byte
		db	000h
; @16F7
COMMENT_NESTED	label	byte
		db	000h,001h
; @16F9
OPTION_ERROR_LIMIT	label	byte
		db	019h
; @16FA
OPTION_WARNING_LIMIT	label	byte
		db	'd'
; @16FB
NAME_LIMIT	label	byte
		db	' '
; @16FC
C51_SKIP_LINK	label	byte
		db	000h
; @16FD
DATA_16FD	label	byte
		db	000h
; @16FE
OPTION_NO_AUTODEPEND	label	byte
		db	000h
; @16FF
OPTION_STACK_CHECK	label	byte
		db	000h
; @1700
OPTION_SOURCE_DEBUG	label	byte
		db	000h
; @1701
OPTION_LINE_NUMBERS	label	byte
		db	000h
; @1702
OPTION_OPTIMIZE_SPEED	label	byte
		db	000h
; @1703
OPTIMIZE_ENABLED	label	byte
		db	000h
; @1704
OPTION_SUPPRESS_RELOADS	label	byte
		db	000h
; @1705
OPTION_CALLING_CONVENTION	label	byte
		db	000h
; @1706
OPTION_STANDARD_FRAME	label	byte
		db	001h
; @1707
OPTION_REGISTER_VARS	label	byte
		db	001h
; @1708
OPTION_MERGE_STRINGS	label	byte
		db	000h
; @1709
OPTION_OVERLAY_CODE	label	byte
		db	000h
; @170A
C52_OS2_OPTION	label	byte
		db	000h
; @170B
C52_MULTITHREAD_OPTION	label	byte
		db	000h
; @170C
C52_DLL_OPTION	label	byte
		db	000h,000h,000h,000h,000h,000h
; @1712
HUGE_PTR_AHSHIFT_MODE	label	byte
		db	000h
; @1713
OPTION_DS_NOT_SS	label	byte
		db	000h
; @1714
COMPILER_MODE	label	byte
		db	000h
; @1715
OPTION_COMPILE_VIA_ASM	label	byte
		db	000h
; @1716
OPTION_UNDERSCORES	label	byte
		db	001h,000h,000h,000h
; @171A
C52_CODE_NAME_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @171E
C52_CODE_GROUP_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @1722
C52_CODE_CLASS_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @1726
C52_DATA_NAME_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @172A
C52_DATA_GROUP_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @172E
C52_DATA_CLASS_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @1732
C52_BSS_NAME_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @1736
C52_BSS_GROUP_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @173A
C52_BSS_CLASS_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @173E
C52_FAR_NAME_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @1742
C52_FAR_GROUP_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @1746
C52_FAR_CLASS_OPTION	label	byte
		dw	offset DGROUP:DATA_1D36,DGROUP
; @174A
OPTION_OUTPUT_DIR	label	byte
		dw	offset DGROUP:STR_EMPTY_MACRO_VALUE,DGROUP
; @174E
OPTION_OBJECT_NAME	label	byte
		db	000h,000h,000h,000h
		dw	offset DGROUP:STR_EMPTY_MACRO_VALUE,DGROUP
; @1756
INCLUDE_OPTION_TEXT_PTR	label	byte
		dw	offset DGROUP:STR_EMPTY_MACRO_VALUE,DGROUP
		db	000h,000h,000h,000h
; @175E
LINK_OUTPUT_NAME	label	byte
		db	000h,000h,000h,000h
; @1762
OPTION_FLAGS	label	byte
		db	000h
; @1763
VTABLE_MODE	label	byte
		db	003h
; @1764
OPTION_ENUMS_AS_INT	label	byte
		db	001h
; @1765
PCH_OPTION_MODE	label	byte
		db	000h
; @1766
PCH_FILE_NAME	label	byte
		db	000h,000h,000h,000h
; @176A
EMS_PAGE_LIMIT	label	byte
		db	000h,000h
; @176C
EXT_MEMORY_BASE	label	byte
		db	0FFh,0FFh,0FFh,0FFh
; @1770
EXT_MEMORY_BANK_SIZE	label	byte
		db	000h,000h,000h,000h
; @1774
OPTION_LINK_OVERLAY	label	byte
		db	000h
; @1775
OPTION_EXPAND_INLINES	label	byte
		db	001h
; @1776
OPTION_WINDOWS_MODE	label	byte
		db	000h
; @1777
C31_MEMORY_OPTION	label	byte
		db	001h
; @1778
OPTION_FLAG	label	byte
		db	000h
; @1779
OPTION_COMDEFS	label	byte
		db	000h
; @177A
OPTION_SS_EQUALS_DS	label	byte
		db	000h
; @177B
OPTION_AUTO_FAR_DATA	label	byte
		db	000h
; @177C
FAR_DATA_THRESHOLD	label	byte
		db	0FFh,07Fh
; @177E
COMMAND_OPTION_TABLE	label	byte
		db	'A',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1A76
		db	000h,000h,'f',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1AB6
		db	000h,000h,'m',001h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1B2E
		db	000h,000h,'r',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1B96
		db	000h,000h,'z',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1BC6
		db	000h,000h,'1',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_TARGET_CPU
		db	000h,000h,'2',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_TARGET_CPU
		db	002h,000h,'C',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:COMMENT_NESTED
		db	000h,000h,'G',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_OPTIMIZE_SPEED
		db	000h,000h,'K',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:UNSIGNED_CHAR
		db	000h,000h,'N',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_STACK_CHECK
		db	000h,000h,'O',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1AF6
		db	000h,000h,'Z',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_SUPPRESS_RELOADS
		db	000h,000h,'a',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:BCC_PACK_FLAG
		db	000h,000h,'b',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_ENUMS_AS_INT
		db	000h,000h,'d',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_MERGE_STRINGS
		db	000h,000h,'k',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_STANDARD_FRAME
		db	000h,000h,'p',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1A2E
		db	000h,000h,'u',001h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_UNDERSCORES
		db	000h,000h,'v',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1C5E
		db	000h,000h,'y',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_LINE_NUMBERS
		db	000h,000h,'n',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:OPTION_OUTPUT_DIR
		db	000h,000h,'o',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:OPTION_OBJECT_NAME
		db	000h,000h,'g',002h
		dw	005F3h	; @code SET_BYTE_NUMBER_OPTION
		dw	offset DGROUP:OPTION_WARNING_LIMIT
		db	0FFh,000h,'i',001h
		dw	005F3h	; @code SET_BYTE_NUMBER_OPTION
		dw	offset DGROUP:NAME_LIMIT
		db	' ',000h,'j',002h
		dw	005F3h	; @code SET_BYTE_NUMBER_OPTION
		dw	offset DGROUP:OPTION_ERROR_LIMIT
		db	0FFh,000h,'w',002h
		dw	00451h	; @code HANDLE_WARNING_OPTION
		db	000h,000h,000h,000h,'Y',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:DATA_82D4
		db	000h,000h,'Y',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	000h,000h,'Y',001h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1A46
		db	000h,000h,'B',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_COMPILE_VIA_ASM
		db	000h,000h,'S',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:COMPILER_MODE
		db	000h,000h,'y',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:DATA_24CF
		db	000h,000h,'E',000h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:TASM_PROGRAM_NAME
		db	000h,000h,'M',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:DATA_16FD
		db	001h,000h,'M',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:DATA_24D0
		db	000h,000h,'M',000h,015h,004h
		dw	offset DGROUP:DATA_24DB
		db	000h,000h,'c',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:C51_SKIP_LINK
		db	000h,000h,'e',000h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:LINK_OUTPUT_NAME
		db	000h,000h,'D',000h
		dw	00929h	; @code DEFINE_MACROS_OPTION
		db	000h,000h,000h,000h,'I',000h
		dw	009FDh	; @code BCC_SET_OPTION_INCLUDE
		db	000h,000h,000h,000h,'L',000h
		dw	00A21h	; @code BCC_SET_OPTION_LIBRARY_PATH
		db	000h,000h,000h,000h,'U',000h
		dw	009E6h	; @code UNDEFINE_MACRO_OPTION
		db	000h,000h,000h,000h,'l',000h
		dw	007C4h	; @code BCC_SET_OPTION_LIBRARY
		db	000h,000h,000h,000h,'T',000h
		dw	0069Bh	; @code ADD_NAME_LIST_OPTION
		db	000h,000h,000h,000h,'h',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:HUGE_PTR_AHSHIFT_MODE
		db	000h,000h,'P',000h
		dw	0073Dh	; @code HANDLE_CPP_EXT_OPTION
		db	000h,000h,000h,000h,'X',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_NO_AUTODEPEND
		db	000h,000h,'V',000h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1C2E
		db	000h,000h,'H',000h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1CAE
		db	000h,000h,'Q',000h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1CDE
		db	000h,000h,'W',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_OVERLAY_CODE
		db	000h,000h,'W',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:DATA_82D4
		db	001h,000h,'W',001h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_19F6
		db	000h,000h,'F',000h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1996
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @193E
DATA_193E	label	byte
		db	'-',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_AUTO_FAR_DATA
		db	000h,000h,000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_AUTO_FAR_DATA
		db	001h,000h,'=',000h
		dw	00647h	; @code SET_INT_NUMBER_OPTION
		dw	offset DGROUP:FAR_DATA_THRESHOLD
		db	0FFh,0FFh,000h,000h,000h,000h,000h,000h,000h,000h
; @195E
DATA_195E	label	byte
		db	'-',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_COMDEFS
		db	000h,000h,'-',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_SS_EQUALS_DS
		db	000h,000h,'-',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_AUTO_FAR_DATA
		db	000h,000h,000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_COMDEFS
		db	001h,000h,000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_SS_EQUALS_DS
		db	001h,000h,000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_AUTO_FAR_DATA
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1996
DATA_1996	label	byte
		db	'c',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_COMDEFS
		db	000h,000h,'s',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_SS_EQUALS_DS
		db	000h,000h,'f',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_AUTO_FAR_DATA
		db	001h,000h,'f',000h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_193E
		db	000h,000h,'m',000h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_195E
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @19C6
DATA_19C6	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	002h,000h,'E',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	005h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @19DE
DATA_19DE	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	003h,000h,'D',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	005h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @19F6
DATA_19F6	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	001h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	000h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:DATA_82D4
		db	000h,000h,'S',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		db	004h,000h,'D',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_19C6
		db	000h,000h,'E',002h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_19DE
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1A2E
DATA_1A2E	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_CALLING_CONVENTION
		db	001h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_CALLING_CONVENTION
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1A46
DATA_1A46	label	byte
		db	000h,001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_OVERLAY_CODE
		db	001h,000h,'-',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_OVERLAY_CODE
		db	000h,000h,'f',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_OVERLAY_CODE
		db	001h,000h,'n',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_OVERLAY_CODE
		db	002h,000h,'o',001h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_LINK_OVERLAY
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1A76
DATA_1A76	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:LANGUAGE_MODE
		db	001h,000h,'+',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:LANGUAGE_MODE
		db	001h,000h,'K',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:LANGUAGE_MODE
		db	003h,000h,'T',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:LANGUAGE_MODE
		db	000h,000h,'U',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:LANGUAGE_MODE
		db	002h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:LANGUAGE_MODE
		db	000h,000h,'.',002h
		dw	00538h	; @code RESTORE_OPTION_DEFAULT
		dw	offset DGROUP:LANGUAGE_MODE
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1AB6
DATA_1AB6	label	byte
		db	000h,001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_FLOAT_MODE
		db	001h,000h,'+',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_FLOAT_MODE
		db	001h,000h,'2',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_FLOAT_MODE
		db	003h,000h,'8',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_FLOAT_MODE
		db	002h,000h,'-',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_FLOAT_MODE
		db	000h,000h,'.',001h
		dw	00538h	; @code RESTORE_OPTION_DEFAULT
		dw	offset DGROUP:OPTION_FLOAT_MODE
		db	000h,000h,'f',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_FAST_FLOAT
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1AF6
DATA_1AF6	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTIMIZE_ENABLED
		db	001h,000h,'0',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTIMIZE_ENABLED
		db	000h,000h,'1',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTIMIZE_ENABLED
		db	001h,000h,'2',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTIMIZE_ENABLED
		db	002h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTIMIZE_ENABLED
		db	000h,000h,'.',002h
		dw	00538h	; @code RESTORE_OPTION_DEFAULT
		dw	offset DGROUP:OPTIMIZE_ENABLED
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1B2E
DATA_1B2E	label	byte
		db	'c',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		db	003h,000h,'h',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		db	005h,000h,'l',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		db	004h,000h,'m',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		db	002h,000h,'s',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		db	001h,000h,'t',001h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		db	000h,000h,'m',001h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1B7E
		db	000h,000h,'s',001h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1B7E
		db	000h,000h,'t',001h
		dw	00567h	; @code HANDLE_SUBTABLE_OPTION
		dw	offset DGROUP:DATA_1B7E
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1B7E
DATA_1B7E	label	byte
		db	000h,001h
		dw	0059Ah	; @code IGNORE_OPTION
		db	000h,000h,000h,000h,'!',001h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_DS_NOT_SS
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1B96
DATA_1B96	label	byte
		db	'd',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_REGISTER_VARS
		db	002h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_REGISTER_VARS
		db	000h,000h,'+',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_REGISTER_VARS
		db	001h,000h,000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_REGISTER_VARS
		db	001h,000h,'.',002h
		dw	00538h	; @code RESTORE_OPTION_DEFAULT
		dw	offset DGROUP:OPTION_REGISTER_VARS
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1BC6
DATA_1BC6	label	byte
		db	'D',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_BSS_NAME_OPTION
		db	000h,000h,'G',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_BSS_GROUP_OPTION
		db	000h,000h,'B',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_BSS_CLASS_OPTION
		db	000h,000h,'C',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_CODE_NAME_OPTION
		db	000h,000h,'P',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_CODE_GROUP_OPTION
		db	000h,000h,'A',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_CODE_CLASS_OPTION
		db	000h,000h,'R',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_DATA_NAME_OPTION
		db	000h,000h,'S',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_DATA_GROUP_OPTION
		db	000h,000h,'T',001h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_DATA_CLASS_OPTION
		db	000h,000h,'E',002h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_FAR_NAME_OPTION
		db	000h,000h,'H',002h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_FAR_GROUP_OPTION
		db	000h,000h,'F',002h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:C52_FAR_CLASS_OPTION
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1C2E
DATA_1C2E	label	byte
		db	000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:VTABLE_MODE
		db	003h,000h,'0',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:VTABLE_MODE
		db	001h,000h,'1',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:VTABLE_MODE
		db	002h,000h,'s',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:VTABLE_MODE
		db	000h,000h,'f',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_FLAG
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1C5E
DATA_1C5E	label	byte
		db	000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_SOURCE_DEBUG
		db	001h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_SOURCE_DEBUG
		db	000h,000h,'.',002h
		dw	00538h	; @code RESTORE_OPTION_DEFAULT
		dw	offset DGROUP:OPTION_SOURCE_DEBUG
		db	000h,000h,000h,002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_EXPAND_INLINES
		db	000h,000h,'-',002h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:OPTION_EXPAND_INLINES
		db	001h,000h,'.',002h
		dw	00538h	; @code RESTORE_OPTION_DEFAULT
		dw	offset DGROUP:OPTION_EXPAND_INLINES
		db	000h,000h,'i',002h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:OPTION_EXPAND_INLINES
		db	000h,000h,'-',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:DATA_24D9
		db	000h,000h,000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:DATA_24D9
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1CAE
DATA_1CAE	label	byte
		db	'-',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:PCH_OPTION_MODE
		db	000h,000h,'u',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:PCH_OPTION_MODE
		db	004h,000h,'=',000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:PCH_OPTION_MODE
		db	002h,000h,'=',000h
		dw	005A6h	; @code SET_STRING_OPTION
		dw	offset DGROUP:PCH_FILE_NAME
		db	000h,000h,000h,000h
		dw	00581h	; @code SET_OPTION_VALUE
		dw	offset DGROUP:PCH_OPTION_MODE
		db	002h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1CDE
DATA_1CDE	label	byte
		db	'e',000h
		dw	00F11h	; @code HANDLE_EMS_OPTION
		db	000h,000h,000h,000h,'x',000h
		dw	00F9Fh	; @code HANDLE_EXT_MEMORY_OPTION
		db	000h,000h,000h,000h,'s',000h
		dw	0039Ch	; @code HANDLE_FLAG_OPTION
		dw	offset DGROUP:C31_MEMORY_OPTION
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @1CFE
DATA_1CFE	label	byte
		db	'('
; @1CFF
DATA_1CFF	label	byte
		db	')'
; @1D00
STR_EMPTY_MACRO_VALUE	label	byte
		db	000h
; @1D01
DATA_1D01	label	byte
		db	'['
; @1D02
DATA_1D02	label	byte
		db	']',000h
; @1D04
DATA_1D04	label	byte
		db	'{',000h
; @1D06
DATA_1D06	label	byte
		db	'}',000h
; @1D08
DATA_1D08	label	byte
		db	';',000h
; @1D0A
DATA_1D0A	label	byte
		db	',',000h
; @1D0C
DATA_1D0C	label	byte
		db	'..'
; @1D0E
DATA_1D0E	label	byte
		db	'.',000h
; @1D10
DATA_1D10	label	byte
		db	'=',000h
; @1D12
DATA_1D12	label	byte
		db	'+=',000h
; @1D15
DATA_1D15	label	byte
		db	'-=',000h
; @1D18
DATA_1D18	label	byte
		db	'*=',000h
; @1D1B
DATA_1D1B	label	byte
		db	'/=',000h
; @1D1E
DATA_1D1E	label	byte
		db	'%=',000h
; @1D21
DATA_1D21	label	byte
		db	'&=',000h
; @1D24
DATA_1D24	label	byte
		db	'|=',000h
; @1D27
DATA_1D27	label	byte
		db	'^=',000h
; @1D2A
DATA_1D2A	label	byte
		db	'<'
; @1D2B
DATA_1D2B	label	byte
		db	'<=',000h
; @1D2E
DATA_1D2E	label	byte
		db	'>'
; @1D2F
DATA_1D2F	label	byte
		db	'>=',000h
; @1D32
DATA_1D32	label	byte
		db	'+',000h
; @1D34
DATA_1D34	label	byte
		db	'-',000h
; @1D36
DATA_1D36	label	byte
		db	'*',000h
; @1D38
DATA_1D38	label	byte
		db	'/',000h
; @1D3A
DATA_1D3A	label	byte
		db	'%',000h
; @1D3C
DATA_1D3C	label	byte
		db	'&',000h
; @1D3E
DATA_1D3E	label	byte
		db	'|',000h
; @1D40
DATA_1D40	label	byte
		db	'^',000h
; @1D42
DATA_1D42	label	byte
		db	'<'
; @1D43
DATA_1D43	label	byte
		db	'<',000h
; @1D45
DATA_1D45	label	byte
		db	'>'
; @1D46
DATA_1D46	label	byte
		db	'>',000h
; @1D48
DATA_1D48	label	byte
		db	'?',000h
; @1D4A
DATA_1D4A	label	byte
		db	':',000h
; @1D4C
DATA_1D4C	label	byte
		db	'||',000h
; @1D4F
DATA_1D4F	label	byte
		db	'&&',000h
; @1D52
DATA_1D52	label	byte
		db	'==',000h
; @1D55
DATA_1D55	label	byte
		db	'!=',000h
; @1D58
DATA_1D58	label	byte
		db	'!',000h
; @1D5A
DATA_1D5A	label	byte
		db	'~',000h
; @1D5C
DATA_1D5C	label	byte
		db	'++',000h
; @1D5F
DATA_1D5F	label	byte
		db	'--',000h
; @1D62
DATA_1D62	label	byte
		db	'->',000h
; @1D65
DATA_1D65	label	byte
		db	'.*',000h
; @1D68
DATA_1D68	label	byte
		db	'->*',000h
; @1D6C
DATA_1D6C	label	byte
		db	'::',000h
; @1D6F
DATA_1D6F	label	byte
		db	'class',000h
; @1D75
DATA_1D75	label	byte
		db	'delete',000h
; @1D7C
DATA_1D7C	label	byte
		db	'friend',000h
; @1D83
DATA_1D83	label	byte
		db	'inline',000h
; @1D8A
DATA_1D8A	label	byte
		db	'new',000h
; @1D8E
DATA_1D8E	label	byte
		db	'operator',000h
; @1D97
DATA_1D97	label	byte
		db	'overload',000h
; @1DA0
DATA_1DA0	label	byte
		db	'private',000h
; @1DA8
DATA_1DA8	label	byte
		db	'protected',000h
; @1DB2
DATA_1DB2	label	byte
		db	'public',000h
; @1DB9
DATA_1DB9	label	byte
		db	'this',000h
; @1DBE
DATA_1DBE	label	byte
		db	'virtual',000h
; @1DC6
DATA_1DC6	label	byte
		db	'_cs',000h
; @1DCA
DATA_1DCA	label	byte
		db	'_ds',000h
; @1DCE
DATA_1DCE	label	byte
		db	'_es',000h
; @1DD2
DATA_1DD2	label	byte
		db	'_se'
; @1DD5
STR_INCLUDE_GIVEN_MARK	label	byte
		db	'g',000h
; @1DD7
DATA_1DD7	label	byte
		db	'_ss',000h
; @1DDB
DATA_1DDB	label	byte
		db	'asm',000h
; @1DDF
DATA_1DDF	label	byte
		db	'_asm',000h
; @1DE4
DATA_1DE4	label	byte
		db	'cdecl',000h
; @1DEA
DATA_1DEA	label	byte
		db	'_cdecl',000h
; @1DF1
DATA_1DF1	label	byte
		db	'_export',000h
; @1DF9
DATA_1DF9	label	byte
		db	'far',000h
; @1DFD
DATA_1DFD	label	byte
		db	'_far',000h
; @1E02
DATA_1E02	label	byte
		db	'huge',000h
; @1E07
DATA_1E07	label	byte
		db	'_huge',000h
; @1E0D
DATA_1E0D	label	byte
		db	'interrupt',000h
; @1E17
DATA_1E17	label	byte
		db	'_interrupt',000h
; @1E22
DATA_1E22	label	byte
		db	'_loadds',000h
; @1E2A
DATA_1E2A	label	byte
		db	'near',000h
; @1E2F
DATA_1E2F	label	byte
		db	'_near',000h
; @1E35
DATA_1E35	label	byte
		db	'pascal',000h
; @1E3C
DATA_1E3C	label	byte
		db	'_pascal',000h
; @1E44
DATA_1E44	label	byte
		db	'_saveregs',000h
; @1E4E
DATA_1E4E	label	byte
		db	'const',000h
; @1E54
DATA_1E54	label	byte
		db	'signed',000h
; @1E5B
DATA_1E5B	label	byte
		db	'volatile',000h
; @1E64
DATA_1E64	label	byte
		db	'enum',000h
; @1E69
DATA_1E69	label	byte
		db	'void',000h
; @1E6E
DATA_1E6E	label	byte
		db	'auto',000h
; @1E73
DATA_1E73	label	byte
		db	'break',000h
; @1E79
DATA_1E79	label	byte
		db	'case',000h
; @1E7E
DATA_1E7E	label	byte
		db	'char',000h
; @1E83
DATA_1E83	label	byte
		db	'continue',000h
; @1E8C
DATA_1E8C	label	byte
		db	'default',000h
; @1E94
DATA_1E94	label	byte
		db	'do',000h
; @1E97
DATA_1E97	label	byte
		db	'double',000h
; @1E9E
DATA_1E9E	label	byte
		db	'else',000h
; @1EA3
DATA_1EA3	label	byte
		db	'extern',000h
; @1EAA
DATA_1EAA	label	byte
		db	'float',000h
; @1EB0
DATA_1EB0	label	byte
		db	'for',000h
; @1EB4
DATA_1EB4	label	byte
		db	'goto',000h
; @1EB9
DATA_1EB9	label	byte
		db	'if',000h
; @1EBC
DATA_1EBC	label	byte
		db	'int',000h
; @1EC0
DATA_1EC0	label	byte
		db	'long',000h
; @1EC5
DATA_1EC5	label	byte
		db	'register',000h
; @1ECE
DATA_1ECE	label	byte
		db	'return',000h
; @1ED5
DATA_1ED5	label	byte
		db	'short',000h
; @1EDB
DATA_1EDB	label	byte
		db	'sizeof',000h
; @1EE2
DATA_1EE2	label	byte
		db	'static',000h
; @1EE9
DATA_1EE9	label	byte
		db	'struct',000h
; @1EF0
DATA_1EF0	label	byte
		db	'switch',000h
; @1EF7
DATA_1EF7	label	byte
		db	'typedef',000h
; @1EFF
DATA_1EFF	label	byte
		db	'union',000h
; @1F05
DATA_1F05	label	byte
		db	'unsigned',000h
; @1F0E
DATA_1F0E	label	byte
		db	'while',000h
; @1F14
STR_CPP	label	byte
		db	'.cpp',000h
; @1F19
STR_BACKSLASH	label	byte
		db	'\',000h,000h
; @1F1C
DISCARD_CHAR_EMIT_FN	label	byte
		dd	SCAN_EMPTY
; @1F20
DIRECTIVE_TABLE	label	byte
		dw	offset DGROUP:STR_PRAGMA
		db	00Bh
		dw	00654h	; @code PARSE_PRAGMA
		dw	offset DGROUP:DATA_1F8B
		db	00Ch
		dw	006BBh	; @code PARSE_ERROR_DIRECTIVE
		dw	offset DGROUP:DATA_1F91
		db	001h
		dw	0079Ah	; @code DIRECTIVE_INCLUDE
		dw	offset DGROUP:STR_DEFINE
		db	002h
		dw	0097Ah	; @code BCC_PARSE_MACRO
		dw	offset DGROUP:DATA_1FA0
		db	003h
		dw	00BD1h	; @code PARSE_UNDEF
		dw	offset DGROUP:DATA_1FA6
		db	007h
		dw	00C60h	; @code PARSE_CONDITIONAL
		dw	offset DGROUP:DATA_1FA9
		db	004h
		dw	00D2Ah	; @code PARSE_IFDEF_DIRECTIVE
		dw	offset DGROUP:DATA_1FAF
		db	005h
		dw	00D3Dh	; @code PARSE_IFNDEF_DIRECTIVE
		dw	offset DGROUP:DATA_1FB6
		db	008h
		dw	00D4Fh	; @code PARSE_ELSE
		dw	offset DGROUP:DATA_1FBB
		db	00Ah
		dw	00DA1h	; @code PARSE_ELIF
		dw	offset DGROUP:DATA_1FC0
		db	006h
		dw	00E04h	; @code PARSE_ENDIF
		dw	offset DGROUP:STR_LINE
		db	009h
		dw	00E37h	; @code BCC_PARSE_LINE
; @1F5C
PRAGMA_TABLE	label	byte
		dw	0013Ah	; @code PRAGMA_WARN
		dw	offset DGROUP:DATA_1FF8
		dw	00214h	; @code CHECK_NAME_CONTEXT
		dw	offset DGROUP:DATA_1FFD
		dw	00362h	; @code PRAGMA_SAVEREGS
		dw	offset DGROUP:DATA_2004
		dw	00373h	; @code PRAGMA_OPTION
		dw	offset DGROUP:DATA_200D
		dw	0033Dh	; @code PRAGMA_STARTUP
		dw	offset DGROUP:DATA_2014
		dw	0034Fh	; @code PRAGMA_EXIT
		dw	offset DGROUP:DATA_201C
		dw	00443h	; @code PRAGMA_ARGSUSED
		dw	offset DGROUP:DATA_2021
		dw	00454h	; @code PRAGMA_NORETVAL
		dw	offset DGROUP:DATA_202A
		dw	004B0h	; @code PRAGMA_CODESEG
		dw	offset DGROUP:DATA_2033
		db	000h,000h,000h,000h
; @1F84
STR_PRAGMA	label	byte
		db	'pragma',000h
; @1F8B
DATA_1F8B	label	byte
		db	'error',000h
; @1F91
DATA_1F91	label	byte
		db	'include',000h
; @1F99
STR_DEFINE	label	byte
		db	'define',000h
; @1FA0
DATA_1FA0	label	byte
		db	'undef',000h
; @1FA6
DATA_1FA6	label	byte
		db	'if',000h
; @1FA9
DATA_1FA9	label	byte
		db	'ifdef',000h
; @1FAF
DATA_1FAF	label	byte
		db	'ifndef',000h
; @1FB6
DATA_1FB6	label	byte
		db	'else',000h
; @1FBB
DATA_1FBB	label	byte
		db	'elif',000h
; @1FC0
DATA_1FC0	label	byte
		db	'endif',000h
; @1FC6
STR_LINE	label	byte
		db	'line',000h
; @1FCB
STR_MISSING_FUNCTION	label	byte
		db	'missing function identifier',000h
; @1FE7
STR_PRAGMA_DIRECTIVE	label	byte
		db	'pragma directive',000h
; @1FF8
DATA_1FF8	label	byte
		db	'warn',000h
; @1FFD
DATA_1FFD	label	byte
		db	'inline',000h
; @2004
DATA_2004	label	byte
		db	'saveregs',000h
; @200D
DATA_200D	label	byte
		db	'option',000h
; @2014
DATA_2014	label	byte
		db	'startup',000h
; @201C
DATA_201C	label	byte
		db	'exit',000h
; @2021
DATA_2021	label	byte
		db	'argsused',000h
; @202A
DATA_202A	label	byte
		db	'noretval',000h
; @2033
DATA_2033	label	byte
		db	'codeseg',000h,000h
; @203C
LITERAL_CHAR_EMIT_PTR	label	byte
		dd	SCAN_EMIT
; @2040
MONTH_ABBREVIATIONS	label	byte
		db	'JanFebMarAprMayJunJulAugSepOctNovDec'
; @2064
TOKEN_START_FLAGS	label	byte
		db	001h,001h,001h,001h,001h,001h,001h,001h,003h,001h,001h,002h
		db	002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h
		db	002h,002h,002h,002h,002h,002h,002h,002h,002h,003h,002h,002h
		db	002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h
		db	002h,004h,004h,004h,004h,010h,010h,010h,010h,010h,'            @@@@'
		db	0A0h,0A0h,080h,080h,080h,0C0h,0C0h,080h,080h,080h,080h,080h
		db	0C0h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h
		db	008h,008h,002h,004h,002h,003h,' ',002h,010h,010h,002h,' ',010h
		db	010h,010h,010h,004h,010h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h
; @20E6
SINGLE_CHAR_TOKEN_TABLE	label	byte
		db	'*',01Ah,01Bh,018h,016h,019h,01Dh,01Ch,00Bh
; @20EF
OP_ASSIGN_TOKEN_TABLE	label	byte
		db	'%',010h,011h,00Eh,00Ch,00Fh,013h,012h,'$'
; @20F8
DOUBLED_CHAR_TOKEN_TABLE	label	byte
		db	000h,000h,'#',000h,'-',000h,000h,'"'
; @2100
CHAR_CLASS	label	byte
		db	'$',0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0F7h,0ECh,0F7h
		db	0F7h,0ECh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0E7h,0EEh,0EEh,0EEh,0EEh,0EEh,0F7h,000h,0F4h,0EEh
		db	0EEh,0FFh,0FEh,0F2h,001h,002h,0FDh,0FCh,008h,0F1h,0F0h,0FBh
		db	0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0DEh,007h
		db	0EFh,0F8h,0EDh,' ',0EEh,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,003h,0EAh,004h,0FAh,0F6h,0EEh
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,005h,0F9h,006h,'+',0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh
		db	0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0EEh,0F7h,0EEh,0EEh
		db	0EEh
; @2200
LEX_READ_MODE0_CLASSES	label	byte
		db	0EEh,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0DFh,0ECh
		db	0DFh,0DFh,0ECh,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E7h,0E6h,0E6h,0E6h,0E6h,0E6h,0DFh,0E6h,0E1h
		db	0E3h,0E6h,0E6h,0E6h,0E1h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E2h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0E6h,0E4h,0E6h,0E6h
		db	0F6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h
; @2300
LEX_READ_MODE1_CLASSES	label	byte
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0ECh
		db	0E6h,0E6h,0ECh,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,008h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E5h
		db	0E6h,0E6h,0E6h,0E6h,0E5h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E2h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0F5h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0E6h,0E6h,0E6h,0E6h
		db	0F6h,0E6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h,0F6h
		db	0F6h,0F6h,0F6h,0F6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h,0E6h
		db	0F7h,0E6h,0E6h,0E6h,0E6h
; @2401
PREDEFINED_1	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,080h,0FFh,07Fh
; @240B
PRED_NAME_1	label	byte
		db	'STDC__',000h
; @2412
PRED_NAME_2	label	byte
		db	'cplusplus',000h
; @241C
PRED_NAME_3	label	byte
		db	'FILE__',000h
; @2423
PRED_NAME_4	label	byte
		db	'LINE__',000h
; @242A
PRED_NAME_5	label	byte
		db	'DATE__',000h
; @2431
PRED_NAME_6	label	byte
		db	'TIME__',000h
; @2438
STR_DEFINED	label	byte
		db	'defined',000h
; @2440
EOF_BUFFER_TEXT	label	byte
		db	00Ah,01Ah
; @2442
STR_NEWLINE_INPUT	label	byte
		db	00Ah,000h
; @2444
STR_DOUBLE_QUOTE	label	byte
		db	'"',000h
; @2446
STR_BLANK_COMMENT_LINE	label	byte
		db	'   ;',009h
; @244B
STR_CRLF_ECHO	label	byte
		db	00Dh,00Ah,000h
; @244E
STR_COMMENT_INDENT	label	byte
		db	'   ;',009h,000h
; @2454
ARGUMENT_LIST	label	byte
		db	000h,000h,000h,000h
; @2458
ARGUMENT_LIST_TAIL	label	byte
		db	000h,000h,000h,000h
; @245C
C51_DOS_LIBRARIES	label	byte
		dw	offset DGROUP:DATA_2516
		dw	offset DGROUP:DATA_251E
		dw	offset DGROUP:DATA_2525
		dw	offset DGROUP:DATA_252F
		dw	offset DGROUP:DATA_251E
		dw	offset DGROUP:DATA_2525
		dw	offset DGROUP:DATA_2537
		dw	offset DGROUP:DATA_253F
		dw	offset DGROUP:DATA_2546
		dw	offset DGROUP:DATA_2550
		dw	offset DGROUP:DATA_2558
		dw	offset DGROUP:DATA_255F
		dw	offset DGROUP:DATA_2569
		dw	offset DGROUP:DATA_2571
		dw	offset DGROUP:DATA_2578
		dw	offset DGROUP:DATA_2582
		dw	offset DGROUP:DATA_258A
		dw	offset DGROUP:DATA_2591
; @2480
STARTUP_SS_DS_NAMES	label	byte
		dw	offset DGROUP:DATA_259B
		dw	offset DGROUP:DATA_25A4
		dw	offset DGROUP:DATA_25AD
		dw	offset DGROUP:DATA_25B6
		dw	offset DGROUP:DATA_25BF
		dw	offset DGROUP:DATA_25C8
; @248C
C51_WINDOWS_LIBRARIES	label	byte
		dw	offset DGROUP:DATA_25D1
		dw	offset DGROUP:DATA_251E
		dw	offset DGROUP:DATA_2525
		dw	offset DGROUP:DATA_25DA
		dw	offset DGROUP:DATA_251E
		dw	offset DGROUP:DATA_2525
		dw	offset DGROUP:DATA_25E3
		dw	offset DGROUP:DATA_253F
		dw	offset DGROUP:DATA_2546
		dw	offset DGROUP:DATA_25EC
		dw	offset DGROUP:DATA_2558
		dw	offset DGROUP:DATA_255F
		dw	offset DGROUP:DATA_25F5
		dw	offset DGROUP:DATA_2571
		dw	offset DGROUP:DATA_2578
		dw	offset DGROUP:DATA_25FE
		dw	offset DGROUP:DATA_258A
		dw	offset DGROUP:DATA_2591
; @24B0
C51_WINDOWS_RUNTIME	label	byte
		dw	offset DGROUP:DATA_2607
		dw	offset DGROUP:DATA_2607
		dw	offset DGROUP:DATA_2611
		dw	offset DGROUP:DATA_261B
		dw	offset DGROUP:DATA_2625
		dw	offset DGROUP:DATA_262F
; @24BC
TASM_PROGRAM_NAME	label	byte
		dw	offset DGROUP:DATA_2639,DGROUP
; @24C0
C53_OPTION_PATH	label	byte
		dw	offset DGROUP:DATA_2642,DGROUP
; @24C4
LINKER_SWITCH_FLAGS	label	byte
		db	000h,000h,001h,000h,000h,000h,000h,000h,000h,000h,000h
; @24CF
DATA_24CF	label	byte
		db	000h
; @24D0
DATA_24D0	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h
; @24D9
DATA_24D9	label	byte
		db	000h,000h
; @24DB
DATA_24DB	label	byte
		db	001h,000h,000h
; @24DE
C51_UPPER_LINK_OPTIONS	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h
; @24F8
C51_DIGIT_LINK_OPTIONS	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,'``````TC2.0'
		db	000h
; @250E
LINK_LIBRARY_ARG_SEEN	label	byte
		db	000h,000h
; @2510
C51_DLL_MODEL	label	byte
		db	003h,003h,004h,003h,004h,005h
; @2516
DATA_2516	label	byte
		db	'c0t'
; @2519
STR_OBJ_2	label	byte
		db	'.obj',000h
; @251E
DATA_251E	label	byte
		db	'cs'
; @2520
SPECIAL_NAME	label	byte
		db	'.lib',000h
; @2525
DATA_2525	label	byte
		db	'maths.lib',000h
; @252F
DATA_252F	label	byte
		db	'c0s.obj',000h
; @2537
DATA_2537	label	byte
		db	'c0m.obj',000h
; @253F
DATA_253F	label	byte
		db	'cm.lib',000h
; @2546
DATA_2546	label	byte
		db	'mathm.lib',000h
; @2550
DATA_2550	label	byte
		db	'c0c.obj',000h
; @2558
DATA_2558	label	byte
		db	'cc.lib',000h
; @255F
DATA_255F	label	byte
		db	'mathc.lib',000h
; @2569
DATA_2569	label	byte
		db	'c0l.obj',000h
; @2571
DATA_2571	label	byte
		db	'cl.lib',000h
; @2578
DATA_2578	label	byte
		db	'mathl.lib',000h
; @2582
DATA_2582	label	byte
		db	'c0h.obj',000h
; @258A
DATA_258A	label	byte
		db	'ch.lib',000h
; @2591
DATA_2591	label	byte
		db	'mathh.lib',000h
; @259B
DATA_259B	label	byte
		db	'c0ft.obj',000h
; @25A4
DATA_25A4	label	byte
		db	'c0fs.obj',000h
; @25AD
DATA_25AD	label	byte
		db	'c0fm.obj',000h
; @25B6
DATA_25B6	label	byte
		db	'c0fc.obj',000h
; @25BF
DATA_25BF	label	byte
		db	'c0fl.obj',000h
; @25C8
DATA_25C8	label	byte
		db	'c0fh.obj',000h
; @25D1
DATA_25D1	label	byte
		db	'c0@t.obj',000h
; @25DA
DATA_25DA	label	byte
		db	'c0@s.obj',000h
; @25E3
DATA_25E3	label	byte
		db	'c0@m.obj',000h
; @25EC
DATA_25EC	label	byte
		db	'c0@c.obj',000h
; @25F5
DATA_25F5	label	byte
		db	'c0@l.obj',000h
; @25FE
DATA_25FE	label	byte
		db	'c0@h.obj',000h
; @2607
DATA_2607	label	byte
		db	'cwins.lib',000h
; @2611
DATA_2611	label	byte
		db	'cwinm.lib',000h
; @261B
DATA_261B	label	byte
		db	'cwinc.lib',000h
; @2625
DATA_2625	label	byte
		db	'cwinl.lib',000h
; @262F
DATA_262F	label	byte
		db	'cwinh.lib',000h
; @2639
DATA_2639	label	byte
		db	'tasm.exe',000h
; @2642
DATA_2642	label	byte
		db	'turboc.cfg',000h
; @264D
STR_COLON_CRLF	label	byte
		db	':',00Dh,00Ah,000h
; @2651
STR_ASM_EXT	label	byte
		db	'.asm',000h
; @2656
STR_CPP_EXT	label	byte
		db	'.cpp',000h
; @265B
STR_O	label	byte
		db	'/o',000h
; @265E
STR_D_TINY	label	byte
		db	'/D__TINY__ ',000h
; @266A
STR_D_SMALL	label	byte
		db	'/D__SMALL__ ',000h
; @2677
STR_D_MEDIUM	label	byte
		db	'/D__MEDIUM__ ',000h
; @2685
STR_D_COMPACT	label	byte
		db	'/D__COMPACT__ ',000h
; @2694
STR_D_LARGE	label	byte
		db	'/D__LARGE__ ',000h
; @26A1
STR_D_HUGE	label	byte
		db	'/D__HUGE__ ',000h
; @26AD
STR_D_PASCAL	label	byte
		db	'/D__PASCAL__ ',000h
; @26BB
STR_D_FASTCALL	label	byte
		db	'/D__FASTCALL__ ',000h
; @26CB
STR_D_CDECL	label	byte
		db	'/D__CDECL__ ',000h
; @26D8
STR_E	label	byte
		db	'/e',000h
; @26DB
STR_R	label	byte
		db	'/r',000h
; @26DE
STR_ZI	label	byte
		db	'/zi',000h
; @26E2
STR_ML	label	byte
		db	'/ml',000h
; @26E6
STR_SPACE_SLASH	label	byte
		db	' /',000h
; @26E9
STR_SPACE_COMMA	label	byte
		db	' ,',000h
; @26EC
STR_SPACE_SPACE_SEMI	label	byte
		db	'  ;',000h
; @26F0
STR_PLUS_CRLF	label	byte
		db	'+',00Dh,00Ah,000h
; @26F4
STR_TURBOC_LN	label	byte
		db	'turboc.$ln',000h
; @26FF
STR_O_2	label	byte
		db	'/o-',000h
; @2703
STR_V	label	byte
		db	'/v+',000h
; @2707
STR_V_2	label	byte
		db	'/v-',000h
; @270B
STR_DLL	label	byte
		db	'.dll',000h
; @2710
STR_Y	label	byte
		db	'/y',000h
; @2713
STR_TWD	label	byte
		db	'/Twd',000h
; @2718
STR_T	label	byte
		db	'/T',000h
; @271B
STR_O_3	label	byte
		db	'/o-+',00Dh,00Ah,000h
; @2722
STR_OVERLAY_LIB	label	byte
		db	'OVERLAY.LIB',000h
; @272E
STR_IMPORT_LIB	label	byte
		db	'IMPORT.LIB',000h
; @2739
STR_EMU_LIB	label	byte
		db	'EMU.LIB',000h
; @2741
STR_FP87_LIB	label	byte
		db	'FP87.LIB',000h
; @274A
STR_DEF	label	byte
		db	'.def',000h
; @274F
STR_TLINK_EXE	label	byte
		db	'tlink.exe',000h
; @2759
STR_TURBOC_LN_2	label	byte
		db	' @turboc.$ln',000h
; @2766
INTEGRAL_PROMOTION_KIND	label	byte
		db	000h,000h,005h,000h,005h,000h,005h,000h,006h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h
; @2792
ASM_STATEMENT_FLAG	label	byte
		db	000h,000h
; @2794
C52_MODEL_INFO	label	byte
		dw	offset DGROUP:DATA_2852,DGROUP
		db	000h,000h
		dw	offset DGROUP:DATA_285B,DGROUP
		db	000h,000h
		dw	offset DGROUP:DATA_2865,DGROUP
		db	000h,001h
		dw	offset DGROUP:DATA_2870,DGROUP
		db	001h,000h
		dw	offset DGROUP:DATA_287C,DGROUP
		db	001h,001h
		dw	offset DGROUP:DATA_2886,DGROUP
		db	001h,001h
; @27B8
PSEUDO_REGISTER_TABLE	label	byte
		dw	offset DGROUP:DATA_288F
		db	000h,000h,006h,000h,000h
		dw	offset DGROUP:DATA_2893
		db	002h,000h,006h,002h,006h
		dw	offset DGROUP:DATA_2897
		db	004h,000h,006h,003h,002h
		dw	offset DGROUP:DATA_289B
		db	006h,000h,006h,001h,004h
		dw	offset DGROUP:DATA_289F
		db	008h,000h,006h,006h,00Ah
		dw	offset DGROUP:DATA_28A3
		db	009h,000h,006h,007h,00Ch
		dw	offset DGROUP:DATA_28A7
		db	00Ah,000h,006h,005h,008h
		dw	offset DGROUP:DATA_28AB
		db	00Bh,000h,006h,004h,018h
		dw	offset DGROUP:DATA_28AF
		db	00Ch,000h,006h,010h,010h
		dw	offset DGROUP:DATA_28B3
		db	00Dh,000h,006h,013h,00Eh
		dw	offset DGROUP:DATA_28B7
		db	00Eh,000h,006h,011h,014h
		dw	offset DGROUP:DATA_28BB
		db	00Fh,000h,006h,012h,01Ah
		dw	offset DGROUP:DATA_28BF
		db	000h,000h,002h,008h,000h
		dw	offset DGROUP:DATA_28C3
		db	004h,000h,002h,00Bh,002h
		dw	offset DGROUP:DATA_28C7
		db	006h,000h,002h,009h,004h
		dw	offset DGROUP:DATA_28CB
		db	002h,000h,002h,00Ah,006h
		dw	offset DGROUP:DATA_28CF
		db	001h,000h,002h,00Ch,001h
		dw	offset DGROUP:DATA_28D3
		db	005h,000h,002h,00Fh,003h
		dw	offset DGROUP:DATA_28D7
		db	007h,000h,002h,00Dh,005h
		dw	offset DGROUP:DATA_28DB
		db	003h,000h,002h,00Eh,007h
		dw	offset DGROUP:DATA_28DF
		db	0FFh,0FFh,006h,000h,016h,000h,000h,000h,000h,000h,000h,000h
; @2852
DATA_2852	label	byte
		db	'__TINY__'
; @285A
STR_EMPTY_3	label	byte
		db	000h
; @285B
DATA_285B	label	byte
		db	'__SMALL__',000h
; @2865
DATA_2865	label	byte
		db	'__MEDIUM__',000h
; @2870
DATA_2870	label	byte
		db	'__COMPACT__',000h
; @287C
DATA_287C	label	byte
		db	'__LARGE__',000h
; @2886
DATA_2886	label	byte
		db	'__HUGE__',000h
; @288F
DATA_288F	label	byte
		db	'_AX',000h
; @2893
DATA_2893	label	byte
		db	'_DX',000h
; @2897
DATA_2897	label	byte
		db	'_BX',000h
; @289B
DATA_289B	label	byte
		db	'_CX',000h
; @289F
DATA_289F	label	byte
		db	'_SI',000h
; @28A3
DATA_28A3	label	byte
		db	'_DI',000h
; @28A7
DATA_28A7	label	byte
		db	'_BP',000h
; @28AB
DATA_28AB	label	byte
		db	'_SP',000h
; @28AF
DATA_28AF	label	byte
		db	'_ES',000h
; @28B3
DATA_28B3	label	byte
		db	'_DS',000h
; @28B7
DATA_28B7	label	byte
		db	'_CS',000h
; @28BB
DATA_28BB	label	byte
		db	'_SS',000h
; @28BF
DATA_28BF	label	byte
		db	'_AL',000h
; @28C3
DATA_28C3	label	byte
		db	'_BL',000h
; @28C7
DATA_28C7	label	byte
		db	'_CL',000h
; @28CB
DATA_28CB	label	byte
		db	'_DL',000h
; @28CF
DATA_28CF	label	byte
		db	'_AH',000h
; @28D3
DATA_28D3	label	byte
		db	'_BH',000h
; @28D7
DATA_28D7	label	byte
		db	'_CH',000h
; @28DB
DATA_28DB	label	byte
		db	'_DH',000h
; @28DF
DATA_28DF	label	byte
		db	'_FLAGS',000h
; @28E6
STR__TEXT	label	byte
		db	'_TEXT',000h
; @28EC
STR_CODE	label	byte
		db	'CODE',000h
; @28F1
STR__	label	byte
		db	'_'
; @28F2
STR_DATA	label	byte
		db	'data',000h
; @28F7
STR_DGROUP	label	byte
		db	'dgroup',000h
; @28FE
STR_X5F_2	label	byte
		db	'_'
; @28FF
STR_BSS	label	byte
		db	'bss',000h
; @2903
STR_FAR_DATA	label	byte
		db	'FAR_DATA',000h
; @290C
STR_TEXT_2	label	byte
		db	'_text',000h
; @2912
STR_1	label	byte
		db	'1'
; @2913
STR_XFB	label	byte
		db	0FBh,000h
; @2915
STR___MULTI_THREAD__	label	byte
		db	'__MULTI_THREAD__',000h
; @2926
STR___SINGLE_THREAD__	label	byte
		db	'__SINGLE_THREAD__',000h
; @2938
STR___DLL__	label	byte
		db	'__DLL__',000h
; @2940
STR___OS2__	label	byte
		db	'__OS2__',000h
; @2948
STR___MSDOS__	label	byte
		db	'__MSDOS__',000h
; @2952
STR__WINDOWS	label	byte
		db	'_Windows',000h
; @295B
STR___TURBOC__	label	byte
		db	'__TURBOC__',000h
; @2966
STR_0X0297	label	byte
		db	'0x0297',0FBh,000h
; @296E
STR___BORLANDC__	label	byte
		db	'__BORLANDC__',000h
; @297B
STR_0X0200	label	byte
		db	'0x0200',0FBh,000h
; @2983
STR___TCPLUSPLUS__	label	byte
		db	'__TCPLUSPLUS__',000h
; @2992
STR___BCPLUSPLUS__	label	byte
		db	'__BCPLUSPLUS__',000h
; @29A1
STR___OVERLAY__	label	byte
		db	'__OVERLAY__',000h
; @29AD
STR___PASCAL__	label	byte
		db	'__PASCAL__',000h
; @29B8
STR___FASTCALL__	label	byte
		db	'__FASTCALL__',000h
; @29C5
STR___CDECL__	label	byte
		db	'__CDECL__',000h
; @29CF
STR__FAR	label	byte
		db	'_FAR',000h
; @29D4
NAME_A1	label	byte
		db	'_INIT_',000h
; @29DB
NAME_A2	label	byte
		db	'INITDATA',000h
; @29E4
NAME_B1	label	byte
		db	'_EXIT_',000h
; @29EB
NAME_B2	label	byte
		db	'EXITDATA',000h
; @29F4
MIN_FREE_HEAP	label	byte
		db	0FFh,0FFh,00Fh,000h
; @29F8
C53_DEFAULT_FILE	label	byte
		db	'TCDEF.SYM',000h
; @2A02
C53_COMMAND_LINE	label	byte
		db	'command line',000h
; @2A0F
C53_CONFIG_FILE	label	byte
		db	'configuration file',000h
; @2A22
OPT_TEXT_YO	label	byte
		db	'Yo',000h
; @2A25
C53_YO_OFF	label	byte
		db	'Yo-',000h
; @2A29
OPT_TEXT_V	label	byte
		db	'v',000h
; @2A2B
C53_V_OFF	label	byte
		db	'v-',000h
; @2A2E
OPT_TEXT_VI	label	byte
		db	'vi',000h
; @2A31
C53_VI_OFF	label	byte
		db	'vi-',000h,000h
; @2A36
DEBUG_PREFIX	label	byte
		db	009h,'?debug',009h,'C ',000h
; @2A41
DEBUG_MORE	label	byte
		db	'+',00Dh,00Ah,009h,'?debug',009h,'C ',000h
; @2A4F
DEBUG_SUFFIX	label	byte
		db	00Dh,00Ah,000h
; @2A52
C56_EXTERN	label	byte
		db	009h,'extrn',009h,000h
; @2A5A
C56_NEAR	label	byte
		db	'near',000h
; @2A5F
C56_PUBLIC_DLL	label	byte
		db	009h,'publicdll',009h,000h
; @2A6B
C56_PUBLIC	label	byte
		db	009h,'public',009h,000h
; @2A74
C56_STACK_EQU	label	byte
		db	009h,'equ',009h,'s@'
; @2A7B
C56_PLUS	label	byte
		db	'+',000h
; @2A7D
C56_EQU	label	byte
		db	009h,'equ',009h,000h
; @2A83
DEBUG_NODE_PREFIX	label	byte
		db	009h,'?debug',009h,'F ',000h
; @2A8E
C56_VERSION_EXTENDED	label	byte
		db	'05',000h
; @2A91
C56_VERSION_BASE	label	byte
		db	'01',000h
; @2A94
C56_DATA_MARK	label	byte
		db	'd@',000h
; @2A97
STR_BSS_BASE_LABEL	label	byte
		db	'b@',000h
; @2A9A
C56_WORD_MARK	label	byte
		db	'w+',000h,000h
; @2A9E
OBJ_EXTERN_INDEX	label	byte
		db	000h,000h
; @2AA0
STR_TURBOFLOAT	label	byte
		db	'__turboFloat',000h,000h
; @2AAE
ASM_KEYWORD_TABLE	label	byte
		dw	offset DGROUP:DATA_2E86
		db	'z',000h
		dw	offset DGROUP:DATA_2E88
		db	't',000h
		dw	offset DGROUP:DATA_2E8C
		db	't',000h
		dw	offset DGROUP:DATA_2E90
		db	't',000h
		dw	offset DGROUP:DATA_2E94
		db	't',000h
		dw	offset DGROUP:DATA_2E98
		db	't',000h
		dw	offset DGROUP:DATA_2E9C
		db	't',000h
		dw	offset DGROUP:DATA_2EA0
		db	'z',000h
		dw	offset DGROUP:DATA_2EA3
		db	'z',000h
		dw	offset DGROUP:DATA_2EA6
		db	't',000h
		dw	offset DGROUP:DATA_2EAA
		db	't',000h
		dw	offset DGROUP:DATA_2EAF
		db	'z',000h
		dw	offset DGROUP:DATA_2EB2
		db	'z',000h
		dw	offset DGROUP:DATA_2EB5
		db	'z',000h
		dw	offset DGROUP:DATA_2EB8
		db	't',000h
		dw	offset DGROUP:DATA_2EBE
		db	'z',000h
		dw	offset DGROUP:DATA_2EC1
		db	'z',000h
		dw	offset DGROUP:DATA_2EC4
		db	'u',000h
		dw	offset DGROUP:DATA_2EC9
		db	't',000h
		dw	offset DGROUP:DATA_2ECD
		db	'z',000h
		dw	offset DGROUP:DATA_2ED0
		db	'z',000h
		dw	offset DGROUP:DATA_2ED3
		db	't',000h
		dw	offset DGROUP:DATA_2ED7
		db	't',000h
		dw	offset DGROUP:DATA_2EDB
		db	't',000h
		dw	offset DGROUP:DATA_2EDF
		db	't',000h
		dw	offset DGROUP:DATA_2EE3
		db	't',000h
		dw	offset DGROUP:DATA_2EE7
		db	'w',000h
		dw	offset DGROUP:DATA_2EEC
		db	'w',000h
		dw	offset DGROUP:DATA_2EF2
		db	'w',000h
		dw	offset DGROUP:DATA_2EF8
		db	'z',000h
		dw	offset DGROUP:DATA_2EFB
		db	't',000h
		dw	offset DGROUP:DATA_2EFF
		db	'z',000h
		dw	offset DGROUP:DATA_2F02
		db	't',000h
		dw	offset DGROUP:DATA_2F06
		db	't',000h
		dw	offset DGROUP:DATA_2F0A
		db	't',000h
		dw	offset DGROUP:DATA_2E9D
		db	't',000h
		dw	offset DGROUP:DATA_2F0D
		db	't',000h
		dw	offset DGROUP:DATA_2F11
		db	'z',000h
		dw	offset DGROUP:DATA_2F14
		db	'z',000h
		dw	offset DGROUP:DATA_2F17
		db	't',000h
		dw	offset DGROUP:DATA_2F1B
		db	'z',000h
		dw	offset DGROUP:DATA_2F1E
		db	'z',000h
		dw	offset DGROUP:DATA_2F21
		db	't',000h
		dw	offset DGROUP:DATA_2F24
		db	'y',000h
		dw	offset DGROUP:DATA_2F2A
		db	'z',000h
		dw	offset DGROUP:DATA_2F2D
		db	't',000h
		dw	offset DGROUP:DATA_2F33
		db	'z',000h
		dw	offset DGROUP:DATA_2F36
		db	't',000h
		dw	offset DGROUP:DATA_2F3C
		db	't',000h
		dw	offset DGROUP:DATA_2F42
		db	't',000h
		dw	offset DGROUP:DATA_2F47
		db	't',000h
		dw	offset DGROUP:DATA_2F4C
		db	't',000h
		dw	offset DGROUP:DATA_2F52
		db	'~',000h
		dw	offset DGROUP:DATA_2F56
		db	't',000h
		dw	offset DGROUP:DATA_2F5B
		db	't',000h
		dw	offset DGROUP:DATA_2F61
		db	't',000h
		dw	offset DGROUP:DATA_2F66
		db	't',000h
		dw	offset DGROUP:DATA_2F6C
		db	't',000h
		dw	offset DGROUP:DATA_2F71
		db	't',000h
		dw	offset DGROUP:DATA_2F77
		db	't',000h
		dw	offset DGROUP:DATA_2F7E
		db	't',000h
		dw	offset DGROUP:DATA_2F86
		db	't',000h
		dw	offset DGROUP:DATA_2F8C
		db	't',000h
		dw	offset DGROUP:DATA_2F91
		db	't',000h
		dw	offset DGROUP:DATA_2F97
		db	't',000h
		dw	offset DGROUP:DATA_2F9D
		db	't',000h
		dw	offset DGROUP:DATA_2FA4
		db	't',000h
		dw	offset DGROUP:DATA_2FA9
		db	't',000h
		dw	offset DGROUP:DATA_2FAF
		db	't',000h
		dw	offset DGROUP:DATA_2FB5
		db	't',000h
		dw	offset DGROUP:DATA_2FBB
		db	't',000h
		dw	offset DGROUP:DATA_2FC2
		db	't',000h
		dw	offset DGROUP:DATA_2FC8
		db	't',000h
		dw	offset DGROUP:DATA_2FCF
		db	't',000h
		dw	offset DGROUP:DATA_2FD4
		db	't',000h
		dw	offset DGROUP:DATA_2FDA
		db	't',000h
		dw	offset DGROUP:DATA_2FE2
		db	't',000h
		dw	offset DGROUP:DATA_2FE8
		db	't',000h
		dw	offset DGROUP:DATA_2FED
		db	't',000h
		dw	offset DGROUP:DATA_2FF3
		db	't',000h
		dw	offset DGROUP:DATA_2FF9
		db	't',000h
		dw	offset DGROUP:DATA_3000
		db	't',000h
		dw	offset DGROUP:DATA_3004
		db	't',000h
		dw	offset DGROUP:DATA_3009
		db	't',000h
		dw	offset DGROUP:DATA_300F
		db	't',000h
		dw	offset DGROUP:DATA_3016
		db	't',000h
		dw	offset DGROUP:DATA_301D
		db	't',000h
		dw	offset DGROUP:DATA_3024
		db	't',000h
		dw	offset DGROUP:DATA_302B
		db	't',000h
		dw	offset DGROUP:DATA_3032
		db	't',000h
		dw	offset DGROUP:DATA_3038
		db	't',000h
		dw	offset DGROUP:DATA_303D
		db	't',000h
		dw	offset DGROUP:DATA_3042
		db	't',000h
		dw	offset DGROUP:DATA_3048
		db	't',000h
		dw	offset DGROUP:DATA_304F
		db	't',000h
		dw	offset DGROUP:DATA_3056
		db	't',000h
		dw	offset DGROUP:DATA_305C
		db	't',000h
		dw	offset DGROUP:DATA_3063
		db	't',000h
		dw	offset DGROUP:DATA_3068
		db	't',000h
		dw	offset DGROUP:DATA_306F
		db	't',000h
		dw	offset DGROUP:DATA_3076
		db	't',000h
		dw	offset DGROUP:DATA_307E
		db	't',000h
		dw	offset DGROUP:DATA_3085
		db	't',000h
		dw	offset DGROUP:DATA_308C
		db	't',000h
		dw	offset DGROUP:DATA_3092
		db	't',000h
		dw	offset DGROUP:DATA_3098
		db	't',000h
		dw	offset DGROUP:DATA_30A0
		db	't',000h
		dw	offset DGROUP:DATA_30A7
		db	't',000h
		dw	offset DGROUP:DATA_30AD
		db	't',000h
		dw	offset DGROUP:DATA_30B4
		db	't',000h
		dw	offset DGROUP:DATA_30BA
		db	't',000h
		dw	offset DGROUP:DATA_30BE
		db	't',000h
		dw	offset DGROUP:DATA_30C4
		db	't',000h
		dw	offset DGROUP:DATA_30CB
		db	't',000h
		dw	offset DGROUP:DATA_30D0
		db	't',000h
		dw	offset DGROUP:DATA_30D6
		db	't',000h
		dw	offset DGROUP:DATA_30DB
		db	't',000h
		dw	offset DGROUP:DATA_30E1
		db	't',000h
		dw	offset DGROUP:DATA_30E7
		db	't',000h
		dw	offset DGROUP:DATA_30EE
		db	't',000h
		dw	offset DGROUP:DATA_30F3
		db	't',000h
		dw	offset DGROUP:DATA_30F9
		db	't',000h
		dw	offset DGROUP:DATA_30FE
		db	't',000h
		dw	offset DGROUP:DATA_3103
		db	't',000h
		dw	offset DGROUP:DATA_310B
		db	't',000h
		dw	offset DGROUP:DATA_3111
		db	't',000h
		dw	offset DGROUP:DATA_3119
		db	't',000h
		dw	offset DGROUP:DATA_2FC3
		db	't',000h
		dw	offset DGROUP:DATA_2FD5
		db	't',000h
		dw	offset DGROUP:DATA_311D
		db	't',000h
		dw	offset DGROUP:DATA_3120
		db	't',000h
		dw	offset DGROUP:DATA_3124
		db	'w',000h
		dw	offset DGROUP:DATA_3128
		db	'w',000h
		dw	offset DGROUP:DATA_312D
		db	'w',000h
		dw	offset DGROUP:DATA_309C
		db	't',000h
		dw	offset DGROUP:DATA_3132
		db	't',000h
		dw	offset DGROUP:DATA_3137
		db	't',000h
		dw	offset DGROUP:DATA_313C
		db	'x',005h
		dw	offset DGROUP:DATA_313F
		db	'x',009h
		dw	offset DGROUP:DATA_3143
		db	'x',004h
		dw	offset DGROUP:DATA_3146
		db	'x',008h
		dw	offset DGROUP:DATA_314A
		db	'x',00Ch
		dw	offset DGROUP:DATA_314D
		db	'x',016h
		dw	offset DGROUP:DATA_3152
		db	'x',00Ah
		dw	offset DGROUP:DATA_3155
		db	'x',003h
		dw	offset DGROUP:DATA_3158
		db	'x',007h
		dw	offset DGROUP:DATA_315C
		db	'x',002h
		dw	offset DGROUP:DATA_315F
		db	'x',006h
		dw	offset DGROUP:DATA_3163
		db	'x',001h
		dw	offset DGROUP:DATA_3167
		db	'x',008h
		dw	offset DGROUP:DATA_316B
		db	'x',004h
		dw	offset DGROUP:DATA_3170
		db	'x',009h
		dw	offset DGROUP:DATA_3174
		db	'x',005h
		dw	offset DGROUP:DATA_3179
		db	'x',00Dh
		dw	offset DGROUP:DATA_317D
		db	'x',00Bh
		dw	offset DGROUP:DATA_3181
		db	'x',006h
		dw	offset DGROUP:DATA_3185
		db	'x',002h
		dw	offset DGROUP:DATA_318A
		db	'x',007h
		dw	offset DGROUP:DATA_318E
		db	'x',003h
		dw	offset DGROUP:DATA_3193
		db	'x',00Fh
		dw	offset DGROUP:DATA_3197
		db	'x',013h
		dw	offset DGROUP:DATA_319B
		db	'x',011h
		dw	offset DGROUP:DATA_319F
		db	'x',00Bh
		dw	offset DGROUP:DATA_31A3
		db	'x',00Eh
		dw	offset DGROUP:DATA_31A6
		db	'x',012h
		dw	offset DGROUP:DATA_31A9
		db	'x',012h
		dw	offset DGROUP:DATA_31AD
		db	'x',013h
		dw	offset DGROUP:DATA_31B1
		db	'x',010h
		dw	offset DGROUP:DATA_31B4
		db	'x',00Ah
		dw	offset DGROUP:DATA_31B7
		db	't',000h
		dw	offset DGROUP:DATA_31BC
		db	't',000h
		dw	offset DGROUP:DATA_31C0
		db	't',000h
		dw	offset DGROUP:DATA_31C4
		db	't',000h
		dw	offset DGROUP:DATA_31C8
		db	't',000h
		dw	offset DGROUP:DATA_31CE
		db	't',000h
		dw	offset DGROUP:DATA_31D2
		db	'}',000h
		dw	offset DGROUP:DATA_31D7
		db	'w',000h
		dw	offset DGROUP:DATA_31DC
		db	'w',000h
		dw	offset DGROUP:DATA_31E2
		db	'w',000h
		dw	offset DGROUP:DATA_31E8
		db	'x',017h
		dw	offset DGROUP:DATA_31ED
		db	'x',014h
		dw	offset DGROUP:DATA_31F3
		db	'x',015h
		dw	offset DGROUP:DATA_31FA
		db	'x',015h
		dw	offset DGROUP:DATA_3201
		db	'x',014h
		dw	offset DGROUP:DATA_3207
		db	't',000h
		dw	offset DGROUP:DATA_320B
		db	't',000h
		dw	offset DGROUP:DATA_320F
		db	'w',000h
		dw	offset DGROUP:DATA_3214
		db	'w',000h
		dw	offset DGROUP:DATA_321A
		db	'w',000h
		dw	offset DGROUP:DATA_2FD6
		db	't',000h
		dw	offset DGROUP:DATA_3220
		db	07Fh,000h
		dw	offset DGROUP:DATA_3225
		db	't',000h
		dw	offset DGROUP:DATA_3064
		db	't',000h
		dw	offset DGROUP:DATA_3229
		db	't',000h
		dw	offset DGROUP:DATA_30A4
		db	't',000h
		dw	offset DGROUP:DATA_322D
		db	't',000h
		dw	offset DGROUP:DATA_3231
		db	'w',000h
		dw	offset DGROUP:DATA_3236
		db	'w',000h
		dw	offset DGROUP:DATA_323C
		db	'w',000h
		dw	offset DGROUP:DATA_3242
		db	't',000h
		dw	offset DGROUP:DATA_3246
		db	't',000h
		dw	offset DGROUP:DATA_324B
		db	't',000h
		dw	offset DGROUP:DATA_3250
		db	081h,000h
		dw	offset DGROUP:DATA_3254
		db	't',000h
		dw	offset DGROUP:DATA_3259
		db	't',000h
		dw	offset DGROUP:DATA_325F
		db	't',000h
		dw	offset DGROUP:DATA_3265
		db	't',000h
		dw	offset DGROUP:DATA_3269
		db	't',000h
		dw	offset DGROUP:DATA_326D
		db	'v',000h
		dw	offset DGROUP:DATA_3271
		db	'v',000h
		dw	offset DGROUP:DATA_3276
		db	'v',000h
		dw	offset DGROUP:DATA_327C
		db	'v',000h
		dw	offset DGROUP:DATA_3282
		db	'v',000h
		dw	offset DGROUP:DATA_3138
		db	't',000h
		dw	offset DGROUP:DATA_3287
		db	't',000h
		dw	offset DGROUP:DATA_328B
		db	't',000h
		dw	offset DGROUP:DATA_328F
		db	't',000h
		dw	offset DGROUP:DATA_3294
		db	't',000h
		dw	offset DGROUP:DATA_3298
		db	't',000h
		dw	offset DGROUP:DATA_329C
		db	't',000h
		dw	offset DGROUP:DATA_32A0
		db	'w',000h
		dw	offset DGROUP:DATA_32A5
		db	'w',000h
		dw	offset DGROUP:DATA_32AB
		db	'w',000h
		dw	offset DGROUP:DATA_32B1
		db	't',000h
		dw	offset DGROUP:DATA_32B5
		db	080h,000h
		dw	offset DGROUP:DATA_32BB
		db	't',000h
		dw	offset DGROUP:DATA_2F89
		db	'z',000h
		dw	offset DGROUP:DATA_32BF
		db	't',000h
		dw	offset DGROUP:DATA_32C4
		db	'z',000h
		dw	offset DGROUP:DATA_32C7
		db	'z',000h
		dw	offset DGROUP:DATA_32CA
		db	't',000h
		dw	offset DGROUP:DATA_32CE
		db	't',000h
		dw	offset DGROUP:DATA_32D2
		db	't',000h
		dw	offset DGROUP:DATA_32D6
		db	'w',000h
		dw	offset DGROUP:DATA_32DB
		db	'w',000h
		dw	offset DGROUP:DATA_32E1
		db	'w',000h
		dw	offset DGROUP:DATA_2FF5
		db	't',000h
		dw	offset DGROUP:DATA_32E7
		db	't',000h
		dw	offset DGROUP:DATA_32EC
		db	't',000h
		dw	offset DGROUP:DATA_32F1
		db	't',000h
		dw	offset DGROUP:DATA_30F4
		db	't',000h
		dw	offset DGROUP:DATA_2F25
		db	'y',000h
		dw	offset DGROUP:DATA_32F6
		db	't',000h
		dw	offset DGROUP:DATA_32FB
		db	't',000h
		dw	offset DGROUP:DATA_3300
		db	't',000h
; @2E82
ASM_KEYWORD_COMPARE_FUNC	label	byte
		dd	BCC_NAME_COMPARE
; @2E86
DATA_2E86	label	byte
		db	'$',000h
; @2E88
DATA_2E88	label	byte
		db	'aaa',000h
; @2E8C
DATA_2E8C	label	byte
		db	'aad',000h
; @2E90
DATA_2E90	label	byte
		db	'aam',000h
; @2E94
DATA_2E94	label	byte
		db	'aas',000h
; @2E98
DATA_2E98	label	byte
		db	'adc',000h
; @2E9C
DATA_2E9C	label	byte
		db	'a'
; @2E9D
DATA_2E9D	label	byte
		db	'dd',000h
; @2EA0
DATA_2EA0	label	byte
		db	'ah',000h
; @2EA3
DATA_2EA3	label	byte
		db	'al',000h
; @2EA6
DATA_2EA6	label	byte
		db	'and',000h
; @2EAA
DATA_2EAA	label	byte
		db	'arpl',000h
; @2EAF
DATA_2EAF	label	byte
		db	'ax',000h
; @2EB2
DATA_2EB2	label	byte
		db	'bh',000h
; @2EB5
DATA_2EB5	label	byte
		db	'bl',000h
; @2EB8
DATA_2EB8	label	byte
		db	'bound',000h
; @2EBE
DATA_2EBE	label	byte
		db	'bp',000h
; @2EC1
DATA_2EC1	label	byte
		db	'bx',000h
; @2EC4
DATA_2EC4	label	byte
		db	'call',000h
; @2EC9
DATA_2EC9	label	byte
		db	'cbw',000h
; @2ECD
DATA_2ECD	label	byte
		db	'ch',000h
; @2ED0
DATA_2ED0	label	byte
		db	'cl',000h
; @2ED3
DATA_2ED3	label	byte
		db	'clc',000h
; @2ED7
DATA_2ED7	label	byte
		db	'cld',000h
; @2EDB
DATA_2EDB	label	byte
		db	'cli',000h
; @2EDF
DATA_2EDF	label	byte
		db	'cmc',000h
; @2EE3
DATA_2EE3	label	byte
		db	'cmp',000h
; @2EE7
DATA_2EE7	label	byte
		db	'cmps',000h
; @2EEC
DATA_2EEC	label	byte
		db	'cmpsb',000h
; @2EF2
DATA_2EF2	label	byte
		db	'cmpsw',000h
; @2EF8
DATA_2EF8	label	byte
		db	'cs',000h
; @2EFB
DATA_2EFB	label	byte
		db	'cwd',000h
; @2EFF
DATA_2EFF	label	byte
		db	'cx',000h
; @2F02
DATA_2F02	label	byte
		db	'daa',000h
; @2F06
DATA_2F06	label	byte
		db	'das',000h
; @2F0A
DATA_2F0A	label	byte
		db	'db',000h
; @2F0D
DATA_2F0D	label	byte
		db	'dec',000h
; @2F11
DATA_2F11	label	byte
		db	'dh',000h
; @2F14
DATA_2F14	label	byte
		db	'di',000h
; @2F17
DATA_2F17	label	byte
		db	'div',000h
; @2F1B
DATA_2F1B	label	byte
		db	'dl',000h
; @2F1E
DATA_2F1E	label	byte
		db	'ds',000h
; @2F21
DATA_2F21	label	byte
		db	'dw',000h
; @2F24
DATA_2F24	label	byte
		db	'd'
; @2F25
DATA_2F25	label	byte
		db	'word',000h
; @2F2A
DATA_2F2A	label	byte
		db	'dx',000h
; @2F2D
DATA_2F2D	label	byte
		db	'enter',000h
; @2F33
DATA_2F33	label	byte
		db	'es',000h
; @2F36
DATA_2F36	label	byte
		db	'extrn',000h
; @2F3C
DATA_2F3C	label	byte
		db	'f2xm1',000h
; @2F42
DATA_2F42	label	byte
		db	'fabs',000h
; @2F47
DATA_2F47	label	byte
		db	'fadd',000h
; @2F4C
DATA_2F4C	label	byte
		db	'faddp',000h
; @2F52
DATA_2F52	label	byte
		db	'far',000h
; @2F56
DATA_2F56	label	byte
		db	'fbld',000h
; @2F5B
DATA_2F5B	label	byte
		db	'fbstp',000h
; @2F61
DATA_2F61	label	byte
		db	'fchs',000h
; @2F66
DATA_2F66	label	byte
		db	'fclex',000h
; @2F6C
DATA_2F6C	label	byte
		db	'fcom',000h
; @2F71
DATA_2F71	label	byte
		db	'fcomp',000h
; @2F77
DATA_2F77	label	byte
		db	'fcompp',000h
; @2F7E
DATA_2F7E	label	byte
		db	'fdecstp',000h
; @2F86
DATA_2F86	label	byte
		db	'fdi'
; @2F89
DATA_2F89	label	byte
		db	'si',000h
; @2F8C
DATA_2F8C	label	byte
		db	'fdiv',000h
; @2F91
DATA_2F91	label	byte
		db	'fdivp',000h
; @2F97
DATA_2F97	label	byte
		db	'fdivr',000h
; @2F9D
DATA_2F9D	label	byte
		db	'fdivrp',000h
; @2FA4
DATA_2FA4	label	byte
		db	'feni',000h
; @2FA9
DATA_2FA9	label	byte
		db	'ffree',000h
; @2FAF
DATA_2FAF	label	byte
		db	'fiadd',000h
; @2FB5
DATA_2FB5	label	byte
		db	'ficom',000h
; @2FBB
DATA_2FBB	label	byte
		db	'ficomp',000h
; @2FC2
DATA_2FC2	label	byte
		db	'f'
; @2FC3
DATA_2FC3	label	byte
		db	'idiv',000h
; @2FC8
DATA_2FC8	label	byte
		db	'fidivr',000h
; @2FCF
DATA_2FCF	label	byte
		db	'fild',000h
; @2FD4
DATA_2FD4	label	byte
		db	'f'
; @2FD5
DATA_2FD5	label	byte
		db	'i'
; @2FD6
DATA_2FD6	label	byte
		db	'mul',000h
; @2FDA
DATA_2FDA	label	byte
		db	'fincstp',000h
; @2FE2
DATA_2FE2	label	byte
		db	'finit',000h
; @2FE8
DATA_2FE8	label	byte
		db	'fist',000h
; @2FED
DATA_2FED	label	byte
		db	'fistp',000h
; @2FF3
DATA_2FF3	label	byte
		db	'fi'
; @2FF5
DATA_2FF5	label	byte
		db	'sub',000h
; @2FF9
DATA_2FF9	label	byte
		db	'fisubr',000h
; @3000
DATA_3000	label	byte
		db	'fld',000h
; @3004
DATA_3004	label	byte
		db	'fld1',000h
; @3009
DATA_3009	label	byte
		db	'fldcw',000h
; @300F
DATA_300F	label	byte
		db	'fldenv',000h
; @3016
DATA_3016	label	byte
		db	'fldl2e',000h
; @301D
DATA_301D	label	byte
		db	'fldl2t',000h
; @3024
DATA_3024	label	byte
		db	'fldlg2',000h
; @302B
DATA_302B	label	byte
		db	'fldln2',000h
; @3032
DATA_3032	label	byte
		db	'fldpi',000h
; @3038
DATA_3038	label	byte
		db	'fldz',000h
; @303D
DATA_303D	label	byte
		db	'fmul',000h
; @3042
DATA_3042	label	byte
		db	'fmulp',000h
; @3048
DATA_3048	label	byte
		db	'fnclex',000h
; @304F
DATA_304F	label	byte
		db	'fndisi',000h
; @3056
DATA_3056	label	byte
		db	'fneni',000h
; @305C
DATA_305C	label	byte
		db	'fninit',000h
; @3063
DATA_3063	label	byte
		db	'f'
; @3064
DATA_3064	label	byte
		db	'nop',000h
; @3068
DATA_3068	label	byte
		db	'fnsave',000h
; @306F
DATA_306F	label	byte
		db	'fnstcw',000h
; @3076
DATA_3076	label	byte
		db	'fnstenv',000h
; @307E
DATA_307E	label	byte
		db	'fnstsw',000h
; @3085
DATA_3085	label	byte
		db	'fpatan',000h
; @308C
DATA_308C	label	byte
		db	'fprem',000h
; @3092
DATA_3092	label	byte
		db	'fptan',000h
; @3098
DATA_3098	label	byte
		db	'frnd'
; @309C
DATA_309C	label	byte
		db	'int',000h
; @30A0
DATA_30A0	label	byte
		db	'frst'
; @30A4
DATA_30A4	label	byte
		db	'or',000h
; @30A7
DATA_30A7	label	byte
		db	'fsave',000h
; @30AD
DATA_30AD	label	byte
		db	'fscale',000h
; @30B4
DATA_30B4	label	byte
		db	'fsqrt',000h
; @30BA
DATA_30BA	label	byte
		db	'fst',000h
; @30BE
DATA_30BE	label	byte
		db	'fstcw',000h
; @30C4
DATA_30C4	label	byte
		db	'fstenv',000h
; @30CB
DATA_30CB	label	byte
		db	'fstp',000h
; @30D0
DATA_30D0	label	byte
		db	'fstsw',000h
; @30D6
DATA_30D6	label	byte
		db	'fsub',000h
; @30DB
DATA_30DB	label	byte
		db	'fsubp',000h
; @30E1
DATA_30E1	label	byte
		db	'fsubr',000h
; @30E7
DATA_30E7	label	byte
		db	'fsubrp',000h
; @30EE
DATA_30EE	label	byte
		db	'ftst',000h
; @30F3
DATA_30F3	label	byte
		db	'f'
; @30F4
DATA_30F4	label	byte
		db	'wait',000h
; @30F9
DATA_30F9	label	byte
		db	'fxam',000h
; @30FE
DATA_30FE	label	byte
		db	'fxch',000h
; @3103
DATA_3103	label	byte
		db	'fxtract',000h
; @310B
DATA_310B	label	byte
		db	'fyl2x',000h
; @3111
DATA_3111	label	byte
		db	'fyl2xp1',000h
; @3119
DATA_3119	label	byte
		db	'hlt',000h
; @311D
DATA_311D	label	byte
		db	'in',000h
; @3120
DATA_3120	label	byte
		db	'inc',000h
; @3124
DATA_3124	label	byte
		db	'ins',000h
; @3128
DATA_3128	label	byte
		db	'insb',000h
; @312D
DATA_312D	label	byte
		db	'insw',000h
; @3132
DATA_3132	label	byte
		db	'into',000h
; @3137
DATA_3137	label	byte
		db	'i'
; @3138
DATA_3138	label	byte
		db	'ret',000h
; @313C
DATA_313C	label	byte
		db	'ja',000h
; @313F
DATA_313F	label	byte
		db	'jae',000h
; @3143
DATA_3143	label	byte
		db	'jb',000h
; @3146
DATA_3146	label	byte
		db	'jbe',000h
; @314A
DATA_314A	label	byte
		db	'jc',000h
; @314D
DATA_314D	label	byte
		db	'jcxz',000h
; @3152
DATA_3152	label	byte
		db	'je',000h
; @3155
DATA_3155	label	byte
		db	'jg',000h
; @3158
DATA_3158	label	byte
		db	'jge',000h
; @315C
DATA_315C	label	byte
		db	'jl',000h
; @315F
DATA_315F	label	byte
		db	'jle',000h
; @3163
DATA_3163	label	byte
		db	'jmp',000h
; @3167
DATA_3167	label	byte
		db	'jna',000h
; @316B
DATA_316B	label	byte
		db	'jnae',000h
; @3170
DATA_3170	label	byte
		db	'jnb',000h
; @3174
DATA_3174	label	byte
		db	'jnbe',000h
; @3179
DATA_3179	label	byte
		db	'jnc',000h
; @317D
DATA_317D	label	byte
		db	'jne',000h
; @3181
DATA_3181	label	byte
		db	'jng',000h
; @3185
DATA_3185	label	byte
		db	'jnge',000h
; @318A
DATA_318A	label	byte
		db	'jnl',000h
; @318E
DATA_318E	label	byte
		db	'jnle',000h
; @3193
DATA_3193	label	byte
		db	'jno',000h
; @3197
DATA_3197	label	byte
		db	'jnp',000h
; @319B
DATA_319B	label	byte
		db	'jns',000h
; @319F
DATA_319F	label	byte
		db	'jnz',000h
; @31A3
DATA_31A3	label	byte
		db	'jo',000h
; @31A6
DATA_31A6	label	byte
		db	'jp',000h
; @31A9
DATA_31A9	label	byte
		db	'jpe',000h
; @31AD
DATA_31AD	label	byte
		db	'jpo',000h
; @31B1
DATA_31B1	label	byte
		db	'js',000h
; @31B4
DATA_31B4	label	byte
		db	'jz',000h
; @31B7
DATA_31B7	label	byte
		db	'lahf',000h
; @31BC
DATA_31BC	label	byte
		db	'lar',000h
; @31C0
DATA_31C0	label	byte
		db	'lds',000h
; @31C4
DATA_31C4	label	byte
		db	'lea',000h
; @31C8
DATA_31C8	label	byte
		db	'leave',000h
; @31CE
DATA_31CE	label	byte
		db	'les',000h
; @31D2
DATA_31D2	label	byte
		db	'lock',000h
; @31D7
DATA_31D7	label	byte
		db	'lods',000h
; @31DC
DATA_31DC	label	byte
		db	'lodsb',000h
; @31E2
DATA_31E2	label	byte
		db	'lodsw',000h
; @31E8
DATA_31E8	label	byte
		db	'loop',000h
; @31ED
DATA_31ED	label	byte
		db	'loope',000h
; @31F3
DATA_31F3	label	byte
		db	'loopne',000h
; @31FA
DATA_31FA	label	byte
		db	'loopnz',000h
; @3201
DATA_3201	label	byte
		db	'loopz',000h
; @3207
DATA_3207	label	byte
		db	'lsl',000h
; @320B
DATA_320B	label	byte
		db	'mov',000h
; @320F
DATA_320F	label	byte
		db	'movs',000h
; @3214
DATA_3214	label	byte
		db	'movsb',000h
; @321A
DATA_321A	label	byte
		db	'movsw',000h
; @3220
DATA_3220	label	byte
		db	'near',000h
; @3225
DATA_3225	label	byte
		db	'neg',000h
; @3229
DATA_3229	label	byte
		db	'not',000h
; @322D
DATA_322D	label	byte
		db	'out',000h
; @3231
DATA_3231	label	byte
		db	'outs',000h
; @3236
DATA_3236	label	byte
		db	'outsb',000h
; @323C
DATA_323C	label	byte
		db	'outsw',000h
; @3242
DATA_3242	label	byte
		db	'pop',000h
; @3246
DATA_3246	label	byte
		db	'popa',000h
; @324B
DATA_324B	label	byte
		db	'popf',000h
; @3250
DATA_3250	label	byte
		db	'ptr',000h
; @3254
DATA_3254	label	byte
		db	'push',000h
; @3259
DATA_3259	label	byte
		db	'pusha',000h
; @325F
DATA_325F	label	byte
		db	'pushf',000h
; @3265
DATA_3265	label	byte
		db	'rcl',000h
; @3269
DATA_3269	label	byte
		db	'rcr',000h
; @326D
DATA_326D	label	byte
		db	'rep',000h
; @3271
DATA_3271	label	byte
		db	'repe',000h
; @3276
DATA_3276	label	byte
		db	'repne',000h
; @327C
DATA_327C	label	byte
		db	'repnz',000h
; @3282
DATA_3282	label	byte
		db	'repz',000h
; @3287
DATA_3287	label	byte
		db	'rol',000h
; @328B
DATA_328B	label	byte
		db	'ror',000h
; @328F
DATA_328F	label	byte
		db	'sahf',000h
; @3294
DATA_3294	label	byte
		db	'sal',000h
; @3298
DATA_3298	label	byte
		db	'sar',000h
; @329C
DATA_329C	label	byte
		db	'sbb',000h
; @32A0
DATA_32A0	label	byte
		db	'scas',000h
; @32A5
DATA_32A5	label	byte
		db	'scasb',000h
; @32AB
DATA_32AB	label	byte
		db	'scasw',000h
; @32B1
DATA_32B1	label	byte
		db	'shl',000h
; @32B5
DATA_32B5	label	byte
		db	'short',000h
; @32BB
DATA_32BB	label	byte
		db	'shr',000h
; @32BF
DATA_32BF	label	byte
		db	'smsw',000h
; @32C4
DATA_32C4	label	byte
		db	'sp',000h
; @32C7
DATA_32C7	label	byte
		db	'ss',000h
; @32CA
DATA_32CA	label	byte
		db	'stc',000h
; @32CE
DATA_32CE	label	byte
		db	'std',000h
; @32D2
DATA_32D2	label	byte
		db	'sti',000h
; @32D6
DATA_32D6	label	byte
		db	'stos',000h
; @32DB
DATA_32DB	label	byte
		db	'stosb',000h
; @32E1
DATA_32E1	label	byte
		db	'stosw',000h
; @32E7
DATA_32E7	label	byte
		db	'test',000h
; @32EC
DATA_32EC	label	byte
		db	'verr',000h
; @32F1
DATA_32F1	label	byte
		db	'verw',000h
; @32F6
DATA_32F6	label	byte
		db	'xchg',000h
; @32FB
DATA_32FB	label	byte
		db	'xlat',000h
; @3300
DATA_3300	label	byte
		db	'xor',000h
; @3304
STR_CRLF_2	label	byte
		db	00Dh,00Ah,000h,000h
; @3308
STR_OPERATOR_NEW	label	byte
		db	'operator new',000h
; @3315
STR_OPERATOR_DELETE	label	byte
		db	'operator delete',000h,000h
; @3326
STR_FRIEND_4	label	byte
		db	'friend',000h
; @332D
STR_VIRTUAL_4	label	byte
		db	'virtual',000h
; @3335
STR_OPERATOR_5	label	byte
		db	'Operator',009h,'[]',000h
; @3341
STR_DYNAMIC_DISPATCH_CONSTAN	label	byte
		db	'Dynamic dispatch constant',000h
; @335B
STR_STATIC_MEMBER	label	byte
		db	'static member',000h
; @3369
STR_NON_INLINE_FUNCTION	label	byte
		db	'non-inline function',000h
; @337D
STR_STATIC_2	label	byte
		db	'static',000h
; @3384
BCC_DEBUG_EMPTY	label	byte
		db	000h,000h
; @3386
POOL_BANK_TABLE	label	byte
		dw	offset DGROUP:NAME_POOL_SEG
		dw	offset DGROUP:HASH_CHAIN_LINK_SEG
		dw	offset DGROUP:SYMBOL_POOL_SEG
		dw	offset DGROUP:STORAGE_POOL_SEG
		dw	offset DGROUP:CSYM_POOL_SEG
		dw	offset DGROUP:POOL_E
		dw	offset DGROUP:POOL_F
		dw	offset DGROUP:TYPE_POOL
		dw	offset DGROUP:TAG_BODY_POOL_SEG
		dw	offset DGROUP:MEMBER_SEGMENT
		dw	offset DGROUP:LIST_CELL_POOL_SEG
		dw	offset DGROUP:SCOPE_POOL_SEG
		dw	offset DGROUP:POOL_HASH
		dw	offset DGROUP:BASE_LIST_SEG
		dw	offset DGROUP:CONS_CELL_POOL_SEG
		dw	offset DGROUP:LABEL_POOL_SEG
		dw	offset DGROUP:FORMAL_POOL_SEG
		dw	offset DGROUP:C_PARAM_POOL_SEG
		dw	offset DGROUP:PACKED_EXPR_POOL_SEG
		dw	offset DGROUP:TOKEN_STREAM_POOL_SEG
		dw	offset DGROUP:BASE_PATH_POOL_SEG
		dw	offset DGROUP:TEMP_ENTRY_POOL_SEG
		dw	offset DGROUP:CACHE_POOL
		dw	offset DGROUP:LINKAGE_STACK_POOL_SEG
		dw	offset DGROUP:INIT_RECORD_POOL_SEG
		dw	offset DGROUP:DATA_BYTE_POOL_SEG
		dw	offset DGROUP:SRCFILE_POOL_SEG
		dw	offset DGROUP:TOKEN_POOL
		dw	offset DGROUP:C31_BANKS
		dw	offset DGROUP:DATA_7856
		dw	offset DGROUP:DATA_785E
		dw	offset DGROUP:DATA_7866
		dw	offset DGROUP:DATA_786E
		dw	offset DGROUP:DATA_7876
		dw	offset DGROUP:DATA_787E
		dw	offset DGROUP:DATA_7886
		dw	offset DGROUP:SAVED_OPTION_POOL_SEG
; @33D0
PCH_OPTION_FLAG_PTRS	label	byte
		dw	offset DGROUP:OPTION_MEMORY_MODEL
		dw	offset DGROUP:OPTION_DS_NOT_SS
		dw	offset DGROUP:OPTION_UNDERSCORES
		dw	offset DGROUP:NAME_LIMIT
		dw	offset DGROUP:OPTION_WINDOWS_MODE
		dw	offset DGROUP:BCC_PACK_FLAG
		dw	offset DGROUP:OPTION_CALLING_CONVENTION
		dw	offset DGROUP:OPTION_ENUMS_AS_INT
		dw	offset DGROUP:UNSIGNED_CHAR
		dw	offset DGROUP:VTABLE_MODE
		dw	offset DGROUP:CPP_MODE
; @33E6
PREAMBLE_DIRECTIVE_TABLE	label	byte
		dw	offset DGROUP:DATA_3460
		dw	00E4Fh	; @code PCH_DIRECTIVE_PRAGMA
		dw	offset DGROUP:DATA_3467
		dw	01017h	; @code PCH_DIRECTIVE_INCLUDE
		dw	offset DGROUP:DATA_346F
		dw	01205h	; @code PCH_DIRECTIVE_DEFINE
		dw	offset DGROUP:DATA_3476
		dw	01264h	; @code PCH_DIRECTIVE_IF
		dw	offset DGROUP:DATA_3479
		dw	01277h	; @code PCH_DIRECTIVE_IFDEF
		dw	offset DGROUP:DATA_347F
		dw	0128Ah	; @code PCH_DIRECTIVE_IFNDEF
		dw	offset DGROUP:DATA_3486
		dw	0116Dh	; @code PCH_DIRECTIVE_ELSE
		dw	offset DGROUP:DATA_348B
		dw	0116Dh	; @code PCH_DIRECTIVE_ELSE
		dw	offset DGROUP:DATA_3490
		dw	0129Dh	; @code PCH_DIRECTIVE_ENDIF
; @340A
STR_LOADED_PRE_COMPILED	label	byte
		db	'Loaded pre-compiled headers.'
; @3426
STR_NEWLINE	label	byte
		db	00Ah
; @3427
STR_EMPTY	label	byte
		db	000h
; @3428
STR_HASH	label	byte
		db	'#',000h
; @342A
STR_SPACE	label	byte
		db	' ',000h
; @342C
STR_HDRFILE	label	byte
		db	'hdrfile',000h
; @3434
STR_HDRSTOP	label	byte
		db	'hdrstop',000h
; @343C
STR_PRAGMA_2	label	byte
		db	'pragma ',000h
; @3444
STR_EXTERN	label	byte
		db	'extern',000h
; @344B
STR_EXTERN_2	label	byte
		db	'extern ',000h
; @3453
STR_EXTERN_3	label	byte
		db	'extern '
; @345A
STR_QUOTE	label	byte
		db	'"',000h
; @345C
STR_QUOTE_CRLF	label	byte
		db	'"'
; @345D
STR_CRLF	label	byte
		db	00Dh,00Ah,000h
; @3460
DATA_3460	label	byte
		db	'pragma',000h
; @3467
DATA_3467	label	byte
		db	'include',000h
; @346F
DATA_346F	label	byte
		db	'define',000h
; @3476
DATA_3476	label	byte
		db	'if',000h
; @3479
DATA_3479	label	byte
		db	'ifdef',000h
; @347F
DATA_347F	label	byte
		db	'ifndef',000h
; @3486
DATA_3486	label	byte
		db	'else',000h
; @348B
DATA_348B	label	byte
		db	'elif',000h
; @3490
DATA_3490	label	byte
		db	'endif',000h
; @3496
STR_INCLUDE	label	byte
		db	'#include <',000h
; @34A1
STR_GREATER	label	byte
		db	'>',000h
; @34A3
STR_INCLUDE_2	label	byte
		db	'#include "',000h
; @34AE
STR_DEFINE_2	label	byte
		db	'#'
; @34AF
STR_DEFINE_3	label	byte
		db	'define ',000h
; @34B7
STR_IF_3	label	byte
		db	'#if ',000h
; @34BC
STR_IFDEF	label	byte
		db	'#ifdef ',000h
; @34C4
STR_IFNDEF	label	byte
		db	'#ifndef ',000h
; @34CD
STR_ENDIF	label	byte
		db	'#endif ',000h
; @34D5
STR_QUOTE_OPEN_BRACE	label	byte
		db	'" {',000h
; @34D9
STR_CLOSE_BRACE	label	byte
		db	'}',000h
; @34DB
STR_C	label	byte
		db	'C++',000h
; @34DF
STR_C_2	label	byte
		db	'C',000h,000h
; @34E2
BINARY_PRIORITY_BY_TOKEN	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,001h,000h,000h,002h
		db	002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,00Dh,00Dh
		db	00Eh,00Eh,00Eh,009h,007h,008h,00Ch,00Ch
; @3502
TERNARY_ELSE_LEVEL	label	byte
		db	003h,000h,005h,006h,00Ah,00Ah,00Bh,00Bh,00Bh,00Bh
; @350C
OPERATOR_BY_TOKEN	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,'*',000h,000h,012h,013h
		db	014h,015h,016h,017h,01Ah,01Bh,01Ch,018h,019h,008h,009h,00Ah
		db	00Bh,00Ch,00Fh,010h,011h,00Dh,00Eh,'%&(',027h,01Dh,01Eh,' '
		db	01Fh,'"'
; @3535
TYPECHECK_OP_FLAGS	label	byte
		db	'!'
; @3536
LEVEL_ASSOCIATIVITY	label	byte
		db	000h,001h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h
		db	001h,001h,001h,090h,'!',090h,' ',010h,' ',010h,' ',000h,' '
		db	006h,' ',006h,' ',000h,000h,000h,000h,000h,000h,0D1h,081h,091h
		db	080h,091h,080h,011h,080h,011h,080h,001h,080h,003h,080h,003h
		db	080h,001h,080h,001h,080h,001h,080h,098h,001h,098h,001h,098h
		db	001h,098h,001h,098h,001h,098h,001h,090h,080h,090h,080h,0F0h
		db	001h,0F0h,001h,090h,001h,090h,001h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,010h,' ',000h
; @3594
OPERAND_KIND_MASK	label	byte
		db	' ',090h,001h,080h
; @3598
OPERAND_KIND_MESSAGE	label	byte
		db	001h,0D0h,001h,000h,000h,010h,010h,010h,' ',080h,000h,080h,080h
		db	080h,080h,'@@',000h,'/',000h,'/',000h,'/',000h,014h,000h,013h
		db	000h,013h,000h,013h,000h,013h
; @35B9
POST_TO_ASSIGN_OP	label	byte
		db	000h,013h,000h,013h,000h,'T',000h,'T',000h
; @35C2
STR_SUBSCRIPTING_2	label	byte
		db	'Subscripting',000h
; @35CF
STR_ARRAY_BOUNDS_2	label	byte
		db	'Array bounds',000h,013h,014h
; @35DE
STR_STKLEN	label	byte
		db	'_stklen',000h
; @35E6
EXPR_OP_HAS_EFFECT	label	byte
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,001h,001h,001h,001h,001h,001h
		db	001h,001h,001h,001h,001h,000h,000h,000h,000h,000h,000h,001h
		db	001h,001h,000h,001h,001h,001h,001h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,001h,000h,001h
; @361D
STR_IF_4	label	byte
		db	'If',000h
; @3620
STR_FOR_2	label	byte
		db	'For',000h
; @3624
STR_DO_WHILE_2	label	byte
		db	'Do-while',000h
; @362D
STR_WHILE_2	label	byte
		db	'While',000h
; @3633
STR_SWITCH_2	label	byte
		db	'Switch',000h
; @363A
STR_BREAK	label	byte
		db	'Break',000h
; @3640
STR_CONTINUE	label	byte
		db	'Continue',000h
; @3649
STR_RETURN	label	byte
		db	'Return',000h
; @3650
STR_GOTO_2	label	byte
		db	'Goto',000h,000h
; @3656
C_FRONTEND_HOOK_TABLE	label	byte
		dd	EMIT_HEX_BYTE_LIST
		dd	NEW_BITFIELD_NODE
		dd	NEW_CONSTANT_EXPR
		dd	NEW_EXPR_NODE
		dd	NEW_EXPR_NODE_MODE
		dd	EMIT_ASM_SYMBOL_NAME
		dd	DECLARE_UNNAMED_SYMBOL
		dd	RESET_EXPR_POOL
		dd	ENCODE_ASM_SYMBOL
		dd	COUNT_PARAMETERS
		dd	GET_TYPE_FLAGS
		dd	EMIT_LOCALS_DEBUG_INFO
		dd	FINISH_COMPILATION
		dd	TYPE_ALIGNMENT_OR_HUGE_PAD
		dd	FIND_NAMED_FUNCTION
		dd	TREE_HAS_SIDE_EFFECTS
		dd	PARSE_PP_IF_EXPRESSION
		dd	BCC_INTEGER_COERCE
		dd	IS_BASED_POINTER
		dd	STBIN10
		dd	GET_TYPE_QUALIFIERS
		dd	BEGIN_BACKEND_OUTPUT
		dd	GET_TYPE_FLAGS_ALT
		dd	KIND_TIMES_10
		dd	EMIT_GLOBALS_DEBUG_INFO
		dd	BCC_DEBUG_VALUE_MARK
		dd	EMIT_SCOPE_DEBUG_INFO
		dd	GET_SYMBOL_OFFSET
		dd	EMIT_ASM_EXTERNALS
		dd	EMIT_OBJ_SYMBOLS
		dd	PARSE_ASM_MEMBER_ALT
		dd	PARSE_ASM_JUMP_LABEL_ALT
		dd	EXPAND_COMPOUND_ASSIGN
		dd	EXPAND_POST_INC_DEC
		dd	GET_SYMBOL_SEGMENT
		dd	SET_SYMBOL_FLAG_20
		dd	SET_SYMBOL_OFFSET
		dd	SET_SYMBOL_SEGMENT
		dd	SET_SYMBOL_SEGMENT_FLAGGED
		dd	SET_SYMBOL_WORD_10
		dd	DECLARE_NAMED_GLOBAL
		dd	GET_SYMBOL_KIND
		dd	GET_STRING_LITERAL_SYMBOL
		dd	STCVTD
		dd	GET_TYPE_KIND
		dd	SYMBOL_ELEMENT_KIND
		dd	SIZE_OF_TYPE_CHECKED
		dd	GET_SYMBOL_TYPE
		dd	GET_SYMBOL_WORD_10
; @371A
INITIAL_TYPE_POOL_IMAGE	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,002h
		db	000h,000h,000h,000h,000h,000h,000h,000h,002h,008h,000h,000h
		db	000h,000h,000h,000h,000h,000h,003h,004h,000h,000h,000h,000h
		db	000h,000h,000h,000h,004h,00Ah,000h,000h,000h,000h,000h,000h
		db	000h,000h,005h,004h,000h,000h,000h,000h,000h,000h,000h,000h
		db	006h,00Ah,000h,000h,000h,000h,000h,000h,000h,000h,007h,006h
		db	000h,000h,000h,000h,000h,000h,000h,000h,008h,00Ch,000h,000h
		db	000h,000h,000h,000h,000h,000h,009h,00Eh,000h,000h,000h,000h
		db	000h,000h,000h,000h,00Ah,00Fh,000h,000h,000h,000h,000h,000h
		db	000h,000h,00Bh,010h,000h,000h,000h,000h,000h,000h,000h,000h
		db	00Ch,001h,000h,000h,000h,000h,000h,000h,000h,000h
; @379C
STR_S	label	byte
		db	's@',000h
; @379F
STR_MAIN	label	byte
		db	'main',000h
; @37A4
STR_STATIC	label	byte
		db	'static',000h
; @37AB
STR_SETARGV	label	byte
		db	'_setargv__',000h
; @37B6
STR_SETARGV_2	label	byte
		db	'__setargv__',000h
; @37C2
STR_SETENVP	label	byte
		db	'_setenvp__',000h
; @37CD
STR_SETENVP_2	label	byte
		db	'__setenvp__',000h,000h
; @37DA
STORAGE_CLASS_NAMES	label	byte
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_37F6
		dw	offset DGROUP:DATA_37FD
		dw	offset DGROUP:DATA_37FD
		dw	offset DGROUP:DATA_3804
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_3809
		db	000h,000h,000h,000h,000h,000h,000h,000h,011h,'8'
; @37F6
DATA_37F6	label	byte
		db	'extern',000h
; @37FD
DATA_37FD	label	byte
		db	'static',000h
; @3804
DATA_3804	label	byte
		db	'auto',000h
; @3809
DATA_3809	label	byte
		db	'typedef',000h,'register',000h
; @381A
STR_DEBUG_C	label	byte
		db	009h,'?debug',009h,'C ',000h
; @3825
STR_DEBUG_C_2	label	byte
		db	'+',00Dh,00Ah,009h,'?debug',009h,'C ',000h
; @3833
STR_CR_NL	label	byte
		db	00Dh,00Ah,000h
; @3836
STR_EXTRN	label	byte
		db	009h,'extrn',009h,000h
; @383E
STR_NEAR_3	label	byte
		db	'near',000h
; @3843
STR_PUBLICDLL	label	byte
		db	009h,'publicdll',009h,000h
; @384F
STR_PUBLIC_2	label	byte
		db	009h,'public',009h,000h
; @3858
STR_EQU_S	label	byte
		db	009h,'equ',009h,'s@+',000h
; @3861
STR_EQU	label	byte
		db	009h,'equ',009h,000h
; @3867
STR_01	label	byte
		db	'01',000h
; @386A
STR_DEBUG_F	label	byte
		db	009h,'?debug',009h,'F ',000h
; @3875
STR_D	label	byte
		db	'd@',000h
; @3878
STR_B	label	byte
		db	'b@',000h,000h
; @387C
STR_TURBOFLOAT_2	label	byte
		db	'__turboFloat',000h,000h
; @388A
EXPR_RETYPE_SHAPE	label	byte
		db	000h,001h,003h,000h,001h,001h,001h,001h,'00',000h,000h,000h
		db	010h,000h,'000',000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' 0',000h
		db	000h,010h,' ',000h,000h,000h,'00',000h,000h,000h,000h,000h,002h
		db	000h
; @38C1
EXPR_NARROW_SHAPE	label	byte
		db	000h
; @38C2
INVERT_COMPARE_TABLE	label	byte
		db	000h,003h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
; @38CE
MIRROR_COMPARE_TABLE	label	byte
		db	000h,'@',0C0h,0C0h,0C0h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,080h
		db	0C0h,000h,000h,'@',080h,000h,000h,000h,0C0h,0C0h,000h,000h,000h
		db	000h,000h,002h,000h
; @38F8
STR_COLON_2	label	byte
		db	':',000h
; @38FA
OUTPUT_FILE_HANDLE	label	byte
		db	0FFh,0FFh,01Eh,000h,01Dh,000h,'"',000h,'!',000h,' ',000h,01Fh
		db	000h,01Dh,000h,01Eh,000h,' ',000h,01Fh,000h,'"',000h,'!',000h
; @3914
JUMP_CONDITION_INVERSE_TABLE	label	byte
		db	001h,000h,007h,006h,009h,008h,003h,002h,005h,004h,00Bh,00Ah
		db	00Dh,00Ch,00Fh,00Eh,011h,010h,013h,012h
; @3928
KIND_INFO_TABLE	label	byte
		db	000h,000h,000h
; @392B
KIND_SIZE_TABLE	label	byte
		db	000h,001h,001h,001h,001h,002h,001h,001h,001h,003h,003h,002h
; @3937
BITFIELD_UNIT_BYTES	label	byte
		db	002h,004h,003h,002h,002h,003h,003h,002h,002h,004h,003h,002h
		db	002h,007h,007h,002h,004h,008h,007h,002h,004h,009h,009h,002h
		db	004h,00Ah,00Ah,002h,008h,00Bh,00Bh,002h,00Ah,00Ch,00Ch,001h
		db	000h,00Dh,003h,002h,002h,00Eh,003h,002h,002h,00Fh,007h,002h
		db	004h,010h,007h,002h,004h,011h,011h,001h,000h,012h,012h,001h
		db	000h,013h,013h,002h,000h
; @3978
TYPE_RANGE_TABLE	label	byte
		db	014h,014h,002h,000h,015h,003h,002h,002h
; @3980
BCC_ENUM_MIN_LO	label	byte
		db	080h,0FFh,0FFh,0FFh
; @3984
BCC_ENUM_MAX_LO	label	byte
		db	07Fh,000h,000h,000h,000h,000h,000h,000h
; @398C
INT_LIMIT	label	byte
		db	0FFh,000h,000h,000h,000h,080h,0FFh,0FFh,0FFh,07Fh,000h,000h
		db	000h,000h,000h,000h
; @399C
MASK_B	label	byte
		db	0FFh,0FFh,000h,000h,000h,080h,0FFh,0FFh
; @39A4
BCC_ENUM_LIMIT_LO	label	byte
		db	0FFh,07Fh,000h,000h,000h,000h,000h,000h
; @39AC
MASK_C	label	byte
		db	0FFh,0FFh,000h,000h,001h,000h,000h,080h
; @39B4
LONG_MAX_VALUE	label	byte
		db	0FFh,0FFh,0FFh,07Fh
; @39B8
OPERATOR_RULES	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,002h,002h
		db	002h,002h,002h,002h,003h,003h,002h,002h,002h,'3',002h,002h,003h
		db	003h,002h,002h,005h,005h,000h,006h,006h,006h,006h,006h,006h
		db	007h,007h,'3333',006h,006h,007h,007h,'3333',000h,'33333333'
		db	008h,008h,008h,'333333333',004h,004h,004h,004h,004h,004h,004h
		db	004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h
		db	004h,004h,000h,002h,002h,002h,002h,002h,002h,003h,003h,002h
		db	002h,002h,'3',002h,002h,003h,003h,002h,'3',009h,009h,000h,002h
		db	002h,002h,002h,002h,002h,003h,003h,002h,002h,002h,'3',002h,002h
		db	003h,003h,'33',009h,009h,'333333333333333333333',000h,00Ah,00Ah
		db	00Ah,00Ah,00Ah,00Ah,00Bh,00Bh,00Ch,00Ch,00Ch,'3',00Ah,'3',00Eh
		db	00Fh,'3333',000h,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,010h,010h,00Ch
		db	00Ch,00Ch,'3',00Ah,'3',00Eh,00Fh,'3333',000h,'33',011h,011h
		db	011h,011h,012h,012h,00Ch,00Ch,00Ch,'333333333',000h,'33',013h
		db	014h,013h,014h,'33',00Ch,00Ch,00Ch,'333333333',000h,'33',013h
		db	015h,013h,015h,'33333333333333',000h,00Ah,00Ah,00Ah,00Ah,00Ah
		db	00Ah,016h,016h,'333333333333',000h,017h,00Ah,017h,00Ah,017h
		db	00Ah,016h,016h,'333333333333',000h,00Ah,00Ah,00Ah,00Ah,00Ah
		db	00Ah,018h,018h,'333333333333',000h,00Ah,00Ah,00Ah,00Ah,00Ah
		db	00Ah,018h,018h,'333333333333',000h,00Ah,00Ah,00Ah,00Ah,00Ah
		db	00Ah,018h,018h,'333333333333',000h,019h,019h,019h,019h,019h
		db	019h,01Ah,01Ah,01Bh,01Bh,01Bh,'3',019h,019h,01Ah,01Ah,'3333'
		db	000h,019h,019h,019h,019h,019h,019h,01Ch,01Ch,00Dh,00Dh,00Dh
		db	'3',019h,'3',01Eh,01Fh,'3333',000h,019h,019h,019h,019h,019h
		db	019h,'  ',00Dh,00Dh,00Dh,'3',019h,'3',01Eh,01Fh,'3333',000h
		db	'!!""""33',00Dh,00Dh,00Dh,'333333333',000h,'#%333333',00Dh,00Dh
		db	00Dh,'333333333',000h,'$&333333333333333333',000h,019h,019h
		db	019h,019h,019h,019h,'33333333333333',000h,027h,019h,027h,019h
		db	027h,019h,'33333333333333',000h,019h,019h,019h,019h,019h,019h
		db	01Dh,01Dh,'333333333333',000h,019h,019h,019h,019h,019h,019h
		db	01Dh,01Dh,'333333333333',000h,019h,019h,019h,019h,019h,019h
		db	01Dh,01Dh,'3333333333333333333333333333333333333333','3333333333333333333333333333333333333333'
		db	'3333333333333333333333333333333333333333','3333333333333333333333333333333333333333'
		db	'3333333333333333333333333333333333333333','3333333333333333333333333333333333333333'
		db	'333333333333333333333333((((((((((((((((','((((()))))))))))))))))))))33333333333333'
		db	'3333333',000h,'33*3*3+3333333333333',000h,'33333333333333,33333'
		db	000h,'------..///333333333',000h,'------00333333333333',000h
		db	'1111113333333333333333333333333333333333','3333333333333333333333'
		db	000h,'33333333333333333333',000h,'33333333333333332333',001h
		db	001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h
		db	001h,001h,001h,001h,001h,001h,001h,001h,'333333333333333333333'
; @3E3B
CONVERSION_RULES	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,001h,001h,003h,003h,003h,003h
		db	004h,004h,005h,005h,005h,001h,003h,003h,004h,004h,000h,001h
		db	001h,006h,006h,006h,006h,007h,007h,008h,008h,008h,001h,006h
		db	006h,007h,007h,000h,001h,001h,001h,001h,001h,001h,00Ah,00Ah
		db	00Bh,00Bh,00Bh,001h,001h,001h,00Ah,00Ah,000h,001h,001h,001h
		db	001h,001h,001h,00Dh,00Dh,00Eh,00Eh,00Eh,001h,001h,001h,00Dh
		db	00Dh,000h,001h,001h,001h,001h,001h,001h,00Ah,00Ah,00Bh,00Bh
		db	00Bh,001h,001h,001h,00Ah,00Ah,000h,001h,001h,001h,001h,001h
		db	001h,00Dh,00Dh,00Eh,00Eh,00Eh,001h,001h,001h,00Dh,00Dh,000h
		db	00Fh,00Fh,009h,009h,009h,009h,001h,001h,011h,011h,011h,001h
		db	009h,010h,001h,001h,000h,00Fh,00Fh,009h,009h,009h,009h,001h
		db	001h,012h,012h,012h,001h,009h,010h,001h,001h,000h,016h,016h
		db	016h,016h,016h,016h,018h,018h,001h,001h,001h,001h,016h,017h
		db	018h,018h,000h,016h,016h,016h,016h,016h,016h,018h,018h,002h
		db	001h,001h,001h,016h,017h,018h,018h,000h,016h,016h,016h,016h
		db	016h,016h,018h,018h,002h,002h,001h,001h,016h,017h,018h,018h
		db	019h,019h,019h,019h,019h,019h,019h,019h,019h,019h,019h,019h
		db	019h,019h,019h,019h,019h,000h,001h,001h,001h,001h,001h,001h
		db	013h,013h,014h,014h,014h,001h,001h,001h,013h,013h,000h,001h
		db	001h,001h,001h,001h,001h,015h,015h,00Ch,00Ch,00Ch,001h,001h
		db	001h,015h,015h,000h,00Fh,00Fh,009h,009h,009h,009h,001h,001h
		db	012h,012h,012h,001h,009h,010h,001h,001h,000h,00Fh,00Fh,009h
		db	009h,009h,009h,001h,001h,012h,012h,012h,001h,009h,010h,001h
		db	001h
; @3F5C
STR_AHSHIFT_2	label	byte
		db	'__AHSHIFT',000h,'padd@',000h,'psub@',000h,'psba@',000h,'pada@'
		db	000h,'psbh@',000h,'psbp@',000h
; @3F8A
STR_SCOPY_2	label	byte
		db	'scopy@',000h
; @3F91
STR_FTOL	label	byte
		db	'ftol@',000h,000h
; @3F98
OPCODE_DESCRIPTOR_TABLE	label	byte
		db	'LP',001h
; @3F9B
CODE_OP_INFO_TABLE	label	byte
		db	000h,' ',000h,000h,000h
; @3FA0
OPCODE_DESC_BYTE8	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,004h
		db	000h,000h,000h,010h,000h,010h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,001h,004h,000h,000h,000h,010h,000h
		db	010h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h
		db	000h,003h,000h,002h,000h,000h,000h,010h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,008h,000h,004h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,008h,000h,004h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,' ',000h,004h,000h,001h
		db	000h,000h,000h,00Ch,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,' ',000h,004h,000h,002h,000h,000h,000h,010h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,008h,000h,000h,000h
		db	001h,000h,000h,000h,00Ch,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,008h,000h,000h,000h,002h,000h,000h,000h,00Ah
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h,000h
		db	000h,000h,003h,000h,000h,000h,00Ah,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,009h,000h,000h,000h,002h,000h,000h
		db	000h,00Ah,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	009h,000h,000h,000h,002h,000h,000h,000h,00Ah,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,008h,000h,000h,000h,002h
		db	000h,000h,000h,010h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,001h,000h,000h,000h,001h,000h,000h,000h,00Ch,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,000h,000h
		db	000h,002h,000h,000h,000h,010h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,001h,000h,000h,000h,002h,000h,000h,000h
		db	010h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h
		db	000h,000h,000h,004h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,003h,000h,000h,000h,005h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,003h,000h,000h,000h,006h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,000h
		db	001h,002h,00Eh,015h,00Ch,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,003h,000h,002h,002h,00Eh,015h,010h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	003h,000h,002h,002h,00Eh,015h,010h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,002h,000h,003h,000h,004h,002h,00Eh
		db	015h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	002h,000h,003h,000h,005h,002h,00Eh,015h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,002h,000h,003h,000h,006h
		db	002h,00Eh,015h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,003h,000h,002h,002h,00Eh,015h,010h,000h
		db	000h,000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5050
		db	0FEh,000h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	000h,000h,004h,000h
		dw	offset DGROUP:DATA_5050
		db	0FEh,000h,0C1h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,001h,000h,005h,000h
		dw	offset DGROUP:DATA_5050
		db	0FEh,010h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	000h,000h,004h,000h
		dw	offset DGROUP:DATA_5050
		db	0FEh,010h,0C1h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,001h,000h,005h,000h
		dw	offset DGROUP:DATA_5054
		db	003h,012h,000h,003h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0C1h,0D8h,0C0h,0D8h,000h
		dw	offset DGROUP:DATA_5054
		db	003h,012h,000h,003h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0C1h,0D8h,0C0h,0DCh,000h
		dw	offset DGROUP:DATA_5054
		db	003h,012h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0C1h,0D8h,0C0h,0DCh,000h
		dw	offset DGROUP:DATA_5059
		db	0FEh,010h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	010h,000h,014h,000h
		dw	offset DGROUP:DATA_5059
		db	0FEh,010h,0C1h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,011h,000h,015h,000h
		dw	offset DGROUP:DATA_505D
		db	0FEh,000h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	'(',000h,',',000h
		dw	offset DGROUP:DATA_505D
		db	0FEh,000h,0C1h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,')',000h,'-',000h
		dw	offset DGROUP:DATA_505D
		db	0FEh,000h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	'(',000h,',',000h
		dw	offset DGROUP:DATA_505D
		db	0FEh,000h,0C1h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,')',000h,'-',000h
		dw	offset DGROUP:DATA_5061
		db	003h,002h,000h,003h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0E9h,0D8h,0E0h,0D8h,' '
		dw	offset DGROUP:DATA_5061
		db	003h,002h,000h,003h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0E9h,0D8h,0E0h,0DCh,' '
		dw	offset DGROUP:DATA_5061
		db	003h,002h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0E9h,0D8h,0E0h,0DCh,' '
		dw	offset DGROUP:DATA_5066
		db	003h,002h,000h,003h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0E1h,0D8h,0E8h,0D8h,'('
		dw	offset DGROUP:DATA_5066
		db	003h,002h,000h,003h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0E1h,0D8h,0E8h,0DCh,'('
		dw	offset DGROUP:DATA_5066
		db	003h,002h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0E1h,0D8h,0E8h,0DCh,'('
		dw	offset DGROUP:DATA_506C
		db	0FEh,000h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	018h,000h,01Ch,000h
		dw	offset DGROUP:DATA_506C
		db	0FEh,000h,0C1h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,019h,000h,01Dh,000h
		dw	offset DGROUP:DATA_5070
		db	002h,010h,000h,003h,000h,001h,001h,001h,01Bh,001h,000h,0F6h
		db	000h,'(',000h,000h,000h
		dw	offset DGROUP:DATA_5070
		db	002h,010h,000h,003h,000h,002h,002h,009h,019h,009h,001h,000h
		db	000h,'(',000h,000h,000h
		dw	offset DGROUP:DATA_5075
		db	003h,012h,000h,003h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0C9h,0D8h,0C8h,0D8h,008h
		dw	offset DGROUP:DATA_5075
		db	003h,012h,000h,003h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0C9h,0D8h,0C8h,0DCh,008h
		dw	offset DGROUP:DATA_5075
		db	003h,012h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0C9h,0D8h,0C8h,0DCh,008h
		dw	offset DGROUP:DATA_507A
		db	002h,000h,000h,003h,000h,001h,001h,009h,01Ch,001h,000h,0F6h
		db	000h,'8',000h,000h,000h
		dw	offset DGROUP:DATA_507A
		db	002h,000h,000h,003h,000h,002h,002h,009h,01Ah,009h,001h,0F7h
		db	000h,'8',000h,000h,000h
		dw	offset DGROUP:DATA_507F
		db	003h,002h,000h,003h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0F9h,0D8h,0F0h,0D8h,'0'
		dw	offset DGROUP:DATA_507F
		db	003h,002h,000h,003h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0F9h,0D8h,0F0h,0DCh,'0'
		dw	offset DGROUP:DATA_507F
		db	003h,002h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0F9h,0D8h,0F0h,0DCh,'0'
		dw	offset DGROUP:DATA_5084
		db	003h,002h,000h,003h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0F1h,0D8h,0F8h,0D8h,'8'
		dw	offset DGROUP:DATA_5084
		db	003h,002h,000h,003h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0F1h,0D8h,0F8h,0DCh,'8'
		dw	offset DGROUP:DATA_5084
		db	003h,002h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0F1h,0D8h,0F8h,0DCh,'8'
		dw	offset DGROUP:DATA_507B
		db	002h,000h,000h,003h,000h,001h,001h,009h,01Ch,009h,001h,0F6h
		db	000h,'0',000h,000h,000h
		dw	offset DGROUP:DATA_507B
		db	002h,000h,000h,003h,000h,002h,002h,009h,01Ah,009h,001h,0F7h
		db	000h,'0',000h,000h,000h
		dw	offset DGROUP:DATA_507B
		db	002h,000h,000h,003h,000h,001h,001h,009h,01Ch,001h,001h,0F6h
		db	000h,'0',000h,000h,000h
		dw	offset DGROUP:DATA_507B
		db	002h,000h,000h,003h,000h,002h,002h,009h,01Ah,00Bh,002h,0F7h
		db	000h,'0',000h,000h,000h
		dw	offset DGROUP:DATA_507A
		db	002h,000h,000h,003h,000h,001h,001h,009h,01Ch,001h,000h,0F6h
		db	000h,'8',000h,000h,000h
		dw	offset DGROUP:DATA_507A
		db	002h,000h,000h,003h,000h,002h,002h,009h,01Ah,00Bh,002h,0F7h
		db	000h,'8',000h,000h,000h
		dw	offset DGROUP:DATA_508A
		db	0FEh,000h,001h,003h,000h,001h,001h,01Eh,007h,00Ch,000h,000h
		db	000h,000h,000h,' ',000h
		dw	offset DGROUP:DATA_508A
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,' ',000h
		dw	offset DGROUP:DATA_508E
		db	0FEh,000h,001h,003h,000h,001h,001h,01Eh,007h,00Ch,000h,000h
		db	000h,000h,000h,'(',000h
		dw	offset DGROUP:DATA_508E
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,'(',000h
		dw	offset DGROUP:DATA_5092
		db	0FEh,000h,001h,003h,000h,001h,001h,01Eh,007h,00Ch,000h,000h
		db	000h,000h,000h,'8',000h
		dw	offset DGROUP:DATA_5092
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,'8',000h
		dw	offset DGROUP:DATA_5096
		db	0FEh,010h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	' ',000h,'$',000h
		dw	offset DGROUP:DATA_5096
		db	0FEh,010h,'A',003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h,000h
		db	'!',000h,'%',000h
		dw	offset DGROUP:DATA_509A
		db	0FEh,010h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	008h,000h,00Ch,000h
		dw	offset DGROUP:DATA_509A
		db	0FEh,010h,'A',003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h,000h
		db	009h,000h,00Dh,000h
		dw	offset DGROUP:DATA_509D
		db	0FEh,010h,'A',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	'0',000h,'4',000h
		dw	offset DGROUP:DATA_509D
		db	0FEh,010h,'A',003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h,000h
		db	'1',000h,'5',000h
		dw	offset DGROUP:DATA_50A1
		db	002h,000h,001h,003h,000h,001h,001h,00Ch,000h,00Ch,000h,0F6h
		db	000h,018h,000h,000h,000h
		dw	offset DGROUP:DATA_50A1
		db	002h,000h,001h,003h,000h,002h,002h,00Ah,000h,00Ah,000h,0F7h
		db	000h,018h,000h,000h,000h
		dw	offset DGROUP:DATA_50A5
		db	003h,002h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0D9h
		db	0E0h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50AA
		db	0FEh,000h,001h,003h,000h,001h,001h,00Ch,000h,00Ch,000h,0F6h
		db	000h,010h,000h,000h,000h
		dw	offset DGROUP:DATA_50AA
		db	0FEh,000h,001h,003h,000h,002h,002h,00Ah,000h,00Ah,000h,0F7h
		db	000h,010h,000h,000h,000h
		dw	offset DGROUP:DATA_50AE
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,018h,000h
		dw	offset DGROUP:DATA_50B2
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,010h,000h
		dw	offset DGROUP:DATA_50B6
		db	002h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50BC
		db	0FFh,000h,001h,003h,000h,001h,001h,00Ch,000h,00Ch,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50BC
		db	0FFh,000h,001h,003h,000h,002h,002h,00Ah,000h,00Ah,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50C0
		db	0FFh,000h,001h,003h,000h,001h,001h,00Ch,000h,00Ch,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50C0
		db	0FFh,000h,001h,003h,000h,002h,002h,00Ah,000h,00Ah,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50C4
		db	003h,002h,000h,003h,000h,004h,002h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DFh,000h
		dw	offset DGROUP:DATA_50C4
		db	003h,002h,000h,003h,000h,005h,002h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DBh,000h
		dw	offset DGROUP:DATA_50C4
		db	003h,002h,000h,003h,000h,006h,005h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DFh,'('
		dw	offset DGROUP:DATA_50C9
		db	003h,006h,000h,003h,000h,002h,004h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DFh,018h
		dw	offset DGROUP:DATA_50C9
		db	003h,006h,000h,003h,000h,003h,005h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DBh,018h
		dw	offset DGROUP:DATA_50C9
		db	003h,006h,000h,003h,000h,005h,006h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DFh,'8'
		dw	offset DGROUP:DATA_50CF
		db	003h,006h,000h,003h,000h,002h,002h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DFh,010h
		dw	offset DGROUP:DATA_50CF
		db	003h,006h,000h,003h,000h,003h,003h,000h,000h,000h,000h,000h
		db	000h,000h,000h,0DBh,018h
		dw	offset DGROUP:DATA_50CF
		db	003h,006h,000h,003h,000h,005h,005h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50D4
		db	003h,002h,000h,000h,000h,004h,004h,000h,000h,000h,000h,000h
		db	000h,0D9h,0C0h,0D9h,000h
		dw	offset DGROUP:DATA_50D4
		db	003h,002h,000h,000h,000h,005h,005h,000h,000h,000h,000h,000h
		db	000h,0D9h,0C0h,0DDh,000h
		dw	offset DGROUP:DATA_50D4
		db	003h,002h,000h,000h,000h,006h,006h,000h,000h,000h,000h,000h
		db	000h,0D9h,0C0h,0DBh,'('
		dw	offset DGROUP:DATA_50D8
		db	003h,006h,000h,003h,000h,004h,004h,000h,000h,000h,000h,000h
		db	000h,0DDh,0D0h,0D9h,010h
		dw	offset DGROUP:DATA_50D8
		db	003h,006h,000h,003h,000h,005h,005h,000h,000h,000h,000h,000h
		db	000h,0DDh,0D0h,0DDh,010h
		dw	offset DGROUP:DATA_50DC
		db	003h,006h,000h,003h,000h,004h,004h,000h,000h,000h,000h,000h
		db	000h,0DDh,0D8h,0D9h,018h
		dw	offset DGROUP:DATA_50DC
		db	003h,006h,000h,003h,000h,005h,005h,000h,000h,000h,000h,000h
		db	000h,0DDh,0D8h,0DDh,018h
		dw	offset DGROUP:DATA_50DC
		db	003h,006h,000h,003h,000h,006h,006h,000h,000h,000h,000h,000h
		db	000h,0DDh,0D8h,0DBh,'8',000h,000h,000h,000h,000h,003h,000h,000h
		db	000h,009h,000h,009h,001h,000h,000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50E1
		db	002h,000h,'@',000h,000h,002h,002h,00Bh,001h,000h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_50E1
		db	002h,000h,'@',000h,000h,002h,002h,00Bh,009h,000h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_50E5
		db	002h,000h,'@',000h,000h,002h,002h,001h,00Bh,001h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_50E5
		db	002h,000h,'@',000h,000h,002h,002h,009h,00Bh,009h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_50E8
		db	002h,008h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50EC
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,00Ah,000h,09Ch
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50F2
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,00Ah,000h,09Dh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50F7
		db	002h,000h,004h,004h,000h,002h,002h,00Ah,000h,009h,000h,0FFh
		db	000h,010h,000h,000h,000h
		dw	offset DGROUP:DATA_50F7
		db	002h,000h,004h,004h,000h,002h,002h,010h,010h,009h,000h,0FFh
		db	000h,018h,000h,000h,000h
		dw	offset DGROUP:DATA_50F7
		db	001h,009h,004h,004h,000h,002h,000h,000h,000h,009h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50F7
		db	003h,009h,004h,004h,000h,002h,000h,000h,000h,009h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50FC
		db	002h,008h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50FF
		db	001h,008h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50FC
		db	002h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50FC
		db	002h,009h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5102
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0C9h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5108
		db	0FFh,000h,000h,000h,000h,002h,002h,000h,000h,010h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_510C
		db	0FEh,'@@',004h,000h,001h,001h,00Ch,00Ch,000h,000h,000h,000h
		db	'8',000h,'<',000h
		dw	offset DGROUP:DATA_510C
		db	0FEh,'@',0C0h,004h,000h,002h,002h,00Ah,00Ah,000h,000h,000h,000h
		db	'9',000h,'=',000h
		dw	offset DGROUP:DATA_5110
		db	003h,002h,000h,004h,000h,004h,004h,000h,000h,000h,000h,0DEh
		db	0D9h,0D8h,0D8h,0D8h,018h
		dw	offset DGROUP:DATA_5110
		db	003h,002h,000h,004h,000h,005h,005h,000h,000h,000h,000h,0DEh
		db	0D9h,0D8h,0D8h,0DCh,018h
		dw	offset DGROUP:DATA_5110
		db	003h,002h,000h,004h,000h,006h,006h,000h,000h,000h,000h,0DEh
		db	0D9h,0D8h,0D8h,0DCh,018h
		dw	offset DGROUP:DATA_5116
		db	0FEh,'@@',004h,000h,001h,001h,00Ch,00Ch,000h,000h,000h,000h
		db	084h,000h,0A8h,000h
		dw	offset DGROUP:DATA_5116
		db	0FEh,'@@',004h,000h,002h,002h,00Ah,00Ah,000h,000h,000h,000h
		db	085h,000h,0A9h,000h
		dw	offset DGROUP:DATA_511B
		db	003h,002h,000h,004h,000h,004h,004h,000h,000h,000h,000h,0D9h
		db	0E4h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_511B
		db	003h,002h,000h,004h,000h,005h,005h,000h,000h,000h,000h,0D9h
		db	0E4h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_511B
		db	003h,002h,000h,004h,000h,006h,006h,000h,000h,000h,000h,0D9h
		db	0E4h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5120
		db	003h,002h,000h,000h,000h,004h,000h,000h,000h,000h,000h,0D9h
		db	0EEh,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5125
		db	003h,002h,000h,000h,000h,004h,000h,000h,000h,000h,000h,0D9h
		db	0E8h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50D4
		db	003h,002h,000h,000h,000h,006h,006h,000h,000h,000h,000h,000h
		db	000h,0D9h,0C0h,000h,000h
		dw	offset DGROUP:DATA_512A
		db	003h,002h,000h,000h,000h,006h,006h,000h,000h,000h,000h,0DDh
		db	0C0h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5130
		db	003h,002h,000h,000h,000h,006h,006h,000h,000h,000h,000h,0D9h
		db	0F6h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5137
		db	003h,002h,000h,003h,000h,002h,002h,000h,000h,000h,000h,000h
		db	000h,0DFh,0E0h,0DDh,'8'
		dw	offset DGROUP:DATA_513D
		db	002h,002h,000h,003h,000h,000h,000h,000h,000h,000h,000h,0DDh
		db	0D8h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_514B
		db	002h,002h,000h,003h,000h,000h,000h,000h,000h,000h,000h,0D9h
		db	0C9h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5159
		db	004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0C8h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_515F
		db	0FFh,'@@',000h,000h,000h,001h,00Ch,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_515F
		db	0FFh,'@@',000h,000h,000h,002h,00Ah,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_5164
		db	002h,000h,000h,003h,000h,002h,002h,000h,000h,00Ah,000h,08Dh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5168
		db	002h,000h,000h,000h,000h,002h,003h,000h,000h,000h,000h,0C4h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,000h,'@',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,000h,'@',003h,000h,002h,002h,00Ah,00Ah,010h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,000h,'A',003h,000h,002h,002h,010h,010h,010h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_5170
		db	0FEh,000h,000h,003h,000h,002h,002h,00Ah,00Ah,00Ah,000h,000h
		db	000h,085h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,004h,'@',003h,000h,001h,001h,00Ch,00Ch,00Ch,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,004h,'@',003h,000h,002h,002h,010h,010h,010h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,004h,'@',003h,000h,003h,003h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,004h,000h,003h,000h,004h,004h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,004h,000h,003h,000h,005h,005h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	0FEh,004h,000h,003h,000h,006h,006h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5175
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,0CAh,000h,0CBh,000h
		dw	offset DGROUP:DATA_5175
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,0C2h,000h,0C3h,000h
		dw	offset DGROUP:DATA_5179
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0CFh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_50FC
		db	002h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5051
		db	004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_517E
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0FAh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5182
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0FBh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5186
		db	001h,000h,000h,000h,000h,000h,000h,000h,000h,009h,000h,09Fh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_518B
		db	001h,000h,000h,000h,000h,000h,000h,002h,000h,009h,000h,09Eh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_516C
		db	001h,000h,001h,003h,000h,002h,001h,00Ch,000h,01Fh,000h,098h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5190
		db	001h,000h,001h,003h,000h,002h,001h,001h,000h,009h,000h,098h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5194
		db	001h,000h,001h,003h,000h,003h,002h,009h,000h,009h,001h,099h
		db	000h,000h,000h,000h,000h,000h,000h,000h,008h,000h,004h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,008h,000h,004h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,008h,000h,000h,000h,000h,000h,000h
		db	000h,000h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	008h,' ',004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,008h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,002h,000h,000h,000h,006h,006h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,002h,000h,004h,000h
		db	006h,006h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,002h,009h,00Bh,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	000h,002h,00Dh,00Fh,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,002h,009h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	000h,002h,00Bh,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,002h,00Fh,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	000h,001h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,001h,003h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	000h,001h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,001h,007h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	000h,002h,00Dh,015h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,002h,011h,015h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	000h,002h,012h,015h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,000h,002h,012h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	002h,000h,000h,000h,009h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,002h,000h,000h,000h,00Bh,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	002h,000h,000h,000h,00Fh,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,002h,000h,000h,000h,00Dh,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,' ',004h,000h
		db	002h,000h,000h,000h,012h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,' ',004h,000h,002h,000h,000h,000h,015h,000h
		db	000h,000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_5198
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0F3h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_519C
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0F3h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51A1
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0F2h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51A7
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0AEh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51AD
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0A4h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51B3
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0A5h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51B9
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0A6h
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51BF
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0AAh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51C5
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ABh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51CB
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0FDh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51CF
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0FCh
		db	000h,000h,000h,000h,000h
		dw	offset DGROUP:DATA_51D3
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,000h,000h
		dw	offset DGROUP:DATA_51D7
		db	0FEh,000h,001h,003h,000h,002h,002h,01Dh,007h,00Ah,000h,000h
		db	000h,001h,000h,008h,000h
		dw	offset DGROUP:DATA_51DB
		db	003h,002h,000h,003h,000h,006h,006h,000h,000h,000h,000h,0D9h
		db	0E1h,000h,000h,000h,000h
; @4F7A
REG_CLASS_MASK_TABLE	label	byte
		db	000h,000h,001h,000h,002h,000h,004h,000h,008h,000h,010h,000h
		db	' ',000h,'@',000h,080h,000h,001h,000h,'U',007h,004h,000h,0FFh
		db	000h,010h,000h,010h,003h,'@',000h,'U',0FFh,000h,001h,000h,002h
		db	000h,004h,000h,008h,000h,010h,000h,' ',000h,'@',000h,080h,'T'
		db	007h,'P',007h,0FCh,000h,0F0h,000h,015h,007h,'?',000h,'U',000h
		db	000h,003h
; @4FBC
REG_CLASS_IS_WORD	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,001h,001h
		db	000h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h
		db	001h,001h,001h,000h,000h,001h,000h,001h,001h
; @4FDD
REGISTER_MASK_TABLE	label	byte
		db	000h,000h,004h,000h,001h,000h,'U',010h,001h,000h,010h,000h
; @4FE9
OPERAND_BASE_BY_KIND	label	byte
		db	000h,00Fh,009h,000h,000h,00Fh,00Fh,00Fh,01Eh,027h,'16BDFJLN'
		db	09Bh,01Eh,027h,'16BDFJLN',000h,000h,000h,000h,000h,000h,01Eh
		db	027h,000h,000h,000h,000h,000h,000h,000h,027h,01Eh,'PS',000h
		db	015h,000h,000h,000h,000h,000h
; @5020
LEAF_OPCODE_KIND_OFFSET	label	byte
		db	000h,000h,000h,001h,001h,001h,001h,002h,002h,003h,004h,005h
		db	001h,001h,001h,002h,002h,000h,001h,001h,001h,001h
; @5036
OPER_OPCODE_KIND_OFFSET	label	byte
		db	000h,000h,000h,001h,001h,001h,001h,001h,001h,002h,003h,004h
		db	001h,001h,001h,001h,001h,000h,001h,001h,001h,001h,'nop',000h
; @5050
DATA_5050	label	byte
		db	'a'
; @5051
DATA_5051	label	byte
		db	'dd',000h
; @5054
DATA_5054	label	byte
		db	'fadd',000h
; @5059
DATA_5059	label	byte
		db	'adc',000h
; @505D
DATA_505D	label	byte
		db	'sub',000h
; @5061
DATA_5061	label	byte
		db	'fsub',000h
; @5066
DATA_5066	label	byte
		db	'fsubr',000h
; @506C
DATA_506C	label	byte
		db	'sbb',000h
; @5070
DATA_5070	label	byte
		db	'imul',000h
; @5075
DATA_5075	label	byte
		db	'fmul',000h
; @507A
DATA_507A	label	byte
		db	'i'
; @507B
DATA_507B	label	byte
		db	'div',000h
; @507F
DATA_507F	label	byte
		db	'fdiv',000h
; @5084
DATA_5084	label	byte
		db	'fdivr',000h
; @508A
DATA_508A	label	byte
		db	'shl',000h
; @508E
DATA_508E	label	byte
		db	'shr',000h
; @5092
DATA_5092	label	byte
		db	'sar',000h
; @5096
DATA_5096	label	byte
		db	'and',000h
; @509A
DATA_509A	label	byte
		db	'or',000h
; @509D
DATA_509D	label	byte
		db	'xor',000h
; @50A1
DATA_50A1	label	byte
		db	'neg',000h
; @50A5
DATA_50A5	label	byte
		db	'fchs',000h
; @50AA
DATA_50AA	label	byte
		db	'not',000h
; @50AE
DATA_50AE	label	byte
		db	'rcr',000h
; @50B2
DATA_50B2	label	byte
		db	'rcl',000h
; @50B6
DATA_50B6	label	byte
		db	'fwait',000h
; @50BC
DATA_50BC	label	byte
		db	'inc',000h
; @50C0
DATA_50C0	label	byte
		db	'dec',000h
; @50C4
DATA_50C4	label	byte
		db	'fild',000h
; @50C9
DATA_50C9	label	byte
		db	'fistp',000h
; @50CF
DATA_50CF	label	byte
		db	'fist',000h
; @50D4
DATA_50D4	label	byte
		db	'fld',000h
; @50D8
DATA_50D8	label	byte
		db	'fst',000h
; @50DC
DATA_50DC	label	byte
		db	'fstp',000h
; @50E1
DATA_50E1	label	byte
		db	'out',000h
; @50E5
DATA_50E5	label	byte
		db	'in',000h
; @50E8
DATA_50E8	label	byte
		db	'int',000h
; @50EC
DATA_50EC	label	byte
		db	'pushf',000h
; @50F2
DATA_50F2	label	byte
		db	'popf',000h
; @50F7
DATA_50F7	label	byte
		db	'call',000h
; @50FC
DATA_50FC	label	byte
		db	'dw',000h
; @50FF
DATA_50FF	label	byte
		db	'db',000h
; @5102
DATA_5102	label	byte
		db	'leave',000h
; @5108
DATA_5108	label	byte
		db	'pop',000h
; @510C
DATA_510C	label	byte
		db	'cmp',000h
; @5110
DATA_5110	label	byte
		db	'fcomp',000h
; @5116
DATA_5116	label	byte
		db	'test',000h
; @511B
DATA_511B	label	byte
		db	'ftst',000h
; @5120
DATA_5120	label	byte
		db	'fldz',000h
; @5125
DATA_5125	label	byte
		db	'fld1',000h
; @512A
DATA_512A	label	byte
		db	'ffree',000h
; @5130
DATA_5130	label	byte
		db	'fdecsp',000h
; @5137
DATA_5137	label	byte
		db	'fstsw',000h
; @513D
DATA_513D	label	byte
		db	'fstp    st(0)',000h
; @514B
DATA_514B	label	byte
		db	'fxch    st(1)',000h
; @5159
DATA_5159	label	byte
		db	'enter',000h
; @515F
DATA_515F	label	byte
		db	'push',000h
; @5164
DATA_5164	label	byte
		db	'lea',000h
; @5168
DATA_5168	label	byte
		db	'les',000h
; @516C
DATA_516C	label	byte
		db	'mov',000h
; @5170
DATA_5170	label	byte
		db	'xchg',000h
; @5175
DATA_5175	label	byte
		db	'ret',000h
; @5179
DATA_5179	label	byte
		db	'iret',000h
; @517E
DATA_517E	label	byte
		db	'cli',000h
; @5182
DATA_5182	label	byte
		db	'sti',000h
; @5186
DATA_5186	label	byte
		db	'lahf',000h
; @518B
DATA_518B	label	byte
		db	'sahf',000h
; @5190
DATA_5190	label	byte
		db	'cbw',000h
; @5194
DATA_5194	label	byte
		db	'cwd',000h
; @5198
DATA_5198	label	byte
		db	'rep',000h
; @519C
DATA_519C	label	byte
		db	'repz',000h
; @51A1
DATA_51A1	label	byte
		db	'repnz',000h
; @51A7
DATA_51A7	label	byte
		db	'scasb',000h
; @51AD
DATA_51AD	label	byte
		db	'movsb',000h
; @51B3
DATA_51B3	label	byte
		db	'movsw',000h
; @51B9
DATA_51B9	label	byte
		db	'cmpsb',000h
; @51BF
DATA_51BF	label	byte
		db	'stosb',000h
; @51C5
DATA_51C5	label	byte
		db	'stosw',000h
; @51CB
DATA_51CB	label	byte
		db	'std',000h
; @51CF
DATA_51CF	label	byte
		db	'cld',000h
; @51D3
DATA_51D3	label	byte
		db	'rol',000h
; @51D7
DATA_51D7	label	byte
		db	'ror',000h
; @51DB
DATA_51DB	label	byte
		db	'fabs'
; @51DF
REGISTER_NEED_TABLE	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,001h
		db	001h,001h,001h,001h,002h,002h,001h,001h,001h,001h,001h,001h
		db	002h,002h,002h,001h,001h,001h,001h,001h,001h,002h,002h,002h
		db	002h,005h,005h,001h,001h,001h,001h,002h,002h,005h,005h,002h
		db	001h,001h,001h,002h,005h,005h,005h,005h,005h,005h,005h,005h
		db	005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h
		db	005h,000h
; @5235
OPERATOR_HELPER_NAME_TABLE	label	byte
		db	000h,000h,000h,000h,000h,000h,000h,001h,001h,002h,002h,002h
		db	002h,002h,001h,001h,001h,001h,001h,001h,002h,002h,002h,002h
		db	002h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h
		db	000h,001h,001h,001h,001h,000h,000h,001h,001h,001h,001h,001h
		db	001h,001h,001h,001h,001h,003h
		dw	offset DGROUP:DATA_528B
		dw	offset DGROUP:DATA_528B
		dw	offset DGROUP:DATA_5292
		dw	offset DGROUP:DATA_5298
		dw	offset DGROUP:DATA_529F
		dw	offset DGROUP:DATA_52A5
		dw	offset DGROUP:DATA_52AC
		dw	offset DGROUP:DATA_52AC
		dw	offset DGROUP:DATA_52B3
		dw	offset DGROUP:DATA_52BA
		db	00Ah,00Bh,005h,004h,009h,008h,00Ah,00Bh,003h,002h,007h,006h
; @528B
DATA_528B	label	byte
		db	'lxmul@',000h
; @5292
DATA_5292	label	byte
		db	'ldiv@',000h
; @5298
DATA_5298	label	byte
		db	'ludiv@',000h
; @529F
DATA_529F	label	byte
		db	'lmod@',000h
; @52A5
DATA_52A5	label	byte
		db	'lumod@',000h
; @52AC
DATA_52AC	label	byte
		db	'lxlsh@',000h
; @52B3
DATA_52B3	label	byte
		db	'lxrsh@',000h
; @52BA
DATA_52BA	label	byte
		db	'lxursh@',000h
; @52C2
STR_PCMP	label	byte
		db	'pcmp@',000h
; @52C8
STR_TEXT	label	byte
		db	'_TEXT',000h
; @52CE
STR_STKLEN_2	label	byte
		db	'_stklen',000h
; @52D6
STR_BRKLVL	label	byte
		db	'__brklvl',000h
; @52DF
STR_OVERFLOW	label	byte
		db	'overflow@',000h
; @52E9
STR_SPUSH	label	byte
		db	'spush@',000h
; @52F0
STR_SCOPY	label	byte
		db	'scopy@',000h
; @52F7
STR_N	label	byte
		db	'N_',000h
; @52FA
STR_F	label	byte
		db	'F_',000h
; @52FD
STR_AHSHIFT	label	byte
		db	'__AHSHIFT',000h
; @5307
STR_PDEA	label	byte
		db	'pdea@',000h
; @530D
STR_PINA	label	byte
		db	'pina@',000h,000h
; @5314
EVAL_STACK_TOP	label	byte
		db	0FFh,0FFh
; @5316
EVAL_STACK_MAX	label	byte
		db	0FFh,0FFh
; @5318
EVAL_STACK_SPILLED	label	byte
		db	0FFh,0FFh
; @531A
POOLED_NODE_TOP	label	byte
		db	0FFh,0FFh
; @531C
SCRATCH_TEMP_VARIABLE	label	byte
		db	000h,000h
; @531E
JUMP_KIND_REMAP_TABLE	label	byte
		db	000h,0FFh,0FFh,0FFh,005h,004h,0FFh,0FFh,009h,008h,00Ah,00Bh
		db	0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
		db	0FFh,000h
; @5338
STR_SLXMUL	label	byte
		db	':Slxmul@',000h,000h
; @5342
STR_N_CHKSTK	label	byte
		db	'N_CHKSTK@',000h
; @534C
STR_F_CHKSTK	label	byte
		db	'F_CHKSTK@',000h
; @5356
REG_MASK_ES	label	byte
		db	000h,010h
; @5358
REG_MASK_BX_SI_DI	label	byte
		db	010h,003h
; @535A
REG_MASK_SI_DI	label	byte
		db	000h,003h
; @535C
REG_MASK_CX	label	byte
		db	'@',000h
; @535E
REG_MASK_HIGH_BYTES	label	byte
		db	0AAh,000h
; @5360
REG_MASK_LOW_BYTES	label	byte
		db	'U',000h
; @5362
SWITCH_BIT_200_FLAG	label	byte
		db	000h,000h
; @5364
LOCAL_LABEL_SERIAL	label	byte
		db	000h,000h
; @5366
LAST_LINE_MARK_ID	label	byte
		db	0FFh,0FFh
; @5368
JUMP_MNEMONIC_TEXT	label	byte
		db	000h,000h
		dw	offset DGROUP:DATA_53B0
		dw	offset DGROUP:DATA_53B4
		dw	offset DGROUP:DATA_53B7
		dw	offset DGROUP:DATA_53BA
		dw	offset DGROUP:DATA_53BD
		dw	offset DGROUP:DATA_53C0
		dw	offset DGROUP:DATA_53C4
		dw	offset DGROUP:DATA_53C8
		dw	offset DGROUP:DATA_53CC
		dw	offset DGROUP:DATA_53D0
		dw	offset DGROUP:DATA_53D3
		dw	offset DGROUP:DATA_53D7
		dw	offset DGROUP:DATA_53DA
		dw	offset DGROUP:DATA_53DE
		dw	offset DGROUP:DATA_53E1
		dw	offset DGROUP:DATA_53E5
		dw	offset DGROUP:DATA_53E8
		dw	offset DGROUP:DATA_53EC
		dw	offset DGROUP:DATA_53EF
		dw	offset DGROUP:DATA_53F3
		dw	offset DGROUP:DATA_53F9
		dw	offset DGROUP:DATA_5400
		dw	offset DGROUP:DATA_5405
; @5398
JUMP_OPCODE_BYTE	label	byte
		db	000h,0EBh,'|',07Fh,'rw~}vsturspqxyz{',0E1h,0E0h,0E3h,0E2h
; @53B0
DATA_53B0	label	byte
		db	'jmp',000h
; @53B4
DATA_53B4	label	byte
		db	'jl',000h
; @53B7
DATA_53B7	label	byte
		db	'jg',000h
; @53BA
DATA_53BA	label	byte
		db	'jb',000h
; @53BD
DATA_53BD	label	byte
		db	'ja',000h
; @53C0
DATA_53C0	label	byte
		db	'jle',000h
; @53C4
DATA_53C4	label	byte
		db	'jge',000h
; @53C8
DATA_53C8	label	byte
		db	'jbe',000h
; @53CC
DATA_53CC	label	byte
		db	'jae',000h
; @53D0
DATA_53D0	label	byte
		db	'je',000h
; @53D3
DATA_53D3	label	byte
		db	'jne',000h
; @53D7
DATA_53D7	label	byte
		db	'jc',000h
; @53DA
DATA_53DA	label	byte
		db	'jnc',000h
; @53DE
DATA_53DE	label	byte
		db	'jo',000h
; @53E1
DATA_53E1	label	byte
		db	'jno',000h
; @53E5
DATA_53E5	label	byte
		db	'js',000h
; @53E8
DATA_53E8	label	byte
		db	'jns',000h
; @53EC
DATA_53EC	label	byte
		db	'jp',000h
; @53EF
DATA_53EF	label	byte
		db	'jnp',000h
; @53F3
DATA_53F3	label	byte
		db	'loopz',000h
; @53F9
DATA_53F9	label	byte
		db	'loopnz',000h
; @5400
DATA_5400	label	byte
		db	'jcxz',000h
; @5405
DATA_5405	label	byte
		db	'loop',000h
; @540A
STR_COLON_CR_NL	label	byte
		db	':'
; @540B
STR_ASM_STATEMENT_CRLF	label	byte
		db	00Dh,00Ah,000h
; @540E
STR_DEBUG_L	label	byte
		db	009h,'?debug',009h,'L ',000h
; @5419
STR_DW	label	byte
		db	'dw',009h,000h
; @541D
STR_SHORT	label	byte
		db	'short ',000h
; @5424
STR_NEAR_PTR	label	byte
		db	'near ptr ',000h
; @542E
STR_FAR_PTR	label	byte
		db	'far ptr ',000h
; @5437
STR_TAB_AT_AT	label	byte
		db	009h,'@@',000h
; @543B
STR_JMP	label	byte
		db	009h,'jmp',009h,000h
; @5441
STR_BP	label	byte
		db	'[bp',000h,000h
; @5446
INVERTED_JUMP_KIND	label	byte
		db	001h,000h,000h,000h,007h,000h,006h,000h,009h,000h,008h,000h
		db	003h,000h,002h,000h,005h,000h,004h,000h,00Bh,000h,00Ah,000h
		db	00Dh,000h,00Ch,000h,00Fh,000h,00Eh,000h,011h,000h,010h,000h
		db	013h,000h,012h,000h
; @546E
OBJ_OUTPUT_DEFAULT_HOOKS	label	byte
		dd	OBJ_WRITE_FILE_STAMP
		dd	SET_SYMBOL_AT_CURRENT_POS
		dd	ALIGN_SEGMENT_EVEN
		dd	SELECT_SEGMENT
		dd	RESERVE_BYTES
		dd	EMIT_DATA_BYTE
		dd	EMIT_WORD_RELOC
		dd	EMIT_DWORD_RELOC
		dd	OBJ_WRITE_MODULE
		dd	ADD_LINENUM_ENTRY
		dd	ENCODE_ASM_INSTRUCTION
		dd	INSERT_OFFSET_MARK_FRAGMENT
		dd	INSERT_NODE_MARK_FRAGMENT
		dd	EMIT_LOAD_DATA_SEGMENT
		dd	OBJ_NOP
		dd	DEFINE_ASM_LABEL
		dd	ADD_ASM_JUMP
		dd	ADD_JUMP_18_NEXT_FRAGMENT_ALT
		dd	DEFINE_LABEL_ENTRY
		dd	EMIT_SWITCH_JUMP
		dd	EMIT_CS_JMP_BX_DISP
		dd	EMIT_SWITCH_TABLE_LOAD
		dd	EMIT_PUSH_RETURN_ADDRESS
		dd	EMIT_THIS_ADJUST_THUNK
; @54CE
REGISTER_ENCODING_TABLE	label	byte
		db	000h,004h,002h,006h,003h,007h,001h,005h,006h,007h,005h,004h
; @54DA
STR_OBJ_3	label	byte
		db	'.obj',000h
; @54DF
STR_DGROUP_2	label	byte
		db	'DGROUP@',000h
; @54E7
DATA_54E7	label	byte
		db	'FIARQQ',000h
; @54EE
DATA_54EE	label	byte
		db	'FJARQQ',000h
; @54F5
DATA_54F5	label	byte
		db	'FIERQQ',000h
; @54FC
DATA_54FC	label	byte
		db	'FISRQQ',000h
; @5503
DATA_5503	label	byte
		db	'FJSRQQ',000h
; @550A
DATA_550A	label	byte
		db	'FICRQQ',000h
; @5511
DATA_5511	label	byte
		db	'FJCRQQ',000h
; @5518
DATA_5518	label	byte
		db	'FIDRQQ',000h
; @551F
DATA_551F	label	byte
		db	'FIWRQQ',000h
; @5526
FIXUP_CODE_TABLE	label	byte
		db	0C4h,0C4h,000h,0C8h,000h,0C4h,084h,0CCh,0CCh,0C8h,0C8h,0C4h
		db	000h,000h,000h,000h,0C4h
; @5537
STR_TC86_BORLAND_TURBO_C_2_0	label	byte
		db	'TC86 Borland Turbo C++ 2.0',000h
; @5552
ASM_TEXT_DEFAULT_HOOKS	label	byte
		dd	EMIT_DEPENDENCY_RECORD
		dd	EMIT_PROC_OR_LABEL
		dd	ALIGN_ASM_DATA_EVEN
		dd	EMIT_PROC_BEGIN
		dd	RESERVE_DATA_BYTES
		dd	EMIT_DB_DATA
		dd	EMIT_DW_ADDRESS
		dd	EMIT_DD_ADDRESS
		dd	EMIT_ASM_TRAILER
		dd	EMIT_ASM_LINE_MARK
		dd	EMIT_ASM_INSTRUCTION
		dd	EMIT_DEBUG_B_DIRECTIVE
		dd	EMIT_DEBUG_E_DIRECTIVE
		dd	EMIT_LOAD_DATA_SEGMENT_ASM
		dd	EMIT_PROC_ENDP
		dd	DEFINE_LABEL_ASM
		dd	ADD_JUMP_ASM
		dd	ADD_JUMP_18_NEXT_FRAGMENT
		dd	EMIT_LOCAL_LABEL
		dd	EMIT_SWITCH_JUMP_ASM
		dd	EMIT_CS_JMP_BX_DISP_ASM
		dd	EMIT_SWITCH_TABLE_LOAD_ASM
		dd	EMIT_PUSH_RETURN_ADDRESS_ASM
		dd	EMIT_THIS_ADJUST_THUNK_ASM
; @55B2
ASM_OPERAND_FORMAT_MAP	label	byte
		db	000h,001h,005h,007h,009h,00Ah,00Bh
; @55B9
STR_DEBUG_B	label	byte
		db	009h,'?debug',009h,'B'
; @55C2
STR_DB_LINE_CRLF	label	byte
		db	00Dh,00Ah,000h
; @55C5
STR_DEBUG_E	label	byte
		db	009h,'?debug',009h,'E',00Dh,00Ah,000h
; @55D1
STR_MOV_BX_SP	label	byte
		db	009h,'mov',009h,'bx,sp',00Dh,00Ah,000h
; @55DE
STR_ADD_SS_BX	label	byte
		db	009h,'add',009h,'ss:[bx+',000h
; @55EB
STR_RBRACKET_COMMA	label	byte
		db	'],',000h
; @55EE
STR_JMP_FAR_PTR	label	byte
		db	00Dh,00Ah,009h,'jmp',009h,'far ptr ',000h
; @55FE
STR_JMP_NEAR_PTR	label	byte
		db	00Dh,00Ah,009h,'jmp',009h,'near ptr ',000h
; @560F
STR_ASM_2	label	byte
		db	'.asm',000h
; @5614
STR_286	label	byte
		db	009h,'.286',00Dh,00Ah,000h
; @561C
STR_287	label	byte
		db	009h,'.287',00Dh,00Ah,000h
; @5624
STR_286P	label	byte
		db	009h,'.286p',00Dh,00Ah,000h
; @562D
STR_IFNDEF_VERSION_DEBUG_MACRO_E	label	byte
		db	009h,'ifndef',009h,'??version',00Dh,00Ah,'?debug',009h,'macro'
		db	00Dh,00Ah,009h,'endm',00Dh,00Ah,'publicdll macro',009h,'name'
		db	00Dh,00Ah,009h,'public',009h,'name',00Dh,00Ah,009h,'endm',00Dh
		db	00Ah,'$comm',009h,'macro',009h,'name,dist,size,count',00Dh,00Ah
		db	009h,'comm',009h,'dist name:BYTE:count*size',00Dh,00Ah,009h
		db	'endm',00Dh,00Ah,009h,'else',00Dh,00Ah,'$comm',009h,'macro'
		db	009h,'name,dist,size,count',00Dh,00Ah,009h,'comm',009h,'dist name[size]:BYTE:count'
		db	00Dh,00Ah,009h,'endm',00Dh,00Ah,009h,'endif',00Dh,00Ah,009h
		db	'?debug',009h,'S "',000h
; @5730
STR_QUOTE_CR_NL	label	byte
		db	'"',00Dh,00Ah,000h
; @5734
STR_GROUP	label	byte
		db	009h,'group',009h,000h
; @573C
STR_ASSUME_CS_2	label	byte
		db	009h,'assume',009h,'cs:',000h
; @5748
STR_DS	label	byte
		db	',ds:',000h
; @574D
STR_D_LABEL_BYTE_D_W_LABEL_WORD	label	byte
		db	'd@',009h,'label',009h,'byte',00Dh,00Ah,'d@w',009h,'label',009h
		db	'word',00Dh,00Ah,000h
; @576D
STR_B_LABEL_BYTE_B_W_LABEL_WORD	label	byte
		db	'b@',009h,'label',009h,'byte',00Dh,00Ah,'b@w',009h,'label',009h
		db	'word',00Dh,00Ah,000h
; @578D
STR_DEBUG_C_E9	label	byte
		db	009h,'?debug',009h,'C E9',00Dh,00Ah,000h
; @579C
STR_S_LABEL_BYTE	label	byte
		db	's@',009h,'label',009h,'byte',00Dh,00Ah,000h
; @57AC
STR_DB	label	byte
		db	009h,'db',009h,000h
; @57B1
STR_EXTRN_DGROUP_WORD	label	byte
		db	009h,'extrn',009h,'DGROUP@:word',00Dh,00Ah,000h
; @57C7
STR_EXTRN_TURBOFLOAT_WORD	label	byte
		db	009h,'extrn',009h,'__turboFloat:word',00Dh,00Ah,000h
; @57E2
STR_END_CRLF_EOF	label	byte
		db	009h,'end',00Dh,00Ah,01Ah,000h
; @57EA
STR_JMP_WORD_PTR_CS	label	byte
		db	009h,'jmp',009h,'word ptr cs:@',000h
; @57FD
STR_C_6	label	byte
		db	'@C',000h
; @5800
STR_BX	label	byte
		db	'[bx]',00Dh,00Ah,000h
; @5807
STR_MOV_BX_OFFSET	label	byte
		db	009h,'mov',009h,'bx,offset ',000h
; @5817
STR_MOV	label	byte
		db	009h,'mov',009h,000h
; @581D
STR_CS_DGROUP	label	byte
		db	',cs:DGROUP@',00Dh,00Ah,000h
; @582B
STR_JMP_WORD_PTR_CS_BX	label	byte
		db	009h,'jmp',009h,'word ptr cs:[bx+',000h
; @5841
STR_MOV_CX_OFFSET_7_PUSH	label	byte
		db	009h,'mov',009h,'cx,offset $+7',00Dh,00Ah,009h,'push',009h,'cx'
		db	00Dh,00Ah,000h
; @5860
STR_PUSH_OFFSET_6	label	byte
		db	009h,'push',009h,'offset $+6',00Dh,00Ah,000h
; @5873
STR_DEBUG_C_3	label	byte
		db	009h,'?debug',009h,'C ',000h
; @587E
STR_DEBUG_C_4	label	byte
		db	'+',00Dh,00Ah,009h,'?debug',009h,'C ',000h
; @588C
STR_PUSH_CS_CALL	label	byte
		db	'push',009h,'cs',00Dh,00Ah,009h,'call',009h,000h
; @589C
STR_DB_0CBH	label	byte
		db	'db',009h,'0cbh',00Dh,00Ah,000h
; @58A6
STR_FCOMPP	label	byte
		db	'FCOMPP',00Dh,00Ah,000h
; @58AF
STR_P_ST	label	byte
		db	'P',009h,'st(',000h
; @58B5
STR_ST_0	label	byte
		db	'),st( 0 )',00Dh,00Ah,000h
; @58C1
STR_ST_0_ST	label	byte
		db	'st(0),st(',000h
; @58CB
STR_0	label	byte
		db	',0',00Dh,00Ah,000h
; @58D0
STR_AX_AX	label	byte
		db	'ax,ax,',000h
; @58D7
STR_RPAREN	label	byte
		db	')',000h
; @58D9
STR_SEG	label	byte
		db	'seg ',000h
; @58DE
STR_BYTE_2	label	byte
		db	'byte',000h
; @58E3
STR_QWORD	label	byte
		db	'qword',000h
; @58E9
STR_DWORD	label	byte
		db	'dword',000h
; @58EF
STR_TBYTE	label	byte
		db	'tbyte',000h
; @58F5
STR_FAR_5	label	byte
		db	'far',000h
; @58F9
STR_NEAR_6	label	byte
		db	'near',000h
; @58FE
STR_COMM	label	byte
		db	009h,'comm',009h,000h
; @5905
STR_FAR_3	label	byte
		db	'far ',000h
; @590A
STR_NEAR_4	label	byte
		db	'near ',000h
; @5910
STR_COMM_2	label	byte
		db	009h,'$comm',009h,000h
; @5918
STR_FAR_4	label	byte
		db	'far,',000h
; @591D
STR_NEAR_5	label	byte
		db	'near,'
; @5922
ASM_TYPE_NAME_TABLE	label	byte
		db	000h,000h
; @5924
DEBUG_STATE	label	byte
		db	0FFh,0FFh
		dw	offset DGROUP:DATA_597A,DGROUP
		dw	offset DGROUP:DATA_597A,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:DATA_5984,DGROUP
		dw	offset DGROUP:DATA_598A,DGROUP
		dw	offset DGROUP:DATA_598A,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:DATA_5984,DGROUP
		dw	offset DGROUP:DATA_5984,DGROUP
		db	000h,000h,000h,000h
		dw	offset DGROUP:STR_FAR_2,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
		dw	offset DGROUP:STR_WORD,DGROUP
STR_BYTE	equ	$-1
; @597A
DATA_597A	label	byte
		db	'byte',000h
; @597F
STR_WORD	label	byte
		db	'word',000h
; @5984
DATA_5984	label	byte
		db	'dword',000h
; @598A
DATA_598A	label	byte
		db	'qword',000h
; @5990
STR_FAR_2	label	byte
		db	'far',000h
; @5994
STR_SEGMENT	label	byte
		db	009h,'segment ',000h
; @599E
STR_PARA	label	byte
		db	'para',000h
; @59A3
STR_PUBLIC	label	byte
		db	' public ',000h
; @59AC
STR_CRLF_3	label	byte
		db	00Dh,00Ah,000h
; @59AF
STR_SEGMENT_VIRTUAL	label	byte
		db	009h,'segment',009h,'virtual',00Dh,00Ah,000h
; @59C2
STR_DB_2	label	byte
		db	009h,'db',009h,000h
; @59C7
STR_DUP_0	label	byte
		db	' dup (0)',00Dh,00Ah,000h
; @59D2
STR_DUP	label	byte
		db	' dup (?)',00Dh,00Ah,000h
; @59DD
STR_ASSUME_CS	label	byte
		db	009h,'assume',009h,'cs:',000h
; @59E9
STR_PROC	label	byte
		db	009h,'proc',009h,000h
; @59F0
STR_NEAR_2	label	byte
		db	'near',000h
; @59F5
STR_LABEL	label	byte
		db	009h,'label',009h,000h
; @59FD
STR_ENDP	label	byte
		db	009h,'endp',00Dh,00Ah,000h
; @5A05
STR_DW_2	label	byte
		db	009h,'dw',009h,000h
; @5A0A
STR_DD	label	byte
		db	009h,'dd',009h,000h
; @5A0F
STR_C_5	label	byte
		db	'@C',000h
; @5A12
STR_LABEL_WORD	label	byte
		db	009h,'label',009h,'word',00Dh,00Ah,000h
; @5A20
STR_ENDS	label	byte
		db	009h,'ends',00Dh,00Ah,000h
; @5A28
INTRINSIC_TABLE	label	byte
		dw	offset DGROUP:DATA_5A78
		db	00Ch,000h,001h,000h,005h,000h,000h,000h
		dw	offset DGROUP:DATA_5A80
		db	005h,000h,001h,000h,005h,000h,000h,000h
		dw	offset DGROUP:DATA_5A88
		db	00Ch,000h,002h,000h,005h,002h,000h,000h
		dw	offset DGROUP:DATA_5A95
		db	002h,000h,001h,000h,005h,000h,000h,000h
		dw	offset DGROUP:DATA_5AA1
		db	00Ch,000h,002h,000h,005h,006h,000h,000h
		dw	offset DGROUP:DATA_5AAE
		db	006h,000h,001h,000h,005h,000h,000h,000h
		dw	offset DGROUP:STR_EMIT
		db	00Ch,000h,0FFh,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h
; @5A78
DATA_5A78	label	byte
		db	'__int__',000h
; @5A80
DATA_5A80	label	byte
		db	'__abs__',000h
; @5A88
DATA_5A88	label	byte
		db	'__outportb__',000h
; @5A95
DATA_5A95	label	byte
		db	'__inportb__',000h
; @5AA1
DATA_5AA1	label	byte
		db	'__outportw__',000h
; @5AAE
DATA_5AAE	label	byte
		db	'__inportw__',000h
; @5ABA
STR_EMIT	label	byte
		db	'__emit__',000h,000h
; @5AC4
STR_FIARQQ	label	byte
		db	'FIARQQ',000h
; @5ACB
STR_FJARQQ	label	byte
		db	'FJARQQ',000h
; @5AD2
STR_FIERQQ	label	byte
		db	'FIERQQ',000h
; @5AD9
STR_FISRQQ	label	byte
		db	'FISRQQ',000h
; @5AE0
STR_FJSRQQ	label	byte
		db	'FJSRQQ',000h
; @5AE7
STR_FICRQQ	label	byte
		db	'FICRQQ',000h
; @5AEE
STR_FJCRQQ	label	byte
		db	'FJCRQQ',000h
; @5AF5
STR_FIDRQQ	label	byte
		db	'FIDRQQ',000h
; @5AFC
POW10_SMALL	label	byte
		db	001h,000h,000h,000h,00Ah,000h,000h,000h,'d',000h,000h,000h,0E8h
		db	003h,000h,000h,010h,027h,000h,000h,0A0h,086h,001h,000h,'@B'
		db	00Fh,000h,080h,096h,098h,000h
; @5B1C
POW10_LARGE	label	byte
		db	000h,000h,000h,000h,000h,' ',0BCh,0BEh,019h,'@',000h,000h,000h
		db	004h,0BFh,0C9h,01Bh,08Eh,'4@',09Eh,0B5h,'p+',0A8h,0ADh,0C5h
		db	09Dh,'i@',0D5h,0A6h,0CFh,0FFh,'I',01Fh,'x',0C2h,0D3h,'@',0E0h
		db	08Ch,0E9h,080h,0C9h,'G',0BAh,093h,0A8h,'A',08Eh,0DEh,0F9h,09Dh
		db	0FBh,0EBh,'~',0AAh,'QC',0C7h,091h,00Eh,0A6h,0AEh,0A0h,019h,0E3h
		db	0A3h,'F',017h,00Ch,'u',081h,086h,'uv',0C9h,'HM',0E5h,']=',0C5h
		db	'];',08Bh,09Eh,092h,'Z',09Bh,097h,' ',08Ah,002h,'R`',0C4h,'%u'
; @5B80
_CTYPE	label	byte
		db	000h
; @5B81
CTYPE_BY_CHAR	label	byte
		db	'         !!                     ',001h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,002h
		db	002h,002h,002h,002h,002h,002h,002h,002h,002h,000h,000h,000h
		db	000h,000h,000h,000h,014h,014h,014h,014h,014h,014h,004h,004h
		db	004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h
		db	004h,004h,004h,004h,004h,004h,000h,000h,000h,000h,000h,000h
		db	018h,018h,018h,018h,018h,018h,008h,008h,008h,008h,008h,008h
		db	008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h
		db	008h,008h,000h,000h,000h,000h,' ',000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h,000h
; @5C82
LONG_MIN_DIGITS	label	byte
		db	'2147483648',000h,000h
; @5C8E
SEARCH_PATH_NAME	label	byte
		db	'PA'
; END-OF-DATA (new initialised data goes here; tools/modlink.py --pad-at END tests it)
_DATA		ends
_BSS		segment word public 'DATA'
		db	'T'
		db	'H'
		db	000h
SEARCH_SEPARATOR	label	byte
		db	'/'
		db	000h
		db	000h
BSS_START	label	byte
SAVED_INT23_VECTOR	label	byte
		db	4 dup (?)
SAVED_INT18_VECTOR	label	byte
		db	4 dup (?)
SAVED_INT1B_VECTOR	label	byte
		db	4 dup (?)
CTRL_BREAK_SEEN	label	byte
		db	2 dup (?)
HEAP_SIZE_PARAS	label	byte
		db	2 dup (?)
HANDLE_RING_NODES	label	byte
		db	514 dup (?)
HEAP_HOOK_CALLSITE	label	byte
		db	4 dup (?)
SCOPE_STACK_DEPTH	label	byte
		db	16 dup (?)
DEFAULT_CALL_CONVENTION	label	byte
		db	2 dup (?)
CACHE_HEAD	label	byte
		db	2 dup (?)
FUNCTION_BODY_DEPTH	label	byte
		db	2 dup (?)
CURRENT_TOKEN	label	byte
		db	2 dup (?)
VECTOR_NEW_SYMBOL	label	byte
		db	2 dup (?)
GLOBAL_SCOPE_TAGS	label	byte
		db	2 dup (?)
INT_TYPE	label	byte
		db	2 dup (?)
SUPPRESS_WARNINGS_DEPTH	label	byte
		db	2 dup (?)
NOT_ANSI_FLAG	label	byte
		db	2 dup (?)
SETARGV_SYMBOL	label	byte
		db	2 dup (?)
SETENVP_SYMBOL	label	byte
		db	2 dup (?)
TOKEN_STREAM_POOL_SEG	label	byte
		db	8 dup (?)
BCC_TREE_FLAG	label	byte
		db	2 dup (?)
BCC_TREE_SPECIAL	label	byte
		db	2 dup (?)
CURRENT_FUNCTION_TYPE	label	byte
		db	2 dup (?)
RETURN_FORM_SEEN	label	byte
		db	1 dup (?)
STMT_SCOPE_BLOCK	label	byte
		db	1 dup (?)
BCC_TREE_LINK	label	byte
		db	1 dup (?)
STRUCT_RETURN_PARAM	label	byte
		db	1 dup (?)
CODE_UNREACHABLE	label	byte
		db	1 dup (?)
STMT_NO_GOTO_OR_LABEL_FLAG	label	byte
		db	1 dup (?)
LOOP_NEST_FACTOR	label	byte
		db	2 dup (?)
ENCLOSING_STATEMENT_KIND	label	byte
		db	2 dup (?)
STATEMENT_NEST_DEPTH	label	byte
		db	2 dup (?)
CURRENT_SWITCH	label	byte
		db	6 dup (?)
SWITCH_STATE_SCOPE	label	byte
		db	11 dup (?)
LOOP_CONTEXT	label	byte
		db	4 dup (?)
LOOP_BREAK_SCOPE	label	byte
		db	5 dup (?)
PENDING_GOTO_LIST	label	byte
		db	2 dup (?)
LABEL_LIST_HEAD	label	byte
		db	2 dup (?)
BLOCK_NEST_LEVEL	label	byte
		db	2 dup (?)
DECL_INIT_SERIAL	label	byte
		db	2 dup (?)
BCC_PARSE_BUFFER	label	byte
		db	2 dup (?)
CTOR_DTOR_MODE	label	byte
		db	2 dup (?)
CTOR_THIS_SYMBOL	label	byte
		db	2 dup (?)
CTOR_THIS_ASSIGNED	label	byte
		db	1 dup (?)
CTOR_CHECK_THIS_ASSIGN	label	byte
		db	1 dup (?)
PACKED_INIT_EXPR	label	byte
		db	2 dup (?)
FNBODY_WORD_A_SAVE	label	byte
		db	2 dup (?)
FNBODY_WORD_B_SAVE	label	byte
		db	2 dup (?)
CPP_BODY_END_LABEL	label	byte
		db	2 dup (?)
FUNCTION_DEF_POSITION	label	byte
		db	2 dup (?)
FUNC_START_CLEARED_WORD	label	byte
		db	2 dup (?)
FUNCTION_DEF_LINE	label	byte
		db	2 dup (?)
CURRENT_SOURCE_FILE	label	byte
		db	2 dup (?)
STARTUP_BODY_ACTIVE	label	byte
		db	1 dup (?)
SAW_RETURN_WITH_VALUE	label	byte
		db	1 dup (?)
SAW_RETURN_WITHOUT_VALUE	label	byte
		db	1 dup (?)
PRAGMA_NORETVAL_PENDING	label	byte
		db	1 dup (?)
LOCAL_INIT_EXPR_LIST	label	byte
		db	2 dup (?)
FAR_CHAR_POINTER_TYPE	label	byte
		db	2 dup (?)
PARAM_LIST_DEPTH	label	byte
		db	2 dup (?)
C26_SCOPE_STACK	label	byte
		db	10 dup (?)
RECORDING_TOKENS	label	byte
		db	2 dup (?)
VECTOR_VNEW_SYMBOL	label	byte
		db	2 dup (?)
TAG_BODY_POOL_SEG	label	byte
		db	8 dup (?)
INIT_RECORD_POOL_SEG	label	byte
		db	8 dup (?)
DIAG_NAME_BUFFER	label	byte
		db	2 dup (?)
BCC_DEBUG_NAME	label	byte
		db	514 dup (?)
VTABLE_ENTRY_PTR_TYPE	label	byte
		db	2 dup (?)
INT_TYPE_SIZE	label	byte
		db	2 dup (?)
PENDING_DEFINITION_LIST	label	byte
		db	2 dup (?)
PENDING_INIT_LIST	label	byte
		db	2 dup (?)
INLINE_OPTION_BLOCK_FLAG	label	byte
		db	2 dup (?)
MEMBER_PTR_CLASS_TYPE	label	byte
		db	2 dup (?)
VTABLE_CLASS_LIST	label	byte
		db	2 dup (?)
STRING_TOKEN_PENDING	label	byte
		db	2 dup (?)
VECTOR_APPLY_SYMBOL	label	byte
		db	2 dup (?)
VTABLE_NEAR_FUNC_MEMBER	label	byte
		db	2 dup (?)
VTABLE_FAR_FUNC_MEMBER	label	byte
		db	2 dup (?)
TOKEN_RECORD_STREAM	label	byte
		db	2 dup (?)
NEAR_PURE_ERROR_SYMBOL	label	byte
		db	2 dup (?)
FAR_PURE_ERROR_SYMBOL	label	byte
		db	2 dup (?)
EXPAND_INLINES_FLAG	label	byte
		db	2 dup (?)
NON_CPP_CLEARED_WORD_A	label	byte
		db	2 dup (?)
MEMBER_PTR_OFFSET_MEMBER	label	byte
		db	2 dup (?)
MEMBER_PTR_VINDEX_MEMBER	label	byte
		db	2 dup (?)
MEMBER_PTR_NEAR_FUNC_MEMBER	label	byte
		db	2 dup (?)
MEMBER_PTR_FAR_FUNC_MEMBER	label	byte
		db	2 dup (?)
TOKEN_STREAM_POS	label	byte
		db	2 dup (?)
VECTOR_DELETE_SYMBOL	label	byte
		db	2 dup (?)
VECTOR_VAPPLY_SYMBOL	label	byte
		db	2 dup (?)
TOKEN_STREAM_HANDLE	label	byte
		db	2 dup (?)
TOKEN_NAMES	label	byte
		db	10 dup (?)
CTOR_NAME	label	byte
		db	2 dup (?)
DTOR_NAME	label	byte
		db	98 dup (?)
CONVERSION_FUNC_NAME	label	byte
		db	24 dup (?)
EXPR_CURRENT2	label	byte
		db	56 dup (?)
HIDDEN_RETURN_PARAM_NAME	label	byte
		db	20 dup (?)
OPERATOR_DELETE_NAME	label	byte
		db	6 dup (?)
OPERATOR_NEW_NAME	label	byte
		db	12 dup (?)
THIS_NAME	label	byte
		db	2 dup (?)
VTABLE_PTR_NAME	label	byte
		db	32 dup (?)
MEMBER_PTR_DELTA_MEMBER	label	byte
		db	2 dup (?)
STORAGE_POOL_SEG	label	byte
		db	4 dup (?)
FNBODY_WORD_B	label	byte
		db	2 dup (?)
FNBODY_CLEARED_WORD_B	label	byte
		db	2 dup (?)
INLINE_BODY_QUEUE	label	byte
		db	2 dup (?)
INLINE_EXPANSION_DEPTH	label	byte
		db	2 dup (?)
END_OF_INPUT_SEEN	label	byte
		db	2 dup (?)
FAR_VOID_PTR_TYPE	label	byte
		db	2 dup (?)
FAR_VTABLE_ENTRY_PTR_TYPE	label	byte
		db	2 dup (?)
LONG_TYPE	label	byte
		db	2 dup (?)
VOID_TYPE	label	byte
		db	2 dup (?)
CPP_MODE	label	byte
		db	4 dup (?)
PLAIN_CHAR_TYPE	label	byte
		db	2 dup (?)
BASE_PATH_POOL_SEG	label	byte
		db	8 dup (?)
INLINE_FUNCTION_STACK	label	byte
		db	2 dup (?)
ENUMS_AS_INT_FLAG	label	byte
		db	2 dup (?)
DOUBLE_TYPE	label	byte
		db	2 dup (?)
LINKAGE_STACK_POOL_SEG	label	byte
		db	52 dup (?)
STRUCT_BODY_TYPE	label	byte
		db	2 dup (?)
ACTIVE_LIST	label	byte
		db	2 dup (?)
TYPE_SIZE_LOW	label	byte
		db	1 dup (?)
WARNING_ENABLED_TABLE	label	byte
		db	3 dup (?)
BITFIELD_ALIGN_BITS	label	byte
		db	2 dup (?)
CLASS_KEY_TOKEN	label	byte
		db	2 dup (?)
SCOPE_STATE	label	byte
		db	2 dup (?)
CURRENT_DECLARATOR_NAME	label	byte
		db	2 dup (?)
DECLARATOR_NAME_TOKEN	label	byte
		db	2 dup (?)
SPECIAL_MEMBER_KIND	label	byte
		db	2 dup (?)
STORAGE_CLASS_TOKEN	label	byte
		db	2 dup (?)
TYPE_EXPR	label	byte
		db	2 dup (?)
MEMBER_QUALIFIER_CLASS	label	byte
		db	2 dup (?)
PARSE_FLAG2	label	byte
		db	1 dup (?)
MEMBER_DECL_FRIEND	label	byte
		db	1 dup (?)
NO_THIS_PARAMETER	label	byte
		db	1 dup (?)
MEMBER_DECL_TYPE_NAMED	label	byte
		db	1 dup (?)
RETURN_TYPE_OMITTED	label	byte
		db	1 dup (?)
DISPATCH_NUMBER_GIVEN	label	byte
		db	1 dup (?)
DISPATCH_NUMBER	label	byte
		db	2 dup (?)
MEMBER_DECL_ATTRIBUTES	label	byte
		db	1 dup (?)
PARSE_CLASS	label	byte
		db	4 dup (?)
CLASS_VTABLE_SIZE	label	byte
		db	2 dup (?)
EXPR_OFFSET2	label	byte
		db	2 dup (?)
MEMBER_FLAG_200_SWITCH	label	byte
		db	1 dup (?)
C9_TYPE_GRID	label	byte
		db	90 dup (?)
UNSIGNED_INT_TYPE	label	byte
		db	14 dup (?)
EMIT_INTRINSIC_SYMBOL	label	byte
		db	2 dup (?)
DOUBLE_TYPE_SIZE	label	byte
		db	4 dup (?)
CURRENT_TOKEN_RECORD	label	byte
		db	2 dup (?)
CURRENT_TOKEN_FLAGS	label	byte
		db	1 dup (?)
CURRENT_TOKEN_FILE	label	byte
		db	2 dup (?)
CURRENT_TOKEN_LINE	label	byte
		db	2 dup (?)
CURRENT_TOKEN_LOC_WORD3	label	byte
		db	2 dup (?)
CURRENT_TOKEN_VALUE	label	byte
		db	11 dup (?)
CHAR_TYPE	label	byte
		db	2 dup (?)
CURRENT_SCOPE	label	byte
		db	2 dup (?)
TYPE_POOL	label	byte
		db	4 dup (?)
TYPE_POOL_LENGTH	label	byte
		db	2 dup (?)
TYPE_POOL_WORD6	label	byte
		db	2 dup (?)
PARSER_RESET_BYTE_A	label	byte
		db	2 dup (?)
STRING_LITERAL_SYMBOL	label	byte
		db	2 dup (?)
TEMP_ENTRY_POOL_SEG	label	byte
		db	8 dup (?)
NO_ERRORS_YET	label	byte
		db	2 dup (?)
SHORT_TYPE	label	byte
		db	2 dup (?)
LABEL_POOL_SEG	label	byte
		db	4 dup (?)
FNBODY_WORD_A	label	byte
		db	2 dup (?)
FNBODY_CLEARED_WORD_A	label	byte
		db	2 dup (?)
MAIN_SYMBOL	label	byte
		db	2 dup (?)
CONDITIONAL_ARM_DEPTH	label	byte
		db	2 dup (?)
LINKAGE_STACK	label	byte
		db	2 dup (?)
GLOBAL_SCOPE	label	byte
		db	2 dup (?)
CSYM_POOL_SEG	label	byte
		db	4 dup (?)
NODE_COUNT	label	byte
		db	4 dup (?)
TEMP_DESTRUCTOR_LIST	label	byte
		db	2 dup (?)
PARSER_INIT_MARK_A5	label	byte
		db	2 dup (?)
EXPR_TEMP2	label	byte
		db	4 dup (?)
NEW_OPERATOR_SYMBOL	label	byte
		db	2 dup (?)
TEMP_NAME_COUNTER	label	byte
		db	2 dup (?)
IMPLICIT_FUNC_TYPE	label	byte
		db	2 dup (?)
INT_FAR_FUNC_TYPE	label	byte
		db	2 dup (?)
RUNTIME_HELPER_FUNC_TYPE	label	byte
		db	2 dup (?)
GLOBAL_SCOPE_NAMES	label	byte
		db	2 dup (?)
INLINE_TOKEN_STREAM	label	byte
		db	2 dup (?)
PTRDIFF_TYPE	label	byte
		db	2 dup (?)
LIST_CELL_POOL_SEG	label	byte
		db	8 dup (?)
CONS_CELL_POOL_SEG	label	byte
		db	8 dup (?)
HIDDEN_RETURN_PARAM_RECORD	label	byte
		db	2 dup (?)
CPU_LEVEL_1_FLAG	label	byte
		db	1 dup (?)
CPU_IS_286	label	byte
		db	1 dup (?)
VTABLE_ENTRY_CLASS_TYPE	label	byte
		db	2 dup (?)
FILE_INIT_EXPR_QUEUE	label	byte
		db	2 dup (?)
EXPR_START_FLAG_MASK	label	byte
		db	2 dup (?)
CHAR_POINTER_TYPE	label	byte
		db	2 dup (?)
TYPE_LOCAL	label	byte
		db	2 dup (?)
ENUM_BODY_TREE_FLAG	label	byte
		db	2 dup (?)
PLAIN_CHAR_KIND	label	byte
		db	2 dup (?)
INT_NEAR_FUNC_TYPE	label	byte
		db	2 dup (?)
VOID_NOARG_FUNC_TYPE	label	byte
		db	2 dup (?)
BASE_LIST_SEG	label	byte
		db	8 dup (?)
SYMBOL_POOL_SEG	label	byte
		db	4 dup (?)
SCOPE_LINK10_MARK	label	byte
		db	2 dup (?)
SCOPE_LINK10_MARK_HIGH	label	byte
		db	2 dup (?)
VOID_POINTER_TYPE	label	byte
		db	2 dup (?)
IMPLICIT_FUNC_PTR_TYPE	label	byte
		db	2 dup (?)
BCC_TYPE_PTR	label	byte
		db	4 dup (?)
REPLAY_STREAM_1	label	byte
		db	2 dup (?)
REPLAY_STREAM_2	label	byte
		db	2 dup (?)
REPLAY_STREAM_3	label	byte
		db	2 dup (?)
REPLAY_STREAM_4	label	byte
		db	2 dup (?)
FORMAL_POOL_SEG	label	byte
		db	8 dup (?)
PACKED_EXPR_POOL_SEG	label	byte
		db	8 dup (?)
CURRENT_CLASS_TYPE	label	byte
		db	2 dup (?)
WARNING_SWITCH_STATE	label	byte
		db	26 dup (?)
WARN_PRO_FLAG	label	byte
		db	4 dup (?)
FOR_STEP_CLEARED_FLAG	label	byte
		db	30 dup (?)
TOKEN_MASK	label	byte
		db	2 dup (?)
IN_ERROR_RECOVERY	label	byte
		db	2 dup (?)
INT_NEAR_FUNC_PTR_TYPE	label	byte
		db	2 dup (?)
INT_FAR_FUNC_PTR_TYPE	label	byte
		db	2 dup (?)
CURRENT_LINKAGE	label	byte
		db	2 dup (?)
STORAGE_RECORD_COUNT	label	byte
		db	2 dup (?)
TYPE_DEBUG_ID_COUNTER	label	byte
		db	2 dup (?)
DEBUG_CLASS_INDEX_NEXT	label	byte
		db	2 dup (?)
DEBUG_MEMBER_COUNTER	label	byte
		db	2 dup (?)
PARSER_RESET_BYTE_B	label	byte
		db	2 dup (?)
DESTRUCTOR_ENTRY_SERIAL	label	byte
		db	2 dup (?)
DELETE_OPERATOR_SYMBOL	label	byte
		db	2 dup (?)
NON_CPP_CLEARED_WORD_B	label	byte
		db	2 dup (?)
CACHE_POOL	label	byte
		db	8 dup (?)
SIZE_T_TYPE	label	byte
		db	2 dup (?)
MEMBER_PTR_PAD_MEMBER	label	byte
		db	2 dup (?)
C13_BIND_BANK	label	byte
		db	8 dup (?)
C13_ORDER_BANK	label	byte
		db	8 dup (?)
C14_NAME_BUFFER	label	byte
		db	516 dup (?)
C28_LITERAL_PATCH	label	byte
		db	14 dup (?)
LOGICAL_LINE	label	byte
		db	2 dup (?)
FUNCTION_NAME_TEXT	label	byte
		db	2 dup (?)
DIAG_FUNC_NAME_HIGH	label	byte
		db	2 dup (?)
CURRENT_FILE_NAME	label	byte
		db	2 dup (?)
OPERAND_LIST_BASE	label	byte
		db	2 dup (?)
OPERATOR_STACK_OFFSET	label	byte
		db	2 dup (?)
OPERATOR_STACK_POOL	label	byte
		db	8 dup (?)
OPERAND_LIST_HEAD	label	byte
		db	2 dup (?)
OPERATOR_STACK_DEPTH	label	byte
		db	4 dup (?)
MEMBER_INIT_EXPR	label	byte
		db	2 dup (?)
MEMBER_CACHE_TYPES	label	byte
		db	64 dup (?)
MEMBER_CACHE_NAMES	label	byte
		db	64 dup (?)
MEMBER_CACHE_MEMBERS	label	byte
		db	64 dup (?)
COMPILE_FILE_COUNT	label	byte
		db	2 dup (?)
C_DECL_SCOPE	label	byte
		db	2 dup (?)
TOKEN_TEXT_BUFFER	label	byte
		db	4094 dup (?)
EMIT_LIMIT	label	byte
		db	1 dup (?)
TOKEN_LIMIT	label	byte
		db	1 dup (?)
NAME_BUFFER	label	byte
		db	34 dup (?)
C_FUNC_START_CLEARED_WORD	label	byte
		db	2 dup (?)
PENDING_POOL	label	byte
		db	14 dup (?)
MACRO_MODE	label	byte
		db	1 dup (?)
MODEL_FAR_CODE	label	byte
		db	1 dup (?)
MODEL_FAR_DATA	label	byte
		db	1 dup (?)
CURRENT_LINE	label	byte
		db	2 dup (?)
LEX_FILE_SERIAL_NODE	label	byte
		db	2 dup (?)
MACRO_EXPANSION_DEPTH	label	byte
		db	2 dup (?)
PRAGMA_SAVEREGS_PENDING	label	byte
		db	1 dup (?)
MACRO_MARK_FC_PENDING	label	byte
		db	1 dup (?)
MACRO_NAME_UNEXPANDED	label	byte
		db	1 dup (?)
MACRO_MARK_FE_SEEN	label	byte
		db	1 dup (?)
TYPE_POOL_LENGTH_MARK	label	byte
		db	2 dup (?)
PRAGMA_ARGSUSED_PENDING	label	byte
		db	3 dup (?)
PLAIN_INT_TYPE	label	byte
		db	2 dup (?)
STRING_CHAR_TYPE	label	byte
		db	2 dup (?)
IMPLICIT_FUNCTION_TYPE	label	byte
		db	2 dup (?)
C_HELPER_FUNC_TYPE	label	byte
		db	2 dup (?)
BACKEND_OUTPUT_BEGUN_FLAG	label	byte
		db	2 dup (?)
LOOP_BLOCK_WEIGHT	label	byte
		db	2 dup (?)
CURRENT_LOOP_CONTEXT	label	byte
		db	4 dup (?)
CURRENT_SWITCH_CONTEXT	label	byte
		db	4 dup (?)
SWITCH_CASE_LIST	label	byte
		db	2 dup (?)
SWITCH_DEFAULT_LABEL	label	byte
		db	2 dup (?)
STATEMENT_LABELED_FLAG	label	byte
		db	2 dup (?)
COMPILER_TABLES_INIT_FLAG	label	byte
		db	1 dup (?)
TOKEN_PUSHED_BACK	label	byte
		db	12 dup (?)
BITFIELD_INIT_PENDING	label	byte
		db	2 dup (?)
BITFIELD_INIT_BITS	label	byte
		db	2 dup (?)
BITFIELD_INIT_OFFSET	label	byte
		db	3 dup (?)
C_FUNC_DEF_SET_ONLY_FLAG	label	byte
		db	15 dup (?)
C_STRING_LITERAL_SYMBOL	label	byte
		db	3 dup (?)
HEAP_RESERVE_BYTES	label	byte
		db	4 dup (?)
INIT_OPTION	label	byte
		db	2 dup (?)
PRAGMA_CODESEG_SEEN	label	byte
		db	2 dup (?)
SCOPE_POOL_SEG	label	byte
		db	4 dup (?)
PARAM_SCOPE_MARK	label	byte
		db	2 dup (?)
PARAM_SCOPE_MARK_AUX	label	byte
		db	2 dup (?)
NAME_POOL_SEG	label	byte
		db	4 dup (?)
NAME_TABLE_END	label	byte
		db	4 dup (?)
HASH_CHAIN_LINK_SEG	label	byte
		db	8 dup (?)
SEARCH_LIST	label	byte
		db	4 dup (?)
STRING_POOL_SEG	label	byte
		db	4 dup (?)
STRING_POOL_USED	label	byte
		db	4 dup (?)
C31_BANKS	label	byte
		db	8 dup (?)
DATA_7856	label	byte
		db	8 dup (?)
DATA_785E	label	byte
		db	8 dup (?)
DATA_7866	label	byte
		db	8 dup (?)
DATA_786E	label	byte
		db	8 dup (?)
DATA_7876	label	byte
		db	8 dup (?)
DATA_787E	label	byte
		db	8 dup (?)
DATA_7886	label	byte
		db	8 dup (?)
ERROR_JUMP_BUFFER	label	byte
		db	14 dup (?)
POOL_HASH	label	byte
		db	8 dup (?)
MEMBER_SEGMENT	label	byte
		db	8 dup (?)
NAME_HASH_TABLE	label	byte
		db	2048 dup (?)
OBJ_RECORD_HOOK	label	byte
		db	4 dup (?)
NEW_BITFIELD_NODE_HOOK	label	byte
		db	4 dup (?)
NEW_CONST_NODE_HOOK	label	byte
		db	4 dup (?)
NEW_EXPR_NODE_HOOK	label	byte
		db	4 dup (?)
NEW_SYMBOL_NODE_HOOK	label	byte
		db	4 dup (?)
NAME_HOOK	label	byte
		db	4 dup (?)
NEW_TEMPORARY_HOOK	label	byte
		db	4 dup (?)
RESET_EXPR_POOL_HOOK	label	byte
		db	4 dup (?)
ASM_IDENTIFIER_HOOK	label	byte
		db	4 dup (?)
CALL_ARG_SPLIT_HOOK	label	byte
		db	4 dup (?)
FLAG_HOOK	label	byte
		db	4 dup (?)
EMIT_LOCALS_DEBUG_HOOK	label	byte
		db	4 dup (?)
FINISH_COMPILATION_HOOK	label	byte
		db	4 dup (?)
TYPE_ALIGNMENT_HOOK	label	byte
		db	4 dup (?)
PRAGMA_FUNC_LOOKUP_HOOK	label	byte
		db	4 dup (?)
TREE_HAS_SIDE_EFFECTS_HOOK	label	byte
		db	4 dup (?)
EVAL_EXPRESSION	label	byte
		db	4 dup (?)
TOKEN_CONVERT	label	byte
		db	4 dup (?)
IS_BASED_POINTER_HOOK	label	byte
		db	8 dup (?)
CALL_KIND_HOOK	label	byte
		db	4 dup (?)
BEGIN_BACKEND_OUTPUT_HOOK	label	byte
		db	4 dup (?)
GET_TYPE_FLAGS_ALT_HOOK	label	byte
		db	4 dup (?)
MODE_HOOK	label	byte
		db	4 dup (?)
DEBUG_HEADER_DONE_HOOK	label	byte
		db	4 dup (?)
OBJ_FRAGMENT_LABEL_HOOK	label	byte
		db	4 dup (?)
OBJ_FRAGMENT_NODE_HOOK	label	byte
		db	4 dup (?)
SYMBOL_INDEX_HOOK	label	byte
		db	4 dup (?)
ASM_TRAILER_HOOK	label	byte
		db	4 dup (?)
OBJ_WRITE_MODULE_HOOK	label	byte
		db	4 dup (?)
ASM_TOKEN_2F_HOOK	label	byte
		db	4 dup (?)
ASM_INSTRUCTION_HOOK	label	byte
		db	4 dup (?)
EXPAND_COMPOUND_ASSIGN_HOOK	label	byte
		db	4 dup (?)
EXPAND_INC_DEC_HOOK	label	byte
		db	4 dup (?)
GET_SYMBOL_SEGMENT_HOOK	label	byte
		db	4 dup (?)
FRAME_SYMBOL_MARK_HOOK	label	byte
		db	4 dup (?)
SET_SYMBOL_OFFSET_HOOK	label	byte
		db	4 dup (?)
SET_SYMBOL_SEGMENT_HOOK	label	byte
		db	4 dup (?)
REGVAR_ASSIGNED_HOOK	label	byte
		db	4 dup (?)
SET_SYMBOL_VARIABLE_HOOK	label	byte
		db	4 dup (?)
DECLARE_NAMED_GLOBAL_HOOK	label	byte
		db	4 dup (?)
GET_SYMBOL_KIND_HOOK	label	byte
		db	4 dup (?)
STRING_LITERAL_SYMBOL_HOOK	label	byte
		db	4 dup (?)
DECAY_TO_POINTER_HOOK	label	byte
		db	4 dup (?)
GET_TYPE_KIND_HOOK	label	byte
		db	4 dup (?)
SYMBOL_ELEMENT_KIND_HOOK	label	byte
		db	4 dup (?)
SIZE_OF_TYPE_CHECKED_HOOK	label	byte
		db	4 dup (?)
TYPE_HOOK	label	byte
		db	4 dup (?)
GET_SYMBOL_VARIABLE_HOOK	label	byte
		db	4 dup (?)
DEFINE_LIST_TAIL	label	byte
		db	4 dup (?)
DEFINE_LIST_HEAD	label	byte
		db	4 dup (?)
INCLUDE_DIR_LIST	label	byte
		db	4 dup (?)
CONTEXT_PTR	label	byte
		db	2 dup (?)
DECLARATOR_NODE_POOL_SEG	label	byte
		db	8 dup (?)
EXPR_POOL_SEG	label	byte
		db	4 dup (?)
EXPR_POOL_UNIT	label	byte
		db	2 dup (?)
EXPR_POOL_USED	label	byte
		db	2 dup (?)
SRCFILE_POOL_SEG	label	byte
		db	4 dup (?)
SEGMENT_POOL_USED	label	byte
		db	2 dup (?)
SEGMENT_POOL_FREE_LIST	label	byte
		db	2 dup (?)
C_PARAM_POOL_SEG	label	byte
		db	8 dup (?)
SAVED_OPTION_BLOCK	label	byte
		db	144 dup (?)
SOURCE_FILE_LIST	label	byte
		db	2 dup (?)
CURRENT_BANK_INDEX	label	byte
		db	2 dup (?)
DIRECTIVE_MODE	label	byte
		db	2 dup (?)
LINE_RECORD	label	byte
		db	6 dup (?)
TOKEN_POSITION	label	byte
		db	4 dup (?)
POOL_A	label	byte
		db	2 dup (?)
POOL_A_STEP	label	byte
		db	2 dup (?)
POOL_A_UNIT	label	byte
		db	1 dup (?)
LINKER_Y_SWITCH_FLAGS	label	byte
		db	1 dup (?)
POOL_A_USED	label	byte
		db	2 dup (?)
TOKEN_POOL	label	byte
		db	2 dup (?)
TOKEN_POOL_STEP	label	byte
		db	2 dup (?)
TOKEN_POOL_UNIT	label	byte
		db	2 dup (?)
TOKEN_POOL_USED	label	byte
		db	6 dup (?)
CHAR_CLASS_PTR	label	byte
		db	2 dup (?)
TOKEN_PTR	label	byte
		db	2 dup (?)
PENDING_STRING_TEXT	label	byte
		db	2 dup (?)
LINE_POOL	label	byte
		db	2 dup (?)
LINE_POOL_STEP	label	byte
		db	2 dup (?)
CONDITION_MARK	label	byte
		db	1 dup (?)
LINKER_T_SWITCH_FLAGS	label	byte
		db	1 dup (?)
CONDITION_STATE	label	byte
		db	2 dup (?)
TOKEN_TYPE	label	byte
		db	2 dup (?)
TOKEN_AUX	label	byte
		db	1 dup (?)
TOKEN_FILE_NODE	label	byte
		db	2 dup (?)
TOKEN_LINE	label	byte
		db	2 dup (?)
TOKEN_LENGTH	label	byte
		db	2 dup (?)
TOKEN_CONST_VALUE	label	byte
		db	11 dup (?)
CONTEXT_SEG	label	byte
		db	2 dup (?)
CONTEXT_SEG_STEP	label	byte
		db	2 dup (?)
CONTEXT_SEG_UNIT	label	byte
		db	2 dup (?)
CONTEXT_SEG_USED	label	byte
		db	2 dup (?)
INPUT_BUFFER	label	byte
		db	2 dup (?)
INPUT_ACTIVE	label	byte
		db	2 dup (?)
FREE_MACRO_CONTEXT_LIST	label	byte
		db	2 dup (?)
INPUT_UNGET_FLAG	label	byte
		db	2 dup (?)
CURRENT_FILE_CONTEXT	label	byte
		db	2 dup (?)
LEXER_INIT_CLEARED_WORD	label	byte
		db	2 dup (?)
INPUT_UNGET_CHAR	label	byte
		db	2 dup (?)
STRING_DATA	label	byte
		db	2 dup (?)
INPUT_LIMIT	label	byte
		db	2 dup (?)
INPUT_FILE_POS	label	byte
		db	4 dup (?)
INPUT_INDEX	label	byte
		db	2 dup (?)
ECHO_NEXT_LINE	label	byte
		db	2 dup (?)
CURRENT_SYMBOL	label	byte
		db	2 dup (?)
BREAK_POLL_COUNTER	label	byte
		db	2 dup (?)
CURRENT_TIME	label	byte
		db	4 dup (?)
COMPILE_FAILED	label	byte
		db	2 dup (?)
CURRENT_DATE	label	byte
		db	4 dup (?)
C51_Y_LINK_OPTIONS	label	byte
		db	26 dup (?)
C51_T_LINK_OPTIONS	label	byte
		db	22 dup (?)
DATA_82D4	label	byte
		db	4 dup (?)
TOKEN_TEXT	label	byte
		db	4 dup (?)
BSS_SEGMENT_NAME	label	byte
		db	2 dup (?)
C52_FAR_SERIAL	label	byte
		db	4 dup (?)
CODE_SEGMENT_NAME	label	byte
		db	2 dup (?)
BSS_GROUP_NAME	label	byte
		db	2 dup (?)
DATA_BSS_GROUPS_DIFFER	label	byte
		db	2 dup (?)
SYMBOL_A1	label	byte
		db	2 dup (?)
CODE_GROUP_NAME	label	byte
		db	2 dup (?)
BSS_SEGMENT_SEPARATE	label	byte
		db	2 dup (?)
BSS_CLASS_NAME	label	byte
		db	2 dup (?)
SYMBOL_A2	label	byte
		db	2 dup (?)
CODE_CLASS_NAME	label	byte
		db	2 dup (?)
C52_MODULE_NAME	label	byte
		db	10 dup (?)
PSEUDO_REG_BP_SYMBOL	label	byte
		db	2 dup (?)
PSEUDO_REG_SP_SYMBOL	label	byte
		db	2 dup (?)
DATA_SEGMENT_NAME	label	byte
		db	2 dup (?)
SYMBOL_B1	label	byte
		db	2 dup (?)
DATA_GROUP_NAME	label	byte
		db	2 dup (?)
BACKEND_MODE3_TYPE	label	byte
		db	2 dup (?)
SYMBOL_B2	label	byte
		db	2 dup (?)
DATA_CLASS_NAME	label	byte
		db	2 dup (?)
MALLOC_POOL_LENGTH_MARK	label	byte
		db	2 dup (?)
MALLOC_POOL_SEG	label	byte
		db	4 dup (?)
MALLOC_POOL_LENGTH	label	byte
		db	2 dup (?)
MALLOC_POOL_WORD6	label	byte
		db	2 dup (?)
BCC_LINE_OFFSET	label	byte
		db	2 dup (?)
BCC_LINE_SEGMENT	label	byte
		db	2 dup (?)
PENDING_EXTERN_RECORD_TYPE	label	byte
		db	2 dup (?)
ASM_MNEMONIC_FLAGS	label	byte
		db	1 dup (?)
ASM_STATEMENT_BUFFER	label	byte
		db	513 dup (?)
ASM_STATEMENT_CURSOR	label	byte
		db	4 dup (?)
PREAMBLE_POOL_SEG	label	byte
		db	2 dup (?)
PREAMBLE_POOL_CAPACITY	label	byte
		db	2 dup (?)
PREAMBLE_POOL_USED	label	byte
		db	2 dup (?)
PREAMBLE_POOL_FREE_LIST	label	byte
		db	2 dup (?)
PCH_DIAGNOSTIC_ISSUED	label	byte
		db	2 dup (?)
PCH_DEPENDENCY_TAIL	label	byte
		db	2 dup (?)
PREAMBLE_PUSHBACK_BUFFER	label	byte
		db	128 dup (?)
PCH_DEPENDENCY_HEAD	label	byte
		db	2 dup (?)
PREAMBLE_REMAINDER_NODE	label	byte
		db	2 dup (?)
PREAMBLE_IF_DEPTH	label	byte
		db	2 dup (?)
MACRO_SNAPSHOT_POOL_SEG	label	byte
		db	2 dup (?)
MACRO_SNAPSHOT_POOL_CAPACITY	label	byte
		db	2 dup (?)
MACRO_SNAPSHOT_POOL_USED	label	byte
		db	2 dup (?)
MACRO_SNAPSHOT_POOL_FREE	label	byte
		db	2 dup (?)
PREAMBLE_MISMATCH_NODE	label	byte
		db	2 dup (?)
PCH_INDEX_POOL_SEG	label	byte
		db	2 dup (?)
PCH_INDEX_POOL_CAPACITY	label	byte
		db	2 dup (?)
PCH_INDEX_POOL_USED	label	byte
		db	2 dup (?)
PCH_INDEX_POOL_FREE	label	byte
		db	2 dup (?)
PCH_FILE_MAGIC	label	byte
		db	2 dup (?)
PCH_HEADER_VERSION	label	byte
		db	2 dup (?)
PCH_INDEX_FILE_OFFSET	label	byte
		db	4 dup (?)
PCH_INDEX_FILE_SIZE	label	byte
		db	2 dup (?)
PCH_FILE_HANDLE	label	byte
		db	2 dup (?)
PREAMBLE_REPLAY_NODE	label	byte
		db	2 dup (?)
PREAMBLE_LIST_TAIL	label	byte
		db	2 dup (?)
PCH_SAVE_PENDING	label	byte
		db	2 dup (?)
PREAMBLE_LIST_HEAD	label	byte
		db	2 dup (?)
PCH_DEPENDENCY_POOL_SEG	label	byte
		db	2 dup (?)
PCH_DEPENDENCY_POOL_CAPACITY	label	byte
		db	2 dup (?)
PCH_DEPENDENCY_POOL_USED	label	byte
		db	2 dup (?)
PCH_DEPENDENCY_POOL_FREE	label	byte
		db	2 dup (?)
SAVED_OPTION_POOL_SEG	label	byte
		db	2 dup (?)
SAVED_OPTION_POOL_CAPACITY	label	byte
		db	2 dup (?)
SAVED_OPTION_POOL_USED	label	byte
		db	2 dup (?)
SAVED_OPTION_POOL_FREE	label	byte
		db	2 dup (?)
PCH_COLLECT_DEPENDENCIES	label	byte
		db	2 dup (?)
CALL_ARGUMENT_NUMBER	label	byte
		db	2 dup (?)
CALL_FUNCTION_EXPR	label	byte
		db	2 dup (?)
C_UNNAMED_GLOBAL_LIST	label	byte
		db	2 dup (?)
C_GLOBAL_SCOPE	label	byte
		db	2 dup (?)
C_FUNCTION_NAME_BUFFER	label	byte
		db	34 dup (?)
C_FUNCTION_SCOPE	label	byte
		db	2 dup (?)
C_OLD_STYLE_PARAM_LIST	label	byte
		db	2 dup (?)
PARAM_NAME	label	byte
		db	2 dup (?)
C_DECL_CALL_CONVENTION	label	byte
		db	2 dup (?)
C_DECL_DISTANCE	label	byte
		db	2 dup (?)
C_DECLARATOR_NAME	label	byte
		db	2 dup (?)
C_DECL_STORAGE_CLASS	label	byte
		db	2 dup (?)
C_DECL_SOURCE_LINE	label	byte
		db	2 dup (?)
C_DECL_START_POSITION	label	byte
		db	2 dup (?)
C_DECL_START_POSITION_HIGH	label	byte
		db	2 dup (?)
C_CURRENT_FUNCTION_SYMBOL	label	byte
		db	2 dup (?)
C_DECL_SYMBOL_FLAGS	label	byte
		db	2 dup (?)
C_DECL_SOURCE_FILE	label	byte
		db	2 dup (?)
DECLARATOR_NAME_FILE	label	byte
		db	2 dup (?)
C_DECL_MODIFIERS	label	byte
		db	4 dup (?)
DECLARATOR_NAME	label	byte
		db	2 dup (?)
PARAM_LIST_KIND	label	byte
		db	2 dup (?)
DECLARATOR_NAME_LINE	label	byte
		db	2 dup (?)
OUTPUT_BUFFER_FILL	label	byte
		db	2 dup (?)
CURRENT_OWNER_TAG	label	byte
		db	2 dup (?)
OUTPUT_BUFFER_SEG	label	byte
		db	2 dup (?)
ERROR_COUNT	label	byte
		db	2 dup (?)
ASM_OUTPUT_PATH	label	byte
		db	2 dup (?)
BACKEND_OWNER_TAG	label	byte
		db	2 dup (?)
BACKEND_SPARE_POOL_SEG	label	byte
		db	8 dup (?)
BSS_SEGMENT_ID	label	byte
		db	2 dup (?)
FLOW_BLOCK_POOL_SEG	label	byte
		db	4 dup (?)
CODE_NODE_POOL_UNIT	label	byte
		db	2 dup (?)
CODE_NODE_POOL_USED	label	byte
		db	10 dup (?)
CODE_SEGMENT_ID	label	byte
		db	2 dup (?)
REG_HISTORY_POOL_SEG	label	byte
		db	4 dup (?)
HISTORY_END_OFFSET	label	byte
		db	2 dup (?)
REG_HISTORY_POOL_FREE_LIST	label	byte
		db	2 dup (?)
VARIABLE_TABLE_SEG	label	byte
		db	4 dup (?)
VARIABLE_TABLE_END	label	byte
		db	2 dup (?)
VARIABLE_TABLE_FREE_LIST	label	byte
		db	10 dup (?)
DEFAULT_CODE_SEGMENT_ID	label	byte
		db	2 dup (?)
CODE_OP_POOL_SEG	label	byte
		db	4 dup (?)
CODE_OP_POOL_UNIT	label	byte
		db	2 dup (?)
CODE_OP_POOL_USED	label	byte
		db	2 dup (?)
CASE_ENTRY_POOL_SEG	label	byte
		db	4 dup (?)
CASE_ENTRY_POOL_UNIT	label	byte
		db	2 dup (?)
CASE_ENTRY_POOL_USED	label	byte
		db	2 dup (?)
POOL_E	label	byte
		db	2 dup (?)
POOL_E_STEP	label	byte
		db	2 dup (?)
POOL_E_UNIT	label	byte
		db	2 dup (?)
POOL_E_USED	label	byte
		db	2 dup (?)
CODE_OPERAND_POOL_SEG	label	byte
		db	4 dup (?)
CODE_OPERAND_POOL_UNIT	label	byte
		db	2 dup (?)
CODE_OPERAND_POOL_USED	label	byte
		db	10 dup (?)
POOL_F	label	byte
		db	2 dup (?)
POOL_F_STEP	label	byte
		db	2 dup (?)
POOL_F_UNIT	label	byte
		db	2 dup (?)
POOL_F_USED	label	byte
		db	2 dup (?)
DATA_BYTE_POOL_SEG	label	byte
		db	4 dup (?)
DATA_BYTE_POOL_LENGTH	label	byte
		db	2 dup (?)
DATA_BYTE_POOL_WORD6	label	byte
		db	2 dup (?)
LINE_NUMBER_POOL_SEG	label	byte
		db	4 dup (?)
LINE_NUMBER_POOL_USED	label	byte
		db	4 dup (?)
LIVE_VALUE_POOL_SEG	label	byte
		db	4 dup (?)
LIVE_VALUE_POOL_USED	label	byte
		db	2 dup (?)
LIVE_VALUE_POOL_FREE_LIST	label	byte
		db	2 dup (?)
DATA_SEGMENT_ID	label	byte
		db	2 dup (?)
NODE_SERIAL_COUNTER	label	byte
		db	2 dup (?)
DEBUG_TYPE_COUNTER	label	byte
		db	2 dup (?)
SELECTED_SEGMENT_ID	label	byte
		db	2 dup (?)
SEGMENT_COUNT	label	byte
		db	2 dup (?)
CODE_OUTPUT_FLAGS	label	byte
		db	2 dup (?)
CODEGEN_FUNCTION_SYMBOL	label	byte
		db	2 dup (?)
FUNCTION_CODE_SEGMENT	label	byte
		db	2 dup (?)
FUNCTION_SOURCE_FILE	label	byte
		db	2 dup (?)
FUNCTION_START_LINE	label	byte
		db	2 dup (?)
FUNCTION_SOURCE_POS_LOW	label	byte
		db	2 dup (?)
FUNCTION_SOURCE_POS_HIGH	label	byte
		db	2 dup (?)
CODE_BLOCK_LIST_HEAD	label	byte
		db	2 dup (?)
CODE_BLOCK_LIST_TAIL	label	byte
		db	2 dup (?)
FUNCTION_RETURN_LABEL	label	byte
		db	2 dup (?)
FRAME_LOCALS_SIZE	label	byte
		db	2 dup (?)
CODEGEN_PARAMS_SIZE	label	byte
		db	2 dup (?)
FRAME_HEADER_SIZE	label	byte
		db	2 dup (?)
FUNCTION_OUTER_SCOPE_BLOCK	label	byte
		db	2 dup (?)
CODEGEN_RETURN_TYPE	label	byte
		db	2 dup (?)
CODEGEN_PARAM_LIST	label	byte
		db	2 dup (?)
CODEGEN_CALL_CONV	label	byte
		db	1 dup (?)
CODEGEN_FUNCTION_FLAGS	label	byte
		db	2 dup (?)
FUNCTION_SERIAL	label	byte
		db	2 dup (?)
CURRENT_CODE_BLOCK	label	byte
		db	2 dup (?)
CODE_OP_NEXT_INDEX	label	byte
		db	2 dup (?)
CODEGEN_USED_REG_MASK	label	byte
		db	2 dup (?)
FUNCTION_CLAIMED_REG_MASK	label	byte
		db	2 dup (?)
SAVED_REG_MASK	label	byte
		db	4 dup (?)
LIVE_VALUE_SPILL_END	label	byte
		db	2 dup (?)
LIVE_VALUE_END	label	byte
		db	2 dup (?)
CURRENT_SCOPE_BLOCK	label	byte
		db	15 dup (?)
JUMP_OPT_KEEP_EMPTY_BLOCKS	label	byte
		db	2 dup (?)
JUMP_OPT_CHANGED	label	byte
		db	2 dup (?)
RESOLVED_REQUEST_COUNT	label	byte
		db	2 dup (?)
CURRENT_INSN_INDEX	label	byte
		db	2 dup (?)
BLOCK_CLAIMED_REG_MASK	label	byte
		db	2 dup (?)
ALLOCATABLE_REGISTER_MASK	label	byte
		db	2 dup (?)
REGALLOC_SCOPE_NODE	label	byte
		db	2 dup (?)
PENDING_REQUESTS	label	byte
		db	48 dup (?)
PENDING_REGISTER_MASK	label	byte
		db	2 dup (?)
BLOCK_FREE_REGISTER_MASK	label	byte
		db	2 dup (?)
PENDING_RESULT_REGISTER	label	byte
		db	2 dup (?)
PENDING_REQUEST_COUNT	label	byte
		db	2 dup (?)
SPILLED_REQUEST_COUNT	label	byte
		db	2 dup (?)
CROSS_JUMP_CHANGED	label	byte
		db	2 dup (?)
PEEPHOLE_STORE_STAMP	label	byte
		db	98 dup (?)
PEEPHOLE_MEMORY_STORE_STAMP	label	byte
		db	2 dup (?)
CODEGEN_UNUSED_POOL_NINE	label	byte
		db	8 dup (?)
EMIT_DEPENDENCY_HOOK	label	byte
		db	4 dup (?)
DEFINE_SYMBOL_HERE_HOOK	label	byte
		db	4 dup (?)
ALIGN_OUTPUT_HOOK	label	byte
		db	4 dup (?)
STREAM_HOOK	label	byte
		db	4 dup (?)
RESERVE_BYTES_HOOK	label	byte
		db	4 dup (?)
BYTE_HOOK	label	byte
		db	4 dup (?)
WORD_HOOK	label	byte
		db	4 dup (?)
ALT_HOOK	label	byte
		db	4 dup (?)
FINISH_OUTPUT_HOOK	label	byte
		db	4 dup (?)
LINE_NUMBER_HOOK	label	byte
		db	4 dup (?)
EMIT_INSTRUCTION_HOOK	label	byte
		db	4 dup (?)
SCOPE_ENTER_DEBUG_HOOK	label	byte
		db	4 dup (?)
SCOPE_EXIT_DEBUG_HOOK	label	byte
		db	4 dup (?)
EMIT_LOAD_DGROUP_HOOK	label	byte
		db	4 dup (?)
EPILOGUE_DONE_HOOK	label	byte
		db	4 dup (?)
BLOCK_START_HOOK	label	byte
		db	4 dup (?)
BLOCK_JUMP_HOOK	label	byte
		db	4 dup (?)
EMIT_LABEL_WORD_HOOK	label	byte
		db	4 dup (?)
DEFINE_NODE_LABEL_HOOK	label	byte
		db	4 dup (?)
RETURN_BLOCK_WORD20_HOOK	label	byte
		db	4 dup (?)
EMIT_OP_AF_HOOK	label	byte
		db	4 dup (?)
EMIT_OP_B0_HOOK	label	byte
		db	4 dup (?)
EMIT_OP_76_HOOK	label	byte
		db	4 dup (?)
EMIT_THIS_ADJUST_THUNK_HOOK	label	byte
		db	4 dup (?)
CODEGEN_UNUSED_POOL_ONE	label	byte
		db	8 dup (?)
CODEGEN_UNUSED_POOL_TWO	label	byte
		db	8 dup (?)
CODE_BYTE_POOL_SEG	label	byte
		db	2 dup (?)
OUTPUT_BUFFER_LIMIT	label	byte
		db	2 dup (?)
OUTPUT_BUFFER_POS	label	byte
		db	2 dup (?)
CODE_BYTE_POOL_FREE_LIST	label	byte
		db	2 dup (?)
CODE_FRAGMENT_POOL_SEG	label	byte
		db	4 dup (?)
CODE_FRAGMENT_POOL_USED	label	byte
		db	2 dup (?)
CODE_FRAGMENT_POOL_FREE_LIST	label	byte
		db	2 dup (?)
QUEUED_WORD_POOL_SEG	label	byte
		db	4 dup (?)
QUEUED_WORD_POOL_USED	label	byte
		db	2 dup (?)
QUEUED_WORD_POOL_FREE	label	byte
		db	2 dup (?)
CODEGEN_UNUSED_POOL_EIGHT	label	byte
		db	8 dup (?)
SEG_DATA_BLOCK_POOL_SEG	label	byte
		db	8 dup (?)
CODEGEN_UNUSED_POOL_FIVE	label	byte
		db	8 dup (?)
CODEGEN_UNUSED_POOL_THREE	label	byte
		db	8 dup (?)
CODEGEN_UNUSED_POOL_SIX	label	byte
		db	8 dup (?)
CODEGEN_UNUSED_POOL_SEVEN	label	byte
		db	8 dup (?)
RELOCATION_POOL_SEG	label	byte
		db	8 dup (?)
CODEGEN_UNUSED_POOL_FOUR	label	byte
		db	8 dup (?)
SEGDEF_POOL_SEG	label	byte
		db	4 dup (?)
FAR_SEGMENT_COUNT	label	byte
		db	6 dup (?)
SEGMENT_LIST_HEAD	label	byte
		db	2 dup (?)
SEGMENT_LIST_TAIL	label	byte
		db	2 dup (?)
SELECTED_SEGDEF_ENTRY	label	byte
		db	2 dup (?)
SELECTED_SEGDEF_COPY	label	byte
		db	2 dup (?)
GROUP_LIST_HEAD	label	byte
		db	2 dup (?)
GROUP_LIST_TAIL	label	byte
		db	2 dup (?)
GROUP_COUNT	label	byte
		db	2 dup (?)
ASM_OUTPUT_FLAGS	label	byte
		db	2 dup (?)
PARAM_FRAME_BASE	label	byte
		db	2 dup (?)
INSN_57_PENDING	label	byte
		db	1 dup (?)
INSN_9C_DEFERRED	label	byte
		db	4 dup (?)
STACK_BALANCE_NEEDED	label	byte
		db	1 dup (?)
FRAME_PUSHED_REG_BYTES	label	byte
		db	4 dup (?)
CALL_ARG_SPLIT_COUNT	label	byte
		db	2 dup (?)
EVAL_STACK_VALUES	label	byte
		db	2 dup (?)
EVAL_STACK_TEMP_NODES	label	byte
		db	398 dup (?)
POOLED_NODE_STACK	label	byte
		db	200 dup (?)
SWAP_OPCODE_FLAG	label	byte
		db	2 dup (?)
OUTER_SCOPE_EXIT_VALUE	label	byte
		db	2 dup (?)
REGISTER_HISTORY_CURSOR	label	byte
		db	2 dup (?)
SWITCH_TABLE_LIST	label	byte
		db	2 dup (?)
CURRENT_CODE_FRAGMENT	label	byte
		db	2 dup (?)
INSN_9C_DEFERRED_OPERAND	label	byte
		db	10 dup (?)
FIRST_ASM_OPERAND	label	byte
		db	2 dup (?)
FIRST_OPERAND_SEG_REG	label	byte
		db	1 dup (?)
FIRST_OPERAND_INDEX_REG	label	byte
		db	1 dup (?)
FIRST_OPERAND_REG	label	byte
		db	1 dup (?)
FIRST_OPERAND_VALUE	label	byte
		db	4 dup (?)
SECOND_ASM_OPERAND	label	byte
		db	2 dup (?)
SECOND_OPERAND_SEG_REG	label	byte
		db	1 dup (?)
SECOND_OPERAND_INDEX_REG	label	byte
		db	1 dup (?)
SECOND_OPERAND_REG	label	byte
		db	1 dup (?)
SECOND_OPERAND_VALUE	label	byte
		db	14 dup (?)
OBJ_RECORD_CURSOR	label	byte
		db	2 dup (?)
OBJ_RECORD_CHECKSUM	label	byte
		db	2 dup (?)
LINE_MARK_LAST_FILE	label	byte
		db	2 dup (?)
SAVE_SS	label	byte
		db	2 dup (?)
SAVE_SP	label	byte
		db	2 dup (?)
ENV_BUFFER	label	byte
		db	128 dup (?)
SEARCH_BUFFER	label	byte
		db	114 dup (?)
_BSS		ends
_BSSEND		segment word public 'DATA'
		db	14 dup (0)
BSS_CLEAR_END	label	byte
		db	2 dup (0)
_BSSEND		ends
_STACK		segment word stack 'STACK'
STACK_BOTTOM	label	byte
		db	4500 dup (?)
_STACK		ends
		end

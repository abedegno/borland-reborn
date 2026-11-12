/* CPP.EXE: the BCC reconstruction's shared headers, with the BCC.EXE data addresses dropped
   from the comments (CPP.EXE's data layout differs; symbols.tsv has CPP's addresses). */
/* DATA.H: the compiler's global data in DGROUP, one declaration per item, in
   address order.  The storage is the initialized data segment
   (linkgroups/CB0B4.ASM); the names are absolute DS equates (symbols.tsv).
   Items that sources declare in different ways (different views of the same
   bytes) are declared in each source as it compiled, not here.
   Generated during the readability pass. */
#ifndef DATA_H
#define DATA_H
extern unsigned int HEAP_START_SEG;
extern unsigned int HEAP_END_SEG;
extern unsigned int PROGRAM_PSP;
extern unsigned char DOS_HOST_MODE;
extern unsigned int EXTENDER_HEAP_TOP;
extern unsigned int EXTENDER_BASE;
extern char STR_BORLAND_C_VERSION_2_0[];
extern char STR_AVAILABLE_MEMORY[];
extern char STR_SYNTAX_IS_BCC_OPTIONS[];
extern char STR_ASM[];
extern char STR_OBJ[];
extern unsigned int SWAP_FILE_PREPARED;
extern unsigned char HEAP_DEFAULT_OWNER_TAG;
extern unsigned int HEAP_SAVED_TOP_KEY;
extern unsigned char HANDLE_RING_NEWEST;
extern unsigned char HANDLE_RING_TAG_CURSOR;
extern unsigned char HANDLE_RING_UNTAG_CURSOR;
extern unsigned int HEAP_DESCRIPTOR_SEGMENTS[];
extern unsigned int OWNER_TAG_BITMAP[16];
extern unsigned char HEAP_CPU_TYPE;
extern char near POINTER_TEXT[];
extern char near STR_STATIC_VARIABLES[];
extern char near STR_FRIEND[];
extern char near STR_VIRTUAL[];
extern char near STR_GOTO[];
extern char near STR_IF[];
extern char near STR_SWITCH[];
extern char near STR_WHILE[];
extern char near STR_DO_WHILE[];
extern char near STR_FOR[];
extern unsigned char near EXPR_OP_FLAGS[];
extern unsigned int near TYPE_FLAGS[];
extern unsigned char WARNING_SWITCH_TABLE[];
extern unsigned char EXPR_FLAGS[];
extern unsigned char near C9_TYPE_SIZES[];
extern unsigned char near C18_OPERATOR_TOKENS[];
extern char near STR___EMIT__[];
extern char near STR_S_2[];
extern char near STR_MAIN_2[];
extern char near STR__SETARGV__[];
extern char near STR___SETARGV__[];
extern char near STR__SETENVP__[];
extern char near STR___SETENVP__[];
extern char near STR_NEW[];
extern char near STR__VECTOR_NEW_[];
extern char near STR__VECTOR_VNEW_[];
extern char near STR_DELETE[];
extern char near STR__VECTOR_DELETE_[];
extern char near STR__VECTOR_APPLY_[];
extern char near STR__VECTOR_VAPPLY_[];
extern char near STR__FPURE_ERROR_[];
extern char near STR__NPURE_ERROR_[];
extern char near STR_FAR_FUNC[];
extern char near STR_NEAR_FUNC[];
extern char near STR_DELTA[];
extern char near STR_VINDEX[];
extern char near STR_OFFSET[];
extern char near STR_PAD[];
extern char near STR_EMPTY_2[];
extern char near STR__STCON_[];
extern char near STR__STDES_[];
extern char near STR_VSF[];
extern char near STR_VSN[];
extern char near STR_QUEST[];
extern char near STR_ADD[];
extern char near STR_SUB[];
extern char near STR_MUL[];
extern char near STR_DIV[];
extern char near STR_MOD[];
extern char near STR_X[];
extern char near STR_OR[];
extern char near STR_AND[];
extern char near STR_CMP[];
extern char near STR_ASG[];
extern char near STR_LSS[];
extern char near STR_GTR[];
extern char near STR_RPLU[];
extern char near STR_RMIN[];
extern char near STR_RMUL[];
extern char near STR_RDIV[];
extern char near STR_RMOD[];
extern char near STR_RXOR[];
extern char near STR_RAND[];
extern char near STR_ROR[];
extern char near STR_LSH[];
extern char near STR_RSH[];
extern char near STR_RLSH[];
extern char near STR_RRSH[];
extern char near STR_EQL[];
extern char near STR_NEQ[];
extern char near STR_LEQ[];
extern char near STR_GEQ[];
extern char near STR_LAND[];
extern char near STR_LOR[];
extern char near STR_CALL[];
extern char near STR_SUBS[];
extern char near STR_NEW_2[];
extern char near STR_DELE[];
extern char near STR_AROW[];
extern char near STR_COMA[];
extern char near STR_ARWM[];
extern char near STR_IND[];
extern char near STR_ADR[];
extern char near STR_NOT[];
extern char near STR_INC[];
extern char near STR_DEC[];
extern char near STR_CTR[];
extern char near STR_DTR[];
extern char near STR_ZYXWVUTSRQPONMLKJIHGFEDC[];
extern char near STR_LOCAL_DESTRUCTORS[];
extern char near STR_ARRAY_BOUNDS[];
extern char near STR_A_MEMBER_FUNCTION[];
extern char near STR_FRIEND_2[];
extern char near STR_VIRTUAL_2[];
extern char near STR_OPERATOR[];
extern char near STR_OPERATOR_2[];
extern char near STR_REFERENCE[];
extern char near C25_EMPTY_NAME[];
extern char near C27_STATIC_TEXT[];
extern char near STR_COLON[];
extern char near STR_ERRORS_IN_COMPILE[];
extern char STR_FATAL[];
extern char STR_IN_FUNCTION[];
extern char STR_WARNING[];
extern char STR_ERROR[];
extern char STR_FMT_SPACE_STRING[];
extern char STR_FMT_SPACE_LONG[];
extern char STR_COLON_SPACE[];
extern char STR_DIAG_NEWLINE[];
extern char near STR_VOID[];
extern char near STR_DOT_DOT_DOT[];
extern char near STR_CONST[];
extern char near STR_VOLATILE[];
extern char near STR_ENUM[];
extern char near STR_ENUM_2[];
extern char near STR_FAR[];
extern char near STR_NEAR[];
extern char near STR_COLON_COLON[];
extern char near STR_PASCAL[];
extern char near STR_STAR_RPAREN[];
extern char near STR_CONST_2[];
extern char near STR_VOLATILE_2[];
extern char near STR_STRUCT[];
extern char near STR_UNION[];
extern char near STR_OPERATOR_3[];
extern char near STR_LPAREN_RPAREN[];
extern char near STR_CONST_3[];
extern char near STR_VOLATILE_3[];
extern char near STR_OPERATOR_4[];
extern char near STR_AN_INTEGRAL_TYPE[];
extern char near STR_A_POINTER_TYPE[];
extern char near STR_A_SCALAR_TYPE[];
extern char near STR_AN_ARITHMETIC_TYPE[];
extern char near STR_A_SIMPLE_TYPE[];
extern char near STR_C_3[];
extern char near STR_C_4[];
extern char near STR_PASCAL_2[];
extern char near STR_TYPE_CONVERSION[];
extern unsigned char near BINARY_PRECEDENCE_BY_TOKEN[];
extern unsigned char near STACK_PRECEDENCE_BY_OP[];
extern unsigned char near PREFIX_PRECEDENCE_BY_TOKEN[];
extern char near STR_SUBSCRIPTING[];
extern char near STR_FRIEND_3[];
extern char near STR_VIRTUAL_3[];
extern unsigned char near TOKEN_OPERATOR_CODE[];
extern unsigned int near COMPARE_NEGATION_TABLE[];
extern char near STR_IF_2[];
extern char near STR_A_STANDARD_CONVERSION[];
extern int near COMPARE_NEGATE_TABLE[];
extern signed char TYPE_RECORD_SIZE[];
extern signed char MEMBER_RECORD_SIZE[];
extern unsigned int DUPLICATE_TYPE_FREE_LIST;
extern char near DEFAULT_SOURCE_EXT[];
extern unsigned char OPTION_FLOAT_MODE;
extern unsigned char OPTION_FAST_FLOAT;
extern char COMMENT_NESTED;
extern unsigned char OPTION_ERROR_LIMIT;
extern unsigned char OPTION_WARNING_LIMIT;
extern unsigned char C51_SKIP_LINK;
extern unsigned char OPTION_NO_AUTODEPEND;
extern unsigned char OPTION_STACK_CHECK;
extern unsigned char OPTIMIZE_ENABLED;
extern signed char OPTION_SUPPRESS_RELOADS;
extern unsigned char OPTION_STANDARD_FRAME;
extern unsigned char OPTION_REGISTER_VARS;
extern unsigned char OPTION_MERGE_STRINGS;
extern unsigned char C52_OS2_OPTION;
extern unsigned char C52_MULTITHREAD_OPTION;
extern unsigned char C52_DLL_OPTION;
extern unsigned char OPTION_DS_NOT_SS;
extern unsigned char VTABLE_MODE;
extern signed char PCH_OPTION_MODE;
extern int EMS_PAGE_LIMIT;
extern long EXT_MEMORY_BASE;
extern unsigned long EXT_MEMORY_BANK_SIZE;
extern unsigned char OPTION_LINK_OVERLAY;
extern unsigned char OPTION_EXPAND_INLINES;
extern unsigned char OPTION_FLAG;
extern signed char OPTION_COMDEFS;
extern unsigned char OPTION_SS_EQUALS_DS;
extern unsigned int FAR_DATA_THRESHOLD;
extern char near STR_EMPTY_MACRO_VALUE[];
extern char STR_INCLUDE_GIVEN_MARK[];
extern char near STR_CPP[];
extern char near STR_BACKSLASH[];
extern char STR_PRAGMA[];
extern char STR_DEFINE[];
extern char STR_LINE[];
extern char near STR_MISSING_FUNCTION[];
extern char near STR_PRAGMA_DIRECTIVE[];
extern unsigned char TOKEN_START_FLAGS[];
extern unsigned char SINGLE_CHAR_TOKEN_TABLE[];
extern unsigned char OP_ASSIGN_TOKEN_TABLE[];
extern unsigned char DOUBLED_CHAR_TOKEN_TABLE[];
extern signed char LEX_READ_MODE0_CLASSES[];
extern signed char LEX_READ_MODE1_CLASSES[];
extern char PREDEFINED_1[];
extern char PRED_NAME_1[];
extern char PRED_NAME_2[];
extern char PRED_NAME_3[];
extern char PRED_NAME_4[];
extern char PRED_NAME_5[];
extern char PRED_NAME_6[];
extern char STR_DEFINED[];
extern char near EOF_BUFFER_TEXT[];
extern char near STR_NEWLINE_INPUT[];
extern char near STR_DOUBLE_QUOTE[];
extern char near STR_BLANK_COMMENT_LINE[];
extern char near STR_CRLF_ECHO[];
extern char near STR_COMMENT_INDENT[];
extern char near *STARTUP_SS_DS_NAMES[6];
extern char near *C51_WINDOWS_RUNTIME[6];
extern unsigned char C51_UPPER_LINK_OPTIONS[26];
extern unsigned char C51_DIGIT_LINK_OPTIONS[10];
extern unsigned int LINK_LIBRARY_ARG_SEEN;
extern signed char C51_DLL_MODEL[6];
extern char near STR_OBJ_2[];
extern char near SPECIAL_NAME[];
extern char near STR_COLON_CRLF[];
extern char near STR_ASM_EXT[];
extern char near STR_CPP_EXT[];
extern char near STR_O[];
extern char near STR_D_TINY[];
extern char near STR_D_SMALL[];
extern char near STR_D_MEDIUM[];
extern char near STR_D_COMPACT[];
extern char near STR_D_LARGE[];
extern char near STR_D_HUGE[];
extern char near STR_D_PASCAL[];
extern char near STR_D_FASTCALL[];
extern char near STR_D_CDECL[];
extern char near STR_E[];
extern char near STR_R[];
extern char near STR_ZI[];
extern char near STR_ML[];
extern char near STR_SPACE_SLASH[];
extern char near STR_SPACE_COMMA[];
extern char near STR_SPACE_SPACE_SEMI[];
extern char near STR_PLUS_CRLF[];
extern char near STR_TURBOC_LN[];
extern char near STR_O_2[];
extern char near STR_V[];
extern char near STR_V_2[];
extern char near STR_DLL[];
extern char near STR_Y[];
extern char near STR_TWD[];
extern char near STR_T[];
extern char near STR_O_3[];
extern char near STR_OVERLAY_LIB[];
extern char near STR_IMPORT_LIB[];
extern char near STR_EMU_LIB[];
extern char near STR_FP87_LIB[];
extern char near STR_DEF[];
extern char near STR_TLINK_EXE[];
extern char near STR_TURBOC_LN_2[];
extern unsigned int INTEGRAL_PROMOTION_KIND[];
extern unsigned int ASM_STATEMENT_FLAG;
extern char near STR_EMPTY_3[];
extern char near STR__TEXT[];
extern char near STR_CODE[];
extern char near STR__[];
extern char near STR_DATA[];
extern char near STR_DGROUP[];
extern char near STR_X5F_2[];
extern char near STR_BSS[];
extern char near STR_FAR_DATA[];
extern char near STR_TEXT_2[];
extern char near STR_1[];
extern char near STR_XFB[];
extern char near STR___MULTI_THREAD__[];
extern char near STR___SINGLE_THREAD__[];
extern char near STR___DLL__[];
extern char near STR___OS2__[];
extern char near STR___MSDOS__[];
extern char near STR__WINDOWS[];
extern char near STR___TURBOC__[];
extern char near STR_0X0297[];
extern char near STR___BORLANDC__[];
extern char near STR_0X0200[];
extern char near STR___TCPLUSPLUS__[];
extern char near STR___BCPLUSPLUS__[];
extern char near STR___OVERLAY__[];
extern char near STR___PASCAL__[];
extern char near STR___FASTCALL__[];
extern char near STR___CDECL__[];
extern char near STR__FAR[];
extern char near NAME_A1[];
extern char near NAME_A2[];
extern char near NAME_B1[];
extern char near NAME_B2[];
extern long MIN_FREE_HEAP;
extern char near C53_DEFAULT_FILE[];
extern char near C53_COMMAND_LINE[];
extern char near C53_CONFIG_FILE[];
extern char near OPT_TEXT_YO[];
extern char near C53_YO_OFF[];
extern char near OPT_TEXT_V[];
extern char near C53_V_OFF[];
extern char near OPT_TEXT_VI[];
extern char near C53_VI_OFF[];
extern char near DEBUG_PREFIX[];
extern char near DEBUG_MORE[];
extern char near DEBUG_SUFFIX[];
extern char near C56_EXTERN[];
extern char near C56_NEAR[];
extern char near C56_PUBLIC_DLL[];
extern char near C56_PUBLIC[];
extern char near C56_STACK_EQU[];
extern char near C56_PLUS[];
extern char near C56_EQU[];
extern char near DEBUG_NODE_PREFIX[];
extern char near C56_VERSION_EXTENDED[];
extern char near C56_VERSION_BASE[];
extern char near C56_DATA_MARK[];
extern char near STR_BSS_BASE_LABEL[];
extern char near C56_WORD_MARK[];
extern unsigned int OBJ_EXTERN_INDEX;
extern char near STR_TURBOFLOAT[];
extern char near STR_CRLF_2[];
extern char STR_OPERATOR_NEW[];
extern char STR_OPERATOR_DELETE[];
extern char STR_FRIEND_4[];
extern char STR_VIRTUAL_4[];
extern char STR_OPERATOR_5[];
extern char STR_DYNAMIC_DISPATCH_CONSTAN[];
extern char STR_STATIC_MEMBER[];
extern char STR_NON_INLINE_FUNCTION[];
extern char STR_STATIC_2[];
extern char near BCC_DEBUG_EMPTY[];
extern unsigned int near PCH_OPTION_FLAG_PTRS[];
extern char STR_LOADED_PRE_COMPILED[];
extern char near STR_NEWLINE[];
extern char near STR_EMPTY[];
extern char near STR_HASH[];
extern char near STR_SPACE[];
extern char near STR_HDRFILE[];
extern char near STR_HDRSTOP[];
extern char near STR_PRAGMA_2[];
extern char near STR_EXTERN[];
extern char near STR_EXTERN_2[];
extern char near STR_EXTERN_3[];
extern char near STR_QUOTE[];
extern char near STR_QUOTE_CRLF[];
extern char near STR_CRLF[];
extern char near STR_INCLUDE[];
extern char near STR_GREATER[];
extern char near STR_INCLUDE_2[];
extern char near STR_DEFINE_2[];
extern char near STR_DEFINE_3[];
extern char near STR_IF_3[];
extern char near STR_IFDEF[];
extern char near STR_IFNDEF[];
extern char near STR_ENDIF[];
extern char near STR_QUOTE_OPEN_BRACE[];
extern char near STR_CLOSE_BRACE[];
extern char STR_C[];
extern char STR_C_2[];
extern signed char BINARY_PRIORITY_BY_TOKEN[];
extern signed char TERNARY_ELSE_LEVEL;
extern signed char OPERATOR_BY_TOKEN[];
extern unsigned int TYPECHECK_OP_FLAGS[];
extern signed char LEVEL_ASSOCIATIVITY[];
extern unsigned char OPERAND_KIND_MASK[];
extern unsigned int OPERAND_KIND_MESSAGE[];
extern signed char near POST_TO_ASSIGN_OP[];
extern char STR_SUBSCRIPTING_2[];
extern char near STR_STKLEN[];
extern signed char near EXPR_OP_HAS_EFFECT[];
extern char near STR_IF_4[];
extern char near STR_FOR_2[];
extern char near STR_DO_WHILE_2[];
extern char near STR_WHILE_2[];
extern char near STR_SWITCH_2[];
extern char near STR_BREAK[];
extern char near STR_CONTINUE[];
extern char near STR_RETURN[];
extern char near STR_GOTO_2[];
extern unsigned char INITIAL_TYPE_POOL_IMAGE[];
extern char near STR_S[];
extern char near STR_MAIN[];
extern char STR_STATIC[];
extern char STR_SETARGV[];
extern char STR_SETARGV_2[];
extern char STR_SETENVP[];
extern char STR_SETENVP_2[];
extern char near *STORAGE_CLASS_NAMES[];
extern char STR_DEBUG_C[];
extern char STR_CR_NL[];
extern char STR_01[];
extern char STR_DEBUG_F[];
extern signed char EXPR_RETYPE_SHAPE[];
extern signed char EXPR_NARROW_SHAPE[];
extern unsigned int INVERT_COMPARE_TABLE[];
extern unsigned int MIRROR_COMPARE_TABLE[];
extern int OUTPUT_FILE_HANDLE;
extern char JUMP_CONDITION_INVERSE_TABLE[];
extern signed char KIND_SIZE_TABLE[];
extern signed char BITFIELD_UNIT_BYTES;
extern long BCC_ENUM_MIN_LO;
extern long BCC_ENUM_MAX_LO;
extern long INT_LIMIT;
extern long MASK_B;
extern unsigned long LONG_MAX_VALUE;
extern unsigned char near OPERATOR_RULES[];
extern unsigned char near CONVERSION_RULES[];
extern unsigned char CODE_OP_INFO_TABLE[];
extern unsigned char OPCODE_DESC_BYTE8[];
extern unsigned int REG_CLASS_MASK_TABLE[];
extern unsigned char near REG_CLASS_IS_WORD[];
extern unsigned int REGISTER_MASK_TABLE[];
extern unsigned char OPERAND_BASE_BY_KIND[];
extern unsigned char LEAF_OPCODE_KIND_OFFSET[];
extern unsigned char OPER_OPCODE_KIND_OFFSET[];
extern unsigned int near OPERATOR_HELPER_NAME_TABLE[];
extern char near STR_PCMP[];
extern char near STR_OVERFLOW[];
extern char near STR_SPUSH[];
extern char near STR_SCOPY[];
extern char near STR_PDEA[];
extern char near STR_PINA[];
extern int EVAL_STACK_TOP;
extern int EVAL_STACK_MAX;
extern int EVAL_STACK_SPILLED;
extern int POOLED_NODE_TOP;
extern unsigned int SCRATCH_TEMP_VARIABLE;
extern char JUMP_KIND_REMAP_TABLE[];
extern unsigned int REG_MASK_ES;
extern unsigned int REG_MASK_BX_SI_DI;
extern unsigned int REG_MASK_SI_DI;
extern unsigned int REG_MASK_CX;
extern unsigned int REG_MASK_HIGH_BYTES;
extern unsigned int REG_MASK_LOW_BYTES;
extern unsigned int SWITCH_BIT_200_FLAG;
extern unsigned int LOCAL_LABEL_SERIAL;
extern unsigned int LAST_LINE_MARK_ID;
extern char near *JUMP_MNEMONIC_TEXT[];
extern unsigned char JUMP_OPCODE_BYTE[];
extern char STR_ASM_STATEMENT_CRLF[];
extern char STR_BP[];
extern unsigned int INVERTED_JUMP_KIND[];
extern signed char REGISTER_ENCODING_TABLE[];
extern signed char FIXUP_CODE_TABLE[];
extern char ASM_OPERAND_FORMAT_MAP[];
extern char STR_DEBUG_B;
extern char STR_DB_LINE_CRLF;
extern char STR_DEBUG_E;
extern char STR_DB;
extern char STR_MOV_CX_OFFSET_7_PUSH;
extern char STR_PUSH_OFFSET_6;
extern char STR_ENDP;
extern char STR_ENDS[];
extern char near STR_EMIT[];
extern unsigned char CTYPE_BY_CHAR[];
extern char near SEARCH_PATH_NAME[];
extern char near SEARCH_SEPARATOR[];
extern unsigned int CTRL_BREAK_SEEN;
extern unsigned int HEAP_SIZE_PARAS;
extern unsigned int SCOPE_STACK_DEPTH;
extern unsigned int CACHE_HEAD;
extern unsigned int CURRENT_TOKEN;
extern unsigned int VECTOR_NEW_SYMBOL;
extern unsigned int GLOBAL_SCOPE_TAGS;
extern unsigned int INT_TYPE;
extern unsigned int SUPPRESS_WARNINGS_DEPTH;
extern unsigned char NOT_ANSI_FLAG;
extern unsigned int SETARGV_SYMBOL;
extern unsigned int SETENVP_SYMBOL;
extern unsigned int TOKEN_STREAM_POOL_SEG;
extern unsigned int BCC_TREE_FLAG;
extern unsigned int CURRENT_FUNCTION_TYPE;
extern unsigned int STMT_SCOPE_BLOCK;
extern unsigned int BCC_TREE_LINK;
extern unsigned int STRUCT_RETURN_PARAM;
extern unsigned char CODE_UNREACHABLE;
extern unsigned char STMT_NO_GOTO_OR_LABEL_FLAG;
extern unsigned int LOOP_NEST_FACTOR;
extern unsigned int ENCLOSING_STATEMENT_KIND;
extern unsigned int STATEMENT_NEST_DEPTH;
extern unsigned int SWITCH_STATE_SCOPE;
extern unsigned int LOOP_BREAK_SCOPE;
extern unsigned int PENDING_GOTO_LIST;
extern unsigned int LABEL_LIST_HEAD;
extern unsigned int BLOCK_NEST_LEVEL;
extern int DECL_INIT_SERIAL;
extern unsigned int BCC_PARSE_BUFFER;
extern unsigned int CTOR_DTOR_MODE;
extern unsigned int CTOR_THIS_SYMBOL;
extern unsigned char CTOR_THIS_ASSIGNED;
extern unsigned char CTOR_CHECK_THIS_ASSIGN;
extern unsigned int PACKED_INIT_EXPR;
extern unsigned int FNBODY_WORD_A_SAVE;
extern unsigned int FNBODY_WORD_B_SAVE;
extern unsigned int CPP_BODY_END_LABEL;
extern unsigned int FUNC_START_CLEARED_WORD;
extern unsigned int FUNCTION_DEF_LINE;
extern unsigned int CURRENT_SOURCE_FILE;
extern unsigned char STARTUP_BODY_ACTIVE;
extern unsigned char SAW_RETURN_WITH_VALUE;
extern unsigned char SAW_RETURN_WITHOUT_VALUE;
extern unsigned int LOCAL_INIT_EXPR_LIST;
extern unsigned int FAR_CHAR_POINTER_TYPE;
extern unsigned int PARAM_LIST_DEPTH;
extern unsigned int near C26_SCOPE_STACK[];
extern unsigned char RECORDING_TOKENS;
extern unsigned int VECTOR_VNEW_SYMBOL;
extern unsigned int TAG_BODY_POOL_SEG;
extern unsigned int INIT_RECORD_POOL_SEG;
extern char BCC_DEBUG_NAME[];
extern unsigned int VTABLE_ENTRY_PTR_TYPE;
extern unsigned int INT_TYPE_SIZE;
extern unsigned int PENDING_DEFINITION_LIST;
extern unsigned int PENDING_INIT_LIST;
extern unsigned char INLINE_OPTION_BLOCK_FLAG;
extern unsigned int MEMBER_PTR_CLASS_TYPE;
extern unsigned int VTABLE_CLASS_LIST;
extern unsigned char STRING_TOKEN_PENDING;
extern unsigned int VECTOR_APPLY_SYMBOL;
extern unsigned int VTABLE_NEAR_FUNC_MEMBER;
extern unsigned int VTABLE_FAR_FUNC_MEMBER;
extern unsigned int NEAR_PURE_ERROR_SYMBOL;
extern unsigned int FAR_PURE_ERROR_SYMBOL;
extern unsigned char EXPAND_INLINES_FLAG;
extern unsigned int NON_CPP_CLEARED_WORD_A;
extern unsigned int MEMBER_PTR_OFFSET_MEMBER;
extern unsigned int MEMBER_PTR_VINDEX_MEMBER;
extern unsigned int MEMBER_PTR_NEAR_FUNC_MEMBER;
extern unsigned int MEMBER_PTR_FAR_FUNC_MEMBER;
extern unsigned int VECTOR_DELETE_SYMBOL;
extern unsigned int VECTOR_VAPPLY_SYMBOL;
extern unsigned int TOKEN_STREAM_HANDLE;
extern unsigned int TOKEN_NAMES[];
extern unsigned int CTOR_NAME;
extern unsigned int DTOR_NAME;
extern unsigned int CONVERSION_FUNC_NAME;
extern unsigned int EXPR_CURRENT2;
extern unsigned int HIDDEN_RETURN_PARAM_NAME;
extern unsigned int OPERATOR_DELETE_NAME;
extern unsigned int OPERATOR_NEW_NAME;
extern unsigned int THIS_NAME;
extern unsigned int VTABLE_PTR_NAME;
extern unsigned int MEMBER_PTR_DELTA_MEMBER;
extern unsigned int STORAGE_POOL_SEG;
extern unsigned int FNBODY_WORD_B;
extern unsigned int FNBODY_CLEARED_WORD_B;
extern unsigned int INLINE_BODY_QUEUE;
extern unsigned int INLINE_EXPANSION_DEPTH;
extern unsigned char END_OF_INPUT_SEEN;
extern unsigned int FAR_VOID_PTR_TYPE;
extern unsigned int FAR_VTABLE_ENTRY_PTR_TYPE;
extern unsigned int LONG_TYPE;
extern unsigned int VOID_TYPE;
extern unsigned char CPP_MODE;
extern unsigned int PLAIN_CHAR_TYPE;
extern unsigned int BASE_PATH_POOL_SEG;
extern unsigned int INLINE_FUNCTION_STACK;
extern unsigned char ENUMS_AS_INT_FLAG;
extern unsigned int DOUBLE_TYPE;
extern unsigned int LINKAGE_STACK_POOL_SEG;
extern unsigned int STRUCT_BODY_TYPE;
extern unsigned int ACTIVE_LIST;
extern signed char WARNING_ENABLED_TABLE[];
extern int BITFIELD_ALIGN_BITS;
extern unsigned int CLASS_KEY_TOKEN;
extern unsigned int SCOPE_STATE;
extern unsigned int CURRENT_DECLARATOR_NAME;
extern unsigned int DECLARATOR_NAME_TOKEN;
extern unsigned int SPECIAL_MEMBER_KIND;
extern unsigned int STORAGE_CLASS_TOKEN;
extern unsigned int TYPE_EXPR;
extern unsigned int MEMBER_QUALIFIER_CLASS;
extern unsigned char PARSE_FLAG2;
extern unsigned char MEMBER_DECL_FRIEND;
extern unsigned char NO_THIS_PARAMETER;
extern unsigned char MEMBER_DECL_TYPE_NAMED;
extern unsigned char RETURN_TYPE_OMITTED;
extern unsigned char DISPATCH_NUMBER_GIVEN;
extern unsigned int DISPATCH_NUMBER;
extern unsigned char PARSE_CLASS;
extern unsigned int CLASS_VTABLE_SIZE;
extern unsigned int EXPR_OFFSET2;
extern unsigned char MEMBER_FLAG_200_SWITCH;
extern unsigned int UNSIGNED_INT_TYPE;
extern unsigned int EMIT_INTRINSIC_SYMBOL;
extern unsigned int DOUBLE_TYPE_SIZE;
extern signed char CURRENT_TOKEN_FLAGS;
extern unsigned int CURRENT_TOKEN_FILE;
extern unsigned int CURRENT_TOKEN_LINE;
extern unsigned int CURRENT_TOKEN_LOC_WORD3;
extern unsigned int CHAR_TYPE;
extern unsigned int CURRENT_SCOPE;
extern unsigned int TYPE_POOL;
extern unsigned int TYPE_POOL_LENGTH;
extern unsigned int TYPE_POOL_WORD6;
extern unsigned char PARSER_RESET_BYTE_A;
extern unsigned int STRING_LITERAL_SYMBOL;
extern unsigned int TEMP_ENTRY_POOL_SEG;
extern unsigned char NO_ERRORS_YET;
extern unsigned int SHORT_TYPE;
extern unsigned int LABEL_POOL_SEG;
extern unsigned int FNBODY_WORD_A;
extern unsigned int FNBODY_CLEARED_WORD_A;
extern unsigned int MAIN_SYMBOL;
extern unsigned int CONDITIONAL_ARM_DEPTH;
extern unsigned int LINKAGE_STACK;
extern unsigned int GLOBAL_SCOPE;
extern unsigned int CSYM_POOL_SEG;
extern unsigned int NODE_COUNT;
extern unsigned int TEMP_DESTRUCTOR_LIST;
extern unsigned char PARSER_INIT_MARK_A5;
extern unsigned int NEW_OPERATOR_SYMBOL;
extern unsigned int TEMP_NAME_COUNTER;
extern unsigned int IMPLICIT_FUNC_TYPE;
extern unsigned int INT_FAR_FUNC_TYPE;
extern unsigned int RUNTIME_HELPER_FUNC_TYPE;
extern unsigned int GLOBAL_SCOPE_NAMES;
extern unsigned int INLINE_TOKEN_STREAM;
extern unsigned int PTRDIFF_TYPE;
extern unsigned int LIST_CELL_POOL_SEG;
extern unsigned int CONS_CELL_POOL_SEG;
extern unsigned int HIDDEN_RETURN_PARAM_RECORD;
extern unsigned char CPU_LEVEL_1_FLAG;
extern unsigned char CPU_IS_286;
extern unsigned int VTABLE_ENTRY_CLASS_TYPE;
extern unsigned int FILE_INIT_EXPR_QUEUE;
extern unsigned int EXPR_START_FLAG_MASK;
extern unsigned int CHAR_POINTER_TYPE;
extern unsigned int TYPE_LOCAL;
extern unsigned char ENUM_BODY_TREE_FLAG;
extern unsigned int PLAIN_CHAR_KIND;
extern unsigned int INT_NEAR_FUNC_TYPE;
extern unsigned int VOID_NOARG_FUNC_TYPE;
extern unsigned int BASE_LIST_SEG;
extern unsigned int SYMBOL_POOL_SEG;
extern unsigned int SCOPE_LINK10_MARK;
extern unsigned int SCOPE_LINK10_MARK_HIGH;
extern unsigned int VOID_POINTER_TYPE;
extern unsigned int IMPLICIT_FUNC_PTR_TYPE;
extern unsigned int REPLAY_STREAM_2;
extern unsigned int REPLAY_STREAM_3;
extern unsigned int REPLAY_STREAM_4;
extern unsigned int FORMAL_POOL_SEG;
extern unsigned int PACKED_EXPR_POOL_SEG;
extern unsigned int CURRENT_CLASS_TYPE;
extern unsigned char WARNING_SWITCH_STATE[];
extern unsigned char WARN_PRO_FLAG;
extern char FOR_STEP_CLEARED_FLAG;
extern unsigned int TOKEN_MASK;
extern unsigned char IN_ERROR_RECOVERY;
extern unsigned int INT_NEAR_FUNC_PTR_TYPE;
extern unsigned int INT_FAR_FUNC_PTR_TYPE;
extern unsigned int CURRENT_LINKAGE;
extern unsigned int STORAGE_RECORD_COUNT;
extern unsigned int TYPE_DEBUG_ID_COUNTER;
extern unsigned int DEBUG_CLASS_INDEX_NEXT;
extern unsigned int DEBUG_MEMBER_COUNTER;
extern unsigned char PARSER_RESET_BYTE_B;
extern unsigned int DESTRUCTOR_ENTRY_SERIAL;
extern unsigned int DELETE_OPERATOR_SYMBOL;
extern unsigned int NON_CPP_CLEARED_WORD_B;
extern unsigned int CACHE_POOL;
extern unsigned int SIZE_T_TYPE;
extern unsigned int MEMBER_PTR_PAD_MEMBER;
extern int C28_LITERAL_PATCH;
extern unsigned int LOGICAL_LINE;
extern unsigned int DIAG_FUNC_NAME_HIGH;
extern unsigned int CURRENT_FILE_NAME;
extern unsigned int OPERAND_LIST_BASE;
extern unsigned int OPERATOR_STACK_OFFSET;
extern unsigned int OPERATOR_STACK_POOL;
extern unsigned int OPERAND_LIST_HEAD;
extern int OPERATOR_STACK_DEPTH;
extern unsigned int MEMBER_INIT_EXPR;
extern unsigned int MEMBER_CACHE_TYPES[32];
extern unsigned int MEMBER_CACHE_NAMES[32];
extern unsigned int MEMBER_CACHE_MEMBERS[32];
extern unsigned int COMPILE_FILE_COUNT;
extern unsigned int C_DECL_SCOPE;
extern char TOKEN_TEXT_BUFFER[];
extern char EMIT_LIMIT;
extern char near NAME_BUFFER[];
extern unsigned int C_FUNC_START_CLEARED_WORD;
extern unsigned char MACRO_MODE;
extern unsigned char MODEL_FAR_DATA;
extern unsigned int CURRENT_LINE;
extern unsigned int LEX_FILE_SERIAL_NODE;
extern char MACRO_NAME_UNEXPANDED;
extern unsigned char MACRO_MARK_FE_SEEN;
extern unsigned int TYPE_POOL_LENGTH_MARK;
extern unsigned int PLAIN_INT_TYPE;
extern unsigned int STRING_CHAR_TYPE;
extern unsigned int IMPLICIT_FUNCTION_TYPE;
extern unsigned int C_HELPER_FUNC_TYPE;
extern unsigned int BACKEND_OUTPUT_BEGUN_FLAG;
extern unsigned int SWITCH_CASE_LIST;
extern unsigned int SWITCH_DEFAULT_LABEL;
extern int STATEMENT_LABELED_FLAG;
extern unsigned char COMPILER_TABLES_INIT_FLAG;
extern unsigned int BITFIELD_INIT_PENDING;
extern unsigned int BITFIELD_INIT_BITS;
extern unsigned int BITFIELD_INIT_OFFSET;
extern unsigned char C_FUNC_DEF_SET_ONLY_FLAG;
extern unsigned int C_STRING_LITERAL_SYMBOL;
extern long HEAP_RESERVE_BYTES;
extern unsigned int PARAM_SCOPE_MARK;
extern unsigned int PARAM_SCOPE_MARK_AUX;
extern unsigned int NAME_TABLE_END;
extern unsigned int STRING_POOL_USED;
extern unsigned int POOL_HASH;
extern unsigned int MEMBER_SEGMENT;
extern unsigned int CONTEXT_PTR;
extern unsigned int DECLARATOR_NODE_POOL_SEG;
extern unsigned int EXPR_POOL_UNIT;
extern unsigned int EXPR_POOL_USED;
extern unsigned int SEGMENT_POOL_USED;
extern unsigned int SEGMENT_POOL_FREE_LIST;
extern unsigned int C_PARAM_POOL_SEG;
extern char SAVED_OPTION_BLOCK[];
extern unsigned int SOURCE_FILE_LIST;
extern unsigned int CURRENT_BANK_INDEX;
extern unsigned int DIRECTIVE_MODE;
extern unsigned int LINE_RECORD;
extern unsigned int POOL_A;
extern unsigned int POOL_A_STEP;
extern unsigned int POOL_A_UNIT;
extern char LINKER_Y_SWITCH_FLAGS[];
extern unsigned int POOL_A_USED;
extern unsigned int TOKEN_POOL;
extern unsigned int TOKEN_POOL_STEP;
extern unsigned int TOKEN_POOL_UNIT;
extern unsigned int TOKEN_POOL_USED;
extern unsigned int LINE_POOL;
extern unsigned int LINE_POOL_STEP;
extern unsigned int CONDITION_MARK;
extern char LINKER_T_SWITCH_FLAGS[];
extern unsigned int CONDITION_STATE;
extern unsigned int TOKEN_FILE_NODE;
extern unsigned int TOKEN_LINE;
extern unsigned int TOKEN_LENGTH;
extern unsigned int CONTEXT_SEG;
extern unsigned int CONTEXT_SEG_STEP;
extern unsigned int CONTEXT_SEG_UNIT;
extern unsigned int CONTEXT_SEG_USED;
extern unsigned int INPUT_BUFFER;
extern unsigned int INPUT_ACTIVE;
extern unsigned int FREE_MACRO_CONTEXT_LIST;
extern unsigned int INPUT_UNGET_FLAG;
extern unsigned int CURRENT_FILE_CONTEXT;
extern unsigned int LEXER_INIT_CLEARED_WORD;
extern int INPUT_UNGET_CHAR;
extern unsigned int STRING_DATA;
extern long INPUT_FILE_POS;
extern unsigned int ECHO_NEXT_LINE;
extern unsigned int CURRENT_SYMBOL;
extern unsigned int BREAK_POLL_COUNTER;
extern unsigned int COMPILE_FAILED;
extern unsigned char C51_Y_LINK_OPTIONS[26];
extern unsigned char C51_T_LINK_OPTIONS[26];
extern char near TOKEN_TEXT[3];
extern unsigned int BSS_SEGMENT_NAME;
extern unsigned int C52_FAR_SERIAL;
extern unsigned int CODE_SEGMENT_NAME;
extern unsigned int BSS_GROUP_NAME;
extern unsigned int DATA_BSS_GROUPS_DIFFER;
extern unsigned int SYMBOL_A1;
extern unsigned int CODE_GROUP_NAME;
extern unsigned int BSS_SEGMENT_SEPARATE;
extern unsigned int BSS_CLASS_NAME;
extern unsigned int SYMBOL_A2;
extern unsigned int CODE_CLASS_NAME;
extern char near C52_MODULE_NAME[];
extern unsigned int PSEUDO_REG_BP_SYMBOL;
extern unsigned int PSEUDO_REG_SP_SYMBOL;
extern unsigned int DATA_SEGMENT_NAME;
extern unsigned int SYMBOL_B1;
extern unsigned int DATA_GROUP_NAME;
extern unsigned int BACKEND_MODE3_TYPE;
extern unsigned int SYMBOL_B2;
extern unsigned int DATA_CLASS_NAME;
extern unsigned int MALLOC_POOL_LENGTH_MARK;
extern unsigned int MALLOC_POOL_SEG;
extern unsigned int MALLOC_POOL_LENGTH;
extern unsigned int MALLOC_POOL_WORD6;
extern unsigned int BCC_LINE_OFFSET;
extern unsigned int BCC_LINE_SEGMENT;
extern unsigned int PENDING_EXTERN_RECORD_TYPE;
extern unsigned char ASM_MNEMONIC_FLAGS;
extern char ASM_STATEMENT_BUFFER[];
extern unsigned int PREAMBLE_POOL_SEG;
extern unsigned int PREAMBLE_POOL_CAPACITY;
extern unsigned int PREAMBLE_POOL_USED;
extern unsigned int PREAMBLE_POOL_FREE_LIST;
extern unsigned char PCH_DIAGNOSTIC_ISSUED;
extern unsigned int PCH_DEPENDENCY_TAIL;
extern char near PREAMBLE_PUSHBACK_BUFFER[];
extern unsigned int PCH_DEPENDENCY_HEAD;
extern unsigned int PREAMBLE_REMAINDER_NODE;
extern int PREAMBLE_IF_DEPTH;
extern unsigned int MACRO_SNAPSHOT_POOL_SEG;
extern unsigned int MACRO_SNAPSHOT_POOL_CAPACITY;
extern unsigned int MACRO_SNAPSHOT_POOL_USED;
extern unsigned int MACRO_SNAPSHOT_POOL_FREE;
extern unsigned int PREAMBLE_MISMATCH_NODE;
extern unsigned int PCH_INDEX_POOL_SEG;
extern unsigned int PCH_INDEX_POOL_CAPACITY;
extern unsigned int PCH_INDEX_POOL_USED;
extern unsigned int PCH_INDEX_POOL_FREE;
extern unsigned int PCH_FILE_MAGIC;
extern unsigned int PCH_HEADER_VERSION;
extern long PCH_INDEX_FILE_OFFSET;
extern unsigned int PCH_INDEX_FILE_SIZE;
extern int PCH_FILE_HANDLE;
extern unsigned int PREAMBLE_REPLAY_NODE;
extern unsigned int PREAMBLE_LIST_TAIL;
extern unsigned char PCH_SAVE_PENDING;
extern unsigned int PREAMBLE_LIST_HEAD;
extern unsigned int PCH_DEPENDENCY_POOL_SEG;
extern unsigned int PCH_DEPENDENCY_POOL_CAPACITY;
extern unsigned int PCH_DEPENDENCY_POOL_USED;
extern unsigned int PCH_DEPENDENCY_POOL_FREE;
extern unsigned int SAVED_OPTION_POOL_SEG;
extern unsigned int SAVED_OPTION_POOL_CAPACITY;
extern unsigned int SAVED_OPTION_POOL_USED;
extern unsigned int SAVED_OPTION_POOL_FREE;
extern signed char PCH_COLLECT_DEPENDENCIES;
extern unsigned int CALL_ARGUMENT_NUMBER;
extern unsigned int CALL_FUNCTION_EXPR;
extern unsigned int C_UNNAMED_GLOBAL_LIST;
extern unsigned int C_GLOBAL_SCOPE;
extern char C_FUNCTION_NAME_BUFFER[];
extern unsigned int C_FUNCTION_SCOPE;
extern unsigned int C_OLD_STYLE_PARAM_LIST;
extern unsigned int PARAM_NAME;
extern unsigned int C_DECL_CALL_CONVENTION;
extern unsigned int C_DECL_DISTANCE;
extern unsigned int C_DECLARATOR_NAME;
extern unsigned int C_DECL_SOURCE_LINE;
extern unsigned long C_DECL_START_POSITION;
extern unsigned int C_DECL_START_POSITION_HIGH;
extern unsigned int C_CURRENT_FUNCTION_SYMBOL;
extern unsigned int C_DECL_SOURCE_FILE;
extern unsigned int DECLARATOR_NAME_FILE;
extern unsigned int DECLARATOR_NAME;
extern unsigned int DECLARATOR_NAME_LINE;
extern unsigned int OUTPUT_BUFFER_FILL;
extern unsigned int OUTPUT_BUFFER_SEG;
extern unsigned int ASM_OUTPUT_PATH;
extern unsigned int BACKEND_OWNER_TAG;
extern unsigned int BSS_SEGMENT_ID;
extern unsigned int CODE_NODE_POOL_UNIT;
extern unsigned int CODE_NODE_POOL_USED;
extern unsigned int REG_HISTORY_POOL_SEG;
extern unsigned int HISTORY_END_OFFSET;
extern unsigned int REG_HISTORY_POOL_FREE_LIST;
extern unsigned int VARIABLE_TABLE_END;
extern unsigned int VARIABLE_TABLE_FREE_LIST;
extern unsigned int DEFAULT_CODE_SEGMENT_ID;
extern unsigned int CODE_OP_POOL_SEG;
extern unsigned int CODE_OP_POOL_UNIT;
extern unsigned int CODE_OP_POOL_USED;
extern unsigned int CASE_ENTRY_POOL_SEG;
extern unsigned int CASE_ENTRY_POOL_UNIT;
extern unsigned int CASE_ENTRY_POOL_USED;
extern unsigned int POOL_E;
extern unsigned int POOL_E_STEP;
extern unsigned int POOL_E_UNIT;
extern unsigned int POOL_E_USED;
extern unsigned int CODE_OPERAND_POOL_SEG;
extern unsigned int CODE_OPERAND_POOL_UNIT;
extern unsigned int CODE_OPERAND_POOL_USED;
extern unsigned int POOL_F;
extern unsigned int POOL_F_STEP;
extern unsigned int POOL_F_UNIT;
extern unsigned int POOL_F_USED;
extern unsigned int DATA_BYTE_POOL_LENGTH;
extern unsigned int DATA_BYTE_POOL_WORD6;
extern unsigned int LINE_NUMBER_POOL_SEG;
extern unsigned int LINE_NUMBER_POOL_USED;
extern unsigned int LIVE_VALUE_POOL_SEG;
extern unsigned int LIVE_VALUE_POOL_USED;
extern unsigned int LIVE_VALUE_POOL_FREE_LIST;
extern unsigned int DATA_SEGMENT_ID;
extern unsigned int DEBUG_TYPE_COUNTER;
extern unsigned int SELECTED_SEGMENT_ID;
extern unsigned int SEGMENT_COUNT;
extern unsigned int CODE_OUTPUT_FLAGS;
extern unsigned int CODEGEN_FUNCTION_SYMBOL;
extern unsigned int FUNCTION_CODE_SEGMENT;
extern unsigned int FUNCTION_SOURCE_FILE;
extern unsigned int FUNCTION_START_LINE;
extern unsigned int FUNCTION_SOURCE_POS_LOW;
extern unsigned int FUNCTION_SOURCE_POS_HIGH;
extern unsigned int CODE_BLOCK_LIST_HEAD;
extern unsigned int CODE_BLOCK_LIST_TAIL;
extern unsigned int FUNCTION_RETURN_LABEL;
extern unsigned int FRAME_LOCALS_SIZE;
extern unsigned int CODEGEN_PARAMS_SIZE;
extern unsigned int FRAME_HEADER_SIZE;
extern unsigned int FUNCTION_OUTER_SCOPE_BLOCK;
extern unsigned int CODEGEN_RETURN_TYPE;
extern unsigned int CODEGEN_PARAM_LIST;
extern unsigned char CODEGEN_CALL_CONV;
extern unsigned int CODEGEN_FUNCTION_FLAGS;
extern unsigned int FUNCTION_SERIAL;
extern unsigned int CURRENT_CODE_BLOCK;
extern unsigned int CODE_OP_NEXT_INDEX;
extern unsigned int CODEGEN_USED_REG_MASK;
extern unsigned int FUNCTION_CLAIMED_REG_MASK;
extern unsigned int SAVED_REG_MASK;
extern unsigned int LIVE_VALUE_SPILL_END;
extern unsigned int LIVE_VALUE_END;
extern unsigned int CURRENT_SCOPE_BLOCK;
extern unsigned int JUMP_OPT_KEEP_EMPTY_BLOCKS;
extern signed char RESOLVED_REQUEST_COUNT;
extern unsigned int CURRENT_INSN_INDEX;
extern unsigned int BLOCK_CLAIMED_REG_MASK;
extern unsigned int ALLOCATABLE_REGISTER_MASK;
extern unsigned int REGALLOC_SCOPE_NODE;
extern unsigned int PENDING_REGISTER_MASK;
extern unsigned int BLOCK_FREE_REGISTER_MASK;
extern signed char PENDING_RESULT_REGISTER;
extern int PENDING_REQUEST_COUNT;
extern signed char SPILLED_REQUEST_COUNT;
extern unsigned int CROSS_JUMP_CHANGED;
extern unsigned int PEEPHOLE_STORE_STAMP;
extern unsigned int PEEPHOLE_MEMORY_STORE_STAMP;
extern unsigned int OUTPUT_BUFFER_LIMIT;
extern unsigned int OUTPUT_BUFFER_POS;
extern unsigned int CODE_BYTE_POOL_FREE_LIST;
extern unsigned int CODE_FRAGMENT_POOL_SEG;
extern unsigned int CODE_FRAGMENT_POOL_USED;
extern unsigned int CODE_FRAGMENT_POOL_FREE_LIST;
extern unsigned int QUEUED_WORD_POOL_SEG;
extern unsigned int QUEUED_WORD_POOL_USED;
extern unsigned int QUEUED_WORD_POOL_FREE;
extern unsigned int SEG_DATA_BLOCK_POOL_SEG;
extern unsigned int RELOCATION_POOL_SEG;
extern unsigned int SEGDEF_POOL_SEG;
extern unsigned int FAR_SEGMENT_COUNT;
extern unsigned int SEGMENT_LIST_TAIL;
extern unsigned int SELECTED_SEGDEF_ENTRY;
extern unsigned int SELECTED_SEGDEF_COPY;
extern unsigned int GROUP_LIST_HEAD;
extern unsigned int GROUP_LIST_TAIL;
extern unsigned int GROUP_COUNT;
extern unsigned int ASM_OUTPUT_FLAGS;
extern unsigned int PARAM_FRAME_BASE;
extern unsigned char STACK_BALANCE_NEEDED;
extern unsigned int FRAME_PUSHED_REG_BYTES;
extern int CALL_ARG_SPLIT_COUNT;
extern unsigned int near EVAL_STACK_VALUES[];
extern unsigned int near EVAL_STACK_TEMP_NODES[];
extern unsigned int POOLED_NODE_STACK[];
extern unsigned int OUTER_SCOPE_EXIT_VALUE;
extern unsigned int REGISTER_HISTORY_CURSOR;
extern unsigned int SWITCH_TABLE_LIST;
extern unsigned int CURRENT_CODE_FRAGMENT;
extern unsigned char FIRST_OPERAND_SEG_REG;
extern unsigned char FIRST_OPERAND_INDEX_REG;
extern unsigned char FIRST_OPERAND_REG;
extern unsigned int FIRST_OPERAND_VALUE;
extern unsigned char SECOND_OPERAND_SEG_REG;
extern unsigned char SECOND_OPERAND_INDEX_REG;
extern unsigned char SECOND_OPERAND_REG;
extern unsigned int SECOND_OPERAND_VALUE;
extern unsigned char near *OBJ_RECORD_CURSOR;
extern unsigned int OBJ_RECORD_CHECKSUM;
extern unsigned int LINE_MARK_LAST_FILE;
extern unsigned int SAVE_SS;
extern unsigned int SAVE_SP;
extern char near ENV_BUFFER[];
extern char near SEARCH_BUFFER[];

/* Strings the code reaches by address (names made from their text by
   tools/namestrings.py; the original passes their DS offsets). */
extern char STR_C_7[];                              /* "C++" */
extern char STR_C_8[];                              /* "C" */
extern char STR_ARRAY_BOUNDS_2[];                   /* "Array bounds" */
extern char STR_DEBUG_C_2[];                        /* "+\r\n\t?debug\tC " */
extern char STR_EXTRN[];                            /* "\textrn\t" */
extern char STR_NEAR_3[];                           /* "near" */
extern char STR_PUBLICDLL[];                        /* "\tpublicdll\t" */
extern char STR_PUBLIC_2[];                         /* "\tpublic\t" */
extern char STR_EQU_S[];                            /* "\tequ\ts@+" */
extern char STR_EQU[];                              /* "\tequ\t" */
extern char STR_D[];                                /* "d@" */
extern char STR_B[];                                /* "b@" */
extern char STR_TURBOFLOAT_2[];                     /* "__turboFloat" */
extern char STR_COLON_2[];                          /* ":" */
extern char STR_AHSHIFT_2[];                        /* "__AHSHIFT" */
extern char STR_SCOPY_2[];                          /* "scopy@" */
extern char STR_FTOL[];                             /* "ftol@" */
extern char STR_TEXT[];                             /* "_TEXT" */
extern char STR_STKLEN_2[];                         /* "_stklen" */
extern char STR_BRKLVL[];                           /* "__brklvl" */
extern char STR_N[];                                /* "N_" */
extern char STR_F[];                                /* "F_" */
extern char STR_AHSHIFT[];                          /* "__AHSHIFT" */
extern char STR_SLXMUL[];                           /* ":Slxmul@" */
extern char STR_N_CHKSTK[];                         /* "N_CHKSTK@" */
extern char STR_F_CHKSTK[];                         /* "F_CHKSTK@" */
extern char STR_COLON_CR_NL[];                      /* ":\r\n" */
extern char STR_DEBUG_L[];                          /* "\t?debug\tL " */
extern char STR_DW[];                               /* "dw\t" */
extern char STR_SHORT[];                            /* "short " */
extern char STR_NEAR_PTR[];                         /* "near ptr " */
extern char STR_FAR_PTR[];                          /* "far ptr " */
extern char STR_TAB_AT_AT[];                        /* "\t@@" */
extern char STR_JMP[];                              /* "\tjmp\t" */
extern char STR_OBJ_3[];                            /* ".obj" */
extern char STR_DGROUP_2[];                         /* "DGROUP@" */
extern char STR_TC86_BORLAND_TURBO_C_2_0[];         /* "TC86 Borland Turbo C++ 2.0" */
extern char STR_MOV_BX_SP[];                        /* "\tmov\tbx,sp\r\n" */
extern char STR_ADD_SS_BX[];                        /* "\tadd\tss:[bx+" */
extern char STR_RBRACKET_COMMA[];                   /* "]," */
extern char STR_JMP_FAR_PTR[];                      /* "\r\n\tjmp\tfar ptr " */
extern char STR_JMP_NEAR_PTR[];                     /* "\r\n\tjmp\tnear ptr " */
extern char STR_ASM_2[];                            /* ".asm" */
extern char STR_286[];                              /* "\t.286\r\n" */
extern char STR_287[];                              /* "\t.287\r\n" */
extern char STR_286P[];                             /* "\t.286p\r\n" */
extern char STR_IFNDEF_VERSION_DEBUG_MACRO_E[];     /* "\tifndef\t??version\r\n?debug\tmacro\r\n" */
extern char STR_QUOTE_CR_NL[];                      /* ""\r\n" */
extern char STR_GROUP[];                            /* "\tgroup\t" */
extern char STR_ASSUME_CS_2[];                      /* "\tassume\tcs:" */
extern char STR_DS[];                               /* ",ds:" */
extern char STR_D_LABEL_BYTE_D_W_LABEL_WORD[];      /* "d@\tlabel\tbyte\r\nd@w\tlabel\tword\r\n" */
extern char STR_B_LABEL_BYTE_B_W_LABEL_WORD[];      /* "b@\tlabel\tbyte\r\nb@w\tlabel\tword\r\n" */
extern char STR_DEBUG_C_E9[];                       /* "\t?debug\tC E9\r\n" */
extern char STR_S_LABEL_BYTE[];                     /* "s@\tlabel\tbyte\r\n" */
extern char STR_EXTRN_DGROUP_WORD[];                /* "\textrn\tDGROUP@:word\r\n" */
extern char STR_EXTRN_TURBOFLOAT_WORD[];            /* "\textrn\t__turboFloat:word\r\n" */
extern char STR_JMP_WORD_PTR_CS[];                  /* "\tjmp\tword ptr cs:@" */
extern char STR_C_6[];                              /* "@C" */
extern char STR_BX[];                               /* "[bx]\r\n" */
extern char STR_MOV_BX_OFFSET[];                    /* "\tmov\tbx,offset " */
extern char STR_MOV[];                              /* "\tmov\t" */
extern char STR_CS_DGROUP[];                        /* ",cs:DGROUP@\r\n" */
extern char STR_JMP_WORD_PTR_CS_BX[];               /* "\tjmp\tword ptr cs:[bx+" */
extern char STR_DEBUG_C_3[];                        /* "\t?debug\tC " */
extern char STR_DEBUG_C_4[];                        /* "+\r\n\t?debug\tC " */
extern char STR_PUSH_CS_CALL[];                     /* "push\tcs\r\n\tcall\t" */
extern char STR_DB_0CBH[];                          /* "db\t0cbh\r\n" */
extern char STR_FCOMPP[];                           /* "FCOMPP\r\n" */
extern char STR_P_ST[];                             /* "P\tst(" */
extern char STR_ST_0[];                             /* "),st( 0 )\r\n" */
extern char STR_ST_0_ST[];                          /* "st(0),st(" */
extern char STR_0[];                                /* ",0\r\n" */
extern char STR_AX_AX[];                            /* "ax,ax," */
extern char STR_COMM[];                             /* "\tcomm\t" */
extern char STR_FAR_3[];                            /* "far " */
extern char STR_NEAR_4[];                           /* "near " */
extern char STR_COMM_2[];                           /* "\t$comm\t" */
extern char STR_FAR_4[];                            /* "far," */
extern char STR_NEAR_5[];                           /* "near," */
extern char STR_BYTE[];                             /* "\rbyte" */
extern char STR_WORD[];                             /* "word" */
extern char STR_FAR_2[];                            /* "far" */
extern char STR_SEGMENT[];                          /* "\tsegment " */
extern char STR_PARA[];                             /* "para" */
extern char STR_PUBLIC[];                           /* " public " */
extern char STR_CRLF_3[];                           /* "\r\n" */
extern char STR_SEGMENT_VIRTUAL[];                  /* "\tsegment\tvirtual\r\n" */
extern char STR_DB_2[];                             /* "\tdb\t" */
extern char STR_DUP_0[];                            /* " dup (0)\r\n" */
extern char STR_DUP[];                              /* " dup (?)\r\n" */
extern char STR_ASSUME_CS[];                        /* "\tassume\tcs:" */
extern char STR_PROC[];                             /* "\tproc\t" */
extern char STR_NEAR_2[];                           /* "near" */
extern char STR_LABEL[];                            /* "\tlabel\t" */
extern char STR_DW_2[];                             /* "\tdw\t" */
extern char STR_DD[];                               /* "\tdd\t" */
extern char STR_C_5[];                              /* "@C" */
extern char STR_LABEL_WORD[];                       /* "\tlabel\tword\r\n" */
extern char STR_FIARQQ[];                           /* "FIARQQ" */
extern char STR_FJARQQ[];                           /* "FJARQQ" */
extern char STR_FIERQQ[];                           /* "FIERQQ" */
extern char STR_FISRQQ[];                           /* "FISRQQ" */
extern char STR_FJSRQQ[];                           /* "FJSRQQ" */
extern char STR_FICRQQ[];                           /* "FICRQQ" */
extern char STR_FJCRQQ[];                           /* "FJCRQQ" */
extern char STR_FIDRQQ[];                           /* "FIDRQQ" */

/* Strings the code reaches by address (names made from their text by
   tools/namestrings.py; the original passes their DS offsets). */
extern char STR_RPAREN[];                           /* ")" */
extern char STR_SEG[];                              /* "seg " */
extern char STR_BYTE_2[];                           /* "byte" */
extern char STR_QWORD[];                            /* "qword" */
extern char STR_DWORD[];                            /* "dword" */
extern char STR_TBYTE[];                            /* "tbyte" */
extern char STR_FAR_5[];                            /* "far" */
extern char STR_NEAR_6[];                           /* "near" */

extern signed char REGISTER_NEED_TABLE[];           /* register need by operator class (x21) and value kind */
extern char STR_END_CRLF_EOF[];                     /* "\tend\r\n\x1a" */

#endif

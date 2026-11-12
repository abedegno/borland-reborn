/* OVL.H: functions of the ovl sources shared with other files: one
   prototype each, written as its definition is (the defining source on each line).
   Generated during the readability pass. */
#ifndef OVL_H
#define OVL_H
unsigned int far pascal TYPE_BUILD(unsigned int scope,unsigned int type,unsigned int name,unsigned int kind); /* FUNCDECL.C */
unsigned int far pascal DEFINE_SEGMENT_FIXED_ID(unsigned int value1,unsigned int value2,unsigned int value3,unsigned int value4); /* OBJSEGS.C */
long far pascal CURRENT_SEGMENT_SIZE(void);                                    /* OBJSEGS.C */
unsigned char far pascal TYPES_COMPATIBLE(unsigned int first, unsigned int second,unsigned int mode); /* TYPESIZE.C */
unsigned int far pascal MAKE_POINTER_TYPE(unsigned int type, unsigned int kind,unsigned char reference); /* TYPESIZE.C */
unsigned int far pascal TYPE_ALIGNMENT(unsigned int type);                    /* TYPESIZE.C */
long far pascal TYPE_SIZE(unsigned int type);                            /* TYPESIZE.C */
unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int node, unsigned int value); /* ACCESS.C */
unsigned char far pascal SYMBOL_ACCESSIBLE(unsigned int value1,unsigned int value2); /* ACCESS.C */
unsigned int far pascal GET_BASE_OFFSET(unsigned int left,unsigned int right); /* BASECONV.C */
unsigned char far pascal IS_OBJECT_RVALUE(unsigned int node);                  /* BASECONV.C */
void far pascal COMPILE_CONSTRUCTOR(void);                                         /* CTORBODY.C */
void far pascal COMPILE_DESTRUCTOR(void);                                         /* CTORBODY.C */
unsigned int far pascal CHECK_INITIALIZATION(unsigned int node);                    /* EXPRCHK.C */
unsigned int far pascal CHECK_MULTIPLICATIVE_OP(unsigned int node,unsigned int mode, unsigned int type,unsigned int hint); /* EXPRCHK.C */
unsigned int far pascal CHECK_COMPOUND_ASSIGNMENT(unsigned int node,unsigned int mode,unsigned int hint); /* EXPRCHK.C */
unsigned int far pascal CHECK_SUBTRACTION(unsigned int node,unsigned int mode,unsigned int type); /* EXPRCHK.C */
unsigned int far pascal CHECK_INTEGRAL_OP(unsigned int node,unsigned int mode);  /* EXPRCHK.C */
unsigned int far pascal CHECK_SUBSCRIPT(unsigned int node,unsigned int mode);  /* EXPRCHK.C */
unsigned int far pascal CHECK_DOT_MEMBER(unsigned int node,unsigned char mode); /* EXPRCHK.C */
unsigned int far pascal CHECK_POINTER_INDIRECTION(unsigned int node,unsigned int mode,unsigned int kind); /* EXPRCHK.C */
unsigned int far pascal CHECK_COMPARISON(unsigned int node,unsigned int mode);  /* EXPRCHK.C */
unsigned int far pascal CHECK_LOGICAL_OP(unsigned int node,unsigned int mode);  /* EXPRCHK.C */
unsigned int far pascal CHECK_RETURN_VALUE(unsigned int node);                    /* EXPRCHK.C */
unsigned int far pascal CHECK_ADDITION(unsigned int node,unsigned int mode,unsigned int kind); /* EXPRCHK.C */
unsigned int far pascal CHECK_ASSIGNMENT(unsigned int node);                    /* EXPRCHK.C */
void far pascal PARSE_STATEMENT_LIST(void);                                         /* STMTCPP.C */
void far pascal CHECK_UNDEFINED_LABELS(void);                                         /* STMTCPP.C */
void far pascal PARSE_FUNCTION_BODY(void);                                         /* STMTCPP.C */
void far pascal RELEASE_SCOPE_OBJECTS(unsigned int marker);                          /* STMTCPP.C */
int far pascal LOG2_POWER_OF_TWO(unsigned long value);                      /* CONSTFLD.C */
void far pascal TRY_PCH_LOAD(void);                                        /* PCH.C */
void far pascal REPORT_PRAGMA_ERROR(unsigned int error,char far *name);       /* PREPROC.C */
unsigned int far pascal BUILD_SPECIAL_MEMBER_BODY(unsigned int node);                   /* SPECMEMB.C */
void far pascal FLUSH_PENDING_INITIALIZERS(unsigned char partial);                        /* CPPFINAL.C */
void far pascal PROCESS_DEFERRED_DECLS(void);                                         /* CPPFINAL.C */
unsigned int far pascal BCC_SYMBOL_CREATE(char far *text,unsigned int value); /* NAMEPOOL.C */
char far * far pascal MANGLE_MEMBER_NAME(unsigned int member);               /* MANGLE.C */
char far * far pascal MANGLE_SYMBOL_NAME(unsigned int symbol);                    /* MANGLE.C */
unsigned int far pascal ADD_CV_QUALIFIERS(unsigned int type,unsigned char second, unsigned char first); /* DECLSPEC.C */
void far pascal EMIT_HUGE_DATA(unsigned int symbol);                    /* HUGEDATA.C */
unsigned int far pascal DEFINE_HUGE_DATA_SEGMENTS(unsigned int type);           /* HUGEDATA.C */
void far pascal NEXT_DATA_BANK(unsigned char advance);                        /* HUGEDATA.C */
void far pascal EMIT_DATA_SPANS(long remaining,unsigned char advance);         /* HUGEDATA.C */
unsigned int far pascal BEGIN_ARRAY_DATA(unsigned int symbol);                  /* HUGEDATA.C */
unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *output,unsigned int operation,unsigned int context); /* CPPCALL.C */
unsigned char far pascal TRY_UNARY_OPERATOR_CALL(unsigned int far *output,unsigned int operation,unsigned int context); /* CPPCALL.C */
int far pascal LEX_NEXT_TOKEN(void);                                     /* LEXER.C */
int far pascal NAME_VALIDATE(char far *text);                          /* LEXER.C */
int far pascal NEXT_POOL_CHARACTER(int reset);                                     /* LEXER.C */
unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int expression);              /* CPPCAST.C */
unsigned int far pascal CAST_EXPRESSION(unsigned int expression,unsigned int context); /* CPPCAST.C */
unsigned int far pascal ANALYZE_TEMP_OBJECT_NODE(unsigned int expression,unsigned int context); /* CPPCAST.C */
unsigned int far pascal RESOLVE_SYMBOL_NODE(unsigned int expression,unsigned int type); /* CPPCAST.C */
unsigned int far pascal ANALYZE_DELETE_EXPRESSION(unsigned int node);                    /* CPPEXPCK.C */
unsigned int far pascal ANALYZE_NEW_EXPRESSION(unsigned int node);                    /* CPPEXPCK.C */
unsigned int far pascal ANALYZE_DOT_STAR(unsigned int node);                    /* CPPEXPCK.C */
unsigned int far pascal PARSE_ASSIGNMENT_EXPR(unsigned int stop);                    /* OPPREC.C */
void far pascal RESET_EXPR_PARSER(void);                                         /* OPPREC.C */
unsigned int far pascal PARSE_ARGUMENT_LIST(unsigned int flag);                    /* OPPREC.C */
unsigned int far pascal JOIN_COMMA_EXPR(unsigned int left,unsigned int right); /* EXPRPOOL.C */
unsigned int far pascal MAKE_UNARY_NODE(unsigned int op,unsigned int operand); /* EXPRPOOL.C */
unsigned int far pascal CREATE_TEMP_SYMBOL(unsigned int type,unsigned char global); /* EXPRPOOL.C */
unsigned int far pascal REPORT_EXPR_ERROR(unsigned int code,char far *first,long second, unsigned int node); /* EXPRPOOL.C */
unsigned int far pascal COPY_EXPR_TREE(unsigned int expression);         /* EXPRPOOL.C */
void far pascal FREE_EXPR_NODE(unsigned int node);                       /* EXPRPOOL.C */
unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int value);              /* EXPRPOOL.C */
unsigned int far pascal MAKE_CAST_NODE(unsigned int type,unsigned int operand); /* EXPRPOOL.C */
unsigned int far pascal MAKE_CALL_NODE(unsigned int value,unsigned int a5,unsigned int a4, unsigned int a3,unsigned int a2,unsigned int a1); /* EXPRPOOL.C */
unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int symbol);             /* EXPRPOOL.C */
unsigned int far pascal MAKE_LIST_NODE(unsigned int item,unsigned int next); /* EXPRPOOL.C */
unsigned int far pascal MAKE_BINARY_NODE(unsigned int op,unsigned int left,unsigned int right); /* EXPRPOOL.C */
unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int type);               /* EXPRPOOL.C */
unsigned int far pascal MAKE_INT_CONSTANT(unsigned int type,long value);    /* EXPRPOOL.C */
unsigned char far pascal IS_LVALUE(unsigned int expression);        /* EXPRPOOL.C */
unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int code,unsigned int node); /* EXPRPOOL.C */
unsigned char far pascal C7_TYPE_COMPAT(unsigned int left,unsigned int right, unsigned char strict); /* EXPRPOOL.C */
void far pascal FREE_EXPR_TREE(unsigned int node);                            /* EXPRPOOL.C */
unsigned int far pascal CHECK_NULL_CONSTANT(unsigned int expression,unsigned char far *zero); /* EXPRPOOL.C */
unsigned int far pascal ALLOC_EXPR_NODE(void);                                 /* EXPRPOOL.C */
unsigned int far pascal BUILD_SYMBOL_EXPR(unsigned int symbol);                  /* EXPRPOOL.C */
void far pascal CLEAR_PREPARED_FLAGS(unsigned int record,unsigned int bits);   /* CPPSCOPE.C */
unsigned int far pascal BCC_TYPE_CREATE(unsigned int name,unsigned int kind); /* CPPSCOPE.C */
void far pascal C0MARK(unsigned char both);                            /* CPPSCOPE.C */
unsigned int far pascal C9_ALLOC_MEMBER(unsigned int kind);            /* CPPSCOPE.C */
unsigned int far pascal ALLOC_FORMAL_RECORD(void);                  /* CPPSCOPE.C */
void far pascal C9_CLEAR_MEMBER_TABLES(void);                          /* CPPSCOPE.C */
unsigned int far pascal LIST_CONS_ALT(unsigned int next,unsigned int value); /* CPPSCOPE.C */
unsigned int far pascal CREATE_TYPE(unsigned int kind);                    /* CPPSCOPE.C */
unsigned int far pascal DECLARE_GLOBAL_SYMBOL(char far *name,unsigned int type,unsigned int value,unsigned int extra); /* CPPSCOPE.C */
unsigned int far pascal FIND_NAME_IN_LIST(unsigned int name,unsigned int list);  /* CPPSCOPE.C */
void far pascal POP_SCOPE(unsigned char leaving);                        /* CPPSCOPE.C */
unsigned int far pascal PREPARE_SYMBOL(unsigned int symbol);                  /* CPPSCOPE.C */
unsigned int far pascal GET_PREPARED_SYMBOL(unsigned int record);                  /* CPPSCOPE.C */
unsigned int far pascal FIND_EQUIVALENT_TYPE(unsigned int type);                    /* CPPSCOPE.C */
unsigned int far pascal TOKEN_FROM_NAME(unsigned int name);                    /* CPPSCOPE.C */
void far pascal SET_PREPARED_FLAGS(unsigned int record,unsigned int bits);        /* CPPSCOPE.C */
unsigned int far pascal GET_PREPARED_FLAGS(unsigned int record);                  /* CPPSCOPE.C */
unsigned int far pascal DECLARE_MEMBER(unsigned int name,unsigned int kind);  /* CPPSCOPE.C */
void far pascal LIST_CELL_FREE(unsigned int cell);                            /* CPPSCOPE.C */
void far pascal SET_TYPE_DEBUG_ID(unsigned int type,unsigned int value);         /* CPPSCOPE.C */
unsigned int far pascal ALLOC_LABEL_RECORD(void);                                 /* CPPSCOPE.C */
unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int name,unsigned int kind);  /* CPPSCOPE.C */
unsigned int far pascal ALLOC_SCOPE(void);                                 /* CPPSCOPE.C */
unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int name,unsigned int type);  /* CPPSCOPE.C */
unsigned int far pascal LOOKUP_NAME(unsigned int name);                    /* CPPSCOPE.C */
unsigned int far pascal LIST_CONS(unsigned int next,unsigned int value); /* CPPSCOPE.C */
void far pascal PUSH_SCOPE(unsigned char kind);                           /* CPPSCOPE.C */
unsigned int far pascal BUILD_VBASE_ADDRESS(unsigned int tree,int offset,unsigned int type); /* CPPCTOR.C */
unsigned int far pascal BUILD_BASE_INITS(unsigned char adjust,unsigned int keys); /* CPPCTOR.C */
unsigned int far pascal FIND_COPY_CTOR(unsigned int type,unsigned char any); /* CPPCTOR.C */
unsigned int far pascal BUILD_VBASE_INITS(unsigned int context,unsigned int keys); /* CPPCTOR.C */
unsigned int far pascal REGISTER_TEMP_DESTRUCTOR(unsigned int tree,unsigned int type,unsigned int next); /* CPPCTOR.C */
unsigned char far pascal IS_BASE_CLASS(unsigned int derived,unsigned int base, unsigned char strict); /* CPPCTOR.C */
unsigned int far pascal BUILD_BASE_ADDRESS(unsigned int tree,int offset,unsigned int type); /* CPPCTOR.C */
unsigned int far pascal BUILD_MEMBER_INITS(unsigned int keys);               /* CPPCTOR.C */
unsigned int far pascal COLLECT_VBASES(unsigned int type);               /* CPPCTOR.C */
void far pascal FREE_PARAM_ITEM(unsigned int param);                      /* CPPCTOR.C */
unsigned int far pascal BUILD_VPTR_INITS(unsigned int context,unsigned int type); /* CPPCTOR.C */
unsigned int far pascal BCC_MEMBER_LOOKUP(unsigned int type);          /* CPPCTOR.C */
unsigned int far pascal CREATE_PARAM_RECORD(unsigned int type,unsigned int flags,unsigned int kind); /* CPPCTOR.C */
void far pascal FREE_TEMP_ENTRY(unsigned int node);                            /* CPPCTOR.C */
unsigned int far pascal ALLOC_TEMP_ENTRY(void);                                 /* CPPCTOR.C */
unsigned char far pascal SAME_SIGNATURE(unsigned int left,unsigned int right); /* CPPCTOR.C */
unsigned int far pascal COPY_PARAM_QUALIFIERS(unsigned int kind,unsigned int type);  /* CPPCTOR.C */
unsigned int far pascal ALLOC_INIT_ENTRY(unsigned int key);                     /* CPPCTOR.C */
unsigned int far pascal BUILD_THIS_NODE(unsigned int symbol);                  /* CPPCTOR.C */
void far pascal ADD_THIS_PARAMETER(unsigned int value,unsigned int type);         /* CPPCTOR.C */
unsigned int far pascal FIND_DEFAULT_CTOR(unsigned int type,unsigned char any);  /* CPPCTOR.C */
void far pascal QUEUE_DEFERRED_SYMBOL(unsigned int symbol);                          /* CPPCTOR.C */
unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int from,unsigned int to);    /* CPPCTOR.C */
void far pascal ADD_HIDDEN_PARAMETER(unsigned int type,unsigned int kind);          /* CPPCTOR.C */
unsigned int far pascal BUILD_THIS_ALLOC_IF_NULL(unsigned int symbol,unsigned int type); /* CPPCTOR.C */
unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *pool,unsigned int size); /* POOLS.C */
unsigned int far pascal POOL_ALLOC(unsigned int far *pool,unsigned int size); /* POOLS.C */
void far pascal POOL_FREE_ITEM(unsigned int far *pool,unsigned int item);     /* POOLS.C */
int far pascal COMPILE_ONE_FILE(char far *name);                           /* OPTIONS.C */
int far pascal APPLY_OPTION(char far *argument,unsigned int pass);     /* OPTIONS.C */
void far pascal SAVE_WARNINGS_AS_DEFAULT(void);                                         /* OPTIONS.C */
void far pascal RESET_WARNINGS_TO_DEFAULT(void);                                         /* OPTIONS.C */
unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int expr,unsigned char mode); /* SIMPLIFY.C */
unsigned int far pascal MAKE_INITIALIZED_TEMP(unsigned int expression);              /* MEMBPTR.C */
unsigned int far pascal MAKE_MEMBER_POINTER(unsigned int expression,unsigned char fresh); /* MEMBPTR.C */
unsigned int far pascal FIND_NAMED_FUNCTION_PREPARED(unsigned int allow_parameters);        /* CPPIFEXP.C */
int far pascal EVAL_CONSTANT_CONDITION(void);                                          /* CPPIFEXP.C */
char far * far pascal MEMBER_NAME_TEXT(unsigned int member);               /* DIAG.C */
char far * far pascal NAME_TEXT_COPY(unsigned int name);                  /* DIAG.C */
void far pascal SKIP_TO_SYNC_TOKEN(unsigned int token);                           /* DIAG.C */
void far pascal SKIP_BRACE_GROUP(void);                                         /* DIAG.C */
void far pascal REPORT_DIAGNOSTIC_LINE(int code,long first,long second);              /* DIAG.C */
void far pascal REPORT_NAME_DIAGNOSTIC(int code,unsigned int name);                   /* DIAG.C */
void far pascal REPORT_CURRENT_TOKEN(int code);                                     /* DIAG.C */
void far pascal REPORT_DIAGNOSTIC(int code,long first,long second);              /* DIAG.C */
char far * far pascal SYMBOL_NAME_TEXT(unsigned int symbol);                    /* DIAG.C */
void far pascal REPORT_DIAGNOSTIC_AT(int code,long first,long second, unsigned int line,unsigned int column); /* DIAG.C */
void far pascal COMPILE_INLINE_BODY(unsigned int symbol,unsigned char enabled);    /* INLINEBD.C */
void far pascal RECORD_INLINE_BODY(unsigned int symbol);                          /* INLINEBD.C */
void far pascal END_FUNCTION_BODY(void);                                         /* FUNCDEF.C */
void far pascal BEGIN_FUNCTION_BODY(unsigned int owner,unsigned int function);     /* FUNCDEF.C */
void far pascal DECLARE_HIDDEN_RETURN_PARAM(unsigned int type,unsigned char existing);     /* FUNCDEF.C */
void far pascal DECLARE_PARAMETERS(unsigned int parameter,unsigned char existing); /* FUNCDEF.C */
unsigned char far pascal BCC_PARSE_BEGIN(unsigned int kind);           /* TOKSTRM.C */
void far pascal BCC_PARSE_POP(unsigned int kind);                      /* TOKSTRM.C */
void far pascal BCC_PARSE_PUSH(unsigned int kind);                     /* TOKSTRM.C */
void far pascal STREAM_PUT_END(unsigned int stream);                          /* TOKSTRM.C */
void far pascal STREAM_CREATE(unsigned int far *destination,unsigned int existing); /* TOKSTRM.C */
void far pascal STREAM_PATCH_LITERAL(void);                                         /* TOKSTRM.C */
void far pascal STREAM_SEEK(unsigned int stream,int position);             /* TOKSTRM.C */
int far pascal STREAM_TELL(unsigned int stream);                           /* TOKSTRM.C */
void far pascal STREAM_COPY_STATE(unsigned int destination,unsigned int source); /* TOKSTRM.C */
int far pascal READ_STREAM_CHAR(void);                                          /* TOKSTRM.C */
void far pascal CONSTRUCT_ARRAY_ELEMENTS(long count,unsigned int symbol,unsigned int type, long far *cursor,unsigned char forbidden,unsigned char unused); /* CPPINIT.C */
void far pascal QUEUE_INIT_EXPR(unsigned int expression);                      /* CPPINIT.C */
unsigned char far pascal BCC_PARSE_QUERY(void);                        /* LOOKAHD.C */
unsigned char far pascal SKIP_BALANCED_TOKENS(unsigned int mask,unsigned int opening, unsigned int closing); /* LOOKAHD.C */
unsigned char far pascal SCAN_DECLARATOR(unsigned int mode);                   /* LOOKAHD.C */
unsigned char far pascal IS_PAREN_TYPE_NAME(unsigned int mode);                   /* LOOKAHD.C */
unsigned char far pascal SCAN_TYPE_SPECIFIERS(void);                                /* LOOKAHD.C */
long far pascal SPELL_SYMBOL_WITH_TYPE(unsigned int symbol,unsigned int type); /* TYPESPEL.C */
long far pascal LINKAGE_NAME(unsigned int language);                /* TYPESPEL.C */
long far pascal FORMAT_SPECIAL_MEMBER(unsigned int kind,unsigned int reference,unsigned int type); /* TYPESPEL.C */
long far pascal CLASS_NAME_OF_TYPE(unsigned int type);                       /* TYPESPEL.C */
char far * far pascal REQUIRED_TYPE_TEXT(unsigned int category);                  /* TYPESPEL.C */
char far * far pascal FORMAT_MEMBER_NAME(unsigned int name,unsigned int kind, unsigned int type,unsigned int member_type); /* TYPESPEL.C */
char far * far pascal FORMAT_CALL_SIGNATURE(unsigned int expression,unsigned int owner); /* TYPESPEL.C */
char far * far pascal FORMAT_SYMBOL(unsigned int symbol);                    /* TYPESPEL.C */
long far pascal FORMAT_MEMBER(unsigned int member);                          /* TYPESPEL.C */
long far pascal FORMAT_TYPE(unsigned int type);                            /* TYPESPEL.C */
void far pascal INIT_SCALAR(unsigned int symbol,unsigned int type,long far *position, unsigned int expression); /* INITLIST.C */
void far pascal INIT_OBJECT(unsigned int symbol,unsigned int type, long far *position,unsigned char advance,unsigned char empty); /* INITLIST.C */
void far pascal PLACE_BITFIELD_MEMBER(int requested_width,long far *total,int far *bits,int far *offset,int far *shift); /* FLDPLACE.C */
void far pascal PLACE_STRUCT_MEMBER(long size,long far *total,int far *bits,int far *offset); /* FLDPLACE.C */
unsigned int far pascal MAKE_RETURN_SLOT(unsigned int symbol);                  /* FLDPLACE.C */
unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int expression,unsigned int mask,unsigned int desired); /* OVERLOAD.C */
unsigned int far pascal FIND_USER_CONVERSION(unsigned int desired,unsigned int type,unsigned char exact,unsigned int line,unsigned int column); /* OVERLOAD.C */
unsigned int far pascal FIND_MATCHING_OVERLOAD(unsigned int head,unsigned int type);  /* OVERLOAD.C */
unsigned int far pascal SELECT_OVERLOAD(unsigned int expression,unsigned int first,unsigned int second,unsigned int mask); /* OVERLOAD.C */
unsigned int far pascal LOWER_EXPRESSION(unsigned int expression);              /* LOWEREXP.C */
unsigned int far pascal EXPR_BANK_MARK(void);                                 /* EXPRPACK.C */
void far pascal EXPR_BANK_RESET(unsigned int position);                        /* EXPRPACK.C */
unsigned int far pascal PACK_EXPR_TREE(unsigned int expression);              /* EXPRPACK.C */
unsigned int far pascal UNPACK_EXPR_TREE(unsigned int record);                  /* EXPRPACK.C */
void far pascal PEEK_TOKEN(void);                                         /* TOKADV.C */
void far pascal ADVANCE_TOKEN(void);                                         /* TOKADV.C */
int far pascal NEXT_LITERAL_CHAR(unsigned int mode);                             /* TOKADV.C */
int far pascal BCC_SYMBOL_CURRENT_TEST(void);                          /* MACROS.C */
unsigned int far pascal MACRO_DEFINE(char far *name,char far *replacement, signed char flag,unsigned int list); /* MACROS.C */
int far pascal MACRO_DEFINED(char far *text);                          /* MACROS.C */
unsigned int far pascal MACRO_LOOKUP(unsigned int offset);             /* MACROS.C */
void far pascal MACRO_REMOVE(char far *text);                          /* MACROS.C */
unsigned int far pascal ANALYZE_COMMA_EXPR(unsigned int node,unsigned int mode,unsigned int leaf_mode); /* COMMAEXP.C */
void far pascal RUN_LINKER(int count,char far * far *arguments); /* DRVLINK.C */
void far pascal EXPAND_RESPONSE_FILES(int far *count,char far * far * far *arguments); /* DRVLINK.C */
void far pascal FATAL_EXIT(int error);                           /* DRVLINK.C */
void far pascal BCC_STRING_FILE_APPEND(char far *path);                /* DRVLINK.C */
void far pascal PROCESS_FILE_ARGUMENT(char far *path);                /* DRVLINK.C */
void far pascal NESTING_CHECK(void);                                   /* DRVLINK.C */
void far pascal PATH_PROCESS(char far *path,unsigned int remove_original,unsigned int mode); /* DRVLINK.C */
char far * far pascal ADD_DEFAULT_EXTENSION(char far *first,char far *second); /* DRVLINK.C */
unsigned int far pascal DEFINE_FAR_SEGMENT(void);                            /* SEGNAMES.C */
unsigned int far pascal BCC_INTERN_STRING(char far *text);             /* SEGNAMES.C */
void far pascal ADD_STARTUP_ENTRY(unsigned int first,unsigned int second);       /* SEGNAMES.C */
void far pascal ADD_EXIT_ENTRY(unsigned int first,unsigned int second);       /* SEGNAMES.C */
char far * far pascal READ_CONFIG_AND_ARGS(int argc,char far * far *argv); /* CONFIG.C */
unsigned int far pascal BCC_NODE_BINARY(signed char kind,unsigned int type,unsigned int left,unsigned int right); /* EXPRNOD2.C */
unsigned int far pascal BCC_NODE_CONVERT(unsigned int node);           /* EXPRNOD2.C */
unsigned int far pascal BCC_NODE_INTEGER(unsigned int type,long value); /* EXPRNOD2.C */
unsigned int far pascal BCC_NODE_MODE(signed char kind,unsigned int type,unsigned int left,unsigned int right,signed char mode); /* EXPRNOD2.C */
unsigned int far pascal NEW_BITFIELD_NODE_ALT(unsigned int left,unsigned int type,unsigned char first,unsigned char second); /* EXPRNOD2.C */
void far pascal BCC_NODE_RESET(void);                                  /* EXPRNOD2.C */
unsigned int far pascal EXPAND_COMPOUND_ASSIGN_ALT(unsigned int node);           /* EXPRNOD2.C */
int far pascal TREE_HAS_SIDE_EFFECTS_ALT(unsigned int node);                       /* EXPRNOD2.C */
unsigned int far pascal ANALYZE_CALL(unsigned int expression,unsigned int other); /* CALLCHK.C */
unsigned int far pascal BUILD_LOGICAL_NOT(unsigned int expression,unsigned int context); /* UNARYOP.C */
unsigned int far pascal BUILD_DEREF(unsigned int expression,unsigned int context, unsigned char keep); /* UNARYOP.C */
unsigned int far pascal BUILD_ADDRESS_OF(unsigned int expression,unsigned int context, unsigned int policy); /* UNARYOP.C */
unsigned int far pascal BUILD_UNARY_ARITH(unsigned int expression,unsigned int context, unsigned int hint); /* UNARYOP.C */
unsigned int far pascal BUILD_INCDEC(unsigned int expression,unsigned int context); /* UNARYOP.C */
unsigned int far pascal BUILD_COMPLEMENT(unsigned int expression,unsigned int context, unsigned int hint); /* UNARYOP.C */
void far pascal EMIT_ZERO_BYTES(unsigned int count);                   /* STMTBLK.C */
void far pascal SET_STREAM(unsigned int value);                      /* STMTBLK.C */
unsigned int far pascal SELECT_SYMBOL_STREAM(unsigned int symbol);             /* STMTBLK.C */
void far pascal APPEND_SCOPE_ENTER_BLOCK(void);                                         /* STMTBLK.C */
void far pascal SPLICE_STATEMENT_CHAIN(unsigned int chain,unsigned int parent);       /* STMTBLK.C */
void far pascal REGISTER_SYMBOL_VARIABLE(unsigned int symbol);                          /* STMTBLK.C */
unsigned int far pascal NEW_LABEL_IF_ENABLED(void);                                 /* STMTBLK.C */
void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int value);                           /* STMTBLK.C */
void far pascal EMIT_CONST_INIT_VALUE(unsigned int node);                            /* STMTBLK.C */
void far pascal FINISH_FUNCTION_STATE(void);                                         /* STMTBLK.C */
void far pascal APPEND_SCOPE_EXIT_BLOCK(void);                                         /* STMTBLK.C */
void far pascal START_FUNCTION_STATE(void);                                         /* STMTBLK.C */
void far pascal EMIT_BYTE_IF_ENABLED(unsigned char code);                           /* STMTBLK.C */
void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int node);                            /* STMTBLK.C */
unsigned int far pascal ANALYZE_EXPRESSION(unsigned int expression,unsigned int type,unsigned int context); /* EXPRDISP.C */
unsigned int far pascal RESOLVE_SYMBOL_REFERENCE(unsigned int expression,unsigned int type); /* EXPRDISP.C */
unsigned int far pascal ANALYZE_AND_DECAY(unsigned int expression,unsigned int type); /* EXPRDISP.C */
unsigned int far pascal CHECK_CAST(unsigned int expression);         /* CONVERT.C */
unsigned int far pascal MAKE_ADDRESS_OF(unsigned int node);               /* CONVERT.C */
unsigned int far pascal BALANCE_BINARY_OPERANDS(unsigned int requested,unsigned int expression); /* CONVERT.C */
unsigned int far pascal MAKE_DEREFERENCE(unsigned int node);                    /* CONVERT.C */
unsigned char far pascal IS_MODIFIABLE_NODE(unsigned int node);                   /* CONVERT.C */
unsigned int far pascal DECAY_TO_POINTER(unsigned int node);                    /* CONVERT.C */
unsigned int far pascal APPLY_BASED_POINTER(unsigned int node);                    /* CONVERT.C */
unsigned int far pascal CONVERT_TO_RVALUE(unsigned int node);                    /* CONVERT.C */
unsigned int far pascal NODE_ENUM_TO_INT(unsigned int node);                    /* CONVERT.C */
unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int target,unsigned int expression,unsigned int mode); /* CONVERT.C */
unsigned int far pascal FIND_NODE_BY_SERIAL(unsigned int key);                    /* SRCSEGS.C */
void far pascal SET_FUNCTION_SYMBOL_TYPE(unsigned int record,unsigned int scope, unsigned int type,unsigned int token); /* EXTDECL.C */
long far pascal FILE_TIME(char far *path);                             /* FILETIME.C */
#endif

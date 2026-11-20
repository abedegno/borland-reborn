/* DATA.H: the compiler's global data in DGROUP, one declaration per item, in
   address order.  The storage is the initialized data segment
   (linkgroups/CB0B4.ASM); the names are absolute DS equates (symbols.tsv).
   Items that sources declare in different ways (different views of the same
   bytes) are declared in each source as it compiled, not here.
   Generated during the readability pass. */
#ifndef DATA_H
#define DATA_H
extern unsigned int HEAP_START_SEG;                     /* DS:0004 */
extern unsigned int HEAP_END_SEG;                     /* DS:0008 */
extern unsigned int PROGRAM_PSP;                    /* DS:0016 */
extern unsigned char DOS_HOST_MODE;                    /* DS:001A */
extern unsigned int EXTENDER_HEAP_TOP;                     /* DS:001B */
extern unsigned int EXTENDER_BASE;                  /* DS:001D */
extern char STR_BORLAND_C_VERSION_2_0[];                            /* DS:0020 */
extern char STR_AVAILABLE_MEMORY[];                            /* DS:0064 */
extern char STR_SYNTAX_IS_BCC_OPTIONS[];                            /* DS:007E */
extern char STR_ASM[];                            /* DS:069C */
extern char STR_OBJ[];                            /* DS:06A1 */
extern unsigned int SWAP_FILE_PREPARED;                 /* DS:06BE */
extern unsigned char HEAP_DEFAULT_OWNER_TAG;                   /* DS:06C0 */
extern unsigned int HEAP_SAVED_TOP_KEY;                     /* DS:06C4 */
extern unsigned char HANDLE_RING_NEWEST;             /* DS:06C6 */
extern unsigned char HANDLE_RING_TAG_CURSOR;                   /* DS:06C7 */
extern unsigned char HANDLE_RING_UNTAG_CURSOR;                   /* DS:06C8 */
extern unsigned int HEAP_DESCRIPTOR_SEGMENTS[];     /* DS:06CA */
extern unsigned int OWNER_TAG_BITMAP[16];            /* DS:06DA */
extern unsigned char HEAP_CPU_TYPE;                 /* DS:06FA */
extern char near POINTER_TEXT[];                    /* DS:071E */
extern char near STR_STATIC_VARIABLES[];                       /* DS:0726 */
extern char near STR_FRIEND[];                       /* DS:0737 */
extern char near STR_VIRTUAL[];                       /* DS:073E */
extern char near STR_GOTO[];                       /* DS:0746 */
extern char near STR_IF[];                       /* DS:074B */
extern char near STR_SWITCH[];                       /* DS:074E */
extern char near STR_WHILE[];                       /* DS:0755 */
extern char near STR_DO_WHILE[];                       /* DS:075B */
extern char near STR_FOR[];                       /* DS:0764 */
extern unsigned char near EXPR_OP_FLAGS[];             /* DS:0768 */
extern unsigned int near TYPE_FLAGS[];              /* DS:07B3 */
extern unsigned char WARNING_SWITCH_TABLE[];                  /* DS:08B9 */
extern unsigned char EXPR_FLAGS[];                  /* DS:09CA */
extern unsigned char near C9_TYPE_SIZES[];          /* DS:0B9C */
extern unsigned char near C18_OPERATOR_TOKENS[];    /* DS:0BD5 */
extern char near STR___EMIT__[];                    /* DS:0CD7 */
extern char near STR_S_2[];                    /* DS:0CE0 */
extern char near STR_MAIN_2[];                    /* DS:0CE3 */
extern char near STR__SETARGV__[];                    /* DS:0CE8 */
extern char near STR___SETARGV__[];                    /* DS:0CF3 */
extern char near STR__SETENVP__[];                    /* DS:0CFF */
extern char near STR___SETENVP__[];                    /* DS:0D0A */
extern char near STR_NEW[];                    /* DS:0D16 */
extern char near STR__VECTOR_NEW_[];                    /* DS:0D1A */
extern char near STR__VECTOR_VNEW_[];                    /* DS:0D27 */
extern char near STR_DELETE[];                    /* DS:0D35 */
extern char near STR__VECTOR_DELETE_[];                    /* DS:0D3C */
extern char near STR__VECTOR_APPLY_[];                    /* DS:0D4C */
extern char near STR__VECTOR_VAPPLY_[];                    /* DS:0D5B */
extern char near STR__FPURE_ERROR_[];                    /* DS:0D6B */
extern char near STR__NPURE_ERROR_[];                    /* DS:0D79 */
extern char near STR_FAR_FUNC[];                    /* DS:0D87 */
extern char near STR_NEAR_FUNC[];                    /* DS:0D90 */
extern char near STR_DELTA[];                    /* DS:0D9A */
extern char near STR_VINDEX[];                    /* DS:0DA0 */
extern char near STR_OFFSET[];                    /* DS:0DA7 */
extern char near STR_PAD[];                    /* DS:0DAE */
extern char near STR_EMPTY_2[];                   /* DS:0DB2 */
extern char near STR__STCON_[];                   /* DS:0DB4 */
extern char near STR__STDES_[];                   /* DS:0DBC */
extern char near STR_VSF[];                   /* DS:0DC4 */
extern char near STR_VSN[];                   /* DS:0DC9 */
extern char near STR_QUEST[];                   /* DS:0E2A */
extern char near STR_ADD[];                   /* DS:0E74 */
extern char near STR_SUB[];                   /* DS:0E78 */
extern char near STR_MUL[];                   /* DS:0E7C */
extern char near STR_DIV[];                   /* DS:0E80 */
extern char near STR_MOD[];                   /* DS:0E84 */
extern char near STR_X[];                   /* DS:0E88 */
extern char near STR_OR[];                   /* DS:0E89 */
extern char near STR_AND[];                   /* DS:0E8C */
extern char near STR_CMP[];                   /* DS:0E90 */
extern char near STR_ASG[];                   /* DS:0E94 */
extern char near STR_LSS[];                   /* DS:0E98 */
extern char near STR_GTR[];                   /* DS:0E9C */
extern char near STR_RPLU[];                   /* DS:0EA0 */
extern char near STR_RMIN[];                   /* DS:0EA5 */
extern char near STR_RMUL[];                   /* DS:0EAA */
extern char near STR_RDIV[];                   /* DS:0EAF */
extern char near STR_RMOD[];                   /* DS:0EB4 */
extern char near STR_RXOR[];                   /* DS:0EB9 */
extern char near STR_RAND[];                   /* DS:0EBE */
extern char near STR_ROR[];                   /* DS:0EC3 */
extern char near STR_LSH[];                   /* DS:0EC7 */
extern char near STR_RSH[];                   /* DS:0ECB */
extern char near STR_RLSH[];                   /* DS:0ECF */
extern char near STR_RRSH[];                   /* DS:0ED4 */
extern char near STR_EQL[];                   /* DS:0ED9 */
extern char near STR_NEQ[];                   /* DS:0EDD */
extern char near STR_LEQ[];                   /* DS:0EE1 */
extern char near STR_GEQ[];                   /* DS:0EE5 */
extern char near STR_LAND[];                   /* DS:0EE9 */
extern char near STR_LOR[];                   /* DS:0EEE */
extern char near STR_CALL[];                   /* DS:0EF2 */
extern char near STR_SUBS[];                   /* DS:0EF7 */
extern char near STR_NEW_2[];                   /* DS:0EFC */
extern char near STR_DELE[];                   /* DS:0F00 */
extern char near STR_AROW[];                   /* DS:0F05 */
extern char near STR_COMA[];                   /* DS:0F0A */
extern char near STR_ARWM[];                   /* DS:0F0F */
extern char near STR_IND[];                   /* DS:0F14 */
extern char near STR_ADR[];                   /* DS:0F18 */
extern char near STR_NOT[];                   /* DS:0F1C */
extern char near STR_INC[];                   /* DS:0F20 */
extern char near STR_DEC[];                   /* DS:0F24 */
extern char near STR_CTR[];                   /* DS:0F28 */
extern char near STR_DTR[];                   /* DS:0F2C */
extern char near STR_ZYXWVUTSRQPONMLKJIHGFEDC[];                   /* DS:0F30 */
extern char near STR_LOCAL_DESTRUCTORS[];                       /* DS:0F70 */
extern char near STR_ARRAY_BOUNDS[];                   /* DS:0F82 */
extern char near STR_A_MEMBER_FUNCTION[];                   /* DS:0F90 */
extern char near STR_FRIEND_2[];                       /* DS:0FA2 */
extern char near STR_VIRTUAL_2[];                       /* DS:0FA9 */
extern char near STR_OPERATOR[];                       /* DS:0FB1 */
extern char near STR_OPERATOR_2[];                       /* DS:0FBD */
extern char near STR_REFERENCE[];                       /* DS:0FCA */
extern char near C25_EMPTY_NAME[];                  /* DS:0FD4 */
extern char near C27_STATIC_TEXT[];                 /* DS:0FD6 */
extern char near STR_COLON[];                       /* DS:10A2 */
extern char near STR_ERRORS_IN_COMPILE[];                       /* DS:10A4 */
extern char STR_FATAL[];                            /* DS:10C2 */
extern char STR_IN_FUNCTION[];                            /* DS:10C8 */
extern char STR_WARNING[];                            /* DS:10D8 */
extern char STR_ERROR[];                            /* DS:10E0 */
extern char STR_FMT_SPACE_STRING[];                            /* DS:10E8 */
extern char STR_FMT_SPACE_LONG[];                            /* DS:10EC */
extern char STR_COLON_SPACE[];                            /* DS:10F1 */
extern char STR_DIAG_NEWLINE[];                            /* DS:10F4 */
extern char near STR_VOID[];                   /* DS:1122 */
extern char near STR_DOT_DOT_DOT[];                   /* DS:1127 */
extern char near STR_CONST[];                   /* DS:112B */
extern char near STR_VOLATILE[];                   /* DS:1132 */
extern char near STR_ENUM[];                   /* DS:113C */
extern char near STR_ENUM_2[];                   /* DS:1142 */
extern char near STR_FAR[];                   /* DS:1147 */
extern char near STR_NEAR[];                   /* DS:114D */
extern char near STR_COLON_COLON[];                   /* DS:1154 */
extern char near STR_PASCAL[];                   /* DS:1157 */
extern char near STR_STAR_RPAREN[];                   /* DS:115F */
extern char near STR_CONST_2[];                   /* DS:1162 */
extern char near STR_VOLATILE_2[];                   /* DS:116A */
extern char near STR_STRUCT[];                   /* DS:1175 */
extern char near STR_UNION[];                   /* DS:117C */
extern char near STR_OPERATOR_3[];                   /* DS:1182 */
extern char near STR_LPAREN_RPAREN[];                   /* DS:118C */
extern char near STR_CONST_3[];                   /* DS:118F */
extern char near STR_VOLATILE_3[];                   /* DS:1196 */
extern char near STR_OPERATOR_4[];                   /* DS:11A0 */
extern char near STR_AN_INTEGRAL_TYPE[];                   /* DS:11AA */
extern char near STR_A_POINTER_TYPE[];                   /* DS:11BB */
extern char near STR_A_SCALAR_TYPE[];                   /* DS:11CA */
extern char near STR_AN_ARITHMETIC_TYPE[];                   /* DS:11D8 */
extern char near STR_A_SIMPLE_TYPE[];                   /* DS:11EB */
extern char near STR_C_3[];                   /* DS:11F9 */
extern char near STR_C_4[];                   /* DS:11FD */
extern char near STR_PASCAL_2[];                   /* DS:11FF */
extern char near STR_TYPE_CONVERSION[];                   /* DS:1206 */
extern unsigned char near BINARY_PRECEDENCE_BY_TOKEN[];             /* DS:1216 */
extern unsigned char near STACK_PRECEDENCE_BY_OP[];             /* DS:1299 */
extern unsigned char near PREFIX_PRECEDENCE_BY_TOKEN[];             /* DS:131C */
extern char near STR_SUBSCRIPTING[];                       /* DS:139F */
extern char near STR_FRIEND_3[];                       /* DS:13AC */
extern char near STR_VIRTUAL_3[];                       /* DS:13B3 */
extern unsigned char near TOKEN_OPERATOR_CODE[];             /* DS:13BC */
extern unsigned int near COMPARE_NEGATION_TABLE[];              /* DS:1420 */
extern char near STR_IF_2[];                       /* DS:1440 */
extern char near STR_A_STANDARD_CONVERSION[];                   /* DS:1444 */
extern int near COMPARE_NEGATE_TABLE[];                       /* DS:145A */
extern signed char TYPE_RECORD_SIZE[];                    /* DS:14B6 */
extern signed char MEMBER_RECORD_SIZE[];                    /* DS:14CC */
extern unsigned int DUPLICATE_TYPE_FREE_LIST;                     /* DS:14D0 */
extern char near DEFAULT_SOURCE_EXT[];                  /* DS:14F9 */
extern unsigned char OPTION_FLOAT_MODE;                    /* DS:16F3 */
extern unsigned char OPTION_FAST_FLOAT;                    /* DS:16F4 */
extern char COMMENT_NESTED;                         /* DS:16F7 */
extern unsigned char OPTION_ERROR_LIMIT;                    /* DS:16F9 */
extern unsigned char OPTION_WARNING_LIMIT;                    /* DS:16FA */
extern unsigned char C51_SKIP_LINK;                 /* DS:16FC */
extern unsigned char OPTION_NO_AUTODEPEND;                    /* DS:16FE */
extern unsigned char OPTION_STACK_CHECK;                    /* DS:16FF */
extern unsigned char OPTIMIZE_ENABLED;                    /* DS:1703 */
extern signed char OPTION_SUPPRESS_RELOADS;                     /* DS:1704 */
extern unsigned char OPTION_STANDARD_FRAME;                    /* DS:1706 */
extern unsigned char OPTION_REGISTER_VARS;                    /* DS:1707 */
extern unsigned char OPTION_MERGE_STRINGS;                 /* DS:1708 */
extern unsigned char C52_OS2_OPTION;                /* DS:170A */
extern unsigned char C52_MULTITHREAD_OPTION;        /* DS:170B */
extern unsigned char C52_DLL_OPTION;                /* DS:170C */
extern unsigned char OPTION_DS_NOT_SS;                    /* DS:1713 */
extern unsigned char VTABLE_MODE;                 /* DS:1763 */
extern signed char PCH_OPTION_MODE;                      /* DS:1765 */
extern int EMS_PAGE_LIMIT;                              /* DS:176A */
extern long EXT_MEMORY_BASE;                             /* DS:176C */
extern unsigned long EXT_MEMORY_BANK_SIZE;                    /* DS:1770 */
extern unsigned char OPTION_LINK_OVERLAY;                    /* DS:1774 */
extern unsigned char OPTION_EXPAND_INLINES;                    /* DS:1775 */
extern unsigned char OPTION_FLAG;                   /* DS:1778 */
extern signed char OPTION_COMDEFS;                      /* DS:1779 */
extern unsigned char OPTION_SS_EQUALS_DS;                    /* DS:177A */
extern unsigned int FAR_DATA_THRESHOLD;                     /* DS:177C */
extern char near STR_EMPTY_MACRO_VALUE[];                       /* DS:1D00 */
extern char STR_INCLUDE_GIVEN_MARK[];                           /* DS:1DD5 */
extern char near STR_CPP[];                       /* DS:1F14 */
extern char near STR_BACKSLASH[];                       /* DS:1F19 */
extern char STR_PRAGMA[];                            /* DS:1F84 */
extern char STR_DEFINE[];                            /* DS:1F99 */
extern char STR_LINE[];                            /* DS:1FC6 */
extern char near STR_MISSING_FUNCTION[];                       /* DS:1FCB */
extern char near STR_PRAGMA_DIRECTIVE[];                       /* DS:1FE7 */
extern unsigned char TOKEN_START_FLAGS[];                  /* DS:2064 */
extern unsigned char SINGLE_CHAR_TOKEN_TABLE[];                  /* DS:20E6 */
extern unsigned char OP_ASSIGN_TOKEN_TABLE[];                  /* DS:20EF */
extern unsigned char DOUBLED_CHAR_TOKEN_TABLE[];                  /* DS:20F8 */
extern signed char LEX_READ_MODE0_CLASSES[];                    /* DS:2200 */
extern signed char LEX_READ_MODE1_CLASSES[];                    /* DS:2300 */
extern char PREDEFINED_1[];                         /* DS:2401 */
extern char PRED_NAME_1[];                          /* DS:240B */
extern char PRED_NAME_2[];                          /* DS:2412 */
extern char PRED_NAME_3[];                          /* DS:241C */
extern char PRED_NAME_4[];                          /* DS:2423 */
extern char PRED_NAME_5[];                          /* DS:242A */
extern char PRED_NAME_6[];                          /* DS:2431 */
extern char STR_DEFINED[];                            /* DS:2438 */
extern char near EOF_BUFFER_TEXT[];                       /* DS:2440 */
extern char near STR_NEWLINE_INPUT[];                       /* DS:2442 */
extern char near STR_DOUBLE_QUOTE[];                       /* DS:2444 */
extern char near STR_BLANK_COMMENT_LINE[];                       /* DS:2446 */
extern char near STR_CRLF_ECHO[];                       /* DS:244B */
extern char near STR_COMMENT_INDENT[];                       /* DS:244E */
extern char near *STARTUP_SS_DS_NAMES[6];             /* DS:2480 */
extern char near *C51_WINDOWS_RUNTIME[6];           /* DS:24B0 */
extern unsigned char C51_UPPER_LINK_OPTIONS[26];    /* DS:24DE */
extern unsigned char C51_DIGIT_LINK_OPTIONS[10];    /* DS:24F8 */
extern unsigned int LINK_LIBRARY_ARG_SEEN;                 /* DS:250E */
extern signed char C51_DLL_MODEL[6];                /* DS:2510 */
extern char near STR_OBJ_2[];                       /* DS:2519 */
extern char near SPECIAL_NAME[];                    /* DS:2520 */
extern char near STR_COLON_CRLF[];                      /* DS:264D */
extern char near STR_ASM_EXT[];                      /* DS:2651 */
extern char near STR_CPP_EXT[];                      /* DS:2656 */
extern char near STR_O[];                       /* DS:265B */
extern char near STR_D_TINY[];                       /* DS:265E */
extern char near STR_D_SMALL[];                       /* DS:266A */
extern char near STR_D_MEDIUM[];                       /* DS:2677 */
extern char near STR_D_COMPACT[];                       /* DS:2685 */
extern char near STR_D_LARGE[];                       /* DS:2694 */
extern char near STR_D_HUGE[];                       /* DS:26A1 */
extern char near STR_D_PASCAL[];                       /* DS:26AD */
extern char near STR_D_FASTCALL[];                       /* DS:26BB */
extern char near STR_D_CDECL[];                       /* DS:26CB */
extern char near STR_E[];                       /* DS:26D8 */
extern char near STR_R[];                       /* DS:26DB */
extern char near STR_ZI[];                       /* DS:26DE */
extern char near STR_ML[];                       /* DS:26E2 */
extern char near STR_SPACE_SLASH[];                       /* DS:26E6 */
extern char near STR_SPACE_COMMA[];                       /* DS:26E9 */
extern char near STR_SPACE_SPACE_SEMI[];                       /* DS:26EC */
extern char near STR_PLUS_CRLF[];                       /* DS:26F0 */
extern char near STR_TURBOC_LN[];                   /* DS:26F4 */
extern char near STR_O_2[];                   /* DS:26FF */
extern char near STR_V[];                   /* DS:2703 */
extern char near STR_V_2[];                   /* DS:2707 */
extern char near STR_DLL[];                   /* DS:270B */
extern char near STR_Y[];                   /* DS:2710 */
extern char near STR_TWD[];                   /* DS:2713 */
extern char near STR_T[];                   /* DS:2718 */
extern char near STR_O_3[];                   /* DS:271B */
extern char near STR_OVERLAY_LIB[];                   /* DS:2722 */
extern char near STR_IMPORT_LIB[];                   /* DS:272E */
extern char near STR_EMU_LIB[];                   /* DS:2739 */
extern char near STR_FP87_LIB[];                   /* DS:2741 */
extern char near STR_DEF[];                   /* DS:274A */
extern char near STR_TLINK_EXE[];                   /* DS:274F */
extern char near STR_TURBOC_LN_2[];                   /* DS:2759 */
extern unsigned int INTEGRAL_PROMOTION_KIND[];                   /* DS:2766 */
extern unsigned int ASM_STATEMENT_FLAG;                     /* DS:2792 */
extern char near STR_EMPTY_3[];                   /* DS:285A */
extern char near STR__TEXT[];                   /* DS:28E6 */
extern char near STR_CODE[];                   /* DS:28EC */
extern char near STR__[];                   /* DS:28F1 */
extern char near STR_DATA[];                   /* DS:28F2 */
extern char near STR_DGROUP[];                   /* DS:28F7 */
extern char near STR_X5F_2[];                   /* DS:28FE */
extern char near STR_BSS[];                   /* DS:28FF */
extern char near STR_FAR_DATA[];                   /* DS:2903 */
extern char near STR_TEXT_2[];                   /* DS:290C */
extern char near STR_1[];                   /* DS:2912 */
extern char near STR_XFB[];                   /* DS:2913 */
extern char near STR___MULTI_THREAD__[];                   /* DS:2915 */
extern char near STR___SINGLE_THREAD__[];                   /* DS:2926 */
extern char near STR___DLL__[];                   /* DS:2938 */
extern char near STR___OS2__[];                   /* DS:2940 */
extern char near STR___MSDOS__[];                   /* DS:2948 */
extern char near STR__WINDOWS[];                   /* DS:2952 */
extern char near STR___TURBOC__[];                   /* DS:295B */
extern char near STR_0X0297[];                   /* DS:2966 */
extern char near STR___BORLANDC__[];                   /* DS:296E */
extern char near STR_0X0200[];                   /* DS:297B */
extern char near STR___TCPLUSPLUS__[];                   /* DS:2983 */
extern char near STR___BCPLUSPLUS__[];                   /* DS:2992 */
extern char near STR___OVERLAY__[];                   /* DS:29A1 */
extern char near STR___PASCAL__[];                   /* DS:29AD */
extern char near STR___FASTCALL__[];                   /* DS:29B8 */
extern char near STR___CDECL__[];                   /* DS:29C5 */
extern char near STR__FAR[];                   /* DS:29CF */
extern char near NAME_A1[];                         /* DS:29D4 */
extern char near NAME_A2[];                         /* DS:29DB */
extern char near NAME_B1[];                         /* DS:29E4 */
extern char near NAME_B2[];                         /* DS:29EB */
extern long MIN_FREE_HEAP;                             /* DS:29F4 */
extern char near C53_DEFAULT_FILE[];                /* DS:29F8 */
extern char near C53_COMMAND_LINE[];                /* DS:2A02 */
extern char near C53_CONFIG_FILE[];                 /* DS:2A0F */
extern char near OPT_TEXT_YO[];                          /* DS:2A22 */
extern char near C53_YO_OFF[];                      /* DS:2A25 */
extern char near OPT_TEXT_V[];                           /* DS:2A29 */
extern char near C53_V_OFF[];                       /* DS:2A2B */
extern char near OPT_TEXT_VI[];                          /* DS:2A2E */
extern char near C53_VI_OFF[];                      /* DS:2A31 */
extern char near DEBUG_PREFIX[];                    /* DS:2A36 */
extern char near DEBUG_MORE[];                      /* DS:2A41 */
extern char near DEBUG_SUFFIX[];                    /* DS:2A4F */
extern char near C56_EXTERN[];                      /* DS:2A52 */
extern char near C56_NEAR[];                        /* DS:2A5A */
extern char near C56_PUBLIC_DLL[];                  /* DS:2A5F */
extern char near C56_PUBLIC[];                      /* DS:2A6B */
extern char near C56_STACK_EQU[];                   /* DS:2A74 */
extern char near C56_PLUS[];                        /* DS:2A7B */
extern char near C56_EQU[];                         /* DS:2A7D */
extern char near DEBUG_NODE_PREFIX[];               /* DS:2A83 */
extern char near C56_VERSION_EXTENDED[];            /* DS:2A8E */
extern char near C56_VERSION_BASE[];                /* DS:2A91 */
extern char near C56_DATA_MARK[];                   /* DS:2A94 */
extern char near STR_BSS_BASE_LABEL[];                   /* DS:2A97 */
extern char near C56_WORD_MARK[];                   /* DS:2A9A */
extern unsigned int OBJ_EXTERN_INDEX;                     /* DS:2A9E */
extern char near STR_TURBOFLOAT[];                       /* DS:2AA0 */
extern char near STR_CRLF_2[];                       /* DS:3304 */
extern char STR_OPERATOR_NEW[];                            /* DS:3308 */
extern char STR_OPERATOR_DELETE[];                            /* DS:3315 */
extern char STR_FRIEND_4[];                         /* DS:3326 */
extern char STR_VIRTUAL_4[];                         /* DS:332D */
extern char STR_OPERATOR_5[];                         /* DS:3335 */
extern char STR_DYNAMIC_DISPATCH_CONSTAN[];                         /* DS:3341 */
extern char STR_STATIC_MEMBER[];                         /* DS:335B */
extern char STR_NON_INLINE_FUNCTION[];                         /* DS:3369 */
extern char STR_STATIC_2[];                         /* DS:337D */
extern char near BCC_DEBUG_EMPTY[];                 /* DS:3384 */
extern unsigned int near PCH_OPTION_FLAG_PTRS[];              /* DS:33D0 */
extern char STR_LOADED_PRE_COMPILED[];                            /* DS:340A */
extern char near STR_NEWLINE[];                       /* DS:3426 */
extern char near STR_EMPTY[];                       /* DS:3427 */
extern char near STR_HASH[];                       /* DS:3428 */
extern char near STR_SPACE[];                       /* DS:342A */
extern char near STR_HDRFILE[];                       /* DS:342C */
extern char near STR_HDRSTOP[];                       /* DS:3434 */
extern char near STR_PRAGMA_2[];                       /* DS:343C */
extern char near STR_EXTERN[];                       /* DS:3444 */
extern char near STR_EXTERN_2[];                       /* DS:344B */
extern char near STR_EXTERN_3[];                       /* DS:3453 */
extern char near STR_QUOTE[];                       /* DS:345A */
extern char near STR_QUOTE_CRLF[];                       /* DS:345C */
extern char near STR_CRLF[];                       /* DS:345D */
extern char near STR_INCLUDE[];                       /* DS:3496 */
extern char near STR_GREATER[];                       /* DS:34A1 */
extern char near STR_INCLUDE_2[];                       /* DS:34A3 */
extern char near STR_DEFINE_2[];                       /* DS:34AE */
extern char near STR_DEFINE_3[];                       /* DS:34AF */
extern char near STR_IF_3[];                       /* DS:34B7 */
extern char near STR_IFDEF[];                       /* DS:34BC */
extern char near STR_IFNDEF[];                       /* DS:34C4 */
extern char near STR_ENDIF[];                       /* DS:34CD */
extern char near STR_QUOTE_OPEN_BRACE[];                       /* DS:34D5 */
extern char near STR_CLOSE_BRACE[];                       /* DS:34D9 */
extern char STR_C[];                            /* DS:34DB */
extern char STR_C_2[];                            /* DS:34DF */
extern signed char BINARY_PRIORITY_BY_TOKEN[];                    /* DS:34E2 */
extern signed char TERNARY_ELSE_LEVEL;                      /* DS:3502 */
extern signed char OPERATOR_BY_TOKEN[];                    /* DS:350C */
extern unsigned int TYPECHECK_OP_FLAGS[];                   /* DS:3535 */
extern signed char LEVEL_ASSOCIATIVITY[];                    /* DS:3536 */
extern unsigned char OPERAND_KIND_MASK[];                  /* DS:3594 */
extern unsigned int OPERAND_KIND_MESSAGE[];                   /* DS:3598 */
extern signed char near POST_TO_ASSIGN_OP[];               /* DS:35B9 */
extern char STR_SUBSCRIPTING_2[];                           /* DS:35C2 */
extern char near STR_STKLEN[];                       /* DS:35DE */
extern signed char near EXPR_OP_HAS_EFFECT[];               /* DS:35E6 */
extern char near STR_IF_4[];                       /* DS:361D */
extern char near STR_FOR_2[];                       /* DS:3620 */
extern char near STR_DO_WHILE_2[];                       /* DS:3624 */
extern char near STR_WHILE_2[];                       /* DS:362D */
extern char near STR_SWITCH_2[];                       /* DS:3633 */
extern char near STR_BREAK[];                       /* DS:363A */
extern char near STR_CONTINUE[];                       /* DS:3640 */
extern char near STR_RETURN[];                       /* DS:3649 */
extern char near STR_GOTO_2[];                       /* DS:3650 */
extern unsigned char INITIAL_TYPE_POOL_IMAGE[];                  /* DS:371A */
extern char near STR_S[];                       /* DS:379C */
extern char near STR_MAIN[];                       /* DS:379F */
extern char STR_STATIC[];                            /* DS:37A4 */
extern char STR_SETARGV[];                            /* DS:37AB */
extern char STR_SETARGV_2[];                            /* DS:37B6 */
extern char STR_SETENVP[];                            /* DS:37C2 */
extern char STR_SETENVP_2[];                            /* DS:37CD */
extern char near *STORAGE_CLASS_NAMES[];                     /* DS:37DA */
extern char STR_DEBUG_C[];                         /* DS:381A */
extern char STR_CR_NL[];                         /* DS:3833 */
extern char STR_01[];                         /* DS:3867 */
extern char STR_DEBUG_F[];                         /* DS:386A */
extern signed char EXPR_RETYPE_SHAPE[];                    /* DS:388A */
extern signed char EXPR_NARROW_SHAPE[];                    /* DS:38C1 */
extern unsigned int INVERT_COMPARE_TABLE[];                   /* DS:38C2 */
extern unsigned int MIRROR_COMPARE_TABLE[];                   /* DS:38CE */
extern int OUTPUT_FILE_HANDLE;                              /* DS:38FA */
extern char JUMP_CONDITION_INVERSE_TABLE[];                           /* DS:3914 */
extern signed char KIND_SIZE_TABLE[];                    /* DS:392B */
extern signed char BITFIELD_UNIT_BYTES;                      /* DS:3937 */
extern long BCC_ENUM_MIN_LO;                        /* DS:3980 */
extern long BCC_ENUM_MAX_LO;                        /* DS:3984 */
extern long INT_LIMIT;                              /* DS:398C */
extern long MASK_B;                                 /* DS:399C */
extern unsigned long LONG_MAX_VALUE;                    /* DS:39B4 */
extern unsigned char near OPERATOR_RULES[];         /* DS:39B8 */
extern unsigned char near CONVERSION_RULES[];       /* DS:3E3B */
extern unsigned char CODE_OP_INFO_TABLE[];                  /* DS:3F9B */
extern unsigned char OPCODE_DESC_BYTE8[];                  /* DS:3FA0 */
extern unsigned int REG_CLASS_MASK_TABLE[];                   /* DS:4F7A */
extern unsigned char near REG_CLASS_IS_WORD[];             /* DS:4FBC */
extern unsigned int REGISTER_MASK_TABLE[];                   /* DS:4FDD */
extern unsigned char OPERAND_BASE_BY_KIND[];                  /* DS:4FE9 */
extern unsigned char LEAF_OPCODE_KIND_OFFSET[];                  /* DS:5020 */
extern unsigned char OPER_OPCODE_KIND_OFFSET[];                  /* DS:5036 */
extern unsigned int near OPERATOR_HELPER_NAME_TABLE[];              /* DS:5235 */
extern char near STR_PCMP[];                       /* DS:52C2 */
extern char near STR_OVERFLOW[];                       /* DS:52DF */
extern char near STR_SPUSH[];                       /* DS:52E9 */
extern char near STR_SCOPY[];                       /* DS:52F0 */
extern char near STR_PDEA[];                       /* DS:5307 */
extern char near STR_PINA[];                       /* DS:530D */
extern int EVAL_STACK_TOP;                              /* DS:5314 */
extern int EVAL_STACK_MAX;                              /* DS:5316 */
extern int EVAL_STACK_SPILLED;                              /* DS:5318 */
extern int POOLED_NODE_TOP;                              /* DS:531A */
extern unsigned int SCRATCH_TEMP_VARIABLE;                     /* DS:531C */
extern char JUMP_KIND_REMAP_TABLE[];                           /* DS:531E */
extern unsigned int REG_MASK_ES;                     /* DS:5356 */
extern unsigned int REG_MASK_BX_SI_DI;                     /* DS:5358 */
extern unsigned int REG_MASK_SI_DI;                     /* DS:535A */
extern unsigned int REG_MASK_CX;                     /* DS:535C */
extern unsigned int REG_MASK_HIGH_BYTES;                     /* DS:535E */
extern unsigned int REG_MASK_LOW_BYTES;                     /* DS:5360 */
extern unsigned int SWITCH_BIT_200_FLAG;                     /* DS:5362 */
extern unsigned int LOCAL_LABEL_SERIAL;                     /* DS:5364 */
extern unsigned int LAST_LINE_MARK_ID;                     /* DS:5366 */
extern char near *JUMP_MNEMONIC_TEXT[];                     /* DS:5368 */
extern unsigned char JUMP_OPCODE_BYTE[];                  /* DS:5398 */
extern char STR_ASM_STATEMENT_CRLF[];                            /* DS:540B */
extern char STR_BP[];                            /* DS:5441 */
extern unsigned int INVERTED_JUMP_KIND[];                   /* DS:5446 */
extern signed char REGISTER_ENCODING_TABLE[];                    /* DS:54CE */
extern signed char FIXUP_CODE_TABLE[];                    /* DS:5526 */
extern char ASM_OPERAND_FORMAT_MAP[];                           /* DS:55B2 */
extern char STR_DEBUG_B;                              /* DS:55B9 */
extern char STR_DB_LINE_CRLF;                              /* DS:55C2 */
extern char STR_DEBUG_E;                              /* DS:55C5 */
extern char STR_DB;                              /* DS:57AC */
extern char STR_MOV_CX_OFFSET_7_PUSH;                              /* DS:5841 */
extern char STR_PUSH_OFFSET_6;                              /* DS:5860 */
extern char STR_ENDP;                              /* DS:59FD */
extern char STR_ENDS[];                            /* DS:5A20 */
extern char near STR_EMIT[];                       /* DS:5ABA */
extern unsigned char CTYPE_BY_CHAR[];                  /* DS:5B81 */
extern char near SEARCH_PATH_NAME[];                /* DS:5C8E */
extern char near SEARCH_SEPARATOR[];                /* DS:5C93 */
extern unsigned int CTRL_BREAK_SEEN;                 /* DS:5CA2 */
extern unsigned int HEAP_SIZE_PARAS;                     /* DS:5CA4 */
extern unsigned int SCOPE_STACK_DEPTH;                     /* DS:5EAC */
extern unsigned int CACHE_HEAD;                     /* DS:5EBE */
extern unsigned int CURRENT_TOKEN;                     /* DS:5EC2 */
extern unsigned int VECTOR_NEW_SYMBOL;                     /* DS:5EC4 */
extern unsigned int GLOBAL_SCOPE_TAGS;                   /* DS:5EC6 */
extern unsigned int INT_TYPE;                  /* DS:5EC8 */
extern unsigned int SUPPRESS_WARNINGS_DEPTH;                     /* DS:5ECA */
extern unsigned char NOT_ANSI_FLAG;                    /* DS:5ECC */
extern unsigned int SETARGV_SYMBOL;                     /* DS:5ECE */
extern unsigned int SETENVP_SYMBOL;                     /* DS:5ED0 */
extern unsigned int TOKEN_STREAM_POOL_SEG;                     /* DS:5ED2 */
extern unsigned int BCC_TREE_FLAG;                  /* DS:5EDA */
extern unsigned int CURRENT_FUNCTION_TYPE;                 /* DS:5EDE */
extern unsigned int STMT_SCOPE_BLOCK;                     /* DS:5EE1 */
extern unsigned int BCC_TREE_LINK;                  /* DS:5EE2 */
extern unsigned int STRUCT_RETURN_PARAM;                     /* DS:5EE3 */
extern unsigned char CODE_UNREACHABLE;                    /* DS:5EE4 */
extern unsigned char STMT_NO_GOTO_OR_LABEL_FLAG;                    /* DS:5EE5 */
extern unsigned int LOOP_NEST_FACTOR;                     /* DS:5EE6 */
extern unsigned int ENCLOSING_STATEMENT_KIND;                     /* DS:5EE8 */
extern unsigned int STATEMENT_NEST_DEPTH;                     /* DS:5EEA */
extern unsigned int SWITCH_STATE_SCOPE;                     /* DS:5EF2 */
extern unsigned int LOOP_BREAK_SCOPE;                     /* DS:5F01 */
extern unsigned int PENDING_GOTO_LIST;                     /* DS:5F06 */
extern unsigned int LABEL_LIST_HEAD;                     /* DS:5F08 */
extern unsigned int BLOCK_NEST_LEVEL;                     /* DS:5F0A */
extern int DECL_INIT_SERIAL;                              /* DS:5F0C */
extern unsigned int BCC_PARSE_BUFFER;               /* DS:5F0E */
extern unsigned int CTOR_DTOR_MODE;                     /* DS:5F10 */
extern unsigned int CTOR_THIS_SYMBOL;                     /* DS:5F12 */
extern unsigned char CTOR_THIS_ASSIGNED;                    /* DS:5F14 */
extern unsigned char CTOR_CHECK_THIS_ASSIGN;                    /* DS:5F15 */
extern unsigned int PACKED_INIT_EXPR;                     /* DS:5F16 */
extern unsigned int FNBODY_WORD_A_SAVE;                     /* DS:5F18 */
extern unsigned int FNBODY_WORD_B_SAVE;                     /* DS:5F1A */
extern unsigned int CPP_BODY_END_LABEL;                     /* DS:5F1C */
extern unsigned int FUNC_START_CLEARED_WORD;                     /* DS:5F20 */
extern unsigned int FUNCTION_DEF_LINE;                     /* DS:5F22 */
extern unsigned int CURRENT_SOURCE_FILE;                     /* DS:5F24 */
extern unsigned char STARTUP_BODY_ACTIVE;                    /* DS:5F26 */
extern unsigned char SAW_RETURN_WITH_VALUE;                    /* DS:5F27 */
extern unsigned char SAW_RETURN_WITHOUT_VALUE;                    /* DS:5F28 */
extern unsigned int LOCAL_INIT_EXPR_LIST;                     /* DS:5F2A */
extern unsigned int FAR_CHAR_POINTER_TYPE;                     /* DS:5F2C */
extern unsigned int PARAM_LIST_DEPTH;                     /* DS:5F2E */
extern unsigned int near C26_SCOPE_STACK[];         /* DS:5F30 */
extern unsigned char RECORDING_TOKENS;                    /* DS:5F3A */
extern unsigned int VECTOR_VNEW_SYMBOL;                     /* DS:5F3C */
extern unsigned int TAG_BODY_POOL_SEG;                   /* DS:5F3E */
extern unsigned int INIT_RECORD_POOL_SEG;                     /* DS:5F46 */
extern char BCC_DEBUG_NAME[];                       /* DS:5F50 */
extern unsigned int VTABLE_ENTRY_PTR_TYPE;                     /* DS:6152 */
extern unsigned int INT_TYPE_SIZE;                     /* DS:6154 */
extern unsigned int PENDING_DEFINITION_LIST;                     /* DS:6156 */
extern unsigned int PENDING_INIT_LIST;                     /* DS:6158 */
extern unsigned char INLINE_OPTION_BLOCK_FLAG;                    /* DS:615A */
extern unsigned int MEMBER_PTR_CLASS_TYPE;                     /* DS:615C */
extern unsigned int VTABLE_CLASS_LIST;                     /* DS:615E */
extern unsigned char STRING_TOKEN_PENDING;                    /* DS:6160 */
extern unsigned int VECTOR_APPLY_SYMBOL;                     /* DS:6162 */
extern unsigned int VTABLE_NEAR_FUNC_MEMBER;                     /* DS:6164 */
extern unsigned int VTABLE_FAR_FUNC_MEMBER;                     /* DS:6166 */
extern unsigned int NEAR_PURE_ERROR_SYMBOL;                     /* DS:616A */
extern unsigned int FAR_PURE_ERROR_SYMBOL;                     /* DS:616C */
extern unsigned char EXPAND_INLINES_FLAG;                    /* DS:616E */
extern unsigned int NON_CPP_CLEARED_WORD_A;                     /* DS:6170 */
extern unsigned int MEMBER_PTR_OFFSET_MEMBER;                     /* DS:6172 */
extern unsigned int MEMBER_PTR_VINDEX_MEMBER;                     /* DS:6174 */
extern unsigned int MEMBER_PTR_NEAR_FUNC_MEMBER;                     /* DS:6176 */
extern unsigned int MEMBER_PTR_FAR_FUNC_MEMBER;                     /* DS:6178 */
extern unsigned int VECTOR_DELETE_SYMBOL;                     /* DS:617C */
extern unsigned int VECTOR_VAPPLY_SYMBOL;                     /* DS:617E */
extern unsigned int TOKEN_STREAM_HANDLE;                     /* DS:6180 */
extern unsigned int TOKEN_NAMES[];                  /* DS:6182 */
extern unsigned int CTOR_NAME;             /* DS:618C */
extern unsigned int DTOR_NAME;               /* DS:618E */
extern unsigned int CONVERSION_FUNC_NAME;                     /* DS:61F0 */
extern unsigned int EXPR_CURRENT2;                  /* DS:6208 */
extern unsigned int HIDDEN_RETURN_PARAM_NAME;                     /* DS:6240 */
extern unsigned int OPERATOR_DELETE_NAME;                     /* DS:6254 */
extern unsigned int OPERATOR_NEW_NAME;                     /* DS:625A */
extern unsigned int THIS_NAME;                   /* DS:6266 */
extern unsigned int VTABLE_PTR_NAME;                   /* DS:6268 */
extern unsigned int MEMBER_PTR_DELTA_MEMBER;                     /* DS:6288 */
extern unsigned int STORAGE_POOL_SEG;                     /* DS:628A */
extern unsigned int FNBODY_WORD_B;                     /* DS:628E */
extern unsigned int FNBODY_CLEARED_WORD_B;                     /* DS:6290 */
extern unsigned int INLINE_BODY_QUEUE;                     /* DS:6292 */
extern unsigned int INLINE_EXPANSION_DEPTH;                     /* DS:6294 */
extern unsigned char END_OF_INPUT_SEEN;                    /* DS:6296 */
extern unsigned int FAR_VOID_PTR_TYPE;                     /* DS:6298 */
extern unsigned int FAR_VTABLE_ENTRY_PTR_TYPE;                     /* DS:629A */
extern unsigned int LONG_TYPE;                     /* DS:629C */
extern unsigned int VOID_TYPE;                     /* DS:629E */
extern unsigned char CPP_MODE;              /* DS:62A0 */
extern unsigned int PLAIN_CHAR_TYPE;                     /* DS:62A4 */
extern unsigned int BASE_PATH_POOL_SEG;                     /* DS:62A6 */
extern unsigned int INLINE_FUNCTION_STACK;                     /* DS:62AE */
extern unsigned char ENUMS_AS_INT_FLAG;                    /* DS:62B0 */
extern unsigned int DOUBLE_TYPE;                     /* DS:62B2 */
extern unsigned int LINKAGE_STACK_POOL_SEG;                     /* DS:62B4 */
extern unsigned int STRUCT_BODY_TYPE;                     /* DS:62E8 */
extern unsigned int ACTIVE_LIST;                    /* DS:62EA */
extern signed char WARNING_ENABLED_TABLE[];                    /* DS:62ED */
extern int BITFIELD_ALIGN_BITS;                              /* DS:62F0 */
extern unsigned int CLASS_KEY_TOKEN;                     /* DS:62F2 */
extern unsigned int SCOPE_STATE;                    /* DS:62F4 */
extern unsigned int CURRENT_DECLARATOR_NAME;                     /* DS:62F6 */
extern unsigned int DECLARATOR_NAME_TOKEN;                     /* DS:62F8 */
extern unsigned int SPECIAL_MEMBER_KIND;                     /* DS:62FA */
extern unsigned int STORAGE_CLASS_TOKEN;                     /* DS:62FC */
extern unsigned int TYPE_EXPR;                      /* DS:62FE */
extern unsigned int MEMBER_QUALIFIER_CLASS;                     /* DS:6300 */
extern unsigned char PARSE_FLAG2;                   /* DS:6302 */
extern unsigned char MEMBER_DECL_FRIEND;                    /* DS:6303 */
extern unsigned char NO_THIS_PARAMETER;                    /* DS:6304 */
extern unsigned char MEMBER_DECL_TYPE_NAMED;                    /* DS:6305 */
extern unsigned char RETURN_TYPE_OMITTED;                    /* DS:6306 */
extern unsigned char DISPATCH_NUMBER_GIVEN;                    /* DS:6307 */
extern unsigned int DISPATCH_NUMBER;                     /* DS:6308 */
extern unsigned char PARSE_CLASS;                   /* DS:630B */
extern unsigned int CLASS_VTABLE_SIZE;                     /* DS:630F */
extern unsigned int EXPR_OFFSET2;                   /* DS:6311 */
extern unsigned char MEMBER_FLAG_200_SWITCH;                    /* DS:6313 */
extern unsigned int UNSIGNED_INT_TYPE;                     /* DS:636E */
extern unsigned int EMIT_INTRINSIC_SYMBOL;                     /* DS:637C */
extern unsigned int DOUBLE_TYPE_SIZE;                     /* DS:637E */
extern signed char CURRENT_TOKEN_FLAGS;                      /* DS:6384 */
extern unsigned int CURRENT_TOKEN_FILE;                     /* DS:6385 */
extern unsigned int CURRENT_TOKEN_LINE;                     /* DS:6387 */
extern unsigned int CURRENT_TOKEN_LOC_WORD3;                     /* DS:6389 */
extern unsigned int CHAR_TYPE;                   /* DS:6396 */
extern unsigned int CURRENT_SCOPE;                     /* DS:6398 */
extern unsigned int TYPE_POOL;                      /* DS:639A */
extern unsigned int TYPE_POOL_LENGTH;                     /* DS:639E */
extern unsigned int TYPE_POOL_WORD6;                     /* DS:63A0 */
extern unsigned char PARSER_RESET_BYTE_A;                    /* DS:63A2 */
extern unsigned int STRING_LITERAL_SYMBOL;                     /* DS:63A4 */
extern unsigned int TEMP_ENTRY_POOL_SEG;                     /* DS:63A6 */
extern unsigned char NO_ERRORS_YET;                 /* DS:63AE */
extern unsigned int SHORT_TYPE;                     /* DS:63B0 */
extern unsigned int LABEL_POOL_SEG;                     /* DS:63B2 */
extern unsigned int FNBODY_WORD_A;                     /* DS:63B6 */
extern unsigned int FNBODY_CLEARED_WORD_A;                     /* DS:63B8 */
extern unsigned int MAIN_SYMBOL;                     /* DS:63BA */
extern unsigned int CONDITIONAL_ARM_DEPTH;                     /* DS:63BC */
extern unsigned int LINKAGE_STACK;                     /* DS:63BE */
extern unsigned int GLOBAL_SCOPE;                     /* DS:63C0 */
extern unsigned int CSYM_POOL_SEG;                /* DS:63C2 */
extern unsigned int NODE_COUNT;                     /* DS:63C6 */
extern unsigned int TEMP_DESTRUCTOR_LIST;                     /* DS:63CA */
extern unsigned char PARSER_INIT_MARK_A5;                    /* DS:63CC */
extern unsigned int NEW_OPERATOR_SYMBOL;                     /* DS:63D2 */
extern unsigned int TEMP_NAME_COUNTER;                     /* DS:63D4 */
extern unsigned int IMPLICIT_FUNC_TYPE;                     /* DS:63D6 */
extern unsigned int INT_FAR_FUNC_TYPE;                     /* DS:63D8 */
extern unsigned int RUNTIME_HELPER_FUNC_TYPE;                     /* DS:63DA */
extern unsigned int GLOBAL_SCOPE_NAMES;                   /* DS:63DC */
extern unsigned int INLINE_TOKEN_STREAM;                     /* DS:63DE */
extern unsigned int PTRDIFF_TYPE;                     /* DS:63E0 */
extern unsigned int LIST_CELL_POOL_SEG;                     /* DS:63E2 */
extern unsigned int CONS_CELL_POOL_SEG;                     /* DS:63EA */
extern unsigned int HIDDEN_RETURN_PARAM_RECORD;                     /* DS:63F2 */
extern unsigned char CPU_LEVEL_1_FLAG;                    /* DS:63F4 */
extern unsigned char CPU_IS_286;                    /* DS:63F5 */
extern unsigned int VTABLE_ENTRY_CLASS_TYPE;                     /* DS:63F6 */
extern unsigned int FILE_INIT_EXPR_QUEUE;                     /* DS:63F8 */
extern unsigned int EXPR_START_FLAG_MASK;                     /* DS:63FA */
extern unsigned int CHAR_POINTER_TYPE;                     /* DS:63FC */
extern unsigned int TYPE_LOCAL;                     /* DS:63FE */
extern unsigned char ENUM_BODY_TREE_FLAG;                    /* DS:6400 */
extern unsigned int PLAIN_CHAR_KIND;                     /* DS:6402 */
extern unsigned int INT_NEAR_FUNC_TYPE;                     /* DS:6404 */
extern unsigned int VOID_NOARG_FUNC_TYPE;                     /* DS:6406 */
extern unsigned int BASE_LIST_SEG;                  /* DS:6408 */
extern unsigned int SYMBOL_POOL_SEG;                   /* DS:6410 */
extern unsigned int SCOPE_LINK10_MARK;                     /* DS:6414 */
extern unsigned int SCOPE_LINK10_MARK_HIGH;                     /* DS:6416 */
extern unsigned int VOID_POINTER_TYPE;                     /* DS:6418 */
extern unsigned int IMPLICIT_FUNC_PTR_TYPE;                     /* DS:641A */
extern unsigned int REPLAY_STREAM_2;                     /* DS:6422 */
extern unsigned int REPLAY_STREAM_3;                     /* DS:6424 */
extern unsigned int REPLAY_STREAM_4;                     /* DS:6426 */
extern unsigned int FORMAL_POOL_SEG;            /* DS:6428 */
extern unsigned int PACKED_EXPR_POOL_SEG;                     /* DS:6430 */
extern unsigned int CURRENT_CLASS_TYPE;                     /* DS:6438 */
extern unsigned char WARNING_SWITCH_STATE[];                  /* DS:643A */
extern unsigned char WARN_PRO_FLAG;                    /* DS:6454 */
extern char FOR_STEP_CLEARED_FLAG;                             /* DS:6458 */
extern unsigned int TOKEN_MASK;                     /* DS:6476 */
extern unsigned char IN_ERROR_RECOVERY;                   /* DS:6478 */
extern unsigned int INT_NEAR_FUNC_PTR_TYPE;                     /* DS:647A */
extern unsigned int INT_FAR_FUNC_PTR_TYPE;                     /* DS:647C */
extern unsigned int CURRENT_LINKAGE;                     /* DS:647E */
extern unsigned int STORAGE_RECORD_COUNT;                     /* DS:6480 */
extern unsigned int TYPE_DEBUG_ID_COUNTER;                     /* DS:6482 */
extern unsigned int DEBUG_CLASS_INDEX_NEXT;                     /* DS:6484 */
extern unsigned int DEBUG_MEMBER_COUNTER;                     /* DS:6486 */
extern unsigned char PARSER_RESET_BYTE_B;                    /* DS:6488 */
extern unsigned int DESTRUCTOR_ENTRY_SERIAL;                     /* DS:648A */
extern unsigned int DELETE_OPERATOR_SYMBOL;                     /* DS:648C */
extern unsigned int NON_CPP_CLEARED_WORD_B;                     /* DS:648E */
extern unsigned int CACHE_POOL;                     /* DS:6490 */
extern unsigned int SIZE_T_TYPE;                     /* DS:6498 */
extern unsigned int MEMBER_PTR_PAD_MEMBER;                     /* DS:649A */
extern int C28_LITERAL_PATCH;                       /* DS:66B0 */
extern unsigned int LOGICAL_LINE;                   /* DS:66BE */
extern unsigned int DIAG_FUNC_NAME_HIGH;                     /* DS:66C2 */
extern unsigned int CURRENT_FILE_NAME;                     /* DS:66C4 */
extern unsigned int OPERAND_LIST_BASE;                     /* DS:66C6 */
extern unsigned int OPERATOR_STACK_OFFSET;                     /* DS:66C8 */
extern unsigned int OPERATOR_STACK_POOL;                     /* DS:66CA */
extern unsigned int OPERAND_LIST_HEAD;                     /* DS:66D2 */
extern int OPERATOR_STACK_DEPTH;                              /* DS:66D4 */
extern unsigned int MEMBER_INIT_EXPR;                     /* DS:66D8 */
extern unsigned int MEMBER_CACHE_TYPES[32];                 /* DS:66DA */
extern unsigned int MEMBER_CACHE_NAMES[32];                 /* DS:671A */
extern unsigned int MEMBER_CACHE_MEMBERS[32];                 /* DS:675A */
extern unsigned int COMPILE_FILE_COUNT;                     /* DS:679A */
extern unsigned int C_DECL_SCOPE;                     /* DS:679C */
extern char TOKEN_TEXT_BUFFER[];                          /* DS:679E */
extern char EMIT_LIMIT;                             /* DS:779C */
extern char near NAME_BUFFER[];                     /* DS:779E */
extern unsigned int C_FUNC_START_CLEARED_WORD;                     /* DS:77C0 */
extern unsigned char MACRO_MODE;                    /* DS:77D0 */
extern unsigned char MODEL_FAR_DATA;                  /* DS:77D2 */
extern unsigned int CURRENT_LINE;                   /* DS:77D3 */
extern unsigned int LEX_FILE_SERIAL_NODE;                     /* DS:77D5 */
extern char MACRO_NAME_UNEXPANDED;                             /* DS:77DB */
extern unsigned char MACRO_MARK_FE_SEEN;                    /* DS:77DC */
extern unsigned int TYPE_POOL_LENGTH_MARK;                     /* DS:77DD */
extern unsigned int PLAIN_INT_TYPE;                     /* DS:77E2 */
extern unsigned int STRING_CHAR_TYPE;                     /* DS:77E4 */
extern unsigned int IMPLICIT_FUNCTION_TYPE;                     /* DS:77E6 */
extern unsigned int C_HELPER_FUNC_TYPE;                     /* DS:77E8 */
extern unsigned int BACKEND_OUTPUT_BEGUN_FLAG;                     /* DS:77EA */
extern unsigned int SWITCH_CASE_LIST;                     /* DS:77F6 */
extern unsigned int SWITCH_DEFAULT_LABEL;                     /* DS:77F8 */
extern int STATEMENT_LABELED_FLAG;                              /* DS:77FA */
extern unsigned char COMPILER_TABLES_INIT_FLAG;                    /* DS:77FC */
extern unsigned int BITFIELD_INIT_PENDING;                     /* DS:7809 */
extern unsigned int BITFIELD_INIT_BITS;                     /* DS:780B */
extern unsigned int BITFIELD_INIT_OFFSET;                     /* DS:780D */
extern unsigned char C_FUNC_DEF_SET_ONLY_FLAG;                    /* DS:7810 */
extern unsigned int C_STRING_LITERAL_SYMBOL;                     /* DS:781F */
extern long HEAP_RESERVE_BYTES;                             /* DS:7822 */
extern unsigned int PARAM_SCOPE_MARK;                     /* DS:782E */
extern unsigned int PARAM_SCOPE_MARK_AUX;                     /* DS:7830 */
extern unsigned int NAME_TABLE_END;                     /* DS:7836 */
extern unsigned int STRING_POOL_USED;                     /* DS:784A */
extern unsigned int POOL_HASH;                      /* DS:789C */
extern unsigned int MEMBER_SEGMENT;                 /* DS:78A4 */
extern unsigned int CONTEXT_PTR;                    /* DS:817C */
extern unsigned int DECLARATOR_NODE_POOL_SEG;                     /* DS:817E */
extern unsigned int EXPR_POOL_UNIT;                     /* DS:818A */
extern unsigned int EXPR_POOL_USED;                     /* DS:818C */
extern unsigned int SEGMENT_POOL_USED;                     /* DS:8192 */
extern unsigned int SEGMENT_POOL_FREE_LIST;                     /* DS:8194 */
extern unsigned int C_PARAM_POOL_SEG;                     /* DS:8196 */
extern char SAVED_OPTION_BLOCK[];                           /* DS:819E */
extern unsigned int SOURCE_FILE_LIST;                     /* DS:822E */
extern unsigned int CURRENT_BANK_INDEX;                     /* DS:8230 */
extern unsigned int DIRECTIVE_MODE;                 /* DS:8232 */
extern unsigned int LINE_RECORD;                    /* DS:8234 */
extern unsigned int POOL_A;                         /* DS:823E */
extern unsigned int POOL_A_STEP;                    /* DS:8240 */
extern unsigned int POOL_A_UNIT;                    /* DS:8242 */
extern char LINKER_Y_SWITCH_FLAGS[];                           /* DS:8243 */
extern unsigned int POOL_A_USED;                    /* DS:8244 */
extern unsigned int TOKEN_POOL;                     /* DS:8246 */
extern unsigned int TOKEN_POOL_STEP;                /* DS:8248 */
extern unsigned int TOKEN_POOL_UNIT;                /* DS:824A */
extern unsigned int TOKEN_POOL_USED;                /* DS:824C */
extern unsigned int LINE_POOL;                      /* DS:8258 */
extern unsigned int LINE_POOL_STEP;                 /* DS:825A */
extern unsigned int CONDITION_MARK;                 /* DS:825C */
extern char LINKER_T_SWITCH_FLAGS[];                           /* DS:825D */
extern unsigned int CONDITION_STATE;                /* DS:825E */
extern unsigned int TOKEN_FILE_NODE;                     /* DS:8263 */
extern unsigned int TOKEN_LINE;                     /* DS:8265 */
extern unsigned int TOKEN_LENGTH;                     /* DS:8267 */
extern unsigned int CONTEXT_SEG;                    /* DS:8274 */
extern unsigned int CONTEXT_SEG_STEP;               /* DS:8276 */
extern unsigned int CONTEXT_SEG_UNIT;               /* DS:8278 */
extern unsigned int CONTEXT_SEG_USED;               /* DS:827A */
extern unsigned int INPUT_BUFFER;                   /* DS:827C */
extern unsigned int INPUT_ACTIVE;                   /* DS:827E */
extern unsigned int FREE_MACRO_CONTEXT_LIST;                     /* DS:8280 */
extern unsigned int INPUT_UNGET_FLAG;               /* DS:8282 */
extern unsigned int CURRENT_FILE_CONTEXT;                     /* DS:8284 */
extern unsigned int LEXER_INIT_CLEARED_WORD;                     /* DS:8286 */
extern int INPUT_UNGET_CHAR;                        /* DS:8288 */
extern unsigned int STRING_DATA;                    /* DS:828A */
extern long INPUT_FILE_POS;                         /* DS:828E */
extern unsigned int ECHO_NEXT_LINE;                     /* DS:8294 */
extern unsigned int CURRENT_SYMBOL;                 /* DS:8296 */
extern unsigned int BREAK_POLL_COUNTER;                  /* DS:8298 */
extern unsigned int COMPILE_FAILED;                     /* DS:829E */
extern unsigned char C51_Y_LINK_OPTIONS[26];        /* DS:82A4 */
extern unsigned char C51_T_LINK_OPTIONS[26];        /* DS:82BE */
extern char near TOKEN_TEXT[3];                     /* DS:82D8 */
extern unsigned int BSS_SEGMENT_NAME;                     /* DS:82DC */
extern unsigned int C52_FAR_SERIAL;                 /* DS:82DE */
extern unsigned int CODE_SEGMENT_NAME;                     /* DS:82E2 */
extern unsigned int BSS_GROUP_NAME;                     /* DS:82E4 */
extern unsigned int DATA_BSS_GROUPS_DIFFER;                     /* DS:82E6 */
extern unsigned int SYMBOL_A1;                      /* DS:82E8 */
extern unsigned int CODE_GROUP_NAME;                     /* DS:82EA */
extern unsigned int BSS_SEGMENT_SEPARATE;                     /* DS:82EC */
extern unsigned int BSS_CLASS_NAME;                     /* DS:82EE */
extern unsigned int SYMBOL_A2;                      /* DS:82F0 */
extern unsigned int CODE_CLASS_NAME;                     /* DS:82F2 */
extern char near C52_MODULE_NAME[];                 /* DS:82F4 */
extern unsigned int PSEUDO_REG_BP_SYMBOL;                     /* DS:82FE */
extern unsigned int PSEUDO_REG_SP_SYMBOL;                     /* DS:8300 */
extern unsigned int DATA_SEGMENT_NAME;                     /* DS:8302 */
extern unsigned int SYMBOL_B1;                      /* DS:8304 */
extern unsigned int DATA_GROUP_NAME;                     /* DS:8306 */
extern unsigned int BACKEND_MODE3_TYPE;                     /* DS:8308 */
extern unsigned int SYMBOL_B2;                      /* DS:830A */
extern unsigned int DATA_CLASS_NAME;                     /* DS:830C */
extern unsigned int MALLOC_POOL_LENGTH_MARK;                     /* DS:830E */
extern unsigned int MALLOC_POOL_SEG;                     /* DS:8310 */
extern unsigned int MALLOC_POOL_LENGTH;                     /* DS:8314 */
extern unsigned int MALLOC_POOL_WORD6;                     /* DS:8316 */
extern unsigned int BCC_LINE_OFFSET;                /* DS:8318 */
extern unsigned int BCC_LINE_SEGMENT;               /* DS:831A */
extern unsigned int PENDING_EXTERN_RECORD_TYPE;                     /* DS:831C */
extern unsigned char ASM_MNEMONIC_FLAGS;                    /* DS:831E */
extern char ASM_STATEMENT_BUFFER[];                           /* DS:831F */
extern unsigned int PREAMBLE_POOL_SEG;                     /* DS:8524 */
extern unsigned int PREAMBLE_POOL_CAPACITY;                     /* DS:8526 */
extern unsigned int PREAMBLE_POOL_USED;                     /* DS:8528 */
extern unsigned int PREAMBLE_POOL_FREE_LIST;                     /* DS:852A */
extern unsigned char PCH_DIAGNOSTIC_ISSUED;                    /* DS:852C */
extern unsigned int PCH_DEPENDENCY_TAIL;                     /* DS:852E */
extern char near PREAMBLE_PUSHBACK_BUFFER[];                       /* DS:8530 */
extern unsigned int PCH_DEPENDENCY_HEAD;                     /* DS:85B0 */
extern unsigned int PREAMBLE_REMAINDER_NODE;                     /* DS:85B2 */
extern int PREAMBLE_IF_DEPTH;                              /* DS:85B4 */
extern unsigned int MACRO_SNAPSHOT_POOL_SEG;                     /* DS:85B6 */
extern unsigned int MACRO_SNAPSHOT_POOL_CAPACITY;                     /* DS:85B8 */
extern unsigned int MACRO_SNAPSHOT_POOL_USED;                     /* DS:85BA */
extern unsigned int MACRO_SNAPSHOT_POOL_FREE;                     /* DS:85BC */
extern unsigned int PREAMBLE_MISMATCH_NODE;                     /* DS:85BE */
extern unsigned int PCH_INDEX_POOL_SEG;                     /* DS:85C0 */
extern unsigned int PCH_INDEX_POOL_CAPACITY;                     /* DS:85C2 */
extern unsigned int PCH_INDEX_POOL_USED;                     /* DS:85C4 */
extern unsigned int PCH_INDEX_POOL_FREE;                     /* DS:85C6 */
extern unsigned int PCH_FILE_MAGIC;                     /* DS:85C8 */
extern unsigned int PCH_HEADER_VERSION;                     /* DS:85CA */
extern long PCH_INDEX_FILE_OFFSET;                             /* DS:85CC */
extern unsigned int PCH_INDEX_FILE_SIZE;                     /* DS:85D0 */
extern int PCH_FILE_HANDLE;                              /* DS:85D2 */
extern unsigned int PREAMBLE_REPLAY_NODE;                     /* DS:85D4 */
extern unsigned int PREAMBLE_LIST_TAIL;                     /* DS:85D6 */
extern unsigned char PCH_SAVE_PENDING;                    /* DS:85D8 */
extern unsigned int PREAMBLE_LIST_HEAD;                     /* DS:85DA */
extern unsigned int PCH_DEPENDENCY_POOL_SEG;                     /* DS:85DC */
extern unsigned int PCH_DEPENDENCY_POOL_CAPACITY;                     /* DS:85DE */
extern unsigned int PCH_DEPENDENCY_POOL_USED;                     /* DS:85E0 */
extern unsigned int PCH_DEPENDENCY_POOL_FREE;                     /* DS:85E2 */
extern unsigned int SAVED_OPTION_POOL_SEG;                     /* DS:85E4 */
extern unsigned int SAVED_OPTION_POOL_CAPACITY;                     /* DS:85E6 */
extern unsigned int SAVED_OPTION_POOL_USED;                     /* DS:85E8 */
extern unsigned int SAVED_OPTION_POOL_FREE;                     /* DS:85EA */
extern signed char PCH_COLLECT_DEPENDENCIES;                      /* DS:85EC */
extern unsigned int CALL_ARGUMENT_NUMBER;                     /* DS:85EE */
extern unsigned int CALL_FUNCTION_EXPR;                     /* DS:85F0 */
extern unsigned int C_UNNAMED_GLOBAL_LIST;                     /* DS:85F2 */
extern unsigned int C_GLOBAL_SCOPE;                     /* DS:85F4 */
extern char C_FUNCTION_NAME_BUFFER[];                            /* DS:85F6 */
extern unsigned int C_FUNCTION_SCOPE;                     /* DS:8618 */
extern unsigned int C_OLD_STYLE_PARAM_LIST;                     /* DS:861A */
extern unsigned int PARAM_NAME;                     /* DS:861C */
extern unsigned int C_DECL_CALL_CONVENTION;                     /* DS:861E */
extern unsigned int C_DECL_DISTANCE;                     /* DS:8620 */
extern unsigned int C_DECLARATOR_NAME;                     /* DS:8622 */
extern unsigned int C_DECL_SOURCE_LINE;                     /* DS:8626 */
extern unsigned long C_DECL_START_POSITION;                    /* DS:8628 */
extern unsigned int C_DECL_START_POSITION_HIGH;                     /* DS:862A */
extern unsigned int C_CURRENT_FUNCTION_SYMBOL;                     /* DS:862C */
extern unsigned int C_DECL_SOURCE_FILE;                     /* DS:8630 */
extern unsigned int DECLARATOR_NAME_FILE;                     /* DS:8632 */
extern unsigned int DECLARATOR_NAME;                     /* DS:8638 */
extern unsigned int DECLARATOR_NAME_LINE;                     /* DS:863C */
extern unsigned int OUTPUT_BUFFER_FILL;                     /* DS:863E */
extern unsigned int OUTPUT_BUFFER_SEG;                     /* DS:8642 */
extern unsigned int ASM_OUTPUT_PATH;                     /* DS:8646 */
extern unsigned int BACKEND_OWNER_TAG;                     /* DS:8648 */
extern unsigned int BSS_SEGMENT_ID;                     /* DS:8652 */
extern unsigned int CODE_NODE_POOL_UNIT;                     /* DS:8658 */
extern unsigned int CODE_NODE_POOL_USED;                     /* DS:865A */
extern unsigned int REG_HISTORY_POOL_SEG;                     /* DS:8666 */
extern unsigned int HISTORY_END_OFFSET;                     /* DS:866A */
extern unsigned int REG_HISTORY_POOL_FREE_LIST;                     /* DS:866C */
extern unsigned int VARIABLE_TABLE_END;                     /* DS:8672 */
extern unsigned int VARIABLE_TABLE_FREE_LIST;                     /* DS:8674 */
extern unsigned int DEFAULT_CODE_SEGMENT_ID;                     /* DS:867E */
extern unsigned int CODE_OP_POOL_SEG;                     /* DS:8680 */
extern unsigned int CODE_OP_POOL_UNIT;                     /* DS:8684 */
extern unsigned int CODE_OP_POOL_USED;                     /* DS:8686 */
extern unsigned int CASE_ENTRY_POOL_SEG;                     /* DS:8688 */
extern unsigned int CASE_ENTRY_POOL_UNIT;                     /* DS:868C */
extern unsigned int CASE_ENTRY_POOL_USED;                     /* DS:868E */
extern unsigned int POOL_E;                         /* DS:8690 */
extern unsigned int POOL_E_STEP;                    /* DS:8692 */
extern unsigned int POOL_E_UNIT;                    /* DS:8694 */
extern unsigned int POOL_E_USED;                    /* DS:8696 */
extern unsigned int CODE_OPERAND_POOL_SEG;                     /* DS:8698 */
extern unsigned int CODE_OPERAND_POOL_UNIT;                     /* DS:869C */
extern unsigned int CODE_OPERAND_POOL_USED;                     /* DS:869E */
extern unsigned int POOL_F;                         /* DS:86A8 */
extern unsigned int POOL_F_STEP;                    /* DS:86AA */
extern unsigned int POOL_F_UNIT;                    /* DS:86AC */
extern unsigned int POOL_F_USED;                    /* DS:86AE */
extern unsigned int DATA_BYTE_POOL_LENGTH;                     /* DS:86B4 */
extern unsigned int DATA_BYTE_POOL_WORD6;                     /* DS:86B6 */
extern unsigned int LINE_NUMBER_POOL_SEG;                     /* DS:86B8 */
extern unsigned int LINE_NUMBER_POOL_USED;                     /* DS:86BC */
extern unsigned int LIVE_VALUE_POOL_SEG;                     /* DS:86C0 */
extern unsigned int LIVE_VALUE_POOL_USED;                     /* DS:86C4 */
extern unsigned int LIVE_VALUE_POOL_FREE_LIST;                     /* DS:86C6 */
extern unsigned int DATA_SEGMENT_ID;                     /* DS:86C8 */
extern unsigned int DEBUG_TYPE_COUNTER;                     /* DS:86CC */
extern unsigned int SELECTED_SEGMENT_ID;                     /* DS:86CE */
extern unsigned int SEGMENT_COUNT;                     /* DS:86D0 */
extern unsigned int CODE_OUTPUT_FLAGS;                     /* DS:86D2 */
extern unsigned int CODEGEN_FUNCTION_SYMBOL;                     /* DS:86D4 */
extern unsigned int FUNCTION_CODE_SEGMENT;                     /* DS:86D6 */
extern unsigned int FUNCTION_SOURCE_FILE;                     /* DS:86D8 */
extern unsigned int FUNCTION_START_LINE;                     /* DS:86DA */
extern unsigned int FUNCTION_SOURCE_POS_LOW;                     /* DS:86DC */
extern unsigned int FUNCTION_SOURCE_POS_HIGH;                     /* DS:86DE */
extern unsigned int CODE_BLOCK_LIST_HEAD;                     /* DS:86E0 */
extern unsigned int CODE_BLOCK_LIST_TAIL;                     /* DS:86E2 */
extern unsigned int FUNCTION_RETURN_LABEL;                     /* DS:86E4 */
extern unsigned int FRAME_LOCALS_SIZE;                     /* DS:86E6 */
extern unsigned int CODEGEN_PARAMS_SIZE;                     /* DS:86E8 */
extern unsigned int FRAME_HEADER_SIZE;                     /* DS:86EA */
extern unsigned int FUNCTION_OUTER_SCOPE_BLOCK;                     /* DS:86EC */
extern unsigned int CODEGEN_RETURN_TYPE;                     /* DS:86EE */
extern unsigned int CODEGEN_PARAM_LIST;                     /* DS:86F0 */
extern unsigned char CODEGEN_CALL_CONV;                    /* DS:86F2 */
extern unsigned int CODEGEN_FUNCTION_FLAGS;                     /* DS:86F3 */
extern unsigned int FUNCTION_SERIAL;                     /* DS:86F5 */
extern unsigned int CURRENT_CODE_BLOCK;                     /* DS:86F7 */
extern unsigned int CODE_OP_NEXT_INDEX;                     /* DS:86F9 */
extern unsigned int CODEGEN_USED_REG_MASK;                     /* DS:86FB */
extern unsigned int FUNCTION_CLAIMED_REG_MASK;                     /* DS:86FD */
extern unsigned int SAVED_REG_MASK;                     /* DS:86FF */
extern unsigned int LIVE_VALUE_SPILL_END;                     /* DS:8703 */
extern unsigned int LIVE_VALUE_END;                     /* DS:8705 */
extern unsigned int CURRENT_SCOPE_BLOCK;                     /* DS:8707 */
extern unsigned int JUMP_OPT_KEEP_EMPTY_BLOCKS;                     /* DS:8716 */
extern signed char RESOLVED_REQUEST_COUNT;                      /* DS:871A */
extern unsigned int CURRENT_INSN_INDEX;                     /* DS:871C */
extern unsigned int BLOCK_CLAIMED_REG_MASK;                     /* DS:871E */
extern unsigned int ALLOCATABLE_REGISTER_MASK;                     /* DS:8720 */
extern unsigned int REGALLOC_SCOPE_NODE;                     /* DS:8722 */
extern unsigned int PENDING_REGISTER_MASK;                     /* DS:8754 */
extern unsigned int BLOCK_FREE_REGISTER_MASK;                     /* DS:8756 */
extern signed char PENDING_RESULT_REGISTER;                      /* DS:8758 */
extern int PENDING_REQUEST_COUNT;                              /* DS:875A */
extern signed char SPILLED_REQUEST_COUNT;                      /* DS:875C */
extern unsigned int CROSS_JUMP_CHANGED;                     /* DS:875E */
extern unsigned int PEEPHOLE_STORE_STAMP;                     /* DS:8760 */
extern unsigned int PEEPHOLE_MEMORY_STORE_STAMP;                     /* DS:87C2 */
extern unsigned int OUTPUT_BUFFER_LIMIT;                     /* DS:883E */
extern unsigned int OUTPUT_BUFFER_POS;                     /* DS:8840 */
extern unsigned int CODE_BYTE_POOL_FREE_LIST;                     /* DS:8842 */
extern unsigned int CODE_FRAGMENT_POOL_SEG;                     /* DS:8844 */
extern unsigned int CODE_FRAGMENT_POOL_USED;                     /* DS:8848 */
extern unsigned int CODE_FRAGMENT_POOL_FREE_LIST;                     /* DS:884A */
extern unsigned int QUEUED_WORD_POOL_SEG;                     /* DS:884C */
extern unsigned int QUEUED_WORD_POOL_USED;                     /* DS:8850 */
extern unsigned int QUEUED_WORD_POOL_FREE;                     /* DS:8852 */
extern unsigned int SEG_DATA_BLOCK_POOL_SEG;                     /* DS:885C */
extern unsigned int RELOCATION_POOL_SEG;                     /* DS:8884 */
extern unsigned int SEGDEF_POOL_SEG;                     /* DS:8894 */
extern unsigned int FAR_SEGMENT_COUNT;                     /* DS:8898 */
extern unsigned int SEGMENT_LIST_TAIL;                     /* DS:88A0 */
extern unsigned int SELECTED_SEGDEF_ENTRY;                     /* DS:88A2 */
extern unsigned int SELECTED_SEGDEF_COPY;                     /* DS:88A4 */
extern unsigned int GROUP_LIST_HEAD;                     /* DS:88A6 */
extern unsigned int GROUP_LIST_TAIL;                     /* DS:88A8 */
extern unsigned int GROUP_COUNT;                     /* DS:88AA */
extern unsigned int ASM_OUTPUT_FLAGS;                     /* DS:88AC */
extern unsigned int PARAM_FRAME_BASE;                     /* DS:88AE */
extern unsigned char STACK_BALANCE_NEEDED;                    /* DS:88B5 */
extern unsigned int FRAME_PUSHED_REG_BYTES;                     /* DS:88B6 */
extern int CALL_ARG_SPLIT_COUNT;                              /* DS:88BA */
extern unsigned int near EVAL_STACK_VALUES[];              /* DS:88BC */
extern unsigned int near EVAL_STACK_TEMP_NODES[];              /* DS:88BE */
extern unsigned int POOLED_NODE_STACK[];                   /* DS:8A4C */
extern unsigned int OUTER_SCOPE_EXIT_VALUE;                     /* DS:8B16 */
extern unsigned int REGISTER_HISTORY_CURSOR;                     /* DS:8B18 */
extern unsigned int SWITCH_TABLE_LIST;                     /* DS:8B1A */
extern unsigned int CURRENT_CODE_FRAGMENT;                     /* DS:8B1C */
extern unsigned char FIRST_OPERAND_SEG_REG;                    /* DS:8B2A */
extern unsigned char FIRST_OPERAND_INDEX_REG;                    /* DS:8B2B */
extern unsigned char FIRST_OPERAND_REG;                    /* DS:8B2C */
extern unsigned int FIRST_OPERAND_VALUE;                     /* DS:8B2D */
extern unsigned char SECOND_OPERAND_SEG_REG;                    /* DS:8B33 */
extern unsigned char SECOND_OPERAND_INDEX_REG;                    /* DS:8B34 */
extern unsigned char SECOND_OPERAND_REG;                    /* DS:8B35 */
extern unsigned int SECOND_OPERAND_VALUE;                     /* DS:8B36 */
extern unsigned char near *OBJ_RECORD_CURSOR;              /* DS:8B44 */
extern unsigned int OBJ_RECORD_CHECKSUM;                     /* DS:8B46 */
extern unsigned int LINE_MARK_LAST_FILE;                     /* DS:8B48 */
extern unsigned int SAVE_SS;                        /* DS:8B4A */
extern unsigned int SAVE_SP;                        /* DS:8B4C */
extern char near ENV_BUFFER[];                      /* DS:8B4E */
extern char near SEARCH_BUFFER[];                   /* DS:8BCE */

/* Strings the code reaches by address (names made from their text by
   tools/namestrings.py; the original passes their DS offsets). */
extern char STR_C_7[];                              /* DS:0711 "C++" */
extern char STR_C_8[];                              /* DS:0715 "C" */
extern char STR_ARRAY_BOUNDS_2[];                   /* DS:35CF "Array bounds" */
extern char STR_DEBUG_C_2[];                        /* DS:3825 "+\r\n\t?debug\tC " */
extern char STR_EXTRN[];                            /* DS:3836 "\textrn\t" */
extern char STR_NEAR_3[];                           /* DS:383E "near" */
extern char STR_PUBLICDLL[];                        /* DS:3843 "\tpublicdll\t" */
extern char STR_PUBLIC_2[];                         /* DS:384F "\tpublic\t" */
extern char STR_EQU_S[];                            /* DS:3858 "\tequ\ts@+" */
extern char STR_EQU[];                              /* DS:3861 "\tequ\t" */
extern char STR_D[];                                /* DS:3875 "d@" */
extern char STR_B[];                                /* DS:3878 "b@" */
extern char STR_TURBOFLOAT_2[];                     /* DS:387C "__turboFloat" */
extern char STR_COLON_2[];                          /* DS:38F8 ":" */
extern char STR_AHSHIFT_2[];                        /* DS:3F5C "__AHSHIFT" */
extern char STR_SCOPY_2[];                          /* DS:3F8A "scopy@" */
extern char STR_FTOL[];                             /* DS:3F91 "ftol@" */
extern char STR_TEXT[];                             /* DS:52C8 "_TEXT" */
extern char STR_STKLEN_2[];                         /* DS:52CE "_stklen" */
extern char STR_BRKLVL[];                           /* DS:52D6 "__brklvl" */
extern char STR_N[];                                /* DS:52F7 "N_" */
extern char STR_F[];                                /* DS:52FA "F_" */
extern char STR_AHSHIFT[];                          /* DS:52FD "__AHSHIFT" */
extern char STR_SLXMUL[];                           /* DS:5338 ":Slxmul@" */
extern char STR_N_CHKSTK[];                         /* DS:5342 "N_CHKSTK@" */
extern char STR_F_CHKSTK[];                         /* DS:534C "F_CHKSTK@" */
extern char STR_COLON_CR_NL[];                      /* DS:540A ":\r\n" */
extern char STR_DEBUG_L[];                          /* DS:540E "\t?debug\tL " */
extern char STR_DW[];                               /* DS:5419 "dw\t" */
extern char STR_SHORT[];                            /* DS:541D "short " */
extern char STR_NEAR_PTR[];                         /* DS:5424 "near ptr " */
extern char STR_FAR_PTR[];                          /* DS:542E "far ptr " */
extern char STR_TAB_AT_AT[];                        /* DS:5437 "\t@@" */
extern char STR_JMP[];                              /* DS:543B "\tjmp\t" */
extern char STR_OBJ_3[];                            /* DS:54DA ".obj" */
extern char STR_DGROUP_2[];                         /* DS:54DF "DGROUP@" */
extern char STR_TC86_BORLAND_TURBO_C_2_0[];         /* DS:5537 "TC86 Borland Turbo C++ 2.0" */
extern char STR_MOV_BX_SP[];                        /* DS:55D1 "\tmov\tbx,sp\r\n" */
extern char STR_ADD_SS_BX[];                        /* DS:55DE "\tadd\tss:[bx+" */
extern char STR_RBRACKET_COMMA[];                   /* DS:55EB "]," */
extern char STR_JMP_FAR_PTR[];                      /* DS:55EE "\r\n\tjmp\tfar ptr " */
extern char STR_JMP_NEAR_PTR[];                     /* DS:55FE "\r\n\tjmp\tnear ptr " */
extern char STR_ASM_2[];                            /* DS:560F ".asm" */
extern char STR_286[];                              /* DS:5614 "\t.286\r\n" */
extern char STR_287[];                              /* DS:561C "\t.287\r\n" */
extern char STR_286P[];                             /* DS:5624 "\t.286p\r\n" */
extern char STR_IFNDEF_VERSION_DEBUG_MACRO_E[];     /* DS:562D "\tifndef\t??version\r\n?debug\tmacro\r\n" */
extern char STR_QUOTE_CR_NL[];                      /* DS:5730 ""\r\n" */
extern char STR_GROUP[];                            /* DS:5734 "\tgroup\t" */
extern char STR_ASSUME_CS_2[];                      /* DS:573C "\tassume\tcs:" */
extern char STR_DS[];                               /* DS:5748 ",ds:" */
extern char STR_D_LABEL_BYTE_D_W_LABEL_WORD[];      /* DS:574D "d@\tlabel\tbyte\r\nd@w\tlabel\tword\r\n" */
extern char STR_B_LABEL_BYTE_B_W_LABEL_WORD[];      /* DS:576D "b@\tlabel\tbyte\r\nb@w\tlabel\tword\r\n" */
extern char STR_DEBUG_C_E9[];                       /* DS:578D "\t?debug\tC E9\r\n" */
extern char STR_S_LABEL_BYTE[];                     /* DS:579C "s@\tlabel\tbyte\r\n" */
extern char STR_EXTRN_DGROUP_WORD[];                /* DS:57B1 "\textrn\tDGROUP@:word\r\n" */
extern char STR_EXTRN_TURBOFLOAT_WORD[];            /* DS:57C7 "\textrn\t__turboFloat:word\r\n" */
extern char STR_JMP_WORD_PTR_CS[];                  /* DS:57EA "\tjmp\tword ptr cs:@" */
extern char STR_C_6[];                              /* DS:57FD "@C" */
extern char STR_BX[];                               /* DS:5800 "[bx]\r\n" */
extern char STR_MOV_BX_OFFSET[];                    /* DS:5807 "\tmov\tbx,offset " */
extern char STR_MOV[];                              /* DS:5817 "\tmov\t" */
extern char STR_CS_DGROUP[];                        /* DS:581D ",cs:DGROUP@\r\n" */
extern char STR_JMP_WORD_PTR_CS_BX[];               /* DS:582B "\tjmp\tword ptr cs:[bx+" */
extern char STR_DEBUG_C_3[];                        /* DS:5873 "\t?debug\tC " */
extern char STR_DEBUG_C_4[];                        /* DS:587E "+\r\n\t?debug\tC " */
extern char STR_PUSH_CS_CALL[];                     /* DS:588C "push\tcs\r\n\tcall\t" */
extern char STR_DB_0CBH[];                          /* DS:589C "db\t0cbh\r\n" */
extern char STR_FCOMPP[];                           /* DS:58A6 "FCOMPP\r\n" */
extern char STR_P_ST[];                             /* DS:58AF "P\tst(" */
extern char STR_ST_0[];                             /* DS:58B5 "),st( 0 )\r\n" */
extern char STR_ST_0_ST[];                          /* DS:58C1 "st(0),st(" */
extern char STR_0[];                                /* DS:58CB ",0\r\n" */
extern char STR_AX_AX[];                            /* DS:58D0 "ax,ax," */
extern char STR_COMM[];                             /* DS:58FE "\tcomm\t" */
extern char STR_FAR_3[];                            /* DS:5905 "far " */
extern char STR_NEAR_4[];                           /* DS:590A "near " */
extern char STR_COMM_2[];                           /* DS:5910 "\t$comm\t" */
extern char STR_FAR_4[];                            /* DS:5918 "far," */
extern char STR_NEAR_5[];                           /* DS:591D "near," */
extern char STR_BYTE[];                             /* DS:5979 "\rbyte" */
extern char STR_WORD[];                             /* DS:597F "word" */
extern char STR_FAR_2[];                            /* DS:5990 "far" */
extern char STR_SEGMENT[];                          /* DS:5994 "\tsegment " */
extern char STR_PARA[];                             /* DS:599E "para" */
extern char STR_PUBLIC[];                           /* DS:59A3 " public " */
extern char STR_CRLF_3[];                           /* DS:59AC "\r\n" */
extern char STR_SEGMENT_VIRTUAL[];                  /* DS:59AF "\tsegment\tvirtual\r\n" */
extern char STR_DB_2[];                             /* DS:59C2 "\tdb\t" */
extern char STR_DUP_0[];                            /* DS:59C7 " dup (0)\r\n" */
extern char STR_DUP[];                              /* DS:59D2 " dup (?)\r\n" */
extern char STR_ASSUME_CS[];                        /* DS:59DD "\tassume\tcs:" */
extern char STR_PROC[];                             /* DS:59E9 "\tproc\t" */
extern char STR_NEAR_2[];                           /* DS:59F0 "near" */
extern char STR_LABEL[];                            /* DS:59F5 "\tlabel\t" */
extern char STR_DW_2[];                             /* DS:5A05 "\tdw\t" */
extern char STR_DD[];                               /* DS:5A0A "\tdd\t" */
extern char STR_C_5[];                              /* DS:5A0F "@C" */
extern char STR_LABEL_WORD[];                       /* DS:5A12 "\tlabel\tword\r\n" */
extern char STR_FIARQQ[];                           /* DS:5AC4 "FIARQQ" */
extern char STR_FJARQQ[];                           /* DS:5ACB "FJARQQ" */
extern char STR_FIERQQ[];                           /* DS:5AD2 "FIERQQ" */
extern char STR_FISRQQ[];                           /* DS:5AD9 "FISRQQ" */
extern char STR_FJSRQQ[];                           /* DS:5AE0 "FJSRQQ" */
extern char STR_FICRQQ[];                           /* DS:5AE7 "FICRQQ" */
extern char STR_FJCRQQ[];                           /* DS:5AEE "FJCRQQ" */
extern char STR_FIDRQQ[];                           /* DS:5AF5 "FIDRQQ" */

/* Strings the code reaches by address (names made from their text by
   tools/namestrings.py; the original passes their DS offsets). */
extern char STR_RPAREN[];                           /* DS:58D7 ")" */
extern char STR_SEG[];                              /* DS:58D9 "seg " */
extern char STR_BYTE_2[];                           /* DS:58DE "byte" */
extern char STR_QWORD[];                            /* DS:58E3 "qword" */
extern char STR_DWORD[];                            /* DS:58E9 "dword" */
extern char STR_TBYTE[];                            /* DS:58EF "tbyte" */
extern char STR_FAR_5[];                            /* DS:58F5 "far" */
extern char STR_NEAR_6[];                           /* DS:58F9 "near" */

extern signed char REGISTER_NEED_TABLE[];           /* DS:51DF: register need by operator class (x21) and value kind */
extern char STR_END_CRLF_EOF[];                     /* DS:57E2 "\tend\r\n\x1a" */

#endif

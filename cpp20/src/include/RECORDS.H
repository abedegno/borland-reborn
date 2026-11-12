/* RECORDS.H: the layout of BCC's pool records as C structs, for reading and for a port.
   Generated from FIELDS.H and the access widths the code uses
   (generated during the readability pass).  The recovered sources do not use these
   structs: they read records with the POOL.H accessors and the FIELDS.H offsets, because
   that is how the original reached them -- rewriting the reads as struct members compiles
   to different code in 65 of the 89 files that read records (tested), so the
   original evidently used offsets, not members.  Members sharing an offset are a union;
   a field that would overlap another member is left out.  FAM_AT(r) is record r of the
   family's pool and FAM_ES(r) the same record reached through ES.  Byte-packed. */
#ifndef RECORDS_H
#define RECORDS_H
#include <dos.h>
struct BaseEntry {
    unsigned int next;                  /* 0x00 BASE_NEXT */
    unsigned int type;                  /* 0x02 BASE_TYPE */
    unsigned int offset;                /* 0x04 BASE_OFFSET */
    unsigned char public_;               /* 0x06 BASE_PUBLIC */
    unsigned char virtual_;              /* 0x07 BASE_VIRTUAL */
    unsigned char used;                  /* 0x08 BASE_USED */
};
#define BASE_AT(r) ((struct BaseEntry far *)MK_FP(BASE_LIST_SEG,(r)))
#define BASE_ES(r) ((struct BaseEntry far *)MK_FP(_ES,(r)))
struct FlowBlock {
    unsigned int kind;                  /* 0x00 CNODE_KIND */
    unsigned int jump_refs;             /* 0x02 CNODE_JUMP_REFS */
    union {
        unsigned int first_op;          /* 0x04 CNODE_FIRST_OP */
        unsigned int scope_reg_mask;    /* 0x04 CNODE_SCOPE_REG_MASK */
    } u04;
    unsigned int op_count;              /* 0x06 CNODE_OP_COUNT */
    unsigned int jump_kind;             /* 0x08 CNODE_JUMP_KIND */
    unsigned int history;               /* 0x0A CNODE_HISTORY */
    unsigned int next;                  /* 0x0C CNODE_NEXT */
    unsigned int prev;                  /* 0x0E CNODE_PREV */
    union {
        unsigned int target;            /* 0x10 CNODE_TARGET */
        unsigned int scope_entry;       /* 0x10 CNODE_SCOPE_ENTRY */
        unsigned int scope_parent;      /* 0x10 CNODE_SCOPE_PARENT */
    } u10;
    union {
        unsigned int case_list;         /* 0x12 CNODE_CASE_LIST */
        unsigned int scope_info;        /* 0x12 CNODE_SCOPE_INFO */
    } u12;
    unsigned int scope_own_regs;        /* 0x14 CNODE_SCOPE_OWN_REGS */
    union {
        unsigned int switch_low_op;     /* 0x16 CNODE_SWITCH_LOW_OP */
        unsigned int scope_child;       /* 0x16 CNODE_SCOPE_CHILD */
    } u16;
    union {
        unsigned int switch_high_op;    /* 0x18 CNODE_SWITCH_HIGH_OP */
        unsigned int scope_sibling;     /* 0x18 CNODE_SCOPE_SIBLING */
    } u18;
    char pad_1A[2];
    unsigned int flags;                 /* 0x1C CNODE_FLAGS */
    unsigned int fragment;              /* 0x1E CNODE_FRAGMENT */
    unsigned int pred_list;             /* 0x20 CNODE_PRED_LIST */
    unsigned int pred_next;             /* 0x22 CNODE_PRED_NEXT */
    unsigned int loop_weight;           /* 0x24 CNODE_LOOP_WEIGHT */
};
#define CNODE_AT(r) ((struct FlowBlock far *)MK_FP(FLOW_BLOCK_POOL_SEG,(r)))
#define CNODE_ES(r) ((struct FlowBlock far *)MK_FP(_ES,(r)))
struct ConsCell {
    unsigned int next;                  /* 0x00 CONS_NEXT */
    unsigned int value;                 /* 0x02 CONS_VALUE */
};
#define CONS_AT(r) ((struct ConsCell far *)MK_FP(CONS_CELL_POOL_SEG,(r)))
#define CONS_ES(r) ((struct ConsCell far *)MK_FP(_ES,(r)))
struct CodeOp {
    unsigned char opcode;                /* 0x00 COP_OPCODE */
    unsigned char flags;                 /* 0x01 COP_FLAGS */
    unsigned char register_;             /* 0x02 COP_REGISTER */
    unsigned char reg_class;             /* 0x03 COP_REG_CLASS */
};
#define COP_AT(r) ((struct CodeOp far *)MK_FP(CODE_OP_POOL_SEG,(r)))
#define COP_ES(r) ((struct CodeOp far *)MK_FP(_ES,(r)))
struct CParam {
    unsigned char reg_mark;              /* 0x00 CPARM_REG_MARK */
    unsigned char byte1;                 /* 0x01 CPARM_BYTE1 */
    unsigned int type;                  /* 0x02 CPARM_TYPE */
    unsigned int name;                  /* 0x04 CPARM_NAME */
    unsigned int next;                  /* 0x06 CPARM_NEXT */
};
#define CPARM_AT(r) ((struct CParam far *)MK_FP(C_PARAM_POOL_SEG,(r)))
#define CPARM_ES(r) ((struct CParam far *)MK_FP(_ES,(r)))
struct CSymbol {
    unsigned int next;                  /* 0x00 CSYM_NEXT */
    unsigned int name;                  /* 0x02 CSYM_NAME */
    unsigned char namespace;             /* 0x04 CSYM_NAMESPACE */
    unsigned char class_;                /* 0x05 CSYM_CLASS */
    unsigned int flags;                 /* 0x06 CSYM_FLAGS */
    union {
        unsigned int type;              /* 0x08 CSYM_TYPE */
        unsigned int prep_flags;        /* 0x08 CSYM_PREP_FLAGS */
    } u08;
    unsigned int var_entry;             /* 0x0A CSYM_VAR_ENTRY */
    unsigned int segment;               /* 0x0C CSYM_SEGMENT */
    union {
        unsigned int offset;            /* 0x0E CSYM_OFFSET */
        unsigned int label;             /* 0x0E CSYM_LABEL */
    } u0E;
};
#define CSYM_AT(r) ((struct CSymbol far *)MK_FP(CSYM_POOL_SEG,(r)))
#define CSYM_ES(r) ((struct CSymbol far *)MK_FP(_ES,(r)))
struct InputContext {
    union {
        unsigned int file_handle;       /* 0x00 CTX_FILE_HANDLE */
        unsigned int kind;              /* 0x00 CTX_KIND */
    } u00;
    unsigned int length;                /* 0x02 CTX_LENGTH */
    unsigned int read_pos;              /* 0x04 CTX_READ_POS */
    unsigned int buffer_seg_var;        /* 0x06 CTX_BUFFER_SEG_VAR */
    unsigned int buffer_base;           /* 0x08 CTX_BUFFER_BASE */
    unsigned int prev;                  /* 0x0A CTX_PREV */
    union {
        unsigned int saved_file_name;   /* 0x0C CTX_SAVED_FILE_NAME */
        unsigned int macro_args;        /* 0x0C CTX_MACRO_ARGS */
    } u0C;
    union {
        unsigned int saved_line;        /* 0x0E CTX_SAVED_LINE */
        unsigned int macro_hlink;       /* 0x0E CTX_MACRO_HLINK */
    } u0E;
    union {
        unsigned int saved_serial_node; /* 0x10 CTX_SAVED_SERIAL_NODE */
        unsigned int macro_def;         /* 0x10 CTX_MACRO_DEF */
    } u10;
    unsigned int file_pos;              /* 0x12 CTX_FILE_POS */
    unsigned int saved_line_record;     /* 0x14 CTX_SAVED_LINE_RECORD */
};
#define CTX_AT(r) ((struct InputContext far *)MK_FP(CONTEXT_SEG,(r)))
#define CTX_ES(r) ((struct InputContext far *)MK_FP(_ES,(r)))
struct Declarator {
    signed char kind;                  /* 0x00 DCLR_KIND */
    signed char flags;                 /* 0x01 DCLR_FLAGS */
    long array_size;            /* 0x02 DCLR_ARRAY_SIZE */
    signed char call_conv;             /* 0x06 DCLR_CALL_CONV */
    signed char distance;              /* 0x07 DCLR_DISTANCE */
    signed char extra_mods;            /* 0x08 DCLR_EXTRA_MODS */
    union {
        unsigned int params;            /* 0x09 DCLR_PARAMS */
        unsigned int ptr_base;          /* 0x09 DCLR_PTR_BASE */
    } u09;
    unsigned int child;                 /* 0x0B DCLR_CHILD */
};
#define DCLR_AT(r) ((struct Declarator far *)MK_FP(DECLARATOR_NODE_POOL_SEG,(r)))
#define DCLR_ES(r) ((struct Declarator far *)MK_FP(_ES,(r)))
struct ExprNode {
    unsigned int op;                    /* 0x00 EXPR_OP */
    unsigned int kind;                  /* 0x02 EXPR_KIND */
    unsigned char qual_flags;            /* 0x04 EXPR_QUAL_FLAGS */
    char pad_05[1];
    unsigned char node_flags;            /* 0x06 EXPR_NODE_FLAGS */
    unsigned char node_flags2;           /* 0x07 EXPR_NODE_FLAGS2 */
    unsigned int type;                  /* 0x08 EXPR_TYPE */
    union {
        unsigned int left;              /* 0x0A EXPR_LEFT */
        long value;             /* 0x0A EXPR_VALUE */
    } u0A;
    union {
        unsigned int scope_class;       /* 0x0E EXPR_SCOPE_CLASS */
        unsigned int member_name;       /* 0x0E EXPR_MEMBER_NAME */
    } u0E;
    unsigned int name_kind;             /* 0x10 EXPR_NAME_KIND */
    char pad_12[2];
    unsigned int src_file;              /* 0x14 EXPR_SRC_FILE */
    unsigned int src_line;              /* 0x16 EXPR_SRC_LINE */
    unsigned int src_word3;             /* 0x18 EXPR_SRC_WORD3 */
};
#define EXPR_AT(r) ((struct ExprNode far *)MK_FP(EXPR_POOL_SEG,(r)))
#define EXPR_ES(r) ((struct ExprNode far *)MK_FP(_ES,(r)))
struct CacheEntry {
    unsigned int next;                  /* 0x00 FNCACHE_NEXT */
    unsigned int function;              /* 0x02 FNCACHE_FUNCTION */
    unsigned int list;                  /* 0x04 FNCACHE_LIST */
};
#define FNCACHE_AT(r) ((struct CacheEntry far *)MK_FP(CACHE_POOL,(r)))
#define FNCACHE_ES(r) ((struct CacheEntry far *)MK_FP(_ES,(r)))
struct Formal {
    unsigned int next;                  /* 0x00 FORMAL_NEXT */
    unsigned int type;                  /* 0x02 FORMAL_TYPE */
    unsigned int name;                  /* 0x04 FORMAL_NAME */
    unsigned char is_register;           /* 0x06 FORMAL_IS_REGISTER */
    unsigned char implicit;              /* 0x07 FORMAL_IMPLICIT */
    unsigned int default_arg;           /* 0x08 FORMAL_DEFAULT_ARG */
};
#define FORMAL_AT(r) ((struct Formal far *)MK_FP(FORMAL_POOL_SEG,(r)))
#define FORMAL_ES(r) ((struct Formal far *)MK_FP(_ES,(r)))
struct Fragment {
    union {
        unsigned int next;              /* 0x00 FRAG_NEXT */
        unsigned int fragfix_offset;    /* 0x00 FRAGFIX_OFFSET */
    } u00;
    union {
        unsigned int code_start;        /* 0x02 FRAG_CODE_START */
        unsigned int fragfix_target;    /* 0x02 FRAGFIX_TARGET */
    } u02;
    union {
        unsigned int mark_value;        /* 0x04 FRAG_MARK_VALUE */
        unsigned int size;              /* 0x04 FRAG_SIZE */
        unsigned int fragfix_kind;      /* 0x04 FRAGFIX_KIND */
    } u04;
    unsigned int start_offset;          /* 0x06 FRAG_START_OFFSET */
    unsigned int jump_kind;             /* 0x08 FRAG_JUMP_KIND */
    unsigned int jump_target;           /* 0x0A FRAG_JUMP_TARGET */
    unsigned int fixups;                /* 0x0C FRAG_FIXUPS */
    union {
        unsigned int text_length;       /* 0x0E FRAG_TEXT_LENGTH */
        unsigned int fixup_count;       /* 0x0E FRAG_FIXUP_COUNT */
    } u0E;
    unsigned int first_line;            /* 0x10 FRAG_FIRST_LINE */
    unsigned int line_count;            /* 0x12 FRAG_LINE_COUNT */
    char pad_14[2];
    unsigned int flags;                 /* 0x16 FRAG_FLAGS */
};
#define FRAG_AT(r) ((struct Fragment far *)MK_FP(CODE_FRAGMENT_POOL_SEG,(r)))
#define FRAG_ES(r) ((struct Fragment far *)MK_FP(_ES,(r)))
struct NameLink {
    unsigned int next;                  /* 0x00 HLINK_NEXT */
    unsigned int macro;                 /* 0x02 HLINK_MACRO */
    unsigned int token;                 /* 0x04 HLINK_TOKEN */
};
#define HLINK_AT(r) ((struct NameLink far *)MK_FP(HASH_CHAIN_LINK_SEG,(r)))
#define HLINK_ES(r) ((struct NameLink far *)MK_FP(_ES,(r)))
struct Label {
    union {
        unsigned int next;              /* 0x00 LABEL_NEXT */
        unsigned int goto_next;         /* 0x00 GOTO_NEXT */
    } u00;
    union {
        unsigned int name;              /* 0x02 LABEL_NAME */
        int goto_init_serial;  /* 0x02 GOTO_INIT_SERIAL */
    } u02;
    unsigned int block;                 /* 0x04 LABEL_BLOCK */
    union {
        int serial_low;        /* 0x06 LABEL_SERIAL_LOW */
        unsigned int goto_target;       /* 0x06 GOTO_TARGET */
    } u06;
    union {
        unsigned int serial_high;       /* 0x08 LABEL_SERIAL_HIGH */
        unsigned int goto_temps;        /* 0x08 GOTO_TEMPS */
    } u08;
    unsigned char defined;               /* 0x0A LABEL_DEFINED */
    unsigned int temps;                 /* 0x0B LABEL_TEMPS */
};
#define LABEL_AT(r) ((struct Label far *)MK_FP(LABEL_POOL_SEG,(r)))
#define LABEL_ES(r) ((struct Label far *)MK_FP(_ES,(r)))
struct LCellRec {
    union {
        unsigned int null_value;        /* 0x00 LCELL_NULL_VALUE */
        unsigned int next;              /* 0x00 LCELL_NEXT */
    } u00;
    unsigned int value;                 /* 0x02 LCELL_VALUE */
};
#define LCELL_AT(r) ((struct LCellRec far *)MK_FP(LIST_CELL_POOL_SEG,(r)))
#define LCELL_ES(r) ((struct LCellRec far *)MK_FP(_ES,(r)))
struct LineEntry {
    unsigned int line;                  /* 0x00 LINENUM_LINE */
    unsigned int offset;                /* 0x02 LINENUM_OFFSET */
};
#define LINENUM_AT(r) ((struct LineEntry far *)MK_FP(LINE_NUMBER_POOL_SEG,(r)))
#define LINENUM_ES(r) ((struct LineEntry far *)MK_FP(_ES,(r)))
struct LinkageEntry {
    unsigned int saved_linkage;         /* 0x00 LINKSTK_SAVED_LINKAGE */
    unsigned int next;                  /* 0x02 LINKSTK_NEXT */
};
#define LINKSTK_AT(r) ((struct LinkageEntry far *)MK_FP(LINKAGE_STACK_POOL_SEG,(r)))
#define LINKSTK_ES(r) ((struct LinkageEntry far *)MK_FP(_ES,(r)))
struct LiveValue {
    unsigned int op;                    /* 0x00 LVAL_OP */
    unsigned int use_count;             /* 0x02 LVAL_USE_COUNT */
};
#define LVAL_AT(r) ((struct LiveValue far *)MK_FP(LIVE_VALUE_POOL_SEG,(r)))
#define LVAL_ES(r) ((struct LiveValue far *)MK_FP(_ES,(r)))
struct Member {
    unsigned int memb_next;             /* 0x00 MEMB_NEXT */
    unsigned int memb_name;             /* 0x02 MEMB_NAME */
    union {
        unsigned char memb_flags;        /* 0x04 MEMB_FLAGS */
        unsigned int memb_c_offset;     /* 0x04 MEMB_C_OFFSET */
    } u04;
    union {
        unsigned int memb_value;        /* 0x06 MEMB_VALUE */
        unsigned char memb_c_bit_offset; /* 0x06 MEMB_C_BIT_OFFSET */
    } u06;
    union {
        unsigned int memb_type;         /* 0x08 MEMB_TYPE */
        unsigned char memb_c_flags;      /* 0x08 MEMB_C_FLAGS */
    } u08;
    unsigned int memb_class;            /* 0x0A MEMB_CLASS */
};
#define MEMBER_AT(r) ((struct Member far *)MK_FP(MEMBER_SEGMENT,(r)))
#define MEMBER_ES(r) ((struct Member far *)MK_FP(_ES,(r)))
struct MemInit {
    unsigned int next;                  /* 0x00 MINIT_NEXT */
    unsigned int target;                /* 0x02 MINIT_TARGET */
    unsigned int expr;                  /* 0x04 MINIT_EXPR */
};
#define MINIT_AT(r) ((struct MemInit far *)MK_FP(INIT_RECORD_POOL_SEG,(r)))
#define MINIT_ES(r) ((struct MemInit far *)MK_FP(_ES,(r)))
struct MacroSnapshot {
    unsigned char param_count;           /* 0x00 MSNAP_PARAM_COUNT */
};
#define MSNAP_AT(r) ((struct MacroSnapshot far *)MK_FP(MACRO_SNAPSHOT_POOL_SEG,(r)))
#define MSNAP_ES(r) ((struct MacroSnapshot far *)MK_FP(_ES,(r)))
struct NameRec {
    unsigned int symbols;               /* 0x00 NAME_SYMBOLS */
    unsigned int text_offset;           /* 0x02 NAME_TEXT_OFFSET */
    unsigned int text_bank;             /* 0x04 NAME_TEXT_BANK */
};
#define NAME_AT(r) ((struct NameRec far *)MK_FP(NAME_POOL_SEG,(r)))
#define NAME_ES(r) ((struct NameRec far *)MK_FP(_ES,(r)))
struct Operands {
    union {
        unsigned int left;              /* 0x00 OPND_LEFT */
        unsigned int variable;          /* 0x00 OPND_VARIABLE */
        unsigned char register_;         /* 0x00 OPND_REGISTER */
        unsigned long const_value;       /* 0x00 OPND_CONST_VALUE */
    } u00;
};
#define OPND_AT(r) ((struct Operands far *)MK_FP(CODE_OPERAND_POOL_SEG,(r)))
#define OPND_ES(r) ((struct Operands far *)MK_FP(_ES,(r)))
struct PchTrieNode {
    unsigned int next;                  /* 0x00 PCHTRIE_NEXT */
    unsigned int child;                 /* 0x02 PCHTRIE_CHILD */
    long file_pos;              /* 0x04 PCHTRIE_FILE_POS */
    long alloc_size;            /* 0x08 PCHTRIE_ALLOC_SIZE */
    unsigned int kind;                  /* 0x0C PCHTRIE_KIND */
};
#define PCHTRIE_AT(r) ((struct PchTrieNode far *)MK_FP(PCH_INDEX_POOL_SEG,(r)))
#define PCHTRIE_ES(r) ((struct PchTrieNode far *)MK_FP(_ES,(r)))
struct PchDependency {
    unsigned int next;                  /* 0x00 PDEP_NEXT */
    unsigned long file_time;             /* 0x02 PDEP_FILE_TIME */
};
#define PDEP_AT(r) ((struct PchDependency far *)MK_FP(PCH_DEPENDENCY_POOL_SEG,(r)))
#define PDEP_ES(r) ((struct PchDependency far *)MK_FP(_ES,(r)))
struct PreambleDir {
    unsigned int next;                  /* 0x00 PDIR_NEXT */
    unsigned int prev;                  /* 0x02 PDIR_PREV */
    unsigned int line;                  /* 0x04 PDIR_LINE */
    unsigned int kind;                  /* 0x06 PDIR_KIND */
};
#define PDIR_AT(r) ((struct PreambleDir far *)MK_FP(PREAMBLE_POOL_SEG,(r)))
#define PDIR_ES(r) ((struct PreambleDir far *)MK_FP(_ES,(r)))
struct StorageRec {
    char pad_00[6];
    unsigned int symbol;                /* 0x06 PSTOR_SYMBOL */
    unsigned int flags;                 /* 0x08 PSTOR_FLAGS */
};
#define PSTOR_AT(r) ((struct StorageRec far *)MK_FP(STORAGE_POOL_SEG,(r)))
#define PSTOR_ES(r) ((struct StorageRec far *)MK_FP(_ES,(r)))
struct QueuedWord {
    unsigned int value;                 /* 0x00 QWORD_VALUE */
};
#define QWORD_AT(r) ((struct QueuedWord far *)MK_FP(QUEUED_WORD_POOL_SEG,(r)))
#define QWORD_ES(r) ((struct QueuedWord far *)MK_FP(_ES,(r)))
struct Relocation {
    unsigned int next;                  /* 0x00 RELOC_NEXT */
    unsigned int offset;                /* 0x02 RELOC_OFFSET */
    unsigned int symbol;                /* 0x04 RELOC_SYMBOL */
    unsigned int kind;                  /* 0x06 RELOC_KIND */
};
#define RELOC_AT(r) ((struct Relocation far *)MK_FP(RELOCATION_POOL_SEG,(r)))
#define RELOC_ES(r) ((struct Relocation far *)MK_FP(_ES,(r)))
struct RegHistory {
    unsigned char action;                /* 0x00 RHIST_ACTION */
    unsigned char is_word;               /* 0x01 RHIST_IS_WORD */
    unsigned char register_;             /* 0x02 RHIST_REGISTER */
    unsigned int insn_index;            /* 0x03 RHIST_INSN_INDEX */
    unsigned int value_op;              /* 0x05 RHIST_VALUE_OP */
    unsigned int partner;               /* 0x07 RHIST_PARTNER */
};
#define RHIST_AT(r) ((struct RegHistory far *)MK_FP(REG_HISTORY_POOL_SEG,(r)))
#define RHIST_ES(r) ((struct RegHistory far *)MK_FP(_ES,(r)))
struct Scope {
    unsigned int parent;                /* 0x00 SCOPE_PARENT */
    unsigned int nest_level;            /* 0x02 SCOPE_NEST_LEVEL */
    union {
        unsigned int names;             /* 0x04 SCOPE_NAMES */
        unsigned int c_parent;          /* 0x04 SCOPE_C_PARENT */
    } u04;
    union {
        unsigned int tags;              /* 0x06 SCOPE_TAGS */
        unsigned int c_symbols;         /* 0x06 SCOPE_C_SYMBOLS */
    } u06;
    unsigned int enter_block;           /* 0x08 SCOPE_ENTER_BLOCK */
    unsigned int saved_link10_mark;     /* 0x0A SCOPE_SAVED_LINK10_MARK */
    unsigned int saved_type_length;     /* 0x0C SCOPE_SAVED_TYPE_LENGTH */
    unsigned int stmt_level;            /* 0x0E SCOPE_STMT_LEVEL */
    unsigned int temps;                 /* 0x10 SCOPE_TEMPS */
    unsigned int saved_init_serial;     /* 0x12 SCOPE_SAVED_INIT_SERIAL */
    unsigned char is_function;           /* 0x14 SCOPE_IS_FUNCTION */
};
#define SCOPE_AT(r) ((struct Scope far *)MK_FP(SCOPE_POOL_SEG,(r)))
#define SCOPE_ES(r) ((struct Scope far *)MK_FP(_ES,(r)))
struct DataBlock {
    unsigned int start;                 /* 0x00 SEGBLK_START */
    unsigned int length;                /* 0x02 SEGBLK_LENGTH */
    unsigned int relocs;                /* 0x04 SEGBLK_RELOCS */
    char pad_06[2];
    unsigned int next;                  /* 0x08 SEGBLK_NEXT */
};
#define SEGBLK_AT(r) ((struct DataBlock far *)MK_FP(SEG_DATA_BLOCK_POOL_SEG,(r)))
#define SEGBLK_ES(r) ((struct DataBlock far *)MK_FP(_ES,(r)))
struct SegDef {
    unsigned int next;                  /* 0x00 SEGDEF_NEXT */
    unsigned int group;                 /* 0x02 SEGDEF_GROUP */
    unsigned int index;                 /* 0x04 SEGDEF_INDEX */
    unsigned int first_block;           /* 0x06 SEGDEF_FIRST_BLOCK */
    unsigned int last_block;            /* 0x08 SEGDEF_LAST_BLOCK */
    unsigned int class_name;            /* 0x0A SEGDEF_CLASS_NAME */
    long size;                  /* 0x0C SEGDEF_SIZE */
    unsigned char align;                 /* 0x10 SEGDEF_ALIGN */
    unsigned int name;                  /* 0x11 SEGDEF_NAME */
    char pad_13[4];
    unsigned int buffer_base;           /* 0x17 SEGDEF_BUFFER_BASE */
    unsigned int parent_id;             /* 0x19 SEGDEF_PARENT_ID */
};
#define SEGDEF_AT(r) ((struct SegDef far *)MK_FP(SEGDEF_POOL_SEG,(r)))
#define SEGDEF_ES(r) ((struct SegDef far *)MK_FP(_ES,(r)))
struct SourceFile {
    unsigned int name;                  /* 0x00 SRCFILE_NAME */
    unsigned int line_count;            /* 0x02 SRCFILE_LINE_COUNT */
    unsigned int serial;                /* 0x04 SRCFILE_SERIAL */
    unsigned int debug_index;           /* 0x06 SRCFILE_DEBUG_INDEX */
    unsigned int segment;               /* 0x08 SRCFILE_SEGMENT */
    unsigned int first_node;            /* 0x0A SRCFILE_FIRST_NODE */
    unsigned int first_line;            /* 0x0C SRCFILE_FIRST_LINE */
};
#define SRCFILE_AT(r) ((struct SourceFile far *)MK_FP(SRCFILE_POOL_SEG,(r)))
#define SRCFILE_ES(r) ((struct SourceFile far *)MK_FP(_ES,(r)))
struct SwitchCase {
    unsigned int next;                  /* 0x00 SWCASE_NEXT */
    long value;                 /* 0x02 SWCASE_VALUE */
    unsigned int target;                /* 0x06 SWCASE_TARGET */
};
#define SWCASE_AT(r) ((struct SwitchCase far *)MK_FP(CASE_ENTRY_POOL_SEG,(r)))
#define SWCASE_ES(r) ((struct SwitchCase far *)MK_FP(_ES,(r)))
struct Symbol {
    union {
        unsigned int owner_class;       /* 0x00 SYM_OWNER_CLASS */
        unsigned int next;              /* 0x00 SYM_NEXT */
    } u00;
    unsigned int name;                  /* 0x02 SYM_NAME */
    unsigned int type;                  /* 0x04 SYM_TYPE */
    unsigned char flags;                 /* 0x06 SYM_FLAGS */
    unsigned char storage_class;         /* 0x07 SYM_STORAGE_CLASS */
    union {
        unsigned int storage;           /* 0x08 SYM_STORAGE */
        unsigned int const_value;       /* 0x08 SYM_CONST_VALUE */
        unsigned int alias_member;      /* 0x08 SYM_ALIAS_MEMBER */
    } u08;
    union {
        unsigned int func_flags;        /* 0x0A SYM_FUNC_FLAGS */
        unsigned int alias_object;      /* 0x0A SYM_ALIAS_OBJECT */
        unsigned int global_flags;      /* 0x0A SYM_GLOBAL_FLAGS */
    } u0A;
    unsigned char inline_access;         /* 0x0C SYM_INLINE_ACCESS */
    union {
        unsigned int intrinsic_num;     /* 0x0D SYM_INTRINSIC_NUM */
        unsigned int special_kind;      /* 0x0D SYM_SPECIAL_KIND */
        unsigned int inline_pos;        /* 0x0D SYM_INLINE_POS */
    } u0D;
    unsigned int func_kind;             /* 0x0F SYM_FUNC_KIND */
    unsigned int linkage;               /* 0x11 SYM_LINKAGE */
    unsigned int next_overload;         /* 0x13 SYM_NEXT_OVERLOAD */
    unsigned int virtual_index;         /* 0x15 SYM_VIRTUAL_INDEX */
};
#define SYM_AT(r) ((struct Symbol far *)MK_FP(SYMBOL_POOL_SEG,(r)))
#define SYM_ES(r) ((struct Symbol far *)MK_FP(_ES,(r)))
struct TagBody {
    unsigned int debug_id;              /* 0x00 TAG_DEBUG_ID */
    unsigned int members;               /* 0x02 TAG_MEMBERS */
    union {
        unsigned int enum_base;         /* 0x04 TAG_ENUM_BASE */
        unsigned int size;              /* 0x04 TAG_SIZE */
    } u04;
    unsigned int symbol;                /* 0x06 TAG_SYMBOL */
    unsigned int debug_class_index;     /* 0x08 TAG_DEBUG_CLASS_INDEX */
    char pad_0A[2];
    unsigned int bases;                 /* 0x0C TAG_BASES */
    unsigned int access_decls;          /* 0x0E TAG_ACCESS_DECLS */
    unsigned int vtable_size;           /* 0x10 TAG_VTABLE_SIZE */
    unsigned int vtable_symbol;         /* 0x12 TAG_VTABLE_SYMBOL */
    unsigned int this_type;             /* 0x14 TAG_THIS_TYPE */
    unsigned int own_size;              /* 0x16 TAG_OWN_SIZE */
    unsigned int class_flags;           /* 0x18 TAG_CLASS_FLAGS */
    unsigned int word_1a;               /* 0x1A TAG_DDVT_COUNT */
};
#define TAG_AT(r) ((struct TagBody far *)MK_FP(TAG_BODY_POOL_SEG,(r)))
#define TAG_ES(r) ((struct TagBody far *)MK_FP(_ES,(r)))
struct TempDtor {
    unsigned int next;                  /* 0x00 TDTOR_NEXT */
    unsigned int serial;                /* 0x02 TDTOR_SERIAL */
    unsigned int expr;                  /* 0x04 TDTOR_EXPR */
};
#define TDTOR_AT(r) ((struct TempDtor far *)MK_FP(TEMP_ENTRY_POOL_SEG,(r)))
#define TDTOR_ES(r) ((struct TempDtor far *)MK_FP(_ES,(r)))
struct TypeRec {
    unsigned int kind;                  /* 0x00 TYPE_KIND */
    unsigned char attrs;                 /* 0x02 TYPE_ATTRS */
    union {
        unsigned int member_class;      /* 0x03 TYPE_MEMBER_CLASS */
        unsigned int free_next;         /* 0x03 TYPE_FREE_NEXT */
        unsigned int c_size;            /* 0x03 TYPE_C_SIZE */
        unsigned int c_target;          /* 0x03 TYPE_C_TARGET */
    } u03;
    union {
        unsigned int tag_body;          /* 0x05 TYPE_TAG_BODY */
        unsigned int debug_id;          /* 0x05 TYPE_DEBUG_ID */
        unsigned int c_params;          /* 0x05 TYPE_C_PARAMS */
        unsigned int c_ptr_base;        /* 0x05 TYPE_C_PTR_BASE */
        unsigned int c_members;         /* 0x05 TYPE_C_MEMBERS */
    } u05;
    union {
        unsigned int target;            /* 0x07 TYPE_TARGET */
        signed char c_ptr_quals;       /* 0x07 TYPE_C_PTR_QUALS */
        unsigned char c_call_conv;       /* 0x07 TYPE_C_CALL_CONV */
        unsigned int c_tag_symbol;      /* 0x07 TYPE_C_TAG_SYMBOL */
    } u07;
    union {
        unsigned int params;            /* 0x09 TYPE_PARAMS */
        unsigned int ptr_base;          /* 0x09 TYPE_PTR_BASE */
        long array_count;       /* 0x09 TYPE_ARRAY_COUNT */
        unsigned char c_byte9;           /* 0x09 TYPE_C_BYTE9 */
    } u09;
    union {
        unsigned char ptr_mode;          /* 0x0D TYPE_PTR_MODE */
        unsigned int dim_expr;          /* 0x0D TYPE_DIM_EXPR */
    } u0D;
};
#define TYPE_AT(r) ((struct TypeRec far *)MK_FP(TYPE_POOL,(r)))
#define TYPE_ES(r) ((struct TypeRec far *)MK_FP(_ES,(r)))
struct Variable {
    unsigned int symbol;                /* 0x00 VAR_SYMBOL */
    unsigned int scope_block;           /* 0x02 VAR_SCOPE_BLOCK */
    char pad_04[2];
    unsigned char type_kind;             /* 0x06 VAR_TYPE_KIND */
    unsigned char register_;             /* 0x07 VAR_REGISTER */
    unsigned char preferred_reg;         /* 0x08 VAR_PREFERRED_REG */
    unsigned int segment;               /* 0x09 VAR_SEGMENT */
    unsigned int type;                  /* 0x0B VAR_TYPE */
    unsigned char symbol_kind;           /* 0x0D VAR_SYMBOL_KIND */
    unsigned char flags;                 /* 0x0E VAR_FLAGS */
    unsigned int frame_offset;          /* 0x0F VAR_FRAME_OFFSET */
    unsigned int use_count;             /* 0x11 VAR_USE_COUNT */
    unsigned int es_class_weight;       /* 0x13 VAR_ES_CLASS_WEIGHT */
    unsigned int index_weight;          /* 0x15 VAR_INDEX_WEIGHT */
    unsigned int shift_count_uses;      /* 0x17 VAR_SHIFT_COUNT_USES */
    unsigned int store_stamp;           /* 0x19 VAR_STORE_STAMP */
    unsigned int excluded_regs;         /* 0x1B VAR_EXCLUDED_REGS */
};
#define VAR_AT(r) ((struct Variable far *)MK_FP(VARIABLE_TABLE_SEG,(r)))
#define VAR_ES(r) ((struct Variable far *)MK_FP(_ES,(r)))
#endif

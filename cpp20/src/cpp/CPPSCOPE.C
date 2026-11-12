/* target: CPPSCOPE */
/* opts: -mm -O -Z -p -y -B */
/* CPP.EXE module CPPSCOPE (image 0xFE31..0xFFB9, frame 0FE3h): source taken from the
   BCC.EXE reconstruction (bcc20/src/cpp/CPPSCOPE.C). CPP.EXE has only six
   of its functions (ALLOC_TYPE_RECORD, ALLOC_ENUM_LINK, ALLOC_STRUCT_LINK, CREATE_TYPE,
   GET_TYPE_DEBUG_ID, SET_TYPE_DEBUG_ID), in the same order; left out here:
   C9_ALLOC_MEMBER, COPY_TYPE_RECORD, FIND_EQUIVALENT_TYPE, INTERN_QUALIFIED_TYPE,
   TOKEN_FROM_NAME, ALLOC_SYMBOL_ENTRY, BCC_TYPE_CREATE, DECLARE_TAG,
   DECLARE_MEMBER_ALIAS, C0FIND, FIND_NAME_IN_LIST, FIND_SYMBOL_IN_SCOPES, LOOKUP_NAME,
   C9_CLEAR_MEMBER_TABLES, CACHE_MEMBER_LOOKUP, FIND_MEMBER_BY_NAME, BCC_TYPE_PRIMARY,
   DECLARE_MEMBER, DECLARE_GLOBAL_SYMBOL, ALLOC_SCOPE, PUSH_SCOPE, POP_SCOPE,
   ALLOC_LABEL_RECORD, ALLOC_JUMP_RECORD, PREPARE_SYMBOL, GET_PREPARED_FLAGS,
   SET_PREPARED_FLAGS, GET_PREPARED_SYMBOL, CLEAR_PREPARED_FLAGS,
   SET_PREPARED_SYMBOL_FLAGS, C56_NAME_FLAGS, LIST_CONS, LIST_CELL_FREE, LIST_CONS_ALT,
   C0MARK, ALLOC_FORMAL_RECORD (their declarations, and the comments of a few, are left
   under section marks). CPP.EXE's edit is marked "CPP.EXE edit". */
/* Role: type record allocation. Entry points: CREATE_TYPE, GET_TYPE_DEBUG_ID,
   SET_TYPE_DEBUG_ID. */
/* Overview: in BCC this file held the C++ front end's basic tables (record allocation
   for types, members, symbols, scopes, formal parameters and list cells; name lookup;
   scopes; the storage records handed to the code generator). CPP.EXE keeps only the
   type-record part, which INITTYPE.C uses to build the scalar types for #if:
   - CREATE_TYPE allocates a zeroed record of a kind in TYPE_POOL (ALLOC_TYPE_RECORD);
     struct, union and enum types also get a tag body in TAG_BODY_POOL_SEG
     (ALLOC_STRUCT_LINK, ALLOC_ENUM_LINK).
   - GET_TYPE_DEBUG_ID and SET_TYPE_DEBUG_ID read and write a type's debugger type
     index (C9SCALAR in INITTYPE.C sets it from C9_TYPE_SIZES). */
/* BCC's file was compiled through TASM (-B) for its inline-assembly functions
   (FIND_EQUIVALENT_TYPE, FIND_MEMBER_BY_NAME). */
/* CPP.EXE keeps -B although none of the inline-assembly functions is left: its
   relocations for this module run in ascending order, the TASM signature (docs/FINDINGS.md). */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- (BCC's C9_ALLOC_MEMBER: not in CPP.EXE) ---- */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);


/* ---- (BCC's COPY_TYPE_RECORD: not in CPP.EXE) ---- */


/* ---- (BCC's FIND_EQUIVALENT_TYPE: not in CPP.EXE) ---- */
extern int  FUNCTION_BODY_DEPTH;


/* ---- (BCC's INTERN_QUALIFIED_TYPE: not in CPP.EXE) ---- */

/* INTERN_QUALIFIED_TYPE: the type record equal to type but with the qualifier bits
   qualifiers (const 1, volatile 2; the other attribute bits are kept). Scans the
   whole type pool (records start at offset 15) for an existing record of the same
   kind, attributes and member class and the same contents (tag body; result and
   parameters; element type and count; or target, pointer mode and words 9 and 0x0B);
   ... (BCC's comment, cut short with the function.) */

/* ---- (BCC's TOKEN_FROM_NAME: not in CPP.EXE) ---- */
struct C9TokenName { unsigned int name,token; };
extern struct C9TokenName  C9_TOKEN_NAMES[];
extern struct C9TokenName far *C9_TOKEN_END;


/* ---- ALLOC_TYPE_RECORD (CPP 0FE3:0001) ---- */

/* ALLOC_TYPE_RECORD: a zeroed type record of kind. (BCC's version took a pointer-kind
   record from DUPLICATE_TYPE_FREE_LIST when one was free and no function body was
   open.) */
static unsigned int near pascal ALLOC_TYPE_RECORD(unsigned int kind)
{
    unsigned int type;

    /* CPP.EXE edit: no reuse of DUPLICATE_TYPE_FREE_LIST; CPP's code (image 0xFE31)
       goes straight to POOL_ALLOC (the free list is fed by FIND_EQUIVALENT_TYPE, which
       CPP.EXE does not have). */
    type=POOL_ALLOC(&TYPE_POOL,TYPE_RECORD_SIZE[kind]);
    RTL_MEMSET(MK_FP(TYPE_POOL,type),0,TYPE_RECORD_SIZE[kind]);
    TYPE_W(type,TYPE_KIND)=kind;
    return type;
}

/* ---- ALLOC_ENUM_LINK (CPP 0FE3:003D) ---- */

/* ALLOC_ENUM_LINK / ALLOC_STRUCT_LINK: a zeroed tag body: 8 bytes for an enum or a C
   struct, 0x1C bytes for a C++ class (bases, vtable data, class flags). */
static unsigned int near pascal ALLOC_ENUM_LINK(void)
{
    unsigned int link;

    link=POOL_ALLOC(&TAG_BODY_POOL_SEG,8);
    RTL_MEMSET(MK_FP(TAG_BODY_POOL_SEG,link),0,8);
    return link;
}

/* ---- ALLOC_STRUCT_LINK (CPP 0FE3:0067) ---- */

static unsigned int near pascal ALLOC_STRUCT_LINK(void)
{
    unsigned int size;
    unsigned int link;

    size=CPP_MODE ? 0x1c : 8;
    link=POOL_ALLOC(&TAG_BODY_POOL_SEG,size);
    RTL_MEMSET(MK_FP(TAG_BODY_POOL_SEG,link),0,size);
    return link;
}

/* ---- CREATE_TYPE (CPP 0FE3:009E) ---- */

/* CREATE_TYPE: a new type record of kind; enum (0x15), struct (0x13) and union (0x14)
   types get a new tag body. */
unsigned int far pascal CREATE_TYPE(unsigned int kind)
{
    unsigned int type;

    type=ALLOC_TYPE_RECORD(kind);
    TYPE_W(type,TYPE_KIND)=kind;
    if (kind==0x15)
        TYPE_W(type,TYPE_TAG_BODY)=ALLOC_ENUM_LINK();
    else if (kind==0x13 || kind==0x14)
        TYPE_W(type,TYPE_TAG_BODY)=ALLOC_STRUCT_LINK();
    return type;
}

/* ---- GET_TYPE_DEBUG_ID (CPP 0FE3:00DA) ---- */

/* GET_TYPE_DEBUG_ID / SET_TYPE_DEBUG_ID: the Turbo Debugger type index of a type,
   kept in the type record (TYPE_DEBUG_ID) or, for struct, union and enum, in the tag
   body (TAG_DEBUG_ID). */
unsigned int far pascal GET_TYPE_DEBUG_ID(unsigned int type)
{
    /* Each case returns explicitly; BC cross-jumps the identical returns. */
    switch (TYPE_W(type,TYPE_KIND)) {
    case TK_NEAR_PTR:
    case TK_SEG_PTR:
    case TK_HUGE_PTR:
        return TYPE_W(type,TYPE_DEBUG_ID);
    case TK_ARRAY:
        return TYPE_W(type,TYPE_DEBUG_ID);
    case TK_FUNCTION:
        return TYPE_W(type,TYPE_DEBUG_ID);
    case TK_STRUCT:
    case TK_UNION:
        return TAG_W(TYPE_W(type,TYPE_DEBUG_ID),TAG_DEBUG_ID);
    case TK_ENUM:
        return TAG_W(TYPE_W(type,TYPE_DEBUG_ID),TAG_DEBUG_ID);
    }
    return TYPE_W(type,TYPE_DEBUG_ID);
}

/* ---- SET_TYPE_DEBUG_ID (CPP 0FE3:012F) ---- */

void far pascal SET_TYPE_DEBUG_ID(unsigned int type,unsigned int value)
{
    /* Each case stores explicitly; BC cross-jumps the identical stores. */
    switch (TYPE_W(type,TYPE_KIND)) {
    case TK_NEAR_PTR:
    case TK_SEG_PTR:
    case TK_HUGE_PTR:
        TYPE_W(type,TYPE_DEBUG_ID)=value;
        break;
    case TK_ARRAY:
        TYPE_W(type,TYPE_DEBUG_ID)=value;
        break;
    case TK_FUNCTION:
        TYPE_W(type,TYPE_DEBUG_ID)=value;
        break;
    case TK_STRUCT:
    case TK_UNION:
        TAG_W(TYPE_W(type,TYPE_DEBUG_ID),TAG_DEBUG_ID)=value;
        break;
    case TK_ENUM:
        TAG_W(TYPE_W(type,TYPE_DEBUG_ID),TAG_DEBUG_ID)=value;
        break;
    default:
        TYPE_W(type,TYPE_DEBUG_ID)=value;
    }
}

/* ---- (BCC's ALLOC_SYMBOL_ENTRY: not in CPP.EXE) ---- */
extern signed char SYMBOL_RECORD_SIZE[][2];


/* ---- (BCC's BCC_TYPE_CREATE: not in CPP.EXE) ---- */
extern unsigned int  SCOPE_POOL_SEG;
extern unsigned int  NAME_POOL_SEG;
/* (BCC: FIND_NAME_IN_LIST is defined later in the file and reached through an external
   reference, a far call the overlay linker relaxed.) */
extern unsigned int far pascal FIND_NAME_IN_LIST_BODY(unsigned int,unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);


/* ---- (BCC's DECLARE_TAG: not in CPP.EXE) ---- */


/* ---- (BCC's DECLARE_MEMBER_ALIAS: not in CPP.EXE) ---- */


/* ---- (BCC's C0FIND: not in CPP.EXE) ---- */



/* ---- (BCC's FIND_NAME_IN_LIST: not in CPP.EXE) ---- */


/* ---- (BCC's FIND_SYMBOL_IN_SCOPES: not in CPP.EXE) ---- */


/* ---- (BCC's LOOKUP_NAME: not in CPP.EXE) ---- */


/* ---- (BCC's C9_CLEAR_MEMBER_TABLES: not in CPP.EXE) ---- */


/* ---- (BCC's CACHE_MEMBER_LOOKUP: not in CPP.EXE) ---- */


/* ---- (BCC's FIND_MEMBER_BY_NAME: not in CPP.EXE) ---- */


/* ---- (BCC's BCC_TYPE_PRIMARY: not in CPP.EXE) ---- */


/* ---- (BCC's DECLARE_MEMBER: not in CPP.EXE) ---- */


/* ---- (BCC's DECLARE_GLOBAL_SYMBOL: not in CPP.EXE) ---- */
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);


/* ---- (BCC's ALLOC_SCOPE: not in CPP.EXE) ---- */


/* ---- (BCC's PUSH_SCOPE: not in CPP.EXE) ---- */


/* ---- (BCC's POP_SCOPE: not in CPP.EXE) ---- */
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal FREE_TEMP_ENTRY(unsigned int);

/* POP_SCOPE: closes the current scope. Unless leaving is set (the scope is being
   abandoned and its temporaries handed to the parent):
   - warns about unused names: a parameter never used (MSG_PARAMETER_NEVER_USED, class
     6), an auto variable never used (MSG_DECLARED_BUT_NEVER) or set but never read
     (MSG_ASSIGNED_VALUE_THAT; a reference counts as never used);
   - moves names of storage class 2 (extern declarations inside a block) to their
     global chains so they stay known;
   ... (BCC's comment, cut short with the function.) */

/* ---- (BCC's ALLOC_LABEL_RECORD: not in CPP.EXE) ---- */


/* ---- (BCC's ALLOC_JUMP_RECORD: not in CPP.EXE) ---- */


/* ---- (BCC's PREPARE_SYMBOL: not in CPP.EXE) ---- */
extern unsigned int  CODE_SEGMENT_ID;
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
struct X02CTypeRecord { unsigned int head,value,extra,type,flags; };


/* ---- (BCC's GET_PREPARED_FLAGS: not in CPP.EXE) ---- */


/* ---- (BCC's SET_PREPARED_FLAGS: not in CPP.EXE) ---- */


/* ---- (BCC's GET_PREPARED_SYMBOL: not in CPP.EXE) ---- */


/* ---- (BCC's CLEAR_PREPARED_FLAGS: not in CPP.EXE) ---- */


/* ---- (BCC's SET_PREPARED_SYMBOL_FLAGS: not in CPP.EXE) ---- */


/* ---- (BCC's C56_NAME_FLAGS: not in CPP.EXE) ---- */


/* ---- (BCC's LIST_CONS: not in CPP.EXE) ---- */
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);


/* ---- (BCC's LIST_CELL_FREE: not in CPP.EXE) ---- */
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);


/* ---- (BCC's LIST_CONS_ALT: not in CPP.EXE) ---- */


/* ---- (BCC's C0MARK: not in CPP.EXE) ---- */


/* ---- (BCC's ALLOC_FORMAL_RECORD: not in CPP.EXE) ---- */


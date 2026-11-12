/* target: ovr101_C235UNIT */
/* opts: -mm -O -Z -p -Y -y -B */
/* Role: C++ type and scope tables. Entry points: C9_ALLOC_MEMBER, COPY_TYPE_RECORD,
   FIND_EQUIVALENT_TYPE, INTERN_QUALIFIED_TYPE, TOKEN_FROM_NAME, CREATE_TYPE,
   GET_TYPE_DEBUG_ID, SET_TYPE_DEBUG_ID (+31 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C++ front end's basic tables, used by every other C++ file: record
   allocation for types, members, symbols, scopes, formal parameters and list cells;
   name lookup; scopes; and the "prepared" storage records that hand a symbol over to
   the code generator.
   - Types (TYPE_POOL): CREATE_TYPE allocates a record (struct, union and enum types
     also get a tag body in TAG_BODY_POOL_SEG); INTERN_QUALIFIED_TYPE and
     FIND_EQUIVALENT_TYPE share identical pointer and qualified types so that type
     comparisons can often compare record offsets. Duplicate pointer records found
     outside function bodies are kept on DUPLICATE_TYPE_FREE_LIST for reuse.
   - Names: every identifier is a NAME_POOL record whose NAME_SYMBOLS heads a chain of
     the global symbols with that name; the low three bits of SYM_STORAGE_CLASS tell the
     name space (1 ordinary, 2 tag). The global scope's name and tag lists are not real
     lists: they hold the marker records GLOBAL_SCOPE_NAMES and GLOBAL_SCOPE_TAGS (made in
     driver/INITTYPE.C), and a list equal to a marker means "search the name's global
     chain" (C0FIND). Other scopes keep plain lists (SCOPE_NAMES, SCOPE_TAGS).
   - Members: DECLARE_MEMBER adds to STRUCT_BODY_TYPE, the class being defined;
     FIND_MEMBER_BY_NAME looks a name up in one class (no bases; see ACCESS.C for that)
     through a 32-entry cache (MEMBER_CACHE_NAMES/TYPES/MEMBERS).
   - Scopes (SCOPE_POOL_SEG): PUSH_SCOPE and POP_SCOPE; POP_SCOPE also warns about
     unused locals and parameters and fixes up label records for gotos.
   - PREPARE_SYMBOL makes the 10-byte storage record ({head, segment, intrinsic number,
     symbol, flags}) for a symbol; the record offset has bit 0 set when it lives in
     STORAGE_POOL_SEG (autos and parameters) instead of CSYM_POOL_SEG. The accessors
     below read it through CSYM_W, whose field names are for the C symbol layout:
     CSYM_TYPE (offset 8) is the prepared record's flag word and CSYM_FLAGS (6) its
     symbol.
   Several searches put the key into record 0 (or the null marker record) first, so the
   loop always ends (a sentinel). FIND_EQUIVALENT_TYPE and FIND_MEMBER_BY_NAME are
   inline assembly in the original and are kept as such (the unit is built with -B). */
/* Compiled through TASM (-B): the original has TASM's and r16,imm8 encoding
   (83 /4) at 07B5, 07F8, 0E9F and 0F9E, and a jmp+nop at 00A5. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- C9_ALLOC_MEMBER (listing A720) ---- */
/* row FIND_MEMBER_BY_NAME (offset 0000): called through stub 0C73:003E = C9_ALLOC_MEMBER */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);

/* C9_ALLOC_MEMBER: a new zeroed member record of the size MEMBER_RECORD_SIZE[kind]. */
unsigned int far pascal C9_ALLOC_MEMBER(unsigned int kind)
{
    unsigned int member;

    member=POOL_ALLOC(&MEMBER_SEGMENT,MEMBER_RECORD_SIZE[kind]);
    RTL_MEMSET(MK_FP(MEMBER_SEGMENT,member),0,MEMBER_RECORD_SIZE[kind]);
    return member;
}

/* ---- COPY_TYPE_RECORD (listing A755) ---- */
/* row X02C_26 (offset 0035): called through stub 0C73:005C = COPY_TYPE_RECORD */

/* COPY_TYPE_RECORD: a new type record that is a copy of type (its kind's size). */
unsigned int far pascal COPY_TYPE_RECORD(unsigned int type)
{
    unsigned int copy;

    copy=POOL_ALLOC(&TYPE_POOL,TYPE_RECORD_SIZE[TYPE_W(type,TYPE_KIND)]);
    RTL_MEMMOVE(MK_FP(TYPE_POOL,copy),MK_FP(TYPE_POOL,type),TYPE_RECORD_SIZE[TYPE_W(type,TYPE_KIND)]);
    return copy;
}

/* ---- FIND_EQUIVALENT_TYPE (listing A79A) ---- */
/* row FIND_EQUIVALENT_TYPE (offset 007A): stub 0C73:00BB = FIND_EQUIVALENT_TYPE.
   Inline assembly in the original: the search loop reloads DS with
   TYPE_POOL and reaches DGROUP through SS: overrides, and the jmp+nop at
   00A5 is the TASM signature; the unit is compiled with -B.
   Equivalent C: return `type` if it is zero or not a pointer-like type
   (EXPR_FLAGS&0x14 selects the pointer and reference kinds; this note said
   "aggregate" before, which the flag does not mean).  Otherwise clear flag 0x80 in its field 13; if
   FUNCTION_BODY_DEPTH is non-zero return `type`.  Else search the pool records from
   offset 15 to TYPE_POOL_LENGTH for a copy (same kind, fields 2, 3, 7, 13): if the
   first copy found is `type` itself (or none is found) return `type`;
   otherwise mark `type` (flag 0x80 in field 13), chain it onto DUPLICATE_TYPE_FREE_LIST
   through field 3 and return the copy. */
extern int  FUNCTION_BODY_DEPTH;

unsigned int far pascal FIND_EQUIVALENT_TYPE(unsigned int type)
{
    asm mov ax,word ptr type;
    asm or ax,ax;
    asm je not_found;
    asm mov es,word ptr DGROUP:TYPE_POOL;
    asm mov di,ax;
    asm mov bl,byte ptr es:[di];
    asm mov bh,0;
    asm test byte ptr DGROUP:EXPR_FLAGS[bx],14h;
    asm je not_found;
    asm and word ptr es:[di+0Dh],0FF7Fh;
    asm cmp word ptr DGROUP:FUNCTION_BODY_DEPTH,0;
    asm je search;
not_found:
    asm jmp done;
search:
    asm push ds;
    asm mov ds,word ptr DGROUP:TYPE_POOL;
    asm mov ah,0;
    asm mov cl,bl;
    asm mov ch,byte ptr [di+2];
    asm mov dx,word ptr [di+7];
    asm mov si,0Fh;
next:
    asm mov bl,byte ptr [si];
    asm cmp bl,cl;
    asm jne step;
    asm cmp dx,word ptr [si+7];
    asm je compare;
step:
    asm mov al,byte ptr ss:[bx+offset DGROUP:TYPE_RECORD_SIZE];
    asm add si,ax;
    asm cmp si,word ptr ss:[offset DGROUP:TYPE_POOL_LENGTH];
    asm jb next;
same:
    asm pop ds;
    asm mov ax,word ptr type;
    asm jmp short done;
clear_ah:
    asm mov ah,0;
    asm jmp short step;
compare:
    asm mov al,byte ptr [si+0Dh];
    asm cmp al,byte ptr [di+0Dh];
    asm jne step;
    asm cmp ch,byte ptr [si+2];
    asm jne step;
    asm mov ax,word ptr [si+3];
    asm cmp ax,word ptr [di+3];
    asm jne clear_ah;
    asm mov ax,word ptr [di+7];
    asm cmp ax,word ptr [si+7];
    asm jne clear_ah;
    asm cmp si,di;
    asm je same;
    asm or word ptr [di+0Dh],80h;
    asm pop ds;
    asm mov ax,word ptr DGROUP:DUPLICATE_TYPE_FREE_LIST;
    asm mov word ptr es:[di+3],ax;
    asm mov word ptr DGROUP:DUPLICATE_TYPE_FREE_LIST,di;
    asm mov ax,si;
done:
    return _AX;
}

/* ---- INTERN_QUALIFIED_TYPE (listing A837) ---- */
/* row INTERN_QUALIFIED_TYPE (offset 0117): stub 0C73:00C0 = INTERN_QUALIFIED_TYPE */

/* INTERN_QUALIFIED_TYPE: the type record equal to type but with the qualifier bits
   qualifiers (const 1, volatile 2; the other attribute bits are kept). Scans the
   whole type pool (records start at offset 15) for an existing record of the same
   kind, attributes and member class and the same contents (tag body; result and
   parameters; element type and count; or target, pointer mode and words 9 and 0x0B);
   otherwise makes a copy with the new attributes. */
unsigned int far pascal INTERN_QUALIFIED_TYPE(unsigned int type,unsigned int qualifiers)
{
    unsigned int cur;
    unsigned int kind;
    unsigned int other;
    register unsigned int pool;
    register unsigned int base;

    pool=TYPE_POOL;
    base=type;
    kind=FAR_W(pool,base,TYPE_KIND);
    qualifiers|=FAR_B(pool,base,TYPE_ATTRS)&0xfffc;
    for (cur=15; cur<TYPE_POOL_LENGTH; cur+=TYPE_RECORD_SIZE[other]) {
        unsigned int entry=cur;    /* block local: BC keeps it in CX, as the original does */
        if ((other=FAR_W(pool,entry,TYPE_KIND))==kind && FAR_B(pool,entry,TYPE_ATTRS)==qualifiers
                && FAR_W(pool,entry,TYPE_MEMBER_CLASS)==FAR_W(pool,base,TYPE_MEMBER_CLASS))
        switch (kind) {
        case TK_STRUCT:
        case TK_UNION:
            if (FAR_W(pool,entry,TYPE_TAG_BODY)==FAR_W(pool,base,TYPE_TAG_BODY)) return cur;
            break;
        case TK_FUNCTION:
            if (FAR_W(pool,entry,TYPE_TARGET)==FAR_W(pool,base,TYPE_TARGET) && FAR_W(pool,entry,TYPE_PARAMS)==FAR_W(pool,base,TYPE_PARAMS)) return cur;
            break;
        case TK_ENUM:
            if (FAR_W(pool,entry,TYPE_TAG_BODY)==FAR_W(pool,base,TYPE_TAG_BODY)) return cur;
            break;
        case TK_ARRAY:
            if (FAR_W(pool,entry,TYPE_TARGET)==FAR_W(pool,base,TYPE_TARGET) && FAR_L(pool,entry,TYPE_ARRAY_COUNT)==FAR_L(pool,base,TYPE_ARRAY_COUNT)) return cur;
            break;
        default:
            if (FAR_W(pool,entry,TYPE_TARGET)==FAR_W(pool,base,TYPE_TARGET) && FAR_B(pool,entry,TYPE_PTR_MODE)==FAR_B(pool,base,TYPE_PTR_MODE)
                && FAR_W(pool,entry,TYPE_PTR_BASE)==FAR_W(pool,base,TYPE_PTR_BASE) && FAR_W(pool,entry,TYPE_PTR_WORD_B)==FAR_W(pool,base,TYPE_PTR_WORD_B)) return cur;
            break;
        }
    }
    type=COPY_TYPE_RECORD(type);
    TYPE_B(type,TYPE_ATTRS)=qualifiers;
    return type;
}

/* ---- TOKEN_FROM_NAME (listing A97E) ---- */
/* row GET_PREPARED_SYMBOL (offset 025E): stub 0C73:007A = TOKEN_FROM_NAME */
struct C9TokenName { unsigned int name,token; };
extern struct C9TokenName  C9_TOKEN_NAMES[];
extern struct C9TokenName far *C9_TOKEN_END;

/* TOKEN_FROM_NAME: the token code whose interned name is name, searching the
   C9_TOKEN_NAMES table backwards from C9_TOKEN_END; entry 0 is the sentinel, so a name
   that is no keyword gives entry 0's token. */
unsigned int far pascal TOKEN_FROM_NAME(unsigned int name)
{
    struct C9TokenName far *entry;

    C9_TOKEN_NAMES[0].name=name;
    for (entry=C9_TOKEN_END; entry->name!=name; --entry)
        ;
    return entry->token;
}

/* ---- ALLOC_TYPE_RECORD (listing A9B2) ---- */

/* ALLOC_TYPE_RECORD: a zeroed type record of kind; a pointer-kind record is taken
   from DUPLICATE_TYPE_FREE_LIST when one is free and no function body is open. */
static unsigned int near pascal ALLOC_TYPE_RECORD(unsigned int kind)
{
    unsigned int type;

    if (FUNCTION_BODY_DEPTH==0 && (EXPR_FLAGS[kind]&0x14)!=0 && DUPLICATE_TYPE_FREE_LIST!=0) {
        type=DUPLICATE_TYPE_FREE_LIST;
        DUPLICATE_TYPE_FREE_LIST=TYPE_W(type,TYPE_FREE_NEXT);
    } else
        type=POOL_ALLOC(&TYPE_POOL,TYPE_RECORD_SIZE[kind]);
    RTL_MEMSET(MK_FP(TYPE_POOL,type),0,TYPE_RECORD_SIZE[kind]);
    TYPE_W(type,TYPE_KIND)=kind;
    return type;
}

/* ---- ALLOC_ENUM_LINK (listing AA16) ---- */

/* ALLOC_ENUM_LINK / ALLOC_STRUCT_LINK: a zeroed tag body: 8 bytes for an enum or a C
   struct, 0x1C bytes for a C++ class (bases, vtable data, class flags). */
static unsigned int near pascal ALLOC_ENUM_LINK(void)
{
    unsigned int link;

    link=POOL_ALLOC(&TAG_BODY_POOL_SEG,8);
    RTL_MEMSET(MK_FP(TAG_BODY_POOL_SEG,link),0,8);
    return link;
}

/* ---- ALLOC_STRUCT_LINK (listing AA42) ---- */

static unsigned int near pascal ALLOC_STRUCT_LINK(void)
{
    unsigned int size;
    unsigned int link;

    size=CPP_MODE ? 0x1c : 8;
    link=POOL_ALLOC(&TAG_BODY_POOL_SEG,size);
    RTL_MEMSET(MK_FP(TAG_BODY_POOL_SEG,link),0,size);
    return link;
}

/* ---- CREATE_TYPE (listing AA7B) ---- */
/* row ALLOC_SYMBOL_ENTRY (offset 035B): stub 0C73:002F = CREATE_TYPE */

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

/* ---- GET_TYPE_DEBUG_ID (listing AAB7) ---- */
/* row LIST_CONS (offset 0397): stub 0C73:0048 = GET_TYPE_DEBUG_ID */

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

/* ---- SET_TYPE_DEBUG_ID (listing AB0C) ---- */
/* row FIND_NAME_IN_LIST (offset 03EC): stub 0C73:00A7 = SET_TYPE_DEBUG_ID */

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

/* ---- ALLOC_SYMBOL_ENTRY (listing AB66) ---- */
/* row DECLARE_TAG (offset 0446): stub 0C73:00B6 = ALLOC_SYMBOL_ENTRY */
extern signed char SYMBOL_RECORD_SIZE[][2];

/* ALLOC_SYMBOL_ENTRY: a zeroed symbol record named name; its size depends on kind and
   on C or C++ mode (SYMBOL_RECORD_SIZE[kind][CPP_MODE]). */
unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int name,unsigned int kind)
{
    unsigned int symbol;

    symbol=POOL_ALLOC(&SYMBOL_POOL_SEG,SYMBOL_RECORD_SIZE[kind][CPP_MODE]);
    RTL_MEMSET(MK_FP(SYMBOL_POOL_SEG,symbol),0,SYMBOL_RECORD_SIZE[kind][CPP_MODE]);
    SYM_W(symbol,SYM_NAME)=name;
    return symbol;
}

/* ---- BCC_TYPE_CREATE (listing ABBC) ---- */
/* row LOOKUP_NAME (offset 049C): stub 0C73:004D = BCC_TYPE_CREATE */
extern unsigned int  SCOPE_POOL_SEG;
extern unsigned int  NAME_POOL_SEG;
/* FIND_NAME_IN_LIST is defined later in this overlay; the original reaches it through an
   external reference (linker-relaxed far call), as DIRTAIL does with COMMENT_BLOCK_BODY. */
extern unsigned int far pascal FIND_NAME_IN_LIST_BODY(unsigned int,unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);

/* BCC_TYPE_CREATE: declares an ordinary name in the current scope: allocates the
   symbol, reports MSG_MULTIPLE_DECLARATION if the scope already has the name, and
   links it into the scope's list or, at global scope, into the name's chain (name
   space 1). Despite its name it creates a symbol, not a type. */
unsigned int far pascal BCC_TYPE_CREATE(unsigned int name,unsigned int kind)
{
    unsigned int head;
    unsigned int symbol;

    symbol=ALLOC_SYMBOL_ENTRY(name,kind);
    head=SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES);
    if (name!=0 && FIND_NAME_IN_LIST_BODY(name,head)!=0)
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
    if (head==GLOBAL_SCOPE_NAMES) {
        SYM_W(symbol,SYM_NEXT)=NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS);
        NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS)=symbol;
        SYM_B(symbol,SYM_STORAGE_CLASS)=SYM_B(symbol,SYM_STORAGE_CLASS)&0xf8|1;
    } else {
        SYM_W(symbol,SYM_NEXT)=head;
        SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES)=symbol;
    }
    return symbol;
}

/* ---- DECLARE_TAG (listing AC56) ---- */
/* row LIST_CONS_ALT (offset 0536): stub 0C73:0098 = DECLARE_TAG */

/* DECLARE_TAG: the same for a struct, union, enum or class tag (name space 2, the
   scope's tag list). */
unsigned int far pascal DECLARE_TAG(unsigned int name)
{
    unsigned int head;
    unsigned int symbol;

    symbol=ALLOC_SYMBOL_ENTRY(name,1);
    head=SCOPE_W(CURRENT_SCOPE,SCOPE_TAGS);
    if (FIND_NAME_IN_LIST_BODY(name,head)!=0)
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
    if (head==GLOBAL_SCOPE_TAGS) {
        SYM_W(symbol,SYM_NEXT)=NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS);
        NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS)=symbol;
        SYM_B(symbol,SYM_STORAGE_CLASS)=SYM_B(symbol,SYM_STORAGE_CLASS)&0xf8|2;
    } else {
        SYM_W(symbol,SYM_NEXT)=head;
        SCOPE_W(CURRENT_SCOPE,SCOPE_TAGS)=symbol;
    }
    return symbol;
}

/* ---- DECLARE_MEMBER_ALIAS (listing ACED) ---- */
/* row X02C_06 (offset 05CD): stub 0C73:00AC = DECLARE_MEMBER_ALIAS */

/* DECLARE_MEMBER_ALIAS: makes the member of an anonymous union visible as a plain name
   in the current scope: a symbol of storage class 14 that refers to member of the
   union object record (SYM_ALIAS_MEMBER, SYM_ALIAS_OBJECT). Uses of it become
   object.member (RESOLVE_SYMBOL_NODE). */
void far pascal DECLARE_MEMBER_ALIAS(unsigned int member,unsigned int record)
{
    unsigned int symbol;

    symbol=BCC_TYPE_CREATE(MEMBER_W(member,MEMB_NAME),8);
    SYM_B(symbol,SYM_STORAGE_CLASS)=SYM_B(symbol,SYM_STORAGE_CLASS)&7|0x70;
    SYM_W(symbol,SYM_TYPE)=MEMBER_W(member,MEMB_TYPE);
    SYM_W(symbol,SYM_ALIAS_MEMBER)=member;
    SYM_W(symbol,SYM_ALIAS_OBJECT)=record;
}

/* ---- C0FIND (listing AD38) ---- */
/* row COPY_TYPE_RECORD (offset 0618): stub 0C73:0061 = C0FIND.
   BC itself keeps the parameter 'kind' in DX (mov dx,[bp+6] ... cmp ax,dx). */

/* C0FIND: the first symbol in name's global chain with name space kind, looking at
   most at the first two links; otherwise returns the third link unchecked (probably
   relying on the chain holding at most one symbol of each name space before it). */
unsigned int far pascal C0FIND(unsigned int name,unsigned int kind)
{
    unsigned int symbol;

    symbol=NAME_W(name,NAME_SYMBOLS);
    if ((SYM_B(symbol,SYM_STORAGE_CLASS)&7)==kind) return symbol;
    symbol=SYM_W(symbol,SYM_NEXT);
    if ((SYM_B(symbol,SYM_STORAGE_CLASS)&7)==kind) return symbol;
    symbol=SYM_W(symbol,SYM_NEXT);
    return symbol;
}

/* ---- FIND_NAME_IN_LIST (listing AD82) ---- */
/* row GET_TYPE_DEBUG_ID (offset 0662): stub 0C73:007F = FIND_NAME_IN_LIST */

/* FIND_NAME_IN_LIST: the symbol called name in list (a scope's name or tag list), or
   0. The global markers GLOBAL_SCOPE_NAMES and GLOBAL_SCOPE_TAGS search the global chains. */
unsigned int far pascal FIND_NAME_IN_LIST(unsigned int name,unsigned int list)
{
    if (list==GLOBAL_SCOPE_NAMES) return C0FIND(name,1);
    if (list==GLOBAL_SCOPE_TAGS) return C0FIND(name,2);
    SYM_W(0,SYM_NAME)=name;
    while (SYM_W(list,SYM_NAME)!=name)
        list=SYM_W(list,SYM_NEXT);
    return list;
}

/* ---- FIND_SYMBOL_IN_SCOPES (listing ADCE) ---- */
/* row X02C_19 (offset 06AE): stub 0C73:00B1 = FIND_SYMBOL_IN_SCOPES */

/* FIND_SYMBOL_IN_SCOPES: looks name up in the open block scopes from the innermost
   out, not including the global scope. In C++ tags are found too, and the search
   stops at the function's outermost scope. Returns the symbol or 0. */
int far pascal FIND_SYMBOL_IN_SCOPES(unsigned int name)
{
    unsigned int found;
    unsigned int scope;

    found=0;
    for (scope=CURRENT_SCOPE; scope!=GLOBAL_SCOPE; scope=SCOPE_W(scope,SCOPE_PARENT)) {
        found=FIND_NAME_IN_LIST(name,SCOPE_W(scope,SCOPE_NAMES));
        if (CPP_MODE && found==0)
            found=FIND_NAME_IN_LIST(name,SCOPE_W(scope,SCOPE_TAGS));
        if (found!=0) break;
        if (CPP_MODE && SCOPE_B(scope,SCOPE_IS_FUNCTION)!=0) break;
    }
    return found;
}

/* ---- LOOKUP_NAME (listing AE33) ---- */
/* row TOKEN_FROM_NAME (offset 0713): stub 0C73:00CA = LOOKUP_NAME */

/* LOOKUP_NAME: full lookup of an ordinary name: block scopes, then global names, then
   in C++ global tags. */
unsigned int far pascal LOOKUP_NAME(unsigned int name)
{
    unsigned int symbol;

    symbol=FIND_SYMBOL_IN_SCOPES(name);
    if (symbol==0)
        symbol=FIND_NAME_IN_LIST(name,GLOBAL_SCOPE_NAMES);
    if (CPP_MODE && symbol==0)
        symbol=FIND_NAME_IN_LIST(name,GLOBAL_SCOPE_TAGS);
    return symbol;
}

/* ---- C9_CLEAR_MEMBER_TABLES (listing AE6F) ---- */
/* row CREATE_TYPE (offset 074F): stub 0C73:0093 = C9_CLEAR_MEMBER_TABLES */

/* C9_CLEAR_MEMBER_TABLES: empties the member lookup cache (all three tables). */
void far pascal C9_CLEAR_MEMBER_TABLES(void)
{
    unsigned int far *first;
    unsigned int far *second;
    unsigned int far *third;

    /* The end test compares with the next table, MEMBER_CACHE_NAMES, which follows
       MEMBER_CACHE_TYPES directly (0x66DA+64); the original's fixup names MEMBER_CACHE_NAMES,
       so it is not written as MEMBER_CACHE_TYPES+32. */
    for (first=MEMBER_CACHE_TYPES,second=MEMBER_CACHE_NAMES,third=MEMBER_CACHE_MEMBERS;
         first<(unsigned int far *)MEMBER_CACHE_NAMES; first++,second++,third++)
        *first=*second=*third=0;
}

/* ---- CACHE_MEMBER_LOOKUP (listing AEBA) ---- */
/* row X02C_04 (offset 079A): stub 0C73:00A2 = CACHE_MEMBER_LOOKUP */

/* CACHE_MEMBER_LOOKUP: stores (name, class type) -> member in its cache slot. */
void far pascal CACHE_MEMBER_LOOKUP(unsigned int name,unsigned int type,unsigned int member)
{
    int slot;

    slot=((name^type)+((name^type)>>4))&0x1f;
    MEMBER_CACHE_TYPES[slot]=type;
    MEMBER_CACHE_NAMES[slot]=name;
    MEMBER_CACHE_MEMBERS[slot]=member;
}

/* ---- FIND_MEMBER_BY_NAME (listing AF01) ---- */
/* row X02C_13 (offset 07E1): stub 0C73:00C5 = FIND_MEMBER_BY_NAME */

/* Inline assembly in the original (xchg si,bx; the hash slot kept in BX).
   Equivalent C: look up (name,type) in the 32-entry cache MEMBER_CACHE_NAMES/66DA/675A,
   slot ((name^type)+((name^type)>>4))&0x1f; on a miss, store the key, find the
   member named `name` in the list at LW(TW(type,5),2) (sentinel MW(0,2)=name)
   and cache and return it. */
unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int name,unsigned int type)
{
    asm mov ax,word ptr name;
    asm mov di,ax;
    asm mov si,word ptr type;
    asm xor ax,si;
    asm mov bx,ax;
    asm mov cl,4;
    asm shr ax,cl;
    asm add bx,ax;
    asm and bx,1Fh;
    asm shl bx,1;
    asm cmp di,word ptr DGROUP:MEMBER_CACHE_NAMES[bx];
    asm jne miss;
    asm cmp si,word ptr DGROUP:MEMBER_CACHE_TYPES[bx];
    asm jne miss;
    asm mov ax,word ptr DGROUP:MEMBER_CACHE_MEMBERS[bx];
    asm jmp short done;
miss:
    asm mov word ptr DGROUP:MEMBER_CACHE_NAMES[bx],di;
    asm mov word ptr DGROUP:MEMBER_CACHE_TYPES[bx],si;
    asm xchg bx,si;                /* TASM puts the first operand in the reg field: 87 DE */
    asm mov es,word ptr DGROUP:TYPE_POOL;
    asm mov bx,word ptr es:[bx+5];
    asm mov es,word ptr DGROUP:TAG_BODY_POOL_SEG;
    asm mov bx,word ptr es:[bx+2];
    asm mov es,word ptr DGROUP:MEMBER_SEGMENT;
    asm mov word ptr es:[2],di;
    asm jmp short test;
next:
    asm mov bx,word ptr es:[bx];
test:
    asm cmp di,word ptr es:[bx+2];
    asm jne next;
    asm mov ax,bx;
    asm mov word ptr DGROUP:MEMBER_CACHE_MEMBERS[si],ax;
done:
    return _AX;
}

/* ---- BCC_TYPE_PRIMARY (listing AF69) ---- */
/* row X02C_1F (offset 0849): stub 0C73:0039 = BCC_TYPE_PRIMARY */

/* BCC_TYPE_PRIMARY: looks up a tag (struct/union/enum/class name): the tag lists of
   the open block scopes, then the global chain (name space 2, with record 0 as the
   sentinel). Returns the tag symbol or 0. */
unsigned int far pascal BCC_TYPE_PRIMARY(unsigned int name)
{
    unsigned int symbol;
    unsigned int scope;

    scope=CURRENT_SCOPE;
    while (scope!=GLOBAL_SCOPE) {
        symbol=FIND_NAME_IN_LIST(name,SCOPE_W(scope,SCOPE_TAGS));
        if (symbol!=0) return symbol;
        scope=SCOPE_W(scope,SCOPE_PARENT);
    }
    SYM_B(0,SYM_STORAGE_CLASS)=(SYM_B(0,SYM_STORAGE_CLASS)&0xF8)|2;
    symbol=NAME_W(name,NAME_SYMBOLS);
    while ((SYM_B(symbol,SYM_STORAGE_CLASS)&7)!=2)
        symbol=SYM_W(symbol,SYM_NEXT);
    return symbol;
}

/* ---- DECLARE_MEMBER (listing AFD5) ---- */
/* row X02C_01 (offset 08B5): stub 0C73:008E = DECLARE_MEMBER */

/* DECLARE_MEMBER: adds a member called name of kind (0 data, 1 enumerator, 2 static,
   3 function) to the class being defined, STRUCT_BODY_TYPE, with the current access
   SCOPE_STATE. A name already declared is MSG_MULTIPLE_DECLARATION unless the old
   member has flag 0x80. Members are kept newest first and entered in the cache. */
unsigned int far pascal DECLARE_MEMBER(unsigned int name,unsigned int kind)
{
    unsigned int member;

    member=FIND_MEMBER_BY_NAME(name,STRUCT_BODY_TYPE);
    if (member && !(MEMBER_B(member,MEMB_FLAGS)&0x80))
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
    member=C9_ALLOC_MEMBER(kind);
    MEMBER_W(member,MEMB_NEXT)=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS);
    TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS)=member;
    MEMBER_W(member,MEMB_NAME)=name;
    CACHE_MEMBER_LOOKUP(name,STRUCT_BODY_TYPE,member);
    MEMBER_B(member,MEMB_FLAGS)=(MEMBER_B(member,MEMB_FLAGS)&0xFC)|((unsigned char)kind&3);
    MEMBER_B(member,MEMB_FLAGS)=(MEMBER_B(member,MEMB_FLAGS)&0xE3)|(((unsigned char)SCOPE_STATE&7)<<2);
    return member;
}

/* ---- DECLARE_GLOBAL_SYMBOL (listing B084) ---- */
/* row DECLARE_GLOBAL_SYMBOL (offset 0964): stub 0C73:009D = DECLARE_GLOBAL_SYMBOL */
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);

/* DECLARE_GLOBAL_SYMBOL: a global symbol (storage class 2) for a name given as text,
   used for compiler-made functions such as _STCON_ and run-time helpers. value goes to
   SYM_GLOBAL_FLAGS; in C++, extra is the function kind and linkage is 1. */
unsigned int far pascal DECLARE_GLOBAL_SYMBOL(char far *name,unsigned int type,unsigned int value,unsigned int extra)
{
    unsigned int symbol;

    symbol=ALLOC_SYMBOL_ENTRY(BCC_SYMBOL_CREATE(name,0),6);
    SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&0xF8)|1;
    SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|0x10;
    SYM_W(symbol,SYM_NEXT)=NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS);
    NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS)=symbol;
    SYM_W(symbol,SYM_TYPE)=type;
    SYM_W(symbol,SYM_STORAGE)=0;
    SYM_W(symbol,SYM_GLOBAL_FLAGS)=value;
    if (CPP_MODE) {
        SYM_W(symbol,SYM_FUNC_KIND)=extra;
        SYM_W(symbol,SYM_LINKAGE)=1;
        SYM_B(symbol,SYM_INLINE_ACCESS)=SYM_B(symbol,SYM_INLINE_ACCESS)&0xFC;
    }
    return symbol;
}

/* ---- ALLOC_SCOPE (listing B117) ---- */
/* row ALLOC_SCOPE (offset 09F7): stub 0C73:0043 = ALLOC_SCOPE */

/* ALLOC_SCOPE: a new scope record, saving the marks that POP_SCOPE restores
   (SCOPE_LINK10_MARK, TYPE_POOL_LENGTH, DECL_INIT_SERIAL) and the nesting level. */
unsigned int far pascal ALLOC_SCOPE(void)
{
    unsigned int scope;

    scope=POOL_ALLOC(&SCOPE_POOL_SEG,0x15);
    SCOPE_W(scope,SCOPE_PARENT)=0;
    SCOPE_W(scope,SCOPE_NAMES)=0;
    SCOPE_W(scope,SCOPE_TAGS)=0;
    SCOPE_W(scope,SCOPE_SAVED_LINK10_MARK)=SCOPE_LINK10_MARK;
    SCOPE_W(scope,SCOPE_SAVED_TYPE_LENGTH)=TYPE_POOL_LENGTH;
    SCOPE_W(scope,SCOPE_NEST_LEVEL)=BLOCK_NEST_LEVEL;
    SCOPE_W(scope,SCOPE_ENTER_BLOCK)=0;
    SCOPE_W(scope,SCOPE_STMT_LEVEL)=0;
    SCOPE_W(scope,SCOPE_SAVED_INIT_SERIAL)=DECL_INIT_SERIAL;
    SCOPE_W(scope,SCOPE_TEMPS)=0;
    SCOPE_B(scope,SCOPE_IS_FUNCTION)=0;
    return scope;
}

/* ---- PUSH_SCOPE (listing B178) ---- */
/* row PUSH_SCOPE (offset 0A58): stub 0C73:0052 = PUSH_SCOPE */

/* PUSH_SCOPE: opens a scope inside the current one (kind 1 for a function body). The
   new scope starts with the enclosing scope's list of temporaries to destroy. */
void far pascal PUSH_SCOPE(unsigned char kind)
{
    unsigned int scope;

    scope=ALLOC_SCOPE();
    SCOPE_W(scope,SCOPE_TEMPS)=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    SCOPE_B(scope,SCOPE_IS_FUNCTION)=kind;
    SCOPE_W(scope,SCOPE_PARENT)=CURRENT_SCOPE;
    CURRENT_SCOPE=scope;
}

/* ---- POP_SCOPE (listing B1A8) ---- */
/* row POP_SCOPE (offset 0A88): stub 0C73:0075 = POP_SCOPE */
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
   - at a function's outermost scope, frees the temporaries recorded on labels and
     resets the type pool and link marks saved when the scope was opened, dropping the
     function's local type records.
   Label records whose goto serial range overlaps declarations made in this scope get
   their upper serial reset, so later checks of gotos into the scope (past
   initializations) see them (probably). */
void far pascal POP_SCOPE(unsigned char leaving)
{
    unsigned int item;
    unsigned int block;
    unsigned char outer;
    unsigned int next;
    unsigned int message;
    register unsigned int symbol;
    register unsigned int scope;

    scope=CURRENT_SCOPE;
    outer=scope==BCC_TREE_LINK || (CPP_MODE && SCOPE_B(scope,SCOPE_IS_FUNCTION));
    if (!leaving) {
        symbol=SCOPE_W(scope,SCOPE_NAMES);
        while (symbol) {
            if (SYM_W(symbol,SYM_NAME)!=0) {
                message=0;
                switch (SYM_B(symbol,SYM_STORAGE_CLASS)>>3) {
                case 6:
                    if (!(SYM_B(symbol,SYM_FLAGS)&4)) message=0x163;
                    break;
                case 4:
                case 5:
                    if (!(SYM_B(symbol,SYM_FLAGS)&7)) message=0x17C;
                    else if (!(SYM_B(symbol,SYM_FLAGS)&4))
                        message=(EXPR_FLAGS[TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)]&0x14) &&
                            (TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_ATTRS)&0x20) ? 0x17C : 0x173;
                    break;
                }
                if (message)
                    REPORT_DIAGNOSTIC(message,NAME_TEXT_COPY(SYM_W(symbol,SYM_NAME)),0L);
            }
            symbol=SYM_W(symbol,SYM_NEXT);
        }
    }
    for (block=LABEL_LIST_HEAD; block; block=LABEL_W(block,LABEL_NEXT)) {
        if (outer && !leaving) {
            if (CPP_MODE) {
                while (LABEL_W(block,LABEL_TEMPS)) {
                    item=LABEL_W(block,LABEL_TEMPS);
                    LABEL_W(block,LABEL_TEMPS)=TDTOR_W(item,TDTOR_NEXT);
                    FREE_TEMP_ENTRY(item);
                }
            }
        } else if ((LABEL_I(block,LABEL_SERIAL_HIGH)>SCOPE_I(scope,SCOPE_SAVED_INIT_SERIAL) && LABEL_I(block,LABEL_SERIAL_HIGH)<=DECL_INIT_SERIAL) ||
            (LABEL_I(block,LABEL_SERIAL_LOW)>SCOPE_I(scope,SCOPE_SAVED_INIT_SERIAL) && LABEL_I(block,LABEL_SERIAL_LOW)<=DECL_INIT_SERIAL))
            LABEL_W(block,LABEL_SERIAL_HIGH)=SCOPE_W(scope,SCOPE_SAVED_INIT_SERIAL);
    }
    DECL_INIT_SERIAL=SCOPE_W(scope,SCOPE_SAVED_INIT_SERIAL);
    CURRENT_SCOPE=SCOPE_W(scope,SCOPE_PARENT);
    if (leaving)
        SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)=SCOPE_W(scope,SCOPE_TEMPS);
    else {
        symbol=SCOPE_W(scope,SCOPE_NAMES);
        while (symbol) {
            next=SYM_W(symbol,SYM_NEXT);
            if ((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==2) {
                SYM_B(symbol,SYM_STORAGE_CLASS)=SYM_B(symbol,SYM_STORAGE_CLASS)&0xF8;
                SYM_W(symbol,SYM_NEXT)=NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS);
                NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS)=symbol;
            }
            symbol=next;
        }
    }
    if (outer && !leaving) {
        SCOPE_LINK10_MARK_HIGH=0;
        SCOPE_LINK10_MARK=SCOPE_W(scope,SCOPE_SAVED_LINK10_MARK);
        TYPE_POOL_WORD6=0;
        TYPE_POOL_LENGTH=SCOPE_W(scope,SCOPE_SAVED_TYPE_LENGTH);
    }
}

/* ---- ALLOC_LABEL_RECORD (listing B431) ---- */
/* row ALLOC_LABEL_RECORD (offset 0D11): stub 0C73:0025 = ALLOC_LABEL_RECORD */

/* ALLOC_LABEL_RECORD: a zeroed 13-byte label record linked on LABEL_LIST_HEAD, with
   LABEL_SERIAL_HIGH open (0x7FFF). */
unsigned int far pascal ALLOC_LABEL_RECORD(void)
{
    unsigned int block;

    block=POOL_ALLOC(&LABEL_POOL_SEG,13);
    RTL_MEMSET(MK_FP(LABEL_POOL_SEG,block),0,13);
    LABEL_W(block,LABEL_NEXT)=LABEL_LIST_HEAD;
    LABEL_LIST_HEAD=block;
    LABEL_W(block,LABEL_SERIAL_HIGH)=0x7FFF;
    return block;
}

/* ---- ALLOC_JUMP_RECORD (listing B46F) ---- */
/* row CACHE_MEMBER_LOOKUP (offset 0D4F): stub 0C73:0020 = ALLOC_JUMP_RECORD */

/* ALLOC_JUMP_RECORD: a zeroed 10-byte pending-goto record linked on
   PENDING_GOTO_LIST. */
unsigned int far pascal ALLOC_JUMP_RECORD(void)
{
    unsigned int block;

    block=POOL_ALLOC(&LABEL_POOL_SEG,10);
    RTL_MEMSET(MK_FP(LABEL_POOL_SEG,block),0,10);
    LABEL_W(block,GOTO_NEXT)=PENDING_GOTO_LIST;
    PENDING_GOTO_LIST=block;
    return block;
}

/* ---- PREPARE_SYMBOL (listing B4A7) ---- */
/* row PREPARE_SYMBOL (offset 0D87): stub 0C73:0066 = PREPARE_SYMBOL */
extern unsigned int  CODE_SEGMENT_ID;
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
struct X02CTypeRecord { unsigned int head,value,extra,type,flags; };

/* PREPARE_SYMBOL: returns the storage record of symbol (cached in SYM_STORAGE), making
   it the first time. A member alias uses its union object's record. The segment word
   is CODE_SEGMENT_ID for near functions, 0xFFFF for far functions, far arrays and
   externals that need it, a new far segment for far data, DATA_SEGMENT_ID for
   initialized data and BSS_SEGMENT_ID otherwise. The flag word gets 4 (near) or 0x10
   (far), const 1, volatile 2, flag 0x40 from the symbol and 0x200 for functions with
   type flag 0x80. Autos and parameters (classes 5, 6) go to STORAGE_POOL_SEG with bit
   0 set in the returned offset; others to CSYM_POOL_SEG. */
unsigned int far pascal PREPARE_SYMBOL(register unsigned int symbol)
{
    unsigned char flags;
    int kind;
    struct X02CTypeRecord record;
    unsigned int type;

    if ((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==14) return PREPARE_SYMBOL(SYM_W(symbol,SYM_ALIAS_OBJECT));
    if (SYM_W(symbol,SYM_STORAGE)!=0) return SYM_W(symbol,SYM_STORAGE);
    type=SYM_W(symbol,SYM_TYPE);
    flags=SYM_B(symbol,SYM_FLAGS);
    kind=SYM_B(symbol,SYM_STORAGE_CLASS)>>3;
    RTL_MEMSET((void far *)&record,0,10);
    if (TYPE_W(type,TYPE_KIND)==TK_FUNCTION)
        record.value=flags&0x80 ? 0xFFFF : CODE_SEGMENT_ID;
    else switch (kind) {
    case 2:
        if ((flags&0x80) || DATA_BSS_GROUPS_DIFFER) {
            record.value=0xFFFF;
            break;
        }
        /* fall through */
    case 1:
    case 3:
    case 4:
        if (TYPE_W(type,TYPE_KIND)==TK_ARRAY && (TYPE_B(type,TYPE_ATTRS)&0x40)) {
            record.value=0xFFFF;    /* cross-jumped onto the copy in case 2 */
            break;
        }
        if (flags&0x80) record.value=DEFINE_FAR_SEGMENT();
        else record.value=flags&1 ? DATA_SEGMENT_ID : BSS_SEGMENT_ID;
        break;
    default:
        record.value=BSS_SEGMENT_ID;
    }
    if (TYPE_W(type,TYPE_KIND)==TK_FUNCTION && (SYM_B(symbol,SYM_INLINE_ACCESS)&3)==3)
        record.extra=SYM_W(symbol,SYM_INTRINSIC_NUM);
    record.type=symbol;
    record.flags=(flags&0x40)|(flags&0x80 ? 0x10 : 4);
    if (TYPE_B(type,TYPE_ATTRS)&1) record.flags|=1;
    if (TYPE_B(type,TYPE_ATTRS)&2) record.flags|=2;
    if (TYPE_W(type,TYPE_KIND)==TK_FUNCTION && (TYPE_B(type,TYPE_FUNC_FLAGS)&0x80)) record.flags|=0x200;
    /* Each branch has its own `copy` (one shared stack slot); the block locals
       keep BC from merging the two struct-copy tails, as in the original. */
    if (kind==5 || kind==6) {
        unsigned int copy;

        copy=POOL_ALLOC(&STORAGE_POOL_SEG,10);
        SYM_W(symbol,SYM_STORAGE)=copy|1;
        *(struct X02CTypeRecord far *)MK_FP(STORAGE_POOL_SEG,copy)=record;
    } else {
        unsigned int copy;

        copy=POOL_ALLOC(&CSYM_POOL_SEG,10);
        STORAGE_RECORD_COUNT++;
        SYM_W(symbol,SYM_STORAGE)=copy;
        *(struct X02CTypeRecord far *)MK_FP(CSYM_POOL_SEG,copy)=record;
    }
    return SYM_W(symbol,SYM_STORAGE);
}

/* ---- GET_PREPARED_FLAGS (listing B682) ---- */
/* row X02C_09 (offset 0F62): stub 0C73:0089 = GET_PREPARED_FLAGS */

/* GET_PREPARED_FLAGS, SET_PREPARED_FLAGS, GET_PREPARED_SYMBOL, CLEAR_PREPARED_FLAGS:
   read or change the flag word or the symbol of a prepared storage record in either
   pool (bit 0 of record selects STORAGE_POOL_SEG). */
unsigned int far pascal GET_PREPARED_FLAGS(unsigned int record)
{
    if (record&1) return PSTOR_W(record&~1,PSTOR_FLAGS);
    return CSYM_W(record,CSYM_PREP_FLAGS);
}

/* ---- SET_PREPARED_FLAGS (listing B6AB) ---- */
/* row X02C_00 (offset 0F8B): stub 0C73:0084 = SET_PREPARED_FLAGS */

void far pascal SET_PREPARED_FLAGS(unsigned int record,unsigned int bits)
{
    if (record&1) PSTOR_W(record&~1,PSTOR_FLAGS)|=bits;
    else CSYM_W(record,CSYM_PREP_FLAGS)|=bits;
}

/* ---- GET_PREPARED_SYMBOL (listing B6D9) ---- */
/* row X02C_0A (offset 0FB9): stub 0C73:006B = GET_PREPARED_SYMBOL */

unsigned int far pascal GET_PREPARED_SYMBOL(unsigned int record)
{
    if (record&1) return PSTOR_W(record&~1,PSTOR_SYMBOL);
    return CSYM_W(record,CSYM_PREP_SYMBOL);
}

/* ---- CLEAR_PREPARED_FLAGS (listing B702) ---- */
/* row X02C_0C (offset 0FE2): stub 0C73:0070 = CLEAR_PREPARED_FLAGS */

void far pascal CLEAR_PREPARED_FLAGS(unsigned int record,unsigned int bits)
{
    if (record&1) PSTOR_W(record&~1,PSTOR_FLAGS)&=~bits;
    else CSYM_W(record,CSYM_PREP_FLAGS)&=~bits;
}

/* ---- SET_PREPARED_SYMBOL_FLAGS (listing B738) ---- */
/* row FIND_SYMBOL_IN_SCOPES (offset 1018): stub 0C73:0034 = SET_PREPARED_SYMBOL_FLAGS */

/* SET_PREPARED_SYMBOL_FLAGS / C56_NAME_FLAGS: set or read the SYM_FLAGS byte of the
   symbol a prepared record belongs to. */
void far pascal SET_PREPARED_SYMBOL_FLAGS(unsigned int record,unsigned char bits)
{
    SYM_B(GET_PREPARED_SYMBOL(record),SYM_FLAGS)|=bits;
}

/* ---- C56_NAME_FLAGS (listing B753) ---- */
/* row X02C_24 (offset 1033): stub 0C73:0057 = C56_NAME_FLAGS */

unsigned int far pascal C56_NAME_FLAGS(unsigned int record)
{
    return SYM_B(GET_PREPARED_SYMBOL(record),SYM_FLAGS);
}

/* ---- LIST_CONS (listing B76D) ---- */
/* row GET_PREPARED_FLAGS (offset 104D): stub 0C73:00CF = LIST_CONS */
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);

/* LIST_CONS: a new CONS cell (next, value); LIST_CELL_FREE frees one. LIST_CONS_ALT
   makes the same kind of cell in LIST_CELL_POOL_SEG (the LCELL pool). */
unsigned int far pascal LIST_CONS(unsigned int next,unsigned int value)
{
    unsigned int cell;

    cell=POOL_ALLOC_REUSE(&CONS_CELL_POOL_SEG,4);
    CONS_W(cell,CONS_NEXT)=next;
    CONS_W(cell,CONS_VALUE)=value;
    return cell;
}

/* ---- LIST_CELL_FREE (listing B799) ---- */
/* row LIST_CELL_FREE (offset 1079): stub 0C73:00D9 = LIST_CELL_FREE */
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);

void far pascal LIST_CELL_FREE(unsigned int cell)
{
    POOL_FREE_ITEM(&CONS_CELL_POOL_SEG,cell);
}

/* ---- LIST_CONS_ALT (listing B7AD) ---- */
/* row SET_TYPE_DEBUG_ID (offset 108D): stub 0C73:002A = LIST_CONS_ALT */

unsigned int far pascal LIST_CONS_ALT(unsigned int next,unsigned int value)
{
    unsigned int cell;

    cell=POOL_ALLOC_REUSE(&LIST_CELL_POOL_SEG,4);
    LCELL_W(cell,LCELL_NEXT)=next;
    LCELL_W(cell,LCELL_VALUE)=value;
    return cell;
}

/* ---- C0MARK (listing B7D9) ---- */
/* row SET_PREPARED_FLAGS (offset 10B9): stub 0C73:00D4 = C0MARK */

/* C0MARK: records the current SCOPE_LINK10_MARK (and, with both, TYPE_POOL_LENGTH) in
   every open block scope, so closing them does not throw away records made now
   (probably records that must outlive the function, such as types of statics). */
void far pascal C0MARK(unsigned char both)
{
    unsigned int scope;

    scope=CURRENT_SCOPE;
    while (scope!=GLOBAL_SCOPE) {
        SCOPE_W(scope,SCOPE_SAVED_LINK10_MARK)=SCOPE_LINK10_MARK;
        if (both) SCOPE_W(scope,SCOPE_SAVED_TYPE_LENGTH)=TYPE_POOL_LENGTH;
        scope=SCOPE_W(scope,SCOPE_PARENT);
    }
}

/* ---- ALLOC_FORMAL_RECORD (listing B80D) ---- */
/* row DECLARE_MEMBER (offset 10ED): stub 0C73:00DE = ALLOC_FORMAL_RECORD */

/* ALLOC_FORMAL_RECORD: a zeroed 10-byte formal parameter (FORMAL) record; the name
   is historical. */
unsigned int far pascal ALLOC_FORMAL_RECORD(void)
{
    unsigned int record;

    record=POOL_ALLOC(&FORMAL_POOL_SEG,10);
    RTL_MEMSET(MK_FP(FORMAL_POOL_SEG,record),0,10);
    return record;
}

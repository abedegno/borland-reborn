/* cppscope.c: from bcc20/src/cpp/CPPSCOPE.C: the C++ front end's basic tables, used by
   every other C++ file: record allocation for types, members, symbols, scopes, formal
   parameters and list cells; name lookup; scopes; and the "prepared" storage records that
   hand a symbol over to the code generator.
   - Types (TYPE_POOL): CREATE_TYPE allocates a record (struct, union and enum types also
     get a tag body); INTERN_QUALIFIED_TYPE and FIND_EQUIVALENT_TYPE share identical pointer
     and qualified types so that type comparisons can often compare record offsets.
     Duplicate pointer records found outside function bodies are kept on
     DUPLICATE_TYPE_FREE_LIST for reuse.
   - Names: every identifier is a NAME_POOL record whose NAME_SYMBOLS heads a chain of the
     global symbols with that name; the low three bits of SYM_STORAGE_CLASS tell the name
     space (1 ordinary, 2 tag).  The global scope's name and tag lists hold the marker
     records GLOBAL_SCOPE_NAMES and GLOBAL_SCOPE_TAGS, meaning "search the name's global
     chain" (C0FIND).  Other scopes keep plain lists.
   - Members: DECLARE_MEMBER adds to STRUCT_BODY_TYPE, the class being defined;
     FIND_MEMBER_BY_NAME looks a name up in one class through a 32-entry cache.
   - Scopes: PUSH_SCOPE and POP_SCOPE; POP_SCOPE also warns about unused locals and
     parameters and fixes up label records for gotos.
   - PREPARE_SYMBOL makes the 10-byte storage record {head, segment, intrinsic number,
     symbol, flags} for a symbol; the record offset has bit 0 set when it lives in
     STORAGE_POOL_SEG (autos and parameters) instead of CSYM_POOL_SEG.
   Several searches put the key into record 0 first, so the loop always ends (a sentinel).
   FIND_EQUIVALENT_TYPE and FIND_MEMBER_BY_NAME are inline assembly in the original; the
   port spells them in C. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"

#define FUNCTION_BODY_DEPTH W(FUNCTION_BODY_DEPTH_P)
#define TYPE_RECORD_SIZE(kind) SB(fp_add(TYPE_RECORD_SIZE_P, (kind)))
#define MEMBER_RECORD_SIZE(kind) SB(fp_add(MEMBER_RECORD_SIZE_P, (kind)))
#define SYMBOL_RECORD_SIZE(kind) SB(fp_add(SYMBOL_RECORD_SIZE_P, (kind) * 2 + CPP_MODE))
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define CACHE_SLOT(name, type) ((u16)(((name) ^ (type)) + (((name) ^ (type)) >> 4)) & 0x1F)

/* a new zeroed member record of the size for kind */
u16 C9_ALLOC_MEMBER(u16 kind)
{
    u16 member = POOL_ALLOC(MEMBER_SEGMENT_P, MEMBER_RECORD_SIZE(kind));
    RTL_MEMSET(MK_FP(MEMBER_SEGMENT, member), 0, MEMBER_RECORD_SIZE(kind));
    return member;
}

/* a new type record that is a copy of type (its kind's size) */
u16 COPY_TYPE_RECORD(u16 type)
{
    u16 copy = POOL_ALLOC(TYPE_POOL_P, TYPE_RECORD_SIZE(TYPE_W(type, TYPE_KIND)));
    RTL_MEMMOVE(MK_FP(TYPE_POOL, copy), MK_FP(TYPE_POOL, type), TYPE_RECORD_SIZE(TYPE_W(type, TYPE_KIND)));
    return copy;
}

/* type itself if it is 0 or not pointer-like (EXPR_FLAGS & 14h).  Otherwise flag 80h of
   its word at 0Dh is cleared and, outside function bodies, the pool is searched from
   offset 15 for a record with the same kind byte and the same bytes 2 and 0Dh and words 3
   and 7.  When the first one found is not type itself, type is marked (flag 80h), put on
   DUPLICATE_TYPE_FREE_LIST through its word 3, and the copy is returned */
u16 FIND_EQUIVALENT_TYPE(u16 type)
{
    if (!type)
        return 0;
    u8 kind = TYPE_B(type, TYPE_KIND);
    if (!(EXPR_FLAGS_AT(kind) & 0x14))
        return type;
    TYPE_W(type, 0x0D) &= 0xFF7F;
    if (FUNCTION_BODY_DEPTH != 0)
        return type;
    u8 attributes = TYPE_B(type, TYPE_ATTRS);
    u16 target = TYPE_W(type, TYPE_TARGET);
    u16 cursor = 15;
    do {
        if (TYPE_B(cursor, TYPE_KIND) == kind && TYPE_W(cursor, TYPE_TARGET) == target
            && TYPE_B(cursor, 0x0D) == TYPE_B(type, 0x0D) && TYPE_B(cursor, TYPE_ATTRS) == attributes
            && TYPE_W(cursor, 3) == TYPE_W(type, 3)) {
            if (cursor == type)
                return type;
            TYPE_W(type, 0x0D) |= 0x80;
            TYPE_W(type, TYPE_FREE_NEXT) = DUPLICATE_TYPE_FREE_LIST;
            DUPLICATE_TYPE_FREE_LIST = type;
            return cursor;
        }
        cursor = (u16)(cursor + B(fp_add(TYPE_RECORD_SIZE_P, TYPE_B(cursor, TYPE_KIND))));
    } while (cursor < TYPE_POOL_LENGTH);
    return type;
}

/* the type record equal to type but with the qualifier bits qualifiers (const 1, volatile
   2; the other attribute bits are kept).  Scans the whole type pool (records start at
   offset 15) for a record of the same kind, attributes and member class and the same
   contents; otherwise makes a copy with the new attributes */
u16 INTERN_QUALIFIED_TYPE(u16 type, u16 qualifiers)
{
    u16 kind = TYPE_W(type, TYPE_KIND), other;
    qualifiers |= TYPE_B(type, TYPE_ATTRS) & 0xFFFC;
    for (u16 cursor = 15; cursor < TYPE_POOL_LENGTH; cursor = (u16)(cursor + TYPE_RECORD_SIZE(other))) {
        if ((other = TYPE_W(cursor, TYPE_KIND)) != kind || TYPE_B(cursor, TYPE_ATTRS) != qualifiers
            || TYPE_W(cursor, TYPE_MEMBER_CLASS) != TYPE_W(type, TYPE_MEMBER_CLASS))
            continue;
        switch (kind) {
        case TK_STRUCT:
        case TK_UNION:
        case TK_ENUM:
            if (TYPE_W(cursor, TYPE_TAG_BODY) == TYPE_W(type, TYPE_TAG_BODY))
                return cursor;
            break;
        case TK_FUNCTION:
            if (TYPE_W(cursor, TYPE_TARGET) == TYPE_W(type, TYPE_TARGET) && TYPE_W(cursor, TYPE_PARAMS) == TYPE_W(type, TYPE_PARAMS))
                return cursor;
            break;
        case TK_ARRAY:
            if (TYPE_W(cursor, TYPE_TARGET) == TYPE_W(type, TYPE_TARGET) && TYPE_L(cursor, TYPE_ARRAY_COUNT) == TYPE_L(type, TYPE_ARRAY_COUNT))
                return cursor;
            break;
        default:
            if (TYPE_W(cursor, TYPE_TARGET) == TYPE_W(type, TYPE_TARGET) && TYPE_B(cursor, TYPE_PTR_MODE) == TYPE_B(type, TYPE_PTR_MODE)
                && TYPE_W(cursor, TYPE_PTR_BASE) == TYPE_W(type, TYPE_PTR_BASE) && TYPE_W(cursor, TYPE_PTR_WORD_B) == TYPE_W(type, TYPE_PTR_WORD_B))
                return cursor;
            break;
        }
    }
    type = COPY_TYPE_RECORD(type);
    TYPE_B(type, TYPE_ATTRS) = (u8)qualifiers;
    return type;
}

/* the token code whose interned name is name, searching the table of {name, token} pairs
   backwards from C9_TOKEN_END; entry 0 is the sentinel, so a name that is no keyword gives
   entry 0's token */
u16 TOKEN_FROM_NAME(u16 name)
{
    W(C9_TOKEN_NAMES_P) = name;
    farptr entry = D(C9_TOKEN_END_P);
    while (W(entry) != name)
        entry = fp_add(entry, -4);
    return W(fp_add(entry, 2));
}

/* a zeroed type record of kind; a pointer-kind record is taken from
   DUPLICATE_TYPE_FREE_LIST when one is free and no function body is open */
u16 ALLOC_TYPE_RECORD(u16 kind)
{
    u16 type;
    if (FUNCTION_BODY_DEPTH == 0 && (EXPR_FLAGS_AT(kind) & 0x14) != 0 && DUPLICATE_TYPE_FREE_LIST != 0) {
        type = DUPLICATE_TYPE_FREE_LIST;
        DUPLICATE_TYPE_FREE_LIST = TYPE_W(type, TYPE_FREE_NEXT);
    } else
        type = POOL_ALLOC(TYPE_POOL_P, TYPE_RECORD_SIZE(kind));
    RTL_MEMSET(MK_FP(TYPE_POOL, type), 0, TYPE_RECORD_SIZE(kind));
    TYPE_W(type, TYPE_KIND) = kind;
    return type;
}

/* a zeroed tag body: 8 bytes for an enum or a C struct, 1Ch bytes for a C++ class */
u16 ALLOC_ENUM_LINK(void)
{
    u16 link = POOL_ALLOC(TAG_BODY_POOL_SEG_P, 8);
    RTL_MEMSET(MK_FP(TAG_BODY_POOL_SEG, link), 0, 8);
    return link;
}

u16 ALLOC_STRUCT_LINK(void)
{
    u16 size = CPP_MODE ? 0x1C : 8;
    u16 link = POOL_ALLOC(TAG_BODY_POOL_SEG_P, size);
    RTL_MEMSET(MK_FP(TAG_BODY_POOL_SEG, link), 0, size);
    return link;
}

/* a new type record of kind; enum, struct and union types get a new tag body */
u16 CREATE_TYPE(u16 kind)
{
    u16 type = ALLOC_TYPE_RECORD(kind);
    TYPE_W(type, TYPE_KIND) = kind;
    if (kind == TK_ENUM) {
        u16 link = ALLOC_ENUM_LINK();
        TYPE_W(type, TYPE_TAG_BODY) = link;
    } else if (kind == TK_STRUCT || kind == TK_UNION) {
        u16 link = ALLOC_STRUCT_LINK();
        TYPE_W(type, TYPE_TAG_BODY) = link;
    }
    return type;
}

/* the debug type index of a type, kept in the type record or, for struct, union and enum,
   in the tag body */
u16 GET_TYPE_DEBUG_ID(u16 type)
{
    switch (TYPE_W(type, TYPE_KIND)) {
    case TK_STRUCT:
    case TK_UNION:
    case TK_ENUM:
        return TAG_W(TYPE_W(type, TYPE_DEBUG_ID), TAG_DEBUG_ID);
    default:
        return TYPE_W(type, TYPE_DEBUG_ID);
    }
}

void SET_TYPE_DEBUG_ID(u16 type, u16 value)
{
    switch (TYPE_W(type, TYPE_KIND)) {
    case TK_STRUCT:
    case TK_UNION:
    case TK_ENUM:
        TAG_W(TYPE_W(type, TYPE_DEBUG_ID), TAG_DEBUG_ID) = value;
        break;
    default:
        TYPE_W(type, TYPE_DEBUG_ID) = value;
    }
}

/* a zeroed symbol record named name; its size depends on kind and on C or C++ mode */
u16 ALLOC_SYMBOL_ENTRY(u16 name, u16 kind)
{
    u16 symbol = POOL_ALLOC(SYMBOL_POOL_SEG_P, SYMBOL_RECORD_SIZE(kind));
    RTL_MEMSET(MK_FP(SYMBOL_POOL_SEG, symbol), 0, SYMBOL_RECORD_SIZE(kind));
    SYM_W(symbol, SYM_NAME) = name;
    return symbol;
}

/* links symbol into list head of the current scope (at offset list), or at global scope
   (head equal to marker) into its name's chain with name space space */
static void link_symbol(u16 symbol, u16 head, u16 marker, u16 list, u8 space)
{
    if (head == marker) {
        SYM_W(symbol, SYM_NEXT) = NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS);
        NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS) = symbol;
        SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 0xF8) | space;
    } else {
        SYM_W(symbol, SYM_NEXT) = head;
        SCOPE_W(CURRENT_SCOPE, list) = symbol;
    }
}

/* declares an ordinary name in the current scope: allocates the symbol, reports a
   multiple declaration if the scope already has the name, and links it into the scope's
   list or, at global scope, into the name's chain.  Despite its name it creates a symbol,
   not a type */
u16 BCC_TYPE_CREATE(u16 name, u16 kind)
{
    u16 symbol = ALLOC_SYMBOL_ENTRY(name, kind);
    u16 head = SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES);
    if (name != 0 && FIND_NAME_IN_LIST(name, head) != 0)
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, name);
    link_symbol(symbol, head, GLOBAL_SCOPE_NAMES, SCOPE_NAMES, 1);
    return symbol;
}

/* the same for a struct, union, enum or class tag (name space 2, the scope's tag list) */
u16 DECLARE_TAG(u16 name)
{
    u16 symbol = ALLOC_SYMBOL_ENTRY(name, 1);
    u16 head = SCOPE_W(CURRENT_SCOPE, SCOPE_TAGS);
    if (FIND_NAME_IN_LIST(name, head) != 0)
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, name);
    link_symbol(symbol, head, GLOBAL_SCOPE_TAGS, SCOPE_TAGS, 2);
    return symbol;
}

/* makes the member of an anonymous union visible as a plain name in the current scope: a
   symbol of storage class 14 that refers to member of the union object record */
void DECLARE_MEMBER_ALIAS(u16 member, u16 record)
{
    u16 symbol = BCC_TYPE_CREATE(MEMBER_W(member, MEMB_NAME), 8);
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x70;
    SYM_W(symbol, SYM_TYPE) = MEMBER_W(member, MEMB_TYPE);
    SYM_W(symbol, SYM_ALIAS_MEMBER) = member;
    SYM_W(symbol, SYM_ALIAS_OBJECT) = record;
}

/* the first symbol in name's global chain with name space kind, looking at most at the
   first two links; otherwise the third link, unchecked */
u16 C0FIND(u16 name, u16 kind)
{
    u16 symbol = NAME_W(name, NAME_SYMBOLS);
    if ((SYM_B(symbol, SYM_STORAGE_CLASS) & 7) == kind)
        return symbol;
    symbol = SYM_W(symbol, SYM_NEXT);
    if ((SYM_B(symbol, SYM_STORAGE_CLASS) & 7) == kind)
        return symbol;
    return SYM_W(symbol, SYM_NEXT);
}

/* the symbol called name in list (a scope's name or tag list), or 0; the global markers
   search the global chains */
u16 FIND_NAME_IN_LIST(u16 name, u16 list)
{
    if (list == GLOBAL_SCOPE_NAMES)
        return C0FIND(name, 1);
    if (list == GLOBAL_SCOPE_TAGS)
        return C0FIND(name, 2);
    SYM_W(0, SYM_NAME) = name;
    while (SYM_W(list, SYM_NAME) != name)
        list = SYM_W(list, SYM_NEXT);
    return list;
}

/* looks name up in the open block scopes from the innermost out, not including the global
   scope.  In C++ tags are found too, and the search stops at the function's outermost
   scope */
i16 FIND_SYMBOL_IN_SCOPES(u16 name)
{
    u16 found = 0;
    for (u16 scope = CURRENT_SCOPE; scope != GLOBAL_SCOPE; scope = SCOPE_W(scope, SCOPE_PARENT)) {
        found = FIND_NAME_IN_LIST(name, SCOPE_W(scope, SCOPE_NAMES));
        if (CPP_MODE && found == 0)
            found = FIND_NAME_IN_LIST(name, SCOPE_W(scope, SCOPE_TAGS));
        if (found != 0)
            break;
        if (CPP_MODE && SCOPE_B(scope, SCOPE_IS_FUNCTION) != 0)
            break;
    }
    return (i16)found;
}

/* full lookup of an ordinary name: block scopes, then global names, then in C++ global
   tags */
u16 LOOKUP_NAME(u16 name)
{
    u16 symbol = (u16)FIND_SYMBOL_IN_SCOPES(name);
    if (symbol == 0)
        symbol = FIND_NAME_IN_LIST(name, GLOBAL_SCOPE_NAMES);
    if (CPP_MODE && symbol == 0)
        symbol = FIND_NAME_IN_LIST(name, GLOBAL_SCOPE_TAGS);
    return symbol;
}

/* empties the member lookup cache (all three tables) */
void C9_CLEAR_MEMBER_TABLES(void)
{
    for (int slot = 0; slot < 32; ++slot)
        MEMBER_CACHE_TYPES_AT(slot) = MEMBER_CACHE_NAMES_AT(slot) = MEMBER_CACHE_MEMBERS_AT(slot) = 0;
}

/* stores (name, class type) -> member in its cache slot */
void CACHE_MEMBER_LOOKUP(u16 name, u16 type, u16 member)
{
    u16 slot = CACHE_SLOT(name, type);
    MEMBER_CACHE_TYPES_AT(slot) = type;
    MEMBER_CACHE_NAMES_AT(slot) = name;
    MEMBER_CACHE_MEMBERS_AT(slot) = member;
}

/* the member called name of class type (no bases), through the cache; on a miss the key
   is stored, the member list searched (member record 0's name word is the sentinel) and
   the result cached */
u16 FIND_MEMBER_BY_NAME(u16 name, u16 type)
{
    u16 slot = CACHE_SLOT(name, type);
    if (name == MEMBER_CACHE_NAMES_AT(slot) && type == MEMBER_CACHE_TYPES_AT(slot))
        return MEMBER_CACHE_MEMBERS_AT(slot);
    MEMBER_CACHE_NAMES_AT(slot) = name;
    MEMBER_CACHE_TYPES_AT(slot) = type;
    u16 member = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS);
    MEMBER_W(0, MEMB_NAME) = name;
    while (MEMBER_W(member, MEMB_NAME) != name)
        member = MEMBER_W(member, MEMB_NEXT);
    MEMBER_CACHE_MEMBERS_AT(slot) = member;
    return member;
}

/* looks up a tag: the tag lists of the open block scopes, then the global chain (name
   space 2, with record 0 as the sentinel).  The tag symbol or 0 */
u16 BCC_TYPE_PRIMARY(u16 name)
{
    for (u16 scope = CURRENT_SCOPE; scope != GLOBAL_SCOPE; scope = SCOPE_W(scope, SCOPE_PARENT)) {
        u16 symbol = FIND_NAME_IN_LIST(name, SCOPE_W(scope, SCOPE_TAGS));
        if (symbol != 0)
            return symbol;
    }
    SYM_B(0, SYM_STORAGE_CLASS) = (SYM_B(0, SYM_STORAGE_CLASS) & 0xF8) | 2;
    u16 symbol = NAME_W(name, NAME_SYMBOLS);
    while ((SYM_B(symbol, SYM_STORAGE_CLASS) & 7) != 2)
        symbol = SYM_W(symbol, SYM_NEXT);
    return symbol;
}

/* adds a member called name of kind (0 data, 1 enumerator, 2 static, 3 function) to the
   class being defined, with the current access SCOPE_STATE.  A name already declared is an
   error unless the old member has flag 80h.  Members are kept newest first and entered in
   the cache */
u16 DECLARE_MEMBER(u16 name, u16 kind)
{
    u16 member = FIND_MEMBER_BY_NAME(name, STRUCT_BODY_TYPE);
    if (member && !(MEMBER_B(member, MEMB_FLAGS) & 0x80))
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, name);
    member = C9_ALLOC_MEMBER(kind);
    MEMBER_W(member, MEMB_NEXT) = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS);
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS) = member;
    MEMBER_W(member, MEMB_NAME) = name;
    CACHE_MEMBER_LOOKUP(name, STRUCT_BODY_TYPE, member);
    MEMBER_B(member, MEMB_FLAGS) = (MEMBER_B(member, MEMB_FLAGS) & 0xFC) | ((u8)kind & 3);
    MEMBER_B(member, MEMB_FLAGS) = (MEMBER_B(member, MEMB_FLAGS) & 0xE3) | (((u8)SCOPE_STATE & 7) << 2);
    return member;
}

/* a global symbol (storage class 2) for a name given as text, used for compiler-made
   functions such as _STCON_ and run-time helpers.  value goes to SYM_GLOBAL_FLAGS; in C++,
   extra is the function kind and linkage is 1 */
u16 DECLARE_GLOBAL_SYMBOL(farptr name, u16 type, u16 value, u16 extra)
{
    u16 symbol = ALLOC_SYMBOL_ENTRY(BCC_SYMBOL_CREATE(name, 0), 6);
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 0xF8) | 1;
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x10;
    SYM_W(symbol, SYM_NEXT) = NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS);
    NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS) = symbol;
    SYM_W(symbol, SYM_TYPE) = type;
    SYM_W(symbol, SYM_STORAGE) = 0;
    SYM_W(symbol, SYM_GLOBAL_FLAGS) = value;
    if (CPP_MODE) {
        SYM_W(symbol, SYM_FUNC_KIND) = extra;
        SYM_W(symbol, SYM_LINKAGE) = 1;
        SYM_B(symbol, SYM_INLINE_ACCESS) &= 0xFC;
    }
    return symbol;
}

/* a new scope record, saving the marks that POP_SCOPE restores and the nesting level */
u16 ALLOC_SCOPE(void)
{
    u16 scope = POOL_ALLOC(SCOPE_POOL_SEG_P, 0x15);
    SCOPE_W(scope, SCOPE_PARENT) = 0;
    SCOPE_W(scope, SCOPE_NAMES) = 0;
    SCOPE_W(scope, SCOPE_TAGS) = 0;
    SCOPE_W(scope, SCOPE_SAVED_LINK10_MARK) = SCOPE_LINK10_MARK;
    SCOPE_W(scope, SCOPE_SAVED_TYPE_LENGTH) = TYPE_POOL_LENGTH;
    SCOPE_W(scope, SCOPE_NEST_LEVEL) = BLOCK_NEST_LEVEL;
    SCOPE_W(scope, SCOPE_ENTER_BLOCK) = 0;
    SCOPE_W(scope, SCOPE_STMT_LEVEL) = 0;
    SCOPE_W(scope, SCOPE_SAVED_INIT_SERIAL) = (u16)DECL_INIT_SERIAL;
    SCOPE_W(scope, SCOPE_TEMPS) = 0;
    SCOPE_B(scope, SCOPE_IS_FUNCTION) = 0;
    return scope;
}

/* opens a scope inside the current one (kind 1 for a function body).  The new scope
   starts with the enclosing scope's list of temporaries to destroy */
void PUSH_SCOPE(u8 kind)
{
    u16 scope = ALLOC_SCOPE();
    SCOPE_W(scope, SCOPE_TEMPS) = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    SCOPE_B(scope, SCOPE_IS_FUNCTION) = kind;
    SCOPE_W(scope, SCOPE_PARENT) = CURRENT_SCOPE;
    CURRENT_SCOPE = scope;
}

/* closes the current scope.  Unless leaving is set (the scope is being abandoned and its
   temporaries handed to the parent) it warns about unused names (a parameter never used,
   an auto variable never used or set but never read, a reference counting as never used),
   moves extern declarations made inside the block to their global chains, and at a
   function's outermost scope frees the temporaries recorded on labels and resets the type
   pool and link marks saved when the scope was opened.  Label records whose goto serial
   range overlaps declarations made in this scope get their upper serial reset */
void POP_SCOPE(u8 leaving)
{
    u16 scope = CURRENT_SCOPE, symbol;
    u8 outer = scope == BCC_TREE_LINK || (CPP_MODE && SCOPE_B(scope, SCOPE_IS_FUNCTION));
    if (!leaving) {
        for (symbol = SCOPE_W(scope, SCOPE_NAMES); symbol; symbol = SYM_W(symbol, SYM_NEXT)) {
            if (SYM_W(symbol, SYM_NAME) == 0)
                continue;
            u16 message = 0;
            switch (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) {
            case 6:
                if (!(SYM_B(symbol, SYM_FLAGS) & 4))
                    message = 0x163;
                break;
            case 4:
            case 5:
                if (!(SYM_B(symbol, SYM_FLAGS) & 7))
                    message = 0x17C;
                else if (!(SYM_B(symbol, SYM_FLAGS) & 4))
                    message = (EXPR_FLAGS_AT(TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND)) & 0x14)
                                      && (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_ATTRS) & 0x20)
                                  ? 0x17C
                                  : 0x173;
                break;
            }
            if (message)
                REPORT_DIAGNOSTIC((i16)message, (i32)NAME_TEXT_COPY(SYM_W(symbol, SYM_NAME)), 0);
        }
    }
    for (u16 block = LABEL_LIST_HEAD; block; block = LABEL_W(block, LABEL_NEXT)) {
        if (outer && !leaving) {
            if (CPP_MODE) {
                while (LABEL_W(block, LABEL_TEMPS)) {
                    u16 item = LABEL_W(block, LABEL_TEMPS);
                    LABEL_W(block, LABEL_TEMPS) = TDTOR_W(item, TDTOR_NEXT);
                    FREE_TEMP_ENTRY(item);
                }
            }
        } else if ((LABEL_I(block, LABEL_SERIAL_HIGH) > SCOPE_I(scope, SCOPE_SAVED_INIT_SERIAL) && LABEL_I(block, LABEL_SERIAL_HIGH) <= DECL_INIT_SERIAL)
                   || (LABEL_I(block, LABEL_SERIAL_LOW) > SCOPE_I(scope, SCOPE_SAVED_INIT_SERIAL) && LABEL_I(block, LABEL_SERIAL_LOW) <= DECL_INIT_SERIAL))
            LABEL_W(block, LABEL_SERIAL_HIGH) = SCOPE_W(scope, SCOPE_SAVED_INIT_SERIAL);
    }
    DECL_INIT_SERIAL = SCOPE_I(scope, SCOPE_SAVED_INIT_SERIAL);
    CURRENT_SCOPE = SCOPE_W(scope, SCOPE_PARENT);
    if (leaving)
        SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) = SCOPE_W(scope, SCOPE_TEMPS);
    else {
        symbol = SCOPE_W(scope, SCOPE_NAMES);
        while (symbol) {
            u16 next = SYM_W(symbol, SYM_NEXT);
            if ((SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) == 2) {
                SYM_B(symbol, SYM_STORAGE_CLASS) &= 0xF8;
                SYM_W(symbol, SYM_NEXT) = NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS);
                NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS) = symbol;
            }
            symbol = next;
        }
    }
    if (outer && !leaving) {
        SCOPE_LINK10_MARK_HIGH = 0;
        SCOPE_LINK10_MARK = SCOPE_W(scope, SCOPE_SAVED_LINK10_MARK);
        TYPE_POOL_WORD6 = 0;
        TYPE_POOL_LENGTH = SCOPE_W(scope, SCOPE_SAVED_TYPE_LENGTH);
    }
}

/* a zeroed 13-byte label record linked on LABEL_LIST_HEAD, its upper serial open */
u16 ALLOC_LABEL_RECORD(void)
{
    u16 block = POOL_ALLOC(LABEL_POOL_SEG_P, 13);
    RTL_MEMSET(MK_FP(LABEL_POOL_SEG, block), 0, 13);
    LABEL_W(block, LABEL_NEXT) = LABEL_LIST_HEAD;
    LABEL_LIST_HEAD = block;
    LABEL_W(block, LABEL_SERIAL_HIGH) = 0x7FFF;
    return block;
}

/* a zeroed 10-byte pending-goto record linked on PENDING_GOTO_LIST */
u16 ALLOC_JUMP_RECORD(void)
{
    u16 block = POOL_ALLOC(LABEL_POOL_SEG_P, 10);
    RTL_MEMSET(MK_FP(LABEL_POOL_SEG, block), 0, 10);
    LABEL_W(block, GOTO_NEXT) = PENDING_GOTO_LIST;
    PENDING_GOTO_LIST = block;
    return block;
}

/* the storage record of symbol (cached in SYM_STORAGE), made the first time.  A member
   alias uses its union object's record.  The segment word is CODE_SEGMENT_ID for near
   functions, FFFFh for far functions, far arrays and externals that need it, a new far
   segment for far data, DATA_SEGMENT_ID for initialized data and BSS_SEGMENT_ID otherwise.
   The flag word gets 4 (near) or 10h (far), const 1, volatile 2, flag 40h from the symbol
   and 200h for functions with type flag 80h.  Autos and parameters (classes 5, 6) go to
   STORAGE_POOL_SEG with bit 0 set in the returned offset; others to CSYM_POOL_SEG */
u16 PREPARE_SYMBOL(u16 symbol)
{
    if ((SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) == 14)
        return PREPARE_SYMBOL(SYM_W(symbol, SYM_ALIAS_OBJECT));
    if (SYM_W(symbol, SYM_STORAGE) != 0)
        return SYM_W(symbol, SYM_STORAGE);
    u16 type = SYM_W(symbol, SYM_TYPE);
    u8 flags = SYM_B(symbol, SYM_FLAGS);
    i16 kind = SYM_B(symbol, SYM_STORAGE_CLASS) >> 3;
    /* the original frame from BP-10h: the record at 2 */
    u16 mark = scratch_mark();
    farptr record = fp_add(scratch_alloc(0x10), 2);
#define RECORD(i) W(fp_add(record, (i) * 2))
    RTL_MEMSET(record, 0, 10);
    if (TYPE_W(type, TYPE_KIND) == TK_FUNCTION)
        RECORD(1) = flags & 0x80 ? 0xFFFF : CODE_SEGMENT_ID;
    else
        switch (kind) {
        case 2:
            if ((flags & 0x80) || DATA_BSS_GROUPS_DIFFER) {
                RECORD(1) = 0xFFFF;
                break;
            }
            /* fall through */
        case 1:
        case 3:
        case 4:
            if (TYPE_W(type, TYPE_KIND) == TK_ARRAY && (TYPE_B(type, TYPE_ATTRS) & 0x40)) {
                RECORD(1) = 0xFFFF;
                break;
            }
            if (flags & 0x80)
                RECORD(1) = DEFINE_FAR_SEGMENT();
            else
                RECORD(1) = flags & 1 ? DATA_SEGMENT_ID : BSS_SEGMENT_ID;
            break;
        default:
            RECORD(1) = BSS_SEGMENT_ID;
        }
    if (TYPE_W(type, TYPE_KIND) == TK_FUNCTION && (SYM_B(symbol, SYM_INLINE_ACCESS) & 3) == 3)
        RECORD(2) = SYM_W(symbol, SYM_INTRINSIC_NUM);
    RECORD(3) = symbol;
    RECORD(4) = (flags & 0x40) | (flags & 0x80 ? 0x10 : 4);
    if (TYPE_B(type, TYPE_ATTRS) & 1)
        RECORD(4) |= 1;
    if (TYPE_B(type, TYPE_ATTRS) & 2)
        RECORD(4) |= 2;
    if (TYPE_W(type, TYPE_KIND) == TK_FUNCTION && (TYPE_B(type, TYPE_FUNC_FLAGS) & 0x80))
        RECORD(4) |= 0x200;
    u16 copy;
    farptr to;
    if (kind == 5 || kind == 6) {
        copy = POOL_ALLOC(STORAGE_POOL_SEG_P, 10);
        SYM_W(symbol, SYM_STORAGE) = copy | 1;
        to = MK_FP(STORAGE_POOL_SEG, copy);
    } else {
        copy = POOL_ALLOC(CSYM_POOL_SEG_P, 10);
        STORAGE_RECORD_COUNT++;
        SYM_W(symbol, SYM_STORAGE) = copy;
        to = MK_FP(CSYM_POOL_SEG, copy);
    }
    for (int i = 0; i < 5; ++i)
        W(fp_add(to, i * 2)) = RECORD(i);
#undef RECORD
    scratch_release(mark);
    return SYM_W(symbol, SYM_STORAGE);
}

/* read or change the flag word or the symbol of a prepared storage record in either pool
   (bit 0 of record selects STORAGE_POOL_SEG) */
u16 GET_PREPARED_FLAGS(u16 record)
{
    if (record & 1)
        return PSTOR_W(record & ~1, PSTOR_FLAGS);
    return CSYM_W(record, CSYM_PREP_FLAGS);
}

void SET_PREPARED_FLAGS(u16 record, u16 bits)
{
    if (record & 1)
        PSTOR_W(record & ~1, PSTOR_FLAGS) |= bits;
    else
        CSYM_W(record, CSYM_PREP_FLAGS) |= bits;
}

u16 GET_PREPARED_SYMBOL(u16 record)
{
    if (record & 1)
        return PSTOR_W(record & ~1, PSTOR_SYMBOL);
    return CSYM_W(record, CSYM_PREP_SYMBOL);
}

void CLEAR_PREPARED_FLAGS(u16 record, u16 bits)
{
    if (record & 1)
        PSTOR_W(record & ~1, PSTOR_FLAGS) &= ~bits;
    else
        CSYM_W(record, CSYM_PREP_FLAGS) &= ~bits;
}

/* set or read the SYM_FLAGS byte of the symbol a prepared record belongs to */
void SET_PREPARED_SYMBOL_FLAGS(u16 record, u8 bits)
{
    SYM_B(GET_PREPARED_SYMBOL(record), SYM_FLAGS) |= bits;
}

u16 C56_NAME_FLAGS(u16 record)
{
    return SYM_B(GET_PREPARED_SYMBOL(record), SYM_FLAGS);
}

/* a new list cell (next, value); LIST_CELL_FREE frees one.  LIST_CONS_ALT makes the same
   kind of cell in LIST_CELL_POOL_SEG */
u16 LIST_CONS(u16 next, u16 value)
{
    u16 cell = POOL_ALLOC_REUSE(CONS_CELL_POOL_SEG_P, 4);
    CONS_W(cell, CONS_NEXT) = next;
    CONS_W(cell, CONS_VALUE) = value;
    return cell;
}

void LIST_CELL_FREE(u16 cell)
{
    POOL_FREE_ITEM(CONS_CELL_POOL_SEG_P, cell);
}

u16 LIST_CONS_ALT(u16 next, u16 value)
{
    u16 cell = POOL_ALLOC_REUSE(LIST_CELL_POOL_SEG_P, 4);
    LCELL_W(cell, LCELL_NEXT) = next;
    LCELL_W(cell, LCELL_VALUE) = value;
    return cell;
}

/* records the current SCOPE_LINK10_MARK (and, with both, TYPE_POOL_LENGTH) in every open
   block scope, so closing them does not throw away records made now */
void C0MARK(u8 both)
{
    for (u16 scope = CURRENT_SCOPE; scope != GLOBAL_SCOPE; scope = SCOPE_W(scope, SCOPE_PARENT)) {
        SCOPE_W(scope, SCOPE_SAVED_LINK10_MARK) = SCOPE_LINK10_MARK;
        if (both)
            SCOPE_W(scope, SCOPE_SAVED_TYPE_LENGTH) = TYPE_POOL_LENGTH;
    }
}

/* a zeroed 10-byte formal parameter record */
u16 ALLOC_FORMAL_RECORD(void)
{
    u16 record = POOL_ALLOC(FORMAL_POOL_SEG_P, 10);
    RTL_MEMSET(MK_FP(FORMAL_POOL_SEG, record), 0, 10);
    return record;
}

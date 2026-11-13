/* csymtab.c: from bcc20/src/types/CSYMTAB.C: the C-mode symbol table.

   C symbols are 16-byte CSYM_POOL_SEG records (CSYM_* fields).  Their name space
   (CSYM_NAMESPACE: 0 ordinary, 1 label, 2 tag) is "storage" in the parameter lists, their
   class (CSYM_CLASS) "kind".  Global symbols hang on the name record (NAME_SYMBOLS),
   unnamed ones on C_UNNAMED_GLOBAL_LIST; locals in the symbol list (SCOPE_C_SYMBOLS) of a
   scope cell in SCOPE_POOL_SEG, the cells a tree (child, sibling, parent) rooted at
   C_GLOBAL_SCOPE.  An extern declared in a block is a global symbol plus a local class-2
   cell whose CSYM_TYPE points at it.  Flags: 20h has a definition, 40h assigned, 80h used,
   200h declared at file level and visible, 1000h in a register (CSYM_SEGMENT the
   register); 10h probably "far" (a helper called far; CSYM_SEGMENT then FFFFh). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "kind.h"
#include "protos.h"
#include "calls.h"
#include "variadic.h"

#define DIAG_NAME_BUFFER W(DIAG_NAME_BUFFER_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define PRAGMA_ARGSUSED_PENDING SB(PRAGMA_ARGSUSED_PENDING_P)
#define NEAR_HELPER_CALLS SB(NEAR_HELPER_CALLS_P)
#define HASH_HEAD(h) W(fp_add(NAME_HASH_TABLE_P, 2 * (h)))
#define TB(n) B(MK_FP(TYPE_POOL, (n)))

/* a new, empty scope cell as the first child of owner */
u16 CREATE_SCOPE(u16 owner)
{
    u16 cell = POOL_ALLOC_REUSE(SCOPE_POOL_SEG_P, 8);
    RTL_MEMSET(MK_FP(SCOPE_POOL_SEG, cell), 0, 8);
    SCOPE_W(cell, SCOPE_C_PARENT) = owner;
    SCOPE_W(cell, SCOPE_C_SIBLING) = SCOPE_W(owner, SCOPE_C_CHILD);
    SCOPE_W(owner, SCOPE_C_CHILD) = cell;
    return cell;
}

/* the symbol name in name space kind, from scope input up to (not including) the global
   scope, then among the visible globals (flag 200h); a local extern cell gives its global */
static u16 find_in_scope(u16 scope, u16 name, u8 kind)
{
    for (u16 node = SCOPE_W(scope, SCOPE_C_SYMBOLS); node; node = CSYM_W(node, CSYM_NEXT))
        if (CSYM_W(node, CSYM_NAME) == name && CSYM_B(node, CSYM_NAMESPACE) == kind)
            return CSYM_B(node, CSYM_CLASS) == 2 ? CSYM_W(node, CSYM_TYPE) : node;
    return 0;
}

static u16 find_global(u16 name, u8 kind)
{
    u16 node = NAME_W(name, NAME_SYMBOLS);
    while (node && CSYM_B(node, CSYM_NAMESPACE) != kind)
        node = CSYM_W(node, CSYM_NEXT);
    return node && (CSYM_W(node, CSYM_FLAGS) & 0x200) ? node : 0;
}

u16 LOOKUP_SYMBOL(u16 name, u16 input, u8 kind)
{
    for (u16 scope = input; scope != 0 && scope != C_GLOBAL_SCOPE; scope = SCOPE_W(scope, SCOPE_C_PARENT))
        for (u16 node = SCOPE_W(scope, SCOPE_C_SYMBOLS); node; node = CSYM_W(node, CSYM_NEXT))
            if (CSYM_W(node, CSYM_NAME) == name && CSYM_B(node, CSYM_NAMESPACE) == kind)
                return CSYM_B(node, CSYM_CLASS) == 2 ? CSYM_W(node, CSYM_TYPE) : node;
    return find_global(name, kind);
}

/* as LOOKUP_SYMBOL in the one scope given (a redeclaration in the same block) */
u16 BCC_STMT_FIND2(u16 name, u16 scope, u8 kind)
{
    if (scope != C_GLOBAL_SCOPE)
        return find_in_scope(scope, name, kind);
    return find_global(name, kind);
}

void REPORT_MULTIPLE_DECLARATION(u16 name)
{
    DIAG_NAME_BUFFER = 0;
    REPORT_ERROR(MSG_MULTIPLE_DECLARATION, NAME_TEXT_COPY(name));
}

/* of two compatible declarations, the type to keep: for functions the one with parameters
   (or a prototype), for arrays the one with a size; otherwise first */
u16 MERGE_DECLARED_TYPES(u16 first, u16 second)
{
    if (TYPE_B(first, TYPE_KIND) == TK_FUNCTION)
        return TYPE_W(first, TYPE_C_PARAMS) == 0 &&
                       (TYPE_W(second, TYPE_C_PARAMS) != 0 || (TYPE_B(second, TYPE_C_FUNC_FLAGS) & 8) == 0)
                   ? second : first;
    if (TYPE_B(first, TYPE_KIND) == TK_ARRAY)
        return TYPE_UL(first, TYPE_C_SIZE) == 0 ? second : first;
    return first;
}

/* check the types of a redeclaration and keep the more complete one */
static void merge_type(u16 node, u16 name, u16 type)
{
    if (!TYPE_RECORDS_COMPATIBLE(CSYM_W(node, CSYM_TYPE), type, 0)) {
        DIAG_NAME_BUFFER = 0;
        REPORT_ERROR(MSG_TYPE_MISMATCH, NAME_TEXT_COPY(name));
    } else
        CSYM_W(node, CSYM_TYPE) = MERGE_DECLARED_TYPES(type, CSYM_W(node, CSYM_TYPE));
}

/* the class check of an extern redeclaration (kind 2): returns 1 when it is complete
   (a class-10 symbol given its type) */
static int extern_class(u16 node, u16 name, u16 type, u16 isconst)
{
    if (CSYM_B(node, CSYM_CLASS) == 10) {
        if (CSYM_W(node, CSYM_TYPE) == 0) {
            CSYM_W(node, CSYM_TYPE) = type;
            return 1;
        }
    } else if (CSYM_B(node, CSYM_CLASS) != 2 && CSYM_B(node, CSYM_CLASS) != 3 && CSYM_B(node, CSYM_CLASS) != 1)
        REPORT_MULTIPLE_DECLARATION(name);
    else if (isconst && CSYM_B(node, CSYM_CLASS) == 2 && CSYM_W(node, CSYM_SEGMENT) != 0xFFFF)
        REPORT_MULTIPLE_DECLARATION(name);
    return 0;
}

static u16 new_csym(void)
{
    u16 node = POOL_ALLOC_REUSE(CSYM_POOL_SEG_P, 0x10);
    RTL_MEMSET(MK_FP(CSYM_POOL_SEG, node), 0, 0x10);
    return node;
}

/* the file-level half of a block-level extern: the global symbol of that name and name
   space (class 8 skipped) is merged with, or a new class-2 global is appended */
u16 DECLARE_GLOBAL_VARIABLE(u16 name, u16 scope, u8 storage, u16 kind, u16 type, u16 value, u16 flags)
{
    (void)scope;
    (void)kind;
    u16 isconst = flags & 0x10, prev = 0, node;
    for (node = NAME_W(name, NAME_SYMBOLS); node; node = CSYM_W(node, CSYM_NEXT)) {
        if (CSYM_B(node, CSYM_NAMESPACE) == storage && CSYM_B(node, CSYM_CLASS) != 8)
            break;
        prev = node;
    }
    if (node) {
        if (extern_class(node, name, type, isconst))
            return node;
        CSYM_W(node, CSYM_FLAGS) |= flags;
        merge_type(node, name, type);
        return node;
    }
    node = new_csym();
    if (prev == 0)
        NAME_W(name, NAME_SYMBOLS) = node;
    else
        CSYM_W(prev, CSYM_NEXT) = node;
    CSYM_B(node, CSYM_CLASS) = 2;
    CSYM_W(node, CSYM_TYPE) = type;
    CSYM_W(node, CSYM_NAME) = name;
    CSYM_B(node, CSYM_NAMESPACE) = storage;
    CSYM_W(node, CSYM_FLAGS) = flags;
    if (isconst)
        CSYM_W(node, CSYM_SEGMENT) = 0xFFFF;
    else if (TB(CSYM_W(node, CSYM_TYPE)) == 0x12)
        CSYM_W(node, CSYM_SEGMENT) = CODE_SEGMENT_ID;
    else
        CSYM_W(node, CSYM_SEGMENT) = value;
    return node;
}

/* declare name (0 unnamed) in scope: name space storage, class kind, type, value (into
   CSYM_SEGMENT) and flags.  At file level a redeclaration is merged into the old symbol
   after checking classes and types; in a block an extern (kind 2) is a global plus a local
   class-2 cell, and any other redeclaration in the block is an error.  New symbols get
   default use flags by class. */
u16 DECLARE_SYMBOL(u16 name, u16 scope, u8 storage, u16 kind, u16 type, u16 value, u16 flags)
{
    u16 isconst = flags & 0x10, node;
    if (!name)
        goto create;
    if (scope == C_GLOBAL_SCOPE) {
        for (node = NAME_W(name, NAME_SYMBOLS); node; node = CSYM_W(node, CSYM_NEXT))
            if (CSYM_B(node, CSYM_NAMESPACE) == storage && (kind != 8 || (CSYM_W(node, CSYM_FLAGS) & 0x200)))
                break;
        if (!node)
            goto create;
        if ((CSYM_W(node, CSYM_FLAGS) & 0x20) && (flags & 0x20)) {
            REPORT_MULTIPLE_DECLARATION(name);
            return node;
        }
        switch (kind) {
        case 2:
            if (extern_class(node, name, type, isconst))
                return node;
            break;
        case 1:
        case 3:
            if (CSYM_B(node, CSYM_CLASS) != 2 && CSYM_B(node, CSYM_CLASS) != 1 && CSYM_B(node, CSYM_CLASS) != 3)
                REPORT_MULTIPLE_DECLARATION(name);
            else if (CSYM_B(node, CSYM_CLASS) != 3) {
                CSYM_B(node, CSYM_CLASS) = (u8)kind;
                CSYM_W(node, CSYM_FLAGS) |= 0x40;
                if (kind == 1)
                    CSYM_W(node, CSYM_FLAGS) |= 0x80;
            }
            if (flags & 0x20)
                CSYM_W(node, CSYM_SEGMENT) = value;
            break;
        default:
            REPORT_MULTIPLE_DECLARATION(name);
        }
        CSYM_W(node, CSYM_FLAGS) |= 0x200 | flags;
        merge_type(node, name, type);
        return node;
    }
    for (node = SCOPE_W(scope, SCOPE_C_SYMBOLS); node; node = CSYM_W(node, CSYM_NEXT))
        if (CSYM_W(node, CSYM_NAME) == name && CSYM_B(node, CSYM_NAMESPACE) == storage)
            break;
    if (kind == 2) {
        if (node) {
            if (CSYM_B(node, CSYM_CLASS) != 2)
                REPORT_MULTIPLE_DECLARATION(name);
            node = CSYM_W(node, CSYM_TYPE);
            merge_type(node, name, type);
        } else {
            node = DECLARE_GLOBAL_VARIABLE(name, C_GLOBAL_SCOPE, storage, kind, type, value, flags);
            u16 cell = new_csym();
            CSYM_W(cell, CSYM_TYPE) = node;
            CSYM_B(cell, CSYM_CLASS) = 2;
            CSYM_W(cell, CSYM_NAME) = name;
            CSYM_W(cell, CSYM_FLAGS) = CSYM_W(node, CSYM_FLAGS);
            CSYM_W(cell, CSYM_NEXT) = SCOPE_W(scope, SCOPE_C_SYMBOLS);
            SCOPE_W(scope, SCOPE_C_SYMBOLS) = cell;
        }
        return node;
    }
    if (node) {
        REPORT_MULTIPLE_DECLARATION(name);
        return node;
    }
create:
    node = new_csym();
    if (scope == C_GLOBAL_SCOPE) {
        if (name) {
            CSYM_W(node, CSYM_NEXT) = NAME_W(name, NAME_SYMBOLS);
            NAME_W(name, NAME_SYMBOLS) = node;
        } else {
            CSYM_W(node, CSYM_NEXT) = C_UNNAMED_GLOBAL_LIST;
            C_UNNAMED_GLOBAL_LIST = node;
        }
        CSYM_B(node, CSYM_CLASS) = (u8)kind;
        CSYM_W(node, CSYM_TYPE) = type;
        CSYM_W(node, CSYM_NAME) = name;
        CSYM_B(node, CSYM_NAMESPACE) = storage;
        CSYM_W(node, CSYM_SEGMENT) = value;
        CSYM_W(node, CSYM_FLAGS) = 0x200 | flags;
        if (!isconst && TB(CSYM_W(node, CSYM_TYPE)) == 0x12)
            CSYM_W(node, CSYM_SEGMENT) = CODE_SEGMENT_ID;
        switch (kind) {
        case 3:
            CSYM_W(node, CSYM_FLAGS) |= 0x40;
            break;
        case 7: case 10: case 1: case 8: case 9:
            CSYM_W(node, CSYM_FLAGS) |= 0xC0;
            break;
        case 2:
            if (isconst)
                CSYM_W(node, CSYM_SEGMENT) = 0xFFFF;
            break;
        }
        return node;
    }
    CSYM_W(node, CSYM_NEXT) = SCOPE_W(scope, SCOPE_C_SYMBOLS);
    SCOPE_W(scope, SCOPE_C_SYMBOLS) = node;
    CSYM_B(node, CSYM_CLASS) = (u8)kind;
    CSYM_W(node, CSYM_TYPE) = type;
    CSYM_W(node, CSYM_NAME) = name;
    CSYM_W(node, CSYM_SEGMENT) = value;
    CSYM_W(node, CSYM_FLAGS) = flags;
    CSYM_B(node, CSYM_NAMESPACE) = storage;
    switch (kind) {
    case 8:
    case 9:
        CSYM_W(node, CSYM_FLAGS) |= 0x80;
        /* fall through */
    case 4:
        CSYM_W(node, CSYM_FLAGS) |= 0x40;
    }
    return node;
}

/* when the scope cell list closes: for each named symbol, a struct or union tag (class 11)
   still of size 0 gets "undefined structure" (enum tags skipped); local extern cells are
   skipped; assigned but never used gets "parameter never used" (class 6, unless #pragma
   argsused is pending) or "assigned a value that is never used" (outside the label name
   space); neither assigned nor used gets "declared but never used" */
void WARN_UNUSED_SYMBOLS(u16 list)
{
    for (u16 record = SCOPE_W(list, SCOPE_C_SYMBOLS); record; record = CSYM_W(record, CSYM_NEXT)) {
        u16 name = CSYM_W(record, CSYM_NAME);
        if (!name)
            continue;
        if (CSYM_B(record, CSYM_CLASS) == 11) {
            u16 type = CSYM_W(record, CSYM_TYPE);
            if (TB(type) == 21 || W(MK_FP(TYPE_POOL, type + 3)))
                continue;
            DIAG_NAME_BUFFER = 0;
            REPORT_WARNING(MSG_UNDEFINED_STRUCTURE_383, NAME_TEXT_COPY(name));
            continue;
        }
        if (CSYM_B(record, CSYM_CLASS) == 2)
            continue;
        u16 flags = CSYM_W(record, CSYM_FLAGS);
        if ((flags & 0xC0) == 0x40) {
            if (CSYM_B(record, CSYM_CLASS) == 6) {
                if (!PRAGMA_ARGSUSED_PENDING) {
                    DIAG_NAME_BUFFER = 0;
                    REPORT_WARNING(MSG_PARAMETER_NEVER_USED, NAME_TEXT_COPY(name));
                }
            } else if (CSYM_B(record, CSYM_NAMESPACE) != 1) {
                DIAG_NAME_BUFFER = 0;
                REPORT_WARNING(MSG_ASSIGNED_VALUE_THAT, NAME_TEXT_COPY(name));
            }
        } else if (!(flags & 0xC0)) {
            DIAG_NAME_BUFFER = 0;
            REPORT_WARNING(MSG_DECLARED_BUT_NEVER, NAME_TEXT_COPY(name));
        }
    }
}

/* look for name in the members of the tag symbol owner: the first match goes to *found;
   0 when a later match conflicts with it (another offset or type), else 1 */
i16 FIND_MEMBER_IN_STRUCT(u16 owner, u16 name, farptr found)
{
    for (u16 node = TYPE_W(CSYM_W(owner, CSYM_TYPE), TYPE_C_PARAMS); node; node = MEMBER_W(node, MEMB_NEXT))
        if (MEMBER_W(node, MEMB_NAME) == name) {
            if (W(found) == 0) {
                W(found) = node;
                return 1;
            }
            if (MEMBER_W(W(found), MEMB_C_OFFSET) != MEMBER_W(node, MEMB_C_OFFSET) ||
                !TYPE_RECORDS_COMPATIBLE(MEMBER_W(W(found), MEMB_C_TYPE), MEMBER_W(node, MEMB_C_TYPE), 0))
                return 0;
        }
    return 1;
}

/* FIND_MEMBER_IN_STRUCT over every tag (class 11) of one scope; for the global scope the
   whole name hash table and then the unnamed list.  0 stops the search (a conflict). */
i16 FIND_MEMBER_IN_SCOPE(u16 scope, u16 name, farptr found)
{
    if (scope == C_GLOBAL_SCOPE) {
        for (i16 bucket = 0; bucket < 0x400; bucket++)
            for (u16 chain = HASH_HEAD(bucket); chain; chain = HLINK_W(chain, HLINK_NEXT))
                for (u16 node = NAME_W(chain, NAME_SYMBOLS); node; node = CSYM_W(node, CSYM_NEXT))
                    if (CSYM_B(node, CSYM_CLASS) == 11 && !FIND_MEMBER_IN_STRUCT(node, name, found))
                        return 0;
        for (u16 c = C_UNNAMED_GLOBAL_LIST; c; c = CSYM_W(c, CSYM_NEXT))
            if (CSYM_B(c, CSYM_CLASS) == 11 && !FIND_MEMBER_IN_STRUCT(c, name, found))
                return 0;
    } else
        for (u16 c = SCOPE_W(scope, SCOPE_C_SYMBOLS); c; c = CSYM_W(c, CSYM_NEXT))
            if (CSYM_B(c, CSYM_CLASS) == 11 && !FIND_MEMBER_IN_STRUCT(c, name, found))
                return 0;
    return 1;
}

/* the struct or union member name: in the given type's members, or with type 0 (the left
   operand of . or -> is not a struct, as old C allowed) in every tag visible from input,
   then all global tags, stopping at a conflicting second match */
u16 LOOKUP_MEMBER(u16 name, u16 input, u16 type)
{
    if (type) {
        u16 node = TYPE_W(type, TYPE_C_MEMBERS);
        while (node && MEMBER_W(node, MEMB_NAME) != name)
            node = MEMBER_W(node, MEMB_NEXT);
        return node;
    }
    u16 mark = scratch_mark();
    farptr found = scratch_alloc(2);
    W(found) = 0;
    u16 scope;
    for (scope = input; scope; scope = SCOPE_W(scope, SCOPE_C_PARENT))
        if (!FIND_MEMBER_IN_SCOPE(scope, name, found))
            break;
    if (!scope)
        FIND_MEMBER_IN_SCOPE(C_GLOBAL_SCOPE, name, found);
    u16 result = W(found);
    scratch_release(mark);
    return result;
}

/* add a member to a member list (head, 0 when empty): name, offset or enumerator value,
   bit offset, bit width, type, flags byte.  A duplicate is reported and returned;
   otherwise the (possibly new) head is returned. */
u16 ADD_STRUCT_MEMBER(u16 name, u16 head, u16 type, u16 flags, u8 first, u8 second, u8 third)
{
    u16 node = head;
    if (node)
        for (;;) {
            if (MEMBER_W(node, MEMB_NAME) == name) {
                REPORT_MULTIPLE_DECLARATION(name);
                return node;
            }
            if (MEMBER_W(node, MEMB_NEXT) == 0)
                break;
            node = MEMBER_W(node, MEMB_NEXT);
        }
    u16 created = POOL_ALLOC_REUSE(MEMBER_SEGMENT_P, 11);
    if (node)
        MEMBER_W(node, MEMB_NEXT) = created;
    else
        head = created;
    MEMBER_W(created, MEMB_NEXT) = 0;
    MEMBER_W(created, MEMB_NAME) = name;
    MEMBER_W(created, MEMB_C_OFFSET) = flags;
    MEMBER_B(created, MEMB_C_BIT_OFFSET) = first;
    MEMBER_B(created, MEMB_C_BIT_WIDTH) = second;
    MEMBER_W(created, MEMB_C_TYPE) = type;
    MEMBER_B(created, MEMB_C_FLAGS) = third;
    return head;
}

/* the expression leaf for identifier name, through the back end's node hooks: class 7 a
   node with the symbol's offset; 10 (an intrinsic: fatal without a type) and 1-4 an
   ordinary symbol node; 5 and 6 (locals, parameters) another node mode; 9 (an enumerator)
   an int constant; anything else (a typedef name) an error and an empty node.  0 when the
   name is not declared. */
u16 BUILD_SYMBOL_OPERAND(u16 name, u16 scope, u8 kind)
{
    u16 node = LOOKUP_SYMBOL(name, scope, kind);
    if (node == 0)
        return 0;
    u16 type = CSYM_W(node, CSYM_TYPE);
    switch (CSYM_B(node, CSYM_CLASS)) {
    case 7:
        return (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(4), A16(type), A16(node), A16(CSYM_W(node, CSYM_OFFSET)),
                             A16(CSYM_W(node, CSYM_FLAGS)));
    case 10:
        if (CSYM_W(node, CSYM_TYPE) == 0)
            REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        /* fall through */
    case 1: case 2: case 3: case 4:
        return (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(1), A16(type), A16(node), A16(0), A16(CSYM_W(node, CSYM_FLAGS)));
    case 5: case 6:
        return (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(type), A16(node), A16(0), A16(CSYM_W(node, CSYM_FLAGS)));
    case 9: {
        u16 mode = (u16)CALL_FAR(MODE_HOOK, A16(5));
        return (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(mode), A32((i32)(i16)CSYM_W(node, CSYM_OFFSET)));
    }
    default:
        REPORT_ERROR(MSG_IMPROPER_USE_TYPEDEF);
        return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(0), A16(0), A16(0), A16(0));
    }
}

/* declare (or mark used) an extern the compiler needs, given by its text (a run-time
   helper): _stklen gets the type MODE_HOOK(6), everything else C_HELPER_FUNC_TYPE; flag
   10h when helpers are called far, 400h when extra is set */
u16 DECLARE_NAMED_GLOBAL(u16 text, i16 extra)
{
    u16 name = BCC_SYMBOL_CREATE(DSPTR(text), 0);
    u16 node = LOOKUP_SYMBOL(name, C_GLOBAL_SCOPE, 0);
    if (node) {
        CSYM_W(node, CSYM_FLAGS) |= 0x80;
        return node;
    }
    u16 flags = 0x80;
    if (!NEAR_HELPER_CALLS)
        flags |= 0x10;
    if (extra)
        flags |= 0x400;
    u16 type = COMPARE_NAME(DSPTR(text), STR_STKLEN_P) ? C_HELPER_FUNC_TYPE : (u16)CALL_FAR(MODE_HOOK, A16(6));
    return DECLARE_SYMBOL(name, C_GLOBAL_SCOPE, 0, 2, type, 0, flags);
}

/* an unnamed class-5 symbol of the type in the current declaration scope (a temporary) */
u16 DECLARE_UNNAMED_SYMBOL(u16 type)
{
    return DECLARE_SYMBOL(0, C_DECL_SCOPE, 0, 5, type, 0, 0);
}

/* "possible use of name before definition" for the symbol */
void WARN_USE_BEFORE_ASSIGN(u16 node)
{
    DIAG_NAME_BUFFER = 0;
    REPORT_WARNING(MSG_POSSIBLE_USE_BEFORE, NAME_TEXT_COPY(CSYM_W(node, CSYM_NAME)));
}

/* the symbol's type kind, through arrays to the element */
u8 SYMBOL_ELEMENT_KIND(u16 input)
{
    u16 node = CSYM_W(input, CSYM_TYPE);
    while (TYPE_B(node, TYPE_KIND) == TK_ARRAY)
        node = TYPE_W(node, TYPE_TARGET);
    return TYPE_B(node, TYPE_KIND);
}

/* one-line accessors the back end reaches through the hook table */
void SET_SYMBOL_FLAG_20(u16 node) { CSYM_W(node, CSYM_FLAGS) |= 0x20; }
u16 GET_SYMBOL_OFFSET(u16 node) { return CSYM_W(node, CSYM_OFFSET); }
u16 GET_SYMBOL_SEGMENT(u16 node) { return CSYM_W(node, CSYM_SEGMENT); }
void SET_SYMBOL_OFFSET(u16 node, u16 value) { CSYM_W(node, CSYM_OFFSET) = value; }
void SET_SYMBOL_SEGMENT(u16 node, u16 value) { CSYM_W(node, CSYM_SEGMENT) = value; }
void SET_SYMBOL_WORD_10(u16 node, u16 value) { CSYM_W(node, CSYM_VAR_ENTRY) = value; }
u16 GET_SYMBOL_KIND(u16 node) { return CSYM_B(node, CSYM_CLASS); }
u16 GET_SYMBOL_TYPE(u16 node) { return CSYM_W(node, CSYM_TYPE); }
u16 GET_SYMBOL_WORD_10(u16 node) { return CSYM_W(node, CSYM_VAR_ENTRY); }
u16 GET_STRING_LITERAL_SYMBOL(void) { return C_STRING_LITERAL_SYMBOL; }

void SET_SYMBOL_SEGMENT_FLAGGED(u16 node, u16 value)
{
    CSYM_W(node, CSYM_SEGMENT) = value;
    CSYM_W(node, CSYM_FLAGS) |= 0x1000;
}

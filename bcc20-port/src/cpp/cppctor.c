/* cppctor.c: from bcc20/src/cpp/CPPCTOR.C: the expression builders behind C++ object
   lifetime.  Nothing here parses; callers in CTORBODY.C, CPPINIT.C, CPPEXPCK.C, SPECMEMB.C,
   BASECONV.C and the statement parser ask for ready-made expression trees:
   - constructor and destructor calls (BUILD_CONSTRUCTOR_CALL, BUILD_DESTRUCTOR_CALL,
     BUILD_SPECIAL_MEMBER_CALL), including arrays through the vector delete helper;
   - the pieces of a constructor body: base, virtual-base and member initializers
     (BUILD_BASE_INITS, BUILD_VBASE_INITS, BUILD_MEMBER_INITS) and the stores of virtual
     table pointers (BUILD_VPTR_INITS); and of a destructor body (BUILD_DESTRUCTOR_BODY);
   - temporaries that need destroying: REGISTER_TEMP_DESTRUCTOR keeps a list of packed
     destructor calls with serial numbers, and BUILD_TEMP_DESTRUCTORS emits the calls
     between two points of that list;
   - base-class questions (IS_BASE_CLASS, IS_UNIQUE_BASE, COLLECT_VBASES) and lookups of
     the default constructor, copy constructor and copy assignment.
   Trees are built with token codes: 0Bh '=', 16h '+', 18h unary '*', 1Bh binary '&', 1Dh
   unary '&', 2Fh '.', 5 initialization, and MAKE_CONDITIONAL_NODE(6Bh or 20h, c, a, b) for
   c ? a : b.  TOKEN_NAMES[] doubles as the table of special member names: [5]
   constructors, [6] destructors, [0Bh] operator=, [72h] the this parameter, [73h] the
   hidden virtual table pointer member and the constructors' hidden virtual-base flag.  A
   class with virtual bases gets one more hidden int parameter in its constructors (0 for a
   complete object, 1 for a base subobject); destructors get a flag parameter too (bit 1
   call operator delete, bit 2 destroy virtual bases).  Base lists are 9-byte BASE records;
   the mem-initializer list is MINIT records. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "exprop.h"
#include "protos.h"
#include "calls.h"

#define E(n, o) EXPR_W((n), (o))
#define KIND(type) TYPE_W((type), TYPE_KIND)
#define KIND_FLAGS(type) EXPR_FLAGS_AT(KIND(type))
#define TAG(type) TYPE_W((type), TYPE_TAG_BODY)
#define CLASS_FLAGS(type) TAG_W(TAG(type), TAG_CLASS_FLAGS)
#define MODEL_FAR_CODE SB(MODEL_FAR_CODE_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define BASE_RECORD_SIZE 9

/* frees a whole list of BASE records (for example the copy made by COLLECT_VBASES) */
void FREE_PARAM_LIST(u16 node)
{
    while (node) {
        u16 cur = node;
        node = BASE_W(node, BASE_NEXT);
        POOL_FREE_ITEM(BASE_LIST_SEG_P, cur);
    }
}

/* 1 if the list of cells starting at node holds value (record 0 is the sentinel) */
u8 LIST_CONTAINS_VALUE(u16 value, u16 node)
{
    if (node == 0)
        return 0;
    CONS_W(0, CONS_VALUE) = value;
    while (CONS_W(node, CONS_VALUE) != value)
        node = CONS_W(node, CONS_NEXT);
    return node != 0;
}

/* called when a function without an ordinary body is used in a way that needs a real one:
   an inline function with a recorded body (inline kind 1) or a compiler-declared special
   member (kind 2).  The first time (SYM_FUNC_FLAGS bit 2 marks it queued) the symbol is
   pushed on PENDING_DEFINITION_LIST, which CPPFINAL.C drains at the end of the file.  With
   VTABLE_MODE 3, for near code or a far or flagged symbol, the function gets its own code
   segment named after its mangled name, numbered from OBJ_EXTERN_INDEX.  Nothing once code
   generation is off */
void QUEUE_DEFERRED_SYMBOL(u16 symbol)
{
    if (!NO_ERRORS_YET)
        return;
    if ((SYM_B(symbol, SYM_INLINE_ACCESS) & 3) != 1 && (SYM_B(symbol, SYM_INLINE_ACCESS) & 3) != 2)
        return;
    if (SYM_W(symbol, SYM_FUNC_FLAGS) & 2)
        return;
    if (VTABLE_MODE == 3 && (!MODEL_FAR_CODE || (SYM_B(symbol, SYM_FLAGS) & 0x90))) {
        u16 bits = DEFAULT_CODE_SEGMENT_ID;
        if (SYM_B(symbol, SYM_FLAGS) & 0x80)
            bits |= 0x8000;
        u16 id = (u16)(OBJ_EXTERN_INDEX + 0x4000);                     /* pascal: left to right */
        u16 name = DEFINE_SEGMENT_FIXED_ID(id, bits, 2, BCC_INTERN_STRING(MANGLE_SYMBOL_NAME(symbol)));
        u16 record = PREPARE_SYMBOL(symbol);
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(record), A16(name));
        CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(record), A16(OBJ_EXTERN_INDEX++));
        SET_PREPARED_FLAGS(record, 0x100);
    }
    SYM_W(symbol, SYM_FUNC_FLAGS) |= 2;
    PENDING_DEFINITION_LIST = LIST_CONS(PENDING_DEFINITION_LIST, symbol);
}

/* 1 when a value of type right cannot be converted to type left: not compatible directly,
   nor through a reference on either side, and no user conversion is found */
u8 CANNOT_CONVERT_TYPES(u16 right, u16 left)
{
    if (C7_TYPE_COMPAT(right, left, 0)
        || ((KIND_FLAGS(right) & 0x14) && (TYPE_B(right, TYPE_ATTRS) & 0x20) && C7_TYPE_COMPAT(TYPE_W(right, TYPE_TARGET), left, 0)))
        return 0;
    if ((KIND_FLAGS(left) & 0x14) && (TYPE_B(left, TYPE_ATTRS) & 0x20))
        left = TYPE_W(left, TYPE_TARGET);
    return FIND_USER_CONVERSION(right, left, 0, 0, 0) == 0;
}

/* the lvalue *(type *)((char *)&tree + offset), the subobject of class type that lies
   offset bytes into the object tree */
u16 BUILD_BASE_ADDRESS(u16 tree, i16 offset, u16 type)
{
    u16 pointer = MAKE_POINTER_TYPE(type, 0, 0);
    u16 base = MAKE_POINTER_TYPE(CHAR_TYPE, KIND(pointer), 0);
    u16 node = MAKE_CAST_NODE(base, MAKE_UNARY_NODE(0x1D, tree));
    node = MAKE_BINARY_NODE(0x16, node, MAKE_INT_CONSTANT(INT_TYPE, offset));
    return MAKE_UNARY_NODE(0x18, MAKE_CAST_NODE(pointer, node));
}

/* *(type **)((char *)&tree + offset), the virtual base pointer stored at offset inside the
   object tree */
u16 BUILD_VBASE_ADDRESS(u16 tree, i16 offset, u16 type)
{
    u16 node = MAKE_CAST_NODE(CHAR_POINTER_TYPE, MAKE_UNARY_NODE(0x1D, tree));
    node = MAKE_BINARY_NODE(0x16, node, MAKE_INT_CONSTANT(INT_TYPE, offset));
    u16 pointer = MAKE_POINTER_TYPE(type, 0, 0);
    return MAKE_UNARY_NODE(0x18, MAKE_CAST_NODE(MAKE_POINTER_TYPE(pointer, 0, 0), node));
}

/* tree.~type(flags) for one object.  Unless flags bit 2 is set, the destructor name is
   qualified by type, which makes the call non-virtual */
u16 BUILD_SINGLE_DTOR_CALL(u16 tree, u16 type, i16 flags)
{
    u16 count = MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE, flags), 0);
    u16 node = BUILD_SPECIAL_MEMBER_CALL(6, tree, count);
    if (!(flags & 2))
        E(E(E(node, EXPR_LEFT), EXPR_RIGHT), EXPR_RIGHT) = type;
    return node;
}

/* the call that destroys tree, an object of type (or an array of them; dim is an extra
   element count for new[]-style arrays, or 0).  0 (tree and dim freed) when the type has
   no destructor.  Arrays are flattened: the count multiplies the extents and a constant
   dim; one object uses BUILD_SINGLE_DTOR_CALL, more use the vector delete helper with
   (address, element size, count, mode, &destructor).  An error when the destructor is not
   accessible from CURRENT_CLASS_TYPE */
u16 BUILD_DESTRUCTOR_CALL(u16 tree, u16 type, u16 dim, i16 flags)
{
    u32 count = 1;
    u8 simple;
    if (!(TYPE_B(type, TYPE_ATTRS) & 8)) {
        FREE_EXPR_TREE(tree);
        FREE_EXPR_TREE(dim);
        return 0;
    }
    while (KIND(type) == TK_ARRAY) {
        count *= (u32)TYPE_L(type, TYPE_ARRAY_COUNT);
        tree = MAKE_UNARY_NODE(0x18, tree);
        type = TYPE_W(type, TYPE_TARGET);
    }
    if (IS_LINK_TIME_CONSTANT(dim) && dim) {
        dim = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(dim, INT_TYPE), 0);
        if (E(dim, EXPR_OP) == EOP_CONST) {
            count *= (u32)(i32)EXPR_I(dim, EXPR_VALUE);
            FREE_EXPR_NODE(dim);
            dim = 0;
        }
    }
    if (dim == 0) {
        if (!(simple = count == 1))
            dim = MAKE_INT_CONSTANT(INT_TYPE, (i32)count);
    } else {
        simple = 0;
        dim = MAKE_BINARY_NODE(0x18, dim, MAKE_INT_CONSTANT(INT_TYPE, (i32)count));
    }
    u16 member = FIND_MEMBER_BY_NAME(DTOR_NAME, type);
    if (!MEMBER_ACCESSIBLE(member, CURRENT_CLASS_TYPE)) {
        REPORT_DIAGNOSTIC_LINE(MSG_DESTRUCTOR_NOT, (i32)SYMBOL_NAME_TEXT(TAG_W(TAG(type), TAG_SYMBOL)), 0);
        FREE_EXPR_TREE(tree);
        return 0;
    }
    if (simple)
        return BUILD_SINGLE_DTOR_CALL(tree, type, flags);
    /* pascal: the arguments are built left to right */
    u16 function = MAKE_SYMBOL_NODE(VECTOR_DELETE_SYMBOL);
    u16 address = MAKE_CAST_NODE(FAR_VOID_PTR_TYPE, MAKE_UNARY_NODE(0x1D, tree));
    u16 size = MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(type));
    u16 mode = MAKE_INT_CONSTANT(INT_TYPE, (i16)(((flags & 1) << 3) | DESTRUCTOR_CALL_FLAGS(type, MEMBER_W(member, MEMB_VALUE))));
    u16 code = MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(MEMBER_W(member, MEMB_VALUE)));
    return MAKE_CALL_NODE(function, address, size, dim, mode, code);
}

/* comma list of destructor calls for the non-virtual bases and the data members of type
   that have destructors, given the object tree (copies are used and tree is freed).  Each
   new call is put in front, so members are destroyed in reverse order of declaration,
   then bases */
u16 BUILD_SUBOBJECT_DTORS(u16 tree, u16 type)
{
    u16 result = 0;
    for (u16 param = TAG_W(TAG(type), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
        if (!BASE_B(param, BASE_VIRTUAL) && (TYPE_B(BASE_W(param, BASE_TYPE), TYPE_ATTRS) & 8)) {
            u16 node = BUILD_SINGLE_DTOR_CALL(COPY_EXPR_TREE(tree), BASE_W(param, BASE_TYPE), 0);
            result = JOIN_COMMA_EXPR(node, result);
        }
    }
    for (u16 member = TAG_W(TAG(type), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0 && (TYPE_B(MEMBER_W(member, MEMB_TYPE), TYPE_ATTRS) & 8)) {
            u16 copy = COPY_EXPR_TREE(tree);                             /* pascal: left to right */
            u16 node = MAKE_BINARY_NODE(0x2F, copy, MAKE_FIELD_REF_NODE(member));
            result = JOIN_COMMA_EXPR(BUILD_DESTRUCTOR_CALL(node, MEMBER_W(member, MEMB_TYPE), 0, 2), result);
        }
    }
    FREE_EXPR_TREE(tree);
    return result;
}

/* a 6-byte temporary-destructor record; FREE_TEMP_ENTRY frees one */
u16 ALLOC_TEMP_ENTRY(void)
{
    return POOL_ALLOC_REUSE(TEMP_ENTRY_POOL_SEG_P, 6);
}

void FREE_TEMP_ENTRY(u16 node)
{
    POOL_FREE_ITEM(TEMP_ENTRY_POOL_SEG_P, node);
}

/* records that the object tree (a temporary or local of type) must be destroyed later:
   builds its destructor call, analyzes it (inside a function), packs it and links a new
   record in front of next, stamped with a new serial.  The new list head, or next
   unchanged when the type needs no destructor.  Warns when this happens inside a
   conditional, and stops the current inline function from being expanded inline */
u16 REGISTER_TEMP_DESTRUCTOR(u16 tree, u16 type, u16 next)
{
    u16 expr = BUILD_DESTRUCTOR_CALL(tree, type, 0, 2);
    if (!expr)
        return next;
    if (CONDITIONAL_ARM_DEPTH)
        REPORT_NAME_DIAGNOSTIC(MSG_DESTRUCTOR_REQUIRED, SYM_W(TAG_W(TAG(type), TAG_SYMBOL), SYM_NAME));
    if (INLINE_FUNCTION_STACK) {
        REPORT_DIAGNOSTIC(MSG_FUNCTIONS_CONTAINING, (i32)STR_LOCAL_DESTRUCTORS_P, 0);
        SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_FLAGS) &= ~4;
    }
    DESTRUCTOR_ENTRY_SERIAL++;
    u16 node = ALLOC_TEMP_ENTRY();
    TDTOR_W(node, TDTOR_NEXT) = next;
    TDTOR_W(node, TDTOR_SERIAL) = DESTRUCTOR_ENTRY_SERIAL;
    if (CURRENT_SCOPE != GLOBAL_SCOPE)
        expr = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expr, VOID_TYPE), 1);
    u16 packed = PACK_EXPR_TREE(expr);
    TDTOR_W(node, TDTOR_EXPR) = packed;
    FREE_EXPR_TREE(expr);
    return node;
}

/* comma expression of the destructor calls for every entry on the list from that is newer
   than the list position to, newest first; the result gets the current token's
   position */
u16 BUILD_TEMP_DESTRUCTORS(u16 from, u16 to)
{
    u16 result = 0;
    while (TDTOR_W(to, TDTOR_SERIAL) > TDTOR_W(from, TDTOR_SERIAL))
        to = TDTOR_W(to, TDTOR_NEXT);
    while (TDTOR_W(from, TDTOR_SERIAL) > TDTOR_W(to, TDTOR_SERIAL)) {
        result = JOIN_COMMA_EXPR(result, UNPACK_EXPR_TREE(TDTOR_W(from, TDTOR_EXPR)));
        from = TDTOR_W(from, TDTOR_NEXT);
    }
    if (result) {
        E(result, EXPR_SRC_FILE) = CURRENT_TOKEN_FILE;
        E(result, EXPR_SRC_LINE) = CURRENT_TOKEN_LINE;
        E(result, EXPR_SRC_WORD3) = CURRENT_TOKEN_LOC_WORD3;
    }
    return result;
}

/* mode bits for the vector helpers: 1 the destructor is a far function, 2 its calling
   convention byte is 2, 4 the class is far or huge, so object addresses are far */
i16 DESTRUCTOR_CALL_FLAGS(u16 type, u16 symbol)
{
    i16 flags = 0;
    if (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_FUNC_FLAGS) & 1)
        flags = 1;
    if (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_CALL_CONV) == 2)
        flags |= 2;
    if (CLASS_FLAGS(type) & 0x108)
        flags |= 4;
    return flags;
}

/* this = (type *)operator new(sizeof(type)), where symbol is the this parameter; the
   class's own operator new when it has one, else the global one */
u16 BUILD_THIS_ALLOCATION(u16 symbol, u16 type)
{
    u16 size = MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(type));
    u16 member = FIND_MEMBER_REPORT(OPERATOR_NEW_NAME, type), tree;
    if (member == 0)
        tree = MAKE_CALL_NODE(MAKE_SYMBOL_NODE(NEW_OPERATOR_SYMBOL), size, 0, 0, 0, 0);
    else {
        u16 node = MAKE_SYMBOL_NODE(MEMBER_W(member, MEMB_VALUE));
        E(node, EXPR_SCOPE_CLASS) = type;
        tree = MAKE_CALL_NODE(node, size, 0, 0, 0, 0);
    }
    tree = MAKE_CAST_NODE(MAKE_POINTER_TYPE(type, 0, 0), tree);
    return MAKE_BINARY_NODE(0x0B, BUILD_THIS_NODE(symbol), tree);
}

/* the start of a constructor: this ? 0 : (this = new ...), so a constructor called with a
   null this allocates its own object.  The allocation stores to CTOR_THIS_SYMBOL; the test
   reads symbol */
u16 BUILD_THIS_ALLOC_IF_NULL(u16 symbol, u16 type)
{
    u16 node = BUILD_THIS_ALLOCATION(CTOR_THIS_SYMBOL, type);
    u16 name = BUILD_THIS_NODE(symbol);
    return MAKE_CONDITIONAL_NODE(0x6B, name, MAKE_INT_CONSTANT(INT_TYPE, 0), node);
}

/* comma list of destructor calls for every virtual base of type that has a destructor,
   the object being the one this-parameter symbol points to */
u16 BUILD_VBASE_DTORS(u16 type, u16 symbol)
{
    u16 result = 0;
    u16 list = COLLECT_VBASES(type);
    for (u16 param = list; param; param = BASE_W(param, BASE_NEXT)) {
        if (TYPE_B(BASE_W(param, BASE_TYPE), TYPE_ATTRS) & 8) {
            u16 tree = BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(symbol), (i16)BASE_W(param, BASE_OFFSET), BASE_W(param, BASE_TYPE));
            result = JOIN_COMMA_EXPR(BUILD_DESTRUCTOR_CALL(tree, BASE_W(param, BASE_TYPE), 0, 0), result);
        }
    }
    FREE_PARAM_LIST(list);
    return result;
}

/* flags & bit, a test of the hidden flags parameter tree */
static u16 flag_test(u16 tree, i32 bit)
{
    u16 node = MAKE_SYMBOL_NODE(tree);
    return MAKE_BINARY_NODE(0x1B, node, MAKE_INT_CONSTANT(INT_TYPE, bit));
}

/* the code a destructor runs after its user body: destroy members and non-virtual bases,
   then, if (flags & 2), the virtual bases, then, if (flags & 1), free the object with
   operator delete (the class's own one, preferring the overload that also takes a size_t,
   or the global one).  tree is the symbol of the hidden flags parameter, symbol the this
   parameter.  When flag is set the whole thing is guarded by this != 0 */
u16 BUILD_DESTRUCTOR_BODY(u16 type, u16 symbol, u8 flag, u16 tree)
{
    u16 list = BUILD_SUBOBJECT_DTORS(MAKE_SYMBOL_NODE(symbol), type);
    u16 node = BUILD_VBASE_DTORS(type, symbol), init;
    if (node) {
        u16 test = flag_test(tree, 2);
        node = MAKE_CONDITIONAL_NODE(0x6B, test, node, MAKE_INT_CONSTANT(INT_TYPE, 0));
        list = JOIN_COMMA_EXPR(list, node);
    }
    u16 member = FIND_MEMBER_QUIET(OPERATOR_DELETE_NAME, type);
    if (member == 0) {
        u16 callee = MAKE_SYMBOL_NODE(DELETE_OPERATOR_SYMBOL);           /* pascal: left to right */
        init = MAKE_CALL_NODE(callee, BUILD_THIS_NODE(symbol), 0, 0, 0, 0);
    } else {
        u16 owner = MEMBER_W(member, MEMB_VALUE);
        if (SYM_W(owner, SYM_NEXT_OVERLOAD) && FORMAL_W(TYPE_W(SYM_W(owner, SYM_TYPE), TYPE_PARAMS), FORMAL_NEXT) == 0)
            owner = SYM_W(owner, SYM_NEXT_OVERLOAD);
        node = MAKE_SYMBOL_NODE(owner);
        E(node, EXPR_SCOPE_CLASS) = type;
        u16 object = BUILD_THIS_NODE(symbol);
        u16 size = FORMAL_W(TYPE_W(SYM_W(owner, SYM_TYPE), TYPE_PARAMS), FORMAL_NEXT) ? MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(type)) : 0;
        init = MAKE_CALL_NODE(node, object, size, 0, 0, 0);
    }
    u16 test = flag_test(tree, 1);
    u16 call = MAKE_CONDITIONAL_NODE(0x6B, test, init, MAKE_INT_CONSTANT(INT_TYPE, 0));
    list = JOIN_COMMA_EXPR(list, call);
    test = flag ? BUILD_THIS_NODE(symbol) : MAKE_INT_CONSTANT(INT_TYPE, 1);
    return MAKE_CONDITIONAL_NODE(0x6B, test, list, MAKE_INT_CONSTANT(INT_TYPE, 0));
}

/* a symbol node for the this parameter symbol, typed as a pointer to the class
   (const-qualified when the this type has attribute bit 1), with node flag 1 set */
u16 BUILD_THIS_NODE(u16 symbol)
{
    u16 node = MAKE_SYMBOL_NODE(symbol);
    u16 type = MAKE_POINTER_TYPE(TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_TARGET), KIND(SYM_W(symbol, SYM_TYPE)), 0);
    E(node, EXPR_TYPE) = type;
    if (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_ATTRS) & 1) {
        type = ADD_CV_QUALIFIERS(E(node, EXPR_TYPE), 0, 1);
        E(node, EXPR_TYPE) = type;
    }
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    return node;
}

/* the hidden virtual table pointer member of a class that has virtual functions or
   dynamically dispatched ones, searching the class and then down its first base class
   until found; 0 for a class without a table */
u16 BCC_MEMBER_LOOKUP(u16 type)
{
    u16 member = 0;
    if (TAG_W(TAG(type), TAG_VTABLE_SIZE) > 0 || (CLASS_FLAGS(type) & 0x800)) {
        while (!member) {
            member = FIND_MEMBER_BY_NAME(VTABLE_PTR_NAME, type);
            if (!member)
                type = BASE_W(TAG_W(TAG(type), TAG_BASES), BASE_TYPE);
        }
    }
    return member;
}

/* copies the 12-byte member record source into a new record, linked before next, with
   the access bits 2-4 replaced by kind and MEMB_VALUE replaced by type */
u16 COPY_MEMBER_RECORD(u16 source, u16 type, u16 next, u16 kind)
{
    u16 member = C9_ALLOC_MEMBER(0);
    for (int i = 0; i < 12; i += 2)
        MEMBER_W(member, i) = MEMBER_W(source, i);
    MEMBER_W(member, MEMB_NEXT) = next;
    MEMBER_B(member, MEMB_FLAGS) = (MEMBER_B(member, MEMB_FLAGS) & 0xE3) | ((kind & 7) << 2);
    MEMBER_W(member, MEMB_VALUE) = type;
    return member;
}

/* tree.NAME(value) where NAME is TOKEN_NAMES[op]: op 5 a constructor call, 6 a destructor
   call, others an ordinary member function; value is the argument list */
u16 BUILD_SPECIAL_MEMBER_CALL(u16 op, u16 tree, u16 value)
{
    u16 name = MAKE_BINARY_NODE(0x2F, tree, MAKE_MEMBER_NAME_NODE(TOKEN_NAMES_AT(op), op == 5 ? 3 : op == 6 ? 4 : 1));
    u16 node = MAKE_CALL_NODE(name, 0, 0, 0, 0, 0);
    E(node, EXPR_RIGHT) = value;
    return node;
}

/* tree.type(value) for a complete object: for a class with virtual bases the hidden first
   argument 0 is added */
u16 BUILD_CONSTRUCTOR_CALL(u16 tree, u16 type, u16 value)
{
    if (CLASS_FLAGS(type) & 4)
        value = MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE, 0), value);
    return BUILD_SPECIAL_MEMBER_CALL(5, tree, value);
}

/* the same for a base subobject: the hidden argument is 1 and the constructor name is
   qualified by type, so the base class's constructor is chosen */
u16 BUILD_BASE_CONSTRUCTOR_CALL(u16 tree, u16 type, u16 value)
{
    if (CLASS_FLAGS(type) & 4)
        value = MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE, 1), value);
    u16 node = BUILD_SPECIAL_MEMBER_CALL(5, tree, value);
    E(E(E(node, EXPR_LEFT), EXPR_RIGHT), EXPR_RIGHT) = type;
    return node;
}

/* initializes tree of type from the argument list node: a constructor call when force is
   set or the class has constructors (flag selects the base-subobject form); otherwise a
   plain initialization from the first argument, more than one argument, or none, being
   an error (the extra arguments are freed) */
u16 BUILD_INIT_CALL(u16 tree, u16 type, u16 node, u8 force, u8 flag)
{
    if (force || ((KIND_FLAGS(type) & 0x40) && (TYPE_B(type, TYPE_ATTRS) & 4)))
        return flag ? BUILD_BASE_CONSTRUCTOR_CALL(tree, type, node) : BUILD_CONSTRUCTOR_CALL(tree, type, node);
    if (!node)
        return REPORT_EXPR_ERROR_PLAIN(MSG_EXTERN_VARIABLE_CANNOT, tree);
    u16 result = MAKE_BINARY_NODE(5, tree, E(node, EXPR_RIGHT));
    u16 next = E(node, EXPR_LEFT);
    FREE_EXPR_NODE(node);
    if (next)
        REPORT_DIAGNOSTIC_AT(MSG_EXTERN_VARIABLE_CANNOT, 0, 0, E(E(next, EXPR_RIGHT), EXPR_SRC_LINE), 0);
    while (next) {
        FREE_EXPR_TREE(E(next, EXPR_RIGHT));
        node = next;
        next = E(next, EXPR_LEFT);
        FREE_EXPR_NODE(node);
    }
    return result;
}

/* counts how many times target occurs as a base class of type, searching the whole base
   graph.  A shared virtual base is counted once: when a path already found and the new one
   are both virtual, the count is not raised.  *ambiguous is set when the last path found
   goes through a virtual base */
void COUNT_BASE_PATHS(u16 target, u16 type, farptr ambiguous, farptr count)
{
    /* the original frame from BP-4: virt at 1, found at 2 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(4);
    farptr virt = fp_add(v, 1), found = fp_add(v, 2);
    W(count) = 0;
    B(ambiguous) = 0;
    for (u16 param = TAG_W(TAG(type), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
        if (TAG(BASE_W(param, BASE_TYPE)) == TAG(target)) {
            W(found) = 1;
            B(virt) = BASE_B(param, BASE_VIRTUAL);
        } else {
            COUNT_BASE_PATHS(target, BASE_W(param, BASE_TYPE), virt, found);
            if (W(found) > 0)
                B(virt) = B(virt) != 0 || BASE_B(param, BASE_VIRTUAL) != 0;
        }
        if (W(count) != 1 || W(found) != 1 || B(ambiguous) == 0 || B(virt) == 0) {
            W(count) += W(found);
            if (W(found) > 0)
                B(ambiguous) = B(virt);
        }
    }
    scratch_release(mark);
}

/* 1 if the first class is the same as the second or a base class of it (both must be class
   types; COUNT_BASE_PATHS(derived, base) counts derived among the bases of base, so
   "derived" is really the base class).  With strict, the base must also be unique and
   accessible: public through the derivation, or the current code is a friend of the first
   class; or else, when the current class is one of the two or a friend of the second, any
   access except 3 (inaccessible) */
u8 IS_BASE_CLASS(u16 derived, u16 base, u8 strict)
{
    if (!(KIND_FLAGS(base) & 0x40) || !(KIND_FLAGS(derived) & 0x40))
        return 0;
    if (TAG(base) == TAG(derived))
        return 1;
    /* the original frame from BP-6: virt at 3, count at 4 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    COUNT_BASE_PATHS(derived, base, fp_add(v, 3), fp_add(v, 4));
    u16 count = W(fp_add(v, 4));
    scratch_release(mark);
    if (!strict)
        return count > 0;
    if (count != 1)
        return 0;
    u16 access = (u16)ACCESS_MODE_VIA_BASES(0, 0, derived, base);
    if (IS_FRIEND(TAG_W(TAG(derived), TAG_SYMBOL)) || access == 0)
        return 1;
    if (TAG(CURRENT_CLASS_TYPE) == TAG(base) || TAG(CURRENT_CLASS_TYPE) == TAG(derived) || IS_FRIEND(TAG_W(TAG(base), TAG_SYMBOL)))
        return access != 3;
    return 0;
}

/* the number of paths to left among the bases of right, and whether the last goes through
   a virtual base (frame BP-4: ambiguous at 1, count at 2) */
static u16 unique_paths(u16 left, u16 right, u8 *ambiguous)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(4);
    COUNT_BASE_PATHS(left, right, fp_add(v, 1), fp_add(v, 2));
    *ambiguous = B(fp_add(v, 1));
    u16 count = W(fp_add(v, 2));
    scratch_release(mark);
    return count;
}

/* 1 if left is right or occurs exactly once among the bases of right, not through a
   virtual base; IS_UNIQUE_BASE allows a virtual path */
u8 IS_UNIQUE_NONVIRTUAL_BASE(u16 left, u16 right)
{
    if (!(KIND_FLAGS(right) & 0x40) || !(KIND_FLAGS(left) & 0x40))
        return 0;
    if (TAG(right) == TAG(left))
        return 1;
    u8 ambiguous;
    u16 count = unique_paths(left, right, &ambiguous);
    return count == 1 && !ambiguous;
}

u8 IS_UNIQUE_BASE(u16 left, u16 right)
{
    if (!(KIND_FLAGS(right) & 0x40) || !(KIND_FLAGS(left) & 0x40))
        return 0;
    if (TAG(right) == TAG(left))
        return 1;
    u8 ambiguous;
    return unique_paths(left, right, &ambiguous) == 1;
}

/* the constructor of type callable with no arguments: one with no parameters after this
   (and after the hidden virtual-base flag), or, unless any is set, one whose first
   parameter has a default.  The function symbol or 0 */
u16 FIND_DEFAULT_CTOR(u16 type, u8 any)
{
    u16 member = FIND_MEMBER_BY_NAME(CTOR_NAME, type);
    if (!member)
        return 0;
    for (u16 node = MEMBER_W(member, MEMB_VALUE); node; node = SYM_W(node, SYM_NEXT_OVERLOAD)) {
        u16 parameter = TYPE_W(SYM_W(node, SYM_TYPE), TYPE_PARAMS);
        if (CLASS_FLAGS(type) & 4)
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
        if (FORMAL_W(parameter, FORMAL_NEXT) == 0 || (FORMAL_W(FORMAL_W(parameter, FORMAL_NEXT), FORMAL_DEFAULT_ARG) && !any))
            return node;
    }
    return 0;
}

/* the copy constructor (kind 5) or copy assignment (kind 0Bh) of type: an overload whose
   first real parameter is compatible with a reference to type and that has no other
   parameter (or, unless any is set, only defaulted ones).  The function symbol or 0 */
u16 FIND_COPY_MEMBER(u16 kind, u16 type, u8 any)
{
    u16 pointer = MAKE_POINTER_TYPE(type, 0, 1);
    u16 member = FIND_MEMBER_BY_NAME(TOKEN_NAMES_AT(kind), type);
    if (!member)
        return 0;
    for (u16 node = MEMBER_W(member, MEMB_VALUE); node; node = SYM_W(node, SYM_NEXT_OVERLOAD)) {
        u16 parameter = TYPE_W(SYM_W(node, SYM_TYPE), TYPE_PARAMS);
        if (kind == 5 && (CLASS_FLAGS(type) & 4))
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
        parameter = FORMAL_W(parameter, FORMAL_NEXT);
        if (!parameter)
            continue;
        if (!TYPES_COMPATIBLE(FORMAL_W(parameter, FORMAL_TYPE), pointer, 2))
            continue;
        parameter = FORMAL_W(parameter, FORMAL_NEXT);
        if (!parameter || (FORMAL_W(parameter, FORMAL_DEFAULT_ARG) && !any))
            return node;
    }
    return 0;
}

u16 FIND_COPY_CTOR(u16 type, u8 any)
{
    return FIND_COPY_MEMBER(5, type, any);
}

u16 FIND_COPY_ASSIGN(u16 type, u8 any)
{
    return FIND_COPY_MEMBER(0x0B, type, any);
}

/* the cv attribute byte of what the copy constructor or copy assignment (kind) of type, or
   of its array element type, takes its argument by.  Assumes the member exists */
u16 COPY_PARAM_QUALIFIERS(u16 kind, u16 type)
{
    u8 indirect = 0;
    while (KIND(type) == TK_ARRAY) {
        indirect = 1;
        type = TYPE_W(type, TYPE_TARGET);
    }
    u16 member = FIND_COPY_MEMBER(kind, type, indirect);     /* called before the pool is read */
    u16 parameter = TYPE_W(SYM_W(member, SYM_TYPE), TYPE_PARAMS);
    parameter = FORMAL_W(parameter, FORMAL_NEXT);
    if (kind == 5 && (CLASS_FLAGS(type) & 4))
        parameter = FORMAL_W(parameter, FORMAL_NEXT);
    return TYPE_B(TYPE_W(FORMAL_W(parameter, FORMAL_TYPE), TYPE_TARGET), TYPE_ATTRS);
}

/* a new formal record named TOKEN_NAMES[kind] for a hidden parameter of class type.  With
   flags 0 its type is the class's this-pointer type; otherwise a pointer to type with cv
   qualifiers from flags (1 const, 2 volatile), built like the this type */
u16 CREATE_PARAM_RECORD(u16 type, u16 flags, u16 kind)
{
    u16 symbol = ALLOC_FORMAL_RECORD();
    FORMAL_W(symbol, FORMAL_NEXT) = 0;
    if (flags) {
        u16 pointer = ADD_CV_QUALIFIERS(type, (flags & 2) != 0, (u8)(flags & 1));
        pointer = MAKE_POINTER_TYPE(pointer, KIND(TAG_W(TAG(type), TAG_THIS_TYPE)), 1);
        TYPE_B(pointer, TYPE_ATTRS) |= TYPE_B(TAG_W(TAG(type), TAG_THIS_TYPE), TYPE_ATTRS) & 3;
        FORMAL_W(symbol, FORMAL_TYPE) = pointer;
    } else
        FORMAL_W(symbol, FORMAL_TYPE) = TAG_W(TAG(type), TAG_THIS_TYPE);
    FORMAL_W(symbol, FORMAL_NAME) = TOKEN_NAMES_AT(kind);
    FORMAL_B(symbol, FORMAL_IS_REGISTER) = 0;
    FORMAL_W(symbol, FORMAL_DEFAULT_ARG) = 0;
    return symbol;
}

/* puts the implicit this parameter in front of the parameter list of the member function
   type, qualified like the function, and records value as its member class */
void ADD_THIS_PARAMETER(u16 value, u16 type)
{
    u16 symbol = CREATE_PARAM_RECORD(value, TYPE_B(type, TYPE_ATTRS) & 3, 0x72);
    FORMAL_W(symbol, FORMAL_NEXT) = TYPE_W(type, TYPE_PARAMS);
    FORMAL_B(symbol, FORMAL_IMPLICIT) = 1;
    TYPE_W(type, TYPE_PARAMS) = symbol;
    TYPE_W(type, TYPE_MEMBER_CLASS) = value;
}

/* 1 if left (arrays decayed to pointers) and right are compatible types, also when one of
   them is a reference to a type compatible with the other */
u8 BCC_TYPE_PRED(u16 left, u16 right)
{
    if (KIND(left) == TK_ARRAY)
        left = MAKE_POINTER_TYPE(TYPE_W(left, TYPE_TARGET), 0, 0);
    u8 same = TYPES_COMPATIBLE(left, right, 0);
    if (!same) {
        if ((KIND_FLAGS(left) & 0x14) && (TYPE_B(left, TYPE_ATTRS) & 0x20))
            same = TYPES_COMPATIBLE(TYPE_W(left, TYPE_TARGET), right, 0);
        if (!same && (KIND_FLAGS(right) & 0x14) && (TYPE_B(right, TYPE_ATTRS) & 0x20))
            same = TYPES_COMPATIBLE(left, TYPE_W(right, TYPE_TARGET), 0);
    }
    return same;
}

/* 1 if two member function types take the same parameters after this, with the same
   ellipsis flag and the same const/volatile of this.  A function without a prototype
   (flag 8) matches anything */
u8 SAME_SIGNATURE(u16 left, u16 right)
{
    u8 same = 0;
    if ((TYPE_B(left, TYPE_FUNC_FLAGS) | TYPE_B(right, TYPE_FUNC_FLAGS)) & 8)
        same = 1;
    else if ((TYPE_B(left, TYPE_FUNC_FLAGS) & 4) == (TYPE_B(right, TYPE_FUNC_FLAGS) & 4) && (TYPE_B(left, TYPE_ATTRS) & 3) == (TYPE_B(right, TYPE_ATTRS) & 3)) {
        u16 a = FORMAL_W(TYPE_W(left, TYPE_PARAMS), FORMAL_NEXT);
        u16 b = FORMAL_W(TYPE_W(right, TYPE_PARAMS), FORMAL_NEXT);
        same = 1;
        while (a && b && same) {
            same = TYPES_COMPATIBLE(FORMAL_W(a, FORMAL_TYPE), FORMAL_W(b, FORMAL_TYPE), 0);
            a = FORMAL_W(a, FORMAL_NEXT);
            b = FORMAL_W(b, FORMAL_NEXT);
        }
        same = same && a == b;
    }
    return same;
}

/* appends the BASE records of list to head, freeing the ones whose class is already there.
   Each one added is placed right after the previous last entry: its offset is that entry's
   offset plus its TAG_OWN_SIZE */
u16 MERGE_VBASE_LIST(u16 head, u16 list)
{
    while (list) {
        u16 next = BASE_W(list, BASE_NEXT);
        if (!head) {
            head = list;
            BASE_W(list, BASE_NEXT) = 0;
            BASE_W(list, BASE_OFFSET) = 0;
        } else {
            u16 cur = head;
            while (BASE_W(cur, BASE_NEXT) && TAG(BASE_W(cur, BASE_TYPE)) != TAG(BASE_W(list, BASE_TYPE)))
                cur = BASE_W(cur, BASE_NEXT);
            if (TAG(BASE_W(cur, BASE_TYPE)) == TAG(BASE_W(list, BASE_TYPE)))
                POOL_FREE_ITEM(BASE_LIST_SEG_P, list);
            else {
                BASE_W(list, BASE_NEXT) = 0;
                BASE_W(list, BASE_OFFSET) = (u16)(BASE_W(cur, BASE_OFFSET) + TAG_W(TAG(BASE_W(cur, BASE_TYPE)), TAG_OWN_SIZE));
                BASE_W(cur, BASE_NEXT) = list;
            }
        }
        list = next;
    }
    return head;
}

/* the virtual bases of type, deepest first, each once (copies of the BASE records) */
u16 COLLECT_VBASES_REC(u16 type)
{
    u16 list = 0;
    if (CLASS_FLAGS(type) & 4) {
        for (u16 param = TAG_W(TAG(type), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
            list = MERGE_VBASE_LIST(list, COLLECT_VBASES_REC(BASE_W(param, BASE_TYPE)));
            if (BASE_B(param, BASE_VIRTUAL)) {
                u16 copy = POOL_ALLOC_REUSE(BASE_LIST_SEG_P, BASE_RECORD_SIZE);
                for (int i = 0; i < BASE_RECORD_SIZE; ++i)
                    BASE_B(copy, i) = BASE_B(param, i);
                BASE_W(copy, BASE_NEXT) = 0;
                list = MERGE_VBASE_LIST(list, copy);
            }
        }
    }
    return list;
}

/* the list of all virtual bases of type with their offsets in a complete object of type:
   they are laid out after its own part.  The caller frees the list with FREE_PARAM_LIST */
u16 COLLECT_VBASES(u16 type)
{
    u16 list = COLLECT_VBASES_REC(type);
    for (u16 param = list; param; param = BASE_W(param, BASE_NEXT))
        BASE_W(param, BASE_OFFSET) = (u16)(BASE_W(param, BASE_OFFSET) + TAG_W(TAG(type), TAG_OWN_SIZE));
    return list;
}

/* the entry of the mem-initializer list node whose target is key (a member record, or a
   base class type), or 0 */
u16 FIND_INIT_BY_MEMBER(u16 key, u16 node)
{
    while (node) {
        if (MINIT_W(node, MINIT_TARGET) == key)
            return node;
        node = MINIT_W(node, MINIT_NEXT);
    }
    return 0;
}

u16 FIND_INIT_BY_BASE(u16 key, u16 node)
{
    while (node) {
        if (MINIT_W(node, MINIT_TARGET) == key)
            return node;
        node = MINIT_W(node, MINIT_NEXT);
    }
    return 0;
}

/* this->member */
static u16 this_member(u16 member)
{
    u16 object = MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
    return MAKE_BINARY_NODE(0x2F, object, MAKE_FIELD_REF_NODE(member));
}

/* the member part of a constructor of CURRENT_CLASS_TYPE, in declaration order: each data
   member with an entry in the mem-initializer list keys uses that expression; a member of
   class type with constructors is default constructed (arrays element by element), or an
   error when it has no default constructor.  Reference and const members without an
   initializer are reported */
u16 BUILD_MEMBER_INITS(u16 keys)
{
    u16 result = 0;
    for (u16 member = TAG_W(TAG(CURRENT_CLASS_TYPE), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        if (MEMBER_B(member, MEMB_FLAGS) & 3)
            continue;
        u16 found = FIND_INIT_BY_MEMBER(member, keys);
        u16 type = MEMBER_W(member, MEMB_TYPE);
        if (found)
            result = JOIN_COMMA_EXPR(result, MINIT_W(found, MINIT_EXPR));
        else if (TYPE_B(type, TYPE_ATTRS) & 4) {
            if (KIND(type) == TK_ARRAY) {
                u16 expr = this_member(member);
                result = JOIN_COMMA_EXPR(result, INIT_VECTOR_ELEMENTS(expr, MEMBER_W(member, MEMB_TYPE)));
            } else if (FIND_DEFAULT_CTOR(type, 0)) {
                u16 expr = this_member(member);
                result = JOIN_COMMA_EXPR(result, BUILD_CONSTRUCTOR_CALL(expr, MEMBER_W(member, MEMB_TYPE), 0));
            } else {
                i32 constructor = FORMAT_SPECIAL_MEMBER(5, 0, type);    /* pascal: left to right */
                REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE_224, constructor, (i32)MEMBER_NAME_TEXT(member));
            }
        } else if ((KIND_FLAGS(type) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20))
            REPORT_NAME_DIAGNOSTIC(MSG_REFERENCE_MEMBER_NOT, MEMBER_W(member, MEMB_NAME));
        else if (TYPE_B(type, TYPE_ATTRS) & 1)
            REPORT_NAME_DIAGNOSTIC(MSG_CONSTANT_MEMBER_NOT, MEMBER_W(member, MEMB_NAME));
    }
    return result;
}

/* a new zeroed mem-initializer record linked in front of the list key */
u16 ALLOC_INIT_ENTRY(u16 key)
{
    u16 node = POOL_ALLOC_REUSE(INIT_RECORD_POOL_SEG_P, 6);
    RTL_MEMSET(MK_FP(INIT_RECORD_POOL_SEG, node), 0, 6);
    MINIT_W(node, MINIT_NEXT) = key;
    return node;
}

/* frees a whole mem-initializer list */
void FREE_INIT_LIST(u16 list)
{
    while (list) {
        u16 node = list;
        list = MINIT_W(list, MINIT_NEXT);
        POOL_FREE_ITEM(INIT_RECORD_POOL_SEG_P, node);
    }
}

/* the default construction of base or virtual base param of CURRENT_CLASS_TYPE, or an error
   (0 then); adjust stores the result of a base constructor that assigns to this back into
   this */
static u16 default_base_init(u16 param, u8 adjust, u8 *made)
{
    u16 symbol = FIND_DEFAULT_CTOR(BASE_W(param, BASE_TYPE), 0);
    *made = 0;
    if (symbol) {
        if (!SYMBOL_ACCESSIBLE(symbol, CURRENT_CLASS_TYPE)) {
            REPORT_DIAGNOSTIC(0xB6, (i32)FORMAT_SYMBOL(symbol), 0);
            return 0;
        }
        u16 expr = MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
        expr = BUILD_BASE_CONSTRUCTOR_CALL(expr, BASE_W(param, BASE_TYPE), 0);
        if (adjust && (SYM_W(symbol, SYM_FUNC_FLAGS) & 0x10)) {
            expr = MAKE_CAST_NODE(MAKE_POINTER_TYPE(CURRENT_CLASS_TYPE, 0, 0), expr);
            expr = MAKE_BINARY_NODE(0x0B, BUILD_THIS_NODE(CTOR_THIS_SYMBOL), expr);
        }
        *made = 1;
        return expr;
    }
    if (TYPE_B(BASE_W(param, BASE_TYPE), TYPE_ATTRS) & 4)
        REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE, FORMAT_SPECIAL_MEMBER(5, 0, BASE_W(param, BASE_TYPE)), 0);
    return 0;
}

/* the non-virtual base part of a constructor of CURRENT_CLASS_TYPE: each base uses its
   mem-initializer from keys, or its default constructor (access-checked), or is an error
   when it has constructors but no default one.  With adjust set (the class's constructors
   may assign to this) and a base constructor that assigns to this, its result is stored
   back into this.  Frees keys */
u16 BUILD_BASE_INITS(u8 adjust, u16 keys)
{
    u16 result = 0;
    for (u16 param = TAG_W(TAG(CURRENT_CLASS_TYPE), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
        if (BASE_B(param, BASE_VIRTUAL))
            continue;
        u16 found = FIND_INIT_BY_BASE(BASE_W(param, BASE_TYPE), keys);
        u8 made;
        if (found)
            result = JOIN_COMMA_EXPR(result, MINIT_W(found, MINIT_EXPR));
        else {
            u16 expr = default_base_init(param, adjust, &made);
            if (made)
                result = JOIN_COMMA_EXPR(result, expr);
        }
    }
    FREE_INIT_LIST(keys);
    return result;
}

/* stores of the virtual base pointer for the virtual base target in every subobject of
   type that derives virtually from it.  context is the this symbol, list the
   COLLECT_VBASES list, offset the position of type's subobject.  Each store is
   *(T **)((char *)this + offset + pointer offset) = &virtual base subobject */
u16 BUILD_VBASE_POINTER_INITS(u16 type, u16 context, u16 list, u16 offset, u16 target)
{
    u16 result = 0, base = 0;
    for (u16 param = TAG_W(TAG(type), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
        if (BASE_B(param, BASE_VIRTUAL) && TAG(BASE_W(param, BASE_TYPE)) == TAG(BASE_W(target, BASE_TYPE))) {
            u16 left = BUILD_VBASE_ADDRESS(MAKE_SYMBOL_NODE(context), (i16)(offset + BASE_W(param, BASE_OFFSET)), BASE_W(param, BASE_TYPE));
            u16 right = BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(context), (i16)BASE_W(target, BASE_OFFSET), BASE_W(target, BASE_TYPE));
            result = JOIN_COMMA_EXPR(result, MAKE_BINARY_NODE(5, left, MAKE_UNARY_NODE(0x1D, right)));
        }
        if (BASE_B(param, BASE_VIRTUAL)) {
            for (u16 cur = list;; cur = BASE_W(cur, BASE_NEXT))
                if (TAG(BASE_W(cur, BASE_TYPE)) == TAG(BASE_W(param, BASE_TYPE))) {
                    base = BASE_W(cur, BASE_OFFSET);
                    break;
                }
        } else
            base = (u16)(offset + BASE_W(param, BASE_OFFSET));
        u16 sub = BUILD_VBASE_POINTER_INITS(BASE_W(param, BASE_TYPE), context, list, base, target);
        result = JOIN_COMMA_EXPR(result, sub);
    }
    return result;
}

/* the virtual base part of a constructor: constructs each virtual base (from keys or by
   default constructor) and sets the virtual base pointers to it, the whole part guarded by
   the hidden flag parameter context: context ? 0 : (...).  Frees keys */
u16 BUILD_VBASE_INITS(u16 context, u16 keys)
{
    u16 result = 0;
    u16 list = COLLECT_VBASES(CURRENT_CLASS_TYPE);
    for (u16 param = list; param; param = BASE_W(param, BASE_NEXT)) {
        u16 found = FIND_INIT_BY_BASE(BASE_W(param, BASE_TYPE), keys);
        u8 made;
        if (found)
            result = JOIN_COMMA_EXPR(result, MINIT_W(found, MINIT_EXPR));
        else {
            u16 expr = default_base_init(param, 0, &made);
            if (made)
                result = JOIN_COMMA_EXPR(result, expr);
        }
        result = JOIN_COMMA_EXPR(BUILD_VBASE_POINTER_INITS(CURRENT_CLASS_TYPE, CTOR_THIS_SYMBOL, list, 0, param), result);
    }
    if (result) {
        u16 test = MAKE_SYMBOL_NODE(context);                           /* pascal: left to right */
        result = MAKE_CONDITIONAL_NODE(0x20, test, MAKE_INT_CONSTANT(INT_TYPE, 0), result);
    }
    FREE_PARAM_LIST(list);
    FREE_INIT_LIST(keys);
    return result;
}

/* stores of the virtual table pointer of type's subobject at offset in context, and
   recursively of its non-virtual bases.  Each class with a table gets
   vptr = &vtable_symbol[*size]; *size then moves past its entries, so the classes share
   one table symbol (scope) laid out in walk order.  nested skips a base whose pointer is
   shared with its derived class.  A class with dynamically dispatched functions has a
   header first that the pointer skips: per such function a far pointer and a short id,
   then a short count and a pointer the size of the vptr member */
u16 BUILD_VPTR_INITS_REC(u16 type, u16 context, u16 offset, u16 scope, farptr size, u8 nested)
{
    u16 result = 0;
    if ((TAG_W(TAG(type), TAG_VTABLE_SIZE) > 0 || (CLASS_FLAGS(type) & 0x800)) && !nested) {
        u16 base = TAG_W(TAG(type), TAG_VTABLE_SIZE);
        u16 member = BCC_MEMBER_LOOKUP(type);
        if (CLASS_FLAGS(type) & 0x800) {
            i16 entry = (i16)((i16)TYPE_SIZE(FAR_VOID_PTR_TYPE) + (i16)TYPE_SIZE(SHORT_TYPE));
            i16 tail = (i16)((i16)TYPE_SIZE(SHORT_TYPE) + (i16)TYPE_SIZE(MEMBER_W(member, MEMB_TYPE)));
            SW(size) = (i16)(entry * (i16)TAG_W(TAG(type), TAG_DDVT_COUNT) + tail + SW(size));
        }
        result = BUILD_BASE_ADDRESS(COPY_EXPR_TREE(context), (i16)offset, type);
        result = MAKE_BINARY_NODE(0x2F, result, MAKE_FIELD_REF_NODE(member));
        u16 table = MAKE_SYMBOL_NODE(scope);                            /* pascal: left to right */
        u16 expr = MAKE_UNARY_NODE(0x1D, MAKE_BINARY_NODE(3, table, MAKE_INT_CONSTANT(INT_TYPE, SW(size))));
        result = MAKE_BINARY_NODE(0x0B, result, expr);
        SW(size) = (i16)(SW(size) + (i16)base);
    }
    for (u16 param = TAG_W(TAG(type), TAG_BASES); param; param = BASE_W(param, BASE_NEXT)) {
        if (!BASE_B(param, BASE_VIRTUAL)) {
            u16 expr = BUILD_VPTR_INITS_REC(BASE_W(param, BASE_TYPE), context, (u16)(BASE_W(param, BASE_OFFSET) + offset), scope, size, BASE_B(param, BASE_USED));
            result = JOIN_COMMA_EXPR(result, expr);
        }
    }
    return result;
}

/* all virtual table pointer stores for a constructor of type whose this symbol is context:
   the class and its non-virtual bases, then each virtual base (reached with
   CONVERT_DERIVED_TO_BASE), all into the class's table symbol */
u16 BUILD_VPTR_INITS(u16 context, u16 type)
{
    u16 scope = TAG_W(TAG(type), TAG_VTABLE_SYMBOL);
    /* the original frame from BP-0Ch: size */
    u16 frame = scratch_mark();
    farptr size = scratch_alloc(0x0C);
    SW(size) = 0;
    u16 mark = MAKE_SYMBOL_NODE(context);
    u16 result = BUILD_VPTR_INITS_REC(type, mark, 0, scope, size, 0);
    if (CLASS_FLAGS(type) & 4) {
        u16 param = COLLECT_VBASES(type);
        u16 sum = 0;
        FREE_EXPR_NODE(mark);
        mark = BUILD_THIS_NODE(context);
        while (param) {
            u16 expr = CONVERT_DERIVED_TO_BASE(COPY_EXPR_TREE(mark), type, 0, BASE_W(param, BASE_TYPE), 1, 0);
            expr = BUILD_VPTR_INITS_REC(BASE_W(param, BASE_TYPE), expr, 0, scope, size, 0);
            sum = JOIN_COMMA_EXPR(sum, expr);
            u16 old = param;
            param = BASE_W(param, BASE_NEXT);
            POOL_FREE_ITEM(BASE_LIST_SEG_P, old);
        }
        result = JOIN_COMMA_EXPR(result, sum);
    }
    FREE_EXPR_NODE(mark);
    scratch_release(frame);
    return result;
}

/* adds a copy of item (a BASE record passed by value: its five words, last first) to the
   BASE list *list unless a base of the same class is already in it; *found says which
   happened.  Used by CLASSDEF.C for the base-specifier list */
void ADD_UNIQUE_PARAM(farptr list, u8 used, u16 access, u16 offset, u16 type, u16 next, farptr found)
{
    u16 param = W(list);
    BASE_W(0, BASE_TYPE) = type;
    while (TAG(BASE_W(param, BASE_TYPE)) != TAG(type))
        param = BASE_W(param, BASE_NEXT);
    if (param)
        B(found) = 1;
    else {
        param = POOL_ALLOC_REUSE(BASE_LIST_SEG_P, BASE_RECORD_SIZE);
        BASE_W(param, BASE_NEXT) = next;
        BASE_W(param, BASE_TYPE) = type;
        BASE_W(param, BASE_OFFSET) = offset;
        BASE_W(param, BASE_PUBLIC) = access;
        BASE_B(param, BASE_USED) = (u8)used;
        BASE_W(param, BASE_NEXT) = W(list);
        W(list) = param;
        B(found) = 0;
    }
}

/* frees one BASE record */
void FREE_PARAM_ITEM(u16 param)
{
    POOL_FREE_ITEM(BASE_LIST_SEG_P, param);
}

/* puts a compiler-added int parameter named TOKEN_NAMES[kind] in front of the parameter
   list of function type type: 73h for the virtual-base flag of constructors, 69h for the
   flags of destructors */
void ADD_HIDDEN_PARAMETER(u16 type, u16 kind)
{
    u16 symbol = ALLOC_FORMAL_RECORD();
    FORMAL_W(symbol, FORMAL_TYPE) = INT_TYPE;
    FORMAL_W(symbol, FORMAL_NAME) = TOKEN_NAMES_AT(kind);
    FORMAL_B(symbol, FORMAL_IS_REGISTER) = 0;
    FORMAL_W(symbol, FORMAL_DEFAULT_ARG) = 0;
    FORMAL_W(symbol, FORMAL_NEXT) = TYPE_W(type, TYPE_PARAMS);
    FORMAL_B(symbol, FORMAL_IMPLICIT) = 1;
    TYPE_W(type, TYPE_PARAMS) = symbol;
}

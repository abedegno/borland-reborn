/* specmemb.c: from bcc20/src/cpp/SPECMEMB.C: the bodies of the special members the compiler
   declares for a class (IMPLMEMB.C declares them; CPPFINAL.C compiles them when needed).
   BUILD_SPECIAL_MEMBER_BODY returns, by SYM_SPECIAL_KIND, the expression forming the whole
   body: 0 operator= (assign each base and data member from the argument, by its own
   operator= where it has one, arrays of such classes element by element); 1 copy
   constructor (virtual bases, bases and members initialised from the argument's, then the
   virtual table pointers); 2 default constructor (virtual bases, bases, members default
   constructed, then the virtual table pointers); 3 destructor (BUILD_DESTRUCTOR_BODY).  The
   parameters are found by name in the current scope: this first, then the virtual-base flag
   of a constructor of a class with virtual bases, then the argument.  Constructors and the
   assignment end in &this.  INIT_VECTOR_ELEMENTS builds the run-time call that default
   constructs every element of an array.  Kept: for an array member CHECK_MEMBER_CLASS_
   CALLABLE fails even when the element's member is found, so an implicit copy of a class
   with such an array member fails. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

/* the parameter named by FORMAL record formal, in the current scope */
static u16 parameter_symbol(u16 formal)
{
    return FIND_NAME_IN_LIST(FORMAL_W(formal, FORMAL_NAME), SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
}

/* for a base or member of type node that needs a constructor: query (FIND_COPY_CTOR or
   FIND_COPY_ASSIGN, a code address) must find an accessible member; mode (5 or 11) names it
   in the report.  1 when all is well; for an array 0 always (see the file comment) */
u8 CHECK_MEMBER_CLASS_CALLABLE(u16 node, u16 mode, farptr query)
{
    if (!(TYPE_B(node, TYPE_ATTRS) & 4))
        return 1;
    if (TYPE_W(node, TYPE_KIND) == TK_ARRAY) {
        while (TYPE_W(node, TYPE_KIND) == TK_ARRAY)
            node = TYPE_W(node, TYPE_TARGET);
        u16 result = (u16)CALL_FAR(query, A16(node), A16(1));
        if (!result)
            REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_COPY, FORMAT_SPECIAL_MEMBER(mode, 1, node), 0);
        return 0;
    }
    u16 result = (u16)CALL_FAR(query, A16(node), A16(0));
    if (result == 0)
        return 1;
    if (!SYMBOL_ACCESSIBLE(result, CURRENT_CLASS_TYPE)) {
        REPORT_DIAGNOSTIC(0xB6, (i32)FORMAT_SYMBOL(result), 0);
        return 0;
    }
    return 1;
}

/* CHECK_MEMBER_CLASS_CALLABLE over every base and data member of class node */
static u8 check_members(u16 node, u16 mode, const char *query)
{
    u8 result = 1;
    farptr code = code_address(query);
    for (u16 di = TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_BASES); di != 0; di = BASE_W(di, BASE_NEXT))
        result = result & CHECK_MEMBER_CLASS_CALLABLE(BASE_W(di, BASE_TYPE), mode, code);
    for (u16 si = TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_MEMBERS); si != 0; si = MEMBER_W(si, MEMB_NEXT))
        if (!(MEMBER_B(si, MEMB_FLAGS) & 3))
            result = result & CHECK_MEMBER_CLASS_CALLABLE(MEMBER_W(si, MEMB_TYPE), mode, code);
    return result;
}

/* 1 when the implicit copy constructor of class node can be built */
u8 CHECK_COPY_CTOR_MEMBERS(u16 node) { return check_members(node, 5, "FIND_COPY_CTOR"); }

/* 1 when the implicit operator= of class node can be built */
u8 CHECK_ASSIGN_MEMBERS(u16 node) { return check_members(node, 11, "FIND_COPY_ASSIGN"); }

/* second.member, where second is a symbol (a parameter) and first a member record */
u16 MAKE_MEMBER_ACCESS(u16 first, u16 second)
{
    u16 object = MAKE_SYMBOL_NODE(second);
    u16 field = MAKE_FIELD_REF_NODE(first);
    return MAKE_BINARY_NODE(0x2F, object, field);
}

/* the element count of an array type (nested arrays counted as one) and its element type */
static i32 element_count(u16 *type)
{
    i32 product = 1;
    while (TYPE_W(*type, TYPE_KIND) == TK_ARRAY) {
        product = (i32)((u32)product * (u32)TYPE_L(*type, TYPE_PARAMS));
        *type = TYPE_W(*type, TYPE_TARGET);
    }
    return product;
}

/* the call that default constructs all elements of array value of type: VECTOR_NEW_SYMBOL
   (VECTOR_VNEW_SYMBOL for a class with virtual bases) with (address, element size, count,
   mode, &constructor), where the constructor takes no argument besides this and the hidden
   flag.  A class without one is an error */
u16 INIT_VECTOR_ELEMENTS(u16 value, u16 type)
{
    i32 product = element_count(&type);
    u8 flag = (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4) != 0;
    u16 member = FIND_MEMBER_BY_NAME(CTOR_NAME, type);
    u16 entry = member == 0 ? 0 : MEMBER_W(member, MEMB_VALUE);
    while (entry) {
        u16 field = TYPE_W(SYM_W(entry, SYM_TYPE), TYPE_PARAMS);
        if (flag)
            field = FORMAL_W(field, FORMAL_NEXT);
        if (FORMAL_W(field, FORMAL_NEXT) == 0)
            break;
        entry = SYM_W(entry, SYM_NEXT_OVERLOAD);
    }
    if (entry == 0)
        return REPORT_EXPR_ERROR(MSG_CANNOT_FIND_INITIALIZE_225, (farptr)FORMAT_SPECIAL_MEMBER(5, 0, type), 0, 0);
    /* pascal: the arguments are built left to right */
    u16 function = MAKE_SYMBOL_NODE(flag ? VECTOR_VNEW_SYMBOL : VECTOR_NEW_SYMBOL);
    u16 address = MAKE_CAST_NODE(FAR_VOID_PTR_TYPE, MAKE_UNARY_NODE(0x1D, value));
    u16 size = MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(type));
    u16 count = MAKE_INT_CONSTANT(INT_TYPE, product);
    u16 mode = MAKE_INT_CONSTANT(INT_TYPE, DESTRUCTOR_CALL_FLAGS(type, entry));
    u16 code = MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(entry));
    return MAKE_CALL_NODE(function, address, size, count, mode, code);
}

/* copies array second into array first element by element, with the element class's copy
   constructor (mode 5) or operator= (mode 11), the overload taking a reference to the
   class.  The node built has EXPR_LEFT (void far *)&first and the argument list
   VECTOR_APPLY_SYMBOL (VECTOR_VAPPLY_SYMBOL for a copy constructor of a class with virtual
   bases), &second, element size, count, mode, &function */
u16 COPY_VECTOR_ELEMENTS(u16 mode, u16 first, u16 second, u16 type)
{
    i32 product = element_count(&type);
    u8 flag = (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4) && mode == 5;
    u16 member = FIND_MEMBER_BY_NAME(TOKEN_NAMES_AT(mode), type);
    u16 node;
    for (node = MEMBER_W(member, MEMB_VALUE); node; node = SYM_W(node, SYM_NEXT_OVERLOAD)) {
        u16 entry = SYM_W(node, SYM_TYPE);
        u16 field = FORMAL_W(TYPE_W(entry, TYPE_PARAMS), FORMAL_NEXT);
        if (flag)
            field = FORMAL_W(field, FORMAL_NEXT);
        u16 child = FORMAL_W(field, FORMAL_TYPE);
        if ((EXPR_FLAGS_AT(TYPE_W(child, TYPE_KIND)) & 0x14) && (TYPE_B(child, TYPE_ATTRS) & 0x20) &&
            FORMAL_W(field, FORMAL_NEXT) == 0 && TYPES_COMPATIBLE(TYPE_W(child, TYPE_TARGET), type, 2))
            break;
    }
    if (node == 0)
        return REPORT_EXPR_ERROR(MSG_CANNOT_FIND_COPY, (farptr)FORMAT_SPECIAL_MEMBER(mode, 1, type), 0, 0);
    u16 to = MAKE_CAST_NODE(FAR_VOID_PTR_TYPE, MAKE_UNARY_NODE(0x1D, first));
    u16 from = MAKE_CAST_NODE(FAR_VOID_PTR_TYPE, MAKE_UNARY_NODE(0x1D, second));
    u16 size = MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(type));
    u16 count = MAKE_INT_CONSTANT(INT_TYPE, product);
    u16 flags = MAKE_INT_CONSTANT(INT_TYPE, DESTRUCTOR_CALL_FLAGS(type, node));
    u16 code = MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(node));
    u16 result = MAKE_CALL_NODE(to, from, size, count, flags, code);
    u16 helper = MAKE_SYMBOL_NODE(flag ? VECTOR_VAPPLY_SYMBOL : VECTOR_APPLY_SYMBOL);
    u16 list = MAKE_LIST_NODE(helper, EXPR_W(result, EXPR_RIGHT));
    EXPR_W(result, EXPR_RIGHT) = list;
    return result;
}

/* the address of base base of the object symbol */
static u16 base_address(u16 symbol, u16 base)
{
    u16 object = MAKE_SYMBOL_NODE(symbol);
    if (BASE_B(base, BASE_VIRTUAL))
        return MAKE_UNARY_NODE(0x18, BUILD_VBASE_ADDRESS(object, BASE_W(base, BASE_OFFSET), BASE_W(base, BASE_TYPE)));
    return BUILD_BASE_ADDRESS(object, BASE_W(base, BASE_OFFSET), BASE_W(base, BASE_TYPE));
}

/* one assignment of the implicit operator=: by the class's own operator= (TYPE_ATTRS 10h)
   into *sum2, else a plain assignment into *sum */
static void assign_part(u16 type, u16 left, u16 right, u16 *sum, u16 *sum2)
{
    if (TYPE_B(type, TYPE_ATTRS) & 0x10)
        *sum2 = JOIN_COMMA_EXPR(*sum2, BUILD_SPECIAL_MEMBER_CALL(0x0B, left, MAKE_LIST_NODE(right, 0)));
    else
        *sum = JOIN_COMMA_EXPR(*sum, MAKE_BINARY_NODE(0x0B, left, right));
}

/* the body of the implicit operator= of class type, context being its function type: b is
   this, a the argument.  Bases (virtual ones through their virtual base pointers) and data
   members are assigned; plain assignments are collected in sum and operator= calls in sum2,
   which run after them.  A member array without operator= is copied whole (token 5).
   Members flagged with exactly one of MEMB_FLAGS 20h and 80h are skipped */
u16 BUILD_ASSIGN_BODY(u16 type, u16 context)
{
    u8 mask = 0xA0;
    u16 field = TYPE_W(context, TYPE_PARAMS);
    u16 b = parameter_symbol(field);
    u16 a = parameter_symbol(FORMAL_W(field, FORMAL_NEXT));
    u16 sum = 0, sum2 = 0;
    for (u16 si = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_BASES); si; si = BASE_W(si, BASE_NEXT)) {
        u16 left = base_address(b, si);
        u16 right = base_address(a, si);
        assign_part(BASE_W(si, BASE_TYPE), left, right, &sum, &sum2);
    }
    for (u16 di = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS); di; di = MEMBER_W(di, MEMB_NEXT)) {
        if (MEMBER_B(di, MEMB_FLAGS) & 3)
            continue;
        if ((MEMBER_B(di, MEMB_FLAGS) & mask) && (MEMBER_B(di, MEMB_FLAGS) & mask) != mask)
            continue;
        u16 left = MAKE_MEMBER_ACCESS(di, b);
        u16 right = MAKE_MEMBER_ACCESS(di, a);
        u16 member_type = MEMBER_W(di, MEMB_TYPE);
        if (TYPE_W(member_type, TYPE_KIND) == 17) {
            if (TYPE_B(member_type, TYPE_ATTRS) & 0x10)
                sum2 = JOIN_COMMA_EXPR(sum2, COPY_VECTOR_ELEMENTS(0x0B, left, right, MEMBER_W(di, MEMB_TYPE)));
            else
                sum = JOIN_COMMA_EXPR(sum, MAKE_BINARY_NODE(5, left, right));
        } else
            assign_part(member_type, left, right, &sum, &sum2);
    }
    u16 body = JOIN_COMMA_EXPR(sum, sum2);
    return JOIN_COMMA_EXPR(body, MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(b)));
}

/* the body of the implicit copy constructor of class input, types being its function
   type.  first is this, extra the virtual-base flag (classes with virtual bases only) and
   second the argument.  Virtual bases are built by default, non-virtual bases and members
   initialised from the argument's (arrays of classes with constructors through
   COPY_VECTOR_ELEMENTS), members flagged 20h or 80h skipped; then the vptr stores */
u16 BUILD_COPY_CTOR_BODY(u16 input, u16 types)
{
    u16 cursor = TYPE_W(types, TYPE_PARAMS);
    u16 first = parameter_symbol(cursor);
    cursor = FORMAL_W(cursor, FORMAL_NEXT);
    u16 second = parameter_symbol(cursor), extra;
    if (TAG_W(TYPE_W(input, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4) {
        extra = second;
        second = parameter_symbol(FORMAL_W(cursor, FORMAL_NEXT));
    } else
        extra = 0;
    u16 di = BUILD_VBASE_INITS(extra, 0);
    for (u16 si = TAG_W(TYPE_W(input, TYPE_TAG_BODY), TAG_BASES); si != 0; si = BASE_W(si, BASE_NEXT)) {
        if (BASE_B(si, BASE_VIRTUAL))
            continue;
        u16 left;
        if (TYPE_B(BASE_W(si, BASE_TYPE), TYPE_ATTRS) & 4)
            left = MAKE_SYMBOL_NODE(first);
        else
            left = BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(first), BASE_W(si, BASE_OFFSET), BASE_W(si, BASE_TYPE));
        u16 right = BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(second), BASE_W(si, BASE_OFFSET), BASE_W(si, BASE_TYPE));
        u16 list = MAKE_LIST_NODE(right, 0);
        u16 node = BUILD_INIT_CALL(left, BASE_W(si, BASE_TYPE), list, 0, 1);
        di = JOIN_COMMA_EXPR(di, node);
    }
    for (u16 member = TAG_W(TYPE_W(input, TYPE_TAG_BODY), TAG_MEMBERS); member != 0; member = MEMBER_W(member, MEMB_NEXT)) {
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) || (MEMBER_B(member, MEMB_FLAGS) & 0xA0))
            continue;
        u16 left = MAKE_MEMBER_ACCESS(member, first);
        u16 right = MAKE_MEMBER_ACCESS(member, second);
        u16 child = MEMBER_W(member, MEMB_TYPE);
        if ((TYPE_B(child, TYPE_ATTRS) & 4) && TYPE_W(child, TYPE_KIND) == 17)
            di = JOIN_COMMA_EXPR(di, COPY_VECTOR_ELEMENTS(5, left, right, child));
        else
            di = JOIN_COMMA_EXPR(di, BUILD_INIT_CALL(left, child, MAKE_LIST_NODE(right, 0), 0, 0));
    }
    di = JOIN_COMMA_EXPR(di, BUILD_VPTR_INITS(first, input));
    return JOIN_COMMA_EXPR(di, MAKE_UNARY_NODE(29, MAKE_SYMBOL_NODE(first)));
}

/* the body of the implicit default constructor of class node: virtual bases (guarded by
   the flag parameter second; BUILD_VBASE_INITS adds the same guard, so it is tested twice),
   bases and members by their default constructors, then the vptr stores */
u16 BUILD_DEFAULT_CTOR_BODY(u16 node, u16 other)
{
    u16 link = TYPE_W(other, TYPE_PARAMS);
    u16 first = parameter_symbol(link), second;
    if (TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4)
        second = parameter_symbol(FORMAL_W(link, FORMAL_NEXT));
    else
        second = 0;
    u16 result = BUILD_VBASE_INITS(second, 0);
    if (result) {
        u16 test = MAKE_SYMBOL_NODE(second);
        u16 zero = MAKE_INT_CONSTANT(INT_TYPE, 0);
        result = MAKE_CONDITIONAL_NODE(0x6B, test, zero, result);
    }
    result = JOIN_COMMA_EXPR(result, BUILD_BASE_INITS(0, 0));
    result = JOIN_COMMA_EXPR(result, BUILD_MEMBER_INITS(0));
    result = JOIN_COMMA_EXPR(result, BUILD_VPTR_INITS(first, node));
    return JOIN_COMMA_EXPR(result, MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(first)));
}

/* the body of the implicit destructor of class first: BUILD_DESTRUCTOR_BODY with this and
   the flags parameter, guarded by this != 0 */
u16 BUILD_IMPLICIT_DESTRUCTOR(u16 first, u16 second)
{
    u16 node = TYPE_W(second, TYPE_PARAMS);
    u16 value1 = parameter_symbol(node);
    u16 value2 = parameter_symbol(FORMAL_W(node, FORMAL_NEXT));
    return BUILD_DESTRUCTOR_BODY(first, value1, 1, value2);
}

/* the body expression of implicit special member node.  When a needed base or member
   function is missing or inaccessible the error has been reported and an error node is
   returned */
u16 BUILD_SPECIAL_MEMBER_BODY(u16 node)
{
    u16 type = SYM_W(SYM_W(node, SYM_OWNER_CLASS), SYM_TYPE);
    switch (SYM_W(node, SYM_SPECIAL_KIND)) {
    case 0:
        return CHECK_ASSIGN_MEMBERS(type) ? BUILD_ASSIGN_BODY(type, SYM_W(node, SYM_TYPE)) : REPORT_EXPR_ERROR_PLAIN(0, 0);
    case 1:
        return CHECK_COPY_CTOR_MEMBERS(type) ? BUILD_COPY_CTOR_BODY(type, SYM_W(node, SYM_TYPE)) : REPORT_EXPR_ERROR_PLAIN(0, 0);
    case 2:
        return BUILD_DEFAULT_CTOR_BODY(type, SYM_W(node, SYM_TYPE));
    case 3:
        return BUILD_IMPLICIT_DESTRUCTOR(type, SYM_W(node, SYM_TYPE));
    }
    return 0;
}

/* exprchk.c: from bcc20/src/expr/EXPRCHK.C: the checkers for binary operators,
   assignments, initialisation, return values, subscripts and member selection.
   ANALYZE_EXPRESSION calls the CHECK_* function for a node; it analyses both operands,
   converts them, sets the node's type and returns the node, a rewritten tree or an error
   node (message 0: already reported).  PREPARE_BINARY_OPERANDS is the common first step.
   Its parameters, and those of the checkers that pass them on: mode is
   ANALYZE_EXPRESSION's context passed through, scope (type, kind) the wanted result type,
   mask (hint) the EXPR_FLAGS mask of operand types the operator takes (1 integral, 3
   arithmetic, 7 scalar, 17h scalar or pointer).  Pointer arithmetic is made explicit: p + i
   becomes p + i * sizeof(*p), p - q (p - q) / sizeof(*p), a[i] *(a + i); operator 2Dh adds
   an offset to a _seg pointer, giving a far pointer.  In C++ each checker first tries a
   user-defined operator and the conversion functions of class operands, and assignment,
   initialisation and return go to their C++ versions. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"

#define OP(n) EXPR_W((n), EXPR_OP)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define TYPE_OF(n) EXPR_W((n), EXPR_TYPE)
#define KIND_OF(n) TYPE_W(TYPE_OF(n), TYPE_KIND)
#define FLAGS(t) EXPR_FLAGS_AT(TYPE_W((t), TYPE_KIND))
#define FLAGS_OF(n) FLAGS(TYPE_OF(n))
#define TK(t) TYPE_I((t), 0)
#define BCC_TYPE(i) W(fp_add(D(BCC_TYPE_PTR_P), (i) * 2))

/* the functions that take the address of the caller's node variable get a slot in the
   scratch area for it */
static u8 prepare(u16 *node, u16 mode, u16 scope, u16 mask)
{
    u16 mark = scratch_mark();
    farptr p = scratch_alloc(2);
    W(p) = *node;
    u8 replaced = PREPARE_BINARY_OPERANDS(p, mode, scope, mask);
    *node = W(p);
    scratch_release(mark);
    return replaced;
}

static u8 elide(u16 *node)
{
    u16 mark = scratch_mark();
    farptr p = scratch_alloc(2);
    W(p) = *node;
    u8 done = ELIDE_COPY_ASSIGN(p);
    *node = W(p);
    scratch_release(mark);
    return done;
}

static u8 binary_operator(u16 *node, u16 mask, u16 mode)
{
    u16 mark = scratch_mark();
    farptr p = scratch_alloc(2);
    W(p) = *node;
    u8 called = TRY_BINARY_OPERATOR_CALL(p, mask, mode);
    *node = W(p);
    scratch_release(mark);
    return called;
}

/* the "cannot assign" family of errors, with both types' names */
static u16 type_error(u16 message, u16 first, u16 second, u16 node)
{
    i32 one = FORMAT_TYPE(first);
    i32 two = FORMAT_TYPE(second);
    return REPORT_EXPR_ERROR(message, (farptr)one, two, node);
}

/* node <token kind> value (value an int constant of type other), for example 18h (*) for
   i * size and 19h (probably /) for a pointer difference, with node's source position,
   converted to other */
u16 SCALE_BY_ELEMENT_SIZE(u16 kind, i32 value, u16 node, u16 other)
{
    u16 result = MAKE_BINARY_NODE(kind, node, MAKE_INT_CONSTANT(other, value));
    for (int i = 0; i < 6; i++)
        EXPR_B(result, 0x14 + i) = EXPR_B(node, 0x14 + i);
    for (int i = 0; i < 6; i++)
        EXPR_B(RIGHT(result), 0x14 + i) = EXPR_B(result, 0x14 + i);
    result = CONVERT_EXPR_TO_TYPE(other, USUAL_ARITHMETIC_CONVERSIONS(other, result), 0);
    EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
    return result;
}

/* the error for an operand outside the mask: "illegal use of pointer" (19), "illegal use
   of floating point" (47), else message 106 */
static void report_kind(u16 node, u16 kind)
{
    i16 code = (EXPR_FLAGS_AT(kind) & 0x14) ? 0x13 : (EXPR_FLAGS_AT(kind) & 2) ? 0x2F : 0x6A;
    REPORT_DIAGNOSTIC_AT(code, 0, 0, EXPR_W(node, EXPR_SRC_LINE), 0);
}

/* 1 when both operand types are in the mask; else each bad operand is reported */
u8 CHECK_OPERAND_KINDS(u16 node, u16 mask)
{
    u16 left = KIND_OF(LEFT(node)), right = KIND_OF(RIGHT(node));
    if ((EXPR_FLAGS_AT(left) & mask) && (EXPR_FLAGS_AT(right) & mask))
        return 1;
    if (!(EXPR_FLAGS_AT(left) & mask))
        report_kind(node, left);
    if (!(EXPR_FLAGS_AT(right) & mask))
        report_kind(node, right);
    return 0;
}

/* both operands of *output analysed as rvalues with enums made int, the node given the
   left operand's type for now.  1 (with *output replaced) when an operand is in error or
   void, when a C++ operator function was called instead, or when an operand fails the
   mask; 0 to go on */
u8 PREPARE_BINARY_OPERANDS(farptr output, u16 mode, u16 scope, u16 mask)
{
    u16 node = W(output);
    if (scope == VOID_TYPE)
        scope = 0;
    u16 operand = NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), scope, 0)));
    LEFT(node) = operand;
    operand = NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(RIGHT(node), scope, 0)));
    RIGHT(node) = operand;
    EXPR_W(node, EXPR_TYPE) = TYPE_OF(LEFT(node));
    if (KIND_OF(LEFT(node)) == TK_UNDEFINED || KIND_OF(RIGHT(node)) == TK_UNDEFINED) {
        W(output) = REPORT_EXPR_ERROR_PLAIN(0, node);
        return 1;
    }
    if (CPP_MODE) {
        if (TRY_BINARY_OPERATOR_CALL(output, mask, mode))
            return 1;
        if (FLAGS_OF(LEFT(node)) & 0x40) {
            operand = APPLY_CONVERSION_FUNCTION(LEFT(node), mask, 0);
            LEFT(node) = operand;
        }
        if (FLAGS_OF(RIGHT(node)) & 0x40) {
            operand = APPLY_CONVERSION_FUNCTION(RIGHT(node), mask, 0);
            RIGHT(node) = operand;
        }
    }
    if (KIND_OF(LEFT(node)) == TK_VOID || KIND_OF(RIGHT(node)) == TK_VOID) {
        W(output) = REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
        return 1;
    }
    if (!CHECK_OPERAND_KINDS(node, mask)) {
        W(output) = REPORT_EXPR_ERROR_PLAIN(0, node);
        return 1;
    }
    W(output) = node;
    return 0;
}

/* pointer + or - integer (the pointer on the left): the node takes the pointer's type and
   the integer is multiplied by the element size (as long for a huge pointer); an unknown
   size is an error.  A _seg pointer plus an offset becomes operator 2Dh, a far pointer */
u16 SCALE_POINTER_OPERAND(u16 node)
{
    EXPR_W(node, EXPR_TYPE) = TYPE_OF(LEFT(node));
    i32 size = TYPE_SIZE(TYPE_W(TYPE_OF(node), TYPE_TARGET));
    if (!size)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, node);
    if (KIND_OF(node) == TK_SEG_PTR) {
        EXPR_W(node, EXPR_OP) = 0x2D;
        u16 far_type = MAKE_POINTER_TYPE(TYPE_W(TYPE_OF(node), TYPE_TARGET), 0x0F, 0);
        EXPR_W(node, EXPR_TYPE) = far_type;
    }
    u16 scaled = SCALE_BY_ELEMENT_SIZE(0x18, size, RIGHT(node), KIND_OF(node) == TK_HUGE_PTR ? LONG_TYPE : INT_TYPE);
    RIGHT(node) = scaled;
    return node;
}

/* a useless copy removed: when the right side of the assignment-like node *output is a
   comma expression whose value is the left side itself (perhaps as *&x and through
   casts), probably a constructor call that already built the object in place, the
   assignment goes and *output becomes the right side.  1 when it did so */
u8 ELIDE_COPY_ASSIGN(farptr output)
{
    if (!LEFT(W(output)) || !RIGHT(W(output)))
        return 0;
    u16 node = RIGHT(W(output));
    u8 wrapped = 0, chain = 0;
    if (OP(node) == EOP_DEREF) {
        for (node = LEFT(node); OP(node) == 0x35; node = LEFT(node))
            ;
        wrapped = 1;
    }
    if (node && OP(node) == EOP_COMMA) {
        chain = 1;
        node = RIGHT(node);
        while (OP(node) == 0x35)
            node = LEFT(node);
    }
    if (wrapped && node) {
        if (OP(node) != EOP_ADDR)
            return 0;
        node = LEFT(node);
    }
    if (chain && EXPRESSIONS_EQUAL(LEFT(W(output)), node, 0)) {
        u16 previous = W(output);
        W(output) = RIGHT(W(output));
        RIGHT(previous) = 0;
        FREE_EXPR_TREE(previous);
        return 1;
    }
    return 0;
}

/* left = right.  The right side is analysed with the left type wanted and, unless the
   class has special members (TYPE_ATTRS 18h), with the left side as its destination.
   Then: copy elision, C++ operator=, lvalue and const checks, no void values and no
   arrays; null constants become pointers; in C the types must be assignment-compatible
   and the right side is converted to the left type */
u16 CHECK_ASSIGNMENT(u16 node)
{
    u16 operand = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), 0, 0));
    LEFT(node) = operand;
    u16 type = TYPE_OF(LEFT(node));
    EXPR_W(node, EXPR_TYPE) = type;
    u16 scope = (TYPE_B(type, TYPE_ATTRS) & 0x18) ? 0 : LEFT(node);
    operand = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(RIGHT(node), type, scope));
    RIGHT(node) = operand;
    if (elide(&node))
        return node;
    if (CPP_MODE && binary_operator(&node, 0, 0))
        return node;
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    if (OP(LEFT(node)) == 0 || OP(RIGHT(node)) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (CPP_MODE) {
        operand = REWRITE_FOR_REFERENCE_BIND(LEFT(node));
        LEFT(node) = operand;
    }
    if (!IS_LVALUE(LEFT(node)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LVALUE_REQUIRED, node);
    if (!IS_MODIFIABLE_NODE(LEFT(node)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_CANNOT_MODIFY_CONST, node);
    if (KIND_OF(RIGHT(node)) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    if (KIND_OF(node) == TK_ARRAY)
        return type_error(MSG_CANNOT_ASSIGN, TYPE_OF(RIGHT(node)), TYPE_OF(node), node);
    operand = NULL_CONSTANT_TO_POINTER(type, RIGHT(node));
    RIGHT(node) = operand;
    if (CPP_MODE)
        return CHECK_CPP_ASSIGNMENT(node);
    if (!C7_TYPE_COMPAT(type, TYPE_OF(RIGHT(node)), NOT_ANSI_FLAG))
        return type_error(MSG_CANNOT_ASSIGN, TYPE_OF(RIGHT(node)), TYPE_OF(node), node);
    operand = CONVERT_EXPR_TO_TYPE(type, NODE_ENUM_TO_INT(RIGHT(node)), LEFT(node));
    RIGHT(node) = operand;
    return node;
}

/* an initialisation (operator 47h: object = value in a declaration): as CHECK_ASSIGNMENT
   without the lvalue and const checks, and arrays and references are not decayed; the
   node becomes a plain = */
u16 CHECK_INITIALIZATION(u16 node)
{
    u16 operand = ANALYZE_EXPRESSION(LEFT(node), 0, 0);
    LEFT(node) = operand;
    u16 type = TYPE_OF(LEFT(node));
    EXPR_W(node, EXPR_TYPE) = type;
    operand = ANALYZE_EXPRESSION(RIGHT(node), type, LEFT(node));
    RIGHT(node) = operand;
    if (elide(&node))
        return node;
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    if (TYPE_W(type, TYPE_KIND) != TK_ARRAY && !((FLAGS(type) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20))) {
        operand = DECAY_TO_POINTER(RIGHT(node));
        RIGHT(node) = operand;
    }
    u16 right_type = TYPE_OF(RIGHT(node));
    if (TYPE_W(right_type, TYPE_KIND) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    operand = NULL_CONSTANT_TO_POINTER(type, RIGHT(node));
    RIGHT(node) = operand;
    if (CPP_MODE)
        return CHECK_CPP_INITIALIZATION(node);
    if (TYPE_W(type, TYPE_KIND) == TK_FUNCTION ||
        !C7_TYPE_COMPAT(type, TYPE_OF(RIGHT(node)), (u8)(NOT_ANSI_FLAG & !CPP_MODE)))
        return type_error(MSG_CANNOT_INITIALIZE, type, TYPE_OF(RIGHT(node)), node);
    operand = CONVERT_EXPR_TO_TYPE(type, NODE_ENUM_TO_INT(RIGHT(node)), LEFT(node));
    RIGHT(node) = operand;
    EXPR_W(node, EXPR_OP) = EOP_ASSIGN;
    return node;
}

/* x op= y; hint the operand mask (7 for += -= *= /=, 1 for the integer-only ones).  A
   pointer on the right is an error (82, 83 for += and -=); a pointer on the left allows
   only += and -= with an integer, which is scaled.  Shift counts become BCC_TYPE_PTR[2]
   (unsigned char).  Other arithmetic with a right type wider than the left is rewritten
   x = (wide)x op y, x saved in a temporary if need be, so that it is done in the wider
   type */
u16 CHECK_COMPOUND_ASSIGNMENT(u16 node, u16 mode, u16 hint)
{
    u16 left = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), 0, 0));
    LEFT(node) = left;
    u16 left_type = TYPE_OF(left);
    EXPR_W(node, EXPR_TYPE) = left_type;
    u16 right = NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(RIGHT(node), left_type, 0)));
    RIGHT(node) = right;
    u16 op = OP(node);
    u16 right_type = TYPE_OF(right);
    if (CPP_MODE) {
        if (binary_operator(&node, 0, mode))
            return node;
        if (TYPE_W(left_type, TYPE_KIND) == TK_ENUM) {
            i32 one = FORMAT_TYPE(right_type);
            i32 two = FORMAT_TYPE(left_type);
            REPORT_DIAGNOSTIC_AT(MSG_ASSIGNING, one, two, EXPR_W(node, EXPR_SRC_LINE), EXPR_W(node, EXPR_SRC_WORD3));
        }
        left = REWRITE_FOR_REFERENCE_BIND(left);
    }
    left = NODE_ENUM_TO_INT(left);
    LEFT(node) = left;
    if (!IS_LVALUE(left))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LVALUE_REQUIRED, node);
    if (!IS_MODIFIABLE_NODE(left))
        return REPORT_EXPR_ERROR_PLAIN(MSG_CANNOT_MODIFY_CONST, node);
    if (CPP_MODE && (FLAGS(right_type) & 0x40)) {
        right = APPLY_CONVERSION_FUNCTION(right, hint, 0);
        RIGHT(node) = right;
        right_type = TYPE_OF(right);
    }
    if (FLAGS(right_type) & 0x14)
        return REPORT_EXPR_ERROR_PLAIN(op == 0x13 ? 0x52 : op == 0x14 ? 0x53 : 0x13, node);
    if ((FLAGS(left_type) & 0x14) && ((op != 0x13 && op != 0x14) || !(FLAGS(right_type) & 1)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_USE_POINTER, node);
    if (!CHECK_OPERAND_KINDS(node, hint))
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (TYPE_W(right_type, TYPE_KIND) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    if (FLAGS(left_type) & 0x14)
        return SCALE_POINTER_OPERAND(node);
    if (OP(node) == EOP_SHL_ASSIGN || OP(node) == EOP_SHR_ASSIGN) {
        u16 count = CONVERT_EXPR_TO_TYPE(BCC_TYPE(2), right, 0);
        RIGHT(node) = count;
        return node;
    }
    if (!C7_TYPE_COMPAT(left_type, right_type, NOT_ANSI_FLAG))
        return type_error(MSG_CANNOT_ASSIGN, right_type, left_type, node);
    if ((OP(node) == EOP_MOD_ASSIGN || OP(node) == EOP_DIV_ASSIGN || OP(node) == EOP_MUL_ASSIGN) && TK(left_type) <= 2)
        left_type = INT_TYPE;
    if ((FLAGS(left_type) & 1) && (FLAGS(right_type) & 1) && op != 0x15 && op != 0x16 && op != 0x17) {
        u16 converted = CONVERT_EXPR_TO_TYPE(left_type, right, 0);
        RIGHT(node) = converted;
        return node;
    }
    left_type = PICK_WIDER_TYPE(left_type, right_type);
    u16 converted = CONVERT_EXPR_TO_TYPE(left_type, right, 0);
    RIGHT(node) = converted;
    /* the right side wider than x: x = (T)x op y in the wider type T, x evaluated once;
       op + (08h - 13h) turns += into + and so on */
    if (TK(TYPE_OF(left)) < TK(TYPE_OF(RIGHT(node)))) {
        u16 mark = scratch_mark();
        farptr slots = scratch_alloc(4);        /* left, code */
        W(slots) = left;
        W(fp_add(slots, 2)) = 0;
        SAVE_EXPR_IN_TEMP(slots, fp_add(slots, 2));
        left = W(slots);
        u16 code = W(fp_add(slots, 2));
        scratch_release(mark);
        LEFT(node) = left;
        EXPR_W(node, EXPR_OP) = (u16)(op + (0x08 - 0x13));
        left = COPY_EXPR_TREE(left);
        converted = CONVERT_EXPR_TO_TYPE(left_type, LEFT(node), 0);
        LEFT(node) = converted;
        node = MAKE_BINARY_NODE(0x0B, left, node);
        node = ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(code, node), 0, 0);
    }
    return node;
}

/* a return value (operator 46h: EXPR_TYPE the function's return type, EXPR_RIGHT the
   value, EXPR_LEFT an optional destination such as the hidden return slot), checked
   against the return type and converted; with no destination the node is replaced by the
   value, else it becomes an assignment to the destination */
u16 CHECK_RETURN_VALUE(u16 node)
{
    u16 type = TYPE_OF(node);
    u16 scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    u16 operand;
    if (LEFT(node)) {
        operand = ANALYZE_EXPRESSION(LEFT(node), type, 0);
        LEFT(node) = operand;
    }
    operand = ANALYZE_EXPRESSION(RIGHT(node), type, LEFT(node));
    RIGHT(node) = operand;
    if (OP(RIGHT(node)) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    operand = NULL_CONSTANT_TO_POINTER(type, RIGHT(node));
    RIGHT(node) = operand;
    u16 right_type = TYPE_OF(RIGHT(node));
    if (TYPE_W(right_type, TYPE_KIND) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    if (CPP_MODE)
        return CHECK_CPP_RETURN_VALUE(node, scope);
    if (elide(&node))
        return node;
    operand = CONVERT_TO_RVALUE(RIGHT(node));
    RIGHT(node) = operand;
    right_type = TYPE_OF(RIGHT(node));
    if (TYPE_W(type, TYPE_KIND) != TK_VOID) {
        if (!C7_TYPE_COMPAT(type, right_type, NOT_ANSI_FLAG))
            return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_TYPE_DOES, node);
        operand = CONVERT_EXPR_TO_TYPE(type, RIGHT(node), LEFT(node));
        RIGHT(node) = operand;
    }
    if (!LEFT(node)) {
        u16 old = node;
        node = RIGHT(node);
        FREE_EXPR_NODE(old);
    } else
        EXPR_W(node, EXPR_OP) = EOP_ASSIGN;
    return node;
}

/* * / % & | ^ (hint 3 for * and /, 1 for the integer ones): the usual arithmetic
   conversions toward the wanted type, at least int for * / %; other operands must have
   compatible types */
u16 CHECK_MULTIPLICATIVE_OP(u16 node, u16 mode, u16 type, u16 hint)
{
    if (prepare(&node, mode, type, hint))
        return node;
    if ((OP(node) == EOP_MOD || OP(node) == EOP_DIV || OP(node) == EOP_MUL) && TK(type) < 5)
        type = INT_TYPE;
    if (((FLAGS_OF(LEFT(node)) & 3) || (FLAGS_OF(LEFT(node)) & 0x40)) &&
        ((FLAGS_OF(RIGHT(node)) & 3) || (FLAGS_OF(RIGHT(node)) & 0x40)))
        return USUAL_ARITHMETIC_CONVERSIONS(type, node);
    if (TYPES_COMPATIBLE(TYPE_OF(LEFT(node)), TYPE_OF(RIGHT(node)), 1))
        return node;
    return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING, node);
}

/* << and >>: the left operand promoted (int or unsigned int) gives the result type; the
   count becomes BCC_TYPE_PTR[2] (unsigned char) */
u16 CHECK_INTEGRAL_OP(u16 node, u16 mode)
{
    if (prepare(&node, mode, 0, 1))
        return node;
    u16 child = LEFT(node);
    if (OP(child) != 0) {
        u16 type = ENUM_UNDERLYING_TYPE(TYPE_OF(child));
        EXPR_W(child, EXPR_TYPE) = type;
        if (TYPE_I(type, TYPE_KIND) < TK_USHORT)
            type = INT_TYPE;
        else if (TYPE_I(type, TYPE_KIND) == TK_USHORT)
            type = UNSIGNED_INT_TYPE;
        u16 converted = CONVERT_EXPR_TO_TYPE(type, child, 0);
        LEFT(node) = converted;
        EXPR_W(node, EXPR_TYPE) = type;
    }
    if (RIGHT(node)) {
        u16 count = CONVERT_EXPR_TO_TYPE(BCC_TYPE(2), RIGHT(node), 0);
        RIGHT(node) = count;
    }
    return node;
}

/* a[i] as *(a + i) (token 18h makes the *) */
u16 CHECK_SUBSCRIPT(u16 node, u16 mode)
{
    if (CPP_MODE && prepare(&node, mode, 0, 0x17))
        return node;
    EXPR_W(node, EXPR_OP) = EOP_ADD;
    node = CHECK_ADDITION(node, mode, 0);
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    return ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x18, node), 0, 0);
}

/* (C) object.member completed: the member found by name (operator 38h) or taken from a
   member reference (4Ah), the right operand replaced by a member node, the result typed
   as the member with the object's const and volatile.  A bitfield wider than unsigned
   int (a long bitfield) is read as int or unsigned int and converted */
u16 BUILD_MEMBER_ACCESS(u16 node)
{
    u16 member = 0;
    u16 type = TYPE_OF(LEFT(node));
    u16 right = RIGHT(node);
    if (OP(right) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (OP(right) == 0x38) {
        member = FIND_MEMBER_BY_NAME(LEFT(right), type);
        if (!member) {
            farptr name = NAME_TEXT_COPY(LEFT(right));
            i32 type_name = FORMAT_TYPE(type);
            return REPORT_EXPR_ERROR(MSG_NOT_MEMBER, name, type_name, node);
        }
    } else if (OP(right) == 0x4A)
        member = LEFT(right);
    FREE_EXPR_NODE(right);
    /* the freed node's source position, read after the free as in the original */
    u16 made = MAKE_MEMBER_NODE(member, EXPR_W(right, 0x18), EXPR_W(right, 0x16), EXPR_W(right, 0x14));
    RIGHT(node) = made;
    u16 qualified = ADD_CV_QUALIFIERS(MEMBER_W(member, MEMB_TYPE), (TYPE_B(type, TYPE_ATTRS) & 2) != 0,
                                      (TYPE_B(type, TYPE_ATTRS) & 1) != 0);
    EXPR_W(node, EXPR_TYPE) = qualified;
    if ((MEMBER_B(member, MEMB_FLAGS) & 0x40) && TYPE_I(TYPE_OF(node), TYPE_KIND) > TK_UINT) {
        u16 result_type = TYPE_OF(node);
        EXPR_W(node, EXPR_TYPE) = (FLAGS(result_type) & 0x20) ? BCC_TYPE(6) : INT_TYPE;
        EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
        return CONVERT_EXPR_TO_TYPE(result_type, node, 0);
    }
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    return node;
}

/* object.member: the left side a struct or union; C++ goes to ANALYZE_MEMBER_SELECT (mode
   passed on), C to BUILD_MEMBER_ACCESS */
u16 CHECK_DOT_MEMBER(u16 node, u8 mode)
{
    u16 child = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), 0, 0));
    LEFT(node) = child;
    if (OP(child) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (!(FLAGS_OF(child) & 0x40))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LEFT_SIDE_MUST, node);
    if (CPP_MODE)
        return ANALYZE_MEMBER_SELECT(node, mode);
    return BUILD_MEMBER_ACCESS(node);
}

/* p->m and p->*m as (*p).m and (*p).*m, kind the operator to use then (3Bh . or 3Ch .*).
   A based pointer is made a normal pointer first.  In C++ a class on the left of -> goes
   through operator-> (token 30h) while one applies, and ->* may be an overloaded
   operator */
u16 CHECK_POINTER_INDIRECTION(u16 node, u16 mode, u16 kind)
{
    u16 child = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), 0, 0));
    LEFT(node) = child;
    if (OP(child) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (KIND_OF(child) == TK_NEAR_PTR && TYPE_W(TYPE_OF(child), TYPE_PTR_BASE))
        child = ANALYZE_EXPRESSION(APPLY_BASED_POINTER(child), 0, 0);
    if (CPP_MODE && (FLAGS_OF(child) & 0x40)) {
        if (OP(node) == EOP_ARROW) {
            while (FLAGS_OF(child) & 0x40) {
                u16 temporary = MAKE_UNARY_NODE(0x30, child);
                u16 mark = scratch_mark();
                farptr slot = scratch_alloc(2);
                W(slot) = temporary;
                u8 called = TRY_UNARY_OPERATOR_CALL(slot, 0, 0);
                temporary = W(slot);
                scratch_release(mark);
                if (called)
                    child = temporary;
                else {
                    FREE_EXPR_NODE(temporary);
                    break;
                }
            }
        } else {
            u16 operand = ANALYZE_EXPRESSION(RIGHT(node), 0, 0);
            RIGHT(node) = operand;
            if (binary_operator(&node, 0, mode))
                return node;
        }
    }
    if (OP(child) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    LEFT(node) = child;
    if (!(FLAGS_OF(child) & 0x14))
        return REPORT_EXPR_ERROR_PLAIN(MSG_POINTER_REQUIRED_LEFT, node);
    if ((FLAGS_OF(child) & 0x14) && TYPE_W(TYPE_W(TYPE_OF(child), TYPE_TARGET), TYPE_KIND) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    u16 dereferenced = MAKE_DEREFERENCE(child);
    LEFT(node) = dereferenced;
    EXPR_W(node, EXPR_OP) = kind;
    return ANALYZE_EXPRESSION(node, 0, 0);
}

static int void_pointer(u16 type)
{
    return (FLAGS(type) & 0x14) && TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_VOID;
}

/* a + b, kind the wanted type.  A pointer operand goes to the left.  Arithmetic: the
   usual conversions; pointer + integer: scaled; pointer + pointer only as a _seg pointer
   plus a near pointer to compatible types, giving a far pointer (operator 2Dh) */
u16 CHECK_ADDITION(u16 node, u16 mode, u16 kind)
{
    if (prepare(&node, mode, kind, 0x17))
        return node;
    if (KIND_OF(LEFT(node)) != TK_SEG_PTR && (FLAGS_OF(RIGHT(node)) & 0x14))
        node = SWAP_OPERANDS(node);
    u16 left_type = TYPE_OF(LEFT(node));
    if (!(FLAGS(left_type) & 0x14))
        return USUAL_ARITHMETIC_CONVERSIONS(kind, node);
    u16 right_type = TYPE_OF(RIGHT(node));
    if (FLAGS(right_type) & 1)
        return SCALE_POINTER_OPERAND(node);
    if (!(FLAGS(right_type) & 0x14))
        return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING, node);
    if (TYPE_W(right_type, TYPE_KIND) == TK_SEG_PTR) {
        u16 temporary = right_type;
        right_type = left_type;
        left_type = temporary;
        node = SWAP_OPERANDS(node);
    }
    if (TYPE_W(left_type, TYPE_KIND) != TK_SEG_PTR || TYPE_W(right_type, TYPE_KIND) == TK_SEG_PTR ||
        TYPE_W(right_type, TYPE_KIND) == TK_FAR_PTR ||
        (!TYPES_COMPATIBLE(TYPE_W(left_type, TYPE_TARGET), TYPE_W(right_type, TYPE_TARGET), 0) &&
         !void_pointer(left_type) && !void_pointer(right_type)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_INVALID_POINTER, node);
    EXPR_W(node, EXPR_OP) = 0x2D;
    u16 far_type = MAKE_POINTER_TYPE(TYPE_W(void_pointer(left_type) ? right_type : left_type, TYPE_TARGET), 0x0F, 0);
    EXPR_W(node, EXPR_TYPE) = far_type;
    return node;
}

/* a - b, type the wanted type.  Pointer - pointer needs compatible pointers (or, outside
   strict ANSI, equal element sizes) and gives (p - q) / sizeof(*p) as int (long unless near
   pointers), converted to PTRDIFF_TYPE when a wider result is wanted.  Pointer - integer
   is scaled; integer - pointer is an error */
u16 CHECK_SUBTRACTION(u16 node, u16 mode, u16 type)
{
    if (prepare(&node, mode, type, 7))
        return node;
    if (FLAGS_OF(LEFT(node)) & 0x14) {
        if (FLAGS_OF(RIGHT(node)) & 0x14) {
            BALANCE_BINARY_OPERANDS(type, node);
            u16 size = (u16)TYPE_SIZE(TYPE_W(TYPE_OF(LEFT(node)), TYPE_TARGET));
            if (TYPES_COMPATIBLE(TYPE_OF(LEFT(node)), TYPE_OF(RIGHT(node)), 2) ||
                (NOT_ANSI_FLAG && TYPE_SIZE(TYPE_W(TYPE_OF(RIGHT(node)), TYPE_TARGET)) == (i32)size)) {
                u16 converted = CONVERT_EXPR_TO_TYPE(TYPE_OF(RIGHT(node)), LEFT(node), 0);
                LEFT(node) = converted;
                if (!size)
                    return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, node);
                EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
                EXPR_W(node, EXPR_TYPE) = KIND_OF(LEFT(node)) == TK_NEAR_PTR ? INT_TYPE : LONG_TYPE;
                node = SCALE_BY_ELEMENT_SIZE(0x19, (i32)size, node, TYPE_OF(node));
                if (TYPE_I(type, TYPE_KIND) >= TYPE_I(PTRDIFF_TYPE, TYPE_KIND) &&
                    TYPE_I(PTRDIFF_TYPE, TYPE_KIND) > TYPE_I(TYPE_OF(node), TYPE_KIND))
                    node = CONVERT_EXPR_TO_TYPE(PTRDIFF_TYPE, node, 0);
                return node;
            }
            return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING, node);
        }
        if (FLAGS_OF(RIGHT(node)) & 1)
            return SCALE_POINTER_OPERAND(node);
        return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING, node);
    }
    if (FLAGS_OF(RIGHT(node)) & 0x14)
        return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_POINTER, node);
    return USUAL_ARITHMETIC_CONVERSIONS(type, node);
}

/* && and ||: both operands scalar, the result int.  In C++ the temporaries the right
   operand makes are destroyed inside it, since it may not be evaluated at all */
u16 CHECK_LOGICAL_OP(u16 node, u16 mode)
{
    u16 operand = NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), 0, 0)));
    LEFT(node) = operand;
    u16 saved = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    operand = NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(RIGHT(node), 0, 0)));
    RIGHT(node) = operand;
    EXPR_W(node, EXPR_TYPE) = INT_TYPE;
    if (KIND_OF(LEFT(node)) == TK_UNDEFINED || KIND_OF(RIGHT(node)) == TK_UNDEFINED)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (KIND_OF(LEFT(node)) == TK_VOID || KIND_OF(RIGHT(node)) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    if (CPP_MODE) {
        if (binary_operator(&node, 7, mode))
            return node;
        operand = CONVERT_CLASS_TO_SCALAR(RIGHT(node));
        RIGHT(node) = operand;
        operand = APPEND_TEMP_DESTRUCTORS(RIGHT(node), saved);
        RIGHT(node) = operand;
        operand = CONVERT_CLASS_TO_SCALAR(LEFT(node));
        LEFT(node) = operand;
    }
    if (!CHECK_OPERAND_KINDS(node, 7))
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    EXPR_W(node, EXPR_TYPE) = INT_TYPE;
    return node;
}

/* == != < > <= >=: the operands balanced (with char as the wanted type, so that byte
   compares stay possible), the result int.  Member function pointers in C++ go to
   COMPARE_MEMBER_POINTERS.  In C, mismatched pointers or a pointer against an integer only
   warn, and two function pointers are not balanced for < > <= >= */
u16 CHECK_COMPARISON(u16 node, u16 mode)
{
    if (prepare(&node, mode, INT_TYPE, 7))
        return node;
    u16 left = TYPE_OF(LEFT(node)), right = TYPE_OF(RIGHT(node));
    if (CPP_MODE || !(FLAGS(left) & 0x14) || TYPE_W(TYPE_W(left, TYPE_TARGET), TYPE_KIND) != TK_FUNCTION ||
        !(FLAGS(right) & 0x14) || TYPE_W(TYPE_W(right, TYPE_TARGET), TYPE_KIND) != TK_FUNCTION ||
        OP(node) == EOP_EQ || OP(node) == EOP_NE) {
        node = BALANCE_BINARY_OPERANDS(CHAR_TYPE, node);
        EXPR_W(node, EXPR_TYPE) = INT_TYPE;
        left = TYPE_OF(LEFT(node));
        right = TYPE_OF(RIGHT(node));
        if (TYPES_COMPATIBLE(left, right, 2)) {
            if (CPP_MODE && TYPE_W(left, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(left, TYPE_PTR_MODE) == 0x0B &&
                (FLAGS(left) & 0x14) && TYPE_W(TYPE_W(left, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION)
                return COMPARE_MEMBER_POINTERS(node);
            return node;
        }
    }
    if (!CPP_MODE && ((FLAGS(left) & 0x14) || (FLAGS(right) & 0x14))) {
        if ((FLAGS(left) & 0x14) && (FLAGS(right) & 0x14) &&
            ((TYPE_W(TYPE_W(left, TYPE_TARGET), TYPE_KIND) == TK_UCHAR && TYPE_W(TYPE_W(right, TYPE_TARGET), TYPE_KIND) == TK_CHAR) ||
             (TYPE_W(TYPE_W(left, TYPE_TARGET), TYPE_KIND) == TK_CHAR && TYPE_W(TYPE_W(right, TYPE_TARGET), TYPE_KIND) == TK_UCHAR))) {
            REPORT_DIAGNOSTIC_AT(MSG_MIXING_POINTERS_SIGNED, 0, 0, EXPR_W(node, EXPR_SRC_LINE), EXPR_W(node, EXPR_SRC_WORD3));
            return node;
        }
        REPORT_DIAGNOSTIC_AT(MSG_NONPORTABLE_POINTER_362, 0, 0, EXPR_W(node, EXPR_SRC_LINE), EXPR_W(node, EXPR_SRC_WORD3));
    } else
        node = REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING, node);
    return node;
}

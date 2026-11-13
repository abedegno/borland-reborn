/* unaryop.c: from bcc20/src/expr/UNARYOP.C: analysis of the unary operators *p, &x, ++
   and --, unary + and -, ~ and !.  The expression analyser (EXPRDISP.C) calls the BUILD_*
   function for a node whose operand is not yet analysed; each analyses the operand,
   checks it, sets the node's type and marks it analysed (EXPR_NODE_FLAGS bit 1), or
   replaces it by an error node (message 0 when the operand already carried an error).
   C6PRE is the common first step: its operation argument is the EXPR_FLAGS mask of the
   operand types the operator takes (14h pointers, 3 arithmetic, 1 integral, 7 scalar, 0
   for ++ and --), for C++'s search for a conversion; hint is the type the result is
   wanted in, if known.  In C++ an operand of class type may select an overloaded operator
   or a conversion function, and references are looked through. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"

#define TYPE_OF(node) EXPR_W((node), EXPR_TYPE)
#define KIND_OF(node) TYPE_W(TYPE_OF(node), TYPE_KIND)
#define FLAGS_OF(node) EXPR_FLAGS_AT(KIND_OF(node))
#define LEFT(node) EXPR_W((node), EXPR_LEFT)

/* a pointer to a function */
static int function_pointer(u16 type)
{
    return (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION;
}

/* C6PRE and TRY_UNARY_OPERATOR_CALL take the address of the caller's node variable,
   which lives in the scratch area for the call */
static u8 pre(u16 *expression, u16 context, u16 hint, u16 operation)
{
    u16 mark = scratch_mark();
    farptr p = scratch_alloc(2);
    W(p) = *expression;
    u8 replaced = C6PRE(p, context, hint, operation);
    *expression = W(p);
    scratch_release(mark);
    return replaced;
}

static u8 try_operator(u16 *expression, u16 operation, u16 context)
{
    u16 mark = scratch_mark();
    farptr p = scratch_alloc(2);
    W(p) = *expression;
    u8 replaced = TRY_UNARY_OPERATOR_CALL(p, operation, context);
    *expression = W(p);
    scratch_release(mark);
    return replaced;
}

/* the operand of the unary node *output analysed and made an rvalue (hint the wanted
   type, VOID_TYPE taken as none); error and void operands rejected, a user-defined
   operator or conversion tried in C++, an enum operand made int.  1 when *output has
   been replaced (an error node or an operator call) and the caller must return it */
u8 C6PRE(farptr output, u16 context, u16 hint, u16 operation)
{
    u16 node = W(output);
    if (hint == VOID_TYPE)
        hint = 0;
    u16 left = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(node), hint, 0));
    LEFT(node) = left;
    if (EXPR_W(LEFT(node), EXPR_OP) == 0) {
        W(output) = REPORT_EXPR_ERROR_PLAIN(0, W(output));
        return 1;
    }
    if (KIND_OF(LEFT(node)) == TK_VOID) {
        W(output) = REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, W(output));
        return 1;
    }
    if (CPP_MODE) {
        if (TRY_UNARY_OPERATOR_CALL(output, operation, context))
            return 1;
        if (FLAGS_OF(LEFT(node)) & 0x40) {
            left = APPLY_CONVERSION_FUNCTION(LEFT(node), operation, hint);
            LEFT(node) = left;
        }
    }
    left = NODE_ENUM_TO_INT(LEFT(W(output)));
    LEFT(node) = left;
    return 0;
}

/* *p.  A based near pointer is made a normal pointer first.  *f for a function pointer f
   gives f itself unless keep is set (when the & of &*f follows).  Errors: not a pointer,
   a pointer to void, a pointer to an object of unknown size.  The type is the target */
u16 BUILD_DEREF(u16 expression, u16 context, u8 keep)
{
    u16 node = ANALYZE_EXPRESSION(LEFT(expression), 0, 0);
    if (KIND_OF(node) == TK_NEAR_PTR && TYPE_W(TYPE_OF(node), TYPE_PTR_BASE))
        node = APPLY_BASED_POINTER(node);
    LEFT(expression) = node;
    if (pre(&expression, context, 0, 0x14))
        return expression;
    node = LEFT(expression);
    u16 kind = KIND_OF(node);
    if (function_pointer(TYPE_OF(node))) {
        if (!keep) {
            FREE_EXPR_NODE(expression);
            return node;
        }
    } else if (!(EXPR_FLAGS_AT(kind) & 0x14))
        return REPORT_EXPR_ERROR_PLAIN(!kind ? 0 : MSG_INVALID_INDIRECTION, expression);
    u16 target = TYPE_W(TYPE_OF(node), TYPE_TARGET);
    if ((FLAGS_OF(node) & 0x14) && TYPE_W(target, TYPE_KIND) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, expression);
    if (TYPE_SIZE(target) == 0 && !function_pointer(TYPE_OF(node)) && TYPE_W(target, TYPE_KIND) != TK_ARRAY)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, expression);
    EXPR_W(expression, EXPR_TYPE) = TYPE_W(TYPE_OF(node), TYPE_TARGET);
    EXPR_B(expression, EXPR_NODE_FLAGS) |= 1;
    return expression;
}

/* 1 when node (looking through ".") is a register variable, whose address cannot be
   taken: in C++ storage class 7; in C an automatic or parameter (class 5 or 6) with
   SYM_FLAGS bit 8 */
u8 C6PRED(u16 node)
{
    while (node && EXPR_W(node, EXPR_OP) == EOP_DOT)
        node = LEFT(node);
    if (node && EXPR_W(node, EXPR_OP) == 1) {
        u16 symbol = LEFT(node);
        u8 storage = SYM_B(symbol, SYM_STORAGE_CLASS) >> 3;
        if (CPP_MODE)
            return storage == 7;
        return (storage == 5 || storage == 6) && (SYM_B(symbol, SYM_FLAGS) & 8);
    }
    return 0;
}

/* the pointer kind for the address of node: far (0Fh) for a far variable (SYM_FLAGS 80h)
   or for *p with p a _seg pointer, the kind of p for other *p, else 0 for
   MAKE_POINTER_TYPE's default */
u16 C6KIND(u16 node)
{
    while (EXPR_W(node, EXPR_OP) == EOP_DOT)
        node = LEFT(node);
    if (EXPR_W(node, EXPR_OP) == 1) {
        if (SYM_B(LEFT(node), SYM_FLAGS) & 0x80)
            return 0x0F;
    } else if (EXPR_W(node, EXPR_OP) == EOP_DEREF) {
        if (KIND_OF(LEFT(node)) == TK_SEG_PTR)
            return 0x0F;
        return KIND_OF(LEFT(node));
    }
    return 0;
}

/* &x.  fresh is 0 when the node already was an & node (an explicit &, probably, rather
   than an implied one), which matters for the "superfluous & with function" warning and
   for operator& in C++; policy goes on to the resolution of an overloaded function name.
   Returns the analysed node, a member pointer constant or an error node */
u16 BUILD_ADDRESS_OF(u16 expression, u16 context, u16 policy)
{
    u16 left;
    u8 fresh = EXPR_W(expression, EXPR_OP) != EOP_ADDR;
    EXPR_W(expression, EXPR_OP) = EOP_ADDR;
    u8 special = 0;
    /* C++: a symbol of storage class 9 (probably a named constant) needs an initialised
       temporary to have an address */
    if (CPP_MODE && LEFT(expression) && EXPR_W(LEFT(expression), EXPR_OP) == 1)
        special = (SYM_B(LEFT(LEFT(expression)), SYM_STORAGE_CLASS) >> 3) == 9;
    if (!(EXPR_B(LEFT(expression), EXPR_NODE_FLAGS) & 1)) {
        if (EXPR_W(LEFT(expression), EXPR_OP) == EOP_DEREF)
            left = BUILD_DEREF(LEFT(expression), 0, 1);
        else if (EXPR_W(LEFT(expression), EXPR_OP) == EOP_DOT)
            left = CHECK_DOT_MEMBER(LEFT(expression), 1);
        else
            left = ANALYZE_EXPRESSION(LEFT(expression), 0, 0);
        LEFT(expression) = left;
    }
    if (CPP_MODE && (FLAGS_OF(LEFT(expression)) & 0x14) && (TYPE_B(TYPE_OF(LEFT(expression)), TYPE_ATTRS) & 0x20)) {
        left = DEREF_REFERENCE_EXPR(LEFT(expression));
        LEFT(expression) = left;
    }
    if (KIND_OF(LEFT(expression)) == TK_FUNCTION) {
        if (CPP_MODE && EXPR_W(LEFT(expression), EXPR_OP) == 1) {
            EXPR_B(LEFT(expression), EXPR_NODE_FLAGS) &= 0xFE;
            left = RESOLVE_SYMBOL_REFERENCE(LEFT(expression), policy);
            LEFT(expression) = left;
        }
        if (!CPP_MODE && !fresh)
            REPORT_CURRENT_TOKEN(MSG_SUPERFLUOUS_FUNCTION);
    } else if (KIND_OF(LEFT(expression)) != TK_ARRAY && EXPR_W(LEFT(expression), EXPR_OP) != 0x4A) {
        left = DECAY_TO_POINTER(LEFT(expression));
        LEFT(expression) = left;
    }
    if (CPP_MODE) {
        left = REWRITE_FOR_REFERENCE_BIND(LEFT(expression));
        LEFT(expression) = left;
    }
    u8 needs_check = IS_LVALUE(LEFT(expression));
    u16 type = TYPE_OF(LEFT(expression));
    if (TYPE_W(type, TYPE_KIND) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, expression);
    if (CPP_MODE && !fresh && try_operator(&expression, 0, context))
        return expression;
    /* the result is a pointer to the operand's type */
    u16 pointer = MAKE_POINTER_TYPE(type, C6KIND(LEFT(expression)), 0);
    EXPR_W(expression, EXPR_TYPE) = pointer;
    if (special) {
        left = MAKE_INITIALIZED_TEMP(LEFT(expression));
        LEFT(expression) = left;
        needs_check = 1;
    }
    if (!needs_check)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VARIABLE_NAME_EXPECTED, expression);
    if (C6PRED(LEFT(expression)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_MUST_TAKE_ADDRESS, expression);
    /* a named variable: automatics and parameters get pointer mode 3 (probably
       SS-relative) when DS may differ from SS; a function is marked "address taken" */
    if (EXPR_W(LEFT(expression), EXPR_OP) == 1) {
        u16 symbol = LEFT(LEFT(expression));
        u8 storage = SYM_B(symbol, SYM_STORAGE_CLASS) >> 3;
        if ((storage == 5 || storage == 6) &&
            (OPTION_DS_NOT_SS || ((i8)MODEL_FAR_DATA & !(i8)OPTION_SS_EQUALS_DS)))
            TYPE_B(EXPR_W(expression, EXPR_TYPE), TYPE_PTR_MODE) = 3;
        if (TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND) == TK_FUNCTION) {
            SYM_W(symbol, SYM_FUNC_FLAGS) |= 8;
            return CPP_MODE ? MAKE_MEMBER_POINTER(expression, fresh) : expression;
        }
        if ((SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) <= 6)
            return expression;
        return REPORT_EXPR_ERROR_PLAIN(MSG_VARIABLE_NAME_EXPECTED, expression);
    }
    /* &Class::member (operator 4Ah): a member pointer constant, the offset + 1 so that 0
       can be the null member pointer */
    if (EXPR_W(LEFT(expression), EXPR_OP) == 0x4A) {
        u16 record = LEFT(LEFT(expression));
        u16 new_type = MAKE_POINTER_TYPE(TYPE_OF(LEFT(expression)), 0x0D, 0);
        if (!MEMBER_ACCESSIBLE(record, CURRENT_CLASS_TYPE))
            return REPORT_EXPR_ERROR(0xB6, (farptr)FORMAT_MEMBER(record), 0, expression);
        if (MEMBER_B(record, MEMB_FLAGS) & 0x40)
            return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_TAKE_ADDRESS, expression);
        if (!TYPE_W(type, TYPE_MEMBER_CLASS)) {
            type = COPY_TYPE_RECORD(type);
            TYPE_W(type, TYPE_MEMBER_CLASS) = EXPR_W(LEFT(expression), EXPR_RIGHT);
            TYPE_W(new_type, TYPE_TARGET) = type;
        }
        TYPE_B(new_type, TYPE_PTR_MODE) = 0x0B;
        FREE_EXPR_TREE(expression);
        return MAKE_INT_CONSTANT(new_type, (i32)MEMBER_W(record, MEMB_VALUE) + 1);
    }
    /* &object.member: a bitfield has no address; for a member function only the qualified
       form (node flag 2) gives a member pointer */
    if (EXPR_W(LEFT(expression), EXPR_OP) == EOP_DOT) {
        if (KIND_OF(LEFT(expression)) == TK_FUNCTION) {
            u16 record = LEFT(LEFT(expression));
            if (EXPR_B(LEFT(expression), EXPR_NODE_FLAGS) & 2) {
                FREE_EXPR_NODE(record);
                record = LEFT(expression);
                LEFT(expression) = EXPR_W(record, EXPR_RIGHT);
                FREE_EXPR_NODE(record);
                SYM_W(LEFT(LEFT(expression)), SYM_FUNC_FLAGS) |= 8;
                return MAKE_MEMBER_POINTER(expression, fresh);
            }
            return REPORT_EXPR_ERROR_PLAIN(MSG_USE_TAKE_ADDRESS, expression);
        }
        if (EXPR_B(EXPR_W(LEFT(expression), EXPR_RIGHT), EXPR_NODE_FLAGS) & 4)
            return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_TAKE_ADDRESS, expression);
    }
    return expression;
}

/* the error for an operand of the wrong type: "illegal structure operation" for a
   structure, else message */
static u16 wrong_type(u16 expression, u16 message)
{
    return REPORT_EXPR_ERROR_PLAIN((FLAGS_OF(LEFT(expression)) & 0x40) ? MSG_ILLEGAL_STRUCTURE : message, expression);
}

/* ++x, --x, x++, x--: the operand a modifiable lvalue of scalar type, a pointer to a type
   of known size */
u16 BUILD_INCDEC(u16 expression, u16 context)
{
    if (pre(&expression, context, 0, 0))
        return expression;
    if (CPP_MODE) {
        u16 left = REWRITE_FOR_REFERENCE_BIND(LEFT(expression));
        LEFT(expression) = left;
    }
    if (!IS_LVALUE(LEFT(expression)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LVALUE_REQUIRED, expression);
    if (!IS_MODIFIABLE_NODE(LEFT(expression)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_CANNOT_MODIFY_CONST, expression);
    if (!(FLAGS_OF(LEFT(expression)) & 7))
        return wrong_type(expression, MSG_EXPRESSION_SCALAR_TYPE);
    EXPR_W(expression, EXPR_TYPE) = TYPE_OF(LEFT(expression));
    if ((FLAGS_OF(LEFT(expression)) & 0x14) && TYPE_SIZE(TYPE_W(TYPE_OF(expression), TYPE_TARGET)) == 0)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, expression);
    return expression;
}

/* unary + and -: the operand arithmetic.  A small integer operand becomes int unless the
   wanted type (hint) is itself smaller than int and the operand signed, probably so that
   char arithmetic can stay narrow */
u16 BUILD_UNARY_ARITH(u16 expression, u16 context, u16 hint)
{
    if (pre(&expression, context, hint, 3))
        return expression;
    u16 node = LEFT(expression);
    if (!(FLAGS_OF(node) & 3))
        return wrong_type(expression, MSG_EXPRESSION_ARITHMETIC);
    if (TYPE_SIZE(TYPE_OF(node)) < (i32)INT_TYPE_SIZE &&
        ((FLAGS_OF(node) & 0x20) || !hint || TYPE_SIZE(hint) >= (i32)INT_TYPE_SIZE)) {
        node = CONVERT_EXPR_TO_TYPE(INT_TYPE, node, 0);
        LEFT(expression) = node;
    }
    EXPR_W(expression, EXPR_TYPE) = TYPE_OF(node);
    return expression;
}

/* ~x: the operand integral, widened to the wanted integer type (hint, default int) when
   that is larger */
u16 BUILD_COMPLEMENT(u16 expression, u16 context, u16 hint)
{
    if (!hint || !(EXPR_FLAGS_AT(TYPE_W(hint, TYPE_KIND)) & 1))
        hint = INT_TYPE;
    if (pre(&expression, context, hint, 1))
        return expression;
    if (!(FLAGS_OF(LEFT(expression)) & 1))
        return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_INTEGRAL, expression);
    if (TYPE_SIZE(hint) > TYPE_SIZE(TYPE_OF(LEFT(expression)))) {
        u16 left = CONVERT_EXPR_TO_TYPE(hint, LEFT(expression), 0);
        LEFT(expression) = left;
    }
    EXPR_W(expression, EXPR_TYPE) = TYPE_OF(LEFT(expression));
    return expression;
}

/* !x: the operand scalar (in C++ a class may convert to one); an operand smaller than int
   gets a cast to int, and the result is int */
u16 BUILD_LOGICAL_NOT(u16 expression, u16 context)
{
    if (pre(&expression, context, CHAR_TYPE, 7))
        return expression;
    if (!(FLAGS_OF(LEFT(expression)) & 7))
        return wrong_type(expression, MSG_EXPRESSION_SCALAR_TYPE);
    if (CPP_MODE) {
        u16 left = CONVERT_CLASS_TO_SCALAR(LEFT(expression));
        LEFT(expression) = left;
    }
    if ((i16)KIND_OF(LEFT(expression)) < TK_INT && KIND_OF(LEFT(expression)) != TK_UNDEFINED) {
        u16 left = MAKE_CAST_NODE(INT_TYPE, LEFT(expression));
        LEFT(expression) = left;
        EXPR_B(LEFT(expression), EXPR_NODE_FLAGS) |= 1;
    }
    EXPR_W(expression, EXPR_TYPE) = INT_TYPE;
    return expression;
}

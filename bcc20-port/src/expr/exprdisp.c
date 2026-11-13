/* exprdisp.c: from bcc20/src/expr/EXPRDISP.C: the centre of semantic analysis.  The parser
   builds a raw tree and ANALYZE_EXPRESSION dispatches on each node's operator to the
   checker for it, which analyses the operands (calling back here), applies the
   conversions, sets the node's type and reports errors.  This file itself handles symbol
   references, the conditional operator, casts, sizeof and constants.  Every analysed node
   gets EXPR_NODE_FLAGS bit 1, and an analysed node other than a constant comes back at
   once, so a tree may be analysed twice.  type is the type the value is wanted in (0 no
   preference, VOID_TYPE discarded); context goes on unchanged (for a call, a destination
   for a returned structure).

   The original stops with "out of memory" when the 8086 stack pointer drops below 8F0Ch
   (a very deep tree).  The port has no such stack, so that check is left out (README,
   decisions for the native build). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"

#define TYPE_OF(node) EXPR_W((node), EXPR_TYPE)
#define KIND_OF(node) TYPE_W(TYPE_OF(node), TYPE_KIND)
#define FLAGS_OF(node) EXPR_FLAGS_AT(KIND_OF(node))
#define LEFT(node) EXPR_W((node), EXPR_LEFT)
#define RIGHT(node) EXPR_W((node), EXPR_RIGHT)

/* a pointer type with the reference bit (TYPE_ATTRS 20h) */
static int reference(u16 type)
{
    return (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20);
}

/* the value through the TOKEN_CONVERT hook: value truncated to type kind */
static i32 token_convert(i32 value, i16 kind)
{
    return (i32)CALL_FAR(TOKEN_CONVERT, A32((u32)value), A16((u16)kind));
}

/* a symbol leaf (operator 1): its type becomes the symbol's.  In C++ RESOLVE_SYMBOL_NODE
   does the work (overloads, members, the wanted type); in C a symbol of storage class 0Fh
   (probably an enumerator) becomes an int constant of its value.  A leaf with no symbol
   comes back as it is */
u16 RESOLVE_SYMBOL_REFERENCE(u16 expression, u16 type)
{
    if ((EXPR_B(expression, EXPR_NODE_FLAGS) & 1) || !LEFT(expression))
        return expression;
    u16 symbol = LEFT(expression);
    EXPR_W(expression, EXPR_TYPE) = SYM_W(symbol, SYM_TYPE);
    if (CPP_MODE)
        return RESOLVE_SYMBOL_NODE(expression, type);
    if ((SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) == 0x0F) {
        FREE_EXPR_NODE(expression);
        expression = MAKE_INT_CONSTANT(SYM_W(symbol, SYM_TYPE), (i32)(i16)SYM_W(symbol, SYM_CONST_VALUE));
    }
    EXPR_B(expression, EXPR_NODE_FLAGS) |= 1;
    return expression;
}

/* 1 for a symbol leaf of storage class 6 with SYM_FLAGS bit 20h (probably a parameter
   with some special property); such arms of ?: are always read as rvalues.  A whole word,
   of which the callers test the low byte */
i16 C78_special_symbol(u16 expression)
{
    if (EXPR_W(expression, EXPR_OP) == 1 && (SYM_B(LEFT(expression), SYM_STORAGE_CLASS) >> 3) == 6 &&
        (SYM_B(LEFT(expression), SYM_FLAGS) & 0x20))
        return 1;
    return 0;
}

/* parent = cond ? (first : second), parent's operator ?: or 45h, its right operand the :
   node.  The condition must be scalar; the arms are analysed with the wanted type
   (CONDITIONAL_ARM_DEPTH counts the nesting).  The arms stay lvalues only when both are
   references; void arms give a void result; with operator 45h (probably a conditional
   the compiler made, whose value is not used) and a void wanted type both arms become
   void.  Otherwise the arms are balanced to a common type, pointer arms must have
   compatible targets, and a pointer result gets both targets' const and volatile bits.
   The node always ends as ?: */
u16 C78_reconcile_pair(u16 parent, u16 type)
{
    u16 first = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(LEFT(parent), 0, 0));
    if (CPP_MODE)
        first = CONVERT_CLASS_TO_SCALAR(first);
    if (KIND_OF(first) == TK_VOID)
        first = REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, first);
    else if (!(FLAGS_OF(first) & 7))
        first = REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SCALAR_TYPE, first);
    LEFT(parent) = first;
    u16 tree = RIGHT(parent);
    ++CONDITIONAL_ARM_DEPTH;
    first = ANALYZE_EXPRESSION(LEFT(tree), type, 0);
    u16 second = ANALYZE_EXPRESSION(RIGHT(tree), type, 0);
    --CONDITIONAL_ARM_DEPTH;

    if (!(reference(TYPE_OF(first)) && reference(TYPE_OF(second))) ||
        (u8)C78_special_symbol(first) || (u8)C78_special_symbol(second)) {
        first = CONVERT_TO_RVALUE(first);
        second = CONVERT_TO_RVALUE(second);
    }
    LEFT(tree) = first;
    RIGHT(tree) = second;
    u8 first_missing = !first || KIND_OF(first) == TK_VOID;
    u8 second_missing = !second || KIND_OF(second) == TK_VOID;
    /* read even when first is 0, as in the original */
    u16 selected_type = TYPE_OF(first);
    if (first_missing && second_missing)
        selected_type = VOID_TYPE;
    else if (EXPR_W(parent, EXPR_OP) != EOP_QUESTION && TYPE_W(type, TYPE_KIND) == TK_VOID) {
        selected_type = VOID_TYPE;
        u16 arm = CONVERT_EXPR_TO_TYPE(VOID_TYPE, first, 0);
        LEFT(tree) = arm;
        arm = CONVERT_EXPR_TO_TYPE(VOID_TYPE, second, 0);
        RIGHT(tree) = arm;
    } else if (!first_missing && !second_missing) {
        if (KIND_OF(first) == TK_ENUM && TYPES_COMPATIBLE(TYPE_OF(first), TYPE_OF(second), 1))
            selected_type = TYPE_OF(first);
        else {
            tree = BALANCE_BINARY_OPERANDS(type, tree);
            selected_type = TYPE_OF(tree);
            first = LEFT(tree);
            second = RIGHT(tree);
        }
    }

    u16 first_type, second_type;
    if (selected_type != VOID_TYPE && EXPR_W(parent, EXPR_OP) == EOP_QUESTION) {
        if ((FLAGS_OF(first) & 0x14) && (FLAGS_OF(second) & 0x14)) {
            first_type = TYPE_W(TYPE_OF(first), TYPE_TARGET);
            second_type = TYPE_W(TYPE_OF(second), TYPE_TARGET);
        } else {
            first_type = TYPE_OF(first);
            second_type = TYPE_OF(second);
        }
        if (!TYPES_COMPATIBLE(first_type, second_type, 1))
            return REPORT_EXPR_ERROR_PLAIN(MSG_TWO_OPERANDS_MUST, parent);
    }

    EXPR_W(parent, EXPR_OP) = EOP_QUESTION;
    if (EXPR_FLAGS_AT(TYPE_W(selected_type, TYPE_KIND)) & 0x14) {
        first_type = TYPE_OF(first);
        if ((EXPR_FLAGS_AT(TYPE_W(first_type, TYPE_KIND)) & 0x14) &&
            TYPE_W(TYPE_W(first_type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION) {
            if (TYPE_B(TYPE_W(first_type, TYPE_TARGET), TYPE_FUNC_FLAGS) & 8)
                selected_type = TYPE_OF(second);
            else
                selected_type = first_type;
        } else {
            first_type = TYPE_W(first_type, TYPE_TARGET);
            second_type = TYPE_W(TYPE_OF(second), TYPE_TARGET);
            u8 attrs = TYPE_B(first_type, TYPE_ATTRS) | TYPE_B(second_type, TYPE_ATTRS);
            first_type = ADD_CV_QUALIFIERS(TYPE_W(selected_type, TYPE_TARGET), attrs & 2, attrs & 1);
            selected_type = MAKE_POINTER_TYPE(first_type, TYPE_W(selected_type, TYPE_KIND),
                                              (TYPE_B(selected_type, TYPE_ATTRS) & 0x20) != 0);
        }
        EXPR_W(tree, EXPR_TYPE) = selected_type;
    }
    EXPR_W(parent, EXPR_TYPE) = selected_type;
    EXPR_B(tree, EXPR_NODE_FLAGS) |= 1;
    EXPR_B(parent, EXPR_NODE_FLAGS) |= 1;
    return parent;
}

/* a cast node (operator 35h) to the type stored in it: in C++ CAST_EXPRESSION may handle
   it (class conversions); else the operand is analysed with the target type as the wanted
   type, read as an rvalue unless the cast is to a reference, and CHECK_CAST checks the
   conversion */
u16 C78_lower_value(u16 expression, u16 type)
{
    u16 result = CPP_MODE ? CAST_EXPRESSION(expression, type) : 0;
    if (!result) {
        result = ANALYZE_EXPRESSION(LEFT(expression), TYPE_OF(expression), 0);
        if (!(FLAGS_OF(expression) & 0x14) || !(TYPE_B(TYPE_OF(expression), TYPE_ATTRS) & 0x20))
            result = CONVERT_TO_RVALUE(result);
        LEFT(expression) = result;
        result = CHECK_CAST(expression);
    }
    return result;
}

/* an int constant wanted as a smaller integer type (char, short) takes that type when its
   value survives the truncation, so that for example c == 'a' can be done on bytes */
u16 C78_apply_value_type(u16 expression, u16 type)
{
    if (!type || !(EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 1) || (i16)TYPE_W(type, TYPE_KIND) >= TK_INT ||
        KIND_OF(expression) != TK_INT)
        return expression;
    i32 converted = token_convert(EXPR_L(expression, EXPR_VALUE), (i16)TYPE_W(type, TYPE_KIND));
    if (EXPR_L(expression, EXPR_VALUE) == converted)
        EXPR_W(expression, EXPR_TYPE) = type;
    EXPR_B(expression, EXPR_NODE_FLAGS) |= 1;
    return expression;
}

/* sizeof expr: the operand analysed, bitfields and functions refused, a reference looked
   through, and the whole node replaced by a size_t constant (a 0 size is an error) */
static u16 analyze_sizeof(u16 expression)
{
    u16 child = ANALYZE_EXPRESSION(LEFT(expression), 0, 0);
    LEFT(expression) = child;
    if (EXPR_W(child, EXPR_OP) == EOP_DOT && EXPR_W(RIGHT(child), EXPR_OP) == 0x39 &&
        (EXPR_B(RIGHT(child), EXPR_NODE_FLAGS) & 4))
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZEOF_MAY_NOT_APPLIED, expression);
    if (EXPR_W(child, EXPR_OP) == 0) {
        FREE_EXPR_NODE(expression);
        return child;
    }
    u16 child_type = TYPE_OF(child);
    if (reference(child_type))
        child_type = TYPE_W(child_type, TYPE_TARGET);
    if (EXPR_W(child, EXPR_OP) == EOP_DOT && (EXPR_B(RIGHT(child), EXPR_NODE_FLAGS) & 4))
        expression = REPORT_EXPR_ERROR_PLAIN(MSG_SIZEOF_MAY_NOT_APPLIED, expression);
    if (TYPE_W(child_type, TYPE_KIND) == TK_FUNCTION)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZEOF_MAY_NOT_APPLIED_257, expression);
    u16 size_t_type = SIZE_T_TYPE;
    i32 size = token_convert(TYPE_SIZE(child_type), (i16)TYPE_W(SIZE_T_TYPE, TYPE_KIND));
    u16 result = MAKE_INT_CONSTANT(size_t_type, size);
    FREE_EXPR_TREE(expression);
    expression = result;
    if (!TYPE_SIZE(child_type))
        expression = REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, expression);
    return expression;
}

/* expression analysed with the wanted type; returns the analysed tree (perhaps another
   node, an error node, or 0 for 0).  Operators not listed are already in their final
   form when they get here */
u16 ANALYZE_EXPRESSION(u16 expression, u16 type, u16 context)
{
    if (!expression || ((EXPR_B(expression, EXPR_NODE_FLAGS) & 1) && EXPR_W(expression, EXPR_OP) != EOP_CONST))
        return expression;
    switch (EXPR_W(expression, EXPR_OP)) {
    case EOP_DEREF:
        expression = BUILD_DEREF(expression, context, reference(type));
        break;
    case EOP_ADDR: case 0x42:
        expression = BUILD_ADDRESS_OF(expression, context, type);
        break;
    case EOP_INC: case EOP_DEC:
        expression = BUILD_INCDEC(expression, context);
        break;
    case EOP_NEG: case 0x49:
        expression = BUILD_UNARY_ARITH(expression, context, type);
        break;
    case EOP_COMPL:
        expression = BUILD_COMPLEMENT(expression, context, type);
        break;
    case EOP_NOT:
        expression = BUILD_LOGICAL_NOT(expression, context);
        break;
    case EOP_INDEX:
        expression = CHECK_SUBSCRIPT(expression, context);
        break;
    case EOP_DOT:
        expression = CHECK_DOT_MEMBER(expression, 0);
        break;
    case EOP_DOT_STAR:
        expression = ANALYZE_DOT_STAR(expression);
        break;
    case EOP_ARROW:
        expression = CHECK_POINTER_INDIRECTION(expression, context, 0x3B);
        break;
    case EOP_ARROW_STAR:
        expression = CHECK_POINTER_INDIRECTION(expression, context, 0x3C);
        break;
    case EOP_MUL: case EOP_DIV:
        expression = CHECK_MULTIPLICATIVE_OP(expression, context, type, 3);
        break;
    case EOP_MOD: case EOP_AND: case EOP_OR: case EOP_XOR:
        expression = CHECK_MULTIPLICATIVE_OP(expression, context, type, 1);
        break;
    case EOP_SHL: case EOP_SHR:
        expression = CHECK_INTEGRAL_OP(expression, context);
        break;
    case EOP_ADD:
        expression = CHECK_ADDITION(expression, context, type);
        break;
    case EOP_SUB:
        expression = CHECK_SUBTRACTION(expression, context, type);
        break;
    case EOP_ANDAND: case EOP_OROR:
        expression = CHECK_LOGICAL_OP(expression, context);
        break;
    case EOP_EQ: case EOP_NE: case EOP_GT: case EOP_LT: case EOP_GE: case EOP_LE:
        expression = CHECK_COMPARISON(expression, context);
        break;
    case EOP_ASSIGN:
        expression = CHECK_ASSIGNMENT(expression);
        break;
    case 0x47:
        expression = CHECK_INITIALIZATION(expression);
        break;
    case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN: case EOP_DIV_ASSIGN:
        expression = CHECK_COMPOUND_ASSIGNMENT(expression, context, 7);
        break;
    case EOP_MOD_ASSIGN: case EOP_SHL_ASSIGN: case EOP_SHR_ASSIGN:
    case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN:
        expression = CHECK_COMPOUND_ASSIGNMENT(expression, context, 1);
        break;
    case EOP_COMMA:
        expression = ANALYZE_COMMA_EXPR(expression, context, type);
        break;
    case EOP_NEW:
        expression = ANALYZE_NEW_EXPRESSION(expression);
        break;
    case EOP_DELETE:
        expression = ANALYZE_DELETE_EXPRESSION(expression);
        break;
    case 0x46:
        expression = CHECK_RETURN_VALUE(expression);
        break;
    case 0x36:
        expression = ANALYZE_CALL(expression, context);
        break;
    case 0x35:
        expression = C78_lower_value(expression, context);
        break;
    case 0x37:
        expression = ANALYZE_TEMP_OBJECT_NODE(expression, context);
        break;
    case EOP_QUESTION: case 0x45:
        expression = C78_reconcile_pair(expression, type);
        break;
    case EOP_SIZEOF:
        expression = analyze_sizeof(expression);
        break;
    case 0x4A:
        EXPR_W(expression, EXPR_TYPE) = MEMBER_W(LEFT(expression), MEMB_TYPE);
        break;
    case 1:
        expression = RESOLVE_SYMBOL_REFERENCE(expression, type);
        break;
    case EOP_CONST:
        expression = C78_apply_value_type(expression, type);
        break;
    default:
        break;
    }
    EXPR_B(expression, EXPR_NODE_FLAGS) |= 1;
    return expression;
}

/* ANALYZE_EXPRESSION, then CONVERT_TO_RVALUE unless the value is discarded (type
   VOID_TYPE): the usual entry when a value is needed */
u16 ANALYZE_AND_DECAY(u16 expression, u16 type)
{
    u16 result = ANALYZE_EXPRESSION(expression, type, 0);
    if (type != VOID_TYPE)
        result = CONVERT_TO_RVALUE(result);
    return result;
}

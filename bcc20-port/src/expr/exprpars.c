/* exprpars.c: from bcc20/src/expr/EXPRPARS.C: the expression parser of the C front end
   (STMTC.C's side), which checks types as it parses: every operator node is built through
   TYPECHECK_OPERATOR, which inserts the conversions and reports errors at once, from the
   C front end's node constructors (EXPRMAKE.C, through NEW_EXPR_NODE_HOOK and the other
   hooks).  An error gives the error node STCVT8() (operator 0, kind 0), which later checks
   pass through quietly.  STEVALN is a precedence-climbing parser for binary operators;
   STUNARY parses prefix operators, primary expressions and the postfix chain;
   PARSE_CONSTANT_EXPR wraps it for constant expressions (array bounds, bitfields,
   enumerators, case labels, #if), leaving the value in TOKEN_CONST_VALUE.

   The parser works on TOKEN_TYPE (the current token) with one pushed-back token
   (TOKEN_PUSHED_BACK); a constant's or identifier's value is in TOKEN_CONST_VALUE, its
   kind in TOKEN_AUX.  Tokens (TOKEN.H): 1 (, 2 ), 3 [, 4 ], 8 comma, 16h +, 17h -, 18h *,
   1Bh &, 21h :, 2Ah !, 2Bh ~, 2Ch sizeof, 2Dh ++, 2Eh --, 2Fh ., 30h ->, 31h identifier,
   32h and 65h integer constants, 33h floating constant, 34h string literal, 9 "...".  The
   original is written with register pseudo-variables to keep its register use; here they
   are ordinary locals.  STEVALN's "out of memory" stack check is STACK_CHECK
   (native/stack.c). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"
#include "stack.h"

#define OP(n) EXPR_W((n), EXPR_OP)
#define KIND(n) EXPR_W((n), EXPR_KIND)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define TYPE_OF(n) EXPR_W((n), EXPR_TYPE)
#define FLAGS(n) EXPR_FLAGS_AT(KIND(n))
#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_AUX SB(TOKEN_AUX_P)
#define TOKEN_CONST_VALUE D(TOKEN_CONST_VALUE_P)
#define LOW W(TOKEN_CONST_VALUE_P)
#define DIAG_NAME_BUFFER W(DIAG_NAME_BUFFER_P)
#define OPTION_CALLING_CONVENTION B(OPTION_CALLING_CONVENTION_P)
#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define KIND_INFO(i) SB(fp_add(KIND_INFO_TABLE_P, (i)))
#define RANGE_MIN(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8))
#define RANGE_MAX(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8 + 4))
#define TOKEN_RECORD_SIZE 19
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)

/* the hooks */
static u16 mode_type(u16 kind) { return (u16)CALL_FAR(MODE_HOOK, A16(kind)); }
static u16 new_node(u16 op, u16 type, u16 left, u16 right)
{
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(op), A16(type), A16(left), A16(right));
}
static u16 new_const(u16 type, u32 value)
{
    return (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(type), A32(value));
}
static u16 size_of_type(u16 type) { return (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type)); }
static u16 decay(u16 type, u16 node, i16 flag)
{
    return (u16)CALL_FAR(DECAY_TO_POINTER_HOOK, A16(type), A16(node), A16((u16)flag));
}

/* the next token: the pushed-back one, or a new one from the lexer */
static u16 next_token(void)
{
    if (TOKEN_PUSHED_BACK) {
        TOKEN_PUSHED_BACK = 0;
        return TOKEN_TYPE;
    }
    return (u16)LEX_NEXT_TOKEN();
}

/* a whole expression (with commas unless mode stops them); unary is an identifier the
   caller already read, or 0 */
u16 PARSE_EXPRESSION(u16 unary, i16 mode)
{
    return STEVALN(0, unary, mode, 0, 2);
}

/* precedence climbing: a unary expression, then binary operators of priority at least
   minimum (equal only for right-associative levels), the right operand parsed with the
   operator's priority.  mode: which token ends the expression besides the usual ones (1
   an argument list, where commas build list cells 2Bh; 2 a comma; 3 ':' in the middle of
   ?:; 4 token 10, the end of a #if line).  previous is the operator left of this operand,
   for the "ambiguous operators need parentheses" warning.  0 after a syntax error */
u16 STEVALN(i16 minimum, u16 unary, i16 mode, i16 previous, u16 context)
{
    STACK_CHECK(STEVALN);     /* if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY): native/stack.c */
    u16 left = STUNARY(unary, context);
    if (!left)
        return 0;
    i16 associativity = LEVEL_ASSOCIATIVITY_AT(minimum);
    for (;;) {
        i16 token = (i16)TOKEN_TYPE;
        if (token > 0x29 || (mode == 4 && token == 10) || (mode == 2 && token == 8) || (mode == 3 && token == 0x21))
            break;
        i16 priority = BINARY_PRIORITY_BY_TOKEN_AT(token);
        if (!priority)
            break;
        i16 op = OPERATOR_BY_TOKEN_AT(token);
        u16 line = CURRENT_LINE;
        LOGICAL_LINE = line;
        if (op != previous && minimum >= 7 && priority >= 7 &&
            ((minimum <= 12 && priority <= 12) || (minimum == 13 && priority == 12) || (minimum == 12 && priority == 13)))
            REPORT_WARNING(MSG_AMBIGUOUS_OPERATORS);
        if (minimum > priority || (minimum == priority && associativity == 1))
            break;
        u16 right;
        if (op == 0x25) {       /* ?: the middle up to ':', then the right at TERNARY_ELSE_LEVEL */
            next_token();
            right = STEVALN(0, 0, 3, 0, context);
            if (!right)
                return 0;
            if (TOKEN_TYPE != 0x21) {
                REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
                return 0;
            }
            next_token();
            u16 temp = STEVALN(TERNARY_ELSE_LEVEL, 0, mode, 0, context);
            if (!temp)
                return 0;
            LOGICAL_LINE = line;
            right = TYPECHECK_OPERATOR(0x26, right, temp);
            left = TYPECHECK_OPERATOR(0x25, left, right);
        } else {
            next_token();
            right = STEVALN(priority, 0, mode, op, context);
            if (!right)
                return 0;
            LOGICAL_LINE = line;
            if (op == 0x2A)     /* the comma operator: in an argument list a list cell */
                left = mode == 1 ? new_node(0x2B, PLAIN_INT_TYPE, left, right) : new_node(0x2A, TYPE_OF(right), left, right);
            else
                left = TYPECHECK_OPERATOR(op, left, right);
        }
    }
    return left;
}

/* sizeof's constant: unsigned, or unsigned long (MODE_HOOK(8)) for a huge array */
static u16 size_constant(u16 type)
{
    u16 mode = (TYPE_B(type, TYPE_KIND) == 0x11 && TYPE_B(type, TYPE_C_BYTE9)) ? 8 : 6;
    return new_const(mode_type(mode), TOKEN_CONST_VALUE);
}

/* the operand of a prefix operator */
#define READ_UNARY() do { next_token(); node = STUNARY(0, context); if (!node) return 0; } while (0)

/* a unary expression: a prefix operator on a unary expression, sizeof, a cast, a
   parenthesised expression, a constant, a string literal, an identifier (or, with name
   nonzero, the one the caller read), followed by any postfix operators.  context nonzero:
   string literals are emitted into the data being built (initialisers, probably).  0
   after a syntax error */
u16 STUNARY(u16 name, u16 context)
{
    u16 node, other, type;
    LOGICAL_LINE = CURRENT_LINE;
    if (name)
        goto named;
    switch (TOKEN_TYPE) {
    /* prefix * & - ! ~ + ++ --: ++x and --x are built as x += 1 and x -= 1 */
    case 0x18:
        READ_UNARY();
        node = TYPECHECK_OPERATOR(0x31, node, 0);
        goto postfix;
    case 0x1B:
        READ_UNARY();
        node = TYPECHECK_OPERATOR(0x32, node, 0);
        goto postfix;
    case 0x17:
        READ_UNARY();
        node = TYPECHECK_OPERATOR(0x2E, node, 0);
        goto postfix;
    case 0x16:
        READ_UNARY();
        if (KIND(node) == 0)
            goto postfix;
        if (STCVTB(node, 0x10)) {
            node = STCVT8();
            goto postfix;
        }
        node = STCVT6(node);
        goto postfix;
    case 0x2A:
        READ_UNARY();
        node = TYPECHECK_OPERATOR(0x30, node, 0);
        goto postfix;
    case 0x2B:
        READ_UNARY();
        node = TYPECHECK_OPERATOR(0x2F, node, 0);
        goto postfix;
    case 0x2D:
        READ_UNARY();
        other = new_const(PLAIN_INT_TYPE, 1);
        node = TYPECHECK_OPERATOR(0x13, node, other);
        goto postfix;
    case 0x2E:
        READ_UNARY();
        other = new_const(PLAIN_INT_TYPE, 1);
        node = TYPECHECK_OPERATOR(0x14, node, other);
        goto postfix;
    /* sizeof (type) or sizeof expr */
    case 0x2C:
        if (next_token() == 1) {
            u16 token = next_token();
            if (TOKEN_STARTS_TYPE(token)) {
                type = PARSE_TYPE_NAME_PAREN();
                if (!type)
                    return 0;
                TOKEN_CONST_VALUE = size_of_type(type);
                if (!TOKEN_CONST_VALUE)
                    REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
                node = size_constant(type);
                goto postfix;
            }
            other = STEVALN(0, 0, 0, 0, 0);
            if (!other)
                return 0;
            if (TOKEN_TYPE != 2) {
                REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
                return 0;
            }
            next_token();
        } else {
            other = STUNARY(0, context);
            if (!other)
                return 0;
        }
        if (OP(other) == 0x32 && (KIND(LEFT(other)) == 0x11 || KIND(LEFT(other)) == 0x12))
            type = TYPE_OF(LEFT(other));
        else if (OP(other) == 0x33) {
            REPORT_ERROR(MSG_SIZEOF_MAY_NOT_APPLIED);
            type = PLAIN_INT_TYPE;
        } else
            type = TYPE_OF(other);
        if (TYPE_B(type, TYPE_KIND) == 0x12) {
            REPORT_ERROR(MSG_SIZEOF_MAY_NOT_APPLIED_257);
            TOKEN_CONST_VALUE = 1;
        } else {
            TOKEN_CONST_VALUE = size_of_type(type);
            if (!TOKEN_CONST_VALUE)
                REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
        }
        node = size_constant(type);
        goto postfix;
    /* ( type ) cast, or a parenthesised expression */
    case 1: {
        u16 token = next_token();
        if (TOKEN_STARTS_TYPE(token)) {
            type = PARSE_TYPE_NAME_PAREN();
            if (!type)
                return 0;
            node = STUNARY(0, context);
            if (!node)
                return 0;
            other = CONVERT_EXPRESSION_TYPE(node, type);
            if (!other) {
                if (KIND(node) == 12)
                    REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
                else
                    REPORT_INCOMPATIBLE_TYPE();
                goto postfix;
            }
            node = other;
            goto postfix;
        }
        node = STEVALN(0, 0, 0, 0, context);
        if (!node)
            return 0;
        if (TOKEN_TYPE != 2) {
            REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
            return 0;
        }
        next_token();
        goto postfix;
    }
    /* "..." in a variadic function: the address of the unnamed arguments */
    case 9:
        if (LANGUAGE_MODE == 1 || C_DECL_SCOPE == C_GLOBAL_SCOPE ||
            !(TYPE_B(CSYM_W(C_CURRENT_FUNCTION_SYMBOL, CSYM_TYPE), TYPE_C_FUNC_FLAGS) & 4))
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
        node = NEW_EXPR_LEAF(7, PLAIN_INT_TYPE, 0);
        node = TYPECHECK_OPERATOR(0x32, node, 0);
        next_token();
        goto postfix;
    case 0x31:
        name = LOW;
        next_token();
        goto named;
    case 0x32: case 0x65:
        node = new_const(mode_type((u16)(i16)TOKEN_AUX), TOKEN_CONST_VALUE);
        next_token();
        goto postfix;
    case 0x33:
        if (MACRO_MODE && LANGUAGE_MODE == 1) {
            REPORT_AND_SKIP(MSG_ILLEGAL_USE_FLOATING, 0);
            return 0;
        }
        node = NEW_REAL_CONSTANT_NODE(TOKEN_CONST_VALUE_P, mode_type((u16)(i16)TOKEN_AUX));
        next_token();
        goto postfix;
    /* adjacent string literals concatenated into the byte pool: an array of char at an
       offset in C_STRING_LITERAL_SYMBOL, decayed to a pointer */
    case 0x34: {
        u16 start = BYTE_POOL_LENGTH(), count = 0;
        do {
            BCC_LEX_RESTORE((i16)context);
            count += LOW;
        } while (next_token() == 0x34);
        if (context) {
            EMIT_VALUE(0);
            if (OPTION_MERGE_STRINGS)
                start = MERGE_DUPLICATE_BYTES(start);
        }
        type = NEW_ARRAY_TYPE((i32)(u16)(count + 1), STRING_CHAR_TYPE, 0);
        node = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(1), A16(type), A16(C_STRING_LITERAL_SYMBOL), A16(start), A16(4));
        node = decay(TYPE_W(type, TYPE_TARGET), node, 0);
        goto postfix;
    }
    default:
        REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
        return 0;
    }
named:
    STDEFARG(name);
    node = RESOLVE_IDENTIFIER(name);
postfix:
    for (;;) {
        switch (TOKEN_TYPE) {
        case 0x2D:
            node = TYPECHECK_OPERATOR(0x23, node, 0);
            break;
        case 0x2E:
            node = TYPECHECK_OPERATOR(0x24, node, 0);
            break;
        case 3:
            next_token();
            other = STEVALN(0, 0, 0, 0, context);
            if (!other)
                return 0;
            if (TOKEN_TYPE != 4) {
                REPORT_AND_SKIP(MSG_MISSING, STR_SUBSCRIPTING_2_P);
                return 0;
            }
            node = BUILD_SUBSCRIPT(node, other);
            break;
        case 1:
            if (next_token() == 2)
                other = 0;
            else {
                other = STEVALN(0, 0, 1, 0, context);
                if (!other)
                    return 0;
                if (TOKEN_TYPE != 2) {
                    REPORT_AND_SKIP(MSG_FUNCTION_CALL_MISSING, 0);
                    return 0;
                }
            }
            LOGICAL_LINE = CURRENT_LINE;
            node = BUILD_FUNCTION_CALL(node, other);
            break;
        /* object.member: the object a struct; its address taken (a temporary address for a
           non-lvalue such as a function result) and handled as p->member */
        case 0x2F:
            if (next_token() != 0x31) {
                REPORT_AND_SKIP(MSG_INVALID_USE_DOT, 0);
                return 0;
            }
            LOGICAL_LINE = CURRENT_LINE;
            if (KIND(node) == 0)
                break;
            if (KIND(node) != 0x13) {
                REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
                node = STCVT8();
                break;
            }
            if (!IS_ADDRESSABLE_EXPR(node)) {
                if (OP(node) == 0x2A) {
                    u16 pointer = PTR_TYPE_FOR_MODIFIER(TYPE_OF(node), 0, 0, 0);
                    u16 address = new_node(0x32, pointer, RIGHT(node), 0);
                    RIGHT(node) = address;
                    EXPR_W(node, EXPR_KIND) = KIND(RIGHT(node));
                    EXPR_W(node, EXPR_TYPE) = TYPE_OF(RIGHT(node));
                } else {
                    u16 pointer = NEW_POINTER_TYPE(TYPE_OF(node), 13, 0, 0, 3);
                    node = new_node(0x32, pointer, node, 0);
                }
            } else
                node = TYPECHECK_OPERATOR(0x32, node, 0);
            node = STCVT9(node, LOW, C_DECL_SCOPE);
            if (node)
                break;
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_UNDEFINED_SYMBOL, NAME_TEXT_COPY(LOW));
            node = STCVT8();
            break;
        case 0x30:
            if (next_token() != 0x31) {
                REPORT_AND_SKIP(MSG_FIELD_IDENTIFIER, 0);
                return 0;
            }
            LOGICAL_LINE = CURRENT_LINE;
            if (KIND(node) == 0)
                break;
            if (!(FLAGS(node) & 0x14) || TYPE_B(TYPE_W(TYPE_OF(node), TYPE_C_TARGET), TYPE_KIND) != 0x13) {
                REPORT_ERROR(MSG_POINTER_REQUIRED_LEFT);
                node = STCVT8();
                break;
            }
            node = STCVT9(node, LOW, C_DECL_SCOPE);
            if (!node) {
                DIAG_NAME_BUFFER = 0;
                REPORT_ERROR(MSG_UNDEFINED_SYMBOL, NAME_TEXT_COPY(LOW));
                node = STCVT8();
            }
            break;
        default:
            return node;
        }
        next_token();
    }
}
#undef READ_UNARY

/* an undeclared identifier called (followed by '(') is declared an extern function of
   IMPLICIT_FUNCTION_TYPE (int f()) with the default calling convention and code model,
   with "no declaration for function" unless WARN_PRO_FLAG is set */
void STDEFARG(u16 name)
{
    if (TOKEN_TYPE == 1 && !LOOKUP_SYMBOL(name, C_DECL_SCOPE, 0)) {
        if (!WARN_PRO_FLAG) {
            DIAG_NAME_BUFFER = 0;
            REPORT_WARNING(MSG_NO_DECLARATION, NAME_TEXT_COPY(name));
        }
        u16 flags = 0;
        if (OPTION_CALLING_CONVENTION == 1)
            flags = 0x400;
        else if (OPTION_CALLING_CONVENTION == 2)
            flags = 0x2000;
        if (MODEL_FAR_CODE)
            flags |= 0x10;
        DECLARE_SYMBOL(name, C_DECL_SCOPE, 0, 2, IMPLICIT_FUNCTION_TYPE, MODEL_FAR_CODE ? 0xFFFF : CODE_SEGMENT_ID, flags);
    }
}

/* "type-name )" after a '(' (casts and sizeof); a storage class is an error */
u16 PARSE_TYPE_NAME_PAREN(void)
{
    u16 stmt = BCC_STMT_BUILD();
    if (C_DECL_STORAGE_CLASS)
        REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258, DSPTR(STORAGE_CLASS_NAMES_AT(C_DECL_STORAGE_CLASS)));
    if (!stmt)
        return 0;
    u16 type = PARSE_ABSTRACT_DECLARATOR();
    if (!type)
        return 0;
    if (TOKEN_TYPE != 2) {
        REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
        return 0;
    }
    next_token();
    return BCC_STMT_BIND_TYPE(type, stmt);
}

/* a constant expression, its value in TOKEN_CONST_VALUE (0 after an error).  mode: 1
   array bound (then ]), 2 bitfield width or initialiser (, or ;), 4 enumerator value (, or
   }), 5 #if line, 3 case label (:).  0 after a syntax error, else 1.  The nodes are freed
   when the pool was empty on entry */
u16 PARSE_CONSTANT_EXPR(u16 mode)
{
    u16 active = (u16)EXPR_POOL_IS_RESET();
    u16 node = 0;       /* unset in the original for another mode */
    switch (mode) {
    case 1:
        node = STEVALN(0, 0, 0, 0, 2);
        if (TOKEN_TYPE != 4) {
            REPORT_AND_SKIP(MSG_MISSING, STR_ARRAY_BOUNDS_2_P);
            return 0;
        }
        next_token();
        break;
    case 2:
        node = STEVALN(0, 0, 2, 0, 2);
        if (TOKEN_TYPE != 8 && TOKEN_TYPE != 7) {
            REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
            return 0;
        }
        break;
    case 4:
        node = STEVALN(0, 0, 2, 0, 2);
        if (TOKEN_TYPE != 8 && TOKEN_TYPE != 6) {
            REPORT_AND_SKIP(MSG_ENUM_SYNTAX_ERROR, 0);
            return 0;
        }
        break;
    case 5:
        MACRO_MODE = 1;
        next_token();
        node = STEVALN(0, 0, 4, 0, 2);
        MACRO_MODE = 0;
        if (TOKEN_TYPE != 10) {
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
            TOKEN_CONST_VALUE = 0;
            return 0;
        }
        break;
    case 3:
        node = STEVALN(0, 0, 3, 0, 2);
        if (TOKEN_TYPE != 33) {
            REPORT_ERROR(MSG_CASE_STATEMENT_MISSING);
            TOKEN_CONST_VALUE = 0;
            return 1;
        }
        break;
    }
    node = FOLD_EXPRESSION(node);
    if (KIND(node) == 0)
        TOKEN_CONST_VALUE = 0;
    else if (OP(node) == 2)
        TOKEN_CONST_VALUE = (u32)EXPR_L(node, EXPR_LEFT);
    else {
        REPORT_ERROR(MSG_CONSTANT_EXPRESSION);
        TOKEN_CONST_VALUE = 0;
    }
    if (active)
        CALL_FAR0(RESET_EXPR_POOL_HOOK);
    return 1;
}

/* the expression for a name: a symbol leaf (arrays and functions decayed by STCVTC).  An
   undefined name is 0 inside #if; else it is reported and entered as a class-9 symbol of
   MODE_HOOK(0) type, probably so that it is reported once */
u16 RESOLVE_IDENTIFIER(u16 name)
{
    u16 found = BUILD_SYMBOL_OPERAND(name, C_DECL_SCOPE, 0);
    if (!found) {
        if (MACRO_MODE)
            return new_const(PLAIN_INT_TYPE, 0);
        DIAG_NAME_BUFFER = 0;
        REPORT_ERROR(MSG_UNDEFINED_SYMBOL, NAME_TEXT_COPY(name));
        DECLARE_SYMBOL(name, C_DECL_SCOPE, 0, 9, mode_type(0), 0, 0);
        return STCVT8();
    }
    return STCVTC(found);
}

/* a[i] (either operand the pointer) as *(a + i * element size); _seg pointers go through
   TYPECHECK_OPERATOR's + */
u16 BUILD_SUBSCRIPT(u16 left, u16 right)
{
    if (!TYPE_OF(left))
        return left;
    if (!TYPE_OF(right))
        return right;
    if (KIND(left) == TK_SEG_PTR || KIND(right) == TK_SEG_PTR)
        right = TYPECHECK_OPERATOR(8, left, right);
    else if (FLAGS(left) & 0x14) {
        right = SCALE_INDEX(right, left);
        right = new_node(8, TYPE_OF(left), left, right);
    } else {
        left = SCALE_INDEX(left, right);
        right = new_node(8, TYPE_OF(right), right, left);
    }
    return TYPECHECK_OPERATOR(0x31, right, 0);
}

/* the index left converted to int (long for a huge pointer right) and multiplied by
   right's element size (operator 10) */
u16 SCALE_INDEX(u16 left, u16 right)
{
    u16 type = mode_type(KIND(right) == 16 ? 7 : 5);
    left = STASSIGN(left, type);
    return new_node(10, type, left, STCVT5(right));
}

/* the default argument promotions of a call without a prototype over the argument list:
   float to double, small integers and enums to int; a struct argument gets "structure
   passed by value" */
u16 PROMOTE_CALL_ARGS(u16 expression)
{
    u16 item;
    if (!expression)
        return 0;
    if (OP(expression) == 0x2B) {
        u16 rest = PROMOTE_CALL_ARGS(LEFT(expression));
        LEFT(expression) = rest;
        item = RIGHT(expression);
    } else
        item = expression;
    if (KIND(item) == TK_STRUCT)
        REPORT_WARNING(MSG_STRUCTURE_PASSED_VALUE);
    else {
        if (KIND(item) == TK_FLOAT)
            item = CONVERT_EXPRESSION_TYPE(item, mode_type(10));
        else
            item = STCVT6(item);
        if (OP(expression) == 0x2B)
            RIGHT(expression) = item;
        else
            expression = item;
    }
    return expression;
}

/* expression converted to target as assignment does it, with C's warnings: integer to
   pointer ("nonportable pointer conversion", an error for long to a short pointer),
   pointers losing const or volatile or to other types ("suspicious pointer conversion",
   or "mixing pointers to signed and unsigned char"), long to int ("conversion may lose
   significant digits"); arrays, functions and structs as targets are "incompatible type".
   The literal 0 converts to any pointer silently */
u16 STASSIGN(u16 expression, u16 target)
{
    if (OP(expression) == 0)
        return expression;
    u16 old_type = TYPE_OF(expression);
    if (old_type == target)
        return expression;
    expression = FOLD_EXPRESSION(expression);
    i16 old_kind = (i16)KIND(expression);
    i16 kind = TYPE_B(target, TYPE_KIND);
    switch (kind) {
    case 12:
        return CONVERT_EXPRESSION_TYPE(expression, target);
    case 17: case 18: case 19:
        REPORT_INCOMPATIBLE_TYPE();
        return expression;
    case 13: case 14: case 15: case 16:
        expression = NARROW_FAR_POINTER(expression);
        old_kind = (i16)KIND(expression);
        old_type = TYPE_OF(expression);
        if (OP(expression) == 2 && EXPR_L(expression, EXPR_LEFT) == 0 && (old_kind != 13 || (kind != 15 && kind != 16))) {
            EXPR_W(expression, EXPR_TYPE) = target;
            EXPR_W(expression, EXPR_KIND) = (u16)kind;
            return expression;
        }
        if (EXPR_FLAGS_AT(old_kind) & 1) {
            if (kind != 15 && (old_kind == 7 || old_kind == 8))
                REPORT_ERROR(MSG_NONPORTABLE_POINTER);
            else
                REPORT_WARNING(MSG_NONPORTABLE_POINTER_375);
        } else if (EXPR_FLAGS_AT(old_kind) & 0x14) {
            i16 old_flags = TYPE_SC(old_type, TYPE_C_PTR_QUALS), new_flags = TYPE_SC(target, TYPE_C_PTR_QUALS);
            i16 old_bit = old_flags & 1, new_bit = new_flags & 1;
            old_flags &= 2;
            new_flags &= 2;
            if (new_flags < old_flags || new_bit < old_bit)
                REPORT_WARNING(MSG_SUSPICIOUS_POINTER);
            else if (!POINTER_TARGETS_COMPATIBLE(old_type, target, 1)) {
                if (TYPE_B(TYPE_W(old_type, TYPE_C_TARGET), TYPE_KIND) <= 2 && TYPE_B(TYPE_W(target, TYPE_C_TARGET), TYPE_KIND) <= 2 &&
                    POINTER_KIND_COMPATIBLE(old_type, target))
                    REPORT_WARNING(MSG_MIXING_POINTERS_SIGNED);
                else
                    REPORT_WARNING(MSG_SUSPICIOUS_POINTER);
            }
        }
        if (OP(expression) == 0x32 && old_kind == kind &&
            TYPE_RECORDS_COMPATIBLE(TYPE_W(old_type, TYPE_C_TARGET), TYPE_W(target, TYPE_C_TARGET), 1)) {
            EXPR_W(expression, EXPR_TYPE) = target;
            return expression;
        }
        break;
    }
    switch (old_kind) {
    case 7: case 8:
        if (kind == 5 || kind == 6)
            REPORT_WARNING(MSG_CONVERSION_MAY_LOSE);
        break;
    case 13: case 14: case 15: case 16:
        if (EXPR_FLAGS_AT(kind) & 2)
            REPORT_INCOMPATIBLE_TYPE();
        if (EXPR_FLAGS_AT(kind) & 1) {
            u8 wide = kind == 7 || kind == 8;
            if (old_kind == 15 ? wide : !wide)
                REPORT_WARNING(MSG_NONPORTABLE_POINTER_375);
            else
                REPORT_ERROR(MSG_NONPORTABLE_POINTER);
        }
        break;
    case 9: case 10:
        if (EXPR_FLAGS_AT(kind) & 0x14)
            REPORT_INCOMPATIBLE_TYPE();
        break;
    case 12:
        REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
        break;
    case 19:
        REPORT_INCOMPATIBLE_TYPE();
        return expression;
    }
    return CONVERT_EXPRESSION_TYPE(expression, target);
}

/* 1 when two C pointer types have compatible kinds and targets (void * matches anything);
   mode goes to TYPE_RECORDS_COMPATIBLE */
i16 POINTER_TARGETS_COMPATIBLE(u16 left, u16 right, i16 mode)
{
    if (!POINTER_KIND_COMPATIBLE(left, right))
        return 0;
    if (TYPE_B(TYPE_W(left, TYPE_C_TARGET), TYPE_KIND) == TK_VOID || TYPE_B(TYPE_W(right, TYPE_C_TARGET), TYPE_KIND) == TK_VOID)
        return 1;
    return TYPE_RECORDS_COMPATIBLE(TYPE_W(left, TYPE_C_TARGET), TYPE_W(right, TYPE_C_TARGET), (i8)mode);
}

/* 1 when a pointer of type right may be used as left as far as pointer kinds go:
   anything to huge, far to anything but huge, _seg only to _seg, near only to near with
   the same segment mode */
i16 POINTER_KIND_COMPATIBLE(u16 left, u16 right)
{
    switch (TYPE_B(right, TYPE_KIND)) {
    case 14: return TYPE_B(left, TYPE_KIND) == TK_SEG_PTR;
    case 16: return 1;
    case 15: return TYPE_B(left, TYPE_KIND) != TK_HUGE_PTR;
    case 13: return TYPE_B(left, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(left, TYPE_C_FUNC_FLAGS) == TYPE_B(right, TYPE_C_FUNC_FLAGS);
    }
    return 0;
}

void REPORT_INCOMPATIBLE_TYPE(void)
{
    REPORT_ERROR(MSG_INCOMPATIBLE_TYPE);
}

/* the call of expression (a function or a pointer to one) with the argument list value.
   A direct call: an intrinsic (class 10) checks its arguments with CHECK_EMIT_ARGUMENTS;
   a far function outside the current code segment gets CSYM flag 100h.  With a prototype
   the arguments are checked and converted (STCVT3); without one they get the default
   promotions and "call to function with no prototype".  A struct result other than 1, 2
   or 4 bytes comes through a temporary whose address is a hidden first argument; the call
   then reads (call, temp) */
u16 BUILD_FUNCTION_CALL(u16 expression, u16 value)
{
    u16 status, special = 0;
    if (KIND(expression) == TK_UNDEFINED)
        return expression;
    u16 item = TYPE_OF(expression);
    if (!((EXPR_FLAGS_AT(TYPE_B(item, TYPE_KIND)) & 20) && TYPE_B(TYPE_W(item, TYPE_C_TARGET), TYPE_KIND) == TK_FUNCTION)) {
        REPORT_ERROR(MSG_CALL_NONFUNCTION);
        return STCVT8();
    }
    item = TYPE_W(item, TYPE_C_TARGET);
    if (OP(expression) == EOP_ADDR && OP(LEFT(expression)) == 1) {
        expression = LEFT(expression);
        u16 record = LEFT(expression);
        status = CSYM_W(record, CSYM_NAME);
        if (CSYM_B(record, CSYM_CLASS) == 10)
            special = 1;
        else if ((TYPE_B(item, TYPE_C_FUNC_FLAGS) & 1) && CSYM_W(record, CSYM_SEGMENT) != CODE_SEGMENT_ID)
            CSYM_W(record, CSYM_FLAGS) |= 256;
    } else {
        expression = new_node(49, item, expression, 0);
        status = 0;
    }
    u16 type = TYPE_W(item, TYPE_C_PARAMS);
    CALL_ARGUMENT_NUMBER = 1;
    CALL_FUNCTION_EXPR = expression;
    value = FOLD_EXPRESSION(value);
    if (!(TYPE_B(item, TYPE_C_FUNC_FLAGS) & 8)) {
        u8 flags = TYPE_B(item, TYPE_C_FUNC_FLAGS) & 4;
        value = STCVT3(flags, type, PROMOTE_CALL_ARGS(value), status);
    } else if (!special) {
        value = PROMOTE_CALL_ARGS(value);
        if (OP(expression) == 1) {
            DIAG_NAME_BUFFER = 0;
            REPORT_WARNING(MSG_CALL_FUNCTION_NO, NAME_TEXT_COPY(status));
        } else
            REPORT_WARNING(MSG_CALL_FUNCTION_NO_360);
    } else {
        value = FOLD_EXPRESSION(value);
        CHECK_EMIT_ARGUMENTS(CSYM_W(LEFT(expression), CSYM_OFFSET), value);
    }
    item = TYPE_W(item, TYPE_C_TARGET);
    if (TYPE_B(item, TYPE_KIND) == TK_ENUM)
        item = TYPE_W(item, TYPE_C_SIZE) == 1 ? mode_type(1) : PLAIN_INT_TYPE;
    else if (TYPE_B(item, TYPE_KIND) == TK_STRUCT) {
        u16 size = TYPE_W(item, TYPE_C_SIZE);
        if (size != 1 && size != 2 && size != 4) {
            u16 temporary = (u16)CALL_FAR(NEW_TEMPORARY_HOOK, A16(item));
            value = ADD_HIDDEN_RETURN_ARG(item, value, temporary);
            expression = new_node(54, PLAIN_INT_TYPE, expression, value);
            value = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(item), A16(temporary), A16(0), A16(0));
            return new_node(42, item, expression, value);
        }
    }
    return new_node(54, item, expression, value);
}

/* the far address of the temporary value (of struct type) in front of the argument list
   (list cells, operator 43) */
u16 ADD_HIDDEN_RETURN_ARG(u16 type, u16 expression, u16 value)
{
    u16 result = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(type), A16(value), A16(0), A16(0));
    u16 pointer = NEW_POINTER_TYPE(type, 15, 0, 0, 0);
    result = new_node(50, pointer, result, 0);
    if (!expression)
        return result;
    if (OP(expression) != 43)
        return new_node(43, type, result, expression);
    u16 item = expression;
    while (OP(LEFT(item)) == 43)
        item = LEFT(item);
    u16 cell = new_node(43, type, result, LEFT(item));
    LEFT(item) = cell;
    return expression;
}

/* the arguments left checked and converted against the parameter list status of the
   function named right (0 through a pointer); parameters left over give "too few
   parameters in call".  flags: the function's ellipsis bit (4) */
u16 STCVT3(u8 flags, u16 status, u16 left, u16 right)
{
    u16 mark = scratch_mark();
    farptr list = scratch_alloc(2);
    W(list) = status;
    left = STCVT4(flags, list, left, right);
    status = W(list);
    scratch_release(mark);
    if (status) {
        DIAG_NAME_BUFFER = 0;
        REPORT_ERROR(right ? MSG_TOO_FEW_PARAMETERS_46 : MSG_TOO_FEW_PARAMETERS, NAME_TEXT_COPY(right));
    }
    return left;
}

/* the argument tree node (list cells nest through both operands) walked left to right,
   each argument paired with the next parameter in *list: a compatible one (STCVT7)
   converted with STASSIGN, others "type mismatch in parameter" (77 to 80, named or
   numbered by CALL_ARGUMENT_NUMBER).  An argument with no parameter left is an "extra
   parameter" unless the function has an ellipsis (mode 4); which is the function's name
   record, or 0 */
u16 STCVT4(u8 mode, farptr list, u16 node, u16 which)
{
    if (!node)
        return 0;
    if (OP(node) == 0x2B) {
        u16 part = STCVT4(mode, list, LEFT(node), which);
        LEFT(node) = part;
        part = STCVT4(mode, list, RIGHT(node), which);
        RIGHT(node) = part;
        return node;
    }
    u16 parameter = W(list);
    if (parameter) {
        W(list) = CPARM_W(parameter, CPARM_NEXT);
        u16 type = CPARM_W(parameter, CPARM_TYPE);
        if (TYPE_B(type, TYPE_KIND) == 0x15)
            type = TYPE_W(type, TYPE_C_SIZE) == 1 ? mode_type(1) : PLAIN_INT_TYPE;
        if (STCVT7(node, type))
            node = STASSIGN(node, type);
        else if (CPARM_W(parameter, CPARM_NAME)) {
            DIAG_NAME_BUFFER = 0;
            farptr function = NAME_TEXT_COPY(which);      /* cdecl: the last argument first */
            farptr name = NAME_TEXT_COPY(CPARM_W(parameter, CPARM_NAME));
            REPORT_ERROR(which ? MSG_TYPE_MISMATCH_78 : MSG_TYPE_MISMATCH_80, name, function);
        } else {
            DIAG_NAME_BUFFER = 0;
            farptr function = NAME_TEXT_COPY(which);
            REPORT_ERROR(which ? MSG_TYPE_MISMATCH_77 : MSG_TYPE_MISMATCH_79, (long)(i16)CALL_ARGUMENT_NUMBER, function);
        }
        ++CALL_ARGUMENT_NUMBER;
    } else if (mode != 4) {
        DIAG_NAME_BUFFER = 0;
        REPORT_ERROR(which ? MSG_EXTRA_PARAMETER_CALL_97 : MSG_EXTRA_PARAMETER_CALL, NAME_TEXT_COPY(which));
    }
    return node;
}

/* the element size of a pointer node (or the size of another node's type) as a constant
   of PTR_SCALE_TYPE; an unknown size is an error */
u16 STCVT5(u16 node)
{
    u16 converted = size_of_type((FLAGS(node) & 0x14) ? TYPE_W(TYPE_OF(node), TYPE_C_TARGET) : TYPE_OF(node));
    if (!converted)
        REPORT_ERROR(MSG_SIZE_TYPE_UNKNOWN_ZERO);
    u16 scale_type = PTR_SCALE_TYPE(node);
    return new_const(scale_type, converted);
}

/* integral promotion: kinds listed in INTEGRAL_PROMOTION_KIND converted to the kind given
   there (char and short to int); an enum gets its int or char type in place */
u16 STCVT6(u16 node)
{
    u16 kind = KIND(node);
    if (INTEGRAL_PROMOTION_KIND_AT(kind))
        node = CONVERT_EXPRESSION_TYPE(node, mode_type(INTEGRAL_PROMOTION_KIND_AT(kind)));
    else if (kind == 0x15) {
        u16 type = TYPE_W(TYPE_OF(node), TYPE_C_TARGET) == 1 ? mode_type(1) : PLAIN_INT_TYPE;
        EXPR_W(node, EXPR_TYPE) = type;
        EXPR_W(node, EXPR_KIND) = TYPE_B(TYPE_OF(node), TYPE_KIND);
    }
    return node;
}

/* 1 when an argument node may be passed for a parameter of type at all (the conversion
   follows): not to arrays, functions or structs; pointers to non-pointers only in Windows
   mode for integer kinds; near and _seg pointers do not mix; a function pointer needs a
   compatible function type; integers and floats convert among themselves and to enums,
   the literal 0 to pointers */
i16 STCVT7(u16 node, u16 type)
{
    if (TYPE_OF(node) == type)
        return 1;
    i16 old_type = (i16)KIND(node);
    i16 kind = TYPE_B(type, 0);
    if (kind == 17 || kind == 18 || kind == 19)
        return 0;
    switch (old_type) {
    case 13: case 14: case 15: case 16:
        if (!(EXPR_FLAGS_AT(kind) & 0x14))
            return OPTION_WINDOWS_MODE && kind <= 8;
        if ((old_type == 14 && kind == 13) || (old_type == 13 && kind == 14))
            return 0;
        if (TYPE_B(TYPE_W(type, TYPE_C_TARGET), 0) == 18 &&
            !TYPE_RECORDS_COMPATIBLE(TYPE_W(type, TYPE_C_TARGET), TYPE_W(TYPE_OF(node), TYPE_C_TARGET), 3))
            return 0;
        break;
    case 1: case 2: case 3: case 4: case 5: case 6:
    case 7: case 8: case 9: case 10: case 11: case 21:
        if (OP(node) == EOP_CONST && !EXPR_L(node, EXPR_LEFT) && (EXPR_FLAGS_AT(kind) & 0x14))
            return 1;
        if (OPTION_WINDOWS_MODE && old_type <= 8 && (EXPR_FLAGS_AT(kind) & 0x14))
            return 1;
        if (kind <= 11 || kind == 21)
            break;
        return 0;
    case 19:
        return 0;
    }
    return 1;
}

/* the error node (operator 0, no type) */
u16 STCVT8(void)
{
    return new_node(0, 0, 0, 0);
}

/* p->name: the member found with LOOKUP_MEMBER in the struct p points to (left the name,
   right the scope) and its access built (STCVTA), or 0 */
u16 STCVT9(u16 node, u16 left, u16 right)
{
    u16 result = LOOKUP_MEMBER(left, right, TYPE_W(TYPE_OF(node), TYPE_C_TARGET));
    if (!result)
        return 0;
    return STCVTA(node, result);
}

/* *(member type *)(p + offset) for the struct pointer node and member record (the C
   layout).  The pointer keeps its kind, qualifiers and base (huge becomes far); a _seg
   pointer plus offset becomes far (2Dh).  A bitfield member is wrapped in a bitfield node */
u16 STCVTA(u16 node, u16 member)
{
    u16 owner = MEMBER_W(member, MEMB_C_TYPE);
    u16 kind = KIND(node);
    u16 type = TYPE_OF(node);
    if (kind == 16)
        kind = 15;
    type = NEW_POINTER_TYPE(owner, (u8)kind, TYPE_SC(type, TYPE_C_PTR_QUALS), TYPE_W(type, TYPE_C_PTR_BASE), TYPE_SC(type, TYPE_C_FUNC_FLAGS));
    node = CONVERT_EXPRESSION_TYPE(node, type);
    if (MEMBER_W(member, MEMB_C_OFFSET)) {
        u16 int_type = mode_type(5);
        u16 offset = new_const(int_type, MEMBER_W(member, MEMB_C_OFFSET));
        u16 op;
        if (kind == 14) {
            type = NEW_POINTER_TYPE(owner, 15, TYPE_SC(type, TYPE_C_PTR_QUALS), 0, 0);
            op = 0x2D;
        } else
            op = 8;
        node = new_node(op, type, node, offset);
        node = FOLD_EXPRESSION(node);
    }
    node = TYPECHECK_OPERATOR(0x31, node, 0);
    if (MEMBER_B(member, MEMB_C_BIT_WIDTH))
        node = (u16)CALL_FAR(NEW_BITFIELD_NODE_HOOK, A16(node), A16(owner), A16(MEMBER_B(member, MEMB_C_BIT_WIDTH)),
                             A16(MEMBER_B(member, MEMB_C_BIT_OFFSET)));
    return node;
}

/* an operand kind (floating and up) the operator's flag mask does not allow, rejected with
   the message from OPERAND_KIND_MESSAGE; 1 after an error */
i16 STCVTB(u16 node, u16 mask)
{
    u16 kind = KIND(node);
    if ((i16)kind < 9 || !OPERAND_KIND_MASK_AT(kind))
        return 0;
    if (!(mask & OPERAND_KIND_MASK_AT(kind))) {
        REPORT_ERROR((i16)OPERAND_KIND_MESSAGE_AT(kind));
        return 1;
    }
    return 0;
}

/* an array value decays to a pointer to its first element (its symbol marked "address
   taken", CSYM flag 100h), a function value to a function pointer */
u16 STCVTC(u16 node)
{
    if (KIND(node) == 0x11) {
        CSYM_W(LEFT(node), CSYM_FLAGS) |= 0x100;
        node = decay(TYPE_W(TYPE_OF(node), TYPE_TARGET), node, TYPE_SC(TYPE_OF(node), TYPE_PARAMS));
    }
    if (KIND(node) == 0x12)
        node = decay(TYPE_OF(node), node, 0);
    return node;
}

/* &node, the pointer modifier for PTR_TYPE_FOR_MODIFIER: force 10 (huge), a far symbol
   (CSYM flag 10h) 9 (far), a local or parameter when DS may differ from SS and data is
   near 3 (probably an SS-based near pointer) */
u16 STCVTD(u16 type, u16 node, u16 force)
{
    u16 mode = 0;
    if (force)
        mode = 10;
    else if (OP(node) == 1 && (CSYM_W(LEFT(node), CSYM_FLAGS) & 0x10))
        mode = 9;
    else if ((OP(node) == 5 || OP(node) == 6 || OP(node) == 7) && !MODEL_FAR_DATA && OPTION_DS_NOT_SS)
        mode = 3;
    u16 pointer = PTR_TYPE_FOR_MODIFIER(type, (i8)(EXPR_B(node, EXPR_QUAL_FLAGS) & 3), 0, (i8)mode);
    return new_node(0x32, pointer, node, 0);
}

/* a pointer type like type but to target, with its kind, qualifiers and base */
static u16 pointer_like(u16 target, u16 kind, u16 type)
{
    return NEW_POINTER_TYPE(target, (u8)kind, TYPE_SC(type, TYPE_C_PTR_QUALS), TYPE_W(type, TYPE_C_PTR_BASE), TYPE_SC(type, TYPE_C_FUNC_FLAGS));
}

/* the targets of two pointer types incompatible (neither void) */
static int targets_clash(u16 type, u16 other_type)
{
    return TYPE_B(TYPE_W(type, TYPE_C_TARGET), TYPE_KIND) != TK_VOID && TYPE_B(TYPE_W(other_type, TYPE_C_TARGET), TYPE_KIND) != TK_VOID &&
           !TYPE_RECORDS_COMPATIBLE(TYPE_W(type, TYPE_C_TARGET), TYPE_W(other_type, TYPE_C_TARGET), 0);
}

/* the _seg pointer + offset node (2Dh), a far pointer */
static u16 seg_plus(u16 type, u16 seg, u16 offset)
{
    u16 pointer = NEW_POINTER_TYPE(TYPE_W(type, TYPE_C_TARGET), 0xF, 0, 0, 0);
    return new_node(0x2D, pointer, seg, offset);
}

/* operator op on left and right (right 0 for a unary operator, other then the same node):
   the conversions inserted and the result node built, or the error node.
   TYPECHECK_OP_FLAGS[op]: 8000h needs a modifiable lvalue, 2000h integral promotion of
   both, 10h (cleared for pointers) and others the operand mask, 3 the conversion of the
   right operand, 4 no widening of the left, 8 an int result */
u16 TYPECHECK_OPERATOR(i16 op, u16 left, u16 right)
{
    u16 node = left, other = right, result, type, mask;
    if (KIND(node) == TK_UNDEFINED)
        return node;
    if (other && KIND(other) == TK_UNDEFINED)
        return other;
    if (!other)
        other = node;
    result = node;
    mask = (op < 8 || op > 0x33) ? 0 : TYPECHECK_OP_FLAGS_AT(op);
    if (mask & 0x8000) {
        if (!IS_ADDRESSABLE_EXPR(node)) {
            REPORT_ERROR(MSG_LVALUE_REQUIRED);
            return STCVT8();
        }
        if ((EXPR_W(node, EXPR_QUAL_FLAGS) & 1) ||
            ((KIND(node) == TK_STRUCT || KIND(node) == TK_UNION) && STBIN7(TYPE_OF(node), 1))) {
            REPORT_ERROR(MSG_CANNOT_MODIFY_CONST);
            return STCVT8();
        }
    }
    if ((FLAGS(node) & 0x14) || (FLAGS(other) & 0x14))
        mask &= 0xFFEF;
    if (STCVTB(node, mask) || STCVTB(other, mask))
        return STCVT8();
    switch (op) {
    case 0x31: {        /* unary * */
        if (!(FLAGS(node) & 0x14)) {
            REPORT_ERROR(MSG_INVALID_INDIRECTION);
            return STCVT8();
        }
        u16 original = TYPE_OF(node);
        if (TYPE_W(original, TYPE_C_PTR_BASE)) {
            node = APPLY_BASED_POINTER_C(node);
            original = TYPE_OF(node);
        }
        type = TYPE_W(original, TYPE_C_TARGET);
        if (TYPE_B(type, TYPE_KIND) == TK_VOID) {
            REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
            return STCVT8();
        }
        if (TYPE_B(type, TYPE_KIND) == TK_ARRAY) {
            node = new_node(0x31, type, node, 0);
            EXPR_W(node, EXPR_QUAL_FLAGS) = (u16)TYPE_SC(original, TYPE_C_PTR_QUALS);
            u16 pointer = pointer_like(TYPE_W(type, TYPE_TARGET), TYPE_B(original, TYPE_KIND), original);
            result = new_node(0x32, pointer, node, 0);
        } else if (TYPE_B(type, TYPE_KIND) == TK_FUNCTION) {
            node = new_node(0x31, type, node, 0);
            EXPR_W(node, EXPR_QUAL_FLAGS) = (u16)TYPE_SC(original, TYPE_C_PTR_QUALS);
            result = new_node(0x32, original, node, 0);
        } else if (OP(node) == EOP_ADDR && IS_ADDRESSABLE_NODE(LEFT(node))) {
            node = LEFT(node);
            EXPR_W(node, EXPR_TYPE) = type;
            EXPR_W(node, EXPR_KIND) = TYPE_B(type, TYPE_KIND);
            EXPR_W(node, EXPR_QUAL_FLAGS) &= 0xFFFC;
            EXPR_W(node, EXPR_QUAL_FLAGS) |= (u16)TYPE_SC(original, TYPE_C_PTR_QUALS);
            return node;
        } else {
            result = new_node((u16)op, type, node, 0);
            EXPR_W(result, EXPR_QUAL_FLAGS) = (u16)TYPE_SC(original, TYPE_C_PTR_QUALS);
        }
        return result;
    }
    case 0x32:          /* unary & */
        if (OP(node) == EOP_ADDR) {
            if (TYPE_W(TYPE_OF(node), TYPE_C_TARGET) != TYPE_OF(LEFT(node))) {
                type = TYPE_OF(node);
                u16 pointer = pointer_like(TYPE_OF(LEFT(node)), EXPR_B(node, EXPR_KIND), type);
                EXPR_W(node, EXPR_TYPE) = pointer;
                return node;
            }
            REPORT_WARNING(MSG_SUPERFLUOUS_FUNCTION);
            return node;
        }
        if (STBIN2(node) || OP(node) == 0x33 || !IS_ADDRESSABLE_EXPR(node)) {
            REPORT_ERROR(MSG_MUST_TAKE_ADDRESS);
            return STCVT8();
        }
        if (OP(node) == EOP_DEREF) {
            result = LEFT(node);
            type = TYPE_OF(result);
            type = pointer_like(TYPE_OF(node), EXPR_B(result, EXPR_KIND), type);
            EXPR_W(result, EXPR_TYPE) = type;
            EXPR_W(result, EXPR_KIND) = TYPE_B(type, TYPE_KIND);
            return result;
        }
        if (OP(node) == EOP_QUESTION) {
            u16 list = RIGHT(node);
            u16 first = TYPECHECK_OPERATOR(0x32, LEFT(list), 0);
            LEFT(list) = first;
            u16 second = TYPECHECK_OPERATOR(0x32, RIGHT(list), 0);
            RIGHT(list) = second;
            EXPR_W(list, EXPR_KIND) = KIND(first);
            EXPR_W(node, EXPR_KIND) = KIND(list);
            EXPR_W(list, EXPR_TYPE) = TYPE_OF(first);
            EXPR_W(node, EXPR_TYPE) = TYPE_OF(list);
            return node;
        }
        if (OP(node) == 1 || OP(node) == 5)
            CSYM_W(LEFT(node), CSYM_FLAGS) |= 0x100;
        return decay(TYPE_OF(node), node, 0);
    case 0x30:          /* ! (an int result); - and ~ below */
        node = STCVT6(node);
        return new_node(0x30, PLAIN_INT_TYPE, node, 0);
    case 0x2E:
    case 0x2F:
        node = STCVT6(node);
        return new_node((u16)op, TYPE_OF(node), node, 0);
    case 0x23:          /* postfix ++ and --; prefix ++x is built as x += 1 */
    case 0x24:
        if (FLAGS(node) & 0x14)
            result = STCVT5(node);
        else {
            u16 one = new_const(PLAIN_INT_TYPE, 1);
            result = STASSIGN(one, TYPE_OF(node));
        }
        return new_node((u16)op, TYPE_OF(node), node, result);
    case 8:             /* binary + */
        if (FLAGS(node) & 0x14) {
            type = TYPE_OF(node);
            if (KIND(node) == TK_SEG_PTR) {
                if (KIND(other) == TK_SEG_PTR || KIND(other) == TK_FAR_PTR) {
                    REPORT_ERROR(MSG_INVALID_POINTER);
                    return STCVT8();
                }
                if (KIND(other) != TK_NEAR_PTR)
                    other = SCALE_INDEX(other, node);
                else if (targets_clash(type, TYPE_OF(other))) {
                    REPORT_ERROR(MSG_ILLEGAL_USE_POINTER);
                    return STCVT8();
                }
                if (TYPE_B(TYPE_W(type, TYPE_C_TARGET), TYPE_KIND) == TK_VOID)
                    type = TYPE_OF(other);
                return seg_plus(type, node, other);
            }
            if (KIND(other) == TK_SEG_PTR) {
                if (KIND(node) == TK_FAR_PTR) {
                    REPORT_ERROR(MSG_INVALID_POINTER);
                    return STCVT8();
                }
                if (targets_clash(type, TYPE_OF(other))) {
                    REPORT_ERROR(MSG_ILLEGAL_USE_POINTER);
                    return STCVT8();
                }
                if (TYPE_B(TYPE_W(type, TYPE_C_TARGET), TYPE_KIND) == TK_VOID)
                    type = TYPE_OF(other);
                return seg_plus(type, other, node);
            }
            if (FLAGS(other) & 0x14) {
                REPORT_ERROR(MSG_INVALID_POINTER);
                return STCVT8();
            }
            other = SCALE_INDEX(other, node);
            result = new_node(8, type, node, other);
        } else if (FLAGS(other) & 0x14) {
            if (KIND(other) == TK_SEG_PTR) {
                node = SCALE_INDEX(node, other);
                return seg_plus(TYPE_OF(other), other, node);
            }
            node = SCALE_INDEX(node, other);
            result = new_node(8, TYPE_OF(other), other, node);
        } else
            goto general;
        return result;
    case 0x13:          /* += */
        if (FLAGS(node) & 0x14) {
            if (FLAGS(other) & 0x14) {
                REPORT_ERROR(MSG_INVALID_POINTER);
                return STCVT8();
            }
            other = SCALE_INDEX(other, node);
            return new_node((u16)op, TYPE_OF(node), node, other);
        }
        if (!(FLAGS(other) & 0x14))
            goto general;
        REPORT_ERROR(MSG_ILLEGAL_USE_POINTER);
        return STCVT8();
    case 9:             /* binary - and -= (14h) */
    case 0x14:
        if (FLAGS(node) & 0x14) {
            if (FLAGS(other) & 0x14) {
                if (op == 0x14) {
                    REPORT_ERROR(MSG_ILLEGAL_POINTER);
                    return STCVT8();
                }
                other = STASSIGN(other, TYPE_OF(node));
                u16 scale = STCVT5(node);
                type = mode_type((KIND(other) == TK_FAR_PTR || KIND(other) == TK_HUGE_PTR) ? 7 : 5);
                if (TYPE_B(type, TYPE_KIND) == TK_LONG && KIND(other) == TK_FAR_PTR) {
                    u16 common = mode_type(6);
                    node = CONVERT_EXPRESSION_TYPE(node, common);
                    other = CONVERT_EXPRESSION_TYPE(other, common);
                }
                result = new_node(0x2C, type, node, other);
                scale = CONVERT_EXPRESSION_TYPE(scale, type);
                result = new_node(0xB, TYPE_OF(result), result, scale);
            } else {
                other = SCALE_INDEX(other, node);
                result = new_node((u16)op, TYPE_OF(node), node, other);
            }
        } else {
            if (!(FLAGS(other) & 0x14))
                goto general;
            REPORT_ERROR(MSG_ILLEGAL_POINTER);
            return STCVT8();
        }
        return result;
    case 0x25:          /* ?: (other the 26h node) */
        if (OP(node) != EOP_CONST)
            node = STBIN3(node);
        if (OP(other) != EOP_COLON)
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
        return new_node(0x25, TYPE_OF(other), node, other);
    case 0x12:          /* =: struct assignment here, other types the general path */
        if (KIND(node) != TK_STRUCT && KIND(other) != TK_STRUCT)
            goto general;
        if (!TYPE_RECORDS_COMPATIBLE(TYPE_OF(node), TYPE_OF(other), 1)) {
            REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
            return STCVT8();
        }
        return new_node(0x12, TYPE_OF(node), node, other);
    case 0x1D: case 0x1E: case 0x1F: case 0x20: case 0x21: case 0x22:   /* comparisons */
        if (!(FLAGS(node) & 0x14) && !(FLAGS(other) & 0x14)) {
            node = FOLD_EXPRESSION(node);
            other = FOLD_EXPRESSION(other);
            /* the left operand's operator (result still holds left), not op, as in the original */
            if (OP(other) != EOP_CONST)
                STBIN4((i16)MIRROR_COMPARE_OP(OP(result)), node, (i16)KIND(other));
            else if (OP(node) != EOP_CONST)
                STBIN4((i16)OP(result), other, (i16)KIND(node));
        }
        if ((FLAGS(node) & 0x14) && (FLAGS(other) & 0x14)) {
            if (KIND(other) == TK_FAR_PTR && KIND(node) != TK_FAR_PTR)
                node = STBIN5(node, TYPE_OF(other));
            else
                other = STBIN5(other, TYPE_OF(node));
        }
        goto general;
    case 0x27:          /* && and || */
    case 0x28:
        node = STBIN3(node);
        other = STBIN3(other);
        return new_node((u16)op, PLAIN_INT_TYPE, node, other);
    default:
    general:
        if (mask & 0x2000) {
            other = STCVT6(other);
            node = STCVT6(node);
        }
        switch (mask & 3) {
        case 3:
            other = CONVERT_EXPRESSION_TYPE(other, mode_type(2));
            break;
        case 1:
            if (op >= 0x13 && op <= 0x17 && KIND_INFO(KIND(other) * 4) > KIND_INFO(KIND(node) * 4)) {
                result = new_node((u16)op, TYPE_OF(other), node, other);
                result = (u16)CALL_FAR(EXPAND_COMPOUND_ASSIGN_HOOK, A16(result));
                u16 child = RIGHT(result);
                u16 converted = STASSIGN(LEFT(child), TYPE_OF(other));
                LEFT(child) = converted;
                converted = STASSIGN(child, TYPE_OF(node));
                RIGHT(result) = converted;
                EXPR_W(result, EXPR_KIND) = KIND(node);
                EXPR_W(result, EXPR_TYPE) = TYPE_OF(node);
                return result;
            }
            other = STASSIGN(other, TYPE_OF(node));
            goto widen;
        case 2:
            other = STASSIGN(other, mode_type(2));
            goto widen;
        default:
            if ((FLAGS(node) & 0x14) && OP(other) == EOP_CONST && EXPR_L(other, EXPR_VALUE) == 0)
                other = CONVERT_EXPRESSION_TYPE(other, TYPE_OF(node));
            else if ((FLAGS(other) & 0x14) && OP(node) == EOP_CONST && EXPR_L(node, EXPR_VALUE) == 0)
                node = CONVERT_EXPRESSION_TYPE(node, TYPE_OF(other));
            else if (EXPR_I(other, EXPR_KIND) < EXPR_I(node, EXPR_KIND))
                other = STASSIGN(other, TYPE_OF(node));
        widen:
            if (!(mask & 4) && EXPR_I(node, EXPR_KIND) < EXPR_I(other, EXPR_KIND))
                node = STASSIGN(node, TYPE_OF(other));
        }
        type = (mask & 8) ? PLAIN_INT_TYPE : TYPE_OF(node);
        result = new_node((u16)op, type, node, other);
    }
    return result;
}

/* 1 for a register variable (leaf 5 with CSYM flag 8, or leaf 4), whose address cannot be
   taken */
i16 STBIN2(u16 node)
{
    if (OP(node) == 5)
        return CSYM_W(LEFT(node), CSYM_FLAGS) & 8;
    return OP(node) == 4;
}

/* a condition operand: comparisons, && || and ! as they are, anything else (x != 0); an
   assignment used as a condition gets "possibly incorrect assignment" */
u16 STBIN3(u16 node)
{
    if (OP(node) == 18)
        REPORT_WARNING(MSG_POSSIBLY_INCORRECT);
    i16 op = (i16)OP(node);
    if ((op >= 29 && op <= 34) || op == 39 || op == 40 || op == 48)
        return node;
    return TYPECHECK_OPERATOR(0x1E, node, new_const(PLAIN_INT_TYPE, 0));
}

/* for a comparison of a variable with the constant node: "constant out of range in
   comparison" when the constant cannot be a value of the variable's integer kind type (or
   the comparison is always true or false at the range's ends); else the constant takes
   that kind so that the comparison can be done in it */
void STBIN4(i16 opcode, u16 node, i16 type)
{
    if (OP(node) != EOP_CONST || type >= 7)
        return;
    i32 value = EXPR_L(node, EXPR_VALUE);
    if (EXPR_FLAGS_AT(type) & 0x20) {
        if ((u32)value > (u32)RANGE_MAX(type) || (opcode == 0x21 && value == 0) ||
            (opcode == 0x22 && (u32)value == (u32)RANGE_MAX(type))) {
            REPORT_WARNING(MSG_CONSTANT_OUT_RANGE);
            return;
        }
    } else if (value < RANGE_MIN(type) || value > RANGE_MAX(type) || (opcode == 0x21 && value == RANGE_MIN(type)) ||
               (opcode == 0x22 && value == RANGE_MAX(type))) {
        REPORT_WARNING(MSG_CONSTANT_OUT_RANGE);
        return;
    }
    EXPR_L(node, EXPR_VALUE) = (i32)CALL_FAR(TOKEN_CONVERT, A32((u32)value), A16((u16)type));
    EXPR_W(node, EXPR_KIND) = (u16)type;
}

/* the pointer node converted to the pointer type for a comparison, with a warning when
   the targets are not compatible */
u16 STBIN5(u16 node, u16 type)
{
    u16 left = TYPE_OF(node);
    if (!POINTER_TARGETS_COMPATIBLE(left, type, 3)) {
        u8 chars = TYPE_B(TYPE_W(left, 3), 0) <= 2 && TYPE_B(TYPE_W(type, 3), 0) <= 2 && POINTER_KIND_COMPATIBLE(left, type);
        REPORT_WARNING(chars ? MSG_MIXING_POINTERS_SIGNED : MSG_SUSPICIOUS_POINTER);
    }
    return CONVERT_EXPRESSION_TYPE(node, type);
}

/* 1 when node is an lvalue: a symbol leaf, *p or a bitfield (not of array type), or a ?:
   of struct type whose arms are both lvalues */
i16 IS_ADDRESSABLE_EXPR(u16 node)
{
    switch ((i16)OP(node)) {
    case 0x25:
        if (KIND(node) != TK_STRUCT)
            return 0;
        return IS_ADDRESSABLE_EXPR(LEFT(RIGHT(node))) && IS_ADDRESSABLE_EXPR(RIGHT(RIGHT(node)));
    case 1: case 4: case 5: case 6: case 7: case 0x31: case 0x33:
        return KIND(node) != TK_ARRAY;
    default:
        return 0;
    }
}

/* 1 when a member of the struct type has a flag in mask (MEMB_C_FLAGS; mask 1 probably
   "const") */
i16 STBIN7(u16 type, u16 mask)
{
    for (u16 member = TYPE_W(type, TYPE_C_PARAMS); member; member = MEMBER_W(member, MEMB_NEXT))
        if (mask & MEMBER_B(member, MEMB_C_FLAGS))
            return 1;
    return 0;
}

/* the C version of APPLY_BASED_POINTER: the based pointer's base text (from POOL_HASH)
   parsed, base + pointer returned; the node unchanged on a syntax error */
u16 APPLY_BASED_POINTER_C(u16 node)
{
    u8 saved[TOKEN_RECORD_SIZE];
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        saved[i] = B(fp_add(TOKEN_TYPE_P, i));
    BCC_INPUT_STRING_PTR(FP_OFF(POOL_HASH_P), TYPE_W(TYPE_OF(node), TYPE_C_PTR_BASE));
    next_token();
    u16 base = PARSE_EXPRESSION(0, 0);
    if (!base)
        return node;
    if (TOKEN_TYPE != 7) {
        REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX, 0);
        return node;
    }
    POP_INPUT_CONTEXT(1);
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        B(fp_add(TOKEN_TYPE_P, i)) = saved[i];
    return TYPECHECK_OPERATOR(8, base, node);
}

/* 1 for a symbol leaf without EXPR_QUAL_FLAGS bit 4 (bit 4 probably marks a variable in
   the default data group) */
i16 STBIN9(u16 node)
{
    return OP(node) == 1 && !(EXPR_W(node, EXPR_QUAL_FLAGS) & 4);
}

/* 1 when value is the string literal symbol C_STRING_LITERAL_SYMBOL */
i16 STBIN10(u16 value)
{
    return value == C_STRING_LITERAL_SYMBOL;
}

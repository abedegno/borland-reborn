/* opprec.c: from bcc20/src/parser/OPPREC.C: the expression parser of the C++ front end
   (which also parses C expressions, and #if expressions).  It is an operator-precedence
   parser: one loop (PARSE_EXPRESSION_PREC) reads tokens left to right, pushing operands on
   an operand stack and operators on an operator stack, and before pushing an operator it
   reduces (REDUCE_OPERATOR) every stacked operator that binds at least as tightly.
   Smaller precedence numbers bind tighter: operands 2, prefix operators 0Ah, and 7Eh means
   "this token ends the expression" (tables BINARY_PRECEDENCE_BY_TOKEN and
   PREFIX_PRECEDENCE_BY_TOKEN for the incoming token, STACK_PRECEDENCE_BY_OP for the stacked
   one).  Stacked operators are token codes, plus pseudo-codes: 59h / 5Ah postfix ++ / --,
   5Bh unary +, 5Ch address, 5Dh indirection, 5Eh unary -, 5Fh call, 60h the '[' of
   delete[], 61h cast, 63h ::delete.  The operator stack is 80h words in
   OPERATOR_STACK_POOL; the operand stack a chain of list nodes in the expression pool
   (EXPR_RIGHT the operand, EXPR_LEFT the next) from OPERAND_LIST_HEAD down to the sentinel
   OPERAND_LIST_BASE.  A nested expression saves and restores both stacks.  Errors set
   IN_ERROR_RECOVERY; the loop then stops and the caller's stop token is searched for.  Node
   flag 8 (EXPR_NODE_FLAGS) marks a parenthesised subexpression.

   The token records and locals whose addresses are passed on live in the scratch area, in
   the original frame's layout where several are passed.  PARSE_EXPRESSION_PREC's recovery
   reads its paren and bracket counts unset when the expression did not start with an
   expression token; here they are 0 (README, decisions). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define CURRENT_TOKEN_VALUE D(CURRENT_TOKEN_VALUE_P)
#define BCC_TYPE_AT(i) W(fp_add(D(BCC_TYPE_PTR_P), (i) * 2))
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define STK(i) W(MK_FP(OPERATOR_STACK_POOL, OPERATOR_STACK_OFFSET + (i) * 2))
#define TOKEN_RECORD_SIZE 19

static u16 top(void) { return OPERATOR_STACK_DEPTH <= 0 ? 0x82 : STK(OPERATOR_STACK_DEPTH - 1); }

/* a fresh pair of stacks: a new 100h-byte operator stack and an operand stack holding only
   a sentinel (an error node in a list node) */
void INIT_EXPR_PARSER(void)
{
    OPERATOR_STACK_DEPTH = 0;
    OPERATOR_STACK_OFFSET = POOL_ALLOC_REUSE(OPERATOR_STACK_POOL_P, 0x100);
    OPERAND_LIST_BASE = REPORT_EXPR_ERROR_PLAIN(0, 0);
    u16 base = MAKE_LIST_NODE(OPERAND_LIST_BASE, 0);
    OPERAND_LIST_BASE = base;
    OPERAND_LIST_HEAD = base;
}

/* releases the operator stack; 1 if both stacks were empty (the expression complete) */
u8 END_EXPR_PARSER(void)
{
    u8 empty = OPERATOR_STACK_DEPTH == 0 && OPERAND_LIST_HEAD == OPERAND_LIST_BASE;
    OPERATOR_STACK_DEPTH = 0;
    POOL_FREE_ITEM(OPERATOR_STACK_POOL_P, OPERATOR_STACK_OFFSET);
    return empty;
}

/* pops an operand; on an empty stack reports "operand expected" and gives an error node */
u16 POP_OPERAND(void)
{
    u16 node = OPERAND_LIST_HEAD, result;
    if (node == OPERAND_LIST_BASE) {
        result = REPORT_EXPR_ERROR_PLAIN(MSG_OPERAND_EXPECTED, 0);
        IN_ERROR_RECOVERY = 1;
    } else {
        result = EXPR_W(node, EXPR_RIGHT);
        OPERAND_LIST_HEAD = EXPR_W(node, EXPR_LEFT);
        FREE_EXPR_NODE(node);
    }
    return result;
}

/* pushes an operator code; more than 80h is "expression too complex" */
void PUSH_OPERATOR(u16 op)
{
    if (OPERATOR_STACK_DEPTH >= 0x80) {
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_TOO);
        IN_ERROR_RECOVERY = 1;
    } else {
        STK(OPERATOR_STACK_DEPTH) = op;
        OPERATOR_STACK_DEPTH++;
    }
}

/* pops an operator code; 82h (and a syntax error) if the stack is empty */
u16 POP_OPERATOR(void)
{
    if (OPERATOR_STACK_DEPTH <= 0) {
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
        IN_ERROR_RECOVERY = 1;
        return 0x82;
    }
    OPERATOR_STACK_DEPTH--;
    return STK(OPERATOR_STACK_DEPTH);
}

/* an unparenthesised shift */
static int floatop(u16 n)
{
    return (EXPR_W(n, EXPR_OP) == EOP_SHL || EXPR_W(n, EXPR_OP) == EOP_SHR) && !(EXPR_B(n, EXPR_NODE_FLAGS) & 8);
}

/* a different operator with precedence between that of token 1Eh and token 1Ch */
static int mixed(u16 n, u16 op)
{
    u8 t = C18_OPERATOR_TOKENS_AT(EXPR_W(n, EXPR_OP));
    return op != 0x32 && t != op && BINARY_PRECEDENCE_BY_TOKEN_AT(t) >= BINARY_PRECEDENCE_BY_TOKEN_AT(0x1E) &&
           BINARY_PRECEDENCE_BY_TOKEN_AT(t) <= BINARY_PRECEDENCE_BY_TOKEN_AT(0x1C);
}

static int parenthesised(u16 n) { return EXPR_B(n, EXPR_NODE_FLAGS) & 8; }

/* pops the top operator and its operands and pushes the node built from them.  ')' pops
   its '(' and marks the node parenthesised; ']' makes a subscript from '[' or completes a
   delete[]; delete pairs with a following expression; a cast gets its operand; ':' needs a
   '?' below it.  For shifts, + and -, and the bitwise and comparison operators, an
   unparenthesised operand built from a confusable operator gives "ambiguous operators".  A
   '(', '[' or '?' left over is a missing-partner error */
void REDUCE_OPERATOR(void)
{
    u16 op = POP_OPERATOR(), next, third, left, right, node = 0;
    switch (op) {
    case 2:
        if (top() == 1)
            POP_OPERATOR();
        else {
            REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_CHECK);
            IN_ERROR_RECOVERY = 1;
        }
        node = POP_OPERAND();
        EXPR_B(node, EXPR_NODE_FLAGS) |= 8;
        break;
    case 4:
        next = POP_OPERATOR();
        if (next != 3 && next != 0x60) {
            PUSH_OPERATOR(next);
            REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
            IN_ERROR_RECOVERY = 1;
            break;
        }
        node = MAKE_BINARY_NODE(3, 0, 0);
        if (next == 0x60) {
            EXPR_W(node, EXPR_OP) = EOP_DELETE;
            u16 operand = POP_OPERAND();
            EXPR_W(node, EXPR_LEFT) = operand;
        } else {
            u16 operand = POP_OPERAND();
            EXPR_W(node, EXPR_RIGHT) = operand;
            operand = POP_OPERAND();
            EXPR_W(node, EXPR_LEFT) = operand;
        }
        break;
    case 0x63:
    case 0x69:
        node = POP_OPERAND();
        if (EXPR_W(EXPR_W(OPERAND_LIST_HEAD, EXPR_RIGHT), EXPR_OP) == EOP_DELETE) {
            right = node;
            node = POP_OPERAND();
            EXPR_W(node, EXPR_RIGHT) = right;
        } else
            node = MAKE_BINARY_NODE(0x69, MAKE_INT_CONSTANT(INT_TYPE, 1), node);
        if (op == 0x63)
            EXPR_B(node, EXPR_NODE_FLAGS) &= 0xDF;
        break;
    case 0x61:
        third = POP_OPERAND();
        node = POP_OPERAND();
        EXPR_W(node, EXPR_LEFT) = third;
        break;
    case 0x21:
        if (top() != 0x20) {
            REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_FOUND);
            IN_ERROR_RECOVERY = 1;
        } else {
            POP_OPERATOR();
            right = POP_OPERAND();
            left = POP_OPERAND();
            third = POP_OPERAND();
            node = MAKE_CONDITIONAL_NODE(0x20, third, left, right);
        }
        break;
    case 0x2A: case 0x2B: case 0x2C: case 0x2D: case 0x2E: case 0x6C:
        node = MAKE_UNARY_NODE(op, POP_OPERAND());
        break;
    case 0x59:
        node = MAKE_UNARY_NODE(0x2D, POP_OPERAND());
        EXPR_B(node, EXPR_NODE_FLAGS) |= 2;
        break;
    case 0x5A:
        node = MAKE_UNARY_NODE(0x2E, POP_OPERAND());
        EXPR_B(node, EXPR_NODE_FLAGS) |= 2;
        break;
    case 0x5B:
        node = MAKE_UNARY_NODE(0x16, POP_OPERAND());
        break;
    case 0x5C:
        node = MAKE_UNARY_NODE(0x1B, POP_OPERAND());
        break;
    case 0x5D:
        node = MAKE_UNARY_NODE(0x18, POP_OPERAND());
        break;
    case 0x5E:
        node = MAKE_UNARY_NODE(0x17, POP_OPERAND());
        break;
    case 0x5F:
        op = 1;
        /* fall through */
    case 0x08: case 0x0B: case 0x0C: case 0x0D: case 0x0E: case 0x0F: case 0x10: case 0x11:
    case 0x12: case 0x13: case 0x14: case 0x15: case 0x18: case 0x19: case 0x1A: case 0x22:
    case 0x23: case 0x2F: case 0x30: case 0x64: case 0x66:
        right = POP_OPERAND();
        left = POP_OPERAND();
        node = MAKE_BINARY_NODE(op, left, right);
        break;
    case 0x16:
    case 0x17:
        right = POP_OPERAND();
        left = POP_OPERAND();
        if (floatop(right) || floatop(left))
            REPORT_CURRENT_TOKEN(MSG_AMBIGUOUS_OPERATORS);
        node = MAKE_BINARY_NODE(op, left, right);
        break;
    case 0x1E:
    case 0x1F:
        right = POP_OPERAND();
        left = POP_OPERAND();
        if (((EXPR_W(right, EXPR_OP) == EOP_ADD || EXPR_W(right, EXPR_OP) == EOP_SUB || mixed(right, op)) && !parenthesised(right)) ||
            ((EXPR_W(left, EXPR_OP) == EOP_ADD || EXPR_W(left, EXPR_OP) == EOP_SUB || mixed(left, op)) && !parenthesised(left)))
            REPORT_CURRENT_TOKEN(MSG_AMBIGUOUS_OPERATORS);
        node = MAKE_BINARY_NODE(op, left, right);
        break;
    case 0x1B: case 0x1C: case 0x1D: case 0x24: case 0x25: case 0x26: case 0x27: case 0x28: case 0x29:
        right = POP_OPERAND();
        left = POP_OPERAND();
        if ((mixed(right, op) && !parenthesised(right) && EXPR_W(right, EXPR_OP) != EOP_ADDR) ||
            (EXPR_W(left, EXPR_OP) != EOP_ADDR && mixed(left, op) && !parenthesised(left)))
            REPORT_CURRENT_TOKEN(MSG_AMBIGUOUS_OPERATORS);
        node = MAKE_BINARY_NODE(op, left, right);
        break;
    case 1:
        REPORT_CURRENT_TOKEN(MSG_NO_MATCHING);
        IN_ERROR_RECOVERY = 1;
        break;
    case 3:
        REPORT_DIAGNOSTIC(MSG_MISSING, (i32)STR_SUBSCRIPTING_P, 0);
        IN_ERROR_RECOVERY = 1;
        break;
    case 0x20:
        REPORT_CURRENT_TOKEN(MSG_NO_FOLLOWING);
        IN_ERROR_RECOVERY = 1;
        break;
    case 0x82:
        IN_ERROR_RECOVERY = 1;
        break;
    default:
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
        IN_ERROR_RECOVERY = 1;
    }
    if (node)
        OPERAND_LIST_HEAD = MAKE_LIST_NODE(node, OPERAND_LIST_HEAD);
}

/* '.' or '->' (the current token) after the operand on top of the stack: in C++ the
   member is parsed by PARSE_MEMBER_SELECTOR; in C it must be an identifier, kept as a
   member-name node */
u16 PARSE_MEMBER_OPERATOR(void)
{
    u16 node = POP_OPERAND(), type;
    node = MAKE_BINARY_NODE(CURRENT_TOKEN, node, 0);
    ADVANCE_TOKEN();
    if (CPP_MODE)
        return PARSE_MEMBER_SELECTOR(node);
    if (CURRENT_TOKEN == TOK_IDENT)
        type = MAKE_MEMBER_NAME_NODE((u16)CURRENT_TOKEN_VALUE, 0);
    else
        type = REPORT_EXPR_ERROR_PLAIN(MSG_FIELD_IDENTIFIER, 0);
    ADVANCE_TOKEN();
    EXPR_W(node, EXPR_RIGHT) = type;
    return node;
}

/* the expression node for an identifier.  type is the symbol name lookup found (0 if
   none), token the identifier's token record (kind word, flags byte, three location words,
   name word at 9) and where its source position (passed as its words, third first).  An
   undeclared name followed by '(' is a call of an undeclared function: reported (an error
   in C++, a warning in C), declared as extern "int name()" and moved into the file scope's
   name chain.  Inside #if (MACRO_MODE) an unknown name is 0L (and in strict ANSI mode
   every name is).  A typedef name is an error here */
u16 BUILD_IDENTIFIER_NODE(u16 type_in, farptr token, u16 third, u16 second, u16 first)
{
    /* the original frame from BP-4 to the parameter type at BP+10h: created at 1, type at
       14h */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x16);
    farptr created = fp_add(v, 1), type = fp_add(v, 0x14);
    u16 node, result;
    W(type) = type_in;
    if (MACRO_MODE && LANGUAGE_MODE)
        W(type) = 0;
    else if (!W(type) && W(token) == 0x31 && CURRENT_TOKEN == TOK_LPAREN) {
        REPORT_DIAGNOSTIC(CPP_MODE ? MSG_FUNCTION_SHOULD_HAVE : MSG_NO_DECLARATION, (i32)NAME_TEXT_COPY(W(fp_add(token, 9))), 0);
        u16 saved = CURRENT_LINKAGE;
        CURRENT_LINKAGE = 2;
        DECLARE_FUNCTION(IMPLICIT_FUNC_TYPE, W(fp_add(token, 9)), 0, 0x36, type, created);
        if (SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES) != GLOBAL_SCOPE_NAMES) {
            u16 t = W(type);
            SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES) = SYM_W(t, SYM_NEXT);
            SYM_W(t, SYM_NEXT) = NAME_W(SYM_W(t, SYM_NAME), 0);
            NAME_W(SYM_W(t, SYM_NAME), 0) = t;
        }
        CURRENT_LINKAGE = saved;
    }
    u16 t = W(type);
    if (!t) {
        if (MACRO_MODE)
            result = MAKE_INT_CONSTANT(LONG_TYPE, 0);
        else {
            REPORT_TOKEN_DIAGNOSTIC(token, MSG_UNDEFINED_SYMBOL);
            result = REPORT_EXPR_ERROR_PLAIN(0, 0);
        }
    } else if ((SYM_B(t, SYM_STORAGE_CLASS) >> 3) == 8 || (SYM_B(t, SYM_STORAGE_CLASS) >> 3) == 11) {
        if (!SYM_W(t, SYM_NAME))
            result = REPORT_EXPR_ERROR_PLAIN(MSG_IMPROPER_USE_TYPEDEF, 0);
        else
            result = REPORT_EXPR_ERROR(MSG_IMPROPER_USE_TYPEDEF_262, NAME_TEXT_COPY(SYM_W(t, SYM_NAME)), 0, 0);
    } else {
        node = MAKE_SYMBOL_NODE(t);
        EXPR_W(node, 20) = first;
        EXPR_W(node, 22) = second;
        EXPR_W(node, 24) = third;
        result = node;
    }
    scratch_release(mark);
    return result;
}

/* the C form of a primary identifier: looks up the current name, saves the token and its
   position, advances, and builds the node */
u16 PARSE_IDENTIFIER(void)
{
    if (CURRENT_TOKEN != TOK_IDENT)
        return REPORT_EXPR_ERROR_PLAIN(MSG_IDENTIFIER_EXPECTED, 0);
    u16 type = LOOKUP_NAME((u16)CURRENT_TOKEN_VALUE);
    u16 mark = scratch_mark();
    farptr token = scratch_alloc(TOKEN_RECORD_SIZE + 1);
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        B(fp_add(token, i)) = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
    u16 first = CURRENT_TOKEN_FILE, second = CURRENT_TOKEN_LINE, third = CURRENT_TOKEN_LOC_WORD3;
    ADVANCE_TOKEN();
    u16 result = BUILD_IDENTIFIER_NODE(type, token, third, second, first);
    scratch_release(mark);
    return result;
}

/* a new type "array of value chars", the type of a string literal */
u16 MAKE_STRING_TYPE(i16 value)
{
    u16 type = CREATE_TYPE(0x11);
    TYPE_W(type, TYPE_TARGET) = CHAR_TYPE;
    TYPE_L(type, TYPE_ARRAY_COUNT) = value;
    return type;
}

/* the node for the current constant token: a character constant (char in C++, int in C),
   an integer or floating constant (its type from the token's flags byte through
   BCC_TYPE_PTR), or a string literal: adjacent literals are joined into the data pool by
   COLLECT_STRING_LITERAL and the node refers to STRING_LITERAL_SYMBOL with the offset in
   EXPR_RIGHT */
u16 PARSE_LITERAL(void)
{
    u16 node = 0;
    switch (CURRENT_TOKEN) {
    case 0x65:
        node = MAKE_INT_CONSTANT(CPP_MODE ? CHAR_TYPE : INT_TYPE, (i32)CURRENT_TOKEN_VALUE);
        break;
    case 0x32:
        node = MAKE_INT_CONSTANT(BCC_TYPE_AT(CURRENT_TOKEN_FLAGS), (i32)CURRENT_TOKEN_VALUE);
        break;
    case 0x33:
        /* DS:638B, the token's 10-byte value area */
        node = MAKE_REAL_CONSTANT(BCC_TYPE_AT(CURRENT_TOKEN_FLAGS), CURRENT_TOKEN_VALUE_P);
        break;
    case 0x34: {
        /* the original frame from BP-4: width, value */
        u16 mark = scratch_mark();
        farptr width = scratch_alloc(4), value = fp_add(width, 2);
        EMIT_ARGS(value, width);
        node = MAKE_SYMBOL_NODE(STRING_LITERAL_SYMBOL);
        EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
        u16 type = MAKE_STRING_TYPE((i16)W(width));
        EXPR_W(node, EXPR_TYPE) = type;
        EXPR_W(node, EXPR_RIGHT) = W(value);
        scratch_release(mark);
        return node;
    }
    }
    ADVANCE_TOKEN();
    return node;
}

/* a type name (specifiers and an abstract declarator, as in a cast or sizeof); returns the
   type.  Storage classes, friend and virtual are not allowed.  mode goes to the declaration
   parsers (3 for a type name) */
u16 PARSE_TYPE_NAME(u16 mode)
{
    /* the original frame from BP-14h */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x14);
    farptr third = fp_add(v, 1), second = fp_add(v, 2), first = fp_add(v, 3), spec = fp_add(v, 4);
    farptr fourth_value = fp_add(v, 8), third_value = fp_add(v, 0x0A), second_value = fp_add(v, 0x0C);
    farptr code = fp_add(v, 0x0E), value = fp_add(v, 0x10), context = fp_add(v, 0x12);
    W(context) = INT_TYPE;
    PARSE_DECL_SPECIFIERS(mode, code, first, second, context, spec, third);
    if (W(code) != 0x82 || B(first) || B(second))
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,
                          (i32)(B(first) ? STR_FRIEND_3_P : B(second) ? STR_VIRTUAL_3_P : NAME_TEXT_COPY(TOKEN_NAMES_AT(W(code)))), 0);
    PARSE_DECLARATOR(W(context), mode, value, second_value, third_value, fourth_value, spec, spec);
    u16 result = W(value);
    scratch_release(mark);
    return result;
}

/* C++: nonzero if the current identifier names a type and is followed by '(', an explicit
   constructor call or functional cast "T(x)" */
u8 IS_CONSTRUCTOR_CALL_AHEAD(void)
{
    if (CPP_MODE && CURRENT_TOKEN == TOK_IDENT) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 1)
            return TYPE_LOOKUP((u16)CURRENT_TOKEN_VALUE) != 0;
    }
    return 0;
}

/* at '(' where an operand is expected: nonzero if a cast follows.  In C a type keyword or
   type name after '(' is enough; in C++ the whole parenthesised part must be a type name.
   '~' is excluded (a destructor call) */
u8 IS_CAST_AHEAD(void)
{
    PEEK_TOKEN();
    if (!TOKEN_IS_TYPE_START_BODY(TOKEN_TYPE_P) || TOKEN_TYPE == 0x2B)
        return 0;
    if (CPP_MODE)
        return IS_PAREN_TYPE_NAME(3);
    return 1;
}

/* "(type)": a cast node whose operand is filled in when the cast is reduced */
u16 PARSE_CAST_TYPE(void)
{
    ADVANCE_TOKEN();
    u16 result = MAKE_CAST_NODE(PARSE_TYPE_NAME(3), 0);
    REQUIRE_TOKEN_BODY(2, 0xDD);
    return result;
}

/* after sizeof: for "sizeof(type)" the size as a size_t constant (a reference counts as
   the referred type; size 0 is an error).  Otherwise 0, and sizeof is a prefix operator on
   the expression that follows */
u16 PARSE_SIZEOF_TYPE(void)
{
    u16 node;
    ADVANCE_TOKEN();
    PEEK_TOKEN();
    if (CURRENT_TOKEN == TOK_LPAREN && TOKEN_IS_TYPE_START_BODY(TOKEN_TYPE_P)) {
        ADVANCE_TOKEN();
        u16 type = PARSE_TYPE_NAME(3);
        if ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20))
            type = TYPE_W(type, TYPE_TARGET);
        if (!TYPE_SIZE(type))
            REPORT_CURRENT_TOKEN(MSG_SIZE_TYPE_UNKNOWN_ZERO);
        u32 size = CALL_FAR(TOKEN_CONVERT, A32((u32)TYPE_SIZE(type)), A16(TYPE_W(SIZE_T_TYPE, TYPE_KIND)));
        node = MAKE_INT_CONSTANT(SIZE_T_TYPE, (i32)size);
        REQUIRE_TOKEN_BODY(2, 0xE9);
    } else
        node = 0;
    return node;
}

/* one expression; returns its tree.  flag nonzero allows the comma operator at the top
   level; otherwise a comma outside parentheses, brackets and ?: ends the expression.  stop
   is the token the caller expects after it: an unmatched ')' or ']' ends the expression
   quietly (stop 2 or 4), and it is the recovery point after an error.  In the loop, for
   each token: node is an operand built from it (if any), kind what to do with it (0 push
   the operand, 1 member operator, 2 call: push the operator and the argument list, 3 an
   operator), tok the operator code to push, prec its precedence, expect 1 while an operand
   is expected next, hold that the current token must not be skipped */
u16 PARSE_EXPRESSION_PREC(u8 flag, u16 stop)
{
    i16 parens = 0, brackets = 0, questions;
    u16 result;
    if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & EXPR_START_FLAG_MASK)) {
        result = REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_EXPECTED, 0);
        IN_ERROR_RECOVERY = 1;
    } else {
        u16 saved_offset = OPERATOR_STACK_OFFSET;
        u16 saved_list = OPERAND_LIST_HEAD;
        u16 saved_base = OPERAND_LIST_BASE;
        i16 saved_depth = OPERATOR_STACK_DEPTH;
        INIT_EXPR_PARSER();
        parens = 0;
        brackets = 0;
        questions = 0;
        u8 expect = 1, prec, hold;
        do {
            u16 node = 0;
            i16 kind = 3;
            i16 tok = CURRENT_TOKEN;
            hold = 0;
            prec = 0x7E;
            switch (tok) {
            case 0x3A: case 0x3B: case 0x3C: case 0x3D: case 0x3E: case 0x3F: case 0x40: case 0x41: case 0x45:
                if (CPP_MODE && (PEEK_TOKEN(), TOKEN_TYPE) == 1) {
                    node = PARSE_TYPE_CONSTRUCTOR_CALL();
                    kind = 0;
                    expect = 0;
                    prec = 2;
                } else {
                    REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                    ADVANCE_TOKEN();
                    IN_ERROR_RECOVERY = 1;
                }
                break;
            /* token 9 as an operand: the address of the variable arguments */
            case 0x09:
                node = MAKE_ADDR_OF_CONTEXT_NODE();
                ADVANCE_TOKEN();
                kind = 0;
                expect = 0;
                prec = 2;
                break;
            /* '::' starts ::delete, ::new or a qualified name */
            case 0x67:
                PEEK_TOKEN();
                if (TOKEN_TYPE == 0x69) {
                    ADVANCE_TOKEN();
                    tok = 0x63;
                    prec = 0x0A;
                    expect = 1;
                    break;
                }
                PEEK_TOKEN();
                if (TOKEN_TYPE == 0x6C) {
                    node = PARSE_NEW_EXPRESSION();
                    kind = 0;
                    prec = 2;
                    expect = 0;
                    break;
                }
                /* fall through */
            case 0x31:
            case 0x6D:
                if (IS_CONSTRUCTOR_CALL_AHEAD())
                    node = PARSE_TYPE_CONSTRUCTOR_CALL();
                else
                    node = CPP_MODE ? PARSE_QUALIFIED_NAME() : PARSE_IDENTIFIER();
                kind = 0;
                expect = 0;
                prec = 2;
                break;
            case 0x72:
                kind = 0;
                node = CTOR_THIS_SYMBOL == 0 ? REPORT_EXPR_ERROR_PLAIN(MSG_THIS_CAN_ONLY_USED, 0) : BUILD_THIS_NODE(CTOR_THIS_SYMBOL);
                ADVANCE_TOKEN();
                expect = 0;
                prec = 2;
                break;
            case 0x32: case 0x33: case 0x34: case 0x65:
                node = PARSE_LITERAL();
                kind = 0;
                expect = 0;
                prec = 2;
                break;
            case 0x6C:
                node = PARSE_NEW_EXPRESSION();
                kind = 0;
                expect = 0;
                prec = 2;
                break;
            case 0x2F:
            case 0x30:
                kind = 1;
                expect = 0;
                prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                break;
            case 0x64:
            case 0x66:
                prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                if (!CPP_MODE) {
                    REPORT_DIAGNOSTIC(MSG_ONLY_ALLOWED_C, (i32)NAME_TEXT_COPY(TOKEN_NAMES_AT(tok)), 0);
                    IN_ERROR_RECOVERY = 1;
                    ADVANCE_TOKEN();
                }
                if (expect) {
                    if (CPP_MODE)
                        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                    IN_ERROR_RECOVERY = 1;
                    ADVANCE_TOKEN();
                }
                expect = 1;
                break;
            case 0x69:
                expect = 1;
                prec = 0x0A;
                break;
            case 0x2C:
                node = PARSE_SIZEOF_TYPE();
                if (node == 0) {
                    hold = 1;
                    expect = 1;
                    prec = 0x0A;
                } else {
                    kind = 0;
                    expect = 0;
                    prec = 2;
                }
                break;
            /* ',': ends the expression (prec 7Eh) unless a comma operator is allowed here */
            case 0x08:
                if (flag == 0 && parens == 0 && brackets == 0 && questions == 0)
                    break;
                expect = 1;
                prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                break;
            case 0x20:
                questions++;
                expect = 1;
                prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                break;
            case 0x01:
                if (expect && IS_CAST_AHEAD()) {
                    tok = 0x61;
                    node = PARSE_CAST_TYPE();
                    hold = 1;
                    prec = 0x0A;
                } else if (expect) {
                    tok = 1;
                    parens++;
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(1);
                } else {
                    tok = 0x5F;
                    node = PARSE_ARGUMENT_LIST(1);
                    kind = 2;
                    prec = 2;
                }
                break;
            case 0x02:
                if (parens == 0) {
                    if (stop == 2 || stop == 4)
                        hold = 1;
                    else {
                        REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_CHECK);
                        IN_ERROR_RECOVERY = 1;
                    }
                    tok = 0x82;
                } else {
                    parens--;
                    expect = 0;
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                }
                break;
            case 0x03:
                brackets++;
                if (expect && (top() == 0x69 || top() == 0x63))
                    tok = 0x60;
                expect = 1;
                prec = BINARY_PRECEDENCE_BY_TOKEN_AT(3);
                break;
            case 0x04:
                if (brackets == 0) {
                    if (stop == 2 || stop == 4)
                        hold = 1;
                    else {
                        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                        IN_ERROR_RECOVERY = 1;
                    }
                    tok = 0x82;
                } else {
                    brackets--;
                    expect = top() == 0x60;
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                }
                break;
            case 0x21:
                if (questions == 0) {
                    if (stop == 0x21)
                        hold = 1;
                    else {
                        REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_FOUND);
                        IN_ERROR_RECOVERY = 1;
                    }
                } else {
                    questions--;
                    expect = 1;
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(0x21);
                }
                break;
            case 0x2D:
                if (!expect) {
                    tok = 0x59;
                    prec = 6;
                } else
                    prec = 0x0A;
                break;
            case 0x2E:
                if (!expect) {
                    tok = 0x5A;
                    prec = 6;
                } else
                    prec = 0x0A;
                break;
            case 0x16:
                if (expect) {
                    tok = 0x5B;
                    prec = 0x0A;
                } else
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                expect = 1;
                break;
            case 0x1B:
                if (expect) {
                    tok = 0x5C;
                    prec = 0x0A;
                } else
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                expect = 1;
                break;
            case 0x18:
                if (expect) {
                    tok = 0x5D;
                    prec = 0x0A;
                } else
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                expect = 1;
                break;
            case 0x17:
                if (expect) {
                    tok = 0x5E;
                    prec = 0x0A;
                } else
                    prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                expect = 1;
                break;
            default:
                prec = BINARY_PRECEDENCE_BY_TOKEN_AT(tok);
                if (expect) {
                    prec = PREFIX_PRECEDENCE_BY_TOKEN_AT(tok);
                    if (prec == 0x7C) {
                        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                        IN_ERROR_RECOVERY = 1;
                        ADVANCE_TOKEN();
                    }
                }
                expect = 1;
            }
            /* reduce what binds tighter, then push this token's part */
            while (!IN_ERROR_RECOVERY && STACK_PRECEDENCE_BY_OP_AT(top()) <= prec)
                REDUCE_OPERATOR();
            if (IN_ERROR_RECOVERY)
                prec = 0x7E;
            else
                switch (kind) {
                case 0:
                    OPERAND_LIST_HEAD = MAKE_LIST_NODE(node, OPERAND_LIST_HEAD);
                    break;
                case 1: {
                    u16 member = PARSE_MEMBER_OPERATOR();   /* pascal: before the head is read */
                    OPERAND_LIST_HEAD = MAKE_LIST_NODE(member, OPERAND_LIST_HEAD);
                    break;
                }
                case 2:
                    PUSH_OPERATOR((u16)tok);
                    OPERAND_LIST_HEAD = MAKE_LIST_NODE(node, OPERAND_LIST_HEAD);
                    break;
                default:
                    if (prec != 0x7E) {
                        if (tok != 0x82)
                            PUSH_OPERATOR((u16)tok);
                        if (node)
                            OPERAND_LIST_HEAD = MAKE_LIST_NODE(node, OPERAND_LIST_HEAD);
                        if (!hold)
                            ADVANCE_TOKEN();
                    }
                }
        } while (prec != 0x7E);
        result = POP_OPERAND();
        if (!END_EXPR_PARSER()) {
            if (EXPR_W(result, EXPR_OP) != 0)
                result = REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SYNTAX, result);
            IN_ERROR_RECOVERY = 1;
        }
        OPERAND_LIST_BASE = saved_base;
        OPERATOR_STACK_DEPTH = saved_depth;
        OPERATOR_STACK_OFFSET = saved_offset;
        OPERAND_LIST_HEAD = saved_list;
    }
    /* recovery: skip to the stop token, stepping over the closing parts of groups that were
       open in the failed expression */
    if (IN_ERROR_RECOVERY) {
        u8 again;
        do {
            SKIP_TO_SYNC_TOKEN(stop);
            if (CURRENT_TOKEN == TOK_RPAREN)
                parens = parens - 1;
            if (CURRENT_TOKEN == TOK_RBRACKET)
                brackets = brackets - 1;
            again = CURRENT_TOKEN == stop &&
                    ((CURRENT_TOKEN == TOK_RPAREN && parens > 0) || (CURRENT_TOKEN == TOK_RBRACKET && brackets > 0));
            if (again)
                ADVANCE_TOKEN();
        } while (again);
    }
    return result;
}

/* an expression without a top-level comma operator */
u16 PARSE_ASSIGNMENT_EXPR(u16 stop)
{
    return PARSE_EXPRESSION_PREC(0, stop);
}

/* a full expression, comma operator included */
u16 PARSE_COMMA_EXPRESSION(u16 stop)
{
    return PARSE_EXPRESSION_PREC(1, stop);
}

/* "(arg, arg, ...)": a chain of list nodes, one per argument (EXPR_RIGHT the argument,
   EXPR_LEFT the next), or 0 for "()".  flag picks the message for a missing ')': nonzero
   for a call */
u16 PARSE_ARGUMENT_LIST(u16 flag)
{
    u16 head = 0;
    REQUIRE_TOKEN_BODY(1, 0xDA);
    if (CURRENT_TOKEN != TOK_RPAREN) {
        head = MAKE_LIST_NODE(PARSE_EXPRESSION_PREC(0, 2), 0);
        u16 tail = head;
        while (CURRENT_TOKEN == TOK_COMMA) {
            ADVANCE_TOKEN();
            u16 cell = MAKE_LIST_NODE(PARSE_EXPRESSION_PREC(0, 2), 0);
            EXPR_W(tail, EXPR_LEFT) = cell;
            tail = EXPR_W(tail, EXPR_LEFT);
        }
        EXPR_W(tail, EXPR_LEFT) = 0;
    }
    REQUIRE_TOKEN_BODY(2, flag ? 0x1A : 0xE9);
    return head;
}

/* resets the operator stack pool (a pool header: segment, step, unit, used) and both
   stacks for a new compile (called from INIT_PARSER) */
void RESET_EXPR_PARSER(void)
{
    W(fp_add(OPERATOR_STACK_POOL_P, 2)) = 0;          /* step */
    W(fp_add(OPERATOR_STACK_POOL_P, 4)) = 0;          /* unit */
    W(fp_add(OPERATOR_STACK_POOL_P, 6)) = 0;          /* used */
    POOL_INIT(OPERATOR_STACK_POOL_P, 0);
    OPERATOR_STACK_OFFSET = 0;
    OPERAND_LIST_HEAD = 0;
    OPERAND_LIST_BASE = 0;
}

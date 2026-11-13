/* exprpool.c: from bcc20/src/expr/EXPRPOOL.C: the toolkit for expression trees of the C++
   front end (the C front end has EXPRMAKE.C): 1Ah-byte nodes in EXPR_POOL_SEG, allocated
   and freed here, the common node shapes (constants, symbol leaves, unary, binary, cast,
   call and list nodes), compiler temporaries, and questions about trees (an lvalue? free
   of side effects? a constant? a link-time constant? two trees equal?), and tree copies.
   MAKE_UNARY_NODE, MAKE_BINARY_NODE and MAKE_CONDITIONAL_NODE take a token code (TOKEN.H),
   turned into an operator by TOKEN_TO_OPERATOR; their nodes get flag 20h, "not analysed,
   may be an overloaded operator".  Operators without a name: 0 an error node, 1 a symbol
   leaf, 3 a long double constant, 7 probably the "..." leaf, 2Bh an argument-list cell,
   35h a cast, 36h a call, 38h a member name, 39h a member, 4Ah a field reference.
   EXPR_OP_FLAGS[op]: 4 a leaf (its operand words are data), 1 a side effect, 2
   commutative. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "protos.h"
#include "calls.h"

#define OP(n) EXPR_W((n), EXPR_OP)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define TYPE_OF(n) EXPR_W((n), EXPR_TYPE)
#define FLAGS(t) EXPR_FLAGS_AT(TYPE_W((t), TYPE_KIND))
#define OP_FLAGS(n) EXPR_OP_FLAGS_AT(OP(n))
#define STORAGE(sym) (SYM_B((sym), SYM_STORAGE_CLASS) >> 3)

/* token op as its binary operator, or with flag set as the unary operator of the same
   token: + 49h (unary plus), - negation, * dereference, & address, code 17 42h */
u16 TOKEN_TO_OPERATOR(u16 op, u8 flag)
{
    u16 code = TOKEN_OPERATOR_CODE_AT(op);
    if (!flag)
        return code;
    switch (code) {
    case 8: return 0x49;
    case 9: return 0x2E;
    case 10: return 0x31;
    case 15: return 0x32;
    case 17: return 0x42;
    }
    return code;
}

/* a new zeroed node with the current token's source position */
u16 ALLOC_EXPR_NODE(void)
{
    u16 node = POOL_ALLOC_REUSE(EXPR_POOL_SEG_P, 0x1A);
    RTL_MEMSET(MK_FP(EXPR_POOL_SEG, node), 0, 0x1A);
    EXPR_W(node, EXPR_SRC_FILE) = CURRENT_TOKEN_FILE;
    EXPR_W(node, EXPR_SRC_LINE) = CURRENT_TOKEN_LINE;
    EXPR_W(node, EXPR_SRC_WORD3) = CURRENT_TOKEN_LOC_WORD3;
    return node;
}

/* the whole pool emptied at once (RESET_EXPR_POOL's body) */
void RESET_EXPR_POOL_ALT(void)
{
    EXPR_POOL_USED = 0;
    EXPR_POOL_UNIT = 2;
}

/* every node of a tree freed without recursion: a node with a right operand is pushed on
   a stack threaded through its own EXPR_RIGHT while the right subtree goes; popped, its
   right word is cleared and it is freed after its left operand is taken.  Leaves are freed
   without looking at their operand words */
void FREE_EXPR_TREE(u16 node)
{
    u16 stack = 0;
    for (;;) {
        if (!node) {
            if (!stack)
                return;
            node = stack;
            stack = RIGHT(node);
            RIGHT(node) = 0;
        }
        if (OP_FLAGS(node) & 4) {
            POOL_FREE_ITEM(EXPR_POOL_SEG_P, node);
            node = 0;
        } else if (RIGHT(node)) {
            u16 next = RIGHT(node);
            RIGHT(node) = stack;
            stack = node;
            node = next;
        } else {
            u16 next = node;
            node = LEFT(node);
            POOL_FREE_ITEM(EXPR_POOL_SEG_P, next);
        }
    }
}

void FREE_EXPR_NODE(u16 node)
{
    POOL_FREE_ITEM(EXPR_POOL_SEG_P, node);
}

/* one cell (operator 2Bh, type void) of an argument list: EXPR_RIGHT the item, EXPR_LEFT
   the next cell */
u16 MAKE_LIST_NODE(u16 item, u16 next)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 0x2B;
    EXPR_W(node, EXPR_TYPE) = VOID_TYPE;
    RIGHT(node) = item;
    LEFT(node) = next;
    return node;
}

/* an integer constant of type with value, marked analysed */
u16 MAKE_INT_CONSTANT(u16 type, i32 value)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = EOP_CONST;
    EXPR_W(node, EXPR_TYPE) = type;
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    EXPR_L(node, EXPR_VALUE) = value;
    return node;
}

/* a floating constant (operator 3) holding the 10-byte long double at value */
u16 MAKE_REAL_CONSTANT(u16 type, farptr value)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 3;
    EXPR_W(node, EXPR_TYPE) = type;
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG, node + EXPR_LEFT), value, 10);
    return node;
}

/* a symbol leaf (operator 1), not analysed */
u16 MAKE_SYMBOL_NODE(u16 symbol)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 1;
    LEFT(node) = symbol;
    RIGHT(node) = 0;
    EXPR_W(node, EXPR_SCOPE_CLASS) = 0;
    return node;
}

/* a member name leaf (operator 38h); extra in EXPR_NAME_KIND (2 a conversion operator) */
u16 MAKE_MEMBER_NAME_NODE(u16 symbol, u16 extra)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 0x38;
    LEFT(node) = symbol;
    RIGHT(node) = 0;
    EXPR_W(node, EXPR_SCOPE_CLASS) = 0;
    EXPR_W(node, EXPR_NAME_KIND) = extra;
    return node;
}

/* a field reference leaf (operator 4Ah) holding value */
u16 MAKE_FIELD_REF_NODE(u16 value)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 0x4A;
    LEFT(node) = value;
    RIGHT(node) = 0;
    return node;
}

/* a member node (operator 39h): type, offset (MEMB_VALUE), name and, for a bitfield
   (MEMB_FLAGS 40h), shift and width with node flag 4.  The original takes the source
   position as a structure {file, line, word3} by value: the port has its words in the
   order they are pushed (genadapters' STRUCT_ARGUMENTS) */
u16 MAKE_MEMBER_NODE(u16 member, u16 word3, u16 line, u16 file)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    EXPR_W(node, EXPR_OP) = 0x39;
    EXPR_W(node, EXPR_SRC_FILE) = file;
    EXPR_W(node, EXPR_SRC_LINE) = line;
    EXPR_W(node, EXPR_SRC_WORD3) = word3;
    EXPR_W(node, EXPR_TYPE) = MEMBER_W(member, MEMB_TYPE);
    LEFT(node) = MEMBER_W(member, MEMB_VALUE);
    EXPR_B(node, EXPR_MEMB_BIT_SHIFT) = 0;
    EXPR_B(node, EXPR_MEMB_BIT_WIDTH) = 0;
    EXPR_W(node, EXPR_MEMBER_NAME) = MEMBER_W(member, MEMB_NAME);
    if (MEMBER_B(member, MEMB_FLAGS) & 0x40) {
        EXPR_B(node, EXPR_NODE_FLAGS) |= 4;
        EXPR_B(node, EXPR_MEMB_BIT_SHIFT) = MEMBER_B(member, MEMB_BITFIELD) & 7;
        EXPR_B(node, EXPR_MEMB_BIT_WIDTH) = MEMBER_B(member, MEMB_BITFIELD) >> 3;
    }
    EXPR_W(node, EXPR_TYPE) = MEMBER_W(member, MEMB_TYPE);    /* a second time, as in the original */
    return node;
}

/* & of an operator 7 leaf of type int, typed pointer to int, both analysed: probably the
   "..." leaf the C parser makes inside a variadic function, as va_start uses it */
u16 MAKE_ADDR_OF_CONTEXT_NODE(void)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 7;
    LEFT(node) = 0;
    RIGHT(node) = 0;
    EXPR_W(node, EXPR_SCOPE_CLASS) = 0;
    EXPR_W(node, EXPR_TYPE) = INT_TYPE;
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    node = MAKE_UNARY_NODE(0x1B, node);
    u16 pointer = MAKE_POINTER_TYPE(INT_TYPE, 0, 0);
    EXPR_W(node, EXPR_TYPE) = pointer;
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    return node;
}

/* an unanalysed unary node for token op on operand */
u16 MAKE_UNARY_NODE(u16 op, u16 operand)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_B(node, EXPR_NODE_FLAGS) = 0x20;
    EXPR_W(node, EXPR_OP) = TOKEN_TO_OPERATOR(op, 1);
    LEFT(node) = operand;
    RIGHT(node) = 0;
    return node;
}

/* an unanalysed binary node for token op */
u16 MAKE_BINARY_NODE(u16 op, u16 left, u16 right)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_B(node, EXPR_NODE_FLAGS) = 0x20;
    EXPR_W(node, EXPR_OP) = TOKEN_TO_OPERATOR(op, 0);
    LEFT(node) = left;
    RIGHT(node) = right;
    return node;
}

/* left op (first : second); with op ? the conditional (token 21h is :) */
u16 MAKE_CONDITIONAL_NODE(u16 op, u16 left, u16 first, u16 second)
{
    u16 node = MAKE_BINARY_NODE(0x21, first, second);
    return MAKE_BINARY_NODE(op, left, node);
}

/* a cast (operator 35h) of operand to type, with the operand's source position */
u16 MAKE_CAST_NODE(u16 type, u16 operand)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 0x35;
    LEFT(node) = operand;
    RIGHT(node) = 0;
    EXPR_W(node, EXPR_TYPE) = type;
    if (operand)
        for (int i = 0; i < 6; i++)
            EXPR_B(node, EXPR_SRC_FILE + i) = EXPR_B(operand, EXPR_SRC_FILE + i);
    return node;
}

/* a call (operator 36h) of value with up to five arguments (0 absent) in a list in
   EXPR_RIGHT: calls the compiler makes itself */
u16 MAKE_CALL_NODE(u16 value, u16 first_arg, u16 second_arg, u16 third_arg, u16 fourth_arg, u16 fifth_arg)
{
    u16 node = ALLOC_EXPR_NODE();
    EXPR_W(node, EXPR_OP) = 0x36;
    LEFT(node) = value;
    u16 list = 0;
    if (fifth_arg)
        list = MAKE_LIST_NODE(fifth_arg, list);
    if (fourth_arg)
        list = MAKE_LIST_NODE(fourth_arg, list);
    if (third_arg)
        list = MAKE_LIST_NODE(third_arg, list);
    if (second_arg)
        list = MAKE_LIST_NODE(second_arg, list);
    if (first_arg)
        list = MAKE_LIST_NODE(first_arg, list);
    RIGHT(node) = list;
    return node;
}

/* the expression for one symbol (token 1Dh as its unary operator), built, analysed and
   simplified with CURRENT_CLASS_TYPE the symbol's class for a member; the symbol is marked
   used (SYM_FLAGS 4), and in C++ a function is queued, probably for its body later */
u16 BUILD_SYMBOL_EXPR(u16 symbol)
{
    u16 saved = CURRENT_CLASS_TYPE;
    CURRENT_CLASS_TYPE = (SYM_B(symbol, SYM_FLAGS) & 0x10) ? SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE) : 0;
    u16 result = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(symbol)), 0), 0);
    SYM_B(symbol, SYM_FLAGS) |= 4;
    if (CPP_MODE && TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND) == TK_FUNCTION)
        QUEUE_DEFERRED_SYMBOL(symbol);
    CURRENT_CLASS_TYPE = saved;
    return result;
}

/* the next temporary's name, "_$" and TEMP_NAME_COUNTER in base 26 as letters (A, B...,
   least significant first), as a name record */
u16 GENERATE_TEMP_NAME(void)
{
    u16 mark = scratch_mark();
    farptr name = scratch_alloc(20);
    farptr p = name;
    u16 count = TEMP_NAME_COUNTER++;
    B(p) = '_';
    p = fp_add(p, 1);
    B(p) = '$';
    p = fp_add(p, 1);
    do {
        B(p) = (u8)(count % 26 + 'A');
        p = fp_add(p, 1);
        count /= 26;
    } while (count);
    B(p) = 0;
    u16 record = BCC_SYMBOL_CREATE(name, 0);
    scratch_release(mark);
    return record;
}

/* a static temporary of type: class 3 at file level, 4 in a function; global puts it in
   the data segment (initialised), else in BSS */
u16 CREATE_TEMP_SYMBOL(u16 type, u8 global)
{
    u16 symbol = ALLOC_SYMBOL_ENTRY(GENERATE_TEMP_NAME(), 5);
    SYM_W(symbol, SYM_TYPE) = type;
    SYM_B(symbol, SYM_FLAGS) = 0x22;
    SYM_W(symbol, SYM_STORAGE) = 0;
    if (global)
        SYM_B(symbol, SYM_FLAGS) |= 5;
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | (((CURRENT_SCOPE == GLOBAL_SCOPE ? 3 : 4) & 0x1F) << 3);
    u16 prepared = PREPARE_SYMBOL(symbol);
    CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(global ? DATA_SEGMENT_ID : BSS_SEGMENT_ID));
    C0MARK(1);
    return symbol;
}

/* an automatic (class 5) temporary of type, registered as a variable of the function; in
   a nested block with no scope of its own yet, a scope is opened first */
u16 CREATE_LOCAL_TEMP(u16 type)
{
    if (NO_ERRORS_YET && SCOPE_W(CURRENT_SCOPE, SCOPE_NEST_LEVEL) != BLOCK_NEST_LEVEL) {
        PUSH_SCOPE(0);
        if (INLINE_EXPANSION_DEPTH)
            SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK) = SCOPE_W(SCOPE_W(CURRENT_SCOPE, SCOPE_PARENT), SCOPE_ENTER_BLOCK);
        else
            APPEND_SCOPE_ENTER_BLOCK();
    }
    u16 symbol = ALLOC_SYMBOL_ENTRY(GENERATE_TEMP_NAME(), 5);
    SYM_W(symbol, SYM_TYPE) = type;
    SYM_B(symbol, SYM_FLAGS) |= 0x26;
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x28;
    SYM_W(symbol, SYM_STORAGE) = 0;
    REGISTER_SYMBOL_VARIABLE(symbol);
    return symbol;
}

/* 1 when the tree contains an error node (operator 0) */
u8 EXPR_HAS_ERROR(u16 node)
{
    if (!node)
        return 0;
    if (OP(node) == 0)
        return 1;
    if (OP_FLAGS(node) & 4)
        return 0;
    return EXPR_HAS_ERROR(LEFT(node)) || EXPR_HAS_ERROR(RIGHT(node));
}

/* message code (with first and second) at the node's source line, unless code is 0 or the
   tree already holds an error (reported before); the tree freed and a new error node
   (operator 0, flag 1) returned */
u16 REPORT_EXPR_ERROR(u16 code, farptr first, i32 second, u16 node)
{
    if (code && !EXPR_HAS_ERROR(node)) {
        if (!node || !EXPR_W(node, EXPR_SRC_LINE))
            REPORT_DIAGNOSTIC((i16)code, (i32)first, second);
        else
            REPORT_DIAGNOSTIC_AT((i16)code, (i32)first, second, EXPR_W(node, EXPR_SRC_LINE), 0);
    }
    FREE_EXPR_TREE(node);
    node = ALLOC_EXPR_NODE();
    EXPR_B(node, EXPR_NODE_FLAGS) = 1;
    return node;
}

u16 REPORT_EXPR_ERROR_PLAIN(u16 code, u16 node)
{
    return REPORT_EXPR_ERROR(code, 0, 0, node);
}

/* a node's operands exchanged */
u16 SWAP_OPERANDS(u16 node)
{
    u16 left = LEFT(node);
    LEFT(node) = RIGHT(node);
    RIGHT(node) = left;
    return node;
}

/* left, right, or just the one that is not 0; the comma needs no operator lookup */
u16 JOIN_COMMA_EXPR(u16 left, u16 right)
{
    if (!left)
        return right;
    if (!right)
        return left;
    u16 result = MAKE_BINARY_NODE(8, left, right);
    EXPR_B(result, EXPR_NODE_FLAGS) &= (u8)~0x20;
    return result;
}

static int void_pointer(u16 type)
{
    return (FLAGS(type) & 0x14) && TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_VOID;
}

/* 1 when two pointer types may convert into each other as far as their segment goes:
   anything not a near pointer, and void pointers, pass; near pointers need the same
   TYPE_PTR_MODE (3 and 4 together when SS probably equals DS) and the same base name for
   based pointers */
u8 NEAR_PTR_BASES_MATCH(u16 left, u16 right)
{
    if (TYPE_W(left, TYPE_KIND) != TK_NEAR_PTR || void_pointer(left) || void_pointer(right))
        return 1;
    i16 lsize = (i8)TYPE_B(left, TYPE_PTR_MODE), rsize = (i8)TYPE_B(right, TYPE_PTR_MODE);
    if (lsize != rsize) {
        if ((lsize == 3 && rsize == 4) || (lsize == 4 && rsize == 3))
            return !(OPTION_DS_NOT_SS || ((i8)MODEL_FAR_DATA & !(i8)OPTION_SS_EQUALS_DS));
        return 0;
    }
    if (TYPE_W(left, TYPE_PTR_BASE) || TYPE_W(right, TYPE_PTR_BASE)) {
        if (!TYPE_W(left, TYPE_PTR_BASE) || !TYPE_W(right, TYPE_PTR_BASE) ||
            COMPARE_NAME(MK_FP(POOL_HASH, TYPE_W(left, TYPE_PTR_BASE)), MK_FP(POOL_HASH, TYPE_W(right, TYPE_PTR_BASE))))
            return 0;
    }
    return 1;
}

/* 1 when a value of type right may be assigned to (or initialise) type left without a
   cast.  Arithmetic types always mix; with strict also integers and pointers (C, or C++
   when no reference is involved).  Member pointers need a base class relation and the
   same target; pointers: void * on the left takes anything (and in C void * on the right
   converts to anything), else qualifiers may be added but not dropped and the targets
   must be compatible or, in C++, the right target derived from the left.  In C++ a class
   object converts to a base class */
u8 C7_TYPE_COMPAT(u16 left, u16 right, u8 strict)
{
    if (TYPES_COMPATIBLE(left, right, 1) || ((FLAGS(left) & 3) && (FLAGS(right) & 3)))
        return 1;
    if (TYPE_W(left, TYPE_KIND) == TK_SEG_PTR && (FLAGS(right) & 0x14) && TYPE_W(right, TYPE_KIND) != TK_SEG_PTR)
        return 0;
    if (strict && (FLAGS(left) & 0x15) && (FLAGS(right) & 0x15)) {
        if (!CPP_MODE || !(((FLAGS(left) & 0x14) && (TYPE_B(left, TYPE_ATTRS) & 0x20)) ||
                           ((FLAGS(right) & 0x14) && (TYPE_B(right, TYPE_ATTRS) & 0x20))))
            return 1;
    }
    if (TYPE_W(left, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(left, TYPE_PTR_MODE) == 0x0B &&
        TYPE_W(right, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(right, TYPE_PTR_MODE) == 0x0B) {
        u16 lbase = TYPE_W(left, TYPE_TARGET), rbase = TYPE_W(right, TYPE_TARGET);
        if (!IS_BASE_CLASS(TYPE_W(rbase, TYPE_MEMBER_CLASS), TYPE_W(lbase, TYPE_MEMBER_CLASS), 1))
            return 0;
        if (TYPE_W(lbase, TYPE_KIND) == TYPE_W(rbase, TYPE_KIND) && TYPE_W(lbase, TYPE_KIND) == TK_FUNCTION)
            return SAME_SIGNATURE(lbase, rbase);
        u16 lsave = TYPE_W(lbase, TYPE_MEMBER_CLASS), rsave = TYPE_W(rbase, TYPE_MEMBER_CLASS);
        TYPE_W(lbase, TYPE_MEMBER_CLASS) = 0;
        TYPE_W(rbase, TYPE_MEMBER_CLASS) = 0;
        u8 same = TYPES_COMPATIBLE(lbase, rbase, 1);
        TYPE_W(lbase, TYPE_MEMBER_CLASS) = lsave;
        TYPE_W(rbase, TYPE_MEMBER_CLASS) = rsave;
        return same;
    }
    if ((FLAGS(left) & 0x14) && (FLAGS(right) & 0x14) && NEAR_PTR_BASES_MATCH(left, right)) {
        if (void_pointer(left) || (!CPP_MODE && void_pointer(right)))
            return 1;
        if ((TYPE_B(left, TYPE_ATTRS) & 0x20) == (TYPE_B(right, TYPE_ATTRS) & 0x20)) {
            u16 lbase = TYPE_W(left, TYPE_TARGET), rbase = TYPE_W(right, TYPE_TARGET);
            if ((TYPE_B(lbase, TYPE_ATTRS) & 1) < (TYPE_B(rbase, TYPE_ATTRS) & 1) ||
                (TYPE_B(lbase, TYPE_ATTRS) & 2) < (TYPE_B(rbase, TYPE_ATTRS) & 2))
                return 0;
            if ((TYPE_B(left, TYPE_ATTRS) & 0x20) && TYPE_W(lbase, TYPE_KIND) == TK_ARRAY && TYPE_W(rbase, TYPE_KIND) == TK_ARRAY) {
                if (TYPE_L(lbase, TYPE_ARRAY_COUNT) == 0 || TYPE_L(rbase, TYPE_ARRAY_COUNT) == TYPE_L(lbase, TYPE_ARRAY_COUNT))
                    return TYPES_COMPATIBLE(TYPE_W(lbase, TYPE_TARGET), TYPE_W(rbase, TYPE_TARGET), 1);
                return 0;
            }
            if (TYPES_COMPATIBLE(lbase, rbase, 1))
                return 1;
            if (CPP_MODE && (FLAGS(lbase) & 0x40) && (FLAGS(rbase) & 0x40))
                return IS_BASE_CLASS(lbase, rbase, 1);
        }
    } else if (CPP_MODE && (FLAGS(left) & 0x40) && (FLAGS(right) & 0x40))
        return IS_BASE_CLASS(left, right, 1);
    return 0;
}

/* of two arithmetic types the one with the larger kind (kinds go by rank); 0 if either is
   missing */
u16 PICK_WIDER_TYPE(u16 first, u16 second)
{
    if (!first || !second)
        return 0;
    return TYPE_I(first, TYPE_KIND) > TYPE_I(second, TYPE_KIND) ? first : second;
}

/* expression simplified when it is a constant expression, *zero set when it is the integer
   0, a null pointer constant */
u16 CHECK_NULL_CONSTANT(u16 expression, farptr zero)
{
    B(zero) = 0;
    if (IS_LINK_TIME_CONSTANT(expression)) {
        if (OP(expression) != EOP_CONST && OP(expression) != 3)
            expression = SIMPLIFY_EXPRESSION(expression, 0);
        if (OP(expression) == EOP_CONST)
            B(zero) = EXPR_L(expression, EXPR_VALUE) == 0;
    }
    return expression;
}

/* when type is a pointer (not a reference) and expression a null pointer constant, the
   constant takes the pointer type (a member function pointer needs a real conversion) */
u16 NULL_CONSTANT_TO_POINTER(u16 type, u16 expression)
{
    if (type && (FLAGS(type) & 0x14) && !(TYPE_B(type, TYPE_ATTRS) & 0x20)) {
        u16 mark = scratch_mark();
        farptr zero = scratch_alloc(2);
        expression = CHECK_NULL_CONSTANT(expression, zero);
        u8 is_zero = B(zero);
        scratch_release(mark);
        if (is_zero) {
            if (TYPE_W(type, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(type, TYPE_PTR_MODE) == 0x0B &&
                (FLAGS(type) & 0x14) && TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION)
                expression = CONVERT_EXPR_TO_TYPE(type, expression, 0);
            else
                EXPR_W(expression, EXPR_TYPE) = type;
        }
    }
    return expression;
}

/* 1 for expressions that designate an object: symbols, *p, members, a[i], p->m, p->*m, and
   . and .* when both sides are lvalues */
u8 IS_LVALUE(u16 expression)
{
    if (!expression || OP(expression) == 0)
        return 0;
    switch (OP(expression)) {
    case 0x01: case EOP_DEREF: case 0x38: case 0x39: case EOP_INDEX: case EOP_ARROW: case EOP_ARROW_STAR: case 0x4A:
        return 1;
    case EOP_DOT: case EOP_DOT_STAR:
        return IS_LVALUE(LEFT(expression)) && IS_LVALUE(RIGHT(expression));
    }
    return 0;
}

/* 1 when evaluating the tree changes nothing, so it may be evaluated twice or dropped; a
   null tree is free, an error node is not */
u8 IS_SIDE_EFFECT_FREE(u16 expression)
{
    if (!expression || OP(expression) == 0)
        return expression == 0;
    switch (OP(expression)) {
    case 0x01: case EOP_CONST: case 0x03: case 0x07: case 0x39:
        return 1;
    }
    return !(OP_FLAGS(expression) & 1) && IS_SIDE_EFFECT_FREE(LEFT(expression)) && IS_SIDE_EFFECT_FREE(RIGHT(expression));
}

/* 1 when the tree is a compile-time arithmetic constant (sizeof counts; anything touching
   an object or an address does not); a cast is constant when it makes an arithmetic
   link-time constant an integer */
i8 IS_CONSTANT_EXPR(u16 expression)
{
    if (!expression || OP(expression) == 0)
        return 1;
    switch (OP(expression)) {
    case 0x35:
        return (FLAGS(TYPE_OF(expression)) & 1) && (FLAGS(TYPE_OF(LEFT(expression))) & 3) &&
               IS_LINK_TIME_CONSTANT(LEFT(expression));
    case 0x01: case 0x03: case 0x07: case EOP_COMMA: case EOP_DEREF: case EOP_ADDR: case 0x38:
    case 0x39: case EOP_INDEX: case EOP_DOT: case EOP_DOT_STAR: case EOP_ARROW: case EOP_ARROW_STAR: case 0x48:
        return 0;
    case EOP_CONST: case EOP_SIZEOF:
        return 1;
    }
    return !(OP_FLAGS(expression) & 1) && IS_CONSTANT_EXPR(LEFT(expression)) && IS_CONSTANT_EXPR(RIGHT(expression));
}

/* 1 when the value is known by link time: constants, addresses of static objects and
   functions (storage class below 5), arrays with static storage, arithmetic on those */
u8 IS_LINK_TIME_CONSTANT(u16 expression)
{
    if (!expression || OP(expression) == 0)
        return 1;
    switch (OP(expression)) {
    case EOP_ADDR:
        if (OP(LEFT(expression)) == EOP_DEREF)
            return IS_LINK_TIME_CONSTANT(LEFT(LEFT(expression)));
        if (OP(LEFT(expression)) == 1)
            return STORAGE(LEFT(LEFT(expression))) < 5;
        return IS_LINK_TIME_CONSTANT(LEFT(expression));
    case 0x07: case EOP_COMMA: case EOP_DEREF: case 0x38: case 0x39: case EOP_INDEX: case EOP_DOT_STAR:
    case EOP_ARROW: case EOP_ARROW_STAR:
        return 0;
    case EOP_DOT:
        if (OP(LEFT(expression)) == 1)
            return STORAGE(LEFT(LEFT(expression))) < 5;
        return IS_LINK_TIME_CONSTANT(LEFT(expression));
    case 0x01: {
        u16 symbol = LEFT(expression);
        return STORAGE(symbol) == 9 || TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND) == TK_FUNCTION ||
               (STORAGE(symbol) < 5 && TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND) == TK_ARRAY);
    }
    case EOP_CONST: case 0x03: case EOP_SIZEOF: case 0x48:
        return 1;
    }
    return !(OP_FLAGS(expression) & 1) && IS_LINK_TIME_CONSTANT(LEFT(expression)) && IS_LINK_TIME_CONSTANT(RIGHT(expression));
}

/* 1 when the tree, with cancelling & and * pairs and the left parts of commas taken away,
   is a symbol (SYM_FLAGS 20h, not class 6) of the whole expression's type, which can be
   reused instead of copied to a temporary */
u8 IS_NAMED_OBJECT_EXPR(u16 expression)
{
    i16 depth = 0;
    u16 operation = 0x32;
    if (!expression || OP(expression) == 0)
        return 0;
    u16 type = TYPE_OF(expression);
    for (;;) {
        if (OP(expression) == EOP_DEREF || OP(expression) == 0x42 || OP(expression) == EOP_ADDR) {
            operation = OP(expression);
            depth += OP(expression) == EOP_DEREF ? 1 : -1;
            expression = LEFT(expression);
        } else if (OP(expression) == EOP_COMMA)
            expression = RIGHT(expression);
        else
            break;
    }
    return OP(expression) == 1 && (SYM_B(LEFT(expression), SYM_FLAGS) & 0x20) && STORAGE(LEFT(expression)) != 6 &&
           depth == 0 && operation == 0x32 && SYM_W(LEFT(expression), SYM_TYPE) == type;
}

/* 1 when two trees compute the same value: the same operators, types and leaves
   (commutative operators may have their operands swapped).  Without strict, calls and
   other side effects never compare equal; with strict they compare by structure */
u8 EXPRESSIONS_EQUAL(u16 first, u16 second, u8 strict)
{
    if (!first || !second)
        return first == second;
    if (TYPE_OF(first) != TYPE_OF(second) || OP(first) != OP(second))
        return 0;
    switch (OP(first)) {
    case 0x36: {
        if (!strict || !EXPRESSIONS_EQUAL(LEFT(first), LEFT(second), 1))
            return 0;
        u16 left = RIGHT(first), right = RIGHT(second);
        for (; left && right; left = LEFT(left), right = LEFT(right))
            if (!EXPRESSIONS_EQUAL(RIGHT(left), RIGHT(right), 1))
                return 0;
        return !left && !right;
    }
    case EOP_INC: case EOP_DEC:
        return strict && (EXPR_B(first, EXPR_NODE_FLAGS) & 2) == (EXPR_B(second, EXPR_NODE_FLAGS) & 2) &&
               EXPRESSIONS_EQUAL(LEFT(first), LEFT(second), 1);
    case EOP_CONST:
        return EXPR_L(first, EXPR_VALUE) == EXPR_L(second, EXPR_VALUE);
    case 0x03: {
        u16 mark = scratch_mark();
        farptr one = scratch_alloc(10), two = scratch_alloc(10);
        RTL_MEMMOVE(one, MK_FP(EXPR_POOL_SEG, first + EXPR_LEFT), 10);
        RTL_MEMMOVE(two, MK_FP(EXPR_POOL_SEG, second + EXPR_LEFT), 10);
        u8 equal = RTL_LDOUBLE_COMPARE(one, two) == 0;
        scratch_release(mark);
        return equal;
    }
    case 0x48:
        return LEFT(first) == LEFT(second) && RIGHT(first) == RIGHT(second) &&
               EXPR_W(first, EXPR_SCOPE_CLASS) == EXPR_W(second, EXPR_SCOPE_CLASS);
    case 0x01:
        return LEFT(first) == LEFT(second) && RIGHT(first) == RIGHT(second);
    case 0x39:
        return LEFT(first) == LEFT(second) && EXPR_B(first, EXPR_MEMB_BIT_SHIFT) == EXPR_B(second, EXPR_MEMB_BIT_SHIFT) &&
               EXPR_B(first, EXPR_MEMB_BIT_WIDTH) == EXPR_B(second, EXPR_MEMB_BIT_WIDTH) &&
               (EXPR_B(first, EXPR_NODE_FLAGS) & 6) == (EXPR_B(second, EXPR_NODE_FLAGS) & 6);
    case 0x00:
        return 0;
    }
    if ((OP_FLAGS(first) & 1) && !strict)
        return 0;
    return (EXPRESSIONS_EQUAL(LEFT(first), LEFT(second), strict) && EXPRESSIONS_EQUAL(RIGHT(first), RIGHT(second), strict)) ||
           ((OP_FLAGS(first) & 2) && EXPRESSIONS_EQUAL(LEFT(first), RIGHT(second), strict) &&
            EXPRESSIONS_EQUAL(RIGHT(first), LEFT(second), strict));
}

/* a deep copy of a tree (leaves copied whole, their data words included) */
u16 COPY_EXPR_TREE(u16 expression)
{
    if (!expression)
        return 0;
    u16 copy = ALLOC_EXPR_NODE();
    for (int i = 0; i < 26; i++)
        EXPR_B(copy, i) = EXPR_B(expression, i);
    if (!(OP_FLAGS(copy) & 4)) {
        u16 operand = COPY_EXPR_TREE(LEFT(expression));
        LEFT(copy) = operand;
        operand = COPY_EXPR_TREE(RIGHT(expression));
        RIGHT(copy) = operand;
    }
    return copy;
}

/* the symbol under a chain of &, * and 42h nodes (the right side of commas), or 0 */
u16 FIND_BASE_SYMBOL(u16 expression)
{
    while (expression) {
        if (OP(expression) == EOP_ADDR || OP(expression) == 0x42 || OP(expression) == EOP_DEREF)
            expression = LEFT(expression);
        else if (OP(expression) == EOP_COMMA)
            expression = RIGHT(expression);
        else if (OP(expression) == 1)
            return LEFT(expression);
        else
            return 0;
    }
    return 0;
}

/* *expression prepared to be used twice: on return a cheap expression for its value (a
   symbol, or *temp for an lvalue), and *result an assignment that must run first (temp =
   value, or temp = &lvalue), or 0 when no temporary is needed (free of side effects, void,
   or already a named object) */
void SAVE_EXPR_IN_TEMP(farptr expression, farptr result)
{
    u16 node = W(expression), value, symbol;
    if (IS_SIDE_EFFECT_FREE(node) || TYPE_SIZE(TYPE_OF(node)) == 0)
        value = 0;
    else if (IS_LVALUE(node)) {
        u8 wrap = OP(node) == EOP_DEREF && IS_NAMED_OBJECT_EXPR(LEFT(node));
        if (wrap || IS_NAMED_OBJECT_EXPR(node)) {
            symbol = FIND_BASE_SYMBOL(node);
            value = node;
        } else {
            node = MAKE_ADDRESS_OF(node);
            symbol = CREATE_LOCAL_TEMP(TYPE_OF(node));
            wrap = 1;
            value = MAKE_BINARY_NODE(0x0B, MAKE_SYMBOL_NODE(symbol), node);
        }
        node = MAKE_SYMBOL_NODE(symbol);
        if (wrap)
            node = MAKE_UNARY_NODE(0x18, node);
    } else {
        symbol = IS_NAMED_OBJECT_EXPR(node) ? FIND_BASE_SYMBOL(node) : CREATE_LOCAL_TEMP(TYPE_OF(node));
        value = MAKE_BINARY_NODE(0x0B, MAKE_SYMBOL_NODE(symbol), node);
        node = MAKE_SYMBOL_NODE(symbol);
    }
    W(expression) = node;
    W(result) = value;
}

/* at the end of a full expression, the destructor calls for the temporaries made since
   the scope's SCOPE_TEMPS stood at scope appended, their entries freed, and expression,
   list returned so that the whole keeps the expression's value (saved in a temporary
   when it is not void) */
u16 APPEND_TEMP_DESTRUCTORS(u16 expression, u16 scope)
{
    u16 list = BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), scope);
    while (SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) != scope) {
        u16 entry = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) = TDTOR_W(entry, TDTOR_NEXT);
        FREE_TEMP_ENTRY(entry);
    }
    if (!list)
        return expression;
    if (TYPE_SIZE(TYPE_OF(expression)) == 0)
        return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(expression, list), 0, 0);
    u16 mark = scratch_mark();
    farptr slots = scratch_alloc(4);    /* expression, extra */
    W(slots) = expression;
    W(fp_add(slots, 2)) = 0;
    SAVE_EXPR_IN_TEMP(slots, fp_add(slots, 2));
    expression = W(slots);
    u16 extra = W(fp_add(slots, 2));
    scratch_release(mark);
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(JOIN_COMMA_EXPR(extra, list), expression), 0, 0);
}

/* exprmake.c: from bcc20/src/expr/EXPRMAKE.C: expression nodes for the C front end (STMTC.C;
   the C++ front end has EXPRPOOL.C): 20-byte records from EXPR_POOL_SEG, never freed one by
   one, the whole pool emptied by RESET_EXPR_POOL.  Most of these are installed in the
   front end's hook table (NEW_EXPR_NODE_HOOK...), so callers reach them through it.  Also
   CONVERT_EXPRESSION_TYPE, C's conversion of a node to another type (constants folded, a
   node retyped in place where the bits do not change, else a cast node, operator 35h);
   NARROW_INTEGER_EXPR, which finds the narrowest integer kind an expression can be
   computed in; the expansion of x op= y and x++; TREE_HAS_SIDE_EFFECTS.  Leaf operators
   below 8: 1, 4, 5 and 6 symbol leaves, 2 an integer constant, 3 a long double constant.
   EXPR_RETYPE_SHAPE and EXPR_NARROW_SHAPE say per operator how a node may be retyped or
   narrowed (0 not at all, 1 a leaf, 2 a cast, 3 a constant, else bits for "into the left
   or right operand").  KIND_INFO_TABLE has a 4-byte row per kind: byte 0 the size, byte 1
   probably an integer rank.  LANGUAGE_MODE 1 (strict ANSI) turns the in-place shortcuts
   off. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define KIND_INFO(i) SB(fp_add(KIND_INFO_TABLE_P, (i)))
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define RANGE_MIN(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8))
#define RANGE_MAX(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8 + 4))
#define VALUE_AT(node) MK_FP(EXPR_POOL_SEG, (node) + EXPR_LEFT)

/* the hooks */
static u8 type_kind(u16 type) { return (u8)CALL_FAR(GET_TYPE_KIND_HOOK, A16(type)); }
static u16 mode_type(u16 kind) { return (u16)CALL_FAR(MODE_HOOK, A16(kind)); }
static u16 new_node(u16 op, u16 type, u16 left, u16 right)
{
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(op), A16(type), A16(left), A16(right));
}
static i32 token_convert(i32 value, u16 kind)
{
    return (i32)CALL_FAR(TOKEN_CONVERT, A32((u32)value), A16(kind));
}

/* 1 when nothing has been taken from the expression pool since the last reset */
i16 EXPR_POOL_IS_RESET(void)
{
    if (EXPR_POOL_UNIT > 2)
        return 0;
    return 1;
}

/* every expression node freed at once */
void RESET_EXPR_POOL(void)
{
    EXPR_POOL_USED = 0;
    EXPR_POOL_UNIT = 2;
}

/* a node with operator kind, type (its value kind EXPR_KIND from the type), operands left
   and right and qualifier flags mode */
static u16 node_with(i8 kind, u16 type, u16 left, u16 right, i8 mode)
{
    u16 node = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
    EXPR_I(node, EXPR_TYPE) = (i16)type;
    EXPR_I(node, EXPR_OP) = kind;
    EXPR_I(node, EXPR_QUAL_FLAGS) = mode;
    EXPR_B(node, EXPR_NODE_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS2) = 0;
    if (type)
        EXPR_I(node, EXPR_KIND) = type_kind(type);
    else
        EXPR_I(node, EXPR_KIND) = TK_UNDEFINED;
    EXPR_I(node, EXPR_LEFT) = (i16)left;
    EXPR_I(node, EXPR_RIGHT) = (i16)right;
    return node;
}

u16 NEW_EXPR_NODE(i8 kind, u16 type, u16 left, u16 right) { return node_with(kind, type, left, right, 0); }
u16 NEW_EXPR_NODE_MODE(i8 kind, u16 type, u16 left, u16 right, i8 mode) { return node_with(kind, type, left, right, mode); }

/* a leaf with operator kind and type: value in EXPR_RIGHT, EXPR_LEFT 0 */
u16 NEW_EXPR_LEAF(i8 kind, u16 type, u16 value)
{
    u16 node = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
    EXPR_I(node, EXPR_TYPE) = (i16)type;
    EXPR_I(node, EXPR_OP) = kind;
    EXPR_I(node, EXPR_QUAL_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS2) = 0;
    if (type)
        EXPR_I(node, EXPR_KIND) = type_kind(type);
    else
        EXPR_I(node, EXPR_KIND) = TK_UNDEFINED;
    EXPR_I(node, EXPR_RIGHT) = (i16)value;
    EXPR_I(node, EXPR_LEFT) = 0;
    return node;
}

/* an integer constant of type with the long value */
u16 NEW_CONSTANT_EXPR(u16 type, i32 value)
{
    u16 node = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
    EXPR_I(node, EXPR_TYPE) = (i16)type;
    EXPR_I(node, EXPR_OP) = EOP_CONST;
    EXPR_I(node, EXPR_QUAL_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS2) = 0;
    if (type)
        EXPR_I(node, EXPR_KIND) = type_kind(type);
    else
        EXPR_I(node, EXPR_KIND) = TK_UNDEFINED;
    SD(VALUE_AT(node)) = value;
    return node;
}

/* a floating constant (operator 3) from the 10 bytes at value */
u16 NEW_REAL_CONSTANT_NODE(farptr value, u16 type)
{
    u16 node = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
    EXPR_I(node, EXPR_TYPE) = (i16)type;
    EXPR_I(node, EXPR_OP) = 3;
    EXPR_I(node, EXPR_KIND) = type_kind(type);
    EXPR_I(node, EXPR_QUAL_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS2) = 0;
    RTL_MEMMOVE(VALUE_AT(node), value, 10);
    return node;
}

/* a bitfield access (operator 33h) of value: left the width, right the shift */
u16 NEW_BITFIELD_NODE(u16 value, u16 type, u8 left, u8 right)
{
    u16 node = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
    EXPR_W(node, EXPR_TYPE) = type;
    EXPR_W(node, EXPR_OP) = 0x33;
    EXPR_W(node, EXPR_KIND) = type_kind(type);
    EXPR_W(node, EXPR_QUAL_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS) = 0;
    EXPR_B(node, EXPR_NODE_FLAGS2) = 0;
    EXPR_W(node, EXPR_LEFT) = value;
    EXPR_B(node, EXPR_BIT_WIDTH) = left;
    EXPR_B(node, EXPR_BIT_SHIFT) = right;
    return node;
}

/* node given kind and type in place */
static u16 retype(u16 node, u16 kind, u16 type)
{
    EXPR_W(node, EXPR_KIND) = kind;
    EXPR_W(node, EXPR_TYPE) = type;
    return node;
}

/* an integer constant's value as a long double (kind 9 float, 10 double, 11 long double),
   rounded to the kind; in strict ANSI an out-of-range value is an error */
static u16 integer_to_real(u16 current, u16 oldkind, u16 kind, u16 type)
{
    u16 mark = scratch_mark();
    farptr temp = scratch_alloc(10);
    if (EXPR_FLAGS_AT(oldkind) & 0x20)
        RTL_ULONG_TO_LDOUBLE((u32)EXPR_L(current, EXPR_VALUE), temp);
    else
        RTL_LONG_TO_LDOUBLE(EXPR_L(current, EXPR_VALUE), temp);
    if (kind == 9)
        RTL_LDOUBLE_ROUND_TO_FLOAT(temp);
    else if (kind == 10)
        RTL_LDOUBLE_ROUND_TO_DOUBLE(temp);
    if (LANGUAGE_MODE == 1 && LEX_COMPARE(temp))
        REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
    u16 node = NEW_REAL_CONSTANT_NODE(temp, type);
    scratch_release(mark);
    return node;
}

/* a floating constant rounded to float or double, or made an integer constant */
static u16 real_constant_to(u16 current, u16 kind, u16 type)
{
    u16 mark = scratch_mark();
    farptr temp = scratch_alloc(10);
    RTL_MEMMOVE(temp, VALUE_AT(current), 10);
    if (kind == 9) {
        RTL_LDOUBLE_ROUND_TO_FLOAT(temp);
        RTL_MEMMOVE(VALUE_AT(current), temp, 10);
    } else if (kind == 10) {
        RTL_LDOUBLE_ROUND_TO_DOUBLE(temp);
        RTL_MEMMOVE(VALUE_AT(current), temp, 10);
    } else if (kind != 11) {
        if (EXPR_FLAGS_AT(kind) & 0x20) {
            u32 value = RTL_LDOUBLE_TO_ULONG(temp);
            EXPR_L(current, EXPR_VALUE) = (i32)value;
        } else {
            i32 value = RTL_LDOUBLE_TO_LONG(temp);
            EXPR_L(current, EXPR_VALUE) = value;
        }
        EXPR_W(current, EXPR_OP) = EOP_CONST;
    }
    scratch_release(mark);
    return retype(current, kind, type);
}

/* node converted to type: the new tree, or 0 when the conversion is impossible (to an
   array, function, struct or union; between a pointer and a floating type; from void,
   struct or union), which the caller reports.  An error node (operator 0) comes back
   unchanged; enums convert as their int or char type.  Constants are converted now, with
   the run-time library's long double helpers for floating values */
u16 CONVERT_EXPRESSION_TYPE(u16 node, u16 type)
{
    u16 current = node;
    if (EXPR_W(current, EXPR_OP) == 0)
        return current;
    current = FOLD_EXPRESSION(current);
    if (TYPE_B(type, TYPE_KIND) == TK_ENUM)
        type = TYPE_W(type, TYPE_C_SIZE) == 1 ? mode_type(1) : PLAIN_INT_TYPE;
    if (EXPR_W(current, EXPR_TYPE) == type)
        return current;
    u16 oldkind = EXPR_W(current, EXPR_KIND);
    u16 kind = type_kind(type);
    /* first, targets that need no work or are impossible */
    switch (kind) {
    case 12:
        return new_node(0x35, type, current, 0);
    case 17: case 18: case 19: case 20:
        return 0;
    case 13: case 14: case 15: case 16:
        if (EXPR_W(current, EXPR_OP) == EOP_ADDR && oldkind == kind &&
            TYPE_RECORDS_COMPATIBLE(EXPR_W(current, EXPR_TYPE), type, 1)) {
            EXPR_W(current, EXPR_TYPE) = type;
            return current;
        }
        break;
    }
    /* then sources: pointers (a based pointer becomes far first), floats, void */
    switch (oldkind) {
    case 13: case 14: case 15: case 16:
        if (EXPR_FLAGS_AT(kind) & 2)
            return 0;
        if ((i16)CALL_FAR(IS_BASED_POINTER_HOOK, A16(EXPR_W(current, EXPR_TYPE))) && kind == 15)
            current = APPLY_BASED_POINTER_C(current);
        if (EXPR_W(current, EXPR_OP) == EOP_CONST && kind == 15 && oldkind != 15)
            return new_node(0x35, type, current, 0);
        if (LANGUAGE_MODE != 1 && kind == oldkind) {
            u16 from = (u16)CALL_FAR(GET_TYPE_FLAGS_ALT_HOOK, A16(EXPR_W(current, EXPR_TYPE)));
            if (from == (u16)CALL_FAR(GET_TYPE_FLAGS_ALT_HOOK, A16(type))) {
                EXPR_W(current, EXPR_TYPE) = type;
                return current;
            }
        }
        break;
    case 9: case 10:
        if (EXPR_FLAGS_AT(kind) & 0x14)
            return 0;
        break;
    case 12: case 19: case 20:
        return 0;
    }
    /* an addressable object (a symbol or *p) narrowed to a smaller integer or pointer is
       read with the smaller type (far to _seg reads the segment word) */
    if (LANGUAGE_MODE != 1 && IS_ADDRESSABLE_NODE(current) && !(EXPR_FLAGS_AT(oldkind) & 2) &&
        !(EXPR_FLAGS_AT(kind) & 2)) {
        u16 size = (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type));
        u16 oldsize = (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(EXPR_W(current, EXPR_TYPE)));
        if (size > oldsize)
            return new_node(0x35, type, current, 0);
        SEG_PTR_FROM_FAR_ADJUST(current, oldkind, kind);
        return retype(current, kind, type);
    }
    if (EXPR_W(current, EXPR_OP) == EOP_ADDR && (EXPR_FLAGS_AT(kind) & 0x14))
        return retype(current, kind, type);
    if (LANGUAGE_MODE != 1 && KIND_INFO(oldkind * 4) == KIND_INFO(kind * 4))
        return retype(current, kind, type);
    /* an integer constant: the value converted now */
    if (EXPR_W(current, EXPR_OP) == EOP_CONST) {
        switch (kind) {
        case 9: case 10: case 11:
            return integer_to_real(current, oldkind, kind, type);
        case 14:
            if (oldkind == 15 || oldkind == 16 || oldkind == 8 || oldkind == 7)
                EXPR_L(current, EXPR_VALUE) = (i32)(u32)EXPR_W(current, EXPR_RIGHT);
            break;
        }
        EXPR_L(current, EXPR_VALUE) = token_convert(EXPR_L(current, EXPR_VALUE), kind);
        return retype(current, kind, type);
    }
    if (EXPR_W(current, EXPR_OP) == 3)
        return real_constant_to(current, kind, type);
    /* an integer expression narrowed: the narrower type pushed down into the tree where
       the operators allow it */
    if (LANGUAGE_MODE != 1 && (EXPR_FLAGS_AT(kind) & 1) && (EXPR_FLAGS_AT(oldkind) & 1) &&
        KIND_INFO(kind * 4 + 1) < KIND_INFO(oldkind * 4 + 1)) {
        if (EXPR_RETYPE_SHAPE_AT(EXPR_W(current, EXPR_OP)) == 0)
            return new_node(0x35, type, current, 0);
        return RETYPE_EXPR_TREE(current, type_kind(type));
    }
    /* (float)(double)f gives back f */
    if (LANGUAGE_MODE != 1 && kind == 9 && oldkind == 10 && EXPR_W(current, EXPR_OP) == 0x35 &&
        EXPR_W(EXPR_W(current, EXPR_LEFT), EXPR_KIND) == TK_FLOAT)
        return EXPR_W(current, EXPR_LEFT);
    return new_node(0x35, type, current, 0);
}

/* the tree given the integer kind kind (narrower than its own), pushed down into operands
   as the shape table allows; operands that cannot be retyped get a real conversion */
u16 RETYPE_EXPR_TREE(u16 node, u8 kind)
{
    if (!node || !EXPR_W(node, EXPR_OP))
        return 0;
    u16 type = mode_type(kind);
    i8 shape = EXPR_RETYPE_SHAPE_AT(EXPR_W(node, EXPR_OP));
    switch (shape) {
    case 0:
        return CONVERT_EXPRESSION_TYPE(node, type);
    case 1:
        SEG_PTR_FROM_FAR_ADJUST(node, EXPR_W(node, EXPR_KIND), kind);
        break;
    case 3:
        EXPR_L(node, EXPR_VALUE) = token_convert(EXPR_L(node, EXPR_VALUE), kind);
        break;
    case 2: {
        i16 oldkind = (i16)EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_KIND);
        if (oldkind > 8 || KIND_INFO(kind * 4 + 1) > KIND_INFO(oldkind * 4 + 1))
            return retype(node, kind, type);
        return RETYPE_EXPR_TREE(EXPR_W(node, EXPR_LEFT), kind);
    }
    default:
        if ((u8)(shape & 0x10)) {
            u16 left = RETYPE_EXPR_TREE(EXPR_W(node, EXPR_LEFT), kind);
            EXPR_W(node, EXPR_LEFT) = left;
        }
        if ((u8)(shape & 0x20)) {
            u16 right = RETYPE_EXPR_TREE(EXPR_W(node, EXPR_RIGHT), kind);
            EXPR_W(node, EXPR_RIGHT) = right;
        }
    }
    return retype(node, kind, type);
}

/* the smallest integer kind (by kind number) that holds the value of the tree: a constant
   by TYPE_RANGE_TABLE (the minimum and maximum per kind), a widening cast its operand's,
   other operators the larger of their operands' */
u8 NARROWEST_EXPR_KIND(u16 item)
{
    u16 node = item;
    if (!node)
        return 0;
    i16 flags = EXPR_NARROW_SHAPE_AT(EXPR_I(node, EXPR_OP));
    switch (flags) {
    case 0:
        return (u8)EXPR_I(node, EXPR_KIND);
    case 3: {
        i32 value = EXPR_L(node, EXPR_VALUE);
        i16 candidate;
        if (value >= RANGE_MIN(1) && value <= RANGE_MAX(1))
            candidate = 1;
        else if (value >= 0 && value <= RANGE_MAX(2))
            candidate = 2;
        else if (value >= RANGE_MIN(3) && value <= RANGE_MAX(3))
            candidate = 3;
        else if (value >= 0 && value <= RANGE_MAX(4))
            candidate = 4;
        else if (value >= RANGE_MIN(5) && value <= RANGE_MAX(5))
            candidate = 5;
        else if (value >= 0 && value <= RANGE_MAX(6))
            candidate = 6;
        else
            return (u8)EXPR_I(node, EXPR_KIND);
        if (EXPR_I(node, EXPR_KIND) > candidate)
            return (u8)candidate;
        return (u8)EXPR_I(node, EXPR_KIND);
    }
    case 2: {
        i16 current = EXPR_I(node, EXPR_KIND);
        i16 candidate = EXPR_I(EXPR_I(node, EXPR_LEFT), EXPR_KIND);
        if (candidate > 8 || KIND_INFO(current * 4 + 1) <= KIND_INFO(candidate * 4 + 1))
            return (u8)EXPR_I(node, EXPR_KIND);
        return NARROWEST_EXPR_KIND(EXPR_I(node, EXPR_LEFT));
    }
    default: {
        u8 left = (flags & 0x40) ? NARROWEST_EXPR_KIND(EXPR_I(node, EXPR_LEFT)) : 0;
        u8 right = (flags & 0x80) ? NARROWEST_EXPR_KIND(EXPR_I(node, EXPR_RIGHT)) : 0;
        if (!left)
            return right;
        if (!right || left > right)
            return left;
        return right;
    }
    }
}

/* an int or long expression that could be computed in a narrower kind is retyped to it */
u16 NARROW_INTEGER_EXPR(u16 node)
{
    if (!node)
        return node;
    if (EXPR_I(node, EXPR_KIND) <= TK_UCHAR || EXPR_I(node, EXPR_KIND) > TK_ULONG ||
        EXPR_NARROW_SHAPE_AT(EXPR_I(node, EXPR_OP)) == 0)
        return node;
    u8 kind = NARROWEST_EXPR_KIND(node);
    if (EXPR_I(node, EXPR_KIND) == kind)
        return node;
    return RETYPE_EXPR_TREE(node, kind);
}

/* 1 for the operators that name memory: 1, 4, 5, 6 (symbol leaves) and 31h (*p) */
i16 IS_ADDRESSABLE_NODE(u16 node)
{
    u16 op = EXPR_W(node, EXPR_OP);
    return op == 4 || op == 6 || op == 5 || op == 1 || op == 0x31;
}

/* 1 when the tree contains a call (operator 36h); leaves are the operators up to 7 */
i16 EXPR_CONTAINS_CALL(u16 node)
{
    if (!node || EXPR_I(node, EXPR_OP) <= 7)
        return 0;
    if (EXPR_I(node, EXPR_OP) == 0x33)
        return EXPR_CONTAINS_CALL(EXPR_I(node, EXPR_LEFT));
    if (EXPR_I(node, EXPR_OP) == 0x36)
        return 1;
    return EXPR_CONTAINS_CALL(EXPR_I(node, EXPR_LEFT)) || EXPR_CONTAINS_CALL(EXPR_I(node, EXPR_RIGHT));
}

/* a shallow copy of one node */
u16 DUPLICATE_EXPR_NODE(u16 node)
{
    u16 copy = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
    for (int i = 0; i < 20; i++)
        EXPR_B(copy, i) = EXPR_B(node, i);
    return copy;
}

/* a copy of the tree with each x++ and x-- replaced by x */
u16 COPY_TREE_SKIP_POSTINC(u16 node)
{
    if (!node)
        return 0;
    node = DUPLICATE_EXPR_NODE(node);
    if (EXPR_I(node, EXPR_OP) <= 7)
        return node;
    if (EXPR_I(node, EXPR_OP) == 0x33) {
        u16 left = COPY_TREE_SKIP_POSTINC(EXPR_I(node, EXPR_LEFT));
        EXPR_I(node, EXPR_LEFT) = (i16)left;
        return node;
    }
    if (EXPR_I(node, EXPR_OP) == EOP_POSTINC || EXPR_I(node, EXPR_OP) == EOP_POSTDEC)
        return COPY_TREE_SKIP_POSTINC(EXPR_I(node, EXPR_LEFT));
    u16 right = COPY_TREE_SKIP_POSTINC(EXPR_I(node, EXPR_RIGHT));
    EXPR_I(node, EXPR_RIGHT) = (i16)right;
    u16 left = COPY_TREE_SKIP_POSTINC(EXPR_I(node, EXPR_LEFT));
    EXPR_I(node, EXPR_LEFT) = (i16)left;
    return node;
}

/* a copy of the tree with each assignment replaced by its left side */
u16 COPY_TREE_SKIP_ASSIGNS(u16 node)
{
    if (!node)
        return 0;
    node = DUPLICATE_EXPR_NODE(node);
    if (EXPR_I(node, EXPR_OP) <= 7)
        return node;
    if (EXPR_I(node, EXPR_OP) == 0x33) {
        u16 left = COPY_TREE_SKIP_ASSIGNS(EXPR_I(node, EXPR_LEFT));
        EXPR_I(node, EXPR_LEFT) = (i16)left;
        return node;
    }
    if (EXPR_I(node, EXPR_OP) >= EOP_ASSIGN && EXPR_I(node, EXPR_OP) <= EOP_XOR_ASSIGN)
        return COPY_TREE_SKIP_ASSIGNS(EXPR_I(node, EXPR_LEFT));
    u16 right = COPY_TREE_SKIP_ASSIGNS(EXPR_I(node, EXPR_RIGHT));
    EXPR_I(node, EXPR_RIGHT) = (i16)right;
    u16 left = COPY_TREE_SKIP_ASSIGNS(EXPR_I(node, EXPR_LEFT));
    EXPR_I(node, EXPR_LEFT) = (i16)left;
    return node;
}

/* node is *p (operator 31h), perhaps inside a bitfield node (33h): a temporary t made for
   p, node changed in place to read *t, and a new tree *(t = p) (with the same bitfield
   wrapper) returned, so that using the new tree once and node afterwards evaluates p once */
u16 HOIST_LVALUE_ADDR_TO_TEMP(u16 node)
{
    u16 root = EXPR_W(node, EXPR_OP) == 51 ? EXPR_W(node, EXPR_LEFT) : node;
    u16 child = EXPR_W(root, EXPR_LEFT);
    u16 classification = (u16)CALL_FAR(NEW_TEMPORARY_HOOK, A16(EXPR_W(child, EXPR_TYPE)));
    u16 first = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(EXPR_W(child, EXPR_TYPE)), A16(classification), A16(0), A16(0));
    u16 second = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(EXPR_W(child, EXPR_TYPE)), A16(classification), A16(0), A16(0));
    EXPR_W(root, EXPR_LEFT) = second;
    u16 binary = new_node(18, EXPR_W(child, EXPR_TYPE), first, child);
    u16 result = new_node(49, EXPR_W(root, EXPR_TYPE), binary, 0);
    if (EXPR_W(node, EXPR_OP) == 51)
        result = (u16)CALL_FAR(NEW_BITFIELD_NODE_HOOK, A16(result), A16(EXPR_W(node, EXPR_TYPE)),
                               A16(EXPR_B(node, EXPR_BIT_WIDTH)), A16(EXPR_B(node, EXPR_BIT_SHIFT)));
    return result;
}

/* x op= y (node) into x = x op y: the operator changed in place (op= less 11 is op).  If x
   contains a call its address is computed once into a temporary; else x is copied, the
   copy read losing its post-increments and the copy assigned losing its assignments, so
   that each side effect happens once */
u16 EXPAND_COMPOUND_ASSIGN(u16 node)
{
    u16 child = EXPR_W(node, EXPR_LEFT);
    EXPR_W(node, EXPR_OP) += (u16)-11;
    if (EXPR_CONTAINS_CALL(child)) {
        u16 hoisted = HOIST_LVALUE_ADDR_TO_TEMP(child);
        EXPR_W(node, EXPR_LEFT) = hoisted;
    } else {
        u16 copy = COPY_TREE_SKIP_POSTINC(child);
        EXPR_W(node, EXPR_LEFT) = copy;
        child = COPY_TREE_SKIP_ASSIGNS(child);
    }
    u16 type = EXPR_W(node, EXPR_TYPE), target = COPY_TREE_SKIP_ASSIGNS(child);
    return new_node(0x12, type, target, node);
}

/* x++ and x-- (node) into x += 1 and x -= 1 (the operator less 16), in operator 29h with a
   copy of x, probably a sequence that yields its left operand, so that the old value is
   the result */
u16 EXPAND_POST_INC_DEC(u16 node)
{
    u16 converted, operand = EXPR_W(node, EXPR_LEFT);
    EXPR_W(node, EXPR_OP) += (u16)-16;
    if (EXPR_CONTAINS_CALL(operand))
        converted = HOIST_LVALUE_ADDR_TO_TEMP(operand);
    else {
        converted = COPY_TREE_SKIP_POSTINC(operand);
        u16 copy = COPY_TREE_SKIP_ASSIGNS(operand);
        EXPR_W(node, EXPR_LEFT) = copy;
    }
    return new_node(0x29, EXPR_W(node, EXPR_TYPE), converted, node);
}

/* 1 when the tree has an assignment, x++ or x--, or a call (operator 54); leaves have
   none.  The left spine in a loop, right operands through TREE_HAS_SIDE_EFFECTS_HOOK */
i16 TREE_HAS_SIDE_EFFECTS(u16 node)
{
    while (node) {
        switch (EXPR_W(node, EXPR_OP)) {
        case 1: case EOP_CONST: case 3: case 4: case 5: case 6: case 7:
            return 0;
        case EOP_ASSIGN: case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN:
        case EOP_DIV_ASSIGN: case EOP_MOD_ASSIGN: case EOP_SHL_ASSIGN: case EOP_SHR_ASSIGN:
        case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN:
        case EOP_POSTINC: case EOP_POSTDEC: case 54:
            return 1;
        case 51:
            node = EXPR_W(node, EXPR_LEFT);
            break;
        default:
            if (EXPR_W(node, EXPR_RIGHT) && (i16)CALL_FAR(TREE_HAS_SIDE_EFFECTS_HOOK, A16(EXPR_W(node, EXPR_RIGHT))))
                return 1;
            node = EXPR_W(node, EXPR_LEFT);
            break;
        }
    }
    return 0;
}

/* a far or huge pointer object read as a _seg pointer (kind 14): the segment is the high
   word, so a symbol leaf's offset (EXPR_RIGHT) goes up by 2 and *p becomes *(p + 2) */
void SEG_PTR_FROM_FAR_ADJUST(u16 node, u16 oldkind, u16 kind)
{
    if (kind == 14 && (oldkind == 15 || oldkind == 16)) {
        switch (EXPR_I(node, EXPR_OP)) {
        case 1: case 5: case 6:
            EXPR_I(node, EXPR_RIGHT) += 2;
            break;
        case EOP_DEREF: {
            u16 int_type = mode_type(5);
            u16 temporary = (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(int_type), A32(2));
            temporary = new_node(8, EXPR_I(EXPR_I(node, EXPR_LEFT), EXPR_TYPE), EXPR_I(node, EXPR_LEFT), temporary);
            u16 folded = FOLD_EXPRESSION(temporary);
            EXPR_I(node, EXPR_LEFT) = (i16)folded;
            break;
        }
        }
    }
}

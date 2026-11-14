/* simplify.c: from bcc20/src/expr/SIMPLIFY.C: the tree simplifier of the C++ front end,
   SIMPLIFY_EXPRESSION, run on analysed expressions before they are kept or handed on.  One
   walk (SIMPLIFY_NODE dispatches by operator) does three jobs: constant folding and
   algebraic identities (constant arithmetic by the FOLD_* functions, reached through the
   *_FN code pointers, with the long double helpers for floating constants); removal of
   unused values (mode 0: the value is discarded, and subtrees without side effects go,
   SIMPLIFY_NODE returning 0); and use tracking for warnings (each symbol leaf ORs flags
   into its SYM_FLAGS: 4 read, 2 assigned; a read before any assignment outside loops gives
   "possible use before definition").  mode: 0 discarded, 1 used, 2 used as an object (an
   lvalue under &, an assignment's target, a callee).  An operator with an error operand
   becomes the error node.  CONSTANT_TRUTH_VALUE: 0 false, 1 true, 2 unknown.  The long
   arithmetic is Borland's (longops.h).  SIMPLIFY_NODE's "out of memory" stack check is
   STACK_CHECK (native/stack.c). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"
#include "longops.h"
#include "variadic.h"
#include "stack.h"

#define OP(n) EXPR_W((n), EXPR_OP)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define TYPE_OF(n) EXPR_W((n), EXPR_TYPE)
#define VALUE(n) EXPR_L((n), EXPR_VALUE)
#define FLAGS(t) EXPR_FLAGS_AT(TYPE_W((t), TYPE_KIND))
#define FLAGS_OF(n) FLAGS(TYPE_OF(n))
#define IS_CONST(n) (OP(n) == EOP_CONST || OP(n) == 3)
#define BCC_TYPE(i) W(fp_add(D(BCC_TYPE_PTR_P), (i) * 2))
#define REAL_ZERO_P DSPTR(0x09AD)       /* the 10-byte reals 0.0, 1.0, -1.0 (symbols.tsv) */
#define REAL_ONE_P DSPTR(0x09B7)
#define REAL_MINUS_ONE_P DSPTR(0x09C1)
#define RANGE_MIN(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8))
#define RANGE_MAX(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8 + 4))

static i32 token_convert(i32 value, u16 kind)
{
    return (i32)CALL_FAR(TOKEN_CONVERT, A32((u32)value), A16(kind));
}

/* the constant arithmetic, one function per operator and signedness, so that
   APPLY_CONSTANT_OP can be given the pair it needs.  Division and remainder by zero are
   reported by the callers before folding; the shifts shift right for a negative count */
i32 FOLD_ADD_SIGNED(i32 left, i32 right) { return (i32)((u32)left + (u32)right); }
u32 FOLD_ADD_UNSIGNED(u32 left, u32 right) { return left + right; }
i32 FOLD_SUB_SIGNED(i32 left, i32 right) { return (i32)((u32)left - (u32)right); }
u32 FOLD_SUB_UNSIGNED(u32 left, u32 right) { return left - right; }
i32 FOLD_MUL_SIGNED(i32 left, i32 right) { return (i32)((u32)left * (u32)right); }
u32 FOLD_MUL_UNSIGNED(u32 left, u32 right) { return left * right; }
i32 FOLD_DIV_SIGNED(i32 left, i32 right) { return right == 0 ? left : long_div(left, right); }
u32 FOLD_DIV_UNSIGNED(u32 left, u32 right) { return right == 0 ? left : left / right; }
i32 FOLD_MOD_SIGNED(i32 left, i32 right) { return long_mod(left, right); }
u32 FOLD_MOD_UNSIGNED(u32 left, u32 right) { return right == 0 ? 0 : left % right; }
i32 FOLD_AND_LONG(i32 left, i32 right) { return left & right; }
i32 FOLD_OR_LONG(i32 left, i32 right) { return left | right; }
i32 FOLD_XOR_LONG(i32 left, i32 right) { return left ^ right; }

i32 FOLD_SHIFT_SIGNED(i32 value, i32 count)
{
    if (count < 0)
        return long_shr(value, (u8)(0u - (u32)count), 0);
    return long_shl(value, (u8)count);
}

u32 FOLD_SHIFT_UNSIGNED(u32 value, i32 count)
{
    if (count < 0)
        return (u32)long_shr((i32)value, (u8)(0u - (u32)count), 1);
    return (u32)long_shl((i32)value, (u8)count);
}

/* -1, 0 or 1 like strcmp, for folding comparisons of constants */
i16 COMPARE_SIGNED_LONG(i32 left, i32 right) { return left == right ? 0 : left < right ? -1 : 1; }
i16 COMPARE_UNSIGNED_LONG(u32 left, u32 right) { return left == right ? 0 : left < right ? -1 : 1; }

/* the floating operation of operators that have none: the left value stays */
void NO_REAL_FOLD(i32 left, i32 right)
{
    (void)left;
    (void)right;
}

/* *single 1 when value (> 0) is a power of two, *shift its exponent */
void POWER_OF_TWO_SHIFT(i32 value, farptr single, farptr shift)
{
    i16 count;
    for (count = 0; value > 0 && !(value & 1); count++)
        value >>= 1;
    B(single) = value == 1;
    W(shift) = (u16)count;
}

/* the truth value when known now: 0 a zero constant, 1 a nonzero one or the address of a
   symbol, 2 unknown */
u16 CONSTANT_TRUTH_VALUE(u16 expr)
{
    if (expr) {
        if (OP(expr) == EOP_CONST)
            return VALUE(expr) != 0;
        if (OP(expr) == 3) {
            u16 mark = scratch_mark();
            farptr value = scratch_alloc(10);
            RTL_MEMMOVE(value, MK_FP(EXPR_POOL_SEG, expr + EXPR_LEFT), 10);
            i16 compare = RTL_LDOUBLE_COMPARE(value, REAL_ZERO_P);
            scratch_release(mark);
            return compare != 0;
        }
        if (OP(expr) == EOP_ADDR && OP(LEFT(expr)) == 1)
            return 1;
    }
    return 2;
}

/* expr freed, an int constant value instead */
u16 REPLACE_WITH_INT_CONSTANT(i32 value, u16 expr)
{
    u16 result = MAKE_INT_CONSTANT(INT_TYPE, value);
    FREE_EXPR_TREE(expr);
    return result;
}

/* expr freed, a constant value of its type instead */
u16 REPLACE_WITH_TYPED_CONSTANT(i32 value, u16 expr)
{
    u16 result = MAKE_INT_CONSTANT(TYPE_OF(expr), value);
    FREE_EXPR_TREE(expr);
    return result;
}

/* expr and its right operand freed, its left operand instead */
u16 REPLACE_WITH_LEFT(u16 expr)
{
    u16 result = LEFT(expr);
    FREE_EXPR_TREE(RIGHT(expr));
    FREE_EXPR_NODE(expr);
    return result;
}

/* an integer or floating constant negated in place (a long double by its sign bit) */
void NEGATE_CONSTANT(u16 expr)
{
    if (OP(expr) == EOP_CONST)
        VALUE(expr) = token_convert((i32)(0u - (u32)VALUE(expr)), TYPE_W(TYPE_OF(expr), TYPE_KIND));
    else if (OP(expr) == 3) {
        u16 mark = scratch_mark();
        farptr value = scratch_alloc(10);
        RTL_MEMMOVE(value, MK_FP(EXPR_POOL_SEG, expr + EXPR_LEFT), 10);
        W(fp_add(value, 8)) ^= 0x8000;
        RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG, expr + EXPR_LEFT), value, 10);
        scratch_release(mark);
    }
}

/* a new node with operator op (2Eh negation, 2Fh complement) over expr, with expr's type
   and source position */
u16 WRAP_IN_UNARY_NODE(u16 op, u16 expr)
{
    u16 node = ALLOC_EXPR_NODE();
    for (int i = 0; i < 26; i++)
        EXPR_B(node, i) = EXPR_B(expr, i);
    EXPR_W(node, EXPR_OP) = op;
    LEFT(node) = expr;
    RIGHT(node) = 0;
    return node;
}

/* the callee (as an object) and every argument simplified; an error operand makes the
   call an error node */
u16 SIMPLIFY_CALL(u16 expr)
{
    u16 operand = SIMPLIFY_NODE(LEFT(expr), 4, 2);
    LEFT(expr) = operand;
    u8 zero = OP(LEFT(expr)) == 0;
    for (u16 item = RIGHT(expr); item; item = LEFT(item)) {
        operand = SIMPLIFY_NODE(RIGHT(item), 4, 1);
        RIGHT(item) = operand;
        if (!zero && RIGHT(item))
            zero = OP(RIGHT(item)) == 0;
    }
    if (zero)
        expr = REPORT_EXPR_ERROR_PLAIN(0, expr);
    return expr;
}

/* the operand simplified, then the cast removed where it changes nothing (the same
   type) or can be done now: an integer or floating constant to an integer or floating
   type, an integer constant to a pointer or integer of the same size; a cast between
   pointers of the same kind goes too (not &function to another function pointer type).
   What is left has the cast's type.  A discarded operand (0) removes the cast */
u16 SIMPLIFY_CAST(u16 expr, u16 flags, u16 mode)
{
    u16 old = 0;
    u16 operand = SIMPLIFY_NODE(LEFT(expr), flags, mode);
    LEFT(expr) = operand;
    if (!LEFT(expr)) {
        FREE_EXPR_NODE(expr);
        expr = 0;
    } else if (TYPE_OF(expr) == TYPE_OF(LEFT(expr)) || OP(LEFT(expr)) == 0) {
        old = expr;
        expr = LEFT(expr);
    } else {
        u16 type = TYPE_W(TYPE_OF(expr), TYPE_KIND);
        u16 kind = OP(LEFT(expr));
        if (IS_CONST(LEFT(expr))) {
            if ((EXPR_FLAGS_AT(type) & 1) && kind == 2) {
                old = expr;
                expr = LEFT(expr);
                VALUE(expr) = token_convert(VALUE(expr), type);
            } else if ((EXPR_FLAGS_AT(type) & 2) && kind == 3) {
                old = expr;
                expr = LEFT(expr);
            } else if ((EXPR_FLAGS_AT(type) & 1) && kind == 3) {
                old = expr;
                expr = LEFT(old);
                EXPR_W(expr, EXPR_OP) = EOP_CONST;
                u16 mark = scratch_mark();
                farptr value = scratch_alloc(10);
                RTL_MEMMOVE(value, MK_FP(EXPR_POOL_SEG, expr + EXPR_LEFT), 10);
                i32 converted = (FLAGS_OF(expr) & 0x20) ? (i32)RTL_LDOUBLE_TO_ULONG(value) : RTL_LDOUBLE_TO_LONG(value);
                scratch_release(mark);
                VALUE(expr) = converted;
                VALUE(expr) = token_convert(VALUE(expr), type);
            } else if ((EXPR_FLAGS_AT(type) & 2) && kind == 2) {
                old = expr;
                expr = LEFT(old);
                EXPR_W(expr, EXPR_OP) = 3;
                u16 mark = scratch_mark();
                farptr value = scratch_alloc(10);
                if (FLAGS_OF(expr) & 0x20)
                    RTL_ULONG_TO_LDOUBLE((u32)VALUE(expr), value);
                else
                    RTL_LONG_TO_LDOUBLE(VALUE(expr), value);
                RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG, expr + EXPR_LEFT), value, 10);
                scratch_release(mark);
            } else if ((EXPR_FLAGS_AT(type) & 0x15) && kind == 2 && TYPE_SIZE(TYPE_OF(expr)) == TYPE_SIZE(TYPE_OF(LEFT(expr)))) {
                old = expr;
                expr = LEFT(old);
            }
        } else if (!((FLAGS_OF(expr) & 0x14) && TYPE_W(TYPE_W(TYPE_OF(expr), TYPE_TARGET), TYPE_KIND) == TK_FUNCTION && kind == 0x32) &&
                   (EXPR_FLAGS_AT(type) & 0x14) && TYPE_W(TYPE_OF(LEFT(expr)), TYPE_KIND) == type) {
            old = expr;
            expr = LEFT(old);
        }
    }
    if (old) {
        EXPR_W(expr, EXPR_TYPE) = TYPE_OF(old);
        FREE_EXPR_NODE(old);
    }
    return expr;
}

/* !constant becomes 0 or 1; !(a op b) for a comparison the opposite comparison
   (COMPARE_NEGATION_TABLE), and !(x != 0) for x smaller than long !x */
u16 SIMPLIFY_NOT(u16 expr)
{
    u16 child = LEFT(expr);
    switch (CONSTANT_TRUTH_VALUE(child)) {
    case 0: return REPLACE_WITH_INT_CONSTANT(1, expr);
    case 1: return REPLACE_WITH_INT_CONSTANT(0, expr);
    }
    i16 kind = (i16)OP(child);
    if (kind >= 0x1D && kind <= 0x22) {
        if (kind == 0x1E && (i16)TYPE_W(TYPE_OF(LEFT(child)), TYPE_KIND) < TK_LONG &&
            OP(RIGHT(child)) == EOP_CONST && VALUE(RIGHT(child)) == 0) {
            LEFT(expr) = LEFT(child);
            FREE_EXPR_NODE(RIGHT(child));
            FREE_EXPR_NODE(child);
        } else {
            FREE_EXPR_NODE(expr);
            EXPR_W(child, EXPR_OP) = COMPARE_NEGATION_TABLE_AT(OP(child));
            expr = child;
        }
    }
    return expr;
}

/* a unary node.  The operand of &, ++ and -- is read and written (flags 6), but not a
   function under &.  Discarded (mode 0), *p and &x reduce to p and x, and x++ and x--
   become ++x and --x (node flag 2 cleared).  Otherwise *&x and &*p cancel, -constant,
   ~constant and --x fold, unary plus goes, and ! goes to SIMPLIFY_NOT */
u16 SIMPLIFY_UNARY(u16 expr, u16 flags, u16 mode)
{
    u16 old = 0, level = 1, child;
    if (OP(expr) == EOP_ADDR && mode == 2)
        level = 2;
    if (OP(expr) == EOP_DEREF && OP(LEFT(expr)) != 0x35)
        child = LEFT(expr);
    else {
        u16 want = 4;
        if (OP(expr) == EOP_ADDR || OP(expr) == EOP_INC || OP(expr) == EOP_DEC) {
            if (!(FLAGS_OF(expr) & 0x14) || TYPE_W(TYPE_W(TYPE_OF(expr), TYPE_TARGET), TYPE_KIND) != TK_FUNCTION)
                want = 6;
        } else if (mode == 0)
            want = 0;
        child = SIMPLIFY_NODE(LEFT(expr), want, level);
    }
    if (OP(child) == 0) {
        old = expr;
        expr = child;
    } else {
        LEFT(expr) = child;
        switch (OP(expr)) {
        case EOP_DEREF:
            if (mode == 0) {
                FREE_EXPR_NODE(expr);
                expr = SIMPLIFY_NODE(child, 0, mode);
            } else if (OP(child) == EOP_ADDR) {
                old = expr;
                expr = LEFT(child);
                FREE_EXPR_NODE(child);
                expr = SIMPLIFY_NODE(expr, flags, mode);
            } else {
                child = SIMPLIFY_NODE(child, 4, mode);
                LEFT(expr) = child;
                if (OP(child) == EOP_ADDR) {
                    old = expr;
                    expr = LEFT(child);
                    FREE_EXPR_NODE(child);
                }
            }
            break;
        case EOP_ADDR:
            if (mode == 0) {
                FREE_EXPR_NODE(expr);
                expr = child;
            } else if (OP(child) == EOP_DEREF) {
                old = expr;
                expr = LEFT(child);
                FREE_EXPR_NODE(child);
            }
            break;
        case EOP_INC:
        case EOP_DEC:
            if (mode == 0)
                EXPR_B(expr, EXPR_NODE_FLAGS) &= 0xFD;
            break;
        case EOP_NEG:
            if (IS_CONST(child)) {
                old = expr;
                expr = child;
                NEGATE_CONSTANT(expr);
            } else if (OP(child) == EOP_NEG) {
                FREE_EXPR_NODE(expr);
                expr = LEFT(child);
                old = child;
            }
            break;
        case EOP_COMPL:
            if (OP(child) == EOP_CONST) {
                old = expr;
                expr = child;
                VALUE(expr) = token_convert(~VALUE(expr), TYPE_W(TYPE_OF(old), TYPE_KIND));
            }
            break;
        case 0x49:
            old = expr;
            expr = child;
            break;
        case EOP_NOT:
            expr = SIMPLIFY_NOT(expr);
            break;
        }
        if (old)
            EXPR_W(expr, EXPR_TYPE) = TYPE_OF(old);
    }
    if (old)
        FREE_EXPR_NODE(old);
    return expr;
}

/* left op right for two constants of the same sort, as a new constant of type: integers
   with unsigned_op or signed_op (by type's signedness), truncated to type; floating values
   with real_op.  Both operands are freed */
u16 APPLY_CONSTANT_OP(u16 left, u16 right, u16 type, farptr unsigned_op, farptr signed_op, farptr real_op)
{
    u16 result;
    if (OP(left) == EOP_CONST) {
        farptr op = (FLAGS(type) & 0x20) ? unsigned_op : signed_op;
        i32 value = (i32)CALL_FAR(op, A32((u32)VALUE(left)), A32((u32)VALUE(right)));
        result = MAKE_INT_CONSTANT(type, token_convert(value, TYPE_W(type, TYPE_KIND)));
    } else {
        u16 mark = scratch_mark();
        farptr left_value = scratch_alloc(10), right_value = scratch_alloc(10);
        RTL_MEMMOVE(left_value, MK_FP(EXPR_POOL_SEG, left + EXPR_LEFT), 10);
        RTL_MEMMOVE(right_value, MK_FP(EXPR_POOL_SEG, right + EXPR_LEFT), 10);
        CALL_FAR(real_op, A32(left_value), A32(right_value));
        result = MAKE_REAL_CONSTANT(type, left_value);
        scratch_release(mark);
    }
    FREE_EXPR_NODE(right);
    FREE_EXPR_NODE(left);
    return result;
}

/* when both operands are constants of the same sort, expr replaced by the folded
   constant */
u16 FOLD_CONSTANT_OPERANDS(u16 expr, farptr unsigned_op, farptr signed_op, farptr real_op)
{
    u16 left = LEFT(expr), right = RIGHT(expr);
    if (OP(left) == OP(right)) {
        u16 old = expr;
        expr = APPLY_CONSTANT_OP(left, right, TYPE_OF(expr), unsigned_op, signed_op, real_op);
        FREE_EXPR_NODE(old);
    }
    return expr;
}

/* object.member with its operands simplified.  For a variable the member offset goes
   into the symbol leaf's offset; else the member is *(&object + offset), a long offset
   through a huge pointer and the far form 2Dh through a _seg pointer.  A ?:, = or 48h
   object is used through its address.  A bitfield keeps its member node, its offset now
   0.  A member node naming a symbol (operator 1) becomes a silent error */
u16 SIMPLIFY_MEMBER(u16 expr, u16 mode)
{
    u16 left = LEFT(expr), right = RIGHT(expr);
    if (OP(right) == 1)
        return REPORT_EXPR_ERROR_PLAIN(0, expr);
    u8 direct = OP(left) == EOP_QUESTION || OP(left) == EOP_ASSIGN || OP(left) == 0x48;
    u8 near_ptr = OP(left) == EOP_DEREF && TYPE_W(TYPE_OF(LEFT(left)), TYPE_KIND) == TK_SEG_PTR;
    u8 far_ptr = OP(left) == EOP_DEREF && TYPE_W(TYPE_OF(LEFT(left)), TYPE_KIND) == TK_HUGE_PTR;
    if (OP(left) == 1)
        RIGHT(left) += LEFT(right);
    else if (LEFT(right) || near_ptr || direct) {
        u16 temp = MAKE_ADDRESS_OF(left);
        if (!direct) {
            temp = MAKE_BINARY_NODE(0x16, temp, MAKE_INT_CONSTANT(far_ptr ? LONG_TYPE : SIZE_T_TYPE, (i32)LEFT(right)));
            EXPR_W(temp, EXPR_TYPE) = TYPE_OF(LEFT(temp));
            if (near_ptr) {
                EXPR_W(temp, EXPR_OP) = 0x2D;
                u16 pointer = MAKE_POINTER_TYPE(TYPE_W(TYPE_OF(temp), TYPE_TARGET), 0x0F, 0);
                EXPR_W(temp, EXPR_TYPE) = pointer;
            }
            EXPR_B(temp, EXPR_NODE_FLAGS) = 1;
            left = SIMPLIFY_NODE(MAKE_DEREFERENCE(temp), mode == 0 ? 0 : 4, mode);
        } else {
            left = MAKE_ADDRESS_OF(temp);
            EXPR_B(left, EXPR_NODE_FLAGS) = 1;
        }
    }
    EXPR_W(left, EXPR_TYPE) = TYPE_OF(expr);
    if (EXPR_B(right, EXPR_NODE_FLAGS) & 4) {
        LEFT(right) = 0;
        LEFT(expr) = left;
    } else {
        FREE_EXPR_NODE(right);
        FREE_EXPR_NODE(expr);
        expr = left;
    }
    return expr;
}

/* POWER_OF_TWO_SHIFT with its outputs in the scratch area */
static u8 power_of_two(i32 value, i16 *shift)
{
    u16 mark = scratch_mark();
    farptr out = scratch_alloc(4);
    POWER_OF_TWO_SHIFT(value, out, fp_add(out, 2));
    u8 single = B(out);
    *shift = (i16)W(fp_add(out, 2));
    scratch_release(mark);
    return single;
}

/* the real constant's comparison with one of the reals 0.0, 1.0, -1.0 */
static i16 compare_real(u16 constant, farptr with)
{
    u16 mark = scratch_mark();
    farptr real = scratch_alloc(10);
    RTL_MEMMOVE(real, MK_FP(EXPR_POOL_SEG, constant + EXPR_LEFT), 10);
    i16 result = RTL_LDOUBLE_COMPARE(real, with);
    scratch_release(mark);
    return result;
}

/* constants moved right and folded; x * 0.0, 1.0, -1.0; x * 0, x * 1, x * -c (as -(x * c)
   when c is a power of two), x * 2^n as x << n.  As an object (mode 2, probably array
   indexing) (x + c) * k becomes x * k + c * k, so that the constant can join the address
   offset */
u16 SIMPLIFY_MULTIPLY(u16 expr, u16 mode)
{
    if (IS_CONST(LEFT(expr)))
        expr = SWAP_OPERANDS(expr);
    if (IS_CONST(LEFT(expr)))
        return FOLD_CONSTANT_OPERANDS(expr, FOLD_MUL_UNSIGNED_FN, FOLD_MUL_SIGNED_FN, REAL_MUL_FN);
    if (!IS_CONST(RIGHT(expr)))
        return expr;
    u16 right = RIGHT(expr);
    if (OP(right) == 3) {
        u16 mark = scratch_mark();
        farptr real = scratch_alloc(10);
        RTL_MEMMOVE(real, MK_FP(EXPR_POOL_SEG, right + EXPR_LEFT), 10);
        if (RTL_LDOUBLE_COMPARE(real, REAL_ZERO_P) == 0) {
            u16 zero = MAKE_REAL_CONSTANT(TYPE_OF(expr), REAL_ZERO_P);
            FREE_EXPR_TREE(expr);
            expr = zero;
        } else if (RTL_LDOUBLE_COMPARE(real, REAL_ONE_P) == 0)
            expr = REPLACE_WITH_LEFT(expr);
        else if (RTL_LDOUBLE_COMPARE(real, REAL_MINUS_ONE_P) == 0)
            expr = WRAP_IN_UNARY_NODE(0x2E, REPLACE_WITH_LEFT(expr));
        scratch_release(mark);
        return expr;
    }
    u16 left = LEFT(expr);
    u8 nested = OP(left) == EOP_ADD && OP(RIGHT(left)) == EOP_CONST;
    i32 value = VALUE(right);
    if (nested && mode == 2) {
        u16 constant = RIGHT(expr);
        u16 old = expr;
        expr = LEFT(expr);
        LEFT(old) = LEFT(expr);
        if (FLAGS_OF(expr) & 0x20)
            VALUE(constant) = (i32)FOLD_MUL_UNSIGNED((u32)value, (u32)VALUE(constant));
        else
            VALUE(constant) = FOLD_MUL_SIGNED(value, VALUE(constant));
        VALUE(constant) = token_convert(VALUE(constant), TYPE_W(TYPE_OF(constant), TYPE_KIND));
        u16 product = SIMPLIFY_MULTIPLY(old, mode);
        LEFT(expr) = product;
        return expr;
    }
    u8 negate;
    if (value < 0 && !(FLAGS_OF(expr) & 0x20)) {
        negate = 1;
        value = (i32)(0u - (u32)value);
    } else
        negate = 0;
    if (value == 0)
        expr = REPLACE_WITH_TYPED_CONSTANT(0, expr);
    else if (value == 1)
        expr = REPLACE_WITH_LEFT(expr);
    else {
        i16 shift;
        if (power_of_two(value, &shift)) {
            EXPR_W(expr, EXPR_OP) = EOP_SHL;
            EXPR_W(right, EXPR_TYPE) = BCC_TYPE(2);
            VALUE(right) = shift;
        } else
            negate = 0;
    }
    if (negate)
        expr = WRAP_IN_UNARY_NODE(0x2E, expr);
    return expr;
}

/* division by a constant: zero an error for integers; constants fold; x / 1 and x / -1
   (also 1.0, -1.0); unsigned x / 2^n becomes x >> n */
u16 SIMPLIFY_DIVIDE(u16 expr)
{
    u16 right = RIGHT(expr);
    if (!IS_CONST(right))
        return expr;
    if (CONSTANT_TRUTH_VALUE(right) == 0 && !(FLAGS_OF(expr) & 2))
        expr = REPORT_EXPR_ERROR_PLAIN(MSG_DIVISION_ZERO, expr);
    else if (IS_CONST(LEFT(expr)))
        expr = FOLD_CONSTANT_OPERANDS(expr, FOLD_DIV_UNSIGNED_FN, FOLD_DIV_SIGNED_FN, REAL_DIV_FN);
    else if (OP(right) == 3) {
        if (compare_real(right, REAL_ONE_P) == 0)
            expr = REPLACE_WITH_LEFT(expr);
        else if (compare_real(right, REAL_MINUS_ONE_P) == 0)
            expr = WRAP_IN_UNARY_NODE(0x2E, REPLACE_WITH_LEFT(expr));
    } else if (VALUE(right) == 1)
        expr = REPLACE_WITH_LEFT(expr);
    else if (VALUE(right) == -1)
        expr = WRAP_IN_UNARY_NODE(0x2E, REPLACE_WITH_LEFT(expr));
    else if (FLAGS_OF(expr) & 0x20) {
        i16 shift;
        if (power_of_two(VALUE(right), &shift)) {
            EXPR_W(expr, EXPR_OP) = EOP_SHR;
            VALUE(right) = shift;
            EXPR_W(right, EXPR_TYPE) = BCC_TYPE(2);
        }
    }
    return expr;
}

/* remainder by a constant: zero an error; constants fold; x % 1 is 0; unsigned x % 2^n
   becomes x & (2^n - 1) */
u16 SIMPLIFY_MODULO(u16 expr)
{
    u16 right = RIGHT(expr);
    if (!IS_CONST(right))
        return expr;
    if (CONSTANT_TRUTH_VALUE(right) == 0)
        expr = REPORT_EXPR_ERROR_PLAIN(MSG_DIVISION_ZERO, expr);
    else if (IS_CONST(LEFT(expr)))
        expr = FOLD_CONSTANT_OPERANDS(expr, FOLD_MOD_UNSIGNED_FN, FOLD_MOD_SIGNED_FN, NO_REAL_FOLD_FN);
    else if (OP(RIGHT(expr)) == EOP_CONST) {
        if (VALUE(right) == 1)
            expr = REPLACE_WITH_TYPED_CONSTANT(0, expr);
        else if (FLAGS_OF(expr) & 0x20) {
            i16 shift;
            if (power_of_two(VALUE(right), &shift)) {
                EXPR_W(expr, EXPR_OP) = EOP_AND;
                VALUE(right) = (i32)((u32)VALUE(right) - 1);
            }
        }
    }
    return expr;
}

/* 1 when left and right are both integer constants or both floating constants */
u8 BOTH_SAME_KIND_CONSTANT(u16 left, u16 right)
{
    return IS_CONST(left) && OP(left) == OP(right);
}

/* an operand of the form x + c or c - x with an integer constant of the result's size */
static u8 offset_form(u16 operand, u16 size)
{
    u16 constant;
    if (OP(operand) == EOP_ADD)
        constant = RIGHT(operand);
    else if (OP(operand) == EOP_SUB)
        constant = LEFT(operand);
    else
        return 0;
    return IS_CONST(constant) && (FLAGS_OF(constant) & 1) && (u16)TYPE_SIZE(TYPE_OF(constant)) == size;
}

/* constants moved right; two constants fold; x + 0 is x; &v + c moves c into v's offset.
   Constants of x + c and c - x operands are gathered: (x + c1) + c2 = x + (c1 + c2),
   (x + c) + y = (x + y) + c, (x + c1) + (y + c2) = (x + y) + (c1 + c2) */
u16 SIMPLIFY_ADD(u16 expr)
{
    if (IS_CONST(LEFT(expr)))
        expr = SWAP_OPERANDS(expr);
    u16 left = LEFT(expr), right = RIGHT(expr);
    u16 type = TYPE_OF(expr);
    u16 size = (u16)TYPE_SIZE(type);
    u8 left_offset = 0, right_offset = 0;
    if (FLAGS(type) & 1) {
        left_offset = offset_form(left, size);
        right_offset = offset_form(right, size);
    }
    if (BOTH_SAME_KIND_CONSTANT(left, right)) {
        FREE_EXPR_NODE(expr);
        return APPLY_CONSTANT_OP(left, right, type, FOLD_ADD_UNSIGNED_FN, FOLD_ADD_SIGNED_FN, REAL_ADD_FN);
    }
    if (IS_CONST(right)) {
        if (CONSTANT_TRUTH_VALUE(right) == 0)
            return REPLACE_WITH_LEFT(expr);
        if (left_offset) {
            if (OP(left) == EOP_ADD) {
                if (BOTH_SAME_KIND_CONSTANT(RIGHT(left), right)) {
                    u16 sum = APPLY_CONSTANT_OP(RIGHT(left), right, type, FOLD_ADD_UNSIGNED_FN, FOLD_ADD_SIGNED_FN, REAL_ADD_FN);
                    RIGHT(left) = sum;
                    FREE_EXPR_NODE(expr);
                    expr = left;
                }
            } else if (BOTH_SAME_KIND_CONSTANT(LEFT(left), right)) {
                u16 sum = APPLY_CONSTANT_OP(LEFT(left), right, type, FOLD_ADD_UNSIGNED_FN, FOLD_ADD_SIGNED_FN, REAL_ADD_FN);
                LEFT(left) = sum;
                FREE_EXPR_NODE(expr);
                expr = left;
            }
        } else if (OP(left) == EOP_ADDR && OP(LEFT(left)) == 1) {
            RIGHT(LEFT(left)) += LEFT(right);
            FREE_EXPR_NODE(expr);
            FREE_EXPR_NODE(right);
            expr = left;
        }
    } else if (left_offset != right_offset) {
        if (right_offset)
            expr = SWAP_OPERANDS(expr);
        u16 temp = RIGHT(expr);
        if (OP(LEFT(expr)) == EOP_ADD) {
            RIGHT(expr) = RIGHT(LEFT(expr));
            RIGHT(LEFT(expr)) = temp;
        } else {
            RIGHT(expr) = LEFT(LEFT(expr));
            LEFT(LEFT(expr)) = temp;
        }
    } else if (left_offset && right_offset) {
        u16 first = OP(left) == EOP_SUB ? LEFT(left) : RIGHT(left);
        u16 second = OP(right) == EOP_SUB ? LEFT(right) : RIGHT(right);
        if (BOTH_SAME_KIND_CONSTANT(first, second)) {
            u16 temp = APPLY_CONSTANT_OP(first, second, PICK_WIDER_TYPE(TYPE_OF(first), TYPE_OF(second)),
                                         FOLD_ADD_UNSIGNED_FN, FOLD_ADD_SIGNED_FN, REAL_ADD_FN);
            if (OP(left) == EOP_SUB && OP(right) == EOP_SUB) {
                LEFT(right) = RIGHT(left);
                EXPR_W(right, EXPR_OP) = EOP_ADD;
                FREE_EXPR_NODE(LEFT(expr));
                LEFT(expr) = temp;
                EXPR_W(expr, EXPR_OP) = EOP_SUB;
            } else {
                if (OP(left) == EOP_ADD) {
                    RIGHT(left) = OP(right) == EOP_ADD ? LEFT(right) : RIGHT(right);
                    EXPR_W(left, EXPR_OP) = OP(right);
                } else
                    LEFT(left) = LEFT(right);
                FREE_EXPR_NODE(right);
                RIGHT(expr) = temp;
            }
        }
    }
    return expr;
}

/* segment:offset (operator 2Dh) of two constants as one 32-bit constant */
u16 FOLD_FAR_POINTER_CONSTANT(u16 expr)
{
    if (OP(LEFT(expr)) == EOP_CONST && OP(RIGHT(expr)) == EOP_CONST)
        return REPLACE_WITH_TYPED_CONSTANT((i32)(((u32)LEFT(LEFT(expr)) << 16) + (u32)VALUE(RIGHT(expr))), expr);
    return expr;
}

/* x - c becomes x + (-c) for SIMPLIFY_ADD; constants of x + c and c - x operands are
   pulled out as there; c - (x + c2) folds to (c - c2) - x; 0 - x becomes -x */
u16 SIMPLIFY_SUBTRACT(u16 expr)
{
    u16 left = LEFT(expr), right = RIGHT(expr), temp;
    u8 left_const = IS_CONST(left), right_const = IS_CONST(right);
    u16 size = (u16)TYPE_SIZE(TYPE_OF(expr));
    u8 left_offset = 0, right_offset = 0;
    if ((FLAGS_OF(expr) & 1) && (FLAGS_OF(left) & 1) && (FLAGS_OF(right) & 1)) {
        left_offset = offset_form(left, size);
        right_offset = offset_form(right, size);
    }
    if ((right_offset && !left_const) || (left_offset && !right_const)) {
        if (right_offset) {
            if (OP(right) == EOP_SUB) {
                temp = LEFT(right);
                LEFT(right) = left;
                EXPR_W(right, EXPR_OP) = EOP_ADD;
            } else {
                temp = RIGHT(right);
                RIGHT(right) = left;
                EXPR_W(right, EXPR_OP) = EOP_SUB;
                u16 swapped = SWAP_OPERANDS(right);
                RIGHT(expr) = swapped;
            }
            u16 simplified = SIMPLIFY_NODE(RIGHT(expr), 0, 1);
            RIGHT(expr) = simplified;
            LEFT(expr) = temp;
            expr = SWAP_OPERANDS(expr);
            right_const = 1;
            right_offset = 0;
            NEGATE_CONSTANT(temp);
            EXPR_W(expr, EXPR_OP) = EOP_ADD;
        } else {
            if (OP(left) == EOP_SUB) {
                temp = LEFT(left);
                LEFT(left) = right;
                EXPR_W(left, EXPR_OP) = EOP_ADD;
                RIGHT(expr) = temp;
                expr = SWAP_OPERANDS(expr);
            } else {
                temp = RIGHT(left);
                RIGHT(left) = right;
                EXPR_W(left, EXPR_OP) = EOP_SUB;
                RIGHT(expr) = temp;
                EXPR_W(expr, EXPR_OP) = EOP_ADD;
                right_const = 1;
            }
            left_offset = 0;
        }
    } else if (right_const) {
        NEGATE_CONSTANT(right);
        EXPR_W(expr, EXPR_OP) = EOP_ADD;
    }
    if (right_const && OP(expr) == EOP_ADD)
        expr = SIMPLIFY_ADD(expr);
    else if (left_const) {
        if (right_offset) {
            u16 right_part;
            if (OP(right) == EOP_ADD) {
                right_part = RIGHT(right);
                RIGHT(expr) = LEFT(right);
            } else {
                right_part = LEFT(right);
                RIGHT(expr) = RIGHT(right);
                EXPR_W(expr, EXPR_OP) = EOP_ADD;
            }
            u16 difference = APPLY_CONSTANT_OP(left, right_part, PICK_WIDER_TYPE(TYPE_OF(left), TYPE_OF(right_part)),
                                               FOLD_SUB_UNSIGNED_FN, FOLD_SUB_SIGNED_FN, REAL_SUB_FN);
            LEFT(expr) = difference;
            FREE_EXPR_NODE(right);
            if (OP(expr) == EOP_ADD)
                expr = SWAP_OPERANDS(expr);
        } else if (CONSTANT_TRUTH_VALUE(left) == 0) {
            FREE_EXPR_NODE(left);
            FREE_EXPR_NODE(expr);
            expr = WRAP_IN_UNARY_NODE(0x2E, right);
        }
    } else if (left_offset && right_offset) {
        u16 left_part = OP(left) == EOP_SUB ? LEFT(left) : RIGHT(left);
        u16 right_part = OP(right) == EOP_SUB ? LEFT(right) : RIGHT(right);
        if (BOTH_SAME_KIND_CONSTANT(left_part, right_part)) {
            temp = APPLY_CONSTANT_OP(left_part, right_part, PICK_WIDER_TYPE(TYPE_OF(left_part), TYPE_OF(right_part)),
                                     FOLD_SUB_UNSIGNED_FN, FOLD_SUB_SIGNED_FN, REAL_SUB_FN);
            if (OP(left) == EOP_SUB) {
                if (OP(right) == EOP_ADD)
                    RIGHT(right) = RIGHT(left);
                else
                    LEFT(right) = RIGHT(left);
                FREE_EXPR_NODE(left);
                LEFT(expr) = temp;
            } else {
                EXPR_W(expr, EXPR_OP) = EOP_ADD;
                if (OP(right) == EOP_ADD) {
                    RIGHT(left) = LEFT(right);
                    EXPR_W(left, EXPR_OP) = EOP_SUB;
                } else
                    RIGHT(left) = RIGHT(right);
                NEGATE_CONSTANT(temp);
            }
            FREE_EXPR_NODE(right);
            RIGHT(expr) = temp;
        }
    }
    return expr;
}

/* & | ^: constants fold; for & x & 0 is 0 and x & -1 x; for | x | 0 is x and x | -1 -1; for
   ^ x ^ 0 is x and x ^ -1 ~x */
u16 SIMPLIFY_AND(u16 expr)
{
    if (IS_CONST(LEFT(expr)))
        expr = SWAP_OPERANDS(expr);
    if (IS_CONST(LEFT(expr)))
        expr = FOLD_CONSTANT_OPERANDS(expr, FOLD_AND_LONG_FN, FOLD_AND_LONG_FN, NO_REAL_FOLD_FN);
    else if (OP(RIGHT(expr)) == EOP_CONST) {
        if (VALUE(RIGHT(expr)) == 0)
            expr = REPLACE_WITH_TYPED_CONSTANT(0, expr);
        else if (VALUE(RIGHT(expr)) == -1)
            expr = REPLACE_WITH_LEFT(expr);
    }
    return expr;
}

u16 SIMPLIFY_OR(u16 expr)
{
    if (IS_CONST(LEFT(expr)))
        expr = SWAP_OPERANDS(expr);
    if (IS_CONST(LEFT(expr)))
        expr = FOLD_CONSTANT_OPERANDS(expr, FOLD_OR_LONG_FN, FOLD_OR_LONG_FN, NO_REAL_FOLD_FN);
    else if (OP(RIGHT(expr)) == EOP_CONST) {
        if (VALUE(RIGHT(expr)) == 0)
            expr = REPLACE_WITH_LEFT(expr);
        else if (VALUE(RIGHT(expr)) == -1)
            expr = REPLACE_WITH_TYPED_CONSTANT(-1, expr);
    }
    return expr;
}

u16 SIMPLIFY_XOR(u16 expr)
{
    if (IS_CONST(LEFT(expr)))
        expr = SWAP_OPERANDS(expr);
    if (IS_CONST(LEFT(expr)))
        expr = FOLD_CONSTANT_OPERANDS(expr, FOLD_XOR_LONG_FN, FOLD_XOR_LONG_FN, NO_REAL_FOLD_FN);
    else if (OP(RIGHT(expr)) == EOP_CONST) {
        if (VALUE(RIGHT(expr)) == 0)
            expr = REPLACE_WITH_LEFT(expr);
        else if (VALUE(RIGHT(expr)) == -1)
            expr = WRAP_IN_UNARY_NODE(0x2F, REPLACE_WITH_LEFT(expr));
    }
    return expr;
}

/* direction 1 for <<, -1 for >>.  Constants fold (a right shift as a left shift by a
   negative count).  A shift by 0 goes; a shift by more bits than the type has becomes 0
   when it is a right shift or the type is unsigned */
u16 SIMPLIFY_SHIFT(u16 expr, i16 direction)
{
    if (IS_CONST(LEFT(expr)) && IS_CONST(RIGHT(expr))) {
        if (OP(RIGHT(expr)) == EOP_CONST)
            VALUE(RIGHT(expr)) = (i32)((u32)(i32)direction * (u32)VALUE(RIGHT(expr)));
        expr = FOLD_CONSTANT_OPERANDS(expr, FOLD_SHIFT_UNSIGNED_FN, FOLD_SHIFT_SIGNED_FN, NO_REAL_FOLD_FN);
    } else if (OP(RIGHT(expr)) == EOP_CONST) {
        i32 count = VALUE(RIGHT(expr));
        u32 distance = count >= 0 ? (u32)count : 0u - (u32)count;
        if (distance == 0)
            expr = REPLACE_WITH_LEFT(expr);
        else if ((u32)TYPE_SIZE(TYPE_OF(expr)) << 3 < distance) {
            if ((i32)((u32)(i32)direction * (u32)count) < 0 || (FLAGS_OF(expr) & 0x20))
                expr = REPLACE_WITH_TYPED_CONSTANT(0, expr);
        }
    }
    return expr;
}

/* "constant out of range in comparison" when a comparison of an integer variable smaller
   than long with a constant is always true or false.  A constant on the left swaps the
   comparison through COMPARE_NEGATE_TABLE (which holds the mirrored operator) */
void CHECK_COMPARE_RANGE(u16 expr)
{
    i32 value;
    i16 kind, op = (i16)OP(expr);
    if (OP(LEFT(expr)) == EOP_CONST) {
        value = VALUE(LEFT(expr));
        kind = (i16)TYPE_W(TYPE_OF(RIGHT(expr)), TYPE_KIND);
        op = COMPARE_NEGATE_TABLE_AT(op);
    } else {
        value = VALUE(RIGHT(expr));
        kind = (i16)TYPE_W(TYPE_OF(LEFT(expr)), TYPE_KIND);
    }
    if (kind >= 7)
        return;
    if (EXPR_FLAGS_AT(kind) & 0x20) {
        u16 low = (u16)value;
        if ((i32)low > RANGE_MAX(kind) || (op == 0x21 && value == 0) || (op == 0x22 && (i32)low >= RANGE_MAX(kind)))
            REPORT_DIAGNOSTIC_AT(MSG_CONSTANT_OUT_RANGE, 0, 0, EXPR_W(expr, EXPR_SRC_LINE), 0);
    } else if (RANGE_MAX(kind) < value || RANGE_MIN(kind) > value || (op == 0x21 && RANGE_MIN(kind) == value) ||
               (op == 0x22 && RANGE_MAX(kind) == value))
        REPORT_DIAGNOSTIC_AT(MSG_CONSTANT_OUT_RANGE, 0, 0, EXPR_W(expr, EXPR_SRC_LINE), 0);
}

/* equal 1 when the comparison holds for equal operands (==, <=, >=); sign the COMPARE_*
   result that makes it true (-1 for <, 1 for >, 0 for == and !=).  The constant range is
   checked, and comparisons of identical side-effect-free operands and of two constants
   fold */
u16 SIMPLIFY_COMPARISON(u16 expr, u8 equal, i16 sign)
{
    u16 left = LEFT(expr), right = RIGHT(expr);
    if (OP(left) == EOP_CONST || OP(right) == EOP_CONST)
        CHECK_COMPARE_RANGE(expr);
    if (EXPRESSIONS_EQUAL(left, right, 0))
        return REPLACE_WITH_INT_CONSTANT((i32)(i16)equal, expr);
    if (IS_CONST(left) && OP(left) == OP(right)) {
        i16 result;
        if (OP(left) == EOP_CONST) {
            if ((FLAGS_OF(left) & 0x20) || (FLAGS_OF(right) & 0x20))
                result = COMPARE_UNSIGNED_LONG((u32)VALUE(left), (u32)VALUE(right));
            else
                result = COMPARE_SIGNED_LONG(VALUE(left), VALUE(right));
        } else {
            u16 mark = scratch_mark();
            farptr left_value = scratch_alloc(10), right_value = scratch_alloc(10);
            RTL_MEMMOVE(left_value, MK_FP(EXPR_POOL_SEG, left + EXPR_LEFT), 10);
            RTL_MEMMOVE(right_value, MK_FP(EXPR_POOL_SEG, right + EXPR_LEFT), 10);
            result = RTL_LDOUBLE_COMPARE(left_value, right_value);
            scratch_release(mark);
        }
        if (sign == 0 && !equal)
            expr = REPLACE_WITH_INT_CONSTANT(result != 0, expr);
        else
            expr = REPLACE_WITH_INT_CONSTANT(result == sign || (result == 0 && equal), expr);
    }
    return expr;
}

/* an error operand of && or ||: it replaces the node */
static u16 take_error(u16 expr, u16 error, u16 other)
{
    FREE_EXPR_TREE(other);
    FREE_EXPR_NODE(expr);
    return error;
}

/* a && b.  A false constant left side makes it 0 (the right side is not even simplified,
   so its symbols do not count as used); two constants fold; x && 0 becomes 0, or (x, 0)
   when x has side effects */
u16 SIMPLIFY_LOGICAL_AND(u16 expr, u16 mode)
{
    u16 flags = mode == 0 ? 0 : 4;
    u16 operand = SIMPLIFY_NODE(LEFT(expr), flags, 1);
    LEFT(expr) = operand;
    if (LEFT(expr) && OP(LEFT(expr)) == 0)
        return take_error(expr, LEFT(expr), RIGHT(expr));
    if (CONSTANT_TRUTH_VALUE(LEFT(expr)) == 0)
        return REPLACE_WITH_INT_CONSTANT(0, expr);
    operand = SIMPLIFY_NODE(RIGHT(expr), flags, mode);
    RIGHT(expr) = operand;
    if (RIGHT(expr) && OP(RIGHT(expr)) == 0)
        return take_error(expr, RIGHT(expr), LEFT(RIGHT(expr)));
    switch (CONSTANT_TRUTH_VALUE(LEFT(expr))) {
    case 1:
        switch (CONSTANT_TRUTH_VALUE(RIGHT(expr))) {
        case 0: expr = REPLACE_WITH_INT_CONSTANT(0, expr); break;
        case 1: expr = REPLACE_WITH_INT_CONSTANT(1, expr); break;
        }
        break;
    case 2:
        if (CONSTANT_TRUTH_VALUE(RIGHT(expr)) == 0) {
            if (IS_SIDE_EFFECT_FREE(LEFT(expr)))
                expr = REPLACE_WITH_INT_CONSTANT(0, expr);
            else {
                EXPR_W(expr, EXPR_OP) = EOP_COMMA;
                u16 zero = REPLACE_WITH_INT_CONSTANT(0, RIGHT(expr));
                RIGHT(expr) = zero;
            }
        }
        break;
    }
    return expr;
}

/* a || b, as a && b with true and false exchanged */
u16 SIMPLIFY_LOGICAL_OR(u16 expr, u16 mode)
{
    u16 flags = mode == 0 ? 0 : 4;
    u16 operand = SIMPLIFY_NODE(LEFT(expr), flags, 1);
    LEFT(expr) = operand;
    if (LEFT(expr) && OP(LEFT(expr)) == 0)
        return take_error(expr, LEFT(expr), RIGHT(expr));
    if (CONSTANT_TRUTH_VALUE(LEFT(expr)) == 1)
        return REPLACE_WITH_INT_CONSTANT(1, expr);
    operand = SIMPLIFY_NODE(RIGHT(expr), flags, mode);
    RIGHT(expr) = operand;
    if (RIGHT(expr) && OP(RIGHT(expr)) == 0)
        return take_error(expr, RIGHT(expr), LEFT(RIGHT(expr)));
    switch (CONSTANT_TRUTH_VALUE(LEFT(expr))) {
    case 0:
        switch (CONSTANT_TRUTH_VALUE(RIGHT(expr))) {
        case 0: expr = REPLACE_WITH_INT_CONSTANT(0, expr); break;
        case 1: expr = REPLACE_WITH_INT_CONSTANT(1, expr); break;
        }
        break;
    case 2:
        if (CONSTANT_TRUTH_VALUE(RIGHT(expr)) == 1) {
            if (IS_SIDE_EFFECT_FREE(LEFT(expr)))
                expr = REPLACE_WITH_INT_CONSTANT(1, expr);
            else {
                EXPR_W(expr, EXPR_OP) = EOP_COMMA;
                u16 one = REPLACE_WITH_INT_CONSTANT(1, RIGHT(expr));
                RIGHT(expr) = one;
            }
        }
        break;
    }
    return expr;
}

/* x = x is replaced by x */
u16 SIMPLIFY_ASSIGN(u16 expr)
{
    if (EXPRESSIONS_EQUAL(LEFT(expr), RIGHT(expr), 0)) {
        u16 old = expr;
        expr = LEFT(old);
        LEFT(old) = 0;
        FREE_EXPR_TREE(old);
    }
    return expr;
}

/* a chain of commas without recursion, its stacks threaded through the EXPR_LEFT and
   EXPR_RIGHT words of the pushed nodes, node flag 80h marking one pushed from the right.
   Left operands are discarded values; the last right operand gets the caller's mode.
   Commas whose left or right part went are removed */
u16 SIMPLIFY_COMMA(u16 expr, u16 mode)
{
    u16 left_stack = 0, right_stack = 0, child;
    u8 right_done = 0, left_done;
next_right:
    left_done = 0;
next:
    if (!left_done && !right_done) {
        child = LEFT(expr);
        if (child && OP(child) == EOP_COMMA) {
            LEFT(expr) = left_stack;
            left_stack = expr;
            expr = child;
            goto next;
        }
        u16 simplified = SIMPLIFY_NODE(child, 0, 0);
        LEFT(expr) = simplified;
    }
    if (!right_done) {
        child = RIGHT(expr);
        if (child && OP(child) == EOP_COMMA) {
            RIGHT(expr) = right_stack;
            right_stack = expr;
            expr = child;
            EXPR_B(expr, EXPR_NODE_FLAGS) |= 0x80;
            goto next_right;
        }
        u16 simplified = SIMPLIFY_NODE(child, (left_stack && mode) ? 4 : 0, left_stack ? 0 : mode);
        RIGHT(expr) = simplified;
    }
    u8 marked = EXPR_B(expr, EXPR_NODE_FLAGS) & 0x80;
    EXPR_B(expr, EXPR_NODE_FLAGS) &= 0x7F;
    if (!LEFT(expr)) {
        child = expr;
        expr = RIGHT(expr);
        FREE_EXPR_NODE(child);
    } else if (!RIGHT(expr)) {
        child = expr;
        expr = LEFT(expr);
        FREE_EXPR_NODE(child);
    }
    if (marked) {
        u16 parent = right_stack;
        right_stack = RIGHT(parent);
        RIGHT(parent) = expr;
        expr = parent;
        right_done = 1;
        goto next;
    }
    if (left_stack) {
        u16 parent = left_stack;
        left_stack = LEFT(parent);
        LEFT(parent) = expr;
        expr = parent;
        left_done = 1;
        right_done = 0;
        goto next;
    }
    return expr;
}

/* a binary node's operands simplified and the operator's rule applied.  Operators with a
   side effect (EXPR_OP_FLAGS 1: assignments) have an object on the left (mode 2), read and
   written (flags 6), only written (flags 2 added) for plain =; the left of "." keeps the
   caller's mode and flags.  An error operand makes the node an error node */
u16 SIMPLIFY_BINARY(u16 expr, u16 flags, u16 mode)
{
    u16 old = 0, level;
    u8 relation = EXPR_OP_FLAGS_AT(OP(expr)) & 1;
    u16 want = (mode == 0 && !relation) ? 0 : 4;
    if (OP(expr) == EOP_DOT)
        level = mode;
    else if (relation)
        level = 2;
    else
        level = 1;
    if (OP(expr) == EOP_ASSIGN)
        flags |= 2;
    else if (relation)
        flags = 6;
    else if (OP(expr) != EOP_DOT)
        flags = want;
    u16 operand = SIMPLIFY_NODE(LEFT(expr), flags, level);
    LEFT(expr) = operand;
    level = (OP(expr) == EOP_ANDAND || OP(expr) == EOP_OROR) ? mode : 1;
    operand = SIMPLIFY_NODE(RIGHT(expr), want, level);
    RIGHT(expr) = operand;
    if (LEFT(expr) && OP(LEFT(expr)) == 0) {
        old = expr;
        expr = LEFT(old);
        FREE_EXPR_TREE(RIGHT(old));
    }
    if (OP(expr) && RIGHT(expr) && OP(RIGHT(expr)) == 0) {
        old = expr;
        expr = RIGHT(old);
        FREE_EXPR_TREE(LEFT(old));
    }
    if (OP(expr)) {
        switch (OP(expr)) {
        case EOP_DOT: expr = SIMPLIFY_MEMBER(expr, mode); break;
        case EOP_MUL: expr = SIMPLIFY_MULTIPLY(expr, mode); break;
        case EOP_DIV: expr = SIMPLIFY_DIVIDE(expr); break;
        case EOP_MOD: expr = SIMPLIFY_MODULO(expr); break;
        case EOP_ADD: expr = SIMPLIFY_ADD(expr); break;
        case 0x2D: expr = FOLD_FAR_POINTER_CONSTANT(expr); break;
        case EOP_SUB: expr = SIMPLIFY_SUBTRACT(expr); break;
        case EOP_AND: expr = SIMPLIFY_AND(expr); break;
        case EOP_XOR: expr = SIMPLIFY_XOR(expr); break;
        case EOP_OR: expr = SIMPLIFY_OR(expr); break;
        case EOP_SHL: expr = SIMPLIFY_SHIFT(expr, 1); break;
        case EOP_SHR: expr = SIMPLIFY_SHIFT(expr, -1); break;
        case EOP_LT: expr = SIMPLIFY_COMPARISON(expr, 0, -1); break;
        case EOP_GT: expr = SIMPLIFY_COMPARISON(expr, 0, 1); break;
        case EOP_LE: expr = SIMPLIFY_COMPARISON(expr, 1, -1); break;
        case EOP_GE: expr = SIMPLIFY_COMPARISON(expr, 1, 1); break;
        case EOP_EQ: expr = SIMPLIFY_COMPARISON(expr, 1, 0); break;
        case EOP_NE: expr = SIMPLIFY_COMPARISON(expr, 0, 0); break;
        case EOP_ASSIGN: expr = SIMPLIFY_ASSIGN(expr); break;
        }
    }
    if (old)
        FREE_EXPR_NODE(old);
    return expr;
}

/* (void)0, for a missing arm of ?: */
u16 MAKE_VOID_ZERO_NODE(void)
{
    return CONVERT_EXPR_TO_TYPE(VOID_TYPE, MAKE_INT_CONSTANT(INT_TYPE, 0), 0);
}

/* c ? a : b.  A constant condition keeps only the chosen arm; equal arms make it (c, a);
   discarded, both arms become void.  Any error makes the whole an error node */
u16 SIMPLIFY_CONDITIONAL(u16 expr, u16 mode)
{
    u16 want = mode == 0 ? 0 : 4, old;
    u16 operand = SIMPLIFY_NODE(LEFT(expr), 4, 1);
    LEFT(expr) = operand;
    u8 invalid = OP(LEFT(expr)) == 0;
    u16 arms = RIGHT(expr);
    switch (CONSTANT_TRUTH_VALUE(LEFT(expr))) {
    case 0:
        old = expr;
        expr = SIMPLIFY_NODE(RIGHT(RIGHT(old)), want, mode);
        RIGHT(RIGHT(old)) = 0;
        FREE_EXPR_TREE(old);
        break;
    case 1:
        old = expr;
        expr = SIMPLIFY_NODE(LEFT(RIGHT(old)), want, mode);
        LEFT(RIGHT(old)) = 0;
        FREE_EXPR_TREE(old);
        break;
    case 2:
        if (invalid)
            break;
        operand = SIMPLIFY_NODE(LEFT(arms), want, mode);
        LEFT(arms) = operand;
        if (LEFT(arms))
            invalid = OP(LEFT(arms)) == 0;
        if (!invalid) {
            operand = SIMPLIFY_NODE(RIGHT(arms), want, mode);
            RIGHT(arms) = operand;
            if (RIGHT(arms))
                invalid = OP(RIGHT(arms)) == 0;
        }
        if (!invalid) {
            if (!LEFT(arms)) {
                operand = MAKE_VOID_ZERO_NODE();
                LEFT(arms) = operand;
            }
            if (!RIGHT(arms)) {
                operand = MAKE_VOID_ZERO_NODE();
                RIGHT(arms) = operand;
            }
            if (EXPRESSIONS_EQUAL(LEFT(arms), RIGHT(arms), 1)) {
                old = RIGHT(expr);
                RIGHT(expr) = RIGHT(old);
                RIGHT(old) = 0;
                EXPR_W(expr, EXPR_OP) = EOP_COMMA;
                FREE_EXPR_TREE(old);
                expr = SIMPLIFY_NODE(expr, want, mode);
            } else if (mode == 0) {
                operand = CONVERT_EXPR_TO_TYPE(VOID_TYPE, LEFT(arms), 0);
                LEFT(arms) = operand;
                operand = CONVERT_EXPR_TO_TYPE(VOID_TYPE, RIGHT(arms), 0);
                RIGHT(arms) = operand;
                EXPR_W(expr, EXPR_TYPE) = VOID_TYPE;
            }
        }
        break;
    }
    if (invalid)
        expr = REPORT_EXPR_ERROR_PLAIN(0, expr);
    return expr;
}

/* the dispatcher.  Symbol leaves record their use and may warn about use before
   definition (not for storage classes 1, 2, 3, 7 and 10, probably those always
   initialised such as statics and functions).  Discarded, a side-effect-free result is
   freed and 0 returned */
u16 SIMPLIFY_NODE(u16 expr, u16 flags, u16 mode)
{
    STACK_CHECK(SIMPLIFY_NODE);     /* if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY): native/stack.c */
    if (expr) {
        switch (OP(expr)) {
        case 0x36:
            expr = SIMPLIFY_CALL(expr);
            break;
        case 0x35:
            expr = SIMPLIFY_CAST(expr, flags, mode);
            break;
        case EOP_NEG: case EOP_COMPL: case EOP_NOT: case EOP_DEREF: case EOP_ADDR:
        case EOP_INC: case EOP_DEC: case 0x49:
            expr = SIMPLIFY_UNARY(expr, flags, mode);
            break;
        case EOP_ADD: case EOP_SUB: case EOP_MUL: case EOP_DIV: case EOP_MOD: case EOP_SHL:
        case EOP_SHR: case EOP_AND: case EOP_OR: case EOP_XOR: case EOP_ASSIGN: case EOP_ADD_ASSIGN:
        case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN: case EOP_DIV_ASSIGN: case EOP_MOD_ASSIGN: case EOP_SHL_ASSIGN:
        case EOP_SHR_ASSIGN: case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN: case EOP_EQ: case EOP_NE:
        case EOP_GT: case EOP_LT: case EOP_GE: case EOP_LE: case 0x2B: case 0x2D: case EOP_DOT:
            expr = SIMPLIFY_BINARY(expr, flags, mode);
            break;
        case EOP_ANDAND:
            expr = SIMPLIFY_LOGICAL_AND(expr, mode);
            break;
        case EOP_OROR:
            expr = SIMPLIFY_LOGICAL_OR(expr, mode);
            break;
        case EOP_QUESTION:
            expr = SIMPLIFY_CONDITIONAL(expr, mode);
            break;
        case EOP_COMMA:
            expr = SIMPLIFY_COMMA(expr, mode);
            break;
        case 0x01: {
            u16 symbol = LEFT(expr);
            switch (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) {
            case 1: case 2: case 3: case 7: case 10:
                break;
            default:
                if (TYPE_W(TYPE_OF(expr), TYPE_KIND) == TK_FUNCTION)
                    flags &= (u16)~2;
                SYM_B(symbol, SYM_FLAGS) |= (u8)flags;
                if (LOOP_NEST_FACTOR == 1 && (flags & 4) && !(SYM_B(symbol, SYM_FLAGS) & 2)) {
                    REPORT_DIAGNOSTIC_AT(MSG_POSSIBLE_USE_BEFORE, (i32)SYMBOL_NAME_TEXT(symbol), 0,
                                         EXPR_W(expr, EXPR_SRC_LINE), EXPR_W(expr, EXPR_SRC_WORD3));
                    SYM_B(symbol, SYM_FLAGS) |= 2;
                }
                break;
            }
            break;
        }
        }
    }
    if (mode == 0 && IS_SIDE_EFFECT_FREE(expr)) {
        FREE_EXPR_TREE(expr);
        expr = 0;
    }
    return expr;
}

/* the entry: mode nonzero, the value is discarded (an expression statement); 0, it is
   used and its symbols count as read.  The simplified tree, perhaps 0 for a discarded
   side-effect-free expression */
u16 SIMPLIFY_EXPRESSION(u16 expr, u8 mode)
{
    return SIMPLIFY_NODE(expr, mode ? 0 : 4, mode ? 0 : 1);
}

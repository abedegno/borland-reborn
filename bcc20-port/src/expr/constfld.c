/* constfld.c: from bcc20/src/expr/CONSTFLD.C: tree simplification and constant folding for
   the C front end (20-byte nodes, C-layout types, nodes made through NEW_EXPR_NODE_HOOK).
   FOLD_EXPRESSION rewrites a tree bottom up into cheaper equal forms: multiplication,
   unsigned division and remainder by a power of two become shifts and masks; *&x and &*p
   cancel; a constant added to a variable's address goes into the leaf's offset
   (EXPR_RIGHT of leaf operators 1 and 5); chains of + * & | ^ are regrouped so that their
   constants meet; x+0, x|0, x^0 and x*1 go; ?: with a constant condition picks its arm;
   !(a < b) becomes a >= b; relational compares of far pointers compare the offsets.
   FOLD_CONSTANT_NODE computes nodes whose operands are all constants (integers as long,
   floating values with the long double helpers).  FOLD_STATEMENT_EXPR first moves x += c
   and x++ on simple variables out of a statement's expression.  NARROW_FAR_POINTER makes a
   far pointer expression near when its segment is known.  Operators: below 8 leaves, 41
   (29h) a sequence that yields its left operand, 42 (2Ah) comma, 2Ch pointer difference,
   2Dh segment:offset, 51 bitfield, 53 cast, 54 call.

   The original tests the 8086 overflow flag after its long add and subtract and after
   LMUL_WITH_OVERFLOW; the port computes the same signed overflow.  Its long shifts are
   Borland's helpers, whose shift counts the 80186 takes modulo 32.  FOLD_EXPRESSION's
   "out of memory" stack check is left out (README, decisions for the native build). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"
#include "overflow.h"

#define OP(n) EXPR_W((n), EXPR_OP)
#define KIND(n) EXPR_W((n), EXPR_KIND)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define TYPE_OF(n) EXPR_W((n), EXPR_TYPE)
#define VALUE(n) EXPR_L((n), EXPR_VALUE)
#define UNSIGNED(n) (EXPR_FLAGS_AT(KIND(n)) & 0x20)
#define FLAGS8(n) EXPR_FLAGS_AT(KIND(n))

static u16 mode_type(u16 kind) { return (u16)CALL_FAR(MODE_HOOK, A16(kind)); }
static u16 new_node(u16 op, u16 type, u16 left, u16 right)
{
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(op), A16(type), A16(left), A16(right));
}

static void copy_node(u16 to, u16 from)
{
    for (int i = 0; i < 20; i++)
        EXPR_B(to, i) = EXPR_B(from, i);
}

/* 16-bit shifts as the 80186 does them: the count taken modulo 32 */
static u16 shl16(u16 v, u8 c) { c &= 31; return c >= 16 ? 0 : (u16)(v << c); }
static u16 shr16(u16 v, u8 c) { c &= 31; return c >= 16 ? 0 : (u16)(v >> c); }
static u16 sar16(u16 v, u8 c) { c &= 31; return (u16)((i16)v >> (c >= 16 ? 15 : c)); }

/* Borland's long shift helpers (F_LXLSH@, F_LXRSH@, F_LXURSH@): DX:AX by CL */
static i32 long_shl(i32 value, u8 cl)
{
    u16 ax = (u16)value, dx = (u16)((u32)value >> 16);
    if (cl < 16) {
        u16 bx = ax;
        ax = shl16(ax, cl);
        dx = shl16(dx, cl) | shr16(bx, (u8)(16 - cl));
    } else {
        dx = shl16(ax, (u8)(cl - 16));
        ax = 0;
    }
    return (i32)((u32)dx << 16 | ax);
}

static i32 long_shr(i32 value, u8 cl, int is_unsigned)
{
    u16 ax = (u16)value, dx = (u16)((u32)value >> 16);
    if (cl < 16) {
        u16 bx = dx;
        ax = shr16(ax, cl);
        dx = is_unsigned ? shr16(dx, cl) : sar16(dx, cl);
        ax |= shl16(bx, (u8)(16 - cl));
    } else {
        ax = is_unsigned ? shr16(dx, (u8)(cl - 16)) : sar16(dx, (u8)(cl - 16));
        dx = is_unsigned ? 0 : (u16)((i16)dx >> 15);
    }
    return (i32)((u32)dx << 16 | ax);
}

/* the signed long division and remainder of Borland's helpers, where the host's could trap
   (the most negative value by -1 gives itself, remainder 0) */
static i32 long_div(i32 a, i32 b) { return (a == INT32_MIN && b == -1) ? a : a / b; }
static i32 long_mod(i32 a, i32 b) { return (a == INT32_MIN && b == -1) ? 0 : a % b; }

/* simplifies the expression of an expression statement (its value unused): side effects
   moved out, then the tree folded */
u16 FOLD_STATEMENT_EXPR(u16 node)
{
    if (!node || KIND(node) == 0)
        return node;
    u16 mark = scratch_mark();
    farptr slot = scratch_alloc(2);
    W(slot) = node;
    HOIST_SIDE_EFFECTS(slot, slot, node, 3);
    node = W(slot);
    scratch_release(mark);
    return FOLD_EXPRESSION(node);
}

/* HOIST_SIDE_EFFECTS on an operand: child is its own slot, as the original's local */
static u16 hoist_operand(farptr root, u16 operand, u16 flags, int own_root)
{
    u16 mark = scratch_mark();
    farptr child = scratch_alloc(2);
    W(child) = operand;
    HOIST_SIDE_EFFECTS(own_root ? child : root, child, operand, flags);
    u16 result = W(child);
    scratch_release(mark);
    return result;
}

/* in the statement tree *root, x += c, x -= c, x++ and x-- on a simple variable (leaf
   operator up to 7) below the root are replaced by a copy of x (*output) and the update
   goes next to the root: x += c before it ((x += c), root), x++ after it (sequence 41 with
   the update on its right, through POST_TO_ASSIGN_OP).  flags 1 allows moving updates
   before, 2 after.  ?:, &&, || and calls, whose operands may not all be evaluated, are not
   entered; for a comma only the right side keeps "after", and the left side is a
   statement of its own */
void HOIST_SIDE_EFFECTS(farptr root, farptr output, u16 node, u16 flags)
{
    u16 child = (u16)EXPR_I(node, EXPR_LEFT), temporary;
    switch (EXPR_I(node, EXPR_OP)) {
    case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN:
        if (W(root) == node || !(flags & 1) || EXPR_I(child, EXPR_OP) > 7)
            goto descend;
        temporary = new_node((u16)EXPR_I(node, EXPR_OP), (u16)EXPR_I(node, EXPR_TYPE), child, (u16)EXPR_I(node, EXPR_RIGHT));
        W(output) = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
        copy_node(W(output), child);
        W(root) = new_node(42, (u16)EXPR_I(W(root), EXPR_TYPE), temporary, W(root));
        break;
    case EOP_POSTINC: case EOP_POSTDEC:
        if (W(root) == node || !(flags & 2) || EXPR_I(child, EXPR_OP) > 7)
            goto descend;
        temporary = new_node((u16)(i16)POST_TO_ASSIGN_OP_AT(EXPR_I(node, EXPR_OP)), (u16)EXPR_I(node, EXPR_TYPE), child,
                             (u16)EXPR_I(node, EXPR_RIGHT));
        W(output) = POOL_ALLOC(EXPR_POOL_SEG_P, 20);
        copy_node(W(output), child);
        W(root) = new_node(41, (u16)EXPR_I(W(root), EXPR_TYPE), W(root), temporary);
        break;
    case 51:
        child = hoist_operand(root, (u16)EXPR_I(node, EXPR_LEFT), flags, 0);
        EXPR_I(node, EXPR_LEFT) = (i16)child;
        break;
    case EOP_COMMA:
        if (flags & 2) {
            child = hoist_operand(root, (u16)EXPR_I(node, EXPR_RIGHT), 2, 0);
            EXPR_I(node, EXPR_RIGHT) = (i16)child;
        }
        child = hoist_operand(root, (u16)EXPR_I(node, EXPR_LEFT), 3, 1);
        EXPR_I(node, EXPR_LEFT) = (i16)child;
        break;
    case 1: case EOP_CONST: case 3: case 4: case 5: case 6: case 7:
    case EOP_QUESTION: case EOP_ANDAND: case EOP_OROR: case 54:
        break;
    default:
    descend:
        if (EXPR_I(node, EXPR_RIGHT)) {
            child = hoist_operand(root, (u16)EXPR_I(node, EXPR_RIGHT), flags, 0);
            EXPR_I(node, EXPR_RIGHT) = (i16)child;
        }
        if (EXPR_I(node, EXPR_LEFT)) {
            child = hoist_operand(root, (u16)EXPR_I(node, EXPR_LEFT), flags, 0);
            EXPR_I(node, EXPR_LEFT) = (i16)child;
        }
        break;
    }
}

/* x * 2^n, x / 2^n, x % 2^n: the power's exponent, -1 when value is no power of two */
static i16 log2_of(u16 constant) { return LOG2_POWER_OF_TWO((u32)VALUE(constant)); }

/* simplifies the tree (see the file comment) and returns the new tree.  Enum-typed nodes
   are given their int or char type first; casts (operator 53) and leaves come back
   unchanged; a bitfield node only folds its object */
u16 FOLD_EXPRESSION(u16 input)
{
    u16 node = input, left, right, temp;
    i16 bit;
    if (!node || KIND(node) == TK_UNDEFINED || OP(node) == 53)
        return node;
    if (KIND(node) == TK_ENUM) {
        u16 type = TYPE_OF(node);
        if (TYPE_W(type, TYPE_C_SIZE) == 1) {
            u16 t = mode_type(1);
            EXPR_W(node, EXPR_TYPE) = t;
        } else
            EXPR_W(node, EXPR_TYPE) = PLAIN_INT_TYPE;
        EXPR_W(node, EXPR_KIND) = TYPE_B(TYPE_OF(node), TYPE_KIND);
    }
    if ((i16)OP(node) <= 7)
        return node;
    left = FOLD_EXPRESSION(LEFT(node));
    LEFT(node) = left;
    if (OP(node) == 51)
        return node;
    right = FOLD_EXPRESSION(RIGHT(node));
    RIGHT(node) = right;
    switch (OP(node)) {
    case EOP_MUL:
        if (OP(left) == OP(node))
            node = REASSOCIATE_OPERANDS(node, left, right);
        else if (OP(right) == OP(node))
            node = REASSOCIATE_OPERANDS(node, right, left);
        else if (OP(left) == EOP_CONST) {
            LEFT(node) = right;
            RIGHT(node) = left;
        }
        right = RIGHT(node);
        left = LEFT(node);
        /* x * 2^n becomes x << n, x * 1 x, x * 0 (x, 0) to keep x's side effects */
        if (OP(right) == EOP_CONST) {
            if (VALUE(right) > 0) {
                bit = log2_of(right);
                if (bit == 0)
                    return left;
                if (bit > 0) {
                    VALUE(right) = bit;
                    EXPR_W(right, EXPR_KIND) = TK_UCHAR;
                    EXPR_W(node, EXPR_OP) = EOP_SHL;
                }
            } else if (VALUE(right) == 0 && OP(left) != EOP_CONST) {
                EXPR_W(node, EXPR_OP) = EOP_COMMA;
                return node;
            }
        }
        break;
    case EOP_DIV:
        if (OP(right) == EOP_CONST && VALUE(right) > 0) {
            bit = log2_of(right);
            if (bit == 0)
                return left;
            if (bit > 0 && UNSIGNED(node)) {
                VALUE(right) = bit;
                EXPR_W(right, EXPR_KIND) = TK_UCHAR;
                EXPR_W(node, EXPR_OP) = EOP_SHR;
            }
        }
        break;
    case EOP_MOD:
        if (OP(right) == EOP_CONST && VALUE(right) > 0) {
            bit = log2_of(right);
            if (bit == 0) {
                VALUE(right) = 0;
                return right;
            }
            if (bit > 0 && UNSIGNED(node)) {
                --VALUE(right);
                EXPR_W(node, EXPR_OP) = EOP_AND;
            }
        }
        break;
    /* *&x is x; a far pointer that can be near is narrowed first */
    case EOP_DEREF:
        left = NARROW_FAR_POINTER(left);
        if (OP(left) == EOP_ADDR && IS_ADDRESSABLE_NODE(LEFT(left))) {
            left = LEFT(left);
            EXPR_W(left, EXPR_TYPE) = TYPE_OF(node);
            EXPR_W(left, EXPR_KIND) = KIND(node);
            return left;
        }
        LEFT(node) = left;
        return node;
    case EOP_ADDR:
        if (OP(left) == EOP_DEREF)
            return CONVERT_EXPRESSION_TYPE(LEFT(left), TYPE_OF(node));
        return node;
    /* address + constant: the constant goes into the variable leaf's offset */
    case EOP_ADD: {
        u16 type = TYPE_OF(node);
        if (OP(right) == EOP_CONST && VALUE(right) == 0)
            return CONVERT_EXPRESSION_TYPE(left, type);
        if (OP(left) == EOP_ADDR) {
            if (OP(right) == EOP_CONST) {
                if (OP(LEFT(left)) != 1 && OP(LEFT(left)) != 5)
                    break;
                temp = LEFT(left);
                RIGHT(temp) += LEFT(right);
                return left;
            }
            FOLD_ADDRESS_OFFSET(left, right);
        } else if (OP(right) == EOP_ADDR)
            FOLD_ADDRESS_OFFSET(right, left);
        if (OP(left) == EOP_CONST || OP(left) == EOP_ADDR) {
            temp = right;
            right = left;
            left = temp;
        }
        RIGHT(node) = right;
        LEFT(node) = left;
        if (OP(left) == OP(node))
            return REASSOCIATE_OPERANDS(node, left, right);
        if (OP(right) == OP(node))
            return REASSOCIATE_OPERANDS(node, right, left);
        if (OP(right) == EOP_CONST && VALUE(right) == 0) {
            if (KIND(left) != KIND(node))
                left = CONVERT_EXPRESSION_TYPE(left, TYPE_OF(node));
            return left;
        }
        break;
    }
    case EOP_AND:
        if (OP(left) == OP(node))
            return REASSOCIATE_OPERANDS(node, left, right);
        if (OP(right) == OP(node))
            return REASSOCIATE_OPERANDS(node, right, left);
        break;
    case EOP_OR: case EOP_XOR:
        if (OP(left) == OP(node))
            return REASSOCIATE_OPERANDS(node, left, right);
        if (OP(right) == OP(node))
            return REASSOCIATE_OPERANDS(node, right, left);
        if (OP(right) != EOP_CONST || VALUE(right) != 0)
            break;
        return left;
    case 44:
        if (OP(right) == EOP_CONST && VALUE(right) == 0) {
            EXPR_W(left, EXPR_KIND) = KIND(node);
            EXPR_W(left, EXPR_TYPE) = TYPE_OF(node);
            return left;
        }
        break;
    case EOP_SUB:
        if (OP(right) != EOP_CONST)
            break;
        if (VALUE(right) == 0)
            return left;
        if (OP(left) == EOP_ADDR && (OP(LEFT(left)) == 1 || OP(LEFT(left)) == 5)) {
            node = LEFT(left);
            RIGHT(node) -= LEFT(right);
            return left;
        }
        if (UNSIGNED(node))
            break;
        VALUE(right) = (i32)(0u - (u32)VALUE(right));
        EXPR_W(node, EXPR_OP) = EOP_ADD;
        if (OP(left) == EOP_ADD)
            return REASSOCIATE_OPERANDS(node, left, right);
        break;
    case EOP_QUESTION:
        if (OP(left) == EOP_CONST)
            return VALUE(left) != 0 ? LEFT(right) : RIGHT(right);
        return node;
    case EOP_NOT:
        switch (OP(LEFT(node))) {
        case EOP_EQ: case EOP_NE: case EOP_GT: case EOP_LT: case EOP_GE: case EOP_LE:
            node = LEFT(node);
            temp = INVERT_COMPARE_OP(OP(node));
            EXPR_W(node, EXPR_OP) = temp;
            return node;
        }
        break;
    /* far pointers: < > <= >= compare the offsets only, as unsigned int */
    case EOP_GT: case EOP_LT: case EOP_GE: case EOP_LE: {
        if (KIND(left) != TK_FAR_PTR)
            break;
        u16 newtype = mode_type(6);
        temp = CONVERT_EXPRESSION_TYPE(left, newtype);
        LEFT(node) = temp;
        temp = CONVERT_EXPRESSION_TYPE(right, newtype);
        RIGHT(node) = temp;
        EXPR_W(node, EXPR_TYPE) = newtype;
        EXPR_W(node, EXPR_KIND) = TK_UINT;
        break;
    }
    /* x == 0 and x != 0 can be tested in the narrowest kind x fits */
    case EOP_EQ: case EOP_NE:
        if (OP(right) == EOP_CONST && VALUE(right) == 0) {
            left = NARROW_INTEGER_EXPR(left);
            LEFT(node) = left;
            EXPR_W(right, EXPR_KIND) = KIND(left);
        } else if (OP(left) == EOP_CONST && VALUE(left) == 0) {
            right = NARROW_INTEGER_EXPR(right);
            RIGHT(node) = right;
            EXPR_W(left, EXPR_KIND) = KIND(right);
        }
        break;
    }
    return FOLD_CONSTANT_NODE(node);
}

/* the folded floating node: a and b the 10-byte operands in the scratch area */
static u16 fold_real(u16 node, u16 left, u16 right)
{
    u16 mark = scratch_mark();
    farptr a = scratch_alloc(10), b = scratch_alloc(10);
    RTL_MEMMOVE(a, MK_FP(EXPR_POOL_SEG, left + EXPR_LEFT), 10);
    if (right)
        RTL_MEMMOVE(b, MK_FP(EXPR_POOL_SEG, right + EXPR_LEFT), 10);
    u16 op = OP(node);
    switch ((i16)op) {
    case 0x1D: case 0x1E: case 0x1F: case 0x20: case 0x21: case 0x22: {
        i16 r = RTL_LDOUBLE_COMPARE(a, b);
        switch (op) {
        case EOP_EQ: r = r == 0; break;
        case EOP_NE: r = r != 0; break;
        case EOP_GT: r = r > 0; break;
        case EOP_LT: r = r < 0; break;
        case EOP_GE: r = r >= 0; break;
        case EOP_LE: r = r <= 0; break;
        }
        u16 int_type = mode_type(5);
        left = (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(int_type), A32((u32)(i32)r));
        scratch_release(mark);
        return left;
    }
    case 8: RTL_LDOUBLE_ADD(a, b); break;
    case 9: RTL_LDOUBLE_SUB(a, b); break;
    case 10: RTL_LDOUBLE_MUL(a, b); break;
    case 11: RTL_LDOUBLE_DIV(a, b); break;
    case 0x2E: W(fp_add(a, 8)) ^= 0x8000; break;
    default:
        scratch_release(mark);
        return node;
    }
    RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG, left + EXPR_LEFT), a, 10);
    scratch_release(mark);
    return left;
}

/* a unary or binary node whose operands are all constants computed: integers as longs,
   written back into the left operand node, which is returned; floating compares give a new
   node.  node unchanged when its operands are not all constants or the operator does not
   fold.  A signed overflow in +, - or * is an error and the value becomes 1 */
u16 FOLD_CONSTANT_NODE(u16 node)
{
    u16 left = LEFT(node), right = RIGHT(node);
    if (OP(left) == 3 && (!right || OP(right) == 3))
        return fold_real(node, left, right);
    if (OP(left) != EOP_CONST || (right && OP(right) != EOP_CONST))
        return node;
    i32 lv = VALUE(left), rv = 0;   /* rv is left unset for a unary operator in the original */
    if (right)
        rv = VALUE(right);
    u32 ul = (u32)lv, ur = (u32)rv;
    switch (OP(node)) {
    case EOP_ADD: {
        i32 sum = (i32)(ul + ur);
        if (((lv ^ sum) & (rv ^ sum)) < 0 && !UNSIGNED(node)) {
            REPORT_CONSTANT_TOO_LARGE();
            sum = 1;
        }
        lv = sum;
        break;
    }
    case 0x2D:      /* a segment and an offset combined into one 32-bit value */
        if (KIND(left) == TK_SEG_PTR)
            lv = (i32)(((u32)(u16)lv << 16) + ur);
        else
            lv = (i32)(((u32)(u16)rv << 16) + ul);
        break;
    case EOP_SUB: {
        i32 difference = (i32)(ul - ur);
        if (((lv ^ rv) & (lv ^ difference)) < 0 && !UNSIGNED(node)) {
            REPORT_CONSTANT_TOO_LARGE();
            difference = 1;
        }
        lv = difference;
        break;
    }
    case EOP_MUL:
        if (!UNSIGNED(node)) {
            lv = LMUL_WITH_OVERFLOW(lv, rv);
            if (lmul_overflow) {
                REPORT_CONSTANT_TOO_LARGE();
                lv = 1;
            }
        } else
            lv = (i32)(ul * ur);
        break;
    case EOP_DIV:
        if (rv == 0)
            REPORT_WARNING(MSG_DIVISION_ZERO_381);
        else if (UNSIGNED(node))
            lv = (i32)(ul / ur);
        else
            lv = long_div(lv, rv);
        break;
    case EOP_MOD:
        if (rv == 0)
            REPORT_WARNING(MSG_DIVISION_ZERO_381);
        else if (UNSIGNED(node))
            lv = (i32)(ul % ur);
        else
            lv = long_mod(lv, rv);
        break;
    case EOP_SHL:
        lv = long_shl(lv, (u8)rv);
        break;
    case EOP_SHR:
        lv = long_shr(lv, (u8)rv, UNSIGNED(node) != 0);
        break;
    case EOP_AND: lv &= rv; break;
    case EOP_OR: lv |= rv; break;
    case EOP_XOR: lv ^= rv; break;
    case EOP_NOT: lv = !(i16)lv; break;
    case EOP_NEG: lv = (i32)(0u - ul); break;
    case EOP_COMPL: lv = ~lv; break;
    case EOP_EQ: lv = lv == rv; break;
    case EOP_NE: lv = lv != rv; break;
    case EOP_LT: lv = UNSIGNED(left) ? ul < ur : lv < rv; break;
    case EOP_GT: lv = UNSIGNED(left) ? ul > ur : lv > rv; break;
    case EOP_LE: lv = UNSIGNED(left) ? ul <= ur : lv <= rv; break;
    case EOP_GE: lv = UNSIGNED(left) ? ul >= ur : lv >= rv; break;
    case EOP_ANDAND: lv = (i16)lv && (i16)rv; break;
    case EOP_OROR: lv = (i16)lv || (i16)rv; break;
    case 0x2C:      /* pointer difference: near the int difference, huge below, far the offsets' */
        if (KIND(node) == TK_NEAR_PTR)
            lv = (i32)(i16)lv - (i16)rv;
        else if (KIND(node) == TK_HUGE_PTR) {
            /* huge pointers: (seg << 12) + off in 16-bit unsigned arithmetic (the original
               truncates), then subtracted */
            u16 l = (u16)((u16)(ul >> 16) << 12) + (u16)ul;
            u16 r = (u16)((u16)(ur >> 16) << 12) + (u16)ur;
            lv = (i32)l - (i32)r;
        } else
            lv = (i32)(ul & 0xFFFF) - (i32)(ur & 0xFFFF);
        break;
    default:
        return node;
    }
    EXPR_W(left, EXPR_KIND) = KIND(node);
    EXPR_W(left, EXPR_TYPE) = TYPE_OF(node);
    VALUE(left) = (i32)CALL_FAR(TOKEN_CONVERT, A32((u32)lv), A16(KIND(left)));
    return left;
}

/* "numeric constant too large", for an overflow while folding */
void REPORT_CONSTANT_TOO_LARGE(void)
{
    REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
}

/* node and its operand left share an associative operator: (a op b) op c regrouped so
   that constants (and addresses, whose constant offsets fold into the leaf) meet and fold,
   for example (x + 1) + 2 into x + 3, or (&v + i) + 4 into &v' + i with the offset moved
   into v.  The result type goes along so that pointer arithmetic keeps its pointer type.
   Returns the new top */
u16 REASSOCIATE_OPERANDS(u16 node, u16 left, u16 right)
{
    u16 b, c, kind = OP(node);
    LEFT(node) = left;
    RIGHT(node) = right;
    u16 a = RIGHT(left);
    if (OP(a) != EOP_CONST && OP(a) != EOP_ADDR) {
        if (OP(right) != kind)
            return node;
        if (FLAGS8(node) & 0x15) {
            b = LEFT(right);
            c = RIGHT(right);
            if ((FLAGS8(left) & 0x14) || (FLAGS8(c) & 0x14)) {
                EXPR_W(right, EXPR_KIND) = KIND(left);
                EXPR_W(right, EXPR_TYPE) = TYPE_OF(left);
            }
            RIGHT(node) = c;
            LEFT(node) = right;
            RIGHT(right) = b;
            LEFT(right) = left;
        }
        return node;
    }
    if (OP(right) == EOP_CONST) {
        EXPR_W(left, EXPR_KIND) = KIND(node);
        EXPR_W(left, EXPR_TYPE) = TYPE_OF(node);
        if (!(FLAGS8(right) & 0x14)) {
            EXPR_W(node, EXPR_KIND) = KIND(a);
            EXPR_W(node, EXPR_TYPE) = TYPE_OF(a);
        }
        LEFT(node) = a;
        node = FOLD_EXPRESSION(node);
        RIGHT(left) = node;
        FOLD_ADDRESS_OFFSET(RIGHT(left), LEFT(left));
        return left;
    }
    if (OP(right) == EOP_ADDR) {
        if (OP(a) == EOP_CONST) {
            RIGHT(node) = a;
            LEFT(node) = right;
            u16 folded = FOLD_EXPRESSION(node);
            RIGHT(left) = folded;
            EXPR_W(left, EXPR_KIND) = KIND(node);
            EXPR_W(left, EXPR_TYPE) = TYPE_OF(node);
            FOLD_ADDRESS_OFFSET(RIGHT(left), LEFT(left));
            return left;
        }
        FOLD_ADDRESS_OFFSET(RIGHT(node), LEFT(node));
        return node;
    }
    if (OP(right) != kind) {
        if ((FLAGS8(a) & 0x14) || (FLAGS8(right) & 0x14)) {
            EXPR_W(left, EXPR_KIND) = KIND(right);
            EXPR_W(left, EXPR_TYPE) = TYPE_OF(right);
        }
        RIGHT(left) = right;
        RIGHT(node) = a;
        FOLD_ADDRESS_OFFSET(RIGHT(node), LEFT(node));
        return node;
    }
    b = LEFT(right);
    c = RIGHT(right);
    if (OP(c) != EOP_CONST && OP(c) != EOP_ADDR) {
        if (FLAGS8(a) & 0x14) {
            EXPR_W(left, EXPR_KIND) = KIND(b);
            EXPR_W(left, EXPR_TYPE) = TYPE_OF(b);
        } else if (FLAGS8(left) & 0x14) {
            EXPR_W(right, EXPR_KIND) = KIND(left);
            EXPR_W(right, EXPR_TYPE) = TYPE_OF(left);
        }
        LEFT(right) = left;
        RIGHT(left) = b;
        RIGHT(right) = c;
        LEFT(node) = right;
        RIGHT(node) = a;
        FOLD_ADDRESS_OFFSET(RIGHT(node), LEFT(node));
        return node;
    }
    if (OP(c) == EOP_CONST) {
        if (!(FLAGS8(left) & 0x14) || (FLAGS8(a) & 0x14)) {
            EXPR_W(left, EXPR_KIND) = KIND(b);
            EXPR_W(left, EXPR_TYPE) = TYPE_OF(b);
        }
        LEFT(right) = a;
        u16 folded = FOLD_EXPRESSION(right);
        RIGHT(node) = folded;
        RIGHT(left) = b;
        FOLD_ADDRESS_OFFSET(RIGHT(node), LEFT(node));
        return node;
    }
    if (OP(a) == EOP_CONST) {
        LEFT(right) = c;
        RIGHT(right) = a;
        u16 folded = FOLD_EXPRESSION(right);
        RIGHT(node) = folded;
        RIGHT(left) = b;
        FOLD_ADDRESS_OFFSET(RIGHT(node), LEFT(node));
        return node;
    }
    return node;
}

/* target is &variable (leaf operator 1 or 5) and expr an index added to it: the constant
   parts of (i + c) * k and (i + c) << n go into the variable's offset (c * k), leaving
   i * k; through + recursively */
void FOLD_ADDRESS_OFFSET(u16 target, u16 expr)
{
    if (OP(target) != EOP_ADDR)
        return;
    if (OP(LEFT(target)) != 1 && OP(LEFT(target)) != 5)
        return;
    i32 multiplier;
    switch (OP(expr)) {
    case EOP_ADD:
        FOLD_ADDRESS_OFFSET(target, LEFT(expr));
        FOLD_ADDRESS_OFFSET(target, RIGHT(expr));
        return;
    case EOP_MUL:
        if (OP(RIGHT(expr)) != EOP_CONST)
            return;
        multiplier = VALUE(RIGHT(expr));
        break;
    case EOP_SHL:
        if (OP(RIGHT(expr)) != EOP_CONST)
            return;
        multiplier = (i16)shl16(1, EXPR_B(RIGHT(expr), EXPR_VALUE));
        break;
    default:
        return;
    }
    u16 product = LEFT(expr);
    if (OP(product) != EOP_ADD || OP(RIGHT(product)) != EOP_CONST)
        return;
    RIGHT(LEFT(target)) = RIGHT(LEFT(target)) + (u16)((u32)multiplier * (u32)VALUE(RIGHT(product)));
    LEFT(expr) = LEFT(product);
}

/* n when value is 2 to the n, else -1 (also for 0) */
i16 LOG2_POWER_OF_TWO(u32 value)
{
    if (!value)
        return -1;
    i16 bit = 0;
    while (!(value & 1)) {
        value >>= 1;
        ++bit;
    }
    value >>= 1;
    if (value)
        return -1;
    return bit;
}

/* when every value the far pointer expression can have lies in one known segment
   (FAR_POINTER_NARROW_MASK gives its near pointer mode), the tree retyped to a near
   pointer of that mode and folded again; not when DATA and BSS are in different groups */
u16 NARROW_FAR_POINTER(u16 node)
{
    if (DATA_BSS_GROUPS_DIFFER)
        return node;
    i16 mask = FAR_POINTER_NARROW_MASK(node);
    if (mask) {
        u16 near_type = NEW_POINTER_TYPE(TYPE_W(TYPE_OF(node), TYPE_C_TARGET), 13, 0, 0, mask);
        RETYPE_POINTER_TREE(node, near_type);
        node = FOLD_EXPRESSION(node);
    }
    return node;
}

/* every far pointer node of the tree given the near pointer type type; a cast from a near
   pointer goes by copying its operand over it */
void RETYPE_POINTER_TREE(u16 node, u16 type)
{
    if (!node || EXPR_I(node, EXPR_KIND) != TK_FAR_PTR)
        return;
    EXPR_I(node, EXPR_TYPE) = (i16)type;
    EXPR_I(node, EXPR_KIND) = TYPE_B(type, 0);
    switch (EXPR_I(node, EXPR_OP)) {
    case 53:
        if (EXPR_I(EXPR_I(node, EXPR_LEFT), EXPR_KIND) == TK_NEAR_PTR) {
            copy_node(node, (u16)EXPR_I(node, EXPR_LEFT));
            EXPR_I(node, EXPR_TYPE) = (i16)type;
        }
        break;
    case EOP_COMMA:
        RETYPE_POINTER_TREE((u16)EXPR_I(node, EXPR_RIGHT), type);
        break;
    case 1: case EOP_CONST: case 3: case 4: case 5: case 6: case 7:
    case EOP_DEREF: case EOP_ADDR: case 51:
        break;
    default:
        RETYPE_POINTER_TREE((u16)EXPR_I(node, EXPR_LEFT), type);
        RETYPE_POINTER_TREE((u16)EXPR_I(node, EXPR_RIGHT), type);
        break;
    }
}

/* the near pointer mode (2 code, 3 stack, 4 data) that every value of the far pointer
   expression shares, or 0 when unknown: the address of a variable whose leaf STBIN9 passes
   (probably one in the default data group) 2 for a function and 4 otherwise; the address
   of a local 4 when SS equals DS, else 3; a cast from a near pointer that pointer's mode;
   arithmetic its pointer operand's; both arms of ?: must agree */
i16 FAR_POINTER_NARROW_MASK(u16 node)
{
    if (!node || EXPR_I(node, EXPR_KIND) != TK_FAR_PTR)
        return 0;
    u16 left = (u16)EXPR_I(node, EXPR_LEFT);
    switch (EXPR_I(node, EXPR_OP)) {
    case 1: case EOP_CONST: case 3: case 4: case 5: case 6: case 7:
    case EOP_ASSIGN: case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN: case 41: case EOP_DEREF: case 51: case 54:
        return 0;
    case 53:
        if (EXPR_I(left, EXPR_KIND) == TK_NEAR_PTR)
            return (i8)TYPE_B((u16)EXPR_I(left, EXPR_TYPE), 8);
        return 0;
    case EOP_ADDR:
        if (EXPR_I(left, EXPR_OP) == 1) {
            if (!STBIN9(left))
                return EXPR_I(left, EXPR_KIND) == TK_FUNCTION ? 2 : 4;
            return 0;
        }
        if (EXPR_I(left, EXPR_OP) == 54 || EXPR_I(left, EXPR_OP) == EOP_DEREF)
            return 0;
        return OPTION_SS_EQUALS_DS ? 4 : 3;
    case EOP_COMMA:
        return FAR_POINTER_NARROW_MASK((u16)EXPR_I(node, EXPR_RIGHT));
    case EOP_COLON: {
        i16 mode = FAR_POINTER_NARROW_MASK(left);
        if (!mode || FAR_POINTER_NARROW_MASK((u16)EXPR_I(node, EXPR_RIGHT)) != mode)
            return 0;
        return mode;
    }
    default: {
        i16 mode = FAR_POINTER_NARROW_MASK(left);
        if (mode)
            return mode;
        break;
    }
    }
    return FAR_POINTER_NARROW_MASK((u16)EXPR_I(node, EXPR_RIGHT));
}

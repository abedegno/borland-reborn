/* cgexpr.c: from bcc20/src/codegen/CGEXPR.C (overlay CO059): the entry to expression code
   generation.  GENERATE_EXPRESSION turns an analysed expression tree (EXPR_POOL_SEG nodes,
   after LABEL_REGISTER_NEED has filled the register-need byte) into code ops for the current
   flow block and returns the result as an op pair packed in a long (low word: the op holding
   the value or its low word; high word: the op holding the high word or segment, 0 if
   none).  It handles the shapes that need special code itself (comma lists, dereferences,
   struct and bit-field assignment, address-of, x++/x--, long division and shifts,
   comparisons and ?: as values, calls) and sends everything else to GENERATE_OPERATOR.
   mode 0 means the value is not needed (expression statement), 1 that it is.
   The file also has the condition code used by FLOWBLK.C's EMIT_COND_JUMP_*: EMIT_COMPARE
   (a comparison that ends the current block with a conditional jump, long comparisons split
   over several blocks) and EMIT_TEST_ZERO; the function-entry stack check; struct pushes
   and copies through run-time helpers; and loads through pointers.
   Jump kinds set here (CNODE_JUMP_KIND): 1 always, 3 signed greater, 5 unsigned above, 0Ah
   equal, 0Bh not equal, 12-19 jump on a CPU flag, probably.  Probable op meanings: 80h/81h
   CMP byte/word, 85h/86h TEST byte/word, 4Dh OR word, B5h/B6h load DX:AX / CX:BX, B4h a
   value for the 8087, BEh a far address for a helper, C2h/C3h a helper's result in AX/DX.
   The original checks the stack at the top of GENERATE_EXPRESSION (MSG_OUT_MEMORY below
   SP 8F0Ch, since the generator is deeply recursive); the port runs on the host stack and
   has no such check. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "variadic.h"

#define HUGE_PTR_AHSHIFT_MODE SB(HUGE_PTR_AHSHIFT_MODE_P)

#define LO(v) ((u16)(v))
#define HI(v) ((u16)((v) >> 16))
#define PAIR(low, high) ((u32)(u16)(low) | (u32)(u16)(high) << 16)

#define OP(n) EXPR_W((n), EXPR_OP)
#define KIND(n) EXPR_W((n), EXPR_KIND)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define IS_FLOAT(kind) (EXPR_FLAGS_AT(kind) & 2)

static u16 constant(u8 kind, u16 value) { return NEW_CONSTANT_NODE(kind, 0, value); }
static u16 size_of_type(u16 type) { return (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type)); }
static u16 expand_compound(u16 node) { return (u16)CALL_FAR(EXPAND_COMPOUND_ASSIGN_HOOK, A16(node)); }
static u16 symbol_index(u16 symbol) { return (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(symbol)); }
static u16 int_type(void) { return (u16)CALL_FAR(MODE_HOOK, A16(5)); }
static u16 new_const(u16 type, u16 value)
{
    return (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(type), A16(0), A16(value));
}
static u16 new_expr(u16 op, u16 type, u16 left, u16 right)
{
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(op), A16(type), A16(left), A16(right));
}
static void close_ops(u16 block)
{
    CNODE_W(block, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(block, CNODE_FIRST_OP);
}

/* the comma list at node, whose left operand is a comma too: the left-leaning chain is
   reversed in place so the left-most expression is generated first, each for its side
   effects; the last one gives the value */
static u32 generate_comma_list(u16 node)
{
    u16 last = node;
    u16 item = LEFT(node);
    u16 previous = node, first;
    for (;;) {
        first = LEFT(item);
        u16 old_right = RIGHT(item);
        RIGHT(item) = previous;
        LEFT(item) = old_right;
        previous = item;
        if (!first || OP(first) != EOP_COMMA)
            break;
        item = first;
    }
    GENERATE_EXPRESSION(first, 1);
    node = previous;
    do {
        EXPR_SC(node, EXPR_NODE_FLAGS) = -1;
        GENERATE_EXPRESSION(LEFT(node), 1);
        u16 next = RIGHT(node);
        RIGHT(node) = LEFT(node);
        LEFT(node) = first;
        first = node;
        node = next;
    } while (node != last);
    EXPR_SC(node, EXPR_NODE_FLAGS) = -1;
    return GENERATE_EXPRESSION(RIGHT(node), 1);
}

/* a ?: node as a value, generated with blocks: the condition jumps to the second arm, each
   arm ends with op 2 (the value carried to the join), and the join's op 3 is the result.
   Op 6 with 1055h first frees the registers, so both arms start from the same state */
static u32 generate_conditional(u16 node)
{
    u16 first_expression = LEFT(RIGHT(node));
    u8 expression_kind = (u8)KIND(first_expression);
    u16 second_expression = RIGHT(RIGHT(node));
    u16 item = CURRENT_CODE_BLOCK;
    u16 join_label = NEW_LABEL();
    u16 alternate_label = NEW_LABEL();
    u32 left = 0, right = 0;
    u16 low = 0, high = 0;
    constant(6, 0x1055);
    close_ops(item);
    u16 temporary = NEW_BRANCH_BLOCK(0, LEFT(node), alternate_label, 0, 0, 0, 0);
    JOIN_BLOCK_CHAINS(item, temporary);
    temporary = NEW_BLOCK();
    CURRENT_CODE_BLOCK = temporary;
    if (expression_kind != TK_VOID) {
        left = GENERATE_EXPRESSION(first_expression, 1);
        u16 left_low = NEW_CODE_NODE(2, 0, LO(left), 0);
        u16 left_high = HI(left);
        if (left_high)
            left_high = NEW_CODE_NODE(2, 0, left_high, 0);
        left = PAIR(left_low, left_high);
    } else
        GENERATE_EXPRESSION(first_expression, 0);
    close_ops(CURRENT_CODE_BLOCK);
    JOIN_BLOCK_CHAINS(item, temporary);
    JOIN_BLOCK_CHAINS(item, NEW_JUMP_BLOCK(join_label, 0, 0, 0, 0));
    JOIN_BLOCK_CHAINS(item, alternate_label);
    temporary = NEW_BLOCK();
    CURRENT_CODE_BLOCK = temporary;
    if (expression_kind != TK_VOID) {
        right = GENERATE_EXPRESSION(second_expression, 1);
        u16 right_low = NEW_CODE_NODE(2, 0, LO(right), LO(left));
        u16 right_high = HI(right);
        if (right_high)
            right_high = NEW_CODE_NODE(2, 0, right_high, HI(left));
        right = PAIR(right_low, right_high);
    } else
        GENERATE_EXPRESSION(second_expression, 0);
    close_ops(CURRENT_CODE_BLOCK);
    JOIN_BLOCK_CHAINS(item, temporary);
    JOIN_BLOCK_CHAINS(item, join_label);
    temporary = NEW_BLOCK();
    CURRENT_CODE_BLOCK = temporary;
    JOIN_BLOCK_CHAINS(item, temporary);
    if (expression_kind != TK_VOID) {
        low = NEW_CODE_NODE(3, 0, LO(left), LO(right));
        if (HI(left))
            high = NEW_CODE_NODE(3, 0, HI(left), HI(right));
    }
    return PAIR(low, high);
}

/* a long shift by the constant 16 or 1, done inline: by 16 the words just move (CWD fills
   the high word for a signed right shift); by 1 a shift of one word and a
   rotate-through-carry of the other (55h/56h probably RCR/RCL) */
static u32 generate_long_shift(u16 node, u16 count)
{
    u32 left = GENERATE_EXPRESSION(LEFT(node), 1);
    u16 low, high;
    if (count == 0x10) {
        if (OP(node) == EOP_SHL) {
            high = LO(left);
            low = constant(0x0A, 0);
        } else if (KIND(node) == TK_ULONG) {
            low = HI(left);
            high = constant(0x0A, 0);
        } else {
            low = NEW_CODE_NODE(0xAC, 0, HI(left), 0);
            high = constant(0xC3, 0);
        }
    } else {
        u16 item = constant(9, count);
        if (OP(node) == EOP_SHL) {
            low = NEW_CODE_NODE(0x45, 0, LO(left), item);
            high = NEW_CODE_NODE(0x56, 0, HI(left), item);
        } else {
            high = NEW_CODE_NODE(KIND(node) == TK_ULONG ? 0x47 : 0x49, 0, HI(left), item);
            low = NEW_CODE_NODE(0x55, 0, LO(left), item);
        }
    }
    return PAIR(low, high);
}

/* generates expression input (see the overview).  Small structs (up to 4 bytes) are
   handled as integers and enums as int.  Compound assignments to register
   pseudo-variables or awkward targets are first rewritten by EXPAND_COMPOUND_ASSIGN_HOOK
   into x = x op y */
u32 GENERATE_EXPRESSION(u16 input, u16 mode)
{
    u16 node = input, item, temporary;
    if (KIND(node) == TK_UNDEFINED)
        return 0;
    if ((KIND(node) == TK_STRUCT || KIND(node) == TK_UNION) && size_of_type(EXPR_W(node, EXPR_TYPE)) <= 4)
        NARROW_STRUCT_TO_SCALAR(node);
    else if (KIND(node) == TK_ENUM)
        KIND(node) = TK_INT;
    if ((i16)OP(node) >= EOP_ADD_ASSIGN && (i16)OP(node) <= EOP_XOR_ASSIGN) {
        if (OP(LEFT(node)) == 4) {
            item = symbol_index(LEFT(LEFT(node)));
            if ((item >= 0x0C && item <= 0x0F) || item == 0xFFFF)
                node = expand_compound(node);
        } else if (OP(LEFT(node)) == 0x33)
            return UNSET_PASS(GENERATE_BITFIELD_OP_ASSIGN(node, mode));
    }
    switch (OP(node)) {
    case 0x35:
        if (KIND(node) == TK_VOID)
            return UNSET_PASS(GENERATE_EXPRESSION(LEFT(node), mode));
        break;
    case 0x33:
        return (u32)GENERATE_BITFIELD_LOAD(node);
    case 0x29:
        EXPR_SC(node, EXPR_NODE_FLAGS) = -1;
        break;
    case EOP_COMMA:
        EXPR_SC(node, EXPR_NODE_FLAGS) = -1;
        if (OP(LEFT(node)) == EOP_COMMA)
            return generate_comma_list(node);
        break;
    case EOP_DEREF: {
        item = LEFT(node);
        if (KIND(item) == TK_SEG_PTR) {
            u32 pointer = GENERATE_EXPRESSION(item, 1);
            u16 high = LO(pointer);
            u16 low = constant(0x0A, 0);
            return GENERATE_INDIRECT_LOAD(node, high, low);
        }
        if (OP(item) == EOP_ADDR)
            return GENERATE_DEREF_OF_ADDRESS(node, LEFT(item), 0);
        if (OP(item) == EOP_ADD && OP(LEFT(item)) == EOP_ADDR && OP(RIGHT(item)) == EOP_CONST)
            return GENERATE_DEREF_OF_ADDRESS(node, LEFT(LEFT(item)), LEFT(RIGHT(item)));
        u32 pointer = GEN_DEREF_FAR_ADD_ASSIGN(item);
        if (!LO(pointer))
            pointer = GENERATE_EXPRESSION(item, 1);
        return GENERATE_INDIRECT_LOAD(node, HI(pointer), LO(pointer));
    }
    case EOP_ASSIGN:
        /* structs through GENERATE_STRUCT_ASSIGN, bit-fields through
           GENERATE_BITFIELD_STORE; a floating assignment drops a cast between floating
           kinds on its right side; assigning to _FLAGS (register pseudo-variable FFFFh)
           pushes the value and pops it into the flags (op 74h) */
        item = LEFT(node);
        if (KIND(node) == TK_UNION || KIND(node) == TK_STRUCT)
            return GENERATE_STRUCT_ASSIGN(node, mode);
        if (OP(item) == 0x33)
            return UNSET_PASS(GENERATE_BITFIELD_STORE(item, RIGHT(node), mode));
        if (IS_FLOAT(KIND(node))) {
            u16 right = RIGHT(node);
            if (OP(right) == 0x35) {
                u16 child = LEFT(right);
                if (IS_FLOAT(KIND(child)))
                    RIGHT(node) = child;
            }
            break;
        }
        if (OP(item) != 4 || symbol_index(LEFT(item)) != 0xFFFF)
            break;
        {
            u32 result = GENERATE_EXPRESSION(RIGHT(node), 1);
            NEW_CODE_NODE(0x94, 0, LO(result), 0);
            NEW_CODE_NODE(0x74, 0, 0, 0);
            return result;
        }
    case EOP_ADDR:
        if (IS_FLOAT(KIND(LEFT(node))))
            CODE_OUTPUT_FLAGS |= 2;
        return UNSET_PASS(GENERATE_ADDRESS_OF(LEFT(node), (u8)KIND(node)));
    case EOP_POSTINC:
        if (IS_FLOAT(KIND(node)))
            return GEN_FLOAT_POSTINC_DEC(node, mode);
        if (OP(LEFT(node)) == 0x33)
            return UNSET_PASS(GENERATE_BITFIELD_INC_DEC(node, mode));
        return GENERATE_POST_INCREMENT(node);
    case EOP_DIV:
    case EOP_MOD: {
        /* long division and remainder: both operands are pushed (right first, high word
           first) and the helper from OPERATOR_HELPER_NAME_TABLE is called; it pops its 8
           bytes (op AEh) and returns the result in DX:AX.  Op 6 with 55h first frees AX,
           DX, BX and CX, probably */
        if (KIND(node) != TK_LONG && KIND(node) != TK_ULONG)
            break;
        constant(6, 0x55);
        u32 value = GENERATE_EXPRESSION(RIGHT(node), 1);
        NEW_CODE_NODE(0x94, 0, HI(value), 0);
        NEW_CODE_NODE(0x94, 0, LO(value), 0);
        value = GENERATE_EXPRESSION(LEFT(node), 1);
        NEW_CODE_NODE(0x94, 0, HI(value), 0);
        NEW_CODE_NODE(0x94, 0, LO(value), 0);
        EMIT_OPERATOR_HELPER(node);
        constant(0xAE, 8);
        u16 low = constant(0xC2, 0);
        u16 high = constant(0xC3, 0);
        return PAIR(low, high);
    }
    case EOP_POSTDEC:
        if (IS_FLOAT(KIND(node)))
            return GEN_FLOAT_POSTINC_DEC(node, mode);
        if (OP(LEFT(node)) == 0x33)
            return UNSET_PASS(GENERATE_BITFIELD_INC_DEC(node, mode));
        return GENERATE_POST_DECREMENT(node);
    case EOP_DIV_ASSIGN:
    case EOP_MOD_ASSIGN:
        if ((i16)KIND(node) >= TK_SHORT && (i16)KIND(node) <= TK_UINT) {
            node = expand_compound(node);
            break;
        }
        /* fall through */
    case EOP_MUL_ASSIGN:
    case EOP_SHL_ASSIGN:
    case EOP_SHR_ASSIGN:
        if (IS_FLOAT(KIND(node)) && ((i16)OP(LEFT(node)) > 7 || mode)) {
            node = expand_compound(node);
            break;
        }
        if (KIND(node) == TK_LONG || KIND(node) == TK_ULONG)
            node = expand_compound(node);
        break;
    case EOP_ADD_ASSIGN:
    case EOP_SUB_ASSIGN:
        if (IS_FLOAT(KIND(node)) && ((i16)OP(LEFT(node)) > 7 || mode)) {
            node = expand_compound(node);
            break;
        }
        if (!HUGE_PTR_AHSHIFT_MODE && KIND(node) == TK_HUGE_PTR) {
            u16 pointer = (u16)CALL_FAR(DECAY_TO_POINTER_HOOK, A16(EXPR_W(LEFT(node), EXPR_TYPE)),
                                        A16(LEFT(node)), A16(1));
            LEFT(node) = pointer;
        }
        break;
    case EOP_SHL:
    case EOP_SHR:
        if (KIND(node) != TK_LONG && KIND(node) != TK_ULONG)
            break;
        if (OP(RIGHT(node)) != EOP_CONST)
            break;
        if (EXPR_L(RIGHT(node), EXPR_VALUE) > 0xFFFFL)
            break;
        temporary = (u16)EXPR_L(RIGHT(node), EXPR_VALUE);
        if (temporary != 0x10 && temporary != 1)
            break;
        return generate_long_shift(node, temporary);
    case 0x36:
        return (u32)GENERATE_CALL(node, mode);
    case EOP_NOT: {
        u16 operation = OP(LEFT(node));
        if (operation != EOP_OROR && operation != EOP_ANDAND && (i16)KIND(LEFT(node)) <= TK_UINT)
            break;
    }
        /* fall through */
    case EOP_EQ: case EOP_NE: case EOP_GT: case EOP_LT: case EOP_GE: case EOP_LE:
    case EOP_ANDAND: case EOP_OROR: {
        /* a comparison or logical operator used as a value becomes cond ? 1 : 0 */
        item = new_const(int_type(), 1);
        temporary = new_const(int_type(), 0);
        temporary = new_expr(0x26, EXPR_W(item, EXPR_TYPE), item, temporary);
        node = new_expr(0x25, EXPR_W(item, EXPR_TYPE), node, temporary);
    }
        /* fall through */
    case EOP_QUESTION:
        return generate_conditional(node);
    }
    /* rewritten nodes deliberately reach here without being dispatched again */
    if ((OP(node) == EOP_DIV || OP(node) == EOP_MOD) && (KIND(node) == TK_LONG || KIND(node) == TK_ULONG))
        constant(6, 0x55);
    return GENERATE_OPERATOR(node);
}

/* generates return node and moves the value where the caller expects it: AX (B5h with the
   low word only), DX:AX for longs and far pointers, the 8087 for floats (B4h) */
void EMIT_RETURN_VALUE(u16 node)
{
    u32 result = GENERATE_EXPRESSION(LABEL_REGISTER_NEED(node), 1);
    switch (KIND(node)) {
    case 7: case 8: case 15: case 16:
        NEW_CODE_NODE(0xB5, 0, LO(result), HI(result));
        break;
    case 9: case 10: case 11:
        NEW_CODE_NODE(0xB4, 0, LO(result), 0);
        break;
    default:
        NEW_CODE_NODE(0xB5, 0, LO(result), 0);
        break;
    }
}

/* generates node and sets the CPU flags for a test against zero: OR of the two words of a
   long or far pointer; TEST of the operands of an AND node; nothing extra when the last
   operation already set the flags (RESULT_SETS_FLAGS); otherwise CMP with 0; floating
   values are compared with 0.0 on the 8087 (GEN_FPU_COMPARE with FLDZ) */
void EMIT_TEST_ZERO(u16 node)
{
    node = LABEL_REGISTER_NEED(node);
    u32 first, second;
    switch (KIND(node)) {
    case 7: case 8: case 15: case 16:
        first = GENERATE_EXPRESSION(node, 1);
        NEW_CODE_NODE(0x4D, 0, LO(first), HI(first));
        break;
    case 3: case 4: case 5: case 6: case 13: case 14:
    case 1: case 2: {
        int word = KIND(node) > 2;
        if (OP(node) == 0x0F) {
            u16 other = RIGHT(node), left = LEFT(node);
            if (EXPR_SC(node, EXPR_NODE_FLAGS) > 0) {
                first = GENERATE_EXPRESSION(other, 1);
                second = GENERATE_EXPRESSION(left, 1);
            } else {
                first = GENERATE_EXPRESSION(left, 1);
                second = GENERATE_EXPRESSION(other, 1);
            }
            NEW_CODE_NODE(word ? 0x86 : 0x85, 0, LO(first), LO(second));
        } else if (!RESULT_SETS_FLAGS(node)) {
            first = GENERATE_EXPRESSION(node, 1);
            u16 value = constant(word ? 10 : 9, 0);
            NEW_CODE_NODE(word ? 0x81 : 0x80, 0, LO(first), value);
        } else
            GENERATE_EXPRESSION(node, 1);
        break;
    }
    case 9: case 10: case 11:
        first = GENERATE_EXPRESSION(node, 1);
        GEN_FPU_COMPARE(LO(first), NEW_CODE_NODE(0x8A, 0, 0, 0));
        break;
    }
}

/* the segment register a pointer of segment kind value (from the type flags) is relative
   to: 1 ES (12), 2 CS (14), 3 SS (15), 4 DS (13), else FFh */
i8 SEGMENT_REGISTER_CODE(u16 value)
{
    switch (value) {
    case 2: return 0x0E;
    case 4: return 0x0D;
    case 1: return 0x0C;
    case 3: return 0x0F;
    default: return (i8)0xFF;
    }
}

/* generates the operands left and right of comparison node: the one that needs more
   registers first (the right one when the node's need byte is not negative) */
static void generate_pair(u16 node, u16 left, u16 right, u32 *first, u32 *second)
{
    if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0) {
        *first = GENERATE_EXPRESSION(left, 1);
        *second = GENERATE_EXPRESSION(right, 1);
    } else {
        *second = GENERATE_EXPRESSION(right, 1);
        *first = GENERATE_EXPRESSION(left, 1);
    }
}

static int is_zero_constant(u16 node)
{
    return OP(node) == EOP_CONST && EXPR_UL(node, EXPR_LEFT) == 0;
}

/* ends the current block with: if comparison node holds, jump to block target.  Operands
   are swapped (and the operator mirrored) so an immediate ends up on the right.  32-bit
   comparisons compare the high words first in their own block (with CNODE_FLAGS 8 so live
   values flow on) and jump or fall to a low-word comparison done unsigned; a test against
   0 uses EMIT_TEST_ZERO; (_FLAGS & bit) ==/!= 0 becomes a direct jump on that flag;
   floating comparisons use GEN_FPU_COMPARE; huge pointers are compared by a helper
   (STR_PCMP) */
void EMIT_COMPARE(u16 node, u16 target)
{
    u32 first, second;
    node = LABEL_REGISTER_NEED(node);
    u16 kind = OP(node);
    u16 left = LEFT(node), right = RIGHT(node);
    if (!IS_IMMEDIATE_OPERAND(right) &&
        (IS_IMMEDIATE_OPERAND(left) || (EXPR_SC(node, EXPR_NODE_FLAGS) > 0 && OP(left) != 4))) {
        u16 swap = left;
        left = right;
        right = swap;
        kind = MIRROR_COMPARE_OP(kind);
        EXPR_SC(node, EXPR_NODE_FLAGS) = (i8)-EXPR_SC(node, EXPR_NODE_FLAGS);
    }
    u16 original = kind;
    i16 type = (i16)KIND(left);
    kind = (u16)COMPARE_OP_TO_JUMP(kind, type);
    u16 saved = CURRENT_CODE_BLOCK;
    switch (KIND(left)) {
    case 7: case 8: case 15: {
        if (OP(right) == EOP_CONST && (kind == 10 || kind == 11) && EXPR_UL(right, EXPR_LEFT) == 0) {
            EMIT_TEST_ZERO(left);
            break;
        }
        generate_pair(node, left, right, &first, &second);
        u16 temp = NEW_LABEL();
        NEW_CODE_NODE(0x81, 0, HI(first), HI(second));
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_FLAGS) |= 8;
        u16 newnode;
        switch (original) {
        case 0x1F: case 0x20:
            SET_BLOCK_JUMP(kind, target);
            newnode = NEW_BLOCK();
            CURRENT_CODE_BLOCK = newnode;
            SET_BLOCK_JUMP(11, temp);
            JOIN_BLOCK_CHAINS(saved, newnode);
            break;
        case 0x1D:
            SET_BLOCK_JUMP(11, temp);
            break;
        case 0x1E:
            SET_BLOCK_JUMP(kind, target);
            break;
        case 0x22:
            SET_BLOCK_JUMP((u16)COMPARE_OP_TO_JUMP(0x20, type), target);
            newnode = NEW_BLOCK();
            CURRENT_CODE_BLOCK = newnode;
            SET_BLOCK_JUMP((u16)COMPARE_OP_TO_JUMP(0x1F, type), temp);
            JOIN_BLOCK_CHAINS(saved, newnode);
            break;
        case 0x21:
            SET_BLOCK_JUMP((u16)COMPARE_OP_TO_JUMP(0x1F, type), target);
            newnode = NEW_BLOCK();
            CURRENT_CODE_BLOCK = newnode;
            SET_BLOCK_JUMP((u16)COMPARE_OP_TO_JUMP(0x20, type), temp);
            JOIN_BLOCK_CHAINS(saved, newnode);
            break;
        }
        newnode = NEW_BLOCK();
        CURRENT_CODE_BLOCK = newnode;
        NEW_CODE_NODE(0x81, 0, LO(first), LO(second));
        SET_BLOCK_JUMP((u16)COMPARE_OP_TO_JUMP(original, 6), target);
        JOIN_BLOCK_CHAINS(newnode, temp);
        JOIN_BLOCK_CHAINS(saved, newnode);
        return;
    }
    case 3: case 4: case 5: case 6: case 13: case 14:
        if (is_zero_constant(right)) {
            if (OP(left) == 15 && OP(LEFT(left)) == 4 && RIGHT(LEFT(left)) == 0xFFFF)
                kind = FLAGS_BIT_TEST_JUMP_KIND(kind, left);
            else
                EMIT_TEST_ZERO(left);
            break;
        }
        generate_pair(node, left, right, &first, &second);
        NEW_CODE_NODE(0x81, 0, LO(first), LO(second));
        break;
    case 1: case 2:
        if (is_zero_constant(right)) {
            EMIT_TEST_ZERO(left);
            break;
        }
        generate_pair(node, left, right, &first, &second);
        NEW_CODE_NODE(0x80, 0, LO(first), LO(second));
        break;
    case 9: case 10: case 11: {
        u16 a = (u16)GENERATE_EXPRESSION(left, 1);
        u16 b = (u16)GENERATE_EXPRESSION(right, 1);
        GEN_FPU_COMPARE(a, b);
        break;
    }
    case 16: {
        i16 need_left = EXPR_SC(left, EXPR_NODE_FLAGS), need_right = EXPR_SC(right, EXPR_NODE_FLAGS);
        if ((need_left < 0 ? -need_left : need_left) > (need_right < 0 ? -need_right : need_right)) {
            first = GENERATE_EXPRESSION(left, 1);
            second = GENERATE_EXPRESSION(right, 1);
            NEW_CODE_NODE(0xB5, 0, LO(first), HI(first));
            NEW_CODE_NODE(0xB6, 0, LO(second), HI(second));
        } else {
            second = GENERATE_EXPRESSION(right, 1);
            first = GENERATE_EXPRESSION(left, 1);
            NEW_CODE_NODE(0xB6, 0, LO(second), HI(second));
            NEW_CODE_NODE(0xB5, 0, LO(first), HI(first));
        }
        EMIT_HELPER_CALL(FP_OFF(STR_PCMP_P), 0x55);
        break;
    }
    }
    u16 block = CURRENT_CODE_BLOCK;
    close_ops(block);
    CNODE_W(block, CNODE_JUMP_KIND) = kind;
    CNODE_W(block, CNODE_TARGET) = target;
}

/* closes CURRENT_CODE_BLOCK's op run with jump kind kind to block target; returns the
   block */
u16 SET_BLOCK_JUMP(u16 kind, u16 target)
{
    u16 block = CURRENT_CODE_BLOCK;
    close_ops(block);
    CNODE_W(block, CNODE_JUMP_KIND) = kind;
    CNODE_W(block, CNODE_TARGET) = target;
    return CURRENT_CODE_BLOCK;
}

/* for (_FLAGS & mask) == 0 or != 0 (mode 10 or 11) with a one-bit mask of a CPU flag
   (carry, parity, zero, sign or overflow), the jump kind that tests that flag directly;
   otherwise EMIT_TEST_ZERO and mode */
u16 FLAGS_BIT_TEST_JUMP_KIND(u16 mode, u16 node)
{
    if (mode == 10 || mode == 11) {
        u16 child = RIGHT(node);
        if (OP(child) == EOP_CONST) {
            i16 value = LOG2_POWER_OF_TWO(EXPR_UL(child, EXPR_LEFT));
            switch (value) {
            case 0: return mode == 10 ? 13 : 12;
            case 2: return mode == 10 ? 19 : 18;
            case 6: return mode == 10 ? 11 : 10;
            case 7: return mode == 10 ? 17 : 16;
            case 11: return mode == 10 ? 15 : 14;
            }
        }
    }
    EMIT_TEST_ZERO(node);
    return mode;
}

/* non-zero when the instruction that computes signed or plain node node already leaves
   the zero flag matching its result, so no compare with 0 is needed: add or subtract (by
   1 as INC/DEC, 4), or, xor, the in-place forms (3 for += 1 and -= 1).  0 for unsigned
   kinds (EXPR_FLAGS 20h) */
u16 RESULT_SETS_FLAGS(u16 node)
{
    if (EXPR_FLAGS_AT(KIND(node)) & 0x20)
        return 0;
    u16 right;
    switch (OP(node)) {
    case 8:
    case 9:
        right = RIGHT(node);
        if (OP(right) == EOP_CONST && RIGHT(right) == 0 && LEFT(right) == 1)
            return 4;
        /* fall through */
    case 0x10:
    case 0x11:
        return 2;
    case 0x13:
    case 0x14:
        right = RIGHT(node);
        if (OP(right) == EOP_CONST && RIGHT(right) == 0 && LEFT(right) == 1)
            return 3;
        /* fall through */
    case 0x1A:
    case 0x1B:
    case 0x1C:
        return 1;
    }
    return 0;
}

/* looking through casts, 1 for a constant, 3 for the address of a symbol, else 0 */
i16 IS_IMMEDIATE_OPERAND(u16 value)
{
    while (OP(value) == 0x35)
        value = LEFT(value);
    if (OP(value) == EOP_CONST)
        return 1;
    if (OP(value) != EOP_ADDR)
        return 0;
    if (OP(LEFT(value)) == 1)
        return 3;
    return 0;
}

/* the jump kind for comparison operator index on value kind kind: from the table at
   DS:5268 for signed kinds (char, short, int, long, enum), else from DS:5262 (unsigned
   comparisons) */
i16 COMPARE_OP_TO_JUMP(u16 index, i16 kind)
{
    u16 table = FP_OFF(OPERATOR_HELPER_NAME_TABLE_P);
    switch (kind) {
    case 1: case 3: case 5: case 7: case 21:
        return SB(DSPTR(table + 51 + index));
    default:
        return SB(DSPTR(table + 45 + index));
    }
}

/* called when the function's outer scope opens.  Notes in ASM_OUTPUT_FLAGS bit 8 whether
   the code segment has the default name (STR_TEXT), which decides near or far helper
   calls.  With the stack check option (not for Windows or interrupt functions) it appends
   blocks that compare SP with the stack limit variable (_stklen or __brklvl, a far one in
   the huge model; for frames over 200 bytes BP is compared with SP first) and call the
   overflow helper (STR_OVERFLOW) when the stack is too low */
void EMIT_STACK_CHECK(void)
{
    u16 code_segment = FIND_SEGMENT(FUNCTION_CODE_SEGMENT);
    if (!COMPARE_NAME(MK_FP(W(STRING_POOL_SEG_P), SEGDEF_W(code_segment, SEGDEF_NAME)), STR_TEXT_P))
        ASM_OUTPUT_FLAGS |= 8;
    if (SB(OPTION_WINDOWS_MODE_P))
        return;
    if (OPTION_STACK_CHECK == 0)
        return;
    if (CODEGEN_CALL_CONV == 4)
        return;
    u16 done_label = NEW_LABEL();
    u16 overflow_label = 0, check_block, operand_node, limit_node, condition, limit_symbol;
    if (FRAME_LOCALS_SIZE > 200) {
        overflow_label = NEW_LABEL();
        check_block = NEW_BLOCK();
        CURRENT_CODE_BLOCK = check_block;
        u16 bp = NEW_CODE_NODE(8, 0, 10, 0);
        operand_node = NEW_CODE_NODE(8, 0, 11, 0);
        NEW_CODE_NODE(0x81, 0, bp, operand_node);
        SET_BLOCK_JUMP(5, overflow_label);
        APPEND_BLOCK_CHAIN(FUNCTION_SERIAL, check_block, 1);
    }
    check_block = NEW_BLOCK();
    CURRENT_CODE_BLOCK = check_block;
    if (B(OPTION_MEMORY_MODEL_P) != 5) {
        u8 model = B(OPTION_MEMORY_MODEL_P);
        if (model == 4 || model == 3 || OPTION_DS_NOT_SS) {
            condition = 5;
            limit_symbol = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(STR_STKLEN_2_P)), A16(0));
        } else {
            condition = 4;
            limit_symbol = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(STR_BRKLVL_P)), A16(0));
        }
        limit_node = NEW_VARIABLE_NODE(0x10, limit_symbol, 0, 0);
    } else {
        limit_symbol = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(STR_STKLEN_2_P)), A16(0));
        limit_node = NEW_VARIABLE_NODE(13, limit_symbol, 0, 0x10);
        operand_node = NEW_VARIABLE_NODE(12, limit_symbol, 0, 0x10);
        limit_node = NEW_CODE_NODE(0x16, 0, limit_node, operand_node);
        condition = 5;
    }
    operand_node = NEW_CODE_NODE(8, 0, 11, 0);
    NEW_CODE_NODE(0x81, 0, limit_node, operand_node);
    SET_BLOCK_JUMP(condition, done_label);
    APPEND_BLOCK_CHAIN(FUNCTION_SERIAL, check_block, 1);
    if (FRAME_LOCALS_SIZE > 200)
        APPEND_BLOCK_CHAIN(FUNCTION_SERIAL, overflow_label, 1);
    u16 call_block = NEW_BLOCK();
    EMIT_HELPER_CALL(FP_OFF(STR_OVERFLOW_P), 0);
    close_ops(call_block);
    APPEND_BLOCK_CHAIN(FUNCTION_SERIAL, call_block, 1);
    APPEND_BLOCK_CHAIN(FUNCTION_SERIAL, done_label, 1);
}

/* pushes struct argument node: a struct of 1, 2 or 4 bytes is turned into an integer and
   1 is returned so the caller pushes it as such; otherwise its address goes to DX:AX, its
   even size to CX, the helper STR_SPUSH copies it onto the stack (the stack grows by the
   size, op AEh with -size) and 0 is returned */
u16 PUSH_STRUCT_VALUE(u16 node)
{
    u16 size = size_of_type(EXPR_W(node, EXPR_TYPE));
    if (size == 4 || size == 2 || size == 1) {
        NARROW_STRUCT_TO_SCALAR(node);
        return 1;
    }
    u32 value = GENERATE_EXPRESSION(node, 1);
    NEW_CODE_NODE(0xB5, 0, LO(value), HI(value));
    if (size & 1)
        size++;
    NEW_CODE_NODE(0xB6, 0, 0, constant(10, size));
    EMIT_HELPER_CALL(FP_OFF(STR_SPUSH_P), 0x1050);
    constant(0xAE, (u16)-size);
    return 0;
}

/* struct assignment node: pushes the far addresses of the target and the source, puts
   the size in CX and calls STR_SCOPY (which pops 8 bytes); the value of the assignment,
   when mode wants it, is the target generated again */
u32 GENERATE_STRUCT_ASSIGN(u16 node, u16 mode)
{
    u16 left = LEFT(node);
    u16 right = RIGHT(node);
    u16 size = size_of_type(EXPR_W(left, EXPR_TYPE));
    constant(6, 0x1055);
    u32 first = GENERATE_EXPRESSION(left, 1);
    NEW_CODE_NODE(0x94, 0, HI(first), 0);
    NEW_CODE_NODE(0x94, 0, LO(first), 0);
    u32 second = GENERATE_EXPRESSION(right, 1);
    NEW_CODE_NODE(0x94, 0, HI(second), 0);
    NEW_CODE_NODE(0x94, 0, LO(second), 0);
    NEW_CODE_NODE(0xB6, 0, 0, constant(10, size));
    EMIT_HELPER_CALL(FP_OFF(STR_SCOPY_P), 0x1040);
    constant(0xAE, 8);
    if (mode)
        return GENERATE_EXPRESSION(left, mode);
    return 0;
}

/* retypes struct node node of 1, 2 or 4 bytes as unsigned char, unsigned int or unsigned
   long, and does the same through struct assignments (op 34h becomes plain assignment
   12h) to both sides */
void NARROW_STRUCT_TO_SCALAR(u16 node)
{
    u16 size = size_of_type(EXPR_W(node, EXPR_TYPE));
    u8 kind;
    if (size == 1)
        kind = 2;
    else if (size == 2)
        kind = 6;
    else if (size == 4)
        kind = 8;
    else
        return;
    u16 type = (u16)CALL_FAR(MODE_HOOK, A16(kind));
    EXPR_W(node, EXPR_TYPE) = type;
    KIND(node) = kind;
    if (OP(node) == 0x34)
        OP(node) = 0x12;
    if (OP(node) == 0x12) {
        NARROW_STRUCT_TO_SCALAR(LEFT(node));
        NARROW_STRUCT_TO_SCALAR(RIGHT(node));
    }
}

/* a call op of the run-time helper text with the name prefix for near calls (STR_N, tiny
   model or default code segment) or far calls (STR_F); value goes into the call op's right
   operand (probably the registers the helper destroys).  The name is built in a 32-byte
   buffer on BCC's stack, which is in DGROUP (SS is DS), and handed on as a near pointer,
   so the port builds it in the near scratch area */
void EMIT_HELPER_CALL(u16 text, u16 value)
{
    u16 mark = near_scratch_mark();
    farptr buffer = near_scratch_alloc(0x20);
    if (B(OPTION_MEMORY_MODEL_P) == 0 || (ASM_OUTPUT_FLAGS & 8) != 0)
        STRING_COPY(buffer, STR_N_P);
    else
        STRING_COPY(buffer, STR_F_P);
    STRING_APPEND(buffer, DSPTR(text));
    u16 name = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(buffer)), A16(1));
    NEW_VARIABLE_NODE((ASM_OUTPUT_FLAGS & 8) ? 0x77 : 0x78, name, value, 0x10);
    near_scratch_release(mark);
}

/* calls the helper for operator node value from OPERATOR_HELPER_NAME_TABLE, indexed by
   operator*4 + value kind*2 bytes */
void EMIT_OPERATOR_HELPER(u16 value)
{
    u16 offset = (u16)(OP(value) * 4 + KIND(value) * 2);
    EMIT_HELPER_CALL(W(DSPTR(FP_OFF(OPERATOR_HELPER_NAME_TABLE_P) + offset)), 0x55);
}

/* *(&node + amount) read as the type of first.  When node is 3 bytes or more than 4 the
   address is formed and read normally.  Otherwise the value is generated and the wanted
   part taken from its registers, assuming it sits in DX:AX (probably a small struct
   returned by a function): byte amount as register AL, AH, DL or DH (register ops 7 with
   0-3), the high word, or the middle two bytes moved into AX */
u32 GENERATE_DEREF_OF_ADDRESS(u16 first, u16 node, u16 amount)
{
    u16 type = size_of_type(EXPR_W(node, EXPR_TYPE));
    u32 result = GENERATE_EXPRESSION(node, 1);
    u16 low = LO(result), high = HI(result);
    if (type == 3 || type > 4) {
        if (amount)
            low = NEW_CODE_NODE(0x1F, 0, low, constant(10, amount));
        return GENERATE_INDIRECT_LOAD(first, high, low);
    }
    switch (KIND(first)) {
    case 3: case 4: case 5: case 6: case 13: case 14:
        switch (amount) {
        case 1: {
            u16 a = NEW_CODE_NODE(8, 0, 0, 0);
            u16 b = NEW_CODE_NODE(8, 0, 1, 0);
            NEW_CODE_NODE(0x9B, 2, a, b);
            a = NEW_CODE_NODE(8, 0, 1, 0);
            b = NEW_CODE_NODE(8, 0, 2, 0);
            NEW_CODE_NODE(0x9B, 2, a, b);
            low = constant(0xC2, 0);
            break;
        }
        case 2:
            low = high;
            break;
        }
        high = 0;
        break;
    case 1: case 2:
        if (amount <= 3)
            low = NEW_CODE_NODE(7, 0, amount, 0);
        high = 0;
        break;
    }
    return PAIR(low, high);
}

/* x-- (decrement) or x++ (increment, inc set): the result is a copy of the old value
   (97h+, 98h, 99h), then the variable is changed in place by the right operand (ADD/ADC
   or SUB/SBB for longs; for huge pointers inline with __AHSHIFT or through the helpers
   STR_PDEA/STR_PINA) */
static u32 generate_post_inc_dec(u16 node, int inc)
{
    u32 first = GENERATE_EXPRESSION(LEFT(node), 1);
    u32 second = GENERATE_EXPRESSION(RIGHT(node), 1);
    u16 low = 0, high = 0;
    switch (KIND(node)) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        /* fall through */
    case 1: case 2: case 3: case 4: case 5: case 6: case 13:
        low = NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET_AT(KIND(node)) + 0x97, 0, LO(first), 0);
        high = 0;
        NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, LO(first), LO(second));
        break;
    case 7: case 8:
        low = NEW_CODE_NODE(0x98, 0, LO(first), 0);
        high = NEW_CODE_NODE(0x99, 0, HI(first), 0);
        NEW_CODE_NODE(inc ? 0x1D : 0x26, 0x12, LO(first), LO(second));
        NEW_CODE_NODE(inc ? 0x24 : 0x30, 0x22, HI(first), HI(second));
        break;
    case 15:
        high = HI(first);
        low = NEW_CODE_NODE(0x98, 0, LO(first), 0);
        NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, LO(first), LO(second));
        break;
    case 16:
        if (HUGE_PTR_AHSHIFT_MODE) {
            low = NEW_CODE_NODE(0x99, 0, LO(first), 0);
            high = NEW_CODE_NODE(0x99, 0, HI(first), 0);
            u16 temp1 = constant(10, 0);
            u16 symbol = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(STR_AHSHIFT_P)), A16(1));
            u16 temp2 = NEW_VARIABLE_NODE(13, symbol, 0, 0x10);
            NEW_CODE_NODE(OP(node) == EOP_POSTINC ? 0x1D : 0x26, 0x12, LO(first), LO(second));
            u16 carry = NEW_CODE_NODE(0x24, 0x20, temp1, HI(second));
            carry = NEW_CODE_NODE(0x45, 0, carry, temp2);
            NEW_CODE_NODE(inc ? 0x1F : 0x28, 2, HI(first), carry);
        } else {
            first = GENERATE_ADDRESS_OF(LEFT(node), 15);
            constant(6, 0x40);
            NEW_CODE_NODE(0xBE, 0, LO(first), HI(first));
            NEW_CODE_NODE(0xB5, 0, LO(second), HI(second));
            EMIT_HELPER_CALL(OP(node) == EOP_POSTDEC ? FP_OFF(STR_PDEA_P) : FP_OFF(STR_PINA_P), 0x1055);
            low = constant(0xC2, 0);
            high = constant(0xC3, 0);
        }
    }
    return PAIR(low, high);
}

/* x-- (and huge-pointer x++ through the shared code) */
u32 GENERATE_POST_DECREMENT(u16 node)
{
    return generate_post_inc_dec(node, 0);
}

/* x++, the same with ADD/ADC */
u32 GENERATE_POST_INCREMENT(u16 node)
{
    return generate_post_inc_dec(node, 1);
}

/* the address of object node as a pointer of kind mode (13 near: the offset only, 14 _seg:
   the segment only, 15/16 far and huge: both).  &*p is just p.  The segment is that of the
   symbol (op 12) for a global, else SS (register 15); for expression op 7 the offset is
   the parameter area (op 14).  For a near address of op 7 the original returns a high
   word it never set (a register left from the caller), which replay does not compare */
u32 GENERATE_ADDRESS_OF(u16 node, u8 mode)
{
    if (OP(node) == EOP_DEREF)
        return GENERATE_EXPRESSION(LEFT(node), 1);
    u16 segment = 0, other = 0;
    if (mode != 0x0D)
        segment = OP(node) == 1 ? NEW_VARIABLE_NODE(12, LEFT(node), RIGHT(node), EXPR_B(node, EXPR_QUAL_FLAGS))
                                : NEW_CODE_NODE(8, 0, 15, 0);
    if (OP(node) == 7) {
        u16 low = constant(14, 0);
        if (mode == 0x0D)
            UNSET_RETURN(1u << R_DX);
        return PAIR(low, segment);
    }
    if (mode != 0x0E)
        other = NEW_VARIABLE_NODE(13, LEFT(node), RIGHT(node), EXPR_B(node, EXPR_QUAL_FLAGS));
    switch (mode) {
    case 14: return PAIR(segment, 0);
    case 15:
    case 16: return PAIR(other, segment);
    case 13: return PAIR(other, 0);
    }
    UNSET_RETURN(1u << R_AX | 1u << R_DX);
    return 0;
}

/* for a dereference node through a near pointer whose type names a segment (type flags 1
   ES, 2 CS, 3 SS), a register op for that segment register; else 0 (the default DS) */
u16 DEFAULT_SEGMENT_NODE(u16 node)
{
    if (KIND(LEFT(node)) == 13) {
        u16 kind = (u16)CALL_FAR(GET_TYPE_FLAGS_ALT_HOOK, A16(EXPR_W(LEFT(node), EXPR_TYPE)));
        switch (kind) {
        case 2: return NEW_CODE_NODE(8, 0, 14, 0);
        case 3: return NEW_CODE_NODE(8, 0, 15, 0);
        case 1: return NEW_CODE_NODE(8, 0, 12, 0);
        }
    }
    return 0;
}

/* reads the object node points to, given the address as offset op low and segment op high
   (0 for the default): one indirect op of the node's kind, or two (16h low word, 1Bh high
   word) for 32-bit values; a struct or union result is the address itself (with the
   segment its near pointer type implies, or offset 0 for a _seg pointer) */
u32 GENERATE_INDIRECT_LOAD(u16 node, u16 high, u16 low)
{
    switch (KIND(node)) {
    default:
        if (!high)
            high = DEFAULT_SEGMENT_NODE(node);
        return PAIR(NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0, low, high), 0);
    case 7: case 8: case 15: case 16: {
        if (!high)
            high = DEFAULT_SEGMENT_NODE(node);
        u16 result_high = NEW_CODE_NODE(0x1B, 0, low, high);
        u16 result_low = NEW_CODE_NODE(0x16, 0, low, high);
        return PAIR(result_low, result_high);
    }
    case 19: case 20: {
        u16 pointer = LEFT(node);
        if (KIND(pointer) == 13) {
            u16 flags = (u16)CALL_FAR(GET_TYPE_FLAGS_ALT_HOOK, A16(EXPR_W(pointer, EXPR_TYPE)));
            u16 reg = (u16)(i16)SEGMENT_REGISTER_CODE(flags);
            return PAIR(low, NEW_CODE_NODE(8, 0, reg, 0));
        }
        if (KIND(pointer) == 14)
            return PAIR(constant(10, 0), low);
        return PAIR(low, high);
    }
    }
}

/* for *(p += n) or *(p -= n) with a far pointer p, adds in place and returns a copy of
   p's new value as the address; returns low word 0 when node is not that shape (the high
   word is then left unset, as in the original, and not compared) */
u32 GEN_DEREF_FAR_ADD_ASSIGN(u16 node)
{
    if (KIND(node) != 15 || (OP(node) != 0x13 && OP(node) != 0x14)) {
        UNSET_RETURN(1u << R_DX);
        return 0;
    }
    u32 right = GENERATE_EXPRESSION(RIGHT(node), 1);
    u32 left = GENERATE_EXPRESSION(LEFT(node), 1);
    NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, LO(left), LO(right));
    u16 high = NEW_CODE_NODE(0x98, 0, HI(left), 0);
    u16 low = NEW_CODE_NODE(0x99, 0, LO(left), 0);
    return PAIR(low, high);
}

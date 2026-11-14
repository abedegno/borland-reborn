/* crossjmp.c: from bcc20/src/codegen/CROSSJMP.C: the cross-jumping pass, run after
   register allocation when optimising.  When several code blocks continue at the same place
   (by falling through or by an unconditional jump) and end with the same instructions,
   those instructions are kept once: one block keeps them in a new block of its own and the
   others are cut short and jump to it.  Each flow block's CNODE_PRED_LIST heads a list,
   linked through CNODE_PRED_NEXT, of the code blocks that reach it this way.  Two ops are
   equal when opcode, COP_FLAGS, register and operands match; because registers are already
   assigned, the register history entries attached to the ops must match too.  Table flags:
   1 variable leaf, 8 constant, 20h raw operand word.  The pass repeats while
   CROSS_JUMP_CHANGED says a block was emptied. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "explain.h"

#define OP_FLAGS(op) D(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))
#define OPTION_OPTIMIZE_SPEED B(OPTION_OPTIMIZE_SPEED_P)

/* true when code ops left and right (op numbers, 0 for none) compute the same operand.  Ops
   not folded into their parent (COP_FLAGS 1 clear) are equal when they sit in the same
   register.  Folded ops must have the same opcode, flags and register, then: variable leaves
   name the same variable and offset, or register variables in the same register; constants
   have the same long value; raw-word ops the same word; other ops have equal operand trees */
i16 OPERAND_TREES_EQUAL(u16 left, u16 right)
{
    if (left == 0)
        return right == 0;
    if (right == 0)
        return 0;
    u16 lpos = left << 2, rpos = right << 2;
    if ((COP_B(lpos, COP_FLAGS) & 1) == 0 && (COP_B(rpos, COP_FLAGS) & 1) == 0)
        return COP_B(lpos, COP_REGISTER) == COP_B(rpos, COP_REGISTER);
    if (COP_B(lpos, COP_OPCODE) != COP_B(rpos, COP_OPCODE) || COP_B(lpos, COP_FLAGS) != COP_B(rpos, COP_FLAGS)
        || COP_B(lpos, COP_REGISTER) != COP_B(rpos, COP_REGISTER))
        return 0;
    u32 flags = OP_FLAGS(COP_B(lpos, COP_OPCODE));
    if (flags & 1) {
        u16 first = OPND_W(lpos, OPND_LEFT), second = OPND_W(rpos, OPND_LEFT);
        if ((VAR_B(first, VAR_FLAGS) & 2) && (VAR_B(second, VAR_FLAGS) & 2))
            return VAR_B(first, VAR_REGISTER) == VAR_B(second, VAR_REGISTER);
        return first == second && OPND_W(lpos, OPND_RIGHT) == OPND_W(rpos, OPND_RIGHT);
    }
    if (flags & 8)
        return OPND_L(lpos, OPND_LEFT) == OPND_L(rpos, OPND_LEFT);
    if (flags & 0x20)
        return OPND_W(lpos, OPND_LEFT) == OPND_W(rpos, OPND_LEFT);
    return OPERAND_TREES_EQUAL(OPND_W(lpos, OPND_LEFT), OPND_W(rpos, OPND_LEFT))
           && OPERAND_TREES_EQUAL(OPND_W(lpos, OPND_RIGHT), OPND_W(rpos, OPND_RIGHT));
}

/* the number of register history entries of block value: those from its CNODE_HISTORY on
   whose op number lies in the block's op range */
u16 COUNT_BLOCK_HISTORY_ENTRIES(u16 value)
{
    u16 first = CNODE_W(value, CNODE_FIRST_OP);
    u16 end = (u16)(first + CNODE_W(value, CNODE_OP_COUNT) - 1);
    u16 count = 0;
    for (u16 entry = CNODE_W(value, CNODE_HISTORY);
         entry < HISTORY_END_OFFSET && RHIST_W(entry, RHIST_INSN_INDEX) >= first && RHIST_W(entry, RHIST_INSN_INDEX) <= end;
         entry += 9)
        ++count;
    return count;
}

/* the op at the current position of each block is the same op (see OPERAND_TREES_EQUAL,
   but compared here at the top level) */
static u8 same_op(u16 position1, u16 position2)
{
    if (COP_B(position1, COP_OPCODE) != COP_B(position2, COP_OPCODE) || COP_B(position1, COP_FLAGS) != COP_B(position2, COP_FLAGS)
        || COP_B(position1, COP_REGISTER) != COP_B(position2, COP_REGISTER))
        return 0;
    u32 flags = OP_FLAGS(COP_B(position1, COP_OPCODE));
    if (flags & 1) {
        u16 symbol1 = OPND_W(position1, OPND_VARIABLE), symbol2 = OPND_W(position2, OPND_VARIABLE);
        if ((VAR_B(symbol1, VAR_FLAGS) & 2) && (VAR_B(symbol2, VAR_FLAGS) & 2))
            return VAR_B(symbol1, VAR_REGISTER) == VAR_B(symbol2, VAR_REGISTER);
        return symbol1 == symbol2 && OPND_W(position1, OPND_RIGHT) == OPND_W(position2, OPND_RIGHT);
    }
    if (flags & 8)
        return D(MK_FP(CODE_OPERAND_POOL_SEG, position1 + OPND_CONST_VALUE)) == D(MK_FP(CODE_OPERAND_POOL_SEG, position2 + OPND_CONST_VALUE));
    if (flags & 32)
        return OPND_W(position1, OPND_LEFT) == OPND_W(position2, OPND_LEFT);
    return OPERAND_TREES_EQUAL(OPND_W(position1, OPND_LEFT), OPND_W(position2, OPND_LEFT))
           && OPERAND_TREES_EQUAL(OPND_W(position1, OPND_RIGHT), OPND_W(position2, OPND_RIGHT));
}

/* compares blocks left and right backwards from their last ops (skipping dead ops,
   COP_FLAGS 40h) and their history entries backwards in step.  If at least one op matches,
   the matching tail of right is moved into a new block placed after right (taking over
   right's closing jump), right now falls into it, left is shortened by the same ops and
   jumps to it.  The new block gets CNODE_FLAGS 10h and its history starts at the first
   entry of its ops.  Returns the new block, or right when nothing matched */
u16 SPLIT_COMMON_TAIL(u16 left, u16 right)
{
    u16 count1 = CNODE_W(left, CNODE_OP_COUNT), count2 = CNODE_W(right, CNODE_OP_COUNT);
    u16 position1 = (u16)((CNODE_W(left, CNODE_FIRST_OP) + count1 - 1) * 4);
    u16 position2 = (u16)((CNODE_W(right, CNODE_FIRST_OP) + count2 - 1) * 4);
    u16 remaining1 = COUNT_BLOCK_HISTORY_ENTRIES(left);
    u16 remaining2 = COUNT_BLOCK_HISTORY_ENTRIES(right);
    u16 history1 = (u16)(CNODE_W(left, CNODE_HISTORY) + remaining1 * 9 - 9);
    u16 history2 = (u16)(CNODE_W(right, CNODE_HISTORY) + remaining2 * 9 - 9);
    u8 changed = 0;
    while (count1 != 0 && count2 != 0) {
        if (COP_B(position1, COP_FLAGS) & 0x40) {
            position1 -= 4;
            count1--;
            continue;
        }
        if (COP_B(position2, COP_FLAGS) & 0x40) {
            position2 -= 4;
            count2--;
            continue;
        }
        if (!same_op(position1, position2))
            break;
        u8 equal = 1;
        for (;;) {
            u8 more1 = remaining1 != 0 && RHIST_W(history1, RHIST_INSN_INDEX) == (u16)(CNODE_W(left, CNODE_FIRST_OP) + count1 - 1);
            u8 more2 = remaining2 != 0 && RHIST_W(history2, RHIST_INSN_INDEX) == (u16)(CNODE_W(right, CNODE_FIRST_OP) + count2 - 1);
            if (!more1) {
                equal = !more2;
                break;
            }
            if (!more2) {
                equal = 0;
                break;
            }
            if (RHIST_B(history1, RHIST_ACTION) != RHIST_B(history2, RHIST_ACTION) || RHIST_B(history1, RHIST_IS_WORD) != RHIST_B(history2, RHIST_IS_WORD)
                || RHIST_B(history1, RHIST_REGISTER) != RHIST_B(history2, RHIST_REGISTER)
                || COP_B(RHIST_W(history1, RHIST_VALUE_OP) << 2, COP_REGISTER) != COP_B(RHIST_W(history2, RHIST_VALUE_OP) << 2, COP_REGISTER)) {
                equal = 0;
                break;
            }
            history1 -= 9;
            history2 -= 9;
            remaining1--;
            remaining2--;
        }
        if (!equal)
            break;
        count1--;
        position1 -= 4;
        count2--;
        position2 -= 4;
        changed = 1;
    }
    if (!changed)
        return right;
    u16 result = NEW_BLOCK();
    CNODE_W(result, CNODE_KIND) = 0;
    CNODE_W(result, CNODE_JUMP_KIND) = CNODE_W(right, CNODE_JUMP_KIND);
    CNODE_W(result, CNODE_TARGET) = CNODE_W(right, CNODE_TARGET);
    CNODE_W(right, CNODE_JUMP_KIND) = 0;
    CNODE_W(right, CNODE_TARGET) = 0;
    CNODE_W(result, CNODE_OP_COUNT) = (u16)(CNODE_W(right, CNODE_OP_COUNT) - count2);
    CNODE_W(result, CNODE_FIRST_OP) = (u16)(CNODE_W(right, CNODE_FIRST_OP) + count2);
    CNODE_W(right, CNODE_OP_COUNT) = count2;
    CNODE_W(left, CNODE_OP_COUNT) = count1;
    CNODE_W(result, CNODE_NEXT) = CNODE_W(right, CNODE_NEXT);
    history2 = CNODE_W(right, CNODE_HISTORY);
    while (history2 < HISTORY_END_OFFSET && RHIST_W(history2, RHIST_INSN_INDEX) != 0
           && RHIST_W(history2, RHIST_INSN_INDEX) < CNODE_W(result, CNODE_FIRST_OP))
        history2 += 9;
    CNODE_W(result, CNODE_HISTORY) = history2;
    CNODE_W(right, CNODE_NEXT) = result;
    CNODE_W(CNODE_W(result, CNODE_NEXT), CNODE_PREV) = result;
    CNODE_W(result, CNODE_PREV) = right;
    CNODE_W(left, CNODE_TARGET) = result;
    CNODE_W(result, CNODE_FLAGS) = 16;
    if (count1 == 0 || count2 == 0)
        CROSS_JUMP_CHANGED = 1;
    EXPLAIN("crossjump merged=%u ops left_block=%u right_block=%u tail_block=%u",
            CNODE_W(result, CNODE_OP_COUNT), left, right, result);
    return result;
}

/* where code block node really continues, skipping scope blocks and empty blocks and
   following empty jump blocks; *jumps is cleared when it is reached by a jump */
static u16 continuation(u16 target, u8 *falls)
{
    while (CNODE_W(target, CNODE_NEXT) != 0) {
        u16 kind = CNODE_W(target, CNODE_KIND);
        if (kind == 1 || kind == 2) {
            target = CNODE_W(target, CNODE_NEXT);
            continue;
        }
        if (kind != 0 || CNODE_W(target, CNODE_OP_COUNT) != 0)
            break;
        if (CNODE_W(target, CNODE_JUMP_KIND) == 0) {
            target = CNODE_W(target, CNODE_NEXT);
            continue;
        }
        if (CNODE_W(target, CNODE_JUMP_KIND) == 1) {
            target = CNODE_W(target, CNODE_TARGET);
            *falls = 0;
        }
        break;
    }
    return target;
}

/* runs the cross-jumping over the current function's block list until nothing changes */
void CROSS_JUMP_PASS(void)
{
    do {
        if (CTRL_BREAK_SEEN != 0)
            LINE_HOOK();
        CROSS_JUMP_CHANGED = 0;
        for (u16 node = CODE_BLOCK_LIST_HEAD; node != 0; node = CNODE_W(node, CNODE_NEXT))
            CNODE_W(node, CNODE_PRED_LIST) = 0;
        /* first walk: each non-empty code block that falls through or jumps unconditionally
           goes on the predecessor list of the block where it continues: a falling-through
           block at the head, jumping blocks after the head */
        for (u16 node = CODE_BLOCK_LIST_HEAD; node != 0; node = CNODE_W(node, CNODE_NEXT)) {
            if (CNODE_W(node, CNODE_KIND) != 0 || CNODE_W(node, CNODE_OP_COUNT) == 0)
                continue;
            u16 target;
            u8 falls;
            if (CNODE_W(node, CNODE_JUMP_KIND) == 1) {
                target = CNODE_W(node, CNODE_TARGET);
                falls = 0;
            } else {
                if (CNODE_W(node, CNODE_JUMP_KIND) != 0)
                    continue;
                target = CNODE_W(node, CNODE_NEXT);
                falls = 1;
                if (target == 0)
                    continue;
            }
            target = continuation(target, &falls);
            if (falls == 0) {
                CNODE_W(node, CNODE_JUMP_KIND) = 1;
                CNODE_W(node, CNODE_TARGET) = target;
            }
            if (falls != 0 || CNODE_W(target, CNODE_PRED_LIST) == 0) {
                CNODE_W(node, CNODE_PRED_NEXT) = CNODE_W(target, CNODE_PRED_LIST);
                CNODE_W(target, CNODE_PRED_LIST) = node;
            } else {
                u16 head = CNODE_W(target, CNODE_PRED_LIST);
                CNODE_W(node, CNODE_PRED_NEXT) = CNODE_W(head, CNODE_PRED_NEXT);
                CNODE_W(head, CNODE_PRED_NEXT) = node;
            }
        }
        /* second walk: each predecessor in list order (candidate) is compared with every
           predecessor after it, splitting off common tails; once a tail has been split off,
           each later predecessor compared with the new tail block is unlinked.  When
           optimising for speed the walk stops at a predecessor that jumps */
        for (u16 node = CODE_BLOCK_LIST_HEAD; node != 0; node = CNODE_W(node, CNODE_NEXT)) {
            for (u16 head = CNODE_W(node, CNODE_PRED_LIST); head != 0; head = CNODE_W(head, CNODE_PRED_NEXT)) {
                if (OPTION_OPTIMIZE_SPEED != 0 && CNODE_W(head, CNODE_JUMP_KIND) != 0)
                    break;
                u16 candidate = head, previous = head;
                for (u16 other = CNODE_W(head, CNODE_PRED_NEXT); other != 0;) {
                    candidate = SPLIT_COMMON_TAIL(other, candidate);
                    if (candidate != head) {
                        other = CNODE_W(other, CNODE_PRED_NEXT);
                        CNODE_W(previous, CNODE_PRED_NEXT) = other;
                    } else {
                        previous = other;
                        other = CNODE_W(other, CNODE_PRED_NEXT);
                    }
                }
            }
        }
    } while (CROSS_JUMP_CHANGED != 0);
}

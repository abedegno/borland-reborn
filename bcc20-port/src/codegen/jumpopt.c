/* jumpopt.c: from bcc20/src/codegen/JUMPOPT.C: jump optimisation on the flow-block list,
   run first when OPTIMIZE_ENABLED is set, before any code is laid out.
   RESOLVE_JUMP_TARGETS points every jump and case at the block that really holds code,
   counting references in CNODE_JUMP_REFS, and removes the label blocks.  OPTIMIZE_JUMPS
   then repeats, until JUMP_OPT_CHANGED stays 0: jumps to blocks that only jump are sent
   straight to the final target; unreachable blocks after an unconditional jump are
   unlinked; a jump to the next block is dropped; a block that falls into an empty
   unconditional jump takes that jump over; a target reached only by one jump is moved right
   after it; "conditional jump over an unconditional jump" becomes one inverted conditional
   jump; switch cases that go to the default are removed.  Blocks with CNODE_FLAGS 100h
   (jump fixed) keep their jump.  Scope entry and exit blocks (kinds 1 and 2) are skipped
   over when looking for the next or previous block of code. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define JUMP_OPT_CHANGED W(JUMP_OPT_CHANGED_P)
#define OP_FLAGS(op) D(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))

/* first pass: each jump target and switch case target replaced by FIND_REAL_TARGET;
   inline-assembler blocks get 7FFFh references so they are never removed, scope blocks 1.
   Second pass: the label blocks (kind 3) unlinked and freed; a label at the very end becomes
   an empty code block instead.  With JUMP_OPT_KEEP_EMPTY_BLOCKS set the removal stops at the
   first label */
void RESOLVE_JUMP_TARGETS(void)
{
    for (u16 node = CODE_BLOCK_LIST_HEAD; node != 0;) {
        u16 next = CNODE_W(node, CNODE_NEXT);
        switch (CNODE_W(node, CNODE_KIND)) {
        case 5:
            CNODE_W(node, CNODE_JUMP_REFS) = 0x7FFF;
            /* fall through */
        case 0:
            if (CNODE_W(node, CNODE_JUMP_KIND) != 0) {
                u16 target = FIND_REAL_TARGET(CNODE_W(node, CNODE_TARGET));
                CNODE_W(node, CNODE_TARGET) = target;
            }
            break;
        case 4: {
            u16 target = FIND_REAL_TARGET(CNODE_W(node, CNODE_TARGET));
            CNODE_W(node, CNODE_TARGET) = target;
            for (u16 member = CNODE_W(node, CNODE_CASE_LIST); member != 0; member = SWCASE_W(member, SWCASE_NEXT)) {
                target = FIND_REAL_TARGET(SWCASE_W(member, SWCASE_TARGET));
                SWCASE_W(member, SWCASE_TARGET) = target;
            }
            break;
        }
        case 1:
        case 2:
            CNODE_W(node, CNODE_JUMP_REFS) = 1;
        }
        node = next;
    }
    for (u16 node = CODE_BLOCK_LIST_HEAD; node != 0;) {
        u16 next = CNODE_W(node, CNODE_NEXT);
        if (CNODE_W(node, CNODE_KIND) == 3) {
            if (JUMP_OPT_KEEP_EMPTY_BLOCKS != 0)
                break;
            if (CNODE_W(node, CNODE_NEXT) != 0)
                CNODE_W(CNODE_W(node, CNODE_NEXT), CNODE_PREV) = CNODE_W(node, CNODE_PREV);
            else {
                CNODE_W(node, CNODE_KIND) = 0;
                CNODE_W(node, CNODE_JUMP_REFS)++;
                break;
            }
            if (CNODE_W(node, CNODE_PREV) != 0)
                CNODE_W(CNODE_W(node, CNODE_PREV), CNODE_NEXT) = CNODE_W(node, CNODE_NEXT);
            else
                CODE_BLOCK_LIST_HEAD = CNODE_W(node, CNODE_NEXT);
            POOL_FREE_ITEM(FLOW_BLOCK_POOL_SEG_P, node);
        }
        node = next;
    }
}

/* the main loop over the current function's block list; candidate is the next block of
   code after the current one */
void OPTIMIZE_JUMPS(void)
{
    do {
        JUMP_OPT_CHANGED = 0;
        for (u16 block = CODE_BLOCK_LIST_HEAD, next; block; block = next) {
            NESTING_CHECK();
            next = CNODE_W(block, CNODE_NEXT);
            while (IS_SKIPPABLE_JUMP_TARGET(block))
                RETARGET_JUMP(block, CNODE_W(CNODE_W(block, CNODE_TARGET), CNODE_NEXT));
            if ((CNODE_W(block, CNODE_KIND) == 0 || CNODE_W(block, CNODE_KIND) == 4) && CNODE_W(block, CNODE_JUMP_KIND)
                && IS_JUMP_ONLY_BLOCK(CNODE_W(block, CNODE_TARGET)) && !(CNODE_W(block, CNODE_FLAGS) & 0x100))
                RETARGET_JUMP(block, CNODE_W(CNODE_W(block, CNODE_TARGET), CNODE_TARGET));
            u16 candidate = NEXT_CODE_NODE(block);
            if (CNODE_W(block, CNODE_JUMP_KIND) == 1 && !(CNODE_W(block, CNODE_FLAGS) & 0x100)) {
                while (candidate && CNODE_W(candidate, CNODE_JUMP_REFS) == 0) {
                    UNLINK_NODE(candidate);
                    next = CNODE_W(block, CNODE_NEXT);
                    candidate = NEXT_CODE_NODE(block);
                }
            }
            switch (CNODE_W(block, CNODE_KIND)) {
            case 0:
            case 5:
                if (CNODE_W(block, CNODE_JUMP_KIND) == 0) {
                    /* no jump: an empty unreferenced code block is unlinked; a code block
                       followed by an empty block that only jumps takes over that jump */
                    if (CNODE_W(block, CNODE_OP_COUNT) == 0 && CNODE_W(block, CNODE_KIND) == 0 && CNODE_W(block, CNODE_JUMP_REFS) == 0) {
                        UNLINK_NODE(block);
                        break;
                    }
                    if (CNODE_W(block, CNODE_KIND) == 5 || candidate == 0 || CNODE_W(candidate, CNODE_KIND) || CNODE_W(candidate, CNODE_OP_COUNT)
                        || CNODE_W(candidate, CNODE_TARGET) == candidate || CNODE_W(candidate, CNODE_JUMP_KIND) != 1)
                        break;
                    CNODE_W(block, CNODE_JUMP_KIND) = 1;
                    CNODE_W(block, CNODE_FLAGS) |= CNODE_W(candidate, CNODE_FLAGS) & 0x100;
                    CNODE_W(block, CNODE_TARGET) = CNODE_W(candidate, CNODE_TARGET);
                    ++CNODE_W(CNODE_W(block, CNODE_TARGET), CNODE_JUMP_REFS);
                    JUMP_OPT_CHANGED = 1;
                    break;
                }
                /* a jump: to the next block it is removed; an unconditional jump to a block
                   with one reference may pull that block up behind it; a conditional jump
                   followed by an empty unconditional jump may be merged with it */
                if (CNODE_W(block, CNODE_FLAGS) & 0x100)
                    break;
                if (candidate && CNODE_W(block, CNODE_TARGET) == candidate) {
                    --CNODE_W(candidate, CNODE_JUMP_REFS);
                    CNODE_W(block, CNODE_JUMP_KIND) = 0;
                    CNODE_W(block, CNODE_TARGET) = 0;
                    JUMP_OPT_CHANGED = 1;
                    break;
                }
                if (CNODE_W(block, CNODE_JUMP_KIND) == 1) {
                    candidate = CNODE_W(block, CNODE_TARGET);
                    if (CNODE_W(candidate, CNODE_JUMP_REFS) == 1)
                        MOVE_TARGET_AFTER_JUMP(block, candidate);
                    break;
                }
                if (candidate == 0 || CNODE_W(candidate, CNODE_JUMP_KIND) != 1 || !IS_BLOCK_EMPTY(candidate))
                    break;
                MERGE_JUMP_OVER_JUMP(block, candidate);
                next = CNODE_W(block, CNODE_NEXT);
                break;
            case 4: {
                /* a switch: cases whose target only jumps are retargeted; cases that go to the
                   default are taken out; with no cases left the block becomes a code block
                   that jumps to the default */
                u16 previous = 0;
                for (u16 member = CNODE_W(block, CNODE_CASE_LIST); member; member = SWCASE_W(member, SWCASE_NEXT)) {
                    u16 child = SWCASE_W(member, SWCASE_TARGET);
                    if (IS_JUMP_ONLY_BLOCK(child)) {
                        --CNODE_W(child, CNODE_JUMP_REFS);
                        SWCASE_W(member, SWCASE_TARGET) = CNODE_W(child, CNODE_TARGET);
                        ++CNODE_W(SWCASE_W(member, SWCASE_TARGET), CNODE_JUMP_REFS);
                        child = SWCASE_W(member, SWCASE_TARGET);
                        JUMP_OPT_CHANGED = 1;
                    }
                    if (CNODE_W(block, CNODE_TARGET) == child) {
                        --CNODE_W(child, CNODE_JUMP_REFS);
                        if (previous)
                            SWCASE_W(previous, SWCASE_NEXT) = SWCASE_W(member, SWCASE_NEXT);
                        else
                            CNODE_W(block, CNODE_CASE_LIST) = SWCASE_W(member, SWCASE_NEXT);
                        JUMP_OPT_CHANGED = 1;
                    } else
                        previous = member;
                }
                if (CNODE_W(block, CNODE_CASE_LIST) == 0) {
                    CNODE_W(block, CNODE_KIND) = 0;
                    CNODE_W(block, CNODE_JUMP_KIND) = 1;
                    JUMP_OPT_CHANGED = 1;
                }
                break;
            }
            }
        }
    } while (JUMP_OPT_CHANGED);
}

/* true when value is an empty code block whose only effect is an unconditional jump to
   another block */
i16 IS_JUMP_ONLY_BLOCK(u16 value)
{
    return value && CNODE_W(value, CNODE_KIND) == 0 && CNODE_W(value, CNODE_JUMP_KIND) == 1 && IS_BLOCK_EMPTY(value)
           && CNODE_W(value, CNODE_TARGET) != value;
}

/* true when code block node produces no instructions: no ops, a single unreferenced op
   whose table flags are all 0, or only dead ops.  Other kinds are never empty */
i16 IS_BLOCK_EMPTY(u16 node)
{
    if (CNODE_W(node, CNODE_KIND) != 0)
        return 0;
    if (CNODE_W(node, CNODE_OP_COUNT) == 0)
        return 1;
    if (CNODE_W(node, CNODE_OP_COUNT) == 1 && CNODE_W(node, CNODE_JUMP_REFS) == 0
        && OP_FLAGS(COP_B(CNODE_W(node, CNODE_FIRST_OP) << 2, COP_OPCODE)) == 0)
        return 1;
    u16 slot = CNODE_W(node, CNODE_FIRST_OP) << 2;
    for (u16 count = CNODE_W(node, CNODE_OP_COUNT); count != 0; count--, slot += 4)
        if (!(COP_B(slot, COP_FLAGS) & 0x40))
            return 0;
    return 1;
}

/* true when block value jumps to a block that can be jumped past: a scope entry or exit
   block, or an empty code block that falls through to a next block */
i16 IS_SKIPPABLE_JUMP_TARGET(u16 value)
{
    if (!value || !CNODE_W(value, CNODE_JUMP_KIND))
        return 0;
    value = CNODE_W(value, CNODE_TARGET);
    if (CNODE_W(value, CNODE_KIND) == 1 || CNODE_W(value, CNODE_KIND) == 2)
        return 1;
    return CNODE_W(value, CNODE_KIND) == 0 && IS_BLOCK_EMPTY(value) && CNODE_W(value, CNODE_JUMP_KIND) == 0 && CNODE_W(value, CNODE_NEXT) != 0;
}

/* from jump target value, skips labels, scope blocks and empty code blocks that fall
   through, and returns the first block that does something (the last block of the list if
   it runs off the end).  That block gets one more reference and CNODE_FLAGS 10h */
u16 FIND_REAL_TARGET(u16 value)
{
    for (; value; value = CNODE_W(value, CNODE_NEXT)) {
        u16 kind = CNODE_W(value, CNODE_KIND);
        if (kind == 3 || kind == 1 || kind == 2)
            continue;
        if (kind != 0 || CNODE_W(value, CNODE_JUMP_KIND) != 0 || !IS_BLOCK_EMPTY(value))
            break;
    }
    if (!value)
        value = CODE_BLOCK_LIST_TAIL;
    CNODE_W(value, CNODE_JUMP_REFS)++;
    CNODE_W(value, CNODE_FLAGS) |= 0x10;
    return value;
}

/* one more reference on the jump target of block node */
void ADD_TARGET_REF(u16 node)
{
    CNODE_W(CNODE_W(node, CNODE_TARGET), CNODE_JUMP_REFS)++;
}

/* one reference less on the jump target of block node */
void DROP_TARGET_REF(u16 node)
{
    CNODE_W(CNODE_W(node, CNODE_TARGET), CNODE_JUMP_REFS)--;
}

/* block stop jumps unconditionally to node, its only reference.  If the block of code
   before node ends with an unconditional jump (so nothing falls into node), the run of
   unreferenced blocks from node up to the first one ending in an unconditional jump is moved
   to just after stop, which then falls into it instead of jumping.  If that run ends at stop
   itself, the whole run is a loop nothing else reaches, and its blocks are unlinked */
void MOVE_TARGET_AFTER_JUMP(u16 stop, u16 node)
{
    u16 previous = PREV_CODE_NODE(node);
    if (previous == 0 || CNODE_W(previous, CNODE_JUMP_KIND) != 1)
        return;
    u16 cursor;
    for (cursor = CNODE_W(node, CNODE_NEXT); cursor != 0; cursor = CNODE_W(cursor, CNODE_NEXT)) {
        if (CNODE_W(cursor, CNODE_JUMP_REFS) != 0)
            return;
        if (CNODE_W(cursor, CNODE_JUMP_KIND) == 1)
            break;
    }
    if (cursor == 0)
        return;
    if (cursor == stop) {
        for (;;) {
            cursor = NEXT_CODE_NODE(node);
            if (CNODE_W(node, CNODE_JUMP_KIND) != 0 && CNODE_W(node, CNODE_JUMP_KIND) != 1)
                CNODE_W(CNODE_W(node, CNODE_TARGET), CNODE_JUMP_REFS)--;
            UNLINK_NODE(node);
            if (node == stop)
                break;
            node = cursor;
        }
    } else {
        u16 after = CNODE_W(stop, CNODE_NEXT);
        u16 next = CNODE_W(cursor, CNODE_NEXT);
        previous = CNODE_W(node, CNODE_PREV);
        CNODE_W(previous, CNODE_NEXT) = next;
        if (next != 0)
            CNODE_W(next, CNODE_PREV) = previous;
        CNODE_W(cursor, CNODE_NEXT) = after;
        CNODE_W(after, CNODE_PREV) = cursor;
        CNODE_W(stop, CNODE_NEXT) = node;
        CNODE_W(node, CNODE_PREV) = stop;
        CNODE_W(stop, CNODE_JUMP_KIND) = 0;
        CNODE_W(stop, CNODE_TARGET) = 0;
    }
}

/* first jumps conditionally to the block after second, an empty block with an
   unconditional jump.  The condition of first is inverted and it now jumps to the target
   of second, which is unlinked (jcc L1; jmp L2; L1: becomes jncc L2; L1:) */
void MERGE_JUMP_OVER_JUMP(u16 first, u16 second)
{
    u16 current = NEXT_CODE_NODE(second);
    if (!current || CNODE_W(first, CNODE_TARGET) != current)
        return;
    --CNODE_W(current, CNODE_JUMP_REFS);
    CNODE_W(first, CNODE_TARGET) = CNODE_W(second, CNODE_TARGET);
    ++CNODE_W(CNODE_W(first, CNODE_TARGET), CNODE_JUMP_REFS);
    u16 kind = (u16)INVERT_JUMP_CONDITION(CNODE_W(first, CNODE_JUMP_KIND));
    CNODE_W(first, CNODE_JUMP_KIND) = kind;
    UNLINK_NODE(second);
}

/* the jump kind with the opposite condition */
i16 INVERT_JUMP_CONDITION(u16 index)
{
    return JUMP_CONDITION_INVERSE_TABLE_AT(index);
}

/* makes block first jump to second instead, moving the reference count */
void RETARGET_JUMP(u16 first, u16 second)
{
    DROP_TARGET_REF(first);
    CNODE_W(first, CNODE_TARGET) = second;
    ADD_TARGET_REF(first);
    JUMP_OPT_CHANGED = 1;
}

/* takes block value out of the function's list (fixing the head and tail) and, if it was a
   jump-only block, drops its reference on its target.  The block is not freed */
void UNLINK_NODE(u16 value)
{
    if (value == CODE_BLOCK_LIST_HEAD)
        CODE_BLOCK_LIST_HEAD = CNODE_W(value, CNODE_NEXT);
    if (value == CODE_BLOCK_LIST_TAIL)
        CODE_BLOCK_LIST_TAIL = CNODE_W(value, CNODE_PREV);
    if (IS_JUMP_ONLY_BLOCK(value))
        DROP_TARGET_REF(value);
    if (CNODE_W(value, CNODE_PREV) != 0)
        CNODE_W(CNODE_W(value, CNODE_PREV), CNODE_NEXT) = CNODE_W(value, CNODE_NEXT);
    if (CNODE_W(value, CNODE_NEXT) != 0)
        CNODE_W(CNODE_W(value, CNODE_NEXT), CNODE_PREV) = CNODE_W(value, CNODE_PREV);
    JUMP_OPT_CHANGED = 1;
}

/* the next block after node that is not a scope entry or exit block, or 0 */
u16 NEXT_CODE_NODE(u16 node)
{
    do
        node = CNODE_W(node, CNODE_NEXT);
    while (node && (CNODE_W(node, CNODE_KIND) == 1 || CNODE_W(node, CNODE_KIND) == 2));
    return node;
}

/* the same backwards */
u16 PREV_CODE_NODE(u16 node)
{
    do
        node = CNODE_W(node, CNODE_PREV);
    while (node && (CNODE_W(node, CNODE_KIND) == 1 || CNODE_W(node, CNODE_KIND) == 2));
    return node;
}

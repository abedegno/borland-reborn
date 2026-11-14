/* switch.c: from bcc20/src/codegen/SWITCH.C: switch statements.  The parser leaves one
   switch block (kind 4) per switch: the selector's ops (CNODE_SWITCH_LOW_OP, and
   CNODE_SWITCH_HIGH_OP for a long selector, CNODE_FLAGS 4), its case list (CNODE_CASE_LIST:
   CASE_ENTRY_POOL_SEG entries sorted by value) and the default target (CNODE_TARGET).
   LOWER_SWITCH replaces it by ordinary blocks in one of three shapes: a compare tree (a
   binary search on the case values, with short linear runs of compares at the leaves); a
   jump table, used inside the compare tree for a run of cases dense enough (span at most
   three times the count); a table scan for long selectors and for sparse switches with four
   or more cases when not optimising for speed.  The tables themselves are emitted after the
   function from table records: flow blocks reused as records (kind 1 value table, kind 2
   jump table; CNODE_CASE_LIST the first case, CNODE_CASE_COUNT the number of cases) linked
   through CNODE_NEXT on SWITCH_TABLE_LIST.  Code ops: 81h CMP word, 28h SUB word, 1Fh ADD
   word, 4Dh OR word, 99h a copy of the selector into a register, B6h a load into BX/CX, B0h
   and AFh the table address load and the jump through the table, 16h an indirect word with
   a segment override (BX with CS, register 14), constant ops 10; jump kinds 1 always, 3
   signed greater, 5 unsigned above, 0Ah equal, 0Bh not equal, 17h LOOP. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_OPTIMIZE_SPEED B(OPTION_OPTIMIZE_SPEED_P)
#define BCC_PACK_FLAG B(BCC_PACK_FLAG_P)

static u16 constant(u8 kind, i32 value)
{
    return NEW_CONSTANT_NODE(kind, (u16)((u32)value >> 16), (u16)value);
}

static void close_block(u16 block)
{
    CNODE_W(block, CNODE_OP_COUNT) = (u16)(CODE_OP_NEXT_INDEX - CNODE_W(block, CNODE_FIRST_OP));
}

/* pushes table record node on SWITCH_TABLE_LIST */
void LINK_NODE(u16 node)
{
    CNODE_W(node, CNODE_NEXT) = SWITCH_TABLE_LIST;
    SWITCH_TABLE_LIST = node;
}

/* lowers switch block node.  Without cases it just becomes a code block.  For a compare
   tree, the selector is copied into fresh ops in a new block, SWITCH_BIT_200_FLAG records an
   unsigned selector, and the compare blocks are spliced in after node, which becomes a
   plain block without a jump */
void LOWER_SWITCH(u16 node)
{
    u16 first_case = CNODE_W(node, CNODE_CASE_LIST);
    if (first_case == 0) {
        CNODE_W(node, CNODE_KIND) = 0;
        return;
    }
    u16 count = 1, last = first_case;
    for (; SWCASE_W(last, SWCASE_NEXT); last = SWCASE_W(last, SWCASE_NEXT))
        ++count;
    if ((CNODE_W(node, CNODE_FLAGS) & 4)
        || ((u16)(SWCASE_W(last, SWCASE_VALUE) - SWCASE_W(first_case, SWCASE_VALUE)) > (u16)(count * 3) && OPTION_OPTIMIZE_SPEED == 0 && count >= 4)) {
        LOWER_SWITCH_TABLE_SCAN(node, (i16)count, first_case);
        return;
    }
    u16 compare_block = NEW_BLOCK();
    u16 high_expr = CNODE_W(node, CNODE_SWITCH_HIGH_OP), low_expr = CNODE_W(node, CNODE_SWITCH_LOW_OP);
    low_expr = NEW_CODE_NODE(0x99, 0, low_expr, 0);
    if (high_expr)
        high_expr = NEW_CODE_NODE(0x99, 0, high_expr, 0);
    close_block(compare_block);
    CNODE_W(node, CNODE_SWITCH_HIGH_OP) = high_expr;
    CNODE_W(node, CNODE_SWITCH_LOW_OP) = low_expr;
    SWITCH_BIT_200_FLAG = CNODE_W(node, CNODE_FLAGS) & 0x200;
    LOWER_SWITCH_COMPARES(node, (i16)count, first_case, compare_block);
    CNODE_W(node, CNODE_KIND) = 0;
    CNODE_W(node, CNODE_JUMP_KIND) = 0;
    CNODE_W(node, CNODE_TARGET) = 0;
    SPLICE_BLOCK_CHAIN(node, compare_block, CNODE_W(node, CNODE_LOOP_WEIGHT));
}

/* table-scan lowering of switch block node with amount cases starting at case entry value.
   Builds a value-table record, stores the selector in a new temporary, and makes: a setup
   block (the case count into CX, the table address into BX); a loop block comparing the
   selector with CS:[BX] (for a long selector the high word with CS:[BX+amount*2] as well)
   and jumping to the dispatch block on a match; a step block (ADD BX,2, then LOOP back); a
   jump to the default label, given kind 4 and the case list; and the dispatch block, one op
   AFh that jumps through the label part of the table */
void LOWER_SWITCH_TABLE_SCAN(u16 node, i16 amount, u16 value)
{
    u8 wide = (CNODE_W(node, CNODE_FLAGS) & 4) != 0;
    u16 table_node = NEW_BLOCK();
    CNODE_W(table_node, CNODE_KIND) = 1;
    CNODE_W(table_node, CNODE_CASE_LIST) = value;
    CNODE_W(table_node, CNODE_FLAGS) = CNODE_W(node, CNODE_FLAGS);
    CNODE_W(table_node, CNODE_CASE_COUNT) = (u16)amount;
    LINK_NODE(table_node);
    u16 low = CNODE_W(node, CNODE_SWITCH_LOW_OP), high = CNODE_W(node, CNODE_SWITCH_HIGH_OP);
    u16 index_var = FIND_OR_ADD_VARIABLE(0, wide ? 8 : 6, 0);
    u16 setup_block = NEW_BLOCK();
    u16 temp = NEW_PLAIN_CODE_NODE(0x10, index_var, 0);
    NEW_CODE_NODE(0x9C, 2, temp, low);
    if (wide) {
        temp = NEW_PLAIN_CODE_NODE(0x10, index_var, 2);
        NEW_CODE_NODE(0x9C, 2, temp, high);
    }
    NEW_CODE_NODE(0xB6, 0, 0, constant(10, amount));
    constant(0xB0, (i16)table_node);
    close_block(setup_block);
    CNODE_W(setup_block, CNODE_KIND) = 0;
    CNODE_W(setup_block, CNODE_JUMP_KIND) = 1;
    CNODE_W(setup_block, CNODE_TARGET) = 0;
    CNODE_W(node, CNODE_JUMP_KIND) = 0;
    u16 default_label = CNODE_W(node, CNODE_TARGET);
    CNODE_W(node, CNODE_TARGET) = 0;
    CNODE_W(node, CNODE_KIND) = 0;
    u16 cur = NEW_BLOCK();
    u16 table_block = NEW_BLOCK();
    u16 bx = NEW_CODE_NODE(8, 0, 4, 0);
    temp = NEW_CODE_NODE(0x16, 0, bx, NEW_CODE_NODE(8, 0, 14, 0));
    NEW_CODE_NODE(0x81, 0, temp, NEW_PLAIN_CODE_NODE(0x10, index_var, 0));
    close_block(cur);
    u16 step_block;
    if (!wide) {
        CNODE_W(cur, CNODE_JUMP_KIND) = 10;
        CNODE_W(cur, CNODE_TARGET) = table_block;
        step_block = NEW_BLOCK();
    } else {
        CNODE_W(cur, CNODE_JUMP_KIND) = 11;
        u16 jump_block = NEW_BLOCK();
        bx = NEW_CODE_NODE(8, 0, 4, 0);
        u16 high_offset = NEW_CODE_NODE(0x1F, 0, bx, constant(10, (i16)(amount * 2)));
        temp = NEW_CODE_NODE(0x16, 0, high_offset, NEW_CODE_NODE(8, 0, 14, 0));
        NEW_CODE_NODE(0x81, 0, temp, NEW_PLAIN_CODE_NODE(0x10, index_var, 2));
        CNODE_W(jump_block, CNODE_JUMP_KIND) = 10;
        CNODE_W(jump_block, CNODE_TARGET) = table_block;
        close_block(jump_block);
        JOIN_BLOCK_CHAINS(cur, jump_block);
        step_block = NEW_BLOCK();
        CNODE_W(cur, CNODE_TARGET) = step_block;
    }
    temp = NEW_CODE_NODE(8, 0, 4, 0);
    NEW_CODE_NODE(0x1F, 2, temp, constant(10, 2));
    CNODE_W(step_block, CNODE_JUMP_KIND) = 0x17;
    CNODE_W(step_block, CNODE_TARGET) = cur;
    close_block(step_block);
    JOIN_BLOCK_CHAINS(cur, step_block);
    u16 jump_block = NEW_JUMP_BLOCK(default_label, 0, 0, 0, 0);
    CNODE_W(jump_block, CNODE_KIND) = 4;
    CNODE_W(jump_block, CNODE_CASE_LIST) = value;
    JOIN_BLOCK_CHAINS(cur, jump_block);
    CNODE_W(table_block, CNODE_FIRST_OP) = CODE_OP_NEXT_INDEX;
    constant(0xAF, (i16)(wide ? amount * 4 : amount * 2));
    CNODE_W(table_block, CNODE_OP_COUNT) = 1;
    JOIN_BLOCK_CHAINS(cur, table_block);
    JOIN_BLOCK_CHAINS(setup_block, cur);
    SPLICE_BLOCK_CHAIN(node, setup_block, CNODE_W(node, CNODE_LOOP_WEIGHT));
    CNODE_W(setup_block, CNODE_JUMP_KIND) = 0;
}

/* appends to block chain out the compares for count cases of switch block node starting at
   case entry item.  Up to three cases: compare and jump-if-equal for each (a long selector
   first skips on a different high word), then jump to the default.  More cases: find the
   middle case and the span of values; if dense enough, hand the run to
   LOWER_SWITCH_JUMP_TABLE (with fresh copies of the selector ops, put back afterwards);
   otherwise test the middle value, jump to the upper half when greater, do the lower half
   recursively, and loop on the upper half */
void LOWER_SWITCH_COMPARES(u16 node, i16 count, u16 item, u16 out)
{
    u16 high_expr = CNODE_W(node, CNODE_SWITCH_HIGH_OP), low_expr = CNODE_W(node, CNODE_SWITCH_LOW_OP);
    u16 entry = item;
    for (;;) {
        if (count <= 3) {
            for (i16 done = 0; done < count; ++done) {
                u16 skip_block = 0;
                if (high_expr) {
                    skip_block = NEW_BLOCK();
                    u16 block = NEW_BLOCK();
                    NEW_CODE_NODE(0x81, 0, high_expr, constant(10, (i16)SWCASE_W(entry, SWCASE_VALUE_HIGH)));
                    close_block(block);
                    CNODE_W(block, CNODE_JUMP_KIND) = 11;
                    CNODE_W(block, CNODE_TARGET) = skip_block;
                    JOIN_BLOCK_CHAINS(out, block);
                }
                u16 block = NEW_BLOCK();
                NEW_CODE_NODE(0x81, 0, low_expr, constant(10, SWCASE_L(entry, SWCASE_VALUE)));
                close_block(block);
                CNODE_W(block, CNODE_JUMP_KIND) = 10;
                CNODE_W(block, CNODE_TARGET) = SWCASE_W(entry, SWCASE_TARGET);
                JOIN_BLOCK_CHAINS(out, block);
                if (high_expr)
                    JOIN_BLOCK_CHAINS(out, skip_block);
                entry = SWCASE_W(entry, SWCASE_NEXT);
            }
            u16 default_block = NEW_JUMP_BLOCK(CNODE_W(node, CNODE_TARGET), 0, 0, 0, 0);
            JOIN_BLOCK_CHAINS(out, default_block);
            return;
        }
        u16 lower_count = (u16)count >> 1, last_case = entry, mid_case = 0;
        for (u16 span = 1; span < (u16)count; ++span) {
            if (span - 1 == lower_count)
                mid_case = last_case;
            last_case = SWCASE_W(last_case, SWCASE_NEXT);
        }
        u16 span = (u16)(SWCASE_W(last_case, SWCASE_VALUE) - SWCASE_W(entry, SWCASE_VALUE));
        if ((u16)(count * 3) >= span) {
            u16 block = NEW_BLOCK();
            u16 low_copy = NEW_CODE_NODE(0x99, 0, low_expr, 0);
            u16 high_copy = high_expr ? NEW_CODE_NODE(0x99, 0, high_expr, 0) : 0;
            CNODE_W(node, CNODE_SWITCH_HIGH_OP) = high_copy;
            CNODE_W(node, CNODE_SWITCH_LOW_OP) = low_copy;
            close_block(block);
            JOIN_BLOCK_CHAINS(out, block);
            block = LOWER_SWITCH_JUMP_TABLE(node, (u16)count, entry, last_case);
            CNODE_W(node, CNODE_SWITCH_HIGH_OP) = high_expr;
            CNODE_W(node, CNODE_SWITCH_LOW_OP) = low_expr;
            JOIN_BLOCK_CHAINS(out, block);
            return;
        }
        u16 block = NEW_BLOCK();
        NEW_CODE_NODE(0x81, 0, low_expr, constant(10, SWCASE_L(mid_case, SWCASE_VALUE)));
        CNODE_W(block, CNODE_JUMP_KIND) = 10;
        CNODE_W(block, CNODE_TARGET) = SWCASE_W(mid_case, SWCASE_TARGET);
        close_block(block);
        u16 branch_block = NEW_BLOCK();
        u16 skip_block = NEW_BLOCK();
        CNODE_W(branch_block, CNODE_JUMP_KIND) = SWITCH_BIT_200_FLAG ? 5 : 3;
        CNODE_W(branch_block, CNODE_TARGET) = skip_block;
        JOIN_BLOCK_CHAINS(block, branch_block);
        JOIN_BLOCK_CHAINS(out, block);
        LOWER_SWITCH_COMPARES(node, (i16)lower_count, entry, out);
        JOIN_BLOCK_CHAINS(out, skip_block);
        count = (i16)(count - (i16)(lower_count + 1));
        entry = SWCASE_W(mid_case, SWCASE_NEXT);
    }
}

/* jump-table lowering of the value cases from case entry start to end of switch block node;
   the first block made.  The selector minus the first case value is checked (for a long
   selector the high word must become 0, else jump to the default), loaded into BX and
   compared with end-start (jump to the default when above).  The dispatch block is a switch
   block with CNODE_FLAGS 2 (SHL BX,1 and the jump through the table record), with the
   default as its jump for the flow passes.  The case list is cut after end */
u16 LOWER_SWITCH_JUMP_TABLE(u16 node, u16 value, u16 start, u16 end)
{
    u16 head_block = NEW_BLOCK(), cur;
    u16 low = CNODE_W(node, CNODE_SWITCH_LOW_OP), high = CNODE_W(node, CNODE_SWITCH_HIGH_OP);
    if (CNODE_W(node, CNODE_FLAGS) & 4) {
        if (SWCASE_L(start, SWCASE_VALUE)) {
            u16 operand = constant(10, (i16)SWCASE_W(start, SWCASE_VALUE_HIGH));
            u16 low_constant = constant(10, SWCASE_L(start, SWCASE_VALUE));
            high = NEW_CODE_NODE(0x28, 0, high, operand);
            low = NEW_CODE_NODE(0x30, 0, low, low_constant);
        }
        NEW_CODE_NODE(0x4D, 0, high, high);
        close_block(head_block);
        CNODE_W(head_block, CNODE_JUMP_KIND) = 0x0B;
        CNODE_W(head_block, CNODE_TARGET) = CNODE_W(node, CNODE_TARGET);
        cur = NEW_BLOCK();
    } else {
        if (SWCASE_L(start, SWCASE_VALUE)) {
            u16 operand = constant(10, SWCASE_L(start, SWCASE_VALUE));
            low = NEW_CODE_NODE(0x28, 0, low, operand);
        }
        cur = head_block;
    }
    NEW_CODE_NODE(0xB6, 0, low, 0);
    low = NEW_CODE_NODE(8, 0, 4, 0);
    u16 operand = constant(10, (i32)((u32)SWCASE_L(end, SWCASE_VALUE) - (u32)SWCASE_L(start, SWCASE_VALUE)));
    NEW_CODE_NODE(0x81, 0, low, operand);
    CNODE_W(cur, CNODE_JUMP_KIND) = 5;
    close_block(cur);
    CNODE_W(cur, CNODE_TARGET) = CNODE_W(node, CNODE_TARGET);
    if (cur != head_block)
        JOIN_BLOCK_CHAINS(head_block, cur);
    cur = NEW_BLOCK();
    CNODE_W(cur, CNODE_KIND) = 4;
    CNODE_W(cur, CNODE_CASE_LIST) = start;
    SWCASE_W(end, SWCASE_NEXT) = 0;
    close_block(cur);
    CNODE_W(cur, CNODE_FLAGS) = 2;
    CNODE_W(cur, CNODE_JUMP_KIND) = 1;
    CNODE_W(cur, CNODE_TARGET) = CNODE_W(node, CNODE_TARGET);
    JOIN_BLOCK_CHAINS(head_block, cur);
    u16 table_node = NEW_BLOCK();
    CNODE_W(table_node, CNODE_KIND) = 2;
    CNODE_W(table_node, CNODE_CASE_LIST) = start;
    CNODE_W(table_node, CNODE_CASE_COUNT) = value;
    CNODE_W(table_node, CNODE_TARGET) = CNODE_W(node, CNODE_TARGET);
    LINK_NODE(table_node);
    CNODE_W(cur, CNODE_SWITCH_TABLE) = table_node;
    return head_block;
}

static void byte_out(u8 value)
{
    CALL_FAR(BYTE_HOOK, A16(value));
}

static void label_out(u16 target)
{
    CALL_FAR(EMIT_LABEL_WORD_HOOK, A16(target));
}

/* the value table of a table-scan switch at the current position: word-aligned when
   BCC_PACK_FLAG is set, labelled with the record, then the low words of all case values,
   the high words for a long switch, then one label word per case target */
void EMIT_SWITCH_VALUE_TABLE(u16 node)
{
    u16 head = CNODE_W(node, CNODE_CASE_LIST);
    i16 count = (i16)CNODE_W(node, CNODE_CASE_COUNT);
    if (BCC_PACK_FLAG)
        CALL_FAR(ALIGN_OUTPUT_HOOK, A16(2));
    CALL_FAR(DEFINE_NODE_LABEL_HOOK, A16(node));
    u16 item = head;
    for (i16 index = 0; index < count; index++, item = SWCASE_W(item, SWCASE_NEXT)) {
        u32 value = (u32)SWCASE_L(item, SWCASE_VALUE);
        byte_out((u8)value);
        byte_out((u8)(value >> 8));
    }
    if (CNODE_W(node, CNODE_FLAGS) & 4) {
        item = head;
        for (i16 index = 0; index < count; index++, item = SWCASE_W(item, SWCASE_NEXT)) {
            u32 value = (u32)SWCASE_L(item, SWCASE_VALUE);
            byte_out((u8)(value >> 16));
            byte_out((u8)(value >> 24));
        }
    }
    item = head;
    for (i16 index = 0; index < count; index++, item = SWCASE_W(item, SWCASE_NEXT))
        label_out(SWCASE_W(item, SWCASE_TARGET));
}

/* a jump table: one label word for every value from the first case to the last, the
   default target filling the gaps */
void EMIT_SWITCH_JUMP_TABLE(u16 node)
{
    u16 item = CNODE_W(node, CNODE_CASE_LIST);
    i16 count = (i16)CNODE_W(node, CNODE_CASE_COUNT);
    if (BCC_PACK_FLAG)
        CALL_FAR(ALIGN_OUTPUT_HOOK, A16(2));
    CALL_FAR(DEFINE_NODE_LABEL_HOOK, A16(node));
    i32 emitted = 0, position = SWCASE_L(item, SWCASE_VALUE);
    while (emitted < count) {
        while (SWCASE_L(item, SWCASE_VALUE) > position) {
            position = (i32)((u32)position + 1);
            label_out(CNODE_W(node, CNODE_TARGET));
        }
        label_out(SWCASE_W(item, SWCASE_TARGET));
        position = (i32)((u32)position + 1);
        emitted++;
        item = SWCASE_W(item, SWCASE_NEXT);
    }
}

/* emits every table record on SWITCH_TABLE_LIST (kind 1 value table, otherwise jump
   table) */
void EMIT_SWITCH_TABLES(void)
{
    for (u16 node = SWITCH_TABLE_LIST; node != 0; node = CNODE_W(node, CNODE_NEXT)) {
        if (CNODE_W(node, CNODE_KIND) == 1)
            EMIT_SWITCH_VALUE_TABLE(node);
        else
            EMIT_SWITCH_JUMP_TABLE(node);
    }
}

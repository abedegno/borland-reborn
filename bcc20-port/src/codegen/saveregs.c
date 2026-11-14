/* saveregs.c: from bcc20/src/codegen/SAVEREGS.C (overlay CO062): the code generator's 8087
   support.  It builds floating-point code ops (binary ops, compares, stores, float
   arguments, x++ on floats, constants) and keeps track of the 8087 register stack while
   the register allocator walks the ops (REGALLOC.C calls PUSH_EVAL_STACK,
   POP_EVAL_STACK_OPERANDS and SPILL_EVAL_STACK_TO_TEMPS).  The 8087 has eight registers, so
   values that must leave it are spilled into 10-byte temporaries and reloaded later; spills
   and reloads are register history entries (actions 4 and 5) that EMIT_REGISTER_HISTORY
   replays.  A reloaded value can end up below the other operand, so the reload records that
   the next op must use its operand-swapped form (SWAP_OPERAND_OPCODE).
   State: EVAL_STACK_TOP (top level, -1 when empty), EVAL_STACK_SPILLED (levels up to this
   one are in temporaries), EVAL_STACK_VALUES and EVAL_STACK_TEMP_NODES (two interleaved
   word arrays, level*2 indexes both), EVAL_STACK_MAX; POOLED_NODE_STACK and POOLED_NODE_TOP
   (free spill temporaries); SCRATCH_TEMP_VARIABLE (one temporary for conversions).
   The file also resolves the stack offsets of pushed float arguments
   (RESOLVE_STACK_BALANCE) and emits the 8087 slots of SAVED_REG_MASK around the function
   body (called from FRAME.C).
   Probable meanings of the ops: 57h FWAIT, 67h FLD and 6Ch FSTP of a memory operand (plus
   OPERAND_KIND_OPCODE_DELTA for its size), 8Ah FLDZ, 8Bh FLD1, 8Ch FLD ST(i), 90h discard
   the top, 84h compare, 8Fh FSTSW, 29h-2Eh and 38h-3Dh the subtract and divide families in
   normal and reversed form. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "kind.h"

#define OP_FLAGS(op) D(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))
#define OP_SIZE(op) B(fp_add(CODE_OP_INFO_TABLE_P, 4 + (op) * 19))
#define BCC_PACK_FLAG B(BCC_PACK_FLAG_P)

/* how far the 8087 op for op value's operand size lies from the base op: 0 below 4 bytes,
   else size-6 (-2 float, 2 double, 4 long double) */
i16 OPERAND_KIND_OPCODE_DELTA(u16 value)
{
    i16 size = OP_SIZE(COP_B(value << 2, COP_OPCODE));
    if (size < 4)
        return 0;
    return size - 6;
}

/* the operand-reversed form of 8087 op value (29h-2Bh and 38h-3Ah up by 3, 2Ch-2Eh and
   3Bh-3Dh down by 3; probably FSUB/FSUBR and FDIV/FDIVR); other ops unchanged */
i16 SWAP_OPERAND_OPCODE(i16 value)
{
    if ((value >= 0x29 && value <= 0x2B) || (value >= 0x38 && value <= 0x3A))
        return value + 3;
    if ((value >= 0x2C && value <= 0x2E) || (value >= 0x3B && value <= 0x3D))
        return value - 3;
    return value;
}

/* the 8087 op for binary node type (its value kind set to long double to pick the op
   family) on operand ops first and last; when last was generated before first the
   operands are swapped and the reversed op used.  The op is sized by last */
u16 GEN_FPU_BINARY_OP(u16 type, u16 first, u16 last)
{
    EXPR_W(type, EXPR_KIND) = TK_LDOUBLE;
    u16 op = CODE_OP_FOR_NODE(type);
    if (last < first) {
        op = (u16)SWAP_OPERAND_OPCODE((i16)op);
        u16 swap = first;
        first = last;
        last = swap;
    }
    return NEW_CODE_NODE(op + OPERAND_KIND_OPCODE_DELTA(last), 0, first, last);
}

/* an 8087 compare of other with value, then the status word into the CPU flags: FSTSW AX
   when OPTION_FLOAT_MODE is 3 (probably -f287), else FSTSW into a temporary, FWAIT, then
   B7h and A9h (probably MOV AH and SAHF), so an ordinary conditional jump can follow */
void GEN_FPU_COMPARE(u16 other, u16 value)
{
    NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(value) + 0x84, 0, other, value);
    if (OPTION_FLOAT_MODE == 3) {
        NEW_CODE_NODE(0x8F, 2, NEW_CODE_NODE(8, 0, 0, 0), 0);
        NEW_CONSTANT_NODE(0x57, 0, 0);
        NEW_CODE_NODE(0xB7, 0, NEW_CODE_NODE(8, 0, 0, 0), 0);
    } else {
        NEW_CODE_NODE(0x8F, 2, FLOAT_TEMP_NODE(3, 0), 0);
        NEW_CONSTANT_NODE(0x57, 0, 0);
        NEW_CODE_NODE(0xB7, 0, FLOAT_TEMP_NODE(3, 0), 0);
    }
    NEW_CONSTANT_NODE(0xA9, 0, 0);
}

/* store 8087 value mode into value (6Ch sized by value, in place on it), then FWAIT;
   returns the store op */
u16 FPU_STORE_NODE_6C(u16 value, u16 mode)
{
    u16 result = NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(value) + 0x6C, 2, value, mode);
    NEW_CONSTANT_NODE(0x57, 0, 0);
    return result;
}

/* passes floating argument node: SP lowered by its size (ADh with -size), the value stored
   into the new stack slot (B2h, whose offset RESOLVE_STACK_BALANCE fills in later, hence
   STACK_BALANCE_NEEDED), then FWAIT */
u16 PUSH_FLOAT_ARGUMENT(u16 node)
{
    u16 kind = EXPR_W(node, EXPR_KIND) + 0x61;
    u32 value = GENERATE_EXPRESSION(node, 1);
    u16 size = (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(EXPR_W(node, EXPR_TYPE)));
    NEW_CONSTANT_NODE(0xAD, 0, (u16)-size);
    u16 result = NEW_CONSTANT_NODE(0xB2, 0, 0);
    STACK_BALANCE_NEEDED = 1;
    result = NEW_CODE_NODE(kind, 2, result, (u16)value);
    NEW_CONSTANT_NODE(0x57, 0, 0);
    return result;
}

/* x++ or x-- on a floating x: loads x (the result), adds or subtracts 1 to a copy (FLD
   ST(0), FLD1 and the op of the compound assignment EXPAND_COMPOUND_ASSIGN_HOOK builds) and
   stores it back.  The second parameter is not used */
u16 GEN_FLOAT_POSTINC_DEC(u16 node, u16 unused)
{
    (void)unused;
    EXPR_W(node, EXPR_KIND) = TK_LDOUBLE;
    u16 kind = CODE_OP_FOR_NODE(node);
    node = (u16)CALL_FAR(EXPAND_COMPOUND_ASSIGN_HOOK, A16(node));
    u16 result = (u16)GENERATE_EXPRESSION(EXPR_W(EXPR_W(node, EXPR_RIGHT), EXPR_LEFT), 1);
    result = NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(result) + 0x67, 0, 0, result);
    u16 first = NEW_CONSTANT_NODE(0x8C, 0, 0);
    u16 second = NEW_CONSTANT_NODE(0x8B, 0, 0);
    first = NEW_CODE_NODE(kind, 0, first, second);
    u16 value = (u16)GENERATE_EXPRESSION(EXPR_W(node, EXPR_LEFT), 1);
    NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(value) + 0x6C, 2, value, first);
    return result;
}

/* 0 when the two 10-byte long doubles are identical, else 1 */
i16 COMPARE_TEN_BYTES(farptr first, farptr second)
{
    for (i16 count = 10; --count >= 0;) {
        if (B(first) != B(second))
            return 1;
        first = fp_add(first, 1);
        second = fp_add(second, 1);
    }
    return 0;
}

/* the op for floating constant node (its long double at node+10).  0.0 and 1.0 become FLDZ
   and FLD1.  Other values go into the data byte pool in the smallest exact form (float when
   rounding to float loses nothing, else the node's own kind), word-aligned when
   BCC_PACK_FLAG is set and merged with an identical earlier copy, and are read as a leaf at
   that offset of the string-literal symbol.  The four 10-byte arrays sit in BCC's frame:
   first at bp-0Ah, second bp-14h, zero bp-1Eh, one bp-28h (frame 2Eh) */
u16 EMIT_FLOAT_CONSTANT(u16 node)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x2E);
    farptr first = fp_add(v, 0x24), second = fp_add(v, 0x1A);
    farptr zero = fp_add(v, 0x10), one = fp_add(v, 0x06);
    farptr operand = MK_FP(EXPR_POOL_SEG, node + 10);
    u16 result;
    RTL_LONG_TO_LDOUBLE(0, zero);
    if (!COMPARE_TEN_BYTES(operand, zero)) {
        result = NEW_CONSTANT_NODE(0x8A, 0, 0);
        goto done;
    }
    RTL_LONG_TO_LDOUBLE(1, one);
    if (!COMPARE_TEN_BYTES(operand, one)) {
        result = NEW_CONSTANT_NODE(0x8B, 0, 0);
        goto done;
    }
    i16 kind = (i16)EXPR_W(node, EXPR_KIND);
    RTL_MEMMOVE(first, operand, 10);
    RTL_LDOUBLE_ROUND_TO_FLOAT(first);
    if (!COMPARE_TEN_BYTES(first, operand))
        kind = 9;
    RTL_MEMMOVE(second, operand, 10);
    i16 size = 0;
    switch (kind) {
    case 9:
        RTL_LDOUBLE_TO_FLOAT(second, first);
        size = 4;
        break;
    case 10:
        RTL_LDOUBLE_TO_DOUBLE(second, first);
        size = 8;
        break;
    case 11:
        RTL_MEMMOVE(first, operand, 10);
        size = 10;
        break;
    }
    u16 offset = BYTE_POOL_LENGTH();
    if (BCC_PACK_FLAG && (offset & 1)) {
        EMIT_VALUE(0);
        ++offset;
    }
    for (i16 i = 0; i < size; ++i)
        EMIT_VALUE((i8)B(fp_add(first, i)));
    offset = MERGE_DUPLICATE_BYTES(offset);
    u8 leaf = LEAF_OPCODE_KIND_OFFSET_AT(kind) + 15;
    u16 symbol = (u16)CALL_FAR0(STRING_LITERAL_SYMBOL_HOOK);
    result = NEW_VARIABLE_NODE(leaf, symbol, offset, 0);
done:
    scratch_release(mark);
    return result;
}

/* the SP movement of the history entries at history that come before op number index
   (pushes -2, pops +2); returns the next entry */
static u16 history_balance(u16 history, u16 index, i16 *balance)
{
    while (history < HISTORY_END_OFFSET && RHIST_W(history, RHIST_INSN_INDEX) == index) {
        switch (RHIST_B(history, RHIST_ACTION)) {
        case 1: *balance -= 2; break;
        case 2: *balance += 2; break;
        }
        history += 9;
    }
    return history;
}

/* when STACK_BALANCE_NEEDED, walks all ops in block order counting how far SP has moved
   (pushes and PUSHF without a register -2, pops +2, history pushes and pops, SP adjustments
   ADh/AEh) and stores the running value as the constant of each stack-slot op B2h, which
   OPERAND_FROM_NODE turns into a BP-relative address.  The count simply carries on from
   block to block.  History entries after a block's last op carry the op number negated */
void RESOLVE_STACK_BALANCE(void)
{
    if (STACK_BALANCE_NEEDED == 0)
        return;
    i16 balance = 0;
    for (u16 node = CODE_BLOCK_LIST_HEAD; node;) {
        u16 index = CNODE_W(node, CNODE_FIRST_OP);
        u16 cursor = index * 4;
        u16 history = CNODE_W(node, CNODE_HISTORY);
        for (u16 count = CNODE_W(node, CNODE_OP_COUNT); count > 0; --count) {
            history = history_balance(history, index, &balance);
            switch (COP_B(cursor, COP_OPCODE)) {
            case 0x73:
                if (COP_B(cursor, COP_REGISTER) != 0xFF)
                    break;
                /* fall through */
            case 0x93:
            case 0x94:
                balance -= 2;
                break;
            case 0x7F:
                balance += 2;
                break;
            case 0xAD:
            case 0xAE:
                balance += (i16)OPND_W(cursor, OPND_LEFT);
                break;
            case 0xB2:
                OPND_L(cursor, 0) = balance;
                break;
            }
            cursor += 4;
            ++index;
        }
        history_balance(history, (u16)-index, &balance);
        node = CNODE_W(node, CNODE_NEXT);
    }
}

/* forgets the spill temporaries, the scratch temporary and the 8087 stack depth (after
   each function) */
void RESET_TEMP_POOL(void)
{
    POOLED_NODE_TOP = -1;
    SCRATCH_TEMP_VARIABLE = 0;
    EVAL_STACK_MAX = -1;
}

/* a 10-byte temporary for an 8087 spill: a released one if any, else a new variable-table
   entry (long double, kept in memory) */
u16 ACQUIRE_POOLED_NODE(void)
{
    if (POOLED_NODE_TOP < 0) {
        u16 node = FIND_OR_ADD_VARIABLE(0, 11, 0);
        VAR_B(node, VAR_FLAGS) |= 4;
        VAR_W(node, VAR_USE_COUNT) = 1;
        return node;
    }
    u16 node = POOLED_NODE_STACK_AT(POOLED_NODE_TOP);
    POOLED_NODE_TOP--;
    return node;
}

/* returns spill temporary value for reuse (at most 100 are kept) */
void RELEASE_POOLED_NODE(u16 value)
{
    if (POOLED_NODE_TOP < 99) {
        POOLED_NODE_TOP++;
        POOLED_NODE_STACK_AT(POOLED_NODE_TOP) = value;
    }
}

/* a leaf op of value kind index reading the scratch temporary at offset value.  The
   temporary is made on first use and its kind grows to the largest index asked for, so it
   is big enough for every use (CGCONV.C moves values between the CPU and the 8087 in it) */
u16 FLOAT_TEMP_NODE(i16 index, u16 value)
{
    if (SCRATCH_TEMP_VARIABLE == 0) {
        u16 variable = FIND_OR_ADD_VARIABLE(0, 3, 0);
        SCRATCH_TEMP_VARIABLE = variable;
        VAR_B(SCRATCH_TEMP_VARIABLE, VAR_FLAGS) |= 4;
        VAR_W(SCRATCH_TEMP_VARIABLE, VAR_USE_COUNT) = 1;
    }
    if (VAR_B(SCRATCH_TEMP_VARIABLE, VAR_TYPE_KIND) < index)
        VAR_B(SCRATCH_TEMP_VARIABLE, VAR_TYPE_KIND) = (u8)index;
    return NEW_PLAIN_CODE_NODE(LEAF_OPCODE_KIND_OFFSET_AT(index) + 0x0F, SCRATCH_TEMP_VARIABLE, value);
}

/* before op value, records a spill (history action 4) of every 8087 stack level not yet
   spilled, each into its own pooled temporary */
void SPILL_EVAL_STACK_TO_TEMPS(u16 value)
{
    for (i16 level = EVAL_STACK_TOP; level > EVAL_STACK_SPILLED; level--) {
        u16 node = POOL_ALLOC(REG_HISTORY_POOL_SEG_P, 9);
        RHIST_B(node, RHIST_ACTION) = 4;
        RHIST_W(node, RHIST_INSN_INDEX) = value;
        RHIST_B(node, RHIST_IS_WORD) = 0;
        RHIST_B(node, RHIST_REGISTER) = 0;
        RHIST_W(node, RHIST_VALUE_OP) = EVAL_STACK_VALUES_AT(level * 2);
        u16 temp = ACQUIRE_POOLED_NODE();
        RHIST_W(node, RHIST_PARTNER) = temp;
        EVAL_STACK_TEMP_NODES_AT(level * 2) = RHIST_W(node, RHIST_PARTNER);
    }
    EVAL_STACK_SPILLED = EVAL_STACK_TOP;
}

/* op value when its result is a value on the 8087 stack (an op with table flag 2 that is
   neither dead nor folded into an operand, looking through sequence ops 3 to the value they
   yield), else 0 */
u16 FPU_STACK_OPERAND_OR_ZERO(u16 value)
{
    if (!value)
        return 0;
    u16 slot = value << 2;
    if (COP_B(slot, COP_FLAGS) & 0x40)
        return 0;
    while (COP_B(slot, COP_OPCODE) == 3) {
        slot = OPND_W(slot, OPND_RIGHT) << 2;
        value = OPND_W(slot, OPND_LEFT);
        slot = value << 2;
    }
    if (COP_B(slot, COP_FLAGS) & 1)
        return 0;
    if (OP_FLAGS(COP_B(slot, COP_OPCODE)) & 2)
        return value;
    return 0;
}

/* before op second, records the reload (history action 5) of spilled value first from the
   top spilled level's temporary, which is released.  RHIST_REGISTER is 1 when unspilled
   values remain above it, so the replay sets SWAP_OPCODE_FLAG */
void RELOAD_SPILLED_EVAL_ENTRY(u16 first, u16 second)
{
    u16 node = POOL_ALLOC(REG_HISTORY_POOL_SEG_P, 9);
    RHIST_B(node, RHIST_ACTION) = 5;
    RHIST_W(node, RHIST_INSN_INDEX) = second;
    RHIST_B(node, RHIST_IS_WORD) = 0;
    RHIST_B(node, RHIST_REGISTER) = EVAL_STACK_SPILLED < EVAL_STACK_TOP;
    RHIST_W(node, RHIST_VALUE_OP) = first;
    RHIST_W(node, RHIST_PARTNER) = EVAL_STACK_TEMP_NODES_AT(EVAL_STACK_SPILLED * 2);
    RELEASE_POOLED_NODE(RHIST_W(node, RHIST_PARTNER));
    EVAL_STACK_SPILLED--;
}

/* op node (a record offset) at op number value consumes its 8087 operands: right, then
   left (not for a sequence op 3), each reloaded first if it was spilled */
void POP_EVAL_STACK_OPERANDS(u16 node, u16 value)
{
    i16 level = EVAL_STACK_TOP;
    u16 second = OPND_W(node, OPND_RIGHT);
    if (COP_B(node, COP_OPCODE) == 3)
        second = OPND_W(second << 2, OPND_LEFT);
    second = FPU_STACK_OPERAND_OR_ZERO(second);
    if (second) {
        if (EVAL_STACK_SPILLED == level)
            RELOAD_SPILLED_EVAL_ENTRY(second, value);
        --level;
    }
    u16 first = FPU_STACK_OPERAND_OR_ZERO(OPND_W(node, OPND_LEFT));
    if (first && COP_B(node, COP_OPCODE) != 3) {
        if (EVAL_STACK_SPILLED == level)
            RELOAD_SPILLED_EVAL_ENTRY(first, value);
        --level;
    }
    EVAL_STACK_TOP = level;
}

/* op value leaves its result on the 8087 stack */
void PUSH_EVAL_STACK(u16 value)
{
    EVAL_STACK_TOP++;
    EVAL_STACK_VALUES_AT(EVAL_STACK_TOP * 2) = value;
    if (EVAL_STACK_TOP > EVAL_STACK_MAX)
        EVAL_STACK_MAX = EVAL_STACK_TOP;
}

/* emits 8087 op kind working in place on memory operand value.  A register variable
   (VAR_FLAGS 2) is the op's second operand.  Otherwise the reversed op is applied with the
   memory operand and the result stored back with FSTP (for a leaf op 14h the operand is
   loaded with FLD first and the reversed op has no operand) */
void EMIT_FPU_OP_ON_OPERAND(u16 kind, u16 value)
{
    u16 offset = value * 4;
    u16 item = OPND_W(offset, OPND_LEFT);
    if (VAR_B(item, VAR_FLAGS) & 2)
        EMIT_INSN_NODE_REG(kind, value, 0);
    else if (COP_B(offset, COP_OPCODE) == 0x14) {
        EMIT_INSN_NODE(0x67, value);
        EMIT_INSN_NO_OPERANDS((u16)SWAP_OPERAND_OPCODE((i16)kind));
        EMIT_INSN_NODE(0x6C, value);
    } else {
        EMIT_INSN_NODE((u16)SWAP_OPERAND_OPCODE((i16)kind), value);
        EMIT_INSN_NODE(OPERAND_KIND_OPCODE_DELTA(value) + 0x6C, value);
    }
}

/* the jump kind to use after an 8087 compare, from JUMP_KIND_REMAP_TABLE (probably the
   signed conditions to the unsigned ones that SAHF's carry and zero flags need) */
i16 REMAP_JUMP_KIND(u16 index)
{
    return JUMP_KIND_REMAP_TABLE_AT(index);
}

/* one FLDZ (8Ah) per bit of SAVED_REG_MASK, probably reserving 8087 stack slots at
   function entry */
void EMIT_SAVED_REG_PUSHES(void)
{
    for (u16 state = SAVED_REG_MASK; state != 0; state >>= 1)
        if (state & 1)
            EMIT_INSN_NO_OPERANDS(0x8A);
}

/* removes those slots at function exit: one discard (90h) per slot, except that when mode
   says the function returns a floating value the first is 6Ch with the slot count
   (probably FSTP ST(count)), which moves the result into the deepest slot so it stays on
   top when the rest are dropped */
void EMIT_SAVED_REG_POPS(u16 mode)
{
    i16 count = 0;
    for (u16 bits = SAVED_REG_MASK; bits != 0; bits >>= 1)
        count += bits & 1;
    if (mode != 0 && count > 0) {
        EMIT_INSN_REG(0x6C, (u8)count);
        count--;
    }
    while (count != 0) {
        EMIT_INSN_NO_OPERANDS(0x90);
        count--;
    }
}

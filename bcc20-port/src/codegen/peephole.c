/* peephole.c: from bcc20/src/codegen/PEEPHOLE.C: the redundant-load pass, run after
   register allocation when optimising.  It walks the function's code ops in block order and
   keeps, for each of the 16 registers, a slot (DS:8762, 4 bytes each: the op whose value
   the register holds and the store stamp at that moment).  An op whose value is already in
   its register is marked dead (COP_FLAGS 40h); a memory operand folded into an instruction
   (COP_FLAGS 1) whose value already sits in a register the instruction accepts is turned
   into that register.  PEEPHOLE_STORE_STAMP counts stores, each variable keeps the stamp of
   its last store and PEEPHOLE_MEMORY_STORE_STAMP that of the last store through a pointer,
   which may change any variable kept in memory unless OPTION_SUPPRESS_RELOADS.  All slots
   are forgotten at a block whose register contents are unknown (CNODE_FLAGS 10h), at inline
   assembler blocks and after an op with table flag 400h; other ops forget the registers
   they destroy.  Register history entries also overwrite slots.  Table entry (19 bytes,
   from CODE_OP_INFO_TABLE-3): the flag long at 3 (1 variable leaf, 8 constant, 20h raw
   word, 4 writes its left operand, 100h, 400h), the register classes allowed for the
   left/right operand at 9/10, the destroyed-register set at 12. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define COP_SC(r, o) SB(MK_FP(CODE_OP_POOL_SEG, (r) + (o)))
#define ENTRY(op) fp_add(OPCODE_DESCRIPTOR_TABLE_P, (op) * 19)
#define ENTRY_FLAGS(e) D(fp_add((e), 3))
#define ENTRY_TAIL(e, i) B(fp_add((e), 7 + (i)))
#define SLOT_VALUE(n) W(fp_add(PEEPHOLE_STORE_STAMP_P, 2 + (i16)(n) * 4))
#define SLOT_STAMP(n) W(fp_add(PEEPHOLE_STORE_STAMP_P, 4 + (i16)(n) * 4))

/* forgets the contents of all 16 register slots and the last pointer store */
void CLEAR_REGISTER_SLOTS(void)
{
    for (i16 n = 0; n < 16; ++n)
        SLOT_VALUE(n) = 0;
    PEEPHOLE_MEMORY_STORE_STAMP = 0;
}

/* forgets the slots of the registers whose bits are set in mask */
void CLEAR_SLOTS_BY_MASK(u16 mask)
{
    for (i16 n = 0; mask; ++n, mask >>= 1)
        if (mask & 1)
            SLOT_VALUE(n) = 0;
}

/* true when op right computes the same value as op left, the value a register was loaded
   with when the store stamp was limit.  Only leaves count: the same opcode (not a table flag
   400h op) and either the same variable and offset (always true for a constant address;
   otherwise only if the variable was not stored since, not hit by a later pointer store when
   it lives in memory, and not volatile) or, for constants, the same long value */
i16 REGISTER_HOLDS_VALUE(u16 left, u16 right, u16 limit)
{
    if (left == 0)
        return 0;
    u16 a = left << 2, b = right << 2;
    if (COP_B(a, COP_OPCODE) != COP_B(b, COP_OPCODE))
        return 0;
    u32 flags = ENTRY_FLAGS(ENTRY(COP_B(a, COP_OPCODE)));
    if (flags & 0x400)
        return 0;
    if (flags & 1) {
        if (OPND_W(a, OPND_LEFT) != OPND_W(b, OPND_LEFT) || OPND_W(a, OPND_RIGHT) != OPND_W(b, OPND_RIGHT))
            return 0;
        if (flags & 8)
            return 1;
        u16 variable = OPND_W(a, OPND_LEFT);
        if (VAR_W(variable, VAR_STORE_STAMP) > limit)
            return 0;
        if ((VAR_B(variable, VAR_FLAGS) & 4) && PEEPHOLE_MEMORY_STORE_STAMP > limit)
            return 0;
        if (VAR_B(variable, VAR_FLAGS) & 0x80)
            return 0;
        return 1;
    }
    if (flags & 8)
        return OPND_L(a, OPND_LEFT) == OPND_L(b, OPND_LEFT);
    return 0;
}

/* the register op value occupies at its own position: the last history entry at or before
   it that moves the value (following exchanges backwards to the partner op), or else its
   COP_REGISTER */
u8 FIND_ASSIGNED_REGISTER(u16 value)
{
    for (u16 entry = HISTORY_END_OFFSET; entry;) {
        entry -= 9;
        if (RHIST_W(entry, RHIST_INSN_INDEX) > value)
            continue;
        if (RHIST_W(entry, RHIST_VALUE_OP) == value) {
            if (RHIST_B(entry, RHIST_ACTION) == 6) {
                value = RHIST_W(entry, RHIST_PARTNER);
                continue;
            }
            return RHIST_B(entry, RHIST_REGISTER);
        }
        if (RHIST_B(entry, RHIST_ACTION) == 6 && RHIST_W(entry, RHIST_PARTNER) == value)
            value = RHIST_W(entry, RHIST_VALUE_OP);
    }
    return COP_B(value << 2, COP_REGISTER);
}

/* folded operand op second may use registers of class first.  If one of them already holds
   its value, the operand becomes that register: COP_REGISTER is set and the op is marked
   dead (40h) apart from its folded flag */
void MARK_REDUNDANT_OPERAND(u16 second, u16 first)
{
    u16 mask = REG_CLASS_MASK_TABLE_AT(first);
    for (i16 n = 0; mask; ++n, mask >>= 1) {
        if ((mask & 1) && SLOT_VALUE(n) && REGISTER_HOLDS_VALUE(SLOT_VALUE(n), second, SLOT_STAMP(n))) {
            u16 entry = second << 2;
            COP_B(entry, COP_REGISTER) = FIND_ASSIGNED_REGISTER(second);
            COP_B(entry, COP_FLAGS) &= 1;
            COP_B(entry, COP_FLAGS) |= 0x40;
            return;
        }
    }
}

/* folded operand operand of an op that may use registers of class class */
static void redundant_operand(u16 operand, u8 class)
{
    if (operand && (COP_B(operand << 2, COP_FLAGS) & 1))
        MARK_REDUNDANT_OPERAND(operand, class);
}

/* the pass over the current function.  Stamps start at 0 for every variable */
void ELIMINATE_REDUNDANT_LOADS(void)
{
    CLEAR_REGISTER_SLOTS();
    PEEPHOLE_STORE_STAMP = 0;
    for (u16 node = 2; node < VARIABLE_TABLE_END; node += 29)
        VAR_W(node, VAR_STORE_STAMP) = 0;
    for (u16 current = CODE_BLOCK_LIST_HEAD; current; current = CNODE_W(current, CNODE_NEXT)) {
        if (CNODE_W(current, CNODE_FLAGS) & 0x10)
            CLEAR_REGISTER_SLOTS();
        if (CNODE_W(current, CNODE_KIND) == 5)
            CLEAR_REGISTER_SLOTS();
        if (CNODE_W(current, CNODE_KIND) != 0 && CNODE_W(current, CNODE_KIND) != 4)
            continue;
        u16 index = CNODE_W(current, CNODE_FIRST_OP), count = CNODE_W(current, CNODE_OP_COUNT);
        u16 op = index << 2, history = CNODE_W(current, CNODE_HISTORY);
        for (; count; ++index, --count, op += 4) {
            for (; history < HISTORY_END_OFFSET && RHIST_W(history, RHIST_INSN_INDEX) == index; history += 9) {
                switch (RHIST_B(history, RHIST_ACTION)) {
                case 6:
                    SLOT_VALUE(COP_SC(RHIST_W(history, RHIST_VALUE_OP) << 2, COP_REGISTER)) = 0;
                    /* fall through */
                case 2:
                case 3:
                    SLOT_VALUE(SB(MK_FP(REG_HISTORY_POOL_SEG, history + RHIST_REGISTER))) = 0;
                    break;
                }
            }
            if (COP_B(op, COP_FLAGS) & 0x41)
                continue;
            farptr entry = ENTRY(COP_B(op, COP_OPCODE));
            u32 flags = ENTRY_FLAGS(entry);
            if (COP_B(op, COP_REGISTER) != 0xFF) {
                /* an op computed into a register: dropped if the register already holds the
                   same value, else the register now holds it (for the register-copy ops
                   97h-99h the value is their left operand) */
                u16 value = index;
                i8 reg = (i8)FIND_ASSIGNED_REGISTER(index);
                if (COP_B(op, COP_OPCODE) >= 0x97 && COP_B(op, COP_OPCODE) <= 0x99)
                    value = OPND_W(op, OPND_LEFT);
                if (REGISTER_HOLDS_VALUE(SLOT_VALUE(reg), value, SLOT_STAMP(reg)))
                    COP_B(op, COP_FLAGS) |= 0x40;
                else {
                    SLOT_VALUE(reg) = value;
                    SLOT_STAMP(reg) = PEEPHOLE_STORE_STAMP;
                }
            } else if (flags & 0x100) {
                /* the op leaves its own value in its left operand's register */
                i8 reg = (i8)GET_ASSIGNED_REGISTER(OPND_W(op, OPND_LEFT));
                if (reg != -1) {
                    if (REGISTER_HOLDS_VALUE(SLOT_VALUE(reg), index, SLOT_STAMP(reg)))
                        COP_B(op, COP_FLAGS) |= 0x40;
                    else {
                        SLOT_VALUE(reg) = index;
                        SLOT_STAMP(reg) = PEEPHOLE_STORE_STAMP;
                    }
                }
            }
            if (COP_B(op, COP_FLAGS) & 2) {
                /* a store: a variable target gets the new stamp and loses any register copy;
                   when the op writes the value of a right operand in a register, that register
                   now holds the variable.  A register target forgets its slot; any other target
                   is a store through a pointer */
                ++PEEPHOLE_STORE_STAMP;
                u16 left = OPND_W(op, OPND_LEFT) << 2;
                u32 target_flags = ENTRY_FLAGS(ENTRY(COP_B(left, COP_OPCODE)));
                if (target_flags & 1) {
                    u16 node = OPND_W(left, OPND_LEFT);
                    VAR_W(node, VAR_STORE_STAMP) = PEEPHOLE_STORE_STAMP;
                    if (VAR_B(node, VAR_FLAGS) & 2)
                        SLOT_VALUE((i8)VAR_B(node, VAR_REGISTER)) = 0;
                    u16 right = OPND_W(op, OPND_RIGHT);
                    if ((flags & 4) && right && COP_B(right << 2, COP_REGISTER) != 0xFF) {
                        i8 reg = (i8)FIND_ASSIGNED_REGISTER(right);
                        SLOT_VALUE(reg) = OPND_W(op, OPND_LEFT);
                        SLOT_STAMP(reg) = PEEPHOLE_STORE_STAMP;
                    }
                } else if (target_flags & 0x20)
                    SLOT_VALUE(OPND_W(left, OPND_LEFT)) = 0;
                else if (!OPTION_SUPPRESS_RELOADS)
                    PEEPHOLE_MEMORY_STORE_STAMP = PEEPHOLE_STORE_STAMP;
                redundant_operand(OPND_W(op, OPND_RIGHT), ENTRY_TAIL(entry, 3));
            } else if (!(flags & 0x429) && (COP_B(op, COP_OPCODE) < 0x97 || COP_B(op, COP_OPCODE) > 0x99)) {
                /* an ordinary operation: folded memory operands become registers holding the
                   same value */
                redundant_operand(OPND_W(op, OPND_LEFT), ENTRY_TAIL(entry, 2));
                redundant_operand(OPND_W(op, OPND_RIGHT), ENTRY_TAIL(entry, 3));
            }
            if (flags & 0x400)
                CLEAR_REGISTER_SLOTS();
            else if (ENTRY_TAIL(entry, 5))
                CLEAR_SLOTS_BY_MASK(REGISTER_MASK_TABLE_AT(ENTRY_TAIL(entry, 5)));
        }
    }
}

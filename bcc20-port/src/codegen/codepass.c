/* codepass.c: from bcc20/src/codegen/CODEPASS.C (overlay CO05F): passes over the code ops
   that run before register allocation, and the register masks the allocators use.
   Register masks have bit n for register n (0 AX, 1 AH, 2 DX, 3 DH, 4 BX, 5 BH, 6 CX, 7 CH,
   8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 14 CS, 15 SS, probably; a word register's low byte
   shares its number).  1355h (AX, DX, BX, CX, SI, DI, ES) are the registers the allocator
   may hand out, 55h those with byte halves.  CODEGEN_USED_REG_MASK collects the registers
   the function uses.
   SIMPLIFY_ZERO_CONST_INSNS removes AND/OR/XOR with a zero constant.
   MAP_SEGMENTS_MARK_OPERANDS replaces segment-of-symbol ops by the segment register that
   already holds it, then decides for every op which operands the x86 instruction can take
   directly (a register variable, an immediate, one memory operand, a segment register)
   instead of a separate load: such operand ops are marked folded (COP_FLAGS 1) and emitted
   inside their parent's instruction.  Address arithmetic under an indirect access is
   folded into the addressing mode [BX|BP + SI|DI + displacement] by
   MARK_ADDRESS_REGISTERS.  The mode masks passed to MARK_OPERAND_FOR_MODE are, probably:
   1 register operand, 2 immediate, 4 memory, 8 segment register; it returns the forms
   still allowed for the other operand (an x86 instruction has at most one memory
   operand). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_OVERLAY_CODE B(OPTION_OVERLAY_CODE_P)
#define OPTION_TARGET_CPU B(OPTION_TARGET_CPU_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)

/* an op's table entry: its flag word, operand size byte (+4) and the byte after it */
#define OP_FLAG_WORD(op) W(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))
#define OP_SIZE(op) B(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19 + 4))
#define OP_INFO(op) B(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19 + 5))

/* SIMPLIFY_BLOCK_ZERO_CONSTS on every code and switch block of the current function */
void SIMPLIFY_ZERO_CONST_INSNS(void)
{
    for (u16 node = CODE_BLOCK_LIST_HEAD; node; node = CNODE_W(node, CNODE_NEXT))
        switch (CNODE_W(node, CNODE_KIND)) {
        case 0:
        case 4:
            SIMPLIFY_BLOCK_ZERO_CONSTS(node);
        }
}

static int is_zero_constant(u16 slot)
{
    return (COP_B(slot, COP_OPCODE) == 10 || COP_B(slot, COP_OPCODE) == 9) &&
           OPND_L(slot, OPND_CONST_VALUE) == 0;
}

/* walks the ops of block node from the last to the first, skipping ops that work in place
   (COP_FLAGS 2).  x AND 0 (4Ah/4Bh) becomes the constant 0 itself, and x OR 0 / x XOR 0
   (4Dh/4Fh) a plain copy of x (99h for words, 97h for bytes); the zero constant is marked
   dead and, for AND, x no longer counts as used.  The block's first op (count 1) is left
   alone.  Op 14 (the parameter area address) sets ASM_OUTPUT_FLAGS bit 4, which makes
   EMIT_PROLOGUE build a BP frame */
void SIMPLIFY_BLOCK_ZERO_CONSTS(u16 node)
{
    u16 count = CNODE_W(node, CNODE_OP_COUNT);
    u16 slot = (CNODE_W(node, CNODE_FIRST_OP) + count - 1) * 4;
    for (; count; count--, slot -= 4) {
        if (COP_B(slot, COP_FLAGS) & 2)
            continue;
        u8 op = COP_B(slot, COP_OPCODE);
        u8 size = OP_SIZE(op);
        switch (op) {
        case 14:
            ASM_OUTPUT_FLAGS |= 4;
            break;
        case 0x4A:
        case 0x4B: {
            if (count <= 1)
                break;
            u16 right = OPND_W(slot, OPND_RIGHT) * 4;
            u16 left = OPND_W(slot, OPND_LEFT) * 4;
            if (is_zero_constant(right)) {
                COP_B(right, COP_FLAGS) |= 0x40;
                COP_B(left, COP_FLAGS) &= 0xF7;
                COP_B(slot, COP_OPCODE) = COP_B(right, COP_OPCODE);
                OPND_L(slot, OPND_CONST_VALUE) = 0;
                break;
            }
            if (!is_zero_constant(left))
                break;
            COP_B(left, COP_FLAGS) |= 0x40;
            COP_B(right, COP_FLAGS) &= 0xF7;
            COP_B(slot, COP_OPCODE) = COP_B(left, COP_OPCODE);
            OPND_L(slot, OPND_CONST_VALUE) = 0;
            break;
        }
        case 0x4D:
        case 0x4F: {
            if (count <= 1)
                break;
            u16 right = OPND_W(slot, OPND_RIGHT) * 4;
            u16 left = OPND_W(slot, OPND_LEFT) * 4;
            if (is_zero_constant(right)) {
                COP_B(right, COP_FLAGS) |= 0x40;
                OPND_W(slot, OPND_RIGHT) = 0;
                COP_B(slot, COP_OPCODE) = size == 2 ? 0x99 : 0x97;
                break;
            }
            if (is_zero_constant(left)) {
                COP_B(left, COP_FLAGS) |= 0x40;
                OPND_W(slot, OPND_LEFT) = OPND_W(slot, OPND_RIGHT);
                OPND_W(slot, OPND_RIGHT) = 0;
                COP_B(slot, COP_OPCODE) = size == 2 ? 0x99 : 0x97;
            }
        }
        }
    }
}

/* marks every register but SI and DI as used and returns the old mask (around the first
   ASSIGN_REGISTER_VARIABLES, so that round can only hand out SI and DI) */
u16 RESERVE_ALL_REGISTERS(void)
{
    u16 value = CODEGEN_USED_REG_MASK;
    CODEGEN_USED_REG_MASK |= 0xFCFF;
    return value;
}

/* puts back the mask RESERVE_ALL_REGISTERS saved, keeping the SI/DI bits the
   register-variable round set */
void RESTORE_RESERVED_REGISTERS(u16 value)
{
    CODEGEN_USED_REG_MASK &= 0x0300;
    CODEGEN_USED_REG_MASK |= value;
}

/* the allocatable registers not used yet.  A used high byte marks its whole register used,
   and the registers never handed out (high bytes, BP, SP, DS, CS, SS: ECAAh) are added to
   CODEGEN_USED_REG_MASK */
u16 FREE_REGISTER_MASK(void)
{
    CODEGEN_USED_REG_MASK |= (CODEGEN_USED_REG_MASK & 0xAA) >> 1;
    CODEGEN_USED_REG_MASK |= 0xECAA;
    return 0x1355 & ~CODEGEN_USED_REG_MASK;
}

/* the allocatable registers not taken by the register variables of scope block node */
u16 BLOCK_FREE_REGISTERS(u16 node)
{
    return 0x1355 & ~CNODE_W(node, CNODE_SCOPE_OWN_REGS);
}

/* the allocatable registers: AX, DX, BX, CX, SI, DI, ES */
i16 ALL_REGISTERS_MASK(void)
{
    return 0x1355;
}

/* the registers with byte halves: AX, DX, BX, CX */
i16 BYTE_REGISTERS_MASK(void)
{
    return 0x55;
}

/* the register class meaning exactly register value: value+1 for a 1-byte operand (mode
   1), value+9 otherwise */
i16 REGISTER_HINT_CODE(i8 value, u16 mode)
{
    if (mode == 1)
        return value + 1;
    return value + 9;
}

/* the register class for an op of size mode whose class was value: 11 for operands bigger
   than a byte, else 9 when class value is a word class (REG_CLASS_IS_WORD), else 1 */
i16 OP3_REGISTER_HINT(i16 mode, u16 value)
{
    if (mode > 1)
        return 11;
    if (B(DSPTR(value + FP_OFF(REG_CLASS_IS_WORD_P))) != 0)
        return 9;
    return 1;
}

/* true when op value is a folded indirect memory operand (ops 15h-1Bh, COP_FLAGS 1) and
   mode has any of bits 310h */
u16 IS_MARKED_MEM_OPERAND(u16 mode, u16 value)
{
    u16 slot = value << 2;
    return COP_B(slot, COP_OPCODE) >= 0x15 && COP_B(slot, COP_OPCODE) <= 0x1B &&
           (COP_B(slot, COP_FLAGS) & 1) && (mode & 0x310);
}

/* the live pair high word 1Bh, low word 16h of an indirect long read at op record node,
   when one of them is folded or the first one's register class is not 15h */
static u16 long_mem_pair(u16 node, int check_first_dead)
{
    if (COP_B(node, COP_OPCODE) != 0x1B || COP_B(node + 4, COP_OPCODE) != 0x16)
        return 0;
    if (check_first_dead && (COP_B(node, COP_FLAGS) & 0x40))
        return 0;
    if (COP_B(node + 4, COP_FLAGS) & 0x40)
        return 0;
    if (check_first_dead && (COP_B(node, COP_FLAGS) & 1))
        return 1;
    if (COP_B(node + 4, COP_FLAGS) & 1)
        return 1;
    if (COP_B(node, COP_REG_CLASS) != 0x15)
        return 1;
    return 0;
}

/* for op record node: true for the register copies 97h/98h, and for the long pair above
   (either op folded, neither dead) */
u16 IS_OP_97_98_OR_LONG_PAIR(u16 node)
{
    if (COP_B(node, COP_OPCODE) == 0x98 || COP_B(node, COP_OPCODE) == 0x97)
        return 1;
    return long_mem_pair(node, 1);
}

/* the same test for the 1Bh/16h pair alone (only the second op's flags are looked at) */
u16 IS_LONG_MEM_PAIR(u16 node)
{
    return long_mem_pair(node, 0);
}

/* first, every segment-of-symbol op (12) whose symbol lives in the code segment becomes
   register op CS (14; not with overlays, where code can move), and one in DGROUP data or
   BSS becomes DS (13), unless the variable has flag 1.  Then MARK_BLOCK_OPERANDS runs on
   every code and switch block */
void MAP_SEGMENTS_MARK_OPERANDS(void)
{
    u16 slot = 4;
    for (u16 count = CODE_OP_NEXT_INDEX - 1; count; count--, slot += 4) {
        if (COP_B(slot, COP_OPCODE) != 12 || VAR_W(OPND_W(slot, OPND_VARIABLE), VAR_SYMBOL) == 0)
            continue;
        u16 variable = OPND_W(slot, OPND_VARIABLE);
        if (VAR_W(variable, VAR_SEGMENT) == CODE_SEGMENT_ID) {
            if (OPTION_OVERLAY_CODE)
                continue;
            OPND_W(slot, OPND_LEFT) = 14;
        } else {
            if (VAR_B(variable, VAR_FLAGS) & 1)
                continue;
            if (VAR_W(variable, VAR_SEGMENT) != DATA_SEGMENT_ID &&
                (VAR_W(variable, VAR_SEGMENT) != BSS_SEGMENT_ID || DATA_BSS_GROUPS_DIFFER != 0))
                continue;
            OPND_W(slot, OPND_LEFT) = 13;
        }
        COP_B(slot, COP_OPCODE) = 8;
    }
    for (u16 node = CODE_BLOCK_LIST_HEAD; node; node = CNODE_W(node, CNODE_NEXT))
        switch (CNODE_W(node, CNODE_KIND)) {
        case 0:
        case 4:
            MARK_BLOCK_OPERANDS(node);
        }
}

/* the two halves of a far pointer called through (76h) stay folded only when both are
   folded and are the two words of the same thing: indirect reads 16h/1Bh of the same
   address and segment, or leaves 10h/11h of the same variable at offsets 2 apart */
static int far_halves_paired(u16 left, u16 right)
{
    if (COP_B(left, COP_OPCODE) == 0x16 && COP_B(right, COP_OPCODE) == 0x1B &&
        OPND_W(right, OPND_LEFT) == OPND_W(left, OPND_LEFT) &&
        OPND_W(right, OPND_RIGHT) == OPND_W(left, OPND_RIGHT) &&
        (COP_B(right, COP_FLAGS) & 1) && (COP_B(left, COP_FLAGS) & 1))
        return 1;
    if (COP_B(left, COP_OPCODE) == 0x10 && COP_B(right, COP_OPCODE) == 0x11 &&
        OPND_W(left, 0) == OPND_W(right, 0) &&
        OPND_W(left, 2) == (u16)(OPND_W(right, 2) - 2) &&
        (COP_B(right, COP_FLAGS) & 1) && (COP_B(left, COP_FLAGS) & 1))
        return 1;
    return 0;
}

/* for each op of block node (last to first): clears its register and register class for
   the allocator, then (unless it is folded, dead, a leaf, a constant or a raw-word op)
   marks the operands its instruction can take directly.  info is the byte after the op's
   operand size; operands of another small size are not folded.  8087 ops take one memory
   operand; indirect accesses fold their address and segment parts; shifts fold a constant
   count (any count on a 186, up to 3 on the 8086) or a count in CL; POP, PUSH (an immediate
   only on a 186), calls, LEA and MOV allow the forms the x86 has; compares take the
   operand with the higher op number first; other ops fold the left operand first when
   they work in place, else the right one */
void MARK_BLOCK_OPERANDS(u16 node)
{
    u16 count = CNODE_W(node, CNODE_OP_COUNT);
    u16 cursor = (CNODE_W(node, CNODE_FIRST_OP) + count - 1) * 4;
    for (; count; --count, cursor -= 4) {
        COP_B(cursor, COP_REGISTER) = 0xFF;
        COP_B(cursor, COP_REG_CLASS) = 0;
        if (COP_B(cursor, COP_FLAGS) & 0x41)
            continue;
        u8 op = COP_B(cursor, COP_OPCODE);
        u16 flags = OP_FLAG_WORD(op);
        i16 info = OP_INFO(op);
        if (flags & 0x29)
            continue;
        u16 mode = 7;
#define MARK(v, m) MARK_OPERAND_FOR_MODE((v), (m), flags, info)
        switch (op) {
        case 0x22: case 0x2B: case 0x2E: case 0x35: case 0x3A: case 0x3D: case 0x84:
            if (COP_B(cursor, COP_FLAGS) & 2)
                MARK(OPND_W(cursor, OPND_LEFT), 5);
            else
                MARK(OPND_W(cursor, OPND_RIGHT), 1);
            break;
        case 0x20: case 0x21: case 0x29: case 0x2A: case 0x2C: case 0x2D:
        case 0x33: case 0x34: case 0x38: case 0x39: case 0x3B: case 0x3C: case 0x82: case 0x83:
            if (COP_B(cursor, COP_FLAGS) & 2)
                MARK(OPND_W(cursor, OPND_LEFT), 5);
            else
                MARK(OPND_W(cursor, OPND_RIGHT), 5);
            break;
        case 0x5F: case 0x60: case 0x61: case 0x62: case 0x63: case 0x64:
        case 0x68: case 0x69: case 0x6A: case 0x6B: case 0x6C:
            MARK(OPND_W(cursor, OPND_LEFT), 5);
            break;
        case 0x15: case 0x16: case 0x17: case 0x18: case 0x19: case 0x1A: case 0x1B:
            MARK_ADDRESS_REGISTERS(OPND_W(cursor, OPND_LEFT));
            MARK_SEGMENT_REGISTER_OPERAND(OPND_W(cursor, OPND_RIGHT));
            break;
        case 0x44: case 0x45: case 0x46: case 0x47: case 0x48: case 0x49:
        case 0x55: case 0x56: case 0xD3: case 0xD4: {
            u16 right = OPND_W(cursor, OPND_RIGHT) * 4;
            if (COP_B(right, COP_OPCODE) == 9 || COP_B(right, COP_OPCODE) == 10) {
                if (OPTION_TARGET_CPU || D(MK_FP(CODE_OPERAND_POOL_SEG, right)) <= 3)
                    COP_B(right, COP_FLAGS) |= 1;
            } else if (NODE_REGISTER_NUMBER(right) == 6)
                COP_B(right, COP_FLAGS) |= 1;
            if ((COP_B(cursor, COP_FLAGS) & 2) == 0)
                mode = 0;
            MARK(OPND_W(cursor, OPND_LEFT), mode);
            break;
        }
        case 0x7F:
            MARK(OPND_W(cursor, OPND_LEFT), 13);
            break;
        case 0x76: {
            u16 right = OPND_W(cursor, OPND_RIGHT) * 4;
            u16 left = OPND_W(cursor, OPND_LEFT) * 4;
            MARK(OPND_W(cursor, OPND_RIGHT), 4);
            MARK(OPND_W(cursor, OPND_LEFT), 4);
            if (far_halves_paired(left, right))
                break;
            COP_B(right, COP_FLAGS) &= 0xFE;
            COP_B(left, COP_FLAGS) &= 0xFE;
            break;
        }
        case 0x93:
            MARK(OPND_W(cursor, OPND_LEFT), OPTION_TARGET_CPU == 0 ? 9 : 11);
            break;
        case 0x94:
            mode = OPTION_TARGET_CPU == 0 ? 13 : 15;
            /* fall through */
        case 0x75: case 0x77: case 0x78: case 0x95:
            MARK(OPND_W(cursor, OPND_LEFT), mode);
            break;
        case 0x98:
            MARK(OPND_W(cursor, OPND_LEFT), 15);
            break;
        case 0x80:
        case 0x81:
            if (OPND_W(cursor, OPND_LEFT) < OPND_W(cursor, OPND_RIGHT)) {
                mode = MARK(OPND_W(cursor, OPND_RIGHT), mode);
                if ((flags & 4) && (COP_B(cursor, COP_FLAGS) & 8))
                    break;
                MARK(OPND_W(cursor, OPND_LEFT), mode & 0xFFFD);
            } else {
                mode = MARK(OPND_W(cursor, OPND_LEFT), mode & 0xFFFD);
                if ((flags & 4) && (COP_B(cursor, COP_FLAGS) & 8))
                    break;
                MARK(OPND_W(cursor, OPND_RIGHT), mode);
            }
            break;
        case 2: case 3: case 0x6E: case 0x6F: case 0x70: case 0x71:
        case 0xB5: case 0xB6: case 0xBD: case 0xBE: case 0xBF: case 0xC0:
            break;
        case 0x9C:
            mode = 13;
            /* fall through */
        default:
            if ((flags & 0x40) || (COP_B(cursor, COP_FLAGS) & 2)) {
                mode = MARK(OPND_W(cursor, OPND_LEFT), mode & 0xFFFD);
                if ((flags & 4) && (COP_B(cursor, COP_FLAGS) & 8))
                    break;
                MARK(OPND_W(cursor, OPND_RIGHT), mode);
            } else {
                MARK(OPND_W(cursor, OPND_RIGHT), mode);
                MARK(OPND_W(cursor, OPND_LEFT), 0);
            }
            break;
        }
#undef MARK
    }
}

/* folds operand op node into its parent if its form is allowed by flags and returns the
   forms left for the other operand.  other is the parent's table flags (bit 4000h: it
   accepts an immediate), expected the parent's operand size.  Stack slots (B2h), indirect
   accesses, memory variables and register variables are handled by kind; frame variable
   addresses (13 of an auto or parameter) are never folded as immediates */
u16 MARK_OPERAND_FOR_MODE(u16 node, u16 flags, u16 other, i16 expected)
{
    if (!node)
        return 7;
    u16 entry = node * 4;
    u8 op = COP_B(entry, COP_OPCODE);
    if (op == 0xB2) {
        if (flags & 4) {
            COP_B(entry, COP_FLAGS) |= 1;
            return 3;
        }
        return 7;
    }
    i16 kind = OP_SIZE(op);
    if (expected && kind != expected && kind <= 3 && expected <= 3)
        return 7;
    u16 symbol;
    switch (op) {
    case 13:
        symbol = OPND_W(entry, OPND_LEFT);
        if (VAR_B(symbol, VAR_SYMBOL_KIND) == 5 || VAR_B(symbol, VAR_SYMBOL_KIND) == 6)
            return 7;
        /* fall through */
    case 9: case 10: case 12:
        if ((flags & 2) && (other & 0x4000))
            COP_B(entry, COP_FLAGS) |= 1;
        return 7;
    case 8:
        if (OPND_W(entry, OPND_LEFT) >= 12 && OPND_W(entry, OPND_LEFT) <= 15) {
            if (flags & 8)
                COP_B(entry, COP_FLAGS) |= 1;
            return 5;
        }
        /* fall through */
    case 7:
        if (flags & 1)
            COP_B(entry, COP_FLAGS) |= 1;
        return 7;
    case 21: case 22: case 23: case 24: case 25: case 26: case 27:
        if (flags & 4) {
            COP_B(entry, COP_FLAGS) |= 1;
            MARK_ADDRESS_REGISTERS(OPND_W(entry, OPND_LEFT));
            MARK_SEGMENT_REGISTER_OPERAND(OPND_W(entry, OPND_RIGHT));
            return (flags & 9) | 2;
        }
        break;
    case 15:
        symbol = OPND_W(entry, OPND_LEFT);
        if (VAR_B(symbol, VAR_FLAGS) & 2) {
            if (VAR_SC(symbol, VAR_REGISTER) > 7)
                return 7;
            if (flags & 1)
                COP_B(entry, COP_FLAGS) |= 1;
            return 7;
        }
        if (flags & 4) {
            COP_B(entry, COP_FLAGS) |= 1;
            return 3;
        }
        break;
    case 16: case 17: case 18: case 19: case 20:
        symbol = OPND_W(entry, OPND_LEFT);
        if (VAR_B(symbol, VAR_FLAGS) & 2) {
            if (VAR_SC(symbol, VAR_REGISTER) >= 12 && VAR_SC(symbol, VAR_REGISTER) <= 15) {
                if (flags & 8)
                    COP_B(entry, COP_FLAGS) |= 1;
                return 5;
            }
            if (flags & 1)
                COP_B(entry, COP_FLAGS) |= 1;
            return (flags & 9) | 7;
        }
        if (flags & 4) {
            COP_B(entry, COP_FLAGS) |= 1;
            return (flags & 9) | 2;
        }
        break;
    }
    return (flags & 9) | 7;
}

/* the register of op record value when it is a register op (7, 8) or a leaf (0Fh-11h) of
   a register variable; else 0 (which is also AX's number) */
u16 NODE_REGISTER_NUMBER(u16 value)
{
    u8 op = COP_B(value, COP_OPCODE);
    if (op == 8 || op == 7)
        return OPND_W(value, OPND_LEFT);
    if ((op == 0x10 || op == 0x11 || op == 0x0F) && (VAR_B(OPND_W(value, OPND_LEFT), VAR_FLAGS) & 2))
        return (u16)(i16)VAR_SC(OPND_W(value, OPND_LEFT), VAR_REGISTER);
    return 0;
}

/* true when op record value can be the displacement of an address: a word constant (0Ah),
   a symbol segment (0Ch) or the address of a global (0Dh not of an auto or parameter) */
i16 HAS_CONSTANT_ADDRESS_PART(u16 value)
{
    if (COP_B(value, COP_OPCODE) == 0x0A || COP_B(value, COP_OPCODE) == 0x0C)
        return 1;
    if (COP_B(value, COP_OPCODE) == 0x0D) {
        u8 kind = VAR_B(OPND_W(value, OPND_LEFT), VAR_SYMBOL_KIND);
        return !(kind == 5 || kind == 6);
    }
    return 0;
}

/* true when op record value is the address (0Dh) of an auto or parameter, BP plus a
   constant */
i16 IS_FRAME_VARIABLE_NODE(u16 value)
{
    if (COP_B(value, COP_OPCODE) != 0x0D)
        return 0;
    u8 kind = VAR_B(OPND_W(value, OPND_LEFT), VAR_SYMBOL_KIND);
    return kind == 5 || kind == 6;
}

/* folds segment op value (an op number) when it is already in a segment register (12-15),
   so it becomes a segment override */
void MARK_SEGMENT_REGISTER_OPERAND(u16 value)
{
    if (value) {
        u16 slot = value << 2;
        if (NODE_REGISTER_NUMBER(slot) >= 12 && NODE_REGISTER_NUMBER(slot) <= 15)
            COP_B(slot, COP_FLAGS) |= 1;
    }
}

/* folds the parts of address op node that the addressing mode can hold: a register op or
   register variable in BX, SI, DI or BP, a constant or variable address, and for an
   addition (op 31, unless COP_FLAGS 10h) one base register, one index register and a
   constant part.  A frame variable address may join SI or DI (BP+SI/DI+offset); BX with
   BX is not combined.  Each folded op gets COP_FLAGS 1 */
void MARK_ADDRESS_REGISTERS(u16 node)
{
    u16 cursor = node * 4;
    if (COP_B(cursor, COP_FLAGS) & 2)
        return;
    switch (COP_B(cursor, COP_OPCODE)) {
    case 8:
        switch (OPND_W(cursor, OPND_REGISTER)) {
        case 4: case 8: case 9: case 10:
            COP_B(cursor, COP_FLAGS) |= 1;
            COP_B(cursor, COP_REGISTER) = OPND_B(cursor, OPND_REGISTER);
        }
        return;
    case 16: {
        u16 variable = OPND_W(cursor, OPND_VARIABLE);
        if (VAR_B(variable, VAR_FLAGS) & 2)
            switch (VAR_SC(variable, VAR_REGISTER)) {
            case 4: case 8: case 9: case 10:
                COP_B(cursor, COP_FLAGS) |= 1;
            }
        return;
    }
    case 10:
    case 13:
        COP_B(cursor, COP_FLAGS) |= 1;
        return;
    case 31:
        break;
    default:
        return;
    }
    if (COP_B(cursor, COP_FLAGS) & 0x10)
        return;
    u16 left = OPND_W(cursor, OPND_LEFT) * 4;
    u16 right = OPND_W(cursor, OPND_RIGHT) * 4;
    if (HAS_CONSTANT_ADDRESS_PART(right)) {
        MARK_ADDRESS_REGISTERS(OPND_W(cursor, OPND_LEFT));
        goto mark_right;
    }
    if (HAS_CONSTANT_ADDRESS_PART(left)) {
        MARK_ADDRESS_REGISTERS(OPND_W(cursor, OPND_RIGHT));
        COP_B(left, COP_FLAGS) |= 1;
        goto mark_current;
    }
    switch (NODE_REGISTER_NUMBER(left)) {
    case 4:
        return;
    case 8:
    case 9:
        if (IS_FRAME_VARIABLE_NODE(right))
            COP_B(right, COP_FLAGS) |= 1;
        COP_B(left, COP_FLAGS) |= 1;
        goto mark_current;
    case 10: {
        u16 kind = NODE_REGISTER_NUMBER(right);
        if (kind == 8 || kind == 9)
            COP_B(right, COP_FLAGS) |= 1;
        COP_B(left, COP_FLAGS) |= 1;
        goto mark_current;
    }
    }
    switch (NODE_REGISTER_NUMBER(right)) {
    case 8:
    case 9:
        if (IS_FRAME_VARIABLE_NODE(left))
            COP_B(left, COP_FLAGS) |= 1;
        /* fall through */
    case 4:
    case 10:
        goto mark_right;
    }
    return;
mark_right:
    COP_B(right, COP_FLAGS) |= 1;
mark_current:
    COP_B(cursor, COP_FLAGS) |= 1;
}

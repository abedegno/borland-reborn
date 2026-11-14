/* emitinsn.c: from bcc20/src/codegen/EMITINSN.C: the bottom of the code generator's emit
   path.  Every instruction the back end produces goes through one of the EMIT_INSN_*
   builders here: each fills the two operand records FIRST_ASM_OPERAND and
   SECOND_ASM_OPERAND (the records the inline assembler uses) and passes an instruction
   number to EMIT_INSN_OPTIMIZED, which applies a few last-moment rewrites and calls
   EMIT_INSTRUCTION_HOOK.  An operand record is 9 bytes: kind word (0 none, 1 register, 2
   offset of a symbol plus displacement, 3 segment of a symbol, 4 immediate, 5 memory),
   segment override register (+2), index register (+3), base or plain register (+4),
   displacement or immediate (+5), symbol (+7); FFh means no register.  Registers: 0 AX, 2
   DX, 4 BX, 6 CX, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 14 CS, 15 SS.  OPERAND_FROM_NODE
   turns a code op into an operand record; ADD_NODE_TO_OPERAND folds address arithmetic
   into one record.  Operand records are passed by their DS offsets. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define INSN_57_PENDING B(INSN_57_PENDING_P)
#define INSN_9C_DEFERRED B(INSN_9C_DEFERRED_P)
#define FIRST FP_OFF(FIRST_ASM_OPERAND_P)
#define SECOND FP_OFF(SECOND_ASM_OPERAND_P)
#define DEFERRED FP_OFF(INSN_9C_DEFERRED_OPERAND_P)
#define KIND(o) W(DSPTR(o))
#define SEG(o) SB(DSPTR((o) + 2))
#define INDEX(o) SB(DSPTR((o) + 3))
#define REG(o) SB(DSPTR((o) + 4))
#define NUMBER(o) SW(DSPTR((o) + 5))
#define SYMBOL(o) W(DSPTR((o) + 7))
#define OPERAND_SIZE 9

static void hook(u16 kind)
{
    CALL_FAR(EMIT_INSTRUCTION_HOOK, A16(kind));
}

static void copy_bytes(u16 to, u16 from, u16 n)
{
    for (u16 i = 0; i < n; ++i)
        B(DSPTR(to + i)) = B(DSPTR(from + i));
}

/* instruction value with no operands */
void EMIT_INSN_NO_OPERANDS(u16 value)
{
    KIND(FIRST) = 0;
    KIND(SECOND) = 0;
    EMIT_INSN_OPTIMIZED((i16)value);
}

/* instruction value1 with operands [BP+value2] and register value3 */
void EMIT_INSN_STACK_REG(u16 value1, u16 value2, u8 value3)
{
    RTL_MEMSET(FIRST_ASM_OPERAND_P, 0, 9);
    FIRST_OPERAND_INDEX_REG = 0xFF;
    FIRST_OPERAND_SEG_REG = 0xFF;
    KIND(FIRST) = 5;
    FIRST_OPERAND_REG = 10;
    FIRST_OPERAND_VALUE = value2;
    KIND(SECOND) = 1;
    SECOND_OPERAND_REG = value3;
    EMIT_INSN_OPTIMIZED((i16)value1);
}

/* the reverse order: register value2, then [BP+value3] */
void EMIT_INSN_REG_STACK(u16 value1, u8 value2, u16 value3)
{
    RTL_MEMSET(SECOND_ASM_OPERAND_P, 0, 9);
    SECOND_OPERAND_INDEX_REG = 0xFF;
    SECOND_OPERAND_SEG_REG = 0xFF;
    KIND(SECOND) = 5;
    SECOND_OPERAND_REG = 10;
    SECOND_OPERAND_VALUE = value3;
    KIND(FIRST) = 1;
    FIRST_OPERAND_REG = value2;
    EMIT_INSN_OPTIMIZED((i16)value1);
}

/* instruction value with the single register operand mode */
void EMIT_INSN_REG(u16 value, u8 mode)
{
    KIND(FIRST) = 1;
    FIRST_OPERAND_REG = mode;
    KIND(SECOND) = 0;
    EMIT_INSN_OPTIMIZED((i16)value);
}

/* instruction first whose one operand is code op second */
void EMIT_INSN_NODE(u16 first, u16 second)
{
    OPERAND_FROM_NODE(FIRST, second);
    KIND(SECOND) = 0;
    EMIT_INSN_OPTIMIZED((i16)first);
}

/* value with register operands second (destination) and third.  When both are segment
   registers there is no such move on the x86: PUSH third / POP second, or nothing if they
   are the same */
void EMIT_INSN_REG_REG(u16 value, i8 second, i8 third)
{
    if (second >= 12 && third >= 12) {
        if (second != third) {
            EMIT_INSN_REG(0x94, (u8)third);
            EMIT_INSN_REG(0x7F, (u8)second);
        }
        return;
    }
    KIND(FIRST) = 1;
    FIRST_OPERAND_REG = (u8)second;
    KIND(SECOND) = 1;
    SECOND_OPERAND_REG = (u8)third;
    EMIT_INSN_OPTIMIZED((i16)value);
}

/* value with register mode and code op flags; an op that sits in a register goes through
   EMIT_INSN_REG_REG so segment-register moves are handled */
void EMIT_INSN_REG_NODE(u16 value, u8 mode, u16 flags)
{
    KIND(FIRST) = 1;
    FIRST_OPERAND_REG = mode;
    OPERAND_FROM_NODE(SECOND, flags);
    if (KIND(SECOND) == 1)
        EMIT_INSN_REG_REG(value, (i8)FIRST_OPERAND_REG, (i8)SECOND_OPERAND_REG);
    else
        EMIT_INSN_OPTIMIZED((i16)value);
}

/* value with register mode and immediate detail */
void EMIT_INSN_REG_IMM(u16 value, u8 mode, u16 detail)
{
    KIND(FIRST) = 1;
    FIRST_OPERAND_REG = mode;
    KIND(SECOND) = 4;
    SECOND_OPERAND_VALUE = detail;
    EMIT_INSN_OPTIMIZED((i16)value);
}

/* value with code op index then register mode */
void EMIT_INSN_NODE_REG(u16 value, u16 index, u8 mode)
{
    OPERAND_FROM_NODE(FIRST, index);
    KIND(SECOND) = 1;
    SECOND_OPERAND_REG = mode;
    EMIT_INSN_OPTIMIZED((i16)value);
}

/* instruction third with code ops second (first operand) and first (second operand) */
void EMIT_INSN_NODE_NODE(u16 third, u16 second, u16 first)
{
    OPERAND_FROM_NODE(FIRST, second);
    OPERAND_FROM_NODE(SECOND, first);
    EMIT_INSN_OPTIMIZED((i16)third);
}

/* value with code op index and immediate detail */
void EMIT_INSN_NODE_IMM(u16 value, u16 index, u16 detail)
{
    OPERAND_FROM_NODE(FIRST, index);
    KIND(SECOND) = 4;
    SECOND_OPERAND_VALUE = detail;
    EMIT_INSN_OPTIMIZED((i16)value);
}

/* value1 with one operand, the frame slot [BP+offset] of variable-table entry value2 (8087
   spill temporaries) */
void EMIT_INSN_LOCAL(u16 value1, u16 value2)
{
    RTL_MEMSET(FIRST_ASM_OPERAND_P, 0, 9);
    KIND(FIRST) = 5;
    FIRST_OPERAND_REG = 10;
    FIRST_OPERAND_INDEX_REG = 0xFF;
    FIRST_OPERAND_SEG_REG = 0xFF;
    FIRST_OPERAND_VALUE = VAR_W(value2, VAR_FRAME_OFFSET);
    KIND(SECOND) = 0;
    EMIT_INSN_OPTIMIZED((i16)value1);
}

/* last-moment rewrites of instruction kind with the operands already in place, then the
   output hook.  A MOV ES,memory is held back in INSN_9C_DEFERRED_OPERAND; if the next
   instruction is MOV word reg,[same address-2] the pair becomes LES reg,[address], otherwise
   the held move is emitted first.  FWAIT is only noted in INSN_57_PENDING and emitted
   before the next instruction that needs it.  Size optimisations: compare with 0 becomes
   4Ch/4Dh (OR of the register with itself), MOV reg,0 becomes 4Fh (XOR), a move of a
   register to itself is dropped, ADD/SUB by 1, -1 (and 2 for word registers) become INC/DEC
   instructions, and AEh/B1h emit nothing */
void EMIT_INSN_OPTIMIZED(i16 kind)
{
    if (INSN_9C_DEFERRED) {
        if (kind == 0x9C && REG(DEFERRED) == REG(SECOND) && INDEX(DEFERRED) == INDEX(SECOND) && SEG(DEFERRED) == SEG(SECOND)
            && SYMBOL(DEFERRED) == SYMBOL(SECOND) && (i16)(NUMBER(SECOND) + 2) == NUMBER(DEFERRED))
            kind = 0x96;
        else {
            u8 saved[27];
            for (int i = 0; i < 27; ++i)
                saved[i] = B(DSPTR(FIRST + i));
            KIND(FIRST) = 1;
            FIRST_OPERAND_REG = 12;
            copy_bytes(SECOND, DEFERRED, OPERAND_SIZE);
            hook(0x9C);
            for (int i = 0; i < 27; ++i)
                B(DSPTR(FIRST + i)) = saved[i];
        }
        INSN_9C_DEFERRED = 0;
    }
    switch (kind) {
    case 0x57:
        INSN_57_PENDING = 1;
        return;
    case 0x80:
    case 0x81:
        if (KIND(FIRST) == 1 && KIND(SECOND) == 4 && NUMBER(SECOND) == 0) {
            kind -= 0x34;
            KIND(SECOND) = 1;
            REG(SECOND) = (i8)FIRST_OPERAND_REG;
        }
        break;
    case 0x93:
        kind = 0x94;
        break;
    case 0x98:
    case 0x99:
    case 0x9C:
        if (KIND(FIRST) == 1 && FIRST_OPERAND_REG == 12 && KIND(SECOND) == 5) {
            copy_bytes(DEFERRED, SECOND, OPERAND_SIZE);
            INSN_9C_DEFERRED = 1;
            return;
        }
        if (KIND(FIRST) == 1 && KIND(SECOND) == 4 && NUMBER(SECOND) == 0) {
            kind = 0x4F;
            KIND(SECOND) = 1;
            REG(SECOND) = (i8)FIRST_OPERAND_REG;
            break;
        }
        /* fall through */
    case 0x97:
    case 0x9B:
        /* MOV between registers: a move to the same register dropped; a byte move whose source
           is register 8 or above (no byte form) made a word MOV */
        if (KIND(FIRST) == 1 && KIND(SECOND) == 1) {
            if ((i8)FIRST_OPERAND_REG == REG(SECOND))
                return;
            if (kind != 0x9C && kind != 0x98 && REG(SECOND) > 7)
                kind = 0x9C;
        }
        break;
    case 0x1E:
    case 0x1F:
    case 0x27:
    case 0x28: {
        /* ADD (1Eh/1Fh) by 1 -> INC (58h/59h), by -1 -> DEC (5Ah/5Bh), a word register by 2 ->
           two INCs; SUB (27h/28h) the same with INC and DEC exchanged */
        u8 add = kind == 0x1E || kind == 0x1F;
        if (KIND(SECOND) == 4) {
            if (NUMBER(SECOND) == 1) {
                KIND(SECOND) = 0;
                kind += add ? 0x3A : 0x33;
            } else if (NUMBER(SECOND) == 2 && KIND(FIRST) == 1 && kind == (add ? 0x1F : 0x28)) {
                KIND(SECOND) = 0;
                kind += add ? 0x3A : 0x33;
                EMIT_INSN_OPTIMIZED(kind);
            } else if (NUMBER(SECOND) == -1) {
                KIND(SECOND) = 0;
                kind += add ? 0x3C : 0x31;
            }
        }
        break;
    }
    case 0xAE:
    case 0xB1:
        return;
    }
    FLUSH_PENDING_MARKER((u16)kind);
    hook((u16)kind);
}

/* if an FWAIT is pending, decides before instruction kind whether it must be emitted now:
   when kind touches memory, is one of 7Eh, 7Fh (POP), A1h, A2h, A3h, or uses SP.  The FWAIT
   itself is skipped when kind has table flag 2 (an 8087 instruction, which waits by
   itself); either way the pending mark is then cleared */
void FLUSH_PENDING_MARKER(u16 kind)
{
    if (!INSN_57_PENDING)
        return;
    if (KIND(FIRST) == 5 || KIND(SECOND) == 5 || kind == 0x7E || kind == 0x7F || kind == 0xA3 || kind == 0xA2 || kind == 0xA1
        || (KIND(FIRST) == 1 && FIRST_OPERAND_REG == 11)) {
        if ((D(fp_add(CODE_OP_INFO_TABLE_P, kind * 19)) & 2) == 0) {
            u16 first = KIND(FIRST), second = KIND(SECOND);
            KIND(FIRST) = 0;
            KIND(SECOND) = 0;
            hook(0x57);
            KIND(FIRST) = first;
            KIND(SECOND) = second;
        }
        INSN_57_PENDING = 0;
    }
}

/* fills the operand record at output for code op node.  An op with an assigned register is
   a register operand.  Otherwise by opcode: register ops 7/8; B2h a stack slot relative to
   the frame; 13/7Ch the address of a variable (its BP-relative frame slot for autos and
   parameters, else the symbol's offset); 12/7Bh the segment of a symbol; 15-20 and calls
   77h/78h a variable with offset, or the register of a register variable (adjusted by the
   op's register class for byte or 8087 forms); 14 the parameter area; 21-27 an indirect
   operand built from the address op, with the right operand's register as segment override
   (27 reads the word at +2); 9-11 an immediate */
void OPERAND_FROM_NODE(u16 output, u16 node)
{
    RTL_MEMSET(DSPTR(output), 0, 9);
    SEG(output) = -1;
    REG(output) = -1;
    INDEX(output) = -1;
    u16 cell = node * 4;
    if (COP_B(cell, COP_REGISTER) != 0xFF) {
        KIND(output) = 1;
        REG(output) = (i8)COP_B(cell, COP_REGISTER);
        return;
    }
    switch (COP_B(cell, COP_OPCODE)) {
    case 7:
    case 8:
        KIND(output) = 1;
        REG(output) = (i8)OPND_B(cell, OPND_LEFT);
        return;
    case 0xB2:
        NUMBER(output) = (i16)(OPND_W(cell, OPND_LEFT) - FRAME_LOCALS_SIZE - FRAME_PUSHED_REG_BYTES);
        REG(output) = 10;
        break;
    case 13:
    case 0x7C:
        KIND(output) = 2;
        NUMBER(output) = (i16)OPND_W(cell, OPND_RIGHT);
        if (VAR_B(OPND_W(cell, OPND_LEFT), VAR_SYMBOL_KIND) == 5 || VAR_B(OPND_W(cell, OPND_LEFT), VAR_SYMBOL_KIND) == 6) {
            REG(output) = 10;
            NUMBER(output) = (i16)(NUMBER(output) + VAR_W(OPND_W(cell, OPND_LEFT), VAR_FRAME_OFFSET));
            break;
        }
        SYMBOL(output) = VAR_W(OPND_W(cell, OPND_LEFT), VAR_SYMBOL);
        return;
    case 12:
    case 0x7B:
        KIND(output) = 3;
        SYMBOL(output) = VAR_W(OPND_W(cell, OPND_LEFT), VAR_SYMBOL);
        return;
    case 15: case 16: case 17: case 18: case 19: case 20: case 0x77: case 0x78: {
        u16 symbol = OPND_W(cell, OPND_LEFT);
        if (VAR_B(symbol, VAR_SYMBOL_KIND) == 5 || VAR_B(symbol, VAR_SYMBOL_KIND) == 6) {
            if (VAR_B(symbol, VAR_FLAGS) & 2) {
                REG(output) = (i8)VAR_B(symbol, VAR_REGISTER);
                KIND(output) = 1;
                if ((D(fp_add(CODE_OP_INFO_TABLE_P, COP_B(cell, COP_OPCODE) * 19)) & 2) || REG(output) >= 16)
                    REG(output) = (i8)((COP_B(cell, COP_REG_CLASS) & 0x3F) + REG(output) + 0xF0);
                return;
            }
            NUMBER(output) = (i16)(OPND_W(cell, OPND_RIGHT) + VAR_W(symbol, VAR_FRAME_OFFSET));
            REG(output) = 10;
            break;
        }
        SYMBOL(output) = VAR_W(OPND_W(cell, OPND_LEFT), VAR_SYMBOL);
        NUMBER(output) = (i16)OPND_W(cell, OPND_RIGHT);
        break;
    }
    case 14:
        NUMBER(output) = (i16)(CODEGEN_PARAMS_SIZE + PARAM_FRAME_BASE);
        REG(output) = 10;
        break;
    case 21: case 22: case 23: case 24: case 25: case 26: case 27:
        ADD_NODE_TO_OPERAND(output, OPND_W(cell, OPND_LEFT));
        if (COP_B(cell, COP_OPCODE) == 27)
            NUMBER(output) = (i16)(NUMBER(output) + 2);
        if (OPND_W(cell, OPND_RIGHT)) {
            u16 child = OPND_W(cell, OPND_RIGHT) * 4;
            ASSIGN_NODE_REGISTER(child);
            SET_SEGMENT_OVERRIDE(output, COP_B(child, COP_REGISTER));
        }
        /* a segment override equal to the default dropped: DS unless the base is BP, SS when
           the base is BP */
        if (SEG(output) == 13) {
            if (REG(output) != 10)
                SEG(output) = -1;
        } else if (SEG(output) == 15 && REG(output) == 10)
            SEG(output) = -1;
        break;
    case 9:
    case 10:
    case 11:
        KIND(output) = 4;
        NUMBER(output) = (i16)OPND_W(cell, OPND_LEFT);
        return;
    }
    KIND(output) = 5;
}

/* for op record value with no register yet, copies in the register of a register op (8) or
   of a register variable named by a leaf op 10h/11h */
void ASSIGN_NODE_REGISTER(u16 value)
{
    if (COP_B(value, COP_REGISTER) != 0xFF)
        return;
    u8 reg;
    if (COP_B(value, COP_OPCODE) == 8)
        reg = OPND_B(value, OPND_LEFT);
    else {
        if (COP_B(value, COP_OPCODE) != 0x10 && COP_B(value, COP_OPCODE) != 0x11)
            return;
        if ((VAR_B(OPND_W(value, OPND_LEFT), VAR_FLAGS) & 2) == 0)
            return;
        reg = VAR_B(OPND_W(value, OPND_LEFT), VAR_REGISTER);
    }
    COP_B(value, COP_REGISTER) = reg;
}

/* adds address op node into operand record output: a register op gives the base (BP or BX)
   or index (SI or DI); a constant adds to the displacement; a variable address (13) adds its
   frame offset with BP as base, or sets the symbol; op 31 adds both sides recursively */
void ADD_NODE_TO_OPERAND(u16 output, u16 node)
{
    u16 cursor = node * 4;
    ASSIGN_NODE_REGISTER(cursor);
    u8 reg = COP_B(cursor, COP_REGISTER);
    if (reg != 0xFF) {
        if (reg == 10 || reg == 4)
            REG(output) = (i8)reg;
        else if (reg == 8 || reg == 9)
            INDEX(output) = (i8)reg;
        return;
    }
    switch (COP_B(cursor, COP_OPCODE)) {
    case 9:
    case 10:
    case 11:
        NUMBER(output) = (i16)(NUMBER(output) + OPND_W(cursor, OPND_LEFT));
        break;
    case 13:
        NUMBER(output) = (i16)(NUMBER(output) + OPND_W(cursor, OPND_RIGHT));
        if (VAR_B(OPND_W(cursor, OPND_LEFT), VAR_SYMBOL_KIND) == 5 || VAR_B(OPND_W(cursor, OPND_LEFT), VAR_SYMBOL_KIND) == 6) {
            REG(output) = 10;
            NUMBER(output) = (i16)(NUMBER(output) + VAR_W(OPND_W(cursor, OPND_LEFT), VAR_FRAME_OFFSET));
        } else
            SYMBOL(output) = VAR_W(OPND_W(cursor, OPND_LEFT), VAR_SYMBOL);
        break;
    case 31:
        ADD_NODE_TO_OPERAND(output, OPND_W(cursor, OPND_LEFT));
        ADD_NODE_TO_OPERAND(output, OPND_W(cursor, OPND_RIGHT));
        break;
    }
}

/* stores value as the segment override register of the operand record at node */
void SET_SEGMENT_OVERRIDE(u16 node, u8 value)
{
    B(DSPTR(node + 2)) = value;
}

/* the jump kind with the opposite condition */
u16 INVERT_JUMP_KIND(u16 index)
{
    return INVERTED_JUMP_KIND_AT(index);
}

/* emitblk.c: from bcc20/src/codegen/EMITBLK.C: the heart of the instruction emitter.
   EMIT_FUNCTION_BODY calls EMIT_BLOCK_INSTRUCTIONS for each code or switch block once
   registers are allocated; it walks the block's run of code ops and turns each into x86
   instructions through the EMIT_INSN_* builders, which fill FIRST_ASM_OPERAND and
   SECOND_ASM_OPERAND and pass an instruction number to EMIT_INSTRUCTION_HOOK.  Code-op
   numbers and instruction numbers share one numbering, so a plain op is often emitted with
   its own opcode as the instruction number.  Before each op the register history for it is
   replayed.  The op's table entry (CODE_OP_INFO_TABLE-3+op*19) gives its flag long at 3 and
   its operand-size byte at 7 (1 byte, 2 word: size+9Ah is MOV byte 9Bh or MOV word 9Ch).
   COP_FLAGS: 1 folded into its parent's operand, 2 works in place on its left operand, 8
   result used, 40h dead, 80h already done.  Registers: 0 AX (1 AH), 2 DX, 4 BX, 6 CX, 8
   SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 14 CS, 15 SS.  Instructions: 94h PUSH, 7Fh POP, 95h
   LEA, 96h LES, 9Bh/9Ch MOV, 1Fh ADD word, 57h FWAIT. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_OPTIMIZE_SPEED B(OPTION_OPTIMIZE_SPEED_P)
#define OPTION_TARGET_CPU B(OPTION_TARGET_CPU_P)
#define SWAP_OPCODE_FLAG B(SWAP_OPCODE_FLAG_P)
#define INSN_57_PENDING B(INSN_57_PENDING_P)
#define INSN_9C_DEFERRED B(INSN_9C_DEFERRED_P)
#define OPERAND_SIZE 9
#define COP_SC(r, o) SB(MK_FP(CODE_OP_POOL_SEG, (r) + (o)))

/* the op at record op emitted as reg,memory with its register cleared around the call, so
   the builder sees the op as a memory operand, not as the register itself */
static void load_into(u16 insn, u16 op, u16 number)
{
    u8 saved = COP_B(op, COP_REGISTER);
    COP_B(op, COP_REGISTER) = 0xFF;
    EMIT_INSN_REG_NODE(insn, saved, number);
    COP_B(op, COP_REGISTER) = saved;
}

/* the generic two-operand shapes: operand,operand / operand / no operands */
static void emit_operands(u16 op)
{
    if (OPND_W(op, OPND_RIGHT))
        EMIT_INSN_NODE_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT), OPND_W(op, OPND_RIGHT));
    else if (OPND_W(op, OPND_LEFT))
        EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT));
    else
        EMIT_INSN_NO_OPERANDS(COP_B(op, COP_OPCODE));
}

/* the generic path, by the op's table flags: 2 an 8087 op, 9 a load of a leaf, otherwise
   an integer op emitted as reg,operand / reg / operand,operand / operand / no operands,
   depending on which operands it has and whether its result is used */
static void emit_default(u16 node, u16 op, u16 number, u16 count, u16 descriptor)
{
    u32 flags = D(DSPTR(descriptor + 3));
    u8 hint = B(DSPTR(descriptor + 7));
    if (flags & 2) {
        if (flags & 1) {
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_INSN_NODE(hint + 0x61, number);
        } else if (COP_B(op, COP_FLAGS) & 2) {
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_EVAL_STACK_INSN(op);
            else if (COP_B(op, COP_FLAGS) & 0x80)
                EMIT_INSN_NO_OPERANDS(0x90);
            else if (flags & 4)
                EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT));
            else
                EMIT_FPU_OP_ON_OPERAND(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT));
        } else {
            u16 right = OPND_W(op, OPND_RIGHT);
            if (right && (COP_B(right << 2, COP_FLAGS) & 1))
                EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_RIGHT));
            else if (SWAP_OPCODE_FLAG)
                EMIT_INSN_NO_OPERANDS((u16)SWAP_OPERAND_OPCODE(COP_B(op, COP_OPCODE)));
            else
                EMIT_INSN_NO_OPERANDS(COP_B(op, COP_OPCODE));
            if ((COP_B(op, COP_FLAGS) & 8) == 0)
                EMIT_INSN_NO_OPERANDS(0x90);
        }
        SWAP_OPCODE_FLAG = 0;
        return;
    }
    if (flags & 9) {
        if ((COP_B(op, COP_FLAGS) & 8) == 0) {
            /* an unused leaf as the block's last op before a conditional jump: compare it
               with 0 */
            if (count > 1)
                return;
            u16 kind = CNODE_W(node, CNODE_JUMP_KIND) & 0xF8FF;
            if (kind == 1 || kind == 0)
                return;
            EMIT_INSN_NODE_IMM(hint + 0x7F, number, 0);
            return;
        }
        load_into(hint + 0x9A, op, number);
        return;
    }
    GET_ASSIGNED_REGISTER(OPND_W(op, OPND_LEFT));
    if ((COP_B(op, COP_FLAGS) & 2) == 0) {
        if (COP_B(op, COP_FLAGS) & 8) {
            if (OPND_W(op, OPND_RIGHT))
                EMIT_INSN_REG_NODE(COP_B(op, COP_OPCODE), COP_B(op, COP_REGISTER), OPND_W(op, OPND_RIGHT));
            else if (OPND_W(op, OPND_LEFT))
                EMIT_INSN_REG(COP_B(op, COP_OPCODE), COP_B(op, COP_REGISTER));
            else
                EMIT_INSN_NO_OPERANDS(COP_B(op, COP_OPCODE));
            return;
        }
        emit_operands(op);
        return;
    }
    if (COP_B(op, COP_FLAGS) & 8) {
        if (OPND_W(op, OPND_RIGHT))
            EMIT_REG_ASSIGNED_BINARY(op, descriptor);
        else if (OPND_W(op, OPND_LEFT))
            EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT));
        else
            EMIT_INSN_NO_OPERANDS(COP_B(op, COP_OPCODE));
        return;
    }
    if (COP_B(op, COP_FLAGS) & 0x80)
        return;
    emit_operands(op);
}

/* emits all code ops of flow block node, setting CURRENT_INSN_INDEX to each op number in
   turn.  Ops folded into an operand or dead are skipped except line marks (op 1), which go
   to LINE_NUMBER_HOOK (file, line) */
void EMIT_BLOCK_INSTRUCTIONS(u16 node)
{
    u16 count = CNODE_W(node, CNODE_OP_COUNT), number = CNODE_W(node, CNODE_FIRST_OP);
    for (u16 op = number * 4; count; --count, ++number, op += 4) {
        CURRENT_INSN_INDEX = number;
        EMIT_REGISTER_HISTORY(number);
        if (COP_B(op, COP_FLAGS) & 0x41) {
            if (COP_B(op, COP_OPCODE) == 1)
                CALL_FAR(LINE_NUMBER_HOOK, A16(OPND_W(op, OPND_LEFT)), A16(OPND_W(op, OPND_SOURCE_LINE)));
            continue;
        }
        u16 descriptor = (u16)(FP_OFF(OPCODE_DESCRIPTOR_TABLE_P) + COP_B(op, COP_OPCODE) * 19);
        u32 flags = D(DSPTR(descriptor + 3));
        u8 hint = B(DSPTR(descriptor + 7));
        if (flags & 0x2000)
            continue;
        if (flags & 0x1000) {
            EMIT_HELPER_CALL_FOR_NODE(op, descriptor);
            continue;
        }
        switch (COP_B(op, COP_OPCODE)) {
        case 7:
        case 8:
            /* register ops: move the value when the allocator gave the op another register */
            if ((COP_B(op, COP_FLAGS) & 8) == 0 || (u16)(i16)COP_SC(op, COP_REGISTER) == OPND_W(op, OPND_LEFT))
                break;
            EMIT_INSN_REG_REG((u16)REG_MOVE_OPCODE(COP_B(op, COP_OPCODE)), (i8)COP_B(op, COP_REGISTER), (i8)OPND_B(op, OPND_LEFT));
            break;
        case 0xAF:
            CALL_FAR(EMIT_OP_AF_HOOK, A16(OPND_W(op, OPND_LEFT)));
            break;
        case 0xAD:
            /* stack adjust after a call: ADD SP,n, or when optimising for size and n is 2 or 4,
               one or two POP CX */
            if (!D(MK_FP(CODE_OPERAND_POOL_SEG, op)))
                break;
            if (OPTION_OPTIMIZE_SPEED || D(MK_FP(CODE_OPERAND_POOL_SEG, op)) > 4) {
                EMIT_INSN_REG_IMM(0x1F, 11, OPND_W(op, OPND_LEFT));
                break;
            }
            if (D(MK_FP(CODE_OPERAND_POOL_SEG, op)) > 2)
                EMIT_INSN_REG(0x7F, 6);
            EMIT_INSN_REG(0x7F, 6);
            break;
        case 0x73:
            EMIT_INSN_NO_OPERANDS(0x73);
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_INSN_REG(0x7F, COP_B(op, COP_REGISTER));
            break;
        case 0x74:
            EMIT_INSN_NO_OPERANDS(0x74);
            if (COP_B(op, COP_FLAGS) & 8) {
                EMIT_INSN_NO_OPERANDS(0x73);
                EMIT_INSN_REG(0x7F, COP_B(op, COP_REGISTER));
            }
            break;
        case 0x72:
            COP_B(op, COP_OPCODE) = 10;
            EMIT_INSN_NODE(0x72, number);
            break;
        case 0x97:
        case 0x98:
        case 0x99:
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_INSN_REG_NODE(hint + 0x9A, COP_B(op, COP_REGISTER), OPND_W(op, OPND_LEFT));
            break;
        case 0x95:
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_INSN_REG_NODE(COP_B(op, COP_OPCODE), COP_B(op, COP_REGISTER), OPND_W(op, OPND_LEFT));
            break;
        case 14:
            if (COP_B(op, COP_FLAGS) & 8)
                load_into(0x95, op, number);
            break;
        case 0x7A:
            CALL_FAR(BYTE_HOOK, A16(OPND_B(op, OPND_LEFT)));
            break;
        case 0x79:
            CALL_FAR(BYTE_HOOK, A16(OPND_B(op, OPND_LEFT)));
            CALL_FAR(BYTE_HOOK, A16((u8)(D(MK_FP(CODE_OPERAND_POOL_SEG, op)) >> 8)));
            break;
        case 0x7B:
        case 0x7C:
            EMIT_INSN_NODE(COP_B(op, COP_OPCODE), number);
            break;
        case 17:
            if (COP_B(op, COP_FLAGS) & 8)
                load_into(0x9C, op, number);
            break;
        case 27: {
            /* a far pointer's segment word loaded into ES followed by an op that loads its
               offset: merged into one LES; the next op is marked done, its history replayed
               now, and this op becomes op 22 */
            if ((COP_B(op, COP_FLAGS) & 8) == 0)
                break;
            u16 next = op + 4;
            i8 saved = (i8)COP_B(op, COP_REGISTER);
            COP_B(op, COP_REGISTER) = 0xFF;
            if ((COP_B(next, COP_FLAGS) & 0x49) == 8 && saved == 12) {
                COP_B(next, COP_FLAGS) |= 0x40;
                EMIT_REGISTER_HISTORY(number + 1);
                if (COP_B(op, COP_OPCODE) == 27)
                    COP_B(op, COP_OPCODE) = 22;
                else
                    OPND_W(op, OPND_RIGHT) -= 2;
                EMIT_INSN_REG_NODE(0x96, COP_B(next, COP_REGISTER), number);
            } else
                EMIT_INSN_REG_NODE(0x9C, (u8)saved, number);
            COP_B(op, COP_REGISTER) = (u8)saved;
            break;
        }
        case 21:
        case 22:
            if (COP_B(op, COP_FLAGS) & 8)
                load_into(hint + 0x9A, op, number);
            break;
        case 0xB0:
            CALL_FAR(EMIT_OP_B0_HOOK, A16(OPND_W(op, OPND_LEFT)));
            break;
        case 0x8C:
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_INSN_REG(COP_B(op, COP_OPCODE), OPND_B(op, OPND_LEFT));
            break;
        case 0x8D:
        case 0x8E:
            EMIT_INSN_REG(COP_B(op, COP_OPCODE), OPND_B(op, OPND_LEFT));
            break;
        case 0x8F:
            EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT));
            break;
        case 0xB3:
            if ((COP_B(op, COP_FLAGS) & 8) == 0)
                EMIT_INSN_NO_OPERANDS(0x90);
            break;
        case 0x90:
        case 0x91:
        case 0xAB:
        case 0xAC:
            EMIT_INSN_NO_OPERANDS(COP_B(op, COP_OPCODE));
            break;
        case 3: {
            /* a sequence whose value is its left operand: when unused and the right operand is
               on the 8087 stack, 90h; when used, the left operand's register moved into the
               result register */
            if ((COP_B(op, COP_FLAGS) & 8) == 0) {
                if (FPU_STACK_OPERAND_OR_ZERO(OPND_W(OPND_W(op, OPND_RIGHT) << 2, OPND_LEFT)))
                    EMIT_INSN_NO_OPERANDS(0x90);
                break;
            }
            u8 saved = GET_ASSIGNED_REGISTER(OPND_W(op, OPND_LEFT));
            if (COP_B(op, COP_REGISTER) != saved)
                EMIT_INSN_REG_REG(0x9C, (i8)COP_B(op, COP_REGISTER), (i8)saved);
            break;
        }
        case 24:
        case 25:
        case 26:
            if (COP_B(op, COP_FLAGS) & 8)
                EMIT_INSN_NODE(hint + 0x61, number);
            break;
        case 0x82:
        case 0x83:
        case 0x84: {
            /* 8087 compares: a memory right operand is taken directly; otherwise the operand-less
               form, and unless a reload swapped the operands the block's conditional jump kind
               is remapped */
            u16 right = OPND_W(op, OPND_RIGHT);
            if (right && (COP_B(right << 2, COP_FLAGS) & 1))
                EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_RIGHT));
            else {
                if (!SWAP_OPCODE_FLAG && (CNODE_W(node, CNODE_JUMP_KIND) & 0xF8FF)) {
                    u16 kind = (u16)REMAP_JUMP_KIND(CNODE_W(node, CNODE_JUMP_KIND));
                    CNODE_W(node, CNODE_JUMP_KIND) = kind;
                }
                EMIT_INSN_NO_OPERANDS(COP_B(op, COP_OPCODE));
            }
            SWAP_OPCODE_FLAG = 0;
            break;
        }
        case 0xAA:
            /* zero-extend a byte: MOV the high half (register+1) to 0 */
            EMIT_INSN_REG_IMM(0x9B, (u8)(COP_B(op, COP_REGISTER) + 1), 0);
            break;
        case 13:
            /* the address of an auto or parameter: LEA of its frame slot (the op made leaf op 16
               for the operand); globals go to the default path */
            if ((COP_B(op, COP_FLAGS) & 8) == 0)
                break;
            if (VAR_B(OPND_W(op, OPND_VARIABLE), VAR_SYMBOL_KIND) != 5 && VAR_B(OPND_W(op, OPND_VARIABLE), VAR_SYMBOL_KIND) != 6) {
                emit_default(node, op, number, count, descriptor);
                break;
            }
            {
                u8 saved = COP_B(op, COP_REGISTER);
                COP_B(op, COP_REGISTER) = 0xFF;
                COP_B(op, COP_OPCODE) = 16;
                EMIT_INSN_REG_NODE(0x95, saved, number);
                COP_B(op, COP_REGISTER) = saved;
            }
            break;
        case 0x76:
            /* a far call through a pointer that is not a simple memory operand: PUSH CS, the
               hook's part, the two pointer words pushed, then RETF to them */
            if ((COP_B(OPND_W(op, OPND_LEFT) * 4, COP_FLAGS) & 1) == 0) {
                EMIT_INSN_REG(0x94, 14);
                CALL_FAR0(EMIT_OP_76_HOOK);
                EMIT_INSN_NODE(0x94, OPND_W(op, OPND_RIGHT));
                EMIT_INSN_NODE(0x94, OPND_W(op, OPND_LEFT));
                EMIT_INSN_NO_OPERANDS(0xA1);
                break;
            }
            /* fall through */
        case 0x75:
            EMIT_INSN_NODE(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT));
            break;
        case 0x77:
        case 0x78: {
            u8 saved = COP_B(op, COP_REGISTER);
            COP_B(op, COP_REGISTER) = 0xFF;
            OPND_W(op, OPND_RIGHT) = 0;
            EMIT_INSN_NODE(COP_B(op, COP_OPCODE), number);
            COP_B(op, COP_REGISTER) = saved;
            break;
        }
        case 0x44: case 0x45: case 0x46: case 0x47: case 0x48: case 0x49: case 0x55: case 0x56: case 0xD3: case 0xD4: {
            /* shifts by a constant on the 8086: count shifts by 1, then a move if the op and its
               left operand ended up in different registers */
            u16 child = OPND_W(op, OPND_RIGHT) * 4;
            if (COP_B(child, COP_OPCODE) != 9 || (COP_B(child, COP_FLAGS) & 1) == 0 || OPTION_TARGET_CPU) {
                emit_default(node, op, number, count, descriptor);
                break;
            }
            for (u16 amount = OPND_W(child, OPND_LEFT); amount > 0; --amount)
                EMIT_INSN_NODE_IMM(COP_B(op, COP_OPCODE), OPND_W(op, OPND_LEFT), 1);
            if ((COP_B(op, COP_FLAGS) & 10) != 10)
                break;
            u16 amount = GET_ASSIGNED_REGISTER(OPND_W(op, OPND_LEFT));
            if ((u16)(i16)COP_SC(op, COP_REGISTER) == amount)
                break;
            EMIT_INSN_REG_NODE(hint + 0x9A, COP_B(op, COP_REGISTER), OPND_W(op, OPND_LEFT));
            break;
        }
        case 2:
        case 5:
        case 6:
        case 0xAE:
        case 0xB4:
            break;
        default:
            emit_default(node, op, number, count, descriptor);
            break;
        }
    }
    /* block end: a pending FWAIT and a deferred MOV ES,memory flushed, then the history
       entries tagged with the negated last op number replayed */
    if (INSN_57_PENDING) {
        W(FIRST_ASM_OPERAND_P) = 0;
        W(SECOND_ASM_OPERAND_P) = 0;
        CALL_FAR(EMIT_INSTRUCTION_HOOK, A16(0x57));
        INSN_57_PENDING = 0;
    }
    if (INSN_9C_DEFERRED) {
        W(FIRST_ASM_OPERAND_P) = 1;
        FIRST_OPERAND_REG = 12;
        for (int i = 0; i < OPERAND_SIZE; ++i)
            B(fp_add(SECOND_ASM_OPERAND_P, i)) = B(fp_add(INSN_9C_DEFERRED_OPERAND_P, i));
        CALL_FAR(EMIT_INSTRUCTION_HOOK, A16(0x9C));
        INSN_9C_DEFERRED = 0;
    }
    EMIT_REGISTER_HISTORY((u16)-number);
}

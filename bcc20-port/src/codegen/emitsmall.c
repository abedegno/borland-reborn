/* emitsmall.c: from bcc20/src/codegen/REGMOVOP.C, EMITHELP.C, EMITFPU.C and EMITBIN.C: four
   small helpers of the instruction emitter (overlay ovr162), each one source file in the
   original, kept together here.  OPCODE_DESCRIPTOR_TABLE is the 19-byte-per-op table
   CODE_OP_INFO_TABLE seen from 3 bytes earlier; a descriptor passed by near pointer is an
   entry seen that way, so its byte 7 is the op's operand-size byte (1 byte, 2 word) and
   its word at 13 a run-time helper's number.  Instruction numbers used: 9Bh/9Ch MOV byte
   and word (size + 9Ah), 94h PUSH, 77h near CALL, 78h far CALL; register 14 is CS. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_MEMORY_MODEL SB(OPTION_MEMORY_MODEL_P)
#define NEAR_HELPER_CALLS SB(NEAR_HELPER_CALLS_P)
#define OP_FLAGS(op) D(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))
#define DESCRIPTOR_SIZE(descriptor) B(DSPTR((descriptor) + 7))
#define ARG(r) OPND_W((r), OPND_LEFT)

/* REGMOVOP.C: the register-to-register move instruction for code op kind: 9Bh (MOV byte)
   when the op's operand size is 1, otherwise 9Ch (MOV word) */
i16 REG_MOVE_OPCODE(i16 kind)
{
    return B(fp_add(OPCODE_DESCRIPTOR_TABLE_P, kind * 19 + 7)) != 1 ? 0x9C : 0x9B;
}

/* EMITHELP.C: rewrites code op node into a call of the run-time helper named by the
   descriptor's helper number (a table of near name pointers at DS:5338) and emits the call
   for the op CURRENT_INSN_INDEX.  The op's opcode and operands are overwritten for good;
   only COP_REGISTER is restored.  In the tiny model CS is pushed and the call is near */
void EMIT_HELPER_CALL_FOR_NODE(u16 node, u16 descriptor)
{
    u8 saved = COP_B(node, COP_REGISTER);
    COP_B(node, COP_OPCODE) = 16;
    COP_B(node, COP_REGISTER) = 0xFF;
    u16 name = W(fp_add(STR_SLXMUL_P, W(DSPTR(descriptor + 13)) * 2));
    u16 symbol = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(name), A16(1));
    u16 variable = FIND_OR_ADD_VARIABLE(symbol, 0, 16);
    OPND_W(node, OPND_LEFT) = variable;
    OPND_W(node, OPND_RIGHT) = 0;
    if (OPTION_MEMORY_MODEL == 0) {
        EMIT_INSN_REG(0x94, 14);
        EMIT_INSN_NODE(0x77, CURRENT_INSN_INDEX);
    } else
        EMIT_INSN_NODE(NEAR_HELPER_CALLS ? 0x77 : 0x78, CURRENT_INSN_INDEX);
    COP_B(node, COP_REGISTER) = saved;
}

/* EMITFPU.C: the instruction(s) for floating op node whose value must stay on the 8087
   stack because it is used again.  Nothing for an op with COP_FLAGS 80h.  A store (6Ch)
   to a variable held in a register is one instruction 68h; otherwise a copy of the stack
   top (8Ch, register 0) and the store.  Other ops: one instruction op-2 with fast floating
   point, else op and op-5 */
void EMIT_EVAL_STACK_INSN(u16 node)
{
    if (COP_B(node, COP_FLAGS) & 0x80)
        return;
    if (COP_B(node, COP_OPCODE) == 0x6C) {
        u16 child = ARG(node) * 4;
        if ((OP_FLAGS(COP_B(child, COP_OPCODE)) & 1) && (VAR_B(ARG(child), VAR_FLAGS) & 2)) {
            EMIT_INSN_NODE(0x68, ARG(node));
            return;
        }
        EMIT_INSN_REG(0x8C, 0);
        EMIT_INSN_NODE(COP_B(node, COP_OPCODE), ARG(node));
    } else if (OPTION_FAST_FLOAT != 0)
        EMIT_INSN_NODE(COP_B(node, COP_OPCODE) - 2, ARG(node));
    else {
        EMIT_INSN_NODE(COP_B(node, COP_OPCODE), ARG(node));
        EMIT_INSN_NODE(COP_B(node, COP_OPCODE) - 5, ARG(node));
    }
}

/* EMITBIN.C: binary op node, working in place on its left operand with its result used
   again, emitted with the registers already assigned to its operands, adding a move when
   the result must end up in another register.  The byte at offset 0 read in the last case
   but one is the op's opcode, as in the original */
void EMIT_REG_ASSIGNED_BINARY(u16 node, u16 descriptor)
{
    u8 right = GET_ASSIGNED_REGISTER(OPND_W(node, OPND_RIGHT));
    u8 left = GET_ASSIGNED_REGISTER(OPND_W(node, OPND_LEFT));
    u16 move = DESCRIPTOR_SIZE(descriptor) + 0x9A;
    if (OP_FLAGS(COP_B(node, COP_OPCODE)) & 4) {
        if ((COP_B(node, COP_FLAGS) & 0x80) == 0)
            EMIT_INSN_NODE_NODE(COP_B(node, COP_OPCODE), OPND_W(node, OPND_LEFT), OPND_W(node, OPND_RIGHT));
        if (COP_B(node, COP_REGISTER) != right) {
            if (right != 0xFF)
                EMIT_INSN_REG_REG(move, (i8)COP_B(node, COP_REGISTER), (i8)right);
            else
                EMIT_INSN_REG_NODE(move, COP_B(node, COP_REGISTER), OPND_W(node, OPND_LEFT));
        }
    } else if (left != 0xFF) {
        EMIT_INSN_REG_NODE(COP_B(node, COP_OPCODE), left, OPND_W(node, OPND_RIGHT));
        if (COP_B(node, COP_REGISTER) != left)
            EMIT_INSN_REG_REG(move, (i8)COP_B(node, COP_REGISTER), (i8)left);
    } else if (COP_B(node, COP_REGISTER) != 0xFF) {
        EMIT_INSN_NODE_NODE(COP_B(node, OPND_LEFT), OPND_W(node, OPND_LEFT), OPND_W(node, OPND_RIGHT));
        EMIT_INSN_REG_NODE(move, COP_B(node, COP_REGISTER), OPND_W(node, OPND_LEFT));
    } else
        EMIT_INSN_REG_NODE(COP_B(node, COP_OPCODE), left, OPND_W(node, OPND_RIGHT));
}

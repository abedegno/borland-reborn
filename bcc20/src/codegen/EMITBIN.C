/* target: ovr162_STAOV0F6 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: emits a binary operation using the registers assigned to its
   operands, adding register moves as needed. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: part of the instruction emitter overlay (ovr162). EMIT_BLOCK_INSTRUCTIONS calls
   EMIT_REG_ASSIGNED_BINARY (through EMIT_REG_ASSIGNED_BINARY_ENTRY) for a two-operand
   integer op that works in place on its left operand (COP_FLAGS 2) and whose result is
   also used (COP_FLAGS 8), such as an assignment used as a value. It looks at
   which registers the allocator gave the two operands (GET_ASSIGNED_REGISTER, 0xFF for
   none) and the result (COP_REGISTER), emits the operation, and adds a register move
   when the result must end up in a different register. 'Descriptor' is the op's
   CODE_OP_INFO_TABLE entry seen from 3 bytes earlier, so byte7 is the op's operand-size
   byte (1 byte, 2 word) and byte7+0x9A gives MOV byte (0x9B) or MOV word (0x9C), probably.
   Every pool read reloads _ES first; the explicit _ES loads, the comma expressions inside
   call arguments and the empty statement 'node=node' are shapes kept for byte matching.
   Note: ES_B(node,OPND_LEFT) read while ES holds CODE_OP_POOL_SEG is the op's opcode byte
   (offset 0, the same as COP_OPCODE), not an operand. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"
struct Descriptor { unsigned char reserved[7], byte7; };
extern unsigned char far pascal GET_ASSIGNED_REGISTER(unsigned int);
extern void far pascal EMIT_INSN_NODE_NODE(unsigned int,unsigned int,unsigned int);
extern void far pascal EMIT_INSN_REG_NODE(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
/* EMIT_REG_ASSIGNED_BINARY: emits binary op 'node' (CODE_OP_POOL_SEG offset) using the
   registers already assigned to its operands; 'descriptor' is its op table entry (see the
   overview). */
static void near pascal EMIT_REG_ASSIGNED_BINARY(register unsigned int node,
                               register struct Descriptor near *descriptor)
{
    unsigned char right,left;
    _ES=CODE_OPERAND_POOL_SEG;
    right=GET_ASSIGNED_REGISTER(ES_W(node,OPND_RIGHT));
    _ES=CODE_OPERAND_POOL_SEG;
    left=GET_ASSIGNED_REGISTER(ES_W(node,OPND_LEFT));
    _ES=CODE_OP_POOL_SEG;
    /* Table flag 4: the op writes its result into its left operand (set by NEW_CODE_NODE,
       which marks such a left operand with COP_FLAGS 4). Emit 'op left,right' unless
       COP_FLAGS 0x80 says it is already done, then copy the new value into the result
       register: from the right operand's register when it has one, else from the left
       operand. */
    if((*((unsigned long near *)(CODE_OP_INFO_TABLE+ES_B(node,COP_OPCODE)*19))&4L)!=0L) {
        if((ES_B(node,COP_FLAGS)&0x80)==0)
            EMIT_INSN_NODE_NODE(ES_B(node,COP_OPCODE),(_ES=CODE_OPERAND_POOL_SEG,ES_W(node,OPND_LEFT)),ES_W(node,OPND_RIGHT));
        _ES=CODE_OP_POOL_SEG;
        if(ES_B(node,COP_REGISTER)!=right) {
            if(right!=0xFF) EMIT_INSN_REG_REG(descriptor->byte7+0x9A,ES_B(node,COP_REGISTER),right);
            else {
                EMIT_INSN_REG_NODE(descriptor->byte7+0x9A,(_ES=CODE_OP_POOL_SEG,ES_B(node,COP_REGISTER)),
                           (_ES=CODE_OPERAND_POOL_SEG,ES_W(node,OPND_LEFT)));
                /* Preserve the separate original call without emitting code. */
                node=node;
            }
        }
    } else if(left!=0xFF) {
        /* Left operand in a register: operate on that register, then move it into the result
           register when the two differ. */
        _ES=CODE_OP_POOL_SEG;
        EMIT_INSN_REG_NODE(ES_B(node,COP_OPCODE),left,(_ES=CODE_OPERAND_POOL_SEG,ES_W(node,OPND_RIGHT)));
        _ES=CODE_OP_POOL_SEG;
        if(ES_B(node,COP_REGISTER)!=left) EMIT_INSN_REG_REG(descriptor->byte7+0x9A,ES_B(node,COP_REGISTER),left);
    } else {
        /* Left operand not in a register: operate in memory and load the result register from
           the left operand; with no result register just emit the op. */
        _ES=CODE_OP_POOL_SEG;
        if(ES_B(node,COP_REGISTER)!=0xFF) {
            EMIT_INSN_NODE_NODE(ES_B(node,OPND_LEFT),(_ES=CODE_OPERAND_POOL_SEG,ES_W(node,OPND_LEFT)),ES_W(node,OPND_RIGHT));
            EMIT_INSN_REG_NODE(descriptor->byte7+0x9A,(_ES=CODE_OP_POOL_SEG,ES_B(node,COP_REGISTER)),
                       (_ES=CODE_OPERAND_POOL_SEG,ES_W(node,OPND_LEFT)));
        } else {
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_REG_NODE(ES_B(node,COP_OPCODE),left,(_ES=CODE_OPERAND_POOL_SEG,ES_W(node,OPND_RIGHT)));
        }
    }
}

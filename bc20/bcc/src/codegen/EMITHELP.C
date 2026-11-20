/* target: ovr162_STAOV0F5 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: replaces a code node with a call to a named run-time helper and
   emits the near or far call. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: part of the instruction emitter overlay (ovr162). Some code ops have no inline
   x86 form and are done by a call to a run-time helper (CODE_OP_INFO_TABLE flag 0x1000,
   tested in EMIT_BLOCK_INSTRUCTIONS). This file turns such a code op into a call: it makes
   the op a leaf op (16) naming the helper symbol, emits the call, then puts back the op's
   assigned register. 'Descriptor' is the op's CODE_OP_INFO_TABLE entry seen from 3 bytes
   earlier (the caller passes CODE_OP_INFO_TABLE-3+opcode*19), so 'index' is the word at
   offset 10 of the entry: the helper's number in a table of near name pointers at DS:5338.
   Instruction numbers used: 0x94 probably PUSH, 0x77 near CALL, 0x78 far CALL; register 14
   is probably CS (see EMIT_INSN_REG_REG, which moves segment registers 12 and up through
   the stack). */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"
struct Descriptor { unsigned char reserved[13]; unsigned int index; };
extern signed char OPTION_MEMORY_MODEL,NEAR_HELPER_CALLS;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int,unsigned char,unsigned char);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_NODE(unsigned int,unsigned int);

/* EMIT_HELPER_CALL_FOR_NODE: rewrites code op 'node' (its CODE_OP_POOL_SEG offset, op
   number*4) into a call of the run-time helper named by descriptor->index and emits the
   call for the op CURRENT_INSN_INDEX. The helper symbol is declared through
   DECLARE_NAMED_GLOBAL_HOOK and entered in the variable table by FIND_OR_ADD_VARIABLE.
   The op's opcode and operands are overwritten for good; only COP_REGISTER is restored.
   Called from EMIT_BLOCK_INSTRUCTIONS (through EMIT_HELPER_CALL_FOR_NODE_ENTRY). */
static void near pascal EMIT_HELPER_CALL_FOR_NODE(register unsigned int node,
                               register struct Descriptor near *descriptor)
{
    unsigned char saved;
    saved=COP_B(node,COP_REGISTER);
    COP_B(node,COP_OPCODE)=16;
    /* Clear the register so EMIT_INSN_NODE emits a memory/symbol operand, not a register. */
    COP_B(node,COP_REGISTER)=0xFF;
    OPND_W(node,OPND_LEFT)=FIND_OR_ADD_VARIABLE(DECLARE_NAMED_GLOBAL_HOOK(((char near * near *)(STR_SLXMUL))[descriptor->index],1),0,16);
    OPND_W(node,OPND_RIGHT)=0;
    /* Tiny model: push CS and make a near call, so a helper that returns far still works
       inside the single segment. Otherwise a near or far call as NEAR_HELPER_CALLS says. */
    if(OPTION_MEMORY_MODEL==0) {
        EMIT_INSN_REG(0x94,14);
        EMIT_INSN_NODE(0x77,CURRENT_INSN_INDEX);
    } else EMIT_INSN_NODE(NEAR_HELPER_CALLS ? 0x77 : 0x78,CURRENT_INSN_INDEX);
    COP_B(node,COP_REGISTER)=saved;
}

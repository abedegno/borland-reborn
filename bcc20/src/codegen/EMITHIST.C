/* target: ovr162_STAOV0F8 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: replays the register history entries for an instruction (register
   moves, pushes, pops, spills) before emitting it. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: part of the instruction emitter overlay (ovr162). The register allocator
   (REGALLOC.C RECORD_REGISTER_MOVE) and the 8087 stack code (SAVEREGS.C) do not change
   the code ops when a value has to move; they append 9-byte entries to
   REG_HISTORY_POOL_SEG, each tagged with the op number before which it happens
   (RHIST_INSN_INDEX). While emitting, REGISTER_HISTORY_CURSOR walks these entries in
   step with the ops: EMIT_FUNCTION_BODY sets it to a block's CNODE_HISTORY and
   EMIT_BLOCK_INSTRUCTIONS calls EMIT_REGISTER_HISTORY before each op and once more with
   the negated last op number for the block's closing entries. Replaying an entry emits
   the x86 instruction and updates COP_REGISTER of the moved op so later operands see the
   new place. Instruction numbers used, probably: 0x9A XCHG, 0x94 PUSH, 0x7F POP, 0x9B/0x9C
   MOV byte/word, 0x6C store and 0x67 load of an 8087 value to/from a temporary (both
   through EMIT_INSN_LOCAL). */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"
extern unsigned char SWAP_OPCODE_FLAG;
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
extern void far pascal EMIT_INSN_LOCAL(unsigned int,unsigned int);
/* EMIT_REGISTER_HISTORY: emits every history entry at REGISTER_HISTORY_CURSOR tagged with
   op number 'index', advancing the cursor past them. Action 5 (reload) also sets
   SWAP_OPCODE_FLAG from the entry's RHIST_REGISTER byte, which then tells the emitter to
   use the operand-swapped form of the next instruction (SWAP_OPERAND_OPCODE). */
static void near pascal EMIT_REGISTER_HISTORY(unsigned int index)
{
    register unsigned int node;
    unsigned char saved;
    while(REGISTER_HISTORY_CURSOR<HISTORY_END_OFFSET &&
          (_BX=REGISTER_HISTORY_CURSOR,_ES=REG_HISTORY_POOL_SEG,ES_W(_BX,RHIST_INSN_INDEX))==index) {
        _BX=REGISTER_HISTORY_CURSOR;
        _ES=REG_HISTORY_POOL_SEG;
        node=ES_W(_BX,RHIST_VALUE_OP)*4;
        saved=ES_B(_BX,RHIST_REGISTER);
        switch((int)ES_B(_BX,RHIST_ACTION)) {
        /* Exchange: swap the registers of the value op and its partner op (RHIST_PARTNER). */
        case 6:
            EMIT_INSN_REG_REG(0x9A,saved,(_ES=CODE_OP_POOL_SEG,ES_B(node,COP_REGISTER)));
            _ES=CODE_OP_POOL_SEG;
            _AL=ES_B(node,COP_REGISTER);
            _BX=REGISTER_HISTORY_CURSOR;
            _ES=REG_HISTORY_POOL_SEG;
            _BX=ES_W(_BX,RHIST_PARTNER);
            _BX<<=2;
            _ES=CODE_OP_POOL_SEG;
            ES_B(_BX,COP_REGISTER)=_AL;
            ES_B(node,COP_REGISTER)=saved;
            break;
        /* Push: save the value's register on the stack. */
        case 1:
            EMIT_INSN_REG(0x94,(_ES=CODE_OP_POOL_SEG,ES_B(node,COP_REGISTER)));
            break;
        /* Pop: the value comes back from the stack into register 'saved'. */
        case 2:
            _ES=CODE_OP_POOL_SEG;
            ES_B(node,COP_REGISTER)=saved;
            EMIT_INSN_REG(0x7F,saved);
            break;
        /* Move: copy the value into register 'saved'; RHIST_IS_WORD picks MOV word or byte. */
        case 3:
            _BX=REGISTER_HISTORY_CURSOR;
            _ES=REG_HISTORY_POOL_SEG;
            EMIT_INSN_REG_REG((ES_B(_BX,RHIST_IS_WORD)&1) ? 0x9C : 0x9B,saved,
                       (_ES=CODE_OP_POOL_SEG,ES_B(node,COP_REGISTER)));
            _ES=CODE_OP_POOL_SEG;
            ES_B(node,COP_REGISTER)=saved;
            break;
        /* Spill: store an 8087 stack value into its temporary (RHIST_PARTNER). */
        case 4:
            EMIT_INSN_LOCAL(0x6C,(_BX=REGISTER_HISTORY_CURSOR,_ES=REG_HISTORY_POOL_SEG,ES_W(_BX,RHIST_PARTNER)));
            break;
        /* Reload: load the spilled 8087 value back from its temporary. */
        case 5:
            EMIT_INSN_LOCAL(0x67,(_BX=REGISTER_HISTORY_CURSOR,_ES=REG_HISTORY_POOL_SEG,ES_W(_BX,RHIST_PARTNER)));
            SWAP_OPCODE_FLAG=saved;
            break;
        }
        REGISTER_HISTORY_CURSOR+=9;
    }
}

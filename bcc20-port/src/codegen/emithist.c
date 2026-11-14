/* emithist.c: from bcc20/src/codegen/EMITHIST.C: part of the instruction emitter. The
   register allocator and the 8087 stack code do not change the code ops when a value has to
   move; they append 9-byte entries to REG_HISTORY_POOL_SEG, each tagged with the op number
   before which it happens.  While emitting, REGISTER_HISTORY_CURSOR walks these entries in
   step with the ops; replaying an entry emits the x86 instruction and updates COP_REGISTER
   of the moved op so later operands see the new place.  Instruction numbers: 9Ah XCHG, 94h
   PUSH, 7Fh POP, 9Bh/9Ch MOV byte/word, 6Ch store and 67h load of an 8087 value to/from a
   temporary. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define SWAP_OPCODE_FLAG B(SWAP_OPCODE_FLAG_P)

/* emits every history entry at REGISTER_HISTORY_CURSOR tagged with op number index,
   advancing the cursor past them.  Action 5 (reload) also sets SWAP_OPCODE_FLAG from the
   entry's register byte, which makes the emitter use the operand-swapped form of the next
   instruction */
void EMIT_REGISTER_HISTORY(u16 index)
{
    while (REGISTER_HISTORY_CURSOR < HISTORY_END_OFFSET && RHIST_W(REGISTER_HISTORY_CURSOR, RHIST_INSN_INDEX) == index) {
        u16 entry = REGISTER_HISTORY_CURSOR;
        u16 node = RHIST_W(entry, RHIST_VALUE_OP) * 4;
        u8 saved = RHIST_B(entry, RHIST_REGISTER);
        switch (RHIST_B(entry, RHIST_ACTION)) {
        case 6:                                 /* exchange with the partner op */
            EMIT_INSN_REG_REG(0x9A, (i8)saved, (i8)COP_B(node, COP_REGISTER));
            COP_B(RHIST_W(REGISTER_HISTORY_CURSOR, RHIST_PARTNER) << 2, COP_REGISTER) = COP_B(node, COP_REGISTER);
            COP_B(node, COP_REGISTER) = saved;
            break;
        case 1:                                 /* push */
            EMIT_INSN_REG(0x94, COP_B(node, COP_REGISTER));
            break;
        case 2:                                 /* pop into saved */
            COP_B(node, COP_REGISTER) = saved;
            EMIT_INSN_REG(0x7F, saved);
            break;
        case 3:                                 /* move into saved */
            EMIT_INSN_REG_REG((RHIST_B(REGISTER_HISTORY_CURSOR, RHIST_IS_WORD) & 1) ? 0x9C : 0x9B, (i8)saved, (i8)COP_B(node, COP_REGISTER));
            COP_B(node, COP_REGISTER) = saved;
            break;
        case 4:                                 /* spill an 8087 value to its temporary */
            EMIT_INSN_LOCAL(0x6C, RHIST_W(REGISTER_HISTORY_CURSOR, RHIST_PARTNER));
            break;
        case 5:                                 /* reload it */
            EMIT_INSN_LOCAL(0x67, RHIST_W(REGISTER_HISTORY_CURSOR, RHIST_PARTNER));
            SWAP_OPCODE_FLAG = saved;
            break;
        }
        REGISTER_HISTORY_CURSOR += 9;
    }
}

/* emitfunc.c: from bcc20/src/codegen/EMITFUNC.C: last step of the per-function back end.
   It walks the function's flow-block list and, for each block, tells the output layer a
   block starts (BLOCK_START_HOOK), points REGISTER_HISTORY_CURSOR at the block's register
   history, and emits by block kind: code blocks (0) through EMIT_BLOCK_INSTRUCTIONS plus the
   block's closing jump, inline assembler blocks (5) through EMIT_ASM_STATEMENT, scope entry
   (1) and exit (2) blocks as debug-information hooks when OPTION_SOURCE_DEBUG is set, and
   switch blocks (4).  Label blocks (3) emit nothing.  A block's jump goes to
   BLOCK_JUMP_HOOK (jump kind, target block, and whether it is a conditional jump whose
   block has CNODE_FLAGS 100h). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)

static void emit_jump(u16 block)
{
    u16 kind = CNODE_W(block, CNODE_JUMP_KIND), target = CNODE_W(block, CNODE_TARGET);
    u16 fixed = (kind & 0xF8FF) != 1 && (CNODE_W(block, CNODE_FLAGS) & 0x100);
    CALL_FAR(BLOCK_JUMP_HOOK, A16(kind), A16(target), A16(fixed));
}

/* emits the code of the current function, block by block.  Sets OUTER_SCOPE_EXIT_VALUE
   when the outermost scope closes at the end */
void EMIT_FUNCTION_BODY(void)
{
    OUTER_SCOPE_EXIT_VALUE = 0;
    for (u16 block = CODE_BLOCK_LIST_HEAD; block; block = CNODE_W(block, CNODE_NEXT)) {
        CALL_FAR(BLOCK_START_HOOK, A16(block));
        REGISTER_HISTORY_CURSOR = CNODE_W(block, CNODE_HISTORY);
        if (CTRL_BREAK_SEEN)
            LINE_HOOK();
        switch (CNODE_W(block, CNODE_KIND)) {
        case 5:
            EMIT_ASM_STATEMENT(CNODE_W(block, CNODE_ASM_TEXT));
            if (CNODE_W(block, CNODE_JUMP_KIND) & 0xF8FF)
                emit_jump(block);
            break;
        case 1:
            if (OPTION_SOURCE_DEBUG)
                CALL_FAR0(SCOPE_ENTER_DEBUG_HOOK);
            break;
        case 2:
            /* a scope exit; when it is the last block (no next block, or the next is block
               2, the function's return label) its value is kept for the epilogue */
            if (OPTION_SOURCE_DEBUG) {
                u16 next = CNODE_W(block, CNODE_NEXT);
                u16 info = CNODE_W(CNODE_W(block, CNODE_SCOPE_ENTRY), CNODE_SCOPE_INFO);
                if (!next || next == 2)
                    OUTER_SCOPE_EXIT_VALUE = info;
                else
                    CALL_FAR(SCOPE_EXIT_DEBUG_HOOK, A16(info));
            }
            break;
        case 0:
            EMIT_BLOCK_INSTRUCTIONS(block);
            if (CNODE_W(block, CNODE_JUMP_KIND) & 0xF8FF)
                emit_jump(block);
            break;
        case 4:
            /* a switch: its selector code, then a jump table (CNODE_FLAGS 2: SHL BX,1 and the
               jump through the table record) or the ordinary closing jump */
            EMIT_BLOCK_INSTRUCTIONS(block);
            if (CNODE_W(block, CNODE_FLAGS) & 2) {
                EMIT_INSN_REG_IMM(0x45, 4, 1);
                CALL_FAR(RETURN_BLOCK_WORD20_HOOK, A16(CNODE_W(block, CNODE_SWITCH_TABLE)));
            } else
                emit_jump(block);
            break;
        }
    }
}

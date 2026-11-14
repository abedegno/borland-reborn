/* varuses.c: from bcc20/src/codegen/VARUSES.C: a pass run before register variables are
   chosen.  It walks every live code op of the function's code and switch blocks and adds
   the block's loop weight to counters in the variable table, so variables used inside loops
   score higher: VAR_USE_COUNT for plain uses, VAR_INDEX_WEIGHT when the variable is the
   address of an indirect access, VAR_ES_CLASS_WEIGHT when it is the segment part of one,
   VAR_SHIFT_COUNT_USES when it is a shift count.  It also records registers a variable may
   not use in VAR_EXCLUDED_REGS.  A variable leaf is an op whose table flags have 1 and not
   400h. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define FLAGS(r) D(fp_add(CODE_OP_INFO_TABLE_P, COP_B((r), COP_OPCODE) * 19))
#define IS_VARIABLE_LEAF(r) ((FLAGS(r) & 0x401) == 1)

/* fills the weight counters for the current function */
void TALLY_WEIGHTED_USES(void)
{
    for (u16 node = CODE_BLOCK_LIST_HEAD; node; node = CNODE_W(node, CNODE_NEXT)) {
        if (CNODE_W(node, CNODE_KIND) != 0 && CNODE_W(node, CNODE_KIND) != 4)
            continue;
        u16 weight = CNODE_W(node, CNODE_LOOP_WEIGHT);
        u16 entry = CNODE_W(node, CNODE_FIRST_OP) * 4;
        for (u16 count = 0; CNODE_W(node, CNODE_OP_COUNT) > count; entry += 4, ++count) {
            weight = CNODE_W(node, CNODE_LOOP_WEIGHT);
            u8 op = COP_B(entry, COP_OPCODE);
            if (COP_B(entry, COP_FLAGS) & 0x40)
                continue;
            if (IS_VARIABLE_LEAF(entry)) {
                VAR_W(OPND_W(entry, OPND_LEFT), VAR_USE_COUNT) += weight;
                if (op == 0x0F)
                    VAR_W(OPND_W(entry, OPND_LEFT), VAR_EXCLUDED_REGS) |= REG_MASK_SI_DI;
            } else if (op >= 0x15 && op <= 0x1A) {
                if (OPND_W(entry, OPND_RIGHT)) {
                    u16 child = OPND_W(entry, OPND_RIGHT) * 4;
                    if (IS_VARIABLE_LEAF(child))
                        VAR_W(OPND_W(child, OPND_LEFT), VAR_ES_CLASS_WEIGHT) += weight;
                }
                u16 target = OPND_W(entry, OPND_LEFT) * 4;
                if (COP_B(target, COP_OPCODE) == 0x1F) {
                    u16 child = OPND_W(target, OPND_RIGHT) * 4;
                    if ((FLAGS(child) & 0x408) == 8)
                        target = OPND_W(target, OPND_LEFT) * 4;
                }
                if (IS_VARIABLE_LEAF(target))
                    VAR_W(OPND_W(target, OPND_LEFT), VAR_INDEX_WEIGHT) += weight;
            } else if (op >= 0x44 && op <= 0x49) {
                u16 child = OPND_W(entry, OPND_RIGHT) * 4;
                if (IS_VARIABLE_LEAF(child))
                    ++VAR_W(OPND_W(child, OPND_LEFT), VAR_SHIFT_COUNT_USES);
            } else if (COP_B(entry, COP_FLAGS) & 2) {
                u16 target = OPND_W(entry, OPND_LEFT) * 4;
                if ((COP_B(target, COP_FLAGS) & 4) == 0 && IS_VARIABLE_LEAF(target)) {
                    VAR_W(OPND_W(target, OPND_LEFT), VAR_EXCLUDED_REGS) |= REG_MASK_ES;
                    VAR_W(OPND_W(target, OPND_LEFT), VAR_USE_COUNT) += weight;
                }
            }
        }
    }
}

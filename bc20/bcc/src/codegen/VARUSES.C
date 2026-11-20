/* target: ovr154_STAOV087 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: registers: tallies loop-weighted uses of each variable over the code-node list,
   probably to score register-variable candidates. Entry points: TALLY_WEIGHTED_USES. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: a pass run by GENERATE_FUNCTION_CODE before register variables are chosen.
   It walks every live code op of the function's code and switch blocks and adds the
   block's CNODE_LOOP_WEIGHT to counters in the variable table, so variables used inside
   loops score higher: VAR_USE_COUNT for plain uses, VAR_INDEX_WEIGHT when the variable is
   the address of an indirect access (good in BX/SI/DI), VAR_ES_CLASS_WEIGHT when it is the
   segment part of one (good in an ES-class register), VAR_SHIFT_COUNT_USES when it is a
   shift count (good in CX). It also records registers a variable may not use in
   VAR_EXCLUDED_REGS. A 'variable leaf' below is an op whose table flags have 1 and not
   0x400 (FLAGS(r) is the op's CODE_OP_INFO_TABLE flag long). Register variables are then
   chosen from these numbers (REGVARS.C). */

#include <dos.h>
#include "DATA.H"
#include "POOL.H"
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
#define FLAGS(r) (*((unsigned long near *)(CODE_OP_INFO_TABLE + FAR_B(CODE_OP_POOL_SEG,(r),COP_OPCODE)*19)))

/* TALLY_WEIGHTED_USES: fills the weight counters described above for the current function. */
void far pascal TALLY_WEIGHTED_USES(void)
{
    /* The original increments position without initializing or reading it. */
    unsigned int node,position,count;
    register unsigned int entry,target;
    for (node=CODE_BLOCK_LIST_HEAD; node;) {
        if (CNODE_W(node,CNODE_KIND)==0 || CNODE_W(node,CNODE_KIND)==4) {
            entry=CNODE_W(node,CNODE_FIRST_OP)*4;
            for (count=0; CNODE_W(node,CNODE_OP_COUNT)>count;
                 entry+=4,++count,position+=2) {
                if (COP_B(entry,COP_FLAGS)&0x40) continue;
                /* A variable leaf: count a use. Op 0x0F is probably the byte-sized leaf (char), which
                   cannot live in SI or DI (no byte halves). */
                if ((FLAGS(entry)&0x401L)==1L) {
                    VAR_W(OPND_W(entry,OPND_LEFT),VAR_USE_COUNT) += CNODE_W(node,CNODE_LOOP_WEIGHT);
                    if (COP_B(entry,COP_OPCODE)==0x0F)
                        VAR_W(OPND_W(entry,OPND_LEFT),VAR_EXCLUDED_REGS) |= REG_MASK_SI_DI;
                /* Indirect accesses (ops 0x15-0x1A): the right operand is the segment, the left the
                   address; an address 'x + constant' (op 0x1F with a constant right side, table flag 8)
                   counts for x. */
                } else if (COP_B(entry,COP_OPCODE)>=0x15 && COP_B(entry,COP_OPCODE)<=0x1A) {
                    if (OPND_W(entry,OPND_RIGHT)) {
                        register unsigned int child;
                        child=OPND_W(entry,OPND_RIGHT)*4;
                        if ((FLAGS(child)&0x401L)==1L)
                            VAR_W(OPND_W(child,OPND_LEFT),VAR_ES_CLASS_WEIGHT) += CNODE_W(node,CNODE_LOOP_WEIGHT);
                    }
                    target=OPND_W(entry,OPND_LEFT)*4;
                    if (COP_B(target,COP_OPCODE)==0x1F) {
                        register unsigned int child;
                        child=OPND_W(target,OPND_RIGHT)*4;
                        if ((FLAGS(child)&0x408L)==8L)
                            target=OPND_W(target,OPND_LEFT)*4;
                    }
                    if ((FLAGS(target)&0x401L)==1L)
                        VAR_W(OPND_W(target,OPND_LEFT),VAR_INDEX_WEIGHT) += CNODE_W(node,CNODE_LOOP_WEIGHT);
                } else if (COP_B(entry,COP_OPCODE)>=0x44 && COP_B(entry,COP_OPCODE)<=0x49) {
                    register unsigned int child;
                    child=OPND_W(entry,OPND_RIGHT)*4;
                    if ((FLAGS(child)&0x401L)==1L)
                        ++VAR_W(OPND_W(child,OPND_LEFT),VAR_SHIFT_COUNT_USES);
                /* Any other op working in place on its left operand (COP_FLAGS 2): when that operand is
                   a variable leaf not marked written (COP_FLAGS 4), count the use and keep the
                   variable out of the ES-class registers. */
                } else if (COP_B(entry,COP_FLAGS)&2) {
                    target=OPND_W(entry,OPND_LEFT)*4;
                    if ((COP_B(target,COP_FLAGS)&4)==0 && (FLAGS(target)&0x401L)==1L) {
                        VAR_W(OPND_W(target,OPND_LEFT),VAR_EXCLUDED_REGS) |= REG_MASK_ES;
                        VAR_W(OPND_W(target,OPND_LEFT),VAR_USE_COUNT) += CNODE_W(node,CNODE_LOOP_WEIGHT);
                    }
                }
            }
        }
        node = CNODE_W(node,CNODE_NEXT);
    }
}

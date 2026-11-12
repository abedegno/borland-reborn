/* target: ovr171_C105UNIT */
/* Role: jump optimisation. Entry points: OPTIMIZE_JUMPS, IS_BLOCK_EMPTY,
   INVERT_JUMP_CONDITION, UNLINK_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO06F (ovr_1dc1_b052) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: jump optimisation on the flow-block list, run by GENERATE_FUNCTION_CODE first
   when OPTIMIZE_ENABLED is set (RESOLVE_JUMP_TARGETS through its stub, then
   OPTIMIZE_JUMPS), before any code is laid out. RESOLVE_JUMP_TARGETS points every jump
   and case at the block that really holds code, counting references in CNODE_JUMP_REFS,
   and removes the label blocks. OPTIMIZE_JUMPS then repeats, until JUMP_OPT_CHANGED stays
   0: jumps to blocks that only jump are sent straight to the final target; unreachable
   blocks after an unconditional jump are unlinked; a jump to the next block is dropped;
   a block that falls into an empty unconditional jump takes that jump over; a target
   reached only by one jump is moved right after it (MOVE_TARGET_AFTER_JUMP);
   'conditional jump over an unconditional jump' becomes one inverted conditional jump
   (MERGE_JUMP_OVER_JUMP); switch cases that go to the default are removed. Blocks with
   CNODE_FLAGS 0x100 ('jump fixed') keep their jump. Scope entry and exit blocks (kinds 1
   and 2) are skipped over when looking for the next or previous block of code. Several
   functions use raw word indexes into a block: [0] kind, [1] CNODE_JUMP_REFS, [6]
   CNODE_NEXT, [7] CNODE_PREV, [8] CNODE_TARGET. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- RESOLVE_JUMP_TARGETS (listing ovr_1dc1_b052:0520) ---- */
static void far pascal RESOLVE_JUMP_TARGETS(void);
static unsigned int near pascal FIND_REAL_TARGET(unsigned int value);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);
/* RESOLVE_JUMP_TARGETS: first pass: replaces each jump target and switch case target by
   FIND_REAL_TARGET; inline-assembler blocks (kind 5) get 0x7FFF references so they are
   never removed (probably because asm text may refer to them), scope blocks 1. Second pass:
   unlinks and frees the label blocks (kind 3); a label at the very end becomes an empty
   code block instead. With JUMP_OPT_KEEP_EMPTY_BLOCKS set the removal stops at the first
   label. */
static void far pascal RESOLVE_JUMP_TARGETS(void)
{
    unsigned int next;
    register unsigned int node,member;
    node=CODE_BLOCK_LIST_HEAD;
    while(node!=0) {
        next=CNODE_W(node,CNODE_NEXT);
        switch(CNODE_W(node,CNODE_KIND)) {
        case 5:
            CNODE_W(node,CNODE_JUMP_REFS)=0x7FFF;
        case 0:
            if(CNODE_W(node,CNODE_JUMP_KIND)!=0) {
                CNODE_W(node,CNODE_TARGET)=FIND_REAL_TARGET(CNODE_W(node,CNODE_TARGET));
            }
            break;
        case 4:
            CNODE_W(node,CNODE_TARGET)=FIND_REAL_TARGET(CNODE_W(node,CNODE_TARGET)); member=CNODE_W(node,CNODE_CASE_LIST);
            while(member!=0) {
                SWCASE_W(member,SWCASE_TARGET)=FIND_REAL_TARGET(SWCASE_W(member,SWCASE_TARGET));
                member=SWCASE_W(member,SWCASE_NEXT);
            }
            break;
        case 1: case 2:
            CNODE_W(node,CNODE_JUMP_REFS)=1;
        }
        node=next;
    }
    node=CODE_BLOCK_LIST_HEAD;
    while(node!=0) {
        next=CNODE_W(node,CNODE_NEXT);
        if(CNODE_W(node,CNODE_KIND)==3) {
            if(JUMP_OPT_KEEP_EMPTY_BLOCKS!=0) break;
            if(CNODE_W(node,CNODE_NEXT)!=0) {
                CNODE_W(CNODE_W(node,CNODE_NEXT),CNODE_PREV)=CNODE_W(node,CNODE_PREV);
            } else {
                CNODE_W(node,CNODE_KIND)=0; CNODE_W(node,CNODE_JUMP_REFS)++;break;
            }
            if(CNODE_W(node,CNODE_PREV)!=0) {
                CNODE_W(CNODE_W(node,CNODE_PREV),CNODE_NEXT)=CNODE_W(node,CNODE_NEXT);
            } else {
                CODE_BLOCK_LIST_HEAD=CNODE_W(node,CNODE_NEXT);
            }
            POOL_FREE_ITEM(&FLOW_BLOCK_POOL_SEG,node);
        }
        node=next;
    }
}

/* ---- STAOV147 (listing ovr_1dc1_b052:0643) ---- */
static int near pascal IS_JUMP_ONLY_BLOCK(register unsigned int value);
int far pascal IS_BLOCK_EMPTY(register unsigned int node);
static int near pascal IS_SKIPPABLE_JUMP_TARGET(unsigned int value);
static void near pascal MOVE_TARGET_AFTER_JUMP(unsigned int stop,register unsigned int node);
static void near pascal MERGE_JUMP_OVER_JUMP(unsigned int first, unsigned int second);
static void near pascal RETARGET_JUMP(register unsigned int first, unsigned int second);
void far pascal UNLINK_NODE(register unsigned int value);
static unsigned int near pascal NEXT_CODE_NODE(register unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int JUMP_OPT_CHANGED;
extern void far pascal NESTING_CHECK(void);
/* OPTIMIZE_JUMPS: the main loop described in the overview, over the current function's
   block list; 'candidate' is the next block of code after the current one (_SI). */
void far pascal OPTIMIZE_JUMPS(void)
{
    unsigned int candidate,child,next,previous;
    do {
        JUMP_OPT_CHANGED=0;
        _SI=CODE_BLOCK_LIST_HEAD;
        while (_SI) {
            NESTING_CHECK();
            _ES=FLOW_BLOCK_POOL_SEG;
            next=ES_W(_SI,CNODE_NEXT);
            while (IS_SKIPPABLE_JUMP_TARGET(_SI)) {
                RETARGET_JUMP(_SI,(_ES=FLOW_BLOCK_POOL_SEG,_BX=ES_W(_SI,CNODE_TARGET),ES_W(_BX,CNODE_NEXT)));
            }
            _ES=FLOW_BLOCK_POOL_SEG;
            if (ES_W(_SI,CNODE_KIND)==0 || ES_W(_SI,CNODE_KIND)==4) {
                _ES=FLOW_BLOCK_POOL_SEG;
                if (ES_W(_SI,CNODE_JUMP_KIND) && IS_JUMP_ONLY_BLOCK(ES_W(_SI,CNODE_TARGET))) {
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if (!(ES_W(_SI,CNODE_FLAGS)&0x100)) RETARGET_JUMP(_SI,(_BX=ES_W(_SI,CNODE_TARGET),ES_W(_BX,CNODE_TARGET)));
                }
            }
            candidate=NEXT_CODE_NODE(_SI);
            _ES=FLOW_BLOCK_POOL_SEG;
            if (ES_W(_SI,CNODE_JUMP_KIND)==1 && !(ES_W(_SI,CNODE_FLAGS)&0x100)) {
                while (candidate && *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,candidate+CNODE_JUMP_REFS))==0) {
                    UNLINK_NODE(candidate);
                    _ES=FLOW_BLOCK_POOL_SEG;
                    next=ES_W(_SI,CNODE_NEXT);
                    candidate=NEXT_CODE_NODE(_SI);
                }
            }
            _ES=FLOW_BLOCK_POOL_SEG;
            switch (ES_W(_SI,CNODE_KIND)) {
            /* Code or asm block with no jump: an empty unreferenced code block is unlinked; a code
               block followed by an empty block that only jumps takes over that jump (and its 'jump
               fixed' flag). With a jump: a jump to the next block is removed; an unconditional jump
               to a block with one reference may pull that block up behind it; a conditional jump
               followed by an empty unconditional jump may be merged with it. */
            case 0: case 5:
                _ES=FLOW_BLOCK_POOL_SEG;
                if (ES_W(_SI,CNODE_JUMP_KIND)==0) {
                    if (ES_W(_SI,CNODE_OP_COUNT)==0 && ES_W(_SI,CNODE_KIND)==0 && ES_W(_SI,CNODE_JUMP_REFS)==0) {
                        UNLINK_NODE(_SI);
                        goto step;
                    }
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if (ES_W(_SI,CNODE_KIND)==5) goto step;
                    if (candidate==0) goto step;
                    _BX=candidate;
                    if (ES_W(_BX,CNODE_KIND)) goto step;
                    if (ES_W(_BX,CNODE_OP_COUNT)) goto step;
                    if (ES_W(_BX,CNODE_TARGET)==candidate) goto step;
                    if (ES_W(_BX,CNODE_JUMP_KIND)!=1) goto step;
                    ES_W(_SI,CNODE_JUMP_KIND)=1;
                    ES_W(_SI,CNODE_FLAGS)|=ES_W(_BX,CNODE_FLAGS)&0x100;
                    ES_W(_SI,CNODE_TARGET)=ES_W(_BX,CNODE_TARGET);
                    _BX=ES_W(_SI,CNODE_TARGET);
                    ++ES_W(_BX,CNODE_JUMP_REFS);
                    JUMP_OPT_CHANGED=1;
                    /* Preserve this store before the common step. */
                    _AX=_AX;
                    goto step;
                } else {
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if (ES_W(_SI,CNODE_FLAGS)&0x100) goto step;
                    if (candidate) {
                        _ES=FLOW_BLOCK_POOL_SEG;
                        if (ES_W(_SI,CNODE_TARGET)==candidate) {
                            _BX=candidate;
                            --ES_W(_BX,CNODE_JUMP_REFS);
                            ES_W(_SI,CNODE_JUMP_KIND)=0;
                            ES_W(_SI,CNODE_TARGET)=0;
                            goto changed;
                        }
                    }
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if (ES_W(_SI,CNODE_JUMP_KIND)==1) {
                        candidate=ES_W(_SI,CNODE_TARGET);
                        _BX=candidate;
                        if (ES_W(_BX,CNODE_JUMP_REFS)!=1) goto step;
                        MOVE_TARGET_AFTER_JUMP(_SI,candidate);
                        goto step;
                    }
                    if (candidate==0) goto step;
                    _BX=candidate;
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if (ES_W(_BX,CNODE_JUMP_KIND)!=1) goto step;
                    if (!IS_BLOCK_EMPTY(candidate)) goto step;
                    MERGE_JUMP_OVER_JUMP(_SI,candidate);
                    _ES=FLOW_BLOCK_POOL_SEG;
                    next=ES_W(_SI,CNODE_NEXT);
                    goto step;
                }
            /* Switch block: cases whose target only jumps are retargeted; cases that go to the
               default target are taken out of the list; with no cases left the block becomes a code
               block that jumps to the default. */
            case 4:
                previous=0;
                _ES=FLOW_BLOCK_POOL_SEG;
                _DI=ES_W(_SI,CNODE_CASE_LIST);
                while (_DI) {
                    _ES=CASE_ENTRY_POOL_SEG;
                    child=ES_W(_DI,SWCASE_TARGET);
                    if (IS_JUMP_ONLY_BLOCK(child)) {
                        _BX=child;
                        _ES=FLOW_BLOCK_POOL_SEG;
                        --ES_W(_BX,CNODE_JUMP_REFS);
                        _AX=ES_W(_BX,CNODE_TARGET);
                        _ES=CASE_ENTRY_POOL_SEG;
                        ES_W(_DI,SWCASE_TARGET)=_AX;
                        _BX=ES_W(_DI,SWCASE_TARGET);
                        _ES=FLOW_BLOCK_POOL_SEG;
                        ++ES_W(_BX,CNODE_JUMP_REFS);
                        _ES=CASE_ENTRY_POOL_SEG;
                        child=ES_W(_DI,SWCASE_TARGET);
                        JUMP_OPT_CHANGED=1;
                    }
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if (ES_W(_SI,CNODE_TARGET)==child) {
                        _BX=child;
                        --ES_W(_BX,CNODE_JUMP_REFS);
                        if (previous) {
                            _ES=CASE_ENTRY_POOL_SEG;
                            _AX=ES_W(_DI,SWCASE_NEXT);
                            _BX=previous;
                            ES_W(_BX,SWCASE_NEXT)=_AX;
                        } else {
                            _ES=CASE_ENTRY_POOL_SEG;
                            _AX=ES_W(_DI,SWCASE_NEXT);
                            _ES=FLOW_BLOCK_POOL_SEG;
                            ES_W(_SI,CNODE_CASE_LIST)=_AX;
                        }
                        JUMP_OPT_CHANGED=1;
                    } else previous=_DI;
                    _ES=CASE_ENTRY_POOL_SEG;
                    _DI=ES_W(_DI,SWCASE_NEXT);
                }
                _ES=FLOW_BLOCK_POOL_SEG;
                if (ES_W(_SI,CNODE_CASE_LIST)==0) {
                    ES_W(_SI,CNODE_KIND)=0;
                    ES_W(_SI,CNODE_JUMP_KIND)=1;
changed:
                    JUMP_OPT_CHANGED=1;
                }
                break;
            }
step:
            _SI=next;
        }
    } while(JUMP_OPT_CHANGED);
}

/* ---- IS_JUMP_ONLY_BLOCK (listing ovr_1dc1_b052:093B) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* IS_JUMP_ONLY_BLOCK: true when 'value' is an empty code block (IS_BLOCK_EMPTY) whose only
   effect is an unconditional jump to another block. */
static int near pascal IS_JUMP_ONLY_BLOCK(register unsigned int value)
{
    if (value) {
        if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value)) == 0 &&
            *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value + CNODE_JUMP_KIND)) == 1 &&
            IS_BLOCK_EMPTY(value)) {
            if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value + CNODE_TARGET)) != value)
                return 1;
        }
    }
    return 0;
}

/* ---- IS_BLOCK_EMPTY (listing ovr_1dc1_b052:0979) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
struct Descriptor { unsigned char prefix[3];long flags;unsigned char tail[12]; };
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
/* IS_BLOCK_EMPTY: true when code block 'node' produces no instructions: no ops, a single
   unreferenced op whose table flags are all 0, or only dead ops (COP_FLAGS 0x40). Other
   kinds are never empty. */
int far pascal IS_BLOCK_EMPTY(register unsigned int node)
{
    unsigned int offset;
    struct Descriptor near *entry;
    register unsigned int slot;
    unsigned int count;
    if(CNODE_W(node,CNODE_KIND)!=0) return 0;
    if(CNODE_W(node,CNODE_OP_COUNT)==0) return 1;
    if(CNODE_W(node,CNODE_OP_COUNT)==1 && CNODE_W(node,CNODE_JUMP_REFS)==0) {
        offset=CNODE_W(node,CNODE_FIRST_OP)<<2;
        entry=&OPCODE_DESCRIPTOR_TABLE[COP_B(offset,COP_OPCODE)];
        if(entry->flags==0L) return 1;
    }
    count=CNODE_W(node,CNODE_OP_COUNT);
    slot=CNODE_W(node,CNODE_FIRST_OP)<<2;
    while(count!=0) {
        if(!((unsigned int)COP_B(slot,COP_FLAGS)&0x40)) return 0;
        count--;
        slot+=4;
    }
    return 1;
}

/* ---- IS_SKIPPABLE_JUMP_TARGET (listing ovr_1dc1_b052:0A1D) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* IS_SKIPPABLE_JUMP_TARGET: true when block 'value' jumps to a block that can be jumped
   past: a scope entry or exit block, or an empty code block that falls through to a next
   block. */
static int near pascal IS_SKIPPABLE_JUMP_TARGET(register unsigned int value)
{
    if (!value || !*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value + CNODE_JUMP_KIND)))
        return 0;
    value = *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value + CNODE_TARGET));
    if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value)) == 1 ||
        *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value)) == 2)
        return 1;
    if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value)) == 0 && IS_BLOCK_EMPTY(value)) {
        if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value + CNODE_JUMP_KIND)) == 0 &&
            *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value + CNODE_NEXT)) != 0)
            return 1;
    }
    return 0;
}

/* ---- FIND_REAL_TARGET (listing ovr_1dc1_b052:0A81) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
#define W0(r) (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,(r))))

/* FIND_REAL_TARGET: from jump target 'value', skips labels, scope blocks and empty code
   blocks that fall through, and returns the first block that does something (the last
   block of the list if it runs off the end). That block gets one more reference and
   CNODE_FLAGS 0x10 (register contents unknown when it is entered). */
static unsigned int near pascal FIND_REAL_TARGET(register unsigned int value)
{
    for (; value; value = CNODE_W(value, CNODE_NEXT)) {
        if (W0(value) == 3 || W0(value) == 1 || W0(value) == 2)
            continue;
        if (W0(value) != 0 || CNODE_W(value, CNODE_JUMP_KIND) != 0 || !IS_BLOCK_EMPTY(value))
            break;
    }
    if (!value)
        value = CODE_BLOCK_LIST_TAIL;
    CNODE_W(value, CNODE_JUMP_REFS)++;
    CNODE_W(value, CNODE_FLAGS) |= 0x10;
    return value;
}
#undef W0

/* ---- ADD_TARGET_REF (listing ovr_1dc1_b052:0AE5) ---- */
static void near pascal ADD_TARGET_REF(unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* ADD_TARGET_REF: counts one more reference on the jump target of block 'node'. */
static void near pascal ADD_TARGET_REF(unsigned int node)
{
    register unsigned int cursor=node;
    register unsigned int linked;
    linked=((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,cursor))[8];
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,linked))[1]++;
}

/* ---- DROP_TARGET_REF (listing ovr_1dc1_b052:0B01) ---- */
static void near pascal DROP_TARGET_REF(register unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* DROP_TARGET_REF: counts one reference less on the jump target of block 'node'. */
static void near pascal DROP_TARGET_REF(register unsigned int node)
{
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,
        ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,node))[8]))[1]--;
}

/* ---- MOVE_TARGET_AFTER_JUMP (listing ovr_1dc1_b052:0B1B) ---- */
static unsigned int near pascal PREV_CODE_NODE(register unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;
/* MOVE_TARGET_AFTER_JUMP: block 'stop' jumps unconditionally to 'node', its only
   reference. If the block of code before 'node' ends with an unconditional jump (so
   nothing falls into 'node'), the run of unreferenced blocks from 'node' up to the first
   one ending in an unconditional jump is moved to just after 'stop', which then falls
   into it instead of jumping. If that run ends at 'stop' itself, the whole run is a loop
   nothing else reaches, and its blocks are unlinked. */
static void near pascal MOVE_TARGET_AFTER_JUMP(unsigned int stop,register unsigned int node)
{
    unsigned int previous,next,after;
    register unsigned int cursor;
    previous=PREV_CODE_NODE(node);
    if(previous==0) return;
    if(CNODE_W(previous,CNODE_JUMP_KIND)!=1) return;
    cursor=CNODE_W(node,CNODE_NEXT);
    while(cursor!=0) {
        if(CNODE_W(cursor,CNODE_JUMP_REFS)!=0) return;
        if(CNODE_W(cursor,CNODE_JUMP_KIND)==1) break;
        cursor=CNODE_W(cursor,CNODE_NEXT);
    }
    if(cursor==0) return;
    if(cursor==stop) {
        for(;;) {
            cursor=NEXT_CODE_NODE(node);
            if(CNODE_W(node,CNODE_JUMP_KIND)!=0 && CNODE_W(node,CNODE_JUMP_KIND)!=1)
                CNODE_W(CNODE_W(node,CNODE_TARGET),CNODE_JUMP_REFS)--;
            UNLINK_NODE(node);
            if(node==stop) break;
            node=cursor;
        }
    } else {
        after=CNODE_W(stop,CNODE_NEXT);
        next=CNODE_W(cursor,CNODE_NEXT);
        previous=CNODE_W(node,CNODE_PREV);
        CNODE_W(previous,CNODE_NEXT)=next;
        if(next!=0)
            CNODE_W(next,CNODE_PREV)=previous;
        CNODE_W(cursor,CNODE_NEXT)=after;
        CNODE_W(after,CNODE_PREV)=cursor;
        CNODE_W(stop,CNODE_NEXT)=node;
        CNODE_W(node,CNODE_PREV)=stop;
        CNODE_W(stop,CNODE_JUMP_KIND)=0;
        CNODE_W(stop,CNODE_TARGET)=0;
    }
}

/* ---- MERGE_JUMP_OVER_JUMP (listing ovr_1dc1_b052:0C1D) ---- */
int far pascal INVERT_JUMP_CONDITION(unsigned int index);
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* MERGE_JUMP_OVER_JUMP: 'first' jumps conditionally to the block after 'second', which is
   an empty block with an unconditional jump. The condition of 'first' is inverted and it
   now jumps to the target of 'second', which is unlinked ('jcc L1; jmp L2; L1:' becomes
   'jncc L2; L1:'). Word 2 is CNODE_JUMP_REFS. */
static void near pascal MERGE_JUMP_OVER_JUMP(unsigned int first, unsigned int second)
{
    register unsigned int destination = first;
    register unsigned int source = second;
    unsigned int current;

    current = NEXT_CODE_NODE(source);
    if (!current)
        return;
    if (*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, destination + CNODE_TARGET) != current)
        return;
    --*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, current + CNODE_JUMP_REFS);
    *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, destination + CNODE_TARGET) =
        *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, source + CNODE_TARGET);
    ++*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,
        *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, destination + CNODE_TARGET) + 2);
    *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, destination + CNODE_JUMP_KIND) =
        INVERT_JUMP_CONDITION(*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, destination + CNODE_JUMP_KIND));
    UNLINK_NODE(source);
}

/* ---- INVERT_JUMP_CONDITION (listing ovr_1dc1_b052:0C80) ---- */

/* INVERT_JUMP_CONDITION: the jump kind with the opposite condition, from
   JUMP_CONDITION_INVERSE_TABLE. */
int far pascal INVERT_JUMP_CONDITION(unsigned int index)
{
    return JUMP_CONDITION_INVERSE_TABLE[index];
}

/* ---- RETARGET_JUMP (listing ovr_1dc1_b052:0C91) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int JUMP_OPT_CHANGED;

/* RETARGET_JUMP: makes block 'first' jump to 'second' instead, moving the reference count. */
static void near pascal RETARGET_JUMP(register unsigned int first, unsigned int second)
{
    DROP_TARGET_REF(first);
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, first))[8] = second;
    ADD_TARGET_REF(first);
    JUMP_OPT_CHANGED = 1;
}

/* ---- UNLINK_NODE (listing ovr_1dc1_b052:0CB8) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int JUMP_OPT_CHANGED;


/* UNLINK_NODE: takes block 'value' out of the function's list (fixing the head and tail)
   and, if it was a jump-only block, drops its reference on its target. The block is not
   freed. */
void far pascal UNLINK_NODE(register unsigned int value)
{
    if (value == CODE_BLOCK_LIST_HEAD)
        CODE_BLOCK_LIST_HEAD = CNODE_W(value, CNODE_NEXT);
    if (value == CODE_BLOCK_LIST_TAIL)
        CODE_BLOCK_LIST_TAIL = CNODE_W(value, CNODE_PREV);
    if (IS_JUMP_ONLY_BLOCK(value))
        DROP_TARGET_REF(value);
    if (CNODE_W(value, CNODE_PREV) != 0)
        CNODE_W(CNODE_W(value, CNODE_PREV), CNODE_NEXT) = CNODE_W(value, CNODE_NEXT);
    if (CNODE_W(value, CNODE_NEXT) != 0)
        CNODE_W(CNODE_W(value, CNODE_NEXT), CNODE_PREV) = CNODE_W(value, CNODE_PREV);
    JUMP_OPT_CHANGED = 1;
}

/* ---- NEXT_CODE_NODE (listing ovr_1dc1_b052:0D26) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* NEXT_CODE_NODE: the next block after 'node' that is not a scope entry or exit block, or
   0. */
static unsigned int near pascal NEXT_CODE_NODE(register unsigned int node)
{
next:
    node=((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,node))[6];
    if(node)
        goto nonzero;
    return node;
nonzero:
    switch(*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,node)) {
    case 1:
    case 2:
        goto next;
    default:
        return node;
    }
}

/* ---- PREV_CODE_NODE (listing ovr_1dc1_b052:0D57) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* PREV_CODE_NODE: the same backwards. */
static unsigned int near pascal PREV_CODE_NODE(register unsigned int node)
{
next:
    node=((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,node))[7];
    if(node)
        goto nonzero;
    return node;
nonzero:
    switch(*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,node)) {
    case 1:
    case 2:
        goto next;
    default:
        return node;
    }
}

/* target: ovr172_C106UNIT */
/* Role: cross-jumping (merging common code tails). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO070 (ovr_1dc5_b0d9) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the cross-jumping pass, run by GENERATE_FUNCTION_CODE (through
   CROSS_JUMP_PASS_STUB) after register allocation when optimising (OPTIMIZE_ENABLED).
   When several code blocks continue at the same place (by falling through or by an
   unconditional jump) and end with the same instructions, those instructions are kept
   once: one block keeps them in a new block of its own and the others are cut short and
   jump to it. This saves space and is why some original functions share code tails,
   which made them hard to byte-match (docs/SUBSYSTEMS.md).
   Data: each flow block's CNODE_PRED_LIST heads a list, linked through CNODE_PRED_NEXT,
   of the code blocks that reach it this way. Two ops are 'equal' when opcode, COP_FLAGS,
   register and operands match (OPERAND_TREES_EQUAL); because registers are already
   assigned, the register history entries (REGALLOC.C) attached to the ops must match too.
   Table flags used: 1 variable leaf, 8 constant, 0x20 raw operand word. The pass repeats
   while CROSS_JUMP_CHANGED says a block was emptied (which can open new merges). The
   _BX/_ES/_SI/_DI register code throughout is a shape kept for byte matching. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"



/* ---- OPERAND_TREES_EQUAL (listing ovr_1dc5_b0d9:0D90) ---- */
static int far pascal OPERAND_TREES_EQUAL(unsigned int left,unsigned int right);
extern unsigned int VARIABLE_TABLE_SEG;
struct Descriptor { unsigned char prefix[3]; long flags; unsigned char tail[12]; };
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
/* OPERAND_TREES_EQUAL: true when code ops 'left' and 'right' (op numbers, 0 for none)
   compute the same operand. Ops not folded into their parent (COP_FLAGS 1 clear) are
   equal when they sit in the same register. Folded ops must have the same opcode, flags
   and register, then: variable leaves name the same variable and offset, or register
   variables in the same register; constants have the same long value; raw-word ops the
   same word; other ops have equal operand trees, compared recursively. */
static int far pascal OPERAND_TREES_EQUAL(unsigned int left,unsigned int right)
{
    unsigned int first,second;
    struct Descriptor near *entry;
    register unsigned int lpos,rpos;
    if (left==0) return right==0;
    if (right==0) return 0;
    lpos=left<<2;
    rpos=right<<2;
    if ((COP_B(lpos,COP_FLAGS)&1)==0 && (COP_B(rpos,COP_FLAGS)&1)==0)
        return COP_B(lpos,COP_REGISTER)==COP_B(rpos,COP_REGISTER);
    if (COP_B(lpos,COP_OPCODE)!=COP_B(rpos,COP_OPCODE) ||
        COP_B(lpos,COP_FLAGS)!=COP_B(rpos,COP_FLAGS) ||
        COP_B(lpos,COP_REGISTER)!=COP_B(rpos,COP_REGISTER)) return 0;
    entry=&OPCODE_DESCRIPTOR_TABLE[COP_B(lpos,COP_OPCODE)];
    if (entry->flags&1L) {
        first=OPND_W(lpos,OPND_LEFT);
        second=OPND_W(rpos,OPND_LEFT);
        if (VAR_B(first,VAR_FLAGS)&2) {
            if (VAR_B(second,VAR_FLAGS)&2)
                return VAR_B(first,VAR_REGISTER)==VAR_B(second,VAR_REGISTER);
        }
        return first==second && OPND_W(lpos,OPND_RIGHT)==OPND_W(rpos,OPND_RIGHT);
    } else if (entry->flags&8L) {
        return OPND_L(lpos,OPND_LEFT)==OPND_L(rpos,OPND_LEFT);
    } else if (entry->flags&0x20L) {
        return OPND_W(lpos,OPND_LEFT)==OPND_W(rpos,OPND_LEFT);
    } else {
        return OPERAND_TREES_EQUAL(OPND_W(lpos,OPND_LEFT),OPND_W(rpos,OPND_LEFT)) &&
            OPERAND_TREES_EQUAL(OPND_W(lpos,OPND_RIGHT),OPND_W(rpos,OPND_RIGHT));
    }
}

/* ---- COUNT_BLOCK_HISTORY_ENTRIES (listing ovr_1dc5_b0d9:0F25) ---- */
static unsigned int far pascal COUNT_BLOCK_HISTORY_ENTRIES(unsigned int value);
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* COUNT_BLOCK_HISTORY_ENTRIES: counts the register history entries of block 'value':
   those from its CNODE_HISTORY on whose op number lies in the block's op range. */
static unsigned int far pascal COUNT_BLOCK_HISTORY_ENTRIES(unsigned int value)
{
    unsigned int end;

    _DX = value;
    _BX = _DX;
    _ES = FLOW_BLOCK_POOL_SEG;
    _AX = *((unsigned int far *)MK_FP(_ES, _BX + CNODE_FIRST_OP));
    _CX = _AX;
    _AX += *((unsigned int far *)MK_FP(_ES, _BX + CNODE_OP_COUNT));
    _AX--;
    end = _AX;
    _SI = *((unsigned int far *)MK_FP(_ES, _BX + CNODE_HISTORY));
    _DI = 0;
    goto condition;
advance:
    _SI += 9;
    _DI++;
condition:
    if (_SI >= HISTORY_END_OFFSET)
        goto done;
    _ES = REG_HISTORY_POOL_SEG;
    _AX = *((unsigned int far *)MK_FP(_ES, _SI + RHIST_INSN_INDEX));
    if (_AX < _CX)
        goto done;
    _AX = *((unsigned int far *)MK_FP(_ES, _SI + RHIST_INSN_INDEX));
    if (_AX <= end)
        goto advance;
done:
    return _DI;
}

/* ---- SPLIT_COMMON_TAIL (listing ovr_1dc5_b0d9:0F74) ---- */
static unsigned int far pascal SPLIT_COMMON_TAIL(unsigned int left,unsigned int right);
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal NEW_BLOCK(void);
#define FLAGS (*((unsigned long near *)(description+3)))
/* SPLIT_COMMON_TAIL: compares blocks 'left' and 'right' backwards from their last ops
   (skipping dead ops, COP_FLAGS 0x40) and their history entries backwards in step. If at
   least one op matches, the matching tail of 'right' is moved into a new block placed
   after 'right' (taking over right's closing jump), 'right' now falls into it, 'left' is
   shortened by the same ops and jumps to it. The new block gets CNODE_FLAGS 0x10
   (register contents unknown at its start) and its history starts at the first entry of
   its ops. Returns the new block, or 'right' when nothing matched. */
static unsigned int far pascal SPLIT_COMMON_TAIL(unsigned int left,unsigned int right)
{
    unsigned int position1,position2,changed,equal,count1,count2,remaining1,remaining2,result;
    unsigned char near *description;
    unsigned int symbol1,symbol2;
    register unsigned int history2,history1;
    _BX=left; _ES=FLOW_BLOCK_POOL_SEG; count1=ES_W(_BX,CNODE_OP_COUNT);
    _BX=right; count2=ES_W(_BX,CNODE_OP_COUNT);
    _BX=left; position1=(ES_W(_BX,CNODE_FIRST_OP)+count1-1)*4;
    _BX=right; position2=(ES_W(_BX,CNODE_FIRST_OP)+count2-1)*4;
    remaining1=COUNT_BLOCK_HISTORY_ENTRIES(left);
    remaining2=COUNT_BLOCK_HISTORY_ENTRIES(right);
    _BX=left; _ES=FLOW_BLOCK_POOL_SEG; history1=ES_W(_BX,CNODE_HISTORY)+remaining1*9+(-9);
    _BX=right; history2=ES_W(_BX,CNODE_HISTORY)+remaining2*9+(-9);
    changed=0;
    /* Walk back over both blocks while the ops match. */
    while(count1!=0 && count2!=0) {
        _BX=position1; _ES=CODE_OP_POOL_SEG;
        if(ES_B(_BX,COP_FLAGS)&0x40) {position1-=4;count1--;continue;}
        _BX=position2; _ES=CODE_OP_POOL_SEG;
        if(ES_B(_BX,COP_FLAGS)&0x40) {position2-=4;count2--;continue;}
        _ES=CODE_OP_POOL_SEG;
        if(ES_B(position1,COP_OPCODE)!=ES_B(position2,COP_OPCODE)) break;
        if(ES_B(position1,COP_FLAGS)!=ES_B(position2,COP_FLAGS)) break;
        if(ES_B(position1,COP_REGISTER)!=ES_B(position2,COP_REGISTER)) break;
        _ES=CODE_OP_POOL_SEG;
        description=CODE_OP_INFO_TABLE-3+ES_B(position1,COP_OPCODE)*19;
        if((FLAGS&1L)!=0L) {
            _ES=CODE_OPERAND_POOL_SEG;
            symbol1=ES_W(position1,OPND_VARIABLE); symbol2=ES_W(position2,OPND_VARIABLE);
            _BX=symbol1; _ES=VARIABLE_TABLE_SEG;
            if((ES_B(_BX,VAR_FLAGS)&2) && (ES_B(symbol2,VAR_FLAGS)&2)) {
                if(ES_B(symbol1,VAR_REGISTER)!=ES_B(symbol2,VAR_REGISTER)) break;
            } else {
                if(symbol1!=symbol2) break;
                _ES=CODE_OPERAND_POOL_SEG;
                if(ES_W(position1,OPND_RIGHT)!=ES_W(position2,OPND_RIGHT)) break;
            }
        } else if((FLAGS&8L)!=0L) {
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_UL(position1,OPND_CONST_VALUE)!=ES_UL(position2,OPND_CONST_VALUE)) break;
        } else if((FLAGS&32L)!=0L) {
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_W(position1,OPND_LEFT)!=ES_W(position2,OPND_LEFT)) break;
        } else {
            _ES=CODE_OPERAND_POOL_SEG;
            if(!OPERAND_TREES_EQUAL(ES_W(position1,OPND_LEFT),ES_W(position2,OPND_LEFT))) break;
            _ES=CODE_OPERAND_POOL_SEG;
            if(!OPERAND_TREES_EQUAL(ES_W(position1,OPND_RIGHT),ES_W(position2,OPND_RIGHT))) break;
        }
        /* The history entries of the two ops must match one for one: the same action, size and
           register, and the moved values in the same registers. 'equal' stays 1 when both ops
           have no (more) entries. */
        equal=1;
        for(;;) {
            if(remaining1==0 || *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG,history1+RHIST_INSN_INDEX))!=(*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,left+CNODE_FIRST_OP)))+count1-1) {
                equal=remaining2==0 || *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG,history2+RHIST_INSN_INDEX))!=(*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,right+CNODE_FIRST_OP)))+count2-1;
                break;
            }
            if(remaining2==0 || *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG,history2+RHIST_INSN_INDEX))!=(*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,right+CNODE_FIRST_OP)))+count2-1) {equal=0;break;}
            _ES=REG_HISTORY_POOL_SEG;
            if(ES_B(history1,RHIST_ACTION)!=ES_B(history2,RHIST_ACTION) || ES_B(history1,RHIST_IS_WORD)!=ES_B(history2,RHIST_IS_WORD) || ES_B(history1,RHIST_REGISTER)!=ES_B(history2,RHIST_REGISTER) ||
               (_BX=ES_W(history1,RHIST_VALUE_OP),_BX<<=2,_ES=CODE_OP_POOL_SEG,ES_B(_BX,COP_REGISTER))!=
               (_ES=REG_HISTORY_POOL_SEG,_BX=ES_W(history2,RHIST_VALUE_OP),_BX<<=2,_ES=CODE_OP_POOL_SEG,ES_B(_BX,COP_REGISTER))) {equal=0;break;}
            history1-=9;history2-=9;remaining1--;remaining2--;
        }
        if(!equal) break;
        count1--; position1-=4; count2--; position2-=4;
        changed=1;
    }
    if(changed) {
        result=NEW_BLOCK();
        _ES=FLOW_BLOCK_POOL_SEG;
        ES_W(result,CNODE_KIND)=0;
        ES_W(result,CNODE_JUMP_KIND)=ES_W(right,CNODE_JUMP_KIND);
        ES_W(result,CNODE_TARGET)=ES_W(right,CNODE_TARGET);
        ES_W(right,CNODE_JUMP_KIND)=0; ES_W(right,CNODE_TARGET)=0;
        ES_W(result,CNODE_OP_COUNT)=ES_W(right,CNODE_OP_COUNT)-count2;
        ES_W(result,CNODE_FIRST_OP)=ES_W(right,CNODE_FIRST_OP)+count2;
        ES_W(right,CNODE_OP_COUNT)=count2; ES_W(left,CNODE_OP_COUNT)=count1;
        ES_W(result,CNODE_NEXT)=ES_W(right,CNODE_NEXT);
        history2=ES_W(right,CNODE_HISTORY);
        while(history2<HISTORY_END_OFFSET && (_ES=REG_HISTORY_POOL_SEG,ES_W(history2,RHIST_INSN_INDEX))!=0 &&
              ES_W(history2,RHIST_INSN_INDEX)<(_BX=result,_ES=FLOW_BLOCK_POOL_SEG,ES_W(_BX,CNODE_FIRST_OP)))
            history2+=9;
        _BX=result; _ES=FLOW_BLOCK_POOL_SEG;
        ES_W(_BX,CNODE_HISTORY)=history2;
        ES_W(right,CNODE_NEXT)=result;
        ES_W(ES_W(result,CNODE_NEXT),CNODE_PREV)=result;
        ES_W(result,CNODE_PREV)=right;
        ES_W(left,CNODE_TARGET)=result;
        ES_W(result,CNODE_FLAGS)=16;
        if(count1==0 || count2==0) CROSS_JUMP_CHANGED=1;
        return result;
    }
    return right;
}
#undef FLAGS

/* ---- CROSS_JUMP_PASS (listing ovr_1dc5_b0d9:13A2) ---- */
static void far pascal CROSS_JUMP_PASS(void);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char OPTION_OPTIMIZE_SPEED;
/* CROSS_JUMP_PASS: runs the cross-jumping described in the overview over the current
   function's block list until nothing changes. */
static void far pascal CROSS_JUMP_PASS(void)
{
    unsigned int node,candidate,previous,flag;
    do {
        if(CTRL_BREAK_SEEN!=0) LINE_HOOK();
        CROSS_JUMP_CHANGED=0;
        for(node=CODE_BLOCK_LIST_HEAD;node!=0;node=ES_W(_BX,CNODE_NEXT)) {
            _BX=node; _ES=FLOW_BLOCK_POOL_SEG; ES_W(_BX,CNODE_PRED_LIST)=0;
        }
        /* First walk: for each non-empty code block that falls through or jumps unconditionally,
           find where it really continues (skipping scope blocks and empty blocks, following
           empty jump blocks; a block that ends up reaching its target by a jump is given that
           jump directly) and add it to that block's predecessor list. A falling-through block
           goes to the head of the list, jumping blocks go after the head, so the head is the
           block that can keep the tail without a jump. */
        for(node=CODE_BLOCK_LIST_HEAD;node!=0;node=(_BX=node,_ES=FLOW_BLOCK_POOL_SEG,ES_W(_BX,CNODE_NEXT))) {
            _ES=FLOW_BLOCK_POOL_SEG; _BX=node;
            if(ES_W(_BX,CNODE_KIND)!=0) goto next;
            if(ES_W(_BX,CNODE_OP_COUNT)==0) goto next;
            if(ES_W(_BX,CNODE_JUMP_KIND)==1) {_SI=ES_W(_BX,CNODE_TARGET);flag=0;}
            else {
                _BX=node;_ES=FLOW_BLOCK_POOL_SEG;
                if(ES_W(_BX,CNODE_JUMP_KIND)!=0) goto next;
                _SI=ES_W(_BX,CNODE_NEXT);flag=1;
                if(_SI==0) goto next;
            }
            while((_ES=FLOW_BLOCK_POOL_SEG,ES_W(_SI,CNODE_NEXT))!=0) {
                _ES=FLOW_BLOCK_POOL_SEG;
                if(ES_W(_SI,CNODE_KIND)==1 || ES_W(_SI,CNODE_KIND)==2) {
                    _ES=FLOW_BLOCK_POOL_SEG;_SI=ES_W(_SI,CNODE_NEXT);continue;
                }
                _ES=FLOW_BLOCK_POOL_SEG;
                if(ES_W(_SI,CNODE_KIND)!=0 || ES_W(_SI,CNODE_OP_COUNT)!=0) break;
                if(ES_W(_SI,CNODE_JUMP_KIND)==0) {_SI=ES_W(_SI,CNODE_NEXT);continue;}
                _ES=FLOW_BLOCK_POOL_SEG;
                if(ES_W(_SI,CNODE_JUMP_KIND)==1) {_SI=ES_W(_SI,CNODE_TARGET);flag=0;}
                break;
            }
            if(flag==0) {
                _BX=node;_ES=FLOW_BLOCK_POOL_SEG;ES_W(_BX,CNODE_JUMP_KIND)=1;ES_W(_BX,CNODE_TARGET)=_SI;
            }
            if(flag!=0) goto insert;
            _ES=FLOW_BLOCK_POOL_SEG;
            if(ES_W(_SI,CNODE_PRED_LIST)!=0) goto splice;
insert:
            {
                _ES=FLOW_BLOCK_POOL_SEG;_AX=ES_W(_SI,CNODE_PRED_LIST);_BX=node;ES_W(_BX,CNODE_PRED_NEXT)=_AX;
                _AX=node;ES_W(_SI,CNODE_PRED_LIST)=_AX;
            }
            goto next;
splice:
            {
                _ES=FLOW_BLOCK_POOL_SEG;_BX=ES_W(_SI,CNODE_PRED_LIST);_AX=ES_W(_BX,CNODE_PRED_NEXT);_BX=node;ES_W(_BX,CNODE_PRED_NEXT)=_AX;
                _BX=ES_W(_SI,CNODE_PRED_LIST);_AX=node;ES_W(_BX,CNODE_PRED_NEXT)=_AX;
            }
next:;
        }
        for(node=CODE_BLOCK_LIST_HEAD;node!=0;node=(_BX=node,_ES=FLOW_BLOCK_POOL_SEG,ES_W(_BX,CNODE_NEXT))) {
            /* Second walk: for each block, take its predecessors in list order and compare each
               ('candidate', starting as the head) with every predecessor after it, splitting off
               common tails. Once a tail has been split off, 'candidate' is the new tail block and
               each later predecessor compared with it is unlinked from the list. When optimising
               for speed (OPTION_OPTIMIZE_SPEED), the walk stops at a predecessor that jumps, since
               merging would only add jumps. */
            _BX=node;_ES=FLOW_BLOCK_POOL_SEG;_SI=ES_W(_BX,CNODE_PRED_LIST);
            while(_SI!=0) {
                if(OPTION_OPTIMIZE_SPEED!=0) {
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if(ES_W(_SI,CNODE_JUMP_KIND)!=0) break;
                }
                candidate=_SI; previous=_SI;
                _ES=FLOW_BLOCK_POOL_SEG;_DI=ES_W(_SI,CNODE_PRED_NEXT);
                while(_DI!=0) {
                    candidate=SPLIT_COMMON_TAIL(_DI,candidate);
                    if(candidate!=_SI) {
                        _ES=FLOW_BLOCK_POOL_SEG;_DI=ES_W(_DI,CNODE_PRED_NEXT);_BX=previous;ES_W(_BX,CNODE_PRED_NEXT)=_DI;
                    } else {
                        previous=_DI;_ES=FLOW_BLOCK_POOL_SEG;_DI=ES_W(_DI,CNODE_PRED_NEXT);
                    }
                }
                _ES=FLOW_BLOCK_POOL_SEG;_SI=ES_W(_SI,CNODE_PRED_NEXT);
            }
        }
    } while(CROSS_JUMP_CHANGED!=0);
}

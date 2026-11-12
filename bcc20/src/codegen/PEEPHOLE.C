/* target: ovr173_C101UNIT */
/* Role: peephole pass over the code-node list: tracks register contents, drops redundant
   loads. Entry points: ELIMINATE_REDUNDANT_LOADS. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO071 (ovr_1dc8_b159) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the redundant-load pass, run by GENERATE_FUNCTION_CODE after register
   allocation when optimising. It walks the function's code ops in block order and keeps,
   for each of the 16 registers, a slot (struct Slot at DS:8762, 4 bytes each: the op
   whose value the register holds and the store stamp at that moment). An op whose value
   is already in its register is marked dead (COP_FLAGS 0x40) so no load is emitted; a
   memory operand folded into an instruction (COP_FLAGS 1) whose value already sits in a
   register the instruction accepts is turned into that register (MARK_REDUNDANT_OPERAND).
   Validity is tracked with stamps: PEEPHOLE_STORE_STAMP counts stores, each variable
   keeps the stamp of its last store (VAR_STORE_STAMP) and PEEPHOLE_MEMORY_STORE_STAMP
   that of the last store through a pointer, which may change any variable kept in memory
   unless OPTION_SUPPRESS_RELOADS (probably -Z, 'suppress redundant loads') says to assume
   it does not. All slots are forgotten at a block whose register contents are unknown
   (CNODE_FLAGS 0x10, e.g. a jump target), at inline-assembler blocks (kind 5) and after
   an op with table flag 0x400 (probably a call or another op that destroys everything);
   other ops forget the registers they destroy (REGISTER_MASK_TABLE[tail[5]]). Register
   history entries (pops, moves, exchanges) also overwrite slots. Table entry bytes used:
   flags (1 variable leaf, 8 constant, 0x20 raw word operand, 4 writes its left operand,
   0x100, 0x400), tail[2]/tail[3] the register classes allowed for the left/right operand
   (REG_CLASS_MASK_TABLE), tail[5] the destroyed-register set. The _SI/_DI/_ES register
   code is a shape kept for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- CLEAR_REGISTER_SLOTS (listing ovr_1dc8_b159:1590) ---- */
static void near pascal CLEAR_REGISTER_SLOTS(void);
/* CLEAR_REGISTER_SLOTS: forgets the contents of all 16 register slots (the value words
   from DS:8762 to DS:879E) and the last pointer store. */
static void near pascal CLEAR_REGISTER_SLOTS(void)
{
    register unsigned int near *cursor;
    for(cursor=(unsigned int near *)0x8762;cursor<=(unsigned int near *)0x879E;cursor+=2)
        *cursor=0;
    PEEPHOLE_MEMORY_STORE_STAMP=0;
}

/* ---- CLEAR_SLOTS_BY_MASK (listing ovr_1dc8_b159:15B1) ---- */
/* CLEAR_SLOTS_BY_MASK: forgets the slots of the registers whose bits are set in 'mask'. */
static void near pascal CLEAR_SLOTS_BY_MASK(unsigned int mask)
{
    register unsigned int near *cursor;
    register unsigned int bits;
    bits=mask;
    cursor=(unsigned int near *)0x8762;
    while(bits) {
        if(bits&1) *cursor=0;
        cursor+=2;
        bits>>=1;
    }
}

/* ---- REGISTER_HOLDS_VALUE (listing ovr_1dc8_b159:15D9) ---- */
static int near pascal REGISTER_HOLDS_VALUE(unsigned int left,unsigned int right,unsigned int limit);
extern unsigned int VARIABLE_TABLE_SEG;
struct Descriptor { unsigned char prefix[3]; long flags; unsigned char tail[12]; };
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
/* REGISTER_HOLDS_VALUE: true when op 'right' computes the same value as op 'left', the
   value a register was loaded with when the store stamp was 'limit'. Only leaves count:
   the same opcode (not a table flag 0x400 op) and either the same variable and offset
   (always true for a constant address, flags 1 and 8; otherwise only if the variable was
   not stored since, not hit by a later pointer store when it lives in memory, and not
   flagged 0x80, probably volatile) or, for constants, the same long value. */
static int near pascal REGISTER_HOLDS_VALUE(unsigned int left,unsigned int right,unsigned int limit)
{
    if (left==0) goto failed;
    _SI=left<<2;
    _DI=right<<2;
    _ES=CODE_OP_POOL_SEG;
    if (ES_B(_SI,COP_OPCODE)!=ES_B(_DI,COP_OPCODE)) goto failed;
    _ES=CODE_OP_POOL_SEG;
    if (OPCODE_DESCRIPTOR_TABLE[ES_B(_SI,COP_OPCODE)].flags&0x400L) goto failed;
    _ES=CODE_OP_POOL_SEG;
    if (OPCODE_DESCRIPTOR_TABLE[ES_B(_SI,COP_OPCODE)].flags&1L) {
        _ES=CODE_OPERAND_POOL_SEG;
        if (ES_W(_SI,OPND_LEFT)!=ES_W(_DI,OPND_LEFT) || ES_W(_SI,OPND_RIGHT)!=ES_W(_DI,OPND_RIGHT)) return 0;
        _ES=CODE_OP_POOL_SEG;
        if (OPCODE_DESCRIPTOR_TABLE[ES_B(_SI,COP_OPCODE)].flags&8L) return 1;
        _ES=CODE_OPERAND_POOL_SEG;
        _AX=ES_W(_SI,OPND_LEFT);
        _CX=_AX;
        _BX=_CX;
        _ES=VARIABLE_TABLE_SEG;
        if (ES_W(_BX,VAR_STORE_STAMP)>limit) { _SI=_SI; goto failed; }
        _BX=_CX;
        _ES=VARIABLE_TABLE_SEG;
        if ((ES_B(_BX,VAR_FLAGS)&4) && PEEPHOLE_MEMORY_STORE_STAMP>limit) { _SI=_SI; goto failed; }
        _BX=_CX;
        _ES=VARIABLE_TABLE_SEG;
        if (ES_B(_BX,VAR_FLAGS)&0x80) { _SI=_SI; goto failed; }
        return 1;
    } else {
        _ES=CODE_OP_POOL_SEG;
        if (OPCODE_DESCRIPTOR_TABLE[ES_B(_SI,COP_OPCODE)].flags&8L) {
            _ES=CODE_OPERAND_POOL_SEG;
            return *((long far *)MK_FP(_ES,_SI))==*((long far *)MK_FP(_ES,_DI));
        }
    }
failed:
    return 0;
}

/* ---- FIND_ASSIGNED_REGISTER (listing ovr_1dc8_b159:170B) ---- */
static unsigned char near pascal FIND_ASSIGNED_REGISTER(unsigned int value);


/* FIND_ASSIGNED_REGISTER: the register op 'value' occupies at its own position: the last
   history entry at or before it that moves the value (following exchanges, action 6,
   backwards to the partner op), or else its COP_REGISTER. REGALLOC.C has the same search. */
static unsigned char near pascal FIND_ASSIGNED_REGISTER(unsigned int value)
{
    register unsigned int entry;

    entry = HISTORY_END_OFFSET;
    while (entry) {
        entry -= 9;
        if (RHIST_W(entry, RHIST_INSN_INDEX) > value)
            continue;
        if (RHIST_W(entry, RHIST_VALUE_OP) == value) {
            if (RHIST_B(entry, RHIST_ACTION) == 6) {
                value = RHIST_W(entry, RHIST_PARTNER);
                continue;
            }
            return RHIST_B(entry, RHIST_REGISTER);
        } else {
            if (RHIST_B(entry, RHIST_ACTION) == 6 && RHIST_W(entry, RHIST_PARTNER) == value)
                value = RHIST_W(entry, RHIST_VALUE_OP);
        }
    }
    return *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, (value << 2) + COP_REGISTER));
}

/* ---- MARK_REDUNDANT_OPERAND (listing ovr_1dc8_b159:1774) ---- */
static void far pascal MARK_REDUNDANT_OPERAND(unsigned int second, unsigned int first);

/* MARK_REDUNDANT_OPERAND: folded operand op 'second' may use registers of class 'first'.
   If one of them already holds its value, the operand becomes that register: COP_REGISTER
   is set and the op is marked dead (0x40) apart from its folded flag, so it is emitted as
   a register operand and its own load disappears. */
static void far pascal MARK_REDUNDANT_OPERAND(unsigned int second, unsigned int first)
{
    unsigned int mask;
    unsigned char index;
    register unsigned int near *cursor;
    register unsigned int entry;

    mask = REG_CLASS_MASK_TABLE[first];
    cursor = (unsigned int near *)0x8762;
    index = 0;
    while (mask) {
        if ((mask & 1) && cursor[0] &&
                REGISTER_HOLDS_VALUE(cursor[0], second, cursor[1])) {
            entry = second << 2;
            *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, entry + COP_REGISTER)) = FIND_ASSIGNED_REGISTER(second);
            *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, entry + COP_FLAGS)) &= 1;
            *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, entry + COP_FLAGS)) |= 0x40;
            return;
        }
        cursor += 2;
        index++;
        mask >>= 1;
    }
}

/* ---- STAOV15E (listing ovr_1dc8_b159:17E6) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;

struct Slot { unsigned int value,stamp; };
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
extern signed char far pascal GET_ASSIGNED_REGISTER(unsigned int);
#define SLOT(n) (((struct Slot near *)0x8762)+(n))
/* ELIMINATE_REDUNDANT_LOADS: the pass described in the overview, over the current
   function. Stamps start at 0 for every variable. */
void far pascal ELIMINATE_REDUNDANT_LOADS(void)
{
    unsigned int current,left,right,node,index,leftIndex,rightIndex,count;
    struct Slot near *slot;
    struct Descriptor near *entry;
    CLEAR_REGISTER_SLOTS();
    PEEPHOLE_STORE_STAMP=0;
    for (node=2;node<VARIABLE_TABLE_END;node+=29) {
        _BX=node;
        _ES=VARIABLE_TABLE_SEG;
        ES_W(_BX,VAR_STORE_STAMP)=0;
    }
    for (current=CODE_BLOCK_LIST_HEAD;current;current=ES_W(_BX,CNODE_NEXT)) {
        _BX=current;
        _ES=FLOW_BLOCK_POOL_SEG;
        if (ES_W(_BX,CNODE_FLAGS)&0x10) CLEAR_REGISTER_SLOTS();
        _ES=FLOW_BLOCK_POOL_SEG;
        _BX=current;
        if (ES_W(_BX,CNODE_KIND)==5) CLEAR_REGISTER_SLOTS();
        _ES=FLOW_BLOCK_POOL_SEG;
        _BX=current;
        if (ES_W(_BX,CNODE_KIND)==0 || ES_W(_BX,CNODE_KIND)==4) {
            _BX=current;
            _ES=FLOW_BLOCK_POOL_SEG;
            index=ES_W(_BX,CNODE_FIRST_OP);
            count=ES_W(_BX,CNODE_OP_COUNT);
            _SI=index<<2;
            _DI=ES_W(_BX,CNODE_HISTORY);
            while (count) {
                while (_DI<HISTORY_END_OFFSET && *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG,_DI+RHIST_INSN_INDEX))==index) {
                    _ES=REG_HISTORY_POOL_SEG;
                    switch ((unsigned int)ES_B(_DI,RHIST_ACTION)) {
                    case 6:
                        _ES=REG_HISTORY_POOL_SEG;
                        left=ES_W(_DI,RHIST_VALUE_OP)<<2;
                        _BX=left;
                        _ES=CODE_OP_POOL_SEG;
                        SLOT((int)ES_SC(_BX,COP_REGISTER))->value=0;
                    case 2: case 3:
                        _ES=REG_HISTORY_POOL_SEG;
                        SLOT((int)ES_SC(_DI,RHIST_REGISTER))->value=0;
                        break;
                    }
                    _DI+=9;
                }
                _ES=CODE_OP_POOL_SEG;
                if (ES_B(_SI,COP_FLAGS)&0x41) goto advance;
                _ES=CODE_OP_POOL_SEG;
                entry=&OPCODE_DESCRIPTOR_TABLE[ES_B(_SI,COP_OPCODE)];
                /* An op computed into a register: if the register already holds the same value, drop the
                   op; otherwise the register now holds it. For the register-copy ops 0x97-0x99 the value
                   compared is their left operand. */
                if (ES_B(_SI,COP_REGISTER)!=0xFF) {
                    unsigned int value;
                    value=index;
                    slot=SLOT((int)(signed char)FIND_ASSIGNED_REGISTER(index));
                    _ES=CODE_OP_POOL_SEG;
                    if (ES_B(_SI,COP_OPCODE)>=0x97 && ES_B(_SI,COP_OPCODE)<=0x99) {
                        _ES=CODE_OPERAND_POOL_SEG;
                        value=ES_W(_SI,OPND_LEFT);
                    }
                    if (REGISTER_HOLDS_VALUE(slot->value,value,slot->stamp)) {
                        _ES=CODE_OP_POOL_SEG;
                        ES_B(_SI,COP_FLAGS)|=0x40;
                    } else {
                        _BX=(unsigned int)slot;
                        *((unsigned int near *)_BX)=value;
                        ((unsigned int near *)_BX)[1]=PEEPHOLE_STORE_STAMP;
                        /* Keep this slot update distinct from the alternate path. */
                        _AX=_AX;
                    }
                /* Table flag 0x100: the op leaves its own value in its left operand's register. */
                } else if (entry->flags&0x100L) {
                    signed char reg;
                    _ES=CODE_OPERAND_POOL_SEG;
                    reg=GET_ASSIGNED_REGISTER(ES_W(_SI,OPND_LEFT));
                    if (reg!=-1) {
                        slot=SLOT((int)reg);
                        if (REGISTER_HOLDS_VALUE(slot->value,index,slot->stamp)) {
                            _ES=CODE_OP_POOL_SEG;
                            ES_B(_SI,COP_FLAGS)|=0x40;
                        } else {
                            _BX=(unsigned int)slot;
                            *((unsigned int near *)_BX)=index;
                            ((unsigned int near *)_BX)[1]=PEEPHOLE_STORE_STAMP;
                        }
                    }
                }
                _ES=CODE_OP_POOL_SEG;
                /* A store (the op works in place on its left operand): stamp it. A variable target gets
                   the new stamp and loses any register copy; when the op writes the value of a right
                   operand that sits in a register, that register now holds the variable. A register
                   target (raw word op) forgets its slot; any other target is a store through a pointer. */
                if (ES_B(_SI,COP_FLAGS)&2) {
                    ++PEEPHOLE_STORE_STAMP;
                    _ES=CODE_OPERAND_POOL_SEG;
                    left=ES_W(_SI,OPND_LEFT)<<2;
                    _ES=CODE_OP_POOL_SEG;
                    _BX=left;
                    if (OPCODE_DESCRIPTOR_TABLE[ES_B(_BX,COP_OPCODE)].flags&1L) {
                        _ES=CODE_OPERAND_POOL_SEG;
                        _BX=left;
                        node=ES_W(_BX,OPND_LEFT);
                        _BX=node;
                        _ES=VARIABLE_TABLE_SEG;
                        ES_W(_BX,VAR_STORE_STAMP)=PEEPHOLE_STORE_STAMP;
                        if (ES_B(_BX,VAR_FLAGS)&2) SLOT((int)ES_SC(_BX,VAR_REGISTER))->value=0;
                        _ES=CODE_OPERAND_POOL_SEG;
                        _AX=ES_W(_SI,OPND_RIGHT);
                        rightIndex=_AX;
                        right=_AX<<2;
                        if ((entry->flags&4L) && rightIndex) {
                            _BX=right;
                            _ES=CODE_OP_POOL_SEG;
                            if (ES_B(_BX,COP_REGISTER)!=0xFF) {
                                slot=SLOT((int)(signed char)FIND_ASSIGNED_REGISTER(rightIndex));
                                _ES=CODE_OPERAND_POOL_SEG;
                                slot->value=ES_W(_SI,OPND_LEFT);
                                slot->stamp=PEEPHOLE_STORE_STAMP;
                            }
                        }
                    } else {
                        _ES=CODE_OP_POOL_SEG;
                        _BX=left;
                        if (OPCODE_DESCRIPTOR_TABLE[ES_B(_BX,COP_OPCODE)].flags&0x20L) {
                            _ES=CODE_OPERAND_POOL_SEG;
                            _BX=left;
                            _BX=ES_W(_BX,OPND_LEFT);
                            SLOT(_BX)->value=0;
                        } else if (!OPTION_SUPPRESS_RELOADS) PEEPHOLE_MEMORY_STORE_STAMP=PEEPHOLE_STORE_STAMP;
                    }
                    _ES=CODE_OPERAND_POOL_SEG;
                    _AX=ES_W(_SI,OPND_RIGHT);
                    rightIndex=_AX;
                    right=_AX<<2;
                    if (rightIndex) {
                        _BX=right;
                        _ES=CODE_OP_POOL_SEG;
                        /* Preserve the call here before the alternate descriptor path. */
                        if (ES_B(_BX,COP_FLAGS)&1) { MARK_REDUNDANT_OPERAND(rightIndex,(unsigned int)entry->tail[3]); _AX=_AX; }
                    }
                /* An ordinary operation (not a leaf, constant, raw-word op or 0x400 op, and not a
                   register copy): replace folded memory operands by registers holding the same value. */
                } else if (!(entry->flags&0x429L)) {
                    _ES=CODE_OP_POOL_SEG;
                    if (ES_B(_SI,COP_OPCODE)<0x97 || ES_B(_SI,COP_OPCODE)>0x99) {
                        _ES=CODE_OPERAND_POOL_SEG;
                        _AX=ES_W(_SI,OPND_LEFT);
                        leftIndex=_AX;
                        left=_AX<<2;
                        if (leftIndex) {
                            _BX=left;
                            _ES=CODE_OP_POOL_SEG;
                            if (ES_B(_BX,COP_FLAGS)&1) MARK_REDUNDANT_OPERAND(leftIndex,(unsigned int)entry->tail[2]);
                        }
                        _ES=CODE_OPERAND_POOL_SEG;
                        _AX=ES_W(_SI,OPND_RIGHT);
                        rightIndex=_AX;
                        right=_AX<<2;
                        if (rightIndex) {
                            _BX=right;
                            _ES=CODE_OP_POOL_SEG;
                            if (ES_B(_BX,COP_FLAGS)&1) MARK_REDUNDANT_OPERAND(rightIndex,(unsigned int)entry->tail[3]);
                        }
                    }
                }
                if (entry->flags&0x400L) CLEAR_REGISTER_SLOTS();
                else if (entry->tail[5]) CLEAR_SLOTS_BY_MASK(REGISTER_MASK_TABLE[entry->tail[5]]);
advance:
                ++index;
                --count;
                _SI+=4;
            }
        }
        _BX=current;
        _ES=FLOW_BLOCK_POOL_SEG;
    }
}
#undef SLOT

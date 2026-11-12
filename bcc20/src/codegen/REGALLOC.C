/* target: ovr157_C204UNIT */
/* Role: register allocator. Entry points: ALLOCATE_REGISTERS, GET_ASSIGNED_REGISTER,
   HIGH_BIT_INDEX. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO061 (ovr_1d83_a6f1) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the register allocator, run once per function by GENERATE_FUNCTION_CODE
   after register variables are chosen. It is a local allocator: it walks each code and
   switch block's ops in order and gives every op whose result is used a register
   (COP_REGISTER) from the class its CODE_OP_INFO_TABLE entry allows. It never rewrites
   the ops: when a value must move it appends register history entries
   (REG_HISTORY_POOL_SEG, RECORD_REGISTER_MOVE: 1 push, 2 pop, 3 move, 6 exchange; 4/5
   come from SAVEREGS.C for the 8087), which the emitter replays (EMITHIST.C).
   Data: register classes are indexes into REG_CLASS_MASK_TABLE (allowed registers) and
   REG_CLASS_IS_WORD; an op's wanted class is COP_REG_CLASS (low 6 bits), first filled
   backwards from its users by COLLECT_REGISTER_HINTS. The table entry gives the operand
   classes (description[9] left, [10] right), the result class ([0x0B]) and the set of
   registers the op destroys ([0x0C], REGISTER_MASK_TABLE). Values computed but not yet
   used are 'live': LIVE_VALUE_POOL_SEG holds 4-byte entries (op, remaining uses
   LVAL_USE_COUNT) up to LIVE_VALUE_END; those below LIVE_VALUE_SPILL_END were pushed on
   the stack to free their register and are popped back in reverse order.
   ALLOCATABLE_REGISTER_MASK is the set free right now, BLOCK_FREE_REGISTER_MASK the set
   the current scope allows (no register variables); CLAIM_REGISTERS takes registers
   and records them in BLOCK_CLAIMED_REG_MASK, FUNCTION_CLAIMED_REG_MASK and the scope
   masks. Before each op, the registers its operands must be in are 'pending requests'
   (PENDING_REQUESTS, 12-byte struct Entry); RESOLVE_PENDING_REGISTERS satisfies them with
   moves, exchanges and pops. When no register is free, SPILL_REGISTER pushes the oldest
   live value. Special ops: 2 carries a value to the join of a ?: (the second arm's op 2
   names the first arm's as the register to use), 3 is the joined value, 5 and 6 carry a
   mask of registers that must be free (before calls and branches). Running out of
   registers or leaving values live at the end is fatal (MSG_REGISTER_ALLOCATION).
   Note: JUMP_OPT_CHANGED (DS:8718) is declared here as an Entry array because it sits
   exactly one 12-byte entry before PENDING_REQUESTS (DS:8724), so
   JUMP_OPT_CHANGED+PENDING_REQUEST_COUNT is the last pending request; the name belongs to
   the jump optimiser's flag at that address. The _SI/_DI/_ES register code throughout is
   a shape kept for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STAOV0A4 (listing ovr_1d83_a6f1:6F10) ---- */
static void near pascal COLLECT_REGISTER_HINTS(unsigned int node);
static void near pascal ALLOCATE_BLOCK_REGISTERS(unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far cdecl REPORT_FATAL(unsigned int);
extern unsigned int far pascal ALL_REGISTERS_MASK(void);
extern unsigned int far pascal BLOCK_FREE_REGISTERS(unsigned int);

/* ALLOCATE_REGISTERS: allocates registers for the current function: empties the history
   and live-value pools, collects register hints over the blocks from last to first, then
   walks the blocks from first to last: each block's CNODE_HISTORY is set to where its
   history entries start; scope entry and exit blocks change the registers allowed (those
   of register variables in scope are excluded; on exit, offset 0x10, named CNODE_TARGET,
   is the scope entry's CNODE_SCOPE_PARENT); code and switch blocks are allocated. */
void far pascal ALLOCATE_REGISTERS(unsigned int unused)
{
    register unsigned int node;

    HISTORY_END_OFFSET = 0;
    REG_HISTORY_POOL_FREE_LIST = 0;
    LIVE_VALUE_POOL_USED = 0;
    LIVE_VALUE_POOL_FREE_LIST = 0;
    node = CODE_BLOCK_LIST_TAIL;
    while (node) {
        switch (CNODE_W(node, CNODE_KIND)) {
        case 0: case 4:
            COLLECT_REGISTER_HINTS(node);
        }
        node = CNODE_W(node, CNODE_PREV);
    }
    LIVE_VALUE_SPILL_END = 0;
    LIVE_VALUE_END = 0;
    BLOCK_FREE_REGISTER_MASK = ALLOCATABLE_REGISTER_MASK = ALL_REGISTERS_MASK();
    node = CODE_BLOCK_LIST_HEAD;
    while (node) {
        CNODE_W(node, CNODE_HISTORY) = HISTORY_END_OFFSET;
        switch (CNODE_W(node, CNODE_KIND)) {
        case 1:
            REGALLOC_SCOPE_NODE = node;
            BLOCK_FREE_REGISTER_MASK = ALLOCATABLE_REGISTER_MASK = BLOCK_FREE_REGISTERS(REGALLOC_SCOPE_NODE);
            break;
        case 2:
            REGALLOC_SCOPE_NODE = CNODE_W(REGALLOC_SCOPE_NODE, CNODE_SCOPE_PARENT);
            BLOCK_FREE_REGISTER_MASK = ALLOCATABLE_REGISTER_MASK = BLOCK_FREE_REGISTERS(REGALLOC_SCOPE_NODE);
            break;
        case 0: case 4:
            ALLOCATE_BLOCK_REGISTERS(node);
            break;
        }
        node = CNODE_W(node, CNODE_NEXT);
    }
    if (LIVE_VALUE_END)
        REPORT_FATAL(MSG_REGISTER_ALLOCATION);
}

/* ---- STAOV0A5 (listing ovr_1d83_a6f1:6FF1) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
#define FLAGS (*((unsigned long near *)(entry+3)))

/* TREE_USES_REGISTER_MASK: true when the operand tree of op 'node' reads a register
   variable living in exactly the register 'mask' (a one-bit mask). Constants and raw-word
   ops (table flags 8, 0x20) stop the search. */
static int near pascal TREE_USES_REGISTER_MASK(unsigned int mask,unsigned int node)
{
    register unsigned int offset;
    register unsigned char near *entry;

    offset=node*4;
    entry=CODE_OP_INFO_TABLE-3+COP_B(offset,COP_OPCODE)*19;
    if (node==0) return 0;
    if (FLAGS&1L) {
        if (VAR_B(OPND_W(offset,OPND_LEFT),VAR_FLAGS)&2)
            return (1<<VAR_B(OPND_W(offset,OPND_LEFT),VAR_REGISTER))==mask;
        else return 0;
    }
    if (FLAGS&0x28L) return 0;
    return TREE_USES_REGISTER_MASK(mask,OPND_W(offset,OPND_LEFT)) ||
           TREE_USES_REGISTER_MASK(mask,OPND_W(offset,OPND_RIGHT));
}
#undef FLAGS

/* ---- STAOV0A6 (listing ovr_1d83_a6f1:70A0) ---- */
static void near pascal NARROW_REGISTER_HINT(unsigned int first, unsigned int second);
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal OP3_REGISTER_HINT(unsigned int,unsigned int);
extern unsigned int far pascal REFINE_KIND_10_OPERAND_STUB(unsigned int,unsigned int);
extern int far pascal IS_MARKED_MEM_OPERAND(unsigned int,unsigned int);
#define FLAGS(p) (*((unsigned long near *)((p)+3)))

/* COLLECT_REGISTER_HINTS: walks block 'node''s ops backwards and passes register class
   wishes down to the operand ops (NARROW_REGISTER_HINT): from the operand classes in the
   table (REFINE_KIND_10_OPERAND for ops with a folded operand), from ?: join ops 3 and
   carry ops 2 to their values, and, for ops that leave their result in their left
   operand's register (table flag 0x100), the op's own wanted class to its left operand,
   unless the right operand needs that register or the class does not fit. */
static void near pascal COLLECT_REGISTER_HINTS(unsigned int node)
{
    unsigned int count,available,mask,old;
    unsigned char near *description;
    _BX=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    count=ES_W(_BX,CNODE_OP_COUNT);
    _SI=(ES_W(_BX,CNODE_FIRST_OP)+count-1)*4;
    for (;count;--count,_SI-=4) {
        _ES=CODE_OP_POOL_SEG;
        if (ES_B(_SI,COP_FLAGS)&0x40) continue;
        _ES=CODE_OP_POOL_SEG;
        description=CODE_OP_INFO_TABLE-3+ES_B(_SI,COP_OPCODE)*19;
        if (FLAGS(description)&0x29L) continue;
        _ES=CODE_OP_POOL_SEG;
        if (ES_B(_SI,COP_OPCODE)==3) {
            available=OP3_REGISTER_HINT(count,ES_B(_SI,COP_REG_CLASS));
            _ES=CODE_OPERAND_POOL_SEG;
            _DI=ES_W(_SI,OPND_RIGHT)*4;
            NARROW_REGISTER_HINT(_DI,available);
            _ES=CODE_OPERAND_POOL_SEG;
            _DI=ES_W(_SI,OPND_LEFT)*4;
            NARROW_REGISTER_HINT(_DI,available);
        } else {
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_OPCODE)==2) {
                _ES=CODE_OPERAND_POOL_SEG;
                _DI=ES_W(_SI,OPND_LEFT)*4;
                NARROW_REGISTER_HINT(_DI,(*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG,_SI+COP_REG_CLASS))));
            } else {
                _ES=CODE_OP_POOL_SEG;
                if (ES_B(_SI,COP_FLAGS)&1) {
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_LEFT)) {
                        _DI=ES_W(_SI,OPND_LEFT)*4;
                        _ES=CODE_OP_POOL_SEG;
                        if ((ES_B(_DI,COP_FLAGS)&1)==0)
                            NARROW_REGISTER_HINT(_DI,REFINE_KIND_10_OPERAND_STUB(description[9],
                                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,_SI+OPND_RIGHT))));
                    }
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_RIGHT)==0) continue;
                    _DI=ES_W(_SI,OPND_RIGHT)*4;
                    _ES=CODE_OP_POOL_SEG;
                    if (ES_B(_DI,COP_FLAGS)&1) continue;
                    NARROW_REGISTER_HINT(_DI,REFINE_KIND_10_OPERAND_STUB(description[10],
                                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,_SI))));
                    /* Keep the call result register live at the branch join. */
                    _AX=_AX;
                } else {
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_RIGHT)) {
                        _DI=ES_W(_SI,OPND_RIGHT)*4;
                        _ES=CODE_OP_POOL_SEG;
                        if ((ES_B(_DI,COP_FLAGS)&1)==0) NARROW_REGISTER_HINT(_DI,description[10]);
                    }
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_LEFT)==0) continue;
                    _DI=ES_W(_SI,OPND_LEFT)*4;
                    _ES=CODE_OP_POOL_SEG;
                    if (ES_B(_DI,COP_FLAGS)&1) continue;
                    NARROW_REGISTER_HINT(_DI,description[9]);
                    if ((FLAGS(description)&0x100L)==0) continue;
                    _ES=CODE_OP_POOL_SEG;
                    old=REG_CLASS_MASK_TABLE[ES_B(_DI,COP_REG_CLASS)];
                    mask=REG_CLASS_MASK_TABLE[ES_B(_SI,COP_REG_CLASS)];
                    if ((mask&REG_MASK_HIGH_BYTES) &&
                        (*((unsigned long near *)(CODE_OP_INFO_TABLE+ES_B(_DI,COP_OPCODE)*19))&1L)) {
                        _ES=CODE_OPERAND_POOL_SEG;
                        _BX=ES_W(_DI,OPND_LEFT);
                        _ES=VARIABLE_TABLE_SEG;
                        if (ES_B(_BX,VAR_FLAGS)&2) {
                            _ES=CODE_OPERAND_POOL_SEG;
                            _BX=ES_W(_DI,OPND_LEFT);
                            _ES=VARIABLE_TABLE_SEG;
                            if ((REG_MASK_LOW_BYTES&(1<<ES_B(_BX,VAR_REGISTER)))==0) continue;
                        }
                    }
                    if (IS_MARKED_MEM_OPERAND(mask,*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,_SI+OPND_RIGHT))) ||
                        mask==0 || (old&mask)!=mask) continue;
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_LEFT)<=ES_W(_SI,OPND_RIGHT) && TREE_USES_REGISTER_MASK(mask,ES_W(_SI,OPND_RIGHT))) continue;
                    NARROW_REGISTER_HINT(_DI,*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG,_SI+COP_REG_CLASS)));
                }
            }
        }
    }
}
#undef FLAGS

/* ---- STAOV0A7 (listing ovr_1d83_a6f1:7329) ---- */

/* NARROW_REGISTER_HINT: sets op record 'first''s wanted class to 'second' when it has
   none yet, or when 'second' allows a subset of its current class of the same width. */
static void near pascal NARROW_REGISTER_HINT(unsigned int first, unsigned int second)
{
    unsigned int flags;

    _SI = first;
    _DX = second;
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI + COP_REG_CLASS)) != 0) {
        flags = REG_CLASS_MASK_TABLE[*((unsigned char far *)MK_FP(_ES, _SI + COP_REG_CLASS))];
        _DI = REG_CLASS_MASK_TABLE[_DX];
        if ((_DI & flags) != _DI)
            return;
        _ES = CODE_OP_POOL_SEG;
        if (REG_CLASS_IS_WORD[*((unsigned char far *)MK_FP(_ES, _SI + COP_REG_CLASS))] !=
            REG_CLASS_IS_WORD[_DX])
            return;
    }
    _ES = CODE_OP_POOL_SEG;
    _AL = _DL;
    *((unsigned char far *)MK_FP(_ES, _SI + COP_REG_CLASS)) = _AL;
}

/* ---- STAOV0A8 (listing ovr_1d83_a6f1:738F) ---- */
static void near pascal ENSURE_REGISTERS_FREE(unsigned int flags);
static void near pascal RESOLVE_PENDING_REGISTERS(unsigned int node,unsigned int flags);
static unsigned char near pascal PICK_FREE_REGISTER(unsigned int first, unsigned int second);
static void near pascal SPILL_REGISTER(void);
static void near pascal RECORD_REGISTER_MOVE(unsigned char first, unsigned char second, unsigned char third, unsigned int fourth, unsigned int fifth);
static unsigned char near pascal FIND_VALUE_REGISTER(unsigned int value);
static void near pascal RESOLVE_PENDING_NEXT_BLOCK(register unsigned int node);
static void near pascal CLAIM_REGISTERS(register unsigned int flags);
static void near pascal ADD_LIVE_VALUE(unsigned int value, unsigned char shift);
static void near pascal COUNT_REGISTER_USES(unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern int far pascal IS_OP_97_98_OR_LONG_PAIR(unsigned int);
extern int far pascal IS_LONG_MEM_PAIR(unsigned int);
extern unsigned char far pascal REGISTER_HINT_CODE(unsigned char,unsigned int);
extern void far pascal POP_EVAL_STACK_OPERANDS(unsigned int,unsigned int);
extern void far pascal SPILL_EVAL_STACK_TO_TEMPS(unsigned int);
extern void far pascal PUSH_EVAL_STACK(unsigned int);
#define FIELD(n) description[n]
#define FLAGS (*((unsigned long near *)(description+3)))

/* ALLOCATE_BLOCK_REGISTERS: allocates the ops of block 'node' in order (CURRENT_INSN_INDEX
   is the op number, so history entries land before the right op). For each live op:
   operand requests are resolved; 8087 ops only update the 8087 stack model; registers the
   op destroys are freed; ops whose result is unused only handle their side effects; ops
   whose result is used get a register: a specific high byte when the wanted class is one,
   the operand's register for table flag 0x100 ops when allowed, else PICK_FREE_REGISTER.
   A result with uses ahead becomes a live value (ADD_LIVE_VALUE). At the end of a block
   marked CNODE_FLAGS 8 the next block's first op requests are resolved here, so values can
   flow into it. */
static void near pascal ALLOCATE_BLOCK_REGISTERS(unsigned int node)
{
    unsigned int count,mask,allowed,temp;
    unsigned char near *description;
    unsigned char previous;
    register unsigned int cursor,right;
    _BX=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    count=ES_W(_BX,CNODE_OP_COUNT);
    cursor=(CURRENT_INSN_INDEX=ES_W(_BX,CNODE_FIRST_OP))*4;
    BLOCK_CLAIMED_REG_MASK=0;
    while(count) {
        _ES=CODE_OP_POOL_SEG;
        description=CODE_OP_INFO_TABLE-3+ES_B(cursor,COP_OPCODE)*19;
        /* Register copies and long-pair reads use their operands' values one more time, so the
           live values they read get an extra expected use. */
        if(IS_OP_97_98_OR_LONG_PAIR(cursor)) {
            _ES=CODE_OPERAND_POOL_SEG;
            COUNT_REGISTER_USES(ES_W(cursor,OPND_LEFT));
            _ES=CODE_OPERAND_POOL_SEG;
            COUNT_REGISTER_USES(ES_W(cursor,OPND_RIGHT));
        }
        _ES=CODE_OP_POOL_SEG;
        if(ES_B(cursor,COP_FLAGS)&0x41) goto next;
        PENDING_RESULT_REGISTER=-1;
        if((FLAGS&0x29L)==0L) {
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_OPCODE)==2) {
                _ES=CODE_OPERAND_POOL_SEG;
                if(ES_W(cursor,OPND_RIGHT)) goto after_prepare;
            }
            if(count<=1 || !IS_LONG_MEM_PAIR(cursor))
                RESOLVE_PENDING_REGISTERS(CURRENT_INSN_INDEX,0);
            else RESOLVE_PENDING_REGISTERS(CURRENT_INSN_INDEX,1);
        }
after_prepare:
        if(FLAGS&2L) {
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_REGISTER)=0xFF;
            if((FLAGS&1L)==0L) POP_EVAL_STACK_OPERANDS(cursor,CURRENT_INSN_INDEX);
            _ES=CODE_OP_POOL_SEG;
            if((ES_B(cursor,COP_FLAGS)&9)==8) PUSH_EVAL_STACK(CURRENT_INSN_INDEX);
            goto next;
        }
        if(FIELD(0x0C)) ENSURE_REGISTERS_FREE(REGISTER_MASK_TABLE[FIELD(0x0C)]);
        else {
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_OPCODE)==5) {
                _ES=CODE_OPERAND_POOL_SEG;
                ENSURE_REGISTERS_FREE(ES_W(cursor,OPND_LEFT));
            } else if((FLAGS&0x401L)==0x401L) {
                _ES=CODE_OPERAND_POOL_SEG;
                ENSURE_REGISTERS_FREE(ES_W(cursor,OPND_RIGHT));
            }
        }
        _ES=CODE_OP_POOL_SEG;
        if((ES_B(cursor,COP_FLAGS)&8)==0) {
            /* Op 6 with an unused result: spill until every register in its mask (OPND_LEFT) is free,
               and spill the 8087 stack. */
            if(ES_B(cursor,COP_OPCODE)==6) {
                goto check;
flush:
                SPILL_REGISTER();
check:
                if(LIVE_VALUE_SPILL_END<LIVE_VALUE_END) {
                    _ES=CODE_OPERAND_POOL_SEG;
                    if((ALLOCATABLE_REGISTER_MASK&ES_W(cursor,OPND_LEFT))!=ES_W(cursor,OPND_LEFT)) goto flush;
                }
                SPILL_EVAL_STACK_TO_TEMPS(CURRENT_INSN_INDEX);
                goto next;
            }
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_OPCODE)==3) {
                POP_EVAL_STACK_OPERANDS(cursor,CURRENT_INSN_INDEX);
                goto next;
            }
            if(FLAGS&0x100L) {
                temp=1<<PENDING_RESULT_REGISTER;
                CLAIM_REGISTERS(temp);
                ALLOCATABLE_REGISTER_MASK|=temp&BLOCK_FREE_REGISTER_MASK;
            }
            goto next;
        }
        _ES=CODE_OP_POOL_SEG;
        /* Op 2 (a value carried to a ?: join): its register is the one of the value; in the
           second arm (right operand set) it must be the register the first arm's op 2 got, so a
           move is recorded when they differ. */
        if(ES_B(cursor,COP_OPCODE)==2) {
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_W(cursor,OPND_RIGHT)) {
                _BX=ES_W(cursor,OPND_RIGHT);
                _BX<<=2;
                _ES=CODE_OP_POOL_SEG;
                previous=ES_B(_BX,COP_REGISTER);
                _ES=CODE_OPERAND_POOL_SEG;
                right=ES_W(cursor,OPND_LEFT)*4;
                _AL=REGISTER_HINT_CODE(previous,(unsigned int)CODE_OP_INFO_TABLE[*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG,right))*19+4]);
                _ES=CODE_OP_POOL_SEG;
                ES_B(cursor,COP_REG_CLASS)=_AL;
                ES_B(right,COP_REG_CLASS)=_AL;
                mask=1<<previous;
            }
            RESOLVE_PENDING_REGISTERS(CURRENT_INSN_INDEX,0);
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_W(cursor,OPND_RIGHT)==0) POP_EVAL_STACK_OPERANDS(cursor,CURRENT_INSN_INDEX);
            _ES=CODE_OPERAND_POOL_SEG;
            _AL=FIND_VALUE_REGISTER(ES_W(cursor,OPND_LEFT));
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_REGISTER)=_AL;
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_W(cursor,OPND_RIGHT)==0) goto next;
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_REGISTER)==previous) goto next;
            _AL=PICK_FREE_REGISTER(mask,mask);
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_REGISTER)=_AL;
            RECORD_REGISTER_MOVE(3,REG_CLASS_IS_WORD[FIELD(0x0B)],ES_B(cursor,COP_REGISTER),
                         *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,cursor)),0);
            goto next;
        }
        _ES=CODE_OP_POOL_SEG;
        /* Op 3 (the joined value): takes the register of the first arm's op 2, unless the value
           is an 8087 value. */
        if(ES_B(cursor,COP_OPCODE)==3) {
            right=cursor;
            do {
                _ES=CODE_OPERAND_POOL_SEG;
                right=ES_W(right,OPND_LEFT)*4;
                right=ES_W(right,OPND_LEFT)*4;
                _ES=CODE_OP_POOL_SEG;
            } while(ES_B(right,COP_OPCODE)==3);
            if((*((unsigned long near *)(CODE_OP_INFO_TABLE+ES_B(right,COP_OPCODE)*19))&2L)!=0L) goto next;
            _ES=CODE_OPERAND_POOL_SEG;
            _BX=ES_W(cursor,OPND_LEFT);
            _BX<<=2;
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_REGISTER)=ES_B(_BX,COP_REGISTER);
            goto emit;
        }
        _ES=CODE_OP_POOL_SEG;
        /* High word of an indirect long read with class 0x15 (probably 'ES') while ES is taken:
           use any register of the op's result class instead. */
        if(ES_B(cursor,COP_OPCODE)==0x1B && (ES_B(cursor,COP_REG_CLASS)&0x3F)==0x15) {
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_W(cursor,OPND_RIGHT)) {
                _AX=0x1000;
                if((ALLOCATABLE_REGISTER_MASK&_AX)==0) {
                allowed=REG_CLASS_MASK_TABLE[FIELD(0x0B)];
                _AL=PICK_FREE_REGISTER(allowed,allowed);
                _ES=CODE_OP_POOL_SEG;
                ES_B(cursor,COP_REGISTER)=_AL;
                cursor=cursor; /* Retain this branch tail separately. */
                goto emit;
                }
            }
        }
        if(FIELD(0x0B)!=0) {
        allowed=REG_CLASS_MASK_TABLE[FIELD(0x0B)];
        _ES=CODE_OP_POOL_SEG;
        mask=(ES_B(cursor,COP_REG_CLASS)&0x3F) ? REG_CLASS_MASK_TABLE[ES_B(cursor,COP_REG_CLASS)&0x3F] : allowed;
        _AX=mask;
        if((_AX&REG_MASK_HIGH_BYTES)==mask && (mask&allowed)) {
            _ES=CODE_OP_POOL_SEG;
            *((signed char far *)MK_FP(_ES,cursor+COP_REGISTER))=(*((signed char far *)MK_FP(_ES,cursor+COP_REG_CLASS))&0x3F)-1;
            goto next;
        }
        if(FLAGS&0x100L) {
            if(allowed&(1<<PENDING_RESULT_REGISTER)) {
                _ES=CODE_OP_POOL_SEG;
                ES_B(cursor,COP_REGISTER)=PENDING_RESULT_REGISTER;
                goto emit;
            }
            _AL=PICK_FREE_REGISTER(mask,allowed);
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_REGISTER)=_AL;
            cursor=cursor; /* Retain this branch tail separately. */
            goto emit;
        }
        _AL=PICK_FREE_REGISTER(mask,allowed);
        _ES=CODE_OP_POOL_SEG;
        ES_B(cursor,COP_REGISTER)=_AL;
        } else goto next;

emit:
        ADD_LIVE_VALUE(CURRENT_INSN_INDEX,*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG,cursor+COP_REGISTER)));
next:
        --count;
        cursor+=4;
        ++CURRENT_INSN_INDEX;
    }
    _BX=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    if(ES_W(_BX,CNODE_FLAGS)&8) RESOLVE_PENDING_NEXT_BLOCK(node);
}
#undef FIELD
#undef FLAGS

/* ---- STAOV0A9 (listing ovr_1d83_a6f1:77FF) ---- */

/* ENSURE_REGISTERS_FREE: spills live values until all registers in 'flags' are free, then
   marks them used for the scope chain without taking them out of the free set. */
static void near pascal ENSURE_REGISTERS_FREE(unsigned int flags)
{
    unsigned int saved;
    while (LIVE_VALUE_SPILL_END < LIVE_VALUE_END && (ALLOCATABLE_REGISTER_MASK & flags) != flags)
        SPILL_REGISTER();
    saved = ALLOCATABLE_REGISTER_MASK;
    CLAIM_REGISTERS(flags);
    ALLOCATABLE_REGISTER_MASK = saved;
}

/* ---- STAOV0AA (listing ovr_1d83_a6f1:7838) ---- */

/* GET_ASSIGNED_REGISTER: the register of op 'value', or 0xFF when there is none or the op
   is folded into its parent's operand. Used by the emitters. */
unsigned char far pascal GET_ASSIGNED_REGISTER(unsigned int value)
{
    register unsigned int index;
    if (value == 0)
        return 0xFF;
    index = value << 2;
    if (((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, index))[1] & 1)
        return 0xFF;
    return ((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, index))[2];
}

/* ---- STAOV0AB (listing ovr_1d83_a6f1:786D) ---- */
static void near pascal ADD_NODE_REGISTER_REQUESTS(unsigned int index, unsigned int mode);
static unsigned char near pascal ACQUIRE_VALUE_REGISTER(unsigned int node,unsigned int hint);
struct Entry {
    unsigned int node;
    signed char reg;
    unsigned char previous,mode;
    signed char other;
    unsigned int mask,other_mask;
    int references;
};
extern struct Entry JUMP_OPT_CHANGED[],PENDING_REQUESTS[];
extern void far cdecl REPORT_FATAL(unsigned int);

/* RESOLVE_PENDING_REGISTERS: gets the operands of op 'node' into the registers its
   instruction needs ('flags' is passed to ADD_NODE_REGISTER_REQUESTS). The requests are
   collected first; spilled values are popped back; values in a wrong register are moved
   when the right one is free, otherwise two values swap places with an exchange (action
   6). Finally each request's value is released when this was its last use or stays live
   when more uses follow, and PENDING_RESULT_REGISTER notes the register of the op's left
   operand. */
static void near pascal RESOLVE_PENDING_REGISTERS(unsigned int node,unsigned int flags)
{
    struct Entry far *p;
    int i;
    unsigned int index;
    struct Entry far *q;
    register int j;
    register int changed;
    index=node*4;
    PENDING_REQUEST_COUNT=0;
    RESOLVED_REQUEST_COUNT=0;
    PENDING_REGISTER_MASK=0;
    SPILLED_REQUEST_COUNT=0;
    ADD_NODE_REGISTER_REQUESTS(node,flags);
    if (PENDING_REQUEST_COUNT==0) return;
    if (RESOLVED_REQUEST_COUNT==PENDING_REQUEST_COUNT) goto finalize;
    if (PENDING_REQUEST_COUNT==1) {
        PENDING_REQUESTS[0].reg=ACQUIRE_VALUE_REGISTER(PENDING_REQUESTS[0].node,PENDING_REQUESTS[0].other);
        goto finalize;
    }
    if (SPILLED_REQUEST_COUNT>=PENDING_REQUEST_COUNT) {
        for (i=0,p=PENDING_REQUESTS;i<PENDING_REQUEST_COUNT;p++,i++)
            p->reg=ACQUIRE_VALUE_REGISTER(p->node,p->other);
        goto finalize;
    }
    for (;;) {
        changed=0;
        for (i=0,p=PENDING_REQUESTS;i<PENDING_REQUEST_COUNT;p++,i++) {
            if (p->reg==-1) continue;
            if (((1<<p->reg)&p->mask)==0 &&
                (p->mask&PENDING_REGISTER_MASK)==0) {
                p->reg=ACQUIRE_VALUE_REGISTER(p->node,p->other);
                p->mask=1<<p->reg;
                RESOLVED_REQUEST_COUNT++;
                changed=1;
            }
        }
        if (RESOLVED_REQUEST_COUNT==PENDING_REQUEST_COUNT-SPILLED_REQUEST_COUNT) break;
        if (changed) continue;
        for (i=0,p=PENDING_REQUESTS;i<PENDING_REQUEST_COUNT;p++,i++) {
            if ((1<<p->reg)&p->mask) continue;
            for (q=PENDING_REQUESTS,j=0;((1<<p->reg)&q->mask)==0 && j<PENDING_REQUEST_COUNT;q++,j++) ;
            if (j<PENDING_REQUEST_COUNT) {
                RECORD_REGISTER_MOVE(6,0,q->reg,p->node,q->node);
                i=q->reg;
                q->reg=p->reg;
                p->reg=(signed char)i;
                RESOLVED_REQUEST_COUNT++;
                if (((1<<q->reg)&q->mask) && ((1<<p->reg)&q->mask)==0)
                    RESOLVED_REQUEST_COUNT++;
            } else REPORT_FATAL(MSG_REGISTER_ALLOCATION);
            break;
        }
        if (RESOLVED_REQUEST_COUNT==PENDING_REQUEST_COUNT-SPILLED_REQUEST_COUNT) break;
    }
    for (i=0,p=PENDING_REQUESTS;i<PENDING_REQUEST_COUNT;p++,i++)
        if (p->reg==-1) p->reg=ACQUIRE_VALUE_REGISTER(p->node,p->other);
finalize:
    p=PENDING_REQUESTS;
    while (PENDING_REQUEST_COUNT) {
        if (p->references>1) ADD_LIVE_VALUE(p->node,p->reg);
        else if (p->references && (BLOCK_FREE_REGISTER_MASK&(1<<p->reg)))
            ALLOCATABLE_REGISTER_MASK|=1<<p->reg;
        if (*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,index))==p->node) PENDING_RESULT_REGISTER=p->reg;
        p++;
        --PENDING_REQUEST_COUNT;
    }
    PENDING_REGISTER_MASK=0;
}

/* ---- STAOV0AC (listing ovr_1d83_a6f1:7B55) ---- */
static void near pascal ADD_OPERAND_REQUEST(register unsigned int first, unsigned int second, unsigned int third);
static void near pascal ADD_REGISTER_REQUEST(unsigned int node,unsigned int mode);
extern unsigned int far pascal REFINE_KIND_10_OPERAND_STUB(unsigned int, unsigned int);
#define FLAGS (*((unsigned long near *)(_DI+3)))
#define FIELD(n) (*((unsigned char near *)(_DI+(n))))

/* ADD_NODE_REGISTER_REQUESTS: adds requests for the operands of op 'index': for a leaf only
   the leaf itself (when it has a register and is not folded); otherwise each operand with
   the operand class from the table (refined for folded operands). Folded operands are
   searched recursively (ADD_OPERAND_REQUEST). */
static void near pascal ADD_NODE_REGISTER_REQUESTS(unsigned int index, unsigned int mode)
{
    unsigned int first;
    unsigned int second;

    _SI = index * 4;
    _ES = CODE_OP_POOL_SEG;
    _DI = (unsigned int)(CODE_OP_INFO_TABLE - 3 + ES_B(_SI, COP_OPCODE) * 19);
    if (FLAGS & 0x20L)
        return;
    if (FLAGS & 9L) {
        if (FLAGS & 2L)
            return;
        _ES = CODE_OP_POOL_SEG;
        if ((ES_B(_SI, COP_REG_CLASS) & 0x80) && mode == 0) {
            ADD_REGISTER_REQUEST(index, 0);
            _SI = _SI;
            return;
        }
        _ES = CODE_OP_POOL_SEG;
        if (ES_B(_SI, COP_FLAGS) & 1)
            return;
        ADD_REGISTER_REQUEST(index, 0);
    } else {
        _ES = CODE_OP_POOL_SEG;
        if (ES_B(_SI, COP_FLAGS) & 1) {
            first = REFINE_KIND_10_OPERAND_STUB(FIELD(9), ES_W((_ES = CODE_OPERAND_POOL_SEG, _SI), OPND_RIGHT));
            _AX = REFINE_KIND_10_OPERAND_STUB(FIELD(10), ES_W((_ES = CODE_OPERAND_POOL_SEG, _SI), OPND_LEFT));
        } else {
            first = FIELD(9);
            _AX = FIELD(10);
        }
        second = _AX;
        _ES = CODE_OPERAND_POOL_SEG;
        ADD_OPERAND_REQUEST(ES_W(_SI, OPND_LEFT), mode, first);
        _ES = CODE_OP_POOL_SEG;
        if (ES_B(_SI, COP_OPCODE) != 2) {
            _ES = CODE_OPERAND_POOL_SEG;
            ADD_OPERAND_REQUEST(ES_W(_SI, OPND_RIGHT), mode, second);
        }
    }
}
#undef FLAGS
#undef FIELD

/* ---- STAOV0AD (listing ovr_1d83_a6f1:7C4D) ---- */

/* ADD_OPERAND_REQUEST: requests register class 'third' for operand op 'first', or looks
   inside it when it is folded; 8087 values need no CPU register. */
static void near pascal ADD_OPERAND_REQUEST(register unsigned int first,
                                      unsigned int second,
                                      unsigned int third)
{
    register unsigned int entry;

    if (!first)
        return;
    entry = first << 2;
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, entry + COP_FLAGS)) & 1) {
        ADD_NODE_REGISTER_REQUESTS(first, second);
        return;
    }
    if ((*((unsigned long near *)(CODE_OP_INFO_TABLE +
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, entry)) * 19)) & 2L) == 0L)
        ADD_REGISTER_REQUEST(first, third);
}

/* ---- STAOV0AE (listing ovr_1d83_a6f1:7CA0) ---- */

/* PICK_FREE_REGISTER: returns the lowest free register in mask 'second', preferring those
   also in 'first' that no pending request holds; spills live values until one is free. */
static unsigned char near pascal PICK_FREE_REGISTER(unsigned int first,
                                               unsigned int second)
{
    unsigned char position;
    unsigned int bits;
    unsigned int mask;

    _AX = second;
    if (_AX & first) {
        _AX &= first;
        mask = _AX;
        _AX &= PENDING_REGISTER_MASK;
        if (_AX != mask && (BLOCK_FREE_REGISTER_MASK & mask))
            second = mask;
    }
    for (;;) {
        position = 0;
        bits = ALLOCATABLE_REGISTER_MASK & second;
        if (bits) {
            mask = 1;
            while (mask) {
                if ((mask & bits) == mask)
                    return position;
                mask <<= 1;
                position++;
            }
        }
        SPILL_REGISTER();
    }
}

/* ---- STAOV0AF (listing ovr_1d83_a6f1:7CFF) ---- */
extern void far cdecl REPORT_FATAL(unsigned int);

/* SPILL_REGISTER: frees the register of the oldest unspilled live value: normally by
   PUSHing it (action 1) and moving LIVE_VALUE_SPILL_END past it; when the current op is
   itself a PUSH (0x93/0x94), which would upset the stack order, the value is moved to
   another free register instead. */
static void near pascal SPILL_REGISTER(void)
{
    unsigned int type;
    unsigned char selected;
    register unsigned int slot;
    register unsigned int offset;
    for (slot=LIVE_VALUE_SPILL_END;slot<LIVE_VALUE_END &&
         *((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG,slot))==0;slot+=4) ;
    if (slot>=LIVE_VALUE_END) REPORT_FATAL(MSG_REGISTER_ALLOCATION);
    offset=CURRENT_INSN_INDEX*4;
    if (COP_B(offset,COP_OPCODE)==0x94 || COP_B(offset,COP_OPCODE)==0x93) {
        if (ALLOCATABLE_REGISTER_MASK&BLOCK_FREE_REGISTER_MASK) {
            selected=PICK_FREE_REGISTER(ALLOCATABLE_REGISTER_MASK,ALLOCATABLE_REGISTER_MASK);
            offset=LVAL_W(slot,LVAL_OP)*4;
            type=COP_B(offset,COP_REG_CLASS)&0x3F;
            ALLOCATABLE_REGISTER_MASK|=(1<<FIND_VALUE_REGISTER(*((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG,slot))))&BLOCK_FREE_REGISTER_MASK;
            RECORD_REGISTER_MOVE(3,REG_CLASS_IS_WORD[type],selected,
                          *((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG,slot)),0);
            ALLOCATABLE_REGISTER_MASK&=~(1<<selected);
        } else REPORT_FATAL(MSG_REGISTER_ALLOCATION);
    } else {
        ALLOCATABLE_REGISTER_MASK|=(1<<FIND_VALUE_REGISTER(*((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG,slot))))&BLOCK_FREE_REGISTER_MASK;
        RECORD_REGISTER_MOVE(1,0,0xFF,*((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG,slot)),0);
        LIVE_VALUE_SPILL_END=slot+4;
    }
}

/* ---- STAOV0B0 (listing ovr_1d83_a6f1:7E12) ---- */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *pool,
                                          unsigned int size);

/* RECORD_REGISTER_MOVE: appends a history entry before the current op: action 'first',
   word flag 'second', target register 'third', value op 'fourth', partner op 'fifth'. */
static void near pascal RECORD_REGISTER_MOVE(unsigned char first,
                                      unsigned char second,
                                      unsigned char third,
                                      unsigned int fourth,
                                      unsigned int fifth)
{
    register unsigned int entry = POOL_ALLOC(&REG_HISTORY_POOL_SEG, 9);

    *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, entry)) = first;
    *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, entry + RHIST_INSN_INDEX)) = CURRENT_INSN_INDEX;
    *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, entry + RHIST_IS_WORD)) = second;
    *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, entry + RHIST_REGISTER)) = third;
    *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, entry + RHIST_VALUE_OP)) = fourth;
    *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, entry + RHIST_PARTNER)) = fifth;
}

/* ---- STAOV0B1 (listing ovr_1d83_a6f1:7E5A) ---- */
extern void far * far pascal RTL_MEMMOVE(void far *,void far *,unsigned int);

/* ADD_REGISTER_REQUEST: adds a request that value op 'node' be in a register of class
   'mode'. A value requested twice for the same op only counts one use less. A live value
   is taken off the live list (its remaining uses go into the request); a spilled one is
   marked for reloading (reg 0xFF). */
static void near pascal ADD_REGISTER_REQUEST(unsigned int node,unsigned int mode)
{
    unsigned int other,references;
    register struct Entry near *entry;
    register unsigned int offset;
    references=0;
    offset=0;
    for(;;) {
        if(offset>=LIVE_VALUE_END) {
            for(entry=JUMP_OPT_CHANGED+PENDING_REQUEST_COUNT;entry>=PENDING_REQUESTS;--entry) {
                if(entry->node==node) {
                    --entry->references;
                    return;
                }
            }
            break;
        }
        if(LVAL_W(offset,LVAL_OP)==node) {
            for(entry=JUMP_OPT_CHANGED+PENDING_REQUEST_COUNT;entry>=PENDING_REQUESTS;--entry) {
                if(entry->node==node) {
                    --entry->references;
                    return;
                }
            }
            references=LVAL_W(offset,LVAL_USE_COUNT);
            break;
        }
        offset+=4;
    }
    entry=PENDING_REQUESTS+PENDING_REQUEST_COUNT;
    ++PENDING_REQUEST_COUNT;
    entry->node=node;
    entry->mask=REG_CLASS_MASK_TABLE[mode];
    entry->mode=mode;
    entry->other=(other=*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG,node*4+COP_REG_CLASS))&0x3F);
    entry->other_mask=REG_CLASS_MASK_TABLE[other];
    entry->references=references;
    if(offset<LIVE_VALUE_SPILL_END) {
        entry->reg=entry->previous=0xFF;
        SPILLED_REQUEST_COUNT++;
    } else {
        entry->reg=FIND_VALUE_REGISTER(node);
        PENDING_REGISTER_MASK|=1<<entry->reg;
        entry->previous=0xFF;
        if(offset<LIVE_VALUE_END) {
            if(entry->mask&(1<<entry->reg)) RESOLVED_REQUEST_COUNT++;
            LIVE_VALUE_END-=4;
            RTL_MEMMOVE(MK_FP(LIVE_VALUE_POOL_SEG,offset),(char far *)MK_FP(LIVE_VALUE_POOL_SEG,offset)+4,LIVE_VALUE_END-offset);
            LIVE_VALUE_POOL_FREE_LIST=0;
            LIVE_VALUE_POOL_USED=LIVE_VALUE_END;
        } else RESOLVED_REQUEST_COUNT++;
    }
}

/* ---- STAOV0B2 (listing ovr_1d83_a6f1:7FAC) ---- */
static unsigned char near pascal FREE_REGISTER_FROM(unsigned int available);
#define SLOT(r) (*((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG,(r))))

/* ACQUIRE_VALUE_REGISTER: returns the register value op 'node' will be read from, taking
   it off the live list: spilled values are popped back (with every value pushed after
   it, in reverse order); a value whose register does not fit its wanted class is moved to
   one that does (or to class 'hint'). */
static unsigned char near pascal ACQUIRE_VALUE_REGISTER(unsigned int node,unsigned int hint)
{
    unsigned int index,type;
    unsigned char selected,replacement;
    unsigned int mask;
    register unsigned int wanted,offset;
    offset=LIVE_VALUE_END;
    while (offset) {
        offset-=4;
        if (SLOT(offset)!=node) continue;
        if (offset<LIVE_VALUE_SPILL_END) {
            do {
                LIVE_VALUE_SPILL_END-=4;
                wanted=REG_CLASS_MASK_TABLE[COP_B(SLOT(LIVE_VALUE_SPILL_END)*4,COP_REG_CLASS)&0x3F];
                if (ALLOCATABLE_REGISTER_MASK&wanted) selected=PICK_FREE_REGISTER(wanted,wanted);
                else selected=FREE_REGISTER_FROM(wanted);
                RECORD_REGISTER_MOVE(2,0,selected,SLOT(LIVE_VALUE_SPILL_END),0);
                CLAIM_REGISTERS(1<<selected);
            } while (offset<LIVE_VALUE_SPILL_END);
        } else selected=FIND_VALUE_REGISTER(node);
        LIVE_VALUE_END-=4;
        RTL_MEMMOVE(MK_FP(LIVE_VALUE_POOL_SEG,offset),
                     (char far *)MK_FP(LIVE_VALUE_POOL_SEG,offset)+4,LIVE_VALUE_END-offset);
        LIVE_VALUE_POOL_FREE_LIST=0;
        LIVE_VALUE_POOL_USED=LIVE_VALUE_END;
        return selected;
    }
    index=node*4;
    selected=FIND_VALUE_REGISTER(node);
    if (selected==0xFF) return selected;
    type=COP_B(index,COP_REG_CLASS)&0x3F;
    mask=REG_CLASS_MASK_TABLE[type];
    if (((1<<selected)&mask)==0 &&
        ((mask&ALLOCATABLE_REGISTER_MASK)!=0 || ((1<<selected)&REG_CLASS_MASK_TABLE[hint])==0)) {
        replacement=PICK_FREE_REGISTER(mask,REG_CLASS_MASK_TABLE[hint]);
        RECORD_REGISTER_MOVE(3,REG_CLASS_IS_WORD[type],replacement,node,0);
        ALLOCATABLE_REGISTER_MASK|=(1<<selected)&BLOCK_FREE_REGISTER_MASK;
        PENDING_REGISTER_MASK&=~(1<<selected);
        PENDING_REGISTER_MASK|=1<<replacement;
        CLAIM_REGISTERS(1<<replacement);
        selected=replacement;
    }
    return selected;
}
#undef SLOT

/* ---- STAOV0B3 (listing ovr_1d83_a6f1:814A) ---- */
extern void far cdecl REPORT_FATAL(unsigned int);
#define NW(n) (*((unsigned int near *)(_SI+(n))))
#define NB(n) (*((signed char near *)(_SI+(n))))

/* FREE_REGISTER_FROM: frees one register of 'available' by moving its live value or
   pending request elsewhere (first to a register of the value's own class, then to any
   free register), returning the freed register. NW/NB read the words and bytes of a
   pending request (node at 0, reg at 2, mode at 4, mask at 6). */
static unsigned char near pascal FREE_REGISTER_FROM(unsigned int available)
{
    unsigned char selected,replacement;
    unsigned int index,type,node,mask;
    for (_DI=LIVE_VALUE_SPILL_END+4;_DI<LIVE_VALUE_END;_DI+=4) {
        _ES=LIVE_VALUE_POOL_SEG;
        node=ES_W(_DI,LVAL_OP);
        index=node*4;
        selected=FIND_VALUE_REGISTER(node);
        _BX=index;
        _ES=CODE_OP_POOL_SEG;
        type=ES_B(_BX,COP_REG_CLASS)&0x3F;
        mask=REG_CLASS_MASK_TABLE[type];
        if (((1<<selected)&available) && (mask&ALLOCATABLE_REGISTER_MASK)) {
            replacement=PICK_FREE_REGISTER(mask,mask);
            RECORD_REGISTER_MOVE(3,REG_CLASS_IS_WORD[type],replacement,node,0);
            CLAIM_REGISTERS(1<<replacement);
            ALLOCATABLE_REGISTER_MASK|=(1<<selected)&BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    for (_DI=LIVE_VALUE_SPILL_END+4;_DI<LIVE_VALUE_END;_DI+=4) {
        _ES=LIVE_VALUE_POOL_SEG;
        node=ES_W(_DI,LVAL_OP);
        index=node*4;
        selected=FIND_VALUE_REGISTER(node);
        if ((1<<selected)&available) {
            replacement=PICK_FREE_REGISTER(ALLOCATABLE_REGISTER_MASK,ALLOCATABLE_REGISTER_MASK);
            RECORD_REGISTER_MOVE(3,1,replacement,node,0);
            CLAIM_REGISTERS(1<<replacement);
            ALLOCATABLE_REGISTER_MASK|=(1<<selected)&BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    for (_SI=(unsigned int)(PENDING_REQUESTS+PENDING_REQUEST_COUNT-1);
         _SI>=(unsigned int)PENDING_REQUESTS;_SI-=sizeof(struct Entry)) {
        if (((1<<NB(2))&available) && (NW(6)&ALLOCATABLE_REGISTER_MASK)) {
            selected=NB(2);
            replacement=PICK_FREE_REGISTER(NW(6),NW(6));
            RECORD_REGISTER_MOVE(3,REG_CLASS_IS_WORD[NB(4)],replacement,NW(0),0);
            CLAIM_REGISTERS(1<<replacement);
            NB(2)=replacement;
            ALLOCATABLE_REGISTER_MASK|=(1<<selected)&BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    for (_SI=(unsigned int)(PENDING_REQUESTS+PENDING_REQUEST_COUNT-1);
         _SI>=(unsigned int)PENDING_REQUESTS;_SI-=sizeof(struct Entry)) {
        if ((1<<NB(2))&available) {
            selected=NB(2);
            replacement=PICK_FREE_REGISTER(ALLOCATABLE_REGISTER_MASK,ALLOCATABLE_REGISTER_MASK);
            RECORD_REGISTER_MOVE(3,REG_CLASS_IS_WORD[NB(4)],replacement,NW(0),0);
            CLAIM_REGISTERS(1<<replacement);
            NB(2)=replacement;
            ALLOCATABLE_REGISTER_MASK|=(1<<selected)&BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    REPORT_FATAL(MSG_REGISTER_ALLOCATION);
}
#undef NW
#undef NB

/* ---- STAOV0B4 (listing ovr_1d83_a6f1:838A) ---- */


/* FIND_VALUE_REGISTER: the register value op 'value' is in now: the latest history entry
   that moved it (following exchanges), else its COP_REGISTER. PEEPHOLE.C has the same
   search as FIND_ASSIGNED_REGISTER. */
static unsigned char near pascal FIND_VALUE_REGISTER(unsigned int value)
{
    register unsigned int entry;

    entry = HISTORY_END_OFFSET;
    while (entry) {
        entry -= 9;
        if (RHIST_W(entry, RHIST_INSN_INDEX) < value)
            break;
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

/* ---- STAOV0B5 (listing ovr_1d83_a6f1:83F3) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* RESOLVE_PENDING_NEXT_BLOCK: when values are still live at the end of block 'node',
   resolves the requests of the first op of the next non-empty block now, recording the
   moves with the negated op number so they are replayed at the end of 'node'. */
static void near pascal RESOLVE_PENDING_NEXT_BLOCK(register unsigned int node)
{
    if (LIVE_VALUE_END) {
        node = *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node + CNODE_NEXT));
        if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node + CNODE_OP_COUNT)) == 0)
            node = *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node + CNODE_NEXT));
        CURRENT_INSN_INDEX = -CURRENT_INSN_INDEX;
        RESOLVE_PENDING_REGISTERS(*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node + CNODE_FIRST_OP)), 0);
    }
}

/* ---- STAOV0B6 (listing ovr_1d83_a6f1:8431) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* CLAIM_REGISTERS: takes the registers in 'flags' out of the free set and records them as
   used in the block, the function and every scope from the current one outwards (word 2
   CNODE_SCOPE_REG_MASK, word 8 CNODE_SCOPE_PARENT). */
static void near pascal CLAIM_REGISTERS(register unsigned int flags)
{
    register unsigned int cursor;
    BLOCK_CLAIMED_REG_MASK |= flags;
    FUNCTION_CLAIMED_REG_MASK |= flags;
    ALLOCATABLE_REGISTER_MASK &= ~flags;
    cursor = REGALLOC_SCOPE_NODE;
    while (cursor) {
        ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, cursor))[2] |= flags;
        cursor = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, cursor))[8];
    }
}

/* ---- STAOV0B7 (listing ovr_1d83_a6f1:8467) ---- */
/* -Z: ES is kept across far stores into the same segment (user-accepted, batch290-admission/policy-Z-extension.json). */


extern unsigned int far pascal POOL_ALLOC(unsigned int far *segment,
                                            unsigned int size);

/* ADD_LIVE_VALUE: op 'value' now holds register 'shift' with uses ahead: the register is
   claimed and the value appended to the live list. */
static void near pascal ADD_LIVE_VALUE(unsigned int value, unsigned char shift)
{
    register unsigned int entry;
    CLAIM_REGISTERS(1 << shift);
    entry = POOL_ALLOC(&LIVE_VALUE_POOL_SEG, 4);
    *((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG, entry)) = value;
    *((unsigned int far *)MK_FP(LIVE_VALUE_POOL_SEG, entry + LVAL_USE_COUNT)) = 1;
    LIVE_VALUE_END = entry + 4;
}

/* ---- STAOV0B8 (listing ovr_1d83_a6f1:84A6) ---- */
/* HIGH_BIT_INDEX: number of the highest set bit of 'value' (0xFF for 0). */
unsigned char far pascal HIGH_BIT_INDEX(unsigned int value)
{
    unsigned char result;

    result = 0xFF;
    while (value != 0) {
        result++;
        value >>= 1;
    }
    return result;
}

/* ---- STAOV0B9 (listing ovr_1d83_a6f1:84C0) ---- */

/* COUNT_REGISTER_USES: adds one expected use to the live value of op 'node', or, for an op
   without a register, to the live values in its operand tree. */
static void near pascal COUNT_REGISTER_USES(unsigned int node)
{
    register unsigned int cursor,record;
    if(node) {
        record=node*4;
        if(COP_B(record,COP_REGISTER)!=0xFF) {
            for(cursor=0;cursor<LIVE_VALUE_END;cursor+=4) {
                if(LVAL_W(cursor,LVAL_OP)==node) {
                    ++LVAL_W(cursor,LVAL_USE_COUNT);
                    break;
                }
            }
        } else {
            if((*((unsigned long near *)(CODE_OP_INFO_TABLE+COP_B(record,COP_OPCODE)*19))&0x29L)==0L) {
                COUNT_REGISTER_USES(OPND_W(record,OPND_LEFT));
                COUNT_REGISTER_USES(OPND_W(record,OPND_RIGHT));
            }
        }
    }
}

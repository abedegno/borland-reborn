/* target: ovr158_C109UNIT */
/* Role: code generation: 8087 support (floating-point operations, compares, stores, the
   8087 register stack) and the saved-register pushes. Entry points: SWAP_OPERAND_OPCODE,
   GEN_FPU_BINARY_OP, GEN_FPU_COMPARE, FPU_STORE_NODE_6C, PUSH_FLOAT_ARGUMENT,
   GEN_FLOAT_POSTINC_DEC, EMIT_FLOAT_CONSTANT, RESOLVE_STACK_BALANCE (+12 more). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Original CO062 (ovr_1d87_a854) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: most of this file is the code generator's 8087
   support. It builds floating-point code ops (binary ops, compares, stores, float
   arguments, x++ on floats, constants) and keeps track of the 8087 register stack while
   the register allocator walks the ops (REGALLOC.C calls PUSH_EVAL_STACK,
   POP_EVAL_STACK_OPERANDS and SPILL_EVAL_STACK_TO_TEMPS). The 8087 stack has only eight
   registers, so when values must leave it (around calls, probably) they are spilled into
   10-byte temporaries and reloaded later; spills and reloads are register history entries
   (actions 4 and 5) that EMIT_REGISTER_HISTORY (EMITHIST.C) replays. A reloaded value
   can end up below the other operand, so the reload records that the next op must use its
   operand-swapped form (SWAP_OPERAND_OPCODE).
   State: EVAL_STACK_TOP (top index, -1 when empty), EVAL_STACK_SPILLED (entries up to
   this index are in temporaries), EVAL_STACK_VALUES/EVAL_STACK_TEMP_NODES (the op and the
   temporary of each level; level*2 indexes these interleaved word arrays), EVAL_STACK_MAX;
   POOLED_NODE_STACK/POOLED_NODE_TOP (free spill temporaries), SCRATCH_TEMP_VARIABLE (one
   temporary for conversions, FLOAT_TEMP_NODE).
   The file also resolves stack offsets of pushed float arguments (RESOLVE_STACK_BALANCE)
   and emits the 8087 slots of SAVED_REG_MASK around the function body (called from
   FRAME.C; no C code in src/ writes SAVED_REG_MASK).
   Probable meanings of the 8087 ops: 0x57 FWAIT, 0x67 FLD and 0x6C FSTP of a memory
   operand (plus OPERAND_KIND_OPCODE_DELTA for its size), 0x8A FLDZ, 0x8B FLD1, 0x8C FLD
   ST(i), 0x90 discard the top value, 0x84 compare, 0x8F FSTSW, 0x29-0x2E and 0x38-0x3D
   the subtract and divide families in normal and reversed form. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"



/* ---- STAOV0BA (listing ovr_1d87_a854:8540) ---- */

/* OPERAND_KIND_OPCODE_DELTA: how far the 8087 op for op 'value''s operand size lies from
   the base op: reads the size byte of the op's table entry (DS:3F9F = CODE_OP_INFO_TABLE+4)
   and returns 0 below 4 bytes, else size-6 (-2 float, 2 double, 4 long double). */
static int near pascal OPERAND_KIND_OPCODE_DELTA(unsigned int value)
{
    register int size;
    size = ((unsigned char near *)((char near *)&CODE_OP_INFO_TABLE+4))[
        *(unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value << 2) * 19];
    if (size < 4)
        return 0;
    return size - 6;
}

/* ---- STAOV0BB (listing ovr_1d87_a854:8578) ---- */
/* SWAP_OPERAND_OPCODE: the operand-reversed form of 8087 op 'value' (0x29-0x2B and
   0x38-0x3A move up by 3, 0x2C-0x2E and 0x3B-0x3D down by 3; probably FSUB/FSUBR and
   FDIV/FDIVR); other ops are returned unchanged. */
int far pascal SWAP_OPERAND_OPCODE(register int value)
{
    if ((value >= 0x29 && value <= 0x2B) ||
        (value >= 0x38 && value <= 0x3A))
        return value + 3;
    if ((value >= 0x2C && value <= 0x2E) ||
        (value >= 0x3B && value <= 0x3D))
        return value - 3;
    return value;
}

/* ---- STAOV0BC (listing ovr_1d87_a854:85BC) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);
/* GEN_FPU_BINARY_OP: builds the 8087 op for binary node 'type' (its value kind is set to
   long double to pick the op family) on operand ops 'first' and 'last'. If 'last' was
   generated before 'first' the operands are swapped and the reversed op is used. The op
   is sized by 'last'. Returns the new op. */
unsigned int far pascal GEN_FPU_BINARY_OP(unsigned int type,register unsigned int first,register unsigned int last)
{
    unsigned int offset,swap;
    *((unsigned int far *)MK_FP(EXPR_POOL_SEG,type+EXPR_KIND))=0x0B;
    offset=CODE_OP_FOR_NODE(type);
    if(last<first) {
        offset=SWAP_OPERAND_OPCODE(offset);
        swap=first; first=last; last=swap;
    }
    return NEW_CODE_NODE(offset+OPERAND_KIND_OPCODE_DELTA(last),0,first,last);
}

/* ---- STAOV0BD (listing ovr_1d87_a854:8614) ---- */
unsigned int far pascal FLOAT_TEMP_NODE(int index, unsigned int value);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);

/* GEN_FPU_COMPARE: builds an 8087 compare of 'other' with 'value', then moves the 8087
   status word into the CPU flags: FSTSW into AX when OPTION_FLOAT_MODE is 3 (probably
   -f287), otherwise into a temporary, FWAIT, then ops 0xB7 and 0xA9 (probably MOV AH and
   SAHF), so an ordinary conditional jump can follow (see REMAP_JUMP_KIND). */
void far pascal GEN_FPU_COMPARE(unsigned int other,register unsigned int value)
{
    NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(value)+0x84,0,other,value);
    if(OPTION_FLOAT_MODE==3) {
        NEW_CODE_NODE(0x8F,2,NEW_CODE_NODE(8,0,0,0),0);
        NEW_CONSTANT_NODE(0x57,0L);
        NEW_CODE_NODE(0xB7,0,NEW_CODE_NODE(8,0,0,0),0);
    } else {
        NEW_CODE_NODE(0x8F,2,FLOAT_TEMP_NODE(3,0),0);
        NEW_CONSTANT_NODE(0x57,0L);
        NEW_CODE_NODE(0xB7,0,FLOAT_TEMP_NODE(3,0),0);
    }
    NEW_CONSTANT_NODE(0xA9,0L);
}

/* ---- STAOV0BE (listing ovr_1d87_a854:86D9) ---- */
/* FPU_STORE_NODE_6C: builds 'store 8087 value 'mode' into 'value'' (op 0x6C sized by
   'value', working in place on it) followed by FWAIT; returns the store op. */
unsigned int far pascal FPU_STORE_NODE_6C(unsigned int value, unsigned int mode)
{
    register unsigned int item = value;
    unsigned int result;

    result = NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(item) + 0x6C, 2, item, mode);
    NEW_CONSTANT_NODE(0x57, 0L);
    return result;
}

/* ---- STAOV0BF (listing ovr_1d87_a854:8712) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);

/* PUSH_FLOAT_ARGUMENT: passes floating argument 'node': SP is lowered by its size (op 0xAD
   with -size), and the value is stored into the new stack slot (op 0xB2, whose offset
   RESOLVE_STACK_BALANCE fills in later, hence STACK_BALANCE_NEEDED), then FWAIT. */
unsigned int far pascal PUSH_FLOAT_ARGUMENT(register unsigned int node)
{
    register unsigned int result;
    unsigned int kind;
    unsigned long value;
    unsigned int size;
    kind=EXPR_W(node,EXPR_KIND)+0x61;
    value=GENERATE_EXPRESSION(node,1);
    size=SIZE_OF_TYPE_CHECKED_HOOK(EXPR_W(node,EXPR_TYPE));
    NEW_CONSTANT_NODE(0xAD,(unsigned long)(unsigned int)(-size));
    result=NEW_CONSTANT_NODE(0xB2,0L);
    STACK_BALANCE_NEEDED=1;
    result=NEW_CODE_NODE(kind,2,result,(unsigned int)value);
    NEW_CONSTANT_NODE(0x57,0L);
    return result;
}

/* ---- STAOV0C0 (listing ovr_1d87_a854:879C) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *EXPAND_COMPOUND_ASSIGN_HOOK)(unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);

/* GEN_FLOAT_POSTINC_DEC: x++ or x-- on a floating x (EOP_POSTINC/EOP_POSTDEC): loads x
   (the result), adds or subtracts 1 to a copy (FLD ST(0), FLD1 and the op of the
   compound assignment EXPAND_COMPOUND_ASSIGN_HOOK builds) and stores it back. */
unsigned int far pascal GEN_FLOAT_POSTINC_DEC(register unsigned int node,unsigned int unused)
{
    unsigned int value,first,second,kind;
    register unsigned int result;
    EXPR_W(node,EXPR_KIND)=TK_LDOUBLE;
    kind=CODE_OP_FOR_NODE(node);
    node=EXPAND_COMPOUND_ASSIGN_HOOK(node);
    result=GENERATE_EXPRESSION(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_LEFT),1);
    result=NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(result)+0x67,0,0,result);
    first=NEW_CONSTANT_NODE(0x8C,0L);
    second=NEW_CONSTANT_NODE(0x8B,0L);
    first=NEW_CODE_NODE(kind,0,first,second);
    value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
    NEW_CODE_NODE(OPERAND_KIND_OPCODE_DELTA(value)+0x6C,2,value,first);
    return result;
}

/* ---- STAOV0C1 (listing ovr_1d87_a854:885C) ---- */
/* COMPARE_TEN_BYTES: 0 when the two 10-byte long doubles are identical, else 1. */
static int near pascal COMPARE_TEN_BYTES(unsigned char far *first,
                                      unsigned char far *second)
{
    register int count;

    count = 10;
    while (--count >= 0) {
        if (*first != *second)
            return 1;
        first++;
        second++;
    }
    return 0;
}

/* ---- STAOV0C2 (listing ovr_1d87_a854:888A) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned char BCC_PACK_FLAG;
extern unsigned int (far pascal *STRING_LITERAL_SYMBOL_HOOK)(void);
extern void far pascal RTL_LONG_TO_LDOUBLE(long,void far *);
extern void far pascal RTL_LDOUBLE_ROUND_TO_FLOAT(void far *);
extern void far pascal RTL_LDOUBLE_TO_FLOAT(void far *,void far *);
extern void far pascal RTL_LDOUBLE_TO_DOUBLE(void far *,void far *);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal BYTE_POOL_LENGTH(void);
extern unsigned int far pascal MERGE_DUPLICATE_BYTES(unsigned int);
extern void far pascal EMIT_VALUE(unsigned char);
#define OPERAND ((void far *)MK_FP(EXPR_POOL_SEG,node+10))

/* EMIT_FLOAT_CONSTANT: the op for floating constant 'node' (its long double at node+10).
   0.0 and 1.0 become FLDZ and FLD1. Other values are stored in the data byte pool in the
   smallest exact form (float when rounding to float loses nothing, else the node's own
   kind), word-aligned when BCC_PACK_FLAG is set and merged with an identical earlier
   copy, and read as a leaf at that offset of the string-literal symbol. */
unsigned int far pascal EMIT_FLOAT_CONSTANT(unsigned int node)
{
    unsigned char first[10],second[10],zero[10],one[10];
    unsigned int offset;
    int size,kind;
    register int i;
    RTL_LONG_TO_LDOUBLE(0L,zero);
    if (!COMPARE_TEN_BYTES(OPERAND,zero)) return NEW_CONSTANT_NODE(0x8A,0L);
    RTL_LONG_TO_LDOUBLE(1L,one);
    if (!COMPARE_TEN_BYTES(OPERAND,one)) return NEW_CONSTANT_NODE(0x8B,0L);
    kind=*((unsigned int far *)MK_FP(EXPR_POOL_SEG,node+EXPR_KIND));
    RTL_MEMMOVE(first,OPERAND,10);
    RTL_LDOUBLE_ROUND_TO_FLOAT(first);
    if (!COMPARE_TEN_BYTES(first,OPERAND)) kind=9;
    RTL_MEMMOVE(second,OPERAND,10);
    switch (kind) {
    case 9:
        RTL_LDOUBLE_TO_FLOAT(second,first);
        size=4;
        break;
    case 10:
        RTL_LDOUBLE_TO_DOUBLE(second,first);
        size=8;
        break;
    case 11:
        RTL_MEMMOVE(first,OPERAND,10);
        size=10;
        break;
    }
    offset=BYTE_POOL_LENGTH();
    if (BCC_PACK_FLAG && (offset&1)) {
        EMIT_VALUE(0);
        ++offset;
    }
    for (i=0;i<size;++i) EMIT_VALUE(first[i]);
    offset=MERGE_DUPLICATE_BYTES(offset);
    return NEW_VARIABLE_NODE(LEAF_OPCODE_KIND_OFFSET[kind]+15,STRING_LITERAL_SYMBOL_HOOK(),offset,0);
}
#undef OPERAND

/* ---- STAOV0C3 (listing ovr_1d87_a854:8A27) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* RESOLVE_STACK_BALANCE: when STACK_BALANCE_NEEDED, walks all ops in block order counting
   how far SP has moved (pushes and PUSHF without a register -2, pops +2, history pushes
   and pops, SP adjustments 0xAD/0xAE) and stores the running value as the constant of
   each stack-slot op 0xB2, which OPERAND_FROM_NODE (EMITINSN.C) turns into a BP-relative
   address. The count simply carries on from block to block. */
void far pascal RESOLVE_STACK_BALANCE(void)
{
    unsigned int node,index,count;
    register unsigned int history;
    register int balance;
    if(STACK_BALANCE_NEEDED==0) return;
    balance=0;
    for(node=CODE_BLOCK_LIST_HEAD;node;) {
        register unsigned int cursor;
        cursor=(index=CNODE_W(node,CNODE_FIRST_OP))*4;
        history=CNODE_W(node,CNODE_HISTORY);
        count=CNODE_W(node,CNODE_OP_COUNT);
        while(count>0) {
            while(history<HISTORY_END_OFFSET &&
                  RHIST_W(history,RHIST_INSN_INDEX)==index) {
                switch((int)RHIST_B(history,RHIST_ACTION)) {
                case 1: balance-=2; break;
                case 2: balance+=2; break;
                }
                history+=9;
            }
            switch((int)COP_B(cursor,COP_OPCODE)) {
            case 0x73:
                if(COP_B(cursor,COP_REGISTER)!=0xFF) break;
            case 0x93: case 0x94:
                balance-=2;
                break;
            case 0x7F:
                balance+=2;
                break;
            case 0xAD: case 0xAE:
                balance+=(int)OPND_W(cursor,OPND_LEFT);
                break;
            case 0xB2:
                *((long far *)MK_FP(CODE_OPERAND_POOL_SEG,cursor))=(long)balance;
                break;
            }
            cursor+=4;
            ++index;
            --count;
        }
        while(history<HISTORY_END_OFFSET &&
              RHIST_W(history,RHIST_INSN_INDEX)==-index) {
            switch((int)RHIST_B(history,RHIST_ACTION)) {
            case 1: balance-=2; break;
            case 2: balance+=2; break;
            }
            history+=9;
        }
        node=CNODE_W(node,CNODE_NEXT);
    }
}

/* ---- STAOV0C4 (listing ovr_1d87_a854:8B5C) ---- */

/* RESET_TEMP_POOL: forgets the spill temporaries, the scratch temporary and the 8087 stack
   depth (called by RELEASE_VARIABLE_TABLE after each function). */
void far pascal RESET_TEMP_POOL(void)
{
    POOLED_NODE_TOP = -1;
    SCRATCH_TEMP_VARIABLE = 0;
    EVAL_STACK_MAX = -1;
}

/* ---- ACQUIRE_POOLED_NODE (listing ovr_1d87_a854:8B73) ---- */
unsigned int far pascal ACQUIRE_POOLED_NODE(void);
/* -Z: ES is kept across far stores into the same segment (user-accepted, batch290-admission/policy-Z-extension.json). */


extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int, unsigned char, unsigned char);

/* ACQUIRE_POOLED_NODE: a 10-byte temporary for an 8087 spill: a released one if any, else
   a new variable-table entry (long double, kept in memory). */
unsigned int far pascal ACQUIRE_POOLED_NODE(void)
{
    register unsigned int node;
    if (POOLED_NODE_TOP < 0) {
        node = FIND_OR_ADD_VARIABLE(0, 11, 0);
        *((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG, node + VAR_FLAGS)) |= 4;
        *((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG, node + VAR_USE_COUNT)) = 1;
        return node;
    }
    return POOLED_NODE_STACK[POOLED_NODE_TOP--];
}

/* ---- STAOV0C6 (listing ovr_1d87_a854:8BB0) ---- */

/* RELEASE_POOLED_NODE: returns spill temporary 'value' for reuse (at most 100 are kept). */
void far pascal RELEASE_POOLED_NODE(unsigned int value)
{
    if (POOLED_NODE_TOP < 99) {
        POOLED_NODE_TOP++;
        POOLED_NODE_STACK[POOLED_NODE_TOP] = value;
    }
}

/* ---- STAOV0C7 (listing ovr_1d87_a854:8BCF) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int value,
    unsigned char first, unsigned char second);
extern unsigned int far pascal NEW_PLAIN_CODE_NODE(unsigned int size,
    unsigned int state, unsigned int value);

/* FLOAT_TEMP_NODE: a leaf op of value kind 'index' reading the scratch temporary at offset
   'value'. The temporary is created on first use and its kind grows to the largest
   'index' asked for, so it is big enough for every use (CGCONV.C uses it to move values
   between the CPU and the 8087). */
unsigned int far pascal FLOAT_TEMP_NODE(int index, unsigned int value)
{
    if (SCRATCH_TEMP_VARIABLE == 0) {
        SCRATCH_TEMP_VARIABLE = FIND_OR_ADD_VARIABLE(0, 3, 0);
        *((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG, SCRATCH_TEMP_VARIABLE + VAR_FLAGS)) |= 4;
        *((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG, SCRATCH_TEMP_VARIABLE + VAR_USE_COUNT)) = 1;
    }
    if (*((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG, SCRATCH_TEMP_VARIABLE + VAR_TYPE_KIND)) < index)
        *((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG, SCRATCH_TEMP_VARIABLE + VAR_TYPE_KIND)) = index;
    return NEW_PLAIN_CODE_NODE(LEAF_OPCODE_KIND_OFFSET[index] + 0x0F, SCRATCH_TEMP_VARIABLE, value);
}

/* ---- STAOV0C8 (listing ovr_1d87_a854:8C34) ---- */
extern unsigned int far pascal POOL_ALLOC(char far *state, unsigned int size);

/* SPILL_EVAL_STACK_TO_TEMPS: before op 'value', records a spill (history action 4) of
   every 8087 stack entry not yet spilled, each into its own pooled temporary. */
void far pascal SPILL_EVAL_STACK_TO_TEMPS(unsigned int value)
{
    register unsigned int node;
    register int level;
    for (level = EVAL_STACK_TOP; level > EVAL_STACK_SPILLED; level--) {
        node = POOL_ALLOC((char far *)&REG_HISTORY_POOL_SEG, 9);
        *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, node)) = 4;
        *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_INSN_INDEX)) = value;
        *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_IS_WORD)) = 0;
        *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_REGISTER)) = 0;
        *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_VALUE_OP)) = EVAL_STACK_VALUES[level * 2];
        *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_PARTNER)) = ACQUIRE_POOLED_NODE();
        EVAL_STACK_TEMP_NODES[level * 2] = *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_PARTNER));
    }
    EVAL_STACK_SPILLED = EVAL_STACK_TOP;
}

/* ---- STAOV0C9 (listing ovr_1d87_a854:8CA3) ---- */

/* FPU_STACK_OPERAND_OR_ZERO: returns op 'value' when its result is a value on the 8087
   stack (an op with table flag 2 that is neither dead nor folded into an operand,
   looking through sequence ops 3 to the value they yield), else 0. */
unsigned int far pascal FPU_STACK_OPERAND_OR_ZERO(unsigned int value)
{
    register unsigned int slot;

    if (!value)
        return 0;
    slot = value << 2;
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, slot + COP_FLAGS)) & 0x40)
        return 0;
    while (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, slot)) == 3) {
        slot = *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, slot + OPND_RIGHT)) << 2;
        value = *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, slot));
        slot = value << 2;
    }
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, slot + COP_FLAGS)) & 1)
        return 0;
    if ((*((unsigned long near *)(CODE_OP_INFO_TABLE +
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, slot)) * 19)) & 2L) != 0L)
        return value;
    return 0;
}

/* ---- STAOV0CA (listing ovr_1d87_a854:8D1A) ---- */
extern unsigned int far pascal POOL_ALLOC(char far *state, unsigned int size);

/* RELOAD_SPILLED_EVAL_ENTRY: before op 'second', records the reload (history action 5) of
   spilled value 'first' from the top spilled level's temporary, which is released.
   RHIST_REGISTER is 1 when unspilled values remain above it, so the replay sets
   SWAP_OPCODE_FLAG. */
static void far pascal RELOAD_SPILLED_EVAL_ENTRY(unsigned int first, unsigned int second)
{
    register unsigned int node;
    node = POOL_ALLOC((char far *)&REG_HISTORY_POOL_SEG, 9);
    *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, node)) = 5;
    *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_INSN_INDEX)) = second;
    *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_IS_WORD)) = 0;
    *((unsigned char far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_REGISTER)) = EVAL_STACK_SPILLED < EVAL_STACK_TOP;
    *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_VALUE_OP)) = first;
    *((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_PARTNER)) = EVAL_STACK_TEMP_NODES[EVAL_STACK_SPILLED * 2];
    RELEASE_POOLED_NODE(*((unsigned int far *)MK_FP(REG_HISTORY_POOL_SEG, node + RHIST_PARTNER)));
    EVAL_STACK_SPILLED--;
}

/* ---- STAOV0CB (listing ovr_1d87_a854:8D84) ---- */

/* POP_EVAL_STACK_OPERANDS: op 'node' (a record offset) at op number 'value' consumes its
   8087 operands: right, then left (not for a sequence op 3), each reloaded first if it
   was spilled; EVAL_STACK_TOP drops accordingly. */
void far pascal POP_EVAL_STACK_OPERANDS(register unsigned int node,unsigned int value)
{
    unsigned int first,second;
    int level;
    level=EVAL_STACK_TOP;
    second=OPND_W(node,OPND_RIGHT);
    if (COP_B(node,COP_OPCODE)==3)
        second=OPND_W(second<<2,OPND_LEFT);
    second=FPU_STACK_OPERAND_OR_ZERO(second);
    if (second) {
        if (EVAL_STACK_SPILLED==level) RELOAD_SPILLED_EVAL_ENTRY(second,value);
        --level;
    }
    first=FPU_STACK_OPERAND_OR_ZERO(OPND_W(node,OPND_LEFT));
    if (first) {
        if (COP_B(node,COP_OPCODE)!=3) {
            if (EVAL_STACK_SPILLED==level) RELOAD_SPILLED_EVAL_ENTRY(first,value);
            --level;
        }
    }
    EVAL_STACK_TOP=level;
}

/* ---- STAOV0CC (listing ovr_1d87_a854:8E15) ---- */

/* PUSH_EVAL_STACK: op 'value' leaves its result on the 8087 stack. */
void far pascal PUSH_EVAL_STACK(unsigned int value)
{
    EVAL_STACK_TOP++;
    EVAL_STACK_VALUES[EVAL_STACK_TOP * 2] = value;
    if (EVAL_STACK_TOP > EVAL_STACK_MAX)
        EVAL_STACK_MAX = EVAL_STACK_TOP;
}

/* ---- STAOV0CD (listing ovr_1d87_a854:8E3B) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int);
extern void far pascal EMIT_INSN_NODE(unsigned int,unsigned int);
extern void far pascal EMIT_INSN_NODE_REG(unsigned int,unsigned int,unsigned char);

/* EMIT_FPU_OP_ON_OPERAND: emits 8087 op 'kind' that works in place on memory operand
   'value' (called from EMIT_BLOCK_INSTRUCTIONS). If the operand is a register variable
   (VAR_FLAGS 2) the op takes the register as a second operand. Otherwise the reversed op
   is applied with the memory operand and the result stored back with FSTP (for a leaf op
   0x14 the operand is loaded with FLD first and the reversed op has no operand). */
void far pascal EMIT_FPU_OP_ON_OPERAND(unsigned int kind,register unsigned int value)
{
    unsigned int item;
    register unsigned int offset;
    offset=value*4;
    item=OPND_W(offset,OPND_LEFT);
    if(VAR_B(item,VAR_FLAGS)&2) EMIT_INSN_NODE_REG(kind,value,0);
    else {
        if(COP_B(offset,COP_OPCODE)==0x14) {
            EMIT_INSN_NODE(0x67,value);
            EMIT_INSN_NO_OPERANDS(SWAP_OPERAND_OPCODE(kind));
            EMIT_INSN_NODE(0x6C,value);
        } else {
            EMIT_INSN_NODE(SWAP_OPERAND_OPCODE(kind),value);
            EMIT_INSN_NODE(OPERAND_KIND_OPCODE_DELTA(value)+0x6C,value);
        }
    }
}

/* ---- STAOV0CE (listing ovr_1d87_a854:8EBD) ---- */

/* REMAP_JUMP_KIND: the jump kind to use after an 8087 compare, from JUMP_KIND_REMAP_TABLE
   (probably signed conditions to the unsigned ones that SAHF's carry and zero flags
   need). */
int far pascal REMAP_JUMP_KIND(register unsigned int index)
{
    index = JUMP_KIND_REMAP_TABLE[index];
    return index;
}

/* ---- STAOV0CF (listing ovr_1d87_a854:8ED0) ---- */

/* EMIT_SAVED_REG_PUSHES: emits one FLDZ (0x8A) per bit of SAVED_REG_MASK, probably
   reserving 8087 stack slots at function entry (called from the prologues in FRAME.C). */
void far pascal EMIT_SAVED_REG_PUSHES(void)
{
    unsigned int state = SAVED_REG_MASK;

    while (state != 0) {
        if (state & 1)
            EMIT_INSN_NO_OPERANDS(0x8A);
        state >>= 1;
    }
}

/* ---- STAOV0D0 (listing ovr_1d87_a854:8EF2) ---- */
extern void far pascal EMIT_INSN_REG(unsigned int value, unsigned char count);

/* EMIT_SAVED_REG_POPS: removes those slots at function exit: one discard (0x90) per slot,
   except that when 'mode' says the function returns a floating value, the first is
   '0x6C with register count' (probably FSTP ST(count)), which moves the result into the
   deepest slot so it stays on top when the rest are dropped. */
void far pascal EMIT_SAVED_REG_POPS(unsigned int mode)
{
    int count;
    register unsigned int bits;

    count = 0;
    bits = SAVED_REG_MASK;
    while (bits != 0) {
        count = count + (bits & 1);
        bits >>= 1;
    }
    if (mode != 0 && count > 0) {
        EMIT_INSN_REG(0x6C, count);
        count--;
    }
    while (count != 0) {
        EMIT_INSN_NO_OPERANDS(0x90);
        count--;
    }
}

/* target: ovr177_C215UNIT */
/* Role: bitfield load, store and increment. Entry points: GENERATE_BITFIELD_STORE,
   GENERATE_BITFIELD_OP_ASSIGN, GENERATE_BITFIELD_INC_DEC, NEW_SHIFT_NODE. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Original CO074 (ovr_1dd3_b1f8) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: code for bit-field accesses, called from GENERATE_EXPRESSION (CGEXPR.C) when
   it meets a bit-field node (EXPR_OP 0x33: EXPR_LEFT the containing storage unit,
   EXPR_BIT_SHIFT the bit offset, EXPR_BIT_WIDTH the width). A field that fits in the low
   byte (shift+width <= 8) is accessed as a char, otherwise as an int. Loading extracts
   the field with shifts (signed: shift left to the top, then arithmetic right) or shift
   and mask (unsigned, EXPR_FLAGS bit 0x20 of the field's kind, probably 'unsigned').
   Storing clears the field with AND and sets it with OR; increments read, add, mask and
   merge. Results are returned as an op pair packed in a long (low word: the op number of
   the value; high word 0). Code ops used, probably: 0x45 SHL word, 0x47 SHR word, 0x49 SAR
   word, 0x4A/0x4B AND byte/word, 0x4C/0x4D OR byte/word, 0x1F ADD word, 0x28 SUB word,
   0x98 a copy into a register, constants 9 (byte, also shift counts) and 10 (word).
   COP_FLAGS 2 on an AND/OR means it works on its left operand in place (a read-modify-write
   of the storage unit). The _DI/_ES register code is a shape kept for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- GENERATE_BITFIELD_LOAD (listing ovr_1dd3_b1f8:1F80) ---- */
unsigned int far pascal NEW_SHIFT_NODE(register unsigned int start, unsigned int value, register int flag);
extern unsigned int EXPR_POOL_SEG;
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
#define LOW(v) (*((unsigned int near *)&(v)))
/* GENERATE_BITFIELD_LOAD: generates the value of bit-field node 'input'. Retypes the
   storage-unit node to char or int first, then generates it and isolates the field as
   described in the overview. */
static long far pascal GENERATE_BITFIELD_LOAD(unsigned int input)
{
    int mask;
    long value;
    unsigned int constant;
    int shift,width;
    unsigned int node;
    register int amount;
    _DI=input;
    _ES=EXPR_POOL_SEG;
    shift=ES_SC(_DI,EXPR_BIT_SHIFT);
    width=ES_SC(_DI,EXPR_BIT_WIDTH);
    node=ES_W(_DI,EXPR_LEFT);
    if(shift+width<=8) {
        _BX=node;
        ES_W(_BX,EXPR_KIND)=1;
        mask=255;
    } else {
        _BX=node;
        _ES=EXPR_POOL_SEG;
        ES_W(_BX,EXPR_KIND)=5;
        mask=-1;
    }
    value=GENERATE_EXPRESSION(node,1);
    _ES=EXPR_POOL_SEG;
    if(!(EXPR_FLAGS[ES_W(_DI,EXPR_KIND)]&32)) {
        amount=16-(shift+width);
        if(amount) LOW(value)=NEW_SHIFT_NODE(LOW(value),0x45,amount);
        amount=16-width;
        if(amount) {
            LOW(value)=NEW_SHIFT_NODE(LOW(value),0x49,amount);
            /* Preserve the separate result store without emitted code. */
            amount=amount;
        }
    } else {
        amount=(1<<width)-1;
        if(shift) LOW(value)=NEW_SHIFT_NODE(LOW(value),0x47,shift);
        constant=NEW_CONSTANT_NODE(10,(long)(amount&mask));
        LOW(value)=NEW_CODE_NODE(0x4B,0,LOW(value),constant);
    }
    return value;
}
#undef LOW

/* ---- GENERATE_BITFIELD_STORE (listing ovr_1dd3_b1f8:2091) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])
/* GENERATE_BITFIELD_STORE: generates 'dest = source' for bit-field node 'dest'; 'keep'
   non-zero means the assigned value is needed as the result (it is then returned, masked
   to the field width). A one-bit field set from a constant becomes a single OR or AND; a
   constant source is shifted at compile time; other sources are masked, shifted into
   place and ORed in after the field is cleared. */
unsigned long far pascal GENERATE_BITFIELD_STORE(unsigned int dest,register unsigned int source,unsigned int keep)
{
    unsigned long first,second,result;
    unsigned int temp,type,orop,andop;
    int shift,width,mask,clear;
    shift=EXPR_SC(dest,EXPR_BIT_SHIFT);
    width=EXPR_SC(dest,EXPR_BIT_WIDTH);
    mask=(1<<width)-1;
    clear=~(mask<<shift);
    if (shift+width<=8) {
        EXPR_W(EXPR_W(dest,EXPR_LEFT),EXPR_KIND)=TK_CHAR;
        type=9;orop=0x4C;andop=0x4A;
        clear&=0xFF;mask&=0xFF;
    } else {type=10;orop=0x4D;andop=0x4B;}
    if (width==1 && EXPR_W(source,EXPR_OP)==EOP_CONST) {
        second=GENERATE_EXPRESSION(EXPR_W(dest,EXPR_LEFT),1);
        EXPR_L(source,EXPR_VALUE)&=1L;
        if (EXPR_L(source,EXPR_VALUE)) {
            temp=NEW_CONSTANT_NODE(type,(long)(1<<shift));
            LOW(second)=NEW_CODE_NODE(orop,2,LOW(second),temp);
        } else {
            temp=NEW_CONSTANT_NODE(type,(long)clear);
            LOW(second)=NEW_CODE_NODE(andop,2,LOW(second),temp);
        }
        LOW(result)=NEW_CONSTANT_NODE(10,EXPR_L(source,EXPR_VALUE));
    } else {
        if (EXPR_W(source,EXPR_OP)!=EOP_CONST) {
            first=GENERATE_EXPRESSION(source,1);
            LOW(first)=NEW_CODE_NODE(0x4B,0,LOW(first),NEW_CONSTANT_NODE(10,(long)mask));
        }
        second=GENERATE_EXPRESSION(EXPR_W(dest,EXPR_LEFT),1);
        temp=NEW_CONSTANT_NODE(type,(long)clear);
        NEW_CODE_NODE(andop,2,LOW(second),temp);
        clear=shift;
        if (EXPR_W(source,EXPR_OP)==EOP_CONST) {
            EXPR_L(source,EXPR_VALUE)&=(long)mask;
            clear=EXPR_W(source,EXPR_LEFT)<<clear;
            if (clear) {
                LOW(first)=NEW_CONSTANT_NODE(type,(long)clear);
                NEW_CODE_NODE(orop,2,LOW(second),LOW(first));
            }
            if (keep) LOW(result)=NEW_CONSTANT_NODE(10,EXPR_L(source,EXPR_VALUE));
        } else {
            if (keep) LOW(result)=NEW_CODE_NODE(0x98,0,LOW(first),0);
            LOW(first)=NEW_SHIFT_NODE(LOW(first),0x45,clear);
            NEW_CODE_NODE(orop,2,LOW(second),LOW(first));
        }
    }
    HIGH(result)=0;
    return result;
}
#undef LOW
#undef HIGH

/* ---- GENERATE_BITFIELD_OP_ASSIGN (listing ovr_1dd3_b1f8:22D9) ---- */
extern unsigned int (far pascal *EXPAND_COMPOUND_ASSIGN_HOOK)(unsigned int);

/* GENERATE_BITFIELD_OP_ASSIGN: compound assignment to a bit-field: rewritten by
   EXPAND_COMPOUND_ASSIGN_HOOK into 'field = field op value' and generated normally;
   'second' is the keep-result flag. */
unsigned long far pascal GENERATE_BITFIELD_OP_ASSIGN(unsigned int first, unsigned int second)
{
    return GENERATE_EXPRESSION(EXPAND_COMPOUND_ASSIGN_HOOK(first), second);
}

/* ---- GENERATE_BITFIELD_INC_DEC (listing ovr_1dd3_b1f8:22F0) ---- */
extern unsigned int EXPR_POOL_SEG;
extern int (far pascal *TREE_HAS_SIDE_EFFECTS_HOOK)(unsigned int);
extern unsigned int (far pascal *EXPAND_INC_DEC_HOOK)(unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])
/* GENERATE_BITFIELD_INC_DEC: x++ or x-- (EXPR_OP 0x23/0x24; 19/20 are += and -=) on a
   bit-field. When the storage unit's address has side effects the node is rewritten
   through the hooks instead, so the address is evaluated once. Otherwise: copy the unit,
   add or subtract 1<<shift, mask to the field, clear the field in memory, OR the new bits
   in. With 'keep', the result is the old value (postfix) or the new one, extracted like
   GENERATE_BITFIELD_LOAD does. */
unsigned long far pascal GENERATE_BITFIELD_INC_DEC(unsigned int node,unsigned int keep)
{
    int value;
    unsigned int op;
    unsigned long operand,result,temp;
    unsigned int mask,child;
    _SI=node;
    _ES=EXPR_POOL_SEG;
    _DI=ES_W(_SI,EXPR_LEFT);
    child=ES_W(_DI,EXPR_LEFT);
    if (TREE_HAS_SIDE_EFFECTS_HOOK(child)) {
        _ES=EXPR_POOL_SEG;
        if (ES_W(_SI,EXPR_OP)==19 || ES_W(_SI,EXPR_OP)==20)
            return GENERATE_EXPRESSION(EXPAND_COMPOUND_ASSIGN_HOOK(_SI),keep);
        return GENERATE_EXPRESSION(EXPAND_INC_DEC_HOOK(_SI),keep);
    }
    _ES=EXPR_POOL_SEG;
    value=1<<ES_SC(_DI,EXPR_BIT_SHIFT);
    operand=GENERATE_EXPRESSION(child,1);
    _ES=EXPR_POOL_SEG;
    mask=((1<<ES_SC(_DI,EXPR_BIT_WIDTH))-1)<<ES_SC(_DI,EXPR_BIT_SHIFT);
    HIGH(temp)=HIGH(result)=0;
    LOW(temp)=NEW_CODE_NODE(0x98,0,LOW(operand),0);
    if (keep) {
        _ES=EXPR_POOL_SEG;
        if ((int)ES_W(_SI,EXPR_OP)>20) LOW(result)=NEW_CODE_NODE(0x98,0,LOW(temp),0);
    }
    _ES=EXPR_POOL_SEG;
    if (ES_W(_SI,EXPR_OP)==0x23 || ES_W(_SI,EXPR_OP)==19) op=0x1F;
    else op=0x28;
    LOW(temp)=NEW_CODE_NODE(op,0,LOW(temp),NEW_CONSTANT_NODE(10,(long)value));
    LOW(temp)=NEW_CODE_NODE(0x4B,0,LOW(temp),NEW_CONSTANT_NODE(10,(long)mask));
    operand=GENERATE_EXPRESSION(child,1);
    NEW_CODE_NODE(0x4B,2,LOW(operand),NEW_CONSTANT_NODE(10,(long)(unsigned int)~mask));
    operand=GENERATE_EXPRESSION(child,1);
    NEW_CODE_NODE(0x4D,2,LOW(operand),LOW(temp));
    if (keep) {
        _ES=EXPR_POOL_SEG;
        if ((int)ES_W(_SI,EXPR_OP)<=20) LOW(result)=LOW(temp);
        _ES=EXPR_POOL_SEG;
        _BX=ES_W(_DI,EXPR_KIND);
        if (EXPR_FLAGS[_BX]&0x20) {
            value=(1<<ES_SC(_DI,EXPR_BIT_WIDTH))-1;
            LOW(result)=NEW_SHIFT_NODE(LOW(result),0x47,(int)ES_SC(_DI,EXPR_BIT_SHIFT));
            LOW(result)=NEW_CODE_NODE(0x4B,0,LOW(result),NEW_CONSTANT_NODE(10,(long)value));
        } else {
            _ES=EXPR_POOL_SEG;
            value=16-(ES_SC(_DI,EXPR_BIT_SHIFT)+ES_SC(_DI,EXPR_BIT_WIDTH));
            LOW(result)=NEW_SHIFT_NODE(LOW(result),0x45,value);
            _ES=EXPR_POOL_SEG;
            value=16-ES_SC(_DI,EXPR_BIT_WIDTH);
            LOW(result)=NEW_SHIFT_NODE(LOW(result),0x49,value);
        }
    }
    return result;
}
#undef LOW
#undef HIGH

/* ---- NEW_SHIFT_NODE (listing ovr_1dd3_b1f8:2541) ---- */
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int, long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);

/* NEW_SHIFT_NODE: returns op 'start' shifted by shift op 'value' (0x45, 0x47 or 0x49) by
   'flag' bits, or 'start' itself when 'flag' is 0. */
unsigned int far pascal NEW_SHIFT_NODE(register unsigned int start, unsigned int value, register int flag)
{
    if (flag == 0)
        return start;
    return NEW_CODE_NODE(value, 0, start, NEW_CONSTANT_NODE(9, (long)(int)flag));
}

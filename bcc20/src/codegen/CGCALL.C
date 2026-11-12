/* target: ovr178_C208UNIT */
/* Role: calls and argument passing. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO075 (ovr_1dd7_b258) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: code ops for a function call node (GENERATE_EXPRESSION, CGEXPR.C, sends call
   nodes here through a stub). GENERATE_CALL first offers the call to
   GENERATE_INTRINSIC_CALL (INTRINS.C); otherwise it pushes the arguments, emits the call
   and the stack clean-up, and returns the result op pair (the value in AX, the high word
   or segment in DX for longs and far pointers (op 0xC3), floating results on the 8087
   stack (op 0xB3)). Arguments come as a left-leaning chain of EXPR_OP 0x2B nodes. Each
   argument is pushed as whole words (PUSH_ARGUMENT: two pushes for longs and far
   pointers, high word first; 8087 values and structs through SAVEREGS.C helpers), and the
   bytes pushed are counted. CALL_KIND_HOOK and CALL_ARG_SPLIT_HOOK describe the callee's
   type: kind 1 is a plain call whose arguments the caller removes, kind 4 an interrupt
   function (PUSHF, op 0x73, before the call); for other kinds part of the argument list,
   chosen by CALL_ARG_SPLIT_COUNT, is pushed in the opposite order and removed by the
   callee (probably the pascal convention). Code ops used: 0x94 PUSH word (0x93 for a char
   argument, widened to a word push by EMIT_INSN_OPTIMIZED), 0x77/0x78 near/far direct
   call, 0x75 near and 0x76 far indirect call, 0xAD 'ADD SP,n' after the call, 0xAE a
   no-code record of bytes the callee pops. The constant ops 6 and 5 with 0x1055 emit no
   code; 0x1055 is probably the mask of registers a call destroys. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- GENERATE_CALL (listing ovr_1dd7_b258:2580) ---- */
static unsigned int near pascal SPLIT_ARG_LIST_BY_COUNT(register unsigned int node);
static int near pascal PUSH_ARGUMENT_LIST(register unsigned int value);
static int near pascal PUSH_ARGUMENT_CHAIN(register unsigned int value);
static unsigned int near pascal EMIT_CALL_INSTRUCTION(unsigned int value);
extern unsigned int EXPR_POOL_SEG;
extern int (far pascal *CALL_KIND_HOOK)(unsigned int);
extern int (far pascal *CALL_ARG_SPLIT_HOOK)(unsigned int);
extern long far pascal GENERATE_INTRINSIC_CALL_STUB(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
#define LOW(v) (*((unsigned int near *)&(v)))
#define HIGH(v) (*(((unsigned int near *)&(v))+1))
/* GENERATE_CALL: generates call node 'input' (EXPR_LEFT the function, EXPR_RIGHT the
   argument chain) and returns its result op pair packed in a long; 'other' is passed on to
   the intrinsic generator. */
static long far pascal GENERATE_CALL(register unsigned int input,unsigned int other)
{
    int kind,count2,count1;
    unsigned int value,saved;
    long result;
    register unsigned int child;
    result=GENERATE_INTRINSIC_CALL_STUB(input,other);
    if(LOW(result)!=0) return result;
    kind=CALL_KIND_HOOK(EXPR_W(EXPR_W(input,EXPR_LEFT),EXPR_TYPE));
    CALL_ARG_SPLIT_COUNT=CALL_ARG_SPLIT_HOOK(EXPR_W(EXPR_W(input,EXPR_LEFT),EXPR_TYPE));
    count2=count1=0;
    value=EXPR_W(input,EXPR_RIGHT);
    child=0;
    NEW_CONSTANT_NODE(6,0x1055L);
    if(EXPR_W(input,EXPR_RIGHT)!=0) {
        if(kind!=1) {
            child=SPLIT_ARG_LIST_BY_COUNT(value);
            if(CALL_ARG_SPLIT_COUNT<0) {
                if(EXPR_W(child,EXPR_OP)==0x2B) {
                    saved=child;
                    child=EXPR_W(saved,EXPR_LEFT);
                    EXPR_W(saved,EXPR_LEFT)=0;
                } else child=0;
            } else value=0;
        }
        count1+=PUSH_ARGUMENT_LIST(value);
        count2+=PUSH_ARGUMENT_CHAIN(child);
    }
    LOW(result)=EMIT_CALL_INSTRUCTION(EXPR_W(input,EXPR_LEFT));
    HIGH(result)=0;
    switch(EXPR_W(input,EXPR_KIND)) {
    case TK_LONG: case TK_ULONG: case TK_FAR_PTR: case TK_HUGE_PTR:
        HIGH(result)=NEW_CONSTANT_NODE(0xC3,0L);
        break;
    case TK_FLOAT: case TK_DOUBLE: case TK_LDOUBLE:
        LOW(result)=NEW_CODE_NODE(0xB3,0,0,0);
        break;
    }
    /* count2: bytes the callee removes (only recorded); count1: bytes the caller removes. */
    if(count2) NEW_CONSTANT_NODE(0xAE,(long)count2);
    if(count1) NEW_CONSTANT_NODE(0xAD,(long)count1);
    return result;
}
#undef LOW
#undef HIGH

/* ---- SPLIT_ARG_LIST_BY_COUNT (listing ovr_1dd7_b258:26E0) ---- */
extern unsigned int EXPR_POOL_SEG;

/* SPLIT_ARG_LIST_BY_COUNT: walks down the left spine of argument chain 'node', counting
   CALL_ARG_SPLIT_COUNT down once per argument from the innermost one outwards, and
   returns the chain node where the count runs out (or the innermost result once it is
   negative); GENERATE_CALL splits the list there. */
static unsigned int near pascal SPLIT_ARG_LIST_BY_COUNT(register unsigned int node)
{
    unsigned int result;

    if (*(unsigned int far *)MK_FP(EXPR_POOL_SEG, node) == 43) {
        result = SPLIT_ARG_LIST_BY_COUNT(((unsigned int far *)MK_FP(EXPR_POOL_SEG, node))[5]);
        if (CALL_ARG_SPLIT_COUNT >= 0) {
            CALL_ARG_SPLIT_COUNT--;
            return node;
        }
        return result;
    }
    CALL_ARG_SPLIT_COUNT--;
    return node;
}

/* ---- PUSH_ARGUMENT_LIST (listing ovr_1dd7_b258:271A) ---- */
static unsigned int near pascal ARGUMENT_STACK_SIZE(register unsigned int node);
static void near pascal PUSH_ARGUMENT(register unsigned int value);
extern unsigned int EXPR_POOL_SEG;

/* PUSH_ARGUMENT_LIST: pushes the arguments of chain 'value' right operand first (the last
   argument first, as C wants) and returns the number of bytes pushed, each argument
   rounded up to whole words. */
static int near pascal PUSH_ARGUMENT_LIST(register unsigned int value)
{
    register unsigned int total;
    if(!value)
        return 0;
    if(*(unsigned int far *)MK_FP(EXPR_POOL_SEG,value)==0x2B) {
        total=PUSH_ARGUMENT_LIST(*(unsigned int far *)MK_FP(EXPR_POOL_SEG,value+EXPR_RIGHT));
        total+=PUSH_ARGUMENT_LIST(*(unsigned int far *)MK_FP(EXPR_POOL_SEG,value+EXPR_LEFT));
    } else {
        total=ARGUMENT_STACK_SIZE(value);
        PUSH_ARGUMENT(value);
        if(total&1)
            ++total;
    }
    return total;
}

/* ---- PUSH_ARGUMENT_CHAIN (listing ovr_1dd7_b258:2767) ---- */
extern unsigned int EXPR_POOL_SEG;

/* PUSH_ARGUMENT_CHAIN: the same in the opposite order (left operand first); arguments
   whose EXPR_NODE_FLAGS2 byte is set are skipped. */
static int near pascal PUSH_ARGUMENT_CHAIN(register unsigned int value)
{
    unsigned int result;

    if (!value)
        return 0;
    if (*((unsigned int far *)MK_FP(EXPR_POOL_SEG, value)) == 0x2B) {
        result = PUSH_ARGUMENT_CHAIN(*((unsigned int far *)MK_FP(EXPR_POOL_SEG, value + EXPR_LEFT)));
        result += PUSH_ARGUMENT_CHAIN(*((unsigned int far *)MK_FP(EXPR_POOL_SEG, value + EXPR_RIGHT)));
        return result;
    }
    if (*((unsigned char far *)MK_FP(EXPR_POOL_SEG, value + EXPR_NODE_FLAGS2)) != 0)
        return 0;
    result = ARGUMENT_STACK_SIZE(value);
    PUSH_ARGUMENT(value);
    if (result & 1)
        result++;
    return result;
}

/* ---- EMIT_CALL_INSTRUCTION (listing ovr_1dd7_b258:27C3) ---- */
extern unsigned int EXPR_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern int (far pascal *CALL_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *FLAG_HOOK)(unsigned int);
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])
/* EMIT_CALL_INSTRUCTION: emits the call itself for function expression 'value' and
   returns the call op. A call through a pointer (EXPR_OP 0x31): a near pointer to a far
   function gets PUSH CS and a near indirect call; a far pointer gets op 0x76, and a
   pointer held in a variable is forced to memory (VAR_FLAGS 4). A direct call names the
   function symbol in a near or far call op (FLAG_HOOK bit 1: far function). */
static unsigned int near pascal EMIT_CALL_INSTRUCTION(unsigned int value)
{
    unsigned int result;
    unsigned long operand;
    unsigned int size,flag,node;
    _SI=value;
    _ES=EXPR_POOL_SEG;
    size=CALL_KIND_HOOK(ES_W(_SI,EXPR_TYPE));
    _ES=EXPR_POOL_SEG;
    flag=FLAG_HOOK(ES_W(_SI,EXPR_TYPE))&1;
    _ES=EXPR_POOL_SEG;
    if (ES_W(_SI,EXPR_OP)==0x31) {
        _SI=ES_W(_SI,EXPR_LEFT);
        NEW_CONSTANT_NODE(5,0x1055L);
        operand=GENERATE_EXPRESSION(_SI,1);
        if (size==4) NEW_CODE_NODE(0x73,0,0,0);
        _ES=EXPR_POOL_SEG;
        if (ES_W(_SI,EXPR_KIND)==13) {
            if (flag) NEW_CODE_NODE(0x94,0,NEW_CODE_NODE(8,0,14,0),0);
            result=NEW_CODE_NODE(0x75,0,LOW(operand),0);
        } else if (!flag) {
            result=NEW_CODE_NODE(0x75,0,LOW(operand),0);
        } else {
            _DI=LOW(operand)<<2;
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_DI,COP_OPCODE)==16 || ES_B(_DI,COP_OPCODE)==17) {
                _ES=CODE_OPERAND_POOL_SEG;
                node=ES_W(_DI,OPND_LEFT);
                _BX=node;
                _ES=VARIABLE_TABLE_SEG;
                ES_B(_BX,VAR_FLAGS)|=4;
            }
            result=NEW_CODE_NODE(0x76,0,LOW(operand),HIGH(operand));
            /* Keep the result in its local slot at the common return. */
            _SI=_SI;
        }
    } else {
        if (size==4) NEW_CODE_NODE(0x73,0,0,0);
        result=NEW_VARIABLE_NODE(flag?0x78:0x77,(_ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_LEFT)),0x1055,ES_B(_SI,EXPR_QUAL_FLAGS));
    }
    return result;
}
#undef LOW
#undef HIGH

/* ---- ARGUMENT_STACK_SIZE (listing ovr_1dd7_b258:292B) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);

/* ARGUMENT_STACK_SIZE: size of argument 'node''s type (word 4 is EXPR_TYPE), rounded up
   to an even number of bytes. */
static unsigned int near pascal ARGUMENT_STACK_SIZE(register unsigned int node)
{
    return (SIZE_OF_TYPE_CHECKED_HOOK(((unsigned int far *)MK_FP(EXPR_POOL_SEG,node))[4]) + 1) & 0xFFFE;
}

/* ---- PUSH_ARGUMENT (listing ovr_1dd7_b258:2949) ---- */
static void near pascal PUSH_ADDRESS_ARGUMENT(register unsigned int input);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *GET_TYPE_FLAGS_ALT_HOOK)(unsigned int);
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
extern signed char far pascal SEGMENT_REGISTER_CODE(unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern void far pascal PUSH_FLOAT_ARGUMENT(unsigned int);
extern int far pascal PUSH_STRUCT_VALUE(unsigned int);
#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])
/* PUSH_ARGUMENT: generates argument 'value' and pushes it. Special cases for 32-bit
   values: '&x' as a far pointer pushes segment and offset of x without computing it
   (PUSH_ADDRESS_ARGUMENT); op 45 (0x2D, probably a segment:offset pair) pushes both parts;
   a near pointer cast to far (op 53 = 0x35, a cast) pushes the segment register its type
   implies, then the offset; a _seg value cast to far pushes it and offset 0. A struct
   argument that PUSH_STRUCT_VALUE reports as fitting a scalar is pushed again as that
   scalar. Taking the address of a floating object sets CODE_OUTPUT_FLAGS bit 2 (probably
   'floating point used'). */
static void near pascal PUSH_ARGUMENT(register unsigned int value)
{
    signed char reg;
    unsigned long operand;
    if (EXPR_W(value,EXPR_OP)==EOP_ADDR) {
        if (EXPR_FLAGS[EXPR_W(EXPR_W(value,EXPR_LEFT),EXPR_KIND)]&2) CODE_OUTPUT_FLAGS|=2;
    }
again:
    switch(EXPR_W(value,EXPR_KIND)) {
    case TK_FAR_PTR: case TK_HUGE_PTR:
        if (EXPR_W(value,EXPR_OP)==EOP_ADDR) {
            PUSH_ADDRESS_ARGUMENT(EXPR_W(value,EXPR_LEFT));
            break;
        }
        if (EXPR_W(value,EXPR_OP)==45) {
            PUSH_ARGUMENT(EXPR_W(value,EXPR_LEFT));
            PUSH_ARGUMENT(EXPR_W(value,EXPR_RIGHT));
            break;
        }
    case TK_LONG: case TK_ULONG:
        if (EXPR_W(value,EXPR_OP)==53 && EXPR_W(EXPR_W(value,EXPR_LEFT),EXPR_KIND)==TK_NEAR_PTR) {
            value=EXPR_W(value,EXPR_LEFT);
            reg=SEGMENT_REGISTER_CODE(GET_TYPE_FLAGS_ALT_HOOK(EXPR_W(value,EXPR_TYPE)));
            NEW_CODE_NODE(0x94,0,NEW_CODE_NODE(8,0,(int)reg,0),0);
            operand=GENERATE_EXPRESSION(value,1);
            NEW_CODE_NODE(0x94,0,LOW(operand),0);
        } else if (EXPR_W(value,EXPR_OP)==53 && EXPR_W(EXPR_W(value,EXPR_LEFT),EXPR_KIND)==TK_SEG_PTR) {
            operand=GENERATE_EXPRESSION(EXPR_W(value,EXPR_LEFT),1);
            NEW_CODE_NODE(0x94,0,LOW(operand),0);
            LOW(operand)=NEW_CONSTANT_NODE(10,0L);
            NEW_CODE_NODE(0x94,0,LOW(operand),0);
        } else {
            operand=GENERATE_EXPRESSION(value,1);
            NEW_CODE_NODE(0x94,0,HIGH(operand),0);
            NEW_CODE_NODE(0x94,0,LOW(operand),0);
        }
        break;
    case TK_SHORT: case TK_USHORT: case TK_INT: case TK_UINT: case TK_NEAR_PTR: case TK_SEG_PTR:
        operand=GENERATE_EXPRESSION(value,1);
        NEW_CODE_NODE(0x94,0,LOW(operand),0);
        break;
    case TK_CHAR: case TK_UCHAR:
        operand=GENERATE_EXPRESSION(value,1);
        NEW_CODE_NODE(0x93,0,LOW(operand),0);
        break;
    case TK_FLOAT: case TK_DOUBLE: case TK_LDOUBLE:
        PUSH_FLOAT_ARGUMENT(value);
        break;
    case TK_STRUCT: case TK_UNION:
        if (PUSH_STRUCT_VALUE(value)) goto again;
        break;
    }
}
#undef LOW
#undef HIGH

/* ---- PUSH_ADDRESS_ARGUMENT (listing ovr_1dd7_b258:2B55) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
/* PUSH_ADDRESS_ARGUMENT: pushes the far address of object 'input': for a global symbol
   (op 1) its segment (op 12) and offset (op 13); for others SS (register 15) and the
   offset: of the object (op 13), or for expression op 7 the parameter-area address
   (op 14, probably the address of the variable arguments). */
static void near pascal PUSH_ADDRESS_ARGUMENT(register unsigned int input)
{
    register unsigned int result;
    if(EXPR_W(input,EXPR_OP)==1) {
        result=NEW_VARIABLE_NODE(12,EXPR_W(input,EXPR_LEFT),0,EXPR_B(input,EXPR_QUAL_FLAGS));
        NEW_CODE_NODE(0x94,0,result,0);
        result=NEW_VARIABLE_NODE(13,EXPR_W(input,EXPR_LEFT),EXPR_W(input,EXPR_RIGHT),EXPR_B(input,EXPR_QUAL_FLAGS));
    } else {
        if(EXPR_W(input,EXPR_OP)==7) {
            NEW_CODE_NODE(0x94,0,NEW_CODE_NODE(8,0,15,0),0);
            result=NEW_CONSTANT_NODE(14,0L);
        } else {
            NEW_CODE_NODE(0x94,0,NEW_CODE_NODE(8,0,15,0),0);
            result=NEW_VARIABLE_NODE(13,EXPR_W(input,EXPR_LEFT),EXPR_W(input,EXPR_RIGHT),EXPR_B(input,EXPR_QUAL_FLAGS));
        }
    }
    NEW_CODE_NODE(0x94,0,result,0);
}

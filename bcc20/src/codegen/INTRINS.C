/* target: ovr181_C214UNIT */
/* Role: intrinsic calls, __emit__. Entry points: CHECK_EMIT_ARGUMENTS. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO078 (ovr_1dea_b42c) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: inline code for calls of intrinsic functions (symbols of kind 10, numbered by
   SYMBOL_INDEX_HOOK) and for __emit__. GENERATE_INTRINSIC_CALL checks the call against
   the intrinsic's INTRINSIC_TABLE entry (result kind, argument count and argument kinds;
   arguments arrive as a left-leaning chain of EXPR_OP 0x2B nodes), generates the
   arguments in register-need order and builds the code ops for the intrinsic. Intrinsic
   numbers seen here: 0 interrupt call (INT n for a constant n below 256, otherwise PUSHF
   and a far call through the vector at 0:n*4), 1 probably abs (sign word by CWD, XOR,
   SUB), 2 to 5 single string-instruction ops (0x6E, 0x70, 0x6F, 0x71; probably the
   string and memory intrinsics), 6 __emit__, whose arguments become raw bytes in the code
   (code ops 0x7A byte and 0x79 word, emitted by EMIT_BLOCK_INSTRUCTIONS).
   CHECK_EMIT_ARGUMENTS is the front end's check of __emit__ arguments, called before any
   code is made. Any mismatch is MSG_BAD_CALL_INTRINSIC, a fatal error. */
#include <dos.h>
#include <stdlib.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- GENERATE_ARGUMENTS_BY_WEIGHT (listing ovr_1dea_b42c:42C0) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
#define SCORE(n) (*((signed char far *)MK_FP(EXPR_POOL_SEG,(n)+6)))
#define LOW(v) (((volatile unsigned int far *)&(v))[0])
#define HIGH(v) (((volatile unsigned int far *)&(v))[1])
/* GENERATE_ARGUMENTS_BY_WEIGHT: generates the 'count' argument expressions in 'nodes',
   the one with the largest register need first (SCORE is the EXPR_NODE_FLAGS byte that
   LABEL_REGISTER_NEED filled; its sign is dropped here), storing each result op pair in
   'results' at the argument's own index. */
static void near pascal GENERATE_ARGUMENTS_BY_WEIGHT(int count,unsigned int far *nodes,unsigned long far *results)
{
    unsigned int best;
    register int i,score;
    for(i=0;(int)i<count;++i) {
        LOW(results[i])=HIGH(results[i])=0;
        SCORE(nodes[i])=abs((int)SCORE(nodes[i]));
    }
    for(;;) {
        score=-1;
        for(i=0;(int)i<count;++i) {
            if(LOW(results[i])==0 && (int)SCORE(nodes[i])>(int)score) {
                score=(int)SCORE(nodes[i]);
                best=i;
            }
        }
        if((int)score<0) break;
        results[best]=GENERATE_EXPRESSION(nodes[best],1);
    }
}
#undef SCORE
#undef LOW
#undef HIGH

/* ---- GENERATE_INTRINSIC_CALL (listing ovr_1dea_b42c:43B2) ---- */
static void near pascal EMIT_INLINE_ARGUMENTS(unsigned int value);
struct Node {unsigned int kind,type,padding[3],left,right;};
struct Builtin {unsigned char prefix[2];signed char result;unsigned char byte3;signed char count; signed char types[5];};
extern unsigned int EXPR_POOL_SEG;
extern unsigned char KIND_INFO_TABLE[];
extern struct Builtin INTRINSIC_TABLE[];
extern int (far pascal *GET_SYMBOL_KIND_HOOK)(unsigned int);
extern int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
#define NODE(r) ((struct Node far *)MK_FP(EXPR_POOL_SEG,(r)))
#define LOW(v) (*((unsigned int near *)&(v)))
#define HIGH(v) (*(((unsigned int near *)&(v))+1))
/* GENERATE_INTRINSIC_CALL: generates call node 'input' when it calls an intrinsic; returns
   the result op pair (0 when the callee is not an intrinsic, so the caller makes a normal
   call). The argument nodes are collected into args[] from the last to the first. */
static long far pascal GENERATE_INTRINSIC_CALL(unsigned int input,unsigned int unused)
{
    unsigned int head,args[4];
    int count,flag;
    unsigned int symbol;
    struct Builtin far *description;
    long result,temp;
    unsigned int value1,value2,value3;
    unsigned long values[4];
    register unsigned int cursor;
    register int index;
    LOW(result)=HIGH(result)=0;
    if(EXPR_W(EXPR_W(input,EXPR_LEFT),EXPR_OP)!=1) return result;
    head=EXPR_W(input,EXPR_LEFT);
    symbol=EXPR_W(head,EXPR_LEFT);
    if(GET_SYMBOL_KIND_HOOK(symbol)!=10) return result;
    description=&INTRINSIC_TABLE[SYMBOL_INDEX_HOOK(symbol)];
    cursor=EXPR_W(input,EXPR_RIGHT);
    count=description->count;
    if(KIND_INFO_TABLE[EXPR_W(input,EXPR_KIND)*4]!=KIND_INFO_TABLE[description->result*4]) {
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        return result;
    }
    if(cursor!=0 && count>=0) {
        index=count;
        while(NODE(cursor)->kind==0x2B) {
            if(index<=0 || NODE(NODE(cursor)->right)->type!=description->types[index]) {
                REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
                return result;
            }
            ((unsigned int _ss *)args)[index-1]=NODE(cursor)->right;
            index--;
            cursor=NODE(cursor)->left;
        }
        if(index!=1 || NODE(cursor)->type!=description->types[1]) {
            REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
            return result;
        }
        args[0]=cursor;
    } else if(count>0) {
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        return result;
    }
    flag=0;
    GENERATE_ARGUMENTS_BY_WEIGHT(count,args,values);
    switch(SYMBOL_INDEX_HOOK(symbol)) {
    case 1:
        temp=values[0];
        LOW(temp)=NEW_CODE_NODE(0xAC,0,LOW(temp),0);
        HIGH(temp)=NEW_CODE_NODE(8,0,2,0);
        LOW(temp)=NEW_CODE_NODE(0x4F,0,LOW(temp),HIGH(temp));
        LOW(result)=NEW_CODE_NODE(0x28,0,LOW(temp),HIGH(temp));
        break;
    case 2:
        LOW(result)=NEW_CODE_NODE(0x6E,0,LOW(values[0]),LOW(values[1]));
        break;
    case 3:
        NEW_CODE_NODE(0x70,0,NEW_CODE_NODE(8,0,0,0),LOW(values[0]));
        LOW(result)=NEW_CONSTANT_NODE(0xC2,0L);
        break;
    case 4:
        LOW(result)=NEW_CODE_NODE(0x6F,0,LOW(values[0]),LOW(values[1]));
        break;
    case 5:
        NEW_CODE_NODE(0x71,0,NEW_CODE_NODE(8,0,0,0),LOW(values[0]));
        LOW(result)=NEW_CONSTANT_NODE(0xC2,0L);
        break;
    case 0:
        if(EXPR_W(args[0],EXPR_OP)==EOP_CONST) {
            if(EXPR_W(args[0],EXPR_LEFT)>255) {
                REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
                return result;
            }
            LOW(result)=NEW_CONSTANT_NODE(0x72,(long)(EXPR_W(args[0],EXPR_LEFT)&255));
        } else {
            temp=values[0];
            value1=NEW_CODE_NODE(0x45,0,LOW(temp),NEW_CONSTANT_NODE(9,1L));
            value1=NEW_CODE_NODE(0x45,0,value1,NEW_CONSTANT_NODE(9,1L));
            NEW_CODE_NODE(0x73,0,0,0);
            NEW_CODE_NODE(0xA6,0,0,0);
            value3=NEW_CONSTANT_NODE(10,0L);
            value2=NEW_CODE_NODE(0x1B,0,value1,value3);
            value1=NEW_CODE_NODE(0x16,0,value1,value3);
            LOW(result)=NEW_CODE_NODE(0x76,0,value1,value2);
        }
        break;
    case 6:
        EMIT_INLINE_ARGUMENTS(cursor);
        LOW(result)=1;
        break;
    default:
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
    }
    /* 'flag' is never set above, so this POP DS (0x7F of register 13) is never generated. A
       far pointer result (kind 15) takes its high word from op 0xC7. */
    if(flag) NEW_CODE_NODE(0x7F,0,NEW_CODE_NODE(8,0,13,0),0);
    if(description->result==15) HIGH(result)=NEW_CONSTANT_NODE(0xC7,0L);
    return result;
}
#undef NODE
#undef LOW
#undef HIGH

/* ---- EMIT_INLINE_ARGUMENTS (listing ovr_1dea_b42c:47A7) ---- */
extern unsigned int EXPR_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal ASSIGN_LOCAL_OFFSETS(unsigned int,int,unsigned int);
extern void far pascal ASSIGN_PARAM_OFFSETS(void);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,long);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
/* EMIT_INLINE_ARGUMENTS: turns the __emit__ argument list 'value' (0x2B chain, handled
   left to right by recursion) into raw-byte code ops. An int or short constant from 0 to
   255 counts as a byte. Accepted: '&auto' or '&parameter' (EXPR_OP 50 = 0x32 over op 5
   or 6), which forces frame offsets to be assigned now and emits the variable's frame
   offset as one byte; the address of a global as its offset (0x7C), segment (0x7B) or
   both, by pointer kind; constants as a byte, a word, or two words for longs and far
   pointers. */
static void near pascal EMIT_INLINE_ARGUMENTS(unsigned int value)
{
    unsigned char type;
    unsigned int node;
    _SI=value;
    _ES=EXPR_POOL_SEG;
    if(ES_W(_SI,EXPR_OP)==0x2B) {
        EMIT_INLINE_ARGUMENTS(ES_W(_SI,EXPR_LEFT));
        _ES=EXPR_POOL_SEG;
        _SI=ES_W(_SI,EXPR_RIGHT);
    }
    _ES=EXPR_POOL_SEG;
    if((ES_W(_SI,EXPR_KIND)==3 || ES_W(_SI,EXPR_KIND)==5) &&
       *((unsigned int far *)MK_FP(EXPR_POOL_SEG,_SI))==2 &&
       ES_L(_SI,EXPR_LEFT)>=0L && *((long far *)MK_FP(EXPR_POOL_SEG,_SI+EXPR_LEFT))<=255L) type=1;
    else { _ES=EXPR_POOL_SEG;type=ES_B(_SI,EXPR_KIND); }
    _ES=EXPR_POOL_SEG;
    switch(ES_W(_SI,EXPR_OP)) {
    case 50:
        _ES=EXPR_POOL_SEG;
        _DI=ES_W(_SI,EXPR_LEFT);
        if(ES_W(_DI,EXPR_OP)==5 || ES_W(_DI,EXPR_OP)==6) {
            _ES=EXPR_POOL_SEG;
            node=FIND_OR_ADD_VARIABLE(ES_W(_DI,EXPR_LEFT),ES_B(_DI,EXPR_KIND),ES_B(_DI,EXPR_QUAL_FLAGS));
            _BX=node;
            _ES=VARIABLE_TABLE_SEG;
            ++ES_W(_BX,VAR_USE_COUNT);
            if(ES_B(_BX,VAR_SYMBOL_KIND)!=6) ASSIGN_LOCAL_OFFSETS(FUNCTION_OUTER_SCOPE_BLOCK,-FRAME_LOCALS_SIZE,0);
            else if(FUNCTION_OUTER_SCOPE_BLOCK) {FRAME_HEADER_SIZE=2;ASSIGN_PARAM_OFFSETS();}
            _BX=node;
            _ES=VARIABLE_TABLE_SEG;
            ES_B(_BX,VAR_FLAGS)=4;
            NEW_CONSTANT_NODE(0x7A,(long)ES_W(_BX,VAR_FRAME_OFFSET));
            goto done;
        }
        switch(type) {
        case 13:
            NEW_VARIABLE_NODE(0x7C,(_ES=EXPR_POOL_SEG,ES_W(_DI,EXPR_LEFT)),ES_W(_DI,EXPR_RIGHT),ES_B(_DI,EXPR_QUAL_FLAGS));
            break;
        case 14:
            NEW_VARIABLE_NODE(0x7B,(_ES=EXPR_POOL_SEG,ES_W(_DI,EXPR_LEFT)),0,ES_B(_DI,EXPR_QUAL_FLAGS));
            break;
        case 15: case 16:
            NEW_VARIABLE_NODE(0x7C,(_ES=EXPR_POOL_SEG,ES_W(_DI,EXPR_LEFT)),ES_W(_DI,EXPR_RIGHT),ES_B(_DI,EXPR_QUAL_FLAGS));
            NEW_VARIABLE_NODE(0x7B,(_ES=EXPR_POOL_SEG,ES_W(_DI,EXPR_LEFT)),0,ES_B(_DI,EXPR_QUAL_FLAGS));
            break;
        default:
            REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
            /* Keep this warning separate from the outer default. */
            _SI=_SI;
        }
        break;
    case 2:
        switch(type) {
        case 1: case 2:
            NEW_CONSTANT_NODE(0x7A,(long)((_ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_LEFT))&0xFF));
            goto done;
        default:
            NEW_CONSTANT_NODE(0x79,(long)((_ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_LEFT))&0xFFFF));
            goto done;
        /* As written, this 'break' leaves only the inner switch, so a long or far constant falls
           into the outer default and also reports MSG_BAD_CALL_INTRINSIC after its two words. */
        case 7: case 8: case 15: case 16:
            NEW_CONSTANT_NODE(0x79,(long)((_ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_LEFT))&0xFFFF));
            NEW_CONSTANT_NODE(0x79,(long)(int)( _ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_RIGHT)));
            break;
        }
    default:
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
    }
done:
    ;
}

/* ---- CHECK_EMIT_ARGUMENTS (listing ovr_1dea_b42c:49FD) ---- */
static void near pascal CHECK_EMIT_ARGUMENT_LIST(register unsigned int value);

/* CHECK_EMIT_ARGUMENTS: for intrinsic number 'kind' 6 (__emit__) checks the argument list
   'value': at least one argument, and each a constant or an address, possibly cast. */
void far pascal CHECK_EMIT_ARGUMENTS(unsigned int kind, unsigned int value)
{
    if (kind == 6) {
        if (value == 0)
            REPORT_ERROR(MSG_TOO_FEW_PARAMETERS_46, (char far *)STR_EMIT);
        CHECK_EMIT_ARGUMENT_LIST(value);
    }
}

/* ---- CHECK_EMIT_ARGUMENT_LIST (listing ovr_1dea_b42c:4A28) ---- */
extern unsigned int EXPR_POOL_SEG;

/* CHECK_EMIT_ARGUMENT_LIST: checks each argument of the 0x2B chain 'value': constants
   (EXPR_OP 2, 3) and addresses (0x32) pass, casts (0x35) are looked through. Note that
   after MSG_ILLEGAL_PARAMETER_EMIT the loop runs again on the same node, so it repeats
   the error until the error limit (-j) stops the compile; with no limit it would not end. */
static void near pascal CHECK_EMIT_ARGUMENT_LIST(register unsigned int value)
{
    if (*((unsigned int far *)MK_FP(EXPR_POOL_SEG, value)) == 0x2B) {
        CHECK_EMIT_ARGUMENT_LIST(*((unsigned int far *)MK_FP(EXPR_POOL_SEG, value + EXPR_LEFT)));
        value = *((unsigned int far *)MK_FP(EXPR_POOL_SEG, value + EXPR_RIGHT));
    }
    for (;;) {
        switch (*((int far *)MK_FP(EXPR_POOL_SEG, value))) {
        case 0x32:
        case 2:
        case 3:
            return;
        case 0x35:
            value = *((unsigned int far *)MK_FP(EXPR_POOL_SEG, value + EXPR_LEFT));
            break;
        default:
            REPORT_ERROR(MSG_ILLEGAL_PARAMETER_EMIT);
            break;
        }
    }
}

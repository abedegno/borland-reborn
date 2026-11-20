/* target: ovr148_C203UNIT */
/* Role: x86 code generation: expression generator. Entry points: GENERATE_EXPRESSION,
   EMIT_RETURN_VALUE, EMIT_TEST_ZERO, SEGMENT_REGISTER_CODE, EMIT_COMPARE, EMIT_STACK_CHECK,
   PUSH_STRUCT_VALUE, GENERATE_STRUCT_ASSIGN (+3 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO059 (ovr_1d5e_a195) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the entry to expression code generation. GENERATE_EXPRESSION turns an
   analysed expression tree (EXPR_POOL_SEG nodes, after LABEL_REGISTER_NEED has filled
   the register-need byte) into code ops for the current flow block and returns the
   result as an op pair packed in a long (low word: the op holding the value or its low
   word; high word: the op holding the high word or segment, 0 if none). It handles the
   shapes that need special code itself (comma lists, dereferences, struct and bit-field
   assignment, address-of, x++/x--, long division and shifts, comparisons and ?: as
   values, calls) and sends everything else to GENERATE_OPERATOR (CGOPER.C). 'mode' 0
   means the value is not needed (expression statement), 1 that it is.
   The file also has the condition code used by FLOWBLK.C's EMIT_COND_JUMP_*:
   EMIT_COMPARE (a comparison that ends the current block with a conditional jump, long
   comparisons split over several blocks) and EMIT_TEST_ZERO; the function-entry stack
   check; struct pushes and copies through run-time helpers (EMIT_HELPER_CALL makes the
   helper's name from a model prefix and declares it); and loads through pointers.
   Jump kinds set here (CNODE_JUMP_KIND), from COMPARE_OP_TO_JUMP's tables and
   FLAGS_BIT_TEST_JUMP_KIND: 1 always, 3 signed greater, 5 unsigned above, 0x0A equal,
   0x0B not equal, 12-19 jump on a CPU flag (carry, overflow, sign, parity; even set,
   odd clear), probably. Probable op meanings: 0x80/0x81 CMP byte/word, 0x85/0x86 TEST
   byte/word, 0x4D OR word, 0xB5/0xB6 load DX:AX / CX:BX, 0xB4 a value for the 8087,
   0xBE a far address for a helper, 0xC2/0xC3 a helper's result in AX/DX. Several
   functions were compiled without -O or without register variables (#pragma lines) and
   return their long result by loading _DX/_AX and falling off the end; these shapes are
   kept for byte matching. */
#include <dos.h>
#include "EMIT045.H"
#include <stdlib.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STAOV045 (listing ovr_1d5e_a195:1950) ---- */
unsigned long far pascal GENERATE_STRUCT_ASSIGN(unsigned int node, unsigned int mode);
static void near pascal NARROW_STRUCT_TO_SCALAR(register unsigned int node);
void far pascal EMIT_OPERATOR_HELPER(unsigned int value);
static unsigned long near pascal GENERATE_DEREF_OF_ADDRESS(unsigned int first, unsigned int node, unsigned int amount);
static unsigned long near pascal GENERATE_POST_DECREMENT(unsigned int node);
static unsigned long near pascal GENERATE_POST_INCREMENT(unsigned int node);
static unsigned long near pascal GENERATE_ADDRESS_OF(unsigned int node, unsigned char mode);
static unsigned long near pascal GENERATE_INDIRECT_LOAD(unsigned int node, unsigned int high, unsigned int low);
static unsigned long near pascal GEN_DEREF_FAR_ADD_ASSIGN(unsigned int node);
/* GENERATE_EXPRESSION (below) owns its 88-byte compiler switch table. */

/* GENERATE_EXPRESSION: generates expression 'input' (see the overview); stops with
   MSG_OUT_MEMORY when the stack runs low (the generator is deeply recursive). Small
   structs (up to 4 bytes) are handled as integers and enums as int. Compound assignments
   to register pseudo-variables or awkward targets are first rewritten by
   EXPAND_COMPOUND_ASSIGN_HOOK into 'x = x op y'. */
unsigned long far pascal GENERATE_EXPRESSION(unsigned int input,unsigned int mode)
{
    unsigned int operation;
    EmissionPair result;
    EmissionPair temporary_pair;
    unsigned int temporary;
    EmissionPair left_pair;
    EmissionPair right_pair;
    unsigned int first_expression;
    unsigned char expression_kind;
    unsigned int second_expression;
    unsigned int join_label;
    unsigned int alternate_label;
    register unsigned int node=input;
    register unsigned int item;

    if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    result.words.low=result.words.high=0;
    if(EXPR_W(node,EXPR_KIND)==TK_UNDEFINED) return result.value;
    if((EXPR_W(node,EXPR_KIND)==TK_STRUCT || EXPR_W(node,EXPR_KIND)==TK_UNION) && SIZE_OF_TYPE_CHECKED_HOOK(EXPR_W(node,EXPR_TYPE))<=4)
        NARROW_STRUCT_TO_SCALAR(node);
    else if(EXPR_W(node,EXPR_KIND)==TK_ENUM) EXPR_W(node,EXPR_KIND)=TK_INT;
    if((int)EXPR_W(node,EXPR_OP)>=EOP_ADD_ASSIGN && (int)EXPR_W(node,EXPR_OP)<=EOP_XOR_ASSIGN) {
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==4) {
            item=SYMBOL_INDEX_HOOK(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT));
            if((item>=0x0C && item<=0x0F) || item==0xFFFF)
                node=EXPAND_COMPOUND_ASSIGN_HOOK(node);
        } else if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0x33)
            return GENERATE_BITFIELD_OP_ASSIGN(node,mode);
    }
    switch(EXPR_W(node,EXPR_OP)) {
    case 0x35: /* 1A32 */
        if(EXPR_W(node,EXPR_KIND)==TK_VOID) return GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),mode);
        break;
    case 0x33: /* 1A4E */
        return GENERATE_BITFIELD_LOAD(node);
    case 0x29: /* 1A57 */
        EXPR_SC(node,EXPR_NODE_FLAGS)=-1;
        break;
    /* Comma list: the left-leaning chain of comma nodes is reversed in place so the left-most
       expression is generated first, each for its side effects; the last one gives the value. */
    case EOP_COMMA: /* 1A63 */
        EXPR_SC(node,EXPR_NODE_FLAGS)=-1;
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==EOP_COMMA) {
        item=EXPR_W(node,EXPR_LEFT);
        temporary=node;
        left_pair.words.high=node;
        for(;;) {
            left_pair.words.low=EXPR_W(item,EXPR_LEFT);
            {
                register unsigned int old_right=EXPR_W(item,EXPR_RIGHT);
                EXPR_W(item,EXPR_RIGHT)=left_pair.words.high;
                EXPR_W(item,EXPR_LEFT)=old_right;
            }
            left_pair.words.high=item;
            if(!left_pair.words.low || EXPR_W(left_pair.words.low,EXPR_OP)!=EOP_COMMA) break;
            item=left_pair.words.low;
        }
        GENERATE_EXPRESSION(left_pair.words.low,1);
        node=left_pair.words.high;
        do {
            EXPR_SC(node,EXPR_NODE_FLAGS)=-1;
            GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
            right_pair.words.high=EXPR_W(node,EXPR_RIGHT);
            EXPR_W(node,EXPR_RIGHT)=EXPR_W(node,EXPR_LEFT);
            EXPR_W(node,EXPR_LEFT)=left_pair.words.low;
            left_pair.words.low=node;
            node=right_pair.words.high;
        } while(node!=temporary);
        EXPR_SC(node,EXPR_NODE_FLAGS)=-1;
        return GENERATE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),1);
        }
        break;
    case EOP_DEREF: /* 1B14 */
        item=EXPR_W(node,EXPR_LEFT);
        if(EXPR_W(item,EXPR_KIND)==TK_SEG_PTR) {
            temporary_pair.value=GENERATE_EXPRESSION(item,1);
            temporary_pair.words.high=temporary_pair.words.low;
            temporary_pair.words.low=NEW_CONSTANT_NODE(0x0A,0UL);
            return GENERATE_INDIRECT_LOAD(node,temporary_pair.words.high,temporary_pair.words.low);
        }
        if(EXPR_W(item,EXPR_OP)==EOP_ADDR) return GENERATE_DEREF_OF_ADDRESS(node,EXPR_W(item,EXPR_LEFT),0);
        if(EXPR_W(item,EXPR_OP)==EOP_ADD && EXPR_W(EXPR_W(item,EXPR_LEFT),EXPR_OP)==EOP_ADDR && EXPR_W(EXPR_W(item,EXPR_RIGHT),EXPR_OP)==EOP_CONST)
            return GENERATE_DEREF_OF_ADDRESS(node,EXPR_W(EXPR_W(item,EXPR_LEFT),EXPR_LEFT),EXPR_W(EXPR_W(item,EXPR_RIGHT),EXPR_LEFT));
        temporary_pair.value=GEN_DEREF_FAR_ADD_ASSIGN(item);
        if(!temporary_pair.words.low) temporary_pair.value=GENERATE_EXPRESSION(item,1);
        return GENERATE_INDIRECT_LOAD(node,temporary_pair.words.high,temporary_pair.words.low);
    /* Assignment: structs through GENERATE_STRUCT_ASSIGN, bit-fields through
       GENERATE_BITFIELD_STORE; a floating assignment drops a cast between floating kinds on
       its right side; assigning to _FLAGS (register pseudo-variable 0xFFFF) pushes the value
       and pops it into the flags (op 0x74). */
    case EOP_ASSIGN: /* 1BCD */
        item=EXPR_W(node,EXPR_LEFT);
        if(EXPR_W(node,EXPR_KIND)==TK_UNION || EXPR_W(node,EXPR_KIND)==TK_STRUCT) return GENERATE_STRUCT_ASSIGN(node,mode);
        if(EXPR_W(item,EXPR_OP)==0x33) return GENERATE_BITFIELD_STORE(item,EXPR_W(node,EXPR_RIGHT),mode);
        if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&2) {
            register unsigned int right=EXPR_W(node,EXPR_RIGHT);
            if(EXPR_W(right,EXPR_OP)==0x35) {
                register unsigned int child=EXPR_W(right,EXPR_LEFT);
                if(EXPR_FLAGS[EXPR_W(child,EXPR_KIND)]&2) EXPR_W(node,EXPR_RIGHT)=child;
            }
            break;
        }
        if(EXPR_W(item,EXPR_OP)!=4 || SYMBOL_INDEX_HOOK(EXPR_W(item,EXPR_LEFT))!=0xFFFF) break;
        result.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),1);
        NEW_CODE_NODE(0x94,0,result.words.low,0);
        NEW_CODE_NODE(0x74,0,0,0);
        return result.value;
    case EOP_ADDR: /* 1CA4 */
        if(EXPR_FLAGS[EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND)]&2) CODE_OUTPUT_FLAGS|=2;
        return GENERATE_ADDRESS_OF(EXPR_W(node,EXPR_LEFT),(unsigned char)EXPR_W(node,EXPR_KIND));
    case EOP_POSTINC: /* 1CD0 */
        if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&2) {
            result.words.low=GEN_FLOAT_POSTINC_DEC(node,mode);
            result.words.high=0;
            return result.value;
        }
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0x33) return GENERATE_BITFIELD_INC_DEC(node,mode);
        return GENERATE_POST_INCREMENT(node);
    /* Long division and remainder: both operands are pushed (right first, high word first) and
       the helper from OPERATOR_HELPER_NAME_TABLE is called; it pops its 8 bytes (op 0xAE) and
       returns the result in DX:AX. Op 6 with 0x55 first frees AX, DX, BX and CX, probably. */
    case EOP_DIV:case EOP_MOD: /* 1D1A */
        if(EXPR_W(node,EXPR_KIND)!=TK_LONG && EXPR_W(node,EXPR_KIND)!=TK_ULONG) break;
        NEW_CONSTANT_NODE(6,0x55UL);
        result.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),1);
        NEW_CODE_NODE(0x94,0,result.words.high,0);
        NEW_CODE_NODE(0x94,0,result.words.low,0);
        result.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
        NEW_CODE_NODE(0x94,0,result.words.high,0);
        NEW_CODE_NODE(0x94,0,result.words.low,0);
        EMIT_OPERATOR_HELPER(node);
        NEW_CONSTANT_NODE(0xAE,8UL);
        result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
        result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        return result.value;
    case EOP_POSTDEC: /* 1DF6 */
        if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&2) {
            result.words.low=GEN_FLOAT_POSTINC_DEC(node,mode);
            result.words.high=0;
            return result.value;
        }
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0x33) return GENERATE_BITFIELD_INC_DEC(node,mode);
        return GENERATE_POST_DECREMENT(node);
    case EOP_DIV_ASSIGN:case EOP_MOD_ASSIGN: /* 1E40 */
        if((int)EXPR_W(node,EXPR_KIND)>=TK_SHORT && (int)EXPR_W(node,EXPR_KIND)<=TK_UINT) {
            node=EXPAND_COMPOUND_ASSIGN_HOOK(node);
            break;
        }
        /* fall through */
    case EOP_MUL_ASSIGN:case EOP_SHL_ASSIGN:case EOP_SHR_ASSIGN: /* 1E5C */
        if((EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&2) && ((int)EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)>7 || mode)) {
            node=EXPAND_COMPOUND_ASSIGN_HOOK(node);
            break;
        }
        if(EXPR_W(node,EXPR_KIND)==TK_LONG || EXPR_W(node,EXPR_KIND)==TK_ULONG) node=EXPAND_COMPOUND_ASSIGN_HOOK(node);
        break;
    case EOP_ADD_ASSIGN:case EOP_SUB_ASSIGN: /* 1EA4 */
        if((EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&2) && ((int)EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)>7 || mode)) {
            node=EXPAND_COMPOUND_ASSIGN_HOOK(node);
            break;
        }
        if(!HUGE_PTR_AHSHIFT_MODE && EXPR_W(node,EXPR_KIND)==TK_HUGE_PTR)
            EXPR_W(node,EXPR_LEFT)=DECAY_TO_POINTER_HOOK(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),EXPR_W(node,EXPR_LEFT),1);
        break;
    /* Long shifts by the constants 16 and 1 are done inline: by 16 the words just move (CWD
       fills the high word for a signed right shift); by 1 a shift of one word and a
       rotate-through-carry of the other (ops 0x55/0x56 probably RCR/RCL). */
    case EOP_SHL:case EOP_SHR: /* 1F05 */
        if(EXPR_W(node,EXPR_KIND)!=TK_LONG && EXPR_W(node,EXPR_KIND)!=TK_ULONG) break;
        if(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_OP)!=EOP_CONST) break;
        if(EXPR_L(EXPR_W(node,EXPR_RIGHT),EXPR_VALUE)>0xFFFFL) break;
        temporary=(unsigned int)EXPR_L(EXPR_W(node,EXPR_RIGHT),EXPR_VALUE);
        if(temporary!=0x10 && temporary!=1) break;
        left_pair.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
        if(temporary==0x10) {
            if(EXPR_W(node,EXPR_OP)==EOP_SHL) {
                result.words.high=left_pair.words.low;
                result.words.low=NEW_CONSTANT_NODE(0x0A,0UL);
            } else if(EXPR_W(node,EXPR_KIND)==TK_ULONG) {
                result.words.low=left_pair.words.high;
                result.words.high=NEW_CONSTANT_NODE(0x0A,0UL);
            } else {
                result.words.low=NEW_CODE_NODE(0xAC,0,left_pair.words.high,0);
                result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
            }
        } else {
            item=NEW_CONSTANT_NODE(9,(unsigned long)temporary);
            if(EXPR_W(node,EXPR_OP)==EOP_SHL) {
                result.words.low=NEW_CODE_NODE(0x45,0,left_pair.words.low,item);
                result.words.high=NEW_CODE_NODE(0x56,0,left_pair.words.high,item);
            } else {
                result.words.high=NEW_CODE_NODE(EXPR_W(node,EXPR_KIND)==TK_ULONG?0x47:0x49,0,left_pair.words.high,item);
                result.words.low=NEW_CODE_NODE(0x55,0,left_pair.words.low,item);
            }
        }
        return result.value;
    case 0x36: /* 2073 */
        return GENERATE_CALL(node,mode);
    case EOP_NOT: /* 207F */
        operation=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP);
        if(operation!=0x28 && operation!=0x27 && (int)EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND)<=TK_UINT) break;
        /* fall through */
    /* A comparison or logical operator used as a value becomes 'cond ? 1 : 0', and ?: is
       generated with blocks: the condition jumps to the second arm, each arm ends with op 2
       (the value carried to the join), and the join's op 3 is the result. Op 6 with 0x1055
       first frees the registers, so both arms start from the same state. */
    case EOP_EQ:case EOP_NE:case EOP_GT:case EOP_LT:case EOP_GE:case EOP_LE:
    case EOP_ANDAND:case EOP_OROR: /* 20A7 */
        item=NEW_CONST_NODE_HOOK(MODE_HOOK(5),1UL);
        temporary=NEW_CONST_NODE_HOOK(MODE_HOOK(5),0UL);
        temporary=NEW_EXPR_NODE_HOOK(0x26,EXPR_W(item,EXPR_TYPE),item,temporary);
        node=NEW_EXPR_NODE_HOOK(0x25,EXPR_W(item,EXPR_TYPE),node,temporary);
        /* fall through */
    case EOP_QUESTION: /* 2100 */
        first_expression=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_LEFT);
        expression_kind=(unsigned char)EXPR_W(first_expression,EXPR_KIND);
        second_expression=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT);
        item=CURRENT_CODE_BLOCK;
        join_label=NEW_LABEL();
        alternate_label=NEW_LABEL();
        NEW_CONSTANT_NODE(6,0x1055UL);
        CNODE_W(item,CNODE_OP_COUNT)=CODE_OP_NEXT_INDEX-CNODE_W(item,CNODE_FIRST_OP);
        temporary=NEW_BRANCH_BLOCK(0,EXPR_W(node,EXPR_LEFT),alternate_label,0,0,0,0);
        JOIN_BLOCK_CHAINS(item,temporary);
        CURRENT_CODE_BLOCK=temporary=NEW_BLOCK();
        if(expression_kind!=0x0C) {
            left_pair.value=GENERATE_EXPRESSION(first_expression,1);
            left_pair.words.low=NEW_CODE_NODE(2,0,left_pair.words.low,0);
            if(left_pair.words.high)
                left_pair.words.high=NEW_CODE_NODE(2,0,left_pair.words.high,0);
        } else GENERATE_EXPRESSION(first_expression,0);
        CNODE_W(CURRENT_CODE_BLOCK,CNODE_OP_COUNT)=CODE_OP_NEXT_INDEX-CNODE_W(CURRENT_CODE_BLOCK,CNODE_FIRST_OP);
        JOIN_BLOCK_CHAINS(item,temporary);
        JOIN_BLOCK_CHAINS(item,NEW_JUMP_BLOCK(join_label,0,0,0,0));
        JOIN_BLOCK_CHAINS(item,alternate_label);
        CURRENT_CODE_BLOCK=temporary=NEW_BLOCK();
        if(expression_kind!=0x0C) {
            right_pair.value=GENERATE_EXPRESSION(second_expression,1);
            right_pair.words.low=NEW_CODE_NODE(2,0,right_pair.words.low,left_pair.words.low);
            if(right_pair.words.high)
                right_pair.words.high=NEW_CODE_NODE(2,0,right_pair.words.high,left_pair.words.high);
        } else GENERATE_EXPRESSION(second_expression,0);
        CNODE_W(CURRENT_CODE_BLOCK,CNODE_OP_COUNT)=CODE_OP_NEXT_INDEX-CNODE_W(CURRENT_CODE_BLOCK,CNODE_FIRST_OP);
        JOIN_BLOCK_CHAINS(item,temporary);
        JOIN_BLOCK_CHAINS(item,join_label);
        CURRENT_CODE_BLOCK=temporary=NEW_BLOCK();
        JOIN_BLOCK_CHAINS(item,temporary);
        if(expression_kind!=0x0C) {
            result.words.low=NEW_CODE_NODE(3,0,left_pair.words.low,right_pair.words.low);
            if(left_pair.words.high)
                result.words.high=NEW_CODE_NODE(3,0,left_pair.words.high,right_pair.words.high);
        }
        return result.value;
    }
    /* Common generic handler22E7; rewritten nodes deliberately reach here without redispatch. */
    if((EXPR_W(node,EXPR_OP)==EOP_DIV || EXPR_W(node,EXPR_OP)==EOP_MOD) && (EXPR_W(node,EXPR_KIND)==TK_LONG || EXPR_W(node,EXPR_KIND)==TK_ULONG))
        NEW_CONSTANT_NODE(6,0x55UL);
    return GENERATE_OPERATOR(node);
}

/* ---- STAOV046 (listing ovr_1d5e_a195:237F) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal LABEL_REGISTER_NEED(unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
union Result { unsigned long value; struct { unsigned int low,high; } words; };
/* EMIT_RETURN_VALUE: generates 'return node;' value and moves it where the caller expects
   it: AX (op 0xB5 with the low word only), DX:AX for longs and far pointers, the 8087 for
   floats (op 0xB4). */
void far pascal EMIT_RETURN_VALUE(unsigned int node)
{
    union Result result;
    _SI=node;
    result.value=GENERATE_EXPRESSION(LABEL_REGISTER_NEED(_SI),1);
    _ES=EXPR_POOL_SEG;
    _BX=*(unsigned int far *)MK_FP(_ES,_SI+EXPR_KIND);
    _BX-=7;
    switch(_BX) {
    default:
        _AX=0xB5;goto zero_extended;
    case 0:case 1:case 8:case 9:
        NEW_CODE_NODE(0xB5,0,result.words.low,result.words.high);
        break;
    case 2:case 3:case 4:
        _AX=0xB4;
zero_extended:
        NEW_CODE_NODE(_AX,0,result.words.low,0);
        break;
    }
}

/* ---- STAOV047 (listing ovr_1d5e_a195:23F6) ---- */
static unsigned int near pascal RESULT_SETS_FLAGS(unsigned int node);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal LABEL_REGISTER_NEED(unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,unsigned long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
extern void far pascal GEN_FPU_COMPARE(unsigned int, unsigned int);
#define LOW(v) ((unsigned int)(v))
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* EMIT_TEST_ZERO: generates 'node' and sets the CPU flags for a test against zero: OR of
   the two words of a long or far pointer; TEST of the operands of an AND node; nothing
   extra when the last operation already set the flags (RESULT_SETS_FLAGS); otherwise CMP
   with 0; floating values are compared with 0.0 on the 8087 (GEN_FPU_COMPARE with FLDZ). */
void far pascal EMIT_TEST_ZERO(unsigned int node)
{
    unsigned int other;
    unsigned long first;
    unsigned long second;
    unsigned int value;
    unsigned int kind;

    _SI = node;
    _SI = LABEL_REGISTER_NEED(_SI);
    _ES = EXPR_POOL_SEG;
    switch (ES_W(_SI, EXPR_KIND)) {
    case 7: case 8: case 15: case 16:
        first = GENERATE_EXPRESSION(_SI, 1);
        NEW_CODE_NODE(0x4D, 0, LOW(first), HIGH(first));
        break;
    case 3: case 4: case 5: case 6: case 13: case 14:
        _ES = EXPR_POOL_SEG;
        kind = ES_W(_SI, EXPR_OP);
        if (kind == 0x0F) {
            other = ES_W(_SI, EXPR_RIGHT);
            _DI = ES_W(_SI, EXPR_LEFT);
            if (*((signed char far *)MK_FP(_ES, _SI + EXPR_NODE_FLAGS)) > 0) {
                first = GENERATE_EXPRESSION(other, 1);
                second = GENERATE_EXPRESSION(_DI, 1);
            } else {
                first = GENERATE_EXPRESSION(_DI, 1);
                second = GENERATE_EXPRESSION(other, 1);
            }
            NEW_CODE_NODE(0x86, 0, LOW(first), LOW(second));
        } else if (!RESULT_SETS_FLAGS(_SI)) {
            first = GENERATE_EXPRESSION(_SI, 1);
            value = NEW_CONSTANT_NODE(10, 0L);
            NEW_CODE_NODE(0x81, 0, LOW(first), value);
        } else {
            GENERATE_EXPRESSION(_SI, 1);
        }
        break;
    case 1: case 2:
        _ES = EXPR_POOL_SEG;
        kind = ES_W(_SI, EXPR_OP);
        if (kind == 0x0F) {
            other = ES_W(_SI, EXPR_RIGHT);
            _DI = ES_W(_SI, EXPR_LEFT);
            if (*((signed char far *)MK_FP(_ES, _SI + EXPR_NODE_FLAGS)) > 0) {
                first = GENERATE_EXPRESSION(other, 1);
                second = GENERATE_EXPRESSION(_DI, 1);
            } else {
                first = GENERATE_EXPRESSION(_DI, 1);
                second = GENERATE_EXPRESSION(other, 1);
            }
            NEW_CODE_NODE(0x85, 0, LOW(first), LOW(second));
        } else if (!RESULT_SETS_FLAGS(_SI)) {
            first = GENERATE_EXPRESSION(_SI, 1);
            value = NEW_CONSTANT_NODE(9, 0L);
            NEW_CODE_NODE(0x80, 0, LOW(first), value);
        } else {
            GENERATE_EXPRESSION(_SI, 1);
        }
        break;
    case 9: case 10: case 11:
        first = GENERATE_EXPRESSION(_SI, 1);
        GEN_FPU_COMPARE(LOW(first), NEW_CODE_NODE(0x8A, 0, 0, 0));
        break;
    }
}
#undef LOW
#undef HIGH

/* ---- STAOV048 (listing ovr_1d5e_a195:25FC) ---- */
/* SEGMENT_REGISTER_CODE: the segment register a pointer of segment kind 'value' (from the
   type flags) is relative to: 1 ES (12), 2 CS (14), 3 SS (15), 4 DS (13), else 0xFF. */
signed char far pascal SEGMENT_REGISTER_CODE(unsigned int value)
{
    switch (value) {
    case 2:
        return 0x0E;
    case 4:
        return 0x0D;
    case 1:
        return 0x0C;
    case 3:
        return 0x0F;
    default:
        return 0xFF;
    }
}

/* ---- STAOV049 (listing ovr_1d5e_a195:262D) ---- */
static unsigned int near pascal SET_BLOCK_JUMP(unsigned int first, unsigned int second);
static unsigned int near pascal FLAGS_BIT_TEST_JUMP_KIND(unsigned int mode, unsigned int node);
static int near pascal IS_IMMEDIATE_OPERAND(register unsigned int value);
static int near pascal COMPARE_OP_TO_JUMP(register unsigned int index, int kind);
void far pascal EMIT_HELPER_CALL(char near *text,unsigned int value);
extern unsigned int EXPR_POOL_SEG; extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal LABEL_REGISTER_NEED(unsigned int);
extern unsigned int far pascal MIRROR_COMPARE_OP(unsigned int);
extern unsigned int far pascal NEW_LABEL(void);
extern unsigned int far pascal NEW_BLOCK(void);
extern void far pascal JOIN_BLOCK_CHAINS(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern void far pascal GEN_FPU_COMPARE(unsigned int,unsigned int);
#define LOW(v) (((unsigned int near *)&(v))[0])
#define HIGH(v) (((unsigned int near *)&(v))[1])
#define PAIR() do { \
    _BX=node; _ES=EXPR_POOL_SEG; \
    if(ES_SC(_BX,EXPR_NODE_FLAGS)<0) { \
        first=GENERATE_EXPRESSION(_SI,1); \
        second=GENERATE_EXPRESSION(_DI,1); \
    } else { \
        second=GENERATE_EXPRESSION(_DI,1); \
        first=GENERATE_EXPRESSION(_SI,1); \
    } \
} while(0)

/* EMIT_COMPARE: ends the current block with 'if comparison 'node' holds, jump to block
   'value''. Operands are swapped (and the operator mirrored) so an immediate ends up on
   the right. 32-bit comparisons compare the high words first in their own block (with
   CNODE_FLAGS 8 so live values flow on) and jump or fall to a low-word comparison done
   unsigned; a test against 0 uses EMIT_TEST_ZERO; '(_FLAGS & bit) ==/!= 0' becomes a
   direct jump on that flag; floating comparisons use GEN_FPU_COMPARE; huge pointers are
   compared by a helper (STR_PCMP). */
void far pascal EMIT_COMPARE(unsigned int node,unsigned int value)
{
    unsigned long first,second;
    unsigned int saved,newnode,temp,kind,original,type,swap;
    node=LABEL_REGISTER_NEED(node);
    _ES=EXPR_POOL_SEG;
    _BX=node;
    kind=ES_W(_BX,EXPR_OP);
    _SI=ES_W(_BX,EXPR_LEFT);
    _DI=ES_W(_BX,EXPR_RIGHT);
    if(!IS_IMMEDIATE_OPERAND(_DI) &&
       (IS_IMMEDIATE_OPERAND(_SI) ||
        (*((signed char far *)MK_FP(EXPR_POOL_SEG,node+EXPR_NODE_FLAGS))>0 && ES_W(_SI,EXPR_OP)!=4))) {
        swap=_SI;
        _SI=_DI;
        _DI=swap;
        kind=MIRROR_COMPARE_OP(kind);
        _BX=node;
        _ES=EXPR_POOL_SEG;
        ES_SC(_BX,EXPR_NODE_FLAGS)=-ES_SC(_BX,EXPR_NODE_FLAGS);
    }
    original=kind;
    _ES=EXPR_POOL_SEG;
    type=ES_W(_SI,EXPR_KIND);
    kind=COMPARE_OP_TO_JUMP(kind,type);
    saved=CURRENT_CODE_BLOCK;
    _ES=EXPR_POOL_SEG;
    switch(ES_W(_SI,EXPR_KIND)) {
    case 7: case 8: case 15:
        _ES=EXPR_POOL_SEG;
        if(ES_W(_DI,EXPR_OP)==2 && (kind==10 || kind==11)) {
            _ES=EXPR_POOL_SEG;
            if(ES_UL(_DI,EXPR_LEFT)==0L) {
                EMIT_TEST_ZERO(_SI);
                break;
            }
        }
        PAIR();
        temp=NEW_LABEL();
        NEW_CODE_NODE(0x81,0,HIGH(first),HIGH(second));
        _BX=CURRENT_CODE_BLOCK;
        _ES=FLOW_BLOCK_POOL_SEG;
        ES_W(_BX,CNODE_FLAGS)|=8;
        switch(original) {
        case 0x1F: case 0x20:
            SET_BLOCK_JUMP(kind,value);
            CURRENT_CODE_BLOCK=newnode=NEW_BLOCK();
            SET_BLOCK_JUMP(11,temp);
            JOIN_BLOCK_CHAINS(saved,newnode);
            break;
        case 0x1D:
            SET_BLOCK_JUMP(11,temp);
            break;
        case 0x1E:
            SET_BLOCK_JUMP(kind,value);
            break;
        case 0x22:
            SET_BLOCK_JUMP(COMPARE_OP_TO_JUMP(0x20,type),value);
            CURRENT_CODE_BLOCK=newnode=NEW_BLOCK();
            SET_BLOCK_JUMP(COMPARE_OP_TO_JUMP(0x1F,type),temp);
            JOIN_BLOCK_CHAINS(saved,newnode);
            break;
        case 0x21:
            SET_BLOCK_JUMP(COMPARE_OP_TO_JUMP(0x1F,type),value);
            CURRENT_CODE_BLOCK=newnode=NEW_BLOCK();
            SET_BLOCK_JUMP(COMPARE_OP_TO_JUMP(0x20,type),temp);
            JOIN_BLOCK_CHAINS(saved,newnode);
            break;
        }
        CURRENT_CODE_BLOCK=newnode=NEW_BLOCK();
        NEW_CODE_NODE(0x81,0,LOW(first),LOW(second));
        SET_BLOCK_JUMP(COMPARE_OP_TO_JUMP(original,6),value);
        JOIN_BLOCK_CHAINS(newnode,temp);
        JOIN_BLOCK_CHAINS(saved,newnode);
        return;
    case 3: case 4: case 5: case 6: case 13: case 14:
        _ES=EXPR_POOL_SEG;
        if(ES_W(_DI,EXPR_OP)==2 && ES_UL(_DI,EXPR_LEFT)==0L) {
            if(ES_W(_SI,EXPR_OP)==15 && ES_W(ES_W(_SI,EXPR_LEFT),EXPR_OP)==4 && ES_W(ES_W(_SI,EXPR_LEFT),EXPR_RIGHT)==0xFFFF)
                kind=FLAGS_BIT_TEST_JUMP_KIND(kind,_SI);
            else EMIT_TEST_ZERO(_SI);
            break;
        }
        PAIR();
        NEW_CODE_NODE(0x81,0,LOW(first),LOW(second));
        break;
    case 1: case 2:
        _ES=EXPR_POOL_SEG;
        if(ES_W(_DI,EXPR_OP)==2 && ES_UL(_DI,EXPR_LEFT)==0L) {
            EMIT_TEST_ZERO(_SI);
            break;
        }
        PAIR();
        NEW_CODE_NODE(0x80,0,LOW(first),LOW(second));
        break;
    case 9: case 10: case 11:
        GEN_FPU_COMPARE((unsigned int)GENERATE_EXPRESSION(_SI,1),
                      (unsigned int)GENERATE_EXPRESSION(_DI,1));
        break;
    case 16:
        _ES=EXPR_POOL_SEG;
        if(abs(ES_SC(_SI,EXPR_NODE_FLAGS))>abs(ES_SC(_DI,EXPR_NODE_FLAGS))) {
            first=GENERATE_EXPRESSION(_SI,1);
            second=GENERATE_EXPRESSION(_DI,1);
            NEW_CODE_NODE(0xB5,0,LOW(first),HIGH(first));
            NEW_CODE_NODE(0xB6,0,LOW(second),HIGH(second));
        } else {
            second=GENERATE_EXPRESSION(_DI,1);
            first=GENERATE_EXPRESSION(_SI,1);
            NEW_CODE_NODE(0xB6,0,LOW(second),HIGH(second));
            NEW_CODE_NODE(0xB5,0,LOW(first),HIGH(first));
        }
        EMIT_HELPER_CALL(STR_PCMP,0x55);
        break;
    }
    _BX=CURRENT_CODE_BLOCK;
    _ES=FLOW_BLOCK_POOL_SEG;
    ES_W(_BX,CNODE_OP_COUNT)=CODE_OP_NEXT_INDEX-ES_W(_BX,CNODE_FIRST_OP);
    ES_W(_BX,CNODE_JUMP_KIND)=kind;
    ES_W(_BX,CNODE_TARGET)=value;
}
#undef LOW
#undef HIGH
#undef PAIR

/* ---- STAOV050 (listing ovr_1d5e_a195:2A9C) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* SET_BLOCK_JUMP: closes CURRENT_CODE_BLOCK's op run (words 2 and 3 are CNODE_FIRST_OP and
   CNODE_OP_COUNT) with jump kind 'first' (word 4) to block 'second' (word 8); returns the
   block. */
static unsigned int near pascal SET_BLOCK_JUMP(unsigned int first,
                                               unsigned int second)
{
    _BX = CURRENT_CODE_BLOCK;
    _ES = FLOW_BLOCK_POOL_SEG;
    ((unsigned int far *)MK_FP(_ES, _BX))[3] =
        CODE_OP_NEXT_INDEX - ((unsigned int far *)MK_FP(_ES, _BX))[2];
    ((unsigned int far *)MK_FP(_ES, _BX))[4] = first;
    ((unsigned int far *)MK_FP(_ES, _BX))[8] = second;
    return CURRENT_CODE_BLOCK;
}

/* ---- STAOV051 (listing ovr_1d5e_a195:2AC9) ---- */
#pragma option -O-   /* STAOV051 was compiled without -O */
extern unsigned int EXPR_POOL_SEG;
extern int far pascal LOG2_POWER_OF_TWO(unsigned int, unsigned int);


/* FLAGS_BIT_TEST_JUMP_KIND: for '(_FLAGS & mask) == 0' or '!= 0' ('mode' 10 or 11) with a
   one-bit mask of a CPU flag (carry, parity, zero, sign or overflow), returns the jump kind
   that tests that flag directly; otherwise generates EMIT_TEST_ZERO and returns 'mode'. */
static unsigned int near pascal FLAGS_BIT_TEST_JUMP_KIND(unsigned int mode,
                                             unsigned int node)
{
    unsigned int child;
    int value;

    _SI = mode;
    _DI = node;
    if (_SI != 10 && _SI != 11) goto fallback;
    _ES = EXPR_POOL_SEG;
    child = ES_W(_DI, EXPR_RIGHT);
    _BX = child;
    if (ES_W(_BX, EXPR_OP) != 2) goto fallback;
    _BX = child;
    _ES = EXPR_POOL_SEG;
    value = LOG2_POWER_OF_TWO(ES_W(_BX, EXPR_RIGHT), ES_W(_BX, EXPR_LEFT));
    if (value < 0) goto fallback;
    switch (value) {
    case 0:
        return _SI == 10 ? 13 : 12;
    case 2:
        return _SI == 10 ? 19 : 18;
    case 6:
        return _SI == 10 ? 11 : 10;
    case 7:
        return _SI == 10 ? 17 : 16;
    case 11:
        return _SI == 10 ? 15 : 14;
    }
fallback:
    EMIT_TEST_ZERO(_DI);
    /* Return through AX without the extra unoptimized return jump. */
    _AX = _SI;
}

#pragma option -O
/* ---- STAOV052 (listing ovr_1d5e_a195:2B9C) ---- */
extern unsigned int EXPR_POOL_SEG;


/* RESULT_SETS_FLAGS: non-zero when the instruction that computes signed or plain node
   'node' already leaves the zero flag matching its result, so no compare with 0 is needed:
   add or subtract (1 by 1 as INC/DEC, value 4), or, xor, the in-place forms (3 for += 1
   and -= 1). 0 for unsigned kinds (EXPR_FLAGS 0x20). */
static unsigned int near pascal RESULT_SETS_FLAGS(unsigned int node)
{
    _SI = node;
    _ES = EXPR_POOL_SEG;
    _BX = ES_W(_SI, EXPR_KIND);
    if (EXPR_FLAGS[_BX] & 0x20)
        return 0;
    {
        _ES = EXPR_POOL_SEG;
        switch (ES_W(_SI, EXPR_OP)) {
        case 8:
        case 9:
            _ES = EXPR_POOL_SEG;
            _BX = ES_W(_SI, EXPR_RIGHT);
            if (ES_W(_BX, EXPR_OP) == 2) {
                _BX = ES_W(_SI, EXPR_RIGHT);
                if (ES_W(_BX, EXPR_RIGHT) == 0 && ES_W(_BX, EXPR_LEFT) == 1)
                    return 4;
            }
        case 0x10:
        case 0x11:
            return 2;
        case 0x13:
        case 0x14:
            _ES = EXPR_POOL_SEG;
            _BX = ES_W(_SI, EXPR_RIGHT);
            if (ES_W(_BX, EXPR_OP) == 2) {
                _BX = ES_W(_SI, EXPR_RIGHT);
                if (ES_W(_BX, EXPR_RIGHT) == 0 && ES_W(_BX, EXPR_LEFT) == 1)
                    return 3;
            }
        case 0x1A:
        case 0x1B:
        case 0x1C:
            return 1;
        }
    }
    return 0;
}

/* ---- STAOV053 (listing ovr_1d5e_a195:2C51) ---- */
extern unsigned int EXPR_POOL_SEG;

#define N(n) ((unsigned int far *)MK_FP(EXPR_POOL_SEG, (n)))
/* IS_IMMEDIATE_OPERAND: looking through casts, 1 for a constant, 3 for the address of a
   symbol, else 0 (word 5 of a node is EXPR_LEFT). */
static int near pascal IS_IMMEDIATE_OPERAND(register unsigned int value)
{
    while (*N(value) == 0x35)
        value = N(value)[5];
    if (*N(value) == 2)
        return 1;
    if (*N(value) != 0x32)
        return 0;
    if (*N(N(value)[5]) == 1)
        return 3;
    return 0;
}
#undef N

/* ---- STAOV054 (listing ovr_1d5e_a195:2C9F) ---- */
/* COMPARE_OP_TO_JUMP: the jump kind for comparison operator 'index' on value kind 'kind':
   from the table at DS:5268 for signed kinds (char, short, int, long, enum), else from
   DS:5262 (unsigned comparisons). */
static int near pascal COMPARE_OP_TO_JUMP(register unsigned int index, int kind)
{
    switch (kind) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 21:
        return ((signed char near *)((char near *)&OPERATOR_HELPER_NAME_TABLE+51))[index];
    default:
        return ((signed char near *)((char near *)&OPERATOR_HELPER_NAME_TABLE+45))[index];
    }
}

/* ---- STAOV055 (listing ovr_1d5e_a195:2CDA) ---- */
extern unsigned int STRING_POOL_SEG;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char OPTION_MEMORY_MODEL; extern unsigned char OPTION_WINDOWS_MODE;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern int far pascal COMPARE_NAME(char far *,char far *);
extern unsigned int far pascal NEW_LABEL(void);
extern unsigned int far pascal NEW_BLOCK(void);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);

/* EMIT_STACK_CHECK: called when the function's outer scope opens (APPEND_BLOCK_CHAIN).
   Notes in ASM_OUTPUT_FLAGS bit 8 whether the code segment has the default name (DS:52C8),
   which decides near or far helper calls. With the stack check option (not for Windows or
   interrupt functions) it appends blocks that compare SP with the stack limit variable
   (named at DS:52CE or DS:52D6, a far one in the huge model; for frames over 200 bytes BP
   is compared with SP first) and call the overflow helper (STR_OVERFLOW) when the stack is
   too low. */
void far pascal EMIT_STACK_CHECK(void)
{
    unsigned int code_segment,overflow_label,check_block,operand_node,condition,limit_symbol,done_label;
    code_segment=FIND_SEGMENT(FUNCTION_CODE_SEGMENT);
    _BX=code_segment;
    _ES=SEGDEF_POOL_SEG;
    if (!COMPARE_NAME((char far *)MK_FP(STRING_POOL_SEG,ES_W(_BX,SEGDEF_NAME)),
                      (char far *)MK_FP(_DS,(unsigned)(STR_TEXT)))) ASM_OUTPUT_FLAGS|=8;
    if (OPTION_WINDOWS_MODE) return;
    if (OPTION_STACK_CHECK==0) return;
    if (CODEGEN_CALL_CONV==4) return;
    done_label=NEW_LABEL();
    if (FRAME_LOCALS_SIZE>200) {
        overflow_label=NEW_LABEL();
        CURRENT_CODE_BLOCK=check_block=NEW_BLOCK();
        _SI=NEW_CODE_NODE(8,0,10,0);
        operand_node=NEW_CODE_NODE(8,0,11,0);
        NEW_CODE_NODE(0x81,0,_SI,operand_node);
        SET_BLOCK_JUMP(5,overflow_label);
        APPEND_BLOCK_CHAIN(FUNCTION_SERIAL,check_block,1);
    }
    CURRENT_CODE_BLOCK=check_block=NEW_BLOCK();
    if (OPTION_MEMORY_MODEL!=5) {
        if (OPTION_MEMORY_MODEL==4 || OPTION_MEMORY_MODEL==3 || OPTION_DS_NOT_SS) {
            condition=5;
            limit_symbol=DECLARE_NAMED_GLOBAL_HOOK((char near *)(STR_STKLEN_2),0);
        } else {
            condition=4;
            limit_symbol=DECLARE_NAMED_GLOBAL_HOOK((char near *)(STR_BRKLVL),0);
        }
        _SI=NEW_VARIABLE_NODE(0x10,limit_symbol,0,0);
    } else {
        limit_symbol=DECLARE_NAMED_GLOBAL_HOOK((char near *)(STR_STKLEN_2),0);
        _SI=NEW_VARIABLE_NODE(13,limit_symbol,0,0x10);
        operand_node=NEW_VARIABLE_NODE(12,limit_symbol,0,0x10);
        _SI=NEW_CODE_NODE(0x16,0,_SI,operand_node);
        condition=5;
    }
    operand_node=NEW_CODE_NODE(8,0,11,0);
    NEW_CODE_NODE(0x81,0,_SI,operand_node);
    SET_BLOCK_JUMP(condition,done_label);
    APPEND_BLOCK_CHAIN(FUNCTION_SERIAL,check_block,1);
    if (FRAME_LOCALS_SIZE>200) APPEND_BLOCK_CHAIN(FUNCTION_SERIAL,overflow_label,1);
    _DI=NEW_BLOCK();
    EMIT_HELPER_CALL(STR_OVERFLOW,0);
    _ES=FLOW_BLOCK_POOL_SEG;
    ES_W(_DI,CNODE_OP_COUNT)=CODE_OP_NEXT_INDEX-ES_W(_DI,CNODE_FIRST_OP);
    APPEND_BLOCK_CHAIN(FUNCTION_SERIAL,_DI,1);
    APPEND_BLOCK_CHAIN(FUNCTION_SERIAL,done_label,1);
}

/* ---- STAOV056 (listing ovr_1d5e_a195:2EEC) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);


/* PUSH_STRUCT_VALUE: pushes struct argument 'node': a struct of 1, 2 or 4 bytes is turned
   into an integer and 1 is returned so the caller pushes it as such; otherwise its
   address goes to DX:AX, its even size to CX, the helper STR_SPUSH copies it onto the
   stack (the stack grows by the size, op 0xAE with -size) and 0 is returned. */
unsigned int far pascal PUSH_STRUCT_VALUE(unsigned int node)
{
    unsigned long value;
    _DI = node;
    _ES = EXPR_POOL_SEG;
    _SI = SIZE_OF_TYPE_CHECKED_HOOK(*((unsigned int far *)MK_FP(_ES, _DI + EXPR_TYPE)));
    if (_SI == 4 || _SI == 2 || _SI == 1) {
        NARROW_STRUCT_TO_SCALAR(_DI);
        return 1;
    }
    value = GENERATE_EXPRESSION(_DI, 1);
    NEW_CODE_NODE(0xB5, 0, (unsigned int)value,
                 ((unsigned int near *)&value)[1]);
    if (_SI & 1)
        _SI++;
    NEW_CODE_NODE(0xB6, 0, 0, NEW_CONSTANT_NODE(10, (unsigned long)_SI));
    EMIT_HELPER_CALL(STR_SPUSH, 0x1050);
    NEW_CONSTANT_NODE(0xAE, (unsigned long)(unsigned int)(-_SI));
    return 0;
}

/* ---- STAOV057 (listing ovr_1d5e_a195:2F8A) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);

#define LOW(v) ((unsigned int)(v))
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* GENERATE_STRUCT_ASSIGN: struct assignment 'node': pushes the far addresses of the
   target and the source, puts the size in CX and calls STR_SCOPY (which pops 8 bytes);
   the value of the assignment, when 'mode' wants it, is the target generated again. */
unsigned long far pascal GENERATE_STRUCT_ASSIGN(unsigned int node, unsigned int mode)
{
    unsigned int right;
    unsigned int size;
    unsigned long first;
    unsigned long second;

    _DI = node;
    _ES = EXPR_POOL_SEG;
    _SI = ES_W(_DI, EXPR_LEFT);
    right = ES_W(_DI, EXPR_RIGHT);
    size = SIZE_OF_TYPE_CHECKED_HOOK(ES_W(_SI, EXPR_TYPE));
    NEW_CONSTANT_NODE(6, 0x1055L);
    first = GENERATE_EXPRESSION(_SI, 1);
    NEW_CODE_NODE(0x94, 0, HIGH(first), 0);
    NEW_CODE_NODE(0x94, 0, LOW(first), 0);
    second = GENERATE_EXPRESSION(right, 1);
    NEW_CODE_NODE(0x94, 0, HIGH(second), 0);
    NEW_CODE_NODE(0x94, 0, LOW(second), 0);
    NEW_CODE_NODE(0xB6, 0, 0, NEW_CONSTANT_NODE(10, (unsigned long)size));
    EMIT_HELPER_CALL(STR_SCOPY, 0x1040);
    NEW_CONSTANT_NODE(0xAE, 8L);
    if (mode)
        return GENERATE_EXPRESSION(_SI, mode);
    first = 0L;
    return first;
}
#undef LOW
#undef HIGH

/* ---- STAOV058 (listing ovr_1d5e_a195:308B) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);

/* NARROW_STRUCT_TO_SCALAR: retypes struct node 'node' of 1, 2 or 4 bytes as unsigned
   char, unsigned int or unsigned long, and does the same through struct assignments
   (op 0x34 becomes plain assignment 0x12) to both sides. */
static void near pascal NARROW_STRUCT_TO_SCALAR(register unsigned int node)
{
    register unsigned int size;
    unsigned char kind;

    size = SIZE_OF_TYPE_CHECKED_HOOK(EXPR_W(node, EXPR_TYPE));
    if (size == 1)
        kind = 2;
    else if (size == 2)
        kind = 6;
    else if (size == 4)
        kind = 8;
    else
        return;
    EXPR_W(node, EXPR_TYPE) = MODE_HOOK(kind);
    EXPR_W(node, EXPR_KIND) = kind;
    if (EXPR_W(node, EXPR_OP) == 0x34)
        EXPR_W(node, EXPR_OP) = 0x12;
    if (EXPR_W(node, EXPR_OP) == 0x12) {
        NARROW_STRUCT_TO_SCALAR(EXPR_W(node, EXPR_LEFT));
        NARROW_STRUCT_TO_SCALAR(EXPR_W(node, EXPR_RIGHT));
    }
}

/* ---- STAOV059 (listing ovr_1d5e_a195:310E) ---- */
extern unsigned char OPTION_MEMORY_MODEL;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern void far pascal STRING_COPY(char far *,char far *);
extern void far pascal STRING_APPEND(char far *,char far *);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
/* EMIT_HELPER_CALL: builds a call op of the run-time helper 'text' with the name prefix
   for near calls (DS:52F7, tiny model or default code segment) or far calls (DS:52FA);
   'value' goes into the call op's right operand (probably the registers the helper
   destroys). */
void far pascal EMIT_HELPER_CALL(char near *text,unsigned int value)
{
    char buffer[32];
    register unsigned int saved = value;
    register unsigned int name;
    if (OPTION_MEMORY_MODEL == 0 || (ASM_OUTPUT_FLAGS & 8) != 0)
        STRING_COPY(buffer,(char far *)MK_FP(_DS,(unsigned)(STR_N)));
    else
        STRING_COPY(buffer,(char far *)MK_FP(_DS,(unsigned)(STR_F)));
    STRING_APPEND(buffer,text);
    name=DECLARE_NAMED_GLOBAL_HOOK(buffer,1);
    NEW_VARIABLE_NODE((ASM_OUTPUT_FLAGS & 8)?0x77:0x78,name,saved,0x10);
}

/* ---- STAOV060 (listing ovr_1d5e_a195:3181) ---- */
extern unsigned int EXPR_POOL_SEG;

/* EMIT_OPERATOR_HELPER: calls the helper for operator node 'value' from
   OPERATOR_HELPER_NAME_TABLE, indexed by operator*4 + value kind*2 bytes. */
void far pascal EMIT_OPERATOR_HELPER(unsigned int value)
{
    _SI = value;
    _BX = ((unsigned int far *)MK_FP(EXPR_POOL_SEG, _SI))[0];
    _BX <<= 2;
    _AX = ((unsigned int far *)MK_FP(EXPR_POOL_SEG, _SI))[1];
    _AX <<= 1;
    _BX += _AX;
    EMIT_HELPER_CALL((char near *)*(unsigned int near *)((char near *)OPERATOR_HELPER_NAME_TABLE + _BX), 0x55);
}

/* ---- STAOV061 (listing ovr_1d5e_a195:31AC) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
#define LOW(v) (((unsigned int near *)&(v))[0])
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* GENERATE_DEREF_OF_ADDRESS: '*(&node + amount)' read as the type of 'first'. When 'node'
   is 3 bytes or more than 4 the address is formed and read normally. Otherwise the value
   is generated and the wanted part taken from its registers, assuming it sits in DX:AX
   (probably a small struct returned by a function): byte 'amount' as register AL, AH, DL
   or DH (register ops 7 with 0-3), the high word, or the middle two bytes moved into AX. */
static unsigned long near pascal GENERATE_DEREF_OF_ADDRESS(unsigned int first, unsigned int node,
                                      unsigned int amount)
{
    unsigned int type;
    unsigned long result;

    _DI = first;
    _SI = amount;
    _BX = node;
    _ES = EXPR_POOL_SEG;
    type = SIZE_OF_TYPE_CHECKED_HOOK(ES_W(_BX,EXPR_TYPE));
    result = GENERATE_EXPRESSION(node,1);
    if (type == 3 || type > 4) {
        if (_SI)
            LOW(result) = NEW_CODE_NODE(0x1F,0,LOW(result),
                                      NEW_CONSTANT_NODE(10,(unsigned long)_SI));
        return GENERATE_INDIRECT_LOAD(_DI,HIGH(result),LOW(result));
    }
    _ES = EXPR_POOL_SEG;
    switch (ES_W(_DI,EXPR_KIND)) {
    case 3: case 4: case 5: case 6: case 13: case 14:
        switch (_SI) {
        case 1:
            NEW_CODE_NODE(0x9B,2,NEW_CODE_NODE(8,0,0,0),
                                 NEW_CODE_NODE(8,0,1,0));
            NEW_CODE_NODE(0x9B,2,NEW_CODE_NODE(8,0,1,0),
                                 NEW_CODE_NODE(8,0,2,0));
            _AX = NEW_CONSTANT_NODE(0xC2,0L);
            goto set_low;
        case 2:
            _AX = HIGH(result);
set_low:
            LOW(result) = _AX;
            break;
        default:
            break;
        }
        HIGH(result) = 0;
        break;
    case 1: case 2:
        switch (_SI) {
        case 0: LOW(result) = NEW_CODE_NODE(7,0,0,0); break;
        case 1: LOW(result) = NEW_CODE_NODE(7,0,1,0); break;
        case 2: LOW(result) = NEW_CODE_NODE(7,0,2,0); break;
        case 3: LOW(result) = NEW_CODE_NODE(7,0,3,0); break;
        }
        HIGH(result) = 0;
        break;
    }
    return result;
}
#undef LOW
#undef HIGH

/* ---- STAOV062 (listing ovr_1d5e_a195:3340) ---- */
#pragma option -O-   /* STAOV062 was compiled without -O */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *, unsigned int);
extern void far cdecl REPORT_FATAL(unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);

extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int, unsigned int, unsigned int, unsigned char);
#define LOW(v) (((unsigned int near *)&(v))[0])
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* GENERATE_POST_DECREMENT: x-- (and huge-pointer x++ through the shared code): the result
   is a copy of the old value (ops 0x97+ / 0x98 / 0x99), then the variable is decreased in
   place by the right operand (SUB/SBB for longs; for huge pointers inline with __AHSHIFT,
   named at DS:52FD, or through the helpers STR_PDEA/STR_PINA). */
static unsigned long near pascal GENERATE_POST_DECREMENT(unsigned int node)
{
    unsigned long result, first, second;
    unsigned int temp1, temp2;
    _SI = node;
    _ES = EXPR_POOL_SEG;
    first = GENERATE_EXPRESSION(ES_W(_SI,EXPR_LEFT),1);
    _ES = EXPR_POOL_SEG;
    second = GENERATE_EXPRESSION(ES_W(_SI,EXPR_RIGHT),1);
    _ES = EXPR_POOL_SEG;
    switch (ES_W(_SI,EXPR_KIND)) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
    case 1: case 2: case 3: case 4: case 5: case 6: case 13:
        HIGH(result) = 0;
        _ES = EXPR_POOL_SEG;
        LOW(result) = NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET[ES_W(_SI,EXPR_KIND)]+0x97,0,LOW(first),0);
        NEW_CODE_NODE(CODE_OP_FOR_NODE(_SI),2,LOW(first),LOW(second));
        break;
    case 7: case 8:
        LOW(result) = NEW_CODE_NODE(0x98,0,LOW(first),0);
        HIGH(result) = NEW_CODE_NODE(0x99,0,HIGH(first),0);
        NEW_CODE_NODE(0x26,0x12,LOW(first),LOW(second));
        NEW_CODE_NODE(0x30,0x22,HIGH(first),HIGH(second));
        break;
    case 15:
        HIGH(result) = HIGH(first);
        LOW(result) = NEW_CODE_NODE(0x98,0,LOW(first),0);
        NEW_CODE_NODE(CODE_OP_FOR_NODE(_SI),2,LOW(first),LOW(second));
        break;
    case 16:
        if (HUGE_PTR_AHSHIFT_MODE) {
            LOW(result) = NEW_CODE_NODE(0x99,0,LOW(first),0);
            HIGH(result) = NEW_CODE_NODE(0x99,0,HIGH(first),0);
            temp1 = NEW_CONSTANT_NODE(10,0L);
            temp2 = NEW_VARIABLE_NODE(13,DECLARE_NAMED_GLOBAL_HOOK((char near *)(STR_AHSHIFT),1),0,0x10);
            _ES = EXPR_POOL_SEG;
            NEW_CODE_NODE(ES_W(_SI,EXPR_OP)==0x23 ? 0x1D : 0x26,0x12,LOW(first),LOW(second));
            _DI = NEW_CODE_NODE(0x24,0x20,temp1,HIGH(second));
            _DI = NEW_CODE_NODE(0x45,0,_DI,temp2);
            NEW_CODE_NODE(0x28,2,HIGH(first),_DI);
        } else {
            _ES = EXPR_POOL_SEG;
            first = GENERATE_ADDRESS_OF(ES_W(_SI,EXPR_LEFT),15);
            NEW_CONSTANT_NODE(6,0x40L);
            NEW_CODE_NODE(0xBE,0,LOW(first),HIGH(first));
            NEW_CODE_NODE(0xB5,0,LOW(second),HIGH(second));
            _ES = EXPR_POOL_SEG;
            EMIT_HELPER_CALL(ES_W(_SI,EXPR_OP)==0x24 ? STR_PDEA : STR_PINA,0x1055);
            LOW(result) = NEW_CONSTANT_NODE(0xC2,0L);
            HIGH(result) = NEW_CONSTANT_NODE(0xC3,0L);
        }
    }
    /* The unoptimized original returns directly through DX:AX. */
    _DX = HIGH(result);
    _AX = LOW(result);
}
#undef LOW
#undef HIGH

#pragma option -O
/* ---- STAOV063 (listing ovr_1d5e_a195:35D1) ---- */
#pragma option -O-   /* STAOV063 was compiled without -O */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *, unsigned int);
extern void far cdecl REPORT_FATAL(unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);

extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int, unsigned int, unsigned int, unsigned char);
#define LOW(v) (((unsigned int near *)&(v))[0])
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* GENERATE_POST_INCREMENT: x++, the same with ADD/ADC. */
static unsigned long near pascal GENERATE_POST_INCREMENT(unsigned int node)
{
    unsigned long result, first, second;
    unsigned int temp2, temp1;
    _SI = node;
    _ES = EXPR_POOL_SEG;
    first = GENERATE_EXPRESSION(ES_W(_SI,EXPR_LEFT),1);
    _ES = EXPR_POOL_SEG;
    second = GENERATE_EXPRESSION(ES_W(_SI,EXPR_RIGHT),1);
    _ES = EXPR_POOL_SEG;
    switch (ES_W(_SI,EXPR_KIND)) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
    case 1: case 2: case 3: case 4: case 5: case 6: case 13:
        _ES = EXPR_POOL_SEG;
        LOW(result) = NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET[ES_W(_SI,EXPR_KIND)]+0x97,0,LOW(first),0);
        HIGH(result) = 0;
        NEW_CODE_NODE(CODE_OP_FOR_NODE(_SI),2,LOW(first),LOW(second));
        break;
    case 7: case 8:
        LOW(result) = NEW_CODE_NODE(0x98,0,LOW(first),0);
        HIGH(result) = NEW_CODE_NODE(0x99,0,HIGH(first),0);
        NEW_CODE_NODE(0x1D,0x12,LOW(first),LOW(second));
        NEW_CODE_NODE(0x24,0x22,HIGH(first),HIGH(second));
        break;
    case 15:
        HIGH(result) = HIGH(first);
        LOW(result) = NEW_CODE_NODE(0x98,0,LOW(first),0);
        NEW_CODE_NODE(CODE_OP_FOR_NODE(_SI),2,LOW(first),LOW(second));
        break;
    case 16:
        if (HUGE_PTR_AHSHIFT_MODE) {
            LOW(result) = NEW_CODE_NODE(0x99,0,LOW(first),0);
            HIGH(result) = NEW_CODE_NODE(0x99,0,HIGH(first),0);
            temp1 = NEW_CONSTANT_NODE(10,0L);
            temp2 = NEW_VARIABLE_NODE(13,DECLARE_NAMED_GLOBAL_HOOK((char near *)(STR_AHSHIFT),1),0,0x10);
            _ES = EXPR_POOL_SEG;
            NEW_CODE_NODE(ES_W(_SI,EXPR_OP)==0x23 ? 0x1D : 0x26,0x12,LOW(first),LOW(second));
            _DI = NEW_CODE_NODE(0x24,0x20,temp1,HIGH(second));
            _DI = NEW_CODE_NODE(0x45,0,_DI,temp2);
            NEW_CODE_NODE(0x1F,2,HIGH(first),_DI);
        } else {
            _ES = EXPR_POOL_SEG;
            first = GENERATE_ADDRESS_OF(ES_W(_SI,EXPR_LEFT),15);
            NEW_CONSTANT_NODE(6,0x40L);
            NEW_CODE_NODE(0xBE,0,LOW(first),HIGH(first));
            NEW_CODE_NODE(0xB5,0,LOW(second),HIGH(second));
            _ES = EXPR_POOL_SEG;
            EMIT_HELPER_CALL(ES_W(_SI,EXPR_OP)==0x24 ? STR_PDEA : STR_PINA,0x1055);
            LOW(result) = NEW_CONSTANT_NODE(0xC2,0L);
            HIGH(result) = NEW_CONSTANT_NODE(0xC3,0L);
        }
    }
    /* The unoptimized original returns directly through DX:AX. */
    _DX = HIGH(result);
    _AX = LOW(result);
}
#undef LOW
#undef HIGH

#pragma option -O
/* ---- STAOV064 (listing ovr_1d5e_a195:3862) ---- */
#pragma option -O-   /* STAOV064 was compiled without -O */
extern unsigned int EXPR_POOL_SEG;

extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char, unsigned int, unsigned int);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int, unsigned int, unsigned int, unsigned char);
#define LOW(v) (((unsigned int near *)&(v))[0])
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* GENERATE_ADDRESS_OF: the address of object 'node' as a pointer of kind 'mode' (13 near:
   the offset only, 14 _seg: the segment only, 15/16 far and huge: both). '&*p' is just p.
   The segment is that of the symbol (op 12) for a global, else SS (register 15); for
   expression op 7 the offset is the parameter area (op 14). */
static unsigned long near pascal GENERATE_ADDRESS_OF(unsigned int node, unsigned char mode)
{
    unsigned int other;
    unsigned long result;
    _SI = node;
    _ES = EXPR_POOL_SEG;
    if (ES_W(_SI,EXPR_OP) == 0x31)
        return GENERATE_EXPRESSION(ES_W(_SI,EXPR_LEFT),1);
    if (mode != 0x0D) {
        _ES = EXPR_POOL_SEG;
        _DI = ES_W(_SI,EXPR_OP) == 1
            ? NEW_VARIABLE_NODE(12,ES_W(_SI,EXPR_LEFT),ES_W(_SI,EXPR_RIGHT),ES_B(_SI,EXPR_QUAL_FLAGS))
            : NEW_CODE_NODE(8,0,15,0);
    }
    _ES = EXPR_POOL_SEG;
    if (ES_W(_SI,EXPR_OP) == 7) {
        LOW(result) = NEW_CONSTANT_NODE(14,0L);
        HIGH(result) = _DI;
    } else {
        if (mode != 0x0E) {
            _ES = EXPR_POOL_SEG;
            /* Both empty arms are retained in the original code. */
            if (ES_W(_SI,EXPR_OP) == 1) ; else ;
            other = NEW_VARIABLE_NODE(13,
                *((unsigned int far *)MK_FP(EXPR_POOL_SEG,_SI+EXPR_LEFT)),
                ES_W(_SI,EXPR_RIGHT),ES_B(_SI,EXPR_QUAL_FLAGS));
        }
        switch (mode) {
        case 14: LOW(result) = _DI; goto zero;
        case 15:
        case 16: LOW(result) = other; HIGH(result) = _DI; break;
        case 13: LOW(result) = other;
zero:   HIGH(result) = 0;
        }
    }
    /* Leave the long result in DX:AX without an extra return jump. */
    _DX = HIGH(result);
    _AX = LOW(result);
}
#undef LOW
#undef HIGH

#pragma option -O
/* ---- STAOV065 (listing ovr_1d5e_a195:395C) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *GET_TYPE_FLAGS_ALT_HOOK)(unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                           unsigned int, unsigned int);

/* DEFAULT_SEGMENT_NODE: for a dereference 'node' through a near pointer whose type names
   a segment (type flags 1 ES, 2 CS, 3 SS), a register op for that segment register; else
   0 (the default DS). */
unsigned int far pascal DEFAULT_SEGMENT_NODE(register unsigned int node)
{
    unsigned int kind;
    if (EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_KIND) == 13) {
        kind = GET_TYPE_FLAGS_ALT_HOOK(EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_TYPE));
        switch (kind) {
        case 2:
            return NEW_CODE_NODE(8, 0, 14, 0);
        case 3:
            return NEW_CODE_NODE(8, 0, 15, 0);
        case 1:
            return NEW_CODE_NODE(8, 0, 12, 0);
        }
    }
    return 0;
}

/* ---- STAOV066 (listing ovr_1d5e_a195:39DC) ---- */
#pragma option -r-   /* STAOV066 was compiled without register variables */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *GET_TYPE_FLAGS_ALT_HOOK)(unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                           unsigned int, unsigned int);

#define LOW(v) (((volatile unsigned int near *)&(v))[0])
#define HIGH(v) (((volatile unsigned int near *)&(v))[1])

/* GENERATE_INDIRECT_LOAD: reads the object 'node' points to, given the address as offset
   op 'low' and segment op 'high' (0 for the default): one indirect op of the node's kind,
   or two (0x16 low word, 0x1B high word) for 32-bit values; a struct or union result is
   the address itself (with the segment its near pointer type implies, or offset 0 for a
   _seg pointer). */
static unsigned long near pascal GENERATE_INDIRECT_LOAD(unsigned int node,
                                              unsigned int high,
                                              unsigned int low)
{
    volatile unsigned long result;
    _SI = node;
    _ES = EXPR_POOL_SEG;
    switch (ES_W(_SI, EXPR_KIND)) {
    default:
        HIGH(result) = 0;
        if (!high)
            high = DEFAULT_SEGMENT_NODE(_SI);
        LOW(result) = NEW_CODE_NODE(CODE_OP_FOR_NODE(_SI), 0, low, high);
        break;
    case 7: case 8: case 15: case 16:
        if (!high)
            high = DEFAULT_SEGMENT_NODE(_SI);
        HIGH(result) = NEW_CODE_NODE(0x1B, 0, low, high);
        LOW(result) = NEW_CODE_NODE(0x16, 0, low, high);
        break;
    case 19: case 20:
        _ES = EXPR_POOL_SEG;
        _SI = ES_W(_SI, EXPR_LEFT);
        if (ES_W(_SI, EXPR_KIND) == 13) {
            LOW(result) = low;
            HIGH(result) = NEW_CODE_NODE(8, 0,
                SEGMENT_REGISTER_CODE(GET_TYPE_FLAGS_ALT_HOOK(ES_W(_SI, EXPR_TYPE))), 0);
        } else {
            _ES = EXPR_POOL_SEG;
            if (ES_W(_SI, EXPR_KIND) == 14) {
                HIGH(result) = low;
                LOW(result) = NEW_CONSTANT_NODE(10, 0L);
            } else {
                result = ((unsigned long)high << 16) | low;
            }
        }
        break;
    }
    return result;
}
#undef LOW
#undef HIGH

#pragma option -r
/* ---- STAOV067 (listing ovr_1d5e_a195:3AF9) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                           unsigned int, unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);
#define LOW(v) (((unsigned int near *)&(v))[0])
#define HIGH(v) (((unsigned int near *)&(v))[1])

/* GEN_DEREF_FAR_ADD_ASSIGN: for '*(p += n)' or '*(p -= n)' with a far pointer p, adds in
   place and returns a copy of p's new value as the address; returns low word 0 when
   'node' is not that shape (the high word is then left unset, as in the original). */
static unsigned long near pascal GEN_DEREF_FAR_ADD_ASSIGN(unsigned int node)
{
    unsigned long result;
    unsigned long left;
    unsigned long right;

    _SI = node;
    /* The original initializes only the low word on the no-emission path. */
    LOW(result) = 0;
    _ES = EXPR_POOL_SEG;
    if (ES_W(_SI, EXPR_KIND) != 15)
        return result;
    _ES = EXPR_POOL_SEG;
    if (ES_W(_SI, EXPR_OP) != 0x13 && ES_W(_SI, EXPR_OP) != 0x14)
        return result;
    _ES = EXPR_POOL_SEG;
    right = GENERATE_EXPRESSION(ES_W(_SI, EXPR_RIGHT), 1);
    _ES = EXPR_POOL_SEG;
    left = GENERATE_EXPRESSION(ES_W(_SI, EXPR_LEFT), 1);
    NEW_CODE_NODE(CODE_OP_FOR_NODE(_SI), 2, LOW(left), LOW(right));
    HIGH(result) = NEW_CODE_NODE(0x98, 0, HIGH(left), 0);
    LOW(result) = NEW_CODE_NODE(0x99, 0, LOW(left), 0);
    return result;
}
#undef LOW
#undef HIGH

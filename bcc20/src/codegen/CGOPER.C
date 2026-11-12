/* target: CODE_7_R7MAIN */
/* opts: -mm -G -O -Z -p -B */
/* Role: code generation: GENERATE_OPERATOR generates code for one operator node through the
   OPERATOR_RULES table, sending conversions to GENERATE_CONVERSION. Entry points:
   GENERATE_OPERATOR. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the table-driven core of expression code generation. GENERATE_EXPRESSION
   (CGEXPR.C) handles the special shapes itself and sends ordinary operator and leaf nodes
   here. GENERATE_OPERATOR generates the operands (binary operators 8..0x2D both, the left
   one first when EXPR_NODE_FLAGS is negative, see LABEL_REGISTER_NEED; unary operators
   0x2E..0x32 the left one), then looks up a rule number in OPERATOR_RULES
   (operator*21+value kind) and builds the code ops for that rule. Results are op pairs
   (EmissionPair, EMITMAIN.H): words.low the value or low word, words.high the high word
   or segment.
   Probable meanings of the code ops used: 0x1D/0x24 and 0x26/0x30 the low and high halves
   of a 32-bit add (ADD/ADC) and subtract (SUB/SBB), with COP_FLAGS 0x10 on the low half
   and 0x20 on the high half (2 added for in-place forms); 0x9B/0x9C MOV byte/word;
   0x97/0x98 a copy into a register; 0xAA/0xAB/0xAC zero extension, CBW and CWD; 0x45 SHL
   word; 0x51 NEG, 0x59 INC, 0x52 and 0x54 NOT; 0xB5 and 0xB6 load a 32-bit pair into DX:AX
   and CX:BX, 0xBD a count into CL, for run-time helper calls whose result comes back in
   AX (op 0xC2) and DX (op 0xC3). Register ops 8 with 13 and 15 are DS and SS, register op 7
   with 1 is AH. Helper names are near pointers into DS (0x3F5C probably __AHSHIFT, the
   huge-pointer segment step used when HUGE_PTR_AHSHIFT_MODE is set; 0x3F66..0x3F8A the
   huge-pointer and struct-copy helpers); 0x1055 and 0x1040 are probably the registers each
   helper call destroys. */
/* Complete main emitter, including its genuine 100-byte switch suffix. */
#include <dos.h>
#include "EMITMAIN.H"
#include "MSG.H"
#include "POOL.H"
#define PAYLOAD_WORD(n,o) (*(unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,(n)*4+(o)))
#define INSTRUCTION_FLAGS(n) (*(unsigned char far *)MK_FP(CODE_OP_POOL_SEG,(n)*4+1))

/* GENERATE_OPERATOR: generates operator or leaf node 'input' (casts, op 0x35, go to
   GENERATE_CONVERSION) and returns its result op pair packed in a long. Unknown rules
   report MSG_IRREDUCIBLE_EXPRESSION. */
unsigned long far pascal GENERATE_OPERATOR(unsigned int input)
{
    unsigned int chain;
    unsigned int child;
    EmissionPair left;
    EmissionPair right;
    unsigned int first;
    unsigned int second;
    EmissionPair result;
    EmissionPair pointer_operand;
    EmissionPair integer_operand;
    register unsigned int node=input;
    register unsigned int item;

    if(EXPR_W(node,EXPR_OP)==0x35)
        return GENERATE_CONVERSION(node);
    if((int)EXPR_W(node,EXPR_OP)>7 && (int)EXPR_W(node,EXPR_OP)<=0x2D) {
        if(EXPR_SC(node,EXPR_NODE_FLAGS)<0) {
            left.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
            right.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),1);
        } else {
            right.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),1);
            left.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
        }
    } else if((int)EXPR_W(node,EXPR_OP)>0x2D && (int)EXPR_W(node,EXPR_OP)<=EOP_ADDR)
        left.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
    result.words.low=result.words.high=0;
    switch(OPERATOR_RULES[EXPR_W(node,EXPR_OP)*21+EXPR_W(node,EXPR_KIND)]) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        /* fall through */
    /* Leaves. 2: a variable, as a leaf op of its kind; when EXPR_QUAL_FLAGS has 0x10 it is
       read indirectly through its offset (op 13) and segment (op 12). 3: a 32-bit variable,
       two words (the high word at offset +2). 4: a register pseudo-variable (_AX and the
       like; SYMBOL_INDEX_HOOK gives the register, 0xFFFF for _FLAGS, which is read by
       PUSHF): a register op 7 (byte) or 8 (word), and the register is marked used. 5: the far
       address of a static (offset and segment). 6-8: integer, long and floating constants.
       9: the far address of a stack variable (offset and SS). */
    case 2:
        if(EXPR_W(node,EXPR_QUAL_FLAGS)&0x10) {
            first=NEW_VARIABLE_NODE(0x0D,EXPR_W(node,EXPR_LEFT),EXPR_W(node,EXPR_RIGHT),EXPR_B(node,EXPR_QUAL_FLAGS));
            second=NEW_VARIABLE_NODE(0x0C,EXPR_W(node,EXPR_LEFT),0,EXPR_B(node,EXPR_QUAL_FLAGS));
            result.words.low=NEW_CODE_NODE(LEAF_OPCODE_KIND_OFFSET[EXPR_W(node,EXPR_KIND)]+0x15,0,first,second);
        } else
            result.words.low=NEW_VARIABLE_NODE(CODE_OP_FOR_NODE(node),EXPR_W(node,EXPR_LEFT),EXPR_W(node,EXPR_RIGHT),EXPR_B(node,EXPR_QUAL_FLAGS));
        break;
    case 3:
        if(EXPR_W(node,EXPR_QUAL_FLAGS)&0x10) {
            first=NEW_VARIABLE_NODE(0x0D,EXPR_W(node,EXPR_LEFT),EXPR_W(node,EXPR_RIGHT),EXPR_B(node,EXPR_QUAL_FLAGS));
            second=NEW_VARIABLE_NODE(0x0C,EXPR_W(node,EXPR_LEFT),0,EXPR_B(node,EXPR_QUAL_FLAGS));
            result.words.high=NEW_CODE_NODE(0x1B,0,first,second);
            result.words.low=NEW_CODE_NODE(0x16,0,first,second);
        } else {
            result.words.high=NEW_VARIABLE_NODE(0x11,EXPR_W(node,EXPR_LEFT),EXPR_W(node,EXPR_RIGHT)+2,EXPR_B(node,EXPR_QUAL_FLAGS));
            result.words.low=NEW_PLAIN_CODE_NODE(0x10,PAYLOAD_WORD(result.words.high,OPND_LEFT),EXPR_W(node,EXPR_RIGHT));
        }
        break;
    case 4:
        first=SYMBOL_INDEX_HOOK(EXPR_W(node,EXPR_LEFT));
        /* Original BC20/8086 count behavior: the low-byte shift precedes the
           FFFF sentinel test, including count FF; this is target dependent. */
        CODEGEN_USED_REG_MASK|=1U<<(unsigned char)first;
        if(first==0xFFFF)
            result.words.low=NEW_CODE_NODE(0x73,0,0,0);
        else if((int)EXPR_W(node,EXPR_KIND)<=TK_UCHAR)
            result.words.low=NEW_CODE_NODE(7,0,first,0);
        else
            result.words.low=NEW_CODE_NODE(8,0,first,0);
        break;
    case 5:
        result.words.low=NEW_VARIABLE_NODE(0x0D,EXPR_W(node,EXPR_LEFT),EXPR_W(node,EXPR_RIGHT),EXPR_B(node,EXPR_QUAL_FLAGS));
        result.words.high=NEW_VARIABLE_NODE(0x0C,EXPR_W(node,EXPR_LEFT),0,EXPR_B(node,EXPR_QUAL_FLAGS));
        break;
    case 6:
        result.words.low=NEW_CONSTANT_NODE(CODE_OP_FOR_NODE(node),EXPR_UL(node,EXPR_VALUE));
        break;
    case 7:
        result.words.high=NEW_CONSTANT_NODE(0x0A,(long)(int)EXPR_W(node,EXPR_RIGHT));
        result.words.low=NEW_CONSTANT_NODE(0x0A,EXPR_UL(node,EXPR_VALUE));
        break;
    case 8:
        result.words.low=EMIT_FLOAT_CONSTANT(node);
        break;
    case 9:
        result.words.low=NEW_VARIABLE_NODE(0x0D,EXPR_W(node,EXPR_LEFT),EXPR_W(node,EXPR_RIGHT),EXPR_B(node,EXPR_QUAL_FLAGS));
        result.words.high=NEW_CODE_NODE(8,0,0x0F,0);
        break;
    /* Arithmetic. 10: one op for the whole value. 11: 32-bit add. 12: 8087 operation. 13: an
       op working in place on its left operand. 14: an op on the low words that keeps
       whichever operand's high word exists (probably far pointer plus integer). 15: huge
       pointer plus or minus an integer, inline with __AHSHIFT or through a helper. 16: 32-bit
       subtract. 17: op 0x32 (probably multiply); on the 8086 the operands are swapped when
       the right one was generated first. 18: a 32-bit operation through a helper chosen by
       EMIT_OPERATOR_HELPER. 19-21: division and remainder: DX is filled by CWD (signed) or
       set to 0 (unsigned), then the divide op. 22: 32-bit shift through a helper (count in
       CL). 23: shifts (OPER_OPCODE_KIND_OFFSET + 0x48). 24: a bitwise op on both words. */
    case 10:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,left.words.low,right.words.low);
        break;
    case 11:
        result.words.low=NEW_CODE_NODE(0x1D,0x10,left.words.low,right.words.low);
        result.words.high=NEW_CODE_NODE(0x24,0x20,left.words.high,right.words.high);
        break;
    case 12:
        result.words.low=GEN_FPU_BINARY_OP(node,left.words.low,right.words.low);
        break;
    case 13:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),2,left.words.low,right.words.low);
        break;
    case 14:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,left.words.low,right.words.low);
        if(left.words.high) {
            result.words.high=left.words.high;
            break;
        }
        result.words.high=right.words.high;
        break;
    case 15:
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND)==TK_HUGE_PTR) {
            pointer_operand.value=left.value;
            integer_operand.value=right.value;
        } else {
            EXPR_SC(node,EXPR_NODE_FLAGS)=-EXPR_SC(node,EXPR_NODE_FLAGS);
            pointer_operand.value=right.value;
            integer_operand.value=left.value;
        }
        if(HUGE_PTR_AHSHIFT_MODE) {
            first=NEW_CONSTANT_NODE(0x0A,0UL);
            if(EXPR_W(node,EXPR_OP)==EOP_ADD) {
                result.words.low=NEW_CODE_NODE(0x1D,0x10,integer_operand.words.low,pointer_operand.words.low);
                item=NEW_CODE_NODE(0x24,0x20,integer_operand.words.high,first);
                second=NEW_VARIABLE_NODE(0x0D,DECLARE_NAMED_GLOBAL_HOOK((char near *)0x3F5C,1),0,0x10);
                item=NEW_CODE_NODE(0x45,0,item,second);
                result.words.high=NEW_CODE_NODE(0x1F,0,item,pointer_operand.words.high);
            } else {
                result.words.low=NEW_CODE_NODE(0x26,0x10,pointer_operand.words.low,integer_operand.words.low);
                item=NEW_CODE_NODE(0x24,0x20,integer_operand.words.high,first);
                second=NEW_VARIABLE_NODE(0x0D,DECLARE_NAMED_GLOBAL_HOOK((char near *)0x3F5C,1),0,0x10);
                item=NEW_CODE_NODE(0x45,0,item,second);
                result.words.high=NEW_CODE_NODE(0x28,0,pointer_operand.words.high,item);
            }
        } else {
            if(EXPR_SC(node,EXPR_NODE_FLAGS)<0) {
                NEW_CODE_NODE(0xB6,0,integer_operand.words.low,integer_operand.words.high);
                NEW_CODE_NODE(0xB5,0,pointer_operand.words.low,pointer_operand.words.high);
            } else {
                NEW_CODE_NODE(0xB5,0,pointer_operand.words.low,pointer_operand.words.high);
                NEW_CODE_NODE(0xB6,0,integer_operand.words.low,integer_operand.words.high);
            }
            EMIT_HELPER_CALL((char near *)(EXPR_W(node,EXPR_OP)==EOP_ADD?0x3F66:0x3F6C),0x1055);
            result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
            result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        }
        break;
    case 16:
        result.words.low=NEW_CODE_NODE(0x26,0x10,left.words.low,right.words.low);
        result.words.high=NEW_CODE_NODE(0x30,0x20,left.words.high,right.words.high);
        break;
    case 17:
        if(OPTION_TARGET_CPU==0 && EXPR_SC(node,EXPR_NODE_FLAGS)>0) {
            first=left.words.low;
            left.words.low=right.words.low;
            right.words.low=first;
        }
        result.words.low=NEW_CODE_NODE(0x32,0,left.words.low,right.words.low);
        break;
    case 18:
        if(EXPR_SC(node,EXPR_NODE_FLAGS)<0) {
            NEW_CODE_NODE(0xB5,0,right.words.low,right.words.high);
            NEW_CODE_NODE(0xB6,0,left.words.low,left.words.high);
        } else {
            NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
            NEW_CODE_NODE(0xB6,0,right.words.low,right.words.high);
        }
        EMIT_OPERATOR_HELPER(node);
        result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
        result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        break;
    case 19:
        NEW_CODE_NODE(0xAC,0x10,left.words.low,0);
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0x20,left.words.low,right.words.low);
        break;
    case 20:
        NEW_CODE_NODE(0xB5,0x10,0,NEW_CONSTANT_NODE(0x0A,0UL));
        result.words.low=NEW_CODE_NODE(0x3F,0x20,left.words.low,right.words.low);
        break;
    case 21:
        NEW_CODE_NODE(0xB5,0x10,0,NEW_CONSTANT_NODE(0x0A,0UL));
        result.words.low=NEW_CODE_NODE(0x41,0x20,left.words.low,right.words.low);
        break;
    case 22:
        if(EXPR_SC(node,EXPR_NODE_FLAGS)<0) {
            NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
            NEW_CODE_NODE(0xBD,0,right.words.low,0);
        } else {
            NEW_CODE_NODE(0xBD,0,right.words.low,0);
            NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
        }
        EMIT_OPERATOR_HELPER(node);
        result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
        result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        break;
    case 23:
        result.words.low=NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET[EXPR_W(node,EXPR_KIND)]+0x48,0,left.words.low,right.words.low);
        break;
    case 24:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,left.words.low,right.words.low);
        result.words.high=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,left.words.high,right.words.high);
        break;
    /* Assignments. 25: in-place op. 26: 32-bit store, two MOV words. 27: 8087 store. 28:
       32-bit +=. 29: in-place bitwise op on both words. 30: in-place op on the low word,
       high word unchanged. 31: huge pointer += and -=. 32: 32-bit -=. */
    case 25:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),2,left.words.low,right.words.low);
        break;
    case 26:
        result.words.high=NEW_CODE_NODE(0x9C,2,left.words.high,right.words.high);
        result.words.low=NEW_CODE_NODE(0x9C,2,left.words.low,right.words.low);
        break;
    case 27:
        result.words.low=FPU_STORE_NODE_6C(left.words.low,right.words.low);
        break;
    case 28:
        result.words.low=NEW_CODE_NODE(0x1D,0x12,left.words.low,right.words.low);
        result.words.high=NEW_CODE_NODE(0x24,0x22,left.words.high,right.words.high);
        break;
    case 29:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),2,left.words.low,right.words.low);
        result.words.high=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),2,left.words.high,right.words.high);
        break;
    case 30:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),2,left.words.low,right.words.low);
        result.words.high=left.words.high;
        break;
    case 31:
        if(HUGE_PTR_AHSHIFT_MODE) {
            first=NEW_CONSTANT_NODE(0x0A,0UL);
            if(EXPR_W(node,EXPR_OP)==EOP_ADD_ASSIGN) {
                result.words.low=NEW_CODE_NODE(0x1D,0x12,left.words.low,right.words.low);
                item=NEW_CODE_NODE(0x24,0x20,first,right.words.high);
            } else {
                result.words.low=NEW_CODE_NODE(0x26,0x12,left.words.low,right.words.low);
                item=NEW_CODE_NODE(0x30,0x20,first,right.words.high);
            }
            second=NEW_VARIABLE_NODE(0x0D,DECLARE_NAMED_GLOBAL_HOOK((char near *)0x3F5C,1),0,0x10);
            item=NEW_CODE_NODE(0x45,0,item,second);
            result.words.high=NEW_CODE_NODE(0x1F,2,left.words.high,item);
        } else {
            if(left.words.high==0)
                left.words.high=NEW_CODE_NODE(8,0,0x0D,0);
            if(EXPR_SC(node,EXPR_NODE_FLAGS)<0) {
                NEW_CODE_NODE(0xB6,0,right.words.low,right.words.high);
                NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
            } else {
                NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
                NEW_CODE_NODE(0xB6,0,right.words.low,right.words.high);
            }
            EMIT_HELPER_CALL((char near *)(EXPR_W(node,EXPR_OP)==EOP_SUB_ASSIGN?0x3F72:0x3F78),0x1055);
            result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
            result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        }
        break;
    case 32:
        result.words.low=NEW_CODE_NODE(0x26,0x12,left.words.low,right.words.low);
        result.words.high=NEW_CODE_NODE(0x30,0x22,left.words.high,right.words.high);
        break;
    /* 33-38: compound assignment on a byte (or word) done in a register: copy the target into
       a register, operate, store back with MOV; the target's 'written' flag (COP_FLAGS 4) is
       cleared because the store is a separate op. 35-38 widen a char first (CBW, or zero
       extension for unsigned with op 0x3E) for byte division; 36 and 38 take the remainder
       from AH (register op 7 with register 1). */
    case 33:
        first=NEW_CODE_NODE(0x97,0,left.words.low,0);
        right.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,first,right.words.low);
        result.words.low=NEW_CODE_NODE(0x9B,2,left.words.low,right.words.low);
        INSTRUCTION_FLAGS(left.words.low)&=0xFB;
        break;
    case 34:
        first=NEW_CODE_NODE(0x98,0,left.words.low,0);
        right.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,first,right.words.low);
        result.words.low=NEW_CODE_NODE(0x9C,2,left.words.low,right.words.low);
        INSTRUCTION_FLAGS(left.words.low)&=0xFB;
        break;
    case 35:
        first=NEW_CODE_NODE(0x97,0,left.words.low,0);
        first=NEW_CODE_NODE(0xAB,0x10,first,0);
        right.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0x20,first,right.words.low);
        result.words.low=NEW_CODE_NODE(0x9B,2,left.words.low,right.words.low);
        INSTRUCTION_FLAGS(left.words.low)&=0xFB;
        break;
    case 36:
        first=NEW_CODE_NODE(0x97,0,left.words.low,0);
        first=NEW_CODE_NODE(0xAB,0x10,first,0);
        right.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0x30,first,right.words.low);
        right.words.low=NEW_CODE_NODE(7,0,1,0);
        result.words.low=NEW_CODE_NODE(0x9B,2,left.words.low,right.words.low);
        INSTRUCTION_FLAGS(left.words.low)&=0xFB;
        break;
    case 37:
        first=NEW_CODE_NODE(0x97,0,left.words.low,0);
        first=NEW_CODE_NODE(0xAA,0,first,0);
        right.words.low=NEW_CODE_NODE(0x3E,0,first,right.words.low);
        result.words.low=NEW_CODE_NODE(0x9B,2,left.words.low,right.words.low);
        INSTRUCTION_FLAGS(left.words.low)&=0xFB;
        break;
    case 38:
        first=NEW_CODE_NODE(0x97,0,left.words.low,0);
        first=NEW_CODE_NODE(0xAA,0,first,0);
        right.words.low=NEW_CODE_NODE(0x3E,0,first,right.words.low);
        right.words.low=NEW_CODE_NODE(7,0,1,0);
        result.words.low=NEW_CODE_NODE(0x9B,2,left.words.low,right.words.low);
        INSTRUCTION_FLAGS(left.words.low)&=0xFB;
        break;
    /* 39: in-place shift. 40/41: the value of the left or right operand as it is. 42: SUB
       word. 43: pointer difference: huge pointers through a helper; otherwise the difference
       of the offsets as a long (high word 'SBB 0,0' of two zero constants). 44: a far pointer
       from a segment (left) and an offset (right). 45: unary op on a word. 46: 32-bit negate.
       47: op 0x52 on a word (probably NOT). 48: 32-bit complement. */
    case 39:
        result.words.low=NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET[EXPR_W(node,EXPR_KIND)]+0x48,2,left.words.low,right.words.low);
        break;
    case 40:
        result.value=left.value;
        break;
    case 41:
        result.value=right.value;
        break;
    case 42:
        result.words.low=NEW_CODE_NODE(0x28,0,left.words.low,right.words.low);
        break;
    case 43:
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND)==TK_HUGE_PTR) {
            if(EXPR_SC(node,EXPR_NODE_FLAGS)<0) {
                NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
                NEW_CODE_NODE(0xB6,0,right.words.low,right.words.high);
            } else {
                NEW_CODE_NODE(0xB6,0,right.words.low,right.words.high);
                NEW_CODE_NODE(0xB5,0,left.words.low,left.words.high);
            }
            EMIT_HELPER_CALL((char near *)(HUGE_PTR_AHSHIFT_MODE?0x3F7E:0x3F84),0x1055);
            result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
            result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        } else {
            first=NEW_CONSTANT_NODE(0x0A,0UL);
            item=NEW_CONSTANT_NODE(0x0A,0UL);
            result.words.low=NEW_CODE_NODE(0x26,0x10,left.words.low,right.words.low);
            result.words.high=NEW_CODE_NODE(0x30,0x20,first,item);
        }
        break;
    case 44:
        result.words.high=left.words.low;
        result.words.low=right.words.low;
        break;
    case 45:
        result.words.low=NEW_CODE_NODE(CODE_OP_FOR_NODE(node),0,left.words.low,0);
        break;
    case 46:
        second=NEW_CODE_NODE(0x51,0,left.words.high,0);
        result.words.low=NEW_CODE_NODE(0x51,0x10,left.words.low,0);
        item=NEW_CONSTANT_NODE(0x0A,0UL);
        result.words.high=NEW_CODE_NODE(0x30,0x20,second,item);
        break;
    case 47:
        result.words.low=NEW_CODE_NODE(0x52,0,left.words.low,0);
        break;
    case 48:
        result.words.low=NEW_CODE_NODE(0x54,0,left.words.low,0);
        result.words.high=NEW_CODE_NODE(0x54,0,left.words.high,0);
        break;
    /* 49: logical not: NEG sets the carry for a nonzero value, SBB x,x turns that into -1 or
       0, INC gives 0 or 1. */
    case 49:
        first=left.words.low;
        if((int)EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND)<=TK_UCHAR)
            first=NEW_CODE_NODE(0xAB,0,first,0);
        /* The original deliberately overwrites the temporary using left. */
        first=NEW_CODE_NODE(0x51,0x10,left.words.low,0);
        first=NEW_CODE_NODE(0x30,0x20,first,first);
        result.words.low=NEW_CODE_NODE(0x59,0,first,0);
        break;
    /* 50: struct copy through a helper: pushes the far addresses of the destination (SS and
       offset) and the source (DS and offset), puts the size in CX (op 0xB6), calls the helper
       named at DS:3F8A, which removes the 8 bytes of arguments itself (op 0xAE, no code). */
    case 50:
        chain=EXPR_W(node,EXPR_LEFT);
        NEW_CODE_NODE(0x94,0,NEW_CODE_NODE(8,0,0x0F,0),0);
        child=EXPR_W(chain,EXPR_LEFT);
        left.words.low=NEW_VARIABLE_NODE(0x0D,EXPR_W(child,EXPR_LEFT),EXPR_W(child,EXPR_RIGHT),EXPR_B(child,EXPR_QUAL_FLAGS));
        NEW_CODE_NODE(0x94,0,left.words.low,0);
        NEW_CODE_NODE(0x94,0,NEW_CODE_NODE(8,0,0x0D,0),0);
        chain=EXPR_W(chain,EXPR_RIGHT);
        right.words.low=NEW_VARIABLE_NODE(0x0D,EXPR_W(chain,EXPR_LEFT),EXPR_W(chain,EXPR_RIGHT),EXPR_B(chain,EXPR_QUAL_FLAGS));
        NEW_CODE_NODE(0x94,0,right.words.low,0);
        first=NEW_CONSTANT_NODE(0x0A,EXPR_UL(EXPR_W(node,EXPR_RIGHT),EXPR_VALUE));
        NEW_CODE_NODE(0xB6,0,0,first);
        EMIT_HELPER_CALL((char near *)0x3F8A,0x1040);
        NEW_CONSTANT_NODE(0xAE,8UL);
        break;
    case 51:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        break;
    }
    return result.value;
}

/* target: CODE_7_R7HELP */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: GENERATE_CONVERSION generates code for a type conversion node
   through the CONVERSION_RULES table. Entry points: GENERATE_CONVERSION. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: code for one conversion (cast) node. GENERATE_EXPRESSION (CGEXPR.C) or
   GENERATE_OPERATOR (CGOPER.C) sends conversion nodes here. The operand is generated
   first; then CONVERSION_RULES (a byte table, 17 value kinds by 17, indexed by
   source_kind*17+destination_kind, kinds as in KIND.H) gives the rule number, and each
   case builds the code ops that turn the operand into the result. A value is returned as
   a pair of op numbers (EmissionPair, EMIT7.H): words.low for the value or its low word,
   words.high for the high word of a long or the segment of a far pointer (0 when there is
   none). The rules seen here, probably: plain reuse (1, 9, 15: same or narrower integer);
   float narrowing through a memory temporary unless OPTION_FAST_FLOAT (2); sign extension
   with 0xAB (probably CBW) and 0xAC (probably CWD, high word in DX, op 0xC3) (3, 4, 10);
   zero extension with 0xAA and constant 0 high words (6, 7, 13); integer to 8087 by
   storing the words into FLOAT_TEMP_NODE temporaries and loading them with 0x5C/0x5D/0x5E
   (probably FILD word, dword, qword; unsigned values get a zero high part) (5, 8, 11, 12,
   14, 17, 18, 20); the high word only (16, far pointer to _seg); a near pointer made far
   with the segment register its type implies (19, SEGMENT_REGISTER_CODE); a _seg value
   made far with offset 0 (21); 8087 to integer through the run-time helper named at
   DS:3F91, result in AX (op 0xC2) and/or DX (op 0xC3) (22-24). Rule 0, 25 and unknown
   rules report MSG_IRREDUCIBLE_EXPRESSION. The 0x1055 passed to EMIT_HELPER_CALL is
   probably the mask of registers a helper call destroys (CGCALL.C and CGEXPR.C pass the
   same value). */
/* Conversion emitter, including its 50-byte compiler switch table. */
#include <dos.h>
#include "EMIT7.H"
#include "MSG.H"
#include "POOL.H"

/* GENERATE_CONVERSION: generates conversion node 'input' (its value kind EXPR_KIND, the
   operand EXPR_LEFT) and returns the result op pair packed in a long (low word: value or
   low half, high word: high half or 0). */
unsigned long near pascal GENERATE_CONVERSION(unsigned int input)
{
    unsigned int source_class;
    unsigned int destination_class;
    EmissionPair operand;
    EmissionPair result;
    register unsigned int node=input;
    register unsigned int temporary;

    destination_class=EXPR_W(node,EXPR_KIND);
    source_class=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND);
    operand.value=GENERATE_EXPRESSION(EXPR_W(node,EXPR_LEFT),1);
    result.words.low=result.words.high=0;
    switch(CONVERSION_RULES[source_class*17+destination_class]) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        /* fall through */
    case 1:
        result.value=operand.value;
        break;
    case 2:
        if(OPTION_FAST_FLOAT) {
            result.value=operand.value;
            break;
        }
        NEW_CODE_NODE(EXPR_W(node,EXPR_KIND)+0x61,2,FLOAT_TEMP_NODE(EXPR_W(node,EXPR_KIND),0),operand.words.low);
        result.words.low=FLOAT_TEMP_NODE(EXPR_W(node,EXPR_KIND),0);
        break;
    case 3:
        result.words.low=NEW_CODE_NODE(0xAB,0,operand.words.low,0);
        break;
    case 4:
        operand.words.low=NEW_CODE_NODE(0xAB,0,operand.words.low,0);
        result.words.low=NEW_CODE_NODE(0xAC,0x10,operand.words.low,0);
        result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        break;
    case 5:
        operand.words.low=NEW_CODE_NODE(0xAB,0,operand.words.low,0);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        result.words.low=NEW_CODE_NODE(0x5C,0,0,FLOAT_TEMP_NODE(3,0));
        break;
    case 6:
        result.words.low=NEW_CODE_NODE(0xAA,0,operand.words.low,0);
        break;
    case 7:
        operand.words.low=NEW_CODE_NODE(0xAA,0,operand.words.low,0);
        result.words.high=NEW_CONSTANT_NODE(0x0A,0UL);
        result.words.low=operand.words.low;
        break;
    case 8:
        operand.words.low=NEW_CODE_NODE(0xAA,0,operand.words.low,0);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        result.words.low=NEW_CODE_NODE(0x5C,0,0,FLOAT_TEMP_NODE(3,0));
        break;
    case 9:
        result.words.low=operand.words.low;
        break;
    case 10:
        result.words.low=NEW_CODE_NODE(0xAC,0x10,operand.words.low,0);
        result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        break;
    case 11:
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        result.words.low=NEW_CODE_NODE(0x5C,0,0,FLOAT_TEMP_NODE(3,0));
        break;
    case 12:
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,2),operand.words.low);
        temporary=NEW_CONSTANT_NODE(0x0A,0UL);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),temporary);
        result.words.low=NEW_CODE_NODE(0x5D,0,0,FLOAT_TEMP_NODE(7,0));
        break;
    case 13:
        result.words.high=NEW_CONSTANT_NODE(0x0A,0UL);
        result.words.low=operand.words.low;
        break;
    case 14:
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        temporary=NEW_CONSTANT_NODE(0x0A,0UL);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,2),temporary);
        result.words.low=NEW_CODE_NODE(0x5D,0,0,FLOAT_TEMP_NODE(7,0));
        break;
    case 15:
        result.words.low=operand.words.low;
        break;
    case 16:
        result.words.low=operand.words.high;
        break;
    case 17:
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,2),operand.words.high);
        result.words.low=NEW_CODE_NODE(0x5D,0,0,FLOAT_TEMP_NODE(7,0));
        break;
    case 18:
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,2),operand.words.high);
        temporary=NEW_CONSTANT_NODE(0x0A,0UL);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,4),temporary);
        temporary=NEW_CONSTANT_NODE(0x0A,0UL);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,6),temporary);
        result.words.low=NEW_CODE_NODE(0x5E,0,0,FLOAT_TEMP_NODE(0x0A,0));
        break;
    case 19:
        result.words.high=NEW_CODE_NODE(8,0,(int)(signed char)SEGMENT_REGISTER_CODE(GET_TYPE_FLAGS_ALT_HOOK(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE))),0);
        result.words.low=operand.words.low;
        break;
    case 20:
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,0),operand.words.low);
        temporary=NEW_CODE_NODE(8,0,(int)(signed char)SEGMENT_REGISTER_CODE(GET_TYPE_FLAGS_ALT_HOOK(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE))),0);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,2),temporary);
        temporary=NEW_CONSTANT_NODE(0x0A,0UL);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,4),temporary);
        temporary=NEW_CONSTANT_NODE(0x0A,0UL);
        NEW_CODE_NODE(0x9C,2,FLOAT_TEMP_NODE(3,6),temporary);
        result.words.low=NEW_CODE_NODE(0x5E,0,0,FLOAT_TEMP_NODE(0x0A,0));
        break;
    case 21:
        result.words.low=NEW_CONSTANT_NODE(0x0A,0UL);
        result.words.high=operand.words.low;
        break;
    case 22:
        NEW_CODE_NODE(0xB4,0,operand.words.low,0);
        EMIT_HELPER_CALL((char near *)0x3F91,0x1055);
        result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
        break;
    case 23:
        NEW_CODE_NODE(0xB4,0,operand.words.low,0);
        EMIT_HELPER_CALL((char near *)0x3F91,0x1055);
        result.words.low=NEW_CONSTANT_NODE(0xC3,0UL);
        break;
    case 24:
        NEW_CODE_NODE(0xB4,0,operand.words.low,0);
        EMIT_HELPER_CALL((char near *)0x3F91,0x1055);
        result.words.low=NEW_CONSTANT_NODE(0xC2,0UL);
        result.words.high=NEW_CONSTANT_NODE(0xC3,0UL);
        break;
    case 25:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        break;
    }
    return result.value;
}

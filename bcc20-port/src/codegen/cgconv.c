/* cgconv.c: from bcc20/src/codegen/CGCONV.C: code for one conversion (cast) node.  The
   operand is generated first; then CONVERSION_RULES (17 value kinds by 17, indexed by
   source*17+destination) gives the rule number, and each case builds the code ops that turn
   the operand into the result.  A value is a pair of op numbers packed in a long: the low
   word the value or its low word, the high word the high word of a long or the segment of a
   far pointer (0 when there is none).  The rules: plain reuse (1, 9, 15); float narrowing
   through a memory temporary unless OPTION_FAST_FLOAT (2); sign extension with ABh (CBW)
   and ACh (CWD, high word in DX, op C3h) (3, 4, 10); zero extension with AAh and constant
   0 high words (6, 7, 13); integer to 8087 by storing the words into FLOAT_TEMP_NODE
   temporaries and loading them with 5Ch/5Dh/5Eh (FILD word, dword, qword) (5, 8, 11, 12,
   14, 17, 18, 20); the high word only (16); a near pointer made far with the segment
   register its type implies (19); a _seg value made far with offset 0 (21); 8087 to
   integer through the run-time helper named at DS:3F91, result in AX (op C2h) and/or DX
   (op C3h) (22-24).  Rule 0, 25 and unknown rules are fatal errors.  1055h is the mask of
   registers a helper call destroys. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define LOW(pair) ((u16)(pair))
#define HIGH(pair) ((u16)((pair) >> 16))

/* the operand's segment register code as a register op */
static u16 segment_of(u16 node)
{
    u16 flags = (u16)CALL_FAR(GET_TYPE_FLAGS_ALT_HOOK, A16(EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_TYPE)));
    return NEW_CODE_NODE(8, 0, (u16)(i16)SEGMENT_REGISTER_CODE(flags), 0);
}

/* stores value into the integer temporary at offset */
static void store_temp(u16 offset, u16 value)
{
    u16 temp = FLOAT_TEMP_NODE(3, offset);
    NEW_CODE_NODE(0x9C, 2, temp, value);
}

/* generates conversion node input and returns the result op pair */
u32 GENERATE_CONVERSION(u16 input)
{
    u16 node = input;
    u16 destination = EXPR_W(node, EXPR_KIND);
    u16 source = EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_KIND);
    u32 operand = GENERATE_EXPRESSION(EXPR_W(node, EXPR_LEFT), 1);
    u16 low = 0, high = 0, value;
    switch (CONVERSION_RULES_AT(source * 17 + destination)) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        /* fall through */
    case 1:
        return operand;
    case 2:
        if (OPTION_FAST_FLOAT)
            return operand;
        NEW_CODE_NODE(EXPR_W(node, EXPR_KIND) + 0x61, 2, FLOAT_TEMP_NODE(EXPR_W(node, EXPR_KIND), 0), LOW(operand));
        low = FLOAT_TEMP_NODE(EXPR_W(node, EXPR_KIND), 0);
        break;
    case 3:
        low = NEW_CODE_NODE(0xAB, 0, LOW(operand), 0);
        break;
    case 4:
        value = NEW_CODE_NODE(0xAB, 0, LOW(operand), 0);
        low = NEW_CODE_NODE(0xAC, 0x10, value, 0);
        high = NEW_CONSTANT_NODE(0xC3, 0, 0);
        break;
    case 5:
        value = NEW_CODE_NODE(0xAB, 0, LOW(operand), 0);
        store_temp(0, value);
        low = NEW_CODE_NODE(0x5C, 0, 0, FLOAT_TEMP_NODE(3, 0));
        break;
    case 6:
        low = NEW_CODE_NODE(0xAA, 0, LOW(operand), 0);
        break;
    case 7:
        value = NEW_CODE_NODE(0xAA, 0, LOW(operand), 0);
        high = NEW_CONSTANT_NODE(0x0A, 0, 0);
        low = value;
        break;
    case 8:
        value = NEW_CODE_NODE(0xAA, 0, LOW(operand), 0);
        store_temp(0, value);
        low = NEW_CODE_NODE(0x5C, 0, 0, FLOAT_TEMP_NODE(3, 0));
        break;
    case 9:
    case 15:
        low = LOW(operand);
        break;
    case 10:
        low = NEW_CODE_NODE(0xAC, 0x10, LOW(operand), 0);
        high = NEW_CONSTANT_NODE(0xC3, 0, 0);
        break;
    case 11:
        store_temp(0, LOW(operand));
        low = NEW_CODE_NODE(0x5C, 0, 0, FLOAT_TEMP_NODE(3, 0));
        break;
    case 12:
        store_temp(2, LOW(operand));
        store_temp(0, NEW_CONSTANT_NODE(0x0A, 0, 0));
        low = NEW_CODE_NODE(0x5D, 0, 0, FLOAT_TEMP_NODE(7, 0));
        break;
    case 13:
        high = NEW_CONSTANT_NODE(0x0A, 0, 0);
        low = LOW(operand);
        break;
    case 14:
        store_temp(0, LOW(operand));
        store_temp(2, NEW_CONSTANT_NODE(0x0A, 0, 0));
        low = NEW_CODE_NODE(0x5D, 0, 0, FLOAT_TEMP_NODE(7, 0));
        break;
    case 16:
        low = HIGH(operand);
        break;
    case 17:
        store_temp(0, LOW(operand));
        store_temp(2, HIGH(operand));
        low = NEW_CODE_NODE(0x5D, 0, 0, FLOAT_TEMP_NODE(7, 0));
        break;
    case 18:
        store_temp(0, LOW(operand));
        store_temp(2, HIGH(operand));
        store_temp(4, NEW_CONSTANT_NODE(0x0A, 0, 0));
        store_temp(6, NEW_CONSTANT_NODE(0x0A, 0, 0));
        low = NEW_CODE_NODE(0x5E, 0, 0, FLOAT_TEMP_NODE(0x0A, 0));
        break;
    case 19:
        high = segment_of(node);
        low = LOW(operand);
        break;
    case 20:
        store_temp(0, LOW(operand));
        store_temp(2, segment_of(node));
        store_temp(4, NEW_CONSTANT_NODE(0x0A, 0, 0));
        store_temp(6, NEW_CONSTANT_NODE(0x0A, 0, 0));
        low = NEW_CODE_NODE(0x5E, 0, 0, FLOAT_TEMP_NODE(0x0A, 0));
        break;
    case 21:
        low = NEW_CONSTANT_NODE(0x0A, 0, 0);
        high = LOW(operand);
        break;
    case 22:
    case 23:
    case 24:
        NEW_CODE_NODE(0xB4, 0, LOW(operand), 0);
        EMIT_HELPER_CALL(FP_OFF(STR_FTOL_P), 0x1055);
        if (CONVERSION_RULES_AT(source * 17 + destination) != 23)
            low = NEW_CONSTANT_NODE(0xC2, 0, 0);
        if (CONVERSION_RULES_AT(source * 17 + destination) == 23)
            low = NEW_CONSTANT_NODE(0xC3, 0, 0);
        else if (CONVERSION_RULES_AT(source * 17 + destination) == 24)
            high = NEW_CONSTANT_NODE(0xC3, 0, 0);
        break;
    case 25:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        break;
    }
    return (u32)low | ((u32)high << 16);
}

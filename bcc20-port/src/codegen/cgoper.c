/* cgoper.c: from bcc20/src/codegen/CGOPER.C: the table-driven core of expression code
   generation.  GENERATE_EXPRESSION handles the special shapes itself and sends ordinary
   operator and leaf nodes here.  GENERATE_OPERATOR generates the operands (binary operators
   8..2Dh both, the left one first when EXPR_NODE_FLAGS is negative; unary operators
   2Eh..32h the left one), then looks up a rule number in OPERATOR_RULES (operator*21+value
   kind) and builds the code ops for that rule.  Results are op pairs packed in a long (low
   word the value or low word, high word the high word or segment).  Code ops: 1Dh/24h and
   26h/30h the low and high halves of a 32-bit add (ADD/ADC) and subtract (SUB/SBB), with
   COP_FLAGS 10h on the low half and 20h on the high half (2 added for in-place forms);
   9Bh/9Ch MOV byte/word; 97h/98h a copy into a register; AAh/ABh/ACh zero extension, CBW
   and CWD; 45h SHL word; 51h NEG, 59h INC, 52h and 54h NOT; B5h and B6h load a 32-bit pair
   into DX:AX and CX:BX, BDh a count into CL, for run-time helper calls whose result comes
   back in AX (op C2h) and DX (op C3h).  Register ops 8 with 13 and 15 are DS and SS,
   register op 7 with 1 is AH.  Helper names are near pointers into DS (3F5Ch __AHSHIFT;
   3F66h..3F8Ah the huge-pointer and struct-copy helpers); 1055h and 1040h are the registers
   each helper call destroys. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "exprop.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define LOW(pair) ((u16)(pair))
#define HIGH(pair) ((u16)((pair) >> 16))
#define OPTION_TARGET_CPU B(OPTION_TARGET_CPU_P)
#define HUGE_PTR_AHSHIFT_MODE SB(HUGE_PTR_AHSHIFT_MODE_P)
#define PAYLOAD_WORD(n, o) OPND_W((n) * 4, (o))
#define INSTRUCTION_FLAGS(n) COP_B((n) * 4, COP_FLAGS)
#define LEFT_OF(n) EXPR_W((n), EXPR_LEFT), EXPR_W((n), EXPR_RIGHT), EXPR_B((n), EXPR_QUAL_FLAGS)

static u16 constant(u8 kind, u32 value)
{
    return NEW_CONSTANT_NODE(kind, (u16)(value >> 16), (u16)value);
}

/* the variable node of __AHSHIFT, the huge-pointer segment step */
static u16 ahshift(void)
{
    u16 symbol = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(STR_AHSHIFT_2_P)), A16(1));
    return NEW_VARIABLE_NODE(0x0D, symbol, 0, 0x10);
}

/* loads two 32-bit pairs into DX:AX (B5h) and CX:BX (B6h) in the order the operands were
   generated: a pair first when first_flag */
static void load_pairs(u8 first_op, u32 first, u8 second_op, u32 second)
{
    NEW_CODE_NODE(first_op, 0, LOW(first), HIGH(first));
    NEW_CODE_NODE(second_op, 0, LOW(second), HIGH(second));
}

static u32 helper_result(void)
{
    u16 low = constant(0xC2, 0);
    u16 high = constant(0xC3, 0);
    return (u32)low | (u32)high << 16;
}

/* generates operator or leaf node input (casts go to GENERATE_CONVERSION) and returns its
   result op pair.  Unknown rules are fatal errors */
u32 GENERATE_OPERATOR(u16 input)
{
    u16 node = input;
    u32 left = 0, right = 0;
    u16 low = 0, high = 0, first, second, item;
    if (EXPR_W(node, EXPR_OP) == 0x35)
        return GENERATE_CONVERSION(node);
    i16 op = (i16)EXPR_W(node, EXPR_OP);
    if (op > 7 && op <= 0x2D) {
        if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0) {
            left = GENERATE_EXPRESSION(EXPR_W(node, EXPR_LEFT), 1);
            right = GENERATE_EXPRESSION(EXPR_W(node, EXPR_RIGHT), 1);
        } else {
            right = GENERATE_EXPRESSION(EXPR_W(node, EXPR_RIGHT), 1);
            left = GENERATE_EXPRESSION(EXPR_W(node, EXPR_LEFT), 1);
        }
    } else if (op > 0x2D && op <= EOP_ADDR)
        left = GENERATE_EXPRESSION(EXPR_W(node, EXPR_LEFT), 1);
    u16 left_low = LOW(left), left_high = HIGH(left), right_low = LOW(right), right_high = HIGH(right);
    switch (OPERATOR_RULES_AT(EXPR_W(node, EXPR_OP) * 21 + EXPR_W(node, EXPR_KIND))) {
    default:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        /* fall through */
    case 2:                     /* a variable, read indirectly when EXPR_QUAL_FLAGS has 10h */
        if (EXPR_W(node, EXPR_QUAL_FLAGS) & 0x10) {
            first = NEW_VARIABLE_NODE(0x0D, LEFT_OF(node));
            second = NEW_VARIABLE_NODE(0x0C, EXPR_W(node, EXPR_LEFT), 0, EXPR_B(node, EXPR_QUAL_FLAGS));
            low = NEW_CODE_NODE(LEAF_OPCODE_KIND_OFFSET_AT(EXPR_W(node, EXPR_KIND)) + 0x15, 0, first, second);
        } else
            low = NEW_VARIABLE_NODE((u8)CODE_OP_FOR_NODE(node), LEFT_OF(node));
        break;
    case 3:                     /* a 32-bit variable, two words */
        if (EXPR_W(node, EXPR_QUAL_FLAGS) & 0x10) {
            first = NEW_VARIABLE_NODE(0x0D, LEFT_OF(node));
            second = NEW_VARIABLE_NODE(0x0C, EXPR_W(node, EXPR_LEFT), 0, EXPR_B(node, EXPR_QUAL_FLAGS));
            high = NEW_CODE_NODE(0x1B, 0, first, second);
            low = NEW_CODE_NODE(0x16, 0, first, second);
        } else {
            high = NEW_VARIABLE_NODE(0x11, EXPR_W(node, EXPR_LEFT), (u16)(EXPR_W(node, EXPR_RIGHT) + 2), EXPR_B(node, EXPR_QUAL_FLAGS));
            low = NEW_PLAIN_CODE_NODE(0x10, PAYLOAD_WORD(high, OPND_LEFT), EXPR_W(node, EXPR_RIGHT));
        }
        break;
    case 4:                     /* a register pseudo-variable; FFFFh is _FLAGS (PUSHF) */
        first = (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(EXPR_W(node, EXPR_LEFT)));
        CODEGEN_USED_REG_MASK |= (u16)(1u << ((u8)first & 31));
        if (first == 0xFFFF)
            low = NEW_CODE_NODE(0x73, 0, 0, 0);
        else if ((i16)EXPR_W(node, EXPR_KIND) <= TK_UCHAR)
            low = NEW_CODE_NODE(7, 0, first, 0);
        else
            low = NEW_CODE_NODE(8, 0, first, 0);
        break;
    case 5:                     /* the far address of a static */
        low = NEW_VARIABLE_NODE(0x0D, LEFT_OF(node));
        high = NEW_VARIABLE_NODE(0x0C, EXPR_W(node, EXPR_LEFT), 0, EXPR_B(node, EXPR_QUAL_FLAGS));
        break;
    case 6:
        low = constant((u8)CODE_OP_FOR_NODE(node), EXPR_UL(node, EXPR_VALUE));
        break;
    case 7:
        high = constant(0x0A, (u32)(i32)(i16)EXPR_W(node, EXPR_RIGHT));
        low = constant(0x0A, EXPR_UL(node, EXPR_VALUE));
        break;
    case 8:
        low = EMIT_FLOAT_CONSTANT(node);
        break;
    case 9:                     /* the far address of a stack variable */
        low = NEW_VARIABLE_NODE(0x0D, LEFT_OF(node));
        high = NEW_CODE_NODE(8, 0, 0x0F, 0);
        break;
    case 10:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0, left_low, right_low);
        break;
    case 11:
        low = NEW_CODE_NODE(0x1D, 0x10, left_low, right_low);
        high = NEW_CODE_NODE(0x24, 0x20, left_high, right_high);
        break;
    case 12:
        low = GEN_FPU_BINARY_OP(node, left_low, right_low);
        break;
    case 13:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, left_low, right_low);
        break;
    case 14:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0, left_low, right_low);
        high = left_high ? left_high : right_high;
        break;
    case 15: {                  /* huge pointer plus or minus an integer */
        u32 pointer, integer;
        if (EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_KIND) == TK_HUGE_PTR) {
            pointer = left;
            integer = right;
        } else {
            EXPR_SC(node, EXPR_NODE_FLAGS) = (i8)-EXPR_SC(node, EXPR_NODE_FLAGS);
            pointer = right;
            integer = left;
        }
        if (HUGE_PTR_AHSHIFT_MODE) {
            first = constant(0x0A, 0);
            if (EXPR_W(node, EXPR_OP) == EOP_ADD) {
                low = NEW_CODE_NODE(0x1D, 0x10, LOW(integer), LOW(pointer));
                item = NEW_CODE_NODE(0x24, 0x20, HIGH(integer), first);
                second = ahshift();
                item = NEW_CODE_NODE(0x45, 0, item, second);
                high = NEW_CODE_NODE(0x1F, 0, item, HIGH(pointer));
            } else {
                low = NEW_CODE_NODE(0x26, 0x10, LOW(pointer), LOW(integer));
                item = NEW_CODE_NODE(0x24, 0x20, HIGH(integer), first);
                second = ahshift();
                item = NEW_CODE_NODE(0x45, 0, item, second);
                high = NEW_CODE_NODE(0x28, 0, HIGH(pointer), item);
            }
        } else {
            if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0)
                load_pairs(0xB6, integer, 0xB5, pointer);
            else
                load_pairs(0xB5, pointer, 0xB6, integer);
            EMIT_HELPER_CALL(EXPR_W(node, EXPR_OP) == EOP_ADD ? 0x3F66 : 0x3F6C, 0x1055);
            return helper_result();
        }
        break;
    }
    case 16:
        low = NEW_CODE_NODE(0x26, 0x10, left_low, right_low);
        high = NEW_CODE_NODE(0x30, 0x20, left_high, right_high);
        break;
    case 17:                    /* multiply; on the 8086 the operands swap when the right
                                   one was generated first */
        if (OPTION_TARGET_CPU == 0 && EXPR_SC(node, EXPR_NODE_FLAGS) > 0) {
            first = left_low;
            left_low = right_low;
            right_low = first;
        }
        low = NEW_CODE_NODE(0x32, 0, left_low, right_low);
        break;
    case 18:                    /* a 32-bit operation through a helper */
        if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0)
            load_pairs(0xB5, right, 0xB6, left);
        else
            load_pairs(0xB5, left, 0xB6, right);
        EMIT_OPERATOR_HELPER(node);
        return helper_result();
    case 19:                    /* signed division: CWD, then the divide op */
        NEW_CODE_NODE(0xAC, 0x10, left_low, 0);
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0x20, left_low, right_low);
        break;
    case 20:
    case 21:                    /* unsigned division and remainder: DX = 0 */
        NEW_CODE_NODE(0xB5, 0x10, 0, constant(0x0A, 0));
        low = NEW_CODE_NODE(OPERATOR_RULES_AT(EXPR_W(node, EXPR_OP) * 21 + EXPR_W(node, EXPR_KIND)) == 20 ? 0x3F : 0x41, 0x20, left_low, right_low);
        break;
    case 22:                    /* 32-bit shift through a helper (count in CL) */
        if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0) {
            NEW_CODE_NODE(0xB5, 0, left_low, left_high);
            NEW_CODE_NODE(0xBD, 0, right_low, 0);
        } else {
            NEW_CODE_NODE(0xBD, 0, right_low, 0);
            NEW_CODE_NODE(0xB5, 0, left_low, left_high);
        }
        EMIT_OPERATOR_HELPER(node);
        return helper_result();
    case 23:
        low = NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET_AT(EXPR_W(node, EXPR_KIND)) + 0x48, 0, left_low, right_low);
        break;
    case 24:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0, left_low, right_low);
        high = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0, left_high, right_high);
        break;
    case 25:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, left_low, right_low);
        break;
    case 26:
        high = NEW_CODE_NODE(0x9C, 2, left_high, right_high);
        low = NEW_CODE_NODE(0x9C, 2, left_low, right_low);
        break;
    case 27:
        low = FPU_STORE_NODE_6C(left_low, right_low);
        break;
    case 28:
        low = NEW_CODE_NODE(0x1D, 0x12, left_low, right_low);
        high = NEW_CODE_NODE(0x24, 0x22, left_high, right_high);
        break;
    case 29:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, left_low, right_low);
        high = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, left_high, right_high);
        break;
    case 30:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 2, left_low, right_low);
        high = left_high;
        break;
    case 31:                    /* huge pointer += and -= */
        if (HUGE_PTR_AHSHIFT_MODE) {
            first = constant(0x0A, 0);
            if (EXPR_W(node, EXPR_OP) == EOP_ADD_ASSIGN) {
                low = NEW_CODE_NODE(0x1D, 0x12, left_low, right_low);
                item = NEW_CODE_NODE(0x24, 0x20, first, right_high);
            } else {
                low = NEW_CODE_NODE(0x26, 0x12, left_low, right_low);
                item = NEW_CODE_NODE(0x30, 0x20, first, right_high);
            }
            second = ahshift();
            item = NEW_CODE_NODE(0x45, 0, item, second);
            high = NEW_CODE_NODE(0x1F, 2, left_high, item);
        } else {
            if (left_high == 0)
                left_high = NEW_CODE_NODE(8, 0, 0x0D, 0);
            if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0) {
                NEW_CODE_NODE(0xB6, 0, right_low, right_high);
                NEW_CODE_NODE(0xB5, 0, left_low, left_high);
            } else {
                NEW_CODE_NODE(0xB5, 0, left_low, left_high);
                NEW_CODE_NODE(0xB6, 0, right_low, right_high);
            }
            EMIT_HELPER_CALL(EXPR_W(node, EXPR_OP) == EOP_SUB_ASSIGN ? 0x3F72 : 0x3F78, 0x1055);
            return helper_result();
        }
        break;
    case 32:
        low = NEW_CODE_NODE(0x26, 0x12, left_low, right_low);
        high = NEW_CODE_NODE(0x30, 0x22, left_high, right_high);
        break;
    case 33:
    case 34:
    case 35:
    case 36:
    case 37:
    case 38: {
        /* compound assignment on a byte (or word) done in a register: copy the target into a
           register, operate, store back with MOV; the target's written flag is cleared.  35-38
           widen a char first (CBW, or zero extension with op 3Eh) for byte division; 36 and
           38 take the remainder from AH */
        u8 rule = OPERATOR_RULES_AT(EXPR_W(node, EXPR_OP) * 21 + EXPR_W(node, EXPR_KIND));
        first = NEW_CODE_NODE(rule == 34 ? 0x98 : 0x97, 0, left_low, 0);
        if (rule == 35 || rule == 36)
            first = NEW_CODE_NODE(0xAB, 0x10, first, 0);
        else if (rule == 37 || rule == 38)
            first = NEW_CODE_NODE(0xAA, 0, first, 0);
        if (rule == 37 || rule == 38)
            right_low = NEW_CODE_NODE(0x3E, 0, first, right_low);
        else
            right_low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), rule == 35 ? 0x20 : rule == 36 ? 0x30 : 0, first, right_low);
        if (rule == 36 || rule == 38)
            right_low = NEW_CODE_NODE(7, 0, 1, 0);
        low = NEW_CODE_NODE(rule == 34 ? 0x9C : 0x9B, 2, left_low, right_low);
        INSTRUCTION_FLAGS(left_low) &= 0xFB;
        break;
    }
    case 39:
        low = NEW_CODE_NODE(OPER_OPCODE_KIND_OFFSET_AT(EXPR_W(node, EXPR_KIND)) + 0x48, 2, left_low, right_low);
        break;
    case 40:
        return left;
    case 41:
        return right;
    case 42:
        low = NEW_CODE_NODE(0x28, 0, left_low, right_low);
        break;
    case 43:                    /* pointer difference */
        if (EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_KIND) == TK_HUGE_PTR) {
            if (EXPR_SC(node, EXPR_NODE_FLAGS) < 0)
                load_pairs(0xB5, left, 0xB6, right);
            else
                load_pairs(0xB6, right, 0xB5, left);
            EMIT_HELPER_CALL(HUGE_PTR_AHSHIFT_MODE ? 0x3F7E : 0x3F84, 0x1055);
            return helper_result();
        }
        first = constant(0x0A, 0);
        item = constant(0x0A, 0);
        low = NEW_CODE_NODE(0x26, 0x10, left_low, right_low);
        high = NEW_CODE_NODE(0x30, 0x20, first, item);
        break;
    case 44:                    /* a far pointer from a segment and an offset */
        high = left_low;
        low = right_low;
        break;
    case 45:
        low = NEW_CODE_NODE(CODE_OP_FOR_NODE(node), 0, left_low, 0);
        break;
    case 46:                    /* 32-bit negate */
        second = NEW_CODE_NODE(0x51, 0, left_high, 0);
        low = NEW_CODE_NODE(0x51, 0x10, left_low, 0);
        item = constant(0x0A, 0);
        high = NEW_CODE_NODE(0x30, 0x20, second, item);
        break;
    case 47:
        low = NEW_CODE_NODE(0x52, 0, left_low, 0);
        break;
    case 48:
        low = NEW_CODE_NODE(0x54, 0, left_low, 0);
        high = NEW_CODE_NODE(0x54, 0, left_high, 0);
        break;
    case 49:                    /* logical not: NEG, SBB x,x, INC; the CBW made for a char is
                                   overwritten, as the original does */
        if ((i16)EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_KIND) <= TK_UCHAR)
            NEW_CODE_NODE(0xAB, 0, left_low, 0);
        first = NEW_CODE_NODE(0x51, 0x10, left_low, 0);
        first = NEW_CODE_NODE(0x30, 0x20, first, first);
        low = NEW_CODE_NODE(0x59, 0, first, 0);
        break;
    case 50: {                  /* struct copy through a helper */
        u16 chain = EXPR_W(node, EXPR_LEFT);
        NEW_CODE_NODE(0x94, 0, NEW_CODE_NODE(8, 0, 0x0F, 0), 0);
        u16 child = EXPR_W(chain, EXPR_LEFT);
        left_low = NEW_VARIABLE_NODE(0x0D, LEFT_OF(child));
        NEW_CODE_NODE(0x94, 0, left_low, 0);
        NEW_CODE_NODE(0x94, 0, NEW_CODE_NODE(8, 0, 0x0D, 0), 0);
        chain = EXPR_W(chain, EXPR_RIGHT);
        right_low = NEW_VARIABLE_NODE(0x0D, LEFT_OF(chain));
        NEW_CODE_NODE(0x94, 0, right_low, 0);
        first = constant(0x0A, EXPR_UL(EXPR_W(node, EXPR_RIGHT), EXPR_VALUE));
        NEW_CODE_NODE(0xB6, 0, 0, first);
        EMIT_HELPER_CALL(FP_OFF(STR_SCOPY_2_P), 0x1040);
        constant(0xAE, 8);
        break;
    }
    case 51:
        REPORT_FATAL(MSG_IRREDUCIBLE_EXPRESSION);
        break;
    }
    return (u32)low | (u32)high << 16;
}

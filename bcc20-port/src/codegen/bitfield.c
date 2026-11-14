/* bitfield.c: from bcc20/src/codegen/BITFIELD.C: code for bit-field accesses, called from
   GENERATE_EXPRESSION for a bit-field node (EXPR_OP 33h: EXPR_LEFT the containing storage
   unit, EXPR_BIT_SHIFT the bit offset, EXPR_BIT_WIDTH the width).  A field that fits in the
   low byte (shift+width <= 8) is accessed as a char, otherwise as an int.  Loading extracts
   the field with shifts (signed: left to the top, then arithmetic right) or shift and mask
   (unsigned kinds, EXPR_FLAGS 20h).  Storing clears the field with AND and sets it with OR;
   increments read, add, mask and merge.  Results are an op pair packed in a long (low word
   the value's op; high word 0).  Code ops: 45h SHL, 47h SHR, 49h SAR, 4Ah/4Bh AND
   byte/word, 4Ch/4Dh OR byte/word, 1Fh ADD, 28h SUB, 98h a copy into a register, constants
   9 (byte, also shift counts) and 10 (word).  COP_FLAGS 2 on an AND/OR means it works on
   its left operand in place. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "exprop.h"
#include "kind.h"
#include "protos.h"
#include "calls.h"

#define LOW(pair) ((u16)(pair))
#define WITH_LOW(pair, low) (((pair) & 0xFFFF0000u) | (u16)(low))

/* a constant op of kind holding value (sign-extended to a long as the int it is) */
static u16 constant(u8 kind, i32 value)
{
    return NEW_CONSTANT_NODE(kind, (u16)((u32)value >> 16), (u16)value);
}

/* the value of bit-field node input.  Retypes the storage-unit node to char or int first,
   then generates it and isolates the field */
i32 GENERATE_BITFIELD_LOAD(u16 input)
{
    i16 shift = EXPR_SC(input, EXPR_BIT_SHIFT), width = EXPR_SC(input, EXPR_BIT_WIDTH), mask;
    u16 node = EXPR_W(input, EXPR_LEFT);
    if (shift + width <= 8) {
        EXPR_W(node, EXPR_KIND) = 1;
        mask = 255;
    } else {
        EXPR_W(node, EXPR_KIND) = 5;
        mask = -1;
    }
    u32 value = GENERATE_EXPRESSION(node, 1);
    if (!(EXPR_FLAGS_AT(EXPR_W(input, EXPR_KIND)) & 32)) {
        i16 amount = (i16)(16 - (shift + width));
        if (amount)
            value = WITH_LOW(value, NEW_SHIFT_NODE(LOW(value), 0x45, amount));
        amount = (i16)(16 - width);
        if (amount)
            value = WITH_LOW(value, NEW_SHIFT_NODE(LOW(value), 0x49, amount));
    } else {
        i16 amount = (i16)((1 << width) - 1);
        if (shift)
            value = WITH_LOW(value, NEW_SHIFT_NODE(LOW(value), 0x47, shift));
        u16 c = constant(10, (i16)(amount & mask));
        value = WITH_LOW(value, NEW_CODE_NODE(0x4B, 0, LOW(value), c));
    }
    return (i32)value;
}

/* dest = source for bit-field node dest; keep non-zero means the assigned value is needed
   as the result (it is then returned, masked to the field width; otherwise the result's
   low word is whatever the original's stack held).  A one-bit field set from a constant
   becomes a single OR or AND; a constant source is shifted at compile time; other sources
   are masked, shifted into place and ORed in after the field is cleared */
u32 GENERATE_BITFIELD_STORE(u16 dest, u16 source, u16 keep)
{
    i16 shift = EXPR_SC(dest, EXPR_BIT_SHIFT), width = EXPR_SC(dest, EXPR_BIT_WIDTH);
    i16 mask = (i16)((1 << width) - 1), clear = (i16)~(mask << shift);
    u8 type, orop, andop;
    u16 result = 0, first = 0;
    u8 result_set = 0;
    if (shift + width <= 8) {
        EXPR_W(EXPR_W(dest, EXPR_LEFT), EXPR_KIND) = TK_CHAR;
        type = 9;
        orop = 0x4C;
        andop = 0x4A;
        clear &= 0xFF;
        mask &= 0xFF;
    } else {
        type = 10;
        orop = 0x4D;
        andop = 0x4B;
    }
    if (width == 1 && EXPR_W(source, EXPR_OP) == EOP_CONST) {
        u16 second = LOW(GENERATE_EXPRESSION(EXPR_W(dest, EXPR_LEFT), 1));
        EXPR_L(source, EXPR_VALUE) &= 1;
        if (EXPR_L(source, EXPR_VALUE)) {
            u16 temp = constant(type, (i16)(1 << shift));
            NEW_CODE_NODE(orop, 2, second, temp);
        } else {
            u16 temp = constant(type, clear);
            NEW_CODE_NODE(andop, 2, second, temp);
        }
        result = constant(10, EXPR_L(source, EXPR_VALUE));
        result_set = 1;
    } else {
        if (EXPR_W(source, EXPR_OP) != EOP_CONST) {
            first = LOW(GENERATE_EXPRESSION(source, 1));
            first = NEW_CODE_NODE(0x4B, 0, first, constant(10, mask));
        }
        u16 second = LOW(GENERATE_EXPRESSION(EXPR_W(dest, EXPR_LEFT), 1));
        u16 temp = constant(type, clear);
        NEW_CODE_NODE(andop, 2, second, temp);
        if (EXPR_W(source, EXPR_OP) == EOP_CONST) {
            EXPR_L(source, EXPR_VALUE) &= (i32)mask;
            i16 bits = (i16)(EXPR_W(source, EXPR_LEFT) << shift);
            if (bits) {
                first = constant(type, bits);
                NEW_CODE_NODE(orop, 2, second, first);
            }
            if (keep) {
                result = constant(10, EXPR_L(source, EXPR_VALUE));
                result_set = 1;
            }
        } else {
            if (keep) {
                result = NEW_CODE_NODE(0x98, 0, first, 0);
                result_set = 1;
            }
            first = NEW_SHIFT_NODE(first, 0x45, shift);
            NEW_CODE_NODE(orop, 2, second, first);
        }
    }
    if (!result_set)
        UNSET_RETURN(1);
    return result;
}

/* compound assignment to a bit-field: rewritten into field = field op value and generated
   normally; second is the keep-result flag */
u32 GENERATE_BITFIELD_OP_ASSIGN(u16 first, u16 second)
{
    u16 node = (u16)CALL_FAR(EXPAND_COMPOUND_ASSIGN_HOOK, A16(first));
    return UNSET_PASS(GENERATE_EXPRESSION(node, second));
}

/* x++ or x-- (EXPR_OP 23h/24h; 19/20 are += and -=) on a bit-field.  When the storage
   unit's address has side effects the node is rewritten through the hooks instead, so the
   address is evaluated once.  Otherwise: copy the unit, add or subtract 1<<shift, mask to
   the field, clear the field in memory, OR the new bits in.  With keep, the result is the
   old value (postfix) or the new one, extracted as GENERATE_BITFIELD_LOAD does (without
   keep the result's low word is whatever the original's stack held) */
u32 GENERATE_BITFIELD_INC_DEC(u16 node, u16 keep)
{
    u16 field = EXPR_W(node, EXPR_LEFT);
    u16 child = EXPR_W(field, EXPR_LEFT);
    if ((u8)CALL_FAR(TREE_HAS_SIDE_EFFECTS_HOOK, A16(child))) {
        u16 rewritten;
        if (EXPR_W(node, EXPR_OP) == 19 || EXPR_W(node, EXPR_OP) == 20)
            rewritten = (u16)CALL_FAR(EXPAND_COMPOUND_ASSIGN_HOOK, A16(node));
        else
            rewritten = (u16)CALL_FAR(EXPAND_INC_DEC_HOOK, A16(node));
        return GENERATE_EXPRESSION(rewritten, keep);
    }
    i16 value = (i16)(1 << EXPR_SC(field, EXPR_BIT_SHIFT));
    u16 operand = LOW(GENERATE_EXPRESSION(child, 1));
    u16 mask = (u16)(((1 << EXPR_SC(field, EXPR_BIT_WIDTH)) - 1) << EXPR_SC(field, EXPR_BIT_SHIFT));
    u16 result = 0;
    u16 temp = NEW_CODE_NODE(0x98, 0, operand, 0);
    if (keep && (i16)EXPR_W(node, EXPR_OP) > 20)
        result = NEW_CODE_NODE(0x98, 0, temp, 0);
    u16 op = EXPR_W(node, EXPR_OP) == 0x23 || EXPR_W(node, EXPR_OP) == 19 ? 0x1F : 0x28;
    temp = NEW_CODE_NODE(op, 0, temp, constant(10, value));
    temp = NEW_CODE_NODE(0x4B, 0, temp, constant(10, (i32)mask));
    operand = LOW(GENERATE_EXPRESSION(child, 1));
    NEW_CODE_NODE(0x4B, 2, operand, constant(10, (i32)(u16)~mask));
    operand = LOW(GENERATE_EXPRESSION(child, 1));
    NEW_CODE_NODE(0x4D, 2, operand, temp);
    if (!keep) {
        UNSET_RETURN(1);
        return 0;
    }
    if ((i16)EXPR_W(node, EXPR_OP) <= 20)
        result = temp;
    if (EXPR_FLAGS_AT(EXPR_W(field, EXPR_KIND)) & 0x20) {
        value = (i16)((1 << EXPR_SC(field, EXPR_BIT_WIDTH)) - 1);
        result = NEW_SHIFT_NODE(result, 0x47, EXPR_SC(field, EXPR_BIT_SHIFT));
        result = NEW_CODE_NODE(0x4B, 0, result, constant(10, value));
    } else {
        value = (i16)(16 - (EXPR_SC(field, EXPR_BIT_SHIFT) + EXPR_SC(field, EXPR_BIT_WIDTH)));
        result = NEW_SHIFT_NODE(result, 0x45, value);
        value = (i16)(16 - EXPR_SC(field, EXPR_BIT_WIDTH));
        result = NEW_SHIFT_NODE(result, 0x49, value);
    }
    return result;
}

/* op start shifted by shift op value (45h, 47h or 49h) by flag bits, or start itself when
   flag is 0 */
u16 NEW_SHIFT_NODE(u16 start, u16 value, i16 flag)
{
    if (flag == 0)
        return start;
    return NEW_CODE_NODE(value, 0, start, constant(9, flag));
}

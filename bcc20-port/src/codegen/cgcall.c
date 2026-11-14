/* cgcall.c: from bcc20/src/codegen/CGCALL.C: code ops for a function call node.
   GENERATE_CALL first offers the call to GENERATE_INTRINSIC_CALL; otherwise it pushes the
   arguments, emits the call and the stack clean-up, and returns the result op pair (the
   value in AX, the high word or segment in DX for longs and far pointers (op C3h), floating
   results on the 8087 stack (op B3h)).  Arguments come as a left-leaning chain of EXPR_OP
   2Bh nodes.  Each argument is pushed as whole words (two pushes for longs and far
   pointers, high word first; 8087 values and structs through SAVEREGS.C helpers), and the
   bytes pushed are counted.  CALL_KIND_HOOK and CALL_ARG_SPLIT_HOOK describe the callee:
   kind 1 a plain call whose arguments the caller removes, kind 4 an interrupt function
   (PUSHF, op 73h, before the call); for other kinds part of the argument list, chosen by
   CALL_ARG_SPLIT_COUNT, is pushed in the opposite order and removed by the callee (the
   pascal convention).  Code ops: 94h PUSH word (93h for a char), 77h/78h near/far direct
   call, 75h near and 76h far indirect call, ADh ADD SP,n after the call, AEh a no-code
   record of bytes the callee pops.  The constant ops 6 and 5 with 1055h emit no code (the
   mask of registers a call destroys). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "protos.h"
#include "calls.h"

#define LOW(pair) ((u16)(pair))
#define HIGH(pair) ((u16)((pair) >> 16))

static u16 constant(u8 kind, i32 value)
{
    return NEW_CONSTANT_NODE(kind, (u16)((u32)value >> 16), (u16)value);
}

static void push(u16 value)
{
    NEW_CODE_NODE(0x94, 0, value, 0);
}

/* generates call node input (EXPR_LEFT the function, EXPR_RIGHT the argument chain) and
   returns its result op pair; other is passed on to the intrinsic generator */
i32 GENERATE_CALL(u16 input, u16 other)
{
    i32 intrinsic = GENERATE_INTRINSIC_CALL(input, other);
    if (LOW(intrinsic) != 0)
        return intrinsic;
    i16 kind = (i16)CALL_FAR(CALL_KIND_HOOK, A16(EXPR_W(EXPR_W(input, EXPR_LEFT), EXPR_TYPE)));
    CALL_ARG_SPLIT_COUNT = (i16)CALL_FAR(CALL_ARG_SPLIT_HOOK, A16(EXPR_W(EXPR_W(input, EXPR_LEFT), EXPR_TYPE)));
    i16 count1 = 0, count2 = 0;
    u16 value = EXPR_W(input, EXPR_RIGHT), child = 0;
    constant(6, 0x1055);
    if (EXPR_W(input, EXPR_RIGHT) != 0) {
        if (kind != 1) {
            child = SPLIT_ARG_LIST_BY_COUNT(value);
            if (CALL_ARG_SPLIT_COUNT < 0) {
                if (EXPR_W(child, EXPR_OP) == 0x2B) {
                    u16 saved = child;
                    child = EXPR_W(saved, EXPR_LEFT);
                    EXPR_W(saved, EXPR_LEFT) = 0;
                } else
                    child = 0;
            } else
                value = 0;
        }
        count1 = (i16)(count1 + PUSH_ARGUMENT_LIST(value));
        count2 = (i16)(count2 + PUSH_ARGUMENT_CHAIN(child));
    }
    u16 low = EMIT_CALL_INSTRUCTION(EXPR_W(input, EXPR_LEFT)), high = 0;
    switch (EXPR_W(input, EXPR_KIND)) {
    case TK_LONG: case TK_ULONG: case TK_FAR_PTR: case TK_HUGE_PTR:
        high = constant(0xC3, 0);
        break;
    case TK_FLOAT: case TK_DOUBLE: case TK_LDOUBLE:
        low = NEW_CODE_NODE(0xB3, 0, 0, 0);
        break;
    }
    if (count2)
        constant(0xAE, count2);
    if (count1)
        constant(0xAD, count1);
    return (i32)((u32)low | (u32)high << 16);
}

/* walks down the left spine of argument chain node, counting CALL_ARG_SPLIT_COUNT down once
   per argument from the innermost one outwards, and returns the chain node where the count
   runs out (or the innermost result once it is negative) */
u16 SPLIT_ARG_LIST_BY_COUNT(u16 node)
{
    if (EXPR_W(node, EXPR_OP) == 43) {
        u16 result = SPLIT_ARG_LIST_BY_COUNT(EXPR_W(node, EXPR_LEFT));
        if (CALL_ARG_SPLIT_COUNT >= 0) {
            CALL_ARG_SPLIT_COUNT--;
            return node;
        }
        return result;
    }
    CALL_ARG_SPLIT_COUNT--;
    return node;
}

/* one argument pushed; the bytes it takes, rounded up to whole words */
static u16 push_one(u16 value)
{
    u16 total = ARGUMENT_STACK_SIZE(value);
    PUSH_ARGUMENT(value);
    if (total & 1)
        ++total;
    return total;
}

/* pushes the arguments of chain value right operand first (the last argument first, as C
   wants) and returns the number of bytes pushed */
i16 PUSH_ARGUMENT_LIST(u16 value)
{
    if (!value)
        return 0;
    if (EXPR_W(value, EXPR_OP) == 0x2B) {
        u16 total = (u16)PUSH_ARGUMENT_LIST(EXPR_W(value, EXPR_RIGHT));
        return (i16)(total + (u16)PUSH_ARGUMENT_LIST(EXPR_W(value, EXPR_LEFT)));
    }
    return (i16)push_one(value);
}

/* the same in the opposite order (left operand first); arguments whose EXPR_NODE_FLAGS2
   byte is set are skipped */
i16 PUSH_ARGUMENT_CHAIN(u16 value)
{
    if (!value)
        return 0;
    if (EXPR_W(value, EXPR_OP) == 0x2B) {
        u16 result = (u16)PUSH_ARGUMENT_CHAIN(EXPR_W(value, EXPR_LEFT));
        return (i16)(result + (u16)PUSH_ARGUMENT_CHAIN(EXPR_W(value, EXPR_RIGHT)));
    }
    if (EXPR_B(value, EXPR_NODE_FLAGS2) != 0)
        return 0;
    return (i16)push_one(value);
}

/* emits the call itself for function expression value and returns the call op.  A call
   through a pointer (EXPR_OP 31h): a near pointer to a far function gets PUSH CS and a near
   indirect call; a far pointer gets op 76h, and a pointer held in a variable is forced to
   memory.  A direct call names the function symbol in a near or far call op */
u16 EMIT_CALL_INSTRUCTION(u16 value)
{
    u16 size = (u16)CALL_FAR(CALL_KIND_HOOK, A16(EXPR_W(value, EXPR_TYPE)));
    u16 flag = (u16)CALL_FAR(FLAG_HOOK, A16(EXPR_W(value, EXPR_TYPE))) & 1;
    if (EXPR_W(value, EXPR_OP) != 0x31) {
        if (size == 4)
            NEW_CODE_NODE(0x73, 0, 0, 0);
        return NEW_VARIABLE_NODE(flag ? 0x78 : 0x77, EXPR_W(value, EXPR_LEFT), 0x1055, EXPR_B(value, EXPR_QUAL_FLAGS));
    }
    value = EXPR_W(value, EXPR_LEFT);
    constant(5, 0x1055);
    u32 operand = GENERATE_EXPRESSION(value, 1);
    if (size == 4)
        NEW_CODE_NODE(0x73, 0, 0, 0);
    if (EXPR_W(value, EXPR_KIND) == 13) {
        if (flag)
            push(NEW_CODE_NODE(8, 0, 14, 0));
        return NEW_CODE_NODE(0x75, 0, LOW(operand), 0);
    }
    if (!flag)
        return NEW_CODE_NODE(0x75, 0, LOW(operand), 0);
    u16 op = LOW(operand) << 2;
    if (COP_B(op, COP_OPCODE) == 16 || COP_B(op, COP_OPCODE) == 17)
        VAR_B(OPND_W(op, OPND_LEFT), VAR_FLAGS) |= 4;
    return NEW_CODE_NODE(0x76, 0, LOW(operand), HIGH(operand));
}

/* the size of argument node's type, rounded up to an even number of bytes */
u16 ARGUMENT_STACK_SIZE(u16 node)
{
    return (u16)(((u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(EXPR_W(node, EXPR_TYPE))) + 1) & 0xFFFE);
}

/* generates argument value and pushes it.  For 32-bit values: &x as a far pointer pushes
   segment and offset of x without computing it; op 2Dh (a segment:offset pair) pushes both
   parts; a near pointer cast to far (op 35h) pushes the segment register its type implies,
   then the offset; a _seg value cast to far pushes it and offset 0.  A struct argument that
   PUSH_STRUCT_VALUE reports as fitting a scalar is pushed again as that scalar.  Taking the
   address of a floating object sets CODE_OUTPUT_FLAGS bit 2 */
void PUSH_ARGUMENT(u16 value)
{
    u32 operand;
    if (EXPR_W(value, EXPR_OP) == EOP_ADDR && (EXPR_FLAGS_AT(EXPR_W(EXPR_W(value, EXPR_LEFT), EXPR_KIND)) & 2))
        CODE_OUTPUT_FLAGS |= 2;
    for (;;) {
        switch (EXPR_W(value, EXPR_KIND)) {
        case TK_FAR_PTR:
        case TK_HUGE_PTR:
            if (EXPR_W(value, EXPR_OP) == EOP_ADDR) {
                PUSH_ADDRESS_ARGUMENT(EXPR_W(value, EXPR_LEFT));
                return;
            }
            if (EXPR_W(value, EXPR_OP) == 45) {
                PUSH_ARGUMENT(EXPR_W(value, EXPR_LEFT));
                PUSH_ARGUMENT(EXPR_W(value, EXPR_RIGHT));
                return;
            }
            /* fall through */
        case TK_LONG:
        case TK_ULONG:
            if (EXPR_W(value, EXPR_OP) == 53 && EXPR_W(EXPR_W(value, EXPR_LEFT), EXPR_KIND) == TK_NEAR_PTR) {
                value = EXPR_W(value, EXPR_LEFT);
                u16 flags = (u16)CALL_FAR(GET_TYPE_FLAGS_ALT_HOOK, A16(EXPR_W(value, EXPR_TYPE)));
                i8 reg = SEGMENT_REGISTER_CODE(flags);
                push(NEW_CODE_NODE(8, 0, (u16)(i16)reg, 0));
                operand = GENERATE_EXPRESSION(value, 1);
                push(LOW(operand));
            } else if (EXPR_W(value, EXPR_OP) == 53 && EXPR_W(EXPR_W(value, EXPR_LEFT), EXPR_KIND) == TK_SEG_PTR) {
                operand = GENERATE_EXPRESSION(EXPR_W(value, EXPR_LEFT), 1);
                push(LOW(operand));
                push(constant(10, 0));
            } else {
                operand = GENERATE_EXPRESSION(value, 1);
                push(HIGH(operand));
                push(LOW(operand));
            }
            return;
        case TK_SHORT: case TK_USHORT: case TK_INT: case TK_UINT: case TK_NEAR_PTR: case TK_SEG_PTR:
            operand = GENERATE_EXPRESSION(value, 1);
            push(LOW(operand));
            return;
        case TK_CHAR:
        case TK_UCHAR:
            operand = GENERATE_EXPRESSION(value, 1);
            NEW_CODE_NODE(0x93, 0, LOW(operand), 0);
            return;
        case TK_FLOAT: case TK_DOUBLE: case TK_LDOUBLE:
            PUSH_FLOAT_ARGUMENT(value);
            return;
        case TK_STRUCT:
        case TK_UNION:
            if (PUSH_STRUCT_VALUE(value))
                continue;
            return;
        default:
            return;
        }
    }
}

/* pushes the far address of object input: for a global symbol (op 1) its segment (op 12)
   and offset (op 13); for others SS (register 15) and the offset of the object (op 13), or
   for expression op 7 the parameter-area address (op 14) */
void PUSH_ADDRESS_ARGUMENT(u16 input)
{
    u16 result;
    if (EXPR_W(input, EXPR_OP) == 1) {
        result = NEW_VARIABLE_NODE(12, EXPR_W(input, EXPR_LEFT), 0, EXPR_B(input, EXPR_QUAL_FLAGS));
        push(result);
        result = NEW_VARIABLE_NODE(13, EXPR_W(input, EXPR_LEFT), EXPR_W(input, EXPR_RIGHT), EXPR_B(input, EXPR_QUAL_FLAGS));
    } else if (EXPR_W(input, EXPR_OP) == 7) {
        push(NEW_CODE_NODE(8, 0, 15, 0));
        result = constant(14, 0);
    } else {
        push(NEW_CODE_NODE(8, 0, 15, 0));
        result = NEW_VARIABLE_NODE(13, EXPR_W(input, EXPR_LEFT), EXPR_W(input, EXPR_RIGHT), EXPR_B(input, EXPR_QUAL_FLAGS));
    }
    push(result);
}

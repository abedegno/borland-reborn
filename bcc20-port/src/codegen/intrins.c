/* intrins.c: from bcc20/src/codegen/INTRINS.C: inline code for calls of intrinsic functions
   (symbols of kind 10, numbered by SYMBOL_INDEX_HOOK) and for __emit__.
   GENERATE_INTRINSIC_CALL checks the call against the intrinsic's INTRINSIC_TABLE entry (10
   bytes: result kind at 2, argument count at 4, argument kinds from 5 on, indexed from 0),
   generates the arguments in register-need order and builds the code ops.  Intrinsic
   numbers: 0 interrupt call (INT n for a constant n below 256, otherwise PUSHF and a far call
   through the vector at 0:n*4), 1 abs (CWD, XOR, SUB), 2 to 5 single string-instruction ops
   (6Eh, 70h, 6Fh, 71h), 6 __emit__, whose arguments become raw bytes in the code (code ops
   7Ah byte and 79h word).  CHECK_EMIT_ARGUMENTS is the front end's check of __emit__
   arguments.  Any mismatch is a fatal error. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "exprop.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define SCORE(n) EXPR_SC((n), EXPR_NODE_FLAGS)
#define ENTRY(i) fp_add(INTRINSIC_TABLE_P, (i) * 10)
#define ENTRY_RESULT(e) SB(fp_add((e), 2))
#define ENTRY_COUNT(e) SB(fp_add((e), 4))
#define ENTRY_TYPE(e, i) SB(fp_add((e), 5 + (i)))

static u16 constant(u8 kind, i32 value)
{
    return NEW_CONSTANT_NODE(kind, (u16)((u32)value >> 16), (u16)value);
}

/* generates the count argument expressions in nodes, the one with the largest register need
   first (SCORE, whose sign is dropped), storing each result op pair in results at the
   argument's own index */
void GENERATE_ARGUMENTS_BY_WEIGHT(i16 count, farptr nodes, farptr results)
{
    u16 best = 0;
    for (i16 i = 0; i < count; ++i) {
        W(fp_add(results, i * 4)) = W(fp_add(results, i * 4 + 2)) = 0;
        i16 score = SCORE(W(fp_add(nodes, i * 2)));
        SCORE(W(fp_add(nodes, i * 2))) = (i8)(score < 0 ? -score : score);
    }
    for (;;) {
        i16 score = -1;
        for (i16 i = 0; i < count; ++i)
            if (W(fp_add(results, i * 4)) == 0 && SCORE(W(fp_add(nodes, i * 2))) > score) {
                score = SCORE(W(fp_add(nodes, i * 2)));
                best = (u16)i;
            }
        if (score < 0)
            break;
        D(fp_add(results, best * 4)) = GENERATE_EXPRESSION(W(fp_add(nodes, best * 2)), 1);
    }
}

/* generates call node input when it calls an intrinsic; the result op pair (0 when the
   callee is not an intrinsic, so the caller makes a normal call).  The argument nodes are
   collected into args[] from the last to the first */
i32 GENERATE_INTRINSIC_CALL(u16 input, u16 unused)
{
    (void)unused;
    if (EXPR_W(EXPR_W(input, EXPR_LEFT), EXPR_OP) != 1)
        return 0;
    u16 symbol = EXPR_W(EXPR_W(input, EXPR_LEFT), EXPR_LEFT);
    if ((u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(symbol)) != 10)
        return 0;
    farptr description = ENTRY((u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(symbol)));
    u16 cursor = EXPR_W(input, EXPR_RIGHT);
    i16 count = ENTRY_COUNT(description);
    if (B(fp_add(KIND_INFO_TABLE_P, EXPR_W(input, EXPR_KIND) * 4)) != B(fp_add(KIND_INFO_TABLE_P, ENTRY_RESULT(description) * 4))) {
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        return 0;
    }
    /* the original frame from BP-32h: values, args at 28h */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x32);
    farptr values = v, args = fp_add(v, 0x28);
#define ARG(i) W(fp_add(args, (i) * 2))
#define VALUE_LOW(i) W(fp_add(values, (i) * 4))
#define VALUE_HIGH(i) W(fp_add(values, (i) * 4 + 2))
    if (cursor != 0 && count >= 0) {
        i16 index = count;
        while (EXPR_W(cursor, EXPR_OP) == 0x2B) {
            if (index <= 0 || EXPR_W(EXPR_W(cursor, EXPR_RIGHT), EXPR_KIND) != (u16)(i16)ENTRY_TYPE(description, index)) {
                REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
                scratch_release(mark);
                return 0;
            }
            ARG(index - 1) = EXPR_W(cursor, EXPR_RIGHT);
            index--;
            cursor = EXPR_W(cursor, EXPR_LEFT);
        }
        if (index != 1 || EXPR_W(cursor, EXPR_KIND) != (u16)(i16)ENTRY_TYPE(description, 1)) {
            REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
            scratch_release(mark);
            return 0;
        }
        ARG(0) = cursor;
    } else if (count > 0) {
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        scratch_release(mark);
        return 0;
    }
    GENERATE_ARGUMENTS_BY_WEIGHT(count, args, values);
    u16 low = 0, high = 0;
    switch ((u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(symbol))) {
    case 1: {
        u16 value = NEW_CODE_NODE(0xAC, 0, VALUE_LOW(0), 0);
        u16 sign = NEW_CODE_NODE(8, 0, 2, 0);
        value = NEW_CODE_NODE(0x4F, 0, value, sign);
        low = NEW_CODE_NODE(0x28, 0, value, sign);
        break;
    }
    case 2:
        low = NEW_CODE_NODE(0x6E, 0, VALUE_LOW(0), VALUE_LOW(1));
        break;
    case 3:
        NEW_CODE_NODE(0x70, 0, NEW_CODE_NODE(8, 0, 0, 0), VALUE_LOW(0));
        low = constant(0xC2, 0);
        break;
    case 4:
        low = NEW_CODE_NODE(0x6F, 0, VALUE_LOW(0), VALUE_LOW(1));
        break;
    case 5:
        NEW_CODE_NODE(0x71, 0, NEW_CODE_NODE(8, 0, 0, 0), VALUE_LOW(0));
        low = constant(0xC2, 0);
        break;
    case 0:
        if (EXPR_W(ARG(0), EXPR_OP) == EOP_CONST) {
            if (EXPR_W(ARG(0), EXPR_LEFT) > 255) {
                REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
                scratch_release(mark);
                return 0;
            }
            low = constant(0x72, EXPR_W(ARG(0), EXPR_LEFT) & 255);
        } else {
            u16 value1 = VALUE_LOW(0);
            value1 = NEW_CODE_NODE(0x45, 0, value1, constant(9, 1));
            value1 = NEW_CODE_NODE(0x45, 0, value1, constant(9, 1));
            NEW_CODE_NODE(0x73, 0, 0, 0);
            NEW_CODE_NODE(0xA6, 0, 0, 0);
            u16 value3 = constant(10, 0);
            u16 value2 = NEW_CODE_NODE(0x1B, 0, value1, value3);
            value1 = NEW_CODE_NODE(0x16, 0, value1, value3);
            low = NEW_CODE_NODE(0x76, 0, value1, value2);
        }
        break;
    case 6:
        EMIT_INLINE_ARGUMENTS(cursor);
        low = 1;
        break;
    default:
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
    }
#undef ARG
#undef VALUE_LOW
#undef VALUE_HIGH
    scratch_release(mark);
    if (ENTRY_RESULT(description) == 15)
        high = constant(0xC7, 0);
    return (i32)((u32)low | (u32)high << 16);
}

/* turns the __emit__ argument list value (2Bh chain, handled left to right by recursion)
   into raw-byte code ops.  An int or short constant from 0 to 255 counts as a byte.
   Accepted: &auto or &parameter (op 32h over op 5 or 6), which forces frame offsets to be
   assigned now and emits the variable's frame offset as one byte; the address of a global
   as its offset (7Ch), segment (7Bh) or both, by pointer kind; constants as a byte, a word,
   or two words for longs and far pointers (which, as written, then also report an error) */
void EMIT_INLINE_ARGUMENTS(u16 value)
{
    if (EXPR_W(value, EXPR_OP) == 0x2B) {
        EMIT_INLINE_ARGUMENTS(EXPR_W(value, EXPR_LEFT));
        value = EXPR_W(value, EXPR_RIGHT);
    }
    u8 type;
    if ((EXPR_W(value, EXPR_KIND) == 3 || EXPR_W(value, EXPR_KIND) == 5) && EXPR_W(value, EXPR_OP) == 2
        && EXPR_L(value, EXPR_LEFT) >= 0 && EXPR_L(value, EXPR_LEFT) <= 255)
        type = 1;
    else
        type = EXPR_B(value, EXPR_KIND);
    switch (EXPR_W(value, EXPR_OP)) {
    case 0x32: {
        u16 target = EXPR_W(value, EXPR_LEFT);
        if (EXPR_W(target, EXPR_OP) == 5 || EXPR_W(target, EXPR_OP) == 6) {
            u16 node = FIND_OR_ADD_VARIABLE(EXPR_W(target, EXPR_LEFT), EXPR_B(target, EXPR_KIND), EXPR_B(target, EXPR_QUAL_FLAGS));
            ++VAR_W(node, VAR_USE_COUNT);
            if (VAR_B(node, VAR_SYMBOL_KIND) != 6)
                ASSIGN_LOCAL_OFFSETS(FUNCTION_OUTER_SCOPE_BLOCK, (u16)-FRAME_LOCALS_SIZE, 0);
            else if (FUNCTION_OUTER_SCOPE_BLOCK) {
                FRAME_HEADER_SIZE = 2;
                ASSIGN_PARAM_OFFSETS();
            }
            VAR_B(node, VAR_FLAGS) = 4;
            constant(0x7A, VAR_W(node, VAR_FRAME_OFFSET));
            return;
        }
        switch (type) {
        case 13:
            NEW_VARIABLE_NODE(0x7C, EXPR_W(target, EXPR_LEFT), EXPR_W(target, EXPR_RIGHT), EXPR_B(target, EXPR_QUAL_FLAGS));
            break;
        case 14:
            NEW_VARIABLE_NODE(0x7B, EXPR_W(target, EXPR_LEFT), 0, EXPR_B(target, EXPR_QUAL_FLAGS));
            break;
        case 15:
        case 16:
            NEW_VARIABLE_NODE(0x7C, EXPR_W(target, EXPR_LEFT), EXPR_W(target, EXPR_RIGHT), EXPR_B(target, EXPR_QUAL_FLAGS));
            NEW_VARIABLE_NODE(0x7B, EXPR_W(target, EXPR_LEFT), 0, EXPR_B(target, EXPR_QUAL_FLAGS));
            break;
        default:
            REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        }
        return;
    }
    case 2:
        switch (type) {
        case 1:
        case 2:
            constant(0x7A, EXPR_W(value, EXPR_LEFT) & 0xFF);
            return;
        case 7:
        case 8:
        case 15:
        case 16:
            constant(0x79, EXPR_W(value, EXPR_LEFT));
            constant(0x79, (i16)EXPR_W(value, EXPR_RIGHT));
            break;
        default:
            constant(0x79, EXPR_W(value, EXPR_LEFT));
            return;
        }
        /* fall through: as written, the long and far cases also report the error */
    default:
        REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
    }
}

/* for intrinsic number kind 6 (__emit__) checks the argument list value: at least one
   argument, and each a constant or an address, possibly cast */
void CHECK_EMIT_ARGUMENTS(u16 kind, u16 value)
{
    if (kind == 6) {
        if (value == 0)
            REPORT_ERROR(MSG_TOO_FEW_PARAMETERS_46, STR_EMIT_P);
        CHECK_EMIT_ARGUMENT_LIST(value);
    }
}

/* checks each argument of the 2Bh chain value: constants (ops 2, 3) and addresses (32h)
   pass, casts (35h) are looked through.  After the error the loop runs again on the same
   node, so it repeats the error until the error limit stops the compile, as the original
   does */
void CHECK_EMIT_ARGUMENT_LIST(u16 value)
{
    if (EXPR_W(value, EXPR_OP) == 0x2B) {
        CHECK_EMIT_ARGUMENT_LIST(EXPR_W(value, EXPR_LEFT));
        value = EXPR_W(value, EXPR_RIGHT);
    }
    for (;;) {
        switch ((i16)EXPR_W(value, EXPR_OP)) {
        case 0x32:
        case 2:
        case 3:
            return;
        case 0x35:
            value = EXPR_W(value, EXPR_LEFT);
            break;
        default:
            REPORT_ERROR(MSG_ILLEGAL_PARAMETER_EMIT);
            break;
        }
    }
}

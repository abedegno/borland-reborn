/* initdata.c: from bcc20/src/codegen/INITDATA.C: writes the bytes of one constant
   initialiser value, for static data.  The value is an already folded expression node: an
   integer or pointer constant (EXPR_OP 2), a floating constant (op 3, a 10-byte long double
   in the node from EXPR_LEFT on, narrowed to float or double), or the address of a symbol
   (op 32h over a symbol node, possibly under casts, op 35h), which goes out through
   WORD_HOOK (near address) or ALT_HOOK (far address) so the output layer can add a fixup.
   Anything else is an error.  Bytes go to the data byte pool (EMIT_VALUE) or to BYTE_HOOK.
   The expression pool is reset at the end. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

static void emit(u16 direct, u8 value)
{
    if (direct != 0)
        EMIT_VALUE((i8)value);
    else
        CALL_FAR(BYTE_HOOK, A16(value));
}

/* emits constant expression node as initialiser bytes, low byte first; direct non-zero
   sends them to the data byte pool, zero to BYTE_HOOK */
void EMIT_INITIALIZER_VALUE(u16 node, u16 direct)
{
    if (EXPR_W(node, EXPR_OP) == 2) {
        u32 value = EXPR_UL(node, EXPR_LEFT);
        switch (EXPR_W(node, EXPR_KIND)) {
        case 1: case 2:
            emit(direct, EXPR_B(node, EXPR_VALUE));
            break;
        case 3: case 4: case 5: case 6: case 13: case 14: case 21:
            emit(direct, EXPR_B(node, EXPR_VALUE));
            emit(direct, (u8)(value >> 8));
            break;
        case 7: case 8: case 15: case 16:
            emit(direct, EXPR_B(node, EXPR_VALUE));
            emit(direct, (u8)(value >> 8));
            emit(direct, (u8)(value >> 16));
            emit(direct, (u8)(value >> 24));
            break;
        }
    } else if (EXPR_W(node, EXPR_OP) == 3) {
        /* the original frame from BP-1Ch: extended, wide at 0Ah, single at 12h */
        u16 mark = scratch_mark();
        farptr v = scratch_alloc(0x1C);
        farptr extended = v, wide = fp_add(v, 0x0A), single = fp_add(v, 0x12);
        switch (EXPR_W(node, EXPR_KIND)) {
        case 9:
            RTL_MEMMOVE(extended, MK_FP(EXPR_POOL_SEG, node + EXPR_LEFT), 10);
            RTL_LDOUBLE_TO_FLOAT(extended, single);
            for (int index = 0; index < 4; index++)
                emit(direct, B(fp_add(single, index)));
            break;
        case 10:
            RTL_MEMMOVE(extended, MK_FP(EXPR_POOL_SEG, node + EXPR_LEFT), 10);
            RTL_LDOUBLE_TO_DOUBLE(extended, wide);
            for (int index = 0; index < 8; index++)
                emit(direct, B(fp_add(wide, index)));
            break;
        case 11:
            for (int index = 0; index < 10; index++)
                emit(direct, EXPR_B(node, EXPR_LEFT + index));
            break;
        }
        scratch_release(mark);
    } else {
        u16 value = node;
        while (EXPR_W(value, EXPR_OP) == 0x35)
            value = EXPR_W(value, EXPR_LEFT);
        if (EXPR_W(value, EXPR_OP) != 0x32 || EXPR_W(EXPR_W(value, EXPR_LEFT), EXPR_OP) != 1)
            REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
        else {
            value = EXPR_W(value, EXPR_LEFT);
            switch (EXPR_W(node, EXPR_KIND)) {
            case 14:
                REPORT_FATAL(MSG_ILLEGAL_INITIALIZATION);
                /* fall through: REPORT_FATAL does not return */
            case 3: case 4: case 5: case 6: case 13: case 21:
                CALL_FAR(WORD_HOOK, A16(EXPR_W(value, EXPR_LEFT)), A16(EXPR_W(value, EXPR_RIGHT)));
                break;
            case 7: case 8: case 15: case 16:
                CALL_FAR(ALT_HOOK, A16(EXPR_W(value, EXPR_LEFT)), A16(EXPR_W(value, EXPR_RIGHT)));
                break;
            default:
                REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
            }
        }
    }
    CALL_FAR0(RESET_EXPR_POOL_HOOK);
}

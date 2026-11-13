/* exprpack.c: from bcc20/src/expr/EXPRPACK.C: expression trees packed into
   PACKED_EXPR_POOL_SEG and unpacked again (for inline function bodies and default
   arguments kept past the statement that made them).  A packed record has a 10-byte
   header (kind byte, flags byte, type, the 6-byte source position) and then, by kind, the
   constant's long, the operand words, or the packed operands.  The pool's descriptor words
   are segment, capacity, used, and a word cleared on reset. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "exprop.h"
#include "protos.h"

#define R(r, o) AT_W(PACKED_EXPR_POOL_SEG, (r) + (o))
#define RB(r, o) AT_B(PACKED_EXPR_POOL_SEG, (r) + (o))
#define RL(r, o) AT_L(PACKED_EXPR_POOL_SEG, (r) + (o))
#define BANK_USED W(fp_add(PACKED_EXPR_POOL_SEG_P, 4))
#define BANK_WORD6 W(fp_add(PACKED_EXPR_POOL_SEG_P, 6))

static u16 alloc_record(u16 size) { return POOL_ALLOC(PACKED_EXPR_POOL_SEG_P, size); }

/* the packed record of expression (recursively), or 0 for a null tree or an error node */
u16 PACK_EXPR_TREE(u16 expression)
{
    if (!expression || !EXPR_W(expression, EXPR_OP))
        return 0;
    u16 record;
    switch (EXPR_W(expression, EXPR_OP)) {
    case EOP_CONST:
        record = alloc_record(14);
        RL(record, 10) = AT_L(EXPR_POOL_SEG, expression + 10);
        break;
    case 3:
        record = alloc_record(20);
        RTL_MEMMOVE(MK_FP(PACKED_EXPR_POOL_SEG, record + PEXPR_OPERANDS), MK_FP(EXPR_POOL_SEG, expression + EXPR_LEFT), 10);
        break;
    case 0x48:
    case 1:
    case 7:
        record = alloc_record(16);
        R(record, 10) = EXPR_W(expression, EXPR_LEFT);
        R(record, 12) = EXPR_W(expression, EXPR_RIGHT);
        R(record, 14) = EXPR_W(expression, EXPR_SCOPE_CLASS);
        break;
    case 0x38:
        record = alloc_record(18);
        R(record, 10) = EXPR_W(expression, EXPR_LEFT);
        R(record, 12) = EXPR_W(expression, EXPR_RIGHT);
        R(record, 14) = EXPR_W(expression, EXPR_SCOPE_CLASS);
        R(record, 16) = EXPR_W(expression, EXPR_NAME_KIND);
        break;
    case 0x4A:
        record = alloc_record(14);
        R(record, 10) = EXPR_W(expression, EXPR_LEFT);
        R(record, 12) = EXPR_W(expression, EXPR_RIGHT);
        break;
    case 0x39:
        record = alloc_record(14);
        R(record, 10) = EXPR_W(expression, EXPR_LEFT);
        RB(record, 12) = EXPR_B(expression, EXPR_BIT_WIDTH);
        RB(record, 13) = EXPR_B(expression, EXPR_BIT_SHIFT);
        break;
    default: {
        record = alloc_record(14);
        u16 left = PACK_EXPR_TREE(EXPR_W(expression, EXPR_LEFT));
        R(record, 10) = left;
        u16 right = PACK_EXPR_TREE(EXPR_W(expression, EXPR_RIGHT));
        R(record, 12) = right;
        break;
    }
    }
    RB(record, 0) = EXPR_B(expression, EXPR_OP);
    RB(record, 1) = EXPR_B(expression, EXPR_NODE_FLAGS);
    R(record, 2) = EXPR_W(expression, EXPR_TYPE);
    for (int i = 0; i < 6; i++)
        RB(record, 4 + i) = AT_B(EXPR_POOL_SEG, expression + 20 + i);
    return record;
}

/* a tree of new expression nodes rebuilt from a packed record (0 gives 0) */
u16 UNPACK_EXPR_TREE(u16 record)
{
    if (!record)
        return 0;
    u16 expression = ALLOC_EXPR_NODE();
    EXPR_W(expression, EXPR_OP) = RB(record, 0);
    EXPR_B(expression, EXPR_NODE_FLAGS) = RB(record, 1);
    EXPR_W(expression, EXPR_TYPE) = R(record, 2);
    for (int i = 0; i < 6; i++)
        AT_B(EXPR_POOL_SEG, expression + 20 + i) = RB(record, 4 + i);
    switch (RB(record, 0)) {
    case 2:
        AT_L(EXPR_POOL_SEG, expression + 10) = RL(record, 10);
        break;
    case 3:
        RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG, expression + EXPR_LEFT), MK_FP(PACKED_EXPR_POOL_SEG, record + PEXPR_OPERANDS), 10);
        break;
    case 0x48:
    case 1:
    case 7:
        EXPR_W(expression, EXPR_LEFT) = R(record, 10);
        EXPR_W(expression, EXPR_RIGHT) = R(record, 12);
        EXPR_W(expression, EXPR_SCOPE_CLASS) = R(record, 14);
        break;
    case 0x38:
        EXPR_W(expression, EXPR_LEFT) = R(record, 10);
        EXPR_W(expression, EXPR_RIGHT) = R(record, 12);
        EXPR_W(expression, EXPR_SCOPE_CLASS) = R(record, 14);
        EXPR_W(expression, EXPR_NAME_KIND) = R(record, 16);
        break;
    case 0x4A:
        EXPR_W(expression, EXPR_LEFT) = R(record, 10);
        EXPR_W(expression, EXPR_RIGHT) = R(record, 12);
        break;
    case 0x39:
        EXPR_W(expression, EXPR_LEFT) = R(record, 10);
        EXPR_B(expression, EXPR_BIT_WIDTH) = RB(record, 12);
        EXPR_B(expression, EXPR_BIT_SHIFT) = RB(record, 13);
        break;
    default: {
        u16 left = UNPACK_EXPR_TREE(R(record, 10));
        EXPR_W(expression, EXPR_LEFT) = left;
        u16 right = UNPACK_EXPR_TREE(R(record, 12));
        EXPR_W(expression, EXPR_RIGHT) = right;
        break;
    }
    }
    return expression;
}

/* the packed pool's fill position, for EXPR_BANK_RESET */
u16 EXPR_BANK_MARK(void) { return BANK_USED; }

/* free every packed record allocated after position */
void EXPR_BANK_RESET(u16 position)
{
    BANK_WORD6 = 0;
    BANK_USED = position;
}

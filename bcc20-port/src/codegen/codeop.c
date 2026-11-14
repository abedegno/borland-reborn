/* codeop.c: from bcc20/src/codegen/CODEOP.C: two table lookups of the code generator.
   CODE_OP_FOR_NODE picks the code op for an expression node: code ops come in families, one
   per expression operator, with one member per value type, so the op is
   OPERAND_BASE_BY_KIND[operator] plus an offset by the node's value kind from
   LEAF_OPCODE_KIND_OFFSET (leaves: operators up to 7 and EOP_DEREF 31h) or
   OPER_OPCODE_KIND_OFFSET (operators); OPERAND_BASE_BY_KIND is indexed by operator, not by
   kind.  REFINE_KIND_10_OPERAND, called by the register allocator, makes register class 10
   of an operand more precise. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

/* the code op number for expression node value (operator EXPR_OP, value kind EXPR_KIND) */
u16 CODE_OP_FOR_NODE(u16 value)
{
    u16 kind = EXPR_W(value, EXPR_OP), index = EXPR_W(value, EXPR_KIND);
    if ((i16)kind <= 7 || kind == 0x31)
        return (u16)(OPERAND_BASE_BY_KIND_AT(kind) + LEAF_OPCODE_KIND_OFFSET_AT(index));
    return (u16)(OPERAND_BASE_BY_KIND_AT(kind) + OPER_OPCODE_KIND_OFFSET_AT(index));
}

/* kind is an operand's register class from the op table and value the operand op number.
   Classes other than 10 come back unchanged.  For class 10 the result is 13 when the
   operand is already in SI or DI (a register variable leaf 16 or a register op 8), 32 when
   it is a variable leaf 13 of an auto (5) or parameter (6), otherwise 14 */
u16 REFINE_KIND_10_OPERAND(u16 kind, u16 value)
{
    if (kind != 10)
        return kind;
    if (value == 0)
        return 14;
    u16 op = value << 2;
    if (COP_B(op, COP_OPCODE) == 16 && (VAR_B(OPND_W(op, OPND_VARIABLE), VAR_FLAGS) & 2)) {
        u8 reg = VAR_B(OPND_W(op, OPND_VARIABLE), VAR_REGISTER);
        return reg == 8 || reg == 9 ? 13 : 14;
    }
    if (COP_B(op, COP_OPCODE) == 8) {
        u8 reg = B(MK_FP(CODE_OPERAND_POOL_SEG, op + OPND_REGISTER));
        if (reg == 8 || reg == 9)
            return 13;
    }
    if (COP_B(op, COP_OPCODE) == 13 && (VAR_B(OPND_W(op, OPND_VARIABLE), VAR_SYMBOL_KIND) == 5 || VAR_B(OPND_W(op, OPND_VARIABLE), VAR_SYMBOL_KIND) == 6))
        return 32;
    return 14;
}

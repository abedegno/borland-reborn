/* codenode.c: from bcc20/src/codegen/CODENODE.C: allocators for code ops, the back end's
   intermediate code.  Each op takes one 4-byte record in CODE_OP_POOL_SEG (opcode,
   COP_FLAGS, COP_REGISTER, COP_REG_CLASS) and one at the same offset in
   CODE_OPERAND_POOL_SEG (two operand words), and is named by its number: record offset =
   number*4.  Numbers come from CODE_OP_NEXT_INDEX, reset to 1 for each function.  The four
   allocators differ only in how they fill the operand words.  MARK_VARIABLE_ACCESS records
   in each variable's VAR_FLAGS how its leaf ops use it.  Table flags (the long at
   CODE_OP_INFO_TABLE+op*19): 1 a leaf naming a variable, 4 the op writes its left operand,
   8 the op takes the variable's address, 20h the op does not count as a use. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define OP_FLAGS(op) D(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))
#define OP_WORD(r, o) W(MK_FP(CODE_OP_POOL_SEG, (r) + (o)))

/* a new op record and its operand record; the op number's record offset */
static u16 new_op(u8 kind, u8 flags)
{
    u16 record = POOL_ALLOC(CODE_OP_POOL_SEG_P, 4);
    POOL_ALLOC(CODE_OPERAND_POOL_SEG_P, 4);
    COP_B(record, COP_OPCODE) = kind;
    COP_B(record, COP_FLAGS) = flags;
    return record;
}

static u16 next_index(void)
{
    return CODE_OP_NEXT_INDEX++;
}

/* appends op kind with COP_FLAGS flags and operands left and right (op numbers, 0 for
   none); returns the new op number.  Side effects on the operand ops: COP_FLAGS 4 on left
   when the op writes its left operand, 1 on left when flags has 2, and 8 (result used) on
   both operands unless the op has table flag 20h or is a line mark (op 1) */
u16 NEW_CODE_NODE(u16 kind, u8 flags, u16 left, u16 right)
{
    u16 record = new_op((u8)kind, flags);
    if (OP_FLAGS(kind) & 4)
        COP_B(left * 4, COP_FLAGS) |= 4;
    if (flags & 2)
        COP_B(left * 4, COP_FLAGS) |= 1;
    if ((OP_FLAGS(kind) & 0x20) == 0 && COP_B(record, COP_OPCODE) != 1) {
        if (left)
            COP_B(left * 4, COP_FLAGS) |= 8;
        if (right)
            COP_B(right * 4, COP_FLAGS) |= 8;
    }
    OP_WORD(record, COP_REGISTER) = 0;
    OPND_W(record, OPND_LEFT) = left;
    OPND_W(record, OPND_RIGHT) = right;
    return next_index();
}

/* appends leaf op kind whose left operand is the variable-table entry for symbol value1
   (value3 the last argument of FIND_OR_ADD_VARIABLE) and whose right operand is value2;
   returns the op number */
u16 NEW_VARIABLE_NODE(u8 kind, u16 value1, u16 value2, u16 value3)
{
    u16 record = new_op(kind, 0);
    OP_WORD(record, COP_REGISTER) = 0;
    u16 result = FIND_OR_ADD_VARIABLE(value1, 0, (u8)value3);
    OPND_W(record, OPND_LEFT) = result;
    OPND_W(record, OPND_RIGHT) = value2;
    return next_index();
}

/* appends op kind with the raw operand words value1 (left) and value2 (right) */
u16 NEW_PLAIN_CODE_NODE(u8 kind, u16 value1, u16 value2)
{
    u16 record = new_op(kind, 0);
    OP_WORD(record, COP_REGISTER) = 0;
    OPND_W(record, OPND_LEFT) = value1;
    OPND_W(record, OPND_RIGHT) = value2;
    return next_index();
}

/* appends op kind carrying a long constant, which arrives as two words, value1 the high
   word and value2 the low word, stored so the long reads back little-endian */
u16 NEW_CONSTANT_NODE(u8 kind, u16 value1, u16 value2)
{
    u16 record = new_op(kind, 0);
    OP_WORD(record, COP_REGISTER) = 0;
    OPND_W(record, OPND_RIGHT) = value1;
    OPND_W(record, OPND_LEFT) = value2;
    return next_index();
}

/* walks the block chain starting at list and, for each variable leaf op in a code block
   (kind 0) or switch block (kind 4), sets bits in the variable's VAR_FLAGS: 34h when the
   op takes its address, else 20h when it is written to, else 40h for a read */
void MARK_VARIABLE_ACCESS(u16 list)
{
    for (; list; list = CNODE_W(list, CNODE_NEXT)) {
        if (CNODE_W(list, CNODE_KIND) != 0 && CNODE_W(list, CNODE_KIND) != 4)
            continue;
        u16 cursor = CNODE_W(list, CNODE_FIRST_OP) * 4;
        for (u16 count = CNODE_W(list, CNODE_OP_COUNT); count; count--, cursor += 4) {
            u32 attributes = OP_FLAGS(COP_B(cursor, COP_OPCODE));
            if (!(attributes & 1))
                continue;
            if (attributes & 8)
                VAR_B(OPND_W(cursor, OPND_LEFT), VAR_FLAGS) |= 0x34;
            else if (COP_B(cursor, COP_FLAGS) & 4)
                VAR_B(OPND_W(cursor, OPND_LEFT), VAR_FLAGS) |= 0x20;
            else
                VAR_B(OPND_W(cursor, OPND_LEFT), VAR_FLAGS) |= 0x40;
        }
    }
}

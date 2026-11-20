/* target: ovr147_C216UNIT */
/* Role: code-node allocators. Entry points: NEW_CODE_NODE, NEW_VARIABLE_NODE,
   NEW_PLAIN_CODE_NODE, NEW_CONSTANT_NODE, MARK_VARIABLE_ACCESS. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO058 (ovr_1d5a_a169) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: allocators for code ops, the back end's intermediate code. Each op takes one
   4-byte record in CODE_OP_POOL_SEG (opcode, COP_FLAGS, COP_REGISTER, COP_REG_CLASS) and
   one 4-byte record at the same offset in CODE_OPERAND_POOL_SEG (two operand words), and
   is named by its number: record offset = number*4. Numbers come from CODE_OP_NEXT_INDEX,
   which INIT_FUNCTION_STATE resets to 1 for each function, so the ops of a function are
   numbered in the order they are generated and a flow block (FLOWBLK.C) owns the run
   CNODE_FIRST_OP .. CNODE_FIRST_OP+CNODE_OP_COUNT-1. POOL_ALLOC is passed the pool state
   at DS:8680 (CODE_OP_POOL_SEG) and DS:8698 (CODE_OPERAND_POOL_SEG) as raw addresses.
   The four allocators differ only in how they fill the operand words: NEW_CODE_NODE takes
   two op numbers and also sets usage flags on those operands from the op's
   CODE_OP_INFO_TABLE entry; NEW_VARIABLE_NODE stores a variable-table entry; the other two
   store raw words. Writing the word at COP_REGISTER clears both COP_REGISTER and
   COP_REG_CLASS. MARK_VARIABLE_ACCESS runs over finished block chains and records in each
   variable's VAR_FLAGS how its leaf ops use it.
   Table flags used (the long at CODE_OP_INFO_TABLE+op*19): 1 the op is a leaf naming a
   variable, 4 the op writes its left operand, 8 probably the op takes the variable's
   address, 0x20 the op does not count as a use of its operands. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- STAOV040 (listing ovr_1d5a_a169:1690) ---- */
extern unsigned int far pascal POOL_ALLOC(char far *, unsigned int);

/* NEW_CODE_NODE: appends op 'kind' with COP_FLAGS 'flags' and operands 'left' and
   'right' (op numbers, 0 for none); returns the new op number. Side effects on the operand
   ops: COP_FLAGS 4 on 'left' when the op writes its left operand (table flag 4), COP_FLAGS
   1 on 'left' when 'flags' has 2, and COP_FLAGS 8 (result used) on both operands unless
   the op has table flag 0x20 or is a line mark (op 1). */
unsigned int far pascal NEW_CODE_NODE(unsigned int kind, unsigned char flags,
                                      unsigned int left, unsigned int right)
{
    unsigned char near *description;

    _DI = left;
    _SI = POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OP_POOL_SEG), 4);
    POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OPERAND_POOL_SEG), 4);
    _ES = CODE_OP_POOL_SEG;
    *((unsigned char far *)MK_FP(_ES, _SI)) = kind;
    *((unsigned char far *)MK_FP(_ES, _SI + COP_FLAGS)) = flags;
    description = CODE_OP_INFO_TABLE - 3 + kind * 19;
    if (*((unsigned long near *)(description + 3)) & 4L)
        *((unsigned char far *)MK_FP(_ES, _DI * 4 + COP_FLAGS)) |= 4;
    if (flags & 2) {
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, _DI * 4 + COP_FLAGS)) |= 1;
    }
    if ((*((unsigned long near *)(description + 3)) & 0x20L) == 0) {
        _ES = CODE_OP_POOL_SEG;
        if (*((unsigned char far *)MK_FP(_ES, _SI)) != 1) {
            if (_DI)
                *((unsigned char far *)MK_FP(_ES, _DI * 4 + COP_FLAGS)) |= 8;
            if (right) {
                *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, right * 4 + COP_FLAGS)) |= 8;
            }
        }
    }
    _ES = CODE_OP_POOL_SEG;
    *((unsigned int far *)MK_FP(_ES, _SI + COP_REGISTER)) = 0;
    _ES = CODE_OPERAND_POOL_SEG;
    *((unsigned int far *)MK_FP(_ES, _SI)) = _DI;
    *((unsigned int far *)MK_FP(_ES, _SI + OPND_RIGHT)) = right;
    _AX = CODE_OP_NEXT_INDEX;
    CODE_OP_NEXT_INDEX++;
    return _AX;
}

/* ---- STAOV041 (listing ovr_1d5a_a169:1769) ---- */
extern unsigned int far pascal POOL_ALLOC(char far *state, unsigned int size);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int kind,
    unsigned char mode, unsigned char value);

/* NEW_VARIABLE_NODE: appends leaf op 'kind' whose left operand is the variable-table entry
   FIND_OR_ADD_VARIABLE returns for symbol 'value1' (with 'value3' as its last argument)
   and whose right operand is 'value2' (probably an offset added to the variable's
   address); returns the op number. */
unsigned int far pascal NEW_VARIABLE_NODE(unsigned char kind,
                                     unsigned int value1, unsigned int value2,
                                     unsigned int value3)
{
    unsigned int result;

    _SI = POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OP_POOL_SEG), 4);
    POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OPERAND_POOL_SEG), 4);
    _ES = CODE_OP_POOL_SEG;
    *((unsigned char far *)MK_FP(_ES, _SI)) = kind;
    *((unsigned char far *)MK_FP(_ES, _SI + COP_FLAGS)) = 0;
    *((unsigned int far *)MK_FP(_ES, _SI + COP_REGISTER)) = 0;
    result = FIND_OR_ADD_VARIABLE(value1, 0, value3);
    _ES = CODE_OPERAND_POOL_SEG;
    *((unsigned int far *)MK_FP(_ES, _SI)) = result;
    *((unsigned int far *)MK_FP(_ES, _SI + OPND_RIGHT)) = value2;
    _AX = CODE_OP_NEXT_INDEX;
    CODE_OP_NEXT_INDEX++;
    return _AX;
}

/* ---- STAOV042 (listing ovr_1d5a_a169:17D0) ---- */
extern unsigned int far pascal POOL_ALLOC(char far *state, unsigned int size);

/* NEW_PLAIN_CODE_NODE: appends op 'kind' with the raw operand words 'value1' (left) and
   'value2' (right) and no flag side effects; returns the op number. */
unsigned int far pascal NEW_PLAIN_CODE_NODE(unsigned char kind,
                                     unsigned int value1, unsigned int value2)
{
    _SI = POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OP_POOL_SEG), 4);
    POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OPERAND_POOL_SEG), 4);
    _ES = CODE_OP_POOL_SEG;
    *((unsigned char far *)MK_FP(_ES, _SI)) = kind;
    *((unsigned char far *)MK_FP(_ES, _SI + COP_FLAGS)) = 0;
    *((unsigned int far *)MK_FP(_ES, _SI + COP_REGISTER)) = 0;
    _ES = CODE_OPERAND_POOL_SEG;
    *((unsigned int far *)MK_FP(_ES, _SI)) = value1;
    *((unsigned int far *)MK_FP(_ES, _SI + OPND_RIGHT)) = value2;
    _AX = CODE_OP_NEXT_INDEX;
    CODE_OP_NEXT_INDEX++;
    return _AX;
}

/* ---- STAOV043 (listing ovr_1d5a_a169:1824) ---- */
extern unsigned int far pascal POOL_ALLOC(char far *state, unsigned int size);

/* NEW_CONSTANT_NODE: appends op 'kind' carrying a long constant. Callers pass a long (see
   the prototypes in SAVEREGS.C, NEW_CONSTANT_NODE(unsigned int,long)); in this pascal
   definition the long arrives as two words, value1 the high word and value2 the low word,
   and they are stored so the long reads back little-endian at OPND_CONST_VALUE. Returns the
   op number. */
unsigned int far pascal NEW_CONSTANT_NODE(unsigned char kind,
                                     unsigned int value1, unsigned int value2)
{
    _SI = POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OP_POOL_SEG), 4);
    POOL_ALLOC((char far *)MK_FP(_DS, (unsigned)&CODE_OPERAND_POOL_SEG), 4);
    _ES = CODE_OP_POOL_SEG;
    *((unsigned char far *)MK_FP(_ES, _SI)) = kind;
    *((unsigned char far *)MK_FP(_ES, _SI + COP_FLAGS)) = 0;
    *((unsigned int far *)MK_FP(_ES, _SI + COP_REGISTER)) = 0;
    _ES = CODE_OPERAND_POOL_SEG;
    _AX = value1;
    _DX = value2;
    *((unsigned int far *)MK_FP(_ES, _SI + OPND_RIGHT)) = _AX;
    *((unsigned int far *)MK_FP(_ES, _SI)) = _DX;
    _AX = CODE_OP_NEXT_INDEX;
    CODE_OP_NEXT_INDEX++;
    return _AX;
}

/* ---- STAOV044 (listing ovr_1d5a_a169:1878) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int VARIABLE_TABLE_SEG;


/* MARK_VARIABLE_ACCESS: walks the block chain starting at 'list' (through CNODE_NEXT) and,
   for each variable leaf op in a code block (kind 0) or switch block (kind 4), sets bits in
   the variable's VAR_FLAGS: 0x34 when the op probably takes its address (table flag 8;
   this includes 4, 'in memory'), else 0x20 when the op is written to (COP_FLAGS 4), else
   0x40 for a read. Called by SPLICE_BLOCK_CHAIN and APPEND_BLOCK_CHAIN (FLOWBLK.C) as
   chains join the function's block list. */
void far pascal MARK_VARIABLE_ACCESS(register unsigned int list)
{
    unsigned long attributes;
    register unsigned int cursor, count;

    while (list) {
        if (CNODE_W(list, CNODE_KIND) == 0 || CNODE_W(list, CNODE_KIND) == 4) {
            cursor = CNODE_W(list, CNODE_FIRST_OP) * 4;
            count = CNODE_W(list, CNODE_OP_COUNT);
            while (count) {
                attributes = *((unsigned long near *)(CODE_OP_INFO_TABLE +
                    COP_B(cursor, COP_OPCODE) * 19));
                if (attributes & 1L) {
                    if (attributes & 8L) {
                        VAR_B(OPND_W(cursor, OPND_LEFT), VAR_FLAGS) |= 0x34;
                    } else {
                        if (COP_B(cursor, COP_FLAGS) & 4) {
                            VAR_B(OPND_W(cursor, OPND_LEFT), VAR_FLAGS) |= 0x20;
                        } else {
                            VAR_B(OPND_W(cursor, OPND_LEFT), VAR_FLAGS) |= 0x40;
                        }
                    }
                }
                count--;
                cursor += 4;
            }
        }
        list = CNODE_W(list, CNODE_NEXT);
    }
}

/* target: ovr146_C113UNIT */
/* Role: flow-graph blocks for the code generator. Entry points: NEW_BLOCK,
   NEW_ASM_STATEMENT_BLOCK, INIT_FUNCTION_STATE, NEW_SCOPE_ENTER_BLOCK, NEW_SWITCH_BLOCK,
   FINISH_FUNCTION_BLOCKS, NEW_SCOPE_EXIT_BLOCK, SET_SWITCH_BLOCK_INFO (+12 more). Map of
   all sources: docs/SOURCE-MAP.md. */
/* Original CO057 (ovr_1d51_a076) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the flow graph the back end works on. A function is a doubly linked list of
   flow blocks (FLOW_BLOCK_POOL_SEG, 0x2E bytes, fields CNODE_*; list in
   CODE_BLOCK_LIST_HEAD/TAIL, links CNODE_NEXT/CNODE_PREV). A code block (kind 0) owns a
   run of code ops (CNODE_FIRST_OP, CNODE_OP_COUNT: ops are numbered in creation order,
   so a block simply records CODE_OP_NEXT_INDEX before and after generating its
   expression) and may end in a jump (CNODE_JUMP_KIND: 0 none, 1 always, 0x0A jump if
   zero/equal, 0x0B if not zero/not equal, other conditions from EMIT_COMPARE, CGEXPR.C;
   CNODE_TARGET the target block). Other kinds: 1 scope entry and 2 scope exit (debug
   information and register-variable lifetimes), 3 label (an empty target), 4 switch,
   5 inline assembler. The statement layer (STMTBLK.C) calls the NEW_* builders here and
   links their results with APPEND_BLOCK_CHAIN, SPLICE_BLOCK_CHAIN and JOIN_BLOCK_CHAINS;
   JOIN_BLOCK_CHAINS merges a code block into the one before it when nothing separates
   them, so straight-line code ends up in few blocks. When a block chain enters the list
   its loop weight (CNODE_LOOP_WEIGHT, from LOOP_NEST_FACTOR) is set and its variables'
   access flags are recorded (MARK_VARIABLE_ACCESS, CODENODE.C).
   Conditions become jumps through EMIT_COND_JUMP_TRUE/FALSE, which split && and || into
   several blocks. LABEL_REGISTER_NEED labels an expression tree with the registers each
   node needs before it is generated.
   When source debugging, line numbers or assembler output are on, each new block starts
   with line-mark ops (op 1, COP_FLAGS 0x40) for the statement's location and the current
   token's location (the 'fourth'/'third' and 'second'/'first' arguments).
   Field names to watch: NEW_SCOPE_ENTER_BLOCK writes scope fields through switch-block
   names of the same offsets (CNODE_TARGET for CNODE_SCOPE_PARENT, CNODE_CASE_LIST for
   CNODE_SCOPE_INFO, CNODE_SWITCH_LOW_OP for CNODE_SCOPE_CHILD, CNODE_SWITCH_HIGH_OP for
   CNODE_SCOPE_SIBLING, CNODE_FIRST_OP for CNODE_SCOPE_REG_MASK); several functions use raw
   word indexes ([0] kind, [4] jump kind, [7] CNODE_PREV, [8] offset 0x10, [9] offset
   0x12, [14] CNODE_FLAGS). */
#include <dos.h>
#include <stdlib.h>
#include "DATA.H"
#include "HEAP.H"
#include "POOL.H"



/* ---- STAOV017 (listing ovr_1d51_a076:0760) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
extern void far * far pascal RTL_MEMSET(void far *,int,unsigned int);
/* NEW_BLOCK: allocates a zeroed flow block (kind 0) whose op run starts at the next op
   number, with no code fragment yet (CNODE_FRAGMENT 0xFFFF). Returns its offset. */
unsigned int far pascal NEW_BLOCK(void)
{
    register unsigned int node=POOL_ALLOC_REUSE(&FLOW_BLOCK_POOL_SEG,0x2E);
    RTL_MEMSET(MK_FP(FLOW_BLOCK_POOL_SEG,node),0,0x2E);
    CNODE_W(node,CNODE_FIRST_OP)=CODE_OP_NEXT_INDEX;
    CNODE_W(node,CNODE_FRAGMENT)=0xFFFF;
    return node;
}

/* ---- STAOV018 (listing ovr_1d51_a076:079B) ---- */
extern unsigned int STRING_POOL_SEG;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal STRING_LENGTH(unsigned int, unsigned int);
extern unsigned int far pascal POOL_ALLOC(char far *, unsigned int);
extern void far pascal RTL_MEMMOVE(
    unsigned char far *, unsigned int, unsigned int, unsigned int);

/* NEW_ASM_STATEMENT_BLOCK: makes a kind 5 block whose word at 0x12 is a text record in
   STRING_POOL_SEG: bytes 0xFF, 1, the four hex digits of 'fifth' (the source line, as
   EMIT_ASM_STATEMENT reads it back) written as letters 'a' to 'p', '1' when source file
   'fourth' is the function's own file (else '0'), then the
   text at the far pointer 'first':'second'. EMIT_FUNCTION_BODY passes that record to
   EMIT_ASM_STATEMENT, so this is probably an inline-assembler statement
   block (FIELDS.H calls kind 5 'asm label'). */
unsigned int far pascal NEW_ASM_STATEMENT_BLOCK(
    unsigned int first, unsigned int second, unsigned int third,
    unsigned int fourth, unsigned int fifth)
{
    unsigned int size;
    register unsigned int node;
    register unsigned int text;

    size = STRING_LENGTH(first, second) + 1;
    node = NEW_BLOCK();
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[0] = 5;
    text = POOL_ALLOC((char far *)&STRING_POOL_SEG, size + 7);
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[9] = text;
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[4] = 0;
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[0] = 0xFF;
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[1] = 1;
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[2] =
        ((fifth >> 12) & 0xF) + 'a';
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[3] =
        ((fifth >> 8) & 0xF) + 'a';
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[4] =
        ((fifth >> 4) & 0xF) + 'a';
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[5] =
        ((fifth >> 0) & 0xF) + 'a';
    ((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[6] =
        (fourth == FUNCTION_SOURCE_FILE) + '0';
    RTL_MEMMOVE(
        &((unsigned char far *)MK_FP(STRING_POOL_SEG, text))[7],
        first, second, size);
    return node;
}

/* ---- STAOV019 (listing ovr_1d51_a076:0860) ---- */
unsigned int far pascal NEW_LABEL(void);

/* INIT_FUNCTION_STATE: starts a new function for the back end (called by
   START_FUNCTION_STATE): clears the per-function globals from CODEGEN_FUNCTION_SYMBOL up
   to CODEGEN_FUNCTION_FLAGS (0x21 bytes at DS:86D4), counts FUNCTION_SERIAL, stores the
   function's symbol, return type, parameters, calling convention, flags, code segment and
   source position, makes FUNCTION_RETURN_LABEL, restarts op numbering at 1 and clears the
   register masks. Always returns 1. */
unsigned int far pascal INIT_FUNCTION_STATE(
    unsigned int tenth, unsigned int ninth, unsigned int eighth,
    unsigned char seventh, unsigned char sixth, unsigned int fifth,
    unsigned int fourth, unsigned int third, unsigned int second,
    unsigned int first)
{
    RTL_MEMSET((char far *)MK_FP(_DS, 0x86D4), 0, 0x21);
    FUNCTION_SERIAL++;
    CODEGEN_FUNCTION_SYMBOL = tenth;
    CODEGEN_RETURN_TYPE = ninth;
    CODEGEN_PARAM_LIST = eighth;
    CODEGEN_CALL_CONV = seventh;
    CODEGEN_FUNCTION_FLAGS = sixth;
    FUNCTION_CODE_SEGMENT = fifth;
    FUNCTION_SOURCE_FILE = fourth;
    FUNCTION_START_LINE = third;
    _AX = second;
    _DX = first;
    FUNCTION_SOURCE_POS_HIGH = _AX;
    FUNCTION_SOURCE_POS_LOW = _DX;
    FUNCTION_RETURN_LABEL = NEW_LABEL();
    CODE_OP_NEXT_INDEX = 1;
    CODEGEN_USED_REG_MASK = 0;
    FUNCTION_CLAIMED_REG_MASK = 0;
    return 1;
}

/* ---- STAOV020 (listing ovr_1d51_a076:08D8) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* NEW_SCOPE_ENTER_BLOCK: makes the scope entry block for scope record 'value' under the
   entry block 'node' of the enclosing scope, linking it as the first child of 'node' (see
   the overview for the field names used). The first one becomes
   FUNCTION_OUTER_SCOPE_BLOCK; it becomes CURRENT_SCOPE_BLOCK. Returns the block. */
unsigned int far pascal NEW_SCOPE_ENTER_BLOCK(unsigned int value, register unsigned int node)
{
    register unsigned int result;

    result = NEW_BLOCK();
    CNODE_W(result, CNODE_KIND) = 1;
    CNODE_W(result, CNODE_SCOPE_PARENT) = node;
    if (CNODE_W(node, CNODE_SCOPE_CHILD) != 0)
        CNODE_W(result, CNODE_SCOPE_SIBLING) = CNODE_W(node, CNODE_SCOPE_CHILD);
    CNODE_W(node, CNODE_SCOPE_CHILD) = result;
    CNODE_W(result, CNODE_SCOPE_INFO) = value;
    CNODE_W(result, CNODE_SCOPE_REG_MASK) = 0;
    if (FUNCTION_OUTER_SCOPE_BLOCK == 0)
        FUNCTION_OUTER_SCOPE_BLOCK = result;
    CURRENT_SCOPE_BLOCK = result;
    return result;
}

/* ---- STAOV021 (listing ovr_1d51_a076:092E) ---- */
unsigned int far pascal LABEL_REGISTER_NEED(register unsigned int node);
extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned char OPTION_LINE_NUMBERS;
extern unsigned char COMPILER_MODE;
extern unsigned int EXPR_POOL_SEG;
extern unsigned int ERROR_COUNT;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                    unsigned int, unsigned int);
extern long far pascal GENERATE_EXPRESSION(unsigned int, unsigned int);
extern void (far pascal *RESET_EXPR_POOL_HOOK)(void);

/* NEW_SWITCH_BLOCK: makes the switch block (kind 4, the new CURRENT_CODE_BLOCK) for
   selector expression 'fifth': generates it (after LABEL_REGISTER_NEED) and keeps the
   result ops in CNODE_SWITCH_LOW_OP/HIGH_OP. CNODE_FLAGS 4 marks a long selector (kind 7
   and up), 0x200 an unsigned one (kinds 2, 4, 6). The case list and default come later
   (SET_SWITCH_BLOCK_INFO); SWITCH.C lowers the block. */
unsigned int far pascal NEW_SWITCH_BLOCK(
    unsigned int fifth, unsigned int fourth, unsigned int third,
    unsigned int second, unsigned int first)
{
    long value;

    _SI = fifth;
    _DI = fourth;
    CURRENT_CODE_BLOCK = NEW_BLOCK();
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        if (_DI)
            NEW_CODE_NODE(1, 0x40, _DI, third);
        if (second && (second != _DI || first != third))
            NEW_CODE_NODE(1, 0x40, second, first);
    }
    if (ERROR_COUNT == 0) {
        GENERATE_EXPRESSION(LABEL_REGISTER_NEED(_SI), 1);
        ((unsigned int *)&value)[1] = _DX;
    } else {
        _AX = 0;
        ((unsigned int *)&value)[1] = _AX;
    }
    ((unsigned int *)&value)[0] = _AX;
    _BX = CURRENT_CODE_BLOCK;
    _ES = FLOW_BLOCK_POOL_SEG;
    *((long far *)MK_FP(_ES, _BX + CNODE_SWITCH_LOW_OP)) = value;
    _AX = CODE_OP_NEXT_INDEX;
    _AX -= *((unsigned int far *)MK_FP(_ES, _BX + CNODE_FIRST_OP));
    *((unsigned int far *)MK_FP(_ES, _BX + CNODE_OP_COUNT)) = _AX;
    _ES = EXPR_POOL_SEG;
    if (*((int far *)MK_FP(_ES, _SI + EXPR_KIND)) >= 7) {
        _ES = FLOW_BLOCK_POOL_SEG;
        *((unsigned int far *)MK_FP(_ES, _BX + CNODE_FLAGS)) |= 4;
    } else if (*((int far *)MK_FP(EXPR_POOL_SEG, _SI + EXPR_KIND)) == 2 ||
               *((int far *)MK_FP(EXPR_POOL_SEG, _SI + EXPR_KIND)) == 4 ||
               *((int far *)MK_FP(EXPR_POOL_SEG, _SI + EXPR_KIND)) == 6) {
        _BX = CURRENT_CODE_BLOCK;
        _ES = FLOW_BLOCK_POOL_SEG;
        *((unsigned int far *)MK_FP(_ES, _BX + CNODE_FLAGS)) |= 0x200;
    }
    _ES = FLOW_BLOCK_POOL_SEG;
    _BX = CURRENT_CODE_BLOCK;
    *((unsigned int far *)MK_FP(_ES, _BX)) = 4;
    RESET_EXPR_POOL_HOOK();
    return CURRENT_CODE_BLOCK;
}

/* ---- STAOV022 (listing ovr_1d51_a076:0A30) ---- */
void far pascal APPEND_BLOCK_CHAIN( unsigned int third, register unsigned int second, register unsigned int first);
extern unsigned int ERROR_COUNT;
extern void far pascal GENERATE_FUNCTION_CODE(unsigned int, unsigned int);

/* FINISH_FUNCTION_BLOCKS: ends the function: appends FUNCTION_RETURN_LABEL, generates the
   code when there were no errors (GENERATE_FUNCTION_CODE, with 'second'/'third' the
   closing source position), records the lowest free heap seen in MIN_FREE_HEAP and empties
   the code-op, operand, code-node and case pools. 'first' is not used. */
void far pascal FINISH_FUNCTION_BLOCKS(
    unsigned int first, unsigned int second, unsigned int third)
{
    long value;

    APPEND_BLOCK_CHAIN(0, FUNCTION_RETURN_LABEL, 1);
    if (ERROR_COUNT == 0)
        GENERATE_FUNCTION_CODE(second, third);
    value = HEAP_SPACE_BELOW_LIMIT() - HEAP_RESERVE_BYTES;
    if (value < MIN_FREE_HEAP)
        MIN_FREE_HEAP = value;
    CODE_OP_POOL_USED = 0;
    CODE_OP_POOL_UNIT = 4;
    CODE_OPERAND_POOL_USED = 0;
    CODE_OPERAND_POOL_UNIT = 4;
    CODE_NODE_POOL_USED = 0;
    CODE_NODE_POOL_UNIT = 2;
    CASE_ENTRY_POOL_USED = 0;
    CASE_ENTRY_POOL_UNIT = 2;
}

/* ---- STAOV023 (listing ovr_1d51_a076:0AC2) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* NEW_SCOPE_EXIT_BLOCK: makes the scope exit block (kind 2) for scope entry block
   'value' (word 8 = CNODE_SCOPE_ENTRY) and returns to the enclosing scope
   (CURRENT_SCOPE_BLOCK = the entry's CNODE_SCOPE_PARENT, also word 8). */
unsigned int far pascal NEW_SCOPE_EXIT_BLOCK(unsigned int value)
{
    register unsigned int result;
    register unsigned int node = value;

    result = NEW_BLOCK();
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, result))[0] = 2;
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, result))[8] = node;
    CURRENT_SCOPE_BLOCK = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[8];
    return result;
}

/* ---- STAOV024 (listing ovr_1d51_a076:0AEC) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
#define WORD_AT(offset) (*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,(offset)))
/* SET_SWITCH_BLOCK_INFO: finds the first switch block from 'start' along CNODE_NEXT
   (offset 12) and sets its default target 'value1' (offset 16, CNODE_TARGET, with jump
   kind 1 at offset 8) and its case list 'value2' (offset 18, CNODE_CASE_LIST). */
void far pascal SET_SWITCH_BLOCK_INFO(unsigned int start,unsigned int value1,unsigned int value2)
{
    register unsigned int node=start;
    while(WORD_AT(node)!=4) node=WORD_AT(node+12);
    WORD_AT(node+16)=value1;
    WORD_AT(node+8)=1;
    WORD_AT(node+18)=value2;
}
#undef WORD_AT

/* ---- STAOV025 (listing ovr_1d51_a076:0B20) ---- */
extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned char OPTION_LINE_NUMBERS;
extern unsigned char COMPILER_MODE;
extern unsigned int ERROR_COUNT;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                    unsigned int, unsigned int);
extern void (far pascal *RESET_EXPR_POOL_HOOK)(void);

/* NEW_EXPRESSION_BLOCK: makes a code block (the new CURRENT_CODE_BLOCK) that evaluates
   expression 'fifth' for its side effects (GENERATE_EXPRESSION with mode 0, after
   LABEL_REGISTER_NEED; skipped after errors). */
unsigned int far pascal NEW_EXPRESSION_BLOCK(
    unsigned int fifth, unsigned int fourth, unsigned int third,
    unsigned int second, unsigned int first)
{
    unsigned int result;
    register unsigned int left = fourth;
    register unsigned int right = second;

    result = NEW_BLOCK();
    CURRENT_CODE_BLOCK = result;
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        if (left)
            NEW_CODE_NODE(1, 0x40, left, third);
        if (right && (right != left || first != third))
            NEW_CODE_NODE(1, 0x40, right, first);
    }
    if (fifth && ERROR_COUNT == 0)
        GENERATE_EXPRESSION(LABEL_REGISTER_NEED(fifth), 0);
    *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CURRENT_CODE_BLOCK + CNODE_OP_COUNT) =
        CODE_OP_NEXT_INDEX - *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CURRENT_CODE_BLOCK + CNODE_FIRST_OP);
    RESET_EXPR_POOL_HOOK();
    return result;
}

/* ---- STAOV026 (listing ovr_1d51_a076:0BC0) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal MARK_VARIABLE_ACCESS(unsigned int value);


/* SPLICE_BLOCK_CHAIN: inserts the block chain starting at 'value2' after block 'value3'
   (at the list head when 'value3' is 0), giving its blocks loop weight 'value1' and
   recording their variable accesses. */
void far pascal SPLICE_BLOCK_CHAIN(unsigned int value3, unsigned int value2,
                        unsigned int value1)
{
    unsigned int previous;

    if (value2 != 0) {
        MARK_VARIABLE_ACCESS(value2);
        CNODE_W(value2, CNODE_LOOP_WEIGHT) = value1;
        CNODE_W(value2, CNODE_PREV) = value3;
        if (value3 == 0) {
            previous = CODE_BLOCK_LIST_HEAD;
            CODE_BLOCK_LIST_HEAD = value2;
        } else {
            previous = CNODE_W(value3, CNODE_NEXT);
            CNODE_W(value3, CNODE_NEXT) = value2;
        }
        while (CNODE_W(value2, CNODE_NEXT) != 0) {
            value2 = CNODE_W(value2, CNODE_NEXT);
            CNODE_W(value2, CNODE_LOOP_WEIGHT) = value1;
        }
        CNODE_W(value2, CNODE_NEXT) = previous;
        CNODE_W(previous, CNODE_PREV) = value2;
    }
}

/* ---- STAOV027 (listing ovr_1d51_a076:0C37) ---- */
extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned char OPTION_LINE_NUMBERS;
extern unsigned char COMPILER_MODE;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                    unsigned int, unsigned int);

/* NEW_JUMP_BLOCK: makes a block that only jumps unconditionally to block 'fifth' (after
   its line marks). */
unsigned int far pascal NEW_JUMP_BLOCK(
    unsigned int fifth, register unsigned int fourth, unsigned int third,
    unsigned int second, unsigned int first)
{
    register unsigned int result;

    result = NEW_BLOCK();
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        if (fourth)
            NEW_CODE_NODE(1, 0x40, fourth, third);
        if (second && (second != fourth || first != third))
            NEW_CODE_NODE(1, 0x40, second, first);
        CNODE_W(result, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(result, CNODE_FIRST_OP);
    }
    CNODE_W(result, CNODE_JUMP_KIND) = 1;
    CNODE_W(result, CNODE_TARGET) = fifth;
    return result;
}

/* ---- STAOV028 (listing ovr_1d51_a076:0CBB) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* NEW_LABEL: makes an empty label block (kind 3), a jump target. */
unsigned int far pascal NEW_LABEL(void)
{
    register unsigned int value;

    value = NEW_BLOCK();
    *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, value) = 3;
    return value;
}

/* ---- STAOV029 (listing ovr_1d51_a076:0CD1) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* SET_BLOCK_1C_FLAG_1: sets bit 1 in CNODE_FLAGS (word 14) of 'node'. Used by
   APPEND_BLOCK_AND_MARK and by the switch statement parser (parser/STMTC.C); what the bit
   means is not visible here. */
void far pascal SET_BLOCK_1C_FLAG_1(unsigned int node)
{
    ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[14] |= 1;
}

/* ---- STAOV030 (listing ovr_1d51_a076:0CE7) ---- */
void far pascal JOIN_BLOCK_CHAINS(unsigned int first, unsigned int second);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal MARK_VARIABLE_ACCESS(unsigned int);
extern void far pascal EMIT_STACK_CHECK(void);

/* APPEND_BLOCK_CHAIN: appends the chain containing block 'second' (first rewound to its
   first block through CNODE_PREV, word 7) to the end of the function's list, merging
   where possible, and gives the appended blocks loop weight 'first'. 'third' is not
   used. Appending the outermost scope's entry block (kind 1 with no parent) also emits the
   stack check (EMIT_STACK_CHECK, CGEXPR.C). */
void far pascal APPEND_BLOCK_CHAIN(
    unsigned int third, register unsigned int second, register unsigned int first)
{
    if (second == 0)
        return;
    while (((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, second))[7] != 0)
        second = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, second))[7];
    MARK_VARIABLE_ACCESS(second);
    *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, second + CNODE_LOOP_WEIGHT)) = first;
    if (CODE_BLOCK_LIST_HEAD != 0) {
        JOIN_BLOCK_CHAINS(CODE_BLOCK_LIST_TAIL, second);
    } else {
        CODE_BLOCK_LIST_HEAD = second;
        CODE_BLOCK_LIST_TAIL = second;
    }
    while (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CODE_BLOCK_LIST_TAIL + CNODE_NEXT)) != 0) {
        CODE_BLOCK_LIST_TAIL = *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CODE_BLOCK_LIST_TAIL + CNODE_NEXT));
        *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CODE_BLOCK_LIST_TAIL + CNODE_LOOP_WEIGHT)) = first;
    }
    if (*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, second)) == 1 &&
        *((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, second + CNODE_TARGET)) == 0)
        EMIT_STACK_CHECK();
}

/* ---- STAOV031 (listing ovr_1d51_a076:0D74) ---- */
extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned char OPTION_LINE_NUMBERS;
extern unsigned char COMPILER_MODE;
extern unsigned int ERROR_COUNT;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                    unsigned int, unsigned int);
extern void far pascal EMIT_RETURN_VALUE(unsigned int);
extern void (far pascal *RESET_EXPR_POOL_HOOK)(void);

/* NEW_RETURN_JUMP_BLOCK: 'return fifth;': a code block that loads the return value
   (EMIT_RETURN_VALUE) followed by a jump to FUNCTION_RETURN_LABEL. Returns the first block. */
unsigned int far pascal NEW_RETURN_JUMP_BLOCK(
    unsigned int fifth, unsigned int fourth, unsigned int third,
    unsigned int second, unsigned int first)
{
    register unsigned int left = fourth;
    register unsigned int right = second;
    unsigned int result;
    result = NEW_BLOCK();
    CURRENT_CODE_BLOCK = result;
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        if (left)
            NEW_CODE_NODE(1, 0x40, left, third);
        if (right && (right != left || first != third))
            NEW_CODE_NODE(1, 0x40, right, first);
    }
    if (fifth && ERROR_COUNT == 0)
        EMIT_RETURN_VALUE(fifth);
    *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CURRENT_CODE_BLOCK + CNODE_OP_COUNT) =
        CODE_OP_NEXT_INDEX - *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, CURRENT_CODE_BLOCK + CNODE_FIRST_OP);
    RESET_EXPR_POOL_HOOK();
    JOIN_BLOCK_CHAINS(result, NEW_JUMP_BLOCK(FUNCTION_RETURN_LABEL, 0, 0, 0, 0));
    return result;
}

/* ---- STAOV032 (listing ovr_1d51_a076:0E22) ---- */
static unsigned int near pascal EMIT_COND_JUMP_TRUE( unsigned int second, unsigned int first);
static unsigned int near pascal EMIT_COND_JUMP_FALSE( unsigned int second, unsigned int first);
extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned char OPTION_LINE_NUMBERS;
extern unsigned char COMPILER_MODE;
extern unsigned int ERROR_COUNT;
extern void far pascal NEW_CODE_NODE(unsigned int, unsigned char,
                                    unsigned int, unsigned int);
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);

/* NEW_BRANCH_BLOCK: makes the blocks for 'if condition 'sixth' is true ('seventh' set) or
   false, jump to block 'fifth''. Returns the first block, or 0 after errors (the new
   block is freed when nothing was made). */
unsigned int far pascal NEW_BRANCH_BLOCK(
    unsigned int seventh, unsigned int sixth, unsigned int fifth,
    register unsigned int fourth, unsigned int third, unsigned int second,
    unsigned int first)
{
    unsigned int result;
    register unsigned int found;

    result = CURRENT_CODE_BLOCK = NEW_BLOCK();
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        if (fourth)
            NEW_CODE_NODE(1, 0x40, fourth, third);
        if (second && (second != fourth || first != third))
            NEW_CODE_NODE(1, 0x40, second, first);
    }
    if (ERROR_COUNT == 0) {
        if (seventh)
            found = EMIT_COND_JUMP_TRUE(sixth, fifth);
        else
            found = EMIT_COND_JUMP_FALSE(sixth, fifth);
        if (found == 0)
            POOL_FREE_ITEM(&FLOW_BLOCK_POOL_SEG, result);
    } else {
        found = 0;
    }
    return found;
}

/* ---- STAOV033 (listing ovr_1d51_a076:0EC6) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal EMIT_TEST_ZERO(unsigned int);
extern void far pascal EMIT_COMPARE(unsigned int, unsigned int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int, unsigned long);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int, unsigned int,
                                             unsigned int, unsigned int);


/* EMIT_COND_JUMP_TRUE: ends CURRENT_CODE_BLOCK with code for 'jump to block 'first' if
   expression 'second' is true' and returns the first block made. Constants decide at
   compile time; '&x' is always true; '!x' becomes 'jump if x is false'; 'a && b' skips
   over the test of b when a is false; 'a || b' tests both; comparisons go to EMIT_COMPARE;
   integer values are compared with 0, others tested by EMIT_TEST_ZERO and jump kind 0x0B. */
static unsigned int near pascal EMIT_COND_JUMP_TRUE(
    unsigned int second, unsigned int first)
{
    unsigned int result;
    unsigned int saved;
    register unsigned int current = CURRENT_CODE_BLOCK;

    switch (EXPR_I(second, EXPR_OP)) {
    case 2:
        if (*((long far *)MK_FP(EXPR_POOL_SEG, second + EXPR_LEFT)))
            goto nonzero;
        CNODE_W(current, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(current, CNODE_FIRST_OP);
        CNODE_W(current, CNODE_JUMP_KIND) = 0;
        return current;
    case 0x32:
nonzero:
        CNODE_W(current, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(current, CNODE_FIRST_OP);
        CNODE_W(current, CNODE_JUMP_KIND) = 1;
        CNODE_W(current, CNODE_TARGET) = first;
        return current;
    case 0x30:
        return EMIT_COND_JUMP_FALSE(EXPR_W(second, EXPR_LEFT), first);
    case 0x27:
        saved = NEW_LABEL();
        EMIT_COND_JUMP_FALSE(EXPR_W(second, EXPR_LEFT), saved);
        result = CURRENT_CODE_BLOCK = NEW_BLOCK();
        result = EMIT_COND_JUMP_TRUE(EXPR_W(second, EXPR_RIGHT), first);
        JOIN_BLOCK_CHAINS(result, saved);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    case 0x28:
        EMIT_COND_JUMP_TRUE(EXPR_W(second, EXPR_LEFT), first);
        result = CURRENT_CODE_BLOCK = NEW_BLOCK();
        result = EMIT_COND_JUMP_TRUE(EXPR_W(second, EXPR_RIGHT), first);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    case 0x1D:
    case 0x1E:
    case 0x1F:
    case 0x20:
    case 0x21:
    case 0x22:
        goto combine;
    default:
        if (EXPR_I(second, EXPR_KIND) <= 6) {
            second = NEW_EXPR_NODE_HOOK(0x1E, MODE_HOOK(5), second,
                NEW_CONST_NODE_HOOK(EXPR_W(second, EXPR_TYPE), 0L));
            goto combine;
        }
        EMIT_TEST_ZERO(second);
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(CURRENT_CODE_BLOCK, CNODE_FIRST_OP);
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_JUMP_KIND) = 0x0B;
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_TARGET) = first;
        return current;
    }

combine:
    EMIT_COMPARE(second, first);
    return current;
}

/* ---- STAOV034 (listing ovr_1d51_a076:107C) ---- */
unsigned int far pascal INVERT_COMPARE_OP(unsigned int index);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal EMIT_TEST_ZERO(unsigned int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int, unsigned long);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int, unsigned int,
                                             unsigned int, unsigned int);


/* EMIT_COND_JUMP_FALSE: the same for 'jump if false': '&&' and '||' change roles, a
   comparison is inverted (INVERT_COMPARE_OP) and handed to EMIT_COND_JUMP_TRUE, and a
   plain test jumps with kind 0x0A. */
static unsigned int near pascal EMIT_COND_JUMP_FALSE(
    register unsigned int second, unsigned int first)
{
    unsigned int result;
    unsigned int saved;
    register unsigned int current = CURRENT_CODE_BLOCK;

    switch (EXPR_I(second, EXPR_OP)) {
    case 2:
        if (*((long far *)MK_FP(EXPR_POOL_SEG, second + EXPR_LEFT)))
            goto nonzero;
        CNODE_W(current, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(current, CNODE_FIRST_OP);
        CNODE_W(current, CNODE_JUMP_KIND) = 1;
        CNODE_W(current, CNODE_TARGET) = first;
        return current;
nonzero:
        CNODE_W(current, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(current, CNODE_FIRST_OP);
        CNODE_W(current, CNODE_JUMP_KIND) = 0;
        return current;
    case 0x32:
        CNODE_W(current, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(current, CNODE_FIRST_OP);
        CNODE_W(current, CNODE_JUMP_KIND) = 0;
        return current;
    case 0x30:
        return EMIT_COND_JUMP_TRUE(EXPR_W(second, EXPR_LEFT), first);
    case 0x28:
        saved = NEW_LABEL();
        EMIT_COND_JUMP_TRUE(EXPR_W(second, EXPR_LEFT), saved);
        result = CURRENT_CODE_BLOCK = NEW_BLOCK();
        result = EMIT_COND_JUMP_FALSE(EXPR_W(second, EXPR_RIGHT), first);
        JOIN_BLOCK_CHAINS(result, saved);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    case 0x27:
        EMIT_COND_JUMP_FALSE(EXPR_W(second, EXPR_LEFT), first);
        result = CURRENT_CODE_BLOCK = NEW_BLOCK();
        result = EMIT_COND_JUMP_FALSE(EXPR_W(second, EXPR_RIGHT), first);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    case 0x1D:
    case 0x1E:
    case 0x1F:
    case 0x20:
    case 0x21:
    case 0x22:
        goto combine;
    default:
        if (EXPR_I(second, EXPR_KIND) <= 6) {
            second = NEW_EXPR_NODE_HOOK(0x1E, MODE_HOOK(5), second,
                NEW_CONST_NODE_HOOK(EXPR_W(second, EXPR_TYPE), 0L));
            goto combine;
        }
        EMIT_TEST_ZERO(second);
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(CURRENT_CODE_BLOCK, CNODE_FIRST_OP);
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_JUMP_KIND) = 0x0A;
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_TARGET) = first;
        return current;
    }

combine:
    EXPR_W(second, EXPR_OP) = INVERT_COMPARE_OP(EXPR_W(second, EXPR_OP));
    return EMIT_COND_JUMP_TRUE(second, first);
}

/* ---- STAOV035 (listing ovr_1d51_a076:1262) ---- */
static int near pascal EXPR_REGISTER_NEED(register unsigned int node);
extern unsigned int EXPR_POOL_SEG;

#define WORD(o) (*(int far *)MK_FP(EXPR_POOL_SEG, (o)))
#define BYTE(o) (*(signed char far *)MK_FP(EXPR_POOL_SEG, (o)))
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))

/* LABEL_REGISTER_NEED: labels expression tree 'node' bottom-up with the number of
   registers each node needs, stored in the EXPR_NODE_FLAGS byte (node+6; WORD(node) is
   EXPR_OP, node+2 EXPR_KIND, node+0x0A/0x0C the operands). EXPR_REGISTER_NEED gives the
   registers an operator needs for a value kind. For a binary node the need is the larger
   of each operand's need and the cheaper of the two evaluation orders; the sign records
   which operand needs more (negative unless the right operand needs strictly more, or
   equally for an assignment, ops 0x12-0x1C); GENERATE_OPERATOR (CGOPER.C) generates the
   left operand first when it is negative. Returns 'node'. Called before each expression
   is generated (FLOWBLK.C, CGEXPR.C). */
unsigned int far pascal LABEL_REGISTER_NEED(register unsigned int node)
{
    int a, b, c, d, e;
    if (!node || WORD(node + 2) == 0) return node;
    switch (WORD(node)) {
    case 1:
        if (WORD(node + 4) & 0x10) BYTE(node + 6) = 1;
    case 2:
    case 3:
    case 4:
    case 5:
    case 7:
        node = node; /* Preserve the original branch join. */
        return node;
    case 0x33:
        WORD(node + 0x0A) = LABEL_REGISTER_NEED(WORD(node + 0x0A));
        BYTE(node + 6) = -BYTE(WORD(node + 0x0A) + 6);
        return node;
    case 0x32:
        WORD(node + 0x0A) = LABEL_REGISTER_NEED(WORD(node + 0x0A));
        if (WORD(WORD(node + 0x0A)) == 5 || WORD(WORD(node + 0x0A)) == 6)
            BYTE(node + 6) = 1;
        else {
            _ES = EXPR_POOL_SEG;
            _BX = *(unsigned int far *)MK_FP(_ES, node + EXPR_LEFT);
            _AL = *(signed char far *)MK_FP(_ES, _BX + EXPR_NODE_FLAGS);
            *(signed char far *)MK_FP(_ES, node + EXPR_NODE_FLAGS) = _AL;
        }
        node = node; /* Preserve the original branch join. */
        break;
    default:
    WORD(node + 0x0A) = LABEL_REGISTER_NEED(WORD(node + 0x0A));
    if (WORD(node + 0x0C))
        WORD(node + 0x0C) = LABEL_REGISTER_NEED(WORD(node + 0x0C));
    a = EXPR_REGISTER_NEED(node);
    b = EXPR_REGISTER_NEED(WORD(node + 0x0A));
    d = abs(BYTE(WORD(node + 0x0A) + 6));
    if (WORD(node) == 0x23 || WORD(node) == 0x24) d += a;
    if (WORD(node + 0x0C)) {
        c = EXPR_REGISTER_NEED(WORD(node + 0x0C));
        e = abs(BYTE(WORD(node + 0x0C) + 6));
    } else {
        BYTE(node + 6) = -MAX(a,d);
        break;
    }
        BYTE(node + 6) = MAX(e,MAX(d,MAX(a,MIN(e+b,d+c))));
        if (d < e) return node;
        if (d == e && WORD(node) >= 0x12 && WORD(node) <= 0x1C) return node;
        BYTE(node + 6) = -BYTE(node + 6);

    }
    return node;
}
#undef WORD
#undef BYTE
#undef MIN
#undef MAX

/* ---- STAOV036 (listing ovr_1d51_a076:1550) ---- */
extern unsigned int EXPR_POOL_SEG;

/* EXPR_REGISTER_NEED: returns the register need of node 'node' from a
   table at DS:51DF indexed by the operator's class (byte table at DS:5234 by EXPR_OP)
   times 21 plus the value kind. */
static int near pascal EXPR_REGISTER_NEED(register unsigned int node)
{
    return ((signed char near *)0x51DF)[
        *((signed char near *)(*(unsigned int far *)MK_FP(EXPR_POOL_SEG, node) + 0x5234)) * 21 +
        ((unsigned int far *)MK_FP(EXPR_POOL_SEG, node))[1]];
}

/* ---- STAOV037 (listing ovr_1d51_a076:157A) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;


/* JOIN_BLOCK_CHAINS: appends the chain 'second' after the last block of the chain
   containing 'first'. While both ends are plain code blocks and the first does not jump,
   they are merged: an empty block just hands over its jump, and a block whose ops directly
   follow the previous block's ops extends it; merged blocks are freed. */
void far pascal JOIN_BLOCK_CHAINS(unsigned int first, unsigned int second)
{
    unsigned int next;
    register unsigned int source,destination;

    destination = first;
    source = second;
    if (!source) return;

    while (CNODE_W(destination, CNODE_NEXT)) {

        destination = CNODE_W(destination, CNODE_NEXT);
    }
    while (source) {

        if (CNODE_W(destination, CNODE_KIND) == 0 &&
            CNODE_W(source, CNODE_KIND) == 0 &&
            CNODE_W(destination, CNODE_JUMP_KIND) == 0) {
            if (CNODE_W(source, CNODE_OP_COUNT) == 0) {
                CNODE_W(destination, CNODE_JUMP_KIND) = CNODE_W(source, CNODE_JUMP_KIND);
                CNODE_W(destination, CNODE_TARGET) = CNODE_W(source, CNODE_TARGET);
                CNODE_W(destination, CNODE_FLAGS) |= CNODE_W(source, CNODE_FLAGS);
                next = CNODE_W(source, CNODE_NEXT);
                POOL_FREE_ITEM(&FLOW_BLOCK_POOL_SEG, source);
                source = next;
            } else {

                if (CNODE_W(destination, CNODE_FIRST_OP) + CNODE_W(destination, CNODE_OP_COUNT) == CNODE_W(source, CNODE_FIRST_OP)) {
                    CNODE_W(destination, CNODE_OP_COUNT) += CNODE_W(source, CNODE_OP_COUNT);
                    CNODE_W(destination, CNODE_JUMP_KIND) = CNODE_W(source, CNODE_JUMP_KIND);
                    CNODE_W(destination, CNODE_TARGET) = CNODE_W(source, CNODE_TARGET);
                    CNODE_W(destination, CNODE_FLAGS) |= CNODE_W(source, CNODE_FLAGS);
                    next = CNODE_W(source, CNODE_NEXT);
                    POOL_FREE_ITEM(&FLOW_BLOCK_POOL_SEG, source);
                    source = next;
                } else {

                    CNODE_W(source, CNODE_PREV) = destination;
                    break;
                }
            }
        } else {

            CNODE_W(source, CNODE_PREV) = destination;
            break;
        }
    }

    CNODE_W(destination, CNODE_NEXT) = source;
}

/* ---- STAOV038 (listing ovr_1d51_a076:166E) ---- */

/* INVERT_COMPARE_OP: the comparison operator with the opposite result (e.g. == for !=),
   from INVERT_COMPARE_TABLE. */
unsigned int far pascal INVERT_COMPARE_OP(unsigned int index)
{
    return INVERT_COMPARE_TABLE[index];
}

/* ---- STAOV039 (listing ovr_1d51_a076:167E) ---- */

/* MIRROR_COMPARE_OP: the comparison operator for swapped operands (e.g. > for <), from
   MIRROR_COMPARE_TABLE. */
unsigned int far pascal MIRROR_COMPARE_OP(unsigned int index)
{
    return MIRROR_COMPARE_TABLE[index];
}

/* flowblk.c: from bcc20/src/codegen/FLOWBLK.C (overlay CO057): the flow graph the back end
   works on.  A function is a doubly linked list of flow blocks (FLOW_BLOCK_POOL_SEG, 2Eh
   bytes, fields CNODE_*; list in CODE_BLOCK_LIST_HEAD/TAIL, links CNODE_NEXT/CNODE_PREV).
   A code block (kind 0) owns a run of code ops (CNODE_FIRST_OP, CNODE_OP_COUNT: ops are
   numbered in creation order, so a block records CODE_OP_NEXT_INDEX before and after
   generating its expression) and may end in a jump (CNODE_JUMP_KIND: 0 none, 1 always, 0Ah
   jump if zero, 0Bh if not zero, other conditions from EMIT_COMPARE; CNODE_TARGET the target
   block).  Other kinds: 1 scope entry and 2 scope exit, 3 label (an empty target), 4 switch,
   5 inline assembler.  The statement layer calls the NEW_* builders here and links their
   results with APPEND_BLOCK_CHAIN, SPLICE_BLOCK_CHAIN and JOIN_BLOCK_CHAINS;
   JOIN_BLOCK_CHAINS merges a code block into the one before it when nothing separates
   them.  When a chain enters the list its loop weight is set and its variables' access
   flags are recorded (MARK_VARIABLE_ACCESS).
   Conditions become jumps through EMIT_COND_JUMP_TRUE/FALSE, which split && and || into
   several blocks.  LABEL_REGISTER_NEED labels an expression tree with the registers each
   node needs before it is generated.
   When source debugging, line numbers or assembler output are on, each new block starts
   with line-mark ops (op 1, COP_FLAGS 40h) for the statement's location (file, line) and
   the current token's location (token_file, token_line). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_LINE_NUMBERS B(OPTION_LINE_NUMBERS_P)
#define COMPILER_MODE B(COMPILER_MODE_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)

static void reset_expr_pool(void) { CALL_FAR0(RESET_EXPR_POOL_HOOK); }

/* the line-mark ops at the start of a new block: the statement's position, then the
   current token's when it differs */
static void line_marks(u16 file, u16 line, u16 token_file, u16 token_line)
{
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        if (file)
            NEW_CODE_NODE(1, 0x40, file, line);
        if (token_file && (token_file != file || token_line != line))
            NEW_CODE_NODE(1, 0x40, token_file, token_line);
    }
}

/* the op count of block: the ops made since its first */
static void close_ops(u16 block)
{
    CNODE_W(block, CNODE_OP_COUNT) = CODE_OP_NEXT_INDEX - CNODE_W(block, CNODE_FIRST_OP);
}

/* a zeroed flow block (kind 0) whose op run starts at the next op number, with no code
   fragment yet (CNODE_FRAGMENT FFFFh) */
u16 NEW_BLOCK(void)
{
    u16 node = POOL_ALLOC_REUSE(FLOW_BLOCK_POOL_SEG_P, 0x2E);
    RTL_MEMSET(MK_FP(FLOW_BLOCK_POOL_SEG, node), 0, 0x2E);
    CNODE_W(node, CNODE_FIRST_OP) = CODE_OP_NEXT_INDEX;
    CNODE_W(node, CNODE_FRAGMENT) = 0xFFFF;
    return node;
}

/* a kind 5 (inline assembler) block whose CNODE_ASM_TEXT is a text record in
   STRING_POOL_SEG: FFh, 1, the four hex digits of line as letters 'a' to 'p', '1' when file
   is the function's own source file (else '0'), then the text at segment:offset */
u16 NEW_ASM_STATEMENT_BLOCK(u16 segment, u16 offset, u16 unused, u16 file, u16 line)
{
    (void)unused;
    u16 size = STRING_LENGTH(MK_FP(segment, offset)) + 1;
    u16 node = NEW_BLOCK();
    CNODE_W(node, CNODE_KIND) = 5;
    u16 text = POOL_ALLOC(STRING_POOL_SEG_P, size + 7);
    CNODE_W(node, CNODE_ASM_TEXT) = text;
    CNODE_W(node, CNODE_JUMP_KIND) = 0;
    farptr record = MK_FP(STRING_POOL_SEG, text);
    B(record) = 0xFF;
    B(fp_add(record, 1)) = 1;
    B(fp_add(record, 2)) = ((line >> 12) & 0xF) + 'a';
    B(fp_add(record, 3)) = ((line >> 8) & 0xF) + 'a';
    B(fp_add(record, 4)) = ((line >> 4) & 0xF) + 'a';
    B(fp_add(record, 5)) = (line & 0xF) + 'a';
    B(fp_add(record, 6)) = (file == FUNCTION_SOURCE_FILE) + '0';
    RTL_MEMMOVE(fp_add(record, 7), MK_FP(segment, offset), size);
    return node;
}

/* starts a new function for the back end: clears the per-function globals from
   CODEGEN_FUNCTION_SYMBOL up to CODEGEN_FUNCTION_FLAGS (21h bytes at DS:86D4), counts
   FUNCTION_SERIAL, stores the function's symbol, return type, parameters, calling
   convention, flags, code segment and source position, makes FUNCTION_RETURN_LABEL,
   restarts op numbering at 1 and clears the register masks.  Always returns 1 */
u16 INIT_FUNCTION_STATE(u16 symbol, u16 return_type, u16 params, u8 call_conv, u8 flags,
                        u16 segment, u16 file, u16 line, u16 position_high, u16 position_low)
{
    RTL_MEMSET(CODEGEN_FUNCTION_SYMBOL_P, 0, 0x21);
    FUNCTION_SERIAL++;
    CODEGEN_FUNCTION_SYMBOL = symbol;
    CODEGEN_RETURN_TYPE = return_type;
    CODEGEN_PARAM_LIST = params;
    CODEGEN_CALL_CONV = call_conv;
    CODEGEN_FUNCTION_FLAGS = flags;
    FUNCTION_CODE_SEGMENT = segment;
    FUNCTION_SOURCE_FILE = file;
    FUNCTION_START_LINE = line;
    FUNCTION_SOURCE_POS_HIGH = position_high;
    FUNCTION_SOURCE_POS_LOW = position_low;
    u16 label = NEW_LABEL();
    FUNCTION_RETURN_LABEL = label;
    CODE_OP_NEXT_INDEX = 1;
    CODEGEN_USED_REG_MASK = 0;
    FUNCTION_CLAIMED_REG_MASK = 0;
    return 1;
}

/* the scope entry block for scope record value under the entry block node of the
   enclosing scope, linked as node's first child.  The first one becomes
   FUNCTION_OUTER_SCOPE_BLOCK; it becomes CURRENT_SCOPE_BLOCK */
u16 NEW_SCOPE_ENTER_BLOCK(u16 value, u16 node)
{
    u16 result = NEW_BLOCK();
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

/* the switch block (kind 4, the new CURRENT_CODE_BLOCK) for selector expression
   selector: generated (after LABEL_REGISTER_NEED) with its result ops kept in
   CNODE_SWITCH_LOW_OP/HIGH_OP.  CNODE_FLAGS 4 marks a long selector (kind 7 and up), 200h
   an unsigned one (kinds 2, 4, 6).  The case list and default come later */
u16 NEW_SWITCH_BLOCK(u16 selector, u16 file, u16 line, u16 token_file, u16 token_line)
{
    u16 block = NEW_BLOCK();
    CURRENT_CODE_BLOCK = block;
    line_marks(file, line, token_file, token_line);
    u32 value = 0;
    if (ERROR_COUNT == 0)
        value = GENERATE_EXPRESSION(LABEL_REGISTER_NEED(selector), 1);
    block = CURRENT_CODE_BLOCK;
    D(MK_FP(FLOW_BLOCK_POOL_SEG, block + CNODE_SWITCH_LOW_OP)) = value;
    close_ops(block);
    i16 kind = EXPR_I(selector, EXPR_KIND);
    if (kind >= 7)
        CNODE_W(block, CNODE_FLAGS) |= 4;
    else if (kind == 2 || kind == 4 || kind == 6)
        CNODE_W(CURRENT_CODE_BLOCK, CNODE_FLAGS) |= 0x200;
    CNODE_W(CURRENT_CODE_BLOCK, CNODE_KIND) = 4;
    reset_expr_pool();
    return CURRENT_CODE_BLOCK;
}

/* ends the function: appends FUNCTION_RETURN_LABEL, generates the code when there were no
   errors (with segment:offset the closing source position), records the lowest free heap
   seen in MIN_FREE_HEAP and empties the code-op, operand, code-node and case pools.  The
   first parameter is not used */
void FINISH_FUNCTION_BLOCKS(u16 unused, u16 position_high, u16 position_low)
{
    (void)unused;
    APPEND_BLOCK_CHAIN(0, FUNCTION_RETURN_LABEL, 1);
    if (ERROR_COUNT == 0)
        GENERATE_FUNCTION_CODE(MK_FP(position_high, position_low));
    i32 value = HEAP_SPACE_BELOW_LIMIT() - HEAP_RESERVE_BYTES;
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

/* the scope exit block (kind 2) for scope entry block entry, returning to the enclosing
   scope */
u16 NEW_SCOPE_EXIT_BLOCK(u16 entry)
{
    u16 result = NEW_BLOCK();
    CNODE_W(result, CNODE_KIND) = 2;
    CNODE_W(result, CNODE_SCOPE_ENTRY) = entry;
    CURRENT_SCOPE_BLOCK = CNODE_W(entry, CNODE_SCOPE_PARENT);
    return result;
}

/* finds the first switch block from start along CNODE_NEXT and sets its default target
   (CNODE_TARGET, with jump kind 1) and its case list */
void SET_SWITCH_BLOCK_INFO(u16 start, u16 target, u16 cases)
{
    u16 node = start;
    while (CNODE_W(node, CNODE_KIND) != 4)
        node = CNODE_W(node, CNODE_NEXT);
    CNODE_W(node, CNODE_TARGET) = target;
    CNODE_W(node, CNODE_JUMP_KIND) = 1;
    CNODE_W(node, CNODE_CASE_LIST) = cases;
}

/* a code block (the new CURRENT_CODE_BLOCK) that evaluates expression expr for its side
   effects (skipped after errors) */
u16 NEW_EXPRESSION_BLOCK(u16 expr, u16 file, u16 line, u16 token_file, u16 token_line)
{
    u16 result = NEW_BLOCK();
    CURRENT_CODE_BLOCK = result;
    line_marks(file, line, token_file, token_line);
    if (expr && ERROR_COUNT == 0)
        GENERATE_EXPRESSION(LABEL_REGISTER_NEED(expr), 0);
    close_ops(CURRENT_CODE_BLOCK);
    reset_expr_pool();
    return result;
}

/* inserts the block chain chain after block after (at the list head when after is 0),
   giving its blocks loop weight weight and recording their variable accesses */
void SPLICE_BLOCK_CHAIN(u16 after, u16 chain, u16 weight)
{
    if (chain == 0)
        return;
    MARK_VARIABLE_ACCESS(chain);
    CNODE_W(chain, CNODE_LOOP_WEIGHT) = weight;
    CNODE_W(chain, CNODE_PREV) = after;
    u16 previous;
    if (after == 0) {
        previous = CODE_BLOCK_LIST_HEAD;
        CODE_BLOCK_LIST_HEAD = chain;
    } else {
        previous = CNODE_W(after, CNODE_NEXT);
        CNODE_W(after, CNODE_NEXT) = chain;
    }
    while (CNODE_W(chain, CNODE_NEXT) != 0) {
        chain = CNODE_W(chain, CNODE_NEXT);
        CNODE_W(chain, CNODE_LOOP_WEIGHT) = weight;
    }
    CNODE_W(chain, CNODE_NEXT) = previous;
    CNODE_W(previous, CNODE_PREV) = chain;
}

/* a block that only jumps unconditionally to block target (after its line marks) */
u16 NEW_JUMP_BLOCK(u16 target, u16 file, u16 line, u16 token_file, u16 token_line)
{
    u16 result = NEW_BLOCK();
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) {
        line_marks(file, line, token_file, token_line);
        close_ops(result);
    }
    CNODE_W(result, CNODE_JUMP_KIND) = 1;
    CNODE_W(result, CNODE_TARGET) = target;
    return result;
}

/* an empty label block (kind 3), a jump target */
u16 NEW_LABEL(void)
{
    u16 value = NEW_BLOCK();
    CNODE_W(value, CNODE_KIND) = 3;
    return value;
}

/* sets bit 1 of node's CNODE_FLAGS (used by APPEND_BLOCK_AND_MARK and the switch statement
   parser; what the bit means is not visible here) */
void SET_BLOCK_1C_FLAG_1(u16 node)
{
    CNODE_W(node, CNODE_FLAGS) |= 1;
}

/* appends the chain containing block chain (rewound to its first block) to the end of the
   function's list, merging where possible, and gives the appended blocks loop weight
   weight.  The first parameter is not used.  Appending the outermost scope's entry block
   (kind 1 with no parent) also emits the stack check */
void APPEND_BLOCK_CHAIN(u16 unused, u16 chain, u16 weight)
{
    (void)unused;
    if (chain == 0)
        return;
    while (CNODE_W(chain, CNODE_PREV) != 0)
        chain = CNODE_W(chain, CNODE_PREV);
    MARK_VARIABLE_ACCESS(chain);
    CNODE_W(chain, CNODE_LOOP_WEIGHT) = weight;
    if (CODE_BLOCK_LIST_HEAD != 0)
        JOIN_BLOCK_CHAINS(CODE_BLOCK_LIST_TAIL, chain);
    else {
        CODE_BLOCK_LIST_HEAD = chain;
        CODE_BLOCK_LIST_TAIL = chain;
    }
    while (CNODE_W(CODE_BLOCK_LIST_TAIL, CNODE_NEXT) != 0) {
        CODE_BLOCK_LIST_TAIL = CNODE_W(CODE_BLOCK_LIST_TAIL, CNODE_NEXT);
        CNODE_W(CODE_BLOCK_LIST_TAIL, CNODE_LOOP_WEIGHT) = weight;
    }
    if (CNODE_W(chain, CNODE_KIND) == 1 && CNODE_W(chain, CNODE_SCOPE_PARENT) == 0)
        EMIT_STACK_CHECK();
}

/* return expr: a code block that loads the return value followed by a jump to
   FUNCTION_RETURN_LABEL.  Returns the first block */
u16 NEW_RETURN_JUMP_BLOCK(u16 expr, u16 file, u16 line, u16 token_file, u16 token_line)
{
    u16 result = NEW_BLOCK();
    CURRENT_CODE_BLOCK = result;
    line_marks(file, line, token_file, token_line);
    if (expr && ERROR_COUNT == 0)
        EMIT_RETURN_VALUE(expr);
    close_ops(CURRENT_CODE_BLOCK);
    reset_expr_pool();
    JOIN_BLOCK_CHAINS(result, NEW_JUMP_BLOCK(FUNCTION_RETURN_LABEL, 0, 0, 0, 0));
    return result;
}

/* the blocks for: if condition is true (when_true set) or false, jump to block target.
   Returns the first block, or 0 after errors (the new block is freed when nothing was
   made) */
u16 NEW_BRANCH_BLOCK(u16 when_true, u16 condition, u16 target, u16 file, u16 line,
                     u16 token_file, u16 token_line)
{
    u16 result = NEW_BLOCK();
    CURRENT_CODE_BLOCK = result;
    line_marks(file, line, token_file, token_line);
    if (ERROR_COUNT != 0)
        return 0;
    u16 found = when_true ? EMIT_COND_JUMP_TRUE(condition, target)
                          : EMIT_COND_JUMP_FALSE(condition, target);
    if (found == 0)
        POOL_FREE_ITEM(FLOW_BLOCK_POOL_SEG_P, result);
    return found;
}

/* ends block with a jump of kind (0 none) to target */
static u16 end_block(u16 block, u16 kind, u16 target)
{
    close_ops(block);
    CNODE_W(block, CNODE_JUMP_KIND) = kind;
    if (kind)
        CNODE_W(block, CNODE_TARGET) = target;
    return block;
}

/* expr compared with 0 of its own type, as a != node */
static u16 compare_with_zero(u16 expr)
{
    u16 type = (u16)CALL_FAR(MODE_HOOK, A16(5));
    u16 zero = (u16)CALL_FAR(NEW_CONST_NODE_HOOK, A16(EXPR_W(expr, EXPR_TYPE)), A16(0), A16(0));
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(0x1E), A16(type), A16(expr), A16(zero));
}

/* ends CURRENT_CODE_BLOCK with code for: jump to block target if expression expr is true,
   and returns the first block made.  Constants decide at compile time; &x is always true;
   !x becomes jump if x is false; a && b skips over the test of b when a is false; a || b
   tests both; comparisons go to EMIT_COMPARE; integer values are compared with 0, others
   tested by EMIT_TEST_ZERO and jump kind 0Bh */
u16 EMIT_COND_JUMP_TRUE(u16 expr, u16 target)
{
    u16 current = CURRENT_CODE_BLOCK;
    switch (EXPR_I(expr, EXPR_OP)) {
    case 2:
        if (EXPR_L(expr, EXPR_LEFT))
            return end_block(current, 1, target);
        return end_block(current, 0, 0);
    case 0x32:
        return end_block(current, 1, target);
    case 0x30:
        return EMIT_COND_JUMP_FALSE(EXPR_W(expr, EXPR_LEFT), target);
    case 0x27: {
        u16 skip = NEW_LABEL();
        EMIT_COND_JUMP_FALSE(EXPR_W(expr, EXPR_LEFT), skip);
        CURRENT_CODE_BLOCK = NEW_BLOCK();
        u16 result = EMIT_COND_JUMP_TRUE(EXPR_W(expr, EXPR_RIGHT), target);
        JOIN_BLOCK_CHAINS(result, skip);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    }
    case 0x28: {
        EMIT_COND_JUMP_TRUE(EXPR_W(expr, EXPR_LEFT), target);
        CURRENT_CODE_BLOCK = NEW_BLOCK();
        u16 result = EMIT_COND_JUMP_TRUE(EXPR_W(expr, EXPR_RIGHT), target);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    }
    case 0x1D: case 0x1E: case 0x1F: case 0x20: case 0x21: case 0x22:
        break;
    default:
        if (EXPR_I(expr, EXPR_KIND) <= 6) {
            expr = compare_with_zero(expr);
            break;
        }
        EMIT_TEST_ZERO(expr);
        end_block(CURRENT_CODE_BLOCK, 0x0B, target);
        return current;
    }
    EMIT_COMPARE(expr, target);
    return current;
}

/* the same for jump if false: && and || change roles, a comparison is inverted and handed
   to EMIT_COND_JUMP_TRUE, and a plain test jumps with kind 0Ah */
u16 EMIT_COND_JUMP_FALSE(u16 expr, u16 target)
{
    u16 current = CURRENT_CODE_BLOCK;
    switch (EXPR_I(expr, EXPR_OP)) {
    case 2:
        if (EXPR_L(expr, EXPR_LEFT))
            return end_block(current, 0, 0);
        return end_block(current, 1, target);
    case 0x32:
        return end_block(current, 0, 0);
    case 0x30:
        return EMIT_COND_JUMP_TRUE(EXPR_W(expr, EXPR_LEFT), target);
    case 0x28: {
        u16 skip = NEW_LABEL();
        EMIT_COND_JUMP_TRUE(EXPR_W(expr, EXPR_LEFT), skip);
        CURRENT_CODE_BLOCK = NEW_BLOCK();
        u16 result = EMIT_COND_JUMP_FALSE(EXPR_W(expr, EXPR_RIGHT), target);
        JOIN_BLOCK_CHAINS(result, skip);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    }
    case 0x27: {
        EMIT_COND_JUMP_FALSE(EXPR_W(expr, EXPR_LEFT), target);
        CURRENT_CODE_BLOCK = NEW_BLOCK();
        u16 result = EMIT_COND_JUMP_FALSE(EXPR_W(expr, EXPR_RIGHT), target);
        JOIN_BLOCK_CHAINS(current, result);
        return current;
    }
    case 0x1D: case 0x1E: case 0x1F: case 0x20: case 0x21: case 0x22:
        break;
    default:
        if (EXPR_I(expr, EXPR_KIND) <= 6) {
            expr = compare_with_zero(expr);
            break;
        }
        EMIT_TEST_ZERO(expr);
        end_block(CURRENT_CODE_BLOCK, 0x0A, target);
        return current;
    }
    u16 op = INVERT_COMPARE_OP(EXPR_W(expr, EXPR_OP));
    EXPR_W(expr, EXPR_OP) = op;
    return EMIT_COND_JUMP_TRUE(expr, target);
}

/* the register need of node, from REGISTER_NEED_TABLE indexed by the operator's class (a
   byte table at DS:5234 by EXPR_OP) times 21 plus the value kind */
i16 EXPR_REGISTER_NEED(u16 node)
{
    i8 op_class = SB(DSPTR(EXPR_W(node, EXPR_OP) + FP_OFF(OPERATOR_HELPER_NAME_TABLE_P) - 1));
    return REGISTER_NEED_TABLE_AT((i16)(op_class * 21 + EXPR_W(node, EXPR_KIND)));
}

static i16 imax(i16 a, i16 b) { return a > b ? a : b; }
static i16 imin(i16 a, i16 b) { return a < b ? a : b; }
static i16 iabs(i16 a) { return a < 0 ? -a : a; }

/* labels expression tree node bottom-up with the number of registers each node needs, in
   its EXPR_NODE_FLAGS byte.  For a binary node the need is the larger of each operand's
   need and the cheaper of the two evaluation orders; the sign records which operand needs
   more (negative unless the right operand needs strictly more, or equally for an
   assignment, ops 12h-1Ch); GENERATE_OPERATOR generates the left operand first when it is
   negative.  Returns node */
u16 LABEL_REGISTER_NEED(u16 node)
{
    if (!node || EXPR_I(node, EXPR_KIND) == 0)
        return node;
    switch (EXPR_I(node, EXPR_OP)) {
    case 1:
        if (EXPR_I(node, 4) & 0x10)
            EXPR_SC(node, EXPR_NODE_FLAGS) = 1;
        return node;
    case 2: case 3: case 4: case 5: case 7:
        return node;
    case 0x33: {
        u16 left = LABEL_REGISTER_NEED(EXPR_W(node, EXPR_LEFT));
        EXPR_W(node, EXPR_LEFT) = left;
        EXPR_SC(node, EXPR_NODE_FLAGS) = (i8)-EXPR_SC(EXPR_W(node, EXPR_LEFT), EXPR_NODE_FLAGS);
        return node;
    }
    case 0x32: {
        u16 left = LABEL_REGISTER_NEED(EXPR_W(node, EXPR_LEFT));
        EXPR_W(node, EXPR_LEFT) = left;
        i16 op = EXPR_I(EXPR_W(node, EXPR_LEFT), EXPR_OP);
        if (op == 5 || op == 6)
            EXPR_SC(node, EXPR_NODE_FLAGS) = 1;
        else
            EXPR_SC(node, EXPR_NODE_FLAGS) = EXPR_SC(EXPR_W(node, EXPR_LEFT), EXPR_NODE_FLAGS);
        return node;
    }
    }
    u16 left = LABEL_REGISTER_NEED(EXPR_W(node, EXPR_LEFT));
    EXPR_W(node, EXPR_LEFT) = left;
    if (EXPR_W(node, EXPR_RIGHT)) {
        u16 right = LABEL_REGISTER_NEED(EXPR_W(node, EXPR_RIGHT));
        EXPR_W(node, EXPR_RIGHT) = right;
    }
    i16 a = EXPR_REGISTER_NEED(node);
    i16 b = EXPR_REGISTER_NEED(EXPR_W(node, EXPR_LEFT));
    i16 d = iabs(EXPR_SC(EXPR_W(node, EXPR_LEFT), EXPR_NODE_FLAGS));
    if (EXPR_I(node, EXPR_OP) == 0x23 || EXPR_I(node, EXPR_OP) == 0x24)
        d += a;
    if (!EXPR_W(node, EXPR_RIGHT)) {
        EXPR_SC(node, EXPR_NODE_FLAGS) = (i8)-imax(a, d);
        return node;
    }
    i16 c = EXPR_REGISTER_NEED(EXPR_W(node, EXPR_RIGHT));
    i16 e = iabs(EXPR_SC(EXPR_W(node, EXPR_RIGHT), EXPR_NODE_FLAGS));
    EXPR_SC(node, EXPR_NODE_FLAGS) = (i8)imax(e, imax(d, imax(a, imin(e + b, d + c))));
    if (d < e)
        return node;
    if (d == e && EXPR_I(node, EXPR_OP) >= 0x12 && EXPR_I(node, EXPR_OP) <= 0x1C)
        return node;
    EXPR_SC(node, EXPR_NODE_FLAGS) = (i8)-EXPR_SC(node, EXPR_NODE_FLAGS);
    return node;
}

/* appends the chain second after the last block of the chain containing first.  While
   both ends are plain code blocks and the first does not jump, they are merged: an empty
   block just hands over its jump, and a block whose ops directly follow the previous
   block's ops extends it; merged blocks are freed */
void JOIN_BLOCK_CHAINS(u16 first, u16 second)
{
    u16 destination = first, source = second;
    if (!source)
        return;
    while (CNODE_W(destination, CNODE_NEXT))
        destination = CNODE_W(destination, CNODE_NEXT);
    while (source) {
        if (CNODE_W(destination, CNODE_KIND) != 0 || CNODE_W(source, CNODE_KIND) != 0 ||
            CNODE_W(destination, CNODE_JUMP_KIND) != 0 ||
            (CNODE_W(source, CNODE_OP_COUNT) != 0 &&
             CNODE_W(destination, CNODE_FIRST_OP) + CNODE_W(destination, CNODE_OP_COUNT) !=
                 CNODE_W(source, CNODE_FIRST_OP))) {
            CNODE_W(source, CNODE_PREV) = destination;
            break;
        }
        if (CNODE_W(source, CNODE_OP_COUNT) != 0)
            CNODE_W(destination, CNODE_OP_COUNT) += CNODE_W(source, CNODE_OP_COUNT);
        CNODE_W(destination, CNODE_JUMP_KIND) = CNODE_W(source, CNODE_JUMP_KIND);
        CNODE_W(destination, CNODE_TARGET) = CNODE_W(source, CNODE_TARGET);
        CNODE_W(destination, CNODE_FLAGS) |= CNODE_W(source, CNODE_FLAGS);
        u16 next = CNODE_W(source, CNODE_NEXT);
        POOL_FREE_ITEM(FLOW_BLOCK_POOL_SEG_P, source);
        source = next;
    }
    CNODE_W(destination, CNODE_NEXT) = source;
}

/* the comparison operator with the opposite result (== for !=) */
u16 INVERT_COMPARE_OP(u16 index)
{
    return INVERT_COMPARE_TABLE_AT(index);
}

/* the comparison operator for swapped operands (> for <) */
u16 MIRROR_COMPARE_OP(u16 index)
{
    return MIRROR_COMPARE_TABLE_AT(index);
}

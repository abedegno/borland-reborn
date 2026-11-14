/* stmtblk.c: from bcc20/src/codegen/STMTBLK.C: the calls the statement parsers make to
   build a function for the back end.  Each takes front-end trees and source locations and
   turns them into flow blocks, appending them to the current function's block list with the
   current LOOP_NEST_FACTOR as the blocks' loop weight.  All of them do nothing (and release
   the expression pool) once an error has stopped code generation (NO_ERRORS_YET clear).
   Expressions go through LOWER_EXPRESSION first.  A record argument is a source location
   (file, line, word; passed as its three words, last first): file and line, with the current
   token's, become the line-mark ops at the start of the new block.  The MAKE_* functions
   return the new block without appending it; the APPEND_* ones append it at once. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define FUNCTION_DEF_POSITION D(FUNCTION_DEF_POSITION_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define BCC_PACK_FLAG B(BCC_PACK_FLAG_P)
#define STORAGE_FLAGS(n) B(MK_FP(STORAGE_POOL_SEG, ((n) & 0xFFFE) + 8))

static void append(u16 block)
{
    APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER, block, LOOP_NEST_FACTOR);
}

/* a new label block, or 0 while code generation is off */
u16 NEW_LABEL_IF_ENABLED(void)
{
    if (NO_ERRORS_YET)
        return NEW_LABEL();
    return 0;
}

/* opens the back-end state for the function being defined: INIT_FUNCTION_STATE with its
   storage record, return type, parameters, calling convention, function flags, code segment
   and source position.  With VTABLE_MODE 3 and a code segment of its own, that segment
   becomes CODE_SEGMENT_ID first */
void START_FUNCTION_STATE(void)
{
    if (!NO_ERRORS_YET) {
        BCC_PARSE_BUFFER = 0;
        return;
    }
    u16 type = SYM_W(BCC_TREE_SPECIAL, SYM_TYPE);
    u16 name = PREPARE_SYMBOL(BCC_TREE_SPECIAL);
    if (VTABLE_MODE == 3) {
        u16 stream = (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(name));
        if (stream != 0xFFFF && stream != CODE_SEGMENT_ID) {
            CODE_SEGMENT_ID = stream;
            CURRENT_SOURCE_FILE = CLONE_NODE_KEEP_SERIAL(CURRENT_SOURCE_FILE);
        }
    }
    u32 position = FUNCTION_DEF_POSITION;
    BCC_PARSE_BUFFER = INIT_FUNCTION_STATE(name, TYPE_W(type, TYPE_TARGET), TYPE_W(type, TYPE_PARAMS), TYPE_B(type, TYPE_CALL_CONV),
                                           TYPE_B(type, TYPE_FUNC_FLAGS), CODE_SEGMENT_ID, CURRENT_SOURCE_FILE, FUNCTION_DEF_LINE,
                                           (u16)(position >> 16), (u16)position);
    POOL_TRIM(CONTEXT_SEG_P, 100);
}

/* closes the function: the return label is appended and the code generated, with the
   current token's file and line as the closing position */
void FINISH_FUNCTION_STATE(void)
{
    if (NO_ERRORS_YET)
        FINISH_FUNCTION_BLOCKS(BCC_PARSE_BUFFER, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
}

/* the scope entry block of CURRENT_SCOPE, linked under the parent scope's entry block,
   stored in SCOPE_ENTER_BLOCK and appended; 0 while code generation is off */
void APPEND_SCOPE_ENTER_BLOCK(void)
{
    if (NO_ERRORS_YET) {
        u16 block = NEW_SCOPE_ENTER_BLOCK(CURRENT_SCOPE, SCOPE_W(SCOPE_W(CURRENT_SCOPE, SCOPE_PARENT), SCOPE_ENTER_BLOCK));
        SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK) = block;
        append(SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK));
    } else
        SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK) = 0;
}

/* appends the scope exit block matching CURRENT_SCOPE's entry block */
void APPEND_SCOPE_EXIT_BLOCK(void)
{
    if (NO_ERRORS_YET)
        append(NEW_SCOPE_EXIT_BLOCK(SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK)));
}

/* switch statement head: a switch block evaluating selector value, completed later by
   SET_SWITCH_INFO_IF_ENABLED */
u16 APPEND_SWITCH_BLOCK(u16 value, u16 third, u16 second, u16 first)
{
    (void)third;
    if (!NO_ERRORS_YET) {
        RESET_EXPR_POOL_ALT();
        return 0;
    }
    u16 result = NEW_SWITCH_BLOCK(LOWER_EXPRESSION(value), first, second, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
    append(result);
    return result;
}

/* the default target (value1) and case list (value2) of the first switch block of the
   chain at start */
void SET_SWITCH_INFO_IF_ENABLED(u16 start, u16 value1, u16 value2)
{
    if (NO_ERRORS_YET)
        SET_SWITCH_BLOCK_INFO(start, value1, value2);
}

/* appends "if condition first is false, jump to label block second" */
void APPEND_JUMP_IF_FALSE_BLOCK(u16 first, u16 second, u16 word, u16 line, u16 file)
{
    (void)word;
    if (!NO_ERRORS_YET) {
        RESET_EXPR_POOL_ALT();
        return;
    }
    u16 result = NEW_BRANCH_BLOCK(0, LOWER_EXPRESSION(first), second, file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
    append(result);
}

/* returns, without appending, the blocks for "if condition first is true, jump to label
   block second"; line marks only when the record has a line */
u16 MAKE_JUMP_IF_TRUE_BLOCK(u16 first, u16 second, u16 word, u16 line, u16 file)
{
    (void)word;
    if (!NO_ERRORS_YET) {
        RESET_EXPR_POOL_ALT();
        return 0;
    }
    u16 converted = LOWER_EXPRESSION(first);
    if (line)
        return NEW_BRANCH_BLOCK(1, converted, second, file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
    return NEW_BRANCH_BLOCK(1, converted, second, 0, 0, 0, 0);
}

/* the same, appended at once */
void APPEND_JUMP_IF_TRUE_BLOCK(u16 first, u16 second, u16 word, u16 line, u16 file)
{
    (void)word;
    if (!NO_ERRORS_YET) {
        RESET_EXPR_POOL_ALT();
        return;
    }
    u16 result = NEW_BRANCH_BLOCK(1, LOWER_EXPRESSION(first), second, file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
    append(result);
}

/* appends an unconditional jump to label block value, with the record as both line marks */
void APPEND_JUMP_BLOCK(u16 value, u16 word, u16 line, u16 file)
{
    (void)word;
    if (NO_ERRORS_YET)
        append(NEW_JUMP_BLOCK(value, file, line, file, line));
}

/* returns, without appending, a block evaluating expression node for its side effects (0
   when node is 0) */
u16 MAKE_EXPRESSION_BLOCK(u16 node, u16 word, u16 line, u16 file)
{
    (void)word;
    if (NO_ERRORS_YET && node) {
        u16 converted = LOWER_EXPRESSION(node);
        if (line)
            return NEW_EXPRESSION_BLOCK(converted, file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
        return NEW_EXPRESSION_BLOCK(converted, 0, 0, 0, 0);
    }
    RESET_EXPR_POOL_ALT();
    return 0;
}

/* the same, appended at once */
void APPEND_EXPRESSION_BLOCK(u16 node, u16 word, u16 line, u16 file)
{
    (void)word;
    if (NO_ERRORS_YET && node) {
        u16 result = NEW_EXPRESSION_BLOCK(LOWER_EXPRESSION(node), file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
        append(result);
    } else
        RESET_EXPR_POOL_ALT();
}

/* inserts the block chain chain (made earlier by a MAKE_* function) after block parent */
void SPLICE_STATEMENT_CHAIN(u16 chain, u16 parent)
{
    if (NO_ERRORS_YET)
        SPLICE_BLOCK_CHAIN(parent, chain, LOOP_NEST_FACTOR);
}

/* return node;: analyses and simplifies node (always, so errors are found even when no code
   is made), then returns, without appending, a block loading the return value followed by a
   jump to the function's return label */
u16 MAKE_RETURN_JUMP_BLOCK(u16 node, u16 word, u16 line, u16 file)
{
    (void)word;
    node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node, VOID_TYPE), 0);
    if (!NO_ERRORS_YET)
        return 0;
    u16 converted = LOWER_EXPRESSION(node);
    if (line)
        return NEW_RETURN_JUMP_BLOCK(converted, file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
    return NEW_RETURN_JUMP_BLOCK(converted, 0, 0, 0, 0);
}

/* the same for an already analysed node, appended at once */
void APPEND_RETURN_JUMP_BLOCK(u16 node, u16 word, u16 line, u16 file)
{
    (void)word;
    if (!NO_ERRORS_YET) {
        RESET_EXPR_POOL_ALT();
        return;
    }
    u16 result = NEW_RETURN_JUMP_BLOCK(LOWER_EXPRESSION(node), file, line, CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE);
    append(result);
}

/* appends block (chain) value when it is not 0 */
void APPEND_BLOCK_IF_NONZERO(u16 value)
{
    if (NO_ERRORS_YET && value)
        append(value);
}

/* appends block value and sets its CNODE_FLAGS bit 1 */
void APPEND_BLOCK_AND_MARK(u16 value)
{
    if (NO_ERRORS_YET) {
        append(value);
        SET_BLOCK_1C_FLAG_1(value);
    }
}

/* expression statement: analyses and simplifies node as a void expression (always), then
   appends a block for it unless nothing is left */
void APPEND_ANALYZED_EXPRESSION(u16 node)
{
    node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node, VOID_TYPE), 1);
    if (NO_ERRORS_YET && node && EXPR_W(node, EXPR_OP)) {
        u16 result = NEW_EXPRESSION_BLOCK(LOWER_EXPRESSION(node), 0, 0, 0, 0);
        append(result);
    } else
        RESET_EXPR_POOL_ALT();
}

/* links symbol's storage record to a new variable-table entry, or to none while code
   generation is off */
void REGISTER_SYMBOL_VARIABLE(u16 symbol)
{
    u16 storage = PREPARE_SYMBOL(symbol);
    u16 entry = NO_ERRORS_YET ? FIND_OR_ADD_VARIABLE(storage, TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_KIND), STORAGE_FLAGS(storage)) : 0;
    CALL_FAR(SET_SYMBOL_VARIABLE_HOOK, A16(storage), A16(entry));
}

/* before the initialiser of static symbol is emitted: switches output to the symbol's
   segment, word-aligns when the object is bigger than a byte and BCC_PACK_FLAG is set, and
   defines the symbol at the current position.  Returns the previous segment for
   SET_STREAM to restore */
u16 SELECT_SYMBOL_STREAM(u16 symbol)
{
    if (!NO_ERRORS_YET)
        return 0;
    u16 storage = PREPARE_SYMBOL(symbol);
    u16 segment = (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(storage));
    u16 previous = (u16)CALL_FAR(STREAM_HOOK, A16(segment));
    if (TYPE_SIZE(SYM_W(symbol, SYM_TYPE)) > 1 && BCC_PACK_FLAG)
        CALL_FAR(ALIGN_OUTPUT_HOOK, A16(2));
    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(storage));
    return previous;
}

/* switches output to segment value */
void SET_STREAM(u16 value)
{
    if (NO_ERRORS_YET)
        CALL_FAR(STREAM_HOOK, A16(value));
}

/* emits count zero bytes to the current output */
void EMIT_ZERO_BYTES(u16 count)
{
    if (NO_ERRORS_YET)
        for (u16 index = 0; index < count; ++index)
            CALL_FAR(BYTE_HOOK, A16(0));
}

/* emits constant initialiser node to the current output */
void EMIT_CONST_INIT_VALUE(u16 node)
{
    if (NO_ERRORS_YET && node)
        EMIT_INITIALIZER_VALUE(LOWER_EXPRESSION(node), 0);
    else
        RESET_EXPR_POOL_ALT();
}

/* emits one byte to the current output */
void EMIT_BYTE_IF_ENABLED(u8 code)
{
    if (NO_ERRORS_YET)
        CALL_FAR(BYTE_HOOK, A16(code));
    else
        RESET_EXPR_POOL_ALT();
}

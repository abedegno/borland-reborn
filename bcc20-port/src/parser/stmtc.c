/* stmtc.c: from bcc20/src/parser/STMTC.C: the statement parser of the C front end (the one
   COMPILE_C_SOURCE runs for .c files; C++ has its own in STMTCPP.C).  It reads tokens
   straight from the lexer (next_token: LEX_NEXT_TOKEN, or the one token pushed back with
   TOKEN_PUSHED_BACK); the code is in TOKEN_TYPE and an identifier's name or a constant's
   value in TOKEN_CONST_VALUE.  Statements are not built into a tree: each one becomes flow
   blocks appended at once to the function's block chain (APPEND_BLOCK_CHAIN(
   BCC_TREE_SPECIAL, block, LOOP_BLOCK_WEIGHT)): labels, expression blocks, conditional
   branches, jumps, switch and return blocks.  LOOP_BLOCK_WEIGHT triples inside each loop
   when optimising for speed.

   Each PARSE_STATEMENT_C call gets *flag, whether the point before the statement can be
   reached; it is updated for the point after it, and a statement where it is 0 gets the
   "unreachable code" warning.  Loops and switches keep their break and continue labels in
   a loop context (14 bytes: far pointers to the enclosing loop and switch contexts, break
   label, continue label, kind byte, broken byte) on the original's stack, linked through
   CURRENT_LOOP_CONTEXT and CURRENT_SWITCH_CONTEXT; here it lives in the scratch area, as
   does PARSE_BLOCK_BODY's reachability flag.  case values are kept sorted in
   SWITCH_CASE_LIST.  The last two functions walk finished expression trees to warn about
   expressions without effect and to mark variables used or assigned.

   The original passes an unset local (line3) to NEW_BRANCH_BLOCK for a for loop whose
   test starts on the line of its initialisation; the replay is told so (UNSET_ARGS). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_CONST_VALUE SD(TOKEN_CONST_VALUE_P)
#define LOOP_BLOCK_WEIGHT SW(LOOP_BLOCK_WEIGHT_P)
#define OPTION_OPTIMIZE_SPEED B(OPTION_OPTIMIZE_SPEED_P)
#define RETURN_FORM_SEEN B(RETURN_FORM_SEEN_P)
#define DIAG_NAME_BUFFER W(DIAG_NAME_BUFFER_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define CURRENT_LOOP_CONTEXT D(CURRENT_LOOP_CONTEXT_P)          /* struct loop_ctx far * */
#define CURRENT_SWITCH_CONTEXT D(CURRENT_SWITCH_CONTEXT_P)
#define FOR_STEP_FLAG B(FOR_STEP_CLEARED_FLAG_P)

/* the loop context's fields */
#define PREV_LOOP(c) D(c)
#define PREV_SWITCH(c) D(fp_add((c), 4))
#define BREAK_LABEL(c) W(fp_add((c), 8))
#define CONTINUE_LABEL(c) W(fp_add((c), 0x0A))
#define KIND(c) B(fp_add((c), 0x0C))
#define BROKEN(c) B(fp_add((c), 0x0D))

/* the next token: the pushed-back one, or a new one from the lexer */
static u16 next_token(void)
{
    if (TOKEN_PUSHED_BACK) {
        TOKEN_PUSHED_BACK = 0;
        return TOKEN_TYPE;
    }
    return (u16)LEX_NEXT_TOKEN();
}

static void append(u16 block)
{
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL, block, (u16)LOOP_BLOCK_WEIGHT);
}

/* the inside of a compound statement, after its '{': local declarations first (they open
   a new scope C_DECL_SCOPE, with scope enter and exit blocks, unless the caller already
   opened one: opened nonzero), then statements up to the '}'.  value is the reachability
   flag on entry; the flag after the block is returned.  The type pool is cut back after
   each statement, as statement-local types are no longer needed.  Unused locals are
   reported when the scope closes */
i16 PARSE_BLOCK_BODY(u16 opened, u16 value)
{
    u16 mark = scratch_mark();
    farptr flag = scratch_alloc(2);
    W(flag) = value;
    u16 current = C_DECL_SCOPE;
    u16 list = 0;
    u16 saved = STMT_SCOPE_BLOCK;
    if (TOKEN_STARTS_TYPE(next_token())) {
        if (opened == 0) {
            u16 scope = CREATE_SCOPE(C_DECL_SCOPE);
            C_DECL_SCOPE = scope;
            CURRENT_SCOPE = scope;
            current = scope;
            opened = 1;
            list = NEW_SCOPE_ENTER_BLOCK(C_DECL_SCOPE, STMT_SCOPE_BLOCK);
            STMT_SCOPE_BLOCK = list;
            append(list);
        }
        do {
            BCC_STMT_DECL_PARSE();
            if (TOKEN_TYPE != 7)
                REPORT_AND_SKIP(MSG_DECLARATION_MISSING, 0);
        } while (TOKEN_STARTS_TYPE(next_token()));
    }
    TYPE_POOL_LENGTH_MARK = TYPE_POOL_LENGTH;
    while (TOKEN_TYPE != 6 && TOKEN_TYPE != 0) {
        TOKEN_PUSHED_BACK = 1;
        PARSE_STATEMENT_C(flag);
        TYPE_POOL_WORD6 = 0;
        TYPE_POOL_LENGTH = TYPE_POOL_LENGTH_MARK;
        next_token();
    }
    LOGICAL_LINE = CURRENT_LINE;
    if (TOKEN_TYPE != 6)
        REPORT_ERROR(MSG_COMPOUND_STATEMENT);
    if (opened) {
        C_DECL_SCOPE = SCOPE_W(current, SCOPE_C_PARENT);
        CURRENT_SCOPE = C_DECL_SCOPE;
        WARN_UNUSED_SYMBOLS(current);
        if (list) {
            u16 chain = BCC_TREE_SPECIAL;           /* pascal: read before the call */
            u16 block = NEW_SCOPE_EXIT_BLOCK(list);
            APPEND_BLOCK_CHAIN(chain, block, (u16)LOOP_BLOCK_WEIGHT);
        }
        STMT_SCOPE_BLOCK = saved;
    }
    value = W(flag);
    scratch_release(mark);
    return (i16)value;
}

/* entering a loop body: triples the block weight (when optimising for speed, up to a
   limit) */
void ENTER_LOOP_WEIGHT(void)
{
    if (OPTION_OPTIMIZE_SPEED != 0 && LOOP_BLOCK_WEIGHT <= 8191)
        LOOP_BLOCK_WEIGHT *= 3;
}

/* leaving a loop body: undoes ENTER_LOOP_WEIGHT */
void LEAVE_LOOP_WEIGHT(void)
{
    if (LOOP_BLOCK_WEIGHT > 1)
        LOOP_BLOCK_WEIGHT /= 3;
}

/* "unreachable code" when the reachability flag is 0 */
void WARN_IF_UNREACHABLE(farptr value)
{
    if (W(value) == 0)
        REPORT_WARNING(MSG_UNREACHABLE_CODE);
}

/* one statement, its flow blocks appended; flag is the reachability flag.  Labels, case
   and default go back to restart, since they prefix the statement that follows.  file and
   line are the statement's position, given to the blocks for debug line numbers.
   STATEMENT_LABELED_FLAG notes a label inside a loop body; a loop body with no label, case
   or default in it gets its loop-head block marked (SET_BLOCK_1C_FLAG_1) */
void PARSE_STATEMENT_C(farptr flag)
{
    u16 mark = scratch_mark();
    farptr ctx = scratch_alloc(14);
    i16 cls, ifcls, saved_flag, saved6458;
    u16 label = 0, label2, label3, steptree, step, ident, prev, saved_cases, saved_cases2;
    u16 saved_default, saved_default2, rec, file, line, file2, line2, file3, line3 = 0, saved;
    farptr name;
    u16 node, p;
restart:
    NESTING_CHECK();
    ident = 0;
    next_token();
    LOGICAL_LINE = CURRENT_LINE;
    file = TOKEN_FILE_NODE;
    line = TOKEN_LINE;
    saved_cases = SWITCH_CASE_LIST;
    saved_flag = STATEMENT_LABELED_FLAG;
    saved_default = SWITCH_DEFAULT_LABEL;
    switch (TOKEN_TYPE) {
    /* case constant: the value goes into the sorted case list with a new label, placed
       here */
    case 0x63:
        W(flag) = 1;
        next_token();
        if (!PARSE_CONSTANT_EXPR(3))
            goto done;
        if (CURRENT_SWITCH_CONTEXT == 0) {
            REPORT_ERROR(MSG_CASE_OUTSIDE_SWITCH);
            goto restart;
        }
        prev = 0;
        for (p = SWITCH_CASE_LIST; p; p = SWCASE_W(p, SWCASE_NEXT)) {
            if (SWCASE_L(p, SWCASE_VALUE) == TOKEN_CONST_VALUE) {
                REPORT_ERROR(MSG_DUPLICATE_CASE);
                break;
            }
            if (SWCASE_L(p, SWCASE_VALUE) > TOKEN_CONST_VALUE) {
                p = 0;
                break;
            }
            prev = p;
        }
        if (p)
            goto restart;
        label = NEW_LABEL();
        p = POOL_ALLOC_REUSE(CASE_ENTRY_POOL_SEG_P, 8);
        if (prev == 0) {
            SWCASE_W(p, SWCASE_NEXT) = SWITCH_CASE_LIST;
            SWITCH_CASE_LIST = p;
        } else {
            SWCASE_W(p, SWCASE_NEXT) = SWCASE_W(prev, SWCASE_NEXT);
            SWCASE_W(prev, SWCASE_NEXT) = p;
        }
        SWCASE_W(p, SWCASE_TARGET) = label;
        SWCASE_L(p, SWCASE_VALUE) = TOKEN_CONST_VALUE;
        append(label);
        goto restart;
    case 0x62:
        W(flag) = 1;
        if (next_token() != 0x21) {
            REPORT_ERROR(MSG_INCORRECT_USE_DEFAULT);
            TOKEN_PUSHED_BACK = 1;
            goto restart;
        }
        if (CURRENT_SWITCH_CONTEXT == 0) {
            REPORT_ERROR(MSG_DEFAULT_OUTSIDE_SWITCH);
            goto restart;
        }
        if (SWITCH_DEFAULT_LABEL) {
            REPORT_ERROR(MSG_TOO_MANY_DEFAULT_CASES);
            goto restart;
        }
        SWITCH_DEFAULT_LABEL = NEW_LABEL();
        append(SWITCH_DEFAULT_LABEL);
        goto restart;
    case 6:
        TOKEN_PUSHED_BACK = 1;
        /* fall through */
    case 0:
        REPORT_ERROR(MSG_STATEMENT_MISSING_234);
        goto done;
    case 0x57:
        WARN_IF_UNREACHABLE(flag);
        PARSE_ASM_STATEMENT();
        goto done;
    case 0x5A:
        REPORT_ERROR(MSG_MISPLACED_ELSE_127);
        goto restart;
    case 0x59:
        WARN_IF_UNREACHABLE(flag);
        name = STR_IF_4_P;
        if (next_token() != 1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING, name);
            goto done;
        }
        next_token();
        label = NEW_LABEL();
        node = PARSE_EXPRESSION(0, 0);
        if (!node)
            goto done;
        node = FOLD_EXPRESSION(node);
        MARK_SYMBOLS_REFERENCED(node);
        ifcls = BRANCH_IF_FALSE(node, label, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        W(flag) = ifcls >= 0;
        if (TOKEN_TYPE != 2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63, name);
            goto done;
        }
        PARSE_STATEMENT_C(flag);
        file = TOKEN_FILE_NODE;
        line = TOKEN_LINE;
        if (next_token() == 0x5A) {
            saved = W(flag);
            if (ifcls > 0)
                W(flag) = 0;
            else
                W(flag) = 1;
            label2 = NEW_LABEL();
            EMIT_JUMP(label2, file, line, 0, 0);
            append(label);
            PARSE_STATEMENT_C(flag);
            append(label2);
            if (ifcls > 0)
                W(flag) = saved;
            else
                W(flag) |= saved;
            goto done;
        }
        if (ifcls <= 0)
            W(flag) = 1;
        TOKEN_PUSHED_BACK = 1;
        append(label);
        goto done;
    /* for (init; test; step) body: init, a jump to the test unless it is constant, label2:
       body, continue label: step, then the test (a branch back to label2), or a plain jump
       back for an always-true test, then the break label.  cls is the test's
       CLASSIFY_CONDITION result (1 always true, -1 always false, 0 unknown) */
    case 0x5B:
        WARN_IF_UNREACHABLE(flag);
        name = STR_FOR_2_P;
        PREV_LOOP(ctx) = CURRENT_LOOP_CONTEXT;
        BREAK_LABEL(ctx) = NEW_LABEL();
        CONTINUE_LABEL(ctx) = NEW_LABEL();
        KIND(ctx) = 0x5B;
        BROKEN(ctx) = 0;
        label2 = NEW_LABEL();
        if (next_token() != 1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING, name);
            goto done;
        }
        if (next_token() != 7) {
            node = PARSE_EXPRESSION(0, 0);
            if (!node)
                goto done;
            CHECK_EXPRESSION_EFFECT(node);
            node = FOLD_STATEMENT_EXPR(node);
            label = NEW_EXPRESSION_BLOCK(node, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
            append(label);
            file = TOKEN_FILE_NODE;
            line = TOKEN_LINE;
            if (TOKEN_TYPE != 7) {
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, name);
                goto done;
            }
        } else
            file = 0;
        ENTER_LOOP_WEIGHT();
        if (next_token() != 7) {
            file2 = TOKEN_FILE_NODE;
            line2 = TOKEN_LINE;
            if (line == line2 && file == file2)
                file2 = 0;
            node = PARSE_EXPRESSION(0, 0);
            if (!node)
                goto done;
            if (TOKEN_TYPE != 7) {
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, name);
                goto done;
            }
            int line3_unset = 0;
            if (file2) {
                file3 = TOKEN_FILE_NODE;
                line3 = TOKEN_LINE;
            } else {
                file3 = 0;      /* line3 is left unset, as in the original */
                line3_unset = 1;
            }
            node = FOLD_EXPRESSION(node);
            cls = CLASSIFY_CONDITION(node);
            MARK_SYMBOLS_REFERENCED(node);
            if (cls == 0) {
                if (line3_unset)
                    UNSET_ARGS(1u << 6);
                label3 = NEW_BRANCH_BLOCK(1, node, label2, file2, line2, file3, line3_unset ? 0 : line3);
            } else
                label3 = 0;
        } else {
            cls = 1;
            label3 = 0;
        }
        if (next_token() != 2) {
            if (line != TOKEN_LINE || file != TOKEN_FILE_NODE) {
                file = TOKEN_FILE_NODE;
                line = TOKEN_LINE;
            } else
                file = 0;
            step = PARSE_EXPRESSION(0, 0);
            if (!step)
                goto done;
            if (TOKEN_TYPE != 2) {
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63, name);
                goto done;
            }
            step = FOLD_EXPRESSION(step);
            saved6458 = FOR_STEP_FLAG;
            FOR_STEP_FLAG = 0;
            CHECK_EXPRESSION_EFFECT(step);
            FOR_STEP_FLAG = (u8)saved6458;
            steptree = NEW_EXPRESSION_BLOCK(step, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        } else
            steptree = 0;
        CURRENT_LOOP_CONTEXT = ctx;
        if (cls < 0)
            W(flag) = 0;
        else {
            if (cls == 0) {
                label = NEW_LABEL();
                EMIT_JUMP(label, 0, 0, 0, 0);
            }
            append(label2);
        }
        STATEMENT_LABELED_FLAG = 0;
        PARSE_STATEMENT_C(flag);
        if (cls >= 0 && saved_cases == SWITCH_CASE_LIST && STATEMENT_LABELED_FLAG == 0 && saved_default == SWITCH_DEFAULT_LABEL)
            SET_BLOCK_1C_FLAG_1(label2);
        STATEMENT_LABELED_FLAG |= saved_flag;
        append(CONTINUE_LABEL(ctx));
        if (steptree)
            append(steptree);
        if (cls == 0) {
            append(label);
            append(label3);
            BROKEN(ctx) = 1;
        } else if (cls > 0)
            EMIT_JUMP(label2, 0, 0, 0, 0);
        else
            BROKEN(ctx) = 1;
        LEAVE_LOOP_WEIGHT();
        W(flag) = BROKEN(ctx);
        CURRENT_LOOP_CONTEXT = PREV_LOOP(ctx);
        append(BREAK_LABEL(ctx));
        goto done;
    case 0x5D:
        WARN_IF_UNREACHABLE(flag);
        name = STR_DO_WHILE_2_P;
        PREV_LOOP(ctx) = CURRENT_LOOP_CONTEXT;
        KIND(ctx) = 0x5D;
        CURRENT_LOOP_CONTEXT = ctx;
        CONTINUE_LABEL(ctx) = NEW_LABEL();
        BREAK_LABEL(ctx) = NEW_LABEL();
        BROKEN(ctx) = 0;
        label = NEW_LABEL();
        append(label);
        ENTER_LOOP_WEIGHT();
        W(flag) = 1;
        STATEMENT_LABELED_FLAG = 0;
        PARSE_STATEMENT_C(flag);
        if (saved_cases == SWITCH_CASE_LIST && STATEMENT_LABELED_FLAG == 0 && saved_default == SWITCH_DEFAULT_LABEL)
            SET_BLOCK_1C_FLAG_1(label);
        STATEMENT_LABELED_FLAG |= saved_flag;
        if (next_token() != 0x5C) {
            REPORT_AND_SKIP(MSG_DO_STATEMENT_MUST_HAVE, 0);
            goto done;
        }
        file = TOKEN_FILE_NODE;
        line = TOKEN_LINE;
        if (next_token() != 1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING, name);
            goto done;
        }
        next_token();
        CURRENT_LOOP_CONTEXT = PREV_LOOP(ctx);
        append(CONTINUE_LABEL(ctx));
        node = PARSE_EXPRESSION(0, 0);
        if (!node)
            goto done;
        node = FOLD_EXPRESSION(node);
        MARK_SYMBOLS_REFERENCED(node);
        if (BRANCH_IF_TRUE(node, label, file, line, TOKEN_FILE_NODE, TOKEN_LINE) <= 0)
            BROKEN(ctx) = 1;
        LEAVE_LOOP_WEIGHT();
        W(flag) = BROKEN(ctx);
        append(BREAK_LABEL(ctx));
        if (TOKEN_TYPE != 2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63, name);
            goto done;
        }
        if (next_token() != 7)
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, name);
        goto done;
    case 0x5C:
        WARN_IF_UNREACHABLE(flag);
        name = STR_WHILE_2_P;
        if (next_token() != 1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING, name);
            goto done;
        }
        next_token();
        PREV_LOOP(ctx) = CURRENT_LOOP_CONTEXT;
        KIND(ctx) = 0x5C;
        CURRENT_LOOP_CONTEXT = ctx;
        CONTINUE_LABEL(ctx) = NEW_LABEL();
        BREAK_LABEL(ctx) = NEW_LABEL();
        BROKEN(ctx) = 0;
        W(flag) = 1;
        node = PARSE_EXPRESSION(0, 0);
        if (!node)
            goto done;
        if (TOKEN_TYPE != 2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63, name);
            goto done;
        }
        ENTER_LOOP_WEIGHT();
        node = FOLD_EXPRESSION(node);
        cls = CLASSIFY_CONDITION(node);
        if (cls <= 0)
            EMIT_JUMP(CONTINUE_LABEL(ctx), 0, 0, 0, 0);
        if (cls >= 0) {
            label = NEW_LABEL();
            append(label);
        }
        MARK_SYMBOLS_REFERENCED(node);
        if (cls == 0)
            label3 = NEW_BRANCH_BLOCK(1, node, label, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        else
            label3 = 0;
        if (cls < 0) {
            W(flag) = 0;
            BROKEN(ctx) = 1;
        }
        STATEMENT_LABELED_FLAG = 0;
        PARSE_STATEMENT_C(flag);
        if (saved_cases == SWITCH_CASE_LIST && STATEMENT_LABELED_FLAG == 0 && saved_default == SWITCH_DEFAULT_LABEL)
            SET_BLOCK_1C_FLAG_1(CONTINUE_LABEL(ctx));
        STATEMENT_LABELED_FLAG |= saved_flag;
        LEAVE_LOOP_WEIGHT();
        CURRENT_LOOP_CONTEXT = PREV_LOOP(ctx);
        append(CONTINUE_LABEL(ctx));
        if (cls == 0) {
            append(label3);
            BROKEN(ctx) = 1;
        } else if (cls > 0)
            EMIT_JUMP(label, 0, 0, 0, 0);
        W(flag) = BROKEN(ctx);
        append(BREAK_LABEL(ctx));
        goto done;
    /* switch: the selector is converted to int unless it is long, unsigned long or
       unsigned; the cases and default found in the body are attached to the switch block
       afterwards.  A switch without default gets one at its end */
    case 0x5E:
        WARN_IF_UNREACHABLE(flag);
        name = STR_SWITCH_2_P;
        if (next_token() != 1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING, name);
            goto done;
        }
        next_token();
        node = PARSE_EXPRESSION(0, 0);
        if (!node)
            goto done;
        if (EXPR_W(node, EXPR_KIND) != TK_LONG && EXPR_W(node, EXPR_KIND) != TK_ULONG && EXPR_W(node, EXPR_KIND) != TK_UINT)
            node = STASSIGN(node, PLAIN_INT_TYPE);
        saved_cases2 = SWITCH_CASE_LIST;
        saved_default2 = SWITCH_DEFAULT_LABEL;
        SWITCH_DEFAULT_LABEL = 0;
        SWITCH_CASE_LIST = 0;
        MARK_SYMBOLS_REFERENCED(node);
        node = FOLD_EXPRESSION(node);
        label = NEW_SWITCH_BLOCK(node, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        append(label);
        if (TOKEN_TYPE != 2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63, name);
            goto done;
        }
        BREAK_LABEL(ctx) = NEW_LABEL();
        if (CURRENT_LOOP_CONTEXT)
            CONTINUE_LABEL(ctx) = CONTINUE_LABEL(CURRENT_LOOP_CONTEXT);
        else
            CONTINUE_LABEL(ctx) = 0;
        PREV_LOOP(ctx) = CURRENT_LOOP_CONTEXT;
        PREV_SWITCH(ctx) = CURRENT_SWITCH_CONTEXT;
        KIND(ctx) = 0x5E;
        BROKEN(ctx) = 0;
        CURRENT_LOOP_CONTEXT = ctx;
        CURRENT_SWITCH_CONTEXT = ctx;
        W(flag) = 0;
        PARSE_STATEMENT_C(flag);
        if (SWITCH_DEFAULT_LABEL == 0) {
            SWITCH_DEFAULT_LABEL = NEW_LABEL();
            append(SWITCH_DEFAULT_LABEL);
            W(flag) = 1;
        } else if (BROKEN(ctx))
            W(flag) = 1;
        SET_SWITCH_BLOCK_INFO(label, SWITCH_DEFAULT_LABEL, SWITCH_CASE_LIST);
        SWITCH_CASE_LIST = saved_cases2;
        SWITCH_DEFAULT_LABEL = saved_default2;
        append(BREAK_LABEL(ctx));
        CURRENT_LOOP_CONTEXT = PREV_LOOP(ctx);
        CURRENT_SWITCH_CONTEXT = PREV_SWITCH(ctx);
        goto done;
    case 0x60:
        WARN_IF_UNREACHABLE(flag);
        if (next_token() != 7) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, STR_BREAK_P);
            goto done;
        }
        if (CURRENT_LOOP_CONTEXT == 0 || BREAK_LABEL(CURRENT_LOOP_CONTEXT) == 0)
            REPORT_ERROR(MSG_MISPLACED_BREAK);
        else {
            EMIT_JUMP(BREAK_LABEL(CURRENT_LOOP_CONTEXT), file, line, TOKEN_FILE_NODE, TOKEN_LINE);
            BROKEN(CURRENT_LOOP_CONTEXT) = 1;
        }
        W(flag) = 0;
        goto done;
    case 0x61:
        WARN_IF_UNREACHABLE(flag);
        if (next_token() != 7) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, STR_CONTINUE_P);
            goto done;
        }
        if (CURRENT_LOOP_CONTEXT == 0 || CONTINUE_LABEL(CURRENT_LOOP_CONTEXT) == 0)
            REPORT_ERROR(MSG_MISPLACED_CONTINUE);
        else
            EMIT_JUMP(CONTINUE_LABEL(CURRENT_LOOP_CONTEXT), file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        W(flag) = 0;
        goto done;
    /* return: RETURN_FORM_SEEN remembers whether this function used "return;" (1) or
       "return value;" (2), to warn about mixing them */
    case 0x5F:
        WARN_IF_UNREACHABLE(flag);
        W(flag) = 0;
        if (next_token() != 7) {
            node = PARSE_EXPRESSION(0, 0);
            if (!node)
                goto done;
            if (TYPE_B(CURRENT_FUNCTION_TYPE, TYPE_KIND) == TK_VOID)
                REPORT_WARNING(MSG_VOID_FUNCTIONS_MAY_NOT);
            else
                node = STASSIGN(node, CURRENT_FUNCTION_TYPE);
            if (RETURN_FORM_SEEN == 1)
                REPORT_WARNING(MSG_BOTH_RETURN_RETURN);
            RETURN_FORM_SEEN = 2;
            if (TOKEN_TYPE != 7)
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, STR_RETURN_P);
        } else {
            if (CURRENT_FUNCTION_TYPE != PLAIN_INT_TYPE && TYPE_B(CURRENT_FUNCTION_TYPE, TYPE_KIND) != TK_VOID)
                REPORT_WARNING(MSG_FUNCTION_SHOULD_RETURN_367);
            else if (RETURN_FORM_SEEN == 2)
                REPORT_WARNING(MSG_BOTH_RETURN_RETURN);
            RETURN_FORM_SEEN = 1;
            node = 0;
        }
        MARK_SYMBOLS_REFERENCED(node);
        node = FOLD_EXPRESSION(node);
        if (TYPE_B(CURRENT_FUNCTION_TYPE, TYPE_KIND) == TK_STRUCT)
            node = COPY_STRUCT_RETURN(node);
        label = NEW_RETURN_JUMP_BLOCK(node, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        append(label);
        goto done;
    case 5:
        W(flag) = PARSE_BLOCK_BODY(0, W(flag));
        goto done;
    case 0x58:
        WARN_IF_UNREACHABLE(flag);
        if (next_token() != 0x31) {
            REPORT_AND_SKIP(MSG_GOTO_STATEMENT_MISSING, 0);
            goto done;
        }
        rec = LOOKUP_SYMBOL((u16)TOKEN_CONST_VALUE, C_FUNCTION_SCOPE, 1);
        if (rec == 0) {
            rec = DECLARE_SYMBOL((u16)TOKEN_CONST_VALUE, C_FUNCTION_SCOPE, 1, 3, 0, 0, 0);
            u16 l = NEW_LABEL();
            CSYM_W(rec, CSYM_LABEL) = l;
        }
        CSYM_W(rec, CSYM_FLAGS) |= 0x80;
        EMIT_JUMP(CSYM_W(rec, CSYM_LABEL), file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        if (next_token() != 7)
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64, STR_GOTO_2_P);
        W(flag) = 0;
        goto done;
    /* an identifier: a label if ':' follows (labels live in C_FUNCTION_SCOPE, flag 40h =
       defined), else the start of an expression statement, whose first name is passed to
       PARSE_EXPRESSION because it has been read already */
    case 0x31:
        ident = (u16)TOKEN_CONST_VALUE;
        if (next_token() == 0x21) {
            rec = LOOKUP_SYMBOL(ident, C_FUNCTION_SCOPE, 1);
            W(flag) = 1;
            STATEMENT_LABELED_FLAG = 1;
            if (rec == 0) {
                rec = DECLARE_SYMBOL(ident, C_FUNCTION_SCOPE, 1, 3, 0, 0, 0x40);
                u16 l = NEW_LABEL();
                CSYM_W(rec, CSYM_LABEL) = l;
            } else {
                if (CSYM_W(rec, CSYM_FLAGS) & 0x40) {
                    DIAG_NAME_BUFFER = 0;
                    REPORT_ERROR(MSG_MULTIPLE_DECLARATION, NAME_TEXT_COPY(CSYM_W(rec, CSYM_NAME)));
                    goto restart;
                }
                CSYM_W(rec, CSYM_FLAGS) |= 0x40;
            }
            append(CSYM_W(rec, CSYM_LABEL));
            goto restart;
        }
        /* fall through */
    default:
        WARN_IF_UNREACHABLE(flag);
        node = PARSE_EXPRESSION(ident, 0);
        if (!node)
            goto done;
        CHECK_EXPRESSION_EFFECT(node);
        node = FOLD_STATEMENT_EXPR(node);
        label = NEW_EXPRESSION_BLOCK(node, file, line, TOKEN_FILE_NODE, TOKEN_LINE);
        append(label);
        if (TOKEN_TYPE != 7)
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_234, 0);
        W(flag) = 1;
        /* fall through */
    case 7:
        break;
    }
done:
    scratch_release(mark);
}

/* a folded condition: 1 if always true (a nonzero constant or an address), -1 if always
   false (zero), 0 if it must be tested.  Warns on a struct value and on an assignment used
   as a condition */
i16 CLASSIFY_CONDITION(u16 node)
{
    if (EXPR_W(node, EXPR_KIND) == TK_STRUCT)
        REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
    switch (EXPR_W(node, EXPR_OP)) {
    case EOP_CONST:
        return EXPR_L(node, EXPR_LEFT) == 0 ? -1 : 1;
    case EOP_ADDR:
        return 1;
    case EOP_ASSIGN:
        REPORT_WARNING(MSG_POSSIBLY_INCORRECT);
        return 0;
    }
    return 0;
}

/* code that goes to label first when the condition node is false: nothing if it is always
   true, a jump if always false, else a branch block.  second to fifth are the file and
   line positions of the start and end of the condition.  Returns the classification */
i16 BRANCH_IF_FALSE(u16 node, u16 first, u16 second, u16 third, u16 fourth, u16 fifth)
{
    node = STBIN3(node);
    node = FOLD_EXPRESSION(node);
    i16 classification = CLASSIFY_CONDITION(node);
    MARK_SYMBOLS_REFERENCED(node);
    if (classification < 0)
        EMIT_JUMP(first, second, third, fourth, fifth);
    else if (classification == 0) {
        u16 temporary = NEW_BRANCH_BLOCK(0, node, first, second, third, fourth, fifth);
        append(temporary);
    }
    return classification;
}

/* the same, going to label first when the condition is true */
i16 BRANCH_IF_TRUE(u16 node, u16 first, u16 second, u16 third, u16 fourth, u16 fifth)
{
    node = STBIN3(node);
    node = FOLD_EXPRESSION(node);
    i16 classification = CLASSIFY_CONDITION(node);
    if (classification > 0)
        EMIT_JUMP(first, second, third, fourth, fifth);
    else if (classification == 0) {
        u16 temporary = NEW_BRANCH_BLOCK(1, node, first, second, third, fourth, fifth);
        append(temporary);
    }
    return classification;
}

/* a jump to label first (second to fifth: source positions) */
void EMIT_JUMP(u16 first, u16 second, u16 third, u16 fourth, u16 fifth)
{
    u16 chain = BCC_TREE_SPECIAL;                   /* pascal: read before the call */
    u16 block = NEW_JUMP_BLOCK(first, second, third, fourth, fifth);
    APPEND_BLOCK_CHAIN(chain, block, (u16)LOOP_BLOCK_WEIGHT);
}

/* an expression used as a statement.  Warns "code has no effect" for an operator without
   side effects (EXPR_OP_HAS_EFFECT) whose value is not void, looking into comma and ?:
   operands.  As the value is discarded, x++ and x-- become x += and x -= (the step amount
   is in the node already).  Then marks the symbols used */
void CHECK_EXPRESSION_EFFECT(u16 node)
{
    u16 child;
    if (node == 0)
        return;
    if (EXPR_W(node, EXPR_KIND) == TK_UNDEFINED)
        return;
    if (EXPR_W(node, EXPR_OP) == EOP_COMMA) {
        CHECK_EXPRESSION_EFFECT(EXPR_W(node, EXPR_LEFT));
        CHECK_EXPRESSION_EFFECT(EXPR_W(node, EXPR_RIGHT));
    } else if (EXPR_W(node, EXPR_OP) == EOP_QUESTION) {
        if (EXPR_W(node, EXPR_RIGHT) == 0)
            return;
        child = EXPR_W(EXPR_W(node, EXPR_RIGHT), EXPR_LEFT);
        if (EXPR_W(child, EXPR_OP) == 0x35 && EXPR_W(child, EXPR_KIND) != TK_VOID)
            child = EXPR_W(child, EXPR_LEFT);
        CHECK_EXPRESSION_EFFECT(child);
        child = EXPR_W(EXPR_W(node, EXPR_RIGHT), EXPR_RIGHT);
        if (EXPR_W(child, EXPR_OP) == 0x35 && EXPR_W(child, EXPR_KIND) != TK_VOID)
            child = EXPR_W(child, EXPR_LEFT);
        CHECK_EXPRESSION_EFFECT(child);
        MARK_SYMBOLS_REFERENCED(EXPR_W(node, EXPR_LEFT));
    } else {
        if (EXPR_W(node, EXPR_OP) == EOP_POSTINC)
            EXPR_W(node, EXPR_OP) = EOP_ADD_ASSIGN;
        else if (EXPR_W(node, EXPR_OP) == EOP_POSTDEC)
            EXPR_W(node, EXPR_OP) = EOP_SUB_ASSIGN;
        else {
            if (EXPR_W(node, EXPR_OP) == 5 && CSYM_W(EXPR_W(node, EXPR_LEFT), CSYM_NAME) == 0)
                return;
            if (EXPR_W(node, EXPR_KIND) != TK_VOID && !EXPR_OP_HAS_EFFECT_AT(EXPR_W(node, EXPR_OP)))
                REPORT_WARNING(MSG_CODE_HAS_NO_EFFECT);
        }
        MARK_SYMBOLS_REFERENCED(node);
    }
}

/* walks an expression and sets the C symbol flags of the variables in it: 80h used, 40h
   assigned, 100h address taken.  A local read before anything was assigned to it gets the
   "possibly used before definition" warning.  Operators 5 and 6 are local and register
   variable nodes, 1 other symbols, 33h a field selection that is looked through.  Taking
   the address of an array also changes that node's type to the element type */
void MARK_SYMBOLS_REFERENCED(u16 input)
{
    u16 child, node = input;
    for (;;) {
        if (!node)
            return;
        if (EXPR_I(node, EXPR_KIND) == TK_UNDEFINED)
            return;
        switch (EXPR_I(node, EXPR_OP)) {
        case 5:
        case 6:
            if (!(CSYM_W(EXPR_I(node, EXPR_LEFT), CSYM_FLAGS) & 0x40))
                WARN_USE_BEFORE_ASSIGN(EXPR_I(node, EXPR_LEFT));
            /* fall through */
        case 1:
            CSYM_W(EXPR_I(node, EXPR_LEFT), CSYM_FLAGS) |= 0x80;
            return;
        case EOP_ASSIGN:
            if (EXPR_I(node, EXPR_RIGHT))
                MARK_SYMBOLS_REFERENCED(EXPR_I(node, EXPR_RIGHT));
            child = EXPR_I(node, EXPR_LEFT);
            if (EXPR_I(child, EXPR_OP) == 0x33)
                child = EXPR_I(child, EXPR_LEFT);
            if (EXPR_I(child, EXPR_OP) == 1) {
                CSYM_W(EXPR_I(child, EXPR_LEFT), CSYM_FLAGS) |= 0xC0;
                return;
            }
            if (EXPR_I(child, EXPR_OP) == 6 || EXPR_I(child, EXPR_OP) == 5) {
                CSYM_W(EXPR_I(child, EXPR_LEFT), CSYM_FLAGS) |= 0x40;
                return;
            }
            node = child;
            continue;
        case EOP_COMMA:
            CHECK_EXPRESSION_EFFECT(EXPR_I(node, EXPR_LEFT));
            node = EXPR_I(node, EXPR_RIGHT);
            continue;
        case 0x33:
            node = EXPR_I(node, EXPR_LEFT);
            continue;
        case EOP_ADDR:
            child = EXPR_I(node, EXPR_LEFT);
            if (EXPR_I(child, EXPR_OP) == 1 || EXPR_I(child, EXPR_OP) == 6 || EXPR_I(child, EXPR_OP) == 5)
                CSYM_W(EXPR_I(child, EXPR_LEFT), CSYM_FLAGS) |= 0x1C0;
            if (EXPR_I(child, EXPR_KIND) == TK_ARRAY) {
                EXPR_I(child, EXPR_TYPE) = TYPE_W(EXPR_I(child, EXPR_TYPE), TYPE_TARGET);
                EXPR_I(child, EXPR_KIND) = TYPE_B(EXPR_I(child, EXPR_TYPE), TYPE_KIND);
            }
            /* fall through */
        default:
            if (EXPR_I(node, EXPR_LEFT))
                MARK_SYMBOLS_REFERENCED(EXPR_I(node, EXPR_LEFT));
            node = EXPR_I(node, EXPR_RIGHT);
            continue;
        case EOP_CONST:
        case 3:
        case 4:
        case 7:
            return;
        }
    }
}

/* for a function returning a struct whose size is not 1, 2 or 4: the return value
   becomes "*hidden = value, *hidden" through the hidden return pointer
   STRUCT_RETURN_PARAM, so the value is copied to the caller's buffer (operators 31h
   dereference, 12h assignment, 2Ah comma).  Smaller structs come back in registers */
u16 COPY_STRUCT_RETURN(u16 node)
{
    if (!node || !EXPR_W(node, EXPR_OP))
        return node;
    u16 kind = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_C_SIZE);
    if (kind == 1 || kind == 2 || kind == 4)
        return node;
    u16 result = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(CSYM_W(STRUCT_RETURN_PARAM, CSYM_TYPE)),
                               A16(STRUCT_RETURN_PARAM), A16(0), A16(0));
    result = (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(0x31), A16(CURRENT_FUNCTION_TYPE), A16(result), A16(0));
    node = (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(0x12), A16(CURRENT_FUNCTION_TYPE), A16(result), A16(node));
    result = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(CSYM_W(STRUCT_RETURN_PARAM, CSYM_TYPE)),
                           A16(STRUCT_RETURN_PARAM), A16(0), A16(0));
    result = (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(0x31), A16(CURRENT_FUNCTION_TYPE), A16(result), A16(0));
    node = (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(0x2A), A16(CURRENT_FUNCTION_TYPE), A16(node), A16(result));
    return node;
}

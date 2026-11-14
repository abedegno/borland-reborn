/* inlinebd.c: from bcc20/src/cpp/INLINEBD.C: inline function bodies are not compiled where
   they appear.  When the parser meets the body of an inline function (FUNCDEF.C) or of a
   member function defined inside its class (CLASSDEF.C), RECORD_INLINE_BODY copies the
   body's tokens into the token stream TOKEN_STREAM_HANDLE and remembers where they start in
   the symbol (word 13).  COMPILE_INLINE_BODY later replays those tokens through
   INLINE_TOKEN_STREAM as if they were source text and runs the function-definition compiler
   on them, saving and restoring the parser state around it: with enabled 0 to check the
   body without generating code, with enabled 1 from CPPFINAL.C at the end of the file to
   emit an out-of-line copy.  While recording, the function loses its inline-expansion flag
   (word 10 bit 4) if it has an ellipsis, more than 16 parameters, or a statement keyword
   TYPE_FLAGS marks with 80h; asm statements are an error.  The token records (19 bytes)
   passed by address live in the scratch area; the 80-byte function state BCC_TREE_SPECIAL
   is saved in a host buffer. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define S(n, o) SYM_W((n), (o))
#define SB_(n, o) SYM_B((n), (o))
#define T(n, o) TYPE_W((n), (o))
#define TB(n, o) TYPE_B((n), (o))
#define P(n, o) FORMAL_W((n), (o))
#define TOKEN_STREAM_POS W(TOKEN_STREAM_POS_P)
#define FUNCTION_DEF_POSITION W(FUNCTION_DEF_POSITION_P)    /* this file writes its low word */
#define FUNCTION_BODY_DEPTH B(FUNCTION_BODY_DEPTH_P)
#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define TOKEN_RECORD_SIZE 19
#define CONTEXT_SIZE 80


/* records the tokens from the current token (a ':' starting a constructor's
   mem-initializer list, or the '{') to the matching '}' and leaves the parser after the
   body.  symbol is the function (0 to just skip and record a body): it is marked inline
   kind 1, defined, storage class 3, and eligible for inline expansion unless the checks
   fail.  The mem-initializer list is skipped crudely: tokens are taken while TYPE_FLAGS has
   800h or they are commas, which stops at the '{' */
void RECORD_INLINE_BODY(u16 symbol)
{
    u8 eligible = 0, warned = 0;
    if (symbol) {
        SB_(symbol, 12) = (SB_(symbol, 12) & 0xFC) | 1;
        S(symbol, 13) = TOKEN_STREAM_POS;
        SB_(symbol, 6) |= 3;
        SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 0x18;
        S(symbol, 10) |= 4;
        if (!(TB(S(symbol, 4), 12) & 4)) {
            i16 count = 0;
            for (u16 parameter = T(S(symbol, 4), 9); parameter; parameter = P(parameter, 0))
                ++count;
            eligible = count <= 16;
        }
    }
    TOKEN_RECORD_STREAM = TOKEN_STREAM_HANDLE;
    STREAM_SEEK(TOKEN_STREAM_HANDLE, (i16)TOKEN_STREAM_POS);
    STREAM_PUT_TOKEN(TOKEN_STREAM_HANDLE, CURRENT_TOKEN_RECORD_P);
    RECORDING_TOKENS = 1;
    if (CURRENT_TOKEN == TOK_COLON) {
        ADVANCE_TOKEN();
        while ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x800) || CURRENT_TOKEN == TOK_COMMA)
            ADVANCE_TOKEN();
    }
    if (CURRENT_TOKEN == TOK_LBRACE) {
        i16 nesting = 0;
        for (;;) {
            if (CURRENT_TOKEN == 0) {
                REPORT_CURRENT_TOKEN(MSG_COMPOUND_STATEMENT);
                break;
            }
            if (CURRENT_TOKEN == TOK_LBRACE)
                ++nesting;
            else if (CURRENT_TOKEN == TOK_RBRACE) {
                if (--nesting == 0)
                    break;
            } else if (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x80) {
                if (CURRENT_TOKEN == TOK_ASM) {
                    if (!warned) {
                        REPORT_CURRENT_TOKEN(MSG_INLINE_ASSEMBLY_NOT_214);
                        warned = 1;
                    }
                    BCC_LEX_SKIP();
                } else
                    REPORT_DIAGNOSTIC(MSG_FUNCTIONS_CONTAINING, (i32)NAME_TEXT_COPY(TOKEN_NAMES_AT(CURRENT_TOKEN)), 0);
                eligible = 0;
            }
            ADVANCE_TOKEN();
        }
    }
    if (symbol && !eligible)
        S(symbol, 10) &= ~4;
    STREAM_PUT_TOKEN(TOKEN_STREAM_HANDLE, CURRENT_TOKEN_RECORD_P);
    STREAM_PUT_END(TOKEN_STREAM_HANDLE);
    TOKEN_STREAM_POS = (u16)STREAM_TELL(TOKEN_STREAM_HANDLE);
    if (CURRENT_TOKEN == TOK_RBRACE)
        ADVANCE_TOKEN();
}

/* compiles the recorded body of the inline function symbol.  Saves the current and
   look-ahead tokens, file name, function name, parser flags and (inside a function body)
   the current function state; pushes symbol on INLINE_FUNCTION_STACK and the inline token
   stream on the input stack; seeks to the body and calls COMPILE_FUNCTION_DEFINITION with
   storage token 35h (static) and the owning class for a member function.  Code generation
   is on only if enabled (and stays off afterwards if errors occurred).  Bits 0-1 of the
   symbol's flags are cleared for the compile; with enabled 0 the saved flag byte is put
   back afterwards */
void COMPILE_INLINE_BODY(u16 symbol, u8 enabled)
{
    u8 saved_context[CONTEXT_SIZE];
    u8 saved_token[TOKEN_RECORD_SIZE], saved_lookahead[TOKEN_RECORD_SIZE];
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++) {
        saved_token[i] = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
        saved_lookahead[i] = B(fp_add(TOKEN_TYPE_P, i));
    }
    u16 saved_input = CURRENT_FILE_NAME;
    farptr saved_name = FUNCTION_NAME_TEXT;
    u16 saved_flags = SB_(symbol, 6);
    u8 saved_parse = NO_ERRORS_YET;
    u8 saved_context_mode = FUNCTION_BODY_DEPTH;
    u16 saved_depth = SCOPE_STACK_DEPTH;
    u8 saved_permission = INLINE_OPTION_BLOCK_FLAG;
    if (saved_context_mode)
        for (int i = 0; i < CONTEXT_SIZE; i++)
            saved_context[i] = B(fp_add(BCC_TREE_SPECIAL_P, i));
    SB_(symbol, 6) &= 0xFC;
    INLINE_FUNCTION_STACK = LIST_CONS(0, symbol);
    C26_SCOPE_STACK_AT(SCOPE_STACK_DEPTH) = INLINE_TOKEN_STREAM;
    ++SCOPE_STACK_DEPTH;
    STREAM_COPY_STATE(INLINE_TOKEN_STREAM, TOKEN_STREAM_HANDLE);
    STREAM_SEEK(INLINE_TOKEN_STREAM, (i16)S(symbol, 13));
    STREAM_GET_TOKEN(INLINE_TOKEN_STREAM, CURRENT_TOKEN_RECORD_P);
    CURRENT_TOKEN = W(CURRENT_TOKEN_RECORD_P);
    STREAM_GET_TOKEN(INLINE_TOKEN_STREAM, TOKEN_TYPE_P);
    NO_ERRORS_YET = enabled;
    INLINE_OPTION_BLOCK_FLAG = INLINE_OPTION_BLOCK_FLAG && enabled;
    FUNCTION_DEF_LINE = W(fp_add(CURRENT_TOKEN_RECORD_P, 5));     /* location[1] */
    CURRENT_SOURCE_FILE = W(fp_add(CURRENT_TOKEN_RECORD_P, 3));   /* location[0] */
    FUNC_START_CLEARED_WORD = 0;
    FUNCTION_DEF_POSITION = 0;
    u16 owner = (SB_(symbol, 6) & 0x10) ? S(S(symbol, 0), 4) : 0;
    COMPILE_FUNCTION_DEFINITION(S(symbol, 4), owner, S(symbol, 2), S(symbol, 15), 0x35, 0, 1);
    SCOPE_STACK_DEPTH = saved_depth;
    if (saved_context_mode)
        for (int i = 0; i < CONTEXT_SIZE; i++)
            B(fp_add(BCC_TREE_SPECIAL_P, i)) = saved_context[i];
    LIST_CELL_FREE(INLINE_FUNCTION_STACK);
    INLINE_FUNCTION_STACK = 0;
    CURRENT_FILE_NAME = saved_input;
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        B(fp_add(CURRENT_TOKEN_RECORD_P, i)) = saved_token[i];
    CURRENT_TOKEN = W(CURRENT_TOKEN_RECORD_P);
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        B(fp_add(TOKEN_TYPE_P, i)) = saved_lookahead[i];
    NO_ERRORS_YET = saved_parse && ERROR_COUNT == 0;
    FUNCTION_NAME_TEXT = saved_name;
    if (!enabled)
        SB_(symbol, 6) = (u8)saved_flags;
    INLINE_OPTION_BLOCK_FLAG = saved_permission;
}

/* target: ovr082_C26UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ inline functions: records the tokens of an inline body for later and compiles
   the recorded body; rejects asm in inline functions. Entry points: RECORD_INLINE_BODY,
   COMPILE_INLINE_BODY. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: inline function bodies are not compiled where they appear. When the
   parser meets the body of an inline function (parser/FUNCDEF.C) or of a member
   function defined inside its class (CLASSDEF.C), RECORD_INLINE_BODY copies the
   body's tokens into the token stream TOKEN_STREAM_HANDLE and remembers where they
   start in the symbol (SYM_INLINE_POS, raw offset 13). COMPILE_INLINE_BODY later
   replays those tokens through INLINE_TOKEN_STREAM as if they were source text and
   runs the normal function-definition compiler on them, saving and restoring the
   parser state around it. It is called with enabled 0 to check the body (and,
   probably, to build the tree used for inline expansion) without generating code:
   right after recording (FUNCDEF.C) or when a class is complete (IMPLMEMB.C); and
   with enabled 1 from CPPFINAL.C at the end of the file to emit an out-of-line copy
   of the inline functions that were queued by QUEUE_DEFERRED_SYMBOL.
   While recording, the function loses its inline-expansion flag (SYM_FUNC_FLAGS
   bit 4, raw S(symbol,10)) if it has an ellipsis, more than 16 parameters, or a
   statement keyword that TYPE_FLAGS marks with 0x80 (warning
   MSG_FUNCTIONS_CONTAINING); asm statements are an error (MSG_INLINE_ASSEMBLY_NOT_214).
   Raw offsets here: symbol 4 SYM_TYPE, 6 SYM_FLAGS, 7 SYM_STORAGE_CLASS, 10
   SYM_FUNC_FLAGS, 12 SYM_INLINE_ACCESS, 13 SYM_INLINE_POS, 15 SYM_FUNC_KIND; type 9
   TYPE_PARAMS, 12 TYPE_FUNC_FLAGS. */
#include <dos.h>
#include "INLINEBD.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) AT_B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define P(n,o) AT_W(FORMAL_POOL_SEG,(unsigned int)(n)+(o))

/* 0000: record one balanced body and its genuine inline-eligibility effects. */
/* RECORD_INLINE_BODY: records the tokens from the current token (a ':' starting a
   constructor's mem-initializer list, or the '{') to the matching '}' and leaves the
   parser after the body. symbol is the function (0 to just skip and record a body):
   it is marked inline kind 1, defined (SYM_FLAGS 3), storage class 3, and eligible for
   inline expansion unless the checks in the overview fail. The mem-initializer list
   is skipped crudely: tokens are taken while TYPE_FLAGS has 0x800 or they are commas,
   which stops at the '{' (probably 0x800 marks tokens allowed in such a list). */
void far pascal RECORD_INLINE_BODY(register unsigned int symbol)
{
    int count;
    unsigned int parameter;
    unsigned char eligible;
    unsigned char warned;
    register int nesting;
    warned=0;
    eligible=0;
    if(symbol) {
        SB(symbol,12)=(SB(symbol,12)&0xFC)|1;
        S(symbol,13)=TOKEN_STREAM_POS;
        SB(symbol,6)|=3;
        SB(symbol,7)=(SB(symbol,7)&7)|0x18;
        S(symbol,10)|=4;
        if(TB(S(symbol,4),12)&4)
            goto actual_after_symbol_join;
        count=0;
        for(parameter=T(S(symbol,4),9);parameter;parameter=P(parameter,0))
            ++count;
        eligible=count<=16;
    }
actual_after_symbol_join:
    TOKEN_RECORD_STREAM=TOKEN_STREAM_HANDLE;
    STREAM_SEEK(TOKEN_STREAM_HANDLE,TOKEN_STREAM_POS);
    STREAM_PUT_TOKEN(TOKEN_STREAM_HANDLE,&CURRENT_TOKEN_RECORD);
    RECORDING_TOKENS=1;
    if(CURRENT_TOKEN==TOK_COLON) {
        ADVANCE_TOKEN();
        while((TYPE_FLAGS[CURRENT_TOKEN]&0x800) || CURRENT_TOKEN==TOK_COMMA)
            ADVANCE_TOKEN();
    }
    if(CURRENT_TOKEN==TOK_LBRACE) {
        nesting=0;
        for(;;) {
            if(CURRENT_TOKEN==0) {
                REPORT_CURRENT_TOKEN(MSG_COMPOUND_STATEMENT);
                break;
            }
            if(CURRENT_TOKEN==TOK_LBRACE)
                ++nesting;
            else if(CURRENT_TOKEN==TOK_RBRACE) {
                if(--nesting==0)
                    break;
            } else if(TYPE_FLAGS[CURRENT_TOKEN]&0x80) {
                if(CURRENT_TOKEN==TOK_ASM) {
                    if(!warned) {
                        REPORT_CURRENT_TOKEN(MSG_INLINE_ASSEMBLY_NOT_214);
                        warned=1;
                    }
                    BCC_LEX_SKIP();
                } else
                    REPORT_DIAGNOSTIC(MSG_FUNCTIONS_CONTAINING,NAME_TEXT_COPY(TOKEN_NAMES[CURRENT_TOKEN]),0L);
                eligible=0;
            }
            ADVANCE_TOKEN();
        }
    }
    if(symbol && !eligible)
        S(symbol,10)&=~4;
    STREAM_PUT_TOKEN(TOKEN_STREAM_HANDLE,&CURRENT_TOKEN_RECORD);
    STREAM_PUT_END(TOKEN_STREAM_HANDLE);
    TOKEN_STREAM_POS=STREAM_TELL(TOKEN_STREAM_HANDLE);
    if(CURRENT_TOKEN==TOK_RBRACE)
        ADVANCE_TOKEN();
}

/* 01BA: two token snapshots and conditional80B parser-context preservation. */
/* COMPILE_INLINE_BODY: compiles the recorded body of the inline function symbol.
   Saves the current and lookahead tokens, file name, function name, parser flags and
   (when inside a function body) the current function record BCC_TREE_SPECIAL; pushes
   symbol on INLINE_FUNCTION_STACK and the inline token stream on C26_SCOPE_STACK (the
   input stack); seeks to SYM_INLINE_POS and calls COMPILE_FUNCTION_DEFINITION with
   storage token 0x35 (static) and the owning class for a member function. Code
   generation is on only if enabled (NO_ERRORS_YET=enabled, and stays off afterwards
   if errors occurred). Bits 0-1 of SYM_FLAGS are cleared for the compile; with
   enabled 0 the saved flag byte is put back afterwards. */
void far pascal COMPILE_INLINE_BODY(register unsigned int symbol,unsigned char enabled)
{
    unsigned int owner;
    unsigned int saved_input;
    char far *saved_name;
    unsigned int saved_flags;
    unsigned char saved_parse;
    unsigned char saved_context_mode;
    unsigned int saved_depth;
    unsigned char saved_permission;
    struct C26Token saved_token;
    struct C26Token saved_lookahead;
    struct C26Context saved_context;
    saved_token=CURRENT_TOKEN_RECORD;
    saved_lookahead=TOKEN_TYPE;
    saved_input=CURRENT_FILE_NAME;
    saved_name=FUNCTION_NAME_TEXT;
    saved_flags=SB(symbol,6);
    saved_parse=NO_ERRORS_YET;
    saved_context_mode=FUNCTION_BODY_DEPTH;
    saved_depth=SCOPE_STACK_DEPTH;
    saved_permission=INLINE_OPTION_BLOCK_FLAG;
    if(saved_context_mode)
        saved_context=BCC_TREE_SPECIAL;
    SB(symbol,6)&=0xFC;
    INLINE_FUNCTION_STACK=LIST_CONS(0,symbol);
    C26_SCOPE_STACK[SCOPE_STACK_DEPTH]=INLINE_TOKEN_STREAM;
    ++SCOPE_STACK_DEPTH;
    STREAM_COPY_STATE(INLINE_TOKEN_STREAM,TOKEN_STREAM_HANDLE);
    STREAM_SEEK(INLINE_TOKEN_STREAM,S(symbol,13));
    STREAM_GET_TOKEN(INLINE_TOKEN_STREAM,&CURRENT_TOKEN_RECORD);
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    STREAM_GET_TOKEN(INLINE_TOKEN_STREAM,&TOKEN_TYPE);
    NO_ERRORS_YET=enabled;
    INLINE_OPTION_BLOCK_FLAG=INLINE_OPTION_BLOCK_FLAG && enabled;
    FUNCTION_DEF_LINE=CURRENT_TOKEN_RECORD.location[1];
    CURRENT_SOURCE_FILE=CURRENT_TOKEN_RECORD.location[0];
    FUNC_START_CLEARED_WORD=0;
    FUNCTION_DEF_POSITION=0;
    owner=(SB(symbol,6)&0x10)?S(S(symbol,0),4):0;
    COMPILE_FUNCTION_DEFINITION(S(symbol,4),owner,S(symbol,2),S(symbol,15),0x35,0,1);
    SCOPE_STACK_DEPTH=saved_depth;
    if(saved_context_mode)
        BCC_TREE_SPECIAL=saved_context;
    LIST_CELL_FREE(INLINE_FUNCTION_STACK);
    INLINE_FUNCTION_STACK=0;
    CURRENT_FILE_NAME=saved_input;
    CURRENT_TOKEN_RECORD=saved_token;
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    TOKEN_TYPE=saved_lookahead;
    NO_ERRORS_YET=saved_parse && ERROR_COUNT==0;
    FUNCTION_NAME_TEXT=saved_name;
    if(!enabled)
        SB(symbol,6)=saved_flags;
    INLINE_OPTION_BLOCK_FLAG=saved_permission;
}

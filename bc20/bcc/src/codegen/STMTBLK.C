/* target: ovr058_C77UNIT */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: parser-to-back-end interface; appends function, scope, jump,
   return and expression blocks to the flow graph only while code generation is enabled.
   Entry points: NEW_LABEL_IF_ENABLED, START_FUNCTION_STATE, FINISH_FUNCTION_STATE,
   APPEND_SCOPE_ENTER_BLOCK, APPEND_SCOPE_EXIT_BLOCK, APPEND_SWITCH_BLOCK,
   SET_SWITCH_INFO_IF_ENABLED, APPEND_JUMP_IF_FALSE_BLOCK (+17 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the calls the statement parsers make to build a function for the back end.
   Each takes front-end trees and source locations and turns them into flow blocks
   (FLOWBLK.C), appending them to the current function's block list with
   APPEND_BLOCK_CHAIN and the current LOOP_NEST_FACTOR as the blocks' loop weight. All of
   them do nothing (and release the expression pool with RESET_EXPR_POOL_ALT) while
   NO_ERRORS_YET is clear, i.e. once an error has stopped code generation. Expressions go
   through LOWER_EXPRESSION (expr/LOWEREXP.C) first, which turns C++ trees into the shapes
   the back end knows. The existing comment above each function starts with its offset in
   the original module.
   A 'record' argument (struct C77Record6) is a source location: 'first' the file,
   'second' the line (0 for none); together with CURRENT_TOKEN_FILE/LINE it becomes the
   line-mark ops (op 1) at the start of the new block. BCC_PARSE_BUFFER holds what
   INIT_FUNCTION_STATE returned (always 1) and only says that a function is open.
   The MAKE_* functions return the new block without appending it (the caller places it
   later, e.g. with SPLICE_STATEMENT_CHAIN); the APPEND_* ones append it at once. */
#include <dos.h>
#include "STMTBLK.H"
#include "POOL.H"
#define STORAGE_FLAGS(n) (*(unsigned char far *)MK_FP(STORAGE_POOL_SEG,((n)&0xFFFE)+8))

/* 0000: a new label block (NEW_LABEL), or zero while code generation is off. (Corrected:
   this used to say 'current output position'; the function returns a flow block.) */
unsigned int far pascal NEW_LABEL_IF_ENABLED(void)
{
    if(NO_ERRORS_YET) return NEW_LABEL();
    return 0;
}

/* 0015: begin the current declaration and initialize its context bank. */
/* START_FUNCTION_STATE: opens the back-end state for the function being defined
   (BCC_TREE_SPECIAL): INIT_FUNCTION_STATE with its storage record, return type,
   parameters, calling convention, function flags, code segment and source position. When
   VTABLE_MODE is 3 and the function has a code segment of its own (probably the 'smart'
   -V mode, see cpp/CPPCTOR.C), that segment becomes CODE_SEGMENT_ID first. */
void far pascal START_FUNCTION_STATE(void)
{
    unsigned int type,name,stream;

    if(NO_ERRORS_YET) {
        type=SYM_W(BCC_TREE_SPECIAL,SYM_TYPE);
        name=PREPARE_SYMBOL(BCC_TREE_SPECIAL);
        if(VTABLE_MODE==3) {
            stream=(unsigned int)GET_SYMBOL_SEGMENT_HOOK(name);
            if(stream!=0xFFFF && stream!=CODE_SEGMENT_ID) {
                CODE_SEGMENT_ID=stream;
                CURRENT_SOURCE_FILE=CLONE_NODE_KEEP_SERIAL(CURRENT_SOURCE_FILE);
            }
        }
        BCC_PARSE_BUFFER=INIT_FUNCTION_STATE(name,TYPE_W(type,TYPE_TARGET),TYPE_W(type,TYPE_PARAMS),
            TYPE_B(type,TYPE_CALL_CONV),TYPE_B(type,TYPE_FUNC_FLAGS),CODE_SEGMENT_ID,CURRENT_SOURCE_FILE,
            FUNCTION_DEF_LINE,FUNCTION_DEF_POSITION);
        POOL_TRIM((unsigned int far *)&CONTEXT_SEG,100);
    } else BCC_PARSE_BUFFER=0;
}

/* 00BA: finish the current declaration at the current location. */
/* FINISH_FUNCTION_STATE: closes the function: FINISH_FUNCTION_BLOCKS appends the return
   label and generates the code, with the current token's file and line as the closing
   position. */
void far pascal FINISH_FUNCTION_STATE(void)
{
    if(NO_ERRORS_YET)
        FINISH_FUNCTION_BLOCKS(BCC_PARSE_BUFFER,CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE);
}

/* 00D7: makes the scope entry block of CURRENT_SCOPE (corrected; this used to say
   'output handle'): NEW_SCOPE_ENTER_BLOCK, linked under the parent scope's entry block,
   stored in SCOPE_ENTER_BLOCK and appended to the function's block list. Zero while
   code generation is off. */
void far pascal APPEND_SCOPE_ENTER_BLOCK(void)
{
    if(NO_ERRORS_YET) {
        SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK)=NEW_SCOPE_ENTER_BLOCK(CURRENT_SCOPE,SCOPE_W(SCOPE_W(CURRENT_SCOPE,SCOPE_PARENT),SCOPE_ENTER_BLOCK));
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK),LOOP_NEST_FACTOR);
    } else SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK)=0;
}

/* 0128: appends the scope exit block matching CURRENT_SCOPE's entry block (corrected;
   this used to say 'emit a value'). */
void far pascal APPEND_SCOPE_EXIT_BLOCK(void)
{
    if(NO_ERRORS_YET)
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,NEW_SCOPE_EXIT_BLOCK(SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK)),LOOP_NEST_FACTOR);
}

/* 0153: emit and return a result carrying a complete source record. */
/* APPEND_SWITCH_BLOCK: switch statement head: a switch block evaluating selector 'value'
   (NEW_SWITCH_BLOCK). Returns the block, later completed by SET_SWITCH_INFO_IF_ENABLED. */
unsigned int far pascal APPEND_SWITCH_BLOCK(unsigned int value,struct C77Record6 record)
{
    unsigned int result;

    if(NO_ERRORS_YET) {
        result=NEW_SWITCH_BLOCK(LOWER_EXPRESSION(value),record.first,record.second,
            CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    } else {
        RESET_EXPR_POOL_ALT();
        result=0;
    }
    return result;
}

/* 019A: SET_SWITCH_BLOCK_INFO on the first switch block of the chain at 'start': its
   default target (value1, as an unconditional jump) and case list (value2). (Reworded;
   this used to say 'update independent value fields on a node chain'.) */
void far pascal SET_SWITCH_INFO_IF_ENABLED(unsigned int start,unsigned int value1,unsigned int value2)
{
    if(NO_ERRORS_YET) SET_SWITCH_BLOCK_INFO(start,value1,value2);
}

/* 01B6: emit the zero-mode operation and append its result. */
/* APPEND_JUMP_IF_FALSE_BLOCK: appends 'if condition 'first' is false, jump to label
   block 'second'' (NEW_BRANCH_BLOCK with 0). */
void far pascal APPEND_JUMP_IF_FALSE_BLOCK(unsigned int first,unsigned int second,struct C77Record6 record)
{
    unsigned int result;

    if(NO_ERRORS_YET) {
        result=NEW_BRANCH_BLOCK(0,LOWER_EXPRESSION(first),second,record.first,record.second,
            CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    } else RESET_EXPR_POOL_ALT();
}

/* 0204: return the one-mode operation, with location only when supplied. */
/* MAKE_JUMP_IF_TRUE_BLOCK: returns, without appending, the blocks for 'if condition
   'first' is true, jump to label block 'second''; line marks only when 'record' has a
   line. */
unsigned int far pascal MAKE_JUMP_IF_TRUE_BLOCK(unsigned int first,unsigned int second,struct C77Record6 record)
{
    unsigned int converted;

    if(NO_ERRORS_YET) {
        converted=LOWER_EXPRESSION(first);
        return record.second ?
            NEW_BRANCH_BLOCK(1,converted,second,record.first,record.second,
                CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE) :
            NEW_BRANCH_BLOCK(1,converted,second,0,0,0,0);
    }
    RESET_EXPR_POOL_ALT();
    return 0;
}

/* 025E: emit the one-mode operation and append its result. */
/* APPEND_JUMP_IF_TRUE_BLOCK: the same, appended at once. */
void far pascal APPEND_JUMP_IF_TRUE_BLOCK(unsigned int first,unsigned int second,struct C77Record6 record)
{
    unsigned int result;

    if(NO_ERRORS_YET) {
        result=NEW_BRANCH_BLOCK(1,LOWER_EXPRESSION(first),second,record.first,record.second,
            CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    } else RESET_EXPR_POOL_ALT();
}

/* 02AD: the two source-record pairs are separately supplied to the leaf. */
/* APPEND_JUMP_BLOCK: appends an unconditional jump to label block 'value' (goto, break,
   continue), with 'record' as both line marks. */
void far pascal APPEND_JUMP_BLOCK(unsigned int value,struct C77Record6 record)
{
    unsigned int result;

    if(NO_ERRORS_YET) {
        result=NEW_JUMP_BLOCK(value,record.first,record.second,
            record.first,record.second);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    }
}

/* 02E6: return the operation for a nonzero node. */
/* MAKE_EXPRESSION_BLOCK: returns, without appending, a block evaluating expression 'node'
   for its side effects (0 when 'node' is 0). */
unsigned int far pascal MAKE_EXPRESSION_BLOCK(unsigned int node,struct C77Record6 record)
{
    unsigned int converted;

    if(NO_ERRORS_YET && node) {
        converted=LOWER_EXPRESSION(node);
        return record.second ?
            NEW_EXPRESSION_BLOCK(converted,record.first,record.second,
                CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE) :
            NEW_EXPRESSION_BLOCK(converted,0,0,0,0);
    }
    RESET_EXPR_POOL_ALT();
    return 0;
}

/* 0338: append the nonzero node's operation using the supplied record. */
/* APPEND_EXPRESSION_BLOCK: the same, appended at once. */
void far pascal APPEND_EXPRESSION_BLOCK(unsigned int node,struct C77Record6 record)
{
    unsigned int result;

    if(NO_ERRORS_YET && node) {
        result=NEW_EXPRESSION_BLOCK(LOWER_EXPRESSION(node),record.first,record.second,
            CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    } else RESET_EXPR_POOL_ALT();
}

/* 0387: insert the independent chain into its parent context. */
/* SPLICE_STATEMENT_CHAIN: inserts the block chain 'chain' (made earlier by a MAKE_*
   function) after block 'parent' (SPLICE_BLOCK_CHAIN); probably used where the parser
   makes code before it knows where it goes, such as a for loop's step expression. */
void far pascal SPLICE_STATEMENT_CHAIN(unsigned int chain,unsigned int parent)
{
    if(NO_ERRORS_YET) SPLICE_BLOCK_CHAIN(parent,chain,LOOP_NEST_FACTOR);
}

/* 03A4: normalize before testing the output mode. */
/* MAKE_RETURN_JUMP_BLOCK: 'return node;': analyses and simplifies 'node' (always, so
   errors are found even when no code is made), then returns, without appending, a block
   loading the return value followed by a jump to FUNCTION_RETURN_LABEL. */
unsigned int far pascal MAKE_RETURN_JUMP_BLOCK(unsigned int node,struct C77Record6 record)
{
    unsigned int converted;

    node=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node,VOID_TYPE),(unsigned char)0);
    if(NO_ERRORS_YET) {
        converted=LOWER_EXPRESSION(node);
        return record.second ?
            NEW_RETURN_JUMP_BLOCK(converted,record.first,record.second,
                CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE) :
            NEW_RETURN_JUMP_BLOCK(converted,0,0,0,0);
    }
    return 0;
}

/* 0402: append the alternate operation and preserve the full record input. */
/* APPEND_RETURN_JUMP_BLOCK: the same for an already analysed 'node', appended at once. */
void far pascal APPEND_RETURN_JUMP_BLOCK(unsigned int node,struct C77Record6 record)
{
    unsigned int result;

    if(NO_ERRORS_YET) {
        result=NEW_RETURN_JUMP_BLOCK(LOWER_EXPRESSION(node),record.first,record.second,
            CURRENT_TOKEN_FILE,CURRENT_TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    } else RESET_EXPR_POOL_ALT();
}

/* 044A: append a nonzero value. */
/* APPEND_BLOCK_IF_NONZERO: appends block (chain) 'value' when it is not 0. */
void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int value)
{
    if(NO_ERRORS_YET && value) APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,value,LOOP_NEST_FACTOR);
}

/* 046F: append the value before its final notification. */
/* APPEND_BLOCK_AND_MARK: appends block 'value' and sets its CNODE_FLAGS bit 1
   (SET_BLOCK_1C_FLAG_1). */
void far pascal APPEND_BLOCK_AND_MARK(unsigned int value)
{
    if(NO_ERRORS_YET) {
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,value,LOOP_NEST_FACTOR);
        SET_BLOCK_1C_FLAG_1(value);
    }
}

/* 0496: normalize even when output is disabled, then validate the result. */
/* APPEND_ANALYZED_EXPRESSION: expression statement: analyses and simplifies 'node' as a
   void expression (always), then appends a block for it unless nothing is left. */
void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int node)
{
    unsigned int result;

    node=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node,VOID_TYPE),(unsigned char)1);
    if(NO_ERRORS_YET && node && EXPR_W(node,EXPR_OP)) {
        result=NEW_EXPRESSION_BLOCK(LOWER_EXPRESSION(node),0,0,0,0);
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,result,LOOP_NEST_FACTOR);
    } else RESET_EXPR_POOL_ALT();
}

/* 04FC: the outer storage argument precedes its conditional conversion. */
/* REGISTER_SYMBOL_VARIABLE: links 'symbol''s storage record to a new variable-table
   entry (FIND_OR_ADD_VARIABLE, with the record's flag byte as flags), or to none while
   code generation is off. */
void far pascal REGISTER_SYMBOL_VARIABLE(unsigned int symbol)
{
    unsigned int storage;

    storage=PREPARE_SYMBOL(symbol);
    SET_SYMBOL_VARIABLE_HOOK(storage,NO_ERRORS_YET ?
        FIND_OR_ADD_VARIABLE(storage,TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_KIND),STORAGE_FLAGS(storage)) : 0);
}

/* 0548: return the previous stream after all output-side effects. */
/* SELECT_SYMBOL_STREAM: before the initialiser of static 'symbol' is emitted: switches
   output to the symbol's segment (STREAM_HOOK), word-aligns when the object is bigger
   than a byte and BCC_PACK_FLAG is set, and defines the symbol at the current position.
   Returns the previous segment for SET_STREAM to restore. */
unsigned int far pascal SELECT_SYMBOL_STREAM(register unsigned int symbol)
{
    unsigned int storage;
    register unsigned int previous;

    if(NO_ERRORS_YET) {
        storage=PREPARE_SYMBOL(symbol);
        previous=STREAM_HOOK((unsigned int)GET_SYMBOL_SEGMENT_HOOK(storage));
        if(TYPE_SIZE(SYM_W(symbol,SYM_TYPE))>1L && BCC_PACK_FLAG) ALIGN_OUTPUT_HOOK(2);
        DEFINE_SYMBOL_HERE_HOOK(storage);
    } else previous=0;
    return previous;
}

/* 05AC: set a stream while the returned previous stream is unconsumed. */
/* SET_STREAM: switches output to segment 'value' (STREAM_HOOK). */
void far pascal SET_STREAM(unsigned int value)
{
    if(NO_ERRORS_YET) STREAM_HOOK(value);
}

/* 05C1: emit exactly count zero bytes, using an unsigned WORD index. */
/* EMIT_ZERO_BYTES: emits 'count' zero bytes to the current output (as
   the existing comment says); cpp/CPPINIT.C uses it to fill uninitialised parts of data. */
void far pascal EMIT_ZERO_BYTES(unsigned int count)
{
    unsigned int index;

    if(NO_ERRORS_YET) {
        index=0;
        while(index<count) {
            BYTE_HOOK((unsigned char)0);
            ++index;
        }
    }
}

/* 05E2: emit the converted nonzero node, otherwise perform the real fallback. */
/* EMIT_CONST_INIT_VALUE: emits constant initialiser 'node' through EMIT_INITIALIZER_VALUE
   (INITDATA.C) to the current output. */
void far pascal EMIT_CONST_INIT_VALUE(unsigned int node)
{
    if(NO_ERRORS_YET && node) EMIT_INITIALIZER_VALUE_FAR(LOWER_EXPRESSION(node),0);
    else RESET_EXPR_POOL_ALT();
}

/* 060F: a true BYTE input with a rounded physical argument slot. */
/* EMIT_BYTE_IF_ENABLED: emits one byte to the current output. */
void far pascal EMIT_BYTE_IF_ENABLED(unsigned char code)
{
    if(NO_ERRORS_YET) BYTE_HOOK(code);
    else RESET_EXPR_POOL_ALT();
}

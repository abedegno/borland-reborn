/* input.c: from bcc20/src/lexer/INPUT.C: the input stack under the lexer.

   The lexer reads bytes from one buffer: INPUT_BUFFER holds the near address of a variable
   that holds the buffer's segment, INPUT_INDEX and INPUT_LIMIT are offsets in it, and
   INPUT_REFILL is called when INPUT_INDEX reaches INPUT_LIMIT.  What the buffer holds
   depends on the context on top of the stack (CONTEXT_PTR, a record in CONTEXT_SEG, CTX_*
   fields, CTX_PREV the outer one).  CTX_KIND is a DOS file handle for a source or include
   file (read 4096 bytes at a time into a buffer after the record; at its end the buffer
   becomes EOF_BUFFER_TEXT, a line end and the end-of-input byte 26), 202 for a macro
   expansion (the macro's text in POOL_E or POOL_F, by the parity of its offset, or an
   argument's text in POOL_A or TOKEN_POOL), or 201 for a string pushed back into the input.

   A macro's text is fed to the lexer a chunk at a time, each chunk ending at a marker byte
   (80h or above: a parameter, the # or ## operator, a no-expand mark), on which INPUT_REFILL
   then acts.  While a macro expands, its name's HLINK_MACRO is cleared so it cannot expand
   itself, and put back when its context is popped.  MACRO_EXPANSION_DEPTH counts open
   expansions; at 0 the argument pools are emptied.  Popped macro contexts are kept on
   FREE_MACRO_CONTEXT_LIST for reuse.  SEEK_ECHO_FILE, DUMP_SOURCE_LINES and their helpers
   read source lines again through the file handle to copy them into -S output.

   RETURN_MINUS_ONE_STUB of the original is left out: nothing calls it. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"

#define C(o, n) FAR_W(CONTEXT_SEG, (o), (n))
#define SEGMENT_OF(w) W(DSPTR(w))                 /* the segment in the variable at DS:w */
#define BUFFER_SEGMENT SEGMENT_OF(INPUT_BUFFER)
#define NEAR(p) FP_OFF(p)                          /* a global's near address */
/* globals other sources declare differently, as this file declares them */
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define MACRO_EXPANSION_DEPTH W(MACRO_EXPANSION_DEPTH_P)
#define MACRO_MARK_FC_PENDING B(MACRO_MARK_FC_PENDING_P)

/* pop the input stack: the outer context becomes current, its read position reloaded (the
   caller releases the popped record) */
void BCC_INPUT_POP(void)
{
    u16 cursor = CTX_W(CONTEXT_PTR, CTX_PREV);
    CONTEXT_PTR = cursor;
    INPUT_BUFFER = CTX_W(cursor, CTX_BUFFER_SEG_VAR);
    INPUT_INDEX = CTX_W(cursor, CTX_BUFFER_BASE) + CTX_W(cursor, CTX_READ_POS);
    INPUT_LIMIT = CTX_W(cursor, CTX_BUFFER_BASE) + CTX_W(cursor, CTX_LENGTH);
}

/* push context: save the read position in the old top, link the new record to it and make
   its buffer current */
void BCC_INPUT_PUSH(u16 context)
{
    if (CONTEXT_PTR != 0)
        CTX_W(CONTEXT_PTR, CTX_READ_POS) = INPUT_INDEX - CTX_W(CONTEXT_PTR, CTX_BUFFER_BASE);
    CTX_W(context, CTX_PREV) = CONTEXT_PTR;
    CONTEXT_PTR = context;
    INPUT_BUFFER = CTX_W(context, CTX_BUFFER_SEG_VAR);
    INPUT_INDEX = CTX_W(context, CTX_BUFFER_BASE) + CTX_W(context, CTX_READ_POS);
    INPUT_LIMIT = CTX_W(context, CTX_BUFFER_BASE) + CTX_W(context, CTX_LENGTH);
}

/* open a source file and push its context: 0 if it cannot be opened, else 1.  The record
   (1016h bytes: 22 bytes of context, then the 4096-byte buffer) saves the including file's
   name, line and conditional state for POP_INPUT_CONTEXT.  A line end is pushed in front of
   the text, so the first line is line 1 and a '#' on it starts a line.  The file gets its
   own serial node, which identifies it in token positions. */
u16 OPEN_SOURCE_FILE(farptr path)
{
    i16 handle = RTL_OPEN(path, 0);
    if (handle == -1)
        return 0;
    u16 context = POOL_ALLOC(CONTEXT_SEG_P, 0x1016);
    CTX_W(context, CTX_FILE_HANDLE) = (u16)handle;
    CTX_W(context, CTX_LENGTH) = 0;
    CTX_W(context, CTX_BUFFER_SEG_VAR) = NEAR(CONTEXT_SEG_P);
    CTX_W(context, CTX_BUFFER_BASE) = context + 22;
    CTX_W(context, CTX_READ_POS) = 0;
    CTX_W(context, CTX_SAVED_FILE_NAME) = CURRENT_FILE_NAME;
    CTX_W(context, CTX_SAVED_LINE) = CURRENT_LINE;
    CTX_W(context, CTX_SAVED_LINE_RECORD) = LINE_RECORD;
    BCC_INPUT_PUSH(context);
    CURRENT_FILE_CONTEXT = context;
    u16 name = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(path) + 1);
    CURRENT_FILE_NAME = name;
    STRING_COPY(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME), path);
    CURRENT_LINE = 0;
    BCC_INPUT_STRING(STR_NEWLINE_INPUT_P);
    CTX_W(context, CTX_FILE_POS) = 0;
    CTX_W(context, CTX_SAVED_SERIAL_NODE) = LEX_FILE_SERIAL_NODE;
    LEX_FILE_SERIAL_NODE = NEW_SERIAL_NODE(CURRENT_FILE_NAME);
    return 1;
}

/* pop the current context: 1 if reading can go on, 0 at the end of the main file (or with
   an empty stack).  String and macro contexts are just popped.  For a file: an #if left open
   in it is reported unless quiet, the file is closed and the including file's name, line
   and serial node come back; back in the main file, REPLAY_PREAMBLE runs (precompiled
   headers).  quiet is set when unwinding after a fatal error. */
u16 POP_INPUT_CONTEXT(u16 quiet)
{
    if (CONTEXT_PTR == 0)
        return 0;
    if (C(CONTEXT_PTR, 0) == 201 || C(CONTEXT_PTR, 0) == 202) {
        CONTEXT_SEG_USED = 0;
        CONTEXT_SEG_UNIT = CONTEXT_PTR;
        BCC_INPUT_POP();
        return 1;
    }
    u16 context = CONTEXT_PTR;
    if (C(context, 20) != LINE_RECORD && !quiet)
        REPORT_ERROR(MSG_UNEXPECTED_END_FILE_42, FAR_W(LINE_POOL, LINE_RECORD, -2));
    LINE_RECORD = C(context, 20);
    RTL_CLOSE((i16)C(CONTEXT_PTR, 0));
    if (C(CONTEXT_PTR, 10) == 0)
        return 0;
    CURRENT_LINE = C(context, 14);
    LEX_FILE_SERIAL_NODE = CLONE_NODE_NEW_SERIAL(C(context, 16));
    LOGICAL_LINE = CURRENT_LINE;
    CURRENT_FILE_NAME = C(context, 12);
    CONTEXT_SEG_USED = 0;
    CONTEXT_SEG_UNIT = CONTEXT_PTR;
    BCC_INPUT_POP();
    CURRENT_FILE_CONTEXT = CONTEXT_PTR;
    FREE_MACRO_CONTEXT_LIST = 0;
    if (C(CONTEXT_PTR, 10) == 0 && !quiet)
        REPLAY_PREAMBLE();
    return 1;
}

/* a macro context from the free list, or a new one */
static u16 macro_context(void)
{
    u16 context;
    if (FREE_MACRO_CONTEXT_LIST) {
        context = FREE_MACRO_CONTEXT_LIST;
        FREE_MACRO_CONTEXT_LIST = C(context, 10);
    } else {
        context = POOL_ALLOC(CONTEXT_SEG_P, 18);
        C(context, 0) = 202;
    }
    return context;
}

/* bytes up to the first marker (80h or above) or the end */
static u16 chunk_length(farptr cursor)
{
    u16 length = 0;
    while (B(cursor) != 0 && (B(cursor) & 0x80) == 0) {
        cursor = fp_add(cursor, 1);
        ++length;
    }
    return length;
}

/* push a macro expansion: macro is the name record (HASH_CHAIN_LINK_SEG) whose definition
   is disabled meanwhile, or 0 for anonymous text; arguments the POOL_A list of collected
   arguments, or 0; token the offset of the macro text (odd in POOL_F, even in POOL_E), whose
   first byte, the parameter count, is skipped.  The first chunk runs to the first marker. */
void PUSH_MACRO_EXPANSION(u16 macro, u16 arguments, u16 token)
{
    if (macro)
        HLINK_W(macro, HLINK_MACRO) = 0;
    u16 context = macro_context();
    C(context, 4) = 0;
    C(context, 6) = (token & 1) ? NEAR(POOL_F_P) : NEAR(POOL_E_P);
    C(context, 2) = chunk_length(MK_FP((token & 1) ? POOL_F : POOL_E, token + 1));
    C(context, 14) = macro;
    C(context, 16) = token;
    C(context, 12) = arguments;
    C(context, 8) = token + 1;
    BCC_INPUT_PUSH(context);
}

/* the byte of macro text at offset (POOL_F if odd, POOL_E if even) */
u8 BCC_INPUT_BYTE(u16 offset)
{
    return B(MK_FP((offset & 1) ? POOL_F : POOL_E, offset));
}

/* push an expansion context over argument text in POOL_A */
void PUSH_ARGUMENT_TEXT(u16 offset)
{
    u16 context = macro_context();
    CTX_W(context, CTX_READ_POS) = 0;
    CTX_W(context, CTX_LENGTH) = chunk_length(MK_FP(POOL_A, offset));
    CTX_W(context, CTX_MACRO_HLINK) = 0;
    CTX_W(context, CTX_MACRO_DEF) = 0;
    CTX_W(context, CTX_MACRO_ARGS) = 0;
    CTX_W(context, CTX_BUFFER_SEG_VAR) = NEAR(POOL_A_P);
    CTX_W(context, CTX_BUFFER_BASE) = offset;
    ++MACRO_EXPANSION_DEPTH;
    BCC_INPUT_PUSH(context);
}

/* push an expansion context over an argument's value in TOKEN_POOL (up to a marker, the
   end, or an end-of-input byte) */
void PUSH_ARGUMENT_TOKENS(u16 offset)
{
    u16 context = macro_context();
    CTX_W(context, CTX_READ_POS) = 0;
    farptr cursor = MK_FP(TOKEN_POOL, offset);
    u16 length = 0;
    while (B(cursor) != 0 && !(B(cursor) & 0x80) && B(cursor) != 26) {
        cursor = fp_add(cursor, 1);
        ++length;
    }
    CTX_W(context, CTX_LENGTH) = length;
    CTX_W(context, CTX_MACRO_HLINK) = 0;
    CTX_W(context, CTX_MACRO_DEF) = 0;
    CTX_W(context, CTX_MACRO_ARGS) = 0;
    CTX_W(context, CTX_BUFFER_SEG_VAR) = NEAR(TOKEN_POOL_P);
    CTX_W(context, CTX_BUFFER_BASE) = offset;
    ++MACRO_EXPANSION_DEPTH;
    BCC_INPUT_PUSH(context);
}

/* push a string as input (kind 201), read next: the line end before each file, the digits
   of __LINE__, the quote that starts a stringized argument.  Its segment is kept in
   STRING_DATA, so only one far string can be pushed at a time. */
void BCC_INPUT_STRING(farptr text)
{
    STRING_DATA = FP_SEG(text);
    u16 node = POOL_ALLOC(CONTEXT_SEG_P, 12);
    CTX_W(node, CTX_KIND) = 201;
    CTX_W(node, CTX_BUFFER_SEG_VAR) = NEAR(STRING_DATA_P);
    CTX_W(node, CTX_BUFFER_BASE) = FP_OFF(text);
    CTX_W(node, CTX_READ_POS) = 0;
    CTX_W(node, CTX_LENGTH) = STRING_LENGTH(text);
    BCC_INPUT_PUSH(node);
}

/* as BCC_INPUT_STRING, the string given as the near address of a variable holding its
   segment (as pools are) and an offset */
void BCC_INPUT_STRING_PTR(u16 segment_word, u16 offset)
{
    u16 context = POOL_ALLOC(CONTEXT_SEG_P, 12);
    CTX_W(context, CTX_KIND) = 201;
    CTX_W(context, CTX_BUFFER_SEG_VAR) = segment_word;
    CTX_W(context, CTX_BUFFER_BASE) = offset;
    CTX_W(context, CTX_READ_POS) = 0;
    CTX_W(context, CTX_LENGTH) = STRING_LENGTH(MK_FP(SEGMENT_OF(segment_word), offset));
    BCC_INPUT_PUSH(context);
}

/* the offset in POOL_A of macro argument number (value & 7Fh) of the macro context */
static u16 find_argument(u16 context, i16 value)
{
    u16 argument = C(context, 12);
    value &= 0x7F;
    while (value > 1) {
        argument += 2;
        argument += STRING_LENGTH(MK_FP(POOL_A, argument)) + 1;
        --value;
    }
    return argument;
}

/* called when INPUT_INDEX has reached INPUT_LIMIT: the next input byte (consumed), after
   loading more input.  A file context reads the next 4096 bytes; a macro context acts on
   the marker byte that ended the chunk; a finished string or macro context is popped and
   reading goes on in the outer one, until some byte is available. */
u8 INPUT_REFILL(void)
{
    i16 value;
    do {
        switch (C(CONTEXT_PTR, 0)) {
        default:
            if (SEGMENT_OF(C(CONTEXT_PTR, 6)) == DGROUP)
                value = 0;
            else
                value = RTL_READ((i16)C(CONTEXT_PTR, 0),
                                 MK_FP(SEGMENT_OF(C(CONTEXT_PTR, 6)), C(CONTEXT_PTR, 8)), 4096);
            if (value > 0) {
                C(CONTEXT_PTR, 18) += C(CONTEXT_PTR, 2);
                C(CONTEXT_PTR, 2) = (u16)value;
                C(CONTEXT_PTR, 4) = 1;
                INPUT_INDEX = C(CONTEXT_PTR, 8);
                INPUT_LIMIT = C(CONTEXT_PTR, 8) + (u16)value;
                return AT_B(BUFFER_SEGMENT, INPUT_INDEX++);
            }
            STRING_DATA = DGROUP;
            C(CONTEXT_PTR, 6) = NEAR(STRING_DATA_P);
            C(CONTEXT_PTR, 4) = 1;
            C(CONTEXT_PTR, 2) = 2;
            C(CONTEXT_PTR, 8) = NEAR(EOF_BUFFER_TEXT_P);
            INPUT_BUFFER = NEAR(STRING_DATA_P);
            INPUT_INDEX = NEAR(EOF_BUFFER_TEXT_P) + 1;
            INPUT_LIMIT = NEAR(EOF_BUFFER_TEXT_P) + 2;
            return 10;

        /* a macro chunk is used up: the byte at INPUT_LIMIT is the marker that ended it; 0
           ends the whole text, which pops the context */
        case 202: {
            u16 context = CONTEXT_PTR;
            if ((value = AT_B(BUFFER_SEGMENT, INPUT_LIMIT)) == 0) {
                if (C(context, 14))
                    HLINK_W(C(context, 14), HLINK_MACRO) = C(context, 16);
                --MACRO_EXPANSION_DEPTH;
                if (MACRO_EXPANSION_DEPTH == 0) {
                    POOL_A_USED = 0;
                    POOL_A_UNIT = 1;
                    TOKEN_POOL_USED = 0;
                    TOKEN_POOL_UNIT = 1;
                    FREE_MACRO_CONTEXT_LIST = 0;
                    CONTEXT_SEG_USED = 0;
                    CONTEXT_SEG_UNIT = CONTEXT_PTR;
                    BCC_INPUT_POP();
                } else {
                    BCC_INPUT_POP();
                    C(context, 10) = FREE_MACRO_CONTEXT_LIST;
                    FREE_MACRO_CONTEXT_LIST = context;
                }
                break;
            }
            /* the marker: 254 is ## (the argument after it is used unexpanded), 253 is #
               (the argument becomes a string: PENDING_STRING_TEXT points at its raw text
               and a '"' is pushed to start a string literal), 252 a no-expand mark for the
               next name, 255 a literal byte, other 80h+n a parameter: the expanded argument
               text, or the raw text if ## follows */
            u16 cursor = INPUT_LIMIT + 1;
            switch (value) {
            case 254:
                MACRO_MARK_FE_SEEN = 1;
                value = AT_B(BUFFER_SEGMENT, cursor);
                if ((value & 0x80) && value < 251) {
                    ++cursor;
                    PUSH_ARGUMENT_TOKENS(FAR_W(POOL_A, find_argument(context, value), MARG_TEXT_OFFSET));
                }
                value = 0;
                break;
            case 253:
                value = AT_B(BUFFER_SEGMENT, cursor++);
                if (!(value & 0x80) || value >= 251) {
                    REPORT_ERROR(MSG_OPERATOR_NOT_FOLLOWED);
                    --cursor;
                    value = 0;
                    break;
                }
                PENDING_STRING_TEXT = FAR_W(POOL_A, find_argument(context, value), MARG_TEXT_OFFSET);
                BCC_INPUT_STRING(STR_DOUBLE_QUOTE_P);
                value = 0;
                break;
            case 252:
                value = 0;
                MACRO_MARK_FC_PENDING = 1;
                break;
            case 255:
                value = AT_B(BUFFER_SEGMENT, cursor++);
                break;
            case 26:
                if (C(context, 16) == 0)
                    value = 0;
                break;
            case 251:
                break;
            default: {
                u16 argument = find_argument(context, value);
                if (AT_B(SEGMENT_OF(C(context, 6)), cursor) == 254)
                    PUSH_ARGUMENT_TOKENS(FAR_W(POOL_A, argument, MARG_TEXT_OFFSET));
                else
                    PUSH_ARGUMENT_TEXT(argument + 2);
                value = 0;
                break;
            }
            }
            /* the next chunk, up to the next marker, the end or an end-of-input byte */
            C(context, 8) = cursor;
            if (context == CONTEXT_PTR)
                INPUT_INDEX = cursor;
            for (;;) {
                u8 b = AT_B(SEGMENT_OF(C(context, 6)), cursor);
                if (b == 0 || (b & 0x80) || b == 26)
                    break;
                ++cursor;
            }
            C(context, 4) = 0;
            C(context, 2) = cursor - C(context, 8);
            if (context == CONTEXT_PTR)
                INPUT_LIMIT = cursor;
            if (value != 0)
                return (u8)value;
            break;
        }
        case 201:
            CONTEXT_SEG_USED = 0;
            CONTEXT_SEG_UNIT = CONTEXT_PTR;
            BCC_INPUT_POP();
            break;
        }
    } while (INPUT_INDEX >= INPUT_LIMIT);
    return AT_B(BUFFER_SEGMENT, INPUT_INDEX++);
}

static i16 next_input(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : AT_B(BUFFER_SEGMENT, INPUT_INDEX++);
}

/* copy a quoted string or character constant, its opening quote read, through emit (a far
   code pointer: void emit(signed char)), quotes included and escapes left as written.  With
   PENDING_STRING_TEXT set the text comes from TOKEN_POOL instead (a stringized macro
   argument: quotes and backslashes in it are escaped).  1 when the closing quote was found,
   0 at a line end or end of input (an "unterminated string" error if diagnose is set). */
i16 COPY_STRING_LITERAL(i8 quote, farptr emit, u16 diagnose)
{
    void (*out)(i8) = (void (*)(i8))code_function(emit);
    out(quote);
    if (PENDING_STRING_TEXT) {
        for (u16 cursor = PENDING_STRING_TEXT; AT_B(TOKEN_POOL, cursor) != 0; ++cursor) {
            u8 b = AT_B(TOKEN_POOL, cursor);
            if (b == 26)
                break;
            if (b == '"' || b == '\\')
                out('\\');
            else if (b == 252 || b == 251)
                continue;
            else if (b == 255)
                ++cursor;
            out((i8)AT_B(TOKEN_POOL, cursor));
        }
        out(quote);
        PENDING_STRING_TEXT = 0;
        return 1;
    }
    i16 value;
    while ((value = next_input()) != 26 && value != 10 && value != 13) {
        if (value == '\\') {
            value = next_input();
            if (value != 13 && value != 10)
                out('\\');
            else {
                LEX_NEWLINE((i8)value);
                continue;
            }
        } else if (value == quote) {
            out((i8)value);
            return 1;
        }
        out((i8)value);
    }
    if (diagnose) {
        REPORT_ERROR(MSG_UNTERMINATED_STRING);
        out(quote);
    }
    --INPUT_INDEX;
    return 0;
}

/* the byte position in the current file: the buffer's file position plus the read
   position (16 bits, zero-extended) */
u32 INPUT_POSITION(void)
{
    u16 pos = CTX_W(CURRENT_FILE_CONTEXT, CTX_FILE_POS) +
              (CONTEXT_PTR == CURRENT_FILE_CONTEXT ? INPUT_INDEX - C(CURRENT_FILE_CONTEXT, 8)
                                                   : C(CURRENT_FILE_CONTEXT, 4));
    return pos;
}

/* prepare to echo source lines from line: if the current file is the one with serial node
   source, its handle (INPUT_ACTIVE) is moved to position, its old position kept in
   INPUT_FILE_POS; otherwise echoing is off (INPUT_ACTIVE 0) */
void SEEK_ECHO_FILE(u16 line, u16 source, i32 position)
{
    ECHO_NEXT_LINE = line - 1;
    if (LEX_FILE_SERIAL_NODE != source) {
        INPUT_ACTIVE = 0;
        return;
    }
    INPUT_ACTIVE = W(MK_FP(CONTEXT_SEG, CURRENT_FILE_CONTEXT));
    if (INPUT_ACTIVE >= 200 && INPUT_ACTIVE <= 203) {
        INPUT_ACTIVE = 0;
        return;
    }
    INPUT_FILE_POS = RTL_LSEEK((i16)INPUT_ACTIVE, 0, 1);
    RTL_LSEEK((i16)INPUT_ACTIVE, position, 0);
    INPUT_UNGET_FLAG = 0;
}

/* one byte for the echo, or one put back by INPUT_UNGET; 26 at the end of the file */
i16 BCC_INPUT_GET(void)
{
    if (INPUT_UNGET_FLAG) {
        INPUT_UNGET_FLAG = 0;
        return (i16)INPUT_UNGET_CHAR;
    }
    u16 mark = scratch_mark();
    farptr value = scratch_alloc(2);
    i16 result = RTL_READ((i16)INPUT_ACTIVE, value, 1) == 1 ? (i16)(W(value) & 255) : 26;
    scratch_release(mark);
    return result;
}

void INPUT_UNGET(i16 c)
{
    INPUT_UNGET_FLAG = 1;
    INPUT_UNGET_CHAR = (u16)c;
}

/* copy source lines up to, not including, line limit into the output, each indented as a
   comment and cut to 128 characters, with a blank comment line before and after */
void DUMP_SOURCE_LINES(u16 limit)
{
    if (INPUT_ACTIVE == 0 || ECHO_NEXT_LINE >= limit)
        return;
    BCC_OUTPUT_STRING(STR_BLANK_COMMENT_LINE_P);
    while (ECHO_NEXT_LINE < limit) {
        i16 count = 0;
        BCC_OUTPUT_STRING(STR_COMMENT_INDENT_P);
        for (;;) {
            i16 value = BCC_INPUT_GET();
            if (value == 13) {
                value = BCC_INPUT_GET();
                if (value != 10)
                    INPUT_UNGET(value);
                break;
            } else if (value == 10) {
                value = BCC_INPUT_GET();
                if (value != 13)
                    INPUT_UNGET(value);
                break;
            } else if (value == 26) {
                ECHO_NEXT_LINE = limit - 1;
                break;
            } else if (count < 128) {
                OUTPUT_CHAR((i8)value);
                count++;
            }
        }
        BCC_OUTPUT_STRING(STR_CRLF_ECHO_P);
        ECHO_NEXT_LINE++;
    }
    BCC_OUTPUT_STRING(STR_BLANK_COMMENT_LINE_P);
}

/* put the file handle back where the lexer left it */
void RESTORE_ECHO_POSITION(void)
{
    if (INPUT_ACTIVE)
        RTL_LSEEK((i16)INPUT_ACTIVE, (i32)INPUT_FILE_POS, 0);
}

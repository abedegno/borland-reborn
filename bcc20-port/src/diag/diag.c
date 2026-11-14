/* diag.c: from bcc20/src/diag/DIAG.C: the parser's front door to the message printers.
   Parser code reports through REPORT_DIAGNOSTIC (position of the current token),
   REPORT_DIAGNOSTIC_LINE (line only), REPORT_NAME_DIAGNOSTIC (a name as the %s argument) or
   REPORT_TOKEN_DIAGNOSTIC / REPORT_CURRENT_TOKEN (the spelling of a token as the argument).
   All end in REPORT_DIAGNOSTIC_AT, which picks the printer from the message number: below
   10 fatal (REPORT_FATAL), below 14Dh an error (REPORT_ERROR), else a warning
   (REPORT_WARNING; see messages for the numbering).  For the time of the call it sets
   LOGICAL_LINE to the given line and FUNCTION_NAME_TEXT to the name of the function being
   compiled (BCC_TREE_SPECIAL), which the printer adds as "in function ...".
   Message arguments that are names are copied into DIAG_NAME_BUFFER, a 511-byte text buffer
   with a count in front; its text is the same memory as BCC_DEBUG_NAME.  Each copy is
   appended after the previous one, so a message can take several names, and
   REPORT_DIAGNOSTIC_AT empties the buffer after printing.  typespel.c appends to the same
   buffer.
   Also here: the error-recovery skips of the statement and declaration parsers,
   SKIP_TO_SYNC_TOKEN and SKIP_BRACE_GROUP. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "fields.h"
#include "protos.h"
#include "calls.h"
#include "variadic.h"
#include "token.h"

#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)      /* char far * */
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define DIAG_NAME_COUNT W(DIAG_NAME_BUFFER_P)
/* a token record (CURRENT_TOKEN_RECORD and the token stream's): kind, a flag byte, three
   location words (file, line, column), the name */
#define TOKEN_KIND(t) W(t)
#define TOKEN_LINE_OF(t) W(fp_add((t), 5))
#define TOKEN_COLUMN_OF(t) W(fp_add((t), 7))
#define TOKEN_NAME_OF(t) W(fp_add((t), 9))

/* appends one byte to the name buffer at buffer; bytes beyond 511 are dropped */
void APPEND_NAME_BYTE(u8 value, farptr buffer)
{
    if (W(buffer) < 511) {
        B(fp_add(buffer, 2 + W(buffer))) = value;
        W(buffer)++;
    }
}

/* appends the 0-terminated text (without its 0) to buffer */
void APPEND_NAME_TEXT(farptr text, farptr buffer)
{
    for (;;) {
        u8 value = B(text);
        text = fp_add(text, 1);
        if (value == 0)
            break;
        APPEND_NAME_BYTE(value, buffer);
    }
}

/* reports message code with up to two printf arguments first and second (each passed as a
   long, so either a far string pointer or a long number fits) at source line line; column
   is not used.  Any error or fatal message clears NO_ERRORS_YET, probably so no more code is
   generated for the file.  While IN_ERROR_RECOVERY is set (by SKIP_BRACE_GROUP and by the
   expression parser) only fatal messages are printed.  Warnings are also dropped while
   SUPPRESS_WARNINGS_DEPTH is nonzero.  In C++ (CPP_MODE) the function name is spelled with
   its class and parameters (FORMAT_SYMBOL); not while STARTUP_BODY_ACTIVE is set */
void REPORT_DIAGNOSTIC_AT(i16 code, i32 first, i32 second, u16 line, u16 column)
{
    (void)column;
    u16 saved_line = LOGICAL_LINE;
    farptr saved_name = FUNCTION_NAME_TEXT;
    if (code < 0x14D)
        NO_ERRORS_YET = 0;
    if (!IN_ERROR_RECOVERY || code < 10) {
        LOGICAL_LINE = line;
        if (BCC_TREE_SPECIAL && !STARTUP_BODY_ACTIVE)
            FUNCTION_NAME_TEXT = CPP_MODE ? FORMAT_SYMBOL(BCC_TREE_SPECIAL) : SYMBOL_NAME_TEXT(BCC_TREE_SPECIAL);
        else
            FUNCTION_NAME_TEXT = 0;
        if (code < 10)
            REPORT_FATAL(code, (long)first, (long)second);
        else if (code < 0x14D)
            REPORT_ERROR(code, (long)first, (long)second);
        else if (!SUPPRESS_WARNINGS_DEPTH)
            REPORT_WARNING((u16)code, (long)first, (long)second);
        LOGICAL_LINE = saved_line;
        FUNCTION_NAME_TEXT = saved_name;
    }
    DIAG_NAME_COUNT = 0;
}

/* at the current token's line and column */
void REPORT_DIAGNOSTIC(i16 code, i32 first, i32 second)
{
    REPORT_DIAGNOSTIC_AT(code, first, second, TOKEN_LINE_OF(CURRENT_TOKEN_RECORD_P), TOKEN_COLUMN_OF(CURRENT_TOKEN_RECORD_P));
}

/* the same with column 0 */
void REPORT_DIAGNOSTIC_LINE(i16 code, i32 first, i32 second)
{
    REPORT_DIAGNOSTIC_AT(code, first, second, TOKEN_LINE_OF(CURRENT_TOKEN_RECORD_P), 0);
}

/* name: a NAME_POOL record; its text becomes the message's %s argument */
void REPORT_NAME_DIAGNOSTIC(i16 code, u16 name)
{
    i32 text = (i32)NAME_TEXT_COPY(name);
    REPORT_DIAGNOSTIC_AT(code, text, 0, TOKEN_LINE_OF(CURRENT_TOKEN_RECORD_P), TOKEN_COLUMN_OF(CURRENT_TOKEN_RECORD_P));
}

/* reports code at token's position; the argument is the identifier's name for an
   identifier token (kind 31h), else the token's text from TOKEN_NAMES */
void REPORT_TOKEN_DIAGNOSTIC(farptr token, i16 code)
{
    i32 text = (i32)NAME_TEXT_COPY(TOKEN_KIND(token) == 0x31 ? TOKEN_NAME_OF(token) : TOKEN_NAMES_AT(TOKEN_KIND(token)));
    REPORT_DIAGNOSTIC_AT(code, text, 0, TOKEN_LINE_OF(token), TOKEN_COLUMN_OF(token));
}

void REPORT_CURRENT_TOKEN(i16 code)
{
    REPORT_TOKEN_DIAGNOSTIC(CURRENT_TOKEN_RECORD_P, code);
}

/* panic-mode recovery: skips tokens until token or any synchronizing token (TYPE_FLAGS bit
   200h, probably ';', '}' and the like, and the end of input) */
void SKIP_TO_SYNC_TOKEN(u16 token)
{
    while (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x200) && CURRENT_TOKEN != token)
        ADVANCE_TOKEN();
}

/* skips a function body or similar after an error: first tokens with TYPE_FLAGS bit 1000h,
   then, if a '{' follows, everything up to its matching '}' (or the end of input, token
   0).  Sets IN_ERROR_RECOVERY, which stops REPORT_DIAGNOSTIC_AT from printing non-fatal
   messages from then on; it is cleared elsewhere (INIT_PARSER, inlinexp.c) */
void SKIP_BRACE_GROUP(void)
{
    i16 nesting = 0;
    IN_ERROR_RECOVERY = 1;
    while (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x1000)
        ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_LBRACE)
        do {
            if (CURRENT_TOKEN == TOK_LBRACE)
                ++nesting;
            if (CURRENT_TOKEN == TOK_RBRACE)
                --nesting;
            ADVANCE_TOKEN();
        } while (nesting && CURRENT_TOKEN != 0);
}

/* copies the text of NAME_POOL record name into DIAG_NAME_BUFFER and returns a far pointer
   to the copy (valid until the next diagnostic); name 0 gives "".  A name record holds the
   text's offset and a near pointer to the word that holds its segment */
farptr NAME_TEXT_COPY(u16 name)
{
    if (!name)
        return C25_EMPTY_NAME_P;
    farptr result = fp_add(BCC_DEBUG_NAME_P, DIAG_NAME_COUNT);
    farptr text = MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
    APPEND_NAME_TEXT(text, DIAG_NAME_BUFFER_P);
    APPEND_NAME_BYTE(0, DIAG_NAME_BUFFER_P);
    return result;
}

/* the name of a symbol (SYM_NAME, offset 2) as text, or "" if it has none */
farptr SYMBOL_NAME_TEXT(u16 symbol)
{
    return SYM_W(symbol, 2) == 0 ? C25_EMPTY_NAME_P : NAME_TEXT_COPY(SYM_W(symbol, 2));
}

/* the name of a class member (MEMB_NAME, offset 2) as text, or "" if it has none */
farptr MEMBER_NAME_TEXT(u16 member)
{
    return MEMBER_W(member, 2) == 0 ? C25_EMPTY_NAME_P : NAME_TEXT_COPY(MEMBER_W(member, 2));
}

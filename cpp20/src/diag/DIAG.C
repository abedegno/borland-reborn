/* target: DIAG */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module DIAG (image 0x4DA1..0x5071, frame 04DAh): source taken from the
   BCC.EXE reconstruction (bcc20/src/diag/DIAG.C), all 13 functions in
   BCC's order, with one CPP.EXE edit (REPORT_DIAGNOSTIC_AT, marked).
   One file: the two near statics APPEND_NAME_BYTE/APPEND_NAME_TEXT (image 0x4DA1,
   0x4DC1) are reached by plain near calls from NAME_TEXT_COPY, and the far functions
   call each other with `push cs; call near`. */
/* Role: diagnostic helpers (REPORT_DIAGNOSTIC_*, SKIP_TO_SYNC_TOKEN). Entry points:
   REPORT_DIAGNOSTIC_AT, REPORT_DIAGNOSTIC, REPORT_DIAGNOSTIC_LINE, REPORT_NAME_DIAGNOSTIC,
   REPORT_TOKEN_DIAGNOSTIC, REPORT_CURRENT_TOKEN, SKIP_TO_SYNC_TOKEN, SKIP_BRACE_GROUP,
   NAME_TEXT_COPY, SYMBOL_NAME_TEXT, MEMBER_NAME_TEXT. Several of these (the skips, the
   symbol and member names) are kept from BCC although CPP.EXE has no declaration parser;
   whether anything in CPP.EXE still calls them is not checked here. */
#include <dos.h>
#include "DIAG.H"
#include "TOKEN.H"
#include "POOL.H"
/* Overview: the parser's front door to the message printers. Parser code reports through
   REPORT_DIAGNOSTIC (position of the current token), REPORT_DIAGNOSTIC_LINE (line only),
   REPORT_NAME_DIAGNOSTIC (a name as the %s argument) or REPORT_TOKEN_DIAGNOSTIC /
   REPORT_CURRENT_TOKEN (the spelling of a token as the argument). All end in
   REPORT_DIAGNOSTIC_AT, which picks the printer from the message number: below 10 fatal
   (REPORT_FATAL), below 0x14D an error (REPORT_ERROR), else a warning (REPORT_WARNING;
   see MSG.H for the numbering). For the time of the call it sets LOGICAL_LINE to
   the given line. (BCC also set FUNCTION_NAME_TEXT to the name of the function being
   compiled, which the printer adds as "in function ..."; CPP.EXE does not.)
   Message arguments that are names are copied into DIAG_NAME_BUFFER, a 511-byte text
   buffer with a count in front; its text is the same memory as BCC_DEBUG_NAME. Each
   copy is appended after the previous one, so a message can take several names, and
   REPORT_DIAGNOSTIC_AT empties the buffer after printing.
   The file also holds BCC's error-recovery skips for its statement and declaration
   parsers: SKIP_TO_SYNC_TOKEN and SKIP_BRACE_GROUP. */
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define M(n,o) AT_W(MEMBER_SEGMENT,(unsigned int)(n)+(o))
#define NAME(n) (*(struct C25Name far *)MK_FP(NAME_POOL_SEG,(n)))

/* Appends one byte to buffer; bytes beyond 511 are dropped. */
static void near pascal APPEND_NAME_BYTE(unsigned char value,struct C25Buffer far *buffer)
{
    if(buffer->count<511)
        buffer->text[buffer->count++]=value;
}
/* Appends the 0-terminated text (without its 0) to buffer. */
static void near pascal APPEND_NAME_TEXT(char far *text,struct C25Buffer far *buffer)
{
    unsigned char value;
    while((value=*text++)!=0)
        APPEND_NAME_BYTE(value,buffer);
}

/* Reports message code with up to two printf arguments first and second (each passed as
   a long so that either a far string pointer or a long number fits) at source line line.
   column is not used. Any error or fatal message clears NO_ERRORS_YET (in BCC probably
   so no more code is generated for the file). While IN_ERROR_RECOVERY is set (by SKIP_BRACE_GROUP and
   by the expression parser OPPREC.C, probably while tokens are skipped or parsed a
   second time) only fatal messages are printed. Warnings are also
   dropped while SUPPRESS_WARNINGS_DEPTH is nonzero. */
void far pascal REPORT_DIAGNOSTIC_AT(register int code,long first,long second,
                       unsigned int line,unsigned int column)
{
    unsigned int saved_line;
    char far *saved_name;
    saved_line=LOGICAL_LINE;
    saved_name=FUNCTION_NAME_TEXT;
    if(code<0x14D)
        NO_ERRORS_YET=0;
    if(!IN_ERROR_RECOVERY || code<10) {
        LOGICAL_LINE=line;
        /* CPP.EXE edit: no "in function" name. BCC sets FUNCTION_NAME_TEXT here from
           BCC_TREE_SPECIAL (FORMAT_SYMBOL or SYMBOL_NAME_TEXT); CPP.EXE goes from the
           LOGICAL_LINE store straight to the code<10 test (CPP 04DA:0084), but still saves
           and restores FUNCTION_NAME_TEXT around the call. */
        if(code<10)
            REPORT_FATAL(code,first,second);
        else if(code<0x14D)
            REPORT_ERROR(code,first,second);
        else if(!SUPPRESS_WARNINGS_DEPTH)
            REPORT_WARNING(code,first,second);
        LOGICAL_LINE=saved_line;
        FUNCTION_NAME_TEXT=saved_name;
    }
    DIAG_NAME_BUFFER.count=0;
}

/* Reports code at the current token's line and column. */
void far pascal REPORT_DIAGNOSTIC(int code,long first,long second)
{
    REPORT_DIAGNOSTIC_AT(code,first,second,CURRENT_TOKEN_RECORD.location[1],CURRENT_TOKEN_RECORD.location[2]);
}
/* As REPORT_DIAGNOSTIC with column 0. */
void far pascal REPORT_DIAGNOSTIC_LINE(int code,long first,long second)
{
    REPORT_DIAGNOSTIC_AT(code,first,second,CURRENT_TOKEN_RECORD.location[1],0);
}
/* name: a NAME_POOL record; its text becomes the message's %s argument. */
void far pascal REPORT_NAME_DIAGNOSTIC(int code,unsigned int name)
{
    REPORT_DIAGNOSTIC_AT(code,(long)NAME_TEXT_COPY(name),0L,CURRENT_TOKEN_RECORD.location[1],CURRENT_TOKEN_RECORD.location[2]);
}
/* Reports code at token's position; the argument is the identifier's name for an
   identifier token (kind 0x31), else the token's text from TOKEN_NAMES. */
void far pascal REPORT_TOKEN_DIAGNOSTIC(struct C25Token far *token,int code)
{
    REPORT_DIAGNOSTIC_AT(code,(long)NAME_TEXT_COPY(token->kind==0x31?token->name:TOKEN_NAMES[token->kind]),
        0L,token->location[1],token->location[2]);
}
void far pascal REPORT_CURRENT_TOKEN(int code)
{
    REPORT_TOKEN_DIAGNOSTIC(&CURRENT_TOKEN_RECORD,code);
}
/* Panic-mode recovery: skips tokens until token or any synchronizing token (TYPE_FLAGS
   bit 0x200, probably ';', '}' and the like, and end of input). */
void far pascal SKIP_TO_SYNC_TOKEN(unsigned int token)
{
    while(!(TYPE_FLAGS[CURRENT_TOKEN]&0x200) && CURRENT_TOKEN!=token)
        ADVANCE_TOKEN();
}
/* Skips a function body or similar after an error: first tokens with TYPE_FLAGS bit
   0x1000, then, if a '{' follows, everything up to its matching '}' (or end of input,
   token 0). Sets IN_ERROR_RECOVERY, which stops REPORT_DIAGNOSTIC_AT from printing non-fatal
   messages from then on; it is cleared elsewhere (INIT_PARSER). */
void far pascal SKIP_BRACE_GROUP(void)
{
    register int nesting;
    nesting=0;
    IN_ERROR_RECOVERY=1;
    while(TYPE_FLAGS[CURRENT_TOKEN]&0x1000)
        ADVANCE_TOKEN();
    if(CURRENT_TOKEN==TOK_LBRACE) {
        do {
            if(CURRENT_TOKEN==TOK_LBRACE)
                ++nesting;
            if(CURRENT_TOKEN==TOK_RBRACE)
                --nesting;
            ADVANCE_TOKEN();
        } while(nesting && CURRENT_TOKEN!=0);
    }
}
/* Copies the text of NAME_POOL record name into DIAG_NAME_BUFFER and returns a far
   pointer to the copy (valid until the next diagnostic). name 0 gives "". A name record
   holds the text's offset and a near pointer to the word that holds its segment. */
char far * far pascal NAME_TEXT_COPY(register unsigned int name)
{
    char far *result;
    char far *text;
    if(!name)
        return C25_EMPTY_NAME;
    result=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    text=MK_FP(*NAME(name).segment,NAME(name).offset);
    APPEND_NAME_TEXT(text,&DIAG_NAME_BUFFER);
    APPEND_NAME_BYTE(0,&DIAG_NAME_BUFFER);
    return result;
}
/* The name of a symbol (SYM_NAME, offset 2) as text, or "" if it has none. */
char far * far pascal SYMBOL_NAME_TEXT(register unsigned int symbol)
{
    return S(symbol,2)==0?C25_EMPTY_NAME:NAME_TEXT_COPY(S(symbol,2));
}
/* The name of a class member (MEMB_NAME, offset 2) as text, or "" if it has none. */
char far * far pascal MEMBER_NAME_TEXT(register unsigned int member)
{
    return M(member,2)==0?C25_EMPTY_NAME:NAME_TEXT_COPY(M(member,2));
}

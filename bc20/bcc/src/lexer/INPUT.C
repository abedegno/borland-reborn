/* target: ovr107_C133UNIT */
/* Role: lexer and input: the input stack: opening source files, macro-expansion and
   argument contexts, buffer refill, string literal copying, input position, source echo.
   Entry points: OPEN_SOURCE_FILE, POP_INPUT_CONTEXT, PUSH_MACRO_EXPANSION, BCC_INPUT_BYTE,
   BCC_INPUT_STRING, BCC_INPUT_STRING_PTR, INPUT_REFILL, COPY_STRING_LITERAL (+4 more). Map
   of all sources: docs/SOURCE-MAP.md. */
/* Original CO032 as one source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: the input stack under the lexer.  The lexer reads bytes from
   one buffer (INPUT_BUFFER holds the near address of a variable that holds
   the buffer's segment; INPUT_INDEX and INPUT_LIMIT are offsets in it) and
   calls INPUT_REFILL when INPUT_INDEX reaches INPUT_LIMIT.  What the buffer
   holds depends on the input context on top of the stack (CONTEXT_PTR, a
   record in CONTEXT_SEG; fields CTX_*; CTX_PREV links to the outer
   context).  CTX_KIND says what kind of context it is:
     a DOS file handle: a source or #include file, read 4096 bytes at a
       time into a buffer that follows the context record; at the end of
       the file the buffer becomes EOF_BUFFER_TEXT (a line end, then the
       end-of-input byte 26);
     202: a macro expansion, reading a macro definition (POOL_E or POOL_F;
       the parity of the offset picks the pool) or a macro argument's text
       (POOL_A or TOKEN_POOL);
     201: a plain string pushed back into the input (BCC_INPUT_STRING).
   Pushing saves the read position of the old top in its context and loads
   the new one; popping does the reverse.  CURRENT_FILE_CONTEXT is the
   innermost file context, the one line numbers and positions refer to.
   Macro expansion works through INPUT_REFILL: a macro's text is fed to
   the lexer one chunk at a time, a chunk ending at the next marker byte
   (0x80 or above: a parameter, # or ## operator, no-expand mark), and
   INPUT_REFILL then acts on the marker (pushes the argument's text, turns
   a # parameter into a string, ...).  While a macro is being expanded its
   name's HLINK_MACRO is cleared so it cannot expand itself; it is put
   back when its context is popped.  MACRO_EXPANSION_DEPTH counts open
   expansions; when it drops to 0 the argument pools are emptied.
   Popped macro contexts are kept on FREE_MACRO_CONTEXT_LIST for reuse.
   The last functions (SEEK_ECHO_FILE, DUMP_SOURCE_LINES and helpers) are
   separate: they read source lines through the file handle again to copy
   them into assembly output as comments, probably for -S listings with
   source lines. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- INPOP (listing 2460) ---- */
#include <dos.h>
extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
/* Pops the input stack: makes the outer context current and reloads the
   buffer variables from its saved read position.  The caller releases the
   popped record. */
static void near pascal BCC_INPUT_POP(void)
{
    register unsigned int cursor;
    cursor=CTX_W(CONTEXT_PTR,CTX_PREV);
    CONTEXT_PTR=cursor;
    INPUT_BUFFER=CTX_W(cursor,CTX_BUFFER_SEG_VAR);
    INPUT_INDEX=CTX_W(cursor,CTX_BUFFER_BASE)+CTX_W(cursor,CTX_READ_POS);
    INPUT_LIMIT=CTX_W(cursor,CTX_BUFFER_BASE)+CTX_W(cursor,CTX_LENGTH);
}

/* ---- INPUSH (listing 2496) ---- */
#include <dos.h>

/* Pushes context onto the input stack: saves the current read position in
   the old top, links the new record to it and makes its buffer current. */
static void near pascal BCC_INPUT_PUSH(register unsigned int context)
{
    if(CONTEXT_PTR!=0)
        CTX_W(CONTEXT_PTR,CTX_READ_POS)=INPUT_INDEX-CTX_W(CONTEXT_PTR,CTX_BUFFER_BASE);
    CTX_W(context,CTX_PREV)=CONTEXT_PTR;
    CONTEXT_PTR=context;
    INPUT_BUFFER=CTX_W(context,CTX_BUFFER_SEG_VAR);
    INPUT_INDEX=CTX_W(context,CTX_BUFFER_BASE)+CTX_W(context,CTX_READ_POS);
    INPUT_LIMIT=CTX_W(context,CTX_BUFFER_BASE)+CTX_W(context,CTX_LENGTH);
}

/* ---- OPEN_SOURCE_FILE (listing 24EA) ---- */
/* CO032 0x008A OPEN_SOURCE_FILE: open a source file and push its input context. */
#include <dos.h>
extern unsigned int STRING_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned int far pascal NEW_SERIAL_NODE(unsigned int);
static void near pascal BCC_INPUT_PUSH(unsigned int);
/* defined later in this overlay (0x04A6): pushes DS then the offset */
void far pascal BCC_INPUT_STRING(char far *);

/* Returns 0 if the file cannot be opened, else 1.  The context record
   (0x1016 bytes: 22 bytes of context, then the 4096-byte buffer) saves the
   including file's name, line and conditional state so POP_INPUT_CONTEXT
   can restore them.  A line end is pushed in front of the file's text, so
   the first real line is line 1 and a '#' on it is seen as the start of a
   line.  The new file gets its own serial node (LEX_FILE_SERIAL_NODE),
   which identifies it in token positions. */
unsigned int far pascal OPEN_SOURCE_FILE(char far *path)
{
    register unsigned int context;
    register int handle;
    handle=RTL_OPEN(path,0);
    if(handle==-1) return 0;
    context=POOL_ALLOC(&CONTEXT_SEG,0x1016);
    CTX_W(context,CTX_FILE_HANDLE)=handle;
    CTX_W(context,CTX_LENGTH)=0;
    CTX_W(context,CTX_BUFFER_SEG_VAR)=(unsigned int)&CONTEXT_SEG;
    CTX_W(context,CTX_BUFFER_BASE)=context+22;
    CTX_W(context,CTX_READ_POS)=0;
    CTX_W(context,CTX_SAVED_FILE_NAME)=CURRENT_FILE_NAME;
    CTX_W(context,CTX_SAVED_LINE)=CURRENT_LINE;
    CTX_W(context,CTX_SAVED_LINE_RECORD)=LINE_RECORD;
    BCC_INPUT_PUSH(context);
    CURRENT_FILE_CONTEXT=context;
    CURRENT_FILE_NAME=POOL_ALLOC(&STRING_POOL_SEG,STRING_LENGTH(path)+1);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME),path);
    CURRENT_LINE=0;
    BCC_INPUT_STRING(STR_NEWLINE_INPUT);
    CTX_W(context,CTX_FILE_POS)=0;
    CTX_W(context,CTX_SAVED_SERIAL_NODE)=LEX_FILE_SERIAL_NODE;
    LEX_FILE_SERIAL_NODE=NEW_SERIAL_NODE(CURRENT_FILE_NAME);
    return 1;
}

/* ---- RETURN_MINUS_ONE_STUB (listing 25B9) ---- */
/* CO032 0x0159 RETURN_MINUS_ONE_STUB: 10-byte real near function (inc bp frame, ret), no known caller. */

static int near pascal RETURN_MINUS_ONE_STUB(void)
{
    return -1;
}

/* ---- POP_INPUT_CONTEXT (listing 25C3) ---- */
/* CO032 0x0163 POP_INPUT_CONTEXT: pop the current input context (end of file / string). */
#include <dos.h>
extern unsigned int far pascal CLONE_NODE_NEW_SERIAL(unsigned int);
extern void far pascal REPLAY_PREAMBLE(void);
static void near pascal BCC_INPUT_POP(void);
#define C(o,n) FAR_W(CONTEXT_SEG,(o),(n))

/* Returns 1 if a context was popped and reading can go on, 0 at the end of
   the main file (or with an empty stack).  String and macro contexts are
   simply popped.  For a file: an #if left open in it is reported unless
   quiet (LINE_RECORD is probably the innermost open conditional, and the
   word before it in LINE_POOL its line number); the file is closed and
   the including file's name, line and serial node are restored.  When
   reading returns to the main file, REPLAY_PREAMBLE (PCH.C) is called for
   the precompiled-header logic.  quiet is nonzero when unwinding after a
   fatal error (OPTIONS.C pops every context that way). */
unsigned int far pascal POP_INPUT_CONTEXT(register unsigned int quiet)
{
    register unsigned int context;
    if(CONTEXT_PTR==0) return 0;
    if(C(CONTEXT_PTR,0)==201) {
        CONTEXT_SEG_USED=0;
        CONTEXT_SEG_UNIT=CONTEXT_PTR;
        BCC_INPUT_POP();
        return 1;
    }
    context=CONTEXT_PTR;
    /* The original tests 201 again here although the test above already returned for it:
       without this case label the switch compiles differently. */
    switch(C(CONTEXT_PTR,0)) {
    case 201:
    case 202:
        CONTEXT_SEG_USED=0;
        CONTEXT_SEG_UNIT=CONTEXT_PTR;
        BCC_INPUT_POP();
        return 1;
    }
    if(C(context,20)!=LINE_RECORD && !quiet) REPORT_ERROR(MSG_UNEXPECTED_END_FILE_42,FAR_W(LINE_POOL,LINE_RECORD,-2));
    LINE_RECORD=C(context,20);
    RTL_CLOSE(C(CONTEXT_PTR,0));
    if(C(CONTEXT_PTR,10)==0) return 0;
    CURRENT_LINE=C(context,14);
    LEX_FILE_SERIAL_NODE=CLONE_NODE_NEW_SERIAL(C(context,16));
    LOGICAL_LINE=CURRENT_LINE;
    CURRENT_FILE_NAME=C(context,12);
    CONTEXT_SEG_USED=0;
    CONTEXT_SEG_UNIT=CONTEXT_PTR;
    BCC_INPUT_POP();
    CURRENT_FILE_CONTEXT=CONTEXT_PTR;
    FREE_MACRO_CONTEXT_LIST=0;
    if(C(CONTEXT_PTR,10)==0 && !quiet) REPLAY_PREAMBLE();
    return 1;
}
#undef C

/* ---- PUSH_MACRO_EXPANSION (listing 26CB) ---- */
/* CO032 0x026B PUSH_MACRO_EXPANSION: push a macro-expansion input context for a token. */
#include <dos.h>
extern unsigned int HASH_CHAIN_LINK_SEG;
#define C(o,n) FAR_W(CONTEXT_SEG,(o),(n))

/* macro: the name record (HASH_CHAIN_LINK_SEG) of the macro, or 0 for an
   anonymous text such as an argument being pre-expanded; its definition is
   disabled for the duration.  arguments: the POOL_A list of collected
   arguments, or 0.  token: the offset of the macro text (odd in POOL_F,
   even in POOL_E); its first byte is the parameter count and is skipped.
   The first chunk runs up to the first marker byte. */
void far pascal PUSH_MACRO_EXPANSION(unsigned int macro,unsigned int arguments,register unsigned int token)
{
    register unsigned int context;
    unsigned char far *cursor;
    unsigned int length;
    if(macro) HLINK_W(macro,HLINK_MACRO)=0;
    if(FREE_MACRO_CONTEXT_LIST) {
        context=FREE_MACRO_CONTEXT_LIST;
        FREE_MACRO_CONTEXT_LIST=C(context,10);
    } else {
        context=POOL_ALLOC(&CONTEXT_SEG,18);
        C(context,0)=202;
    }
    C(context,4)=0;
    C(context,6)=(unsigned int)((token&1)?&POOL_F:&POOL_E);
    cursor=(unsigned char far *)MK_FP((token&1)?POOL_F:POOL_E,token);
    ++cursor;
    length=0;
    while(*cursor!=0 && (*cursor&0x80)==0) { ++cursor; ++length; }
    C(context,2)=length;
    C(context,14)=macro;
    C(context,16)=token;
    C(context,12)=arguments;
    C(context,8)=token+1;
    BCC_INPUT_PUSH(context);
}
#undef C

/* ---- INBYTE (listing 279D) ---- */
#include <dos.h>
/* Returns the byte of macro text at offset (POOL_F if odd, POOL_E if
   even). */
unsigned char far pascal BCC_INPUT_BYTE(register unsigned int offset)
{
    return *((unsigned char far *)MK_FP((offset&1) ? POOL_F : POOL_E,offset));
}

/* ---- PUSH_ARGUMENT_TEXT (listing 27BC) ---- */
/* CO032 0x035C PUSH_ARGUMENT_TEXT: push an expansion context over argument text in POOL_A. */
#include <dos.h>
extern unsigned int MACRO_EXPANSION_DEPTH;

static void near pascal PUSH_ARGUMENT_TEXT(unsigned int offset)
{
    register unsigned int context;
    register unsigned int length;
    unsigned char far *cursor;
    if(FREE_MACRO_CONTEXT_LIST) {
        context=FREE_MACRO_CONTEXT_LIST;
        FREE_MACRO_CONTEXT_LIST=CTX_W(context,CTX_PREV);
    } else {
        context=POOL_ALLOC(&CONTEXT_SEG,18);
        CTX_W(context,CTX_KIND)=202;
    }
    CTX_W(context,CTX_READ_POS)=0;
    cursor=(unsigned char far *)MK_FP(POOL_A,offset);
    length=0;
    while(*cursor!=0 && (*cursor&0x80)==0) { ++cursor; ++length; }
    CTX_W(context,CTX_LENGTH)=length;
    CTX_W(context,CTX_MACRO_HLINK)=0;
    CTX_W(context,CTX_MACRO_DEF)=0;
    CTX_W(context,CTX_MACRO_ARGS)=0;
    CTX_W(context,CTX_BUFFER_SEG_VAR)=(unsigned int)&POOL_A;
    CTX_W(context,CTX_BUFFER_BASE)=offset;
    ++MACRO_EXPANSION_DEPTH;
    BCC_INPUT_PUSH(context);
}

/* ---- PUSH_ARGUMENT_TOKENS (listing 285B) ---- */
/* CO032 0x03FB PUSH_ARGUMENT_TOKENS: push an expansion context over a value in TOKEN_POOL. */
#include <dos.h>

static void near pascal PUSH_ARGUMENT_TOKENS(unsigned int offset)
{
    register unsigned int context;
    register unsigned int length;
    unsigned char far *cursor;
    if(FREE_MACRO_CONTEXT_LIST) {
        context=FREE_MACRO_CONTEXT_LIST;
        FREE_MACRO_CONTEXT_LIST=CTX_W(context,CTX_PREV);
    } else {
        context=POOL_ALLOC(&CONTEXT_SEG,18);
        CTX_W(context,CTX_KIND)=202;
    }
    CTX_W(context,CTX_READ_POS)=0;
    cursor=(unsigned char far *)MK_FP(TOKEN_POOL,offset);
    length=0;
    while(*cursor!=0) {
        if(*cursor&0x80) break;
        if(*cursor==26) break;
        ++cursor;
        ++length;
    }
    CTX_W(context,CTX_LENGTH)=length;
    CTX_W(context,CTX_MACRO_HLINK)=0;
    CTX_W(context,CTX_MACRO_DEF)=0;
    CTX_W(context,CTX_MACRO_ARGS)=0;
    CTX_W(context,CTX_BUFFER_SEG_VAR)=(unsigned int)&TOKEN_POOL;
    CTX_W(context,CTX_BUFFER_BASE)=offset;
    ++MACRO_EXPANSION_DEPTH;
    BCC_INPUT_PUSH(context);
}

/* ---- INSSTR (listing 2906) ---- */
#include <dos.h>
/* Pushes a string as input (kind 201), so the lexer reads it next.  Used
   for the line end before each file, the digits of __LINE__ and the quote
   that starts a stringized argument.  The string's segment is kept in
   STRING_DATA, so only one far string can be pushed at a time. */
void far pascal BCC_INPUT_STRING(char far *text)
{
    unsigned int node;
    STRING_DATA=FP_SEG(text);
    node=POOL_ALLOC(&CONTEXT_SEG,12);
    CTX_W(node,CTX_KIND)=201;
    CTX_W(node,CTX_BUFFER_SEG_VAR)=(unsigned int)&STRING_DATA;
    CTX_W(node,CTX_BUFFER_BASE)=FP_OFF(text);
    CTX_W(node,CTX_READ_POS)=0;
    CTX_W(node,CTX_LENGTH)=STRING_LENGTH(text);
    BCC_INPUT_PUSH(node);
}

/* ---- INSPTR (listing 2958) ---- */
/* -Z: ES is kept across far stores into the same segment (user-accepted, batch290-admission/policy-Z-extension.json). */
#include <dos.h>
/* Like BCC_INPUT_STRING, but the string is given as the near address of a
   variable holding its segment (as pools are) and an offset. */
void far pascal BCC_INPUT_STRING_PTR(register unsigned int segment_word,unsigned int offset)
{
    register unsigned int context;
    context=POOL_ALLOC(&CONTEXT_SEG,12);
    CTX_W(context,CTX_KIND)=201;
    CTX_W(context,CTX_BUFFER_SEG_VAR)=segment_word;
    CTX_W(context,CTX_BUFFER_BASE)=offset;
    CTX_W(context,CTX_READ_POS)=0;
    CTX_W(context,CTX_LENGTH)=STRING_LENGTH((char far *)MK_FP(*((unsigned int near *)segment_word),offset));
    BCC_INPUT_PUSH(context);
}

/* ---- INPUT_REFILL (listing 29A6) ---- */
/* CO032 0x0546 INPUT_REFILL: refill the input buffer (next byte when the current buffer is empty). */
/* 6-word switch table at 0x08D5..0x08EC belongs to this function. */
#include <dos.h>
extern unsigned int PENDING_STRING_TEXT;
extern unsigned char MACRO_MARK_FC_PENDING;
void far pascal BCC_INPUT_STRING(char far *);   /* 0x04A6 */
#define C(o,n) FAR_W(CONTEXT_SEG,(o),(n))
#define CONTEXT(o) ((unsigned int far *)MK_FP(CONTEXT_SEG,(o)))
#define SEGMENT_OF(w) (*(unsigned int near *)(w))
#define BUFFER_SEGMENT SEGMENT_OF(INPUT_BUFFER)
#define DATA_SEGMENT FP_SEG((void far *)&STRING_DATA)
/* Skip to macro argument number (value&0x7F); argument offsets are in POOL_A. */
#define FIND_ARGUMENT() \
    argument=C(context,12); \
    value&=0x7F; \
    while(value>1) { \
        argument+=2; \
        argument+=STRING_LENGTH((char far *)MK_FP(POOL_A,argument))+1; \
        --value; \
    }

/* Called when INPUT_INDEX has reached INPUT_LIMIT: returns the next input
   byte (and consumes it), after loading more input.  For a file context
   that means reading the next 4096 bytes; for a macro context, acting on
   the marker byte that ended the chunk (see below); a finished string or
   macro context is popped and reading goes on in the outer one.  Loops
   until some byte is available. */
unsigned char far pascal INPUT_REFILL(void)
{
    register unsigned int context;
    register unsigned int cursor;
    int value;
    unsigned int argument;
    do {
        switch(C(CONTEXT_PTR,0)) {
        default:
            if(SEGMENT_OF(C(CONTEXT_PTR,6))==DATA_SEGMENT) value=0;
            else value=RTL_READ(C(CONTEXT_PTR,0),
                       MK_FP(SEGMENT_OF(C(CONTEXT_PTR,6)),C(CONTEXT_PTR,8)),4096);
            if(value>0) {
                C(CONTEXT_PTR,18)+=C(CONTEXT_PTR,2);
                C(CONTEXT_PTR,2)=value;
                C(CONTEXT_PTR,4)=1;
                INPUT_INDEX=C(CONTEXT_PTR,8);
                INPUT_LIMIT=C(CONTEXT_PTR,8)+value;
                return AT_B(BUFFER_SEGMENT,INPUT_INDEX++);
            }
            STRING_DATA=DATA_SEGMENT;
            C(CONTEXT_PTR,6)=(unsigned int)&STRING_DATA;
            C(CONTEXT_PTR,4)=1;
            C(CONTEXT_PTR,2)=2;
            C(CONTEXT_PTR,8)=(unsigned int)EOF_BUFFER_TEXT;
            INPUT_BUFFER=(unsigned int)&STRING_DATA;
            INPUT_INDEX=(unsigned int)(EOF_BUFFER_TEXT+1);
            INPUT_LIMIT=(unsigned int)(EOF_BUFFER_TEXT+2);
            return 10;
        /* Macro context: the current chunk is used up.  The byte at
           INPUT_LIMIT is the marker that ended it; 0 is the end of the whole
           text, which pops the context. */
        case 202:
            context=CONTEXT_PTR;
            if((value=AT_B(BUFFER_SEGMENT,INPUT_LIMIT))==0) {
                if(C(context,14)) HLINK_W(C(context,14),HLINK_MACRO)=C(context,16);
                --MACRO_EXPANSION_DEPTH;
                if(MACRO_EXPANSION_DEPTH==0) {
                    POOL_A_USED=0;
                    POOL_A_UNIT=1;
                    TOKEN_POOL_USED=0;
                    TOKEN_POOL_UNIT=1;
                    FREE_MACRO_CONTEXT_LIST=0;
                    CONTEXT_SEG_USED=0;
                    CONTEXT_SEG_UNIT=CONTEXT_PTR;
                    BCC_INPUT_POP();
                } else {
                    BCC_INPUT_POP();
                    C(context,10)=FREE_MACRO_CONTEXT_LIST;
                    FREE_MACRO_CONTEXT_LIST=context;
                }
                break;
            }
            /* Act on the marker byte: 254 is ## (the argument after it is
               used unexpanded), 253 is # (the argument becomes a string:
               PENDING_STRING_TEXT points at its raw text and a '"' is pushed
               for the lexer to start a string literal), 252 a no-expand mark
               for the next name, 255 a literal byte, other values 0x80+n a
               parameter: the expanded argument text, or the raw text if a
               ## follows. */
            cursor=INPUT_LIMIT+1;
            switch(value) {
            case 254:
                MACRO_MARK_FE_SEEN=1;
                value=AT_B(BUFFER_SEGMENT,cursor);
                if((value&0x80) && value<251) {
                    ++cursor;
                    value&=0x7F;    /* the original masks twice (again in FIND_ARGUMENT) */
                    FIND_ARGUMENT();
                    PUSH_ARGUMENT_TOKENS(FAR_W(POOL_A,argument,MARG_TEXT_OFFSET));
                }
                value=0;
                break;
            case 253:
                value=AT_B(BUFFER_SEGMENT,cursor++);
                if(!(value&0x80) || value>=251) {
                    REPORT_ERROR(MSG_OPERATOR_NOT_FOLLOWED);
                    --cursor;
                    value=0;
                    break;
                }
                FIND_ARGUMENT();
                PENDING_STRING_TEXT=FAR_W(POOL_A,argument,MARG_TEXT_OFFSET);
                BCC_INPUT_STRING(STR_DOUBLE_QUOTE);
                value=0;
                break;
            case 252:
                value=0;
                MACRO_MARK_FC_PENDING=1;
                break;
            case 255:
                value=AT_B(BUFFER_SEGMENT,cursor++);
                break;
            case 26:
                if(C(context,16)==0) value=0;
                break;
            case 251:
                break;
            default:
                value&=0x7F;    /* the original masks twice (again in FIND_ARGUMENT) */
                FIND_ARGUMENT();
                if(AT_B(SEGMENT_OF(C(context,6)),cursor)==254)
                    PUSH_ARGUMENT_TOKENS(FAR_W(POOL_A,argument,MARG_TEXT_OFFSET));
                else PUSH_ARGUMENT_TEXT(argument+2);
                value=0;
                break;
            }
            /* Set up the next chunk, up to the next marker or the end. */
            C(context,8)=cursor;
            if(CONTEXT(context)==CONTEXT(CONTEXT_PTR)) INPUT_INDEX=cursor;
            while(AT_B(SEGMENT_OF(C(context,6)),cursor)!=0 &&
                  (AT_B(SEGMENT_OF(C(context,6)),cursor)&0x80)==0 &&
                  AT_B(SEGMENT_OF(C(context,6)),cursor)!=26) ++cursor;
            C(context,4)=0;
            C(context,2)=cursor-C(context,8);
            if(CONTEXT(context)==CONTEXT(CONTEXT_PTR)) INPUT_LIMIT=cursor;
            if(value!=0) return value;
            break;
        case 201:
            CONTEXT_SEG_USED=0;
            CONTEXT_SEG_UNIT=CONTEXT_PTR;
            BCC_INPUT_POP();
            break;
        }
    } while(INPUT_INDEX>=INPUT_LIMIT);
    return AT_B(BUFFER_SEGMENT,INPUT_INDEX++);
}
#undef C
#undef CONTEXT
#undef SEGMENT_OF
#undef BUFFER_SEGMENT
#undef DATA_SEGMENT
#undef FIND_ARGUMENT

/* ---- COPY_STRING_LITERAL (listing 2D4D) ---- */
/* CO032 0x08ED COPY_STRING_LITERAL: copy a quoted string literal from the input through an emit callback. */
#include <dos.h>
extern void far pascal LEX_NEWLINE(char);
unsigned char far pascal INPUT_REFILL(void);          /* 0x0546, earlier in this overlay */
typedef void (far pascal *EMIT)(signed char);
#define BUFFER_SEGMENT (*(unsigned int near *)INPUT_BUFFER)
#define NEXT_INPUT() (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : AT_B(BUFFER_SEGMENT,INPUT_INDEX++))

/* Copies a quoted string or character constant, whose opening quote has
   been read, through emit, quotes included and escapes left as written.
   If PENDING_STRING_TEXT is set the text comes from TOKEN_POOL instead (a
   stringized macro argument: quotes and backslashes in it are escaped).
   Returns 1 when the closing quote was found, 0 at a line end or end of
   input (an "unterminated string" error if diagnose is nonzero). */
int far pascal COPY_STRING_LITERAL(signed char quote,EMIT emit,unsigned int diagnose)
{
    register unsigned int cursor;
    int value;
    emit(quote);
    if(PENDING_STRING_TEXT) {
        for(cursor=PENDING_STRING_TEXT;AT_B(TOKEN_POOL,cursor)!=0;++cursor) {
            if(AT_B(TOKEN_POOL,cursor)==26) break;
            if(AT_B(TOKEN_POOL,cursor)=='"' || AT_B(TOKEN_POOL,cursor)=='\\') emit('\\');
            else if(AT_B(TOKEN_POOL,cursor)==252 || AT_B(TOKEN_POOL,cursor)==251) continue;
            else if(AT_B(TOKEN_POOL,cursor)==255) ++cursor;
            emit(AT_B(TOKEN_POOL,cursor));
        }
        emit(quote);
        PENDING_STRING_TEXT=0;
        return 1;
    }
    while((value=NEXT_INPUT())!=26 && value!=10 && value!=13) {
        if(value=='\\') {
            value=NEXT_INPUT();
            if(value!=13 && value!=10) emit('\\');
            else {
                LEX_NEWLINE(value);
                continue;
            }
        } else if(value==quote) {
            emit(value);
            return 1;
        }
        emit(value);
    }
    if(diagnose) {
        REPORT_ERROR(MSG_UNTERMINATED_STRING);
        emit(quote);
        --INPUT_INDEX;
        return 0;
    }
    --INPUT_INDEX;
    return 0;
}
#undef BUFFER_SEGMENT
#undef NEXT_INPUT

/* ---- INPUT_POSITION (listing 2E92) ---- */
/* CO032 0x0A32 INPUT_POSITION (= held module INPOS, BCC_INPUT_POSITION): byte position in the current file. */
#include <dos.h>

unsigned long far pascal INPUT_POSITION(void)
{
    return (unsigned int)(CTX_W(CURRENT_FILE_CONTEXT,CTX_FILE_POS) + (CONTEXT_PTR==CURRENT_FILE_CONTEXT ? INPUT_INDEX-((unsigned int far *)MK_FP(CONTEXT_SEG,CURRENT_FILE_CONTEXT))[4] : ((unsigned int far *)MK_FP(CONTEXT_SEG,CURRENT_FILE_CONTEXT))[2]));
}

/* ---- INOPEN (listing 2ECF) ---- */
#include <dos.h>

/* Prepares to echo source lines: the next line to copy is line, and if
   the current file is the one identified by the serial node source the
   file handle (INPUT_ACTIVE) is moved to position, after saving its current
   position in INPUT_FILE_POS.  Otherwise echoing is turned off
   (INPUT_ACTIVE 0). */
void far pascal SEEK_ECHO_FILE(unsigned int line,unsigned int source,long position)
{
    ECHO_NEXT_LINE=line-1;
    if(LEX_FILE_SERIAL_NODE==source) {
        INPUT_ACTIVE=*((unsigned int far *)MK_FP(CONTEXT_SEG,CURRENT_FILE_CONTEXT));
        if(INPUT_ACTIVE>=200 && INPUT_ACTIVE<=203) {
            INPUT_ACTIVE=0;
            return;
        }
    } else {
        INPUT_ACTIVE=0;
        return;
    }
    INPUT_FILE_POS=RTL_LSEEK(INPUT_ACTIVE,0L,1);
    RTL_LSEEK(INPUT_ACTIVE,position,0);
    INPUT_UNGET_FLAG=0;
}

/* ---- INGET (listing 2F3F) ---- */
/* Reads one byte for the echo, honouring a byte put back with
   INPUT_UNGET; 26 at the end of the file. */
static int near pascal BCC_INPUT_GET(void)
{
    int value;
    if (INPUT_UNGET_FLAG) {
        INPUT_UNGET_FLAG=0;
        return INPUT_UNGET_CHAR;
    }
    if (RTL_READ(INPUT_ACTIVE,&value,1)==1)
        return value&255;
    return 26;
}

/* ---- INUNGET (listing 2F7E) ---- */
/* Puts back one byte for BCC_INPUT_GET. */
static void near pascal INPUT_UNGET(int c)
{
    INPUT_UNGET_FLAG = 1;
    INPUT_UNGET_CHAR = c;
}

/* ---- INDUMP (listing 2F93) ---- */
#include <dos.h>
static int near pascal BCC_INPUT_GET(void);
static void near pascal INPUT_UNGET(int);
/* Copies source lines up to, not including, line limit into the output
   through BCC_OUTPUT_STRING and OUTPUT_CHAR, each line indented as a
   comment (STR_COMMENT_INDENT) and cut to 128 characters, with a blank
   comment line before and after the group. */
void far pascal DUMP_SOURCE_LINES(register unsigned int limit)
{
    register int count;
    int value;
    if(INPUT_ACTIVE==0) return;
    if(ECHO_NEXT_LINE>=limit) return;
    BCC_OUTPUT_STRING(STR_BLANK_COMMENT_LINE);
    while(ECHO_NEXT_LINE<limit) {
        count=0;
        BCC_OUTPUT_STRING(STR_COMMENT_INDENT);
        for(;;) {
            value=BCC_INPUT_GET();
            if(value==13) {
                value=BCC_INPUT_GET();
                if(value!=10) INPUT_UNGET(value);
                break;
            } else if(value==10) {
                value=BCC_INPUT_GET();
                if(value!=13) INPUT_UNGET(value);
                break;
            } else if(value==26) {
                ECHO_NEXT_LINE=limit-1;
                break;
            } else if(count<128) {
                OUTPUT_CHAR((unsigned char)value);
                count++;
            }
        }
        BCC_OUTPUT_STRING(STR_CRLF_ECHO);
        ECHO_NEXT_LINE++;
    }
    BCC_OUTPUT_STRING(STR_BLANK_COMMENT_LINE);
}

/* ---- INCLOSE (listing 3048) ---- */
#include <dos.h>
/* DOS INT 21h/AH=42h: seek(handle, signed offset, origin), returning DX:AX. */
/* Puts the file handle back where the lexer left it (INPUT_FILE_POS). */
void far pascal RESTORE_ECHO_POSITION(void)
{
    if (INPUT_ACTIVE)
        RTL_LSEEK(INPUT_ACTIVE,
            INPUT_FILE_POS,0);
}

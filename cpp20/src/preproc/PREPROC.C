/* target: PREPROC */
/* opts: -mm -O -Z -p -y -B -TjNOSMART -d */
/* link: -d (duplicate strings merged): the error reports' "define" and "line" are the
   directive table's own literals (DS:4FF3, DS:5020), where BCC's reconstruction named them
   STR_DEFINE and STR_LINE; the bytes are the same. */
/* CPP.EXE module PREPROC (image 0xA35D..0xB39D, frame 0A35h): source taken from the
   BCC.EXE reconstruction (bcc20/src/preproc/PREPROC.C), with CPP.EXE's
   edits marked "CPP.EXE edit". CPP.EXE has only some of its functions, in the same
   order; left out here: PRAGMA_WARN, CHECK_NAME_CONTEXT, PARSE_STARTUP_EXIT,
   PRAGMA_STARTUP, PRAGMA_EXIT, PRAGMA_SAVEREGS, PRAGMA_OPTION, PRAGMA_ARGSUSED,
   PRAGMA_NORETVAL, SCAN_ALNUM, PRAGMA_CODESEG (BCC's #pragma handlers). BCC's
   PREPROC, DIRTAIL, SKIPLINE and COMMENT files are one file here, in that order:
   CHECK_DIRECTIVE_END and the line skipper are near statics reached by near calls. */
/* Role: preprocessor directives. Entry points: REPORT_PRAGMA_ERROR, DIRECTIVE_START,
   TOKEN_TRIM, SCAN_TOKEN, SCAN_WRITE, SCAN_EMIT_FAR, SCAN_NEXT, SCAN_FINISH,
   COMMENT_BLOCK, COMMENT_LINE, SCAN_EMPTY. */
/* Overview: the preprocessor directives.  The lexer calls DIRECTIVE_START
   when a line starts with '#' (LEX_HASH in LEXER.C).  DIRECTIVE_START reads
   the directive name, looks it up in DIRECTIVE_TABLE (12 entries: name,
   code, handler) and calls the handler with the first character after
   the name.  Handlers read the rest of the line straight from the input
   buffer, character by character (GETBYTE, SCAN_NEXT, SCAN_TOKEN), not
   through tokens.  The handlers here: DIRECTIVE_INCLUDE (#include),
   BCC_PARSE_MACRO (#define), PARSE_UNDEF, PARSE_CONDITIONAL (#if),
   PARSE_IFDEF_DIRECTIVE and PARSE_IFNDEF_DIRECTIVE (#ifdef and #ifndef),
   PARSE_ELIF, PARSE_ELSE, PARSE_ENDIF, BCC_PARSE_LINE (#line),
   PARSE_ERROR_DIRECTIVE (#error) and PARSE_PRAGMA (#pragma). In CPP.EXE
   PARSE_PRAGMA copies the #pragma line to the output unchanged; BCC's
   version dispatched through PRAGMA_TABLE to its PRAGMA_* handlers.
   Conditional compilation: each open #if group has a 4-byte record in
   LINE_POOL (a state word, then the line of the #if); LINE_RECORD points
   just past the innermost record (0 when none is open).  State 1 means
   the lines being processed belong to a taken branch, so a later #elif or
   #else starts lines to skip; state 2 means the #else has been seen.
   Skipped lines are passed over by CONDITIONAL_SCAN, which only looks at
   directives to track nesting and stops at the matching #elif, #else or
   #endif.  DIRECTIVE_MODE tells it which directive it found, by the code
   in DIRECTIVE_TABLE: 4, 5 and 7 open a group (#ifdef, #ifndef, #if),
   6 is #endif, 8 #else and 10 #elif (read from how the codes are used).
   The #if expression is evaluated by EVAL_CONSTANT_CONDITION (CPPIFEXP.C),
   called directly, which leaves the value in TOKEN_CONST_VALUE.
   Text is collected in the token text buffer (TOKEN_PTR, in the buffer
   named TOKEN_TEXT_BUFFER); names go to NAME_BUFFER. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"

/* ---- REPORT_PRAGMA_ERROR (CPP 0A35:000D) ---- */
extern signed char  LANGUAGE_MODE;
/* Reports an error in a #pragma, except in strict ANSI mode (LANGUAGE_MODE
   1), where unknown or malformed pragmas are silently ignored. */
void far pascal REPORT_PRAGMA_ERROR(unsigned int error,char far *name)
{
    if(LANGUAGE_MODE!=1) REPORT_ERROR(error,name);
}

/* ---- DIRECTIVE_START (CPP 0A35:002C) ---- */
#include <dos.h>
struct Keyword { char near *name; signed char token; void (near pascal *function)(int); };
/* CPP.EXE edit: the directive table is defined here (BCC's reconstruction declares it
   extern; its data is matched apart from the code).  CPP.EXE's _DATA has it at DS:4FA2,
   followed by its name strings and then this file's "#pragma " (DS:5025), the layout of
   one file's initialised data and literal pool; and its handlers are this file's near
   statics, which no other file could name.  Codes as described in the overview. */
static void near pascal PARSE_PRAGMA(int);
static void near pascal PARSE_ERROR_DIRECTIVE(int);
static void near pascal DIRECTIVE_INCLUDE(int);
static void near pascal BCC_PARSE_MACRO(int);
static void near pascal PARSE_UNDEF(int);
static void near pascal PARSE_CONDITIONAL(int);
static void near pascal PARSE_IFDEF_DIRECTIVE(int);
static void near pascal PARSE_IFNDEF_DIRECTIVE(int);
static void near pascal PARSE_ELSE(int);
static void near pascal PARSE_ELIF(int);
static void near pascal PARSE_ENDIF(int);
static void near pascal BCC_PARSE_LINE(int);
struct Keyword  DIRECTIVE_TABLE[12] = {
    { "pragma",  11, PARSE_PRAGMA },
    { "error",   12, PARSE_ERROR_DIRECTIVE },
    { "include",  1, DIRECTIVE_INCLUDE },
    { "define",   2, BCC_PARSE_MACRO },
    { "undef",    3, PARSE_UNDEF },
    { "if",       7, PARSE_CONDITIONAL },
    { "ifdef",    4, PARSE_IFDEF_DIRECTIVE },
    { "ifndef",   5, PARSE_IFNDEF_DIRECTIVE },
    { "else",     8, PARSE_ELSE },
    { "elif",    10, PARSE_ELIF },
    { "endif",    6, PARSE_ENDIF },
    { "line",     9, BCC_PARSE_LINE },
};
extern char _CTYPE[];
extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
extern int far pascal SCAN_NEXT(volatile int);
/* CPP.EXE edit: SCAN_FINISH is the near static at the end of this file (BCC: a far
   function in another overlay); every call is a near `call` to it. */
static void near pascal SCAN_FINISH(int);
extern unsigned char far pascal INPUT_REFILL(void);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* Reads a directive name after '#'.  With process nonzero the directive is
   executed.  With process 0 (from CONDITIONAL_SCAN, inside skipped lines)
   it is only identified: its code is left in DIRECTIVE_MODE (0 if the name
   is unknown) and the rest of the line is left unread.  A '#' alone on a
   line is allowed; an unknown name is an error only when processing. */
void far pascal DIRECTIVE_START(unsigned int process)
{
    int value;
    register struct Keyword near *entry;
    register char near *text;
    value=SCAN_NEXT(32);
    if(value==10 || value==13 || value==26) {
        DIRECTIVE_MODE=0;
        if(value==10 || value==13) --INPUT_INDEX;
        return;
    }
    LOGICAL_LINE=CURRENT_LINE;
    if(!(_CTYPE[value+1]&12)) {
        TOKEN_TEXT_BUFFER[0]=(char)value;
        TOKEN_TEXT_BUFFER[1]=0;
        goto diagnose;
    }
    text=TOKEN_TEXT_BUFFER;
    while(_CTYPE[value+1]&12) {
        *text++=(char)value;
        value=GETBYTE;
    }
    *text=0;
    value=SCAN_NEXT(value);
    for(entry=DIRECTIVE_TABLE;entry<DIRECTIVE_TABLE+12;entry++) {
        if(COMPARE_NAME(entry->name,TOKEN_TEXT_BUFFER)==0) {
            if(process) {
                LOGICAL_LINE=CURRENT_LINE;
                entry->function(value);
                return;
            } else {
                DIRECTIVE_MODE=entry->token;
                --INPUT_INDEX;
                return;
            }
        }
    }
    DIRECTIVE_MODE=0;
    if(process) {
 diagnose:
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)TOKEN_TEXT_BUFFER);
    }
    SCAN_FINISH(value);
}
#undef GETBYTE

/* ---- (BCC's PRAGMA_WARN, not in CPP.EXE; only its declarations are left) ---- */
#include <dos.h>
extern int far pascal SCAN_TOKEN(int);
extern void far pascal REPORT_PRAGMA_ERROR(unsigned int,char far *);
extern void far pascal SAVE_WARNING_SWITCH(char far *,unsigned char);

/* ---- (BCC's CHECK_NAME_CONTEXT, not in CPP.EXE; only its declarations are left) ---- */
#include <dos.h>

extern void far CONTEXT_DIAGNOSTIC(void);
extern void far MODE_FALLBACK(int mode);
extern char  COMPILER_MODE;


/* ---- (BCC's PARSE_STARTUP_EXIT, PRAGMA_STARTUP, PRAGMA_EXIT, not in CPP.EXE; only its declarations are left) ---- */
#include <dos.h>
extern int (far pascal *PRAGMA_FUNC_LOOKUP_HOOK)(int);
extern void far pascal ADD_STARTUP_ENTRY(unsigned int,unsigned int);
extern void far pascal ADD_EXIT_ENTRY(unsigned int,unsigned int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

#undef GETBYTE



/* ---- (BCC's PRAGMA_SAVEREGS, not in CPP.EXE; only its declarations are left) ---- */
extern char  PRAGMA_SAVEREGS_PENDING;


/* ---- (BCC's PRAGMA_OPTION, not in CPP.EXE; only its declarations are left) ---- */
#include <dos.h>
extern char *TOKEN_PTR;
extern char  CHAR_CLASS[];
extern void far pascal SCAN_EMIT_FAR(char);
extern int far pascal APPLY_OPTION(char far *,int);
extern void far pascal SAVE_OPTION_STRING(char far *);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

#undef GETBYTE

/* ---- (BCC's PRAGMA_ARGSUSED, not in CPP.EXE; only its declarations are left) ---- */
extern char  PRAGMA_ARGSUSED_PENDING;


/* ---- (BCC's PRAGMA_NORETVAL, not in CPP.EXE; only its declarations are left) ---- */
extern char  PRAGMA_NORETVAL_PENDING;


/* ---- (BCC's SCAN_ALNUM, not in CPP.EXE; only its declarations are left) ---- */
#include <dos.h>



/* ---- (BCC's PRAGMA_CODESEG, not in CPP.EXE; only its declarations are left) ---- */
#include <dos.h>
extern char PRAGMA_CODESEG_SEEN,OPTION_WINDOWS_MODE;
extern unsigned int CODE_SEGMENT_ID;
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern unsigned int far pascal BCC_INTERN_STRING(char far *);
extern unsigned int far pascal DEFINE_SEGMENT(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CLONE_NODE_KEEP_SERIAL(unsigned int);
#define GETBYTE ((unsigned char)(INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++]))
#undef GETBYTE

/* ---- PARSE_PRAGMA (CPP 0A35:0145) ---- */
struct Handler { int (near pascal *function)(int); char near *name; };
extern struct Handler  PRAGMA_TABLE[];
/* CPP.EXE edit: the #pragma handler copies the directive to the output unchanged:
   "#pragma " and then the rest of the line, up to (not including) the line end.  BCC's
   version looks the name up in PRAGMA_TABLE; CPP.EXE has no PRAGMA_* handlers. */
static void near pascal PARSE_PRAGMA(int value)
{
    BCC_OUTPUT_STRING("#pragma ");
    while(value!=10 && value!=13 && value!=26) {
        OUTPUT_CHAR((char)value);
        value=INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    }
    --INPUT_INDEX;
}

/* ---- PARSE_ERROR_DIRECTIVE (CPP 0A35:019D) ---- */
#include <dos.h>

extern void far LEX_NEWLINE(char value);

/* The #error handler: collects the rest of the line
   (with line splices joined) and stops processing with a fatal error
   that shows the text. */
static void near pascal PARSE_ERROR_DIRECTIVE(int value)
{
    TOKEN_PTR = TOKEN_TEXT_BUFFER;
    *TOKEN_PTR = 0;
    while (value != 26 && value != 10 && value != 13) {
        SCAN_EMIT_FAR(value);
        value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
        if (value == 92) {
            value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
            if (value == 10 || value == 13) {
                LEX_NEWLINE(value);
                value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
            } else {
                SCAN_EMIT_FAR(92);
            }
        }
    }
    REPORT_FATAL(MSG_ERROR_DIRECTIVE, (char far *)TOKEN_TEXT_BUFFER);
}

/* ---- DIRECTIVE_INCLUDE (CPP 0A35:027A) ---- */
#include <dos.h>
extern char far *INCLUDE_OPTION_TEXT_PTR;
static void near pascal CHECK_DIRECTIVE_END(int);
extern void far pascal LEX_READ(int,int);
char * near pascal TOKEN_TRIM(void);
extern unsigned int far pascal OPEN_SOURCE_FILE(char far *);
extern int far pascal OPEN_INCLUDE_FILE(char far *);
extern void far pascal RECORD_SOURCE_NAME(void);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* #include "file" or <file>, or #include NAME where the macro NAME expands
   to one of those (read with LEX_READ mode 1).  A "file" name, or a name
   with a drive or a leading slash, or any name when no -I directories are
   given, is first tried as it stands; otherwise, or if that fails, the
   include directories are searched (OPEN_INCLUDE_FILE).  The opened file
   becomes the new top input context, and its name is added to
   SOURCE_FILE_LIST (RECORD_SOURCE_NAME). */
static void near pascal DIRECTIVE_INCLUDE(int value)
{
    char near *end;
    int delimiter,length;
    register char near *text;
    register char near *path;
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    if(value==60 || value==34) {
        TOKEN_TEXT_BUFFER[0]=0;
        if(value==60) delimiter=62;
        else delimiter=34;
        do {
            SCAN_EMIT_FAR((char)value);
            value=GETBYTE;
        } while(value!=26 && value!=10 && value!=13 && value!=delimiter);
        if(value==delimiter) {
            SCAN_EMIT_FAR((char)value);
            value=32;
        }
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        CHECK_DIRECTIVE_END(value);
    } else {
        --INPUT_INDEX;
        LEX_READ(0,1);
    }
    text=TOKEN_TRIM();
    end=text+STRING_LENGTH(text)-1;
    if(*text!=34 && *text!=60) {
        REPORT_ERROR(MSG_BAD_FILE_NAME_FORMAT);
        return;
    }
    if((*text==34 && *end!=34) || (*text==60 && *end!=62)) {
        REPORT_ERROR(MSG_NO_FILE_NAME_ENDING);
        return;
    }
    delimiter=*text;
    *end=0;
    ++text;
    length=STRING_LENGTH(text);
    if(length>80) {
        REPORT_ERROR(MSG_FILE_NAME_TOO_LONG);
        return;
    }
    path=NAME_BUFFER-(length+1);
    STRING_COPY(path,text);
    STRING_COPY(TOKEN_TEXT_BUFFER,path);
    if(delimiter==34 || path[1]==58 || *path==47 || *path==92 || *INCLUDE_OPTION_TEXT_PTR==0) {
        /* CPP.EXE edit: no RECORD_SOURCE_NAME calls here or after OPEN_INCLUDE_FILE
           (BCC records the name for the dependency list; CPP.EXE's code returns straight
           after the open). */
        if(OPEN_SOURCE_FILE(path)) return;
    }
    if(!OPEN_INCLUDE_FILE(path)) REPORT_ERROR(MSG_UNABLE_OPEN_INCLUDE,(char far *)path);
}
#undef GETBYTE

/* ---- TOKEN_TRIM (CPP 0A35:0400) ---- */
/* Strips trailing blanks, tabs and 0xFB separators from the text in the
   token buffer (TOKEN_TEXT_BUFFER) and returns a pointer past its leading blanks. */
/* CPP.EXE edit: near (BCC: far); called with a near `call`, returns with `ret`. */
char * near pascal TOKEN_TRIM(void)
{
    char *p;

    if (TOKEN_TEXT_BUFFER[0] == 0)
        return TOKEN_TEXT_BUFFER;
    p = TOKEN_TEXT_BUFFER + STRING_LENGTH((char far *)TOKEN_TEXT_BUFFER) - 1;
    while (p >= TOKEN_TEXT_BUFFER) {
        if (*p != 32 && *p != 9 && *p != -5)
            break;
        *p-- = 0;
    }
    p = TOKEN_TEXT_BUFFER;
    while (*p == 32 || *p == 9)
        p++;
    return p;
}

/* ---- BCC_PARSE_MACRO (CPP 0A35:044F) ---- */
#include <dos.h>
extern int far pascal NAME_VALIDATE(char far *);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned int far pascal MACRO_DEFINE(char far *,char far *,signed char,unsigned int);
/* #define.  Reads the macro name (refusing the predefined names), an
   optional parameter list in parentheses (names collected in POOL_A from
   start, duplicates reported) and the body with LEX_READ, which turns each
   parameter into the byte 0x80 + its number.  parameters stays -1 for an
   object-like macro.  Checks that # is followed by a parameter and that
   ## is not at either end of the body, appends byte 251 (0xFB, probably a
   separator so an expansion always ends a token), and stores the macro
   with MACRO_DEFINE (MACROS.C).  POOL_A is released afterwards. */
static void near pascal BCC_PARSE_MACRO(int input)
{
    unsigned int start;
    int parameters;
    char far *text;
    char far *end;
    char name[34];
    register int value=input;
    register unsigned int parameter;
    if(!(_CTYPE[value+1]&12) && value!=95) {
        REPORT_ERROR(MSG_DEFINE_DIRECTIVE_NEEDS);
        SCAN_FINISH(value);
        return;
    }
    value=SCAN_TOKEN(value);
    if(NAME_VALIDATE(NAME_BUFFER)) REPORT_ERROR(MSG_DEFINE_DIRECTIVE_NEEDS);
    STRING_COPY(name,NAME_BUFFER);
    parameters=-1;
    start=POOL_ALLOC(&POOL_A,0);
    if(value!=40) {
        --INPUT_INDEX;
        LEX_READ(0,0);
        goto trim;
    }
    parameters=0;
    value=SCAN_NEXT(32);
    if(value==41) {
        LEX_READ(0,0);
        goto trim;
    }
    for(;;) {
        if(!(_CTYPE[value+1]&12) && value!=95) {
            REPORT_ERROR(MSG_MACRO_ARGUMENT_SYNTAX);
            SCAN_FINISH(value);
            return;
        }
        value=SCAN_TOKEN(value);
        for(parameter=start;parameter<POOL_A_UNIT;parameter+=STRING_LENGTH(MK_FP(POOL_A,parameter))+1) {
            if(COMPARE_NAME(MK_FP(POOL_A,parameter),NAME_BUFFER)==0) {
                REPORT_ERROR(MSG_MULTIPLE_DECLARATION,(char far *)NAME_BUFFER);
                break;
            }
        }
        parameter=POOL_ALLOC(&POOL_A,STRING_LENGTH(NAME_BUFFER)+1);
        STRING_COPY(MK_FP(POOL_A,parameter),NAME_BUFFER);
        ++parameters;
        value=SCAN_NEXT(value);
        if(value==41) break;
        if(value!=44) {
            REPORT_ERROR(MSG_INVALID_MACRO_ARGUMENT);
            SCAN_FINISH(value);
            return;
        }
        value=SCAN_NEXT(32);
    }
    value=SCAN_NEXT(32);
    --INPUT_INDEX;
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    *TOKEN_PTR=0;
    parameter=POOL_ALLOC(&POOL_A,1);
    *(char far *)MK_FP(POOL_A,parameter)=0;
    LEX_READ(start,0);
    for(text=(char far *)TOKEN_TEXT_BUFFER;*text;++text) {
        if(*text==-3 && ((text[1]&128)==0 || (unsigned char)text[1]>=251)) {
            REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)"define");
            break;
        }
    }
trim:
    text=(char far *)TOKEN_TRIM();
    end=text+STRING_LENGTH((char far *)text);
    if(text+1<end && end[-1]==-2)
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)"define");
    else if(*text==-2)
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)"define");
    *end=251;
    ++end;
    *end=0;
    MACRO_DEFINE(name,(char far *)text,(signed char)parameters,start);
    POOL_A_USED=0;
    POOL_A_UNIT=start;
}

/* ---- PARSE_UNDEF (CPP 0A35:06A1) ---- */
extern void far MACRO_REMOVE(char far *name);

/* #undef name (the predefined names cannot be undefined). */
static void near pascal PARSE_UNDEF(int value)
{
    if (!((int)_CTYPE[value + 1] & 12) && value != 95) {
        REPORT_ERROR(MSG_BAD_UNDEF_DIRECTIVE);
        SCAN_FINISH(value);
    } else {
        CHECK_DIRECTIVE_END(SCAN_TOKEN(value));
        if (NAME_VALIDATE((char far *)NAME_BUFFER) != 0)
            REPORT_ERROR(MSG_BAD_UNDEF_DIRECTIVE);
        MACRO_REMOVE((char far *)NAME_BUFFER);
    }
}

/* ---- SAVE_LINE_MARKER (CPP 0A35:06F8) ---- */
#include <dos.h>


/* Pushes a conditional record: state value (1 a branch is being compiled,
   2 inside the #else part) and the current line. */
static void near pascal SAVE_LINE_MARKER(int value)
{
    unsigned int offset;

    offset = POOL_ALLOC(&LINE_POOL, 4);
    ((int far *)MK_FP(LINE_POOL, offset))[0] = value;
    ((int far *)MK_FP(LINE_POOL, offset))[1] = CURRENT_LINE;
    LINE_RECORD = offset + 4;
}

/* ---- PARSE_CONDITIONAL (CPP 0A35:072A) ---- */
/* CPP.EXE edit: #if and #elif call EVAL_CONSTANT_CONDITION (CPPIFEXP.C, CPP 0B39:000D) directly
   with a far call; BCC calls through the pointer EVAL_EXPRESSION. */
extern int far pascal EVAL_CONSTANT_CONDITION(void);
static void near CONDITIONAL_SCAN();
static void near SAVE_LINE_MARKER(int value);
extern unsigned long  TOKEN_CONST_VALUE;

/* #if.  If the expression is valid and nonzero the group is compiled
   (state 1).  Otherwise its lines are skipped up to a true #elif (then
   that group is compiled, state 1), an #else (state 2), or the #endif
   (nothing is pushed: the whole conditional is done). */
static void near pascal PARSE_CONDITIONAL(int value)
{
    INPUT_INDEX--;
    value = EVAL_CONSTANT_CONDITION();
    INPUT_INDEX--;
    if (value != 0 && TOKEN_CONST_VALUE != 0L) {
        SAVE_LINE_MARKER(1);
        return;
    }
    CONDITIONAL_SCAN(1, 0);
    if (DIRECTIVE_MODE == 8)
        SAVE_LINE_MARKER(2);
    else if (DIRECTIVE_MODE == 10)
        SAVE_LINE_MARKER(1);
}

/* ---- PARSE_IFDEF (CPP 0A35:0778) ---- */
extern int far MACRO_DEFINED(char far *name);

/* #ifdef (expected 1) and #ifndef (expected 0): like PARSE_CONDITIONAL,
   with "is the name a macro" as the condition.  A missing name is an
   error and the group is then compiled. */
static void near pascal PARSE_IFDEF(register int value, register int expected)
{
    if (!((int)_CTYPE[value + 1] & 12) && value != 95) {
        REPORT_ERROR(expected != 0 ? MSG_BAD_IFDEF_DIRECTIVE : MSG_BAD_IFNDEF_DIRECTIVE);
        SCAN_FINISH(value);
        SAVE_LINE_MARKER(1);
        return;
    }
    CHECK_DIRECTIVE_END(SCAN_TOKEN(value));
    if (MACRO_DEFINED((char far *)NAME_BUFFER) == expected) {
        SAVE_LINE_MARKER(1);
        return;
    }
    CONDITIONAL_SCAN(1, 0);
    if (DIRECTIVE_MODE == 8) {
        SAVE_LINE_MARKER(2);
        return;
    }
    if (DIRECTIVE_MODE != 10)
        return;
    SAVE_LINE_MARKER(1);
}

/* ---- PARSE_IFDEF_DIRECTIVE (CPP 0A35:07EF) ---- */
static void near PARSE_IFDEF();
/* The #ifdef handler. */
static void near pascal PARSE_IFDEF_DIRECTIVE(int value)
{
    PARSE_IFDEF(value, 1);
}

/* ---- PARSE_IFNDEF_DIRECTIVE (CPP 0A35:0800) ---- */
/* The #ifndef handler. */
static void near pascal PARSE_IFNDEF_DIRECTIVE(int value)
{
    PARSE_IFDEF(value, 0);
}

/* ---- PARSE_ELSE (CPP 0A35:0810) ---- */
#include <dos.h>


/* #else met while compiling a taken branch (state 1): skips to the
   matching #endif and pops the record.  Anywhere else it is misplaced.
   CONDITION_STATE and CONDITION_MARK were probably for BCC's precompiled
   header code (to know where the conditional stack stands); CPP.EXE has no
   precompiled headers. */
static void near pascal PARSE_ELSE(int value)
{
    if (LINE_RECORD != 0 &&
            ((int far *)MK_FP(LINE_POOL, (int near *)LINE_RECORD - 2))[0] == 1) {
        CHECK_DIRECTIVE_END(value);
        CONDITIONAL_SCAN(0, 0);
        LINE_RECORD -= 4;
        CONDITION_STATE = 0;
        CONDITION_MARK = LINE_RECORD;
    } else {
        SCAN_FINISH(value);
        REPORT_ERROR(MSG_MISPLACED_ELSE);
    }
}

/* ---- PARSE_ELIF (CPP 0A35:085E) ---- */
#include <dos.h>


/* #elif met while compiling a taken branch: every later group is skipped,
   up to the matching #endif, and the record is popped. */
static void near pascal PARSE_ELIF(int value)
{
    if (LINE_RECORD != 0 &&
            ((int far *)MK_FP(LINE_POOL, (int near *)LINE_RECORD - 2))[0] == 1) {
        SCAN_FINISH(value);
        do
            CONDITIONAL_SCAN(1, 1);
        while (DIRECTIVE_MODE == 10 || DIRECTIVE_MODE == 8);
        LINE_RECORD -= 4;
        CONDITION_STATE = 0;
        CONDITION_MARK = LINE_RECORD;
    } else {
        SCAN_FINISH(value);
        REPORT_ERROR(MSG_MISPLACED_ELIF);
    }
}

/* ---- PARSE_ENDIF (CPP 0A35:08BB) ---- */
/* #endif: pops the innermost conditional record. */
static void near pascal PARSE_ENDIF(int value)
{
    if (LINE_RECORD != 0) {
        LINE_RECORD -= 4;
        CONDITION_STATE = 0;
        CONDITION_MARK = LINE_RECORD;
    } else {
        REPORT_ERROR(MSG_MISPLACED_ENDIF);
    }
    CHECK_DIRECTIVE_END(value);
}

/* ---- BCC_PARSE_LINE (CPP 0A35:08EC) ---- */
#include <dos.h>
extern unsigned int STRING_POOL_SEG;
/* #line number ["file"]: the line is read with macros expanded.  The next
   line will be number; the file name, if given and different, becomes
   CURRENT_FILE_NAME. */
static void near pascal BCC_PARSE_LINE(int input)
{
    int line;
    register char near *text;
    register char near *end;
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    --INPUT_INDEX;
    LEX_READ(0,1);
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    text=TOKEN_TRIM();
    line=0;
    if(!(_CTYPE[*text+1]&2)) {
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)"line");
        return;
    }
    while(_CTYPE[*text+1]&2) {
        line=line*10+*text-48;
        ++text;
    }
    while(*text==32) ++text;
    if(*text!=0) {
        end=text+STRING_LENGTH(text)-1;
        if(*text!=34 || *end!=34) {
            REPORT_ERROR(MSG_BAD_FILE_NAME_FORMAT);
            return;
        }
        ++text;
        *end=0;
        if(STRING_COMPARE(MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME),text)!=0) {
            CURRENT_FILE_NAME=POOL_ALLOC(&STRING_POOL_SEG,STRING_LENGTH(text)+1);
            STRING_COPY(MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME),text);
        }
    }
    LOGICAL_LINE=CURRENT_LINE=line-1;
}

/* ---- SCAN_TOKEN (CPP 0A35:09E0) ---- */
#include <dos.h>

extern char  NAME_LIMIT;

/* Reads a name that starts with value into NAME_BUFFER (letters, digits,
   '_', cut to NAME_LIMIT characters) and returns the first character after
   it. */
int far pascal SCAN_TOKEN(int value)
{
    char far *p;

    p = NAME_BUFFER;
    while ((_CTYPE[value + 1] & 14) || value == 95) {
        if (p < (char far *)(NAME_BUFFER + NAME_LIMIT))
            *p++ = value;
        value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    }
    *p = 0;
    return value;
}

/* ---- CONDITIONAL_SCAN (CPP 0A35:0A4E) ---- */
#include <dos.h>

extern void far pascal DIRECTIVE_START(unsigned int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* Skips the lines of a group that is not compiled, looking only at
   directive lines.  depth counts nested conditionals.  At depth 0:
   #endif ends the scan; #else ends it too unless skip is set (then
   another #else is misplaced); #elif, unless skip is set, has its
   expression evaluated and ends the scan if it is true.  allowed 0 means
   an #else or #elif here is misplaced.  The directive that ended the scan
   is left in DIRECTIVE_MODE.  End of input inside the group is an error
   naming the line where the scan began. */
static void near pascal CONDITIONAL_SCAN(int allowed,unsigned int skip)
{
    int value,line;
    register int enabled=allowed;
    register int depth;
    line=CURRENT_LINE;
    depth=0;
    for(;;) {
        value=SCAN_NEXT(GETBYTE);
        if(value==26) {
            REPORT_ERROR(MSG_UNEXPECTED_END_FILE_42,line);
            return;
        }
        if(value=='#') {
            DIRECTIVE_START(0);
            if(DIRECTIVE_MODE==7 || DIRECTIVE_MODE==4 || DIRECTIVE_MODE==5) ++depth;
            else if(DIRECTIVE_MODE==6) --depth;
            else if(DIRECTIVE_MODE==8 && depth==0) {
                if(enabled) {
                    if(!skip) --depth;
                    else enabled=0;
                } else REPORT_ERROR(MSG_MISPLACED_ELSE);
            } else if(DIRECTIVE_MODE==10 && depth==0) {
                if(!enabled) REPORT_ERROR(MSG_MISPLACED_ELIF);
                else if(!skip) {
                    --INPUT_INDEX;
                    if(!EVAL_CONSTANT_CONDITION()) continue;
                    if(TOKEN_CONST_VALUE!=0L) break;
                    continue;
                }
            }
            value=GETBYTE;
        }
        SCAN_FINISH(value);
        value=GETBYTE;
        if(depth<0) break;
        if(value==10 || value==13) LEX_NEWLINE((char)value);
    }
    --INPUT_INDEX;
}
#undef GETBYTE

/* ---- SCAN_WRITE (CPP 0A35:0BB9) ---- */
extern char  TOKEN_LIMIT;

/* Appends a byte to the token text buffer unchanged (used for marker
   bytes) and keeps the text zero-terminated. */
void far pascal SCAN_WRITE(char value)
{
    if (TOKEN_PTR < &TOKEN_LIMIT)
        *TOKEN_PTR++ = value;
    *TOKEN_PTR = 0;
}

/* ---- SCAN_EMIT_FAR (CPP 0A35:0BDC) ---- */

/* Appends a text character to the token text buffer.  A character with
   the high bit set (except 0xFB) is preceded by 0xFF so it cannot be taken
   for a marker byte.  Characters past EMIT_LIMIT are dropped. */
void far pascal SCAN_EMIT_FAR(char value)
{
    if (TOKEN_PTR < &EMIT_LIMIT) {
        if ((value & 128) && value != -5)
            *TOKEN_PTR++ = -1;
        *TOKEN_PTR++ = value;
    }
    *TOKEN_PTR = 0;
}

/* ---- SCAN_NEXT (CPP 0A35:0C16) ---- */
#include <dos.h>

extern void far pascal COMMENT_BLOCK(void);
extern void far pascal COMMENT_LINE(void);

/* Skips blanks, comments and line splices starting at character value and
   returns the first other character (it has been consumed).  A '/' or a
   backslash that does not start a comment or splice is returned as itself. */
int far pascal SCAN_NEXT(volatile int value)
{
    for (;;) {
        if (value == 47) {
            value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
            if (value == 42) {
                COMMENT_BLOCK();
            } else {
                if (LANGUAGE_MODE != 1 && value == 47) {
                    COMMENT_LINE();
                } else {
                    INPUT_INDEX--;
                    return 47;
                }
            }
        } else if (value == 92) {
            value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
            if (CHAR_CLASS[value + 1] == -20) {
                LEX_NEWLINE(value);
            } else {
                INPUT_INDEX--;
                return 92;
            }
        } else if (CHAR_CLASS[value + 1] != -9) {
            goto return_character;
        }
        value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    }
return_character:
    return value;
}

/* ==== From BCC's preproc/DIRTAIL.C ==== */
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* value is the first character after the directive's arguments. */
static void near pascal CHECK_DIRECTIVE_END(int value)
{
    for(;;) {
        switch(value) {
        case 10:case 13:
            --INPUT_INDEX;
            return;
        case 26:
            return;
        case '/':
            value=GETBYTE;
            if(value=='*') COMMENT_BLOCK();
            else if(LANGUAGE_MODE!=1 && value=='/') COMMENT_LINE();
            else --INPUT_INDEX;
            break;
        case '\\':
            value=GETBYTE;
            if(value==10 || value==13) LEX_NEWLINE((char)value);
            break;
        case 9:case 32:
            break;
        default:
            if(LANGUAGE_MODE==1) REPORT_ERROR(MSG_ILLEGAL_CHARACTER_0X,value,value);
            SCAN_FINISH(value);
            return;
        }
        value=GETBYTE;
    }
}
#undef GETBYTE

/* ==== From BCC's preproc/SKIPLINE.C ==== */
extern int far pascal COPY_STRING_LITERAL(signed char,void (far pascal *)(int),unsigned int);
void far pascal SCAN_EMPTY(int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* value: the first character of the rest of the line. */
/* CPP.EXE edit: this is BCC's BCC_SCAN_FINISH_FAR (SKIPLINE.C) as the near static
   SCAN_FINISH that the directive handlers call.  The string reader is passed SCAN_EMPTY
   (pushed as the constant CPP 0A35:1046) where BCC passes SCAN_EMPTY. */
static void near pascal SCAN_FINISH(int value)
{
    for(;;) {
        switch(value) {
        case 10:case 13:
            --INPUT_INDEX;
            return;
        case '/':
            value=GETBYTE;
            if(value=='*') COMMENT_BLOCK();
            else if(LANGUAGE_MODE!=1 && value=='/') COMMENT_LINE();
            else --INPUT_INDEX;
            break;
        case '\\':
            value=GETBYTE;
            if(value==10 || value==13) LEX_NEWLINE((char)value);
            break;
        case '"':case '\'':
            if(!COPY_STRING_LITERAL((signed char)value,SCAN_EMPTY,0)) return;
            break;
        case 26:
            return;
        }
        value=GETBYTE;
    }
}
#undef GETBYTE

/* ==== From BCC's lexer/COMMENT.C ==== */
/* COMMENT_BLOCK and COMMENT_LINE skip a comment in the input buffer.  Both
   are hand-written assembly inside this C file (the compiler supplies only
   the frame and the SI/DI saves).  The file went through TASM (-B): the
   jmp short + nop before refill_scan (the jump to done) is TASM's.  While
   scanning, DS points at the input buffer's segment and ES at DGROUP.  BX
   holds the line the comment started on, and in COMMENT_BLOCK CX counts
   nested comment levels.  Error 41 is "Unexpected end of file in comment
   started on line %d" (the message table, MSG.H), so BX is pushed as its
   argument. */
/* Skips a block comment.  Called after the opening delimiter; returns with
   INPUT_INDEX just past the closing one.  A "/" followed by "*" inside the
   comment raises the nesting count CX only if COMMENT_NESTED is set; each
   closing delimiter lowers it, and the comment ends when it goes below
   zero. */
void far pascal COMMENT_BLOCK(void)
{
    asm mov bx,word ptr DGROUP:CURRENT_LINE;
    asm xor cx,cx;
reload:
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
scan:
    asm cmp si,dx;
    asm jnc refill_scan;
    asm lodsb;
character:
    asm cmp al,'*';
    asm je possible_end;
    asm cmp al,'/';
    asm je possible_nested;
    asm cmp al,26;
    asm je unexpected_eof;
    asm cmp al,13;
    asm je newline;
    asm cmp al,10;
    asm jne scan;
newline:
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm push bx;
    asm push cx;
    asm cbw;
    asm push ax;
    asm call far ptr LEX_NEWLINE;
    asm pop cx;
    asm pop bx;
    asm jmp reload;
possible_end:
    asm cmp si,dx;
    asm jnc refill_end;
    asm lodsb;
end_character:
    asm cmp al,'/';
    asm jne character;
    asm dec cx;
    asm jge scan;
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm jmp done;
refill_scan:
    asm call refill_sub;
    asm jmp character;
refill_end:
    asm call refill_sub;
    asm jmp end_character;
refill_nested:
    asm call refill_sub;
    asm jmp nested_character;
possible_nested:
    asm cmp byte ptr es:[offset DGROUP:COMMENT_NESTED],0;
    asm je scan;
    asm cmp si,dx;
    asm jnc refill_nested;
    asm lodsb;
nested_character:
    asm cmp al,'*';
    asm jne character;
    asm inc cx;
    asm jmp scan;
    /* refill_sub names the subroutine for the near calls above: BCC maps
       C labels only in jump instructions, so a call needs an asm label. */
    asm refill_sub label near;
    /* near subroutine: save the position, refill, reload the registers */
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm push bx;
    asm push cx;
    asm call far ptr INPUT_REFILL;
    asm pop cx;
    asm pop bx;
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
    asm retn;
unexpected_eof:
    asm push es;
    asm pop ds;
    asm push bx;
    asm mov ax,41;
    asm push ax;
    asm call far ptr REPORT_ERROR;
    asm pop cx;
    asm pop cx;
done:
    ;
}

/* ---- COMMENT_LINE (CPP 0A35:0FE0) ---- */
/* Skips a line comment (two slashes) up to, but not including, the line end. */
void far pascal COMMENT_LINE(void)
{
    asm mov bx,word ptr DGROUP:CURRENT_LINE;
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
scan:
    asm cmp si,dx;
    asm jnc refill;
    asm lodsb;
character:
    asm cmp al,26;
    asm je unexpected_eof;
    asm cmp al,13;
    asm je newline;
    asm cmp al,10;
    asm jne scan;
newline:
    /* leave the newline in the buffer for the caller */
    asm push es;
    asm pop ds;
    asm dec si;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm jmp short done;
refill:
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm push bx;
    asm call far ptr INPUT_REFILL;
    asm pop bx;
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
    asm jmp character;
unexpected_eof:
    asm push es;
    asm pop ds;
    asm push bx;
    asm mov ax,41;
    asm push ax;
    asm call far ptr REPORT_ERROR;
    asm pop cx;
    asm pop cx;
done:
    ;
}

/* ---- SCAN_EMPTY (CPP 0A35:1046) ---- */
/* Does nothing; value is ignored.  Probably installed where a scanner
   hook must be called but no work is needed. */
void far pascal SCAN_EMPTY(int value)
{
}

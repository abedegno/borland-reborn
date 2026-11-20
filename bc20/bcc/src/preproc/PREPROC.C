/* target: ovr105_C130UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: preprocessor directives and #pragma handlers (PRAGMA_*). Entry points:
   REPORT_PRAGMA_ERROR, DIRECTIVE_START, TOKEN_TRIM, SCAN_TOKEN, SCAN_WRITE, SCAN_EMIT_FAR,
   SCAN_NEXT. Map of all sources: docs/SOURCE-MAP.md. */
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
   PARSE_ERROR_DIRECTIVE (#error) and PARSE_PRAGMA (#pragma,
   which dispatches again through PRAGMA_TABLE to the PRAGMA_* handlers,
   CHECK_NAME_CONTEXT and PRAGMA_CODESEG).
   Conditional compilation: each open #if group has a 4-byte record in
   LINE_POOL (a state word, then the line of the #if); LINE_RECORD points
   just past the innermost record (0 when none is open).  State 1 means
   the lines being compiled belong to a taken branch, so a later #elif or
   #else starts lines to skip; state 2 means the #else has been seen.
   Skipped lines are passed over by CONDITIONAL_SCAN, which only looks at
   directives to track nesting and stops at the matching #elif, #else or
   #endif.  DIRECTIVE_MODE tells it which directive it found, by the code
   in DIRECTIVE_TABLE: 4, 5 and 7 open a group (#ifdef, #ifndef, #if),
   6 is #endif, 8 #else and 10 #elif (read from how the codes are used).
   The #if expression is evaluated through EVAL_EXPRESSION, a pointer to
   the front end's evaluator (EVAL_CONSTANT_CONDITION in CPPIFEXP.C for the
   C++ front end), which leaves the value in TOKEN_CONST_VALUE.
   Text is collected in the token text buffer (TOKEN_PTR, in the buffer
   named TOKEN_TEXT_BUFFER); names go to NAME_BUFFER.  Many #pragma settings made
   inside an included file are also saved (SAVE_OPTION_STRING,
   SAVE_WARNING_SWITCH in PCH.C) so they can be replayed when a
   precompiled header is loaded. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"

/* ---- LG091 (listing CC30) ---- */
extern signed char  LANGUAGE_MODE;
/* Reports an error in a #pragma, except in strict ANSI mode (LANGUAGE_MODE
   1), where unknown or malformed pragmas are silently ignored. */
void far pascal REPORT_PRAGMA_ERROR(unsigned int error,char far *name)
{
    if(LANGUAGE_MODE!=1) REPORT_ERROR(error,name);
}

/* ---- LEXTOKEN (listing CC4F) ---- */
#include <dos.h>
struct Keyword { char near *name; signed char token; void (near pascal *function)(int); };
extern struct Keyword  DIRECTIVE_TABLE[];
extern char _CTYPE[];
extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
extern int far pascal SCAN_NEXT(volatile int);
extern void far pascal SCAN_FINISH(int);
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

/* ---- LEXQUAL (listing CD6A) ---- */
#include <dos.h>
extern int far pascal SCAN_TOKEN(int);
extern void far pascal REPORT_PRAGMA_ERROR(unsigned int,char far *);
extern void far pascal SAVE_WARNING_SWITCH(char far *,unsigned char);
/* #pragma warn +xxx, -xxx or .xxx: turns the warning with the
   three-letter name on, off, or back to its default (the fourth byte of
   its WARNING_SWITCH_TABLE entry).  input is the first character after
   "warn"; the return value is the character after the pragma, like every
   PRAGMA_* handler.  Note that entry is never null after the table loop,
   so an unknown warning name is silently ignored. */
static int near pascal PRAGMA_WARN(int input)
{
    int prefix;
    unsigned char far *entry;
    unsigned int index;
    register int value=input;
    if(value!='-' && value!='+' && value!='.') goto invalid;
    prefix=value;
    value=SCAN_NEXT(32);
    if(!(_CTYPE[value+1]&12)) goto invalid;
    value=SCAN_TOKEN(value);
    for(index=0,entry=WARNING_SWITCH_TABLE;*entry;entry+=4,++index) {
        if(entry[0]==NAME_BUFFER[0] && entry[1]==NAME_BUFFER[1] && entry[2]==NAME_BUFFER[2]) {
            if(prefix=='.') WARNING_SWITCH_STATE[index]=entry[3];
            else if(prefix=='+') WARNING_SWITCH_STATE[index]=1;
            else WARNING_SWITCH_STATE[index]=0;
        }
    }
    if(*(unsigned int far *)MK_FP(CONTEXT_SEG,CONTEXT_PTR+CTX_PREV)) SAVE_WARNING_SWITCH(NAME_BUFFER,(unsigned char)prefix);
    if(!entry) {
invalid:
        REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR,STR_PRAGMA);
    }
    return value;
}

/* ---- LEXCHECK (listing CE44) ---- */
#include <dos.h>

extern void far CONTEXT_DIAGNOSTIC(void);
extern void far MODE_FALLBACK(int mode);
extern char  COMPILER_MODE;

/* Probably the #pragma inline handler: inline assembly needs the compile
   to go through the assembler, so unless that is already the case
   (COMPILER_MODE) the compile is abandoned with MODE_FALLBACK(3) and
   restarted that way (see COMPILE_ONE_FILE in OPTIONS.C).  In an included
   file it also marks the precompiled header as unusable
   (CONTEXT_DIAGNOSTIC sets PCH_DIAGNOSTIC_ISSUED). */
static int near pascal CHECK_NAME_CONTEXT(int value)
{
    if (((int far *)MK_FP(CONTEXT_SEG, (int near *)CONTEXT_PTR + CTX_PREV_WORD_INDEX))[0] != 0)
        CONTEXT_DIAGNOSTIC();
    if (!(int)COMPILER_MODE)
        MODE_FALLBACK(3);
    return value;
}

/* ---- PARSE_STARTUP_EXIT (listing CE75) ---- */
#include <dos.h>
extern int (far pascal *PRAGMA_FUNC_LOOKUP_HOOK)(int);
extern void far pascal ADD_STARTUP_ENTRY(unsigned int,unsigned int);
extern void far pascal ADD_EXIT_ENTRY(unsigned int,unsigned int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* #pragma startup name [priority] (mode 0) or #pragma exit (mode 1).  The
   function is looked up through PRAGMA_FUNC_LOOKUP_HOOK (FIND_NAMED_FUNCTION
   or FIND_NAMED_FUNCTION_PREPARED, by front end), which returns -1 if the
   name is undefined (already reported), 0 if it is not a suitable
   function, or the symbol.  The priority defaults to 100.  The entry is
   added to the startup or exit table. */
static int near pascal PARSE_STARTUP_EXIT(int input,unsigned int mode)
{
    int found;
    register int value=input;
    register int number;

    if(!(_CTYPE[value+1]&12) && value!='_') {
        REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR,STR_MISSING_FUNCTION);
    } else {
        value=SCAN_TOKEN(value);
        found=PRAGMA_FUNC_LOOKUP_HOOK(0);
        if(found!=-1) {
            if(found) {
                value=SCAN_NEXT(value);
                if(_CTYPE[value+1]&2) {
                    number=0;
                    while(_CTYPE[value+1]&2) {
                        number=number*10+value-'0';
                        value=GETBYTE;
                    }
                    value=SCAN_NEXT(value);
                } else number=100;
                if(value!=10 && value!=13 && value!=26) {
                    REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR,STR_PRAGMA);
                } else {
                    if(mode) ADD_EXIT_ENTRY(found,number);
                    else ADD_STARTUP_ENTRY(found,number);
                    return value;
                }
            } else REPORT_PRAGMA_ERROR(MSG_NOT_ALLOWED_TYPE,(char far *)0);
        }
    }
    return value;
}
#undef GETBYTE

/* ---- RCF6D (listing CF6D) ---- */
static int near pascal PRAGMA_STARTUP(int input)
{
    return PARSE_STARTUP_EXIT(input,0);
}

/* ---- RCF7F (listing CF7F) ---- */
static int near pascal PRAGMA_EXIT(int input)
{
    return PARSE_STARTUP_EXIT(input,1);
}

/* ---- PRAGMA_SAVEREGS (listing CF92) ---- */
extern char  PRAGMA_SAVEREGS_PENDING;

/* #pragma saveregs: the next function gets the _saveregs treatment. */
static int near pascal PRAGMA_SAVEREGS(int value)
{
    PRAGMA_SAVEREGS_PENDING=1;
    return value;
}

/* ---- PRAGMA_OPTION (listing CFA3) ---- */
#include <dos.h>
extern char *TOKEN_PTR;
extern char  CHAR_CLASS[];
extern void far pascal SCAN_EMIT_FAR(char);
extern int far pascal APPLY_OPTION(char far *,int);
extern void far pascal SAVE_OPTION_STRING(char far *);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* #pragma option -x -y ...: applies each blank-separated command-line
   option with APPLY_OPTION (the leading '-' is skipped); a bad option is
   an error unless in strict ANSI mode.  In an included file the option is
   also saved for the precompiled header. */
static int near pascal PRAGMA_OPTION(int value)
{
    while(value!=26 && value!=10 && value!=13) {
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        while(CHAR_CLASS[value+1]!=(char)0xF7 && value!=26 && value!=10 && value!=13) {
            SCAN_EMIT_FAR((char)value);
            value=GETBYTE;
        }
        if(!APPLY_OPTION(TOKEN_TEXT_BUFFER+1,1) && LANGUAGE_MODE!=1)
            REPORT_ERROR(MSG_INCORRECT_OPTION,(char far *)STR_PRAGMA_DIRECTIVE,(char far *)TOKEN_TEXT_BUFFER);
        if(((int far *)MK_FP(CONTEXT_SEG,(int near *)CONTEXT_PTR+CTX_PREV_WORD_INDEX))[0]!=0)
            SAVE_OPTION_STRING(TOKEN_TEXT_BUFFER+1);
        value=SCAN_NEXT(value);
    }
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    return value;
}
#undef GETBYTE

/* ---- PRAGMA_ARGSUSED (listing D073) ---- */
extern char  PRAGMA_ARGSUSED_PENDING;

/* #pragma argsused: no "parameter never used" warnings for the next
   function. */
static int near pascal PRAGMA_ARGSUSED(int value)
{
    PRAGMA_ARGSUSED_PENDING=1;
    return value;
}

/* ---- PRAGMA_NORETVAL (listing D084) ---- */
extern char  PRAGMA_NORETVAL_PENDING;

/* Sets PRAGMA_NORETVAL_PENDING, probably to suppress the "function should
   return a value" warning for the next function. */
static int near pascal PRAGMA_NORETVAL(int value)
{
    PRAGMA_NORETVAL_PENDING=1;
    return value;
}

/* ---- LEXALNUM (listing D095) ---- */
#include <dos.h>


/* Copies a run of letters, digits and '_' that starts with value into the
   token text buffer; returns the first other character. */
static int far pascal SCAN_ALNUM(int value)
{
    while ((_CTYPE[value + 1] & 14) || value == 95) {
        SCAN_EMIT_FAR(value);
        value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    }
    return value;
}

/* ---- LEXDECL (listing D0E0) ---- */
#include <dos.h>
extern char PRAGMA_CODESEG_SEEN,OPTION_WINDOWS_MODE;
extern unsigned int CODE_SEGMENT_ID;
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern unsigned int far pascal BCC_INTERN_STRING(char far *);
extern unsigned int far pascal DEFINE_SEGMENT(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CLONE_NODE_KEEP_SERIAL(unsigned int);
#define GETBYTE ((unsigned char)(INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++]))
/* The handler of #pragma codeseg [name [group]
   ["class"]]: makes the named segment (names upper-cased; class defaults to
   CODE_CLASS_NAME) the code segment for the following functions, or with
   no arguments goes back to the default code segment.  Starts the back end
   first, since segments are defined there.  Malformed forms only warn. */
static int near pascal PRAGMA_CODESEG(int input)
{
    unsigned int name;
    unsigned int extra;
    register int value=input;
    register unsigned int quoted;
    BEGIN_BACKEND_OUTPUT_HOOK();
    PRAGMA_CODESEG_SEEN=1;
    extra=0;
    quoted=0;
    value=SCAN_NEXT(value);
    if(value==10 || value==13 || value==26) {
        CODE_SEGMENT_ID=DEFAULT_CODE_SEGMENT_ID;
        goto parse_error;
    }
    if((_CTYPE[value+1]&14)==0 && value!=95) goto invalid_identifier;
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    value=SCAN_ALNUM(value);
    RTL_STRUPR(TOKEN_TEXT_BUFFER);
    name=BCC_INTERN_STRING(TOKEN_TEXT_BUFFER);
    for(;;) {
        value=SCAN_NEXT(value);
        if((_CTYPE[value+1]&14)!=0 || value==95) {
            if(extra) REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
            TOKEN_PTR=TOKEN_TEXT_BUFFER;
            value=SCAN_ALNUM(value);
            RTL_STRUPR(TOKEN_TEXT_BUFFER);
            extra=BCC_INTERN_STRING(TOKEN_TEXT_BUFFER);
        } else if(value==34) {
            if(quoted) REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
            value=GETBYTE;
            TOKEN_PTR=TOKEN_TEXT_BUFFER;
            value=SCAN_ALNUM(value);
            RTL_STRUPR(TOKEN_TEXT_BUFFER);
            quoted=BCC_INTERN_STRING(TOKEN_TEXT_BUFFER);
            if(value==34) value=GETBYTE;
            else {
                REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
                goto finish;
            }
        } else break;
    }
    if(value!=10 && value!=13 && value!=26) {
        REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
        goto finish;
    }
    if(!quoted) quoted=CODE_CLASS_NAME;
    CODE_SEGMENT_ID=DEFINE_SEGMENT(OPTION_WINDOWS_MODE?2:1,name,extra,quoted);
    goto parse_error;
invalid_identifier:
    REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
    goto finish;
parse_error:
    CLONE_NODE_KEEP_SERIAL(LEX_FILE_SERIAL_NODE);
    goto finish;
finish:
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    return value;
}
#undef GETBYTE

/* ---- LEXDISP (listing D284) ---- */
struct Handler { int (near pascal *function)(int); char near *name; };
extern struct Handler  PRAGMA_TABLE[];
/* The #pragma handler: reads the pragma name and calls its handler from
   PRAGMA_TABLE; unknown pragmas are ignored.  The rest of the line is then
   skipped. */
static void near pascal PARSE_PRAGMA(register int value)
{
    struct Handler far *entry;
    if(_CTYPE[value+1]&12) {
        value=SCAN_NEXT(SCAN_TOKEN(value));
        entry=PRAGMA_TABLE;
        while(entry->name!=0) {
            if(COMPARE_NAME(NAME_BUFFER,entry->name)==0) {
                value=entry->function(value);
                break;
            }
            entry++;
        }
    }
    SCAN_FINISH(value);
}

/* ---- LEXSTR (listing D2EB) ---- */
#include <dos.h>

extern void far LEX_NEWLINE(char value);

/* The #error handler: collects the rest of the line
   (with line splices joined) and stops the compile with a fatal error
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

/* ---- LEXFILE (listing D3CA) ---- */
#include <dos.h>
extern char far *INCLUDE_OPTION_TEXT_PTR;
extern void near pascal CHECK_DIRECTIVE_END(int);
extern void far pascal LEX_READ(int,int);
extern char * far pascal TOKEN_TRIM(void);
extern unsigned int far pascal OPEN_SOURCE_FILE(char far *);
extern int far pascal OPEN_INCLUDE_FILE(char far *);
extern void far pascal RECORD_SOURCE_NAME(void);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* #include "file" or <file>, or #include NAME where the macro NAME expands
   to one of those (read with LEX_READ mode 1).  A "file" name, or a name
   with a drive or a leading slash, or any name when no -I directories are
   given, is first tried as it stands; otherwise, or if that fails, the
   include directories are searched (OPEN_INCLUDE_FILE).  The opened file
   becomes the new top input context, and its name is recorded for the
   dependency list. */
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
        if(OPEN_SOURCE_FILE(path)) {
            RECORD_SOURCE_NAME();
            return;
        }
    }
    if(!OPEN_INCLUDE_FILE(path)) REPORT_ERROR(MSG_UNABLE_OPEN_INCLUDE,(char far *)path);
    RECORD_SOURCE_NAME();
}
#undef GETBYTE

/* ---- LEXTRIM (listing D55B) ---- */
/* Strips trailing blanks, tabs and 0xFB separators from the text in the
   token buffer (TOKEN_TEXT_BUFFER) and returns a pointer past its leading blanks. */
char *far pascal TOKEN_TRIM(void)
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

/* ---- LEXMACRO (listing D5AA) ---- */
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
            REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)STR_DEFINE);
            break;
        }
    }
trim:
    text=(char far *)TOKEN_TRIM();
    end=text+STRING_LENGTH((char far *)text);
    if(text+1<end && end[-1]==-2)
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)STR_DEFINE);
    else if(*text==-2)
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)STR_DEFINE);
    *end=251;
    ++end;
    *end=0;
    MACRO_DEFINE(name,(char far *)text,(signed char)parameters,start);
    POOL_A_USED=0;
    POOL_A_UNIT=start;
}

/* ---- LEXUNDEF (listing D801) ---- */
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

/* ---- LEXLINE (listing D85C) ---- */
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

/* ---- LEXCOND (listing D890) ---- */
extern int (far *EVAL_EXPRESSION)(void);
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
    value = EVAL_EXPRESSION();
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

/* ---- LEXIFDEF (listing D8DF) ---- */
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

/* ---- LEXIF (listing D95A) ---- */
static void near PARSE_IFDEF();
/* The #ifdef handler. */
static void near pascal PARSE_IFDEF_DIRECTIVE(int value)
{
    PARSE_IFDEF(value, 1);
}

/* ---- LEXIFN (listing D96D) ---- */
/* The #ifndef handler. */
static void near pascal PARSE_IFNDEF_DIRECTIVE(int value)
{
    PARSE_IFDEF(value, 0);
}

/* ---- LEXELSE (listing D97F) ---- */
#include <dos.h>


/* #else met while compiling a taken branch (state 1): skips to the
   matching #endif and pops the record.  Anywhere else it is misplaced.
   CONDITION_STATE and CONDITION_MARK are probably used by the precompiled
   header code to know where the conditional stack stands. */
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

/* ---- LEXELIF (listing D9D1) ---- */
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

/* ---- LEXENDIF (listing DA34) ---- */
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

/* ---- LEXLNUM (listing DA67) ---- */
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
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR,(char far *)STR_LINE);
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

/* ---- LEXTKN (listing DB5E) ---- */
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

/* ---- LEXSKIP (listing DBCC) ---- */
#include <dos.h>
extern int (far *EVAL_EXPRESSION)(void);
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
                    if(!EVAL_EXPRESSION()) continue;
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

/* ---- LEXPUT (listing DD3A) ---- */
extern char  TOKEN_LIMIT;

/* Appends a byte to the token text buffer unchanged (used for marker
   bytes) and keeps the text zero-terminated. */
void far pascal SCAN_WRITE(char value)
{
    if (TOKEN_PTR < &TOKEN_LIMIT)
        *TOKEN_PTR++ = value;
    *TOKEN_PTR = 0;
}

/* ---- LEXEMIT (listing DD5D) ---- */

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

/* ---- LEXNEXT (listing DD97) ---- */
#include <dos.h>

extern void far pascal COMMENT_BLOCK_BODY(void);
extern void far pascal COMMENT_LINE_BODY(void);

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
                COMMENT_BLOCK_BODY();
            } else {
                if (LANGUAGE_MODE != 1 && value == 47) {
                    COMMENT_LINE_BODY();
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

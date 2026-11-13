/* preproc.c: from bcc20/src/preproc/PREPROC.C: the preprocessor directives.

   The lexer calls DIRECTIVE_START when a line starts with '#'.  It reads the directive
   name, looks it up in DIRECTIVE_TABLE (12 five-byte entries: near name pointer, code byte,
   near handler offset in this module's code segment) and calls the handler with the first
   character after the name.  Handlers read the rest of the line straight from the input
   buffer, not through tokens.  #pragma dispatches again through PRAGMA_TABLE (four-byte
   entries: near handler, near name; ends at a null name).

   Conditional compilation: each open #if group has a 4-byte record in LINE_POOL (a state
   word, then the line of the #if); LINE_RECORD points just past the innermost record.
   State 1: a taken branch is being compiled; 2: the #else has been seen.  Skipped lines
   are passed over by CONDITIONAL_SCAN, which only looks at directives; DIRECTIVE_MODE says
   which one it found, by its code: 4, 5 and 7 open a group (#ifdef, #ifndef, #if), 6 is
   #endif, 8 #else and 10 #elif.  #if expressions are evaluated through EVAL_EXPRESSION (a
   pointer to the front end's evaluator), which leaves the value in TOKEN_CONST_VALUE. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"
#include "variadic.h"

/* globals as this file declares them */
#define LANGUAGE_MODE SB(LANGUAGE_MODE_P)
#define COMPILER_MODE SB(COMPILER_MODE_P)
#define PRAGMA_SAVEREGS_PENDING SB(PRAGMA_SAVEREGS_PENDING_P)
#define PRAGMA_ARGSUSED_PENDING SB(PRAGMA_ARGSUSED_PENDING_P)
#define PRAGMA_NORETVAL_PENDING SB(PRAGMA_NORETVAL_PENDING_P)
#define PRAGMA_CODESEG_SEEN SB(PRAGMA_CODESEG_SEEN_P)
#define OPTION_WINDOWS_MODE SB(OPTION_WINDOWS_MODE_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#undef INCLUDE_OPTION_TEXT_PTR
#define INCLUDE_OPTION_TEXT_PTR D(INCLUDE_OPTION_TEXT_PTR_P)   /* char far * */
#define TOKEN_CONST_VALUE D(TOKEN_CONST_VALUE_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define NAME_LIMIT SB(NAME_LIMIT_P)
#define CHAR_CLASS_AT(c) SB(fp_add(CHAR_CLASS_P, (c) + 1))

#define DS(o) DSPTR(o)
#define TOKEN_TEXT FP_OFF(TOKEN_TEXT_BUFFER_P)
#define TOKEN_END FP_OFF(TOKEN_LIMIT_P)
#define NAME_TEXT FP_OFF(NAME_BUFFER_P)
#define IN_INCLUDE_FILE (W(MK_FP(CONTEXT_SEG, CONTEXT_PTR + CTX_PREV)) != 0)

static i16 getbyte(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : B(MK_FP(W(DS(INPUT_BUFFER)), INPUT_INDEX++));
}

static int alpha(i16 c) { return CTYPE(c) & 12; }               /* a letter */
static int alnum_(i16 c) { return (CTYPE(c) & 14) || c == '_'; } /* a letter, digit or _ */
static int line_end(i16 c) { return c == 10 || c == 13 || c == 26; }

/* an error in a #pragma, except in strict ANSI mode, where pragmas are silently ignored */
void REPORT_PRAGMA_ERROR(u16 error, farptr name)
{
    if (LANGUAGE_MODE != 1)
        REPORT_ERROR((i16)error, name);
}

/* read a directive name after '#'.  With process set the directive is executed; with 0
   (from CONDITIONAL_SCAN, in skipped lines) it is only identified: its code goes to
   DIRECTIVE_MODE (0 if unknown) and the rest of the line is left unread.  A '#' alone on a
   line is allowed; an unknown name is an error only when processing. */
void DIRECTIVE_START(u16 process)
{
    i16 value = SCAN_NEXT(32);
    if (value == 10 || value == 13 || value == 26) {
        DIRECTIVE_MODE = 0;
        if (value == 10 || value == 13)
            --INPUT_INDEX;
        return;
    }
    LOGICAL_LINE = CURRENT_LINE;
    if (!alpha(value)) {
        TOKEN_TEXT_BUFFER_AT(0) = (i8)value;
        TOKEN_TEXT_BUFFER_AT(1) = 0;
        goto diagnose;
    }
    u16 text = TOKEN_TEXT;
    while (alpha(value)) {
        B(DS(text++)) = (u8)value;
        value = getbyte();
    }
    B(DS(text)) = 0;
    value = SCAN_NEXT(value);
    for (u16 entry = FP_OFF(DIRECTIVE_TABLE_P); entry < FP_OFF(DIRECTIVE_TABLE_P) + 12 * 5; entry += 5) {
        if (COMPARE_NAME(DS(W(DS(entry))), TOKEN_TEXT_BUFFER_P) == 0) {
            if (process) {
                LOGICAL_LINE = CURRENT_LINE;
                CALL_NEAR("PREPROC", W(DS(entry + 3)), A16(value));
            } else {
                DIRECTIVE_MODE = (u16)(i16)SB(DS(entry + 2));
                --INPUT_INDEX;
            }
            return;
        }
    }
    DIRECTIVE_MODE = 0;
    if (process) {
    diagnose:
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR, TOKEN_TEXT_BUFFER_P);
    }
    BCC_SCAN_FINISH_FAR(value);
}

/* #pragma warn +xxx, -xxx or .xxx: the warning with the three-letter name on, off, or
   back to its default (the fourth byte of its WARNING_SWITCH_TABLE entry).  An unknown
   name is silently ignored (the table walk never leaves the entry null). */
i16 PRAGMA_WARN(i16 input)
{
    i16 value = input;
    if (value != '-' && value != '+' && value != '.') {
        REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_PRAGMA_P);
        return value;
    }
    i16 prefix = value;
    value = SCAN_NEXT(32);
    if (!alpha(value)) {
        REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_PRAGMA_P);
        return value;
    }
    value = SCAN_TOKEN(value);
    u16 index = 0;
    for (farptr entry = WARNING_SWITCH_TABLE_P; B(entry); entry = fp_add(entry, 4), ++index)
        if (B(entry) == B(NAME_BUFFER_P) && B(fp_add(entry, 1)) == B(fp_add(NAME_BUFFER_P, 1)) &&
            B(fp_add(entry, 2)) == B(fp_add(NAME_BUFFER_P, 2))) {
            if (prefix == '.')
                WARNING_SWITCH_STATE_AT(index) = B(fp_add(entry, 3));
            else
                WARNING_SWITCH_STATE_AT(index) = prefix == '+';
        }
    if (IN_INCLUDE_FILE)
        SAVE_WARNING_SWITCH(NAME_BUFFER_P, (u8)prefix);
    return value;
}

/* probably #pragma inline: inline assembly needs the compile to go through the
   assembler, so unless that is the case already the compile is restarted that way
   (MODE_FALLBACK(3)); in an included file the precompiled header becomes unusable */
i16 CHECK_NAME_CONTEXT(i16 value)
{
    if (W(MK_FP(CONTEXT_SEG, CONTEXT_PTR + 2 * CTX_PREV_WORD_INDEX)) != 0)
        CONTEXT_DIAGNOSTIC();
    if (!COMPILER_MODE)
        MODE_FALLBACK(3);
    return value;
}

/* #pragma startup name [priority] (mode 0) or #pragma exit (mode 1): the function is
   looked up through PRAGMA_FUNC_LOOKUP_HOOK (-1 undefined, already reported; 0 not a
   suitable function; else the symbol); the priority defaults to 100 */
i16 PARSE_STARTUP_EXIT(i16 input, u16 mode)
{
    i16 value = input;
    if (!alpha(value) && value != '_') {
        REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_MISSING_FUNCTION_P);
        return value;
    }
    value = SCAN_TOKEN(value);
    i16 found = (i16)CALL_FAR(PRAGMA_FUNC_LOOKUP_HOOK, A16(0));
    if (found == -1)
        return value;
    if (!found) {
        REPORT_PRAGMA_ERROR(MSG_NOT_ALLOWED_TYPE, 0);
        return value;
    }
    i16 number;
    value = SCAN_NEXT(value);
    if (CTYPE(value) & 2) {
        number = 0;
        while (CTYPE(value) & 2) {
            number = (i16)(number * 10 + value - '0');
            value = getbyte();
        }
        value = SCAN_NEXT(value);
    } else
        number = 100;
    if (!line_end(value)) {
        REPORT_PRAGMA_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_PRAGMA_P);
        return value;
    }
    if (mode)
        ADD_EXIT_ENTRY((u16)found, (u16)number);
    else
        ADD_STARTUP_ENTRY((u16)found, (u16)number);
    return value;
}

i16 PRAGMA_STARTUP(i16 input) { return PARSE_STARTUP_EXIT(input, 0); }
i16 PRAGMA_EXIT(i16 input) { return PARSE_STARTUP_EXIT(input, 1); }

/* #pragma saveregs: the next function gets the _saveregs treatment */
i16 PRAGMA_SAVEREGS(i16 value)
{
    PRAGMA_SAVEREGS_PENDING = 1;
    return value;
}

/* #pragma option -x -y ...: each blank-separated option applied with APPLY_OPTION (the
   leading '-' skipped); a bad one is an error unless in strict ANSI mode.  In an included
   file it is also saved for the precompiled header. */
i16 PRAGMA_OPTION(i16 value)
{
    while (!line_end(value)) {
        TOKEN_PTR = TOKEN_TEXT;
        while (CHAR_CLASS_AT(value) != -9 && !line_end(value)) {
            SCAN_EMIT_FAR((i8)value);
            value = getbyte();
        }
        if (!APPLY_OPTION(fp_add(TOKEN_TEXT_BUFFER_P, 1), 1) && LANGUAGE_MODE != 1)
            REPORT_ERROR(MSG_INCORRECT_OPTION, STR_PRAGMA_DIRECTIVE_P, TOKEN_TEXT_BUFFER_P);
        if (W(MK_FP(CONTEXT_SEG, CONTEXT_PTR + 2 * CTX_PREV_WORD_INDEX)) != 0)
            SAVE_OPTION_STRING(fp_add(TOKEN_TEXT_BUFFER_P, 1));
        value = SCAN_NEXT(value);
    }
    TOKEN_PTR = TOKEN_TEXT;
    return value;
}

/* #pragma argsused: no "parameter never used" warnings for the next function */
i16 PRAGMA_ARGSUSED(i16 value)
{
    PRAGMA_ARGSUSED_PENDING = 1;
    return value;
}

/* probably suppresses "function should return a value" for the next function */
i16 PRAGMA_NORETVAL(i16 value)
{
    PRAGMA_NORETVAL_PENDING = 1;
    return value;
}

/* copy a run of letters, digits and '_' starting with value into the token buffer; the
   first other character is returned */
i16 SCAN_ALNUM(i16 value)
{
    while (alnum_(value)) {
        SCAN_EMIT_FAR((i8)value);
        value = getbyte();
    }
    return value;
}

/* #pragma codeseg [name [group] ["class"]]: the named segment (names upper-cased; class
   CODE_CLASS_NAME by default) becomes the code segment of the following functions; with no
   arguments the default one again.  Starts the back end first.  Malformed forms warn. */
i16 PRAGMA_CODESEG(i16 input)
{
    i16 value = input;
    u16 name, extra = 0, quoted = 0;
    CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
    PRAGMA_CODESEG_SEEN = 1;
    value = SCAN_NEXT(value);
    if (line_end(value)) {
        CODE_SEGMENT_ID = DEFAULT_CODE_SEGMENT_ID;
        goto parse_error;
    }
    if (!alnum_(value))
        goto invalid_identifier;
    TOKEN_PTR = TOKEN_TEXT;
    value = SCAN_ALNUM(value);
    RTL_STRUPR(TOKEN_TEXT_BUFFER_P);
    name = BCC_INTERN_STRING(TOKEN_TEXT_BUFFER_P);
    for (;;) {
        value = SCAN_NEXT(value);
        if (alnum_(value)) {
            if (extra)
                REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
            TOKEN_PTR = TOKEN_TEXT;
            value = SCAN_ALNUM(value);
            RTL_STRUPR(TOKEN_TEXT_BUFFER_P);
            extra = BCC_INTERN_STRING(TOKEN_TEXT_BUFFER_P);
        } else if (value == 34) {
            if (quoted)
                REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
            value = (u8)getbyte();
            TOKEN_PTR = TOKEN_TEXT;
            value = SCAN_ALNUM(value);
            RTL_STRUPR(TOKEN_TEXT_BUFFER_P);
            quoted = BCC_INTERN_STRING(TOKEN_TEXT_BUFFER_P);
            if (value == 34)
                value = (u8)getbyte();
            else {
                REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
                goto finish;
            }
        } else
            break;
    }
    if (!line_end(value)) {
        REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
        goto finish;
    }
    if (!quoted)
        quoted = CODE_CLASS_NAME;
    CODE_SEGMENT_ID = DEFINE_SEGMENT(OPTION_WINDOWS_MODE ? 2 : 1, name, extra, quoted);
    goto parse_error;
invalid_identifier:
    REPORT_WARNING(MSG_ILL_FORMED_PRAGMA);
    goto finish;
parse_error:
    CLONE_NODE_KEEP_SERIAL(LEX_FILE_SERIAL_NODE);
finish:
    TOKEN_PTR = TOKEN_TEXT;
    return value;
}

/* #pragma: reads the name and calls its handler from PRAGMA_TABLE; unknown pragmas are
   ignored; the rest of the line is skipped */
void PARSE_PRAGMA(i16 value)
{
    if (alpha(value)) {
        value = SCAN_NEXT(SCAN_TOKEN(value));
        for (u16 entry = FP_OFF(PRAGMA_TABLE_P); W(DS(entry + 2)) != 0; entry += 4)
            if (COMPARE_NAME(NAME_BUFFER_P, DS(W(DS(entry + 2)))) == 0) {
                value = (i16)CALL_NEAR("PREPROC", W(DS(entry)), A16(value));
                break;
            }
    }
    BCC_SCAN_FINISH_FAR(value);
}

/* #error: the rest of the line (splices joined) stops the compile with a fatal error */
void PARSE_ERROR_DIRECTIVE(i16 value)
{
    TOKEN_PTR = TOKEN_TEXT;
    B(DS(TOKEN_PTR)) = 0;
    while (!line_end(value)) {
        SCAN_EMIT_FAR((i8)value);
        value = getbyte();
        if (value == 92) {
            value = getbyte();
            if (value == 10 || value == 13) {
                LEX_NEWLINE((i8)value);
                value = getbyte();
            } else
                SCAN_EMIT_FAR(92);
        }
    }
    REPORT_FATAL(MSG_ERROR_DIRECTIVE, TOKEN_TEXT_BUFFER_P);
}

/* #include "file" or <file>, or #include NAME with NAME a macro expanding to one of those.
   A "file" name, a name with a drive or a leading slash, or any name when no -I directories
   are given is tried as it stands first; otherwise, or if that fails, the include
   directories are searched.  The file becomes the new input, and its name is recorded for
   the dependency list. */
void DIRECTIVE_INCLUDE(i16 value)
{
    i16 delimiter;
    TOKEN_PTR = TOKEN_TEXT;
    if (value == 60 || value == 34) {
        TOKEN_TEXT_BUFFER_AT(0) = 0;
        delimiter = value == 60 ? 62 : 34;
        do {
            SCAN_EMIT_FAR((i8)value);
            value = getbyte();
        } while (!line_end(value) && value != delimiter);
        if (value == delimiter) {
            SCAN_EMIT_FAR((i8)value);
            value = 32;
        }
        TOKEN_PTR = TOKEN_TEXT;
        CHECK_DIRECTIVE_END(value);
    } else {
        --INPUT_INDEX;
        LEX_READ(0, 1);
    }
    u16 text = TOKEN_TRIM();
    u16 end = text + STRING_LENGTH(DS(text)) - 1;
    if (SB(DS(text)) != 34 && SB(DS(text)) != 60) {
        REPORT_ERROR(MSG_BAD_FILE_NAME_FORMAT);
        return;
    }
    if ((SB(DS(text)) == 34 && SB(DS(end)) != 34) || (SB(DS(text)) == 60 && SB(DS(end)) != 62)) {
        REPORT_ERROR(MSG_NO_FILE_NAME_ENDING);
        return;
    }
    delimiter = SB(DS(text));
    B(DS(end)) = 0;
    ++text;
    i16 length = (i16)STRING_LENGTH(DS(text));
    if (length > 80) {
        REPORT_ERROR(MSG_FILE_NAME_TOO_LONG);
        return;
    }
    u16 path = NAME_TEXT - (length + 1);   /* just before NAME_BUFFER, as the original */
    STRING_COPY(DS(path), DS(text));
    STRING_COPY(TOKEN_TEXT_BUFFER_P, DS(path));
    if (delimiter == 34 || SB(DS(path + 1)) == 58 || SB(DS(path)) == 47 || SB(DS(path)) == 92 ||
        SB(INCLUDE_OPTION_TEXT_PTR) == 0) {
        if (OPEN_SOURCE_FILE(DS(path))) {
            RECORD_SOURCE_NAME();
            return;
        }
    }
    if (!OPEN_INCLUDE_FILE(DS(path)))
        REPORT_ERROR(MSG_UNABLE_OPEN_INCLUDE, DS(path));
    RECORD_SOURCE_NAME();
}

/* strip trailing blanks, tabs and FBh separators from the token buffer, and return a near
   pointer past its leading blanks */
u16 TOKEN_TRIM(void)
{
    if (TOKEN_TEXT_BUFFER_AT(0) == 0)
        return TOKEN_TEXT;
    u16 p = TOKEN_TEXT + STRING_LENGTH(TOKEN_TEXT_BUFFER_P) - 1;
    while ((i16)(p - TOKEN_TEXT) >= 0) {
        i8 c = SB(DS(p));
        if (c != 32 && c != 9 && c != -5)
            break;
        B(DS(p--)) = 0;
    }
    p = TOKEN_TEXT;
    while (SB(DS(p)) == 32 || SB(DS(p)) == 9)
        p++;
    return p;
}

/* #define: the name (the predefined names refused), an optional parameter list (names
   collected in POOL_A from start, duplicates reported) and the body read with LEX_READ,
   which turns each parameter into 80h + its number.  Checks that # is followed by a
   parameter and that ## is at neither end, appends FBh, and stores the macro (POOL_A is
   released afterwards). */
void BCC_PARSE_MACRO(i16 input)
{
    i16 value = input, parameters = -1;
    if (!alpha(value) && value != 95) {
        REPORT_ERROR(MSG_DEFINE_DIRECTIVE_NEEDS);
        BCC_SCAN_FINISH_FAR(value);
        return;
    }
    value = SCAN_TOKEN(value);
    if (NAME_VALIDATE(NAME_BUFFER_P))
        REPORT_ERROR(MSG_DEFINE_DIRECTIVE_NEEDS);
    u16 mark = scratch_mark();
    farptr name = scratch_alloc(34);
    STRING_COPY(name, NAME_BUFFER_P);
    u16 start = POOL_ALLOC(POOL_A_P, 0);
    if (value != 40) {
        --INPUT_INDEX;
        LEX_READ(0, 0);
        goto trim;
    }
    parameters = 0;
    value = SCAN_NEXT(32);
    if (value == 41) {
        LEX_READ(0, 0);
        goto trim;
    }
    for (;;) {
        if (!alpha(value) && value != 95) {
            REPORT_ERROR(MSG_MACRO_ARGUMENT_SYNTAX);
            BCC_SCAN_FINISH_FAR(value);
            scratch_release(mark);
            return;
        }
        value = SCAN_TOKEN(value);
        for (u16 parameter = start; parameter < POOL_A_UNIT;
             parameter += STRING_LENGTH(MK_FP(POOL_A, parameter)) + 1)
            if (COMPARE_NAME(MK_FP(POOL_A, parameter), NAME_BUFFER_P) == 0) {
                REPORT_ERROR(MSG_MULTIPLE_DECLARATION, NAME_BUFFER_P);
                break;
            }
        u16 parameter = POOL_ALLOC(POOL_A_P, STRING_LENGTH(NAME_BUFFER_P) + 1);
        STRING_COPY(MK_FP(POOL_A, parameter), NAME_BUFFER_P);
        ++parameters;
        value = SCAN_NEXT(value);
        if (value == 41)
            break;
        if (value != 44) {
            REPORT_ERROR(MSG_INVALID_MACRO_ARGUMENT);
            BCC_SCAN_FINISH_FAR(value);
            scratch_release(mark);
            return;
        }
        value = SCAN_NEXT(32);
    }
    value = SCAN_NEXT(32);
    --INPUT_INDEX;
    TOKEN_PTR = TOKEN_TEXT;
    B(DS(TOKEN_PTR)) = 0;
    {
        u16 last = POOL_ALLOC(POOL_A_P, 1);
        B(MK_FP(POOL_A, last)) = 0;
    }
    LEX_READ((i16)start, 0);
    for (farptr text = TOKEN_TEXT_BUFFER_P; SB(text); text = fp_add(text, 1))
        if (SB(text) == -3 && ((B(fp_add(text, 1)) & 128) == 0 || B(fp_add(text, 1)) >= 251)) {
            REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_DEFINE_P);
            break;
        }
trim: {
    farptr text = DS(TOKEN_TRIM());
    farptr end = fp_add(text, STRING_LENGTH(text));
    if (FP_OFF(text) + 1 < FP_OFF(end) && SB(fp_add(end, -1)) == -2)
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_DEFINE_P);
    else if (SB(text) == -2)
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_DEFINE_P);
    B(end) = 251;
    end = fp_add(end, 1);
    B(end) = 0;
    MACRO_DEFINE(name, text, (i8)parameters, start);
    }
    POOL_A_USED = 0;
    POOL_A_UNIT = start;
    scratch_release(mark);
}

/* #undef name (the predefined names cannot be undefined) */
void PARSE_UNDEF(i16 value)
{
    if (!alpha(value) && value != 95) {
        REPORT_ERROR(MSG_BAD_UNDEF_DIRECTIVE);
        BCC_SCAN_FINISH_FAR(value);
        return;
    }
    CHECK_DIRECTIVE_END(SCAN_TOKEN(value));
    if (NAME_VALIDATE(NAME_BUFFER_P) != 0)
        REPORT_ERROR(MSG_BAD_UNDEF_DIRECTIVE);
    MACRO_REMOVE(NAME_BUFFER_P);
}

/* push a conditional record: state value and the current line */
void SAVE_LINE_MARKER(i16 value)
{
    u16 offset = POOL_ALLOC(LINE_POOL_P, 4);
    W(MK_FP(LINE_POOL, offset)) = (u16)value;
    W(MK_FP(LINE_POOL, offset + 2)) = CURRENT_LINE;
    LINE_RECORD = offset + 4;
}

/* the hook is PARSE_PP_IF_EXPRESSION (C) or EVAL_CONSTANT_CONDITION (C++) */
static i16 eval_expression(void)
{
    return (i16)CALL_FAR0(EVAL_EXPRESSION);
}

/* #if: a valid nonzero expression compiles the group (state 1); otherwise its lines are
   skipped up to a true #elif (state 1), an #else (state 2) or the #endif (nothing pushed) */
void PARSE_CONDITIONAL(i16 value)
{
    INPUT_INDEX--;
    value = eval_expression();
    INPUT_INDEX--;
    if (value != 0 && TOKEN_CONST_VALUE != 0) {
        SAVE_LINE_MARKER(1);
        return;
    }
    CONDITIONAL_SCAN(1, 0);
    if (DIRECTIVE_MODE == 8)
        SAVE_LINE_MARKER(2);
    else if (DIRECTIVE_MODE == 10)
        SAVE_LINE_MARKER(1);
}

/* #ifdef (expected 1) and #ifndef (expected 0), with "is the name a macro" as the
   condition; a missing name is an error and the group is then compiled */
void PARSE_IFDEF(i16 value, i16 expected)
{
    if (!alpha(value) && value != 95) {
        REPORT_ERROR(expected != 0 ? MSG_BAD_IFDEF_DIRECTIVE : MSG_BAD_IFNDEF_DIRECTIVE);
        BCC_SCAN_FINISH_FAR(value);
        SAVE_LINE_MARKER(1);
        return;
    }
    CHECK_DIRECTIVE_END(SCAN_TOKEN(value));
    if (MACRO_DEFINED(NAME_BUFFER_P) == expected) {
        SAVE_LINE_MARKER(1);
        return;
    }
    CONDITIONAL_SCAN(1, 0);
    if (DIRECTIVE_MODE == 8)
        SAVE_LINE_MARKER(2);
    else if (DIRECTIVE_MODE == 10)
        SAVE_LINE_MARKER(1);
}

void PARSE_IFDEF_DIRECTIVE(i16 value) { PARSE_IFDEF(value, 1); }
void PARSE_IFNDEF_DIRECTIVE(i16 value) { PARSE_IFDEF(value, 0); }

static int in_taken_branch(void)
{
    return LINE_RECORD != 0 && SW(MK_FP(LINE_POOL, LINE_RECORD - 4)) == 1;
}

static void pop_conditional(void)
{
    LINE_RECORD -= 4;
    CONDITION_STATE = 0;
    CONDITION_MARK = LINE_RECORD;
}

/* #else in a taken branch: skip to the matching #endif and pop; anywhere else misplaced */
void PARSE_ELSE(i16 value)
{
    if (in_taken_branch()) {
        CHECK_DIRECTIVE_END(value);
        CONDITIONAL_SCAN(0, 0);
        pop_conditional();
    } else {
        BCC_SCAN_FINISH_FAR(value);
        REPORT_ERROR(MSG_MISPLACED_ELSE);
    }
}

/* #elif in a taken branch: every later group is skipped to the #endif, and the record
   popped */
void PARSE_ELIF(i16 value)
{
    if (in_taken_branch()) {
        BCC_SCAN_FINISH_FAR(value);
        do
            CONDITIONAL_SCAN(1, 1);
        while (DIRECTIVE_MODE == 10 || DIRECTIVE_MODE == 8);
        pop_conditional();
    } else {
        BCC_SCAN_FINISH_FAR(value);
        REPORT_ERROR(MSG_MISPLACED_ELIF);
    }
}

/* #endif: pop the innermost conditional record */
void PARSE_ENDIF(i16 value)
{
    if (LINE_RECORD != 0)
        pop_conditional();
    else
        REPORT_ERROR(MSG_MISPLACED_ENDIF);
    CHECK_DIRECTIVE_END(value);
}

/* #line number ["file"], read with macros expanded: the next line is number, and the file
   name, if given and different, becomes CURRENT_FILE_NAME */
void BCC_PARSE_LINE(i16 input)
{
    (void)input;
    TOKEN_PTR = TOKEN_TEXT;
    --INPUT_INDEX;
    LEX_READ(0, 1);
    TOKEN_PTR = TOKEN_TEXT;
    u16 text = TOKEN_TRIM();
    i16 line = 0;
    if (!(CTYPE(SB(DS(text))) & 2)) {
        REPORT_ERROR(MSG_UNKNOWN_PREPROCESSOR, STR_LINE_P);
        return;
    }
    while (CTYPE(SB(DS(text))) & 2) {
        line = (i16)(line * 10 + SB(DS(text)) - 48);
        ++text;
    }
    while (SB(DS(text)) == 32)
        ++text;
    if (SB(DS(text)) != 0) {
        u16 end = text + STRING_LENGTH(DS(text)) - 1;
        if (SB(DS(text)) != 34 || SB(DS(end)) != 34) {
            REPORT_ERROR(MSG_BAD_FILE_NAME_FORMAT);
            return;
        }
        ++text;
        B(DS(end)) = 0;
        if (STRING_COMPARE(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME), DS(text)) != 0) {
            u16 name = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(DS(text)) + 1);
            CURRENT_FILE_NAME = name;
            STRING_COPY(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME), DS(text));
        }
    }
    LOGICAL_LINE = CURRENT_LINE = (u16)(line - 1);
}

/* a name starting with value into NAME_BUFFER (letters, digits, '_', cut to NAME_LIMIT
   characters); the first character after it is returned */
i16 SCAN_TOKEN(i16 value)
{
    farptr p = NAME_BUFFER_P;
    while (alnum_(value)) {
        if (FP_OFF(p) < (u16)(NAME_TEXT + NAME_LIMIT)) {
            B(p) = (u8)value;
            p = fp_add(p, 1);
        }
        value = getbyte();
    }
    B(p) = 0;
    return value;
}

/* skip the lines of a group that is not compiled, looking only at directive lines.  depth
   counts nested conditionals.  At depth 0, #endif ends the scan; #else ends it too unless
   skip is set (then another #else is misplaced); #elif, unless skip is set, has its
   expression evaluated and ends the scan if true.  allowed 0: an #else or #elif here is
   misplaced.  The directive that ended the scan is left in DIRECTIVE_MODE.  End of input
   is an error naming the line where the scan began. */
void CONDITIONAL_SCAN(i16 allowed, u16 skip)
{
    i16 value, enabled = allowed, depth = 0;
    u16 line = CURRENT_LINE;
    for (;;) {
        value = SCAN_NEXT(getbyte());
        if (value == 26) {
            REPORT_ERROR(MSG_UNEXPECTED_END_FILE_42, line);
            return;
        }
        if (value == '#') {
            DIRECTIVE_START(0);
            if (DIRECTIVE_MODE == 7 || DIRECTIVE_MODE == 4 || DIRECTIVE_MODE == 5)
                ++depth;
            else if (DIRECTIVE_MODE == 6)
                --depth;
            else if (DIRECTIVE_MODE == 8 && depth == 0) {
                if (enabled) {
                    if (!skip)
                        --depth;
                    else
                        enabled = 0;
                } else
                    REPORT_ERROR(MSG_MISPLACED_ELSE);
            } else if (DIRECTIVE_MODE == 10 && depth == 0) {
                if (!enabled)
                    REPORT_ERROR(MSG_MISPLACED_ELIF);
                else if (!skip) {
                    --INPUT_INDEX;
                    if (!eval_expression())
                        continue;
                    if (TOKEN_CONST_VALUE != 0)
                        break;
                    continue;
                }
            }
            value = getbyte();
        }
        BCC_SCAN_FINISH_FAR(value);
        value = getbyte();
        if (depth < 0)
            break;
        if (value == 10 || value == 13)
            LEX_NEWLINE((i8)value);
    }
    --INPUT_INDEX;
}

/* append a byte to the token buffer unchanged (marker bytes), keeping it terminated */
void SCAN_WRITE(i8 value)
{
    if (TOKEN_PTR < TOKEN_END)
        B(DS(TOKEN_PTR++)) = (u8)value;
    B(DS(TOKEN_PTR)) = 0;
}

/* append a text character to the token buffer: one with the high bit set (but FBh) is
   preceded by FFh so it cannot be taken for a marker; past EMIT_LIMIT characters are
   dropped */
void SCAN_EMIT_FAR(i8 value)
{
    if (TOKEN_PTR < FP_OFF(EMIT_LIMIT_P)) {
        if ((value & 128) && value != -5)
            B(DS(TOKEN_PTR++)) = 0xFF;
        B(DS(TOKEN_PTR++)) = (u8)value;
    }
    B(DS(TOKEN_PTR)) = 0;
}

/* skip blanks, comments and line splices starting at value, and return the first other
   character (consumed); a '/' or backslash that starts neither is returned as itself */
i16 SCAN_NEXT(i16 value)
{
    for (;;) {
        if (value == 47) {
            value = getbyte();
            if (value == 42)
                COMMENT_BLOCK();
            else if (LANGUAGE_MODE != 1 && value == 47)
                COMMENT_LINE();
            else {
                INPUT_INDEX--;
                return 47;
            }
        } else if (value == 92) {
            value = getbyte();
            if (CHAR_CLASS_AT(value) == -20)
                LEX_NEWLINE((i8)value);
            else {
                INPUT_INDEX--;
                return 92;
            }
        } else if (CHAR_CLASS_AT(value) != -9)
            return value;
        value = getbyte();
    }
}

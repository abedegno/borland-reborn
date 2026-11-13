/* target: ovr106_C226UNIT */
/* opts: -mm -G -O -Z -p -Y -y -B -TjNOSMART */
/* Role: lexer. Entry points: INIT_LEXER_POOLS, INIT_LEXER_STATE, LEX_NEXT_TOKEN, LEX_HASH,
   LEX_READ, NAME_VALIDATE, LEX_NEWLINE, LEX_WHITESPACE (+7 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the lexer.  It turns the bytes of the current input (a source
   file, an #include file, or the text of a macro expansion, all managed by
   INPUT.C) into tokens, and it also does most of the preprocessor's
   character-level work: reading #define bodies, collecting and
   pre-expanding macro arguments, and expanding the predefined macros.
   LEX_NEXT_TOKEN is called by PEEK_TOKEN (TOKADV.C) whenever the parser
   needs a token; it writes the token code into the first word of the
   lookahead record TOKEN_TYPE, its position (TOKEN_LINE, TOKEN_LENGTH,
   TOKEN_FILE_NODE) and its value (TOKEN_CONST_VALUE: an identifier's name
   node, an integer's long value, or a 10-byte floating value; TOKEN_AUX:
   the constant's type kind, TK_INT .. TK_LDOUBLE).  Token codes made here
   besides operators: 0x31 identifier, 0x32 integer constant, 0x33 floating
   constant, 0x34 string literal (its characters are read later, see
   NEXT_POOL_CHARACTER), 0x65 character constant, 0 end of input.
   Input bytes are read with the GETBYTE macro straight from the current
   input buffer (INPUT_BUFFER, INPUT_INDEX, INPUT_LIMIT), calling
   INPUT_REFILL at the end of the buffer.
   Every character has a class in a 256-entry table; CHAR_CLASS_PTR selects
   one of three tables, and that is how one scanner serves three jobs:
     CHAR_CLASS+1 (normal): C tokens for the parser;
     LEX_READ_MODE0_CLASSES+1 (CHAR_CLASS+0x101): reading a #define body
       as text, without expanding macros;
     LEX_READ_MODE1_CLASSES+1 (CHAR_CLASS+0x201): reading text with macros
       expanded (a macro-valued #include name, a pre-expanded argument).
   In the two text modes most classes copy characters into the token text
   buffer (TOKEN_PTR, which runs through the buffer named TOKEN_TEXT_BUFFER, up to
   TOKEN_LIMIT / EMIT_LIMIT) instead of returning tokens.
   Marker bytes inside macro text: 0x80+n a macro parameter (n is its
   index), 0xFD the # (stringize) operator, 0xFE the ## (paste) operator,
   0xFC a name that must not be expanded again, 0xFF "the next byte is
   literal", 26 (Ctrl-Z) the end of a text.
   A trick used throughout: the predefined macros and defined() are
   expanded by returning a character for LEX_NEXT_TOKEN to rescan.
   __STDC__ and defined(x) return '1' or '0', which then scans as a
   number; __FILE__ returns '"' with PENDING_STRING_TEXT pointing at the
   name; __LINE__ pushes its digits back into the input. */
#include <dos.h>
#include "DATA.H"
#include "HEAP.H"
#include "MSG.H"
#include "FIELDS.H"
#include "POOL.H"

/* CO031: the preprocessor lexer (token scanner, number, character and
   string scanning, macro-argument reading and the pool replay helpers).
   The original file contains the hand-written LEX_WHITESPACE, so BCC
   compiled it through TASM (-B).  -TjNOSMART: the original assembler did
   not turn far calls into push cs; call near, so calls to functions defined
   later in the file stay far calls that the linker relaxes
   (nop; push cs; call), while calls to functions defined earlier are BC's
   own push cs; call near. */

/* ---- INIT_LEXER_POOLS: lexer pool initialisation (0000) ---- */
extern char  INIT_OPTION;
extern void far POOL_INIT(unsigned int far *pool, unsigned int unit);

/* Sets up the lexer's six pools (the POOL_A list of macro arguments, the
   line pool, the input context pool, TOKEN_POOL for macro and string
   text, and the scratch pools POOL_E and POOL_F) for a new compile, under
   the compile's owner tag INIT_OPTION. */
void far pascal INIT_LEXER_POOLS(void)
{
    SET_DEFAULT_OWNER_TAG(INIT_OPTION);

    POOL_A_UNIT = POOL_A_STEP = 1;
    POOL_A_USED = 0;
    POOL_INIT(&POOL_A, 1);

    CONDITION_MARK = LINE_POOL_STEP = 0;
    CONDITION_STATE = 0;
    POOL_INIT(&LINE_POOL, 0);

    CONTEXT_SEG_UNIT = CONTEXT_SEG_STEP = 2;
    CONTEXT_SEG_USED = 0;
    POOL_INIT(&CONTEXT_SEG, 2);

    TOKEN_POOL_UNIT = TOKEN_POOL_STEP = 1;
    TOKEN_POOL_USED = 0;
    POOL_INIT(&TOKEN_POOL, 1);

    POOL_E_UNIT = POOL_E_STEP = 2;
    POOL_E_USED = 0;
    POOL_INIT(&POOL_E, 2);

    POOL_F_UNIT = POOL_F_STEP = 1;
    POOL_F_USED = 0;
    POOL_INIT(&POOL_F, 1);
}

/* ---- INIT_LEXER_STATE: lexer state initialisation (00BA) ---- */
extern signed char *CHAR_CLASS_PTR;
extern signed char  CHAR_CLASS[];
extern char *TOKEN_PTR;
extern unsigned int  PENDING_STRING_TEXT;
extern unsigned int  TOKEN_TYPE;
extern unsigned int  CURRENT_TOKEN_RECORD;

/* Resets the lexer for a new source file: no open input, the normal
   character class table, an empty token text buffer and empty current and
   lookahead tokens (0x82 means "none yet"). */
void far pascal INIT_LEXER_STATE(void)
{
    CONTEXT_PTR = 0;
    CHAR_CLASS_PTR = CHAR_CLASS + 1;
    TOKEN_PTR = TOKEN_TEXT_BUFFER;
    CURRENT_FILE_CONTEXT = 0;
    LEXER_INIT_CLEARED_WORD = 0;
    FREE_MACRO_CONTEXT_LIST = 0;
    LINE_RECORD = 0;
    PENDING_STRING_TEXT = 0;
    TOKEN_TYPE = 0x82;
    CURRENT_TOKEN_RECORD = 0x82;
    CURRENT_TOKEN = 0x82;
}

/* ---- LEX_NEXT_TOKEN: the token scanner (0101) ---- */
static int near pascal SCAN_NUMBER_TEXT(char c);
static int near pascal CONVERT_NUMBER_TOKEN(int base);

extern unsigned char far pascal INPUT_REFILL(void);
extern unsigned long far pascal INPUT_POSITION(void);
extern void far pascal SCAN_EMIT_FAR(char);
extern void far pascal COMMENT_BLOCK(void);
extern void far pascal COMMENT_LINE(void);
extern void far pascal SCAN_WRITE(char);
extern int far pascal SCAN_NEXT(int);
extern void far cdecl REPORT_ERROR();
extern unsigned int far pascal POP_INPUT_CONTEXT(unsigned int);
extern int far pascal COPY_STRING_LITERAL(signed char, void (far pascal *)(signed char), unsigned int);

/* unit functions.  A call written with a stub name (LEX_NEWLINE,
   CLASSIFY_IDENTIFIER) went through the overlay stub in the original; one written
   with the body name (LEX_NEWLINE_BODY = OVL:006A:118C, CLASSIFY_IDENTIFIER_BODY =
   OVL:006A:1333, the body of CLASSIFY_IDENTIFIER) jumped straight to the body. */
extern int far pascal CLASSIFY_IDENTIFIER_BODY(void);
void far pascal LEX_HASH(char value);
void far pascal LEX_NEWLINE(char value);
void far pascal LEX_WHITESPACE(char value);
static int near pascal LEX_CHARACTER(void);

extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
extern long  TOKEN_POSITION;
extern unsigned char LANGUAGE_MODE;
extern unsigned int HASH_CHAIN_LINK_SEG;
/* the token value area: a long for integer tokens, also used as a
   10-byte floating value by RTL_SCAN_LDOUBLE and LEX_COMPARE */
extern unsigned long  TOKEN_CONST_VALUE;
extern void (far pascal *LITERAL_CHAR_EMIT_PTR)(signed char);

#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
#define CLASS_TABLE(n) ((signed char far *)CHAR_CLASS_PTR == (signed char far *)(CHAR_CLASS + (n)))
#define MARK_TOKEN() { \
    TOKEN_LINE = CURRENT_LINE; \
    TOKEN_LENGTH = (unsigned int)INPUT_POSITION() - (unsigned int)TOKEN_POSITION; \
    TOKEN_FILE_NODE = LEX_FILE_SERIAL_NODE; }

/* Scans one token and returns its code (also stored in TOKEN_TYPE).  The
   loop reads a character, looks up its class and switches on it; a case
   that ends in break has consumed something that is not a token (blanks,
   a comment, a directive, a line splice, text copied in a text mode) and
   goes round for the next character.  INPUT_INDEX-- puts back one
   character read too far.  For operators the class is minus an index into
   three tables: SINGLE_CHAR_TOKEN_TABLE (x), DOUBLED_CHAR_TOKEN_TABLE (xx)
   and OP_ASSIGN_TOKEN_TABLE (x=). */
int far pascal LEX_NEXT_TOKEN(void)
{
    int c;
    int c2;
    register int cls;

    for (c = GETBYTE; ; c = GETBYTE) {
reclass:
        cls = CHAR_CLASS_PTR[c];
        switch (cls) {
        /* A letter: an identifier, keyword or macro name.  L' and L" start
           wide character constants and strings: the L is dropped (copied
           in text modes) and the quote is rescanned. */
        case -10:
            if (c == 'L') {
                c2 = GETBYTE;
                if (c2 == '\'' || c2 == '"') {
                    if (!CLASS_TABLE(0x001))
                        SCAN_EMIT_FAR(c);
                    c = c2;
                    goto reclass;
                }
                INPUT_INDEX--;
            }
            MARK_TOKEN();
            MACRO_MARK_FE_SEEN = 0;
            LEX_WHITESPACE(c);
            if (CLASS_TABLE(0x101))
                return TOKEN_TYPE = 0x31;
            /* c >= 0: the name was a macro or predefined name and c is the
               next character to scan; otherwise look up its keyword. */
            c = CLASSIFY_IDENTIFIER_BODY();
            if (c >= 0)
                goto reclass;
            if (CLASS_TABLE(0x201))
                return TOKEN_TYPE = 0x31;
            /* an identifier token carries its symbol in the low word */
            *(unsigned int *)&TOKEN_CONST_VALUE = CURRENT_SYMBOL;
            /* HLINK_TOKEN is the keyword token of the name (0 if it is not
               a keyword).  In strict ANSI mode keywords are not recognised
               while reading text for the preprocessor. */
            c = *(int far *)MK_FP(HASH_CHAIN_LINK_SEG, CURRENT_SYMBOL + HLINK_TOKEN);
            if (c == 0)
                return TOKEN_TYPE = 0x31;
            if (MACRO_MODE && LANGUAGE_MODE == 1)
                return TOKEN_TYPE = 0x31;
            return TOKEN_TYPE = c;
        default:
            MARK_TOKEN();
            return TOKEN_TYPE = cls;
        /* Followed by a line end this character is a line splice; followed
           by '?' it gives token 0x20 (probably the ?: operator); otherwise it
           is an illegal character. */
        case -22:
            c2 = GETBYTE;
            if (c2 == 10 || c2 == 13) {
                LEX_NEWLINE(c2);
                break;
            }
            if (c2 == '?') {
                MARK_TOKEN();
                return TOKEN_TYPE = 0x20;
            }
            INPUT_INDEX--;
        case -18:
            REPORT_ERROR(MSG_ILLEGAL_CHARACTER_0X, c, c);
            break;
        /* End of the current input: pop back to the including file or
           the text a macro was called from; 0 at the real end. */
        case -25:
            if (POP_INPUT_CONTEXT(0))
                break;
            return TOKEN_TYPE = 0;
        /* A line end.  LEX_HASH counts it and starts a directive if the
           next line begins with '#'.  In a text mode it ends the read
           instead (token 10). */
        case -20:
            if (MACRO_MODE)
                return TOKEN_TYPE = 10;
            LEX_HASH(c);
            break;
        case -11:
            MARK_TOKEN();
            cls = SCAN_NUMBER_TEXT(c);
            if (CLASS_TABLE(0x001))
                return TOKEN_TYPE = CONVERT_NUMBER_TOKEN(cls);
            break;
        /* '/': a block or line comment (line comments only when not in
           strict ANSI mode), or the / /= operators. */
        case -5:
            /* Documented exception (dead store): the original negates cls
               here (neg at 0369) although this case then indexes the tables
               with the constant 5. */
            cls = -cls;
            MARK_TOKEN();
            c2 = GETBYTE;
            if (c2 == '*') {
                COMMENT_BLOCK();
                break;
            }
            if (LANGUAGE_MODE != 1 && c2 == '/') {
                COMMENT_LINE();
                break;
            }
            if (DOUBLED_CHAR_TOKEN_TABLE[5] && c2 == c)
                return TOKEN_TYPE = DOUBLED_CHAR_TOKEN_TABLE[5];
            if (c2 == '=')
                return TOKEN_TYPE = OP_ASSIGN_TOKEN_TABLE[5];
            INPUT_INDEX--;
            return TOKEN_TYPE = SINGLE_CHAR_TOKEN_TABLE[5];
        case 0: case -1: case -2: case -3: case -4:
        case -6: case -7: case -8:
            cls = -cls;
            MARK_TOKEN();
            c2 = GETBYTE;
            if (DOUBLED_CHAR_TOKEN_TABLE[cls] && c2 == c)
                return TOKEN_TYPE = DOUBLED_CHAR_TOKEN_TABLE[cls];
            if (c2 == '=')
                return TOKEN_TYPE = OP_ASSIGN_TOKEN_TABLE[cls];
            INPUT_INDEX--;
            return TOKEN_TYPE = SINGLE_CHAR_TOKEN_TABLE[cls];
        /* '"': a string literal.  Only the token is returned here; its
           characters are read later through NEXT_POOL_CHARACTER. */
        case -12:
            MARK_TOKEN();
            return TOKEN_TYPE = 0x34;
        case -14:
            MARK_TOKEN();
            return TOKEN_TYPE = LEX_CHARACTER();
        case -34:
            MARK_TOKEN();
            c = GETBYTE;
            if (c == ':')
                return TOKEN_TYPE = 0x67;
            INPUT_INDEX--;
            return TOKEN_TYPE = 0x21;
        case -15:
            MARK_TOKEN();
            c = GETBYTE;
            if (c == '-')
                return TOKEN_TYPE = 0x2E;
            if (c == '=')
                return TOKEN_TYPE = 0x0D;
            if (c == '>') {
                c = GETBYTE;
                if (c == '*')
                    return TOKEN_TYPE = 0x66;
                INPUT_INDEX--;
                return TOKEN_TYPE = 0x30;
            }
            INPUT_INDEX--;
            return TOKEN_TYPE = 0x17;
        case -16:
            MARK_TOKEN();
            c = GETBYTE;
            if (CHAR_CLASS_PTR[c] == -11) {
                INPUT_INDEX--;
                cls = SCAN_NUMBER_TEXT('.');
                return TOKEN_TYPE = CONVERT_NUMBER_TOKEN(cls);
            }
            if (c == '.') {
                c = GETBYTE;
                if (c != '.') {
                    REPORT_ERROR(MSG_TWO_CONSECUTIVE_DOTS);
                    INPUT_INDEX--;
                    return TOKEN_TYPE = 0x2F;
                }
                return TOKEN_TYPE = 9;
            }
            if (c == '*')
                return TOKEN_TYPE = 0x64;
            INPUT_INDEX--;
            return TOKEN_TYPE = 0x2F;
        case -17:
            MARK_TOKEN();
            c = GETBYTE;
            if (c == '=')
                return TOKEN_TYPE = 0x28;
            if (c == '<') {
                c = GETBYTE;
                if (c == '=')
                    return TOKEN_TYPE = 0x14;
                INPUT_INDEX--;
                return TOKEN_TYPE = 0x1E;
            }
            INPUT_INDEX--;
            return TOKEN_TYPE = 0x26;
        case -19:
            MARK_TOKEN();
            c = GETBYTE;
            if (c == '=')
                return TOKEN_TYPE = 0x29;
            if (c == '>') {
                c = GETBYTE;
                if (c == '=')
                    return TOKEN_TYPE = 0x15;
                INPUT_INDEX--;
                return TOKEN_TYPE = 0x1F;
            }
            INPUT_INDEX--;
            return TOKEN_TYPE = 0x27;
        /* The cases from here on occur only in the text-mode tables:
           backslash, line ends, comments and blanks are copied (a run of
           blanks or a comment becomes one blank), quoted text is copied
           whole, and # or ## become the marker bytes 0xFD and 0xFE. */
        case -28:
            c = GETBYTE;
            if (c != 10 && c != 13) {
                INPUT_INDEX--;
                SCAN_EMIT_FAR('\\');
            } else
                LEX_NEWLINE(c);
            break;
        case -32:
            c = GETBYTE;
            if (c != 10 && c != 13)
                SCAN_EMIT_FAR(c);
            else
                LEX_NEWLINE(c);
            break;
        case -30:
            c = GETBYTE;
            if (c == '*') {
                COMMENT_BLOCK();
                if (TOKEN_PTR <= TOKEN_TEXT_BUFFER || TOKEN_PTR[-1] != ' ')
                    SCAN_EMIT_FAR(' ');
            } else if (LANGUAGE_MODE != 1 && c == '/') {
                COMMENT_LINE();
                if (TOKEN_PTR <= TOKEN_TEXT_BUFFER || TOKEN_PTR[-1] != ' ')
                    SCAN_EMIT_FAR(' ');
            } else {
                INPUT_INDEX--;
                SCAN_EMIT_FAR('/');
            }
            break;
        case -33:
            if (TOKEN_PTR <= TOKEN_TEXT_BUFFER || TOKEN_PTR[-1] != ' ')
                SCAN_EMIT_FAR(' ');
            break;
        case -26:
            SCAN_EMIT_FAR(c);
            break;
        case -27:
            if (COPY_STRING_LITERAL(c, LITERAL_CHAR_EMIT_PTR, 1))
                break;
            return TOKEN_TYPE = 10;
        case -31:
            if (COPY_STRING_LITERAL(c, LITERAL_CHAR_EMIT_PTR, 0))
                break;
            return TOKEN_TYPE = 10;
        case -29:
            c = GETBYTE;
            if (c == '#') {
                while (TOKEN_PTR > TOKEN_TEXT_BUFFER && TOKEN_PTR[-1] == ' ')
                    TOKEN_PTR--;
                SCAN_WRITE(0xFE);
                SCAN_NEXT(' ');
                INPUT_INDEX--;
                break;
            } else {
                SCAN_WRITE(0xFD);
                SCAN_NEXT(c);
                INPUT_INDEX--;
            }
            break;
        case -9:
            break;
        }
    }
}
#undef GETBYTE
#undef CLASS_TABLE
#undef MARK_TOKEN

/* ---- LEX_HASH (0A52) ---- */
extern void far LEX_NEWLINE_BODY(char value);
extern void far DIRECTIVE_START(int mode);

/* Called for a line end (value is its first character, CR or LF): counts
   the line, skips blanks at the start of the next line and, if the first
   other character is '#', processes the directive (DIRECTIVE_START,
   PREPROC.C).  So directives are found only at the start of a line. */
void far pascal LEX_HASH(char value)
{
    LEX_NEWLINE_BODY(value);
    value = SCAN_NEXT(32);
    if (value == 35)
        DIRECTIVE_START(1);
    else
        INPUT_INDEX--;
}

/* ---- LEX_READ (0A83) ---- */
#pragma option -G- -y-   /* LEX_READ: compiled without -G and without line numbers */

extern int far MACRO_LOOKUP(int context);
extern int far STRING_LENGTH(char far *text);

/* Reads the rest of the current line as text into the token text buffer
   (TOKEN_TEXT_BUFFER), for the preprocessor.  mode 0 reads a #define body
   without expanding macros; mode 1 reads with macros expanded (used for
   #include with a macro name).  context is the POOL_A offset of the macro's
   parameter names (0 for none); a name found there by MACRO_LOOKUP is
   stored as the marker byte 0x80 + parameter number.  Leaves INPUT_INDEX on
   the line end, restores the normal class table and reports an expansion
   that overflowed the buffer. */
void far pascal LEX_READ(int context, int mode)
{
    int value;

    if (mode != 0)
        CHAR_CLASS_PTR = LEX_READ_MODE1_CLASSES + 1;
    else
        CHAR_CLASS_PTR = LEX_READ_MODE0_CLASSES + 1;
    *TOKEN_PTR = 0;
    MACRO_MODE = 1;
    for (;;) {
        switch (LEX_NEXT_TOKEN()) {
        case 0:
            goto finish;
        case 10:
            goto line_end;
        case 49:
            break;
        default:
            continue;
        }
        if ((value = MACRO_LOOKUP(context)) != 0)
            SCAN_WRITE(value + 128);
        else
            TOKEN_PTR += STRING_LENGTH((char far *)TOKEN_PTR);
    }
line_end:
    INPUT_INDEX--;
finish:
    CHAR_CLASS_PTR = CHAR_CLASS + 1;
    if (TOKEN_PTR >= &EMIT_LIMIT)
        REPORT_ERROR(MSG_MACRO_EXPANSION_TOO);
    MACRO_MODE = 0;
    TOKEN_PTR = TOKEN_TEXT_BUFFER;
}
#pragma option -G -y

/* ---- COLLECT_MACRO_ARGUMENTS (0B15) ---- */
static int near pascal READ_MACRO_ARGUMENT(unsigned int far *offset);
/* CO031 0x0B15: collect the parenthesised arguments of a function-like
   macro call into POOL_A and push the expansion context. */

extern unsigned char far pascal BCC_INPUT_BYTE(unsigned int offset);
extern void far pascal PUSH_MACRO_EXPANSION(unsigned int macro, unsigned int arguments, unsigned int token);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *, unsigned int);
extern char far * far pascal STRING_COPY(char far *, char far *);
static void near pascal LEX_ERROR(int value);
extern int  MACRO_EXPANSION_DEPTH;


/* Returns 1 if the expansion was pushed, 0 if a function-like macro name
   was not followed by '(' (then it is an ordinary identifier).  The
   macro's definition (HLINK_MACRO of the name) starts with its parameter
   count, 0xFF for an object-like macro.  Each argument is stored in POOL_A
   as a word (the TOKEN_POOL offset of its raw text, used for # and ##)
   followed by its macro-expanded text (used everywhere else);
   a wrong number of arguments is reported but the expansion still goes
   ahead.  READ_MACRO_ARGUMENT returns 26 when the input ended inside the
   argument list. */
static int near pascal COLLECT_MACRO_ARGUMENTS(void)
{
    unsigned int token;
    unsigned int entry;
    unsigned int first;
    int count;
    char c;
    char *end;
    unsigned int text_offset;
    unsigned int mark;
    register char *text;
    register unsigned int symbol;

    symbol = CURRENT_SYMBOL;
    token = HLINK_W(symbol, HLINK_MACRO);
    count = BCC_INPUT_BYTE(token);
    if (count == 0xFF) {
        MACRO_EXPANSION_DEPTH++;
        PUSH_MACRO_EXPANSION(symbol, 0, token); return 1;
    }
    first = 0;    /* dead store, as in the original */
    do {
        c = SCAN_NEXT(32);
    } while (MACRO_MODE == 0 && (c == 10 || c == 13));
    if (c != '(') {
        INPUT_INDEX--;
        return 0;
    }
    text = TOKEN_PTR;
    MACRO_EXPANSION_DEPTH++;
    c = SCAN_NEXT(32);
    if (c == ')') {
        if (count != 0)
            LEX_ERROR(symbol);
        PUSH_MACRO_EXPANSION(symbol, 0, token);
        return 1;
    } else {
        INPUT_INDEX--;
        c = READ_MACRO_ARGUMENT(&text_offset);
        if (c == 26)
            return 1;
        while (*text == ' ' || *text == '\t')
            text++;
        first = POOL_ALLOC(&POOL_A, 0);
        for (;;) {
            end = text + STRING_LENGTH((char far *)text) - 1;
            while (end >= text && *end == ' ')
                end--;
            end[1] = 0;
            if (count == 0) {
                LEX_ERROR(symbol);
                MACRO_EXPANSION_DEPTH--;
                return 1;
            }
            entry = POOL_ALLOC(&POOL_A, STRING_LENGTH((char far *)text) + 3);
            mark = POOL_A_UNIT;
            *(unsigned int far *)MK_FP(POOL_A, entry) = text_offset;
            STRING_COPY((char far *)((unsigned int far *)MK_FP(POOL_A, entry) + 1), (char far *)text);
            count--;
            if (c != ',')
                break;
            text = TOKEN_PTR;
            c = READ_MACRO_ARGUMENT(&text_offset);
            if (c == 26) {
                POOL_A_USED = 0;
                POOL_A_UNIT = first;
                return 1;
            }
            while (*text == ' ' || *text == '\t')
                text++;
            POOL_A_USED = 0;
            POOL_A_UNIT = mark;
        }
        if (count != 0)
            LEX_ERROR(symbol);
        PUSH_MACRO_EXPANSION(symbol, first, token);
    }
    return 1;
}


/* ---- LEX_ERROR (0CC0) ---- */
extern char far *far NAME_TEXT_COPY();

/* Reports "wrong number of arguments" for the macro whose name node is
   value. */
static void near pascal LEX_ERROR(int value)
{
    REPORT_ERROR(MSG_WRONG_NUMBER_ARGUMENTS, NAME_TEXT_COPY(value));
}

/* ---- NAME_VALIDATE (0CDF) ---- */
extern int far COMPARE_NAME(char far *first, char far *second);
extern char  OPTION_FLAGS;

/* Recognises the predefined macro names.  Returns 0 for any other name,
   1 for __STDC__ (only in strict ANSI mode, LANGUAGE_MODE 1) or __cplusplus
   (only in C++ mode, OPTION_FLAGS bit 0), 2 for __FILE__, 3 for __LINE__,
   4 for __DATE__, 5 for __TIME__ (PRED_NAME_1 .. PRED_NAME_6 hold these
   names without the leading "__").  Also used by #define and #undef to
   refuse redefining them. */
int far pascal NAME_VALIDATE(char far *text)
{
    if (text[0] != 95 || text[1] != 95)
        return 0;
    text += 2;
    if (COMPARE_NAME(text, (char far *)PRED_NAME_1) == 0 && LANGUAGE_MODE == 1) {
return_one:
        return 1;
    }
    if (COMPARE_NAME(text, (char far *)PRED_NAME_2) == 0) {
        if (OPTION_FLAGS & 1) {
            /* Documented exception (dummy statement): keeps the original's
               je 0D37 over its own jmp 0D14 (0D33 -> 0D35).  Without it BC
               folds the goto into a jne 0D14. */
            (void)0;
            goto return_one;
        }
    }
    if (COMPARE_NAME(text, (char far *)PRED_NAME_3) == 0)
        return 2;
    if (COMPARE_NAME(text, (char far *)PRED_NAME_4) == 0)
        return 3;
    if (COMPARE_NAME(text, (char far *)PRED_NAME_5) == 0)
        return 4;
    if (COMPARE_NAME(text, (char far *)PRED_NAME_6) == 0)
        return 5;
    return 0;
}

/* ---- READ_MACRO_ARGUMENT (0DA1) ---- */
/* CO031 0x0DA1: read one macro argument (up to ',' or ')' at depth 0),
   store its text in TOKEN_POOL and its pre-expanded form in POOL_F. */
/* More exactly: the raw text is copied to TOKEN_POOL (its offset goes to
   *offset); a temporary copy in POOL_F is then pushed as input and lexed
   again with the macro-expanding class table, which leaves the expanded
   text in the token text buffer at the starting TOKEN_PTR, where the
   caller COLLECT_MACRO_ARGUMENTS picks it up.  POOL_F is released again.
   Returns the character that ended the argument (',' or ')'), or 26 if
   the input ended or a string in it was unterminated. */

extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *, unsigned int);
extern void far pascal RTL_MEMMOVE(void far *, void far *, unsigned int);

extern char  TOKEN_LIMIT;
extern char  MACRO_MARK_FC_PENDING;

#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* The original searches a value table for this sparse switch (mov cx,15;
   loop), which BC emits only when optimizing for size; -G gives a compare
   tree instead. */
#pragma option -G-
static int near pascal READ_MACRO_ARGUMENT(unsigned int far *offset)
{
    int c;
    unsigned int length;
    signed char *saved_class;
    char *saved_ptr;
    unsigned int saved_unit;
    unsigned int expansion;
    register char *start;
    register int depth;

    saved_ptr = start = TOKEN_PTR;
    *TOKEN_PTR = 0;
    depth = 0;
    for (;;) {
        switch (c = GETBYTE) {
        case ')':
            depth--;
            if (depth < 0)
                goto done;
            SCAN_EMIT_FAR(c);
            break;
        case ',':
            if (depth == 0)
                goto done;
            SCAN_EMIT_FAR(c);
            break;
        case '(':
            depth++;
            SCAN_EMIT_FAR(c);
            break;
        case '/':
            if (GETBYTE != '*') {
                INPUT_INDEX--;
                SCAN_EMIT_FAR(c);
                break;
            }
            COMMENT_BLOCK();
            if (TOKEN_PTR > start && TOKEN_PTR[-1] == ' ')
                continue;
            else
                SCAN_EMIT_FAR(' ');
            continue;
        case '\\':
            c = GETBYTE;
            if (c == 13 || c == 10) {
                LEX_NEWLINE_BODY(c);
                if (TOKEN_PTR > start && TOKEN_PTR[-1] == ' ')
                    continue;
                else
                    SCAN_EMIT_FAR(' ');
                continue;
            }
            INPUT_INDEX--;
            SCAN_EMIT_FAR('\\');
            break;
        case '"':
        case '\'':
            if (COPY_STRING_LITERAL(c, LITERAL_CHAR_EMIT_PTR, 1))
                continue;
            SCAN_EMIT_FAR(c);
            return 26;
        case 10:
        case 13:
            LEX_NEWLINE_BODY(c);
        case 9:
        case ' ':
            if (TOKEN_PTR > start && TOKEN_PTR[-1] == ' ')
                continue;
            else
                SCAN_EMIT_FAR(' ');
            continue;
        case 0xFB:
        case 0xFC:
            SCAN_WRITE(c);
            break;
        case 26:
            goto done;
        case 0xFF:
            c = GETBYTE;
        default:
            if (MACRO_MARK_FC_PENDING) {
                SCAN_WRITE(0xFC);
                MACRO_MARK_FC_PENDING = 0;
            }
            if (CHAR_CLASS[c + 1] == (char)0xF6) {
                unsigned int symbol;

                LEX_WHITESPACE(c);
                symbol = BCC_SYMBOL_CREATE((char far *)TOKEN_PTR, 0);
                if (HLINK_W(symbol, HLINK_MACRO) == 0 && NAME_VALIDATE((char far *)TOKEN_PTR) == 0 &&
                    TOKEN_PTR < &TOKEN_LIMIT) {
                    RTL_MEMMOVE((char far *)(TOKEN_PTR + 1), (char far *)TOKEN_PTR,
                                 STRING_LENGTH((char far *)TOKEN_PTR) + 1);
                    *TOKEN_PTR = 0xFC;
                }
                TOKEN_PTR += STRING_LENGTH((char far *)TOKEN_PTR);
                continue;
            }
            SCAN_EMIT_FAR(c);
            break;
        }
    }
done:
    while (*start == ' ')
        start++;
    while (TOKEN_PTR > start) {
        /* store in the then-branch: no label between the test and the store,
           so BX from the compare is reused */
        if (TOKEN_PTR[-1] == ' ')
            TOKEN_PTR[-1] = 0;
        else
            break;
        TOKEN_PTR--;
    }
    SCAN_EMIT_FAR(26);
    *offset = POOL_ALLOC(&TOKEN_POOL, STRING_LENGTH((char far *)start) + 1);
    STRING_COPY((char far *)MK_FP(TOKEN_POOL, *offset), (char far *)start);
    saved_unit = POOL_F_UNIT;
    length = STRING_LENGTH((char far *)start) + 1;
    length += length & 1;
    expansion = POOL_ALLOC(&POOL_F, length);
    STRING_COPY((char far *)MK_FP(POOL_F, expansion + MACDEF_TEXT), (char far *)start);
    MACRO_EXPANSION_DEPTH++;
    PUSH_MACRO_EXPANSION(0, 0, expansion);
    saved_class = CHAR_CLASS_PTR;
    /* the table LEX_READ selects for reading text with macros expanded */
    CHAR_CLASS_PTR = LEX_READ_MODE1_CLASSES + 1;
    depth = 0;
    TOKEN_PTR = saved_ptr;
    *TOKEN_PTR = 0;
    for (;;) {
        switch (LEX_NEXT_TOKEN()) {
        case 8:
            goto finish;
        case 49:
            break;
        default:
            continue;
        }
        if (MACRO_NAME_UNEXPANDED && TOKEN_PTR < &TOKEN_LIMIT) {
            RTL_MEMMOVE((char far *)(TOKEN_PTR + 1), (char far *)TOKEN_PTR,
                         STRING_LENGTH((char far *)TOKEN_PTR) + 1);
            *TOKEN_PTR = 0xFC;
            TOKEN_PTR++;
        }
        TOKEN_PTR += STRING_LENGTH((char far *)TOKEN_PTR);
    }
finish:
    if (TOKEN_PTR >= &TOKEN_LIMIT)
        REPORT_ERROR(MSG_MACRO_EXPANSION_TOO);
    CHAR_CLASS_PTR = saved_class;
    *TOKEN_PTR = 0;
    TOKEN_PTR = saved_ptr;
    (void)GETBYTE;
    INPUT_INDEX--;
    MACRO_MARK_FC_PENDING = 0;
    POOL_F_USED = 0;
    POOL_F_UNIT = saved_unit;
    return c;
}
#pragma option -G

#undef GETBYTE

/* ---- LEX_NEWLINE (118C) ---- */

extern void far LINE_HOOK(void);

/* Consumes a line end whose first character value has been read: a CR LF
   or LF CR pair counts as one.  Advances CURRENT_LINE and LOGICAL_LINE,
   and records the position where the new line starts.  CTRL_BREAK_SEEN is
   set by the Ctrl-Break handler (rtl/RIRQ1B.C), so once per line the
   compiler checks for a break and, if there was one, LINE_HOOK
   (rtl/RINIT.C) ends the program. */
void far pascal LEX_NEWLINE(char value)
{
    int c;

    c = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
        ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    if (value == 13) {
        if (c != 10)
            INPUT_INDEX--;
    } else if (c != 13) {
        INPUT_INDEX--;
    }
    CURRENT_LINE++;
    LOGICAL_LINE = CURRENT_LINE;
    if (CTRL_BREAK_SEEN != 0)
        LINE_HOOK();
    TOKEN_POSITION = INPUT_POSITION();
}

/* ---- LEX_WHITESPACE (11F6) ---- */
extern char  NAME_LIMIT;

/* Hand-written assembly in the original (lodsb, xlat, loop and stosb, which
   BC's code generator never emits); it is the reason this file was compiled
   through TASM.  The original is a C function with an inline-asm body (BP
   frame, a C call to INPUT_REFILL, a C goto).  Despite its name it scans an
   identifier.  In C terms:
   copy the identifier that starts with value - characters of class 0xF6
   (letter) or 0xF5 (digit) - from the input buffer into the token buffer
   while it has room, refilling the buffer as needed; leave INPUT_INDEX on
   the first other character, then NUL-terminate the copy, cut to
   NAME_LIMIT significant characters.  Characters past TOKEN_LIMIT are
   consumed but not stored; the lookup always uses the base table
   CHAR_CLASS+1 (not CHAR_CLASS_PTR); TOKEN_PTR is left unchanged. */
void far pascal LEX_WHITESPACE(char value)
{
    asm mov di,word ptr DGROUP:TOKEN_PTR;
    asm push di;
    asm push ds;
    asm pop es;
    asm mov bx,offset DGROUP:CHAR_CLASS+1;
    asm cld;
    asm mov dx,word ptr value;
store:
    asm cmp di,offset DGROUP:TOKEN_LIMIT;
    asm jnc load;
    asm mov al,dl;
    asm stosb;
load:
    asm mov cx,word ptr DGROUP:INPUT_LIMIT;
    asm mov ax,word ptr DGROUP:INPUT_INDEX;
    asm mov si,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [si];
    asm mov si,ax;
    asm sub cx,si;
    asm jcxz refill;
buffer_loop:
    asm lodsb;
    asm xor ah,ah;
    asm mov dx,ax;
    asm xlat byte ptr es:[bx];
    asm cmp al,0F6h;
    asm jne not_letter;
name_char:
    asm cmp di,offset DGROUP:TOKEN_LIMIT;
    asm jnc buffer_next;
    asm mov al,dl;
    asm stosb;
buffer_next:
    asm loop buffer_loop;
refill:
    asm push bx;
    asm push cx;
    asm push es;
    asm pop ds;
    INPUT_REFILL();
    asm push ds;
    asm pop es;
    asm pop cx;
    asm pop bx;
    asm cld;
    asm mov dx,ax;
    asm xlat;
    asm cmp al,0F6h;
    asm je store;
    asm cmp al,0F5h;
    asm je store;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    goto finish;
not_letter:
    asm cmp al,0F5h;
    asm je name_char;
finish:
    asm push es;
    asm pop ds;
    asm dec si;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm pop ax;
    asm mov word ptr DGROUP:TOKEN_PTR,ax;
    asm mov cx,di;
    asm sub cx,ax;
    asm mov bl,byte ptr DGROUP:NAME_LIMIT;
    asm xor bh,bh;
    asm cmp cx,bx;
    asm jbe terminate;
    asm add ax,bx;
    asm mov di,ax;
terminate:
    asm xor al,al;
    asm stosb;
}

/* ---- LEX_IDENTIFIER (1284) ---- */

/* Plain C version of the identifier copy: copies the identifier that
   starts with value into the token text buffer, at most NAME_LIMIT
   characters; letters, digits, '@' and '$' count as identifier
   characters.  Extra characters are skipped. */
void far pascal LEX_IDENTIFIER(int value)
{
    register char *p;
    register int remaining;

    p = TOKEN_PTR;
    remaining = NAME_LIMIT;
    do {
        *p++ = value;
        value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
        remaining--;
    } while (remaining != 0 &&
             (CHAR_CLASS[value + 1] == -10 || CHAR_CLASS[value + 1] == -11 ||
              value == 64 || value == 36));
    *p = 0;
    while (CHAR_CLASS[value + 1] == -10 || CHAR_CLASS[value + 1] == -11 ||
           value == 36 || value == 64)
        value = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    INPUT_INDEX--;
}

/* ---- CLASSIFY_IDENTIFIER (1333) ---- */
/* CO031 0x1333 CLASSIFY_IDENTIFIER_BODY (stub 0C94:005C = CLASSIFY_IDENTIFIER): classify an
   identifier just scanned - predefined macros __FILE__/__LINE__/__DATE__/
   __TIME__/__STDC__, defined(), or a macro call. */

extern void far pascal RTL_ITOA10(int, char far *);
extern void far pascal BCC_INPUT_STRING(char far *);
extern int far pascal BCC_SYMBOL_CURRENT_TEST(void);
static int near pascal LEX_DEFINED(void);
extern unsigned int  STRING_POOL_SEG;
extern struct date  CURRENT_DATE;
extern struct time  CURRENT_TIME;
extern char MONTH_ABBREVIATIONS[][3];

#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* Return value: -2 for an ordinary name (MACRO_NAME_UNEXPANDED is then
   set), -1 for a function-like macro name without '(' (also ordinary), or
   a character >= 0 for LEX_NEXT_TOKEN to rescan: the first character of a
   macro's expansion, or the character trick for a predefined name (see the
   file overview).  A name marked 0xFC (MACRO_MARK_FC_PENDING) is never
   expanded; it only gets its name node in CURRENT_SYMBOL. */
int far pascal CLASSIFY_IDENTIFIER(void)
{
    int pending;
    char far *name;
    char buffer[16];
    register unsigned int offset;
    register char *start;

    pending = MACRO_MARK_FC_PENDING;
    MACRO_MARK_FC_PENDING = 0;
    MACRO_NAME_UNEXPANDED = 0;
    if (pending != 0 && MACRO_MARK_FE_SEEN == 0) {
        CURRENT_SYMBOL = BCC_SYMBOL_CREATE((char far *)TOKEN_PTR, 0);
    } else {
        switch (NAME_VALIDATE((char far *)TOKEN_PTR)) {
        case 2:
            start = TOKEN_PTR;
            name = (char far *)MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME);
            while (*name != 0) {
                if (*name == '\\')
                    SCAN_EMIT_FAR('\\');
                SCAN_EMIT_FAR(*name);
                name++;
            }
            offset = POOL_ALLOC(&TOKEN_POOL, STRING_LENGTH((char far *)start) + 1);
            STRING_COPY((char far *)MK_FP(TOKEN_POOL, offset), (char far *)start);
            TOKEN_PTR = start;
set_string:
            PENDING_STRING_TEXT = offset;
            return 34;
        case 3:
            /* __LINE__: push back all digits but the first and return the
               first. */
            RTL_ITOA10(CURRENT_LINE, (char far *)NAME_BUFFER);
            BCC_INPUT_STRING((char far *)(NAME_BUFFER + 1));
            return NAME_BUFFER[0];
        case 1:
            return 49;
        case 4:
            RTL_MEMMOVE((void far *)buffer, (void far *)MONTH_ABBREVIATIONS[CURRENT_DATE.da_mon - 1], 3);
            buffer[3] = ' ';
            buffer[4] = CURRENT_DATE.da_day / 10 + '0';
            buffer[5] = CURRENT_DATE.da_day % 10 + '0';
            buffer[6] = ' ';
            RTL_ITOA10(CURRENT_DATE.da_year, (char far *)(buffer + 7));
            goto store;
        case 5:
            buffer[0] = CURRENT_TIME.ti_hour / 10 + '0';
            buffer[1] = CURRENT_TIME.ti_hour % 10 + '0';
            buffer[2] = ':';
            buffer[3] = CURRENT_TIME.ti_min / 10 + '0';
            buffer[4] = CURRENT_TIME.ti_min % 10 + '0';
            buffer[5] = ':';
            buffer[6] = CURRENT_TIME.ti_sec / 10 + '0';
            buffer[7] = CURRENT_TIME.ti_sec % 10 + '0';
            buffer[8] = 0;
store:
            offset = POOL_ALLOC(&TOKEN_POOL, STRING_LENGTH((char far *)buffer) + 1);
            STRING_COPY((char far *)MK_FP(TOKEN_POOL, offset), (char far *)buffer);
            goto set_string;
        }
        if (MACRO_MODE != 0 && COMPARE_NAME((char far *)TOKEN_PTR, (char far *)STR_DEFINED) == 0)
            return LEX_DEFINED();
        if (BCC_SYMBOL_CURRENT_TEST()) {
            if (COLLECT_MACRO_ARGUMENTS() == 0)
                return -1;
            return GETBYTE;
        }
    }
    MACRO_NAME_UNEXPANDED = 1;
    return -2;
}

#undef GETBYTE

/* ---- LEX_DEFINED (1562) ---- */
#pragma option -G- -y-   /* LEX_DEFINED: compiled without -G and without line numbers */

extern int far pascal SCAN_TOKEN(int value);
extern int far pascal MACRO_DEFINED(char far *name);

/* The defined operator in #if: reads "name" or "(name)" and returns the
   character '1' (49) if the name is a macro, else '0' (48), for the caller
   to rescan as a number.  A syntax error gives '0'. */
static int near pascal LEX_DEFINED(void)
{
    register int value;
    register int parentheses;

    value = SCAN_NEXT(32);
    if (value == 26) {
syntax_error:
        REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
        goto not_defined;
    }
    if (value == 40) {
        parentheses = 1;
        value = SCAN_NEXT(32);
        if (value == 26)
            goto syntax_error;
    } else
        parentheses = 0;
    if (CHAR_CLASS[value + 1] != (char)0xF6) {
        /* Documented exception (dummy statement): keeps the original's
           je 15A9 over its own jmp 1578 (15A5 -> 15A7).  Without it BC
           folds the goto into a jne 1578. */
        (void)0;
        goto syntax_error;
    }
    value = SCAN_TOKEN(value);
    if (parentheses != 0) {
        value = SCAN_NEXT(value);
        if (value != 41) {
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
            INPUT_INDEX--;
        }
    } else
        INPUT_INDEX--;
    if (MACRO_DEFINED((char far *)NAME_BUFFER) != 0)
        return 49;
not_defined:
    return 48;
}
#pragma option -G -y

/* ---- SCAN_NUMBER_TEXT (15F1) ---- */
/* CO031 0x15F1: scan the rest of a numeric literal into the token buffer;
   returns the radix (10/8/16) for an integer, 0 for a floating constant,
   and sets TOKEN_AUX to the literal's type. */

extern int far pascal TOLOWER(int value);

extern char  TOKEN_AUX;

#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* The original compares the class-table pointer as a far pointer (ds:ds). */
#define ANSI_CLASS ((char far *)CHAR_CLASS_PTR == (char far *)(CHAR_CLASS + 1))

/* Built for size like LEX_DEFINED and READ_MACRO_ARGUMENT: the original pops cdecl arguments with
   pop cx (-G gives inc sp; inc sp) and cross-jumps the duplicate tails. */
#pragma option -G-
static int near pascal SCAN_NUMBER_TEXT(char c)
{
    int dot;
    int cls;
    register int base;
    register int exp;

    dot = 0;
    exp = 0;
    if (c == '0') {
        SCAN_EMIT_FAR('0');
        c = GETBYTE;
        if (c == 'x' || c == 'X') {
            MACRO_MARK_FC_PENDING = 0;
            SCAN_EMIT_FAR(c);
            c = GETBYTE;
            cls = CHAR_CLASS[c + 1];
            if (cls != -11 && ANSI_CLASS && (cls != -10 || TOLOWER(c) > 'f'))
                REPORT_ERROR(MSG_INCORRECT_NUMBER);
            base = 16;
        } else
            base = 8;
    } else
        base = 10;
    for (;;) {
        switch (c) {
        case '8':
        case '9':
            if (base == 8) {
                if (!ANSI_CLASS) {
emit:
                    SCAN_EMIT_FAR(c);
                    break;
                }
                REPORT_ERROR(MSG_ILLEGAL_OCTAL_DIGIT);
                break;
            }
        case '0': case '1': case '2': case '3':
        case '4': case '5': case '6': case '7':
            SCAN_EMIT_FAR(c);
            break;
        case '.':
            if (ANSI_CLASS) {
                if (dot)
                    REPORT_ERROR(MSG_TOO_MANY_DECIMAL);
                if (exp)
                    REPORT_ERROR(MSG_MISPLACED_DECIMAL);
                if (base == 16)
                    REPORT_ERROR(MSG_INCORRECT_NUMBER);
            }
            dot = 1;
            base = 0;
            SCAN_EMIT_FAR(c);
            break;
        case 'E':
        case 'e':
            MACRO_MARK_FC_PENDING = 0;
            if (base != 16) {
                if (ANSI_CLASS && exp)
                    REPORT_ERROR(MSG_TOO_MANY_EXPONENTS);
                exp = 1;
                base = 0;
                SCAN_EMIT_FAR(c);
                c = GETBYTE;
                if (c == '-' || c == '+') {
                    SCAN_EMIT_FAR(c);
                    c = GETBYTE;
                }
                /* the original shares the emit in case 8/9 here; under -y the
                   compiler does not merge a then-block tail, so jump to it */
                if (CHAR_CLASS[c + 1] == (char)0xF5)
                    goto emit;
                if (ANSI_CLASS)
                    REPORT_ERROR(MSG_INCORRECT_NUMBER);
                INPUT_INDEX--;
                TOKEN_AUX = 10;
                return 0;
            } else {
                SCAN_EMIT_FAR(c);
                break;
            }
        case 'A': case 'B': case 'C': case 'D':
        case 'a': case 'b': case 'c': case 'd':
            if (base != 16)
                goto int_end;
            MACRO_MARK_FC_PENDING = 0;
            SCAN_EMIT_FAR(c);
            break;
        case 'F':
        case 'f':
            if (ANSI_CLASS && base != 16 && dot == 0 && exp == 0)
                REPORT_ERROR(MSG_INCORRECT_NUMBER);
            MACRO_MARK_FC_PENDING = 0;
            SCAN_EMIT_FAR(c);
            if (base == 16)
                break;
            TOKEN_AUX = 9;
            return 0;
        case 'L':
        case 'l':
            MACRO_MARK_FC_PENDING = 0;
            SCAN_EMIT_FAR(c);
            if (dot || exp) {
                TOKEN_AUX = 11;
                return 0;
            }
            TOKEN_AUX = 7;
            c = GETBYTE;
            if (c == 'u' || c == 'U') {
                TOKEN_AUX = 8;
                SCAN_EMIT_FAR(c);
            } else
                INPUT_INDEX--;
            return base;
        case 'U':
        case 'u':
            if (dot || exp) {
                INPUT_INDEX--;
                TOKEN_AUX = 10;
                return 0;
            }
            MACRO_MARK_FC_PENDING = 0;
            SCAN_EMIT_FAR(c);
            TOKEN_AUX = 6;
            c = GETBYTE;
            if (c == 'l' || c == 'L') {
                TOKEN_AUX = 8;
                SCAN_EMIT_FAR(c);
            } else
                INPUT_INDEX--;
            return base;
        default:
            if (dot || exp) {
                INPUT_INDEX--;
                TOKEN_AUX = 10;
                return 0;
            }
int_end:
            INPUT_INDEX--;
            TOKEN_AUX = 5;
            return base;
        }
        c = GETBYTE;
    }
}

#pragma option -G

#undef GETBYTE
#undef ANSI_CLASS

/* ---- LEX_COMPARE (1A24) ---- */

/* Compare the 10-byte value at text with PREDEFINED_1. */
/* Returns nonzero if the 10 bytes are equal.  PREDEFINED_1 is probably the
   long double value the run-time scanner returns on overflow (infinity),
   so CONVERT_NUMBER_TOKEN uses this to detect a floating constant out of
   range. */
int far pascal LEX_COMPARE(char far *text)
{
    char far *entry;
    char far *input;

    input = text;
    entry = PREDEFINED_1;
    while (entry < PREDEFINED_1 + 10) {
        if (*entry != *input)
            break;
        entry++;
        input++;
    }
    return entry >= PREDEFINED_1 + 10;
}

/* ---- CONVERT_NUMBER_TOKEN (1A6F) ---- */
/* CO031 0x1A6F: convert the numeric literal in TOKEN_TEXT_BUFFER (radix from
   SCAN_NUMBER_TEXT, 0 = floating) into TOKEN_CONST_VALUE and pick its type. */

extern void far pascal RTL_SCAN_LDOUBLE(char far *text, void far *value);
extern void far pascal RTL_LDOUBLE_ROUND_TO_FLOAT(void far *value);
extern void far pascal RTL_LDOUBLE_ROUND_TO_DOUBLE(void far *value);
extern void far * far pascal RTL_MEMSET(void far *, int, unsigned int);
extern void far cdecl REPORT_WARNING(int error);

extern unsigned long  MASK_C;
extern unsigned long  BCC_ENUM_LIMIT_LO;

/* Built without -G from here to the end of the file: the original pops
   cdecl arguments with pop cx (-G gives inc sp; inc sp). */
#pragma option -G-
/* Returns token 0x33 for a floating constant (rounded to float or double
   by its suffix; out of range is an error in strict ANSI mode) or 0x32 for
   an integer.  An integer without a suffix that does not fit its type is
   widened as C requires: decimal to long then unsigned long, octal and hex
   to unsigned, long, unsigned long.  BCC_ENUM_LIMIT_LO, MASK_C and
   LONG_MAX_VALUE are probably 0x7FFF, 0xFFFF and 0x7FFFFFFF.  Widening to
   long gives the warning "constant is long". */
static int near pascal CONVERT_NUMBER_TOKEN(int base)
{
    register int c;
    register char *p;

    TOKEN_PTR = TOKEN_TEXT_BUFFER;
    if (base == 0) {
        RTL_SCAN_LDOUBLE((char far *)TOKEN_TEXT_BUFFER, (void far *)&TOKEN_CONST_VALUE);
        if (TOKEN_AUX == 9)
            RTL_LDOUBLE_ROUND_TO_FLOAT((void far *)&TOKEN_CONST_VALUE);
        else if (TOKEN_AUX == 10)
            RTL_LDOUBLE_ROUND_TO_DOUBLE((void far *)&TOKEN_CONST_VALUE);
        if (LANGUAGE_MODE == 1 && LEX_COMPARE((char far *)&TOKEN_CONST_VALUE)) {
            REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
            RTL_MEMSET((void far *)&TOKEN_CONST_VALUE, 0, 10);
        }
        return 51;
    }
    TOKEN_CONST_VALUE = 0;
    if (base == 16)
        p = TOKEN_TEXT_BUFFER + 2;
    else
        p = TOKEN_TEXT_BUFFER;
    while (*p != 0) {
        c = TOLOWER(*p);
        if (c == 'l' || c == 'u')
            break;
        if (CHAR_CLASS[c + 1] == (char)0xF6)
            c += 10 - 'a';
        else
            c -= '0';
        TOKEN_CONST_VALUE = TOKEN_CONST_VALUE * base + c;
        p++;
    }
    c = TOKEN_AUX;
    switch (TOKEN_AUX) {
    case 5:
        if (base == 10) {
            if (TOKEN_CONST_VALUE > LONG_MAX_VALUE) TOKEN_AUX = 8;
            else if (TOKEN_CONST_VALUE > BCC_ENUM_LIMIT_LO)
                TOKEN_AUX = 7;
        } else {
            if (TOKEN_CONST_VALUE > LONG_MAX_VALUE)
                TOKEN_AUX = 8;
            else if (TOKEN_CONST_VALUE > MASK_C)
                TOKEN_AUX = 7;
            else if (TOKEN_CONST_VALUE > BCC_ENUM_LIMIT_LO)
                TOKEN_AUX = 6;
        }
        break;
    case 6:
        if (TOKEN_CONST_VALUE > MASK_C)
            TOKEN_AUX = 8;
        break;
    case 7:
        if (TOKEN_CONST_VALUE > LONG_MAX_VALUE)
            TOKEN_AUX = 8;
    }
    if (TOKEN_AUX >= 7 && c < 7)
        REPORT_WARNING(MSG_CONSTANT_LONG);
    return 50;
}

/* ---- LEX_CHARACTER (1C5E) ---- */

int far pascal DECODE_ESCAPE_CHAR(char quote);
extern char  UNSIGNED_CHAR;
extern long (far pascal *TOKEN_CONVERT)(long value, int type);

/* Scans a character constant after the opening quote.  One character
   gives token 0x65 with the value sign- or zero-extended as plain char is
   (UNSIGNED_CHAR, the -K option); two characters give an int constant
   (0x32) holding both bytes; more than two is an error.  The value goes
   to TOKEN_CONST_VALUE through TOKEN_CONVERT with type TK_INT. */
static int near pascal LEX_CHARACTER(void)
{
    int c;
    long value;
    register int count;

    ((int *)&value)[0] = 0;
    count = 0;
    while ((c = DECODE_ESCAPE_CHAR(39)) != -1) {
        if (count < 2)
            ((char *)&value)[count] = c;
        count++;
    }
    if (count > 2) {
        REPORT_ERROR(MSG_CHARACTER_CONSTANT_TOO);
    }
    if (count == 1) {
        TOKEN_TYPE = 101;
        if (UNSIGNED_CHAR != 0)
            value = (unsigned char)value;
        else
            value = (signed char)value;
    }
    TOKEN_CONST_VALUE = TOKEN_CONVERT((int)value, 5);
    TOKEN_AUX = 5;
    return count == 1 ? 101 : 50;
}

/* ---- DECODE_ESCAPE_CHAR: escape decoding (1CF0) ---- */

static void near LEX_WARNING(void);
extern char  _CTYPE[];

/* Reads one character of a string or character constant from the input,
   decoding escapes (\n, \x41, \101 ...).  Returns -1 at the closing quote,
   or, after reporting "unterminated string", at a line end or end of
   input.  A backslash before a line end is a splice and is skipped.  Hex
   and octal values above INT_LIMIT are errors; long hex escapes warn. */
int far pascal DECODE_ESCAPE_CHAR(char quote)
{
    int c;
    int error;
    register int value;
    register int count;

restart:
    error = 0;
    c = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
        ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
    if (c == 26 || c == 10 || c == 13) {
        LEX_WARNING();
        INPUT_INDEX--;
        return -1;
    }
    if (c == quote)
        return -1;
    if (c == 92) {
        c = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
            ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
        switch (c) {
        case 26:
            LEX_WARNING();
            return -1;
        case 'a': return 7;
        case 't': return 9;
        case 'n': return 10;
        case 'b': return 8;
        case 'r': return 13;
        case 'f': return 12;
        case 'v': return 11;
        case 'x':
            c = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
            if (!(_CTYPE[c + 1] & 0x12)) {
                INPUT_INDEX--;
                return 'x';
            }
            value = 0;
            count = 1;
            do {
                value <<= 4;
                value += (_CTYPE[c + 1] & 2) ? c - 48 : TOLOWER(c) - 87;
                if (!error && (long)value > INT_LIMIT) {
                    LOGICAL_LINE = CURRENT_LINE;
                    REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                    error = 1;
                    value = 0;
                }
                c = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
                if (!(_CTYPE[c + 1] & 0x12)) {
                    INPUT_INDEX--;
                    if (count > 3)
                        REPORT_WARNING(MSG_HEXADECIMAL_VALUE);
                    return value;
                }
                count++;
            } while (1);
        case 10:
        case 13:
            LEX_NEWLINE(c);
            goto restart;
        case '0': case '1': case '2': case '3':
        case '4': case '5': case '6': case '7':
            value = 0;
            count = 0;
            while (count < 3) {
                value = value * 8 + c - 48;
                if (!error && (long)value > INT_LIMIT) {
                    LOGICAL_LINE = CURRENT_LINE;
                    REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                    error = 1;
                    value = 0;
                }
                c = INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() :
                    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER, 0))[INPUT_INDEX++];
                if (c >= '0' && c <= '7')
                    count++;
                else
                    break;
            }
            if (quote == 39 && c != 39) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_CHARACTER_CONSTANT_TOO);
            }
            INPUT_INDEX--;
            return value;
        default:
            return c;
        }
    }
    return c;
}

/* ---- LEX_WARNING (1FAC) ---- */

/* Despite its name this reports an error: "unterminated string or
   character constant". */
static void near pascal LEX_WARNING(void)
{
    REPORT_ERROR(MSG_UNTERMINATED_STRING);
}

/* ---- LEX_STRING_ESCAPE (1FBD) ---- */

/* The same escape decoding as DECODE_ESCAPE_CHAR, but for text already in
   TOKEN_POOL (a string produced by macro expansion).  *position is the
   offset of the backslash on entry and is left on the last character used. */
static char far pascal LEX_STRING_ESCAPE(unsigned int far *position)
{
    int c;
    int value;
    register unsigned int offset;
    register int count;

    offset = *position;
    offset++;
    c = ((unsigned char far *)MK_FP(TOKEN_POOL, 0))[offset];
    *position = offset;
    switch (c) {
    case 'a': return 7;
    case 't': return 9;
    case 'n': return 10;
    case 'b': return 8;
    case 'r': return 13;
    case 'f': return 12;
    case 'v': return 11;
    case 'x':
        /* The original re-reads the 'x' itself here, so \x in pool text
           yields 'x' and consumes no hex digits.  Kept as in the original. */
        c = ((unsigned char far *)MK_FP(TOKEN_POOL, 0))[offset];
        offset++;
        if (!(_CTYPE[c + 1] & 0x12))
            return 'x';
        value = 0;
        count = 1;
        do {
            value <<= 4;
            value += (_CTYPE[c + 1] & 2) ? c - 48 : TOLOWER(c) - 87;
            if ((long)value > INT_LIMIT) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                value = 0;
            }
            c = ((unsigned char far *)MK_FP(TOKEN_POOL, 0))[offset];
            if (!(_CTYPE[c + 1] & 0x12)) {
                *position = offset - 1;
                if (count > 2)
                    REPORT_WARNING(MSG_HEXADECIMAL_VALUE);
                return value;
            }
            offset++;
            count++;
        } while (1);
    case '0': case '1': case '2': case '3':
    case '4': case '5': case '6': case '7':
        offset++;
        value = 0;
        count = 0;
        while (count < 3) {
            value = value * 8 + c - 48;
            if ((long)value > INT_LIMIT) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                value = 0;
            }
            c = ((unsigned char far *)MK_FP(TOKEN_POOL, 0))[offset];
            if (c >= '0' && c <= '7') {
                *position = offset;
                offset++;
                count++;
            } else {
                break;
            }
        }
        return value;
    default:
        return c;
    }
}

/* ---- BCC_LEX_RESTORE: pool replay (217F) ---- */

extern void far EMIT_VALUE(char value);
extern void (far *BYTE_HOOK)(char value);

#define POOL ((unsigned char far *)MK_FP(TOKEN_POOL, 0))

/* Replay the pending pool text (or read a fresh string literal) and pass
   each character to the output selected by mode, counting them. */
void far pascal BCC_LEX_RESTORE(register int mode)
{
    int value;
    char c;
    unsigned int offset;
    register int quote;

    *(unsigned int *)&TOKEN_CONST_VALUE = 0;
    quote = 0;
    if (PENDING_STRING_TEXT != 0) {
        offset = PENDING_STRING_TEXT;
        while (POOL[offset] != 0) {
            c = POOL[offset];
            if ((unsigned char)c == 0xFC || (unsigned char)c == 0xFB)
                goto advance;
            if ((unsigned char)c == 0xFF) {
                offset++;
                c = POOL[offset];
            } else if (POOL[offset] == 26) {
                break;
            } else if (POOL[offset] == 92) {
                if (quote == 0)
                    c = LEX_STRING_ESCAPE((unsigned int far *)&offset);
                else if (*(unsigned char far *)MK_FP(TOKEN_POOL, offset + TOKPOOL_NEXT_CHAR) == quote) {
                    if (mode == 2)
                        EMIT_VALUE(92);
                    else if (mode == 1)
                        BYTE_HOOK(92);
                    offset++;
                    c = POOL[offset];
                }
            } else if (POOL[offset] == 34 || POOL[offset] == 39) {
                if (quote == 0)
                    quote = POOL[offset];
                else if (POOL[offset] == quote)
                    quote = 0;
            }
            (*(unsigned int *)&TOKEN_CONST_VALUE)++;
            if (mode == 2)
                EMIT_VALUE(c);
            else if (mode == 1)
                BYTE_HOOK(c);
advance:
            offset++;
        }
        PENDING_STRING_TEXT = 0;
    } else {
        while ((value = DECODE_ESCAPE_CHAR(34)) != -1) {
            (*(unsigned int *)&TOKEN_CONST_VALUE)++;
            if (mode == 2)
                EMIT_VALUE(value);
            else if (mode == 1)
                BYTE_HOOK(value);
        }
    }
}

#undef POOL

/* ---- NEXT_POOL_CHARACTER: next pool character (22F4) ---- */

#define POOL ((unsigned char far *)MK_FP(TOKEN_POOL, 0))

/* Return the next character of the pending pool text (or of a fresh
   string literal), or -1 at its end. */
/* Documented exception (undefined behaviour): quote is a register local
   that is cleared only when reset == 0 (22F4..); otherwise it is read
   uninitialised, holding whatever the caller left in the register.  The
   original does the same. */
int far pascal NEXT_POOL_CHARACTER(int reset)
{
    register int value;
    register int quote;

    if (PENDING_STRING_TEXT != 0) {
        if (reset == 0)
            quote = 0;
        while (POOL[PENDING_STRING_TEXT] == 0xFC || POOL[PENDING_STRING_TEXT] == 0xFB)
            PENDING_STRING_TEXT++;
        value = POOL[PENDING_STRING_TEXT];
        if (value == 0xFF) {
            PENDING_STRING_TEXT++;
            value = POOL[PENDING_STRING_TEXT];
        } else if (value == 92) {
            if (quote == 0)
                value = (unsigned char)LEX_STRING_ESCAPE((unsigned int far *)&PENDING_STRING_TEXT);
            else if (*(unsigned char far *)MK_FP(TOKEN_POOL, PENDING_STRING_TEXT + TOKPOOL_NEXT_CHAR) == quote)
                quote = 0;
        } else if (value == 26 || value == 0) {
            PENDING_STRING_TEXT = 0;
            return -1;
        } else if (value == 34 || value == 39) {
            if (quote == 0)
                quote = value;
            else if (quote == value)
                quote = 0;
        }
        PENDING_STRING_TEXT++;
    } else
        value = DECODE_ESCAPE_CHAR(34);
    return value;
}

#undef POOL

/* ---- FLUSH_PENDING_POOL: pool flush (23B0) ---- */
extern char far *PENDING_POOL;
/* Copies a string into POOL_HASH and returns its offset: the pending text
   at PENDING_POOL (0xFC marks dropped) if there is one, else a string
   literal read from the input; the copy ends with ';'.  Used by the C
   front end's declarator parser for the string literal that may follow
   '*' in a pointer declarator (PARSE_DECLARATOR_TREE in CDECLR.C), kept as
   the pointer type's base name (TYPE_C_PTR_BASE). */
unsigned int far pascal FLUSH_PENDING_POOL(void)
{
    int value;
    /* volatile: the original reloads the cursor (les bx) for each access. */
    char far * volatile pending;
    unsigned int result;
    /* count is never read; the original keeps it too. */
    register int count = 0;
    register char *position;

    /* Documented exception (duplicate statement): the original clears SI
       twice (xor si,si at 23B8 and 23BA). */
    count = 0;
    position = TOKEN_PTR;
    if (PENDING_POOL != 0) {
        pending = PENDING_POOL;
        while (*pending != 0) {
            if ((unsigned char)*pending != 0xFC) {
                count++;
                SCAN_EMIT_FAR((unsigned char)*pending);
            }
            pending++;
        }
        PENDING_POOL = 0;
    } else
        while ((value = DECODE_ESCAPE_CHAR('"')) != -1) {
            count++;
            SCAN_EMIT_FAR((unsigned char)value);
        }
    SCAN_EMIT_FAR(';');
    result = POOL_ALLOC(&POOL_HASH, STRING_LENGTH((char far *)position) + 1);
    STRING_COPY((char far *)MK_FP(POOL_HASH, result), (char far *)position);
    TOKEN_PTR = position;
    return result;
}
#pragma option -G

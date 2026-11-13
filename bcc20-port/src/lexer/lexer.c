/* lexer.c: from bcc20/src/lexer/LEXER.C: the lexer.

   It turns the bytes of the current input (input.c) into tokens and does most of the
   preprocessor's character-level work: reading #define bodies, collecting and pre-expanding
   macro arguments, expanding the predefined macros.  LEX_NEXT_TOKEN writes the token code
   into the first word of TOKEN_TYPE, its position (TOKEN_LINE, TOKEN_LENGTH,
   TOKEN_FILE_NODE) and value (TOKEN_CONST_VALUE: an identifier's name node, an integer, or a
   10-byte real; TOKEN_AUX: the constant's type kind).  Codes made here besides operators:
   31h identifier, 32h integer, 33h real, 34h string literal (its characters are read later,
   NEXT_POOL_CHARACTER), 65h character constant, 0 end of input.

   Every character has a class in a 256-entry table; CHAR_CLASS_PTR selects one of three:
   CHAR_CLASS+1 (C tokens), LEX_READ_MODE0_CLASSES+1 (a #define body read as text) and
   LEX_READ_MODE1_CLASSES+1 (text read with macros expanded).  In the text modes most classes
   copy characters into the token text buffer (TOKEN_PTR in TOKEN_TEXT_BUFFER, up to
   TOKEN_LIMIT) instead of returning tokens.  Marker bytes in macro text: 80h+n a parameter,
   FDh # (stringize), FEh ## (paste), FCh a name not to expand again, FFh "the next byte is
   literal", 26 the end of a text.  Predefined macros and defined() are expanded by returning
   a character for LEX_NEXT_TOKEN to rescan ('1' or '0', or '"' with PENDING_STRING_TEXT set,
   or the first digit of __LINE__ with the rest pushed back into the input).

   NEXT_POOL_CHARACTER is not translated yet: the original reads a register its caller left
   (its `quote' is uninitialised unless reset is 0), which depends on the caller's register
   allocation; the native build has to decide what to do there (docs/FINDINGS.md). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"
#include "variadic.h"

/* globals as this file declares them */
#define INIT_OPTION SB(INIT_OPTION_P)
#define CHAR_CLASS_PTR W(CHAR_CLASS_PTR_P)          /* near pointer into a class table */
#define CHAR_CLASS (FP_OFF(CHAR_CLASS_P))            /* the table's near address */
#define TOKEN_POSITION SD(TOKEN_POSITION_P)
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define TOKEN_CONST_VALUE D(TOKEN_CONST_VALUE_P)
#define TOKEN_CONST_LOW W(TOKEN_CONST_VALUE_P)
#define LITERAL_CHAR_EMIT_PTR D(LITERAL_CHAR_EMIT_PTR_P)
#define NAME_LIMIT SB(NAME_LIMIT_P)
#define OPTION_FLAGS SB(OPTION_FLAGS_P)
#define TOKEN_AUX SB(TOKEN_AUX_P)
#define MASK_C D(MASK_C_P)
#define BCC_ENUM_LIMIT_LO D(BCC_ENUM_LIMIT_LO_P)
#define UNSIGNED_CHAR SB(UNSIGNED_CHAR_P)
#define TOKEN_CONVERT D(TOKEN_CONVERT_P)
#define BYTE_HOOK D(BYTE_HOOK_P)
#undef PENDING_POOL
#define PENDING_POOL D(PENDING_POOL_P)              /* char far * in this file */
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define MACRO_EXPANSION_DEPTH W(MACRO_EXPANSION_DEPTH_P)
#define MACRO_MARK_FC_PENDING SB(MACRO_MARK_FC_PENDING_P)
#define TOKEN_TYPE_WORD W(TOKEN_TYPE_P)

#define DS(o) DSPTR(o)                               /* a near pointer as a far one */
#define CLASS_OF(table, c) SB(DS((table) + (c)))
#define BASE_CLASS(c) SB(fp_add(CHAR_CLASS_P, (c) + 1))
#define TOKEN_TEXT FP_OFF(TOKEN_TEXT_BUFFER_P)
#define TOKEN_END FP_OFF(TOKEN_LIMIT_P)              /* &TOKEN_LIMIT */
#define TOKEN_PREV SB(DS(TOKEN_PTR - 1))             /* TOKEN_PTR[-1] */

static u8 getbyte(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : B(MK_FP(W(DS(INPUT_BUFFER)), INPUT_INDEX++));
}

static int class_table(u16 n) { return CHAR_CLASS_PTR == CHAR_CLASS + n; }

static void mark_token(void)
{
    TOKEN_LINE = CURRENT_LINE;
    TOKEN_LENGTH = (u16)INPUT_POSITION() - (u16)TOKEN_POSITION;
    TOKEN_FILE_NODE = LEX_FILE_SERIAL_NODE;
}

static i16 set_token(i16 t)
{
    TOKEN_TYPE_WORD = (u16)t;
    return t;
}

/* the lexer's six pools for a new compile, under the compile's owner tag */
void INIT_LEXER_POOLS(void)
{
    SET_DEFAULT_OWNER_TAG((u8)INIT_OPTION);
    POOL_A_UNIT = POOL_A_STEP = 1;
    POOL_A_USED = 0;
    POOL_INIT(POOL_A_P, 1);
    CONDITION_MARK = LINE_POOL_STEP = 0;
    CONDITION_STATE = 0;
    POOL_INIT(LINE_POOL_P, 0);
    CONTEXT_SEG_UNIT = CONTEXT_SEG_STEP = 2;
    CONTEXT_SEG_USED = 0;
    POOL_INIT(CONTEXT_SEG_P, 2);
    TOKEN_POOL_UNIT = TOKEN_POOL_STEP = 1;
    TOKEN_POOL_USED = 0;
    POOL_INIT(TOKEN_POOL_P, 1);
    POOL_E_UNIT = POOL_E_STEP = 2;
    POOL_E_USED = 0;
    POOL_INIT(POOL_E_P, 2);
    POOL_F_UNIT = POOL_F_STEP = 1;
    POOL_F_USED = 0;
    POOL_INIT(POOL_F_P, 1);
}

/* reset for a new source file: no input, the normal class table, an empty token buffer
   and empty current and lookahead tokens (82h, none yet) */
void INIT_LEXER_STATE(void)
{
    CONTEXT_PTR = 0;
    CHAR_CLASS_PTR = CHAR_CLASS + 1;
    TOKEN_PTR = TOKEN_TEXT;
    CURRENT_FILE_CONTEXT = 0;
    LEXER_INIT_CLEARED_WORD = 0;
    FREE_MACRO_CONTEXT_LIST = 0;
    LINE_RECORD = 0;
    PENDING_STRING_TEXT = 0;
    TOKEN_TYPE_WORD = 0x82;
    W(CURRENT_TOKEN_RECORD_P) = 0x82;
    CURRENT_TOKEN = 0x82;
}

static i16 SCAN_NUMBER_TEXT_(i8 c);
static i16 CONVERT_NUMBER_TOKEN_(i16 base);

/* if the token buffer does not end in a blank, add one */
static void emit_blank(void)
{
    if (TOKEN_PTR <= TOKEN_TEXT || TOKEN_PREV != ' ')
        SCAN_EMIT_FAR(' ');
}

/* one token, its code also stored in TOKEN_TYPE.  A case that breaks has consumed
   something that is not a token and goes round for the next character.  Operators have a
   class that is minus an index into SINGLE_CHAR_TOKEN_TABLE (x), DOUBLED_CHAR_TOKEN_TABLE
   (xx) and OP_ASSIGN_TOKEN_TABLE (x=). */
i16 LEX_NEXT_TOKEN(void)
{
    i16 c, c2, cls;
    for (c = getbyte();; c = getbyte()) {
    reclass:
        cls = CLASS_OF(CHAR_CLASS_PTR, c);
        switch (cls) {
        case -10:   /* a letter; L' and L" start wide constants: the L is dropped */
            if (c == 'L') {
                c2 = getbyte();
                if (c2 == '\'' || c2 == '"') {
                    if (!class_table(1))
                        SCAN_EMIT_FAR((i8)c);
                    c = c2;
                    goto reclass;
                }
                INPUT_INDEX--;
            }
            mark_token();
            MACRO_MARK_FE_SEEN = 0;
            LEX_WHITESPACE((i8)c);
            if (class_table(0x101))
                return set_token(0x31);
            c = CLASSIFY_IDENTIFIER();   /* >= 0: a character to rescan */
            if (c >= 0)
                goto reclass;
            if (class_table(0x201))
                return set_token(0x31);
            TOKEN_CONST_LOW = CURRENT_SYMBOL;
            c = SW(MK_FP(HASH_CHAIN_LINK_SEG, CURRENT_SYMBOL + HLINK_TOKEN));
            if (c == 0)
                return set_token(0x31);
            if (MACRO_MODE && LANGUAGE_MODE == 1)
                return set_token(0x31);
            return set_token(c);
        default:
            mark_token();
            return set_token(cls);
        case -22:   /* a line splice, '?' after it (token 20h), or an illegal character */
            c2 = getbyte();
            if (c2 == 10 || c2 == 13) {
                LEX_NEWLINE((i8)c2);
                break;
            }
            if (c2 == '?') {
                mark_token();
                return set_token(0x20);
            }
            INPUT_INDEX--;
            /* fall through */
        case -18:
            REPORT_ERROR(MSG_ILLEGAL_CHARACTER_0X, c, c);
            break;
        case -25:   /* the end of the current input */
            if (POP_INPUT_CONTEXT(0))
                break;
            return set_token(0);
        case -20:   /* a line end: a directive may start; in a text mode it ends the read */
            if (MACRO_MODE)
                return set_token(10);
            LEX_HASH((i8)c);
            break;
        case -11:
            mark_token();
            cls = SCAN_NUMBER_TEXT_((i8)c);
            if (class_table(1))
                return set_token(CONVERT_NUMBER_TOKEN_(cls));
            break;
        case -5:    /* '/': a comment (// only when not strict ANSI), or / /= */
            mark_token();
            c2 = getbyte();
            if (c2 == '*') {
                COMMENT_BLOCK();
                break;
            }
            if (LANGUAGE_MODE != 1 && c2 == '/') {
                COMMENT_LINE();
                break;
            }
            if (DOUBLED_CHAR_TOKEN_TABLE_AT(5) && c2 == c)
                return set_token(DOUBLED_CHAR_TOKEN_TABLE_AT(5));
            if (c2 == '=')
                return set_token(OP_ASSIGN_TOKEN_TABLE_AT(5));
            INPUT_INDEX--;
            return set_token(SINGLE_CHAR_TOKEN_TABLE_AT(5));
        case 0: case -1: case -2: case -3: case -4:
        case -6: case -7: case -8:
            cls = -cls;
            mark_token();
            c2 = getbyte();
            if (DOUBLED_CHAR_TOKEN_TABLE_AT(cls) && c2 == c)
                return set_token(DOUBLED_CHAR_TOKEN_TABLE_AT(cls));
            if (c2 == '=')
                return set_token(OP_ASSIGN_TOKEN_TABLE_AT(cls));
            INPUT_INDEX--;
            return set_token(SINGLE_CHAR_TOKEN_TABLE_AT(cls));
        case -12:   /* '"': only the token; the characters are read later */
            mark_token();
            return set_token(0x34);
        case -14:
            mark_token();
            return set_token(LEX_CHARACTER());
        case -34:
            mark_token();
            c = getbyte();
            if (c == ':')
                return set_token(0x67);
            INPUT_INDEX--;
            return set_token(0x21);
        case -15:
            mark_token();
            c = getbyte();
            if (c == '-')
                return set_token(0x2E);
            if (c == '=')
                return set_token(0x0D);
            if (c == '>') {
                c = getbyte();
                if (c == '*')
                    return set_token(0x66);
                INPUT_INDEX--;
                return set_token(0x30);
            }
            INPUT_INDEX--;
            return set_token(0x17);
        case -16:
            mark_token();
            c = getbyte();
            if (CLASS_OF(CHAR_CLASS_PTR, c) == -11) {
                INPUT_INDEX--;
                cls = SCAN_NUMBER_TEXT_('.');
                return set_token(CONVERT_NUMBER_TOKEN_(cls));
            }
            if (c == '.') {
                c = getbyte();
                if (c != '.') {
                    REPORT_ERROR(MSG_TWO_CONSECUTIVE_DOTS);
                    INPUT_INDEX--;
                    return set_token(0x2F);
                }
                return set_token(9);
            }
            if (c == '*')
                return set_token(0x64);
            INPUT_INDEX--;
            return set_token(0x2F);
        case -17:
            mark_token();
            c = getbyte();
            if (c == '=')
                return set_token(0x28);
            if (c == '<') {
                c = getbyte();
                if (c == '=')
                    return set_token(0x14);
                INPUT_INDEX--;
                return set_token(0x1E);
            }
            INPUT_INDEX--;
            return set_token(0x26);
        case -19:
            mark_token();
            c = getbyte();
            if (c == '=')
                return set_token(0x29);
            if (c == '>') {
                c = getbyte();
                if (c == '=')
                    return set_token(0x15);
                INPUT_INDEX--;
                return set_token(0x1F);
            }
            INPUT_INDEX--;
            return set_token(0x27);
        /* the text-mode classes: backslash, line ends, comments and blanks are copied (a
           run of blanks or a comment becomes one blank), quoted text is copied whole, # and
           ## become the markers FDh and FEh */
        case -28:
            c = getbyte();
            if (c != 10 && c != 13) {
                INPUT_INDEX--;
                SCAN_EMIT_FAR('\\');
            } else
                LEX_NEWLINE((i8)c);
            break;
        case -32:
            c = getbyte();
            if (c != 10 && c != 13)
                SCAN_EMIT_FAR((i8)c);
            else
                LEX_NEWLINE((i8)c);
            break;
        case -30:
            c = getbyte();
            if (c == '*') {
                COMMENT_BLOCK();
                emit_blank();
            } else if (LANGUAGE_MODE != 1 && c == '/') {
                COMMENT_LINE();
                emit_blank();
            } else {
                INPUT_INDEX--;
                SCAN_EMIT_FAR('/');
            }
            break;
        case -33:
            emit_blank();
            break;
        case -26:
            SCAN_EMIT_FAR((i8)c);
            break;
        case -27:
            if (COPY_STRING_LITERAL((i8)c, LITERAL_CHAR_EMIT_PTR, 1))
                break;
            return set_token(10);
        case -31:
            if (COPY_STRING_LITERAL((i8)c, LITERAL_CHAR_EMIT_PTR, 0))
                break;
            return set_token(10);
        case -29:
            c = getbyte();
            if (c == '#') {
                while (TOKEN_PTR > TOKEN_TEXT && TOKEN_PREV == ' ')
                    TOKEN_PTR--;
                SCAN_WRITE((i8)0xFE);
                SCAN_NEXT(' ');
            } else {
                SCAN_WRITE((i8)0xFD);
                SCAN_NEXT(c);
            }
            INPUT_INDEX--;
            break;
        case -9:
            break;
        }
    }
}

/* a line end (value is its first character): counts the line, skips blanks at the start
   of the next line and, if the first other character is '#', processes the directive, so
   directives are found only at the start of a line */
void LEX_HASH(i8 value)
{
    LEX_NEWLINE(value);
    value = (i8)SCAN_NEXT(32);
    if (value == 35)
        DIRECTIVE_START(1);
    else
        INPUT_INDEX--;
}

/* read the rest of the line as text into TOKEN_TEXT_BUFFER: mode 0 a #define body without
   expanding macros, mode 1 with macros expanded.  context is the POOL_A offset of the
   macro's parameter names (0 for none); a name found there becomes the marker 80h + its
   number.  Leaves INPUT_INDEX on the line end and reports an expansion that overflowed. */
void LEX_READ(i16 context, i16 mode)
{
    CHAR_CLASS_PTR = mode != 0 ? FP_OFF(LEX_READ_MODE1_CLASSES_P) + 1 : FP_OFF(LEX_READ_MODE0_CLASSES_P) + 1;
    B(DS(TOKEN_PTR)) = 0;
    MACRO_MODE = 1;
    for (;;) {
        i16 t = LEX_NEXT_TOKEN();
        if (t == 0)
            goto finish;
        if (t == 10)
            break;
        if (t != 49)
            continue;
        i16 value = MACRO_LOOKUP(context);
        if (value != 0)
            SCAN_WRITE((i8)(value + 128));
        else
            TOKEN_PTR += STRING_LENGTH(DS(TOKEN_PTR));
    }
    INPUT_INDEX--;
finish:
    CHAR_CLASS_PTR = CHAR_CLASS + 1;
    if (TOKEN_PTR >= FP_OFF(EMIT_LIMIT_P))
        REPORT_ERROR(MSG_MACRO_EXPANSION_TOO);
    MACRO_MODE = 0;
    TOKEN_PTR = TOKEN_TEXT;
}

/* skip leading blanks and tabs of the token text at near address text */
static u16 skip_blanks(u16 text)
{
    while (SB(DS(text)) == ' ' || SB(DS(text)) == '\t')
        text++;
    return text;
}

/* collect the parenthesised arguments of a function-like macro call into POOL_A and push
   the expansion: 1 if pushed, 0 if the name was not followed by '(' (an ordinary
   identifier).  The definition starts with its parameter count (FFh object-like).  Each
   argument is a word (the TOKEN_POOL offset of its raw text, for # and ##) and its
   expanded text.  A wrong number of arguments is reported, but the expansion goes ahead. */
i16 COLLECT_MACRO_ARGUMENTS(void)
{
    u16 symbol = CURRENT_SYMBOL;
    u16 token = HLINK_W(symbol, HLINK_MACRO);
    i16 count = BCC_INPUT_BYTE(token);
    i8 c;
    if (count == 0xFF) {
        MACRO_EXPANSION_DEPTH++;
        PUSH_MACRO_EXPANSION(symbol, 0, token);
        return 1;
    }
    do
        c = (i8)SCAN_NEXT(32);
    while (MACRO_MODE == 0 && (c == 10 || c == 13));
    if (c != '(') {
        INPUT_INDEX--;
        return 0;
    }
    u16 text = TOKEN_PTR;
    MACRO_EXPANSION_DEPTH++;
    c = (i8)SCAN_NEXT(32);
    if (c == ')') {
        if (count != 0)
            LEX_ERROR(symbol);
        PUSH_MACRO_EXPANSION(symbol, 0, token);
        return 1;
    }
    INPUT_INDEX--;
    u16 mark = scratch_mark();
    farptr text_offset = scratch_alloc(2);
    c = READ_MACRO_ARGUMENT(text_offset);
    if (c == 26) {
        scratch_release(mark);
        return 1;
    }
    text = skip_blanks(text);
    u16 first = POOL_ALLOC(POOL_A_P, 0);
    for (;;) {
        u16 end = text + STRING_LENGTH(DS(text)) - 1;
        while ((i16)(end - text) >= 0 && SB(DS(end)) == ' ')
            end--;
        B(DS(end + 1)) = 0;
        if (count == 0) {
            LEX_ERROR(symbol);
            MACRO_EXPANSION_DEPTH--;
            scratch_release(mark);
            return 1;
        }
        u16 entry = POOL_ALLOC(POOL_A_P, STRING_LENGTH(DS(text)) + 3);
        u16 unit_mark = POOL_A_UNIT;
        W(MK_FP(POOL_A, entry)) = W(text_offset);
        STRING_COPY(MK_FP(POOL_A, entry + 2), DS(text));
        count--;
        if (c != ',')
            break;
        text = TOKEN_PTR;
        c = READ_MACRO_ARGUMENT(text_offset);
        if (c == 26) {
            POOL_A_USED = 0;
            POOL_A_UNIT = first;
            scratch_release(mark);
            return 1;
        }
        text = skip_blanks(text);
        POOL_A_USED = 0;
        POOL_A_UNIT = unit_mark;
    }
    if (count != 0)
        LEX_ERROR(symbol);
    PUSH_MACRO_EXPANSION(symbol, first, token);
    scratch_release(mark);
    return 1;
}

/* "wrong number of arguments" for the macro whose name node is value */
void LEX_ERROR(i16 value)
{
    REPORT_ERROR(MSG_WRONG_NUMBER_ARGUMENTS, NAME_TEXT_COPY((u16)value));
}

/* the predefined macro names: 0 for any other name, 1 for __STDC__ (strict ANSI only) or
   __cplusplus (C++ only, OPTION_FLAGS bit 0), 2 __FILE__, 3 __LINE__, 4 __DATE__, 5
   __TIME__.  Also used by #define and #undef to refuse redefining them. */
i16 NAME_VALIDATE(farptr text)
{
    if (SB(text) != 95 || SB(fp_add(text, 1)) != 95)
        return 0;
    text = fp_add(text, 2);
    if (COMPARE_NAME(text, PRED_NAME_1_P) == 0 && LANGUAGE_MODE == 1)
        return 1;
    if (COMPARE_NAME(text, PRED_NAME_2_P) == 0 && (OPTION_FLAGS & 1))
        return 1;
    if (COMPARE_NAME(text, PRED_NAME_3_P) == 0)
        return 2;
    if (COMPARE_NAME(text, PRED_NAME_4_P) == 0)
        return 3;
    if (COMPARE_NAME(text, PRED_NAME_5_P) == 0)
        return 4;
    if (COMPARE_NAME(text, PRED_NAME_6_P) == 0)
        return 5;
    return 0;
}

/* read one macro argument (up to ',' or ')' at depth 0): its raw text goes to TOKEN_POOL
   (the offset to *offset); a copy in POOL_F is pushed as input and lexed again with macros
   expanded, which leaves the expanded text in the token buffer where the argument started.
   Returns the character that ended it, or 26 at the end of input or an unterminated
   string. */
i16 READ_MACRO_ARGUMENT(farptr offset)
{
    i16 c;
    u16 saved_ptr = TOKEN_PTR, start = TOKEN_PTR;
    B(DS(TOKEN_PTR)) = 0;
    i16 depth = 0;
    for (;;) {
        switch (c = getbyte()) {
        case ')':
            depth--;
            if (depth < 0)
                goto done;
            SCAN_EMIT_FAR((i8)c);
            break;
        case ',':
            if (depth == 0)
                goto done;
            SCAN_EMIT_FAR((i8)c);
            break;
        case '(':
            depth++;
            SCAN_EMIT_FAR((i8)c);
            break;
        case '/':
            if (getbyte() != '*') {
                INPUT_INDEX--;
                SCAN_EMIT_FAR((i8)c);
                break;
            }
            COMMENT_BLOCK();
            if (!(TOKEN_PTR > start && TOKEN_PREV == ' '))
                SCAN_EMIT_FAR(' ');
            continue;
        case '\\':
            c = getbyte();
            if (c == 13 || c == 10) {
                LEX_NEWLINE((i8)c);
                if (!(TOKEN_PTR > start && TOKEN_PREV == ' '))
                    SCAN_EMIT_FAR(' ');
                continue;
            }
            INPUT_INDEX--;
            SCAN_EMIT_FAR('\\');
            break;
        case '"':
        case '\'':
            if (COPY_STRING_LITERAL((i8)c, LITERAL_CHAR_EMIT_PTR, 1))
                continue;
            SCAN_EMIT_FAR((i8)c);
            return 26;
        case 10:
        case 13:
            LEX_NEWLINE((i8)c);
            /* fall through */
        case 9:
        case ' ':
            if (!(TOKEN_PTR > start && TOKEN_PREV == ' '))
                SCAN_EMIT_FAR(' ');
            continue;
        case 0xFB:
        case 0xFC:
            SCAN_WRITE((i8)c);
            break;
        case 26:
            goto done;
        case 0xFF:
            c = getbyte();
            /* fall through */
        default:
            if (MACRO_MARK_FC_PENDING) {
                SCAN_WRITE((i8)0xFC);
                MACRO_MARK_FC_PENDING = 0;
            }
            if (BASE_CLASS(c) == -10) {
                LEX_WHITESPACE((i8)c);
                u16 symbol = BCC_SYMBOL_CREATE(DS(TOKEN_PTR), 0);
                if (HLINK_W(symbol, HLINK_MACRO) == 0 && NAME_VALIDATE(DS(TOKEN_PTR)) == 0 &&
                    TOKEN_PTR < TOKEN_END) {
                    RTL_MEMMOVE(DS(TOKEN_PTR + 1), DS(TOKEN_PTR), STRING_LENGTH(DS(TOKEN_PTR)) + 1);
                    B(DS(TOKEN_PTR)) = 0xFC;
                }
                TOKEN_PTR += STRING_LENGTH(DS(TOKEN_PTR));
                continue;
            }
            SCAN_EMIT_FAR((i8)c);
            break;
        }
    }
done:
    while (SB(DS(start)) == ' ')
        start++;
    while (TOKEN_PTR > start) {
        if (TOKEN_PREV == ' ')
            TOKEN_PREV = 0;
        else
            break;
        TOKEN_PTR--;
    }
    SCAN_EMIT_FAR(26);
    u16 raw = POOL_ALLOC(TOKEN_POOL_P, STRING_LENGTH(DS(start)) + 1);
    W(offset) = raw;
    STRING_COPY(MK_FP(TOKEN_POOL, W(offset)), DS(start));
    u16 saved_unit = POOL_F_UNIT;
    u16 length = STRING_LENGTH(DS(start)) + 1;
    length += length & 1;
    u16 expansion = POOL_ALLOC(POOL_F_P, length);
    STRING_COPY(MK_FP(POOL_F, expansion + MACDEF_TEXT), DS(start));
    MACRO_EXPANSION_DEPTH++;
    PUSH_MACRO_EXPANSION(0, 0, expansion);
    u16 saved_class = CHAR_CLASS_PTR;
    CHAR_CLASS_PTR = FP_OFF(LEX_READ_MODE1_CLASSES_P) + 1;
    TOKEN_PTR = saved_ptr;
    B(DS(TOKEN_PTR)) = 0;
    for (;;) {
        i16 t = LEX_NEXT_TOKEN();
        if (t == 8)
            break;
        if (t != 49)
            continue;
        if (MACRO_NAME_UNEXPANDED && TOKEN_PTR < TOKEN_END) {
            RTL_MEMMOVE(DS(TOKEN_PTR + 1), DS(TOKEN_PTR), STRING_LENGTH(DS(TOKEN_PTR)) + 1);
            B(DS(TOKEN_PTR)) = 0xFC;
            TOKEN_PTR++;
        }
        TOKEN_PTR += STRING_LENGTH(DS(TOKEN_PTR));
    }
    if (TOKEN_PTR >= TOKEN_END)
        REPORT_ERROR(MSG_MACRO_EXPANSION_TOO);
    CHAR_CLASS_PTR = saved_class;
    B(DS(TOKEN_PTR)) = 0;
    TOKEN_PTR = saved_ptr;
    (void)getbyte();
    INPUT_INDEX--;
    MACRO_MARK_FC_PENDING = 0;
    POOL_F_USED = 0;
    POOL_F_UNIT = saved_unit;
    return c;
}

/* consume a line end whose first character value was read (CR LF or LF CR count as one):
   advance CURRENT_LINE and LOGICAL_LINE and note where the line starts.  Once per line a
   Ctrl-Break seen by the handler ends the program (LINE_HOOK). */
void LEX_NEWLINE(i8 value)
{
    i16 c = getbyte();
    if (value == 13) {
        if (c != 10)
            INPUT_INDEX--;
    } else if (c != 13)
        INPUT_INDEX--;
    CURRENT_LINE++;
    LOGICAL_LINE = CURRENT_LINE;
    if (CTRL_BREAK_SEEN != 0)
        LINE_HOOK();
    TOKEN_POSITION = (i32)INPUT_POSITION();
}

/* hand-written assembly in the original; despite its name it copies an identifier: the
   one starting with value, characters of class F6h (letter) or F5h (digit) in the base
   table, from the input into the token buffer while there is room (the rest is read but
   not stored), refilling as needed; INPUT_INDEX is left on the first other character and
   the copy is cut to NAME_LIMIT and terminated.  TOKEN_PTR is unchanged.  As in the
   original, INPUT_INDEX is not brought up to date before a refill. */
void LEX_WHITESPACE(i8 value)
{
    u16 start = TOKEN_PTR, di = TOKEN_PTR;
    u8 dl = (u8)value;
    u16 si;
    for (;;) {
        if (di < TOKEN_END)
            B(DS(di++)) = dl;
        u16 cx = INPUT_LIMIT - INPUT_INDEX;
        u16 seg = W(DS(INPUT_BUFFER));
        si = INPUT_INDEX;
        for (; cx; cx--) {
            dl = B(MK_FP(seg, si++));
            i8 cls = BASE_CLASS(dl);
            if (cls != -10 && cls != -11)
                goto finish;
            if (di < TOKEN_END)
                B(DS(di++)) = dl;
        }
        dl = INPUT_REFILL();
        i8 cls = BASE_CLASS(dl);
        if (cls == -10 || cls == -11)
            continue;
        si = INPUT_INDEX;
        break;
    }
finish:
    INPUT_INDEX = si - 1;
    TOKEN_PTR = start;
    if ((u16)(di - start) > (u8)NAME_LIMIT)
        di = start + (u8)NAME_LIMIT;
    B(DS(di)) = 0;
}

/* plain C copy of an identifier into the token buffer, at most NAME_LIMIT characters;
   letters, digits, '@' and '$' count; extra characters are skipped */
void LEX_IDENTIFIER(i16 value)
{
    u16 p = TOKEN_PTR;
    i16 remaining = NAME_LIMIT;
    do {
        B(DS(p++)) = (u8)value;
        value = getbyte();
        remaining--;
    } while (remaining != 0 && (BASE_CLASS(value) == -10 || BASE_CLASS(value) == -11 ||
                                value == 64 || value == 36));
    B(DS(p)) = 0;
    while (BASE_CLASS(value) == -10 || BASE_CLASS(value) == -11 || value == 36 || value == 64)
        value = getbyte();
    INPUT_INDEX--;
}

/* classify the identifier just scanned: -2 for an ordinary name (MACRO_NAME_UNEXPANDED
   set), -1 for a function-like macro name without '(', or a character >= 0 to rescan: the
   first of a macro's expansion, or the predefined-name trick.  A name marked FCh is never
   expanded; it only gets its name node in CURRENT_SYMBOL. */
i16 CLASSIFY_IDENTIFIER(void)
{
    i16 pending = MACRO_MARK_FC_PENDING;
    u16 offset;
    MACRO_MARK_FC_PENDING = 0;
    MACRO_NAME_UNEXPANDED = 0;
    if (pending != 0 && MACRO_MARK_FE_SEEN == 0) {
        CURRENT_SYMBOL = BCC_SYMBOL_CREATE(DS(TOKEN_PTR), 0);
        MACRO_NAME_UNEXPANDED = 1;
        return -2;
    }
    u16 mark = scratch_mark();
    farptr buffer = scratch_alloc(16);
    switch (NAME_VALIDATE(DS(TOKEN_PTR))) {
    case 2: {
        u16 start = TOKEN_PTR;
        farptr name = MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME);
        while (SB(name) != 0) {
            if (SB(name) == '\\')
                SCAN_EMIT_FAR('\\');
            SCAN_EMIT_FAR(SB(name));
            name = fp_add(name, 1);
        }
        offset = POOL_ALLOC(TOKEN_POOL_P, STRING_LENGTH(DS(start)) + 1);
        STRING_COPY(MK_FP(TOKEN_POOL, offset), DS(start));
        TOKEN_PTR = start;
        goto set_string;
    }
    case 3:   /* __LINE__: push back all digits but the first and return the first */
        RTL_ITOA10((i16)CURRENT_LINE, NAME_BUFFER_P);
        BCC_INPUT_STRING(fp_add(NAME_BUFFER_P, 1));
        scratch_release(mark);
        return NAME_BUFFER_AT(0);
    case 1:
        scratch_release(mark);
        return 49;
    case 4: {
        farptr date = CURRENT_DATE_P;           /* struct date: year, day, month */
        RTL_MEMMOVE(buffer, fp_add(MONTH_ABBREVIATIONS_P, 3 * (SB(fp_add(date, 3)) - 1)), 3);
        i8 day = SB(fp_add(date, 2));
        B(fp_add(buffer, 3)) = ' ';
        B(fp_add(buffer, 4)) = (u8)(day / 10 + '0');
        B(fp_add(buffer, 5)) = (u8)(day % 10 + '0');
        B(fp_add(buffer, 6)) = ' ';
        RTL_ITOA10(SW(date), fp_add(buffer, 7));
        goto store;
    }
    case 5: {
        farptr time = CURRENT_TIME_P;           /* struct time: min, hour, hund, sec */
        u8 hour = B(fp_add(time, 1)), min = B(time), sec = B(fp_add(time, 3));
        B(buffer) = (u8)(hour / 10 + '0');
        B(fp_add(buffer, 1)) = (u8)(hour % 10 + '0');
        B(fp_add(buffer, 2)) = ':';
        B(fp_add(buffer, 3)) = (u8)(min / 10 + '0');
        B(fp_add(buffer, 4)) = (u8)(min % 10 + '0');
        B(fp_add(buffer, 5)) = ':';
        B(fp_add(buffer, 6)) = (u8)(sec / 10 + '0');
        B(fp_add(buffer, 7)) = (u8)(sec % 10 + '0');
        B(fp_add(buffer, 8)) = 0;
    }
    store:
        offset = POOL_ALLOC(TOKEN_POOL_P, STRING_LENGTH(buffer) + 1);
        STRING_COPY(MK_FP(TOKEN_POOL, offset), buffer);
    set_string:
        PENDING_STRING_TEXT = offset;
        scratch_release(mark);
        return 34;
    }
    scratch_release(mark);
    if (MACRO_MODE != 0 && COMPARE_NAME(DS(TOKEN_PTR), STR_DEFINED_P) == 0)
        return LEX_DEFINED();
    if (BCC_SYMBOL_CURRENT_TEST()) {
        if (COLLECT_MACRO_ARGUMENTS() == 0)
            return -1;
        return getbyte();
    }
    MACRO_NAME_UNEXPANDED = 1;
    return -2;
}

/* defined in #if: reads "name" or "(name)" and returns '1' if the name is a macro, else
   '0', for the caller to rescan as a number; a syntax error gives '0' */
i16 LEX_DEFINED(void)
{
    i16 value = SCAN_NEXT(32), parentheses = 0;
    if (value == 26)
        goto syntax_error;
    if (value == 40) {
        parentheses = 1;
        value = SCAN_NEXT(32);
        if (value == 26)
            goto syntax_error;
    }
    if (BASE_CLASS(value) != -10)
        goto syntax_error;
    value = SCAN_TOKEN(value);
    if (parentheses) {
        value = SCAN_NEXT(value);
        if (value != 41) {
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
            INPUT_INDEX--;
        }
    } else
        INPUT_INDEX--;
    return MACRO_DEFINED(NAME_BUFFER_P) != 0 ? 49 : 48;
syntax_error:
    REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
    return 48;
}

#define ANSI_CLASS (CHAR_CLASS_PTR == CHAR_CLASS + 1)

/* scan the rest of a number into the token buffer: the radix (10, 8, 16) for an integer, 0
   for a real; TOKEN_AUX gets its type */
i16 SCAN_NUMBER_TEXT(i8 c)
{
    i16 dot = 0, exp = 0, base;
    if (c == '0') {
        SCAN_EMIT_FAR('0');
        c = (i8)getbyte();
        if (c == 'x' || c == 'X') {
            MACRO_MARK_FC_PENDING = 0;
            SCAN_EMIT_FAR(c);
            c = (i8)getbyte();
            i16 cls = BASE_CLASS((u8)c);
            if (cls != -11 && ANSI_CLASS && (cls != -10 || (i16)TOLOWER(c) > 'f'))
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
            /* fall through */
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
                c = (i8)getbyte();
                if (c == '-' || c == '+') {
                    SCAN_EMIT_FAR(c);
                    c = (i8)getbyte();
                }
                if (BASE_CLASS((u8)c) == -11)
                    goto emit;
                if (ANSI_CLASS)
                    REPORT_ERROR(MSG_INCORRECT_NUMBER);
                INPUT_INDEX--;
                TOKEN_AUX = 10;
                return 0;
            }
            SCAN_EMIT_FAR(c);
            break;
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
            c = (i8)getbyte();
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
            c = (i8)getbyte();
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
        c = (i8)getbyte();
    }
}

static i16 SCAN_NUMBER_TEXT_(i8 c) { return SCAN_NUMBER_TEXT(c); }

/* nonzero if the 10 bytes at text equal PREDEFINED_1 (probably the long double the
   run-time scanner gives on overflow, so an out-of-range real is detected) */
i16 LEX_COMPARE(farptr text)
{
    farptr input = text, entry = PREDEFINED_1_P;
    u16 end = FP_OFF(PREDEFINED_1_P) + 10;
    while (FP_OFF(entry) < end) {
        if (SB(entry) != SB(input))
            break;
        entry = fp_add(entry, 1);
        input = fp_add(input, 1);
    }
    return FP_OFF(entry) >= end;
}

/* convert the number in TOKEN_TEXT_BUFFER (radix from SCAN_NUMBER_TEXT, 0 a real) into
   TOKEN_CONST_VALUE and pick its type: 33h for a real (rounded to float or double by its
   suffix; out of range an error in strict ANSI mode), 32h for an integer, widened as C
   requires when it has no suffix (decimal to long then unsigned long; octal and hex to
   unsigned, long, unsigned long), with the warning "constant is long" */
i16 CONVERT_NUMBER_TOKEN(i16 base)
{
    TOKEN_PTR = TOKEN_TEXT;
    if (base == 0) {
        RTL_SCAN_LDOUBLE(TOKEN_TEXT_BUFFER_P, TOKEN_CONST_VALUE_P);
        if (TOKEN_AUX == 9)
            RTL_LDOUBLE_ROUND_TO_FLOAT(TOKEN_CONST_VALUE_P);
        else if (TOKEN_AUX == 10)
            RTL_LDOUBLE_ROUND_TO_DOUBLE(TOKEN_CONST_VALUE_P);
        if (LANGUAGE_MODE == 1 && LEX_COMPARE(TOKEN_CONST_VALUE_P)) {
            REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
            RTL_MEMSET(TOKEN_CONST_VALUE_P, 0, 10);
        }
        return 51;
    }
    TOKEN_CONST_VALUE = 0;
    u16 p = base == 16 ? TOKEN_TEXT + 2 : TOKEN_TEXT;
    while (SB(DS(p)) != 0) {
        i16 c = (i16)TOLOWER(SB(DS(p)));
        if (c == 'l' || c == 'u')
            break;
        if (BASE_CLASS(c) == -10)
            c += 10 - 'a';
        else
            c -= '0';
        TOKEN_CONST_VALUE = TOKEN_CONST_VALUE * (u32)(i32)base + (u32)(i32)c;
        p++;
    }
    i16 c = TOKEN_AUX;
    switch (TOKEN_AUX) {
    case 5:
        if (base == 10) {
            if (TOKEN_CONST_VALUE > LONG_MAX_VALUE)
                TOKEN_AUX = 8;
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

static i16 CONVERT_NUMBER_TOKEN_(i16 base) { return CONVERT_NUMBER_TOKEN(base); }

/* a character constant after its opening quote: one character gives token 65h, its value
   sign- or zero-extended as plain char is (-K); two give an int constant (32h) holding both
   bytes; more is an error.  The value goes through TOKEN_CONVERT with type TK_INT. */
i16 LEX_CHARACTER(void)
{
    u8 bytes[2] = {0, 0};
    i16 c, count = 0;
    while ((c = DECODE_ESCAPE_CHAR(39)) != -1) {
        if (count < 2)
            bytes[count] = (u8)c;
        count++;
    }
    if (count > 2)
        REPORT_ERROR(MSG_CHARACTER_CONSTANT_TOO);
    i16 value = (i16)(bytes[0] | bytes[1] << 8);
    if (count == 1) {
        TOKEN_TYPE_WORD = 101;
        value = UNSIGNED_CHAR != 0 ? (u8)value : (i8)value;
    }
    TOKEN_CONST_VALUE = CALL_FAR(TOKEN_CONVERT, A32((i32)value), A16(5));
    TOKEN_AUX = 5;
    return count == 1 ? 101 : 50;
}

/* one character of a string or character constant from the input, escapes decoded; -1 at
   the closing quote, or after "unterminated string" at a line end or end of input.  A
   backslash before a line end is a splice.  Hex and octal values above INT_LIMIT are
   errors; long hex escapes warn.  The value is a 16-bit int, as in the original. */
i16 DECODE_ESCAPE_CHAR(i8 quote)
{
    i16 c, value, count, error;
restart:
    error = 0;
    c = getbyte();
    if (c == 26 || c == 10 || c == 13) {
        LEX_WARNING();
        INPUT_INDEX--;
        return -1;
    }
    if (c == quote)
        return -1;
    if (c != 92)
        return c;
    c = getbyte();
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
        c = getbyte();
        if (!(CTYPE(c) & 0x12)) {
            INPUT_INDEX--;
            return 'x';
        }
        value = 0;
        count = 1;
        for (;;) {
            value = (i16)(value << 4);
            value = (i16)(value + ((CTYPE(c) & 2) ? c - 48 : (i16)TOLOWER(c) - 87));
            if (!error && (i32)value > INT_LIMIT) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                error = 1;
                value = 0;
            }
            c = getbyte();
            if (!(CTYPE(c) & 0x12)) {
                INPUT_INDEX--;
                if (count > 3)
                    REPORT_WARNING(MSG_HEXADECIMAL_VALUE);
                return value;
            }
            count++;
        }
    case 10:
    case 13:
        LEX_NEWLINE((i8)c);
        goto restart;
    case '0': case '1': case '2': case '3':
    case '4': case '5': case '6': case '7':
        value = 0;
        count = 0;
        while (count < 3) {
            value = (i16)(value * 8 + c - 48);
            if (!error && (i32)value > INT_LIMIT) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                error = 1;
                value = 0;
            }
            c = getbyte();
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

/* despite its name, an error: "unterminated string or character constant" */
void LEX_WARNING(void)
{
    REPORT_ERROR(MSG_UNTERMINATED_STRING);
}

#define POOL_BYTE(o) B(MK_FP(TOKEN_POOL, (o)))

/* escape decoding as DECODE_ESCAPE_CHAR, for text already in TOKEN_POOL: *position is
   the offset of the backslash and is left on the last character used.  As in the original,
   \x re-reads the 'x' itself, so it yields 'x' and consumes no hex digits. */
i8 LEX_STRING_ESCAPE(farptr position)
{
    i16 value, count;
    u16 offset = W(position) + 1;
    i16 c = POOL_BYTE(offset);
    W(position) = offset;
    switch (c) {
    case 'a': return 7;
    case 't': return 9;
    case 'n': return 10;
    case 'b': return 8;
    case 'r': return 13;
    case 'f': return 12;
    case 'v': return 11;
    case 'x':
        c = POOL_BYTE(offset);
        offset++;
        if (!(CTYPE(c) & 0x12))
            return 'x';
        value = 0;
        count = 1;
        for (;;) {
            value = (i16)(value << 4);
            value = (i16)(value + ((CTYPE(c) & 2) ? c - 48 : (i16)TOLOWER(c) - 87));
            if ((i32)value > INT_LIMIT) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                value = 0;
            }
            c = POOL_BYTE(offset);
            if (!(CTYPE(c) & 0x12)) {
                W(position) = offset - 1;
                if (count > 2)
                    REPORT_WARNING(MSG_HEXADECIMAL_VALUE);
                return (i8)value;
            }
            offset++;
            count++;
        }
    case '0': case '1': case '2': case '3':
    case '4': case '5': case '6': case '7':
        offset++;
        value = 0;
        count = 0;
        while (count < 3) {
            value = (i16)(value * 8 + c - 48);
            if ((i32)value > INT_LIMIT) {
                LOGICAL_LINE = CURRENT_LINE;
                REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                value = 0;
            }
            c = POOL_BYTE(offset);
            if (c >= '0' && c <= '7') {
                W(position) = offset;
                offset++;
                count++;
            } else
                break;
        }
        return (i8)value;
    default:
        return (i8)c;
    }
}

/* pass one character to the output mode selects: 2 the data byte pool, 1 BYTE_HOOK */
static void restore_out(i16 mode, i8 c)
{
    if (mode == 2)
        EMIT_VALUE(c);
    else if (mode == 1)
        CALL_FAR(BYTE_HOOK, A16(c));
}

/* replay the pending pool text (or read a fresh string literal) and pass each character
   to the output mode selects, counting them in TOKEN_CONST_VALUE's low word */
void BCC_LEX_RESTORE(i16 mode)
{
    TOKEN_CONST_LOW = 0;
    i16 quote = 0;
    if (PENDING_STRING_TEXT != 0) {
        u16 mark = scratch_mark();
        farptr offset = scratch_alloc(2);
        W(offset) = PENDING_STRING_TEXT;
        while (POOL_BYTE(W(offset)) != 0) {
            i8 c = (i8)POOL_BYTE(W(offset));
            if ((u8)c == 0xFC || (u8)c == 0xFB)
                goto advance;
            if ((u8)c == 0xFF) {
                W(offset)++;
                c = (i8)POOL_BYTE(W(offset));
            } else if (POOL_BYTE(W(offset)) == 26)
                break;
            else if (POOL_BYTE(W(offset)) == 92) {
                if (quote == 0)
                    c = LEX_STRING_ESCAPE(offset);
                else if (POOL_BYTE(W(offset) + TOKPOOL_NEXT_CHAR) == quote) {
                    restore_out(mode, 92);
                    W(offset)++;
                    c = (i8)POOL_BYTE(W(offset));
                }
            } else if (POOL_BYTE(W(offset)) == 34 || POOL_BYTE(W(offset)) == 39) {
                if (quote == 0)
                    quote = POOL_BYTE(W(offset));
                else if (POOL_BYTE(W(offset)) == quote)
                    quote = 0;
            }
            TOKEN_CONST_LOW++;
            restore_out(mode, c);
        advance:
            W(offset)++;
        }
        PENDING_STRING_TEXT = 0;
        scratch_release(mark);
    } else {
        i16 value;
        while ((value = DECODE_ESCAPE_CHAR(34)) != -1) {
            TOKEN_CONST_LOW++;
            restore_out(mode, (i8)value);
        }
    }
}

/* copy a string into POOL_HASH and return its offset: the pending text at PENDING_POOL
   (FCh marks dropped) if there is one, else a string literal read from the input; the copy
   ends with ';'.  For the string a pointer declarator may carry (CDECLR.C). */
u16 FLUSH_PENDING_POOL(void)
{
    u16 position = TOKEN_PTR;
    if (PENDING_POOL != 0) {
        farptr pending = PENDING_POOL;
        while (SB(pending) != 0) {
            if (B(pending) != 0xFC)
                SCAN_EMIT_FAR(SB(pending));
            pending = fp_add(pending, 1);
        }
        PENDING_POOL = 0;
    } else {
        i16 value;
        while ((value = DECODE_ESCAPE_CHAR('"')) != -1)
            SCAN_EMIT_FAR((i8)value);
    }
    SCAN_EMIT_FAR(';');
    u16 result = POOL_ALLOC(POOL_HASH_P, STRING_LENGTH(DS(position)) + 1);
    STRING_COPY(MK_FP(POOL_HASH, result), DS(position));
    TOKEN_PTR = position;
    return result;
}

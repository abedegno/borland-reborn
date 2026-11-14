/* asmstmt.c: from bcc20/src/parser/ASMSTMT.C: the asm statement ("asm mov ax,1" or "asm {
   ... }"), used by both front ends.  The parser calls PARSE_ASM_STATEMENT with the asm
   keyword as current token.  Assembly text is not tokenised as C: this file reads the
   characters straight from the input buffer with its own scanner SCAN_ASM_TOKEN, which
   knows mnemonics and register names from ASM_KEYWORD_TABLE (245 sorted four-byte entries:
   near name, token, flags; found by binary search).  Each statement is rebuilt as text in
   ASM_STATEMENT_BUFFER (BCC_LEX_SPECIAL appends a character; ASM_STATEMENT_CURSOR, a far
   pointer, is the end) and then stored: inside a function as an asm block in the
   function's code (NEW_ASM_STATEMENT_BLOCK), at file level written at once to the data
   segment through EMIT_ASM_STATEMENT.  C names in operands go to ASM_IDENTIFIER_HOOK and
   member selections ('.') to ASM_TOKEN_2F_HOOK, both set by the front end; a register
   name marks that register used (CODEGEN_USED_REG_MASK).  The token codes are the asm
   scanner's own (5 '{', 6 '}', 7 ';', 31h name, 32h number, 7Ch end of line, 74h to 80h
   classes of keywords from the table, 7Bh any other character).  In C (CPP_MODE clear)
   some problems are only warnings. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_POSITION D(TOKEN_POSITION_P)
#define NAME_LIMIT SB(NAME_LIMIT_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#undef ASM_STATEMENT_CURSOR
#define ASM_STATEMENT_CURSOR D(ASM_STATEMENT_CURSOR_P)         /* char far * */
#define TOKEN_TEXT FP_OFF(TOKEN_TEXT_BUFFER_P)

static i16 getbyte(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : B(MK_FP(W(DSPTR(INPUT_BUFFER)), INPUT_INDEX++));
}

/* error as an error in C++ and as a warning in C */
void BCC_PARSE_DIAGNOSTIC(u16 error)
{
    if (CPP_MODE)
        REPORT_CURRENT_TOKEN((i16)error);
    else
        REPORT_WARNING(error);
}

/* error, at the current token in C++ */
void BCC_NODE_ERROR(u16 error)
{
    if (CPP_MODE != 0)
        REPORT_CURRENT_TOKEN((i16)error);
    else
        REPORT_ERROR((i16)error);
}

/* the comparison for the binary search of ASM_KEYWORD_TABLE: entry points at a table entry
   whose first word is the keyword's text */
i16 BCC_NAME_COMPARE(farptr name, farptr entry)
{
    return STRING_COMPARE(name, DSPTR(W(entry)));
}

/* one assembler token into TOKEN_TEXT_BUFFER; returns its code.  Blanks are copied to the
   statement as a separator, comments skipped.  A name is first offered to
   CLASSIFY_IDENTIFIER, so macros expand inside asm (an expansion is rescanned); a mnemonic
   or register gives its table token and leaves its flags in ASM_MNEMONIC_FLAGS.  Numbers
   keep their assembler form; a C hex number 0x.. gets a trailing 'H'.  A character
   constant 'x' is a number */
i16 SCAN_ASM_TOKEN(void)
{
    i16 value, next, hex;
restart:
    TOKEN_PTR = TOKEN_TEXT;
    value = getbyte();
dispatch:
    SCAN_EMIT_FAR((i8)value);
    hex = 0;
    switch (value) {
    case 0xFB:
        goto restart;
    case 9:
    case ' ':
        BCC_LEX_SPECIAL((i8)value);
        goto restart;
    case '{':
        return 5;
    case '}':
        return 6;
    case '/':
        next = getbyte();
        if (next == '*') {
            COMMENT_BLOCK();
            TOKEN_PTR = TOKEN_TEXT;
            goto restart;
        }
        if (next == '/') {
            COMMENT_LINE();
            TOKEN_PTR = TOKEN_TEXT;
            goto restart;
        }
        --INPUT_INDEX;
        break;
    case '$': case '@': case '_':
    case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': case 'G': case 'H': case 'I':
    case 'J': case 'K': case 'L': case 'M': case 'N': case 'O': case 'P': case 'Q': case 'R':
    case 'S': case 'T': case 'U': case 'V': case 'W': case 'X': case 'Y': case 'Z':
    case 'a': case 'b': case 'c': case 'd': case 'e': case 'f': case 'g': case 'h': case 'i':
    case 'j': case 'k': case 'l': case 'm': case 'n': case 'o': case 'p': case 'q': case 'r':
    case 's': case 't': case 'u': case 'v': case 'w': case 'x': case 'y': case 'z': {
        TOKEN_PTR = TOKEN_TEXT;
        LEX_IDENTIFIER(value);
        TOKEN_TEXT_BUFFER_AT(NAME_LIMIT) = 0;
        if ((value = CLASSIFY_IDENTIFIER()) != -2 && value != -1)
            goto dispatch;
        farptr entry = BCC_BINARY_SEARCH(TOKEN_TEXT_BUFFER_P, ASM_KEYWORD_TABLE_P, 245, 4, ASM_KEYWORD_COMPARE_FUNC);
        if (entry) {
            ASM_MNEMONIC_FLAGS = B(fp_add(entry, 3));
            return B(fp_add(entry, 2));
        }
        return 49;
    }
    case '0':
        value = getbyte();
        if (value == 'x' || value == 'X')
            hex = 1;
        else
            --INPUT_INDEX;
        /* fall through */
    case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9':
        for (;;) {
            value = getbyte();
            if (!(CTYPE(value) & 0x12))
                break;
            SCAN_EMIT_FAR((i8)value);
        }
        if (value == '.' || value == 'h' || value == 'H')
            SCAN_EMIT_FAR((i8)value);
        else
            --INPUT_INDEX;
        if (hex)
            SCAN_EMIT_FAR('H');
        return 50;
    case ';':
        return 7;
    case 10:
    case 13:
    case 26:
        --INPUT_INDEX;
        return 124;
    case '(':
        return 1;
    case '.':
        return 47;
    case '\'':
        do {
            value = getbyte();
            SCAN_EMIT_FAR((i8)value);
        } while (value != '\'');
        return 50;
    }
    return 123;
}

/* one asm statement, or a braced block of them.  phase: 0 at the start, 1 inside asm {
   ... } (line ends are then crossed, with directives handled through LEX_HASH, until the
   closing brace), 2 after a single-line statement.  Each statement is checked through
   BCC_LEX_TOKEN and PARSE_ASM_MNEMONIC / SCAN_ASM_OPERANDS while its text is collected,
   then stored unless an error occurred earlier (NO_ERRORS_YET).  MACRO_MODE is set
   throughout so the lexer helpers stop at line ends */
void PARSE_ASM_STATEMENT(void)
{
    i16 phase, result;
    u16 valid, parsed, value, copy;
    TOKEN_TYPE = 0x82;
    phase = 0;
    ASM_STATEMENT_FLAG = 1;
    MACRO_MODE = 1;
outer:
    valid = 1;
restart:
    parsed = 0;
    result = 0;
    ASM_STATEMENT_CURSOR = ASM_STATEMENT_BUFFER_P;
    switch (BCC_LEX_TOKEN()) {
    case 1:
        BCC_LEX_SPECIAL(9);
        /* fall through */
    case 4:
        parsed = 1;
        goto expression;
    case 2:
        parsed = PARSE_ASM_MNEMONIC();
        if (parsed)
            result = SCAN_ASM_OPERANDS();
        break;
    case 6:
        TOKEN_PTR = TOKEN_TEXT;
        result = 1;
        break;
    case 5:
        TOKEN_PTR = TOKEN_TEXT;
        if (!phase) {
            phase = 1;
            goto restart;
        }
        BCC_NODE_ERROR(MSG_INLINE_ASSEMBLY_NOT);
        goto restart;
    case 0x7C:
        if (phase == 1) {
            value = getbyte();
            if (value == 0x1A) {
                REPORT_ERROR(MSG_COMPOUND_STATEMENT);
                phase = 0;
                break;
            }
            LEX_HASH((i8)value);
            TOKEN_LINE = CURRENT_LINE;
            TOKEN_LENGTH = (u16)INPUT_POSITION() - (u16)TOKEN_POSITION + 1;
            TOKEN_FILE_NODE = LEX_FILE_SERIAL_NODE;
            ASM_STATEMENT_CURSOR = ASM_STATEMENT_BUFFER_P;
            TOKEN_PTR = TOKEN_TEXT;
            goto restart;
        }
        /* fall through */
    case 3:
        BCC_PARSE_DIAGNOSTIC(MSG_UNKNOWN_ASSEMBLER);
        valid = 0;
        parsed = 1;
        BCC_LEX_SPECIAL(9);
expression:
        result = SCAN_ASM_OPERANDS();
    }
    TOKEN_PTR = TOKEN_TEXT;
    if (!phase)
        phase = 2;
    if (parsed) {
        BCC_LEX_SPECIAL(0);
        if (NO_ERRORS_YET) {
            if (CURRENT_SCOPE != GLOBAL_SCOPE) {
                u16 chain = BCC_PARSE_BUFFER;           /* pascal: read before the call */
                u16 block = NEW_ASM_STATEMENT_BLOCK(FP_SEG(ASM_STATEMENT_BUFFER_P), FP_OFF(ASM_STATEMENT_BUFFER_P),
                                                    valid, TOKEN_FILE_NODE, TOKEN_LINE);
                APPEND_BLOCK_CHAIN(chain, block, LOOP_NEST_FACTOR);
            } else {
                value = STRING_LENGTH(ASM_STATEMENT_BUFFER_P);
                copy = POOL_ALLOC(STRING_POOL_SEG_P, value + 2);
                CALL_FAR(STREAM_HOOK, A16(DATA_SEGMENT_ID));
                STRING_COPY(MK_FP(STRING_POOL_SEG, copy), ASM_STATEMENT_BUFFER_P);
                EMIT_ASM_STATEMENT(copy);
                STRING_COPY(MK_FP(STRING_POOL_SEG, copy), STR_CRLF_2_P);
                EMIT_ASM_STATEMENT(copy);
            }
        }
    }
    if (result) {
        if (phase != 1)
            BCC_NODE_ERROR(MSG_INLINE_ASSEMBLY_NOT);
    } else if (phase == 1)
        goto outer;
    MACRO_MODE = 0;
}

/* a mnemonic with any prefix (tokens 7Eh to 80h add flags 100h to 400h, rep and segment
   override forms).  Inside a function, when the token after the mnemonic is a name or one
   of the keyword classes listed, the instruction goes to ASM_INSTRUCTION_HOOK instead
   (jumps to C labels, which the compiler resolves itself), and 0 is returned.  Otherwise
   the mnemonic is copied to the statement and 1 is returned */
i16 PARSE_ASM_MNEMONIC(void)
{
    i16 token;
    u16 flags = ASM_MNEMONIC_FLAGS;
    BCC_LEX_SPECIAL(9);
    switch (token = SCAN_ASM_TOKEN()) {
    case 0x80:
        flags |= 0x100;
        BCC_LEX_ADVANCE();
        token = SCAN_ASM_TOKEN();
        break;
    case 0x7F:
        if ((token = SCAN_ASM_TOKEN()) != 0x81) {
            BCC_LEX_ADVANCE();
            break;
        }
        flags |= 0x200;
        BCC_LEX_ADVANCE();
        token = SCAN_ASM_TOKEN();
        break;
    case 0x7E:
        if ((token = SCAN_ASM_TOKEN()) != 0x81) {
            BCC_LEX_ADVANCE();
            break;
        }
        flags |= 0x400;
        BCC_LEX_ADVANCE();
        token = SCAN_ASM_TOKEN();
        break;
    }
    switch (token) {
    case 0x31: case 0x74: case 0x75: case 0x76: case 0x77: case 0x78:
    case 0x7B: case 0x7C: case 0x7D: case 0x7E: case 0x7F: case 0x80:
        if (CURRENT_SCOPE != GLOBAL_SCOPE) {
            CALL_FAR(ASM_INSTRUCTION_HOOK, A16(flags));
            if (SCAN_ASM_OPERANDS())
                --INPUT_INDEX;
            return 0;
        }
    }
    BCC_LEX_ADVANCE();
    return 1;
}

/* copies operands to the statement text up to its end.  1 if it ended at '}' (the end of
   an asm block), 0 at a line end or ';'.  A register name (token 7Ah) is looked up as
   "_XX" in PSEUDO_REGISTER_TABLE (seven-byte entries: near name, register number word,
   type, two spare bytes) to mark the register used */
i16 SCAN_ASM_OPERANDS(void)
{
    for (;;) {
        switch (SCAN_ASM_TOKEN()) {
        case 0x7C:
            return 0;
        case 6:
            return 1;
        case 7:
            return 0;
        case 0x32:
            BCC_LEX_ADVANCE();
            continue;
        case 0x7A: {
            u16 mark = scratch_mark();
            farptr name = scratch_alloc(4);
            B(name) = 0x5F;
            B(fp_add(name, 1)) = (u8)RTL_TOUPPER(TOKEN_TEXT_BUFFER_AT(0));
            B(fp_add(name, 2)) = (u8)RTL_TOUPPER(TOKEN_TEXT_BUFFER_AT(1));
            B(fp_add(name, 3)) = 0;
            for (farptr entry = PSEUDO_REGISTER_TABLE_P; W(entry); entry = fp_add(entry, 7)) {
                if (COMPARE_NAME(DSPTR(W(entry)), name) == 0) {
                    CODEGEN_USED_REG_MASK |= (u16)(1u << (W(fp_add(entry, 2)) & 31));
                    break;
                }
            }
            scratch_release(mark);
            BCC_LEX_ADVANCE();
            continue;
        }
        case 0x79:
            BCC_LEX_ADVANCE();
            SCAN_ASM_TOKEN();
            BCC_LEX_ADVANCE();
            continue;
        case 0x31:
            CALL_FAR0(ASM_IDENTIFIER_HOOK);
            /* fall through */
        case 0x74: case 0x76: case 0x77: case 0x78:
        case 0x7D: case 0x7E: case 0x7F: case 0x80:
            BCC_LEX_ADVANCE();
            continue;
        case 0x2F: {
            i16 result = (i16)CALL_FAR0(ASM_TOKEN_2F_HOOK);
            if (!result)
                return 0;
            if (result == 1)
                BCC_LEX_ADVANCE();
            continue;
        }
        default:
            BCC_LEX_ADVANCE();
            continue;
        }
    }
}

/* the first token of a statement: 7Ch (end of line), 5 or 6 ('{', '}') as they are;
   otherwise 1 for an instruction needing no further check, 2 for a mnemonic whose
   operands PARSE_ASM_MNEMONIC checks, 3 for anything unknown, 4 for a '.' directive.
   Token 7Dh (a label or prefix) is copied first.  Token 75h marks a group of registers
   used (mask 1055h) */
i16 BCC_LEX_TOKEN(void)
{
    i8 separator = 9;
    i16 token = SCAN_ASM_TOKEN();
    if (token == 0x7C || token == 5 || token == 6)
        return token;
    if (token == 0x7D) {
        BCC_LEX_SPECIAL(separator);
        BCC_LEX_ADVANCE();
        token = SCAN_ASM_TOKEN();
        separator = 0x20;
    }
    if (token == 0x74 || token == 0x77 || token == 0x75) {
        if (token == 0x75)
            CODEGEN_USED_REG_MASK |= 0x1055;
        BCC_LEX_SPECIAL(separator);
        goto return_one;
    }
    if (token == 0x78) {
        BCC_LEX_SPECIAL(separator);
        BCC_LEX_ADVANCE();
        return 2;
    }
    if (token == 0x76) {
        BCC_LEX_SPECIAL(separator);
        BCC_LEX_ADVANCE();
        token = SCAN_ASM_TOKEN();
        if (token != 0x77)
            goto return_three;
return_one:
        BCC_LEX_ADVANCE();
        return 1;
    }
    if (token == 0x2F) {
        BCC_LEX_SPECIAL(separator);
        BCC_LEX_ADVANCE();
        return 4;
    }
    BCC_LEX_SPECIAL(separator);
return_three:
    BCC_LEX_ADVANCE();
    return 3;
}

/* appends the current asm token's text (TOKEN_TEXT_BUFFER) to the statement */
void BCC_LEX_ADVANCE(void)
{
    for (u16 cursor = TOKEN_TEXT; SB(DSPTR(cursor)); cursor++)
        BCC_LEX_SPECIAL(SB(DSPTR(cursor)));
}

/* one character onto ASM_STATEMENT_BUFFER (at most 1E0h characters).  Overflow is
   reported when the closing 0 is appended */
void BCC_LEX_SPECIAL(i8 value)
{
    if (FP_OFF(ASM_STATEMENT_CURSOR) < (u16)(FP_OFF(ASM_STATEMENT_BUFFER_P) + 0x1E0)) {
        farptr cursor = ASM_STATEMENT_CURSOR;
        SB(cursor) = value;
        ASM_STATEMENT_CURSOR = fp_add(cursor, 1);
    } else if (value == 0)
        BCC_NODE_ERROR(MSG_ASSEMBLER_STATEMENT);
}

/* skips the rest of an asm statement: up to a line end or ';' (consumed), stepping over
   quoted text and comments */
void BCC_LEX_SKIP(void)
{
    for (;;) {
        u16 ch = getbyte();
        if (ch == 13)
            return;
        if (ch == 10)
            return;
        if (ch == ';')
            return;
        if (ch == '\'') {
            do
                ch = getbyte();
            while (ch != '\'');
        } else if (ch == '/') {
            ch = getbyte();
            if (ch == '*')
                COMMENT_BLOCK();
            else if (ch == '/')
                COMMENT_LINE();
            else
                --INPUT_INDEX;
        }
    }
}

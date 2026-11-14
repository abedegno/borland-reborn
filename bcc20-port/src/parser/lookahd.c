/* lookahd.c: from bcc20/src/parser/LOOKAHD.C: lookahead for the C++ front end's hardest
   question, whether the text ahead declares something or is an expression ("T (x);",
   "(T)(x)").  These functions read the tokens with ADVANCE_TOKEN and return 1 when they
   have the shape of a declaration or type name; they run inside a recording
   (BCC_PARSE_PUSH, undone by BCC_PARSE_POP) so that the real parser can read the tokens
   again.  TYPE_FLAGS bits: 8 type keywords, 4 probably other declaration specifiers,
   2000h probably modifiers (near, far, cdecl), 10h tokens that can follow '(' in a
   declarator, 800h and 1000h tokens allowed inside a bracketed or parenthesised group.
   Token 67h is '::'; a name followed by it is a qualifier, not a type name. */
#include "port.h"
#include "data.h"
#include "token.h"
#include "protos.h"

#define FLAGS(token) TYPE_FLAGS_AT(token)

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return W(TOKEN_TYPE_P);
}

static int type_start(void) { return TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) != 0; }

/* a group starting at the current token opening ('(' 1, '[' 3, '{' 5) skipped up to and
   with its matching closing token, with only commas, nested groups and tokens with a
   TYPE_FLAGS bit of mask inside.  1 if the group was closed, 0 if a token not allowed
   came first */
u8 SKIP_BALANCED_TOKENS(u16 mask, u16 opening, u16 closing)
{
    u16 depth = 0;
    do {
        while ((CURRENT_TOKEN == TOK_COMMA || ((FLAGS(CURRENT_TOKEN) & mask) && CURRENT_TOKEN != opening && CURRENT_TOKEN != closing)) &&
               depth > 0)
            ADVANCE_TOKEN();
        if (CURRENT_TOKEN == opening) {
            ++depth;
            ADVANCE_TOKEN();
        } else if (CURRENT_TOKEN == closing && depth > 0) {
            --depth;
            ADVANCE_TOKEN();
        }
    } while (depth > 0 && ((FLAGS(CURRENT_TOKEN) & mask) || CURRENT_TOKEN == opening || CURRENT_TOKEN == closing ||
                           CURRENT_TOKEN == TOK_COMMA));
    return depth == 0;
}

/* the declaration specifiers skipped (type keywords, modifiers, a struct/union/class/enum
   head, or one type name).  A second plain identifier after a type is the declarator and
   ends the scan with 1; a struct head followed by '{' skips the whole body.  0 when a
   struct keyword has no name after it */
u8 SCAN_TYPE_SPECIFIERS(void)
{
    u8 seen = 0;
    while (type_start() && peek_kind() != 0x67) {
        while (type_start() && peek_kind() != 0x67) {
            if (CURRENT_TOKEN == TOK_STRUCT || CURRENT_TOKEN == TOK_UNION || CURRENT_TOKEN == TOK_CLASS || CURRENT_TOKEN == TOK_ENUM) {
                seen = 1;
                ADVANCE_TOKEN();
                if (CURRENT_TOKEN == TOK_IDENT && peek_kind() == 5) {
                    ADVANCE_TOKEN();
                    return SKIP_BALANCED_TOKENS(0xFFFF, 5, 6);
                }
                if (CURRENT_TOKEN != TOK_IDENT)
                    return 0;
            } else if (FLAGS(CURRENT_TOKEN) & 4)
                seen = 1;
            else if (CURRENT_TOKEN == TOK_IDENT) {
                if (seen)
                    return 1;
                seen = 1;
            }
            ADVANCE_TOKEN();
        }
    }
    return 1;
}

/* one declarator skipped: modifiers, a qualifier "name::", '*' and '&' with const and
   volatile, a name or a parenthesised inner declarator, array and function suffixes.
   mode: 0 a declarator in a statement (a name or parentheses needed; a function suffix
   skipped as a group), 1 a parameter declarator (the name optional; a function suffix must
   be a parameter list), 3 an abstract declarator (no name).  1 if the tokens fit */
u8 SCAN_DECLARATOR(u16 mode)
{
    while (FLAGS(CURRENT_TOKEN) & 0x2000)
        ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x67) {
        ADVANCE_TOKEN();
        ADVANCE_TOKEN();
    }
    while (CURRENT_TOKEN == TOK_STAR || CURRENT_TOKEN == TOK_AMPERSAND) {
        ADVANCE_TOKEN();
        while (FLAGS(CURRENT_TOKEN) & 0x2000)
            ADVANCE_TOKEN();
        while (CURRENT_TOKEN == TOK_CONST || CURRENT_TOKEN == TOK_VOLATILE)
            ADVANCE_TOKEN();
    }
    u8 named = CURRENT_TOKEN == TOK_IDENT, parenthesized = 0;
    if (named)
        ADVANCE_TOKEN();
    else if (CURRENT_TOKEN == TOK_LPAREN && (FLAGS(peek_kind()) & 0x10)) {
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x67) {
            ADVANCE_TOKEN();
            ADVANCE_TOKEN();
        }
        if (CURRENT_TOKEN == TOK_IDENT)
            return 0;
        parenthesized = 1;
        if (!SCAN_DECLARATOR(mode) || CURRENT_TOKEN != TOK_RPAREN)
            return 0;
        ADVANCE_TOKEN();
    }
    while (CURRENT_TOKEN == TOK_LBRACKET || CURRENT_TOKEN == TOK_LPAREN) {
        if (!named && !parenthesized && mode != 3)
            return 0;
        if (CURRENT_TOKEN == TOK_LBRACKET) {
            if (!SKIP_BALANCED_TOKENS(0x800, 3, 4))
                return 0;
        } else if (mode == 0) {
            if (!SKIP_BALANCED_TOKENS(0x1000, 1, 2))
                return 0;
        } else if (!BCC_PARSE_QUERY())
            return 0;
    }
    if (mode == 0)
        return named || parenthesized;
    if (mode == 3)
        return !named;
    return 1;
}

/* the tokens from the current '(' a parameter list: declarations with optional default
   values ("= expression") separated by commas, perhaps ending in "...", then ')'.  The
   list consumed; 1 if it fits */
u8 BCC_PARSE_QUERY(void)
{
    ADVANCE_TOKEN();
    while (type_start() && peek_kind() != 0x67) {
        if (!SCAN_TYPE_SPECIFIERS() || !SCAN_DECLARATOR(1))
            return 0;
        if (CURRENT_TOKEN == TOK_ASSIGN) {
            ADVANCE_TOKEN();
            while ((FLAGS(CURRENT_TOKEN) & 0x800) && CURRENT_TOKEN != TOK_RPAREN && CURRENT_TOKEN != TOK_COMMA) {
                if (CURRENT_TOKEN == TOK_LPAREN) {
                    if (!SKIP_BALANCED_TOKENS(0x800, 1, 2))
                        return 0;
                } else
                    ADVANCE_TOKEN();
            }
        }
        if (CURRENT_TOKEN == TOK_COMMA) {
            ADVANCE_TOKEN();
            continue;
        }
        if (CURRENT_TOKEN != TOK_RPAREN && CURRENT_TOKEN != TOK_ELLIPSIS)
            return 0;
    }
    if (CURRENT_TOKEN == TOK_ELLIPSIS)
        ADVANCE_TOKEN();
    if (CURRENT_TOKEN != TOK_RPAREN)
        return 0;
    ADVANCE_TOKEN();
    return 1;
}

/* with '(' current: 1 if the parentheses hold just a type name ("(T *)x", "sizeof(T)").
   The tokens are recorded in replay mode and rewound, so the position is unchanged; 0 if
   that stream is being replayed already */
u8 IS_PAREN_TYPE_NAME(u16 mode)
{
    u8 result = 0;
    if (BCC_PARSE_BEGIN(mode)) {
        BCC_PARSE_PUSH(mode);
        ADVANCE_TOKEN();
        result = SCAN_TYPE_SPECIFIERS();
        if (result)
            result = SCAN_DECLARATOR(3);
        if (CURRENT_TOKEN != TOK_RPAREN)
            result = 0;
        BCC_PARSE_POP(mode);
    }
    return result;
}

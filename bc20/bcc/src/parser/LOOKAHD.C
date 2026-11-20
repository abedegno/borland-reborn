/* target: ovr086_C30UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: parser (C++ mode): lookahead that decides whether tokens form a type or
   declaration, skipping balanced token groups. Entry points: SKIP_BALANCED_TOKENS,
   SCAN_TYPE_SPECIFIERS, SCAN_DECLARATOR, BCC_PARSE_QUERY, IS_PAREN_TYPE_NAME. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: lookahead for the C++ front end's hardest question: does the
   text ahead declare something, or is it an expression?  In C++,
   "T (x);" or "(T)(x)" can be either, depending on what follows.  These
   functions answer by actually reading the tokens: they consume tokens
   with ADVANCE_TOKEN and return 1 if the tokens have the shape of a
   declaration (or type name), 0 if not.  They must run inside a
   recording made with BCC_PARSE_PUSH and undone with BCC_PARSE_POP
   (TOKSTRM.C), so the tokens can be read again by the real parser;
   IS_PAREN_TYPE_NAME does that itself, and IS_DECLARATION_AHEAD in
   STMTCPP.C does it for statements.  The tests use bits of the per-token
   flag table TYPE_FLAGS: 0x08 type keywords, 0x04 probably other
   declaration specifiers, 0x2000 probably modifiers such as near, far,
   cdecl, 0x10 tokens that can follow '(' in a declarator, 0x800 and 0x1000
   tokens that may appear inside a bracketed or parenthesised group.
   Token 0x67 is '::' (TOK_SCOPE); a name followed by '::' is a qualifier,
   not a type name. */
#include "LOOKAHD.H"
#include "TOKEN.H"
#define PEEK_KIND() (PEEK_TOKEN(), TOKEN_TYPE.kind)
#define TYPE_START() TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD)

/* 0000: unsigned delimiter depth and the original ordered synchronizing tests. */
/* Skips a group that starts at the current token opening (for example
   '(' 1, '[' 3, '{' 5) up to and including its matching closing token,
   allowing inside only commas, nested groups and tokens whose TYPE_FLAGS
   entry has a bit of mask.  Returns 1 if the group was closed, 0 if a
   token not allowed was met first. */
unsigned char far pascal SKIP_BALANCED_TOKENS(unsigned int mask,unsigned int opening,
    unsigned int closing)
{
    register unsigned int depth;
    depth=0;
    do {
        while((CURRENT_TOKEN==TOK_COMMA ||
              ((TYPE_FLAGS[CURRENT_TOKEN]&mask) && CURRENT_TOKEN!=opening &&
               CURRENT_TOKEN!=closing)) && depth>0)
            ADVANCE_TOKEN();
        if(CURRENT_TOKEN==opening) {
            ++depth;
            ADVANCE_TOKEN();
        } else if(CURRENT_TOKEN==closing && depth>0) {
            --depth;
            ADVANCE_TOKEN();
        }
    } while(depth>0 && ((TYPE_FLAGS[CURRENT_TOKEN]&mask) ||
             CURRENT_TOKEN==opening || CURRENT_TOKEN==closing || CURRENT_TOKEN==TOK_COMMA));
    return depth==0;
}

/* 008D: both original lookahead predicate blocks retain their real calls. */
/* Skips the declaration specifiers of a declaration (type keywords,
   modifiers, a struct/union/class/enum head, or one type name).  A
   second plain identifier after a type is taken as the declarator and
   ends the scan with 1.  A struct head followed by '{' skips the whole
   body.  Returns 0 if a struct keyword is not followed by a name. */
unsigned char far pascal SCAN_TYPE_SPECIFIERS(void)
{
    unsigned char seen;
    seen=0;
    while(TYPE_START() && PEEK_KIND()!=0x67) {
        while(TYPE_START() && PEEK_KIND()!=0x67) {
            if(CURRENT_TOKEN==TOK_STRUCT || CURRENT_TOKEN==TOK_UNION ||
               CURRENT_TOKEN==TOK_CLASS || CURRENT_TOKEN==TOK_ENUM) {
                seen=1;
                ADVANCE_TOKEN();
                if(CURRENT_TOKEN==TOK_IDENT && PEEK_KIND()==5) {
                    ADVANCE_TOKEN();
                    return SKIP_BALANCED_TOKENS(0xFFFF,5,6);
                }
                if(CURRENT_TOKEN!=TOK_IDENT)
                    return 0;
            } else if(TYPE_FLAGS[CURRENT_TOKEN]&4)
                seen=1;
            else if(CURRENT_TOKEN==TOK_IDENT) {
                if(seen)
                    return 1;
                seen=1;
            }
            ADVANCE_TOKEN();
        }
    }
    return 1;
}

/* 0158: one real mode WORD, two BYTE facts and recursive declarator recognition. */
/* Skips one declarator: modifiers, a qualifier "name::", any number of
   '*' or '&' with const/volatile, then a name or a parenthesised inner
   declarator (scanned recursively), then array and function suffixes.
   mode says what is acceptable: 0 a declarator in a statement (must have
   a name or parentheses; a function suffix is skipped as a token group),
   1 a parameter declarator (the name is optional; a function suffix must
   be a parameter list, checked by BCC_PARSE_QUERY), 3 an abstract
   declarator as in a cast or sizeof (no name allowed).  Returns 1 if the
   tokens fit. */
unsigned char far pascal SCAN_DECLARATOR(register unsigned int mode)
{
    unsigned char named;
    unsigned char parenthesized;
    while(TYPE_FLAGS[CURRENT_TOKEN]&0x2000)
        ADVANCE_TOKEN();
    if(CURRENT_TOKEN==TOK_IDENT && PEEK_KIND()==0x67) {
        ADVANCE_TOKEN();
        ADVANCE_TOKEN();
    }
    while(CURRENT_TOKEN==TOK_STAR || CURRENT_TOKEN==TOK_AMPERSAND) {
        ADVANCE_TOKEN();
        while(TYPE_FLAGS[CURRENT_TOKEN]&0x2000)
            ADVANCE_TOKEN();
        while(CURRENT_TOKEN==TOK_CONST || CURRENT_TOKEN==TOK_VOLATILE)
            ADVANCE_TOKEN();
    }
    named=CURRENT_TOKEN==TOK_IDENT;
    parenthesized=0;
    if(named)
        ADVANCE_TOKEN();
    else if(CURRENT_TOKEN==TOK_LPAREN && (TYPE_FLAGS[PEEK_KIND()]&0x10)) {
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN==TOK_IDENT && PEEK_KIND()==0x67) {
            ADVANCE_TOKEN();
            ADVANCE_TOKEN();
        }
        if(CURRENT_TOKEN==TOK_IDENT)
            return 0;
        parenthesized=1;
        if(!SCAN_DECLARATOR(mode))
            return 0;
        if(CURRENT_TOKEN!=TOK_RPAREN)
            return 0;
        ADVANCE_TOKEN();
    }
    while(CURRENT_TOKEN==TOK_LBRACKET || CURRENT_TOKEN==TOK_LPAREN) {
        if(named!=0 || parenthesized!=0 || mode==3) {
            if(CURRENT_TOKEN==TOK_LBRACKET) {
                if(!SKIP_BALANCED_TOKENS(0x800,3,4))
                    return 0;
            } else if(mode==0) {
                if(!SKIP_BALANCED_TOKENS(0x1000,1,2))
                    return 0;
            } else if(!BCC_PARSE_QUERY())
                return 0;
        } else
            return 0;
    }
    if(mode==0)
        return named || parenthesized;
    if(mode==3)
        return !named;
    return 1;
}

/* 02F6: canonical query endpoint; consume exactly the original token sequence. */
/* Checks that the tokens from the current '(' form a parameter list:
   parameter declarations with optional default values ("= expression"),
   separated by commas, optionally ending in "...", then ')'.  Consumes
   the list; returns 1 if it fits. */
unsigned char far pascal BCC_PARSE_QUERY(void)
{
    ADVANCE_TOKEN();
    while(TYPE_START() && PEEK_KIND()!=0x67) {
        if(!SCAN_TYPE_SPECIFIERS())
            return 0;
        if(!SCAN_DECLARATOR(1))
            return 0;
        if(CURRENT_TOKEN==TOK_ASSIGN) {
            ADVANCE_TOKEN();
            while((TYPE_FLAGS[CURRENT_TOKEN]&0x800) &&
                  CURRENT_TOKEN!=TOK_RPAREN && CURRENT_TOKEN!=TOK_COMMA) {
                if(CURRENT_TOKEN==TOK_LPAREN) {
                    if(!SKIP_BALANCED_TOKENS(0x800,1,2))
                        return 0;
                } else
                    ADVANCE_TOKEN();
            }
        }
        if(CURRENT_TOKEN==TOK_COMMA) {
            ADVANCE_TOKEN();
            continue;
        }
        if(CURRENT_TOKEN!=TOK_RPAREN && CURRENT_TOKEN!=TOK_ELLIPSIS)
            return 0;
    }
    if(CURRENT_TOKEN==TOK_ELLIPSIS)
        ADVANCE_TOKEN();
    if(CURRENT_TOKEN!=TOK_RPAREN)
        return 0;
    ADVANCE_TOKEN();
    return 1;
}

/* 03BE: mode is a WORD, forwarded unchanged through all three real stream calls. */
/* Called with the current token '(': returns 1 if the parentheses hold
   just a type name, as in a cast "(T *)x" or "sizeof(T)".  Records the
   tokens in replay stream mode and rewinds afterwards, so the token
   position is unchanged; if that stream is already being replayed the
   answer is 0. */
unsigned char far pascal IS_PAREN_TYPE_NAME(register unsigned int mode)
{
    unsigned char result;
    result=0;
    if(BCC_PARSE_BEGIN(mode)) {
        BCC_PARSE_PUSH(mode);
        ADVANCE_TOKEN();
        result=SCAN_TYPE_SPECIFIERS();
        if(result)
            result=SCAN_DECLARATOR(3);
        if(CURRENT_TOKEN!=TOK_RPAREN)
            result=0;
        BCC_PARSE_POP(mode);
    }
    return result;
}

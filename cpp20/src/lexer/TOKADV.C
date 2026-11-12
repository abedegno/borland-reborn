/* target: TOKADV */
/* CPP.EXE module TOKADV (image 0x3156..0x32E4, frame 0315h): source taken from the
   BCC.EXE reconstruction (bcc20/src/lexer/TOKADV.C), edited for CPP.EXE
   (see the "CPP.EXE edit" notes), plus CPP.EXE's output loop. */
/* Role: token advance and the preprocessor's output loop: reads the next token from
   the lexer, drains unread string-literal characters, and writes every token to the
   output. Entry points: NEXT_LITERAL_CHAR, PEEK_TOKEN, ADVANCE_TOKEN,
   WRITE_PREPROCESSED_TOKENS. */
/* opts: -mm -G- -O -Z -p -d */
/* CPP.EXE: BCC's -B -TjNOSMART -Tm2 dropped: CPP.EXE's relocations for this module
   (image 0x3161..0x32B7) run in descending order, the compiler's own object, not
   TASM's; the code is the same either way. */
/* CPP.EXE: -d (merge duplicate strings) added: the spellings' literal pool shares
   "<" and "<=" with "<<" and "<<=", "." with "...", "signed" with "unsigned" (whole
   strings and tails); without -d the pool is 0x16 bytes longer and _DATA differs. */
/* Overview: the token reader.  Two token records: CURRENT_TOKEN_RECORD
   (its code is copied to CURRENT_TOKEN) and one token of lookahead in
   TOKEN_TYPE, filled on demand by PEEK_TOKEN from the lexer (LEX_NEXT_TOKEN,
   LEXER.C).  Token code 0x82 in TOKEN_TYPE means "no lookahead read yet";
   code 0 is end of input and 0x34 a string literal.
   A string literal token does not carry its text: the characters are read
   later, one at a time, through NEXT_LITERAL_CHAR.  STRING_TOKEN_PENDING
   says the current token is a literal whose characters have not all been
   read; ADVANCE_TOKEN must drain them before it can move on.
   WRITE_PREPROCESSED_TOKENS (CPP.EXE only) is the preprocessor's main loop.
   BCC's version of this file also played back recorded token streams for
   its C++ front end (TOKSTRM.C) and recorded tokens; CPP.EXE has neither. */
#include "TOKADV.H"
#include "POOL.H"

/* CPP.EXE edit: the preprocessor has no token playback streams, no token recording
   and no parser, so NEXT_LITERAL_CHAR always reads the lexer's string pool,
   PEEK_TOKEN always calls the lexer, and ADVANCE_TOKEN only drains a literal. The
   file gains WRITE_PREPROCESSED_TOKENS, the preprocessor's output loop, and its own initialised data:
   TOKEN_SPELLINGS (DS:03AE), LITERAL_LAST_CHAR (DS:05BA) and the spellings' literal
   pool (DS:05BB..07A8). CPP.EXE's code references DS:03AE, DS:05BA and the pool only
   from this module (image 0x3156..0x32E4). The two data names are chosen here. */

extern void far pascal INIT_PARSER(void);
extern void far pascal BCC_OUTPUT_STRING(char far *text);   /* RFILEIO.C */
extern void far pascal OUTPUT_CHAR(char value);             /* RFILEIO.C */
extern unsigned int NAME_POOL_SEG;
extern char TOKEN_TEXT_BUFFER[];
/* The name record of an identifier token (word 9 of the token record). */
#define TOKEN_NAME (*(unsigned int *)&CURRENT_TOKEN_RECORD.rest[7])

/* The text written for each token code (0x83 codes; 0x82 is "no token"). Identifiers
   (0x31), numbers (0x32, 0x33), string literals (0x34) and character constants (0x65)
   carry their own text and have no entry. */
static char far *TOKEN_SPELLINGS[0x83] = {
    0,
    "(", ")", "[", "]", "{", "}", ";", ",", "...", "\r\n",
    "=", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>=",
    "+", "-", "*", "/", "%", "&", "|", "^", "<<", ">>", "?", ":",
    "||", "&&", "==", "!=", "<", ">", "<=", ">=", "!", "~", "sizeof",
    "++", "--", ".", "->",
    0, 0, 0, 0,
    "static", "extern", "typedef", "register", "auto",
    "char", "short", "int", "unsigned", "signed", "long", "float", "double",
    "struct", "union", "enum", "void",
    "interrupt", "pascal", "cdecl", "_fastcall", "const", "volatile",
    "_loadds", "_saveregs", "_export", "near", "far",
    "_cs", "_ds", "_es", "_ss", "_seg", "huge", "asm",
    "goto", "if", "else", "for", "while", "do", "switch", "return", "break",
    "continue", "default", "case",
    ".*", 0, "->*", "::",
    "class", "delete", "friend", "inline", "new", "operator", "overload",
    "private", "protected", "public", "this", "virtual"
};

/* The character NEXT_LITERAL_CHAR returned last; a backslash makes the next
   character of the literal (or its end) be passed on as is. */
static char LITERAL_LAST_CHAR = 0;

/* Returns the next character of the current string literal, or -1 at its
   end (which also clears STRING_TOKEN_PENDING).  mode is the index of the
   character being read (0 for the first).
   CPP.EXE edit: no playback streams; and a literal that ends right after a
   backslash gives a closing '"' first (image 0x3172..0x3179). */
int far pascal NEXT_LITERAL_CHAR(unsigned int mode)
{
    int character;

    character=NEXT_POOL_CHARACTER(mode);
    if(character==-1 && LITERAL_LAST_CHAR=='\\')
        character='"';
    if(character==-1)
        STRING_TOKEN_PENDING=0;
    LITERAL_LAST_CHAR=LITERAL_LAST_CHAR=='\\' ? ' ' : character;
    return character;
}

/* Makes sure the lookahead record TOKEN_TYPE holds the next token, reading
   it if it is still empty (0x82): from the lexer, or, once end of input was
   seen, a 0 token. CPP.EXE edit: no playback streams and no recording. */
void far pascal PEEK_TOKEN(void)
{
    if(TOKEN_TYPE.kind==0x82) {
        if(END_OF_INPUT_SEEN)
            TOKEN_TYPE.kind=0;
        else
            LEX_NEXT_TOKEN();
    }
}

/* Moves to the next token: drains any unread characters of a string
   literal, notes end of input after a 0 token has been consumed, then makes
   the lookahead the current token, empties the lookahead and sets
   STRING_TOKEN_PENDING if the new token is a string literal.
   CPP.EXE edit: no recording (STREAM_PATCH_LITERAL). */
void far pascal ADVANCE_TOKEN(void)
{
    register unsigned int mode;
    mode=0;
    if(STRING_TOKEN_PENDING)
        while(NEXT_LITERAL_CHAR(mode++)!=-1)
            ;
    if(!CURRENT_TOKEN && !END_OF_INPUT_SEEN)
        END_OF_INPUT_SEEN=1;
    PEEK_TOKEN();
    CURRENT_TOKEN_RECORD=TOKEN_TYPE;
    TOKEN_TYPE.kind=0x82;
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    STRING_TOKEN_PENDING=CURRENT_TOKEN==0x34;
}

/* CPP.EXE only: the preprocessor's main loop, called by BEGIN_SESSION
   (INITPOOL.C) in place of the parser. It reads every token of the source
   up to end of input and writes its text to the output file: an identifier's
   name, the text of a number or character constant (TOKEN_TEXT_BUFFER), a
   string literal between quotes, or the token's spelling. The name is
   descriptive, chosen here (image 0x3223). */
void far pascal WRITE_PREPROCESSED_TOKENS(void)
{
    register unsigned int index;

    INIT_PARSER();
    while(CURRENT_TOKEN) {
        switch(CURRENT_TOKEN) {
        case 0x31: {
            char far *text;
            text=MK_FP(*(unsigned int near *)NAME_W(TOKEN_NAME,NAME_TEXT_BANK),
                       NAME_W(TOKEN_NAME,NAME_TEXT_OFFSET));
            BCC_OUTPUT_STRING(text);
            break;
        }
        case 0x32:
        case 0x33:
        case 0x65:
            BCC_OUTPUT_STRING(TOKEN_TEXT_BUFFER);
            break;
        case 0x34: {
            int c;
            index=0;
            OUTPUT_CHAR('"');
            while((c=NEXT_LITERAL_CHAR(index++))!=-1)
                OUTPUT_CHAR(c);
            OUTPUT_CHAR('"');
            break;
        }
        case 0:
            return;
        default:
            BCC_OUTPUT_STRING(TOKEN_SPELLINGS[CURRENT_TOKEN]);
        }
        ADVANCE_TOKEN();
    }
}

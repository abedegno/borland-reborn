/* target: ovr117_C129UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: parser: inline assembly statements (asm keyword): scans asm tokens, mnemonics and
   operands and hands each statement to the assembler encoder. Entry points:
   BCC_NAME_COMPARE, SCAN_ASM_TOKEN, PARSE_ASM_STATEMENT, BCC_LEX_SPECIAL, BCC_LEX_SKIP. Map
   of all sources: docs/SOURCE-MAP.md. */
/* Overview: the asm statement ("asm mov ax,1" or "asm { ... }"), used by
   both front ends.  The parser calls PARSE_ASM_STATEMENT with the asm
   keyword as current token.  Assembly text is not tokenised as C: this
   file reads the characters straight from the input buffer (GETBYTE) with
   its own scanner SCAN_ASM_TOKEN, which knows assembler mnemonics and
   register names from ASM_KEYWORD_TABLE (245 sorted entries, found by
   binary search).  Each statement is rebuilt as text in
   ASM_STATEMENT_BUFFER (BCC_LEX_SPECIAL appends a character;
   ASM_STATEMENT_CURSOR is the end) and then stored: inside a function as
   a user-label block in the function's code (NEW_ASM_STATEMENT_BLOCK), so it
   comes out in the generated assembly at that point; at file level it is
   written at once to the data segment through EMIT_ASM_STATEMENT.  C
   names in operands are handed to ASM_IDENTIFIER_HOOK and member
   selections ('.') to ASM_TOKEN_2F_HOOK, both set by the front end; a
   register name marks that register as used (CODEGEN_USED_REG_MASK), so
   the code generator saves it.  The token codes returned here are the
   asm scanner's own (5 '{', 6 '}', 7 ';', 0x31 name, 0x32 number, 0x7C end
   of line, 0x74 to 0x80 classes of keywords from the table, 123 any other
   character).  In C (CPP_MODE clear) some problems are only
   warnings. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"

/* ---- R6970 (listing 6970) ---- */
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far cdecl REPORT_WARNING(unsigned int,...);
/* Reports error as an error in C++ and as a warning in C. */
static void near pascal BCC_PARSE_DIAGNOSTIC(register unsigned int error)
{
    if(CPP_MODE) REPORT_CURRENT_TOKEN(error);
    else REPORT_WARNING(error);
}

/* ---- NODEERR (listing 6994) ---- */
#include <dos.h>
extern void far cdecl REPORT_ERROR(unsigned int);
/* Reports error, at the current token in C++. */
static void near pascal BCC_NODE_ERROR(register unsigned int error)
{
    if (CPP_MODE!=0) REPORT_CURRENT_TOKEN(error);
    else REPORT_ERROR(error);
}

/* ---- NAMECMP (listing 69B8) ---- */
extern int far pascal STRING_COMPARE(char far *,char far *);
/* Comparison function for the binary search of ASM_KEYWORD_TABLE: entry
   points at a table entry whose first word is the keyword text. */
int far pascal BCC_NAME_COMPARE(char far *name,char near * far *entry)
{
    return STRING_COMPARE(name,*entry);
}

/* ---- LEXSW (listing 69D1) ---- */
#include <dos.h>
struct Keyword { char near *name; unsigned char token,flags; };
extern char *TOKEN_PTR;
extern char NAME_LIMIT; extern char _CTYPE[];
extern struct Keyword  ASM_KEYWORD_TABLE[];
extern int (far pascal *ASM_KEYWORD_COMPARE_FUNC)(char far *,char near * far *);
extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
extern unsigned char far pascal INPUT_REFILL(void);
extern void far pascal SCAN_EMIT_FAR(char);
extern void far pascal LEX_SPECIAL_BODY(char);
extern void far pascal COMMENT_BLOCK(void);
extern void far pascal COMMENT_LINE(void);
extern void far pascal LEX_IDENTIFIER(int);
extern int far pascal CLASSIFY_IDENTIFIER(void);
extern void far * far pascal BCC_BINARY_SEARCH(char far *,void far *,int,unsigned int,int (far pascal *)(char far *,char near * far *));
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* Scans one assembler token into the token text buffer (TOKEN_TEXT_BUFFER) and
   returns its code.  Blanks are copied to the statement as a separator,
   comments skipped.  A name is first offered to CLASSIFY_IDENTIFIER, so
   macros expand inside asm (an expansion is rescanned); a mnemonic or
   register gives its table token and leaves its flags in
   ASM_MNEMONIC_FLAGS.  Numbers keep their assembler form; a C hex number
   0x.. is rewritten with a trailing 'H'.  A character constant 'x' is a
   number. */
int far pascal SCAN_ASM_TOKEN(void)
{
    register int next,hex;
restart:
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    { int value=GETBYTE;
dispatch:
    SCAN_EMIT_FAR((char)value);
    hex=0;
    switch(value) {
    case 0xfb:goto restart;
    case 9:case ' ':
        LEX_SPECIAL_BODY((char)value);
        goto restart;
    case '{':return 5;
    case '}':return 6;
    case '/':
        next=GETBYTE;
        if(next=='*') {COMMENT_BLOCK();goto comment_restart;}
        if(next=='/') {
            COMMENT_LINE();
comment_restart:
            TOKEN_PTR=TOKEN_TEXT_BUFFER;
            goto restart;
        }
        --INPUT_INDEX;
        break;
    case '$':case '@':case '_':
    case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':case 'G':case 'H':case 'I':case 'J':case 'K':case 'L':case 'M':
    case 'N':case 'O':case 'P':case 'Q':case 'R':case 'S':case 'T':case 'U':case 'V':case 'W':case 'X':case 'Y':case 'Z':
    case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':case 'g':case 'h':case 'i':case 'j':case 'k':case 'l':case 'm':
    case 'n':case 'o':case 'p':case 'q':case 'r':case 's':case 't':case 'u':case 'v':case 'w':case 'x':case 'y':case 'z': {
        struct Keyword far *entry;
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        LEX_IDENTIFIER(value);
        TOKEN_TEXT_BUFFER[NAME_LIMIT]=0;
        if((value=CLASSIFY_IDENTIFIER())!=-2 && value!=-1) goto dispatch;
        entry=BCC_BINARY_SEARCH(TOKEN_TEXT_BUFFER,ASM_KEYWORD_TABLE,245,4,ASM_KEYWORD_COMPARE_FUNC);
        if(entry) {ASM_MNEMONIC_FLAGS=entry->flags;return entry->token;}
        return 49;
    }
    case '0':
        value=GETBYTE;
        if(value=='x' || value=='X') hex=1;
        else --INPUT_INDEX;
    case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8':case '9':
        for(;;) {
            value=GETBYTE;
            if(!(_CTYPE[value+1]&0x12)) break;
            SCAN_EMIT_FAR((char)value);
        }
        if(value=='.' || value=='h' || value=='H') SCAN_EMIT_FAR((char)value);
        else --INPUT_INDEX;
        if(hex) SCAN_EMIT_FAR('H');
        return 50;
    case ';':return 7;
    case 10:case 13:case 26:
        --INPUT_INDEX;
        return 124;
    case '(':return 1;
    case '.':return 47;
    case '\'':
        do {value=GETBYTE;SCAN_EMIT_FAR((char)value);} while(value!='\'');
        return 50;
    }
    return 123;
    }
}
#undef GETBYTE

/* ---- PARSE_ASM_STATEMENT (listing 6D41) ---- */
static int near pascal PARSE_ASM_MNEMONIC(void);
static int near pascal SCAN_ASM_OPERANDS(void);
#include <dos.h>
extern unsigned int TOKEN_TYPE;
extern unsigned long  TOKEN_POSITION;
extern unsigned int STRING_POOL_SEG;
extern char far *ASM_STATEMENT_CURSOR;
static void near pascal BCC_PARSE_DIAGNOSTIC(unsigned int);
static void near pascal BCC_NODE_ERROR(unsigned int);
static int near pascal BCC_LEX_TOKEN(void);
extern void far pascal LEX_HASH(char);
extern unsigned long far pascal INPUT_POSITION(void);
extern unsigned int far pascal NEW_ASM_STATEMENT_BLOCK(char far *,unsigned int,unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern char far * far pascal STRING_COPY(char far *,char far *);
extern void far pascal EMIT_ASM_STATEMENT(unsigned int);
extern void (far pascal *STREAM_HOOK)(unsigned int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* Parses one asm statement, or a braced block of them.  phase: 0 at the
   start, 1 inside asm { ... } (line ends are then crossed, with
   directives handled through LEX_HASH, until the closing brace), 2 after
   a single-line statement.  Each statement is checked through
   BCC_LEX_TOKEN and PARSE_ASM_MNEMONIC / SCAN_ASM_OPERANDS while its text
   is collected, then stored (see the file overview) unless an error
   occurred earlier (NO_ERRORS_YET).  MACRO_MODE is set throughout so the
   lexer helpers stop at line ends. */
void far pascal PARSE_ASM_STATEMENT(void)
{
    register int phase;
    register int result;
    TOKEN_TYPE=0x82;
    phase=0;
    ASM_STATEMENT_FLAG=1;
    MACRO_MODE=1;
    {
    unsigned int valid,parsed,value,copy;
outer:
    valid=1;
restart:
    parsed=0;
    result=0;
    ASM_STATEMENT_CURSOR=ASM_STATEMENT_BUFFER;
    switch(BCC_LEX_TOKEN()) {
    case 1:
        LEX_SPECIAL_BODY(9);
    case 4:
        parsed=1;
        goto expression;
    case 2:
        parsed=PARSE_ASM_MNEMONIC();
        if(parsed) result=SCAN_ASM_OPERANDS();
        break;
    case 6:
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        result=1;
        break;
    case 5:
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        if(!phase) {
            phase=1;
            goto restart;
        }
        BCC_NODE_ERROR(MSG_INLINE_ASSEMBLY_NOT);
        goto restart;
    case 0x7C:
        if(phase==1) {
            value=GETBYTE;
            if(value==0x1A) {
                REPORT_ERROR(MSG_COMPOUND_STATEMENT);
                phase=0;
                break;
            }
            LEX_HASH((char)value);
            TOKEN_LINE=CURRENT_LINE;
            TOKEN_LENGTH=(unsigned int)INPUT_POSITION()-(unsigned int)TOKEN_POSITION+1;
            TOKEN_FILE_NODE=LEX_FILE_SERIAL_NODE;
            ASM_STATEMENT_CURSOR=ASM_STATEMENT_BUFFER;
            TOKEN_PTR=TOKEN_TEXT_BUFFER;
            goto restart;
        }
    case 3:
        BCC_PARSE_DIAGNOSTIC(MSG_UNKNOWN_ASSEMBLER);
        valid=0;
        parsed=1;
        LEX_SPECIAL_BODY(9);
expression:
        result=SCAN_ASM_OPERANDS();
    }
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    if(!phase) phase=2;
    if(parsed) {
        LEX_SPECIAL_BODY(0);
        if(NO_ERRORS_YET) {
            if(CURRENT_SCOPE!=GLOBAL_SCOPE)
                APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,
                    NEW_ASM_STATEMENT_BLOCK(ASM_STATEMENT_BUFFER,valid,TOKEN_FILE_NODE,TOKEN_LINE),LOOP_NEST_FACTOR);
            else {
                value=STRING_LENGTH(ASM_STATEMENT_BUFFER);
                copy=POOL_ALLOC(&STRING_POOL_SEG,value+2);
                STREAM_HOOK(DATA_SEGMENT_ID);
                STRING_COPY(MK_FP(STRING_POOL_SEG,copy),ASM_STATEMENT_BUFFER);
                EMIT_ASM_STATEMENT(copy);
                STRING_COPY(MK_FP(STRING_POOL_SEG,copy),STR_CRLF_2);
                EMIT_ASM_STATEMENT(copy);
            }
        }
    }
    if(result) {
        if(phase!=1) BCC_NODE_ERROR(MSG_INLINE_ASSEMBLY_NOT);
    } else if(phase==1) goto outer;
    MACRO_MODE=0;
    }
}
#undef GETBYTE

/* ---- PARSE_ASM_MNEMONIC (listing 6F5F) ---- */
static int near pascal SCAN_ASM_OPERANDS(void);
extern int far pascal SCAN_ASM_TOKEN(void);
static void near pascal BCC_LEX_ADVANCE(void);
extern void (far pascal *ASM_INSTRUCTION_HOOK)(unsigned int);
/* Reads a mnemonic with any prefix (tokens 0x7E to 0x80 add flags 0x100
   to 0x400, probably rep and segment-override forms).  Inside a function,
   when the token after the mnemonic is a name or one of the keyword
   classes listed, the instruction goes to ASM_INSTRUCTION_HOOK instead
   (probably jumps to C labels, which the compiler must resolve itself);
   then 0 is returned.  Otherwise the mnemonic is copied
   to the statement and 1 is returned. */
static int near pascal PARSE_ASM_MNEMONIC(void)
{
    register int token;
    unsigned int flags=ASM_MNEMONIC_FLAGS;
    LEX_SPECIAL_BODY(9);
    switch(token=SCAN_ASM_TOKEN()) {
    case 0x80:
        flags|=0x100;
        BCC_LEX_ADVANCE();
        token=SCAN_ASM_TOKEN();
        break;
    case 0x7F:
        if((token=SCAN_ASM_TOKEN())!=0x81) { BCC_LEX_ADVANCE(); break; }
        else {
            flags|=0x200;
            BCC_LEX_ADVANCE();
            token=SCAN_ASM_TOKEN();
        }
        break;
    case 0x7E:
        if((token=SCAN_ASM_TOKEN())!=0x81) { BCC_LEX_ADVANCE(); break; }
        else {
            flags|=0x400;
            BCC_LEX_ADVANCE();
            token=SCAN_ASM_TOKEN();
        }
        break;
    }
    switch(token) {
    case 0x31:case 0x74:case 0x75:case 0x76:case 0x77:case 0x78:
    case 0x7B:case 0x7C:case 0x7D:case 0x7E:case 0x7F:case 0x80:
        if(CURRENT_SCOPE!=GLOBAL_SCOPE) {
            ASM_INSTRUCTION_HOOK(flags);
            if(SCAN_ASM_OPERANDS()) --INPUT_INDEX;
            return 0;
        }
    }
    BCC_LEX_ADVANCE();
    return 1;
}

/* ---- SCAN_ASM_OPERANDS (listing 704A) ---- */
struct C9Token {
    char near *name;
    unsigned int flags;
    signed char type;
    unsigned char reserved[2];
};
extern struct C9Token  PSEUDO_REGISTER_TABLE[];
extern unsigned int far pascal RTL_TOUPPER(int);
extern int far pascal COMPARE_NAME(char far *,char far *);
extern void (far pascal *ASM_IDENTIFIER_HOOK)(void);
extern int (far pascal *ASM_TOKEN_2F_HOOK)(void);
/* Copies operands to the statement text up to the end of the statement.
   Returns 1 if it ended at '}' (end of an asm block), 0 at a line end or
   ';'.  A register name (token 0x7A) is looked up as "_XX" in PSEUDO_REGISTER_TABLE
   (the pseudo-register symbols) to mark the register used. */
static int near pascal SCAN_ASM_OPERANDS(void)
{
    register struct C9Token near *entry;
    register int result;
    for(;;) switch(SCAN_ASM_TOKEN()) {
    case 0x7C:
        return 0;
    case 6:
        return 1;
    case 7:
        return 0;
    case 0x32:
        BCC_LEX_ADVANCE(); continue;
    case 0x7A: {
        char name[4];
        name[0]=0x5F;
        name[1]=RTL_TOUPPER(TOKEN_TEXT_BUFFER[0]);
        name[2]=RTL_TOUPPER(TOKEN_TEXT_BUFFER[1]);
        name[3]=0;
        for(entry=PSEUDO_REGISTER_TABLE;entry->name;++entry) {
            if(COMPARE_NAME(entry->name,name)==0) {
                CODEGEN_USED_REG_MASK|=1<<entry->flags;
                break;
            }
        }
        BCC_LEX_ADVANCE(); continue;
    }
    case 0x79:
        BCC_LEX_ADVANCE();
        SCAN_ASM_TOKEN();
        BCC_LEX_ADVANCE(); continue;
    case 0x31:
        ASM_IDENTIFIER_HOOK();
    case 0x74:case 0x76:case 0x77:case 0x78:
    case 0x7D:case 0x7E:case 0x7F:case 0x80:
        BCC_LEX_ADVANCE(); continue;
    case 0x2F:
        result=ASM_TOKEN_2F_HOOK();
        if(!result) return 0;
        if(result==1) BCC_LEX_ADVANCE();
        continue;
    default:
        BCC_LEX_ADVANCE(); continue;
    }
}

/* ---- LTOKEN (listing 7146) ---- */
/* context-helper-sparse-switch: 0x5A 0x238 78 */
/* Classifies the first token of a statement: 0x7C (end of line), 5 or 6
   ('{', '}') are returned as they are; otherwise 1 for an instruction
   needing no further check, 2 for a mnemonic whose operands are checked
   by PARSE_ASM_MNEMONIC, 3 for anything unknown, 4 for a '.' directive.
   Token 0x7D (probably a label or prefix) is copied first.  Token 0x75
   marks a group of registers used (mask 0x1055). */
static int near pascal BCC_LEX_TOKEN(void)
{
    char separator=9;
    register int token;
    token=SCAN_ASM_TOKEN();
    if(token==0x7c || token==5 || token==6) return token;
    if(token==0x7d) {
        LEX_SPECIAL_BODY(separator);
        BCC_LEX_ADVANCE();
        token=SCAN_ASM_TOKEN();
        separator=0x20;
    }
    if(token==0x74 || token==0x77 || token==0x75) {
        if(token==0x75) CODEGEN_USED_REG_MASK|=0x1055;
        LEX_SPECIAL_BODY(separator);
        goto return_one;
    }
    if(token==0x78) {
        LEX_SPECIAL_BODY(separator);
        BCC_LEX_ADVANCE();
        return 2;
    }
    if(token==0x76) {
        LEX_SPECIAL_BODY(separator);
        BCC_LEX_ADVANCE();
        token=SCAN_ASM_TOKEN();
        if(token!=0x77) goto return_three;
return_one:
        BCC_LEX_ADVANCE();
        return 1;
    }
    if(token==0x2f) {
        LEX_SPECIAL_BODY(separator);
        BCC_LEX_ADVANCE();
        return 4;
    }
    LEX_SPECIAL_BODY(separator);
return_three:
    BCC_LEX_ADVANCE();
    return 3;
}

/* ---- LADV (listing 7210) ---- */
/* Direct same-overlay entry has its own address, distinct from the FBOV stub. */
/* Appends the current asm token's text (TOKEN_TEXT_BUFFER) to the statement. */
static void near pascal BCC_LEX_ADVANCE(void)
{
    register char near *cursor;
    cursor=TOKEN_TEXT_BUFFER;
    while(*cursor) {
        LEX_SPECIAL_BODY(*cursor);
        cursor++;
    }
}

/* ---- LSPEC (listing 722C) ---- */
/* Appends one character to ASM_STATEMENT_BUFFER (at most 0x1E0
   characters).  Overflow is reported once the closing 0 is appended. */
void far pascal BCC_LEX_SPECIAL(char value)
{
    if((unsigned int)ASM_STATEMENT_CURSOR<(unsigned int)(ASM_STATEMENT_BUFFER+0x1E0)) {
        *ASM_STATEMENT_CURSOR=value;
        ASM_STATEMENT_CURSOR++;
    } else if(value==0) BCC_NODE_ERROR(MSG_ASSEMBLER_STATEMENT);
}

/* ---- LSKIP (listing 7258) ---- */
#include <dos.h>
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* Skips the rest of an asm statement: up to a line end or ';' (left
   consumed), stepping over quoted text and comments. */
void far pascal BCC_LEX_SKIP(void)
{
    register unsigned int ch;
    for (;;) {
        ch=GETBYTE;
        if (ch==13) return;
        if (ch==10) return;
        if (ch==';') return;
        if (ch=='\'') {
            do { ch=GETBYTE; } while (ch!='\'');
        } else if (ch=='/') {
            ch=GETBYTE;
            if (ch=='*') COMMENT_BLOCK();
            else if (ch=='/') COMMENT_LINE();
            else --INPUT_INDEX;
        }
    }
}
#undef GETBYTE

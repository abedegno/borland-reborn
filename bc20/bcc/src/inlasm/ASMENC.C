/* target: ovr170_C222UNIT */
/* Role: inline assembly encoder. Entry points: ENCODE_ASM_SYMBOL. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO06E (ovr_1dbe_b000) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: front-end support for asm statements in C compiles (the C front end's
   symbol records, CSYM_POOL_SEG; ASMENC2.C holds the same three jobs for C++). The asm
   statement scanner (parser/ASMSTMT.C) rebuilds each statement as text; when it meets a
   C name it calls ENCODE_ASM_SYMBOL through ASM_IDENTIFIER_HOOK, and for a '.' it calls
   PARSE_ASM_MEMBER_ALT through ASM_TOKEN_2F_HOOK. Both work on the token text in
   TOKEN_TEXT_BUFFER and leave there what goes into the statement:
   - for object output a coded name the inline assembler can resolve later
     (DECODE_ASM_SYMBOL in ASMOPND.C): "@S" + 4 letters (a static or global symbol
     record) or "@V" + 4 letters (a variable table entry for an auto or parameter), then
     a size letter; each letter is 'a' + one hex digit;
   - for assembly output the name as the assembler must spell it, or for a local the
     byte 1Ah + 4 letters of its variable entry, which EMIT_ASM_STATEMENT (BLKLAYOT.C)
     later replaces by the name, register or [bp+n];
   - an enum constant becomes its decimal value; a member selection ".name" becomes
     "+offset".
   PARSE_ASM_JUMP_LABEL_ALT handles a jump from asm code to a C label: it makes the
   label known and adds a jump block to the function's flow graph. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- ENCODE_ASM_SYMBOL (listing ovr_1dbe_b000:0000) ---- */
extern signed char COMPILER_MODE;
extern unsigned char OPTION_UNDERSCORES;
extern unsigned int NAME_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG; extern unsigned int STRING_POOL_SEG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern char far *far pascal STRING_COPY(char far *,char far *);
extern void far pascal STRING_APPEND(char far *,char far *);
extern void far pascal RTL_ITOA10(int,char far *);
extern unsigned int far pascal RTL_TOUPPER(int);
extern void far cdecl REPORT_ERROR(unsigned int);
#define NIB(n,s) ((unsigned char)(((n)>>(s))&15)+'a')
/* Replaces the identifier in TOKEN_TEXT_BUFFER by its coded form (see the overview), if it
   names a symbol of the current C scopes. The symbol is marked used and assigned
   (CSYM_FLAGS 0xC0) and, unless flag 8 is set, 0x100 (probably "address taken"); its
   variable entry gets one more use and VAR_FLAGS bit 2 ("in memory"), probably so the
   register allocator keeps it out of registers. In assembly mode: a public data symbol
   gets the data group prefix ("DGROUP:", string 0x38F8 is ":") and falls into the
   external case, which writes the linker spelling (upper case for pascal, '@' for flag
   0x2000, '_' under -u); statics, autos and parameters become the 1Ah marker; any other
   class is "Improper use of a typedef symbol". Nothing changes for an unknown name. */
void far pascal ENCODE_ASM_SYMBOL(void)
{
    long number;
    char far *p;
    unsigned int entry,symbol;
    register unsigned int record;
    register char near *dest;
    symbol=BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER,0x31);
    record=LOOKUP_SYMBOL(symbol,C_DECL_SCOPE,0);
    if (record) {
        CSYM_W(record,CSYM_FLAGS)|=0xC0;
        if (!(CSYM_W(record,CSYM_FLAGS)&8)) CSYM_W(record,CSYM_FLAGS)|=0x100;
        TOKEN_TEXT_BUFFER[0]=0;
        entry=FIND_OR_ADD_VARIABLE(record,0,CSYM_B(record,CSYM_FLAGS));
        ++VAR_W(entry,VAR_USE_COUNT);
        VAR_B(entry,VAR_FLAGS)|=4;
        if (!COMPILER_MODE) {
            switch((unsigned int)CSYM_B(record,CSYM_CLASS)) {
            case 1: case 2: case 3: case 4:
                TOKEN_TEXT_BUFFER[0]='@';TOKEN_TEXT_BUFFER[1]='S';
                TOKEN_TEXT_BUFFER[2]=NIB(record,12);TOKEN_TEXT_BUFFER[3]=NIB(record,8);
                TOKEN_TEXT_BUFFER[4]=NIB(record,4);TOKEN_TEXT_BUFFER[5]=NIB(record,0);
                TOKEN_TEXT_BUFFER[6]=(unsigned char)SIZE_OF_TYPE_CHECKED_HOOK(CSYM_W(record,CSYM_TYPE))+'a';
                TOKEN_TEXT_BUFFER[7]=0;
                break;
            case 5: case 6:
                TOKEN_TEXT_BUFFER[0]='@';TOKEN_TEXT_BUFFER[1]='V';
                TOKEN_TEXT_BUFFER[2]=NIB(entry,12);TOKEN_TEXT_BUFFER[3]=NIB(entry,8);
                TOKEN_TEXT_BUFFER[4]=NIB(entry,4);TOKEN_TEXT_BUFFER[5]=NIB(entry,0);
                TOKEN_TEXT_BUFFER[6]=(unsigned char)SIZE_OF_TYPE_CHECKED_HOOK(CSYM_W(record,CSYM_TYPE))+'a';
                TOKEN_TEXT_BUFFER[7]=0;
                break;
            case 9:
                RTL_ITOA10(CSYM_W(record,CSYM_OFFSET),TOKEN_TEXT_BUFFER);
                break;
            }
        } else {
            switch((unsigned int)CSYM_B(record,CSYM_CLASS)) {
                /* Falls into case 2 on purpose. */
            case 1:
                if (TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_KIND)!=18 && DATA_GROUP_NAME) {
                    STRING_COPY(TOKEN_TEXT_BUFFER,(char far *)MK_FP(STRING_POOL_SEG,DATA_GROUP_NAME));
                    STRING_APPEND(TOKEN_TEXT_BUFFER,(char near *)(STR_COLON_2));
                }
            case 2:
                dest=TOKEN_TEXT_BUFFER+STRING_LENGTH(TOKEN_TEXT_BUFFER);
                p=(char far *)MK_FP(*((unsigned int near *)NAME_W(CSYM_W(record,CSYM_NAME),NAME_TEXT_BANK)),
                                   NAME_W(CSYM_W(record,CSYM_NAME),NAME_TEXT_OFFSET));
                if (CSYM_W(record,CSYM_FLAGS)&0x400) {
                    while (*p) *dest++=RTL_TOUPPER((int)*p++);
                    *dest++=0;
                } else if (CSYM_W(record,CSYM_FLAGS)&0x2000) {
                    *dest++='@';
                    STRING_COPY(dest,p);
                    dest+=STRING_LENGTH(dest);
                } else {
                    if (OPTION_UNDERSCORES) *dest++='_';
                    STRING_COPY(dest,p);
                }
                break;
            case 3: case 4: case 5: case 6:
                TOKEN_TEXT_BUFFER[0]=0x1A;
                number=(unsigned int)entry;
                TOKEN_TEXT_BUFFER[1]=NIB(number,12);TOKEN_TEXT_BUFFER[2]=NIB(number,8);
                TOKEN_TEXT_BUFFER[3]=NIB(number,4);TOKEN_TEXT_BUFFER[4]=((unsigned char)number&15)+'a';
                TOKEN_TEXT_BUFFER[5]=0;
                break;
            case 9:
                RTL_ITOA10(CSYM_W(record,CSYM_OFFSET),TOKEN_TEXT_BUFFER);
                break;
            default:
                REPORT_ERROR(MSG_IMPROPER_USE_TYPEDEF);
            }
        }
    }
}
#undef NIB

/* ---- PARSE_ASM_MEMBER_ALT (listing ovr_1dbe_b000:02FD) ---- */
extern unsigned int NAME_POOL_SEG;
extern int TOKEN_TYPE;
extern long TOKEN_CONST_VALUE;
extern unsigned char TOKEN_PUSHED_BACK;
extern int far pascal SCAN_ASM_TOKEN(void);
extern int far pascal LEX_NEXT_TOKEN(void);
extern int far pascal TOKEN_STARTS_TYPE(int);
extern unsigned int far pascal PARSE_TYPE_NAME_PAREN(void);
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int far pascal LOOKUP_MEMBER(unsigned int,unsigned int,unsigned int);
extern void far pascal BCC_LEX_SPECIAL(unsigned char);
/* Handles '.' in an asm operand. Forms: ".member" or "(type).member" (token 1 is the
   '('; the type must be a struct or union). If the name after the dot is a member (looked
   up in the given type or the C scopes), TOKEN_TEXT_BUFFER becomes "+offset" (for C member
   records MEMB_FLAGS holds the offset). Otherwise the '.' is passed on as an ordinary
   character (BCC_LEX_SPECIAL). Returns 1 when done, 0 at end of line or ';' (tokens 7Ch
   and 7), 2 after a syntax error. The token numbers are the asm scanner's (0x31 a name,
   0x74..0x81 keyword classes). */
static int far pascal PARSE_ASM_MEMBER_ALT(void)
{
    unsigned int first,second;
    register unsigned int node;
    register int token;
    token=SCAN_ASM_TOKEN();
    if(token==1) {
        if(!TOKEN_STARTS_TYPE(TOKEN_PUSHED_BACK!=0 ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())) {
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
            return 2;
        }
        node=PARSE_TYPE_NAME_PAREN();
        if(!node) return 0;
        if(TYPE_B(node,TYPE_KIND)!=19 && TYPE_B(node,TYPE_KIND)!=20) {
            REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
            node=0;
        }
        if(TOKEN_TYPE!=49) {
            REPORT_ERROR(MSG_INVALID_USE_DOT);
            return 2;
        }
        STRING_COPY(TOKEN_TEXT_BUFFER,(char far *)MK_FP(
            *((unsigned int near *)NAME_W((unsigned int)TOKEN_CONST_VALUE,NAME_TEXT_BANK)),
            NAME_W((unsigned int)TOKEN_CONST_VALUE,NAME_TEXT_OFFSET)));
        token=49;
    } else node=0;
    switch(token) {
    case 49: case 116: case 118: case 119: case 120: case 121:
    case 122: case 123: case 124: case 125: case 126: case 127:
    case 128: case 129:
        first=BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER,49);
        second=LOOKUP_MEMBER(first,C_DECL_SCOPE,node);
        if(second!=0) {
            TOKEN_TEXT_BUFFER[0]='+';
            RTL_ITOA10(MEMBER_W(second,MEMB_FLAGS),TOKEN_TEXT_BUFFER+1);
        } else BCC_LEX_SPECIAL('.');
        break;
    default:
        BCC_LEX_SPECIAL('.');
        if(token==124) return 0;
        if(token==7) return 0;
    }
    return 1;
}

/* ---- PARSE_ASM_JUMP_LABEL_ALT (listing ovr_1dbe_b000:046E) ---- */
extern unsigned int BCC_TREE_SPECIAL; extern unsigned int LOOP_BLOCK_WEIGHT; extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal BCC_LEX_SPECIAL(unsigned char);
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NEW_LABEL(void);
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
/* A jump in asm code to the C label named in TOKEN_TEXT_BUFFER: appends '@' to the statement
   text, finds or declares the label in the function scope (with a new code label), marks
   it used, and adds a jump block of jump kind value (flag 0x100) at the current line to
   the function's block chain. */
static void far pascal PARSE_ASM_JUMP_LABEL_ALT(unsigned int value)
{
    unsigned int name;
    register unsigned int symbol;
    register unsigned int node;
    BCC_LEX_SPECIAL(0x40);
    name=BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER,0x31);
    symbol=LOOKUP_SYMBOL(name,C_FUNCTION_SCOPE,1);
    if(symbol==0) {
        symbol=DECLARE_SYMBOL(name,C_FUNCTION_SCOPE,1,3,0,0,0);
        CSYM_W(symbol,CSYM_LABEL)=NEW_LABEL();
    }
    CSYM_W(symbol,CSYM_FLAGS)|=0x80;
    node=NEW_JUMP_BLOCK(CSYM_W(symbol,CSYM_LABEL),TOKEN_FILE_NODE,TOKEN_LINE,TOKEN_FILE_NODE,TOKEN_LINE);
    CNODE_W(node,CNODE_JUMP_KIND)=value;
    CNODE_W(node,CNODE_FLAGS)|=0x100;
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,node,LOOP_BLOCK_WEIGHT);
}

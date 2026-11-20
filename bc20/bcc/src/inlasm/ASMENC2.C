/* target: ovr088_C227UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: inline assembly encoder (second copy, other pools). Entry points: FIND_ASM_MEMBER,
   ENCODE_ASM_SYMBOL_ALT, PARSE_ASM_MEMBER, PARSE_ASM_JUMP_LABEL. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C++ front end's twin of ASMENC.C: the hooks the asm statement scanner
   (parser/ASMSTMT.C) calls for C names (ENCODE_ASM_SYMBOL_ALT, through
   ASM_IDENTIFIER_HOOK) and for '.' member selections (PARSE_ASM_MEMBER, through
   ASM_TOKEN_2F_HOOK), and the jump to a C label from asm code (PARSE_ASM_JUMP_LABEL).
   They read the C++ symbol records (SYMBOL_POOL_SEG, scopes from CURRENT_SCOPE) and
   leave the replacement text in TOKEN_TEXT_BUFFER: "@S"/"@V" coded names for object output
   (decoded by DECODE_ASM_SYMBOL in ASMOPND.C), real spellings or the 1Ah marker for
   assembly output, decimal values for enum constants, "+offset" for members. The ALT
   suffixes are swapped against ASMENC.C: here the encoder is ..._ALT and the member and
   label parsers are not. The repeated #include <dos.h> lines come from the separate
   listing modules this file was joined from. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- FIND_ASM_MEMBER (listing BA90) ---- */
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG; extern unsigned int NAME_POOL_SEG; extern unsigned int HASH_CHAIN_LINK_SEG;
extern unsigned int near  NAME_HASH_TABLE[];
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
/* Finds a data member called name for ".name" without a type: first in the struct tags
   of every scope from CURRENT_SCOPE out to (not including) the global scope, then in the
   type of every symbol of the whole name table whose name-space kind is 2 (tags) and
   which is not an enum. Returns the member record or 0. */
unsigned int far pascal FIND_ASM_MEMBER(unsigned int name)
{
    unsigned int result;
    int bucket;
    unsigned int chain;
    register unsigned int entry;
    register unsigned int scope;
    for(scope=CURRENT_SCOPE;scope!=GLOBAL_SCOPE;scope=SCOPE_W(scope,SCOPE_PARENT)) {
        for(entry=SCOPE_W(scope,SCOPE_TAGS);entry;entry=SYM_W(entry,SYM_NEXT)) {
            result=FIND_MEMBER_BY_NAME(name,SYM_W(entry,SYM_TYPE));
            if(result) return result;
        }
    }
    for(bucket=0;bucket<0x400;bucket++) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=HLINK_W(chain,HLINK_NEXT)) {
            for(entry=NAME_W(chain,NAME_SYMBOLS);entry;entry=SYM_W(entry,SYM_NEXT)) {
                if((SYM_B(entry,SYM_STORAGE_CLASS)&7)==2
                   && TYPE_W(SYM_W(entry,SYM_TYPE),TYPE_KIND)!=0x15) {
                    result=FIND_MEMBER_BY_NAME(name,SYM_W(entry,SYM_TYPE));
                    if(result) return result;
                }
            }
        }
    }
    return 0;
}

/* ---- ENCODE_ASM_SYMBOL_ALT (listing BB6A) ---- */
#include <dos.h>
extern signed char  COMPILER_MODE;
extern unsigned char  OPTION_UNDERSCORES;
extern unsigned int VARIABLE_TABLE_SEG; extern unsigned int STRING_POOL_SEG;
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern unsigned int far pascal GET_PREPARED_FLAGS(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern char far *far pascal STRING_COPY(char far *,char far *);
extern void far pascal STRING_APPEND(char far *,char far *);
extern void far pascal RTL_ITOA10(int,char far *);
extern unsigned int far pascal RTL_TOUPPER(int);
extern void far cdecl REPORT_ERROR(unsigned int);
#define NIB(n,s) ((unsigned char)(((n)>>(s))&15)+'a')
/* Replaces the identifier in TOKEN_TEXT_BUFFER by its coded form if it names a visible symbol
   (LOOKUP_NAME). The symbol is marked used (SYM_FLAGS 4) and, if not a function,
   defined (2). Object mode: "@S" + the prepared storage record for classes 1-4, "@V" +
   the variable entry for autos and parameters (5, 6; their entry gets a use and
   VAR_FLAGS bit 2), then a size letter; enum constants (9) give their value. Assembly
   mode: publics (data with the data group prefix "DGROUP:") fall into externals and get
   the linker spelling; class 3 data gets the group prefix too and falls into classes
   4-6, which become the 1Ah marker + variable entry; other classes are "Improper use of
   a typedef symbol". C++ mangled names are not produced here. */
void far pascal ENCODE_ASM_SYMBOL_ALT(void)
{
    char far *p;
    unsigned int symbol;
    unsigned int entry;
    register unsigned int node;
    register char near *dest;
    symbol=BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER,0x31);
    node=LOOKUP_NAME(symbol);
    if(node==0) return;
    SYM_B(node,SYM_FLAGS)|=4;
    if(TYPE_W(SYM_W(node,SYM_TYPE),TYPE_KIND)!=0x12) SYM_B(node,SYM_FLAGS)|=2;
    TOKEN_TEXT_BUFFER[0]=0;
    dest=TOKEN_TEXT_BUFFER;
    if(!COMPILER_MODE) {
        switch(SYM_B(node,SYM_STORAGE_CLASS)>>3) {
        case 1: case 2: case 3: case 4:
            dest[0]='@';dest[1]='S';
            dest[2]=NIB(PREPARE_SYMBOL(node),12);dest[3]=NIB(PREPARE_SYMBOL(node),8);
            dest[4]=NIB(PREPARE_SYMBOL(node),4);dest[5]=NIB(PREPARE_SYMBOL(node),0);
            dest[6]=(unsigned char)TYPE_SIZE(SYM_W(node,SYM_TYPE))+'a';
            dest[7]=0;
            break;
        case 5: case 6:
            entry=FIND_OR_ADD_VARIABLE(PREPARE_SYMBOL(node),0,GET_PREPARED_FLAGS(PREPARE_SYMBOL(node)));
            ++VAR_W(entry,VAR_USE_COUNT);
            VAR_B(entry,VAR_FLAGS)|=4;
            dest[0]='@';dest[1]='V';
            dest[2]=NIB(entry,12);dest[3]=NIB(entry,8);
            dest[4]=NIB(entry,4);dest[5]=NIB(entry,0);
            dest[6]=(unsigned char)TYPE_SIZE(SYM_W(node,SYM_TYPE))+'a';
            dest[7]=0;
            break;
        case 9:
            RTL_ITOA10(SYM_W(node,SYM_STORAGE),TOKEN_TEXT_BUFFER);
            break;
        }
    } else {
        switch(SYM_B(node,SYM_STORAGE_CLASS)>>3) {
            /* Falls into case 2 on purpose; case 3 below likewise falls into 4. */
        case 1:
            if(TYPE_W(SYM_W(node,SYM_TYPE),TYPE_KIND)!=0x12 && DATA_GROUP_NAME) {
                STRING_COPY(TOKEN_TEXT_BUFFER,(char far *)MK_FP(STRING_POOL_SEG,DATA_GROUP_NAME));
                STRING_APPEND(TOKEN_TEXT_BUFFER,STR_COLON);
            }
        case 2:
            dest=TOKEN_TEXT_BUFFER+STRING_LENGTH(TOKEN_TEXT_BUFFER);
            p=(char far *)MK_FP(*((unsigned int near *)NAME_W(SYM_W(node,SYM_NAME),NAME_TEXT_BANK)),
                               NAME_W(SYM_W(node,SYM_NAME),NAME_TEXT_OFFSET));
            if(SYM_B(node,SYM_FLAGS)&0x40) {
                while(*p) *dest++=RTL_TOUPPER((int)*p++);
                *dest++=0;
            } else {
                if(OPTION_UNDERSCORES) *dest++='_';
                STRING_COPY(dest,p);
            }
            break;
        case 3:
            if(TYPE_W(SYM_W(node,SYM_TYPE),TYPE_KIND)!=0x12 && DATA_GROUP_NAME) {
                STRING_COPY(dest,(char far *)MK_FP(STRING_POOL_SEG,DATA_GROUP_NAME));
                STRING_APPEND(dest,STR_COLON);
                dest+=STRING_LENGTH(dest);
            }
        case 4: case 5: case 6:
            {
                unsigned int number;
                entry=FIND_OR_ADD_VARIABLE(PREPARE_SYMBOL(node),0,GET_PREPARED_FLAGS(PREPARE_SYMBOL(node)));
                ++VAR_W(entry,VAR_USE_COUNT);
                VAR_B(entry,VAR_FLAGS)|=4;
                number=entry;
                dest[0]=0x1A;
                dest[1]=NIB(number,12);dest[2]=NIB(number,8);
                dest[3]=NIB(number,4);dest[4]=((unsigned char)number&15)+'a';
                dest[5]=0;
            }
            break;
        case 9:
            RTL_ITOA10(SYM_W(node,SYM_STORAGE),TOKEN_TEXT_BUFFER);
            break;
        default:
            REPORT_ERROR(MSG_IMPROPER_USE_TYPEDEF);
        }
    }
}
#undef NIB

/* ---- PARSE_ASM_MEMBER (listing BE7E) ---- */
#include <dos.h>
extern unsigned int CURRENT_TOKEN_RECORD;
extern int  TOKEN_TYPE;
extern long  TOKEN_CONST_VALUE;
extern int far pascal SCAN_ASM_TOKEN(void);
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned int far pascal PARSE_TYPE_NAME(unsigned int);
extern int far pascal LEX_NEXT_TOKEN(void);
extern void far pascal BCC_LEX_SPECIAL(unsigned char);
/* Handles '.' in an asm operand: ".member" or "(type).member" (the type must be a
   struct). A data member (MEMB_FLAGS kind 0) found in the type, or by FIND_ASM_MEMBER,
   turns TOKEN_TEXT_BUFFER into "+offset" (MEMB_VALUE); otherwise the '.' is passed on as an
   ordinary character. Returns 1 when done, 0 at end of line or ';', 2 after an error. */
int far pascal PARSE_ASM_MEMBER(void)
{
    unsigned int name;
    int token;
    register unsigned int node;
    register unsigned int member;
    token=SCAN_ASM_TOKEN();
    if(token==1) {
        ADVANCE_TOKEN();
        if(!TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD)) {
            REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
            return 2;
        }
        node=PARSE_TYPE_NAME(3);
        LEX_NEXT_TOKEN();
        if(!node) return 0;
        if(TYPE_W(node,TYPE_KIND)!=0x13) {
            REPORT_CURRENT_TOKEN(MSG_NOT_ALLOWED_TYPE);
            node=0;
        }
        if(TOKEN_TYPE!=0x31) {
            REPORT_CURRENT_TOKEN(MSG_INVALID_USE_DOT);
            return 2;
        }
        STRING_COPY(TOKEN_TEXT_BUFFER,(char far *)MK_FP(
            *((unsigned int near *)NAME_W((unsigned int)TOKEN_CONST_VALUE,NAME_TEXT_BANK)),
            NAME_W((unsigned int)TOKEN_CONST_VALUE,NAME_TEXT_OFFSET)));
        token=0x31;
    } else node=0;
    switch(token) {
    case 0x31: case 0x74: case 0x76: case 0x77: case 0x78: case 0x79:
    case 0x7A: case 0x7B: case 0x7C: case 0x7D: case 0x7E: case 0x7F:
    case 0x80: case 0x81:
        name=BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER,0x31);
        member=node==0 ? FIND_ASM_MEMBER(name) : FIND_MEMBER_BY_NAME(name,node);
        if(member && (MEMBER_B(member,MEMB_FLAGS)&3)==0) {
            TOKEN_TEXT_BUFFER[0]='+';
            RTL_ITOA10(MEMBER_W(member,MEMB_VALUE),TOKEN_TEXT_BUFFER+1);
        } else BCC_LEX_SPECIAL('.');
        break;
    default:
        BCC_LEX_SPECIAL('.');
        if(token==0x7C) return 0;
        if(token==7) return 0;
    }
    return 1;
}

/* ---- PARSE_ASM_JUMP_LABEL (listing BFEC) ---- */
#include <dos.h>
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int far pascal ALLOC_LABEL_RECORD(void);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
/* A jump in asm code to the C label named in TOKEN_TEXT_BUFFER: appends '@' to the statement
   text, finds the label in LABEL_LIST_HEAD (record 0's name is set to the name first, as
   a sentinel, so the search loop always stops; ending at 0 means not found) or creates
   it, and while code is being generated (NO_ERRORS_YET) adds a jump block of jump kind
   value (flag 0x100) to the function's block chain (BCC_PARSE_BUFFER). */
void far pascal PARSE_ASM_JUMP_LABEL(unsigned int value)
{
    unsigned int name;
    register unsigned int label;
    register unsigned int node;
    BCC_LEX_SPECIAL(0x40);
    name=BCC_SYMBOL_CREATE(TOKEN_TEXT_BUFFER,0x31);
    LABEL_W(0,2)=name;
    for(label=LABEL_LIST_HEAD;LABEL_W(label,LABEL_NAME)!=name;label=LABEL_W(label,LABEL_NEXT));
    if(!label) {
        label=ALLOC_LABEL_RECORD();
        LABEL_W(label,LABEL_NAME)=name;
        LABEL_W(label,LABEL_BLOCK)=NEW_LABEL_IF_ENABLED();
        LABEL_W(label,LABEL_TEMPS)=0;
        LABEL_W(label,LABEL_SERIAL_LOW)=0;
        LABEL_W(label,LABEL_SERIAL_HIGH)=0x7FFF;
    }
    if(NO_ERRORS_YET) {
        node=NEW_JUMP_BLOCK(LABEL_W(label,LABEL_BLOCK),TOKEN_FILE_NODE,TOKEN_LINE,TOKEN_FILE_NODE,TOKEN_LINE);
        CNODE_W(node,CNODE_JUMP_KIND)=value;
        CNODE_W(node,CNODE_FLAGS)|=0x100;
        APPEND_BLOCK_CHAIN(BCC_PARSE_BUFFER,node,LOOP_NEST_FACTOR);
    }
}

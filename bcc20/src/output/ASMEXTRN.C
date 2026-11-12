/* target: ovr169_C218UNIT */
/* Role: assembly text output (-S): externals and COMM declarations, function debug
   information, hex byte lists, symbol names. Entry points: EMIT_HEX_BYTE_LIST,
   EMIT_ASM_EXTERNALS, EMIT_ASM_SYMBOL_NAME. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO06D (ovr_1dbb_afa6) as one source. */
/* opts: -mm -G -O -Z -p -Y */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"



/* Overview: pieces of the assembly-text writer used when BCC writes a .asm file (-S, or
   -B where TASM assembles it). They are reached through the back end's hook table, not
   called by name. ASMSYMS.C does the same work on the C++ symbol records; this file
   reads the C front end's records (CSYM_POOL_SEG). Text goes out through
   PUT_CODE_STRING/PUT_CODE_CHAR; most literal strings are named by their DS offset
   (TEXT(0x....)), with their contents noted below.
   - EMIT_HEX_BYTE_LIST writes a debug record as "?debug C xx,xx,..." lines, the TASM
     directive that copies bytes into an object COMENT record.
   - EMIT_ASM_EXTERNALS walks the module's symbol records (the C_GLOBAL_SCOPE list in
     CSYM_POOL_SEG) at the end of the file and writes extrn, COMM, public, publicdll and
     equ lines, then the per-function ?debug lines when -v is on.
   - EMIT_ASM_SYMBOL_NAME writes how a symbol is spelled in the assembly text.
   CSYM_CLASS values as this file uses them: 1 public, 2 external, 3 defined here and
   written under its plain name (probably the module's own functions and variables),
   4 static data addressed from the d@ / b@ base labels. CSYM_FLAGS bits
   used: 0x80/0x40 used or assigned, 0x400 pascal name (upper case), 0x800 communal
   (COMM), 0x2000 name written with a leading '@' (probably a C++ mangled name).
   The register pseudo-variables (_SI, _DI, _BX, _ES) are kept as written for byte
   matching; ES_W/ES_B read a word or byte at ES:offset. */
/* ---- EMIT_HEX_BYTE_LIST (listing ovr_1dbb_afa6:FA60) ---- */
extern unsigned int DEBUG_STATE;
extern unsigned int far pascal OBJ_RECORD_BUFFER(void);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal EMIT_HEX_BYTE(int value);

/* Writes the bytes of the current object record buffer (OBJ_RECORD_BUFFER, skipping its
   first byte) as hex values after "\t?debug\tC ", 20 per line, continued with
   "+\r\n\t?debug\tC ", ending with "\r\n". count is the record length
   (OBJ_WRITE_RECORD calls this through OBJ_RECORD_HOOK in assembly mode); the first byte,
   the COMENT attribute, is skipped, so count - 1 bytes are written. Unless the first
   byte written (the comment class) is E6h, DEBUG_STATE is set to FFFFh while the bytes
   are written, and restored after. */
void far pascal EMIT_HEX_BYTE_LIST(int count)
{
    unsigned int saved;
    register int out_count;

    saved = DEBUG_STATE;
    _AX = OBJ_RECORD_BUFFER();
    _AX++;
    _SI = _AX;
    if (*((unsigned char near *)_SI) != 0xE6)
        DEBUG_STATE = 0xFFFF;
    PUT_CODE_STRING((char far *)MK_FP(_DS, 0x381A));
    out_count = 0;
output_loop:
    EMIT_HEX_BYTE(*((signed char near *)_SI));
    out_count++;
    _SI++;
    count--;
    if (count <= 1)
        goto done;
    if (out_count < 20)
        goto output_loop;
    PUT_CODE_STRING((char far *)MK_FP(_DS, 0x3825));
    out_count = 0;
    goto output_loop;
done:
    PUT_CODE_STRING((char far *)MK_FP(_DS, 0x3833));
    DEBUG_STATE = saved;
}

/* ---- EMIT_ASM_EXTERNALS (listing ovr_1dbb_afa6:FAC3) ---- */
static void near pascal EMIT_ASM_FUNCTION_DEBUG(unsigned int records);
extern unsigned int SCOPE_POOL_SEG; extern unsigned int NAME_POOL_SEG;
extern unsigned char OPTION_SOURCE_DEBUG;
extern signed char OPTION_UNDERSCORES;
extern char far *ASM_TYPE_NAME_TABLE[];
extern void (far pascal *NAME_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal EMIT_COMM_DECLARATION(unsigned int,unsigned int,unsigned int,long);
extern void far pascal EMIT_SIGNED_DECIMAL(unsigned int);
#define TEXT(n) ((char near *)(n))
/* End-of-module declarations for every used or assigned symbol (flags 0xC0):
   external (class 2): "\textrn\tname:type" with the type word from ASM_TYPE_NAME_TABLE
   ("near" for a function placed in a segment), or a COMM declaration for a communal
   variable, with the element size and count of an array; public (class 1):
   "\tpublic\tname" or "\tpublicdll\tname" for an exported function (type flag 0x80); it
   then falls into the class-3 case on purpose. Class 3 at segment 0: "name\tequ\ts@+n",
   a name inside the string-literal block s@. Last, a class-3 symbol whose public
   assembly spelling differs from its plain name (a pascal name with lower-case letters,
   or any name under -u) gets "public-spelling\tequ\tname"; the class byte is changed to 1
   and back to 3 so NAME_HOOK writes both spellings. */
void far pascal EMIT_ASM_EXTERNALS(void)
{
    unsigned int number;
    long product;
    unsigned int first;
    char far *p;
    _BX=C_GLOBAL_SCOPE;
    _ES=SCOPE_POOL_SEG;
    first=ES_W(_BX,SCOPE_TAGS);
    _SI=first;
    while (_SI) {
        _ES=CSYM_POOL_SEG;
        if (!(ES_W(_SI,CSYM_FLAGS)&0xC0)) goto next;
        _ES=CSYM_POOL_SEG;
            /* Note: case 1 has no break and continues into case 3. */
        switch ((unsigned int)ES_B(_SI,CSYM_CLASS)) {
        case 2:
            _ES=CSYM_POOL_SEG;
            if (ES_W(_SI,CSYM_FLAGS)&0x800) {
                _DI=ES_W(_SI,CSYM_TYPE);
                product=1;
                while (TYPE_B(_DI,TYPE_KIND)==17) {
                    product*=*((long far *)MK_FP(TYPE_POOL,_DI+TYPE_MEMBER_CLASS));
                    _ES=TYPE_POOL;
                    _DI=ES_W(_DI,TYPE_TARGET);
                }
                EMIT_COMM_DECLARATION(_SI,(CSYM_W(_SI,CSYM_SEGMENT)!=BSS_SEGMENT_ID),SIZE_OF_TYPE_CHECKED_HOOK(_DI),product);
            } else {
                PUT_CODE_STRING(TEXT(0x3836));
                NAME_HOOK(_SI);
                PUT_CODE_CHAR(0x3A);
                number=SYMBOL_ELEMENT_KIND_HOOK(_SI);
                if (number==18 && CSYM_W(_SI,CSYM_SEGMENT)!=0xFFFF)
                    PUT_CODE_STRING(TEXT(0x383E));
                else PUT_CODE_STRING(ASM_TYPE_NAME_TABLE[number]);
            }
            PUT_CODE_STRING(TEXT(0x3833));
            break;
        case 1:
            _BX=CSYM_W(_SI,CSYM_TYPE);
            _ES=TYPE_POOL;
            if (ES_B(_BX,TYPE_KIND)==18 && (TYPE_B(CSYM_W(_SI,CSYM_TYPE),TYPE_C_FUNC_FLAGS)&0x80))
                PUT_CODE_STRING(TEXT(0x3843));
            else PUT_CODE_STRING(TEXT(0x384F));
            NAME_HOOK(_SI);
            PUT_CODE_STRING(TEXT(0x3833));
        case 3:
            _ES=CSYM_POOL_SEG;
            if (ES_W(_SI,CSYM_SEGMENT)==0) {
                _BX=CSYM_W(_SI,CSYM_TYPE);
                _ES=TYPE_POOL;
                if (ES_B(_BX,TYPE_KIND)!=18) {
                    NAME_HOOK(_SI);
                    PUT_CODE_STRING(TEXT(0x3858));
                    _ES=CSYM_POOL_SEG;
                    EMIT_SIGNED_DECIMAL(ES_W(_SI,CSYM_OFFSET));
                    PUT_CODE_STRING(TEXT(0x3833));
                }
            }
            break;
        }
        _ES=CSYM_POOL_SEG;
        if (ES_B(_SI,CSYM_CLASS)!=3) goto next;
        if (ES_W(_SI,CSYM_SEGMENT)==0) goto next;
        if (ES_W(_SI,CSYM_FLAGS)&0x400) {
            _BX=ES_W(_SI,CSYM_NAME);
            _ES=NAME_POOL_SEG;
            _BX=ES_W(_BX,NAME_TEXT_BANK);
            _AX=*((unsigned int near *)_BX);
            _BX=CSYM_W(_SI,CSYM_NAME);
            _ES=NAME_POOL_SEG;
            _DX=ES_W(_BX,NAME_TEXT_OFFSET);
            p=(char far *)MK_FP(_AX,_DX);
            while (*p) {
                if (CTYPE_BY_CHAR[(int)*p]&8) break;
                ++p;
            }
            if (*p==0) goto next;
        } else if (OPTION_UNDERSCORES==0) goto next;
        _ES=CSYM_POOL_SEG;
        ES_B(_SI,CSYM_CLASS)=1;
        NAME_HOOK(_SI);
        PUT_CODE_STRING(TEXT(0x3861));
        _ES=CSYM_POOL_SEG;
        ES_B(_SI,CSYM_CLASS)=3;
        NAME_HOOK(_SI);
        PUT_CODE_STRING(TEXT(0x3833));
next:
        _ES=CSYM_POOL_SEG;
        _SI=ES_W(_SI,CSYM_NEXT);
    }
    /* first: the head of the symbol list walked above. */
    if (OPTION_SOURCE_DEBUG) EMIT_ASM_FUNCTION_DEBUG(first);
}
#undef TEXT

/* ---- EMIT_ASM_FUNCTION_DEBUG (listing ovr_1dbb_afa6:FD26) ---- */
extern signed char  OPTION_MEMORY_MODEL;
extern void (far pascal *DEBUG_HEADER_DONE_HOOK)(void);
extern void far pascal PUT_CODE_STRING(char far *);
extern char far *far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal EMIT_DECIMAL(unsigned int);
#define RECORD_TYPE(r) FAR_W(CSYM_POOL_SEG,(r),CSYM_TYPE)
/* With -v: writes "\t?debug\tC EA01mm" (a Turbo Debugger header comment: class EAh,
   version 01, memory model with the -u flag in bit 3), calls DEBUG_HEADER_DONE_HOOK, then
   one "\t?debug\tF name typeindex flags" line per function of class 3 in the list
   records. flags is 18h or 98h (type pointer qualifier 4) for symbols with CSYM_FLAGS
   bit 0x20, else 0. */
static void near pascal EMIT_ASM_FUNCTION_DEBUG(unsigned int records)
{
    unsigned char flag;
    register unsigned int record;
    PUT_CODE_STRING(STR_DEBUG_C);
    EMIT_HEX_BYTE(0xEA);
    PUT_CODE_STRING(STR_01);
    EMIT_HEX_BYTE(OPTION_MEMORY_MODEL|(OPTION_UNDERSCORES<<3));
    PUT_CODE_STRING(STR_CR_NL);
    DEBUG_HEADER_DONE_HOOK();
    for(record=records;record!=0;record=CSYM_W(record,CSYM_NEXT)) {
        if(CSYM_B(record,CSYM_CLASS)!=3) continue;
        if(TYPE_B(RECORD_TYPE(record),TYPE_KIND)!=0x12) continue;
        flag=0;
        if(CSYM_W(record,CSYM_FLAGS)&0x20)
            flag |= TYPE_B(RECORD_TYPE(record),TYPE_C_PTR_QUALS)==4 ? 0x98 : 0x18;
        PUT_CODE_STRING(STR_DEBUG_F);
        PUT_CODE_STRING(NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
        PUT_CODE_CHAR(0x20);
        EMIT_DECIMAL(TYPE_W(RECORD_TYPE(record),TYPE_C_DEBUG_INDEX));
        PUT_CODE_CHAR(0x20);
        EMIT_DECIMAL(flag);
        PUT_CODE_STRING(STR_CR_NL);
    }
}
#undef RECORD_TYPE

/* ---- EMIT_ASM_SYMBOL_NAME (listing ovr_1dbb_afa6:FE31) ---- */
extern unsigned int NAME_POOL_SEG;
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal EMIT_DECIMAL(unsigned int);
#define TEXT(n) ((char near *)(n))
#define NAME_WORD(r,n) FAR_W(NAME_POOL_SEG,FAR_W(CSYM_POOL_SEG,(r),CSYM_NAME),(n))
/* Writes the assembly spelling of symbol record node. Class 4: "d@+n" (in the data
   segment) or "b@+n" (BSS), with "w" before the "+" when SYMBOL_ELEMENT_KIND_HOOK gives
   a kind above 2. Other classes: the name is copied to BCC_DEBUG_NAME (DS:5F50); class 3
   as it is; a pascal name (0x400) in upper case; else with a leading '@' (flag 0x2000)
   or '_' (under -u). */
void far pascal EMIT_ASM_SYMBOL_NAME(register unsigned int node)
{
    char far *p;
    if (CSYM_B(node,CSYM_CLASS)==4) {
        if (CSYM_W(node,CSYM_SEGMENT)==DATA_SEGMENT_ID) PUT_CODE_STRING(TEXT(0x3875));
        else PUT_CODE_STRING(TEXT(0x3878));
        if (SYMBOL_ELEMENT_KIND_HOOK(node)>2) PUT_CODE_CHAR(0x77);
        PUT_CODE_CHAR(0x2B);
        EMIT_DECIMAL(CSYM_W(node,CSYM_OFFSET));
    } else {
        p=STRING_COPY(TEXT(0x5F50),(char far *)MK_FP(
            *((unsigned int near *)NAME_WORD(node,4)),NAME_WORD(node,2)));
        if (CSYM_B(node,CSYM_CLASS)==3)
            PUT_CODE_STRING(p);
        else if (CSYM_W(node,CSYM_FLAGS)&0x400) {
            while (*p) {
                PUT_CODE_CHAR(RTL_TOUPPER((int)*p));
                ++p;
            }
        } else {
            if (CSYM_W(node,CSYM_FLAGS)&0x2000) PUT_CODE_CHAR(0x40);
            else if (OPTION_UNDERSCORES) PUT_CODE_CHAR(0x5F);
            PUT_CODE_STRING(p);
        }
    }
}
#undef TEXT
#undef NAME_WORD

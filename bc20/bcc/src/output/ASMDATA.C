/* target: ovr180_C102UNIT */
/* Role: assembly text output (-S). Entry points: EMIT_PROC_BEGIN, ALIGN_ASM_DATA_EVEN,
   EMIT_DB_DATA, EMIT_PROC_OR_LABEL, EMIT_PROC_ENDP, EMIT_LOCAL_LABEL,
   ADD_JUMP_18_NEXT_FRAGMENT, EMIT_ASM_LINE_MARK (+2 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO077 (ovr_1de3_b3c8) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: small writers of the assembly-text output (BCC's .asm file under -S or -B),
   reached mostly through the back end's hook table. They keep the segment records
   (SEGDEF_POOL_SEG, FIELDS.H SEGDEF_*) up to date while writing, so the assembly path
   tracks segment sizes the same way the object path does.
   - EMIT_PROC_BEGIN switches the text to another segment: "name ends" for the open one
     (EMIT_SEGMENT_END), then "name\tsegment byte|word|para public 'class'". A virtual
     segment (SEGDEF_PARENT_ID set) is opened inside its parent code segment as
     "name\tsegment\tvirtual".
   - RESERVE_DATA_BYTES, EMIT_DB_DATA, EMIT_DW_ADDRESS, EMIT_DD_ADDRESS write db/dw/dd
     data and grow the segment's size, with the fatal "Too much global data defined in
     file" past 64 KB. SEGDEF_FIRST_BLOCK is used here only as a "has initialized data"
     mark: reserved space is written as "dup (0)" after real data, "dup (?)" before.
   - EMIT_PROC_OR_LABEL writes the label line of a public or static symbol: for a
     function "assume cs:group" and "name\tproc\tfar|near", else "name\tlabel\ttype".
   - EMIT_LOCAL_LABEL writes a jump label "@<function serial>@C<n>\tlabel\tword"
     (strings 0x5A0F/0x5A12), EMIT_ASM_LINE_MARK a source-line marker.
   - EMIT_DECIMAL and EMIT_SIGNED_DECIMAL print numbers.
   Literal texts are addressed by DS offset; 0x7846 passed to PUT_FAR_STRING is
   probably the address of the string-pool segment word, so the name offsets that
   follow are read from STRING_POOL_SEG. Code with register pseudo-variables
   (_SI, _DI, _ES, and the odd _SI=_SI) is kept as written for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STAOV189 (listing ovr_1de3_b3c8:3C80) ---- */
static void near pascal EMIT_SEGMENT_END(void);
extern unsigned int STRING_POOL_SEG;
extern int DEBUG_STATE;
extern void far pascal EMIT_ASM_HEADER_FAR(void);
extern unsigned int far pascal SELECT_SEGMENT(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal PUT_FAR_STRING(unsigned int,unsigned int);
#define TEXT(n) ((char near *)(n))
/* Makes segment id value the one the text is written into, writing the segment header
   first (and the file header on first use, ASM_OUTPUT_FLAGS bit 0). value 0 only closes
   the open segment. DEBUG_STATE is -1 during the switch and then holds the new
   segment's index. Returns the id selected (by SELECT_SEGMENT), or the previous id when
   value is 0. */
unsigned int far pascal EMIT_PROC_BEGIN(register unsigned int value)
{
    unsigned int old,outer;
    register unsigned int entry;
    if (!(ASM_OUTPUT_FLAGS&1)) EMIT_ASM_HEADER_FAR();
    if (SELECTED_SEGMENT_ID!=value) {
        DEBUG_STATE=-1;
        EMIT_SEGMENT_END();
        old=SELECTED_SEGMENT_ID;
        if (value==0) {
            SELECTED_SEGMENT_ID=0;
            return old;
        }
        value=SELECT_SEGMENT(value);
        entry=SELECTED_SEGDEF_ENTRY;
        outer=SEGDEF_W(entry,SEGDEF_PARENT_ID)&0x7FFF;
        if (outer) entry=FIND_SEGMENT(outer);
        PUT_FAR_STRING(SEGDEF_W(entry,SEGDEF_NAME),(unsigned)&STRING_POOL_SEG);
        PUT_CODE_STRING(TEXT(STR_SEGMENT));
        if (SEGDEF_B(entry,SEGDEF_ALIGN)==16) PUT_CODE_STRING(TEXT(STR_PARA));
        else if (SEGDEF_SC(entry,SEGDEF_ALIGN)>1) PUT_CODE_STRING(TEXT(STR_WORD));
        else PUT_CODE_STRING(TEXT(STR_BYTE+1));
        PUT_CODE_STRING(TEXT(STR_PUBLIC));
        if (FAR_B(STRING_POOL_SEG,SEGDEF_W(entry,SEGDEF_CLASS_NAME),STRPOOL_CHAR)) {
            PUT_CODE_CHAR('\'');
            PUT_FAR_STRING(SEGDEF_W(entry,SEGDEF_CLASS_NAME),(unsigned)&STRING_POOL_SEG);
            PUT_CODE_CHAR('\'');
        }
        PUT_CODE_STRING(TEXT(STR_CRLF_3));
        DEBUG_STATE=SEGDEF_W(entry,SEGDEF_INDEX);
        if (outer) {
            PUT_FAR_STRING(SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_NAME),(unsigned)&STRING_POOL_SEG);
            PUT_CODE_STRING(TEXT(STR_SEGMENT_VIRTUAL));
        }
    }
    return value;
}
#undef TEXT

/* ---- RESERVE_DATA_BYTES (listing ovr_1de3_b3c8:3DAD) ---- */
void far pascal EMIT_DECIMAL(register unsigned int value);
static void far pascal RESERVE_DATA_BYTES(unsigned int amount);
extern void far cdecl REPORT_FATAL(unsigned int,unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
#define TEXT(n) ((char near *)(n))
/* Writes "\tdb\t<amount> dup (0)" (or "dup (?)" if the segment has no initialized data
   yet) and grows the segment. More than 64 KB in a segment is fatal. */
static void far pascal RESERVE_DATA_BYTES(unsigned int amount)
{
    register unsigned int record=SELECTED_SEGDEF_ENTRY;
    long total;
    total=SEGDEF_L(record,SEGDEF_SIZE)+amount;
    if(total>0x10000L) REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA,SEGDEF_W(record,SEGDEF_NAME));
    SEGDEF_L(record,SEGDEF_SIZE)=total;
    PUT_CODE_STRING(TEXT(STR_DB_2));
    EMIT_DECIMAL(amount);
    PUT_CODE_STRING(SEGDEF_W(record,SEGDEF_FIRST_BLOCK)!=0 ? TEXT(STR_DUP_0) : TEXT(STR_DUP));
}
#undef TEXT

/* ---- ALIGN_ASM_DATA_EVEN (listing ovr_1de3_b3c8:3E39) ---- */
void far pascal ALIGN_ASM_DATA_EVEN(int value);

/* For an alignment of 2 or more, adds one byte when the segment size is odd. */
void far pascal ALIGN_ASM_DATA_EVEN(int value)
{
    if (value >= 2) {
        if ((*(unsigned long far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE) & 1UL) != 0)
            RESERVE_DATA_BYTES(1);
    }
}

/* ---- EMIT_DB_DATA (listing ovr_1de3_b3c8:3E62) ---- */
void far pascal EMIT_DB_DATA(unsigned char value);
void far pascal EMIT_SIGNED_DECIMAL(int value);

/* Writes "\tdb\t<value>" for one data byte and marks the segment as holding data. */
void far pascal EMIT_DB_DATA(unsigned char value)
{
    register unsigned int node = SELECTED_SEGDEF_ENTRY;
    if (*((long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) >= 0x10000L) {
            REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA, *((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_NAME)));
    }
    *((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) += 1;
    *((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_FIRST_BLOCK)) = 1;
    PUT_CODE_STRING((char near *)(STR_DB_2));
    EMIT_SIGNED_DECIMAL((unsigned int)value);
    PUT_CODE_STRING((char near *)(STR_CRLF_3));
}

/* ---- EMIT_PROC_OR_LABEL (listing ovr_1de3_b3c8:3ECA) ---- */
void far pascal EMIT_PROC_OR_LABEL(unsigned int value);
extern unsigned int CODE_SEGMENT_ID;
extern char far *ASM_TYPE_NAME_TABLE[];
extern unsigned int (far pascal *GET_SYMBOL_KIND_HOOK)(unsigned int);
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_HOOK)(unsigned int);
extern unsigned int (far pascal *FLAG_HOOK)(unsigned int);
extern void (far pascal *NAME_HOOK)(unsigned int);
extern void far pascal SET_SYMBOL_AT_CURRENT_POS(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_FAR_STRING(unsigned int,unsigned int);
#define TEXT(n) ((char near *)(n))
/* Places symbol value at the current position and, for kinds 1 and 3 (public or
   defined here), writes its label: a function (element kind 18) gets
   "\tassume\tcs:<group or code segment>" and "name\tproc\tfar" or "near" (FLAG_HOOK bit 0
   = far); data gets "name\tlabel\t<type>". It writes no extrn line. */
void far pascal EMIT_PROC_OR_LABEL(unsigned int value)
{
    _DI=value;
    SET_SYMBOL_AT_CURRENT_POS(_DI);
    if (GET_SYMBOL_KIND_HOOK(_DI)==1 || GET_SYMBOL_KIND_HOOK(_DI)==3) {
        if (SYMBOL_ELEMENT_KIND_HOOK(_DI)==18) {
            PUT_CODE_STRING(TEXT(STR_ASSUME_CS));
            _SI=FIND_SEGMENT(CODE_SEGMENT_ID);
            _ES=SEGDEF_POOL_SEG;
            if ((int)ES_W(_SI,SEGDEF_PARENT_ID)>0) _SI=FIND_SEGMENT(ES_W(_SI,SEGDEF_PARENT_ID));
            _ES=SEGDEF_POOL_SEG;
            if (ES_W(_SI,SEGDEF_GROUP)) {
                _BX=ES_W(_SI,SEGDEF_GROUP);
                _AX=ES_W(_BX,SEGGRP_NAME);
            } else {
                _ES=SEGDEF_POOL_SEG;
                _AX=ES_W(_SI,SEGDEF_NAME);
            }
            PUT_FAR_STRING(_AX,(unsigned)&STRING_POOL_SEG);
            PUT_CODE_STRING(TEXT(STR_CRLF_3));
            NAME_HOOK(_DI);
            PUT_CODE_STRING(TEXT(STR_PROC));
            if (FLAG_HOOK(TYPE_HOOK(_DI))&1) PUT_CODE_STRING(TEXT(STR_FAR_2));
            else { PUT_CODE_STRING(TEXT(STR_NEAR_2)); _SI=_SI; }
        } else {
            NAME_HOOK(_DI);
            PUT_CODE_STRING(TEXT(STR_LABEL));
            PUT_CODE_STRING(ASM_TYPE_NAME_TABLE[SYMBOL_ELEMENT_KIND_HOOK(_DI)]);
        }
        PUT_CODE_STRING(TEXT(STR_CRLF_3));
    }
}
#undef TEXT

/* ---- EMIT_PROC_ENDP (listing ovr_1de3_b3c8:3FC1) ---- */
void far pascal EMIT_PROC_ENDP(void);

/* Writes "name endp" for the function being generated (CODEGEN_FUNCTION_SYMBOL). */
void far pascal EMIT_PROC_ENDP(void)
{
    NAME_HOOK(CODEGEN_FUNCTION_SYMBOL);
    PUT_CODE_STRING(&STR_ENDP);
}

/* ---- EMIT_DW_ADDRESS (listing ovr_1de3_b3c8:3FD8) ---- */
static void far pascal EMIT_DW_ADDRESS(register unsigned int name,register unsigned int value);
extern void (far pascal *NAME_HOOK)(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal EMIT_GROUP_PREFIX(unsigned int);
/* Writes "\tdw\t[group:]name[+value]", a near address, and grows the segment by 2. */
static void far pascal EMIT_DW_ADDRESS(register unsigned int name,register unsigned int value)
{
    SEGDEF_L(SELECTED_SEGDEF_ENTRY,SEGDEF_SIZE)+=2;
    if(SEGDEF_L(SELECTED_SEGDEF_ENTRY,SEGDEF_SIZE)>0x10000L)
        REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA,SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_NAME));
    SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_FIRST_BLOCK)=1;
    PUT_CODE_STRING((char near *)(STR_DW_2));
    EMIT_GROUP_PREFIX(name);
    NAME_HOOK(name);
    if(value) {
        PUT_CODE_CHAR('+');
        EMIT_DECIMAL(value);
    }
    PUT_CODE_STRING((char near *)(STR_CRLF_3));
}

/* ---- EMIT_DD_ADDRESS (listing ovr_1de3_b3c8:4063) ---- */
static void far pascal EMIT_DD_ADDRESS(register unsigned int name,register unsigned int value);
extern void (far pascal *NAME_HOOK)(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal EMIT_GROUP_PREFIX(unsigned int);
/* Writes "\tdd\t[group:]name[+value]", a far address, and grows the segment by 4. */
static void far pascal EMIT_DD_ADDRESS(register unsigned int name,register unsigned int value)
{
    SEGDEF_L(SELECTED_SEGDEF_ENTRY,SEGDEF_SIZE)+=4;
    if(SEGDEF_L(SELECTED_SEGDEF_ENTRY,SEGDEF_SIZE)>0x10000L)
        REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA,SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_NAME));
    SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_FIRST_BLOCK)=1;
    PUT_CODE_STRING((char near *)(STR_DD));
    EMIT_GROUP_PREFIX(name);
    NAME_HOOK(name);
    if(value) {
        PUT_CODE_CHAR('+');
        EMIT_DECIMAL(value);
    }
    PUT_CODE_STRING((char near *)(STR_CRLF_3));
}

/* ---- EMIT_LOCAL_LABEL (listing ovr_1de3_b3c8:40EE) ---- */
void far pascal EMIT_LOCAL_LABEL(unsigned int value);

/* Writes the definition of local jump label value of the current function:
   "@<FUNCTION_SERIAL>@C<value>\tlabel\tword". */
void far pascal EMIT_LOCAL_LABEL(unsigned int value)
{
    PUT_CODE_CHAR(0x40);
    EMIT_DECIMAL(FUNCTION_SERIAL);
    PUT_CODE_STRING((char near *)(STR_C_5));
    EMIT_DECIMAL(value);
    PUT_CODE_STRING((char near *)(STR_LABEL_WORD));
}

/* ---- ADD_JUMP_18_NEXT_FRAGMENT (listing ovr_1de3_b3c8:4123) ---- */
void far pascal ADD_JUMP_18_NEXT_FRAGMENT(unsigned int value);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal ADD_JUMP(unsigned int first, unsigned int second,
                               unsigned int third);
extern void far pascal START_NEXT_FRAGMENT(void);

/* Adds a jump (code-op 18h) to flow block value, passing the block's flag 0x100 (word
   14 of the block), and starts a new code fragment. */
void far pascal ADD_JUMP_18_NEXT_FRAGMENT(unsigned int value)
{
    register unsigned int node = value;

    ADD_JUMP(0x18, node,
            ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[14] & 0x100);
    START_NEXT_FRAGMENT();
}

/* ---- EMIT_ASM_LINE_MARK (listing ovr_1de3_b3c8:414A) ---- */
void far pascal EMIT_ASM_LINE_MARK(unsigned int node,register unsigned int value);
extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned int far pascal FIND_NODE_BY_SERIAL(unsigned int);
extern void far pascal OBJ_WRITE_FILE_ENTRY(unsigned int);
extern void far pascal PUT_CODE_CHAR(unsigned int);
/* Marks source line value of file record node (a SRCSEGS.C serial) in the code text: a
   7-byte marker FFh, 01h, the line as four letters 'a'..'p' (one per hex digit) and '1'
   if node is the function's own file (FUNCTION_SOURCE_FILE), else '0'. Code text is
   buffered by PUT_CODE_CHAR, so the marker is probably turned into a line directive when
   the buffer is written. With -v a file-name record is written first when the file
   changes (OBJ_WRITE_FILE_ENTRY). */
void far pascal EMIT_ASM_LINE_MARK(unsigned int node,register unsigned int value)
{
    register unsigned int found;
    found=FIND_NODE_BY_SERIAL(node);
    if (found) {
        if (OPTION_SOURCE_DEBUG && LINE_MARK_LAST_FILE!=found) {
            OBJ_WRITE_FILE_ENTRY(found);
            LINE_MARK_LAST_FILE=found;
        }
        PUT_CODE_CHAR(0xFF);
        PUT_CODE_CHAR(1);
        PUT_CODE_CHAR(((value>>12)&15)+'a');
        PUT_CODE_CHAR(((value>>8)&15)+'a');
        PUT_CODE_CHAR(((value>>4)&15)+'a');
        PUT_CODE_CHAR((value&15)+'a');
        PUT_CODE_CHAR((node==FUNCTION_SOURCE_FILE)+'0');
    }
}

/* ---- STAOV200 (listing ovr_1de3_b3c8:41EF) ---- */
extern void far pascal PUT_CODE_STRING(char far *);


/* Closes the open segment: "name ends", and "parent ends" for a virtual segment. It
   ends a segment, not a procedure. */
static void near pascal EMIT_SEGMENT_END(void)
{
    register unsigned int selected;
    if (SELECTED_SEGDEF_ENTRY != 0) {
        PUT_FAR_STRING(SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_NAME), (unsigned)&STRING_POOL_SEG);
        PUT_CODE_STRING((char far *)STR_ENDS);
        if (SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_PARENT_ID) != 0) {
            selected = FIND_SEGMENT(SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_PARENT_ID) & 0x7FFF);
            PUT_FAR_STRING(SEGDEF_W(selected, SEGDEF_NAME), (unsigned)&STRING_POOL_SEG);
            PUT_CODE_STRING((char far *)STR_ENDS);
        }
        SELECTED_SEGDEF_ENTRY = 0;
        DEBUG_STATE = 0;
    }
}

/* ---- EMIT_SIGNED_DECIMAL (listing ovr_1de3_b3c8:4263) ---- */
/* Writes value in decimal with a '-' when negative. */
void far pascal EMIT_SIGNED_DECIMAL(int value)
{
    if (value < 0) {
        PUT_CODE_CHAR(0x2D);
        value = -value;
    }
    EMIT_DECIMAL(value);
}

/* ---- EMIT_DECIMAL (listing ovr_1de3_b3c8:4288) ---- */
/* Writes value in decimal (recursive, most significant digit first). */
void far pascal EMIT_DECIMAL(register unsigned int value)
{
    if (value / 10)
        EMIT_DECIMAL(value / 10);
    PUT_CODE_CHAR(value % 10 + 0x30);
}

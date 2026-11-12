/* target: ovr179_C107UNIT */
/* Role: assembly text output (-S): instruction and operand text. Entry points:
   EMIT_HEX_BYTE, EMIT_DEBUG_B_DIRECTIVE, EMIT_DEBUG_E_DIRECTIVE, DEFINE_LABEL_ASM,
   ADD_JUMP_ASM, EMIT_THIS_ADJUST_THUNK_ASM, EMIT_ASM_TRAILER, EMIT_SWITCH_JUMP_ASM (+8
   more). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO076 (ovr_1dda_b2c2) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the core of BCC's assembly-text output, used when COMPILER_MODE is set (-S,
   or -B where TASM assembles the result). The back end calls everything through a table
   of output hooks: for assembly output CREATE_ASM_OUTPUT copies ASM_TEXT_DEFAULT_HOOKS
   (96 bytes of far function pointers) over the live table that starts at
   EMIT_DEPENDENCY_HOOK (BEGIN_SESSION in INITPOOL.C installs the default table, probably
   the object-file one). So most functions here have an object-file twin with the same
   job.
   What is written, in file order:
   - CREATE_ASM_OUTPUT: creates <name>.asm, writes .286/.287 or .286p for the CPU and
     float options and the header (a dummy ?debug macro for assemblers other than TASM,
     then ?debug S "file"); EMIT_DEPENDENCY_RECORD adds a ?debug C E9 line (file time
     and name) per source file unless auto-dependencies are off.
   - EMIT_ASM_HEADER (on first output): group directives, "assume cs:..,ds:..", and the
     d@/d@w and b@/b@w base labels of the data and BSS segments.
   - per instruction: EMIT_ASM_INSTRUCTION writes one line from the opcode number and the
     two operands FIRST_ASM_OPERAND / SECOND_ASM_OPERAND, and adds the instruction's
     length (INSTRUCTION_SIZE) to the segment size, since the assembly path must know
     offsets without assembling.
   - EMIT_ASM_TRAILER (end): the string-literal block "s@ label byte" with every literal
     byte as db lines (printable runs quoted, up to 61 characters), extrn DGROUP@ and
     __turboFloat when needed, then "end".
   Strings are addressed by DS offset; 0x7846 handed to PUT_FAR_STRING is probably the
   address of the string-pool segment word. Statements such as _AX=_AX, _SI=_SI and
   printed=printed do nothing; they are kept so the code compiles to the original bytes.
   Opcode numbers index OPCODE_DESCRIPTOR_TABLE (19-byte entries: mnemonic, length
   class, flags; flag 2 marks x87 instructions). */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STAOV16F (listing ovr_1dda_b2c2:2C20) ---- */
extern void far pascal PUT_CODE_CHAR(unsigned int value);

/* Writes value's low byte as two upper-case hex digits. */
void far pascal EMIT_HEX_BYTE(unsigned int value)
{
    register int digit;

    digit = (value >> 4) & 0x0F;
    PUT_CODE_CHAR(digit < 10 ? digit + 0x30 : digit + 0x37);
    digit = value & 0x0F;
    PUT_CODE_CHAR(digit < 10 ? digit + 0x30 : digit + 0x37);
}

/* ---- STAOV170 (listing ovr_1dda_b2c2:2C6A) ---- */
extern void far pascal PUT_CODE_STRING(char far *text);

/* Writes the STR_DEBUG_B text, probably the "?debug B" line that opens a block's debug
   scope. */
void far pascal EMIT_DEBUG_B_DIRECTIVE(void)
{
    PUT_CODE_STRING(&STR_DEBUG_B);
}

/* ---- EMIT_DEBUG_E_DIRECTIVE (listing ovr_1dda_b2c2:2C79) ---- */
void far pascal EMIT_DEBUG_E_DIRECTIVE(unsigned int value);
extern void far pascal INSERT_NODE_MARK_FRAGMENT(unsigned int value);
extern void far pascal PUT_CODE_STRING(char far *text);

/* Marks code node value in the fragment list, then writes STR_DEBUG_E, probably the
   matching "?debug E" line. */
void far pascal EMIT_DEBUG_E_DIRECTIVE(unsigned int value)
{
    INSERT_NODE_MARK_FRAGMENT(value);
    PUT_CODE_STRING(&STR_DEBUG_E);
}

/* ---- STAOV172 (listing ovr_1dda_b2c2:2C92) ---- */
extern void far pascal DEFINE_LABEL(unsigned int value);

/* Assembly-output hook entries that just pass on to the common code: DEFINE_LABEL and,
   below, ADD_JUMP. */
void far pascal DEFINE_LABEL_ASM(unsigned int value)
{
    DEFINE_LABEL(value);
}

/* ---- ADD_JUMP_ASM (listing ovr_1dda_b2c2:2CA1) ---- */
void far pascal ADD_JUMP_ASM( unsigned int first, unsigned int second, unsigned int third);
extern void far pascal ADD_JUMP(
    unsigned int first, unsigned int second, unsigned int third);

void far pascal ADD_JUMP_ASM(
    unsigned int first, unsigned int second, unsigned int third)
{
    ADD_JUMP(first, second, third);
}

/* ---- EMIT_THIS_ADJUST_THUNK_ASM (listing ovr_1dda_b2c2:2CB6) ---- */
void far pascal EMIT_THIS_ADJUST_THUNK_ASM(unsigned int first, unsigned int second, unsigned int third, unsigned int fourth);
extern void (far pascal *NAME_HOOK)(unsigned int value);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal EMIT_DECIMAL(unsigned int value);

/* Writes a C++ thunk that adjusts "this" on the stack and jumps to the real function:
     mov bx,sp / add ss:[bx+<fourth + 4 or 2>],<second> / jmp far|near ptr <first>
   third set means a far function (the return address is 4 bytes, the jump far);
   second is the adjustment, fourth the offset of this among the arguments. */
void far pascal EMIT_THIS_ADJUST_THUNK_ASM(unsigned int first, unsigned int second,
                         unsigned int third, unsigned int fourth)
{
    PUT_CODE_STRING((char near *)(STR_MOV_BX_SP));
    PUT_CODE_STRING((char near *)(STR_ADD_SS_BX));
    EMIT_DECIMAL(fourth + (third ? 4 : 2));
    PUT_CODE_STRING((char near *)(STR_RBRACKET_COMMA));
    EMIT_DECIMAL(second);
    PUT_CODE_STRING(third ? (char near *)(STR_JMP_FAR_PTR) : (char near *)(STR_JMP_NEAR_PTR));
    NAME_HOOK(first);
    PUT_CODE_STRING((char near *)&STR_DB_LINE_CRLF);
}

/* ---- CREATE_ASM_OUTPUT (listing ovr_1dda_b2c2:2D23) ---- */
static void far pascal CREATE_ASM_OUTPUT(char far *filename);
extern unsigned char OPTION_TARGET_CPU;
extern unsigned int STRING_POOL_SEG;
struct HookTable { unsigned char bytes[96]; };
extern struct HookTable EMIT_DEPENDENCY_HOOK,ASM_TEXT_DEFAULT_HOOKS;
extern char far *far pascal STRING_COPY(char far *,char far *);
extern void far pascal STRING_APPEND(char far *,char far *);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern int far pascal CREATE_OUTPUT_FILE(char far *);
extern void far cdecl REPORT_FATAL(unsigned int,char far *);
extern void far pascal PUT_CODE_STRING(char far *);
#define TEXT(n) ((char near *)(n))
/* Installs the assembly hook table and opens the .asm file. ASM_OUTPUT_PATH gets ".asm"
   added unless CODE_OUTPUT_FLAGS bit 0 is set (probably when -o gave a full name). A file
   that cannot be created is fatal. filename is the source name written into the header. */
static void far pascal CREATE_ASM_OUTPUT(char far *filename)
{
    char path[80];
    STRING_COPY(path,(char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH));
    /* Install the original 96-byte default table of output callbacks. */
    EMIT_DEPENDENCY_HOOK=ASM_TEXT_DEFAULT_HOOKS;
    if(!(CODE_OUTPUT_FLAGS&1)) {
        STRING_APPEND(path,TEXT(STR_ASM_2));
        ASM_OUTPUT_PATH=POOL_ALLOC(&STRING_POOL_SEG,STRING_LENGTH(path)+1);
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH),path);
    }
    if(CREATE_OUTPUT_FILE(path)==-1) REPORT_FATAL(MSG_UNABLE_CREATE_OUTPUT,path);
    if(OPTION_TARGET_CPU==1) {
        PUT_CODE_STRING(TEXT(STR_286));
        if(OPTION_FLOAT_MODE==2) {PUT_CODE_STRING(TEXT(STR_287));_AX=_AX;}
    } else if(OPTION_TARGET_CPU==2) {
        PUT_CODE_STRING(TEXT(STR_286P));
        if(OPTION_FLOAT_MODE==2) PUT_CODE_STRING(TEXT(STR_287));
    }
    PUT_CODE_STRING(TEXT(STR_IFNDEF_VERSION_DEBUG_MACRO_E));
    PUT_CODE_STRING(filename);
    PUT_CODE_STRING(TEXT(STR_QUOTE_CR_NL));
}
#undef TEXT

/* ---- STAOV176 (listing ovr_1dda_b2c2:2E1A) ---- */
extern unsigned int SEGMENT_LIST_HEAD;
extern void far pascal PUT_CODE_CHAR(unsigned int value);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal PUT_FAR_STRING(unsigned int position, unsigned int segment);

/* Writes "NAME\tgroup\tseg1,seg2,..." for group record value, listing every segment
   whose SEGDEF_GROUP is that group. For group records SEGDEF_INDEX (offset 4) holds the
   group name (SEGGRP_NAME). */
static void near pascal EMIT_GROUP_DEFINITION(unsigned int value)
{
    register unsigned int node;
    register unsigned int emitted;
    emitted = 0;
    node = SEGMENT_LIST_HEAD;
    PUT_FAR_STRING(*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, value + SEGDEF_INDEX), (unsigned)&STRING_POOL_SEG);
    PUT_CODE_STRING((char near *)(STR_GROUP));
    while (node != 0) {
        if (*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_GROUP) == value) {
            if (emitted != 0)
                PUT_CODE_CHAR(0x2C);
            PUT_FAR_STRING(*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_NAME), (unsigned)&STRING_POOL_SEG);
            emitted = 1;
        }
        node = *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node);
    }
    PUT_CODE_STRING((char near *)&STR_DB_LINE_CRLF);
}

/* ---- EMIT_ASM_HEADER (listing ovr_1dda_b2c2:2E90) ---- */
static void far pascal EMIT_ASM_HEADER(void);
extern unsigned int CODE_SEGMENT_ID;
extern unsigned int far pascal EMIT_PROC_BEGIN(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern void far pascal PUT_FAR_STRING(unsigned int,unsigned int);
/* The first part of the file body (ASM_OUTPUT_FLAGS bit 0 marks it done): opens and
   closes the code segment once, writes the groups (clearing each group record's own
   group word first), the assume line, and the d@/b@ labels at the start of the data and
   BSS segments; resets LINE_MARK_LAST_FILE. */
static void far pascal EMIT_ASM_HEADER(void)
{
    register unsigned int item;
    register unsigned int node;
    ASM_OUTPUT_FLAGS|=1;
    EMIT_PROC_BEGIN(CODE_SEGMENT_ID);
    EMIT_PROC_BEGIN(0);
    for(item=GROUP_LIST_HEAD;item!=0;item=SEGDEF_W(item,SEGDEF_NEXT)) {
        SEGDEF_W(item,SEGDEF_GROUP)=0;
        EMIT_GROUP_DEFINITION(item);
    }
    PUT_CODE_STRING((char near *)(STR_ASSUME_CS_2));
    node=FIND_SEGMENT(CODE_SEGMENT_ID);
    PUT_FAR_STRING(SEGDEF_W(node,SEGDEF_GROUP)!=0 ? SEGDEF_W(SEGDEF_W(node,SEGDEF_GROUP),SEGDEF_INDEX) : SEGDEF_W(node,SEGDEF_NAME),(unsigned)&STRING_POOL_SEG);
    PUT_CODE_STRING((char near *)(STR_DS));
    node=FIND_SEGMENT(DATA_SEGMENT_ID);
    PUT_FAR_STRING(SEGDEF_W(node,SEGDEF_GROUP)!=0 ? SEGDEF_W(SEGDEF_W(node,SEGDEF_GROUP),SEGDEF_INDEX) : SEGDEF_W(node,SEGDEF_NAME),(unsigned)&STRING_POOL_SEG);
    PUT_CODE_STRING((char near *)&STR_DB_LINE_CRLF);
    EMIT_PROC_BEGIN(DATA_SEGMENT_ID);
    PUT_CODE_STRING((char near *)(STR_D_LABEL_BYTE_D_W_LABEL_WORD));
    EMIT_PROC_BEGIN(BSS_SEGMENT_ID);
    PUT_CODE_STRING((char near *)(STR_B_LABEL_BYTE_B_W_LABEL_WORD));
    LINE_MARK_LAST_FILE=0;
}

/* ---- EMIT_ASM_TRAILER (listing ovr_1dda_b2c2:2F7D) ---- */
void far pascal EMIT_ASM_TRAILER(void);
extern unsigned int DATA_BYTE_POOL_SEG; extern unsigned int CODE_SEGMENT_ID;
extern void (far pascal *ASM_TRAILER_HOOK)(void);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal EMIT_SIGNED_DECIMAL(unsigned int);
extern unsigned int far pascal EMIT_PROC_BEGIN(unsigned int);
#define C(n) (*((signed char far *)MK_FP(DATA_BYTE_POOL_SEG,offset+(n))))
#define TEXT(n) ((char near *)(n))
/* End of the file: "?debug C E9" (end of dependency list), groups that belong to another
   group, the literal block (DATA_BYTE_POOL_SEG, DATA_BYTE_POOL_LENGTH bytes) under
   "s@ label byte", "extrn DGROUP@:word" if a DS load needed it (ASM_OUTPUT_FLAGS bit 1),
   "extrn __turboFloat:word" if floating point was used, ASM_TRAILER_HOOK, and
   "\tend" followed by ^Z. */
void far pascal EMIT_ASM_TRAILER(void)
{
    unsigned int current;
    int count;
    register unsigned int offset,index;
    PUT_CODE_STRING(TEXT(STR_DEBUG_C_E9));
    for(current=GROUP_LIST_HEAD;current;current=SEGDEF_W(current,SEGDEF_NEXT)) {
        if(SEGDEF_W(current,SEGDEF_GROUP)) EMIT_GROUP_DEFINITION(current);
    }
    EMIT_PROC_BEGIN(DATA_SEGMENT_ID);
    PUT_CODE_STRING(TEXT(STR_S_LABEL_BYTE));
    offset=0;
    index=0;
    while(index<DATA_BYTE_POOL_LENGTH) {
        PUT_CODE_STRING(TEXT(&STR_DB));
            /* A printable byte starts a quoted run; it ends at a non-printable byte, a
               quote, the end, or after 60 more characters. Other bytes are written as
               signed decimal numbers. */
        if(C(0)>=0x20 && C(0)<=0x7E && C(0)!='\'') {
            PUT_CODE_CHAR('\'');
            PUT_CODE_CHAR((int)C(0));
            for(count=0;count<60;++count) {
                if(index+1==DATA_BYTE_POOL_LENGTH) break;
                if(C(1)<0x20 || C(1)>0x7E || C(1)=='\'') break;
                ++offset;
                ++index;
                PUT_CODE_CHAR((int)C(0));
            }
            PUT_CODE_CHAR('\'');
        } else {
            EMIT_SIGNED_DECIMAL((int)C(0));
        }
        PUT_CODE_STRING(TEXT(&STR_DB_LINE_CRLF));
        ++offset;
        ++index;
    }
    EMIT_PROC_BEGIN(CODE_SEGMENT_ID);
    if(ASM_OUTPUT_FLAGS&2) PUT_CODE_STRING(TEXT(STR_EXTRN_DGROUP_WORD));
    EMIT_PROC_BEGIN(0);
    if(CODE_OUTPUT_FLAGS&2) PUT_CODE_STRING(TEXT(STR_EXTRN_TURBOFLOAT_WORD));
    ASM_TRAILER_HOOK();
    PUT_CODE_STRING(TEXT(STR_END_CRLF_EOF));
}
#undef C
#undef TEXT

/* ---- EMIT_SWITCH_JUMP_ASM (listing ovr_1dda_b2c2:30C5) ---- */
void far pascal EMIT_SWITCH_JUMP_ASM(unsigned int value);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal EMIT_DECIMAL(unsigned int value);

/* Switch dispatch through a jump table: "\tjmp\tword ptr cs:@<serial>@C<value>[bx]"; the
   segment size grows by 5 (the instruction's length). */
void far pascal EMIT_SWITCH_JUMP_ASM(unsigned int value)
{
    PUT_CODE_STRING((char near *)(STR_JMP_WORD_PTR_CS));
    EMIT_DECIMAL(FUNCTION_SERIAL);
    PUT_CODE_STRING((char near *)(STR_C_6));
    EMIT_DECIMAL(value);
    PUT_CODE_STRING((char near *)(STR_BX));
    *(unsigned long far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE) += 5;
}

/* ---- EMIT_SWITCH_TABLE_LOAD_ASM (listing ovr_1dda_b2c2:310D) ---- */
void far pascal EMIT_SWITCH_TABLE_LOAD_ASM(unsigned int value);
extern void far pascal PUT_CODE_CHAR(unsigned int value);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal EMIT_DECIMAL(unsigned int value);

/* "\tmov\tbx,offset @<serial>@C<value>": loads the address of a switch table. */
void far pascal EMIT_SWITCH_TABLE_LOAD_ASM(unsigned int value)
{
    PUT_CODE_STRING((char near *)(STR_MOV_BX_OFFSET));
    PUT_CODE_CHAR(0x40);
    EMIT_DECIMAL(FUNCTION_SERIAL);
    PUT_CODE_STRING((char near *)(STR_C_6));
    EMIT_DECIMAL(value);
    PUT_CODE_STRING((char near *)&STR_DB_LINE_CRLF);
}

/* ---- EMIT_LOAD_DATA_SEGMENT_ASM (listing ovr_1dda_b2c2:314C) ---- */
void far pascal EMIT_LOAD_DATA_SEGMENT_ASM(unsigned char value);
extern unsigned char OPTION_MEMORY_MODEL;
extern void far pascal PUT_CODE_STRING(char far *);
extern char far * far pascal REGISTER_NAME(unsigned char,unsigned char);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern void far pascal PUT_FAR_STRING(unsigned int,unsigned int);
#define TEXT(n) ((char near *)(n))
/* Loads DS's value into register value: tiny model "mov reg,cs:DGROUP@" (and notes that
   DGROUP@ must be declared extrn), else "mov reg,<data group or segment>". */
void far pascal EMIT_LOAD_DATA_SEGMENT_ASM(unsigned char value)
{
    register unsigned int entry;
    if (OPTION_MEMORY_MODEL==0) {
        PUT_CODE_STRING(TEXT(STR_MOV));
        PUT_CODE_STRING(REGISTER_NAME(value,6));
        PUT_CODE_STRING(TEXT(STR_CS_DGROUP));
        ASM_OUTPUT_FLAGS|=2;
    } else {
        PUT_CODE_STRING(TEXT(STR_MOV));
        PUT_CODE_STRING(REGISTER_NAME(value,6));
        PUT_CODE_STRING(TEXT(STR_RBRACKET_COMMA+1));
        entry=FIND_SEGMENT(DATA_SEGMENT_ID);
        if (SEGDEF_W(entry,SEGDEF_GROUP))
            PUT_FAR_STRING(SEGDEF_W(SEGDEF_W(entry,SEGDEF_GROUP),SEGDEF_INDEX),(unsigned)&STRING_POOL_SEG);
        else
            PUT_FAR_STRING(SEGDEF_W(entry,SEGDEF_NAME),(unsigned)&STRING_POOL_SEG);
        PUT_CODE_STRING(TEXT(&STR_DB_LINE_CRLF));
    }
}
#undef TEXT

/* ---- EMIT_CS_JMP_BX_DISP_ASM (listing ovr_1dda_b2c2:31ED) ---- */
void far pascal EMIT_CS_JMP_BX_DISP_ASM(unsigned int value);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal EMIT_DECIMAL(unsigned int value);

/* "\tjmp\tword ptr cs:[bx+<value>]", 5 bytes. */
void far pascal EMIT_CS_JMP_BX_DISP_ASM(unsigned int value)
{
    PUT_CODE_STRING((char near *)(STR_JMP_WORD_PTR_CS_BX));
    EMIT_DECIMAL(value);
    PUT_CODE_STRING((char near *)(STR_BX+3));
    *(unsigned long far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE) += 5;
}

/* ---- EMIT_PUSH_RETURN_ADDRESS_ASM (listing ovr_1dda_b2c2:3222) ---- */
void far pascal EMIT_PUSH_RETURN_ADDRESS_ASM(void);
extern unsigned char OPTION_TARGET_CPU;
extern void far pascal PUT_CODE_STRING(char far *text);

/* Pushes a return address that points past the next instruction: on an 8086 through CX
   (STR_MOV_CX_OFFSET_7_PUSH), from the 186 on with push immediate (STR_PUSH_OFFSET_6),
   as the string names say. */
void far pascal EMIT_PUSH_RETURN_ADDRESS_ASM(void)
{
    if (OPTION_TARGET_CPU == 0)
        PUT_CODE_STRING(&STR_MOV_CX_OFFSET_7_PUSH);
    else
        PUT_CODE_STRING(&STR_PUSH_OFFSET_6);
}

/* ---- EMIT_DEPENDENCY_RECORD (listing ovr_1dda_b2c2:323E) ---- */
static void far pascal EMIT_DEPENDENCY_RECORD(char far *text);
extern unsigned int DEBUG_STATE;
extern unsigned int far pascal STRING_LENGTH(char far *);
extern long far pascal FILE_TIME(char far *);
extern void far pascal PUT_CODE_STRING(char far *);
/* Writes "\t?debug\tC E9" + the file time of source file text (4 bytes) + name length +
   the name, in hex, continued every 21 bytes; the same bytes a COMENT class E9h
   dependency record holds in an object file. Not written with OPTION_NO_AUTODEPEND.
   DEBUG_STATE is -1 while writing. */
static void far pascal EMIT_DEPENDENCY_RECORD(char far *text)
{
    long timestamp;
    unsigned int saved;
    char far *cursor;
    unsigned int length;
    register int count;
    if(OPTION_NO_AUTODEPEND!=0) return;
    length=STRING_LENGTH(text);
    saved=DEBUG_STATE;
    DEBUG_STATE=-1;
    PUT_CODE_STRING((char near *)(STR_DEBUG_C_3));
    EMIT_HEX_BYTE(0xE9);
    timestamp=FILE_TIME(text);
    EMIT_HEX_BYTE(((char near *)&timestamp)[0]);
    EMIT_HEX_BYTE(((char near *)&timestamp)[1]);
    EMIT_HEX_BYTE(((char near *)&timestamp)[2]);
    EMIT_HEX_BYTE(((char near *)&timestamp)[3]);
    EMIT_HEX_BYTE(length);
    cursor=text;
    for(;;) {
        count=0;
        do {
            EMIT_HEX_BYTE(*cursor);
            cursor++;
            if(*cursor==0) goto done;
            count++;
        } while(count<=20);
        PUT_CODE_STRING((char near *)(STR_DEBUG_C_4));
    }
done:
    PUT_CODE_STRING((char near *)&STR_DB_LINE_CRLF);
    DEBUG_STATE=saved;
}

/* ---- INSTRUCTION_SIZE (listing ovr_1dda_b2c2:3306) ---- */
static int near pascal INSTRUCTION_SIZE(unsigned int kind);
struct Descriptor { char near *name; unsigned char pad; long flags; unsigned char tail[12]; };
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
struct Operand { unsigned int kind; signed char index,scale,reg; unsigned int offset,symbol; };
static int near pascal OPERAND_SIZE(register struct Operand near *operand,unsigned int type);
extern struct Operand FIRST_ASM_OPERAND,SECOND_ASM_OPERAND;
/* Returns the length in bytes of instruction kind with the current operands: the
   descriptor's base length plus the operand bytes (OPERAND_SIZE). Length class -1:
   1 extra byte for a register operand, else 2 (ModRM form); -2: 2 or 3 bytes for the
   short accumulator-immediate form, else operands + 2. Opcode 57h under the float
   emulator (OPTION_FLOAT_MODE 1) gets one byte more. */
static int near pascal INSTRUCTION_SIZE(unsigned int kind)
{
    register unsigned int count;
    int length;
    struct Descriptor near *entry;
    entry=&OPCODE_DESCRIPTOR_TABLE[kind];
    count=OPERAND_SIZE(&FIRST_ASM_OPERAND,kind)+OPERAND_SIZE(&SECOND_ASM_OPERAND,kind);
    if(kind==0x57 && OPTION_FLOAT_MODE==1) count++;
    length=(signed char)entry->pad;
    if(length==-1) {
        if(FIRST_ASM_OPERAND.kind==1) return count+1;
        return count+2;
    }
    if(length==-2) {
        if(SECOND_ASM_OPERAND.kind==4 && FIRST_ASM_OPERAND.kind==1 && FIRST_ASM_OPERAND.reg==0) {
            if(((unsigned char near *)entry)[7]==2) return 3;
            return 2;
        }
        return count+2;
    }
    return count+length;
}

/* ---- OPERAND_SIZE (listing ovr_1dda_b2c2:33A6) ---- */
/* Bytes an operand adds to instruction type: an immediate (kind 4) 1 or 2 bytes (1 when
   the instruction takes a byte, or a sign-extended byte fits); kinds 2 and 3 (offset or
   segment of a symbol) 2; a memory operand (kind 5) its displacement, 0, 1 or 2 bytes,
   plus 1 for a segment override (index set). Registers (kind 1) add nothing. */
static int near pascal OPERAND_SIZE(register struct Operand near *operand,unsigned int type)
{
    register int length;
    unsigned char near *entry;
    entry=CODE_OP_INFO_TABLE-3+type*19;
    switch(operand->kind) {
    case 4:
        if(entry[7]==0) return 1;
        if((*((unsigned long near *)(entry+3))&0x8000L)==0L) return 2;
        if((int)operand->offset>127 || (int)operand->offset< -128) return 2;
        return 1;
    case 2: case 3:
        return 2;
    case 5:
        length=0;
        if(operand->index!=-1) length++;
        if(operand->symbol!=0) length+=2;
        else if(operand->reg==-1 && operand->scale==-1) length+=2;
        else if((int)operand->offset< -128 || (int)operand->offset>127) length+=2;
        else if(operand->offset!=0) length++;
        return length;
    default:
        return 0;
    }
}

/* ---- EMIT_ASM_INSTRUCTION (listing ovr_1dda_b2c2:3458) ---- */
void far pascal EMIT_ASM_INSTRUCTION(int opcode);
static int near pascal INSN_OPERAND_FORMAT(int index);
static void near pascal EMIT_ASM_OPERAND(register struct Operand near *operand,int type);
void far pascal EMIT_GROUP_PREFIX(unsigned int value);

extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
extern struct Operand FIRST_ASM_OPERAND,SECOND_ASM_OPERAND;
extern unsigned char OPTION_MEMORY_MODEL;
extern unsigned int (far pascal *GET_SYMBOL_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal EMIT_DECIMAL(unsigned int);
#define TEXT(n) ((char near *)(n))
#define FORMAT(n) EMIT_ASM_OPERAND(&FIRST_ASM_OPERAND,(n))
/* Writes one instruction line "\tmnemonic\toperands". _SI holds the opcode and _DI its
   descriptor throughout. Special cases before the normal form: opcode 78h (call) to a
   far function in the same code segment becomes "push cs / call"; A1h in a near
   function is written as "db 0cbh" (a far return); C8h..CAh are prefixes written with a
   space and no line end; x87 forms (descriptor flag 2) are "FCOMPP" or "nameP st(n),st(0)".
   Operands follow in the switch, by opcode. */
void far pascal EMIT_ASM_INSTRUCTION(int opcode)
{
    int format;
    unsigned int symbol;
    _SI=opcode;
    *((long far *)MK_FP(SEGDEF_POOL_SEG,SELECTED_SEGDEF_ENTRY+SEGDEF_SIZE))+=(int)INSTRUCTION_SIZE(_SI);
    _DI=(unsigned int)&OPCODE_DESCRIPTOR_TABLE[_SI];
    PUT_CODE_CHAR(9);
    if (_SI==0x78) {
        symbol=FIRST_ASM_OPERAND.symbol;
        if (OPTION_MEMORY_MODEL) {
            if (symbol==0) goto normal;
            if (GET_SYMBOL_KIND_HOOK(symbol)==2) goto normal;
            if (GET_SYMBOL_SEGMENT_HOOK(symbol)!=FUNCTION_CODE_SEGMENT) goto normal;
        }
        PUT_CODE_STRING(TEXT(STR_PUSH_CS_CALL));
        FORMAT(0x12);
        goto newline;
    }
    if (_SI==0xA1 && !(CODEGEN_FUNCTION_FLAGS&1)) { PUT_CODE_STRING(TEXT(STR_DB_0CBH)); goto done; }
    if ((int)_SI>=0xC8 && (int)_SI<=0xCA) {
        PUT_CODE_STRING(((struct Descriptor near *)_DI)->name);
        PUT_CODE_CHAR(0x20);
        goto done;
    }
    if (((struct Descriptor near *)_DI)->flags&2L) {
        if ((int)_SI>=0x82 && (int)_SI<=0x84 && FIRST_ASM_OPERAND.kind==0) {
            PUT_CODE_STRING(TEXT(STR_FCOMPP)); goto done;
        }
        if (SECOND_ASM_OPERAND.kind==1) {
            PUT_CODE_STRING(((struct Descriptor near *)_DI)->name);
            PUT_CODE_STRING(TEXT(STR_P_ST));
            EMIT_DECIMAL((int)FIRST_ASM_OPERAND.reg);
            PUT_CODE_STRING(TEXT(STR_ST_0)); goto done;
        }
    }
normal:
    PUT_CODE_STRING(((struct Descriptor near *)_DI)->name);
    PUT_CODE_CHAR(9);
    switch((int)_SI) {
    case 0xA1: case 0xA2:
        if (SECOND_ASM_OPERAND.kind) { EMIT_DECIMAL(SECOND_ASM_OPERAND.offset); goto newline; }
        _SI=_SI;
        break;
    case 0xA4: case 0xA5: case 0x7B: case 0x7C:
        if (FIRST_ASM_OPERAND.kind!=4) EMIT_GROUP_PREFIX(FIRST_ASM_OPERAND.symbol);
        FORMAT(0);
        break;
    case 0x8C: case 0x8D:
        PUT_CODE_STRING(TEXT(STR_P_ST+2));
        EMIT_DECIMAL((int)FIRST_ASM_OPERAND.reg);
        PUT_CODE_STRING(TEXT(STR_ST_0+8));
        goto done;
    case 0x3D: case 0x82: case 0x83: case 0x84:
    case 0x20: case 0x21: case 0x22:
    case 0x29: case 0x2A: case 0x2B: case 0x2C: case 0x2D: case 0x2E:
    case 0x33: case 0x34: case 0x35:
    case 0x38: case 0x39: case 0x3A: case 0x3B: case 0x3C:
        if (FIRST_ASM_OPERAND.kind!=1) goto fallback;
        PUT_CODE_STRING(TEXT(STR_ST_0_ST));
        EMIT_DECIMAL((int)FIRST_ASM_OPERAND.reg);
        PUT_CODE_STRING(TEXT(STR_ST_0+8));
        goto done;
    case 0x92:
        EMIT_DECIMAL(SECOND_ASM_OPERAND.offset);
        PUT_CODE_STRING(TEXT(STR_0));
        goto done;
    case 0x72:
        EMIT_DECIMAL(FIRST_ASM_OPERAND.offset);
        break;
    case 0x32:
        if (FIRST_ASM_OPERAND.kind==4) PUT_CODE_STRING(TEXT(STR_AX_AX));
    case 0x31: case 0x36: case 0x37:
    case 0x3F: case 0x41: case 0x42: case 0x43:
        EMIT_ASM_OPERAND(&SECOND_ASM_OPERAND,INSN_OPERAND_FORMAT(_SI));
        break;
    case 0x76:
        FORMAT(7); break;
    case 0x78:
        FORMAT(0x15); break;
    case 0x77:
        FORMAT(0x12); break;
    default:
fallback:
        if (_SI==0x5D) format=7;
        else format=INSN_OPERAND_FORMAT(_SI);
        if (OPCODE_DESCRIPTOR_TABLE[_SI].tail[2]==1) FORMAT(1);
        else FORMAT(format);
        if (SECOND_ASM_OPERAND.kind) {
            PUT_CODE_CHAR(0x2C);
            if (OPCODE_DESCRIPTOR_TABLE[_SI].tail[3]==7 || OPCODE_DESCRIPTOR_TABLE[_SI].tail[3]==1) format=1;
            EMIT_ASM_OPERAND(&SECOND_ASM_OPERAND,format);
        }
        break;
    }
newline:
    PUT_CODE_STRING(TEXT(&STR_DB_LINE_CRLF));
done:
    ;
}
#undef TEXT
#undef FORMAT

/* ---- INSN_OPERAND_FORMAT (listing ovr_1dda_b2c2:37CA) ---- */

/* Operand type (a type kind, used for "byte ptr" and register width) of instruction
   index, from byte 8 of its descriptor through ASM_OPERAND_FORMAT_MAP. */
static int near pascal INSN_OPERAND_FORMAT(int index)
{
    return ASM_OPERAND_FORMAT_MAP[OPCODE_DESC_BYTE8[index * 19]];
}

/* ---- EMIT_ASM_OPERAND (listing ovr_1dda_b2c2:37EA) ---- */
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern void (far pascal *NAME_HOOK)(unsigned int);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_FAR_STRING(unsigned int,unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern char far *far pascal REGISTER_NAME(unsigned char,unsigned char);
#define S(n) ((char far *)MK_FP(_DS,(n)))
/* Writes one operand. kind 1: a register (or "st(n)" for x87 types); 4: an immediate;
   2: "offset [group:]name[+n]"; 3: the segment of a symbol (its group or segment name, or
   "seg name"); 5: memory, with "byte/word/dword/qword/tbyte/far/near ptr" when type is
   given, an optional segment override, then name, [base+index+disp] or "ds:[n]" for an
   absolute address. Struct Operand: kind, index (segment register), scale (second
   address register), reg (register or base), offset, symbol. */
static void near pascal EMIT_ASM_OPERAND(register struct Operand near *operand,int type)
{
    int owner;
    unsigned int node;
    register int printed;
    printed=0;
    switch(operand->kind) {
    case 1:
        if(EXPR_FLAGS[type]&2) {
            PUT_CODE_STRING(S(STR_P_ST+2));
            EMIT_DECIMAL(operand->reg);
            PUT_CODE_STRING(S(STR_RPAREN));
        } else PUT_CODE_STRING(REGISTER_NAME(operand->reg,type<=2 ? 2:6));
        break;
    case 4:
        if(type>2) goto numeric;
        EMIT_DECIMAL(operand->offset&255);
        printed=printed;
        break;
    case 2:
        PUT_CODE_STRING(S(STR_MOV_BX_OFFSET+8));
        EMIT_GROUP_PREFIX(operand->symbol);
        if(operand->symbol!=0) {
            NAME_HOOK(operand->symbol);
            printed=1;
        }
        if(operand->offset!=0) {
            if(printed && operand->offset!=0) PUT_CODE_CHAR('+');
            EMIT_DECIMAL(operand->offset);
            printed=printed;
        }
        break;
    case 3:
        owner=GET_SYMBOL_SEGMENT_HOOK(operand->symbol);
        if(GET_SYMBOL_KIND_HOOK(operand->symbol)==3 && SYMBOL_ELEMENT_KIND_HOOK(operand->symbol)!=18 && owner!=-1) {
            if(owner==0) {
                _AX=FIND_SEGMENT(DATA_SEGMENT_ID);
                printed=printed;
            } else _AX=FIND_SEGMENT(owner);
            node=_AX;
            _BX=node; _ES=SEGDEF_POOL_SEG;
            if(ES_W(_BX,SEGDEF_GROUP)!=0) {
                _BX=ES_W(_BX,SEGDEF_GROUP);
                PUT_FAR_STRING(ES_W(_BX,SEGGRP_NAME),(unsigned)&STRING_POOL_SEG);
                return;
            }
            _BX=node; _ES=SEGDEF_POOL_SEG;
            PUT_FAR_STRING(ES_W(_BX,SEGDEF_NAME),(unsigned)&STRING_POOL_SEG);
            return;
        }
        PUT_CODE_STRING(S(STR_SEG));
        if(operand->symbol!=0) NAME_HOOK(operand->symbol);
        break;
    case 5:
        if(type!=0) {
            switch(type) {
            case 1: case 2:PUT_CODE_STRING(S(STR_BYTE_2));break;
            case 10:PUT_CODE_STRING(S(STR_QWORD));break;
            case 9:PUT_CODE_STRING(S(STR_DWORD));break;
            case 11:PUT_CODE_STRING(S(STR_TBYTE));break;
            case 21:PUT_CODE_STRING(S(STR_FAR_5));break;
            case 18:PUT_CODE_STRING(S(STR_NEAR_6));break;
            case 7:PUT_CODE_STRING(S(STR_DWORD));break;
            default:PUT_CODE_STRING(S(STR_QWORD+1));break;
            }
            PUT_CODE_STRING(S(STR_JMP_FAR_PTR+10));
        }
        if(operand->index!=-1) {
            PUT_CODE_STRING(REGISTER_NAME(operand->index,6));
            PUT_CODE_CHAR(':');
        } else EMIT_GROUP_PREFIX(operand->symbol);
        if(operand->symbol!=0) {
            NAME_HOOK(operand->symbol);
            printed=1;
        } else if(operand->reg==-1 && operand->scale==-1) {
            if(operand->index==-1) PUT_CODE_STRING(S(STR_DS+1));
            PUT_CODE_CHAR('[');
            EMIT_DECIMAL(operand->offset);
            PUT_CODE_CHAR(']');
            break;
        }
        if(operand->reg!=-1 || operand->scale!=-1) {
            PUT_CODE_CHAR('[');
            printed=0;
            if(operand->reg!=-1) {
                PUT_CODE_STRING(REGISTER_NAME(operand->reg,6));
                printed=1;
            }
            if(operand->scale!=-1) {
                if(printed) PUT_CODE_CHAR('+');
                PUT_CODE_STRING(REGISTER_NAME(operand->scale,6));
                printed=1;
            }
            if(operand->offset!=0) {
                if(printed && (int)operand->offset>0) PUT_CODE_CHAR('+');
                EMIT_SIGNED_DECIMAL(operand->offset);
            }
            PUT_CODE_CHAR(']');
        } else if(operand->offset!=0) {
            if(printed) PUT_CODE_CHAR('+');
numeric:
            EMIT_DECIMAL(operand->offset);
        }
        break;
    }
}
#undef S

/* ---- EMIT_GROUP_PREFIX (listing ovr_1dda_b2c2:3AFA) ---- */
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int value);
extern void far pascal PUT_CODE_CHAR(unsigned int value);
extern void far pascal PUT_FAR_STRING(unsigned int, unsigned int);

/* Writes "GROUP:" before a reference to symbol value when its segment belongs to a group
   (word 1 of the segment record is SEGDEF_GROUP, word 2 of the group record its name). */
void far pascal EMIT_GROUP_PREFIX(unsigned int value)
{
    register unsigned int entry;

    if (value) {
        entry = FIND_SEGMENT(GET_SYMBOL_SEGMENT_HOOK(value));
        if (entry) {
            if (((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, entry))[1]) {
                PUT_FAR_STRING(((unsigned int far *)MK_FP(SEGDEF_POOL_SEG,
                    ((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, entry))[1]))[2],
                    (unsigned)&STRING_POOL_SEG);
                PUT_CODE_CHAR(0x3A);
            }
        }
    }
}

/* ---- EMIT_DB_LINE (listing ovr_1dda_b2c2:3B42) ---- */
void far pascal EMIT_DB_LINE(unsigned char value);
extern void far pascal PUT_CODE_STRING(char far *text);
extern void far pascal EMIT_SIGNED_DECIMAL(unsigned int value);

/* Writes one "db value" line. */
void far pascal EMIT_DB_LINE(unsigned char value)
{
    PUT_CODE_STRING(&STR_DB);
    EMIT_SIGNED_DECIMAL(value);
    PUT_CODE_STRING(&STR_DB_LINE_CRLF);
}

/* ---- STAOV188 (listing ovr_1dda_b2c2:3B68) ---- */
extern void (far pascal *NAME_HOOK)(unsigned int);
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern char far *ASM_TYPE_NAME_TABLE[];
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(unsigned int);
extern void far pascal EMIT_DECIMAL(unsigned int);
#define TEXT(n) ((char near *)(n))
/* Communal variable: "\tcomm\tfar|near name:type" for a single scalar of size 1, 2, 4, 8
   or 10; otherwise "\t$comm\tname,far|near,width,count" (count in hex with H when it is
   64K or more). indirect set selects far. */
void far pascal EMIT_COMM_DECLARATION(unsigned int node,unsigned int indirect,unsigned int width,unsigned long count)
{
    if(count==1L && (width==1 || width==2 || width==4 || width==8 || width==10)) {
        PUT_CODE_STRING(TEXT(STR_COMM));
        PUT_CODE_STRING(indirect!=0 ? TEXT(STR_FAR_3) : TEXT(STR_NEAR_4));
        NAME_HOOK(node);
        PUT_CODE_CHAR(':');
        PUT_CODE_STRING(ASM_TYPE_NAME_TABLE[SYMBOL_ELEMENT_KIND_HOOK(node)]);
    } else {
        PUT_CODE_STRING(TEXT(STR_COMM_2));
        NAME_HOOK(node);
        PUT_CODE_CHAR(',');
        PUT_CODE_STRING(indirect!=0 ? TEXT(STR_FAR_4) : TEXT(STR_NEAR_5));
        EMIT_DECIMAL(width);
        PUT_CODE_CHAR(',');
        if(count>=0x10000L) {
            EMIT_HEX_BYTE((unsigned int)(count>>24));
            EMIT_HEX_BYTE((unsigned int)(count>>16));
            EMIT_HEX_BYTE((unsigned int)(count>>8));
            EMIT_HEX_BYTE((unsigned int)count);
            PUT_CODE_CHAR('H');
        } else EMIT_DECIMAL((unsigned int)count);
    }
}
#undef TEXT

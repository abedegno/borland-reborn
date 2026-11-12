/* target: ovr182_C213UNIT */
/* Role: inline assembly: operand helpers for the encoder in INLINASM.ASM: decodes symbol
   operands, emits bytes, fixup operands and segment-override prefixes. Entry points:
   DECODE_ASM_SYMBOL, ASM_COLON_LABEL_STUB, EMIT_ASM_BYTE, EMIT_ASM_FIXUP_OPERAND,
   ASM_FLUSH_KIND2_STUB, EMIT_SEGMENT_PREFIX. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO079 (ovr_1ded_b4a9) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the services BCC's resident inline assembler (INLINASM.ASM,
   ASM_ASSEMBLE_STATEMENT) calls back into while it assembles an asm statement straight
   to machine code (object mode).
   - DECODE_ASM_SYMBOL turns the coded name a front end put into the statement text in
     place of a C variable (ENCODE_ASM_SYMBOL in ASMENC.C, ENCODE_ASM_SYMBOL_ALT in
     ASMENC2.C) back into an operand: "@S" + 4 letters for a static or global symbol,
     "@V" + 4 letters for an auto or parameter (a variable table entry), each followed by a
     size letter. A letter stands for one hex digit ('a' = 0 ... 'p' = 15).
   - EMIT_ASM_BYTE, EMIT_ASM_FIXUP_OPERAND and EMIT_SEGMENT_PREFIX receive the assembled
     bytes, operands with fixups, and prefixed bytes.
   - ASM_COLON_LABEL_STUB and ASM_FLUSH_KIND2_STUB are entries that do nothing and return
     0 (success).
   A nonzero return value tells the assembler to stop with that error code. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"
#include "POOL.H"



/* ---- DECODE_ASM_SYMBOL (listing ovr_1ded_b4a9:4A90) ---- */
struct Decoded { unsigned long zero;void far *operand;unsigned long value;int tag,match; };
extern unsigned int CODE_SEGMENT_ID; extern unsigned int VARIABLE_TABLE_SEG;
extern int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void far cdecl REPORT_ERROR(unsigned int,char far *);
#define NIB(p,n) (((int)(signed char)(p)[n]-'a')&15)
#define HEX(p) ((NIB(p,0)<<12)|(NIB(p,1)<<8)|(NIB(p,2)<<4)|NIB(p,3))
/* text points one character before a coded name; out receives the operand. For "@S":
   operand = far pointer to the symbol's record in CSYM_POOL_SEG, value = its offset
   (SYMBOL_INDEX_HOOK), match = 1 if it lies in the current code segment. For "@V" of a
   variable not in a register (VAR_FLAGS & 2 clear): operand = -3 (marks a BP-relative
   operand), value = its frame offset, match 0; for a register variable these fields are
   left unchanged. tag = the size letter's value. Returns 0, or 5Ah after reporting
   "Undefined symbol" when the text is not a coded name. */
int far pascal DECODE_ASM_SYMBOL(char far *text,struct Decoded far *out)
{
    register unsigned int index;
    ++text;
    if(*text=='@') {
        out->zero=0L;
        ++text;
        if(*text++=='S') {
            index=HEX(text);
            out->operand=MK_FP(CSYM_POOL_SEG,index);
            out->value=(unsigned int)SYMBOL_INDEX_HOOK(index);
            out->match=GET_SYMBOL_SEGMENT_HOOK(index)==CODE_SEGMENT_ID;
        } else {
            index=HEX(text);
            if((VAR_B(index,VAR_FLAGS)&2)==0) {
                out->operand=(void far *)-3L;
                out->value=VAR_W(index,VAR_FRAME_OFFSET);
                out->match=0;
            }
        }
        out->tag=(unsigned char)text[4]-'a';
    } else {
        REPORT_ERROR(MSG_UNDEFINED_SYMBOL,text);
        return 0x5A;
    }
    return 0;
}
#undef NIB
#undef HEX

/* ---- STAOV211 (listing ovr_1ded_b4a9:4BEE) ---- */
/* Hook entry that does nothing; returns 0. */
int far pascal ASM_COLON_LABEL_STUB(unsigned int first, unsigned int second)
{
    return 0;
}

/* ---- EMIT_ASM_BYTE (listing ovr_1ded_b4a9:4BF7) ---- */
extern void (far pascal *BYTE_HOOK)(unsigned char value);
extern unsigned int far pascal FIND_SEGMENT(unsigned int value);
extern void far pascal EMIT_CODE_BYTE(unsigned char value);

/* Stores one assembled byte: to the data segment through BYTE_HOOK when the data segment
   is selected (an asm statement at file level), else into the code buffer. Returns 0. */
unsigned int far pascal EMIT_ASM_BYTE(unsigned char value)
{
    if (FIND_SEGMENT(DATA_SEGMENT_ID) == SELECTED_SEGDEF_ENTRY)
        BYTE_HOOK(value);
    else
        EMIT_CODE_BYTE(value);
    return 0;
}

/* ---- EMIT_ASM_FIXUP_OPERAND (listing ovr_1ded_b4a9:4C22) ---- */
extern void far pascal EMIT_CODE_WORD(unsigned int value);
extern void far pascal ADD_FIXUP(unsigned int, unsigned int);

/* Writes an operand that needs a fixup. value1 is the operand form: 0 or 1 an offset
   (fixup kind 1, one word), 2 offset and segment (fixup kind 3, two words), 3 a far
   address (kind 7, one word). value2:value3 is the far pointer DECODE_ASM_SYMBOL gave
   (value3, its offset, is the symbol record); value5 and value4 are the low and high
   words of the operand's value. Returns 0. */
unsigned int far pascal EMIT_ASM_FIXUP_OPERAND(char value1, unsigned int value2,
                                 unsigned int value3, unsigned int value4,
                                 unsigned int value5)
{
    /* As in the original, mode is left unset when value1 is not 0..3. */
    register unsigned int mode;
    switch (value1) {
    case 2:
        mode = 3;
        break;
    case 0:
        mode = 1;
        break;
    case 1:
        mode = 1;
        break;
    case 3:
        mode = 7;
        break;
    }
    ADD_FIXUP(mode, value3);
    EMIT_CODE_WORD(value5);
    if (mode == 3)
        EMIT_CODE_WORD(value4);
    return 0;
}

/* ---- STAOV215 (listing ovr_1ded_b4a9:4C77) ---- */
/* Hook entry that does nothing; returns 0. */
int far pascal ASM_FLUSH_KIND2_STUB(unsigned int first, unsigned int second, unsigned int third)
{
    return 0;
}

/* ---- EMIT_SEGMENT_PREFIX (listing ovr_1ded_b4a9:4C80) ---- */
extern void far pascal EMIT_CODE_BYTE(unsigned char);
extern void far pascal ADD_NAMED_FIXUP(char near *);
#define TEXT(n) ((char near *)(n))
/* Writes the segment-override prefix byte prefix (3Eh DS, 26h ES, 36h SS, 2Eh CS, or
   none) and then the instruction byte character. annotated set means an x87 instruction
   for the emulator: an FWAIT (9Bh) is written first, with fixups to the emulator symbols
   (FIARQQ/FJARQQ, FIERQQ, FISRQQ/FJSRQQ, FICRQQ/FJCRQQ, FIDRQQ without prefix) on the
   wait and prefix bytes, so the linker can patch them for the emulator. Returns 0. */
int far pascal EMIT_SEGMENT_PREFIX(unsigned char character,signed char prefix,unsigned char annotated)
{
    switch((int)prefix) {
    case 0x3E:
        if(annotated!=0) {
            ADD_NAMED_FIXUP(TEXT(0x5AC4));EMIT_CODE_BYTE(0x9B);ADD_NAMED_FIXUP(TEXT(0x5ACB));
        }
        EMIT_CODE_BYTE(0x3E);break;
    case 0x26:
        if(annotated!=0) {ADD_NAMED_FIXUP(TEXT(0x5AD2));EMIT_CODE_BYTE(0x9B);}
        EMIT_CODE_BYTE(0x26);break;
    case 0x36:
        if(annotated!=0) {
            ADD_NAMED_FIXUP(TEXT(0x5AD9));EMIT_CODE_BYTE(0x9B);ADD_NAMED_FIXUP(TEXT(0x5AE0));
        }
        EMIT_CODE_BYTE(0x36);break;
    case 0x2E:
        if(annotated!=0) {
            ADD_NAMED_FIXUP(TEXT(0x5AE7));EMIT_CODE_BYTE(0x9B);ADD_NAMED_FIXUP(TEXT(0x5AEE));
        }
        EMIT_CODE_BYTE(0x2E);break;
    default:
        if(annotated!=0) {ADD_NAMED_FIXUP(TEXT(0x5AF5));EMIT_CODE_BYTE(0x9B);}
    }
    EMIT_CODE_BYTE(character);
    return 0;
}
#undef TEXT

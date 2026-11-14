/* asmopnd.c: from bcc20/src/inlasm/ASMOPND.C: the services BCC's resident inline assembler
   (INLINASM.ASM, ASM_ASSEMBLE_STATEMENT) calls back while it assembles an asm statement
   straight to machine code (object mode).
   DECODE_ASM_SYMBOL turns the coded name a front end put in the statement text in place of
   a C variable (ENCODE_ASM_SYMBOL in asmenc.c, ENCODE_ASM_SYMBOL_ALT in asmenc2.c) back into
   an operand: "@S" and 4 letters for a static or global symbol, "@V" and 4 letters for an
   auto or parameter (a variable table entry), each followed by a size letter.  A letter
   stands for one hex digit ('a' = 0 ... 'p' = 15).
   EMIT_ASM_BYTE, EMIT_ASM_FIXUP_OPERAND and EMIT_SEGMENT_PREFIX receive the assembled
   bytes, operands with fixups and prefixed bytes.  ASM_COLON_LABEL_STUB and
   ASM_FLUSH_KIND2_STUB do nothing and return 0.  A nonzero result tells the assembler to
   stop with that error code. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "fields.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)

/* the operand DECODE_ASM_SYMBOL fills (struct Decoded): a zero long, the operand, its value,
   the size tag and whether it lies in the current code segment */
#define DECODED_ZERO 0
#define DECODED_OPERAND 4
#define DECODED_VALUE 8
#define DECODED_TAG 12
#define DECODED_MATCH 14

/* one letter of a coded name as a hex digit */
static u16 nibble(farptr text, i16 n) { return (u16)(((i16)SB(fp_add(text, n)) - 'a') & 15); }
static u16 coded_index(farptr text)
{
    return (u16)(nibble(text, 0) << 12 | nibble(text, 1) << 8 | nibble(text, 2) << 4 | nibble(text, 3));
}

/* text points one character before a coded name.  For "@S": the operand is a far pointer
   to the symbol's record in CSYM_POOL_SEG, the value its offset (SYMBOL_INDEX_HOOK), match
   1 if it lies in the current code segment.  For "@V" of a variable not in a register
   (VAR_FLAGS bit 1 clear): the operand is -3 (a BP-relative operand), the value its frame
   offset, match 0; for a register variable those fields are left as they were.  The tag is
   the size letter's value.  Returns 0, or 5Ah after reporting "Undefined symbol" when the
   text is not a coded name */
i16 DECODE_ASM_SYMBOL(farptr text, farptr out)
{
    text = fp_add(text, 1);
    if (SB(text) != '@') {
        REPORT_ERROR(MSG_UNDEFINED_SYMBOL, text);
        return 0x5A;
    }
    D(fp_add(out, DECODED_ZERO)) = 0;
    text = fp_add(text, 1);
    i8 kind = SB(text);
    text = fp_add(text, 1);
    u16 index = coded_index(text);
    if (kind == 'S') {
        D(fp_add(out, DECODED_OPERAND)) = MK_FP(CSYM_POOL_SEG, index);
        D(fp_add(out, DECODED_VALUE)) = (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(index));
        W(fp_add(out, DECODED_MATCH)) = (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(index)) == CODE_SEGMENT_ID;
    } else if ((VAR_B(index, VAR_FLAGS) & 2) == 0) {
        D(fp_add(out, DECODED_OPERAND)) = 0xFFFFFFFDu;
        D(fp_add(out, DECODED_VALUE)) = VAR_W(index, VAR_FRAME_OFFSET);
        W(fp_add(out, DECODED_MATCH)) = 0;
    }
    W(fp_add(out, DECODED_TAG)) = (u16)(B(fp_add(text, 4)) - 'a');
    return 0;
}

i16 ASM_COLON_LABEL_STUB(u16 first, u16 second)
{
    (void)first;
    (void)second;
    return 0;
}

/* one assembled byte: to the data segment through BYTE_HOOK when the data segment is
   selected (an asm statement at file level), else into the code buffer */
u16 EMIT_ASM_BYTE(u8 value)
{
    if (FIND_SEGMENT(DATA_SEGMENT_ID) == SELECTED_SEGDEF_ENTRY)
        CALL_FAR(BYTE_HOOK, A16(value));
    else
        EMIT_CODE_BYTE(value);
    return 0;
}

/* an operand that needs a fixup.  form 0 or 1 is an offset (fixup kind 1, one word), 2
   offset and segment (kind 3, two words), 3 a far address (kind 7, one word).
   segment:symbol is the far pointer DECODE_ASM_SYMBOL gave (symbol, its offset, is the
   symbol record); low and high are the words of the operand's value.  The original leaves
   the kind unset for any other form: the translation passes 0 and replay does not compare
   it (it is never reached by the corpus) */
u16 EMIT_ASM_FIXUP_OPERAND(i8 form, u16 segment, u16 symbol, u16 high, u16 low)
{
    (void)segment;
    u16 mode;
    switch (form) {
    case 2:
        mode = 3;
        break;
    case 0:
    case 1:
        mode = 1;
        break;
    case 3:
        mode = 7;
        break;
    default:
        mode = 0;
        UNSET_ARGS(1);
    }
    ADD_FIXUP(mode, symbol);
    EMIT_CODE_WORD(low);
    if (mode == 3)
        EMIT_CODE_WORD(high);
    return 0;
}

i16 ASM_FLUSH_KIND2_STUB(u16 first, u16 second, u16 third)
{
    (void)first;
    (void)second;
    (void)third;
    return 0;
}

/* writes the segment-override prefix (3Eh DS, 26h ES, 36h SS, 2Eh CS, or none) and then the
   instruction byte.  For an x87 instruction (annotated) an FWAIT (9Bh) comes first, with
   fixups to the emulator symbols (FIARQQ/FJARQQ, FIERQQ, FISRQQ/FJSRQQ, FICRQQ/FJCRQQ,
   FIDRQQ without a prefix) on the wait and prefix bytes, so the linker can patch them for
   the emulator */
i16 EMIT_SEGMENT_PREFIX(u8 character, i8 prefix, u8 annotated)
{
    switch (prefix) {
    case 0x3E:
        if (annotated != 0) {
            ADD_NAMED_FIXUP(FP_OFF(STR_FIARQQ_P));
            EMIT_CODE_BYTE(0x9B);
            ADD_NAMED_FIXUP(FP_OFF(STR_FJARQQ_P));
        }
        EMIT_CODE_BYTE(0x3E);
        break;
    case 0x26:
        if (annotated != 0) {
            ADD_NAMED_FIXUP(FP_OFF(STR_FIERQQ_P));
            EMIT_CODE_BYTE(0x9B);
        }
        EMIT_CODE_BYTE(0x26);
        break;
    case 0x36:
        if (annotated != 0) {
            ADD_NAMED_FIXUP(FP_OFF(STR_FISRQQ_P));
            EMIT_CODE_BYTE(0x9B);
            ADD_NAMED_FIXUP(FP_OFF(STR_FJSRQQ_P));
        }
        EMIT_CODE_BYTE(0x36);
        break;
    case 0x2E:
        if (annotated != 0) {
            ADD_NAMED_FIXUP(FP_OFF(STR_FICRQQ_P));
            EMIT_CODE_BYTE(0x9B);
            ADD_NAMED_FIXUP(FP_OFF(STR_FJCRQQ_P));
        }
        EMIT_CODE_BYTE(0x2E);
        break;
    default:
        if (annotated != 0) {
            ADD_NAMED_FIXUP(FP_OFF(STR_FIDRQQ_P));
            EMIT_CODE_BYTE(0x9B);
        }
    }
    EMIT_CODE_BYTE(character);
    return 0;
}

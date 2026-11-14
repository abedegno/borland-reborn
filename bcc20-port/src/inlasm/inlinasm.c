/* inlinasm.c: from bcc20/src/inlasm/INLINASM.ASM (hand-written assembly in the original):
   BCC's built-in inline assembler, one module with a single far entry,

       int far pascal ASM_ASSEMBLE_STATEMENT(char far * far *text, unsigned length, int mode)

   called from blklayot.c for each asm statement in object mode.  It returns 0 on success
   and a negative code that the caller maps to an error message, and stores the text
   position reached back through text.  Its 1C0h-byte frame holds the parser state, shared
   by the near routines through BP; operands are 14h-byte records in the frame or pushed on
   the stack; the stack's depth is checked (an expression too deep is error FEh).
   Layout: the statement driver and operand parser, an expression evaluator (one routine per
   precedence level; most have a table of operator token, handler pairs walked by
   ASM_MATCH_OPERATOR_TABLE), number scanning with B/O/D/H radix suffixes, instruction
   encoding, and the opcode table (ASM_MNEMONIC_HASH_TABLE) and register-name table
   (ASM_KEYWORD_HASH_TABLE), which stay data in the code segment and are read there.
   The translation follows the assembly instruction for instruction: the registers are
   16-bit variables, the flags the routines return their results in are kept where the
   original's jumps test them, and the stack is BCC's own: SP starts at the caller's SP in
   DGROUP (BCC's SS is DS) and every push, call and return moves it as in the original, so
   the frame, the operands pushed on the stack and the depth check are where and as they
   were, and the far pointers handed to the C helpers are the original's.  A jump to the
   statement's exit from inside nested routines is a host longjmp. */
#include <setjmp.h>
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"

/* ---- the machine ---- */
static u16 ax, bx, cx, dx, si, di, bp, sp;
static unsigned zf, cf, sf, of;
static jmp_buf statement_exit;
/* the arguments, at bp+6 (mode), bp+8 (the length left, counted down by the scanner) and
   bp+0Ah (text) in the original's frame: the port keeps them here and leaves the caller's
   stack above the return address alone */
static farptr arg_text;
static u16 arg_length, arg_mode;
#define LENGTH arg_length

#define AL ((u8)ax)
#define AH ((u8)(ax >> 8))
#define BL ((u8)bx)
#define BH ((u8)(bx >> 8))
#define CL ((u8)cx)
#define CH ((u8)(cx >> 8))
#define DL ((u8)dx)
#define DH ((u8)(dx >> 8))
#define SET_LO(r, v) ((r) = (u16)(((r) & 0xFF00) | (u8)(v)))
#define SET_HI(r, v) ((r) = (u16)(((r) & 0x00FF) | (u16)((u8)(v)) << 8))

/* DGROUP (DS and SS) and the module's code segment (its tables) */
#define MB(o) B(DSPTR((u16)(o)))
#define MW(o) W(DSPTR((u16)(o)))
#define CODE_SEG ((u16)(0x0775 + (DGROUP - DGROUP_PARA)))   /* load-relative, symbols.tsv */
#define CB(o) B(MK_FP(CODE_SEG, (u16)(o)))
#define CW(o) W(MK_FP(CODE_SEG, (u16)(o)))
#define BPB(n) MB(bp + (n))
#define BPW(n) MW(bp + (n))

static void push(u16 v)
{
    sp -= 2;
    MW(sp) = v;
}
static u16 pop(void)
{
    u16 v = MW(sp);
    sp += 2;
    return v;
}
/* a near call: the return address takes a stack word, as in the original */
#define CALL(f) (push(0), f(), sp += 2)

static void flags16(u16 r)
{
    zf = r == 0;
    sf = r >> 15;
}
static void flags8(u8 r)
{
    zf = r == 0;
    sf = r >> 7;
}
static void cmp16(u16 a, u16 b)
{
    u16 r = (u16)(a - b);
    cf = a < b;
    of = ((a ^ b) & (a ^ r)) >> 15;
    flags16(r);
}
static void cmp8(u8 a, u8 b)
{
    u8 r = (u8)(a - b);
    cf = a < b;
    of = ((a ^ b) & (a ^ r)) >> 7;
    flags8(r);
}
static u16 logic16(u16 r)
{
    cf = of = 0;
    flags16(r);
    return r;
}
static u8 logic8(u8 r)
{
    cf = of = 0;
    flags8(r);
    return r;
}
static u16 add16(u16 a, u16 b)
{
    u32 r = (u32)a + b;
    cf = r >> 16;
    of = (~(a ^ b) & (a ^ (u16)r)) >> 15;
    flags16((u16)r);
    return (u16)r;
}
static u16 adc16(u16 a, u16 b)
{
    u32 r = (u32)a + b + cf;
    of = (~(a ^ b) & (a ^ (u16)r)) >> 15;
    cf = r >> 16;
    flags16((u16)r);
    return (u16)r;
}
static u16 sub16(u16 a, u16 b)
{
    cmp16(a, b);
    return (u16)(a - b);
}
static u16 sbb16(u16 a, u16 b)
{
    u32 subtrahend = (u32)b + cf;
    u16 r = (u16)(a - subtrahend);
    of = ((a ^ b) & (a ^ r)) >> 15;
    cf = a < subtrahend;
    flags16(r);
    return r;
}
static u16 neg16(u16 a)
{
    u16 r = (u16)(0 - a);
    cf = a != 0;
    of = a == 0x8000;
    flags16(r);
    return r;
}
static u16 inc16(u16 a)
{
    u16 r = (u16)(a + 1);
    of = r == 0x8000;
    flags16(r);
    return r;
}
static u16 dec16(u16 a)
{
    u16 r = (u16)(a - 1);
    of = a == 0x8000;
    flags16(r);
    return r;
}
static u8 inc8(u8 a)
{
    u8 r = (u8)(a + 1);
    of = r == 0x80;
    flags8(r);
    return r;
}
static u8 dec8(u8 a)
{
    u8 r = (u8)(a - 1);
    of = a == 0x80;
    flags8(r);
    return r;
}
#define JL (sf != of)
#define JG (!zf && sf == of)
#define JLE (zf || sf != of)
#define JGE (sf == of)
#define JA (!cf && !zf)
#define JBE (cf || zf)

/* the far helpers in C (asmopnd.c, asmcode.c): their results in AX, flags from or ax,ax */
static void far_result(u16 result)
{
    ax = result;
    logic16(ax);
}

/* the frame (offsets from BP) */
#define TEXT_OFF (-0x12)             /* the far text pointer: offset, then segment at -10h */
#define TEXT_SEG (-0x10)
#define SAVED_TEXT (-0x14)           /* the position before the current token */
#define LOOKUP_ENTRY (-0x1E)         /* the keyword entry (code-segment offset) of a word */
#define EMIT_COUNT (-0x110)          /* bytes queued in the emit records (bp+0FEF0h) */
#define EMIT_RECORDS (-0x17E)        /* 10-byte emit records (bp+0FE82h) */
#define STRING_LITERAL (-0x10E)      /* a string operand: length, then the text (bp+0FEF2h) */
#define OPERAND1 (-0x196)            /* operand records (bp+0FE6Ah, 0FE56h, 0FE42h) */
#define OPERAND2 (-0x1AA)
#define OPERAND3 (-0x1BE)
#define STACK_LIMIT (-0x5A8)         /* bp+0FA58h, the lowest SP allowed */

/* forward declarations of the routines */
static void asm_init_state(void);
static void asm_flush_emit_records(void);
static void asm_parse_prefixes(void);
static void asm_parse_data_directive(void);
static void asm_emit_data_value(void);
static void asm_parse_label_prefix(void);
static void asm_parse_operands(void);
static void asm_parse_operand_expr(void);
static void asm_expr_or_xor(void);
static void asm_expr_and(void);
static void asm_expr_not(void);
static void asm_expr_add_sub(void);
static void asm_expr_mul_div_shift(void);
static void asm_expr_ptr_seg_override(void);
static void asm_expr_unary_sign(void);
static void asm_expr_high_low(void);
static void asm_expr_postfix(void);
static void asm_accept_token(void);
static void asm_expect_token(void);
static void asm_next_token(void);
static void asm_peek_nonblank_char(void);
static void asm_match_operator_table(void);
static void asm_require_immediate(void);
static void asm_require_constant(void);
static void asm_push_temp_operand(void);
static void asm_pop_temp_operand(void);
static void asm_clear_operand(void);
static void asm_add_operands(void);
static void asm_make_memory_operand(void);
static void asm_copy_operand_from_di(void);
static void asm_imm_fits_byte(void);
static void asm_check_imm_fits_word(void);
static void asm_queue_emit_record(void);
static void asm_emit_prefix_list(void);
static void asm_encode_instruction(void);
static void asm_mul32(void);
static void asm_div32(void);
static void asm_check_stack_depth(void);
static void asm_run_handler(u16 handler);

/* ---- errors: AL the code, the text position put back, out to the statement's exit ---- */
static void asm_rewind_and_exit(void)
{
    BPW(TEXT_OFF) = BPW(SAVED_TEXT);
    longjmp(statement_exit, 1);
}
static void asm_return_error(u8 code)
{
    ax = (u16)(i16)(i8)code;     /* cbw */
    asm_rewind_and_exit();
}
#define ASM_FAIL_FIELD_IDENT() asm_return_error(0xF1)
#define ASM_FAIL_DIVIDE_BY_ZERO() asm_return_error(0xF2)
#define ASM_FAIL_NEEDS_286_287() asm_return_error(0xF3)
#define ASM_FAIL_BAD_COMBINATION() asm_return_error(0xF4)
#define ASM_FAIL_BAD_DIGIT() asm_return_error(0xF5)
#define ASM_FAIL_STRING_TOO_LONG() asm_return_error(0xF6)
#define ASM_FAIL_NUMBER_OVERFLOW() asm_return_error(0xF7)
#define ASM_FAIL_INVALID_REGISTER() asm_return_error(0xF8)
#define ASM_FAIL_ADD_RELOCATABLES() asm_return_error(0xF9)
#define ASM_FAIL_NOT_CONSTANT() asm_return_error(0xFB)
#define ASM_FAIL_MEMORY_REFERENCE() asm_return_error(0xFC)
#define ASM_FAIL_SIZE_COMBINATION() asm_return_error(0xFD)
#define ASM_FAIL_STACK_OVERFLOW() asm_return_error(0xFE)
#define ASM_FAIL_SYNTAX() asm_return_error(0xFF)

/* SP at or below the limit word at bp-8: the expression is too deep */
static void asm_check_stack_depth(void)
{
    cmp16(sp, BPW(-8));
    if (JBE)
        ASM_FAIL_STACK_OVERFLOW();
}

/* ---- the entry ---- */
i16 ASM_ASSEMBLE_STATEMENT(farptr text, u16 length, i16 mode)
{
    /* BCC's stack: the return address at the caller's SP (the top of the near scratch area,
       in DGROUP), the frame and the operands pushed below it as in the original, so the
       frame lies where the original's did; the area down to the depth check's limit
       (bp-5A8h) and a little more is taken from the near scratch area, so that nothing
       the helpers allocate there lands in it */
    u16 saved_sp = sp, saved_bp = bp;
    farptr saved_text = arg_text;
    u16 saved_length = arg_length, saved_mode = arg_mode;
    arg_text = text;
    arg_length = length;
    arg_mode = (u16)mode;
    u16 mark = near_scratch_mark();
    sp = mark;
    near_scratch_alloc(0x800);
    push(bp);
    bp = sp;
    sp -= 0x1C0;
    if (setjmp(statement_exit) == 0) {
        CALL(asm_init_state);
        BPB(-0x1B) = 1;
        CALL(asm_next_token);
        BPW(SAVED_TEXT) = BPW(TEXT_OFF);
        CALL(asm_parse_label_prefix);
        CALL(asm_parse_prefixes);
        BPB(-0x1B) = dec8(BPB(-0x1B));
        CALL(asm_parse_data_directive);
        if (!zf) {
            ax = (ax & 0xFF00) | 0x3B;
            CALL(asm_accept_token);
            if (zf) {
                ax = (ax & 0xFF00) | 0x41;
                CALL(asm_expect_token);
                CALL(asm_parse_operands);
                CALL(asm_encode_instruction);
            } else
                CALL(asm_emit_prefix_list);
        }
        CALL(asm_flush_emit_records);
        ax = 0;
    }
    /* ASM_STATEMENT_EXIT: the text position back through text, SI and DI as they were */
    cx = BPW(TEXT_OFF);
    W(arg_text) = cx;
    si = BPW(-4);
    di = BPW(-6);
    sp = saved_sp;
    bp = saved_bp;
    arg_text = saved_text;
    arg_length = saved_length;
    arg_mode = saved_mode;
    near_scratch_release(mark);
    return (i16)ax;
}

static void asm_init_state(void)
{
    BPW(-4) = si;
    BPW(-6) = di;
    BPW(-8) = (u16)(bp + STACK_LIMIT);
    u16 offset = W(arg_text);
    u16 segment = W(fp_add(arg_text, 2));
    BPW(TEXT_OFF) = offset;
    BPW(TEXT_SEG) = segment;
    bx = offset;
    ax = 0;
    BPW(SAVED_TEXT) = 0;
    BPW(-0x3A) = 0;
    BPW(-0x38) = 0;
    BPW(-0x0E) = 0;
    BPW(EMIT_COUNT) = 0;
    BPB(-0x25) = 0;
}

/* hands the queued emit records (10 bytes each: kind, a byte, two words, two more) to the C
   side: kind 0 a byte (EMIT_ASM_BYTE), 1 an operand with a fixup (EMIT_ASM_FIXUP_OPERAND),
   2 ASM_FLUSH_KIND2_STUB, else a prefixed byte (EMIT_SEGMENT_PREFIX).  A nonzero result
   stops the statement with that code */
static void asm_flush_emit_records(void)
{
    si = (u16)(bp + EMIT_RECORDS);
    for (;;) {
        BPW(EMIT_COUNT) = sub16(BPW(EMIT_COUNT), 0x0A);
        if (cf)
            break;
        push(si);
        bx = MB(si);
        cx = MB(si + 1);
        dx = MW(si + 2);
        ax = MW(si + 4);
        si += 6;
        {
            u16 t = ax;
            ax = dx;
            dx = t;
        }
        bx = dec16(bx);
        if (sf)
            far_result(EMIT_ASM_BYTE(AL));
        else if (zf)
            far_result(EMIT_ASM_FIXUP_OPERAND((i8)CL, MW(si + 2), MW(si), dx, ax));
        else if ((bx = dec16(bx)) == 0)
            far_result((u16)ASM_FLUSH_KIND2_STUB(ax, MW(si + 2), MW(si)));
        else
            far_result((u16)EMIT_SEGMENT_PREFIX(AL, (i8)(CL & 0xFE), (u8)(CL & 1)));
        if (!zf)
            asm_rewind_and_exit();
        si = pop();
        si += 0x0A;
    }
    BPW(EMIT_COUNT) = 0;
}

/* segment-override and repeat prefixes before the instruction: each keyword entry of
   kind AEh puts its byte in the next free slot of the prefix list at bp-0Eh */
static void asm_parse_prefixes(void)
{
    while (DH == 0x41 && CB(BPW(LOOKUP_ENTRY)) == 0xAE) {
        bx = BPW(LOOKUP_ENTRY);
        ax = (ax & 0xFF00) | CB(bx + 2);
        cx = 5;
        bx = (u16)(bp - 0x0F);
        do {
            bx++;
            cmp8(MB(bx), 0);
            cx--;
        } while (cx && !zf);
        SET_HI(ax, 0);
        MW(bx) = ax;
        CALL(asm_next_token);
    }
}

/* db/dw/dd: a list of values, each emitted and flushed; ZF set when the statement was such a
   directive */
static void asm_parse_data_directive(void)
{
    cmp8(DH, 0x41);
    if (!zf)
        return;
    bx = BPW(LOOKUP_ENTRY);
    ax = CW(bx);
    cmp8(AL, 0xEA);
    if (!zf)
        return;
    BPB(-0x1A) = AH;
    if (BPW(-0x0E) != 0)
        ASM_FAIL_SYNTAX();
    CALL(asm_next_token);
    for (;;) {
        si = (u16)(bp + OPERAND1);
        CALL(asm_parse_operand_expr);
        push(dx);
        CALL(asm_emit_data_value);
        CALL(asm_flush_emit_records);
        dx = pop();
        ax = (ax & 0xFF00) | 0x2C;
        CALL(asm_accept_token);
        if (zf)
            break;
    }
    ax = (ax & 0xFF00) | 0x3B;
    CALL(asm_expect_token);
    ax = logic16(0);
}

/* queues the data value of the operand at SI: db a byte or the characters of a string, dw a
   word (a relocatable one as a fixup record), dd a doubleword (a relocatable far address as
   a fixup record) */
static void asm_dataval_queue_record(void)
{
    CALL(asm_queue_emit_record);
}
static void asm_dataval_queue_byte(void)
{
    SET_LO(bx, 0);
    cx = ax;
    asm_dataval_queue_record();
}
static void asm_dataval_queue_word(void)
{
    CALL(asm_dataval_queue_byte);
    ax = (u16)(ax >> 8 | ax << 8);
    asm_dataval_queue_byte();
}

static void asm_emit_data_value(void)
{
    di = si;
    ax = MW(si);
    dx = MW(si + 2);
    cx = MW(si + 8);
    cx = logic16(cx | MW(si + 0x0A));
    cmp8(BPB(-0x1A), 2);
    if (zf) {
        /* dw */
        cmp8(BPB(STRING_LITERAL), 2);
        if (JA)
            ASM_FAIL_STRING_TOO_LONG();
        CALL(asm_check_imm_fits_word);
        if (cx == 0) {
            asm_dataval_queue_word();
            return;
        }
        bx = 0x101;
        cmp8(MB(si + 0x13), BH);
        if (!cf)
            SET_HI(bx, MB(si + 0x13));
        {
            u16 t = ax;
            ax = cx;
            cx = t;
        }
        ax = MW(bp - 0x18E);
        MW(bp - 0x182) = ax;
        ax = MW(bp - 0x18C);
        MW(bp - 0x180) = ax;
        asm_queue_emit_record();
        return;
    }
    if (JA) {
        /* dd */
        cmp8(BPB(STRING_LITERAL), 4);
        if (JA)
            ASM_FAIL_STRING_TOO_LONG();
        if (cx == 0) {
            CALL(asm_dataval_queue_word);
        } else {
            {
                u16 t = ax;
                ax = cx;
                cx = t;
            }
            bx = 0x301;
            cmp8(MB(si + 0x13), 0);
            if (zf) {
                asm_dataval_queue_record();
                return;
            }
            SET_HI(bx, MB(si + 0x13));
            ax = MW(bp - 0x18E);
            MW(bp - 0x182) = ax;
            ax = MW(bp - 0x18C);
            MW(bp - 0x180) = ax;
            CALL(asm_queue_emit_record);
        }
        {
            u16 t = ax;
            ax = dx;
            dx = t;
        }
        asm_dataval_queue_word();
        return;
    }
    /* db */
    if (cx != 0)
        ASM_FAIL_SIZE_COMBINATION();
    si = (u16)(bp + STRING_LITERAL);
    cmp8(MB(si), 0);
    if (zf) {
        CALL(asm_imm_fits_byte);
        if (!zf)
            ASM_FAIL_NUMBER_OVERFLOW();
        asm_dataval_queue_byte();
        return;
    }
    ax = MB(si);
    si++;
    {
        u16 t = ax;
        ax = cx;
        cx = t;
    }
    while (cx) {
        SET_LO(ax, MB(si));
        si++;
        push(si);
        push(cx);
        CALL(asm_dataval_queue_byte);
        CALL(asm_flush_emit_records);
        cx = pop();
        si = pop();
        cx--;
    }
}

/* a label "name:" before the instruction goes to ASM_COLON_LABEL_STUB */
static void asm_parse_label_prefix(void)
{
    CALL(asm_peek_nonblank_char);
    cmp8(AL, 0x3A);
    if (!zf)
        return;
    bx = (u16)(bp - 0x6C);
    far_result((u16)ASM_COLON_LABEL_STUB(bx, DGROUP));
    if (!zf)
        asm_rewind_and_exit();
    CALL(asm_next_token);
    ax = (ax & 0xFF00) | 0x3A;
    CALL(asm_expect_token);
}

/* up to three operands, separated by commas, ending at ';' (the statement's end); the
   count at bp-1Ch.  A size given on only one of the first two goes to the other */
static void asm_parse_operands(void)
{
    BPB(-0x1C) = 0;
    BPW(-0x16) = BPW(SAVED_TEXT);
    ax = (ax & 0xFF00) | 0x3B;
    CALL(asm_accept_token);
    if (!zf)
        return;
    si = (u16)(bp + OPERAND1);
    CALL(asm_parse_operand_expr);
    BPB(-0x1C) = inc8(BPB(-0x1C));
    ax = (ax & 0xFF00) | 0x3B;
    CALL(asm_accept_token);
    if (!zf)
        return;
    ax = (ax & 0xFF00) | 0x2C;
    CALL(asm_expect_token);
    BPW(-0x18) = BPW(SAVED_TEXT);
    si = (u16)(bp + OPERAND2);
    CALL(asm_parse_operand_expr);
    BPB(-0x1C) = inc8(BPB(-0x1C));
    si = (u16)(bp + OPERAND1);
    di = (u16)(bp + OPERAND2);
    ax = MW(si + 0x0C);
    cx = MW(di + 0x0C);
    BPW(-0x22) = cx;
    if (cx == 0) {
        u16 t = MW(di + 0x0C);
        MW(di + 0x0C) = ax;
        ax = t;
    } else if (logic16(ax), ax == 0) {
        u16 t = MW(si + 0x0C);
        MW(si + 0x0C) = cx;
        cx = t;
    }
    ax = (ax & 0xFF00) | 0x3B;
    CALL(asm_accept_token);
    if (!zf)
        return;
    ax = (ax & 0xFF00) | 0x2C;
    CALL(asm_expect_token);
    si = (u16)(bp + OPERAND3);
    CALL(asm_parse_operand_expr);
    BPB(-0x1C) = inc8(BPB(-0x1C));
    ax = (ax & 0xFF00) | 0x3B;
    CALL(asm_expect_token);
}

/* ---- the expression evaluator: the operand record at SI ---- */
static void asm_parse_operand_expr(void)
{
    CALL(asm_check_stack_depth);
    CALL(asm_clear_operand);
    CALL(asm_expr_or_xor);
    cmp8(MB(si + 0x12), 0x67);
    if (zf && !(MB(si + 0x0E) & 0x40))
        ASM_FAIL_MEMORY_REFERENCE();
}

/* code-segment offsets of the operator tables and their handlers (the tables hold each
   handler as an offset from the table) */
#define ASM_OR_XOR_OPS_TABLE 0x0326
#define ASM_NOT_OPS_TABLE 0x0372
#define ASM_ADD_SUB_OPS_TABLE 0x03AA
#define ASM_MUL_DIV_SHIFT_OPS_TABLE 0x0417
#define ASM_OFFSET_SEG_TYPE_TABLE 0x04D7
#define ASM_UNARY_SIGN_OPS_TABLE 0x0501
#define ASM_HIGH_LOW_OPS_TABLE 0x0524
#define H_OP_OR 0x031A
#define H_OP_XOR 0x0320
#define H_ADDSUB_ADD 0x03A1
#define H_ADDSUB_SUB 0x0391
#define H_MULDIV_MUL 0x0404
#define H_MULDIV_DIV 0x040A
#define H_MULDIV_MOD 0x0410
#define H_MULDIV_SHR 0x03E2
#define H_MULDIV_SHL 0x03F5
#define H_OFS_OFFSET 0x049B
#define H_OFS_SEG 0x04A1
#define H_OFS_TYPE 0x04AC
#define H_USIGN_NEG 0x04EF
#define H_USIGN_PLUS 0x04FB
#define H_HILO_HIGH 0x0516
#define H_HILO_LOW 0x051A
#define ASM_BRACKET_OPS_TABLE 0x05B4
#define H_BRACKET_PAREN 0x05A4
#define H_BRACKET_SQUARE 0x05A8

static void asm_expr_or_xor(void)
{
    CALL(asm_expr_and);
    for (;;) {
        bx = ASM_OR_XOR_OPS_TABLE;
        CALL(asm_match_operator_table);
        if (zf)
            return;
        CALL(asm_require_immediate);
        CALL(asm_push_temp_operand);
        CALL(asm_expr_and);
        CALL(asm_require_immediate);
        CALL(asm_pop_temp_operand);
        ax = MW(di);
        cx = MW(di + 2);
        push(0);
        asm_run_handler(bx);
        sp += 2;
        sp += 0x14;
    }
}

static void asm_expr_and(void)
{
    CALL(asm_expr_not);
    for (;;) {
        ax = (ax & 0xFF00) | 0x4A;      /* TOK_AND */
        CALL(asm_accept_token);
        if (zf)
            return;
        CALL(asm_require_immediate);
        CALL(asm_push_temp_operand);
        CALL(asm_expr_not);
        CALL(asm_require_immediate);
        CALL(asm_pop_temp_operand);
        ax = MW(di);
        MW(si) = logic16(MW(si) & ax);
        ax = MW(di + 2);
        MW(si + 2) = logic16(MW(si + 2) & ax);
        sp += 0x14;
    }
}

static void asm_expr_not(void)
{
    CALL(asm_check_stack_depth);
    bx = ASM_NOT_OPS_TABLE;
    CALL(asm_match_operator_table);
    if (zf) {
        asm_expr_add_sub();
        return;
    }
    CALL(asm_expr_not);
    CALL(asm_require_immediate);
    MW(si) = (u16)~MW(si);
    MW(si + 2) = (u16)~MW(si + 2);
    BPB(STRING_LITERAL) = 0;
}

static void asm_expr_add_sub(void)
{
    CALL(asm_expr_mul_div_shift);
    for (;;) {
        bx = ASM_ADD_SUB_OPS_TABLE;
        CALL(asm_match_operator_table);
        if (zf)
            return;
        CALL(asm_push_temp_operand);
        CALL(asm_expr_mul_div_shift);
        CALL(asm_pop_temp_operand);
        push(0);
        asm_run_handler(bx);
        sp += 2;
        sp += 0x14;
    }
}

static void asm_expr_mul_div_shift(void)
{
    CALL(asm_expr_ptr_seg_override);
    for (;;) {
        bx = ASM_MUL_DIV_SHIFT_OPS_TABLE;
        CALL(asm_match_operator_table);
        if (zf)
            return;
        CALL(asm_require_immediate);
        CALL(asm_push_temp_operand);
        CALL(asm_expr_ptr_seg_override);
        CALL(asm_require_immediate);
        CALL(asm_pop_temp_operand);
        push(dx);
        ax = MW(si);
        dx = MW(si + 2);
        cx = MW(di);
        push(0);
        asm_run_handler(bx);
        sp += 2;
        MW(si) = ax;
        MW(si + 2) = dx;
        dx = pop();
        sp += 0x14;
    }
}

/* shifts of DX:AX by CX (the count masked with 803Fh: a negative count shifts the other
   way, a zero count nothing) */
static void op_shr(void);
static void op_shl(void)
{
    cx = logic16(cx & 0x803F);
    if (sf) {
        cx = neg16(cx);
        op_shr();
        return;
    }
    if (zf)
        return;
    do {
        cf = ax >> 15;
        ax = (u16)(ax << 1);
        u16 out = dx >> 15;
        dx = (u16)(dx << 1 | cf);
        cf = out;
    } while (--cx);
}
static void op_shr(void)
{
    cx = logic16(cx & 0x803F);
    if (sf) {
        cx = neg16(cx);
        if (of)
            return;
        op_shl();
        return;
    }
    if (zf)
        return;
    do {
        cf = dx & 1;
        dx >>= 1;
        u16 out = ax & 1;
        ax = (u16)(cf << 15 | ax >> 1);
        cf = out;
    } while (--cx);
}

static void asm_expr_ptr_seg_override(void)
{
    CALL(asm_check_stack_depth);
    bx = ASM_OFFSET_SEG_TYPE_TABLE;
    CALL(asm_match_operator_table);
    if (!zf) {
        /* OFFSET, SEG or TYPE: the handler runs when the operand after it is parsed */
        push(bx);
        CALL(asm_clear_operand);
        asm_expr_ptr_seg_override();
        asm_run_handler(pop());
        return;
    }
    CALL(asm_expr_unary_sign);
    ax = (ax & 0xFF00) | 0x50;          /* TOK_PTR */
    CALL(asm_accept_token);
    if (zf) {
        /* a segment register followed by ':' is an override for the operand after it */
        cmp8(MB(si + 0x10), 2);
        if (!zf)
            return;
        cmp8(MB(si + 0x12), 0x65);
        if (!zf)
            return;
        ax = (ax & 0xFF00) | 0x3A;
        CALL(asm_accept_token);
        if (zf)
            return;
        push(MW(si + 0x11));
        CALL(asm_clear_operand);
        CALL(asm_expr_ptr_seg_override);
        ax = pop();
        SET_LO(ax, (u8)(AL << 3) | 0x26);
        MB(si + 0x0F) = AL;
        MB(si + 0x0E) |= 0x40;
        CALL(asm_make_memory_operand);
        return;
    }
    /* type PTR operand */
    CALL(asm_push_temp_operand);
    CALL(asm_expr_ptr_seg_override);
    CALL(asm_pop_temp_operand);
    push(MW(si + 0x0C));
    push(MW(si + 4));
    push(MW(si + 6));
    CALL(asm_copy_operand_from_di);
    MW(si + 6) = pop();
    MW(si + 4) = pop();
    MW(si + 0x0C) = pop();
    MB(si + 0x12) = 0x67;
    MB(si + 0x0E) |= 0x40;
    sp += 0x14;
}

/* OFFSET, SEG and TYPE make the operand a constant: its offset, its segment (fixup kind 2)
   or its size */
static void ofsseg_make_constant(void)
{
    MB(si + 0x12) = 0x64;
    bx = 0;
    MB(si + 0x0E) = 0;
    MB(si + 0x0F) = 0;
    MW(si + 2) = 0;
    MW(si + 0x0C) = 0;
    ax = MW(si + 8);
    ax = logic16(ax | MW(si + 0x0A));
    if (!zf)
        return;
    MB(si + 0x13) = 0;
}
static void ofs_offset(void)
{
    MB(si + 0x13) = 1;
    ofsseg_make_constant();
}
static void ofs_seg(void)
{
    MB(si + 0x13) = 2;
    MW(si) = MW(si + 2);
    ofsseg_make_constant();
}
static void ofs_type(void)
{
    MW(si) = MW(si + 0x0C);
    ax = 0;
    MW(si + 8) = 0;
    MW(si + 0x0A) = 0;
    ofsseg_make_constant();
}

static void asm_expr_unary_sign(void)
{
    bx = ASM_UNARY_SIGN_OPS_TABLE;
    CALL(asm_match_operator_table);
    if (zf) {
        asm_expr_high_low();
        return;
    }
    CALL(asm_check_stack_depth);
    push(bx);
    asm_expr_unary_sign();
    asm_run_handler(pop());
}
static void usign_plus(void)
{
    BPB(STRING_LITERAL) = 0;
}
static void usign_neg(void)
{
    CALL(asm_require_constant);
    MW(si) = neg16(MW(si));
    MW(si + 2) = adc16(MW(si + 2), 0);
    MW(si + 2) = neg16(MW(si + 2));
    usign_plus();
}

static void asm_expr_high_low(void)
{
    bx = ASM_HIGH_LOW_OPS_TABLE;
    CALL(asm_match_operator_table);
    if (zf) {
        asm_expr_postfix();
        return;
    }
    CALL(asm_check_stack_depth);
    push(bx);
    asm_expr_high_low();
    asm_run_handler(pop());
}
static void hilo_low(void)
{
    MB(si + 1) = 0;
    MW(si + 2) = 0;
}
static void hilo_high(void)
{
    MW(si) = (u16)(MW(si) >> 8 | MW(si) << 8);
    hilo_low();
}

/* ADD and SUB: SUB negates the constant at DI first */
static void addsub_add(void)
{
    CALL(asm_add_operands);
    BPB(STRING_LITERAL) = 0;
}
static void addsub_sub(void)
{
    {
        u16 t = si;
        si = di;
        di = t;
    }
    CALL(asm_require_constant);
    {
        u16 t = si;
        si = di;
        di = t;
    }
    MW(di) = neg16(MW(di));
    MW(di + 2) = adc16(MW(di + 2), 0);
    MW(di + 2) = neg16(MW(di + 2));
    addsub_add();
}

/* ---- postfix: '.' member, '[' or '(' indexing, after a bracketed or primary term ---- */
static void asm_expr_bracketed(void);
static void asm_expr_primary(void);
static void asm_primary_term(void);
static void asm_term_symbol(void);

static void asm_expr_postfix(void)
{
    CALL(asm_check_stack_depth);
    CALL(asm_expr_bracketed);
    for (;;) {
        cmp8(DH, 0x2E);
        if (zf) {
            /* ".member": the field's offset added, its size taken */
            BPW(-0x3A) = MW(si + 4);
            BPW(-0x38) = MW(si + 6);
            ax = 0;
            MW(si + 4) = 0;
            MW(si + 6) = 0;
            CALL(asm_next_token);
            CALL(asm_push_temp_operand);
            CALL(asm_expr_ptr_seg_override);
            CALL(asm_pop_temp_operand);
            cmp8(MB(di + 0x12), 0x65);
            if (zf)
                ASM_FAIL_FIELD_IDENT();
            cx = MW(di + 0x0C);
            if (cx)
                MW(si + 0x0C) = 0;
            CALL(asm_add_operands);
            sp += 0x14;
            continue;
        }
        cmp8(DH, 0x5B);
        if (!zf)
            cmp8(DH, 0x28);
        if (!zf)
            return;
        /* "[...]" or "(...)" after a term: added to it, a size given inside wins */
        CALL(asm_push_temp_operand);
        CALL(asm_expr_bracketed);
        CALL(asm_pop_temp_operand);
        cx = MW(si + 0x0C);
        if (cx)
            MW(di + 0x0C) = 0;
        CALL(asm_add_operands);
        sp += 0x14;
    }
}

/* "(expr)" or "[expr]" ("[...]" is a memory operand), else a primary term */
static void asm_expr_bracketed(void)
{
    bx = ASM_BRACKET_OPS_TABLE;
    CALL(asm_match_operator_table);
    if (zf) {
        asm_expr_primary();
        return;
    }
    push(bx);
    CALL(asm_expr_or_xor);
    asm_run_handler(pop());
}
static void close_paren(void)
{
    ax = (ax & 0xFF00) | 0x29;
    asm_expect_token();
}
static void close_square(void)
{
    CALL(asm_make_memory_operand);
    MB(si + 0x0E) |= 0x40;
    ax = (ax & 0xFF00) | 0x5D;
    asm_expect_token();
}

static void asm_expr_primary(void)
{
    CALL(asm_primary_term);
    asm_next_token();
}

/* the current token as an operand: a register (65h: its size from bp-20h), a number (64h),
   a symbol (6Bh) or a size keyword (66h) */
static void asm_primary_term(void)
{
    MB(si + 0x12) = DH;
    cmp8(DH, 0x65);
    if (zf) {
        ax = BPW(-0x20);
        MW(si + 0x10) = ax;
        SET_LO(ax, dec8(AL));
        if (sf) {
            MW(si + 0x0C) = inc16(MW(si + 0x0C));
            return;
        }
        if (!zf)
            return;
        MW(si + 0x0C) = inc16(MW(si + 0x0C));
        MW(si + 0x0C) = inc16(MW(si + 0x0C));
        return;
    }
    cmp8(DH, 0x64);
    if (zf) {
        /* ASM_TERM_NUMBER */
        MW(si) = BPW(-0x36);
        MW(si + 2) = BPW(-0x34);
        return;
    }
    cmp8(DH, 0x6B);
    if (zf) {
        asm_term_symbol();
        return;
    }
    cmp8(DH, 0x66);
    if (zf) {
        /* ASM_TERM_SIZE_KEYWORD */
        MB(si + 0x12) = 0x64;
        MW(si + 0x0C) = BPW(-0x36);
        return;
    }
    ASM_FAIL_SYNTAX();
}

/* a symbol (DECODE_ASM_SYMBOL's operand at bp-46h..-3Ch): its size, value and the field
   offset pending from a '.', with its fixup; operand -1 is a constant, -2 a register
   variable, -3 a BP-relative local */
static void asm_term_symbol(void)
{
    MB(si + 0x12) = 0x67;
    MW(si + 0x0C) = BPW(-0x3E);
    MW(si) = BPW(-0x42);
    MW(si + 2) = BPW(-0x40);
    MW(si + 4) = BPW(-0x3A);
    MW(si + 6) = BPW(-0x38);
    ax = 0;
    BPW(-0x3A) = 0;
    BPW(-0x38) = 0;
    ax = BPW(-0x46);
    cx = BPW(-0x44);
    cx = inc16(cx);
    if (zf) {
        /* ASM_TERM_SYMBOL_NO_FIXUP */
        cmp16(ax, 0xFFFE);
        if (cf) {
            MB(si + 0x0E) = 4;         /* ASM_TERM_BP_RELATIVE */
            MB(si + 0x0E) |= 0x40;
            return;
        }
        if (zf) {
            MB(si + 0x0E) |= 0x40;
            return;
        }
        MB(si + 0x12) = 0x64;
        return;
    }
    cx = dec16(cx);
    MW(si + 8) = ax;
    MW(si + 0x0A) = cx;
    if (BPB(-0x3C) & 1)
        MB(si + 0x0F) = 0x2E;
    MB(si + 0x0E) |= 0x40;
}

/* the operand at DI copied over the one at SI */
static void asm_copy_operand_from_di(void)
{
    for (int i = 0; i < 0x14; i++)
        MB(si + i) = MB(di + i);
}

/* adds the operand at DI to the one at SI: constants add; a constant added to a segment
   register changes the register number; otherwise both become memory operands, the values
   and field offsets add, at most one may carry a fixup, base and index registers combine
   (not twice the same kind), and a segment override is taken over */
static void asm_add_operands(void)
{
    push(dx);
    int to_memory = 1;
    cmp8(MB(di + 0x12), 0x64);
    if (zf) {
        cmp8(MB(si + 0x12), 0x64);
        if (zf)
            to_memory = 0;
        else if (cmp8(MB(si + 0x12), 0x65), zf && (cmp8(MB(si + 0x10), 4), zf)) {
            ax = MW(di);
            MB(si + 0x11) = (u8)(MB(si + 0x11) + AL);
            MB(si + 0x11) &= 7;
            dx = pop();
            return;
        }
    }
    if (to_memory) {
        CALL(asm_make_memory_operand);
        {
            u16 t = si;
            si = di;
            di = t;
        }
        CALL(asm_make_memory_operand);
        {
            u16 t = si;
            si = di;
            di = t;
        }
    }
    ax = MW(di);
    bx = MW(di + 2);
    MW(si) = add16(MW(si), ax);
    MW(si + 2) = adc16(MW(si + 2), bx);
    ax = MW(di + 4);
    dx = MW(di + 6);
    ax = logic16(ax | dx);
    if (!zf) {
        MW(si + 4) = MW(di + 4);
        MW(si + 6) = MW(di + 6);
    }
    SET_LO(cx, MB(di + 0x13));
    bx = MW(di + 8);
    dx = MW(di + 0x0A);
    ax = logic16(dx | bx);
    if (!zf) {
        MB(si + 0x13) = CL;
        u16 t = MW(si + 8);
        MW(si + 8) = bx;
        bx = t;
        t = MW(si + 0x0A);
        MW(si + 0x0A) = dx;
        dx = t;
        if (logic16(bx | dx), !zf)
            ASM_FAIL_ADD_RELOCATABLES();
    }
    cx = MW(di + 0x0C);
    if (cx) {
        u16 t = MW(si + 0x0C);
        MW(si + 0x0C) = cx;
        cx = t;
    }
    SET_LO(ax, MB(di + 0x0E));
    SET_HI(ax, AL & MB(si + 0x0E));
    MB(si + 0x0E) |= AL;
    if (AH & 0x0F)
        ASM_FAIL_INVALID_REGISTER();
    SET_LO(ax, MB(di + 0x0F));
    if (logic8(AL), !zf) {
        cmp8(MB(si + 0x0F), 0);
        if (sf)
            ASM_FAIL_SYNTAX();
        MB(si + 0x0F) = AL;
    }
    dx = pop();
}

/* the operand at SI as a memory operand: a constant becomes an address; a 16-bit register
   that can address memory (BX, BP, SI, DI) becomes [reg] */
#define ASM_REG_ADDRESS_BITS 0x0745
static void asm_make_memory_operand(void)
{
    cmp8(MB(si + 0x12), 0x64);
    if (!zf) {
        cmp8(MB(si + 0x12), 0x65);
        if (zf) {
            cmp8(MB(si + 0x10), 1);
            if (!zf)
                ASM_FAIL_INVALID_REGISTER();
            bx = 0;
            SET_LO(bx, MB(si + 0x11));
            u8 bits = (u8)(BH + CB(ASM_REG_ADDRESS_BITS + bx));
            SET_HI(bx, bits);
            if (bits & 0x80)
                ASM_FAIL_INVALID_REGISTER();
            MB(si + 0x0E) = BH;
            MW(si + 0x0C) = 0;
        } else {
            cmp8(MB(si + 0x12), 0x67);
            if (!zf)
                ASM_FAIL_MEMORY_REFERENCE();
        }
    }
    MB(si + 0x12) = 0x67;
}

/* ---- operator tables: ZF set when the current token (DH) is none of the table's; else
   BX is the handler (the table's address plus its word) and the next token is read ---- */
static void asm_match_operator_table(void)
{
    cx = bx;
    for (;;) {
        SET_LO(ax, CB(bx));
        bx += 3;
        if (logic8(AL), zf)
            return;
        cmp8(AL, DH);
        if (zf)
            break;
    }
    bx = (u16)(CW(bx - 2) + cx);
    CALL(asm_next_token);
    logic16(bx);
}

/* a temporary operand record on the stack: SI points at it (cleared), the old SI and BX
   are kept under the return address; ASM_POP_TEMP_OPERAND gives them back with DI at the
   record, which the caller drops (add sp,14h) */
static void asm_clear_operand(void)
{
    for (int i = 0; i < 0x14; i += 2)
        MW(si + i) = 0;
    ax = 0;
    cx = 0;
}
static void asm_push_temp_operand(void)
{
    u16 return_address = pop();
    sp -= 0x14;
    ax = sp;
    push(si);
    push(bx);
    {
        u16 t = ax;
        ax = si;
        si = t;
    }
    push(return_address);
    asm_clear_operand();
}
static void asm_pop_temp_operand(void)
{
    ax = pop();
    bx = pop();
    si = pop();
    di = sp;
    push(ax);
}

/* the operand at SI must be a constant (a memory operand without a fixup is accepted by
   ASM_REQUIRE_CONSTANT, only a number by ASM_REQUIRE_IMMEDIATE) */
static void reqconst_no_fixup(void)
{
    ax = MW(si + 8);
    ax = logic16(ax | MW(si + 0x0A));
    if (!zf)
        ASM_FAIL_NOT_CONSTANT();
}
static void asm_require_constant(void)
{
    cmp8(MB(si + 0x12), 0x67);
    if (zf) {
        reqconst_no_fixup();
        return;
    }
    asm_require_immediate();
}
static void asm_require_immediate(void)
{
    cmp8(MB(si + 0x12), 0x64);
    if (!zf)
        ASM_FAIL_NOT_CONSTANT();
    reqconst_no_fixup();
}

/* the current token must be AL (else a syntax error), or ASM_ACCEPT_TOKEN: ZF clear when it
   was and the next one has been read, else ZF set with AX 0 */
static void asm_expect_token(void)
{
    cmp8(AL, DH);
    if (zf) {
        asm_next_token();
        return;
    }
    ASM_FAIL_SYNTAX();
}
static void asm_accept_token(void)
{
    cmp8(AL, DH);
    if (zf) {
        asm_next_token();
        return;
    }
    ax = logic16(0);
}

/* ---- the scanner ---- */
static void asm_scan_word(void);
static void asm_lookup_mnemonic(void);
static void asm_get_punct_token(void);
static void asm_lookup_keyword(void);
static void asm_scan_number_token(void);
static void asm_lookup_c_symbol(void);
static void asm_peek_char(void);
static void asm_advance_char(void);
static void asm_is_word_char(void);
static void asm_is_digit(void);
static void asm_scan_quoted_string(void);
static void asm_hash_table_lookup(void);
static void asm_opcode_table_address(void);
static void asm_keyword_table_address(void);

/* the next token into DH (3Bh, ';', at the end of the statement): a mnemonic (41h, only
   where one is expected, bp-1Bh 1), a punctuation character, a keyword (its class from the
   register table), a number (64h), or a C symbol (6Bh).  ZF is always clear after it, and
   a token 0 comes back as 1 */
static void asm_next_token(void)
{
    SET_HI(dx, 0x3B);
    if (LENGTH != 0) {
        push(si);
        push(di);
        push(bx);
        CALL(asm_scan_word);
        int found = 0;
        if (BPB(-0x1B) == 1) {
            CALL(asm_lookup_mnemonic);
            found = !zf;
        }
        if (!found) {
            CALL(asm_get_punct_token);
            found = !zf;
        }
        if (!found) {
            CALL(asm_lookup_keyword);
            found = !zf;
        }
        if (!found) {
            CALL(asm_scan_number_token);
            found = !zf;
        }
        if (!found && BPB(-0x1B) != 1)
            CALL(asm_lookup_c_symbol);
        bx = pop();
        di = pop();
        si = pop();
    }
    /* sub dh,1 / adc dh,1 */
    if (DH == 0) {
        SET_HI(dx, 1);
        cf = 1;
    } else
        cf = 0;
    zf = 0;
    sf = DH >> 7;
}

/* the next character of the text in AL (AH 0), BX its offset; ZF set at the end (length
   at bp+8 used up, or a 0), which also sets the length to 0 */
static void asm_peek_char(void)
{
    ax = 0;
    cmp16(LENGTH, ax);
    if (JBE) {
        LENGTH = ax;
        return;
    }
    bx = BPW(TEXT_OFF);
    SET_LO(ax, B(MK_FP(BPW(TEXT_SEG), bx)));
    flags8(AL);
    cf = 0;
    if (zf)
        LENGTH = ax;
}
static void asm_advance_char(void)
{
    BPW(TEXT_OFF)++;
    LENGTH--;
    asm_peek_char();
}
/* the next character other than a blank or control character (or above 7Eh) */
static void asm_peek_nonblank_char(void)
{
    for (;;) {
        CALL(asm_peek_char);
        if (zf)
            return;
        cmp8(AL, 0x20);
        if (!JBE) {
            cmp8(AL, 0x7F);
            if (cf)
                return;
        }
        BPW(TEXT_OFF)++;
        LENGTH--;
    }
}

/* CF set for a character of a name (letters, digits, '_', '$', '@', '&', '?') */
static void asm_is_letter(void)
{
    u8 c = AL;
    cf = (u8)(c - 0x5B) + 0x1A > 0xFF;
    if (!cf)
        cf = (u8)((u8)(c - 0x5B + 0x1A) - 0x3A) + 0x1A > 0xFF;
}
static void asm_is_ident_char(void)
{
    CALL(asm_is_letter);
    if (cf)
        return;
    cf = AL == 0x5F || AL == 0x24 || AL == 0x40 || AL == 0x26 || AL == 0x3F;
}
static void asm_is_digit(void)
{
    cf = (u8)(AL - 0x3A) + 0x0A > 0xFF;
}
static void asm_is_word_char(void)
{
    CALL(asm_is_ident_char);
    if (!cf)
        asm_is_digit();
}

/* the next word into bp-6Ch (count byte, then the characters) and, upper-cased, into
   bp-8Eh (the form the tables are searched with), its hash (the sum of the characters
   less 1 each) at bp-23h; bp-19h: 1 a word, 2 a string (at bp-10Eh), 0 punctuation.  A
   ';', '{', "(*" or the word END ends the statement (the token ';') */
#define WORD_TEXT (-0x6C)
#define WORD_UPPER (-0x8E)
static void scanword_end_statement(void)
{
    BPB(-0x19) = 0;
    BPW(WORD_TEXT) = 0x3B01;
    LENGTH = 0;
    BPW(TEXT_OFF) = BPW(SAVED_TEXT);
}
static void asm_scan_word(void)
{
    ax = 0;
    BPW(WORD_TEXT) = 0;
    BPW(WORD_UPPER) = 0;
    BPB(-0x23) = 0;
    CALL(asm_peek_nonblank_char);
    BPW(SAVED_TEXT) = bx;
    if (zf) {
        scanword_end_statement();
        return;
    }
    CALL(asm_is_word_char);
    if (cf) {
        do {
            si = BPW(WORD_TEXT) & 0xFF;
            if (si != 0x20) {
                BPB(WORD_TEXT)++;
                BPB(WORD_UPPER)++;
                MW(bp + si - 0x6B) = ax;
                if (AL >= 0x61)
                    SET_LO(ax, AL & 0x5F);
                MW(bp + si - 0x8D) = ax;
                ax--;
                BPB(-0x23) = (u8)(BPB(-0x23) + AL);
            }
            CALL(asm_advance_char);
            if (zf)
                break;
            CALL(asm_is_word_char);
        } while (cf);
        BPB(-0x19) = 1;
        if (BPW(WORD_UPPER) == 0x4503 && BPW(WORD_UPPER + 2) == 0x444E)
            scanword_end_statement();
        return;
    }
    BPB(-0x19) = 2;
    CALL(asm_scan_quoted_string);
    if (zf)
        return;
    BPB(-0x19) = 0;
    BPB(WORD_TEXT)++;
    BPW(WORD_TEXT + 1) = ax;
    if (AL == 0x3B || AL == 0x7B) {
        scanword_end_statement();
        return;
    }
    {
        u16 t = ax;
        ax = dx;
        dx = t;
    }
    CALL(asm_advance_char);
    SET_HI(ax, DL);
    if (ax == 0x282A)
        scanword_end_statement();
}

/* a string in quotes (' or "), a doubled quote standing for itself, into bp-10Eh (at most
   127 characters); ZF set after one, ZF clear (from the compare) for another character */
static void asm_scan_quoted_string(void)
{
    SET_LO(cx, AL);
    cmp8(AL, 0x27);
    if (!zf)
        cmp8(AL, 0x22);
    if (!zf)
        return;
    BPB(STRING_LITERAL) = 0;
    for (;;) {
        CALL(asm_advance_char);
        if (zf)
            ASM_FAIL_STRING_TOO_LONG();
        if (AL == CL) {
            CALL(asm_advance_char);
            if (AL != CL) {
                ax = logic16(0);
                return;
            }
        }
        si = BPW(STRING_LITERAL) & 0xFF;
        if (si == 0x7F)
            ASM_FAIL_STRING_TOO_LONG();
        BPB(STRING_LITERAL)++;
        MB(bp + si + STRING_LITERAL + 1) = AL;
    }
}

/* a C name: "&name" drops the '&'; DECODE_ASM_SYMBOL (asmopnd.c) decodes the coded name
   into the record at bp-4Ah (the field offset pending from a '.' kept in its first long);
   an error stops the statement with DECODE_ASM_SYMBOL's code */
static void asm_lookup_c_symbol(void)
{
    bx = (u16)(bp + WORD_TEXT);
    ax = MW(bx);
    if (AH == 0x26) {
        bx++;
        SET_LO(ax, dec8(AL));
        if (zf)
            ASM_FAIL_SYNTAX();
        MB(bx) = AL;
    }
    BPW(-0x4A) = BPW(-0x3A);
    BPW(-0x48) = BPW(-0x38);
    far_result((u16)DECODE_ASM_SYMBOL(MK_FP(DGROUP, bx), MK_FP(DGROUP, (u16)(bp - 0x4A))));
    if (!zf)
        asm_rewind_and_exit();
    BPW(-0x3A) = BPW(-0x4A);
    BPW(-0x38) = BPW(-0x48);
    SET_HI(dx, 0x6B);
}

/* a one-character punctuation token: DH the character (ZF clear), else DX 0 (ZF set) */
static void asm_get_punct_token(void)
{
    if (BPB(-0x19) == 0) {
        dx = BPW(WORD_TEXT);
        if (DL == 1) {
            logic8(DH);
            return;
        }
    }
    dx = 0;
    logic8(DH);
}

/* ---- numbers: B/O/D/H suffixes, '$' for hex, a string of up to 4 characters ---- */
static void mul32_by_2(void)
{
    dx = add16(dx, dx);
    di = adc16(di, di);
    if (cf)
        ASM_FAIL_NUMBER_OVERFLOW();
}
static void mul32_by_4(void)
{
    CALL(mul32_by_2);
    mul32_by_2();
}
static void mul32_by_8(void)
{
    CALL(mul32_by_2);
    mul32_by_4();
}
static void mul32_by_16(void)
{
    CALL(mul32_by_2);
    mul32_by_8();
}
/* times 10: twice the value plus eight times it; the original adds the low words without
   carrying into the high words */
static void mul32_by_10(void)
{
    push(ax);
    CALL(mul32_by_2);
    push(di);
    push(dx);
    CALL(mul32_by_4);
    ax = pop();
    dx = add16(dx, ax);
    ax = pop();
    di = add16(di, ax);
    if (cf)
        ASM_FAIL_NUMBER_OVERFLOW();
    ax = pop();
}
static void accdigit_add(void)
{
    if (!cf)
        ASM_FAIL_BAD_DIGIT();
    dx = add16(dx, ax);
    di = adc16(di, 0);
    if (cf)
        ASM_FAIL_NUMBER_OVERFLOW();
}
#define ACC_BINARY 0x0A0C
#define ACC_OCTAL 0x0A16
#define ACC_DECIMAL 0x0A20
#define ACC_HEX 0x0A2A
static void accumulate_digit(u16 accumulator)
{
    u8 r;
    switch (accumulator) {
    case ACC_BINARY:
        CALL(mul32_by_2);
        r = (u8)(AL - '2');
        cf = (unsigned)r + 2 > 0xFF;
        SET_LO(ax, (u8)(r + 2));
        break;
    case ACC_OCTAL:
        CALL(mul32_by_8);
        r = (u8)(AL - '8');
        cf = (unsigned)r + 8 > 0xFF;
        SET_LO(ax, (u8)(r + 8));
        break;
    case ACC_DECIMAL:
        CALL(mul32_by_10);
        r = (u8)(AL - ':');
        cf = (unsigned)r + 10 > 0xFF;
        SET_LO(ax, (u8)(r + 10));
        break;
    default:
        CALL(mul32_by_16);
        r = AL;
        if (r >= ':')
            r = (u8)(r - 7);
        r = (u8)(r - 0x40);
        cf = (unsigned)r + 0x10 > 0xFF;
        SET_LO(ax, (u8)(r + 0x10));
        break;
    }
    accdigit_add();
}

static void literal_store(void)
{
    BPW(-0x36) = dx;
    BPW(-0x34) = di;
    SET_HI(dx, 0x64);
    logic8(DH);
}

/* a string as a number: its characters packed, the last in the low byte */
static void asm_convert_literal(void)
{
    si = (u16)(bp + STRING_LITERAL);
    ax = 0;
    di = 0;
    dx = 0;
    SET_LO(ax, MB(si));
    si++;
    {
        u16 t = ax;
        ax = cx;
        cx = t;
    }
    while (cx) {
        di &= 0xFF;
        CALL(mul32_by_16);
        CALL(mul32_by_16);
        SET_LO(ax, MB(si));
        si++;
        SET_LO(dx, AL);
        cx--;
    }
    literal_store();
}

static void asm_scan_number_token(void)
{
    cmp8(BPB(-0x19), 1);
    if (JA) {
        asm_convert_literal();
        return;
    }
    if (!zf) {
        ax = logic16(0);
        return;
    }
    /* ASM_LITERAL_WORD */
    BPB(STRING_LITERAL) = 0;
    cx = BPB(WORD_UPPER);
    ax = MW(bp + WORD_UPPER + 1);
    si = 1;
    if (AL != 0x24) {
        si = 0;
        CALL(asm_is_digit);
        if (!cf) {
            ax = logic16(0);
            return;
        }
        di = cx;
        SET_LO(ax, MB(bp + di + WORD_UPPER));
        CALL(asm_is_digit);
        bx = ACC_DECIMAL;
        if (!cf) {
            cx--;
            if (AL == 'D')
                bx = ACC_DECIMAL;
            else if (AL == 'B')
                bx = ACC_BINARY;
            else if (AL == 'O')
                bx = ACC_OCTAL;
            else if (AL == 'H') {
                cx = (u16)(cx - si);
                bx = ACC_HEX;
            } else
                ASM_FAIL_BAD_DIGIT();
        }
    } else {
        cx = (u16)(cx - si);
        bx = ACC_HEX;
    }
    di = 0;
    dx = 0;
    while (cx) {
        cx--;
        si++;
        ax = MB(bp + si + WORD_UPPER);
        push(0);
        accumulate_digit(bx);
        sp += 2;
    }
    literal_store();
}

/* ---- the tables: an opcode or keyword table starts with a mask word and bucket heads;
   an entry is a link word, then the counted name, then the entry's data ---- */
static void asm_lookup_mnemonic(void)
{
    CALL(asm_opcode_table_address);
    CALL(asm_hash_table_lookup);
    if (zf)
        return;
    BPW(LOOKUP_ENTRY) = di;
    SET_HI(dx, 0x41);
}
static void asm_lookup_keyword(void)
{
    CALL(asm_keyword_table_address);
    CALL(asm_hash_table_lookup);
    if (zf)
        return;
    SET_HI(dx, CB(di));
    di++;
    ax = CW(di);
    BPW(-0x20) = ax;
    BPW(-0x36) = ax;
    ax = (ax & 0x8000) ? 0xFFFF : 0;     /* add ax,ax / sbb ax,ax */
    BPW(-0x34) = ax;
    ax = dec16(ax);
}
/* the table at DI searched for the word at bp-8Eh (only for a word, bp-19h 1); DI the
   entry's data with ZF clear, or DI 0 with ZF set */
static void asm_hash_table_lookup(void)
{
    if (BPB(-0x19) == 1) {
        SET_LO(bx, (u8)(BPB(-0x23) * 2));
        bx &= CW(di);
        bx = CW(bx + di + 2);
        if (bx != 0) {
            ax = (u16)(bp + WORD_UPPER);
            dx = (u16)(BPB(WORD_UPPER) + 1);
            do {
                di = (u16)(bx + 2);
                si = ax;
                cx = dx;
                zf = 1;
                while (cx) {
                    u8 a = MB(si), b = CB(di);
                    si++;
                    di++;
                    cx--;
                    if (a != b) {
                        zf = 0;
                        break;
                    }
                }
                if (zf) {
                    logic16(di);
                    return;
                }
                bx = CW(bx);
            } while (bx);
        }
    }
    di = 0;
    logic16(di);
}

/* ---- 32-bit arithmetic: DX:AX times or divided by BX:CX ---- */
static void asm_mul32(void)
{
    push(si);
    push(di);
    si = ax;
    di = dx;
    u32 product = (u32)ax * cx;             /* low times low */
    push((u16)product);
    push((u16)(product >> 16));
    product = (u32)si * bx;                 /* low times high */
    ax = bx;
    bx = (u16)product;
    {
        u16 t = ax;
        ax = di;                            /* high times low */
        di = t;
    }
    product = (u32)ax * cx;
    ax = (u16)product;
    dx = pop();
    dx = (u16)(dx + bx);
    dx = (u16)(dx + ax);
    ax = pop();
    di = pop();
    si = pop();
}

/* signed: the quotient in DX:AX, the remainder (with the dividend's sign) in BX:CX; a
   divisor 0 is "divide by zero" */
static void asm_div32(void)
{
    push(si);
    push(di);
    push(bp);
    if ((cx | bx) == 0)
        ASM_FAIL_DIVIDE_BY_ZERO();
    int divisor_negative = bx >> 15;
    push(0);                    /* pushf */
    if (divisor_negative) {
        cx = neg16(cx);
        bx = adc16(bx, 0);
        bx = neg16(bx);
    }
    int dividend_negative = dx >> 15;
    push(0);                    /* pushf */
    if (dividend_negative) {
        ax = neg16(ax);
        dx = adc16(dx, 0);
        dx = neg16(dx);
    }
    si = cx;
    di = bx;
    cx = 0;
    bx = logic16(0);            /* xor bx,bx: the carry clear */
    for (u16 count = 0x21; count; count--) {
        unsigned out = cx >> 15;
        cx = (u16)(cx << 1 | cf);
        unsigned out2 = bx >> 15;
        bx = (u16)(bx << 1 | out);
        cf = out2;
        cx = sub16(cx, si);
        bx = sbb16(bx, di);
        if (cf) {
            cx = add16(cx, si);
            bx = adc16(bx, di);
        }
        cf = !cf;
        out = ax >> 15;
        ax = (u16)(ax << 1 | cf);
        out2 = dx >> 15;
        dx = (u16)(dx << 1 | out);
        cf = out2;
    }
    sp += 2;                    /* popf: the dividend's sign */
    if (dividend_negative) {
        cx = neg16(cx);
        bx = adc16(bx, 0);
        bx = neg16(bx);
        sp += 2;
        if (!divisor_negative) {
            ax = neg16(ax);
            dx = adc16(dx, 0);
            dx = neg16(dx);
        }
    } else {
        sp += 2;
        if (divisor_negative) {
            ax = neg16(ax);
            dx = adc16(dx, 0);
            dx = neg16(dx);
        }
    }
    bp = pop();
    di = pop();
    si = pop();
}

/* ---- instruction encoding ---- */
static void asm_opcode_byte_count(void);
static void asm_flush_pending_opcode(void);
static void asm_begin_opcode(void);
static void asm_emit_modrm(void);
static void asm_is_word_rm(void);
static void asm_decode_rm_operand(void);
static void asm_emit_modrm_form_reg(void);
static void asm_queue_byte(void);
static void asm_queue_word(void);
static void asm_is_byte_or_word_rm(void);
static void asm_emit_imm16(void);
static void asm_emit_imm8(void);
static void asm_is_imm_zero(void);
static void asm_imm_fits_signed_byte(void);
static void asm_set_modrm_reg_from_di(void);
static void asm_set_modrm_reg_field(void);
static void asm_emit_modrm_no_size(void);
static void asm_is_direct_address(void);
static void asm_emit_displacement(void);
static void asm_emit_modrm_bytes(void);
static void asm_run_form(u16 handler);

#define ASM_FORM_HANDLER_TABLE 0x1354

static void swap_si_di(void)
{
    u16 t = si;
    si = di;
    di = t;
}
static void swap_al_ah(void)
{
    ax = (u16)(ax >> 8 | ax << 8);
}

/* tries the forms of the mnemonic (bp-1Eh: its entries in the opcode table, each a form
   word, the operand count in its top two bits, a handler index, and the opcode bytes)
   until one takes the operands (ZF set); none is "invalid combination" or, with two
   operands of other sizes, "operand size mismatch".  A form flagged 4 needs the 286
   (mode bits 0-1 at bp+6) */
static void asm_encode_instruction(void)
{
    for (;;) {
        ax = 0;
        BPW(EMIT_COUNT) = 0;
        BPB(-0x25) = 0;
        BPB(-0x2D) = 0;
        BPB(-0x2E) = 0;
        bx = BPW(LOOKUP_ENTRY);
        bx = CW(bx);
        SET_LO(cx, 6);
        SET_HI(bx, BH >> 6);
        cmp8(BH, BPB(-0x1C));
        if (zf) {
            si = (u16)(bp + OPERAND1);
            di = (u16)(bp + OPERAND2);
            SET_HI(ax, MB(si + 0x12));
            SET_LO(ax, MB(di + 0x12));
            bx &= 0x7E;
            push(0);
            asm_run_form(bx >> 1);      /* call cs:ASM_FORM_HANDLER_TABLE[bx] */
            sp += 2;
            if (zf) {
                bx = BPW(LOOKUP_ENTRY);
                if ((CB(bx + 1) & 4) && !((u8)arg_mode & 3)) {
                    BPW(SAVED_TEXT) = BPW(-0x16);
                    ASM_FAIL_NEEDS_286_287();
                }
                asm_flush_pending_opcode();
                return;
            }
        }
        CALL(asm_opcode_byte_count);
        if (!(CB(bx) & 0x80))
            break;
        ax = (u16)(ax + 2);
        BPW(LOOKUP_ENTRY) = (u16)(BPW(LOOKUP_ENTRY) + ax);
    }
    ax = BPW(-0x16);
    cmp8(BPB(-0x1C), 1);
    int not_two = JLE;
    if (!not_two)
        ax = BPW(-0x18);
    BPW(SAVED_TEXT) = ax;
    if (!not_two && MW(bp - 0x18A) != MW(bp - 0x19E))
        ASM_FAIL_SIZE_COMBINATION();
    ASM_FAIL_BAD_COMBINATION();
}

/* the form handlers: SI the first operand, DI the second, AH and AL their kinds */
static void form_no_operands(void)
{
    CALL(asm_begin_opcode);
    ax = logic16(0);
}
static void form_reject(void)
{
    ASM_FAIL_SYNTAX();
}
static void form_near_indirect(void)
{
    CALL(asm_is_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_emit_modrm);
}
static void form_far_indirect(void)
{
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    cmp8(AL, 0xFF);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_emit_modrm);
}
/* a short jump to a label: the record 2 (ASM_FLUSH_KIND2_STUB) with the label */
static void form_short_jump(void)
{
    cmp8(AH, 0x67);
    if (!zf)
        return;
    cmp16(MW(si + 0x0C), 0xFFFD);
    if (!zf)
        return;
    ax = MW(si);
    ax = logic16(ax | MW(si + 2));
    if (!zf)
        return;
    CALL(asm_emit_prefix_list);
    CALL(asm_opcode_byte_count);
    SET_LO(cx, CB(bx + 2));
    bx = 2;
    MW(bp - 0x182) = MW(si + 8);
    MW(bp - 0x180) = MW(si + 0x0A);
    CALL(asm_queue_emit_record);
}
/* a near (size -3) or far (size -2) direct jump or call to a symbol in memory: the opcode
   byte, then the target as a fixup record (form 0 near, 3 far) */
static void dirjmp_check_size(void)
{
    cmp16(MW(si + 0x0C), cx);
    if (!zf)
        return;
    cmp8(AH, 0x67);
    if (!zf)
        return;
    cmp8(MB(si + 0x0E), 0x40);
    if (!zf)
        return;
    push(bx);
    CALL(asm_emit_prefix_list);
    CALL(asm_opcode_byte_count);
    SET_LO(cx, CB(bx + 2));
    SET_LO(bx, 0);
    CALL(asm_queue_emit_record);
    bx = pop();
    SET_LO(bx, 1);
    cx = MW(si);
    dx = MW(si + 2);
    MW(bp - 0x182) = MW(si + 8);
    MW(bp - 0x180) = MW(si + 0x0A);
    CALL(asm_queue_emit_record);
}
static void form_direct_jump(void)
{
    SET_HI(bx, 0);
    cx = 0xFFFD;
    cmp16(MW(si + 0x0C), cx);
    if (!zf)
        SET_LO(cx, 0xFF);
    dirjmp_check_size();
}
static void form_direct_jump_far(void)
{
    SET_HI(bx, 3);
    cx = 0xFFFE;
    dirjmp_check_size();
}
/* shifts and rotates: by 1, by CL, or (286) by an 8-bit count */
static void form_shift_rotate(void)
{
    CALL(asm_is_byte_or_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_imm_fits_byte);
    if (zf) {
        cmp8(AL, 1);
        if (zf) {
            CALL(asm_emit_modrm_form_reg);
            return;
        }
        if (!((u8)arg_mode & 3))
            ASM_FAIL_NEEDS_286_287();
        BPB(-0x24) = (u8)(BPB(-0x24) - 0x10);
        push(ax);
        CALL(asm_emit_modrm_form_reg);
        ax = pop();
        CALL(asm_queue_byte);
        return;
    }
    cmp8(MB(di + 0x12), 0x65);
    if (!zf)
        return;
    cmp16(MW(di + 0x10), 0x100);
    if (!zf)
        return;
    BPB(-0x24) = (u8)(BPB(-0x24) + 2);
    CALL(asm_emit_modrm_form_reg);
}
/* xchg of AX with a 16-bit register: the one-byte form */
static void xchgax_no_swap(void)
{
    cmp16(ax, 0x6565);
    if (!zf)
        return;
    cmp16(MW(si + 0x10), 1);
    if (!zf)
        return;
    cmp8(MB(di + 0x10), 1);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    SET_LO(ax, MB(di + 0x11));
    BPB(-0x24) |= AL;
    ax = logic16(0);
}
static void form_xchg_reg16_ax(void)
{
    swap_al_ah();
    swap_si_di();
    xchgax_no_swap();
}
static void form_enter(void)
{
    swap_si_di();
    CALL(asm_begin_opcode);
    CALL(asm_emit_imm16);
    if (!zf)
        return;
    swap_si_di();
    CALL(asm_emit_imm8);
}
/* ret and retf (mode bit 8 at bp+7 bit 0 makes a plain ret far), with a pop count */
static void ret_check_pop_count(void)
{
    di = si;
    BPB(-0x24) |= 1;
    CALL(asm_is_imm_zero);
    if (zf)
        return;
    BPB(-0x24) &= 0xFE;
    asm_emit_imm16();
}
static void form_return(void)
{
    CALL(asm_begin_opcode);
    if ((u8)(arg_mode >> 8) & 1)
        BPB(-0x24) |= 8;
    cmp8(BPB(-0x1C), 0);
    if (zf)
        return;
    ret_check_pop_count();
}
static void form_return_with_imm(void)
{
    CALL(asm_begin_opcode);
    ret_check_pop_count();
}
static void form_imm16_operand(void)
{
    CALL(asm_begin_opcode);
    swap_si_di();
    asm_emit_imm16();
}
static void form_imm8_operand(void)
{
    swap_si_di();
    CALL(asm_begin_opcode);
    CALL(asm_imm_fits_signed_byte);
    if (!zf)
        return;
    CALL(asm_queue_byte);
}
/* imul reg16, r/m16, imm (286): the short form 6Bh for a signed byte */
static void form_imul_immediate(void)
{
    cmp8(AH, 0x65);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 1);
    if (!zf)
        return;
    swap_si_di();
    CALL(asm_is_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_from_di);
    di = (u16)(bp + OPERAND3);
    CALL(asm_check_imm_fits_word);
    if (!zf)
        return;
    CALL(asm_imm_fits_signed_byte);
    unsigned fits = zf;
    push(0);                    /* pushf */
    if (fits)
        BPB(-0x24) |= 2;
    push(ax);
    CALL(asm_emit_modrm_no_size);
    ax = pop();
    sp += 2;                    /* popf */
    zf = fits;
    if (fits) {
        asm_queue_byte();
        return;
    }
    CALL(asm_queue_word);
}
static void form_lea(void)
{
    cmp16(ax, 0x6567);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 1);
    if (!zf)
        return;
    swap_si_di();
    CALL(asm_decode_rm_operand);
    swap_si_di();
    if (!zf)
        return;
    BPB(-0x2E) = 0;
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_field);
    CALL(asm_emit_modrm_no_size);
}
/* in and out: the opcode when the register operand is the accumulator (AL or AX) */
static void asm_emit_opcode_if_acc(void)
{
    cmp8(AH, 0x65);
    if (!zf)
        return;
    cmp8(MB(si + 0x11), 0);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    SET_LO(ax, MB(si + 0x10));
    cmp8(AL, 1);
    if (JA)
        return;
    BPB(-0x24) |= AL;
    ax = logic16(0);
}
static void outimm_no_swap(void)
{
    CALL(asm_emit_opcode_if_acc);
    if (!zf)
        return;
    CALL(asm_emit_imm8);
}
static void form_out_imm8_acc(void)
{
    swap_si_di();
    swap_al_ah();
    outimm_no_swap();
}
static void outdx_no_swap(void)
{
    cmp8(AL, 0x65);
    if (!zf)
        return;
    cmp16(MW(di + 0x10), 0x201);
    if (!zf)
        return;
    CALL(asm_emit_opcode_if_acc);
}
static void form_out_dx_acc(void)
{
    swap_si_di();
    swap_al_ah();
    outdx_no_swap();
}
/* int n (int 3 the one-byte form) */
static void form_int(void)
{
    CALL(asm_begin_opcode);
    di = si;
    CALL(asm_imm_fits_byte);
    if (!zf)
        return;
    cmp8(AL, 3);
    if (zf)
        return;
    BPB(-0x24)++;
    CALL(asm_queue_byte);
}
/* mov segment register, r/m (or the other way, MOVSREG_NO_SWAP); mov cs,... is refused */
static void movsreg_no_swap(void)
{
    cmp8(AL, 0x65);
    if (!zf)
        return;
    cmp8(MB(di + 0x10), 2);
    if (!zf)
        return;
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    cmp8(AL, 1);
    if (!zf) {
        cmp16(MW(si + 0x0C), 0);
        if (!zf)
            return;
    }
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_from_di);
    CALL(asm_emit_modrm_no_size);
}
static void form_mov_sreg_rm(void)
{
    swap_al_ah();
    swap_si_di();
    SET_LO(bx, MB(di + 0x11));
    u8 r = (u8)(BL - 1);
    cf = BL < 1;
    SET_LO(bx, r);
    flags8(r);
    if (zf) {
        bx = dec16(bx);
        return;
    }
    movsreg_no_swap();
}
/* mov register, immediate: the short forms B0h+reg and B8h+reg */
static void form_mov_reg_imm(void)
{
    cmp16(ax, 0x6564);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 1);
    if (JA)
        return;
    CALL(asm_begin_opcode);
    SET_LO(ax, MB(si + 0x11));
    BPB(-0x24) |= AL;
    cmp8(MB(si + 0x10), 0);
    if (zf) {
        CALL(asm_emit_imm8);
        return;
    }
    BPB(-0x24) |= 8;
    asm_emit_imm16();
}
static void form_unary_rm(void)
{
    CALL(asm_is_byte_or_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_emit_modrm_form_reg);
}
/* mov accumulator, [address] (or the other way): the short forms A0h-A3h */
static void movmoffs_no_swap(void)
{
    cmp16(ax, 0x6765);
    if (!zf)
        return;
    cmp8(MB(di + 0x11), 0);
    if (!zf)
        return;
    CALL(asm_is_direct_address);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    SET_LO(ax, MB(di + 0x10));
    cmp8(AL, 1);
    if (JA)
        return;
    cmp8(AL, BPB(-0x2C));
    if (!zf)
        return;
    BPB(-0x24) |= AL;
    CALL(asm_emit_displacement);
}
static void form_mov_acc_moffs(void)
{
    swap_al_ah();
    swap_si_di();
    movmoffs_no_swap();
}
/* test and xchg: register and r/m in either order */
static void testxchg_try_order(void)
{
    cmp8(AL, 0x65);
    if (!zf)
        return;
    cmp8(MB(di + 0x10), 1);
    if (JA)
        return;
    CALL(asm_is_byte_or_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_from_di);
    SET_LO(ax, MB(di + 0x10));
    cmp8(AL, BPB(-0x2C));
    if (!zf)
        return;
    CALL(asm_emit_modrm_bytes);
}
static void form_test_xchg_rm(void)
{
    push(ax);
    CALL(testxchg_try_order);
    ax = pop();
    if (zf)
        return;
    swap_si_di();
    swap_al_ah();
    testxchg_try_order();
}
static void form_lds_les(void)
{
    cmp16(ax, 0x6567);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 1);
    if (!zf)
        return;
    swap_si_di();
    CALL(asm_decode_rm_operand);
    cmp16(BPW(-0x22), 0);
    if (!zf) {
        cmp8(AL, 0xFF);
        if (!zf)
            return;
    }
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_from_di);
    CALL(asm_emit_modrm_no_size);
}
static void larlsl_no_swap(void)
{
    cmp8(AL, 0x65);
    if (!zf)
        return;
    cmp8(MB(di + 0x10), 1);
    if (!zf)
        return;
    CALL(asm_is_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_from_di);
    CALL(asm_emit_modrm_no_size);
}
static void form_lar_lsl(void)
{
    swap_si_di();
    swap_al_ah();
    larlsl_no_swap();
}
static void form_descriptor_mem(void)
{
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    cmp16(MW(si + 0x0C), 6);
    if (!zf) {
        cmp16(MW(si + 0x0C), 0);
        if (!zf)
            return;
    }
    CALL(asm_begin_opcode);
    CALL(asm_emit_modrm);
}
/* register and r/m in either order (bp-2Dh 2 when the register is the first operand) */
static void rmreg_reg_in_di(void)
{
    cmp8(MB(di + 0x10), 1);
    if (JA)
        return;
    CALL(asm_is_byte_or_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_set_modrm_reg_from_di);
    SET_LO(ax, MB(di + 0x10));
    cmp8(AL, BPB(-0x2C));
    if (!zf)
        return;
    CALL(asm_emit_modrm_bytes);
}
static void form_rm_reg(void)
{
    cmp8(AL, 0x65);
    if (!zf) {
        cmp8(AH, 0x65);
        if (!zf)
            return;
        BPB(-0x2D) = 2;
        swap_si_di();
    }
    rmreg_reg_in_di();
}
static void form_rm16(void)
{
    CALL(asm_is_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_emit_modrm);
}
/* alu r/m, immediate: 83h for a word with a signed-byte immediate */
static void form_alu_rm_imm(void)
{
    CALL(asm_check_imm_fits_word);
    if (!zf)
        return;
    CALL(asm_is_byte_or_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    cmp8(BPB(-0x2C), 0);
    if (!zf) {
        CALL(asm_imm_fits_signed_byte);
        if (!zf) {
            CALL(asm_emit_modrm_form_reg);
            if (!zf)
                return;
            CALL(asm_emit_imm16);
            return;
        }
        BPB(-0x24) |= 2;
    }
    CALL(asm_imm_fits_byte);
    if (!zf)
        return;
    CALL(asm_emit_modrm_form_reg);
    if (!zf)
        return;
    CALL(asm_emit_imm8);
}
static void form_rm_imm(void)
{
    cmp8(AL, 0x64);
    if (!zf)
        return;
    CALL(asm_is_byte_or_word_rm);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_emit_modrm_form_reg);
    cmp8(BPB(-0x2C), 1);
    if (zf)
        asm_emit_imm16();
    else
        asm_emit_imm8();
}
/* alu accumulator, immediate: the short forms */
static void form_acc_imm(void)
{
    cmp16(ax, 0x6564);
    if (!zf)
        return;
    CALL(asm_check_imm_fits_word);
    if (!zf)
        return;
    cmp8(MB(si + 0x11), 0);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 1);
    if (JA)
        return;
    if (zf) {
        CALL(asm_begin_opcode);
        BPB(-0x24)++;
        CALL(asm_emit_imm16);
        return;
    }
    CALL(asm_imm_fits_byte);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    CALL(asm_emit_imm8);
}
static void form_reg16_in_opcode(void)
{
    cmp8(AH, 0x65);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 1);
    if (!zf)
        return;
    CALL(asm_begin_opcode);
    SET_LO(ax, MB(si + 0x11));
    BPB(-0x24) |= AL;
    ax = logic16(0);
}
/* push and pop of a segment register (pop cs refused: CL 1; the other entry takes any) */
static void ppsreg_check(void)
{
    cmp8(AH, 0x65);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 2);
    if (!zf)
        return;
    cmp8(MB(si + 0x11), CL);
    if (zf) {
        ax = inc16(ax);
        return;
    }
    CALL(asm_begin_opcode);
    SET_LO(ax, (u8)(MB(si + 0x11) << 3));
    SET_LO(cx, 3);
    BPB(-0x24) |= AL;
    ax = logic16(0);
}
static void form_push_pop_sreg(void)
{
    SET_LO(cx, 1);
    ppsreg_check();
}
static void form_push_pop_any_sreg(void)
{
    SET_LO(cx, 0xFF);
    ppsreg_check();
}
/* an x87 opcode: the prefix list, then the opcode bytes as one record 3 (a byte below 2 in
   front gives the emulator flag; a WAIT, 9Bh, clears it) with the low bits of DL in the
   first byte; without the 287 (mode bits 0-1) the emulator flag is set */
static void emit_fpu_opcode_bits(void)
{
    {
        u16 t = ax;
        ax = dx;
        dx = t;
    }
    CALL(asm_emit_prefix_list);
    CALL(asm_opcode_byte_count);
    SET_HI(dx, 0);
    if (!((u8)arg_mode & 3))
        SET_HI(dx, 1);
    for (;;) {
        cx = CW(bx + 2);
        cmp8(CL, 1);
        if (JA)
            break;
        SET_HI(dx, CL);
        bx++;
        ax = dec16(ax);
    }
    if (CL == 0x9B)
        SET_HI(dx, 0);
    SET_LO(cx, CL | DL);
    SET_HI(ax, CH);
    SET_LO(bx, 3);
    SET_HI(bx, BPB(-0x2E));
    BPB(-0x2E) = 0;
    SET_HI(bx, BH | DH);
    CALL(asm_queue_emit_record);
    ax = dec16(ax);
    BPB(-0x25) = AL;
    BPB(-0x24) = AH;
    ax = logic16(0);
}
static void asm_emit_fpu_opcode(void)
{
    SET_LO(ax, 0);
    emit_fpu_opcode_bits();
}
static void form_fstsw_ax(void)
{
    cmp8(AH, 0x65);
    if (!zf)
        return;
    cmp16(MW(si + 0x10), 1);
    if (!zf)
        return;
    asm_emit_fpu_opcode();
}
/* x87 with a memory operand of a given size: CH the size of the plain form, CL the size of
   the form with bit 2 in the opcode (FDh FDh tbyte, FEh FEh qword, FFh/01h dword or word,
   01h 01h word (an unsized operand taken as a word), FFh FEh dword or qword) */
static void fpumem_check_operand(void)
{
    cmp8(AH, 0x67);
    if (!zf)
        return;
    push(cx);
    CALL(asm_decode_rm_operand);
    cx = pop();
    if (!zf)
        return;
    SET_LO(ax, 0);
    cmp8(BPB(-0x2C), CH);
    if (!zf) {
        cmp8(BPB(-0x2C), CL);
        if (!zf)
            return;
        SET_LO(ax, AL | 4);
    }
    CALL(emit_fpu_opcode_bits);
    CALL(asm_emit_modrm);
}
static void form_fpu_mem_sized(void)
{
    cx = 0xFDFD;
    fpumem_check_operand();
}
static void form_fpu_mem_qword_only(void)
{
    cx = 0xFEFE;
    fpumem_check_operand();
}
static void form_fpu_mem_word_or_dword(void)
{
    cx = 0xFF01;
    fpumem_check_operand();
}
static void form_fpu_mem_word_only(void)
{
    cmp16(MW(si + 0x0C), 0);
    if (zf)
        MW(si + 0x0C) = 2;
    cx = 0x101;
    fpumem_check_operand();
}
static void form_fpu_mem_dword_or_qword(void)
{
    cx = 0xFFFE;
    fpumem_check_operand();
}
/* fldenv/fstenv (14 bytes) and fsave/frstor (94 bytes) */
static void fpuenv_check_size(void)
{
    cmp16(MW(si + 0x0C), cx);
    if (!zf) {
        cmp16(MW(si + 0x0C), 0);
        if (!zf)
            return;
    }
    cmp8(AH, 0x67);
    if (!zf)
        return;
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    CALL(asm_emit_fpu_opcode);
    CALL(asm_emit_modrm);
}
static void form_fpu_env_mem(void)
{
    cx = 0x0E;
    fpuenv_check_size();
}
static void form_fpu_save_mem(void)
{
    cx = 0x5E;
    fpuenv_check_size();
}
/* x87 with ST(i): alone, ST(i) and ST, or ST and ST(i) */
static void fpusti_check_reg(void)
{
    cmp16(ax, 0x6565);
    if (!zf)
        return;
    cmp8(MB(si + 0x10), 4);
    if (!zf)
        return;
    CALL(asm_emit_fpu_opcode);
    SET_LO(ax, MB(si + 0x11));
    BPB(-0x24) |= AL;
    ax = logic16(0);
}
static void fpusti_st_second(void)
{
    cmp16(MW(di + 0x10), 4);
    if (!zf)
        return;
    fpusti_check_reg();
}
static void form_fpu_sti(void)
{
    SET_LO(ax, 0x65);
    fpusti_check_reg();
}
static void form_fpu_st_first(void)
{
    swap_si_di();
    swap_al_ah();
    fpusti_st_second();
}

/* the operand at SI is a direct address (ZF set; bp-2Bh 1, from ASM_DECODE_RM_OPERAND) */
static void asm_is_direct_address(void)
{
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    cmp8(BPB(-0x2B), 1);
}
/* the operand at SI is a byte or word register or memory operand (ZF set) */
static void asm_is_byte_or_word_rm(void)
{
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    logic8(AL & 0xFE);
}
static void asm_is_word_rm(void)
{
    CALL(asm_decode_rm_operand);
    if (!zf)
        return;
    cmp8(AL, 1);
}

/* classifies the operand at SI for a ModRM byte: bp-2Ah/-28h its fixup, bp-30h its
   displacement, bp-31h the fixup kind, bp-2Bh 0 a register or based memory (1 a direct
   address), bp-2Ch its size code (0 byte, 1 word, ...; FCh none), bp-26h the ModRM bits,
   bp-2Eh a segment prefix that is not the default.  ZF set (AX 0) for a register of byte or
   word size or a memory operand; AL the size code either way */
#define ASM_MODRM_RM_SIZE_TABLE 0x1165
static void decrm_done(void)
{
    SET_LO(ax, BPB(-0x2C));
}
static void asm_decode_rm_operand(void)
{
    BPW(-0x2A) = MW(si + 8);
    ax = MW(si + 0x0A);
    BPW(-0x28) = ax;
    BPW(-0x30) = 0;
    BPB(-0x2E) = 0;
    cmp8(MB(si + 0x12), 0x65);
    if (zf) {
        BPB(-0x2B) = 0;
        ax = MW(si + 0x10);
        SET_HI(ax, AH | 0xC0);
        BPB(-0x26) = AH;
        cmp8(AL, 1);
        if (JA) {
            decrm_done();
            return;
        }
        BPB(-0x2C) = AL;
        ax = logic16(0);
        decrm_done();
        return;
    }
    cmp8(MB(si + 0x12), 0x67);
    if (!zf) {
        decrm_done();
        return;
    }
    SET_LO(ax, MB(si + 0x13));
    if (AL == 0)
        ax++;
    BPB(-0x31) = AL;
    ax = 0x601;
    SET_LO(bx, MB(si + 0x0E));
    bx &= 0x0F;
    if (bx != 0) {
        SET_HI(ax, CB(bx + ASM_MODRM_RM_SIZE_TABLE - 1));
        if (AH & 0x80)
            ASM_FAIL_INVALID_REGISTER();
        ax--;
    }
    BPB(-0x2B) = AL;
    cx = MW(si);
    BPW(-0x30) = cx;
    SET_LO(cx, 0xFC);
    bx = MW(si + 0x0C);
    if (bx <= 0x0A)
        SET_LO(cx, CB(bx + ASM_MODRM_RM_SIZE_TABLE + 0x0F));
    BPB(-0x2C) = CL;
    BPB(-0x26) = AH;
    SET_HI(ax, MB(si + 0x0F));
    if (AH != 0) {
        SET_LO(ax, 0x3E);
        if (BPB(-0x2B) != 1 && (MB(si + 0x0E) & 4))
            SET_LO(ax, 0x36);
        if (AL != AH)
            BPB(-0x2E) = AH;
    }
    ax = logic16(0);
    decrm_done();
}

/* the immediate at DI fits a signed byte (ZF set) */
static void asm_imm_fits_signed_byte(void)
{
    cmp8(MB(di + 0x12), 0x64);
    if (!zf)
        return;
    cmp8(MB(di + 0x13), 0);
    if (!zf)
        return;
    ax = (u16)(i16)(i8)MB(di);
    dx = (ax & 0x8000) ? 0xFFFF : 0;
    cmp8(AH, MB(di + 1));
    if (!zf)
        return;
    cmp16(dx, MW(di + 2));
}
/* the immediate at DI is a word (a long whose high word is its sign or 0; otherwise
   "number too large"), ZF set, AX its value; ZF clear for another operand */
static void asm_check_imm_fits_word(void)
{
    cmp8(MB(di + 0x12), 0x64);
    if (!zf)
        return;
    ax = MW(di);
    dx = (ax & 0x8000) ? 0xFFFF : 0;
    cmp16(MW(di + 2), dx);
    if (zf)
        return;
    dx = 0;
    cmp16(MW(di + 2), dx);
    if (zf)
        return;
    ASM_FAIL_NUMBER_OVERFLOW();
}
/* ... and fits a byte (signed or unsigned), without a fixup */
static void asm_imm_fits_byte(void)
{
    CALL(asm_check_imm_fits_word);
    if (!zf)
        return;
    cmp8(MB(di + 0x13), 0);
    if (!zf)
        return;
    if (logic16(dx), sf) {
        dx = ax;
        ax = (u16)(i16)(i8)AL;
        cmp16(ax, dx);
        return;
    }
    logic8(AH);
}
/* the immediate at DI is 0 */
static void asm_is_imm_zero(void)
{
    cmp8(MB(di + 0x13), 0);
    if (!zf)
        return;
    CALL(asm_check_imm_fits_word);
    if (!zf)
        return;
    logic16(ax);
}

/* the register of SI (or DI) into the ModRM reg field */
static void modrmreg_shift_in(void)
{
    SET_LO(ax, (u8)(AL << 3));
    BPB(-0x26) |= AL;
}
static void asm_set_modrm_reg_field(void)
{
    SET_LO(ax, MB(si + 0x11));
    modrmreg_shift_in();
}
static void asm_set_modrm_reg_from_di(void)
{
    SET_LO(ax, MB(di + 0x11));
    modrmreg_shift_in();
}

/* the prefixes, a segment prefix, the opcode bytes but the last, which stays pending at
   bp-24h (counted at bp-25h) for the form to add bits to */
static void opbytes_fetch_byte(void)
{
    SET_LO(ax, CB(bx + 2));
    bx++;
}
static void asm_emit_opcode_bytes(void)
{
    CALL(asm_opcode_byte_count);
    {
        u16 t = ax;
        ax = cx;
        cx = t;
    }
    cx = dec16(cx);
    if (!zf && !sf)
        do {
            CALL(opbytes_fetch_byte);
            CALL(asm_queue_byte);
        } while (--cx);
    opbytes_fetch_byte();
}
static void asm_begin_opcode(void)
{
    CALL(asm_emit_prefix_list);
    SET_LO(ax, BPB(-0x2E));
    if (logic8(AL), !zf)
        CALL(asm_queue_byte);
    CALL(asm_emit_opcode_bytes);
    BPB(-0x25)++;
    BPB(-0x24) = AL;
}
static void asm_emit_prefix_list(void)
{
    bx = (u16)(bp - 0x0E);
    for (;;) {
        ax = 0;
        SET_LO(ax, MB(bx));
        if (logic8(AL), zf)
            return;
        CALL(asm_queue_byte);
        bx++;
    }
}
static void asm_flush_pending_opcode(void)
{
    push(ax);
    u8 pending = BPB(-0x25);
    BPB(-0x25) = 0;
    ax = pending;
    if (logic8(AL), !zf) {
        SET_LO(ax, BPB(-0x24));
        CALL(asm_queue_byte);
    }
    ax = pop();
}

/* ---- the emit records: kind in BL (0 a byte, 1 a fixup operand with BH its form, 2 a
   short jump, 3 an x87 opcode), CX and DX the value, the fixup's far pointer at
   bp-182h/-180h; at most 11 records ---- */
static void asm_queue_emit_record(void)
{
    CALL(asm_flush_pending_opcode);
    push(si);
    si = BPW(EMIT_COUNT);
    if (si == 0x6E)
        ASM_FAIL_SYNTAX();
    MW(bp + si - 0x17E) = bx;
    MW(bp + si - 0x17C) = cx;
    MW(bp + si - 0x17A) = dx;
    MW(bp + si - 0x178) = MW(bp - 0x182);
    MW(bp + si - 0x176) = MW(bp - 0x180);
    BPW(EMIT_COUNT) = (u16)(BPW(EMIT_COUNT) + 0x0A);
    si = pop();
    cmp16(ax, ax);
}
static void asm_queue_byte(void)
{
    CALL(asm_flush_pending_opcode);
    push(bx);
    push(cx);
    SET_LO(bx, 0);
    cx = ax;
    CALL(asm_queue_emit_record);
    cx = pop();
    bx = pop();
}
static void asm_queue_word(void)
{
    CALL(asm_queue_byte);
    swap_al_ah();
    asm_queue_byte();
}
/* the immediate at DI as a word (with its fixup as a record 1) or a byte */
static void asm_emit_imm16(void)
{
    SET_HI(bx, MB(di + 0x13));
    if (logic8(BH), !zf) {
        SET_LO(bx, 1);
        cx = MW(di);
        dx = MW(di + 2);
        MW(bp - 0x182) = MW(di + 8);
        MW(bp - 0x180) = MW(di + 0x0A);
        CALL(asm_queue_emit_record);
        return;
    }
    CALL(asm_check_imm_fits_word);
    if (zf)
        asm_queue_word();
}
static void asm_emit_imm8(void)
{
    CALL(asm_imm_fits_byte);
    if (zf)
        asm_queue_byte();
}
/* the displacement word bp-30h, as a fixup record when the operand has a fixup */
static void asm_emit_displacement(void)
{
    ax = BPW(-0x30);
    cx = BPW(-0x2A);
    cx = logic16(cx | BPW(-0x28));
    if (zf) {
        asm_queue_word();
        return;
    }
    {
        u16 t = ax;
        ax = cx;
        cx = t;
    }
    dx = 0;
    SET_LO(bx, 1);
    SET_HI(bx, BPB(-0x31));
    MW(bp - 0x182) = BPW(-0x2A);
    MW(bp - 0x180) = BPW(-0x28);
    asm_queue_emit_record();
}

/* the form's flag byte (the entry's second byte) in AL, BX the entry */
static void asm_get_form_flags(void)
{
    bx = BPW(LOOKUP_ENTRY);
    SET_LO(ax, CB(bx + 1));
}
/* the number of opcode bytes (1-4) in AX */
static void asm_opcode_byte_count(void)
{
    CALL(asm_get_form_flags);
    ax &= 3;
    ax++;
}

/* the ModRM byte and displacement: mod 11 for a register, a direct address (r/m 110) with
   a 16-bit displacement, otherwise none, 8 or 16 bits as the displacement needs ([bp]
   always has one); the operand's size bit and the direction bit (bp-2Dh) go into the
   pending opcode byte.  ZF set unless the size code is above FDh */
static void modrm_set_result(void)
{
    cmp8(BPB(-0x2C), 0xFD);
    if (JA)
        return;
    ax = logic16(0);
}
static void modrm_queue_al(void)
{
    CALL(asm_queue_byte);
    modrm_set_result();
}
static void modrm_queue_modrm(void)
{
    SET_LO(ax, BPB(-0x26));
    modrm_queue_al();
}
static void asm_emit_modrm_bytes(void)
{
    SET_LO(ax, BPB(-0x2C) | BPB(-0x2D));
    BPB(-0x24) |= AL;
    SET_LO(ax, BPB(-0x26));
    SET_HI(ax, AL);
    ax &= 0xC7C0;
    if (AL == 0xC0) {
        modrm_queue_modrm();
        return;
    }
    if (BPB(-0x2B) != 1) {
        cx = BPW(-0x2A);
        cx = logic16(cx | BPW(-0x28));
        if (zf) {
            cx = BPW(-0x30);
            if (AH != 6 && cx == 0) {
                modrm_queue_modrm();
                return;
            }
            ax = (u16)(i16)(i8)CL;
            if (ax == cx) {
                BPB(-0x26) |= 0x40;
                CALL(modrm_queue_modrm);
                ax = BPW(-0x30);
                modrm_queue_al();
                return;
            }
        }
        BPB(-0x26) |= 0x80;
    }
    CALL(modrm_queue_modrm);
    CALL(asm_emit_displacement);
    modrm_set_result();
}
static void asm_emit_modrm_form_reg(void)
{
    CALL(asm_get_form_flags);
    SET_LO(ax, AL & 0x38);
    BPB(-0x26) |= AL;
    cmp8(BPB(-0x2D), 0);
    if (zf)
        asm_emit_modrm_bytes();
}
static void asm_emit_modrm(void)
{
    BPB(-0x2C) = 0;
    asm_emit_modrm_form_reg();
}
static void asm_emit_modrm_no_size(void)
{
    BPB(-0x2C) = 0;
    asm_emit_modrm_bytes();
}

/* the two hash tables in the code segment */
static void asm_opcode_table_address(void)
{
    di = 0x13C4;    /* ASM_MNEMONIC_HASH_TABLE */
}
static void asm_keyword_table_address(void)
{
    di = 0x1E5A;    /* ASM_KEYWORD_HASH_TABLE */
}

/* ---- dispatch: an operator handler by its code offset, a form by its table index ---- */
static void asm_run_handler(u16 handler)
{
    switch (handler) {
    case H_OP_OR:
        MW(si) |= ax;
        MW(si + 2) |= cx;
        break;
    case H_OP_XOR:
        MW(si) ^= ax;
        MW(si + 2) ^= cx;
        break;
    case H_ADDSUB_ADD:
        addsub_add();
        break;
    case H_ADDSUB_SUB:
        addsub_sub();
        break;
    case H_MULDIV_MUL:
        bx = MW(di + 2);
        asm_mul32();
        break;
    case H_MULDIV_DIV:
        bx = MW(di + 2);
        asm_div32();
        break;
    case H_MULDIV_MOD:
        push(0);
        bx = MW(di + 2);
        asm_div32();
        sp += 2;
        {
            u16 t = ax;
            ax = cx;
            cx = t;
            t = dx;
            dx = bx;
            bx = t;
        }
        break;
    case H_MULDIV_SHR:
        op_shr();
        break;
    case H_MULDIV_SHL:
        op_shl();
        break;
    case H_OFS_OFFSET:
        ofs_offset();
        break;
    case H_OFS_SEG:
        ofs_seg();
        break;
    case H_OFS_TYPE:
        ofs_type();
        break;
    case H_USIGN_NEG:
        usign_neg();
        break;
    case H_USIGN_PLUS:
        usign_plus();
        break;
    case H_HILO_HIGH:
        hilo_high();
        break;
    case H_HILO_LOW:
        hilo_low();
        break;
    case H_BRACKET_PAREN:
        close_paren();
        break;
    case H_BRACKET_SQUARE:
        close_square();
        break;
    }
}

/* ASM_FORM_HANDLER_TABLE in order */
static void (*const FORMS[])(void) = {
    form_no_operands, form_imm16_operand, form_imm8_operand, form_lea,
    form_out_dx_acc, form_out_imm8_acc, outdx_no_swap, outimm_no_swap,
    form_xchg_reg16_ax, xchgax_no_swap, form_int, form_enter,
    form_acc_imm, form_mov_reg_imm, form_near_indirect, form_direct_jump_far,
    form_far_indirect, form_short_jump, form_direct_jump, movmoffs_no_swap,
    form_mov_acc_moffs, form_return, form_return_with_imm, form_reject,
    form_push_pop_any_sreg, form_push_pop_sreg, form_reg16_in_opcode, form_descriptor_mem,
    form_lar_lsl, larlsl_no_swap, form_imul_immediate, form_mov_sreg_rm,
    movsreg_no_swap, form_rm_reg, form_test_xchg_rm, form_rm16,
    form_alu_rm_imm, form_rm_imm, form_unary_rm, form_lds_les,
    form_shift_rotate, asm_emit_fpu_opcode, form_fstsw_ax, form_fpu_sti,
    fpusti_st_second, form_fpu_st_first, form_fpu_mem_dword_or_qword, form_fpu_mem_sized,
    form_fpu_mem_word_only, form_fpu_mem_word_or_dword, form_fpu_mem_qword_only, form_fpu_env_mem,
    form_fpu_save_mem, form_reject,
};

static void asm_run_form(u16 index)
{
    FORMS[index]();
}

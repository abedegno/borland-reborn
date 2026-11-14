/* ldarith.c: from bcc20/src/float/LDARITH.ASM and LDUNPACK.ASM (Borland run-time library,
   hand-written assembly): software arithmetic on 80-bit extended reals, used by constant
   folding (FOLD_CONSTANT_NODE in constfld.c).  Each entry leaves a op b in *a:
   RTL_LDOUBLE_ADD, RTL_LDOUBLE_SUB, RTL_LDOUBLE_MUL, RTL_LDOUBLE_DIV.  Add and subtract go
   through the common routine ldouble_addsub (RTL_LDOUBLE_ADDSUB in the original), whose
   flag flips the sign of b.  Operands are first unpacked to a 12-byte work format in the
   frame (ldouble_unpack, RTL_LDOUBLE_UNPACK): the four mantissa words, the exponent without
   the sign, then the sign (0 or 1).  Multiply asks BCC_EXTENDED_HAS_PAYLOAD (ldisnan.c) to
   tell a NaN operand from an infinity; the result is then the default NaN.
   The arithmetic is the original's instruction for instruction (carries, 16-bit mul and
   div, the quotient estimates of the division), on 16-bit values with an explicit carry
   flag; the frame lives in scratch memory at the original's BP offsets (FRAME_W(n) is the
   word at bp-n). */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

/* ---- 8086 arithmetic with the carry flag ---- */
static unsigned cf;

static u16 add16(u16 a, u16 b)
{
    u32 r = (u32)a + b;
    cf = r >> 16;
    return (u16)r;
}
static u16 adc16(u16 a, u16 b)
{
    u32 r = (u32)a + b + cf;
    cf = r >> 16;
    return (u16)r;
}
static u16 sub16(u16 a, u16 b)
{
    cf = a < b;
    return (u16)(a - b);
}
static u16 sbb16(u16 a, u16 b)
{
    u32 subtrahend = (u32)b + cf;
    cf = a < subtrahend;
    return (u16)(a - subtrahend);
}
static u8 adc8(u8 a, u8 b)
{
    u16 r = (u16)(a + b + cf);
    cf = r >> 8;
    return (u8)r;
}
static u8 sbb8(u8 a, u8 b)
{
    u16 subtrahend = (u16)(b + cf);
    cf = a < subtrahend;
    return (u8)(a - subtrahend);
}
static u16 rcr16(u16 a)
{
    unsigned out = a & 1;
    a = (u16)(cf << 15 | a >> 1);
    cf = out;
    return a;
}
static u8 rcr8(u8 a)
{
    unsigned out = a & 1;
    a = (u8)(cf << 7 | a >> 1);
    cf = out;
    return a;
}
static u16 rcl16(u16 a)
{
    unsigned out = a >> 15;
    a = (u16)(a << 1 | cf);
    cf = out;
    return a;
}
static u16 shl16(u16 a)
{
    cf = a >> 15;
    return (u16)(a << 1);
}
static u8 shl8(u8 a)
{
    cf = a >> 7;
    return (u8)(a << 1);
}
static u16 shr16(u16 a)
{
    cf = a & 1;
    return a >> 1;
}
/* mul: dx:ax = ax * b */
static void mul16(u16 *ax, u16 *dx, u16 b)
{
    u32 r = (u32)*ax * b;
    *ax = (u16)r;
    *dx = (u16)(r >> 16);
}
/* div: dx:ax / b, quotient in ax, remainder in dx (the algorithm keeps the quotient within
   16 bits; the 8086 would raise a divide error otherwise) */
static void div16(u16 *ax, u16 *dx, u16 b)
{
    u32 n = (u32)*dx << 16 | *ax;
    *ax = (u16)(n / b);
    *dx = (u16)(n % b);
}

/* ---- the frame (scratch memory, size bytes below bp) ---- */
static farptr frame_bp;
#define FRAME_W(n) W(fp_add(frame_bp, -(n)))
#define FRAME_B(n) B(fp_add(frame_bp, -(n)))
#define FRAME_P(n) fp_add(frame_bp, -(n))

/* unpacks the 80-bit real at source into the work format at target: the mantissa, the
   exponent with the sign bit removed, the sign as 0 or 1 */
static void ldouble_unpack(farptr source, farptr target)
{
    for (int i = 0; i < 8; i += 2)
        W(fp_add(target, i)) = W(fp_add(source, i));
    u16 word = W(fp_add(source, 8));
    W(fp_add(target, 8)) = word & 0x7FFF;
    W(fp_add(target, 10)) = word >> 15;
}

/* stores mantissa words and the exponent with the sign (the byte at sign_at) at target */
static void store_result(farptr target, u16 ax, u16 bx, u16 cx, u16 dx, u16 exponent, u8 sign)
{
    W(target) = ax;
    W(fp_add(target, 2)) = bx;
    W(fp_add(target, 4)) = cx;
    W(fp_add(target, 6)) = dx;
    W(fp_add(target, 8)) = (u16)(((u16)(exponent << 1) | sign) >> 1 | (u16)(exponent << 1 | sign) << 15);
}

/* a + b (negate_b 0) or a - b (negate_b 1), into a.  Frame (1Ah bytes): a's work copy at
   bp-18h, b's at bp-0Ch; bp-1Ah the shift count, bp-19h the guard byte shifted out of the
   aligned operand */
static void ldouble_addsub(farptr a, farptr b, u8 negate_b)
{
    ldouble_unpack(a, FRAME_P(0x18));
    ldouble_unpack(b, FRAME_P(0x0C));
    u16 si = 0x18, di = 0x0C;            /* which work copy: the larger and the smaller */
#define SI_W(o) FRAME_W(si - (o))
#define DI_W(o) FRAME_W(di - (o))
    u8 al = (u8)(negate_b ^ FRAME_B(2));
    FRAME_B(2) = al;                    /* b's sign, flipped for a subtraction */
    al ^= FRAME_B(0x0E);
    negate_b = al;                      /* the signs differ: subtract magnitudes */
    u16 ax = FRAME_W(0x10), bx = FRAME_W(4), cx = 0, dx = 0;
    if (ax >= 0x7FFF)
        goto inf_check;
    if (bx >= 0x7FFF)
        goto b_special;
    if (ax < bx) {
        FRAME_B(0x0E) = FRAME_B(2);
        FRAME_W(0x10) = bx;
        u16 t = ax;
        ax = bx;
        bx = t;
        t = si;
        si = di;
        di = t;
    }
    if (bx != 0)
        goto align;
    goto return_larger;
b_special:
    si = di;
    FRAME_W(0x10) = FRAME_W(4);
    FRAME_W(0x0E) = FRAME_W(2);
inf_check:
    if (FRAME_W(0x10) != FRAME_W(4))
        goto return_larger;
    if (FRAME_W(0x0E) == FRAME_W(2))
        goto return_larger;
    /* infinities of opposite signs: the default NaN */
    FRAME_W(0x0E) = 0;
    ax = 0;
    bx = 0;
    cx = 0;
    dx = 0xC000;
    goto store;
return_larger:
    ax = SI_W(0);
    bx = SI_W(2);
    cx = SI_W(4);
    dx = SI_W(6);
    goto store;
align:
    ax = (u16)(ax - bx);
    if ((i16)ax > 0x40)
        goto return_larger;
    FRAME_B(0x1A) = (u8)ax;
    ax = DI_W(0);
    bx = DI_W(2);
    cx = DI_W(4);
    dx = DI_W(6);
    FRAME_B(0x19) = 0;
    FRAME_B(0x1A) = (u8)(FRAME_B(0x1A) - 8);
    if ((i8)FRAME_B(0x1A) >= 0)
        do {
            FRAME_B(0x19) = (u8)ax;
            ax = (u16)(ax >> 8 | (bx & 0xFF) << 8);
            bx = (u16)(bx >> 8 | (cx & 0xFF) << 8);
            cx = (u16)(cx >> 8 | (dx & 0xFF) << 8);
            dx = dx >> 8;
            FRAME_B(0x1A) = (u8)(FRAME_B(0x1A) - 8);
        } while ((i8)FRAME_B(0x1A) >= 0);
    FRAME_B(0x1A) &= 7;
    while (FRAME_B(0x1A)) {
        dx = shr16(dx);
        cx = rcr16(cx);
        bx = rcr16(bx);
        ax = rcr16(ax);
        FRAME_B(0x19) = rcr8(FRAME_B(0x19));
        FRAME_B(0x1A)--;
    }
    di = 0;
    if (negate_b == 0) {
        ax = add16(ax, SI_W(0));
        bx = adc16(bx, SI_W(2));
        cx = adc16(cx, SI_W(4));
        dx = adc16(dx, SI_W(6));
        if (cf) {
            dx = rcr16(dx);
            cx = rcr16(cx);
            bx = rcr16(bx);
            ax = rcr16(ax);
            FRAME_B(0x19) = rcr8(FRAME_B(0x19));
            FRAME_W(0x10)++;
        }
        goto round;
    }
    FRAME_B(0x0E) ^= 1;
    ax = sub16(ax, SI_W(0));
    bx = sbb16(bx, SI_W(2));
    cx = sbb16(cx, SI_W(4));
    dx = sbb16(dx, SI_W(6));
    if (cf) {
        FRAME_B(0x0E) ^= 1;
        dx = (u16)~dx;
        cx = (u16)~cx;
        bx = (u16)~bx;
        ax = (u16)~ax;
        u8 guard = FRAME_B(0x19);
        FRAME_B(0x19) = (u8)(0 - guard);
        cf = guard != 0;               /* neg sets the carry for a nonzero byte */
        cf = !cf;                       /* cmc */
        ax = adc16(ax, di);
        bx = adc16(bx, di);
        cx = adc16(cx, di);
        dx = adc16(dx, di);
    }
    /* normalise */
    {
        u16 count = 0x40;
        if (!(dx & 0x8000)) {
            do {
                if (--count == 0) {
                    FRAME_W(0x10) = 0;
                    FRAME_B(0x0E) = 0;
                    goto store;
                }
                FRAME_B(0x19) = shl8(FRAME_B(0x19));
                ax = rcl16(ax);
                bx = rcl16(bx);
                cx = rcl16(cx);
                dx = adc16(dx, dx);
            } while (!(dx & 0x8000));
            FRAME_W(0x10) = (u16)(FRAME_W(0x10) + (u16)(count - 0x40));
        }
    }
round:
    FRAME_B(0x19) = shl8(FRAME_B(0x19));
    ax = adc16(ax, di);
    bx = adc16(bx, di);
    cx = adc16(cx, di);
    dx = adc16(dx, di);
    if (cf) {
        dx = rcr16(dx);
        FRAME_W(0x10)++;
    }
    if (FRAME_W(0x10) >= 0x7FFF) {
        FRAME_W(0x10) = 0x7FFF;
        ax = bx = cx = dx = 0;
    } else if (FRAME_W(0x10) == 0)
        ax = bx = cx = dx = 0;
store:
    store_result(a, ax, bx, cx, dx, FRAME_W(0x10), FRAME_B(0x0E));
#undef SI_W
#undef DI_W
}

/* runs body with a frame of size bytes in scratch memory */
#define WITH_FRAME(size, body)                                  \
    do {                                                        \
        u16 mark_ = scratch_mark();                             \
        farptr saved_ = frame_bp;                               \
        frame_bp = fp_add(scratch_alloc((size) + 2), (size));   \
        body;                                                   \
        frame_bp = saved_;                                      \
        scratch_release(mark_);                                 \
    } while (0)

void RTL_LDOUBLE_ADD(farptr a, farptr b)
{
    WITH_FRAME(0x1A, ldouble_addsub(a, b, 0));
}

void RTL_LDOUBLE_SUB(farptr a, farptr b)
{
    WITH_FRAME(0x1A, ldouble_addsub(a, b, 1));
}

/* a * b into a.  Frame (18h bytes): a's work copy at bp-18h, b's at bp-0Ch.  The 64x64-bit
   product is built from 16-bit partial products, leaving out those below the low columns
   the result needs (the original's order of additions is kept) */
static void ldouble_mul(farptr a, farptr b)
{
    ldouble_unpack(a, FRAME_P(0x18));
    ldouble_unpack(b, FRAME_P(0x0C));
    FRAME_B(0x0E) ^= FRAME_B(2);
    u16 bx = FRAME_W(4), ax = FRAME_W(0x10), cx, dx, si, di;
    if (ax >= 0x7FFF) {
        /* a is infinity or NaN */
        if (FRAME_W(4) == 0 || BCC_EXTENDED_HAS_PAYLOAD(FRAME_P(0x18)))
            goto default_nan;
        W(fp_add(a, 8)) &= 0x7FFF;
        if (FRAME_W(0x0E) & 0xFF)
            W(fp_add(a, 8)) ^= 0x8000;
        return;
    }
    if (bx >= 0x7FFF) {
        if (FRAME_W(0x10) == 0 || BCC_EXTENDED_HAS_PAYLOAD(FRAME_P(0x0C)))
            goto default_nan;
        di = 0x7FFF;
        ax = FRAME_W(0x0C);
        bx = FRAME_W(0x0A);
        cx = FRAME_W(8);
        dx = FRAME_W(6);
        goto store;
    }
    if (ax >= bx) {
        u16 t = ax;
        ax = bx;
        bx = t;
    }
    if (ax == 0)
        goto zero;
    ax = add16(ax, bx);
    ax = sub16(ax, 0x3FFE);
    if (cf)
        goto zero;
    FRAME_W(0x10) = ax;
    di = 0;
    cx = 0;
    si = 0;
    if (FRAME_B(9) & 0x80) {
        cx = FRAME_W(0x18);
        si = FRAME_W(0x16);
    }
    if (FRAME_B(0x15) & 0x80) {
        cx = add16(cx, FRAME_W(0x0C));
        si = adc16(si, FRAME_W(0x0A));
        di = adc16(di, di);
        if (FRAME_B(9) & 0x80)
            di--;
    }
    bx = 0;
    ax = FRAME_W(0x0C);
    mul16(&ax, &dx, FRAME_W(0x14));
    cx = add16(cx, ax);
    si = adc16(si, dx);
    di = adc16(di, 0);
    ax = FRAME_W(8);
    if (ax) {
        mul16(&ax, &dx, FRAME_W(0x18));
        cx = add16(cx, ax);
        si = adc16(si, dx);
        di = adc16(di, 0);
        ax = FRAME_W(8);
        mul16(&ax, &dx, FRAME_W(0x16));
        si = add16(si, ax);
        di = adc16(di, dx);
        bx = adc16(bx, 0);
    }
    ax = FRAME_W(0x0C);
    mul16(&ax, &dx, FRAME_W(0x12));
    si = add16(si, ax);
    di = adc16(di, dx);
    bx = adc16(bx, 0);
    ax = FRAME_W(0x0A);
    mul16(&ax, &dx, FRAME_W(0x14));
    si = add16(si, ax);
    di = adc16(di, dx);
    bx = adc16(bx, 0);
    ax = FRAME_W(6);
    if (ax) {
        mul16(&ax, &dx, FRAME_W(0x18));
        si = add16(si, ax);
        di = adc16(di, dx);
        bx = adc16(bx, 0);
    }
    cx = 0;
    u16 pushed = si;
    si = cx;
    ax = FRAME_W(0x0A);
    mul16(&ax, &dx, FRAME_W(0x12));
    di = add16(di, ax);
    bx = adc16(bx, dx);
    cx = adc16(cx, 0);
    ax = FRAME_W(8);
    if (ax) {
        mul16(&ax, &dx, FRAME_W(0x14));
        di = add16(di, ax);
        bx = adc16(bx, dx);
        cx = adc16(cx, 0);
        ax = FRAME_W(8);
        mul16(&ax, &dx, FRAME_W(0x12));
        bx = add16(bx, ax);
        cx = adc16(cx, dx);
        si = adc16(si, 0);
    }
    ax = FRAME_W(6);
    if (ax) {
        mul16(&ax, &dx, FRAME_W(0x16));
        di = add16(di, ax);
        bx = adc16(bx, dx);
        cx = adc16(cx, 0);
        si = adc16(si, 0);
        ax = FRAME_W(6);
        mul16(&ax, &dx, FRAME_W(0x14));
        bx = add16(bx, ax);
        cx = adc16(cx, dx);
        si = adc16(si, 0);
        ax = FRAME_W(6);
        mul16(&ax, &dx, FRAME_W(0x12));
        cx = add16(cx, ax);
        si = adc16(si, dx);
    }
    /* normalise: dx:cx:bx:ax with the guard word in si */
    dx = si;
    {
        u16 t = ax;
        ax = di;
        di = t;
    }
    si = pushed;
    di = FRAME_W(0x10);
    if (!(dx & 0x8000)) {
        di--;
        si = shl16(si);
        ax = rcl16(ax);
        bx = rcl16(bx);
        cx = rcl16(cx);
        dx = rcl16(dx);
    }
    si = shl16(si);
    ax = adc16(ax, 0);
    bx = adc16(bx, 0);
    cx = adc16(cx, 0);
    dx = adc16(dx, 0);
    if (cf) {
        dx = rcr16(dx);
        di++;
    }
    if (di >= 0x7FFF) {
        di = 0x7FFF;
        dx = 0x8000;
        ax = bx = cx = 0;
    }
    goto store;
zero:
    di = 0;
    dx = 0;
    ax = bx = cx = 0;
    goto store;
default_nan:
    dx = 0xC000;
    di = 0x7FFF;
    ax = bx = cx = 0;
store:
    store_result(a, ax, bx, cx, dx, di, FRAME_B(0x0E));
}

void RTL_LDOUBLE_MUL(farptr a, farptr b)
{
    WITH_FRAME(0x18, ldouble_mul(a, b));
}

/* a / b into a.  Frame (28h bytes): a's work copy at bp-28h (the dividend, worn down into
   remainders), b's at bp-1Ch, the sign at bp-6, the exponent at bp-8, the quotient words at
   bp-0Eh..bp-0Ah with a carry byte at bp-1, and a fifth remainder word at bp-4.  Each
   quotient word is estimated by dividing by b's top word, corrected by the full products */
static void ldouble_div(farptr a, farptr b)
{
    u16 ax, bx, cx, dx, si, di;
    FRAME_W(4) = 0;
    ldouble_unpack(a, FRAME_P(0x28));
    ldouble_unpack(b, FRAME_P(0x1C));
    FRAME_B(6) = (u8)(FRAME_B(0x1E) ^ FRAME_B(0x12));
    si = FRAME_W(0x14);
    ax = FRAME_W(0x20);
    if (si >= 0x7FFF)
        goto result_zero;
    if (ax >= 0x7FFF)
        goto return_a;
    if (si == 0)
        goto infinity;
    if (ax == 0)
        goto return_a;
    ax = add16(ax, 0x3FFE);
    ax = sub16(ax, si);
    if (cf)
        goto result_zero;
    goto divide;
infinity:
    dx = 0x7FFF;
    si = 0x8000;
    if (ax != 0)
        goto clear_low;
default_nan:
    dx = 0x7FFF;
    si = 0xC000;
    goto clear_low;
result_zero:
    dx = 0;
    si = 0;
    if (ax == 0x7FFF)
        goto default_nan;
clear_low:
    ax = bx = cx = 0;
    goto store;
return_a:
    W(fp_add(a, 8)) &= 0x7FFF;
    if (FRAME_W(6) & 0xFF)
        W(fp_add(a, 8)) ^= 0x8000;
    return;
divide:
    FRAME_W(8) = ax;
    cx = 0;
    dx = FRAME_W(0x22);
    si = FRAME_W(0x16);
    if (!(si > dx)) {
        dx = (u16)(dx - si);
        cx++;
    }
    ax = FRAME_W(0x24);
    div16(&ax, &dx, si);
    /* adc ax,1 with the carry the cmp/sub left (clear on both paths: cmp si,dx with si<=dx
       gives no borrow, sub dx,si neither) */
    cf = 0;
    ax = adc16(ax, 1);
    cx = (u16)((cx & 0xFF00) | adc8((u8)cx, (u8)(cx >> 8)));
    FRAME_B(1) = (u8)cx;
    FRAME_W(0x0A) = ax;
    {
        u16 pushed = ax;
        ax = FRAME_W(0x1C);
        bx = FRAME_W(0x1A);
        if (cx) {
            dx = FRAME_W(0x18);
            do {
                FRAME_W(0x28) = sub16(FRAME_W(0x28), ax);
                FRAME_W(0x26) = sbb16(FRAME_W(0x26), bx);
                FRAME_W(0x24) = sbb16(FRAME_W(0x24), dx);
                FRAME_W(0x22) = sbb16(FRAME_W(0x22), si);
            } while (--cx);
        }
        si = pushed;
    }
    mul16(&ax, &dx, si);
    FRAME_W(4) = ax;
    {
        u16 t = ax;
        ax = dx;
        dx = t;
        t = ax;
        ax = bx;
        bx = t;
    }
    mul16(&ax, &dx, si);
    bx = add16(bx, ax);
    cx = adc16(cx, dx);
    ax = FRAME_W(0x18);
    mul16(&ax, &dx, si);
    cx = add16(cx, ax);
    dx = adc16(dx, 0);
    {
        u16 t = ax;
        ax = dx;
        dx = t;
        t = ax;
        ax = si;
        si = t;
    }
    mul16(&ax, &dx, FRAME_W(0x16));
    ax = add16(ax, si);
    dx = adc16(dx, 0);
    bx = sub16(bx, FRAME_W(0x28));
    cx = sbb16(cx, FRAME_W(0x26));
    ax = sbb16(ax, FRAME_W(0x24));
    dx = sbb16(dx, FRAME_W(0x22));
    FRAME_W(0x28) = bx;
    FRAME_W(0x26) = cx;
    FRAME_W(0x24) = ax;
    si = FRAME_W(0x16);
    div16(&ax, &dx, si);
    {
        u16 t = ax;
        ax = cx;
        cx = t;
    }
    div16(&ax, &dx, si);
    dx = 0;
    cf = 1;
    ax = adc16(ax, dx);
    cx = adc16(cx, dx);
    dx = sub16(dx, ax);
    FRAME_W(0x0C) = dx;
    FRAME_W(0x0A) = sbb16(FRAME_W(0x0A), cx);
    FRAME_B(1) = sbb8(FRAME_B(1), 0);
    {
        u16 pushed = ax;
        ax = FRAME_W(0x1C);
        bx = FRAME_W(0x1A);
        if (cx) {
            dx = FRAME_W(0x18);
            do {
                FRAME_W(4) = sub16(FRAME_W(4), ax);
                FRAME_W(0x28) = sbb16(FRAME_W(0x28), bx);
                FRAME_W(0x26) = sbb16(FRAME_W(0x26), dx);
                FRAME_W(0x24) = sbb16(FRAME_W(0x24), si);
            } while (--cx);
        }
        si = pushed;
    }
    mul16(&ax, &dx, si);
    {
        u16 t = ax;
        ax = dx;
        dx = t;
        t = ax;
        ax = bx;
        bx = t;
    }
    mul16(&ax, &dx, si);
    bx = add16(bx, ax);
    cx = adc16(cx, dx);
    ax = FRAME_W(0x18);
    mul16(&ax, &dx, si);
    cx = add16(cx, ax);
    dx = adc16(dx, 0);
    {
        u16 t = ax;
        ax = dx;
        dx = t;
        t = ax;
        ax = si;
        si = t;
    }
    mul16(&ax, &dx, FRAME_W(0x16));
    ax = add16(ax, si);
    dx = adc16(dx, 0);
    bx = sub16(bx, FRAME_W(4));
    cx = sbb16(cx, FRAME_W(0x28));
    ax = sbb16(ax, FRAME_W(0x26));
    dx = sbb16(dx, FRAME_W(0x24));
    FRAME_W(4) = bx;
    FRAME_W(0x28) = cx;
    FRAME_W(0x26) = ax;
    si = FRAME_W(0x16);
    div16(&ax, &dx, si);
    {
        u16 t = ax;
        ax = cx;
        cx = t;
    }
    div16(&ax, &dx, si);
    dx = 0;
    cf = 1;
    ax = adc16(ax, dx);
    cx = adc16(cx, dx);
    FRAME_W(0x0E) = ax;
    FRAME_W(0x0C) = add16(FRAME_W(0x0C), cx);
    FRAME_W(0x0A) = adc16(FRAME_W(0x0A), dx);
    FRAME_B(1) = adc8(FRAME_B(1), (u8)dx);
    {
        u16 t = ax;
        ax = si;
        si = t;
    }
    dx = FRAME_W(0x1A);
    {
        u16 t = ax;
        ax = dx;
        dx = t;
    }
    bx = FRAME_W(0x18);
    if (cx)
        do {
            FRAME_W(4) = sub16(FRAME_W(4), ax);
            FRAME_W(0x28) = sbb16(FRAME_W(0x28), bx);
            FRAME_W(0x26) = sbb16(FRAME_W(0x26), dx);
        } while (--cx);
    mul16(&ax, &dx, si);
    {
        u16 t = ax;
        ax = dx;
        dx = t;
        t = ax;
        ax = bx;
        bx = t;
    }
    mul16(&ax, &dx, si);
    bx = add16(bx, ax);
    cx = adc16(cx, dx);
    ax = FRAME_W(0x16);
    mul16(&ax, &dx, si);
    ax = add16(ax, cx);
    dx = adc16(dx, 0);
    bx = sub16(bx, FRAME_W(4));
    ax = sbb16(ax, FRAME_W(0x28));
    dx = sbb16(dx, FRAME_W(0x26));
    FRAME_W(4) = bx;
    FRAME_W(0x28) = ax;
    si = FRAME_W(0x18);
    si = add16(si, si);
    si = FRAME_W(0x16);
    si = adc16(si, 0);
    u8 dh;
    if (cf) {
        u16 t = bx;
        bx = dx;
        dx = t;
        dh = (u8)(dx >> 8);
    } else {
        bx = shl16(bx);
        ax = rcl16(ax);
        dx = rcl16(dx);
        div16(&ax, &dx, si);
        {
            u16 t = ax;
            ax = bx;
            bx = t;
        }
        div16(&ax, &dx, si);
        bx = shr16(bx);
        ax = rcr16(ax);
        dh = rcr8((u8)(dx >> 8));
    }
    /* combine: the negated last quotient digits added to the quotient words */
    cx = 0xFFFF;
    si = cx;
    u8 dl = (u8)cx;
    bx = (u16)~bx;
    ax = (u16)~ax;
    cf = dh != 0;
    dh = (u8)(0 - dh);
    cf = !cf;
    ax = adc16(ax, 0);
    bx = adc16(bx, FRAME_W(0x0E));
    cx = adc16(cx, FRAME_W(0x0C));
    si = adc16(si, FRAME_W(0x0A));
    dl = adc8(dl, FRAME_B(1));
    cf = dl & 1;
    dl >>= 1;
    if (cf) {
        si = rcr16(si);
        cx = rcr16(cx);
        bx = rcr16(bx);
        ax = rcr16(ax);
        dh = rcr8(dh);
        FRAME_W(8)++;
    }
    di = 0;
    dh = shl8(dh);
    ax = adc16(ax, di);
    bx = adc16(bx, di);
    cx = adc16(cx, di);
    si = adc16(si, di);
    dl = adc8(dl, 0);
    dx = FRAME_W(8);
    if (dl != 0) {
        si = 0x8000;
        dx++;
    }
    if (dx >= 0x7FFF)
        goto infinity;
store:
    store_result(a, ax, bx, cx, si, dx, FRAME_B(6));
}

void RTL_LDOUBLE_DIV(farptr a, farptr b)
{
    WITH_FRAME(0x28, ldouble_div(a, b));
}

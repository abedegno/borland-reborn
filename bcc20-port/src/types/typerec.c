/* typerec.c: from bcc20/src/types/TYPEREC.C: the C-mode type records and the storage of
   huge arrays.

   In C mode types are 10-byte TYPE_POOL records in the "C layout" (TYPE_C_* fields); byte 0
   is the kind.  By kind: array (11h) +3 element count (long), +7 element type, +9 huge
   flag; pointer (0Dh-10h) +3 pointed-to type, +5 based-pointer base name, +7 qualifiers, +8
   near-pointer segment mode; function (12h) +3 return type, +5 parameter list, +7 calling
   convention, +8 flags (1 far, 8 no prototype); struct/union (13h/14h) +3 size, +5
   members, +7 tag symbol, +9 kind; enum (15h) +3 size (2), +5 a word set by the caller.
   KIND_INFO_TABLE has a 4-byte row per kind: byte 2 the alignment, byte 3 the size.
   Arrays over 64K are split over several far segments (ARRAY_DATA_LENGTH and the
   RESERVE_* functions, which emit through the back end's hooks). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "kind.h"
#include "protos.h"
#include "calls.h"
#include "variadic.h"

#define KIND_INFO(i) SB(fp_add(KIND_INFO_TABLE_P, (i)))
#define DIAG_NAME_BUFFER W(DIAG_NAME_BUFFER_P)
#define MASK_C SD(MASK_C_P)
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define TP(n) MK_FP(TYPE_POOL, (n))

/* the size of a type, through the front end's hook (SIZE_OF_TYPE_CHECKED here): its low
   word, as the original declares the hook */
static u16 size_hook(u16 type)
{
    return (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type));
}

/* a fresh 10-byte record in TYPE_POOL, zeroed */
static u16 new_record(void)
{
    u16 node = POOL_ALLOC_REUSE(TYPE_POOL_P, 10);
    RTL_MEMSET(TP(node), 0, 10);
    return node;
}

/* probably the offset of a kind's 10-byte entry in some per-kind table */
i16 KIND_TIMES_10(u8 kind)
{
    return (i16)(kind * 10);
}

/* a new array type of extent elements of type; flag marks a huge array (up to 16M bytes),
   others must fit in 64K (else "array size too large", the type still built) */
u16 NEW_ARRAY_TYPE(i32 extent, u16 type, u16 flag)
{
    i32 size = size_hook(type);
    if (flag) {
        if ((i32)((u32)size * (u32)extent) > 0xFFFFFF)
            REPORT_ERROR(MSG_ARRAY_SIZE_TOO_LARGE);
    } else if ((i32)((u32)size * (u32)extent) > 0xFFFF)
        REPORT_ERROR(MSG_ARRAY_SIZE_TOO_LARGE);
    u16 node = new_record();
    TYPE_B(node, TYPE_KIND) = 0x11;
    TYPE_W(node, TYPE_TARGET) = type;
    TYPE_L(node, TYPE_C_SIZE) = extent;
    TYPE_B(node, TYPE_C_BYTE9) = (u8)flag;
    return node;
}

/* a new enum type (kind 15h, size 2) with value in the word at +5 */
u16 MAKE_ENUM_TYPE(u16 value)
{
    u16 node = new_record();
    B(TP(node)) = 0x15;
    W(TP(node + 5)) = value;
    W(TP(node + 3)) = 2;
    return node;
}

/* a function type: return type, parameter list, calling convention, flags */
u16 NEW_FUNCTION_TYPE(u16 first, u16 second, u8 third, i16 fourth)
{
    u16 node = new_record();
    B(TP(node)) = 0x12;
    W(TP(node + 3)) = first;
    W(TP(node + 5)) = second;
    B(TP(node + 8)) = (u8)fourth;
    B(TP(node + 7)) = third;
    return node;
}

/* a pointer type: owner the pointed-to type, kind near..huge, the const and volatile bits,
   value the based-pointer base name, flags the near-pointer segment mode */
u16 NEW_POINTER_TYPE(u16 owner, u8 kind, i16 qualifier, u16 value, i16 flags)
{
    u16 node = new_record();
    B(TP(node)) = kind;
    B(TP(node + TYPE_C_PTR_QUALS)) = (u8)qualifier;
    W(TP(node + TYPE_C_PTR_BASE)) = value;
    B(TP(node + TYPE_C_FUNC_FLAGS)) = (u8)flags;
    W(TP(node + TYPE_C_TARGET)) = owner;
    return node;
}

/* an empty struct record (kind 13h, size 0 until its body is declared); value, probably
   struct or union, kept in byte 9 */
u16 NEW_STRUCT_TYPE(i8 value)
{
    u16 node = new_record();
    B(TP(node)) = 0x13;
    B(TP(node + TYPE_C_BYTE9)) = (u8)value;
    return node;
}

/* the size of a C type (1 for a null type): arrays multiply their counts down to the
   element type; a struct still of size 0 is undefined (reported with its tag name, and
   set to 1 so the error comes once); enums use their size word, other kinds
   KIND_INFO_TABLE's.  The factor is a 16-bit unsigned int, sign-extended from the table. */
i32 SIZE_OF_TYPE_CHECKED(u16 node)
{
    if (!node)
        return 1;
    u16 current = node;
    i32 length = 1;
    while (TYPE_B(current, TYPE_KIND) == 0x11) {
        length = (i32)((u32)length * (u32)TYPE_L(current, TYPE_C_SIZE));
        current = TYPE_W(current, TYPE_TARGET);
    }
    u16 factor;
    switch (TYPE_B(current, TYPE_KIND)) {
    case 0x13:
    case 0x14:
        factor = TYPE_W(current, TYPE_C_SIZE);
        if (!factor) {
            DIAG_NAME_BUFFER = 0;
            REPORT_ERROR(MSG_UNDEFINED_STRUCTURE,
                         NAME_TEXT_COPY(CSYM_W(TYPE_W(current, TYPE_C_TAG_SYMBOL), CSYM_NAME)));
            TYPE_W(current, TYPE_C_SIZE) = 1;
        }
        break;
    case 0x15:
        factor = TYPE_W(current, TYPE_C_SIZE);
        break;
    default:
        factor = (u16)KIND_INFO(TYPE_B(current, TYPE_KIND) * 4 + 3);
    }
    return (i32)((u32)length * factor);
}

/* 1 when every parameter of the function type keeps its type under the default argument
   promotions: float parameters never do; char and short (kind below TK_INT) only fail in
   strict ANSI mode */
i16 PARAMS_UNCHANGED_BY_PROMOTE(u16 node)
{
    for (u16 item = TYPE_W(node, TYPE_C_PARAMS); item; item = CPARM_W(item, CPARM_NEXT)) {
        u8 kind = B(TP(FAR_W(C_PARAM_POOL_SEG, item, CPARM_TYPE)));
        if (kind < 5) {
            if (LANGUAGE_MODE == 1)
                return 0;
        } else if (kind == 9)
            return 0;
    }
    return 1;
}

#define K(n) B(TP(n))
#define L(n) SD(TP((n) + 3))

/* the C-mode compatibility test: walks both types down (array element, return type,
   pointer target), recursing only for parameters.  mode 0: pointer qualifiers equal at
   every level; 1: the left may not have a const or volatile bit the right lacks; 2: as 1
   but from the second level; 3: qualifiers equal but void * matches char * and unsigned
   char *, passed on to parameters.  Struct, union and enum records match only themselves. */
i16 TYPE_RECORDS_COMPATIBLE(u16 left, u16 right, i8 mode)
{
    do {
        if (left == right)
            return 1;
        if (K(left) != K(right))
            return 0;
        switch (K(left)) {
        case 17:
            if (L(left) != L(right) && L(left) && L(right))
                return 0;
            left = TYPE_W(left, TYPE_TARGET);
            right = TYPE_W(right, TYPE_TARGET);
            break;
        case 19: case 20: case 21:
            return 0;
        case 18: {
            if (TYPE_SC(left, TYPE_C_CALL_CONV) != TYPE_SC(right, TYPE_C_CALL_CONV))
                return 0;
            i8 a = TYPE_SC(left, TYPE_C_FUNC_FLAGS), b = TYPE_SC(right, TYPE_C_FUNC_FLAGS);
            if (a & 8) {
                if ((a & ~8) != (b & ~8))
                    return 0;
                if (!(b & 8) && !PARAMS_UNCHANGED_BY_PROMOTE(right))
                    return 0;
            } else if (b & 8) {
                if ((b & ~8) != (a & ~8))
                    return 0;
                if (!(a & 8) && !PARAMS_UNCHANGED_BY_PROMOTE(left))
                    return 0;
            } else {
                if (a != b)
                    return 0;
                i8 nested = mode == 3 ? 3 : 0;
                u16 p, q;
                for (p = TYPE_W(left, TYPE_C_PARAMS), q = TYPE_W(right, TYPE_C_PARAMS); p && q;
                     p = CPARM_W(p, CPARM_NEXT), q = CPARM_W(q, CPARM_NEXT))
                    if (!TYPE_RECORDS_COMPATIBLE(CPARM_W(p, CPARM_TYPE), CPARM_W(q, CPARM_TYPE), nested))
                        return 0;
                if (p != q)
                    return 0;
            }
            goto children;
        }
        case 13:   /* near pointer: based pointers need the same base name */
            if (!TYPE_W(left, TYPE_C_PARAMS)) {
                if (TYPE_W(right, TYPE_C_PARAMS))
                    return 0;
            } else {
                if (!TYPE_W(right, TYPE_C_PARAMS))
                    return 0;
                if (COMPARE_NAME(MK_FP(POOL_HASH, TYPE_W(left, TYPE_C_PARAMS)),
                                 MK_FP(POOL_HASH, TYPE_W(right, TYPE_C_PARAMS))))
                    return 0;
            }
            /* fall through */
        case 14: case 15: case 16: {
            if (TYPE_SC(left, TYPE_C_FUNC_FLAGS) != TYPE_SC(right, TYPE_C_FUNC_FLAGS))
                return 0;
            i8 lq = TYPE_SC(left, TYPE_C_PTR_QUALS), rq = TYPE_SC(right, TYPE_C_PTR_QUALS);
            if (mode == 0 && lq != rq)
                return 0;
            if (mode == 3) {
                if (lq != rq)
                    return 0;
                u8 lk = K(TYPE_W(left, TYPE_C_SIZE)), rk = K(TYPE_W(right, TYPE_C_SIZE));
                if ((lk == 12 && rk <= 2) || (lk <= 2 && rk == 12))
                    return 1;
            } else if (mode == 1) {
                if ((lq & 1) > (rq & 1) || (lq & 2) > (rq & 2))
                    return 0;
            }
        }
        children:   /* the target or return type, at +3 */
            left = TYPE_W(left, TYPE_C_SIZE);
            right = TYPE_W(right, TYPE_C_SIZE);
        }
        if (mode == 2)
            mode = 1;
    } while (left && right);
    return left == right;
}

#undef K
#undef L

/* truncate a constant to an integer width: 1/2 signed/unsigned int, 3/4 char, 5/6 long
   (the same as CODE_MASK in expr/TRUNCVAL.C) */
i32 BCC_INTEGER_COERCE(i32 value, u8 mode)
{
    switch (mode) {
    case 1:
        value &= INT_LIMIT;
        if (value & ((INT_LIMIT + 1) >> 1))
            value |= ~INT_LIMIT;
        break;
    case 2:
        value &= INT_LIMIT;
        break;
    case 3:
        value &= MASK_B;
        if (value & ((MASK_B + 1) >> 1))
            value |= ~MASK_B;
        break;
    case 4:
        value &= MASK_B;
        break;
    case 5:
        value &= MASK_C;
        if (value & (i32)((u32)(MASK_C + 1) >> 1))
            value |= ~MASK_C;
        break;
    case 6:
        value &= MASK_C;
        break;
    }
    return value;
}

/* the bytes of an array type, all dimensions times the element size.  Over 64K it is a
   huge array in 64K segments: when the element size is not a power of two an element would
   straddle a boundary, so 10000h % size padding bytes go in front (*adjustment; 0
   otherwise), and over 128K with padding is too large. */
i32 ARRAY_DATA_LENGTH(u16 node, farptr adjustment)
{
    u16 current = node;
    i32 length = 1;
    while (TYPE_B(current, TYPE_KIND) == TK_ARRAY) {
        length = (i32)((u32)length * (u32)TYPE_L(current, TYPE_C_SIZE));
        current = TYPE_W(current, TYPE_TARGET);
    }
    u16 alignment = size_hook(current);
    length = (i32)((u32)length * alignment);
    W(adjustment) = 0;
    if (length <= 0x10000)
        return length;
    i16 padding = LOG2_POWER_OF_TWO(alignment);
    if (padding < 0) {
        padding = (i16)(0x10000 % (i32)alignment);
        if (length + padding > 0x20000)
            REPORT_ERROR(MSG_ARRAY_SIZE_TOO_LARGE);
        length += padding;
        W(adjustment) = (u16)padding;
    }
    return length;
}

/* one far segment for each started 64K of the array type; the first one is returned */
u16 ALLOC_ARRAY_SEGMENTS(u16 node)
{
    u16 mark = scratch_mark();
    i32 length = ARRAY_DATA_LENGTH(node, scratch_alloc(2));
    scratch_release(mark);
    u16 result = DEFINE_FAR_SEGMENT();
    while (length > 0x10000) {
        DEFINE_FAR_SEGMENT();
        length -= 0x10000;
    }
    return result;
}

/* reserve 64K or less through the hook, which takes a 16-bit count: a full 64K as two
   8000h pieces */
static void reserve(i32 chunk)
{
    if (chunk == 0x10000) {
        CALL_FAR(RESERVE_BYTES_HOOK, A16(0x8000));
        CALL_FAR(RESERVE_BYTES_HOOK, A16(0x8000));
    } else
        CALL_FAR(RESERVE_BYTES_HOOK, A16((u16)chunk));
}

/* uninitialised storage for the huge array variable node (a C symbol): the padding, the
   label, then the bytes in 64K pieces, each in the next segment from CSYM_SEGMENT */
void RESERVE_ARRAY_STORAGE(u16 node)
{
    u16 mark = scratch_mark();
    farptr adjustment_p = scratch_alloc(2);
    i32 remaining = ARRAY_DATA_LENGTH(CSYM_W(node, CSYM_TYPE), adjustment_p);
    u16 adjustment = W(adjustment_p);
    scratch_release(mark);
    i32 chunk;
    if (adjustment) {
        CALL_FAR(RESERVE_BYTES_HOOK, A16(adjustment));
        chunk = 0x10000 - adjustment;
        remaining -= adjustment;
    } else
        chunk = 0x10000;
    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(node));
    u16 item = CSYM_W(node, CSYM_SEGMENT);
    while (remaining) {
        CALL_FAR(STREAM_HOOK, A16(item));
        if (chunk > remaining)
            chunk = remaining;
        reserve(chunk);
        remaining -= chunk;
        chunk = 0x10000;
        item++;
    }
}

/* when the current output segment holds exactly 64K, switch to the next one */
void ADVANCE_IF_SEGMENT_FULL(void)
{
    if (CURRENT_SEGMENT_SIZE() == 0x10000) {
        i16 stream = (i16)CALL_FAR(STREAM_HOOK, A16(0));
        CALL_FAR(STREAM_HOOK, A16(stream + 1));
    }
}

/* after an initialiser filled the first offset elements of the huge array type, reserve
   the rest, filling the current segment first */
void RESERVE_ARRAY_REMAINDER(u16 node, u16 offset)
{
    u16 mark = scratch_mark();
    farptr adjustment_p = scratch_alloc(2);
    i32 remaining = ARRAY_DATA_LENGTH(TYPE_W(node, TYPE_TARGET), adjustment_p);
    remaining -= W(adjustment_p);
    scratch_release(mark);
    remaining = (i32)((u32)remaining * (u32)(TYPE_L(node, TYPE_C_SIZE) - offset));
    i32 chunk = 0x10000 - CURRENT_SEGMENT_SIZE();
    for (;;) {
        if (chunk > remaining)
            chunk = remaining;
        reserve(chunk);
        remaining -= chunk;
        if (!remaining)
            break;
        chunk = 0x10000;
        ADVANCE_IF_SEGMENT_FULL();
    }
}

/* for a huge array its padding byte count, else the alignment of its innermost kind */
i16 TYPE_ALIGNMENT_OR_HUGE_PAD(u16 node)
{
    if (TYPE_B(node, TYPE_KIND) == TK_ARRAY && TYPE_B(node, TYPE_C_BYTE9) != 0) {
        u16 mark = scratch_mark();
        farptr result = scratch_alloc(2);
        ARRAY_DATA_LENGTH(node, result);
        i16 value = (i16)W(result);
        scratch_release(mark);
        return value;
    }
    while (TYPE_B(node, TYPE_KIND) == TK_ARRAY)
        node = TYPE_W(node, TYPE_TARGET);
    return KIND_INFO(TYPE_B(node, TYPE_KIND) * 4 + 2);
}

/* small accessors of the C layout */
i16 GET_TYPE_FLAGS(u16 node) { return SB(TP(node + TYPE_C_FUNC_FLAGS)); }
i16 GET_TYPE_FLAGS_ALT(u16 node) { return SB(TP(node + TYPE_C_FUNC_FLAGS)); }
i16 GET_TYPE_QUALIFIERS(u16 node) { return SB(TP(node + TYPE_C_PTR_QUALS)); }
u8 GET_TYPE_KIND(u16 node) { return B(TP(node)); }

i16 IS_BASED_POINTER(u16 node)
{
    return B(TP(node)) == 0x0D && W(TP(node + TYPE_C_PARAMS)) != 0;
}

/* the number of parameters of a function type, 7FFFh without a prototype (any count);
   one more for the hidden return-slot pointer when it returns a struct that is not 1, 2
   or 4 bytes */
i16 COUNT_PARAMETERS(u16 input)
{
    u16 node = input;
    if (TYPE_B(node, TYPE_C_FUNC_FLAGS) & 8)
        return 0x7FFF;
    i16 count = 0;
    for (u16 item = TYPE_W(node, TYPE_C_PARAMS); item; item = W(MK_FP(C_PARAM_POOL_SEG, item + CPARM_NEXT)))
        count++;
    node = TYPE_W(node, TYPE_C_TARGET);
    if (TYPE_B(node, TYPE_KIND) == TK_STRUCT && (TYPE_W(node, TYPE_C_SIZE) > 4 || TYPE_W(node, TYPE_C_SIZE) == 3))
        count++;
    return count;
}

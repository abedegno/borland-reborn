/* hugedata.c: from bcc20/src/output/HUGEDATA.C: data for objects bigger than one 64 KB
   segment (huge arrays), and the segment-by-segment output of initialized far data.  Such
   an object gets a run of far data segments defined one after another, so their ids are
   consecutive: the stream for the next 64 KB is id + 1.  Output goes to the back end
   through hooks: STREAM_HOOK selects the segment written to (and returns the previous one),
   RESERVE_BYTES_HOOK adds that many zero bytes, DEFINE_SYMBOL_HERE_HOOK places the symbol
   at the current offset.  A count of 64 KB does not fit in a word, so a full segment is
   reserved as two halves of 8000h.
   An element must not straddle a segment boundary.  When the element size is not a power
   of two, 10000h % size bytes of padding are put in front of the array so the first segment
   ends exactly at an element boundary (padding at the front can line up only one segment
   boundary, which is probably why more than 128 KB with padding is refused as "Array size
   too large").  Nothing is written once NO_ERRORS_YET is cleared by an error. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"

static u16 stream(u16 segment) { return (u16)CALL_FAR(STREAM_HOOK, A16(segment)); }
static void reserve(u16 bytes) { CALL_FAR(RESERVE_BYTES_HOOK, A16(bytes)); }
static u16 symbol_segment(u16 prepared) { return (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(prepared)); }

/* the size in bytes of the (possibly multi-dimensional) array type type, plus the padding
   described above; adjustment receives the padding (0 if none or if the object fits in 64
   KB).  For arrays the long at TYPE_PARAMS holds the element count */
i32 C17MEASURE(u16 type, farptr adjustment)
{
    i32 length = 1;
    while (TYPE_W(type, TYPE_KIND) == 0x11) {
        length *= TYPE_L(type, TYPE_PARAMS);
        type = TYPE_W(type, TYPE_TARGET);
    }
    i32 element_size = TYPE_SIZE(type);
    length *= element_size;
    W(adjustment) = 0;
    if (length <= 0x10000L)
        return length;
    i32 padding = LOG2_POWER_OF_TWO((u32)element_size);
    if (padding < 0) {
        padding = 0x10000L % element_size;
        if (length + padding > 0x20000L)
            REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
        length += padding;
        W(adjustment) = (u16)padding;
    }
    return length;
}

/* defines as many far data segments as an object of type type needs (at least one) and
   returns the id of the first.  The padding word C17MEASURE writes sits at bp-6 in BCC's
   frame (6 bytes) */
u16 DEFINE_HUGE_DATA_SEGMENTS(u16 type)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    i32 length = C17MEASURE(type, v);
    u16 result = DEFINE_FAR_SEGMENT();
    while (length > 0x10000L) {
        DEFINE_FAR_SEGMENT();
        length -= 0x10000L;
    }
    scratch_release(mark);
    return result;
}

/* reserves chunk zero bytes, a full 64 KB as two halves */
static void reserve_chunk(i32 chunk)
{
    if (chunk == 0x10000L) {
        reserve(0x8000);
        reserve(0x8000);
    } else
        reserve((u16)chunk);
}

/* writes an uninitialized huge object: padding, the symbol's label, then zero bytes,
   moving to the next segment of its run after each 64 KB.  The padding word sits at bp-6
   in BCC's frame (0Ch bytes) */
void EMIT_HUGE_DATA(u16 symbol)
{
    if (!NO_ERRORS_YET)
        return;
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x0C);
    farptr adjustment_p = fp_add(v, 6);
    u16 prepared = PREPARE_SYMBOL(symbol);
    stream(symbol_segment(prepared));
    i32 remaining = C17MEASURE(SYM_W(symbol, SYM_TYPE), adjustment_p);
    u16 adjustment = W(adjustment_p);
    i32 chunk;
    if (adjustment) {
        reserve(adjustment);
        chunk = 0x10000L - adjustment;
        remaining -= adjustment;
    } else
        chunk = 0x10000L;
    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(prepared));
    u16 segment = symbol_segment(prepared);
    while (remaining) {
        stream(segment);
        if (chunk > remaining)
            chunk = remaining;
        reserve_chunk(chunk);
        remaining -= chunk;
        chunk = 0x10000L;
        ++segment;
    }
    scratch_release(mark);
}

/* starts writing the initializer of far array symbol: defines its segments if it has none
   yet (segment FFFFh), switches output to its first segment, places the label and the
   padding.  Returns the previously selected stream so the caller can switch back */
u16 BEGIN_ARRAY_DATA(u16 symbol)
{
    if (!NO_ERRORS_YET)
        return 0;
    u16 prepared = PREPARE_SYMBOL(symbol);
    if (symbol_segment(prepared) == 0xFFFF) {
        u16 segment = DEFINE_HUGE_DATA_SEGMENTS(SYM_W(symbol, SYM_TYPE));
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(segment));
    }
    u16 previous = stream(symbol_segment(prepared));
    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(prepared));
    i32 element_size = TYPE_SIZE(TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_TARGET));
    if (LOG2_POWER_OF_TWO((u32)element_size) < 0)
        reserve((u16)(0x10000L % element_size));
    return previous;
}

/* if the current segment is full (64 KB), continues in the next one: a newly defined far
   segment when advance is set, else the next segment of the run (id + 1) */
void NEXT_DATA_BANK(u8 advance)
{
    if (CURRENT_SEGMENT_SIZE() == 0x10000L) {
        if (advance)
            stream(DEFINE_FAR_SEGMENT());
        else {
            u16 previous = stream(0);
            stream(previous + 1);
        }
    }
}

/* adds remaining zero bytes to the data being written (the uninitialized tail of an
   initialized array), filling the current segment and moving on with NEXT_DATA_BANK; one
   span is written even when remaining starts at 0 */
void EMIT_DATA_SPANS(i32 remaining, u8 advance)
{
    if (!NO_ERRORS_YET)
        return;
    i32 chunk = 0x10000L - CURRENT_SEGMENT_SIZE();
    for (;;) {
        if (chunk > remaining)
            chunk = remaining;
        reserve_chunk(chunk);
        remaining -= chunk;
        if (!remaining)
            break;
        chunk = 0x10000L;
        NEXT_DATA_BANK(advance);
    }
}

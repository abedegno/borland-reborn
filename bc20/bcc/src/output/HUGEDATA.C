/* target: ovr073_C17UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: data output: huge and far arrays: defines the data segments a huge object needs and
   emits array data bank by bank. Entry points: DEFINE_HUGE_DATA_SEGMENTS, EMIT_HUGE_DATA,
   BEGIN_ARRAY_DATA, NEXT_DATA_BANK, EMIT_DATA_SPANS. Map of all sources:
   docs/SOURCE-MAP.md. */
#include <dos.h>
#include "HUGEDATA.H"
#include "MSG.H"
#include "FIELDS.H"
/* Overview: data for objects bigger than one 64 KB segment (huge arrays), and the
   segment-by-segment output of initialized far data. Such an object gets a run of far
   data segments defined one after another, so their ids are consecutive: the stream
   for the next 64 KB is "id + 1". Output goes to the back end through hooks:
   STREAM_HOOK selects the segment written to (and returns the previous one),
   RESERVE_BYTES_HOOK adds that many zero bytes, DEFINE_SYMBOL_HERE_HOOK places the
   symbol at the current offset. A count of 64 KB does not fit in a word, so a full
   segment is reserved as two halves of 0x8000.
   An element must not straddle a segment boundary. When the element size is not a
   power of two (LOG2_POWER_OF_TWO returns -1), 0x10000 % size bytes of padding are put
   in front of the array so the first segment ends exactly at an element boundary
   (padding at the front can line up only one segment boundary, which is probably why
   more than 128 KB with padding is refused as "Array size too large").
   Nothing is written once NO_ERRORS_YET is cleared by an error. */
#define T(n,o) (*(unsigned int far *)MK_FP(TYPE_POOL,(unsigned int)(n)+(o)))
#define TL(n,o) (*(long far *)MK_FP(TYPE_POOL,(unsigned int)(n)+(o)))
#define S(n,o) (*(unsigned int far *)MK_FP(SYMBOL_POOL_SEG,(unsigned int)(n)+(o)))

/* 0000: genuinely private FAR; the adjustment is a real FAR output. */
/* Returns the size in bytes of the (possibly multi-dimensional) array type type, plus
   the padding described above; *adjustment receives the padding (0 if none or if the
   object fits in 64 KB). For arrays TYPE_PARAMS (offset 9) holds the element count. */
static long far pascal C17MEASURE(register unsigned int type,
    unsigned int far *adjustment)
{
    long element_size;
    long length;
    long padding;
    length=1L;
    while(T(type,TYPE_KIND)==0x11) {
        length*=TL(type,TYPE_PARAMS);
        type=T(type,TYPE_TARGET);
    }
    element_size=TYPE_SIZE(type);
    length*=element_size;
    *adjustment=0;
    if(length<=0x10000L)
        return length;
    padding=LOG2_POWER_OF_TWO((unsigned long)element_size);
    if(padding<0L) {
        padding=0x10000L%element_size;
        if(length+padding>0x20000L)
            REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
        length+=padding;
        *adjustment=(unsigned int)padding;
    }
    return length;
}
/* 00FA: allocate at least one bank and retain the first bank's handle. */
/* Defines as many far data segments as an object of type type needs (at least one) and
   returns the id of the first. */
unsigned int far pascal DEFINE_HUGE_DATA_SEGMENTS(unsigned int type)
{
    long length;
    unsigned int result;
    length=C17MEASURE(type,&result);
    result=DEFINE_FAR_SEGMENT();
    while(length>0x10000L) {
        DEFINE_FAR_SEGMENT();
        length-=0x10000L;
    }
    return result;
}
/* 0140: emit complete bank spans, preserving callback and arena read order. */
/* Writes an uninitialized huge object: padding, the symbol's label, then zero bytes,
   moving to the next segment of its run after each 64 KB. */
void far pascal EMIT_HUGE_DATA(register unsigned int symbol)
{
    long remaining;
    unsigned int adjustment;
    long chunk;
    unsigned int prepared;
    register unsigned int stream;
    if(!NO_ERRORS_YET)
        return;
    prepared=PREPARE_SYMBOL(symbol);
    STREAM_HOOK(GET_SYMBOL_SEGMENT_HOOK(prepared));
    remaining=C17MEASURE(S(symbol,SYM_TYPE),&adjustment);
    if(adjustment) {
        RESERVE_BYTES_HOOK(adjustment);
        chunk=0x10000L-adjustment;
        remaining-=adjustment;
    } else
        chunk=0x10000L;
    DEFINE_SYMBOL_HERE_HOOK(prepared);
    stream=GET_SYMBOL_SEGMENT_HOOK(prepared);
    while(remaining) {
        STREAM_HOOK(stream);
        if(chunk>remaining)
            chunk=remaining;
        if(chunk==0x10000L) {
            RESERVE_BYTES_HOOK(0x8000);
            RESERVE_BYTES_HOOK(0x8000);
        } else
            RESERVE_BYTES_HOOK((unsigned int)chunk);
        remaining-=chunk;
        chunk=0x10000L;
        ++stream;
    }
}
/* 0234: initialize the stream and return the previous stream handle. */
/* Starts writing the initializer of far array symbol: defines its segments if it has
   none yet (segment 0xFFFF), switches output to its first segment, places the label and
   the padding. Returns the previously selected stream so the caller can switch back. */
unsigned int far pascal BEGIN_ARRAY_DATA(register unsigned int symbol)
{
    unsigned int previous;
    long element_size;
    register unsigned int prepared;
    if(!NO_ERRORS_YET)
        return 0;
    prepared=PREPARE_SYMBOL(symbol);
    if(GET_SYMBOL_SEGMENT_HOOK(prepared)==0xFFFF)
        SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_HUGE_DATA_SEGMENTS(S(symbol,SYM_TYPE)));
    previous=STREAM_HOOK(GET_SYMBOL_SEGMENT_HOOK(prepared));
    DEFINE_SYMBOL_HERE_HOOK(prepared);
    element_size=TYPE_SIZE(T(S(symbol,SYM_TYPE),TYPE_TARGET));
    if(LOG2_POWER_OF_TWO((unsigned long)element_size)<0)
        RESERVE_BYTES_HOOK((unsigned int)(0x10000L%element_size));
    return previous;
}
/* 02CE: actual BYTE formal; this routine has no NO_ERRORS_YET guard. */
/* If the current segment is full (64 KB), continues in the next one: a newly defined far
   segment when advance is set, else the next segment of the run (id + 1). */
void far pascal NEXT_DATA_BANK(unsigned char advance)
{
    unsigned int previous;
    if(CURRENT_SEGMENT_SIZE()==0x10000L) {
        if(advance)
            STREAM_HOOK(DEFINE_FAR_SEGMENT());
        else {
            previous=STREAM_HOOK(0);
            STREAM_HOOK(previous+1);
        }
    }
}
/* 0304: process one initial span even when remaining is initially zero. */
/* Adds remaining zero bytes to the data being written (the uninitialized tail of an
   initialized array), filling the current segment and moving on with NEXT_DATA_BANK. */
void far pascal EMIT_DATA_SPANS(long remaining,unsigned char advance)
{
    long chunk;
    if(!NO_ERRORS_YET)
        return;
    chunk=0x10000L-CURRENT_SEGMENT_SIZE();
    for(;;) {
        if(chunk>remaining)
            chunk=remaining;
        if(chunk==0x10000L) {
            RESERVE_BYTES_HOOK(0x8000);
            RESERVE_BYTES_HOOK(0x8000);
        } else
            RESERVE_BYTES_HOOK((unsigned int)chunk);
        remaining-=chunk;
        if(!remaining)
            break;
        chunk=0x10000L;
        NEXT_DATA_BANK(advance);
    }
}

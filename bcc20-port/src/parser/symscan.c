/* symscan.c: from bcc20/src/parser/SYMSCAN.C: the scan of every symbol at the end of a
   compilation unit, through the name hash table (1024 buckets of name chains in
   HASH_CHAIN_LINK_SEG, each name heading its symbols): a structure tag used but never
   defined (C only); static functions and data never used, and used functions never
   defined; tentative definitions given their storage now (BSS, a far segment, or huge data
   segments, through the output hooks); objects of unknown or zero size. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"

#define S(n, o) SYM_W((n), (o))
#define T(n) TYPE_W((n), 0)
#define BUCKET(i) W(fp_add(NAME_HASH_TABLE_P, (i) * 2))

static u16 segment_of(u16 prepared) { return (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(prepared)); }
static void set_segment(u16 prepared, u16 segment)
{
    CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(segment));
}

void SCAN_FILE_SYMBOLS(void)
{
    for (i16 bucket = 0; bucket < 1024; ++bucket)
        for (u16 chain = BUCKET(bucket); chain; chain = W(MK_FP(HASH_CHAIN_LINK_SEG, chain)))
            for (u16 symbol = W(MK_FP(NAME_POOL_SEG, chain)); symbol; symbol = S(symbol, 0)) {
                /* a structure tag (name-space kind 2): in C one of size 0 was never
                   defined; a tag ends this name's walk */
                if ((SYM_B(symbol, SYM_STORAGE_CLASS) & 7) == 2) {
                    if (!CPP_MODE && (EXPR_FLAGS_AT(T(S(symbol, 4))) & 0x40) && !TYPE_SIZE(S(symbol, 4)))
                        REPORT_DIAGNOSTIC(MSG_UNDEFINED_STRUCTURE_383, (i32)SYMBOL_NAME_TEXT(symbol), 0);
                    break;
                }
                u16 flags = SYM_B(symbol, SYM_FLAGS), prepared;
                switch (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) {
                case 2:         /* extern: only clears prepared flag 80h for a type of no size */
                    if (S(symbol, 8))
                        break;
                    prepared = PREPARE_SYMBOL(symbol);
                    if ((GET_PREPARED_FLAGS(prepared) & 0x80) && !TYPE_SIZE(S(symbol, 4)))
                        CLEAR_PREPARED_FLAGS(prepared, 0x80);
                    break;
                case 3:         /* file and block statics: unused ones reported, then as 1 */
                case 4:
                    if (!(flags & 4) && NO_ERRORS_YET && !(CPP_MODE && (SYM_B(symbol, SYM_INLINE_ACCESS) & 3) == 1))
                        REPORT_DIAGNOSTIC(MSG_DECLARED_BUT_NEVER, (i32)SYMBOL_NAME_TEXT(symbol), 0);
                    /* fall through */
                case 1:
                    if (flags & 1)      /* initialised: storage already emitted */
                        break;
                    prepared = PREPARE_SYMBOL(symbol);
                    if (T(S(symbol, 4)) == TK_FUNCTION) {
                        if (flags & 4)
                            REPORT_DIAGNOSTIC(MSG_UNDEFINED_SYMBOL, (i32)SYMBOL_NAME_TEXT(symbol), 0);
                        break;
                    }
                    if (T(S(symbol, 4)) == TK_ARRAY && (TYPE_B(S(symbol, 4), TYPE_ATTRS) & 0x40)) {
                        set_segment(prepared, DEFINE_HUGE_DATA_SEGMENTS(S(symbol, 4)));
                        EMIT_HUGE_DATA(symbol);
                        break;
                    }
                    /* a tentative definition: far data (attribute 80h) or BSS, aligned,
                       labelled and its size reserved */
                    if (segment_of(prepared) == 0xFFFF)
                        set_segment(prepared, (TYPE_B(S(symbol, 4), TYPE_ATTRS) & 0x80) ? DEFINE_FAR_SEGMENT() : BSS_SEGMENT_ID);
                    CALL_FAR(STREAM_HOOK, A16(segment_of(prepared)));
                    u16 alignment = (u16)CALL_FAR(TYPE_ALIGNMENT_HOOK, A16(S(symbol, 4)));
                    CALL_FAR(ALIGN_OUTPUT_HOOK, A16(alignment));
                    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(prepared));
                    u16 size = (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(S(symbol, 4)));
                    if (!size)
                        REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, (i32)SYMBOL_NAME_TEXT(symbol), 0);
                    else
                        CALL_FAR(RESERVE_BYTES_HOOK, A16(size));
                    break;
                }
            }
}

void CHECK_FILE_SYMBOLS(void)
{
    SCAN_FILE_SYMBOLS();
}

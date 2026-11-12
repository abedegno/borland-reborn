/* target: ovr078_C22UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: end-of-file symbol scan: undefined, unused, zero-size symbols. Entry points:
   CHECK_FILE_SYMBOLS. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: runs once at the end of a compilation unit, after the whole
   file has been parsed.  It walks every symbol reachable from the name
   hash table (NAME_HASH_TABLE, 1024 buckets; each bucket is a chain of
   name nodes in HASH_CHAIN_LINK_SEG, and each name node in NAME_POOL_SEG
   heads a list of symbols in SYMBOL_POOL_SEG that share the name).  For
   each symbol it:
     - reports a structure tag that was used but never defined (C only);
     - reports static functions or data declared but never used, and
       extern references to undefined functions;
     - for tentative definitions (data declared without an initializer)
       actually reserves the storage now: in the BSS segment, a far
       segment, or huge data segments, through the output hooks;
     - reports objects whose size is still unknown or zero.
   The S/SB/T/TB macros read words and bytes of symbol and type records at
   raw offsets (offset 4 of a symbol is its type, offset 8 probably its
   definition or initializer; offset 0 of a type is its kind).
   The real work is in the near helper; CHECK_FILE_SYMBOLS is only the far
   entry point the driver calls. */
#include <dos.h>
#include "SYMSCAN.H"
#include "MSG.H"
#include "POOL.H"
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) (*(unsigned char far *)MK_FP(SYMBOL_POOL_SEG,(unsigned int)(n)+(o)))
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) (*(unsigned char far *)MK_FP(TYPE_POOL,(unsigned int)(n)+(o)))

/* 0000: full bucket/chain/symbol traversal, genuine private near Y. */
static void near pascal SCAN_FILE_SYMBOLS(void)
{
    int bucket;
    unsigned int chain;
    unsigned int flags;
    unsigned int size;
    register unsigned int symbol;
    register unsigned int prepared;
    for(bucket=0;bucket<1024;++bucket) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for(symbol=AT_W(NAME_POOL_SEG,chain);symbol;symbol=S(symbol,0)) {
                /* Name-space kind 2 is a structure tag.  In C, a struct whose
                   size is still 0 was never defined.  A tag ends the walk of
                   this name's symbol list. */
                if((SB(symbol,SYM_STORAGE_CLASS)&7)==2) {
                    if(!CPP_MODE && (EXPR_FLAGS[T(S(symbol,4),0)]&0x40) &&
                       !TYPE_SIZE(S(symbol,4)))
                        REPORT_DIAGNOSTIC(MSG_UNDEFINED_STRUCTURE_383,SYMBOL_NAME_TEXT(symbol),0L);
                    break;
                }
                flags=SB(symbol,SYM_FLAGS);
                /* Dispatch on the storage class (bits 3-7; C0SELECT in
                   EXTDECL.C assigns them): 2 extern, which reserves no
                   storage and only clears prepared flag 0x80 when the type
                   has no size; 3 file static and 4 block static, which can
                   be reported unused; 1 a global definition.  Cases 3 and
                   4 fall through into case 1 on purpose. */
                switch(SB(symbol,SYM_STORAGE_CLASS)>>3) {
                case 2:
                    if(S(symbol,8))
                        break;
                    prepared=PREPARE_SYMBOL(symbol);
                    if((GET_PREPARED_FLAGS(prepared)&0x80) && !TYPE_SIZE(S(symbol,4)))
                        CLEAR_PREPARED_FLAGS(prepared,0x80);
                    break;
                case 3:
                case 4:
                    /* Never used (flag 4 clear), no errors so far
                       (NO_ERRORS_YET), and not a C++ inline function. */
                    if(!(flags&4) && NO_ERRORS_YET &&
                       !(CPP_MODE && (SB(symbol,SYM_INLINE_ACCESS)&3)==1))
                        REPORT_DIAGNOSTIC(MSG_DECLARED_BUT_NEVER,SYMBOL_NAME_TEXT(symbol),0L);
                case 1:
                    /* Initialised (flag 1): storage already emitted. */
                    if(flags&1)
                        break;
                    prepared=PREPARE_SYMBOL(symbol);
                    /* A function (TK_FUNCTION) that is used but has no body. */
                    if(T(S(symbol,4),0)==0x12) {
                        if(flags&4)
                            REPORT_DIAGNOSTIC(MSG_UNDEFINED_SYMBOL,SYMBOL_NAME_TEXT(symbol),0L);
                        break;
                    }
                    /* An array with attribute 0x40 (FIELDS.H calls it a far
                       array) gets its own data segments through
                       DEFINE_HUGE_DATA_SEGMENTS. */
                    if(T(S(symbol,4),0)==0x11 && (TB(S(symbol,4),TYPE_ATTRS)&0x40)) {
                        SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_HUGE_DATA_SEGMENTS(S(symbol,4)));
                        EMIT_HUGE_DATA(symbol);
                        break;
                    }
                    /* Otherwise it is a tentative definition: choose a segment
                       (far data if attribute 0x80, else BSS), align, place the
                       label and reserve its size in bytes. */
                    if(GET_SYMBOL_SEGMENT_HOOK(prepared)==0xFFFF) {
                        if(TB(S(symbol,4),TYPE_ATTRS)&0x80)
                            SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_FAR_SEGMENT());
                        else
                            SET_SYMBOL_SEGMENT_HOOK(prepared,BSS_SEGMENT_ID);
                    }
                    STREAM_HOOK(GET_SYMBOL_SEGMENT_HOOK(prepared));
                    ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK(S(symbol,4)));
                    DEFINE_SYMBOL_HERE_HOOK(prepared);
                    size=(unsigned int)SIZE_OF_TYPE_CHECKED_HOOK(S(symbol,4));
                    if(!size)
                        REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,SYMBOL_NAME_TEXT(symbol),0L);
                    else
                        RESERVE_BYTES_HOOK(size);
                    break;
                }
            }
        }
    }
}

/* 0286: sole FAR export; the helper owns all substantive work. */
void far pascal CHECK_FILE_SYMBOLS(void)
{
    SCAN_FILE_SYMBOLS();
}

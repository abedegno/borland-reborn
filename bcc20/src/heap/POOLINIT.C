/* target: CODE_2_RH1B1C */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: POOL_INIT allocates a pool's bank-0 block and keeps its segment in
   the pool's handle word. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry that allocates a bank-0 block of request bytes for a
   pool whose handle word is *output (for example &MALLOC_POOL_SEG): the
   block's segment is written there and kept up to date by the heap when the
   block moves.  It does not fill in a pool record's
   capacity, used or free-list words; POOLS.C does that.  It first makes sure
   there are spare descriptors.  When there is no room the status hook is
   called with (1, 100h) and the allocation retried if it frees memory;
   otherwise HEAP_STATUS is set to 1000h, the hook called with (1, 1000h) and
   1000h returned.  Returns 0 on success. */
/* Complete126-byte resident0094:1B1C..1B9A reconstruction.
   The scoped bounded-prefix verifier proves the genuine late CS load's
   reference. Hardware segment selection remains explicit below. */
#include <dos.h>
#include "RHOUT.H"
#include "RHHOOK.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
/* Existing real program-data byte supplies only its fixed segment here;
   this body neither reads it nor depends on its value or offset. */
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
/* Descriptive identity for the genuine near no-argument0138 body.
   It is not the unrelated RHCYCLE entry at000F; no address seed is added. */
extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);

static unsigned int far pascal _loadds POOL_INIT(unsigned int far *output,
    unsigned int request)
{
    HeapNode near *node;
    if(RH_PREPARE_DESCRIPTORS())
        goto failed;
retry:
    HEAP_STATUS=0;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if((node=HEAP_ALLOC_NODE(request))) {
        ((struct HeapOutputNodeView near *)node)->output=output;
        RH_UPDATE_NODE_ADDRESS(node,1);
        return 0;
    }
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    HEAP_HOOK_CALLSITE(1,0x100);
    if(HEAP_STATUS==0)
        goto retry;
failed:
    _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED);
    HEAP_STATUS=0x1000;
    HEAP_HOOK_CALLSITE(1,0x1000);
    return 0x1000;
}

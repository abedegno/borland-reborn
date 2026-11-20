/* target: CODE_2_RH1AE0 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: GROW_HEAP_TO grows the heap up to a requested top, used after TASM
   or TLINK has run. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry that grows bank 0 back up after it was shrunk with
   SHRINK_HEAP_TO, probably around running TASM or TLINK: the top is
   raised to the paragraph request, or to HEAP_SAVED_TOP_KEY (the top saved
   by SHRINK_HEAP_TO) when request is 0, by adding free space with
   EXTEND_HEAP.  The DOS memory block itself is probably resized by the
   caller. */
/* Unbuilt complete proposal for resident0094:1AE0..1B1C (60 bytes).
   Scoped void result follows the actual EXECMEM return chain to an AX kill.
   Program WORD default is read before selecting current heap bank DS. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern HeapNode near * near pascal EXTEND_HEAP(unsigned int amount);

static void far pascal _loadds GROW_HEAP_TO(unsigned int request)
{
    unsigned int limit=request;
    if(!limit)
        limit=HEAP_SAVED_TOP_KEY;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(ACTIVE_HEAP.chain_tail->key<limit)
        EXTEND_HEAP(limit-ACTIVE_HEAP.chain_tail->key);
}

/* target: CODE_2_RH2C7B */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: HANDLE_IN_BANK_5 tells whether a handle's node currently lives in
   bank 5. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry: nonzero when the block behind a handle word is in
   bank 5, that is, discarded or not yet loaded (only its descriptor
   exists). */
/* Complete reconstruction, original0094:2C7B..2CA7/full44. */
#include <dos.h>
#include "RHHEAP.H"
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *node_offset);

static unsigned int far pascal _loadds HANDLE_IN_BANK_5(unsigned int far *handle)
{
    HeapNode near *node;
    return BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node)==5;
}

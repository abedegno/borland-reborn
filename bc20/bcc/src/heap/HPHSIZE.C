/* target: CODE_2_RH2C48 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: HANDLE_BLOCK_SIZE returns the size of the block behind a handle.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry that returns the byte size last asked for (field8) of
   the block behind a handle word, in whatever bank it is. */
/* Complete reconstruction, original0094:2C48..2C7B/full51.
   Current-bank near view; no owned storage or observed-caller claim. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *node_offset);

static unsigned int far pascal _loadds HANDLE_BLOCK_SIZE(unsigned int far *handle)
{
    HeapNode near *node;
    unsigned int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    return node->field8;
}

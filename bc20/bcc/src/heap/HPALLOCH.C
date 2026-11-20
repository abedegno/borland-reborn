/* target: CODE_2_RH1B9A */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: the far allocation entry: allocates a node and a handle item
   pointing at it. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: HEAP_ALLOC_HANDLE, the far allocation entry for blocks that get
   a heap-owned handle (see HPGETITM.C for handle items).  It makes sure
   there are spare descriptors, takes a handle item, allocates a bank-0 node
   of request bytes (HEAP_ALLOC_NODE), points the node's output at the item,
   writes the block's segment into it and flags the node 4000h.  It returns
   the item's far address, which the caller keeps (for example OBJSEGS.C's
   object segment buffers).  When there is no room the status hook is
   called with (1, 100h); if it frees memory (HEAP_STATUS back to 0) the
   allocation is retried, else the item is given back, HEAP_STATUS is set to
   1000h, the hook is called with (1, 1000h) and 0 is returned. */
/* Complete181-byte reconstruction for resident0094:1B9A..1C4F.
   Both genuine CS-to-DS loads remain explicit hardware interop. The hook
   declaration describes its physical caller protocol, not a universal
   ordinary-returning ABI of the installed CDECL/nonlocal handler. */
#include <dos.h>
#include "RHOUT.H"
#include "RHHOOK.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
struct HeapItem;
extern struct HeapItem far * near pascal HEAP_ALLOC_ITEM(void);
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);
extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);

static unsigned int far * far pascal _loadds HEAP_ALLOC_HANDLE(unsigned int request)
{
    HeapNode near *node;
    struct HeapItem far *item;
    if(RH_PREPARE_DESCRIPTORS())
        goto failed;
    HEAP_STATUS=0;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    item=HEAP_ALLOC_ITEM();
    if(!item)
        goto failed;
retry:
    if((node=HEAP_ALLOC_NODE(request))) {
        ((struct HeapOutputNodeView near *)node)->output=(unsigned int far *)item;
        RH_UPDATE_NODE_ADDRESS(node,1);
        node->flags|=0x4000;
        return (unsigned int far *)item;
    }
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    HEAP_HOOK_CALLSITE(1,0x100);
    if(HEAP_STATUS==0) {
        _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
        goto retry;
    }
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    HEAP_FREE_ITEM(item);
failed:
    _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED);
    HEAP_STATUS=0x1000;
    HEAP_HOOK_CALLSITE(1,0x1000);
    return 0;
}

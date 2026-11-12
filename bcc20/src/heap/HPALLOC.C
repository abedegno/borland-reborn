/* target: CODE_2_RH110A */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: HEAP_ALLOC_NODE allocates a node: rounds the request, reclaims or
   extends space, first fit on the free list, then the request bank. Entry points:
   HEAP_ALLOC_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: HEAP_ALLOC_NODE, the general allocator of the active bank: it
   returns a used node of at least request bytes in the movable area, or 0
   (see HEAPMAIN.C's overview for banks and nodes).  It is every bank's
   hook_22, and is called directly for bank 0 by HEAP_ALLOC_HANDLE,
   POOL_INIT, ALLOC_BANK0_NODE and RESIZE_NODE.  Steps: round the request to
   units; make sure there is enough free space (bank 0, field5 & 4: reclaim
   other blocks with RECLAIM_FOR_SPACE; a swap bank, field5 & 80h: grow the
   file by 64K when SWAP_GROW_FILE_ALLOWED; other banks just fail); try the
   free cursor (the largest free node seen), then first fit on the free list
   (remembering the largest node passed as the new cursor), then the bank's
   hook_26, which compacts free space; cut the node found (RHSLICE), record
   the byte size in field8 and move the roving cursor past it (RHSETCUR). */
/* Complete zero-build proposal; no codegen/match/admission claim.
   Original native PUBLIC HEAP_ALLOC_NODE = resident0094:110A.
   Selected heap DS, near links and domain-qualified request26 contract. */
#include "RHALLOC.H"
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern unsigned int near pascal SWAP_EXTEND_FILE(unsigned long amount);
extern HeapNode near * near pascal EXTEND_HEAP(unsigned int amount);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,
    unsigned int size,unsigned char mode);
extern void near pascal RHSETCUR(HeapNode near *node);
/* Main-program DGROUP byte, independent of selected heap DS.
   Neutral new identity; original MZ SEGMENT16 field proves paragraph0DEF. */
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request)
{
    HeapNode near *node=0;
    unsigned int needed=RH_ROUND_REQUEST(request);
    if(ACTIVE_HEAP.field5&4) {
        if(RH_AVAILABLE_SPACE()<needed &&
           RECLAIM_FOR_SPACE(needed,ACTIVE_HEAP.current,ACTIVE_HEAP.head,
                  ACTIVE_HEAP.end))
            return 0;
    } else if(ACTIVE_HEAP.free_size<needed) {
        if((ACTIVE_HEAP.field5&0x80) && SWAP_GROW_FILE_ALLOWED) {
            if(!SWAP_EXTEND_FILE(0x10000UL))
                EXTEND_HEAP(0x80);
            else
                return 0;
        } else
            return 0;
    }
    node=ACTIVE_HEAP.free_cursor;
    if(node->size>=needed) {
        RHSLICE(node,needed,0);
        goto allocated;
    }
    for(node=ACTIVE_HEAP.free_head->next_free;
        node!=ACTIVE_HEAP.free_head;node=node->next_free) {
        if(node->size>=needed) {
            RHSLICE(node,needed,0);
            goto allocated;
        }
        if(node->size>ACTIVE_HEAP.free_cursor->size)
            ACTIVE_HEAP.free_cursor=node;
    }
    if((node=HEAP_REQUEST_BANK->request26.allocate(needed))) {
        RHSLICE(node,needed,0);
        goto allocated;
    }
    return 0;
allocated:
    node->field8=request;
    RHSETCUR(node);
    return node;
}

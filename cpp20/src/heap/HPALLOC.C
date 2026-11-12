/* target: HPALLOC */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPALLOC (0054:0A86, image 0xFC6): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPALLOC.C), with CPP.EXE's edits
   marked "CPP.EXE edit"; compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: HEAP_ALLOC_NODE allocates a node: rounds the request, reclaims
   space, first fit on the free list, then the request bank. Entry points:
   HEAP_ALLOC_NODE. */
/* Overview: HEAP_ALLOC_NODE, the general allocator of the active bank: it
   returns a used node of at least request bytes in the movable area, or 0
   (see HEAPMAIN.C's overview for banks and nodes).  It is every bank's
   hook_22 (set by INIT_BANK), and is called directly for bank 0 by
   HEAP_ALLOC_HANDLE, POOL_INIT, ALLOC_BANK0_NODE, RESIZE_NODE and
   INIT_MAIN_HEAP.  Steps: round the request to units; make sure there is
   enough free space (bank 0, field5 & 4: reclaim other blocks with
   RECLAIM_FOR_SPACE; other banks just fail; BCC.EXE also grows a swap bank's
   file here, and CPP.EXE has no swap bank); try the free cursor (the largest
   free node seen), then first fit on the free list (remembering the largest
   node passed as the new cursor), then the bank's hook_26, which compacts
   free space; cut the node found (RHSLICE), record the byte size in field8
   and move the roving cursor past it (RHSETCUR).  The C body runs with DS
   set to the active bank's descriptor segment; links are near. */
#include "CPPHEAP.H"
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern unsigned int near pascal SWAP_EXTEND_FILE(unsigned long amount);
extern HeapNode near * near pascal EXTEND_HEAP(unsigned int amount);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,
    unsigned int size,unsigned char mode);
extern void near pascal RHSETCUR(HeapNode near *node);
/* BCC's swap-growth switch, kept from BCC's source; CPP.EXE's code does not use
   it (nor RH_AVAILABLE_SPACE or SWAP_EXTEND_FILE above). */
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request)
{
    /* CPP.EXE edit: node is a register variable (SI) and needed stays on the
       stack (volatile: see ALLOC_FIXED_LOW in HPFIXLO.C). */
    register HeapNode near *node=0;
    volatile unsigned int needed=RH_ROUND_REQUEST(request);
    /* CPP.EXE edit: ACTIVE_HEAP.free_size where BCC calls RH_AVAILABLE_SPACE,
       and no swap-file growth: a heap without room fails at once. */
    if(ACTIVE_HEAP.field5&4) {
        if(ACTIVE_HEAP.free_size<needed &&
           RECLAIM_FOR_SPACE(needed,ACTIVE_HEAP.current,ACTIVE_HEAP.head,
                  ACTIVE_HEAP.end))
            goto failed;
    } else if(ACTIVE_HEAP.free_size<needed)
        goto failed;
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
failed:
    return 0;
allocated:
    node->field8=request;
    RHSETCUR(node);
    return node;
}

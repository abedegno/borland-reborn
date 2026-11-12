/* target: HPSLICE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE edits (HEAP2 agent): built with register variables on (BCC: -r-):
   RHSLICE keeps node/rest in SI/DI, the merge functions node in DI and next
   in SI (image 0x9E3..0xB0D, 0054:04A3..0054:05CD).  In CPP's merge functions the then-arm's jmp
   and the goto's jmp are one (mov di,[di+4]; jmp test), so BCC's
   "else (void)0;" dummy statements are gone; RH_MARK_FREE_AND_MERGE declares
   next `register` so that it gets SI (TC 2.01 otherwise gives node SI). */
/* CPP.EXE module HPSLICE: source taken from the BCC.EXE reconstruction
   (bcc20/src/heap/HPSLICE.C); compiled by Turbo C 2.01 (see CPPHEAP.H),
   with the CPP.EXE edits marked. */
/* Role: far-memory heap: RHSLICE splits a free node to a requested size; RH_COALESCE_FREE
   and RH_MARK_FREE_AND_MERGE merge free neighbours. Entry points: RHSLICE,
   RH_COALESCE_FREE, RH_MARK_FREE_AND_MERGE. */
/* Overview: cutting and merging nodes within the active bank (see
   HEAPMAIN.C's overview for nodes, the address-ordered chain and the free
   list).  Every allocator ends in RHSLICE: it takes a free node, cuts it to
   the size wanted and makes it a used node owned by the default owner tag
   (HEAP_DEFAULT_OWNER_TAG, see HPTAGS.C) in this bank.  mode 0 means the
   node is on the free list and the leftover goes back on it; the fixed
   allocators pass 18h for free nodes outside the movable area, which are
   not on the free list.  Releasing goes the other way: RH_COALESCE_FREE
   merges a free node on the free list with free neighbours (keeping
   free_size, current and free_cursor right), and RH_MARK_FREE_AND_MERGE does
   the same for space outside the movable area, which is not on the list.
   Merged-away nodes give their descriptors back (UNLINK_HEAP_NODE,
   RRETNDES.C). */
/* Splitting and merging heap nodes.
   RHSLICE cuts a node to size bytes, putting the rest in a new free node,
   and returns that node (or the original node when nothing was left over);
   RH_COALESCE_FREE and RH_MARK_FREE_AND_MERGE merge a node with free
   (flag 4) neighbours.

   Compiled through TASM (-B), because RHSLICE reads the program's
   HEAP_DEFAULT_OWNER_TAG through ES with inline asm.  In BCC.EXE's copy that
   asm is why the compiler reloads BX and does not share the two
   "mov [1Ch],ax" tails; plain C gives neither there.
   Documented exceptions:
   - _ES=ACTIVE_HEAP.program_segment in RHSLICE: segment set-up, as in HPALLOCH.
   - _AL just after it (pseudo-register read): the byte the asm loaded.
   - (BCC only, removed for CPP) In both merge functions, "else (void)0;"
     kept the then-arm's jmp ahead of the goto's own jmp.
   - Shape gotos: the loop test is written as statements after a label
     (goto test / goto merge) because the original stores next and reloads
     it before the test.  A while condition gives "mov bx,ax"; the comma
     form while(next=node->next,next->flags&4) gives and/or instead of test. */
#include <dos.h>
#include "CPPHEAP.H"
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal UNLINK_HEAP_NODE(HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RHUNLINK(HeapNode near *node);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);

/* Cut node to size units.  Returns the new free node holding the rest, or
   node itself when nothing is left over (the fixed allocators compare the
   two).  The used node gets flags 0, the default owner tag, this bank in
   field19 and no callback. */
HeapNode near * near pascal RHSLICE(HeapNode near *node,unsigned int size,
    unsigned char mode)
{
    unsigned int remaining;
    HeapNode near *rest;
    remaining=node->size-size;
    rest=node;              /* returned as is when nothing is split off */
    if(!mode) RHUNLINK(node);
    if(remaining>0) {
        rest=RNEWNODE();
        rest->size=remaining;
        node->size=size;
        rest->key=node->key+size;
        RHLINK(node,rest);
        rest->flags=4;
        if(!mode) {
            ADD_FREE_NODE(rest);
            ACTIVE_HEAP.free_cursor=rest;
        }
    } else if(!mode)
        ACTIVE_HEAP.free_cursor=ACTIVE_HEAP.free_head->next_free;
    node->flags=0;
    _ES=ACTIVE_HEAP.program_segment;
    asm mov al,es:[offset DGROUP:HEAP_DEFAULT_OWNER_TAG];
    node->field12=_AL;
    node->field19=ACTIVE_HEAP.field4;
    node->field18=0;
    return rest;
}

/* Merge a free node (on the free list) with the free node before it and all
   free nodes after it; the merged ones leave the free list and the chain
   and their descriptors are returned. */
void near pascal RH_COALESCE_FREE(HeapNode near *node)
{
    HeapNode near *next;
    if(node->previous->flags&4) node=node->previous;
    goto test;              /* shape goto: test at the bottom, see header */
merge:
    RHUNLINK(next);
    node->next=next->next;
    next->next->previous=node;
    node->size+=next->size;
    ACTIVE_HEAP.free_size+=next->size;
    if(next==ACTIVE_HEAP.current) ACTIVE_HEAP.current=node;
    if(next==ACTIVE_HEAP.free_cursor) ACTIVE_HEAP.free_cursor=node;
    UNLINK_HEAP_NODE(next);
test:
    next=node->next;
    if(next->flags&4) goto merge;
}

/* Mark node free and merge it with free neighbours, without touching the
   free list or free_size: for space outside the movable area (fixed
   regions), which the allocators do not search. */
void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node)
{
    register HeapNode near *next;   /* CPP.EXE edit: next in SI, node in DI */
    node->flags=4;
    if(node->previous->flags&4) node=node->previous;
    goto test;              /* shape goto: test at the bottom, see header */
merge:
    node->next=next->next;
    next->next->previous=node;
    node->size+=next->size;
    UNLINK_HEAP_NODE(next);
test:
    next=node->next;
    if(next->flags&4) goto merge;
}

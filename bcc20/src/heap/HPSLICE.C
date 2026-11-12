/* target: CODE_2_RG2A1 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: RHSLICE splits a free node to a requested size; RH_COALESCE_FREE
   and RH_MARK_FREE_AND_MERGE merge free neighbours. Entry points: RHSLICE,
   RH_COALESCE_FREE, RH_MARK_FREE_AND_MERGE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: cutting and merging nodes within the active bank (see
   HEAPMAIN.C's overview for nodes, the address-ordered chain and the free
   list).  Every allocator ends in RHSLICE: it takes a free node, cuts it to
   the size wanted and makes it a used node owned by the default owner tag
   (HEAP_DEFAULT_OWNER_TAG, see HPOWNTAG.C) in this bank.  mode 0 means the
   node is on the free list and the leftover goes back on it; the fixed
   allocators pass 18h for free nodes outside the movable area, which are
   not on the free list.  Releasing goes the other way: RH_COALESCE_FREE
   merges a free node on the free list with free neighbours (keeping
   free_size, current and free_cursor right), and RH_MARK_FREE_AND_MERGE does
   the same for space outside the movable area, which is not on the list.
   Merged-away nodes give their descriptors back (RRETNDES, which callers
   name UNLINK_HEAP_NODE). */
/* CODE_2:05D5..077F: splitting and merging heap nodes.
   RHSLICE cuts a node to size bytes, putting the rest in a new free node,
   and returns that node (or the original node when nothing was left over);
   RH_COALESCE_FREE and RH_MARK_FREE_AND_MERGE merge a node with free
   (flag 4) neighbours.

   Compiled through TASM (-B), because RHSLICE reads the program's
   HEAP_DEFAULT_OWNER_TAG through ES with inline asm.  That asm is why BCC reloads BX
   at 066F and does not share the two "mov [1Ch],ax" tails (0647, 065C);
   plain C gives neither: a far pointer from MK_FP, and an _es pointer
   (as in HPSHRINK) both let BCC keep BX and merge the tails.
   Documented exceptions:
   - _ES=ACTIVE_HEAP.program_segment at 0667: segment set-up, as in HPALLOCH.
   - _AL at 0672 (pseudo-register read): the byte the asm loaded.
   - In both merge functions, "else (void)0;" (dummy statement) keeps the
     then-arm's jmp at 06A3/0738 ahead of the goto's own jmp (06A5/073A).
   - Shape gotos: the loop test is written as statements after a label
     (goto test / goto merge) because the original stores next and reloads
     it before the test.  A while condition gives "mov bx,ax"; the comma
     form while(next=node->next,next->flags&4) gives and/or instead of test. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
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
    else (void)0;
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
    HeapNode near *next;
    node->flags=4;
    if(node->previous->flags&4) node=node->previous;
    else (void)0;
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

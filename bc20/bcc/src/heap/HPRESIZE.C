/* target: CODE_2_RG2A9 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RESIZE_NODE grows or shrinks a node in place or by moving it, with
   SWAP_WITH_FREE_NODE exchanging a node with a free one. Entry points: RESIZE_NODE. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: growing a bank-0 node to a new byte size (see HEAPMAIN.C's
   overview for nodes and the head/end bounds of the movable area).
   CHANGE_HEAP_NODE_MODE (RHAPI.C, mode 1000h) and RH_GROW_DESCRIPTORS
   (HPDESC.C) call RESIZE_NODE; shrinking is SHRINK_NODE (HPSHRNKN.C).
   RESIZE_NODE tries, in order: reclaim space if too little is free; grow
   into a free node just above; for a fixed node, give up unless it sits just
   below head; swap with a free node just below and grow; move the block into
   a big enough free node elsewhere (exchanging the two nodes' places in the
   chain, so the old place becomes the free one); finally compact free space
   next to the block (GATHER_FREE_AT_LOW_END above it, GATHER_FREE_AT_HIGH_END
   below it).  "outside" means the node lies outside the movable area (fixed
   blocks), where freed space is merged but not put on the free list.
   head is stepped back one node around the moves and forward again after,
   probably so a node at head is treated as inside the area while it
   changes. */
#include "RHHEAP.H"
struct HeapLinks { HeapNode near *previous,*next; };
#define LINKS(n) (*(struct HeapLinks near *)&(n)->previous)
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,HeapNode near *first,
    HeapNode near *restart,HeapNode near *stop);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,unsigned int size,
    unsigned char mode);
extern HeapNode near * near pascal GATHER_FREE_AT_LOW_END(unsigned int needed,
    HeapNode near *start,HeapNode near *stop);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);
extern void near pascal RHSWAP(HeapNode near *node);
extern void near pascal RHSETCUR(HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RHUNLINK(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);
extern void near pascal UNLINK_HEAP_NODE(HeapNode near *node);

/* Exchange a node with the free node just below it: move the block down to
   free's key (move_node_2c), swap their places in the chain (RHSWAP), then
   merge the free node, now above, with its free neighbours (on the free list
   unless outside).  Written in K&R form; the pascal prototype after it gives
   callers the pascal convention. */
void near SWAP_WITH_FREE_NODE(node,free,outside)
HeapNode near *node;
HeapNode near *free;
char outside;
{
    outside=outside;    /* ARGSUSED-style self-assignment: the original
                           narrows the char parameter in place */
    ACTIVE_HEAP.move_node_2c(node,free->key);
    RHSWAP(free);
    if(outside) RH_MARK_FREE_AND_MERGE(free);
    else RH_COALESCE_FREE(free);
    if(ACTIVE_HEAP.head==free) ACTIVE_HEAP.head=node;
}
void near pascal SWAP_WITH_FREE_NODE(HeapNode near *node,HeapNode near *free,
    char outside);

/* Grow node to size bytes (see the overview).  Returns the node, which may
   have moved, or 0 when there is no room.  tracked_size grows with a
   tracked node. */
HeapNode near * near pascal RESIZE_NODE(HeapNode near *node,unsigned int size)
{
    unsigned int rounded;
    unsigned int delta;
    HeapNode near *other;
    unsigned char outside;
    unsigned int key;
    struct HeapLinks links;
    rounded=RH_ROUND_REQUEST(size);
    delta=rounded-node->size;
    outside=node->key<ACTIVE_HEAP.head->key || node->key>=ACTIVE_HEAP.end->key;
    if(RH_AVAILABLE_SPACE()<delta) {
        other=node->next;
        if((other==ACTIVE_HEAP.end || RECLAIM_FOR_SPACE(delta,other,other,ACTIVE_HEAP.end))
                && RECLAIM_FOR_SPACE(delta,ACTIVE_HEAP.current,ACTIVE_HEAP.head,ACTIVE_HEAP.end))
            return 0;
    }
    other=node->next;
    if((other->flags&4) && other->size>=delta) goto grow;
    if(node->flags&0x18) {
        if(node->next==ACTIVE_HEAP.head) goto in_place;
        return 0;
    }
    other=node->previous;
    if((other->flags&4) && other->size>=delta) {
        SWAP_WITH_FREE_NODE(node,other,outside);
        goto grow;
    }
    /* Move the whole block into a free node of the new size: from the free
       cursor, a search of the free list, or a fresh allocation for an
       outside node.  The two nodes then trade places in the chain (key,
       size and links), so other becomes the old space and is freed. */
    if(ACTIVE_HEAP.free_size>=rounded) {
    other=ACTIVE_HEAP.free_cursor;
    if(other->size<rounded) {
        for(other=ACTIVE_HEAP.free_head->next_free;other!=ACTIVE_HEAP.free_head;
                other=other->next_free) {
            if(other->size>=rounded) goto found;
            if(other->size>ACTIVE_HEAP.free_cursor->size)
                ACTIVE_HEAP.free_cursor=other;
        }
        if(outside==0) goto in_place;
        if(!(other=HEAP_ALLOC_NODE(size))) return 0;
    } else {
found:
        RHSLICE(other,rounded,0);
    }
    ACTIVE_HEAP.head=ACTIVE_HEAP.head->previous;
    key=node->key;
    links=LINKS(node);
    ACTIVE_HEAP.move_node_2c(node,other->key);
    other->key=key;
    other->size=node->size;
    node->size=rounded;
    other->next->previous=node;
    node->next->previous=other;
    other->previous->next=node;
    node->previous->next=other;
    LINKS(node)=LINKS(other);
    LINKS(other)=links;
    if(outside) RH_MARK_FREE_AND_MERGE(other);
    else {
        ADD_FREE_NODE(other);
        RH_COALESCE_FREE(other);
    }
    /* The next three statements repeat the start of done: BCC tail-merges
       them into the original's jmp 17DB and keeps the dead jmp after it. */
    ACTIVE_HEAP.head=ACTIVE_HEAP.head->next;
    node->field8=size;
    RHSETCUR(node);
    goto done;
    } else {
    /* Compact free space next to the block: above it, else below it (then
       swap down into it).  The last resort swaps with the node below. */
in_place:
    other=node->next;
    if(other!=ACTIVE_HEAP.end && (other=GATHER_FREE_AT_LOW_END(delta,other,ACTIVE_HEAP.end))!=0)
        goto grow;
    if(node->flags&0x18) return 0;
    if(node!=ACTIVE_HEAP.head) {
        if((other=GATHER_FREE_AT_HIGH_END(delta,ACTIVE_HEAP.head,node))!=0) {
            SWAP_WITH_FREE_NODE(node,other,outside);
            goto grow;
        }
    } else return 0;
    other=node->previous;
    SWAP_WITH_FREE_NODE(node,other,outside);
    RH_COALESCE_FREE(other);
    /* other is a free node right above node with at least delta units: take
       delta units from its start (or all of it). */
grow:
    ACTIVE_HEAP.head=ACTIVE_HEAP.head->previous;
    if(other->size==delta) {
        if(other->key>=ACTIVE_HEAP.head->key && other->key<ACTIVE_HEAP.end->key) {
            RHUNLINK(other);
            ACTIVE_HEAP.free_cursor=ACTIVE_HEAP.free_head->next_free;
        }
        UNLINK_HEAP_NODE(other);
    } else {
        other->size-=delta;
        other->key+=delta;
        if(other->key>=ACTIVE_HEAP.head->key && other->key<ACTIVE_HEAP.end->key)
            ACTIVE_HEAP.free_size-=delta;
    }
    node->size=rounded;
    }
    ACTIVE_HEAP.head=ACTIVE_HEAP.head->next;
    node->field8=size;
    RHSETCUR(node);
done:
    if(node->flags&0x60) ACTIVE_HEAP.tracked_size+=delta;
    return node;
}

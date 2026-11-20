/* target: CODE_2_RH0F0A */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: GATHER_FREE_AT_HIGH_END moves nodes to collect a free block of the
   needed size at the high end of the heap. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: compaction toward the low end (see HEAPMAIN.C's overview for
   nodes and the movable area).  Starting at start and walking back toward
   stop, it adds up free space until needed units are found (or stop is
   reached).  Then, from that point up to start, it slides every used block
   down over the gaps (move_node_2c, which rewrites its handle), deletes the
   free nodes, and makes one free node of the total just below start, which
   also becomes current and free_cursor.  head is stepped back and forward
   around the change, probably so it stays valid if the node it named is
   deleted.  Returns the free node when it is big enough, else 0 (the
   compaction is done anyway).  The callers pass (needed, head, end) to
   compact the whole movable area. */
/* Unbuilt ordinary-C caller proposal; foreign move callbacks may rebase DS. */
#include "RHHEAP.H"
extern void near pascal RHUNLINK(HeapNode near *node);
struct PoolNode;
extern void near pascal UNLINK_HEAP_NODE(struct PoolNode near *node);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
static HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start)
{
    HeapNode near *cursor=start;
    unsigned int space=0;
    while(cursor!=stop && space<needed) {
        cursor=cursor->previous;
        if(cursor->flags&4)
            space+=cursor->size;
    }
    if(space) {
        unsigned int key=cursor->key;
        HeapNode near *next=cursor;
        ACTIVE_HEAP.head=ACTIVE_HEAP.head->previous;
        while(cursor!=start) {
            if(cursor->flags&4) {
                next=cursor->next;
                RHUNLINK(cursor);
                UNLINK_HEAP_NODE((struct PoolNode near *)cursor);
                cursor=next;
            } else {
                if(cursor->key!=key)
                    ACTIVE_HEAP.move_node_2c(cursor,key);
                key+=cursor->size;
                cursor=cursor->next;
            }
        }
        RHLINK(cursor->previous,RNEWNODE());
        cursor=cursor->previous;
        cursor->size=space;
        cursor->key=key;
        ADD_FREE_NODE(cursor);
        ACTIVE_HEAP.current=cursor;
        ACTIVE_HEAP.free_cursor=cursor;
        ACTIVE_HEAP.head=ACTIVE_HEAP.head->next;
    }
    if(space<needed)
        return 0;
    return cursor;
}

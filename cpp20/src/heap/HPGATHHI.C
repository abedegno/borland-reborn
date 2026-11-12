/* target: HPGATHHI */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPGATHHI (0054:0902, image 0xE42): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPGATHHI.C), with one CPP.EXE edit
   (marked); compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: GATHER_FREE_AT_HIGH_END moves nodes to collect a free block of the
   needed size at the high end of the heap. */
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
   compact the whole movable area.  A bank's move hook may change DS. */
#include "CPPHEAP.H"
extern void near pascal RHUNLINK(HeapNode near *node);
struct PoolNode;
extern void near pascal UNLINK_HEAP_NODE(struct PoolNode near *node);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
/* link: GATHER_FREE_AT_HIGH_END is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start)
{
    /* CPP.EXE edit: cursor and next are register variables (SI, DI); Turbo C
       2.01 gives SI and DI to them only when they are declared register. */
    register HeapNode near *cursor=start;
    unsigned int space=0;
    while(cursor!=stop && space<needed) {
        cursor=cursor->previous;
        if(cursor->flags&4)
            space+=cursor->size;
    }
    if(space) {
        unsigned int key=cursor->key;
        register HeapNode near *next=cursor;
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

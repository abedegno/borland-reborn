/* target: HPGATHLO */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPGATHLO (0054:09C4, image 0xF04): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPGATHLO.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: GATHER_FREE_AT_LOW_END moves nodes to collect a free block of the
   needed size at the low end of the heap. */
/* Overview: the mirror of GATHER_FREE_AT_HIGH_END: from start walking up
   toward stop it adds up free space until needed units are found, then
   slides the used blocks in that span up (move_node_2e) and makes one free
   node at the low end of the span, at start's old key.  Returns it when big
   enough, else 0.  Used by ALLOC_FIXED_LOW and RESIZE_NODE. */
#include "CPPHEAP.H"
extern void near pascal RHUNLINK(HeapNode near *node);
struct PoolNode;
extern void near pascal UNLINK_HEAP_NODE(struct PoolNode near *node);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
/* link: GATHER_FREE_AT_LOW_END is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
HeapNode near * near pascal GATHER_FREE_AT_LOW_END(unsigned int needed,
    HeapNode near *start,HeapNode near *stop)
{
    HeapNode near *cursor=start;
    unsigned int space=0;
    while(cursor!=stop && space<needed) {
        if(cursor->flags&4)
            space+=cursor->size;
        cursor=cursor->next;
    }
    if(space) {
        unsigned int key=cursor->key;
        HeapNode near *before=cursor;
        ACTIVE_HEAP.head=ACTIVE_HEAP.head->previous;
        while(before!=start) {
            before=cursor->previous;
            if(before->flags&4) {
                RHUNLINK(before);
                UNLINK_HEAP_NODE((struct PoolNode near *)before);
            } else {
                key-=before->size;
                if(before->key!=key)
                    ACTIVE_HEAP.move_node_2e(before,key);
                cursor=before;
            }
        }
        RHLINK(cursor->previous,RNEWNODE());
        cursor=cursor->previous;
        cursor->size=space;
        cursor->key=key-space;
        ADD_FREE_NODE(cursor);
        ACTIVE_HEAP.current=cursor;
        ACTIVE_HEAP.free_cursor=cursor;
        ACTIVE_HEAP.head=ACTIVE_HEAP.head->next;
    }
    if(space<needed)
        return 0;
    return cursor;
}

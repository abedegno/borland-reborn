/* target: CODE_2_RG2A6 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: moves a node's contents out to another bank (RH_TRY_FLAG20) or to
   bank 5 (RH_TRY_FLAG40) and frees its place; clears ring entries. Entry points:
   RH_TRY_FLAG20, RH_TRY_FLAG40, RH_CLEAR_TAG_ENTRY. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: eviction, the way the heap frees conventional memory (bank 0)
   when an allocation does not fit (see HEAPMAIN.C's overview for banks,
   nodes, handles and flags).  RH_RECLAIM_NODE (HPRCLNOD.C) picks one of the
   two routines here by the node's flags.  A node flagged 20h is moved: its
   contents are written into another bank (EMS, extended memory or a swap
   file) and its descriptor goes with it, flagged 80h.  A node flagged 40h
   is discarded: only its descriptor is kept, in bank 5, flagged 100h, and
   its callback (field18, through RH_DISPATCH_NODE) is told so it can rebuild
   the contents later.  Either way the bank-0 space becomes free and the
   owner's handle is switched to the descriptor-index form; a later
   CHANGE_HEAP_NODE_MODE on the block brings it back into bank 0.
   Both keep the tracked totals (tracked_nodes, tracked_size: reclaimable
   nodes) and the tagged total (tagged_size) in step: when less than a
   quarter of the tracked size is tagged, RING_ADVANCE_CURSOR tags one more
   ring entry.  NODE_METADATA rebuilds a node's output pointer from its two
   words at +0Eh. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
struct HeapItem;
extern unsigned int far HEAP_PROGRAM_DS;
extern HeapNode near *HANDLE_RING_NODES[];
extern unsigned int near cdecl RH_HEAP_DISPATCH(unsigned int bank,unsigned int operation,...);
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
extern HeapNode near * near pascal RH_COPY_DESCRIPTOR(unsigned int source_bank,
    unsigned int target_bank,HeapNode near *source,HeapNode near *target);
extern void near pascal RING_ADVANCE_CURSOR(void);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);
extern unsigned int near pascal RH_RELEASE_DESCRIPTOR(HeapNode near *node);
extern unsigned int near pascal OVR_IMAGE_SIZE(void far *metadata);
#define NODE_METADATA(n) MK_FP((unsigned int)(n)->next_free,(unsigned int)(n)->previous_free)

void near pascal RH_CLEAR_TAG_ENTRY(HeapNode near *node);

/* Move a bank-0 node out to another bank.  When the node already has a
   valid copy there (flag 2000h) that copy is reused and only the callback
   is told (operation 4).  Otherwise banks 4 down to (flags & 3) + 1 are
   tried: allocate a copy of field8 bytes there (operation 0), tell the
   callback, write the contents in (operation 2).  Then the bank-0 node is
   freed and the copy takes over the descriptor data and the handle (index
   form).  Returns 0, or 1000h when no bank had room.  DS is bank 0 on
   return. */
unsigned int near pascal RH_TRY_FLAG20(HeapNode near *node)
{
    int bank;
    int low;
    HeapNode near *copy;
    if(node->flags&0x2000) {
        low=0;
        bank=node->field19>>3;
        copy=(HeapNode near *)((struct HeapReleaseNode near *)node)->bank_handle;
        RH_DISPATCH_NODE(node,4,NODE_METADATA(node),node->flags&0x400);
    } else {
        low=(node->flags&3)+1;
        for(bank=4;bank>=low;bank--) {
            if((copy=(HeapNode near *)RH_HEAP_DISPATCH(bank,0,node->field8))!=0) {
                if(node->field18) {
                    RH_UPDATE_NODE_ADDRESS(node,4);
                    RH_DISPATCH_NODE(node,4,NODE_METADATA(node),node->flags&0x400);
                    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
                    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
                }
                RH_HEAP_DISPATCH(bank,2,copy,node->key);
                break;
            }
        }
        if(bank<low) goto fail;
    }
    if(node->flags&0x60) {
        --ACTIVE_HEAP.tracked_nodes;
        ACTIVE_HEAP.tracked_size-=node->size;
    }
    if((ACTIVE_HEAP.tracked_size>>2)>ACTIVE_HEAP.tagged_size) RING_ADVANCE_CURSOR();
    if(node->flags&0x1000) RH_CLEAR_TAG_ENTRY(node);
    RH_COPY_DESCRIPTOR(0,bank,node,copy);
    if(node->flags&0x400) ACTIVE_HEAP.field52-=node->size;
    if(node->key>=ACTIVE_HEAP.head->key && node->key<ACTIVE_HEAP.end->key) {
        ADD_FREE_NODE(node);
        RH_COALESCE_FREE(node);
    } else
        RH_MARK_FREE_AND_MERGE(node);
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm mov bx,bank;
    asm shl bx,1;
    asm mov ds,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS[bx];
    copy->field19=ACTIVE_HEAP.field4;
    copy->flags&=~0x2000;
    copy->flags|=0x80;
    RH_UPDATE_NODE_ADDRESS(copy,2);
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    return 0;
fail:
    return 0x1000;
}

/* Discard a bank-0 node.  Any copy in another bank is released and the
   callback is asked first (operation 1).  If it returns 0, the descriptor is
   moved to a new bank-5 node (flag 100h; for a 400h node field8 becomes the
   overlay image size, OVR_IMAGE_SIZE) and the bank-0 space freed; 1000h is
   returned when bank 5 has no descriptor.  If the callback returns nonzero,
   the block is dropped for good: its handle is freed or cleared and the
   node released.  Returns 0 on success. */
unsigned int near pascal RH_TRY_FLAG40(HeapNode near *node)
{
    HeapNode near *copy;
    unsigned int result;
    result=0;
    RH_UPDATE_NODE_ADDRESS(node,4);
    if(node->flags&0x2000) {
        RH_HEAP_DISPATCH(node->field19>>3,1,
            ((struct HeapReleaseNode near *)node)->bank_handle);
        node->flags&=~0x2000;
    }
    if((ACTIVE_HEAP.tracked_size>>2)>ACTIVE_HEAP.tagged_size) RING_ADVANCE_CURSOR();
    if(node->field18) result=RH_DISPATCH_NODE(node,1,NODE_METADATA(node),0);
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(result==0) {
        if((copy=(HeapNode near *)RH_HEAP_DISPATCH(5,0,node->field8))!=0) {
            if(node->flags&0x1000) RH_CLEAR_TAG_ENTRY(node);
            RH_COPY_DESCRIPTOR(0,5,node,copy);
            if(node->flags&0x400) ACTIVE_HEAP.field52-=node->size;
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[5];
            copy->flags|=0x100;
            copy->field19=ACTIVE_HEAP.field4;
            if(copy->flags&0x400) copy->field8=OVR_IMAGE_SIZE(NODE_METADATA(copy));
            RH_UPDATE_NODE_ADDRESS(copy,2);
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
            if(node->flags&0x60) {
                --ACTIVE_HEAP.tracked_nodes;
                ACTIVE_HEAP.tracked_size-=node->size;
            }
            if(node->key>=ACTIVE_HEAP.head->key && node->key<ACTIVE_HEAP.end->key) {
                ADD_FREE_NODE(node);
                RH_COALESCE_FREE(node);
            } else
                RH_MARK_FREE_AND_MERGE(node);
            return 0;
        }
        return 0x1000;      /* early-return style: these returns leave the
                               original's two dead jumps at 0BD4/0BD6 */
    }
    if(node->flags&0x4000) HEAP_FREE_ITEM((struct HeapItem far *)NODE_METADATA(node));
    else *(unsigned int far *)NODE_METADATA(node)=0;
    RH_RELEASE_DESCRIPTOR(node);
    return 0;
}

/* Take a node out of the handle ring: clear its slot (field13) in
   HANDLE_RING_NODES, take it out of tagged_size when tagged, and clear
   flags 800h and 1000h.  The ring lives in the program's DS, reached
   through ES = ACTIVE_HEAP.program_segment. */
void near pascal RH_CLEAR_TAG_ENTRY(HeapNode near *node)
{
    _ES=ACTIVE_HEAP.program_segment;
    asm mov bx,node;
    asm mov bl,[bx+0Dh];
    asm xor bh,bh;
    asm shl bx,1;
    asm mov word ptr es:[bx+offset DGROUP:HANDLE_RING_NODES],0;
    if(node->flags&0x800) ACTIVE_HEAP.tagged_size-=node->size;
    node->flags&=0xe7ff;
}

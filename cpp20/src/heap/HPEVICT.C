/* target: HPEVICT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE edits (HEAP2 agent): CPP's heap has no tracked or tagged totals,
   no handle ring and no bank copies kept beside bank-0 nodes, so both
   routines lose those steps and RH_CLEAR_TAG_ENTRY is not in CPP.EXE (the
   module ends at image 0xDAF, where RH_RECLAIM_NODE starts).  node and copy
   are register variables (SI, DI), so register variables are on (BCC: -r-). */
/* CPP.EXE module HPEVICT (0054:06B9..0054:086F, image 0xBF9..0xDAF): source taken
   from the BCC.EXE reconstruction (bcc20/src/heap/HPEVICT.C); compiled
   by Turbo C 2.01 (see CPPHEAP.H), with the CPP.EXE edits marked. */
/* Role: far-memory heap: moves a node's contents out to another bank (RH_TRY_FLAG20) or
   discards it to the null bank 4 (RH_TRY_FLAG40) and frees its place. Entry points:
   RH_TRY_FLAG20, RH_TRY_FLAG40. */
/* Overview: eviction, the way the heap frees conventional memory (bank 0)
   when an allocation does not fit (see HEAPMAIN.C's overview for banks,
   nodes, handles and flags).  RH_RECLAIM_NODE (HPRCLNOD.C) picks one of the
   two routines here by the node's flags; RHAPI.C calls them too.  A node
   flagged 20h is moved: its contents are written into another bank
   (extended memory, bank 3, or EMS, bank 2; CPP.EXE has no swap file) and
   its descriptor goes with it, flagged 80h.  A node flagged 40h is
   discarded: only its descriptor is kept, in the null bank 4 (BCC.EXE's
   bank 5), flagged 100h, and its callback (field18, through
   RH_DISPATCH_NODE) is told so it can rebuild the contents later.  Either
   way the bank-0 space becomes free and the owner's handle is switched to
   the descriptor-index form; a later CHANGE_HEAP_NODE_MODE on the block
   brings it back into bank 0.
   BCC.EXE's versions also keep tracked and tagged totals and the handle
   ring in step; CPP.EXE's do not (see the edits above).  NODE_METADATA reads
   a node's output pointer from its two words at +0Eh. */
#include <dos.h>
#include "CPPHEAP.H"
struct HeapItem;
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near cdecl RH_HEAP_DISPATCH(unsigned int bank,unsigned int operation,...);
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
extern HeapNode near * near pascal RH_COPY_DESCRIPTOR(unsigned int source_bank,
    unsigned int target_bank,HeapNode near *source,HeapNode near *target);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);
extern unsigned int near pascal RH_RELEASE_DESCRIPTOR(HeapNode near *node);
/* CPP.EXE edit: the two words at +0Eh are read as one far pointer (push
   [si+10h]; push [si+0Eh], and les bx,[si+0Eh]), BCC builds it with MK_FP. */
#define NODE_METADATA(n) (((struct HeapOutputNodeView near *)(n))->output)

/* Move a bank-0 node out to another bank: banks 3 down to (flags & 3) + 1
   are tried: allocate a copy of field8 bytes there (operation 0), tell the
   callback, write the contents in (operation 2).  Then the bank-0 node is
   freed and the copy takes over the descriptor data and the handle (index
   form).  Returns 0, or 1000h when no bank had room.  DS is bank 0 on
   return.
   CPP.EXE edit (image 0xBF9, 0054:06B9): the walk starts at bank 3, not 4; there is no
   reuse of a kept copy (flag 2000h), no tracked/tagged bookkeeping, no
   ring-entry clear, no field52 update and the copy's flag 2000h is not
   cleared, and the callback is told without RH_UPDATE_NODE_ADDRESS(node,4)
   first. */
unsigned int near pascal RH_TRY_FLAG20(register HeapNode near *node)
{
    int bank;
    int low;
    register HeapNode near *copy;
    low=(node->flags&3)+1;
    for(bank=3;bank>=low;bank--) {
        if((copy=(HeapNode near *)RH_HEAP_DISPATCH(bank,0,node->field8))!=0) {
            if(node->field18) {
                RH_DISPATCH_NODE(node,4,NODE_METADATA(node),node->flags&0x400);
                asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
                _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
            }
            RH_HEAP_DISPATCH(bank,2,copy,node->key);
            break;
        }
    }
    if(bank<low) goto fail;
    RH_COPY_DESCRIPTOR(0,bank,node,copy);
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
    copy->flags|=0x80;
    RH_UPDATE_NODE_ADDRESS(copy,2);
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    return 0;
fail:
    return 0x1000;
}

/* Discard a bank-0 node.  The callback is asked first (operation 1).  If it
   returns 0, the descriptor is moved to a new bank-4 node (flag 100h) and
   the bank-0 space freed; 1000h is returned when bank 4 has no descriptor.
   If the callback returns nonzero, the block is dropped for good: its
   handle is freed or cleared and the node released.  Returns 0 on success.
   CPP.EXE edit (image 0xCDA, 0054:079A): the descriptor goes to bank 4, not 5
   (RH_HEAP_DISPATCH(4,0,..), HEAP_DESCRIPTOR_SEGMENTS[4] at DS:0380h); no
   RH_UPDATE_NODE_ADDRESS(node,4) first, no bank-copy release, no ring or
   tracked bookkeeping, no field52 update and no overlay image size. */
unsigned int near pascal RH_TRY_FLAG40(register HeapNode near *node)
{
    register HeapNode near *copy;
    unsigned int result;
    result=0;
    if(node->field18) result=RH_DISPATCH_NODE(node,1,NODE_METADATA(node),0);
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(result==0) {
        if((copy=(HeapNode near *)RH_HEAP_DISPATCH(4,0,node->field8))!=0) {
            RH_COPY_DESCRIPTOR(0,4,node,copy);
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[4];
            copy->flags|=0x100;
            copy->field19=ACTIVE_HEAP.field4;
            RH_UPDATE_NODE_ADDRESS(copy,2);
            asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
            _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
            if(node->key>=ACTIVE_HEAP.head->key && node->key<ACTIVE_HEAP.end->key) {
                ADD_FREE_NODE(node);
                RH_COALESCE_FREE(node);
            } else
                RH_MARK_FREE_AND_MERGE(node);
            return 0;
        }
        return 0x1000;
    }
    if(node->flags&0x4000) HEAP_FREE_ITEM((struct HeapItem far *)NODE_METADATA(node));
    else *(unsigned int far *)NODE_METADATA(node)=0;
    RH_RELEASE_DESCRIPTOR(node);
    return 0;
}

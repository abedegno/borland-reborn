/* target: HPALLOCH */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* Matched (HEAP2 agent): BCC's file used -r-; CPP's build keeps register
   variables on for this file (node is in SI), so -r- is dropped. */
/* CPP.EXE module HPALLOCH (0054:12A9, image 0x17E9): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPALLOCH.C); compiled by Turbo C 2.01
   (see CPPHEAP.H), with the CPP.EXE edits marked. */
/* Role: far-memory heap: the far allocation entry: allocates a node and a handle item
   pointing at it. */
/* Overview: HEAP_ALLOC_HANDLE, the far allocation entry for blocks that get
   a heap-owned handle (see HPGETITM.C for handle items).  It makes sure
   there are spare descriptors, takes a handle item, allocates a bank-0 node
   of request bytes (HEAP_ALLOC_NODE), points the node's output at the item,
   writes the block's segment into it and flags the node 4000h.  It returns
   the item's far address, which the caller keeps.  When there is no room
   the item is given back, HEAP_STATUS is set to 1000h, the status hook is
   called and 0 is returned (CPP.EXE edit: no retry, see below).  It is
   static and nothing in CPP.EXE calls it; BCC.EXE's callers (for example
   its object segment buffers) are not in CPP.EXE.  The CS-relative loads of
   the program's DS are inline asm.  The hook is called through
   HEAP_HOOK_CALLSITE, whose declaration describes the caller's side only. */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int far HEAP_PROGRAM_DS;
struct HeapItem;
extern struct HeapItem far * near pascal HEAP_ALLOC_ITEM(void);
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);
extern unsigned int near pascal RH_PREPARE_DESCRIPTORS(void);
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);

/* CPP.EXE edit: Turbo C 2.01 has no _loadds; the DGROUP load after the SI
   save and the DS restore before the shared epilogue are inline asm, and the
   result is left in DX:AX for it (the function falls off its end there, as
   the original returns the registers).  There is no retry: a failed
   allocation frees the item and reports 1000h at once, calling the hook
   with no arguments (BCC calls HEAP_HOOK_CALLSITE(1,100h) and retries while
   it clears HEAP_STATUS). */
static unsigned int far * far pascal HEAP_ALLOC_HANDLE(unsigned int request)
{
    register HeapNode near *node;
    struct HeapItem far *item;
    asm push ds;
    asm mov ax,DGROUP;
    asm mov ds,ax;
    if(RH_PREPARE_DESCRIPTORS())
        goto failed;
    HEAP_STATUS=0;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    item=HEAP_ALLOC_ITEM();
    if(!item)
        goto failed;
    if((node=HEAP_ALLOC_NODE(request))) {
        ((struct HeapOutputNodeView near *)node)->output=(unsigned int far *)item;
        RH_UPDATE_NODE_ADDRESS(node,1);
        node->flags|=0x4000;
        _DX=FP_SEG(item);
        _AX=FP_OFF(item);
        goto done;
    }
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    HEAP_FREE_ITEM(item);
failed:
    asm mov ax,DGROUP;
    asm mov ds,ax;
    HEAP_STATUS=0x1000;
    ((void (far *)(void))HEAP_HOOK_CALLSITE)();
    _DX=0;
    _AX=_DX;
done:
    asm pop ds;
}

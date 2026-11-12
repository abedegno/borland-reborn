/* target: HPFREETG */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPFREETG (image 0x18D5, 0054:1395, 0x9F bytes): from the BCC.EXE
   reconstruction (bcc20/src/heap/HPFREETG.C); compiled by Turbo C 2.01
   (see CPPHEAP.H).
   CPP.EXE edits (each marked below): five banks instead of six (cmp [bp-2],5);
   node is a register variable (SI), so the file is built with register
   variables on (BCC's -r- dropped from the opts: with -r- TC 2.01 ignores the
   `register`); with the shorter body the jcxz reaches the loop step
   directly, so BCC's jcxz-over-jmp detour is gone. */
/* Role: far-memory heap: FREE_TAG_NODES releases every heap node owned by a given tag.
   Entry points: FREE_TAG_NODES. */
/* Overview: frees, in one call, every heap block that belongs to an owner
   tag (see HPTAGS.C for tags); FREE_OWNER_TAG (HPHSIZE.C) calls it before it clears
   the tag.  It walks the node chain of each bank that is set up and releases
   each used node whose field12 is the tag through the bank's release hook
   (hook_24), after freeing its handle item (flag 4000h) or clearing its
   handle word, so the owner sees a zero handle.  A release returns the
   node's descriptor (UNLINK_HEAP_NODE clears its previous link but keeps next), so
   the walk then steps along next to a live node and continues from there. */
/* FREE_TAG_NODES: release every heap node owned by tag (owner, or
   HEAP_DEFAULT_OWNER_TAG when owner is 0) in all five descriptor banks.
   Each released node's metadata is dropped (HEAP_FREE_ITEM for item-backed nodes,
   else its word is cleared) and it is handed to ACTIVE_HEAP.hook_24.

   Compiled through TASM (-B).  The bank switch is inline asm.  BCC.EXE's
   version steps around its jcxz (jcxz over a jmp short) although a direct
   jcxz would have reached; CPP.EXE's jcxz goes straight to the loop step
   (see the edits above).  huge gives the push ds / DGROUP load / pop ds
   frame (BCC's _loadds). */
#include <dos.h>
#include "CPPHEAP.H"
struct HeapItem;
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);

void huge pascal FREE_TAG_NODES(unsigned char owner)
{
    unsigned char tag;
    int bank;
    register HeapNode near *node;   /* CPP.EXE edit: node lives in SI (BCC: a stack local) */
    tag=owner==0?HEAP_DEFAULT_OWNER_TAG:owner;
    for(bank=0;bank<5;bank++) {     /* CPP.EXE edit: five banks (cmp [bp-2],5 at 0054:1424) */
        asm mov bx,bank;
        asm shl bx,1;
        asm mov cx,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS[bx];
        asm jcxz next;      /* CPP.EXE edit: a direct jcxz to the loop step (0054:13C4) */
        asm mov ds,cx;
        for(node=ACTIVE_HEAP.chain_head->next;node!=ACTIVE_HEAP.chain_tail;
                node=node->next) {
            if(!(node->flags&4) && node->field12==tag) {
                if(node->flags&0x4000)
                    HEAP_FREE_ITEM((struct HeapItem far *)((struct HeapOutputNodeView near *)node)->output);
                else *((struct HeapOutputNodeView near *)node)->output=0;
                ACTIVE_HEAP.hook_24(node);
                if(!node->previous) {
                    while(!node->previous) node=node->next;
                    node=node->previous;
                }
            }
        }
        asm mov ax,DGROUP;      /* back to the program's DS */
        asm mov ds,ax;
    next: ;
    }
}

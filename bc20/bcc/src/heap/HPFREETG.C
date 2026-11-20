/* target: CODE_2_R25FF */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: FREE_TAG_NODES releases every heap node owned by a given tag.
   Entry points: FREE_TAG_NODES. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: frees, in one call, every heap block that belongs to an owner
   tag (see HPOWNTAG.C for tags); FREE_OWNER_TAG calls it before it clears
   the tag.  It walks the node chain of each bank that is set up and releases
   each used node whose field12 is the tag through the bank's release hook
   (hook_24), after freeing its handle item (flag 4000h) or clearing its
   handle word, so the owner sees a zero handle.  A release returns the
   node's descriptor (RRETNDES clears its previous link but keeps next), so
   the walk then steps along next to a live node and continues from there. */
/* CODE_2:1CBF..1D7F, FREE_TAG_NODES: release every heap node owned by tag
   (owner, or HEAP_DEFAULT_OWNER_TAG when owner is 0) in all six descriptor banks.
   Each released node's metadata is dropped (HEAP_FREE_ITEM for item-backed nodes,
   else its word is cleared) and it is handed to ACTIVE_HEAP.hook_24.

   Compiled through TASM (-B).  The bank switch is inline asm.  The original
   steps around its jcxz (jcxz over a jmp short, 1CED) although a direct
   jcxz would have reached; its continue is a forward jmp TASM shortened ("jmp short; nop" at 1CF1),
   which BCC writes only when asm lies between the jump and its target, here
   the asm DS restore to DGROUP at 1D67.  _loadds gives the push ds / DGROUP
   load / pop ds frame. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHOUT.H"
#include "DATA.H"
struct HeapItem;
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);

void far pascal _loadds FREE_TAG_NODES(unsigned char owner)
{
    unsigned char tag;
    int bank;
    HeapNode near *node;
    tag=owner==0?HEAP_DEFAULT_OWNER_TAG:owner;
    for(bank=0;bank<6;bank++) {
        asm mov bx,bank;
        asm shl bx,1;
        asm mov cx,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS[bx];
        asm jcxz empty;     /* stepped around, as the original does */
        asm jmp short load;
    empty:
        continue;
    load:
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
    }
}

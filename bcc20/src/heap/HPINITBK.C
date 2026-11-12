/* target: CODE_2_RH1893 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: INIT_BANK builds the descriptor table and free list of a newly
   set-up bank. Entry points: INIT_BANK. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: INIT_BANK sets up a bank's control record (see HEAPMAIN.C's
   overview): its range (leading_fields[0] first key, [1] size in units),
   its number (field4), unit (field8) and rounding (field6), where the shared
   descriptor table appears in its DS (field30 = (6 - bank) * 50h, and
   bank_adjustment), the default allocate and release hooks, and its first
   nodes: the free-list sentinel, the chain_head sentinel, one free node
   covering the whole range (head, current and free_cursor) and the
   chain_tail sentinel at the top (end = chain_tail: nothing fixed high).
   For a bank other than 0 it also sets HEAP_DESCRIPTOR_SEGMENTS[bank] and
   leaves DS at the new bank; callers rely on that to fill in the rest of
   the record.  Called by INIT_MAIN_HEAP, INIT_SWAP_BANK, INIT_EMS_BANK,
   INIT_EXT_BANK and INIT_NULL_BANK. */
/* Unbuilt complete proposal for original resident0094:1893..19BD.
   One genuine DS-domain selection; all initialization remains typed C. */
#include <dos.h>
#include "RHENTRY.H"
#include "DATA.H"
/* Existing real far program byte supplies only its fixed DGROUP segment.
   Its value/offset play no algorithmic role in this initializer. */
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_RELEASE_DESCRIPTOR(HeapNode near *node);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);

void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8)
{
    HeapNode near *node;
    if(bank) {
        HEAP_DESCRIPTOR_SEGMENTS[bank]=HEAP_DESCRIPTOR_SEGMENTS[0]+bank*5;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    }
    ACTIVE_HEAP.field30=(6-bank)*0x50;
    ACTIVE_HEAP.bank_adjustment=bank*0x50;
    ACTIVE_HEAP.leading_fields[0]=first_key;
    ACTIVE_HEAP.leading_fields[1]=size;
    ACTIVE_HEAP.field4=(unsigned char)bank;
    ACTIVE_HEAP.field6=field6;
    ACTIVE_HEAP.field8=field8;
    HEAP_ENTRY_BANK->allocate22=HEAP_ALLOC_NODE;
    HEAP_ENTRY_BANK->release24=RH_RELEASE_DESCRIPTOR;
    ACTIVE_HEAP.program_segment=FP_SEG(&SWAP_GROW_FILE_ALLOWED);

    node=RNEWNODE();
    ACTIVE_HEAP.free_head=node;
    node->key=ACTIVE_HEAP.leading_fields[0];
    node->flags=0x8004;
    node->next=node->previous=node;
    node->next_free=node->previous_free=node;
    node->size=0;

    node=RNEWNODE();
    ACTIVE_HEAP.chain_head=node;
    node->key=ACTIVE_HEAP.leading_fields[0];
    node->flags=0x8000;
    node->next=node->previous=node;
    node->size=0;

    node=RNEWNODE();
    ACTIVE_HEAP.head=ACTIVE_HEAP.current=node;
    node->key=ACTIVE_HEAP.leading_fields[0];
    node->size=ACTIVE_HEAP.leading_fields[1];
    RHLINK(ACTIVE_HEAP.chain_head,node);
    ADD_FREE_NODE(node);
    ACTIVE_HEAP.free_cursor=node;
    RHLINK(node,RNEWNODE());
    node=node->next;
    ACTIVE_HEAP.end=ACTIVE_HEAP.chain_tail=node;
    node->key=ACTIVE_HEAP.leading_fields[0]+ACTIVE_HEAP.leading_fields[1];
    node->size=0;
    node->flags=0x8000;
}

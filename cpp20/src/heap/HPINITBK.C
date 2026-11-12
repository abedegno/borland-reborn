/* target: HPINITBK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPINITBK (0054:0FF6, image 0x1536): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPINITBK.C), with the CPP.EXE edits
   marked; compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: INIT_BANK builds the descriptor table and free list of a newly
   set-up bank. Entry points: INIT_BANK. */
/* Overview: INIT_BANK sets up a bank's control record (see HEAPMAIN.C's
   overview): its range (leading_fields[0] first key, [1] size in units),
   its number (field4), unit (field8) and rounding (field6), where the shared
   descriptor table appears in its DS (field30 = (5 - bank) * 40h, and
   bank_adjustment; BCC.EXE: (6 - bank) * 50h), the default allocate and
   release hooks, and its first
   nodes: the free-list sentinel, the chain_head sentinel, one free node
   covering the whole range (head, current and free_cursor) and the
   chain_tail sentinel at the top (end = chain_tail: nothing fixed high).
   For a bank other than 0 it also sets HEAP_DESCRIPTOR_SEGMENTS[bank] and
   leaves DS at the new bank; callers rely on that to fill in the rest of
   the record.  Called by INIT_MAIN_HEAP, INIT_EMS_BANK, INIT_EXT_BANK and
   INIT_NULL_BANK (BCC.EXE also by INIT_SWAP_BANK). */
#include <dos.h>
#include "CPPHEAP.H"
/* BCC's source takes DGROUP from this far program byte's segment; CPP.EXE
   stores DGROUP directly (see the edit below), so it is not used here. */
extern unsigned char far SWAP_GROW_FILE_ALLOWED;
extern HeapNode near * near pascal HEAP_ALLOC_NODE(unsigned int request);
extern unsigned int near pascal RH_RELEASE_DESCRIPTOR(HeapNode near *node);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);

void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8)
{
    /* CPP.EXE edit: node is a register variable (SI). */
    register HeapNode near *node;
    /* CPP.EXE edit: CPP's banks are 4 paragraphs (40h bytes) of descriptor
       segment each, and there are 5 of them; BCC's are 5 paragraphs, 6 banks. */
    if(bank) {
        HEAP_DESCRIPTOR_SEGMENTS[bank]=HEAP_DESCRIPTOR_SEGMENTS[0]+bank*4;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    }
    ACTIVE_HEAP.field30=(5-bank)*0x40;
    ACTIVE_HEAP.bank_adjustment=bank*0x40;
    ACTIVE_HEAP.leading_fields[0]=first_key;
    ACTIVE_HEAP.leading_fields[1]=size;
    ACTIVE_HEAP.field4=(unsigned char)bank;
    ACTIVE_HEAP.field6=field6;
    ACTIVE_HEAP.field8=field8;
    HEAP_ENTRY_BANK->allocate22=HEAP_ALLOC_NODE;
    HEAP_ENTRY_BANK->release24=RH_RELEASE_DESCRIPTOR;
    /* CPP.EXE edit: the program's DGROUP stored as an immediate with a
       segment fixup (C7 06 0A00 2A12 R), where BCC's C loads FP_SEG of a
       far program byte through AX/DX. */
    asm mov word ptr DGROUP:ACTIVE_HEAP.program_segment,DGROUP;

    ACTIVE_HEAP.free_head=node=RNEWNODE();  /* CPP.EXE edit: one statement */
    node->key=ACTIVE_HEAP.leading_fields[0];
    node->flags=0x8004;
    node->next=node->previous=node;
    node->next_free=node->previous_free=node;
    node->size=0;

    ACTIVE_HEAP.chain_head=node=RNEWNODE(); /* CPP.EXE edit: one statement */
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

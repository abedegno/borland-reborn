/* target: H_HPDESC */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* Role: far-memory heap: the descriptor table: grow it, release flagged entries, prepare it
   for a request. Entry points: RH_GROW_DESCRIPTORS, RH_PREPARE_DESCRIPTORS. */
/* Overview: management of the heap's descriptor table, the array of 20-byte
   node descriptors (HeapNode) that every bank shares; HEAPMAIN.C's overview
   explains banks, nodes and handles.  The table is itself a block in bank 0
   (ACTIVE_HEAP.descriptor_block, entries from offset 140h); unused entries
   form a list from ACTIVE_HEAP.descriptor_head through next_free, and
   ACTIVE_HEAP.descriptor_count counts them (despite its name, it is the
   number of free entries: RNEWNODE decrements it, RRETNDES increments it).
   All bookkeeping is in bank 0's record, so these functions run with DS =
   HEAP_DESCRIPTOR_SEGMENTS[0].
   Before any operation that may need new descriptors (an allocation, a mode
   change, a new bank), callers run RH_PREPARE_DESCRIPTORS.  It wants 8 more
   free entries than there are reclaimable (tracked) nodes, probably so that
   every node that may be moved out to another bank can get a descriptor
   there.  It first grows the table, then compacts every bank (merging free
   nodes gives descriptors back), then discards overlay-code nodes. */
/* CODE_2:0017..0233, the heap's descriptor-bank management: growing the
   bank, freeing flagged handles, and RH_PREPARE_DESCRIPTORS, which makes room
   for eight more descriptors before an allocation (called by POOL_INIT in
   POOLINIT and by HPALLOCH).  Returns 0, or 1001h when no room could be made.

   Compiled C with inline asm, through TASM (-B): the original has TASM's
   "jmp short; nop" for a forward jump at 0051, which BCC's own code
   generator never emits.  The asm here is where the original's code is not
   BCC output: the CS-relative DS loads, the indexed bank load into DS, the
   mul/add size computation, the bl handle loop and rep stosb.  Plain segment
   loads are C assignments to _DS/_ES, as in HPALLOCH.

   Documented exceptions (pseudo-register reads):
   - _FLAGS&1 at 0038: the carry test (jae over a near jmp) on the size
     computation, which is asm (mul and add) so that end is stored only
     after the test;
   - _AX at 003D: the end offset that computation leaves in AX;
   - _CX at 00FE: the handle's node offset loaded by the asm loop. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
/* Descriptor-bank entry view: 22 bytes (the grow loop's stride); only the
   free-chain link at +10h, the same place as HeapNode.next_free, is used. */
typedef struct HeapDescriptor HeapDescriptor;
struct HeapDescriptor {
    unsigned char leading_fields[0x10];
    HeapDescriptor near *next_free;
    unsigned char trailing_fields[2];
};
extern unsigned int far HEAP_PROGRAM_DS;
/* Program-DS handle table, read through ES = ACTIVE_HEAP.program_segment. */
extern HeapNode near * near pascal RESIZE_NODE(HeapNode near *block,
    unsigned int end);

/* Grow the descriptor bank by count entries: resize its block, add the new
   entries to the end of the free chain, zero them and link them in order. */
unsigned int near pascal RH_GROW_DESCRIPTORS(unsigned int count)
{
    HeapDescriptor near *old_end;
    HeapDescriptor near *end;
    HeapDescriptor near *entry;
    unsigned int result;
    result=0;
    old_end=(HeapDescriptor near *)ACTIVE_HEAP.descriptor_block->field8;
    asm mov ax,count;
    asm mov dx,20;  /* sizeof(HeapDescriptor) */
    asm mul dx;
    asm add ax,old_end;
    if(_FLAGS&1) goto fail;
    end=(HeapDescriptor near *)_AX;
    if((entry=(HeapDescriptor near *)RESIZE_NODE(ACTIVE_HEAP.descriptor_block,
            (unsigned int)end))!=0) {
        ACTIVE_HEAP.descriptor_block=(HeapNode near *)entry;
        entry=(HeapDescriptor near *)ACTIVE_HEAP.descriptor_head;
        if(entry) {
            while(entry->next_free) entry=entry->next_free;
            entry->next_free=old_end;
        } else ACTIVE_HEAP.descriptor_head=(HeapNode near *)old_end;
        /* Clear the new entries, then chain them into the free list. */
        entry=old_end;
        asm push ds;
        asm pop es;
        asm push di;
        asm mov cx,end;
        asm sub cx,entry;
        asm mov di,old_end;
        asm xor ax,ax;
        asm cld;
        asm rep stosb;
        asm pop di;
        for(;entry<end;entry++) entry->next_free=entry+1;
        entry--;
        entry->next_free=0;
        ACTIVE_HEAP.descriptor_count+=count;
    } else {
fail:
        result=0x1001;
    }
    return result;
}

/* Make room for 8 more descriptors than are tracked: pass 0 grows the table by 20,
   pass 1 calls hook_26(-1) in banks 0-3 whose segment is nonzero (bank 4, the
   discard bank, is skipped).  Five passes; passes 2 to 4 only recheck.  TLINK's
   version of the heap has no swap file and no flagged-handle pass. */
unsigned int near pascal RH_PREPARE_DESCRIPTORS(void)
{
    unsigned char pass;
    int bank;
    pass=0;
    asm push ds;
    while(pass<5) {
        asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
        _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
        if(ACTIVE_HEAP.tracked_nodes+8>ACTIVE_HEAP.descriptor_count) {
            if(pass==0) RH_GROW_DESCRIPTORS(20);
            else if(pass==1) {
                for(bank=0;bank<5;bank++) {
                    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
                    _CX=HEAP_DESCRIPTOR_SEGMENTS[bank];
                    asm jcxz next;
                    _DS=_CX;
                    if(bank==4) continue;
                    ACTIVE_HEAP.hook_26(-1);
                next: ;
                }
            }
            pass++;
        } else {
            asm pop ds;
            return 0;
        }
    }
    asm pop ds;
    return 0x1001;
}

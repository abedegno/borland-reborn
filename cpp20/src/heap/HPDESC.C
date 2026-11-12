/* target: HPDESC */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPDESC (0054:0011..0054:0158, image 0x551..0x698): source taken from
   the BCC.EXE reconstruction (bcc20/src/heap/HPDESC.C), edited for
   CPP.EXE (marked "CPP.EXE edit"): RH_RELEASE_FLAGGED is not in CPP.EXE (left out
   here), and CPP's heap has 20-byte descriptors and 5 banks.  Compiled by Turbo C 2.01
   (see CPPHEAP.H). */
/* Role: far-memory heap: the descriptor table: grow it and prepare it for a request.
   Entry points: RH_GROW_DESCRIPTORS, RH_PREPARE_DESCRIPTORS. */
/* Overview: management of the heap's descriptor table, the array of 20-byte
   node descriptors (HeapNode; BCC.EXE's are 22 bytes) that every bank shares;
   HEAPMAIN.C's overview explains banks, nodes and handles.  The table is
   itself a block in bank 0 (ACTIVE_HEAP.descriptor_block, entries from
   offset 140h); unused entries
   form a list from ACTIVE_HEAP.descriptor_head through next_free, and
   ACTIVE_HEAP.descriptor_count counts them (despite its name, it is the
   number of free entries: RNEWNODE decrements it, UNLINK_HEAP_NODE increments it).
   All bookkeeping is in bank 0's record, so these functions run with DS =
   HEAP_DESCRIPTOR_SEGMENTS[0].
   Before any operation that may need new descriptors (an allocation, a mode
   change, a new bank), callers run RH_PREPARE_DESCRIPTORS.  It wants 8 more
   free entries than there are reclaimable (tracked) nodes, probably so that
   every node that may be moved out to another bank can get a descriptor
   there.  (No CPP.EXE code writes tracked_nodes, which INIT_MAIN_HEAP
   clears, so in CPP.EXE it is probably always 0.)  It first grows the
   table, then compacts every bank (merging free
   nodes gives descriptors back).  BCC.EXE then also discards overlay-code
   nodes (RH_RELEASE_FLAGGED); CPP.EXE does not. */
/* RH_PREPARE_DESCRIPTORS makes room for eight more descriptors before an
   allocation (called by POOL_INIT in POOLINIT.C, HEAP_ALLOC_HANDLE in
   HPALLOCH.C, and RHAPI.C).  Both functions return 0, or 1001h
   when no room could be made.

   Compiled C with inline asm, through TASM (-B).  The asm here is where the
   original's code is not compiler output: the CS-relative DS loads, the
   indexed bank load into DS, the mul/add size computation and rep stosb.
   Plain segment loads are C assignments to _DS/_ES, as in HPALLOCH.

   Documented exceptions (pseudo-register reads):
   - _FLAGS&1 in RH_GROW_DESCRIPTORS: the carry test (jae over a near jmp)
     on the size computation, which is asm (mul and add) so that end is
     stored only after the test;
   - _AX just after it: the end offset that computation leaves in AX.
   (BCC's file also reads _CX in RH_RELEASE_FLAGGED, not in CPP.EXE.) */
#include <dos.h>
#include "CPPHEAP.H"
/* CPP.EXE edit: 20 bytes (the grow loop steps by 14h), BCC's are 22.
   Descriptor-bank entry view; only the
   free-chain link at +10h, the same place as HeapNode.next_free, is used. */
typedef struct HeapDescriptor HeapDescriptor;
struct HeapDescriptor {
    unsigned char leading_fields[0x10];
    HeapDescriptor near *next_free;
    unsigned char trailing_fields[2];
};
extern unsigned int far HEAP_PROGRAM_DS;
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
    asm mov dx,20;  /* sizeof(HeapDescriptor); CPP.EXE edit: 20, BCC 22 */
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

/* Make room for 8 more descriptors than are tracked: pass 0 grows the bank,
   pass 1 calls hook_26(-1) in banks 0-3 whose segment is nonzero (bank 4 is
   skipped).  Five passes; passes 2 to 4 only recheck.
   CPP.EXE edit: CPP's heap has 5 banks (HEAP_DESCRIPTOR_SEGMENTS[0..4]), the
   last one skipped as BCC skips its bank 5; there is no swap-file bank, so
   no SWAP_GROW_FILE_ALLOWED/SWAP_EXCHANGE_ALLOWED juggling for banks 1 and 2,
   and no pass 2 (RH_RELEASE_FLAGGED is not in CPP.EXE). */
unsigned int near pascal RH_PREPARE_DESCRIPTORS(void)
{
    int bank;
    unsigned char pass;
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
                    asm mov bx,bank;
                    asm shl bx,1;
                    asm mov cx,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS[bx];
                    asm jcxz next;
                    asm mov ds,cx;
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

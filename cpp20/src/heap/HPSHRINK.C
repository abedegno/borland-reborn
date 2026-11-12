/* target: HPSHRINK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -k -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* link: tools/fixorder.py reorders this object's fixups at link time (tools/fixorder.tsv
   gives the order and the evidence); see docs/FINDINGS.md, "The 2 bytes". */
/* CPP.EXE module HPSHRINK (0054:1136..120F, image 0x1676..0x1754): three functions of
   the BCC.EXE heap (bcc20/src/heap/HPGATHER.C, HPSHRNKH.C and
   HPSHRINK.C there), with the CPP.EXE edits marked; compiled by Turbo C 2.01 (see
   CPPHEAP.H), going through TASM (-B).
   Why one file: CPP.EXE's relocation table lists SHRINK_HEAP_FULLY's far call (16A5h)
   before GATHER_ALL_FREE_SPACE's DGROUP load (167Bh). TLINK writes relocations in object
   order, so separate objects for the first two functions cannot give that order: they
   were one object. SHRINK_HEAP_TO's first relocation (16B3h) follows straight after, and
   this file gives every byte of the three functions as one Turbo C 2.01 compile (BCC.EXE
   built the first two with Borland C++ 2.0 and _loadds, which Turbo C 2.01 lacks). The
   same three functions sit together, in this order, in BCC.EXE. */
/* Role: far-memory heap: GATHER_ALL_FREE_SPACE gathers all free space at the high end,
   SHRINK_HEAP_FULLY and SHRINK_HEAP_TO shrink the heap. */
/* Overview of SHRINK_HEAP_TO: far entry that lowers the top of bank 0 by up to limit
   paragraphs, so that DOS memory can be given back (in BCC.EXE probably
   before TASM or TLINK is run); GROW_HEAP_TO undoes it.  In CPP.EXE its
   only caller is SHRINK_HEAP_FULLY (below), which nothing calls.  The
   current top is saved in HEAP_SAVED_TOP_KEY (a program-DS word, written
   through ES).  Only when no block is fixed at the high end: blocks are
   reclaimed if needed, free space
   is gathered at the top, and the top free node is cut down (at least one
   paragraph is kept).  Returns the new top paragraph. */
#include <dos.h>
#include "CPPHEAP.H"
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);
unsigned int far pascal SHRINK_HEAP_TO(unsigned int);

/* CPP.EXE edit (both static entries below): BCC's source is `_loadds`, which Turbo C
   2.01 does not have, so the DS save and DGROUP load are inline asm, and the result is
   left in AX and returned as _AX. */

/* Far entry that compacts the movable area of bank 0 so that all its free space forms
   one node at the high end; returns that node's offset (valid in bank 0's DS) or 0, as
   a plain word.  It is static and nothing in CPP.EXE calls it. */
static unsigned int far pascal GATHER_ALL_FREE_SPACE(void)
{
    asm push ds;
    asm mov ax,DGROUP;
    asm mov ds,ax;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    _AX=(unsigned int)GATHER_FREE_AT_HIGH_END(0xffffU,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
    asm pop ds;
    return _AX;
}

/* Far entry: SHRINK_HEAP_TO(FFFFh), shrink bank 0 as far as it goes; returns the new
   top paragraph.  It is static and nothing in CPP.EXE calls it. */
static unsigned int far pascal SHRINK_HEAP_FULLY(void)
{
    asm push ds;
    asm mov ax,DGROUP;
    asm mov ds,ax;
    /* NOSMART: SHRINK_HEAP_TO is later in this segment, and TASM's SMART mode would turn
       the far call into push cs + call near; CPP.EXE has the far call (9Ah). */
    asm NOSMART;
    _AX=SHRINK_HEAP_TO(0xffffU);
    asm SMART;
    asm pop ds;
    return _AX;
}

/* HEAP_SAVED_TOP_KEY (CPPHEAP.H) is a program-DGROUP word (DS:0376 in CPP.EXE).
   Only its offset is used while the bank's DS is active; the store goes
   through ES = the program's DS. */
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);

/* CPP.EXE edit: Turbo C 2.01 has no _loadds.  The DGROUP load comes after the
   SI save (push si; push ds; mov ax,DGROUP; mov ds,ax), which a huge function
   (no register variables there) does not give, so it is inline asm here. */
/* link: SHRINK_HEAP_TO is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int far pascal SHRINK_HEAP_TO(unsigned int limit)
{
    /* CPP.EXE edit: node is a register variable (SI), and the free space is
       read from ACTIVE_HEAP.free_size where BCC calls RH_AVAILABLE_SPACE. */
    register HeapNode near *node;
    volatile unsigned int amount;   /* on the stack: see HPFIXLO.C */
    asm push ds;
    asm mov ax,DGROUP;
    asm mov ds,ax;
    amount=limit;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    _ES=ACTIVE_HEAP.program_segment;
    /* CPP.EXE edit: the ES store is asm (mov es:[376h],ax); Turbo C 2.01
       goes through BX for the _es pointer of BCC's C. */
    _AX=ACTIVE_HEAP.chain_tail->key;
    asm mov word ptr es:[offset DGROUP:HEAP_SAVED_TOP_KEY],ax;
    if(ACTIVE_HEAP.end==ACTIVE_HEAP.chain_tail) {
        if(ACTIVE_HEAP.free_size<amount &&
           RECLAIM_FOR_SPACE(amount,ACTIVE_HEAP.current,ACTIVE_HEAP.head,ACTIVE_HEAP.end))
            amount=ACTIVE_HEAP.free_size;
        GATHER_FREE_AT_HIGH_END(amount,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
        node=ACTIVE_HEAP.chain_tail->previous;
        if(node->flags&4) {
            if(node->size<=amount)
                amount=node->size-1;
            ACTIVE_HEAP.free_size-=amount;
            node->size-=amount;
            ACTIVE_HEAP.chain_tail->key=
                node->key+node->size;
            ACTIVE_HEAP.leading_fields[1]=
                ACTIVE_HEAP.chain_tail->key-
                ACTIVE_HEAP.leading_fields[0];
        }
    }
    _AX=ACTIVE_HEAP.leading_fields[0]+ACTIVE_HEAP.leading_fields[1];
    asm pop ds;
    return _AX;
}

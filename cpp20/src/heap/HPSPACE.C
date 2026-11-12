/* target: HPSPACE */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPSPACE (0054:1B90, image 0x20D0): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPSPACE.C); with the CPP.EXE edits
   marked "CPP.EXE edit".  Compiled by Borland C++ 2.0 (it is _loadds). */
/* Role: far-memory heap: HEAP_SPACE_BELOW_LIMIT returns the heap space still available
   below the limit. Entry points: HEAP_SPACE_BELOW_LIMIT. */
/* Overview: far entry: how many bytes of bank 0 are free, as a long:
   free_size * 16.  (BCC.EXE also adds the reclaimable, tracked, blocks and
   takes off the 400h reserve field54; CPP.EXE's heap has neither.)  Called
   by CPPMAIN.C and INITPOOL.C.
   The paragraphs-to-bytes conversion is inline asm (rol by 4, then split
   into DX:AX), not the long-shift helper, so the value is left in DX:AX by
   asm: a documented exception (fall-off-end).  DS is bank 0
   (HEAP_DESCRIPTOR_SEGMENTS[0]) there, so the DGROUP: overrides only give
   the field offsets. */
#include "CPPHEAP.H"

/* CPP.EXE edit (image 0x20D0): only free_size is counted (mov ax,ds:[1Ah]);
   CPP's ACTIVE_HEAP has no tracked_size/field54 to add and take off. */
long far pascal _loadds HEAP_SPACE_BELOW_LIMIT(void)
{
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    asm mov ax,word ptr DGROUP:ACTIVE_HEAP.free_size;
    asm mov cl,4;
    asm rol ax,cl;
    asm mov dx,ax;
    asm and ax,0FFF0h;
    asm and dx,0Fh;
}

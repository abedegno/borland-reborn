/* target: HPCOPYD */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPCOPYD (0054:03A5, image 0x8E5): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPCOPYD.C), with one CPP.EXE edit
   (marked: five words copied, for the 20-byte descriptor); compiled by Turbo C 2.01
   (see CPPHEAP.H). */
/* Role: far-memory heap: RH_COPY_DESCRIPTOR copies a node descriptor's data bytes from one
   bank's descriptor table to another's. Entry points: RH_COPY_DESCRIPTOR. */
/* Overview: when a block moves between banks its descriptor moves with it
   (see HEAPMAIN.C's overview for banks and nodes): RH_COPY_DESCRIPTOR copies
   the part of a node that describes the block rather than its place (flags,
   owner tag, field13, output pointer, callback and bank byte) into a node
   of the other bank.  key, size, the chain links and field8 stay with each
   bank's own node.  Used by RH_TRY_FLAG20/40 (HPEVICT.C) and RHAPI.C.
   (BCC.EXE's 22-byte node also copies the word at +14h, and ADOPT_EXTERNAL_REGIONS,
   not in CPP.EXE, calls it too.) */
/* RH_COPY_DESCRIPTOR: copy a descriptor's ten data bytes (+0Ah..+13h) from
   source in descriptor bank source_bank to target in target_bank,
   allocating target in that bank first when it is 0.  Returns target.
   Bank switches are C assignments to _DS/_ES (segment set-up, as in
   HPALLOCH); the saved DS, the CS-relative program-DS loads and the rep movsw
   copy are inline asm. */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern HeapNode near * near pascal RNEWNODE(void);

HeapNode near * near pascal RH_COPY_DESCRIPTOR(unsigned int source_bank,
    unsigned int target_bank,HeapNode near *source,HeapNode near *target)
{
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[target_bank];
    if(!target) target=RNEWNODE();
    _ES=_DS;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[source_bank];
    asm mov si,source;
    asm mov di,target;
    asm add si,10;
    asm add di,10;
    asm mov cx,5;   /* CPP.EXE edit: five words (+0Ah..+13h of a 20-byte descriptor), BCC six */
    asm cld;
    asm rep movsw;
    asm pop ds;
    return target;
}

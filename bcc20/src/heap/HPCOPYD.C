/* target: CODE_2_RG2A4 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: RH_COPY_DESCRIPTOR copies a node descriptor's data bytes from one
   bank's descriptor table to another's. Entry points: RH_COPY_DESCRIPTOR. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: when a block moves between banks its descriptor moves with it
   (see HEAPMAIN.C's overview for banks and nodes): RH_COPY_DESCRIPTOR copies
   the part of a node that describes the block rather than its place (flags,
   owner tag, ring slot, output pointer, callback, bank byte and the word at
   +14h) into a node of the other bank.  key, size, the chain links and
   field8 stay with each bank's own node.  Used by RH_TRY_FLAG20/40
   (HPEVICT.C), ALLOC_BANK0_NODE and ADOPT_EXTERNAL_REGIONS (RHAPI.C). */
/* CODE_2:04B8..0506: copy a descriptor's twelve data bytes (+0Ah..+15h) from
   source in descriptor bank source_bank to target in target_bank,
   allocating target in that bank first when it is 0.  Returns target.
   Called from CODE_2 08ED..0C40 (0A00, 0B3C; not yet source) and the
   unlisted CODE_2 gap (217A, 2AC3).
   Bank switches are C assignments to _DS/_ES (segment set-up, as in
   HPALLOCH); the saved DS, the CS-relative program-DS loads and the rep movsw
   copy are inline asm. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
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
    asm mov cx,6;
    asm cld;
    asm rep movsw;
    asm pop ds;
    return target;
}

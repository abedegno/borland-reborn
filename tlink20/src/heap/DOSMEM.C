/* target: H_DOSMEM */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* Role: far blocks straight from DOS, outside the heap (DOS_ALLOC_FAR, DOS_FREE_FAR).
   TLINK's own addition to the heap library: BCC.EXE's copy has no such module. */
/* DOS_ALLOC_FAR(size) asks DOS (int 21h AH=48h) for a block and returns it
   as a far pointer with offset 0, or 0 when DOS refuses.  A size of
   FFFFFFFFh takes the largest free block: the first call with FFFFh
   paragraphs fails and leaves the largest size in BX, which the second
   call then allocates.  The paragraph count is (size + 15) >> 8, not >> 4
   (the high byte of the sum becomes BH and the next byte BL): asked for n
   bytes, DOS gives only about n/16 of them.  match: the code as found.
   DOS_FREE_FAR(block) gives a block back (AH=49h); it returns 0, or on
   failure the heap's status word rather than the DOS error. */
#include <dos.h>
extern unsigned int HEAP_STATUS;

void far * far pascal _loadds DOS_ALLOC_FAR(unsigned long size)
{
    unsigned segment,offset;    /* the block's address */
    if(size==0xFFFFFFFFUL) {
        asm mov bx,0FFFFh;
        asm mov ax,4800h;
        asm int 21h;
        asm mov ax,4800h;
        asm int 21h;
        offset=0;
        segment=_AX;
    } else {
        asm mov cx,word ptr size+2;
        asm mov bx,word ptr size;
        asm add bx,0Fh;
        asm adc cx,0;
        asm mov bl,bh;
        asm mov bh,cl;
        asm or ch,ch;
        asm je fits;
        return 0;
    fits:
        asm mov ax,4800h;
        asm int 21h;
        offset=0;
        segment=_AX;
        asm jae done;
        return 0;
    }
done:
    return MK_FP(segment,offset);
}

unsigned int far pascal _loadds DOS_FREE_FAR(void far *block)
{
    _ES=FP_SEG(block);
    asm mov ax,4900h;
    asm int 21h;
    asm jae freed;
    return HEAP_STATUS;
freed:
    return 0;
}

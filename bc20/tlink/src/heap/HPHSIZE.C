/* target: H_HPHSIZE */
/* opts: -mm -G -O -Z -p -r- -B -TjNOSMART -zCCODE2 */
/* HPHSIZE.C: three far heap entries in one module (the second half of HPOWNTAG.C,
   HPHSIZE.C and HPINBNK5.C in the bcc20 reconstruction).
   FREE_OWNER_TAG(tag) frees a tag: it releases every heap node the tag owns
   (FREE_TAG_NODES), then clears the tag's bit (rol builds the mask; C has no rotate
   operator).  HANDLE_BLOCK_SIZE returns the byte size last asked for (field8) of the
   block behind a handle word, in whatever bank it is.  HANDLE_IN_BANK_5 (the name
   from BCC's heap, where bank 5 is the discard bank) is nonzero when the block behind
   a handle is in TLINK's discard bank, 4: discarded, only its descriptor left.
   One module, through TASM: the relocation of FREE_OWNER_TAG's far call comes after
   the DGROUP loads of the two other functions in TLINK.EXE (and BCC.EXE and CPP.EXE),
   which is TASM's place for a call to an EXTRN that BCC's -B output declares at its
   end. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern void far pascal FREE_TAG_NODES(unsigned char tag);
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *node_offset);

void far pascal _loadds FREE_OWNER_TAG(unsigned char tag)
{
    FREE_TAG_NODES(tag);
    _BL=tag;
    _BH^=_BH;
    _CX=_BX;
    _CL&=7;
    _AL=0xFE;
    asm rol al,cl
    asm mov cl,3
    asm shr bx,cl
    asm and byte ptr OWNER_TAG_BITMAP[bx],al   /* byte bx of the bitmap */
}

unsigned int far pascal _loadds HANDLE_BLOCK_SIZE(unsigned int far *handle)
{
    HeapNode near *node;
    unsigned int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    return node->field8;
}

unsigned int far pascal _loadds HANDLE_IN_BANK_5(unsigned int far *handle)
{
    HeapNode near *node;
    return BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node)==4;
}

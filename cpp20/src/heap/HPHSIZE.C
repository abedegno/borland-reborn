/* target: HPHSIZE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPHSIZE (image 0x1F91..0x201C, 0054:1A51..0054:1ADC): FREE_OWNER_TAG
   and the two handle queries, from three files of the BCC.EXE reconstruction
   (bcc20/src/heap/HPOWNTAG.C, HPHSIZE.C and HPINBNK5.C), in BCC's order
   and kept as one source here, with CPP.EXE's edits marked "CPP.EXE edit".  The two
   queries were first matched as the tail of HPTAGS (BC 2.0).  Role: far-memory heap:
   free an owner tag's blocks, and the size and bank of the block behind a handle.
   HANDLE_BLOCK_SIZE and HANDLE_IN_BANK_5 are static and nothing in CPP.EXE calls them;
   FREE_OWNER_TAG is called from INITPOOL.C.
   Compiler: Turbo C 2.01.  HANDLE_IN_BANK_5 reserves its 2-byte local with sub sp,2
   (image 1FF2) where Borland C++ 2.0 writes dec sp; dec sp (BCC.EXE's own copy of the
   function has dec sp; dec sp).  Turbo C 2.01 has no _loadds; a huge function without
   register variables gives the same prologue (push bp; mov bp,sp; sub sp,N; push ds;
   mov ax,DGROUP; mov ds,ax) and pop ds before the return.  HANDLE_BLOCK_SIZE matches
   with either compiler (sub sp,4 in both); it is taken with its neighbour.  Nothing in
   CPP.EXE tells whether the two were one file or two.  CRLF line ends, for CPPHEAP.H's
   sake.  "image" marks a CPP.EXE image offset, 0054:xxxx a CPP.EXE address in the heap
   frame; the relocation addresses below are image offsets. */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *node_offset);

/* ---- FREE_OWNER_TAG, from heap/HPOWNTAG.C (BCC) ---- */
/* link: FREE_OWNER_TAG belongs to this Turbo C file in CPP.EXE, not to HPTAGS.C. TASM writes
   a module's fixups in order but defers those of symbols not yet declared (externs come at
   the end of the compiler's assembly) to the end of the module; CPP.EXE's relocation table
   has this function's DGROUP load (1F96h), then HANDLE_BLOCK_SIZE's and HANDLE_IN_BANK_5's
   (1FC5h, 1FF7h), then its far call to FREE_TAG_NODES (1FA0h): exactly what one Turbo C -B
   object holding the three functions gives (tested), and not two objects. CPP.EXE edit:
   `huge` for BCC's _loadds, as in the rest of this file. */
extern void far pascal FREE_TAG_NODES(unsigned int tag);
extern unsigned int OWNER_TAG_BITMAP[16];
void huge pascal FREE_OWNER_TAG(unsigned int tag)
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
    asm and byte ptr [bx+DGROUP:OWNER_TAG_BITMAP],al   /* byte bx of the bitmap */
}

/* ---- from heap/HPHSIZE.C ---- */
/* HANDLE_BLOCK_SIZE returns the size of the block behind a handle: the byte
   size last asked for (field8) of the block behind a handle word, in
   whatever bank it is. */

/* CPP.EXE edit: huge for BCC's _loadds (Turbo C 2.01: see the top of the file). */
static unsigned int huge pascal HANDLE_BLOCK_SIZE(unsigned int far *handle)
{
    /* CPP.EXE edit: node declared first and the bank stored in its own statement
       (image 1FD7: mov [bp-2],ax; mov bx,ax): Turbo C 2.01 gives node [bp-4] and
       bank [bp-2] this way; BCC's one-statement form stores the bank through BX. */
    HeapNode near *node;
    unsigned int bank;
    bank=BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    return node->field8;
}

/* ---- from heap/HPINBNK5.C ---- */
/* HANDLE_IN_BANK_5 tells whether a handle's node currently lives in the
   null bank (bank 4 in CPP.EXE, BCC's bank 5; the name is BCC's): nonzero
   when the block behind a handle word is discarded or not yet loaded (only
   its descriptor exists). */

/* CPP.EXE edit: huge for BCC's _loadds (Turbo C 2.01: see the top of the file). */
static unsigned int huge pascal HANDLE_IN_BANK_5(unsigned int far *handle)
{
    HeapNode near *node;
    /* CPP.EXE edit: bank 4 is the null bank (0054:1AC9: cmp ax,4). */
    return BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node)==4;
}

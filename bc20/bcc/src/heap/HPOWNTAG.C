/* target: CODE_2_R3513 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: allocates and frees the owner tags that group heap nodes for
   release together. Entry points: ALLOCATE_OWNER_TAG, FREE_OWNER_TAG. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: owner tags group heap blocks so that a part of the compiler
   can free all its blocks at once.  Every node records the tag that was
   HEAP_DEFAULT_OWNER_TAG when it was allocated (RHSLICE puts it in
   field12); SET_DEFAULT_OWNER_TAG and its callers change the default (for example
   BACKINIT.C sets it to BACKEND_OWNER_TAG), FREE_TAG_NODES (HPFREETG.C) frees
   every block with a tag and CHANGE_TAG_NODES_MODE (RHAPI.C) changes their
   mode.  This file hands tags out and takes them back.  Owner tags are
   unrelated to the "tagged" flag 800h of the handle ring (HPRING.C). */
/* CODE_2:2BD3..2C48: the owner-tag allocator and its release.
   ALLOCATE_OWNER_TAG allocates an owner tag (the byte stored in
   a heap node's field12; see HPFREETG and RHAPI's CHANGE_TAG_NODES_MODE).  OWNER_TAG_BITMAP
   holds 256 bits, one per tag, set while the tag is in use.  The first clear
   bit is set and its tag number returned in AL; 0 when every tag is in use
   (words of FFFFh are skipped).  Tag 0 is reserved: bit 0 is set in the
   initial data.
   BC 2.0 C with _loadds, register pseudo-variables and inline asm for the
   string and rotate instructions.  The register moves are C (BCC's own
   encodings) and the leas inline asm (BCC's built-in assembler keeps lea for
   a global, which TASM's smart mode would turn into mov).
   FREE_OWNER_TAG(tag) frees a tag: it releases every heap node the tag owns
   (FREE_TAG_NODES), then clears the tag's bit (rol builds the mask; C has no
   rotate operator).  The two were one module in an earlier stage of the recovery. */
#include "DATA.H"
extern void far pascal FREE_TAG_NODES(unsigned char tag);

unsigned char far pascal _loadds ALLOCATE_OWNER_TAG(void)
{
    /* Scan the 16 words of OWNER_TAG_BITMAP for the first clear bit: ror
       moves bit 0 into the carry, so CX counts down from 16 at the bit
       found.  Then set it (or 8000h, rotated back into place) and turn the
       word and bit position into the tag number in AL. */
    asm cld
    asm lea dx,OWNER_TAG_BITMAP+32
    asm lea si,OWNER_TAG_BITMAP
next_word:
    asm lodsw
    if(_AX!=0xFFFF) {
        _CX=16;
scan:
        asm ror ax,1
        asm jnc found
        asm loop scan
    }
    if(_SI<_DX) goto next_word;
    return 0;
found:
    _AX|=0x8000;
    _BX=_CX;
    --_CX;
    asm ror ax,cl
    asm mov [si-2],ax
    asm sub si,offset OWNER_TAG_BITMAP+2
    asm mov cl,3
    asm shl si,cl
    _AX=_SI;
    _AX+=16;
    _AX-=_BX;
    return _AL;     /* documented pseudo-register read */
}

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

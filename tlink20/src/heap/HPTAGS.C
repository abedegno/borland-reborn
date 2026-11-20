/* target: H_HPTAGS */
/* opts: -mm -G -O -Z -p -B -TjNOSMART -zCCODE2 */
/* HPTAGS.C: the heap's owner tags (one module: OWNERTAG.C, HPDEFTAG.C and the first
   half of HPOWNTAG.C in the bcc20 reconstruction).  Owner tags group heap blocks so
   that a part of the program can free all its blocks at once: every node records the
   tag that was HEAP_DEFAULT_OWNER_TAG when it was allocated (RHSLICE puts it in
   field12), FREE_TAG_NODES (HPFREETG.C) frees every block with a tag.
   SET_DEFAULT_OWNER_TAG and GET_DEFAULT_OWNER_TAG store and return the default;
   ALLOCATE_OWNER_TAG hands out a tag: OWNER_TAG_BITMAP holds 256 bits, one per tag,
   set while the tag is in use; the first clear bit is set and its tag number returned
   in AL, 0 when every tag is in use.  Tag 0 is reserved (bit 0 set in the data).
   Built through TASM (-B) with smart mode off (-TjNOSMART), as cpp20 found for the
   same module of CPP.EXE: the fixups come in TASM's ascending order and the leas stay
   leas.  The register moves are C and the string and rotate instructions inline asm. */
#include "DATA.H"

void far pascal _loadds SET_DEFAULT_OWNER_TAG(unsigned char value)
{
    HEAP_DEFAULT_OWNER_TAG=value;
}

unsigned char far pascal _loadds GET_DEFAULT_OWNER_TAG(void)
{
    return HEAP_DEFAULT_OWNER_TAG;
}

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

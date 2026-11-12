/* target: HPTAGS */
/* opts: -mm -G -O -Z -p -B -TjNOSMART -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPTAGS (image 0x1F26..0x1F91, 0054:19E6..0054:1A51): the owner tags,
   from three files of the BCC.EXE reconstruction (bcc20/src/heap/
   OWNERTAG.C, HPDEFTAG.C and HPOWNTAG.C), in BCC's order and kept as one source here.
   Nothing in CPP.EXE tells whether they were one file or three (no far call between
   them).  The empty stub in front (image 0x1F21) is HPSTUBAP.C.  FREE_OWNER_TAG (the
   rest of BCC's HPOWNTAG.C) and the two handle queries that follow in BCC (HPHSIZE.C
   and HPINBNK5.C), image 0x1F91..0x201C, are a separate module compiled by Turbo C
   2.01: see HPHSIZE.C.  CRLF line ends, for CPPHEAP.H's sake.  "image" marks a CPP.EXE
   image offset, 0054:xxxx a CPP.EXE address in the heap frame. */
/* Compiler: Borland C++ 2.0, not Turbo C 2.01.  Turbo C 2.01 (tried,
   the functions as huge pascal) leaves out push bp; mov bp,sp in GET_DEFAULT_OWNER_TAG
   and ALLOCATE_OWNER_TAG (no arguments, no locals), which CPP.EXE has (image 1F3A,
   1F49), and it cannot pass -TjNOSMART to TASM.
   Built with -TjNOSMART: ALLOCATE_OWNER_TAG's two leas of a global stay leas
   (0054:1A14, 0054:1A18), which TASM's smart mode turns into mov.  The asm references to
   OWNER_TAG_BITMAP name DGROUP: so that their fixups are DGROUP-relative (the
   bytes are the same either way; without DGROUP: verify.py takes the variable as a
   far one whose segment half is never referenced). */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned char HEAP_DEFAULT_OWNER_TAG;    /* DATA.H's (LF, which Turbo C 2.01 -B cannot read) */
extern unsigned int OWNER_TAG_BITMAP[16];
extern void far pascal FREE_TAG_NODES(unsigned int tag);

/* ---- from heap/OWNERTAG.C ---- */
/* Role: far-memory heap: SET_DEFAULT_OWNER_TAG stores the owner tag the heap gives new
   nodes. Entry points: SET_DEFAULT_OWNER_TAG. */
/* Overview: SET_DEFAULT_OWNER_TAG
   does not set a compiler option: it stores its argument in HEAP_DEFAULT_OWNER_TAG, the
   owner tag the far heap gives to new nodes when the caller passes no tag. Callers set
   a tag before building pools and restore the old tag afterwards (in CPP.EXE: MEMINIT.C,
   OPTIONS.C, INITPOOL.C, LEXER.C, RFILEIO.C). A later "free all nodes with tag
   T" (FREE_TAG_NODES) then releases everything allocated in between. _loadds makes the
   function load DS itself (in BCC.EXE it is called from overlays). */
void far pascal _loadds SET_DEFAULT_OWNER_TAG(unsigned char value)
{
    HEAP_DEFAULT_OWNER_TAG=value;
}

/* ---- from heap/HPDEFTAG.C ---- */
/* Role: far-memory heap: returns the default owner tag for new heap nodes. Entry points:
   GET_DEFAULT_OWNER_TAG. */
/* Overview: returns HEAP_DEFAULT_OWNER_TAG, the owner tag (see below)
   that new heap blocks are given at the moment. */
unsigned char far pascal _loadds GET_DEFAULT_OWNER_TAG(void)
{
    return HEAP_DEFAULT_OWNER_TAG;
}

/* ---- from heap/HPOWNTAG.C ---- */
/* Role: far-memory heap: allocates the owner tags that group heap nodes for release
   together. Entry points: ALLOCATE_OWNER_TAG (FREE_OWNER_TAG, which frees them, is in
   HPHSIZE.C in CPP.EXE). */
/* Overview: owner tags group heap blocks so that a part of the program
   can free all its blocks at once.  Every node records the tag that was
   HEAP_DEFAULT_OWNER_TAG when it was allocated (RHSLICE puts it in
   field12); SET_DEFAULT_OWNER_TAG and its callers change the default,
   and FREE_TAG_NODES (HPFREETG.C) frees every block with a tag.  This part
   hands tags out (OPTIONS.C calls it).  (BCC.EXE also has
   CHANGE_TAG_NODES_MODE and a handle ring with a "tagged" flag 800h,
   unrelated to owner tags; CPP.EXE has neither.) */
/* ALLOCATE_OWNER_TAG allocates an owner tag (the byte stored in
   a heap node's field12; see HPFREETG.C).  OWNER_TAG_BITMAP
   holds 256 bits, one per tag, set while the tag is in use.  The first clear
   bit is set and its tag number returned in AL; 0 when every tag is in use
   (words of FFFFh are skipped).  Tag 0 is reserved: bit 0 is set in the
   initial data.
   BC 2.0 C with _loadds, register pseudo-variables and inline asm for the
   string and rotate instructions.  The register moves are C (BCC's own
   encodings) and the leas inline asm (BCC's built-in assembler keeps lea for
   a global, which TASM's smart mode would turn into mov).
   FREE_OWNER_TAG(tag) (HPHSIZE.C here) frees a tag: it releases every heap
   node the tag owns (FREE_TAG_NODES), then clears the tag's bit (rol builds
   the mask; C has no rotate operator). */

unsigned char far pascal _loadds ALLOCATE_OWNER_TAG(void)
{
    /* Scan the 16 words of OWNER_TAG_BITMAP for the first clear bit: ror
       moves bit 0 into the carry, so CX counts down from 16 at the bit
       found.  Then set it (or 8000h, rotated back into place) and turn the
       word and bit position into the tag number in AL. */
    asm cld
    asm lea dx,DGROUP:OWNER_TAG_BITMAP+32
    asm lea si,DGROUP:OWNER_TAG_BITMAP
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
    asm sub si,offset DGROUP:OWNER_TAG_BITMAP+2
    asm mov cl,3
    asm shl si,cl
    _AX=_SI;
    _AX+=16;
    _AX-=_BX;
    return _AL;     /* documented pseudo-register read */
}

/* link: FREE_OWNER_TAG (image 0x1F91) is in HPHSIZE.C in CPP.EXE: see the note there. */


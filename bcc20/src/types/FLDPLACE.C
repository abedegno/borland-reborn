/* target: ovr096_C38UNIT */
/* Role: types: places struct members and bitfields at offsets (honouring word alignment);
   builds the hidden return slot address. Entry points: PLACE_STRUCT_MEMBER,
   PLACE_BITFIELD_MEMBER, MAKE_RETURN_SLOT. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: struct layout helpers plus one return-value helper, used while declaring
   class members and compiling C++ function bodies.
   PLACE_STRUCT_MEMBER and PLACE_BITFIELD_MEMBER are a pair: the caller keeps a running layout
   state for the struct being declared (total = bytes laid out so far, bits = bits used
   in the bitfield word that is still open) and calls one of them per member; each
   writes the member's byte offset (and, for a bitfield, its bit shift) and advances the
   state. They place members; they do not compute type sizes.
   BCC_PACK_FLAG is the word-alignment option: when set, members larger than one byte and
   new bitfield words start on an even offset. No caller names them directly in src/;
   they are probably reached through the overlay stubs listed in OVL.H.
   MAKE_RETURN_SLOT is called from parser/STMTCPP.C for a function that returns
   a structure in memory: it builds the expression "*hidden return pointer" naming the
   caller-supplied slot, or returns 0 when the value comes back in registers.
   EXPR_FLAGS is indexed by type kind and classes kinds (as used across src/: 1 integral,
   2 floating, 0x14 pointer kinds, 0x40 struct/union). */
/* Whole original record96/0C5D; actual native CO027, 505 bytes. */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
#include <dos.h>
#include "FLDPLACE.H"
#include "POOL.H"

/* PLACE_STRUCT_MEMBER: places an ordinary member of "size" bytes. First closes any open
   bitfield word (rounding *bits up to whole bytes), aligns to even if word alignment is
   on and the member is bigger than a byte, then stores the member's offset in *offset,
   adds the size to *total and clears *bits. */
void far pascal PLACE_STRUCT_MEMBER(long size,long far *total,int far *bits,int far *offset)
{
    long position=*total+((*bits+7)>>3);
    if(size>1 && BCC_PACK_FLAG) position=(position+1)&~1L;
    *offset=position;
    *total=position+size;
    *bits=0;
}
/* PLACE_BITFIELD_MEMBER: places a bitfield member "requested_width" bits wide (0 means
   "close the current word" as in C). Bitfields are packed into 16-bit words: when the
   new field does not fit in the bits left (or width is 0) the open word is closed and,
   with word alignment, the offset is made even. Whole bytes already used are folded
   into the offset so *shift is always 0..7; *offset and *shift receive the field's byte
   offset and bit position. The state is then advanced past the field: complete bytes go
   into *total and the remainder stays in *bits. Without word alignment (or when the field
   ends exactly on a word) each full byte the field covers is moved into *total at once. */
void far pascal PLACE_BITFIELD_MEMBER(int requested_width,long far *total,int far *bits,int far *offset,int far *shift)
{
    long position=*total;
    register int used=*bits;
    register int width=requested_width;
    if(used+width>16 || width==0) {
        position+=(used+7)>>3;
        if(BCC_PACK_FLAG) position=(position+1)&~1L;
        used=0;
    }
    if(used>=8) {++position;used-=8;}
    *offset=position;*shift=used;
    if(!BCC_PACK_FLAG || used+width==16) {
        while(used+width>=8) {++position;width-=8;}
    }
    used+=width;
    *total=position;*bits=used;
}
/* MAKE_RETURN_SLOT: symbol is the function being compiled (STMTCPP.C passes
   BCC_TREE_SPECIAL). Looks at its return type (TYPE_TARGET of the function type); a
   member-function pointer (near pointer with TYPE_PTR_MODE 0x0B to a function) is
   returned as the struct type MEMBER_PTR_CLASS_TYPE. Returns 0 when the value is not a
   struct/union, or is one of 1, 2 or 4 bytes with no special members (TYPE_ATTRS bit 4,
   probably "has a constructor"), since such values return in registers. Otherwise finds
   the hidden parameter HIDDEN_RETURN_PARAM_NAME in the function's name list (word +4 of
   the scope record BCC_TREE_LINK) and returns MAKE_UNARY_NODE(0x18, its symbol node):
   0x18 is the token TOK_STAR, so the result is "*param", the return slot itself, not its
   address. */
unsigned int far pascal MAKE_RETURN_SLOT(register unsigned int symbol)
{
    unsigned int size,expression;
    register unsigned int type=TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_TARGET);
    if(TYPE_W(type,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(type,TYPE_PTR_MODE)==0xb &&
       (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) type=MEMBER_PTR_CLASS_TYPE;
    size=TYPE_SIZE(type);
    if(!(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) || (size<=4 && size!=3 && !(TYPE_B(type,TYPE_ATTRS)&4))) return 0;
    expression=MAKE_SYMBOL_NODE(FIND_NAME_IN_LIST(HIDDEN_RETURN_PARAM_NAME,AT_W(SCOPE_POOL_SEG,BCC_TREE_LINK+4)));
    return MAKE_UNARY_NODE(0x18,expression);
}

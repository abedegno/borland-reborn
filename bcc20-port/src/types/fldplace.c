/* fldplace.c: from bcc20/src/types/FLDPLACE.C: placing struct members and bitfields, and
   the hidden return slot of a function returning a struct. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "protos.h"

#define BCC_PACK_FLAG B(BCC_PACK_FLAG_P)

/* an ordinary member of size bytes: close any open bitfield word (rounding *bits up to
   bytes), align to even with word alignment for members over a byte, store the offset in
   *offset, add the size to *total, clear *bits */
void PLACE_STRUCT_MEMBER(i32 size, farptr total, farptr bits, farptr offset)
{
    i32 position = SD(total) + ((SW(bits) + 7) >> 3);
    if (size > 1 && BCC_PACK_FLAG)
        position = (position + 1) & ~1L;
    SW(offset) = (i16)position;
    SD(total) = position + size;
    SW(bits) = 0;
}

/* a bitfield requested_width bits wide (0 closes the current word).  Fields pack into
   16-bit words: one that does not fit in the bits left (or width 0) closes the open word,
   made even with word alignment.  Whole bytes used are folded into the offset, so *shift
   is 0..7; *offset and *shift get the field's byte and bit position.  Then complete bytes
   go into *total and the rest stays in *bits; without word alignment (or when the field
   ends exactly on a word) each full byte the field covers moves into *total at once. */
void PLACE_BITFIELD_MEMBER(i16 requested_width, farptr total, farptr bits, farptr offset, farptr shift)
{
    i32 position = SD(total);
    i16 used = SW(bits), width = requested_width;
    if (used + width > 16 || width == 0) {
        position += (used + 7) >> 3;
        if (BCC_PACK_FLAG)
            position = (position + 1) & ~1L;
        used = 0;
    }
    if (used >= 8) {
        ++position;
        used -= 8;
    }
    SW(offset) = (i16)position;
    SW(shift) = used;
    if (!BCC_PACK_FLAG || used + width == 16)
        while (used + width >= 8) {
            ++position;
            width -= 8;
        }
    used += width;
    SD(total) = position;
    SW(bits) = used;
}

/* the return slot of the function being compiled, as "*hidden parameter", when it returns
   a struct or union that does not come back in registers (not 1, 2 or 4 bytes, or with
   special members, TYPE_ATTRS bit 4); 0 otherwise.  A member-function pointer is returned
   as the struct MEMBER_PTR_CLASS_TYPE. */
u16 MAKE_RETURN_SLOT(u16 symbol)
{
    u16 type = TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_TARGET);
    if (TYPE_W(type, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(type, TYPE_PTR_MODE) == 0xB &&
        (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) &&
        TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION)
        type = MEMBER_PTR_CLASS_TYPE;
    u16 size = (u16)TYPE_SIZE(type);
    if (!(EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) ||
        (size <= 4 && size != 3 && !(TYPE_B(type, TYPE_ATTRS) & 4)))
        return 0;
    u16 expression = MAKE_SYMBOL_NODE(FIND_NAME_IN_LIST(HIDDEN_RETURN_PARAM_NAME,
                                                        AT_W(SCOPE_POOL_SEG, BCC_TREE_LINK + 4)));
    return MAKE_UNARY_NODE(0x18, expression);
}

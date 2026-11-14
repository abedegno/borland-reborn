/* hpowntag.c: from bcc20/src/heap/HPOWNTAG.C: owner tags group heap blocks so that a part
   of the compiler can free all its blocks at once (every block records the default owner
   tag of its allocation; FREE_TAG_NODES frees all blocks of a tag).  OWNER_TAG_BITMAP
   holds 256 bits, one per tag, set while the tag is in use; tag 0 is reserved (its bit is
   set in the initial data).  ALLOCATE_OWNER_TAG takes the first clear bit, 0 when every tag
   is in use; FREE_OWNER_TAG frees the tag's blocks and clears its bit. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define OWNER_TAG_BITMAP_P DSPTR(0x06DA)

u8 ALLOCATE_OWNER_TAG(void)
{
    for (u16 word = 0; word < 16; word++) {
        farptr p = fp_add(OWNER_TAG_BITMAP_P, word * 2);
        if (W(p) == 0xFFFF)
            continue;
        for (u16 bit = 0; bit < 16; bit++)
            if (!(W(p) >> bit & 1)) {
                W(p) |= (u16)(1u << bit);
                return (u8)(word * 16 + bit);
            }
    }
    return 0;
}

void FREE_OWNER_TAG(u8 tag)
{
    FREE_TAG_NODES(tag);
    B(fp_add(OWNER_TAG_BITMAP_P, tag >> 3)) &= (u8)~(1u << (tag & 7));
}

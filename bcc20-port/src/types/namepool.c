/* namepool.c: from bcc20/src/types/NAMEPOOL.C: the identifier table.

   Every identifier, keyword and macro name becomes one name record (BCC_SYMBOL_CREATE), so
   two spellings of a name always give the same record number.  NAME_HASH_TABLE has 1024
   chain heads.  A record sits at the same offset in two 6-byte pools allocated in step:
   HASH_CHAIN_LINK_SEG (+0 chain link, +2 macro definition, +4 value: the token or keyword
   code) and NAME_POOL_SEG (+0 head of the symbols bound to the name, +2 offset of its text,
   +4 near pointer to its C31_BANKS entry).  The text banks are 64K segments (8-byte
   entries: segment, capacity, used, extra); a new one is opened when one is nearly full.
   Names are never removed.  The original's inline assembly (copy, strlen and compare
   loops) is plain C here. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define BANK(i) (FP_OFF(C31_BANKS_P) + 8 * (i))        /* near pointer to bank entry i */
#define NB_SEGMENT(b) W(DSPTR(b))
#define NB_CAPACITY(b) W(DSPTR((b) + 2))
#define NB_USED(b) W(DSPTR((b) + 4))
#define NB_EXTRA(b) W(DSPTR((b) + 6))
#define HASH_HEAD(h) W(fp_add(NAME_HASH_TABLE_P, 2 * (h)))

/* copy length bytes of text into the current bank, opening the next one when used +
   length reaches FF00h; the result is the bank entry's near pointer (high word) and the
   copy's offset in its segment (low word) */
u32 COPY_NAME_TO_BANK(farptr text, u16 length)
{
    u16 bank = BANK(CURRENT_BANK_INDEX);
    if ((u16)(NB_USED(bank) + length) >= 0xFF00) {
        CURRENT_BANK_INDEX++;
        bank += 8;
        NB_USED(bank) = NB_CAPACITY(bank) = 1;
        NB_EXTRA(bank) = 0;
        POOL_INIT(DSPTR(bank), 1);
    }
    u16 copy = POOL_ALLOC(DSPTR(bank), length);
    for (u16 i = 0; i < length; i++)
        B(MK_FP(NB_SEGMENT(bank), copy + i)) = B(fp_add(text, i));
    return (u32)bank << 16 | copy;
}


/* the record for the name text, created with value if it is new.  The hash, for two or
   more characters, mixes the length (with the NUL), the first two bytes and the last two
   characters; for one character it is that character, sign-extended and not masked (a
   byte from 80h indexes before NAME_HASH_TABLE, as in the original). */
u16 BCC_SYMBOL_CREATE(farptr text, u16 value)
{
    u16 length = STRING_LENGTH(text) + 1;
    i16 hash;
    if (length > 2)
        hash = (i16)(((u16)(length << 6) + W(text) + (u16)(W(fp_add(text, length - 3)) << 3)) & 0x3FF);
    else
        hash = SB(text);
    if (HASH_HEAD(hash) == 0) {
        u16 node = POOL_ALLOC(NAME_POOL_SEG_P, 6);
        POOL_ALLOC(HASH_CHAIN_LINK_SEG_P, 6);
        HASH_HEAD(hash) = node;
        HLINK_W(node, HLINK_NEXT) = 0;
        NAME_W(node, NAME_SYMBOLS) = 0;
        HLINK_W(node, HLINK_MACRO) = 0;
        HLINK_W(node, HLINK_TOKEN) = value;
        u32 where = COPY_NAME_TO_BANK(text, length);
        D(MK_FP(NAME_POOL_SEG, node + NAME_TEXT_OFFSET)) = where;
        return node;
    }
    /* the chain: compare the text, its NUL included */
    u16 node = HASH_HEAD(hash), last = 0;
    while (node) {
        u16 bank = NAME_W(node, 4);
        farptr name = MK_FP(NB_SEGMENT(bank), NAME_W(node, 2));
        u16 i = 0;
        while (i < length && B(fp_add(text, i)) == B(fp_add(name, i)))
            i++;
        if (i == length)
            return node;
        last = node;
        node = HLINK_W(node, HLINK_NEXT);
    }
    u16 created = POOL_ALLOC(NAME_POOL_SEG_P, 6);
    POOL_ALLOC(HASH_CHAIN_LINK_SEG_P, 6);
    HLINK_W(last, HLINK_NEXT) = created;
    HLINK_W(created, HLINK_NEXT) = 0;
    NAME_W(created, NAME_SYMBOLS) = 0;
    HLINK_W(created, HLINK_MACRO) = 0;
    HLINK_W(created, HLINK_TOKEN) = value;
    u32 where = COPY_NAME_TO_BANK(text, length);
    D(MK_FP(NAME_POOL_SEG, created + NAME_TEXT_OFFSET)) = where;
    return created;
}

/* pools.c: from bcc20/src/heap/POOLS.C: growable pools of small records in one heap block.

   A pool is four words, normally a global in DGROUP: [0] the block's segment (its heap
   handle word, which the heap rewrites when it moves the block), [1] its capacity in bytes,
   [2] the bytes used, [3] the head of a list of freed items.  An item is a byte offset in
   the segment; a freed item's first word links to the next.  POOL_ALLOC hands out bytes at
   the end and grows the block through the heap (RESIZE_POOL_BLOCK): capacity starts at
   100h and doubles up to 2000h, then grows by 2000h, at most FFFFh; a pool that would reach
   64K stops BCC with "compiler table limit".  POOL_SET_USED is left out: nothing in BCC
   calls it. */
#include "port.h"
#include "protos.h"
#include "variadic.h"
#include "msg.h"

#define POOL(p, i) W(fp_add((p), 2 * (i)))

/* a freed item of the pool if there is one, else POOL_ALLOC(pool, size) */
u16 POOL_ALLOC_REUSE(farptr pool, u16 size)
{
    if (POOL(pool, 3) != 0) {
        u16 item = POOL(pool, 3);
        POOL(pool, 3) = W(MK_FP(POOL(pool, 0), item));
        return item;
    }
    return POOL_ALLOC(pool, size);
}

void POOL_FREE_ITEM(farptr pool, u16 item)
{
    W(MK_FP(POOL(pool, 0), item)) = POOL(pool, 3);
    POOL(pool, 3) = item;
}

/* size bytes at the end of the pool, growing its block when the capacity is too small;
   returns their offset */
u16 POOL_ALLOC(farptr pool, u16 size)
{
    u16 result = POOL(pool, 2);
    if ((u32)POOL(pool, 2) + size >= 0xFFFF)
        REPORT_FATAL(MSG_COMPILER_TABLE_LIMIT);
    size += POOL(pool, 2);
    if (POOL(pool, 1) < size) {
        u16 capacity = POOL(pool, 1);
        if (capacity < 0x100)
            capacity = 0x100;
        while (capacity < size) {
            if (capacity <= 0x2000)
                capacity <<= 1;
            else if ((u32)capacity + 0x2000 > 0xFFFF) {   /* the add carries: clamp, stop */
                capacity = 0xFFFF;
                break;
            } else
                capacity += 0x2000;
        }
        RESIZE_POOL_BLOCK(pool, capacity);
        POOL(pool, 1) = capacity;
    }
    POOL(pool, 2) = size;
    return result;
}

/* shrink the pool's block to the bytes used plus size spare bytes, when it is bigger */
void POOL_TRIM(farptr pool, u16 size)
{
    u16 capacity = POOL(pool, 2) + size;
    if (POOL(pool, 1) > capacity) {
        POOL(pool, 1) = capacity;
        RESIZE_POOL_BLOCK(pool, capacity);
    }
}

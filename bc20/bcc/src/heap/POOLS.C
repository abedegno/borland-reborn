/* target: ovr124_C237UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: memory: growable near pools (segment, capacity, used, free list): allocate, reuse,
   free, trim; reports compiler table limit. Entry points: POOL_ALLOC_REUSE, POOL_FREE_ITEM,
   POOL_ALLOC, POOL_TRIM, POOL_SET_USED. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: growable pools of small records inside one heap block.  A pool
   is four words, normally globals in DGROUP: [0] the block's segment (its
   heap handle word, so the heap rewrites it when the block moves), [1] its
   capacity in bytes, [2] the bytes used, [3] the head of a list of freed
   items.  An item is a byte offset in the segment; a freed item's first word
   links to the next freed one.  POOL_ALLOC hands out the next bytes at the
   end and grows the block (RESIZE_POOL_BLOCK, a heap entry) when needed:
   capacity starts at 100h and doubles up to 2000h, then grows by 2000h, at
   most FFFFh; a pool that would pass 64K stops BCC with "compiler table
   limit".  POOL_ALLOC_REUSE takes a freed item first (the pool's items are
   probably all one size, as size is not checked).  POOL_FREE_ITEM frees an
   item, POOL_TRIM drops spare capacity, POOL_SET_USED sets the used size.
   The block itself is allocated by POOL_INIT (POOLINIT.C). */
#include <dos.h>
#include "RTL.H"
#include "MSG.H"

/* ---- POOL_ALLOC_REUSE (listing D430) ---- */
unsigned int far pascal POOL_ALLOC(unsigned int far *pool,unsigned int size);
/* row X043_00 (offset 0x0): stub 0CE6:0025 = POOL_ALLOC_REUSE */
/* A pool is four words: segment, capacity, bytes used, free-list head. */

/* Return a freed item of pool if there is one, else POOL_ALLOC(pool, size). */
unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *pool,unsigned int size)
{
    register unsigned int item;

    if(pool[3]!=0) {
        item=pool[3];
        pool[3]=*(unsigned int far *)MK_FP(pool[0],item);
        return item;
    }
    return POOL_ALLOC(pool,size);
}

/* ---- POOL_FREE_ITEM (listing D466) ---- */
/* row POOL_FREE_ITEM (offset 0x36): stub 0CE6:0034 = POOL_FREE_ITEM */
/* Put item on pool's free list. */
void far pascal POOL_FREE_ITEM(unsigned int far *pool,register unsigned int item)
{
    *(unsigned int far *)MK_FP(pool[0],item)=pool[3];
    pool[3]=item;
}

/* ---- POOL_ALLOC (listing D486) ---- */
/* row X043_02 (offset 0x56): stub 0CE6:002F = POOL_ALLOC */
extern void far pascal RESIZE_POOL_BLOCK(unsigned int far *,unsigned int);

/* -G: the original pops the REPORT_FATAL argument with inc sp; inc sp
   (0089) and allocates its local with dec sp; dec sp (0059). */
#pragma option -G
/* Take size bytes at the end of pool, growing its block when the capacity
   is too small; returns their offset.  Fatal when the pool would reach 64K. */
unsigned int far pascal POOL_ALLOC(unsigned int far *pool,register unsigned int size)
{
    unsigned int result;
    register unsigned int capacity;

    result=pool[2];
    if((long)pool[2]+size>=0xFFFFL)
        REPORT_FATAL(MSG_COMPILER_TABLE_LIMIT);
    size+=pool[2];
    if(pool[1]<size) {
        capacity=pool[1];
        if(capacity<0x100)
            capacity=0x100;
        while(capacity<size) {
            if(capacity<=0x2000)
                capacity<<=1;
            else {
                capacity+=0x2000;
                /* If the add wrapped past 64K, clamp the capacity to 0xFFFF and
                   stop growing.  The original tests the carry of that add
                   directly (00B1 add si,2000h; 00B5 jae): BC's _FLAGS
                   pseudo-variable, bit 0 = CF, read right after the add.
                   Every plain C form ((capacity+=0x2000)<0x2000, a separate
                   compare, <=0x1FFF, an unsigned long sum) adds a cmp. */
                if(_FLAGS&1) {
                    capacity=0xFFFF;
                    break;
                }
            }
        }
        RESIZE_POOL_BLOCK(pool,capacity);
        pool[1]=capacity;
    }
    pool[2]=size;
    return result;
}
#pragma option -G-

/* ---- POOL_TRIM (listing D515) ---- */
/* row X043_03 (offset 0xE5): stub 0CE6:002A = POOL_TRIM */

/* Shrink pool's block to the bytes used plus size spare bytes, when it is
   bigger. */
void far pascal POOL_TRIM(unsigned int far *pool,unsigned int size)
{
    register unsigned int capacity;

    capacity=pool[2]+size;
    if(pool[1]>capacity) {
        pool[1]=capacity;
        RESIZE_POOL_BLOCK(pool,capacity);
    }
}

/* ---- POOL_SET_USED (listing D540) ---- */
/* row X043_01 (offset 0x110): stub 0CE6:0020 = POOL_SET_USED */

/* Set the bytes used of pool to size, first growing the block to size
   rounded up to 256 bytes when it is too small. */
void far pascal POOL_SET_USED(unsigned int far *pool,register unsigned int size)
{
    register unsigned int capacity;

    if(pool[1]<size) {
        capacity=(size+0xFF)&0xFF00;
        if(capacity==0)
            capacity-=2;     /* 0 (a full 64K) becomes 0xFFFE */
        RESIZE_POOL_BLOCK(pool,capacity);
        pool[1]=capacity;
    }
    pool[2]=size;
}

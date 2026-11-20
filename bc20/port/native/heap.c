/* heap.c: the native build's far heap, in place of BCC's (../bcc20/src/heap: banks in
   conventional memory, EMS, extended memory and swap files, handle rings, compaction).
   Here there is one bank, conventional memory from INIT_HEAP's start to its limit, and no
   swapping.  It keeps the original's contract with its callers: every block has an owner
   word, its handle, which holds the block's segment and is rewritten when the block moves
   (a pool that grows past its neighbour is copied elsewhere); every block records the
   default owner tag of its allocation, and FREE_TAG_NODES frees all blocks of a tag,
   clearing their handles; HEAP_ALLOC_HANDLE hands out heap-owned handle words.  Blocks are
   zero-filled when allocated.  A block fixed with FIX_HEAP_NODE_LOW (the malloc pool, whose
   items hold far pointers to one another) never moves: when it grows, the blocks in its way
   move instead, as the original's RESIZE_NODE gathers free space above a fixed node. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "port.h"
#include "data.h"
#include "protos.h"
#include "native.h"

typedef struct {
    u16 seg, paras;
    farptr handle;      /* the owner's word holding seg */
    u8 tag;
    u8 item;            /* the handle is a heap-owned item (HEAP_ALLOC_HANDLE) */
    u8 fixed;           /* FIX_HEAP_NODE_LOW: never moves */
} Block;

#define MAX_BLOCKS 4096
static Block blocks[MAX_BLOCKS];   /* sorted by seg */
static int block_count;
static u16 heap_lo, heap_hi;
static u32 reserve_paras;           /* C31_SET_MEMORY_LIMIT */

/* heap-owned handle words: ITEMS words in their own block */
#define ITEMS 2048
static u16 item_seg;
static u8 item_used[ITEMS];

static u16 paras_for(u32 bytes)
{
    u32 paras = (bytes + 15) >> 4;
    return (u16)(paras ? paras : 1);
}

static int find_block(u16 seg)
{
    for (int i = 0; i < block_count; i++)
        if (blocks[i].seg == seg)
            return i;
    return -1;
}

/* the first gap of paras paragraphs, ignoring block skip (-1 none); 0 when there is none */
static u16 find_gap(u16 paras, int skip)
{
    u16 at = heap_lo;
    for (int i = 0; i <= block_count; i++) {
        if (i == skip)
            continue;
        u16 end = i < block_count ? blocks[i].seg : heap_hi;
        if (end >= at && (u32)(end - at) >= paras)
            return at;
        if (i < block_count && (u32)blocks[i].seg + blocks[i].paras > at)
            at = (u16)(blocks[i].seg + blocks[i].paras);
    }
    return 0;
}

static void sort_blocks(void)
{
    for (int i = 1; i < block_count; i++)
        for (int j = i; j > 0 && blocks[j - 1].seg > blocks[j].seg; j--) {
            Block t = blocks[j];
            blocks[j] = blocks[j - 1];
            blocks[j - 1] = t;
        }
}

static void out_of_memory(u32 bytes)
{
    fprintf(stderr, "bcc: out of memory (asked for %lu bytes)\n", (unsigned long)bytes);
    exit(4);
}

/* a new block of bytes for handle; its segment, written into the handle */
static u16 new_block(farptr handle, u32 bytes, u8 item)
{
    u16 paras = paras_for(bytes);
    u16 seg = find_gap(paras, -1);
    if (!seg || block_count == MAX_BLOCKS)
        out_of_memory(bytes);
    memset(mem + LIN(seg, 0), 0, (size_t)paras * 16);
    blocks[block_count++] = (Block){seg, paras, handle, HEAP_DEFAULT_OWNER_TAG, item, 0};
    sort_blocks();
    W(handle) = seg;
    return seg;
}

static void free_block(int i)
{
    if (blocks[i].item) {
        u16 n = (u16)(FP_OFF(blocks[i].handle) / 2);
        if (n < ITEMS)
            item_used[n] = 0;
    }
    W(blocks[i].handle) = 0;
    memmove(&blocks[i], &blocks[i + 1], (size_t)(block_count - i - 1) * sizeof(Block));
    block_count--;
}

u16 INIT_HEAP(u16 start, u16 limit, u16 descriptors, farptr callback, farptr swap_path)
{
    (void)descriptors;
    (void)callback;
    (void)swap_path;
    heap_lo = start;
    heap_hi = limit;
    block_count = 0;
    item_seg = 0;
    farptr handle = native_item_holder();
    item_seg = new_block(handle, ITEMS * 2, 0);
    return 0;
}

u16 FIX_HEAP_NODE_LOW(farptr handle)
{
    int i = find_block(W(handle));
    if (i >= 0)
        blocks[i].fixed = 1;
    return 0;
}

/* moves block i to the first gap that fits it (its handle follows) */
static void move_block(int i)
{
    Block *b = &blocks[i];
    u16 seg = find_gap(b->paras, i);
    if (!seg)
        out_of_memory((u32)b->paras * 16);
    memmove(mem + LIN(seg, 0), mem + LIN(b->seg, 0), (size_t)b->paras * 16);
    b->seg = seg;
    W(b->handle) = seg;
    sort_blocks();
}

u16 POOL_INIT(farptr handle, u16 bytes)
{
    new_block(handle, bytes, 0);
    return 0;
}

void RESIZE_POOL_BLOCK(farptr handle, u16 bytes)
{
    int i = find_block(W(handle));
    if (i < 0) {
        new_block(handle, bytes, 0);
        return;
    }
    u16 paras = paras_for(bytes);
    Block *b = &blocks[i];
    u16 limit = i + 1 < block_count ? blocks[i + 1].seg : heap_hi;
    if ((u32)b->seg + paras <= limit) {
        if (paras > b->paras)
            memset(mem + LIN(b->seg + b->paras, 0), 0, (size_t)(paras - b->paras) * 16);
        b->paras = paras;
        return;
    }
    if (b->fixed) {
        /* claim the space and move each block in it out of the way */
        u16 seg = b->seg, old = b->paras;
        if ((u32)seg + paras > heap_hi)
            out_of_memory(bytes);
        b->paras = paras;
        for (;;) {
            int k = find_block(seg), j = -1;
            for (int n = 0; n < block_count; n++)
                if (n != k && blocks[n].seg >= seg && blocks[n].seg < seg + paras) {
                    j = n;
                    break;
                }
            if (j < 0)
                break;
            move_block(j);
        }
        memset(mem + LIN(seg + old, 0), 0, (size_t)(paras - old) * 16);
        return;
    }
    u16 seg = find_gap(paras, i);
    if (!seg)
        out_of_memory(bytes);
    memmove(mem + LIN(seg, 0), mem + LIN(b->seg, 0), (size_t)b->paras * 16);
    memset(mem + LIN(seg + b->paras, 0), 0, (size_t)(paras - b->paras) * 16);
    b->seg = seg;
    b->paras = paras;
    W(b->handle) = seg;
    sort_blocks();
}

farptr HEAP_ALLOC_HANDLE(u16 bytes)
{
    for (u16 n = 0; n < ITEMS; n++)
        if (!item_used[n]) {
            item_used[n] = 1;
            farptr item = MK_FP(item_seg, n * 2);
            new_block(item, bytes, 1);
            return item;
        }
    out_of_memory(bytes);
    return 0;
}

u16 FREE_HANDLE_BLOCK(farptr handle)
{
    int i = find_block(W(handle));
    if (i < 0)
        return 0x1002;
    free_block(i);
    return 0;
}

void FREE_TAG_NODES(u8 owner)
{
    u8 tag = owner ? owner : HEAP_DEFAULT_OWNER_TAG;
    for (int i = 0; i < block_count;)
        if (blocks[i].tag == tag && blocks[i].seg != item_seg)
            free_block(i);
        else
            i++;
}

static u32 free_paras(void)
{
    u32 used = 0;
    for (int i = 0; i < block_count; i++)
        used += blocks[i].paras;
    return (u32)(heap_hi - heap_lo) - used;
}

i32 HEAP_SPACE_BELOW_LIMIT(void)
{
    u32 paras = free_paras();
    paras = paras > reserve_paras ? paras - reserve_paras : 0;
    return (i32)(paras << 4);
}

u32 C31_SET_MEMORY_LIMIT(u32 bytes)
{
    u32 paras = (bytes + 15) >> 4, available = free_paras();
    reserve_paras = paras < available ? paras : available;
    return reserve_paras << 4;
}

u32 C31_MEMORY_LIMIT(void)
{
    return reserve_paras << 4;
}

/* nothing to adopt: the overlay manager's resident code is not the native build's */
void ADOPT_EXTERNAL_REGIONS(u16 target, u16 source)
{
    (void)target;
    (void)source;
}

void INIT_EMS_EXT_BANKS(void) {}
void SHUTDOWN_HEAP_BANKS(void) {}
void SHRINK_MEMORY_FOR_EXEC(void) {}
void RESTORE_MEMORY_AFTER_EXEC(void) {}

/* the message image (and any other loadable image) behind an overlay stub header: on first
   use its bytes are read from the program file into a heap block whose handle is the
   header's word at 10h; the result is that segment with the header's offset */
farptr OVR_ENSURE_IMAGE_LOADED(farptr header)
{
    u16 seg = (u16)(FP_SEG(header) ^ DOS_HOST_MODE);
    farptr loaded = MK_FP(seg, 0x10);
    if (W(loaded) == 0) {
        u16 size = W(MK_FP(seg, 8));
        u16 image = new_block(loaded, (u32)size + W(MK_FP(seg, 0x0A)) + 16, 0);
        native_read_overlay(D(MK_FP(seg, 4)), mem + LIN(image, 0), size);
    }
    return MK_FP(W(loaded), FP_OFF(header));
}

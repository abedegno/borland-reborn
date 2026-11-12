/* target: CODE_2_RH0349 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: takes a free handle item from the first heap page with room,
   adding a page when needed. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: handle items.  A block allocated through HEAP_ALLOC_HANDLE
   (HPALLOCH.C) has no handle word of its own owner; instead the heap gives
   it a 4-byte item, and the item's first word becomes the block's handle
   (the node's output pointer points at it, and the node gets flag 4000h).
   Items live in pages: bank-0 blocks fixed at the low end, made by
   RH_NEWPAGE (HPNEWPG.C) and chained from ACTIVE_HEAP.page_segment through
   each page's first word.  A page header (struct HeapPage) holds the next
   page's segment, the page's own segment, the count of items in use and the
   offset of the first free item; free items are chained through their first
   word.  HEAP_ALLOC_ITEM here takes an item from the first page that has
   one (adding a page when none has), HEAP_FREE_ITEM (HPPUTITM.C) gives it
   back.  Returns a far pointer to the item, or 0.  Runs with DS = bank 0. */
#include "RHHEAP.H"
struct HeapPage {
    unsigned int next_segment,field2,count,free_offset;
};
struct HeapItem {
    unsigned int next_offset;
};
union HeapAddress {
    struct HeapPage far *page;
    struct HeapItem far *item;
    struct { unsigned int offset,segment; } words;
};
extern unsigned int near pascal RH_NEWPAGE(void);
static struct HeapItem far *near pascal HEAP_ALLOC_ITEM(void)
{
    union HeapAddress page,item;
    page.words.offset=0;
    for(page.words.segment=ACTIVE_HEAP.page_segment;page.words.segment;
        page.words.segment=page.page->next_segment) {
        if(page.page->free_offset)
            goto available;
    }
    if(!(page.words.segment=RH_NEWPAGE()))
        return 0;
available:
    ++page.page->count;
    item.words.segment=page.words.segment;
    item.words.offset=page.page->free_offset;
    page.page->free_offset=item.item->next_offset;
    item.item->next_offset=0;
    return item.item;
}

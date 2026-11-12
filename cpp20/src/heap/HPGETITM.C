/* target: HPGETITM */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPGETITM (0054:0264, image 0x7A4): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPGETITM.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: takes a free handle item from the first heap page with room,
   adding a page when needed. */
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
   back.  Returns a far pointer to the item, or 0.  Runs with DS = bank 0.
   In CPP.EXE its only caller, HEAP_ALLOC_HANDLE, is itself never called. */
#include "CPPHEAP.H"
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
/* link: HEAP_ALLOC_ITEM is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
struct HeapItem far *near pascal HEAP_ALLOC_ITEM(void)
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

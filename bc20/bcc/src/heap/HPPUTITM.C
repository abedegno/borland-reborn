/* target: CODE_2_RH03B6 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: returns a handle item to its page and frees the page when it
   empties. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: HEAP_FREE_ITEM gives a handle item back to its page (see
   HPGETITM.C for items and pages).  The page is the item's segment.  When
   its count of items in use drops to 0 the page is taken out of the page
   chain and its block released (its segment is resolved to its node, with
   DS = the program's, and RH_RELEASE_DESCRIPTOR frees it); otherwise the
   item is pushed on the page's free-item list.  Called when a block with
   flag 4000h is freed (FREE_HANDLE_BLOCK, CHANGE_HEAP_NODE_MODE,
   FREE_TAG_NODES, RH_TRY_FLAG40) and by HEAP_ALLOC_HANDLE on failure.  It
   switches DS to bank 0 itself and restores the caller's DS. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
struct HeapPage { unsigned int next_segment,field2,count,free_offset; };
struct HeapItem { unsigned int next_offset; };
union HeapAddress {
    struct HeapPage far *page;
    struct HeapItem far *item;
    struct { unsigned int offset,segment; } words;
};
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,unsigned int far *offset);
extern unsigned int near pascal RH_RELEASE_DESCRIPTOR(HeapNode near *node);
static void near pascal HEAP_FREE_ITEM(struct HeapItem far *item)
{
    union HeapAddress page;
    unsigned int descriptor;
    union HeapAddress previous;
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm mov ds,word ptr HEAP_DESCRIPTOR_SEGMENTS;
    page.words.segment=FP_SEG(item);
    page.words.offset=0;
    if((page.page->count=page.page->count-1)==0) {
        if(page.words.segment==ACTIVE_HEAP.page_segment)
            ACTIVE_HEAP.page_segment=page.page->next_segment;
        else {
            previous.words.segment=ACTIVE_HEAP.page_segment;
            previous.words.offset=0;
            while(previous.page->next_segment!=page.words.segment)
                previous.words.segment=previous.page->next_segment;
            previous.page->next_segment=page.page->next_segment;
        }
        asm push ds;
        asm mov ds,word ptr ACTIVE_HEAP.program_segment;
        BCC_POOL_RESOLVE_WORD(page.words.segment,&descriptor);
        asm pop ds;
        RH_RELEASE_DESCRIPTOR((HeapNode near *)descriptor);
    } else {
        item->next_offset=page.page->free_offset;
        page.page->free_offset=FP_OFF(item);
    }
    asm pop ds;
}

/* target: CODE_2_RG2A2 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: RH_NEWPAGE allocates a heap node of the active heap's page size.
   Entry points: RH_NEWPAGE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: makes a new page of handle items (see HPGETITM.C for items and
   pages) and puts it at the front of the page chain
   (ACTIVE_HEAP.page_segment).  The page is a bank-0 block fixed at the low
   end and locked (8008h), so items never move and a far pointer to an item
   stays valid.  The page's own segment word (+2) is its handle word, so the
   heap's segment updates land in the page itself.  Called by INIT_MAIN_HEAP
   for the first page and by HEAP_ALLOC_ITEM when all pages are full. */
/* CODE_2:02B1..0349, RH_NEWPAGE: allocate a heap node of ACTIVE_HEAP.page_size
   bytes and format it as a page of 4-byte items (HEAP_ALLOC_ITEM hands them out).
   The page header gets the node's segment at +2, and the node's output
   pointer is aimed there.  The items are 4 bytes from +0Ah; each item's
   first word links to the next item, and the last link is 0.  Returns the
   page segment, or 0.

   Compiled through TASM (-B): "jmp short; nop" at 02C8.  The item loop is
   inline asm (stosw with lea), not BCC output.
   Documented exception (pseudo-register read): return _ES at 033E, the page
   segment the asm loop leaves in ES. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHOUT.H"
struct HeapPage { unsigned int next_segment,self_segment,count,free_offset; };
union HeapAddress {
    struct HeapPage far *page;
    struct { unsigned int offset,segment; } words;
};
extern HeapNode near * near pascal ALLOC_FIXED_LOW(unsigned int request);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);

unsigned int near pascal RH_NEWPAGE(void)
{
    HeapNode near *node;
    union HeapAddress page;
    node=ALLOC_FIXED_LOW(ACTIVE_HEAP.page_size);
    if(node) {
        node->flags|=0x8008;
        page.words.segment=node->key;
        node->field12=0;
        page.words.offset=0;
        page.page->self_segment=page.words.segment;
        ((struct HeapOutputNodeView near *)node)->output=&page.page->self_segment;
        RH_UPDATE_NODE_ADDRESS(node,0);
        page.page->count=0;
        page.page->next_segment=ACTIVE_HEAP.page_segment;
        ACTIVE_HEAP.page_segment=page.words.segment;
        page.page->free_offset=10;
        /* Chain the items, 4 bytes each from offset 0Ah.  Each round stores
           a 0 (the word at 8 the first time, then the previous item's second
           word) and then, as the first word of the item at DI, the offset of
           the next item (lea ax,[di+4]).  The loop stops at page_size and the
           last link is set to 0. */
        asm push di;
        asm les di,page;
        asm mov dx,word ptr DGROUP:ACTIVE_HEAP.page_size;
        asm add di,8;
        asm cld;
    link:
        asm xor ax,ax;
        asm stosw;
        asm lea ax,[di+4];
        asm stosw;
        asm cmp di,dx;
        asm jb link;
        asm mov word ptr es:[di-2],0;
        asm pop di;
        return _ES;
    }
    return 0;
}

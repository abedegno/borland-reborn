/* target: CODE_2_RH1C4F */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: frees a handle's block (FREE_HANDLE_BLOCK). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: far entry that frees the block behind a handle word: the handle
   item is given back (flag 4000h) or the word cleared, and the node released
   through its bank's release hook (hook_24, seen here through the
   HEAP_ENTRY_BANK view).  Returns 0, or 1002h for a bad handle, which also
   goes to the status hook.  Callers free whole pools this way (OOMHAND.C,
   CONFIG.C, RFILEIO.C). */
/* Unbuilt complete proposal for resident0094:1C4F..1CBF (112 bytes).
   Hook declaration is the limited physical CALLER protocol view, not a
   compatible ordinary-returning declaration of the installed CDECL body. */
#include <dos.h>
#include "RHENTRY.H"
#include "RHHOOK.H"
#include "DATA.H"
extern unsigned int HEAP_STATUS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *node_offset);
struct HeapItem;
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);

static unsigned int far pascal _loadds FREE_HANDLE_BLOCK(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank=(int)BCC_POOL_RESOLVE_WORD(*handle,
                                     (unsigned int far *)&node_offset);
    if(bank<6) {
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        if(((HeapNode near *)node_offset)->flags&0x4000)
            HEAP_FREE_ITEM((struct HeapItem far *)handle);
        else
            *handle=0;
        HEAP_ENTRY_BANK->release24((HeapNode near *)node_offset);
        return 0;
    } else {
        HEAP_STATUS=0x1002;
        HEAP_HOOK_CALLSITE(1,0x1002);
        return 0x1002;
    }
}

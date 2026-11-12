/* target: HPFREEHB */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPFREEHB (0054:132F, image 0x186F): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPFREEHB.C), with the CPP.EXE edits
   marked; compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: frees a handle's block (FREE_HANDLE_BLOCK). */
/* Overview: far entry that frees the block behind a handle word: the handle
   item is given back (flag 4000h) or the word cleared, and the node released
   through its bank's release hook (hook_24, seen here through the
   HEAP_ENTRY_BANK view).  Returns 0, or 1002h for a bad handle, which also
   goes to the status hook.  Callers free whole pools this way (OOMHAND.C,
   CONFIG.C, RFILEIO.C, and the jump stub at the end of OVREXMEM.ASM). */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int HEAP_STATUS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *node_offset);
struct HeapItem;
extern void near pascal HEAP_FREE_ITEM(struct HeapItem far *item);

/* link: FREE_HANDLE_BLOCK is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int huge pascal FREE_HANDLE_BLOCK(unsigned int far *handle)
{
    unsigned int node_offset;
    int bank=(int)BCC_POOL_RESOLVE_WORD(*handle,
                                     (unsigned int far *)&node_offset);
    if(bank<5) {    /* CPP.EXE edit: 5 banks (BCC: 6) */
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        if(((HeapNode near *)node_offset)->flags&0x4000)
            HEAP_FREE_ITEM((struct HeapItem far *)handle);
        else
            *handle=0;
        HEAP_ENTRY_BANK->release24((HeapNode near *)node_offset);
        return 0;
    } else {
        HEAP_STATUS=0x1002;
        /* CPP.EXE edit: the hook is called with no arguments (call dword
           ptr only); BCC pushes 1 and 1002h. */
        ((void (far *)(void))HEAP_HOOK_CALLSITE)();
        return 0x1002;
    }
}

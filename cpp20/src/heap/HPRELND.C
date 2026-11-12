/* target: HPRELND */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* HEAP2 agent: -r- dropped (CPP keeps node in SI: push si; mov si,[bp+4] at
   image 0xBB1). */
/* CPP.EXE module HPRELND (0054:066B, image 0xBAB): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPRELND.C); compiled by Turbo C 2.01
   (see CPPHEAP.H), with the CPP.EXE edits marked. */
/* Role: far-memory heap: RH_RELEASE_DESCRIPTOR frees a node: unfixes it and returns it
   to the free list. */
/* Overview: RH_RELEASE_DESCRIPTOR frees a used block in the active bank; it
   is every bank's default release hook (hook_24) and is called directly for
   handle pages.  Despite the name it frees the block, not just the
   descriptor.  It releases a fixed-low or fixed-high fix, then puts the
   space on the free list and merges it when it lies in the movable area, or
   merges it outside the list when it lies in a fixed region.  Returns 0.
   (BCC.EXE's version first also updates the tracked totals, releases a
   copy kept in another bank and clears the node's ring slot; see the edit
   below.) */
#include "CPPHEAP.H"
extern unsigned int near pascal RH_RELEASE_SPECIAL(HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);
/* CPP.EXE edit: CPP's function (image 0xBAB) has none of BCC's tracked-node
   accounting (field5&4), bank-copy release (flag 2000h) or tag-ring clear
   (flag 1000h); it starts with the flag 18h test.  CPP's ACTIVE_HEAP has no
   such fields (CPPHEAP.H).  node is a register variable (SI) and result
   stays on the stack: Turbo C 2.01 would put result in DI by itself;
   volatile is a stand-in for whatever kept it out of a register (as in
   HPFIXLO.C and HPEXTEND.C). */
/* link: RH_RELEASE_DESCRIPTOR is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int near pascal RH_RELEASE_DESCRIPTOR(register HeapNode near *node)
{
    volatile unsigned int result=1;
    if(node->flags&0x18)
        result=RH_RELEASE_SPECIAL(node);
    if(result && node->key>=ACTIVE_HEAP.head->key && node->key<ACTIVE_HEAP.end->key) {
        ADD_FREE_NODE(node);
        RH_COALESCE_FREE(node);
    } else
        RH_MARK_FREE_AND_MERGE(node);
    return 0;
}

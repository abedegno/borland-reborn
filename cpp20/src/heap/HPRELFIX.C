/* target: HPRELFIX */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPRELFIX (0054:064E, image 0xB8E): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPRELFIX.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: RH_RELEASE_SPECIAL releases a fixed node through UNFIX_LOW_NODE or
   UNFIX_HIGH_NODE. */
/* Overview: used by RH_RELEASE_DESCRIPTOR when the node being freed is fixed
   (flag 8 or 10h): releases the fix at the right end.  Returns 1 when the
   node was the innermost block of its fixed region, so the region shrank and
   the node is now inside the movable area, else 0 (it stays a hole in the
   fixed region). */
#include "CPPHEAP.H"
extern unsigned int near pascal UNFIX_LOW_NODE(HeapNode near *node);
extern unsigned int near pascal UNFIX_HIGH_NODE(HeapNode near *node);
/* link: RH_RELEASE_SPECIAL is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int near pascal RH_RELEASE_SPECIAL(HeapNode near *node)
{
    if(node->flags&8)
        return UNFIX_LOW_NODE(node);
    else
        return UNFIX_HIGH_NODE(node);
}

/* target: CODE_2_RH0826 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RH_RELEASE_SPECIAL releases a fixed node through UNFIX_LOW_NODE or
   UNFIX_HIGH_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: used by RH_RELEASE_DESCRIPTOR when the node being freed is fixed
   (flag 8 or 10h): releases the fix at the right end.  Returns 1 when the
   node was the innermost block of its fixed region, so the region shrank and
   the node is now inside the movable area, else 0 (it stays a hole in the
   fixed region). */
#include "RHHEAP.H"
extern unsigned int near pascal UNFIX_LOW_NODE(HeapNode near *node);
extern unsigned int near pascal UNFIX_HIGH_NODE(HeapNode near *node);
static unsigned int near pascal RH_RELEASE_SPECIAL(HeapNode near *node)
{
    if(node->flags&8)
        return UNFIX_LOW_NODE(node);
    else
        return UNFIX_HIGH_NODE(node);
}

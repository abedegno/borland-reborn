/* target: CODE_2_RH1441 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RESIZE_HANDLE_BLOCK changes the size of the block behind a handle.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: shrinks the block behind a handle word to request bytes
   (SHRINK_NODE) when that changes its size in units, and moves field52 (the
   total of 400h nodes, probably overlay code) by the difference; the
   unsigned difference is negative when shrinking.  SHRINK_NODE assumes the
   new size is smaller, so callers probably only shrink.  Keeps the caller's
   DS. */
/* Complete zero-build hardware-domain bridge proposal, original0094:1441..148F.
   True NEAR RET6: FAR input handle pointer plus WORD request, not a FAR entry. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,
    unsigned int far *offset);
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern void near pascal SHRINK_NODE(HeapNode near *node,unsigned int request);

static void near pascal RESIZE_HANDLE_BLOCK(unsigned int far *handle,unsigned int request)
{
    unsigned int node_offset;
    unsigned int difference;
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[
        BCC_POOL_RESOLVE_WORD(*handle,(unsigned int far *)&node_offset)];
    difference=RH_ROUND_REQUEST(request)-
        ((HeapNode near *)node_offset)->size;
    if(difference) {
        SHRINK_NODE((HeapNode near *)node_offset,request);
        ACTIVE_HEAP.field52+=difference;
    }
    asm pop ds;
}

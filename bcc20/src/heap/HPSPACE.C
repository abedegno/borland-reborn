/* target: CODE_2_R36F7 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: HEAP_SPACE_BELOW_LIMIT returns the heap space still available
   below the limit. Entry points: HEAP_SPACE_BELOW_LIMIT. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: far entry for the compiler: how many bytes of bank 0 are free or
   could be freed by moving out or discarding reclaimable (tracked) blocks,
   less the 400h reserve field54. */
/* CODE_2:2DB7..2DDE, HEAP_SPACE_BELOW_LIMIT: the heap space still available below
   the memory limit, in bytes: (free_size + tracked_size - field54) * 16
   as a long.  The paragraphs-to-bytes conversion is inline asm (rol by 4,
   then split into DX:AX), not BCC's long-shift helper, so the value is left
   in DX:AX by asm: a documented exception (fall-off-end).  DS is bank 0
   (HEAP_DESCRIPTOR_SEGMENTS[0]) there, so the DGROUP: overrides only give
   the field offsets.  Callers declare it long (FLOWBLK, SYMSCANC). */
#include "RHHEAP.H"
#include "DATA.H"

long far pascal _loadds HEAP_SPACE_BELOW_LIMIT(void)
{
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    asm mov ax,word ptr DGROUP:ACTIVE_HEAP.free_size;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.tracked_size;
    asm sub ax,word ptr DGROUP:ACTIVE_HEAP.field54;
    asm mov cl,4;
    asm rol ax,cl;
    asm mov dx,ax;
    asm and ax,0FFF0h;
    asm and dx,0Fh;
}

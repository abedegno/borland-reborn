/* target: CODE_2_RH0D8E */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RH_AVAILABLE_SPACE returns the free space in the active heap,
   probably less a reserve kept for overlay code nodes. Entry points: RH_AVAILABLE_SPACE.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RH_AVAILABLE_SPACE returns the free space of the active bank in
   units, as the allocators and RECLAIM_FOR_SPACE judge it.  field52 is the
   total size of nodes flagged 400h (probably overlay code) and field54 the
   reserve kept for them (C31_SET_MEMORY_LIMIT).  While they use less than the
   reserve, the shortfall is held back from other allocations and field5 &
   40h is set; an allocation for a 400h node (field5 & 1, set by
   ALLOC_BANK0_NODE) may use it all. */
#include "RHHEAP.H"
unsigned int near pascal RH_AVAILABLE_SPACE(void)
{
    int difference=ACTIVE_HEAP.field52-ACTIVE_HEAP.field54;
    if(difference<0) {
        ACTIVE_HEAP.field5=ACTIVE_HEAP.field5|0x40;
        if((unsigned char)(ACTIVE_HEAP.field5&1))
            return ACTIVE_HEAP.free_size;
        else
            return ACTIVE_HEAP.free_size+difference;
    } else
        ACTIVE_HEAP.field5=ACTIVE_HEAP.field5&~0x40;
    return ACTIVE_HEAP.free_size;
}

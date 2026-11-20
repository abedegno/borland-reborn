/* target: CODE_5_R5CLEAN */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: INIT_EMS_EXT_BANKS sets up the EMS and extended-memory banks when
   their limits allow. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: called once from main (RMAIN13C.C) after the main heap is up, to
   add the optional heap banks for blocks moved out of conventional memory
   (see HEAPMAIN.C's overview for banks): bank 3 in EMS when EMS_PAGE_LIMIT
   is not negative (pages from 0, as many as that limit; 0 means all), and
   bank 4 in extended memory when EXT_MEMORY_BASE is not negative.  Note
   that INIT_EXT_BANK takes (base, size), so EXT_MEMORY_BASE is passed as
   the bank's base address and EXT_MEMORY_BANK_SIZE as its size (0 means up
   to the end of what the overlay manager allows). */
#include "DATA.H"
#include "HEAP.H"
static void far pascal INIT_EMS_EXT_BANKS(void)
{
    if(EMS_PAGE_LIMIT>=0) INIT_EMS_BANK(0,0,EMS_PAGE_LIMIT);
    if(EXT_MEMORY_BASE>=0L) INIT_EXT_BANK(EXT_MEMORY_BASE,EXT_MEMORY_BANK_SIZE);
}

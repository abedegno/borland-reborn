/* target: CODE_2_RH2D67 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: at exit releases the swap, EMS and extended-memory banks and shuts
   the overlay manager down. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry called before BCC exits (at the end of main in
   RMAIN13C.C, and on the error exits of RDRV388.C and DRVLINK.C): closes and
   deletes the swap files (banks 1 and 2), frees the EMS pages (bank 3) and
   extended memory (bank 4) of the banks that were set up, then shuts the
   overlay manager down. */
/* Complete reconstruction of original0094:2D67..2DA8/full65.
   Declarations describe only these actual ignored-result call sites. */
#include "DATA.H"
extern void near pascal DISCARD_SWAP_BANK(unsigned int bank);
extern void near pascal RELEASE_EMS_BANK(void);
extern void near pascal RH_CALL_EXT_RELEASE(void);
extern void far pascal OVR_SHUTDOWN(void);

static void far pascal _loadds SHUTDOWN_HEAP_BANKS(void)
{
    if(HEAP_DESCRIPTOR_SEGMENTS[1])
        DISCARD_SWAP_BANK(1);
    if(HEAP_DESCRIPTOR_SEGMENTS[2])
        DISCARD_SWAP_BANK(2);
    if(HEAP_DESCRIPTOR_SEGMENTS[3])
        RELEASE_EMS_BANK();
    if(HEAP_DESCRIPTOR_SEGMENTS[4])
        RH_CALL_EXT_RELEASE();
    OVR_SHUTDOWN();
}

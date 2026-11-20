/* target: H_HPSHUTDN */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* Role: far-memory heap: at exit releases the swap, EMS and extended-memory banks and shuts
   the overlay manager down. */
/* Overview: far entry called before BCC exits (at the end of main in
   RMAIN13C.C, and on the error exits of RDRV388.C and DRVLINK.C): closes and
   deletes the swap files (banks 1 and 2), frees the EMS pages (bank 3) and
   extended memory (bank 4) of the banks that were set up, then shuts the
   overlay manager down. */
/* Complete reconstruction of original0094:2D67..2DA8/full65.
   Declarations describe only these actual ignored-result call sites. */
#include "DATA.H"
extern void near pascal RELEASE_EMS_BANK(void);
extern void near pascal RH_CALL_EXT_RELEASE(void);

void far pascal _loadds SHUTDOWN_HEAP_BANKS(void)
{
    if(HEAP_DESCRIPTOR_SEGMENTS[2])
        RELEASE_EMS_BANK();
    if(HEAP_DESCRIPTOR_SEGMENTS[3])
        RH_CALL_EXT_RELEASE();
}

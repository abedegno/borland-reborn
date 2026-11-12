/* target: HPSHUTDN */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPSHUTDN (0054:1B61, image 0x20A1): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPSHUTDN.C); with the CPP.EXE edits
   marked "CPP.EXE edit". */
/* Role: far-memory heap: at exit releases the EMS and extended-memory banks. */
/* Overview: far entry called before CPP exits (CPPMAIN.C, and the error
   exits in CONFIG.C and DRVLINK.C): frees the EMS pages (bank 2) and the
   extended memory (bank 3) of the banks that were set up.  BCC.EXE's version
   also closes and deletes its swap files and shuts the overlay manager
   down.  The results of both calls are ignored. */
#include "DATA.H"
extern void near pascal RELEASE_EMS_BANK(void);
extern void near pascal RH_CALL_EXT_RELEASE(void);

/* CPP.EXE edit (image 0x20A1): CPP has no swap-file banks and no overlay
   manager, so there is no DISCARD_SWAP_BANK and no OVR_SHUTDOWN; EMS is
   bank 2 (HEAP_DESCRIPTOR_SEGMENTS[2], DS:037Ch) and extended memory bank 3
   (DS:037Eh), as in CPP's EMSINIT.C and EXTINIT.C. */
/* link: SHUTDOWN_HEAP_BANKS is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void far pascal _loadds SHUTDOWN_HEAP_BANKS(void)
{
    if(HEAP_DESCRIPTOR_SEGMENTS[2])
        RELEASE_EMS_BANK();
    if(HEAP_DESCRIPTOR_SEGMENTS[3])
        RH_CALL_EXT_RELEASE();
}

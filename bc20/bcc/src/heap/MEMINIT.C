/* target: CODE_5_C5INIT */
/* opts: -mm -G- -O -Z -p */
/* Role: far-memory heap: start-up memory initialisation; sets up the main heap with the
   out-of-memory handler, probably adopts the start-up code region as heap space. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: INIT_MEMORY_MANAGER runs once at start-up and brings up BCC's
   far heap (see src/heap/HEAPMAIN.C's overview).  The heap gets the
   paragraphs from HEAP_START_SEG up to HEAP_START_SEG + HEAP_SIZE_PARAS, or up
   to EXTENDER_HEAP_TOP when DOS_HOST_MODE is 8 (probably running under a DOS
   extender); handle-item pages of FEh bytes (rounded down to FCh);
   OUT_OF_MEMORY_HANDLER as the status hook; and no swap file.  If that
   fails BCC reports "Out of memory" and exits.  Then the regions from
   INIT_REGION_START_MARK to
   INIT_END_C_START_MARK are adopted into the heap, the default owner tag is
   set to 42h (SET_DEFAULT_OWNER_TAG stores HEAP_DEFAULT_OWNER_TAG), and the malloc pool
   (MALLOC_POOL_SEG, a POOLS.C pool) gets an empty block that is fixed at the
   low end of the heap. */
#include <dos.h>
#include "DATA.H"
#include "HEAP.H"
#include "MSG.H"
typedef void (far cdecl *ErrorCallback)();
extern int far pascal INIT_HEAP(unsigned int,unsigned int,unsigned int,ErrorCallback,char far *);
extern void far cdecl OUT_OF_MEMORY_HANDLER();
/* Address-only references to original far export stubs. */
extern void far pascal INIT_REGION_START_MARK(void),INIT_END_C_START_MARK(void);
extern void far cdecl REPORT_ERROR(int,...);
extern void far pascal EXIT(int);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern unsigned int far pascal FIX_HEAP_NODE_LOW(unsigned int far *);
static void far pascal INIT_MEMORY_MANAGER(void)
{
    register unsigned int limit;
    if(DOS_HOST_MODE==8) limit=EXTENDER_HEAP_TOP;
    else limit=HEAP_START_SEG+HEAP_SIZE_PARAS;
    if(INIT_HEAP(HEAP_START_SEG,limit,0xFE,OUT_OF_MEMORY_HANDLER,(char far *)0)) {
        REPORT_ERROR(MSG_OUT_MEMORY);
        EXIT(1);
    }
    ADOPT_EXTERNAL_REGIONS(FP_SEG(INIT_REGION_START_MARK),FP_SEG(INIT_END_C_START_MARK));
    SET_DEFAULT_OWNER_TAG(0x42);
    POOL_INIT(&MALLOC_POOL_SEG,0);
    FIX_HEAP_NODE_LOW(&MALLOC_POOL_SEG);
}

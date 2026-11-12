/* target: MEMINIT */
/* opts: -mm -G- -O -Z -p -B -zCCODE5 */
/* link: -zCCODE5 gives this file the code segment it shares with the other files of frame 0485h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module MEMINIT (0485:0000..0485:0081, image 0x4850..0x48D1): source taken
   from the BCC.EXE reconstruction (bcc20/src/heap/MEMINIT.C), with
   CPP.EXE's edits marked "CPP.EXE edit", and the bank set-up of BANKINIT.C after it
   (image 0x48B8), reduced to the EMS bank. */
/* Role: far-memory heap: start-up memory initialisation; sets up the main heap with the
   out-of-memory handler, and the malloc pool. */
/* Overview: INIT_MEMORY_MANAGER runs once at start-up (CPPMAIN.C calls it)
   and brings up CPP's far heap (see src/heap/HEAPMAIN.C's overview).  The
   heap gets the paragraphs from HEAP_START_SEG up to HEAP_START_SEG +
   HEAP_SIZE_PARAS; handle-item pages of FEh bytes (rounded down to FCh);
   OUT_OF_MEMORY_HANDLER as the status hook; and no swap file.  If that
   fails CPP reports "Out of memory" and exits.  Then the default owner tag
   is set to 42h (SET_DEFAULT_OWNER_TAG stores HEAP_DEFAULT_OWNER_TAG), and
   the malloc pool (MALLOC_POOL_SEG, a POOLS.C pool) gets an empty block that
   is fixed at the low end of the heap.  (BCC.EXE's version also handles a
   DOS extender and adopts its start-up regions into the heap;
   INIT_REGION_START_MARK and INIT_END_C_START_MARK below are declared but
   not used here.) */
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
extern void far cdecl exit(int);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern unsigned int far pascal FIX_HEAP_NODE_LOW(unsigned int far *);
/* link: INIT_MEMORY_MANAGER is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void far pascal INIT_MEMORY_MANAGER(void)
{
    /* CPP.EXE edit: no DOS-extender case and no adopted start-up regions
       (image 4850..4885); limit is on the stack (dec sp; dec sp at 4853), not
       a register variable; CPP's start-up has a cdecl exit (0000:00B1). */
    unsigned int limit;
    limit=HEAP_START_SEG+HEAP_SIZE_PARAS;
    if(INIT_HEAP(HEAP_START_SEG,limit,0xFE,OUT_OF_MEMORY_HANDLER,(char far *)0)) {
        REPORT_ERROR(MSG_OUT_MEMORY);
        exit(1);
    }
    SET_DEFAULT_OWNER_TAG(0x42);
    POOL_INIT(&MALLOC_POOL_SEG,0);
    FIX_HEAP_NODE_LOW(&MALLOC_POOL_SEG);
}

/* ---- from heap/BANKINIT.C ---- */
extern long far pascal _loadds INIT_EMS_BANK(unsigned int handle,unsigned int first,
    unsigned int pages);
/* Set up the EMS bank when EMS_PAGE_LIMIT allows it (not negative).  It is
   static and nothing in this file calls it, so it is never called in
   CPP.EXE.
   CPP.EXE edit: no extended-memory bank set-up after it (image 48B8..48D1). */
static void far pascal INIT_EMS_EXT_BANKS(void)
{
    if(EMS_PAGE_LIMIT>=0) INIT_EMS_BANK(0,0,EMS_PAGE_LIMIT);
}

/* meminit.c: from bcc20/src/heap/MEMINIT.C: INIT_MEMORY_MANAGER starts the far heap at
   start-up: bank 0 from HEAP_START_SEG for HEAP_SIZE_PARAS paragraphs (up to
   EXTENDER_HEAP_TOP under the DOS extender, DOS_HOST_MODE 8), with OUT_OF_MEMORY_HANDLER as
   its error callback; failure is "Out of memory" and exit 1.  Then the program image
   between the start-up code's region marks is handed to the heap (ADOPT_EXTERNAL_REGIONS,
   the overlay manager's resident code), and the malloc pool is created empty under owner
   tag 42h and fixed at the low end of the heap. */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

/* the region marks are one-byte placeholder overlays; FP_SEG of each is its stub segment
   (load-relative paragraphs, see options.c) */
#define STUB_SEG(para) ((u16)((para) + (DGROUP - DGROUP_PARA)))

void INIT_MEMORY_MANAGER(void)
{
    u16 limit = DOS_HOST_MODE == 8 ? EXTENDER_HEAP_TOP : (u16)(HEAP_START_SEG + HEAP_SIZE_PARAS);
    if (INIT_HEAP(HEAP_START_SEG, limit, 0xFE, code_address("OUT_OF_MEMORY_HANDLER"), 0)) {
        REPORT_ERROR(MSG_OUT_MEMORY);
        EXIT(1);
    }
    ADOPT_EXTERNAL_REGIONS(STUB_SEG(0x0CE3), STUB_SEG(0x0CEA));     /* INIT_REGION_START_MARK, INIT_END_C_START_MARK */
    SET_DEFAULT_OWNER_TAG(0x42);
    POOL_INIT(MALLOC_POOL_SEG_P, 0);
    FIX_HEAP_NODE_LOW(MALLOC_POOL_SEG_P);
}

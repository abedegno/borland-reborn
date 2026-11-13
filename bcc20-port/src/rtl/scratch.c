/* scratch.c: the port's scratch area for address-taken locals (port.h), and the lookup of
   BCC code addresses. Port material, no original. */
#include "port.h"
#include "data.h"

static u16 scratch_top;

farptr scratch_alloc(u16 bytes)
{
    farptr p = MK_FP(SCRATCH_SEG, scratch_top);
    scratch_top += (bytes + 1) & ~1u;
    return p;
}

u16 scratch_mark(void) { return scratch_top; }

void scratch_release(u16 mark) { scratch_top = mark; }

/* generated with the adapters (tools/genadapters.py): BCC's functions by code address,
   segment relative to the load segment */
typedef struct {
    u16 seg, off;
    void *function;
} CodeName;
extern const CodeName CODE_NAMES[];

void *code_function(farptr code)
{
    u16 seg = FP_SEG(code) - (DGROUP - DGROUP_PARA), off = FP_OFF(code);
    for (const CodeName *c = CODE_NAMES; c->function; c++)
        if (c->seg == seg && c->off == off)
            return c->function;
    return 0;
}

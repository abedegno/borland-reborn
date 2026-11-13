/* scratch.c: the port's scratch area for address-taken locals (port.h), and the lookup of
   BCC code addresses. Port material, no original. */
#include "port.h"
#include "data.h"
#include <string.h>

static u16 scratch_top;

farptr scratch_alloc(u16 bytes)
{
    farptr p = MK_FP(SCRATCH_SEG, scratch_top);
    scratch_top += (bytes + 1) & ~1u;
    return p;
}

u16 scratch_mark(void) { return scratch_top; }

void scratch_release(u16 mark) { scratch_top = mark; }

/* a code address that names no function the port knows: replay fails the call, the native
   build stops */
extern void code_unknown(farptr code);

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
    code_unknown(code);
    return 0;
}

/* near code pointers: a handler table holds the offset of each function in its code segment;
   module is the original source's stem (PREPROC for src/preproc/PREPROC.C) */
typedef struct {
    const char *module;
    u32 base;
} ModuleBase;
typedef struct {
    u32 at;
    void *function;
} CodeAt;
extern const ModuleBase MODULE_BASES[];
extern const CodeAt CODE_AT[];

void *near_function(const char *module, u16 off)
{
    for (const ModuleBase *m = MODULE_BASES; m->module; m++)
        if (!strcmp(m->module, module))
            for (const CodeAt *c = CODE_AT; c->function; c++)
                if (c->at == m->base + off)
                    return c->function;
    code_unknown(MK_FP(0, off));
    return 0;
}

/* runtime.c: port material, no original: the scratch area for address-taken locals
   (port.h), and calls through BCC's code pointers (calls.h). */
#include <string.h>
#include "port.h"
#include "variadic.h"
#include "data.h"
#include "calls.h"

/* ---- the scratch area: grows up from SCRATCH_SEG:0 ---- */
static u16 scratch_top;

farptr scratch_alloc(u16 bytes)
{
    farptr p = MK_FP(SCRATCH_SEG, scratch_top);
    scratch_top += (bytes + 1) & ~1u;
    return p;
}

u16 scratch_mark(void) { return scratch_top; }

/* ---- the near scratch area (port.h): grows down from near_scratch_top in DGROUP ---- */
u16 near_scratch_top = 0xFFF0;

farptr near_scratch_alloc(u16 bytes)
{
    near_scratch_top -= (bytes + 1) & ~1u;
    return DSPTR(near_scratch_top);
}

u16 near_scratch_mark(void) { return near_scratch_top; }
void near_scratch_release(u16 mark) { near_scratch_top = mark; }

/* scratch bytes the original leaves unset (port.h): offset ranges [lo, hi) */
static u16 unset_lo[16], unset_hi[16];
static unsigned n_unset;

void scratch_release(u16 mark)
{
    scratch_top = mark;
    while (n_unset && unset_lo[n_unset - 1] >= mark)
        n_unset--;
}

void UNSET_BYTES(farptr p, u16 n)
{
    if (FP_SEG(p) == SCRATCH_SEG && n_unset < 16) {
        unset_lo[n_unset] = FP_OFF(p);
        unset_hi[n_unset++] = FP_OFF(p) + n;
    }
}

int scratch_unset(u16 offset)
{
    for (unsigned i = 0; i < n_unset; i++)
        if (offset >= unset_lo[i] && offset < unset_hi[i])
            return 1;
    return 0;
}

/* memory left holding an unset value (port.h): linear ranges [lo, hi) */
static u32 result_lo[32], result_hi[32];
static unsigned n_results;

void UNSET_RESULT(farptr p, u16 n)
{
    if (n_results < 32) {
        result_lo[n_results] = LIN(FP_SEG(p), FP_OFF(p));
        result_hi[n_results++] = LIN(FP_SEG(p), FP_OFF(p)) + n;
    }
}

int result_unset(u32 linear)
{
    for (unsigned i = 0; i < n_results; i++)
        if (linear >= result_lo[i] && linear < result_hi[i])
            return 1;
    return 0;
}

void unset_results_clear(void) { n_results = 0; }

/* ---- arguments the original leaves unset (port.h) ---- */
u32 unset_args;
u16 unset_returns;
const char *unset_returns_owner;

/* UNSET_PASS (port.h): the marks before the call, put back when the call made none */
static struct { u16 mask; const char *owner; } unset_saved[64];
static unsigned n_unset_saved;

void unset_push(void)
{
    if (n_unset_saved < 64) {
        unset_saved[n_unset_saved].mask = unset_returns;
        unset_saved[n_unset_saved].owner = unset_returns_owner;
    }
    n_unset_saved++;
    unset_returns = 0;
    unset_returns_owner = 0;
}

u32 unset_pass(u32 value, const char *owner)
{
    n_unset_saved--;
    if (unset_returns)
        unset_returns_owner = owner;
    else if (n_unset_saved < 64) {
        unset_returns = unset_saved[n_unset_saved].mask;
        unset_returns_owner = unset_saved[n_unset_saved].owner;
    }
    return value;
}

/* ---- calls through code pointers ---- */

/* a code address that names no function the port knows: replay fails the call, the native
   build stops */
extern void code_unknown(farptr code);

/* generated with the adapters (tools/genadapters.py): the functions by code address
   (segment from the load segment), by module code segment and file offset */
typedef struct {
    u16 seg, off, function;
} CodeName;
typedef struct {
    const char *module;
    u32 base;
} ModuleBase;
typedef struct {
    u32 at;
    u16 function;
} CodeAt;
extern const CodeName CODE_NAMES[];
extern const ModuleBase MODULE_BASES[];
extern const CodeAt CODE_AT[];

static const Function *far_entry(farptr code)
{
    u16 seg = FP_SEG(code) - (DGROUP - DGROUP_PARA), off = FP_OFF(code);
    for (const CodeName *c = CODE_NAMES; c->function != 0xFFFF; c++)
        if (c->seg == seg && c->off == off)
            return &ALL_FUNCTIONS[c->function];
    code_unknown(code);
    return 0;
}

static const Function *near_entry(const char *module, u16 off)
{
    for (const ModuleBase *m = MODULE_BASES; m->module; m++)
        if (!strcmp(m->module, module))
            for (const CodeAt *c = CODE_AT; c->function != 0xFFFF; c++)
                if (c->at == m->base + off)
                    return &ALL_FUNCTIONS[c->function];
    code_unknown(MK_FP(0, off));
    return 0;
}

/* the stack the arguments are pushed on: the top of the scratch segment, growing down */
static u16 call_sp = 0xFFF0;

static u32 call_entry(const Function *f, const FarArg *args, unsigned n)
{
    unsigned bytes = f->ret;
    for (unsigned i = 0; i < n; i++)
        bytes += args[i].size;
    u16 sp = call_sp - (u16)bytes, saved = call_sp;
    call_sp = sp;
    for (unsigned i = 0; i < f->ret; i++)
        B(MK_FP(SCRATCH_SEG, sp + i)) = 0;             /* the return address: unused */
    /* pascal pushes left to right, so the last argument is lowest; cdecl the other way */
    u16 pos = sp + (u16)f->ret;
    for (unsigned k = 0; k < n; k++) {
        const FarArg *a = &args[f->args ? k : n - 1 - k];
        for (unsigned b = 0; b < a->size; b++)
            B(MK_FP(SCRATCH_SEG, pos + b)) = (u8)(a->value >> (8 * b));
        pos += a->size;
    }
    u16 r[13] = {0};
    r[R_SS] = SCRATCH_SEG;
    r[R_SP] = sp;
    r[R_DS] = DGROUP;
    f->call(r);
    call_sp = saved;
    if (f->outs & OUT_AL)
        return (u8)r[R_AX];
    return (u32)r[R_DX] << 16 | r[R_AX];
}

/* the far code address the original pushes for a function passed as an argument (calls.h);
   0 for a function with none */
farptr code_address(const char *name)
{
    for (const CodeName *c = CODE_NAMES; c->function != 0xFFFF; c++)
        if (!strcmp(ALL_FUNCTIONS[c->function].name, name))
            return MK_FP(c->seg + (DGROUP - DGROUP_PARA), c->off);
    return 0;
}

u32 call_far_args(farptr code, const FarArg *args, unsigned n)
{
    const Function *f = far_entry(code);
    return f ? call_entry(f, args, n) : 0;
}

u32 call_near_args(const char *module, u16 off, const FarArg *args, unsigned n)
{
    const Function *f = near_entry(module, off);
    return f ? call_entry(f, args, n) : 0;
}

/* ---- variadic arguments (variadic.h): the block the original's cdecl stack held ---- */
farptr dos_argument_block(const DosArg *args)
{
    u16 bytes = 0;
    for (const DosArg *a = args; a->size; a++)
        bytes += a->size;
    farptr block = scratch_alloc(bytes);
    farptr p = block;
    for (const DosArg *a = args; a->size; a++) {
        if (a->size == 4)
            D(p) = a->value;
        else
            W(p) = (u16)a->value;
        p = fp_add(p, a->size);
    }
    return block;
}


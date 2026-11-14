/* replay: run translated functions from calls recorded in Borland's BCC.EXE and compare.

       build/replay FUNCTION RECORDS...
       build/replay --list            the functions it can replay

   RECORDS are files of the tracing emu2's call recorder (EMU2_RECORD; tools/record.py makes
   them from the test corpus).  For each recorded call of FUNCTION, the address space is
   filled with a poison byte, the bytes the call read are put back with the values they had,
   and the translation is called with the recorded registers (its arguments are read from the
   recorded stack).  Then:
     - the registers the function returns in (adapters) must equal the recorded ones;
     - every byte the original wrote must hold the same value, and no other byte may have
       changed.  The original's own stack frame is not compared (the translation keeps its
       locals on the host stack), nor its return address and arguments: Turbo C changes a
       parameter in place (a++ on a pointer parameter), and the caller never reads it back.

   The overlay manager's work is not recorded as calls; what it wrote comes as external writes
   (X lines), applied before the child they precede, or at the end of the call.

   Functions the port does not define yet are stand-ins (build/adapters.c).  A record carries
   the calls the original made to them inside the recorded call, its children, in order.
   When the translation calls a stand-in, the next child must be a call of that function with
   the same arguments, made from the same memory (the bytes the child read must hold what it
   read); then the child's writes are applied (but for its own frame and arguments) and its
   result returned.  A different call, or one too many or too few, fails the replay.  The
   stack from below the child up to the top of the stack segment is left out of the check of
   what the child read: the translation's locals are not in the address space, and the
   callers' frames are not its business (the overlay manager, whose work is not recorded,
   rewrites return addresses there).  For the same reason the callers' frames are left out
   of the final comparison.

   A read of a byte the original never read finds poison, which almost always shows up as a
   difference.  A call that has not returned after 2 seconds stops the run (a translation
   that loops, often on poison it should never have read).
   Exit status 0 only if every call matched. */
#define _POSIX_C_SOURCE 200809L
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "port.h"
#include "replay.h"
#include "data.h"

u8 *mem;
u16 DGROUP;   /* data.h: set from each call's DS */
static u8 *expect;
static char hung[512];   /* what to say if a call does not return */

#define POISON 0xF4

static const char *REG[13] = {"AX", "BX", "CX", "DX", "SP", "BP", "SI", "DI",
                              "ES", "CS", "SS", "DS", "FLAGS"};

typedef struct {
    unsigned at, seq, steps, bios, child;
    u16 min_sp;                   /* FRAME: the lowest SP of the call */
    char name[64];
    u16 in[13], out[13];
    u8 stack[32];
    struct run { char kind; u32 lin; unsigned n; u8 *bytes; } *runs;
    unsigned n_runs, cap_runs;
} Record;

static void on_alarm(int sig)
{
    (void)sig;
    if (write(1, hung, strlen(hung)) < 0)
        _exit(1);
    _exit(1);
}

static void regs(const char *s, u16 *r)
{
    for (int i = 0; i < 13; i++)
        r[i] = (u16)strtoul(s, (char **)&s, 16);
}

static unsigned hex_bytes(const char *e, u8 *out)
{
    unsigned n = 0;
    for (; e[0] && e[1] && e[0] != '\n'; e += 2) {
        char h[3] = {e[0], e[1], 0};
        out[n++] = (u8)strtoul(h, 0, 16);
    }
    return n;
}

static void add_run(Record *c, char kind, const char *s)
{
    char *e;
    u32 lin = strtoul(s, &e, 16);
    while (*e == ' ')
        e++;
    u8 *bytes = malloc(strlen(e) / 2 + 1);
    unsigned n = hex_bytes(e, bytes);
    if (c->n_runs == c->cap_runs) {
        c->cap_runs = c->cap_runs ? 2 * c->cap_runs : 16;
        c->runs = realloc(c->runs, c->cap_runs * sizeof *c->runs);
    }
    c->runs[c->n_runs++] = (struct run){kind, lin, n, bytes};
}

/* all records of a file */
static Record *read_records(const char *file, unsigned *count)
{
    static char line[1 << 20];
    FILE *f = fopen(file, "r");
    if (!f) {
        perror(file);
        exit(2);
    }
    Record *all = 0, *c = 0;
    unsigned n = 0, cap = 0;
    while (fgets(line, sizeof line, f)) {
        if (!strncmp(line, "CALL ", 5)) {
            if (n == cap)
                all = realloc(all, (cap = cap ? 2 * cap : 64) * sizeof *all);
            c = &all[n++];
            memset(c, 0, sizeof *c);
            sscanf(line + 5, "%x %u %63s", &c->at, &c->seq, c->name);
        } else if (!c)
            continue;
        else if (!strncmp(line, "PARENT", 6))
            c->child = 1;
        else if (!strncmp(line, "IN ", 3))
            regs(line + 3, c->in);
        else if (!strncmp(line, "OUT", 3))
            regs(line + 3, c->out);
        else if (!strncmp(line, "S ", 2))
            hex_bytes(line + 2, c->stack);
        else if (line[0] == 'R' || line[0] == 'W' || line[0] == 'X')
            add_run(c, line[0], line + 2);
        else if (!strncmp(line, "FRAME ", 6))
            c->min_sp = (u16)strtoul(line + 6, 0, 16);
        else if (!strncmp(line, "STEPS ", 6))
            c->steps = atoi(line + 6);
        else if (!strncmp(line, "BIOS ", 5))
            c->bios = atoi(line + 5);
    }
    fclose(f);
    *count = n;
    return all;
}

/* ---- the call being replayed, for the stand-ins ---- */
static struct {
    const Function *fn;
    Record *call, *children;
    unsigned n_children, next;
    u32 window_lo, window_hi;     /* the stack around the two frames, left out of checks */
    /* far pointers into the original's stack that the translation passed as scratch
       pointers (port.h): original linear address -> the translation's */
    struct { u32 orig, port; } map[16];
    unsigned n_map;
    const char *file;
    int verbose;
    jmp_buf fail;
} now;

static void fail(const char *fmt, ...)
{
    if (now.verbose) {
        va_list ap;
        va_start(ap, fmt);
        printf("  %s call %u: ", now.file, now.call->seq);
        vprintf(fmt, ap);
        printf("\n");
        va_end(ap);
    }
    longjmp(now.fail, 1);
}

static int in_window(u32 a) { return a >= now.window_lo && a < now.window_hi; }

/* scratch.c: a function pointer to a code address the port has no function for */
void code_unknown(farptr code)
{
    fail("%s calls code at %04X:%04X (load segment +%04X), which names no known function",
         now.fn->name, FP_SEG(code), FP_OFF(code), (u16)(FP_SEG(code) - (DGROUP - DGROUP_PARA)));
}

/* the near scratch area runs from near_scratch_top up to the replayed call's SP */
static u16 near_scratch_base;
static int in_near_scratch(u16 off) { return off >= near_scratch_top && off < near_scratch_base; }

/* the bottom of a call's own frame: its lowest SP (records made before FRAME lines: a guess) */
static u16 frame_low(const Record *c) { return c->min_sp ? c->min_sp : c->in[R_SP] - 0x100; }

/* a byte of the original's stack as the translation's scratch byte, if it lies within 256
   bytes after a pointer the translation passed in its place; else 0 */
static u32 mapped(u32 a)
{
    for (unsigned i = 0; i < now.n_map; i++)
        if (a >= now.map[i].orig && a < now.map[i].orig + 256)
            return now.map[i].port + (a - now.map[i].orig);
    return 0;
}

u32 stand_in(const char *name, unsigned outs, const StandInArg *args, unsigned n)
{
    if (now.next >= now.n_children)
        fail("%s calls %s, where BCC.EXE made no more calls", now.fn->name, name);
    Record *c = &now.children[now.next++];
    if (getenv("REPLAY_TRACE"))
        fprintf(stderr, "    %u: %s (BCC.EXE: %s)\n", now.next, name, c->name);
    /* REPLAY_WATCH=ADDR: a byte's value before each stand-in call (debugging) */
    const char *watch = getenv("REPLAY_WATCH");
    if (watch)
        fprintf(stderr, "    watch %s = %02X before call %u (%s)\n", watch, mem[strtoul(watch, 0, 16)], now.next, name);
    /* what the overlay manager (not recorded as a call) wrote before this call */
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'X')
            memcpy(mem + c->runs[i].lin, c->runs[i].bytes, c->runs[i].n);
    if (strcmp(c->name, name))
        fail("%s calls %s, where BCC.EXE called %s (its call %u)", now.fn->name, name, c->name,
             now.next);
    now.n_map = 0;
    u32 unset = unset_args;      /* arguments the original passes unset (port.h) */
    unset_args = 0;
    for (unsigned i = 0; i < n; i++) {
        if (i < 32 && (unset >> i & 1))
            continue;
        u32 want = 0;
        for (unsigned b = 0; b < args[i].size; b++)
            want |= (u32)c->stack[args[i].off + b] << (8 * b);
        u32 mask = args[i].bytes == 1 ? 0xFF : args[i].size == 2 ? 0xFFFF : 0xFFFFFFFF;
        /* a pointer to a local of the caller: the translation's is in the scratch area, or
           in the near scratch area (DGROUP, below the call's SP) for a local BCC reaches
           through DS; a near pointer is an offset in SS, which is DGROUP */
        if (args[i].size == 4 && FP_SEG(want) == c->in[R_SS] && FP_SEG(args[i].value) == SCRATCH_SEG &&
            in_window(LIN(FP_SEG(want), FP_OFF(want))) && now.n_map < 16) {
            now.map[now.n_map].orig = LIN(FP_SEG(want), FP_OFF(want));
            now.map[now.n_map++].port = LIN(FP_SEG(args[i].value), FP_OFF(args[i].value));
            continue;
        }
        if (args[i].bytes != 1 && (args[i].value & mask) != (want & mask) && now.n_map < 16) {
            u16 seg = args[i].size == 4 ? FP_SEG(args[i].value) : c->in[R_SS];
            u16 off = (u16)args[i].value;
            u16 want_seg = args[i].size == 4 ? FP_SEG(want) : c->in[R_SS];
            if (seg == c->in[R_SS] && want_seg == c->in[R_SS] && in_near_scratch(off) &&
                in_window(LIN(want_seg, (u16)want))) {
                now.map[now.n_map].orig = LIN(want_seg, (u16)want);
                now.map[now.n_map++].port = LIN(seg, off);
                continue;
            }
        }
        if ((args[i].value & mask) != (want & mask))
            fail("%s calls %s with argument %u = %X, BCC.EXE passed %X", now.fn->name, name, i + 1,
                 args[i].value & mask, want & mask);
    }
    /* the memory it read must be as the original had it, outside the stack */
    u32 lo = now.window_lo;
    u32 child_lo = LIN(c->in[R_SS], frame_low(c));
    if (child_lo < now.window_lo)
        now.window_lo = child_lo;
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'R')
            for (unsigned j = 0; j < c->runs[i].n; j++) {
                u32 a = c->runs[i].lin + j;
                if (in_window(a))
                    a = mapped(a);
                if (a >= LIN(SCRATCH_SEG, 0) && a < LIN(SCRATCH_SEG, 0) + 0x10000 &&
                    scratch_unset((u16)(a - LIN(SCRATCH_SEG, 0))))
                    continue;   /* a local the original leaves unset (port.h) */
                if (a && mem[a] != c->runs[i].bytes[j])
                    fail("before %s calls %s, byte %05X is %02X, BCC.EXE had %02X", now.fn->name,
                         name, a, mem[a], c->runs[i].bytes[j]);
            }
    now.window_lo = lo;
    /* its writes, but for its own frame and arguments: everything else it changed is part
       of the state, the caller's stack included (the overlay manager rewrites return
       addresses there when the heap moves an overlay) */
    u32 own_lo = LIN(c->in[R_SS], frame_low(c));
    u32 own_hi = LIN(c->in[R_SS], c->in[R_SP]) + (u16)(c->out[R_SP] - c->in[R_SP]);
    if (own_hi < LIN(c->in[R_SS], c->in[R_SP]) + 4)
        own_hi = LIN(c->in[R_SS], c->in[R_SP]) + 4;
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'W')
            for (unsigned j = 0; j < c->runs[i].n; j++) {
                u32 a = c->runs[i].lin + j;
                if (in_window(a) && mapped(a))
                    mem[mapped(a)] = c->runs[i].bytes[j];
                else if (a < own_lo || a >= own_hi)
                    mem[a] = c->runs[i].bytes[j];
            }
    if (outs & OUT_AL)
        return (u8)c->out[R_AX];
    if (outs & OUT(R_DX))
        return (u32)c->out[R_DX] << 16 | c->out[R_AX];
    return c->out[R_AX];
}

/* run one call; returns 1 if it matched, printing the differences otherwise */
static int replay(const Function *fn, Record *c, Record *children, unsigned n_children,
                  const char *file, int verbose)
{
    memset(mem, POISON, MEM_SIZE);
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'R')
            memcpy(mem + c->runs[i].lin, c->runs[i].bytes, c->runs[i].n);
    /* the return address and arguments as the caller pushed them (a first read of an
       argument can be lost when the overlay manager writes on the stack) */
    memcpy(mem + LIN(c->in[R_SS], c->in[R_SP]), c->stack, sizeof c->stack);
    memcpy(expect, mem, MEM_SIZE);
    /* the return address and arguments: up to the SP the call returned with (a pascal
       function pops its arguments), or fn->args bytes past the return address */
    u32 args_lo = LIN(c->in[R_SS], c->in[R_SP]);
    u32 args_hi = args_lo + (u16)(c->out[R_SP] - c->in[R_SP]);
    if (args_hi < args_lo + fn->args)
        args_hi = args_lo + fn->args;
    /* the final memory: what the overlay manager wrote before each child (as it was then),
       then the call's own writes and what the overlay manager wrote after the last child (as
       they were at the end) */
    for (unsigned k = 0; k < n_children; k++)
        for (unsigned i = 0; i < children[k].n_runs; i++)
            if (children[k].runs[i].kind == 'X')
                memcpy(expect + children[k].runs[i].lin, children[k].runs[i].bytes, children[k].runs[i].n);
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'W' || c->runs[i].kind == 'X')
            for (unsigned j = 0; j < c->runs[i].n; j++) {
                u32 a = c->runs[i].lin + j;
                if (a < args_lo || a >= args_hi)
                    expect[a] = c->runs[i].bytes[j];
            }

    now.fn = fn;
    now.call = c;
    now.children = children;
    now.n_children = n_children;
    now.next = 0;
    /* the stack around the call, up to the top of the stack segment: the callers' frames are
       not the translation's business, and the overlay manager rewrites return addresses
       there (its work is not recorded) */
    u32 stack_top = LIN(c->in[R_SS], 0) + 0x10000;
    now.window_lo = LIN(c->in[R_SS], frame_low(c));
    now.window_hi = stack_top;
    now.file = file;
    now.verbose = verbose;
    if (setjmp(now.fail)) {
        alarm(0);
        return 0;
    }

    u16 r[13];
    memcpy(r, c->in, sizeof r);
    DGROUP = r[R_DS];
    scratch_release(0);
    near_scratch_release(r[R_SP]);
    near_scratch_base = r[R_SP];
    unset_results_clear();
    unset_returns = 0;
    unset_returns_owner = 0;
    snprintf(hung, sizeof hung, "  %s call %u: %s did not return within 2 seconds\n", file,
             c->seq, fn->name);
    alarm(2);
    fn->call(r);
    alarm(0);
    /* registers the translation says the original returns unset (port.h), for itself only */
    if (!unset_returns_owner || strcmp(unset_returns_owner, fn->name) != 0)
        unset_returns = 0;

    int ok = 1;
    if (now.next < n_children) {
        if (verbose)
            printf("  %s call %u: BCC.EXE made %u more calls (next: %s)\n", file, c->seq,
                   n_children - now.next, children[now.next].name);
        ok = 0;
    }
    if ((fn->outs & OUT_AL) && !(unset_returns & 1) && (u8)r[R_AX] != (u8)c->out[R_AX]) {
        if (verbose)
            printf("  %s call %u: AL is %02X, BCC.EXE left %02X\n", file, c->seq, (u8)r[R_AX],
                   (u8)c->out[R_AX]);
        ok = 0;
    }
    for (int i = 0; i < 13; i++)
        if ((fn->outs >> i & 1) && !(unset_returns >> i & 1) && r[i] != c->out[i]) {
            if (verbose)
                printf("  %s call %u: %s is %04X, BCC.EXE left %04X\n", file, c->seq, REG[i],
                       r[i], c->out[i]);
            ok = 0;
        }
    /* what the overlay manager wrote after the last child */
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'X')
            memcpy(mem + c->runs[i].lin, c->runs[i].bytes, c->runs[i].n);
    /* the scratch area is the translation's own (port.h) */
    memcpy(mem + LIN(SCRATCH_SEG, 0), expect + LIN(SCRATCH_SEG, 0), 0x10000);
    /* and the stack from the call's own frame up (its frame, return address, arguments and
       the callers' frames) is left out, as above */
    u32 frame_lo = LIN(c->in[R_SS], frame_low(c));
    /* the frames of the calls it made are its own stack use too: a stand-in's writes there
       are not applied (stand_in), so they are not compared either */
    for (unsigned k = 0; k < n_children; k++)
        if (children[k].in[R_SS] == c->in[R_SS] && LIN(c->in[R_SS], frame_low(&children[k])) < frame_lo)
            frame_lo = LIN(c->in[R_SS], frame_low(&children[k]));
    memcpy(mem + frame_lo, expect + frame_lo, stack_top - frame_lo);
    /* a far pointer to one of the original's locals, left behind in memory (a dangling
       pointer to a dead frame, as after an error path): the translation's local is in the
       scratch area, so a scratch pointer stands for any address in the call's own frames */
    for (u32 a = 0; a + 4 <= MEM_SIZE; a++)
        if (mem[a] != expect[a])
            for (u32 s = a >= 3 ? a - 3 : 0; s <= a && s + 4 <= MEM_SIZE; s++) {
                u16 want_seg = expect[s + 2] | expect[s + 3] << 8, want_off = expect[s] | expect[s + 1] << 8;
                u16 got_seg = mem[s + 2] | mem[s + 3] << 8;
                if (want_seg == c->in[R_SS] && got_seg == SCRATCH_SEG && want_off >= frame_low(c) &&
                    want_off < c->in[R_SP]) {
                    memcpy(mem + s, expect + s, 4);
                    break;
                }
            }
    /* memory the translation marked as holding an unset value (port.h) */
    for (u32 a = 0; a < MEM_SIZE; a++)
        if (mem[a] != expect[a] && result_unset(a))
            mem[a] = expect[a];
    if (memcmp(mem, expect, MEM_SIZE)) {
        unsigned shown = 0;
        for (u32 a = 0; a < MEM_SIZE; a++)
            if (mem[a] != expect[a] && verbose && shown++ < 8)
                printf("  %s call %u: byte %05X is %02X, BCC.EXE left %02X\n", file, c->seq, a,
                       mem[a], expect[a]);
        ok = 0;
    }
    return ok;
}

int main(int argc, char **argv)
{
    if (argc == 2 && !strcmp(argv[1], "--list")) {
        list_functions();
        return 0;
    }
    if (argc < 3) {
        fprintf(stderr, "usage: replay FUNCTION RECORDS...\n");
        return 2;
    }
    const Function *fn = find_function(argv[1]);
    if (!fn) {
        fprintf(stderr, "replay: %s is not translated (no adapter)\n", argv[1]);
        return 2;
    }
    signal(SIGALRM, on_alarm);
    mem = malloc(MEM_SIZE);
    expect = malloc(MEM_SIZE);
    unsigned calls = 0, matched = 0, failed_shown = 0, with_children = 0;
    for (int i = 2; i < argc; i++) {
        unsigned n;
        Record *all = read_records(argv[i], &n);
        for (unsigned k = 0; k < n;) {
            unsigned kids = 0;
            while (k + 1 + kids < n && all[k + 1 + kids].child)
                kids++;
            if (!all[k].child && (!getenv("REPLAY_ONLY") || (unsigned)atoi(getenv("REPLAY_ONLY")) == all[k].seq)) {
                calls++;
                with_children += kids > 0;
                int ok = replay(fn, &all[k], &all[k + 1], kids, argv[i], failed_shown < 5);
                matched += ok;
                failed_shown += !ok;
            }
            k += 1 + kids;
        }
    }
    if (!calls) {
        printf("%s: no recorded calls, not checked (does the corpus reach it?)\n", fn->name);
        return 1;
    }
    printf("%s: %u calls, %u match", fn->name, calls, matched);
    if (with_children)
        printf(" (%u with calls to functions not yet translated)", with_children);
    printf("\n");
    return matched == calls ? 0 : 1;
}

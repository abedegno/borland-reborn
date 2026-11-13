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

   Functions the port does not define yet are stand-ins (build/adapters.c).  A record carries
   the calls the original made to them inside the recorded call, its children, in order.
   When the translation calls a stand-in, the next child must be a call of that function with
   the same arguments, made from the same memory (the bytes the child read must hold what it
   read); then the child's writes are applied (but for its own frame and arguments) and its
   result returned.  A different call, or one too many or too few, fails the replay.  The
   stack around the two frames is left out of the check of what the child read: the
   translation's locals are not in the address space.

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
        else if (line[0] == 'R' || line[0] == 'W')
            add_run(c, line[0], line + 2);
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

u32 stand_in(const char *name, unsigned outs, const StandInArg *args, unsigned n)
{
    if (now.next >= now.n_children)
        fail("%s calls %s, where BCC.EXE made no more calls", now.fn->name, name);
    Record *c = &now.children[now.next++];
    if (strcmp(c->name, name))
        fail("%s calls %s, where BCC.EXE called %s (its call %u)", now.fn->name, name, c->name,
             now.next);
    for (unsigned i = 0; i < n; i++) {
        u32 want = 0;
        for (unsigned b = 0; b < args[i].size; b++)
            want |= (u32)c->stack[args[i].off + b] << (8 * b);
        u32 mask = args[i].bytes == 1 ? 0xFF : args[i].size == 2 ? 0xFFFF : 0xFFFFFFFF;
        if ((args[i].value & mask) != (want & mask))
            fail("%s calls %s with argument %u = %X, BCC.EXE passed %X", now.fn->name, name, i + 1,
                 args[i].value & mask, want & mask);
    }
    /* the memory it read must be as the original had it, outside the stack */
    u32 lo = now.window_lo;
    u32 child_lo = LIN(c->in[R_SS], c->in[R_SP]) - 0x1000;
    if (child_lo < now.window_lo)
        now.window_lo = child_lo;
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'R')
            for (unsigned j = 0; j < c->runs[i].n; j++) {
                u32 a = c->runs[i].lin + j;
                if (!in_window(a) && mem[a] != c->runs[i].bytes[j])
                    fail("before %s calls %s, byte %05X is %02X, BCC.EXE had %02X", now.fn->name,
                         name, a, mem[a], c->runs[i].bytes[j]);
            }
    now.window_lo = lo;
    /* its writes, but for its own frame and arguments: everything else it changed is part
       of the state, the caller's stack included (the overlay manager rewrites return
       addresses there when the heap moves an overlay) */
    u32 own_lo = LIN(c->in[R_SS], c->in[R_SP]) - 0x1000;
    u32 own_hi = LIN(c->in[R_SS], c->in[R_SP]) + (u16)(c->out[R_SP] - c->in[R_SP]);
    if (own_hi < own_lo + 0x1000 + 4)
        own_hi = own_lo + 0x1000 + 4;
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'W')
            for (unsigned j = 0; j < c->runs[i].n; j++) {
                u32 a = c->runs[i].lin + j;
                if (a < own_lo || a >= own_hi)
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
    memcpy(expect, mem, MEM_SIZE);
    /* the return address and arguments: up to the SP the call returned with (a pascal
       function pops its arguments), or fn->args bytes past the return address */
    u32 args_lo = LIN(c->in[R_SS], c->in[R_SP]);
    u32 args_hi = args_lo + (u16)(c->out[R_SP] - c->in[R_SP]);
    if (args_hi < args_lo + fn->args)
        args_hi = args_lo + fn->args;
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'W')
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
    now.window_lo = args_lo - 0x1000;
    now.window_hi = args_hi + 0x40;
    now.file = file;
    now.verbose = verbose;
    if (setjmp(now.fail)) {
        alarm(0);
        return 0;
    }

    u16 r[13];
    memcpy(r, c->in, sizeof r);
    DGROUP = r[R_DS];
    snprintf(hung, sizeof hung, "  %s call %u: %s did not return within 2 seconds\n", file,
             c->seq, fn->name);
    alarm(2);
    fn->call(r);
    alarm(0);

    int ok = 1;
    if (now.next < n_children) {
        if (verbose)
            printf("  %s call %u: BCC.EXE made %u more calls (next: %s)\n", file, c->seq,
                   n_children - now.next, children[now.next].name);
        ok = 0;
    }
    if ((fn->outs & OUT_AL) && (u8)r[R_AX] != (u8)c->out[R_AX]) {
        if (verbose)
            printf("  %s call %u: AL is %02X, BCC.EXE left %02X\n", file, c->seq, (u8)r[R_AX],
                   (u8)c->out[R_AX]);
        ok = 0;
    }
    for (int i = 0; i < 13; i++)
        if ((fn->outs >> i & 1) && r[i] != c->out[i]) {
            if (verbose)
                printf("  %s call %u: %s is %04X, BCC.EXE left %04X\n", file, c->seq, REG[i],
                       r[i], c->out[i]);
            ok = 0;
        }
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
            if (!all[k].child) {
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

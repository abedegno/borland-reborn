/* replay: run translated functions from calls recorded in Borland's BCC.EXE and compare.

       build/replay FUNCTION RECORDS...
       build/replay --list            the functions it can replay

   RECORDS are files of the tracing emu2's call recorder (EMU2_RECORD; tools/record.py makes
   them from the test corpus).  For each recorded call of FUNCTION, the address space is
   filled with a poison byte, the bytes the call read are put back with the values they had,
   and the translation is called with the recorded registers (its arguments are read from the
   recorded stack).  Then:
     - the registers the function returns in (functions.c) must equal the recorded ones;
     - every byte the original wrote must hold the same value, and no other byte may have
       changed.  The original's own stack frame is not compared: the translation keeps its
       locals on the host stack.
   A read of a byte the original never read finds poison, which almost always shows up as a
   difference.  A call that has not returned after 2 seconds stops the run (a translation
   that loops, often on poison it should never have read).  Calls that made DOS or BIOS calls are skipped: their records are incomplete.
   Exit status 0 only if every compared call matched. */
#define _POSIX_C_SOURCE 200809L
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include "port.h"
#include "replay.h"

u8 *mem;
static u8 *expect;
static char hung[512];   /* what to say if a call does not return */

static void on_alarm(int sig)
{
    (void)sig;
    if (write(1, hung, strlen(hung)) < 0)
        _exit(1);
    _exit(1);
}

#define POISON 0xF4

static const char *REG[13] = {"AX", "BX", "CX", "DX", "SP", "BP", "SI", "DI",
                              "ES", "CS", "SS", "DS", "FLAGS"};

typedef struct {
    unsigned at, seq, steps, bios;
    u16 in[13], out[13];
    /* memory runs: kind 'R' or 'W', linear address, bytes */
    struct run { char kind; u32 lin; unsigned n; u8 *bytes; } *runs;
    unsigned n_runs, cap_runs;
} Record;

static void regs(const char *s, u16 *r)
{
    for (int i = 0; i < 13; i++)
        r[i] = (u16)strtoul(s, (char **)&s, 16);
}

static void add_run(Record *c, char kind, const char *s)
{
    char *e;
    u32 lin = strtoul(s, &e, 16);
    while (*e == ' ')
        e++;
    unsigned n = 0;
    u8 *bytes = malloc(strlen(e) / 2 + 1);
    for (; e[0] && e[1] && e[0] != '\n'; e += 2) {
        char h[3] = {e[0], e[1], 0};
        bytes[n++] = (u8)strtoul(h, 0, 16);
    }
    if (c->n_runs == c->cap_runs) {
        c->cap_runs = c->cap_runs ? 2 * c->cap_runs : 16;
        c->runs = realloc(c->runs, c->cap_runs * sizeof *c->runs);
    }
    c->runs[c->n_runs++] = (struct run){kind, lin, n, bytes};
}

static void clear(Record *c)
{
    for (unsigned i = 0; i < c->n_runs; i++)
        free(c->runs[i].bytes);
    free(c->runs);
    memset(c, 0, sizeof *c);
}

/* read the next record; 0 at the end of the file */
static int next_record(FILE *f, Record *c)
{
    static char line[1 << 20];
    clear(c);
    int in_call = 0;
    while (fgets(line, sizeof line, f)) {
        if (!strncmp(line, "CALL ", 5)) {
            sscanf(line + 5, "%x %u", &c->at, &c->seq);
            in_call = 1;
        } else if (!in_call)
            continue;
        else if (!strncmp(line, "IN ", 3))
            regs(line + 3, c->in);
        else if (!strncmp(line, "OUT", 3))
            regs(line + 3, c->out);
        else if (line[0] == 'R' || line[0] == 'W')
            add_run(c, line[0], line + 2);
        else if (!strncmp(line, "STEPS ", 6))
            c->steps = atoi(line + 6);
        else if (!strncmp(line, "BIOS ", 5))
            c->bios = atoi(line + 5);
        else if (!strncmp(line, "END", 3))
            return 1;
    }
    return 0;
}

/* run one call; returns 1 if it matched, printing the differences otherwise */
static int replay(const Function *fn, Record *c, const char *file, int verbose)
{
    memset(mem, POISON, MEM_SIZE);
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'R')
            memcpy(mem + c->runs[i].lin, c->runs[i].bytes, c->runs[i].n);
    memcpy(expect, mem, MEM_SIZE);
    for (unsigned i = 0; i < c->n_runs; i++)
        if (c->runs[i].kind == 'W')
            memcpy(expect + c->runs[i].lin, c->runs[i].bytes, c->runs[i].n);

    u16 r[13];
    memcpy(r, c->in, sizeof r);
    snprintf(hung, sizeof hung, "  %s call %u: %s did not return within 2 seconds\n", file,
             c->seq, fn->name);
    alarm(2);
    fn->call(r);
    alarm(0);

    int ok = 1;
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
            if (mem[a] != expect[a]) {
                if (verbose && shown++ < 8)
                    printf("  %s call %u: byte %05X is %02X, BCC.EXE left %02X\n", file, c->seq,
                           a, mem[a], expect[a]);
            }
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
        fprintf(stderr, "replay: no translation of %s in replay/functions.c\n", argv[1]);
        return 2;
    }
    signal(SIGALRM, on_alarm);
    mem = malloc(MEM_SIZE);
    expect = malloc(MEM_SIZE);
    unsigned calls = 0, matched = 0, skipped = 0, failed_shown = 0;
    Record c = {0};
    for (int i = 2; i < argc; i++) {
        FILE *f = fopen(argv[i], "r");
        if (!f) {
            perror(argv[i]);
            return 2;
        }
        while (next_record(f, &c)) {
            if (c.bios) {
                skipped++;
                continue;
            }
            calls++;
            int ok = replay(fn, &c, argv[i], failed_shown < 5);
            matched += ok;
            failed_shown += !ok;
        }
        fclose(f);
    }
    clear(&c);
    printf("%s: %u calls, %u match", fn->name, calls, matched);
    if (skipped)
        printf(", %u skipped (made DOS calls)", skipped);
    printf("\n");
    return calls && matched == calls ? 0 : 1;
}

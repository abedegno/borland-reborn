/* explain.c: EXPLAIN's output (include/explain.h).  Everything here only reads BCC's
   memory: a name is read from its NAME_POOL record, a register name from the pseudo-register
   table, so explaining never changes what is compiled. */
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "port.h"
#include "data.h"
#include "pool.h"
#include "native.h"
#include "explain.h"

int native_explaining;
static void (*sink)(void *, const char *);
static void *sink_context;

/* native.c, before a run: the job's callback, or stderr when BCC_EXPLAIN is set */
void native_explain_begin(void (*callback)(void *, const char *), void *context)
{
    sink = callback;
    sink_context = context;
    native_explaining = callback != 0 || getenv("BCC_EXPLAIN") != 0;
}

void native_explain(const char *format, ...)
{
    char line[512];
    va_list ap;
    va_start(ap, format);
    vsnprintf(line, sizeof line, format, ap);
    va_end(ap);
    if (sink)
        sink(sink_context, line);
    else
        fprintf(stderr, "explain: %s\n", line);
}

/* a few rotating buffers, so several names can go into one line */
static char *buffer(void)
{
    static char buffers[8][96];
    static unsigned next;
    return buffers[next++ & 7];
}

const char *explain_symbol(u16 symbol)
{
    char *out = buffer();
    if (!symbol) {
        strcpy(out, "(temporary)");
        return out;
    }
    u16 name = SB(CPP_MODE_P) ? SYM_W(symbol, 2) : CSYM_W(symbol, 2);
    if (!name) {
        strcpy(out, "(unnamed)");
        return out;
    }
    farptr text = MK_FP(W(DSPTR(NAME_W(name, 4))), NAME_W(name, 2));
    size_t n = 0;
    while (n < 95 && SB(text) > ' ') {
        out[n++] = (char)SB(text);
        text = fp_add(text, 1);
    }
    out[n] = 0;
    return out;
}

/* the word register numbered number, as the -S listing spells it, into out (3+ bytes) */
static void register_name(u16 number, char *out, size_t size)
{
    for (farptr e = PSEUDO_REGISTER_TABLE_P; W(e); e = fp_add(e, 7))
        if (W(fp_add(e, 2)) == number && SB(fp_add(e, 4)) == 6) {
            u16 name = W(e);
            snprintf(out, size, "%c%c", SB(DSPTR(name + 1)) | 0x20, SB(DSPTR(name + 2)) | 0x20);
            return;
        }
    snprintf(out, size, "r%u", number);
}

const char *explain_register(u16 number)
{
    char *out = buffer();
    register_name(number, out, 96);
    return out;
}

const char *explain_registers(u16 mask)
{
    char *out = buffer();
    size_t n = 0;
    out[0] = 0;
    for (u16 i = 0; i < 16 && n < 80; i++)
        if (mask & (1u << i)) {
            char name[8];
            register_name(i, name, sizeof name);
            n += (size_t)snprintf(out + n, 96 - n, "%s%s", n ? "," : "", name);
        }
    if (!n)
        strcpy(out, "-");
    return out;
}

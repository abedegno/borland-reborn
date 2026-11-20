/* functions.c: the hand-written adapters, and the lookup of a function by name.

   Most adapters are generated (build/adapters.c, tools/genadapters.py) from the port's
   prototypes and the original definitions' calling conventions.  A function whose original
   passes values in other registers, or that the generator gets wrong, gets an entry here,
   which takes precedence. */
#include <stdio.h>
#include <string.h>
#include "replay.h"
#include "variadic.h"

/* the variadic originals (variadic.h): replayed through their _ARGS forms, with the block
   of arguments the original had on its stack after the fixed one (far cdecl: the return
   address takes 4 bytes) */
static u16 stack_word(u16 *r, u16 offset) { return W(MK_FP(r[R_SS], r[R_SP] + offset)); }
static u32 stack_dword(u16 *r, u16 offset) { return D(MK_FP(r[R_SS], r[R_SP] + offset)); }
static void call_REPORT_FATAL(u16 *r) { REPORT_FATAL_ARGS((i16)stack_word(r, 4), MK_FP(r[R_SS], r[R_SP] + 6)); }
static void call_REPORT_ERROR(u16 *r) { REPORT_ERROR_ARGS((i16)stack_word(r, 4), MK_FP(r[R_SS], r[R_SP] + 6)); }
static void call_REPORT_WARNING(u16 *r) { REPORT_WARNING_ARGS(stack_word(r, 4), MK_FP(r[R_SS], r[R_SP] + 6)); }
static void call_RTL_DPRINTF(u16 *r) { RTL_DPRINTF_ARGS(stack_dword(r, 4), MK_FP(r[R_SS], r[R_SP] + 8)); }

static const Function HAND_FUNCTIONS[] = {
    {"REPORT_FATAL", call_REPORT_FATAL, 0, 6, 4},
    {"REPORT_ERROR", call_REPORT_ERROR, 0, 6, 4},
    {"REPORT_WARNING", call_REPORT_WARNING, 0, 6, 4},
    {"RTL_DPRINTF", call_RTL_DPRINTF, 0, 8, 4},
    {0, 0, 0, 0, 0},
};

extern const Function GENERATED_FUNCTIONS[];

const Function *find_function(const char *name)
{
    for (const Function *f = HAND_FUNCTIONS; f->name; f++)
        if (!strcmp(f->name, name))
            return f;
    for (const Function *f = GENERATED_FUNCTIONS; f->name; f++)
        if (!strcmp(f->name, name))
            return f;
    return 0;
}

void list_functions(void)
{
    for (const Function *f = HAND_FUNCTIONS; f->name; f++)
        puts(f->name);
    for (const Function *f = GENERATED_FUNCTIONS; f->name; f++)
        if (find_function(f->name) == f)
            puts(f->name);
}

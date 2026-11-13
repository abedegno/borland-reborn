/* functions.c: the hand-written adapters, and the lookup of a function by name.

   Most adapters are generated (build/adapters.c, tools/genadapters.py) from the port's
   prototypes and the original definitions' calling conventions.  A function whose original
   passes values in other registers, or that the generator gets wrong, gets an entry here,
   which takes precedence. */
#include <stdio.h>
#include <string.h>
#include "replay.h"
#include "variadic.h"

/* stand-ins for variadic functions: the fixed arguments are checked */
void REPORT_FATAL(i16 error, ...)
{
    const StandInArg args[] = {{4, 2, 2, (u32)error}};
    stand_in("REPORT_FATAL", 0, args, 1);
}

void REPORT_ERROR(i16 error, ...)
{
    const StandInArg args[] = {{4, 2, 2, (u32)error}};
    stand_in("REPORT_ERROR", 0, args, 1);
}

static const Function HAND_FUNCTIONS[] = {
    {0, 0, 0, 0},
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

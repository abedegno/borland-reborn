/* functions.c: the hand-written adapters, and the lookup of a function by name.

   Most adapters are generated (build/adapters.c, tools/genadapters.py) from the port's
   prototypes and the original definitions' calling conventions.  A function whose original
   passes values in other registers, or that the generator gets wrong, gets an entry here,
   which takes precedence. */
#include <stdio.h>
#include <string.h>
#include "replay.h"
#include "variadic.h"
#include "structargs.h"

/* stand-ins for variadic functions: the fixed arguments are checked */
void REPORT_FATAL(i16 error, ...)
{
    const StandInArg args[] = {{4, 2, 2, (u32)error}};
    stand_in("REPORT_FATAL", 0, args, 1);
}

void REPORT_WARNING(u16 error, ...)
{
    const StandInArg args[] = {{4, 2, 2, (u32)error}};
    stand_in("REPORT_WARNING", 0, args, 1);
}

void REPORT_ERROR(i16 error, ...)
{
    const StandInArg args[] = {{4, 2, 2, (u32)error}};
    stand_in("REPORT_ERROR", 0, args, 1);
}

/* stand-ins for functions that take a structure by value (structargs.h): far pascal, so
   the structure is pushed after the arguments before it, its first word lowest */
u16 MAKE_MEMBER_NODE(u16 member, u16 file, u16 line, u16 word3)
{
    const StandInArg args[] = {{10, 2, 2, member}, {4, 2, 2, file}, {6, 2, 2, line}, {8, 2, 2, word3}};
    return (u16)stand_in("MAKE_MEMBER_NODE", OUT(R_AX), args, 4);
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

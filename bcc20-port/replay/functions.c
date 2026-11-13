/* functions.c: how replay calls each translated function.

   Each entry reads the function's arguments where BCC.EXE's caller put them and stores the
   result in the registers it returns in.  For a far pascal function the return address takes
   4 bytes at SP and the arguments follow, the last one first (pascal pushes left to right). */
#include <stdio.h>
#include <string.h>
#include "replay.h"
#include "rtl.h"

static void call_COMPARE_NAME(u16 *r)
{
    r[R_AX] = (u16)COMPARE_NAME(arg32(r, 8), arg32(r, 4));
}

static void call_STRING_LENGTH(u16 *r)
{
    r[R_AX] = STRING_LENGTH(arg32(r, 4));
}

static void call_RTL_MEMMOVE(u16 *r)
{
    RTL_MEMMOVE(arg32(r, 10), arg32(r, 6), arg16(r, 4));
}

static void ret32(u16 *r, u32 v)
{
    r[R_AX] = (u16)v;
    r[R_DX] = (u16)(v >> 16);
}

static void call_RTL_MEMSET(u16 *r)
{
    ret32(r, RTL_MEMSET(arg32(r, 8), (i16)arg16(r, 6), arg16(r, 4)));
}

static void call_STRING_COPY(u16 *r)
{
    ret32(r, STRING_COPY(arg32(r, 8), arg32(r, 4)));
}

static void call_RTL_STRNCPY(u16 *r)
{
    ret32(r, RTL_STRNCPY(arg32(r, 10), arg32(r, 6), arg16(r, 4)));
}

#define DXAX (OUT(R_DX) | OUT(R_AX))
static const Function FUNCTIONS[] = {
    {"COMPARE_NAME", call_COMPARE_NAME, OUT(R_AX)},
    {"STRING_LENGTH", call_STRING_LENGTH, OUT(R_AX)},
    {"RTL_MEMMOVE", call_RTL_MEMMOVE, 0},
    {"RTL_MEMSET", call_RTL_MEMSET, DXAX},
    {"STRING_COPY", call_STRING_COPY, DXAX},
    {"RTL_STRNCPY", call_RTL_STRNCPY, DXAX},
};

const Function *find_function(const char *name)
{
    for (unsigned i = 0; i < sizeof FUNCTIONS / sizeof *FUNCTIONS; i++)
        if (!strcmp(FUNCTIONS[i].name, name))
            return &FUNCTIONS[i];
    return 0;
}

void list_functions(void)
{
    for (unsigned i = 0; i < sizeof FUNCTIONS / sizeof *FUNCTIONS; i++)
        puts(FUNCTIONS[i].name);
}

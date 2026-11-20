/* hostjmp.h: the host's setjmp and longjmp, as the port uses them (C0_TERMINATE's exit from
   deep inside a compile, BCC's own long jumps, the inline assembler's statement exit).
   MinGW-w64's setjmp records the frame for an SEH unwind, and longjmp then unwinds through
   Windows' exception tables, which fails for these jumps (status C00000FF); with no frame
   recorded longjmp restores the registers alone, as on other hosts. */
#ifndef HOSTJMP_H
#define HOSTJMP_H
#include <setjmp.h>
#if defined(__MINGW64__) && defined(_WIN64)
#undef setjmp
#define setjmp(buffer) _setjmp((buffer), NULL)
#endif
#endif

/* setjump.h: C45_SETJUMP for the functions that call it (COMPILE_ONE_FILE, RUN_LINKER),
   included after protos.h.  In the native build (native/) it is the host's setjmp, so it is
   expanded in the frame of the function that calls it; native.c's C45_LONGJUMP jumps back.
   Under replay it stays the recorded call. */
#ifndef PORT_SETJUMP_H
#define PORT_SETJUMP_H
#include "port.h"
#ifdef PORT_NATIVE
#include "hostjmp.h"
jmp_buf *native_jump_slot(farptr buffer);
#undef C45_SETJUMP
#define C45_SETJUMP(buffer) ((i16)setjmp(*native_jump_slot(buffer)))
#endif
#endif

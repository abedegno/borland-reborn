/* stack.h: BCC.EXE's stack checks.  The original stops with "Out of memory" when the 8086
   SP is below 8F0Ch at the top of its eight deeply recursive functions.  In the native build
   STACK_CHECK compares the virtual SP of native/stack.c; under replay it does nothing (no
   recorded call reaches the limit).
   A translation that leaves calls with its own longjmp (not C45_LONGJUMP) saves the model's
   depth with STACK_DEPTH() before its setjmp and puts it back with STACK_UNWIND after the
   jump, since the jump skips the calls' ends. */
#ifndef PORT_STACK_H
#define PORT_STACK_H
#ifdef PORT_NATIVE
int native_stack_below(u16 limit, void *fn);
unsigned native_stack_depth(void);
void native_stack_unwind(unsigned to);
#define STACK_CHECK(fn) do { if (native_stack_below(0x8F0C, (void *)(fn))) REPORT_FATAL(MSG_OUT_MEMORY); } while (0)
#define STACK_DEPTH() native_stack_depth()
#define STACK_UNWIND(depth) native_stack_unwind(depth)
#else
#define STACK_CHECK(fn) do { } while (0)
#define STACK_DEPTH() 0u
#define STACK_UNWIND(depth) ((void)(depth))
#endif
#endif

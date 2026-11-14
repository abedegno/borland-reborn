/* calls.h: every function of the original as a register-level entry, and calls through
   BCC's code pointers.

   Each function (translated, or a replay stand-in) has an adapter that takes its arguments
   from an 8086 stack in the address space, as its original calling convention lays them
   out, and leaves its result in AX or DX:AX (build/adapters.c, tools/genadapters.py).
   A call through a code pointer (a hook, a callback, a handler table) goes through these
   adapters: the arguments are pushed as the original caller pushed them, so the call does
   not depend on the C types the two sides were declared with. */
#ifndef PORT_CALLS_H
#define PORT_CALLS_H
#include "port.h"

/* register indexes: AX BX CX DX SP BP SI DI ES CS SS DS FLAGS */
enum { R_AX, R_BX, R_CX, R_DX, R_SP, R_BP, R_SI, R_DI, R_ES, R_CS, R_SS, R_DS, R_FLAGS };
#define OUT(r) (1u << (r))
#define OUT_AL (1u << 13)   /* only AL: a char result */

typedef struct {
    const char *name;
    void (*call)(u16 *r);   /* arguments from the stack at r[SS]:r[SP], result in r */
    unsigned outs;          /* the registers it returns in */
    unsigned args;          /* cdecl: bytes of return address and arguments (the caller pops
                               them); 0 for pascal */
    unsigned ret;           /* bytes of its return address: 2 near, 4 far */
} Function;

extern const Function ALL_FUNCTIONS[];

static inline void ret32(u16 *r, u32 v)
{
    r[R_AX] = (u16)v;
    r[R_DX] = (u16)(v >> 16);
}

/* an argument as the original caller pushes it: a word or a doubleword */
typedef struct {
    u8 size;
    u32 value;
} FarArg;
#define A16(x) {2, (u32)(u16)(x)}
#define A32(x) {4, (u32)(x)}

/* call the function at a far code address (or a near offset in a module's code segment),
   arguments in the order of the original declaration; the result is DX:AX */
u32 call_far_args(farptr code, const FarArg *args, unsigned n);
u32 call_near_args(const char *module, u16 off, const FarArg *args, unsigned n);
/* the far code address of a function, as the original passes it as an argument */
farptr code_address(const char *name);
#define CALL_FAR(code, ...) \
    call_far_args((code), (const FarArg[]){__VA_ARGS__}, sizeof((const FarArg[]){__VA_ARGS__}) / sizeof(FarArg))
#define CALL_FAR0(code) call_far_args((code), 0, 0)
#define CALL_NEAR(module, off, ...)                                                   \
    call_near_args((module), (off), (const FarArg[]){__VA_ARGS__},                   \
                   sizeof((const FarArg[]){__VA_ARGS__}) / sizeof(FarArg))

#endif

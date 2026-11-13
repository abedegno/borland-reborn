#ifndef REPLAY_H
#define REPLAY_H
#include "port.h"

/* register indexes of a record: AX BX CX DX SP BP SI DI ES CS SS DS FLAGS */
enum { R_AX, R_BX, R_CX, R_DX, R_SP, R_BP, R_SI, R_DI, R_ES, R_CS, R_SS, R_DS, R_FLAGS };
#define OUT(r) (1u << (r))
#define OUT_AL (1u << 13)   /* only AL: a char result */

/* a translated function as replay calls it: `call` takes its arguments from the recorded
   registers and stack and leaves its results in the registers named by `outs` */
typedef struct {
    const char *name;
    void (*call)(u16 *r);
    unsigned outs;
    unsigned args;   /* bytes of return address and arguments, for a function that does not
                        pop them (cdecl); 0 for pascal, whose return SP shows them */
} Function;

const Function *find_function(const char *name);

/* an argument a stand-in was called with: its offset from SP at entry, its size on the
   stack, its own size (1 for a char, pushed as a word) and its value */
typedef struct {
    unsigned off, size, bytes;
    u32 value;
} StandInArg;

/* answer a call of a function not yet translated from the recorded call (replay.c) */
u32 stand_in(const char *name, unsigned outs, const StandInArg *args, unsigned n);
void list_functions(void);

/* arguments on the recorded stack: off is from SP at entry (0 is the return address) */
static inline u16 arg16(const u16 *r, unsigned off) { return W(MK_FP(r[R_SS], r[R_SP] + off)); }
static inline farptr arg32(const u16 *r, unsigned off) { return D(MK_FP(r[R_SS], r[R_SP] + off)); }

static inline void ret32(u16 *r, u32 v)
{
    r[R_AX] = (u16)v;
    r[R_DX] = (u16)(v >> 16);
}

#endif

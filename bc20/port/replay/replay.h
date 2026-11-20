#ifndef REPLAY_H
#define REPLAY_H
#include "port.h"

#include "calls.h"

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


#endif

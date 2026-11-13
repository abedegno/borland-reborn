#ifndef REPLAY_H
#define REPLAY_H
#include "port.h"

/* register indexes of a record: AX BX CX DX SP BP SI DI ES CS SS DS FLAGS */
enum { R_AX, R_BX, R_CX, R_DX, R_SP, R_BP, R_SI, R_DI, R_ES, R_CS, R_SS, R_DS, R_FLAGS };
#define OUT(r) (1u << (r))

/* a translated function as replay calls it: `call` takes its arguments from the recorded
   registers and stack and leaves its results in the registers named by `outs` */
typedef struct {
    const char *name;
    void (*call)(u16 *r);
    unsigned outs;
} Function;

const Function *find_function(const char *name);
void list_functions(void);

/* arguments on the recorded stack: off is from SP at entry (0 is the return address) */
static inline u16 arg16(const u16 *r, unsigned off) { return W(MK_FP(r[R_SS], r[R_SP] + off)); }
static inline farptr arg32(const u16 *r, unsigned off) { return D(MK_FP(r[R_SS], r[R_SP] + off)); }

#endif

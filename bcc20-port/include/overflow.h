/* overflow.h: what the original's hand-written helpers report in the 8086 overflow flag,
   which C cannot return: the port's translations set these instead. */
#ifndef PORT_OVERFLOW_H
#define PORT_OVERFLOW_H

/* the OF that LMUL_WITH_OVERFLOW (src/float/lmulovf.c) leaves */
extern int lmul_overflow;

#endif

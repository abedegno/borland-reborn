/* ldouble.h: the software long double (80-bit extended real) routines of the run-time
   library (src/float), hand-written assembly in the original.  A value is 10 bytes: the
   64-bit mantissa (explicit leading bit) in four little-endian words, then a word of sign
   (bit 15) and exponent (bias 3FFFh).  The routines declared here are called only from
   other assembly modules, so the original's C headers do not name them (protos.h has the
   ones C code calls). */
#ifndef PORT_LDOUBLE_H
#define PORT_LDOUBLE_H
#include "port.h"

typedef uint64_t u64;
typedef int64_t i64;

void RTL_INT64_TO_LDOUBLE(farptr source, farptr target);   /* i642ld.c */
void RTL_LDOUBLE_TO_INT64(farptr source, farptr target);   /* ld2i64.c */
void RTL_LDOUBLE_SCALE_POW10(i16 power, farptr value);     /* rpow10.c */

/* the mantissa and the sign-and-exponent word of the value at p */
static inline u64 ld_mantissa(farptr p)
{
    return (u64)D(p) | (u64)D(fp_add(p, 4)) << 32;
}
static inline u16 ld_exponent_word(farptr p) { return W(fp_add(p, 8)); }
static inline void ld_store(farptr p, u64 mantissa, u16 exponent_word)
{
    D(p) = (u32)mantissa;
    D(fp_add(p, 4)) = (u32)(mantissa >> 32);
    W(fp_add(p, 8)) = exponent_word;
}
static inline u64 ld_read64(farptr p) { return ld_mantissa(p); }
static inline void ld_write64(farptr p, u64 v)
{
    D(p) = (u32)v;
    D(fp_add(p, 4)) = (u32)(v >> 32);
}

#endif

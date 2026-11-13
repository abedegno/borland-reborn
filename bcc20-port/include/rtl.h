/* rtl.h: the run-time library functions translated so far (src/rtl/). */
#ifndef RTL_H
#define RTL_H
#include "port.h"

i16 COMPARE_NAME(farptr a, farptr b);
u16 STRING_LENGTH(farptr string);
void RTL_MEMMOVE(farptr destination, farptr source, u16 count);
farptr RTL_MEMSET(farptr destination, i16 c, u16 count);
farptr STRING_COPY(farptr destination, farptr source);
farptr RTL_STRNCPY(farptr destination, farptr source, u16 n);

#endif

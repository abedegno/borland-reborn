/* variadic.h: functions of the original with variable arguments, declared by hand
   (tools/genadapters.py leaves them out of protos.h).  replay/functions.c has their
   stand-ins, which check the fixed arguments only. */
#ifndef PORT_VARIADIC_H
#define PORT_VARIADIC_H
#include "port.h"

void REPORT_FATAL(i16 error, ...);     /* diag/FATAL.C, far cdecl: stops the compile */
void REPORT_ERROR(i16 error, ...);     /* diag/ERRREPT.C, far cdecl */
void REPORT_WARNING(u16 error, ...);   /* diag/WARNREPT.C, far cdecl */

#endif

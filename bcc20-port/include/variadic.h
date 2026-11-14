/* variadic.h: the original's functions with variable arguments (all far cdecl): the
   diagnostic printers REPORT_FATAL, REPORT_ERROR, REPORT_WARNING (diag/) and the console
   printf RTL_DPRINTF (rtl/dprintf.c).  tools/genadapters.py leaves them out of protos.h.
   The originals hand the arguments after the fixed one on as a far pointer into their own
   stack (the cdecl layout), which RTL_DVPRINTF reads: 2 bytes for an int, 4 for a long or a
   far pointer.  The translation does the same with an argument block it lays out in
   scratch memory: each name below is a macro that tags every argument with its DOS size
   (DOS_SIZE: a farptr or any other u32, and a host long, take 4 bytes; everything else is
   an int and takes 2) and passes them to the function's _ARGS form, which takes the block.
   So a long argument must be written with a (long) cast: i32 is the host's int.
   replay/functions.c calls the _ARGS forms when it replays the originals, with the block
   the original had on its stack. */
#ifndef PORT_VARIADIC_H
#define PORT_VARIADIC_H
#include "port.h"

typedef struct {
    u8 size;        /* 2 or 4; 0 ends a list */
    u32 value;
} DosArg;

#define DOS_SIZE(x) _Generic((x), u32: 4, long: 4, unsigned long: 4, long long: 4, unsigned long long: 4, default: 2)
#define DOS_ARG(x) {DOS_SIZE(x), (u32)(x)}
#define DOS_E1(a) DOS_ARG(a)
#define DOS_E2(a, b) DOS_ARG(a), DOS_ARG(b)
#define DOS_E3(a, b, c) DOS_ARG(a), DOS_ARG(b), DOS_ARG(c)
#define DOS_E4(a, b, c, d) DOS_ARG(a), DOS_ARG(b), DOS_ARG(c), DOS_ARG(d)
#define DOS_E5(a, b, c, d, e) DOS_ARG(a), DOS_ARG(b), DOS_ARG(c), DOS_ARG(d), DOS_ARG(e)
#define DOS_E6(a, b, c, d, e, f) DOS_ARG(a), DOS_ARG(b), DOS_ARG(c), DOS_ARG(d), DOS_ARG(e), DOS_ARG(f)
#define DOS_PICK(_1, _2, _3, _4, _5, _6, N, ...) N
#define DOS_EACH(...) DOS_PICK(__VA_ARGS__, DOS_E6, DOS_E5, DOS_E4, DOS_E3, DOS_E2, DOS_E1, -)(__VA_ARGS__)
#define DOS_ARGS(...) ((const DosArg[]){__VA_OPT__(DOS_EACH(__VA_ARGS__), ) {0, 0}})

/* the arguments laid out as the original's cdecl stack had them, in scratch memory (the
   caller marks and releases the scratch area around it) */
farptr dos_argument_block(const DosArg *args);

void REPORT_FATAL_ARGS(i16 error, farptr arguments);     /* diag/fatal.c: stops the compile */
void REPORT_ERROR_ARGS(i16 error, farptr arguments);     /* diag/errrept.c */
void REPORT_WARNING_ARGS(u16 error, farptr arguments);   /* diag/warnrept.c */
void RTL_DPRINTF_ARGS(farptr format, farptr arguments);  /* rtl/dprintf.c */
void report_fatal_v(i16 error, const DosArg *args);
void report_error_v(i16 error, const DosArg *args);
void report_warning_v(u16 error, const DosArg *args);
void rtl_dprintf_v(farptr format, const DosArg *args);

#define REPORT_FATAL(error, ...) report_fatal_v((i16)(error), DOS_ARGS(__VA_ARGS__))
#define REPORT_ERROR(error, ...) report_error_v((i16)(error), DOS_ARGS(__VA_ARGS__))
#define REPORT_WARNING(error, ...) report_warning_v((u16)(error), DOS_ARGS(__VA_ARGS__))
#define RTL_DPRINTF(format, ...) rtl_dprintf_v((farptr)(format), DOS_ARGS(__VA_ARGS__))

#endif

/* explain.h: the compiler explaining its choices (README.md, "Plan", step 6): the register
   variables and the registers the allocator took, values spilled, tails cross-jumping
   merged, loads the peephole pass removed.  EXPLAIN(format, ...) sends one line ("kind
   key=value ...") to the library's explain callback (include/bcc20.h), or to stderr with
   BCC_EXPLAIN set; it reads BCC's memory and never writes it, so the compile is the same.
   Under replay it does nothing. */
#ifndef PORT_EXPLAIN_H
#define PORT_EXPLAIN_H
#ifdef PORT_NATIVE
extern int native_explaining;
void native_explain(const char *format, ...) __attribute__((format(printf, 1, 2)));
const char *explain_symbol(u16 symbol);         /* a front end symbol's name */
const char *explain_registers(u16 mask);        /* "ax,dx" for a register mask */
const char *explain_register(u16 number);
#define EXPLAIN(...) do { if (native_explaining) native_explain(__VA_ARGS__); } while (0)
#else
#define EXPLAIN(...) do { } while (0)
#endif
#endif

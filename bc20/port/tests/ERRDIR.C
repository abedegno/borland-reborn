/* modtest: -ml */
/* modes: -c */
/* #error stops the compile with a fatal error; first a macro called with too many
   arguments.  (Too few would expand the missing one from pool memory this compile never
   wrote, which differs in the native build: README.md, "Decisions".) */
#define PAIR(a, b) ((a) + (b))
int x = PAIR(1, 2, 3);
#if 1
#error stop here
#endif
int y;

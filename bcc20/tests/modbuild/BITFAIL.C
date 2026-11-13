/* modtest: -ml -O -G */
/* Borland C++ 2.0 stops with "Fatal: Register allocation failure" on a post-increment or
   post-decrement of a bitfield reached through a far pointer (the compact, large and huge
   models); the small model, or a global, compiles.  Both compilers must fail alike. */
struct flags { unsigned count : 7; signed level : 4; };
int post(struct flags *f)
{
    return f->count++;
}

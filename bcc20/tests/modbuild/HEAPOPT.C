/* modtest: -ml -#3000 */
/* The hidden -# switch: RARGV0F0 reads it before the memory manager starts and sets the
   heap size in paragraphs, but the option parser then rejects it ("Incorrect command line
   option"), so it cannot shrink the heap of a real compile.  Both compilers must stop alike. */
int f(void) { return 1; }

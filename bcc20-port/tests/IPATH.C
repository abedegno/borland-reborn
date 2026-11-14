/* modtest: -O -G -P +C:\SRC\IPATHU7.CFG */
/* modes: -c */
/* A configuration file named on the command line (IPATHU7.CFG, the shape of Ultima 7's
   U7.CFG) with a long -I list: its directories are kept in the malloc pool, which outgrows
   its first block while the configuration text sits after it.
   The pool is fixed in BCC (FIX_HEAP_NODE_LOW), so the blocks after it move, not the pool;
   IPATH.H is found only through the list's last directory. */
#include "IPATH.H"
int main(void) { return IPATH_FOUND; }

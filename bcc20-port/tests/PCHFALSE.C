/* modtest: -ml -H */
/* modes: -c -c */
/* Precompiled headers: a preamble with conditionals that are false when replayed (#if 0,
   #ifdef and #ifndef), a header that defines data, so the state may not be saved (the
   saved entry is made unloadable), and an #undef, which ends the preamble. */
#ifndef FIRST_GUARD
#define FIRST_GUARD 1
#endif
#include <stdio.h>
#include "PCHDATA.H"
#if 0
#include <math.h>
#endif
#ifdef NOT_DEFINED_ANYWHERE
#include <dos.h>
#endif
#ifndef FIRST_GUARD
#include <alloc.h>
#endif
#undef FIRST_GUARD
int main(void) { return header_data; }

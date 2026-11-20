/* modtest: -ml -H */
/* modes: -c -c */
/* Precompiled headers with a preamble of every kind of directive: #define before the first
   #include, #if, #ifdef, #ifndef, #else and #endif, a header holding #pragma warn, and
   #pragma hdrstop; the second compile loads the saved state. */
#define BEFORE 1
#include <stdio.h>
#if BEFORE
#include <string.h>
#endif
#ifdef BEFORE
#include <stdlib.h>
#else
#include <dos.h>
#endif
#ifndef AFTER
#include "PCHWARN.H"
#endif
#pragma hdrstop
int main(void) { char b[10]; strcpy(b, "x"); printf("%s\n", b); return WARNED; }

/* modtest: -ml */
/* modes: -c */
/* #pragma inline restarts the compile through the assembler (MODE_FALLBACK, then TASM,
   which is not there). */
#pragma inline
int f(int a) { asm mov ax, a; return _AX; }

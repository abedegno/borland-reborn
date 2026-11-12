/* target: RSCMP */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RSCMP (119C:0000..0021): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RSCMP.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: COMPARE_NAME. */
/* Overview: COMPARE_NAME is the C library's strcmp on far strings
   (case matters).  In CPP.EXE it compares identifier names and option
   strings (LEXER, MACROS, PREPROC, CONFIG, OPTIONS).  The loop reads one byte of a (lodsb) and compares it with the byte of b
   (scasb) until they differ or the terminator is reached; the result is
   computed from the last bytes read. */
/* Borland run-time library strcmp with pascal calling
   (COMPARE_NAME): returns the byte difference, sign-extended with cbw
   (wrong sign when the characters differ by more than 127, as in the
   original).
   Written the way Borland wrote these run-time functions (.CAS files): C
   with inline assembly, compiled by Turbo C 2.01.  Turbo C saves SI and DI
   because the inline assembly uses them; the result is left in AX (DX:AX)
   by the assembly and the function falls off its end (documented
   fall-off-end) unless it returns a C value. */
#pragma inline
int far pascal COMPARE_NAME(char far *a,char far *b)
{
    asm cld
    asm push ds
    asm les di,b
    asm lds si,a
compare:
    asm lodsb
    asm scasb
    asm jne differ
    asm or al,al
    asm jne compare
differ:
    asm sub al,es:[di-1]
    asm cbw
    asm pop ds
}

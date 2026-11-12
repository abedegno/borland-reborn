/* target: CODE_33_RSCMP */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: COMPARE_NAME. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: COMPARE_NAME is the C library's strcmp on far strings
   (case matters).  It is used all over the compiler to compare identifier
   names and option strings.  The loop reads one byte of a (lodsb) and compares it with the byte of b
   (scasb) until they differ or the terminator is reached; the result is
   computed from the last bytes read. */
/* CODE_33:0007..0028, Borland run-time library strcmp with pascal calling
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

/* target: CODE_35_RSLEN */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: STRING_LENGTH. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: STRING_LENGTH is the C library's strlen on a far string, and
   is used all over the compiler.  repne scasb counts CX down from FFFFh
   past the terminator, leaving CX = -(length+2); not then dec turns that
   into the length. */
/* CODE_35:0002..001D, Borland run-time library strlen with pascal calling
   (STRING_LENGTH): repne scasb over the far string.
   Written the way Borland wrote these run-time functions (.CAS files): C
   with inline assembly, compiled by Turbo C 2.01.  Turbo C saves SI and DI
   because the inline assembly uses them; the result is left in AX (DX:AX)
   by the assembly and the function falls off its end (documented
   fall-off-end) unless it returns a C value. */
#pragma inline
unsigned far pascal STRING_LENGTH(char far *string)
{
    asm les di,string
    asm mov al,0
    asm mov cx,-1
    asm cld
    asm repne scasb
    asm mov ax,cx
    asm not ax
    asm dec ax
}

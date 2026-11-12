/* target: RMSET */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RMSET (11E5:000C..003A): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RMSET.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: RTL_MEMSET. */
/* Overview: the C library's memset: fills count bytes at destination with
   the low byte of c and returns destination.  It stores one byte if the
   address is odd, then words (the byte doubled in AX), then a last byte
   if one is left.  Used by RTL_STRNCPY (RSCPY.C) and elsewhere in the
   program to clear records. */
/* Borland run-time library memset with pascal calling
   (RTL_MEMSET): word stores after aligning the destination; returns
   the destination.
   Written the way Borland wrote these run-time functions (.CAS files): C
   with inline assembly, compiled by Turbo C 2.01.  Turbo C saves SI and DI
   because the inline assembly uses them; the result is left in AX (DX:AX)
   by the assembly and the function falls off its end (documented
   fall-off-end) unless it returns a C value. */
#pragma inline
void far * far pascal RTL_MEMSET(void far *destination,int c,unsigned count)
{
    asm les di,destination
    asm mov cx,count
    asm mov al,byte ptr c
    asm mov ah,al
    asm cld
    asm test di,1
    asm je aligned
    asm jcxz done
    asm stosb
    asm dec cx
aligned:
    asm shr cx,1
    asm rep stosw
    asm jnc done
    asm stosb
done:
    return destination;
}

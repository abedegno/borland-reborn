/* target: RMMOVE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RMMOVE (11F0:0009..005E): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RMMOVE.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: RTL_MEMMOVE. */
/* Overview: the C library's memmove: copies count bytes and handles
   overlap by copying backward when the source lies below the destination.
   The pointers are compared segment first and then offset, so the choice
   of direction is only right for overlapping blocks that use the same
   segment.  AX holds 1 for a backward copy and 0 for a forward one and is
   used to adjust SI and DI around the word moves.  The return type is
   void here although the C library's memmove returns the destination.
   It is used all over the program to move records and text (the string
   functions in RSCPY.C and RSCAT.C, the lexer, macros, expression pools). */
/* Borland run-time library memmove with pascal calling
   (RTL_MEMMOVE): copies backward when the source is below the
   destination, by words after aligning the destination.  The forward
   jump is written short: TASM would leave a nop after a near one.
   Written the way Borland wrote these run-time functions (.CAS files): C
   with inline assembly, compiled by Turbo C 2.01.  Turbo C saves SI and DI
   because the inline assembly uses them; the result is left in AX (DX:AX)
   by the assembly and the function falls off its end (documented
   fall-off-end) unless it returns a C value. */
#pragma inline
void far pascal RTL_MEMMOVE(void far *destination,void far *source,unsigned count)
{
    asm push ds
    asm mov dx,word ptr source+2
    asm mov ax,word ptr source
    asm cmp dx,word ptr destination+2
    asm ja forward
    asm jc backward
    asm cmp ax,word ptr destination
    asm jnc forward
    /* Backward: set the direction flag; AX = 1.  Forward: clear it; AX = 0. */
backward:
    asm std
    asm mov ax,1
    asm jmp short direction
forward:
    asm cld
    asm xor ax,ax
direction:
    asm lds si,source
    asm les di,destination
    asm mov cx,count
    asm or ax,ax
    asm je aligned_test
    /* Backward copies start at the last byte of each block. */
    asm add si,cx
    asm dec si
    asm add di,cx
    asm dec di
    /* Move one byte first if DI is odd, so the word moves store aligned. */
aligned_test:
    asm test di,1
    asm je aligned
    asm jcxz done
    asm movsb
    asm dec cx
    /* Word moves.  Going backward SI and DI are stepped back one byte so
       each word covers the byte they pointed at and the one below.  An odd
       count (carry from shr) leaves one byte, moved after undoing that
       step. */
aligned:
    asm sub si,ax
    asm sub di,ax
    asm shr cx,1
    asm rep movsw
    asm jnc done
    asm add si,ax
    asm add di,ax
    asm movsb
done:
    asm cld
    asm pop ds
}

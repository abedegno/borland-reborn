/* modtest: -ml */
/* Inline assembler: segment overrides, x87 instructions (emulator fixups), db data, labels
   and jumps. */
int v;
void f(void)
{
    asm mov ax, es:[bx]
    asm mov cs:[si], ax
    asm fld qword ptr ss:[bp-8]
    asm fstp dword ptr ds:v
    asm fwait
    asm db 90h, 0CCh
    asm dw 1234h
    asm jmp short done
done:
    asm nop
}

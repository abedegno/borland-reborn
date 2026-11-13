/* modtest: -ml -O */
/* modes: -S */
/* Inline assembly: registers, memory operands with structure members and locals, labels,
   jumps and pseudo registers. */
struct rec { int a; char b; long c; struct rec *next; };
struct rec records[4];
int asm_test(struct rec *r, int n)
{
    int local = n;
    asm mov bx, word ptr r
    asm mov ax, [bx].a
    asm add ax, local
    asm mov local, ax
    asm les bx, r
    asm mov al, es:[bx].b
    asm cbw
    asm add local, ax
again:
    asm dec n
    asm jnz again
    asm cmp word ptr records, 3
    asm je done
    asm inc word ptr records+2
done:
    _AX = local;
    _BX = _AX + _CX;
    asm push si
    asm pop si
    return _AX + records[1].a;
}

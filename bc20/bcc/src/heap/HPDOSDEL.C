/* target: CODE_2_RH4664 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RH_DOS_DELETE deletes a file (DOS 41h), used for the swap file.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: deletes a file by its far path (int 21h AH=41h), errors
   ignored.  DISCARD_SWAP_BANK uses it to remove a swap file. */
/* Unbuilt real near DOS AH41 wrapper; flags/AX remain hardware outputs. */
#include <dos.h>
static void near pascal RH_DOS_DELETE(void far *address)
{
    asm push ds;
    asm lds dx,dword ptr address;
    _AH=0x41;
    geninterrupt(0x21);
    asm pop ds;
}

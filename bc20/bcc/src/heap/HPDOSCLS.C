/* target: CODE_2_RH4674 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RH_DOS_CLOSE closes a file handle (DOS 3Eh), used for the swap
   file. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: closes a DOS file handle (int 21h AH=3Eh), errors ignored.
   Used for the swap files (DISCARD_SWAP_BANK, SWAP_EXTEND_FILE).  The other
   DOS wrappers are in HPDOSIO.ASM. */
/* Unbuilt real near DOS AH3E wrapper; flags/AX remain hardware outputs. */
#include <dos.h>
static void near pascal RH_DOS_CLOSE(unsigned int handle)
{
    _BX=handle;
    _AH=0x3E;
    geninterrupt(0x21);
}

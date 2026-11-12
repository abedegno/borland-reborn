/* target: CODE_2_RH38C7 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: DISCARD_SWAP_BANK closes and deletes a swap-file bank. Entry
   points: DISCARD_SWAP_BANK. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: closes a swap-file bank's file and deletes it.  A swap bank's
   record keeps the file handle in page_segment and the far pointer to the
   file's path at +34h (where other banks have field52/field54), set by
   INIT_SWAP_BANK.  Called by SWAP_PREPARE_FILE when the file cannot be grown
   and by SHUTDOWN_HEAP_BANKS.  The caller clears the bank's
   HEAP_DESCRIPTOR_SEGMENTS entry when needed. */
/* Complete reconstruction of original0094:38C7..38FB/full52.
   Only the actual DS save/select/restore uses hardware interoperation. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
typedef void far *CleanupAddress;
extern void near pascal RH_DOS_CLOSE(unsigned int handle);
extern void near pascal RH_DOS_DELETE(CleanupAddress address);

void near pascal DISCARD_SWAP_BANK(unsigned int bank)
{
    CleanupAddress address;
    asm push ds;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
    address=*(CleanupAddress near *)&ACTIVE_HEAP.field52;
    RH_DOS_CLOSE(ACTIVE_HEAP.page_segment);
    asm pop ds;
    RH_DOS_DELETE(address);
}

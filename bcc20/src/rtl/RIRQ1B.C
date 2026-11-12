/* target: CODE_1_RIRQ1B */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: BCC's Ctrl-Break handler.  INT 1Bh is the interrupt the BIOS
   keyboard code raises when Ctrl-Break is pressed.  RMAIN13C installs
   CTRL_BREAK_HANDLER_ENTRY as that vector, probably this function (its
   address follows LINE_HOOK in the same segment).  The handler only sets
   CTRL_BREAK_SEEN; LINE_HOOK (RINIT.C) does the real work later, at a safe
   point.  EXIT (REXIT09F.C) puts the old vector back. */
/* DOS INT 1Bh callback. The interrupt attribute preserves the interrupted
   register/DS state and returns through IRET; the handler only sets the flag. */
#include "DATA.H"
static void interrupt RIRQ1B(void)
{
    CTRL_BREAK_SEEN=1;
}

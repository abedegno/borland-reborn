/* rinit.c: from bcc20/src/rtl/RINIT.C and REXIT09F.C.  LINE_HOOK is where BCC stops after a
   Ctrl-Break (the handler only sets CTRL_BREAK_SEEN; the lexer and two long code generator
   loops test it at points where the data is consistent): the Ctrl-C cleanup (RCTRL23), then
   EXIT(100h), whose low byte 0 is the DOS exit code.  EXIT restores the Ctrl-Break vector
   saved at start-up and ends the program through C0_TERMINATE (DOS 4Ch with the status's
   low byte); unlike the C library's exit it runs no atexit functions and flushes nothing. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define SAVED_INT1B_VECTOR D(DSPTR(0x5C9E))

void LINE_HOOK(void)
{
    RCTRL23();
    EXIT(0x100);
}

void EXIT(i16 status)
{
    RVECSET(0x1B, SAVED_INT1B_VECTOR);
    C0_TERMINATE(status);
}

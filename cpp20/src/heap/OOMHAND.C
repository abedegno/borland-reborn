/* target: OOMHAND */
/* opts: -mm -G- -O -Z -p -B -zCCODE5 */
/* link: -zCCODE5 gives this file the code segment it shares with the other files of frame 0485h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module OOMHAND (0485:00BC, image 0x490C): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/OOMHAND.C), with one CPP.EXE edit
   (marked: the cdecl exit). */
/* Role: far-memory heap: out-of-memory callback; frees the name and hash pools, then
   reports "Out of memory" and exits or reports it as fatal. */
/* Overview: the heap's status hook (HEAP_HOOK_CALLSITE, installed by
   INIT_MEMORY_MANAGER through INIT_HEAP).  In CPP.EXE the heap calls it,
   with no arguments, when an allocation finds no room or a handle is bad
   (HEAP_STATUS 1000h or 1002h; see POOLINIT.C, HPALLOCH.C, HPFREEHB.C).
   (BCC.EXE's heap also calls it with a status for a retry, and for swap,
   EMS and extended-memory I/O errors; CPP.EXE's does not.)  This handler
   does not look at the status: it frees the name pool and the hash-chain
   pool to make room for the message and stops the program with "Out of
   memory": an error and exit(1) while SESSION_PHASE is 0, else a fatal
   error.  It never returns to the heap normally. */
#include "DATA.H"
#include "MSG.H"
extern unsigned int NAME_POOL_SEG,HASH_CHAIN_LINK_SEG,SESSION_PHASE;
extern unsigned int far pascal FREE_HANDLE_BLOCK(unsigned int far *);
extern void far cdecl REPORT_ERROR(int,...);
extern void far cdecl REPORT_FATAL(int,...);
/* CPP.EXE edit: CPP.EXE's start-up module exports a cdecl exit (0000:00B1); its argument
   pop is shared with REPORT_FATAL's (the jmp lands on pop cx). BCC calls a pascal EXIT. */
extern void far cdecl exit(int);
/* In BCC.EXE the hook's callers push the status and a domain word; CPP.EXE's
   callers push nothing.  Neither parameter is read here, and the handler
   does not return normally. */
/* link: OUT_OF_MEMORY_HANDLER is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void far cdecl OUT_OF_MEMORY_HANDLER(unsigned int status,unsigned int domain)
{
    FREE_HANDLE_BLOCK(&NAME_POOL_SEG);
    FREE_HANDLE_BLOCK(&HASH_CHAIN_LINK_SEG);
    if(SESSION_PHASE==0) {
        OPTION_ERROR_LIMIT=0;
        REPORT_ERROR(MSG_OUT_MEMORY);
        exit(1);
    } else REPORT_FATAL(MSG_OUT_MEMORY);
}

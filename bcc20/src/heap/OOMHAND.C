/* target: CODE_5_C5CB */
/* opts: -mm -G- -O -Z -p */
/* Role: far-memory heap: out-of-memory callback; frees the name and hash pools, then
   reports "Out of memory" and exits or reports it as fatal. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the heap's status hook (HEAP_HOOK_CALLSITE, installed by
   INIT_MEMORY_MANAGER through INIT_HEAP).  The heap calls it for every
   failure: an allocation that found no room (status 100h, which the
   allocators would retry if the hook returned with HEAP_STATUS 0), a failed
   call (1000h to 1003h) and swap, EMS or extended-memory I/O errors
   (E000h, E001h, E010h, E020h).  This handler does not look at the status:
   it frees the name pool and the hash-chain pool to make room for the
   message and stops the compiler with "Out of memory": an error and exit(1)
   while SESSION_PHASE is 0, else a fatal error.  It never returns to the
   heap normally, so the heap's retry paths are not used in BCC. */
#include "DATA.H"
#include "MSG.H"
extern unsigned int NAME_POOL_SEG,HASH_CHAIN_LINK_SEG,SESSION_PHASE;
extern unsigned int far pascal FREE_HANDLE_BLOCK(unsigned int far *);
extern void far cdecl REPORT_ERROR(int,...);
extern void far cdecl REPORT_FATAL(int,...);
extern void far pascal EXIT(int);
/* Actual hook callsites pass status first on the stack, followed by domain.
   Neither value is inspected by this callback. Its error paths do not return
   normally through the allocator hook's wider stack contract. */
static void far cdecl OUT_OF_MEMORY_HANDLER(unsigned int status,unsigned int domain)
{
    FREE_HANDLE_BLOCK(&NAME_POOL_SEG);
    FREE_HANDLE_BLOCK(&HASH_CHAIN_LINK_SEG);
    if(SESSION_PHASE==0) {
        OPTION_ERROR_LIMIT=0;
        REPORT_ERROR(MSG_OUT_MEMORY);
        EXIT(1);
    } else REPORT_FATAL(MSG_OUT_MEMORY);
}

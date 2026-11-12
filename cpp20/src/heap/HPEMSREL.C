/* target: HPEMSREL */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPEMSREL (image 0x28A6..0x28B0, 0054:2366): RELEASE_EMS_BANK, source
   taken unchanged from the BCC.EXE reconstruction
   (bcc20/src/heap/HPEMSREL.C).  It was first matched as the tail of
   EMSINIT.  Compiler: Borland C++ 2.0, which builds the standard frame
   (push bp; mov bp,sp ... pop bp, image 28A6) for a function without arguments or
   locals; Turbo C 2.01, which compiled INIT_EMS_BANK before it, leaves the frame out
   (tried: 6 bytes, call far; ret). */
/* Role: far-memory heap: RELEASE_EMS_BANK frees the EMS bank's handle. */
/* Overview: at exit (SHUTDOWN_HEAP_BANKS) frees the EMS bank's pages
   through FREE_EMS_HANDLE (OVREXMEM.ASM, BCC's overlay EMS code).  The
   result is ignored. */
extern void far pascal FREE_EMS_HANDLE(void);

/* link: RELEASE_EMS_BANK is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal RELEASE_EMS_BANK(void)
{
    FREE_EMS_HANDLE();
}

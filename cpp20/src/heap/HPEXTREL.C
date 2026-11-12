/* target: HPEXTREL */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPEXTREL (image 0x2AF4..0x2AFE, 0054:25B4): RH_CALL_EXT_RELEASE,
   source taken unchanged from the BCC.EXE reconstruction
   (bcc20/src/heap/HPEXTREL.C).  It was first matched as the tail of
   EXTINIT.  Compiler: Borland C++ 2.0, which builds the standard frame
   (push bp; mov bp,sp ... pop bp, image 2AF4) for a function without arguments or
   locals; Turbo C 2.01, which compiled INIT_EXT_BANK before it, leaves the frame out
   (tried: 6 bytes, call far; ret). */
/* Role: far-memory heap: RH_CALL_EXT_RELEASE releases the extended-memory bank through
   OVR_RELEASE_EXT_MEMORY (OVREXMEM.ASM, BCC's overlay extended-memory code). */
/* Overview: at exit (SHUTDOWN_HEAP_BANKS) gives the extended-memory bank
   back.  The result is ignored. */
extern void far pascal OVR_RELEASE_EXT_MEMORY(void);

/* link: RH_CALL_EXT_RELEASE is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal RH_CALL_EXT_RELEASE(void)
{
    OVR_RELEASE_EXT_MEMORY();
}

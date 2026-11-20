/* target: HPSTUBIO */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPSTUBIO (image 0x3154..0x3156, the end of the heap frame 0054h):
   two empty functions, a bare ret and a bare retf.  Turbo C 2.01 compiles an empty
   function to just that (Borland C++ 2.0 would give it a push bp / mov bp,sp frame, as
   in the stub before it, HPSTUBOV.C).  BCC.EXE has its stub RH_SELF_CALL_BEFORE_DOS_IO
   (heap/HPSTUBIO.C, a self-calling stub) at this place, followed by the heap's DOS file
   I/O, which CPP.EXE does not have; so the near one takes BCC's name.  Nothing in
   CPP.EXE calls either; the far one has no counterpart in BCC.EXE; its name is descriptive. */
static void near pascal RH_SELF_CALL_BEFORE_DOS_IO(void)
{
}

static void far pascal RH_EMPTY_FAR_STUB(void)
{
}

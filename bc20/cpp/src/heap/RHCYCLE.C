/* target: RHCYCLE */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHCYCLE: the stub at the start of the first heap module (image
   0x54C, frame 0054h). BCC.EXE has the same stub at the start of CODE_2 (heap/RHCYCLE.C),
   where it calls itself; CPP.EXE edit: CPP's is empty (55 8B EC 5D C3: push bp, mov bp,sp,
   pop bp, ret), and every CPP heap module starts with one. Nothing calls it. */
static void near pascal RHCYCLE(void)
{
}

/* target: HPSTUBEM */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPSTUBEM (image 0x28B0..0x28B5): an empty stub.  BCC.EXE has a
   stub at the same place in the heap (RH_SELF_CALL_AFTER_EMS_BANK, heap/HPSTUBEM.C, after the EMS bank), where it calls itself;
   CPP.EXE edit: CPP's is empty (55 8B EC 5D C3: push bp, mov bp,sp, pop bp, ret).
   A file of its own, compiled by Borland C++ 2.0: the heap files around it are Turbo C
   2.01 objects, and Turbo C 2.01 compiles an empty function to a bare ret, without the
   frame, where BC 2.0 gives the frame (as RHCYCLE.C at 0x54C).  Nothing calls it. */
static void near pascal RH_SELF_CALL_AFTER_EMS_BANK(void)
{
}

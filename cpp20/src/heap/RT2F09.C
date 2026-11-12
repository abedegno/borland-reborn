/* target: RT2F09 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RT2F09 (0054:1CD2, image 0x2212): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RT2F09.C); its code is the
   same in both programs. */
/* Role: far-memory heap: far wrapper that resolves a heap handle word to its bank and node.
   Entry points: RESOLVE_HANDLE_FAR. */
/* Overview: far wrapper of BCC_POOL_RESOLVE_WORD (HPDISP.C) for code outside
   the heap's code segment (frame 0054h): resolves a heap handle word to its
   bank (returned) and node offset (stored through offset). */
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,unsigned int far *offset);
unsigned int far pascal _loadds RESOLVE_HANDLE_FAR(unsigned int handle,unsigned int far *offset)
{
    return BCC_POOL_RESOLVE_WORD(handle,offset);
}

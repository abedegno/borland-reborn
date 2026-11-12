/* target: RTOUPPER */
/* opts: -mm -G -O -Z -r- -p -zCCODE36 */
/* link: -zCCODE36 gives this file the code segment it shares with the other files of frame 11A6h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RTOUPPER (11A6:002A..004E): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RTOUPPER.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: RTL_TOUPPER. */
/* Overview: RTL_TOUPPER is the C library's toupper.  _CTYPE is the
   library's character class table, indexed by the character plus 1 (entry
   0 is for EOF); the bit with value 8 (_IS_LOW) marks a lower-case letter, which is changed by
   subtracting 32.  Only the low byte of value is used, so EOF (-1) comes
   back as 255.  The caller is RTL_STRUPR, which CPP.EXE has in
   driver/CPPMAIN.C (BCC.EXE has it in RSTRLOW.C). */
extern unsigned char _CTYPE[];
unsigned int far pascal RTL_TOUPPER(int value)
{
    if(_CTYPE[(unsigned char)value+1]&8) return (unsigned char)value-32;
    return (unsigned char)value;
}

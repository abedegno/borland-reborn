/* target: LDISNAN */
/* opts: -mm -G -O- -Z -r- -p -zCCODE9 */
/* link: -zCCODE9 gives this file the code segment it shares with the other files of frame 1076h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module LDISNAN (1076:0024..0067): source taken unchanged from the BCC.EXE
   reconstruction (src/float/LDISNAN.C); its code is the same in both programs. */
/* Role: run-time library: BCC_EXTENDED_HAS_PAYLOAD tests whether an 80-bit real is a NaN
   (exponent 7FFFh with a mantissa other than infinity's). Entry points:
   BCC_EXTENDED_HAS_PAYLOAD. */
/* Overview: a NaN test for the long double (80-bit) arithmetic in
   float/LDARITH.ASM, close to the C99 isnan.  Its only caller is the
   multiply routine there, which needs to tell a NaN operand from an
   infinity.  record points at an operand in the unpacked work format made
   by RTL_LDOUBLE_UNPACK (LDUNPACK.ASM): the four mantissa words from low
   to high, then the exponent with the sign bit already removed (so the
   comparison with 7FFFh is not upset by the sign), then a sign word that
   ExtendedWords leaves out.  An exponent of 7FFFh with any mantissa other
   than 8000 0000 0000 0000h (the explicit integer bit alone, which is
   infinity) counts as a NaN, including forms with the integer bit clear.
   Returns 1 for a NaN, else 0.  Built with -O- (see the opts line). */
typedef struct {
    unsigned int low,lower,middle,high,exponent;
} ExtendedWords;
int near pascal BCC_EXTENDED_HAS_PAYLOAD(ExtendedWords far *record)
{
    return record->exponent==0x7fff &&
        (record->high!=0x8000 || record->low || record->lower || record->middle);
}

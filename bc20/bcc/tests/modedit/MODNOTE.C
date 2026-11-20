/* opts: -mm -G -O -Z -p */
/* link: with RMAIN13C */
/* Role: test of the modding build (tools/modedits.py): a new source file in the resident
   code, joining RMAIN13C's code segment, with data of its own.  MOD_NOTE only counts its
   calls and mixes their values into its own table, so BCC's output does not change. */
static unsigned int note_count;                 /* zeroed data (_BSS) */
static unsigned int note_mix[4] = { 1, 2, 3, 4 };   /* initialised data (_DATA) */

void far pascal MOD_NOTE(unsigned int value)
{
    ++note_count;
    note_mix[note_count & 3] ^= value;
}

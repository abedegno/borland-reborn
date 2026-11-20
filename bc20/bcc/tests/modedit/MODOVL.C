/* opts: -mm -O -Z -p -Y */
/* link: with NAMEPOOL */
/* Role: test of the modding build (tools/modedits.py): a new source file in an overlay,
   NAMEPOOL's, with data of its own.  MOD_OVL_NOTE only counts its calls and keeps the
   largest value, so BCC's output does not change. */
static unsigned int ovl_count;                  /* zeroed data (_BSS) */
static unsigned int ovl_largest = 7;            /* initialised data (_DATA) */

void far pascal MOD_OVL_NOTE(unsigned int value)
{
    ++ovl_count;
    if(value > ovl_largest) ovl_largest = value;
}

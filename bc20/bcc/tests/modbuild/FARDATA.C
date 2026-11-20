/* modtest: -ml -O -G */
/* Far and huge arrays in the large model: each gets data segments of its own, written
   segment by segment (HUGEDATA.C), including one over 64 KB and one whose element size is
   not a power of two. */
char far far_bytes[1000];
int far far_ints[5] = { 1, 2, 3, 4, 5 };
char huge huge_bytes[70000L];
struct three { char c[3]; } huge huge_odd[25000];
static long far static_far[4] = { 10, 20 };
long use_far(int i)
{
    static char far local_far[16] = "local";
    return far_bytes[i] + far_ints[i % 5] + huge_bytes[i * 10L] + huge_odd[i].c[2]
        + static_far[i & 3] + local_far[i & 15];
}

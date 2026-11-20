/* modtest: -mh -O -G */
/* Huge model: far data per module, huge pointers and their arithmetic. */
char huge *big;
long huge table[1000];
static int counter;
int count_huge(char huge *p, long n)
{
    long i;
    int sum = 0;
    for (i = 0; i < n; i++)
        sum += p[i];
    big = p + n;
    table[n % 1000] = sum;
    counter++;
    return sum + (int)(big - p) + counter;
}
long diff(int huge *a, int huge *b) { return b - a; }
int far *farp(int far *p, int n) { return p + n; }

/* objects bigger than 64 KB, and initialised far data, written segment by segment */
char huge big_array[100000L];
struct three { char c[3]; } huge odd_array[30000];     /* 90000 bytes: padded in front */
long huge huge_init[4] = { 1, 2, 3, 4 };
int far far_init[6] = { 1, 2, 3, 4, 5, 6 };
char far far_text[] = "far initialised text";
long sum_big(long i) { return big_array[i] + odd_array[i % 30000].c[1] + huge_init[i & 3] + far_init[i % 6]; }

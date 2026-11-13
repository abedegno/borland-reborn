/* modtest: -ml -O -G */
/* Initialisers: nested aggregates, arrays of structures, strings, unions, addresses of
   statics and functions, partial and brace-elided lists, and automatic aggregates. */
struct inner { char c; int i; long l; };
struct outer { struct inner in[2]; char name[8]; int *p; int (*fn)(int); };
union u { int i; char c[4]; };
static int number = 5;
static int square(int x) { return x * x; }
struct outer one = { { { 'a', 1, 2L }, { 'b', 3, 4L } }, "outer", &number, square };
struct outer two[] = { { 'c', 5, 6L, 'd', 7, 8L, "two", 0, 0 }, { { { 'e' } } } };
union u un = { 0x1234 };
char text[] = "a string";
char *texts[] = { "one", "two", "three", 0 };
int grid[3][4] = { { 1, 2 }, { 3 }, { 4, 5, 6, 7 } };
long longs[5] = { 1, -2, 3L << 20 };
float floats[] = { 1.5f, 2.25f, -3.0f };
double doubles[3] = { 1e10, 2.5e-3 };
unsigned char bytes[] = { 255, 0x80, 'z' };
struct { int a; struct { int b, c; } s; int d[2]; } anon = { 1, 2, 3, 4, 5 };
char far *far_text = "far text";
int *int_ptrs[] = { &number, &grid[1][0], (int *)&longs[2] };

int automatic(int v)
{
    struct inner local = { 'x', 10, 20L };
    int arr[4] = { 1, 2, 3 };
    char word[] = "local";
    struct outer big = { { { 'q', 1, 2 } }, "big", &number, square };
    static int counter = 3;
    counter += v;
    return local.i + arr[v & 3] + word[v & 3] + big.fn(big.in[0].i) + counter;
}

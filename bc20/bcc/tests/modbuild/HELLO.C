#include <stdio.h>
#include <string.h>
struct point { int x, y; };
static int table[] = { 1, 2, 3, 5, 8, 13 };
long total(struct point *p, int n)
{
    long t = 0;
    int i;
    for (i = 0; i < n; i++)
        t += (long)p[i].x * p[i].y + table[i % 6];
    switch (n) {
    case 0: return -1;
    case 1: case 2: t <<= 1; break;
    case 7: t ^= 0x55; break;
    default: t--;
    }
    return t;
}
int main(int argc, char **argv)
{
    struct point pts[4] = { {1, 2}, {3, 4}, {5, 6}, {7, 8} };
    char buf[40];
    strcpy(buf, argc > 1 ? argv[1] : "none");
    printf("%s %ld %f\n", buf, total(pts, 4), 3.5 * argc);
    return 0;
}

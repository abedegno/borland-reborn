/* modtest: -ml -w */
/* Diagnostics in C, all warnings on: type mismatches the messages spell out, suspicious
   conversions, unused and undefined names, unreachable code. */
struct s { int a; };
struct t { long b; };
int f(int, char *);
int g(void);
long values[3];
int test(int x, char *p, struct s *sp)
{
    int unused;
    struct t *tp = sp;
    char c = p;
    int *ip = values;
    long l = sp;
    x = f(p, x);
    x = f(1);
    x = g(2);
    x = sp->b;
    x = undefined_name + 1;
    if (x = 3) p++;
    return;
    x++;
}
void v(void) { return 1; }
int h(int a) { if (a) return 1; }

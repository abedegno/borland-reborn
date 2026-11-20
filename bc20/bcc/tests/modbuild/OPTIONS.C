/* modtest: -mc -1 -a -d -k- -N -r- -u- -K -Z- -O- -G- -zCMYCODE -zDMYDATA -DDEFINED=3 -UNONE -i12 -g3 -j4 -w-par */
/* Many switches at once: compact model, 186 code, word alignment, merged strings, no
   standard frame, stack checks, no register variables, no underscores, unsigned chars,
   segment names, macros, identifier length and diagnostic limits. */
static char a1[] = "duplicate", a2[] = "duplicate";
char *s1 = "merged", *s2 = "merged";
struct odd { char c; int i; char d; long l; } odd_one;
int very_long_identifier_one, very_long_identifier_two;
int sum(int n, char c)
{
    int i, t = DEFINED;
    for (i = 0; i < n; i++) t += c + i;
    return t + odd_one.i + s1[0] + s2[1];
}

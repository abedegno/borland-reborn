/* modtest: -mt -2 -p -r -O -G -Z -k -y -A -C -w -DDEFINED=4 */
/* Other switches: tiny model, 286 code, Pascal calls, register variables, line
   numbers, ANSI keywords only, nested comments. */
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

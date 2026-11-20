/* target: STUBS */
/* opts: -mc -O -Z */
/* STUBS.C: three empty functions, linked straight after the startup code.
 *
 * TLIB.EXE has three bytes, three RETs, between C0's code and the first of TLIB's own,
 * which nothing calls. Empty functions compiled by Turbo C 2.01 are exactly that. Such
 * stubs were the usual way to keep the library's argv and environment set-up out of a
 * program that reads its command line itself, as TLIB does; which three functions they
 * were is not known, and these names are guesses. */
void _setargv(void)
{
}

void _setenvp(void)
{
}

int matherr(void)
{
}

/* modtest: -ml -O -r */
/* #pragma option with "." (keep the current value of an option past the end of the
   compile) and #pragma warn switches. */
#pragma option -O. -r. -A. -f.
#pragma warn -rch
#pragma warn .rch
int f(int a) { return a * 3; }

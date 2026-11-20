/* modtest: -A -ml */
/* modes: -c */
/* Strict ANSI mode: malformed pragmas are ignored silently; a floating constant out of
   range is an error; // is not a comment. */
#pragma warn xyz
#pragma startup 3
#pragma option -zzzz
double huge_value = 1e5000;
long double huger = 1e9999L;
int x = 1 // 2
    ;

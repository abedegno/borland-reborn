/* modtest: -ml -H -O */
/* modes: -c -c */
/* Precompiled headers (-H): the first compile writes TCDEF.SYM, the second reads it. */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main(int argc, char **argv)
{
    char buffer[40];
    strcpy(buffer, argc > 1 ? argv[1] : "none");
    printf("%s %d\n", buffer, atoi(buffer));
    return 0;
}

/* target: CODE_27_RGETENV */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library: getenv (Turbo C 2.01), finds a variable in the DOS environment
   and returns a far pointer to its value. Entry points: RTL_GETENV. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's getenv.  The DOS environment block at
   ENVIRONMENT_SEG:0 is a list of "NAME=value" strings ending with an empty
   string.  For each entry the name is compared character by character
   (case matters); on a match the value is copied into the static buffer
   ENV_BUFFER and a pointer to that buffer is returned, so each call
   overwrites the previous result.  RTL_SEARCHPATH (SEARCHP.C) uses it to
   read PATH. */
/* Segment 0A8E:0006..0098, Borland run-time library getenv with pascal
   calling (Turbo C 2.01).  Walks the environment block for "name=" and
   copies the value to a static buffer; returns the buffer or NULL. */
#include <dos.h>
extern unsigned int ENVIRONMENT_SEG;         /* DS:0014, environment segment */
extern char near ENV_BUFFER[];          /* DS:8B4E */

char far * far pascal RTL_GETENV(char far *name)
{
    char far *environment;
    char far *wanted;
    register char *copy;
    environment=MK_FP(ENVIRONMENT_SEG,0);
    while(*environment) {
        wanted=name;
        while(*wanted==*environment) {
            wanted++;
            environment++;
        }
        if(*wanted==0 && *environment=='=') {
            environment++;
            copy=ENV_BUFFER;
            while(*environment) *copy++=*environment++;
            *copy=0;
            return ENV_BUFFER;
        }
        /* No match: skip the rest of this entry and its terminator. */
        while(*environment) environment++;
        environment++;
    }
    return 0;
}

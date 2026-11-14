/* rgetenv.c: from bcc20/src/rtl/RGETENV.C: getenv (Turbo C 2.01).  The DOS environment
   block at ENVIRONMENT_SEG:0 is a list of "NAME=value" strings ending with an empty string.
   Each entry's name is compared character by character (case matters); on a match the
   value is copied into the static buffer ENV_BUFFER and a pointer to it is returned, so
   each call overwrites the previous result.  RTL_SEARCHPATH (searchp.c) uses it to read
   PATH.  Returns 0 for a name that is not there. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define ENVIRONMENT_SEG W(ENVIRONMENT_SEG_P)

farptr RTL_GETENV(farptr name)
{
    farptr environment = MK_FP(ENVIRONMENT_SEG, 0);
    while (SB(environment)) {
        farptr wanted = name;
        while (SB(wanted) == SB(environment)) {
            wanted = fp_add(wanted, 1);
            environment = fp_add(environment, 1);
        }
        if (SB(wanted) == 0 && SB(environment) == '=') {
            environment = fp_add(environment, 1);
            farptr copy = ENV_BUFFER_P;
            while (SB(environment)) {
                B(copy) = B(environment);
                copy = fp_add(copy, 1);
                environment = fp_add(environment, 1);
            }
            B(copy) = 0;
            return ENV_BUFFER_P;
        }
        /* no match: skip the rest of this entry and its terminator */
        while (SB(environment))
            environment = fp_add(environment, 1);
        environment = fp_add(environment, 1);
    }
    return 0;
}

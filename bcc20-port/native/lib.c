/* lib.c: bcc20_compile and bcc20_free (include/bcc20.h), the library call around one run of
   BCC (native.c): the job's files go into native.c's memory files, the run's own memory is
   set up afresh, and what it wrote and printed comes back in the result. */
#include <stdlib.h>
#include <string.h>
#include "native.h"

int bcc20_compile(const bcc20_job *job, bcc20_result *result)
{
    const char **argv = malloc((size_t)(job->argc + 2) * sizeof *argv);
    argv[0] = "BCC.EXE";
    for (int i = 0; i < job->argc; i++)
        argv[i + 1] = job->argv[i];
    argv[job->argc + 1] = 0;
    memset(result, 0, sizeof *result);
    if (native_job_begin(job) != 0) {           /* more files than BCC20_MAX_FILES */
        free(argv);
        result->status = -1;
        return -1;
    }
    int status = native_run(job->argc + 1, argv);
    native_job_end(result);
    result->status = status;
    free(argv);
    return status;
}

void bcc20_free(bcc20_result *result)
{
    for (int i = 0; i < result->n_outputs; i++) {
        free((void *)result->outputs[i].name);
        free((void *)result->outputs[i].data);
    }
    free(result->outputs);
    free(result->console);
    memset(result, 0, sizeof *result);
}

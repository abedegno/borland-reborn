/* bcc20run: runs one BCC command line through the library (include/bcc20.h), for testing
   it against build/bcc (tools/nativetest.py --lib).

     bcc20run [--file NAME[=PATH]]... [--root DIR] [--time SECONDS] [--repeat N] -- ARGS...

   Each --file is given to BCC from memory under its DOS name (read from PATH, default the
   host file NAME); other files come from --root.  The files BCC wrote are written to the
   current directory under their names, its console text to stdout, and its exit status is
   bcc20run's.  --repeat N runs the same job N times in this one process and fails unless
   every run gives the same output, which shows that runs do not share state. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bcc20.h"

static void *read_file(const char *path, size_t *size)
{
    FILE *f = fopen(path, "rb");
    if (!f) {
        perror(path);
        exit(2);
    }
    fseek(f, 0, SEEK_END);
    *size = (size_t)ftell(f);
    fseek(f, 0, SEEK_SET);
    void *data = malloc(*size + 1);
    if (fread(data, 1, *size, f) != *size) {
        perror(path);
        exit(2);
    }
    fclose(f);
    return data;
}

static int same(const bcc20_result *a, const bcc20_result *b)
{
    if (a->status != b->status || a->console_size != b->console_size ||
        memcmp(a->console, b->console, a->console_size) || a->n_outputs != b->n_outputs)
        return 0;
    for (int i = 0; i < a->n_outputs; i++)
        if (strcmp(a->outputs[i].name, b->outputs[i].name) || a->outputs[i].size != b->outputs[i].size ||
            memcmp(a->outputs[i].data, b->outputs[i].data, a->outputs[i].size))
            return 0;
    return 1;
}

int main(int argc, char **argv)
{
    bcc20_file files[64];
    int n_files = 0, repeat = 1, i = 1;
    bcc20_job job = {0};
    job.stack_limit = 1;
    for (; i < argc && strcmp(argv[i], "--"); i++) {
        if (!strcmp(argv[i], "--file") && i + 1 < argc && n_files < 64) {
            char *spec = argv[++i], *eq = strchr(spec, '=');
            const char *path = eq ? eq + 1 : spec;
            if (eq)
                *eq = 0;
            files[n_files].name = spec;
            files[n_files].data = read_file(path, &files[n_files].size);
            n_files++;
        } else if (!strcmp(argv[i], "--root") && i + 1 < argc)
            job.root = argv[++i];
        else if (!strcmp(argv[i], "--time") && i + 1 < argc)
            job.time = atoll(argv[++i]);
        else if (!strcmp(argv[i], "--repeat") && i + 1 < argc)
            repeat = atoi(argv[++i]);
        else if (!strcmp(argv[i], "--no-stack-limit"))
            job.stack_limit = 0;
        else {
            fprintf(stderr, "bcc20run: unknown option %s\n", argv[i]);
            return 2;
        }
    }
    if (i < argc)
        i++;
    job.argc = argc - i;
    job.argv = (const char *const *)argv + i;
    job.files = files;
    job.n_files = n_files;
    bcc20_result first, again;
    bcc20_compile(&job, &first);
    for (int r = 1; r < repeat; r++) {
        bcc20_compile(&job, &again);
        int ok = same(&first, &again);
        bcc20_free(&again);
        if (!ok) {
            fprintf(stderr, "bcc20run: run %d of the same job gave other output\n", r + 1);
            return 3;
        }
    }
    fwrite(first.console, 1, first.console_size, stdout);
    for (int k = 0; k < first.n_outputs; k++) {
        FILE *f = fopen(first.outputs[k].name, "wb");
        if (!f || fwrite(first.outputs[k].data, 1, first.outputs[k].size, f) != first.outputs[k].size) {
            perror(first.outputs[k].name);
            return 2;
        }
        fclose(f);
    }
    int status = first.status;
    bcc20_free(&first);
    return status;
}

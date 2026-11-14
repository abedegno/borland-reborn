/* bcc20run: runs one BCC command line through the library (include/bcc20.h), for testing
   it against build/bcc (tools/nativetest.py --lib).

     bcc20run [--file NAME[=PATH]]... [--root DIR] [--time SECONDS] [--repeat N]
              [--explain PATH] [--no-stack-limit] -- ARGS...

   Each --file is given to BCC from memory under its DOS name (read from PATH, default the
   host file NAME); other files come from --root.  The files BCC wrote are written to the
   current directory under their names, its console text to stdout, and its exit status is
   bcc20run's.  --repeat N runs the same job N times in this one process and fails unless
   every run gives the same output, which shows that runs do not share state.  --explain
   writes the compiler's explanation of its choices (include/explain.h) to PATH.

     bcc20run --serve

   runs jobs read from stdin and writes their results to stdout, until QUIT or the end of
   stdin, so that a client keeps compilers running (one process per core it wants busy) and
   sends each job without starting a process.  Every message is a line "TAG N..." (decimal
   numbers) followed by the bytes the numbers count:

     ROOT len            path        the root for the jobs that follow (len 0: none)
     KEEP namelen len    name data   a file every later job holds (headers sent once); the
                                     same name again replaces it
     FORGET                          drops the kept files
     TIME seconds                    the clock and the files' times (0: the host's)
     STACK 0|1                       BCC.EXE's stack limit off or on (on to start with)
     EXPLAIN 0|1                     the compiler's explanation with each result
     ARG len             text        the next BCC argument of the job
     FILE namelen len    name data   a file of this job only (it hides a kept one)
     RUN                             compiles the job, answers, and starts an empty one
     PAUSE len           name        a snapshot (POSIX hosts): RUN then stops BCC when it
                                     first opens a file of that name, answers PAUSED, and
                                     keeps the paused compiler; each variant is FILE records
                                     then RESUME, which finishes a copy of the paused compile
                                     with those files (the paused name among them) and
                                     answers as RUN does; RELEASE ends the paused compile,
                                     answered as RUN (status 255).  PAUSE 0 stops pausing.
     QUIT

   The answer to RUN is STATUS n, CONSOLE len + text, one OUTPUT namelen len + name data
   per file BCC wrote, EXPLAIN len + text when asked for, then DONE.  A malformed message
   is answered with ERROR len + text and ends the server (status 2). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bcc20.h"
#ifndef _WIN32
#include <sys/wait.h>
#include <unistd.h>
#endif
#ifdef _WIN32
#include <fcntl.h>
#include <io.h>
#endif

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

/* ---- server mode ---- */
typedef struct { char *name; void *data; size_t size; } Held;
typedef struct { char *text; size_t size, capacity; } Text;

static void text_add(Text *t, const char *s, size_t n)
{
    if (t->size + n > t->capacity) {
        t->capacity = (t->size + n) * 2 + 256;
        t->text = realloc(t->text, t->capacity);
    }
    memcpy(t->text + t->size, s, n);
    t->size += n;
}

static void serve_explain(void *context, const char *line)
{
    text_add((Text *)context, line, strlen(line));
    text_add((Text *)context, "\n", 1);
}

static void fail(const char *message)
{
    printf("ERROR %zu\n%s", strlen(message), message);
    fflush(stdout);
    exit(2);
}

static void *read_bytes(size_t n)
{
    char *data = malloc(n + 1);
    if (n && fread(data, 1, n, stdin) != n)
        fail("message cut short");
    data[n] = 0;
    return data;
}

/* the paused compiler (PAUSE): copies of it finish each variant */
static int in_child;

static void paused(void *context)
{
    (void)context;
#ifdef _WIN32
    fail("no snapshot on this host");
#else
    char line[256];
    Held variant[64];
    int n = 0;
    printf("PAUSED\n");
    fflush(stdout);
    while (fgets(line, sizeof line, stdin)) {
        char tag[16];
        unsigned long long a = 0, b = 0;
        int got = sscanf(line, "%15s %llu %llu", tag, &a, &b);
        if (got == 3 && !strcmp(tag, "FILE")) {
            if (n == 64)
                fail("more than 64 files in a variant");
            variant[n].name = read_bytes((size_t)a);
            variant[n].data = read_bytes((size_t)b);
            variant[n].size = (size_t)b;
            n++;
        } else if (got >= 1 && !strcmp(tag, "RESUME")) {
            fflush(stdout);
            pid_t child = fork();
            if (child < 0)
                fail("fork failed");
            if (child == 0) {           /* the copy: the variant's files, then on with the run */
                in_child = 1;
                for (int k = 0; k < n; k++)
                    if (bcc20_add_file(variant[k].name, variant[k].data, variant[k].size))
                        fail("no room for the variant's files");
                return;
            }
            int status;
            waitpid(child, &status, 0);
            if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
                fail("a variant's compile crashed");
            for (int k = 0; k < n; k++) {
                free(variant[k].name);
                free(variant[k].data);
            }
            n = 0;
        } else if (got >= 1 && !strcmp(tag, "RELEASE"))
            bcc20_abandon();
        else
            fail("only FILE, RESUME and RELEASE while paused");
    }
    exit(0);
#endif
}

static int serve(void)
{
    Held kept[BCC20_MAX_FILES], files[BCC20_MAX_FILES];
    int n_kept = 0, n_files = 0, n_args = 0;
    char *args[256], *root = 0, line[256];
    long long time = 0;
    int stack_limit = 1, explain = 0;
#ifdef _WIN32
    _setmode(_fileno(stdin), _O_BINARY);
#endif
    while (fgets(line, sizeof line, stdin)) {
        char tag[16];
        unsigned long long a = 0, b = 0;
        int got = sscanf(line, "%15s %llu %llu", tag, &a, &b);
        if (got < 1)
            fail("empty message");
        if (!strcmp(tag, "QUIT"))
            break;
        else if (!strcmp(tag, "ROOT") && got == 2) {
            free(root);
            root = a ? read_bytes((size_t)a) : 0;
        } else if ((!strcmp(tag, "KEEP") || !strcmp(tag, "FILE")) && got == 3) {
            int keep = tag[0] == 'K';
            Held h = {read_bytes((size_t)a), read_bytes((size_t)b), (size_t)b};
            Held *list = keep ? kept : files;
            int *n = keep ? &n_kept : &n_files, k;
            for (k = 0; k < *n && strcmp(list[k].name, h.name); k++)
                ;
            if (k < *n) {
                free(list[k].name);
                free(list[k].data);
            } else if (*n + 1 + (keep ? n_files : n_kept) > BCC20_MAX_FILES)
                fail("more files than BCC20_MAX_FILES");
            else
                (*n)++;
            list[k] = h;
        } else if (!strcmp(tag, "FORGET")) {
            for (int k = 0; k < n_kept; k++) {
                free(kept[k].name);
                free(kept[k].data);
            }
            n_kept = 0;
        } else if (!strcmp(tag, "TIME") && got == 2)
            time = (long long)a;
        else if (!strcmp(tag, "STACK") && got == 2)
            stack_limit = a != 0;
        else if (!strcmp(tag, "EXPLAIN") && got == 2)
            explain = a != 0;
        else if (!strcmp(tag, "PAUSE") && got == 2) {
            static char *pause_name;
            free(pause_name);
            pause_name = a ? read_bytes((size_t)a) : 0;
            bcc20_pause_at(pause_name, paused, 0);
        }
        else if (!strcmp(tag, "ARG") && got == 2) {
            if (n_args == 256)
                fail("more than 256 arguments");
            args[n_args++] = read_bytes((size_t)a);
        } else if (!strcmp(tag, "RUN")) {
            /* the job's own files first: BCC takes the first of a name */
            bcc20_file *all = malloc(sizeof *all * (size_t)(n_files + n_kept + 1));
            int n = 0;
            for (int k = 0; k < n_files; k++)
                all[n++] = (bcc20_file){files[k].name, files[k].data, files[k].size};
            for (int k = 0; k < n_kept; k++)
                all[n++] = (bcc20_file){kept[k].name, kept[k].data, kept[k].size};
            Text explained = {0};
            bcc20_job job = {0};
            job.argc = n_args;
            job.argv = (const char *const *)args;
            job.files = all;
            job.n_files = n;
            job.root = root;
            job.time = time;
            job.stack_limit = stack_limit;
            if (explain) {
                job.explain = serve_explain;
                job.explain_context = &explained;
            }
            bcc20_result result;
            bcc20_compile(&job, &result);
            printf("STATUS %d\nCONSOLE %zu\n", result.status, result.console_size);
            fwrite(result.console, 1, result.console_size, stdout);
            for (int k = 0; k < result.n_outputs; k++) {
                printf("OUTPUT %zu %zu\n%s", strlen(result.outputs[k].name), result.outputs[k].size,
                       result.outputs[k].name);
                fwrite(result.outputs[k].data, 1, result.outputs[k].size, stdout);
            }
            if (explain) {
                printf("EXPLAIN %zu\n", explained.size);
                fwrite(explained.text, 1, explained.size, stdout);
            }
            printf("DONE\n");
            fflush(stdout);
            if (in_child)               /* a variant's copy: its answer is all it gives */
                _exit(0);
            bcc20_free(&result);
            free(explained.text);
            free(all);
            for (int k = 0; k < n_files; k++) {
                free(files[k].name);
                free(files[k].data);
            }
            for (int k = 0; k < n_args; k++)
                free(args[k]);
            n_files = n_args = 0;
        } else
            fail("unknown message");
    }
    return 0;
}

static void explain_line(void *context, const char *line)
{
    fprintf((FILE *)context, "%s\n", line);
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
#ifdef _WIN32
    _setmode(_fileno(stdout), _O_BINARY);   /* the console text has BCC's own CR LF */
#endif
    job.stack_limit = 1;
    if (argc == 2 && !strcmp(argv[1], "--serve"))
        return serve();
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
        else if (!strcmp(argv[i], "--explain") && i + 1 < argc) {
            FILE *f = fopen(argv[++i], "w");
            if (!f) {
                perror(argv[i]);
                return 2;
            }
            job.explain = explain_line;
            job.explain_context = f;
        }
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

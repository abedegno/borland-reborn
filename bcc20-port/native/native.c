/* native.c: the native build's start-up and DOS services (README.md, "Plan", step 3).
   main() does what DOS and the start-up code (../bcc20/src/driver/C0.ASM) do for BCC.EXE:
   it loads the parts of the program image the translations read (DGROUP's initial data,
   the inline assembler's tables, the message image's stub header: image.c) into the flat
   memory at their places in the load module and applies their relocations, builds the
   PSP, an environment and argc/argv, fills the start-up words at the start of DGROUP,
   clears the BSS and calls the driver, RMAIN13C, which ends in EXIT.  BCC's code itself is
   never needed: all of it is translated.
   The DOS services (int 21h) the translated code reaches through the run-time library are
   done with the host's: files by handle (DOS handles are host descriptors), find first and
   next, date and time, console output.  Interrupt vectors are words in the vector table at
   0:0, as under DOS.  C45_SETJUMP is the host's setjmp (calls.h), C45_LONGJUMP its longjmp.
   Any other untranslated function reached stops the program with its name (stand_in). */
#include <dirent.h>
#include <fcntl.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#ifdef _WIN32
#include <process.h>
#else
#include <sys/wait.h>
#endif
#include <time.h>
#include <unistd.h>
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"
#include "replay.h"
#include "native.h"
#include "image.h"
#include "bcc20.h"

u8 *mem;
u16 DGROUP;

/* the memory map: PSP, program image, environment, arguments, heap up to the scratch
   segment (port.h) */
#define PSP_SEG 0x07F0
#define LOAD_SEG 0x0800
#define BSS_START 0x5C96            /* src/data/DGROUP.ASM: BSS_START, the end of the data */
#define EXE_HEADER_SS 0x16B4        /* BCC.EXE's header: the initial stack, SS:SP */
#define EXE_HEADER_SP 0x1194
#define ENV_PARAS 0x10
#define ARG_PARAS 0x100

static u16 env_seg, arg_seg;

#define ERRNO W(DSPTR(0x0000))

#ifndef O_BINARY
#define O_BINARY 0              /* Windows: files are bytes, never text with CR LF */
#endif

/* a DOS wildcard pattern (* and ?, any case) against a name; with pathname set, * and ?
   do not match '/' */
static int wildcard_match(const char *pattern, const char *name, int pathname)
{
    for (;; pattern++, name++) {
        char p = *pattern, n = *name;
        if (p == '*') {
            while (pattern[1] == '*')
                pattern++;
            if (!pattern[1])
                return !pathname || !strchr(name, '/');
            for (const char *s = name; *s; s++) {
                if (wildcard_match(pattern + 1, s, pathname))
                    return 1;
                if (pathname && *s == '/')
                    return 0;
            }
            return wildcard_match(pattern + 1, name + strlen(name), pathname);
        }
        if (!p)
            return !n;
        if (!n)
            return 0;
        if (p == '?') {
            if (pathname && n == '/')
                return 0;
            continue;
        }
        if ((p >= 'a' && p <= 'z' ? p - 32 : p) != (n >= 'a' && n <= 'z' ? n - 32 : n))
            return 0;
    }
}

/* ---- library mode (lib.c, include/bcc20.h): the job's files and everything BCC writes
   are in memory; the console text is kept; other files come from the job's root ---- */
static const bcc20_job *job;
typedef struct {
    char name[160];             /* normalised: no drive, '/' separators, upper case */
    u8 *data;
    size_t size, capacity;
    int written, deleted, owned;
} MemFile;
static MemFile mem_files[64];
static int n_mem_files;
/* DOS file handles, as DOS and emu2 hand them out: the lowest free one from 5 (0 to 4 are
   the standard devices).  Each is a host file descriptor, or in library mode a memory file.
   BCC sees only these numbers, never the host's descriptors. */
#define DOS_HANDLES 255
static struct { int used; int fd; int file; size_t position; } handles[DOS_HANDLES];   /* fd -1: memory file */
static char *console_text;
static size_t console_size, console_capacity;

static void console_put(const char *s, size_t n)
{
    if (!job) {
        fwrite(s, 1, n, stdout);
        return;
    }
    if (console_size + n > console_capacity) {
        console_capacity = (console_size + n) * 2 + 256;
        console_text = realloc(console_text, console_capacity);
    }
    memcpy(console_text + console_size, s, n);
    console_size += n;
}

static void console_printf(const char *format, ...)
{
    char text[64];
    va_list ap;
    va_start(ap, format);
    int n = vsnprintf(text, sizeof text, format, ap);
    va_end(ap);
    console_put(text, n < 0 ? 0 : (size_t)n);
}

/* a DOS name as the memory files keep it */
static void normalise(const char *dos, char *out, size_t size)
{
    const char *s = dos;
    if (((s[0] | 0x20) >= 'a' && (s[0] | 0x20) <= 'z') && s[1] == ':')
        s += 2;
    while (*s == '\\' || *s == '/')
        s++;
    size_t n = 0;
    for (; *s && n + 1 < size; s++)
        out[n++] = *s == '\\' ? '/' : (char)(*s >= 'a' && *s <= 'z' ? *s - 32 : *s);
    out[n] = 0;
}

static i16 dos_result(int result, u16 error);

static int find_mem_file(const char *dos)
{
    char name[160];
    normalise(dos, name, sizeof name);
    for (int i = 0; i < n_mem_files; i++)
        if (!mem_files[i].deleted && !strcmp(mem_files[i].name, name))
            return i;
    return -1;
}

/* a new DOS handle for a host descriptor (or, fd -1, memory file file); -1 when all are in
   use (DOS error 4, too many open files) */
static int new_handle(int fd, int file)
{
    for (int h = 5; h < DOS_HANDLES; h++)
        if (!handles[h].used) {
            handles[h].used = 1;
            handles[h].fd = fd;
            handles[h].file = file;
            handles[h].position = 0;
            return h;
        }
    return -1;
}

static int open_mem_handle(int file)
{
    return new_handle(-1, file);
}

/* a host descriptor opened for a DOS handle: the handle, or -1 with ERRNO set */
static i16 host_handle(int fd, u16 error)
{
    if (fd < 0)
        return dos_result(-1, error);
    int h = new_handle(fd, -1);
    if (h < 0) {
        close(fd);
        return dos_result(-1, 4);
    }
    return (i16)h;
}

/* the host descriptor of a DOS handle, -1 if none (the standard devices are the host's) */
static int host_fd(i16 handle)
{
    if (handle >= 0 && handle < 5)
        return handle < 3 ? handle : 2;
    if (handle < 0 || handle >= DOS_HANDLES || !handles[handle].used)
        return -1;
    return handles[handle].fd;
}

static time_t clock_now(void) { return job && job->time ? (time_t)job->time : time(0); }

/* lib.c: the files of a job, before a run */
void native_job_begin(const bcc20_job *j)
{
    job = j;
    n_mem_files = 0;
    console_size = 0;
    for (int i = 0; i < j->n_files && n_mem_files < 64; i++) {
        MemFile *f = &mem_files[n_mem_files++];
        memset(f, 0, sizeof *f);
        normalise(j->files[i].name, f->name, sizeof f->name);
        f->data = (u8 *)j->files[i].data;
        f->size = f->capacity = j->files[i].size;
    }
}

/* lib.c: what the run wrote, after it */
void native_job_end(bcc20_result *result)
{
    result->console = console_text;
    result->console_size = console_size;
    console_text = 0;
    console_capacity = console_size = 0;
    result->outputs = 0;
    result->n_outputs = 0;
    for (int i = 0; i < n_mem_files; i++) {
        MemFile *f = &mem_files[i];
        if (f->written && !f->deleted) {
            result->outputs = realloc(result->outputs, (size_t)(result->n_outputs + 1) * sizeof *result->outputs);
            char *name = malloc(strlen(f->name) + 1);
            strcpy(name, f->name);
            for (char *c = name; *c; c++)
                if (*c == '/')
                    *c = '\\';
            result->outputs[result->n_outputs++] = (bcc20_file){name, f->data, f->size};
            f->owned = 0;
        } else if (f->owned)
            free(f->data);
    }
    n_mem_files = 0;
    job = 0;
}

/* ---- the program image ---- */
/* the parts of BCC.EXE's image the translations read (image.c, tools/genimage.py), at
   their places in the load module, their segment words relocated as DOS does */
static void load_program(void)
{
    for (const ImagePart *part = IMAGE_PARTS; part->bytes; part++) {
        memcpy(mem + LIN(LOAD_SEG + part->para, 0), part->bytes, part->size);
        for (const u16 *r = part->relocs; *r != 0xFFFF; r++)
            W(MK_FP(LOAD_SEG + part->para, *r)) += LOAD_SEG;
    }
}

/* the bytes of an overlay image (the messages) at offset of the overlay area */
void native_read_overlay(u32 offset, u8 *target, u16 size)
{
    for (const ImageOverlay *o = IMAGE_OVERLAYS; o->bytes; o++)
        if (o->offset == offset && size <= o->size) {
            memcpy(target, o->bytes, size);
            return;
        }
    fprintf(stderr, "bcc: no overlay image at %lX (native/image.c)\n", (unsigned long)offset);
    exit(4);
}

farptr native_item_holder(void) { return MK_FP(env_seg, 0xF0); }

/* a string into DOS memory at p; the address after its 0 */
static farptr put_string(farptr p, const char *s)
{
    do
        B(p) = (u8)*s;
    while (*s && (p = fp_add(p, 1), s++, 1));
    return fp_add(p, 1);
}

/* ---- one run of BCC: main() for the command line, bcc20_compile (lib.c) for a library
   call.  Everything is set up afresh, so runs do not share state; BCC's exit (C0_TERMINATE)
   comes back here with its status ---- */
static jmp_buf run_exit;
static int running;
static void reset_platform(void);
static void close_searches(void);

int native_run(int argc, const char *const *argv)
{
    if (!mem)
        mem = calloc(1, MEM_SIZE);
    memset(mem, 0, MEM_SIZE);
    reset_platform();
    native_explain_begin(job ? job->explain : 0, job ? job->explain_context : 0);
    int status = setjmp(run_exit);
    if (status) {
        running = 0;
        return status - 1;
    }
    running = 1;
    load_program();
    DGROUP = LOAD_SEG + DGROUP_PARA;
    memset(mem + LIN(DGROUP, BSS_START), 0, 0x10000 - BSS_START);
    env_seg = DGROUP + 0x1000;
    arg_seg = env_seg + ENV_PARAS;
    u16 heap_start = arg_seg + ARG_PARAS, heap_end = (u16)(SCRATCH_SEG - (getenv("BCC_HEAP_CUT") ? atoi(getenv("BCC_HEAP_CUT")) : 0));
    /* the environment: no variables, then the program's path (DOS 3) */
    farptr env = MK_FP(env_seg, 0);
    B(env) = 0;
    B(fp_add(env, 1)) = 0;
    W(fp_add(env, 2)) = 1;
    put_string(fp_add(env, 4), "BCC.EXE");
    /* the PSP: the top of memory and the environment */
    W(MK_FP(PSP_SEG, 2)) = heap_end;
    W(MK_FP(PSP_SEG, 0x2C)) = env_seg;
    /* the start-up words (C0.ASM) */
    W(DSPTR(0x04)) = W(DSPTR(0x0C)) = heap_start;
    W(DSPTR(0x08)) = W(DSPTR(0x10)) = heap_end;
    W(DSPTR(0x12)) = W(DSPTR(0x16)) = PSP_SEG;
    W(DSPTR(0x14)) = env_seg;
    /* the command tail as DOS passes it: the arguments joined by blanks, at most 126
       characters (a longer command line loses its end), split again at blanks and tabs
       by the start-up code into argv: far pointers, then the strings */
    char tail[128];
    size_t length = 0;
    for (int i = 1; i < argc; i++) {
        if (i > 1 && length < 126)
            tail[length++] = ' ';
        for (const char *c = argv[i]; *c && length < 126; c++)
            tail[length++] = *c;
    }
    tail[length] = 0;
    farptr vector = MK_FP(arg_seg, 0);
    char *words[64];
    int count = 0;
    words[count++] = "BCC.EXE";
    for (char *w = strtok(tail, " \t"); w && count < 63; w = strtok(0, " \t"))
        words[count++] = w;
    farptr text = fp_add(vector, (count + 1) * 4);
    for (int i = 0; i < count; i++) {
        D(fp_add(vector, i * 4)) = text;
        text = put_string(text, words[i]);
    }
    D(fp_add(vector, count * 4)) = 0;
    /* BCC.EXE's SP when C0 calls the compiler (native/stack.c): C0 copies the command tail
       (DOS's, with its leading blank) below the stack the EXE header gives, rounded down to
       a word, pushes two words for each argument and seven more, and makes the far call */
    {
        i32 dos_length = (i32)length + (argc > 1 ? 1 : 0);
        i32 top = (i32)EXE_HEADER_SS - DGROUP_PARA;
        native_stack_set_root((((i32)EXE_HEADER_SP - dos_length - 1) & 0xFFFE) + top * 16
                              - (4 + 4 * (count - 1) + 4 + 6 + 4));
    }
    RMAIN13C((i16)count, vector);
    running = 0;
    return 0;
}

#ifndef BCC20_LIBRARY
int main(int argc, char **argv)
{
    return native_run(argc, (const char *const *)argv);
}
#endif

/* ---- untranslated functions ---- */
u32 stand_in(const char *name, unsigned outs, const StandInArg *args, unsigned n)
{
    (void)outs;
    (void)args;
    (void)n;
    fflush(stdout);
    fprintf(stderr, "bcc: %s is not part of the native build yet\n", name);
    exit(3);
}

void code_unknown(farptr code)
{
    fflush(stdout);
    fprintf(stderr, "bcc: a call to code at %04X:%04X, which names no known function\n", FP_SEG(code), FP_OFF(code));
    exit(3);
}

/* ---- setjmp and longjmp (calls.h) ---- */
static struct {
    farptr buffer;
    jmp_buf jump;
    u16 scratch, near_scratch;
    unsigned stack_depth;           /* native/stack.c's shadow stack at the C45_SETJUMP */
} jumps[8];

jmp_buf *native_jump_slot(farptr buffer)
{
    unsigned i;
    for (i = 0; i < 8 && jumps[i].buffer && jumps[i].buffer != buffer; i++)
        ;
    if (i == 8) {
        fprintf(stderr, "bcc: too many jump buffers\n");
        exit(4);
    }
    jumps[i].buffer = buffer;
    jumps[i].scratch = scratch_mark();
    jumps[i].near_scratch = near_scratch_mark();
    jumps[i].stack_depth = native_stack_depth();
    return &jumps[i].jump;
}

void C45_LONGJUMP(farptr buffer, i16 value)
{
    for (unsigned i = 0; i < 8; i++)
        if (jumps[i].buffer == buffer) {
            scratch_release(jumps[i].scratch);
            near_scratch_release(jumps[i].near_scratch);
            native_stack_unwind(jumps[i].stack_depth);
            longjmp(jumps[i].jump, value ? value : 1);
        }
    fprintf(stderr, "bcc: long jump to a buffer never set\n");
    exit(4);
}

void C0_TERMINATE(i16 status)
{
    fflush(stdout);
    if (running)
        longjmp(run_exit, (status & 0xFF) + 1);
    exit(status & 0xFF);
}

/* ---- files ---- */
/* BCC_ROOT: the host directory standing for drive C:'s root; the current directory is then
   the DOS current directory under it (a makefile's C:\BORLANDC\INCLUDE, a "..\" out of the
   build directory).  Unset, the current directory is the root, as it was. */
#ifdef _WIN32
#define full_path(path, out) _fullpath((out), (path), 1024)
#else
#define full_path(path, out) realpath((path), (out))
#endif

static const char *drive_root(void)
{
    const char *root = job ? 0 : getenv("BCC_ROOT");
    return root && *root ? root : 0;
}

/* a DOS path as the host's: '\' as '/', relative to the current directory, or to the drive
   root when it starts at the root */
static char *host_path(farptr name)
{
    static char path[512];
    size_t n = 0;
    for (farptr p = name; SB(p) && n < sizeof path - 1; p = fp_add(p, 1))
        path[n++] = (char)(SB(p) == '\\' ? '/' : SB(p));
    path[n] = 0;
    /* the drive's root is the current directory, as under emu2 */
    char *start = path;
    if (n >= 2 && ((path[0] | 0x20) >= 'a' && (path[0] | 0x20) <= 'z') && path[1] == ':')
        start += 2;
    int absolute = *start == '/';
    while (*start == '/')
        start++;
    memmove(path, start, strlen(start) + 1);
    if (absolute && drive_root()) {
        char rooted[1024];
        snprintf(rooted, sizeof rooted, "%s/%s", drive_root(), path);
        snprintf(path, sizeof path, "%s", rooted);
    }
    if (!path[0])
        strcpy(path, ".");
    /* DOS cuts each name to 8.3 (STRSTREAM.H opens STRSTREA.H); the host's file under the
       full name is used when there is one (emu2 does the same), else the 8.3 one */
    /* library mode: other files are under the job's root (none without one) */
    if (job) {
        char rooted[1024];
        snprintf(rooted, sizeof rooted, "%s/%s", job->root ? job->root : "/nonexistent-bcc20-root", path);
        snprintf(path, sizeof path, "%s", rooted);
    }
    struct stat st;
    if (stat(path, &st) == 0 || getenv("BCC_EMU2_FIND"))      /* emu2 does not cut names */
        return path;
    char cut[512];
    size_t k = 0;
    for (char *part = path; *part && k < sizeof cut - 16;) {
        char *end = strchr(part, '/');
        size_t length = end ? (size_t)(end - part) : strlen(part);
        char *dot = memchr(part, '.', length);
        size_t base = dot ? (size_t)(dot - part) : length;
        if (strncmp(part, ".", length) && strncmp(part, "..", length)) {
            memcpy(cut + k, part, base < 8 ? base : 8);
            k += base < 8 ? base : 8;
            if (dot) {
                size_t ext = length - base - 1;
                cut[k++] = '.';
                memcpy(cut + k, dot + 1, ext < 3 ? ext : 3);
                k += ext < 3 ? ext : 3;
            }
        } else {
            memcpy(cut + k, part, length);
            k += length;
        }
        if (!end)
            break;
        cut[k++] = '/';
        part = end + 1;
    }
    cut[k] = 0;
    strcpy(path, cut);
    return path;
}

static i16 dos_result(int result, u16 error)
{
    if (result < 0) {
        ERRNO = error;
        return -1;
    }
    return (i16)result;
}

/* BCC_TRACE set: every open and find on stderr */
static int tracing(void)
{
    static int on = -1;
    if (on < 0)
        on = getenv("BCC_TRACE") != 0;
    return on;
}

i16 RTL_OPEN(farptr name, i16 mode)
{
    static const int modes[] = {O_RDONLY | O_BINARY, O_WRONLY | O_BINARY, O_RDWR | O_BINARY, O_RDONLY | O_BINARY};
    if (job) {
        int file = find_mem_file((const char *)at(name));
        if (file >= 0)
            return dos_result(open_mem_handle(file), 4);
        if (mode & 3) {             /* the host is never written in library mode: a root
                                       file opened for writing is copied into memory first */
            FILE *host = fopen(host_path(name), "rb");
            if (!host || n_mem_files == 64) {
                if (host)
                    fclose(host);
                return dos_result(-1, host ? 4 : 2);
            }
            MemFile *f = &mem_files[n_mem_files];
            memset(f, 0, sizeof *f);
            normalise((const char *)at(name), f->name, sizeof f->name);
            fseek(host, 0, SEEK_END);
            f->size = f->capacity = (size_t)ftell(host);
            fseek(host, 0, SEEK_SET);
            f->data = malloc(f->size + 1);
            f->owned = 1;
            if (fread(f->data, 1, f->size, host) != f->size)
                f->size = 0;
            fclose(host);
            return dos_result(open_mem_handle(n_mem_files++), 4);
        }
    }
    i16 result = host_handle(open(host_path(name), modes[mode & 3]), 2);
    if (tracing())
        fprintf(stderr, "open %s -> %d\n", host_path(name), result);
    return result;
}

i16 RTL_CREAT(farptr name, i16 attribute)
{
    (void)attribute;
    if (job) {
        int file = find_mem_file((const char *)at(name));
        if (file < 0) {
            if (n_mem_files == 64)
                return dos_result(-1, 4);
            file = n_mem_files++;
            memset(&mem_files[file], 0, sizeof mem_files[file]);
            normalise((const char *)at(name), mem_files[file].name, sizeof mem_files[file].name);
        } else if (!mem_files[file].owned) {
            mem_files[file].data = 0;   /* a job's file: replaced by a new one of BCC's */
            mem_files[file].capacity = 0;
        }
        mem_files[file].owned = 1;
        mem_files[file].written = 1;
        mem_files[file].size = 0;
        return dos_result(open_mem_handle(file), 4);
    }
    return host_handle(open(host_path(name), O_RDWR | O_CREAT | O_TRUNC | O_BINARY, 0644), 5);
}

static MemFile *mem_file_of(i16 handle)
{
    return handle >= 5 && handle < DOS_HANDLES && handles[handle].used && handles[handle].fd < 0
        ? &mem_files[handles[handle].file] : 0;
}

i16 RTL_READ(i16 handle, farptr buffer, u16 count)
{
    MemFile *f = mem_file_of(handle);
    if (f) {
        size_t *position = &handles[handle].position;
        size_t n = *position < f->size ? f->size - *position : 0;
        if (n > count)
            n = count;
        memcpy(at(buffer), f->data + *position, n);
        *position += n;
        return (i16)n;
    }
    return dos_result((int)read(host_fd(handle), at(buffer), count), 6);
}

i16 RTL_WRITE(i16 handle, farptr buffer, u16 count)
{
    MemFile *f = mem_file_of(handle);
    if (f) {
        size_t *position = &handles[handle].position;
        if (!f->owned) {            /* a job's file written to: BCC's own copy from now on */
            u8 *copy = malloc(f->size + 1);
            memcpy(copy, f->data, f->size);
            f->data = copy;
            f->capacity = f->size;
            f->owned = 1;
        }
        if (*position + count > f->capacity) {
            f->capacity = (*position + count) * 2 + 1024;
            f->data = realloc(f->data, f->capacity);
        }
        if (*position > f->size)
            memset(f->data + f->size, 0, *position - f->size);
        memcpy(f->data + *position, at(buffer), count);
        *position += count;
        if (*position > f->size)
            f->size = *position;
        f->written = 1;
        return (i16)count;
    }
    if (job && (handle == 1 || handle == 2)) {
        console_put((const char *)at(buffer), count);
        return (i16)count;
    }
    if (handle == 1)
        fflush(stdout);
    return dos_result((int)write(host_fd(handle), at(buffer), count), 6);
}

i32 RTL_LSEEK(i16 handle, i32 position, i16 whence)
{
    MemFile *f = mem_file_of(handle);
    if (f) {
        size_t *at_pos = &handles[handle].position;
        long long to = whence == 0 ? position : whence == 1 ? (long long)*at_pos + position : (long long)f->size + position;
        if (to < 0) {
            ERRNO = 6;
            return -1;
        }
        *at_pos = (size_t)to;
        return (i32)to;
    }
    off_t result = lseek(host_fd(handle), position, whence);
    if (result < 0) {
        ERRNO = 6;
        return -1;
    }
    return (i32)result;
}

i16 RTL_CLOSE(i16 handle)
{
    if (handle < 5 || handle >= DOS_HANDLES || !handles[handle].used)
        return dos_result(-1, 6);
    handles[handle].used = 0;
    return handles[handle].fd < 0 ? 0 : dos_result(close(handles[handle].fd), 6);
}

i16 DELETE_FILE(farptr path)
{
    if (job) {
        int file = find_mem_file((const char *)at(path));
        if (file < 0)
            return dos_result(-1, 2);
        mem_files[file].deleted = 1;
        return 0;
    }
    return dos_result(unlink(host_path(path)), 2);
}

/* ---- find first and next: the find record (dir.h ffblk) keeps the search in its first
   21 bytes: a slot number into searches[] ---- */
static struct {
    DIR *dir;
    char directory[512], pattern[64];
    int in_memory, next;        /* library mode: searching the memory files, from next */
    char mem_pattern[160];      /* normalised directory and pattern */
    char dos_directory[160];    /* the directory as BCC named it, for the memory files */
} searches[16];

static u32 dos_time(time_t t)
{
    struct tm *tm = localtime(&t);
    u16 time = (u16)(tm->tm_hour << 11 | tm->tm_min << 5 | tm->tm_sec / 2);
    u16 date = (u16)((tm->tm_year - 80) << 9 | (tm->tm_mon + 1) << 5 | tm->tm_mday);
    return (u32)date << 16 | time;
}

/* a find record filled in for a file found */
static void found(farptr record, u32 stamp, u32 size, const char *name)
{
    B(fp_add(record, 21)) = 0x20;                   /* ff_attrib: archive */
    W(fp_add(record, 22)) = (u16)stamp;             /* ff_ftime */
    W(fp_add(record, 24)) = (u16)(stamp >> 16);     /* ff_fdate */
    D(fp_add(record, 26)) = size;                   /* ff_fsize */
    farptr out = fp_add(record, 30);
    for (const char *c = name; *c; c++, out = fp_add(out, 1))
        B(out) = (u8)(*c >= 'a' && *c <= 'z' ? *c - 32 : *c);
    B(out) = 0;
}

static i16 find_next_in(unsigned slot, farptr record)
{
    if (searches[slot].in_memory) {
        while (searches[slot].next < n_mem_files) {
            MemFile *f = &mem_files[searches[slot].next++];
            if (f->deleted || !wildcard_match(searches[slot].mem_pattern, f->name, 1))
                continue;
            const char *base = strrchr(f->name, '/');
            found(record, dos_time(clock_now()), (u32)f->size, base ? base + 1 : f->name);
            return 0;
        }
        /* then the root's files, as on the command line */
        searches[slot].in_memory = 0;
        if (!job->root || !searches[slot].dir) {
            ERRNO = 18;
            return -1;
        }
    }
    struct dirent *entry;
    while (searches[slot].dir && (entry = readdir(searches[slot].dir))) {
        if (!wildcard_match(searches[slot].pattern, entry->d_name, 0))
            continue;
        char full[1100];
        snprintf(full, sizeof full, "%s%s", searches[slot].directory, entry->d_name);
        struct stat st;
        if (stat(full, &st) || !S_ISREG(st.st_mode) || strlen(entry->d_name) > 12)
            continue;
        if (job) {                  /* a memory file hides the root's file of its name */
            char dos[1100];
            snprintf(dos, sizeof dos, "%s%s", searches[slot].dos_directory, entry->d_name);
            if (find_mem_file(dos) >= 0)
                continue;
        }
        found(record, dos_time(st.st_mtime), (u32)st.st_size, entry->d_name);
        return 0;
    }
    if (searches[slot].dir) {
        closedir(searches[slot].dir);
        searches[slot].dir = 0;
    }
    ERRNO = 18;
    return -1;
}

i16 FINDFIRST(farptr path, farptr record, i16 attribute)
{
    (void)attribute;
    if (tracing())
        fprintf(stderr, "find %s\n", host_path(path));
    /* BCC_EMU2_FIND set (tools/nativetest.py): fail on a name longer than 8.3 as emu2's
       find first does, where DOS would cut it to 8.3 and find the file */
    if (getenv("BCC_EMU2_FIND")) {
        const char *name = (const char *)at(path), *last = name;
        for (const char *c = name; *c; c++)
            if (*c == '\\' || *c == '/' || *c == ':')
                last = c + 1;
        const char *dot = strchr(last, '.');
        size_t base = dot ? (size_t)(dot - last) : strlen(last);
        if (base > 8 || (dot && strlen(dot + 1) > 3)) {
            ERRNO = 2;
            return -1;
        }
    }
    unsigned slot;
    for (slot = 0; slot < 16 && searches[slot].dir; slot++)
        ;
    if (slot == 16) {
        slot = 0;
        closedir(searches[slot].dir);
        searches[slot].dir = 0;
    }
    char *host = host_path(path);
    char *slash = strrchr(host, '/');
    if (slash) {
        snprintf(searches[slot].directory, sizeof searches[slot].directory, "%.*s/", (int)(slash - host), host);
        snprintf(searches[slot].pattern, sizeof searches[slot].pattern, "%s", slash + 1);
    } else {
        searches[slot].directory[0] = 0;
        snprintf(searches[slot].pattern, sizeof searches[slot].pattern, "%s", host);
    }
    searches[slot].dir = opendir(searches[slot].directory[0] ? searches[slot].directory : ".");
    B(record) = (u8)slot;
    searches[slot].in_memory = 0;
    if (job) {                      /* the memory files first */
        searches[slot].in_memory = 1;
        searches[slot].next = 0;
        normalise((const char *)at(path), searches[slot].mem_pattern, sizeof searches[slot].mem_pattern);
        snprintf(searches[slot].dos_directory, sizeof searches[slot].dos_directory, "%s", searches[slot].mem_pattern);
        char *cut = strrchr(searches[slot].dos_directory, '/');
        if (cut)
            cut[1] = 0;
        else
            searches[slot].dos_directory[0] = 0;
        return find_next_in(slot, record);
    }
    if (!searches[slot].dir) {
        ERRNO = 3;
        return -1;
    }
    return find_next_in(slot, record);
}

i16 FINDNEXT(farptr record)
{
    return find_next_in(B(record) & 15, record);
}

/* ---- date, time, vectors, DOS ---- */
static struct tm *now_tm(void)
{
    time_t t = clock_now();
    return localtime(&t);
}

void RTL_GETDATE(farptr date)
{
    struct tm *tm = now_tm();
    W(date) = (u16)(tm->tm_year + 1900);
    B(fp_add(date, 2)) = (u8)tm->tm_mday;
    B(fp_add(date, 3)) = (u8)(tm->tm_mon + 1);
}

void RTL_GETTIME(farptr time_record)
{
    struct tm *tm = now_tm();
    B(time_record) = (u8)tm->tm_min;
    B(fp_add(time_record, 1)) = (u8)tm->tm_hour;
    B(fp_add(time_record, 2)) = 0;
    B(fp_add(time_record, 3)) = (u8)tm->tm_sec;
}

farptr RVECGET(u16 vector) { return D(MK_FP(0, vector * 4)); }
void RVECSET(u16 vector, farptr handler) { D(MK_FP(0, vector * 4)) = handler; }

/* the only DOS function BCC calls this way is 0Bh, the Ctrl-Break poll */
i16 DOS_CALL_AH(i16 function, i16 unused1, i16 unused2)
{
    (void)function;
    (void)unused1;
    (void)unused2;
    return 0;
}

/* ---- console output: RTL_DVPRINTF's subset of printf (%d, %x, %c, %s, l for long; an
   unknown conversion ends the output) ---- */
void RTL_DVPRINTF(farptr format, farptr args)
{
    for (; SB(format); format = fp_add(format, 1)) {
        char c = (char)SB(format);
        if (c != '%') {
            console_put(&c, 1);
            continue;
        }
        format = fp_add(format, 1);
        int is_long = 0;
        if (SB(format) == 'l') {
            is_long = 1;
            format = fp_add(format, 1);
        }
        switch (SB(format)) {
        case 'd':
            if (is_long) {
                console_printf("%ld", (long)(i32)D(args));
                args = fp_add(args, 4);
            } else {
                console_printf("%d", (int)(i16)W(args));
                args = fp_add(args, 2);
            }
            break;
        case 'x': {
            u32 value = is_long ? D(args) : W(args);
            args = fp_add(args, is_long ? 4 : 2);
            if (value)
                console_printf("%lx", (unsigned long)value);
            break;
        }
        case 'c':
            { char ch = (char)W(args); console_put(&ch, 1); }
            args = fp_add(args, 2);
            break;
        case 's':
            for (farptr p = D(args); SB(p); p = fp_add(p, 1))
                { char ch = (char)SB(p); console_put(&ch, 1); }
            args = fp_add(args, 4);
            break;
        default:
            return;
        }
    }
}

/* itoa(value, buffer, 10) */
void RTL_ITOA10(i16 value, farptr buffer)
{
    char text[8];
    snprintf(text, sizeof text, "%d", value);
    put_string(buffer, text);
}

/* ---- programs (TASM, TLINK) ---- */
/* searchpath (../bcc20/src/rtl/SEARCHP.C): file itself if it exists, else the first
   directory of the DOS environment's PATH holding it, in the static SEARCH_BUFFER; 0 when
   it is nowhere.  The native build's environment has no PATH. */
farptr RTL_SEARCHPATH(farptr file)
{
    farptr buffer = DSPTR(0x8BCE);
    struct stat st;
    if (stat(host_path(file), &st) == 0) {
        put_string(buffer, (const char *)at(file));
        return buffer;
    }
    farptr path = RTL_GETENV(DSPTR(0x5C8E));      /* "PATH" */
    if (!path)
        return 0;
    while (SB(path)) {
        farptr end = path;
        while (SB(end) && SB(end) != ';')
            end = fp_add(end, 1);
        u16 length = (u16)(FP_OFF(end) - FP_OFF(path));
        memmove(at(buffer), at(path), length);
        B(fp_add(buffer, length)) = 0;
        if (length && SB(fp_add(buffer, length - 1)) != ':' && SB(fp_add(buffer, length - 1)) != '/' &&
            SB(fp_add(buffer, length - 1)) != '\\')
            B(fp_add(buffer, length++)) = '\\';
        put_string(fp_add(buffer, length), (const char *)at(file));
        if (stat(host_path(buffer), &st) == 0)
            return buffer;
        path = SB(end) ? fp_add(end, 1) : end;
    }
    return 0;
}

/* EXEC, mode 0 (run and wait).  A DOS program (TASM, TLINK) cannot run natively: with
   BCC_DOS_RUNNER naming a DOS emulator (emu2) it runs there, the command tail split into
   words, and the result is its exit code; without it EXEC fails as for a file that is not
   there (BCC then reports "Unable to execute command").  block is DOS's parameter block:
   environment segment, far command tail (length byte, text, CR), two far FCB pointers */
i16 RTL_EXEC(farptr path, i8 mode, farptr block)
{
    const char *runner = getenv("BCC_DOS_RUNNER");
    if (!runner || !*runner || mode != 0) {
        ERRNO = 2;
        return -1;
    }
    char program[512];
    snprintf(program, sizeof program, "%s", host_path(path));
    farptr tail = D(fp_add(block, 2));
    u8 length = B(tail);
    char text[130];
    memcpy(text, at(fp_add(tail, 1)), length);
    text[length] = 0;
    char *argv[70];
    int argc = 0;
    argv[argc++] = (char *)runner;
    argv[argc++] = program;
    for (char *word = strtok(text, " \t\r"); word && argc < 69; word = strtok(0, " \t\r"))
        argv[argc++] = word;
    argv[argc] = 0;
    /* the child sees the same drive C: and current directory (emu2's settings) */
    char cwd_env[300] = "", root_env[1100] = "";
    if (drive_root()) {
        char root[1024], cwd[1024], here[1024];
        if (full_path(drive_root(), root) && getcwd(cwd, sizeof cwd) && full_path(cwd, here)) {
            size_t k = strlen(root);
            if (!strncmp(here, root, k) && (here[k] == '/' || here[k] == 0)) {
                snprintf(root_env, sizeof root_env, "EMU2_DRIVE_C=%s", root);
                int m = snprintf(cwd_env, sizeof cwd_env, "EMU2_CWD=C:\\%s", here[k] ? here + k + 1 : "");
                for (int i = 0; i < m; i++)
                    if (cwd_env[i] == '/')
                        cwd_env[i] = '\\';
            }
        }
    }
    fflush(stdout);
#ifdef _WIN32
    if (root_env[0]) {
        _putenv(root_env);
        _putenv(cwd_env);
    }
    intptr_t code = _spawnvp(_P_WAIT, runner, (const char *const *)argv);
    if (code < 0) {
        ERRNO = 2;
        return -1;
    }
    return (i16)(code & 0xFF);
#else
    pid_t child = fork();
    if (child < 0) {
        ERRNO = 8;
        return -1;
    }
    if (child == 0) {
        if (root_env[0]) {
            putenv(root_env);
            putenv(cwd_env);
        }
        execvp(runner, argv);
        _exit(127);
    }
    int status;
    if (waitpid(child, &status, 0) < 0 || !WIFEXITED(status) || WEXITSTATUS(status) == 127) {
        ERRNO = 2;
        return -1;
    }
    return (i16)(WEXITSTATUS(status) & 0xFF);
#endif
}

/* the platform's own state, back to its start for a new run */
static void reset_platform(void)
{
    close_searches();
    memset(jumps, 0, sizeof jumps);
    for (int h = 5; h < DOS_HANDLES; h++)         /* files a run left open */
        if (handles[h].used && handles[h].fd >= 0)
            close(handles[h].fd);
    memset(handles, 0, sizeof handles);
    native_stack_unwind(0);
    native_stack_enable(job ? job->stack_limit : -1);
    scratch_release(0);
    near_scratch_release(0xFFF0);
}

static void close_searches(void)
{
    for (unsigned i = 0; i < 16; i++) {
        if (searches[i].dir)
            closedir(searches[i].dir);
        searches[i].dir = 0;
        searches[i].in_memory = 0;
    }
}

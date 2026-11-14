/* native.c: the native build's start-up and DOS services (README.md, "Plan", step 3).
   main() does what DOS and the start-up code (../bcc20/src/driver/C0.ASM) do for BCC.EXE:
   it loads the program image into the flat memory at a fixed segment and applies its
   relocations (the image holds BCC's initial data: DGROUP, the overlay stub headers and
   the code segments' tables, which translated code reads), builds the PSP, an environment
   and argc/argv, fills the start-up words at the start of DGROUP, clears the BSS and calls
   the driver, RMAIN13C, which ends in EXIT.  The image comes from the program file named by
   BCC20_EXE (default: the toolchain's BCC.EXE); its code is never run.
   The DOS services (int 21h) the translated code reaches through the run-time library are
   done with the host's: files by handle (DOS handles are host descriptors), find first and
   next, date and time, console output.  Interrupt vectors are words in the vector table at
   0:0, as under DOS.  C45_SETJUMP is the host's setjmp (calls.h), C45_LONGJUMP its longjmp.
   Any other untranslated function reached stops the program with its name (stand_in). */
#include <dirent.h>
#include <fcntl.h>
#include <fnmatch.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"
#include "replay.h"
#include "native.h"

u8 *mem;
u16 DGROUP;

#ifndef BCC20_EXE_DEFAULT
#define BCC20_EXE_DEFAULT "../bcc20/toolchain/BC20/BIN/BCC.EXE"
#endif

/* the memory map: PSP, program image, environment, arguments, heap up to the scratch
   segment (port.h) */
#define PSP_SEG 0x07F0
#define LOAD_SEG 0x0800
#define BSS_START 0x5C96            /* src/data/DGROUP.ASM: BSS_START, the end of the data */
#define ENV_PARAS 0x10
#define ARG_PARAS 0x100

static u8 *program;
static long program_size;
static u32 overlay_base;            /* the end of the load module in the file */
static u16 env_seg, arg_seg;

#define ERRNO W(DSPTR(0x0000))

/* ---- the program image ---- */
static void load_program(const char *path)
{
    FILE *f = fopen(path, "rb");
    if (!f) {
        fprintf(stderr, "bcc: cannot read the program image %s (set BCC20_EXE)\n", path);
        exit(4);
    }
    fseek(f, 0, SEEK_END);
    program_size = ftell(f);
    fseek(f, 0, SEEK_SET);
    program = malloc((size_t)program_size);
    if (fread(program, 1, (size_t)program_size, f) != (size_t)program_size) {
        fprintf(stderr, "bcc: cannot read %s\n", path);
        exit(4);
    }
    fclose(f);
#define HDR(o) (program[o] | program[(o) + 1] << 8)
    u32 header = (u32)HDR(8) * 16;
    overlay_base = (u32)HDR(4) * 512 - (HDR(2) ? 512 - HDR(2) : 0);
    memcpy(mem + LIN(LOAD_SEG, 0), program + header, overlay_base - header);
    /* the overlay area starts with a 16-byte "FBOV" header; stub offsets count after it */
    if (!memcmp(program + overlay_base, "FBOV", 4))
        overlay_base += 16;
    for (u16 i = 0; i < HDR(6); i++) {
        u32 entry = (u32)HDR(0x18) + i * 4;
        u16 off = (u16)HDR(entry), seg = (u16)HDR(entry + 2);
        W(MK_FP(LOAD_SEG + seg, off)) += LOAD_SEG;
    }
#undef HDR
}

void native_read_overlay(u32 offset, u8 *target, u16 size)
{
    u32 start = overlay_base + offset;
    if ((long)(start + size) > program_size) {
        fprintf(stderr, "bcc: overlay image outside the program file\n");
        exit(4);
    }
    memcpy(target, program + start, size);
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

int main(int argc, char **argv)
{
    mem = calloc(1, MEM_SIZE);
    const char *image = getenv("BCC20_EXE");
    load_program(image ? image : BCC20_EXE_DEFAULT);
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
    RMAIN13C((i16)count, vector);
    return 0;
}

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
    return &jumps[i].jump;
}

void C45_LONGJUMP(farptr buffer, i16 value)
{
    for (unsigned i = 0; i < 8; i++)
        if (jumps[i].buffer == buffer) {
            scratch_release(jumps[i].scratch);
            near_scratch_release(jumps[i].near_scratch);
            longjmp(jumps[i].jump, value ? value : 1);
        }
    fprintf(stderr, "bcc: long jump to a buffer never set\n");
    exit(4);
}

void C0_TERMINATE(i16 status)
{
    fflush(stdout);
    exit(status & 0xFF);
}

/* ---- files ---- */
/* a DOS path as the host's: '\' as '/', relative to the current directory */
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
    while (*start == '/')
        start++;
    memmove(path, start, strlen(start) + 1);
    if (!path[0])
        strcpy(path, ".");
    /* DOS cuts each name to 8.3 (STRSTREAM.H opens STRSTREA.H); the host's file under the
       full name is used when there is one (emu2 does the same), else the 8.3 one */
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
    static const int modes[] = {O_RDONLY, O_WRONLY, O_RDWR, O_RDONLY};
    i16 result = dos_result(open(host_path(name), modes[mode & 3]), 2);
    if (tracing())
        fprintf(stderr, "open %s -> %d\n", host_path(name), result);
    return result;
}

i16 RTL_CREAT(farptr name, i16 attribute)
{
    (void)attribute;
    return dos_result(open(host_path(name), O_RDWR | O_CREAT | O_TRUNC, 0644), 5);
}

i16 RTL_READ(i16 handle, farptr buffer, u16 count)
{
    return dos_result((int)read(handle, at(buffer), count), 6);
}

i16 RTL_WRITE(i16 handle, farptr buffer, u16 count)
{
    if (handle == 1)
        fflush(stdout);
    return dos_result((int)write(handle, at(buffer), count), 6);
}

i32 RTL_LSEEK(i16 handle, i32 position, i16 whence)
{
    off_t result = lseek(handle, position, whence);
    if (result < 0) {
        ERRNO = 6;
        return -1;
    }
    return (i32)result;
}

i16 RTL_CLOSE(i16 handle)
{
    return dos_result(close(handle), 6);
}

i16 DELETE_FILE(farptr path)
{
    return dos_result(unlink(host_path(path)), 2);
}

/* ---- find first and next: the find record (dir.h ffblk) keeps the search in its first
   21 bytes: a slot number into searches[] ---- */
static struct {
    DIR *dir;
    char directory[512], pattern[64];
} searches[16];

static u32 dos_time(time_t t)
{
    struct tm *tm = localtime(&t);
    u16 time = (u16)(tm->tm_hour << 11 | tm->tm_min << 5 | tm->tm_sec / 2);
    u16 date = (u16)((tm->tm_year - 80) << 9 | (tm->tm_mon + 1) << 5 | tm->tm_mday);
    return (u32)date << 16 | time;
}

static i16 find_next_in(unsigned slot, farptr record)
{
    struct dirent *entry;
    while (searches[slot].dir && (entry = readdir(searches[slot].dir))) {
        if (fnmatch(searches[slot].pattern, entry->d_name, FNM_CASEFOLD))
            continue;
        char full[1100];
        snprintf(full, sizeof full, "%s%s", searches[slot].directory, entry->d_name);
        struct stat st;
        if (stat(full, &st) || !S_ISREG(st.st_mode) || strlen(entry->d_name) > 12)
            continue;
        u32 stamp = dos_time(st.st_mtime);
        B(fp_add(record, 21)) = 0x20;                   /* ff_attrib: archive */
        W(fp_add(record, 22)) = (u16)stamp;             /* ff_ftime */
        W(fp_add(record, 24)) = (u16)(stamp >> 16);     /* ff_fdate */
        D(fp_add(record, 26)) = (u32)st.st_size;        /* ff_fsize */
        farptr name = fp_add(record, 30);
        for (const char *c = entry->d_name; *c; c++, name = fp_add(name, 1))
            B(name) = (u8)(*c >= 'a' && *c <= 'z' ? *c - 32 : *c);
        B(name) = 0;
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
    if (slot == 16)
        slot = 0;
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
    time_t t = time(0);
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
            putchar(c);
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
                printf("%ld", (long)(i32)D(args));
                args = fp_add(args, 4);
            } else {
                printf("%d", (int)(i16)W(args));
                args = fp_add(args, 2);
            }
            break;
        case 'x': {
            u32 value = is_long ? D(args) : W(args);
            args = fp_add(args, is_long ? 4 : 2);
            if (value)
                printf("%lx", (unsigned long)value);
            break;
        }
        case 'c':
            putchar((char)W(args));
            args = fp_add(args, 2);
            break;
        case 's':
            for (farptr p = D(args); SB(p); p = fp_add(p, 1))
                putchar((char)SB(p));
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

/* a DOS program cannot run in the native build: EXEC fails as for a file that is not
   there (BCC then reports "Unable to execute command") */
i16 RTL_EXEC(farptr path, i8 mode, farptr block)
{
    (void)path;
    (void)mode;
    (void)block;
    ERRNO = 2;
    return -1;
}

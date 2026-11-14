/* rfnsplit.c: from bcc20/src/rtl/RFNSPLIT.C: the C library's fnsplit and fnmerge (dir.h)
   with pascal calling and far pointers (Turbo C 2.01), which take a DOS path apart into
   drive, directory, name and extension and put one together again.  FNSPLIT copies the
   path (leading blanks skipped, at most MAXPATH characters) into a buffer with a 0 in front
   of it and walks backward from the end.  Each part it recognises is copied out with
   SLICE_TEXT and cut off the work copy by writing a 0 over its first character, so the next
   part found ends there; the leading 0 stops the walk at the start of the path.  Any of
   drive, dir, name and ext may be 0.  Used by the driver and option code to build file
   names. */
#include "port.h"
#include "protos.h"

#define WILDCARDS 0x01
#define EXTENSION 0x02
#define FILENAME 0x04
#define DIRECTORY 0x08
#define DRIVE 0x10
#define MAXPATH 80
#define MAXDRIVE 3
#define MAXDIR 66
#define MAXFILE 9
#define MAXEXT 5

/* at most length characters from source to destination (if given), terminated; then the
   work copy is cut at source */
void SLICE_TEXT(farptr destination, farptr source, u16 length)
{
    if (destination) {
        RTL_STRNCPY(destination, source, length);
        B(fp_add(destination, length)) = 0;
    }
    B(source) = 0;
}

/* splits path into the four parts; the dir.h flags: which parts were present (DRIVE,
   DIRECTORY, FILENAME, EXTENSION) and WILDCARDS if the name or extension holds '*' or '?'.
   BCC's frame: the 82-byte work copy at bp-52h */
static i16 split_path(farptr buffer, farptr path, farptr drive, farptr dir, farptr name, farptr ext)
{
    i16 flags = 0;
    if (drive)
        B(drive) = 0;
    if (dir)
        B(dir) = 0;
    if (name)
        B(name) = 0;
    if (ext)
        B(ext) = 0;
    farptr p = buffer;
    while (SB(path) == ' ')
        path = fp_add(path, 1);
    i16 split = (i16)STRING_LENGTH(path);
    if (split > MAXPATH)
        split = MAXPATH;
    B(p) = 0;
    p = fp_add(p, 1);
    RTL_STRNCPY(p, path, (u16)split);
    p = fp_add(p, split);
    B(p) = 0;
    split = 0;
    /* walking backward: before split is set, a '.' starts the extension (the last '.'
       only) and the first '\', '/' or ':' (or the start) ends the name; after that a ':'
       or the start ends the directory */
    for (;;) {
        p = fp_add(p, -1);
        i8 c = SB(p);
        if (c == '.') {
            if (!split && !(flags & EXTENSION)) {
                flags |= EXTENSION;
                SLICE_TEXT(ext, p, MAXEXT);
            }
            continue;
        }
        if ((c == ':' || c == 0) && split) {
            p = fp_add(p, 1);
            if (SB(p))
                flags |= DIRECTORY;
            SLICE_TEXT(dir, p, MAXDIR);
            p = fp_add(p, -1);
            break;
        }
        if (c == ':' || c == 0 || c == '/' || c == '\\') {
            if (!split) {
                split++;
                p = fp_add(p, 1);
                if (SB(p))
                    flags |= FILENAME;
                SLICE_TEXT(name, p, MAXFILE);
                p = fp_add(p, -1);
                if (SB(p) == ':' || SB(p) == 0)
                    break;
            }
            continue;
        }
        if ((c == '*' || c == '?') && !split)
            flags |= WILDCARDS;
    }
    /* stopped at a ':': what is in front of it is the drive */
    if (SB(p) == ':') {
        if (SB(fp_add(buffer, 1)))
            flags |= DRIVE;
        SLICE_TEXT(drive, fp_add(buffer, 1), MAXDRIVE);
    }
    return flags;
}

i16 FNSPLIT(farptr path, farptr drive, farptr dir, farptr name, farptr ext)
{
    u16 mark = scratch_mark();
    farptr frame = scratch_alloc(0x56);
    i16 flags = split_path(fp_add(frame, 4), path, drive, dir, name, ext);
    scratch_release(mark);
    return flags;
}

/* source copied to destination with its terminator; the address of that terminator, so
   the next copy appends (like stpcpy) */
farptr COPY_TO_END(farptr destination, farptr source)
{
    for (;;) {
        u8 c = B(source);
        source = fp_add(source, 1);
        B(destination) = c;
        if (c == 0)
            return destination;
        destination = fp_add(destination, 1);
    }
}

/* builds path from the parts: only the first character of drive is used, followed by ':';
   a '\' is added after dir unless it already ends in one or in '/'.  Missing or empty parts
   are left out */
void FNMERGE(farptr path, farptr drive, farptr dir, farptr name, farptr ext)
{
    if (drive && SB(drive)) {
        B(path) = B(drive);
        path = fp_add(path, 1);
        B(path) = ':';
        path = fp_add(path, 1);
    }
    if (dir && SB(dir)) {
        path = COPY_TO_END(path, dir);
        if (SB(fp_add(path, -1)) != '\\' && SB(fp_add(path, -1)) != '/') {
            B(path) = '\\';
            path = fp_add(path, 1);
        }
    }
    if (name)
        path = COPY_TO_END(path, name);
    if (ext)
        path = COPY_TO_END(path, ext);
    B(path) = 0;
}

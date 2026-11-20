/* target: ovr160_C82UNIT */
/* Role: object output: numbered records tying source files to code segments (new, clone on
   segment change, find by serial); probably for line-number debug records. Entry points:
   NEW_SERIAL_NODE, CLONE_NODE_KEEP_SERIAL, CLONE_NODE_NEW_SERIAL, FIND_NODE_BY_SERIAL. Map
   of all sources: docs/SOURCE-MAP.md. */
/* Original CO064 record160: NEW_SERIAL_NODE CLONE_NODE_KEEP_SERIAL CLONE_NODE_NEW_SERIAL FIND_NODE_BY_SERIAL. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: a small table of source-file records kept in SRCFILE_POOL_SEG, each naming
   one source file used in one code segment and numbered by a serial. The lexer makes a
   record whenever it starts reading a file (NEW_SERIAL_NODE from INPUT.C when an
   #include is opened, CLONE_NODE_NEW_SERIAL when it returns to the including file), and
   the current serial is kept in LEX_FILE_SERIAL_NODE. When the code segment changes
   (#pragma codeseg in PREPROC.C, a function placed in another segment in STMTBLK.C),
   CLONE_NODE_KEEP_SERIAL adds a record with the same serial for the new segment.
   Token streams store the serial, and FIND_NODE_BY_SERIAL finds the record again to get
   the file name back (TOKSTRM.C) or for the object and assembly writers (OBJSEGS.C,
   ASMDATA.C), probably for line-number and file-name debug records.
   Record layout (14 bytes): key = the file name (an offset in the string pool), flag,
   serial, mark, context = code segment id, next = an earlier record of the same file;
   bytes 12-13 are unused here. The pool starts at offset 2, so 0 means "no record".
   Serials come from NODE_SERIAL_COUNTER, reset for each compile by CLEAR_BACKEND_STATE. */
#include <dos.h>

/* Bank descriptor view shared with INITPOOL.H (segment/capacity/used/extra). */
struct C82Bank { unsigned int segment,capacity,used,extra; };
/* 14-byte slot; bytes 12..13 are not accessed by this unit. */
struct C82Node { unsigned int key,flag,serial,mark,context,next; };

extern struct C82Bank SRCFILE_POOL_SEG;
extern unsigned int CODE_SEGMENT_ID;
extern unsigned int NODE_SERIAL_COUNTER;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *pool,unsigned int size);

/* -Z: after a far store into the arena, the compiler keeps the ES already
   loaded from SRCFILE_POOL_SEG.segment instead of reading it again (as the original
   does). This assumes arena stores never alias DS:818E or DS:86CA. */
#define NODE(h) ((struct C82Node far *)MK_FP(SRCFILE_POOL_SEG.segment,(h)))

unsigned int far pascal FIND_NODE_BY_SERIAL(unsigned int key);

/* Returns the new serial: -Z keeps the value just loaded from NODE_SERIAL_COUNTER. */
/* Adds a record for file name key in the current code segment (1 if none is defined
   yet) under a new serial and returns that serial. */
unsigned int far pascal NEW_SERIAL_NODE(unsigned int key)
{
    register unsigned int node;
    node=POOL_ALLOC(&SRCFILE_POOL_SEG.segment,14);
    NODE(node)->key=key;
    NODE(node)->context=CODE_SEGMENT_ID ? CODE_SEGMENT_ID : 1;
    NODE(node)->next=0;
    NODE(node)->flag=0;
    NODE(node)->serial=++NODE_SERIAL_COUNTER;
    NODE(node)->mark=0;
    return NODE_SERIAL_COUNTER;
}

/* key is a serial. Adds a record for the same file in the current code segment under
   the same serial, linked to the last record of the chain, and returns the serial
   (0 if the serial is unknown). */
unsigned int far pascal CLONE_NODE_KEEP_SERIAL(unsigned int key)
{
    register unsigned int old,node;
    old=FIND_NODE_BY_SERIAL(key);
    if(!old) return 0;
    node=POOL_ALLOC(&SRCFILE_POOL_SEG.segment,14);
    NODE(node)->key=NODE(old)->key;
    NODE(node)->context=CODE_SEGMENT_ID;
    while(NODE(old)->next) old=NODE(old)->next;
    NODE(node)->next=old;
    NODE(node)->flag=0;
    NODE(node)->serial=key;
    NODE(node)->mark=0;
    return NODE(node)->serial;
}

/* Returns 0, NEW_SERIAL_NODE's serial, or the new serial (-Z, as in NEW_SERIAL_NODE). */
/* key is a serial. If its record belongs to another code segment, starts afresh with
   NEW_SERIAL_NODE for the same file; else adds a record for the same file and segment
   under a new serial. Returns the new serial, or 0 if key is unknown. */
unsigned int far pascal CLONE_NODE_NEW_SERIAL(unsigned int key)
{
    register unsigned int old,node;
    old=FIND_NODE_BY_SERIAL(key);
    if(!old) return 0;
    if(NODE(old)->context!=CODE_SEGMENT_ID) return NEW_SERIAL_NODE(NODE(old)->key);
    node=POOL_ALLOC(&SRCFILE_POOL_SEG.segment,14);
    NODE(node)->key=NODE(old)->key;
    NODE(node)->context=NODE(old)->context;
    while(NODE(old)->next) old=NODE(old)->next;
    NODE(node)->next=old;
    NODE(node)->flag=0;
    NODE(node)->serial=++NODE_SERIAL_COUNTER;
    NODE(node)->mark=0;
    return NODE_SERIAL_COUNTER;
}

/* Returns the offset of the last record with serial key, or 0. A linear scan of the
   whole pool. */
unsigned int far pascal FIND_NODE_BY_SERIAL(unsigned int key)
{
    register unsigned int node,found;
    found=0;
    for(node=2;node<SRCFILE_POOL_SEG.used;node+=14)
        if(NODE(node)->serial==key) found=node;
    return found;
}

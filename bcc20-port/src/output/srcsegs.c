/* srcsegs.c: from bcc20/src/output/SRCSEGS.C (overlay CO064): a small table of source-file
   records kept in SRCFILE_POOL_SEG, each naming one source file used in one code segment and
   numbered by a serial.  The lexer makes a record whenever it starts reading a file
   (NEW_SERIAL_NODE when an #include is opened, CLONE_NODE_NEW_SERIAL when it returns to the
   including file), and the current serial is kept in LEX_FILE_SERIAL_NODE.  When the code
   segment changes (#pragma codeseg, a function placed in another segment),
   CLONE_NODE_KEEP_SERIAL adds a record with the same serial for the new segment.  Token
   streams store the serial, and FIND_NODE_BY_SERIAL finds the record again to get the file
   name back or for the object and assembly writers, probably for line-number and file-name
   debug records.
   Record layout (14 bytes): 0 the file name (an offset in the string pool), 2 a flag, 4 the
   serial, 6 a mark, 8 the code segment id, 10 an earlier record of the same file; bytes 12-13
   are unused here.  The pool starts at offset 2, so 0 means no record.  Serials come from
   NODE_SERIAL_COUNTER, reset for each compile.  The pool's descriptor is segment, capacity,
   used, extra. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define NODE_SERIAL_COUNTER W(NODE_SERIAL_COUNTER_P)
#define SRCFILE_POOL_USED W(fp_add(SRCFILE_POOL_SEG_P, 4))

#define NODE_KEY 0
#define NODE_FLAG 2
#define NODE_SERIAL 4
#define NODE_MARK 6
#define NODE_CONTEXT 8
#define NODE_NEXT 10
#define NODE(r, o) W(MK_FP(SRCFILE_POOL_SEG, (r) + (o)))

/* adds a record for file name key in the current code segment (1 if none is defined yet)
   under a new serial and returns that serial */
u16 NEW_SERIAL_NODE(u16 key)
{
    u16 node = POOL_ALLOC(SRCFILE_POOL_SEG_P, 14);
    NODE(node, NODE_KEY) = key;
    NODE(node, NODE_CONTEXT) = CODE_SEGMENT_ID ? CODE_SEGMENT_ID : 1;
    NODE(node, NODE_NEXT) = 0;
    NODE(node, NODE_FLAG) = 0;
    NODE(node, NODE_SERIAL) = ++NODE_SERIAL_COUNTER;
    NODE(node, NODE_MARK) = 0;
    return NODE_SERIAL_COUNTER;
}

/* a new record for the file of record old, after the last record of old's chain */
static u16 clone_node(u16 old, u16 context)
{
    u16 node = POOL_ALLOC(SRCFILE_POOL_SEG_P, 14);
    NODE(node, NODE_KEY) = NODE(old, NODE_KEY);
    NODE(node, NODE_CONTEXT) = context;
    while (NODE(old, NODE_NEXT))
        old = NODE(old, NODE_NEXT);
    NODE(node, NODE_NEXT) = old;
    NODE(node, NODE_FLAG) = 0;
    return node;
}

/* key is a serial.  Adds a record for the same file in the current code segment under the
   same serial, linked to the last record of the chain, and returns the serial (0 if the
   serial is unknown) */
u16 CLONE_NODE_KEEP_SERIAL(u16 key)
{
    u16 old = FIND_NODE_BY_SERIAL(key);
    if (!old)
        return 0;
    u16 node = clone_node(old, CODE_SEGMENT_ID);
    NODE(node, NODE_SERIAL) = key;
    NODE(node, NODE_MARK) = 0;
    return NODE(node, NODE_SERIAL);
}

/* key is a serial.  If its record belongs to another code segment, starts afresh with
   NEW_SERIAL_NODE for the same file; else adds a record for the same file and segment under
   a new serial.  Returns the new serial, or 0 if key is unknown */
u16 CLONE_NODE_NEW_SERIAL(u16 key)
{
    u16 old = FIND_NODE_BY_SERIAL(key);
    if (!old)
        return 0;
    if (NODE(old, NODE_CONTEXT) != CODE_SEGMENT_ID)
        return NEW_SERIAL_NODE(NODE(old, NODE_KEY));
    u16 node = clone_node(old, NODE(old, NODE_CONTEXT));
    NODE(node, NODE_SERIAL) = ++NODE_SERIAL_COUNTER;
    NODE(node, NODE_MARK) = 0;
    return NODE_SERIAL_COUNTER;
}

/* the offset of the last record with serial key, or 0: a linear scan of the whole pool */
u16 FIND_NODE_BY_SERIAL(u16 key)
{
    u16 found = 0;
    for (u16 node = 2; node < SRCFILE_POOL_USED; node += 14)
        if (NODE(node, NODE_SERIAL) == key)
            found = node;
    return found;
}

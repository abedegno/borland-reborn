/* target: ovr145_C108UNIT */
/* Role: object output: segment, group and data-buffer manager. Entry points:
   DEFINE_SEGMENT, DEFINE_SEGMENT_FIXED_ID, SELECT_SEGMENT, CURRENT_SEGMENT_SIZE,
   FIND_SEGMENT, ADD_LINENUM_ENTRY, ADD_RELOCATION, RESERVE_BYTES (+7 more). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Original CO056 (ovr_1d4a_a000) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the segment and group table of the module being compiled, and the in-memory
   image of each segment's data, kept until OBJ_WRITE_MODULE (OMFWRITE.C) writes it out.
   Records live in SEGDEF_POOL_SEG (layout: FIELDS.H SEGDEF_* for segments, SEGGRP_* for
   the 6-byte group records). Segment ids are numbered from 1 (SEGMENT_COUNT) and are the
   OMF segment indexes; group ids likewise (GROUP_COUNT). Segments are listed from
   SEGMENT_LIST_HEAD, groups from GROUP_LIST_HEAD.
   One segment is "selected" (SELECT_SEGMENT: SELECTED_SEGMENT_ID and its record
   SELECTED_SEGDEF_ENTRY); data and relocations go to it. Its data is a chain of data
   blocks (SEG_DATA_BLOCK_POOL_SEG, 10 bytes: start offset, length up to 400h,
   relocation list, next), each written later as one LEDATA record; the bytes themselves
   are in one heap buffer per segment (SEGDEF_BUFFER_HANDLE), grown 1 KB at a time.
   A segment without data blocks only counts its size (uninitialized data). Relocations
   (RELOCATION_POOL_SEG, 8 bytes: next, offset in block, symbol or value, kind) become
   FIXUPP entries. While code is being generated (CODE_OUTPUT_FLAGS bit 2) bytes go to
   the code buffer instead (EMIT_CODE_BYTE).
   ADD_LINENUM_ENTRY records line numbers per source-file record (SRCFILE_POOL_SEG, see
   SRCSEGS.C) for the LINNUM records. Every segment is limited to 64 KB ("Too much global
   data defined in file"). The register pseudo-variable code (_SI, _DI, _ES, _BX) is kept
   as written for byte matching; _SI=_SI does nothing. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STAOV001 (listing ovr_1d4a_a000:0000) ---- */
extern unsigned int STRING_POOL_SEG; extern unsigned int SEGMENT_LIST_HEAD;
extern int far pascal COMPARE_NAME(char far *,char far *);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern void far * far pascal RTL_MEMSET(void far *,int,unsigned int);

/* Returns the id of the segment named name in group key with class other (all
   string-pool offsets; key 0 = no group), creating the group and the segment if they do
   not exist yet. flag is the alignment for a new segment: 1 byte, 2 word, 16
   paragraph. An existing segment is matched by name, group and class only. */
unsigned int far pascal DEFINE_SEGMENT(unsigned int flag,unsigned int name,unsigned int key,unsigned int other)
{
    register unsigned int record,group;
    if(key) {
        group=GROUP_LIST_HEAD;
        while(group) {
            _ES=SEGDEF_POOL_SEG;
            if(COMPARE_NAME(MK_FP(STRING_POOL_SEG,ES_W(group,SEGGRP_NAME)),MK_FP(STRING_POOL_SEG,key))==0) break;
            _ES=SEGDEF_POOL_SEG;
            group=ES_W(group,SEGGRP_NEXT);
        }
        if(!group) {
            group=POOL_ALLOC(&SEGDEF_POOL_SEG,6);
            ++GROUP_COUNT;
            _ES=SEGDEF_POOL_SEG;
            ES_W(group,SEGGRP_INDEX)=GROUP_COUNT;
            ES_W(group,SEGGRP_NAME)=key;
            ES_W(group,SEGGRP_NEXT)=0;
            if(GROUP_LIST_HEAD==0) GROUP_LIST_HEAD=group;
            else {
                _ES=SEGDEF_POOL_SEG;
                _BX=GROUP_LIST_TAIL;
                ES_W(_BX,SEGGRP_NEXT)=group;
            }
            GROUP_LIST_TAIL=group;
        }
    } else group=0;
    record=SEGMENT_LIST_HEAD;
    while(record) {
        _ES=SEGDEF_POOL_SEG;
        if(COMPARE_NAME(MK_FP(STRING_POOL_SEG,ES_W(record,SEGDEF_NAME)),MK_FP(STRING_POOL_SEG,name))==0) {
            _ES=SEGDEF_POOL_SEG;
            if(ES_W(record,SEGDEF_GROUP)==group && COMPARE_NAME(MK_FP(STRING_POOL_SEG,ES_W(record,SEGDEF_CLASS_NAME)),MK_FP(STRING_POOL_SEG,other))==0) {
                _ES=SEGDEF_POOL_SEG;
                return ES_W(record,SEGDEF_INDEX);
            }
        }
        _ES=SEGDEF_POOL_SEG;
        record=ES_W(record,SEGDEF_NEXT);
    }
    record=POOL_ALLOC(&SEGDEF_POOL_SEG,0x1B);
    RTL_MEMSET(MK_FP(SEGDEF_POOL_SEG,record),0,0x1B);
    _ES=SEGDEF_POOL_SEG;
    ES_W(record,SEGDEF_NAME)=name;
    ES_W(record,SEGDEF_CLASS_NAME)=other;
    ++SEGMENT_COUNT;
    ES_W(record,SEGDEF_INDEX)=SEGMENT_COUNT;
    ES_W(record,SEGDEF_GROUP)=group;
    *((unsigned char far *)MK_FP(_ES,record+SEGDEF_ALIGN))=flag;
    ES_W(record,SEGDEF_PARENT_ID)=0;
    if(SEGMENT_LIST_HEAD) {
        _BX=SEGMENT_LIST_TAIL;
        ES_W(_BX,SEGDEF_NEXT)=record;
    } else SEGMENT_LIST_HEAD=record;
    SEGMENT_LIST_TAIL=record;
    return SEGMENT_COUNT;
}

/* ---- STAOV002 (listing ovr_1d4a_a000:0150) ---- */
/* Adds a segment record named value4 with alignment value3 (no group, class offset 0)
   and gives it the caller's id value1 and parent value2 (SEGDEF_PARENT_ID), without
   using up a segment number. Used for virtual segments (CPPCTOR.C, CPPFINAL.C pass
   4000h + OBJ_EXTERN_INDEX), which are written as B0h records inside their parent.
   Returns value1. */
unsigned int far pascal DEFINE_SEGMENT_FIXED_ID(register unsigned int value1,unsigned int value2,unsigned int value3,unsigned int value4)
{
    unsigned int saved;
    saved=SEGMENT_COUNT;
    DEFINE_SEGMENT(value3,value4,0,0);
    SEGMENT_COUNT=saved;
    *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG,SEGMENT_LIST_TAIL+SEGDEF_INDEX)=value1;
    *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG,SEGMENT_LIST_TAIL+SEGDEF_PARENT_ID)=value2;
    return value1;
}

/* ---- STAOV003 (listing ovr_1d4a_a000:018F) ---- */
unsigned int far pascal FIND_SEGMENT(unsigned int value);

/* Makes segment id value the selected one (value 0 changes nothing) and returns the
   previously selected id. */
unsigned int far pascal SELECT_SEGMENT(register unsigned int value)
{
    register unsigned int old=SELECTED_SEGMENT_ID;
    if (!value) return old;
    SELECTED_SEGDEF_COPY=SELECTED_SEGDEF_ENTRY=FIND_SEGMENT(value);
    SELECTED_SEGMENT_ID=value;
    return old;
}

/* ---- STAOV004 (listing ovr_1d4a_a000:01B9) ---- */

/* Size so far (the location counter) of the selected segment. */
long far pascal CURRENT_SEGMENT_SIZE(void)
{
    return *(unsigned long far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE);
}

/* ---- STAOV005 (listing ovr_1d4a_a000:01CE) ---- */
extern unsigned int SEGMENT_LIST_HEAD;

/* Returns the record of segment id value (word 2 is SEGDEF_INDEX), or 0. */
unsigned int far pascal FIND_SEGMENT(unsigned int value)
{
    register unsigned int cursor,key;
    key = value;
    cursor = SEGMENT_LIST_HEAD;
    while (cursor) {
        if (((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, cursor))[2] == key)
            return cursor;
        cursor = ((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, cursor))[0];
    }
    return 0;
}

/* ---- STAOV006 (listing ovr_1d4a_a000:01FD) ---- */
#define W(s,o,i) (((unsigned int far *)MK_FP((s),(o)))[i])

/* Appends a new empty data block to segment record value, starting at the segment's
   current size (word 6 = low word of SEGDEF_SIZE; words 3 and 4 are SEGDEF_FIRST_BLOCK
   and SEGDEF_LAST_BLOCK), and returns it. */
static unsigned int near pascal ALLOCATE_DATA_BLOCK(register unsigned int value)
{
    unsigned int block;
    block = POOL_ALLOC(&SEG_DATA_BLOCK_POOL_SEG, 10);
    RTL_MEMSET(MK_FP(SEG_DATA_BLOCK_POOL_SEG, block), 0, 10);
    W(SEG_DATA_BLOCK_POOL_SEG, block, 0) = W(SEGDEF_POOL_SEG, value, 6);
    W(SEG_DATA_BLOCK_POOL_SEG, block, 4) = 0;
    if (W(SEGDEF_POOL_SEG, value, 3))
        W(SEG_DATA_BLOCK_POOL_SEG, W(SEGDEF_POOL_SEG, value, 4), 4) = block;
    else
        W(SEGDEF_POOL_SEG, value, 3) = block;
    W(SEGDEF_POOL_SEG, value, 4) = block;
    return block;
}
#undef W

/* ---- STAOV007 (listing ovr_1d4a_a000:026E) ---- */
extern unsigned int SRCFILE_POOL_SEG; extern unsigned int CODE_SEGMENT_ID;
extern unsigned int far pascal FIND_NODE_BY_SERIAL(unsigned int);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *, unsigned int);

/* Records that source line value of the file with serial name starts at the current
   offset of the selected segment. A file record's line entries must be contiguous in
   LINE_NUMBER_POOL_SEG, so if a later record already has lines, a new record for the same
   file and the current code segment is made first. A line equal to the last one, or a
   smaller line already recorded, is not added again. The stored offset is made relative
   to the current code fragment (CURRENT_CODE_FRAGMENT), which counts its lines, probably
   because fragments still move when jumps are shortened. */
void far pascal ADD_LINENUM_ENTRY(unsigned int name, unsigned int value)
{
    unsigned int slot;
    unsigned int limit;
    unsigned int saved;

    _DI = FIND_NODE_BY_SERIAL(name);
    if (_DI) {
        _SI = _DI + 14;
        while (_SI < SEGMENT_POOL_USED) {
            _ES = SRCFILE_POOL_SEG;
            if (ES_W(_SI, SRCFILE_LINE_COUNT) != 0) {
                _SI = POOL_ALLOC(&SRCFILE_POOL_SEG, 14);
                _ES = SRCFILE_POOL_SEG;
                ES_W(_SI, SRCFILE_NAME) = ES_W(_DI, SRCFILE_NAME);
                ES_W(_SI, SRCFILE_SEGMENT) = CODE_SEGMENT_ID;
                ES_W(_SI, SRCFILE_FIRST_NODE) = ES_W(_DI, SRCFILE_FIRST_NODE);
                ES_W(_SI, SRCFILE_LINE_COUNT) = 0;
                ES_W(_SI, SRCFILE_SERIAL) = ES_W(_DI, SRCFILE_SERIAL);
                ES_W(_SI, SRCFILE_DEBUG_INDEX) = ES_W(_DI, SRCFILE_DEBUG_INDEX);
                _DI = _SI;
                break;
            }
            _SI += 14;
        }
        _BX = SELECTED_SEGDEF_ENTRY;
        _ES = SEGDEF_POOL_SEG;
        saved = ES_W(_BX, SEGDEF_SIZE);
        limit = LINE_NUMBER_POOL_USED;
        _ES = SRCFILE_POOL_SEG;
        if (ES_W(_DI, SRCFILE_LINE_COUNT) == 0) {
            ES_W(_DI, SRCFILE_FIRST_LINE) = limit;
        } else {
            _ES = SRCFILE_POOL_SEG;
            if (ES_W(_DI, SRCFILE_FIRST_LINE) < limit) {
                limit -= 4;
                _ES = LINE_NUMBER_POOL_SEG;
                _BX = limit;
                if (ES_W(_BX, LINENUM_LINE) == value)
                    return;
                _ES = LINE_NUMBER_POOL_SEG;
                _BX = limit;
                if (ES_W(_BX, LINENUM_LINE) > value) {
                    _ES = SRCFILE_POOL_SEG;
                    slot = ES_W(_DI, SRCFILE_FIRST_LINE);
                    while (slot <= limit) {
                        _ES = LINE_NUMBER_POOL_SEG;
                        _BX = slot;
                        if (ES_W(_BX, LINENUM_LINE) == value)
                            return;
                        slot += 4;
                    }
                }
            }
        }
        slot = POOL_ALLOC(&LINE_NUMBER_POOL_SEG, 4);
        _ES = SRCFILE_POOL_SEG;
        ES_W(_DI, SRCFILE_LINE_COUNT)++;
        _ES = LINE_NUMBER_POOL_SEG;
        _BX = slot;
        ES_W(_BX, LINENUM_LINE) = value;
        ES_W(_BX, LINENUM_OFFSET) = saved;
        _BX = CURRENT_CODE_FRAGMENT;
        _ES = CODE_FRAGMENT_POOL_SEG;
        if (ES_W(_BX, FRAG_LINE_COUNT) == 0)
            ES_W(_BX, FRAG_FIRST_LINE) = slot;
        _BX = CURRENT_CODE_FRAGMENT;
        _ES = CODE_FRAGMENT_POOL_SEG;
        ES_W(_BX, FRAG_LINE_COUNT)++;
        _AX = ES_W(_BX, FRAG_START_OFFSET);
        _BX = slot;
        _ES = LINE_NUMBER_POOL_SEG;
        ES_W(_BX, LINENUM_OFFSET) -= _AX;
    }
}

/* ---- STAOV008 (listing ovr_1d4a_a000:03CD) ---- */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *, unsigned int);

/* Adds a relocation of kind kind for target value at the current end of the selected
   segment's last data block. A new block is started first if the bytes the fixup covers
   (4 for kind 7, a far pointer; 2 otherwise) would not fit, so a fixup never spans two
   LEDATA records. The caller writes the bytes next. */
void far pascal ADD_RELOCATION(unsigned int kind, unsigned int value)
{
    unsigned int current;
    current = SELECTED_SEGDEF_ENTRY;
    _BX = current;
    _ES = SEGDEF_POOL_SEG;
    if (ES_W(_BX, SEGDEF_FIRST_BLOCK) == 0)
        _SI = ALLOCATE_DATA_BLOCK(current);
    else {
        _BX = current;
        _ES = SEGDEF_POOL_SEG;
        _SI = ES_W(_BX, SEGDEF_LAST_BLOCK);
    }
    if (kind == 7) {
        _ES = SEG_DATA_BLOCK_POOL_SEG;
        if (ES_W(_SI, SEGBLK_LENGTH) > 0x3FC) {
            _SI = ALLOCATE_DATA_BLOCK(current);
            _SI = _SI;
        }
    } else {
        _ES = SEG_DATA_BLOCK_POOL_SEG;
        if (ES_W(_SI, SEGBLK_LENGTH) > 0x3FE)
            _SI = ALLOCATE_DATA_BLOCK(current);
    }
    _DI = POOL_ALLOC(&RELOCATION_POOL_SEG, 8);
    _ES = RELOCATION_POOL_SEG;
    ES_W(_DI, RELOC_KIND) = kind;
    _ES = SEG_DATA_BLOCK_POOL_SEG;
    _AX = ES_W(_SI, SEGBLK_LENGTH);
    _ES = RELOCATION_POOL_SEG;
    ES_W(_DI, RELOC_OFFSET) = _AX;
    ES_W(_DI, RELOC_SYMBOL) = value;
    _ES = SEG_DATA_BLOCK_POOL_SEG;
    _AX = ES_W(_SI, SEGBLK_RELOCS);
    _ES = RELOCATION_POOL_SEG;
    ES_W(_DI, RELOC_NEXT) = _AX;
    _ES = SEG_DATA_BLOCK_POOL_SEG;
    ES_W(_SI, SEGBLK_RELOCS) = _DI;
}

/* ---- STAOV009 (listing ovr_1d4a_a000:047E) ---- */
void far pascal EMIT_DATA_BYTE(unsigned char value);
extern void far cdecl REPORT_FATAL(unsigned int kind, unsigned int message);

/* Adds count bytes of zeros: only the size grows while the segment has no data blocks
   (uninitialized data); otherwise real zero bytes are written. */
void far pascal RESERVE_BYTES(register unsigned int count)
{
    register unsigned int node = SELECTED_SEGDEF_ENTRY;
    long value;

    if (*((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_FIRST_BLOCK)) == 0) {
        value = *((long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) + count;
        if (value > 0x10000L)
            REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA, *((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_NAME)));
        *((long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) = value;
    } else {
        while (count) {
            count--;
            EMIT_DATA_BYTE(0);
        }
    }
}

/* ---- STAOV010 (listing ovr_1d4a_a000:04F6) ---- */
extern void far pascal EMIT_CODE_BYTE(unsigned char value);

/* For an alignment of 2 or more, makes the selected segment's size even: a 0 code byte,
   a size round-up (no data yet), or a 0 data byte. */
void far pascal ALIGN_SEGMENT_EVEN(int value)
{
    register unsigned int node;

    if (value < 2)
        return;
    node = SELECTED_SEGDEF_ENTRY;
    if (CODE_OUTPUT_FLAGS & 4) {
        if ((*((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) & 1UL) != 0L)
            EMIT_CODE_BYTE(0);
    } else if (*((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_FIRST_BLOCK)) == 0) {
        *((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) += 1;
        *((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) &= 0xFFFFFFFEUL;
    } else {
        if ((*((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, node + SEGDEF_SIZE)) & 1UL) != 0L)
            EMIT_DATA_BYTE(0);
    }
}

/* ---- STAOV011 (listing ovr_1d4a_a000:0566) ---- */
extern void far pascal EMIT_CODE_BYTE(unsigned char);
extern unsigned int far * far pascal HEAP_ALLOC_HANDLE(unsigned int);
extern void far pascal RESIZE_POOL_BLOCK(unsigned int far *,unsigned int);
extern void far cdecl REPORT_FATAL(unsigned int,unsigned int);
#define HANDLE(r) (*((unsigned int far * far *)MK_FP(SEGDEF_POOL_SEG,(r)+0x13)))

/* Appends one byte to the selected segment: to the code buffer while code is being
   generated, else to the last data block (a new one every 400h bytes) and the segment's
   heap buffer, which is created on first use and grown by 1 KB whenever the offset from
   SEGDEF_BUFFER_BASE reaches a multiple of 400h (a full 64 KB request becomes FFFFh). */
void far pascal EMIT_DATA_BYTE(unsigned char value)
{
    unsigned int delta,position,size;
    register unsigned int node;
    register unsigned int block;
    node=SELECTED_SEGDEF_ENTRY;
    if (CODE_OUTPUT_FLAGS&4) {
        EMIT_CODE_BYTE(value);
        return;
    }
    block=SEGDEF_W(node,SEGDEF_LAST_BLOCK);
    if (!block || SEGBLK_W(block,SEGBLK_LENGTH)>=0x400)
        block=ALLOCATE_DATA_BLOCK(node);
    if (HANDLE(node)==0) {
        HANDLE(node)=HEAP_ALLOC_HANDLE(0x400);
        SEGDEF_W(node,SEGDEF_BUFFER_BASE)=SEGBLK_W(block,SEGBLK_START)+SEGBLK_W(block,SEGBLK_LENGTH);
    }
    position=SEGBLK_W(block,SEGBLK_START)+SEGBLK_W(block,SEGBLK_LENGTH);
    delta=position-SEGDEF_W(node,SEGDEF_BUFFER_BASE);
    if ((delta&0x3FF)==0) {
        size=delta+0x400;
        if (size==0) size=0xFFFF;
        RESIZE_POOL_BLOCK(HANDLE(node),size);
    }
    *((unsigned char far *)MK_FP(*HANDLE(node),delta))=value;
    ++SEGBLK_W(block,SEGBLK_LENGTH);
    if (*((long far *)MK_FP(SEGDEF_POOL_SEG,node+SEGDEF_SIZE))>=0x10000L)
        REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA,SEGDEF_W(node,SEGDEF_NAME));
    ++*((long far *)MK_FP(SEGDEF_POOL_SEG,node+SEGDEF_SIZE));
}
#undef HANDLE

/* ---- STAOV012 (listing ovr_1d4a_a000:0679) ---- */
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int, unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int, unsigned int);

/* Places symbol value at the current position: segment = selected segment id (word 2),
   offset = its current size (word 6, the low word of SEGDEF_SIZE). */
void far pascal SET_SYMBOL_AT_CURRENT_POS(unsigned int value)
{
    register unsigned int item;
    item = SELECTED_SEGDEF_ENTRY;
    SET_SYMBOL_SEGMENT_HOOK(value, ((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, item))[2]);
    SET_SYMBOL_OFFSET_HOOK(value, ((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, item))[6]);
}

/* ---- STAOV013 (listing ovr_1d4a_a000:06A5) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal ADD_JUMP(unsigned int first, unsigned int second,
                               unsigned int third);
extern void far pascal START_NEXT_FRAGMENT(void);

/* Same as ADD_JUMP_18_NEXT_FRAGMENT in ASMDATA.C, for the object-file hook table: a jump
   (code-op 18h) to flow block value, then a new code fragment. */
void far pascal ADD_JUMP_18_NEXT_FRAGMENT_ALT(unsigned int value)
{
    register unsigned int node = value;

    ADD_JUMP(0x18, node,
            ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[14] & 0x100);
    START_NEXT_FRAGMENT();
}

/* ---- STAOV014 (listing ovr_1d4a_a000:06CC) ---- */
/* Writes a 16-bit address of target mode plus value (relocation kind 1). */
void far pascal EMIT_WORD_RELOC(unsigned int mode, unsigned int value)
{
    ADD_RELOCATION(1, mode);
    EMIT_DATA_BYTE((unsigned char)value);
    EMIT_DATA_BYTE((unsigned char)(value >> 8));
}

/* ---- STAOV015 (listing ovr_1d4a_a000:06F2) ---- */
/* Writes a 32-bit far address of target mode with offset value (relocation kind 7); the
   segment word is left 0 for the linker. */
void far pascal EMIT_DWORD_RELOC(unsigned int mode, unsigned int value)
{
    ADD_RELOCATION(7, mode);
    EMIT_DATA_BYTE((unsigned char)value);
    EMIT_DATA_BYTE((unsigned char)(value >> 8));
    EMIT_DATA_BYTE(0);
    EMIT_DATA_BYTE(0);
}

/* ---- STAOV016 (listing ovr_1d4a_a000:0726) ---- */
extern unsigned int SEGMENT_LIST_HEAD;

/* Returns 1 if any segment has a nonzero size, else 0. */
unsigned int far pascal ANY_SEGMENT_HAS_DATA(void)
{
    register unsigned int cursor;
    cursor = SEGMENT_LIST_HEAD;
    while (cursor) {
        if (*((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, cursor + SEGDEF_SIZE)))
            return 1;
        cursor = ((unsigned int far *)MK_FP(SEGDEF_POOL_SEG, cursor))[0];
    }
    return 0;
}

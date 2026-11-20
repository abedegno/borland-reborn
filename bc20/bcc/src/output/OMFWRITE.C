/* target: ovr144_C117UNIT */
/* Role: OMF object-file writer (OBJ_*). Entry points: OBJ_RESET_RECORD, OBJ_PUT_BYTE,
   OBJ_PUT_INDEX, OBJ_RECORD_LENGTH, OBJ_PUT_NAME, OBJ_PUT_WORD, OBJ_WRITE_RECORD,
   OBJ_QUEUE_WORD (+7 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO055 (ovr_1d43_9eb4) as one source. */
/* opts: -mm -G -O -Z -p -Y -B */
/* Overview: the OMF (Intel/Microsoft object module format) writer that produces the .obj
   file when BCC compiles straight to an object (COMPILER_MODE 0).
   Building records: a record body is collected in a near buffer that reuses TOKEN_TEXT_BUFFER
   (OBJ_RECORD_BUFFER returns it); OBJ_RESET_RECORD empties it, OBJ_PUT_BYTE / WORD /
   INDEX / NAME append, and OBJ_WRITE_RECORD(type) writes "type, length, body, checksum"
   through the buffered output file (OUTPUT_CHAR). When assembly text is written instead
   (COMPILER_MODE set) OBJ_WRITE_RECORD hands the body to OBJ_RECORD_HOOK, which writes it
   as a "?debug C" line (EMIT_HEX_BYTE_LIST), so debug records reach TASM unchanged.
   OBJ_BEGIN_RECORD / OBJ_OUT_BYTE / OBJ_END_RECORD write a record directly to the file,
   keeping the checksum, for records too big for the buffer (LEDATA, file stamps).
   Record types used: 80h THEADR, 88h COMENT, 8Ah MODEND, 94h LINNUM, 96h LNAMES,
   98h SEGDEF, 9Ah GRPDEF, 9Ch FIXUPP, A0h LEDATA, B0h COMDEF. COMENT classes (the second
   byte; the first, attribute, is 0): 00h translator name, E8h source file, E9h
   dependency (file time and name), EAh Turbo Debugger version and memory model, EEh a
   list of code offsets, A1h written for overlay code.
   OBJ_WRITE_MODULE writes the whole module at the end: the string literals into the data
   segment, LNAMES, SEGDEF, GRPDEF, the external and public records (OBJ_WRITE_MODULE_HOOK,
   probably EMIT_EXTDEF_PUBDEF_RECORDS of OBJPUBS.C or its C twin), the data of every segment with its
   fixups, the line numbers, and MODEND. The segment records are FIELDS.H SEGDEF_*;
   NAME(n,o) reads a string-pool name whose offset is at offset o of segment record n
   (17 = SEGDEF_NAME, 10 = SEGDEF_CLASS_NAME, 4 = a group's name). */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- OUTRESET (listing ovr_1d43_9eb4:EB40) ---- */
/* Starts a new record body at the start of the buffer. */
void far pascal OBJ_RESET_RECORD(void)
{
    OBJ_RECORD_CURSOR=(unsigned char near *)TOKEN_TEXT_BUFFER;
}

/* ---- STOVR168 (listing ovr_1d43_9eb4:EB4B) ---- */
void far pascal OBJ_PUT_BYTE(unsigned char value)
{
    *OBJ_RECORD_CURSOR=value;
    ++OBJ_RECORD_CURSOR;
}

/* ---- STOVR169 (listing ovr_1d43_9eb4:EB5F) ---- */
/* Appends an OMF index: one byte below 128, else two bytes with bit 7 set in the first
   (high byte first). */
void far pascal OBJ_PUT_INDEX(unsigned int value)
{
    if(value>127) {
        OBJ_PUT_BYTE(0x80|(value>>8));
        value&=0xFF;
    }
    OBJ_PUT_BYTE((unsigned char)value);
}

/* ---- STOVR170 (listing ovr_1d43_9eb4:EB89) ---- */
/* Number of bytes in the record body so far. */
int far pascal OBJ_RECORD_LENGTH(void)
{
    return OBJ_RECORD_CURSOR-(unsigned char near *)TOKEN_TEXT_BUFFER;
}

/* ---- STOVR171 (listing ovr_1d43_9eb4:EB94) ---- */
/* Appends a length-prefixed name. */
void far pascal OBJ_PUT_NAME(char far *text)
{
    OBJ_PUT_BYTE(STRING_LENGTH(text));
    while(*text) OBJ_PUT_BYTE(*text++);
}

/* ---- STOVR172 (listing ovr_1d43_9eb4:EBBF) ---- */
void far pascal OBJ_PUT_WORD(unsigned int value)
{
    OBJ_PUT_BYTE((unsigned char)value);
    OBJ_PUT_BYTE(value>>8);
}

/* ---- STOVR173 (listing ovr_1d43_9eb4:EBDA) ---- */
static void near pascal OBJ_BEGIN_RECORD(unsigned char type,unsigned int length);
static void near pascal OBJ_OUT_BYTE(unsigned char value);
static void near pascal OBJ_END_RECORD(void);
extern unsigned char COMPILER_MODE;
extern void (far pascal *OBJ_RECORD_HOOK)(unsigned int);
/* Writes the collected body as a record of type type (nothing if the body is empty).
   The length field counts the body plus the checksum byte. In assembly mode the body
   goes to OBJ_RECORD_HOOK with its length instead. Does not reset the buffer. */
void far pascal OBJ_WRITE_RECORD(unsigned char type)
{
    unsigned char far *p;
    register int length=OBJ_RECORD_CURSOR-TOKEN_TEXT_BUFFER;
    if(length>0) {
        if(COMPILER_MODE) OBJ_RECORD_HOOK(length);
        else {
            OBJ_BEGIN_RECORD(type,length+1);
            p=TOKEN_TEXT_BUFFER;
            while(OBJ_RECORD_CURSOR>(unsigned char near *)p) {
                OBJ_OUT_BYTE(*p);
                ++p;
            }
            OBJ_END_RECORD();
        }
    }
}

/* ---- STOVR174 (listing ovr_1d43_9eb4:EC2F) ---- */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
/* Queues one word (a code offset, from BLKLAYOT.C under -v) for OBJ_FLUSH_QUEUED_WORDS. */
void far pascal OBJ_QUEUE_WORD(unsigned int value)
{
    register unsigned int node=POOL_ALLOC(&QUEUED_WORD_POOL_SEG,2);
    *(unsigned int far *)MK_FP(QUEUED_WORD_POOL_SEG,node)=value;
}

/* ---- STOVR175 (listing ovr_1d43_9eb4:EC52) ---- */
/* Writes the queued words as COMENT class EEh records: segment index of the selected
   segment, then up to 1024 words per record. Empties the queue. */
void far pascal OBJ_FLUSH_QUEUED_WORDS(void)
{
    register unsigned int offset;
    register int count;
    if(QUEUED_WORD_POOL_USED) {
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        *(unsigned int near *)OBJ_RECORD_CURSOR=0xEE00;
        OBJ_RECORD_CURSOR+=2;
        OBJ_PUT_INDEX(SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_INDEX));
        count=0;
        offset=0;
        while(offset<QUEUED_WORD_POOL_USED) {
            if(count>1023) {
                OBJ_WRITE_RECORD(0x88);
                OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
                *(unsigned int near *)OBJ_RECORD_CURSOR=0xEE00;
                OBJ_RECORD_CURSOR+=2;
                OBJ_PUT_INDEX(SEGDEF_W(SELECTED_SEGDEF_ENTRY,SEGDEF_INDEX));
                count=0;
            }
            *(unsigned int near *)OBJ_RECORD_CURSOR=QWORD_W(offset,QWORD_VALUE);
            OBJ_RECORD_CURSOR+=2;
            ++count;
            offset+=2;
        }
        OBJ_WRITE_RECORD(0x88);
        QUEUED_WORD_POOL_FREE=0;
        QUEUED_WORD_POOL_USED=0;
    }
}

/* ---- STOVR176 (listing ovr_1d43_9eb4:ECEE) ---- */
extern unsigned int STRING_POOL_SEG; extern unsigned int SRCFILE_POOL_SEG;
extern long far pascal FILE_TIME(char far *);
/* Writes a COMENT class E8h naming source file record node (a SRCFILE_POOL_SEG record;
   the first record of the same file is used). The first time: byte 0, the name and the
   file's time stamp, and the file gets the next free debug index (largest so far + 1);
   later times: just that index. */
void far pascal OBJ_WRITE_FILE_ENTRY(register unsigned int node)
{
    union { long value; unsigned char bytes[4]; } stamp;
    unsigned int maximum=0;
    char path[80];
    register unsigned int item;
    OBJ_RECORD_CURSOR=(unsigned char near *)TOKEN_TEXT_BUFFER;
    *(unsigned int near *)OBJ_RECORD_CURSOR=0xe800;
    OBJ_RECORD_CURSOR+=2;
    if(SRCFILE_W(node,SRCFILE_FIRST_NODE)) node=SRCFILE_W(node,SRCFILE_FIRST_NODE);
    if(!SRCFILE_W(node,SRCFILE_DEBUG_INDEX)) {
        *OBJ_RECORD_CURSOR++=0;
        OBJ_PUT_NAME((char far *)MK_FP(STRING_POOL_SEG,SRCFILE_W(node,SRCFILE_NAME)));
        STRING_COPY(path,(char far *)MK_FP((_ES=SRCFILE_POOL_SEG,STRING_POOL_SEG),*(unsigned int far *)MK_FP(_ES,node)));
        stamp.value=FILE_TIME(path);
        *OBJ_RECORD_CURSOR++=stamp.bytes[0];
        *OBJ_RECORD_CURSOR++=stamp.bytes[1];
        *OBJ_RECORD_CURSOR++=stamp.bytes[2];
        *OBJ_RECORD_CURSOR++=stamp.bytes[3];
        for(item=2;item<SEGMENT_POOL_USED;item+=14)
            if(SRCFILE_W(item,SRCFILE_DEBUG_INDEX)>maximum) maximum=SRCFILE_W(item,SRCFILE_DEBUG_INDEX);
        SRCFILE_W(node,SRCFILE_DEBUG_INDEX)=maximum+1;
    } else OBJ_PUT_INDEX(SRCFILE_W(node,SRCFILE_DEBUG_INDEX));
    OBJ_WRITE_RECORD(0x88);
}

/* ---- STOVR177 (listing ovr_1d43_9eb4:EDE8) ---- */
extern unsigned int SRCFILE_POOL_SEG; extern unsigned int NODE_SERIAL_COUNTER;
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
/* Writes the LINNUM records: code segments in ascending order; for each source file
   record with lines in that segment, a file entry and then (line, offset) pairs, at most
   1000 per record, preceded by group and segment index. Clears each record's line count
   as it goes. With no lines at all only the main file's entry (record 2) is written.
   NODE_SERIAL_COUNTER is reset to 0 here. */
static void near pascal OBJ_WRITE_LINE_NUMBERS(void)
{
    int count,remaining;
    unsigned int section,record,minimum,index;
    register unsigned int node;
    register unsigned int position;
    count=0;
    NODE_SERIAL_COUNTER=0;
    for(node=2;node<SEGMENT_POOL_USED;node+=14) {
        if(SRCFILE_W(node,SRCFILE_LINE_COUNT)) { count=1; break; }
        SRCFILE_W(node,SRCFILE_SERIAL)=0;
    }
    if(!count && SEGMENT_POOL_USED>2) OBJ_WRITE_FILE_ENTRY(2);
    else for(;;) {
        minimum=0xFFFF;
        node=0;
        for(index=2;index<SEGMENT_POOL_USED;index+=14) {
            if(SRCFILE_W(index,SRCFILE_LINE_COUNT) && SRCFILE_W(index,SRCFILE_SEGMENT)<minimum) {
                node=index;
                minimum=SRCFILE_W(index,SRCFILE_SEGMENT);
            }
        }
        if(!node) break;
        for(;node<SEGMENT_POOL_USED;node+=14) {
            if(SRCFILE_W(node,SRCFILE_LINE_COUNT) && SRCFILE_W(node,SRCFILE_SEGMENT)==minimum) {
                _ES=SRCFILE_POOL_SEG;
                remaining=ES_W(node,SRCFILE_LINE_COUNT);
                ES_W(node,SRCFILE_LINE_COUNT)=0;
                OBJ_WRITE_FILE_ENTRY(node);
                count=0;
                record=FIND_SEGMENT(SRCFILE_W(node,SRCFILE_SEGMENT));
                if(record && SEGDEF_W(record,SEGDEF_GROUP))
                    section=SEGDEF_W(SEGDEF_W(record,SEGDEF_GROUP),SEGDEF_GROUP);
                else section=0;
                OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
                OBJ_PUT_INDEX(section);
                OBJ_PUT_INDEX(SRCFILE_W(node,SRCFILE_SEGMENT));
                position=SRCFILE_W(node,SRCFILE_FIRST_LINE);
                while(--remaining>=0) {
                    if(count>=1000) {
                        OBJ_WRITE_RECORD(0x94);
                        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
                        OBJ_PUT_INDEX(section);
                        OBJ_PUT_INDEX(SRCFILE_W(node,SRCFILE_SEGMENT));
                        count=0;
                    }
                    *(unsigned int near *)OBJ_RECORD_CURSOR=LINENUM_W(position,LINENUM_LINE);
                    OBJ_RECORD_CURSOR+=2;
                    *(unsigned int near *)OBJ_RECORD_CURSOR=LINENUM_W(position,LINENUM_OFFSET);
                    OBJ_RECORD_CURSOR+=2;
                    position+=4;
                    ++count;
                }
                OBJ_WRITE_RECORD(0x94);
            }
        }
    }
}

/* ---- STOVR178 (listing ovr_1d43_9eb4:EF87) ---- */
extern unsigned char OPTION_OVERLAY_CODE;
/* Starts the object file: THEADR with the module name text, a translator COMENT
   "TC86 Borland Turbo C++ 2.0", and for overlay code a COMENT class A1h with the bytes
   01h, 'T', 'D'. Called from ASMCODE.C when the object file is created. */
void far pascal OBJ_WRITE_MODULE_HEADER(char far *text)
{
    OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
    OBJ_PUT_NAME(text);
    OBJ_WRITE_RECORD(0x80);
    OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
    *(unsigned int near *)OBJ_RECORD_CURSOR=0;
    OBJ_RECORD_CURSOR+=2;
    OBJ_PUT_NAME((char near *)(STR_TC86_BORLAND_TURBO_C_2_0));
    OBJ_WRITE_RECORD(0x88);
    if(OPTION_OVERLAY_CODE) {
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        *(unsigned int near *)OBJ_RECORD_CURSOR=0xA100;
        OBJ_RECORD_CURSOR+=2;
        *OBJ_RECORD_CURSOR=1;
        ++OBJ_RECORD_CURSOR;
        *(unsigned int near *)OBJ_RECORD_CURSOR=0x4454;
        OBJ_RECORD_CURSOR+=2;
        OBJ_WRITE_RECORD(0x88);
    }
}

/* ---- STOVR179 (listing ovr_1d43_9eb4:F001) ---- */
extern long far pascal FILE_TIME(char far *);
/* Writes a dependency COMENT (class E9h: file time, name length, name) for source file
   text, unless auto-dependencies are off (OPTION_NO_AUTODEPEND). */
void far pascal OBJ_WRITE_FILE_STAMP(char far *text)
{
    unsigned int length;
    char far *p;
    union { long value; unsigned char bytes[4]; } timestamp;
    if(OPTION_NO_AUTODEPEND==0) {
        length=STRING_LENGTH(text);
        OBJ_BEGIN_RECORD(0x88,length+8);
        OBJ_OUT_BYTE(0);
        OBJ_OUT_BYTE(0xE9);
        timestamp.value=FILE_TIME(text);
        OBJ_OUT_BYTE(timestamp.bytes[0]);
        OBJ_OUT_BYTE(timestamp.bytes[1]);
        OBJ_OUT_BYTE(timestamp.bytes[2]);
        OBJ_OUT_BYTE(timestamp.bytes[3]);
        OBJ_OUT_BYTE((unsigned char)length);
        p=text;
        while(*p) {
            OBJ_OUT_BYTE(*p);
            ++p;
        }
        OBJ_END_RECORD();
    }
}

/* ---- STOVR180 (listing ovr_1d43_9eb4:F099) ---- */
static void near pascal OBJ_WRITE_SEGMENT_DATA(unsigned int node);
extern unsigned int STRING_POOL_SEG; extern unsigned int DATA_BYTE_POOL_SEG; extern unsigned int SEGMENT_LIST_HEAD;
extern unsigned char OPTION_MEMORY_MODEL,OPTION_UNDERSCORES,OPTION_FLAGS;
extern unsigned int (far pascal *STRING_LITERAL_SYMBOL_HOOK)(void);
extern void (far pascal *OBJ_WRITE_MODULE_HOOK)(unsigned int);
extern void far pascal EMIT_DATA_BYTE(unsigned char);
extern void far pascal SET_SYMBOL_AT_CURRENT_POS(unsigned int);
extern void far pascal SELECT_SEGMENT(unsigned int);
#define NAME(n,o) ((char far *)MK_FP((_ES=SEGDEF_POOL_SEG,STRING_POOL_SEG),*(unsigned int far *)MK_FP(_ES,(n)+(o))))
/* Writes everything after the code (see the overview). Details: the literal pool
   (DATA_BYTE_POOL_SEG) is appended to the data segment and the string-literal symbol
   placed at its start; saved, the data segment size before that, is passed to the
   extern/public writer. An empty E9h COMENT ends the dependency list (unless
   OPTION_NO_AUTODEPEND). LNAMES holds "",
   then name and class of every real segment, then the group names, so segment k's names
   are indexes 2k and 2k+1 and the groups follow. SEGDEF attribute byte: alignment in bits
   5-7 (paragraph alignment 16 is stored as 3), 2 = exactly 64 KB, 8 = public combine.
   A virtual segment (SEGDEF_PARENT_ID set) is written as a B0h record naming its parent
   segment. A group over 64 KB is fatal ("Group overflowed maximum size"). */
void far pascal OBJ_WRITE_MODULE(void)
{
    long total;
    unsigned int index,count,position,saved;
    char path[64];
    register unsigned int node;
    register unsigned int group;
    SELECT_SEGMENT(DATA_SEGMENT_ID);
    SET_SYMBOL_AT_CURRENT_POS(STRING_LITERAL_SYMBOL_HOOK());
    _BX=SELECTED_SEGDEF_ENTRY;
    saved=SEGDEF_W(_BX,SEGDEF_SIZE);
    position=0;
    count=0;
    while(count<DATA_BYTE_POOL_LENGTH) {
        EMIT_DATA_BYTE(*(unsigned char far *)MK_FP(DATA_BYTE_POOL_SEG,position));
        ++position;
        ++count;
    }
    _AX=(int)(signed char)OPTION_NO_AUTODEPEND;
    if(!_AX) {
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        *(unsigned int near *)OBJ_RECORD_CURSOR=0xE900;
        OBJ_RECORD_CURSOR+=2;
        OBJ_WRITE_RECORD(0x88);
    }
    OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
    *(unsigned int near *)OBJ_RECORD_CURSOR=0xEA00;
    OBJ_RECORD_CURSOR+=2;
    *OBJ_RECORD_CURSOR++=OPTION_FLAGS?5:1;
    *OBJ_RECORD_CURSOR++=OPTION_MEMORY_MODEL|(OPTION_UNDERSCORES<<3);
    OBJ_WRITE_RECORD(0x88);
    OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
    *OBJ_RECORD_CURSOR++=0;
    for(node=SEGMENT_LIST_HEAD;node;node=SEGDEF_W(node,SEGDEF_NEXT)) if(!SEGDEF_W(node,SEGDEF_PARENT_ID)) {
        OBJ_PUT_NAME(NAME(node,17));
        OBJ_PUT_NAME(NAME(node,10));
    }
    for(group=GROUP_LIST_HEAD;group;group=SEGDEF_W(group,SEGDEF_NEXT)) OBJ_PUT_NAME(NAME(group,4));
    OBJ_WRITE_RECORD(0x96);
    index=2;
    for(node=SEGMENT_LIST_HEAD;node;node=SEGDEF_W(node,SEGDEF_NEXT)) {
        if(SEGDEF_W(node,SEGDEF_PARENT_ID)) continue;
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        if(SEGDEF_B(node,SEGDEF_ALIGN)==16) SEGDEF_B(node,SEGDEF_ALIGN)=3;
        *OBJ_RECORD_CURSOR++=(SEGDEF_B(node,SEGDEF_ALIGN)<<5)+(SEGDEF_L(node,SEGDEF_SIZE)==0x10000L?2:0)+8;
        *(unsigned int near *)OBJ_RECORD_CURSOR=SEGDEF_W(node,SEGDEF_SIZE);
        OBJ_RECORD_CURSOR+=2;
        OBJ_PUT_INDEX(index);
        OBJ_PUT_INDEX(index+1);
        *OBJ_RECORD_CURSOR++=1;
        OBJ_WRITE_RECORD(0x98);
        index+=2;
    }
    for(node=SEGMENT_LIST_HEAD;node;node=SEGDEF_W(node,SEGDEF_NEXT)) {
        if(!SEGDEF_W(node,SEGDEF_PARENT_ID)) continue;
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        OBJ_PUT_NAME(NAME(node,17));
        *OBJ_RECORD_CURSOR++=0;
        OBJ_PUT_INDEX(SEGDEF_W(node,SEGDEF_PARENT_ID)&0x7FFF);
        if(SEGDEF_L(node,SEGDEF_SIZE)<=128L) *OBJ_RECORD_CURSOR++=(unsigned char)SEGDEF_L(node,SEGDEF_SIZE);
        else {
            *OBJ_RECORD_CURSOR++=0x81;
            *(unsigned int near *)OBJ_RECORD_CURSOR=SEGDEF_W(node,SEGDEF_SIZE);
            OBJ_RECORD_CURSOR+=2;
        }
        OBJ_WRITE_RECORD(0xB0);
    }
    for(group=GROUP_LIST_HEAD;group;group=SEGDEF_W(group,SEGDEF_NEXT),++index) {
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        OBJ_PUT_INDEX(index);
        total=0L;
        for(node=SEGMENT_LIST_HEAD;node;node=SEGDEF_W(node,SEGDEF_NEXT)) if(SEGDEF_W(node,SEGDEF_GROUP)==group) {
            total+=SEGDEF_L(node,SEGDEF_SIZE);
            *OBJ_RECORD_CURSOR++=0xFF;
            OBJ_PUT_INDEX(SEGDEF_W(node,SEGDEF_INDEX));
        }
        if(total>0x10000L) {
            STRING_COPY(path,NAME(group,4));
            REPORT_FATAL(MSG_GROUP_OVERFLOWED,(char far *)path);
        }
        OBJ_WRITE_RECORD(0x9A);
    }
    OBJ_WRITE_MODULE_HOOK(saved);
    for(node=SEGMENT_LIST_HEAD;node;node=SEGDEF_W(node,SEGDEF_NEXT)) OBJ_WRITE_SEGMENT_DATA(node);
    OBJ_WRITE_LINE_NUMBERS();
    OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
    *OBJ_RECORD_CURSOR++=0;
    OBJ_WRITE_RECORD(0x8A);
}
#undef NAME

/* ---- STOVR181 (listing ovr_1d43_9eb4:F3FD) ---- */
/* Empty hook entry. */
void far pascal OBJ_NOP(void)
{
}

/* ---- STOVR182 (listing ovr_1d43_9eb4:F402) ---- */
static void near pascal OBJ_WRITE_FIXUP(unsigned int record,unsigned int block,unsigned int link);
/* Writes the data of segment record node, one LEDATA per data block (at most 1 KB):
   first the block's fixups are built in the record buffer (OBJ_WRITE_FIXUP, which may
   also patch the data bytes), then the LEDATA is written directly from the segment's
   in-memory buffer (segment index, start offset, bytes), then the FIXUPP from the record
   buffer. */
static void near pascal OBJ_WRITE_SEGMENT_DATA(unsigned int node)
{
    unsigned int block,amount,saved,start,relative,total;
    register unsigned int record=node;
    register unsigned int link;
    total=0;
    for(block=SEGDEF_W(record,SEGDEF_FIRST_BLOCK);block;block=SEGBLK_W(block,SEGBLK_NEXT)) {
        saved=amount=SEGBLK_W(block,SEGBLK_LENGTH);
        OBJ_RECORD_CURSOR=TOKEN_TEXT_BUFFER;
        for(link=SEGBLK_W(block,SEGBLK_RELOCS);link;link=RELOC_W(link,RELOC_NEXT))
            OBJ_WRITE_FIXUP(record,block,link);
        if((int)SEGDEF_W(record,SEGDEF_INDEX)>127) {
            OBJ_BEGIN_RECORD(0xA0,amount+5);
            OBJ_OUT_BYTE(((int)SEGDEF_W(record,SEGDEF_INDEX)>>8)|0x80);
        }
        else OBJ_BEGIN_RECORD(0xA0,amount+4);
        OBJ_OUT_BYTE((unsigned char)SEGDEF_W(record,SEGDEF_INDEX));
        start=SEGBLK_W(block,SEGBLK_START);
        OBJ_OUT_BYTE(start&0xFF);
        OBJ_OUT_BYTE(start>>8);
        relative=start-SEGDEF_W(record,SEGDEF_BUFFER_BASE);
        while(amount>0) {
            --amount;
            OBJ_OUT_BYTE(*(unsigned char far *)MK_FP(**(unsigned int far * far *)MK_FP(SEGDEF_POOL_SEG,record+SEGDEF_BUFFER_HANDLE),relative));
            ++relative;
        }
        OBJ_END_RECORD();
        OBJ_WRITE_RECORD(0x9C);
        total+=saved;
    }
}

/* ---- STOVR183 (listing ovr_1d43_9eb4:F515) ---- */
/* Adds amount to the data word at offset of data block block in segment node (the bytes
   live in a heap buffer reached through SEGDEF_BUFFER_HANDLE, starting at segment offset
   SEGDEF_BUFFER_BASE). Used to put the known part of a fixup's value into the data. */
static void near pascal OBJ_PATCH_FIXUP_WORD(unsigned int node,unsigned int block,unsigned int offset,unsigned int amount)
{
    unsigned int relative;
    register unsigned int record=node;
    register unsigned int position=offset;
    position+=*(unsigned int far *)MK_FP(SEG_DATA_BLOCK_POOL_SEG,block);
    relative=position-*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG,record+SEGDEF_BUFFER_BASE);
    *(unsigned int far *)MK_FP(**(unsigned int far * far *)MK_FP(SEGDEF_POOL_SEG,record+SEGDEF_BUFFER_HANDLE),relative)+=amount;
}

/* ---- STOVR184 (listing ovr_1d43_9eb4:F553) ---- */
extern unsigned char OPTION_OVERLAY_CODE,OPTION_WINDOWS_MODE;
extern unsigned int (far pascal *GET_SYMBOL_KIND_HOOK)(unsigned int);
extern int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_HOOK)(unsigned int);
extern unsigned int (far pascal *FLAG_HOOK)(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
#define EMIT(v) { *OBJ_RECORD_CURSOR=(unsigned char)(v); ++OBJ_RECORD_CURSOR; }
/* Adds one FIXUPP entry for relocation link of data block block in segment record. By
   RELOC_KIND: 6 is self-relative (a near call or jump): a target in the same segment is
   resolved here and needs no fixup; 1 and 7 add a non-external target's offset to the
   data; 16 adds the location's own offset; 5 adds a constant (then has no symbol). The
   locat byte comes from FIXUP_CODE_TABLE[kind], with the high bits of the offset; for
   overlay or Windows code a far pointer to a far function uses D4h instead, probably so
   the linker can route it through an overlay or entry thunk. The fix data byte then
   picks frame and target: 14h group + segment, 54h segment, 16h group + external,
   56h external, 46h external with the location as frame; kind 10 uses the data segment
   (DS) as target. GET_SYMBOL_KIND_HOOK: 2 external, 1/3/4 defined in a segment. */
static void near pascal OBJ_WRITE_FIXUP(unsigned int record,unsigned int block,unsigned int link)
{
    unsigned int kind;
    int code;
    unsigned int offset,other,value;
    register unsigned int current=record;
    register unsigned int symbol;
    symbol=RELOC_W(link,RELOC_SYMBOL);
    offset=RELOC_W(link,RELOC_OFFSET);
    kind=RELOC_W(link,RELOC_KIND);
    if(kind==6) {
        if(GET_SYMBOL_KIND_HOOK(symbol)!=2) {
            value=SYMBOL_INDEX_HOOK(symbol);
            if(GET_SYMBOL_SEGMENT_HOOK(symbol)==SEGDEF_W(current,SEGDEF_INDEX))
                value-=SEGBLK_W(block,SEGBLK_START)+offset+2;
            OBJ_PATCH_FIXUP_WORD(current,block,offset,value);
            if(GET_SYMBOL_SEGMENT_HOOK(symbol)==SEGDEF_W(current,SEGDEF_INDEX)) return;
        }
    } else if(kind==1 || kind==7) {
        if(GET_SYMBOL_KIND_HOOK(symbol)!=2)
            OBJ_PATCH_FIXUP_WORD(current,block,offset,SYMBOL_INDEX_HOOK(symbol));
    } else if(kind==16) {
        OBJ_PATCH_FIXUP_WORD(current,block,offset,SEGBLK_W(block,SEGBLK_START)+offset);
    } else if(kind==5 && symbol) {
        OBJ_PATCH_FIXUP_WORD(current,block,offset,symbol);
        symbol=0;
    }
    code=FIXUP_CODE_TABLE[kind];
    if((OPTION_OVERLAY_CODE || OPTION_WINDOWS_MODE) && kind==1 && SYMBOL_ELEMENT_KIND_HOOK(symbol)==0x12 && (FLAG_HOOK(TYPE_HOOK(symbol))&1))
        code=0xD4;
    EMIT((unsigned char)code|(offset>>8));
    EMIT(offset&0xFF);
    if(kind==0) {
        OBJ_PATCH_FIXUP_WORD(current,block,offset,CSYM_W(symbol,CSYM_NEXT));
        if(SEGDEF_W(current,SEGDEF_GROUP)) {
            EMIT(0x14);
            OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(current,SEGDEF_GROUP),SEGDEF_GROUP));
        } else { EMIT(0x54); }
        EMIT(SEGDEF_W(current,SEGDEF_INDEX));
    } else if(kind==5 || kind==16) {
        if(SEGDEF_W(current,SEGDEF_GROUP)) {
            EMIT(0x14);
            OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(current,SEGDEF_GROUP),SEGDEF_GROUP));
        } else { EMIT(0x54); }
        OBJ_PUT_INDEX(SEGDEF_W(current,SEGDEF_INDEX));
    } else if(RELOC_W(link,RELOC_KIND)==10) {
        other=FIND_SEGMENT(DATA_SEGMENT_ID);
        if(SEGDEF_W(other,SEGDEF_GROUP)) {
            EMIT(0x14);
            OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(other,SEGDEF_GROUP),SEGDEF_GROUP));
        } else { EMIT(0x54); }
        OBJ_PUT_INDEX(SEGDEF_W(other,SEGDEF_INDEX));
    } else if(RELOC_W(link,RELOC_KIND)==11) {
        EMIT(0x46);
        OBJ_PUT_INDEX(SYMBOL_INDEX_HOOK(symbol));
    } else {
        switch(GET_SYMBOL_KIND_HOOK(symbol)) {
        case 2:
            other=FIND_SEGMENT(GET_SYMBOL_SEGMENT_HOOK(symbol));
            if(GET_SYMBOL_SEGMENT_HOOK(symbol)==0xFFFF || !SEGDEF_W(other,SEGDEF_GROUP)) {
                EMIT(0x56);
            } else {
                EMIT(0x16);
                OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(other,SEGDEF_GROUP),SEGDEF_GROUP));
            }
            OBJ_PUT_INDEX(SYMBOL_INDEX_HOOK(symbol));
            break;
        case 1: case 3: case 4:
            other=FIND_SEGMENT(GET_SYMBOL_SEGMENT_HOOK(symbol));
            if(SEGDEF_W(other,SEGDEF_GROUP)) {
                EMIT(0x14);
                OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(other,SEGDEF_GROUP),SEGDEF_GROUP));
            } else { EMIT(0x54); }
            OBJ_PUT_INDEX(SEGDEF_W(other,SEGDEF_INDEX));
            break;
        }
    }
}
#undef EMIT

/* ---- STOVR185 (listing ovr_1d43_9eb4:F87F) ---- */
/* Starts writing a record directly to the file: type and length (body + checksum). */
static void near pascal OBJ_BEGIN_RECORD(unsigned char type,unsigned int length)
{
    OBJ_RECORD_CHECKSUM=0;
    OBJ_OUT_BYTE(type);
    OBJ_OUT_BYTE(length&0xFF);
    OBJ_OUT_BYTE(length>>8);
}

/* ---- STOVR186 (listing ovr_1d43_9eb4:F8A9) ---- */
/* Writes one byte of a directly written record and adds it to the checksum. */
static void near pascal OBJ_OUT_BYTE(unsigned char value)
{
    OBJ_RECORD_CHECKSUM+=value;
    OUTPUT_CHAR(value);
}

/* ---- STOVR187 (listing ovr_1d43_9eb4:F8C4) ---- */
/* Writes the checksum byte that makes the record's bytes sum to 0. */
static void near pascal OBJ_END_RECORD(void)
{
    unsigned int checksum;
    checksum=(-OBJ_RECORD_CHECKSUM)&0xFF;
    OBJ_OUT_BYTE((unsigned char)checksum);
}

/* ---- STOVR188 (listing ovr_1d43_9eb4:F8E1) ---- */
/* The original far entry returns a DS-relative pointer in AX. */
char near * far pascal OBJ_RECORD_BUFFER(void)
{
    return TOKEN_TEXT_BUFFER;
}

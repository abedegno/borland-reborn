/* target: ovr165_C128UNIT */
/* Role: precompiled headers (PCH_*): hdrfile, hdrstop, saved preamble. Entry points:
   ADD_PCH_DEPENDENCY, SAVE_WARNING_SWITCH, CONTEXT_DIAGNOSTIC, SAVE_OPTION_STRING,
   REPLAY_PREAMBLE, INIT_PCH_STATE, TRY_PCH_LOAD. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO069 (ovr_1da8_abec) as one source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: precompiled headers.  When the option is on (PCH_OPTION_MODE
   nonzero), TRY_PCH_LOAD runs at the start of a compile, before the
   parser reads its first token.  It scans the "preamble": the run of
   directives at the top of the main file (#include, #define, #if, #ifdef,
   #ifndef, #endif, #pragma hdrfile and hdrstop, and extern "C" { ... }
   around them), recording each as a PDIR record in PREAMBLE_POOL_SEG
   (kinds: 0 #include <>, 1 #include "", 2 #define, 3 #if, 4 #ifdef,
   5 #ifndef, 6 #endif, 7 extern "C" {, 8 the closing brace).  The first
   line that does not belong is left in PREAMBLE_PUSHBACK_BUFFER as text.
   The precompiled-header file (PCH_FILE_NAME, set by #pragma hdrfile)
   holds an index: a trie of directive sequences (PCHTRIE records in
   PCH_INDEX_POOL_SEG), each node giving the file position of a saved
   compiler state.  LOAD_PCH_FILE finds the longest saved sequence that
   matches this file's preamble and, if the options, the macros defined
   beforehand and (in mode 2) the headers' file times all agree, reads the
   saved state back: every record pool listed in POOL_BANK_TABLE, the
   string pool and the name hash table, so the compiler is as if it had
   just compiled those headers.  The directives after the matched part are
   turned back into text and fed to the lexer as input.
   If nothing could be loaded, the preamble is compiled normally by
   REPLAY_PREAMBLE, which handles the recorded directives one by one:
   each #include opens the file and returns, and POP_INPUT_CONTEXT
   (INPUT.C) calls REPLAY_PREAMBLE again when the file ends.  At the end of
   the preamble the state is saved for next time (WRITE_PCH_ENTRY) unless
   there were errors, code or data were generated, or an extern "C" block
   is still open; in those cases a stale entry is made unloadable instead.
   Pragmas and options set inside headers are recorded (SAVE_OPTION_STRING,
   SAVE_WARNING_SWITCH) so a load can apply them again.
   PCH_OPTION_MODE: loading is tried only above 1, 2 also checks the
   headers' file times, and 4 never saves (read from the tests; the
   matching command-line options are set in the driver). */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- ADD_PCH_DEPENDENCY (listing BEC0) ---- */
#include <dos.h>
extern unsigned int STRING_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *, unsigned int);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern char far * far pascal STRING_COPY(char far *, char far *);
extern long far pascal FILE_TIME(char far *);

/* While a preamble is being compiled for saving (PCH_COLLECT_DEPENDENCIES),
   records the file just opened (CURRENT_FILE_NAME) and its time stamp at
   the end of the dependency list, so a later load can tell whether a
   header changed. */
void far pascal ADD_PCH_DEPENDENCY(void)
{
    char buffer[80];
    register unsigned int entry;

    if (!PCH_COLLECT_DEPENDENCIES)
        return;
    entry = POOL_ALLOC(&PCH_DEPENDENCY_POOL_SEG, STRING_LENGTH(
        (char far *)MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME)) + 7);
    PDEP_W(entry, PDEP_NEXT) = 0;
    PDEP_UL(entry, PDEP_FILE_TIME) = FILE_TIME(STRING_COPY(buffer,
        (char far *)MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME)));
    STRING_COPY((char far *)MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_NAME),
                (char far *)MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME));
    if (PCH_DEPENDENCY_HEAD)
        PDEP_W(PCH_DEPENDENCY_TAIL, PDEP_NEXT) = entry;
    else
        PCH_DEPENDENCY_HEAD = entry;
    PCH_DEPENDENCY_TAIL = entry;
}

/* ---- STAOV0FA (listing BF52) ---- */
#include <dos.h>

/* Makes a new trie node (no sibling, no child, no saved state yet) for
   the directive record node and returns it. */
static unsigned int near pascal NEW_PREAMBLE_TRIE_NODE(unsigned int node)
{
    register unsigned int entry;

    entry=POOL_ALLOC(&PCH_INDEX_POOL_SEG,
                     STRING_LENGTH((char far *)MK_FP(PREAMBLE_POOL_SEG,node+PDIR_TEXT))+15);
    PCHTRIE_W(entry,PCHTRIE_NEXT)=0;
    PCHTRIE_W(entry,PCHTRIE_CHILD)=0;
    PCHTRIE_W(entry,PCHTRIE_FILE_POS_HI)=0;
    PCHTRIE_W(entry,PCHTRIE_FILE_POS)=0;
    PCHTRIE_W(entry,PCHTRIE_ALLOC_SIZE_HI)=0;
    PCHTRIE_W(entry,PCHTRIE_ALLOC_SIZE)=0;
    PCHTRIE_W(entry,PCHTRIE_KIND)=PDIR_W(node,PDIR_KIND);
    STRING_COPY((char far *)MK_FP(PCH_INDEX_POOL_SEG,entry+PCHTRIE_TEXT),
                (char far *)MK_FP(PREAMBLE_POOL_SEG,node+PDIR_TEXT));
    return entry;
}

/* ---- STAOV0FB (listing BFD3) ---- */
#include <dos.h>
static unsigned int near pascal NEW_PREAMBLE_TRIE_NODE(unsigned int);
extern int far pascal COMPARE_NAME(char far *,char far *);

/* Walks the trie from tree along the directive list starting at node,
   adding nodes where the path does not exist yet, and returns the trie
   node of the last directive: the place where the saved state for this
   exact preamble lives.  tree == PCH_INDEX_POOL_USED means the trie is
   empty (no node has been allocated at offset 2 yet). */
static unsigned int near pascal FIND_OR_ADD_PREAMBLE(register unsigned int tree,
                                              register unsigned int node)
{
    unsigned int saved;
    for (;;) {
        saved=tree;
        if (tree==PCH_INDEX_POOL_USED) {
            tree=NEW_PREAMBLE_TRIE_NODE(node);
            continue;
        }
        if (PDIR_W(node,PDIR_KIND)==PCHTRIE_W(tree,PCHTRIE_KIND) &&
            COMPARE_NAME((char far *)MK_FP(PREAMBLE_POOL_SEG,node+PDIR_TEXT),
                         (char far *)MK_FP(PCH_INDEX_POOL_SEG,tree+PCHTRIE_TEXT))==0) {
            tree=PCHTRIE_W(tree,PCHTRIE_CHILD);
            node=PDIR_W(node,PDIR_NEXT);
            if (!node) return saved;
            if (!tree)
                PCHTRIE_W(saved,PCHTRIE_CHILD)=tree=NEW_PREAMBLE_TRIE_NODE(node);
        } else {
            tree=PCHTRIE_W(tree,PCHTRIE_NEXT);
            if (!tree)
                PCHTRIE_W(saved,PCHTRIE_NEXT)=tree=NEW_PREAMBLE_TRIE_NODE(node);
        }
    }
}

/* ---- APPEND_DIRECTIVE_LIST (listing C077) ---- */
#include <dos.h>


/* Appends the directive list value to the end of the list node and
   returns the joined list (value alone if node is 0). */
static unsigned int near pascal APPEND_DIRECTIVE_LIST(register unsigned int node, unsigned int value)
{
    register unsigned int last;
    if (!node)
        return value;
    last = node;
    while (*(unsigned int far *)MK_FP(PREAMBLE_POOL_SEG, last))
        last = *(unsigned int far *)MK_FP(PREAMBLE_POOL_SEG, last);
    *(unsigned int far *)MK_FP(PREAMBLE_POOL_SEG, last) = value;
    return node;
}

/* ---- FIND_PREAMBLE (listing C0AE) ---- */
#include <dos.h>

/* Like FIND_OR_ADD_PREAMBLE but read-only: returns the trie node of the
   longest prefix of the directive list node found in the trie (0 if not
   even the first directive matches).  The first directive that did not
   match is left in PREAMBLE_MISMATCH_NODE (TRY_PCH_LOAD feeds it and the
   rest back as text after a load). */
static unsigned int near pascal FIND_PREAMBLE(register unsigned int tree,register unsigned int node)
{
    unsigned int saved;
    saved=0;
    for (;;) {
        if (tree==PCH_INDEX_POOL_USED) return saved;
        if (PDIR_W(node,PDIR_KIND)==PCHTRIE_W(tree,PCHTRIE_KIND) &&
            COMPARE_NAME((char far *)MK_FP(PREAMBLE_POOL_SEG,node+PDIR_TEXT),
                         (char far *)MK_FP(PCH_INDEX_POOL_SEG,tree+PCHTRIE_TEXT))==0) {
            saved=tree;
            tree=PCHTRIE_W(tree,PCHTRIE_CHILD);
            node=PDIR_W(node,PDIR_NEXT);
            if (!node) return saved;
            if (!tree) break;
        } else {
            tree=PCHTRIE_W(tree,PCHTRIE_NEXT);
            if (!tree) break;
        }
    }
    PREAMBLE_MISMATCH_NODE=node;
    return saved;
}

/* ---- COLLECT_POOL_SIZES (listing C131) ---- */
struct C31Bank { unsigned int segment,capacity,used,extra; };
extern struct C31Bank near * near  POOL_BANK_TABLE[];

/* Writes the used size of each of the 37 pools in POOL_BANK_TABLE into
   output (0xFFFF for a pool that was never set up) and returns their sum. */
static unsigned long near pascal COLLECT_POOL_SIZES(unsigned int far *output)
{
    unsigned long total = 0;
    struct C31Bank near * near *entry = POOL_BANK_TABLE;

    while (entry < POOL_BANK_TABLE+37) {
        if ((*entry)->segment) {
            *output = (*entry)->used;
            total += (unsigned long)(*entry)->used;
        } else {
            *output = 0xFFFF;
        }
        entry++;
        output++;
    }
    return total;
}

/* ---- SAVE_OPTION_FLAGS (listing C18A) ---- */
/* Copies the 11 option bytes listed in PCH_OPTION_FLAG_PTRS (the options
   a saved state depends on) to dest. */
static void near pascal SAVE_OPTION_FLAGS(char far *dest)
{
    register unsigned int near *cursor=PCH_OPTION_FLAG_PTRS;
    while (cursor < (PCH_OPTION_FLAG_PTRS+11)) {
        *dest=*(unsigned char near *)*cursor;
        ++cursor;
        ++dest;
    }
}

/* ---- OPTION_FLAGS_DIFFER (listing C1AF) ---- */
/* Nonzero if the 11 saved option bytes at text differ from the current
   options. */
static int near pascal OPTION_FLAGS_DIFFER(unsigned char far *text)
{
    register unsigned int near *cursor=PCH_OPTION_FLAG_PTRS;
    while(cursor<(PCH_OPTION_FLAG_PTRS+11)) {
        if(*text!=*(unsigned char near *)*cursor)
            return 1;
        ++cursor;
        ++text;
    }
    return 0;
}

/* ---- SAVE_MACRO_SNAPSHOT (listing C1DD) ---- */
#include <dos.h>
extern unsigned int  NAME_POOL_SEG;
extern unsigned int  HASH_CHAIN_LINK_SEG;

/* Records every macro defined before the preamble (from the command line
   or the compiler itself) into MACRO_SNAPSHOT_POOL_SEG: name, then
   parameter count and body.  A saved state may be loaded only if this
   snapshot is identical to the one saved with it.  The name records are
   6 bytes each, from offset 2 up to NAME_TABLE_END.  Note it always reads
   the definition from POOL_E, even for an odd offset, which would be in
   POOL_F (probably never the case this early). */
static void near pascal SAVE_MACRO_SNAPSHOT(void)
{
    register unsigned int entry;
    register unsigned int text;
    char far *source;

    for (entry = 2; entry < NAME_TABLE_END; entry += 6) {
        if (HLINK_W(entry, HLINK_MACRO)) {
            source = MK_FP(*(unsigned int near *)NAME_W(entry, NAME_TEXT_BANK), NAME_W(entry, NAME_TEXT_OFFSET));
            text = POOL_ALLOC(&MACRO_SNAPSHOT_POOL_SEG, STRING_LENGTH(source) + 1);
            STRING_COPY((char far *)MK_FP(MACRO_SNAPSHOT_POOL_SEG, text), source);
            text = POOL_ALLOC(&MACRO_SNAPSHOT_POOL_SEG,
                STRING_LENGTH((char far *)MK_FP(POOL_E, HLINK_W(entry, HLINK_MACRO)) + 1) + 2);
            MSNAP_B(text, MSNAP_PARAM_COUNT) = FAR_B(POOL_E, HLINK_W(entry, HLINK_MACRO), MACDEF_PARAM_COUNT);
            text++;
            STRING_COPY((char far *)MK_FP(MACRO_SNAPSHOT_POOL_SEG, text),
                (char far *)MK_FP(POOL_E, HLINK_W(entry, HLINK_MACRO)) + 1);
        }
    }
}

/* ---- ALLOC_PCH_FILE_SPACE (listing C29B) ---- */
#include <dos.h>

/* Returns a file position for size bytes: a block from the free list at
   offset 0 of PCH_INDEX_POOL_SEG, else the end of the file data
   (PCH_INDEX_FILE_OFFSET, which then moves up; the index itself is
   written after the data).  Written with register pseudo-variables to
   match the original: _SI walks the list, _DI is the best block.  Note
   the best-fit test also takes a block smaller than size (a negative
   difference); in practice the list is probably always empty, see
   FREE_PCH_FILE_SPACE. */
static long near pascal ALLOC_PCH_FILE_SPACE(long size)
{
    long difference;
    long best;
    long result;

    _SI = 0;
    _DI = 0;
    best = size;
    while ((_ES = PCH_INDEX_POOL_SEG, _SI = ES_W(_SI, PCHFREE_NEXT), _SI)) {
        _ES = PCH_INDEX_POOL_SEG;
        difference = ES_L(_SI, PCHFREE_SIZE) - size;
        if (difference < best) {
            best = difference;
            _DI = _SI;
        }
    }
    if (_DI) {
        _ES = PCH_INDEX_POOL_SEG;
        ES_L(_DI, PCHFREE_SIZE) = 0L;
        return ES_L(_DI, PCHFREE_FILE_POS);
    }
    result = PCH_INDEX_FILE_OFFSET;
    PCH_INDEX_FILE_OFFSET += size;
    return result;
}

/* ---- STAOV103 (listing C33E) ---- */
#include <dos.h>

/* Meant to put the file block at position value2, of size value1, on the
   free list.  As the original stores the new block's link as 0 and never
   updates the list head, the block is probably never reachable, so freed
   space is not reused. */
static void near pascal FREE_PCH_FILE_SPACE(long value2, long value1)
{
    register unsigned int block;
    register unsigned int head;
    if (value1 == 0)
        return;
    head = 0;
    block = *((unsigned int far *)MK_FP(PCH_INDEX_POOL_SEG, head));
    for (;;) {
        if (block == 0) {
            block = POOL_ALLOC(&PCH_INDEX_POOL_SEG, 0x0A);
            break;
        }
        if (*((long far *)MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_SIZE)) == 0)
            break;
        block = *((unsigned int far *)MK_FP(PCH_INDEX_POOL_SEG, block));
    }
    *((unsigned int far *)MK_FP(PCH_INDEX_POOL_SEG, block)) = head;
    *((long far *)MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_FILE_POS)) = value2;
    *((long far *)MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_SIZE)) = value1;
    /* The original ends by making the block the new list head, but stores it only in
       its local copy (a mov di,si before the epilogue), so the assignment has no effect. */
    head = block;
}

/* ---- WRITE_PCH_DATA (listing C3AE) ---- */
extern char far *PCH_FILE_NAME;
extern void far pascal RTL_CLOSE(unsigned int value);
extern int far pascal DELETE_FILE(char far *path);
extern unsigned int far pascal RTL_WRITE(unsigned int handle,void far *buffer,unsigned int size);

/* Writes size bytes to the precompiled-header file.  Returns 0 on success;
   on a failed write the file is closed and deleted and 1 is returned. */
static int near pascal WRITE_PCH_DATA(void far *buffer,unsigned int size)
{
    if(!size) return 0;
    if(RTL_WRITE(PCH_FILE_HANDLE,buffer,size)==size) return 0;
    RTL_CLOSE(PCH_FILE_HANDLE);
    PCH_FILE_HANDLE = -1;
    DELETE_FILE(PCH_FILE_NAME);
    return 1;
}

/* ---- INVALIDATE_PCH_ENTRY (listing C3F9) ---- */
#include <dos.h>
static unsigned int near pascal FIND_OR_ADD_PREAMBLE(unsigned int, unsigned int);
extern long far pascal RTL_LSEEK(int, long, unsigned int);
extern int far pascal RTL_READ(int, void far *, unsigned int);

/* Makes the saved state for the current preamble unloadable, by adding 1
   to the magic word 0xEDFE at the start of its header in the file.  Used
   when this compile's preamble could not be saved, so an out-of-date
   state is not loaded later. */
static void near pascal INVALIDATE_PCH_ENTRY(void)
{
    unsigned int header[56];
    register unsigned int entry;
    if (PCH_FILE_HANDLE >= 0) {
        entry = FIND_OR_ADD_PREAMBLE(2, PREAMBLE_LIST_HEAD);
        if (PCHTRIE_L(entry, PCHTRIE_FILE_POS) == 0L) return;
        if (RTL_LSEEK(PCH_FILE_HANDLE, PCHTRIE_L(entry, PCHTRIE_FILE_POS), 0) == PCHTRIE_L(entry, PCHTRIE_FILE_POS) &&
            RTL_READ(PCH_FILE_HANDLE, header, sizeof(header)) == sizeof(header) &&
            header[0] == 0xEDFE && header[1] == 6) {
            header[0]++;
            if (RTL_LSEEK(PCH_FILE_HANDLE, PCHTRIE_L(entry, PCHTRIE_FILE_POS), 0) == PCHTRIE_L(entry, PCHTRIE_FILE_POS)) {
                /* The original tests the write result although both outcomes end the
                   function: BC20 -O keeps that test (a je to the next instruction) only
                   for this if/else shape. */
                if (WRITE_PCH_DATA(header, sizeof(header))) {
                } else return;
            }
        }
    }
}

/* ---- WRITE_PCH_ENTRY (listing C4B6) ---- */
extern char  NAME_HASH_TABLE[];
#include <dos.h>
extern unsigned int TOKEN_STREAM_POS;
extern int far pascal RTL_CREAT(char far *,unsigned int);
static void near pascal SAVE_OPTION_FLAGS(char far *dest);
static unsigned long near pascal COLLECT_POOL_SIZES(unsigned int far *output);
static void near pascal FREE_PCH_FILE_SPACE(long,long);
static long near pascal ALLOC_PCH_FILE_SPACE(long size);
struct Header {
    unsigned int magic,version,first,second,third,fourth,tag;
    unsigned int value615e,value85f2,value617a,cache,value8230;
    unsigned char mode;
    char part[11];
    unsigned int code;
    unsigned int sizes[37];
};

/* Saves the compiler state after the preamble.  Creates the file if
   needed (a 10-byte file header at PCH_FILE_MAGIC: magic 0xD03C, version
   2, index position and size).  Finds or adds the trie node for this
   preamble, reserves file space when the old space is too small (with
   0x800 bytes to spare), and writes a 0x70-byte header (struct Header:
   magic 0xEDFE, version 6, sizes of the parts, a few list heads and
   counters, the option bytes, each pool's size) followed by the macro
   snapshot, the dependency list, the string pool, each pool's contents
   and the name hash table.  Then rewrites the index and the file header.
   A write error abandons the file (WRITE_PCH_DATA deletes it). */
static void near pascal WRITE_PCH_ENTRY(void)
{
    long total;
    struct Header header;
    register unsigned int entry;
    register struct C31Bank near * near *pool;
    if(PCH_FILE_HANDLE<0) {
        PCH_FILE_HANDLE=RTL_CREAT(PCH_FILE_NAME,0);
        if(PCH_FILE_HANDLE<0) return;
        PCH_FILE_MAGIC=0xD03C;
        PCH_HEADER_VERSION=2;
        PCH_INDEX_FILE_OFFSET=10L;
        if(WRITE_PCH_DATA(&PCH_FILE_MAGIC,10)) return;
        PCHTRIE_W(0,0)=0;
    }
    entry=FIND_OR_ADD_PREAMBLE(2,PREAMBLE_LIST_HEAD);
    PCH_INDEX_FILE_SIZE=PCH_INDEX_POOL_USED;
    header.magic=0xEDFE;
    header.version=6;
    header.tag=11;
    header.value615e=VTABLE_CLASS_LIST;
    header.value85f2=C_UNNAMED_GLOBAL_LIST;
    header.value617a=TOKEN_STREAM_POS;
    header.cache=CACHE_HEAD;
    header.value8230=CURRENT_BANK_INDEX;
    header.mode=PCH_DIAGNOSTIC_ISSUED;
    SAVE_OPTION_FLAGS(header.part);
    header.code=0x25;
    header.first=MACRO_SNAPSHOT_POOL_USED;
    header.second=PCH_DEPENDENCY_POOL_USED;
    header.third=STRING_POOL_USED;
    header.fourth=FAR_SEGMENT_COUNT;
    total=(unsigned int)(header.first+header.second+header.third+0x800)+COLLECT_POOL_SIZES(header.sizes)+0x70L;
    if(PCHTRIE_L(entry,PCHTRIE_ALLOC_SIZE)<total) {
        FREE_PCH_FILE_SPACE(PCHTRIE_L(entry,PCHTRIE_FILE_POS),PCHTRIE_L(entry,PCHTRIE_ALLOC_SIZE));
        total+=0x800;
        PCHTRIE_L(entry,PCHTRIE_FILE_POS)=ALLOC_PCH_FILE_SPACE(total);
        PCHTRIE_L(entry,PCHTRIE_ALLOC_SIZE)=total;
    }
    if(RTL_LSEEK(PCH_FILE_HANDLE,PCHTRIE_L(entry,PCHTRIE_FILE_POS),0)!=PCHTRIE_L(entry,PCHTRIE_FILE_POS)) return;
    if(WRITE_PCH_DATA(&header,0x70)) return;
    if(WRITE_PCH_DATA(MK_FP(MACRO_SNAPSHOT_POOL_SEG,0),header.first)) return;
    if(WRITE_PCH_DATA(MK_FP(PCH_DEPENDENCY_POOL_SEG,0),header.second)) return;
    if(WRITE_PCH_DATA(MK_FP(STRING_POOL_SEG,0),header.third)) return;
    for(pool=POOL_BANK_TABLE;pool<POOL_BANK_TABLE+37;pool++) {
        if((*pool)->segment) {
            if(WRITE_PCH_DATA(MK_FP((*pool)->segment,0),(*pool)->used)) return;
        }
    }
    if(WRITE_PCH_DATA((void far *)NAME_HASH_TABLE,0x800)) return;
    if(RTL_LSEEK(PCH_FILE_HANDLE,PCH_INDEX_FILE_OFFSET,0)!=PCH_INDEX_FILE_OFFSET) return;
    if(WRITE_PCH_DATA(MK_FP(PCH_INDEX_POOL_SEG,0),PCH_INDEX_POOL_USED)) return;
    if(RTL_LSEEK(PCH_FILE_HANDLE,0L,0)) return;
    if(WRITE_PCH_DATA(&PCH_FILE_MAGIC,10)) return;
}

/* ---- RELOCATE_NAME_BANKS (listing C715) ---- */
#include <dos.h>
extern struct C31Bank near  C31_BANKS[];

/* Each 6-byte name record holds, in its third word, the near address of
   the bank (in C31_BANKS) holding its text.  If C31_BANKS is at a
   different address than in the compiler that wrote the file, adds the
   difference to every record. */
static void near pascal RELOCATE_NAME_BANKS(void)
{
    register unsigned int cursor=2,delta;
    delta=(unsigned int)C31_BANKS-((unsigned int far *)MK_FP(NAME_POOL_SEG,cursor))[2];
    if(!delta) return;
    while(cursor<NAME_TABLE_END) {
        ((unsigned int far *)MK_FP(NAME_POOL_SEG,cursor))[2]=
            ((unsigned int far *)MK_FP(NAME_POOL_SEG,cursor))[2]+delta;
        cursor+=6;
    }
}

/* ---- MACRO_SNAPSHOT_DIFFERS (listing C74D) ---- */
#include <dos.h>


/* Nonzero if count bytes at offset second and at offset first of
   MACRO_SNAPSHOT_POOL_SEG differ. */
static int near pascal MACRO_SNAPSHOT_DIFFERS(register unsigned int second, register unsigned int first,
                                 unsigned int count)
{
    while(count) {
        if(*(unsigned char far *)MK_FP(MACRO_SNAPSHOT_POOL_SEG,second)!=
           *(unsigned char far *)MK_FP(MACRO_SNAPSHOT_POOL_SEG,first))
            return 1;
        --count;
        ++second;
        ++first;
    }
    return 0;
}

/* ---- PCH_DEPENDENCIES_CHANGED (listing C77F) ---- */
#include <dos.h>


/* Nonzero if any header in the loaded dependency list now has a
   different file time. */
static int near pascal PCH_DEPENDENCIES_CHANGED(void)
{
    char buffer[80];
    register unsigned int entry;

    for (entry = 2; entry;
         entry = *((unsigned int far *)MK_FP(PCH_DEPENDENCY_POOL_SEG, entry))) {
        if (FILE_TIME(STRING_COPY(buffer, (char far *)MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_NAME))) !=
            *((unsigned long far *)MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_TIME)))
            return 1;
    }
    return 0;
}

/* ---- NOTIFY_PCH_DEPENDENCIES (listing C7CF) ---- */
#include <dos.h>

extern void (far *EMIT_DEPENDENCY_HOOK)(void far *value);

/* After a load, passes every header of the saved state to
   EMIT_DEPENDENCY_HOOK, so the object file's dependency list still names
   them although they were not opened. */
static void near pascal NOTIFY_PCH_DEPENDENCIES(void)
{
    char buffer[80];
    register unsigned int entry;
    entry = 2;
    while (entry) {
        EMIT_DEPENDENCY_HOOK(STRING_COPY((void far *)buffer,
            (void far *)MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_NAME)));
        entry = *(unsigned int far *)MK_FP(PCH_DEPENDENCY_POOL_SEG, entry);
    }
}

/* ---- OFFSET_SEGMENT_RECORDS (listing C807) ---- */
#include <dos.h>

extern unsigned int  SRCFILE_POOL_SEG;
extern unsigned int  NODE_SERIAL_COUNTER;

/* Fixes the 14-byte source-file records in SRCFILE_POOL_SEG after a load:
   their first word is a string pool offset, and the loaded strings were
   placed value bytes further up.  Also raises NODE_SERIAL_COUNTER to the
   highest serial number found (the third word).  The first record, the
   main file's own, is skipped. */
static void near pascal OFFSET_SEGMENT_RECORDS(unsigned int value)
{
    register unsigned int cursor;
    cursor=2;
    goto check;
loop:
    if(((unsigned int far *)MK_FP(SRCFILE_POOL_SEG,cursor))[2]>NODE_SERIAL_COUNTER)
        NODE_SERIAL_COUNTER=((unsigned int far *)MK_FP(SRCFILE_POOL_SEG,cursor))[2];
    *(unsigned int far *)MK_FP(SRCFILE_POOL_SEG,cursor)+=value;
check:
    cursor+=14;
    if(cursor<SEGMENT_POOL_USED)
        goto loop;
}

/* ---- REPLAY_SAVED_OPTIONS (listing C83F) ---- */
#include <dos.h>
extern void far pascal APPLY_OPTION(char far *,unsigned int);
#define BYTE(n) (*((unsigned char far *)MK_FP(SAVED_OPTION_POOL_SEG,offset+(n))))

/* Applies again the options and warning switches recorded with the
   loaded state: an entry starting '=' is a #pragma option text, one
   starting '+', '-' or '.' a #pragma warn switch (see PRAGMA_WARN). */
static void near pascal REPLAY_SAVED_OPTIONS(void)
{
    unsigned int offset;
    unsigned int index;
    unsigned char far *entry;
    for (offset=0;offset<SAVED_OPTION_POOL_USED;offset+=STRING_LENGTH((char far *)MK_FP(SAVED_OPTION_POOL_SEG,offset))+1) {
        if (BYTE(0)=='=') {
            APPLY_OPTION((char far *)MK_FP(SAVED_OPTION_POOL_SEG,offset)+1,1);
        } else {
            for (index=0,entry=WARNING_SWITCH_TABLE;*entry;entry+=4,++index) {
                if (BYTE(1)==entry[0] && BYTE(2)==entry[1] && BYTE(3)==entry[2]) {
                    if (BYTE(0)=='.') WARNING_SWITCH_STATE[index]=entry[3];
                    else if (BYTE(0)=='+') WARNING_SWITCH_STATE[index]=1;
                    else WARNING_SWITCH_STATE[index]=0;
                }
            }
        }
    }
}
#undef BYTE

/* ---- LOAD_PCH_FILE (listing C900) ---- */
#include <dos.h>
struct Save { char data[14]; };
extern signed char COMPILER_MODE;
extern char NAME_HASH_TABLE[];
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern int far pascal RTL_OPEN(char far *,unsigned int);
extern void far pascal MODE_FALLBACK(unsigned int);
static unsigned int near pascal FIND_PREAMBLE(unsigned int tree,unsigned int node);
static int near pascal OPTION_FLAGS_DIFFER(unsigned char far *text);
static int near pascal MACRO_SNAPSHOT_DIFFERS(register unsigned int second, register unsigned int first, unsigned int count);
static int near pascal PCH_DEPENDENCIES_CHANGED(void);
static void near pascal RELOCATE_NAME_BANKS(void);
static void near pascal REPLAY_SAVED_OPTIONS(void);
static void near pascal OFFSET_SEGMENT_RECORDS(unsigned int value);
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern void far cdecl RTL_DPRINTF(char far *);
#define FL(n) (*((unsigned long far *)MK_FP(PCH_INDEX_POOL_SEG,entry+(n))))
#define H(n) (*((unsigned int near *)(header+(n))))
#define POOL (*pool)
#define SAVED_GLOBAL (*((struct Save far *)MK_FP(SRCFILE_POOL_SEG,2)))

/* Tries to load a saved state for this preamble.  Returns 0 on success
   and -1 if anything does not fit (file missing, no matching trie node,
   wrong header, different options or macros, changed headers); a failed
   load can leave the index pool loaded but changes nothing else.  If the
   saved state needs compiling through the assembler (header byte 24, the
   PCH_DIAGNOSTIC_ISSUED flag) and that is not yet the case, the compile is
   restarted that way (MODE_FALLBACK(3)).  The H() macro reads a word of
   the 112-byte header at a byte offset. */
static int near pascal LOAD_PCH_FILE(void)
{
    unsigned int far *sizes;
    unsigned int base,offset,old;
    unsigned char header[112];
    struct Save saved;
    register struct C31Bank near * near *pool;
    register unsigned int entry;
    PCH_FILE_HANDLE=RTL_OPEN(PCH_FILE_NAME,2);
    if (PCH_FILE_HANDLE<0) return -1;
    if (RTL_READ(PCH_FILE_HANDLE,&PCH_FILE_MAGIC,10)!=10) return -1;
    if (RTL_LSEEK(PCH_FILE_HANDLE,PCH_INDEX_FILE_OFFSET,0)!=PCH_INDEX_FILE_OFFSET) return -1;
    POOL_ALLOC(&PCH_INDEX_POOL_SEG,PCH_INDEX_FILE_SIZE-PCH_INDEX_POOL_USED);
    if (RTL_READ(PCH_FILE_HANDLE,MK_FP(PCH_INDEX_POOL_SEG,0),PCH_INDEX_FILE_SIZE)!=PCH_INDEX_FILE_SIZE) return -1;
    if (PCH_OPTION_MODE<=1) return -1;
    entry=FIND_PREAMBLE(2,PREAMBLE_LIST_HEAD);
    if (!entry || FL(4)==0) return -1;
    if (RTL_LSEEK(PCH_FILE_HANDLE,FL(4),0)!=FL(4)) return -1;
    if (RTL_READ(PCH_FILE_HANDLE,header,112)!=112) return -1;
    if (header[24] && !COMPILER_MODE) {
        RTL_CLOSE(PCH_FILE_HANDLE);
        PCH_FILE_HANDLE=-1;
        MODE_FALLBACK(3);
    }
    if (H(0)!=0xEDFE || H(2)!=6 || H(12)!=11 ||
        OPTION_FLAGS_DIFFER(header+25) || H(36)!=0x25) return -1;
    base=POOL_ALLOC(&MACRO_SNAPSHOT_POOL_SEG,H(4));
    if (RTL_READ(PCH_FILE_HANDLE,MK_FP(MACRO_SNAPSHOT_POOL_SEG,base),H(4))!=H(4)) return -1;
    if (H(4)!=base || MACRO_SNAPSHOT_DIFFERS(0,base,H(4))) {
        MACRO_SNAPSHOT_POOL_FREE=0;
        MACRO_SNAPSHOT_POOL_USED=base;
        return -1;
    }
    MACRO_SNAPSHOT_POOL_FREE=0;
    MACRO_SNAPSHOT_POOL_USED=base;
    POOL_ALLOC(&PCH_DEPENDENCY_POOL_SEG,H(6));
    if (RTL_READ(PCH_FILE_HANDLE,MK_FP(PCH_DEPENDENCY_POOL_SEG,0),H(6))!=H(6)) return -1;
    if (PCH_OPTION_MODE==2 && PCH_DEPENDENCIES_CHANGED()) return -1;
    BEGIN_BACKEND_OUTPUT_HOOK();
    offset=STRING_POOL_USED;
    POOL_ALLOC(&STRING_POOL_SEG,H(8));
    if (RTL_READ(PCH_FILE_HANDLE,MK_FP(STRING_POOL_SEG,offset),H(8))!=H(8)) return -1;
    old=SEGMENT_POOL_USED;
    if (old>2) saved=SAVED_GLOBAL;
    while (FAR_SEGMENT_COUNT<H(10)) DEFINE_FAR_SEGMENT();
    pool=POOL_BANK_TABLE;
    sizes=(unsigned int far *)(header+38);
    while (pool<POOL_BANK_TABLE+37) {
        if (*sizes!=0xFFFF) {
            if (POOL->segment==0) {
                POOL->used=POOL->capacity=0;
                POOL->extra=0;
                POOL_INIT(&POOL->segment,0);
            }
            POOL_ALLOC(&POOL->segment,*sizes-POOL->used);
            if (RTL_READ(PCH_FILE_HANDLE,MK_FP(POOL->segment,0),*sizes)!=*sizes) return -1;
        }
        ++pool;
        ++sizes;
    }
    if (RTL_READ(PCH_FILE_HANDLE,NAME_HASH_TABLE,0x800)!=0x800) return -1;
    RELOCATE_NAME_BANKS();
    REPLAY_SAVED_OPTIONS();
    if (old>2) {
        SAVED_GLOBAL=saved;
        OFFSET_SEGMENT_RECORDS(offset);
    } else {
        SEGMENT_POOL_FREE_LIST=0;
        SEGMENT_POOL_USED=old;
    }
    VTABLE_CLASS_LIST=H(14);
    C_UNNAMED_GLOBAL_LIST=H(16);
    TOKEN_STREAM_POS=H(18);
    CACHE_HEAD=H(20);
    CURRENT_BANK_INDEX=H(22);
    RTL_DPRINTF(STR_LOADED_PRE_COMPILED);
    return 0;
}
#undef FL
#undef H
#undef POOL
#undef SAVED_GLOBAL

/* ---- NEXT_LINE_IS_DIRECTIVE (listing CC4C) ---- */
extern unsigned int  INPUT_INDEX;
extern char  CHAR_CLASS[];
extern int far pascal SCAN_NEXT(int value);
extern void far pascal LEX_NEWLINE(char value);

/* Skips blank lines and comments and returns 1 if the next line starts
   with '#' and more text (INPUT_INDEX is left on the first character after
   '#').  Returns 0 otherwise, with the first character put back.  Class
   0xEC (-20) is the line end. */
static int near pascal NEXT_LINE_IS_DIRECTIVE(void)
{
    unsigned int c;
    for(;;) {
        c = SCAN_NEXT(0x20);
        if (c == '#') {
            LOGICAL_LINE = CURRENT_LINE;
            c = SCAN_NEXT(0x20);
            if (CHAR_CLASS[c + 1] == (char)0xEC) {
                LEX_NEWLINE(c);
                continue;
            }
            if (c == 0x1A) return 0;
            break;
        }
        if (CHAR_CLASS[c + 1] == (char)0xEC) {
            LEX_NEWLINE(c);
            continue;
        }
        INPUT_INDEX--;
        return 0;
    }
    INPUT_INDEX--;
    return 1;
}

/* ---- PUSH_BACK_DIRECTIVE (listing CCB3) ---- */
#include <dos.h>
extern void far pascal STRING_APPEND(char far *,char far *);
extern void far pascal BCC_INPUT_STRING(char far *);
extern void far pascal DIRECTIVE_START(unsigned int);

/* Rebuilds the directive "#" text into PREAMBLE_PUSHBACK_BUFFER.  With flag
   set the directive is executed at once (pushed back as input and passed
   to DIRECTIVE_START) and preamble scanning goes on; with flag 0 it stays
   in the buffer and scanning stops.  Returns flag, which the preamble
   scanner uses as "continue". */
static int near pascal PUSH_BACK_DIRECTIVE(char near *text,register int flag)
{
    STRING_COPY(PREAMBLE_PUSHBACK_BUFFER,STR_HASH);
    STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,text);
    STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,STR_SPACE);
    --INPUT_INDEX;
    if (flag) {
        BCC_INPUT_STRING(PREAMBLE_PUSHBACK_BUFFER+1);
        DIRECTIVE_START(0x20);
        PREAMBLE_PUSHBACK_BUFFER[0]=0;
    }
    return flag;
}

/* ---- PCH_DIRECTIVE_PRAGMA (listing CD0F) ---- */
#include <dos.h>
extern unsigned int INPUT_LIMIT;
extern char near *TOKEN_PTR;
extern unsigned char far pascal INPUT_REFILL(void);
extern int far pascal SCAN_TOKEN(int);
extern void far pascal SCAN_EMIT_FAR(char);
extern void far *far pascal MALLOC(unsigned int);
extern void far pascal BCC_SCAN_FINISH_FAR(int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* #pragma inside the preamble: hdrfile "name" sets the file name and
   scanning goes on; hdrstop ends the preamble; any other pragma is
   executed at once if no preamble directive has been recorded yet, and
   otherwise ends the preamble. */
static int near pascal PCH_DIRECTIVE_PRAGMA(int value)
{
    register int close;

    value=SCAN_TOKEN(value);
    if (COMPARE_NAME(STR_HDRFILE,NAME_BUFFER)==0) {
        value=SCAN_NEXT(value);
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        TOKEN_TEXT_BUFFER[0]=0;
        if (value=='"') {
            close=value;
            value=GETBYTE;
        } else
            close=0x1A;
        do {
            SCAN_EMIT_FAR(value);
            value=GETBYTE;
        } while (value!=0x1A && value!=10 && value!=13 && value!=close);
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        PCH_FILE_NAME=MALLOC(STRING_LENGTH(TOKEN_TEXT_BUFFER)+1);
        STRING_COPY(PCH_FILE_NAME,TOKEN_TEXT_BUFFER);
        BCC_SCAN_FINISH_FAR(value);
        return 1;
    }
    if (COMPARE_NAME(STR_HDRSTOP,NAME_BUFFER)==0) {
        BCC_SCAN_FINISH_FAR(value);
        return 0;
    }
    STRING_COPY(TOKEN_TEXT_BUFFER,STR_PRAGMA_2);
    STRING_APPEND(TOKEN_TEXT_BUFFER,NAME_BUFFER);
    return PUSH_BACK_DIRECTIVE(TOKEN_TEXT_BUFFER,PREAMBLE_LIST_HEAD==0 ? 1 : 0);
}
#undef GETBYTE

/* ---- ADD_PREAMBLE_ENTRY (listing CE5B) ---- */
#include <dos.h>

/* Appends a directive record of kind with text name and the current
   logical line to the preamble list. */
static void near pascal ADD_PREAMBLE_ENTRY(unsigned int kind,char near *name)
{
    register unsigned int entry;

    entry=POOL_ALLOC(&PREAMBLE_POOL_SEG,STRING_LENGTH(name)+9);
    PDIR_W(entry,PDIR_NEXT)=0;
    PDIR_W(entry,PDIR_KIND)=kind;
    PDIR_W(entry,PDIR_LINE)=LOGICAL_LINE;
    STRING_COPY((char far *)MK_FP(PREAMBLE_POOL_SEG,entry+PDIR_TEXT),name);
    if (PREAMBLE_LIST_HEAD) {
        *((unsigned int far *)MK_FP(PREAMBLE_POOL_SEG,PREAMBLE_LIST_TAIL))=entry;
        PDIR_W(entry,PDIR_PREV)=PREAMBLE_LIST_TAIL;
    } else {
        PREAMBLE_LIST_HEAD=entry;
        PDIR_W(entry,PDIR_PREV)=0;
    }
    PREAMBLE_LIST_TAIL=entry;
}

/* ---- PCH_DIRECTIVE_INCLUDE (listing CED7) ---- */
#include <dos.h>
extern char near *far pascal TOKEN_TRIM(void);
extern void far cdecl REPORT_ERROR(int,...);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* #include in the preamble: records "file" or <file> and returns 1.  A
   macro name instead of a file name ends the preamble (the directive is
   left in the pushback buffer); a malformed name is reported and also
   ends it. */
static int near pascal PCH_DIRECTIVE_INCLUDE(int value)
{
    int close;
    int length;
    register char near *name;
    register char near *last;

    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    if (value=='<' || value=='"') {
        TOKEN_TEXT_BUFFER[0]=0;
        if (value=='<')
            close='>';
        else
            close='"';
        do {
            SCAN_EMIT_FAR(value);
            value=GETBYTE;
        } while (value!=0x1A && value!=10 && value!=13 && value!=close);
        if (value==close) {
            SCAN_EMIT_FAR(value);
            value=' ';
        }
        TOKEN_PTR=TOKEN_TEXT_BUFFER;
        BCC_SCAN_FINISH_FAR(value);
        name=TOKEN_TRIM();
        last=name+STRING_LENGTH(name)-1;
        if (*name!='"' && *name!='<') {
            REPORT_ERROR(MSG_BAD_FILE_NAME_FORMAT);
            return 0;
        }
    } else {
        --INPUT_INDEX;
        STRING_COPY(PREAMBLE_PUSHBACK_BUFFER,STR_HASH);
        STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,TOKEN_TEXT_BUFFER);
        STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,STR_SPACE);
        return 0;
    }
    if ((*name=='"' && *last!='"') || (*name=='<' && *last!='>')) {
        REPORT_ERROR(MSG_NO_FILE_NAME_ENDING);
        return 0;
    }
    close=*name;
    *last=0;
    ++name;
    length=STRING_LENGTH(name);
    if (length>0x50) {
        REPORT_ERROR(MSG_FILE_NAME_TOO_LONG);
        return 0;
    }
    ADD_PREAMBLE_ENTRY(close=='<' ? 0 : 1,name);
    return 1;
}
#undef GETBYTE

/* ---- PCH_DIRECTIVE_ELSE (listing D02D) ---- */
#include <dos.h>

/* A directive that cannot be recorded (#else and the like): executed at
   once if the preamble is still empty, otherwise it ends the preamble. */
static int near pascal PCH_DIRECTIVE_ELSE(int value)
{
    return PUSH_BACK_DIRECTIVE(TOKEN_TEXT_BUFFER,PREAMBLE_LIST_HEAD==0 ? 1 : 0);
}

/* ---- PCH_PUSH_BACK_DIRECTIVE_NOW (listing D04C) ---- */
#include <dos.h>

/* A directive that is always executed at once without ending the
   preamble scan. */
static int near pascal PCH_PUSH_BACK_DIRECTIVE_NOW(int value)
{
    return PUSH_BACK_DIRECTIVE(TOKEN_TEXT_BUFFER,1);
}

/* ---- READ_DIRECTIVE_LINE (listing D060) ---- */
#include <dos.h>
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* Reads the rest of the directive line into the token buffer and returns
   it trimmed. */
static char near *near pascal READ_DIRECTIVE_LINE(int value)
{
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    while (value!=0x1A && value!=10 && value!=13) {
        SCAN_EMIT_FAR(value);
        value=GETBYTE;
    }
    TOKEN_PTR=TOKEN_TEXT_BUFFER;
    BCC_SCAN_FINISH_FAR(value);
    return TOKEN_TRIM();
}
#undef GETBYTE

/* ---- PCH_DIRECTIVE_DEFINE (listing D0C5) ---- */
#include <dos.h>

/* #define in the preamble: executed at once while the preamble is empty
   (so macros set before the first #include count as predefined),
   otherwise recorded. */
static int near pascal PCH_DIRECTIVE_DEFINE(int value)
{
    if (PREAMBLE_LIST_HEAD==0)
        PUSH_BACK_DIRECTIVE(TOKEN_TEXT_BUFFER,1);
    else
        ADD_PREAMBLE_ENTRY(2,READ_DIRECTIVE_LINE(value));
    return 1;
}

/* ---- ADD_CONDITIONAL_ENTRY (listing D0F3) ---- */
#include <dos.h>

/* #if, #ifdef or #ifndef (kind 3, 4, 5) in the preamble: executed at once
   while the preamble is empty, otherwise recorded with its line text, and
   the open conditional is counted in PREAMBLE_IF_DEPTH. */
static int near pascal ADD_CONDITIONAL_ENTRY(int value,unsigned int kind)
{
    if (PREAMBLE_LIST_HEAD==0)
        PUSH_BACK_DIRECTIVE(TOKEN_TEXT_BUFFER,1);
    else {
        ADD_PREAMBLE_ENTRY(kind,READ_DIRECTIVE_LINE(value));
        ++PREAMBLE_IF_DEPTH;
    }
    return 1;
}

/* ---- PCH_DIRECTIVE_IF (listing D124) ---- */
#include <dos.h>

static int near pascal PCH_DIRECTIVE_IF(int value)
{
    return ADD_CONDITIONAL_ENTRY(value,3);
}

/* ---- PCH_DIRECTIVE_IFDEF (listing D137) ---- */
#include <dos.h>

static int near pascal PCH_DIRECTIVE_IFDEF(int value)
{
    return ADD_CONDITIONAL_ENTRY(value,4);
}

/* ---- PCH_DIRECTIVE_IFNDEF (listing D14A) ---- */
#include <dos.h>

static int near pascal PCH_DIRECTIVE_IFNDEF(int value)
{
    return ADD_CONDITIONAL_ENTRY(value,5);
}

/* ---- PCH_DIRECTIVE_ENDIF (listing D15D) ---- */
#include <dos.h>

/* #endif in the preamble: recorded if it closes a recorded conditional,
   otherwise executed at once. */
static int near pascal PCH_DIRECTIVE_ENDIF(int value)
{
    if (PREAMBLE_IF_DEPTH<=0)
        PUSH_BACK_DIRECTIVE(TOKEN_TEXT_BUFFER,1);
    else {
        ADD_PREAMBLE_ENTRY(6,READ_DIRECTIVE_LINE(value));
        --PREAMBLE_IF_DEPTH;
    }
    return 1;
}

/* ---- SKIP_BLANKS_AND_NEWLINES (listing D18F) ---- */
#include <dos.h>

extern char  CHAR_CLASS[];
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* Skips blanks, comments and line ends; returns the next character. */
static unsigned int near pascal SKIP_BLANKS_AND_NEWLINES(unsigned int value)
{
    for (;;) {
        value = SCAN_NEXT(value);
        if (CHAR_CLASS[value + 1] != (char)0xEC)
            break;
        LEX_NEWLINE(value);
        value = GETBYTE;
    }
    return value;
}
#undef GETBYTE

/* ---- SCAN_EXTERN_LINKAGE (listing D1E1) ---- */
#include <dos.h>
extern char  _CTYPE[];
static void near pascal ADD_PREAMBLE_ENTRY(unsigned int kind,char near *name);
static unsigned int near pascal SKIP_BLANKS_AND_NEWLINES(unsigned int value);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* Called when the next line is not a directive.  Accepts extern "name" {
   (recorded as kind 7) and a closing brace (kind 8) as part of the
   preamble and returns 1.  Anything else ends the preamble: the text read
   so far is rebuilt in PREAMBLE_PUSHBACK_BUFFER and 0 is returned. */
static int near pascal SCAN_EXTERN_LINKAGE(void)
{
    unsigned int value;
    char near *path;
    value=GETBYTE;
    LOGICAL_LINE=CURRENT_LINE;
    if (value=='}') {
        ADD_PREAMBLE_ENTRY(8,STR_EMPTY);
        return 1;
    }
    path=TOKEN_TEXT_BUFFER;
    while ((int)_CTYPE[value+1]&12) {
        *path=value;
        ++path;
        value=GETBYTE;
    }
    *path=0;
    if (COMPARE_NAME(STR_EXTERN,TOKEN_TEXT_BUFFER)) {
        STRING_COPY(PREAMBLE_PUSHBACK_BUFFER,TOKEN_TEXT_BUFFER);
rewind:
        --INPUT_INDEX;
        return 0;
    }
    value=SKIP_BLANKS_AND_NEWLINES(value);
    if (value!='"') {
        STRING_COPY(PREAMBLE_PUSHBACK_BUFFER,STR_EXTERN_2);
        goto rewind;
    }
    value=GETBYTE;
    path=TOKEN_TEXT_BUFFER;
    while (value!='"') {
        *path=value;
        ++path;
        value=GETBYTE;
    }
    *path=0;
    if (value=='"') value=GETBYTE;
    value=SKIP_BLANKS_AND_NEWLINES(value);
    if (value!='{') {
        STRING_COPY(PREAMBLE_PUSHBACK_BUFFER,STR_EXTERN_3);
        STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,TOKEN_TEXT_BUFFER);
        STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,STR_QUOTE_CRLF);
        --CURRENT_LINE;
        goto rewind;
    }
    ADD_PREAMBLE_ENTRY(7,TOKEN_TEXT_BUFFER);
    return 1;
}
#undef GETBYTE

/* ---- SCAN_PREAMBLE_DIRECTIVE (listing D38D) ---- */
#include <dos.h>
struct Handler { char near *name; int (near pascal *run)(unsigned int); };
extern struct Handler  PREAMBLE_DIRECTIVE_TABLE[];
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* Scans one line of the preamble; returns nonzero to go on.  A directive
   is dispatched through PREAMBLE_DIRECTIVE_TABLE (9 entries, the handlers
   above); an unknown one ends the preamble. */
static int near pascal SCAN_PREAMBLE_DIRECTIVE(void)
{
    unsigned int value;
    struct Handler near *entry;
    char near *path;
    if (!NEXT_LINE_IS_DIRECTIVE()) return SCAN_EXTERN_LINKAGE();
    value=GETBYTE;
    LOGICAL_LINE=CURRENT_LINE;
    path=TOKEN_TEXT_BUFFER;
    while ((int)_CTYPE[value+1]&12) {
        *path=value;
        ++path;
        value=GETBYTE;
    }
    *path=0;
    value=SCAN_NEXT(value);
    for (entry=PREAMBLE_DIRECTIVE_TABLE;entry<PREAMBLE_DIRECTIVE_TABLE+9;++entry) {
        if (COMPARE_NAME(entry->name,TOKEN_TEXT_BUFFER)==0) return entry->run(value);
    }
    STRING_COPY(PREAMBLE_PUSHBACK_BUFFER,STR_HASH);
    STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,TOKEN_TEXT_BUFFER);
    STRING_APPEND(PREAMBLE_PUSHBACK_BUFFER,STR_SPACE);
    --INPUT_INDEX;
    return 0;
}
#undef GETBYTE

/* ---- RESET_PCH_STATE (listing D47B) ---- */
extern void far pascal POOL_TRIM(unsigned int far *,unsigned int);

/* Empties all the precompiled-header pools once the preamble is done. */
static void near pascal RESET_PCH_STATE(void)
{
    PREAMBLE_POOL_FREE_LIST=0;
    PREAMBLE_POOL_USED=2;
    PCH_INDEX_POOL_FREE=0;
    PCH_INDEX_POOL_USED=2;
    MACRO_SNAPSHOT_POOL_FREE=0;
    MACRO_SNAPSHOT_POOL_USED=0;
    PCH_DEPENDENCY_POOL_FREE=0;
    PCH_DEPENDENCY_POOL_USED=2;
    SAVED_OPTION_POOL_FREE=0;
    SAVED_OPTION_POOL_USED=2;
    POOL_TRIM(&PREAMBLE_POOL_SEG,0);
    POOL_TRIM(&PCH_INDEX_POOL_SEG,0);
    POOL_TRIM(&MACRO_SNAPSHOT_POOL_SEG,0);
    POOL_TRIM(&PCH_DEPENDENCY_POOL_SEG,0);
    POOL_TRIM(&SAVED_OPTION_POOL_SEG,0);
    PCH_DIAGNOSTIC_ISSUED=0;
}

/* ---- STAG002 (listing D504) ---- */
#include <dos.h>
/* Static near walker over 8-byte links in the pool segment (CO069). The 8-byte
   switch table after the code is the compiler's; the link keeps the original's. */
struct Link { unsigned int next,field2,field4,kind; };
#define N(n) ((struct Link far *)MK_FP(PREAMBLE_POOL_SEG,(n)))
/* Returns the #endif record (kind 6) that closes the conditional whose
   body starts at record input, counting nested #if kinds (3 to 5); the
   last record if there is none.  struct Link spells out the PDIR layout
   (next, previous, line, kind). */
static unsigned int near pascal FIND_MATCHING_ENDIF(unsigned int input)
{
    register unsigned int node=input;
    register int depth=1;
    for(;;) {
        switch(N(node)->kind) {
        case 3:case 4:case 5:++depth;break;
        case 6:if(--depth) break;return node;
        }
        if(N(node)->next) node=N(node)->next;
        else break;
    }
    return node;
}
#undef N

/* ---- FIND_BALANCED_BLOCK_END (listing D54F) ---- */
#include <dos.h>

/* Walks the directive list from node over balanced #if ... #endif and
   extern "C" { ... } groups.  Returns the record that closes the current
   level (an #endif or closing brace), or the first opener that is never
   closed (0 instead when nested), or 0 at the end of the list. */
static unsigned int near pascal FIND_BALANCED_BLOCK_END(register unsigned int node,unsigned int nested)
{
    register unsigned int end;
    while (node) {
        switch (PDIR_W(node,PDIR_KIND)) {
        case 7:
            end=FIND_BALANCED_BLOCK_END(PDIR_W(node,PDIR_NEXT),1);
            if (end && PDIR_W(end,PDIR_KIND)==8)
                node=end;
            else {
                if (nested)
                    return 0;
                return node;
            }
            break;
        case 6: case 8:
            return node;
        case 3: case 4: case 5:
            end=FIND_BALANCED_BLOCK_END(PDIR_W(node,PDIR_NEXT),1);
            if (end && PDIR_W(end,PDIR_KIND)==6)
                node=end;
            else {
                if (nested)
                    return 0;
                return node;
            }
            break;
        }
        node=PDIR_W(node,PDIR_NEXT);
    }
    return node;
}

/* ---- FIND_PREAMBLE_END (listing D5ED) ---- */
#include <dos.h>

static unsigned int near pascal FIND_BALANCED_BLOCK_END(unsigned int node,unsigned int nested);


/* Decides how much of the preamble can be precompiled: everything before
   the first unclosed group, minus any #defines at its end (they are left
   to be compiled normally, probably so a saved state ends with an
   #include).  Returns the first record of the part that is not
   precompiled, or 0 if all of it is. */
static unsigned int near pascal FIND_PREAMBLE_END(register unsigned int value)
{
    register unsigned int prev;

    prev = FIND_BALANCED_BLOCK_END(value, 0);
    if (prev)
        value = PDIR_W(prev, PDIR_PREV);
    else
        value = PREAMBLE_LIST_TAIL;
    while (value && PDIR_W(value, PDIR_KIND) == 2) {
        prev = value;
        value = PDIR_W(value, PDIR_PREV);
    }
    return prev;
}

/* ---- REBUILD_DIRECTIVE_TEXT (listing D635) ---- */
#include <dos.h>
#define NODETEXT ((char far *)MK_FP(PREAMBLE_POOL_SEG,node+8))
#define WORD(n) (*((int far *)MK_FP(PREAMBLE_POOL_SEG,node+(n))))
/* Turns the directive records from node on back into source text in
   TOKEN_TEXT_BUFFER, one directive per line, adding line ends so each lands on
   its original line; CURRENT_LINE is set back to before the first one, so
   the text can be pushed back as input with correct line numbers. */
static void near pascal REBUILD_DIRECTIVE_TEXT(register unsigned int node)
{
    int saved_line;
    register int line;
    saved_line=CURRENT_LINE;
    LOGICAL_LINE=CURRENT_LINE=line=WORD(4)-1;
    for (;node;node=WORD(0)) {
        while (WORD(4)>line) {
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_CRLF);
            ++line;
        }
        switch (WORD(6)) {
        case 0:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_INCLUDE);
            STRING_APPEND(TOKEN_TEXT_BUFFER,NODETEXT);
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_GREATER);
            break;
        case 1:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_INCLUDE_2);
            STRING_APPEND(TOKEN_TEXT_BUFFER,NODETEXT);
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_QUOTE);
            break;
        case 2:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_DEFINE_2);
            goto append_node;
        case 3:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_IF_3);
            goto append_node;
        case 4:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_IFDEF);
            goto append_node;
        case 5:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_IFNDEF);
append_node:
            STRING_APPEND(TOKEN_TEXT_BUFFER,NODETEXT);
            break;
        case 6:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_ENDIF);
            break;
        case 7:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_EXTERN_3);
            STRING_APPEND(TOKEN_TEXT_BUFFER,NODETEXT);
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_QUOTE_OPEN_BRACE);
            break;
        case 8:
            STRING_APPEND(TOKEN_TEXT_BUFFER,STR_CLOSE_BRACE);
            break;
        }
    }
    while (line<saved_line) {
        STRING_APPEND(TOKEN_TEXT_BUFFER,STR_CRLF);
        ++line;
    }
}
#undef NODETEXT
#undef WORD

/* ---- SAVE_WARNING_SWITCH (listing D7AD) ---- */
#include <dos.h>
/* Records a #pragma warn switch made inside a header (prefix '+', '-' or
   '.', then the warning name) for REPLAY_SAVED_OPTIONS. */
void far pascal SAVE_WARNING_SWITCH(char far *text, unsigned char prefix)
{
    register unsigned int node;
    node = POOL_ALLOC(&SAVED_OPTION_POOL_SEG, STRING_LENGTH(text) + 2);
    *(unsigned char far *)MK_FP(SAVED_OPTION_POOL_SEG,node) = prefix;
    ++node;
    STRING_COPY(MK_FP(SAVED_OPTION_POOL_SEG,node), text);
}

/* ---- STAOV118 (listing D7EB) ---- */
/* Notes that the headers need the compile to go through the assembler
   (called from CHECK_NAME_CONTEXT in PREPROC.C, probably the #pragma
   inline handler, when it runs inside a header); saved in the state's header so
   a load can restart the compile that way. */
void far pascal CONTEXT_DIAGNOSTIC(void)
{
    PCH_DIAGNOSTIC_ISSUED = 1;
}

/* ---- SAVE_OPTION_STRING (listing D7F5) ---- */
#include <dos.h>
/* Records a #pragma option text made inside a header, marked '=' (0x3D),
   for REPLAY_SAVED_OPTIONS. */
void far pascal SAVE_OPTION_STRING(char far *text)
{
    register unsigned int node;
    node = POOL_ALLOC(&SAVED_OPTION_POOL_SEG, STRING_LENGTH(text) + 2);
    *(unsigned char far *)MK_FP(SAVED_OPTION_POOL_SEG,node) = 0x3D;
    ++node;
    STRING_COPY(MK_FP(SAVED_OPTION_POOL_SEG,node), text);
}

/* ---- STAG003 (listing D831) ---- */
#include <dos.h>
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
/* extern "name" { while replaying the preamble: saves CURRENT_LINKAGE on
   LINKAGE_STACK and sets it from the name (1 or 2 for the two names the
   compiler knows, STR_C and STR_C_2; anything else is an error). */
static void near pascal PUSH_LANGUAGE_LINKAGE(char far *name)
{
    register unsigned int node;
    node=POOL_ALLOC_REUSE(&LINKAGE_STACK_POOL_SEG,4);
    LINKSTK_W(node,LINKSTK_SAVED_LINKAGE)=CURRENT_LINKAGE;
    LINKSTK_W(node,LINKSTK_NEXT)=LINKAGE_STACK;
    LINKAGE_STACK=node;
    if(COMPARE_NAME(name,STR_C)==0) CURRENT_LINKAGE=1;
    else if(COMPARE_NAME(name,STR_C_2)==0) CURRENT_LINKAGE=2;
    else {
        CURRENT_LINKAGE=0;
        REPORT_CURRENT_TOKEN(MSG_UNKNOWN_LANGUAGE_MUST);
    }
}

/* ---- STAG004 (listing D8A8) ---- */
#include <dos.h>
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);
/* The closing brace of an extern "name" block: restores the saved
   linkage. */
static void near pascal POP_LANGUAGE_LINKAGE(void)
{
    register unsigned int node;
    if(!LINKAGE_STACK) REPORT_CURRENT_TOKEN(MSG_UNEXPECTED);
    else {
        node=LINKAGE_STACK;
        LINKAGE_STACK=LINKSTK_W(node,LINKSTK_NEXT);
        CURRENT_LINKAGE=LINKSTK_W(node,LINKSTK_SAVED_LINKAGE);
        POOL_FREE_ITEM(&LINKAGE_STACK_POOL_SEG,node);
    }
}

/* ---- REPLAY_PREAMBLE (listing D8E3) ---- */
#include <dos.h>
extern int ERROR_COUNT;
extern long  TOKEN_CONST_VALUE;
extern char far *INCLUDE_OPTION_TEXT_PTR;
extern int (far *EVAL_EXPRESSION)(void);
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern void far pascal BCC_INPUT_STRING_PTR(unsigned int,unsigned int);
extern unsigned int far pascal OPEN_SOURCE_FILE(char far *);
extern void far pascal RECORD_SOURCE_NAME(void);
extern int far pascal OPEN_INCLUDE_FILE(char far *);
extern int far pascal MACRO_DEFINED(char far *);
extern unsigned int far pascal ANY_SEGMENT_HAS_DATA(void);
static unsigned int near pascal FIND_MATCHING_ENDIF(unsigned int input);
static void near pascal PUSH_LANGUAGE_LINKAGE(char far *name);
static void near pascal POP_LANGUAGE_LINKAGE(void);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : \
    ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])

/* Continues compiling the recorded preamble from PREAMBLE_REPLAY_NODE.
   #define records are fed through the directive code as text; #if,
   #ifdef and #ifndef are evaluated and a false one skips to its #endif;
   extern blocks push and pop the linkage.  An #include opens the file and
   returns at once (the next record is kept in PREAMBLE_REPLAY_NODE);
   POP_INPUT_CONTEXT calls this again when the main file is resumed, which
   happens after every top-level #include and so also in compiles without
   precompiled headers, where it finds nothing to do.  At the end: saves
   or invalidates the state if a save is pending, closes the file, and
   pushes back as input the text of the directives that were not part of
   the precompiled preamble plus the line that ended the preamble. */
void far pascal REPLAY_PREAMBLE(void)
{
    char name[256];
    register unsigned int node;
    register unsigned int entry;

    node=PREAMBLE_REPLAY_NODE;
    while (node) {
        STRING_COPY(name,(char far *)MK_FP(PREAMBLE_POOL_SEG,node+PDIR_TEXT));
        LOGICAL_LINE=PDIR_W(node,PDIR_LINE);
        switch (PDIR_W(node,PDIR_KIND)) {
        case 0:
        case 1:
            if ((PDIR_W(node,PDIR_KIND)==1 || name[1]==':' || name[0]=='/' || name[0]=='\\' ||
                 *INCLUDE_OPTION_TEXT_PTR==0) && OPEN_SOURCE_FILE(name)) {
                RECORD_SOURCE_NAME();
                PREAMBLE_REPLAY_NODE=PDIR_W(node,PDIR_NEXT);
                return;
            }
            if (!OPEN_INCLUDE_FILE(name)) {
                REPORT_ERROR(MSG_UNABLE_OPEN_INCLUDE,(char far *)name);
                RECORD_SOURCE_NAME();
                PREAMBLE_REPLAY_NODE=PDIR_W(node,PDIR_NEXT);
                return;
            }
            RECORD_SOURCE_NAME();
            PREAMBLE_REPLAY_NODE=PDIR_W(node,PDIR_NEXT);
            return;
        case 2:
            STRING_COPY(name,STR_DEFINE_3);
            STRING_APPEND(name,(char far *)MK_FP(PREAMBLE_POOL_SEG,node+PDIR_TEXT));
            STRING_APPEND(name,STR_NEWLINE);
            BCC_INPUT_STRING(name);
            DIRECTIVE_START(0x20);
            if (CHAR_CLASS[GETBYTE+1]==-20)
                GETBYTE;
            --INPUT_INDEX;
            break;
        case 3:
            STRING_APPEND(name,STR_NEWLINE);
            BCC_INPUT_STRING(name);
            if (!(*EVAL_EXPRESSION)() || !TOKEN_CONST_VALUE)
                node=FIND_MATCHING_ENDIF(PDIR_W(node,PDIR_NEXT));
            GETBYTE;
            --INPUT_INDEX;
            break;
        case 4:
            if (!MACRO_DEFINED(name))
                node=FIND_MATCHING_ENDIF(PDIR_W(node,PDIR_NEXT));
            break;
        case 5:
            if (MACRO_DEFINED(name))
                node=FIND_MATCHING_ENDIF(PDIR_W(node,PDIR_NEXT));
            break;
        case 7:
            PUSH_LANGUAGE_LINKAGE(name);
            break;
        case 8:
            POP_LANGUAGE_LINKAGE();
            break;
        }
        node=PDIR_W(node,PDIR_NEXT);
    }
    PREAMBLE_REPLAY_NODE=0;
    if (PCH_SAVE_PENDING) {
        PCH_SAVE_PENDING=0;
        (*BEGIN_BACKEND_OUTPUT_HOOK)();
        if (ERROR_COUNT || ANY_SEGMENT_HAS_DATA() || LINKAGE_STACK)
            INVALIDATE_PCH_ENTRY();
        else
            WRITE_PCH_ENTRY();
    }
    PCH_COLLECT_DEPENDENCIES=0;
    if (PCH_FILE_HANDLE>=0) {
        RTL_CLOSE(PCH_FILE_HANDLE);
        PCH_FILE_HANDLE=-1;
    }
    TOKEN_TEXT_BUFFER[0]=0;
    if (PREAMBLE_REMAINDER_NODE) {
        REBUILD_DIRECTIVE_TEXT(PREAMBLE_REMAINDER_NODE);
        PREAMBLE_REMAINDER_NODE=0;
    }
    if (PREAMBLE_PUSHBACK_BUFFER[0]) {
        if (TOKEN_TEXT_BUFFER[0]==0) {
            STRING_COPY(TOKEN_TEXT_BUFFER,STR_CRLF);
            --CURRENT_LINE;
        }
        STRING_APPEND(TOKEN_TEXT_BUFFER,PREAMBLE_PUSHBACK_BUFFER);
        PREAMBLE_PUSHBACK_BUFFER[0]=0;
    }
    RESET_PCH_STATE();
    entry=POOL_ALLOC(&PREAMBLE_POOL_SEG,STRING_LENGTH(TOKEN_TEXT_BUFFER)+1);
    STRING_COPY((char far *)MK_FP(PREAMBLE_POOL_SEG,entry),TOKEN_TEXT_BUFFER);
    BCC_INPUT_STRING_PTR((unsigned int)&PREAMBLE_POOL_SEG,entry);
}
#undef GETBYTE

/* ---- INIT_PCH_STATE (listing DBBA) ---- */
/* Clears the preamble state and sets up the precompiled-header pools for
   a new compile. */
void far pascal INIT_PCH_STATE(void)
{
    PREAMBLE_REPLAY_NODE=PREAMBLE_REMAINDER_NODE=PREAMBLE_LIST_HEAD=PREAMBLE_LIST_TAIL=PREAMBLE_MISMATCH_NODE=0;
    PREAMBLE_PUSHBACK_BUFFER[0]=0;
    PCH_SAVE_PENDING=0;
    PCH_COLLECT_DEPENDENCIES=0;
    PCH_FILE_HANDLE=-1;
    PREAMBLE_POOL_USED=PREAMBLE_POOL_CAPACITY=2;
    PREAMBLE_POOL_FREE_LIST=0;
    POOL_INIT(&PREAMBLE_POOL_SEG,2);
    PCH_INDEX_POOL_USED=PCH_INDEX_POOL_CAPACITY=2;
    PCH_INDEX_POOL_FREE=0;
    POOL_INIT(&PCH_INDEX_POOL_SEG,2);
    MACRO_SNAPSHOT_POOL_USED=MACRO_SNAPSHOT_POOL_CAPACITY=0;
    MACRO_SNAPSHOT_POOL_FREE=0;
    POOL_INIT(&MACRO_SNAPSHOT_POOL_SEG,0);
    PCH_DEPENDENCY_POOL_USED=PCH_DEPENDENCY_POOL_CAPACITY=2;
    PCH_DEPENDENCY_POOL_FREE=0;
    POOL_INIT(&PCH_DEPENDENCY_POOL_SEG,2);
    SAVED_OPTION_POOL_USED=SAVED_OPTION_POOL_CAPACITY=0;
    SAVED_OPTION_POOL_FREE=0;
    POOL_INIT(&SAVED_OPTION_POOL_SEG,0);
    PCH_DEPENDENCY_HEAD=PCH_DEPENDENCY_TAIL=0;
}

/* ---- TRY_PCH_LOAD (listing DC7A) ---- */
#include <dos.h>
extern unsigned int TOKEN_TYPE;
static int near pascal SCAN_PREAMBLE_DIRECTIVE(void);
static unsigned int near pascal FIND_PREAMBLE_END(register unsigned int value);
static void near pascal SAVE_MACRO_SNAPSHOT(void);
static int near pascal LOAD_PCH_FILE(void);
static void near pascal NOTIFY_PCH_DEPENDENCIES(void);
static unsigned int near pascal APPEND_DIRECTIVE_LIST(unsigned int node, unsigned int value);
extern void far pascal REPLAY_PREAMBLE(void);

/* Entry point, called once per compile before parsing (COMPILE_C_SOURCE
   for the C front end, driver/INITTYPE.C for the C++ one).  Scans the preamble, splits off the part that
   cannot be precompiled, snapshots the macros, and tries to load a saved
   state.  On success the matched directives are dropped and the rest is
   left as text; on failure (unless mode 4) the state will be saved after
   the preamble has been compiled.  REPLAY_PREAMBLE then starts the work.
   TOKEN_TYPE is set to "no token" so the parser's first read starts
   fresh. */
void far pascal TRY_PCH_LOAD(void)
{
    if (PCH_OPTION_MODE) {
        PREAMBLE_IF_DEPTH=0;
        while(SCAN_PREAMBLE_DIRECTIVE()) ;
        PREAMBLE_REPLAY_NODE=PREAMBLE_LIST_HEAD;
        PREAMBLE_REMAINDER_NODE=FIND_PREAMBLE_END(PREAMBLE_LIST_HEAD);
        if (PREAMBLE_REMAINDER_NODE) {
            if (PDIR_W(PREAMBLE_REMAINDER_NODE,PDIR_PREV))
                PDIR_W(PDIR_W(PREAMBLE_REMAINDER_NODE,PDIR_PREV),PDIR_NEXT)=0;
            else PREAMBLE_REPLAY_NODE=0;
        }
        if (PREAMBLE_REPLAY_NODE) {
            SAVE_MACRO_SNAPSHOT();
            if (!LOAD_PCH_FILE()) {
                NOTIFY_PCH_DEPENDENCIES();
                RTL_CLOSE(PCH_FILE_HANDLE);
                PCH_FILE_HANDLE=-1;
                PREAMBLE_REPLAY_NODE=0;
                PREAMBLE_REMAINDER_NODE=APPEND_DIRECTIVE_LIST(PREAMBLE_MISMATCH_NODE,PREAMBLE_REMAINDER_NODE);
            } else if (PCH_OPTION_MODE!=4) {
                PCH_COLLECT_DEPENDENCIES=1;
                PCH_SAVE_PENDING=1;
            }
        }
        PCH_DEPENDENCY_POOL_FREE=0;
        PCH_DEPENDENCY_POOL_USED=2;
        REPLAY_PREAMBLE();
        TOKEN_TYPE=0x82;
    }
}

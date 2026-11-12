/* target: NAMEPOOL */
/* opts: -mm -O -Z -p -B -TjNOSMART */
/* CPP.EXE module NAMEPOOL (image 0x8F97..0x9187, frame 08F9h): source taken unchanged
   from the BCC.EXE reconstruction (bcc20/src/types/NAMEPOOL.C); its code
   is the same in both programs (BCC's file was built with -Y, this one without). */
/* Role: the symbol-name pool: hashes and interns names, copying new name text into
   pool banks. Entry point: BCC_SYMBOL_CREATE. */
/* Overview: the identifier table. Every identifier, keyword and macro name is turned
   into one name record by BCC_SYMBOL_CREATE, so that two spellings of the same name
   always give the same record number and later code can compare names as 16-bit
   numbers. Callers in CPP.EXE: the lexer for each identifier, INIT_POOLS_AND_KEYWORDS
   (driver/INITPOOL.C), which enters the keywords with their token code as value, and
   the macro code (preproc/MACROS.C) for macro names.
   Data: NAME_HASH_TABLE (1024 chain heads), the two parallel 6-byte record pools
   NAME_POOL_SEG and HASH_CHAIN_LINK_SEG described below, and the text banks C31_BANKS
   with CURRENT_BANK_INDEX, which this file advances when a bank is nearly full (64K
   segments, so text never crosses a segment). Names are never removed.
   The note below and the per-function notes describe the inline asm, which is kept
   from the original. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"

/* The symbol-name pool.  Names are interned once: BCC_SYMBOL_CREATE
   hashes a name, searches the hash chain and, if the name is new, copies it
   into the current pool bank.  Both functions contain inline asm in the
   original (block copy, strlen and compare loops, and a jmp padded with a
   nop by TASM), so the file went through TASM (-B; -TjNOSMART as for the
   lexer). */

struct C31Bank { unsigned int segment,capacity,used,extra; };
extern struct C31Bank near C31_BANKS[];
extern unsigned int NAME_POOL_SEG,HASH_CHAIN_LINK_SEG;
extern unsigned int NAME_HASH_TABLE[];
extern void far pascal POOL_INIT(unsigned int far *pool,int units);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *pool,unsigned int size);

/* Name records live at the same offset in two pools, which are always
   allocated in lockstep (6 bytes each, initialised alike in
   INIT_POOLS_AND_KEYWORDS, driver/INITPOOL.C), so
   only the NAME_POOL_SEG allocation's offset is kept.
   HASH_CHAIN_LINK_SEG: +0 hash-chain link, +2 macro definition (0 if none),
               +4 value (token or keyword code).
   NAME_POOL_SEG: +0 head of the symbols bound to this name, +2 offset of the
               text, +4 near pointer to its C31Bank entry. */

/* Copy length bytes of text into the current pool bank, opening the next
   bank when used+length reaches 0xFF00.  Returns DX = near pointer to the
   C31Bank entry and AX = offset of the copy within bank->segment.
   The asm block (0057..) takes POOL_ALLOC's AX directly as the copy
   destination (mov di,ax) and leaves it untouched.
   Documented exception (falls off the end): the original leaves the result
   in DX:AX from its inline asm (mov dx,bx at 005C; AX is POOL_ALLOC's
   result) and has no return statement. */
static unsigned long near pascal COPY_NAME_TO_BANK(char far *text,unsigned int length)
{
    struct C31Bank near *bank;

    bank=&C31_BANKS[CURRENT_BANK_INDEX];
    if(bank->used+length>=0xFF00) {
        CURRENT_BANK_INDEX++;
        bank++;
        bank->used=bank->capacity=1;
        bank->extra=0;
        POOL_INIT(&bank->segment,1);
    }
    POOL_ALLOC(&bank->segment,length);
    asm mov di,ax;
    asm mov bx,word ptr bank;
    asm mov dx,bx;
    asm mov es,word ptr [bx];
    asm mov cx,word ptr length;
    asm push ds;
    asm lds si,dword ptr text;
    asm shr cx,1;
    asm rep movsw;
    asm adc cx,cx;
    asm rep movsb;
    asm pop ds;
}

/* Return the record for the name text, creating it with value if it is
   new.
   Documented exception (falls off the end): the chain search is inline asm
   that returns a found record with mov ax,bx; jmp to the epilogue (0169). */
unsigned int far pascal BCC_SYMBOL_CREATE(char far *text,unsigned int value)
{
    unsigned int node;
    unsigned int created;
    unsigned int length;
    unsigned int hash;

    asm cld;
    asm les di,dword ptr text;
    asm mov cx,0FFFFh;
    asm xor al,al;
    asm repne scasb;
    asm not cx;
    asm mov word ptr length,cx;    /* strlen + 1: includes the NUL */
    /* hash: for two or more characters, the length, the first two bytes and
       the last two characters; otherwise the first character, sign-extended
       and unmasked (a byte >= 0x80 indexes before NAME_HASH_TABLE: the original's
       behaviour) */
    if(length>2)
        hash=((length<<6)+*(unsigned int far *)text
              +(*(unsigned int far *)(text+(length-3))<<3))&0x3FF;
    else
        hash=*text;
    /* bucket empty: the new record becomes the chain head */
    if(NAME_HASH_TABLE[hash]==0) {
        node=POOL_ALLOC(&NAME_POOL_SEG,6);
        POOL_ALLOC(&HASH_CHAIN_LINK_SEG,6);
        NAME_HASH_TABLE[hash]=node;
        HLINK_W(node,HLINK_NEXT)=0;
        NAME_W(node,NAME_SYMBOLS)=0;
        HLINK_W(node,HLINK_MACRO)=0;
        HLINK_W(node,HLINK_TOKEN)=value;
        *(unsigned long far *)MK_FP(NAME_POOL_SEG,node+NAME_TEXT_OFFSET)=COPY_NAME_TO_BANK(text,length);
        return node;
    }
    /* chain search: BX = current record and AX = length carry across the
       loop; DX = the previous record; the compare includes the NUL */
    asm mov bx,word ptr hash;
    asm shl bx,1;
    asm mov bx,word ptr DGROUP:NAME_HASH_TABLE[bx];
    asm mov ax,word ptr length;
compare:
    asm mov es,word ptr DGROUP:NAME_POOL_SEG;
    asm mov si,word ptr es:[bx+4];
    asm mov di,word ptr es:[bx+2];
    asm mov es,word ptr [si];
    asm push ds;
    asm lds si,dword ptr text;
    asm mov cx,ax;
    asm repe cmpsb;
    asm pop ds;
    asm jne next;
    asm mov ax,bx;
    asm jmp done;
next:
    asm mov es,word ptr DGROUP:HASH_CHAIN_LINK_SEG;
    asm mov dx,bx;
    asm mov bx,word ptr es:[bx];
    asm or bx,bx;
    asm jne compare;
    /* not found: DX (stored in node) is the last record of the chain; append a new one */
    asm mov word ptr node,dx;
    created=POOL_ALLOC(&NAME_POOL_SEG,6);
    POOL_ALLOC(&HASH_CHAIN_LINK_SEG,6);
    HLINK_W(node,HLINK_NEXT)=created;
    HLINK_W(created,HLINK_NEXT)=0;
    NAME_W(created,NAME_SYMBOLS)=0;
    HLINK_W(created,HLINK_MACRO)=0;
    HLINK_W(created,HLINK_TOKEN)=value;
    *(unsigned long far *)MK_FP(NAME_POOL_SEG,created+NAME_TEXT_OFFSET)=COPY_NAME_TO_BANK(text,length);
    return created;
done:
    ;
}

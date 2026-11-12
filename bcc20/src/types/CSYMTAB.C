/* target: ovr131_C124UNIT */
/* Role: types and symbols (C mode): scopes and symbol table: lookup, declaring locals and
   globals, member lookup, unused/never-used/use-before-assign warnings. Entry points:
   CREATE_SCOPE, LOOKUP_SYMBOL, BCC_STMT_FIND2, DECLARE_SYMBOL, WARN_UNUSED_SYMBOLS,
   LOOKUP_MEMBER, ADD_STRUCT_MEMBER, BUILD_SYMBOL_OPERAND (+15 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the symbol table used when compiling C (not C++; C++ uses cpp/CPPSCOPE.C).
   It runs during parsing: the declaration parser (parser/CDECL.C) declares names here,
   the expression parser looks them up, and at the end of each block or function
   WARN_UNUSED_SYMBOLS gives the "never used" warnings.
   Data: C symbols are 16-byte CSYM_POOL_SEG records (CSYM_* fields). Their name space
   (CSYM_NAMESPACE: 0 ordinary, 1 label, 2 tag) is called "storage" or "kind" in the
   parameter lists here, and their class (CSYM_CLASS) "kind". Global symbols hang on the
   name record (NAME_SYMBOLS chain of NAME_POOL_SEG, see types/NAMEPOOL.C), unnamed global
   ones on C_UNNAMED_GLOBAL_LIST; local symbols are kept in the symbol list
   (SCOPE_C_SYMBOLS) of a scope cell in SCOPE_POOL_SEG, and scope cells form a tree
   (child, sibling, parent) whose root is C_GLOBAL_SCOPE. An extern declared inside a
   block makes a real global symbol plus a local cell of class 2 whose CSYM_TYPE word
   points at the global symbol; LOOKUP_SYMBOL follows that link.
   Symbol flag bits seen here (CSYM_FLAGS): 0x20 has a definition (two definitions are a
   "multiple declaration"), 0x40 assigned, 0x80 used, 0x200 declared at file level and
   visible, 0x1000 lives in a register (CSYM_SEGMENT then holds the register). Bit 0x10
   is read into a variable called isconst, but DECLARE_NAMED_GLOBAL sets it for far
   helper calls and it makes CSYM_SEGMENT 0xFFFF (no fixed segment), so it probably means
   "far". The many small accessors at the end exist so that the back end can reach the
   C symbol fields through the hook table. */
/* Original CO04A (ovr_1d06_9746) as one source. */
/* opts: -mm -G -O -Z -p -Y -y -k- */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* CREATE_SCOPE: makes a new, empty C scope cell as the first child of "owner" and
   returns it. The ListCell fields are SCOPE_C_CHILD, SCOPE_C_SIBLING, SCOPE_C_PARENT and
   SCOPE_C_SYMBOLS in that order. */
/* ---- STOVR16 (listing 7460) ---- */
#include <dos.h>
extern unsigned int  SCOPE_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
struct ListCell { unsigned int head,next,owner,reserved; };
unsigned int far pascal CREATE_SCOPE(register unsigned int owner)
{
    register unsigned int cell;
    cell=POOL_ALLOC_REUSE(&SCOPE_POOL_SEG,sizeof(struct ListCell));
    RTL_MEMSET(MK_FP(SCOPE_POOL_SEG,cell),0,sizeof(struct ListCell));
    ((struct ListCell far *)MK_FP(SCOPE_POOL_SEG,cell))->owner=owner;
    ((struct ListCell far *)MK_FP(SCOPE_POOL_SEG,cell))->next=((struct ListCell far *)MK_FP(SCOPE_POOL_SEG,owner))->head;
    ((struct ListCell far *)MK_FP(SCOPE_POOL_SEG,owner))->head=cell;
    return cell;
}

/* LOOKUP_SYMBOL: finds "name" in name space "kind", searching the scope input and its
   parents up to (not including) the global scope, then the global symbols (only those
   with flag 0x200). A local extern cell (class 2) gives the global symbol it points at.
   Returns the CSYM record or 0. */
/* ---- STOVR17 (listing 74A3) ---- */
#include <dos.h>
extern unsigned int NAME_POOL_SEG;
unsigned int far pascal LOOKUP_SYMBOL(unsigned int name,unsigned int input,unsigned char kind)
{
    register unsigned int node;
    register unsigned int scope=input;
    while(scope!=0 && scope!=C_GLOBAL_SCOPE) {
        node=SCOPE_W(scope,SCOPE_C_SYMBOLS);
        while(node) {
            if(CSYM_W(node,CSYM_NAME)==name && CSYM_B(node,CSYM_NAMESPACE)==kind) {
                if(CSYM_B(node,CSYM_CLASS)==2) return CSYM_W(node,CSYM_TYPE);
                return node;
            }
            node=CSYM_W(node,CSYM_NEXT);
        }
        scope=SCOPE_W(scope,SCOPE_C_PARENT);
    }
    node=NAME_W(name,NAME_SYMBOLS);
    while(node && CSYM_B(node,CSYM_NAMESPACE)!=kind) node=CSYM_W(node,CSYM_NEXT);
    if(node && (CSYM_W(node,CSYM_FLAGS)&0x200)) return node;
    return 0;
}

/* BCC_STMT_FIND2: like LOOKUP_SYMBOL but searches only the one scope given (used to
   check for a redeclaration in the same block, e.g. of a struct or enum tag). */
/* ---- STOVR18 (listing 753D) ---- */
#include <dos.h>
unsigned int far pascal BCC_STMT_FIND2(register unsigned int name,unsigned int scope,unsigned char kind)
{
    register unsigned int node;
    if(scope!=C_GLOBAL_SCOPE) {
        node=SCOPE_W(scope,SCOPE_C_SYMBOLS);
        while(node) {
            if(CSYM_W(node,CSYM_NAME)==name && CSYM_B(node,CSYM_NAMESPACE)==kind) {
                if(CSYM_B(node,CSYM_CLASS)==2) return CSYM_W(node,CSYM_TYPE);
                return node;
            }
            node=CSYM_W(node,CSYM_NEXT);
        }
    } else {
        node=NAME_W(name,NAME_SYMBOLS);
        while(node && CSYM_B(node,CSYM_NAMESPACE)!=kind) node=CSYM_W(node,CSYM_NEXT);
        if(node && (CSYM_W(node,CSYM_FLAGS)&0x200)) return node;
    }
    return 0;
}

/* DECLARE_SYMBOL: declares "name" (0 for an unnamed symbol) in "scope", name space
   "storage", class "kind", with "type", "value" (stored in CSYM_SEGMENT) and "flags".
   Returns the symbol, which may be an existing one: at file level a redeclaration is
   merged into the old symbol after checking the classes (MSG_MULTIPLE_DECLARATION) and
   the types (TYPE_RECORDS_COMPATIBLE, MSG_TYPE_MISMATCH), and MERGE_DECLARED_TYPES
   keeps the more complete of the two types. In a block an extern (kind 2) is entered as
   a global symbol plus a local class-2 cell; any other redeclaration in the same block
   is an error. New symbols get default use flags by class, probably so that kinds of
   symbol that cannot be "unused" never trigger the warnings below. */
/* ---- DECLARE_SYMBOL (listing 75CB) ---- */
static unsigned int near pascal DECLARE_GLOBAL_VARIABLE(register unsigned int name,unsigned int scope,unsigned char storage,unsigned int kind,unsigned int type,unsigned int value,unsigned int flags);
#include <dos.h>
extern unsigned int CODE_SEGMENT_ID; extern unsigned int DIAG_NAME_BUFFER;
extern int far pascal TYPE_RECORDS_COMPATIBLE(unsigned int,unsigned int,signed char);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
static void near pascal REPORT_MULTIPLE_DECLARATION(unsigned int);
static unsigned int near pascal MERGE_DECLARED_TYPES(unsigned int,unsigned int);
#define TB(n) (*(unsigned char far *)MK_FP(TYPE_POOL,(n)))
unsigned int far pascal DECLARE_SYMBOL(register unsigned int name,unsigned int scope,unsigned char storage,unsigned int kind,unsigned int type,unsigned int value,unsigned int flags)
{
    unsigned int cell;
    unsigned int isconst;
    register unsigned int node;
    isconst=flags&0x10;
    /* unnamed and not-found symbols share the creation code below */
    if(!name) goto create;
    /* file level: find an earlier symbol of the same name space (class 8 symbols only
       count if visible, flag 0x200) */
    if(scope==C_GLOBAL_SCOPE) {
        for(node=NAME_W(name,NAME_SYMBOLS);node;node=CSYM_W(node,CSYM_NEXT)) {
            if(CSYM_B(node,CSYM_NAMESPACE)==storage) {
                if(kind!=8) break;
                if(CSYM_W(node,CSYM_FLAGS)&0x200) break;
            }
        }
        if(!node) goto create;
        if((CSYM_W(node,CSYM_FLAGS)&0x20) && (flags&0x20)) {
            REPORT_MULTIPLE_DECLARATION(name);
            return node;
        }
        switch(kind) {
        case 2:
            if(CSYM_B(node,CSYM_CLASS)==10) {
                if(CSYM_W(node,CSYM_TYPE)==0) {
                    CSYM_W(node,CSYM_TYPE)=type;
                    return node;
                }
            } else if(CSYM_B(node,CSYM_CLASS)!=2 && CSYM_B(node,CSYM_CLASS)!=3 && CSYM_B(node,CSYM_CLASS)!=1)
                REPORT_MULTIPLE_DECLARATION(name);
            else if(isconst && CSYM_B(node,CSYM_CLASS)==2 && CSYM_W(node,CSYM_SEGMENT)!=0xffff) REPORT_MULTIPLE_DECLARATION(name);
            break;
        case 1:case 3:
            if(CSYM_B(node,CSYM_CLASS)!=2 && CSYM_B(node,CSYM_CLASS)!=1 && CSYM_B(node,CSYM_CLASS)!=3) REPORT_MULTIPLE_DECLARATION(name);
            else if(CSYM_B(node,CSYM_CLASS)!=3) {
                CSYM_B(node,CSYM_CLASS)=kind;
                CSYM_W(node,CSYM_FLAGS)|=0x40;
                if(kind==1) CSYM_W(node,CSYM_FLAGS)|=0x80;
            }
            if(flags&0x20) CSYM_W(node,CSYM_SEGMENT)=value;
            break;
        default:
            REPORT_MULTIPLE_DECLARATION(name);
        }
        CSYM_W(node,CSYM_FLAGS)|=0x200|flags;
        if(!TYPE_RECORDS_COMPATIBLE(CSYM_W(node,CSYM_TYPE),type,0)) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(name));
        } else CSYM_W(node,CSYM_TYPE)=MERGE_DECLARED_TYPES(type,CSYM_W(node,CSYM_TYPE));
        return node;
    }
    /* block level: look for the name in this scope only */
    for(node=SCOPE_W(scope,SCOPE_C_SYMBOLS);node;node=CSYM_W(node,CSYM_NEXT)) {
        if(CSYM_W(node,CSYM_NAME)==name && CSYM_B(node,CSYM_NAMESPACE)==storage) break;
    }
    if(kind==2) {
        if(node) {
            if(CSYM_B(node,CSYM_CLASS)!=2) REPORT_MULTIPLE_DECLARATION(name);
            node=CSYM_W(node,CSYM_TYPE);
            if(!TYPE_RECORDS_COMPATIBLE(CSYM_W(node,CSYM_TYPE),type,0)) {
                DIAG_NAME_BUFFER=0;
                REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(name));
            } else CSYM_W(node,CSYM_TYPE)=MERGE_DECLARED_TYPES(type,CSYM_W(node,CSYM_TYPE));
        } else {
            node=DECLARE_GLOBAL_VARIABLE(name,C_GLOBAL_SCOPE,storage,kind,type,value,flags);
            cell=POOL_ALLOC_REUSE(&CSYM_POOL_SEG,0x10);
            RTL_MEMSET(MK_FP(CSYM_POOL_SEG,cell),0,0x10);
            CSYM_W(cell,CSYM_TYPE)=node;
            CSYM_B(cell,CSYM_CLASS)=2;
            CSYM_W(cell,CSYM_NAME)=name;
            CSYM_W(cell,CSYM_FLAGS)=CSYM_W(node,CSYM_FLAGS);
            CSYM_W(cell,CSYM_NEXT)=SCOPE_W(scope,SCOPE_C_SYMBOLS);
            SCOPE_W(scope,SCOPE_C_SYMBOLS)=cell;
        }
        return node;
    }
    if(node) {
        REPORT_MULTIPLE_DECLARATION(name);
        return node;
    }
/* create a new symbol: at file level on the name's chain (or the unnamed list) ... */
create:
    if(scope==C_GLOBAL_SCOPE) {
        node=POOL_ALLOC_REUSE(&CSYM_POOL_SEG,0x10);
        RTL_MEMSET(MK_FP(CSYM_POOL_SEG,node),0,0x10);
        if(name) {
            CSYM_W(node,CSYM_NEXT)=NAME_W(name,NAME_SYMBOLS);
            NAME_W(name,NAME_SYMBOLS)=node;
        } else {
            CSYM_W(node,CSYM_NEXT)=C_UNNAMED_GLOBAL_LIST;
            C_UNNAMED_GLOBAL_LIST=node;
        }
        CSYM_B(node,CSYM_CLASS)=kind;
        CSYM_W(node,CSYM_TYPE)=type;
        CSYM_W(node,CSYM_NAME)=name;
        CSYM_B(node,CSYM_NAMESPACE)=storage;
        CSYM_W(node,CSYM_SEGMENT)=value;
        CSYM_W(node,CSYM_FLAGS)=0x200|flags;
        if(!isconst && TB(CSYM_W(node,CSYM_TYPE))==0x12) CSYM_W(node,CSYM_SEGMENT)=CODE_SEGMENT_ID;
        switch(kind) {
        case 3:
            CSYM_W(node,CSYM_FLAGS)|=0x40;
            break;
        case 7:case 10:
            CSYM_W(node,CSYM_FLAGS)|=0xc0;
            break;
        case 2:
            if(!isconst) break;
            CSYM_W(node,CSYM_SEGMENT)=0xffff;
            break;
        case 1:case 8:case 9:
            CSYM_W(node,CSYM_FLAGS)|=0xc0;
            break;
        }
        return node;
    }
    /* ... or at block level at the head of the scope's symbol list */
    node=POOL_ALLOC_REUSE(&CSYM_POOL_SEG,0x10);
    RTL_MEMSET(MK_FP(CSYM_POOL_SEG,node),0,0x10);
    CSYM_W(node,CSYM_NEXT)=SCOPE_W(scope,SCOPE_C_SYMBOLS);
    SCOPE_W(scope,SCOPE_C_SYMBOLS)=node;
    CSYM_B(node,CSYM_CLASS)=kind;
    CSYM_W(node,CSYM_TYPE)=type;
    CSYM_W(node,CSYM_NAME)=name;
    CSYM_W(node,CSYM_SEGMENT)=value;
    CSYM_W(node,CSYM_FLAGS)=flags;
    CSYM_B(node,CSYM_NAMESPACE)=storage;
    switch(kind) {
    case 8:case 9:
        CSYM_W(node,CSYM_FLAGS)|=0x80;
    case 4:
        CSYM_W(node,CSYM_FLAGS)|=0x40;
    }
    return node;
}
#undef TB

/* DECLARE_GLOBAL_VARIABLE: the file-level half of a block-level extern declaration:
   finds the global symbol of that name and name space (skipping class 8) and merges
   with it, or appends a new class-2 global symbol at the end of the name's chain. */
/* ---- DECLARE_GLOBAL_VARIABLE (listing 7A17) ---- */
#include <dos.h>
#define TB(n) (*(unsigned char far *)MK_FP(TYPE_POOL,(n)))
static unsigned int near pascal DECLARE_GLOBAL_VARIABLE(register unsigned int name,unsigned int scope,unsigned char storage,unsigned int kind,unsigned int type,unsigned int value,unsigned int flags)
{
    unsigned int prev;
    unsigned int isconst;
    register unsigned int node;
    isconst=flags&0x10;
    prev=0;
    for(node=NAME_W(name,NAME_SYMBOLS);node;node=CSYM_W(node,CSYM_NEXT)) {
        /* the label at the loop step makes BC20 reload ES there, as the original does */
        if(CSYM_B(node,CSYM_NAMESPACE)!=storage) goto next;
        if(CSYM_B(node,CSYM_CLASS)!=8) break;
    next:
        prev=node;
    }
    if(node) {
        if(CSYM_B(node,CSYM_CLASS)==10) {
            if(CSYM_W(node,CSYM_TYPE)==0) {
                CSYM_W(node,CSYM_TYPE)=type;
                return node;
            }
        } else if(CSYM_B(node,CSYM_CLASS)!=2 && CSYM_B(node,CSYM_CLASS)!=3 && CSYM_B(node,CSYM_CLASS)!=1)
            REPORT_MULTIPLE_DECLARATION(name);
        else if(isconst && CSYM_B(node,CSYM_CLASS)==2 && CSYM_W(node,CSYM_SEGMENT)!=0xffff)
            REPORT_MULTIPLE_DECLARATION(name);
        CSYM_W(node,CSYM_FLAGS)|=flags;
        if(!TYPE_RECORDS_COMPATIBLE(CSYM_W(node,CSYM_TYPE),type,0)) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(name));
        } else
            CSYM_W(node,CSYM_TYPE)=MERGE_DECLARED_TYPES(type,CSYM_W(node,CSYM_TYPE));
        return node;
    } else {
        node=POOL_ALLOC_REUSE(&CSYM_POOL_SEG,0x10);
        RTL_MEMSET(MK_FP(CSYM_POOL_SEG,node),0,0x10);
        if(prev==0) NAME_W(name,NAME_SYMBOLS)=node;
        else CSYM_W(prev,CSYM_NEXT)=node;
        CSYM_B(node,CSYM_CLASS)=2;
        CSYM_W(node,CSYM_TYPE)=type;
        CSYM_W(node,CSYM_NAME)=name;
        CSYM_B(node,CSYM_NAMESPACE)=storage;
        CSYM_W(node,CSYM_FLAGS)=flags;
        if(isconst) CSYM_W(node,CSYM_SEGMENT)=0xffff;
        else if(TB(CSYM_W(node,CSYM_TYPE))==0x12) CSYM_W(node,CSYM_SEGMENT)=CODE_SEGMENT_ID; else CSYM_W(node,CSYM_SEGMENT)=value;
    }
    return node;
}
#undef TB

/* REPORT_MULTIPLE_DECLARATION: reports MSG_MULTIPLE_DECLARATION for name. */
/* ---- STOVR22 (listing 7BAC) ---- */
static void near pascal REPORT_MULTIPLE_DECLARATION(unsigned int name)
{
    DIAG_NAME_BUFFER=0;
    REPORT_ERROR(MSG_MULTIPLE_DECLARATION,NAME_TEXT_COPY(name));
}

/* WARN_UNUSED_SYMBOLS: called when the scope cell "list" closes. For each named symbol:
   a struct/union tag (class 11) whose size is still 0 gets "undefined structure"
   (enum tags are skipped); local extern cells (class 2) are skipped; a symbol assigned
   but never used (flags 0x40 without 0x80) gets "parameter never used" for a parameter
   (class 6, unless #pragma argsused is pending) or "assigned a value that is never used"
   for anything outside the label name space; a symbol with neither flag gets "declared
   but never used". Struct Record mirrors CSYM: storage = CSYM_NAMESPACE, kind =
   CSYM_CLASS. R() reads through _ES and RR() through CSYM_POOL_SEG; the mix, and the
   record=record statements, are kept for byte matching. */
/* ---- STOVR23 (listing 7BD1) ---- */
#include <dos.h>
typedef unsigned int word;
extern char  PRAGMA_ARGSUSED_PENDING;
struct List { word head,next,owner,records; };
struct Record { word next,name; unsigned char storage,kind; word flags,type; };
struct Type { unsigned char kind,pad[2]; word flags; };
#define R(n) ((struct Record far *)MK_FP(_ES,n))
#define RR(n) ((struct Record far *)MK_FP(CSYM_POOL_SEG,n))
#define T(n) ((struct Type far *)MK_FP(TYPE_POOL,n))
void far pascal WARN_UNUSED_SYMBOLS(register word list)
{
 register word record;
 record=((struct List far *)MK_FP(SCOPE_POOL_SEG,list))->records;
 for(;record;record=RR(record)->next) {
  if(!RR(record)->name) continue;
  if(RR(record)->kind==11) {
   if(T(R(record)->type)->kind==21) continue;
   if(T(RR(record)->type)->flags) continue;
   DIAG_NAME_BUFFER=0;
   REPORT_WARNING(MSG_UNDEFINED_STRUCTURE_383,NAME_TEXT_COPY(RR(record)->name));
   continue;
  }
  {
   if(RR(record)->kind==2) continue;
   if(!R(record)->name) continue;
   if((R(record)->flags&0xc0)==0x40) {
    if(R(record)->kind==6) {
     _AX=(int)PRAGMA_ARGSUSED_PENDING;
     if(!_AX) {
     DIAG_NAME_BUFFER=0;
     REPORT_WARNING(MSG_PARAMETER_NEVER_USED,NAME_TEXT_COPY(R(record)->name));
     record=record;
     }

    } else if(RR(record)->storage!=1) {
     DIAG_NAME_BUFFER=0;
     REPORT_WARNING(MSG_ASSIGNED_VALUE_THAT,NAME_TEXT_COPY(R(record)->name));
     record=record;

    }
   } else if(!(RR(record)->flags&0xc0)) {
    DIAG_NAME_BUFFER=0;
    REPORT_WARNING(MSG_DECLARED_BUT_NEVER,NAME_TEXT_COPY(R(record)->name));
     record=record;

   }
  }
 }
}
#undef R
#undef RR
#undef T

/* MERGE_DECLARED_TYPES: of two compatible declarations of one symbol, picks the type to
   keep: for functions the one with a parameter list (or with a prototype), for arrays
   the one with a known size; otherwise first. */
/* ---- STOVR24 (listing 7D01) ---- */
#include <dos.h>
static unsigned int near pascal MERGE_DECLARED_TYPES(unsigned int first,unsigned int second)
{
    register unsigned int left=first,right=second;
    if(TYPE_B(left,TYPE_KIND)==TK_FUNCTION) {
        if(TYPE_W(left,TYPE_C_PARAMS)==0 && (TYPE_W(right,TYPE_C_PARAMS)!=0 || (TYPE_B(right,TYPE_C_FUNC_FLAGS)&8)==0))
            return right;
        else return left;
    } else {
        if(TYPE_B(left,TYPE_KIND)==TK_ARRAY) {
            if(TYPE_UL(left,TYPE_C_SIZE)==0L)
                return right;
            else return left;
        }
    }
    return left;
}

/* LOOKUP_MEMBER: finds the struct or union member "name". With a struct type, searches
   its member list (word +5, TYPE_C_MEMBERS, read here as TYPE_C_PARAMS). With type 0
   (the left operand of . or -> is not a struct, which old C allowed, and the inline
   assembler) it searches the members of every struct tag visible from scope input, then
   of all global tags; the search stops at the first member of the same name that has a
   different offset or type. Returns the member record (or 0). */
/* ---- STOVR25 (listing 7D55) ---- */
#include <dos.h>
static int near pascal FIND_MEMBER_IN_SCOPE(unsigned int,unsigned int,unsigned int far *);
unsigned int far pascal LOOKUP_MEMBER(unsigned int name,unsigned int input,unsigned int type)
{
    unsigned int found;
    register unsigned int node;
    register unsigned int scope;
    if(type) {
        node=TYPE_W(type,TYPE_C_MEMBERS);
        while(node) {
            if(MEMBER_W(node,MEMB_NAME)==name) break;
            node=MEMBER_W(node,MEMB_NEXT);
        }
        return node;
    }
    found=0;
    scope=input;
    while(scope) {
        if(!FIND_MEMBER_IN_SCOPE(scope,name,&found)) return found;
        scope=SCOPE_W(scope,SCOPE_C_PARENT);
    }
    if(!FIND_MEMBER_IN_SCOPE(C_GLOBAL_SCOPE,name,&found)) return found;
    return found;
}

/* FIND_MEMBER_IN_STRUCT: looks for "name" in the members of the tag symbol owner. The
   first match is stored in *found; returns 0 when a later match conflicts with it
   (different offset or type), else 1. */
/* ---- STOVR26 (listing 7DD3) ---- */
#include <dos.h>
static int near pascal FIND_MEMBER_IN_STRUCT(unsigned int owner,register unsigned int name,unsigned int far *found)
{
    register unsigned int node;
    node=TYPE_W(CSYM_W(owner,CSYM_TYPE),TYPE_C_PARAMS);
    while(node) {
        if(MEMBER_W(node,MEMB_NAME)==name) {
            if(*found==0) {*found=node;return 1;}
            if(MEMBER_W(*found,MEMB_C_OFFSET)!=MEMBER_W(node,MEMB_C_OFFSET) ||
               !TYPE_RECORDS_COMPATIBLE(MEMBER_W(*found,MEMB_C_TYPE),MEMBER_W(node,MEMB_C_TYPE),0)) return 0;
        }
        node=MEMBER_W(node,MEMB_NEXT);
    }
    return 1;
}

/* FIND_MEMBER_IN_SCOPE: runs FIND_MEMBER_IN_STRUCT over every tag (class 11) of one
   scope; for the global scope that means walking the whole name hash table and then the
   unnamed list. Returns 0 to stop the search (conflict), else 1. */
/* ---- STOVR27 (listing 7E54) ---- */
#include <dos.h>
extern unsigned int HASH_CHAIN_LINK_SEG;
extern unsigned int near  NAME_HASH_TABLE[];
static int near pascal FIND_MEMBER_IN_STRUCT(unsigned int,unsigned int,unsigned int far *);
static int near pascal FIND_MEMBER_IN_SCOPE(unsigned int scope,unsigned int name,unsigned int far *found)
{
    unsigned int current;
    int bucket;
    register unsigned int node;
    register unsigned int chain;
    if(scope==C_GLOBAL_SCOPE) {
        for(bucket=0;bucket<0x400;bucket++) {
            for(chain=NAME_HASH_TABLE[bucket];chain;chain=HLINK_W(chain,HLINK_NEXT)) {
                for(node=NAME_W(chain,NAME_SYMBOLS);node;node=CSYM_W(node,CSYM_NEXT)) {
                    if(CSYM_B(node,CSYM_CLASS)==11 && !FIND_MEMBER_IN_STRUCT(node,name,found)) return 0;
                }
            }
        }
        for(current=C_UNNAMED_GLOBAL_LIST;current;current=CSYM_W(current,CSYM_NEXT)) {
            if(CSYM_B(current,CSYM_CLASS)==11 && !FIND_MEMBER_IN_STRUCT(current,name,found)) return 0;
        }
    } else {
        for(current=SCOPE_W(scope,SCOPE_C_SYMBOLS);current;current=CSYM_W(current,CSYM_NEXT)) {
            if(CSYM_B(current,CSYM_CLASS)==11 && !FIND_MEMBER_IN_STRUCT(current,name,found)) return 0;
        }
    }
    return 1;
}

/* ADD_STRUCT_MEMBER: adds a member to a struct/union/enum member list
   (head; 0 for an empty list): name, offset or enumerator value ("flags" here, stored in
   MEMB_C_OFFSET), bit offset (first), bit width (second), type and the symbol flags byte
   (third). A duplicate name is reported and the old member returned; otherwise returns
   the (possibly new) list head. */
/* ---- STOVR28 (listing 7F55) ---- */
#include <dos.h>
unsigned int far pascal ADD_STRUCT_MEMBER(unsigned int name,unsigned int head,unsigned int type,unsigned int flags,unsigned char first,unsigned char second,unsigned char third)
{
    register unsigned int node=head;
    register unsigned int created;
    if(node) {
        for(;;) {
            if(MEMBER_W(node,MEMB_NAME)==name) {REPORT_MULTIPLE_DECLARATION(name);return node;}
            if(MEMBER_W(node,MEMB_NEXT)==0) break;
            node=MEMBER_W(node,MEMB_NEXT);
        }
    }
    created=POOL_ALLOC_REUSE(&MEMBER_SEGMENT,11);
    if(node) MEMBER_W(node,MEMB_NEXT)=created;
    else head=created;
    MEMBER_W(created,MEMB_NEXT)=0;
    MEMBER_W(created,MEMB_NAME)=name;
    MEMBER_W(created,MEMB_C_OFFSET)=flags;
    MEMBER_B(created,MEMB_C_BIT_OFFSET)=first;
    MEMBER_B(created,MEMB_C_BIT_WIDTH)=second;
    MEMBER_W(created,MEMB_C_TYPE)=type;
    MEMBER_B(created,MEMB_C_FLAGS)=third;
    return head;
}

/* BUILD_SYMBOL_OPERAND: builds the expression leaf for identifier "name" through the
   back-end node hooks. Class 7 gives a node with the symbol's offset; class 10 (an
   intrinsic, fatal if it has no type yet) and classes 1-4 give an ordinary symbol node;
   5 and 6 (probably locals and parameters) a different node mode; 9 (an enumerator) an
   int constant of its value. Anything else (a typedef name) is an error that returns an
   empty node. Returns 0 when the name is not declared. */
/* ---- STOVR29 (listing 7FE7) ---- */
#include <dos.h>
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern unsigned int (far pascal *NEW_SYMBOL_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int,long);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
unsigned int far pascal BUILD_SYMBOL_OPERAND(unsigned int name,unsigned int scope,unsigned char kind)
{
    unsigned int type;
    register unsigned int node;
    register unsigned int result;
    node=LOOKUP_SYMBOL(name,scope,kind);
    if(node==0) return 0;
    type=CSYM_W(node,CSYM_TYPE);
    switch(CSYM_B(node,CSYM_CLASS)) {
    case 7:result=NEW_SYMBOL_NODE_HOOK(4,type,node,CSYM_W(node,CSYM_OFFSET),CSYM_W(node,CSYM_FLAGS));break;
    case 10:
        if(CSYM_W(node,CSYM_TYPE)==0) REPORT_FATAL(MSG_BAD_CALL_INTRINSIC);
        case 1:case 2:case 3:case 4:result=NEW_SYMBOL_NODE_HOOK(1,type,node,0,CSYM_W(node,CSYM_FLAGS));break;
    case 5:case 6:result=NEW_SYMBOL_NODE_HOOK(5,type,node,0,CSYM_W(node,CSYM_FLAGS));break;
    case 9:result=NEW_CONST_NODE_HOOK(MODE_HOOK(5),(long)(int)CSYM_W(node,CSYM_OFFSET));break;
    default:
        REPORT_ERROR(MSG_IMPROPER_USE_TYPEDEF);
        return NEW_EXPR_NODE_HOOK(0,0,0,0);
    }
    return result;
}

/* DECLARE_NAMED_GLOBAL: declares (or marks as used) an extern the compiler itself needs,
   given by its text, such as a run-time helper. _stklen (STR_STKLEN) gets the type
   MODE_HOOK(6) (probably unsigned int), every other name the helper function type
   C_HELPER_FUNC_TYPE. Flag 0x10 is added when helpers are called far, 0x400 when extra
   is nonzero. */
/* ---- DECLARE_NAMED_GLOBAL (listing 80E4) ---- */
#include <dos.h>
extern signed char  NEAR_HELPER_CALLS;
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
unsigned int far pascal DECLARE_NAMED_GLOBAL(char *text,int extra)
{
    unsigned int name;
    unsigned int type;
    register unsigned int node;
    register unsigned int flags;
    name=BCC_SYMBOL_CREATE(text,0);
    node=LOOKUP_SYMBOL(name,C_GLOBAL_SCOPE,0);
    if(node) {
        CSYM_W(node,CSYM_FLAGS)|=0x80;
    } else {
        flags=0x80;
        if(!NEAR_HELPER_CALLS) flags|=0x10;
        if(extra) flags|=0x400;
        type=COMPARE_NAME(text,STR_STKLEN) ? C_HELPER_FUNC_TYPE : MODE_HOOK(6);
        node=DECLARE_SYMBOL(name,C_GLOBAL_SCOPE,0,2,type,0,flags);
    }
    return node;
}

/* DECLARE_UNNAMED_SYMBOL: declares an unnamed class-5 symbol of the given type in the
   current declaration scope, probably a compiler temporary. */
/* ---- DECLARE_UNNAMED_SYMBOL (listing 817B) ---- */
unsigned int far pascal DECLARE_UNNAMED_SYMBOL(unsigned int type)
{
    return DECLARE_SYMBOL(0,C_DECL_SCOPE,0,5,type,0,0);
}

/* WARN_USE_BEFORE_ASSIGN: warns "possible use of name before definition" for symbol
   node. */
/* ---- STOVR33 (listing 819B) ---- */
#include <dos.h>
void far pascal WARN_USE_BEFORE_ASSIGN(register unsigned int node)
{
    DIAG_NAME_BUFFER=0;
    REPORT_WARNING(MSG_POSSIBLE_USE_BEFORE,NAME_TEXT_COPY(*(unsigned int far *)MK_FP(CSYM_POOL_SEG,node+CSYM_NAME)));
}

/* SYMBOL_ELEMENT_KIND: type kind of the symbol, looking through arrays to the element. */
/* ---- STOVR34 (listing 81C8) ---- */
#include <dos.h>
unsigned char far pascal SYMBOL_ELEMENT_KIND(register unsigned int input)
{
    register unsigned int node;
    node=*(unsigned int far *)MK_FP(CSYM_POOL_SEG,input+CSYM_TYPE);
    while(TYPE_B(node,TYPE_KIND)==TK_ARRAY) node=TYPE_W(node,TYPE_TARGET);
    return TYPE_B(node,TYPE_KIND);
}

/* The functions from here on are one-line accessors of C symbol fields, used by the back
   end (probably through the hook table): SET_SYMBOL_FLAG_20 sets flag 0x20 (probably
   "has a definition"); *_WORD_10 read and write CSYM_VAR_ENTRY (offset 10 decimal);
   SET_SYMBOL_SEGMENT_FLAGGED puts a symbol in a register (flag 0x1000). */
/* ---- STOVR35 (listing 81F5) ---- */
#include <dos.h>
void far pascal SET_SYMBOL_FLAG_20(register unsigned int node)
{
    CSYM_W(node,CSYM_FLAGS)|=0x20;
}

/* ---- STOVR36 (listing 820B) ---- */
#include <dos.h>
unsigned int far pascal GET_SYMBOL_OFFSET(register unsigned int node)
{
    return *(unsigned int far *)MK_FP(CSYM_POOL_SEG,node+CSYM_OFFSET);
}

/* ---- STOVR37 (listing 821F) ---- */
#include <dos.h>
unsigned int far pascal GET_SYMBOL_SEGMENT(register unsigned int node)
{
    return *(unsigned int far *)MK_FP(CSYM_POOL_SEG,node+CSYM_SEGMENT);
}

/* ---- STOVR38 (listing 8233) ---- */
#include <dos.h>
void far pascal SET_SYMBOL_OFFSET(register unsigned int node,unsigned int value)
{
    CSYM_W(node,CSYM_OFFSET)=value;
}

/* ---- STOVR39 (listing 824A) ---- */
#include <dos.h>
void far pascal SET_SYMBOL_SEGMENT(register unsigned int node,unsigned int value)
{
    CSYM_W(node,CSYM_SEGMENT)=value;
}

/* ---- STOVR40 (listing 8261) ---- */
#include <dos.h>
void far pascal SET_SYMBOL_WORD_10(register unsigned int node,unsigned int value)
{
    CSYM_W(node,CSYM_VAR_ENTRY)=value;
}

/* ---- STOVR41 (listing 8278) ---- */
#include <dos.h>
unsigned int far pascal GET_SYMBOL_KIND(register unsigned int node)
{
    return *(unsigned char far *)MK_FP(CSYM_POOL_SEG,node+CSYM_CLASS);
}

/* ---- STOVR42 (listing 828E) ---- */
#include <dos.h>
unsigned int far pascal GET_SYMBOL_TYPE(register unsigned int node)
{
    return *(unsigned int far *)MK_FP(CSYM_POOL_SEG,node+CSYM_TYPE);
}

/* ---- STOVR43 (listing 82A2) ---- */
#include <dos.h>
unsigned int far pascal GET_SYMBOL_WORD_10(register unsigned int node)
{
    return *(unsigned int far *)MK_FP(CSYM_POOL_SEG,node+CSYM_VAR_ENTRY);
}

/* ---- STOVR44 (listing 82B6) ---- */
#include <dos.h>
void far pascal SET_SYMBOL_SEGMENT_FLAGGED(register unsigned int node,unsigned int value)
{
    CSYM_W(node,CSYM_SEGMENT)=value;
    CSYM_W(node,CSYM_FLAGS)|=0x1000;
}

/* ---- STOVR45 (listing 82D3) ---- */
unsigned int far pascal GET_STRING_LITERAL_SYMBOL(void)
{
    return C_STRING_LITERAL_SYMBOL;
}

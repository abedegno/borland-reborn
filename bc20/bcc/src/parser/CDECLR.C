/* target: ovr134_C125UNIT */
/* Role: parser (C mode): declarators: parameter and abstract declarators, declarator trees,
   parameter lists, binding a declarator to its type, building function types. Entry points:
   BCC_STMT_DECL_NEW, PARSE_PARAM_DECLARATOR, PARSE_ABSTRACT_DECLARATOR, BCC_STMT_BEGIN,
   PARSE_PARAMETER_LIST, BCC_STMT_BIND_TYPE, IS_BARE_DECLARATOR, BUILD_FUNCTION_TYPE. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Original CO04D (ovr_1d1a_9aac) 0000..0C79 as one source; PTRMOD (0C79..) is a separate file. */
/* opts: -mm -G -O -Z -p -Y -y -k- */
/* Overview: declarators in the C front end (COMPILE_C_SOURCE).  A
   declarator is parsed in two steps.  PARSE_DECLARATOR_TREE reads it into
   a small tree of temporary DCLR nodes in DECLARATOR_NODE_POOL_SEG (kind 0
   the name, 0x0D pointer, 0x11 array, 0x12 function), the outermost
   operator at the root, recording the modifiers found next to each part
   (near, far, huge, _cs ... _seg, cdecl, pascal, interrupt, _loadds,
   _saveregs, _export, from BCC_STMT_BEGIN).  BCC_STMT_BIND_TYPE then walks
   the tree from the root, applying each operator to the base type from
   the declaration specifiers ("int *a[3]": array of 3, of pointer, to int)
   and frees the nodes.  The three entry points differ in the name rule:
   BCC_STMT_DECL_NEW needs a name (level 1), PARSE_PARAM_DECLARATOR allows
   none (level 0), PARSE_ABSTRACT_DECLARATOR forbids one (level -1, type
   names in casts and sizeof).  The declared name is left in
   DECLARATOR_NAME with its line and file.
   Tokens come from the lexer through NEXT() as in STMTC.C.  The C storage
   classes used here: 6 parameter, 13 register (C_DECL_STORAGE_CLASS, set
   by the specifier parser in CDECL.C). */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- STOVR83 (listing AAC0) ---- */
static unsigned int near pascal PARSE_DECLARATOR_TREE(unsigned int input,int level);
/* Parses a declarator that must have a name and returns its DCLR tree (0
   after an error).  input is passed on as permission for an old-style
   identifier list "f(a, b)" (nonzero at file level, probably).  Copies the
   name and its position to C_DECLARATOR_NAME and C_DECL_SOURCE_*. */
unsigned int far pascal BCC_STMT_DECL_NEW(unsigned int input)
{
    register unsigned int result=PARSE_DECLARATOR_TREE(input,1);
    if(!result) return 0;
    C_DECLARATOR_NAME=DECLARATOR_NAME;
    C_DECL_SOURCE_LINE=DECLARATOR_NAME_LINE;
    C_DECL_SOURCE_FILE=DECLARATOR_NAME_FILE;
    return result;
}

/* ---- STOVR84 (listing AAF1) ---- */
static unsigned int near pascal PARSE_DECLARATOR_TREE(unsigned int input,int level);
#include <dos.h>
/* Parses a parameter's declarator (name optional, left in PARAM_NAME). */
unsigned int far pascal PARSE_PARAM_DECLARATOR(void)
{
    register unsigned int result=PARSE_DECLARATOR_TREE(0,0);
    if(result==0) return 0;
    PARAM_NAME=DECLARATOR_NAME;
    return result;
}

/* ---- STOVR85 (listing AB11) ---- */
static unsigned int near pascal PARSE_DECLARATOR_TREE(unsigned int input,int level);
#include <dos.h>
/* Parses an abstract declarator (no name), for type names. */
unsigned int far pascal PARSE_ABSTRACT_DECLARATOR(void)
{
    return PARSE_DECLARATOR_TREE(0,-1);
}

/* ---- STOVR86 (listing AB20) ---- */
struct Flags { signed char first,second,third; };
extern unsigned int TOKEN_TYPE;
extern unsigned char  TOKEN_PUSHED_BACK;
extern void far cdecl REPORT_ERROR(unsigned int,...);
extern unsigned int far pascal LEX_NEXT_TOKEN(void);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Reads any run of modifier keywords, adding them to flags, which is
   returned.  first is the calling convention (cdecl 1, pascal 2, 0x49 3,
   interrupt 4), second the distance or segment (_es 1, _cs 2, _ss 3, _ds
   4, _seg 7, near 8, far 9, huge 10), third a mask (_loadds 2, _saveregs
   0x10, _export 0x80).  Repeats and contradictions are "conflicting type
   modifiers" errors. */
struct Flags far pascal BCC_STMT_BEGIN(struct Flags flags)
{
    int second,first,mask;
    for(;;) {
        mask=first=second=0;
        switch(TOKEN_TYPE) {
        case 0x48:first=1;break;
        case 0x47:first=2;break;
        case 0x46:first=4;break;
        case 0x49:first=3;break;
        case 0x4C:mask=2;break;
        case 0x4E:mask=0x80;break;
        case 0x4D:mask=0x10;break;
        case 0x51:second=2;break;
        case 0x52:second=4;break;
        case 0x53:second=1;break;
        case 0x54:second=3;break;
        case 0x55:second=7;break;
        case 0x4F:second=8;break;
        case 0x50:second=9;break;
        case 0x56:second=10;break;
        default:
            if(flags.first!=0 && flags.second<=3 && flags.second>=2) {
                flags.second=0;REPORT_ERROR(MSG_CONFLICTING_TYPE);
            }
            return flags;
        }
        if(mask&flags.third) REPORT_ERROR(MSG_CONFLICTING_TYPE);
        flags.third|=mask;
        if(first!=0) {
            if(flags.first!=0) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags.first=first;
        }
        if(second!=0) {
            if(flags.second!=0) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags.second=second;
        }
        if(flags.second==8 && flags.first==4) {
            REPORT_ERROR(MSG_CONFLICTING_TYPE);flags.second=0;
        }
        NEXT();
        LOGICAL_LINE=CURRENT_LINE;
    }
}
#undef NEXT

/* ---- PARSE_DECLARATOR_TREE (listing ACA2) ---- */
#include <dos.h>

extern long  TOKEN_CONST_VALUE;
extern unsigned char PARAM_LIST_KIND;
extern struct Flags  C_DECL_MODIFIERS;
extern void far cdecl REPORT_FATAL(unsigned int);
extern void far cdecl REPORT_AND_SKIP(unsigned int,...);
extern unsigned int far pascal FLUSH_PENDING_POOL(void);
extern unsigned int far pascal PARSE_CONSTANT_EXPR(unsigned int);
extern struct Flags far pascal BCC_STMT_BEGIN(struct Flags);
extern unsigned int far pascal PARSE_PARAMETER_LIST(unsigned int);
static unsigned int near pascal PARSE_CV_QUALIFIERS(void);
static unsigned int near pascal NEW_DECLARATOR_NODE(unsigned int,long,unsigned int,unsigned int,unsigned char,struct Flags);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses one declarator into a DCLR tree, recursively for '*' and
   parentheses, then any number of () and [] suffixes; level is the name
   rule (see the file overview).  A pointer may be followed by const or
   volatile and by a string literal naming its base (kept in POOL_HASH by
   FLUSH_PENDING_POOL).  Array sizes must be positive constants.  The test
   of _SP stops runaway recursion with a fatal "out of memory". */
static unsigned int near pascal PARSE_DECLARATOR_TREE(unsigned int input,int level)
{
    int flags,array;
    struct Flags local;
    unsigned int second;
    unsigned int node;
    if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    local=BCC_STMT_BEGIN(C_DECL_MODIFIERS);
    C_DECL_MODIFIERS.second=0;C_DECL_MODIFIERS.first=0;C_DECL_MODIFIERS.third=0;
    if(TOKEN_TYPE==0x18) {
        NEXT();
        flags=PARSE_CV_QUALIFIERS();
        if(TOKEN_TYPE==0x34) {
            second=FLUSH_PENDING_POOL();
            NEXT();
        } else second=0;
        node=PARSE_DECLARATOR_TREE(input,level);
        if(!node) return 0;
        return NEW_DECLARATOR_NODE(0xD,0L,node,second,flags,local);
    }
    DECLARATOR_NAME=0;
    if(TOKEN_TYPE==1) {
        NEXT();
        if(TOKEN_TYPE!=2) {
            node=PARSE_DECLARATOR_TREE(input,level);
            if(!node) return 0;
        } else if(level<=0) {
            node=NEW_DECLARATOR_NODE(0x12,0L,0,0,0,local);
            local.first=0;local.second=0;
        } else {
            REPORT_AND_SKIP(MSG_NEED_IDENTIFIER,0L);
            return 0;
        }
        NEXT();
    } else {
        if(TOKEN_TYPE==0x31 && level>=0) {
            DECLARATOR_NAME=(unsigned int)TOKEN_CONST_VALUE;
            DECLARATOR_NAME_LINE=TOKEN_LINE;
            DECLARATOR_NAME_FILE=TOKEN_FILE_NODE;
            NEXT();
        } else if(level>0) {
            REPORT_AND_SKIP(MSG_NEED_IDENTIFIER,0L);
            return 0;
        }
        node=NEW_DECLARATOR_NODE(0,0L,0,0,0,local);
    }
    LOGICAL_LINE=CURRENT_LINE;
    if(TOKEN_TYPE!=1 && TOKEN_TYPE!=3 && local.second!=0 && local.second!=8 && local.second!=10 && local.second!=9)
        REPORT_ERROR(MSG_CONFLICTING_TYPE);
    array=0;
    while(TOKEN_TYPE==1 || TOKEN_TYPE==3) {
        if(TOKEN_TYPE!=3) {
            unsigned int size,scope,line,params;
            NEXT();
            size=DECLARATOR_NAME;scope=DECLARATOR_NAME_LINE;line=DECLARATOR_NAME_FILE;
            params=PARSE_PARAMETER_LIST(input);
            DECLARATOR_NAME=size;DECLARATOR_NAME_LINE=scope;DECLARATOR_NAME_FILE=line;
            if(PARAM_LIST_KIND==0) return 0;
            flags=0;
            if(PARAM_LIST_KIND==2) {
                input=0;params=0;flags=8;
            } else if(PARAM_LIST_KIND==3) {
                if(local.first!=1 && local.first!=0) REPORT_ERROR(MSG_CONFLICTING_TYPE);
                flags=4;
            }
            node=NEW_DECLARATOR_NODE(0x12,0L,node,params,flags,local);
        } else {
            unsigned int size;
            if(local.second==10) {
                local.second=9;array=1;
            } else if(local.second!=0 && local.second!=8 && local.second!=9) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            NEXT();
            if(TOKEN_TYPE!=4) {
                size=DECLARATOR_NAME;
                if(!PARSE_CONSTANT_EXPR(1)) return 0;
                DECLARATOR_NAME=size;
                if(TOKEN_CONST_VALUE<=0) {
                    REPORT_ERROR(MSG_ARRAY_MUST_HAVE_LEAST);
                    TOKEN_CONST_VALUE=1;
                }
                node=NEW_DECLARATOR_NODE(0x11,TOKEN_CONST_VALUE,node,0,array,local);
                TOKEN_PUSHED_BACK=1;
            } else node=NEW_DECLARATOR_NODE(0x11,0L,node,0,array,local);
        }
        NEXT();
        LOGICAL_LINE=CURRENT_LINE;
    }
    return node;
}
#undef NEXT

/* ---- STOVR88 (listing B0A6) ---- */
#include <dos.h>
extern unsigned int C_DECL_SYMBOL_FLAGS; extern unsigned int C_DECL_STORAGE_CLASS;
extern unsigned char  LANGUAGE_MODE;
extern unsigned int far pascal CREATE_SCOPE(unsigned int);
extern int far pascal TOKEN_STARTS_TYPE(unsigned int);
extern unsigned int far pascal BCC_STMT_BUILD(void);
extern void far pascal BCC_STMT_FUNCTION_NEAR(void);
extern unsigned int far pascal BCC_STMT_ADD_FIELD(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal PARSE_PARAM_DECLARATOR(void);
extern unsigned int far pascal BCC_STMT_BIND_TYPE(unsigned int input,unsigned int type);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
#define RESTORE_SCOPE() if(LANGUAGE_MODE==1) {C_DECL_SCOPE=oldscope;PARAM_SCOPE_MARK_AUX=0;PARAM_SCOPE_MARK=newscope;}
/* Parses what follows '(' in a function declarator, up to ')'.  Returns
   the parameter list (C_PARAM_POOL_SEG records) or 0, and sets
   PARAM_LIST_KIND: 0 error, 1 prototype, 2 no prototype ("()" or an
   old-style identifier list, kept in C_OLD_STYLE_PARAM_LIST; allowed only
   when input is nonzero), 3 prototype ending in "...".  A list that is
   just "void" becomes empty.  In strict ANSI mode the parameters get their
   own scope while being parsed. */
unsigned int far pascal PARSE_PARAMETER_LIST(unsigned int input)
{
    unsigned int decl,saved,newscope,oldscope;
    register unsigned int list;
    register unsigned int type;
    saved=C_DECL_SYMBOL_FLAGS;
    if(TOKEN_TYPE==2) goto empty;
    if(TOKEN_STARTS_TYPE(TOKEN_TYPE)) {
        if(LANGUAGE_MODE==1) {oldscope=C_DECL_SCOPE;newscope=CREATE_SCOPE(C_DECL_SCOPE);C_DECL_SCOPE=newscope;}
        list=0;
        for(;;) {
            type=BCC_STMT_BUILD();
            if(!type) {RESTORE_SCOPE();PARAM_LIST_KIND=0;return 0;}
            if(C_DECL_STORAGE_CLASS==0) C_DECL_STORAGE_CLASS=6;
            else if(C_DECL_STORAGE_CLASS!=13) {
                REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258,(char far *)STORAGE_CLASS_NAMES[C_DECL_STORAGE_CLASS]);
                C_DECL_STORAGE_CLASS=6;
            }
            if(TOKEN_TYPE!=8 && TOKEN_TYPE!=2) {
                decl=PARSE_PARAM_DECLARATOR();
                if(decl==0) {C_DECL_SYMBOL_FLAGS=saved;RESTORE_SCOPE();PARAM_LIST_KIND=0;return 0;}
                type=BCC_STMT_BIND_TYPE(decl,type);
            } else PARAM_NAME=0;
            C_DECL_SYMBOL_FLAGS=saved;
            list=BCC_STMT_ADD_FIELD(list,PARAM_NAME,type,C_DECL_STORAGE_CLASS);
            if(TOKEN_TYPE!=8) {PARAM_LIST_KIND=1;break;}
            NEXT();
            if(TOKEN_TYPE==9) {NEXT();PARAM_LIST_KIND=3;break;}
            if(TOKEN_STARTS_TYPE(TOKEN_TYPE)) continue;
            REPORT_AND_SKIP(TOKEN_TYPE==2?MSG_DECLARATION_WAS:MSG_EXPECTED_233,0L);
            RESTORE_SCOPE();PARAM_LIST_KIND=0;return 0;
        }
        RESTORE_SCOPE();
        if(TOKEN_TYPE!=2) {REPORT_AND_SKIP(MSG_EXPECTED_233,0L);PARAM_LIST_KIND=0;return 0;}
        if(list && TYPE_B(CPARM_W(list,CPARM_TYPE),TYPE_KIND)==12 && CPARM_W(list,CPARM_NEXT)==0 && CPARM_W(list,CPARM_NAME)==0) list=0;
        return list;
    }
    if(!input) {REPORT_AND_SKIP(MSG_PARAMETER_NAMES_ARE,0L);PARAM_LIST_KIND=0;return 0;}
    newscope=C_DECL_SCOPE;
    BCC_STMT_FUNCTION_NEAR();
    list=0;
    for(;;) {
        if(TOKEN_TYPE!=0x31) {REPORT_AND_SKIP(MSG_EXPECTED_233,0L);C_DECL_SCOPE=newscope;PARAM_LIST_KIND=0;return 0;}
        list=BCC_STMT_ADD_FIELD(list,(unsigned int)TOKEN_CONST_VALUE,0,0);
        NEXT();
        if(TOKEN_TYPE==2) break;
        if(TOKEN_TYPE!=8) {REPORT_AND_SKIP(MSG_EXPECTED_202,0L);C_DECL_SCOPE=newscope;PARAM_LIST_KIND=0;return 0;}
        NEXT();
    }
    C_OLD_STYLE_PARAM_LIST=list;
empty:
    PARAM_LIST_KIND=2;
    return 0;
}
#undef NEXT
#undef RESTORE_SCOPE

/* ---- STOVR89 (listing B384) ---- */
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Reads const (1) and volatile (2) after a '*' and returns the flags. */
static unsigned int near pascal PARSE_CV_QUALIFIERS(void)
{
    register unsigned int flags=0;
    for(;;) {
        switch(TOKEN_TYPE) {
        case 0x4A:
            if(flags&1) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags|=1;
            break;
        case 0x4B:
            if(flags&2) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            flags|=2;
            break;
        default:return flags;
        }
        NEXT();
    }
}
#undef NEXT

/* ---- STOVR90 (listing B3E2) ---- */
#include <dos.h>

extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
/* Allocates a 13-byte DCLR node: kind, array size value, inner node
   first, parameter list or pointer base second, flags (cv-qualifiers,
   function flags, or the huge-array mark) and the modifiers local. */
static unsigned int near pascal NEW_DECLARATOR_NODE(unsigned int kind,long value,unsigned int first,unsigned int second,unsigned char flags,struct Flags local)
{
    register unsigned int node=POOL_ALLOC_REUSE(&DECLARATOR_NODE_POOL_SEG,13);
    DCLR_B(node,DCLR_KIND)=kind;
    DCLR_W(node,DCLR_PARAMS)=second;
    *(long far *)MK_FP(DECLARATOR_NODE_POOL_SEG,node+DCLR_ARRAY_SIZE)=value;
    DCLR_B(node,DCLR_FLAGS)=flags;
    DCLR_W(node,DCLR_CHILD)=first;
    *(struct Flags far *)MK_FP(DECLARATOR_NODE_POOL_SEG,node+DCLR_CALL_CONV)=local;
    return node;
}

/* ---- STOVR91 (listing B443) ---- */
#include <dos.h>
static void near pascal REPORT_TYPE_NOT_ALLOWED(void);
extern unsigned int far pascal BUILD_FUNCTION_TYPE(register unsigned int node,unsigned int value,unsigned char mode,signed char flags);
extern unsigned int far pascal BUILD_POINTER_TYPE(unsigned int,signed char,unsigned int,signed char);
extern unsigned int far pascal NEW_ARRAY_TYPE(long,unsigned int,unsigned int);
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);
/* Applies the DCLR tree input to the base type and returns the resulting
   type, freeing the nodes.  Modifiers written before a function's name
   ("int far f()") are moved from the inner node to the function.  The
   name node's modifiers are left in C_DECL_CALL_CONVENTION and
   C_DECL_DISTANCE for the declared object.  C_DECL_SYMBOL_FLAGS carries
   cv-qualifiers from one pointer level to the type built at the next. */
unsigned int far pascal BCC_STMT_BIND_TYPE(unsigned int input,unsigned int type)
{
    int second,flags,first,saved;
    register unsigned int node=input;
    register unsigned int child;
    C_DECL_CALL_CONVENTION=0;C_DECL_DISTANCE=0;
    while(node) {
        child=DCLR_W(node,DCLR_CHILD);
        if(DCLR_SC(node,DCLR_KIND)==17) {
            if(TYPE_B(type,TYPE_KIND)==TK_FUNCTION || TYPE_B(type,TYPE_KIND)==TK_VOID) REPORT_TYPE_NOT_ALLOWED();
            if(TYPE_B(type,TYPE_KIND)==TK_ARRAY && TYPE_B(type,TYPE_C_BYTE9)!=0) DCLR_SC(node,DCLR_FLAGS)=1;
            type=NEW_ARRAY_TYPE(DCLR_L(node,DCLR_ARRAY_SIZE),type,DCLR_SC(node,DCLR_FLAGS));
        } else if(DCLR_SC(node,DCLR_KIND)==18) {
            second=DCLR_SC(node,DCLR_DISTANCE);first=DCLR_SC(node,DCLR_CALL_CONV);
            if(child) {
                if(second==0) second=DCLR_SC(child,DCLR_DISTANCE);
                if(DCLR_SC(node,DCLR_EXTRA_MODS)==0) {DCLR_SC(node,DCLR_EXTRA_MODS)=DCLR_SC(child,DCLR_EXTRA_MODS);DCLR_SC(child,DCLR_EXTRA_MODS)=0;}
                if(DCLR_SC(child,DCLR_KIND)==13) {
                    if(DCLR_SC(child,DCLR_DISTANCE)==0) DCLR_SC(child,DCLR_DISTANCE)=second;
                } else {
                    if(DCLR_SC(child,DCLR_DISTANCE)!=second) REPORT_ERROR(MSG_CONFLICTING_TYPE);
                    DCLR_SC(child,DCLR_DISTANCE)=0;
                }
                if(first==0) first=DCLR_SC(child,DCLR_CALL_CONV);
                DCLR_SC(child,DCLR_CALL_CONV)=0;
            }
            flags=(signed char)(DCLR_SC(node,DCLR_FLAGS)|DCLR_SC(node,DCLR_EXTRA_MODS));
            switch(second) {
            case 8:flags|=0x40;break;
            case 9:flags|=1;break;
            case 10:flags|=3;break;
            }
            type=BUILD_FUNCTION_TYPE(type,DCLR_W(node,DCLR_PARAMS),(unsigned char)first,(signed char)flags);
            C_DECL_SYMBOL_FLAGS=0;
        } else if(DCLR_SC(node,DCLR_KIND)==13) {
            if(child && DCLR_SC(child,DCLR_KIND)==0 && DCLR_SC(child,DCLR_CALL_CONV)==0) {
                DCLR_SC(child,DCLR_CALL_CONV)=DCLR_SC(node,DCLR_CALL_CONV);DCLR_SC(node,DCLR_CALL_CONV)=0;
            }
            if(DCLR_SC(node,DCLR_CALL_CONV)!=0 || DCLR_SC(node,DCLR_EXTRA_MODS)!=0) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            second=DCLR_SC(node,DCLR_FLAGS);
            saved=C_DECL_SYMBOL_FLAGS;
            type=BUILD_POINTER_TYPE(type,(signed char)saved,DCLR_W(node,DCLR_PTR_BASE),(signed char)DCLR_SC(node,DCLR_DISTANCE));
            C_DECL_SYMBOL_FLAGS=second;
        } else {
            C_DECL_CALL_CONVENTION=DCLR_SC(node,DCLR_CALL_CONV);
            if(DCLR_SC(node,DCLR_DISTANCE)==9 || DCLR_SC(node,DCLR_DISTANCE)==10) C_DECL_DISTANCE=9;
            else if(DCLR_SC(node,DCLR_DISTANCE)==8) C_DECL_DISTANCE=8;
        }
        POOL_FREE_ITEM(&DECLARATOR_NODE_POOL_SEG,node);
        node=child;
    }
    return type;
}

/* ---- STOVR92 (listing B680) ---- */
/* Reports "not an allowed type" (an array of functions, a function
   returning an array, and so on). */
static void near pascal REPORT_TYPE_NOT_ALLOWED(void)
{
    REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
}

/* ---- STOVR93 (listing B68C) ---- */
#include <dos.h>
/* Nonzero if the DCLR tree is just a name (kind 0). */
int far pascal IS_BARE_DECLARATOR(register unsigned int node)
{
    return *(unsigned char far *)MK_FP(DECLARATOR_NODE_POOL_SEG,node)==0;
}

/* ---- STOVR94 (listing B6A9) ---- */
#include <dos.h>
extern signed char  OPTION_CALLING_CONVENTION;
extern unsigned char  OPTION_MEMORY_MODEL,MODEL_FAR_CODE;
/* The original call promotes signed flags to a word; the callee stores its low byte. */
extern unsigned int far pascal NEW_FUNCTION_TYPE(unsigned int,unsigned int,unsigned char,int);
/* Builds the type "function returning node" with parameter list value.
   mode is the calling convention (0 means the default from the -p option,
   OPTION_CALLING_CONVENTION); an interrupt function (4) is always far
   (flags 3).  Without an explicit distance (flags 0x40 near, 1 far, 3
   huge) the memory model decides.  A function may not return an array or
   a function. */
unsigned int far pascal BUILD_FUNCTION_TYPE(register unsigned int node,unsigned int value,unsigned char mode,signed char flags)
{
    if(mode==4) flags|=3;
    else {
        if(mode==0) {
            switch(OPTION_CALLING_CONVENTION) {
            case 0:mode=1;break;
            case 1:mode=2;break;
            case 2:mode=3;break;
            }
        }
        if((unsigned char)(flags&0x43)==0) {
            if(OPTION_MEMORY_MODEL==5) flags|=3;
            else if(MODEL_FAR_CODE) flags|=1;
            else flags|=0x40;
        }
    }
    switch(*(unsigned char far *)MK_FP(TYPE_POOL,node)) {
    case 0x11: case 0x12:REPORT_TYPE_NOT_ALLOWED();break;
    }
    return NEW_FUNCTION_TYPE(node,value,mode,(signed char)flags);
}

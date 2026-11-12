/* target: DECLSPEC */
/* opts: -mm -G- -O -Z -p */
/* match: compiled directly by BC 2.0, not through TASM: CPP.EXE's relocations for this
   file come in descending order, as BC's own objects give (TASM objects give ascending
   order). The direct backend cross-jumps identical tails that the -B path keeps; four
   documented (void)0 merge barriers below keep the original's separate copies. */
/* CPP.EXE module DECLSPEC (image 0x64CE..0x777A, frame 064Ch): source taken from the
   BCC.EXE reconstruction (bcc20/src/parser/DECLSPEC.C), with CPP.EXE's
   edits marked "CPP.EXE edit". CPP.EXE has only some of its functions, in the same
   order; left out here: PARSE_OLD_STYLE_PARAMS, NEW_RECORD_TYPE, DECLARE_TAG_SYMBOL,
   LOOKUP_OR_DECLARE_TAG, PARSE_RECORD_SPECIFIER, PARSE_ENUM_SPECIFIER,
   ADD_CV_QUALIFIERS, STRIP_CV_QUALIFIERS. Image addresses in the CPP.EXE edit notes
   are CPP.EXE's. */
/* Role: parser: declaration specifiers and declarators, as needed for the type names
   of casts and sizeof in #if expressions. Entry points: PARSE_POINTER_DECLARATOR,
   PARSE_FUNCTION_DECLARATOR, PARSE_TYPE_MODIFIERS, PARSE_DECLARATOR,
   PARSE_DECL_SPECIFIERS. */
/* Overview: declaration specifiers and declarators. In CPP.EXE they are reached from
   PARSE_TYPE_NAME (OPPREC.C), which reads the type name of a cast or of
   sizeof(type) in an #if expression; in BCC they served its C++ front end (also used
   for C when CPP_MODE, the C++ language flag, is clear).  PARSE_DECL_SPECIFIERS reads
   the specifiers (storage class, friend, virtual, inline, type keywords) and returns
   the base type; PARSE_DECLARATOR then reads one declarator and returns the full type
   and the declared name.  CPP.EXE has no typedef names and no struct, union, class or
   enum specifiers, and its parameter lists are only checked for syntax.  Declarators
   are built directly as type records: pointer, array and function types are created
   from the outside in with the innermost slot left open, and ATTACH_DECLARATOR_BASE
   fills it with the base type at the end.
   Modifiers travel in a struct C16Spec of three bytes: first the calling
   convention (cdecl 1, pascal 2, interrupt 4), second the distance or
   segment (_es 1, _cs 2, _ss 3, _ds 4, _seg 7, near 8, far 9, huge 10;
   11 probably a member pointer's), third _loadds 2, _saveregs 0x10,
   _export 0x80.
   Type record offsets used through the T/TB macros: 0 kind (0x0D near
   pointer, 0x0E _seg pointer, 0x0F far pointer, 0x10 huge pointer, 0x11
   array, 0x12 function, 0x13 struct or class, 0x14 union, 0x15 enum),
   2 attributes (1 const, 2 volatile, 0x20 reference or runtime array
   bound, 0x40 old-style function or far array, 0x80 distance given
   explicitly), 3 member class, 5 struct body, 7 target or result, 9
   parameter list or array count, 11 calling convention or member pointer
   class, 12 function flags, 13 pointer segment mode (0x80 = not yet
   attached).  CL() reads the class body record (TAG_BODY_POOL_SEG), whose
   word 24 holds class flags (0x20 declared with "class", 8/0x10/0x100 far,
   near, huge class, 0x80 abstract, 0x200 had errors). */
#include <dos.h>
#include "DECLSPEC.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) AT_B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define C(n,o) AT_W(TAG_BODY_POOL_SEG,(unsigned int)(n)+(o))
#define CL(n,o) C(T(n,5),(o))
#define A(n,o) AT_W(FORMAL_POOL_SEG,(unsigned int)(n)+(o))
#define AB(n,o) AT_B(FORMAL_POOL_SEG,(unsigned int)(n)+(o))
#define E(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define NW(n,o) AT_W(SCOPE_POOL_SEG,(unsigned int)(n)+(o))
#define LINK(n,o) AT_W(NAME_POOL_SEG,(unsigned int)(n)+(o))
#define ARRAY_ELEMENT(n) (((struct C16Array far *)MK_FP(TYPE_POOL,(n)))->element)
#define FUNCTION_RESULT(n) (((struct C16Function far *)MK_FP(TYPE_POOL,(n)))->result)
#define TOKEN (*(struct C16Token near *)&CURRENT_TOKEN_RECORD)
#define CONTEXT (*(struct C16Context near *)&STRUCT_BODY_TYPE)
#define CTXW(o) (*(unsigned int near *)(CONTEXT.bytes+(o)))
#define CTXB(o) (*(unsigned char near *)(CONTEXT.bytes+(o)))

/* Nonzero if the current token is void or a typedef name for void (the
   caller then checks that ')' follows, for "f(void)"). */
static unsigned char near pascal IS_VOID_PARAM_LIST(void)
{
    /* CPP.EXE edit: only the void keyword; no typedef-name lookup (CPP.EXE 0x64CE
       compares CURRENT_TOKEN with 0x45 and nothing else). */
    return CURRENT_TOKEN==TOK_VOID;
}
/* Parses a prototype parameter list up to and including ')'.  *head
   receives the FORMAL list (type, name, register flag, and in C++ a
   default argument checked against the type and stored packed), *variadic
   1 if it ends in "...".  The parameters are parsed in a scope of their
   own (PARAM_LIST_DEPTH counts nesting; a struct first declared inside a
   parameter list is reported).  Arrays and functions become pointers. */
/* CPP.EXE edit: the preprocessor only checks the syntax.  CPP.EXE (0x64E1) keeps
   the token walk, the storage-class check and the separator diagnostics, but builds
   no FORMAL records, opens no parameter scope, converts no types and reads no default
   arguments; *head stays 0. */
static void near pascal PARSE_PARAM_LIST(unsigned int far *head,unsigned char far *variadic)
{
    unsigned int tail;
    unsigned int kind;
    unsigned int type;
    unsigned int name;
    unsigned int member;
    unsigned int scope;
    struct C16Spec spec;
    struct C16Spec scratch;
    unsigned char named;
    unsigned char modifier1;
    unsigned char modifier2;
    register unsigned int parameter;
    *variadic=0;
    *head=0;
    tail=0;
    if(IS_VOID_PARAM_LIST()) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==2) {
            ADVANCE_TOKEN();
            goto parameters_done;
        }
    }
    while(TOKEN_IS_TYPE_START(&TOKEN) && (PEEK_TOKEN(),TOKEN_TYPE)!=0x67) {
        type=INT_TYPE;
        PARSE_DECL_SPECIFIERS(0,&kind,&modifier1,&modifier2,&type,&spec,&named);
        if((kind!=0x82 && kind!=0x38) || modifier1 || modifier2)
            REPORT_CURRENT_TOKEN(MSG_REGISTER_ONLY_STORAGE);
        PARSE_DECLARATOR(type,1,&type,&name,&member,&scope,&spec,&scratch);
        if(CURRENT_TOKEN!=TOK_RPAREN && (CURRENT_TOKEN!=TOK_ELLIPSIS || !CPP_MODE)) {
            if(CURRENT_TOKEN==TOK_COMMA) {
                ADVANCE_TOKEN();
                if(CURRENT_TOKEN==TOK_RPAREN)
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            } else if(TOKEN_IS_TYPE_START(&TOKEN)) {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
                /* match: merge barrier (documented no-op, an exception). CPP.EXE
                   keeps this arm's own push ax / call REPORT_CURRENT_TOKEN / jmp at
                   +010A..+0113; without it BC's direct backend cross-jumps the arm
                   into the MSG_DECLARATION_WAS copy at +00F4 (6 bytes shorter).
                   continue, or else ; on the other copy, gave the same merge. */
                (void)0;
            } else if(CURRENT_TOKEN!=TOK_ELLIPSIS) {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                IN_ERROR_RECOVERY=1;
                SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
            }
        }
    }
parameters_done:
    if(CURRENT_TOKEN==TOK_ELLIPSIS) {
        *variadic=1;
        ADVANCE_TOKEN();
    }
    if(CURRENT_TOKEN!=TOK_RPAREN) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
        IN_ERROR_RECOVERY=1;
        SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
    }
    if(CURRENT_TOKEN==TOK_RPAREN)
        ADVANCE_TOKEN();
}
/* spec is the three-byte struct C16Spec, passed by value. */
/* At '*' or '&': returns a pointer (or, for '&' in C++, reference) type
   to type.  The pointer kind comes from the modifier in spec (near, far,
   huge, _seg, a segment register) or, by default, from the memory model
   (MODEL_FAR_DATA for data, MODEL_FAR_CODE or the function's own distance
   for code).  A string literal after '*' names a based pointer's base
   (FLUSH_PENDING_POOL).  const and volatile after it qualify the pointer.
   Pointers to references are errors. */
unsigned int far pascal PARSE_POINTER_DECLARATOR(register unsigned int type,struct C16Spec spec)
{
    unsigned int kind;
    unsigned int model;
    unsigned char special;
    unsigned int flags;
    register unsigned int result;
    special=0;
    /* CPP.EXE edit: no FIND_EQUIVALENT_TYPE of an unattached pointer here, no
       0x80 "not yet attached" mark on the new pointer's segment mode, and a
       based pointer's string is skipped without FLUSH_PENDING_POOL (CPP.EXE
       0x6670..0x67B4). */
    model=T(type,0)==0x12?2:4;
    switch(spec.second) {
    case 1:case 2:case 3:case 4:case 5:case 6:case 11:
        model=spec.second;
        kind=0x0D;
        break;
    case 9:
        special=1;
        model=0;
        kind=0x0F;
        break;
    case 7:
        model=0;
        kind=0x0E;
        break;
    case 10:
        special=1;
        model=0;
        kind=0x10;
        break;
    case 8:
        special=1;
        kind=0x0D;
        break;
    case 0:
        if(T(type,0)==0x12) {
            flags=TB(type,12);
            kind=(MODEL_FAR_CODE || (flags&1))?0x0F:0x0D;
            /* match: merge barrier (documented no-op, an exception). CPP.EXE
               has two full mov ax,0Fh / mov ax,0Dh / mov [bp-2],ax ternaries
               (+022E..+0239 and +0242..+024D); without it the direct backend
               shares one copy between both (7 bytes shorter, plus dead jmps).
               break here gave the same merge. */
            (void)0;
        } else
            kind=MODEL_FAR_DATA?0x0F:0x0D;
        break;
    }
    result=CREATE_TYPE(kind);
    if((EXPR_FLAGS[T(type,0)]&0x14) && (TB(type,2)&0x20))
        REPORT_CURRENT_TOKEN(MSG_CANNOT_DEFINE_POINTER);
    if(CURRENT_TOKEN==TOK_AMPERSAND) {
        if(!CPP_MODE)
            REPORT_CURRENT_TOKEN(MSG_ONLY_ALLOWED_C);
        else {
            TB(result,2)|=0x20;
            if(T(type,0)==0x0C)
                REPORT_WARNING(MSG_VOID_NOT_VALID_TYPE);
        }
    }
    if(special)
        TB(result,2)|=0x80;
    T(result,7)=type;
    T(result,9)=0;
    TB(result,13)=(unsigned char)model;
    T(result,11)=0;
    ADVANCE_TOKEN();
    if(CURRENT_TOKEN==0x34)
        ADVANCE_TOKEN();
    if(CURRENT_TOKEN==TOK_CONST || CURRENT_TOKEN==TOK_VOLATILE) {
        while(CURRENT_TOKEN==TOK_CONST || CURRENT_TOKEN==TOK_VOLATILE) {
            if(CURRENT_TOKEN==TOK_CONST) {
                if(TB(result,2)&1)
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                TB(result,2)|=1;
            } else {
                if(TB(result,2)&2)
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                TB(result,2)|=2;
            }
            ADVANCE_TOKEN();
        }
    }
    return result;
}
/* At '[': returns an array type.  runtime nonzero (in a new expression)
   allows a non-constant bound, kept as an expression with attribute 0x20;
   otherwise the bound must be a positive constant (zero is allowed in C).
   Further [] or () suffixes are parsed first, as they bind to the element.
   huge (spec.second 10) marks the array far (attribute 0x40); class flags
   4 and 8 (constructor, destructor) are copied from the element type. */
static unsigned int near pascal PARSE_ARRAY_DECLARATOR(unsigned char runtime,
    register unsigned int type,struct C16Spec spec)
{
    long count;
    unsigned char expression_bound;
    unsigned int expression;
    unsigned int result;
    if((EXPR_FLAGS[T(type,0)]&0x14) && (TB(type,2)&0x20))
        REPORT_CURRENT_TOKEN(MSG_ARRAY_REFERENCES_NOT);
    ADVANCE_TOKEN();
    expression_bound=0;
    if(CURRENT_TOKEN==TOK_RBRACKET)
        count=0L;
    else if(runtime) {
        expression=PARSE_ASSIGNMENT_EXPR(4);
        expression_bound=1;
    } else {
        PARSE_CONSTANT_EXPR_VALUE(4,&count);
        if(count<0L || (count==0L && CPP_MODE)) {
            REPORT_CURRENT_TOKEN(MSG_ARRAY_MUST_HAVE_LEAST);
            count=1L;
        }
    }
    if(CURRENT_TOKEN==TOK_RBRACKET)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_MISSING,STR_ARRAY_BOUNDS,0L);
    if(CURRENT_TOKEN==TOK_LBRACKET)
        type=PARSE_ARRAY_DECLARATOR(0,type,spec);
    else if(CURRENT_TOKEN==TOK_LPAREN && !runtime)
        type=PARSE_FUNCTION_DECLARATOR(type,spec);
    result=CREATE_TYPE(0x11);
    T(result,7)=type;
    if(expression_bound) {
        TB(result,2)|=0x20;
        T(result,13)=expression;
        T(result,11)=0;
        T(result,9)=0;
    } else
        *(long far *)MK_FP(TYPE_POOL,result+TYPE_PARAMS)=count;
    if(spec.second==10)
        TB(result,2)|=0x40;
    if(TB(type,2)&4)
        TB(result,2)|=4;
    if(TB(type,2)&8)
        TB(result,2)|=8;
    return result;
}
/* At '(': returns a function type with its parameter list.  "()" is an
   unprototyped function in C (flag 8) but an empty list in C++; an
   identifier list is old style (attribute 0x40, a warning in C++).  The
   function's distance comes from spec or the memory model (flags 0x40
   near, 1 far, 3 huge; interrupt functions are far), its calling
   convention from spec or DEFAULT_CALL_CONVENTION.  In C++ trailing const
   or volatile qualify a member function. */
unsigned int far pascal PARSE_FUNCTION_DECLARATOR(register unsigned int type,struct C16Spec spec)
{
    unsigned int parameters;
    unsigned char variadic;
    unsigned char unspecified;
    unsigned char old_style;
    unsigned int flags;
    register unsigned int result;
    ADVANCE_TOKEN();
    parameters=0;
    variadic=0;
    unspecified=0;
    old_style=0;
    if(CPP_MODE && CURRENT_TOKEN==TOK_ELLIPSIS) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==2) {
            ADVANCE_TOKEN();
            ADVANCE_TOKEN();
            variadic=1;
            goto parameters_done;
        }
    }
    if(!CPP_MODE && CURRENT_TOKEN==TOK_RPAREN) {
        unspecified=1;
        ADVANCE_TOKEN();
    /* CPP.EXE edit: no old-style identifier list branch (TYPE_LOOKUP_FAR,
       PARSE_OLD_STYLE_PARAMS); CPP.EXE (0x6A2B..0x6A35) goes straight to
       PARSE_PARAM_LIST.  old_style stays 0 but is still tested. */
    } else
        PARSE_PARAM_LIST(&parameters,&variadic);
parameters_done:
    if(CURRENT_TOKEN==TOK_LBRACKET)
        type=PARSE_ARRAY_DECLARATOR(0,type,spec);
    else if(CURRENT_TOKEN==TOK_LPAREN)
        type=PARSE_FUNCTION_DECLARATOR(type,spec);
    result=CREATE_TYPE(0x12);
    T(result,7)=type;
    T(result,9)=parameters;
    flags=spec.third;
    switch(spec.second) {
    case 0:case 11:
        if(OPTION_MEMORY_MODEL==5)
            flags|=3;
        else
            flags|=MODEL_FAR_CODE?1:0x40;
        break;
    case 8:
        flags|=0x40;
        TB(result,2)|=0x80;
        break;
    case 9:
        flags|=1;
        TB(result,2)|=0x80;
        break;
    case 10:
        flags|=3;
        TB(result,2)|=0x80;
        break;
    }
    TB(result,11)=spec.first?spec.first:DEFAULT_CALL_CONVENTION;
    if(spec.first==4) {
        flags&=0xFFBF;
        flags|=3;
    }
    if(unspecified)
        flags|=8;
    if(old_style)
        TB(result,2)|=0x40;
    if(variadic)
        flags|=4;
    if(CPP_MODE) {
        while(CURRENT_TOKEN==TOK_CONST || CURRENT_TOKEN==TOK_VOLATILE) {
            TB(result,2)|=CURRENT_TOKEN==TOK_CONST?1:2;
            ADVANCE_TOKEN();
        }
    }
    TB(result,12)=flags;
    return result;
}
/* Walks to the innermost type of the declarator chain and makes base its
   target, then applies the rules that depend on the base: pointers to
   members (base with a member class) become near pointers with mode 0x0B,
   a pointer's explicit distance is moved onto a function base and the
   pointer kind adjusted to the function's distance, an array's size above
   64K makes it a far array, and so on.  Returns the outermost type (base
   itself when declarator is 0). */
static unsigned int near pascal ATTACH_DECLARATOR_BASE(unsigned int declarator,
    register unsigned int base)
{
    /* CPP.EXE edit: declarator is not declared register (BCC's is): CPP.EXE keeps
       base in SI and declarator in DI, which this declaration gives. */
    unsigned int next;
    unsigned int result;
    if(!declarator)
        return base;
    /* CPP.EXE edit: base is not canonicalized (no FIND_EQUIVALENT_TYPE), and a
       near pointer declarator never carries a member class to move onto the base
       (no COPY_TYPE_RECORD / ADD_THIS_PARAMETER block); CPP.EXE 0x6BBC..0x6DBD. */
    result=declarator;
    do {
        switch(T(declarator,0)) {
        case 0x0D:case 0x0E:case 0x0F:case 0x10:
            next=T(declarator,7);
            TB(declarator,13)&=0x7F;
            break;
        case 0x11:
            next=ARRAY_ELEMENT(declarator);
            break;
        case 0x12:
            next=FUNCTION_RESULT(declarator);
            break;
        default:
            next=0;
            break;
        }
        if(next)
            declarator=next;
    } while(next);
    switch(T(declarator,0)) {
    case 0x0E:
        T(declarator,7)=base;
        if((CPP_MODE && T(base,3)) || T(base,0)==0x12)
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        break;
    case 0x0D:
        T(declarator,7)=base;
        if((EXPR_FLAGS[T(base,0)]&0x14) && (TB(base,2)&0x20))
            REPORT_CURRENT_TOKEN(MSG_CANNOT_DEFINE_POINTER);
        if(CPP_MODE && T(base,3))
            TB(declarator,13)=0x0B;
        else if(T(base,0)==0x12) {
            TB(declarator,13)=2;
            if(TB(declarator,2)&0x80) {
                if(!((unsigned int)TB(base,2)&0x80)) {
                    TB(base,12)&=0xFE;
                    TB(base,12)|=0x40;
                }
            } else if(TB(base,12)&1)
                T(declarator,0)=0x0F;
        }
        break;
    case 0x0F:case 0x10:
        T(declarator,7)=base;
        if((EXPR_FLAGS[T(base,0)]&0x14) && (TB(base,2)&0x20))
            REPORT_CURRENT_TOKEN(MSG_CANNOT_DEFINE_POINTER);
        if(CPP_MODE && T(base,3)) {
            if(TB(declarator,2)&0x80)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            TB(declarator,13)=0x0B;
            T(declarator,0)=0x0D;
        } else if(T(base,0)==0x12) {
            if(TB(declarator,2)&0x80) {
                if(!((unsigned int)TB(base,2)&0x80)) {
                    TB(base,12)&=0xBF;
                    TB(base,12)|=1;
                }
            } else if(TB(base,12)&0x40) {
                T(declarator,0)=0x0D;
                TB(declarator,13)=2;
            }
        }
        break;
    case 0x11:
        T(declarator,7)=base;
        if((EXPR_FLAGS[T(base,0)]&0x14) && (TB(base,2)&0x20))
            REPORT_CURRENT_TOKEN(MSG_ARRAY_REFERENCES_NOT);
        TB(declarator,2)|=TB(base,2)&0x0C;
        if(TYPE_SIZE(declarator)>0xFFFFL)
            TB(declarator,2)|=0x40;
        break;
    case 0x12:
        T(declarator,7)=base;
        break;
    }
    return result;
}
/* Returns a three-byte struct; the compiler supplies the hidden far
   destination itself (it is not a parameter in the source). */
/* Reads a run of modifier keywords into a copy of value and returns it
   (by value, through a hidden pointer).  Two calling conventions, two
   distances, a repeated flag, or interrupt with near are conflicting
   modifiers. */
struct C16Spec far pascal PARSE_TYPE_MODIFIERS(struct C16Spec value)
{
    struct C16Spec result;
    unsigned int model;
    unsigned int storage;
    unsigned int flags;
    result=value;
    for(;;) {
        flags=storage=model=0;
        switch(CURRENT_TOKEN) {
        case TOK_CDECL:storage=1;break;
        case TOK_PASCAL:storage=2;break;
        case TOK_INTERRUPT:storage=4;break;
        case TOK_LOADDS:flags=2;break;
        case TOK_EXPORT:flags=0x80;break;
        case TOK_SAVEREGS:flags=0x10;break;
        case TOK_CS:model=2;break;
        case TOK_DS:model=4;break;
        case TOK_ES:model=1;break;
        case TOK_SS:model=3;break;
        case TOK_SEG:model=7;break;
        case TOK_NEAR:model=8;break;
        case TOK_FAR:model=9;break;
        case TOK_HUGE:model=10;break;
        default:
            if(result.first && result.second<=3 && result.second>=2)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            return result;
        }
        if((int)result.third&flags)
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        result.third|=flags;
        if(storage) {
            if(result.first)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            if(storage==4 && result.second==8)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            result.first=storage;
        }
        if(model) {
            if(result.second)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            result.second=model;
        }
        ADVANCE_TOKEN();
    }
}
/* Parses one declarator applied to the base type initial.  Outputs: *type
   the declared type, *name the declared name (0 if none), *scope and
   *owner the qualifying class or scope when the name is qualified
   (C++), *spec the modifiers in force.  mode says where the declarator
   is: 0 an ordinary declaration, 1 a parameter, 2 probably a member, 3 a
   type name, 4 and 5 the type in a new expression (runtime array bounds;
   in mode 4 no function suffix), 6 only the leading pointer part (C++).
   In C++ the pointer part, including qualified names and member pointers,
   is handled by TYPE_PATH_FAR, and operator or destructor names by
   TYPE_OPERATOR_FAR.  "T x(...)" with T a class may be an object with
   constructor arguments rather than a function: PARSE_STATE_CHECK decides
   and the parentheses are then left for the initializer (retain).
   Arrays larger than 64K (16M for far arrays) are errors. */
void far pascal PARSE_DECLARATOR(unsigned int initial,register unsigned int mode,
    unsigned int far *type,unsigned int far *name,unsigned int far *scope,
    unsigned int far *owner,struct C16Spec far *spec,struct C16Spec far *scratch)
{
    unsigned int declarator;
    unsigned int built;
    struct C16Spec current;
    struct C16Spec nested;
    struct C16Spec suffix;
    struct C16Spec pointer;
    register unsigned int base;
    /* CPP.EXE edit: only the C path (CPP.EXE 0x6F1E..0x7217): no TYPE_PATH_FAR
       qualified-name prefix, no operator/destructor names, no retained
       constructor call, and no FIND_EQUIVALENT_TYPE anywhere; the type is
       returned as ATTACH_DECLARATOR_BASE built it. */
    base=initial;
    *scope=0;
    declarator=0;
    *owner=0;
    *name=0;
    current=*spec;
    suffix=EXPR_TEMP2;
    current=PARSE_TYPE_MODIFIERS(current);
    pointer=current;
    while(CURRENT_TOKEN==TOK_STAR || CURRENT_TOKEN==TOK_AMPERSAND) {
        base=PARSE_POINTER_DECLARATOR(base,pointer);
        pointer=PARSE_TYPE_MODIFIERS(EXPR_TEMP2);
    }
    nested=current;
    suffix=current;
    if(CURRENT_TOKEN==TOK_IDENT && (!mode || mode==2 || mode==1)) {
        *name=CURRENT_TOKEN_VALUE;
        *scope=0;
        ADVANCE_TOKEN();
    } else if(CURRENT_TOKEN==TOK_LPAREN && mode!=4) {
        PEEK_TOKEN();
        if(TYPE_FLAGS[TOKEN_TYPE]&0x10) {
            ADVANCE_TOKEN();
            PARSE_DECLARATOR(0,mode,&declarator,name,scope,owner,&nested,&suffix);
            if(!declarator) {
                if(nested.second) {
                    if(current.second && current.second!=nested.second)
                        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
                    else
                        current.second=nested.second;
                }
                if(nested.first) {
                    if(current.first && current.first!=nested.first)
                        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
                    else
                        current.first=nested.first;
                }
                if(nested.third) {
                    if(current.third && nested.third!=current.third)
                        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
                    else
                        current.third=nested.third;
                }
            }
            if(CURRENT_TOKEN==TOK_RPAREN)
                ADVANCE_TOKEN();
            else {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                IN_ERROR_RECOVERY=1;
                SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
            }
        }
    }
    if(CURRENT_TOKEN==TOK_LBRACKET) {
        built=PARSE_ARRAY_DECLARATOR(mode==4 || mode==5,base,current);
        if(current.second==10)
            nested.second=0;
    } else if(CURRENT_TOKEN==TOK_LPAREN)
        built=PARSE_FUNCTION_DECLARATOR(base,suffix);
    else
        built=base;
    *type=ATTACH_DECLARATOR_BASE(declarator,built);
    *spec=current;
    if(T(*type,0)==0x11 && *type!=initial) {
        if(TB(*type,2)&0x40) {
            if(TYPE_SIZE(*type)>0xFFFFFFL) {
                REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
                /* match: merge barrier (documented no-op, an exception). CPP.EXE
                   has both mov ax,0Ch / push ax / call REPORT_CURRENT_TOKEN copies
                   (+0D17 and +0D38); without it the direct backend jumps the
                   first test into the second copy (13 bytes shorter). An empty
                   else gave the same merge. */
                (void)0;
            }
        } else if(TYPE_SIZE(*type)>0xFFFFL)
            REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
    }
}
/* Its switch over 15 sparse keys is a value table in the code segment. */
/* Adds the current type keyword to words (primary: void, char, int,
   float, double, struct ...; sign: signed, unsigned; size: short, long;
   constant, changing: const, volatile) and consumes it, parsing a
   struct/union/class/enum specifier on the spot.  Returns 1 when the
   keyword cannot combine with those already seen, which ends the
   specifiers (a repeated keyword is reported and skipped instead). */
static unsigned char near pascal ACCEPT_TYPE_WORD(unsigned int context,
    struct C16TypeWords far *words,unsigned int far *type)
{
    if(words->primary==CURRENT_TOKEN || words->sign==CURRENT_TOKEN ||
        words->size==CURRENT_TOKEN) {
        if(CURRENT_TOKEN!=TOK_STRUCT && CURRENT_TOKEN!=TOK_UNION &&
           CURRENT_TOKEN!=TOK_CLASS && CURRENT_TOKEN!=TOK_ENUM) {
            REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
            ADVANCE_TOKEN();
        }
        return 1;
    }
    switch(CURRENT_TOKEN) {
    case TOK_VOID:
        if(words->primary!=0x82 || words->sign!=0x82 || words->size!=0x82)
            return 1;
        words->primary=0x45;
        ADVANCE_TOKEN();
        break;
    case TOK_CHAR:
        if(words->primary!=0x82 || words->size!=0x82)
            return 1;
        words->primary=0x3A;
        ADVANCE_TOKEN();
        break;
    case TOK_INT:
        if(words->primary!=0x82)
            return 1;
        words->primary=0x3C;
        ADVANCE_TOKEN();
        break;
    case TOK_FLOAT:case TOK_DOUBLE:
        if(words->primary!=0x82 || words->sign!=0x82 || words->size==0x3B ||
           (CURRENT_TOKEN==TOK_FLOAT && words->size==0x3F))
            return 1;
        words->primary=CURRENT_TOKEN;
        ADVANCE_TOKEN();
        break;
    case TOK_SHORT:
        if((words->primary!=0x82 && words->primary!=0x3C) || words->size!=0x82)
            return 1;
        words->size=0x3B;
        ADVANCE_TOKEN();
        break;
    case TOK_LONG:
        if((words->primary!=0x82 && words->primary!=0x3C && words->primary!=0x41) ||
            words->size!=0x82)
            return 1;
        words->size=0x3F;
        ADVANCE_TOKEN();
        break;
    case TOK_UNSIGNED:case TOK_SIGNED:
        if((words->primary!=0x82 && words->primary!=0x3A && words->primary!=0x3C) ||
            words->sign!=0x82)
            return 1;
        words->sign=CURRENT_TOKEN;
        ADVANCE_TOKEN();
        break;
    case TOK_CONST:
        if(*type && (words->constant || (TB(*type,2)&1)))
            REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
        words->constant=1;
        ADVANCE_TOKEN();
        break;
    case TOK_VOLATILE:
        if(*type && (words->changing || (TB(*type,2)&2)))
            REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
        words->changing=1;
        ADVANCE_TOKEN();
        break;
    case TOK_STRUCT:case TOK_UNION:case TOK_ENUM:case TOK_CLASS:
        /* CPP.EXE edit: no struct/union/class/enum specifiers; the keyword is
           skipped and ends the type words (CPP.EXE 0x6F68: jmp to the
           ADVANCE_TOKEN; return 1 tail of the repeated-keyword branch). */
        ADVANCE_TOKEN();
        return 1;
    }
    return 0;
}
/* words is an eight-byte struct passed by value. */
/* Turns the collected type words into a type: the basic type indexed in
   BCC_TYPE_PTR (char kinds 1 and 2, or PLAIN_CHAR_KIND for plain char;
   short 3, int 5, long 7, each +1 for unsigned; float 9, double 10, long
   double 11, void 12), or type itself for a typedef name or a struct
   specifier.  Returns 0 if no type was given at all.  const and volatile
   are then added. */
static unsigned int near pascal BUILD_BASIC_TYPE(struct C16TypeWords words,
    unsigned char named,unsigned int type)
{
    register unsigned int index;
    register unsigned int result;
    index=0;
    if(!named &&
       (words.primary==0x45 || words.primary==0x3A || words.primary==0x3C ||
        words.primary==0x40 || words.primary==0x41 ||
        ((words.constant || words.changing) && words.primary==0x82) ||
        words.sign!=0x82 || words.size!=0x82))
        result=0;
    else {
        if(!type)
            return 0;
        result=type;
    }
    if(!result) {
        if(words.primary==0x40 || words.primary==0x41) {
            if(words.size==0x3F)
                index=11;
            else if(words.primary==0x41)
                index=10;
            else
                index=9;
        } else if(words.primary==0x3A) {
            if(words.sign==0x3E)
                index=1;
            else if(words.sign==0x3D)
                index=2;
            else
                index=PLAIN_CHAR_KIND;
        } else if(words.primary!=0x82 || words.sign!=0x82 ||
                  words.constant || words.changing || words.size!=0x82) {
            if(words.primary==0x45)
                index=12;
            else if(words.size==0x3B)
                index=3;
            else if(words.size==0x3F)
                index=7;
            else
                index=5;
            if(words.sign==0x3D)
                ++index;
        }
        result=BCC_TYPE_PTR[index];
    }
    /* CPP.EXE edit: const and volatile are not added (no ADD_CV_QUALIFIERS;
       CPP.EXE 0x7539 returns result as it is). */
    return result;
}
/* Nonzero while the current token can continue the specifiers: a type
   start that is not '~', and an identifier only if no type has been seen
   yet (in C++ also not when followed by '::', a qualified name). */
static unsigned char near pascal MORE_TYPE_WORDS(register unsigned int primary)
{
    return TOKEN_IS_TYPE_START(&TOKEN) && CURRENT_TOKEN!=TOK_TILDE &&
        (CURRENT_TOKEN!=TOK_IDENT || primary==0x82) &&
        (!CPP_MODE || CURRENT_TOKEN!=TOK_IDENT ||
         ((PEEK_TOKEN(),TOKEN_TYPE)!=0x67 &&
          (primary==0x82 || primary==0x45 || primary==0x3A || primary==0x3C ||
           primary==0x40 || primary==0x41)));
}
/* Parses declaration specifiers.  Outputs: *kind the storage-class or
   function-specifier token (0x82 if none; static with inline gives
   inline), *modifier1 friend, *modifier2 virtual, *type the base type (the
   caller passes a default in *type), *spec the modifiers attached to a
   typedef name used as the type, *named 1 if the type was a typedef name.
   context 0 allows a forward declaration "struct S;".  overload is
   obsolete and only warned about. */
void far pascal PARSE_DECL_SPECIFIERS(unsigned int context,unsigned int far *kind,
    unsigned char far *modifier1,unsigned char far *modifier2,unsigned int far *type,
    struct C16Spec far *spec,unsigned char far *named)
{
    struct C16TypeWords words;
    unsigned int result;
    result=*type;
    spec->first=0;
    spec->second=0;
    spec->third=0;
    words.primary=0x82;
    words.sign=0x82;
    words.size=0x82;
    words.constant=0;
    words.changing=0;
    *named=0;
    *kind=0x82;
    *modifier1=0;
    *modifier2=0;
    ENUM_BODY_TREE_FLAG=0;
    while(MORE_TYPE_WORDS(words.primary)) {
        if(TYPE_FLAGS[CURRENT_TOKEN]&1) {
            if(CURRENT_TOKEN==TOK_OVERLOAD) {
                REPORT_CURRENT_TOKEN(MSG_OVERLOAD_NOW);
                if(*kind==0x82) {
                    *kind=CURRENT_TOKEN;
                    /* match: merge barrier (documented no-op, an exception).
                       CPP.EXE keeps this les bx / mov ax,CURRENT_TOKEN / mov
                       es:[bx],ax store at +119F with its own jmp to ADVANCE_TOKEN;
                       without it the direct backend merges it into the storage
                       class copy at +1225, and the friend/virtual tails then share
                       in the other direction (7 bytes shorter). An empty else
                       gave the same merge. */
                    (void)0;
                }
            } else if(CURRENT_TOKEN==TOK_FRIEND) {
                if(*modifier1)
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                *modifier1=1;
            } else if(CURRENT_TOKEN==TOK_VIRTUAL) {
                if(*modifier2)
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                *modifier2=1;
            } else if(CURRENT_TOKEN==TOK_INLINE && *kind==0x35) {
                *kind=CURRENT_TOKEN;
            } else if(!(CURRENT_TOKEN==TOK_STATIC && *kind==0x6B)) {
                if(*kind!=0x82 && *kind!=0x6E)
                    REPORT_CURRENT_TOKEN(MSG_TOO_MANY_STORAGE);
                else
                    *kind=CURRENT_TOKEN;
            }
            ADVANCE_TOKEN();
        } else if(TYPE_FLAGS[CURRENT_TOKEN]&2) {
            if(ACCEPT_TYPE_WORD(context,&words,&result))
                break;
        /* CPP.EXE edit: no typedef names (no TOK_IDENT branch with
           TYPE_LOOKUP_FAR); an identifier is reported as not legal here
           (CPP.EXE 0x7365..0x73A5). */
        } else
            REPORT_DIAGNOSTIC(MSG_NOT_LEGAL_HERE,NAME_TEXT_COPY(TOKEN_NAMES[CURRENT_TOKEN]),0L);
    }
    *type=BUILD_BASIC_TYPE(words,*named,result);
}

/* target: ovr072_C16UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: parser (C++ mode): declarations: declaration specifiers, pointer/array/function
   declarators, type modifiers, struct/union/class and enum specifiers, tags, cv-qualifiers.
   Entry points: PARSE_POINTER_DECLARATOR, PARSE_FUNCTION_DECLARATOR, PARSE_TYPE_MODIFIERS,
   PARSE_DECLARATOR, NEW_RECORD_TYPE, ADD_CV_QUALIFIERS, STRIP_CV_QUALIFIERS,
   PARSE_DECL_SPECIFIERS. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: declaration specifiers and declarators for the C++ front end
   (also used for C when CPP_MODE, the C++ language flag, is
   clear).  PARSE_DECL_SPECIFIERS reads the specifiers of a declaration
   (storage class, friend, virtual, inline, type keywords, a typedef name,
   a struct/union/class/enum specifier) and returns the base type;
   PARSE_DECLARATOR then reads one declarator and returns the full type
   and the declared name.  Unlike the C front end (CDECLR.C), declarators
   are built directly as type records: pointer, array and function types
   are created from the outside in with the innermost slot left open, and
   ATTACH_DECLARATOR_BASE fills it with the base type at the end.
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

/* 0000 */
/* Reads an old-style identifier list "f(a, b, c)" up to ')' and returns
   it as FORMAL records with names only (types come later, in
   PARSE_KR_PARAMETERS).  A repeated name is reported. */
static unsigned int near pascal PARSE_OLD_STYLE_PARAMS(void)
{
    unsigned int tail;
    unsigned int head;
    register unsigned int node;
    register unsigned int next;
    tail=0;
    head=0;
    while(CURRENT_TOKEN==TOK_IDENT) {
        next=ALLOC_FORMAL_RECORD();
        A(next,4)=CURRENT_TOKEN_VALUE;
        if(!tail)
            head=next;
        else
            A(tail,0)=next;
        tail=next;
        node=head;
        while(A(node,4)!=CURRENT_TOKEN_VALUE)
            node=A(node,0);
        if(node!=tail)
            REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,NAME_TEXT_COPY(A(node,4)),0L);
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN!=TOK_RPAREN) {
            if(CURRENT_TOKEN==TOK_COMMA) {
                while(CURRENT_TOKEN==TOK_COMMA) {
                    ADVANCE_TOKEN();
                    if(CURRENT_TOKEN==TOK_RPAREN || CURRENT_TOKEN==TOK_COMMA)
                        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
                }
            } else {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
                IN_ERROR_RECOVERY=1;
            }
        }
    }
    if(CURRENT_TOKEN!=TOK_RPAREN) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
        IN_ERROR_RECOVERY=1;
        SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
    }
    if(CURRENT_TOKEN==TOK_RPAREN)
        ADVANCE_TOKEN();
    return head;
}
/* 00FF */
/* Nonzero if the current token is void or a typedef name for void (the
   caller then checks that ')' follows, for "f(void)"). */
static unsigned char near pascal IS_VOID_PARAM_LIST(void)
{
    return CURRENT_TOKEN==TOK_VOID ||
        (CURRENT_TOKEN==TOK_IDENT && T(TYPE_LOOKUP_FAR(CURRENT_TOKEN_VALUE),0)==0x0C);
}
/* 0130 */
/* Parses a prototype parameter list up to and including ')'.  *head
   receives the FORMAL list (type, name, register flag, and in C++ a
   default argument checked against the type and stored packed), *variadic
   1 if it ends in "...".  The parameters are parsed in a scope of their
   own (PARAM_LIST_DEPTH counts nesting; a struct first declared inside a
   parameter list is reported).  Arrays and functions become pointers. */
static void near pascal PARSE_PARAM_LIST(unsigned int far *head,unsigned char far *variadic)
{
    unsigned int tail;
    unsigned int kind;
    unsigned int type;
    unsigned int name;
    unsigned int expression;
    unsigned int member;
    unsigned int scope;
    struct C16Spec spec;
    struct C16Spec scratch;
    unsigned char named;
    unsigned char modifier1;
    unsigned char modifier2;
    unsigned int saved;
    unsigned int context;
    register unsigned int parameter;
    register unsigned int result;
    saved=PARAM_SCOPE_MARK;
    context=ALLOC_SCOPE();
    NW(context,0)=CURRENT_SCOPE;
    CURRENT_SCOPE=context;
    ++PARAM_LIST_DEPTH;
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
        parameter=ALLOC_FORMAL_RECORD();
        type=INT_TYPE;
        PARSE_DECL_SPECIFIERS(0,&kind,&modifier1,&modifier2,&type,&spec,&named);
        if((kind!=0x82 && kind!=0x38) || modifier1 || modifier2)
            REPORT_CURRENT_TOKEN(MSG_REGISTER_ONLY_STORAGE);
        PARSE_DECLARATOR(type,1,&type,&name,&member,&scope,&spec,&scratch);
        if(T(type,0)==0x12)
            type=MAKE_POINTER_TYPE(type,0,0);
        else if(T(type,0)==0x11)
            type=MAKE_POINTER_TYPE(T(type,7),(TB(type,2)&0x40)?0x10:0,0);
        if(CPP_MODE && (EXPR_FLAGS[T(type,0)]&0x40) &&
            (CL(type,24)&0x80))
            REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE,(char far *)CLASS_NAME_OF_TYPE(type),0L);
        A(parameter,2)=type;
        A(parameter,4)=name;
        if(name) {
            if(member)
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
            if(scope)
                REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_CANNOT_HAVE);
        }
        if(CPP_MODE && CURRENT_TOKEN==TOK_ASSIGN) {
            ADVANCE_TOKEN();
            expression=PARSE_ASSIGNMENT_EXPR(2);
            result=ANALYZE_AND_DECAY(COPY_EXPR_TREE(expression),type);
            result=NULL_CONSTANT_TO_POINTER(type,result);
            if(CANNOT_CONVERT_TYPES(type,E(result,8)))
                result=REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE,FORMAT_TYPE(type),FORMAT_TYPE(E(result,8)),result);
            FREE_EXPR_TREE(result);
            A(parameter,8)=PACK_EXPR_TREE(expression);
            FREE_EXPR_TREE(expression);
        }
        AB(parameter,6)=kind==0x38;
        A(parameter,0)=0;
        if(!tail)
            *head=parameter;
        else
            A(tail,0)=parameter;
        tail=parameter;
        if(A(parameter,4)) {
            parameter=*head;
            while(A(parameter,4)!=name)
                parameter=A(parameter,0);
            if(parameter!=tail)
                REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
        }
        if(CURRENT_TOKEN!=TOK_RPAREN && (CURRENT_TOKEN!=TOK_ELLIPSIS || !CPP_MODE)) {
            if(CURRENT_TOKEN==TOK_COMMA) {
                ADVANCE_TOKEN();
                if(CURRENT_TOKEN==TOK_RPAREN)
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            } else if(TOKEN_IS_TYPE_START(&TOKEN))
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
            else if(CURRENT_TOKEN!=TOK_ELLIPSIS) {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                IN_ERROR_RECOVERY=1;
                SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
            }
        }
    }
    A(tail,0)=0;
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
    --PARAM_LIST_DEPTH;
    CURRENT_SCOPE=NW(CURRENT_SCOPE,0);
    PARAM_SCOPE_MARK_AUX=0;
    PARAM_SCOPE_MARK=saved;
}
/* 04CE: pointer/reference declarator, real three-byte by-value flags. */
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
    if((EXPR_FLAGS[T(type,0)]&0x14) && (TB(type,13)&0x80))
        type=FIND_EQUIVALENT_TYPE(type);
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
    TB(result,13)=(unsigned char)model|0x80;
    T(result,11)=0;
    ADVANCE_TOKEN();
    if(CURRENT_TOKEN==0x34) {
        if(kind==0x0D) {
            T(result,9)=FLUSH_PENDING_POOL();
            STRING_TOKEN_PENDING=0;
        }
        ADVANCE_TOKEN();
    }
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
/* 06DD */
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
/* 085C */
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
    } else if(CURRENT_TOKEN==TOK_IDENT && !TYPE_LOOKUP_FAR(CURRENT_TOKEN_VALUE)) {
        if(CPP_MODE)
            REPORT_CURRENT_TOKEN(MSG_STYLE_FUNCTION);
        parameters=PARSE_OLD_STYLE_PARAMS();
        old_style=1;
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
/* 0A51: attach the base to the complete declarator chain. */
/* Walks to the innermost type of the declarator chain and makes base its
   target, then applies the rules that depend on the base: pointers to
   members (base with a member class) become near pointers with mode 0x0B,
   a pointer's explicit distance is moved onto a function base and the
   pointer kind adjusted to the function's distance, an array's size above
   64K makes it a far array, and so on.  Returns the outermost type (base
   itself when declarator is 0). */
static unsigned int near pascal ATTACH_DECLARATOR_BASE(register unsigned int declarator,
    register unsigned int base)
{
    unsigned int next;
    unsigned int result;
    if(!declarator)
        return base;
    base=FIND_EQUIVALENT_TYPE(base);
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
        if(CPP_MODE && T(declarator,11)) {
            if(!T(base,3)) {
                base=COPY_TYPE_RECORD(base);
                T(declarator,7)=base;
                T(base,3)=T(declarator,11);
                if(T(base,0)==0x12)
                    ADD_THIS_PARAMETER(T(declarator,11),base);
            } else
                REPORT_CURRENT_TOKEN(MSG_MULTIPLE_SCOPE);
        }
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
/* 0CE8: genuine three-byte structure return. Borland supplies its hidden
   FAR destination automatically; it is not an explicit source formal. */
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
/* 0E49 */
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
    unsigned char retain;
    struct C16Spec current;
    struct C16Spec nested;
    struct C16Spec suffix;
    struct C16Spec pointer;
    register unsigned int base;
    base=initial;
    *scope=0;
    declarator=0;
    *owner=0;
    *name=0;
    current=*spec;
    suffix=EXPR_TEMP2;
    if(CPP_MODE) {
        base=TYPE_PATH_FAR(base,mode,owner,&current,scratch);
        if(mode==6) {
            *type=FIND_EQUIVALENT_TYPE(base);
            *spec=current;
            return;
        }
    } else {
        current=PARSE_TYPE_MODIFIERS(current);
        pointer=current;
        while(CURRENT_TOKEN==TOK_STAR || CURRENT_TOKEN==TOK_AMPERSAND) {
            base=PARSE_POINTER_DECLARATOR(base,pointer);
            pointer=PARSE_TYPE_MODIFIERS(EXPR_TEMP2);
        }
    }
    nested=current;
    suffix=current;
    if(CURRENT_TOKEN==TOK_IDENT && (!mode || mode==2 || mode==1)) {
        *name=CURRENT_TOKEN_VALUE;
        *scope=0;
        ADVANCE_TOKEN();
    } else if(CPP_MODE && (CURRENT_TOKEN==TOK_OPERATOR || CURRENT_TOKEN==TOK_TILDE))
        base=TYPE_OPERATOR_FAR(FIND_EQUIVALENT_TYPE(base),*owner,name,scope);
    else if(CURRENT_TOKEN==TOK_LPAREN && mode!=4) {
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
        built=PARSE_ARRAY_DECLARATOR(mode==4 || mode==5,FIND_EQUIVALENT_TYPE(base),current);
        if(current.second==10)
            nested.second=0;
    } else if(CURRENT_TOKEN==TOK_LPAREN) {
        retain=0;
        if(CPP_MODE) {
            retain=mode==4;
            if(!mode && (EXPR_FLAGS[T(initial,0)]&0x40))
                retain=*name!=0 && *scope==0 && !PARSE_STATE_CHECK();
            built=retain?base:PARSE_FUNCTION_DECLARATOR(FIND_EQUIVALENT_TYPE(base),suffix);
        } else
            built=PARSE_FUNCTION_DECLARATOR(base,suffix);
    } else
        built=base;
    *type=FIND_EQUIVALENT_TYPE(ATTACH_DECLARATOR_BASE(declarator,built));
    *spec=current;
    if(T(*type,0)==0x11 && *type!=initial) {
        if(TB(*type,2)&0x40) {
            if(TYPE_SIZE(*type)>0xFFFFFFL)
                REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
        } else if(TYPE_SIZE(*type)>0xFFFFL)
            REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
    }
}
/* 1255 */
/* Creates a struct (or union, token 0x43) type.  In C++ the class flags
   record "class" (token 0x68) and a near, far or huge class (access
   0x4F, 0x50, 0x56). */
unsigned int far pascal NEW_RECORD_TYPE(unsigned int token,register unsigned int access)
{
    register unsigned int type;
    type=CREATE_TYPE(token==0x43?0x14:0x13);
    if(CPP_MODE) {
        if(token==0x68)
            CL(type,24)|=0x20;
        if(access==0x4F)
            CL(type,24)|=0x10;
        else if(access==0x50)
            CL(type,24)|=8;
        else if(access==0x56)
            CL(type,24)|=0x100;
    }
    if(PARAM_LIST_DEPTH)
        REPORT_DIAGNOSTIC(MSG_DECLARE_PRIOR_USE,(char far *)FORMAT_TYPE(type),0L);
    return type;
}
/* 1301 */
/* Makes a tag symbol for type (name may be 0 for an anonymous struct),
   storage class 8, name-space kind 2, and chains it into the list headed
   at the name record of the keyword "struct" (TOKEN_NAMES[TOK_STRUCT]),
   which probably collects tags that are not in a scope. */
static unsigned int near pascal DECLARE_TAG_SYMBOL(unsigned int type,unsigned int name)
{
    unsigned int link;
    register unsigned int symbol;
    register unsigned int result_type;
    result_type=type;
    symbol=ALLOC_SYMBOL_ENTRY(name,1);
    S(symbol,4)=result_type;
    if(result_type)
        CL(result_type,6)=symbol;
    SB(symbol,7)=(SB(symbol,7)&7)|0x40;
    SB(symbol,7)=(SB(symbol,7)&0xF8)|2;
    link=TOKEN_NAMES[TOK_STRUCT];
    S(symbol,0)=LINK(link,0);
    LINK(link,0)=symbol;
    C0MARK(1);
    return symbol;
}
/* 1383 */
/* Reads an optional tag name and returns the tag symbol.  definition
   nonzero means a body (or a forward declaration "struct S;") follows, so
   only the current scope is searched; otherwise the tag is looked up in
   all scopes.  Redefining a defined struct, or using a non-struct name as
   a tag, is reported and a fresh tag is made (*valid 0 tells the caller to
   skip the body).  A new named tag is declared in the current scope
   (storage class 11).  In C++ a struct tag and a typedef of the same name
   for a different type are reported. */
static unsigned int near pascal LOOKUP_OR_DECLARE_TAG(unsigned int token,unsigned int access,
    unsigned char definition,unsigned char far *valid)
{
    unsigned int name;
    unsigned int previous;
    register unsigned int type;
    register unsigned int symbol;
    symbol=0;
    name=0;
    *valid=1;
    if(CURRENT_TOKEN==TOK_IDENT) {
        name=CURRENT_TOKEN_VALUE;
        ADVANCE_TOKEN();
    }
    if(name) {
        if(definition)
            symbol=FIND_NAME_IN_LIST(name,NW(CURRENT_SCOPE,6));
        else
            symbol=BCC_TYPE_PRIMARY(name);
    }
    if(symbol) {
        type=S(symbol,4);
        if(!((unsigned int)EXPR_FLAGS[T(type,0)]&0x40)) {
            REPORT_NAME_DIAGNOSTIC(MSG_MUST_PREVIOUSLY_240,name);
            return DECLARE_TAG_SYMBOL(NEW_RECORD_TYPE(token,access),name);
        }
        if(CL(type,4) && definition && (!CPP_MODE || CURRENT_TOKEN!=TOK_SEMICOLON)) {
            REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
            *valid=0;
            return DECLARE_TAG_SYMBOL(NEW_RECORD_TYPE(token,access),name);
        }
        if(CPP_MODE) {
            if(token==0x68)
                CL(type,24)|=0x20;
            if((access==0x4F && (CL(type,24)&0x108)) ||
               (access==0x50 && (CL(type,24)&0x110)) ||
               (access==0x56 && (CL(type,24)&0x18)))
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        }
        return symbol;
    }
    type=NEW_RECORD_TYPE(token,access);
    if(name) {
        symbol=DECLARE_TAG(name);
        SB(symbol,7)=(SB(symbol,7)&7)|0x58;
        S(symbol,4)=type;
        CL(type,6)=symbol;
    } else
        symbol=DECLARE_TAG_SYMBOL(type,0);
    if(CPP_MODE && name) {
        previous=FIND_NAME_IN_LIST(name,NW(CURRENT_SCOPE,4));
        if(previous && (SB(previous,7)>>3)==8 && S(previous,4)!=type)
            REPORT_NAME_DIAGNOSTIC(MSG_BOTH_STRUCTURE_TAG,S(previous,2));
    }
    return symbol;
}
/* 157E */
/* Parses a struct, union or class specifier after its keyword (with the
   C++ class modifiers near, far, huge, _export first) and returns its
   type.  With a body ('{', or ':' for C++ base classes) the members are
   parsed by TYPE_CLOSE with the class being defined in STRUCT_BODY_TYPE
   and CURRENT_CLASS_TYPE; the parse state block at STRUCT_BODY_TYPE
   (struct C16Context) is saved and restored around nested class
   definitions (BCC_TREE_FLAG counts the nesting).  In C++ the
   compiler-generated members are then declared, unless errors occurred
   (class flag 0x200 marks a class whose definition had errors). */
static unsigned int near pascal PARSE_RECORD_SPECIFIER(unsigned int token,unsigned char allow_forward)
{
    unsigned int following;
    unsigned char definition;
    unsigned char valid;
    unsigned int type;
    unsigned char virtual_class;
    unsigned int saved_scope;
    unsigned int saved_special;
    unsigned int snapshot;
    struct C16Context saved_context;
    register unsigned int symbol;
    register unsigned int access;
    access=0x82;
    virtual_class=0;
    snapshot=ERROR_COUNT;
    while(CURRENT_TOKEN==TOK_NEAR || CURRENT_TOKEN==TOK_FAR ||
          CURRENT_TOKEN==TOK_HUGE || CURRENT_TOKEN==TOK_EXPORT) {
        if(CURRENT_TOKEN==TOK_NEAR || CURRENT_TOKEN==TOK_FAR || CURRENT_TOKEN==TOK_HUGE)
            access=CURRENT_TOKEN;
        else {
            virtual_class=1;
            access=0x56;
        }
        if(!CPP_MODE)
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        ADVANCE_TOKEN();
    }
    if(CURRENT_TOKEN==TOK_IDENT) {
        PEEK_TOKEN();
        following=TOKEN_TYPE;
    } else
        following=CURRENT_TOKEN;
    definition=following==5 || (CPP_MODE && following==0x21);
    symbol=LOOKUP_OR_DECLARE_TAG(token,access,definition || (following==7 && allow_forward),&valid);
    if(!definition)
        return S(symbol,4);
    saved_special=BCC_TREE_SPECIAL;
    BCC_TREE_SPECIAL=0;
    if(BCC_TREE_FLAG++)
        saved_context=CONTEXT;
    ACTIVE_LIST=symbol;
    STRUCT_BODY_TYPE=S(symbol,4);
    saved_scope=CURRENT_CLASS_TYPE;
    CURRENT_CLASS_TYPE=STRUCT_BODY_TYPE;
    CLASS_KEY_TOKEN=token;
    CTXW(0x25)=access;
    CTXW(6)=0;
    CTXW(4)=0;
    CTXW(8)=0;
    CTXB(0x2B)=virtual_class;
    if(CPP_MODE)
        TYPE_BASE_FAR();
    /* Native malformed-entry exit deliberately bypasses state restoration. */
    if(CURRENT_TOKEN!=TOK_LBRACE)
        return STRUCT_BODY_TYPE;
    if(!valid) {
        SKIP_BRACE_GROUP();
        IN_ERROR_RECOVERY=0;
    } else {
        ADVANCE_TOKEN();
        if(!CPP_MODE && !NOT_ANSI_FLAG && CURRENT_TOKEN==TOK_RBRACE)
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
        TYPE_CLOSE();
        if(CPP_MODE && snapshot==ERROR_COUNT)
            DECLARE_IMPLICIT_MEMBERS();
    }
    type=STRUCT_BODY_TYPE;
    if(snapshot!=ERROR_COUNT)
        CL(type,24)|=0x200;
    if(--BCC_TREE_FLAG)
        CONTEXT=saved_context;
    CURRENT_CLASS_TYPE=saved_scope;
    BCC_TREE_SPECIAL=saved_special;
    return type;
}
/* 1789 */
/* Parses an enum specifier after its keyword: a body is built by
   ENUM_BUILD; "enum name" must name an existing enum.  Returns the type
   or 0. */
static unsigned int near pascal PARSE_ENUM_SPECIFIER(void)
{
    unsigned char present;
    struct C16Token token;
    register unsigned int symbol;
    register unsigned int type;
    present=0;
    if(CURRENT_TOKEN==TOK_IDENT) {
        token=TOKEN;
        present=1;
        ADVANCE_TOKEN();
    }
    if(CURRENT_TOKEN==TOK_LBRACE) {
        ENUM_BODY_TREE_FLAG=(unsigned char)BCC_TREE_FLAG;
        type=ENUM_BUILD(&token,present);
        if(PARAM_LIST_DEPTH)
            REPORT_DIAGNOSTIC(MSG_DECLARE_PRIOR_USE,(char far *)FORMAT_TYPE(type),0L);
        return type;
    }
    if(present) {
        symbol=BCC_TYPE_PRIMARY(token.name);
        if(!symbol) {
            REPORT_TOKEN_DIAGNOSTIC(&token,MSG_UNDEFINED_SYMBOL);
            return 0;
        } else if(T(S(symbol,4),0)==0x15)
            return S(symbol,4);
        else {
            REPORT_TOKEN_DIAGNOSTIC(&token,MSG_MUST_PREVIOUSLY_206);
            return 0;
        }
    } else
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    return 0;
}
/* 1853 */
/* Returns type with volatile (second) and/or const (first) added.  Basic
   types (kind 12 and below) come from the fixed table C9_TYPE_GRID, other
   types from INTERN_QUALIFIED_TYPE, so each qualified type exists once. */
unsigned int far pascal ADD_CV_QUALIFIERS(register unsigned int type,unsigned char second,
    unsigned char first)
{
    int row;
    int column;
    register unsigned int qualifiers;
    qualifiers=TB(type,2)&3;
    if(second)
        qualifiers|=2;
    if(first)
        qualifiers|=1;
    if((TB(type,2)&3)==qualifiers)
        return type;
    if((int)T(type,0)<=12) {
        row=(qualifiers&2)?0:1;
        column=(qualifiers&1)?0:1;
        return C9_TYPE_GRID[row][column][T(type,0)];
    }
    return INTERN_QUALIFIED_TYPE(type,qualifiers);
}
/* 18F4 */
/* Returns the unqualified version of type. */
unsigned int far pascal STRIP_CV_QUALIFIERS(register unsigned int type)
{
    if(!((unsigned int)TB(type,2)&3))
        return type;
    if((int)T(type,0)<=12)
        return C9_TYPE_GRID[1][1][T(type,0)];
    return INTERN_QUALIFIED_TYPE(type,0);
}
/* 1931: sparse15-key CS dispatch follows at1B9A. */
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
        if(words->primary!=0x82 || words->sign!=0x82 || words->size!=0x82)
            return 1;
        words->primary=CURRENT_TOKEN;
        ADVANCE_TOKEN();
        if(words->primary==0x44)
            *type=PARSE_ENUM_SPECIFIER();
        else
            *type=PARSE_RECORD_SPECIFIER(words->primary,context==0);
        break;
    }
    return 0;
}
/* 1BD6: genuine eight-byte by-value type-word record. */
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
    return ADD_CV_QUALIFIERS(result,words.changing,words.constant);
}
/* 1CF5 */
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
/* 1D67 */
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
                if(*kind==0x82)
                    *kind=CURRENT_TOKEN;
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
        } else if(CURRENT_TOKEN==TOK_IDENT) {
            result=TYPE_LOOKUP_FAR(CURRENT_TOKEN_VALUE);
            if(words.primary==0x82 && words.sign==0x82 && words.size==0x82) {
                words.primary=0x31;
                *named=1;
                *spec=*(struct C16Spec far *)MK_FP(SYMBOL_POOL_SEG,LOOKUP_NAME(CURRENT_TOKEN_VALUE)+SYM_STORAGE);
                if(result && ((words.constant && (TB(result,2)&1)) ||
                               (words.changing && (TB(result,2)&2))))
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                ADVANCE_TOKEN();
            } else {
                result=0;
                break;
            }
        } else
            REPORT_DIAGNOSTIC(MSG_NOT_LEGAL_HERE,NAME_TEXT_COPY(TOKEN_NAMES[CURRENT_TOKEN]),0L);
    }
    *type=BUILD_BASIC_TYPE(words,*named,result);
}

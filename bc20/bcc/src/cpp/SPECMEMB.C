/* target: ovr167_C132UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: C++ compiler-generated special members (constructors, assignment). Entry points:
   INIT_VECTOR_ELEMENTS, BUILD_SPECIAL_MEMBER_BODY. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the bodies of the special members the compiler declares for a class
   (IMPLMEMB.C declares them; CPPFINAL.C's C13INITIALIZE compiles them when they are
   needed). BUILD_SPECIAL_MEMBER_BODY returns, by SYM_SPECIAL_KIND, the expression that
   forms the whole body:
   - 0 operator=: assign each base and data member from the argument, by its own
     operator= where it has one (arrays of such classes element by element);
   - 1 copy constructor: virtual bases, bases and members initialized from the
     argument's, then the virtual table pointers;
   - 2 default constructor: virtual bases, bases, members default constructed, then
     the virtual table pointers;
   - 3 destructor: BUILD_DESTRUCTOR_BODY.
   The parameters of the function are found by name in the current scope (the function
   body's scope is open): this first, then the virtual-base flag of a constructor of a
   class with virtual bases, then the argument. Most of them read the FORMAL record's
   name word as ES_W(x,SCOPE_NAMES): SCOPE_NAMES and FORMAL_NAME are both offset 4, and
   FORMAL_NAME is what is meant. The functions are written with register
   pseudo-variables (_ES, _BX, _SI, _DI) as in the original; _SI=_SI in
   BUILD_ASSIGN_BODY is a do-nothing statement kept for byte matching.
   Constructors and the assignment end in &this (token 0x1D), which C13INITIALIZE turns
   into the returned value. INIT_VECTOR_ELEMENTS, also used by CPPCTOR.C and CPPINIT.C,
   builds the run-time call that default constructs every element of an array. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- CHECK_MEMBER_CLASS_CALLABLE (listing E8F0) ---- */
#include <dos.h>
extern long far pascal FORMAT_SPECIAL_MEMBER(unsigned int,unsigned int,unsigned int);
extern long far pascal FORMAT_SYMBOL(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,long,long);
extern unsigned char far pascal SYMBOL_ACCESSIBLE(unsigned int,unsigned int);
typedef unsigned int (far pascal *Query)(unsigned int,unsigned char);
/* CHECK_MEMBER_CLASS_CALLABLE: for a base or member of type node that needs a
   constructor (TYPE_ATTRS 4): query (FIND_COPY_CTOR or FIND_COPY_ASSIGN) must find an
   accessible member; mode (5 or 11) names it in MSG_CANNOT_FIND_COPY. Returns 1 when
   all is well. For an array the element type's member is looked up, but the function
   then returns 0 even when it is found (the array path falls into the failure exit),
   so an implicit copy of a class with such an array member fails. */
static unsigned char near pascal CHECK_MEMBER_CLASS_CALLABLE(register unsigned int node,
                                        unsigned int mode,Query query)
{
    register unsigned int result;
    if(!(TYPE_B(node,TYPE_ATTRS)&4)) return 1;
    if(TYPE_W(node,TYPE_KIND)==TK_ARRAY) {
        while(TYPE_W(node,TYPE_KIND)==TK_ARRAY)
            node=TYPE_W(node,TYPE_TARGET);
        result=query(node,1);
        if(!result) REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_COPY,FORMAT_SPECIAL_MEMBER(mode,1,node),0L);
failure:
        return 0;
    }
    result=query(node,0);
    if(result==0) return 1;
    if(!SYMBOL_ACCESSIBLE(result,CURRENT_CLASS_TYPE)) {
        REPORT_DIAGNOSTIC(0xB6,FORMAT_SYMBOL(result),0L);
        goto failure;
    }
    return 1;
}

/* ---- CHECK_COPY_CTOR_MEMBERS (listing E98B) ---- */
#include <dos.h>

extern unsigned int far pascal FIND_COPY_CTOR(unsigned int,unsigned char);
/* CHECK_COPY_CTOR_MEMBERS / CHECK_ASSIGN_MEMBERS: CHECK_MEMBER_CLASS_CALLABLE over
   every base and data member of class node for the copy constructor or operator=;
   1 when the implicit member can be built. */
static unsigned char near pascal CHECK_COPY_CTOR_MEMBERS(unsigned int node)
{
    unsigned char result;
    result=1;
    _BX=node; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG; _DI=ES_W(_BX,TAG_BASES);
    while(_DI!=0) {
        _ES=BASE_LIST_SEG;
        result = result & CHECK_MEMBER_CLASS_CALLABLE(ES_W(_DI,BASE_TYPE),5,FIND_COPY_CTOR);
        _ES=BASE_LIST_SEG; _DI=ES_W(_DI,BASE_NEXT);
    }
    _BX=node; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG; _SI=ES_W(_BX,TAG_MEMBERS);
    while(_SI!=0) {
        _ES=MEMBER_SEGMENT;
        if(ES_B(_SI,MEMB_FLAGS)&3) goto next;
        result = result & CHECK_MEMBER_CLASS_CALLABLE(ES_W(_SI,MEMB_TYPE),5,FIND_COPY_CTOR);
next:
        _ES=MEMBER_SEGMENT; _SI=ES_W(_SI,MEMB_NEXT);
    }
    return result;
}

/* ---- CHECK_ASSIGN_MEMBERS (listing EA28) ---- */
#include <dos.h>

extern unsigned int far pascal FIND_COPY_ASSIGN(unsigned int,unsigned char);
static unsigned char near pascal CHECK_ASSIGN_MEMBERS(unsigned int node)
{
    unsigned char result;
    result=1;
    _BX=node; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG; _DI=ES_W(_BX,TAG_BASES);
    while(_DI!=0) {
        _ES=BASE_LIST_SEG;
        result = result & CHECK_MEMBER_CLASS_CALLABLE(ES_W(_DI,BASE_TYPE),11,FIND_COPY_ASSIGN);
        _ES=BASE_LIST_SEG; _DI=ES_W(_DI,BASE_NEXT);
    }
    _BX=node; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG; _SI=ES_W(_BX,TAG_MEMBERS);
    while(_SI!=0) {
        _ES=MEMBER_SEGMENT;
        if(ES_B(_SI,MEMB_FLAGS)&3) goto next;
        result = result & CHECK_MEMBER_CLASS_CALLABLE(ES_W(_SI,MEMB_TYPE),11,FIND_COPY_ASSIGN);
next:
        _ES=MEMBER_SEGMENT; _SI=ES_W(_SI,MEMB_NEXT);
    }
    return result;
}

/* ---- MAKE_MEMBER_ACCESS (listing EAC5) ---- */
extern unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int, unsigned int, unsigned int);

/* MAKE_MEMBER_ACCESS: second.member, where second is a symbol (a parameter) and first
   a member record. */
static unsigned int near pascal MAKE_MEMBER_ACCESS(unsigned int first, unsigned int second)
{
    return MAKE_BINARY_NODE(0x2F, MAKE_SYMBOL_NODE(second), MAKE_FIELD_REF_NODE(first));
}

/* ---- INIT_VECTOR_ELEMENTS (listing EAE9) ---- */
#include <dos.h>
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern int far pascal DESTRUCTOR_CALL_FLAGS(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_CALL_NODE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
/* INIT_VECTOR_ELEMENTS: the call that default constructs all elements of array value
   of type (nested arrays counted as one): VECTOR_NEW_SYMBOL (VECTOR_VNEW_SYMBOL for a
   class with virtual bases) with (address, element size, count, mode, &constructor),
   where the constructor takes no argument besides this and the hidden flag. A class
   without one gives MSG_CANNOT_FIND_INITIALIZE_225. */
unsigned int far pascal INIT_VECTOR_ELEMENTS(unsigned int value,register unsigned int type)
{
    long product;
    unsigned int member;
    unsigned char flag;
    unsigned int field;
    register unsigned int entry;
    product=1;
    while (TYPE_W(type,TYPE_KIND)==TK_ARRAY) {
        product*=*((long far *)MK_FP(TYPE_POOL,type+TYPE_PARAMS));
        type=TYPE_W(type,TYPE_TARGET);
    }
    flag=(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)!=0;
    member=FIND_MEMBER_BY_NAME(CTOR_NAME,type);
    entry=member==0 ? 0 : MEMBER_W(member,MEMB_VALUE);
    while (entry) {
        field=TYPE_W(SYM_W(entry,SYM_TYPE),TYPE_PARAMS);
        if (flag) field=FORMAL_W(field,FORMAL_NEXT);
        if (FORMAL_W(field,FORMAL_NEXT)==0) break;
        entry=SYM_W(entry,SYM_NEXT_OVERLOAD);
    }
    if (entry==0) return REPORT_EXPR_ERROR(MSG_CANNOT_FIND_INITIALIZE_225,FORMAT_SPECIAL_MEMBER(5,0,type),0L,0);
    return MAKE_CALL_NODE(MAKE_SYMBOL_NODE(flag?VECTOR_VNEW_SYMBOL:VECTOR_NEW_SYMBOL),
        MAKE_CAST_NODE(FAR_VOID_PTR_TYPE,MAKE_UNARY_NODE(0x1D,value)),
        MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(type)),
        MAKE_INT_CONSTANT(INT_TYPE,product),
        MAKE_INT_CONSTANT(INT_TYPE,(long)DESTRUCTOR_CALL_FLAGS(type,entry)),
        MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(entry)));
}

/* ---- COPY_VECTOR_ELEMENTS (listing EC53) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);
/* COPY_VECTOR_ELEMENTS: copies array second into array first element by element,
   with the element class's copy constructor (mode 5) or operator= (mode 11), the
   overload that takes a reference to the class. The node built has EXPR_LEFT
   (void far *)&first and the argument list VECTOR_APPLY_SYMBOL (VECTOR_VAPPLY_SYMBOL
   for a copy constructor of a class with virtual bases), &second, element size, count,
   mode, &function: unlike INIT_VECTOR_ELEMENTS the helper symbol is put at the front
   of the argument list rather than as the callee; how later passes treat this node is
   not shown here. MSG_CANNOT_FIND_COPY when no such member exists. */
static unsigned int near pascal COPY_VECTOR_ELEMENTS(unsigned int mode,unsigned int first,
                                        unsigned int second,register unsigned int type)
{
    long product;
    unsigned char flag;
    unsigned int entry,member,child,result,field;
    register unsigned int node;
    product=1;
    while (TYPE_W(type,TYPE_KIND)==17) {
        product*=*((long far *)MK_FP(TYPE_POOL,type+TYPE_PARAMS));
        type=TYPE_W(type,TYPE_TARGET);
    }
    flag=(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4) && mode==5;
    member=FIND_MEMBER_BY_NAME(TOKEN_NAMES[mode],type);
    node=MEMBER_W(member,MEMB_VALUE);
    while (node) {
        entry=SYM_W(node,SYM_TYPE);
        field=FORMAL_W(TYPE_W(entry,TYPE_PARAMS),FORMAL_NEXT);
        if (flag) field=FORMAL_W(field,FORMAL_NEXT);
        child=FORMAL_W(field,FORMAL_TYPE);
        if (EXPR_FLAGS[TYPE_W(child,TYPE_KIND)]&0x14) {
            if (TYPE_B(child,TYPE_ATTRS)&0x20) {
                if (FORMAL_W(field,FORMAL_NEXT)==0) {
                    if (TYPES_COMPATIBLE(TYPE_W(child,TYPE_TARGET),type,2)) break;
                }
            }
        }
        node=SYM_W(node,SYM_NEXT_OVERLOAD);
    }
    if (node==0) return REPORT_EXPR_ERROR(MSG_CANNOT_FIND_COPY,FORMAT_SPECIAL_MEMBER(mode,1,type),0L,0);
    result=MAKE_CALL_NODE(
        MAKE_CAST_NODE(FAR_VOID_PTR_TYPE,MAKE_UNARY_NODE(0x1D,first)),
        MAKE_CAST_NODE(FAR_VOID_PTR_TYPE,MAKE_UNARY_NODE(0x1D,second)),
        MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(type)),
        MAKE_INT_CONSTANT(INT_TYPE,product),
        MAKE_INT_CONSTANT(INT_TYPE,(long)DESTRUCTOR_CALL_FLAGS(type,node)),
        MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(node)));
    EXPR_W(result,EXPR_RIGHT)=MAKE_LIST_NODE(MAKE_SYMBOL_NODE(flag?VECTOR_VAPPLY_SYMBOL:VECTOR_APPLY_SYMBOL),
                                         EXPR_W(result,EXPR_RIGHT));
    return result;
}

/* ---- BUILD_ASSIGN_BODY (listing EE46) ---- */
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG;
extern unsigned int far pascal FIND_NAME_IN_LIST(unsigned int,unsigned int);
extern unsigned int far pascal BUILD_VBASE_ADDRESS(unsigned int,int,unsigned int);
extern unsigned int far pascal BUILD_BASE_ADDRESS(unsigned int,int,unsigned int);
extern unsigned int far pascal BUILD_SPECIAL_MEMBER_CALL(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
static unsigned int near pascal MAKE_MEMBER_ACCESS(unsigned int first, unsigned int second);
static unsigned int near pascal COPY_VECTOR_ELEMENTS(unsigned int mode,unsigned int first, unsigned int second,register unsigned int type);
/* BUILD_ASSIGN_BODY: the body of the implicit operator= of class type, context being
   its function type: b is this, a the argument. Bases (virtual ones through their
   virtual base pointers) and data members are assigned; plain assignments are
   collected in sum and operator= calls in sum2, which run after them. A member array
   without operator= is copied whole (token 5, initialization). Members flagged with
   exactly one of MEMB_FLAGS 0x20 and 0x80 are skipped (probably hidden members). */
static unsigned int far pascal BUILD_ASSIGN_BODY(unsigned int type,unsigned int context)
{
    unsigned int a,b,sum,sum2,right,left,field;
    unsigned char mask;
    mask=0xA0;
    _BX=context;
    _ES=TYPE_POOL;
    field=ES_W(_BX,TYPE_PARAMS);
    _BX=field;
    _ES=FORMAL_POOL_SEG;
    b=FIND_NAME_IN_LIST(ES_W(_BX,FORMAL_NAME),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    _ES=FORMAL_POOL_SEG;
    _BX=field;
    _BX=ES_W(_BX,FORMAL_NEXT);
    a=FIND_NAME_IN_LIST(ES_W(_BX,FORMAL_NAME),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    sum=0;
    sum2=0;
    _BX=type;
    _ES=TYPE_POOL;
    _BX=ES_W(_BX,TYPE_TAG_BODY);
    _ES=TAG_BODY_POOL_SEG;
    _SI=ES_W(_BX,TAG_BASES);
    while (_SI) {
        _ES=BASE_LIST_SEG;
        if (ES_B(_SI,BASE_VIRTUAL)) {
            left=BUILD_VBASE_ADDRESS(MAKE_SYMBOL_NODE(b),(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_OFFSET)),ES_W(_SI,BASE_TYPE));
            left=MAKE_UNARY_NODE(0x18,left);
            right=BUILD_VBASE_ADDRESS(MAKE_SYMBOL_NODE(a),(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_OFFSET)),ES_W(_SI,BASE_TYPE));
            right=MAKE_UNARY_NODE(0x18,right);
        } else {
            left=BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(b),(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_OFFSET)),ES_W(_SI,BASE_TYPE));
            right=BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(a),(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_OFFSET)),ES_W(_SI,BASE_TYPE));
        }
        _ES=BASE_LIST_SEG;
        _BX=ES_W(_SI,BASE_TYPE);
        _ES=TYPE_POOL;
        if (ES_B(_BX,TYPE_ATTRS)&0x10) sum2=JOIN_COMMA_EXPR(sum2,BUILD_SPECIAL_MEMBER_CALL(0x0B,left,MAKE_LIST_NODE(right,0)));
        else sum=JOIN_COMMA_EXPR(sum,MAKE_BINARY_NODE(0x0B,left,right));
        _ES=BASE_LIST_SEG;
        _SI=ES_W(_SI,BASE_NEXT);
    }
    _BX=type;
    _ES=TYPE_POOL;
    _BX=ES_W(_BX,TYPE_TAG_BODY);
    _ES=TAG_BODY_POOL_SEG;
    _DI=ES_W(_BX,TAG_MEMBERS);
    while (_DI) {
        _ES=MEMBER_SEGMENT;
        if (ES_B(_DI,MEMB_FLAGS)&3) goto next;
        _AL=ES_B(_DI,MEMB_FLAGS)&mask;
        _AH=0;
        if (_AX && (ES_B(_DI,MEMB_FLAGS)&mask)!=mask) goto next;
        left=MAKE_MEMBER_ACCESS(_DI,b);
        right=MAKE_MEMBER_ACCESS(_DI,a);
        _ES=MEMBER_SEGMENT;
        _BX=ES_W(_DI,MEMB_TYPE);
        _ES=TYPE_POOL;
        if (ES_W(_BX,TYPE_KIND)==17) {
            _ES=MEMBER_SEGMENT;
            _BX=ES_W(_DI,MEMB_TYPE);
            _ES=TYPE_POOL;
            if (ES_B(_BX,TYPE_ATTRS)&0x10)
                sum2=JOIN_COMMA_EXPR(sum2,COPY_VECTOR_ELEMENTS(0x0B,left,right,(_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_TYPE))));
            else { sum=JOIN_COMMA_EXPR(sum,MAKE_BINARY_NODE(5,left,right)); _SI=_SI; }
        } else {
            _ES=MEMBER_SEGMENT;
            _BX=ES_W(_DI,MEMB_TYPE);
            _ES=TYPE_POOL;
            if (ES_B(_BX,TYPE_ATTRS)&0x10)
                sum2=JOIN_COMMA_EXPR(sum2,BUILD_SPECIAL_MEMBER_CALL(0x0B,left,MAKE_LIST_NODE(right,0)));
            else sum=JOIN_COMMA_EXPR(sum,MAKE_BINARY_NODE(0x0B,left,right));
        }
next:
        _ES=MEMBER_SEGMENT;
        _DI=ES_W(_DI,MEMB_NEXT);
    }
    return JOIN_COMMA_EXPR(JOIN_COMMA_EXPR(sum,sum2),MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(b)));
}

/* ---- BUILD_COPY_CTOR_BODY (listing F0FD) ---- */
#include <dos.h>
extern unsigned int far pascal BUILD_VBASE_INITS(unsigned int,unsigned int);
extern unsigned int far pascal BUILD_INIT_CALL(unsigned int,unsigned int,unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal BUILD_VPTR_INITS(unsigned int,unsigned int);
/* BUILD_COPY_CTOR_BODY: the body of the implicit copy constructor of class input,
   types being its function type. first is this, extra the virtual-base flag (classes
   with virtual bases only) and second the argument. Virtual bases are built by
   default (BUILD_VBASE_INITS), non-virtual bases and members are initialized from the
   argument's (BUILD_INIT_CALL; arrays of classes with constructors through
   COPY_VECTOR_ELEMENTS), members flagged 0x20 or 0x80 skipped; then the vptr stores. */
static unsigned int far pascal BUILD_COPY_CTOR_BODY(unsigned int input,unsigned int types)
{
    unsigned int second,extra,first,node,member,child,right,left,cursor;
    _BX=types; _ES=TYPE_POOL; cursor=ES_W(_BX,TYPE_PARAMS);
    _BX=cursor; _ES=FORMAL_POOL_SEG;
    first=FIND_NAME_IN_LIST(ES_W(_BX,FORMAL_NAME),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    _ES=FORMAL_POOL_SEG; _BX=cursor; cursor=ES_W(_BX,FORMAL_NEXT);
    _BX=cursor;
    second=FIND_NAME_IN_LIST(ES_W(_BX,FORMAL_NAME),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    _BX=input; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG;
    if(ES_W(_BX,TAG_CLASS_FLAGS)&4) {
        extra=second;
        _ES=FORMAL_POOL_SEG; _BX=cursor; _BX=ES_W(_BX,FORMAL_NEXT);
        second=FIND_NAME_IN_LIST(ES_W(_BX,SCOPE_NAMES),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    } else extra=0;
    _DI=BUILD_VBASE_INITS(extra,0);
    _BX=input; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG; _SI=ES_W(_BX,TAG_BASES);
    while(_SI!=0) {
        _ES=BASE_LIST_SEG;
        if(!ES_B(_SI,BASE_VIRTUAL)) {
            _BX=ES_W(_SI,BASE_TYPE); _ES=TYPE_POOL;
            if(ES_B(_BX,TYPE_ATTRS)&4) left=MAKE_SYMBOL_NODE(first);
            else left=BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(first),(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_OFFSET)),ES_W(_SI,BASE_TYPE));
            right=BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(second),(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_OFFSET)),ES_W(_SI,BASE_TYPE));
            node=BUILD_INIT_CALL(left,(_ES=BASE_LIST_SEG,ES_W(_SI,BASE_TYPE)),MAKE_LIST_NODE(right,0),0,1);
            _DI=JOIN_COMMA_EXPR(_DI,node);
        }
        _ES=BASE_LIST_SEG; _SI=ES_W(_SI,BASE_NEXT);
    }
    _BX=input; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG;
    member=ES_W(_BX,TAG_MEMBERS);
    while(member!=0) {
        _BX=member; _ES=MEMBER_SEGMENT;
        if(ES_B(_BX,MEMB_FLAGS)&3) goto next_member;
        if(!((unsigned int)ES_B(_BX,MEMB_FLAGS)&0xA0)) {
            left=MAKE_MEMBER_ACCESS(member,first);
            right=MAKE_MEMBER_ACCESS(member,second);
            _BX=member; _ES=MEMBER_SEGMENT; child=ES_W(_BX,MEMB_TYPE);
            _BX=child; _ES=TYPE_POOL;
            if((ES_B(_BX,TYPE_ATTRS)&4) && ES_W(_BX,TYPE_KIND)==17)
                _DI=JOIN_COMMA_EXPR(_DI,COPY_VECTOR_ELEMENTS(5,left,right,child));
            else _DI=JOIN_COMMA_EXPR(_DI,BUILD_INIT_CALL(left,child,MAKE_LIST_NODE(right,0),0,0));
        }
next_member:
        _ES=MEMBER_SEGMENT; _BX=member; member=ES_W(_BX,MEMB_NEXT);
    }
    _DI=JOIN_COMMA_EXPR(_DI,BUILD_VPTR_INITS(first,input));
    return _DI=JOIN_COMMA_EXPR(_DI,MAKE_UNARY_NODE(29,MAKE_SYMBOL_NODE(first)));
}

/* ---- BUILD_DEFAULT_CTOR_BODY (listing F34F) ---- */
#include <dos.h>
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal BUILD_BASE_INITS(unsigned char,unsigned int);
extern unsigned int far pascal BUILD_MEMBER_INITS(unsigned int);
/* BUILD_DEFAULT_CTOR_BODY: the body of the implicit default constructor of class
   node: virtual bases (guarded by the flag parameter second; BUILD_VBASE_INITS already
   adds the same guard, so it is tested twice), bases and members by their default
   constructors, then the vptr stores. */
static unsigned int far pascal BUILD_DEFAULT_CTOR_BODY(unsigned int node,unsigned int other)
{
    unsigned int first,second;
    register unsigned int result,link;
    link=TYPE_W(other,TYPE_PARAMS);
    first=FIND_NAME_IN_LIST(FORMAL_W(link,FORMAL_NAME),SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    if(TAG_W(TYPE_W(node,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)
        second=FIND_NAME_IN_LIST(FORMAL_W(FORMAL_W(link,FORMAL_NEXT),FORMAL_NAME),
                       SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    else second=0;
    result=BUILD_VBASE_INITS(second,0);
    if(result) result=MAKE_CONDITIONAL_NODE(0x6B,MAKE_SYMBOL_NODE(second),
                                  MAKE_INT_CONSTANT(INT_TYPE,0L),result);
    result=JOIN_COMMA_EXPR(result,BUILD_BASE_INITS(0,0));
    result=JOIN_COMMA_EXPR(result,BUILD_MEMBER_INITS(0));
    result=JOIN_COMMA_EXPR(result,BUILD_VPTR_INITS(first,node));
    return result=JOIN_COMMA_EXPR(result,MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(first)));
}

/* ---- BUILD_IMPLICIT_DESTRUCTOR (listing F44D) ---- */
#include <dos.h>
extern unsigned int far pascal BUILD_DESTRUCTOR_BODY(unsigned int,unsigned int,unsigned char,unsigned int);
/* BUILD_IMPLICIT_DESTRUCTOR: the body of the implicit destructor of class first:
   BUILD_DESTRUCTOR_BODY with this (value1) and the flags parameter (value2), guarded
   by this != 0. */
static unsigned int far pascal BUILD_IMPLICIT_DESTRUCTOR(unsigned int first,unsigned int second)
{
    unsigned int value1,value2;
    register unsigned int node;
    _BX=second;
    _ES=TYPE_POOL;
    node=ES_W(_BX,TYPE_PARAMS);
    _ES=FORMAL_POOL_SEG;
    value1=FIND_NAME_IN_LIST(ES_W(node,SCOPE_NAMES),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    _ES=FORMAL_POOL_SEG;
    _BX=ES_W(node,FORMAL_NEXT);
    value2=FIND_NAME_IN_LIST(ES_W(_BX,SCOPE_NAMES),(_BX=CURRENT_SCOPE,_ES=SCOPE_POOL_SEG,ES_W(_BX,SCOPE_NAMES)));
    return BUILD_DESTRUCTOR_BODY(first,value1,1,value2);
}

/* ---- BUILD_SPECIAL_MEMBER_BODY (listing F4B2) ---- */
/* Public: overlay stub 0DB1:0025 is CD 3F C2 0B = entry 0x0BC2, i.e. this function. */
/* Returns the result of BUILD_ASSIGN_BODY, BUILD_COPY_CTOR_BODY, BUILD_DEFAULT_CTOR_BODY,
   BUILD_IMPLICIT_DESTRUCTOR or REPORT_EXPR_ERROR_PLAIN (CPPFINAL.C uses it). (This note
   named the last three by old numbers 132/133/134 before.) */
#include <dos.h>
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);

/* BUILD_SPECIAL_MEMBER_BODY: the body expression of implicit special member node (see
   the overview). When a needed base or member function is missing or inaccessible the
   error has been reported and an error node is returned. */
unsigned int far pascal BUILD_SPECIAL_MEMBER_BODY(register unsigned int node)
{
    register unsigned int type;

    type=SYM_W(SYM_W(node,SYM_OWNER_CLASS),SYM_TYPE);
    switch(SYM_W(node,SYM_SPECIAL_KIND)) {
    case 0:
        return CHECK_ASSIGN_MEMBERS(type) ? BUILD_ASSIGN_BODY(type,SYM_W(node,SYM_TYPE)) : REPORT_EXPR_ERROR_PLAIN(0,0);
    case 1:
        return CHECK_COPY_CTOR_MEMBERS(type) ? BUILD_COPY_CTOR_BODY(type,SYM_W(node,SYM_TYPE)) : REPORT_EXPR_ERROR_PLAIN(0,0);
    case 2:
        return BUILD_DEFAULT_CTOR_BODY(type,SYM_W(node,SYM_TYPE));
    case 3:
        return BUILD_IMPLICIT_DESTRUCTOR(type,SYM_W(node,SYM_TYPE));
    }
    return 0;
}

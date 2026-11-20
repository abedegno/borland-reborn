/* target: ovr077_C230UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: C++ expressions: class assignment, initialization and return checks, member
   selection and .*, member-pointer comparison, new and delete expressions. Entry points:
   CHECK_CPP_ASSIGNMENT, CHECK_CPP_INITIALIZATION, CHECK_CPP_RETURN_VALUE,
   ANALYZE_MEMBER_SELECT, ANALYZE_DOT_STAR, COMPARE_MEMBER_POINTERS, ANALYZE_NEW_EXPRESSION,
   ANALYZE_DELETE_EXPRESSION. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: C++ checks of expression analysis, called by the C checks in expr/ when
   a class, reference or pointer to member is involved.
   - CHECK_CPP_ASSIGNMENT, CHECK_CPP_INITIALIZATION (operator 0x47, T x = y) and
     CHECK_CPP_RETURN_VALUE convert the right side to the target type: derived to base,
     conversion functions, constructors, reference binding (to the object itself or to
     a temporary), and run temporaries' destructors after a return value is computed.
   - ANALYZE_MEMBER_SELECT resolves the member name of a '.' node (a -> has already been
     turned into '.' on *p) in the object's class and its bases, with access checks;
     ANALYZE_DOT_STAR handles .* with a pointer to member.
   - COMPARE_MEMBER_POINTERS compares pointers to members field by field.
   - ANALYZE_NEW_EXPRESSION and ANALYZE_DELETE_EXPRESSION expand new and delete into
     calls of operator new/delete, constructors, destructors and the run-time vector
     helpers (VECTOR_NEW_SYMBOL, VECTOR_VNEW_SYMBOL, VECTOR_DELETE_SYMBOL).
   Expression operators met here: 1 symbol, 0x36 call, 0x47 initialization, 0x48
   pointer-to-member constant, 0x4A member node (EXPR_LEFT a member record). Node flag
   0x20 is set by MAKE_UNARY_NODE/MAKE_BINARY_NODE; on new and delete nodes it is clear
   for ::new and ::delete, probably. Token codes used to build nodes: 5 initialization,
   0x0B '=', 0x17 '-', 0x18 '*', 0x1D address-of, 0x23 probably '&&', 0x24 probably
   '==', 0x2A '!', 0x2F '.'; MAKE_CONDITIONAL_NODE(0x6B, c, a, b) is c ? a : b.
   A pointer to data member is the member offset plus 1 (0 is the null pointer); a
   pointer to member function is the struct MEMBER_PTR_CLASS_TYPE (delta, vindex,
   offset, pad fields). */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- CHECK_CPP_ASSIGNMENT (listing 6DE0) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);
extern unsigned int far pascal CONVERT_DERIVED_TO_BASE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_DEREFERENCE(unsigned int);
extern unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern long far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_AT(unsigned int,long,long,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *);
extern unsigned int far pascal UNPACK_EXPR_TREE(unsigned int);
extern unsigned int far pascal BUILD_THIS_NODE(unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
/* CHECK_CPP_ASSIGNMENT: finishes assignment node (EXPR_TYPE the left side's type):
   converts a derived class object on the right to the base on the left, applies a
   conversion function when a scalar is assigned from a class (mask 7), checks
   compatibility (MSG_CANNOT_ASSIGN) and warns when an enum gets another type. The
   right side is converted to the left's type (passing the left side as target unless
   the class has a destructor or assignment flag 8/0x10), and ELIDE_COPY_ASSIGN may
   rewrite the whole node. In an old-style constructor that assigns to this
   (CTOR_CHECK_THIS_ASSIGN), an assignment to this is noted (CTOR_THIS_ASSIGNED, a
   warning unless node flag 0x10) and the saved member initializations
   (PACKED_INIT_EXPR) are run after it if this is not 0: (this = e, this ? init : 0,
   this). */
unsigned int far pascal CHECK_CPP_ASSIGNMENT(unsigned int node)
{
    unsigned int rtype;
    unsigned int left;
    register unsigned int type;
    register unsigned int tmp;
    type=EXPR_W(node,EXPR_TYPE);
    rtype=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    if(IS_BASE_CLASS(type,rtype,1) && !TYPES_COMPATIBLE(type,rtype,1)) {
        tmp=MAKE_ADDRESS_OF(EXPR_W(node,EXPR_RIGHT));
        tmp=CONVERT_DERIVED_TO_BASE(tmp,rtype,0,type,0,0);
        EXPR_W(node,EXPR_RIGHT)=MAKE_DEREFERENCE(ANALYZE_EXPRESSION(tmp,0,0));
    }
    if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&7) && (EXPR_FLAGS[TYPE_W(rtype,TYPE_KIND)]&0x40)) {
        EXPR_W(node,EXPR_RIGHT)=APPLY_CONVERSION_FUNCTION(EXPR_W(node,EXPR_RIGHT),7,type);
        rtype=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    }
    if(!(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && !C7_TYPE_COMPAT(type,rtype,0))
        return REPORT_EXPR_ERROR(MSG_CANNOT_ASSIGN,FORMAT_TYPE(rtype),FORMAT_TYPE(type),node);
    if(TYPE_W(type,TYPE_KIND)==TK_ENUM && !TYPES_COMPATIBLE(type,rtype,1))
        REPORT_DIAGNOSTIC_AT(MSG_ASSIGNING,FORMAT_TYPE(rtype),FORMAT_TYPE(type),EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
    tmp=EXPR_W(node,EXPR_LEFT);
    if((TYPE_B(type,TYPE_ATTRS)&8) || (TYPE_B(type,TYPE_ATTRS)&0x10)) tmp=0;
    EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,EXPR_W(node,EXPR_RIGHT),tmp);
    if(ELIDE_COPY_ASSIGN(&node)) return node;
    left=EXPR_W(node,EXPR_LEFT);
    if(CTOR_CHECK_THIS_ASSIGN && EXPR_W(left,EXPR_OP)==1 && EXPR_W(left,EXPR_LEFT)==CTOR_THIS_SYMBOL) {
        if(!(EXPR_B(node,EXPR_NODE_FLAGS)&0x10)) REPORT_DIAGNOSTIC_AT(MSG_ASSIGNMENT_THIS,0L,0L,EXPR_W(left,EXPR_SRC_LINE),0);
        CTOR_THIS_ASSIGNED=1;
        if(PACKED_INIT_EXPR) {
            tmp=UNPACK_EXPR_TREE(PACKED_INIT_EXPR);
            if(tmp) tmp=MAKE_CONDITIONAL_NODE(0x6B,BUILD_THIS_NODE(CTOR_THIS_SYMBOL),tmp,MAKE_INT_CONSTANT(INT_TYPE,0L));
            node=JOIN_COMMA_EXPR(node,tmp);
            node=JOIN_COMMA_EXPR(node,MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL));
            CTOR_CHECK_THIS_ASSIGN=0;
            node=ANALYZE_EXPRESSION(node,0,0);
            CTOR_CHECK_THIS_ASSIGN=1;
        }
    }
    return node;
}

/* ---- CHECK_CPP_INITIALIZATION (listing 705E) ---- */
struct C21Location { unsigned int first,second,third; };
extern unsigned int far pascal FIND_USER_CONVERSION(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(unsigned int);
extern unsigned int far pascal MAKE_REFERENCE(unsigned int);
extern unsigned int far pascal DEREF_REFERENCE_EXPR(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned char far pascal IS_NAMED_OBJECT_EXPR(unsigned int);
extern unsigned char far pascal IS_BIT_FIELD_NODE(unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern long far pascal CLASS_NAME_OF_TYPE(unsigned int);
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal FIND_COPY_CTOR(unsigned int,unsigned char);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
#define LOCATION(n) (*(struct C21Location far *)MK_FP(EXPR_POOL_SEG,(n)+20))
/* CHECK_CPP_INITIALIZATION: finishes initialization node (operator 0x47; EXPR_LEFT
   the object, EXPR_RIGHT the value, EXPR_TYPE the object's type).
   A reference is bound like this: compatible pointer value: plain assignment; an lvalue
   (not a bit field) of the referred type or a class derived from it: its address; a
   reference member may not be bound to a parameter (MSG_REFERENCE_MEMBER) nor to a
   temporary (MSG_REFERENCE_MEMBER_NEEDS); otherwise a local temporary initialized from
   the value is made and bound, with MSG_TEMPORARY_USED for a reference to non-const.
   When FIND_USER_CONVERSION picks a constructor, the node becomes a constructor call
   through TRY_BINARY_OPERATOR_CALL, except when the value is a call result (op 0x36)
   of the same class or a derived one and the class has a copy constructor: that
   value is copied like an assignment instead. Otherwise the node is checked like an
   assignment (operator EOP_ASSIGN) and ELIDE_COPY_ASSIGN may simplify it. */
unsigned int far pascal CHECK_CPP_INITIALIZATION(unsigned int node)
{
    unsigned int rtype;
    unsigned int item;
    unsigned int temp;
    register unsigned int type;
    register unsigned int right;
    type=EXPR_W(node,EXPR_TYPE);
    right=EXPR_W(node,EXPR_RIGHT);
    rtype=EXPR_W(right,EXPR_TYPE);
    if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20)) {
        EXPR_W(node,EXPR_OP)=EOP_ASSIGN;
        EXPR_W(node,EXPR_RIGHT)=right=APPLY_CONVERSION_FUNCTION(right,0,type);
        rtype=EXPR_W(right,EXPR_TYPE);
        if(C7_TYPE_COMPAT(type,rtype,0)) return node;
        right=REWRITE_FOR_REFERENCE_BIND(right);
        if(TYPE_W(rtype,TYPE_KIND)==TK_ARRAY && TYPE_L(rtype,TYPE_ARRAY_COUNT)==0 && TYPE_SIZE(TYPE_W(type,TYPE_TARGET)))
            return REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE,FORMAT_TYPE(type),FORMAT_TYPE(rtype),node);
        if((IS_LVALUE(right) || IS_NAMED_OBJECT_EXPR(right)) && !IS_BIT_FIELD_NODE(right) &&
           (TYPES_COMPATIBLE(TYPE_W(type,TYPE_TARGET),rtype,1) || IS_BASE_CLASS(TYPE_W(type,TYPE_TARGET),rtype,1))) {
            if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==EOP_DOT && EXPR_W(right,EXPR_OP)==1 && (SYM_B(EXPR_W(right,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==6)
                return REPORT_EXPR_ERROR(MSG_REFERENCE_MEMBER,(long)NAME_TEXT_COPY(EXPR_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_RIGHT),EXPR_MEMBER_NAME)),0L,node);
            right=MAKE_REFERENCE(MAKE_ADDRESS_OF(right));
            EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,right,EXPR_W(node,EXPR_LEFT));
            return node;
        }
        EXPR_W(node,EXPR_RIGHT)=right=DEREF_REFERENCE_EXPR(right);
        if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==EOP_DOT)
            return REPORT_EXPR_ERROR(MSG_REFERENCE_MEMBER_NEEDS,(long)NAME_TEXT_COPY(EXPR_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_RIGHT),EXPR_MEMBER_NAME)),0L,node);
        if((EXPR_FLAGS[TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)]&0x40) && (TAG_W(TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x80))
            return REPORT_EXPR_ERROR(MSG_CANNOT_CREATE_VARIABLE,CLASS_NAME_OF_TYPE(TYPE_W(type,TYPE_TARGET)),0L,node);
        if(IS_LVALUE(right) && !(TYPE_B(TYPE_W(type,TYPE_TARGET),TYPE_ATTRS)&1))
            REPORT_DIAGNOSTIC_AT(MSG_TEMPORARY_USED,(long)(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==1 ? SYMBOL_NAME_TEXT(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT)) : (char far *)STR_REFERENCE),
                0L,EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
        item=CREATE_LOCAL_TEMP(TYPE_W(type,TYPE_TARGET));
        temp=MAKE_BINARY_NODE(5,EXPR_W(node,EXPR_LEFT),MAKE_SYMBOL_NODE(item));
        LOCATION(temp)=LOCATION(EXPR_W(node,EXPR_LEFT));
        EXPR_W(node,EXPR_LEFT)=MAKE_SYMBOL_NODE(item);
        EXPR_B(node,EXPR_NODE_FLAGS)&=0xFE;
        EXPR_W(node,EXPR_OP)=0x47;
        return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(node,temp),0,0);
    }
    EXPR_W(node,EXPR_RIGHT)=right=DEREF_REFERENCE_EXPR(right);
    rtype=EXPR_W(right,EXPR_TYPE);
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_ENUM && !TYPES_COMPATIBLE(type,rtype,1))
        REPORT_DIAGNOSTIC_AT(MSG_INITIALIZING,FORMAT_TYPE(type),FORMAT_TYPE(rtype),EXPR_W(node,EXPR_SRC_LINE),0);
    item=FIND_USER_CONVERSION(type,rtype,1,EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
    if(item && SYM_W(item,SYM_FUNC_KIND)==3 &&
       ((EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_OP)!=0x36 && (!FIND_COPY_CTOR(type,0) || IS_LVALUE(EXPR_W(node,EXPR_RIGHT)) || IS_NAMED_OBJECT_EXPR(EXPR_W(node,EXPR_RIGHT)))) ||
        (TYPES_COMPATIBLE(type,rtype,2)==0 && IS_BASE_CLASS(type,rtype,1)==0)) &&
       TRY_BINARY_OPERATOR_CALL(&node,0,0))
        return node;
    if(IS_BASE_CLASS(type,rtype,1)) {
        temp=MAKE_ADDRESS_OF(EXPR_W(node,EXPR_RIGHT));
        temp=CONVERT_DERIVED_TO_BASE(temp,rtype,0,type,0,0);
        EXPR_W(node,EXPR_RIGHT)=MAKE_DEREFERENCE(ANALYZE_EXPRESSION(temp,0,0));
    }
    EXPR_W(node,EXPR_OP)=EOP_ASSIGN;
    if((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&7) && (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x40)) {
        EXPR_W(node,EXPR_RIGHT)=APPLY_CONVERSION_FUNCTION(EXPR_W(node,EXPR_RIGHT),7,type);
        rtype=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    }
    if(TYPE_W(type,TYPE_KIND)==TK_FUNCTION || (!(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && !C7_TYPE_COMPAT(type,rtype,0)))
        return REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE,FORMAT_TYPE(type),FORMAT_TYPE(rtype),node);
    EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,NODE_ENUM_TO_INT(EXPR_W(node,EXPR_RIGHT)),EXPR_W(node,EXPR_LEFT));
    ELIDE_COPY_ASSIGN(&node);
    return node;
}
#undef LOCATION

/* ---- CHECK_CPP_RETURN_VALUE (listing 7584) ---- */
extern unsigned int SCOPE_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal BUILD_CONSTRUCTOR_CALL(unsigned int,unsigned int,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
#define SCOPE_WORD(o) (*(unsigned int far *)MK_FP(SCOPE_POOL_SEG,CURRENT_SCOPE+(o)))
/* CHECK_CPP_RETURN_VALUE: finishes the return of a value: node is an assignment-like
   node whose EXPR_TYPE is the function's return type, EXPR_LEFT the place for a class
   result (0 when none) and EXPR_RIGHT the value; scope is the temporary-destructor list
   position at the function's start, so BUILD_TEMP_DESTRUCTORS adds the destructor calls
   of everything newer. A reference result must be an lvalue that is not a local
   (storage class 5) or a named object (MSG_ATTEMPTING_RETURN, _301). A class result is
   built with ELIDE_COPY_ASSIGN, a conversion function, or a constructor call on the
   result place. When destructors must run after a scalar value is computed, the value
   is first saved in a temporary: (tmp = value, destructors, tmp). */
unsigned int far pascal CHECK_CPP_RETURN_VALUE(unsigned int node,unsigned int scope)
{
    unsigned int temp;
    unsigned int rtype;
    unsigned int item;
    unsigned int extra;
    register unsigned int type;
    register unsigned int right;
    type=EXPR_W(node,EXPR_TYPE);
    right=EXPR_W(node,EXPR_RIGHT);
    rtype=EXPR_W(right,EXPR_TYPE);
    if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20)) {
        EXPR_W(node,EXPR_RIGHT)=right=APPLY_CONVERSION_FUNCTION(right,0,type);
        rtype=EXPR_W(right,EXPR_TYPE);
    }
    if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20) && !C7_TYPE_COMPAT(type,rtype,0)) {
        right=REWRITE_FOR_REFERENCE_BIND(DEREF_REFERENCE_EXPR(right));
        if(!IS_LVALUE(right)) return REPORT_EXPR_ERROR_PLAIN(MSG_VARIABLE_NAME_EXPECTED,node);
        temp=right;
        while(EXPR_W(temp,EXPR_OP)==EOP_COMMA) temp=EXPR_W(temp,EXPR_RIGHT);
        if(IS_NAMED_OBJECT_EXPR(right)) return REPORT_EXPR_ERROR_PLAIN(MSG_ATTEMPTING_RETURN_301,node);
        if(EXPR_W(temp,EXPR_OP)==1 && (SYM_B(EXPR_W(temp,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==5)
            return REPORT_EXPR_ERROR(MSG_ATTEMPTING_RETURN,(long)SYMBOL_NAME_TEXT(EXPR_W(temp,EXPR_LEFT)),0L,node);
        if(TYPES_COMPATIBLE(TYPE_W(type,TYPE_TARGET),rtype,1) ||
           ((EXPR_FLAGS[TYPE_W(rtype,TYPE_KIND)]&0x14) && C7_TYPE_COMPAT(TYPE_W(type,TYPE_TARGET),rtype,0)) ||
           IS_BASE_CLASS(TYPE_W(type,TYPE_TARGET),rtype,1))
            EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,MAKE_REFERENCE(MAKE_ADDRESS_OF(right)),0);
        else return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_TYPE_DOES,node);
    } else {
        if(!((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20))) {
            EXPR_W(node,EXPR_RIGHT)=right=CONVERT_TO_RVALUE(EXPR_W(node,EXPR_RIGHT));
            rtype=EXPR_W(right,EXPR_TYPE);
        }
        if(TYPE_W(type,TYPE_KIND)==TK_ENUM && !TYPES_COMPATIBLE(rtype,type,1))
            REPORT_DIAGNOSTIC_AT(MSG_INITIALIZING,FORMAT_TYPE(type),FORMAT_TYPE(rtype),EXPR_W(node,EXPR_SRC_LINE),0);
        if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) || (EXPR_FLAGS[TYPE_W(rtype,TYPE_KIND)]&0x40)) {
            if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&7) && (EXPR_FLAGS[TYPE_W(rtype,TYPE_KIND)]&0x40))
                right=APPLY_CONVERSION_FUNCTION(right,7,type);
            else {
                if(ELIDE_COPY_ASSIGN(&node)) {
                    node=JOIN_COMMA_EXPR(node,BUILD_TEMP_DESTRUCTORS(SCOPE_WORD(0x10),scope));
                    return ANALYZE_EXPRESSION(node,0,0);
                }
                item=FIND_USER_CONVERSION(type,rtype,1,EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
                if(item && SYM_W(item,SYM_FUNC_KIND)!=3)
                    right=CONVERT_EXPR_TO_TYPE(type,right,EXPR_W(node,EXPR_LEFT));
                else if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && (TYPE_B(type,TYPE_ATTRS)&4)) {
                    temp=BUILD_CONSTRUCTOR_CALL(EXPR_W(node,EXPR_LEFT),type,MAKE_LIST_NODE(right,0));
                    FREE_EXPR_NODE(node);
                    temp=JOIN_COMMA_EXPR(temp,BUILD_TEMP_DESTRUCTORS(SCOPE_WORD(0x10),scope));
                    return ANALYZE_EXPRESSION(temp,0,0);
                }
            }
        }
        if(TYPE_W(type,TYPE_KIND)!=TK_VOID && !C7_TYPE_COMPAT(type,EXPR_W(right,EXPR_TYPE),0))
            return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_TYPE_DOES,node);
        EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,right,EXPR_W(node,EXPR_LEFT));
    }
    EXPR_W(node,EXPR_OP)=EOP_ASSIGN;
    if(EXPR_W(node,EXPR_LEFT)==0) {
        temp=node;
        node=EXPR_W(node,EXPR_RIGHT);
        FREE_EXPR_NODE(temp);
    } else ELIDE_COPY_ASSIGN(&node);
    extra=BUILD_TEMP_DESTRUCTORS(SCOPE_WORD(0x10),scope);
    if(extra) {
        if(!(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && EXPR_W(node,EXPR_OP)!=EOP_ASSIGN) {
            unsigned int info;
            unsigned int added;
            info=CREATE_LOCAL_TEMP(EXPR_W(node,EXPR_TYPE));
            added=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(info),node);
            added=JOIN_COMMA_EXPR(added,extra);
            node=JOIN_COMMA_EXPR(added,MAKE_SYMBOL_NODE(info));
        } else node=JOIN_COMMA_EXPR(node,extra);
        node=ANALYZE_EXPRESSION(node,type,0);
    }
    return node;
}
#undef SCOPE_WORD

/* ---- RESOLVE_CONVERSION_MEMBER (listing 79E7) ---- */
extern unsigned int far pascal CREATE_TYPE(unsigned int);
extern char far * far pascal FORMAT_MEMBER_NAME(unsigned int,unsigned int,unsigned int,unsigned int);
#define LOCATION(n) (*(struct C21Location far *)MK_FP(EXPR_POOL_SEG,(n)+20))
/* RESOLVE_CONVERSION_MEMBER: object.operator T: the member name node (name kind 2)
   names a conversion function. Finds it with FIND_USER_CONVERSION from the class
   (EXPR_SCOPE_CLASS of the name node) to T (EXPR_RIGHT of the name node, else the
   left side's type) and puts a symbol node for it on the right of node; reports
   MSG_NOT_MEMBER when there is none. */
static unsigned int far pascal RESOLVE_CONVERSION_MEMBER(unsigned int node)
{
    unsigned int item;
    unsigned int type;
    unsigned int pointer;
    register unsigned int right;
    register unsigned int result;
    right=EXPR_W(node,EXPR_RIGHT);
    type=EXPR_W(right,EXPR_RIGHT)==0 ? EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE) : EXPR_W(right,EXPR_RIGHT);
    item=FIND_USER_CONVERSION(EXPR_W(right,EXPR_SCOPE_CLASS),type,1,EXPR_W(right,EXPR_SRC_LINE),EXPR_W(right,EXPR_SRC_WORD3));
    if(!item || SYM_W(item,SYM_FUNC_KIND)!=2) {
        pointer=CREATE_TYPE(0x12);
        TYPE_W(pointer,TYPE_TARGET)=EXPR_W(right,EXPR_SCOPE_CLASS);
        return REPORT_EXPR_ERROR(MSG_NOT_MEMBER,(long)FORMAT_MEMBER_NAME(EXPR_W(right,EXPR_LEFT),EXPR_W(right,EXPR_NAME_KIND),pointer,type),CLASS_NAME_OF_TYPE(type),node);
    }
    result=MAKE_SYMBOL_NODE(item);
    LOCATION(result)=LOCATION(right);
    EXPR_W(result,EXPR_TYPE)=SYM_W(item,SYM_TYPE);
    EXPR_W(result,EXPR_SCOPE_CLASS)=EXPR_W(right,EXPR_RIGHT);
    EXPR_B(result,EXPR_NODE_FLAGS)|=1;
    FREE_EXPR_NODE(right);
    EXPR_W(node,EXPR_RIGHT)=result;
    return node;
}
#undef LOCATION

/* ---- ANALYZE_MEMBER_SELECT (listing 7AF8) ---- */
extern unsigned int far pascal RESOLVE_SYMBOL_REFERENCE(unsigned int,unsigned int);
extern void far pascal FIND_MEMBER_IN_BASES(unsigned int,unsigned int,unsigned int far *,unsigned int far *,unsigned int far *);
extern long far pascal FORMAT_MEMBER(unsigned int);
extern unsigned char far pascal IS_UNIQUE_BASE(unsigned int,unsigned int);
extern unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int);
extern unsigned int far pascal MAKE_MEMBER_NODE(unsigned int,struct C21Location);
extern unsigned int far pascal ADD_CV_QUALIFIERS(unsigned int,unsigned char,unsigned char);
extern void far pascal FREE_EXPR_TREE(unsigned int);
#define LOCATION(n) (*(struct C21Location far *)MK_FP(EXPR_POOL_SEG,(n)+20))
/* ANALYZE_MEMBER_SELECT: finishes a '.' node: EXPR_LEFT is the object, EXPR_RIGHT a
   member-name node (or an already found member node, op 0x4A, or a symbol). Looks the
   name up in the class or in the qualifying class X of obj.X::m (which must be a base,
   and unique unless the member is a constructor), checks ambiguity and access (except
   for overloaded functions, checked later). Then by member kind:
   0 data member: converts the object to the declaring base class if needed and makes
     a member node whose type carries the object's const/volatile; with mode set, a
     qualified name used for its address (node flag 2) gives a bare field reference
     (for &X::m);
   1 enumerator: an int constant; 2 static member: a symbol node; 3 member function: a
     symbol node on the right of the '.', qualified by X when given. */
unsigned int far pascal ANALYZE_MEMBER_SELECT(register unsigned int node,unsigned char mode)
{
    unsigned int member;
    unsigned int left;
    unsigned int ltype;
    unsigned int bad;
    unsigned int access;
    unsigned int qualifier;
    unsigned int scope;
    unsigned int result;
    register unsigned int right;
    member=0;
    right=EXPR_W(node,EXPR_RIGHT);
    left=EXPR_W(node,EXPR_LEFT);
    ltype=EXPR_W(left,EXPR_TYPE);
    bad=0;
    qualifier=0;
    if(EXPR_W(right,EXPR_OP)==0) return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(EXPR_W(right,EXPR_OP)==1) {
        EXPR_W(node,EXPR_RIGHT)=RESOLVE_SYMBOL_REFERENCE(EXPR_W(node,EXPR_RIGHT),0);
        return node;
    }
    if(EXPR_W(right,EXPR_OP)==0x4A) {
        qualifier=EXPR_W(right,EXPR_RIGHT);
        scope=ltype;
        member=EXPR_W(right,EXPR_LEFT);
    } else {
        if(EXPR_W(right,EXPR_NAME_KIND)==2) return RESOLVE_CONVERSION_MEMBER(node);
        qualifier=EXPR_W(right,EXPR_RIGHT);
        scope=qualifier==0 ? ltype : qualifier;
        FIND_MEMBER_IN_BASES(EXPR_W(right,EXPR_LEFT),scope,&bad,&member,&access);
        if(bad)
            return REPORT_EXPR_ERROR(MSG_FIELD_AMBIGUOUS,(long)FORMAT_MEMBER_NAME(EXPR_W(right,EXPR_LEFT),EXPR_W(right,EXPR_NAME_KIND),0,scope),CLASS_NAME_OF_TYPE(bad),right);
        if(!member)
            return REPORT_EXPR_ERROR(MSG_NOT_MEMBER,(long)FORMAT_MEMBER_NAME(EXPR_W(right,EXPR_LEFT),EXPR_W(right,EXPR_NAME_KIND),0,scope),CLASS_NAME_OF_TYPE(scope),right);
    }
    if(qualifier && !IS_BASE_CLASS(qualifier,ltype,0))
        return REPORT_EXPR_ERROR(MSG_NOT_BASE_CLASS,CLASS_NAME_OF_TYPE(qualifier),CLASS_NAME_OF_TYPE(ltype),node);
    if(qualifier && !IS_UNIQUE_BASE(qualifier,ltype) &&
       !((MEMBER_B(member,MEMB_FLAGS)&3)==3 && SYM_W(MEMBER_W(member,MEMB_VALUE),SYM_FUNC_KIND)==3))
        return REPORT_EXPR_ERROR(MSG_FIELD_AMBIGUOUS,FORMAT_MEMBER(member),CLASS_NAME_OF_TYPE(ltype),node);
    if(!((MEMBER_B(member,MEMB_FLAGS)&3)==3 && SYM_W(MEMBER_W(member,MEMB_VALUE),SYM_NEXT_OVERLOAD)) && !MEMBER_ACCESSIBLE(member,ltype))
        return REPORT_EXPR_ERROR(0xB6,FORMAT_MEMBER(member),0L,node);
    switch(MEMBER_B(member,MEMB_FLAGS)&3) {
    case 0:
        if(mode && (EXPR_B(node,EXPR_NODE_FLAGS)&2) && qualifier) {
            result=MAKE_FIELD_REF_NODE(member);
            EXPR_W(result,EXPR_RIGHT)=qualifier;
            EXPR_W(result,EXPR_TYPE)=MEMBER_W(member,MEMB_TYPE);
            LOCATION(result)=LOCATION(right);
            EXPR_B(result,EXPR_NODE_FLAGS)|=1;
            FREE_EXPR_TREE(node);
            return result;
        }
        if(TYPE_W(MEMBER_W(member,MEMB_CLASS),TYPE_TAG_BODY)!=TYPE_W(ltype,TYPE_TAG_BODY)) {
            left=CONVERT_DERIVED_TO_BASE(MAKE_ADDRESS_OF(left),ltype,qualifier,MEMBER_W(member,MEMB_CLASS),0,0);
            EXPR_W(node,EXPR_LEFT)=MAKE_DEREFERENCE(left);
        }
        EXPR_W(node,EXPR_RIGHT)=MAKE_MEMBER_NODE(member,LOCATION(right));
        EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE)=ADD_CV_QUALIFIERS(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),(TYPE_B(ltype,TYPE_ATTRS)&2)!=0,(TYPE_B(ltype,TYPE_ATTRS)&1)!=0);
        break;
    case 1:
        result=MAKE_INT_CONSTANT(MEMBER_W(member,MEMB_TYPE),(int)MEMBER_W(member,MEMB_VALUE));
        FREE_EXPR_TREE(node);
        return result;
    case 2:
    case 3:
        result=MAKE_SYMBOL_NODE(MEMBER_W(member,MEMB_VALUE));
        LOCATION(result)=LOCATION(right);
        EXPR_W(result,EXPR_TYPE)=SYM_W(MEMBER_W(member,MEMB_VALUE),SYM_TYPE);
        EXPR_W(result,EXPR_SCOPE_CLASS)=qualifier;
        EXPR_B(result,EXPR_NODE_FLAGS)|=1;
        if((MEMBER_B(member,MEMB_FLAGS)&3)==2) {
            FREE_EXPR_TREE(node);
            return result;
        }
        EXPR_W(node,EXPR_RIGHT)=result;
        break;
    }
    EXPR_W(node,EXPR_TYPE)=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    FREE_EXPR_NODE(right);
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    return node;
}
#undef LOCATION

/* ---- ANALYZE_DOT_STAR (listing 7F13) ---- */
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
/* ANALYZE_DOT_STAR: finishes object .* member pointer. The object must be a class
   whose base is the member pointer's class (it is converted to that class); a class
   on the right may be converted with a conversion function (mask 0x80). A pointer to
   data member becomes *(T *)((char *)&object + (int)pm - 1); a pointer to member
   function is left for the call code (LOWER_MEMBER_POINTER_CALL in CPPCALL.C). */
unsigned int far pascal ANALYZE_DOT_STAR(register unsigned int node)
{
    unsigned int temp;
    unsigned int target;   /* read uninitialised on one path below, as in the original ([bp-4] at 0x1316) */
    register unsigned int right;
    EXPR_W(node,EXPR_LEFT)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0));
    if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0) return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x40)) node=REPORT_EXPR_ERROR_PLAIN(MSG_LEFT_SIDE_MUST,node);
    right=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),0,0);
    EXPR_W(node,EXPR_RIGHT)=right=APPLY_CONVERSION_FUNCTION(right,0x80,0);
    if(TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)!=TK_NEAR_PTR || TYPE_B(EXPR_W(right,EXPR_TYPE),TYPE_PTR_MODE)!=0x0B) return REPORT_EXPR_ERROR_PLAIN(MSG_RIGHT_SIDE_NOT_MEMBER,node);
    if(EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&0x14) {
        target=TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_TARGET);
        if(!IS_BASE_CLASS(TYPE_W(target,TYPE_MEMBER_CLASS),EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),1)) return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_DO_NOT_MATCH,node);
        if(TYPE_W(target,TYPE_MEMBER_CLASS)!=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE)) {
            temp=MAKE_ADDRESS_OF(EXPR_W(node,EXPR_LEFT));
            temp=CONVERT_EXPR_TO_TYPE(MAKE_POINTER_TYPE(TYPE_W(target,TYPE_MEMBER_CLASS),0,0),temp,0);
            EXPR_W(node,EXPR_LEFT)=MAKE_DEREFERENCE(temp);
        }
    }
    if(!((EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)) {
        right=MAKE_BINARY_NODE(0x17,MAKE_CAST_NODE(INT_TYPE,right),MAKE_INT_CONSTANT(INT_TYPE,1L));
        EXPR_W(node,EXPR_RIGHT)=right;
        EXPR_W(node,EXPR_LEFT)=MAKE_CAST_NODE(CHAR_POINTER_TYPE,MAKE_ADDRESS_OF(EXPR_W(node,EXPR_LEFT)));
        EXPR_W(node,EXPR_OP)=EOP_ADD;
        node=ANALYZE_EXPRESSION(MAKE_CAST_NODE(MAKE_POINTER_TYPE(target,0,0),node),0,0);
        node=MAKE_DEREFERENCE(node);
    }
    return node;
}

/* ---- IS_NULL_MEMBER_PTR (listing 8129) ---- */
/* IS_NULL_MEMBER_PTR: 1 for a member pointer constant (op 0x48) with all parts 0. */
static unsigned char near pascal IS_NULL_MEMBER_PTR(register unsigned int node)
{
    if(EXPR_W(node,EXPR_OP)==0x48) return EXPR_W(node,EXPR_LEFT)==0 && EXPR_W(node,EXPR_RIGHT)==0 && EXPR_W(node,EXPR_SCOPE_CLASS)==0;
    return 0;
}

/* ---- COMPARE_MEMBER_POINTERS (listing 8161) ---- */
extern unsigned int far pascal SWAP_OPERANDS(unsigned int);
extern unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *,unsigned int far *);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
/* COMPARE_MEMBER_POINTERS: == or != between pointers to members (other operators are
   MSG_OPERANDS_ARE_DIFFERING). Against a null constant it becomes a test of the value
   (CONVERT_CLASS_TO_SCALAR, negated with ! for ==). Otherwise both sides are saved in
   temporaries and all four fields of the struct are compared and joined, negated for
   !=. */
unsigned int far pascal COMPARE_MEMBER_POINTERS(register unsigned int node)
{
    unsigned int result;
    unsigned int left;
    unsigned int right;
    unsigned int side;
    register unsigned int part;
    if(EXPR_W(node,EXPR_OP)!=EOP_EQ && EXPR_W(node,EXPR_OP)!=EOP_NE) return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING,node);
    if(IS_NULL_MEMBER_PTR(EXPR_W(node,EXPR_LEFT))) node=SWAP_OPERANDS(node);
    if(IS_NULL_MEMBER_PTR(EXPR_W(node,EXPR_RIGHT))) {
        result=CONVERT_CLASS_TO_SCALAR(EXPR_W(node,EXPR_LEFT));
        if(EXPR_W(node,EXPR_OP)==EOP_EQ) result=ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x2A,result),0,0);
        FREE_EXPR_NODE(EXPR_W(node,EXPR_RIGHT));
        FREE_EXPR_NODE(node);
        return result;
    }
    left=EXPR_W(node,EXPR_LEFT);
    EXPR_W(left,EXPR_TYPE)=MEMBER_PTR_CLASS_TYPE;
    SAVE_EXPR_IN_TEMP(&left,&side);
    right=EXPR_W(node,EXPR_RIGHT);
    EXPR_W(right,EXPR_TYPE)=MEMBER_PTR_CLASS_TYPE;
    SAVE_EXPR_IN_TEMP(&right,&result);
    side=JOIN_COMMA_EXPR(side,result);
    result=MAKE_BINARY_NODE(0x24,
        MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(left),MAKE_FIELD_REF_NODE(MEMBER_PTR_PAD_MEMBER)),
        MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(right),MAKE_FIELD_REF_NODE(MEMBER_PTR_PAD_MEMBER)));
    part=MAKE_BINARY_NODE(0x24,
        MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(left),MAKE_FIELD_REF_NODE(MEMBER_PTR_OFFSET_MEMBER)),
        MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(right),MAKE_FIELD_REF_NODE(MEMBER_PTR_OFFSET_MEMBER)));
    result=MAKE_BINARY_NODE(0x23,part,result);
    part=MAKE_BINARY_NODE(0x24,
        MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(left),MAKE_FIELD_REF_NODE(MEMBER_PTR_VINDEX_MEMBER)),
        MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(right),MAKE_FIELD_REF_NODE(MEMBER_PTR_VINDEX_MEMBER)));
    result=MAKE_BINARY_NODE(0x23,part,result);
    part=MAKE_BINARY_NODE(0x24,
        MAKE_BINARY_NODE(0x2F,left,MAKE_FIELD_REF_NODE(MEMBER_PTR_DELTA_MEMBER)),
        MAKE_BINARY_NODE(0x2F,right,MAKE_FIELD_REF_NODE(MEMBER_PTR_DELTA_MEMBER)));
    result=MAKE_BINARY_NODE(0x23,part,result);
    if(EXPR_W(node,EXPR_OP)==EOP_NE) result=MAKE_UNARY_NODE(0x2A,result);
    result=JOIN_COMMA_EXPR(side,result);
    FREE_EXPR_NODE(node);
    result=ANALYZE_EXPRESSION(result,0,0);
    return result;
}

/* ---- BUILD_ALLOC_CALL (listing 83CE) ---- */
/* BUILD_ALLOC_CALL: (type)operator new(size * sizeof element, placement args) where
   symbol is the operator new to call (0: the global one) and object the placement
   argument list. When neither force nor placement arguments are given the result is
   (type)0 instead: the allocation is then left to the constructor, which allocates
   when this is 0 (BUILD_THIS_ALLOC_IF_NULL). A member operator new is called
   qualified by its class. */
static unsigned int near pascal BUILD_ALLOC_CALL(register unsigned int symbol,unsigned int object,unsigned int type,unsigned int size,unsigned char force)
{
    unsigned int base;
    register unsigned int result;
    if(force || object) {
        base=MAKE_BINARY_NODE(0x18,COPY_EXPR_TREE(size),MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(TYPE_W(type,TYPE_TARGET))));
        if(!symbol) symbol=NEW_OPERATOR_SYMBOL;
        result=MAKE_BINARY_NODE(1,MAKE_SYMBOL_NODE(symbol),MAKE_LIST_NODE(base,object));
        if(SYM_B(symbol,SYM_FLAGS)&0x10) EXPR_W(EXPR_W(result,EXPR_LEFT),EXPR_SCOPE_CLASS)=SYM_W(SYM_W(symbol,SYM_OWNER_CLASS),SYM_TYPE);
    } else result=MAKE_INT_CONSTANT(INT_TYPE,0L);
    return MAKE_CAST_NODE(type,result);
}

/* ---- ANALYZE_NEW_EXPRESSION (listing 847F) ---- */
extern unsigned char far pascal IS_LINK_TIME_CONSTANT(unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern unsigned int far pascal FIND_MEMBER_REPORT(unsigned int,unsigned int);
extern unsigned int far pascal FIND_DEFAULT_CTOR(unsigned int,unsigned char);
extern long far pascal FORMAT_SPECIAL_MEMBER(unsigned int,unsigned int,unsigned int);
extern int far pascal DESTRUCTOR_CALL_FLAGS(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CALL_NODE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
#define LOCATION(n) (*(struct C21Location far *)MK_FP(EXPR_POOL_SEG,(n)+20))
/* ANALYZE_NEW_EXPRESSION: finishes a new node: EXPR_TYPE the allocated type, EXPR_LEFT
   the element count (0 for one object), EXPR_RIGHT a node with the placement arguments
   (left) and the initializer list (right). For a class with constructors:
   - an array (count not the constant 1) uses VECTOR_NEW_SYMBOL, or VECTOR_VNEW_SYMBOL
     for a class with virtual bases, with the memory, element size, count, mode and
     the default constructor; initializers are not allowed (MSG_NO_CONSTRUCTOR);
   - one object becomes a constructor call on *(type *)alloc, where alloc is 0 unless
     ::new or placement new is used, so the class's constructor allocates (with the
     class's own operator new).
   Other types are allocated with operator new and, when initializers are given,
   assigned through a temporary pointer: (tmp = alloc, *tmp = init, tmp). A class with
   flag 0x80 (probably abstract) cannot be created. */
unsigned int far pascal ANALYZE_NEW_EXPRESSION(unsigned int node)
{
    unsigned int count;
    unsigned int placement;
    unsigned int init;
    unsigned int symbol;
    unsigned int ctor;
    unsigned int ptype;
    unsigned char global;
    unsigned char array;
    unsigned int size;
    unsigned char special;
    unsigned int alloc;
    register unsigned int type;
    register unsigned int work;
    symbol=0;
    special=0;
    type=EXPR_W(node,EXPR_TYPE);
    if(EXPR_W(node,EXPR_LEFT)==0) EXPR_W(node,EXPR_LEFT)=MAKE_INT_CONSTANT(INT_TYPE,1L);
    count=EXPR_W(node,EXPR_LEFT);
    work=EXPR_W(node,EXPR_RIGHT);
    placement=EXPR_W(work,EXPR_LEFT);
    init=EXPR_W(work,EXPR_RIGHT);
    global=!(EXPR_B(node,EXPR_NODE_FLAGS)&0x20);
    ptype=MAKE_POINTER_TYPE(type,0,0);
    if(TYPE_B(type,TYPE_ATTRS)&4) {
        while(TYPE_W(type,TYPE_KIND)==TK_ARRAY) {
            count=MAKE_BINARY_NODE(0x18,count,MAKE_INT_CONSTANT(INT_TYPE,TYPE_L(type,TYPE_ARRAY_COUNT)));
            type=TYPE_W(type,TYPE_TARGET);
        }
    }
    count=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(count,INT_TYPE,0));
    array=1;
    if(IS_LINK_TIME_CONSTANT(count)) {
        count=SIMPLIFY_EXPRESSION(count,0);
        if(EXPR_W(count,EXPR_OP)==EOP_CONST) array=EXPR_L(count,EXPR_VALUE)!=1;
    }
    global=global || array;
    size=TYPE_SIZE(type);
    if(global) symbol=NEW_OPERATOR_SYMBOL;
    if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) {
        if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x80) return REPORT_EXPR_ERROR(MSG_CANNOT_CREATE_VARIABLE,FORMAT_TYPE(type),0L,node);
        special=(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)!=0;
        if(!global) {
            unsigned int member;
            member=FIND_MEMBER_REPORT(OPERATOR_NEW_NAME,type);
            if(member) symbol=MEMBER_W(member,MEMB_VALUE);
        }
    }
    if(!size) return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,node);
    if(TYPE_B(type,TYPE_ATTRS)&4) {
        if(array) {
            ctor=FIND_DEFAULT_CTOR(type,1);
            if(init) return REPORT_EXPR_ERROR_PLAIN(MSG_NO_CONSTRUCTOR,node);
            if(ctor) {
                unsigned int list;
                list=0;
                alloc=special ? VECTOR_VNEW_SYMBOL : VECTOR_NEW_SYMBOL;
                ptype=MAKE_POINTER_TYPE(TYPE_W(ptype,TYPE_TARGET),0x0F,0);
                if(global || placement) SAVE_EXPR_IN_TEMP(&count,&list);
                work=MAKE_CALL_NODE(MAKE_SYMBOL_NODE(alloc),
                    BUILD_ALLOC_CALL(symbol,placement,ptype,count,global),
                    MAKE_INT_CONSTANT(SIZE_T_TYPE,size),
                    count,
                    MAKE_INT_CONSTANT(INT_TYPE,DESTRUCTOR_CALL_FLAGS(type,ctor)),
                    MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(ctor)));
                work=JOIN_COMMA_EXPR(list,work);
            } else return REPORT_EXPR_ERROR(MSG_CANNOT_FIND_INITIALIZE_225,FORMAT_SPECIAL_MEMBER(5,0,type),0L,node);
        } else {
            work=BUILD_ALLOC_CALL(symbol,placement,ptype,count,global);
            work=BUILD_CONSTRUCTOR_CALL(MAKE_UNARY_NODE(0x18,work),type,init);
            LOCATION(work)=LOCATION(node);
        }
    } else {
        work=BUILD_ALLOC_CALL(symbol,placement,ptype,count,1);
        if(init) {
            unsigned int list;
            unsigned int old;
            unsigned int item;
            list=0;
            while(init) {
                list=JOIN_COMMA_EXPR(list,EXPR_W(init,EXPR_RIGHT));
                old=init;
                init=EXPR_W(init,EXPR_LEFT);
                FREE_EXPR_NODE(old);
            }
            item=CREATE_LOCAL_TEMP(ptype);
            work=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(item),MAKE_CAST_NODE(ptype,work));
            work=JOIN_COMMA_EXPR(work,MAKE_BINARY_NODE(0x0B,MAKE_UNARY_NODE(0x18,MAKE_SYMBOL_NODE(item)),list));
            work=JOIN_COMMA_EXPR(work,MAKE_SYMBOL_NODE(item));
        }
    }
    return ANALYZE_EXPRESSION(MAKE_CAST_NODE(ptype,work),ptype,0);
}
#undef LOCATION

/* ---- FIND_DELETE_OPERATOR (listing 8891) ---- */
/* FIND_DELETE_OPERATOR: the class's own operator delete, preferring the overload
   with a second (size) parameter; 0 for a non-class or a class without one. */
static unsigned int near pascal FIND_DELETE_OPERATOR(register unsigned int type)
{
    unsigned int member;
    register unsigned int symbol;
    if(!(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40)) return 0;
    member=FIND_MEMBER_REPORT(OPERATOR_DELETE_NAME,type);
    if(!member) return 0;
    symbol=MEMBER_W(member,MEMB_VALUE);
    if(SYM_W(symbol,SYM_NEXT_OVERLOAD) && FORMAL_W(TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_PARAMS),FORMAL_NEXT)==0) symbol=SYM_W(symbol,SYM_NEXT_OVERLOAD);
    return symbol;
}

/* ---- ANALYZE_DELETE_EXPRESSION (listing 8906) ---- */
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned int far pascal BUILD_DESTRUCTOR_CALL(unsigned int,unsigned int,unsigned int,int);
/* ANALYZE_DELETE_EXPRESSION: finishes delete: EXPR_RIGHT the pointer, EXPR_LEFT the
   count. A class with a destructor is destroyed by BUILD_DESTRUCTOR_CALL with flags 3
   (destroy and free: the destructor calls operator delete itself), or flags 2 followed
   by the global DELETE_OPERATOR_SYMBOL when ::delete is used on a class that has its
   own operator delete (probably). A virtual destructor is called through a temporary
   pointer and only if it is not 0. Other types call operator delete directly (the
   class's own one only for a single object), adding count * size when it takes a
   size parameter. */
unsigned int far pascal ANALYZE_DELETE_EXPRESSION(unsigned int node)
{
    unsigned int expr;
    unsigned int count;
    unsigned int target;
    unsigned char global;
    unsigned char single;
    unsigned int member;
    unsigned char destroy;
    unsigned int list;
    unsigned int call;
    register unsigned int result;
    register unsigned int symbol;
    expr=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),0,0));
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x14)) return REPORT_EXPR_ERROR_PLAIN(MSG_INVALID_INDIRECTION,expr);
    target=TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_TARGET);
    symbol=FIND_DELETE_OPERATOR(target);
    global=symbol && !(EXPR_B(node,EXPR_NODE_FLAGS)&0x20);
    count=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0));
    single=EXPR_W(count,EXPR_OP)==EOP_CONST && EXPR_L(count,EXPR_VALUE)==1;
    if(TYPE_B(target,TYPE_ATTRS)&8) {
        member=FIND_MEMBER_BY_NAME(DTOR_NAME,target);
        destroy=member && SYM_W(MEMBER_W(member,MEMB_VALUE),SYM_VIRTUAL_INDEX);
        list=0;
        if(destroy || global) SAVE_EXPR_IN_TEMP(&expr,&list);
        expr=ANALYZE_EXPRESSION(expr,0,0);
        result=BUILD_DESTRUCTOR_CALL(MAKE_DEREFERENCE(COPY_EXPR_TREE(expr)),target,count,global ? 2 : 3);
        if(global) {
            call=MAKE_CALL_NODE(MAKE_SYMBOL_NODE(DELETE_OPERATOR_SYMBOL),COPY_EXPR_TREE(expr),0,0,0,0);
            result=JOIN_COMMA_EXPR(result,call);
        }
        if(destroy) {
            result=MAKE_CONDITIONAL_NODE(0x6B,COPY_EXPR_TREE(expr),result,
                MAKE_CAST_NODE(VOID_TYPE,MAKE_INT_CONSTANT(INT_TYPE,0L)));
            result=JOIN_COMMA_EXPR(list,result);
        }
    } else {
        if(!single || global || !symbol) symbol=DELETE_OPERATOR_SYMBOL;
        if(FORMAL_W(TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_PARAMS),FORMAL_NEXT))
            count=MAKE_BINARY_NODE(0x18,count,MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(EXPR_W(expr,EXPR_TYPE))));
        else count=0;
        result=MAKE_CALL_NODE(MAKE_SYMBOL_NODE(symbol),expr,count,0,0,0);
        if(SYM_B(symbol,SYM_FLAGS)&0x10) EXPR_W(EXPR_W(result,EXPR_LEFT),EXPR_SCOPE_CLASS)=SYM_W(SYM_W(symbol,SYM_OWNER_CLASS),SYM_TYPE);
    }
    return ANALYZE_EXPRESSION(result,0,0);
}

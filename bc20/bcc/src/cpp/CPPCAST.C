/* target: ovr076_C229UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: C++ expressions: resolves symbol references (overloaded names), casts, and
   class-to-integral or class-to-scalar conversion through conversion functions. Entry
   points: RESOLVE_SYMBOL_NODE, ANALYZE_TEMP_OBJECT_NODE, CAST_EXPRESSION,
   CONVERT_CLASS_TO_INTEGRAL, CONVERT_CLASS_TO_SCALAR. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: C++ hooks of expression analysis. The dispatcher expr/EXPRDISP.C calls
   these in C++ mode (CPP_MODE) for symbol references, temporary-object nodes
   and casts; the statement parser (STMTCPP.C) and the operator checks call the two
   CONVERT_CLASS_TO_* functions where a condition or an integer is required.
   - RESOLVE_SYMBOL_NODE finishes a symbol node by storage class: enumerators and
     constants become constant nodes, a name of several overloaded functions is
     resolved against the type it is converted to, and a member alias (an anonymous
     union member) becomes object.member.
   - CAST_EXPRESSION handles the C++ cases of (type)expr: user conversions
     (constructor or conversion function), casts to references, pointer-to-member
     casts and pointer casts between base and derived classes. It returns 0 to tell
     the caller to do an ordinary C cast instead.
   - CONVERT_CLASS_TO_INTEGRAL / CONVERT_CLASS_TO_SCALAR apply a conversion function
     to a class value, and turn a pointer to member into something testable.
   Storage classes (SYM_STORAGE_CLASS >> 3) seen here: 1-5 ordinary objects and
   functions, 6 a parameter (probably), 9 a constant with a stored value, 14 a member
   alias, 15 an int enumerator. A pointer to member is a TK_NEAR_PTR with pointer mode
   0x0B; its run-time form is the struct MEMBER_PTR_CLASS_TYPE (fields
   MEMBER_PTR_DELTA_MEMBER, _VINDEX_, _OFFSET_, _PAD_). */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- RESOLVE_SYMBOL_NODE (listing 6430) ---- */
#include <dos.h>
typedef struct { unsigned char bytes[10]; } C40RealStorage;
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned int far pascal MAKE_REAL_CONSTANT(unsigned int,C40RealStorage far *);
extern unsigned int far pascal FIND_MATCHING_OVERLOAD(unsigned int,unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern long far pascal FORMAT_SYMBOL(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
extern unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);

/* RESOLVE_SYMBOL_NODE: finishes symbol node expression (EXPR_LEFT is the symbol);
   type is the type the value is wanted as, or 0. A parameter of a class with
   constructors gets a reference type (such parameters are passed by address,
   probably). An overloaded function name is resolved with FIND_MATCHING_OVERLOAD
   when type is a function or pointer to function; without such a type the name is
   ambiguous (MSG_AMBIGUITY_BETWEEN). Marks the result with node flag 1. */
unsigned int far pascal RESOLVE_SYMBOL_NODE(register unsigned int expression,unsigned int type)
{
    unsigned int base;
    C40RealStorage real;
    register unsigned int symbol;

    symbol=EXPR_W(expression,EXPR_LEFT);
    base=SYM_W(symbol,SYM_TYPE);
    switch(SYM_B(symbol,SYM_STORAGE_CLASS)>>3) {
    case 6:
        if((EXPR_FLAGS[TYPE_W(base,TYPE_KIND)]&0x40) && (TYPE_B(base,TYPE_ATTRS)&4))
            EXPR_W(expression,EXPR_TYPE)=MAKE_POINTER_TYPE(base,0,1);
        break;
    case 15:
        expression=MAKE_INT_CONSTANT(base,(long)(int)SYM_W(symbol,SYM_CONST_VALUE));
        break;
    case 9:
        FREE_EXPR_NODE(expression);
        if(EXPR_FLAGS[TYPE_W(base,TYPE_KIND)]&1) {
            expression=MAKE_INT_CONSTANT(base,SYM_L(symbol,SYM_CONST_VALUE));
        } else {
            RTL_MEMMOVE((void far *)&real,MK_FP(SYMBOL_POOL_SEG,symbol+SYM_CONST_VALUE),10);
            expression=MAKE_REAL_CONSTANT(base,&real);
        }
        break;
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
        if(TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)==TK_FUNCTION && SYM_W(symbol,SYM_NEXT_OVERLOAD) && type) {
            if(((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) ||
               TYPE_W(type,TYPE_KIND)==TK_FUNCTION) {
                symbol=FIND_MATCHING_OVERLOAD(EXPR_W(expression,EXPR_LEFT),type);
                if(!symbol) {
                    expression=REPORT_EXPR_ERROR(MSG_COULD_NOT_FIND_MATCH,FORMAT_TYPE(type),0L,expression);
                } else {
                    EXPR_W(expression,EXPR_LEFT)=symbol;
                    EXPR_W(expression,EXPR_TYPE)=SYM_W(symbol,SYM_TYPE);
                }
            } else {
                expression=REPORT_EXPR_ERROR(MSG_AMBIGUITY_BETWEEN,FORMAT_SYMBOL(symbol),FORMAT_SYMBOL(SYM_W(symbol,SYM_NEXT_OVERLOAD)),expression);
            }
        }
        break;
    case 14:
        EXPR_W(expression,EXPR_LEFT)=SYM_W(symbol,SYM_ALIAS_OBJECT);
        expression=MAKE_BINARY_NODE(0x2F,expression,MAKE_FIELD_REF_NODE(SYM_W(symbol,SYM_ALIAS_MEMBER)));
        return ANALYZE_EXPRESSION(expression,0,0);
    }
    EXPR_B(expression,EXPR_NODE_FLAGS)|=1;
    return expression;
}

/* ---- ANALYZE_TEMP_OBJECT_NODE (listing 663F) ---- */
#include <dos.h>
extern unsigned int far pascal CONSTRUCT_TEMP_OBJECT(unsigned int,unsigned int,unsigned int);

/* ANALYZE_TEMP_OBJECT_NODE: a node standing for type(args) (EXPR_TYPE the class,
   EXPR_RIGHT the arguments) becomes a constructed temporary; context is the object to
   construct into if it fits (see CONSTRUCT_TEMP_OBJECT). */
unsigned int far pascal ANALYZE_TEMP_OBJECT_NODE(register unsigned int expression,unsigned int context)
{
    unsigned int result;

    result=CONSTRUCT_TEMP_OBJECT(EXPR_W(expression,EXPR_TYPE),EXPR_W(expression,EXPR_RIGHT),context);
    FREE_EXPR_NODE(expression);
    return result;
}

/* ---- CAST_EXPRESSION (listing 666F) ---- */
#include <dos.h>
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal FIND_USER_CONVERSION(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INITIALIZED_TEMP(unsigned int);
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_REFERENCE(unsigned int);
extern unsigned int far pascal CHECK_NULL_CONSTANT(unsigned int,unsigned char far *);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern unsigned char far pascal IS_UNIQUE_BASE(unsigned int,unsigned int);
extern unsigned char far pascal IS_UNIQUE_NONVIRTUAL_BASE(unsigned int,unsigned int);
extern unsigned int far pascal ADJUST_MEMBER_FUNC_PTR_BASE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal ADJUST_NODE_BASE_OFFSET(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_DERIVED_TO_BASE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal CONVERT_BASE_TO_DERIVED(unsigned int,unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal CHECK_CAST(unsigned int);
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal MAKE_CALL_NODE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);

/* CAST_EXPRESSION: analyzes the cast node expression to type EXPR_TYPE. Steps:
   analyze the operand; if the types are already compatible, the operand is just
   retyped. Otherwise look for a user conversion, or a constructor of the target
   class taking the value (CTOR_NAME is TOKEN_NAMES[5], the constructor
   name). A
   constructor gives a temporary object, a conversion function gives a member call.
   Without one: a cast to a reference takes the operand's address (after making it
   addressable); a 0 cast to a pointer to member function becomes a null member
   pointer constant (op 0x48 with all parts 0); member pointer casts adjust between
   related classes; pointer casts between classes convert derived to base (must be
   unique) or base to derived (must be unique and non-virtual). Returns 0 when the
   cast is not a C++ special case and the caller should treat it as a C cast. */
unsigned int far pascal CAST_EXPRESSION(register unsigned int expression,unsigned int context)
{
    unsigned int source;
    unsigned int target_inner;
    unsigned int source_inner;
    unsigned int symbol;
    unsigned char reference;
    unsigned int node;
    unsigned int result;
    unsigned char changed;
    unsigned char member_reference;
    unsigned int operand;
    register unsigned int target;

    target=EXPR_W(expression,EXPR_TYPE);
    reference=(EXPR_FLAGS[TYPE_W(target,TYPE_KIND)]&0x14) && (TYPE_B(target,TYPE_ATTRS)&0x20);
    member_reference=0;
    if(reference && EXPR_W(expression,EXPR_LEFT) && EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1)
        member_reference=(SYM_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==9;
    EXPR_W(expression,EXPR_LEFT)=ANALYZE_EXPRESSION(EXPR_W(expression,EXPR_LEFT),target,0);
    if(!reference || (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x14)==0 ||
       (TYPE_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_ATTRS)&0x20)==0)
        EXPR_W(expression,EXPR_LEFT)=CONVERT_TO_RVALUE(EXPR_W(expression,EXPR_LEFT));
    source=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE);
    EXPR_B(expression,EXPR_NODE_FLAGS)|=1;
    /* Already compatible: the cast only changes the type. */
    if(TYPES_COMPATIBLE(source,target,2)) {
        EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE)=target;
        result=EXPR_W(expression,EXPR_LEFT);
    } else {
        symbol=0;
        symbol=FIND_USER_CONVERSION(target,source,1,EXPR_W(expression,EXPR_SRC_LINE),EXPR_W(expression,EXPR_SRC_WORD3));
        if(!symbol && (EXPR_FLAGS[TYPE_W(target,TYPE_KIND)]&0x40) && (TYPE_B(target,TYPE_ATTRS)&4)) {
            operand=FIND_MEMBER_BY_NAME(CTOR_NAME,target);
            if(operand) symbol=MEMBER_W(operand,MEMB_VALUE);
        }
        /* No user conversion: the remaining cases are reference, member pointer and
           class pointer casts; returning 0 means "an ordinary C cast". */
        if(!symbol) {
            if(reference && !((EXPR_FLAGS[TYPE_W(source,TYPE_KIND)]&0x14) && (TYPE_B(source,TYPE_ATTRS)&0x20))) {
                operand=EXPR_W(expression,EXPR_LEFT);
                if(member_reference) operand=MAKE_INITIALIZED_TEMP(operand);
                if(!IS_LVALUE(operand)) operand=REWRITE_FOR_REFERENCE_BIND(operand);
                if(IS_LVALUE(operand)) {
                    EXPR_W(expression,EXPR_LEFT)=MAKE_REFERENCE(ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x1D,operand),0,0));
                    source=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE);
                } else {
                    EXPR_W(expression,EXPR_LEFT)=operand;
                }
            }
            if(!(EXPR_FLAGS[TYPE_W(source,TYPE_KIND)]&0x14)) {
                if(TYPE_W(target,TYPE_KIND)!=TK_NEAR_PTR || TYPE_B(target,TYPE_PTR_MODE)!=0x0B ||
                   (EXPR_FLAGS[TYPE_W(target,TYPE_KIND)]&0x14)==0 || TYPE_W(TYPE_W(target,TYPE_TARGET),TYPE_KIND)!=TK_FUNCTION)
                    return 0;
                EXPR_W(expression,EXPR_LEFT)=CHECK_NULL_CONSTANT(EXPR_W(expression,EXPR_LEFT),&changed);
                if(!changed)
                    return REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM,FORMAT_TYPE(source),FORMAT_TYPE(target),expression);
                node=EXPR_W(expression,EXPR_LEFT);
                EXPR_W(node,EXPR_OP)=0x48;
                EXPR_W(node,EXPR_TYPE)=EXPR_W(expression,EXPR_TYPE);
                EXPR_W(node,EXPR_SCOPE_CLASS)=0;
                EXPR_W(node,EXPR_LEFT)=0;
                EXPR_W(node,EXPR_RIGHT)=0;
                EXPR_B(node,EXPR_NODE_FLAGS)|=1;
                FREE_EXPR_NODE(expression);
                return node;
            }
            source_inner=TYPE_W(source,TYPE_TARGET);
            if(TYPE_W(source,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(source,TYPE_PTR_MODE)==0x0B) {
                if(EXPR_FLAGS[TYPE_W(target,TYPE_KIND)]&1) {
                    if(TYPE_W(source_inner,TYPE_KIND)==TK_FUNCTION) goto fail;
                    return expression;
                }
                if(TYPE_W(target,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(target,TYPE_PTR_MODE)==0x0B &&
                   (((EXPR_FLAGS[TYPE_W(target,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(target,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) ==
                    ((EXPR_FLAGS[TYPE_W(source,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(source,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION))) {
                    target_inner=TYPE_W(target,TYPE_TARGET);
                    if(TYPES_COMPATIBLE(TYPE_W(source_inner,TYPE_MEMBER_CLASS),TYPE_W(target_inner,TYPE_MEMBER_CLASS),1)) return expression;
                    if(IS_BASE_CLASS(TYPE_W(source_inner,TYPE_MEMBER_CLASS),TYPE_W(target_inner,TYPE_MEMBER_CLASS),0) ||
                       IS_BASE_CLASS(TYPE_W(target_inner,TYPE_MEMBER_CLASS),TYPE_W(source_inner,TYPE_MEMBER_CLASS),0)) {
                        if(TYPE_W(target_inner,TYPE_KIND)==TK_FUNCTION)
                            return ADJUST_MEMBER_FUNC_PTR_BASE(expression,TYPE_W(source_inner,TYPE_MEMBER_CLASS),TYPE_W(target_inner,TYPE_MEMBER_CLASS),context);
                        return ADJUST_NODE_BASE_OFFSET(expression,TYPE_W(source_inner,TYPE_MEMBER_CLASS),TYPE_W(target_inner,TYPE_MEMBER_CLASS));
                    }
                }
fail:
                return REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM,FORMAT_TYPE(source),FORMAT_TYPE(target),expression);
            }
            if(!(EXPR_FLAGS[TYPE_W(target,TYPE_KIND)]&0x14)) return 0;
            target_inner=TYPE_W(target,TYPE_TARGET);
            if(TYPES_COMPATIBLE(target_inner,source_inner,1)) return 0;
            if(IS_BASE_CLASS(target_inner,source_inner,0)) {
                if(!IS_UNIQUE_BASE(target_inner,source_inner))
                    return REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM,FORMAT_TYPE(source),FORMAT_TYPE(target),expression);
                node=EXPR_W(expression,EXPR_LEFT);
                result=CONVERT_DERIVED_TO_BASE(node,source_inner,0,target_inner,reference,1);
                result=ANALYZE_EXPRESSION(result,0,0);
                if(TYPE_W(target,TYPE_KIND)!=TYPE_W(source,TYPE_KIND)) {
                    EXPR_W(expression,EXPR_LEFT)=result;
                    return CHECK_CAST(expression);
                }
                FREE_EXPR_NODE(expression);
                return result;
            } else if(IS_BASE_CLASS(source_inner,target_inner,0)) {
                if(IS_UNIQUE_NONVIRTUAL_BASE(source_inner,target_inner)) {
                    result=CONVERT_BASE_TO_DERIVED(EXPR_W(expression,EXPR_LEFT),source_inner,target_inner,reference);
                    result=ANALYZE_EXPRESSION(result,0,0);
                    if(TYPE_W(target,TYPE_KIND)!=TYPE_W(source,TYPE_KIND)) {
                        EXPR_W(expression,EXPR_LEFT)=result;
                        return CHECK_CAST(expression);
                    }
                    FREE_EXPR_NODE(expression);
                return result;
                } else {
                    return REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM,FORMAT_TYPE(source),FORMAT_TYPE(target),expression);
                }
            } else {
                return reference ? expression : 0;
            }
        } else if(SYM_W(symbol,SYM_FUNC_KIND)==3) {
            result=CONSTRUCT_TEMP_OBJECT(EXPR_W(expression,EXPR_TYPE),MAKE_LIST_NODE(EXPR_W(expression,EXPR_LEFT),0),context);
        } else {
            node=MAKE_BINARY_NODE(0x2F,EXPR_W(expression,EXPR_LEFT),MAKE_SYMBOL_NODE(symbol));
            node=MAKE_CALL_NODE(node,0,0,0,0,0);
            result=ANALYZE_EXPRESSION(node,target,0);
        }
    }
    FREE_EXPR_NODE(expression);
    return result;
}

/* ---- CONVERT_CLASS_TO_INTEGRAL (listing 6C2F) ---- */
#include <dos.h>
extern unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned int);

/* CONVERT_CLASS_TO_INTEGRAL: analyzes expression wanting an int; a class value is
   converted with a conversion function (APPLY_CONVERSION_FUNCTION mask 1, probably
   integral types only). Used for switch selectors, probably (STMTCPP.C). */
unsigned int far pascal CONVERT_CLASS_TO_INTEGRAL(register unsigned int expression)
{
    expression=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression,INT_TYPE,0));
    if(CPP_MODE && (EXPR_FLAGS[TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)]&0x40))
        expression=APPLY_CONVERSION_FUNCTION(expression,1,0);
    return expression;
}

/* ---- CONVERT_CLASS_TO_SCALAR (listing 6C7E) ---- */
#include <dos.h>
extern void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *,unsigned int far *);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);

/* CONVERT_CLASS_TO_SCALAR: analyzes an expression used as a condition or operand of
   !, && and ||. A class value goes through a conversion function (mask 7). A pointer
   to member is saved in a temporary and replaced by delta | vindex | offset | pad of
   its struct (token 0x1C, probably '|'), which is nonzero exactly when the member
   pointer is not null. */
unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int expression)
{
    unsigned int offset;
    register unsigned int tree;
    register unsigned int part;

    expression=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression,0,0));
    if(CPP_MODE) {
        if(EXPR_FLAGS[TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)]&0x40) {
            expression=APPLY_CONVERSION_FUNCTION(expression,7,0);
        } else if(TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)==TK_NEAR_PTR && TYPE_B(EXPR_W(expression,EXPR_TYPE),TYPE_PTR_MODE)==0x0B) {
            SAVE_EXPR_IN_TEMP(&expression,&offset);
            EXPR_W(expression,EXPR_TYPE)=MEMBER_PTR_CLASS_TYPE;
            tree=MAKE_BINARY_NODE(0x2F,expression,MAKE_FIELD_REF_NODE(MEMBER_PTR_DELTA_MEMBER));
            part=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(expression),MAKE_FIELD_REF_NODE(MEMBER_PTR_VINDEX_MEMBER));
            tree=MAKE_BINARY_NODE(0x1C,tree,part);
            part=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(expression),MAKE_FIELD_REF_NODE(MEMBER_PTR_OFFSET_MEMBER));
            tree=MAKE_BINARY_NODE(0x1C,tree,part);
            part=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(expression),MAKE_FIELD_REF_NODE(MEMBER_PTR_PAD_MEMBER));
            tree=MAKE_BINARY_NODE(0x1C,tree,part);
            expression=ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(offset,tree),0,0);
        }
    }
    return expression;
}

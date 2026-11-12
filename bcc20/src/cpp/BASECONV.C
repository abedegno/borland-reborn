/* target: ovr166_C116UNIT */
/* Role: C++ expressions: reference binding and dereference, derived-to-base and
   base-to-derived pointer conversion, virtual base pointers, base offsets, temporary
   objects. Entry points: MAKE_REFERENCE, DEREF_REFERENCE_EXPR, CONVERT_DERIVED_TO_BASE,
   CONVERT_BASE_TO_DERIVED, ADJUST_MEMBER_FUNC_PTR_BASE, ADJUST_NODE_BASE_OFFSET,
   GET_BASE_OFFSET, CONSTRUCT_TEMP_OBJECT (+2 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: expression rewrites the C++ front end needs for references, class
   hierarchies and temporaries. Called from expression analysis (expr/UNARYOP.C,
   EXPRCHK.C, CONVERT.C), CPPEXPCK.C, CPPCALL.C and the constructor builders.
   - References are pointer types with TYPE_ATTRS bit 0x20 (EXPR_FLAGS[kind] & 0x14
     selects pointer-like kinds). MAKE_REFERENCE retypes a pointer-valued node as a
     reference, STRIP_REFERENCE does the reverse, DEREF_REFERENCE_EXPR turns a
     reference-valued node into the object it refers to.
   - Base class conversion: ACCUMULATE_BASE_OFFSET finds the path from a derived class
     down to a base and adds up the subobject offsets; each virtual base on the path
     cannot be reached by a constant, so it adds a read of the virtual base pointer
     (MAKE_VBASE_POINTER_EXPR) to a chain, built inside out by BUILD_BASE_ADJUST_EXPR.
     CONVERT_DERIVED_TO_BASE and CONVERT_BASE_TO_DERIVED use that to convert pointers
     (with a null test so a null pointer stays null) and references. GET_BASE_OFFSET
     gives a constant offset. ADJUST_MEMBER_FUNC_PTR_BASE and ADJUST_NODE_BASE_OFFSET
     move pointers to members between classes.
   - CONSTRUCT_TEMP_OBJECT builds an object with a constructor in a temporary and
     registers its destructor on the current scope.
   - IS_OBJECT_RVALUE and REWRITE_FOR_REFERENCE_BIND deal with C++ expressions whose
     result is an object (assignments, prefix ++/--, and comma or ?: built from them)
     although IS_LVALUE does not treat them as lvalues; they are rewritten so their
     address can be taken.
   Pointer offsets are added as (char *)p + n with token-coded nodes (0x16 '+', 0x18
   unary '*', 0x1D unary address-of, 0x0B '=', 0x2F '.'; see CPPCTOR.C), and
   MAKE_CONDITIONAL_NODE(0x20, c, a, b) is c ? a : b. Expression operator 0x48 is a
   pointer-to-member constant (see MEMBPTR.C), 0x35 a cast.
   Several functions use register pseudo-variables (_SI, _DI) for locals, and
   CONVERT_DERIVED_TO_BASE and CONVERT_BASE_TO_DERIVED contain a do-nothing _SI=_SI
   kept for byte matching (see the note at the first one). */
/* Original CO06A (ovr_1dad_add3) as one source. */
/* opts: -mm -O -Z -p -Y */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STRIP_REFERENCE (listing ovr_1dad_add3:DD30) ---- */
static unsigned int near pascal STRIP_REFERENCE(register unsigned int value);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int first,
                                        unsigned int second,
                                        unsigned char third);

#define NODE_TYPE(v) (*((unsigned int far *)MK_FP(EXPR_POOL_SEG, (v) + 8)))

/* STRIP_REFERENCE: if node value has a reference type, retypes it in place as the
   matching pointer type (same target and kind, no reference bit). Returns value. */
static unsigned int near pascal STRIP_REFERENCE(register unsigned int value)
{
    if (EXPR_FLAGS[TYPE_W(NODE_TYPE(value), TYPE_KIND)] & 0x14) {
        if (TYPE_B(NODE_TYPE(value), TYPE_ATTRS) & 0x20) {
            NODE_TYPE(value) =
                MAKE_POINTER_TYPE(TYPE_W(NODE_TYPE(value), TYPE_TARGET),
                        TYPE_W(NODE_TYPE(value), TYPE_KIND),
                        0);
        }
    }
    return value;
}
#undef NODE_TYPE

/* ---- MAKE_REFERENCE (listing ovr_1dad_add3:DD98) ---- */
unsigned int far pascal MAKE_REFERENCE(unsigned int value);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
/* MAKE_REFERENCE: if node value has a (non-reference) pointer type, retypes it in place
   as a reference to the same target, keeping the pointer mode and word 9. */
unsigned int far pascal MAKE_REFERENCE(register unsigned int value)
{
    register unsigned int type;
    if (EXPR_FLAGS[TYPE_W(EXPR_W(value,EXPR_TYPE),TYPE_KIND)]&0x14) {
        if (!(TYPE_B(EXPR_W(value,EXPR_TYPE),TYPE_ATTRS)&0x20)) {
            type=EXPR_W(value,EXPR_TYPE);
            EXPR_W(value,EXPR_TYPE)=MAKE_POINTER_TYPE(TYPE_W(type,TYPE_TARGET),TYPE_W(type,TYPE_KIND),1);
            TYPE_B(EXPR_W(value,EXPR_TYPE),TYPE_PTR_MODE)=TYPE_B(type,TYPE_PTR_MODE);
            TYPE_W(EXPR_W(value,EXPR_TYPE),TYPE_PARAMS)=TYPE_W(type,TYPE_PARAMS);
        }
    }
    return value;
}

/* ---- DEREF_REFERENCE_EXPR (listing ovr_1dad_add3:DE24) ---- */
unsigned int far pascal DEREF_REFERENCE_EXPR(unsigned int value);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned int far pascal MAKE_DEREF_NODE(unsigned int);
/* DEREF_REFERENCE_EXPR: turns a reference-valued expression into the referred object:
   &x typed as a reference to x's type gives back x itself, anything else gets a
   dereference node (MAKE_DEREF_NODE). A reference to type kind 18 (probably a
   function) is left alone. A symbol of storage class 14 (a member alias) is an error
   here (MSG_ILLEGAL_STRUCTURE). */
unsigned int far pascal DEREF_REFERENCE_EXPR(unsigned int value)
{
    unsigned int next;
    if (value) {
        if (EXPR_W(value,EXPR_OP)==1) {
            if ((SYM_B(EXPR_W(value,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==14)
                return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_STRUCTURE,value);
        }
        if (EXPR_FLAGS[TYPE_W(EXPR_W(value,EXPR_TYPE),TYPE_KIND)]&0x14) {
            if (TYPE_B(EXPR_W(value,EXPR_TYPE),TYPE_ATTRS)&0x20) {
                if (EXPR_FLAGS[TYPE_W(EXPR_W(value,EXPR_TYPE),TYPE_KIND)]&0x14) {
                    if (TYPE_W(TYPE_W(EXPR_W(value,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==18) goto done;
                }
                if (EXPR_W(value,EXPR_OP)==50) {
                    if (TYPE_W(EXPR_W(value,EXPR_TYPE),TYPE_TARGET)==
                        EXPR_W(EXPR_W(value,EXPR_LEFT),EXPR_TYPE)) {
                        next=EXPR_W(value,EXPR_LEFT);
                        FREE_EXPR_NODE(value);
                        value=next;
                        goto done;
                    }
                }
                value=MAKE_DEREF_NODE(value);
            }
        }
    }
done:
    return value;
}

/* ---- MAKE_VBASE_POINTER_EXPR (listing ovr_1dad_add3:DF00) ---- */
static unsigned int far pascal MAKE_VBASE_POINTER_EXPR(unsigned int value);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int, unsigned int, unsigned char);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int, unsigned int);

/* MAKE_VBASE_POINTER_EXPR: *(value **)<hole>: reads a virtual base pointer of class
   value. The cast's operand is left 0; BUILD_BASE_ADJUST_EXPR fills it in. */
static unsigned int far pascal MAKE_VBASE_POINTER_EXPR(unsigned int value)
{
    unsigned int intermediate;

    intermediate = MAKE_POINTER_TYPE(MAKE_POINTER_TYPE(value, 0, 0), 0, 0);
    return MAKE_UNARY_NODE(24, MAKE_CAST_NODE(intermediate, 0));
}

/* ---- BUILD_BASE_ADJUST_EXPR (listing ovr_1dad_add3:DF3D) ---- */
static unsigned int far pascal BUILD_BASE_ADJUST_EXPR(register unsigned int node, int value, register unsigned int third);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int, unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int, long);

/* BUILD_BASE_ADJUST_EXPR: makes (char *)third + value (no addition when value is 0).
   If node, a chain of virtual base pointer reads, is given, the result is stored in
   the chain's innermost empty cast (op 0x35 with EXPR_LEFT 0; [0] and [5] are
   EXPR_OP and EXPR_LEFT as word indexes) and the chain is returned, so the
   new expression becomes the address the deepest read starts from. */
static unsigned int far pascal BUILD_BASE_ADJUST_EXPR(register unsigned int node, int value,
                                        register unsigned int third)
{
    unsigned int original;

    third = MAKE_CAST_NODE(CHAR_POINTER_TYPE, third);
    if (value)
        third = MAKE_BINARY_NODE(0x16, third, MAKE_INT_CONSTANT(INT_TYPE, (long)value));
    if (node == 0)
        return third;
    original = node;
    while (((unsigned int far *)MK_FP(EXPR_POOL_SEG, node))[0] != 0x35 ||
           ((unsigned int far *)MK_FP(EXPR_POOL_SEG, node))[5] != 0)
        node = ((unsigned int far *)MK_FP(EXPR_POOL_SEG, node))[5];
    ((unsigned int far *)MK_FP(EXPR_POOL_SEG, node))[5] = third;
    return original;
}

/* ---- ACCUMULATE_BASE_OFFSET (listing ovr_1dad_add3:DFAD) ---- */
static void far pascal ACCUMULATE_BASE_OFFSET(register unsigned int left,unsigned int right, int far *delta,unsigned int far *out, unsigned char far *state);
/* ACCUMULATE_BASE_OFFSET: finds base class left inside class right (depth first, the
   first path found) and accumulates how to get there: *delta collects constant
   offsets; at a virtual base the offset so far and a virtual base pointer read are
   folded into the expression chain *out and *delta restarts at 0. *state is 1 when
   left was found (or is right itself), 0 otherwise. Record 2 of BASE_LIST_SEG is set
   so that the null record 0 reads as a base of type left: the search loop always
   stops (sentinel). */
static void far pascal ACCUMULATE_BASE_OFFSET(register unsigned int left,unsigned int right,
                               int far *delta,unsigned int far *out,
                               unsigned char far *state)
{
    register unsigned int cursor;
    *state=0;
    if(right!=left) {
        cursor=*((unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,TYPE_W(right,TYPE_TAG_BODY)+TAG_BASES));
        BASE_W(2,BASE_NEXT)=left;
        while(TYPE_W(BASE_W(cursor,BASE_TYPE),TYPE_TAG_BODY)!=TYPE_W(left,TYPE_TAG_BODY)) {
            ACCUMULATE_BASE_OFFSET(left,BASE_W(cursor,BASE_TYPE),delta,out,state);
            if(*state!=0) break;
            cursor=BASE_W(cursor,BASE_NEXT);
        }
        if(cursor==0) {
            *state=0;
            return;
        }
        if(BASE_B(cursor,BASE_VIRTUAL)!=0) {
            *out=BUILD_BASE_ADJUST_EXPR(*out,*delta,MAKE_VBASE_POINTER_EXPR(BASE_W(cursor,BASE_TYPE)));
            *delta=0;
        }
        *delta=*delta+*((int far *)MK_FP(BASE_LIST_SEG,cursor+BASE_OFFSET));
    }
    *state=1;
}

/* ---- CONVERT_DERIVED_TO_BASE (listing ovr_1dad_add3:E08D) ---- */
unsigned int far pascal CONVERT_DERIVED_TO_BASE(unsigned int node,unsigned int target, unsigned int middle,unsigned int type, unsigned char flag,unsigned char extra);
extern void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *,unsigned int far *);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal CHECK_CAST(unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
/* CONVERT_DERIVED_TO_BASE: converts node, a pointer to class target, to a pointer to
   base class type, going through class middle first when it is not 0. With flag the
   value is a reference: the result is retyped as a reference and no null test is
   made. Otherwise, when extra is set and the conversion is not a no-op, the pointer
   is saved in a temporary and tested: p ? adjusted : (char *)p. Without any offset
   the conversion is just a checked cast. */
unsigned int far pascal CONVERT_DERIVED_TO_BASE(unsigned int node,unsigned int target,
                                 unsigned int middle,unsigned int type,
                                 unsigned char flag,unsigned char extra)
{
    unsigned int first,second;
    unsigned char state;
    unsigned int result,temp;
    _SI=middle;
    _DI=type;
    if (_DI!=target) {
        if (flag) extra=0;
        first=0;
        second=0;
        ACCUMULATE_BASE_OFFSET(_DI,_SI==0?target:_SI,&first,&second,&state);
        if (_SI) ACCUMULATE_BASE_OFFSET(_SI,target,&first,&second,&state);
        if (first || second) {
            node=STRIP_REFERENCE(node);
            temp=0;
            if (extra) SAVE_EXPR_IN_TEMP(&node,&temp);
            result=BUILD_BASE_ADJUST_EXPR(second,first,node);
            if (extra) {
                result=MAKE_CONDITIONAL_NODE(0x20,COPY_EXPR_TREE(node),result,
                    MAKE_CAST_NODE(CHAR_POINTER_TYPE,COPY_EXPR_TREE(node)));
            }
            node=JOIN_COMMA_EXPR(temp,MAKE_CAST_NODE(MAKE_POINTER_TYPE(_DI,0,0),result));
            node=ANALYZE_EXPRESSION(node,0,0);
            /* Keep the conversion result in the argument slot at the join. */
            if (flag) { node=MAKE_REFERENCE(node); _SI=_SI; }
        } else {
            node=CHECK_CAST(MAKE_CAST_NODE(MAKE_POINTER_TYPE(_DI,0,flag),node));
        }
    }
    return node;
}

/* ---- CONVERT_BASE_TO_DERIVED (listing ovr_1dad_add3:E1D1) ---- */
unsigned int far pascal CONVERT_BASE_TO_DERIVED(unsigned int node,unsigned int target, unsigned int type,unsigned char flag);
extern void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *,unsigned int far *);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal CHECK_CAST(unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
/* CONVERT_BASE_TO_DERIVED: converts node, a pointer to base class target, to a pointer
   to derived class type by subtracting the base's constant offset (a virtual base
   cannot be converted this way; only the constant part is used). A pointer (flag 0)
   gets the null test; a reference (flag 1) is retyped as a reference. */
unsigned int far pascal CONVERT_BASE_TO_DERIVED(unsigned int node,unsigned int target,
                                 unsigned int type,unsigned char flag)
{
    unsigned int first,second;
    unsigned char state;
    unsigned int temp;
    _SI=type;
    first=0;
    second=0;
    ACCUMULATE_BASE_OFFSET(target,_SI,&first,&second,&state);
    if (first) {
        node=STRIP_REFERENCE(node);
        SAVE_EXPR_IN_TEMP(&node,&temp);
        _DI=BUILD_BASE_ADJUST_EXPR(0,-first,node);
        if (!flag) {
            _DI=MAKE_CONDITIONAL_NODE(0x20,COPY_EXPR_TREE(node),_DI,
                MAKE_CAST_NODE(CHAR_POINTER_TYPE,COPY_EXPR_TREE(node)));
        }
        node=JOIN_COMMA_EXPR(temp,MAKE_CAST_NODE(MAKE_POINTER_TYPE(_SI,0,0),_DI));
        node=ANALYZE_EXPRESSION(node,0,0);
        if (flag) { node=MAKE_REFERENCE(node); _SI=_SI; }
    } else {
        node=CHECK_CAST(MAKE_CAST_NODE(MAKE_POINTER_TYPE(_SI,0,flag),node));
    }
    return node;
}

/* ---- ADJUST_MEMBER_FUNC_PTR_BASE (listing ovr_1dad_add3:E2CB) ---- */
unsigned int far pascal ADJUST_MEMBER_FUNC_PTR_BASE(unsigned int node,unsigned int left, unsigned int right,unsigned int temp);
extern unsigned int EXPR_POOL_SEG;
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern unsigned char far pascal IS_SIDE_EFFECT_FREE(unsigned int);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
/* ADJUST_MEMBER_FUNC_PTR_BASE: converts a pointer to member function between classes
   left and right. node is the conversion node (it is freed; its operand is used and
   the result gets the node's type). The offset between the classes is added to the
   pointer's this-adjust part: directly for a 0x48 constant, otherwise through a
   temporary: (tmp = value, tmp.delta += tmp ? offset : 0, tmp), where delta is the
   member MEMBER_PTR_DELTA_MEMBER of the struct MEMBER_PTR_CLASS_TYPE (token 0x0C is
   probably '+='). temp is a side-effect-free place to use, or 0 to make a new local. */
unsigned int far pascal ADJUST_MEMBER_FUNC_PTR_BASE(register unsigned int node,unsigned int left,
                                 unsigned int right,unsigned int temp)
{
    unsigned int saved;
    int delta;
    unsigned int unused;
    unsigned char state;
    unsigned int result;
    register unsigned int aux;
    delta=0;
    unused=0;
    state=0;
    saved=EXPR_W(node,EXPR_TYPE);
    aux=node;
    node=EXPR_W(aux,EXPR_LEFT);
    FREE_EXPR_NODE(aux);
    if (IS_BASE_CLASS(left,right,0)) {
        ACCUMULATE_BASE_OFFSET(left,right,&delta,&unused,&state);
    } else {
        ACCUMULATE_BASE_OFFSET(right,left,&delta,&unused,&state);
        delta=-delta;
    }
    if (delta) {
        if (EXPR_W(node,EXPR_OP)==0x48) {
            EXPR_W(node,EXPR_LEFT)+=delta;
        } else {
            if (!temp || !IS_SIDE_EFFECT_FREE(temp))
                temp=ANALYZE_EXPRESSION(MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(saved)),0,0);
            aux=COPY_EXPR_TREE(temp);
            EXPR_W(aux,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
            node=MAKE_BINARY_NODE(0x0B,aux,node);
            aux=COPY_EXPR_TREE(temp);
            EXPR_W(aux,EXPR_TYPE)=MEMBER_PTR_CLASS_TYPE;
            aux=MAKE_BINARY_NODE(0x2F,aux,MAKE_FIELD_REF_NODE(MEMBER_PTR_DELTA_MEMBER));
            result=MAKE_CONDITIONAL_NODE(0x20,COPY_EXPR_TREE(temp),
                MAKE_INT_CONSTANT(INT_TYPE,(long)delta),MAKE_INT_CONSTANT(INT_TYPE,0L));
            aux=MAKE_BINARY_NODE(0x0C,aux,result);
            node=JOIN_COMMA_EXPR(node,aux);
            node=ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(node,COPY_EXPR_TREE(temp)),0,0);
        }
    }
    EXPR_W(node,EXPR_TYPE)=saved;
    return node;
}

/* ---- ADJUST_NODE_BASE_OFFSET (listing ovr_1dad_add3:E460) ---- */
unsigned int far pascal ADJUST_NODE_BASE_OFFSET(unsigned int node,unsigned int left,unsigned int right);
extern unsigned int EXPR_POOL_SEG;
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
/* ADJUST_NODE_BASE_OFFSET: the same for a pointer to data member, which is an offset:
   adds the difference between classes left and right to a constant, or builds
   (type)((int)value + offset). node is the conversion node and is freed. */
unsigned int far pascal ADJUST_NODE_BASE_OFFSET(register unsigned int node,unsigned int left,unsigned int right)
{
    int delta;
    unsigned int unused;
    unsigned char state;
    unsigned int saved;
    register unsigned int type;
    delta=0;
    unused=0;
    state=0;
    type=EXPR_W(node,EXPR_TYPE);
    saved=node;
    node=EXPR_W(saved,EXPR_LEFT);
    FREE_EXPR_NODE(saved);
    if (IS_BASE_CLASS(left,right,0)) {
        ACCUMULATE_BASE_OFFSET(left,right,&delta,&unused,&state);
    } else {
        ACCUMULATE_BASE_OFFSET(right,left,&delta,&unused,&state);
        delta=-delta;
    }
    if (delta==0) {
restore:
        EXPR_W(node,EXPR_TYPE)=type;
        return node;
    }
    if (EXPR_W(node,EXPR_OP)==EOP_CONST) {
        *((long far *)MK_FP(EXPR_POOL_SEG,node+EXPR_LEFT))+=delta;
        goto restore;
    }
    node=MAKE_CAST_NODE(INT_TYPE,node);
    node=MAKE_BINARY_NODE(0x16,node,MAKE_INT_CONSTANT(INT_TYPE,(long)delta));
    node=MAKE_CAST_NODE(type,node);
    return ANALYZE_EXPRESSION(node,type,0);
}

/* ---- GET_BASE_OFFSET (listing ovr_1dad_add3:E54E) ---- */
unsigned int far pascal GET_BASE_OFFSET(unsigned int left,unsigned int right);
extern void far pascal FREE_EXPR_TREE(unsigned int);
extern unsigned int far pascal COLLECT_VBASES(unsigned int);
extern void far pascal FREE_PARAM_ITEM(unsigned int);
/* GET_BASE_OFFSET: the offset of base class left inside class right as a constant: 0
   when left is not a base of right; when the path goes through a virtual base, the
   offset of left in COLLECT_VBASES(right) (right taken as a complete object; 0 if left
   is not itself one of the virtual bases). */
unsigned int far pascal GET_BASE_OFFSET(unsigned int left,unsigned int right)
{
    unsigned int first,second;
    unsigned char state;
    unsigned int result;
    register unsigned int cursor;
    register unsigned int entry;
    first=0;
    second=0;
    state=0;
    ACCUMULATE_BASE_OFFSET(left,right,&first,&second,&state);
    if (!state) return 0;
    if (second==0) return first;
    FREE_EXPR_TREE(second);
    cursor=COLLECT_VBASES(right);
    result=0;
    while (cursor) {
        if (TYPE_W(BASE_W(cursor,BASE_TYPE),TYPE_TAG_BODY)==TYPE_W(left,TYPE_TAG_BODY))
            result=BASE_W(cursor,BASE_OFFSET);
        entry=cursor;
        cursor=BASE_W(cursor,BASE_NEXT);
        FREE_PARAM_ITEM(entry);
    }
    return result;
}

/* ---- CONSTRUCT_TEMP_OBJECT (listing ovr_1dad_add3:E5F0) ---- */
unsigned int far pascal CONSTRUCT_TEMP_OBJECT(unsigned int type,unsigned int value,register unsigned int node);
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_SIDE_EFFECT_FREE(unsigned int);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal BUILD_CONSTRUCTOR_CALL(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal REGISTER_TEMP_DESTRUCTOR(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
#define CURRENT_WORD(n) (*((unsigned int far *)MK_FP(SCOPE_POOL_SEG,CURRENT_SCOPE+(n))))
/* CONSTRUCT_TEMP_OBJECT: constructs an object of type with argument list value.
   When node is an object of the same type without side effects, it is constructed
   in place: (node.type(value), node). Otherwise a new local temporary is used,
   giving *(tmp.type(value), &tmp), and the temporary's destructor is put on the
   current scope's SCOPE_TEMPS list (scope word 16). Returns the analyzed tree. */
unsigned int far pascal CONSTRUCT_TEMP_OBJECT(unsigned int type,unsigned int value,register unsigned int node)
{
    unsigned int temp;
    register unsigned int result;
    if (node) {
        if (!TYPES_COMPATIBLE(EXPR_W(node,EXPR_TYPE),type,1) || !IS_SIDE_EFFECT_FREE(node)) node=0;
    }
    if (node==0) temp=MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(type));
    else temp=COPY_EXPR_TREE(node);
    result=COPY_EXPR_TREE(temp);
    if (node==0) result=MAKE_UNARY_NODE(0x1D,result);
    result=JOIN_COMMA_EXPR(BUILD_CONSTRUCTOR_CALL(temp,type,value),result);
    if (node==0) {
        result=MAKE_UNARY_NODE(0x18,result);
        CURRENT_WORD(16)=REGISTER_TEMP_DESTRUCTOR(COPY_EXPR_TREE(temp),type,CURRENT_WORD(16));
    }
    return ANALYZE_EXPRESSION(result,0,0);
}
#undef CURRENT_WORD

/* ---- IS_OBJECT_RVALUE (listing ovr_1dad_add3:E6BF) ---- */
unsigned char far pascal IS_OBJECT_RVALUE(register unsigned int node);
extern unsigned int EXPR_POOL_SEG;
extern unsigned char far pascal IS_LVALUE(unsigned int);
/* IS_OBJECT_RVALUE: tells whether node is an expression that
   yields an object in C++ although it is not a plain lvalue: an assignment or compound
   assignment, a ++ or -- without node flag 2 (the prefix form, probably), a comma
   whose right side is such an object, or a ?: whose two arms both are. Other side
   effects (calls, postfix ++) give 0. */
unsigned char far pascal IS_OBJECT_RVALUE(register unsigned int node)
{
    register unsigned int child;
    switch(EXPR_W(node,EXPR_OP)) {
    case EOP_INC: case EOP_DEC:
        return !(*((unsigned char far *)MK_FP(EXPR_POOL_SEG,node+EXPR_NODE_FLAGS))&2);
    case EOP_COMMA:
        return IS_LVALUE(EXPR_W(node,EXPR_RIGHT)) || IS_OBJECT_RVALUE(EXPR_W(node,EXPR_RIGHT));
    case EOP_QUESTION:
        child=EXPR_W(node,EXPR_RIGHT);
        return (IS_LVALUE(EXPR_W(child,EXPR_LEFT)) || IS_OBJECT_RVALUE(EXPR_W(child,EXPR_LEFT))) &&
               (IS_LVALUE(EXPR_W(child,EXPR_RIGHT)) || IS_OBJECT_RVALUE(EXPR_W(child,EXPR_RIGHT)));
    case EOP_ASSIGN: case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN: case EOP_DIV_ASSIGN: case EOP_MOD_ASSIGN:
    case EOP_SHL_ASSIGN: case EOP_SHR_ASSIGN: case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN:
        return 1;
    default:
        return 0;
    }
}

/* ---- REWRITE_FOR_REFERENCE_BIND (listing ovr_1dad_add3:E7C0) ---- */
unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(unsigned int node);
extern unsigned int EXPR_POOL_SEG;
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);
extern void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *,unsigned int far *);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
/* REWRITE_FOR_REFERENCE_BIND: makes an object-yielding expression (see
   IS_OBJECT_RVALUE) addressable, before & is applied or a reference is bound:
   x op= y becomes *(save, x op= y, &x) with x's address kept in a temporary when
   needed; for comma (op 42) and ?: (op 37) the parts are rewritten and their
   addresses taken. Lvalues, references and other expressions are returned as they
   are. */
unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(register unsigned int node)
{
    unsigned int kind,value,temp;
    register unsigned int child;
    kind=EXPR_W(node,EXPR_OP);
    if (EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x14) {
        if (TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_ATTRS)&0x20) goto unchanged;
    }
    if (IS_LVALUE(node) || !IS_OBJECT_RVALUE(node)) {
unchanged:
        return node;
    }
    if (kind==42) {
        EXPR_W(node,EXPR_RIGHT)=MAKE_ADDRESS_OF(REWRITE_FOR_REFERENCE_BIND(EXPR_W(node,EXPR_RIGHT)));
    } else if (kind==37) {
        child=EXPR_W(node,EXPR_RIGHT);
        EXPR_W(child,EXPR_LEFT)=MAKE_ADDRESS_OF(REWRITE_FOR_REFERENCE_BIND(EXPR_W(child,EXPR_LEFT)));
        EXPR_W(child,EXPR_RIGHT)=MAKE_ADDRESS_OF(REWRITE_FOR_REFERENCE_BIND(EXPR_W(child,EXPR_RIGHT)));
    } else {
        value=EXPR_W(node,EXPR_LEFT);
        temp=0;
        SAVE_EXPR_IN_TEMP(&value,&temp);
        value=ANALYZE_EXPRESSION(value,0,0);
        EXPR_W(node,EXPR_LEFT)=value;
        node=JOIN_COMMA_EXPR(JOIN_COMMA_EXPR(temp,node),MAKE_ADDRESS_OF(COPY_EXPR_TREE(value)));
    }
    *((unsigned char far *)MK_FP(EXPR_POOL_SEG,node+EXPR_NODE_FLAGS))&=0xFE;
    return ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x18,node),0,0);
}

/* target: ovr133_C85UNIT */
/* Role: expressions: expression-node constructors (binary, leaf, constant, real, bitfield),
   retyping and narrowing, compound assignment and post-increment expansion, side-effect
   test. Entry points: EXPR_POOL_IS_RESET, RESET_EXPR_POOL, NEW_EXPR_NODE, NEW_EXPR_LEAF,
   NEW_EXPR_NODE_MODE, NEW_CONSTANT_EXPR, NEW_REAL_CONSTANT_NODE, NEW_BITFIELD_NODE (+7
   more). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO04C (ovr_1d13_99b3) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: expression-node building for the C-mode front end (the STMTC.C side; the
   C++-mode front end uses expr/EXPRPOOL.C). Here nodes are 20-byte records taken from EXPR_POOL_SEG with
   POOL_ALLOC and never freed one by one: the whole pool is emptied with
   RESET_EXPR_POOL, probably after each statement or function. Most of these functions
   are installed in the front-end hook table (NEW_EXPR_NODE_HOOK, NEW_CONST_NODE_HOOK,
   NEW_BITFIELD_NODE_HOOK, ...), so callers usually reach them through those pointers.
   Besides the constructors the file has:
   - CONVERT_EXPRESSION_TYPE, the C conversion of a node to another type: it folds
     constants, retypes a node in place where the bits do not change, and otherwise
     wraps it in a cast node (operator 0x35);
   - NARROW_INTEGER_EXPR and its helpers, which find the narrowest integer kind an
     integer expression can be computed in without changing the result (probably so
     the code generator can use byte operations);
   - EXPAND_COMPOUND_ASSIGN and EXPAND_POST_INC_DEC, which rewrite x op= y and x++ into
     plain assignments without evaluating side effects in x twice;
   - TREE_HAS_SIDE_EFFECTS.
   Leaf operators below 8 are numbers here: 1, 4, 5 and 6 are symbol leaves (5 a local
   temporary as made by HOIST_LVALUE_ADDR_TO_TEMP), 2 EOP_CONST, 3 a long double
   constant; 0x33 is a bitfield access, 0x35 a cast, 0x36 a call.
   Per-operator tables EXPR_RETYPE_SHAPE and EXPR_NARROW_SHAPE say how a node may be
   retyped or narrowed (0 not at all, 1 a leaf, 2 a cast, 3 a constant, otherwise flag
   bits for "recurse into left/right"). KIND_INFO_TABLE has a 4-byte row per kind: byte 0
   is used as the size and byte 1 probably as an integer rank. LANGUAGE_MODE is the
   language mode; 1 is strict ANSI (see lexer/LEXER.C), which turns off
   the in-place shortcuts. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- STOVR58 (listing ovr_1d13_99b3:9B30) ---- */
/* EXPR_POOL_IS_RESET: 1 when nothing has been allocated in the expression pool since
   the last reset. */
int far pascal EXPR_POOL_IS_RESET(void)
{
    if(EXPR_POOL_UNIT>2) return 0;
    return 1;
}

/* ---- STOVR59 (listing ovr_1d13_99b3:9B43) ---- */
/* RESET_EXPR_POOL: frees every expression node at once. */
void far pascal RESET_EXPR_POOL(void)
{
    EXPR_POOL_USED=0;
    EXPR_POOL_UNIT=2;
}

/* ---- STOVR60 (listing ovr_1d13_99b3:9B54) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
/* NEW_EXPR_NODE: node with operator kind, type (the value kind EXPR_KIND is taken from
   the type) and two operands. */
unsigned int far pascal NEW_EXPR_NODE(signed char kind,register unsigned int type,unsigned int left,unsigned int right)
{
    register unsigned int node;
    node=POOL_ALLOC(&EXPR_POOL_SEG,20);
    EXPR_I(node,EXPR_TYPE)=type;
    EXPR_I(node,EXPR_OP)=kind;
    EXPR_I(node,EXPR_QUAL_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    if(type) EXPR_I(node,EXPR_KIND)=GET_TYPE_KIND_HOOK(type);
    else EXPR_I(node,EXPR_KIND)=TK_UNDEFINED;
    EXPR_I(node,EXPR_LEFT)=left;
    EXPR_I(node,EXPR_RIGHT)=right;
    return node;
}

/* ---- STOVR61 (listing ovr_1d13_99b3:9BC4) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
/* NEW_EXPR_LEAF: leaf with operator kind and type; value goes to EXPR_RIGHT and
   EXPR_LEFT is 0. */
unsigned int far pascal NEW_EXPR_LEAF(signed char kind,unsigned int type,unsigned int value)
{
    register unsigned int node;
    register unsigned int saved_type=type;
    node=POOL_ALLOC(&EXPR_POOL_SEG,20);
    EXPR_I(node,EXPR_TYPE)=saved_type;
    EXPR_I(node,EXPR_OP)=kind;
    EXPR_I(node,EXPR_QUAL_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    if(saved_type) EXPR_I(node,EXPR_KIND)=GET_TYPE_KIND_HOOK(saved_type);
    else EXPR_I(node,EXPR_KIND)=TK_UNDEFINED;
    EXPR_I(node,EXPR_RIGHT)=value;
    EXPR_I(node,EXPR_LEFT)=0;
    return node;
}

/* ---- STOVR62 (listing ovr_1d13_99b3:9C33) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
/* NEW_EXPR_NODE_MODE: like NEW_EXPR_NODE, also setting EXPR_QUAL_FLAGS to mode. */
unsigned int far pascal NEW_EXPR_NODE_MODE(signed char kind,register unsigned int type,unsigned int left,unsigned int right,signed char mode)
{
    register unsigned int node;
    node=POOL_ALLOC(&EXPR_POOL_SEG,20);
    EXPR_I(node,EXPR_TYPE)=type;
    EXPR_I(node,EXPR_OP)=kind;
    EXPR_I(node,EXPR_QUAL_FLAGS)=mode;
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    if(type) EXPR_I(node,EXPR_KIND)=GET_TYPE_KIND_HOOK(type);
    else EXPR_I(node,EXPR_KIND)=TK_UNDEFINED;
    EXPR_I(node,EXPR_LEFT)=left;
    EXPR_I(node,EXPR_RIGHT)=right;
    return node;
}

/* ---- STOVR63 (listing ovr_1d13_99b3:9CA5) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
/* NEW_CONSTANT_EXPR: integer constant node of type with the long value. */
unsigned int far pascal NEW_CONSTANT_EXPR(register unsigned int type,long value)
{
    register unsigned int node;
    node=POOL_ALLOC(&EXPR_POOL_SEG,20);
    EXPR_I(node,EXPR_TYPE)=type;
    EXPR_I(node,EXPR_OP)=EOP_CONST;
    EXPR_I(node,EXPR_QUAL_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    if(type) EXPR_I(node,EXPR_KIND)=GET_TYPE_KIND_HOOK(type);
    else EXPR_I(node,EXPR_KIND)=TK_UNDEFINED;
    *(long far *)MK_FP(EXPR_POOL_SEG,node+EXPR_LEFT)=value;
    return node;
}

/* ---- STOVR64 (listing ovr_1d13_99b3:9D13) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
/* NEW_REAL_CONSTANT_NODE: floating constant (operator 3) from 10 bytes at value. */
unsigned int far pascal NEW_REAL_CONSTANT_NODE(void far *value,register unsigned int type)
{
    register unsigned int node;
    node=POOL_ALLOC(&EXPR_POOL_SEG,20);
    EXPR_I(node,EXPR_TYPE)=type;
    EXPR_I(node,EXPR_OP)=3;
    EXPR_I(node,EXPR_KIND)=GET_TYPE_KIND_HOOK(type);
    EXPR_I(node,EXPR_QUAL_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,node+EXPR_LEFT),value,10);
    return node;
}

/* ---- STOVR65 (listing ovr_1d13_99b3:9D78) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
/* NEW_BITFIELD_NODE: bitfield access (operator 0x33) of the object value; left is the
   width and right the shift. */
unsigned int far pascal NEW_BITFIELD_NODE(unsigned int value,register unsigned int type,unsigned char left,unsigned char right)
{
    register unsigned int node=POOL_ALLOC(&EXPR_POOL_SEG,20);
    EXPR_W(node,EXPR_TYPE)=type;
    EXPR_W(node,EXPR_OP)=0x33;
    EXPR_W(node,EXPR_KIND)=GET_TYPE_KIND_HOOK(type);
    EXPR_W(node,EXPR_QUAL_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    EXPR_W(node,EXPR_LEFT)=value;
    EXPR_B(node,EXPR_BIT_WIDTH)=left;
    EXPR_B(node,EXPR_BIT_SHIFT)=right;
    return node;
}

/* ---- STOVR66 (listing ovr_1d13_99b3:9DD9) ---- */
int far pascal IS_ADDRESSABLE_NODE(unsigned int node);
static unsigned int near pascal RETYPE_EXPR_TREE(register unsigned int node,unsigned char kind);
void far pascal SEG_PTR_FROM_FAR_ADJUST(register unsigned int node,unsigned int oldkind,unsigned int kind);
extern unsigned int EXPR_POOL_SEG;
extern unsigned char LANGUAGE_MODE;
extern signed char KIND_INFO_TABLE[];
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern int (far pascal *IS_BASED_POINTER_HOOK)(unsigned int);
extern unsigned int (far pascal *GET_TYPE_FLAGS_ALT_HOOK)(unsigned int);
extern long (far pascal *TOKEN_CONVERT)(long,int);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);
extern int far pascal TYPE_RECORDS_COMPATIBLE(unsigned int,unsigned int,signed char);
extern unsigned int far pascal APPLY_BASED_POINTER_C(unsigned int);
extern void far pascal RTL_ULONG_TO_LDOUBLE(unsigned long,void far *);
extern void far pascal RTL_LONG_TO_LDOUBLE(long,void far *);
extern void far pascal RTL_LDOUBLE_ROUND_TO_FLOAT(void far *);
extern void far pascal RTL_LDOUBLE_ROUND_TO_DOUBLE(void far *);
extern unsigned long far pascal RTL_LDOUBLE_TO_ULONG(void far *);
extern long far pascal RTL_LDOUBLE_TO_LONG(void far *);
extern int far pascal LEX_COMPARE(char far *);
/* CONVERT_EXPRESSION_TYPE: converts node to type and returns the new tree, or 0 when the
   conversion is impossible (to an array, function, struct or union; between a pointer
   and a floating type; from void, struct or union); the caller reports the error. An
   error node (operator 0) is returned unchanged; enums convert as their int or char
   type. Constant operands are converted at compile time, using the run-time long double
   helpers for floating values. */
unsigned int far pascal CONVERT_EXPRESSION_TYPE(unsigned int node,unsigned int type)
{
    unsigned int oldkind,size,oldsize;
    char temp[10];
    register unsigned int current=node;
    register unsigned int kind;
    if(EXPR_W(current,EXPR_OP)==0) return current;
    current=FOLD_EXPRESSION(current);
    if(TYPE_B(type,TYPE_KIND)==TK_ENUM) type=TYPE_W(type,TYPE_C_SIZE)==1 ? MODE_HOOK(1) : PLAIN_INT_TYPE;
    if(EXPR_W(current,EXPR_TYPE)==type) return current;
    oldkind=EXPR_W(current,EXPR_KIND);
    kind=GET_TYPE_KIND_HOOK(type);
    /* first, targets that need no work or are impossible */
    switch(kind) {
    case 12: return NEW_EXPR_NODE_HOOK(0x35,type,current,0);
    case 17: case 18: case 19: case 20: return 0;
    case 13: case 14: case 15: case 16:
        if(EXPR_W(current,EXPR_OP)==EOP_ADDR && oldkind==kind && TYPE_RECORDS_COMPATIBLE(EXPR_W(current,EXPR_TYPE),type,1)) {
            EXPR_W(current,EXPR_TYPE)=type;return current;
        }
        break;
    }
    /* then sources: pointers (based pointers become far first), floats, void */
    switch(oldkind) {
    case 13: case 14: case 15: case 16:
        if(EXPR_FLAGS[kind]&2) return 0;
        if(IS_BASED_POINTER_HOOK(EXPR_W(current,EXPR_TYPE)) && kind==15) current=APPLY_BASED_POINTER_C(current);
        if(EXPR_W(current,EXPR_OP)==EOP_CONST && kind==15 && oldkind!=15) goto convert;
        if(LANGUAGE_MODE!=1 && kind==oldkind && GET_TYPE_FLAGS_ALT_HOOK(EXPR_W(current,EXPR_TYPE))==GET_TYPE_FLAGS_ALT_HOOK(type)) {
            EXPR_W(current,EXPR_TYPE)=type;return current;
        }
        break;
    case 9: case 10:
        if(EXPR_FLAGS[kind]&0x14) return 0;
        break;
    case 12: case 19: case 20: return 0;
    }
    /* an addressable object (symbol or *p) narrowed to a smaller integer or pointer can
       just be read with the smaller type (a far to _seg conversion reads the segment word) */
    if(LANGUAGE_MODE!=1 && IS_ADDRESSABLE_NODE(current) && !(EXPR_FLAGS[oldkind]&2) && !(EXPR_FLAGS[kind]&2)) {
        size=SIZE_OF_TYPE_CHECKED_HOOK(type);
        oldsize=SIZE_OF_TYPE_CHECKED_HOOK(EXPR_W(current,EXPR_TYPE));
        if(size>oldsize) goto convert;
        SEG_PTR_FROM_FAR_ADJUST(current,oldkind,kind);
        EXPR_W(current,EXPR_KIND)=kind;EXPR_W(current,EXPR_TYPE)=type;return current;
    }
    if(EXPR_W(current,EXPR_OP)==EOP_ADDR && (EXPR_FLAGS[kind]&0x14)) {
        EXPR_W(current,EXPR_KIND)=kind;EXPR_W(current,EXPR_TYPE)=type;return current;
    }
    if(LANGUAGE_MODE!=1 && KIND_INFO_TABLE[oldkind*4]==KIND_INFO_TABLE[kind*4]) {
        EXPR_W(current,EXPR_KIND)=kind;EXPR_W(current,EXPR_TYPE)=type;return current;
    }
    /* integer constant: convert the value now */
    if(EXPR_W(current,EXPR_OP)==EOP_CONST) {
        switch(kind) {
        case 9: case 10: case 11:
            if(EXPR_FLAGS[oldkind]&0x20) RTL_ULONG_TO_LDOUBLE((unsigned long)EXPR_L(current,EXPR_VALUE),temp);
            else RTL_LONG_TO_LDOUBLE(EXPR_L(current,EXPR_VALUE),temp);
            if(kind==9) RTL_LDOUBLE_ROUND_TO_FLOAT(temp);
            else if(kind==10) RTL_LDOUBLE_ROUND_TO_DOUBLE(temp);
            if(LANGUAGE_MODE==1 && LEX_COMPARE(temp)) REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
            return NEW_REAL_CONSTANT_NODE(temp,type);
        case 14:
            if(oldkind==15 || oldkind==16 || oldkind==8 || oldkind==7)
                EXPR_L(current,EXPR_VALUE)=(unsigned long)EXPR_W(current,EXPR_RIGHT);
            break;
        }
        EXPR_L(current,EXPR_VALUE)=TOKEN_CONVERT(EXPR_L(current,EXPR_VALUE),kind);
        EXPR_W(current,EXPR_KIND)=kind;EXPR_W(current,EXPR_TYPE)=type;return current;
    }
    /* floating constant: round to float/double, or turn it into an integer constant */
    if(EXPR_W(current,EXPR_OP)==3) {
        RTL_MEMMOVE(temp,MK_FP(EXPR_POOL_SEG,current+EXPR_LEFT),10);
        if(kind==9) {
            RTL_LDOUBLE_ROUND_TO_FLOAT(temp);
            RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,current+EXPR_LEFT),temp,10);
        } else if(kind==10) {
            RTL_LDOUBLE_ROUND_TO_DOUBLE(temp);
            RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,current+EXPR_LEFT),temp,10);
        } else if(kind!=11) {
            if(EXPR_FLAGS[kind]&0x20) EXPR_L(current,EXPR_VALUE)=RTL_LDOUBLE_TO_ULONG(temp);
            else EXPR_L(current,EXPR_VALUE)=RTL_LDOUBLE_TO_LONG(temp);
            EXPR_W(current,EXPR_OP)=EOP_CONST;
        }
        EXPR_W(current,EXPR_KIND)=kind;EXPR_W(current,EXPR_TYPE)=type;return current;
    }
    /* narrowing an integer expression: push the narrower type down into the tree where
       the operators allow it */
    if(LANGUAGE_MODE!=1 && (EXPR_FLAGS[kind]&1) && (EXPR_FLAGS[oldkind]&1) && KIND_INFO_TABLE[kind*4+1]<KIND_INFO_TABLE[oldkind*4+1]) {
        if(EXPR_RETYPE_SHAPE[EXPR_W(current,EXPR_OP)]==0)
            return NEW_EXPR_NODE_HOOK(0x35,type,current,0);
        else return RETYPE_EXPR_TREE(current,GET_TYPE_KIND_HOOK(type));
    }
    /* (float)(double)f gives back f */
    if(LANGUAGE_MODE!=1 && kind==9 && oldkind==10 && EXPR_W(current,EXPR_OP)==0x35 && EXPR_W(EXPR_W(current,EXPR_LEFT),EXPR_KIND)==TK_FLOAT)
        return EXPR_W(current,EXPR_LEFT);
convert:
    return NEW_EXPR_NODE_HOOK(0x35,type,current,0);
}

/* ---- STOVR68 (listing ovr_1d13_99b3:A275) ---- */
extern unsigned int EXPR_POOL_SEG;
extern signed char KIND_INFO_TABLE[];
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern long (far pascal *TOKEN_CONVERT)(long,int);
/* RETYPE_EXPR_TREE: gives the tree node the integer kind "kind" (narrower than its own),
   pushing the new type down into operands as the shape table allows; operands that
   cannot be retyped get a real conversion. */
static unsigned int near pascal RETYPE_EXPR_TREE(register unsigned int node,unsigned char kind)
{
    int oldkind;
    signed char shape;
    register unsigned int type;
    if(!node || !EXPR_W(node,EXPR_OP)) return 0;
    type=MODE_HOOK(kind);
    shape=EXPR_RETYPE_SHAPE[EXPR_W(node,EXPR_OP)];
    switch(shape) {
    case 0: return CONVERT_EXPRESSION_TYPE(node,type);
    case 1: SEG_PTR_FROM_FAR_ADJUST(node,EXPR_W(node,EXPR_KIND),kind);break;
    case 3: EXPR_L(node,EXPR_VALUE)=TOKEN_CONVERT(EXPR_L(node,EXPR_VALUE),kind);break;
    case 2:
        oldkind=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_KIND);
        if(oldkind>8) { EXPR_W(node,EXPR_KIND)=kind;EXPR_W(node,EXPR_TYPE)=type;return node; }
        if(KIND_INFO_TABLE[kind*4+1]>KIND_INFO_TABLE[oldkind*4+1]) { EXPR_W(node,EXPR_KIND)=kind;EXPR_W(node,EXPR_TYPE)=type;return node; }
        return RETYPE_EXPR_TREE(EXPR_W(node,EXPR_LEFT),kind);
    default:
        if((unsigned char)(shape&0x10)) EXPR_W(node,EXPR_LEFT)=RETYPE_EXPR_TREE(EXPR_W(node,EXPR_LEFT),kind);
        if((unsigned char)(shape&0x20)) EXPR_W(node,EXPR_RIGHT)=RETYPE_EXPR_TREE(EXPR_W(node,EXPR_RIGHT),kind);
    }
    EXPR_W(node,EXPR_KIND)=kind;
    EXPR_W(node,EXPR_TYPE)=type;
    return node;
}

/* ---- STOVR70 (listing ovr_1d13_99b3:A3A9) ---- */
extern unsigned int EXPR_POOL_SEG;
extern signed char KIND_INFO_TABLE[];
struct Range { long minimum,maximum; };
extern struct Range TYPE_RANGE_TABLE[];
/* NARROWEST_EXPR_KIND: smallest integer kind (by kind number) that can represent the
   value of the tree item: a constant uses TYPE_RANGE_TABLE (min/max per kind) to find
   the smallest kind holding it; a widening cast looks through to its operand; other
   operators take the larger of their operands' kinds. */
static unsigned char near pascal NARROWEST_EXPR_KIND(unsigned int item)
{
    int current,candidate;
    unsigned char left,right;
    long value;
    register unsigned int node=item;
    register int flags;
    if(node==0) return 0;
    flags=EXPR_NARROW_SHAPE[EXPR_I(node,EXPR_OP)];
    switch(flags) {
    case 0:
        return (unsigned char)EXPR_I(node,EXPR_KIND);
    case 3:
        value=EXPR_L(node,EXPR_VALUE);
        if(value>=TYPE_RANGE_TABLE[1].minimum && value<=TYPE_RANGE_TABLE[1].maximum) candidate=1;
        else if(value>=0L && value<=TYPE_RANGE_TABLE[2].maximum) candidate=2;
        else if(value>=TYPE_RANGE_TABLE[3].minimum && value<=TYPE_RANGE_TABLE[3].maximum) candidate=3;
        else if(value>=0L && value<=TYPE_RANGE_TABLE[4].maximum) candidate=4;
        else if(value>=TYPE_RANGE_TABLE[5].minimum && value<=TYPE_RANGE_TABLE[5].maximum) candidate=5;
        else if(value>=0L && value<=TYPE_RANGE_TABLE[6].maximum) candidate=6;
        else return (unsigned char)EXPR_I(node,EXPR_KIND);
        if(EXPR_I(node,EXPR_KIND)>candidate) return candidate;
        return (unsigned char)EXPR_I(node,EXPR_KIND);
    case 2:
        current=EXPR_I(node,EXPR_KIND);
        candidate=EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_KIND);
        if(candidate>8 || KIND_INFO_TABLE[current*4+1]<=KIND_INFO_TABLE[candidate*4+1])
            return (unsigned char)EXPR_I(node,EXPR_KIND);
        return NARROWEST_EXPR_KIND(EXPR_I(node,EXPR_LEFT));
    default:
        if(flags&0x40) left=NARROWEST_EXPR_KIND(EXPR_I(node,EXPR_LEFT));
        else left=0;
        if(flags&0x80) right=NARROWEST_EXPR_KIND(EXPR_I(node,EXPR_RIGHT));
        else right=0;
        if(left==0) return right;
        if(right==0 || left>right) return left;
        return right;
    }
}

/* ---- STOVR71 (listing ovr_1d13_99b3:A5D4) ---- */
extern unsigned int EXPR_POOL_SEG;
/* NARROW_INTEGER_EXPR: if node is an int or long expression that could be computed in a
   narrower kind, retypes it to that kind. */
unsigned int far pascal NARROW_INTEGER_EXPR(register unsigned int node)
{
    unsigned char kind;
    if(node==0) return node;
    if(EXPR_I(node,EXPR_KIND)<=TK_UCHAR || EXPR_I(node,EXPR_KIND)>TK_ULONG || EXPR_NARROW_SHAPE[EXPR_I(node,EXPR_OP)]==0)
        return node;
    kind=NARROWEST_EXPR_KIND(node);
    if(EXPR_I(node,EXPR_KIND)==kind) return node;
    return RETYPE_EXPR_TREE(node,kind);
}

/* ---- STOVR72 (listing ovr_1d13_99b3:A62B) ---- */
extern unsigned int EXPR_POOL_SEG;
#define KIND(n) (*(unsigned int far *)MK_FP(EXPR_POOL_SEG,(n)))
/* IS_ADDRESSABLE_NODE: 1 for operators 1, 4, 5, 6 (symbol leaves) and 0x31 (EOP_DEREF),
   i.e. nodes that name memory. */
int far pascal IS_ADDRESSABLE_NODE(register unsigned int node)
{
    return KIND(node)==4 || KIND(node)==6 || KIND(node)==5 ||
           KIND(node)==1 || KIND(node)==0x31;
}
#undef KIND

/* ---- STOVR73 (listing ovr_1d13_99b3:A660) ---- */
static int near pascal EXPR_CONTAINS_CALL(register unsigned int node);
static unsigned int near pascal COPY_TREE_SKIP_POSTINC(register unsigned int node);
static unsigned int near pascal COPY_TREE_SKIP_ASSIGNS(register unsigned int node);
static unsigned int near pascal HOIST_LVALUE_ADDR_TO_TEMP(register unsigned int node);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
/* EXPAND_COMPOUND_ASSIGN: turns "x op= y" (node) into "x = x op y". The operator is
   changed in place (op= minus 11 gives op, e.g. EOP_ADD_ASSIGN to EOP_ADD). If x
   contains a call, its address is computed once into a temporary (see
   HOIST_LVALUE_ADDR_TO_TEMP); otherwise x is copied, the copy read as operand losing
   its post-increments and the copy assigned to losing its assignments, so each side
   effect happens once. */
unsigned int far pascal EXPAND_COMPOUND_ASSIGN(register unsigned int node)
{
    register unsigned int child=EXPR_W(node,EXPR_LEFT);
    EXPR_W(node,EXPR_OP)+=-11;
    if(EXPR_CONTAINS_CALL(child)) EXPR_W(node,EXPR_LEFT)=HOIST_LVALUE_ADDR_TO_TEMP(child);
    else {
        EXPR_W(node,EXPR_LEFT)=COPY_TREE_SKIP_POSTINC(child);
        child=COPY_TREE_SKIP_ASSIGNS(child);
    }
    return NEW_EXPR_NODE_HOOK(0x12,EXPR_W(node,EXPR_TYPE),COPY_TREE_SKIP_ASSIGNS(child),node);
}

/* ---- STOVR74 (listing ovr_1d13_99b3:A6B8) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
/* EXPAND_POST_INC_DEC: turns x++ / x-- (node) into x += 1 / x -= 1 (operator minus 16)
   wrapped in operator 0x29 together with a copy of x, probably a sequence node that
   yields its left operand, so the old value is the result. */
unsigned int far pascal EXPAND_POST_INC_DEC(register unsigned int node)
{
    unsigned int result,converted;
    register unsigned int operand=EXPR_W(node,EXPR_LEFT);
    EXPR_W(node,EXPR_OP)+=-16;
    if(EXPR_CONTAINS_CALL(operand)) converted=HOIST_LVALUE_ADDR_TO_TEMP(operand);
    else {
        converted=COPY_TREE_SKIP_POSTINC(operand);
        EXPR_W(node,EXPR_LEFT)=COPY_TREE_SKIP_ASSIGNS(operand);
    }
    result=NEW_EXPR_NODE_HOOK(0x29,EXPR_W(node,EXPR_TYPE),converted,node);
    return result;
}

/* ---- STOVR75 (listing ovr_1d13_99b3:A712) ---- */
extern unsigned int EXPR_POOL_SEG;
/* EXPR_CONTAINS_CALL: 1 when the tree contains a call (operator 0x36). Leaves are the
   operators up to 7. */
static int near pascal EXPR_CONTAINS_CALL(register unsigned int node)
{
    if(!node) return 0;
    if(EXPR_I(node,EXPR_OP)<=7) return 0;
    if(EXPR_I(node,EXPR_OP)==0x33) return EXPR_CONTAINS_CALL(EXPR_I(node,EXPR_LEFT));
    if(EXPR_I(node,EXPR_OP)==0x36) return 1;
    return EXPR_CONTAINS_CALL(EXPR_I(node,EXPR_LEFT)) || EXPR_CONTAINS_CALL(EXPR_I(node,EXPR_RIGHT));
}

/* ---- STOVR76 (listing ovr_1d13_99b3:A77D) ---- */
static unsigned int near pascal DUPLICATE_EXPR_NODE(unsigned int node);
extern unsigned int EXPR_POOL_SEG;
/* COPY_TREE_SKIP_POSTINC: copies a tree, replacing each x++ / x-- by x. */
static unsigned int near pascal COPY_TREE_SKIP_POSTINC(register unsigned int node)
{
    if(!node) return 0;
    node=DUPLICATE_EXPR_NODE(node);
    if(EXPR_I(node,EXPR_OP)<=7) return node;
    if(EXPR_I(node,EXPR_OP)==0x33) {
        EXPR_I(node,EXPR_LEFT)=COPY_TREE_SKIP_POSTINC(EXPR_I(node,EXPR_LEFT));
        return node;
    }
    if(EXPR_I(node,EXPR_OP)==EOP_POSTINC || EXPR_I(node,EXPR_OP)==EOP_POSTDEC)
        return COPY_TREE_SKIP_POSTINC(EXPR_I(node,EXPR_LEFT));
    EXPR_I(node,EXPR_RIGHT)=COPY_TREE_SKIP_POSTINC(EXPR_I(node,EXPR_RIGHT));
    EXPR_I(node,EXPR_LEFT)=COPY_TREE_SKIP_POSTINC(EXPR_I(node,EXPR_LEFT));
    return node;
}

/* ---- STOVR77 (listing ovr_1d13_99b3:A7F6) ---- */
extern unsigned int EXPR_POOL_SEG;
/* COPY_TREE_SKIP_ASSIGNS: copies a tree, replacing each assignment by its left side. */
static unsigned int near pascal COPY_TREE_SKIP_ASSIGNS(register unsigned int node)
{
    if(!node) return 0;
    node=DUPLICATE_EXPR_NODE(node);
    if(EXPR_I(node,EXPR_OP)<=7) return node;
    if(EXPR_I(node,EXPR_OP)==0x33) {
        EXPR_I(node,EXPR_LEFT)=COPY_TREE_SKIP_ASSIGNS(EXPR_I(node,EXPR_LEFT));
        return node;
    }
    if(EXPR_I(node,EXPR_OP)>=EOP_ASSIGN && EXPR_I(node,EXPR_OP)<=EOP_XOR_ASSIGN)
        return COPY_TREE_SKIP_ASSIGNS(EXPR_I(node,EXPR_LEFT));
    EXPR_I(node,EXPR_RIGHT)=COPY_TREE_SKIP_ASSIGNS(EXPR_I(node,EXPR_RIGHT));
    EXPR_I(node,EXPR_LEFT)=COPY_TREE_SKIP_ASSIGNS(EXPR_I(node,EXPR_LEFT));
    return node;
}

/* ---- STOVR78 (listing ovr_1d13_99b3:A86B) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
struct Node20 { unsigned char bytes[20]; };
/* DUPLICATE_EXPR_NODE: shallow copy of one node. */
static unsigned int near pascal DUPLICATE_EXPR_NODE(unsigned int node)
{
    register unsigned int copy=POOL_ALLOC(&EXPR_POOL_SEG,sizeof(struct Node20));
    *(struct Node20 far *)MK_FP(EXPR_POOL_SEG,copy)=*(struct Node20 far *)MK_FP(EXPR_POOL_SEG,node);
    return copy;
}

/* ---- STOVR79 (listing ovr_1d13_99b3:A89C) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *NEW_TEMPORARY_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_SYMBOL_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_BITFIELD_NODE_HOOK)(unsigned int,unsigned int,unsigned char,unsigned char);
/* HOIST_LVALUE_ADDR_TO_TEMP: node is *p (operator 49, EOP_DEREF), possibly inside a
   bitfield node (operator 51, 0x33). Creates a temporary t for p, changes node in place
   to read *t, and returns a new tree *(t = p) (with the same bitfield wrapper). Using
   the new tree once and node afterwards evaluates p only once. */
static unsigned int near pascal HOIST_LVALUE_ADDR_TO_TEMP(register unsigned int node)
{
    unsigned int root,first,binary,result,classification;
    register unsigned int child;
    if(EXPR_W(node,EXPR_OP)==51) root=EXPR_W(node,EXPR_LEFT);
    else root=node;
    child=EXPR_W(root,EXPR_LEFT);
    classification=NEW_TEMPORARY_HOOK(EXPR_W(child,EXPR_TYPE));
    first=NEW_SYMBOL_NODE_HOOK(5,EXPR_W(child,EXPR_TYPE),classification,0,0);
    EXPR_W(root,EXPR_LEFT)=NEW_SYMBOL_NODE_HOOK(5,EXPR_W(child,EXPR_TYPE),classification,0,0);
    binary=NEW_EXPR_NODE_HOOK(18,EXPR_W(child,EXPR_TYPE),first,child);
    result=NEW_EXPR_NODE_HOOK(49,EXPR_W(root,EXPR_TYPE),binary,0);
    if(EXPR_W(node,EXPR_OP)==51) result=NEW_BITFIELD_NODE_HOOK(result,EXPR_W(node,EXPR_TYPE),EXPR_B(node,EXPR_BIT_WIDTH),EXPR_B(node,EXPR_BIT_SHIFT));
    return result;
}

/* ---- STOVR80 (listing ovr_1d13_99b3:A96D) ---- */
extern unsigned int EXPR_POOL_SEG;
extern int (far pascal *TREE_HAS_SIDE_EFFECTS_HOOK)(unsigned int);
/* TREE_HAS_SIDE_EFFECTS: 1 when the tree contains an assignment, x++/x-- or a call
   (operator 54). Leaves (operators 1-7) have none. Walks the left spine in a loop and
   recurses into right operands through TREE_HAS_SIDE_EFFECTS_HOOK. */
int far pascal TREE_HAS_SIDE_EFFECTS(register unsigned int node)
{
    while(node) {
        switch(EXPR_W(node,EXPR_OP)) {
        case 1: case EOP_CONST: case 3: case 4: case 5: case 6: case 7:
            return 0;
        case EOP_ASSIGN: case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN: case EOP_DIV_ASSIGN: case EOP_MOD_ASSIGN:
        case EOP_SHL_ASSIGN: case EOP_SHR_ASSIGN: case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN:
        case EOP_POSTINC: case EOP_POSTDEC: case 54:
            return 1;
        case 51: node=EXPR_W(node,EXPR_LEFT);break;
        default:
            if(EXPR_W(node,EXPR_RIGHT) && TREE_HAS_SIDE_EFFECTS_HOOK(EXPR_W(node,EXPR_RIGHT))) return 1;
            else node=EXPR_W(node,EXPR_LEFT);
            break;
        }
    }
    return 0;
}

/* ---- STOVR82 (listing ovr_1d13_99b3:AA2E) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int,long);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);
/* SEG_PTR_FROM_FAR_ADJUST: when a far or huge pointer object is read as a _seg pointer
   (kind 14), the segment is the high word: for a symbol leaf the offset in EXPR_RIGHT
   is moved up by 2, for *p the pointer becomes p + 2. */
void far pascal SEG_PTR_FROM_FAR_ADJUST(register unsigned int node,unsigned int oldkind,unsigned int kind)
{
    register unsigned int temporary;
    if(kind==14 && (oldkind==15 || oldkind==16)) {
        switch(EXPR_I(node,EXPR_OP)) {
        case 1: case 5: case 6: EXPR_I(node,EXPR_RIGHT)+=2;break;
        case EOP_DEREF:
            temporary=NEW_CONST_NODE_HOOK(MODE_HOOK(5),2L);
            temporary=NEW_EXPR_NODE_HOOK(8,EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_TYPE),EXPR_I(node,EXPR_LEFT),temporary);
            EXPR_I(node,EXPR_LEFT)=FOLD_EXPRESSION(temporary);
            break;
        }
    }
}

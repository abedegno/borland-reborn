/* target: ovr130_C123UNIT */
/* opts: -mm -G -O -Z -p -Y -y -k- */
/* Role: constant folding. Entry points: FOLD_STATEMENT_EXPR, FOLD_EXPRESSION,
   FOLD_CONSTANT_NODE, LOG2_POWER_OF_TWO, NARROW_FAR_POINTER. Map of all sources:
   docs/SOURCE-MAP.md. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* CO049: expression-tree simplification and constant folding.  The whole
   overlay as one source; the section headers name the original listing
   modules. */
/* Overview: tree simplification and constant folding for the C-mode front end (20-byte
   nodes, TYPE_C_* types, nodes made through NEW_EXPR_NODE_HOOK). FOLD_EXPRESSION walks a
   tree bottom up and rewrites it into cheaper equal forms before code generation:
   multiplication, unsigned division and unsigned remainder by a power of two become
   shifts and masks; *&x and &*p cancel; adding a constant to the address of a variable
   is folded into the variable leaf's offset (EXPR_RIGHT of leaf operators 1 and 5);
   chains of + * & | ^ are reassociated so their constants meet and fold; x+0, x|0, x^0,
   x*1 disappear; a ?: with a constant condition picks its arm; !(a < b) becomes a >= b;
   relational compares of far pointers compare only the offsets. FOLD_CONSTANT_NODE then
   computes nodes whose operands are all constants (integers as long, floating values
   through the long double helpers), reporting overflow of signed constants and division
   by zero. FOLD_STATEMENT_EXPR is the entry for a whole expression statement: it first
   moves x += c and x++ on simple variables out of the expression (HOIST_SIDE_EFFECTS).
   NARROW_FAR_POINTER turns a far pointer expression into a near one when its segment
   is known (addresses of statics, locals, or casts from near pointers).
   Operators below 8 are leaves (1, 4, 5, 6 symbol leaves, 2 EOP_CONST, 3 long double
   constant). Unnamed operators used here: 41 (0x29) a sequence node that yields its
   left operand, 42 (0x2A) EOP_COMMA, 0x2C pointer difference, 0x2D segment:offset
   combination, 51 bitfield, 53 cast, 54 call. EXPR_FLAGS bit 0x20 marks unsigned kinds.
   The stack check in FOLD_EXPRESSION stops very deep trees with MSG_OUT_MEMORY. */

/* ---- STOVR3 (listing 5B10) ---- */
extern unsigned int  EXPR_POOL_SEG;
static void near pascal HOIST_SIDE_EFFECTS(unsigned int far *,unsigned int far *,unsigned int,unsigned int);
/* FOLD_EXPRESSION_BODY, LOG2_POWER_OF_TWO_BODY and NARROW_FAR_POINTER_BODY are the in-overlay body
   labels of FOLD_EXPRESSION, LOG2_POWER_OF_TWO and NARROW_FAR_POINTER: a call written with
   the body label went straight to the body in the original, a call written
   with the stub name went through the overlay stub. */
extern unsigned int far pascal FOLD_EXPRESSION_BODY(unsigned int);
/* FOLD_STATEMENT_EXPR: simplifies the expression of an expression statement (its value
   is not used): moves side effects out (HOIST_SIDE_EFFECTS) and folds the tree. */
unsigned int far pascal FOLD_STATEMENT_EXPR(unsigned int node)
{
    if(node==0 || *(unsigned int far *)MK_FP(EXPR_POOL_SEG,node+EXPR_KIND)==0) return node;
    HOIST_SIDE_EFFECTS(&node,&node,node,3);
    return FOLD_EXPRESSION_BODY(node);
}

/* ---- STOVR4 (listing 5B49) ---- */
struct Node20 { unsigned char bytes[20]; };
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
#define N(n) (*(struct Node20 far *)MK_FP(EXPR_POOL_SEG,(n)))
/* HOIST_SIDE_EFFECTS: in the statement tree *root, finds x += c / x -= c and x++ / x--
   applied to a simple variable (leaf operator <= 7) somewhere below the root, replaces
   them by a plain copy of x (*output), and puts the update itself next to the root:
   x += c before it ((x += c), root), and x++ after it (sequence node 41 with the update
   as its right side, through POST_TO_ASSIGN_OP). flags bit 1 allows moving updates
   before, bit 2 after. The search does not enter ?:, && , || or calls, whose operands
   may not all be evaluated; for a comma only the right side keeps "after" and the left
   side is handled as a statement of its own. */
static void near pascal HOIST_SIDE_EFFECTS(unsigned int far *root,unsigned int far *output,register unsigned int node,register unsigned int flags)
{
    unsigned int child=EXPR_I(node,EXPR_LEFT),temporary;
    switch(EXPR_I(node,EXPR_OP)) {
    case EOP_ADD_ASSIGN:case EOP_SUB_ASSIGN:
        if(*root==node || !(flags&1) || EXPR_I(child,EXPR_OP)>7) goto descend;
        temporary=NEW_EXPR_NODE_HOOK(EXPR_I(node,EXPR_OP),EXPR_I(node,EXPR_TYPE),child,EXPR_I(node,EXPR_RIGHT));
        *output=POOL_ALLOC(&EXPR_POOL_SEG,sizeof(struct Node20));
        N(*output)=N(child);
        *root=NEW_EXPR_NODE_HOOK(42,EXPR_I(*root,EXPR_TYPE),temporary,*root);
        break;
    case EOP_POSTINC:case EOP_POSTDEC:
        if(*root==node || !(flags&2) || EXPR_I(child,EXPR_OP)>7) goto descend;
        temporary=NEW_EXPR_NODE_HOOK(POST_TO_ASSIGN_OP[EXPR_I(node,EXPR_OP)],EXPR_I(node,EXPR_TYPE),child,EXPR_I(node,EXPR_RIGHT));
        *output=POOL_ALLOC(&EXPR_POOL_SEG,sizeof(struct Node20));
        N(*output)=N(child);
        *root=NEW_EXPR_NODE_HOOK(41,EXPR_I(*root,EXPR_TYPE),*root,temporary);
        break;
    case 51:
        child=EXPR_I(node,EXPR_LEFT);
        HOIST_SIDE_EFFECTS(root,&child,EXPR_I(node,EXPR_LEFT),flags);
        EXPR_I(node,EXPR_LEFT)=child;
        break;
    case EOP_COMMA:
        if(flags&2) {
            child=EXPR_I(node,EXPR_RIGHT);
            HOIST_SIDE_EFFECTS(root,&child,EXPR_I(node,EXPR_RIGHT),2);
            EXPR_I(node,EXPR_RIGHT)=child;
        }
        child=EXPR_I(node,EXPR_LEFT);
        HOIST_SIDE_EFFECTS(&child,&child,EXPR_I(node,EXPR_LEFT),3);
        EXPR_I(node,EXPR_LEFT)=child;
        break;
    default:
    descend:
        if(EXPR_I(node,EXPR_RIGHT)) {
            child=EXPR_I(node,EXPR_RIGHT);
            HOIST_SIDE_EFFECTS(root,&child,EXPR_I(node,EXPR_RIGHT),flags);
            EXPR_I(node,EXPR_RIGHT)=child;
        }
        if(EXPR_I(node,EXPR_LEFT)) {
            child=EXPR_I(node,EXPR_LEFT);
            HOIST_SIDE_EFFECTS(root,&child,EXPR_I(node,EXPR_LEFT),flags);
            EXPR_I(node,EXPR_LEFT)=child;
        }
        break;
    case 1:case EOP_CONST:case 3:case 4:case 5:case 6:case 7:
    case EOP_QUESTION:case EOP_ANDAND:case EOP_OROR:case 54:break;
    }
}
#undef N

/* ---- STOVR5 (listing 5DF2) ---- */
unsigned int far pascal FOLD_CONSTANT_NODE(register unsigned int node);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
static unsigned int near pascal REASSOCIATE_OPERANDS(unsigned int,unsigned int,unsigned int);
static void near pascal FOLD_ADDRESS_OFFSET(unsigned int,unsigned int);
extern int far pascal LOG2_POWER_OF_TWO_BODY(unsigned long);
extern unsigned int far pascal NARROW_FAR_POINTER_BODY(unsigned int);
extern int far pascal IS_ADDRESSABLE_NODE(unsigned int);
extern unsigned int far pascal CONVERT_EXPRESSION_TYPE(unsigned int,unsigned int);
extern unsigned int far pascal NARROW_INTEGER_EXPR(unsigned int);
extern unsigned int far pascal INVERT_COMPARE_OP(unsigned int);
/* FOLD_EXPRESSION: simplifies the tree input (see the overview) and returns the new
   tree. Enum-typed nodes are first given their int or char type; casts (operator 53)
   and leaves are returned unchanged; bitfield nodes only fold their object. */
unsigned int far pascal FOLD_EXPRESSION(unsigned int input)
{
    int bit;
    unsigned int right,temp,type,newtype;
    register unsigned int node=input;
    register unsigned int left;
    /* Documented exception (pseudo-register read): stack-depth check,
       cmp sp,8F0Ch at 02ED. */
    if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    if(node==0 || EXPR_W(node,EXPR_KIND)==TK_UNDEFINED || EXPR_W(node,EXPR_OP)==53) return node;
    if(EXPR_W(node,EXPR_KIND)==TK_ENUM) {
        type=EXPR_W(node,EXPR_TYPE);
        if(TYPE_W(type,TYPE_C_SIZE)==1) EXPR_W(node,EXPR_TYPE)=MODE_HOOK(1);
        else EXPR_W(node,EXPR_TYPE)=PLAIN_INT_TYPE;
        EXPR_W(node,EXPR_KIND)=TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_KIND);
    }
    if((int)EXPR_W(node,EXPR_OP)<=7) return node;
    left=EXPR_W(node,EXPR_LEFT)=FOLD_EXPRESSION(EXPR_W(node,EXPR_LEFT));
    if(EXPR_W(node,EXPR_OP)==51) return node;
    right=EXPR_W(node,EXPR_RIGHT)=FOLD_EXPRESSION(EXPR_W(node,EXPR_RIGHT));
    switch(EXPR_W(node,EXPR_OP)) {
    case EOP_MUL:
        if(EXPR_W(left,EXPR_OP)==EXPR_W(node,EXPR_OP)) node=REASSOCIATE_OPERANDS(node,left,right);
        else if(EXPR_W(right,EXPR_OP)==EXPR_W(node,EXPR_OP)) node=REASSOCIATE_OPERANDS(node,right,left);
        else if(EXPR_W(left,EXPR_OP)==EOP_CONST) {EXPR_W(node,EXPR_LEFT)=right;EXPR_W(node,EXPR_RIGHT)=left;}
        right=EXPR_W(node,EXPR_RIGHT);left=EXPR_W(node,EXPR_LEFT);
        /* x * 2^n becomes x << n; x * 1 becomes x; x * 0 becomes (x, 0) to keep x's side effects */
        if(EXPR_W(right,EXPR_OP)==EOP_CONST) {
        if(EXPR_L(right,EXPR_VALUE)>0L) {
            bit=LOG2_POWER_OF_TWO_BODY((unsigned long)EXPR_L(right,EXPR_VALUE));
            if(bit==0) return left;
            if(bit>0) {EXPR_L(right,EXPR_VALUE)=(long)bit;EXPR_W(right,EXPR_KIND)=TK_UCHAR;EXPR_W(node,EXPR_OP)=EOP_SHL;}
        } else {
            if(EXPR_L(right,EXPR_VALUE)==0L && EXPR_W(left,EXPR_OP)!=EOP_CONST) {
                EXPR_W(node,EXPR_OP)=EOP_COMMA;
                return node;
            }
        }
        }
        break;
    case EOP_DIV:
        if(EXPR_W(right,EXPR_OP)==EOP_CONST && EXPR_L(right,EXPR_VALUE)>0L) {
        bit=LOG2_POWER_OF_TWO_BODY((unsigned long)EXPR_L(right,EXPR_VALUE));
        if(bit==0) return left;
        if(bit>0 && (EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20)) {
            EXPR_L(right,EXPR_VALUE)=(long)bit;EXPR_W(right,EXPR_KIND)=TK_UCHAR;EXPR_W(node,EXPR_OP)=EOP_SHR;
        }
        }
        break;
    case EOP_MOD:
        if(EXPR_W(right,EXPR_OP)==EOP_CONST && EXPR_L(right,EXPR_VALUE)>0L) {
        bit=LOG2_POWER_OF_TWO_BODY((unsigned long)EXPR_L(right,EXPR_VALUE));
        if(bit==0) {EXPR_L(right,EXPR_VALUE)=0L;return right;}
        if(bit>0 && (EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20)) {
            --EXPR_L(right,EXPR_VALUE);EXPR_W(node,EXPR_OP)=EOP_AND;
        }
        }
        break;
    /* *&x is x; a far pointer that can be near is narrowed first */
    case EOP_DEREF:
        left=NARROW_FAR_POINTER_BODY(left);
        if(EXPR_W(left,EXPR_OP)==EOP_ADDR && IS_ADDRESSABLE_NODE(EXPR_W(left,EXPR_LEFT))) {
            left=EXPR_W(left,EXPR_LEFT);
            EXPR_W(left,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);EXPR_W(left,EXPR_KIND)=EXPR_W(node,EXPR_KIND);
            return left;
        }
        EXPR_W(node,EXPR_LEFT)=left;
        return node;
    case EOP_ADDR:
        if(EXPR_W(left,EXPR_OP)==EOP_DEREF) return CONVERT_EXPRESSION_TYPE(EXPR_W(left,EXPR_LEFT),EXPR_W(node,EXPR_TYPE));
        return node;
    /* address + constant: add the constant to the variable leaf's offset */
    case EOP_ADD:
        type=EXPR_W(node,EXPR_TYPE);
        if(EXPR_W(right,EXPR_OP)==EOP_CONST && EXPR_L(right,EXPR_VALUE)==0L) return CONVERT_EXPRESSION_TYPE(left,type);
        if(EXPR_W(left,EXPR_OP)==EOP_ADDR) {
            if(EXPR_W(right,EXPR_OP)==EOP_CONST) {
                if(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)!=1 && EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)!=5) break;
                temp=EXPR_W(left,EXPR_LEFT);EXPR_W(temp,EXPR_RIGHT)+=EXPR_W(right,EXPR_LEFT);
                return left;
            }
            FOLD_ADDRESS_OFFSET(left,right);
        } else if(EXPR_W(right,EXPR_OP)==EOP_ADDR) FOLD_ADDRESS_OFFSET(right,left);
        if(EXPR_W(left,EXPR_OP)==EOP_CONST || EXPR_W(left,EXPR_OP)==EOP_ADDR) {temp=right;right=left;left=temp;}
        EXPR_W(node,EXPR_RIGHT)=right;EXPR_W(node,EXPR_LEFT)=left;
        if(EXPR_W(left,EXPR_OP)==EXPR_W(node,EXPR_OP)) return REASSOCIATE_OPERANDS(node,left,right);
        if(EXPR_W(right,EXPR_OP)==EXPR_W(node,EXPR_OP)) return REASSOCIATE_OPERANDS(node,right,left);
        if(EXPR_W(right,EXPR_OP)==EOP_CONST && EXPR_L(right,EXPR_VALUE)==0L) {
            if(EXPR_W(left,EXPR_KIND)!=EXPR_W(node,EXPR_KIND)) left=CONVERT_EXPRESSION_TYPE(left,EXPR_W(node,EXPR_TYPE));
            return left;
        }
        break;
    case EOP_AND:
        if(EXPR_W(left,EXPR_OP)==EXPR_W(node,EXPR_OP)) return REASSOCIATE_OPERANDS(node,left,right);
        if(EXPR_W(right,EXPR_OP)==EXPR_W(node,EXPR_OP)) return REASSOCIATE_OPERANDS(node,right,left);
        break;
    case EOP_OR:case EOP_XOR:
        if(EXPR_W(left,EXPR_OP)==EXPR_W(node,EXPR_OP)) return REASSOCIATE_OPERANDS(node,left,right);
        if(EXPR_W(right,EXPR_OP)==EXPR_W(node,EXPR_OP)) return REASSOCIATE_OPERANDS(node,right,left);
        if(EXPR_W(right,EXPR_OP)!=EOP_CONST || EXPR_L(right,EXPR_VALUE)!=0L) break;
        return left;
    case 44:
        if(EXPR_W(right,EXPR_OP)==EOP_CONST && EXPR_L(right,EXPR_VALUE)==0L) {
            EXPR_W(left,EXPR_KIND)=EXPR_W(node,EXPR_KIND);EXPR_W(left,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
            return left;
        }
        break;
    case EOP_SUB:
        if(EXPR_W(right,EXPR_OP)!=EOP_CONST) break;
        if(EXPR_L(right,EXPR_VALUE)==0L) return left;
        if(EXPR_W(left,EXPR_OP)==EOP_ADDR && (EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==1 || EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==5)) {
            node=EXPR_W(left,EXPR_LEFT);EXPR_W(node,EXPR_RIGHT)-=EXPR_W(right,EXPR_LEFT);
            return left;
        }
        if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20) break;
        EXPR_L(right,EXPR_VALUE)=-EXPR_L(right,EXPR_VALUE);EXPR_W(node,EXPR_OP)=EOP_ADD;
        if(EXPR_W(left,EXPR_OP)==EOP_ADD) return REASSOCIATE_OPERANDS(node,left,right);
        break;
    case EOP_QUESTION:
        if(EXPR_W(left,EXPR_OP)==EOP_CONST) {
            if(EXPR_L(left,EXPR_VALUE)!=0L) return EXPR_W(right,EXPR_LEFT);
            else return EXPR_W(right,EXPR_RIGHT);
        }
        return node;
    case EOP_NOT:
        switch(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)) {
        case EOP_EQ:case EOP_NE:case EOP_GT:case EOP_LT:case EOP_GE:case EOP_LE:
            node=EXPR_W(node,EXPR_LEFT);EXPR_W(node,EXPR_OP)=INVERT_COMPARE_OP(EXPR_W(node,EXPR_OP));
            return node;
        }
        break;
    /* far pointers: < > <= >= compare the offsets only, as unsigned int */
    case EOP_GT:case EOP_LT:case EOP_GE:case EOP_LE:
        if(EXPR_W(left,EXPR_KIND)!=TK_FAR_PTR) break;
        newtype=MODE_HOOK(6);
        EXPR_W(node,EXPR_LEFT)=CONVERT_EXPRESSION_TYPE(left,newtype);
        EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPRESSION_TYPE(right,newtype);
        EXPR_W(node,EXPR_TYPE)=newtype;EXPR_W(node,EXPR_KIND)=TK_UINT;
        break;
    /* x == 0 / x != 0 can be tested in the narrowest kind x fits in */
    case EOP_EQ:case EOP_NE:
        if(EXPR_W(right,EXPR_OP)==EOP_CONST && EXPR_L(right,EXPR_VALUE)==0L) {
            EXPR_W(node,EXPR_LEFT)=(left=NARROW_INTEGER_EXPR(left));EXPR_W(right,EXPR_KIND)=EXPR_W(left,EXPR_KIND);
        } else if(EXPR_W(left,EXPR_OP)==EOP_CONST && EXPR_L(left,EXPR_VALUE)==0L) {
            right=NARROW_INTEGER_EXPR(right);EXPR_W(node,EXPR_RIGHT)=right;EXPR_W(left,EXPR_KIND)=EXPR_W(right,EXPR_KIND);
        }
        break;
    }
    return FOLD_CONSTANT_NODE(node);
}

/* FOLD_CONSTANT_NODE is described by the comment below. In short: returns the left
   operand turned into the folded constant, or node unchanged when the operands are not
   all constants or the operator cannot be folded. */
/* ---- FOLD_CONSTANT_NODE (listing 6536) ---- */
/* FOLD_CONSTANT_NODE (stub 0D00:002A, body BCC_FAR_6536 = OVL:0082:0A26):
   constant folding of a unary/binary expression node.  Float operands
   (node kind 3) go through 10-byte temporaries and far helpers; integer
   operands (kind 2) are folded as longs.

   Documented exception (pseudo-register reads): the original tests the
   CPU overflow flag after `lv += rv`, `lv -= rv` and after the signed
   multiply helper (jo at 0C51, 0CBB and 0D10).  BC compiles
   `if (_FLAGS & 0x800)` straight after the operation to that jo; no C
   comparison produces it (precedent: the carry test in C237 POOL_ALLOC).
   For * the unsigned flag is checked first: unsigned operands use a plain
   multiply, signed ones the helper LMUL_WITH_OVERFLOW, which sets OF on
   (approximately detected) overflow.  After a signed overflow the folded value becomes 1.

   Integer results are written back into the left node, which is returned;
   float compares return a new node from NEW_CONST_NODE_HOOK instead. */
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int,long);
extern long (far pascal *TOKEN_CONVERT)(long,int);
extern int far pascal RTL_LDOUBLE_COMPARE(void far *,void far *);
extern void far pascal RTL_LDOUBLE_ADD(void far *,void far *);
extern void far pascal RTL_LDOUBLE_SUB(void far *,void far *);
extern void far pascal RTL_LDOUBLE_MUL(void far *,void far *);
extern void far pascal RTL_LDOUBLE_DIV(void far *,void far *);
extern long far pascal LMUL_WITH_OVERFLOW(long,long);
static void near pascal REPORT_CONSTANT_TOO_LARGE(void);

unsigned int far pascal FOLD_CONSTANT_NODE(register unsigned int node)
{
    unsigned int right;
    long lv;
    int r;
    long rv;
    unsigned int a[5];
    unsigned int b[5];
    unsigned int left;

    left=EXPR_W(node,EXPR_LEFT);
    right=EXPR_W(node,EXPR_RIGHT);
    if(EXPR_W(left,EXPR_OP)==3 && (right==0 || EXPR_W(right,EXPR_OP)==3)) {
        RTL_MEMMOVE(a,MK_FP(EXPR_POOL_SEG,left+EXPR_LEFT),10);
        if(right) RTL_MEMMOVE(b,MK_FP(EXPR_POOL_SEG,right+EXPR_LEFT),10);
        /* signed: the original's case dispatch here uses jg (0A9E, 0AA8) */
        switch((int)EXPR_W(node,EXPR_OP)) {
        case 0x1D: case 0x1E: case 0x1F: case 0x20: case 0x21: case 0x22:
            r=RTL_LDOUBLE_COMPARE(a,b);
            switch(EXPR_W(node,EXPR_OP)) { case EOP_EQ: r=r==0; break; case EOP_NE: r=r!=0; break; case EOP_GT: r=r>0; break; case EOP_LT: r=r<0; break; case EOP_GE: r=r>=0; break; case EOP_LE: r=r<=0; break; }
            left=NEW_CONST_NODE_HOOK(MODE_HOOK(5),(long)r);
            /* through the common exit (one epilogue load of left), as in
               the original; a direct return compiles differently */
            goto done;
        case 8:
            RTL_LDOUBLE_ADD(a,b);
            break;
        case 9:
            RTL_LDOUBLE_SUB(a,b);
            break;
        case 10:
            RTL_LDOUBLE_MUL(a,b);
            break;
        case 11:
            RTL_LDOUBLE_DIV(a,b);
            break;
        case 0x2E:
            a[4]^=0x8000;
            break;
        default:
            return node;
        }
        RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,left+EXPR_LEFT),a,10);
    } else {
        if(EXPR_W(left,EXPR_OP)!=EOP_CONST || right && EXPR_W(right,EXPR_OP)!=EOP_CONST) return node;
        lv=EXPR_L(left,EXPR_VALUE);
        if(right) rv=EXPR_L(right,EXPR_VALUE);
        switch(EXPR_W(node,EXPR_OP)) {
        case EOP_ADD:
            lv+=rv;
            if(_FLAGS&0x800) {
                if(!(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20)) {
                    REPORT_CONSTANT_TOO_LARGE();
                    lv=1;
                }
            }
            break;
        case 0x2D:    /* combine a segment and an offset into one 32-bit value */
            if(EXPR_W(left,EXPR_KIND)==TK_SEG_PTR) lv=((long)(unsigned int)lv<<16)+rv;
            else lv=((long)(unsigned int)rv<<16)+lv;
            break;
        case EOP_SUB:
            lv-=rv;
            if(_FLAGS&0x800) {
                if(!(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20)) {
                    REPORT_CONSTANT_TOO_LARGE();
                    lv=1;
                }
            }
            break;
        case EOP_MUL:
            if(!(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20)) {
                lv=LMUL_WITH_OVERFLOW(lv,rv);
                if(_FLAGS&0x800) {
                    REPORT_CONSTANT_TOO_LARGE();
                    lv=1;
                }
            } else lv*=rv;
            break;
        case EOP_DIV:
            if(rv==0) REPORT_WARNING(MSG_DIVISION_ZERO_381);
            else if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20) lv=(unsigned long)lv/rv;
            else lv/=rv;
            break;
        case EOP_MOD:
            if(rv==0) REPORT_WARNING(MSG_DIVISION_ZERO_381);
            else if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20) lv=(unsigned long)lv%rv;
            else lv%=rv;
            break;
        case EOP_SHL:
            lv<<=rv;
            break;
        case EOP_SHR:
            if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x20) lv=(unsigned long)lv>>rv;
            else lv>>=rv;
            break;
        case EOP_AND:
            lv&=rv;
            break;
        case EOP_OR:
            lv|=rv;
            break;
        case EOP_XOR:
            lv^=rv;
            break;
        case EOP_NOT:
            lv=!(int)lv;
            break;
        case EOP_NEG:
            lv=-lv;
            break;
        case EOP_COMPL:
            lv=~lv;
            break;
        case EOP_EQ:
            lv=lv==rv;
            break;
        case EOP_NE:
            lv=lv!=rv;
            break;
        case EOP_LT:
            if(EXPR_FLAGS[EXPR_W(left,EXPR_KIND)]&0x20) lv=(unsigned long)lv<rv;
            else lv=lv<rv;
            break;
        case EOP_GT:
            if(EXPR_FLAGS[EXPR_W(left,EXPR_KIND)]&0x20) lv=(unsigned long)lv>rv;
            else lv=lv>rv;
            break;
        case EOP_LE:
            if(EXPR_FLAGS[EXPR_W(left,EXPR_KIND)]&0x20) lv=(unsigned long)lv<=rv;
            else lv=lv<=rv;
            break;
        case EOP_GE:
            if(EXPR_FLAGS[EXPR_W(left,EXPR_KIND)]&0x20) lv=(unsigned long)lv>=rv;
            else lv=lv>=rv;
            break;
        case EOP_ANDAND:
            lv=(int)lv && (int)rv;
            break;
        case EOP_OROR:
            lv=(int)lv || (int)rv;
            break;
        case 0x2C:    /* pointer difference: near = int difference, huge below,
                         otherwise far = offset-only difference */
            if(EXPR_W(node,EXPR_KIND)==TK_NEAR_PTR) lv=(int)lv-(int)rv;
            else if(EXPR_W(node,EXPR_KIND)==TK_HUGE_PTR) {
                /* huge pointers: (seg<<12)+off, computed in 16-bit unsigned
                   arithmetic (the original truncates), then subtracted */
                lv=(FP_SEG((void far *)lv)<<12)+FP_OFF((void far *)lv);
                rv=(FP_SEG((void far *)rv)<<12)+FP_OFF((void far *)rv);
                lv-=rv;
            } else lv=(lv&0xFFFF)-(rv&0xFFFF);
            break;
        default:
            return node;
        }
        EXPR_W(left,EXPR_KIND)=EXPR_W(node,EXPR_KIND);
        EXPR_W(left,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
        EXPR_L(left,EXPR_VALUE)=TOKEN_CONVERT(lv,EXPR_W(left,EXPR_KIND));
    }
done:
    return left;
}

/* ---- STOVR7 (listing 6CB7) ---- */
/* REPORT_CONSTANT_TOO_LARGE: reports MSG_NUMERIC_CONSTANT_TOO (overflow while folding). */
static void near pascal REPORT_CONSTANT_TOO_LARGE(void)
{
    REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
}

/* ---- STOVR8 (listing 6CC3) ---- */
#define FLAGS8(n) EXPR_FLAGS[EXPR_W(n,EXPR_KIND)]
/* REASSOCIATE_OPERANDS: node and its operand left (passed as left) have the same
   associative operator; regroups (a op b) op c so that constants (and addresses, whose
   constant offsets fold into the leaf) end up together and fold, e.g. (x + 1) + 2 into
   x + 3 or (&v + i) + 4 into &v' + i with the offset moved into v. The result type is
   carried along so pointer arithmetic keeps its pointer type. Returns the new top. */
static unsigned int near pascal REASSOCIATE_OPERANDS(register unsigned int node,register unsigned int left,unsigned int right)
{
    unsigned int a,b,c,kind;
    kind=EXPR_W(node,EXPR_OP);
    EXPR_W(node,EXPR_LEFT)=left;EXPR_W(node,EXPR_RIGHT)=right;
    a=EXPR_W(left,EXPR_RIGHT);
    if(EXPR_W(a,EXPR_OP)!=EOP_CONST && EXPR_W(a,EXPR_OP)!=EOP_ADDR) {
        /* shares the return below, as in the original (a direct return
           compiles differently) */
        if(EXPR_W(right,EXPR_OP)!=kind) goto unchanged;
        if(FLAGS8(node)&0x15) {
            b=EXPR_W(right,EXPR_LEFT);c=EXPR_W(right,EXPR_RIGHT);
            if((FLAGS8(left)&0x14) || (FLAGS8(c)&0x14)) {
                EXPR_W(right,EXPR_KIND)=EXPR_W(left,EXPR_KIND);EXPR_W(right,EXPR_TYPE)=EXPR_W(left,EXPR_TYPE);
            }
            EXPR_W(node,EXPR_RIGHT)=c;EXPR_W(node,EXPR_LEFT)=right;
            EXPR_W(right,EXPR_RIGHT)=b;EXPR_W(right,EXPR_LEFT)=left;
            return node;
        }
 unchanged:
        return node;
    } else {
        if(EXPR_W(right,EXPR_OP)==EOP_CONST) {
            EXPR_W(left,EXPR_KIND)=EXPR_W(node,EXPR_KIND);EXPR_W(left,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
            if(!(FLAGS8(right)&0x14)) {
                EXPR_W(node,EXPR_KIND)=EXPR_W(a,EXPR_KIND);EXPR_W(node,EXPR_TYPE)=EXPR_W(a,EXPR_TYPE);
            }
            EXPR_W(node,EXPR_LEFT)=a;
            node=FOLD_EXPRESSION(node);
            EXPR_W(left,EXPR_RIGHT)=node;
            FOLD_ADDRESS_OFFSET(EXPR_W(left,EXPR_RIGHT),EXPR_W(left,EXPR_LEFT));
            return left;
        } else if(EXPR_W(right,EXPR_OP)==EOP_ADDR) {
            if(EXPR_W(a,EXPR_OP)==EOP_CONST) {
                EXPR_W(node,EXPR_RIGHT)=a;EXPR_W(node,EXPR_LEFT)=right;
                EXPR_W(left,EXPR_RIGHT)=FOLD_EXPRESSION(node);
                EXPR_W(left,EXPR_KIND)=EXPR_W(node,EXPR_KIND);EXPR_W(left,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
                FOLD_ADDRESS_OFFSET(EXPR_W(left,EXPR_RIGHT),EXPR_W(left,EXPR_LEFT));
                return left;
            } else {
                FOLD_ADDRESS_OFFSET(EXPR_W(node,EXPR_RIGHT),EXPR_W(node,EXPR_LEFT));
                return node;
            }
        } else if(EXPR_W(right,EXPR_OP)!=kind) {
            if((FLAGS8(a)&0x14) || (FLAGS8(right)&0x14)) {
                EXPR_W(left,EXPR_KIND)=EXPR_W(right,EXPR_KIND);EXPR_W(left,EXPR_TYPE)=EXPR_W(right,EXPR_TYPE);
            }
            EXPR_W(left,EXPR_RIGHT)=right;EXPR_W(node,EXPR_RIGHT)=a;
            FOLD_ADDRESS_OFFSET(EXPR_W(node,EXPR_RIGHT),EXPR_W(node,EXPR_LEFT));
                return node;
        } else {
            b=EXPR_W(right,EXPR_LEFT);c=EXPR_W(right,EXPR_RIGHT);
            if(EXPR_W(c,EXPR_OP)!=EOP_CONST && EXPR_W(c,EXPR_OP)!=EOP_ADDR) {
                if(FLAGS8(a)&0x14) {
                    EXPR_W(left,EXPR_KIND)=EXPR_W(b,EXPR_KIND);EXPR_W(left,EXPR_TYPE)=EXPR_W(b,EXPR_TYPE);
                } else if(FLAGS8(left)&0x14) {
                    EXPR_W(right,EXPR_KIND)=EXPR_W(left,EXPR_KIND);EXPR_W(right,EXPR_TYPE)=EXPR_W(left,EXPR_TYPE);
                }
                EXPR_W(right,EXPR_LEFT)=left;EXPR_W(left,EXPR_RIGHT)=b;EXPR_W(right,EXPR_RIGHT)=c;
                EXPR_W(node,EXPR_LEFT)=right;EXPR_W(node,EXPR_RIGHT)=a;
                FOLD_ADDRESS_OFFSET(EXPR_W(node,EXPR_RIGHT),EXPR_W(node,EXPR_LEFT));
                return node;
            } else if(EXPR_W(c,EXPR_OP)==EOP_CONST) {
                if(!(FLAGS8(left)&0x14) || (FLAGS8(a)&0x14)) {
                    EXPR_W(left,EXPR_KIND)=EXPR_W(b,EXPR_KIND);EXPR_W(left,EXPR_TYPE)=EXPR_W(b,EXPR_TYPE);
                }
                EXPR_W(right,EXPR_LEFT)=a;
                EXPR_W(node,EXPR_RIGHT)=FOLD_EXPRESSION(right);
                EXPR_W(left,EXPR_RIGHT)=b;
                FOLD_ADDRESS_OFFSET(EXPR_W(node,EXPR_RIGHT),EXPR_W(node,EXPR_LEFT));
                return node;
            } else if(EXPR_W(a,EXPR_OP)==EOP_CONST) {
                EXPR_W(right,EXPR_LEFT)=c;EXPR_W(right,EXPR_RIGHT)=a;
                EXPR_W(node,EXPR_RIGHT)=FOLD_EXPRESSION(right);
                EXPR_W(left,EXPR_RIGHT)=b;
                FOLD_ADDRESS_OFFSET(EXPR_W(node,EXPR_RIGHT),EXPR_W(node,EXPR_LEFT));
                return node;
            }
        }
    }
    return node;
}
#undef FLAGS8

/* ---- STOVR9 (listing 7011) ---- */
/* FOLD_ADDRESS_OFFSET: target is &variable (leaf operator 1 or 5) and expr an index
   expression added to it. Constant parts of expr of the form (i + c) * k or
   (i + c) << n are moved into the variable's offset (c * k), leaving i * k. Recurses
   through +. */
static void near pascal FOLD_ADDRESS_OFFSET(register unsigned int target,register unsigned int expr)
{
    long multiplier;
    unsigned int product;
    if(EXPR_W(target,EXPR_OP)!=EOP_ADDR) return;
    if(EXPR_W(EXPR_W(target,EXPR_LEFT),EXPR_OP)!=1 && EXPR_W(EXPR_W(target,EXPR_LEFT),EXPR_OP)!=5) return;
    switch(EXPR_W(expr,EXPR_OP)) {
    case EOP_ADD:
        FOLD_ADDRESS_OFFSET(target,EXPR_W(expr,EXPR_LEFT));
        FOLD_ADDRESS_OFFSET(target,EXPR_W(expr,EXPR_RIGHT));
        break;
    case EOP_MUL:
        if(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)!=EOP_CONST) break;
        multiplier=EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE);
        product=EXPR_W(expr,EXPR_LEFT);
        if(EXPR_W(product,EXPR_OP)!=EOP_ADD) break;
        if(EXPR_W(EXPR_W(product,EXPR_RIGHT),EXPR_OP)!=EOP_CONST) break;
        EXPR_W(EXPR_W(target,EXPR_LEFT),EXPR_RIGHT)=EXPR_W(EXPR_W(target,EXPR_LEFT),EXPR_RIGHT)+(unsigned int)(multiplier*EXPR_L(EXPR_W(product,EXPR_RIGHT),EXPR_VALUE));
        EXPR_W(expr,EXPR_LEFT)=EXPR_W(product,EXPR_LEFT);
        break;
    case EOP_SHL:
        if(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)!=EOP_CONST) break;
        multiplier=(long)(1<<EXPR_B(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE));
        product=EXPR_W(expr,EXPR_LEFT);
        if(EXPR_W(product,EXPR_OP)!=EOP_ADD) break;
        if(EXPR_W(EXPR_W(product,EXPR_RIGHT),EXPR_OP)!=EOP_CONST) break;
        EXPR_W(EXPR_W(target,EXPR_LEFT),EXPR_RIGHT)=EXPR_W(EXPR_W(target,EXPR_LEFT),EXPR_RIGHT)+(unsigned int)(multiplier*EXPR_L(EXPR_W(product,EXPR_RIGHT),EXPR_VALUE));
        EXPR_W(expr,EXPR_LEFT)=EXPR_W(product,EXPR_LEFT);
        break;
    }
}

/* ---- STOVR10 (listing 715B) ---- */
/* LOG2_POWER_OF_TWO: n when value is 2 to the n, else -1 (also for 0). */
int far pascal LOG2_POWER_OF_TWO(unsigned long value)
{
    register int bit;
    if(value==0L) return -1;
    bit=0;
    while((value&1UL)==0L) {
        value>>=1;
        ++bit;
    }
    value>>=1;
    if(value!=0L) return -1;
    return bit;
}

/* ---- STOVR11 (listing 71B0) ---- */
static int near pascal FAR_POINTER_NARROW_MASK(unsigned int);
static void near pascal RETYPE_POINTER_TREE(unsigned int,unsigned int);
extern unsigned int far pascal NEW_POINTER_TYPE(unsigned int,unsigned char,int,unsigned int,int);
/* NARROW_FAR_POINTER: if all values the far pointer expression node can have lie in one
   known segment (FAR_POINTER_NARROW_MASK gives its near-pointer mode), retypes the tree
   to a near pointer of that mode and folds it again. Not done when DATA and BSS are in
   different groups (DATA_BSS_GROUPS_DIFFER). */
unsigned int far pascal NARROW_FAR_POINTER(register unsigned int node)
{
    int mask;
    if(DATA_BSS_GROUPS_DIFFER) return node;
    if((mask=FAR_POINTER_NARROW_MASK(node))!=0) {
        RETYPE_POINTER_TREE(node,NEW_POINTER_TYPE(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_C_TARGET),13,0,0,mask));
        node=FOLD_EXPRESSION(node);
    }
    return node;
}

/* ---- STOVR12 (listing 7201) ---- */

/* RETYPE_POINTER_TREE: gives every far-pointer node of the tree the near pointer type
   "type"; a cast from a near pointer is removed by copying its operand over it. */
static void near pascal RETYPE_POINTER_TREE(register unsigned int node,register unsigned int type)
{
    if(node==0) return;
    if(EXPR_I(node,EXPR_KIND)!=TK_FAR_PTR) return;
    EXPR_I(node,EXPR_TYPE)=type;
    EXPR_I(node,EXPR_KIND)=*(unsigned char far *)MK_FP(TYPE_POOL,type);
    switch(EXPR_I(node,EXPR_OP)) {
    case 53:
        if(EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_KIND)==TK_NEAR_PTR) {
            *(struct Node20 far *)MK_FP(EXPR_POOL_SEG,node)=
                *(struct Node20 far *)MK_FP(EXPR_POOL_SEG,EXPR_I(node,EXPR_LEFT));
            EXPR_I(node,EXPR_TYPE)=type;
        }
        break;
    case 43:case 44:case 45:case EOP_NEG:case EOP_COMPL:case EOP_NOT:case 52:
    default:
        RETYPE_POINTER_TREE(EXPR_I(node,EXPR_LEFT),type);
        RETYPE_POINTER_TREE(EXPR_I(node,EXPR_RIGHT),type);
        break;
    case EOP_COMMA:
        RETYPE_POINTER_TREE(EXPR_I(node,EXPR_RIGHT),type);
        break;
    case 1:case EOP_CONST:case 3:case 4:case 5:case 6:case 7:
    case EOP_DEREF:case EOP_ADDR:case 51:
        break;
    }
}

/* ---- STOVR14 (listing 72D4) ---- */
extern int far pascal STBIN9(unsigned int);
/* FAR_POINTER_NARROW_MASK: the near-pointer mode (TYPE_C_FUNC_FLAGS byte, e.g. 2 code,
   3 stack, 4 data) that every value of the far pointer expression node shares, or 0 when
   unknown: the address of a variable whose leaf has EXPR_QUAL_FLAGS bit 4 (STBIN9 then
   gives 0; probably a variable in the default data group) is 2 for a function and 4
   otherwise; the address of a local is 4 when
   SS equals DS, else 3; a cast from a near pointer has that pointer's mode; arithmetic
   takes the mode of its pointer operand; both arms of ?: must agree. */
static int near pascal FAR_POINTER_NARROW_MASK(register unsigned int node)
{
    register int left;
    if(node==0 || EXPR_I(node,EXPR_KIND)!=TK_FAR_PTR) return 0;
    switch(EXPR_I(node,EXPR_OP)) {
    case 1:
    case EOP_CONST:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case EOP_ASSIGN:
    case EOP_ADD_ASSIGN:
    case EOP_SUB_ASSIGN:
    case 41:
    case EOP_DEREF:
    case 51:
    case 54:
        return 0;
    case 53:
        if(EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_KIND)==TK_NEAR_PTR)
            return *(signed char far *)MK_FP(TYPE_POOL,EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_TYPE)+8);
        return 0;
    case EOP_ADDR:
        if(EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_OP)==1) {
            if(!STBIN9(EXPR_I(node,EXPR_LEFT))) {
                if(EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_KIND)==TK_FUNCTION) return 2;
                return 4;
            }
            return 0;
        } else {
            if(EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_OP)==54 || EXPR_I(EXPR_I(node,EXPR_LEFT),EXPR_OP)==EOP_DEREF) return 0;
            if(OPTION_SS_EQUALS_DS) return 4;
            else return 3;
        }
    case EOP_COMMA:return FAR_POINTER_NARROW_MASK(EXPR_I(node,EXPR_RIGHT));
    case EOP_COLON:
        left=FAR_POINTER_NARROW_MASK(EXPR_I(node,EXPR_LEFT));
        if(left==0) return 0;
        if(FAR_POINTER_NARROW_MASK(EXPR_I(node,EXPR_RIGHT))!=left) return 0;
        return left;
    case EOP_ADD:
    case EOP_SUB:
    case EOP_MUL:
    case EOP_DIV:
    case EOP_MOD:
    case EOP_SHL:
    case EOP_SHR:
    case EOP_AND:
    case EOP_OR:
    case EOP_XOR:
    case EOP_MUL_ASSIGN:
    case EOP_DIV_ASSIGN:
    case EOP_MOD_ASSIGN:
    case EOP_SHL_ASSIGN:
    case EOP_SHR_ASSIGN:
    case EOP_AND_ASSIGN:
    case EOP_OR_ASSIGN:
    case EOP_XOR_ASSIGN:
    case EOP_EQ:
    case EOP_NE:
    case EOP_GT:
    case EOP_LT:
    case EOP_GE:
    case EOP_LE:
    case EOP_POSTINC:
    case EOP_POSTDEC:
    case EOP_QUESTION:
    case EOP_ANDAND:
    case EOP_OROR:
    case 43:
    case 44:
    case 45:
    case EOP_NEG:
    case EOP_COMPL:
    case EOP_NOT:
    case 52:
    default:
        left=FAR_POINTER_NARROW_MASK(EXPR_I(node,EXPR_LEFT));
        if(left) return left;
        break;
    }
    return FAR_POINTER_NARROW_MASK(EXPR_I(node,EXPR_RIGHT));
}

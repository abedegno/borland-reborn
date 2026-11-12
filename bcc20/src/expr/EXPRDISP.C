/* target: ovr059_C78UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: expression builder dispatch. Entry points: RESOLVE_SYMBOL_REFERENCE,
   ANALYZE_EXPRESSION, ANALYZE_AND_DECAY. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the centre of semantic analysis in the C++-mode front end (the one built
   on the 0x1A-byte nodes of expr/EXPRPOOL.C; it also keeps C branches, taken when
   CPP_MODE, the C++ flag, is 0). The parser builds a raw tree; ANALYZE_EXPRESSION
   is then called on it (from about 20 files) and dispatches on the node's operator to
   the checker for that operator, which analyses the operands (calling back into ANALYZE_EXPRESSION),
   applies the conversions, sets the node's type and reports errors. The checkers live in
   expr/UNARYOP.C (unary operators), expr/EXPRCHK.C (binary operators, assignment,
   members), expr/CALLCHK.C (calls), expr/COMMAEXP.C (commas), expr/CONVERT.C and the
   cpp/ files (new, delete, casts, temporaries). This file itself handles symbol
   references, the conditional operator, casts, sizeof and constants.
   Every analysed node gets EXPR_NODE_FLAGS bit 1, and an already analysed node (other
   than a constant) is returned at once, so a tree may safely be analysed twice.
   Parameters used throughout: "type" is the type the value is wanted in, if known
   (0 = no preference, VOID_TYPE = value discarded), used to keep arithmetic narrow and
   to pick overloads; "context" is passed on unchanged (for calls it is a destination
   for a returned structure, for others probably similar).
   The stack check at the top of ANALYZE_EXPRESSION stops very deep recursion with
   MSG_OUT_MEMORY instead of running out of stack. */
/* Complete CO003 expression dispatch and type reconciliation. */
#include <dos.h>
#include "EXPRDISP.H"
#include "MSG.H"
#include "POOL.H"


/* RESOLVE_SYMBOL_REFERENCE: analyses a symbol leaf (operator 1): its type becomes the
   symbol's type. In C++ RESOLVE_SYMBOL_NODE does the work (overloads, members, wanted
   type "type"); in C a symbol of storage class 0x0F (probably an enumerator) is
   replaced by an int constant of its value. A leaf without symbol is returned as is. */
/* 0000: resolve a symbol reference, then mark its resulting expression. */
unsigned int far pascal RESOLVE_SYMBOL_REFERENCE(unsigned int expression,unsigned int type)
{
    unsigned int symbol;
    if((EXPR_B(expression,EXPR_NODE_FLAGS)&1) || EXPR_W(expression,EXPR_LEFT)==0) return expression;
    symbol=EXPR_W(expression,EXPR_LEFT);
    EXPR_W(expression,EXPR_TYPE)=SYM_W(symbol,SYM_TYPE);
    if(CPP_MODE) return RESOLVE_SYMBOL_NODE(expression,type);
    if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==0x0F) {
        FREE_EXPR_NODE(expression);
        expression=MAKE_INT_CONSTANT(SYM_W(symbol,SYM_TYPE),(long)(int)SYM_W(symbol,SYM_CONST_VALUE));
    }
    EXPR_B(expression,EXPR_NODE_FLAGS)|=1;
    return expression;
}

/* C78_special_symbol: 1 for a symbol leaf of storage class 6 with SYM_FLAGS bit 0x20
   (probably a parameter with some special property); such arms of ?: are always read
   as rvalues. */
/* 0088: a full-WORD Boolean; its callers consume the low-BYTE view. */
static int near pascal C78_special_symbol(unsigned int expression)
{
    if(EXPR_W(expression,EXPR_OP)==1 && (SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==6 &&
       (SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_FLAGS)&0x20)) return 1;
    return 0;
}

/* C78_reconcile_pair: analyses a conditional parent = cond ? (first : second) (parent
   op EOP_QUESTION or 0x45, right operand an EOP_COLON node "tree"). The condition must
   be scalar; the arms are analysed with the wanted type (CONDITIONAL_ARM_DEPTH counts
   the nesting). Both arms stay lvalues only when both are references; void arms give a
   void result; with operator 0x45 (probably a conditional the compiler made, whose value
   is not used) and a void wanted type both arms are converted to void. Otherwise the
   arms are balanced to a common type (BALANCE_BINARY_OPERANDS), pointer arms must have
   compatible targets (MSG_TWO_OPERANDS_MUST), and a pointer result gets the union of
   both targets' const/volatile bits. The node always ends as EOP_QUESTION. */
/* 00D3: reconcile the two children and propagate their common type. */
static unsigned int near pascal C78_reconcile_pair(unsigned int parent,unsigned int type)
{
    unsigned int second;
    unsigned char first_missing,second_missing;
    unsigned int first_type,second_type,selected_type;
    unsigned int first;
    register unsigned int tree;

    first=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(parent,EXPR_LEFT),0,0));
    if(CPP_MODE) first=CONVERT_CLASS_TO_SCALAR(first);
    if(TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_KIND)==TK_VOID) {
        first=REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,first);
    } else if(!(EXPR_FLAGS[TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_KIND)]&7)) {
        first=REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SCALAR_TYPE,first);
    }
    EXPR_W(parent,EXPR_LEFT)=first;
    tree=EXPR_W(parent,EXPR_RIGHT);
    ++CONDITIONAL_ARM_DEPTH;
    first=ANALYZE_EXPRESSION(EXPR_W(tree,EXPR_LEFT),type,0);
    second=ANALYZE_EXPRESSION(EXPR_W(tree,EXPR_RIGHT),type,0);
    --CONDITIONAL_ARM_DEPTH;

    if(!((EXPR_FLAGS[TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_KIND)]&0x14) &&
         (TYPE_B(EXPR_W(first,EXPR_TYPE),TYPE_ATTRS)&0x20) &&
         (EXPR_FLAGS[TYPE_W(EXPR_W(second,EXPR_TYPE),TYPE_KIND)]&0x14) &&
         (TYPE_B(EXPR_W(second,EXPR_TYPE),TYPE_ATTRS)&0x20)) ||
       (unsigned char)C78_special_symbol(first) ||
       (unsigned char)C78_special_symbol(second)) {
        first=CONVERT_TO_RVALUE(first);
        second=CONVERT_TO_RVALUE(second);
    }
    EXPR_W(tree,EXPR_LEFT)=first;
    EXPR_W(tree,EXPR_RIGHT)=second;
    first_missing=!first || TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_KIND)==TK_VOID;
    second_missing=!second || TYPE_W(EXPR_W(second,EXPR_TYPE),TYPE_KIND)==TK_VOID;
    /* This read precedes the Boolean cases even when first is zero. */
    selected_type=EXPR_W(first,EXPR_TYPE);
    if(first_missing && second_missing) selected_type=VOID_TYPE;
    else if(EXPR_W(parent,EXPR_OP)!=EOP_QUESTION && TYPE_W(type,TYPE_KIND)==TK_VOID) {
        selected_type=VOID_TYPE;
        EXPR_W(tree,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(VOID_TYPE,first,0);
        EXPR_W(tree,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(VOID_TYPE,second,0);
    } else if(!first_missing && !second_missing) {
        if(TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_KIND)==TK_ENUM && TYPES_COMPATIBLE(EXPR_W(first,EXPR_TYPE),EXPR_W(second,EXPR_TYPE),1))
            selected_type=EXPR_W(first,EXPR_TYPE);
        else {
            tree=BALANCE_BINARY_OPERANDS(type,tree);
            selected_type=EXPR_W(tree,EXPR_TYPE);
            first=EXPR_W(tree,EXPR_LEFT);
            second=EXPR_W(tree,EXPR_RIGHT);
        }
    }

    if(selected_type!=VOID_TYPE && EXPR_W(parent,EXPR_OP)==EOP_QUESTION) {
        if((EXPR_FLAGS[TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_KIND)]&0x14) &&
           (EXPR_FLAGS[TYPE_W(EXPR_W(second,EXPR_TYPE),TYPE_KIND)]&0x14)) {
            first_type=TYPE_W(EXPR_W(first,EXPR_TYPE),TYPE_TARGET);
            second_type=TYPE_W(EXPR_W(second,EXPR_TYPE),TYPE_TARGET);
        } else {
            first_type=EXPR_W(first,EXPR_TYPE);
            second_type=EXPR_W(second,EXPR_TYPE);
        }
        if(!TYPES_COMPATIBLE(first_type,second_type,1))
            return REPORT_EXPR_ERROR_PLAIN(MSG_TWO_OPERANDS_MUST,parent);
    }

    EXPR_W(parent,EXPR_OP)=EOP_QUESTION;
    if(EXPR_FLAGS[TYPE_W(selected_type,TYPE_KIND)]&0x14) {
        first_type=EXPR_W(first,EXPR_TYPE);
        if((EXPR_FLAGS[TYPE_W(first_type,TYPE_KIND)]&0x14) &&
           TYPE_W(TYPE_W(first_type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION) {
            if(TYPE_B(TYPE_W(first_type,TYPE_TARGET),TYPE_FUNC_FLAGS)&8) selected_type=EXPR_W(second,EXPR_TYPE);
            else selected_type=first_type;
        } else {
            first_type=TYPE_W(first_type,TYPE_TARGET);
            second_type=TYPE_W(EXPR_W(second,EXPR_TYPE),TYPE_TARGET);
            first_type=ADD_CV_QUALIFIERS(TYPE_W(selected_type,TYPE_TARGET),
                (TYPE_B(first_type,TYPE_ATTRS)|TYPE_B(second_type,TYPE_ATTRS))&2,
                (TYPE_B(first_type,TYPE_ATTRS)|TYPE_B(second_type,TYPE_ATTRS))&1);
            selected_type=MAKE_POINTER_TYPE(first_type,TYPE_W(selected_type,TYPE_KIND),
                (TYPE_B(selected_type,TYPE_ATTRS)&0x20)!=0);
        }
        EXPR_W(tree,EXPR_TYPE)=selected_type;
    }
    EXPR_W(parent,EXPR_TYPE)=selected_type;
    EXPR_B(tree,EXPR_NODE_FLAGS)|=1;
    EXPR_B(parent,EXPR_NODE_FLAGS)|=1;
    return parent;
}

/* C78_lower_value: analyses a cast node (operator 0x35) to the type stored in it: in
   C++ CAST_EXPRESSION may handle it (class conversions); otherwise the operand is
   analysed with the target type as wanted type, read as an rvalue unless casting to a
   reference, and CHECK_CAST validates the conversion. */
/* 04E5: obtain an existing value or lower and attach its child. */
static unsigned int near pascal C78_lower_value(unsigned int expression,unsigned int type)
{
    unsigned int result=0;
    result=CPP_MODE?CAST_EXPRESSION(expression,type):0;
    if(!result) {
        result=ANALYZE_EXPRESSION(EXPR_W(expression,EXPR_LEFT),EXPR_W(expression,EXPR_TYPE),0);
        if((EXPR_FLAGS[TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)]&0x14)==0 ||
           (TYPE_B(EXPR_W(expression,EXPR_TYPE),TYPE_ATTRS)&0x20)==0) result=CONVERT_TO_RVALUE(result);
        EXPR_W(expression,EXPR_LEFT)=result;
        result=CHECK_CAST(expression);
    }
    return result;
}

/* C78_apply_value_type: an int constant wanted as a smaller integer type (char, short)
   takes that type when its value survives the truncation (TOKEN_CONVERT), so that for
   example c == 'a' can be done on bytes. */
/* 056A: change type only when conversion preserves the complete value. */
static unsigned int near pascal C78_apply_value_type(unsigned int expression,unsigned int type)
{
    long converted;
    if(!type || !(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&1) || (int)TYPE_W(type,TYPE_KIND)>=TK_INT ||
       TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)!=TK_INT) return expression;
    converted=TOKEN_CONVERT(EXPR_L(expression,EXPR_VALUE),(int)TYPE_W(type,TYPE_KIND));
    if(EXPR_L(expression,EXPR_VALUE)==converted) EXPR_W(expression,EXPR_TYPE)=type;
    EXPR_B(expression,EXPR_NODE_FLAGS)|=1;
    return expression;
}

/* ANALYZE_EXPRESSION: analyses expression with wanted type "type" and returns the
   analysed tree (possibly a different node, an error node, or 0 for 0). The case list
   maps each operator to its checker; operators listed with the default are already in
   their final form when they reach here. */
/* 05F4: all original kinds 1..74, with a single selected case action. */
unsigned int far pascal ANALYZE_EXPRESSION(unsigned int expression,unsigned int type,unsigned int context)
{
    unsigned int result,child,child_type;

    /* A genuine architectural query, not automatic -N instrumentation. */
    if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    if(!expression || ((EXPR_B(expression,EXPR_NODE_FLAGS)&1) && EXPR_W(expression,EXPR_OP)!=EOP_CONST)) return expression;
    switch(EXPR_W(expression,EXPR_OP)) {
    case EOP_DEREF:
        expression=BUILD_DEREF(expression,context,
            (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20));
        break;
    case EOP_ADDR:case 0x42:
        expression=BUILD_ADDRESS_OF(expression,context,type);
        break;
    case EOP_INC:case EOP_DEC:
        expression=BUILD_INCDEC(expression,context);
        break;
    case EOP_NEG:case 0x49:
        expression=BUILD_UNARY_ARITH(expression,context,type);
        break;
    case EOP_COMPL:
        expression=BUILD_COMPLEMENT(expression,context,type);
        break;
    case EOP_NOT:
        expression=BUILD_LOGICAL_NOT(expression,context);
        break;
    case EOP_INDEX:
        expression=CHECK_SUBSCRIPT(expression,context);
        break;
    case EOP_DOT:
        expression=CHECK_DOT_MEMBER(expression,0);
        break;
    case EOP_DOT_STAR:
        expression=ANALYZE_DOT_STAR(expression);
        break;
    case EOP_ARROW:
        expression=CHECK_POINTER_INDIRECTION(expression,context,0x3B);
        break;
    case EOP_ARROW_STAR:
        expression=CHECK_POINTER_INDIRECTION(expression,context,0x3C);
        break;
    case EOP_MUL:case EOP_DIV:
        expression=CHECK_MULTIPLICATIVE_OP(expression,context,type,3);
        break;
    case EOP_MOD:case EOP_AND:case EOP_OR:case EOP_XOR:
        expression=CHECK_MULTIPLICATIVE_OP(expression,context,type,1);
        break;
    case EOP_SHL:case EOP_SHR:
        expression=CHECK_INTEGRAL_OP(expression,context);
        break;
    case EOP_ADD:
        expression=CHECK_ADDITION(expression,context,type);
        break;
    case EOP_SUB:
        expression=CHECK_SUBTRACTION(expression,context,type);
        break;
    case EOP_ANDAND:case EOP_OROR:
        expression=CHECK_LOGICAL_OP(expression,context);
        break;
    case EOP_EQ:case EOP_NE:case EOP_GT:case EOP_LT:case EOP_GE:case EOP_LE:
        expression=CHECK_COMPARISON(expression,context);
        break;
    case EOP_ASSIGN:
        expression=CHECK_ASSIGNMENT(expression);
        break;
    case 0x47:
        expression=CHECK_INITIALIZATION(expression);
        break;
    case EOP_ADD_ASSIGN:case EOP_SUB_ASSIGN:case EOP_MUL_ASSIGN:case EOP_DIV_ASSIGN:
        expression=CHECK_COMPOUND_ASSIGNMENT(expression,context,7);
        break;
    case EOP_MOD_ASSIGN:case EOP_SHL_ASSIGN:case EOP_SHR_ASSIGN:case EOP_AND_ASSIGN:case EOP_OR_ASSIGN:case EOP_XOR_ASSIGN:
        expression=CHECK_COMPOUND_ASSIGNMENT(expression,context,1);
        break;
    case EOP_COMMA:
        expression=ANALYZE_COMMA_EXPR(expression,context,type);
        break;
    case EOP_NEW:
        expression=ANALYZE_NEW_EXPRESSION(expression);
        break;
    case EOP_DELETE:
        expression=ANALYZE_DELETE_EXPRESSION(expression);
        break;
    case 0x46:
        expression=CHECK_RETURN_VALUE(expression);
        break;
    case 0x36:
        expression=ANALYZE_CALL(expression,context);
        break;
    case 0x35:
        expression=C78_lower_value(expression,context);
        break;
    case 0x37:
        expression=ANALYZE_TEMP_OBJECT_NODE(expression,context);
        break;
    case EOP_QUESTION:case 0x45:
        expression=C78_reconcile_pair(expression,type);
        break;
    /* sizeof expr: analyse the operand, refuse bitfields and functions, look through a
       reference, and replace the whole node by a size_t constant (0 size is an error) */
    case EOP_SIZEOF:
        child=ANALYZE_EXPRESSION(EXPR_W(expression,EXPR_LEFT),0,0);
        EXPR_W(expression,EXPR_LEFT)=child;
        if(EXPR_W(child,EXPR_OP)==EOP_DOT && EXPR_W(EXPR_W(child,EXPR_RIGHT),EXPR_OP)==0x39 &&
           (EXPR_B(EXPR_W(child,EXPR_RIGHT),EXPR_NODE_FLAGS)&4)) {
            expression=REPORT_EXPR_ERROR_PLAIN(MSG_SIZEOF_MAY_NOT_APPLIED,expression);
            break;
        }
        if(EXPR_W(child,EXPR_OP)==0) {
            FREE_EXPR_NODE(expression);
            expression=child;
            break;
        }
        child_type=EXPR_W(child,EXPR_TYPE);
        if((EXPR_FLAGS[TYPE_W(child_type,TYPE_KIND)]&0x14) && (TYPE_B(child_type,TYPE_ATTRS)&0x20))
            child_type=TYPE_W(child_type,TYPE_TARGET);
        if(EXPR_W(child,EXPR_OP)==EOP_DOT && (EXPR_B(EXPR_W(child,EXPR_RIGHT),EXPR_NODE_FLAGS)&4))
            expression=REPORT_EXPR_ERROR_PLAIN(MSG_SIZEOF_MAY_NOT_APPLIED,expression);
        if(TYPE_W(child_type,TYPE_KIND)==TK_FUNCTION) {
            expression=REPORT_EXPR_ERROR_PLAIN(MSG_SIZEOF_MAY_NOT_APPLIED_257,expression);
            break;
        }
        result=MAKE_INT_CONSTANT(SIZE_T_TYPE,
            TOKEN_CONVERT(TYPE_SIZE(child_type),(int)TYPE_W(SIZE_T_TYPE,TYPE_KIND)));
        FREE_EXPR_TREE(expression);
        expression=result;
        if(!TYPE_SIZE(child_type)) expression=REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,expression);
        break;
    case 0x4A:
        EXPR_W(expression,EXPR_TYPE)=MEMBER_W(EXPR_W(expression,EXPR_LEFT),MEMB_TYPE);
        break;
    case 1:
        expression=RESOLVE_SYMBOL_REFERENCE(expression,type);
        break;
    case EOP_CONST:
        expression=C78_apply_value_type(expression,type);
        break;
    case 3:case 4:case 5:case 6:case 7:case EOP_POSTINC:case EOP_POSTDEC:case EOP_COLON:
    case 0x29:case 0x2B:case 0x2C:case 0x2D:case 0x33:case 0x34:
    case 0x38:case 0x39:case 0x48:
    default:
        break;
    }
    EXPR_B(expression,EXPR_NODE_FLAGS)|=1;
    return expression;
}

/* ANALYZE_AND_DECAY: ANALYZE_EXPRESSION followed by CONVERT_TO_RVALUE unless the value
   is discarded (type VOID_TYPE): the usual entry point when a value is needed. */
/* 0982: dispatch first, then normalize against the freshly read default type. */
unsigned int far pascal ANALYZE_AND_DECAY(unsigned int expression,unsigned int type)
{
    unsigned int result;
    result=ANALYZE_EXPRESSION(expression,type,0);
    if(type!=VOID_TYPE) result=CONVERT_TO_RVALUE(result);
    return result;
}

/* target: ovr071_C236UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: C++ constructors, destructors, virtual bases. Entry points: FREE_PARAM_LIST,
   LIST_CONTAINS_VALUE, QUEUE_DEFERRED_SYMBOL, CANNOT_CONVERT_TYPES, BUILD_BASE_ADDRESS,
   BUILD_VBASE_ADDRESS, BUILD_DESTRUCTOR_CALL, ALLOC_TEMP_ENTRY (+35 more). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: the expression builders behind C++ object lifetime. Nothing here parses;
   callers in CTORBODY.C (constructor and destructor bodies), CPPINIT.C, CPPEXPCK.C,
   SPECMEMB.C, BASECONV.C and the statement parser ask for ready-made expression trees:
   - constructor and destructor calls (BUILD_CONSTRUCTOR_CALL, BUILD_DESTRUCTOR_CALL,
     BUILD_SPECIAL_MEMBER_CALL), including arrays through VECTOR_DELETE_SYMBOL;
   - the pieces of a constructor body: base, virtual-base and member initializers
     (BUILD_BASE_INITS, BUILD_VBASE_INITS, BUILD_MEMBER_INITS) and the stores of
     virtual table pointers (BUILD_VPTR_INITS); and of a destructor body
     (BUILD_DESTRUCTOR_BODY);
   - temporaries that need destroying: REGISTER_TEMP_DESTRUCTOR keeps a list of packed
     destructor calls (TDTOR records) with serial numbers, and BUILD_TEMP_DESTRUCTORS
     emits the calls between two points of that list;
   - base-class questions (IS_BASE_CLASS, IS_UNIQUE_BASE, COLLECT_VBASES) and lookups of
     the default constructor, copy constructor and copy assignment.
   The trees are built with token codes, not EOP_ operators: MAKE_UNARY_NODE and
   MAKE_BINARY_NODE translate them (TOKEN_TO_OPERATOR in EXPRPOOL.C). Codes seen here:
   0x0B '=', 0x16 '+', 0x18 '*' (unary: dereference), 0x1B '&' (binary: bit test),
   0x1D (unary, used as address-of), 0x2F '.', 5 (initialization, operator 0x47),
   and MAKE_CONDITIONAL_NODE(0x6B or 0x20, c, a, b) for c ? a : b.
   TOKEN_NAMES[] (DS:6182) doubles as the table of special member names: [5] names
   constructors, [6] destructors, [0x0B] operator=, [0x72] the this parameter, [0x73]
   both the hidden virtual table pointer member and the constructors' hidden
   virtual-base flag. Several DATA.H globals are really entries of this array, under
   names that hide it: CTOR_NAME (DS:618C) is TOKEN_NAMES[5],
   DTOR_NAME (DS:618E) TOKEN_NAMES[6], CONVERSION_FUNC_NAME (DS:61F0)
   TOKEN_NAMES[0x37], OPERATOR_DELETE_NAME (DS:6254) TOKEN_NAMES[0x69] (also the
   name of the destructors' hidden flags parameter), OPERATOR_NEW_NAME (DS:625A)
   TOKEN_NAMES[0x6C], THIS_NAME
   (DS:6266) TOKEN_NAMES[0x72] and VTABLE_PTR_NAME (DS:6268) TOKEN_NAMES[0x73].
   A class with virtual bases (TAG_CLASS_FLAGS bit 4) gets one more hidden int
   parameter in its constructors (0 for a complete object, 1 when called for a base
   subobject) that says whether the virtual bases must be built; destructors get a
   flag parameter too (bit 1 call operator delete, bit 2 destroy virtual bases).
   CTOR_THIS_SYMBOL is the this parameter of the member function being compiled (set
   for every member function body, 0 outside them), not only of constructors.
   Base lists are BASE records (struct ParameterItem below is the same 9-byte record);
   the mem-initializer list is MINIT records. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"
struct ParameterItem { unsigned int next,type,offset; unsigned char scope,qualifier,used; };

/* ---- FREE_PARAM_LIST (listing 0000) ---- */
/* row X00F_17 (offset 0x0): stub 0BE2:00B1 = FREE_PARAM_LIST */
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);

/* FREE_PARAM_LIST: frees a whole list of BASE records (for example the copy made by
   COLLECT_VBASES). */
void far pascal FREE_PARAM_LIST(register unsigned int node)
{
    unsigned int cur;

    while(node) {
        cur=node;
        node=BASE_W(node,BASE_NEXT);
        POOL_FREE_ITEM(&BASE_LIST_SEG,cur);
    }
}

/* ---- LIST_CONTAINS_VALUE (listing 002D) ---- */
/* row X00F_26 (offset 0x2D): stub 0BE2:007F = LIST_CONTAINS_VALUE */

/* LIST_CONTAINS_VALUE: 1 if the CONS list starting at node holds value. */
unsigned char far pascal LIST_CONTAINS_VALUE(unsigned int value,unsigned int node)
{
    if(node==0)
        return 0;
    CONS_W(0,2)=value;     /* sentinel in record 0 ends the search */
    while(CONS_W(node,CONS_VALUE)!=value)
        node=CONS_W(node,CONS_NEXT);
    return node!=0;
}

/* ---- QUEUE_DEFERRED_SYMBOL (listing 006D) ---- */
/* row QUEUE_DEFERRED_SYMBOL (offset 0x6D): stub 0BE2:0052 = QUEUE_DEFERRED_SYMBOL */
extern signed char  MODEL_FAR_CODE;    /* sign-extended (cbw at 00C0) */
extern char far * far pascal MANGLE_SYMBOL_NAME(unsigned int);
extern unsigned int far pascal BCC_INTERN_STRING(char far *);
extern unsigned int far pascal DEFINE_SEGMENT_FIXED_ID(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern void far pascal SET_PREPARED_FLAGS(unsigned int,unsigned int);
extern unsigned int far pascal LIST_CONS(unsigned int,unsigned int);

/* QUEUE_DEFERRED_SYMBOL: called when a function without an ordinary body is used in
   a way that needs a real one: an inline function with a recorded body (inline kind
   1) or a compiler-declared special member (kind 2), whose address is taken, that is
   called without being expanded, or that goes into a virtual table. The first time
   (SYM_FUNC_FLAGS bit 2 marks it queued) the symbol is pushed on
   PENDING_DEFINITION_LIST, which CPPFINAL.C drains at the end of the file
   (COMPILE_INLINE_BODY or C13INITIALIZE). When VTABLE_MODE is 3 (probably the
   "smart" -V mode, see CPPFINAL.C) and the code is near or the symbol has flag 0x80 or
   0x10, the function gets its own code segment named after its mangled name, numbered
   from OBJ_EXTERN_INDEX, so the linker can merge duplicate copies (probably). Does
   nothing once code generation is off (NO_ERRORS_YET 0). */
void far pascal QUEUE_DEFERRED_SYMBOL(register unsigned int symbol)
{
    unsigned int record;
    unsigned int name;
    unsigned int bits;

    if(!NO_ERRORS_YET)
        return;
    if((SYM_B(symbol,SYM_INLINE_ACCESS)&3)!=1 && (SYM_B(symbol,SYM_INLINE_ACCESS)&3)!=2)
        return;
    if(!(SYM_W(symbol,SYM_FUNC_FLAGS)&2)) {
        if(VTABLE_MODE==3 && (!MODEL_FAR_CODE || (SYM_B(symbol,SYM_FLAGS)&0x90))) {
            bits=DEFAULT_CODE_SEGMENT_ID;
            if(SYM_B(symbol,SYM_FLAGS)&0x80)
                bits|=0x8000;
            name=DEFINE_SEGMENT_FIXED_ID(OBJ_EXTERN_INDEX+0x4000,bits,2,
                BCC_INTERN_STRING(MANGLE_SYMBOL_NAME(symbol)));
            record=PREPARE_SYMBOL(symbol);
            SET_SYMBOL_SEGMENT_HOOK(record,name);
            SET_SYMBOL_OFFSET_HOOK(record,OBJ_EXTERN_INDEX++);
            SET_PREPARED_FLAGS(record,0x100);
        }
        SYM_W(symbol,SYM_FUNC_FLAGS)|=2;
        PENDING_DEFINITION_LIST=LIST_CONS(PENDING_DEFINITION_LIST,symbol);
    }
}

/* ---- CANNOT_CONVERT_TYPES (listing 014C) ---- */
/* row CANNOT_CONVERT_TYPES (offset 0x14C): stub 0BE2:00E3 = CANNOT_CONVERT_TYPES */
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal FIND_USER_CONVERSION(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int);

/* CANNOT_CONVERT_TYPES: 1 when a value of type right cannot be converted to type
   left: not compatible directly, nor through a reference on either side, and no user
   conversion (constructor or conversion function) is found. */
unsigned char far pascal CANNOT_CONVERT_TYPES(unsigned int right,unsigned int left)
{
    unsigned int result;

    if(C7_TYPE_COMPAT(right,left,0) ||
       ((EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) && (TYPE_B(right,TYPE_ATTRS)&0x20) &&
        C7_TYPE_COMPAT(TYPE_W(right,TYPE_TARGET),left,0)))
        return 0;
    if((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && (TYPE_B(left,TYPE_ATTRS)&0x20))
        left=TYPE_W(left,TYPE_TARGET);
    result=FIND_USER_CONVERSION(right,left,0,0,0);
    return result==0;
}

/* ---- BUILD_BASE_ADDRESS (listing 01D0) ---- */
/* row ADD_THIS_PARAMETER (offset 0x1D0): stub 0BE2:00B6 = BUILD_BASE_ADDRESS */
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);

/* BUILD_BASE_ADDRESS: returns the lvalue *(type *)((char *)&tree + offset), the
   subobject of class type that lies offset bytes into the object tree. */
unsigned int far pascal BUILD_BASE_ADDRESS(unsigned int tree,int offset,unsigned int type)
{
    unsigned int base;
    unsigned int node;
    unsigned int pointer;

    pointer=MAKE_POINTER_TYPE(type,0,0);
    base=MAKE_POINTER_TYPE(CHAR_TYPE,TYPE_W(pointer,TYPE_KIND),0);
    node=MAKE_CAST_NODE(base,MAKE_UNARY_NODE(0x1D,tree));
    node=MAKE_BINARY_NODE(0x16,node,MAKE_INT_CONSTANT(INT_TYPE,(long)offset));
    return MAKE_UNARY_NODE(0x18,MAKE_CAST_NODE(pointer,node));
}

/* ---- BUILD_VBASE_ADDRESS (listing 0249) ---- */
/* row X00F_0B (offset 0x249): stub 0BE2:0025 = BUILD_VBASE_ADDRESS */

/* BUILD_VBASE_ADDRESS: returns *(type **)((char *)&tree + offset), the virtual base
   pointer stored at offset inside the object tree (an lvalue of type pointer to
   type, so it can be read or assigned). */
unsigned int far pascal BUILD_VBASE_ADDRESS(unsigned int tree,int offset,unsigned int type)
{
    unsigned int pointer;
    unsigned int node;

    node=MAKE_CAST_NODE(CHAR_POINTER_TYPE,MAKE_UNARY_NODE(0x1D,tree));
    node=MAKE_BINARY_NODE(0x16,node,MAKE_INT_CONSTANT(INT_TYPE,(long)offset));
    pointer=MAKE_POINTER_TYPE(type,0,0);
    return MAKE_UNARY_NODE(0x18,MAKE_CAST_NODE(MAKE_POINTER_TYPE(pointer,0,0),node));
}

/* ---- BUILD_SINGLE_DTOR_CALL (listing 02BA) ---- */
unsigned int far pascal BUILD_SPECIAL_MEMBER_CALL(register unsigned int op,unsigned int tree,unsigned int value);
/* row BUILD_SINGLE_DTOR_CALL (offset 0x2BA): stub none (static) = BUILD_SINGLE_DTOR_CALL */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);

/* BUILD_SINGLE_DTOR_CALL: tree.~type(flags) for one object. Unless flags bit 2 is
   set, the qualifying class of the destructor name is set to type, which makes the
   call non-virtual (probably: it names exactly this class's destructor). */
static unsigned int far pascal BUILD_SINGLE_DTOR_CALL(unsigned int tree,unsigned int type,int flags)
{
    unsigned int count;
    unsigned int node;

    count=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,(long)flags),0);
    node=BUILD_SPECIAL_MEMBER_CALL(6,tree,count);
    if(!(flags&2))
        EXPR_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_RIGHT),EXPR_RIGHT)=type;
    return node;
}

/* ---- BUILD_DESTRUCTOR_CALL (listing 0312) ---- */
int far pascal DESTRUCTOR_CALL_FLAGS(unsigned int type,unsigned int symbol);
/* row BUILD_DESTRUCTOR_CALL (offset 0x312): stub 0BE2:0057 = BUILD_DESTRUCTOR_CALL */
extern unsigned int far pascal MAKE_CALL_NODE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned char far pascal IS_LINK_TIME_CONSTANT(unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int,unsigned int);
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_LINE(int,long,long);
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal FREE_EXPR_TREE(unsigned int);

/* BUILD_DESTRUCTOR_CALL: builds the call that destroys tree, an object of type (or an
   array of them; dim is an extra element count for new[]-style arrays, or 0). Returns 0
   (and frees tree and dim) when the type has no destructor (TYPE_ATTRS bit 8). Arrays
   are flattened: the count multiplies the extents and a constant dim; one object uses
   BUILD_SINGLE_DTOR_CALL, more use the run-time helper VECTOR_DELETE_SYMBOL with
   (address, element size, count, mode, &destructor). Reports MSG_DESTRUCTOR_NOT
   when the destructor is not accessible from CURRENT_CLASS_TYPE. */
unsigned int far pascal BUILD_DESTRUCTOR_CALL(unsigned int tree,unsigned int type,unsigned int dim,int flags)
{
    long count;
    unsigned int member;
    unsigned char simple;

    count=1;
    if(TYPE_B(type,TYPE_ATTRS)&8) {
        while(TYPE_W(type,TYPE_KIND)==TK_ARRAY) {
            count*=TYPE_L(type,TYPE_ARRAY_COUNT);
            tree=MAKE_UNARY_NODE(0x18,tree);
            type=TYPE_W(type,TYPE_TARGET);
        }
        if(IS_LINK_TIME_CONSTANT(dim) && dim) {
            dim=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(dim,INT_TYPE),0);
            if(EXPR_W(dim,EXPR_OP)==EOP_CONST) {
                count*=EXPR_I(dim,EXPR_VALUE);
                FREE_EXPR_NODE(dim);
                dim=0;
            }
        }
        if(dim==0) {
            if(!(simple=count==1))
                dim=MAKE_INT_CONSTANT(INT_TYPE,count);
        } else {
            simple=0;
            dim=MAKE_BINARY_NODE(0x18,dim,MAKE_INT_CONSTANT(INT_TYPE,count));
        }
        member=FIND_MEMBER_BY_NAME(DTOR_NAME,type);
        if(!MEMBER_ACCESSIBLE(member,CURRENT_CLASS_TYPE)) {
            REPORT_DIAGNOSTIC_LINE(MSG_DESTRUCTOR_NOT,(long)SYMBOL_NAME_TEXT(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL)),0L);
            FREE_EXPR_TREE(tree);
            return 0;
        }
        if(simple)
            return BUILD_SINGLE_DTOR_CALL(tree,type,flags);
        return MAKE_CALL_NODE(MAKE_SYMBOL_NODE(VECTOR_DELETE_SYMBOL),
            MAKE_CAST_NODE(FAR_VOID_PTR_TYPE,MAKE_UNARY_NODE(0x1D,tree)),
            MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(type)),
            dim,
            MAKE_INT_CONSTANT(INT_TYPE,(long)((flags&1)<<3|DESTRUCTOR_CALL_FLAGS(type,MEMBER_W(member,MEMB_VALUE)))),
            MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(MEMBER_W(member,MEMB_VALUE))));
    }
    FREE_EXPR_TREE(tree);
    FREE_EXPR_TREE(dim);
    return 0;
}

/* ---- BUILD_SUBOBJECT_DTORS (listing 0515) ---- */
/* row BUILD_SUBOBJECT_DTORS (offset 0x515): stub none (static) = BUILD_SUBOBJECT_DTORS */
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int);

/* BUILD_SUBOBJECT_DTORS: comma list of destructor calls for the non-virtual bases
   and the data members of type that have destructors, given the object tree (the
   copies are made with COPY_EXPR_TREE and tree is freed). Each new call is put in
   front, so members are destroyed in reverse order of declaration, then bases. */
static unsigned int far pascal BUILD_SUBOBJECT_DTORS(unsigned int tree,unsigned int type)
{
    unsigned int param;
    unsigned int member;
    register unsigned int result;
    register unsigned int node;

    result=0;
    param=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);
    while(param) {
        if(!BASE_B(param,BASE_VIRTUAL) && (TYPE_B(BASE_W(param,BASE_TYPE),TYPE_ATTRS)&8)) {
            node=BUILD_SINGLE_DTOR_CALL(COPY_EXPR_TREE(tree),BASE_W(param,BASE_TYPE),0);
            result=JOIN_COMMA_EXPR(node,result);
        }
        param=BASE_W(param,BASE_NEXT);
    }
    member=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member) {
        if((MEMBER_B(member,MEMB_FLAGS)&3)==0 && (TYPE_B(MEMBER_W(member,MEMB_TYPE),TYPE_ATTRS)&8)) {
            node=MAKE_BINARY_NODE(0x2F,COPY_EXPR_TREE(tree),MAKE_FIELD_REF_NODE(member));
            result=JOIN_COMMA_EXPR(BUILD_DESTRUCTOR_CALL(node,MEMBER_W(member,MEMB_TYPE),0,2),result);
        }
        member=MEMBER_W(member,MEMB_NEXT);
    }
    FREE_EXPR_TREE(tree);
    return result;
}

/* ---- ALLOC_TEMP_ENTRY (listing 0621) ---- */
/* row ALLOC_TEMP_ENTRY (offset 0x621): stub 0BE2:00E8 = ALLOC_TEMP_ENTRY */
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);

/* ALLOC_TEMP_ENTRY / FREE_TEMP_ENTRY: a 6-byte TDTOR record in TEMP_ENTRY_POOL_SEG. */
unsigned int far pascal ALLOC_TEMP_ENTRY(void)
{
    unsigned int node;

    node=POOL_ALLOC_REUSE(&TEMP_ENTRY_POOL_SEG,6);
    return node;
}

/* ---- FREE_TEMP_ENTRY (listing 063B) ---- */
/* row FREE_TEMP_ENTRY (offset 0x63B): stub 0BE2:00F2 = FREE_TEMP_ENTRY */

void far pascal FREE_TEMP_ENTRY(unsigned int node)
{
    POOL_FREE_ITEM(&TEMP_ENTRY_POOL_SEG,node);
}

/* ---- REGISTER_TEMP_DESTRUCTOR (listing 064F) ---- */
/* row ADD_UNIQUE_PARAM (offset 0x64F): stub 0BE2:0084 = REGISTER_TEMP_DESTRUCTOR */
extern unsigned int  BCC_TREE_SPECIAL;
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern unsigned int far pascal PACK_EXPR_TREE(unsigned int);

/* REGISTER_TEMP_DESTRUCTOR: records that the object tree (a temporary or local of
   type) must be destroyed later. Builds its destructor call, analyzes it (inside a
   function), packs it and links a new TDTOR record in front of next, stamped with a
   new DESTRUCTOR_ENTRY_SERIAL. Returns the new list head, or next unchanged when the
   type needs no destructor. Warns when this happens inside a conditional
   (CONDITIONAL_ARM_DEPTH) and stops an inline function from being expanded inline
   (clears SYM_FUNC_FLAGS bit 4 of BCC_TREE_SPECIAL, the current function). */
unsigned int far pascal REGISTER_TEMP_DESTRUCTOR(unsigned int tree,unsigned int type,unsigned int next)
{
    register unsigned int node;
    register unsigned int expr;

    expr=BUILD_DESTRUCTOR_CALL(tree,type,0,2);
    if(!expr)
        return next;
    if(CONDITIONAL_ARM_DEPTH)
        REPORT_NAME_DIAGNOSTIC(MSG_DESTRUCTOR_REQUIRED,SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME));
    if(INLINE_FUNCTION_STACK) {
        REPORT_DIAGNOSTIC(MSG_FUNCTIONS_CONTAINING,(char far *)STR_LOCAL_DESTRUCTORS,0L);
        SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_FLAGS)&=~4;
    }
    DESTRUCTOR_ENTRY_SERIAL++;
    node=ALLOC_TEMP_ENTRY();
    TDTOR_W(node,TDTOR_NEXT)=next;
    TDTOR_W(node,TDTOR_SERIAL)=DESTRUCTOR_ENTRY_SERIAL;
    if(CURRENT_SCOPE!=GLOBAL_SCOPE)
        expr=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expr,VOID_TYPE),1);
    TDTOR_W(node,TDTOR_EXPR)=PACK_EXPR_TREE(expr);
    FREE_EXPR_TREE(expr);
    return node;
}

/* ---- BUILD_TEMP_DESTRUCTORS (listing 071A) ---- */
/* row BUILD_TEMP_DESTRUCTORS (offset 0x71A): stub 0BE2:0061 = BUILD_TEMP_DESTRUCTORS */
extern unsigned int far pascal UNPACK_EXPR_TREE(unsigned int);

/* BUILD_TEMP_DESTRUCTORS: comma expression of the destructor calls for every entry
   on the list from that is newer than the list position to, newest first; used when
   leaving a scope or a full expression. Serial numbers show the order: the first loop
   moves to back to the newest entry not newer than from, the second unpacks the
   entries of from that are newer. The result gets the current token's position. */
unsigned int far pascal BUILD_TEMP_DESTRUCTORS(register unsigned int from,unsigned int to)
{
    register unsigned int result;

    result=0;
    /* Skip entries of to that are newer than from (serials only grow). */
    while(TDTOR_W(to,TDTOR_SERIAL)>TDTOR_W(from,TDTOR_SERIAL))
        to=TDTOR_W(to,TDTOR_NEXT);
    /* Then collect the destructor calls of the entries of from newer than that. */
    while(TDTOR_W(from,TDTOR_SERIAL)>TDTOR_W(to,TDTOR_SERIAL)) {
        result=JOIN_COMMA_EXPR(result,UNPACK_EXPR_TREE(TDTOR_W(from,TDTOR_EXPR)));
        from=TDTOR_W(from,TDTOR_NEXT);
    }
    if(result) {
        EXPR_W(result,EXPR_SRC_FILE)=CURRENT_TOKEN_FILE;
        EXPR_W(result,EXPR_SRC_LINE)=CURRENT_TOKEN_LINE;
        EXPR_W(result,EXPR_SRC_WORD3)=CURRENT_TOKEN_LOC_WORD3;
    }
    return result;
}

/* ---- DESTRUCTOR_CALL_FLAGS (listing 0799) ---- */
/* row X00F_1B (offset 0x799): stub 0BE2:004D = DESTRUCTOR_CALL_FLAGS */

/* DESTRUCTOR_CALL_FLAGS: mode bits for the vector helpers: 1 the destructor symbol
   is a far function, 2 its calling convention byte is 2 (probably pascal), 4 the
   class is far or huge (TAG_CLASS_FLAGS 8 or 0x100), so object addresses are far. */
int far pascal DESTRUCTOR_CALL_FLAGS(unsigned int type,unsigned int symbol)
{
    int flags;

    flags=0;
    if(TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_FUNC_FLAGS)&1)
        flags=1;
    if(TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_CALL_CONV)==2)
        flags|=2;
    if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x108)
        flags|=4;
    return flags;
}

/* ---- BUILD_THIS_ALLOCATION (listing 07F3) ---- */
unsigned int far pascal BUILD_THIS_NODE(register unsigned int symbol);
/* row X00F_12 (offset 0x7F3): stub 0BE2:0093 = BUILD_THIS_ALLOCATION */
extern unsigned int far pascal FIND_MEMBER_REPORT(unsigned int,unsigned int);

/* BUILD_THIS_ALLOCATION: this = (type *)operator new(sizeof(type)), where symbol is
   the this parameter; uses the class's own operator new when it has one
   (FIND_MEMBER_REPORT), else the global NEW_OPERATOR_SYMBOL. */
unsigned int far pascal BUILD_THIS_ALLOCATION(unsigned int symbol,register unsigned int type)
{
    unsigned int tree;
    unsigned int size;
    unsigned int member;
    unsigned int node;

    size=MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(type));
    member=FIND_MEMBER_REPORT(OPERATOR_NEW_NAME,type);
    if(member==0)
        tree=MAKE_CALL_NODE(MAKE_SYMBOL_NODE(NEW_OPERATOR_SYMBOL),size,0,0,0,0);
    else {
        node=MAKE_SYMBOL_NODE(MEMBER_W(member,MEMB_VALUE));
        EXPR_W(node,EXPR_SCOPE_CLASS)=type;
        tree=MAKE_CALL_NODE(node,size,0,0,0,0);   /* BC cross-jumps the shared call tail; the
                                                   then-branch ends push ax; jmp 0852 */
    }
    tree=MAKE_CAST_NODE(MAKE_POINTER_TYPE(type,0,0),tree);
    return MAKE_BINARY_NODE(0x0B,BUILD_THIS_NODE(symbol),tree);
}

/* ---- BUILD_THIS_ALLOC_IF_NULL (listing 0892) ---- */
/* row BUILD_THIS_ALLOC_IF_NULL (offset 0x892): stub 0BE2:007A = BUILD_THIS_ALLOC_IF_NULL */
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);

/* BUILD_THIS_ALLOC_IF_NULL: the start of a constructor: this ? 0 : (this = new ...),
   so a constructor called with a null this (from a new expression) allocates its own
   object. The allocation stores to CTOR_THIS_SYMBOL; the test reads symbol. */
unsigned int far pascal BUILD_THIS_ALLOC_IF_NULL(unsigned int symbol,unsigned int type)
{
    unsigned int name;
    register unsigned int node;

    node=BUILD_THIS_ALLOCATION(CTOR_THIS_SYMBOL,type);
    name=BUILD_THIS_NODE(symbol);
    node=MAKE_CONDITIONAL_NODE(0x6B,name,MAKE_INT_CONSTANT(INT_TYPE,0L),node);
    return node;
}

/* ---- BUILD_VBASE_DTORS (listing 08D6) ---- */
unsigned int far pascal COLLECT_VBASES(unsigned int type);
/* row X00F_23 (offset 0x8D6): stub 0BE2:006B = BUILD_VBASE_DTORS */

/* BUILD_VBASE_DTORS: comma list of destructor calls for every virtual base of type
   that has a destructor, the object being the one this-parameter symbol points to. */
unsigned int far pascal BUILD_VBASE_DTORS(unsigned int type,unsigned int symbol)
{
    unsigned int result;
    unsigned int tree;
    register unsigned int param;
    register unsigned int list;

    result=0;
    list=param=COLLECT_VBASES(type);
    while(param) {
        if(TYPE_B(BASE_W(param,BASE_TYPE),TYPE_ATTRS)&8) {
            tree=BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(symbol),BASE_W(param,BASE_OFFSET),BASE_W(param,BASE_TYPE));
            result=JOIN_COMMA_EXPR(BUILD_DESTRUCTOR_CALL(tree,BASE_W(param,BASE_TYPE),0,0),result);
        }
        param=BASE_W(param,BASE_NEXT);
    }
    FREE_PARAM_LIST(list);
    return result;
}

/* ---- BUILD_DESTRUCTOR_BODY (listing 095A) ---- */
/* row X00F_0E (offset 0x95A): stub 0BE2:0034 = BUILD_DESTRUCTOR_BODY */
extern unsigned int far pascal FIND_MEMBER_QUIET(unsigned int,unsigned int);

/* BUILD_DESTRUCTOR_BODY: the code a destructor runs after its user body: destroy
   members and non-virtual bases, then, if (flags & 2), the virtual bases, then, if
   (flags & 1), free the object with operator delete (the class's own one, preferring
   the overload that also takes a size_t, or DELETE_OPERATOR_SYMBOL). tree is the
   symbol of the hidden flags parameter, symbol the this parameter. When flag is set
   the whole thing is guarded by this != 0. */
unsigned int far pascal BUILD_DESTRUCTOR_BODY(unsigned int type,unsigned int symbol,
    unsigned char flag,unsigned int tree)
{
    unsigned int member;
    unsigned int list;
    unsigned int node2;
    unsigned int init;
    unsigned int call;
    register unsigned int owner;
    register unsigned int node;

    list=BUILD_SUBOBJECT_DTORS(MAKE_SYMBOL_NODE(symbol),type);
    node=BUILD_VBASE_DTORS(type,symbol);
    if(node) {
        node2=MAKE_BINARY_NODE(0x1B,MAKE_SYMBOL_NODE(tree),MAKE_INT_CONSTANT(INT_TYPE,2L));
        node=MAKE_CONDITIONAL_NODE(0x6B,node2,node,MAKE_INT_CONSTANT(INT_TYPE,0L));
        list=JOIN_COMMA_EXPR(list,node);
    }
    member=FIND_MEMBER_QUIET(OPERATOR_DELETE_NAME,type);
    if(member==0)
        init=MAKE_CALL_NODE(MAKE_SYMBOL_NODE(DELETE_OPERATOR_SYMBOL),BUILD_THIS_NODE(symbol),0,0,0,0);
    else {
        owner=MEMBER_W(member,MEMB_VALUE);
        if(SYM_W(owner,SYM_NEXT_OVERLOAD) && FORMAL_W(TYPE_W(SYM_W(owner,SYM_TYPE),TYPE_PARAMS),FORMAL_NEXT)==0)
            owner=SYM_W(owner,SYM_NEXT_OVERLOAD);
        node=MAKE_SYMBOL_NODE(owner);
        EXPR_W(node,EXPR_SCOPE_CLASS)=type;
        init=MAKE_CALL_NODE(node,BUILD_THIS_NODE(symbol),
            FORMAL_W(TYPE_W(SYM_W(owner,SYM_TYPE),TYPE_PARAMS),FORMAL_NEXT) ? MAKE_INT_CONSTANT(SIZE_T_TYPE,TYPE_SIZE(type)) : 0,
            0,0,0);
    }
    node2=MAKE_BINARY_NODE(0x1B,MAKE_SYMBOL_NODE(tree),MAKE_INT_CONSTANT(INT_TYPE,1L));
    call=MAKE_CONDITIONAL_NODE(0x6B,node2,init,MAKE_INT_CONSTANT(INT_TYPE,0L));
    list=JOIN_COMMA_EXPR(list,call);
    node2=flag ? BUILD_THIS_NODE(symbol) : MAKE_INT_CONSTANT(INT_TYPE,1L);
    return MAKE_CONDITIONAL_NODE(0x6B,node2,list,MAKE_INT_CONSTANT(INT_TYPE,0L));
}

/* ---- BUILD_THIS_NODE (listing 0B33) ---- */
/* row BUILD_THIS_NODE (offset 0xB33): stub 0BE2:00BB = BUILD_THIS_NODE */
extern unsigned int far pascal ADD_CV_QUALIFIERS(unsigned int,unsigned char,unsigned char);

/* BUILD_THIS_NODE: a symbol node for the this parameter symbol, typed as a pointer to
   the class (const-qualified when the this type has attribute bit 1), with node flag
   1 set. */
unsigned int far pascal BUILD_THIS_NODE(register unsigned int symbol)
{
    register unsigned int node;

    node=MAKE_SYMBOL_NODE(symbol);
    EXPR_W(node,EXPR_TYPE)=MAKE_POINTER_TYPE(TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_TARGET),TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND),0);
    if(TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_ATTRS)&1)
        EXPR_W(node,EXPR_TYPE)=ADD_CV_QUALIFIERS(EXPR_W(node,EXPR_TYPE),0,1);
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    return node;
}

/* ---- BCC_MEMBER_LOOKUP (listing 0BB1) ---- */
/* row X00F_0C (offset 0xBB1): stub 0BE2:0020 = BCC_MEMBER_LOOKUP */

/* BCC_MEMBER_LOOKUP: finds the hidden virtual table pointer member of a class that
   has virtual functions (TAG_VTABLE_SIZE > 0) or dynamically dispatched functions
   (class flag 0x800), searching the class
   and then down its first base class until found. Its name is VTABLE_PTR_NAME, which is
   TOKEN_NAMES[0x73] (see the overview). Returns 0 for a class without a
   vtable. Used by MAKE_MEMBER_POINTER, CPPCALL.C (virtual calls), CPPFINAL.C and the
   debug records. */
unsigned int far pascal BCC_MEMBER_LOOKUP(register unsigned int type)
{
    unsigned int member;

    member=0;
    if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_VTABLE_SIZE)>0 || (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x800)) {
        while(!member) {
            member=FIND_MEMBER_BY_NAME(VTABLE_PTR_NAME,type);
            if(!member)
                type=BASE_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES),BASE_TYPE);
        }
    }
    return member;
}

/* ---- COPY_MEMBER_RECORD (listing 0C18) ---- */
/* row X00F_20 (offset 0xC18): stub 0BE2:0075 = COPY_MEMBER_RECORD */
struct C0FMember { unsigned int words[6]; };   /* a 12-byte member record, copied whole */
extern unsigned int far pascal C9_ALLOC_MEMBER(unsigned int);
#define M(n) ((struct C0FMember far *)MK_FP(MEMBER_SEGMENT,(n)))

/* COPY_MEMBER_RECORD: copies the 12-byte member record source into a new record,
   linked before next, with access bits 2-4 of MEMB_FLAGS replaced by kind and
   MEMB_VALUE replaced by type. */
unsigned int far pascal COPY_MEMBER_RECORD(unsigned int source,unsigned int type,
    unsigned int next,unsigned int kind)
{
    register unsigned int member;

    member=C9_ALLOC_MEMBER(0);
    *M(member)=*M(source);
    MEMBER_W(member,MEMB_NEXT)=next;
    MEMBER_B(member,MEMB_FLAGS)=(MEMBER_B(member,MEMB_FLAGS)&0xE3)|((kind&7)<<2);   /* kind: bits 2-4 */
    MEMBER_W(member,MEMB_VALUE)=type;
    return member;
}
#undef M

/* ---- BUILD_SPECIAL_MEMBER_CALL (listing 0C68) ---- */
/* row X00F_19 (offset 0xC68): stub 0BE2:0098 = BUILD_SPECIAL_MEMBER_CALL */
extern unsigned int far pascal MAKE_MEMBER_NAME_NODE(unsigned int,unsigned int);

/* BUILD_SPECIAL_MEMBER_CALL: tree.NAME(value) where NAME is TOKEN_NAMES[op]: op 5
   builds a constructor call, 6 a destructor call, others an ordinary member function.
   value is the argument list (list nodes), stored straight into the call node. */
unsigned int far pascal BUILD_SPECIAL_MEMBER_CALL(register unsigned int op,unsigned int tree,unsigned int value)
{
    unsigned int name;
    unsigned int node;

    name=MAKE_BINARY_NODE(0x2F,tree,
        MAKE_MEMBER_NAME_NODE(TOKEN_NAMES[op],op==5 ? 3 : op==6 ? 4 : 1));
    node=MAKE_CALL_NODE(name,0,0,0,0,0);
    EXPR_W(node,EXPR_RIGHT)=value;
    return node;
}

/* ---- BUILD_CONSTRUCTOR_CALL (listing 0CCD) ---- */
/* row X00F_1E (offset 0xCCD): stub 0BE2:005C = BUILD_CONSTRUCTOR_CALL */

/* BUILD_CONSTRUCTOR_CALL: tree.type(value) for a complete object: for a class with
   virtual bases the hidden first argument 0 is added (build the virtual bases). */
unsigned int far pascal BUILD_CONSTRUCTOR_CALL(unsigned int tree,unsigned int type,unsigned int value)
{
    if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)
        value=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,0L),value);
    return BUILD_SPECIAL_MEMBER_CALL(5,tree,value);
}

/* ---- BUILD_BASE_CONSTRUCTOR_CALL (listing 0D16) ---- */
/* row X00F_10 (offset 0xD16): stub 0BE2:00AC = BUILD_BASE_CONSTRUCTOR_CALL */

/* BUILD_BASE_CONSTRUCTOR_CALL: like BUILD_CONSTRUCTOR_CALL for a base subobject: the
   hidden argument is 1 (do not build virtual bases) and the constructor name is
   qualified by type, so the base class's constructor is chosen. */
unsigned int far pascal BUILD_BASE_CONSTRUCTOR_CALL(unsigned int tree,register unsigned int type,unsigned int value)
{
    unsigned int node;

    if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)
        value=MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE,1L),value);
    node=BUILD_SPECIAL_MEMBER_CALL(5,tree,value);
    EXPR_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_RIGHT),EXPR_RIGHT)=type;
    return node;
}

/* ---- BUILD_INIT_CALL (listing 0D7A) ---- */
/* row X00F_14 (offset 0xD7A): stub 0BE2:00C0 = BUILD_INIT_CALL */
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_AT(unsigned int,long,long,unsigned int,unsigned int);

/* BUILD_INIT_CALL: initializes tree of type from the argument list node. Calls a
   constructor when force is set or the class has constructors (TYPE_ATTRS bit 4; flag
   selects the base-subobject form). Otherwise the object is initialized by plain
   assignment from the first argument; more than one argument, or none, is an error
   (MSG_EXTERN_VARIABLE_CANNOT, whatever its name says) and the extra arguments are
   freed. */
unsigned int far pascal BUILD_INIT_CALL(unsigned int tree,unsigned int type,
    unsigned int node,unsigned char force,unsigned char flag)
{
    unsigned int result;
    register unsigned int next;

    if(force || ((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && (TYPE_B(type,TYPE_ATTRS)&4))) {
        if(flag)
            result=BUILD_BASE_CONSTRUCTOR_CALL(tree,type,node);
        else
            result=BUILD_CONSTRUCTOR_CALL(tree,type,node);
    } else if(!node)
        result=REPORT_EXPR_ERROR_PLAIN(MSG_EXTERN_VARIABLE_CANNOT,tree);
    else {
        result=MAKE_BINARY_NODE(5,tree,EXPR_W(node,EXPR_RIGHT));
        next=EXPR_W(node,EXPR_LEFT);
        FREE_EXPR_NODE(node);
        if(next)
            REPORT_DIAGNOSTIC_AT(MSG_EXTERN_VARIABLE_CANNOT,0L,0L,EXPR_W(EXPR_W(next,EXPR_RIGHT),EXPR_SRC_LINE),0);
        while(next) {
            FREE_EXPR_TREE(EXPR_W(next,EXPR_RIGHT));
            node=next;
            next=EXPR_W(next,EXPR_LEFT);
            FREE_EXPR_NODE(node);
        }
    }
    return result;
}

/* ---- COUNT_BASE_PATHS (listing 0E53) ---- */
/* row COUNT_BASE_PATHS (offset 0xE53): stub none (static) = COUNT_BASE_PATHS */

/* COUNT_BASE_PATHS: counts how many times target occurs as a base class of type,
   searching the whole base graph. A shared virtual base is counted once: when a
   path already found and the new one are both virtual, the count is not raised.
   *ambiguous is set when the last path found goes through a virtual base (callers
   use it as "reached through a virtual base"). */
static void near pascal COUNT_BASE_PATHS(register unsigned int target,unsigned int type,
    unsigned char far *ambiguous,unsigned int far *count)
{
    unsigned int found;
    unsigned char virt;
    register unsigned int param;

    param=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);
    *count=0;
    *ambiguous=0;
    while(param) {
        if(TYPE_W(BASE_W(param,BASE_TYPE),TYPE_TAG_BODY)==TYPE_W(target,TYPE_TAG_BODY)) {
            found=1;
            virt=BASE_B(param,BASE_VIRTUAL);
        } else {
            COUNT_BASE_PATHS(target,BASE_W(param,BASE_TYPE),&virt,&found);
            if(found>0)
                virt=virt!=0 || BASE_B(param,BASE_VIRTUAL)!=0;
        }
        if(*count!=1 || found!=1 || *ambiguous==0 || virt==0) {
            *count+=found;
            if(found>0)
                *ambiguous=virt;
        }
        param=BASE_W(param,BASE_NEXT);
    }
}

/* ---- IS_BASE_CLASS (listing 0F2D) ---- */
/* row X00F_13 (offset 0xF2D): stub 0BE2:00A2 = IS_BASE_CLASS */
extern unsigned int far pascal ACCESS_MODE_VIA_BASES_FAR(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_FRIEND(unsigned int);

/* IS_BASE_CLASS: 1 if the first class is the same as the second or a base class of
   it (both must be class types). Beware the parameter names: COUNT_BASE_PATHS(derived,
   base) counts derived among the bases of base, so "derived" is really the base class
   and "base" the derived one, and callers use it that way (ACCESS.C).
   With strict, the base must also be unique and accessible: access 0 (public) through
   the derivation, or the current code is a friend of the first class; or else, when
   the current class is one of the two or a friend of the second, any access except 3
   (inaccessible). */
unsigned char far pascal IS_BASE_CLASS(register unsigned int derived,register unsigned int base,
    unsigned char strict)
{
    unsigned int count;
    unsigned char virt;
    unsigned int access;

    if(!(EXPR_FLAGS[TYPE_W(base,TYPE_KIND)]&0x40) || !(EXPR_FLAGS[TYPE_W(derived,TYPE_KIND)]&0x40))
        return 0;
    if(TYPE_W(base,TYPE_TAG_BODY)==TYPE_W(derived,TYPE_TAG_BODY))
        return 1;
    COUNT_BASE_PATHS(derived,base,&virt,&count);
    if(strict) {
        if(count!=1)
            return 0;
        access=ACCESS_MODE_VIA_BASES_FAR(0,0,derived,base);
        if(IS_FRIEND(TAG_W(TYPE_W(derived,TYPE_TAG_BODY),TAG_SYMBOL)) || access==0)
            return 1;
        if(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY)==TYPE_W(base,TYPE_TAG_BODY) || TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY)==TYPE_W(derived,TYPE_TAG_BODY) ||
           IS_FRIEND(TAG_W(TYPE_W(base,TYPE_TAG_BODY),TAG_SYMBOL)))
            return access!=3;
        return 0;
    }
    return count>0;
}

/* ---- IS_UNIQUE_NONVIRTUAL_BASE (listing 1013) ---- */
/* row COPY_MEMBER_RECORD (offset 0x1013): stub 0BE2:00A7 = IS_UNIQUE_NONVIRTUAL_BASE */

/* IS_UNIQUE_NONVIRTUAL_BASE: 1 if left is right or occurs exactly once among the
   bases of right, not through a virtual base. IS_UNIQUE_BASE below allows a virtual
   path. */
unsigned char far pascal IS_UNIQUE_NONVIRTUAL_BASE(unsigned int left,unsigned int right)
{
    unsigned int count;
    unsigned char ambiguous;

    if(!(EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x40) || !(EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x40))
        return 0;
    if(TYPE_W(right,TYPE_TAG_BODY)==TYPE_W(left,TYPE_TAG_BODY))
        return 1;
    COUNT_BASE_PATHS(left,right,&ambiguous,&count);
    return count==1 && !ambiguous;
}

/* ---- IS_UNIQUE_BASE (listing 1084) ---- */
/* row X00F_28 (offset 0x1084): stub 0BE2:0066 = IS_UNIQUE_BASE */

unsigned char far pascal IS_UNIQUE_BASE(unsigned int left,unsigned int right)
{
    unsigned int count;
    unsigned char ambiguous;

    if(!(EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x40) || !(EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x40))
        return 0;
    if(TYPE_W(right,TYPE_TAG_BODY)==TYPE_W(left,TYPE_TAG_BODY))
        return 1;
    COUNT_BASE_PATHS(left,right,&ambiguous,&count);
    return count==1;
}

/* ---- FIND_DEFAULT_CTOR (listing 10EC) ---- */
/* row FIND_DEFAULT_CTOR (offset 0x10EC): stub 0BE2:009D = FIND_DEFAULT_CTOR */

/* FIND_DEFAULT_CTOR: the constructor of type callable with no arguments: one with no
   parameters after this (and after the hidden virtual-base flag), or, unless any is
   set, one whose first parameter has a default. CTOR_NAME is the
   constructor name TOKEN_NAMES[5] (see the overview). Returns the function symbol
   or 0. */
unsigned int far pascal FIND_DEFAULT_CTOR(unsigned int type,unsigned char any)
{
    unsigned int member;
    register unsigned int symbol;
    unsigned int node;

    member=FIND_MEMBER_BY_NAME(CTOR_NAME,type);
    if(!member)
        return 0;
    node=MEMBER_W(member,MEMB_VALUE);
    while(node) {
        symbol=TYPE_W(SYM_W(node,SYM_TYPE),TYPE_PARAMS);
        if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)
            symbol=FORMAL_W(symbol,FORMAL_NEXT);
        if(FORMAL_W(symbol,FORMAL_NEXT)==0 || (FORMAL_W(FORMAL_W(symbol,FORMAL_NEXT),FORMAL_DEFAULT_ARG) && !any))
            return node;
        node=SYM_W(node,SYM_NEXT_OVERLOAD);
    }
    return 0;
}

/* ---- FIND_COPY_MEMBER (listing 1178) ---- */
/* row FIND_COPY_MEMBER (offset 0x1178): stub none (static) = FIND_COPY_MEMBER */
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);

/* FIND_COPY_MEMBER: finds the copy constructor (kind 5) or copy assignment (kind 0x0B)
   of type: an overload whose first real parameter is compatible with a reference to
   type and that has no other parameter (or, unless any is set, only defaulted ones).
   Returns the function symbol or 0. */
static unsigned int far pascal FIND_COPY_MEMBER(unsigned int kind,unsigned int type,
    unsigned char any)
{
    unsigned int member;
    unsigned int pointer;
    register unsigned int symbol;
    unsigned int node;

    pointer=MAKE_POINTER_TYPE(type,0,1);
    member=FIND_MEMBER_BY_NAME(TOKEN_NAMES[kind],type);
    if(!member)
        return 0;
    for(node=MEMBER_W(member,MEMB_VALUE); node; node=SYM_W(node,SYM_NEXT_OVERLOAD)) {
        symbol=TYPE_W(SYM_W(node,SYM_TYPE),TYPE_PARAMS);
        if(kind==5 && (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4))
            symbol=FORMAL_W(symbol,FORMAL_NEXT);
        symbol=FORMAL_W(symbol,FORMAL_NEXT);
        if(!symbol)
            continue;
        if(!TYPES_COMPATIBLE(FORMAL_W(symbol,FORMAL_TYPE),pointer,2))
            continue;
        symbol=FORMAL_W(symbol,FORMAL_NEXT);
        if(!symbol || (FORMAL_W(symbol,FORMAL_DEFAULT_ARG) && !any))
            return node;
    }
    return 0;
}

/* ---- FIND_COPY_CTOR (listing 1245) ---- */
/* row X00F_22 (offset 0x1245): stub 0BE2:003E = FIND_COPY_CTOR */

unsigned int far pascal FIND_COPY_CTOR(unsigned int type,unsigned char any)
{
    return FIND_COPY_MEMBER(5,type,any);
}

/* ---- FIND_COPY_ASSIGN (listing 125B) ---- */
/* row X00F_21 (offset 0x125B): stub 0BE2:0070 = FIND_COPY_ASSIGN */

unsigned int far pascal FIND_COPY_ASSIGN(unsigned int type,unsigned char any)
{
    return FIND_COPY_MEMBER(0xb,type,any);
}

/* ---- COPY_PARAM_QUALIFIERS (listing 1271) ---- */
/* row COPY_PARAM_QUALIFIERS (offset 0x1271): stub 0BE2:002A = COPY_PARAM_QUALIFIERS */

/* COPY_PARAM_QUALIFIERS: the cv attribute byte of what the copy constructor or copy
   assignment (kind) of type, or of its array element type, takes its argument by:
   tells whether it takes a const or volatile reference. Assumes the member exists. */
unsigned int far pascal COPY_PARAM_QUALIFIERS(unsigned int kind,unsigned int type)
{
    unsigned char indirect;
    register unsigned int symbol;

    indirect=0;
    while(TYPE_W(type,TYPE_KIND)==TK_ARRAY) {
        indirect=1;
        type=TYPE_W(type,TYPE_TARGET);
    }
    symbol=TYPE_W(SYM_W(FIND_COPY_MEMBER(kind,type,indirect),SYM_TYPE),TYPE_PARAMS);
    symbol=FORMAL_W(symbol,FORMAL_NEXT);
    if(kind==5 && (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4))
        symbol=FORMAL_W(symbol,FORMAL_NEXT);
    return TYPE_B(TYPE_W(FORMAL_W(symbol,FORMAL_TYPE),TYPE_TARGET),TYPE_ATTRS);
}

/* ---- CREATE_PARAM_RECORD (listing 12FB) ---- */
/* row CREATE_PARAM_RECORD (offset 0x12FB): stub 0BE2:00CF = CREATE_PARAM_RECORD */
extern unsigned int far pascal ALLOC_FORMAL_RECORD(void);

/* CREATE_PARAM_RECORD: a new FORMAL record named TOKEN_NAMES[kind] for a hidden
   parameter of class type. With flags 0 its type is the class's this-pointer type
   (TAG_THIS_TYPE); otherwise a pointer to type with cv qualifiers from flags (1
   const, 2 volatile), built like the this type. */
unsigned int far pascal CREATE_PARAM_RECORD(unsigned int type,unsigned int flags,unsigned int kind)
{
    register unsigned int symbol;

    symbol=ALLOC_FORMAL_RECORD();
    FORMAL_W(symbol,FORMAL_NEXT)=0;
    if(flags) {
        unsigned int pointer;

        pointer=ADD_CV_QUALIFIERS(type,(flags&2)!=0,flags&1);
        pointer=MAKE_POINTER_TYPE(pointer,TYPE_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_THIS_TYPE),TYPE_KIND),1);
        TYPE_B(pointer,TYPE_ATTRS)|=TYPE_B(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_THIS_TYPE),TYPE_ATTRS)&3;
        FORMAL_W(symbol,FORMAL_TYPE)=pointer;
    } else
        FORMAL_W(symbol,FORMAL_TYPE)=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_THIS_TYPE);
    FORMAL_W(symbol,FORMAL_NAME)=TOKEN_NAMES[kind];
    FORMAL_B(symbol,FORMAL_IS_REGISTER)=0;
    FORMAL_W(symbol,FORMAL_DEFAULT_ARG)=0;
    return symbol;
}

/* ---- ADD_THIS_PARAMETER (listing 13CA) ---- */
/* row X00F_2A (offset 0x13CA): stub 0BE2:008E = ADD_THIS_PARAMETER */

/* ADD_THIS_PARAMETER: puts the implicit this parameter (name TOKEN_NAMES[0x72]) in
   front of the parameter list of the member function type, qualified like the
   function (TYPE_ATTRS bits 1-2), and records value as its member class. */
void far pascal ADD_THIS_PARAMETER(unsigned int value,register unsigned int type)
{
    unsigned int symbol;

    symbol=CREATE_PARAM_RECORD(value,TYPE_B(type,TYPE_ATTRS)&3,0x72);
    FORMAL_W(symbol,FORMAL_NEXT)=TYPE_W(type,TYPE_PARAMS);
    FORMAL_B(symbol,FORMAL_IMPLICIT)=1;
    TYPE_W(type,TYPE_PARAMS)=symbol;
    TYPE_W(type,TYPE_MEMBER_CLASS)=value;
}

/* ---- BCC_TYPE_PRED (listing 1416) ---- */
/* row ADD_HIDDEN_PARAMETER (offset 0x1416): stub 0BE2:0089 = BCC_TYPE_PRED */

/* BCC_TYPE_PRED: 1 if left (arrays decayed to pointers) and right are compatible
   types, also when one of them is a reference to a type compatible with the other. */
unsigned char far pascal BCC_TYPE_PRED(unsigned int left,unsigned int right)
{
    unsigned char same;

    if(TYPE_W(left,TYPE_KIND)==TK_ARRAY)
        left=MAKE_POINTER_TYPE(TYPE_W(left,TYPE_TARGET),0,0);
    if(!(same=TYPES_COMPATIBLE(left,right,0))) {
        if((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && (TYPE_B(left,TYPE_ATTRS)&0x20))
            same=TYPES_COMPATIBLE(TYPE_W(left,TYPE_TARGET),right,0);
        if(!same && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) && (TYPE_B(right,TYPE_ATTRS)&0x20))
            same=TYPES_COMPATIBLE(left,TYPE_W(right,TYPE_TARGET),0);
    }
    return same;
}

/* ---- SAME_SIGNATURE (listing 14AF) ---- */
/* row X00F_1C (offset 0x14AF): stub 0BE2:0048 = SAME_SIGNATURE */

/* SAME_SIGNATURE: 1 if two member function types take the same parameters after
   this, with the same ellipsis flag and the same const/volatile of this. A function
   without a prototype (flag 8) matches anything. Used to see if a function overrides
   a virtual one. */
unsigned char far pascal SAME_SIGNATURE(unsigned int left,unsigned int right)
{
    unsigned int left_type;
    unsigned int right_type;
    unsigned char same;
    register unsigned int left_symbol;
    register unsigned int right_symbol;

    same=0;
    if((TYPE_B(left,TYPE_FUNC_FLAGS)|TYPE_B(right,TYPE_FUNC_FLAGS))&8)
        same=1;
    else if((TYPE_B(left,TYPE_FUNC_FLAGS)&4)==(TYPE_B(right,TYPE_FUNC_FLAGS)&4) && (TYPE_B(left,TYPE_ATTRS)&3)==(TYPE_B(right,TYPE_ATTRS)&3)) {
        left_symbol=FORMAL_W(TYPE_W(left,TYPE_PARAMS),FORMAL_NEXT);
        right_symbol=FORMAL_W(TYPE_W(right,TYPE_PARAMS),FORMAL_NEXT);
        same=1;
        while(left_symbol && right_symbol && same) {
            left_type=FORMAL_W(left_symbol,FORMAL_TYPE);
            right_type=FORMAL_W(right_symbol,FORMAL_TYPE);
            same=TYPES_COMPATIBLE(left_type,right_type,0);
            left_symbol=FORMAL_W(left_symbol,FORMAL_NEXT);
            right_symbol=FORMAL_W(right_symbol,FORMAL_NEXT);
        }
        same=same && left_symbol==right_symbol;
    }
    return same;
}

/* ---- MERGE_VBASE_LIST (listing 1599) ---- */
/* row MERGE_VBASE_LIST (offset 0x1599): stub none (static) = MERGE_VBASE_LIST */

/* MERGE_VBASE_LIST: appends the BASE records of list to head, dropping (freeing) the
   ones whose class is already there. Each one added is placed right after the
   previous last entry: its offset is that entry's offset plus its TAG_OWN_SIZE, so the
   offsets are relative to the end of the derived class's own part. */
static unsigned int far pascal MERGE_VBASE_LIST(unsigned int head,unsigned int list)
{
    unsigned int next;
    unsigned int cur;

    while(list) {
        next=BASE_W(list,BASE_NEXT);
        if(!head) {
            head=list;
            BASE_W(list,BASE_NEXT)=0;
            BASE_W(list,BASE_OFFSET)=0;
        } else {
            cur=head;
            while(BASE_W(cur,BASE_NEXT) && TYPE_W(BASE_W(cur,BASE_TYPE),TYPE_TAG_BODY)!=TYPE_W(BASE_W(list,BASE_TYPE),TYPE_TAG_BODY))
                cur=BASE_W(cur,BASE_NEXT);
            if(TYPE_W(BASE_W(cur,BASE_TYPE),TYPE_TAG_BODY)==TYPE_W(BASE_W(list,BASE_TYPE),TYPE_TAG_BODY))
                POOL_FREE_ITEM(&BASE_LIST_SEG,list);
            else {
                BASE_W(list,BASE_NEXT)=0;
                BASE_W(list,BASE_OFFSET)=BASE_W(cur,BASE_OFFSET)+TAG_W(TYPE_W(BASE_W(cur,BASE_TYPE),TYPE_TAG_BODY),TAG_OWN_SIZE);
                BASE_W(cur,BASE_NEXT)=list;
            }
        }
        list=next;
    }
    return head;
}

/* ---- COLLECT_VBASES_REC (listing 166B) ---- */
/* row COLLECT_VBASES_REC (offset 0x166B): stub none (static) = COLLECT_VBASES_REC */
#define PITEM(n) (*(struct ParameterItem far *)MK_FP(BASE_LIST_SEG,(n)))

/* COLLECT_VBASES_REC: the virtual bases of type, deepest first, each once (copies of
   the BASE records, merged with MERGE_VBASE_LIST). */
static unsigned int far pascal COLLECT_VBASES_REC(unsigned int type)
{
    unsigned int list;
    register unsigned int param;
    register unsigned int copy;

    list=0;
    if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4) {
        for(param=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);param;param=BASE_W(param,BASE_NEXT)) {
            list=MERGE_VBASE_LIST(list,COLLECT_VBASES_REC(BASE_W(param,BASE_TYPE)));
            if(BASE_B(param,BASE_VIRTUAL)) {
                copy=POOL_ALLOC_REUSE(&BASE_LIST_SEG,9);
                PITEM(copy)=PITEM(param);
                BASE_W(copy,BASE_NEXT)=0;
                list=MERGE_VBASE_LIST(list,copy);
            }
        }
    }
    return list;
}
#undef PITEM

/* ---- COLLECT_VBASES (listing 1711) ---- */
/* row SAME_SIGNATURE (offset 0x1711): stub 0BE2:00CA = COLLECT_VBASES */

/* COLLECT_VBASES: the list of all virtual bases of type with their offsets in a
   complete object of type: they are laid out after its own part (TAG_OWN_SIZE). The
   caller frees the list with FREE_PARAM_LIST. */
unsigned int far pascal COLLECT_VBASES(unsigned int type)
{
    unsigned int list;
    register unsigned int param;

    list=COLLECT_VBASES_REC(type);
    for(param=list;param;param=BASE_W(param,BASE_NEXT))
        BASE_W(param,BASE_OFFSET)=BASE_W(param,BASE_OFFSET)+TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_OWN_SIZE);
    return list;
}

/* ---- FIND_INIT_BY_MEMBER (listing 175A) ---- */
/* row FIND_INIT_BY_MEMBER (offset 0x175A): stub none (static) = FIND_INIT_BY_MEMBER */

/* FIND_INIT_BY_MEMBER / FIND_INIT_BY_BASE: the entry of the mem-initializer list node
   whose MINIT_TARGET is key (a member record, or a base class type), or 0. */
static unsigned int near pascal FIND_INIT_BY_MEMBER(unsigned int key,unsigned int node)
{
    while(node) {
        if(MINIT_W(node,MINIT_TARGET)==key)
            return node;
        node=MINIT_W(node,MINIT_NEXT);
    }
    return 0;
}

/* ---- BUILD_MEMBER_INITS (listing 1788) ---- */
/* row X00F_09 (offset 0x1788): stub 0BE2:00C5 = BUILD_MEMBER_INITS */
extern unsigned int far pascal INIT_VECTOR_ELEMENTS(unsigned int,unsigned int);
extern long far pascal FORMAT_SPECIAL_MEMBER(unsigned int,unsigned int,unsigned int);
extern char far * far pascal MEMBER_NAME_TEXT(unsigned int);

/* BUILD_MEMBER_INITS: the member part of a constructor of CURRENT_CLASS_TYPE, in
   declaration order: each data member with an entry in the mem-initializer list keys
   uses that expression; a member of class type with constructors is default
   constructed (arrays element by element through INIT_VECTOR_ELEMENTS), or
   MSG_CANNOT_FIND_INITIALIZE_224 when it has no default constructor. Reference and
   const members without an initializer are reported. */
unsigned int far pascal BUILD_MEMBER_INITS(unsigned int keys)
{
    unsigned int expr;
    unsigned int found;
    register unsigned int member;
    register unsigned int result;

    result=0;
    for(member=TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_MEMBERS);member;member=MEMBER_W(member,MEMB_NEXT)) {
        if(MEMBER_B(member,MEMB_FLAGS)&3)
            continue;
        found=FIND_INIT_BY_MEMBER(member,keys);
        if(found)
            result=JOIN_COMMA_EXPR(result,MINIT_W(found,MINIT_EXPR));
        else if(TYPE_B(MEMBER_W(member,MEMB_TYPE),TYPE_ATTRS)&4) {
            if(TYPE_W(MEMBER_W(member,MEMB_TYPE),TYPE_KIND)==TK_ARRAY) {
                expr=MAKE_BINARY_NODE(0x2f,MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL),MAKE_FIELD_REF_NODE(member));
                result=JOIN_COMMA_EXPR(result,INIT_VECTOR_ELEMENTS(expr,MEMBER_W(member,MEMB_TYPE)));
            } else if(FIND_DEFAULT_CTOR(MEMBER_W(member,MEMB_TYPE),0)) {
                expr=MAKE_BINARY_NODE(0x2f,MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL),MAKE_FIELD_REF_NODE(member));
                result=JOIN_COMMA_EXPR(result,BUILD_CONSTRUCTOR_CALL(expr,MEMBER_W(member,MEMB_TYPE),0));
            } else
                REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE_224,(char far *)FORMAT_SPECIAL_MEMBER(5,0,MEMBER_W(member,MEMB_TYPE)),(long)MEMBER_NAME_TEXT(member));
        } else if((EXPR_FLAGS[TYPE_W(MEMBER_W(member,MEMB_TYPE),TYPE_KIND)]&0x14) && (TYPE_B(MEMBER_W(member,MEMB_TYPE),TYPE_ATTRS)&0x20))
            REPORT_NAME_DIAGNOSTIC(MSG_REFERENCE_MEMBER_NOT,MEMBER_W(member,MEMB_NAME));
        else if(TYPE_B(MEMBER_W(member,MEMB_TYPE),TYPE_ATTRS)&1)
            REPORT_NAME_DIAGNOSTIC(MSG_CONSTANT_MEMBER_NOT,MEMBER_W(member,MEMB_NAME));
    }
    return result;
}

/* ---- ALLOC_INIT_ENTRY (listing 191E) ---- */
/* row ALLOC_INIT_ENTRY (offset 0x191E): stub 0BE2:0039 = ALLOC_INIT_ENTRY */

/* ALLOC_INIT_ENTRY: a new zeroed MINIT record whose MINIT_NEXT is key (the parameter
   is the list to link in front of, despite its name). */
unsigned int far pascal ALLOC_INIT_ENTRY(unsigned int key)
{
    register unsigned int node;

    node=POOL_ALLOC_REUSE(&INIT_RECORD_POOL_SEG,6);
    RTL_MEMSET(MK_FP(INIT_RECORD_POOL_SEG,node),0,6);
    MINIT_W(node,MINIT_NEXT)=key;
    return node;
}

/* ---- FREE_INIT_LIST (listing 1954) ---- */
/* row FREE_INIT_LIST (offset 0x1954): stub none (static) = FREE_INIT_LIST */

/* FREE_INIT_LIST: frees a whole MINIT list. */
static void near pascal FREE_INIT_LIST(unsigned int list)
{
    unsigned int node;

    while(list) {
        node=list;
        list=MINIT_W(list,MINIT_NEXT);
        POOL_FREE_ITEM(&INIT_RECORD_POOL_SEG,node);
    }
}

/* ---- FIND_INIT_BY_BASE (listing 1983) ---- */
/* row FIND_INIT_BY_BASE (offset 0x1983): stub none (static) = FIND_INIT_BY_BASE */

static unsigned int near pascal FIND_INIT_BY_BASE(unsigned int key,unsigned int node)
{
    while(node) {
        if(MINIT_W(node,MINIT_TARGET)==key)
            return node;
        node=MINIT_W(node,MINIT_NEXT);
    }
    return 0;
}

/* ---- BUILD_BASE_INITS (listing 19B1) ---- */
/* row X00F_0F (offset 0x19B1): stub 0BE2:002F = BUILD_BASE_INITS */
extern unsigned char far pascal SYMBOL_ACCESSIBLE(unsigned int,unsigned int);
extern char far * far pascal FORMAT_SYMBOL(unsigned int);

/* Compiled without line records (-y-): the original merges the second
   result=JOIN_COMMA_EXPR(result,expr) into the first (1AB1 jmp 0x1A03), a
   mid-statement merge of the call tail.  Built with -y, BC keeps both copies,
   as the sibling BUILD_VBASE_INITS does in the original. */
#pragma option -y-
/* BUILD_BASE_INITS: the non-virtual base part of a constructor of
   CURRENT_CLASS_TYPE: each base uses its mem-initializer from keys, or its default
   constructor (access-checked, message 0xB6 probably "not accessible"), or is an
   error when it has constructors but no default one. With adjust set (the class's
   constructors may assign to this, class flag 2) and the base constructor flagged 0x10
   in SYM_FUNC_FLAGS (it assigns to this), the base constructor's result is stored back
   into this. Frees keys. */
unsigned int far pascal BUILD_BASE_INITS(unsigned char adjust,unsigned int keys)
{
    unsigned int expr;
    unsigned int symbol;
    unsigned int found;
    register unsigned int param;
    register unsigned int result;

    result=0;
    for(param=TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_BASES);param;param=BASE_W(param,BASE_NEXT)) {
        if(BASE_B(param,BASE_VIRTUAL))
            continue;
        found=FIND_INIT_BY_BASE(BASE_W(param,BASE_TYPE),keys);
        if(found)
            result=JOIN_COMMA_EXPR(result,MINIT_W(found,MINIT_EXPR));
        else {
            symbol=FIND_DEFAULT_CTOR(BASE_W(param,BASE_TYPE),0);
            if(symbol) {
                if(!SYMBOL_ACCESSIBLE(symbol,CURRENT_CLASS_TYPE))
                    REPORT_DIAGNOSTIC(0xb6,FORMAT_SYMBOL(symbol),0L);
                else {
                    expr=BUILD_BASE_CONSTRUCTOR_CALL(MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL),BASE_W(param,BASE_TYPE),0);
                    if(adjust && (SYM_W(symbol,SYM_FUNC_FLAGS)&0x10)) {
                        expr=MAKE_CAST_NODE(MAKE_POINTER_TYPE(CURRENT_CLASS_TYPE,0,0),expr);
                        expr=MAKE_BINARY_NODE(0xb,BUILD_THIS_NODE(CTOR_THIS_SYMBOL),expr);
                    }
                    result=JOIN_COMMA_EXPR(result,expr);
                }
            } else if(TYPE_B(BASE_W(param,BASE_TYPE),TYPE_ATTRS)&4)
                REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE,(char far *)FORMAT_SPECIAL_MEMBER(5,0,BASE_W(param,BASE_TYPE)),0L);
        }
    }
    FREE_INIT_LIST(keys);
    return result;
}
#pragma option -y

/* ---- BUILD_VBASE_POINTER_INITS (listing 1B0A) ---- */
/* row BUILD_VBASE_POINTER_INITS (offset 0x1B0A): stub none (static) = BUILD_VBASE_POINTER_INITS */

/* BUILD_VBASE_POINTER_INITS: stores of the virtual base pointer for the virtual base
   target in every subobject of type that derives virtually from it. context is the
   this symbol, list the COLLECT_VBASES list (where each virtual base lies), offset the
   position of type's subobject. Each store is
   *(T **)((char *)this + offset + pointer offset) = &virtual base subobject. */
static unsigned int far pascal BUILD_VBASE_POINTER_INITS(unsigned int type,unsigned int context,
    unsigned int list,unsigned int offset,unsigned int target)
{
    unsigned int result;
    unsigned int sub;
    unsigned int left;
    unsigned int right;
    unsigned int cur;
    unsigned int base;
    register unsigned int param;

    result=0;
    for(param=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);param;param=BASE_W(param,BASE_NEXT)) {
        if(BASE_B(param,BASE_VIRTUAL) && TYPE_W(BASE_W(param,BASE_TYPE),TYPE_TAG_BODY)==TYPE_W(BASE_W(target,BASE_TYPE),TYPE_TAG_BODY)) {
            left=BUILD_VBASE_ADDRESS(MAKE_SYMBOL_NODE(context),offset+BASE_W(param,BASE_OFFSET),BASE_W(param,BASE_TYPE));
            right=BUILD_BASE_ADDRESS(MAKE_SYMBOL_NODE(context),BASE_W(target,BASE_OFFSET),BASE_W(target,BASE_TYPE));
            result=JOIN_COMMA_EXPR(result,MAKE_BINARY_NODE(5,left,MAKE_UNARY_NODE(0x1d,right)));
        }
        if(BASE_B(param,BASE_VIRTUAL)) {
            for(cur=list;;cur=BASE_W(cur,BASE_NEXT))
                if(TYPE_W(BASE_W(cur,BASE_TYPE),TYPE_TAG_BODY)==TYPE_W(BASE_W(param,BASE_TYPE),TYPE_TAG_BODY)) {
                    base=BASE_W(cur,BASE_OFFSET);
                    break;
                }
        } else
            base=offset+BASE_W(param,BASE_OFFSET);
        sub=BUILD_VBASE_POINTER_INITS(BASE_W(param,BASE_TYPE),context,list,base,target);
        result=JOIN_COMMA_EXPR(result,sub);
    }
    return result;
}

/* ---- BUILD_VBASE_INITS (listing 1C5A) ---- */
/* row X00F_29 (offset 0x1C5A): stub 0BE2:0043 = BUILD_VBASE_INITS */

/* BUILD_VBASE_INITS: the virtual base part of a constructor: constructs each virtual
   base (from keys or by default constructor, like BUILD_BASE_INITS) and sets the
   virtual base pointers to it. The whole part is guarded by the hidden flag parameter
   context: context ? 0 : (...), so only the constructor of the complete object does it.
   Frees keys. */
unsigned int far pascal BUILD_VBASE_INITS(unsigned int context,unsigned int keys)
{
    unsigned int expr;
    unsigned int list;
    unsigned int symbol;
    unsigned int found;
    register unsigned int param;
    register unsigned int result;

    result=0;
    for(list=param=COLLECT_VBASES(CURRENT_CLASS_TYPE);param;param=BASE_W(param,BASE_NEXT)) {
        found=FIND_INIT_BY_BASE(BASE_W(param,BASE_TYPE),keys);
        if(found)
            result=JOIN_COMMA_EXPR(result,MINIT_W(found,MINIT_EXPR));
        else {
            symbol=FIND_DEFAULT_CTOR(BASE_W(param,BASE_TYPE),0);
            if(symbol) {
                if(!SYMBOL_ACCESSIBLE(symbol,CURRENT_CLASS_TYPE))
                    REPORT_DIAGNOSTIC(0xb6,FORMAT_SYMBOL(symbol),0L);
                else {
                    expr=MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
                    expr=BUILD_BASE_CONSTRUCTOR_CALL(expr,BASE_W(param,BASE_TYPE),0);
                    result=JOIN_COMMA_EXPR(result,expr);
                }
            } else if(TYPE_B(BASE_W(param,BASE_TYPE),TYPE_ATTRS)&4)
                REPORT_DIAGNOSTIC(MSG_CANNOT_FIND_INITIALIZE,(char far *)FORMAT_SPECIAL_MEMBER(5,0,BASE_W(param,BASE_TYPE)),0L);
        }
        result=JOIN_COMMA_EXPR(BUILD_VBASE_POINTER_INITS(CURRENT_CLASS_TYPE,CTOR_THIS_SYMBOL,list,0,param),result);
    }
    if(result)
        result=MAKE_CONDITIONAL_NODE(0x20,MAKE_SYMBOL_NODE(context),MAKE_INT_CONSTANT(INT_TYPE,0L),result);
    FREE_PARAM_LIST(list);
    FREE_INIT_LIST(keys);
    return result;
}

/* ---- BUILD_VPTR_INITS_REC (listing 1DA9) ---- */
/* row BUILD_VPTR_INITS_REC (offset 0x1DA9): stub none (static) = BUILD_VPTR_INITS_REC */

/* BUILD_VPTR_INITS_REC: stores of the virtual table pointer of type's subobject at
   offset in context, and recursively of its non-virtual bases. Each class with a
   vtable gets vptr = &vtable_symbol[*size]; *size then moves past its entries, so
   the classes share one table symbol (scope) laid out in walk order. nested (the
   base's BASE_USED flag, set by LIST_FINISH in CLASSDEF.C) skips a base whose vptr is
   shared with its derived class. A class with flag 0x800 has dynamically dispatched (DDVT) functions, and
   its table starts with a header that the vptr skips: per dynamic function
   (TAG_DDVT_COUNT of them) a far pointer and a short id, then a short count and a pointer
   the size of the vptr member (C13SPECIAL in CPPFINAL.C writes it). */
static unsigned int far pascal BUILD_VPTR_INITS_REC(unsigned int type,unsigned int context,
    unsigned int offset,unsigned int scope,int far *size,unsigned char nested)
{
    unsigned int result;
    unsigned int expr;
    int base;
    unsigned int member;
    register unsigned int param;

    result=0;
    if((TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_VTABLE_SIZE)>0 || (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x800)) && !nested) {
        base=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_VTABLE_SIZE);
        member=BCC_MEMBER_LOOKUP(type);
        if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x800)
            /* 16-bit arithmetic on the low words of TYPE_SIZE's long results
               (imul, add).  Not written with +=: the original adds *size last,
               through AX (1E6A add ax,es:[bx]); += gives add es:[bx],ax. */
            *size=((int)TYPE_SIZE(FAR_VOID_PTR_TYPE)+(int)TYPE_SIZE(SHORT_TYPE))*TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_DDVT_COUNT)+
                ((int)TYPE_SIZE(SHORT_TYPE)+(int)TYPE_SIZE(MEMBER_W(member,MEMB_TYPE)))+*size;
        result=BUILD_BASE_ADDRESS(COPY_EXPR_TREE(context),offset,type);
        result=MAKE_BINARY_NODE(0x2f,result,MAKE_FIELD_REF_NODE(member));
        expr=MAKE_UNARY_NODE(0x1d,MAKE_BINARY_NODE(3,MAKE_SYMBOL_NODE(scope),
            MAKE_INT_CONSTANT(INT_TYPE,(long)*size)));
        result=MAKE_BINARY_NODE(0xb,result,expr);
        *size+=base;
    }
    for(param=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);param;param=BASE_W(param,BASE_NEXT)) {
        if(!BASE_B(param,BASE_VIRTUAL)) {
            expr=BUILD_VPTR_INITS_REC(BASE_W(param,BASE_TYPE),context,BASE_W(param,BASE_OFFSET)+offset,scope,size,
                BASE_B(param,BASE_USED));
            result=JOIN_COMMA_EXPR(result,expr);
        }
    }
    return result;
}

/* ---- BUILD_VPTR_INITS (listing 1F51) ---- */
/* row X00F_05 (offset 0x1F51): stub 0BE2:00ED = BUILD_VPTR_INITS */
extern unsigned int far pascal CONVERT_DERIVED_TO_BASE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned char,unsigned char);

/* BUILD_VPTR_INITS: all virtual table pointer stores for a constructor of type whose
   this symbol is context: the class and its non-virtual bases, then each virtual base
   (reached with CONVERT_DERIVED_TO_BASE), all into the class's TAG_VTABLE_SYMBOL. */
unsigned int far pascal BUILD_VPTR_INITS(unsigned int context,unsigned int type)
{
    unsigned int result;
    unsigned int expr;
    unsigned int mark;
    unsigned int sum;
    unsigned int scope;
    int size;
    register unsigned int param;
    register unsigned int old;

    scope=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_VTABLE_SYMBOL);
    size=0;
    mark=MAKE_SYMBOL_NODE(context);
    result=BUILD_VPTR_INITS_REC(type,mark,0,scope,&size,0);
    if(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4) {
        param=COLLECT_VBASES(type);
        sum=0;
        FREE_EXPR_NODE(mark);
        mark=BUILD_THIS_NODE(context);
        while(param) {
            expr=CONVERT_DERIVED_TO_BASE(COPY_EXPR_TREE(mark),type,0,BASE_W(param,BASE_TYPE),1,0);
            expr=BUILD_VPTR_INITS_REC(BASE_W(param,BASE_TYPE),expr,0,scope,&size,0);
            sum=JOIN_COMMA_EXPR(sum,expr);
            old=param;
            param=BASE_W(param,BASE_NEXT);
            POOL_FREE_ITEM(&BASE_LIST_SEG,old);
        }
        result=JOIN_COMMA_EXPR(result,sum);
    }
    FREE_EXPR_NODE(mark);
    return result;
}

/* ---- ADD_UNIQUE_PARAM (listing 2062) ---- */
/* row X00F_01 (offset 0x2062): stub 0BE2:00D9 = ADD_UNIQUE_PARAM */

#define PITEM(n) (*(struct ParameterItem far *)MK_FP(BASE_LIST_SEG,(n)))

/* ADD_UNIQUE_PARAM: adds a copy of item to the BASE list *list unless a base of the
   same class is already in it; *found says which happened. Used by CLASSDEF.C for the
   base-specifier list (duplicate base check). */
void far pascal ADD_UNIQUE_PARAM(unsigned int far *list,struct ParameterItem item,
    unsigned char far *found)
{
    register unsigned int param;

    param=*list;
    BASE_W(0,BASE_TYPE)=item.type;     /* sentinel in record 0 ends the search */
    while(TYPE_W(BASE_W(param,BASE_TYPE),TYPE_TAG_BODY)!=TYPE_W(item.type,TYPE_TAG_BODY))
        param=BASE_W(param,BASE_NEXT);
    if(param)
        *found=1;
    else {
        param=POOL_ALLOC_REUSE(&BASE_LIST_SEG,9);
        PITEM(param)=item;
        BASE_W(param,BASE_NEXT)=*list;
        *list=param;
        *found=0;
    }
}
#undef PITEM

/* ---- FREE_PARAM_ITEM (listing 20E9) ---- */
/* row X00F_00 (offset 0x20E9): stub 0BE2:00DE = FREE_PARAM_ITEM */

/* FREE_PARAM_ITEM: frees one BASE record. */
void far pascal FREE_PARAM_ITEM(unsigned int param)
{
    POOL_FREE_ITEM(&BASE_LIST_SEG,param);
}

/* ---- ADD_HIDDEN_PARAMETER (listing 20FD) ---- */
/* row X00F_02 (offset 0x20FD): stub 0BE2:00D4 = ADD_HIDDEN_PARAMETER */

/* ADD_HIDDEN_PARAMETER: puts a compiler-added int parameter named TOKEN_NAMES[kind]
   in front of the parameter list of function type type: kind 0x73 (named like
   'virtual') for the virtual-base flag of constructors, 0x69 (named like 'delete')
   for the flags of destructors. */
void far pascal ADD_HIDDEN_PARAMETER(unsigned int type,unsigned int kind)
{
    register unsigned int symbol;

    symbol=ALLOC_FORMAL_RECORD();
    FORMAL_W(symbol,FORMAL_TYPE)=INT_TYPE;
    FORMAL_W(symbol,FORMAL_NAME)=TOKEN_NAMES[kind];
    FORMAL_B(symbol,FORMAL_IS_REGISTER)=0;
    FORMAL_W(symbol,FORMAL_DEFAULT_ARG)=0;
    FORMAL_W(symbol,FORMAL_NEXT)=TYPE_W(type,TYPE_PARAMS);
    FORMAL_B(symbol,FORMAL_IMPLICIT)=1;
    TYPE_W(type,TYPE_PARAMS)=symbol;
}

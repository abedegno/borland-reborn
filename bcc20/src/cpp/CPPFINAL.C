/* target: ovr069_C13UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ classes: end-of-file processing: static initializer and destructor functions,
   virtual tables (with this-adjust thunks), pending inline and deferred definitions. Entry
   points: FLUSH_PENDING_INITIALIZERS, PROCESS_DEFERRED_DECLS. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: what the C++ compiler still has to emit when the source file has been
   read. PROCESS_DEFERRED_DECLS is the driver, run once at the end of the file (only
   while code generation is on). It
   - compiles the functions queued on PENDING_DEFINITION_LIST (QUEUE_DEFERRED_SYMBOL):
     out-of-line copies of inline functions and the bodies of compiler-declared special
     members (C13DECLARATIONS, C13INITIALIZE);
   - builds the static constructor function _STCON_ from the initializations queued on
     FILE_INIT_EXPR_QUEUE (C13PENDING) and the static destructor function _STDES_ from
     TEMP_DESTRUCTOR_LIST (C13VALUES), registered in the start-up and exit tables;
   - emits the virtual tables of the classes on VTABLE_CLASS_LIST (C13CLASSES), and
     repeats until no new function was queued (emitting a table can queue functions);
   - writes the initial data of temporaries left on PENDING_INIT_LIST
     (FLUSH_PENDING_INITIALIZERS, also called from elsewhere).
   Virtual tables: one table symbol per class (TAG_VTABLE_SYMBOL) holds the parts for
   the class and for each base subobject that needs its own pointer, in the order
   BUILD_VPTR_INITS in CPPCTOR.C assumes. For each part C13INHERITED collects the
   virtual functions by slot (sorted 6-byte records key/symbol/offset in
   C13_ORDER_BANK, made by C13SLOT), C13OVERRIDE and C13PATH find the final overrider
   of each slot along the derivation path, and C13EMIT writes the entries: the
   function's address, NEAR/FAR_PURE_ERROR_SYMBOL for a pure virtual function
   (SYM_FUNC_FLAGS 0x20), or a this-adjusting thunk (C13BIND, emitted by C13BINDINGS)
   when the overrider lives at another offset. Path records (BASE_PATH_POOL_SEG, 8
   bytes: 0 parent, 2 child, 4 class type, 6 offset) form the chain from the complete
   class down to the subobject being filled. A class with dynamically dispatched
   (DDVT) functions (class flag 0x800, function flag 0x100) gets a header first
   (C13SPECIAL).
   VTABLE_MODE is tested here like a virtual table mode, not a CPU: 1 (CPU_LEVEL_1_FLAG)
   emits no tables, 2 (CPU_IS_286) emits every table, 3 puts tables, thunks and inline
   copies in segments of their own named after the mangled name; probably the -V
   option (external, public, smart virtual tables).
   Raw offsets through local macros: SW(n,0) SYM_OWNER_CLASS, SW(n,2) SYM_NAME,
   SW(n,4) SYM_TYPE, SB(n,6) SYM_FLAGS (1 defined, 4 used, 0x10 member, 0x80 far),
   SB(n,7) SYM_STORAGE_CLASS, SW(n,10) SYM_FUNC_FLAGS, SB(n,12) SYM_INLINE_ACCESS,
   SW(n,15) SYM_FUNC_KIND, SW(n,19) SYM_NEXT_OVERLOAD, SW(n,21) SYM_VIRTUAL_INDEX;
   TW(n,5) TYPE_TAG_BODY, TW(n,7) TYPE_TARGET; LW(n,2) TAG_MEMBERS, LW(n,12) TAG_BASES,
   LW(n,16) TAG_VTABLE_SIZE, LW(n,18) TAG_VTABLE_SYMBOL, LW(n,24) TAG_CLASS_FLAGS,
   LW(n,26) TAG_DDVT_COUNT (number of DDVT functions); MW(n,0) MEMB_NEXT, MB(n,4)
   MEMB_FLAGS, MW(n,6) MEMB_VALUE, MW(n,8) MEMB_TYPE; PW/PB(n,0/2/4/7/8) BASE_NEXT,
   BASE_TYPE, BASE_OFFSET, BASE_VIRTUAL, BASE_USED; QW(n,10)/QW(n,12) the link and tree
   words of a packed-expression record; DW CONS cells; FW(n,0/2/4) the
   PENDING_INIT_LIST record (next, symbol, packed tree). */
#include <dos.h>
#include "CPPFINAL.H"
#include "POOL.H"

#define TW(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define SW(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) AT_B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define LW(n,o) AT_W(TAG_BODY_POOL_SEG,(unsigned int)(n)+(o))
#define MW(n,o) AT_W(MEMBER_SEGMENT,(unsigned int)(n)+(o))
#define MB(n,o) AT_B(MEMBER_SEGMENT,(unsigned int)(n)+(o))
#define PW(n,o) AT_W(BASE_LIST_SEG,(unsigned int)(n)+(o))
#define PB(n,o) AT_B(BASE_LIST_SEG,(unsigned int)(n)+(o))
#define CW(n,o) AT_W(BASE_PATH_POOL_SEG,(unsigned int)(n)+(o))
#define QW(n,o) AT_W(PACKED_EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define DW(n,o) AT_W(CONS_CELL_POOL_SEG,(unsigned int)(n)+(o))
#define FW(n,o) AT_W(INIT_RECORD_POOL_SEG,(unsigned int)(n)+(o))
#define XW(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define SLOT(base,i) (*(struct C13Slot far *)MK_FP(C13_ORDER_BANK.segment,\
    (unsigned int)(base)+(int)(i)*(int)sizeof(struct C13Slot)))
#define BW(n,o) AT_W(C13_BIND_BANK.segment,(unsigned int)(n)+(o))

/* 0000: construct a transient symbol from the actual FAR name. */
/* C13NEW: declares a static function void name(void) (one of the start-up and exit
   functions), marks it defined and used, opens its body with no source position and
   returns its prepared storage record. */
static unsigned int near pascal C13NEW(char far *name)
{
    register unsigned int symbol;
    symbol=DECLARE_GLOBAL_SYMBOL(name,VOID_NOARG_FUNC_TYPE,0,0);
    SB(symbol,7)=(SB(symbol,7)&7)|0x18;
    SB(symbol,6)|=5;
    SW(symbol,10)|=8;
    CURRENT_TOKEN_FILE=0;
    CURRENT_TOKEN_LINE=0;
    CURRENT_SOURCE_FILE=0;
    FUNCTION_DEF_LINE=0;
    FUNC_START_CLEARED_WORD=0;
    FUNCTION_DEF_POSITION=0;
    BEGIN_FUNCTION_BODY(symbol,VOID_NOARG_FUNC_TYPE);
    return PREPARE_SYMBOL(symbol);
}

/* 006F: reverse link10, then emit each saved expression. */
/* C13PENDING: builds _STCON_, the function that runs the file's static
   initializations, from the packed-expression list head (newest first, so it is
   reversed into source order first). Registered as a start-up entry with priority
   0x20. Nothing is made when the list is empty. */
static void near pascal C13PENDING(unsigned int head)
{
    register unsigned int reversed;
    register unsigned int node;
    reversed=0;
    while(head) {
        node=head;
        head=QW(node,10);
        QW(node,10)=reversed;
        reversed=node;
    }
    STARTUP_BODY_ACTIVE=1;
    if(reversed) {
        CODE_SEGMENT_ID=DEFAULT_CODE_SEGMENT_ID;
        ADD_STARTUP_ENTRY(C13NEW(STR__STCON_),0x20);
        while(reversed) {
            APPEND_ANALYZED_EXPRESSION(UNPACK_EXPR_TREE(QW(reversed,12)));
            reversed=QW(reversed,10);
        }
        END_FUNCTION_BODY();
        STARTUP_BODY_ACTIVE=0;
    }
}

/* 00E6: same producer, with the separate link0/value4 node arena. */
/* C13VALUES: builds _STDES_, the exit function that destroys the file's static
   objects, from the TDTOR list node (newest first, so destruction runs in reverse
   order of construction). */
static void near pascal C13VALUES(register unsigned int node)
{
    if(node) {
        CODE_SEGMENT_ID=DEFAULT_CODE_SEGMENT_ID;
        STARTUP_BODY_ACTIVE=1;
        ADD_EXIT_ENTRY(C13NEW(STR__STDES_),0x20);
        while(node) {
            APPEND_ANALYZED_EXPRESSION(UNPACK_EXPR_TREE(AT_W(TEMP_ENTRY_POOL_SEG,node+4)));
            node=AT_W(TEMP_ENTRY_POOL_SEG,node);
        }
        END_FUNCTION_BODY();
        STARTUP_BODY_ACTIVE=0;
    }
}

/* 013F */
/* C13INITIALIZE: compiles the body of a special member that the compiler declared for
   a class (default or copy constructor, assignment, destructor; see IMPLMEMB.C): the
   expression comes from BUILD_SPECIAL_MEMBER_BODY. A function returning a value gets a
   return statement (node built with token 0x5F): a constructor returns this, an
   assignment returns *this (the dereferenced expression). Warnings are suppressed. */
static void near pascal C13INITIALIZE(register unsigned int symbol)
{
    unsigned int result_type;
    unsigned char member;
    register unsigned int expression;
    ++SUPPRESS_WARNINGS_DEPTH;
    member=SW(symbol,15)==3;
    CURRENT_SOURCE_FILE=0;
    FUNCTION_DEF_LINE=0;
    FUNC_START_CLEARED_WORD=0;
    FUNCTION_DEF_POSITION=0;
    if(SB(symbol,6)&0x10)
        CURRENT_CLASS_TYPE=SW(SW(symbol,0),4);
    BEGIN_FUNCTION_BODY(symbol,SW(symbol,4));
    CTOR_THIS_SYMBOL=LOOKUP_NAME(THIS_NAME);
    result_type=TW(CURRENT_FUNCTION_TYPE,7);
    expression=BUILD_SPECIAL_MEMBER_BODY(symbol);
    if(result_type==VOID_TYPE)
        APPEND_ANALYZED_EXPRESSION(expression);
    else {
        if(member)
            expression=JOIN_COMMA_EXPR(expression,BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
        else
            expression=MAKE_UNARY_NODE(0x18,expression);
        expression=MAKE_BINARY_NODE(0x5F,0,expression);
        XW(expression,8)=result_type;
        expression=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression,VOID_TYPE),0);
        APPEND_RETURN_JUMP_BLOCK(expression,NO_SOURCE_LOCATION);
    }
    END_FUNCTION_BODY();
    CURRENT_CLASS_TYPE=0;
    --SUPPRESS_WARNINGS_DEPTH;
}

/* 0251: declaration initialization followed by the reverse-loop
   initialization models the two actual producer operations at0257/025B. */
/* C13DECLARATIONS: empties PENDING_DEFINITION_LIST in the order the functions were
   queued, compiling each: a recorded inline body (inline kind 1) with
   COMPILE_INLINE_BODY, otherwise a special member with C13INITIALIZE. The first
   assignment of reversed is overwritten at once; both stores are kept as in the
   original (see the note above). */
static void near pascal C13DECLARATIONS(void)
{
    register unsigned int reversed=PENDING_DEFINITION_LIST;
    register unsigned int node;
    for(reversed=0;PENDING_DEFINITION_LIST;) {
        node=PENDING_DEFINITION_LIST;
        PENDING_DEFINITION_LIST=DW(PENDING_DEFINITION_LIST,0);
        DW(node,0)=reversed;
        reversed=node;
    }
    ++SUPPRESS_WARNINGS_DEPTH;
    while(reversed) {
        if(NO_ERRORS_YET) {
            if((SB(DW(reversed,2),12)&3)==1)
                COMPILE_INLINE_BODY(DW(reversed,2),1);
            else
                C13INITIALIZE(DW(reversed,2));
        }
        node=reversed;
        reversed=DW(reversed,0);
        LIST_CELL_FREE(node);
    }
    --SUPPRESS_WARNINGS_DEPTH;
}

/* 02DD: actual public BYTE flag occupies one Pascal WORD argument. */
/* FLUSH_PENDING_INITIALIZERS: writes the initial data of each temporary on
   PENDING_INIT_LIST (queued by MAKE_INITIALIZED_TEMP and LOWEREXP.C) into its
   symbol's segment and removes it from the list. With partial set only symbols of
   storage class 4 are done (probably those whose storage is ready now); the others
   stay queued. */
void far pascal FLUSH_PENDING_INITIALIZERS(unsigned char partial)
{
    unsigned int expression;
    unsigned int saved;
    register unsigned int node=PENDING_INIT_LIST;
    register unsigned int previous=0;
    for(previous=0,node=PENDING_INIT_LIST;node;node=FW(node,0)) {
        if(partial && (SB(FW(node,2),7)>>3)!=4) {
            previous=node;
            continue;
        }
        saved=SELECT_SYMBOL_STREAM(FW(node,2));
        for(expression=FW(node,4);expression;expression=QW(expression,10))
            EMIT_CONST_INIT_VALUE(UNPACK_EXPR_TREE(QW(expression,12)));
        SET_STREAM(saved);
        if(!previous)
            PENDING_INIT_LIST=FW(node,0);
        else
            FW(previous,0)=FW(node,0);
    }
}

/* 0397: allocate the genuine six-byte binding record. */
/* C13BIND: makes the thunk symbol for a virtual table entry that must adjust this by
   offset before jumping to function symbol: a temporary symbol (far when the function
   is far), recorded with offset and function in a 6-byte entry of C13_BIND_BANK for
   C13BINDINGS. The function is queued (QUEUE_DEFERRED_SYMBOL) since its address is
   now needed. */
static unsigned int near pascal C13BIND(unsigned int offset,unsigned int symbol)
{
    unsigned int prepared;
    register unsigned int entry;
    register unsigned int binding;
    binding=CREATE_TEMP_SYMBOL(INT_TYPE,1);
    prepared=PREPARE_SYMBOL(binding);
    SET_SYMBOL_SEGMENT_HOOK(prepared,0xFFFF);
    if(TB(SW(symbol,4),12)&1) {
        SB(binding,6)|=0x80;
        CLEAR_PREPARED_FLAGS(prepared,4);
        SET_PREPARED_FLAGS(prepared,0x10);
    }
    entry=POOL_ALLOC(&C13_BIND_BANK.segment,6);
    BW(entry,0)=offset;
    BW(entry,2)=symbol;
    QUEUE_DEFERRED_SYMBOL(symbol);
    BW(entry,4)=binding;
    return binding;
}

/* 0434: table base is the actual zero offset within ORDER_BANK.segment. */
/* C13EMIT: writes the count+1 entries of the slot table (C13_ORDER_BANK from offset
   0) as constant data into the current stream; *size gets the bytes written. */
static void near pascal C13EMIT(int count,unsigned int far *size)
{
    unsigned int expression;
    unsigned int base;
    unsigned int symbol;
    register int index;
    base=0;
    *size=0;
    for(index=0;index<=count;++index) {
        symbol=SLOT(base,index).symbol;
        if(SW(symbol,10)&0x20)
            symbol=(TB(SW(symbol,4),12)&1)?FAR_PURE_ERROR_SYMBOL:NEAR_PURE_ERROR_SYMBOL;
        else if(SLOT(base,index).offset)
            symbol=C13BIND(SLOT(base,index).offset,symbol);
        expression=BUILD_SYMBOL_EXPR(symbol);
        *size+=(unsigned int)TYPE_SIZE(XW(expression,8));
        EMIT_CONST_INIT_VALUE(expression);
    }
}

/* 04EE: insertion in sorted six-byte records. Native record copy is the
   compiler's genuine FAR structure-assignment runtime at0:0402. */
/* C13SLOT: finds or inserts the slot record with virtual index key in the sorted table
   (binary search over *count+1 records, *count being the last index); a new record is
   cleared and *count grows. Returns the record's offset. */
static unsigned int near pascal C13SLOT(unsigned int key,int far *count)
{
    unsigned int base;
    int high;
    int low;
    int middle;
    register unsigned int position;
    register unsigned int end;
    base=0;
    high=*count;
    low=0;
    middle=0;
    while(low<=high) {
        middle=(low+high)/2;
        position=base+middle*6;
        if(SLOT(position,0).key==key)
            return position;
        if(SLOT(position,0).key>key)
            high=middle-1;
        else
            low=middle+1;
    }
    position=base+high*6+6;
    ++*count;
    end=POOL_ALLOC(&C13_ORDER_BANK.segment,6);
    while(end>position) {
        SLOT(end,0)=SLOT(end,-1);
        end-=6;
    }
    SLOT(position,0).key=key;
    SLOT(position,0).symbol=0;
    SLOT(position,0).offset=0;
    return position;
}

/* 05C8 */
/* C13COLLECT: enters every virtual function of class type (not the DDVT ones) into
   its slot, unless the slot already has a function: classes are visited most derived
   first, so the overriding function wins. */
static void near pascal C13COLLECT(unsigned int type,int far *count)
{
    unsigned int slot;
    unsigned int symbol;
    register unsigned int member=LW(TW(type,5),2);
    for(member=LW(TW(type,5),2);member;member=MW(member,0)) {
        if((MB(member,4)&3)==3) {
            for(symbol=MW(member,6);symbol;symbol=SW(symbol,19)) {
                if(SW(symbol,21)>0 && !(SW(symbol,10)&0x100)) {
                    slot=C13SLOT(SW(symbol,21),count);
                    if(!AT_W(C13_ORDER_BANK.segment,slot+2)) {
                        AT_W(C13_ORDER_BANK.segment,slot+2)=symbol;
                        AT_W(C13_ORDER_BANK.segment,slot+4)=0;
                    }
                }
            }
        }
    }
}

/* 066B */
/* C13INHERITED: fills the slot table for class type and the chain of bases that
   share its table pointer (BASE_USED); *count is the last slot index, -1 when the class
   has no virtual table. */
static void near pascal C13INHERITED(register unsigned int type,int far *count)
{
    register unsigned int base;
    *count=-1;
    if(LW(TW(type,5),16)>0) {
        while(type) {
            C13COLLECT(type,count);
            base=LW(TW(type,5),12);
            type=0;
            while(base) {
                if(PB(base,8))
                    type=PW(base,2);
                base=PW(base,0);
            }
        }
    }
}

/* 06D4 */
/* C13OVERRIDE: path is the chain of classes from the complete object down to the
   subobject whose table is being filled, which lies at offset. For each slot it
   searches the classes from the top (most derived) down for a function with the same
   name and signature (SAME_SIGNATURE); the first found replaces the slot's function,
   and the slot's offset becomes the difference between that class's offset and the
   subobject's, the this adjustment a thunk must make. */
static void near pascal C13OVERRIDE(unsigned int path,unsigned int offset,int count)
{
    unsigned int table;
    unsigned int name;
    unsigned int type;
    unsigned int symbol;
    unsigned int member;
    register unsigned int node;
    register int index;
    table=0;
    if(path) {
        for(index=0;index<=count;++index) {
            name=SW(SLOT(table,index).symbol,2);
            type=SW(SLOT(table,index).symbol,4);
            node=path;
            while(CW(node,0))
                node=CW(node,0);
            while(node) {
                member=FIND_MEMBER_BY_NAME(name,CW(node,4));
                for(symbol=MW(member,6);symbol;symbol=SW(symbol,19)) {
                    if(SAME_SIGNATURE(SW(symbol,4),type)) {
                        SLOT(table,index).symbol=symbol;
                        SLOT(table,index).offset=CW(node,6)-offset;
                        break;
                    }
                }
                if(symbol)
                    break;
                node=CW(node,2);
            }
        }
    }
}

/* 07F3 */
/* C13BASE: the offset of virtual base type in the COLLECT_VBASES list path, or 0. */
static unsigned int near pascal C13BASE(register unsigned int path,
    register unsigned int type)
{
    while(path) {
        if(TW(PW(path,2),5)==TW(type,5))
            return PW(path,4);
        path=PW(path,0);
    }
    return 0;
}

/* 0835 */
/* C13PATH: for a virtual base target, walks every derivation path from class type
   (at offset) down to it, extending the path chain (parent, linked both ways while
   the walk is inside), and runs C13OVERRIDE for each path that reaches target, so
   overriders declared in any branch that derives from the shared virtual base are
   found. Virtual bases on the way are placed with C13BASE. */
static void near pascal C13PATH(unsigned int type,unsigned int offset,
    unsigned int target,unsigned int bases,unsigned int parent,int count)
{
    unsigned int displacement;
    register unsigned int base;
    register unsigned int path;
    path=POOL_ALLOC_REUSE(&BASE_PATH_POOL_SEG,8);
    CW(path,0)=parent;
    CW(path,2)=0;
    CW(path,6)=offset;
    CW(path,4)=type;
    if(parent)
        CW(parent,2)=path;
    base=LW(TW(type,5),12);
    while(base) {
        if(PB(base,7))
            displacement=C13BASE(bases,PW(base,2));
        else
            displacement=PW(base,4)+offset;
        if(TW(PW(base,2),5)==TW(target,5))
            C13OVERRIDE(path,displacement,count);
        else
            C13PATH(PW(base,2),displacement,target,bases,path,count);
        base=PW(base,0);
    }
    POOL_FREE_ITEM(&BASE_PATH_POOL_SEG,path);
    if(parent)
        CW(parent,2)=0;
}

/* 0921 */
/* C13WALK: emits the table parts of class type (at offset in the complete class root)
   and recursively of its non-virtual bases. A base that shares its derived class's
   table pointer (indirect, BASE_USED) emits nothing itself. bases is the virtual base
   list when the part belongs to a virtual base subobject (then C13PATH also looks in
   the other branches). *size adds up the bytes emitted. */
static void near pascal C13WALK(unsigned int type,unsigned int root,
    unsigned int bases,unsigned int offset,unsigned int parent,
    unsigned char indirect,unsigned int far *size)
{
    int count;
    unsigned int emitted;
    register unsigned int base;
    register unsigned int path;
    if(!indirect) {
        C13INHERITED(type,&count);
        C13OVERRIDE(parent,offset,count);
        if(bases)
            C13PATH(root,0,type,bases,0,count);
        C13EMIT(count,&emitted);
        *size+=emitted;
    }
    base=LW(TW(type,5),12);
    if(base) {
        path=POOL_ALLOC_REUSE(&BASE_PATH_POOL_SEG,8);
        CW(path,0)=parent;
        CW(path,2)=0;
        CW(path,6)=offset;
        CW(path,4)=type;
        if(parent)
            CW(parent,2)=path;
        while(base) {
            if(!PB(base,7))
                C13WALK(PW(base,2),root,bases,PW(base,4)+offset,path,PB(base,8),size);
            base=PW(base,0);
        }
        POOL_FREE_ITEM(&BASE_PATH_POOL_SEG,path);
        if(parent)
            CW(parent,2)=0;
    }
}

/* 0A2F */
/* C13VIRTUAL: emits the table parts of each virtual base of type, at its offset in
   the complete object. */
static void near pascal C13VIRTUAL(unsigned int type,unsigned int far *size)
{
    register unsigned int node;
    register unsigned int bases;
    bases=COLLECT_VBASES(type);
    node=bases;
    while(node) {
        C13WALK(PW(node,2),type,bases,PW(node,4),0,0,size);
        node=PW(node,0);
    }
    while(bases) {
        node=bases;
        bases=PW(bases,0);
        POOL_FREE_ITEM(&BASE_LIST_SEG,node);
    }
}

/* 0A8E */
/* C13LABEL: the code segment for the class's thunks: with VTABLE_MODE 3 a new
   segment named after the mangled table symbol plus STR_VSF (far thunks, special set)
   or STR_VSN (near), otherwise the current CODE_SEGMENT_ID. */
static unsigned int near pascal C13LABEL(register unsigned int type,
    unsigned char special)
{
    char far *name;
    register unsigned int segment;
    segment=DEFAULT_CODE_SEGMENT_ID;
    if(VTABLE_MODE!=3)
        return CODE_SEGMENT_ID;
    if(special)
        segment|=0x8000;
    name=MANGLE_SYMBOL_NAME(LW(TW(type,5),18));
    name=STRING_APPEND(name,special?STR_VSF:STR_VSN);
    return DEFINE_SEGMENT_FIXED_ID(OBJ_EXTERN_INDEX++ +0x4000,segment,2,
        BCC_INTERN_STRING(name));
}

/* 0B1A */
/* C13WIDTH: extra stack distance to this for a thunk of function type type: when
   the function returns a class through a hidden pointer (a class with constructors,
   or one whose size is not 1, 2 or 4), KIND_SIZE_TABLE[60] (probably the size of that
   hidden pointer), else 0. */
static int near pascal C13WIDTH(unsigned int type)
{
    register unsigned int result_type;
    register unsigned int width;
    result_type=TW(type,7);
    width=(unsigned int)TYPE_SIZE(result_type);
    if((EXPR_FLAGS[TW(result_type,0)]&0x40) &&
        ((TB(result_type,2)&4) || (width!=1 && width!=2 && width!=4)))
        return KIND_SIZE_TABLE[60];
    return 0;
}

/* 0B66 */
/* C13BINDINGS: emits each thunk recorded by C13BIND: puts the thunk symbol in a near
   or far thunk segment (C13LABEL, made on first use) and lets
   EMIT_THIS_ADJUST_THUNK_HOOK write code that adds the offset to this and jumps to the
   function. */
static void near pascal C13BINDINGS(unsigned int type)
{
    unsigned int end;
    unsigned int special_label;
    unsigned int label;
    unsigned int saved;
    unsigned int special;
    register unsigned int position;
    register unsigned int normal_label;
    normal_label=0;
    special_label=0;
    end=C13_BIND_BANK.used;
    for(position=0;position<end;position+=6) {
        special=(SB(BW(position,4),6)&0x80)!=0;
        if(special) {
            if(!special_label)
                special_label=C13LABEL(type,1);
            label=special_label;
        } else {
            if(!normal_label)
                normal_label=C13LABEL(type,0);
            label=normal_label;
        }
        SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(BW(position,4)),label);
        saved=SELECT_SYMBOL_STREAM(BW(position,4));
        EMIT_THIS_ADJUST_THUNK_HOOK(PREPARE_SYMBOL(BW(position,2)),BW(position,0),special,
            C13WIDTH(SW(BW(position,2),4)));
        SET_STREAM(saved);
    }
}

/* 0C3D: genuinely private FAR, called with PUSH CS/near CALL. No overlay
   stub or address-taking loader field exists for this entry. */
/* C13SPECIAL: the header in front of the table of a class with dynamically dispatched
   (DDVT) functions: the addresses of all its DDVT functions, their dispatch ids
   (SYM_VIRTUAL_INDEX) as shorts, their count (TAG_DDVT_COUNT), then a pointer into the
   first base's table symbol, just past that base's header, when that base also has
   DDVT functions, else 0. *size adds the header size. */
static void far pascal C13SPECIAL(register unsigned int type,
    unsigned int far *size)
{
    unsigned int symbol;
    unsigned int result_type;
    unsigned int expression;
    unsigned int displacement;
    register unsigned int member;
    result_type=MW(BCC_MEMBER_LOOKUP(type),8);
    for(member=LW(TW(type,5),2);member;member=MW(member,0)) {
        if((MB(member,4)&3)==3) {
            for(symbol=MW(member,6);symbol;symbol=SW(symbol,19))
                if(SW(symbol,10)&0x100)
                    EMIT_CONST_INIT_VALUE(BUILD_SYMBOL_EXPR(symbol));
        }
    }
    for(member=LW(TW(type,5),2);member;member=MW(member,0)) {
        if((MB(member,4)&3)==3) {
            for(symbol=MW(member,6);symbol;symbol=SW(symbol,19))
                if(SW(symbol,10)&0x100)
                    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(SHORT_TYPE,(long)SW(symbol,21)));
        }
    }
    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(SHORT_TYPE,(long)LW(TW(type,5),26)));
    *size+=(unsigned int)TYPE_SIZE(SHORT_TYPE)+(unsigned int)TYPE_SIZE(result_type)+
        ((unsigned int)TYPE_SIZE(FAR_VOID_PTR_TYPE)+(unsigned int)TYPE_SIZE(SHORT_TYPE))*
        LW(TW(type,5),26);
    type=LW(TW(type,5),12)==0?0:PW(LW(TW(type,5),12),2);
    if(!type || !(LW(TW(type,5),24)&0x800))
        EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(result_type,0L));
    else {
        displacement=(unsigned int)TYPE_SIZE(SHORT_TYPE)+(unsigned int)TYPE_SIZE(result_type)+
            ((unsigned int)TYPE_SIZE(FAR_VOID_PTR_TYPE)+(unsigned int)TYPE_SIZE(SHORT_TYPE))*
            LW(TW(type,5),26);
        expression=MAKE_BINARY_NODE(0x16,BUILD_SYMBOL_EXPR(LW(TW(type,5),18)),
            MAKE_INT_CONSTANT(INT_TYPE,(long)displacement));
        expression=MAKE_CAST_NODE(result_type,expression);
        EMIT_CONST_INIT_VALUE(SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(expression,0),0));
    }
}

/* 0E98 */
/* C13BUILD: emits the whole virtual table of class type: picks the table symbol's
   segment (its own named segment in mode 3, the code segment for a far table, flag
   0x80), selects that stream and writes the DDVT header, the parts of the class and
   its non-virtual bases, then those of the virtual bases, and finally the thunks.
   *size gets the table size. */
static void near pascal C13BUILD(register unsigned int type,
    unsigned int far *size)
{
    unsigned int saved;
    unsigned int prepared;
    unsigned int label;
    register unsigned int symbol;
    symbol=LW(TW(type,5),18);
    C13_ORDER_BANK.limit=0;
    C13_ORDER_BANK.used=0;
    C13_BIND_BANK.limit=0;
    C13_BIND_BANK.used=0;
    if(VTABLE_MODE==3) {
        prepared=PREPARE_SYMBOL(symbol);
        if(GET_SYMBOL_SEGMENT_HOOK(prepared)==-1) {
            label=DEFINE_SEGMENT_FIXED_ID(OBJ_EXTERN_INDEX+0x4000,
                (SB(symbol,6)&0x80)?DEFAULT_CODE_SEGMENT_ID:DATA_SEGMENT_ID,2,
                BCC_INTERN_STRING(MANGLE_SYMBOL_NAME(symbol)));
            SET_SYMBOL_SEGMENT_HOOK(prepared,label);
            SET_SYMBOL_OFFSET_HOOK(prepared,OBJ_EXTERN_INDEX++);
            SET_PREPARED_FLAGS(prepared,0x100);
        }
    } else if(SB(symbol,6)&0x80)
        SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(LW(TW(type,5),18)),CODE_SEGMENT_ID);
    saved=SELECT_SYMBOL_STREAM(LW(TW(type,5),18));
    *size=0;
    if(LW(TW(type,5),24)&0x800)
        C13SPECIAL(type,size);
    C13WALK(type,type,0,0,0,0,size);
    C13VIRTUAL(type,size);
    SET_STREAM(saved);
    C13BINDINGS(type);
}

/* 0FE1 */
/* C13CLASSES: emits the virtual table of each class on VTABLE_CLASS_LIST whose table
   symbol is used (SYM_FLAGS 4) or always in mode 2 (CPU_IS_286), once (SYM_FLAGS 1
   marks it done), and stores the size in the table symbol's array type. */
static void near pascal C13CLASSES(void)
{
    unsigned int type;
    unsigned int size;
    register unsigned int symbol;
    register unsigned int node;
    for(node=VTABLE_CLASS_LIST;node;node=DW(node,0)) {
        type=SW(DW(node,2),4);
        symbol=LW(TW(type,5),18);
        if((SB(symbol,6)&4) || CPU_IS_286) {
            if(!((unsigned int)SB(symbol,6)&1)) {
                SB(symbol,6)|=1;
                C13BUILD(type,&size);
                *(unsigned long far *)MK_FP(TYPE_POOL,
                    (unsigned int)SW(symbol,4)+9)=size;
            }
        }
    }
}

/* 1072: the genuine public whole-unit driver. */
/* PROCESS_DEFERRED_DECLS: the end-of-file driver (see the overview). Sets up the two
   scratch pools C13_ORDER_BANK and C13_BIND_BANK first. */
void far pascal PROCESS_DEFERRED_DECLS(void)
{
    LEX_FILE_SERIAL_NODE=0xFFFF;
    if(NO_ERRORS_YET) {
        C13_ORDER_BANK.used=C13_ORDER_BANK.spare=0;
        C13_ORDER_BANK.limit=0;
        POOL_INIT(&C13_ORDER_BANK.segment,0);
        C13_BIND_BANK.used=C13_BIND_BANK.spare=0;
        C13_BIND_BANK.limit=0;
        POOL_INIT(&C13_BIND_BANK.segment,0);
        ++SUPPRESS_WARNINGS_DEPTH;
        C13DECLARATIONS();
        C13PENDING(FILE_INIT_EXPR_QUEUE);
        C13VALUES(TEMP_DESTRUCTOR_LIST);
        /* Compiling functions and emitting tables can queue more functions:
           repeat until nothing is pending. */
        do {
            C13DECLARATIONS();
            if(!CPU_LEVEL_1_FLAG)
                C13CLASSES();
            FLUSH_PENDING_INITIALIZERS(0);
        } while(PENDING_DEFINITION_LIST);
        --SUPPRESS_WARNINGS_DEPTH;
    }
}

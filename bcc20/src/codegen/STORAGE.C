/* target: ovr057_C76UNIT */
/* opts: -mm -G -O -Z -p -Y -rd */
/* Role: code generation: queries and setters for symbol storage records and type classes,
   runtime helper symbol declaration, parameter counts; probably called through back-end
   hooks. Entry points: STORAGE_INTRINSIC_NUMBER, STORAGE_SEGMENT, SYMBOL_CATEGORY,
   TYPE_CLASS_BYTE, STORAGE_TYPE_CLASS, STORAGE_FIRST_WORD, SET_STORAGE_FLAG_20,
   SET_STORAGE_ARG_COUNT (+17 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: small services the back end asks of the front end, outside the back-end
   overlays (C76UNIT); the existing comments give each function's offset in the original
   module. Most take a 'storage' handle: the prepared storage record of a symbol, made by
   PREPARE_SYMBOL (cpp/CPPSCOPE.C). Records of autos and parameters live in
   STORAGE_POOL_SEG and the handle is the record offset with bit 0 set; all others live in
   CSYM_POOL_SEG and the handle is the plain offset (hence the repeated 'storage&1' test).
   The 10-byte record is {head, value, extra, symbol, flags} at offsets 0, 2, 4, 6, 8:
   'value' is the segment id, 'extra' the intrinsic number of an intrinsic function (read
   here as STORAGE_INTRINSIC_NUMBER), 'symbol' the front-end symbol, 'flags' a flag word.
   The rest are type queries (class byte, near-pointer mode, function flags, size),
   declaration of run-time helper symbols, the parameter count of a function type, an
   address-of node builder and a temporary allocator. Probably all reached through the
   back-end hook table rather than called directly. */
#include <dos.h>
#include "STORAGE.H"
#include "POOL.H"

/* 0000: tagged storage argument count. */
unsigned int far pascal STORAGE_INTRINSIC_NUMBER(register unsigned int storage)
{
    if(storage&1) return AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+4);
    return AT_W(CSYM_POOL_SEG,storage+4);
}

/* 002A: tagged storage segment. */
unsigned int far pascal STORAGE_SEGMENT(register unsigned int storage)
{
    if(storage&1) return AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+2);
    return AT_W(CSYM_POOL_SEG,storage+2);
}

/* 0054: symbol category, transported as a full WORD. */
/* SYMBOL_CATEGORY: returns the storage class of the record's symbol (SYM_STORAGE_CLASS
   shifted right by 3). */
unsigned int far pascal SYMBOL_CATEGORY(unsigned int storage)
{
    return (int)SYM_B(GET_PREPARED_SYMBOL(storage),SYM_STORAGE_CLASS)>>3;
}

/* 0075: class of the supplied type, returned only in AL. */
/* TYPE_CLASS_BYTE: returns the type kind the back end works with for 'type': the kind
   itself, the base kind for an enum, and 0x13 for a near pointer of mode 0x0B (member
   pointer) to a function when CPP_MODE is set. */
unsigned char far pascal TYPE_CLASS_BYTE(register unsigned int type)
{
    if(CPP_MODE && TYPE_W(type,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(type,TYPE_PTR_MODE)==0x0B &&
       (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)
        return 0x13;
    if(TYPE_W(type,TYPE_KIND)==TK_ENUM) return TYPE_B(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_ENUM_BASE),TYPE_KIND);
    return TYPE_B(type,TYPE_KIND);
}

/* 00D7: resolve storage to a type before classifying it. */
/* STORAGE_TYPE_CLASS: the same classification for the type TYPE_HOOK gives for
   'storage', after stripping array levels to the element type. */
unsigned char far pascal STORAGE_TYPE_CLASS(unsigned int storage)
{
    register unsigned int type;
    type=TYPE_HOOK(storage);
    while(TYPE_W(type,TYPE_KIND)==TK_ARRAY) type=TYPE_W(type,TYPE_TARGET);
    if(CPP_MODE && TYPE_W(type,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(type,TYPE_PTR_MODE)==0x0B &&
       (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)
        return 0x13;
    if(TYPE_W(type,TYPE_KIND)==TK_ENUM) return TYPE_B(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_ENUM_BASE),TYPE_KIND);
    return TYPE_B(type,TYPE_KIND);
}

/* 014F: tagged storage's first WORD. */
unsigned int far pascal STORAGE_FIRST_WORD(register unsigned int storage)
{
    if(storage&1) return AT_W(STORAGE_POOL_SEG,storage&0xFFFE);
    return AT_W(CSYM_POOL_SEG,storage);
}

/* 0177 */
/* SET_STORAGE_FLAG_20: sets bit 0x20 in the record's flag word. */
void far pascal SET_STORAGE_FLAG_20(register unsigned int storage)
{
    if(storage&1) AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+8)|=0x20;
    else AT_W(CSYM_POOL_SEG,storage+8)|=0x20;
}

/* 01A5 */
/* SET_STORAGE_ARG_COUNT: stores 'value' in word 4 of the record (see STORAGE_INTRINSIC_NUMBER). */
void far pascal SET_STORAGE_ARG_COUNT(register unsigned int storage,register unsigned int value)
{
    if(storage&1) AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+4)=value;
    else AT_W(CSYM_POOL_SEG,storage+4)=value;
}

/* 01D4 */
/* SET_STORAGE_SEGMENT: sets the record's segment id. */
void far pascal SET_STORAGE_SEGMENT(register unsigned int storage,register unsigned int segment)
{
    if(storage&1) AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+2)=segment;
    else AT_W(CSYM_POOL_SEG,storage+2)=segment;
}

/* 0203: retain the separate flag update before the segment store. */
/* SET_STORAGE_SEGMENT_FLAG_8: sets bit 8 in the flag word and the segment id. */
void far pascal SET_STORAGE_SEGMENT_FLAG_8(register unsigned int storage,register unsigned int segment)
{
    if(storage&1) {
        AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+8)|=8;
        AT_W(STORAGE_POOL_SEG,(storage&0xFFFE)+2)=segment;
    } else {
        AT_W(CSYM_POOL_SEG,storage+8)|=8;
        AT_W(CSYM_POOL_SEG,storage+2)=segment;
    }
}

/* 0244 */
/* SET_STORAGE_FIRST_WORD: sets word 0 of the record. */
void far pascal SET_STORAGE_FIRST_WORD(register unsigned int storage,register unsigned int value)
{
    if(storage&1) AT_W(STORAGE_POOL_SEG,storage&0xFFFE)=value;
    else AT_W(CSYM_POOL_SEG,storage)=value;
}

/* 0271 */
/* IS_BASED_NEAR_PTR: true for a near pointer with a base (TYPE_PTR_BASE set). */
int far pascal IS_BASED_NEAR_PTR(register unsigned int type)
{
    return TYPE_W(type,TYPE_KIND)==TK_NEAR_PTR && TYPE_W(type,TYPE_PTR_BASE)!=0;
}

/* 0295: this consumer sign-extends the actual BYTE attribute. */
/* NEAR_PTR_SUBKIND: the pointer mode byte (TYPE_PTR_MODE) of a near pointer, else 0. */
int far pascal NEAR_PTR_SUBKIND(register unsigned int type)
{
    if(TYPE_W(type,TYPE_KIND)==TK_NEAR_PTR) return TYPE_SC(type,TYPE_PTR_MODE);
    return 0;
}

/* 02B4: INT permits the alternate family's signed BYTE result too. */
/* TYPE_ATTR_BYTE_0C: the function flags byte of a function type (TYPE_FUNC_FLAGS). */
int far pascal TYPE_ATTR_BYTE_0C(unsigned int type)
{
    return TYPE_B(type,TYPE_FUNC_FLAGS);
}

/* 02C8 */
/* TYPE_ATTR_BYTE_0B: the calling-convention byte of a function type (TYPE_CALL_CONV). */
int far pascal TYPE_ATTR_BYTE_0B(unsigned int type)
{
    return TYPE_B(type,TYPE_CALL_CONV);
}

/* 02DC: both DX and AX are the actual returned size. */
long far pascal STORAGE_TYPE_SIZE(unsigned int type)
{
    return TYPE_SIZE(type);
}

/* 02EB: one true BYTE formal, rounded by the calling convention. */
unsigned int far pascal BASIC_TYPE_FOR_KIND(unsigned char index)
{
    return BCC_TYPE_PTR[index];
}

/* 0302 */
/* SYMBOL_TYPE_OF_STORAGE: the type of the record's symbol. */
unsigned int far pascal SYMBOL_TYPE_OF_STORAGE(unsigned int storage)
{
    return SYM_W(GET_PREPARED_SYMBOL(storage),SYM_TYPE);
}

/* 031B: name creation precedes the fresh context read. */
/* DECLARE_RUNTIME_SYMBOL: returns the storage record for the run-time helper named
   'text', declaring it as a global function of type RUNTIME_HELPER_FUNC_TYPE the first
   time. The symbol gets SYM_FLAGS 4; on first declaration flag 0x40 follows 'mark', and
   with CPP_MODE the linkage is set to 2 (as for main). */
unsigned int far pascal DECLARE_RUNTIME_SYMBOL(register char near *text,unsigned int mark)
{
    register unsigned int symbol;

    symbol=FIND_NAME_IN_LIST(BCC_SYMBOL_CREATE((char far *)text,0),GLOBAL_SCOPE_NAMES);
    if(symbol) SYM_B(symbol,SYM_FLAGS)|=4;
    else {
        symbol=DECLARE_GLOBAL_SYMBOL((char far *)text,RUNTIME_HELPER_FUNC_TYPE,0,0);
        SYM_B(symbol,SYM_FLAGS)|=4;
        if(mark) SYM_B(symbol,SYM_FLAGS)|=0x40;
        else SYM_B(symbol,SYM_FLAGS)&=0xBF;
        if(CPP_MODE) SYM_W(symbol,SYM_LINKAGE)=2;
        C0MARK((unsigned char)0);
    }
    return PREPARE_SYMBOL(symbol);
}

/* 039D: retained even though no covered nominal slot invokes it. */
int far pascal IS_STRING_LITERAL_STORAGE(unsigned int storage)
{
    return PREPARE_SYMBOL(STRING_LITERAL_SYMBOL)==storage;
}

/* 03B9 */
/* STRING_LITERAL_STORAGE: the storage record of STRING_LITERAL_SYMBOL. */
unsigned int far pascal STRING_LITERAL_STORAGE(void)
{
    return PREPARE_SYMBOL(STRING_LITERAL_SYMBOL);
}

/* 03C7 */
/* PARAMETER_COUNT: number of parameters of function type 'type' (or of the function a
   pointer type points to). Returns 0x7FFF when TYPE_FUNC_FLAGS has 8 (no prototype).
   One is added for a hidden parameter when the function returns a struct (EXPR_FLAGS bit
   0x40) that is not returned in registers: size above 4 or exactly 3, or a class with a
   constructor (TYPE_ATTRS 4). */
unsigned int far pascal PARAMETER_COUNT(register unsigned int type)
{
    unsigned int parameter;
    unsigned int result_type;
    unsigned int size;
    register unsigned int count;

    if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) type=TYPE_W(type,TYPE_TARGET);
    if(TYPE_B(type,TYPE_FUNC_FLAGS)&8) return 0x7FFF;
    count=0;
    parameter=TYPE_W(type,TYPE_PARAMS);
    while(parameter) {
        parameter=FORMAL_W(parameter,FORMAL_NEXT);
        ++count;
    }
    result_type=TYPE_W(type,TYPE_TARGET);
    size=(unsigned int)TYPE_SIZE(result_type);
    if((EXPR_FLAGS[TYPE_W(result_type,TYPE_KIND)]&0x40) &&
       (size>4 || size==3 || (TYPE_B(result_type,TYPE_ATTRS)&4)))
        ++count;
    return count;
}

/* 045F */
/* MAKE_ADDRESS_OF_TYPED: builds '&expression' (token 0x1B is '&') whose type is a pointer
   to 'type': pointer mode 0x10 with 'force', 0x0F when the expression is a symbol whose
   storage flags have 0x10, else 0. Taking the address of an auto, parameter or register
   variable (ops 4, 5, 7) when DS is not SS (OPTION_DS_NOT_SS, MODEL_FAR_DATA clear) gives
   pointer mode 3, probably an SS-relative pointer. Returns the new node. */
unsigned int far pascal MAKE_ADDRESS_OF_TYPED(unsigned int type,register unsigned int expression,
    unsigned int force)
{
    unsigned int mode;
    register unsigned int node;

    mode=0;
    node=MAKE_UNARY_NODE(0x1B,expression);
    EXPR_B(node,EXPR_NODE_FLAGS)=0;
    EXPR_B(node,EXPR_NODE_FLAGS2)=0;
    if(EXPR_W(expression,EXPR_OP)==1 && (GET_PREPARED_FLAGS(EXPR_W(expression,EXPR_LEFT))&0x10))
        mode=0x0F;
    EXPR_W(node,EXPR_TYPE)=MAKE_POINTER_TYPE(type,force?0x10:mode,(unsigned char)0);
    if((EXPR_W(expression,EXPR_OP)==5 || EXPR_W(expression,EXPR_OP)==4 || EXPR_W(expression,EXPR_OP)==7) &&
       MODEL_FAR_DATA==0 && OPTION_DS_NOT_SS)
        TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_PTR_MODE)=3;
    EXPR_W(node,EXPR_KIND)=(unsigned int)GET_TYPE_KIND_HOOK(EXPR_W(node,EXPR_TYPE));
    return node;
}

/* 0514 */
/* TEMP_STORAGE_FOR_TYPE: creates a local temporary of 'type' and returns its storage
   record. */
unsigned int far pascal TEMP_STORAGE_FOR_TYPE(unsigned int type)
{
    return PREPARE_SYMBOL(CREATE_LOCAL_TEMP(type));
}

/* 0529: real exported identity, retained without a synthetic caller. */
unsigned int far pascal STORAGE_IDENTITY(unsigned int value)
{
    return value;
}

/* mangle.c: from bcc20/src/cpp/MANGLE.C: Borland C++ name mangling, the link names that
   encode a C++ symbol's class and parameter types.  MANGLE_SYMBOL_NAME is the main entry,
   used when a symbol is written to the object file and to name per-function and virtual
   table segments; MANGLE_MEMBER_NAME does the same for a member record; MANGLE_PLAIN_NAME
   and MANGLE_FUNCTION_PREFIX also serve the type spelling for messages, and APPEND_DECIMAL
   the type spelling.  The form built is
     @Class@name$q<arguments>            member function
     @name$q<arguments>                  ordinary function
     @Class@$b<op>$q... / @Class@$o<type>$q...   operators / conversion functions
     @Class@name                         static data member, ordinary data
   with 'x' and 'w' before the 'q' for const and volatile member functions, and '0' after
   "@Class@" when the class is huge (class flag 100h) or OPTION_FLAG is set.  Argument
   types: one or two letters per type from C14_TYPE_ENCODINGS (a table of far pointers;
   qualifiers 'x' const, 'w' volatile first), 'p'/'r' near pointer/reference, 'n'/'m' far
   pointer/reference, 'a<count>$' arrays, 'q...$' functions, length-prefixed names for
   classes and enums, 'v' for no arguments, 'e' for an ellipsis, and 't<code>' to repeat an
   earlier argument's type (codes from C14_ARGUMENT_CODES).  All output goes into a buffer
   (a length word and at most 1FFh characters); MANGLE_SYMBOL_NAME and MANGLE_MEMBER_NAME use
   the shared C14_NAME_BUFFER and shorten the result to 63 characters, the last two a
   checksum of the cut-off part.  Kept: the remembered argument types share their 37th slot
   with the search index, as in the original union. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "protos.h"
#include "calls.h"

#define LENGTH(out) W(out)
#define TEXT(out, i) SB(fp_add((out), 2 + (i)))
#define ENCODING(kind) D(fp_add(C14_TYPE_ENCODINGS_P, (kind) * 4))
#define ARGUMENT_CODE(i) SB(fp_add(D(C14_ARGUMENT_CODES_P), (i)))
#define BUFFER_SIZE 516

/* a character or a zero-ended string onto out, dropping what does not fit */
void C14CHAR(i8 value, farptr out)
{
    if (LENGTH(out) < 0x1FF)
        TEXT(out, LENGTH(out)++) = value;
}

void C14TEXT(farptr text, farptr out)
{
    i8 value;
    while ((value = SB(text)) != 0) {
        text = fp_add(text, 1);
        C14CHAR(value, out);
    }
}

/* the text of name record name: a far pointer whose segment is the word a near pointer
   points at (a bank segment word) */
static farptr name_text(u16 name)
{
    u16 offset = NAME_W(name, 2), bank = NAME_W(name, 4);
    return MK_FP(W(DSPTR(bank)), offset);
}

/* the name of symbol (nothing for 0 or an unnamed symbol) */
void C14SYMBOL(u16 symbol, farptr out)
{
    if (symbol && SYM_W(symbol, SYM_NAME))
        C14TEXT(name_text(SYM_W(symbol, SYM_NAME)), out);
}

/* value in decimal */
void APPEND_DECIMAL(u32 value, farptr out)
{
    u16 digits[12];
    i16 index = 12;
    do {
        digits[--index] = (u16)(value % 10) + '0';
        value /= 10;
    } while (value != 0);
    while (index <= 11)
        C14CHAR((i8)digits[index++], out);
}

/* a symbol's name preceded by its length in decimal (classes and enums among the
   arguments) */
void C14LENGTH(u16 symbol, farptr out)
{
    u16 mark = scratch_mark();
    farptr temporary = scratch_alloc(BUFFER_SIZE);
    LENGTH(temporary) = 0;
    C14SYMBOL(symbol, temporary);
    APPEND_DECIMAL(LENGTH(temporary), out);
    for (i16 index = 0; index < (i16)LENGTH(temporary); ++index)
        C14CHAR(TEXT(temporary, index), out);
    scratch_release(mark);
}

/* '@' and, for a member, the class name, '@' and the marker '0' for a huge class (or with
   OPTION_FLAG).  owner is the class's tag symbol or 0 */
void C14PREFIX(u16 owner, farptr out)
{
    C14CHAR('@', out);
    if (owner) {
        C14SYMBOL(owner, out);
        C14CHAR('@', out);
        if (OPTION_FLAG || (TAG_W(TYPE_W(SYM_W(owner, SYM_TYPE), TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x100))
            C14CHAR('0', out);
    }
}

/* out = @[Class@]name, the mangled name of a data symbol, or the start of a function's */
void MANGLE_PLAIN_NAME(u16 owner, u16 symbol, farptr out)
{
    LENGTH(out) = 0;
    C14PREFIX(owner, out);
    C14SYMBOL(symbol, out);
}

/* the encoding of type; '?' for a missing type.  Pointers, arrays and functions continue
   with the encoding of their target type */
void C14TYPE(u16 type, farptr out)
{
    if (!type) {
        C14CHAR('?', out);
        return;
    }
    if (TYPE_B(type, TYPE_ATTRS) & 1)
        C14CHAR('x', out);
    if (TYPE_B(type, TYPE_ATTRS) & 2)
        C14CHAR('w', out);
    switch (TYPE_W(type, TYPE_KIND)) {
    case TK_ENUM:
        C14LENGTH(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), out);
        return;
    case TK_NEAR_PTR:
        C14CHAR((TYPE_B(type, TYPE_ATTRS) & 0x20) ? 'r' : 'p', out);
        break;
    case TK_FAR_PTR:
        C14CHAR((TYPE_B(type, TYPE_ATTRS) & 0x20) ? 'm' : 'n', out);
        break;
    case TK_SEG_PTR:
    case TK_HUGE_PTR:
        C14TEXT(ENCODING(TYPE_W(type, TYPE_KIND)), out);
        break;
    case TK_ARRAY:
        C14CHAR('a', out);
        if (!(TYPE_B(type, TYPE_ATTRS) & 0x20))
            APPEND_DECIMAL(TYPE_UL(type, TYPE_ARRAY_COUNT), out);
        C14CHAR('$', out);
        break;
    case TK_STRUCT:
    case TK_UNION:
        C14LENGTH(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), out);
        return;
    case TK_FUNCTION:
        C14CHAR('q', out);
        C14ARGUMENTS(type, 0, 0, out);
        C14CHAR('$', out);
        break;
    default:
        C14TEXT(ENCODING(TYPE_W(type, TYPE_KIND)), out);
        return;
    }
    C14TYPE(TYPE_W(type, TYPE_TARGET), out);
}

/* 1 when type is a basic type whose encoding, with a qualifier letter, is at most two
   characters: repeating it is shorter than a 't' back-reference */
u8 C14SHORT(u16 type)
{
    u16 qualifier = (TYPE_B(type, TYPE_ATTRS) & 3) != 0;
    return (i16)TYPE_W(type, TYPE_KIND) <= TK_VOID && STRING_LENGTH(ENCODING(TYPE_W(type, TYPE_KIND))) + qualifier <= 2;
}

/* the parameter types of function type, skipping the first parameter when first is set
   (this) and the next when second is set (a hidden parameter).  A type equal to an earlier
   parameter's (up to 35 remembered) is written as 't' plus the earlier position's code */
void C14ARGUMENTS(u16 type, u8 first, u8 second, farptr out)
{
    u16 slots[37];                      /* slots[36] is the search index too */
#define SEARCH slots[36]
    u16 parameter = TYPE_W(type, TYPE_PARAMS);
    u8 variadic = (TYPE_B(type, TYPE_FUNC_FLAGS) & 4) != 0;
    if (first)
        parameter = FORMAL_W(parameter, FORMAL_NEXT);
    if (second)
        parameter = FORMAL_W(parameter, FORMAL_NEXT);
    i16 count = 0;
    if (!parameter)
        C14CHAR('v', out);
    else
        do {
            if (count <= 35)
                slots[++count] = FORMAL_W(parameter, FORMAL_TYPE);
            if (C14SHORT(FORMAL_W(parameter, FORMAL_TYPE)))
                C14TYPE(FORMAL_W(parameter, FORMAL_TYPE), out);
            else {
                for (SEARCH = 1; (i16)SEARCH < count && !TYPES_COMPATIBLE(slots[SEARCH], FORMAL_W(parameter, FORMAL_TYPE), 0); ++SEARCH)
                    ;
                if ((i16)SEARCH >= count)
                    C14TYPE(FORMAL_W(parameter, FORMAL_TYPE), out);
                else {
                    C14CHAR('t', out);
                    C14CHAR(ARGUMENT_CODE(SEARCH), out);
                }
            }
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
        } while (parameter);
#undef SEARCH
    if (variadic)
        C14CHAR('e', out);
}

static void put_text(farptr text, farptr out)
{
    while (SB(text)) {
        C14CHAR(SB(text), out);
        text = fp_add(text, 1);
    }
}

/* @[Class@]$b<name> for a binary operator function; operation is the operator's token code
   and selects the short name ('?' if unknown; r-prefixed names for compound assignments) */
void C14OPERATOR(u16 owner, u16 operation, farptr out)
{
    farptr text;
    C14PREFIX(owner, out);
    C14CHAR('$', out);
    C14CHAR('b', out);
    switch (operation) {
    case 22: text = STR_ADD_P; break;
    case 23: text = STR_SUB_P; break;
    case 24: text = STR_MUL_P; break;
    case 25: text = STR_DIV_P; break;
    case 26: text = STR_MOD_P; break;
    case 29: text = STR_X_P; break;
    case 27: text = STR_AND_P; break;
    case 28: text = STR_OR_P; break;
    case 43: text = STR_CMP_P; break;
    case 11: text = STR_ASG_P; break;
    case 38: text = STR_LSS_P; break;
    case 39: text = STR_GTR_P; break;
    case 12: text = STR_RPLU_P; break;
    case 13: text = STR_RMIN_P; break;
    case 14: text = STR_RMUL_P; break;
    case 15: text = STR_RDIV_P; break;
    case 16: text = STR_RMOD_P; break;
    case 19: text = STR_RXOR_P; break;
    case 17: text = STR_RAND_P; break;
    case 18: text = STR_ROR_P; break;
    case 30: text = STR_LSH_P; break;
    case 31: text = STR_RSH_P; break;
    case 20: text = STR_RLSH_P; break;
    case 21: text = STR_RRSH_P; break;
    case 36: text = STR_EQL_P; break;
    case 37: text = STR_NEQ_P; break;
    case 40: text = STR_LEQ_P; break;
    case 41: text = STR_GEQ_P; break;
    case 35: text = STR_LAND_P; break;
    case 34: text = STR_LOR_P; break;
    case 1: text = STR_CALL_P; break;
    case 3: text = STR_SUBS_P; break;
    case 108: text = STR_NEW_2_P; break;
    case 105: text = STR_DELE_P; break;
    case 48: text = STR_AROW_P; break;
    case 8: text = STR_COMA_P; break;
    case 102: text = STR_ARWM_P; break;
    default: text = STR_QUEST_P; break;
    }
    put_text(text, out);
}

/* the same for the one-operand forms: unary operators, constructors (ctr, operation 5),
   destructors (dtr, 6), new and delete */
void C14SPECIAL(u16 owner, u16 operation, farptr out)
{
    farptr text;
    C14PREFIX(owner, out);
    C14CHAR('$', out);
    C14CHAR('b', out);
    switch (operation) {
    case 22: text = STR_ADD_P; break;
    case 23: text = STR_SUB_P; break;
    case 24: text = STR_IND_P; break;
    case 27: text = STR_ADR_P; break;
    case 43: text = STR_CMP_P; break;
    case 42: text = STR_NOT_P; break;
    case 45: text = STR_INC_P; break;
    case 46: text = STR_DEC_P; break;
    case 5: text = STR_CTR_P; break;
    case 6: text = STR_DTR_P; break;
    case 108: text = STR_NEW_2_P; break;
    case 105: text = STR_DELE_P; break;
    default: text = STR_QUEST_P; break;
    }
    put_text(text, out);
}

/* @[Class@]$o<type> for a conversion function to type */
void C14CONVERSION(u16 owner, u16 type, farptr out)
{
    C14PREFIX(owner, out);
    C14CHAR('$', out);
    C14CHAR('o', out);
    C14TYPE(type, out);
}

/* out = the part of a function's mangled name before its argument types, ending in $q
   (with x/w for const/volatile functions), by SYM_FUNC_KIND: 0 plain name, 1 operator
   function (unary when it has a single parameter, counting this), 2 conversion function, 3
   constructor, 4 destructor.  owner is the class's tag symbol or 0 */
void MANGLE_FUNCTION_PREFIX(u16 owner, u16 symbol, farptr out)
{
    LENGTH(out) = 0;
    switch (SYM_W(symbol, SYM_FUNC_KIND)) {
    case 0:
        MANGLE_PLAIN_NAME(owner, symbol, out);
        break;
    case 1: {
        u16 parameter = TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_PARAMS);
        if (FORMAL_W(parameter, FORMAL_NEXT) == 0)
            C14SPECIAL(owner, TOKEN_FROM_NAME(SYM_W(symbol, SYM_NAME)), out);
        else
            C14OPERATOR(owner, TOKEN_FROM_NAME(SYM_W(symbol, SYM_NAME)), out);
        break;
    }
    case 2:
        C14CONVERSION(owner, TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_TARGET), out);
        break;
    case 3:
        C14SPECIAL(owner, 5, out);
        break;
    case 4:
        C14SPECIAL(owner, 6, out);
        break;
    }
    C14CHAR('$', out);
    if (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_ATTRS) & 1)
        C14CHAR('x', out);
    if (TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_ATTRS) & 2)
        C14CHAR('w', out);
    C14CHAR('q', out);
}

/* the full mangled name of symbol: for a function the prefix and the argument types,
   skipping this (non-static members) and the hidden parameter of a destructor or of a
   constructor of a class with virtual bases; for data the plain name */
void C14NAME(u16 symbol, farptr out)
{
    u16 owner = (SYM_B(symbol, SYM_FLAGS) & 0x10) ? SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE) : 0;
    u16 owner_symbol = owner == 0 ? 0 : TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_SYMBOL);
    if (TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND) == TK_FUNCTION) {
        u8 first = owner && !(SYM_W(symbol, SYM_FUNC_FLAGS) & 0x40);
        u8 second = 0;
        MANGLE_FUNCTION_PREFIX(owner_symbol, symbol, out);
        if (owner) {
            if (SYM_W(symbol, SYM_FUNC_KIND) == 4)
                second = 1;
            else if (SYM_W(symbol, SYM_FUNC_KIND) == 3)
                second = (TAG_W(TYPE_W(owner, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4) != 0;
        }
        C14ARGUMENTS(SYM_W(symbol, SYM_TYPE), first, second, out);
    } else
        MANGLE_PLAIN_NAME(owner_symbol, symbol, out);
}

/* cuts out to limit characters when longer than limit - 2, putting a two-character
   checksum of the removed tail (letters from a 63-character alphabet) in the last two
   places, so long names stay distinct */
void C14SHORTEN(i16 limit, farptr out)
{
    farptr alphabet = STR_ZYXWVUTSRQPONMLKJIHGFEDC_P;
    if ((i16)LENGTH(out) > limit - 2) {
        i16 checksum = 0;
        for (i16 index = limit - 2; index < (i16)LENGTH(out); ++index)
            checksum = checksum + TEXT(out, index);
        TEXT(out, limit - 2) = SB(fp_add(alphabet, (checksum / 63) % 63));
        TEXT(out, limit - 1) = SB(fp_add(alphabet, checksum % 63));
        LENGTH(out) = limit;
    }
}

/* the mangled name of symbol as a zero-ended string in C14_NAME_BUFFER (overwritten by the
   next call) */
farptr MANGLE_SYMBOL_NAME(u16 symbol)
{
    C14NAME(symbol, C14_NAME_BUFFER_P);
    C14SHORTEN(63, C14_NAME_BUFFER_P);
    TEXT(C14_NAME_BUFFER_P, LENGTH(C14_NAME_BUFFER_P)) = 0;
    return fp_add(C14_NAME_BUFFER_P, 2);
}

/* @Class@name for member record member, in C14_NAME_BUFFER */
farptr MANGLE_MEMBER_NAME(u16 member)
{
    LENGTH(C14_NAME_BUFFER_P) = 0;
    C14PREFIX(TAG_W(TYPE_W(MEMBER_W(member, MEMB_CLASS), TYPE_TAG_BODY), TAG_SYMBOL), C14_NAME_BUFFER_P);
    C14TEXT(name_text(MEMBER_W(member, MEMB_NAME)), C14_NAME_BUFFER_P);
    C14SHORTEN(63, C14_NAME_BUFFER_P);
    TEXT(C14_NAME_BUFFER_P, LENGTH(C14_NAME_BUFFER_P)) = 0;
    return fp_add(C14_NAME_BUFFER_P, 2);
}

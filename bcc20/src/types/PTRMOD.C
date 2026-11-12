/* target: ovr134_STOVR95 */
/* opts: -mm -G -O -Z -p */
/* Role: types: builds the pointer type for a near, far, huge or _seg modifier, defaulting
   by memory model and function type. Entry points: PTR_TYPE_FOR_MODIFIER. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: one function, PTR_TYPE_FOR_MODIFIER, that makes "pointer to <node>" for a
   given pointer modifier. Declarators (parser/CDECL.C, e.g. decaying a function or array
   parameter) and the expression parser (expr/EXPRPARS.C, taking an address) call it with
   modifier 0, meaning "whatever the memory model says". It only chooses the pointer kind
   (TK_NEAR_PTR 13, TK_SEG_PTR 14, TK_FAR_PTR 15, TK_HUGE_PTR 16) and the near-pointer
   mode stored in TYPE_PTR_MODE (2 code, 4 data, other small numbers for the segment a
   near pointer is based on), then lets NEW_POINTER_TYPE (types/TYPEREC.C) find or build
   the type record. Pointers to functions default to the code model (MODEL_FAR_CODE, or a
   function type flagged far in TYPE_C_FUNC_FLAGS bit 0); pointers to data default to
   the data model in MODEL_FAR_DATA (probably "far data", the byte after MODEL_FAR_CODE).
   The kinds are written as numbers, not TK_ names, in this file. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"
extern unsigned char MODEL_FAR_CODE;
extern unsigned int far pascal NEW_POINTER_TYPE(unsigned int,unsigned char,int,unsigned int,int);
/* PTR_TYPE_FOR_MODIFIER: node is the pointed-to type, qualifier the const/volatile bits
   of the pointer, value is passed through to NEW_POINTER_TYPE, and second the modifier:
   0 none (model default), 1..6 a near pointer with that segment mode (probably the
   _cs/_ds/_es/_ss style based pointers), 7 _seg, 8 near (mode by target kind), 9 far,
   10 huge. Returns the pointer type record. */
/* second is a Flags.second selector in the original caller's 0..10 domain. */
unsigned int far pascal PTR_TYPE_FOR_MODIFIER(register unsigned int node,signed char qualifier,unsigned int value,signed char second)
{
    unsigned int kind;
    int flags;
    register int mode=0;
    switch(second) {
    case 1:case 2:case 3:case 4:case 5:case 6:
        mode=second;
        kind=13;
        break;
    case 9:kind=15;break;
    case 7:kind=14;break;
    case 10:kind=16;break;
    case 8:
        if(TYPE_SC(node,TYPE_KIND)==TK_FUNCTION) {mode=2;kind=13;}
        else {mode=4;do kind=13; while(0);}  /* do-while: mov di,4 stays */
        break;
    case 0:
        if(TYPE_SC(node,TYPE_KIND)==TK_FUNCTION) {
            flags=TYPE_SC(node,TYPE_C_FUNC_FLAGS);
            if(MODEL_FAR_CODE || (flags&1)) kind=15;
            else {mode=2;kind=13;(void)0;}    /* documented dummy: keeps this
                                    store out of the tail merge, as the original */
        } else {
            if(MODEL_FAR_DATA) kind=15;
            else {mode=4;kind=13;}
        }
        break;
    }
    return NEW_POINTER_TYPE(node,(unsigned char)kind,qualifier,value,mode);
}

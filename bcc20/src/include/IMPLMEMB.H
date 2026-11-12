#ifndef IMPLMEMB_H
#define IMPLMEMB_H
#include "DATA.H"
extern unsigned int far pascal FIND_DEFAULT_CTOR(unsigned int,unsigned char);
extern long far pascal FORMAT_SPECIAL_MEMBER(unsigned int,unsigned int,unsigned int);
extern long far pascal MEMBER_NAME_TEXT(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,long,long);
extern unsigned char far pascal SYMBOL_ACCESSIBLE(unsigned int,unsigned int);
extern char far * far pascal FORMAT_SYMBOL(unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int,unsigned int);

/* The following bindings extend the original prefix's extern-only data contract. */
extern unsigned int TYPE_SIZE_LOW;
extern unsigned int CODE_SEGMENT_ID;
extern unsigned char MODEL_FAR_CODE;
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern unsigned int far pascal CREATE_TYPE(unsigned int);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern unsigned int far pascal DECLARE_MEMBER(unsigned int,unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal SET_PREPARED_FLAGS(unsigned int,unsigned int);
extern unsigned int far pascal LIST_CONS(unsigned int,unsigned int);
extern void far pascal C0MARK(unsigned char);
extern void far pascal SET_FUNCTION_SYMBOL_TYPE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CREATE_PARAM_RECORD(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern void far pascal ADD_THIS_PARAMETER(unsigned int,unsigned int);
extern void far pascal ADD_HIDDEN_PARAMETER(unsigned int,unsigned int);
extern unsigned int far pascal TYPE_OFFSET_FAR(unsigned char,unsigned int);
extern unsigned int far pascal CREATE_TEMP_SYMBOL(unsigned int,unsigned char);
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern void far pascal COMPILE_INLINE_BODY(unsigned int,unsigned char);
extern void far pascal LIST_CELL_FREE(unsigned int);
extern unsigned char far pascal SAME_SIGNATURE(unsigned int,unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal COLLECT_VBASES(unsigned int);
extern void far pascal FREE_PARAM_ITEM(unsigned int);
extern unsigned int far pascal COPY_PARAM_QUALIFIERS(unsigned int,unsigned int);
extern unsigned int far pascal FIND_COPY_CTOR(unsigned int,unsigned char);

#endif

/* target: ovr175_STAOV15F */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: emits the bytes of a constant initialiser (integers, float/double
   from long double, addresses through hooks); reports illegal initialisation. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: writes the bytes of one constant initialiser value, for static data. The
   value is an already folded expression node: an integer or pointer constant (EXPR_OP 2),
   a floating constant (op 3, held as a 10-byte long double in the node from EXPR_LEFT on
   and narrowed with RTL_LDOUBLE_TO_FLOAT or RTL_LDOUBLE_TO_DOUBLE), or the address of a
   symbol (op 0x32 over a symbol node, op 1, possibly under ops 0x35, probably casts),
   which goes out through WORD_HOOK (near address) or ALT_HOOK (far address) so the output
   layer can add a fixup. Anything else is reported as MSG_ILLEGAL_INITIALIZATION. Bytes go
   either to the data byte pool (EMIT_VALUE, BYTEPOOL.C) or to the current output through
   BYTE_HOOK. Value kinds (KIND.H): 1-2 chars, 3-6 shorts and ints, 13 near pointer, 14 _seg
   pointer, 21 enum, 7-8 longs, 15-16 far and huge pointers, 9-11 float, double, long double.
   The expression pool is reset at the end (RESET_EXPR_POOL_HOOK). */
#include <dos.h>
#include "MSG.H"
#include "POOL.H"
extern unsigned int EXPR_POOL_SEG;
typedef void (far pascal *EmitByte)(unsigned char);
extern EmitByte BYTE_HOOK;
extern void far pascal EMIT_VALUE(unsigned char);
extern void (far pascal *WORD_HOOK)(unsigned int,unsigned int);
extern void (far pascal *ALT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *RESET_EXPR_POOL_HOOK)(void);
extern void far cdecl REPORT_FATAL(unsigned int);
extern void far cdecl REPORT_ERROR(unsigned int);
extern void far *far pascal RTL_MEMMOVE(void far *,void far *,unsigned int);
extern void far pascal RTL_LDOUBLE_TO_FLOAT(void far *,void far *);
extern void far pascal RTL_LDOUBLE_TO_DOUBLE(void far *,void far *);
/* EMIT_INITIALIZER_VALUE: emits constant expression 'node' as initialiser bytes, low byte
   first; 'direct' non-zero sends them to the data byte pool (EMIT_VALUE), zero to
   BYTE_HOOK. Probably reached through a back-end hook (it is static and far). */
static void far pascal EMIT_INITIALIZER_VALUE(unsigned int node,unsigned int direct)
{
    unsigned int value;
    register int index;
    register unsigned int valueNode;
    EmitByte emit;
    unsigned char single[4],wide[8],extended[10];
    valueNode=node;
    if(direct!=0) emit=EMIT_VALUE;
    else emit=BYTE_HOOK;
    if(EXPR_W(valueNode,EXPR_OP)==2) {
        switch(EXPR_W(valueNode,EXPR_KIND)) {
        case 1: case 2:
            emit(EXPR_B(valueNode,EXPR_VALUE));break;
        case 3: case 4: case 5: case 6: case 13: case 14: case 21:
            emit(EXPR_B(valueNode,EXPR_VALUE));
            emit(EXPR_L(valueNode,EXPR_LEFT)>>8);break;
        case 7: case 8: case 15: case 16:
            emit(EXPR_B(valueNode,EXPR_VALUE));
            emit(EXPR_L(valueNode,EXPR_LEFT)>>8);
            emit(EXPR_L(valueNode,EXPR_LEFT)>>16);
            emit(EXPR_L(valueNode,EXPR_LEFT)>>24);break;
        }
    } else if(EXPR_W(valueNode,EXPR_OP)==3) {
        switch(EXPR_W(valueNode,EXPR_KIND)) {
        case 9:
            RTL_MEMMOVE(extended,MK_FP(EXPR_POOL_SEG,valueNode+EXPR_LEFT),10);
            RTL_LDOUBLE_TO_FLOAT(extended,single);
            for(index=0;(int)index<4;index++) emit(single[index]);
            break;
        case 10:
            RTL_MEMMOVE(extended,MK_FP(EXPR_POOL_SEG,valueNode+EXPR_LEFT),10);
            RTL_LDOUBLE_TO_DOUBLE(extended,wide);
            for(index=0;(int)index<8;index++) emit(wide[index]);
            break;
        case 11:
            for(index=0;(int)index<10;index++) {
                emit(((unsigned char far *)MK_FP(EXPR_POOL_SEG,valueNode+EXPR_LEFT))[index]);
            }
            break;
        }
    } else {
        value=valueNode;
        while(EXPR_W(value,EXPR_OP)==0x35) value=EXPR_W(value,EXPR_LEFT);
        if(EXPR_W(value,EXPR_OP)!=0x32 ||
           EXPR_W(EXPR_W(value,EXPR_LEFT),EXPR_OP)!=1)
            REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
        else {
            value=EXPR_W(value,EXPR_LEFT);
            switch(EXPR_W(valueNode,EXPR_KIND)) {
            /* A _seg pointer cannot be initialised with an address: fatal error (if REPORT_FATAL ever
               returned, the case would fall into the near-address hook). */
            case 14:
                REPORT_FATAL(MSG_ILLEGAL_INITIALIZATION);
            case 3: case 4: case 5: case 6: case 13: case 21:
                WORD_HOOK(EXPR_W(value,EXPR_LEFT),EXPR_W(value,EXPR_RIGHT));break;
            case 7: case 8: case 15: case 16:
                ALT_HOOK(EXPR_W(value,EXPR_LEFT),EXPR_W(value,EXPR_RIGHT));break;
            default:
                REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
            }
        }
    }
    RESET_EXPR_POOL_HOOK();
}

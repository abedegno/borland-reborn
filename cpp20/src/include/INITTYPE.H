#ifndef INITTYPE_H
#define INITTYPE_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"

/* Original eight-byte bank descriptor; canonical segment scalars remain extern. */
struct C9Bank {
    unsigned int segment,spare,used,limit;
};

/* POOL_INIT: a far pascal function with six bytes of arguments (retf 6). */
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);

/* New addresses whose actual native PUBLIC names are already occupied. */
/* Actual native PUBLIC ALLOC_LABEL_RECORD is unoccupied in the canonical namespace. */


/* Extern-only extension from the remaining original bodies. */
extern unsigned int SCOPE_POOL_SEG; /* the scope pool's segment, CPP DS:6DF6 */
extern unsigned char OPTION_BLOCK; /* CPP DS:0F2A */
extern unsigned char OPTION_MEMORY_MODEL; /* CPP DS:0F2B */
extern unsigned char NEAR_HELPER_CALLS;
extern unsigned char LANGUAGE_MODE; /* CPP DS:0F31 */
extern unsigned char UNSIGNED_CHAR; /* CPP DS:0F32 */
extern unsigned char OPTION_CALLING_CONVENTION; /* CPP DS:0F41 */
extern unsigned char OPTION_UNDERSCORES;
extern unsigned char OPTION_FLAGS; /* CPP DS:0F9E */
extern unsigned char OPTION_ENUMS_AS_INT; /* CPP DS:0FA0 */
extern unsigned int DEFAULT_CALL_CONVENTION; /* CPP DS:5788 */
extern unsigned int FUNCTION_BODY_DEPTH;
extern unsigned int BCC_TREE_SPECIAL;
extern unsigned int LOOP_CONTEXT;
extern unsigned int DIAG_NAME_BUFFER; /* CPP DS:581A */
extern unsigned int TOKEN_RECORD_STREAM;
extern unsigned int TOKEN_STREAM_POS;
extern unsigned int REPLAY_STREAM_1;
extern unsigned int FUNCTION_NAME_TEXT; /* CPP DS:773E */
extern unsigned char MODEL_FAR_CODE; /* CPP DS:6D9D */
extern unsigned int NAME_POOL_SEG; /* CPP DS:6DFE */

extern unsigned int near C9_TYPE_GRID[2][2][13];
extern unsigned int far *BCC_TYPE_PTR;
struct C9Token {
    char near *name;
    unsigned int flags;
    signed char type;
    unsigned char reserved[2];
};
extern struct C9Token PSEUDO_REGISTER_TABLE[];
struct C9Intrinsic {
    char near *name;
    signed char result;
    unsigned char reserved3;
    signed char count;
    unsigned char reserved5;
    signed char parameters[4];
};
extern struct C9Intrinsic INTRINSIC_TABLE[];
struct C9TokenName { unsigned int name,token; };
extern struct C9TokenName C9_TOKEN_NAMES[];
extern struct C9TokenName far *C9_TOKEN_END;
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);

#endif

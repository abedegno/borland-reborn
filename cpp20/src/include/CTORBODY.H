#ifndef CTORBODY_H
#define CTORBODY_H


/* (BCC.EXE: PARSE_ARGUMENT_LIST and FREE_EXPR_TREE were reached through overlay
   stubs; CPP.EXE has no overlays.) */

/* Extern-only extension: original native DS bindings. */
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern unsigned int CURRENT_TOKEN_VALUE;
extern unsigned int BCC_TREE_SPECIAL;

/* Six-byte original record is passed by value, invoking genuine F_SPUSH@. */
#include "BCCREC6.H"
#include "DATA.H"
#include "OVL.H"
extern struct C77Record6 NO_SOURCE_LOCATION;

extern unsigned int far pascal BUILD_INIT_CALL(unsigned int,unsigned int,unsigned int,
    unsigned char,unsigned char);
/* Actual native TYPE_LOOKUP_FAR name is occupied elsewhere in the canonical namespace. */
extern void far pascal C11_EXPECT(unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_EXPRESSION_BLOCK(unsigned int,struct C77Record6);
extern unsigned int far pascal MAKE_JUMP_IF_TRUE_BLOCK(unsigned int,unsigned int,struct C77Record6);
extern unsigned int far pascal MAKE_RETURN_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_RETURN_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_JUMP_IF_FALSE_BLOCK(unsigned int,unsigned int,struct C77Record6);
extern unsigned int far pascal BUILD_DESTRUCTOR_BODY(unsigned int,unsigned int,
    unsigned char,unsigned int);

#endif

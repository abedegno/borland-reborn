/* TOKEN.H: the parser's token codes.  Names and texts come from BCC's keyword
   table (C31_KEYWORD_GROUPS: the text BCC registers for each code, which
   follows on each line); TOK_IDENT is inferred from use.  The current token is
   CURRENT_TOKEN.  Generated during the readability pass. */
#ifndef TOKEN_H
#define TOKEN_H
#define TOK_LPAREN 0x01         /* '()' */
#define TOK_RPAREN 0x02         /* ')' */
#define TOK_LBRACKET 0x03       /* '[]' */
#define TOK_RBRACKET 0x04       /* ']' */
#define TOK_LBRACE 0x05         /* '{' */
#define TOK_RBRACE 0x06         /* '}' */
#define TOK_SEMICOLON 0x07      /* ';' */
#define TOK_COMMA 0x08          /* ',' */
#define TOK_ELLIPSIS 0x09       /* '...' */
#define TOK_ASSIGN 0x0B         /* '=' */
#define TOK_PLUS 0x16           /* '+' */
#define TOK_MINUS 0x17          /* '-' */
#define TOK_STAR 0x18           /* '*' */
#define TOK_AMPERSAND 0x1B      /* '&' */
#define TOK_COLON 0x21          /* ':' */
#define TOK_NOT 0x2A            /* '!' */
#define TOK_TILDE 0x2B          /* '~' */
#define TOK_SIZEOF 0x2C         /* 'sizeof' */
#define TOK_INC 0x2D            /* '++' */
#define TOK_DEC 0x2E            /* '--' */
#define TOK_DOT 0x2F            /* '.' */
#define TOK_IDENT 0x31          /* identifier (inferred: the token printed through its own name) */
#define TOK_STATIC 0x35         /* 'static' */
#define TOK_EXTERN 0x36         /* 'extern' */
#define TOK_TYPEDEF 0x37        /* 'typedef' */
#define TOK_CHAR 0x3A           /* 'char' */
#define TOK_SHORT 0x3B          /* 'short' */
#define TOK_INT 0x3C            /* 'int' */
#define TOK_UNSIGNED 0x3D       /* 'unsigned' */
#define TOK_SIGNED 0x3E         /* 'signed' */
#define TOK_LONG 0x3F           /* 'long' */
#define TOK_FLOAT 0x40          /* 'float' */
#define TOK_DOUBLE 0x41         /* 'double' */
#define TOK_STRUCT 0x42         /* 'struct' */
#define TOK_UNION 0x43          /* 'union' */
#define TOK_ENUM 0x44           /* 'enum' */
#define TOK_VOID 0x45           /* 'void' */
#define TOK_INTERRUPT 0x46      /* 'interrupt' */
#define TOK_PASCAL 0x47         /* 'pascal' */
#define TOK_CDECL 0x48          /* 'cdecl' */
#define TOK_CONST 0x4A          /* 'const' */
#define TOK_VOLATILE 0x4B       /* 'volatile' */
#define TOK_LOADDS 0x4C         /* '_loadds' */
#define TOK_SAVEREGS 0x4D       /* '_saveregs' */
#define TOK_EXPORT 0x4E         /* '_export' */
#define TOK_NEAR 0x4F           /* 'near' */
#define TOK_FAR 0x50            /* 'far' */
#define TOK_CS 0x51             /* '_cs' */
#define TOK_DS 0x52             /* '_ds' */
#define TOK_ES 0x53             /* '_es' */
#define TOK_SS 0x54             /* '_ss' */
#define TOK_SEG 0x55            /* '_seg' */
#define TOK_HUGE 0x56           /* 'huge' */
#define TOK_ASM 0x57            /* 'asm' */
#define TOK_GOTO 0x58           /* 'goto' */
#define TOK_IF 0x59             /* 'if' */
#define TOK_ELSE 0x5A           /* 'else' */
#define TOK_FOR 0x5B            /* 'for' */
#define TOK_WHILE 0x5C          /* 'while' */
#define TOK_DO 0x5D             /* 'do' */
#define TOK_SWITCH 0x5E         /* 'switch' */
#define TOK_RETURN 0x5F         /* 'return' */
#define TOK_BREAK 0x60          /* 'break' */
#define TOK_CONTINUE 0x61       /* 'continue' */
#define TOK_DEFAULT 0x62        /* 'default' */
#define TOK_CASE 0x63           /* 'case' */
#define TOK_SCOPE 0x67          /* '::' */
#define TOK_CLASS 0x68          /* 'class' */
#define TOK_DELETE 0x69         /* 'delete' */
#define TOK_FRIEND 0x6A         /* 'friend' */
#define TOK_INLINE 0x6B         /* 'inline' */
#define TOK_NEW 0x6C            /* 'new' */
#define TOK_OPERATOR 0x6D       /* 'operator' */
#define TOK_OVERLOAD 0x6E       /* 'overload' */
#define TOK_PRIVATE 0x6F        /* 'private' */
#define TOK_PROTECTED 0x70      /* 'protected' */
#define TOK_PUBLIC 0x71         /* 'public' */
#define TOK_THIS 0x72           /* 'this' */
#define TOK_VIRTUAL 0x73        /* 'virtual' */
/* codes used throughout but not in the keyword table (from the lexer and parser; marked probably where inferred) */
#define TOK_QUESTION 0x20       /* '?' (probably) */
#define TOK_INT_CONST 0x32      /* integer constant */
#define TOK_FLOAT_CONST 0x33    /* floating constant */
#define TOK_STRING 0x34         /* string literal */
#define TOK_REGISTER 0x38       /* register */
#define TOK_AUTO 0x39           /* auto */
#define TOK_CHAR_CONST 0x65     /* character constant */
#define TOK_NONE 0x82           /* no token */
#endif

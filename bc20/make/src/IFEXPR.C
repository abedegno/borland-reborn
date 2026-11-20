/* target: IFEXPR */
/* opts: -mc -O -Z -d -a -y */
/* IFEXPR.C: the expressions of !if and !elif, after macro expansion (MACRO.C): C's
 * operators on long integers, with numbers in decimal, octal (0...) and hex (0x...),
 * character constants, and names, which count as 0. ifexpr() is the only entry; expr()
 * climbs operator precedence (prectab, assoctab) and the ternary ?: works through
 * trueval and falseval, which ':' sets and '?' chooses from. The -a switch shows in the 0
 * byte before escchar()'s switch table. */
#include <ctype.h>
#include "MAKE.H"

/* tokens; the operators' codes index prectab */
#define T_ERR		-1
#define T_END		0
#define T_PLUS		1
#define T_MINUS		2
#define T_MUL		3
#define T_DIV		4
#define T_MOD		5
#define T_AND		6
#define T_OR		7
#define T_XOR		8
#define T_SHL		9
#define T_SHR		10
#define T_QUEST		11
#define T_COLON		12
#define T_EQ		13
#define T_NE		14
#define T_LT		15
#define T_GT		16
#define T_LE		17
#define T_GE		18
#define T_ANDAND	19
#define T_OROR		20
#define T_NUM		21
#define T_NOT		22
#define T_COMPL		23
#define T_LPAREN	24
#define T_RPAREN	25

/* character classes in chclass: a character that is a token by itself has the token's code
 * there; the others have one of these */
#define C_BANG		-20		/* ! or != */
#define C_GT		-19		/* > >> >= */
#define C_EQ		-18		/* == */
#define C_LT		-17		/* < << <= */
#define C_QUOTE		-14		/* a character constant */
#define C_ALPHA		-13		/* a name */
#define C_AMP		-12		/* & && */
#define C_DIGIT		-11		/* a number */
#define C_BAR		-10		/* | || */
#define C_BLANK		-9
#define C_BAD		-8

int chclass[128] = {
	-8, -8, -8, -8, -8, -8, -8, -8, -8, -9, -9, -9, -9, -8, -8, -8,
	-8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8, -8,
	-9, -20, -8, -8, -8, 5, -12, -14, 24, 25, 3, 1, -8, 2, -8, 4,
	-11, -11, -11, -11, -11, -11, -11, -11, -11, -11, 12, -8, -17, -18, -19, 11,
	-8, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13,
	-13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -8, -8, -8, 8, -13,
	-8, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13,
	-13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -13, -8, -10, -8, 23, -8
};

char prectab[21] = {
	0, 12, 12, 13, 13, 13, 8, 6, 7, 11, 11, 3, 3, 9, 9, 10, 10, 10, 10, 5, 4
};

char assoctab[14] = {
	0, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
};

long numval;			/* the value of the T_NUM token just read */
int curtok;			/* the token just read */
char *lexpos;			/* where lex() reads */
long falseval;			/* the operands of ?: */
int errflag;			/* stops the evaluation after an error */
long trueval;

void lex(void);
long term(void);
long pascal expr(register int prec);

int pascal ifexpr(char *s)
{
	long v;

	if (debug)
		msg("#if buffer = %s\n", s);
	lexpos = s;
	v = expr(0);
	if (curtok > 0)
		error(syntaxmsg);
	if (curtok > 0 || errflag)
		return 0;
	return v != 0;
}

long term(void)
{
	long x;

	switch (curtok) {
	case T_MINUS:
		lex();
		x = -term();
		break;
	case T_NOT:
		lex();
		x = !term();
		break;
	case T_COMPL:
		lex();
		x = ~term();
		break;
	case T_LPAREN:
		x = expr(0);
		if (errflag)
			break;
		if (curtok != T_RPAREN) {
			(void)0;	/* match: keeps the test as a jump over a jump */
			goto bad;
		}
		lex();
		(void)0;	/* match: keeps this lex() call apart from the one in case T_NUM */
		break;
	case T_NUM:
		x = numval;
		lex();
		break;
	default:
	bad:
		error(syntaxmsg);
		errflag = 1;
	}
	if (debug)
		msg("term = %ld Lex = %d\n", x, curtok);
	return x;
}

long pascal expr(register int prec)
{
	long x;
	long y;
	int assoc;
	int op;
	register int oprec;

	lex();
	if (errflag)
		return 0;
	x = term();
	if (errflag)
		return 0;
	assoc = assoctab[prec];
	for (;;) {
		if (debug)
			msg("expr x = %ld Lex = %d\n", x, curtok);
		if (curtok > T_OROR || curtok <= T_END)
			break;
		oprec = prectab[curtok];
		op = curtok;
		if (oprec == 0)
			break;
		if (prec > oprec)
			break;
		if (prec == oprec && assoc == 1)
			break;
		y = expr(oprec);
		if (debug)
			msg("expr y = %ld Lex = %d\n", y, curtok);
		if (errflag)
			return 0;
		switch (op) {
		case T_PLUS:
			x += y;
			break;
		case T_MINUS:
			x -= y;
			break;
		case T_MUL:
			x *= y;
			break;
		case T_AND:
			x &= y;
			break;
		case T_OR:
			x |= y;
			break;
		case T_XOR:
			x ^= y;
			break;
		case T_EQ:
			x = x == y;
			break;
		case T_NE:
			x = x != y;
			break;
		case T_GT:
			x = x > y;
			break;
		case T_LT:
			x = x < y;
			break;
		case T_GE:
			x = x >= y;
			break;
		case T_LE:
			x = x <= y;
			break;
		case T_SHL:
			x <<= y;
			break;
		case T_SHR:
			x >>= y;
			break;
		case T_ANDAND:
			x = x && y;
			break;
		case T_OROR:
			x = x || y;
			break;
		case T_COLON:
			trueval = x;
			falseval = y;
			break;
		case T_QUEST:
			if (x)
				x = trueval;
			else {
				x = falseval;
				(void)1;	/* match: the (void)N statements keep these stores apart; each N differs so that they do not match each other */
			}
			break;
		case T_DIV:
			if (y == 0) {
				(void)0;	/* match: keeps the test as a jump over a jump */
				goto divzero;
			}
			x /= y;
			(void)2;	/* match: see (void)1 */
			break;
		case T_MOD:
			if (y == 0) {
			divzero:
				error(divzeromsg);
				errflag = 1;
			} else {
				x %= y;
				(void)3;	/* match: see (void)1 */
			}
			break;
		}
	}
	return x;
}

int symbol(void);
int number(void);
int charconst(void);

void lex(void)
{
	register int c;
	register int cls;

	for (;;) {
		c = *lexpos++;
		if (c == 0) {
			curtok = T_END;
			return;
		}
		cls = chclass[c];
		switch (cls) {
		default:
			curtok = cls;
			return;
		case C_EQ:
			c = *lexpos++;
			if (c == '=') {
				curtok = T_EQ;
				return;
			}
			/* a lone = is as bad as an unknown character */
		case C_BAD:
			error(badcharmsg, c);
			errflag = 1;
			curtok = T_ERR;
			return;
		case C_BANG:
			c = *lexpos++;
			if (c == '=') {
				curtok = T_NE;
				return;
			}
			lexpos--;
			curtok = T_NOT;
			return;
		case C_ALPHA:
			curtok = symbol();
			return;
		case C_DIGIT:
			curtok = number();
			return;
		case C_QUOTE:
			curtok = charconst();
			return;
		case C_LT:
			c = *lexpos++;
			if (c == '<') {
				curtok = T_SHL;
				return;
			}
			if (c == '=') {
				curtok = T_LE;
				return;
			}
			lexpos--;
			curtok = T_LT;
			return;
		case C_AMP:
			c = *lexpos++;
			if (c == '&') {
				curtok = T_ANDAND;
				return;
			}
			lexpos--;
			curtok = T_AND;
			return;
		case C_BAR:
			c = *lexpos++;
			if (c == '|') {
				curtok = T_OROR;
				return;
			}
			lexpos--;
			curtok = T_OR;
			return;
		case C_GT:
			c = *lexpos++;
			if (c == '>') {
				curtok = T_SHR;
				return;
			}
			if (c == '=') {
				curtok = T_GE;
				return;
			}
			lexpos--;
			curtok = T_GT;
			return;
		case C_BLANK:
			continue;
		}
	}
}

int symbol(void)
{
	char *p;

	for (p = lexpos; chclass[*p] == C_ALPHA || chclass[*p] == C_DIGIT; p++)
		;
	lexpos = p;
	numval = 0;
	return T_NUM;
}

int number(void)
{
	int c;
	char *start;
	register int base;

	lexpos--;
	if (*lexpos == '0') {
		lexpos++;
		if (*lexpos == 'x' || *lexpos == 'X') {
			lexpos++;
			base = 16;
		} else
			base = 8;
	} else
		base = 10;
	start = lexpos;
	for (; *lexpos; lexpos++) {
		c = tolower(*lexpos);
		if (chclass[*lexpos] == C_DIGIT)
			continue;
		if (base == 16 && c >= 'a' && c <= 'f') {
			*lexpos = c;
			continue;
		}
		if (c == 'l') {
			*lexpos = c;
			lexpos++;
		}
		break;
	}
	numval = 0;
	for (; start < lexpos; start++) {
		if (*start == 'l')
			break;
		if (base == 8 && *start > '7') {
			error(octalmsg);
			errflag = 1;
			break;
		}
		*start = *start >= 'a' ? *start - ('a' - 10) : *start - '0';
		numval = numval * base + *start;
	}
	return T_NUM;
}

int pascal escchar(int quote);

int charconst(void)
{
	int c;
	int val;
	register int n;

	val = 0;
	n = 0;
	while ((c = escchar('\'')) != -1) {
		if (n < 2)
			((char *)&val)[n] = c;
		n++;
	}
	if (n >= 2)
		error(charlongmsg);
	numval = val;
	return T_NUM;
}

int pascal escchar(int quote)
{
	register int c;
	register int v;

	c = *lexpos++;
	if (c == -1)
		return -1;
	if (c == quote)
		return -1;
	if (c != '\\')
		goto ret;	/* match: see ret: below */
	c = *lexpos++;
	if (c == -1)
		return -1;
	switch (c) {
	case 't':
		return 9;
	case 'n':
		return 10;
	case 'b':
		return 8;
	case 'r':
		return 13;
	case 'f':
		return 12;
	}
	if (c >= '0' && c <= '7') {
		v = c - '0';
		c = *lexpos++;
		if (c < '0' || c > '7')
			lexpos--;
		else {
			v = v * 8 + c - '0';
			c = *lexpos++;
			if (c < '0' || c > '7')
				lexpos--;
			else
				v = v * 8 + c - '0';
		}
		return v;
	}
	return c;	/* match: a second return c, tail-merged into the one below as a jump the
			   original keeps */
ret:
	return c;
}

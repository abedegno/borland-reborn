/* target: T_UNMANGLE */
/* opts: -mc -p -zCUNMANGLE_TEXT */
/* UNMANGLE.C: TLINK's C++ name demangler.  UNMANGLE turns a Borland C++ 2.0
   mangled name ("@class@member$qi") back into C++ ("class::member(int)") for
   TLINK's messages and map file.

   The mangled form: '@', the class name (absent for a plain function), '@',
   the member name, then '$q' and the argument types.  A member name that
   starts with "$b" is an operator or a constructor ("$bctr") or destructor
   ("$bdtr"); one that starts with "$o" is a conversion operator, whose
   target type follows.  Types: v void, c char, s short, i int, l long,
   f float, d double, g long double, e "..."; prefixes u unsigned, z signed
   (printed as nothing), x const, w volatile, up huge, ur _seg; p/r near
   pointer/reference, m/n far pointer/reference; a<dim>$ array; q<args>$<ret>
   function; a decimal length then that many characters: a class name;
   t<digit> repeats an earlier argument type (1-9, then a-z for 10-35).

   Built by Borland C++ 2.0 in the compact model (near code, far data) with
   pascal calls and no optimisation; the stack is its own segment, so
   pointers into the argument arena are _ss pointers.  The string routines
   are the run-time library's far pascal ones (RSCPY.C and its siblings),
   and errors leave through SETJMP/LONGJMP (SETJMP.ASM): a malformed name
   jumps back to UNMANGLE, which ends the text with "...". */

/* the run-time library's string and memory routines (far pascal) */
extern int far pascal COMPARE_NAME(char far *a, char far *b);
extern unsigned far pascal STRING_LENGTH(char far *string);
extern char far * far pascal STRING_COPY(char far *destination, char far *source);
extern char far * far pascal RTL_STRNCPY(char far *destination, char far *source,
	unsigned n);
extern void far pascal RTL_MEMMOVE(void far *destination, void far *source,
	unsigned count);
extern char far * far pascal STRING_APPEND(char far *destination, char far *source);
extern int far pascal LOWER_CASE(int c);	/* CHARCASE.C */

/* SETJMP.ASM: a jump buffer holds 10 words */
typedef unsigned JUMP_BUFFER[10];
extern int far pascal SETJMP(JUMP_BUFFER far *buffer);
extern void far pascal LONGJMP(JUMP_BUFFER far *buffer, int value);

extern char cdecl _ctype[];	/* the character table (CTYPE.ASM) */
#define IS_DIGIT(c)	(_ctype[(c) + 1] & 2)
#define IS_LOWER(c)	(_ctype[(c) + 1] & 8)
#define IS_ALNUM(c)	(_ctype[(c) + 1] & (2 | 4 | 8))

/* operator names: the mangled spelling after "$b", and the C++ one */
static struct {
	char _ds *mangled;
	char _ds *name;
} operators[] = {
	{ "add", "+" }, { "adr", "&" }, { "and", "&" }, { "asg", "=" },
	{ "land", "&&" }, { "lor", "||" }, { "call", "()" }, { "cmp", "~" },
	{ "dec", "--" }, { "dele", "delete" }, { "div", "/" }, { "eql", "==" },
	{ "geq", ">=" }, { "gtr", ">" }, { "inc", "++" }, { "ind", "*" },
	{ "leq", "<=" }, { "lsh", "<<" }, { "lss", "<" }, { "mod", "%" },
	{ "mul", "*" }, { "neq", "!=" }, { "new", "new" }, { "not", "!" },
	{ "or", "|" }, { "rand", "&=" }, { "rdiv", "/=" }, { "rlsh", "<<=" },
	{ "rmin", "-=" }, { "rmod", "%=" }, { "rmul", "*=" }, { "ror", "|=" },
	{ "rplu", "+=" }, { "rrsh", ">>=" }, { "rsh", ">>" }, { "rxor", "^=" },
	{ "sub", "-" }, { "subs", "[]" }, { "xor", "^" }, { "arow", "->" },
	{ 0, 0 }
};

static unsigned arena_room;		/* free bytes in the argument arena */
static char _ss *arena_next;		/* its next free byte (UNMANGLE's stack) */
/* name: the three statics are named so that BCC's _BSS order (a hash of the name)
   is TLINK.EXE's: arena_room, arena_next, failed. */
static JUMP_BUFFER failed;		/* where a malformed name jumps to */

/* the C++ spelling of operator `name' (the part after "$b") */
static char _ds * near pascal operator_name(char far *name)
{
	struct { char _ds *mangled; char _ds *name; } far *p;

	for (p = (void far *)operators; p->mangled && COMPARE_NAME(p->mangled, name);
	     p++)
		;
	if (p->mangled == 0)
		LONGJMP(&failed, 1);
	return p->name;
}

/* Reads a decimal length at *pp and the name of that many characters after
   it.  The name is moved down over the last digit and given a terminating
   0, so that *pp ends up pointing at it as a string. */
static void near pascal read_length(char far * far *pp, unsigned far *length)
{
	char far *p = *pp;
	register int n = 0;

	do {
		n = n * 10 + *p - '0';
		p++;
	} while (IS_DIGIT(*p));
	if (STRING_LENGTH(p) < n)
		LONGJMP(&failed, 1);
	p--;
	RTL_MEMMOVE(p, p + 1, n);
	p[n] = 0;
	*pp = p;
	*length = n;
}

static void near pascal decode_arguments(char far * far *source,
	char far * far *destination, unsigned far *room);

/* Decodes one type at *source into *destination (at most *room characters),
   with `name' (a declarator such as " near", or 0) placed where C++ puts it:
   "int near*" for a pointer, "void (near*)(int)" for a pointer to a
   function. */
static void near pascal decode_type(char far * far *source,
	char far * far *destination, unsigned far *room, char far *name)
{
	register unsigned n;
	register int is_function;
	char far *word;
	char far *s;
	char far *d;
	unsigned length;
	char far *qualifier;

	s = *source;
	d = *destination;
	qualifier = 0;
	/* prefixes */
	for (;;) {
		switch (*s) {
		case 'u':
			if (s[1] == 'p')
				qualifier = " huge ";
			else if (s[1] == 'r')
				qualifier = " _seg ";
			else
				word = "unsigned ";
			break;
		case 'z':
			word = "";
			break;
		case 'x':
			word = "const ";
			break;
		case 'w':
			word = "volatile ";
			break;
		default:
			goto basic;
		}
		s++;
		if (qualifier == 0) {
			length = STRING_LENGTH(word);
			if (*room >= length) {
				STRING_COPY(d, word);
				d += length;
				*room -= length;
			} else
				*room = 0;
			*d = 0;
		}
	}
basic:
	switch (*s) {
	case 'v':
		word = "void";
		break;
	case 'c':
		word = "char";
		break;
	case 's':
		word = "short";
		break;
	case 'i':
		word = "int";
		break;
	case 'l':
		word = "long";
		break;
	case 'f':
		word = "float";
		break;
	case 'd':
		word = "double";
		break;
	case 'g':
		word = "long double";
		break;
	case 'e':
		word = "...";
		break;
	default:
		goto compound;
	}
	length = STRING_LENGTH(word);
	if (*room >= length) {
		STRING_COPY(d, word);
		d += length;
		*room -= length;
	} else
		*room = 0;
	s++;
	goto done;
compound:
	if (IS_DIGIT(*s)) {
		/* a class name */
		read_length(&s, &length);
		if (*room >= length) {
			STRING_COPY(d, s);
			d += length;
			*room -= length;
		} else
			*room = 0;
		s += length + 1;
	} else if (*s == 'p' || *s == 'r' || *s == 'm' || *s == 'n') {
		/* a pointer or a reference: the type pointed to, then the
		   declarator */
		int is_reference;
		char is_const, is_volatile;
		char far *t;

		is_reference = 0;
		if (qualifier == 0) {
			is_reference = *s == 'r' || *s == 'm';
			if (*s == 'p' || *s == 'r')
				qualifier = " near";
			else
				qualifier = " far";
		}
		s++;
		t = s;
		is_const = is_volatile = 0;
		for (;;) {
			if (*t == 'x')
				is_const = 1;
			else if (*t == 'w')
				is_volatile = 1;
			else
				break;
			t++;
		}
		is_function = 0;
		if (*t == 'q') {
			/* a pointer to a function: "(near*)", and a const or
			   volatile member function's qualifiers after it */
			is_function++;
			qualifier++;
			s = t;
		}
		decode_type(&s, &d, room, qualifier);
		if (is_function) {
			if (is_const && *room > 6) {
				STRING_COPY(d, " const");
				d += 6;
				*room -= 6;
			}
			if (is_volatile && *room > 9) {
				STRING_COPY(d, " volatile");
				d += 9;
				*room -= 9;
			}
		} else {
			if (!IS_ALNUM(d[-1]))
				qualifier++;	/* no space after a '*' or ')' */
			n = STRING_LENGTH(qualifier);
			if (*room > n) {
				STRING_COPY(d, qualifier);
				d += n;
				*d++ = is_reference ? '&' : '*';
				*room -= n + 1;
			}
		}
	} else if (*s == 'a') {
		/* an array: the element type, then the dimensions */
		char dimensions[90];

		n = 0;
		do {
			dimensions[n++] = '[';
			s++;
			if (*s == '0')
				s++;
			while (*s && *s != '$')
				dimensions[n++] = *s++;
			if (*s)
				s++;
			dimensions[n++] = ']';
		} while (*s == 'a');
		dimensions[n] = 0;
		decode_type(&s, &d, room, 0);
		if (*room >= n + 2) {
			STRING_COPY(d, dimensions);
			d += n;
			*room -= n;
		} else if (*room >= 2) {
			*d++ = '[';
			*d++ = ']';
			*d = 0;
			*room -= 2;
		} else
			*room = 0;
	} else if (*s == 'q') {
		/* a function: "(name*)(arguments)", then the return type
		   moved to the front */
		char far *t;

		t = d;
		s++;
		if (*room >= 3) {
			*d++ = '(';
			if (name) {
				n = STRING_LENGTH(name);
				if (*room >= n + 2) {
					STRING_COPY(d, name);
					d += n;
					*room -= n;
				}
			}
			*d++ = '*';
			*d++ = ')';
			*room -= 3;
			*d = 0;
		} else
			*room = 0;
		decode_arguments(&s, &d, room);
		if (*s == '$') {
			char far *start;
			char returned[64];

			s++;
			start = d;
			decode_type(&s, &d, room, 0);
			n = STRING_LENGTH(start);
			if (n < 64) {
				STRING_COPY(returned, start);
				RTL_MEMMOVE(t + n, t, start - t);
				RTL_MEMMOVE(t, returned, n);
			}
		}
	} else if (*s)
		LONGJMP(&failed, 1);
done:
	*d = 0;
	*source = s;
	*destination = d;
	return;
}

/* Decodes an argument list at *source: "(int,char near*)".  Each argument
   type is also kept in the arena, so that a later "t<n>" can repeat it. */
static void near pascal decode_arguments(char far * far *source,
	char far * far *destination, unsigned far *roomp)
{
	register int count;
	register int k;
	char far *s;
	char far *d;
	unsigned room;
	unsigned length;
	unsigned saved_room;
	char _ss *saved_arena;
	char far *start;
	unsigned size;
	char _ss *arguments[36];

	s = *source;
	d = *destination;
	room = *roomp;
	count = 0;
	saved_room = arena_room;
	saved_arena = arena_next;
	if (room > 0) {
		*d++ = '(';
		room--;
		*d = 0;
	}
	if (*s == 'v')
		s++;
	else
		for (;;) {
			count++;
			arguments[count] = 0;
			if (*s == 't') {
				s++;
				if (IS_DIGIT(*s))
					k = *s - '0';
				else if (IS_LOWER(*s))
					k = *s - ('a' - 10);
				else
					LONGJMP(&failed, 1);
				if (*s)
					s++;
				if (arguments[k]) {
					length = STRING_LENGTH(arguments[k]);
					if (room >= length) {
						STRING_COPY(d, arguments[k]);
						d += length;
						room -= length;
					} else
						room = 0;
				} else
					LONGJMP(&failed, 1);
			} else {
				start = d;
				decode_type(&s, &d, &room, 0);
				size = STRING_LENGTH(start) + 1;
				if (arena_room >= size) {
					arguments[count] = arena_next;
					STRING_COPY(arena_next, start);
					arena_next += size;
					arena_room -= size;
				}
			}
			if (!IS_ALNUM(*s))
				break;
			if (room > 0) {
				*d++ = ',';
				*d = 0;
				room--;
			}
		}
	if (room > 0) {
		*d++ = ')';
		room--;
	}
	*d = 0;
	arena_room = saved_room;
	arena_next = saved_arena;
	*source = s;
	*destination = d;
	*roomp = room;
}

/* Demangles `name' into buffer (size bytes; with a member's arguments when
   arguments is nonzero) and copies the class name to classname and the
   member name to member, either of which may be 0.  A name that does not
   start with '@' is copied as it is.  Returns 0 for a plain name, 1 for a
   member function or data, 2 a constructor, 3 a destructor, 4 an operator,
   5 a conversion operator, 6 a member without arguments. */
int far pascal UNMANGLE(char far *name, char far *buffer, register int size,
	char far *classname, char far *member, int arguments)
{
	register int kind;
	char far *p;
	char far *out;
	char far *member_name;
	char far *class_name;
	unsigned length;
	unsigned room;
	char is_const, is_volatile;
	char arena_space[128];
	char copy[64];

	if (name == 0)
		return 0;
	if (*name != '@') {
		STRING_COPY(buffer, name);
		return 0;
	}
	RTL_STRNCPY(copy, name, 62);
	copy[62] = 0;
	/* a name in upper case only (from an object file made with /U) is
	   brought to lower case */
	for (p = copy + 1; *p; p++)
		if (*p >= 'a' && *p <= 'z')
			goto cased;
	for (p = copy + 1; *p; p++)
		*p = LOWER_CASE(*p);
cased:
	p = copy + 1;
	if (*p == '$' && (p[1] == 'b' || p[1] == 'o'))
		p += 3;
	while (*p && *p != '@' && *p != '$')
		p++;
	if (*p == 0) {
		if (buffer)
			STRING_COPY(buffer, name);
		if (member)
			STRING_COPY(member, name);
		return 0;
	}
	if (*p == '@') {
		*p++ = 0;
		class_name = copy + 1;
		while (IS_DIGIT(*p))
			p++;
		member_name = p;
		if (*p == '$' && (p[1] == 'b' || p[1] == 'o'))
			p += 3;
		while (*p && *p != '$')
			p++;
		if (*p == 0) {
			kind = 6;
			goto named;
		}
	} else {
		class_name = 0;
		member_name = copy + 1;
	}
	*p++ = 0;
	if (*member_name == '$') {
		member_name += 2;
		if (member_name[-1] == 'b') {
			if (COMPARE_NAME(member_name, "ctr") == 0)
				kind = 2;
			else if (COMPARE_NAME(member_name, "dtr") == 0)
				kind = 3;
			else
				kind = 4;
		} else
			kind = 5;
	} else
		kind = 1;
named:
	if (classname)
		STRING_COPY(classname, class_name);
	if (member) {
		if (buffer == 0) {
			out = member;
			arguments = 0;
			goto spell;
		}
		STRING_COPY(member, member_name);
	}
	if (buffer == 0)
		return kind;
	out = buffer;
	room = size - 1;
	if (SETJMP(&failed)) {
overflow:
		buffer[size - 4u] = 0;	/* room for "..." (match: unsigned 4) */
		STRING_APPEND(out, "...");
		return kind;
	}
	arena_next = arena_space;
	arena_room = 128;
	if (class_name) {
		length = STRING_LENGTH(class_name);
		STRING_COPY(out, class_name);
		out += length;
		*out++ = ':';
		*out++ = ':';
		room -= length + 2;
	}
spell:
	switch (kind) {
	case 3:
		*out++ = '~';
		/* falls through: the class name */
	case 2:
		STRING_COPY(out, class_name);
		break;
	case 4:
		STRING_COPY(out, "operator ");
		out += 9;
		STRING_COPY(out, operator_name(member_name));
		break;
	case 5:
		STRING_COPY(out, "operator ");
		out += 9;
		room -= 9;
		decode_type(&member_name, &out, &room, 0);
		kind = 5;
		break;
	case 1:
	case 6:
		STRING_COPY(out, member_name);
		break;
	}
	if (!arguments)
		return kind;
	out += STRING_LENGTH(out);
	room = buffer + size - out - 1;
	if (room < 0)
		room = 0;
	is_const = is_volatile = 0;
	for (;;) {
		if (*p == 'x')
			is_const = 1;
		else if (*p == 'w')
			is_volatile = 1;
		else
			break;
		p++;
	}
	if (*p == 'q') {
		p++;
		decode_arguments(&p, &out, &room);
	}
	if (is_const) {
		if (room < 6)
			goto overflow;
		STRING_APPEND(out, " const");
	}
	if (is_volatile) {
		if (room < 9)
			goto overflow;
		STRING_APPEND(out, " volatile");
	}
	return kind;
}

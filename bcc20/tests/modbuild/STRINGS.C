/* modtest: -ml */
/* modes: -c -S */
/* Strings made by macro expansion (stringizing and __FILE__) with escapes and quotes in
   them, adjacent literals, an unterminated string and character constant. */
#define STR(x) #x
#define XSTR(x) STR(x)
char *a = STR("quoted \"inner\" \n \x41\101 \\");
char *b = STR('\'' "\t");
char *c = XSTR(__FILE__);
char *d = __FILE__ "tail";
char *e = STR(a\nb) STR(\x7) STR(\101);
char *f = "unterminated
char g = 'x
int ok;

/* target: MSGS */
/* opts: -mc -O -Z -d -a -y */
/* MSGS.C: MAKE's messages, a file of data only: the other files push them by address.
 * macrolongmsg is never used. */
#include "MAKE.H"

char errsmsg[] = "*** %d errors during make ***\n";
char fatalmsg[] = "Fatal";
char errormsg[] = "Error";
char nohowmsg[] = "'%s' does not exist - don't know how to make it";
char execmsg[] = "Unable to execute command: %s";
char badarg[] = "Incorrect command line argument: %s";
char nomakemsg[] = "Unable to open makefile";
char nomemmsg[] = "Not enough memory";
char errdirmsg[] = "Error directive: %s";
char redirmsg[] = "Unable to redirect input or output";
char notermmsg[] = "No terminator specified for in-line file operator";
char circmsg[] = "Circular dependency exists in makefile";
char toolongmsg[] = "Command arguments too long";
char ifeofmsg[] = "Unexpected end of file in conditional started at line %d";
char baddirmsg[] = "Unknown preprocessor statement";
char badincmsg[] = "Bad filename format in include statement";
char longnamemsg[] = "Filename too long";
char noendmsg[] = "No filename ending";
char noincmsg[] = "Unable to open include file '%s'";
char macrolongmsg[] = "Macro expansion too long";
char iflongmsg[] = "If statement too long";
char cmdlongmsg[] = "Command too long";
char rulelongmsg[] = "Rule line too long";
char badundefmsg[] = "Bad undef statement syntax";
char elsemsg[] = "Misplaced else statement";
char cmdsyntaxmsg[] = "Command syntax error";
char elifmsg[] = "Misplaced elif statement";
char endifmsg[] = "Misplaced endif statement";
char badcharmsg[] = "Illegal character in constant expression '%c'";
char syntaxmsg[] = "Expression syntax error in !if statement";
char octalmsg[] = "Illegal octal digit";
char charlongmsg[] = "Character constant too long";
char divzeromsg[] = "Division by zero";
char redefmsg[] = "Redefinition of target '%s'";
char badtransmsg[] = "Bad macro output translator";

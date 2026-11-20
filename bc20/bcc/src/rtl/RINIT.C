/* target: CODE_1_RINIT */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: LINE_HOOK. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: what BCC does after the user presses Ctrl-Break.  The INT 1Bh
   handler (RIRQ1B.C) only sets CTRL_BREAK_SEEN.  The lexer at each new
   line (lexer/LEXER.C) and two long code generator loops (CROSSJMP.C,
   EMITFUNC.C) test the flag and call LINE_HOOK, so BCC stops at a point
   where its data is consistent.  LINE_HOOK runs the Ctrl-C cleanup
   (RCTRL23.C) and ends the program with EXIT(0x100).  EXIT passes only the
   low byte of the status to DOS, so the DOS exit code is 0.  The context
   lines are build directives naming the files whose static functions this
   one calls. */
/* context: RVECSET.C */
/* context: RCTRL23.C */
/* context: REXIT09F.C */
/* context-helper-entry: RVECSET.C RVECSET */
/* context-helper-entry: RCTRL23.C RCTRL23 */
/* context-call: 0x3 RCTRL23 CTRL_C_HANDLER_ENTRY */
/* context-call: 0xB EXIT EXIT_BODY */
/* Normal no-argument caller. The handler's carry result is ignored; EXIT
   receives the original full WORD 0100h, not an invented byte formal. */
void far pascal LINE_HOOK(void)
{
    RCTRL23();
    EXIT(0x100);
}

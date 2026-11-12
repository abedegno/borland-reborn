/* target: CODE_1_RCTRL23 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: BCC's Ctrl-C handler and its emergency cleanup.  RMAIN13C
   installs the code at CTRL_C_HANDLER_ENTRY (this function, per the
   context-call line in RINIT.C) as the INT 23h vector, and RUN_PROGRAM (RDRV388.C)
   takes it out while TASM or TLINK runs.  RCTRL23 puts back the INT 18h
   and INT 1Bh vectors saved at startup, closes and deletes a half-written
   output file (DISCARD_OUTPUT_FILE, RFILEIO.C) and releases the EMS and
   extended memory banks (SHUTDOWN_HEAP_BANKS).  It then returns far with
   the carry flag set; DOS takes a far return with carry set from an
   INT 23h handler as "abort the program".  LINE_HOOK (RINIT.C) also calls
   it directly after a Ctrl-Break, and ignores the carry.  The context
   lines above are build directives naming the file whose static RVECSET
   this one calls (RVECSET.C).  No standard C function corresponds. */
/* context: RVECSET.C */
/* context-helper-entry: RVECSET */
/* context-call: 0x15 RVECSET RVECSET_BODY */
/* context-call: 0x25 RVECSET RVECSET_BODY */
/* Actual callback protocol: _loadds preserves DS and selects DGROUP for
   the C cleanup calls, and far-return with carry set. This is not IRET. */
typedef void far *RawAddress;
extern RawAddress SAVED_INT18_VECTOR;
extern RawAddress SAVED_INT1B_VECTOR;
extern void far pascal DISCARD_OUTPUT_FILE(void);
extern void far pascal SHUTDOWN_HEAP_BANKS(void);
static void far pascal _loadds RCTRL23(void)
{
    RVECSET(0x18,SAVED_INT18_VECTOR);
    RVECSET(0x1B,SAVED_INT1B_VECTOR);
    DISCARD_OUTPUT_FILE();
    SHUTDOWN_HEAP_BANKS();
    asm stc;
}

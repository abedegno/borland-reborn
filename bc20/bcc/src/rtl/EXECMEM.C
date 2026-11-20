/* target: CODE_5_R5PAIR */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library: shrinks BCC's memory (heap fully, then program top) before
   running TASM or TLINK, and grows it back afterwards. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the two memory steps around running an external program.
   RUN_PROGRAM in driver/RDRV388.C calls SHRINK_MEMORY_FOR_EXEC just before
   RTL_EXEC starts TASM or TLINK, and RESTORE_MEMORY_AFTER_EXEC just after
   it returns.  Shrinking gives the far heap's unused top back (heap code
   in heap/HPSHRNKH.C) and then cuts BCC's DOS memory block down to the new
   heap top with SET_PROGRAM_TOP (SETTOP.C), so the child program gets the
   freed memory.  Restoring grows the DOS block as far as it will go and
   then lets the heap grow back (heap/HPGROW.C).  No standard C function
   corresponds; it is BCC's own glue. */
extern unsigned int far pascal SHRINK_HEAP_FULLY(void);
extern unsigned int near pascal SET_PROGRAM_TOP(unsigned int);
extern void far pascal GROW_HEAP_TO(unsigned int);
/* Shrink the heap as far as it goes; SHRINK_HEAP_FULLY returns the new top
   paragraph, and SET_PROGRAM_TOP resizes the DOS block to end there. */
static void far pascal SHRINK_MEMORY_FOR_EXEC(void)
{
    SET_PROGRAM_TOP(SHRINK_HEAP_FULLY());
}
/* Ask for a top of FFFFh, which DOS refuses: SET_PROGRAM_TOP then returns
   the largest top it can have.  The second call sets that top and returns
   0 on success.  GROW_HEAP_TO(0) grows the heap back to the top it saved
   when it was shrunk (0 means "use the saved top" in heap/HPGROW.C). */
static void far pascal RESTORE_MEMORY_AFTER_EXEC(void)
{
    register unsigned int value;
    value=SET_PROGRAM_TOP(0xffffU);
    value=SET_PROGRAM_TOP(value);
    GROW_HEAP_TO(value);
}

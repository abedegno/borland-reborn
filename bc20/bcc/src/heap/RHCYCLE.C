/* target: CODE_2_RHCYCLE */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: a stub that only calls itself (nothing calls it). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: RHCYCLE only calls itself; nothing is known to call it (like the
   RH_SELF_CALL_* stubs, probably a placeholder kept from Borland's source). */
static void near pascal RHCYCLE(void)
{
    RHCYCLE();
}

/* target: CODE_2_RH38FB */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: RH_SELF_CALL_AFTER_SWAP_BANK, an uncalled stub that only calls
   itself, probably a placeholder kept from Borland's source. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: a function that only calls itself; nothing calls it. */
static void near pascal RH_SELF_CALL_AFTER_SWAP_BANK(void)
{
    RH_SELF_CALL_AFTER_SWAP_BANK();
}

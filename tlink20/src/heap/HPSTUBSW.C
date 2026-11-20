/* target: H_HPSTUBSW */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* Role: far-memory heap: RH_SELF_CALL_AFTER_SWAP_BANK, an uncalled stub that only calls
   itself, probably a placeholder kept from Borland's source. */
/* Overview: a function that only calls itself; nothing calls it. */
void near pascal RH_SELF_CALL_AFTER_SWAP_BANK(void)
{
    RH_SELF_CALL_AFTER_SWAP_BANK();
}

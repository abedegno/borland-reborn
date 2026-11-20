/* target: H_HPSTUBEM */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* Role: far-memory heap: RH_SELF_CALL_AFTER_EMS_BANK, an uncalled stub that only calls
   itself, probably a placeholder kept from Borland's source. */
/* Overview: a function that only calls itself; nothing calls it. */
/* Complete reconstruction of original0094:3CE7..3CEF; scoped ignored-result interface. */
void near pascal RH_SELF_CALL_AFTER_EMS_BANK(void)
{
    RH_SELF_CALL_AFTER_EMS_BANK();
}

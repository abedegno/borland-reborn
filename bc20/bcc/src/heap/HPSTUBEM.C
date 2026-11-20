/* target: CODE_2_RH3CE7 */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: RH_SELF_CALL_AFTER_EMS_BANK, an uncalled stub that only calls
   itself, probably a placeholder kept from Borland's source. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: a function that only calls itself; nothing calls it. */
/* Complete reconstruction of original0094:3CE7..3CEF; scoped ignored-result interface. */
static void near pascal RH_SELF_CALL_AFTER_EMS_BANK(void)
{
    RH_SELF_CALL_AFTER_EMS_BANK();
}

/* target: CODE_2_RH2CA7 */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: RH_SELF_CALL_BEFORE_INIT, an uncalled stub that only calls itself,
   probably a placeholder kept from Borland's source. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: a function that only calls itself; nothing calls it. */
static void near pascal RH_SELF_CALL_BEFORE_INIT(void)
{
    RH_SELF_CALL_BEFORE_INIT();
}

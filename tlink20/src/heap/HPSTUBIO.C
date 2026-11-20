/* target: H_HPSTUBIO */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* Role: far-memory heap: RH_SELF_CALL_BEFORE_DOS_IO, an uncalled stub that only calls
   itself, probably a placeholder kept from Borland's source. */
/* Overview: a function that only calls itself; nothing calls it. */
void near pascal RH_SELF_CALL_BEFORE_DOS_IO(void)
{
    RH_SELF_CALL_BEFORE_DOS_IO();
}

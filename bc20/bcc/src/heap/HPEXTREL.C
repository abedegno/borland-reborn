/* target: CODE_2_RH3F7E */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: RH_CALL_EXT_RELEASE releases the extended-memory bank through the
   overlay manager's OVR_RELEASE_EXT_MEMORY. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: at exit (SHUTDOWN_HEAP_BANKS) gives the extended-memory bank
   back through the overlay manager. */
/* Complete reconstruction of original0094:3F7E..3F88; scoped ignored-result interface. */
extern void far pascal OVR_RELEASE_EXT_MEMORY(void);

static void near pascal RH_CALL_EXT_RELEASE(void)
{
    OVR_RELEASE_EXT_MEMORY();
}

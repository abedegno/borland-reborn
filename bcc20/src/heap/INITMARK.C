/* target: ovr123_C70S42 */
/* opts: -mm -zCCO042_TEXT -zECO042_TEXT -zFCODE */
/* Role: far-memory heap: one-byte marker at the start of a memory region that
   INIT_MEMORY_MANAGER passes to the heap; no code. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: only its segment matters: INIT_MEMORY_MANAGER passes
   FP_SEG(INIT_REGION_START_MARK) to ADOPT_EXTERNAL_REGIONS as the first
   region of the chain. */
/* Original one-byte segment anchor; no executable routine is declared. */
unsigned char far pascal INIT_REGION_START_MARK[1]={0};

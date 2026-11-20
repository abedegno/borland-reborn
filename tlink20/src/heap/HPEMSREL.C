/* target: H_HPEMSREL */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* Role: far-memory heap: RELEASE_EMS_BANK frees the EMS bank's handle. */
/* Overview: at exit (SHUTDOWN_HEAP_BANKS) frees the EMS bank's pages
   through the overlay manager's FREE_EMS_HANDLE. */
/* Complete reconstruction of original0094:3CDD..3CE7; scoped ignored-result interface. */
extern void far pascal FREE_EMS_HANDLE(void);

void near pascal RELEASE_EMS_BANK(void)
{
    FREE_EMS_HANDLE();
}

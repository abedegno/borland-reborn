/* target: H_HPRELCB */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* Role: far-memory heap: BCC_RESIDENT_RELEASE_CALLBACK, a release callback that unlinks a
   pool node and returns 0. Entry points: BCC_RESIDENT_RELEASE_CALLBACK. */
/* Overview: bank 4's release hook (hook_24): a bank-4 node has no memory, so
   releasing it only takes it out of the chain and returns its descriptor
   (RRETNDES, which callers name RRETNDES). */
struct PoolNode;
extern void near pascal RRETNDES(struct PoolNode near *);
unsigned int near pascal BCC_RESIDENT_RELEASE_CALLBACK(struct PoolNode near *node)
{
    RRETNDES(node);
    return 0;
}

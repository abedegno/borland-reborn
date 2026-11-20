/* target: CODE_2_R19EC */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: BCC_RESIDENT_RELEASE_CALLBACK, a release callback that unlinks a
   pool node and returns 0. Entry points: BCC_RESIDENT_RELEASE_CALLBACK. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: bank 5's release hook (hook_24): a bank-5 node has no memory, so
   releasing it only takes it out of the chain and returns its descriptor
   (RRETNDES, which callers name UNLINK_HEAP_NODE). */
struct PoolNode;
extern void near pascal UNLINK_HEAP_NODE(struct PoolNode near *);
unsigned int near pascal BCC_RESIDENT_RELEASE_CALLBACK(struct PoolNode near *node)
{
    UNLINK_HEAP_NODE(node);
    return 0;
}

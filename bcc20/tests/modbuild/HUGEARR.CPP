// modtest: -ml -O -G
// Huge arrays in C++: each gets far data segments of its own, written segment by segment
// (HUGEDATA.C, reached only from the C++ front end): one over 64 KB, one initialised, and
// one whose element size is not a power of two, padded in front.
char huge big_bytes[70000L];
int huge small_init[10] = { 1, 2, 3 };
struct Three { char c[3]; } huge odd_array[25000];
long use(long i) { return big_bytes[i] + small_init[i % 10] + odd_array[i % 25000].c[1]; }

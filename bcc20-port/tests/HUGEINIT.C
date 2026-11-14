/* modtest: -mh */
/* A huge array with an initialiser shorter than the array: the rest is reserved across
   segments; constant folding of the rarer operators. */
char huge big[70000] = { 1, 2, 3 };
long huge longs[20000] = { 5L };
int folds[] = { 7 - 9, -7 / 2, -7 % 3, 7u % 3u, 5u - 9u, 1 ^ 2 };
long lfolds[] = { 0x12345678L ^ 0x0F0F0F0FL, -100000L / 7L, -100000L % 7L, 3L - 9L };

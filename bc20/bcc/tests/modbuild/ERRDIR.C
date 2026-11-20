/* modtest: -ml */
/* modes: -c */
/* #error stops the compile with its text, line splices joined. */
int before;
#error This file \
   cannot be compiled "really" 'no'
int after;

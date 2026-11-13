/* modtest: -ms */
/* modes: link */
/* A compile that goes on to link: BCC finds Borland's TLINK in the test directory and runs
   it (the driver's link step and its DOS exec), and TLINK stops for want of C0S.OBJ. */
int main(void) { return 0; }

/* modtest: -ml -Qe -Qe- -Qe=64 -Qx -Qx- -Qx=512,64 -Ff -Ff- -Ff=100 -T/zi -T- -T/m2 -lc -l-c -lx -l- -LLIB;C:\LIB */
/* modes: -c */
/* The port's tests (tools/record.py, corpus_steps) reach what the corpus does not.  This one:
   the EMS and extended memory options (-Qe, -Qx), the far data threshold (-Ff=), TASM
   arguments (-T), linker switches (-l) and library directories (-L). */
int far_data_test[200];
int main(void) { return far_data_test[3]; }

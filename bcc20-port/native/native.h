/* native.h: the native build's platform layer (native/): what native.c and heap.c share */
#ifndef PORT_NATIVE_H
#define PORT_NATIVE_H
#include "port.h"

/* a word in DOS memory that holds the heap's own handle (its item block) */
farptr native_item_holder(void);
/* size bytes of the program file's overlay area at offset into target */
void native_read_overlay(u32 offset, u8 *target, u16 size);

/* stack.c: the shadow stack of BCC.EXE's 8086 stack */
unsigned native_stack_depth(void);
void native_stack_unwind(unsigned to);
void native_stack_set_root(i32 sp);
/* 1 on, 0 off, -1 as BCC_STACK_LIMIT says (default on) */
void native_stack_enable(int on);

/* native.c: one run of BCC (its exit status), and the library's job around it (lib.c) */
#include "bcc20.h"
int native_run(int argc, const char *const *argv);
int native_job_begin(const bcc20_job *job);
void native_job_end(bcc20_result *result);
void native_pause_at(const char *name, void (*pause)(void *), void *context);
int native_add_file(const char *name, const void *data, size_t size);
/* explain.c: where EXPLAIN's lines go for this run */
void native_explain_begin(void (*callback)(void *, const char *), void *context);
#endif

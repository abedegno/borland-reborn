/* native.h: the native build's platform layer (native/): what native.c and heap.c share */
#ifndef PORT_NATIVE_H
#define PORT_NATIVE_H
#include "port.h"

/* a word in DOS memory that holds the heap's own handle (its item block) */
farptr native_item_holder(void);
/* size bytes of the program file's overlay area at offset into target */
void native_read_overlay(u32 offset, u8 *target, u16 size);

#endif

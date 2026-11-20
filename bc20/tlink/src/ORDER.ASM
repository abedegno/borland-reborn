; ORDER.ASM: linked first; declares TLINK.EXE's segments, empty, in their order.
; TLINK lays segments out by class, in the order it first meets each class, and within a
; class in the order it first meets each segment.  So the core's code (CODE0) comes first,
; then TLINK's own data (TLDATA), the stack, the overlay library's two far data segments,
; DGROUP (its _DATA at a paragraph, then _BSS) and last TLINK's big uninitialised data
; (TLBSS).  The other code segments (SETJMP_TEXT, UNMANGLE_TEXT, _TEXT, the run-time
; library's and CODE2) join class CODE in link order.  The names are free: an EXE keeps none.
CODE0		segment byte public 'CODE'
CODE0		ends
TLDATA		segment para public 'TLDATA'
TLDATA		ends
_STACK		segment para stack 'STACK'
_STACK		ends
FAR46		segment para public 'FAR_DATA'
FAR46		ends
FAR50		segment para public 'FAR_DATA'
FAR50		ends
DGROUP		group	_DATA,_BSS
_DATA		segment para public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
TLBSS		segment para public 'BSS'
TLBSS		ends
		end

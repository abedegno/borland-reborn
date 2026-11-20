; HEAPHEAD.ASM: the first 4 bytes of DGROUP, linked before every other DGROUP data.
; ACTIVE_HEAP names offset 0: the heap code reaches the fields of the current bank's
; control block as ACTIVE_HEAP.field with DS set to that bank's descriptor segment, so
; the name has to stand for offset 0 of a segment.  The 4 zero bytes themselves are
; TLINK.EXE's; nothing reads them through DGROUP.

DGROUP		group	_DATA
_DATA		segment word public 'DATA'
		public	ACTIVE_HEAP
ACTIVE_HEAP	label	byte
		dd	0
_DATA		ends
		end

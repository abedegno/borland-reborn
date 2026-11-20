; HEAPDATA.ASM: the heap library's DGROUP variables (bcc20 keeps the same ones in
; DGROUP.ASM; the names are bcc20's).  The bytes are TLINK.EXE's.  The signature in front
; ('$*$*$*', then 1, 6 and 'YOM') heads the library's data in BCC.EXE and CPP.EXE too; YOM
; is the name of Borland's overlay and memory library (OVERLAY.LIB's OVRHP module comes
; from ..\YOMHP.ASM).  TLINK's heap has no swap file and no handle ring, so it has fewer
; variables than BCC's.
;   HEAP_DEFAULT_OWNER_TAG  owner tag given to new nodes (HPTAGS.C)
;   HEAP_STATUS             status of the last heap call (0, 1000h no memory, ...)
;   HEAP_SAVED_TOP_KEY      bank 0's top before SHRINK_HEAP_TO, for GROW_HEAP_TO
;   HEAP_DESCRIPTOR_SEGMENTS the segment of each bank's descriptor table (8 words)
;   OWNER_TAG_BITMAP        one bit per owner tag in use; tag 0 is reserved
;   HEAP_CPU_TYPE           1 8086, 2 286, 3 386 (INIT_HEAP)
;   HEAP_HOOK_CALLSITE      the far routine called when memory runs out (_BSS)
; SWAP_GROW_FILE_ALLOWED is a swap-file switch in BCC's heap; TLINK's sources use it only
; for its segment (FP_SEG), so here it is a second name for HEAP_CPU_TYPE.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
		public	HEAP_DEFAULT_OWNER_TAG
		public	HEAP_STATUS
		public	HEAP_SAVED_TOP_KEY
		public	HEAP_DESCRIPTOR_SEGMENTS
		public	OWNER_TAG_BITMAP
		public	HEAP_CPU_TYPE
		public	SWAP_GROW_FILE_ALLOWED
		db	'$*$*$*',0
		dw	1
		db	6,'YOM',0
HEAP_DEFAULT_OWNER_TAG	dw	0
HEAP_STATUS		dw	0
HEAP_SAVED_TOP_KEY	dw	0
HEAP_DESCRIPTOR_SEGMENTS dw	8 dup (0)
OWNER_TAG_BITMAP	dw	1, 15 dup (0)
SWAP_GROW_FILE_ALLOWED	label	byte
HEAP_CPU_TYPE		db	0
_DATA		ends

_BSS		segment word public 'BSS'
		public	HEAP_HOOK_CALLSITE
		db	6 dup (?)		; not referenced by name anywhere in TLINK
HEAP_HOOK_CALLSITE	dd	?
		db	34h dup (?)		; to 410h: DGROUP's size in TLINK.EXE
_BSS		ends
		end

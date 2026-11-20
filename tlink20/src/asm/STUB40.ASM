; /* target: A_STUB40 */
; /* opts: /ml */
; STUB40.ASM: three bytes in _TEXT after the run-time library's LXMUL and the overlay
; library's __FAR_RETURN: int 40h, then retf.  Nothing in TLINK calls it, and no
; library of the toolchain has it; TLINK 3.0 and 3.01 (Turbo C++ 1.0/1.01) have the same
; bytes after their __FAR_RETURN, so it came with whatever brought that in.  The name is
; descriptive.  (int 40h is where the BIOS moves the diskette service when a hard disk
; is present.)

_TEXT		segment byte public 'CODE'
		assume	cs:_TEXT
		public	INT40_STUB
INT40_STUB	proc	far
		int	40h
		ret
INT40_STUB	endp
_TEXT		ends
		end

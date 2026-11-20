; CTYPE.ASM: the character table the C code tests through ctype.h's macros (_ctype),
; 257 bytes: one for EOF (-1), then one per character.  Bits: 1 space, 2 digit, 4 upper
; case, 8 lower case, 10h hex digit, 20h control, 40h punctuation.  Not the BC 2.0 run-time
; library's table: only TAB and LF are marked as spaces (the library also marks VT, FF and
; CR), so it is TLINK's own copy (or an older library's); the bytes are TLINK.EXE's.

DGROUP		group	_DATA
_DATA		segment word public 'DATA'
		public	__ctype
__ctype		label	byte
		db	0,20h,20h,20h,20h,20h,20h,20h,20h,20h,21h,21h,20h,20h,20h,20h
		db	20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
		db	20h,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,2,2,2,2,2,2,2,2,2,2,0,0,0,0,0
		db	0,0,14h,14h,14h,14h,14h,14h,4,4,4,4,4,4,4,4
		db	4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0
		db	0,0,18h,18h,18h,18h,18h,18h,8,8,8,8,8,8,8,8
		db	8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0
		db	20h,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0
_DATA		ends
		end

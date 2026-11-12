		public	X051_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d2f_9d6c
; BEGIN STOVB137 (listing ovr_1d2f_9d6c:D6C0)
CO051_TEXT	segment byte public 'CODE'
		assume	cs:CO051_TEXT

		public	X051_00
X051_00	label	far
BCC_BYTES_D6C0	label	byte
		db	000h

CO051_TEXT	ends
; END STOVB137
		end

		public	X068_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1da5_abeb
; BEGIN STOVT191 (listing ovr_1da5_abeb:BEB0)
CO068_TEXT	segment byte public 'CODE'
		assume	cs:CO068_TEXT

		public	X068_00
X068_00	label	far
STOVT191	label	byte
BCC_BYTES_BEB0	label	byte
		db	0

CO068_TEXT	ends
; END STOVT191
		end

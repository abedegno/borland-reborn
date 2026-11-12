		public	X067_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1da2_abea
; BEGIN STOVT190 (listing ovr_1da2_abea:BEA0)
CO067_TEXT	segment byte public 'CODE'
		assume	cs:CO067_TEXT

		public	X067_00
X067_00	label	far
STOVT190	label	byte
BCC_BYTES_BEA0	label	byte
		db	0

CO067_TEXT	ends
; END STOVT190
		end

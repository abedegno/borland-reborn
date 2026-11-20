DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_144
; BEGIN RC144 (listing CODE_144:0000)
CODE_144	segment byte public 'CODE'
		assume	cs:CODE_144

		public	BCC_FAR_D5A0
		public	BCC_FAR_D5A5
		public	BCC_FAR_D5AA
		public	BCC_FAR_D5AF
		public	BCC_FAR_D5B4

		db	0CDh,03Fh,000h,000h,0D0h,0DAh,004h,000h,0B1h,002h,012h,000h,005h,000h
		db	000h,000h
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
		db	000h,000h

BCC_FAR_D5A0	label	far
		db	0EAh,094h,001h,069h,0A1h
BCC_FAR_D5A5	label	far
		db	0EAh,040h,001h,069h,0A1h
BCC_FAR_D5AA	label	far
		db	0EAh,000h,000h,069h,0A1h
BCC_FAR_D5AF	label	far
		db	0EAh,0E8h,001h,069h,0A1h
BCC_FAR_D5B4	label	far
		db	0EAh,0D9h,000h,069h,0A1h
		db	000h,000h,000h,000h,000h,000h,000h

CODE_144	ends
; END RC144
		end

DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_173
; BEGIN RC173 (listing CODE_173:0000)
CODE_173	segment byte public 'CODE'
		assume	cs:CODE_173

		public	BCC_FAR_DD00
		public	BCC_FAR_DD05

		db	0CDh,03Fh,000h,000h,0B0h,0EBh,005h,000h,003h,001h,000h,000h,002h,000h	; CODE_173:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_173:000E
		db	000h,000h,000h,000h	; CODE_173:001C
BCC_FAR_DD00	label	far
		db	0EAh,043h,000h,0E7h,0B1h	; CODE_173:0020
BCC_FAR_DD05	label	far
		db	0EAh,000h,000h,0E7h,0B1h,000h,000h,000h,000h,000h,000h	; CODE_173:0025

CODE_173	ends
; END RC173
		end

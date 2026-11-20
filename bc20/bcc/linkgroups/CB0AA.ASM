DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_170
; BEGIN RC170 (listing CODE_170:0000)
CODE_170	segment byte public 'CODE'
		assume	cs:CODE_170

		public	BCC_FAR_DC80

		db	0CDh,03Fh,000h,000h,090h,0E2h,005h,000h,06Bh,006h,002h,000h,001h,000h	; CODE_170:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_170:000E
		db	000h,000h,000h,000h	; CODE_170:001C
BCC_FAR_DC80	label	far
		db	0EAh,056h,002h,059h,0B1h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_170:0020
		db	000h,000h	; CODE_170:002E

CODE_170	ends
; END RC170
		end

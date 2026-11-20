DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_149
; BEGIN RC149 (listing CODE_149:0000)
CODE_149	segment byte public 'CODE'
		assume	cs:CODE_149

		public	BCC_FAR_D6C0
		public	BCC_FAR_D6C5

		db	0CDh,03Fh,000h,000h,0E0h,003h,005h,000h,0EEh,00Bh,0ACh,000h,002h,000h	; CODE_149:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_149:000E
		db	000h,000h,000h,000h	; CODE_149:001C
BCC_FAR_D6C0	label	far
		db	0EAh,0C1h,00Bh,0DCh,0A3h	; CODE_149:0020
BCC_FAR_D6C5	label	far
		db	0EAh,01Dh,000h,0DCh,0A3h,000h,000h,000h,000h,000h,000h	; CODE_149:0025

CODE_149	ends
; END RC149
		end

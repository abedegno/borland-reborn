DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_148
; BEGIN RC148 (listing CODE_148:0000)
CODE_148	segment byte public 'CODE'
		assume	cs:CODE_148

		public	BCC_FAR_D69A

		db	0CDh,03Fh,000h,000h,050h,002h,005h,000h,054h,001h,032h,000h,003h,000h	; CODE_148:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_148:000E
		db	000h,000h,000h,000h,0EAh,025h,001h,0C6h,0A3h,0EAh,020h,001h,0C6h,0A3h	; CODE_148:001C
BCC_FAR_D69A	label	far
		db	0EAh,000h,000h,0C6h,0A3h,000h	; CODE_148:002A

CODE_148	ends
; END RC148
		end

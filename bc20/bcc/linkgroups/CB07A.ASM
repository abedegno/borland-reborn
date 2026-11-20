DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_122
; BEGIN LG04A (gap CODE_122:0000)
CODE_122	segment byte public 'CODE'
		assume	cs:CODE_122
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0C0h,0B7h,003h,000h,001h,000h,000h,000h,002h,000h	; CODE_122:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_122:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,059h,08Dh,0EAh,000h,000h,059h,08Dh	; CODE_122:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_122:002A

CODE_122	ends
; END LG04A
		end

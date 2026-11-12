DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_62
; BEGIN LG02D (gap CODE_62:0000)
CODE_62	segment byte public 'CODE'
		assume	cs:CODE_62
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,080h,0D4h,000h,000h,037h,010h,08Ah,000h,001h,000h	; CODE_62:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_62:000E
		db	000h,000h,000h,000h,0EAh,075h,00Eh,084h,059h,000h,000h,000h,000h,000h	; CODE_62:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_62:002A

CODE_62	ends
; END LG02D
		end

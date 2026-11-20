DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_65
; BEGIN LG02F (gap CODE_65:0000)
CODE_65	segment byte public 'CODE'
		assume	cs:CODE_65
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0E0h,0F4h,000h,000h,0C7h,00Ch,072h,000h,001h,000h	; CODE_65:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_65:000E
		db	000h,000h,000h,000h,0EAh,021h,008h,073h,05Bh,000h,000h,000h,000h,000h	; CODE_65:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_65:002A

CODE_65	ends
; END LG02F
		end

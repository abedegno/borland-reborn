DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_66
; BEGIN LG030 (gap CODE_66:0000)
CODE_66	segment byte public 'CODE'
		assume	cs:CODE_66
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,020h,002h,001h,000h,0F0h,010h,0B6h,000h,002h,000h	; CODE_66:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_66:000E
		db	000h,000h,000h,000h,0EAh,0DDh,002h,040h,05Ch,0EAh,072h,010h,040h,05Ch	; CODE_66:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_66:002A

CODE_66	ends
; END LG030
		end

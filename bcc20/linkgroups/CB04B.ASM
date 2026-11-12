DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_75
; BEGIN LG035 (gap CODE_75:0000)
CODE_75	segment byte public 'CODE'
		assume	cs:CODE_75
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,030h,0B4h,001h,000h,08Eh,002h,022h,000h,001h,000h	; CODE_75:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_75:000E
		db	000h,000h,000h,000h,0EAh,086h,002h,0BAh,068h,000h,000h,000h,000h,000h	; CODE_75:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_75:002A

CODE_75	ends
; END LG035
		end

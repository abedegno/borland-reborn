DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_58
; BEGIN LG02A (gap CODE_58:0000)
CODE_58	segment byte public 'CODE'
		assume	cs:CODE_58
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,030h,081h,000h,000h,0FBh,00Ah,088h,000h,003h,000h	; CODE_58:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_58:000E
		db	000h,000h,000h,000h,0EAh,034h,006h,093h,054h,0EAh,050h,00Ah,093h,054h	; CODE_58:001C
		db	0EAh,0BFh,003h,093h,054h,000h	; CODE_58:002A

CODE_58	ends
; END LG02A
		end

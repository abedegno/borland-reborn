DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_108
; BEGIN LG044 (gap CODE_108:0000)
CODE_108	segment byte public 'CODE'
		assume	cs:CODE_108
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0C0h,029h,003h,000h,022h,005h,048h,000h,001h,000h	; CODE_108:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_108:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0E9h,084h,000h,000h,000h,000h,000h	; CODE_108:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_108:002A

CODE_108	ends
; END LG044
		end

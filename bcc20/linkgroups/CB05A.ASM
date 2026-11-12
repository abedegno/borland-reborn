DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_90
; BEGIN LG03E (gap CODE_90:0000)
CODE_90	segment byte public 'CODE'
		assume	cs:CODE_90
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0A0h,034h,002h,000h,012h,016h,004h,001h,005h,000h	; CODE_90:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_90:000E
		db	000h,000h,000h,000h,0EAh,095h,005h,0F6h,070h,0EAh,0B4h,003h,0F6h,070h	; CODE_90:001C
		db	0EAh,028h,006h,0F6h,070h,0EAh,080h,013h,0F6h,070h,0EAh,09Eh,008h,0F6h	; CODE_90:002A
		db	070h,000h,000h,000h,000h,000h,000h,000h	; CODE_90:0038

CODE_90	ends
; END LG03E
		end

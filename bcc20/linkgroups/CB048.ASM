DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_72
; BEGIN LG032 (gap CODE_72:0000)
CODE_72	segment byte public 'CODE'
		assume	cs:CODE_72
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,040h,07Fh,001h,000h,0CEh,009h,0BEh,000h,004h,000h	; CODE_72:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_72:000E
		db	000h,000h,000h,000h,0EAh,0BCh,008h,0A6h,065h,0EAh,0E6h,007h,0A6h,065h	; CODE_72:001C
		db	0EAh,0A1h,002h,0A6h,065h,0EAh,000h,000h,0A6h,065h,000h,000h,000h,000h	; CODE_72:002A
		db	000h,000h,000h,000h,000h,000h,000h,000h	; CODE_72:0038

CODE_72	ends
; END LG032
		end

DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_64
; BEGIN LG02E (gap CODE_64:0000)
CODE_64	segment byte public 'CODE'
		assume	cs:CODE_64
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,090h,0EBh,000h,000h,077h,008h,0D4h,000h,003h,000h	; CODE_64:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_64:000E
		db	000h,000h,000h,000h,0EAh,00Bh,003h,0EBh,05Ah,0EAh,0E0h,004h,0EBh,05Ah	; CODE_64:001C
		db	0EAh,064h,007h,0EBh,05Ah,000h	; CODE_64:002A

CODE_64	ends
; END LG02E
		end

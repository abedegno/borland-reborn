DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_73
; BEGIN LG033 (gap CODE_73:0000)
CODE_73	segment byte public 'CODE'
		assume	cs:CODE_73
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0D0h,089h,001h,000h,0A7h,009h,09Ch,000h,005h,000h	; CODE_73:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_73:000E
		db	000h,000h,000h,000h,0EAh,00Fh,002h,043h,066h,0EAh,0FFh,007h,043h,066h	; CODE_73:001C
		db	0EAh,04Eh,008h,043h,066h,0EAh,03Fh,002h,043h,066h,0EAh,000h,000h,043h	; CODE_73:002A
		db	066h,000h,000h,000h,000h,000h,000h,000h	; CODE_73:0038

CODE_73	ends
; END LG033
		end

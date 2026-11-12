DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_113
; BEGIN LG047 (gap CODE_113:0000)
CODE_113	segment byte public 'CODE'
		assume	cs:CODE_113
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,070h,040h,003h,000h,087h,005h,00Ch,000h,008h,000h	; CODE_113:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_113:000E
		db	000h,000h,000h,000h,0EAh,061h,001h,03Eh,086h,0EAh,081h,000h,03Eh,086h	; CODE_113:001C
		db	0EAh,0C9h,004h,03Eh,086h,0EAh,01Ah,002h,03Eh,086h,0EAh,011h,000h,03Eh	; CODE_113:002A
		db	086h,0EAh,0C2h,001h,03Eh,086h,0EAh,000h,000h,03Eh,086h,0EAh,0F3h,000h	; CODE_113:0038
		db	03Eh,086h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_113:0046

CODE_113	ends
; END LG047
		end

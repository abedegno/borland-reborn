DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_74
; BEGIN LG034 (gap CODE_74:0000)
CODE_74	segment byte public 'CODE'
		assume	cs:CODE_74
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,020h,094h,001h,000h,0BBh,01Dh,052h,002h,008h,000h	; CODE_74:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_74:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0DEh,066h,0EAh,09Fh,016h,0DEh,066h	; CODE_74:001C
		db	0EAh,026h,01Bh,0DEh,066h,0EAh,081h,013h,0DEh,066h,0EAh,07Eh,002h,0DEh	; CODE_74:002A
		db	066h,0EAh,018h,00Dh,0DEh,066h,0EAh,0A4h,007h,0DEh,066h,0EAh,033h,011h	; CODE_74:0038
		db	0DEh,066h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_74:0046

CODE_74	ends
; END LG034
		end

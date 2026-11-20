DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_57
; BEGIN LG029 (gap CODE_57:0000)
CODE_57	segment byte public 'CODE'
		assume	cs:CODE_57
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,090h,064h,000h,000h,054h,01Bh,03Eh,001h,00Fh,000h	; CODE_57:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_57:000E
		db	000h,000h,000h,000h,0EAh,0D1h,016h,0DDh,052h,0EAh,0E1h,00Bh,0DDh,052h	; CODE_57:001C
		db	0EAh,040h,018h,0DDh,052h,0EAh,024h,013h,0DDh,052h,0EAh,0A0h,004h,0DDh	; CODE_57:002A
		db	052h,0EAh,054h,008h,0DDh,052h,0EAh,0CDh,014h,0DDh,052h,0EAh,0C1h,006h	; CODE_57:0038
		db	0DDh,052h,0EAh,058h,00Dh,0DDh,052h,0EAh,0EEh,010h,0DDh,052h,0EAh,0A4h	; CODE_57:0046
		db	003h,0DDh,052h,0EAh,05Dh,00Eh,0DDh,052h,0EAh,013h,00Fh,0DDh,052h,0EAh	; CODE_57:0054
		db	0FFh,019h,0DDh,052h,0EAh,064h,011h,0DDh,052h,000h,000h,000h,000h,000h	; CODE_57:0062

CODE_57	ends
; END LG029
		end

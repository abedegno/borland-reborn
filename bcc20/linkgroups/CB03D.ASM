DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_61
; BEGIN LG02C (gap CODE_61:0000)
CODE_61	segment byte public 'CODE'
		assume	cs:CODE_61
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,000h,0ABh,000h,000h,0A0h,026h,0D8h,002h,005h,000h	; CODE_61:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_61:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,01Ah,057h,0EAh,0DDh,024h,01Ah,057h	; CODE_61:001C
		db	0EAh,008h,00Eh,01Ah,057h,0EAh,096h,004h,01Ah,057h,0EAh,0CFh,025h,01Ah	; CODE_61:002A
		db	057h,000h,000h,000h,000h,000h,000h,000h	; CODE_61:0038

CODE_61	ends
; END LG02C
		end

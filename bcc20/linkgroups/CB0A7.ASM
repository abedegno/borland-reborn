DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_167
; BEGIN LG058 (gap CODE_167:0000)
CODE_167	segment byte public 'CODE'
		assume	cs:CODE_167
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0A0h,0CCh,005h,000h,016h,005h,048h,000h,003h,000h	; CODE_167:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_167:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,000h,0B0h,0EAh,0FDh,002h,000h,0B0h	; CODE_167:001C
		db	0EAh,06Eh,004h,000h,0B0h,000h	; CODE_167:002A

CODE_167	ends
; END LG058
		end

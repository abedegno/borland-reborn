DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_134
; BEGIN LG04D (gap CODE_134:0000)
CODE_134	segment byte public 'CODE'
		assume	cs:CODE_134
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0B0h,08Bh,004h,000h,061h,013h,08Eh,001h,006h,000h	; CODE_134:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_134:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,035h,09Ch,0EAh,074h,00Fh,035h,09Ch	; CODE_134:001C
		db	0EAh,0D7h,00Bh,035h,09Ch,0EAh,003h,00Dh,035h,09Ch,0EAh,0D5h,00Ch,035h	; CODE_134:002A
		db	09Ch,0EAh,0CEh,010h,035h,09Ch,000h,000h	; CODE_134:0038

CODE_134	ends
; END LG04D
		end

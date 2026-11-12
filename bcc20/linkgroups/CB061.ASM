DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_97
; BEGIN LG043 (gap CODE_97:0000)
CODE_97	segment byte public 'CODE'
		assume	cs:CODE_97
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,000h,096h,002h,000h,0B1h,004h,01Ah,000h,004h,000h	; CODE_97:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_97:000E
		db	000h,000h,000h,000h,0EAh,096h,004h,026h,07Ah,0EAh,09Eh,004h,026h,07Ah	; CODE_97:001C
		db	0EAh,08Ah,002h,026h,07Ah,0EAh,000h,000h,026h,07Ah,000h,000h,000h,000h	; CODE_97:002A
		db	000h,000h,000h,000h,000h,000h,000h,000h	; CODE_97:0038

CODE_97	ends
; END LG043
		end

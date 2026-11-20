DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_77
; BEGIN LG037 (gap CODE_77:0000)
CODE_77	segment byte public 'CODE'
		assume	cs:CODE_77
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0F0h,0B8h,001h,000h,032h,001h,01Ch,000h,002h,000h	; CODE_77:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_77:000E
		db	000h,000h,000h,000h,0EAh,0C8h,000h,002h,069h,0EAh,000h,000h,002h,069h	; CODE_77:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_77:002A

CODE_77	ends
; END LG037
		end

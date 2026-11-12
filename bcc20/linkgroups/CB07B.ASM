DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_123
; BEGIN LG04B (gap CODE_123:0000)
CODE_123	segment byte public 'CODE'
		assume	cs:CODE_123
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0D0h,0B7h,003h,000h,03Ch,009h,088h,000h,003h,000h	; CODE_123:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_123:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,05Ah,08Dh,0EAh,02Ch,000h,05Ah,08Dh	; CODE_123:001C
		db	0EAh,07Ch,003h,05Ah,08Dh,000h	; CODE_123:002A

CODE_123	ends
; END LG04B
		end

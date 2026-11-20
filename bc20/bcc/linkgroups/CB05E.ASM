DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_94
; BEGIN LG041 (gap CODE_94:0000)
CODE_94	segment byte public 'CODE'
		assume	cs:CODE_94
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0E0h,04Dh,002h,000h,050h,011h,054h,000h,004h,000h	; CODE_94:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_94:000E
		db	000h,000h,000h,000h,0EAh,09Eh,010h,0BEh,075h,0EAh,004h,00Fh,0BEh,075h	; CODE_94:001C
		db	0EAh,05Fh,003h,0BEh,075h,0EAh,0E7h,00Bh,0BEh,075h,000h,000h,000h,000h	; CODE_94:002A
		db	000h,000h,000h,000h,000h,000h,000h,000h	; CODE_94:0038

CODE_94	ends
; END LG041
		end

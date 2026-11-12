DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_164
; BEGIN LG056 (gap CODE_164:0000)
CODE_164	segment byte public 'CODE'
		assume	cs:CODE_164
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,010h,0B5h,005h,000h,050h,00Ch,0E0h,000h,002h,000h	; CODE_164:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_164:000E
		db	000h,000h,000h,000h,0EAh,0F9h,001h,08Fh,0AEh,0EAh,0C2h,00Bh,08Fh,0AEh	; CODE_164:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_164:002A

CODE_164	ends
; END LG056
		end

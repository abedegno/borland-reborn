DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_160
; BEGIN LG053 (gap CODE_160:0000)
CODE_160	segment byte public 'CODE'
		assume	cs:CODE_160
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0A0h,088h,005h,000h,001h,000h,000h,000h,001h,000h	; CODE_160:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_160:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0EAh,0ABh,000h,000h,000h,000h,000h	; CODE_160:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_160:002A

CODE_160	ends
; END LG053
		end

DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_95
; BEGIN LG042 (gap CODE_95:0000)
CODE_95	segment byte public 'CODE'
		assume	cs:CODE_95
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,090h,05Fh,002h,000h,049h,006h,032h,000h,001h,000h	; CODE_95:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_95:000E
		db	000h,000h,000h,000h,0EAh,034h,006h,0D3h,076h,000h,000h,000h,000h,000h	; CODE_95:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_95:002A

CODE_95	ends
; END LG042
		end

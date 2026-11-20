DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_59
; BEGIN LG02B (gap CODE_59:0000)
CODE_59	segment byte public 'CODE'
		assume	cs:CODE_59
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0C0h,08Ch,000h,000h,0C6h,00Ch,064h,000h,006h,000h	; CODE_59:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_59:000E
		db	000h,000h,000h,000h,0EAh,01Ah,00Ah,043h,055h,0EAh,0ADh,003h,043h,055h	; CODE_59:001C
		db	0EAh,0E9h,000h,043h,055h,0EAh,0C6h,00Bh,043h,055h,0EAh,0FAh,00Ah,043h	; CODE_59:002A
		db	055h,0EAh,002h,009h,043h,055h,000h,000h	; CODE_59:0038

CODE_59	ends
; END LG02B
		end

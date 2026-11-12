DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_80
; BEGIN LG038 (gap CODE_80:0000)
CODE_80	segment byte public 'CODE'
		assume	cs:CODE_80
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,060h,0C1h,001h,000h,069h,009h,06Eh,000h,005h,000h	; CODE_80:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_80:000E
		db	000h,000h,000h,000h,0EAh,04Fh,007h,084h,069h,0EAh,0EEh,008h,084h,069h	; CODE_80:001C
		db	0EAh,01Ah,005h,084h,069h,0EAh,0BAh,006h,084h,069h,0EAh,094h,002h,084h	; CODE_80:002A
		db	069h,000h,000h,000h,000h,000h,000h,000h,0CDh,03Fh,000h,000h,040h,0CBh	; CODE_80:0038

CODE_80	ends
; END LG038
		end

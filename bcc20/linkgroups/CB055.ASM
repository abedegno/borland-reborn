DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_85
; BEGIN LG03B (gap CODE_85:0000)
CODE_85	segment byte public 'CODE'
		assume	cs:CODE_85
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0B0h,0E5h,001h,000h,020h,006h,05Ch,000h,004h,000h	; CODE_85:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_85:000E
		db	000h,000h,000h,000h,0EAh,0EEh,003h,0A9h,06Bh,0EAh,05Ch,005h,0A9h,06Bh	; CODE_85:001C
		db	0EAh,000h,000h,0A9h,06Bh,0EAh,0DAh,000h,0A9h,06Bh,000h,000h,000h,000h	; CODE_85:002A
		db	000h,000h,000h,000h,000h,000h,000h,000h	; CODE_85:0038

CODE_85	ends
; END LG03B
		end

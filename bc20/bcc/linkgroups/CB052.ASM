DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_82
; BEGIN LG039 (gap CODE_82:0000)
CODE_82	segment byte public 'CODE'
		assume	cs:CODE_82
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,070h,0D3h,001h,000h,077h,008h,0DAh,000h,007h,000h	; CODE_82:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_82:000E
		db	000h,000h,000h,000h,0EAh,0DEh,005h,09Ch,06Ah,0EAh,078h,004h,09Ch,06Ah	; CODE_82:001C
		db	0EAh,0B1h,003h,09Ch,06Ah,0EAh,04Eh,005h,09Ch,06Ah,0EAh,000h,000h,09Ch	; CODE_82:002A
		db	06Ah,0EAh,0F3h,006h,09Ch,06Ah,0EAh,08Ch,000h,09Ch,06Ah,000h,000h,000h	; CODE_82:0038
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_82:0046

CODE_82	ends
; END LG039
		end

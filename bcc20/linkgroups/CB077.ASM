DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_119
; BEGIN LG048 (gap CODE_119:0000)
CODE_119	segment byte public 'CODE'
		assume	cs:CODE_119
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,010h,092h,003h,000h,019h,022h,01Ch,002h,008h,000h	; CODE_119:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_119:000E
		db	000h,000h,000h,000h,0EAh,072h,015h,020h,08Bh,0EAh,044h,015h,020h,08Bh	; CODE_119:001C
		db	0EAh,0F4h,01Ah,020h,08Bh,0EAh,05Ch,00Bh,020h,08Bh,0EAh,085h,006h,020h	; CODE_119:002A
		db	08Bh,0EAh,043h,00Ch,020h,08Bh,0EAh,031h,01Ah,020h,08Bh,0EAh,026h,000h	; CODE_119:0038
		db	020h,08Bh,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_119:0046

CODE_119	ends
; END LG048
		end

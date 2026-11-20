DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_71
; BEGIN LG031 (gap CODE_71:0000)
CODE_71	segment byte public 'CODE'
		assume	cs:CODE_71
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0F0h,067h,001h,000h,0B1h,015h,090h,001h,008h,000h	; CODE_71:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_71:000E
		db	000h,000h,000h,000h,0EAh,0B4h,007h,04Ah,064h,0EAh,00Bh,003h,04Ah,064h	; CODE_71:001C
		db	0EAh,063h,010h,04Ah,064h,0EAh,0F5h,00Eh,04Ah,064h,0EAh,087h,003h,04Ah	; CODE_71:002A
		db	064h,0EAh,003h,006h,04Ah,064h,0EAh,080h,015h,04Ah,064h,0EAh,0D1h,001h	; CODE_71:0038
		db	04Ah,064h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_71:0046

CODE_71	ends
; END LG031
		end

DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_106
; BEGIN RC106 (listing CODE_106:0000)
CODE_106	segment byte public 'CODE'
		assume	cs:CODE_106

		public	BCC_FAR_CA70

		db	0CDh,03Fh,000h,000h,070h,00Dh,003h,000h,04Fh,012h,0BAh,000h,008h,000h	; CODE_106:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_106:000E
		db	000h,000h,000h,000h	; CODE_106:001C
		public	BCC_STMT_SYNC
BCC_STMT_SYNC	label	far
BCC_FAR_CA70	label	far
		db	0EAh,062h,00Eh,03Ah,083h,0EAh,04Eh,002h,03Ah,083h,0EAh,00Dh,006h,03Ah	; CODE_106:0020
		db	083h,0EAh,02Fh,010h,03Ah,083h,0EAh,02Eh,001h,03Ah,083h,0EAh,0D3h,001h	; CODE_106:002E
		db	03Ah,083h,0EAh,0B2h,005h,03Ah,083h,0EAh,041h,00Eh,03Ah,083h,000h,000h	; CODE_106:003C
		db	000h,000h,000h,000h,000h,000h	; CODE_106:004A

CODE_106	ends
; Original-target semantic aliases (zero bytes)
; END RC106
		end

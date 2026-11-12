		public	BCC_SEG_27
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_27
; BEGIN RGETENV (CODE_27:0006)
CODE_27	segment byte public 'CODE'
BCC_SEG_27	label far
		assume	cs:CODE_27
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh,008h,056h,08Bh
		db	016h,014h,000h,033h,0C0h,089h,056h,0FAh,089h,046h,0F8h,0EBh,067h,0C4h	; CODE_27:000E
		db	05Eh,006h,08Ch,046h,0FEh,089h,05Eh,0FCh,0EBh,006h,0FFh,046h,0FCh,0FFh	; CODE_27:001C
		db	046h,0F8h,0C4h,05Eh,0FCh,026h,08Ah,007h,0C4h,05Eh,0F8h,026h,03Ah,007h	; CODE_27:002A
		db	074h,0ECh,0C4h,05Eh,0FCh,026h,080h,03Fh,000h,075h,033h,0C4h,05Eh,0F8h	; CODE_27:0038
		db	026h,080h,03Fh,03Dh,075h,02Ah,0FFh,046h,0F8h,0BEh,04Eh,08Bh,0EBh,00Ch	; CODE_27:0046
		db	0C4h,05Eh,0F8h,026h,08Ah,007h,088h,004h,0FFh,046h,0F8h,046h,0C4h,05Eh	; CODE_27:0054
		db	0F8h,026h,080h,03Fh,000h,075h,0EBh,0C6h,004h,000h,0B8h,04Eh,08Bh,08Ch	; CODE_27:0062
		db	0DAh,0EBh,01Fh,0FFh,046h,0F8h,0C4h,05Eh,0F8h,026h,080h,03Fh,000h,075h	; CODE_27:0070
		db	0F4h,0FFh,046h,0F8h,0C4h,05Eh,0F8h,026h,080h,03Fh,000h,074h,003h,0E9h	; CODE_27:007E
		db	08Dh,0FFh,033h,0D2h	; CODE_27:008C

		db	08Bh,0C2h,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h	; moved from CODE_28:0000 (segment span per FBOV table)
CODE_27	ends
; END RGETENV
		end

; Direct-segment relocation references
		extrn	BCC_COPY_WORDS:far
		public	BCC_SEG_15
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_15
; BEGIN RATOL (CODE_15:0009)
CODE_15	segment byte public 'CODE'
BCC_SEG_15	label far
		assume	cs:CODE_15
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh
		db	004h,056h,0EBh,003h,0FFh,046h,006h,0C4h,05Eh,006h,026h,080h,03Fh,020h	; CODE_15:000E
		db	074h,0F4h,026h,080h,03Fh,009h,074h,0EEh,026h,080h,03Fh,02Dh,075h,008h	; CODE_15:001C
		db	0BEh,001h,000h,001h,076h,006h,0EBh,002h,033h,0F6h,0C7h,046h,0FEh,000h	; CODE_15:002A
		db	000h,0C7h,046h,0FCh,000h,000h,0EBh,02Fh,08Bh,056h,0FEh,08Bh,046h,0FCh	; CODE_15:0038
		db	033h,0C9h,0BBh,00Ah,000h,09Ah,0A9h,003h
		dw	seg BCC_COPY_WORDS
		db	0C4h,05Eh,006h,052h; CODE_15:0046
		db	050h,026h,08Ah,007h,098h,099h,05Bh,059h,003h,0D8h,013h,0CAh,083h,0C3h	; CODE_15:0054
		db	0D0h,083h,0D1h,0FFh,089h,04Eh,0FEh,089h,05Eh,0FCh,0FFh,046h,006h,0C4h	; CODE_15:0062
		db	05Eh,006h,026h,080h,03Fh,030h,07Ch,006h,026h,080h,03Fh,039h,07Eh,0C2h	; CODE_15:0070
		db	00Bh,0F6h,074h,013h,08Bh,056h,0FEh,08Bh,046h,0FCh,0F7h,0DAh,0F7h,0D8h	; CODE_15:007E
		db	083h,0DAh,000h,089h,056h,0FEh,089h,046h,0FCh,08Bh,056h,0FEh,08Bh,046h	; CODE_15:008C
		db	0FCh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h,055h,08Bh,0ECh,0FFh,076h,008h	; CODE_15:009A
		db	0FFh,076h,006h,00Eh,0E8h,05Ah,0FFh,05Dh	; CODE_15:00A8

		db	0CAh,004h,000h	; moved from CODE_16:0000 (segment span per FBOV table)
CODE_15	ends
; END RATOL
		end

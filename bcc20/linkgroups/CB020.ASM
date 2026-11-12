; Direct-segment relocation references
		extrn	BCC_FAR_AB12:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_32
; BEGIN RSTRCHR (CODE_32:0000)
CODE_32	segment byte public 'CODE'
		assume	cs:CODE_32

		public	BCC_RF_1AA0_002F

		db	055h,08Bh,0ECh,056h,01Eh,0C5h,076h,008h,08Ah,05Eh,006h,0ADh,03Ah,0C3h	; CODE_32:0000
		db	074h,013h,00Ah,0C0h,074h,008h,03Ah,0E3h,074h,00Ch,00Ah,0E4h,075h,0EFh	; CODE_32:000E
		db	01Fh,033h,0D2h,08Bh,0C2h,0EBh,007h,04Eh,08Ch,0DAh,08Bh,0C6h,048h,01Fh	; CODE_32:001C
		db	05Eh,05Dh,0CAh,006h,000h	; CODE_32:002A
BCC_RF_1AA0_002F	label	far
		db	055h,08Bh,0ECh,083h,0ECh,004h,0FFh,076h,00Ah,0FFh,076h,008h,09Ah,002h	; CODE_32:002F
		db	000h
		dw	seg BCC_FAR_AB12
		db	0C4h,05Eh,008h,003h,0D8h,04Bh,08Ch,046h,0FEh,089h,05Eh; CODE_32:003D
		db	0FCh,0EBh,015h,0C4h,05Eh,0FCh,026h,08Ah,007h,03Ah,046h,006h,075h,007h	; CODE_32:004B
		db	08Bh,056h,0FEh,08Bh,0C3h,0EBh,021h,0FFh,04Eh,0FCh,08Bh,046h,0FCh,03Bh	; CODE_32:0059
		db	046h,008h,077h,0E3h,0C4h,05Eh,0FCh,026h,08Ah,007h,03Ah,046h,006h,075h	; CODE_32:0067
		db	007h,08Bh,056h,0FEh,08Bh,0C3h,0EBh,004h,033h,0D2h,08Bh	; CODE_32:0075

		db	0C2h,08Bh,0E5h,05Dh,0CAh,006h,000h	; moved from CODE_33:0000 (segment span per FBOV table)
CODE_32	ends
; END RSTRCHR
		end

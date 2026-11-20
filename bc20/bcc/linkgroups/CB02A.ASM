; Direct-segment relocation references
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B0F1:far
		extrn	BCC_FAR_B146:far
		extrn	BCC_SEG_21:far
		extrn	BCC_SEG_27:far
		public	BCC_SEG_42
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_42
; BEGIN SEARCHP (CODE_42:0000)
CODE_42	segment byte public 'CODE'
BCC_SEG_42	label far
		assume	cs:CODE_42
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh,008h,033h,0C0h,050h,0FFh,076h,008h,0FFh; CODE_42:0000
		db	076h,006h,09Ah,00Ah,000h
		dw	seg BCC_SEG_21
		db	083h,0C4h,006h,03Dh,0FFh,0FFh,074h; CODE_42:000E
		db	003h,0E9h,0E7h,000h,01Eh,0B8h,08Eh,05Ch,050h,09Ah,006h,000h
		dw	seg BCC_SEG_27
		db	089h,056h,0FEh,089h,046h,0FCh,00Bh,0C2h,075h,003h,0E9h,0CAh,000h,0C4h	; CODE_42:002A
		db	05Eh,0FCh,08Ch,046h,0FAh,089h,05Eh,0F8h,0EBh,003h,0FFh,046h,0F8h,0C4h	; CODE_42:0038
		db	05Eh,0F8h,026h,080h,03Fh,000h,074h,006h,026h,080h,03Fh,03Bh,075h,0EEh	; CODE_42:0046
		db	01Eh,0B8h,0CEh,08Bh,050h,0FFh,076h,0FEh,0FFh,076h,0FCh,08Bh,046h,0F8h	; CODE_42:0054
		db	033h,0D2h,02Bh,046h,0FCh,083h,0DAh,000h,050h,09Ah,001h,000h
		dw	seg BCC_FAR_B0F1
		db	08Bh,046h,0F8h,033h,0D2h,02Bh,046h,0FCh,083h,0DAh,000h,08Bh,0D8h,0C6h	; CODE_42:0070
		db	087h,0CEh,08Bh,000h,0C4h,05Eh,0F8h,043h,08Ch,046h,0FEh,089h,05Eh,0FCh	; CODE_42:007E
		db	01Eh,0B8h,0CEh,08Bh,050h,09Ah,002h,000h
		dw	seg BCC_FAR_AB12
		db	08Bh,0D8h,081h,0C3h; CODE_42:008C
		db	0CDh,08Bh,08Ch,0D8h,08Eh,0C0h,08Ch,046h,0FAh,089h,05Eh,0F8h,0B8h,0CEh	; CODE_42:009A
		db	08Bh,08Ch,0DAh,03Bh,0C3h,073h,021h,026h,080h,03Fh,03Ah,074h,01Bh,026h	; CODE_42:00A8
		db	080h,03Fh,02Fh,074h,015h,026h,080h,03Fh,05Ch,074h,00Fh,01Eh,0B8h,0CEh	; CODE_42:00B6
		db	08Bh,050h,01Eh,0B8h,093h,05Ch,050h,09Ah,006h,000h
		dw	seg BCC_FAR_B146
		db	01Eh,0B8h; CODE_42:00C4
		db	0CEh,08Bh,050h,0FFh,076h,008h,0FFh,076h,006h,09Ah,006h,000h
		dw	seg BCC_FAR_B146
		db	033h,0C0h,050h,01Eh,0B8h,0CEh,08Bh,050h,09Ah,00Ah,000h
		dw	seg BCC_SEG_21
		db	083h; CODE_42:00E0
		db	0C4h,006h,03Dh,0FFh,0FFh,075h,022h,0C4h,05Eh,0FCh,026h,080h,03Fh,000h	; CODE_42:00EE
		db	074h,003h,0E9h,036h,0FFh,033h,0D2h,08Bh,0C2h,0EBh,015h,01Eh,0B8h,0CEh	; CODE_42:00FC
		db	08Bh,050h,0FFh,076h,008h,0FFh,076h,006h,09Ah,002h,000h
		dw	seg BCC_DEBUG_BUILD
		db	0B8h; CODE_42:010A
		db	0CEh,08Bh,08Ch,0DAh,08Bh,0E5h,05Dh,0CAh	; CODE_42:0118

		db	004h,000h	; CODE_43:0000 (end of retf 4; segment 0AF5 runs to 0122h)
CODE_42	ends
; END SEARCHP
		end

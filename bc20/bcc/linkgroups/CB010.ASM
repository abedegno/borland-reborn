		public	BCC_SEG_16
; Direct-segment relocation references
		extrn	BCC_FAR_04CF:far
		extrn	BCC_FAR_AB12:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_16
; BEGIN RADDSL (CODE_16:0003)
CODE_16	segment byte public 'CODE'
BCC_SEG_16	label far
		assume	cs:CODE_16
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh,004h,056h,0FFh,076h,008h,0FFh
		db	076h,006h,09Ah,00Fh,005h
		dw	seg BCC_FAR_04CF
		db	0FFh,076h,008h,0FFh,076h,006h,09Ah; CODE_16:000E
		db	002h,000h
		dw	seg BCC_FAR_AB12
		db	08Bh,0F0h,0C4h,05Eh,006h,003h,0DEh,04Bh,08Ch,046h; CODE_16:001C
		db	0FEh,089h,05Eh,0FCh,00Bh,0F6h,07Eh,026h,026h,080h,03Fh,05Ch,074h,020h	; CODE_16:002A
		db	026h,080h,03Fh,02Fh,074h,01Ah,026h,080h,03Fh,03Ah,074h,014h,0FFh,046h	; CODE_16:0038
		db	0FCh,08Bh,05Eh,0FCh,026h,0C6h,007h,05Ch,0FFh,046h	; CODE_16:0046

		db	0FCh,08Bh,05Eh,0FCh,026h,0C6h,007h,000h,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h	; moved from CODE_17:0000 (segment span per FBOV table)
CODE_16	ends
; END RADDSL
		end

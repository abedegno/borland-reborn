; Direct-segment relocation references
		extrn	BCC_FAR_AB51:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_34
; BEGIN RSTRICMP (CODE_34:0008)
CODE_34	segment byte public 'CODE'
		assume	cs:CODE_34

		public	BCC_RF_1AAA_0008

BCC_RF_1AAA_0008	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,0EBh,036h,0C4h,05Eh,00Ah,026h,08Ah,007h,098h	; CODE_34:0008
		db	050h,09Ah,00Dh,000h
		dw	seg BCC_FAR_AB51
		db	088h,046h,0FEh,0C4h,05Eh,006h,026h,08Ah; CODE_34:0016
		db	007h,098h,050h,09Ah,00Dh,000h
		dw	seg BCC_FAR_AB51
		db	088h,046h,0FFh,08Ah,046h,0FEh; CODE_34:0024
		db	03Ah,046h,0FFh,07Ch,020h,08Ah,046h,0FEh,03Ah,046h,0FFh,07Fh,026h,0FFh	; CODE_34:0032
		db	046h,00Ah,0FFh,046h,006h,0C4h,05Eh,00Ah,026h,080h,03Fh,000h,075h,0C1h	; CODE_34:0040
		db	0C4h,05Eh,006h,026h,080h,03Fh,000h,07Eh,005h,0B8h,0FFh,0FFh,0EBh,010h	; CODE_34:004E
		db	0C4h,05Eh,006h,026h,080h,03Fh,000h,07Dh,005h,0B8h,001h,000h,0EBh,002h	; CODE_34:005C
		db	033h,0C0h,08Bh,0E5h,05Dh,0CAh	; CODE_34:006A

		db	008h,000h	; moved from CODE_35:0000 (segment span per FBOV table)
CODE_34	ends
; END RSTRICMP
		end

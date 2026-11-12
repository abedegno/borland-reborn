; Direct-segment relocation references
		extrn	BCC_FAR_245C:far
		public	BCC_SEG_03
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_3
; BEGIN LG004 (gap CODE_3:0000)
CODE_3	segment byte public 'CODE'
BCC_SEG_03	label far
		assume	cs:CODE_3
; Original-image layout stub: not recovered source


		db	000h	; CODE_3:0003, padding between segments
CODE_3	ends
; END LG004
; BEGIN R3OVR (CODE_3:0004)
CODE_3	segment byte public 'CODE'
		assume	cs:CODE_3
		db	055h,08Bh,0ECh,083h,0ECh,002h,053h,051h,056h,057h	; CODE_3:0004
		db	01Eh,0C4h,05Eh,006h,08Ch,0C2h,032h,016h,01Ah,000h,08Eh,0C2h,053h,026h	; CODE_3:000E
		db	08Bh,016h,010h,000h,0C7h,046h,0FEh,000h,000h,00Bh,0D2h,075h,059h,08Bh	; CODE_3:001C
		db	046h,004h,01Eh,006h,09Ah,0D4h,04Dh
		dw	seg BCC_FAR_245C
		db	007h,01Fh,072h,011h,01Eh; CODE_3:002A
		db	006h,089h,046h,0FEh,050h,0B8h,00Eh,000h,050h,09Ah,0B4h,01Fh
		dw	seg BCC_FAR_245C
		db	007h,01Fh,006h,006h,0B8h,010h,000h,050h,006h,050h,026h,0A1h,008h,000h	; CODE_3:0046
		db	026h,003h,006h,00Ah,000h,005h,010h,000h,050h,09Ah,01Ch,01Bh
		dw	seg BCC_FAR_245C
		db	09Ah,07Dh,045h
		dw	seg BCC_FAR_245C
		db	08Bh,046h,0FEh,00Bh,0C0h,074h,00Eh,01Eh,006h; CODE_3:0062
		db	050h,0B8h,00Eh,000h,050h,09Ah,0E9h,01Fh
		dw	seg BCC_FAR_245C
		db	007h,01Fh,007h,09Ah; CODE_3:0070
		db	0F1h,04Ah
		dw	seg BCC_FAR_245C
		db	026h,08Bh,016h,010h,000h,081h,0FAh,000h,010h,077h; CODE_3:007E
		db	045h,08Bh,046h,004h,01Eh,006h,09Ah,0D4h,04Dh
		dw	seg BCC_FAR_245C
		db	007h,01Fh,072h; CODE_3:008C
		db	011h,01Eh,006h,089h,046h,0FEh,050h,0B8h,00Eh,000h,050h,09Ah,0B4h,01Fh	; CODE_3:009A
		dw	seg BCC_FAR_245C
		db	007h,01Fh,006h,006h,0B8h,010h,000h,050h,09Ah,08Bh,045h
		dw	seg BCC_FAR_245C
		db	007h,08Bh,046h,0FEh,00Bh,0C0h,074h,00Eh,01Eh,006h,050h,0B8h,00Eh; CODE_3:00A8
		db	000h,050h,09Ah,0E9h,01Fh
		dw	seg BCC_FAR_245C
		db	007h,01Fh,026h,08Bh,016h; CODE_3:00C4

		db	010h,000h,058h,01Fh,05Fh,05Eh,059h,05Bh,08Bh,0E5h,05Dh,0CAh,004h,000h	; moved from CODE_4:0000 (segment span per FBOV table)
CODE_3	ends
; END R3OVR
		end

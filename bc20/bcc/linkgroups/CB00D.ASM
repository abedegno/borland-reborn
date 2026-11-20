; Direct-segment relocation references
		extrn	BCC_FAR_A17D:far
		extrn	BCC_FAR_970B:far
		public	BCC_SEG_13
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_13
; BEGIN RPOW10 (CODE_13:000C)
CODE_13	segment byte public 'CODE'
BCC_SEG_13	label far
		assume	cs:CODE_13
; Original-image layout stub: not recovered source


		db	055h,08Bh	; CODE_13:000C
		db	0ECh,083h,0ECh,00Ah,056h,057h,08Bh,076h,00Ah,00Bh,0F6h,074h,065h,079h	; CODE_13:000E
		db	002h,0F7h,0DEh,081h,0FEh,087h,013h,076h,003h,0BEh,087h,013h,0BBh,007h	; CODE_13:001C
		db	000h,023h,0DEh,0D1h,0E3h,0D1h,0E3h,081h,0C3h,0FCh,05Ah,0FFh,077h,002h	; CODE_13:002A
		db	0FFh,037h,08Dh,046h,0F6h,016h,050h,09Ah,09Dh,001h
		dw	seg BCC_FAR_A17D
		db	0B1h,003h; CODE_13:0038
		db	0D3h,0EEh,0BFh,01Ch,05Bh,00Bh,0F6h,074h,015h,0D1h,0EEh,073h,00Ch,08Dh	; CODE_13:0046
		db	046h,0F6h,016h,050h,01Eh,057h,09Ah,063h,002h
		dw	seg BCC_FAR_970B
		db	083h,0C7h,00Ah; CODE_13:0054
		db	0EBh,0E7h,0C4h,046h,006h,006h,050h,08Dh,046h,0F6h,016h,050h,083h,07Eh	; CODE_13:0062
		db	00Ah,000h,079h,007h,09Ah,04Eh,004h
		dw	seg BCC_FAR_970B
		db	0EBh,005h,09Ah,063h,002h; CODE_13:0070
		dw	seg BCC_FAR_970B

		db	05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h	; moved from CODE_14:0000 (segment span per FBOV table)
CODE_13	ends
; END RPOW10
		end

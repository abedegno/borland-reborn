; Direct-segment relocation references
		extrn	BCC_FAR_A45B:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_25
; BEGIN RFFIND (CODE_25:0002)
CODE_25	segment byte public 'CODE'
		assume	cs:CODE_25

		public	BCC_RF_1A86_0002
		public	BCC_RF_1A86_0033

BCC_RF_1A86_0002	label	far
		db	055h,08Bh,0ECh,0B8h,01Ah,000h,050h,0FFh,076h,00Ah,0FFh,076h,008h,033h	; CODE_25:0002
		db	0C0h,050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_A45B
		db	01Eh,0C5h,056h,00Ch,08Bh,04Eh,006h; CODE_25:0010
		db	0B4h,04Eh,0CDh,021h,01Fh,073h,008h,0A3h,000h,000h,0B8h,0FFh,0FFh,0EBh	; CODE_25:001E
		db	002h,033h,0C0h,05Dh,0CAh,00Ah,000h	; CODE_25:002C
BCC_RF_1A86_0033	label	far
		db	055h,08Bh,0ECh,0B8h,01Ah,000h,050h,0FFh,076h,008h,0FFh,076h,006h,033h	; CODE_25:0033
		db	0C0h,050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_A45B
		db	0B4h,04Fh,0CDh,021h,073h,008h,0A3h; CODE_25:0041
		db	000h	; CODE_25:004F

		db	000h,0B8h,0FFh,0FFh,0EBh,002h,033h,0C0h,05Dh,0CAh,004h,000h	; moved from CODE_26:0000 (segment span per FBOV table)
CODE_25	ends
; END RFFIND
		end

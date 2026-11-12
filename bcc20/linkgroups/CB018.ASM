; Direct-segment relocation references
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_SEG_180:far
		public	BCC_SEG_24
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_24
; BEGIN REXEC (CODE_24:0001)
CODE_24	segment byte public 'CODE'
BCC_SEG_24	label far
		assume	cs:CODE_24
; Original-image layout stub: not recovered source


		db	055h
		db	08Bh,0ECh,08Bh,0C4h,0A3h,04Ch,08Bh,08Ch,0D0h,0A3h,04Ah,08Bh; CODE_24:0000
		db	08Bh,016h,012h,000h,0B8h,080h,000h,052h,050h,0FFh,076h,00Eh,0FFh,076h	; CODE_24:000E
		db	00Ch,09Ah,002h,000h
		dw	seg BCC_DEBUG_BUILD
		db	0C4h,05Eh,006h,08Eh,01Eh,012h,000h,0BAh; CODE_24:001C
		db	080h,000h,0B4h,04Bh,08Ah,046h,00Ah,0CDh,021h,0BAh
		dw	seg BCC_SEG_180
		db	08Eh,0DAh; CODE_24:002A
		db	0FAh,08Eh,016h,04Ah,08Bh,08Bh,026h,04Ch,08Bh,0FBh,08Bh,0ECh,073h,008h	; CODE_24:0038
		db	0A3h,000h,000h,0B8h,0FFh,0FFh,0EBh,010h,080h,07Eh,00Ah,000h,075h,006h	; CODE_24:0046
		db	0B4h,04Dh,0CDh,021h,0EBh,004h,033h,0C0h,0EBh,000h,05Dh,0CAh	; CODE_24:0054

		db	00Ah,000h	; moved from CODE_25:0000 (segment span per FBOV table)
CODE_24	ends
; END REXEC
		end

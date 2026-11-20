DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_18
; BEGIN RDOSPTR (CODE_18:000B)
CODE_18	segment byte public 'CODE'
		assume	cs:CODE_18

		public	BCC_FAR_A45B

BCC_FAR_A45B	label	far
		db	055h,08Bh,0ECh,08Ah,066h,00Ch,01Eh,0C5h,056h,008h,0F8h,0CDh,021h,01Fh	; CODE_18:000B
		db	073h,006h,0A3h,000h,000h,0B8h,0FFh	; CODE_18:0019

		db	0FFh,05Dh,0CAh,008h,000h	; moved from CODE_19:0000 (segment span per FBOV table)
CODE_18	ends
; END RDOSPTR
		end

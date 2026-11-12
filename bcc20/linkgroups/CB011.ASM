DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_17
; BEGIN RDOSAH (CODE_17:000F)
CODE_17	segment byte public 'CODE'
		assume	cs:CODE_17

		public	BCC_RF_1A44_000F

BCC_RF_1A44_000F	label	far
		db	055h	; CODE_17:000F

		db	08Bh,0ECh,08Ah,066h,00Ah,0CDh,021h,05Dh,0CAh,006h,000h	; moved from CODE_18:0000 (segment span per FBOV table)
CODE_17	ends
; END RDOSAH
		end

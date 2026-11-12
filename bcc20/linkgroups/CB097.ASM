DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_151
; BEGIN RC151 (listing CODE_151:0000)
CODE_151	segment byte public 'CODE'
		assume	cs:CODE_151

		public	BCC_FAR_D760

		db	0CDh,03Fh,000h,000h,010h,01Eh,005h,000h,0B1h,002h,000h,000h,001h,000h	; CODE_151:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_151:000E
		db	000h,000h,000h,000h	; CODE_151:001C
BCC_FAR_D760	label	far
		db	0EAh,000h,000h,06Ah,0A5h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_151:0020
		db	000h,000h	; CODE_151:002E

CODE_151	ends
; END RC151
		end

DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_158
; BEGIN RC158 (listing CODE_158:0000)
CODE_158	segment byte public 'CODE'
		assume	cs:CODE_158

		public	BCC_FAR_D980
		public	BCC_FAR_D985
		public	BCC_FAR_D98A
		public	BCC_FAR_D98F
		public	BCC_FAR_D994
		public	BCC_FAR_D999
		public	BCC_FAR_D99E
		public	BCC_FAR_D9A3
		public	BCC_FAR_D9A8
		public	BCC_FAR_D9AD
		public	BCC_FAR_D9B2
		public	BCC_FAR_D9B7
		public	BCC_FAR_D9BC

		db	0CDh,03Fh,000h,000h,0D0h,06Bh,005h,000h,0F3h,009h,010h,000h,00Dh,000h	; CODE_158:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_158:000E
		db	000h,000h,000h,000h	; CODE_158:001C
BCC_FAR_D980	label	far
		db	0EAh,019h,000h,029h,0AAh	; CODE_158:0020
BCC_FAR_D985	label	far
		db	0EAh,000h,000h,029h,0AAh	; CODE_158:0025
BCC_FAR_D98A	label	far
		db	0EAh,0C2h,000h,029h,0AAh	; CODE_158:002A
BCC_FAR_D98F	label	far
		db	0EAh,0A3h,000h,029h,0AAh	; CODE_158:002F
BCC_FAR_D994	label	far
		db	0EAh,0FAh,001h,029h,0AAh	; CODE_158:0034
BCC_FAR_D999	label	far
		db	0EAh,05Eh,000h,029h,0AAh	; CODE_158:0039
BCC_FAR_D99E	label	far
		db	0EAh,0D7h,001h,029h,0AAh	; CODE_158:003E
BCC_FAR_D9A3	label	far
		db	0EAh,0B6h,001h,029h,0AAh	; CODE_158:0043
BCC_FAR_D9A8	label	far
		db	0EAh,093h,001h,029h,0AAh	; CODE_158:0048
BCC_FAR_D9AD	label	far
		db	0EAh,06Eh,001h,029h,0AAh	; CODE_158:004D
BCC_FAR_D9B2	label	far
		db	0EAh,032h,001h,029h,0AAh	; CODE_158:0052
BCC_FAR_D9B7	label	far
		db	0EAh,0DFh,000h,029h,0AAh	; CODE_158:0057
BCC_FAR_D9BC	label	far
		db	0EAh,0E3h,009h,029h,0AAh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_158:005C
		db	000h,000h,000h,000h,000h,000h	; CODE_158:006A

CODE_158	ends
; END RC158
		end

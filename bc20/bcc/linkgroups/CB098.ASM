DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_152
; BEGIN RC152 (listing CODE_152:0000)
CODE_152	segment byte public 'CODE'
		assume	cs:CODE_152

		public	BCC_FAR_D790
		public	BCC_FAR_D795
		public	BCC_FAR_D79A
		public	BCC_FAR_D79F
		public	BCC_FAR_D7A4
		public	BCC_FAR_D7A9
		public	BCC_FAR_D7AE
		public	BCC_FAR_D7B3
		public	BCC_FAR_D7B8
		public	BCC_FAR_D7BD
		public	BCC_FAR_D7C2
		public	BCC_FAR_D7C7
		public	BCC_FAR_D7CC

		db	0CDh,03Fh,000h,000h,0D0h,020h,005h,000h,06Dh,010h,000h,000h,00Dh,000h	; CODE_152:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_152:000E
		db	000h,000h,000h,000h	; CODE_152:001C
BCC_FAR_D790	label	far
		db	0EAh,0AFh,002h,096h,0A5h	; CODE_152:0020
BCC_FAR_D795	label	far
		db	0EAh,0F9h,002h,096h,0A5h	; CODE_152:0025
BCC_FAR_D79A	label	far
		db	0EAh,000h,000h,096h,0A5h	; CODE_152:002A
BCC_FAR_D79F	label	far
		db	0EAh,03Eh,002h,096h,0A5h	; CODE_152:002F
BCC_FAR_D7A4	label	far
		db	0EAh,053h,002h,096h,0A5h	; CODE_152:0034
BCC_FAR_D7A9	label	far
		db	0EAh,08Ah,002h,096h,0A5h	; CODE_152:0039
BCC_FAR_D7AE	label	far
		db	0EAh,0BEh,003h,096h,0A5h	; CODE_152:003E
BCC_FAR_D7B3	label	far
		db	0EAh,0B7h,002h,096h,0A5h	; CODE_152:0043
BCC_FAR_D7B8	label	far
		db	0EAh,018h,004h,096h,0A5h	; CODE_152:0048
BCC_FAR_D7BD	label	far
		db	0EAh,067h,002h,096h,0A5h	; CODE_152:004D
BCC_FAR_D7C2	label	far
		db	0EAh,0D3h,002h,096h,0A5h	; CODE_152:0052
BCC_FAR_D7C7	label	far
		db	0EAh,030h,003h,096h,0A5h	; CODE_152:0057
BCC_FAR_D7CC	label	far
		db	0EAh,0A7h,002h,096h,0A5h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_152:005C
		db	000h,000h,000h,000h,000h,000h	; CODE_152:006A

CODE_152	ends
; END RC152
		end

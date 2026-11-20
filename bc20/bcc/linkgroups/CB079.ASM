DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_121
; BEGIN RC121 (listing CODE_121:0000)
CODE_121	segment byte public 'CODE'
		assume	cs:CODE_121

		public	BCC_FAR_CE85
		public	BCC_FAR_CE8A
		public	BCC_FAR_CE8F
		public	BCC_FAR_CE94

		db	0CDh,03Fh,000h,000h,060h,0B6h,003h,000h,051h,001h,008h,000h,005h,000h	; CODE_121:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_121:000E
		db	000h,000h,000h,000h,0EAh,010h,001h,043h,08Dh	; CODE_121:001C
		public	BCC_STMT_ALLOC_FIELD
BCC_STMT_ALLOC_FIELD	label	far
BCC_FAR_CE85	label	far
		db	0EAh,000h,000h,043h,08Dh	; CODE_121:0025
		public	BCC_STMT_FORMAT
BCC_STMT_FORMAT	label	far
BCC_FAR_CE8A	label	far
		db	0EAh,0E5h,000h,043h,08Dh	; CODE_121:002A
		public	BCC_MACRO_ALLOC
BCC_MACRO_ALLOC	label	far
		public	BCC_POOL_ALLOC
BCC_POOL_ALLOC	label	far
		public	BCC_POOL_ALLOCATE
BCC_POOL_ALLOCATE	label	far
		public	BCC_RF_1CE6_002F
BCC_RF_1CE6_002F	label	far
BCC_FAR_CE8F	label	far
		db	0EAh,056h,000h,043h,08Dh	; CODE_121:002F
BCC_FAR_CE94	label	far
		db	0EAh,036h,000h,043h,08Dh,000h,000h,000h,000h,000h,000h,000h	; CODE_121:0034

CODE_121	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC121
		end

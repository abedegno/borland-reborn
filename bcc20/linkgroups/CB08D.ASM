DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_141
; BEGIN RC141 (listing CODE_141:0000)
CODE_141	segment byte public 'CODE'
		assume	cs:CODE_141

		public	BCC_FAR_D435
		public	BCC_FAR_D43A
		public	BCC_FAR_D43F
		public	BCC_FAR_D444
		public	BCC_FAR_D449
		public	BCC_FAR_D44E
		public	BCC_FAR_D458
		public	BCC_FAR_D45D
		public	BCC_FAR_D462
		public	BCC_FAR_D46C
		public	BCC_FAR_D471
		public	BCC_FAR_D476

		db	0CDh,03Fh,000h,000h,0E0h,0B5h,004h,000h,0A9h,00Dh,020h,000h,00Fh,000h	; CODE_141:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_141:000E
		db	000h,000h,000h,000h,0EAh,059h,005h,0B4h,09Eh	; CODE_141:001C
		public	BCC_DEBUG_WRITE
BCC_DEBUG_WRITE	label	far
BCC_FAR_D435	label	far
		db	0EAh,054h,000h,0B4h,09Eh	; CODE_141:0025
BCC_FAR_D43A	label	far
		db	0EAh,0EFh,000h,0B4h,09Eh	; CODE_141:002A
		public	BCC_HEAP_RESET
BCC_HEAP_RESET	label	far
BCC_FAR_D43F	label	far
		db	0EAh,000h,000h,0B4h,09Eh	; CODE_141:002F
		public	BCC_DEBUG_MARK
BCC_DEBUG_MARK	label	far
BCC_FAR_D444	label	far
		db	0EAh,00Bh,000h,0B4h,09Eh	; CODE_141:0034
		public	BCC_HEAP_AVAILABLE
BCC_HEAP_AVAILABLE	label	far
		public	BCC_HEAP_CHECK
BCC_HEAP_CHECK	label	far
BCC_FAR_D449	label	far
		db	0EAh,049h,000h,0B4h,09Eh	; CODE_141:0039
		public	BCC_HEAP_ERROR
BCC_HEAP_ERROR	label	far
BCC_FAR_D44E	label	far
		db	0EAh,09Ah,000h,0B4h,09Eh,0EAh,0C1h,004h,0B4h,09Eh	; CODE_141:003E
BCC_FAR_D458	label	far
		db	0EAh,012h,001h,0B4h,09Eh	; CODE_141:0048
		public	BCC_DEBUG_FREE
BCC_DEBUG_FREE	label	far
BCC_FAR_D45D	label	far
		db	0EAh,01Fh,000h,0B4h,09Eh	; CODE_141:004D
		public	BCC_RF_1D41_0052
BCC_RF_1D41_0052	label	far
BCC_FAR_D462	label	far
		db	0EAh,0A1h,00Dh,0B4h,09Eh,0EAh,0BDh,008h,0B4h,09Eh	; CODE_141:0052
BCC_FAR_D46C	label	far
		db	0EAh,047h,004h,0B4h,09Eh	; CODE_141:005C
BCC_FAR_D471	label	far
		db	0EAh,0AEh,001h,0B4h,09Eh	; CODE_141:0061
		public	BCC_HEAP_FREE
BCC_HEAP_FREE	label	far
BCC_FAR_D476	label	far
		db	0EAh,07Fh,000h,0B4h,09Eh,000h,000h,000h,000h,000h	; CODE_141:0066

CODE_141	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC141
		end

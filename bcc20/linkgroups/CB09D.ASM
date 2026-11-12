DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_157
; BEGIN RC157 (listing CODE_157:0000)
CODE_157	segment byte public 'CODE'
		assume	cs:CODE_157

		public	BCC_FAR_D940

		db	0CDh,03Fh,000h,000h,040h,06Ah,005h,000h,079h,001h,006h,000h,004h,000h	; CODE_157:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_157:000E
		db	000h,000h,000h,000h	; CODE_157:001C
BCC_FAR_D940	label	far
		db	0EAh,04Bh,001h,011h,0AAh
		public	BCC_RF_1D92_0025
BCC_RF_1D92_0025	label	far
		db	0EAh,057h,000h,011h,0AAh,0EAh,0C5h,000h,011h; CODE_157:0020
		db	0AAh,0EAh,000h,000h,011h,0AAh,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_157:002E
		db	000h,000h,000h,000h	; CODE_157:003C

CODE_157	ends
; Target-qualified reference aliases (zero bytes)
; END RC157
		end

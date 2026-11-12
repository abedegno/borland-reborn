		public	BCC_SEG_52
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CB034
CODE_52	segment byte public 'OVRDATA'
BCC_SEG_52	label far
		assume	cs:CODE_52
; Original-image layout stub: not recovered source

		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_52:0000
		db	000h,000h	; CODE_52:000E

CODE_52	ends
		end

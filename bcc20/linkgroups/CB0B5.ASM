; Consolidated original-order group CB0B5
_BSS	segment byte public 'DATA'
		assume	cs:_BSS
; Original-image layout stub: not recovered source

		db	054h,048h,000h,02Fh,000h,000h	; _BSS:0000
		db	12202 dup (?)

_BSS	ends
		end

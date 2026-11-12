DGROUP	group	_DATA,_BSS
_DATA	segment word public 'DATA'
_DATA	ends
_BSS	segment word public 'BSS'
_BSS	ends
; Consolidated original-order group CB0B8
_OVRTEXT_	segment byte public 'CODE'
		assume	cs:_OVRTEXT_
; Original-image layout stub: not recovered source

		db	021h,083h,07Eh,0F8h,000h,075h,00Eh,0B8h,0C4h,000h,050h,09Ah,039h,000h	; _OVRTEXT_:0000
		db	088h,002h	; _OVRTEXT_:000E

_OVRTEXT_	ends
		end

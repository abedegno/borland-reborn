DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CB033A
_OVERLAY_	segment byte public 'OVRINFO'
		assume	cs:_OVERLAY_
; Original-image layout stub: not recovered source

		db	0CDh,03Fh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:000E
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:001C
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:002A
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:0038
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,056h,044h	; _OVERLAY_:0046
		db	049h,053h,04Bh,020h,046h,041h,04Bh,045h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:0054
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:0062
		db	000h,000h,000h,000h,000h,000h,000h,001h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:0070
		db	000h,02Eh,0FFh,02Eh,02Fh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; _OVERLAY_:007E
		db	000h,000h,000h,000h	; _OVERLAY_:008C

_OVERLAY_	ends
		end

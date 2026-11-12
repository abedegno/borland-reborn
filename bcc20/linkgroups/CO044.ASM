		public	X044_00
		public	X044_01
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cec_8d59
; BEGIN LG0B9 (gap ovr_1cec_8d59:D590)
CO044_TEXT	segment byte public 'CODE'
		assume	cs:CO044_TEXT
; Original-image layout stub: not recovered source


X044_00	label	far
X044_01	label	far
		db	000h; ovr_1cec_8d59:D590

CO044_TEXT	ends
; END LG0B9
		end

		public	X042_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1ce5_8d42
; BEGIN C70S42 (listing ovr_1ce5_8d42:D420)
CO042_TEXT	segment byte public 'CODE'
		assume	cs:CO042_TEXT
; Original-image layout stub: not recovered source


X042_00	label	far
		db	000h; ovr_1ce5_8d42:D420

CO042_TEXT	ends
; END C70S42
		end

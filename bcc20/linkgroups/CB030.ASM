DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Original uninitialized storage recovered from CODE_48
CODE_48	segment byte public 'BSS'
CODE_48	ends
		end

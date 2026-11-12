		public	BCC_SEG_47
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Original uninitialized storage recovered from CODE_47
CODE_47	segment byte public 'BSS'
BCC_SEG_47	label far
CODE_47	ends
		end

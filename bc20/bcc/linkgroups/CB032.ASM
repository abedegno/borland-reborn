		public	BCC_SEG_50
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Original uninitialized storage recovered from CODE_50
CODE_50	segment word public 'BSS'
BCC_SEG_50	label far
CODE_50	ends
CODE_50A	segment byte public 'BSS'
CODE_50A	ends
CODE_50B	segment byte public 'BSS'
CODE_50B	ends
		end

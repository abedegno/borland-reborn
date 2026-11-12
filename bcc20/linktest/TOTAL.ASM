DGROUP	group	DATA0,STACK0,LAST0
DATA0	segment byte public 'DATA'
	db	5 dup (0)
DATA0	ends
STACK0	segment byte stack 'STACK'
	db	100 dup (?)
STACK0	ends
LAST0	segment byte public 'ENDCODE'
	db	4 dup (0)
LAST0	ends
	end

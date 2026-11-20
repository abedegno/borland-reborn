	.286p
	locals
S000	segment byte public 'CODE'
S000	ends
S50A	segment para public 'CODE'
S50A	ends
S589	segment para public 'CODE'
S589	ends
S59F	segment para public 'CODE'
S59F	ends
S5AD	segment para public 'CODE'
S5AD	ends
S5ED	segment para public 'CODE'
S5ED	ends
S5FD	segment para public 'CODE'
S5FD	ends
S8EF	segment para public 'CODE'
S8EF	ends
S8F6	segment para public 'CODE'
S8F6	ends
S908	segment para public 'CODE'
S908	ends
S9CF	segment para public 'CODE'
S9CF	ends
S9D2	segment para stack 'CODE'
S9D2	ends
S9F3	segment para public 'CODE'
S9F3	ends
S9FA	segment byte public 'CODE'
S9FA	ends
SBB9	segment para public 'CODE'
SBB9	ends
SD33	segment para public 'BSS'
SD33	ends

	public	FA0_START
	extrn	L0A471:byte

S9FA	segment byte public 'CODE'
	assume	cs:S9FA
FA0_START	db	2Eh, 0FFh, 2Eh, 5, 0	;@09FA0
	dd	L0A471
S9FA	ends
	end

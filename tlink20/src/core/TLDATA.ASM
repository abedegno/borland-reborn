	.286
	locals
	public	D1019_START
	public	B117E_START

TLDATA	segment para public 'TLDATA'
D1019_START	db	'Internal undefined error', 0, 'Unable to open file ', 27h, 25h	;@10190
	db	73h, 27h, 0, 'Write failed, disk full?', 0, 'Out of memory', 0
	db	'DOS error, ax = %d', 0, 'Bad object file %s', 0, 'Invalid segment definition'
	db	0, 'Illegal group definition: %s', 0, 'Table limit exceeded', 0
	db	'Group %s exceeds 64K', 0, 'Segment %s exceeds 64K', 0, 'Invalid initial stack offset'
	db	0, 'Bad version number in parameter block', 0, '%s (%d) : Syntax error'
	db	0, '%s (%d) : File read error', 0, '%s (%d) : Missing internal name'
	db	0, '%s (%d) : Incompatible attribute', 0, 'Segment alignment factor too small'
	db	0, 'Segment too large for segment table', 0, 'Cannot generate COM file : stack segment present'
	db	0, 'Cannot generate COM file : program exceeds 64K', 0, 'Cannot generate COM file : invalid initial entry p'
	db	'oint address', 0, 'Cannot generate COM file : segment-relocatable ite'
	db	'ms present', 0, 'Cannot generate COM file : data below initial CS:I'
	db	'P defined', 0, 'Relocation offset overflow', 0, 'Not enough memory'
	db	0, 'Unknown option', 0, 'Bad character in parameters', 0, 'Relocation table overflow'
	db	0, '32-bit record encountered', 0, 'Internal linker error %d'
	db	0, 'Debugging information overflow; try fewer modules ', 'with debug info'
	db	0, 'Limit of 254 segments for new executable file exce', 'eded'
	db	0, 'Stub program exceeds 64K', 0, 'Relocation item exceeds 1Meg DOS limit'
	db	0, 'Fixup overflow at %s, target = %s', 0, '%s is duplicated'
	db	0, '%s defined in module %s is duplicated', 0, 'Undefined symbol %s'
	db	0, 'Program entry point may not reside in an overlay', 0, 'Too many error or warning messages'
	db	0, 'Invalid entry point offset', 0, 'Common segment exceeds 64K'
	db	0, 'Invalid size specified for segment packing', 0, 'Automatic data segment exceeds 64K'
	db	0, 'Invalid size specified for segment alignment', 0, 'Imported references from VIRDEFs not supported'
	db	0, 'User Break', 0, '%s is duplicated', 0, '%s defined in module %s is duplicated'
	db	0, 'No stack', 0, '%s conflicts with module %s', 0, 'No stub for fixup at %s:%s'
	db	0, 'Segment %s is in two groups: %s', 0, 'Group %s overlaps group %s'
	db	0, 'Overlays generated and no overlay manager included', 0, 'No automatic data segment'
	db	0, 'Invalid entry at %x:%x; application may not work i', 'n real mode'
	db	0, 'Attempt to export non-public symbol %s', 0, 'No program starting address defined'
	db	0, 'Overlays ignored in new executable images', 0, 'Duplicate ordinal (%d) in exports'
	db	0, '%s (%d) : Duplicate external name in exports', 0, '%s (%d) : Duplicate internal name in exports'
	db	0, '%s (%d) : Duplicate internal name in imports', 0, 'Debug info switch ignored for COM files'
	db	0, 'No module definition file specified: using default', 73h, 0
	db	0, 0, 19h, 0, 32h, 0, 4Bh, 0, 59h, 0, 6Ch, 0, 7Fh, 0, 9Ah, 0, 0B7h
	db	0, 0CCh, 0, 0E1h, 0, 0F8h, 0, 15h, 1, 3Bh, 1, 52h, 1, 6Ch, 1, 8Ch
	db	1, 0ADh, 1, 0D0h, 1, 0F4h, 1, 25h, 2, 54h, 2, 93h, 2, 0D0h, 2
	db	0Ch, 3, 27h, 3, 39h, 3, 48h, 3, 64h, 3, 7Eh, 3, 98h, 3, 0B1h, 3
	db	0F3h, 3, 2Ah, 4, 43h, 4, 6Ah, 4, 8Ch, 4, 9Dh, 4, 0C3h, 4, 0D7h
	db	4, 8, 5, 2Bh, 5, 46h, 5, 61h, 5, 8Ch, 5, 0AFh, 5, 0DCh, 5, 0Bh
	db	6, 16h, 6, 27h, 6, 4Dh, 6, 56h, 6, 72h, 6, 8Dh, 6, 0ADh, 6, 0C8h
	db	6, 0FBh, 6, 15h, 7, 53h, 7, 7Ah, 7, 9Eh, 7, 0C8h, 7, 0EAh, 7, 17h
	db	8, 44h, 8, 71h, 8, 99h, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0
TLDATA	ends

_STACK	segment para stack 'STACK'
	db	800h dup (0)	;@10AF0
_STACK	ends

TLBSS	segment para public 'BSS'
B117E_START	db	7AC0h dup (?)	;@117E0
TLBSS	ends
	end

	.286p
	locals

Y0DF90	segment para public 'CODE'
	assume	cs:Y0DF90
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 43h	;@0DF90
	db	0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0C0h
	db	0ECh, 5, 0, 0F5h, 5, 4Ch, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
Y0DF90	ends

Y0DFD0	segment para public 'CODE'
	assume	cs:Y0DFD0
	db	0CDh, 3Fh, 70h, 3, 0, 0CDh, 3Fh, 11h, 1, 0, 0CDh, 3Fh, 0C1h, 5	;@0DFD0
	db	0, 0CDh, 3Fh, 59h, 3, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0CDh, 3Fh, 0, 0, 10h, 0F3h, 5, 0, 9Dh, 6, 54h, 0, 1, 0, 0, 0
Y0DFD0	ends

Y0E000	segment para public 'CODE'
	assume	cs:Y0E000
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0E000
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 10h, 0FAh
	db	5, 0, 57h, 10h, 4Ah, 1, 14h, 0, 0, 0
Y0E000	ends

Y0E030	segment para public 'CODE'
	assume	cs:Y0E030
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0CDh	;@0E030
	db	5, 0, 0CDh, 3Fh, 2Ch, 5, 0, 0CDh, 3Fh, 38h, 8, 0, 0CDh
Y0E030	ends

Y0E050	segment para public 'CODE'
	assume	cs:Y0E050
	db	3Fh, 22h, 0Fh, 0, 0CDh, 3Fh, 3, 1, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh	;@0E050
	db	3Fh, 48h, 0Fh, 0, 0CDh, 3Fh, 0DAh, 0Eh, 0, 0CDh, 3Fh, 5Dh, 3, 0
	db	0CDh, 3Fh, 0E6h, 6, 0, 0CDh, 3Fh, 59h, 0, 0, 0CDh, 3Fh, 4Ah, 0
	db	0, 0CDh, 3Fh, 0A5h, 4
Y0E050	ends

Y0E080	segment para public 'CODE'
	assume	cs:Y0E080
	db	0, 0CDh, 3Fh, 81h, 0, 0, 0CDh, 3Fh, 72h, 0, 0, 0CDh, 3Fh, 0EDh	;@0E080
	db	4, 0, 0CDh, 3Fh, 70h, 2, 0, 0CDh, 3Fh, 2, 6, 0, 0CDh, 3Fh, 96h
	db	0, 0, 0CDh, 3Fh, 1Eh, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0E080	ends

Y0E0B0	segment para public 'CODE'
	assume	cs:Y0E0B0
	db	0CDh, 3Fh, 0, 0, 0C0h, 0Bh, 6, 0, 3Eh, 6, 7Ch, 0, 0Dh, 0, 0, 0	;@0E0B0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 41h
	db	3, 0, 0CDh, 3Fh, 0E3h, 5, 0, 0CDh, 3Fh, 0B9h, 1, 0, 0CDh, 3Fh
	db	0E2h, 1, 0, 0CDh, 3Fh, 8, 6, 0, 0CDh, 3Fh, 4Ah, 2, 0, 0CDh, 3Fh
Y0E0B0	ends

Y0E0F0	segment para public 'CODE'
	assume	cs:Y0E0F0
	db	0, 0, 0, 0CDh, 3Fh, 6Eh, 4, 0, 0CDh, 3Fh, 0A3h, 4, 0, 0CDh, 3Fh	;@0E0F0
	db	58h, 3, 0, 0CDh, 3Fh, 2Dh, 1, 0, 0CDh, 3Fh, 0E3h, 3, 0, 0CDh, 3Fh
	db	0CAh, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0E0F0	ends

Y0E120	segment para public 'CODE'
	assume	cs:Y0E120
	db	0CDh, 3Fh, 0, 0, 90h, 12h, 6, 0, 0C7h, 7, 62h, 0, 2, 0, 0, 0, 0	;@0E120
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 3Dh, 7
	db	0, 0CDh, 3Fh, 0F2h, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0C0h
	db	1Ah, 6, 0, 0C0h, 2, 28h, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0F0h, 1, 0, 0CDh, 3Fh, 5Eh
	db	1, 0, 0CDh, 3Fh, 0E7h, 1, 0, 0CDh, 3Fh, 67h, 1, 0, 0CDh, 3Fh, 92h
	db	1, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6Ah, 8Eh, 0, 0, 0, 0, 0
	db	0
Y0E120	ends

Y0E1B0	segment para public 'CODE'
	assume	cs:Y0E1B0
	db	'Borland C++  Version 2.0 Copyright (c) 1991 Borlan', 'd International'	;@0E1B0
	db	0Dh, 0Ah, 0, 0Dh, 0Ah, 9, 'Available memory %ld', 0Dh, 0Ah, 0
	db	'Syntax is: BCC [ o'
Y0E1B0	ends

Y0E220	segment para public 'CODE'
	assume	cs:Y0E220
	db	'ptions ] file[s]     * = default; -x- = turn swi'	;@0E220
Y0E220	ends

Y0E250	segment para public 'CODE'
	assume	cs:Y0E250
	db	'tch x off', 0Dh, 0Ah, '  -1      80186/286 Instructions    -2      80286 '	;@0E250
	db	'Pro'
Y0E250	ends
	end

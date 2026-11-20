	.286p
	locals

Y0CE90	segment para public 'CODE'
	assume	cs:Y0CE90
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 61h	;@0CE90
	db	1, 0, 0CDh, 3Fh, 81h, 0, 0, 0CDh, 3Fh, 0C9h, 4, 0, 0CDh, 3Fh, 1Ah
	db	2, 0, 0CDh, 3Fh, 11h, 0, 0, 0CDh, 3Fh, 0C2h, 1, 0, 0CDh, 3Fh
Y0CE90	ends

Y0CEC0	segment para public 'CODE'
	assume	cs:Y0CEC0
	db	0, 0, 0, 0CDh, 3Fh, 0F3h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0CEC0
	db	0, 0, 10h, 46h, 3, 0, 0A5h, 9, 50h, 0, 5, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0CEC0	ends

Y0CEF0	segment para public 'CODE'
	assume	cs:Y0CEF0
	db	0CDh, 3Fh, 48h, 0, 0, 0CDh, 3Fh, 61h, 0, 0, 0CDh, 3Fh, 0E8h, 8	;@0CEF0
	db	0, 0CDh, 3Fh, 0D1h, 3, 0, 0CDh, 3Fh, 0BCh, 8, 0, 0, 0, 0, 0, 0
	db	0, 0, 0CDh, 3Fh, 0, 0, 20h, 50h, 3, 0, 5Dh, 2, 2Ch, 0, 7, 0, 0
	db	0
Y0CEF0	ends

Y0CF20	segment para public 'CODE'
	assume	cs:Y0CF20
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0CF20
	db	0, 0CDh, 3Fh, 26h, 0, 0, 0CDh, 3Fh, 7Bh, 0, 0, 0CDh, 3Fh, 0EAh
	db	1, 0, 0CDh, 3Fh, 34h, 1, 0, 0CDh, 3Fh, 63h, 1, 0, 0CDh, 3Fh
Y0CF20	ends

Y0CF50	segment para public 'CODE'
	assume	cs:Y0CF50
	db	16h, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0	;@0CF50
	db	0, 0B0h, 52h, 3, 0, 2Fh, 0Eh, 90h, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0CF50	ends

Y0CF80	segment para public 'CODE'
	assume	cs:Y0CF80
	db	0CDh, 3Fh, 52h, 0Dh, 0, 0CDh, 3Fh, 84h, 2, 0, 0CDh, 3Fh, 4Dh, 3	;@0CF80
	db	0, 0CDh, 3Fh, 0F1h, 0, 0, 0CDh, 3Fh, 8Fh, 4, 0, 0CDh, 3Fh, 20h
	db	0Bh, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 61h, 6, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 70h, 61h, 3, 0, 0F8h, 21h, 0C4h, 1, 14h
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0CF80	ends

Y0CFD0	segment para public 'CODE'
	assume	cs:Y0CFD0
	db	0CDh, 3Fh, 0E4h, 1Bh, 0, 0CDh, 3Fh, 0A3h, 21h, 0, 0CDh, 3Fh, 5Ch	;@0CFD0
	db	1Ah, 0, 0CDh, 3Fh, 6Fh, 0Bh, 0, 0CDh, 3Fh, 0A1h, 18h, 0, 0CDh
	db	3Fh, 0BDh, 1Ch, 0, 0CDh, 3Fh, 2, 1Ah, 0, 0CDh, 3Fh, 15h, 1Ch, 0
	db	0CDh, 3Fh, 0D2h, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 7, 20h, 0
	db	0CDh, 3Fh, 0E7h, 2, 0, 0CDh, 3Fh, 9Fh, 17h
Y0CFD0	ends

Y0D010	segment para public 'CODE'
	assume	cs:Y0D010
	db	0, 0CDh, 3Fh, 3Eh, 0, 0, 0CDh, 3Fh, 0F9h, 11h, 0, 0CDh, 3Fh, 1Dh	;@0D010
	db	1Bh, 0, 0CDh, 3Fh, 13h, 0Eh, 0, 0CDh, 3Fh, 89h, 19h, 0, 0CDh, 3Fh
	db	42h, 1Eh, 0, 0CDh, 3Fh, 8Bh, 14h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 30h, 85h, 3, 0, 45h, 0Ch, 94h, 0, 5
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D010	ends

Y0D060	segment para public 'CODE'
	assume	cs:Y0D060
	db	0CDh, 3Fh, 8Ah, 7, 0, 0CDh, 3Fh, 57h, 9, 0, 0CDh, 3Fh, 6, 2, 0	;@0D060
	db	0CDh, 3Fh, 55h, 5, 0, 0CDh, 3Fh, 8Bh, 6, 0, 0, 0, 0, 0, 0, 0, 0
	db	0CDh, 3Fh, 0, 0, 10h, 92h, 3, 0, 19h, 22h, 1Ch, 2, 8, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 72h
	db	15h, 0, 0CDh, 3Fh, 44h, 15h, 0, 0CDh, 3Fh, 0F4h, 1Ah, 0, 0CDh
Y0D060	ends

Y0D0B0	segment para public 'CODE'
	assume	cs:Y0D0B0
	db	3Fh, 5Ch, 0Bh, 0, 0CDh, 3Fh, 85h, 6, 0, 0CDh, 3Fh, 43h, 0Ch, 0	;@0D0B0
	db	0CDh, 3Fh, 31h, 1Ah, 0, 0CDh, 3Fh, 26h, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0CDh, 3Fh, 0, 0, 50h, 0B6h, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 60h, 0B6h
	db	3, 0, 51h, 1, 8, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0CDh, 3Fh, 10h, 1, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
	db	3Fh, 0E5h, 0, 0, 0CDh, 3Fh, 56h, 0, 0, 0CDh, 3Fh, 36h, 0, 0, 0
	db	0, 0, 0, 0, 0, 0
Y0D0B0	ends

Y0D140	segment para public 'CODE'
	assume	cs:Y0D140
	db	0CDh, 3Fh, 0, 0, 0C0h, 0B7h, 3, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0	;@0D140
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0D0h, 0B7h, 3
	db	0, 3Ch, 9, 88h, 0, 3, 0, 0, 0
Y0D140	ends

Y0D180	segment para public 'CODE'
	assume	cs:Y0D180
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D180
	db	0, 0CDh, 3Fh, 2Ch, 0, 0, 0CDh, 3Fh, 7Ch, 3, 0, 0, 0CDh, 3Fh, 0
	db	0, 0A0h, 0C1h, 3, 0, 0AFh, 2Bh, 0AAh, 1, 0Bh, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 18h, 1, 0, 0CDh
	db	3Fh, 5, 1Ch, 0, 0CDh, 3Fh, 0DEh, 0Fh, 0, 0CDh
Y0D180	ends
	end

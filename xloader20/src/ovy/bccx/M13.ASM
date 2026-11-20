	.286p
	locals

Y0DC80	segment para public 'CODE'
	assume	cs:Y0DC80
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DC80
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0A0h, 88h
	db	5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0
Y0DC80	ends

Y0DCC0	segment para public 'CODE'
	assume	cs:Y0DCC0
	db	0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0DCC0
	db	0, 0, 0B0h, 88h, 5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0
Y0DCC0	ends

Y0DD00	segment para public 'CODE'
	assume	cs:Y0DD00
	db	0CDh, 3Fh, 0, 0, 0C0h, 88h, 5, 0, 6Dh, 1Eh, 58h, 1, 7, 0, 0, 0	;@0DD00
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0BAh
	db	1Dh, 0, 0CDh, 3Fh, 0EDh, 18h, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh
	db	2Bh, 19h, 0, 0CDh, 3Fh, 35h, 19h, 0, 0CDh, 3Fh, 23h, 1Ah, 0, 0CDh
	db	3Fh, 0FAh, 1Ch, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh
	db	3Fh, 0, 0, 90h, 0A8h, 5, 0, 0BEh, 0Bh, 0BCh, 0, 0Ah, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DD00	ends

Y0DD70	segment para public 'CODE'
	assume	cs:Y0DD70
	db	0CDh, 3Fh, 90h, 0Ah, 0, 0CDh, 3Fh, 5Dh, 3, 0, 0CDh, 3Fh, 1Eh, 8	;@0DD70
	db	0, 0CDh, 3Fh, 0A1h, 4, 0, 0CDh, 3Fh, 0C0h, 8, 0, 0CDh, 3Fh, 68h
	db	0, 0, 0CDh, 3Fh, 9Bh, 5, 0, 0CDh, 3Fh, 30h, 7, 0, 0CDh, 3Fh, 0F4h
	db	0, 0, 0CDh, 3Fh, 8Fh
Y0DD70	ends

Y0DDA0	segment para public 'CODE'
	assume	cs:Y0DDA0
	db	9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DDA0
	db	10h, 0B5h, 5, 0, 50h, 0Ch, 0E0h, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DDA0	ends

Y0DDD0	segment para public 'CODE'
	assume	cs:Y0DDD0
	db	0CDh, 3Fh, 0F9h, 1, 0, 0CDh, 3Fh, 0C2h, 0Bh, 0, 0, 0, 0, 0, 0	;@0DDD0
	db	0, 0CDh, 3Fh, 0, 0, 40h, 0C2h, 5, 0, 17h, 5, 1Ch, 0, 8, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DDD0	ends

Y0DE00	segment para public 'CODE'
	assume	cs:Y0DE00
	db	0CDh, 3Fh, 0F3h, 2, 0, 0CDh, 3Fh, 91h, 1, 0, 0CDh, 3Fh, 45h, 0	;@0DE00
	db	0, 0CDh, 3Fh, 0D0h, 4, 0, 0CDh, 3Fh, 65h, 4, 0, 0CDh, 3Fh, 0DCh
	db	1, 0, 0CDh, 3Fh, 4, 2, 0, 0CDh, 3Fh, 62h, 3, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0CDh, 3Fh, 0, 0, 80h, 0C7h, 5, 0, 0CCh, 4, 4Ch, 0, 3
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DE00	ends

Y0DE50	segment para public 'CODE'
	assume	cs:Y0DE50
	db	0CDh, 3Fh, 63h, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 0D1h, 3, 0	;@0DE50
	db	0, 0CDh, 3Fh, 0, 0, 0A0h, 0CCh, 5, 0, 16h, 5, 48h, 0, 3, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0
	db	0, 0, 0CDh, 3Fh, 0FDh, 2, 0, 0CDh, 3Fh, 6Eh, 4, 0, 0, 0CDh, 3Fh
	db	0, 0, 0, 0D2h, 5, 0, 68h, 8, 4, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DE50	ends

Y0DEB0	segment para public 'CODE'
	assume	cs:Y0DEB0
	db	0CDh, 3Fh, 98h, 7, 0, 0CDh, 3Fh, 59h, 4, 0, 0CDh, 3Fh, 60h, 7	;@0DEB0
	db	0, 0CDh, 3Fh, 0, 0, 0, 0CDh, 3Fh, 23h, 1, 0, 0, 0, 0, 0, 0, 0
	db	0, 0CDh, 3Fh, 0, 0, 80h, 0DAh, 5, 0, 0, 8, 4, 0, 1, 0, 0, 0
Y0DEB0	ends

Y0DEE0	segment para public 'CODE'
	assume	cs:Y0DEE0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 12h	;@0DEE0
	db	6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 90h, 0E2h
	db	5, 0, 6Bh, 6, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0CDh, 3Fh, 56h, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0
Y0DEE0	ends

Y0DF30	segment para public 'CODE'
	assume	cs:Y0DF30
	db	0CDh, 3Fh, 0, 0, 10h, 0E9h, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0DF30
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 20h
	db	0E9h, 5, 0, 6Fh, 2, 14h, 0, 1, 0, 0, 0
Y0DF30	ends

Y0DF60	segment para public 'CODE'
	assume	cs:Y0DF60
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DF60
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0B0h, 0EBh
	db	5, 0, 3, 1, 0, 0, 2, 0, 0, 0
Y0DF60	ends
	end

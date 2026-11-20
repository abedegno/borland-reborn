	.286p
	locals

Y0AB10	segment para public 'CODE'
	assume	cs:Y0AB10
	db	8Ch, 46h, 0FEh, 89h, 5Eh, 0FCh, 0EBh, 6, 0FFh, 46h, 0FCh, 0FFh	;@0AB10
	db	46h, 0F8h, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 0C4h, 5Eh, 0F8h, 26h
	db	3Ah, 7, 74h, 0ECh, 0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 75h, 33h
	db	0C4h, 5Eh, 0F8h, 26h, 80h, '?=u*', 0FFh, 46h, 0F8h, 0BEh, 6Ah
	db	8Dh, 0EBh, 0Ch, 0C4h, 5Eh, 0F8h, 26h, 8Ah, 7, 88h, 4, 0FFh, 46h
	db	0F8h, 46h, 0C4h, 5Eh, 0F8h, 26h, 80h, 3Fh, 0, 75h, 0EBh, 0C6h
	db	4, 0, 0B8h, 6Ah, 8Dh, 8Ch, 0DAh, 0EBh, 1Fh, 0FFh, 46h, 0F8h, 0C4h
	db	5Eh, 0F8h, 26h, 80h, 3Fh, 0, 75h
Y0AB10	ends

Y0AB70	segment para public 'CODE'
	assume	cs:Y0AB70
	db	0F4h, 0FFh, 46h, 0F8h, 0C4h, 5Eh, 0F8h, 26h, 80h, 3Fh, 0, 74h	;@0AB70
	db	3, 0E9h, 8Dh, 0FFh, 33h, 0D2h, 8Bh, 0C2h, 5Eh, 8Bh, 0E5h, 5Dh
	db	0CAh, 4, 0, 55h, 8Bh, 0ECh, 8Ah, 46h, 6, 0B4h, 35h, 0CDh, 21h
	db	8Bh, 0C3h, 8Ch, 0C2h, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 1Eh, 0C5h
	db	56h, 6, 8Ah, 46h, 0Ah, 0B4h, 25h, 0CDh, 21h, 1Fh, 5Dh, 0CAh, 6
	db	0, 55h, 8Bh, 0ECh, 8Ah, 46h, 6, 8Bh, 4Eh, 0Ah, 8Bh, 56h, 8, 8Bh
	db	5Eh, 0Ch, 0B4h
Y0AB70	ends

Y0ABC0	segment para public 'CODE'
	assume	cs:Y0ABC0
	db	42h, 0CDh, 21h, 73h, 0Ah, 0A3h, 0, 0, 0BAh, 0FFh, 0FFh, 8Bh, 0C2h	;@0ABC0
	db	0EBh, 0, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 8Ah, 46h, 6, 1Eh
	db	0C5h, 56h, 8, 0B4h, 3Dh, 0CDh, 21h, 1Fh, 73h, 8, 0A3h, 0, 0, 0B8h
	db	0FFh, 0FFh, 0EBh, 0, 5Eh, 5Dh, 0CAh
Y0ABC0	ends

Y0ABF0	segment para public 'CODE'
	assume	cs:Y0ABF0
	db	6, 0, 55h, 8Bh, 0ECh, 8Bh, 4Eh, 6, 8Bh, 5Eh, 0Ch, 0B4h, 3Fh, 1Eh	;@0ABF0
	db	0C5h, 56h, 8, 0CDh, 21h, 1Fh, 72h, 2, 0EBh, 6, 0A3h, 0, 0, 0B8h
	db	0FFh, 0FFh, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 1Eh, 0C5h, 76h
	db	8, 8Ah, 5Eh, 6, 0ADh, 3Ah, 0C3h, 74h, 13h, 0Ah, 0C0h, 74h, 8, 3Ah
	db	0E3h, 74h, 0Ch, 0Ah, 0E4h, 75h, 0EFh, 1Fh, 33h, 0D2h, 8Bh, 0C2h
	db	0EBh, 7, 4Eh, 8Ch, 0DAh, 8Bh, 0C6h, 48h, 1Fh, 5Eh, 5Dh, 0CAh, 6
	db	0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 0FFh, 76h, 0Ah, 0FFh, 76h, 8
	db	9Ah, 4, 0, 5Fh, 2, 0C4h, 5Eh, 8, 3, 0D8h, 4Bh, 8Ch, 46h, 0FEh
	db	89h, 5Eh, 0FCh, 0EBh, 15h, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 3Ah, 46h
	db	6, 75h, 7, 8Bh, 56h, 0FEh, 8Bh, 0C3h, 0EBh, 21h, 0FFh, 4Eh, 0FCh
	db	8Bh, 46h, 0FCh, 3Bh, 46h, 8, 77h, 0E3h, 0C4h, 5Eh, 0FCh
Y0ABF0	ends

Y0AC80	segment para public 'CODE'
	assume	cs:Y0AC80
	db	26h, 8Ah, 7, 3Ah, 46h, 6, 75h, 7, 8Bh, 56h, 0FEh, 8Bh, 0C3h, 0EBh	;@0AC80
	db	4, 33h, 0D2h, 8Bh, 0C2h, 8Bh, 0E5h, 5Dh, 0CAh, 6, 0, 55h, 8Bh
	db	0ECh, 56h, 57h, 0FCh, 1Eh, 0C4h, 7Eh, 6, 0C5h, 76h, 0Ah, 0ACh
	db	0AEh, 75h, 4, 0Ah, 0C0h, 75h, 0F8h, 26h, 2Ah
Y0AC80	ends

Y0ACB0	segment para public 'CODE'
	assume	cs:Y0ACB0
	db	45h, 0FFh, 98h, 1Fh, '_^]', 0CAh, 8, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch	;@0ACB0
	db	0EBh, 36h, 0C4h, 5Eh, 0Ah, 26h, 8Ah, 7, 98h, 50h, 9Ah, 0Fh, 0
	db	6Fh, 2, 88h, 46h
Y0ACB0	ends

Y0ACD0	segment para public 'CODE'
	assume	cs:Y0ACD0
	db	0FEh, 0C4h, 5Eh, 6, 26h, 8Ah, 7, 98h, 50h, 9Ah, 0Fh, 0, 6Fh, 2	;@0ACD0
	db	88h, 46h, 0FFh, 8Ah, 46h, 0FEh, 3Ah, 46h, 0FFh, 7Ch, 20h, 8Ah
	db	46h, 0FEh, 3Ah, 46h, 0FFh, 7Fh
Y0ACD0	ends

Y0ACF0	segment para public 'CODE'
	assume	cs:Y0ACF0
	db	26h, 0FFh, 46h, 0Ah, 0FFh, 46h, 6, 0C4h, 5Eh, 0Ah, 26h, 80h, 3Fh	;@0ACF0
	db	0, 75h, 0C1h, 0C4h, 5Eh, 6, 26h, 80h, 3Fh, 0, 7Eh, 5, 0B8h, 0FFh
	db	0FFh, 0EBh, 10h, 0C4h, 5Eh
Y0ACF0	ends

Y0AD10	segment para public 'CODE'
	assume	cs:Y0AD10
	db	6, 26h, 80h, 3Fh, 0, 7Dh, 5, 0B8h, 1, 0, 0EBh, 2, 33h, 0C0h, 8Bh	;@0AD10
	db	0E5h, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 57h, 0C4h, 7Eh, 6
	db	0B0h, 0, 0B9h, 0FFh, 0FFh, 0FCh, 0F2h, 0AEh, 8Bh, 0C1h, 0F7h, 0D0h
	db	'H_^]', 0CAh, 4, 0, 55h, 8Bh, 0ECh, 8Ah, 46h, 6, 0B4h, 0, 8Bh
	db	0D8h, 0F6h, 87h, 0A1h, 5Bh, 4, 74h, 0Ah, 8Ah, 46h, 6, 0B4h, 0
	db	5, 20h, 0, 0EBh, 5, 8Ah, 46h, 6, 0B4h, 0, 5Dh, 0CAh, 2, 0, 55h
	db	8Bh, 0ECh, 8Ah, 46h, 6, 0B4h, 0, 8Bh, 0D8h, 0F6h, 87h, 0A1h, 5Bh
	db	8, 74h, 0Ah, 8Ah, 46h, 6, 0B4h, 0, 5, 0E0h, 0FFh, 0EBh, 5, 8Ah
	db	46h, 6, 0B4h, 0, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 56h, 0B8h, 41h
	db	0, 50h, 0FFh
Y0AD10	ends

Y0AD90	segment para public 'CODE'
	assume	cs:Y0AD90
	db	76h, 8, 0FFh, 76h, 6, 33h, 0C0h, 50h, 9Ah, 0Dh, 0, 3Fh, 1, 8Bh	;@0AD90
	db	0F0h, 83h, 0FEh, 0FFh, 74h, 2, 33h, 0F6h, 8Bh, 0C6h, 5Eh, 5Dh
	db	0CAh, 4, 0, 55h, 8Bh, 0ECh
Y0AD90	ends

Y0ADB0	segment para public 'CODE'
	assume	cs:Y0ADB0
	db	8Bh, 4Eh, 6, 8Bh, 5Eh, 0Ch, 0B4h, 40h, 1Eh, 0C5h, 56h, 8, 0CDh	;@0ADB0
	db	21h, 1Fh, 72h, 2, 0EBh, 6, 0A3h, 0, 0, 0B8h, 0FFh, 0FFh, 5Dh, 0CAh
	db	8, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 8Ch, 0D3h, 8Eh, 0C3h, 8Dh
	db	5Eh, 0Ah, 8Ch, 46h, 0FEh, 89h, 5Eh, 0FCh, 0FFh, 76h, 8, 0FFh, 76h
	db	6, 0FFh, 76h, 0FEh, 53h, 9Ah, 33h, 0, 9Fh, 2, 8Bh, 0E5h, 5Dh, 0CBh
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 1Ah, 56h, 0E9h, 43h, 2, 0C4h, 5Eh, 0Ah
	db	26h, 80h, '?%t', 1Dh, 26h, 80h, 3Fh, 0Ah, 75h, 7, 0BAh, 0Dh, 0
	db	0B4h, 2, 0CDh, 21h, 0C4h, 5Eh, 0Ah, 26h, 8Ah, 7, 98h, 8Bh, 0D0h
	db	0B4h, 2, 0CDh, 21h
Y0ADB0	ends

Y0AE20	segment para public 'CODE'
	assume	cs:Y0AE20
	db	0E9h, 1Ah, 2, 33h, 0F6h, 0FFh, 46h, 0Ah, 8Ch, 0D3h, 8Eh, 0C3h	;@0AE20
	db	8Dh, 5Eh, 0FAh, 8Ch
Y0AE20	ends
	end

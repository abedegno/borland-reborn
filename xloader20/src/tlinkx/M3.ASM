	.286p
	locals
	public	S434_START
	extrn	S2F4_START:byte
	extrn	L04F7B:far
	extrn	L05757:far
	extrn	L06079:far
	extrn	L06849:far
	extrn	S686_START:byte
	extrn	L068C5:far

S434	segment para public 'CODE'
	assume	cs:S434
S434_START	db	100h dup (0)	;@04340
S434	ends

S444	segment para public 'CODE'
	assume	cs:S444
	db	20h dup (0)	;@04440
S444	ends

S400	segment byte public 'CODE'
	assume	cs:S400
	db	0D1h, 0E3h, 0FFh, 97h, 82h, 0Dh, 0CBh, 0BEh, 12h, 0, 1Eh, 0B8h, 18h, 0Fh, 50h, 0B8h	;@04008
	db	8, 0, 50h, 33h, 0C0h, 50h, 0FFh, 74h, 1Ch, 0FFh, 74h, 2Ch, 0FFh, 36h, 0Ah, 0
	db	9Ah
	dd	L04F7B
	db	83h, 0C4h, 0Eh, 0C4h, 6, 1Ch, 0Fh, 0A3h, 10h, 0Fh, 8Ch, 6, 12h, 0Fh, 0C7h, 6
	db	12h, 0, 0, 0, 0C7h, 6, 1Eh, 0
	dw	S444
	db	0C7h, 6, 16h, 0, 4Eh, 6, 0C7h, 6, 1Ah, 0
	dw	seg S2F4_START
	db	0C7h, 6, 2Ah, 0, 70h, 6, 0C7h, 6, 2Eh, 0
	dw	seg S2F4_START
	db	0C3h, 0BEh, 12h, 0, 1Eh, 0B8h, 90h, 0Dh, 50h, 0FFh, 74h, 8, 33h, 0C0h, 50h, 0FFh
	db	74h, 1Ch, 0FFh, 74h, 2Ch, 0FFh, 36h, 0Ah, 0, 9Ah
	dd	L04F7B
	db	83h, 0C4h, 0Eh, 0BEh, 12h, 0, 68h
	dw	S434
	db	0B8h, 80h, 0, 50h, 0FFh, 74h, 0Ch, 33h, 0DBh, 53h, 50h, 0FFh, 74h, 18h, 0FFh, 36h
	db	0Ah, 0, 9Ah
	dd	L04F7B
	db	83h, 0C4h, 0Eh, 1Eh, 0B8h, 90h, 0Dh, 50h, 0Eh, 0E8h, 0AFh, 0, 90h, 0A3h, 12h, 0
	db	0C3h, 0Eh, 0E8h, 0ABh, 1, 90h, 0A3h, 12h, 0, 9Ah
	dd	L05757
	db	0C3h, 0Eh, 0E8h, 4Bh, 1, 90h, 0A3h, 12h, 0, 0C3h, 0Eh, 0E8h, 14h, 2, 90h, 0C3h
	db	0C7h, 6, 12h, 0, 0E4h, 0, 0C7h, 6, 1Eh, 0
	dw	seg S686_START
	db	0C3h, 0A1h, 12h, 0, 0FFh, 36h, 1Eh, 0, 0FFh, 36h, 1Ah, 0, 8Bh, 0DCh, 36h, 0FFh
	db	1Fh, 83h, 0C4h, 4, 0A3h, 12h, 0, 0C3h, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Eh, 6
	db	0Eh, 0, 0BFh, 81h, 0, 0C5h, 76h, 6, 33h, 0C9h, 0FCh, 0ACh, 0Ah, 0C0h, 74h, 7
	db	0AAh, 41h, 83h, 0F9h, 7Eh, 7Ch, 0F4h, 0B0h, 0Dh, 0AAh, 26h, 88h, 0Eh, 80h, 0, 6
	db	1Fh, 0BEh, 81h, 0, 0BFh, 5Ch, 0, 0B8h, 1, 29h, 0CDh, 21h, 0BFh, 6Ch, 0, 0B8h
	db	1, 29h, 0CDh, 21h, 1Fh, 5Fh, 5Eh, 5Dh, 0CAh, 4, 0, 8Eh, 6, 0Eh, 0, 26h
	db	0A1h, 2Eh, 0, 0A3h, 7Eh, 0Dh, 26h, 0A1h, 30h, 0, 0A3h, 80h, 0Dh, 0C3h, 8Eh, 6
	db	0Eh, 0, 0A1h, 7Eh, 0Dh, 26h, 0A3h, 2Eh, 0, 0A1h, 80h, 0Dh, 26h, 0A3h, 30h, 0
	db	0C3h, 55h, 8Bh, 0ECh, 56h, 57h, 0B4h, 51h, 0CDh, 21h, 89h, 1Eh, 16h, 0Fh, 0BBh
	dw	S434
	db	0B4h, 50h, 0CDh, 21h, 0BBh, 64h, 0Dh, 1Eh, 7, 8Bh, 0FBh, 0BAh
	dw	S434
	db	0FCh, 0A1h, 10h, 0, 0ABh, 0B8h, 80h, 0, 0ABh, 8Bh, 0C2h, 0ABh, 0B8h, 5Ch, 0, 0ABh
	db	8Bh, 0C2h, 0ABh, 0B8h, 6Ch, 0, 0ABh, 8Bh, 0C2h, 0ABh, 0FFh, 36h, 2Eh, 0, 0FFh, 36h
	db	30h, 0, 89h, 26h, 7Ah, 0Dh, 8Ch, 16h, 7Ch, 0Dh, 0BCh, 10h, 0Fh, 0C5h, 56h, 6
	db	0B8h, 1, 4Bh, 0CDh, 21h, 0BAh
	dw	seg S2F4_START
	db	8Eh, 0DAh, 0FAh, 8Eh, 16h, 7Ch, 0Dh, 8Bh, 26h, 7Ah, 0Dh, 0FBh, 9Ch, 50h, 0B4h, 30h
	db	0CDh, 21h, 86h, 0C4h, 3Dh, 0Ah, 2, 7Dh, 13h, 0B8h
	dw	S434
	db	8Eh, 0C0h, 0A1h, 2Eh, 0, 26h, 0A3h, 2Eh, 0, 0A1h, 30h, 0, 26h, 0A3h, 30h, 0
	db	58h, 9Dh, 8Fh, 6, 30h, 0, 8Fh, 6, 2Eh, 0, 72h, 0Dh, 83h, 6, 72h, 0Dh
	db	2, 0E8h, 44h, 0FFh, 0B8h, 0, 0, 0EBh, 12h, 92h, 0B8h, 0FEh, 0FFh, 80h, 0FAh, 2
	db	74h, 9, 0B0h, 0FCh, 80h, 0FAh, 8, 74h, 2, 0B0h, 0FAh, 5Fh, 5Eh, 5Dh, 0CAh, 4
	db	0, 55h, 8Bh, 0ECh, 56h, 57h, 0B4h, 51h, 0CDh, 21h, 0E8h, 2Eh, 0FFh, 8Ch, 16h, 7Ch
	db	0Dh, 89h, 26h, 7Ah, 0Dh, 0FAh, 8Eh, 16h, 74h, 0Dh, 8Bh, 26h, 72h, 0Dh, 0FBh, 0C4h
	db	6, 76h, 0Dh, 6, 50h, 8Eh, 0DBh, 8Eh, 0C3h, 0C7h, 6, 0Ah, 0, 3Eh, 2, 8Ch
	db	0Eh, 0Ch, 0, 0CBh, 0B8h
	dw	seg S2F4_START
	db	8Eh, 0D8h, 0FAh, 8Eh, 16h, 7Ch, 0Dh, 8Bh, 26h, 7Ah, 0Dh, 0FBh, 8Bh, 1Eh, 0Eh, 0
	db	0B4h, 50h, 0CDh, 21h, 0B4h, 4Dh, 0CDh, 21h, 5Fh, 5Eh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 56h
	db	57h, 0B4h, 51h, 0CDh, 21h, 89h, 1Eh, 62h, 0Dh, 0C4h, 3Eh, 6Ah, 6, 0FCh, 33h, 0C0h
	db	0B9h, 7, 0, 0F3h, 0ABh, 8Bh, 0C3h, 0ABh, 0ABh, 0A1h, 76h, 0Dh, 0ABh, 0A1h, 78h, 0Dh
	db	0ABh, 9Ch, 58h, 0ABh, 0A1h, 72h, 0Dh, 0ABh, 0A1h, 74h, 0Dh, 0ABh, 8Eh, 0C3h, 26h, 0C7h
	db	6, 0Ah, 0, 0B9h, 2, 26h, 8Ch, 0Eh, 0Ch, 0, 53h, 9Ah
	dd	L068C5
	db	8Bh, 1Eh, 0Eh, 0, 0B4h, 50h, 0CDh, 21h, 0C7h, 6, 14h, 0Fh, 2, 0, 0A1h, 62h
	db	0Dh, 5, 10h, 0, 5Fh, 5Eh, 5Dh, 0CBh, 0B8h
	dw	seg S2F4_START
	db	8Eh, 0D8h, 0FAh, 8Eh, 0D0h, 8Bh, 26h, 10h, 0Fh, 0FBh, 8Bh, 1Eh, 0Eh, 0, 0B4h, 50h
	db	0CDh, 21h, 0B4h, 4Dh, 0CDh, 21h, 50h, 33h, 0C0h, 0A3h, 62h, 0Dh, 9Ah
	dd	L06079
	db	55h, 8Bh, 0ECh, 56h, 57h, 8Bh, 1Eh, 62h, 0Dh, 0Bh, 0DBh, 74h, 45h, 0E8h, 58h, 0FEh
	db	55h, 8Ch, 16h, 7Ch, 0Dh, 89h, 26h, 7Ah, 0Dh, 8Eh, 0C3h, 26h, 0C7h, 6, 0Ah, 0
	db	0Dh, 3, 26h, 8Ch, 0Eh, 0Ch, 0, 0B4h, 50h, 0CDh, 21h, 0B8h, 0, 4Ch, 0CDh, 21h
	db	0B8h
	dw	seg S2F4_START
	db	8Eh, 0D8h, 0FAh, 8Eh, 16h, 7Ch, 0Dh, 8Bh, 26h, 7Ah, 0Dh, 0FBh, 8Bh, 1Eh, 0Eh, 0
	db	0B4h, 50h, 0CDh, 21h, 5Dh, 9Ah
	dd	L06849
	db	33h, 0C0h, 0A3h, 62h, 0Dh, 0C7h, 6, 14h, 0Fh, 3, 0, 5Fh, 5Eh, 5Dh, 0CBh, 0
	db	0, 0, 0, 0, 0, 0
S400	ends

S6FE	segment byte public 'CODE'
	assume	cs:S6FE
	db	0, 11h, 6, 11h, 8, 0	;@06FE8
	dw	S400
S6FE	ends
	end

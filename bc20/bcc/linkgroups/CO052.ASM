		public	X052_01
		public	X052_00
		public	X052_02
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d32_9d6d
; BEGIN C219UNIT (listing ovr_1d32_9d6d:D6D0)


		extrn	BCC_FAR_AF23:far


CO052_TEXT	segment byte public 'CODE'
		assume	cs:CO052_TEXT,ds:DGROUP

		public	X052_01
X052_01	label	far
BCC_FAR_D6D0	proc	far
		push	BP
		mov	BP,SP
		push	DS
		mov	AX,86CAh
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,43h
		push	AX
		db	09Ah
		dw	BCC_FAR_AF23
		dw	seg BCC_FAR_AF23
		pop	BP
		retf
BCC_FAR_D6D0	endp
CO052_TEXT	ends


		extrn	BCC_FAR_245C:far
		extrn	BCC_FAR_34F0:far
		extrn	BCC_FAR_3513:far
		extrn	X053_00:far


CO052_TEXT	segment byte public 'CODE'
		assume	cs:CO052_TEXT,ds:DGROUP

M001_BCC_DATA_8640	equ	8640h
M001_BCC_DATA_8648	equ	8648h
M001_BCC_DATA_864C	equ	864Ch
M001_BCC_DATA_864E	equ	864Eh
M001_BCC_DATA_8650	equ	8650h
M001_BCC_DATA_8656	equ	8656h
M001_BCC_DATA_8658	equ	8658h
M001_BCC_DATA_865A	equ	865Ah
M001_BCC_DATA_8668	equ	8668h
M001_BCC_DATA_866A	equ	866Ah
M001_BCC_DATA_866C	equ	866Ch
M001_BCC_DATA_8670	equ	8670h
M001_BCC_DATA_8672	equ	8672h
M001_BCC_DATA_8674	equ	8674h
M001_BCC_DATA_8682	equ	8682h
M001_BCC_DATA_8684	equ	8684h
M001_BCC_DATA_8686	equ	8686h
M001_BCC_DATA_868A	equ	868Ah
M001_BCC_DATA_868C	equ	868Ch
M001_BCC_DATA_868E	equ	868Eh
M001_BCC_DATA_869A	equ	869Ah
M001_BCC_DATA_869C	equ	869Ch
M001_BCC_DATA_869E	equ	869Eh
M001_BCC_DATA_86B2	equ	86B2h
M001_BCC_DATA_86B4	equ	86B4h
M001_BCC_DATA_86B6	equ	86B6h
M001_BCC_DATA_86BA	equ	86BAh
M001_BCC_DATA_86BC	equ	86BCh
M001_BCC_DATA_86BE	equ	86BEh
M001_BCC_DATA_86C2	equ	86C2h
M001_BCC_DATA_86C4	equ	86C4h
M001_BCC_DATA_86C6	equ	86C6h

		public	X052_02
X052_02	label	far
BCC_FAR_D6E6	proc	far
		push	BP
		mov	BP,SP
		db	09Ah
		dw	BCC_FAR_3513
		dw	seg BCC_FAR_3513
		cbw
		mov	DGROUP:M001_BCC_DATA_8640,AX
		db	09Ah
		dw	BCC_FAR_3513
		dw	seg BCC_FAR_3513
		cbw
		mov	DGROUP:M001_BCC_DATA_8648,AX
		mov	AL,DGROUP:M001_BCC_DATA_8648
		push	AX
		db	09Ah
		dw	BCC_FAR_34F0
		dw	seg BCC_FAR_34F0
		mov	AX,2
		mov	DGROUP:M001_BCC_DATA_8656,AX
		mov	DGROUP:M001_BCC_DATA_8658,AX
		mov	word ptr DGROUP:M001_BCC_DATA_865A,0
		push	DS
		mov	AX,8654h
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AX,2
		mov	DGROUP:M001_BCC_DATA_868A,AX
		mov	DGROUP:M001_BCC_DATA_868C,AX
		mov	word ptr DGROUP:M001_BCC_DATA_868E,0
		push	DS
		mov	AX,8688h
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AX,4
		mov	DGROUP:M001_BCC_DATA_8682,AX
		mov	DGROUP:M001_BCC_DATA_8684,AX
		mov	word ptr DGROUP:M001_BCC_DATA_8686,0
		push	DS
		mov	AX,8680h
		push	AX
		mov	AX,4
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AX,4
		mov	DGROUP:M001_BCC_DATA_869A,AX
		mov	DGROUP:M001_BCC_DATA_869C,AX
		mov	word ptr DGROUP:M001_BCC_DATA_869E,0
		push	DS
		mov	AX,8698h
		push	AX
		mov	AX,4
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M001_BCC_DATA_86B2,AX
		mov	DGROUP:M001_BCC_DATA_86B4,AX
		mov	word ptr DGROUP:M001_BCC_DATA_86B6,0
		push	DS
		mov	AX,86B0h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M001_BCC_DATA_86C2,AX
		mov	DGROUP:M001_BCC_DATA_86C4,AX
		mov	word ptr DGROUP:M001_BCC_DATA_86C6,0
		push	DS
		mov	AX,86C0h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M001_BCC_DATA_8668,AX
		mov	DGROUP:M001_BCC_DATA_866A,AX
		mov	word ptr DGROUP:M001_BCC_DATA_866C,0
		push	DS
		mov	AX,8666h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M001_BCC_DATA_86BA,AX
		mov	DGROUP:M001_BCC_DATA_86BC,AX
		mov	word ptr DGROUP:M001_BCC_DATA_86BE,0
		push	DS
		mov	AX,86B8h
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		mov	AX,2
		mov	DGROUP:M001_BCC_DATA_8670,AX
		mov	DGROUP:M001_BCC_DATA_8672,AX
		mov	word ptr DGROUP:M001_BCC_DATA_8674,0
		push	DS
		mov	AX,866Eh
		push	AX
		mov	AX,2
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		xor	AX,AX
		mov	DGROUP:M001_BCC_DATA_864C,AX
		mov	DGROUP:M001_BCC_DATA_864E,AX
		mov	word ptr DGROUP:M001_BCC_DATA_8650,0
		push	DS
		mov	AX,864Ah
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_245C
		dw	seg BCC_FAR_245C
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	09Ah
		dw	X053_00
		dw	seg X053_00
		pop	BP
		retf	4
BCC_FAR_D6E6	endp
CO052_TEXT	ends


		extrn	BCC_FAR_25FF:far
		extrn	BCC_FAR_355B:far
		extrn	BCC_FAR_5EE3:far
		extrn	BCC_FAR_5F47:far


CO052_TEXT	segment byte public 'CODE'
		assume	cs:CO052_TEXT,ds:DGROUP

M002_BCC_DATA_8640	equ	8640h
M002_BCC_DATA_8648	equ	8648h
M002_BCC_DATA_87EC	equ	87ECh

		public	X052_00
X052_00	label	far
BCC_FAR_D82B	proc	far
		push	BP
		mov	BP,SP
		cmp	word ptr [BP+6],0
		je	short M002_L_D83B
		db	09Ah
		dw	BCC_FAR_5F47
		dw	seg BCC_FAR_5F47
		jmp	short M002_L_D844
M002_L_D83B:
		db	0FFh,01Eh
		dw	87ECh
		db	09Ah
		dw	BCC_FAR_5EE3
		dw	seg BCC_FAR_5EE3
M002_L_D844:
		push	word ptr DGROUP:M002_BCC_DATA_8648
		db	09Ah
		dw	BCC_FAR_25FF
		dw	seg BCC_FAR_25FF
		push	word ptr DGROUP:M002_BCC_DATA_8648
		db	09Ah
		dw	BCC_FAR_355B
		dw	seg BCC_FAR_355B
		push	word ptr DGROUP:M002_BCC_DATA_8640
		db	09Ah
		dw	BCC_FAR_25FF
		dw	seg BCC_FAR_25FF
		push	word ptr DGROUP:M002_BCC_DATA_8640
		db	09Ah
		dw	BCC_FAR_355B
		dw	seg BCC_FAR_355B
		pop	BP
		retf	2
BCC_FAR_D82B	endp
CO052_TEXT	ends

; END C219UNIT
		end

; Recovered FBOV far-pointer references
CO057_TEXT	segment byte public 'CODE'
CO057_TEXT	ends
CO058_TEXT	segment byte public 'CODE'
CO058_TEXT	ends
		public	X059_04
		public	X059_05
		public	X059_06
		public	X059_07
		public	X059_00
		public	X059_01
		public	X059_02
		public	X059_03
		public	X059_08
		public	X059_09
		public	X059_0A
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d5e_a195
; BEGIN C203UNIT (listing ovr_1d5e_a195:1950)

		extrn	BCC_FAR_5B44:far
		extrn	BCC_FAR_5F79:far
		extrn	X057_07:far
		extrn	X057_06:far
		extrn	X057_09:far
		extrn	X057_08:far
		extrn	X057_10:far
		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X062_05:far
		extrn	X074_00:far
		extrn	X074_02:far
		extrn	X074_01:far
		extrn	X074_04:far
		extrn	X075_00:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M000_BCC_DATA_1712	equ	1712h
M000_BCC_DATA_3F83	equ	3F83h
M000_BCC_DATA_80B4	equ	80B4h
M000_BCC_DATA_80B8	equ	80B8h
M000_BCC_DATA_8108	equ	8108h
M000_BCC_DATA_8118	equ	8118h
M000_BCC_DATA_812C	equ	812Ch
M000_BCC_DATA_8158	equ	8158h
M000_BCC_DATA_8164	equ	8164h
M000_BCC_DATA_8186	equ	8186h
M000_BCC_DATA_8654	equ	8654h
M000_BCC_DATA_86D2	equ	86D2h
M000_BCC_DATA_86F7	equ	86F7h
M000_BCC_DATA_86F9	equ	86F9h

		public	X059_00
X059_00	label	far
BCC_NEAR_1950	label	near
BCC_FAR_1950	proc	far
M000_L_1950:
		push	BP
		mov	BP,SP
		sub	SP,1Eh
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		cmp	SP,8F0Ch
		jnc	short M000_L_196C
		mov	AX,6
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
M000_L_196C:
		xor	AX,AX
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		jne	short M000_L_1985
		mov	DX,word ptr [BP-4]
		db	0E9h
		dw	0099Ah
M000_L_1985:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],13h
		je	short M000_L_1997
		cmp	word ptr ES:[SI+2],14h
		jne	short M000_L_19AE
M000_L_1997:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		db	0FFh,01Eh
		dw	8164h
		cmp	AX,4
		ja	short M000_L_19AE
		push	SI
		db	0E8h
		dw	016DFh
		jmp	short M000_L_19BF
M000_L_19AE:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],15h
		jne	short M000_L_19BF
		mov	word ptr ES:[SI+2],5
M000_L_19BF:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],13h
		jl	short M000_L_1A19
		cmp	word ptr ES:[SI],1Ch
		jg	short M000_L_1A19
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],4
		jne	short M000_L_19FF
		mov	BX,word ptr ES:[SI+0Ah]
		push	word ptr ES:[BX+0Ah]
		db	0FFh,01Eh
		dw	8118h
		mov	DI,AX
		cmp	DI,0Ch
		jc	short M000_L_19F1
		cmp	DI,0Fh
		jbe	short M000_L_19F6
M000_L_19F1:
		cmp	DI,-1
		jne	short M000_L_1A19
M000_L_19F6:
		push	SI
		db	0FFh,01Eh
		dw	812Ch
		mov	SI,AX
		jmp	short M000_L_1A19
M000_L_19FF:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],33h
		jne	short M000_L_1A19
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X074_01
		dw	seg X074_01
		db	0E9h
		dw	00906h
M000_L_1A19:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI]
		sub	BX,0Bh
		cmp	BX,2Bh
		jbe	short M000_L_1A2B
		db	0E9h
		dw	008BCh
M000_L_1A2B:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	9D7h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0Ch
		je	short M000_L_1A40
		db	0E9h
		dw	008A7h
M000_L_1A40:
		push	word ptr ES:[SI+0Ah]
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FF05h
		db	0E9h
		dw	008D1h
		push	SI
		db	09Ah
		dw	X074_04
		dw	seg X074_04
		db	0E9h
		dw	008C8h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	byte ptr ES:[SI+6],0FFh
		db	0E9h
		dw	00884h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	byte ptr ES:[SI+6],0FFh
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],2Ah
		je	short M000_L_1A79
		db	0E9h
		dw	0086Eh
M000_L_1A79:
		mov	DI,word ptr ES:[SI+0Ah]
		mov	word ptr [BP-0Ch],SI
		mov	word ptr [BP-0Eh],SI
M000_L_1A83:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+0Ah]
		mov	word ptr [BP-10h],AX
		mov	AX,word ptr ES:[DI+0Ch]
		mov	DX,AX
		mov	AX,word ptr [BP-0Eh]
		mov	word ptr ES:[DI+0Ch],AX
		mov	AX,DX
		mov	word ptr ES:[DI+0Ah],AX
		mov	word ptr [BP-0Eh],DI
		cmp	word ptr [BP-10h],0
		je	short M000_L_1AB8
		mov	BX,word ptr [BP-10h]
		cmp	word ptr ES:[BX],2Ah
		jne	short M000_L_1AB8
		mov	DI,word ptr [BP-10h]
		jmp	short M000_L_1A83
M000_L_1AB8:
		push	word ptr [BP-10h]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FE8Dh
		mov	SI,word ptr [BP-0Eh]
M000_L_1AC6:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	byte ptr ES:[SI+6],0FFh
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FE75h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-12h],AX
		mov	AX,word ptr ES:[SI+0Ah]
		mov	word ptr ES:[SI+0Ch],AX
		mov	AX,word ptr [BP-10h]
		mov	word ptr ES:[SI+0Ah],AX
		mov	word ptr [BP-10h],SI
		mov	SI,word ptr [BP-12h]
		cmp	SI,word ptr [BP-0Ch]
		jne	short M000_L_1AC6
		mov	byte ptr ES:[SI+6],0FFh
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FE3Fh
		db	0E9h
		dw	0080Bh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[DI+2],0Eh
		jne	short M000_L_1B54
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FE24h
		mov	word ptr [BP-8],DX
		mov	word ptr [BP-0Ah],AX
		mov	word ptr [BP-8],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Ah],AX
		push	SI
		push	word ptr [BP-8]
		push	word ptr [BP-0Ah]
		db	0E8h
		dw	01E8Bh
		db	0E9h
		dw	007CBh
M000_L_1B54:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[DI],32h
		jne	short M000_L_1B6C
		push	SI
		push	word ptr ES:[DI+0Ah]
		xor	AX,AX
		push	AX
		db	0E8h
		dw	01643h
		db	0E9h
		dw	007B3h
M000_L_1B6C:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[DI],8
		jne	short M000_L_1BA1
		db	026h,08Bh,05Dh,00Ah,026h,083h,03Fh,032h,075h,021h
		mov	BX,word ptr ES:[DI+0Ch]
		cmp	word ptr ES:[BX],2
		jne	short M000_L_1BA1
		push	SI
		mov	BX,word ptr ES:[DI+0Ah]
		push	word ptr ES:[BX+0Ah]
		mov	BX,word ptr ES:[DI+0Ch]
		push	word ptr ES:[BX+0Ah]
		db	0E8h
		dw	0160Eh
		db	0E9h
		dw	0077Eh
M000_L_1BA1:
		push	DI
		db	0E8h
		dw	01F54h
		mov	word ptr [BP-8],DX
		mov	word ptr [BP-0Ah],AX
		cmp	word ptr [BP-0Ah],0
		jne	short M000_L_1BC0
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FD96h
		mov	word ptr [BP-8],DX
		mov	word ptr [BP-0Ah],AX
M000_L_1BC0:
		push	SI
		push	word ptr [BP-8]
		push	word ptr [BP-0Ah]
		db	0E8h
		dw	01E12h
		db	0E9h
		dw	00752h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	DI,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[SI+2],14h
		je	short M000_L_1BE3
		cmp	word ptr ES:[SI+2],13h
		jne	short M000_L_1BEF
M000_L_1BE3:
		push	SI
		push	word ptr [BP+6]
		nop
		push	CS
		db	0E8h
		dw	0139Eh
		db	0E9h
		dw	00730h
M000_L_1BEF:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[DI],33h
		jne	short M000_L_1C09
		push	DI
		push	word ptr ES:[SI+0Ch]
		push	word ptr [BP+6]
		db	09Ah
		dw	X074_02
		dw	seg X074_02
		db	0E9h
		dw	00716h
M000_L_1C09:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],2
		je	short M000_L_1C46
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DX,AX
		mov	BX,DX
		cmp	word ptr ES:[BX],35h
		je	short M000_L_1C29
		db	0E9h
		dw	006BEh
M000_L_1C29:
		mov	AX,word ptr ES:[BX+0Ah]
		mov	CX,AX
		mov	BX,CX
		mov	BX,word ptr ES:[BX+2]
		test	byte ptr [BX+9CAh],2
		jne	short M000_L_1C3F
		db	0E9h
		dw	006A8h
M000_L_1C3F:
		mov	word ptr ES:[SI+0Ch],AX
		db	0E9h
		dw	006A1h
M000_L_1C46:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[DI],4
		db	074h,003h,0E9h,094h,006h
		push	word ptr ES:[DI+0Ah]
		db	0FFh,01Eh
		dw	8118h
		cmp	AX,0FFFFh
		je	short M000_L_1C63
		db	0E9h
		dw	00684h
M000_L_1C63:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FCDDh
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,74h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	0E9h
		dw	0067Bh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		mov	BX,word ptr ES:[BX+2]
		test	byte ptr [BX+9CAh],2
		je	short M000_L_1CBD
		db	081h,00Eh
		dw	M000_BCC_DATA_86D2
		dw	2
M000_L_1CBD:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AL,byte ptr ES:[SI+2]
		push	AX
		db	0E8h
		dw	01B95h
		db	0E9h
		dw	0064Fh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],2
		je	short M000_L_1CF9
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X062_05
		dw	seg X062_05
		db	089h,046h,0FAh,0C7h,046h,0FCh,000h,000h
		db	08Bh,056h,0FCh,08Bh,046h,0FAh,0E9h,026h,006h
M000_L_1CF9:
		db	08Eh,006h,086h,081h,026h,08Bh,05Ch,00Ah
		db	026h,083h,03Fh,033h,075h,00Ch
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X074_00
		dw	seg X074_00
		db	0E9h
		dw	0060Ch
		push	SI
		db	0E8h
		dw	018BAh
		db	0E9h
		dw	00605h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],7
		je	short M000_L_1D2F
		cmp	word ptr ES:[SI+2],8
		je	short M000_L_1D2F
		db	0E9h
		dw	005B8h
M000_L_1D2F:
		mov	AX,6
		push	AX
		xor	AX,AX
		mov	DX,55h
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FC01h
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0FBC7h
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	SI
		nop
		push	CS
		db	0E8h
		dw	013C8h
		mov	AX,0AEh
		push	AX
		xor	AX,AX
		mov	DX,8
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-6],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	020h
		dw	seg CO058_TEXT
		db	089h,046h,0FCh
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	0E9h
		dw	00529h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],2
		je	short M000_L_1E1F
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X062_05
		dw	seg X062_05
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-4],0
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	0E9h
		dw	00500h
M000_L_1E1F:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],33h
		jne	short M000_L_1E39
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X074_00
		dw	seg X074_00
		db	0E9h
		dw	004E6h
M000_L_1E39:
		push	SI
		db	0E8h
		dw	01503h
		db	0E9h
		dw	004DFh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],3
		jl	short M000_L_1E5C
		cmp	word ptr ES:[SI+2],6
		jg	short M000_L_1E5C
		push	SI
		db	0FFh,01Eh
		dw	812Ch
		mov	SI,AX
		db	0E9h
		dw	0048Bh
M000_L_1E5C:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],2
		je	short M000_L_1E85
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],7
		jg	short M000_L_1E7B
		cmp	word ptr [BP+6],0
		je	short M000_L_1E85
M000_L_1E7B:
		push	SI
		db	0FFh,01Eh
		dw	812Ch
		mov	SI,AX
		db	0E9h
		dw	00462h
M000_L_1E85:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		db	026h,083h,07Ch,002h,007h
		je	short M000_L_1E9A
		cmp	word ptr ES:[SI+2],8
		je	short M000_L_1E9A
		db	0E9h
		dw	0044Dh
M000_L_1E9A:
		push	SI
		db	0FFh,01Eh
		dw	812Ch
		mov	SI,AX
		db	0E9h
		dw	00443h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		db	0F6h,087h,0CAh,009h,002h
		je	short M000_L_1ECD
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],7
		jg	short M000_L_1EC3
		cmp	word ptr [BP+6],0
		je	short M000_L_1ECD
M000_L_1EC3:
		push	SI
		db	0FFh,01Eh
		dw	812Ch
		mov	SI,AX
		db	0E9h
		dw	0041Ah
M000_L_1ECD:
		mov	AL,DGROUP:M000_BCC_DATA_1712
		cbw
		or	AX,AX
		je	short M000_L_1ED8
		db	0E9h
		dw	0040Fh
M000_L_1ED8:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],10h
		je	short M000_L_1EE6
		db	0E9h
		dw	00401h
M000_L_1EE6:
		mov	BX,word ptr ES:[SI+0Ah]
		push	word ptr ES:[BX+8]
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	8158h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	word ptr ES:[SI+0Ah],AX
		db	0E9h
		dw	003E2h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],7
		je	short M000_L_1F1A
		cmp	word ptr ES:[SI+2],8
		je	short M000_L_1F1A
		db	0E9h
		dw	003CDh
M000_L_1F1A:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		cmp	word ptr ES:[BX],2
		je	short M000_L_1F2B
		db	0E9h
		dw	003BCh
M000_L_1F2B:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		cmp	word ptr ES:[BX+0Ch],0
		jl	short M000_L_1F49
		jle	short M000_L_1F3F
		db	0E9h
		dw	003A8h
M000_L_1F3F:
		cmp	word ptr ES:[BX+0Ah],-1
		jbe	short M000_L_1F49
		db	0E9h
		dw	0039Eh
M000_L_1F49:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		mov	AX,word ptr ES:[BX+0Ah]
		mov	word ptr [BP-0Ch],AX
		cmp	word ptr [BP-0Ch],10h
		je	short M000_L_1F67
		cmp	word ptr [BP-0Ch],1
		je	short M000_L_1F67
		db	0E9h
		dw	00380h
M000_L_1F67:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F9D9h
		mov	word ptr [BP-0Eh],DX
		mov	word ptr [BP-10h],AX
		cmp	word ptr [BP-0Ch],10h
		jne	short M000_L_1FF1
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],0Dh
		jne	short M000_L_1FA2
		mov	word ptr [BP-4],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		db	0E9h
		dw	000C5h
M000_L_1FA2:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],8
		jne	short M000_L_1FC8
		mov	AX,word ptr [BP-0Eh]
		mov	word ptr [BP-6],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		db	0E9h
		dw	000A2h
M000_L_1FC8:
		mov	AX,0ACh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-6],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		jmp	short M000_L_206A
M000_L_1FF1:
		mov	AX,9
		push	AX
		xor	AX,AX
		push	AX
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	DI,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],0Dh
		jne	short M000_L_2034
		mov	AX,45h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-10h]
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-6],AX
		mov	AX,56h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		jmp	short M000_L_206A
M000_L_2034:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],8
		jne	short M000_L_2044
		mov	AX,47h
		jmp	short M000_L_2047
M000_L_2044:
		mov	AX,49h
M000_L_2047:
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	AX,55h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-10h]
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
M000_L_2067:
		mov	word ptr [BP-6],AX
M000_L_206A:
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	0E9h
		dw	002ACh
		push	SI
		push	word ptr [BP+6]
		db	09Ah
		dw	X075_00
		dw	seg X075_00
		db	0E9h
		dw	002A0h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],28h
		je	short M000_L_20A7
		cmp	word ptr [BP-2],27h
		je	short M000_L_20A7
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX+2],6
		jg	short M000_L_20A7
		db	0E9h
		dw	00240h
M000_L_20A7:
		mov	AX,5
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		xor	AX,AX
		mov	DX,1
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		mov	DI,AX
		mov	AX,5
		push	AX
		db	0FFh,01Eh
		dw	8108h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	0FFh,01Eh
		dw	80B4h
		mov	word ptr [BP-0Ch],AX
		mov	AX,26h
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[DI+8]
		push	DI
		push	word ptr [BP-0Ch]
		db	0FFh,01Eh
		dw	80B8h
		mov	word ptr [BP-0Ch],AX
		mov	AX,25h
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[DI+8]
		push	SI
		push	word ptr [BP-0Ch]
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		mov	AX,word ptr ES:[BX+0Ah]
		mov	word ptr [BP-16h],AX
		mov	BX,word ptr [BP-16h]
		mov	AL,byte ptr ES:[BX+2]
		mov	byte ptr [BP-17h],AL
		mov	BX,word ptr ES:[SI+0Ch]
		mov	AX,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-1Ah],AX
		mov	DI,word ptr DGROUP:M000_BCC_DATA_86F7
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-1Ch],AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-1Eh],AX
		mov	AX,6
		push	AX
		xor	AX,AX
		mov	DX,1055h
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,DGROUP:M000_BCC_DATA_86F9
		sub	AX,word ptr ES:[DI+4]
		mov	word ptr ES:[DI+6],AX
		xor	AX,AX
		push	AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		push	word ptr [BP-1Eh]
		push	AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X057_09
		dw	seg X057_09
		mov	word ptr [BP-0Ch],AX
		push	DI
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M000_BCC_DATA_86F7,AX
		cmp	byte ptr [BP-17h],0Ch
		je	short M000_L_21CE
		db	0FFh,076h,0EAh,0B8h,001h,000h,050h,00Eh
		db	0E8h,0BAh,0F7h,089h,056h,0F2h,089h,046h
		db	0F0h,0B8h,002h,000h,050h,0B0h,000h,050h
		db	0FFh,076h,0F0h,033h,0C0h,050h
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-10h],AX
		cmp	word ptr [BP-0Eh],0
		je	short M000_L_21D8
		mov	AX,2
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Eh],AX
		jmp	short M000_L_21D8
M000_L_21CE:
		push	word ptr [BP-16h]
		xor	AX,AX
		push	AX
		push	CS
		db	0E8h
		dw	0F778h
M000_L_21D8:
		mov	BX,word ptr DGROUP:M000_BCC_DATA_86F7
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,DGROUP:M000_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		push	DI
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	DI
		push	word ptr [BP-1Ch]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X057_07
		dw	seg X057_07
		push	AX
		db	09Ah
		dw	04Dh
		dw	seg CO057_TEXT
		push	DI
		push	word ptr [BP-1Eh]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M000_BCC_DATA_86F7,AX
		cmp	byte ptr [BP-17h],0Ch
		je	short M000_L_2266
		push	word ptr [BP-1Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F722h
		mov	word ptr [BP-12h],DX
		mov	word ptr [BP-14h],AX
		mov	AX,2
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-14h]
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-14h],AX
		cmp	word ptr [BP-12h],0
		je	short M000_L_2270
		mov	AX,2
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-12h]
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-12h],AX
		jmp	short M000_L_2270
M000_L_2266:
		push	word ptr [BP-1Ah]
		xor	AX,AX
		push	AX
		push	CS
		db	0E8h
		dw	0F6E0h
M000_L_2270:
		mov	BX,word ptr DGROUP:M000_BCC_DATA_86F7
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,DGROUP:M000_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		push	DI
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	DI
		push	word ptr [BP-1Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M000_BCC_DATA_86F7,AX
		push	DI
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		cmp	byte ptr [BP-17h],0Ch
		je	short M000_L_22DF
		mov	AX,3
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-10h]
		push	word ptr [BP-14h]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-0Eh],0
		je	short M000_L_22DF
		mov	AX,3
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-12h]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
M000_L_22DF:
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		jmp	short M000_L_231F
M000_L_22E7:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI],0Bh
		je	short M000_L_22F7
		cmp	word ptr ES:[SI],0Ch
		jne	short M000_L_2319
M000_L_22F7:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],7
		je	short M000_L_2309
		cmp	word ptr ES:[SI+2],8
		jne	short M000_L_2319
M000_L_2309:
		mov	AX,6
		push	AX
		xor	AX,AX
		mov	DX,55h
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
M000_L_2319:
		push	SI
		db	09Ah
		dw	BCC_FAR_5F79
		dw	seg BCC_FAR_5F79
M000_L_231F:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_1950	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_2327	label	word
		dw	003CAh
		dw	003CAh
		dw	005B5h
		dw	005B5h
		dw	00997h
		dw	00997h
		dw	00997h
		dw	0027Dh
		dw	00554h
		dw	00554h
		dw	0050Ch
		dw	004F0h
		dw	004F0h
		dw	0050Ch
		dw	0050Ch
		dw	00997h
		dw	00997h
		dw	00997h
		dw	00757h
		dw	00757h
		dw	00757h
		dw	00757h
		dw	00757h
		dw	00757h
		dw	00380h
		dw	004A6h
		dw	007B0h
		dw	00997h
		dw	00757h
		dw	00757h
		dw	00107h
		dw	00113h
		dw	00997h
		dw	00997h
		dw	00997h
		dw	00997h
		dw	00997h
		dw	0072Fh
		dw	001C4h
		dw	00354h
		dw	000FEh
		dw	00997h
		dw	000E2h
		dw	00723h

CO059_TEXT	ends

		extrn	X057_05:far
		extrn	X058_01:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M002_BCC_DATA_8186	equ	8186h

		public	X059_05
X059_05	label	far
BCC_FAR_237F	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		mov	SI,word ptr [BP+6]
		push	SI
		db	09Ah
		dw	X057_05
		dw	seg X057_05
		push	AX
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F5B8h
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		sub	BX,7
		cmp	BX,9
		ja	short M002_L_23B5
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0A92h
M002_L_23B5:
		mov	AX,0B5h
		jmp	short M002_L_23CC
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-2]
		jmp	short M002_L_23D6
		mov	AX,0B4h
M002_L_23CC:
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
M002_L_23D6:
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_237F	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_23E2	label	word
		dw	00A6Ah
		dw	00A6Ah
		dw	00A79h
		dw	00A79h
		dw	00A79h
		dw	00A65h
		dw	00A65h
		dw	00A65h
		dw	00A6Ah
		dw	00A6Ah

CO059_TEXT	ends

		extrn	X057_05:far
		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X062_0D:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M004_BCC_DATA_8186	equ	8186h

		public	X059_04
X059_04	label	far
BCC_NEAR_23F6	label	near
BCC_FAR_23F6	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Eh
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		push	SI
		db	09Ah
		dw	X057_05
		dw	seg X057_05
		mov	SI,AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		dec	BX
		cmp	BX,0Fh
		jbe	short M004_L_241A
		db	0E9h
		dw	001BAh
M004_L_241A:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0C8Ch
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F526h
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	AX,4Dh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-4]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	0018Fh
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8186
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-0Eh],AX
		cmp	word ptr [BP-0Eh],0Fh
		jne	short M004_L_24B0
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-2],AX
		mov	DI,word ptr ES:[SI+0Ah]
		cmp	byte ptr ES:[SI+6],0
		jle	short M004_L_247B
		push	word ptr [BP-2]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F4DEh
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		push	DI
		jmp	short M004_L_248D
M004_L_247B:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F4CCh
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		push	word ptr [BP-2]
M004_L_248D:
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F4BBh
		mov	word ptr [BP-8],DX
		mov	word ptr [BP-0Ah],AX
		mov	AX,86h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00124h
M004_L_24B0:
		push	SI
		db	0E8h
		dw	006E8h
		or	AX,AX
		jne	short M004_L_24EE
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F48Fh
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Ch],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	000E6h
M004_L_24EE:
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F459h
		db	0E9h
		dw	000DAh
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8186
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-0Eh],AX
		cmp	word ptr [BP-0Eh],0Fh
		jne	short M004_L_2564
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-2],AX
		mov	DI,word ptr ES:[SI+0Ah]
		cmp	byte ptr ES:[SI+6],0
		jle	short M004_L_2530
		push	word ptr [BP-2]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F429h
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		push	DI
		jmp	short M004_L_2542
M004_L_2530:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F417h
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		push	word ptr [BP-2]
M004_L_2542:
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F406h
		mov	word ptr [BP-8],DX
		mov	word ptr [BP-0Ah],AX
		mov	AX,85h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		jmp	short M004_L_25D4
M004_L_2564:
		push	SI
		db	0E8h
		dw	00634h
		or	AX,AX
		jne	short M004_L_25A1
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F3DBh
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	AX,9
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Ch],AX
		mov	AX,80h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		jmp	short M004_L_25D4
M004_L_25A1:
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F3A6h
		jmp	short M004_L_25D4
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F39Bh
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		push	word ptr [BP-6]
		mov	AX,8Ah
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		db	09Ah
		dw	X062_0D
		dw	seg X062_0D
M004_L_25D4:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_23F6	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_25DC	label	word
		dw	00BAAh
		dw	00BAAh
		dw	00AF5h
		dw	00AF5h
		dw	00AF5h
		dw	00AF5h
		dw	00AD1h
		dw	00AD1h
		dw	00C5Ch
		dw	00C5Ch
		dw	00C5Ch
		dw	00C84h
		dw	00AF5h
		dw	00AF5h
		dw	00AD1h
		dw	00AD1h

CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP



		public	X059_02
X059_02	label	far
BCC_NEAR_25FC	label	near
BCC_FAR_25FC	proc	far
		push	BP
		mov	BP,SP
		mov	BX,word ptr [BP+6]
		dec	BX
		cmp	BX,3
		ja	short M006_L_261F
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0CD5h
		mov	AL,0Eh
		db	0EBh,00Eh
		mov	AL,0Dh
		jmp	short M006_L_2621
		db	0B0h,00Ch,0EBh,006h
		mov	AL,0Fh
		jmp	short M006_L_2621
M006_L_261F:
		mov	AL,0FFh
M006_L_2621:
		pop	BP
		retf	2
BCC_FAR_25FC	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_2625	label	word
		dw	00CC7h
		dw	00CBFh
		dw	00CCBh
		dw	00CC3h

CO059_TEXT	ends

		extrn	X057_01:far
		extrn	X057_06:far
		extrn	X057_05:far
		extrn	X057_08:far
		extrn	X057_10:far
		extrn	X058_01:far
		extrn	X062_0D:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M008_BCC_DATA_3D83	equ	3D83h
M008_BCC_DATA_8186	equ	8186h
M008_BCC_DATA_8654	equ	8654h
M008_BCC_DATA_86F7	equ	86F7h
M008_BCC_DATA_86F9	equ	86F9h

		public	X059_06
X059_06	label	far
BCC_FAR_262D	proc	far
		push	BP
		mov	BP,SP
		sub	SP,16h
		push	SI
		push	DI
		push	word ptr [BP+8]
		db	09Ah
		dw	X057_05
		dw	seg X057_05
		mov	word ptr [BP+8],AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	BX,word ptr [BP+8]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-10h],AX
		mov	SI,word ptr ES:[BX+0Ah]
		mov	DI,word ptr ES:[BX+0Ch]
		push	DI
		db	0E8h
		dw	005F8h
		or	AX,AX
		jne	short M008_L_269D
		push	SI
		db	0E8h
		dw	005F0h
		or	AX,AX
		jne	short M008_L_2679
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	byte ptr ES:[BX+6],0
		jle	short M008_L_269D
		cmp	word ptr ES:[SI],4
		je	short M008_L_269D
M008_L_2679:
		mov	word ptr [BP-16h],SI
		mov	SI,DI
		mov	DI,word ptr [BP-16h]
		push	word ptr [BP-10h]
		db	09Ah
		dw	X057_01
		dw	seg X057_01
		mov	word ptr [BP-10h],AX
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AL,byte ptr ES:[BX+6]
		neg	AL
		mov	byte ptr ES:[BX+6],AL
M008_L_269D:
		mov	AX,word ptr [BP-10h]
		mov	word ptr [BP-12h],AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-14h],AX
		push	word ptr [BP-10h]
		push	word ptr [BP-14h]
		db	0E8h
		dw	005E8h
		mov	word ptr [BP-10h],AX
		mov	AX,DGROUP:M008_BCC_DATA_86F7
		mov	word ptr [BP-0Ah],AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		dec	BX
		cmp	BX,0Fh
		jbe	short M008_L_26D1
		db	0E9h
		dw	00376h
M008_L_26D1:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	112Ch
		db	08Eh,006h,086h,081h,026h,083h,03Dh,002h
		db	075h,022h,083h,07Eh,0F0h,00Ah,074h,006h
		db	083h,07Eh,0F0h,00Bh,075h,016h
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+0Ah]
		or	AX,word ptr ES:[DI+0Ch]
		jne	short M008_L_2704
		push	SI
		push	CS
		db	0E8h
		dw	0FCF5h
		db	0E9h
		dw	00343h
M008_L_2704:
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	byte ptr ES:[BX+6],0
		jge	short M008_L_2732
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F235h
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F226h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		jmp	short M008_L_2750
M008_L_2732:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F215h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F206h
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
M008_L_2750:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-0Eh],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	BX,word ptr DGROUP:M008_BCC_DATA_86F7
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8654
		db	026h,081h,04Fh,01Ch
		dw	8
		mov	BX,word ptr [BP-12h]
		sub	BX,1Dh
		cmp	BX,5
		jbe	short M008_L_2786
		db	0E9h
		dw	00090h
M008_L_2786:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1120h
		push	word ptr [BP-10h]
		push	word ptr [BP+6]
		db	0E8h
		dw	00306h
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M008_BCC_DATA_86F7,AX
		mov	AX,0Bh
		jmp	short M008_L_2804
		mov	AX,0Bh
		push	AX
		push	word ptr [BP-0Eh]
		db	0E8h
		dw	002ECh
		jmp	short M008_L_2816
		push	word ptr [BP-10h]
		push	word ptr [BP+6]
		db	0E8h
		dw	002E1h
		jmp	short M008_L_2816
		mov	AX,20h
		push	AX
		push	word ptr [BP-14h]
		db	0E8h
		dw	004D8h
		push	AX
		push	word ptr [BP+6]
		db	0E8h
		dw	002CEh
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M008_BCC_DATA_86F7,AX
		mov	AX,1Fh
		jmp	short M008_L_27FD
		mov	AX,1Fh
		push	AX
		push	word ptr [BP-14h]
		db	0E8h
		dw	004B7h
		push	AX
		db	0FFh,076h,006h
		db	0E8h
		dw	002ADh
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M008_BCC_DATA_86F7,AX
		mov	AX,20h
M008_L_27FD:
		push	AX
		push	word ptr [BP-14h]
		db	0E8h
		dw	0049Bh
M008_L_2804:
		push	AX
		push	word ptr [BP-0Eh]
		db	0E8h
		dw	00291h
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
M008_L_2816:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-0Ch],AX
		mov	DGROUP:M008_BCC_DATA_86F7,AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	word ptr [BP-12h]
		mov	AX,6
		push	AX
		db	0E8h
		dw	00462h
		push	AX
		push	word ptr [BP+6]
		db	0E8h
		dw	00258h
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	0E9h
		dw	0020Bh
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	word ptr ES:[DI],2
		jne	short M008_L_28A1
		mov	AX,word ptr ES:[DI+0Ah]
		or	AX,word ptr ES:[DI+0Ch]
		jne	short M008_L_28A1
		cmp	word ptr ES:[SI],0Fh
		jne	short M008_L_2899
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],4
		jne	short M008_L_2899
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX+0Ch],-1
		jne	short M008_L_2899
		push	word ptr [BP-10h]
		push	SI
		db	0E8h
		dw	00236h
		mov	word ptr [BP-10h],AX
		db	0E9h
		dw	001AEh
M008_L_2899:
		push	SI
		push	CS
		db	0E8h
		dw	0FB58h
		db	0E9h
		dw	001A6h
M008_L_28A1:
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	byte ptr ES:[BX+6],0
		jge	short M008_L_28CF
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F098h
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F089h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		jmp	short M008_L_28ED
M008_L_28CF:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F078h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F069h
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
M008_L_28ED:
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00145h
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		cmp	word ptr ES:[DI],2
		jne	short M008_L_291E
		mov	AX,word ptr ES:[DI+0Ah]
		or	AX,word ptr ES:[DI+0Ch]
		jne	short M008_L_291E
		push	SI
		push	CS
		db	0E8h
		dw	0FADBh
		db	0E9h
		dw	00129h
M008_L_291E:
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		db	026h
		cmp	byte ptr [BX+6],0
		jge	short M008_L_294C
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F01Bh
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0F00Ch
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		jmp	short M008_L_296A
M008_L_294C:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EFFBh
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EFECh
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
M008_L_296A:
		mov	AX,80h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	000C8h
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EFC8h
		push	AX
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EFBEh
		push	AX
		db	09Ah
		dw	X062_0D
		dw	seg X062_0D
		db	0E9h
		dw	000ACh
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8186
		mov	AL,byte ptr ES:[SI+6]
		cbw
		cwd
		xor	AX,DX
		sub	AX,DX
		push	AX
		mov	AL,byte ptr ES:[DI+6]
		cbw
		cwd
		xor	AX,DX
		sub	AX,DX
		pop	DX
		cmp	DX,AX
		jle	short M008_L_29F8
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EF8Eh
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EF7Fh
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-2]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
M008_L_29F0:
		push	word ptr [BP-8]
		db	0FFh,076h,0FAh
		jmp	short M008_L_2A35
M008_L_29F8:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EF4Fh
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EF40h
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-2]
M008_L_2A35:
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,52C2h
		push	AX
		mov	AX,55h
		push	AX
		nop
		push	CS
		db	0E8h
		dw	006C7h
M008_L_2A47:
		mov	BX,word ptr DGROUP:M008_BCC_DATA_86F7
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8654
		mov	AX,DGROUP:M008_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		mov	AX,word ptr [BP-10h]
		mov	word ptr ES:[BX+8],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[BX+10h],AX
M008_L_2A68:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_262D	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_2A70	label	word
		dw	00E56h
		dw	00E62h
		dw	00E3Dh
		dw	00E3Dh
		dw	00E8Eh
		dw	00E6Dh
		dw	00FB2h
		dw	00FB2h
		dw	00F0Dh
		dw	00F0Dh
		dw	00F0Dh
		dw	00F0Dh
		dw	00D88h
		dw	00D88h
		dw	0102Fh
		dw	0102Fh
		dw	0102Fh
		dw	010F7h
		dw	00F0Dh
		dw	00F0Dh
		dw	00D88h
		dw	0104Bh

CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M00A_BCC_DATA_8654	equ	8654h
M00A_BCC_DATA_86F7	equ	86F7h
M00A_BCC_DATA_86F9	equ	86F9h


BCC_NEAR_2A9C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		mov	BX,word ptr DGROUP:M00A_BCC_DATA_86F7
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8654
		mov	AX,DGROUP:M00A_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[BX+8],AX
		mov	AX,word ptr [BP+4]
		mov	word ptr ES:[BX+10h],AX
		mov	AX,DGROUP:M00A_BCC_DATA_86F7
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_2A9C	endp
CO059_TEXT	ends


		extrn	X049_04:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M00B_BCC_DATA_8186	equ	8186h

BCC_NEAR_2AC9	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		cmp	SI,0Ah
		je	short M00B_L_2AE5
		cmp	SI,0Bh
		je	short M00B_L_2AE5
		db	0E9h
		dw	0008Fh
M00B_L_2AE5:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	AX,word ptr ES:[DI+0Ch]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],2
		je	short M00B_L_2AFB
		jmp	short M00B_L_2B74
M00B_L_2AFB:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		push	word ptr ES:[BX+0Ch]
		push	word ptr ES:[BX+0Ah]
		db	09Ah
		dw	X049_04
		dw	seg X049_04
		db	089h,046h,0FCh
		cmp	word ptr [BP-4],0
		jge	short M00B_L_2B1A
		jmp	short M00B_L_2B74
M00B_L_2B1A:
		mov	BX,word ptr [BP-4]
		cmp	BX,0Bh
		ja	short M00B_L_2B74
		shl	BX,1
		db	02Eh,0FFh,0A7h,034h,012h
		cmp	SI,0Ah
		jne	short M00B_L_2B33
		mov	AX,0Dh
		jmp	short M00B_L_2B36
M00B_L_2B33:
		mov	AX,0Ch
M00B_L_2B36:
		jmp	short M00B_L_2B7B
		cmp	SI,0Ah
		jne	short M00B_L_2B42
		mov	AX,13h
		jmp	short M00B_L_2B45
M00B_L_2B42:
		mov	AX,12h
M00B_L_2B45:
		jmp	short M00B_L_2B7B
		cmp	SI,0Ah
		jne	short M00B_L_2B51
		mov	AX,0Bh
		jmp	short M00B_L_2B54
M00B_L_2B51:
		mov	AX,0Ah
M00B_L_2B54:
		jmp	short M00B_L_2B7B
		cmp	SI,0Ah
		jne	short M00B_L_2B60
		mov	AX,11h
		jmp	short M00B_L_2B63
M00B_L_2B60:
		mov	AX,10h
M00B_L_2B63:
		jmp	short M00B_L_2B7B
		cmp	SI,0Ah
		jne	short M00B_L_2B6F
		mov	AX,0Fh
		jmp	short M00B_L_2B72
M00B_L_2B6F:
		mov	AX,0Eh
M00B_L_2B72:
		jmp	short M00B_L_2B7B
M00B_L_2B74:
		push	DI
		push	CS
		db	0E8h
		dw	0F87Dh
		mov	AX,SI
M00B_L_2B7B:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_2AC9	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_2B84	label	word
		dw	011D9h
		dw	01224h
		dw	011E8h
		dw	01224h
		dw	01224h
		dw	01224h
		dw	011F7h
		dw	01206h
		dw	01224h
		dw	01224h
		dw	01224h
		dw	01215h

CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M00D_BCC_DATA_8186	equ	8186h


BCC_NEAR_2B9C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		test	byte ptr [BX+9CAh],20h
		je	short M00D_L_2BB5
		jmp	short M00D_L_2C1F
M00D_L_2BB5:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8186
		mov	BX,word ptr ES:[SI]
		sub	BX,8
		cmp	BX,14h
		ja	short M00D_L_2C1F
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	12D7h
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		cmp	word ptr ES:[BX],2
		jne	short M00D_L_2BF0
		mov	BX,word ptr ES:[SI+0Ch]
		cmp	word ptr ES:[BX+0Ch],0
		jne	short M00D_L_2BF0
		cmp	word ptr ES:[BX+0Ah],1
		jne	short M00D_L_2BF0
		mov	AX,4
		jmp	short M00D_L_2C21
M00D_L_2BF0:
		mov	AX,2
		jmp	short M00D_L_2C21
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		cmp	word ptr ES:[BX],2
		jne	short M00D_L_2C1A
		mov	BX,word ptr ES:[SI+0Ch]
		cmp	word ptr ES:[BX+0Ch],0
		jne	short M00D_L_2C1A
		cmp	word ptr ES:[BX+0Ah],1
		jne	short M00D_L_2C1A
		mov	AX,3
		jmp	short M00D_L_2C21
M00D_L_2C1A:
		mov	AX,1
		jmp	short M00D_L_2C21
M00D_L_2C1F:
		xor	AX,AX
M00D_L_2C21:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_2B9C	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_2C27	label	word
		dw	0127Bh
		dw	0127Bh
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012A0h
		dw	012A0h
		dw	012CFh
		dw	012A5h
		dw	012A5h
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012CFh
		dw	012CAh
		dw	012CAh
		dw	012CAh

CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M00F_BCC_DATA_8186	equ	8186h


BCC_NEAR_2C51	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		jmp	short M00F_L_2C63
M00F_L_2C5B:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8186
		mov	SI,word ptr ES:[SI+0Ah]
M00F_L_2C63:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8186
		cmp	word ptr ES:[SI],35h
		je	short M00F_L_2C5B
		cmp	word ptr ES:[SI],2
		jne	short M00F_L_2C78
		mov	AX,1
		jmp	short M00F_L_2C99
M00F_L_2C78:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8186
		cmp	word ptr ES:[SI],32h
		je	short M00F_L_2C84
		jmp	short M00F_L_2C97
M00F_L_2C84:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX],1
		jne	short M00F_L_2C97
		mov	AX,3
		jmp	short M00F_L_2C99
M00F_L_2C97:
		xor	AX,AX
M00F_L_2C99:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_2C51	endp
CO059_TEXT	ends


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP



BCC_NEAR_2C9F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AX,word ptr [BP+4]
		cmp	AX,5
		je	short M010_L_2CC9
		jg	short M010_L_2CBD
		cmp	AX,1
		je	short M010_L_2CC9
		cmp	AX,3
		je	short M010_L_2CC9
		jmp	short M010_L_2CCF
M010_L_2CBD:
		cmp	AX,7
		je	short M010_L_2CC9
		cmp	AX,15h
		je	short M010_L_2CC9
		jmp	short M010_L_2CCF
M010_L_2CC9:
		mov	AL,byte ptr [SI+5268h]
		jmp	short M010_L_2CD3
M010_L_2CCF:
		mov	AL,byte ptr [SI+5262h]
M010_L_2CD3:
		cbw
		pop	SI
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_2C9F	endp
CO059_TEXT	ends


		extrn	BCC_FAR_AA87:far
		extrn	X056_0E:far
		extrn	X057_06:far
		extrn	X057_04:far
		extrn	X057_10:far
		extrn	X058_01:far
		extrn	X058_03:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M011_BCC_DATA_16EF	equ	16EFh
M011_BCC_DATA_16FF	equ	16FFh
M011_BCC_DATA_1713	equ	1713h
M011_BCC_DATA_1776	equ	1776h
M011_BCC_DATA_7846	equ	7846h
M011_BCC_DATA_814C	equ	814Ch
M011_BCC_DATA_8654	equ	8654h
M011_BCC_DATA_86D6	equ	86D6h
M011_BCC_DATA_86E6	equ	86E6h
M011_BCC_DATA_86F2	equ	86F2h
M011_BCC_DATA_86F5	equ	86F5h
M011_BCC_DATA_86F7	equ	86F7h
M011_BCC_DATA_86F9	equ	86F9h
M011_BCC_DATA_8894	equ	8894h
M011_BCC_DATA_88AC	equ	88ACh

		public	X059_08
X059_08	label	far
BCC_FAR_2CDA	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Eh
		push	SI
		push	DI
		push	word ptr DGROUP:M011_BCC_DATA_86D6
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8894
		push	word ptr DGROUP:M011_BCC_DATA_7846
		push	word ptr ES:[BX+11h]
		push	DS
		mov	AX,52C8h
		push	AX
		db	09Ah
		dw	BCC_FAR_AA87
		dw	seg BCC_FAR_AA87
		or	AX,AX
		jne	short M011_L_2D11
		db	081h,00Eh,0ACh,088h,008h,000h
M011_L_2D11:
		cmp	byte ptr DGROUP:M011_BCC_DATA_1776,0
		je	short M011_L_2D1B
		db	0E9h
		dw	001CBh
M011_L_2D1B:
		cmp	byte ptr DGROUP:M011_BCC_DATA_16FF,0
		jne	short M011_L_2D25
		db	0E9h
		dw	001C1h
M011_L_2D25:
		cmp	byte ptr DGROUP:M011_BCC_DATA_86F2,4
		jne	short M011_L_2D2F
		db	0E9h
		dw	001B7h
M011_L_2D2F:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-0Eh],AX
		cmp	word ptr DGROUP:M011_BCC_DATA_86E6,0C8h
		jbe	short M011_L_2DA7
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-4],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-6],AX
		mov	DGROUP:M011_BCC_DATA_86F7,AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	SI,AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Bh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-8],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	SI
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,5
		push	AX
		push	word ptr [BP-4]
		db	0E8h
		dw	0FD05h
		push	word ptr DGROUP:M011_BCC_DATA_86F5
		push	word ptr [BP-6]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M011_L_2DA7:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-6],AX
		mov	DGROUP:M011_BCC_DATA_86F7,AX
		cmp	byte ptr DGROUP:M011_BCC_DATA_16EF,5
		je	short M011_L_2E01
		cmp	byte ptr DGROUP:M011_BCC_DATA_16EF,4
		je	short M011_L_2DCE
		cmp	byte ptr DGROUP:M011_BCC_DATA_16EF,3
		je	short M011_L_2DCE
		cmp	byte ptr DGROUP:M011_BCC_DATA_1713,0
		je	short M011_L_2DD8
M011_L_2DCE:
		mov	word ptr [BP-0Ah],5
		mov	AX,52CEh
		jmp	short M011_L_2DE0
M011_L_2DD8:
		mov	word ptr [BP-0Ah],4
		mov	AX,52D6h
M011_L_2DE0:
		push	AX
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		mov	word ptr [BP-0Ch],AX
		mov	AX,10h
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	SI,AX
		jmp	short M011_L_2E4F
M011_L_2E01:
		mov	AX,52CEh
		push	AX
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		mov	word ptr [BP-0Ch],AX
		mov	AX,0Dh
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	SI,AX
		mov	AX,0Ch
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	word ptr [BP-8],AX
		mov	AX,16h
		push	AX
		mov	AL,0
		push	AX
		push	SI
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	SI,AX
		mov	word ptr [BP-0Ah],5
M011_L_2E4F:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Bh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-8],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	SI
		push	word ptr [BP-8]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	word ptr [BP-0Ah]
		push	word ptr [BP-0Eh]
		db	0E8h
		dw	0FC1Eh
		push	word ptr DGROUP:M011_BCC_DATA_86F5
		push	word ptr [BP-6]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr DGROUP:M011_BCC_DATA_86E6,0C8h
		jbe	short M011_L_2EA6
		push	word ptr DGROUP:M011_BCC_DATA_86F5
		push	word ptr [BP-4]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M011_L_2EA6:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	DI,AX
		mov	AX,52DFh
		push	AX
		xor	AX,AX
		push	AX
		nop
		push	CS
		db	0E8h
		dw	00255h
		mov	ES,word ptr DGROUP:M011_BCC_DATA_8654
		mov	AX,DGROUP:M011_BCC_DATA_86F9
		sub	AX,word ptr ES:[DI+4]
		mov	word ptr ES:[DI+6],AX
		push	word ptr DGROUP:M011_BCC_DATA_86F5
		push	DI
		mov	AX,1
		push	AX
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		push	word ptr DGROUP:M011_BCC_DATA_86F5
		push	word ptr [BP-0Eh]
		mov	AX,1
		push	AX
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M011_L_2EE6:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_2CDA	endp
CO059_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M012_BCC_DATA_8164	equ	8164h
M012_BCC_DATA_8186	equ	8186h

		public	X059_09
X059_09	label	far
BCC_FAR_2EEC	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M012_BCC_DATA_8186
		push	word ptr ES:[DI+8]
		db	0FFh,01Eh
		dw	8164h
		mov	SI,AX
		cmp	SI,4
		je	short M012_L_2F14
		cmp	SI,2
		je	short M012_L_2F14
		cmp	SI,1
		jne	short M012_L_2F1D
M012_L_2F14:
		push	DI
		db	0E8h
		dw	00173h
		mov	AX,1
		jmp	short M012_L_2F82
M012_L_2F1D:
		push	DI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0EA2Ah
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		push	word ptr [BP-2]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		test	SI,1
		je	short M012_L_2F45
		inc	SI
M012_L_2F45:
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		push	AX
		push	SI
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,52E9h
		push	AX
		mov	AX,1050h
		push	AX
		nop
		push	CS
		db	0E8h
		dw	0019Fh
		mov	AX,0AEh
		push	AX
		mov	AX,SI
		neg	AX
		xor	DX,DX
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		xor	AX,AX
M012_L_2F82:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_2EEC	endp
CO059_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M013_BCC_DATA_8164	equ	8164h
M013_BCC_DATA_8186	equ	8186h

		public	X059_0A
X059_0A	label	far
BCC_NEAR_2F8A	label	near
BCC_FAR_2F8A	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M013_BCC_DATA_8186
		mov	SI,word ptr ES:[DI+0Ah]
		mov	AX,word ptr ES:[DI+0Ch]
		mov	word ptr [BP-2],AX
		push	word ptr ES:[SI+8]
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr [BP-4],AX
		mov	AX,6
		push	AX
		xor	AX,AX
		mov	DX,1055h
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	SI
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E988h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	word ptr [BP-2]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E953h
		mov	word ptr [BP-0Ah],DX
		mov	word ptr [BP-0Ch],AX
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ah]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,94h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		push	AX
		push	word ptr [BP-4]
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,52F0h
		push	AX
		mov	AX,1040h
		push	AX
		nop
		push	CS
		db	0E8h
		dw	000BBh
		mov	AX,0AEh
		push	AX
		xor	AX,AX
		mov	DX,8
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		cmp	word ptr [BP+6],0
		je	short M013_L_3073
		push	SI
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0E8DFh
		jmp	short M013_L_3083
M013_L_3073:
		mov	word ptr [BP-6],0
		mov	word ptr [BP-8],0
		mov	DX,word ptr [BP-6]
		mov	AX,word ptr [BP-8]
M013_L_3083:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_2F8A	endp
CO059_TEXT	ends


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M014_BCC_DATA_8108	equ	8108h
M014_BCC_DATA_8164	equ	8164h
M014_BCC_DATA_8186	equ	8186h


BCC_NEAR_308B	proc	near
M014_L_308B:
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8186
		push	word ptr ES:[SI+8]
		db	0FFh,01Eh
		dw	8164h
		mov	DI,AX
		cmp	DI,1
		jne	short M014_L_30AF
		mov	byte ptr [BP-1],2
		jmp	short M014_L_30C3
M014_L_30AF:
		cmp	DI,2
		jne	short M014_L_30BA
		mov	byte ptr [BP-1],6
		jmp	short M014_L_30C3
M014_L_30BA:
		cmp	DI,4
		jne	short M014_L_3105
		mov	byte ptr [BP-1],8
M014_L_30C3:
		mov	AL,byte ptr [BP-1]
		mov	AH,0
		push	AX
		db	0FFh,01Eh
		dw	8108h
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8186
		mov	word ptr ES:[SI+8],AX
		mov	AL,byte ptr [BP-1]
		mov	AH,0
		mov	word ptr ES:[SI+2],AX
		cmp	word ptr ES:[SI],34h
		jne	short M014_L_30E9
		mov	word ptr ES:[SI],12h
M014_L_30E9:
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8186
		cmp	word ptr ES:[SI],12h
		jne	short M014_L_3105
		push	word ptr ES:[SI+0Ah]
		db	0E8h
		dw	0FF91h
		mov	ES,word ptr DGROUP:M014_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		db	0E8h
		dw	0FF86h
M014_L_3105:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_308B	endp
CO059_TEXT	ends


		extrn	BCC_FAR_B072:far
		extrn	BCC_FAR_B146:far
		extrn	X058_03:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M015_BCC_DATA_16EF	equ	16EFh
M015_BCC_DATA_814C	equ	814Ch
M015_BCC_DATA_88AC	equ	88ACh

		public	X059_01
X059_01	label	far
BCC_NEAR_310E	label	near
BCC_FAR_310E	proc	far
		push	BP
		mov	BP,SP
		sub	SP,20h
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		cmp	byte ptr DGROUP:M015_BCC_DATA_16EF,0
		je	short M015_L_3128
		test	word ptr DGROUP:M015_BCC_DATA_88AC,8
		je	short M015_L_3133
M015_L_3128:
		push	SS
		lea	AX,[BP-20h]
		push	AX
		push	DS
		mov	AX,52F7h
		jmp	short M015_L_313C
M015_L_3133:
		push	SS
		lea	AX,[BP-20h]
		push	AX
		push	DS
		mov	AX,52FAh
M015_L_313C:
		push	AX
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	SS
		lea	AX,[BP-20h]
		push	AX
		push	DS
		push	word ptr [BP+8]
		db	09Ah
		dw	BCC_FAR_B146
		dw	seg BCC_FAR_B146
		lea	AX,[BP-20h]
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		mov	DI,AX
		test	word ptr DGROUP:M015_BCC_DATA_88AC,8
		je	short M015_L_316B
		mov	AX,77h
		jmp	short M015_L_316E
M015_L_316B:
		mov	AX,78h
M015_L_316E:
		push	AX
		push	DI
		push	SI
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_310E	endp
CO059_TEXT	ends




CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M016_BCC_DATA_8186	equ	8186h

		public	X059_07
X059_07	label	far
BCC_NEAR_3181	label	near
BCC_FAR_3181	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M016_BCC_DATA_8186
		mov	BX,word ptr ES:[SI]
		shl	BX,1
		shl	BX,1
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		add	BX,AX
		push	word ptr [BX+5235h]
		mov	AX,55h
		push	AX
		push	CS
		db	0E8h
		dw	0FF67h
		pop	SI
		pop	BP
		retf	2
BCC_FAR_3181	endp
CO059_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M017_BCC_DATA_8164	equ	8164h
M017_BCC_DATA_8186	equ	8186h

BCC_NEAR_31AC	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	DI,word ptr [BP+8]
		mov	SI,word ptr [BP+4]
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M017_BCC_DATA_8186
		push	word ptr ES:[BX+8]
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr [BP-2],AX
		push	word ptr [BP+6]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E778h
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-2],3
		je	short M017_L_31EA
		cmp	word ptr [BP-2],4
		jbe	short M017_L_321B
M017_L_31EA:
		or	SI,SI
		je	short M017_L_320E
		mov	AX,1Fh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		push	AX
		push	SI
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-6],AX
M017_L_320E:
		push	DI
		push	word ptr [BP-4]
		push	word ptr [BP-6]
		db	0E8h
		dw	007C4h
		db	0E9h
		dw	000F8h
M017_L_321B:
		mov	ES,word ptr DGROUP:M017_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+2]
		dec	BX
		cmp	BX,0Dh
		jbe	short M017_L_322C
		db	0E9h
		dw	000E1h
M017_L_322C:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	19D4h
		mov	AX,SI
		cmp	AX,1
		je	short M017_L_3241
		cmp	AX,2
		je	short M017_L_32B7
		jmp	short M017_L_32BF
M017_L_3241:
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,1
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,9Bh
		push	AX
		mov	AL,2
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,1
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,2
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		jmp	short M017_L_32BA
M017_L_32B7:
		mov	AX,word ptr [BP-4]
M017_L_32BA:
		mov	word ptr [BP-6],AX
		jmp	short M017_L_3308
M017_L_32BF:
		jmp	short M017_L_3308
		mov	BX,SI
		cmp	BX,3
		ja	short M017_L_3308
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	19CCh
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		jmp	short M017_L_32FC
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		mov	AX,1
		jmp	short M017_L_32FC
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		mov	AX,2
		jmp	short M017_L_32FC
		mov	AX,7
		push	AX
		mov	AL,0
		push	AX
		mov	AX,3
M017_L_32FC:
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-6],AX
M017_L_3308:
		mov	word ptr [BP-4],0
M017_L_330D:
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
M017_L_3313:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_31AC	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_331C	label	word
		dw	0197Fh
		dw	0198Ah
		dw	01996h
		dw	019A2h
		dw	01971h
		dw	01971h
		dw	018E3h
		dw	018E3h
		dw	018E3h
		dw	018E3h
		dw	019BDh
		dw	019BDh
		dw	019BDh
		dw	019BDh
		dw	019BDh
		dw	019BDh
		dw	018E3h
		dw	018E3h

CO059_TEXT	ends

		extrn	BCC_FAR_5B44:far
		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X058_03:far
		extrn	X073_00:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M019_BCC_DATA_1712	equ	1712h
M019_BCC_DATA_814C	equ	814Ch
M019_BCC_DATA_8186	equ	8186h

BCC_NEAR_3340	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,10h
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E5F4h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E5DEh
		mov	word ptr [BP-0Ah],DX
		mov	word ptr [BP-0Ch],AX
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		dec	BX
		cmp	BX,0Fh
		ja	short M019_L_338D
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1C61h
M019_L_338D:
		mov	AX,1
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
		mov	word ptr [BP-2],0
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+5036h]
		mov	AH,0
		add	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	001CAh
		mov	AX,98h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		mov	AX,26h
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,30h
		push	AX
		mov	AL,22h
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00179h
		mov	AX,word ptr [BP-6]
		mov	word ptr [BP-2],AX
		mov	AX,98h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00146h
		cmp	byte ptr DGROUP:M019_BCC_DATA_1712,0
		jne	short M019_L_3466
		db	0E9h
		dw	000B5h
M019_L_3466:
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-0Eh],AX
		mov	AX,0Dh
		push	AX
		mov	AX,52FDh
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	word ptr [BP-10h],AX
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		cmp	word ptr ES:[SI],23h
		jne	short M019_L_34D0
		mov	AX,1Dh
		jmp	short M019_L_34D3
M019_L_34D0:
		mov	AX,26h
M019_L_34D3:
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,24h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-0Eh]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DI,AX
		mov	AX,45h
		push	AX
		mov	AL,0
		push	AX
		push	DI
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DI,AX
		mov	AX,28h
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-6]
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00087h
M019_L_351B:
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AL,0Fh
		push	AX
		db	0E8h
		dw	00339h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	AX,6
		push	AX
		xor	AX,AX
		mov	DX,40h
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,0BEh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M019_BCC_DATA_8186
		cmp	word ptr ES:[SI],24h
		jne	short M019_L_3572
		mov	AX,5307h
		jmp	short M019_L_3575
M019_L_3572:
		mov	AX,530Dh
M019_L_3575:
		push	AX
		mov	AX,1055h
		push	AX
		push	CS
		db	0E8h
		dw	0FB90h
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-2],AX
M019_L_35A2:
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_3340	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_35B1	label	word
		dw	01A48h
		dw	01A48h
		dw	01A48h
		dw	01A48h
		dw	01A48h
		dw	01A48h
		dw	01A88h
		dw	01A88h
		dw	01A3Dh
		dw	01A3Dh
		dw	01A3Dh
		dw	01A3Dh
		dw	01A48h
		dw	01A3Dh
		dw	01AD9h
		dw	01B0Ch

CO059_TEXT	ends

		extrn	BCC_FAR_5B44:far
		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X058_03:far
		extrn	X073_00:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M01B_BCC_DATA_814C	equ	814Ch
M01B_BCC_DATA_8186	equ	8186h

BCC_NEAR_35D1	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,10h
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E363h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E34Dh
		mov	word ptr [BP-0Ah],DX
		mov	word ptr [BP-0Ch],AX
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		dec	BX
		cmp	BX,0Fh
		ja	short M01B_L_361E
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1EF2h
M01B_L_361E:
		mov	AX,1
		push	AX
		db	09Ah
		dw	BCC_FAR_5B44
		dw	seg BCC_FAR_5B44
		inc	SP
		inc	SP
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		mov	AL,byte ptr [BX+5036h]
		mov	AH,0
		add	AX,97h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-2],0
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	001CAh
		mov	AX,98h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		db	033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO058_TEXT
		mov	word ptr [BP-2],AX
		mov	AX,1Dh
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,24h
		push	AX
		mov	AL,22h
		push	AX
		push	word ptr [BP-6]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00179h
		mov	AX,word ptr [BP-6]
		mov	word ptr [BP-2],AX
		mov	AX,98h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	02Ah
		dw	seg CO058_TEXT
		db	0E9h,046h,001h,080h,03Eh,012h,017h,000h,075h
		db	003h,0E9h
		db	0B5h,000h,0B8h,099h,000h,050h,0B0h,000h,050h,0FFh,076h,0F8h
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-10h],AX
		mov	AX,0Dh
		push	AX
		mov	AX,52FDh
		push	AX
		mov	AX,1
		push	AX
		db	0FFh,01Eh
		dw	814Ch
		push	AX
		xor	AX,AX
		push	AX
		mov	AL,10h
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	word ptr [BP-0Eh],AX
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		cmp	word ptr ES:[SI],23h
		jne	short M01B_L_3761
		mov	AX,1Dh
		jmp	short M01B_L_3764
M01B_L_3761:
		mov	AX,26h
M01B_L_3764:
		push	AX
		mov	AL,12h
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,24h
		push	AX
		mov	AL,20h
		push	AX
		push	word ptr [BP-10h]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DI,AX
		mov	AX,45h
		push	AX
		mov	AL,0
		push	AX
		push	DI
		push	word ptr [BP-0Eh]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	DI,AX
		mov	AX,1Fh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-6]
		push	DI
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		db	0E9h
		dw	00087h
M01B_L_37AC:
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AL,0Fh
		push	AX
		db	0E8h
		dw	000A8h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		mov	AX,6
		push	AX
		xor	AX,AX
		mov	DX,40h
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	AX,0BEh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0B5h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-0Ah]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M01B_BCC_DATA_8186
		cmp	word ptr ES:[SI],24h
		jne	short M01B_L_3803
		mov	AX,5307h
		jmp	short M01B_L_3806
M01B_L_3803:
		mov	AX,530Dh
M01B_L_3806:
		push	AX
		mov	AX,1055h
		push	AX
		push	CS
		db	0E8h
		dw	0F8FFh
		mov	AX,0C2h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		mov	AX,0C3h
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-2],AX
M01B_L_3833:
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_35D1	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_3842	label	word
		dw	01CD9h
		dw	01CD9h
		dw	01CD9h
		dw	01CD9h
		dw	01CD9h
		dw	01CD9h
		dw	01D19h
		dw	01D19h
		dw	01CCEh
		dw	01CCEh
		dw	01CCEh
		dw	01CCEh
		dw	01CD9h
		dw	01CCEh
		dw	01D6Ah
		dw	01D9Dh

CO059_TEXT	ends

		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X058_03:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M01D_BCC_DATA_8186	equ	8186h

BCC_NEAR_3862	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		cmp	word ptr ES:[SI],31h
		jne	short M01D_L_3887
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0E0CCh
		db	0E9h
		dw	000C4h
M01D_L_3887:
		cmp	byte ptr [BP+4],0Dh
		je	short M01D_L_38C4
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		jne	short M01D_L_38AF
		mov	AX,0Ch
		push	AX
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		jmp	short M01D_L_38C2
M01D_L_38AF:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Fh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
M01D_L_38C2:
		mov	DI,AX
M01D_L_38C4:
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		cmp	word ptr ES:[SI],7
		jne	short M01D_L_38E5
		mov	AX,0Eh
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-4],DI
		jmp	short M01D_L_3945
M01D_L_38E5:
		cmp	byte ptr [BP+4],0Eh
		je	short M01D_L_3914
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		jne	short M01D_L_38F7
		jmp	short M01D_L_38F7
M01D_L_38F7:
		mov	AX,0Dh
		push	AX
		mov	ES,word ptr DGROUP:M01D_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		push	word ptr ES:[SI+0Ch]
		mov	AL,byte ptr ES:[SI+4]
		push	AX
		db	09Ah
		dw	X058_03
		dw	seg X058_03
		mov	word ptr [BP-2],AX
M01D_L_3914:
		mov	AL,byte ptr [BP+4]
		mov	AH,0
		sub	AX,0Dh
		mov	BX,AX
		cmp	BX,3
		ja	short M01D_L_3945
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	2004h
		mov	word ptr [BP-6],DI
		jmp	short M01D_L_3940
		mov	AX,word ptr [BP-2]
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-4],DI
		jmp	short M01D_L_3945
		mov	AX,word ptr [BP-2]
		mov	word ptr [BP-6],AX
M01D_L_3940:
		mov	word ptr [BP-4],0
M01D_L_3945:
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
M01D_L_394B:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_3862	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_3954	label	word
		dw	01FEAh
		dw	01FDAh
		dw	01FDFh
		dw	01FDFh

CO059_TEXT	ends

		extrn	X058_01:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M01F_BCC_DATA_8104	equ	8104h
M01F_BCC_DATA_8186	equ	8186h

		public	X059_03
X059_03	label	far
BCC_NEAR_395C	label	near
BCC_FAR_395C	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M01F_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[BX+2],0Dh
		jne	short M01F_L_39D3
		mov	BX,word ptr ES:[SI+0Ah]
		push	word ptr ES:[BX+8]
		db	0FFh,01Eh
		dw	8104h
		mov	word ptr [BP-2],AX
		cmp	AX,1
		je	short M01F_L_39BE
		cmp	AX,2
		je	short M01F_L_3994
		cmp	AX,3
		je	short M01F_L_39A9
		jmp	short M01F_L_39D3
M01F_L_3994:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Eh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		jmp	short M01F_L_39D5
M01F_L_39A9:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Fh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		jmp	short M01F_L_39D5
M01F_L_39BE:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Ch
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		jmp	short M01F_L_39D5
M01F_L_39D3:
		xor	AX,AX
M01F_L_39D5:
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_395C	endp
CO059_TEXT	ends


		extrn	X058_04:far
		extrn	X058_01:far
		extrn	X073_00:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M020_BCC_DATA_8104	equ	8104h
M020_BCC_DATA_8186	equ	8186h

BCC_NEAR_39DC	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		mov	SI,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M020_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+2]
		sub	BX,7
		cmp	BX,0Dh
		ja	short M020_L_39FE
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	218Dh
M020_L_39FE:
		mov	word ptr [BP-2],0
		cmp	word ptr [BP+6],0
		jne	short M020_L_3A11
		push	SI
		push	CS
		db	0E8h
		dw	0FF4Eh
		mov	word ptr [BP+6],AX
M020_L_3A11:
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP+4]
		push	word ptr [BP+6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		db	0E9h
		dw	000A3h
		cmp	word ptr [BP+6],0
		jne	short M020_L_3A3A
		push	SI
		push	CS
		db	0E8h
		dw	0FF25h
		mov	word ptr [BP+6],AX
M020_L_3A3A:
		mov	AX,1Bh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP+4]
		push	word ptr [BP+6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		mov	AX,16h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP+4]
		push	word ptr [BP+6]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
		jmp	short M020_L_3ACF
		mov	ES,word ptr DGROUP:M020_BCC_DATA_8186
		mov	SI,word ptr ES:[SI+0Ah]
		cmp	word ptr ES:[SI+2],0Dh
		jne	short M020_L_3A9E
		mov	AX,word ptr [BP+4]
		mov	word ptr [BP-4],AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		push	word ptr ES:[SI+8]
		db	0FFh,01Eh
		dw	8104h
		push	AX
		push	CS
		db	0E8h
		dw	0EB6Dh
		cbw
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		jmp	short M020_L_3ACF
M020_L_3A9E:
		mov	ES,word ptr DGROUP:M020_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0Eh
		jne	short M020_L_3AC3
		mov	AX,word ptr [BP+4]
		mov	word ptr [BP-2],AX
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		jmp	short M020_L_3ACF
M020_L_3AC3:
		mov	AX,word ptr [BP+6]
		mov	DX,word ptr [BP+4]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
M020_L_3ACF:
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_39DC	endp
CO059_TEXT	ends

CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT

BCC_TABLE_3ADD	label	word
		dw	020DCh
		dw	020DCh
		dw	020AEh
		dw	020AEh
		dw	020AEh
		dw	020AEh
		dw	020AEh
		dw	020AEh
		dw	020DCh
		dw	020DCh
		dw	020AEh
		dw	020AEh
		dw	02116h
		dw	02116h

CO059_TEXT	ends

		extrn	X058_01:far
		extrn	X073_00:far


CO059_TEXT	segment byte public 'CODE'
		assume	cs:CO059_TEXT,ds:DGROUP

M022_BCC_DATA_8186	equ	8186h

BCC_NEAR_3AF9	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		mov	SI,word ptr [BP+4]
		mov	word ptr [BP-4],0
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0Fh
		je	short M022_L_3B16
		jmp	short M022_L_3B93
M022_L_3B16:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		cmp	word ptr ES:[SI],13h
		je	short M022_L_3B28
		cmp	word ptr ES:[SI],14h
		je	short M022_L_3B28
		jmp	short M022_L_3B93
M022_L_3B28:
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0DE18h
		mov	word ptr [BP-0Ah],DX
		mov	word ptr [BP-0Ch],AX
		mov	ES,word ptr DGROUP:M022_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		mov	AX,1
		push	AX
		push	CS
		db	0E8h
		dw	0DE02h
		mov	word ptr [BP-6],DX
		mov	word ptr [BP-8],AX
		push	SI
		db	09Ah
		dw	X073_00
		dw	seg X073_00
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-8]
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,98h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-2],AX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-8]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
M022_L_3B93:
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_3AF9	endp
CO059_TEXT	ends

; END C203UNIT
		end

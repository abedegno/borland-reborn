; Direct-segment relocation references
		extrn	BCC_FAR_04CF:far
		extrn	BCC_SEG_180:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_0
; BEGIN C0 (complete source CODE_0:0000..02C9)
CODE0	segment byte public 'CODE'
		assume	cs:CODE0
; Original-image layout stub: not recovered source

		public	BCC_START
		public	__exit
		public	_abort

BCC_START	label	far
		db	0BAh
		dw	seg BCC_SEG_180
		db	08Eh,0C2h,08Bh,0FCh,026h,08Ch,01Eh,016h,000h,08Ch,0D3h; CODE_0:0000
		db	08Bh,0C7h,005h,00Fh,000h,0D1h,0E8h,0D1h,0E8h,0D1h,0E8h,0D1h,0E8h,003h	; CODE_0:000E
		db	0D8h,026h,083h,03Eh,016h,000h,007h,075h,039h,052h,0B8h,000h,0E8h,0B9h	; CODE_0:001C
		db	0FFh,0FFh,08Bh,0D1h,0CDh,021h,0B8h,000h,0E8h,0CDh,021h,026h,0A3h,004h	; CODE_0:002A
		db	000h,026h,0A3h,00Ch,000h,026h,0C6h,006h,01Ah,000h,008h,0B8h,002h,0E8h	; CODE_0:0038
		db	0B9h,0FFh,0FFh,08Bh,0D1h,0CDh,021h,0B8h,002h,0E8h,0CDh,021h,026h,0A3h	; CODE_0:0046
		db	01Bh,000h,026h,089h,01Eh,01Dh,000h,05Ah,0EBh,01Ch,026h,089h,01Eh,004h	; CODE_0:0054
		db	000h,026h,089h,01Eh,00Ch,000h,08Bh,0C3h,08Bh,00Eh,002h,000h,026h,089h	; CODE_0:0062
		db	00Eh,008h,000h,026h,089h,00Eh,010h,000h,02Bh,0C8h,026h,08Ch,01Eh,012h	; CODE_0:0070
		db	000h,08Bh,00Eh,02Ch,000h,026h,089h,00Eh,014h,000h,0B5h,000h,0BEh,081h	; CODE_0:007E
		db	000h,08Ah,00Eh,080h,000h,08Bh,0C1h,02Bh,0F9h,04Fh,083h,0E7h,0FEh,08Bh	; CODE_0:008C
		db	0E7h,016h,007h,0FCh,0F3h,0A4h,08Bh,0EFh,08Eh,0DAh,08Eh,0C2h,050h,033h	; CODE_0:009A
		db	0C0h,0B9h,04Eh,08Ch,0BFh,096h,05Ch,02Bh,0CFh,0F3h,0AAh,059h,0BBh,001h	; CODE_0:00A8
		db	000h,050h,050h,088h,046h,000h,0E3h,021h,04Dh,080h,07Eh,000h,020h,074h	; CODE_0:00B6
		db	00Ah,080h,07Eh,000h,009h,074h,004h,0B4h,001h,0EBh,00Eh,00Ah,0E4h,088h	; CODE_0:00C4
		db	046h,000h,074h,007h,045h,016h,055h,04Dh,043h,033h,0C0h,0E2h,0DFh,00Ah	; CODE_0:00D2
		db	0E4h,074h,003h,043h,016h,055h,016h,055h,053h,0B4h,030h,0CDh,021h,05Bh	; CODE_0:00E0
		db	03Ch,003h,072h,01Ah,058h,058h,08Eh,006h,014h,000h,033h,0C0h,08Bh,0F8h	; CODE_0:00EE
		db	08Bh,0C8h,049h,0F2h,0AEh,047h,026h,038h,045h,0FFh,075h,0F7h,047h,047h	; CODE_0:00FC
		db	006h,057h,08Bh,0C4h,016h,050h,053h,080h,03Eh,01Ah,000h,008h,075h,005h	; CODE_0:010A
		db	0B8h,050h,08Ch,0EBh,00Ah,08Ch,0D0h,08Ch,0DBh,02Bh,0C3h,0B1h,004h,0D3h	; CODE_0:0118
		db	0E0h,08Ch,0DBh,0FAh,08Eh,0D3h,003h,0E0h,0FBh,033h,0C0h,08Eh,0C3h,08Bh	; CODE_0:0126
		db	0CCh,0BFh,050h,08Ch,02Bh,0CFh,0F3h,0AAh,033h,0EDh,09Ah,03Ch,001h
		dw	seg BCC_FAR_04CF
		db	050h,050h,050h; CODE_0:0134
__exit	label	far
		db	08Bh,0ECh,08Ah,046h,004h,0B4h,04Ch,0CDh,021h,0FBh,053h,055h,08Bh,0ECh	; CODE_0:0146
		db	006h,08Bh,05Eh,004h,087h,05Eh,006h,087h,05Eh,008h,087h,05Eh,002h,089h	; CODE_0:0154
		db	05Eh,004h,0C4h,05Eh,006h,0FFh,046h,006h,026h,08Ah,01Fh,0B7h,000h,0D1h	; CODE_0:0162
		db	0E3h,0F7h,0DBh,02Eh,08Bh,09Fh,07Eh,002h,087h,05Eh,004h,007h,05Dh,09Dh	; CODE_0:0170
		db	0C3h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:017E
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:018C
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:019A
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01A8
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01B6
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01C4
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01D2
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01E0
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01EE
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:01FC
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:020A
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:0218
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:0226
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:0234
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:0242
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:0250
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:025E
		db	090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; CODE_0:026C
		db	090h,090h,090h,090h,090h,090h,0CBh,0CDh,040h,0CBh,052h,075h,06Eh,074h	; CODE_0:027A
		db	069h,06Dh,065h,020h,06Fh,076h,065h,072h,06Ch,061h,079h,020h,065h,072h	; CODE_0:0288
		db	072h,06Fh,072h,00Dh,00Ah	; CODE_0:0296
_abort	label	far
		db	0BBh
		dw	seg BCC_SEG_180
		db	08Eh,0DBh,0A3h,0C2h,006h,0BBh,002h,000h,053h,050h,0FFh; CODE_0:029B
		db	01Eh,0A8h,05Eh,0B9h,017h,000h,0BAh,084h,002h,00Eh,01Fh,0B4h,040h,0BBh	; CODE_0:02A9
		db	002h,000h,0CDh,021h,0B8h,004h,000h,050h,0B8h
		dw	seg BCC_SEG_180
		db	08Eh,0D8h,09Ah; CODE_0:02B7
		db	046h,001h
		dw	seg BCC_COPY_WORDS

CODE0	ends
; END C0
; BEGIN RDIV (listing CODE_0:02C9)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_02C9
		public	BCC_FAR_02CD
		public	BCC_FAR_02D2
		public	BCC_FAR_02D7

BCC_FAR_02C9	proc	far
		xor	CX,CX
		jmp	short M001_L_BODY
BCC_FAR_02C9	endp
BCC_FAR_02CD	proc	far
		mov	CX,1
		jmp	short M001_L_BODY
BCC_FAR_02CD	endp
BCC_FAR_02D2	proc	far
		mov	CX,2
		jmp	short M001_L_BODY
BCC_FAR_02D2	endp
BCC_FAR_02D7	proc	far
		mov	CX,3
M001_L_BODY:
		push	BP
		push	SI
		push	DI
		mov	BP,SP
		mov	DI,CX
		mov	AX,word ptr [BP+0Ah]
		mov	DX,word ptr [BP+0Ch]
		mov	BX,word ptr [BP+0Eh]
		mov	CX,word ptr [BP+10h]
		or	CX,CX
		jne	short M001_L_CHECK_SIGNS
		or	DX,DX
		je	short M001_L_SMALL_DIVIDE
		or	BX,BX
		je	short M001_L_SMALL_DIVIDE
M001_L_CHECK_SIGNS:
		test	DI,1
		jne	short M001_L_DIVIDE
		or	DX,DX
		jns	short M001_L_CHECK_DIVISOR
		neg	DX
		neg	AX
		sbb	DX,0
		or	DI,0Ch
M001_L_CHECK_DIVISOR:
		or	CX,CX
		jns	short M001_L_DIVIDE
		neg	CX
		neg	BX
		sbb	CX,0
		xor	DI,4
M001_L_DIVIDE:
		mov	BP,CX
		mov	CX,20h
		push	DI
		xor	DI,DI
		xor	SI,SI
M001_L_LOOP:
		shl	AX,1
		rcl	DX,1
		rcl	SI,1
		rcl	DI,1
		cmp	DI,BP
		jc	short M001_L_NEXT
		ja	short M001_L_SUBTRACT
		cmp	SI,BX
		jc	short M001_L_NEXT
M001_L_SUBTRACT:
		sub	SI,BX
		sbb	DI,BP
		inc	AX
M001_L_NEXT:
		loop	M001_L_LOOP
		pop	BX
		test	BX,2
		je	short M001_L_QUOTIENT
		mov	AX,SI
		mov	DX,DI
		shr	BX,1
M001_L_QUOTIENT:
		test	BX,4
		je	short M001_L_RETURN
		neg	DX
		neg	AX
		sbb	DX,0
M001_L_RETURN:
		pop	DI
		pop	SI
		pop	BP
		retf	8
M001_L_SMALL_DIVIDE:
		div	BX
		test	DI,2
		je	short M001_L_SMALL_QUOTIENT
		mov	AX,DX
M001_L_SMALL_QUOTIENT:
		xor	DX,DX
		jmp	short M001_L_RETURN
BCC_FAR_02D7	endp
CODE0	ends
; END RDIV
; BEGIN RLSHL (listing CODE_0:036C)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_036C
BCC_FAR_036C	proc	far
		cmp	CL,10h
		jnc	short M002_L_LARGE
		mov	BX,AX
		shl	AX,CL
		shl	DX,CL
		neg	CL
		add	CL,10h
		shr	BX,CL
		or	DX,BX
		retf
M002_L_LARGE:
		sub	CL,10h
		mov	DX,AX
		xor	AX,AX
		shl	DX,CL
		retf
BCC_FAR_036C	endp
CODE0	ends
; END RLSHL
; BEGIN RSHAR (listing CODE_0:038B)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_038B
BCC_FAR_038B	proc	far
		cmp	CL,10h
		jnc	short M003_L_LARGE
		mov	BX,DX
		shr	AX,CL
		sar	DX,CL
		neg	CL
		add	CL,10h
		shl	BX,CL
		or	AX,BX
		retf
M003_L_LARGE:
		sub	CL,10h
		mov	AX,DX
		cwd
		sar	AX,CL
		retf
BCC_FAR_038B	endp
CODE0	ends
; END RSHAR
; BEGIN RLMUL (listing CODE_0:03A9)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_03A9
BCC_FAR_03A9	proc	far
		push	SI
		xchg	AX,SI
		xchg	AX,DX
		test	AX,AX
		je	short M004_L_SKIP1
		mul	BX
M004_L_SKIP1:
		xchg	AX,CX
		test	AX,AX
		je	short M004_L_SKIP2
		mul	SI
		add	CX,AX
M004_L_SKIP2:
		xchg	AX,SI
		mul	BX
		add	DX,CX
		pop	SI
		retf
BCC_FAR_03A9	endp
CODE0	ends
; END RLMUL
; BEGIN RSTACK (listing CODE_0:03C2)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_03C2
		public	BCC_RTL_03C2
BCC_RTL_03C2	label	far
		public	BCC_RUNTIME_BUILD
BCC_RUNTIME_BUILD	label	far
		public	BCC_STRUCT_COPY
BCC_STRUCT_COPY	label	far
BCC_FAR_03C2	proc	far
		pop	BX
		pop	ES
		sub	SP,CX
		push	ES
		push	BX
		push	DI
		push	DS
		mov	DI,SP
		add	DI,8
		mov	BX,SS
		mov	ES,BX
		mov	DS,DX
		xchg	AX,SI
		cld
		shr	CX,1
		rep	movsw
		adc	CX,CX
		rep	movsb
		xchg	AX,SI
		pop	DS
		pop	DI
		retf
BCC_FAR_03C2	endp
CODE0	ends
; Original-target semantic aliases (zero bytes)
; END RSTACK
; BEGIN RLSHR (listing CODE_0:03E3)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_03E3
BCC_FAR_03E3	proc	far
		cmp	CL,10h
		jnc	short M006_L_LARGE
		mov	BX,DX
		shr	AX,CL
		shr	DX,CL
		neg	CL
		add	CL,10h
		shl	BX,CL
		or	AX,BX
		retf
M006_L_LARGE:
		sub	CL,10h
		mov	AX,DX
		xor	DX,DX
		shr	AX,CL
		retf
BCC_FAR_03E3	endp
CODE0	ends
; END RLSHR
; BEGIN RCOPY (listing CODE_0:0402)

CODE0	segment byte public 'CODE'
		assume	cs:CODE0,ds:DGROUP
		public	BCC_FAR_0402
		public	BCC_COPY_WORDS
BCC_COPY_WORDS	label	far
		public	BCC_RTL_0402
BCC_RTL_0402	label	far
		public	BCC_RUNTIME_COPY
BCC_RUNTIME_COPY	label	far
		public	BCC_STRUCT_COPY2
BCC_STRUCT_COPY2	label	far
BCC_FAR_0402	proc	far
		push	BP
		mov	BP,SP
		push	DS
		push	DI
		push	SI
		lds	SI,[BP+6]
		les	DI,[BP+0Ah]
		cld
		rep	movsb
		pop	SI
		pop	DI
		pop	DS
		pop	BP
		retf	8
BCC_FAR_0402	endp
CODE0	ends
; Original-target semantic aliases (zero bytes)
; END RCOPY
		end	BCC_START

	.286p
	locals

Y0DF90	segment para public 'CODE'
	assume	cs:Y0DF90
	db	10h dup (0)	;@0DF90
REFINE_KIND_10_OPERAND_STUB:	int	3Fh	;@0DFA0
	inc	bx	;@0DFA2
	add	byte ptr [bx+si], al	;@0DFA3
CODE_OP_FOR_NODE:	int	3Fh	;@0DFA5
	add	byte ptr [bx+si], al	;@0DFA7
	add	byte ptr [bx+si], al	;@0DFA9
	add	byte ptr [bx+si], al	;@0DFAB
	add	byte ptr [bx+si], al	;@0DFAD
	db	0, 0CDh	; add ch, cl	;@0DFAF
	aas	;@0DFB1
	add	byte ptr [bx+si], al	;@0DFB2
	shr	ah, 5	;@0DFB4
	db	0, 0F5h	; add ch, dh	;@0DFB7
	add	ax, 4Ch	;@0DFB9
	add	ax, 0	;@0DFBC
	add	byte ptr [bx+si], al	;@0DFBF
	add	byte ptr [bx+si], al	;@0DFC1
	add	byte ptr [bx+si], al	;@0DFC3
	add	byte ptr [bx+si], al	;@0DFC5
	add	byte ptr [bx+si], al	;@0DFC7
	add	byte ptr [bx+si], al	;@0DFC9
	add	byte ptr [bx+si], al	;@0DFCB
	add	byte ptr [bx+si], al	;@0DFCD
	db	0	; add ch, cl	;@0DFCF
Y0DF90	ends

Y0DFD0	segment para public 'CODE'
	assume	cs:Y0DFD0
GENERATE_BITFIELD_INC_DEC:	int	3Fh	;@0DFD0
	jo	@@1	;@0DFD2
	db	0, 0CDh	; add ch, cl	;@0DFD4
	aas	;@0DFD6
@@1:	adc	word ptr [bx+di], ax	;@0DFD7
	db	0, 0CDh	; add ch, cl	;@0DFD9
	aas	;@0DFDB
	rol	word ptr [di], 0	;@0DFDC
GENERATE_BITFIELD_OP_ASSIGN:	int	3Fh	;@0DFDF
	pop	cx	;@0DFE1
	add	ax, word ptr [bx+si]	;@0DFE2
	int	3Fh	;@0DFE4
	add	byte ptr [bx+si], al	;@0DFE6
	add	byte ptr [bx+si], al	;@0DFE8
	add	byte ptr [bx+si], al	;@0DFEA
	add	byte ptr [bx+si], al	;@0DFEC
	add	byte ptr [bx+si], al	;@0DFEE
	int	3Fh	;@0DFF0
	add	byte ptr [bx+si], al	;@0DFF2
	db	10h, 0F3h	; adc bl, dh	;@0DFF4
	add	ax, 9D00h	;@0DFF6
	push	es	;@0DFF9
	push	sp	;@0DFFA
	add	byte ptr [bx+di], al	;@0DFFB
	add	byte ptr [bx+si], al	;@0DFFD
	db	0	; add byte ptr [bx+si], al	;@0DFFF
Y0DFD0	ends

Y0E000	segment para public 'CODE'
	assume	cs:Y0E000
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0E000
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 10h, 0FAh
	db	5, 0, 57h, 10h, 4Ah, 1, 14h, 0, 0, 0
Y0E000	ends

Y0E030	segment para public 'CODE'
	assume	cs:Y0E030
	db	10h dup (0)	;@0E030
EMIT_CS_JMP_BX_DISP_ASM:	int	3Fh	;@0E040
	int	5	;@0E042
	db	0, 0CDh	; add ch, cl	;@0E044
	aas	;@0E046
	sub	al, 5	;@0E047
	db	0, 0CDh	; add ch, cl	;@0E049
	aas	;@0E04B
	cmp	byte ptr [bx+si], cl	;@0E04C
	db	0, 0CDh	; add ch, cl	;@0E04E
Y0E030	ends

Y0E050	segment para public 'CODE'
	assume	cs:Y0E050
	db	3Fh, 22h, 0Fh, 0	;@0E050
CREATE_ASM_OUTPUT_FAR:	int	3Fh	;@0E054
	add	ax, word ptr [bx+di]	;@0E056
	db	0, 0CDh	; add ch, cl	;@0E058
	aas	;@0E05A
	add	byte ptr [bx+si], al	;@0E05B
	db	0, 0CDh	; add ch, cl	;@0E05D
	aas	;@0E05F
	dec	ax	;@0E060
	str	bp	;@0E061
	aas	;@0E064
	fimul	dword ptr ds:[0CD00h]	;@0E065
	aas	;@0E069
	pop	bp	;@0E06A
	add	ax, word ptr [bx+si]	;@0E06B
	int	3Fh	;@0E06D
	out	6, al	;@0E06F
	db	0, 0CDh	; add ch, cl	;@0E071
	aas	;@0E073
	pop	cx	;@0E074
	add	byte ptr [bx+si], al	;@0E075
EMIT_DEBUG_B_DIRECTIVE:	int	3Fh	;@0E077
	dec	dx	;@0E079
	add	byte ptr [bx+si], al	;@0E07A
EMIT_SWITCH_JUMP_ASM:	int	3Fh	;@0E07C
	movsw	;@0E07E
	db	4	; add al, 0	;@0E07F
Y0E050	ends

Y0E080	segment para public 'CODE'
	assume	cs:Y0E080
	db	0	;@0E080
ADD_JUMP_ASM:	int	3Fh	;@0E081
	add	word ptr [bx+si], 0CD00h	;@0E083
	aas	;@0E087
	jb	@@1	;@0E088
@@1:	db	0, 0CDh	; add ch, cl	;@0E08A
	aas	;@0E08C
	in	ax, dx	;@0E08D
	add	al, 0	;@0E08E
EMIT_ASM_HEADER_FAR:	int	3Fh	;@0E090
	jo	@@1	;@0E092
	db	0, 0CDh	; add ch, cl	;@0E094
@@1:	aas	;@0E096
	add	al, byte ptr ds:[0CD00h]	;@0E097
	aas	;@0E09B
	xchg	ax, si	;@0E09C
	add	byte ptr [bx+si], al	;@0E09D
	int	3Fh	;@0E09F
	push	ds	;@0E0A1
	push	es	;@0E0A2
	add	byte ptr [bx+si], al	;@0E0A3
	add	byte ptr [bx+si], al	;@0E0A5
	add	byte ptr [bx+si], al	;@0E0A7
	add	byte ptr [bx+si], al	;@0E0A9
	add	byte ptr [bx+si], al	;@0E0AB
	add	byte ptr [bx+si], al	;@0E0AD
	db	0	; add ch, cl	;@0E0AF
Y0E080	ends

Y0E0B0	segment para public 'CODE'
	assume	cs:Y0E0B0
	db	0CDh, 3Fh, 0, 0, 0C0h, 0Bh, 6, 0, 3Eh, 6, 7Ch, 0, 0Dh, 0, 0, 0	;@0E0B0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
EMIT_PROC_ENDP:	int	3Fh	;@0E0D0
	inc	cx	;@0E0D2
	add	ax, word ptr [bx+si]	;@0E0D3
EMIT_SIGNED_DECIMAL:	int	3Fh	;@0E0D5
	jcxz	@@1+2	;@0E0D7
	db	0, 0CDh	; add ch, cl	;@0E0D9
	aas	;@0E0DB
@@1:	mov	cx, 1	;@0E0DC
EMIT_DB_DATA:	int	3Fh	;@0E0DF
	loop	@@1+1	;@0E0E1
@@1:	db	0, 0CDh	; add ch, cl	;@0E0E3
	aas	;@0E0E5
	or	byte ptr ds:[0CD00h], al	;@0E0E6
	aas	;@0E0EA
	dec	dx	;@0E0EB
	add	al, byte ptr [bx+si]	;@0E0EC
EMIT_PROC_BEGIN:	int	3Fh	;@0E0EE
Y0E0B0	ends

Y0E0F0	segment para public 'CODE'
	assume	cs:Y0E0F0
	db	0, 0, 0	;@0E0F0
EMIT_LOCAL_LABEL:	int	3Fh	;@0E0F3
	outsb	;@0E0F5
	add	al, 0	;@0E0F6
ADD_JUMP_18_NEXT_FRAGMENT:	int	3Fh	;@0E0F8
	mov	word ptr ds:[4], ax	;@0E0FA
	int	3Fh	;@0E0FD
	pop	ax	;@0E0FF
	add	ax, word ptr [bx+si]	;@0E100
	int	3Fh	;@0E102
	sub	ax, 1	;@0E104
	int	3Fh	;@0E107
	jcxz	@@1	;@0E109
	db	0, 0CDh	; add ch, cl	;@0E10B
	aas	;@0E10D
@@1:	retf	4	;@0E10E
	db	0Fh dup (0)	;@0E111
Y0E0F0	ends

Y0E120	segment para public 'CODE'
	assume	cs:Y0E120
	db	0CDh, 3Fh, 0, 0, 90h, 12h, 6, 0, 0C7h, 7, 62h, 0, 2, 0, 0, 0, 0	;@0E120
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
CHECK_EMIT_ARGUMENTS:	int	3Fh	;@0E140
	cmp	ax, 7	;@0E142
GENERATE_INTRINSIC_CALL_STUB:	int	3Fh	;@0E145
	db	0F2h, 0, 0	; add byte ptr [bx+si], al	;@0E147
	db	0, 0	; add byte ptr [bx+si], al	;@0E14A
	add	byte ptr [bx+si], al	;@0E14C
	add	byte ptr [bx+si], al	;@0E14E
	int	3Fh	;@0E150
	add	byte ptr [bx+si], al	;@0E152
	rcr	byte ptr [bp+si], 6	;@0E154
	db	0, 0C0h	; add al, al	;@0E157
	add	ch, byte ptr [bx+si]	;@0E159
	add	byte ptr ds:[0], al	;@0E15B
	add	byte ptr [bx+si], al	;@0E15F
	add	byte ptr [bx+si], al	;@0E161
	add	byte ptr [bx+si], al	;@0E163
	add	byte ptr [bx+si], al	;@0E165
	add	byte ptr [bx+si], al	;@0E167
	add	byte ptr [bx+si], al	;@0E169
	add	byte ptr [bx+si], al	;@0E16B
	add	byte ptr [bx+si], al	;@0E16D
	db	0, 0CDh	; add ch, cl	;@0E16F
	aas	;@0E171
	lock add	word ptr [bx+si], ax	;@0E172
ASM_COLON_LABEL_STUB:	int	3Fh	;@0E175
	pop	si	;@0E177
	add	word ptr [bx+si], ax	;@0E178
ASM_FLUSH_KIND2_STUB:	int	3Fh	;@0E17A
	out	1, ax	;@0E17C
	db	0, 0CDh	; add ch, cl	;@0E17E
	aas	;@0E180
	db	67h, 1, 0	; add word ptr [eax], ax	;@0E181
EMIT_ASM_FIXUP_OPERAND:	int	3Fh	;@0E184
	xchg	ax, dx	;@0E186
	add	word ptr [bx+si], ax	;@0E187
	int	3Fh	;@0E189
	add	byte ptr [bx+si], al	;@0E18B
	add	byte ptr [bx+si], al	;@0E18D
	add	byte ptr [bx+si], al	;@0E18F
	add	byte ptr [bx+si], al	;@0E191
	add	byte ptr [bx+si], al	;@0E193
	add	byte ptr [bx+si], al	;@0E195
	add	byte ptr [bx+si], al	;@0E197
	add	byte ptr [bx+si], al	;@0E199
	add	byte ptr [bx+si], al	;@0E19B
	add	byte ptr [bx+si], al	;@0E19D
	add	byte ptr [bx+si], al	;@0E19F
	add	byte ptr [bx+si], al	;@0E1A1
	add	byte ptr [bx+si], al	;@0E1A3
	add	byte ptr [bx+si], al	;@0E1A5
	add	byte ptr [bp+si-72h], ch	;@0E1A7
	add	byte ptr [bx+si], al	;@0E1AA
	add	byte ptr [bx+si], al	;@0E1AC
	add	byte ptr [bx+si], al	;@0E1AE
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

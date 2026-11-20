	.286p
	locals

Y0BFD0	segment para public 'CODE'
	assume	cs:Y0BFD0
TYPES_COMPATIBLE:	int	3Fh	;@0BFD0
	push	si	;@0BFD2
	add	word ptr [bx+si], ax	;@0BFD3
MAKE_POINTER_TYPE:	int	3Fh	;@0BFD5
	add	byte ptr [bx+si], al	;@0BFD7
	db	0, 0CDh	; add ch, cl	;@0BFD9
	aas	;@0BFDB
	inc	di	;@0BFDC
	add	ax, 0CD00h	;@0BFDD
	aas	;@0BFE0
	jo	@@1+1	;@0BFE1
	add	byte ptr [bx+si], al	;@0BFE3
	add	byte ptr [bx+si], al	;@0BFE5
@@1:	add	byte ptr [bx+si], al	;@0BFE7
	add	byte ptr [bx+si], al	;@0BFE9
	add	byte ptr [bx+si], al	;@0BFEB
	add	byte ptr [bx+si], al	;@0BFED
	db	0, 0CDh	; add ch, cl	;@0BFEF
	aas	;@0BFF1
	add	byte ptr [bx+si], al	;@0BFF2
	nop	;@0BFF4
	jmp	short @@2	;@0BFF5
@@2:	add	byte ptr [bx+8], dh	;@0BFF7
	aam	0	;@0BFFA
	add	ax, word ptr [bx+si]	;@0BFFC
	add	byte ptr [bx+si], al	;@0BFFE
	add	byte ptr [bx+si], al	;@0C000
	add	byte ptr [bx+si], al	;@0C002
	add	byte ptr [bx+si], al	;@0C004
	add	byte ptr [bx+si], al	;@0C006
	add	byte ptr [bx+si], al	;@0C008
	add	byte ptr [bx+si], al	;@0C00A
	add	byte ptr [bx+si], al	;@0C00C
	add	byte ptr [bx+si], al	;@0C00E
PARSE_MEMBER_INITIALIZERS:	int	3Fh	;@0C010
	or	ax, word ptr [bp+di]	;@0C012
	db	0, 0CDh	; add ch, cl	;@0C014
	aas	;@0C016
	loopne	@@2+1	;@0C017
@@1:	db	0, 0CDh	; add ch, cl	;@0C019
	aas	;@0C01B
@@2:	db	64h, 7	; pop es	;@0C01C
	db	0, 0	; add byte ptr [bx+si], al	;@0C01E
	int	3Fh	;@0C020
	add	byte ptr [bx+si], al	;@0C022
	loopne	@@1+1	;@0C024
	add	byte ptr [bx+si], al	;@0C026
	db	0C7h, 0Ch, 72h, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0C028
	db	0, 0, 0, 0, 0
Y0BFD0	ends

Y0C040	segment para public 'CODE'
	assume	cs:Y0C040
DECLARE_IMPLICIT_MEMBERS:	int	3Fh	;@0C040
	and	word ptr [bx+si], cx	;@0C042
	add	byte ptr [bx+si], al	;@0C044
	add	byte ptr [bx+si], al	;@0C046
	add	byte ptr [bx+si], al	;@0C048
	add	byte ptr [bx+si], al	;@0C04A
	add	byte ptr [bx+si], al	;@0C04C
	add	byte ptr [bx+si], al	;@0C04E
	int	3Fh	;@0C050
	add	byte ptr [bx+si], al	;@0C052
	and	byte ptr [bp+si], al	;@0C054
	add	word ptr [bx+si], ax	;@0C056
	lock adc	byte ptr [bp+200h], dh	;@0C058
	add	byte ptr [bx+si], al	;@0C05D
	add	byte ptr [bx+si], al	;@0C05F
	add	byte ptr [bx+si], al	;@0C061
	add	byte ptr [bx+si], al	;@0C063
	add	byte ptr [bx+si], al	;@0C065
	add	byte ptr [bx+si], al	;@0C067
	add	byte ptr [bx+si], al	;@0C069
	add	byte ptr [bx+si], al	;@0C06B
	add	byte ptr [bx+si], al	;@0C06D
	db	0, 0CDh	; add ch, cl	;@0C06F
	aas	;@0C071
	fld	qword ptr [bp+si]	;@0C072
	db	0, 0CDh	; add ch, cl	;@0C074
	aas	;@0C076
	db	72h, 10h	; jb L0C089	;@0C077
	add	byte ptr [bx+si], al	;@0C079
	add	byte ptr [bx+si], al	;@0C07B
	add	byte ptr [bx+si], al	;@0C07D
	db	0	; add ch, cl	;@0C07F
Y0C040	ends

Y0C080	segment para public 'CODE'
	assume	cs:Y0C080
	db	0CDh, 3Fh, 0, 0, 0D0h, 13h, 1, 0, 19h	;@0C080
L0C089:	or	al, 0Ch	;@0C089
	add	byte ptr [di], al	;@0C08B
	add	byte ptr [bx+si], al	;@0C08D
	add	byte ptr [bx+si], al	;@0C08F
	add	byte ptr [bx+si], al	;@0C091
	add	byte ptr [bx+si], al	;@0C093
	add	byte ptr [bx+si], al	;@0C095
	add	byte ptr [bx+si], al	;@0C097
	add	byte ptr [bx+si], al	;@0C099
	add	byte ptr [bx+si], al	;@0C09B
	add	byte ptr [bx+si], al	;@0C09D
	db	0, 0CDh	; add ch, cl	;@0C09F
	aas	;@0C0A1
	xchg	ax, bp	;@0C0A2
	or	ax, word ptr [bx+si]	;@0C0A3
APPEND_DECIMAL:	int	3Fh	;@0C0A5
	mov	al, byte ptr ds:[0]	;@0C0A7
MANGLE_SYMBOL_NAME:	int	3Fh	;@0C0AA
	imul	cx, word ptr [bp+di], 0CD00h	;@0C0AC
Y0C080	ends

Y0C0B0	segment para public 'CODE'
	assume	cs:Y0C0B0
	db	3Fh, 0DAh, 8, 0	;@0C0B0
MANGLE_PLAIN_NAME:	int	3Fh	;@0C0B4
	mov	si, 1	;@0C0B6
	add	byte ptr [bx+si], al	;@0C0B9
	add	byte ptr [bx+si], al	;@0C0BB
	add	byte ptr [bx+si], al	;@0C0BD
	db	0, 0CDh	; add ch, cl	;@0C0BF
	aas	;@0C0C1
	add	byte ptr [bx+si], al	;@0C0C2
	add	byte ptr [bx+si], ah	;@0C0C4
	add	word ptr [bx+si], ax	;@0C0C6
	push	cx	;@0C0C8
	and	word ptr [si+2B01h], sp	;@0C0C9
	add	byte ptr [bx+si], al	;@0C0CD
	add	byte ptr [bx+si], al	;@0C0CF
	add	byte ptr [bx+si], al	;@0C0D1
	add	byte ptr [bx+si], al	;@0C0D3
	add	byte ptr [bx+si], al	;@0C0D5
	add	byte ptr [bx+si], al	;@0C0D7
	add	byte ptr [bx+si], al	;@0C0D9
	add	byte ptr [bx+si], al	;@0C0DB
	add	byte ptr [bx+si], al	;@0C0DD
	db	0, 0CDh	; add ch, cl	;@0C0DF
	aas	;@0C0E1
	mov	cl, 0Bh	;@0C0E2
	db	0, 0CDh	; add ch, cl	;@0C0E4
	aas	;@0C0E6
	dec	cx	;@0C0E7
	add	al, byte ptr [bx+si]	;@0C0E8
COPY_PARAM_QUALIFIERS:	int	3Fh	;@0C0EA
	db	71h, 12h	; jno L0C100	;@0C0EC
	db	0, 0CDh	; add ch, cl	;@0C0EE
Y0C0B0	ends

Y0C0F0	segment para public 'CODE'
	assume	cs:Y0C0F0
	db	3Fh, 0B1h, 19h, 0	;@0C0F0
BUILD_DESTRUCTOR_BODY:	int	3Fh	;@0C0F4
	pop	dx	;@0C0F6
	or	word ptr [bx+si], ax	;@0C0F7
ALLOC_INIT_ENTRY:	int	3Fh	;@0C0F9
	push	ds	;@0C0FB
	sbb	word ptr [bx+si], ax	;@0C0FC
FIND_COPY_CTOR:	int	3Fh	;@0C0FE
L0C100:	inc	bp	;@0C100
	adc	al, byte ptr [bx+si]	;@0C101
BUILD_VBASE_INITS:	int	3Fh	;@0C103
	pop	dx	;@0C105
	sbb	al, 0	;@0C106
SAME_SIGNATURE:	int	3Fh	;@0C108
	scasw	;@0C10A
	adc	al, 0	;@0C10B
DESTRUCTOR_CALL_FLAGS:	int	3Fh	;@0C10D
	cwd	;@0C10F
	pop	es	;@0C110
	db	0, 0CDh	; add ch, cl	;@0C111
	aas	;@0C113
	insw	;@0C114
	add	byte ptr [bx+si], al	;@0C115
BUILD_DESTRUCTOR_CALL:	int	3Fh	;@0C117
	adc	al, byte ptr [bp+di]	;@0C119
	db	0, 0CDh	; add ch, cl	;@0C11B
	aas	;@0C11D
	int	0Ch	;@0C11E
Y0C0F0	ends

Y0C120	segment para public 'CODE'
	assume	cs:Y0C120
	db	0	;@0C120
BUILD_TEMP_DESTRUCTORS:	int	3Fh	;@0C121
	sbb	al, byte ptr [bx]	;@0C123
	db	0, 0CDh	; add ch, cl	;@0C125
	aas	;@0C127
	test	byte ptr [bx+si], dl	;@0C128
	db	0, 0CDh	; add ch, cl	;@0C12A
	aas	;@0C12C
	db	0D6h	; salc	;@0C12D
	or	byte ptr [bx+si], al	;@0C12E
FIND_COPY_ASSIGN:	int	3Fh	;@0C130
	pop	bx	;@0C132
	adc	al, byte ptr [bx+si]	;@0C133
COPY_MEMBER_RECORD:	int	3Fh	;@0C135
	sbb	byte ptr [si], cl	;@0C137
	db	0, 0CDh	; add ch, cl	;@0C139
	aas	;@0C13B
	xchg	ax, dx	;@0C13C
	or	byte ptr [bx+si], al	;@0C13D
LIST_CONTAINS_VALUE:	int	3Fh	;@0C13F
	sub	ax, 0	;@0C141
REGISTER_TEMP_DESTRUCTOR:	int	3Fh	;@0C144
	dec	di	;@0C146
	push	es	;@0C147
	db	0, 0CDh	; add ch, cl	;@0C148
	aas	;@0C14A
	push	ss	;@0C14B
	adc	al, 0	;@0C14C
ADD_THIS_PARAMETER:	int	3Fh	;@0C14E
Y0C120	ends

Y0C150	segment para public 'CODE'
	assume	cs:Y0C150
	db	0CAh, 13h, 0	;@0C150
BUILD_THIS_ALLOCATION:	int	3Fh	;@0C153
	db	0F3h, 7	; pop es	;@0C155
	db	0, 0CDh	; add ch, cl	;@0C157
	aas	;@0C159
	db	68h, 0Ch, 0	; push 0Ch	;@0C15A
FIND_DEFAULT_CTOR:	db	0CDh, 3Fh	; int 3Fh	;@0C15D
	in	al, dx	;@0C15F
	adc	byte ptr [bx+si], al	;@0C160
IS_BASE_CLASS:	int	3Fh	;@0C162
	sub	ax, 0Fh	;@0C164
IS_UNIQUE_NONVIRTUAL_BASE:	int	3Fh	;@0C167
	adc	dx, word ptr [bx+si]	;@0C169
	db	0, 0CDh	; add ch, cl	;@0C16B
	aas	;@0C16D
	push	ss	;@0C16E
	or	ax, 0CD00h	;@0C16F
	aas	;@0C172
	add	byte ptr [bx+si], al	;@0C173
	db	0, 0CDh	; add ch, cl	;@0C175
	aas	;@0C177
	rol	byte ptr [bx+di], 1	;@0C178
	db	0, 0CDh	; add ch, cl	;@0C17A
	aas	;@0C17C
	xor	cx, word ptr [bp+di]	;@0C17D
	db	0	; add ch, cl	;@0C17F
Y0C150	ends

Y0C180	segment para public 'CODE'
	assume	cs:Y0C180
BUILD_INIT_CALL:	int	3Fh	;@0C180
	jp	@@1	;@0C182
	db	0, 0CDh	; add ch, cl	;@0C184
	aas	;@0C186
	mov	byte ptr [bx], dl	;@0C187
	db	0, 0CDh	; add ch, cl	;@0C189
	aas	;@0C18B
	adc	word ptr [bx], dx	;@0C18C
	db	0, 0CDh	; add ch, cl	;@0C18E
	aas	;@0C190
@@1:	sti	;@0C191
	adc	al, byte ptr [bx+si]	;@0C192
ADD_HIDDEN_PARAMETER:	int	3Fh	;@0C194
	std	;@0C196
	and	byte ptr [bx+si], al	;@0C197
ADD_UNIQUE_PARAM:	int	3Fh	;@0C199
	bound	sp, dword ptr [bx+si]	;@0C19B
	db	0, 0CDh	; add ch, cl	;@0C19D
	aas	;@0C19F
	db	0E9h, 20h, 0	; jmp near ptr L0C1C3	;@0C1A0
CANNOT_CONVERT_TYPES:	int	3Fh	;@0C1A3
	dec	sp	;@0C1A5
	add	word ptr [bx+si], ax	;@0C1A6
ALLOC_TEMP_ENTRY:	int	3Fh	;@0C1A8
	and	word ptr ds:[0CD00h], ax	;@0C1AA
	aas	;@0C1AE
	push	cx	;@0C1AF
	pop	ds	;@0C1B0
	db	0, 0CDh	; add ch, cl	;@0C1B1
	aas	;@0C1B3
	cmp	ax, word ptr ds:[0]	;@0C1B4
	add	byte ptr [bx+si], al	;@0C1B8
	add	byte ptr [bx+si], al	;@0C1BA
	add	byte ptr [bx+si], al	;@0C1BC
	add	byte ptr [bx+si], al	;@0C1BE
Y0C180	ends

Y0C1C0	segment para public 'CODE'
	assume	cs:Y0C1C0
	db	0CDh, 3Fh, 0	;@0C1C0
L0C1C3:	add	byte ptr [bx+si], dl	;@0C1C3
	inc	bx	;@0C1C5
	add	word ptr [bx+si], ax	;@0C1C6
	sahf	;@0C1C8
	pop	ds	;@0C1C9
	jb	@@1+1	;@0C1CA
@@1:	or	byte ptr [bx+si], al	;@0C1CC
	add	byte ptr [bx+si], al	;@0C1CE
	add	byte ptr [bx+si], al	;@0C1D0
	add	byte ptr [bx+si], al	;@0C1D2
	add	byte ptr [bx+si], al	;@0C1D4
	add	byte ptr [bx+si], al	;@0C1D6
	add	byte ptr [bx+si], al	;@0C1D8
	add	byte ptr [bx+si], al	;@0C1DA
	add	byte ptr [bx+si], al	;@0C1DC
	add	byte ptr [bx+si], al	;@0C1DE
PARSE_FUNCTION_DECLARATOR:	int	3Fh	;@0C1E0
	pop	sp	;@0C1E2
	or	byte ptr [bx+si], al	;@0C1E3
PARSE_POINTER_DECLARATOR:	int	3Fh	;@0C1E5
	into	;@0C1E7
	add	al, 0	;@0C1E8
STRIP_CV_QUALIFIERS:	int	3Fh	;@0C1EA
	hlt	;@0C1EC
	sbb	byte ptr [bx+si], al	;@0C1ED
NEW_RECORD_TYPE:	int	3Fh	;@0C1EF
	push	bp	;@0C1F1
	adc	al, byte ptr [bx+si]	;@0C1F2
PARSE_DECL_SPECIFIERS:	int	3Fh	;@0C1F4
	db	67h, 1Dh, 0, 0CDh	; sbb ax, 0CD00h	;@0C1F6
	db	3Fh	; aas	;@0C1FA
	push	bx	;@0C1FB
	sbb	byte ptr [bx+si], al	;@0C1FC
PARSE_DECLARATOR:	int	3Fh	;@0C1FE
	dec	cx	;@0C200
	push	cs	;@0C201
	db	0, 0CDh	; add ch, cl	;@0C202
	aas	;@0C204
	call	@@1	;@0C205
	add	byte ptr [bx+si], al	;@0C208
	add	byte ptr [bx+si], al	;@0C20A
	add	byte ptr [bx+si], al	;@0C20C
	add	byte ptr [bx+si], al	;@0C20E
	int	3Fh	;@0C210
	add	byte ptr [bx+si], al	;@0C212
@@1:	xor	byte ptr [si+1], ah	;@0C214
	add	byte ptr [si+2003h], dl	;@0C217
	add	byte ptr [di], al	;@0C21B
	add	byte ptr [bx+si], al	;@0C21D
	add	byte ptr [bx+si], al	;@0C21F
	add	byte ptr [bx+si], al	;@0C221
	add	byte ptr [bx+si], al	;@0C223
	add	byte ptr [bx+si], al	;@0C225
	add	byte ptr [bx+si], al	;@0C227
	add	byte ptr [bx+si], al	;@0C229
	add	byte ptr [bx+si], al	;@0C22B
	add	byte ptr [bx+si], al	;@0C22D
	db	0, 0CDh	; add ch, cl	;@0C22F
	aas	;@0C231
	cli	;@0C232
	add	byte ptr [bx+si], al	;@0C233
EMIT_HUGE_DATA:	int	3Fh	;@0C235
	inc	ax	;@0C237
	add	word ptr [bx+si], ax	;@0C238
NEXT_DATA_BANK:	int	3Fh	;@0C23A
	into	;@0C23C
	add	al, byte ptr [bx+si]	;@0C23D
EMIT_DATA_SPANS:	int	3Fh	;@0C23F
	add	al, 3	;@0C241
	db	0, 0CDh	; add ch, cl	;@0C243
	aas	;@0C245
	xor	al, 2	;@0C246
	add	byte ptr [bx+si], al	;@0C248
	add	byte ptr [bx+si], al	;@0C24A
	add	byte ptr [bx+si], al	;@0C24C
	add	byte ptr [bx+si], al	;@0C24E
	int	3Fh	;@0C250
	add	byte ptr [bx+si], al	;@0C252
	db	0F0h, 67h, 1, 0	; lock add word ptr [eax], ax	;@0C254
	mov	cl, 15h	;@0C258
	nop	;@0C25A
	add	word ptr [bx+si], cx	;@0C25B
	add	byte ptr [bx+si], al	;@0C25D
	add	byte ptr [bx+si], al	;@0C25F
	add	byte ptr [bx+si], al	;@0C261
	add	byte ptr [bx+si], al	;@0C263
	add	byte ptr [bx+si], al	;@0C265
	add	byte ptr [bx+si], al	;@0C267
	add	byte ptr [bx+si], al	;@0C269
	add	byte ptr [bx+si], al	;@0C26B
	add	byte ptr [bx+si], al	;@0C26D
	db	0, 0CDh	; add ch, cl	;@0C26F
	aas	;@0C271
	mov	ah, 7	;@0C272
	db	0, 0CDh	; add ch, cl	;@0C274
	aas	;@0C276
	or	ax, word ptr [bp+di]	;@0C277
	db	0, 0CDh	; add ch, cl	;@0C279
	aas	;@0C27B
	arpl	word ptr [bx+si], dx	;@0C27C
	db	0, 0CDh	; add ch, cl	;@0C27E
	aas	;@0C280
	cmc	;@0C281
	push	cs	;@0C282
	db	0, 0CDh	; add ch, cl	;@0C283
	aas	;@0C285
	xchg	word ptr [bp+di], ax	;@0C286
	db	0, 0CDh	; add ch, cl	;@0C288
	aas	;@0C28A
	add	ax, word ptr ds:[0CD00h]	;@0C28B
	aas	;@0C28F
	adc	byte ptr [di], 0	;@0C290
RESOLVE_OVERLOADED_CALL:	int	3Fh	;@0C293
	rol	word ptr [bx+di], 1	;@0C295
	add	byte ptr [bx+si], al	;@0C297
	add	byte ptr [bx+si], al	;@0C299
	add	byte ptr [bx+si], al	;@0C29B
	add	byte ptr [bx+si], al	;@0C29D
	db	0, 0CDh	; add ch, cl	;@0C29F
	aas	;@0C2A1
	add	byte ptr [bx+si], al	;@0C2A2
	inc	ax	;@0C2A4
	jg	@@1+1	;@0C2A5
@@1:	db	0, 0CEh	; add dh, cl	;@0C2A7
	or	word ptr [bp+400h], di	;@0C2A9
	add	byte ptr [bx+si], al	;@0C2AD
	add	byte ptr [bx+si], al	;@0C2AF
	add	byte ptr [bx+si], al	;@0C2B1
	add	byte ptr [bx+si], al	;@0C2B3
	add	byte ptr [bx+si], al	;@0C2B5
	add	byte ptr [bx+si], al	;@0C2B7
	add	byte ptr [bx+si], al	;@0C2B9
	add	byte ptr [bx+si], al	;@0C2BB
	add	byte ptr [bx+si], al	;@0C2BD
	db	0	; add ch, cl	;@0C2BF
Y0C1C0	ends

Y0C2C0	segment para public 'CODE'
	assume	cs:Y0C2C0
PARSE_NEW_EXPRESSION:	int	3Fh	;@0C2C0
	mov	sp, 8	;@0C2C2
PARSE_TYPE_CONSTRUCTOR_CALL:	int	3Fh	;@0C2C5
	out	7, al	;@0C2C7
	db	0, 0CDh	; add ch, cl	;@0C2C9
	aas	;@0C2CB
	mov	ax, word ptr ds:[2]	;@0C2CC
	int	3Fh	;@0C2CF
	add	byte ptr [bx+si], al	;@0C2D1
	add	byte ptr [bx+si], al	;@0C2D3
	add	byte ptr [bx+si], al	;@0C2D5
	add	byte ptr [bx+si], al	;@0C2D7
	add	byte ptr [bx+si], al	;@0C2D9
	add	byte ptr [bx+si], al	;@0C2DB
	add	byte ptr [bx+si], al	;@0C2DD
	db	0, 0CDh	; add ch, cl	;@0C2DF
	aas	;@0C2E1
	add	byte ptr [bx+si], al	;@0C2E2
	db	0D0h, 89h, 1, 0	; ror byte ptr [bx+di+1], 1	;@0C2E4
	db	0A7h	; cmpsw	;@0C2E8
	or	word ptr [si+500h], bx	;@0C2E9
	add	byte ptr [bx+si], al	;@0C2ED
	add	byte ptr [bx+si], al	;@0C2EF
	add	byte ptr [bx+si], al	;@0C2F1
	add	byte ptr [bx+si], al	;@0C2F3
	add	byte ptr [bx+si], al	;@0C2F5
	add	byte ptr [bx+si], al	;@0C2F7
	add	byte ptr [bx+si], al	;@0C2F9
	add	byte ptr [bx+si], al	;@0C2FB
	add	byte ptr [bx+si], al	;@0C2FD
	db	0, 0CDh	; add ch, cl	;@0C2FF
	aas	;@0C301
	lar	ax, word ptr [bx+si]	;@0C302
CONVERT_CLASS_TO_INTEGRAL:	int	3Fh	;@0C305
	inc	word ptr [bx]	;@0C307
	db	0, 0CDh	; add ch, cl	;@0C309
	aas	;@0C30B
	dec	si	;@0C30C
	or	byte ptr [bx+si], al	;@0C30D
CAST_EXPRESSION:	db	0CDh	; int 3Fh	;@0C30F
Y0C2C0	ends

Y0C310	segment para public 'CODE'
	assume	cs:Y0C310
	db	3Fh, 3Fh, 2, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh	;@0C310
	db	3Fh, 0, 0, 20h, 94h, 1, 0, 0BBh, 1Dh, 52h, 2, 8, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
CHECK_CPP_ASSIGNMENT:	int	3Fh	;@0C340
	add	byte ptr [bx+si], al	;@0C342
	db	0, 0CDh	; add ch, cl	;@0C344
	aas	;@0C346
	lahf	;@0C347
	push	ss	;@0C348
	db	0, 0CDh	; add ch, cl	;@0C349
	aas	;@0C34B
	sbb	ax, word ptr es:[bx+si]	;@0C34C
COMPARE_MEMBER_POINTERS:	db	0CDh	; int 3Fh	;@0C34F
Y0C310	ends

Y0C350	segment para public 'CODE'
	assume	cs:Y0C350
	db	3Fh, 81h, 13h, 0	;@0C350
CHECK_CPP_INITIALIZATION:	int	3Fh	;@0C354
	jle	@@1	;@0C356
	db	0, 0CDh	; add ch, cl	;@0C358
@@1:	aas	;@0C35A
	sbb	byte ptr [di], cl	;@0C35B
	db	0, 0CDh	; add ch, cl	;@0C35D
	aas	;@0C35F
	movsb	;@0C360
	pop	es	;@0C361
	db	0, 0CDh	; add ch, cl	;@0C362
	aas	;@0C364
	xor	dx, word ptr [bx+di]	;@0C365
	add	byte ptr [bx+si], al	;@0C367
	add	byte ptr [bx+si], al	;@0C369
	add	byte ptr [bx+si], al	;@0C36B
	add	byte ptr [bx+si], al	;@0C36D
	db	0, 0CDh	; add ch, cl	;@0C36F
	aas	;@0C371
	add	byte ptr [bx+si], al	;@0C372
	db	30h, 0B4h, 1, 0	; xor byte ptr [si+1], dh	;@0C374
	db	8Eh, 2	; mov es, word ptr [bp+si]	;@0C378
	and	al, byte ptr [bx+si]	;@0C37A
	add	word ptr [bx+si], ax	;@0C37C
	add	byte ptr [bx+si], al	;@0C37E
	add	byte ptr [bx+si], al	;@0C380
	add	byte ptr [bx+si], al	;@0C382
	add	byte ptr [bx+si], al	;@0C384
	add	byte ptr [bx+si], al	;@0C386
	add	byte ptr [bx+si], al	;@0C388
	add	byte ptr [bx+si], al	;@0C38A
	add	byte ptr [bx+si], al	;@0C38C
	add	byte ptr [bx+si], al	;@0C38E
CHECK_FILE_SYMBOLS:	int	3Fh	;@0C390
	xchg	byte ptr [bp+si], al	;@0C392
	add	byte ptr [bx+si], al	;@0C394
	add	byte ptr [bx+si], al	;@0C396
	add	byte ptr [bx+si], al	;@0C398
	add	byte ptr [bx+si], al	;@0C39A
	add	byte ptr [bx+si], al	;@0C39C
	add	byte ptr [bx+si], al	;@0C39E
Y0C350	ends
	end

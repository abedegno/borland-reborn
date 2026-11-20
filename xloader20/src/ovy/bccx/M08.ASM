	.286p
	locals
	extrn	L0CEC5:far
	extrn	L181A0:byte

Y0CA10	segment para public 'CODE'
	assume	cs:Y0CA10
	db	0, 0, 0	;@0CA10
ALLOC_SCOPE:	int	3Fh	;@0CA13
	db	0F7h, 9, 0, 0CDh	; test word ptr [bx+di], 0CD00h	;@0CA15
	aas	;@0CA19
	xchg	ax, di	;@0CA1A
	add	ax, word ptr [bx+si]	;@0CA1B
BCC_TYPE_CREATE:	int	3Fh	;@0CA1D
	pushf	;@0CA1F
	add	al, 0	;@0CA20
PUSH_SCOPE:	int	3Fh	;@0CA22
	pop	ax	;@0CA24
	or	al, byte ptr [bx+si]	;@0CA25
C56_NAME_FLAGS:	int	3Fh	;@0CA27
	xor	dx, word ptr [bx+si]	;@0CA29
	db	0, 0CDh	; add ch, cl	;@0CA2B
	aas	;@0CA2D
	xor	ax, 0	;@0CA2E
C0FIND:	int	3Fh	;@0CA31
	sbb	byte ptr ds:[0CD00h], al	;@0CA33
	aas	;@0CA37
	xchg	word ptr [di], cx	;@0CA38
	db	0, 0CDh	; add ch, cl	;@0CA3A
	aas	;@0CA3C
	mov	cx, 0Fh	;@0CA3D
CLEAR_PREPARED_FLAGS:	int	3Fh	;@0CA40
	loop	L0CA51+2	;@0CA42
	db	0, 0CDh	; add ch, cl	;@0CA44
	aas	;@0CA46
	mov	byte ptr [bp+si], cl	;@0CA47
	db	0, 0CDh	; add ch, cl	;@0CA49
	aas	;@0CA4B
	pop	si	;@0CA4C
	add	al, byte ptr [bx+si]	;@0CA4D
FIND_NAME_IN_LIST:	int	3Fh	;@0CA4F
L0CA51:	bound	ax, dword ptr ds:[0CD00h]	;@0CA51
	aas	;@0CA55
	mov	cx, word ptr [bx]	;@0CA56
	db	0, 0CDh	; add ch, cl	;@0CA58
	aas	;@0CA5A
	bound	cx, dword ptr [bx]	;@0CA5B
	db	0, 0CDh	; add ch, cl	;@0CA5D
	aas	;@0CA5F
	mov	ch, 8	;@0CA60
	db	0, 0CDh	; add ch, cl	;@0CA62
	aas	;@0CA64
	dec	di	;@0CA65
	pop	es	;@0CA66
	db	0, 0CDh	; add ch, cl	;@0CA67
	aas	;@0CA69
	db	36h, 5, 0, 0CDh	; add ax, 0CD00h	;@0CA6A
	db	3Fh	; aas	;@0CA6E
	db	64h, 9, 0	; or word ptr [bx+si], ax	;@0CA6F
CACHE_MEMBER_LOOKUP:	db	0CDh, 3Fh	; int 3Fh	;@0CA72
	db	9Ah, 7, 0, 0CDh, 3Fh	; lcall 0x3fcd, 7	;@0CA74
	in	al, dx	;@0CA79
	add	ax, word ptr [bx+si]	;@0CA7A
DECLARE_MEMBER_ALIAS:	int	3Fh	;@0CA7C
	int	5	;@0CA7E
	db	0, 0CDh	; add ch, cl	;@0CA80
	aas	;@0CA82
	scasb	;@0CA83
	push	es	;@0CA84
	db	0, 0CDh	; add ch, cl	;@0CA85
	aas	;@0CA87
	inc	si	;@0CA88
	add	al, 0	;@0CA89
FIND_EQUIVALENT_TYPE:	int	3Fh	;@0CA8B
	jp	@@1	;@0CA8D
@@1:	db	0	; add ch, cl	;@0CA8F
Y0CA10	ends

Y0CA90	segment para public 'CODE'
	assume	cs:Y0CA90
INTERN_QUALIFIED_TYPE:	int	3Fh	;@0CA90
	pop	ss	;@0CA92
	add	word ptr [bx+si], ax	;@0CA93
FIND_MEMBER_BY_NAME:	int	3Fh	;@0CA95
	loope	@@1	;@0CA97
	db	0, 0CDh	; add ch, cl	;@0CA99
	aas	;@0CA9B
	adc	ax, word ptr [bx]	;@0CA9C
	db	0, 0CDh	; add ch, cl	;@0CA9E
@@1:	aas	;@0CAA0
	dec	bp	;@0CAA1
	adc	byte ptr [bx+si], al	;@0CAA2
C0MARK:	int	3Fh	;@0CAA4
	mov	cx, 10h	;@0CAA6
LIST_CELL_FREE:	int	3Fh	;@0CAA9
	jns	@@1	;@0CAAB
	db	0, 0CDh	; add ch, cl	;@0CAAD
	aas	;@0CAAF
	in	ax, dx	;@0CAB0
	adc	byte ptr [bx+si], al	;@0CAB1
	add	byte ptr [bx+si], al	;@0CAB3
	add	byte ptr [bx+si], al	;@0CAB5
	add	byte ptr [bx+si], al	;@0CAB7
	add	byte ptr [bx+si], al	;@0CAB9
	add	byte ptr [bx+si], al	;@0CABB
@@1:	add	byte ptr [bx+si], al	;@0CABD
	db	0, 0CDh	; add ch, cl	;@0CABF
	aas	;@0CAC1
	add	byte ptr [bx+si], al	;@0CAC2
	inc	ax	;@0CAC4
	lodsb	;@0CAC5
	add	al, byte ptr [bx+si]	;@0CAC6
	push	ss	;@0CAC8
	add	word ptr [bx+si], dx	;@0CAC9
	add	byte ptr [bp+di], al	;@0CACB
	add	byte ptr [bx+si], al	;@0CACD
	db	0	; add byte ptr [bx+si], al	;@0CACF
Y0CA90	ends

Y0CAD0	segment para public 'CODE'
	assume	cs:Y0CAD0
	db	10h dup (0)	;@0CAD0
PEEK_TOKEN:	int	3Fh	;@0CAE0
	sub	ax, 0	;@0CAE2
ADVANCE_TOKEN:	int	3Fh	;@0CAE5
	mov	word ptr ds:[0], ax	;@0CAE7
NEXT_LITERAL_CHAR:	int	3Fh	;@0CAEA
	add	byte ptr [bx+si], al	;@0CAEC
	add	byte ptr [bx+si], al	;@0CAEE
	int	3Fh	;@0CAF0
	add	byte ptr [bx+si], al	;@0CAF2
	db	70h, 0ADh	; jo L181A0+18691	;@0CAF4
	add	al, byte ptr [bx+si]	;@0CAF6
	db	0C7h, 10h, 9Ah, 0, 0Bh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0CAF8
	db	0, 0, 0, 0, 0, 0
DEFINE_COMMAND_LINE_MACROS:	int	3Fh	;@0CB10
	mov	cl, 0Eh	;@0CB12
L0CB14:	db	0, 0CDh	; add ch, cl	;@0CB14
	aas	;@0CB16
	db	0EAh, 0Ch, 0, 0CDh, 3Fh	; ljmp 0x3fcd:0xc	;@0CB17
	add	byte ptr [bx+si], al	;@0CB1C
	db	0, 0CDh	; add ch, cl	;@0CB1E
	aas	;@0CB20
	xor	ax, 2	;@0CB21
REMOVE_COMMAND_LINE_MACRO:	int	3Fh	;@0CB24
	pop	bp	;@0CB26
	or	al, 0	;@0CB27
SAVE_WARNINGS_AS_DEFAULT:	int	3Fh	;@0CB29
	sti	;@0CB2B
	add	al, byte ptr [bx+si]	;@0CB2C
RESET_WARNINGS_TO_DEFAULT:	int	3Fh	;@0CB2E
	fadd	qword ptr [bp+si]	;@0CB30
	db	0, 0CDh	; add ch, cl	;@0CB32
	aas	;@0CB34
	dec	cx	;@0CB35
	add	al, byte ptr [bx+si]	;@0CB36
OPEN_INCLUDE_FILE:	int	3Fh	;@0CB38
	dec	cx	;@0CB3A
	push	cs	;@0CB3B
	db	0, 0CDh	; add ch, cl	;@0CB3C
	aas	;@0CB3E
	sbb	al, byte ptr [bp+di]	;@0CB3F
	db	0, 0CDh	; add ch, cl	;@0CB41
	aas	;@0CB43
	db	0D6h	; salc	;@0CB44
@@1:	or	al, byte ptr [bx+si]	;@0CB45
	add	byte ptr [bx+si], al	;@0CB47
	add	byte ptr [bx+si], al	;@0CB49
	add	byte ptr [bx+si], al	;@0CB4B
	add	byte ptr [bx+si], al	;@0CB4D
	db	0, 0CDh	; add ch, cl	;@0CB4F
	aas	;@0CB51
	add	byte ptr [bx+si], al	;@0CB52
	loopne	L0CB14	;@0CB54
	add	al, byte ptr [bx+si]	;@0CB56
	db	0F2h, 1, 0Ch	; add word ptr [si], cx	;@0CB58
	db	0, 1	; add byte ptr [bx+di], al	;@0CB5B
	add	byte ptr [bx+si], al	;@0CB5D
	add	byte ptr [bx+si], al	;@0CB5F
	add	byte ptr [bx+si], al	;@0CB61
	add	byte ptr [bx+si], al	;@0CB63
	add	byte ptr [bx+si], al	;@0CB65
	add	byte ptr [bx+si], al	;@0CB67
	add	byte ptr [bx+si], al	;@0CB69
	add	byte ptr [bx+si], al	;@0CB6B
	add	byte ptr [bx+si], al	;@0CB6D
	db	0, 0CDh	; add ch, cl	;@0CB6F
	aas	;@0CB71
	jns	@@2	;@0CB72
@@2:	add	byte ptr [bx+si], al	;@0CB74
	add	byte ptr [bx+si], al	;@0CB76
	add	byte ptr [bx+si], al	;@0CB78
	add	byte ptr [bx+si], al	;@0CB7A
	add	byte ptr [bx+si], al	;@0CB7C
	add	byte ptr [bx+si], al	;@0CB7E
	int	3Fh	;@0CB80
	add	byte ptr [bx+si], al	;@0CB82
	loopne	@@1+1	;@0CB84
	add	al, byte ptr [bx+si]	;@0CB86
	mov	word ptr ds:[0DA15h], ax	;@0CB88
	add	byte ptr [bp+di], cl	;@0CB8B
	add	byte ptr [bx+si], al	;@0CB8D
	add	byte ptr [bx+si], al	;@0CB8F
	add	byte ptr [bx+si], al	;@0CB91
	add	byte ptr [bx+si], al	;@0CB93
	add	byte ptr [bx+si], al	;@0CB95
	add	byte ptr [bx+si], al	;@0CB97
	add	byte ptr [bx+si], al	;@0CB99
	add	byte ptr [bx+si], al	;@0CB9B
	add	byte ptr [bx+si], al	;@0CB9D
	db	0, 0CDh	; add ch, cl	;@0CB9F
	aas	;@0CBA1
	db	36h, 15h, 0, 0CDh	; adc ax, 0CD00h	;@0CBA2
	db	3Fh	; aas	;@0CBA6
	db	67h, 11h, 0	; adc word ptr [eax], ax	;@0CBA7
SCAN_WRITE:	int	3Fh	;@0CBAA
	or	dl, byte ptr [bx+di]	;@0CBAC
	db	0, 0CDh	; add ch, cl	;@0CBAE
	aas	;@0CBB0
	add	byte ptr [bx+si], al	;@0CBB1
	db	0, 0CDh	; add ch, cl	;@0CBB3
	aas	;@0CBB5
	pushf	;@0CBB6
	adc	ax, 0CD00h	;@0CBB7
	aas	;@0CBBA
	pop	ds	;@0CBBB
	add	byte ptr [bx+si], al	;@0CBBC
BCC_SCAN_FINISH_FAR:	int	3Fh	;@0CBBE
Y0CAD0	ends

Y0CBC0	segment para public 'CODE'
	assume	cs:Y0CBC0
	db	6Bh, 13h, 0	;@0CBC0
COMMENT_BLOCK:	int	3Fh	;@0CBC3
	adc	word ptr [si], 0	;@0CBC5
SCAN_TOKEN:	int	3Fh	;@0CBC8
	db	2Eh, 0Fh, 0, 0CDh	; str bp	;@0CBCA
	db	3Fh	; aas	;@0CBCE
	sub	cx, word ptr [bx+di]	;@0CBCF
	db	0, 0CDh	; add ch, cl	;@0CBD1
	aas	;@0CBD3
	sub	ax, 11h	;@0CBD4
	add	byte ptr [bx+si], al	;@0CBD7
	add	byte ptr [bx+si], al	;@0CBD9
	add	byte ptr [bx+si], al	;@0CBDB
	add	byte ptr [bx+si], al	;@0CBDD
	db	0, 0CDh	; add ch, cl	;@0CBDF
	aas	;@0CBE1
	add	byte ptr [bx+si], al	;@0CBE2
	rcl	bh, 2	;@0CBE4
	add	byte ptr [bp+si+24h], bl	;@0CBE7
	xchg	ax, sp	;@0CBEA
	add	word ptr [bx], cx	;@0CBEB
	add	byte ptr [bx+si], al	;@0CBED
	db	0	; add byte ptr [bx+si], al	;@0CBEF
Y0CBC0	ends

Y0CBF0	segment para public 'CODE'
	assume	cs:Y0CBF0
	db	10h dup (0)	;@0CBF0
INIT_LEXER_STATE:	int	3Fh	;@0CC00
	mov	dx, 0	;@0CC02
FLUSH_PENDING_POOL:	int	3Fh	;@0CC05
	mov	al, 23h	;@0CC07
	db	0, 0CDh	; add ch, cl	;@0CC09
	aas	;@0CC0B
	db	0DFh, 0Ch	; fisttp word ptr [si]	;@0CC0C
	db	0, 0CDh	; add ch, cl	;@0CC0E
	aas	;@0CC10
	test	byte ptr [bp+si], dl	;@0CC11
	db	0, 0CDh	; add ch, cl	;@0CC13
	aas	;@0CC15
	not	byte ptr [bx+di]	;@0CC16
	db	0, 0CDh	; add ch, cl	;@0CC18
	aas	;@0CC1A
	add	byte ptr [bx+si], al	;@0CC1B
	db	0, 0CDh	; add ch, cl	;@0CC1D
	aas	;@0CC1F
	and	al, 1Ah	;@0CC20
	db	0, 0CDh	; add ch, cl	;@0CC22
	aas	;@0CC24
	hlt	;@0CC25
	and	al, byte ptr [bx+si]	;@0CC26
LEX_READ:	int	3Fh	;@0CC28
	or	word ptr [bp+si], 0	;@0CC2A
LEX_NEWLINE:	int	3Fh	;@0CC2D
	mov	word ptr [bx+di], ss	;@0CC2F
	db	0, 0CDh	; add ch, cl	;@0CC31
	aas	;@0CC33
	db	0F0h, 1Ch, 0	;@0CC34
BCC_LEX_RESTORE:	int	3Fh	;@0CC37
	db	7Fh, 21h	; jg L0CC5C	;@0CC39
	db	0, 0CDh	; add ch, cl	;@0CC3B
	aas	;@0CC3D
	xor	dx, word ptr [bp+di]	;@0CC3E
	db	0, 0CDh	; add ch, cl	;@0CC40
	aas	;@0CC42
	push	dx	;@0CC43
	or	al, byte ptr [bx+si]	;@0CC44
LEX_NEXT_TOKEN:	int	3Fh	;@0CC46
	add	word ptr [bx+di], ax	;@0CC48
	add	byte ptr [bx+si], al	;@0CC4A
	add	byte ptr [bx+si], al	;@0CC4C
	add	byte ptr [bx+si], al	;@0CC4E
Y0CBF0	ends

Y0CC50	segment para public 'CODE'
	assume	cs:Y0CC50
	db	0CDh, 3Fh, 0, 0, 0D0h, 0FDh, 2, 0, 8, 0Ch, 42h, 0	;@0CC50
L0CC5C:	or	al, 0	;@0CC5C
	add	byte ptr [bx+si], al	;@0CC5E
	add	byte ptr [bx+si], al	;@0CC60
	add	byte ptr [bx+si], al	;@0CC62
	add	byte ptr [bx+si], al	;@0CC64
	add	byte ptr [bx+si], al	;@0CC66
	add	byte ptr [bx+si], al	;@0CC68
	add	byte ptr [bx+si], al	;@0CC6A
	add	byte ptr [bx+si], al	;@0CC6C
	add	byte ptr [bx+si], al	;@0CC6E
BCC_INPUT_BYTE:	int	3Fh	;@0CC70
	cmp	ax, 3	;@0CC72
INPUT_POSITION:	int	3Fh	;@0CC75
	xor	cl, byte ptr [bp+si]	;@0CC77
	db	0, 0CDh	; add ch, cl	;@0CC79
	aas	;@0CC7B
	in	ax, dx	;@0CC7C
	or	byte ptr [bx+si], al	;@0CC7D
SEEK_ECHO_FILE:	db	0CDh	; int 3Fh	;@0CC7F
Y0CC50	ends

Y0CC80	segment para public 'CODE'
	assume	cs:Y0CC80
	db	3Fh, 6Fh, 0Ah, 0	;@0CC80
POP_INPUT_CONTEXT:	int	3Fh	;@0CC84
	arpl	word ptr [bx+di], ax	;@0CC86
	db	0, 0CDh	; add ch, cl	;@0CC88
	aas	;@0CC8A
	xor	cx, word ptr [bp+di]	;@0CC8B
	db	0, 0CDh	; add ch, cl	;@0CC8D
	aas	;@0CC8F
	inc	si	;@0CC90
	add	ax, 0CD00h	;@0CC91
	aas	;@0CC94
	mov	al, byte ptr [bx+si]	;@0CC95
	db	0, 0CDh	; add ch, cl	;@0CC97
	aas	;@0CC99
	imul	ax, word ptr [bp+si], 0	;@0CC9A
BCC_INPUT_STRING_PTR:	int	3Fh	;@0CC9D
	clc	;@0CC9F
	add	al, 0	;@0CCA0
RESTORE_ECHO_POSITION:	int	3Fh	;@0CCA2
	call	L0CCB2	;@0CCA4
BCC_INPUT_STRING:	int	3Fh	;@0CCA7
	cmpsb	;@0CCA9
	add	al, 0	;@0CCAA
	add	byte ptr [bx+si], al	;@0CCAC
	add	byte ptr [bx+si], al	;@0CCAE
	int	3Fh	;@0CCB0
L0CCB2:	add	byte ptr [bx+si], al	;@0CCB2
	and	byte ptr [bp+si], cl	;@0CCB4
	add	ax, word ptr [bx+si]	;@0CCB6
	and	al, byte ptr [bp+di]	;@0CCB8
	and	byte ptr [bx+si], al	;@0CCBA
	add	ax, 0	;@0CCBC
	add	byte ptr [bx+si], al	;@0CCBF
	add	byte ptr [bx+si], al	;@0CCC1
	add	byte ptr [bx+si], al	;@0CCC3
	add	byte ptr [bx+si], al	;@0CCC5
	add	byte ptr [bx+si], al	;@0CCC7
	add	byte ptr [bx+si], al	;@0CCC9
	add	byte ptr [bx+si], al	;@0CCCB
	add	byte ptr [bx+si], al	;@0CCCD
	db	0, 0CDh	; add ch, cl	;@0CCCF
	aas	;@0CCD1
	push	ds	;@0CCD2
	add	al, byte ptr [bx+si]	;@0CCD3
MACRO_REMOVE:	int	3Fh	;@0CCD5
	std	;@0CCD7
	add	word ptr [bx+si], ax	;@0CCD8
MACRO_DEFINE:	int	3Fh	;@0CCDA
	jl	@@1	;@0CCDC
@@1:	db	0, 0CDh	; add ch, cl	;@0CCDE
Y0CC80	ends

Y0CCE0	segment para public 'CODE'
	assume	cs:Y0CCE0
	db	3Fh, 73h, 2, 0	;@0CCE0
MACRO_LOOKUP:	int	3Fh	;@0CCE4
	sahf	;@0CCE6
	add	al, byte ptr [bx+si]	;@0CCE7
	add	byte ptr [bx+si], al	;@0CCE9
	add	byte ptr [bx+si], al	;@0CCEB
	add	byte ptr [bx+si], al	;@0CCED
	db	0, 0CDh	; add ch, cl	;@0CCEF
	aas	;@0CCF1
	add	byte ptr [bx+si], al	;@0CCF2
	jo	@@1	;@0CCF4
	add	ax, word ptr [bx+si]	;@0CCF6
	dec	di	;@0CCF8
	adc	bh, byte ptr [bp+si+800h]	;@0CCF9
	add	byte ptr [bx+si], al	;@0CCFD
	add	byte ptr [bx+si], al	;@0CCFF
	add	byte ptr [bx+si], al	;@0CD01
@@1:	add	byte ptr [bx+si], al	;@0CD03
	add	byte ptr [bx+si], al	;@0CD05
	add	byte ptr [bx+si], al	;@0CD07
	add	byte ptr [bx+si], al	;@0CD09
	add	byte ptr [bx+si], al	;@0CD0B
	add	byte ptr [bx+si], al	;@0CD0D
	db	0, 0CDh	; add ch, cl	;@0CD0F
	aas	;@0CD11
	bound	cx, dword ptr ds:[0CD00h]	;@0CD12
	aas	;@0CD16
	dec	si	;@0CD17
	add	al, byte ptr [bx+si]	;@0CD18
RUN_LINKER:	int	3Fh	;@0CD1A
	or	ax, 6	;@0CD1C
EXPAND_RESPONSE_FILES:	int	3Fh	;@0CD1F
	das	;@0CD21
	adc	byte ptr [bx+si], al	;@0CD22
ADD_DEFAULT_EXTENSION:	int	3Fh	;@0CD24
	add	word ptr cs:[bx+si], ax	;@0CD26
PROCESS_FILE_ARGUMENT:	int	3Fh	;@0CD29
	rol	word ptr [bx+di], cl	;@0CD2B
	db	0, 0CDh	; add ch, cl	;@0CD2D
	aas	;@0CD2F
	mov	dl, 5	;@0CD30
	db	0, 0CDh	; add ch, cl	;@0CD32
	aas	;@0CD34
	inc	cx	;@0CD35
	push	cs	;@0CD36
	add	byte ptr [bx+si], al	;@0CD37
	add	byte ptr [bx+si], al	;@0CD39
	add	byte ptr [bx+si], al	;@0CD3B
	add	byte ptr [bx+si], al	;@0CD3D
	db	0, 0CDh	; add ch, cl	;@0CD3F
	aas	;@0CD41
	add	byte ptr [bx+si], al	;@0CD42
	and	byte ptr [bx+si], 3	;@0CD44
	add	byte ptr [si+7008h], bl	;@0CD47
	add	byte ptr [bx+di], cl	;@0CD4B
	add	byte ptr [bx+si], al	;@0CD4D
	db	0	; add byte ptr [bx+si], al	;@0CD4F
Y0CCE0	ends

Y0CD50	segment para public 'CODE'
	assume	cs:Y0CD50
	db	10h dup (0)	;@0CD50
ADD_STARTUP_ENTRY:	int	3Fh	;@0CD60
	sub	al, 8	;@0CD62
	db	0, 0CDh	; add ch, cl	;@0CD64
	aas	;@0CD66
	add	byte ptr [bx+si], al	;@0CD67
	db	0, 0CDh	; add ch, cl	;@0CD69
	aas	;@0CD6B
	mov	es, word ptr ds:[0CD00h]	;@0CD6C
	aas	;@0CD70
	mov	es, word ptr [bx]	;@0CD71
	db	0, 0CDh	; add ch, cl	;@0CD73
	aas	;@0CD75
	insb	;@0CD76
	add	byte ptr [bx+si], al	;@0CD77
INIT_SEGMENT_NAMES:	int	3Fh	;@0CD79
	movsw	;@0CD7B
	add	byte ptr [bx+si], al	;@0CD7C
ADD_EXIT_ENTRY:	int	3Fh	;@0CD7E
	db	64h, 8, 0	; or byte ptr [bx+si], al	;@0CD80
BCC_INTERN_STRING:	db	0CDh, 3Fh	; int 3Fh	;@0CD83
	pop	dx	;@0CD85
	push	es	;@0CD86
	db	0, 0CDh	; add ch, cl	;@0CD87
	aas	;@0CD89
	mov	dl, 7	;@0CD8A
	add	byte ptr [bx+si], al	;@0CD8C
	add	byte ptr [bx+si], al	;@0CD8E
	int	3Fh	;@0CD90
	add	byte ptr [bx+si], al	;@0CD92
	shr	byte ptr [bx+di], 3	;@0CD94
	add	byte ptr [bp+si], ah	;@0CD97
	add	ax, 48h	;@0CD99
	add	word ptr [bx+si], ax	;@0CD9C
	add	byte ptr [bx+si], al	;@0CD9E
	add	byte ptr [bx+si], al	;@0CDA0
	add	byte ptr [bx+si], al	;@0CDA2
	add	byte ptr [bx+si], al	;@0CDA4
	add	byte ptr [bx+si], al	;@0CDA6
	add	byte ptr [bx+si], al	;@0CDA8
	add	byte ptr [bx+si], al	;@0CDAA
	add	byte ptr [bx+si], al	;@0CDAC
	add	byte ptr [bx+si], al	;@0CDAE
Y0CD50	ends

Y0CDB0	segment para public 'CODE'
	assume	cs:Y0CDB0
	db	0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0CDB0
	db	0, 0, 30h, 2Fh, 3, 0, 2Fh, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0
Y0CDB0	ends

Y0CDF0	segment para public 'CODE'
	assume	cs:Y0CDF0
	db	0CDh, 3Fh, 0, 0, 70h, 2Fh, 3, 0, 0FCh, 0, 0, 0, 1, 0, 0, 0, 0	;@0CDF0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 80h, 30h, 3
	db	0, 2Bh, 7, 5Eh, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0
Y0CDF0	ends

Y0CE40	segment para public 'CODE'
	assume	cs:Y0CE40
DEBUG_NUMBERS:	int	3Fh	;@0CE40
	inc	ax	;@0CE42
	add	byte ptr [bx+si], al	;@0CE43
C56_EMIT_NAME:	int	3Fh	;@0CE45
	clc	;@0CE47
	add	ax, 0CD00h	;@0CE48
	aas	;@0CE4B
	dec	si	;@0CE4C
	add	ax, word ptr [bx+si]	;@0CE4D
	db	0, 0CDh	; add ch, cl	;@0CE4F
	aas	;@0CE51
	add	byte ptr [bx+si], al	;@0CE52
	adc	byte ptr [bx+si], bh	;@0CE54
	add	ax, word ptr [bx+si]	;@0CE56
	mov	bl, 7	;@0CE58
	mov	byte ptr ds:[200h], al	;@0CE5A
	add	byte ptr [bx+si], al	;@0CE5D
	add	byte ptr [bx+si], al	;@0CE5F
	add	byte ptr [bx+si], al	;@0CE61
	add	byte ptr [bx+si], al	;@0CE63
	add	byte ptr [bx+si], al	;@0CE65
	add	byte ptr [bx+si], al	;@0CE67
	add	byte ptr [bx+si], al	;@0CE69
	add	byte ptr [bx+si], al	;@0CE6B
	add	byte ptr [bx+si], al	;@0CE6D
	db	0, 0CDh	; add ch, cl	;@0CE6F
	aas	;@0CE71
	add	byte ptr [bx+si], al	;@0CE72
	db	0, 0CDh	; add ch, cl	;@0CE74
	aas	;@0CE76
	test	al, 6	;@0CE77
	add	byte ptr [bx+si], al	;@0CE79
	add	byte ptr [bx+si], al	;@0CE7B
	add	byte ptr [bx+si], al	;@0CE7D
	db	0, 0CDh	; add ch, cl	;@0CE7F
	aas	;@0CE81
	add	byte ptr [bx+si], al	;@0CE82
	db	70h, 40h	; jo L0CEC5+1	;@0CE84
	add	ax, word ptr [bx+si]	;@0CE86
	xchg	word ptr [di], ax	;@0CE88
	or	al, 0	;@0CE8A
	or	byte ptr [bx+si], al	;@0CE8C
	add	byte ptr [bx+si], al	;@0CE8E
Y0CE40	ends
	end

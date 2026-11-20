	.286p
	locals

Y0C3A0	segment para public 'CODE'
	assume	cs:Y0C3A0
	db	0CDh, 3Fh, 0, 0, 0E0h, 0B6h, 1, 0, 0EBh, 1, 24h, 0, 2, 0, 0, 0	;@0C3A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
MAKE_MEMBER_POINTER:	int	3Fh	;@0C3C0
	add	byte ptr [bx+si], al	;@0C3C2
	db	0, 0CDh	; add ch, cl	;@0C3C4
	aas	;@0C3C6
	pusha	;@0C3C7
	add	word ptr [bx+si], ax	;@0C3C8
	add	byte ptr [bx+si], al	;@0C3CA
	add	byte ptr [bx+si], al	;@0C3CC
	add	byte ptr [bx+si], al	;@0C3CE
	int	3Fh	;@0C3D0
	add	byte ptr [bx+si], al	;@0C3D2
	db	0F0h, 0B8h, 1, 0, 32h, 1, 1Ch, 0, 2, 0, 0, 0	;@0C3D4
Y0C3A0	ends

Y0C3E0	segment para public 'CODE'
	assume	cs:Y0C3E0
	db	10h dup (0)	;@0C3E0
FIND_NAMED_FUNCTION_PREPARED:	int	3Fh	;@0C3F0
	db	0C8h, 0, 0, 0CDh	; enter 0, 0FFCDh	;@0C3F2
	aas	;@0C3F6
	add	byte ptr [bx+si], al	;@0C3F7
	add	byte ptr [bx+si], al	;@0C3F9
	add	byte ptr [bx+si], al	;@0C3FB
	add	byte ptr [bx+si], al	;@0C3FD
	db	0, 0CDh	; add ch, cl	;@0C3FF
	aas	;@0C401
	add	byte ptr [bx+si], al	;@0C402
	inc	ax	;@0C404
	mov	dx, 1	;@0C405
	pop	ss	;@0C408
	add	cx, word ptr ds:[0B00h]	;@0C409
	add	byte ptr [bx+si], al	;@0C40D
	add	byte ptr [bx+si], al	;@0C40F
	add	byte ptr [bx+si], al	;@0C411
	add	byte ptr [bx+si], al	;@0C413
	add	byte ptr [bx+si], al	;@0C415
	add	byte ptr [bx+si], al	;@0C417
	add	byte ptr [bx+si], al	;@0C419
	add	byte ptr [bx+si], al	;@0C41B
	add	byte ptr [bx+si], al	;@0C41D
	db	0	; add ch, cl	;@0C41F
Y0C3E0	ends

Y0C420	segment para public 'CODE'
	assume	cs:Y0C420
SKIP_TO_SYNC_TOKEN:	int	3Fh	;@0C420
	cli	;@0C422
L0C423:	add	word ptr [bx+si], ax	;@0C423
SKIP_BRACE_GROUP:	int	3Fh	;@0C425
	push	ds	;@0C427
	add	al, byte ptr [bx+si]	;@0C428
NAME_TEXT_COPY:	int	3Fh	;@0C42A
	db	68h, 2, 0	; push 2	;@0C42C
REPORT_NAME_DIAGNOSTIC:	db	0CDh, 3Fh	; int 3Fh	;@0C42F
	jg	@@1+1	;@0C431
@@1:	db	0, 0CDh	; add ch, cl	;@0C433
	aas	;@0C435
	movsw	;@0C436
	add	word ptr [bx+si], ax	;@0C437
REPORT_CURRENT_TOKEN:	int	3Fh	;@0C439
	out	1, ax	;@0C43B
	db	0, 0CDh	; add ch, cl	;@0C43D
	aas	;@0C43F
	cmp	al, 1	;@0C440
	db	0, 0CDh	; add ch, cl	;@0C442
	aas	;@0C444
	pop	si	;@0C445
	add	word ptr [bx+si], ax	;@0C446
MEMBER_NAME_TEXT:	int	3Fh	;@0C448
	in	ax, dx	;@0C44A
	add	al, byte ptr [bx+si]	;@0C44B
SYMBOL_NAME_TEXT:	int	3Fh	;@0C44D
	ret	;@0C44F
	db	2, 0	;@0C450
REPORT_DIAGNOSTIC_AT:	int	3Fh	;@0C452
	dec	si	;@0C454
	add	byte ptr [bx+si], al	;@0C455
	add	byte ptr [bx+si], al	;@0C457
	add	byte ptr [bx+si], al	;@0C459
	add	byte ptr [bx+si], al	;@0C45B
	add	byte ptr [bx+si], al	;@0C45D
	db	0, 0CDh	; add ch, cl	;@0C45F
	aas	;@0C461
	add	byte ptr [bx+si], al	;@0C462
	jo	L0C423	;@0C464
	add	word ptr [bx+si], ax	;@0C466
	mov	bl, 3	;@0C468
	xor	al, 0	;@0C46A
	add	al, byte ptr [bx+si]	;@0C46C
	add	byte ptr [bx+si], al	;@0C46E
Y0C420	ends

Y0C470	segment para public 'CODE'
	assume	cs:Y0C470
	db	10h dup (0)	;@0C470
COMPILE_INLINE_BODY:	int	3Fh	;@0C480
	mov	dx, 1	;@0C482
RECORD_INLINE_BODY:	int	3Fh	;@0C485
	add	byte ptr [bx+si], al	;@0C487
	add	byte ptr [bx+si], al	;@0C489
	add	byte ptr [bx+si], al	;@0C48B
	add	byte ptr [bx+si], al	;@0C48D
	db	0, 0CDh	; add ch, cl	;@0C48F
	aas	;@0C491
	add	byte ptr [bx+si], al	;@0C492
	pusha	;@0C494
	rol	word ptr [bx+di], 0	;@0C495
	db	69h, 9, 6Eh, 0	; imul cx, word ptr [bx+di], 6Eh	;@0C498
	db	5, 0, 0	; add ax, 0	;@0C49C
	db	0	; add byte ptr [bx+si], al	;@0C49F
Y0C470	ends

Y0C4A0	segment para public 'CODE'
	assume	cs:Y0C4A0
	db	10h dup (0)	;@0C4A0
BEGIN_FUNCTION_BODY:	int	3Fh	;@0C4B0
	dec	di	;@0C4B2
	pop	es	;@0C4B3
	db	0, 0CDh	; add ch, cl	;@0C4B4
	aas	;@0C4B6
	out	dx, al	;@0C4B7
	or	byte ptr [bx+si], al	;@0C4B8
DECLARE_PARAMETERS:	int	3Fh	;@0C4BA
	sbb	al, byte ptr [di]	;@0C4BC
	db	0, 0CDh	; add ch, cl	;@0C4BE
	aas	;@0C4C0
	mov	dx, 6	;@0C4C1
COMPILE_FUNCTION_DEFINITION:	int	3Fh	;@0C4C4
	xchg	ax, sp	;@0C4C6
	add	al, byte ptr [bx+si]	;@0C4C7
	add	byte ptr [bx+si], al	;@0C4C9
	add	byte ptr [bx+si], al	;@0C4CB
	add	byte ptr [bx+si], al	;@0C4CD
	db	0	; add ch, cl	;@0C4CF
Y0C4A0	ends

Y0C4D0	segment para public 'CODE'
	assume	cs:Y0C4D0
	db	0CDh, 3Fh, 0, 0, 40h, 0CBh, 1, 0, 4, 8, 16h, 0, 0Ch, 0, 0, 0, 0	;@0C4D0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
STREAM_GET_TOKEN:	int	3Fh	;@0C4F0
	stc	;@0C4F2
	push	es	;@0C4F3
	db	0, 0CDh	; add ch, cl	;@0C4F4
	aas	;@0C4F6
	imul	ax, word ptr [di], 0CD00h	;@0C4F7
	aas	;@0C4FB
	or	ax, 7	;@0C4FC
STREAM_COPY_STATE:	db	0CDh	; int 3Fh	;@0C4FF
Y0C4D0	ends

Y0C500	segment para public 'CODE'
	assume	cs:Y0C500
	db	3Fh, 0Dh, 6, 0	;@0C500
BCC_PARSE_POP:	int	3Fh	;@0C504
	pop	dx	;@0C506
	pop	es	;@0C507
L0C508:	db	0, 0CDh	; add ch, cl	;@0C508
	aas	;@0C50A
	mov	word ptr [bp+si], es	;@0C50B
	db	0, 0CDh	; add ch, cl	;@0C50D
	aas	;@0C50F
	pop	word ptr [di]	;@0C510
	db	0, 0CDh	; add ch, cl	;@0C512
	aas	;@0C514
	xlat	;@0C515
	pop	es	;@0C516
	db	0, 0CDh	; add ch, cl	;@0C517
	aas	;@0C519
	out	dx, ax	;@0C51A
	add	al, 0	;@0C51B
STREAM_PUT_TOKEN:	int	3Fh	;@0C51D
	in	ax, 6	;@0C51F
	db	0, 0CDh	; add ch, cl	;@0C521
	aas	;@0C523
	rol	word ptr ds:[0CD00h], 1	;@0C524
	aas	;@0C528
	sub	al, byte ptr ds:[0]	;@0C529
	add	byte ptr [bx+si], al	;@0C52D
	db	0, 0CDh	; add ch, cl	;@0C52F
	aas	;@0C531
	add	byte ptr [bx+si], al	;@0C532
	jo	L0C508+1	;@0C534
	add	word ptr [bx+si], ax	;@0C536
	ja	@@1+1	;@0C538
	fiadd	dword ptr [bx+si]	;@0C53A
	pop	es	;@0C53C
	add	byte ptr [bx+si], al	;@0C53D
	add	byte ptr [bx+si], al	;@0C53F
@@1:	add	byte ptr [bx+si], al	;@0C541
	add	byte ptr [bx+si], al	;@0C543
	add	byte ptr [bx+si], al	;@0C545
	add	byte ptr [bx+si], al	;@0C547
	add	byte ptr [bx+si], al	;@0C549
	add	byte ptr [bx+si], al	;@0C54B
	add	byte ptr [bx+si], al	;@0C54D
	db	0, 0CDh	; add ch, cl	;@0C54F
	aas	;@0C551
	fiadd	word ptr [di]	;@0C552
	db	0, 0CDh	; add ch, cl	;@0C554
	aas	;@0C556
	js	@@2+1	;@0C557
	db	0, 0CDh	; add ch, cl	;@0C559
	aas	;@0C55B
@@2:	mov	cl, 3	;@0C55C
	db	0, 0CDh	; add ch, cl	;@0C55E
Y0C500	ends

Y0C560	segment para public 'CODE'
	assume	cs:Y0C560
	db	3Fh, 4Eh, 5, 0	;@0C560
QUEUE_INIT_EXPR:	int	3Fh	;@0C564
	add	byte ptr [bx+si], al	;@0C566
	db	0, 0CDh	; add ch, cl	;@0C568
	aas	;@0C56A
	db	0F3h, 6	; push es	;@0C56B
	db	0, 0CDh	; add ch, cl	;@0C56D
	aas	;@0C56F
	mov	word ptr [bx+si], es	;@0C570
	add	byte ptr [bx+si], al	;@0C572
	add	byte ptr [bx+si], al	;@0C574
	add	byte ptr [bx+si], al	;@0C576
	add	byte ptr [bx+si], al	;@0C578
	add	byte ptr [bx+si], al	;@0C57A
	add	byte ptr [bx+si], al	;@0C57C
	add	byte ptr [bx+si], al	;@0C57E
	int	3Fh	;@0C580
	add	byte ptr [bx+si], al	;@0C582
	rcr	ah, 1	;@0C584
	add	word ptr [bx+si], ax	;@0C586
	adc	ax, word ptr [si]	;@0C588
	inc	ax	;@0C58A
	add	byte ptr [di], al	;@0C58B
	add	byte ptr [bx+si], al	;@0C58D
	db	0	; add byte ptr [bx+si], al	;@0C58F
Y0C560	ends

Y0C590	segment para public 'CODE'
	assume	cs:Y0C590
	db	10h dup (0)	;@0C590
IS_PAREN_TYPE_NAME:	int	3Fh	;@0C5A0
	mov	si, 3	;@0C5A2
SCAN_TYPE_SPECIFIERS:	int	3Fh	;@0C5A5
	lea	ax, [bx+si]	;@0C5A7
	db	0, 0CDh	; add ch, cl	;@0C5A9
	aas	;@0C5AB
	add	byte ptr [bx+si], al	;@0C5AC
	db	0, 0CDh	; add ch, cl	;@0C5AE
	aas	;@0C5B0
	pop	ax	;@0C5B1
	add	word ptr [bx+si], ax	;@0C5B2
BCC_PARSE_QUERY:	int	3Fh	;@0C5B4
	test	byte ptr [bp+si], 0	;@0C5B6
	add	byte ptr [bx+si], al	;@0C5B9
	add	byte ptr [bx+si], al	;@0C5BB
	add	byte ptr [bx+si], al	;@0C5BD
	db	0, 0CDh	; add ch, cl	;@0C5BF
	aas	;@0C5C1
	add	byte ptr [bx+si], al	;@0C5C2
	db	30h, 0E1h	; xor cl, ah	;@0C5C4
	add	word ptr [bx+si], ax	;@0C5C6
	sub	al, byte ptr [si]	;@0C5C8
	push	sp	;@0C5CA
	add	byte ptr [bp+di], al	;@0C5CB
	add	byte ptr [bx+si], al	;@0C5CD
	db	0	; add byte ptr [bx+si], al	;@0C5CF
Y0C590	ends

Y0C5D0	segment para public 'CODE'
	assume	cs:Y0C5D0
	db	10h dup (0)	;@0C5D0
BEGIN_SESSION:	int	3Fh	;@0C5E0
	add	byte ptr [bx+si], al	;@0C5E2
	db	0, 0CDh	; add ch, cl	;@0C5E4
	aas	;@0C5E6
	push	sp	;@0C5E7
	add	word ptr [bx+si], ax	;@0C5E8
END_SESSION:	int	3Fh	;@0C5EA
	db	69h, 0, 0, 0	; imul ax, word ptr [bx+si], 0	;@0C5EC
	db	0CDh, 3Fh	; int 3Fh	;@0C5F0
	add	byte ptr [bx+si], al	;@0C5F2
	mov	al, 0E5h	;@0C5F4
	add	word ptr [bx+si], ax	;@0C5F6
	and	byte ptr ds:[5Ch], al	;@0C5F8
	add	al, 0	;@0C5FC
	add	byte ptr [bx+si], al	;@0C5FE
	add	byte ptr [bx+si], al	;@0C600
	add	byte ptr [bx+si], al	;@0C602
	add	byte ptr [bx+si], al	;@0C604
	add	byte ptr [bx+si], al	;@0C606
	add	byte ptr [bx+si], al	;@0C608
	add	byte ptr [bx+si], al	;@0C60A
	add	byte ptr [bx+si], al	;@0C60C
	add	byte ptr [bx+si], al	;@0C60E
PARSE_ASM_MEMBER:	int	3Fh	;@0C610
	out	dx, al	;@0C612
	add	ax, word ptr [bx+si]	;@0C613
PARSE_ASM_JUMP_LABEL:	int	3Fh	;@0C615
	pop	sp	;@0C617
	add	ax, 0CD00h	;@0C618
	aas	;@0C61B
	add	byte ptr [bx+si], al	;@0C61C
	db	0, 0CDh	; add ch, cl	;@0C61E
	aas	;@0C620
	fiadd	dword ptr [bx+si]	;@0C621
	add	byte ptr [bx+si], al	;@0C623
	add	byte ptr [bx+si], al	;@0C625
	add	byte ptr [bx+si], al	;@0C627
	add	byte ptr [bx+si], al	;@0C629
	add	byte ptr [bx+si], al	;@0C62B
	add	byte ptr [bx+si], al	;@0C62D
	db	0	; add ch, cl	;@0C62F
Y0C5D0	ends

Y0C630	segment para public 'CODE'
	assume	cs:Y0C630
	db	0CDh, 3Fh, 0, 0, 30h, 0ECh, 1, 0, 17h, 0Ch, 4, 0, 0Ah, 0, 0, 0	;@0C630
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FORMAT_SPECIAL_MEMBER:	int	3Fh	;@0C650
	xchg	ax, si	;@0C652
	or	word ptr [bx+si], ax	;@0C653
LINKAGE_NAME:	int	3Fh	;@0C655
	fimul	dword ptr [bp+si]	;@0C657
	db	0, 0CDh	; add ch, cl	;@0C659
	aas	;@0C65B
	or	byte ptr [bp+si], 0	;@0C65C
FORMAT_MEMBER_NAME:	int	3Fh	;@0C65F
	or	cl, byte ptr [bp+di]	;@0C661
	db	0, 0CDh	; add ch, cl	;@0C663
	aas	;@0C665
	test	byte ptr ds:[0CD00h], al	;@0C666
	aas	;@0C66A
	add	byte ptr [bx], 0	;@0C66B
FORMAT_MEMBER:	int	3Fh	;@0C66E
	bound	cx, dword ptr [bx+si]	;@0C670
	db	0, 0CDh	; add ch, cl	;@0C672
	aas	;@0C674
	dec	sp	;@0C675
	or	al, byte ptr [bx+si]	;@0C676
CLASS_NAME_OF_TYPE:	int	3Fh	;@0C678
	db	75h, 9	; jne L0C685	;@0C67A
	db	0, 0CDh	; add ch, cl	;@0C67C
	aas	;@0C67E
	db	36h	; or word ptr ss:[bx+si], ax	;@0C67F
Y0C630	ends

Y0C680	segment para public 'CODE'
	assume	cs:Y0C680
	db	9, 0, 0, 0, 0	;@0C680
L0C685:	add	byte ptr [bx+si], al	;@0C685
	add	byte ptr [bx+si], al	;@0C687
	add	byte ptr [bx+si], al	;@0C689
	add	byte ptr [bx+si], al	;@0C68B
	add	byte ptr [bx+si], al	;@0C68D
	db	0, 0CDh	; add ch, cl	;@0C68F
	aas	;@0C691
	add	byte ptr [bx+si], al	;@0C692
	push	ax	;@0C694
	clc	;@0C695
	add	word ptr [bx+si], ax	;@0C696
	jae	@@1	;@0C698
	fadd	dword ptr [bx+si]	;@0C69A
	push	es	;@0C69C
	add	byte ptr [bx+si], al	;@0C69D
	add	byte ptr [bx+si], al	;@0C69F
	add	byte ptr [bx+si], al	;@0C6A1
	add	byte ptr [bx+si], al	;@0C6A3
	add	byte ptr [bx+si], al	;@0C6A5
	add	byte ptr [bx+si], al	;@0C6A7
	add	byte ptr [bx+si], al	;@0C6A9
	add	byte ptr [bx+si], al	;@0C6AB
@@1:	add	byte ptr [bx+si], al	;@0C6AD
	db	0, 0CDh	; add ch, cl	;@0C6AF
	aas	;@0C6B1
	test	al, 12h	;@0C6B2
	db	0, 0CDh	; add ch, cl	;@0C6B4
	aas	;@0C6B6
	cbw	;@0C6B7
	adc	al, byte ptr [bx+si]	;@0C6B8
PARSE_ARGUMENT_LIST:	int	3Fh	;@0C6BA
	mov	ax, 12h	;@0C6BC
RESET_EXPR_PARSER:	db	0CDh	; int 3Fh	;@0C6BF
Y0C680	ends
	end

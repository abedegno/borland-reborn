; ANALYZE.ASM: TKINST's machine analysis, in assembler (the name of the file is
; descriptive). TKINST.C calls analyze() to find out how this machine switches A20 and
; returns from protected mode, and checkcpu() and bioschecksum(); it reads quiet, and
; switchtime and romname, which live here in DGROUP.
;
; Its own data is in four paragraph-aligned DATA segments in DGROUP: variables, the
; descriptor tables, a buffer, and the $-terminated messages. It runs its tests on its
; own stack (ANALYZE_STACK). Data names are descriptive or give the offset (v_XX); routines
; whose job is not clear are named by address.
	.286p
	locals
	public	_analyze, _checkcpu, _bioschecksum, _quiet, _switchtime, _romname
	extrn	_dbname:dword, _reporttime:word
DGROUP	group	ANALYZE_DATA, ANALYZE_GDT, ANALYZE_BUF, ANALYZE_MSG

ANALYZE_DATA	segment para public 'DATA'
v_00	db	0FFh
v_01	db	0FFh
v_02	db	0FFh
v_03	db	0, 0, 0, 0
v_07	db	0, 0
v_09	db	7 dup (0)
v_10	db	0FFh
v_11	db	0FFh
v_12	db	0FFh
v_13	db	0Dh dup (0)
v_20	db	0, 0
v_22	db	0, 0
v_24	db	0FFh
v_25	db	0FFh
v_26	db	0FFh
v_27	db	0FFh
v_28	db	0FFh
v_29	db	0FFh
v_2A	db	0FFh
v_2B	db	0FFh
v_2C	db	0FFh
v_2D	db	0FFh
v_2E	db	0FFh
v_2F	db	0FFh
v_30	db	0FFh
v_31	db	0FFh
v_32	db	0FFh
v_33	db	0FFh
v_34	db	0FFh
v_35	db	0FFh
v_36	db	0FFh
v_37	db	0FFh
v_38	db	0FFh
v_39	db	0FFh
v_3A	db	0, 0
v_3C	db	0, 0
v_3E	db	0, 0
v_40	db	0, 0
v_42	db	0, 0
v_44	db	0FFh
_switchtime	db	0, 0
v_47	db	0, 0
v_49	db	0Bh dup (0)
idtr	db	5 dup (0)
v_59	db	0, 0, 0, 51h, 0
_romname	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '  VCPI present '
v_BE	db	0, 0
v_C0	db	0, 0
v_C2	db	0, 0
v_C4	db	0, 0
v_C6	db	0, 0, 0
v_C9	db	0, 0
v_CB	db	0, 2
v_CD	db	50h, 0
v_CF	db	0, 0B8h
v_D1	db	0, 0, '__CFGCK.DAT', 0, 'EMMXXXX0', 0
v_E8	db	0, 0
dbptr	db	0, 0
v_EC	db	0, 0
dbcount	db	0, 0
v_F0	db	0FFh, 0FFh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ANALYZE_DATA	ends

ANALYZE_GDT	segment para public 'DATA'
	db	0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 7
	db	0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh
	db	0, 0, 0, 9Ah, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh
	db	0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh
	db	0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh
	db	0, 0, 0, 92h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
ANALYZE_GDT	ends

ANALYZE_BUF	segment para public 'DATA'
	db	800h dup (0)
ANALYZE_BUF	ends

ANALYZE_MSG	segment para public 'DATA'
m_restarting_after_checkpoin	db	'Restarting after checkpoint $'
m_01d	db	20h, 0Dh, 0Ah, 24h
m_known_machine_vectra	db	'  Known machine (VECTRA, PS/2)', 0Dh, 0Ah, 24h
m_error_cannot_checkpoint	db	'Error - cannot checkpoint with data on stack', 0Dh, 0Ah, 24h
m_cannot_find_method	db	'Cannot find method to enable A20', 0Dh, 0Ah, 24h
m_error_cannot_checkpoint2	db	'Error - cannot checkpoint with data on stack', 0Dh, 0Ah, 24h
m_cannot_find_method2	db	'Cannot find method to disable A20', 0Dh, 0Ah, 24h
m_error_cannot_checkpoint3	db	'Error - cannot checkpoint with data on stack', 0Dh, 0Ah, 24h
m_about_to_analyze	db	'  [about to analyze shut method]', 0Dh, 0Ah, 24h
m_error_cannot_checkpoint4	db	'Error - cannot checkpoint with data on stack', 0Dh, 0Ah, 24h
m_about_to_check	db	'  [about to check safety]', 0Dh, 0Ah, 24h
m_error_cannot_checkpoint5	db	'Error - cannot checkpoint with data on stack', 0Dh, 0Ah, 24h
m_about_to_time	db	'  [about to time switch]', 0Dh, 0Ah, 24h
m_error_cannot_checkpoint6	db	'Error - cannot checkpoint with data on stack', 0Dh, 0Ah, 24h
m_1fd	db	20h, 0Dh, 0Ah, 24h
m_tkinst_will_periodically	db	'  TKINST will periodically ask you to type a key in order', 0Dh
	db	0Ah, 24h
m_to_verify_that	db	'  to verify that your keyboard is still working.  If the', 0Dh
	db	0Ah, 24h
m_keyboard_appears_to	db	'  keyboard appears to be dead, please reboot the machine', 0Dh
	db	0Ah, 24h
m_and_run_tkinst	db	'  and run TKINST again.  A checkpoint file is used to', 0Dh, 0Ah
	db	24h
m_restart_tkinst_beyond	db	'  restart TKINST beyond the failing test.', 0Dh, 0Ah, 24h
m_317	db	20h, 0Dh, 0Ah, 24h
m_proceed_space_to	db	'  Proceed? (space to continue, control-C to quit): $'
m_proceeding	db	'  proceeding...', 0Dh, 0Ah, 24h
m_error_reading_checkpoint	db	'Error reading checkpoint file', 0Dh, 0Ah, 24h
m_error_reading_checkpoint2	db	'Error reading checkpoint file', 0Dh, 0Ah, 24h
m_error_creating_checkpoint	db	'Error creating checkpoint file', 0Dh, 0Ah, 24h
m_error_writing_checkpoint	db	'Error writing checkpoint file', 0Dh, 0Ah, 24h
m_error_writing_checkpoint2	db	'Error writing checkpoint file', 0Dh, 0Ah, 24h
m_a20_was_already	db	'A20 was already enabled, so test is meaningless', 0Dh, 0Ah, 24h
m_a20_enabled	db	'A20 enabled$'
m_a20_disabled_now	db	'A20 disabled now$'
m_cannot_enable_a20	db	'Cannot enable A20, so cannot test disable', 0Dh, 0Ah, 24h
m_unknown_a20_enable	db	'_UNKNOWN_ A20 Enable method requested', 0Dh, 0Ah, 24h
m_unknown_a20_disable	db	'_UNKNOWN_ A20 Disable method requested', 0Dh, 0Ah, 24h
m_please_press_the	db	', please press the space bar..$'
m_proceeding2	db	' proceeding...', 0Dh, 0Ah, 24h
m_please_press_the2	db	'Please press the space bar now..$'
m_proceeding3	db	' proceeding...', 0Dh, 0Ah, 24h
m_530	db	20h, 0Dh, 0Ah, 24h
m_can_t_analyze	db	'Can', 27h, 't analyze machine with VCPI present (use -v flag).'
	db	0Dh, 0Ah, 24h
m_56d	db	20h, 0Dh, 0Ah, 24h
m_tkinst_protected_mode	db	'TKINST: protected mode not possible on 8086/8088 machines', 0Dh
	db	0Ah, 24h
m_attempt_386_switch	db	'  [attempt 386 switch]', 0Dh, 0Ah, 24h
m_attempt_touchdown_switch	db	'  [attempt Touchdown switch]', 0Dh, 0Ah, 24h
m_attempt_code_9	db	'  [attempt code 9 switch]', 0Dh, 0Ah, 24h
m_attempt_code_a	db	'  [attempt code A switch]', 0Dh, 0Ah, 24h
m_press_and_hold	db	'Press and HOLD DOWN the space bar.. $'
m_proceeding4	db	'...proceeding', 0Dh, 0Ah, 24h
m_you_may_release	db	'You may release space bar', 0Dh, 0Ah, 24h
m_back_in_real	db	'Back in real mode$'
m_attempt_code_9p	db	'  [attempt code 9P switch]', 0Dh, 0Ah, 24h
m_about_to_enter	db	'  [about to enter protected mode]', 0Dh, 0Ah, 24h
m_back_in_real2	db	'  [back in real mode now]', 0Dh, 0Ah, 24h
m_back_in_real3	db	'Back in real mode$'
m_check_safety_across	db	'  [Check safety across switch to real mode]', 0Dh, 0Ah, 24h
m_checking_code_9	db	'  [Checking code 9 safety]', 0Dh, 0Ah, 24h
m_interrupts_were_enabled	db	'[Interrupts were enabled, 8259 needs to be disabled]', 0Dh, 0Ah
	db	24h
m_8259_save_required	db	'[8259 save required]', 0Dh, 0Ah, 24h
m_checking_code_a	db	'  [Checking code A safety]', 0Dh, 0Ah, 24h
m_interrupts_were_enabled2	db	'[Interrupts were enabled, 8259 needs to be disabled]', 0Dh, 0Ah
	db	24h
m_8259_save_required2	db	'[8259 save required]', 0Dh, 0Ah, 24h
m_checking_code_9p	db	'  [Checking code 9P safety]', 0Dh, 0Ah, 24h
m_interrupts_were_enabled3	db	'[Interrupts were enabled, 8259 needs to be disabled]', 0Dh, 0Ah
	db	24h
m_8259_save_required3	db	'[8259 save required]', 0Dh, 0Ah, 24h
m_check_save_8259	db	'  [check save 8259]', 0Dh, 0Ah, 24h
m_check_disable_8259	db	'  [check disable 8259]', 0Dh, 0Ah, 24h
m_check_save_npx	db	'  [check save NPX]', 0Dh, 0Ah, 24h
m_8a3	db	'................................$'
m_8c4	db	20h, 24h
m_8c6	db	20h, 24h
m_8c8	db	20h, 24h
m_8ca	db	20h, 24h
m_8cc	db	20h, 24h
m_8ce	db	20h, 24h
m_8d0	db	20h, 24h
m_8d2	db	20h, 24h
m_8d4	db	20h, 24h
m_8d6	db	20h, 24h
m_8d8	db	20h, 24h
m_8da	db	20h, 24h
m_8dc	db	20h, 24h
m_8de	db	20h, 24h
m_8e0	db	20h, 24h
m_8e2	db	20h, 24h
m_8e4	db	20h, 24h
m_8e6	db	20h, 24h
m_8e8	db	20h, 24h
m_8ea	db	20h, 24h
m_8ec	db	20h, 24h
m_8ee	db	20h, 24h
m_8f0	db	20h, 24h
m_8f2	db	20h, 24h
m_8f4	db	20h, 24h
m_8f6	db	20h, 24h
m_8f8	db	20h, 24h
m_8fa	db	20h, 24h
m_8fc	db	20h, 24h
m_8fe	db	20h, 24h
m_900	db	20h, 24h
m_902	db	20h, 24h
m_904	db	20h, 0Dh, 0Ah, 24h
m_timing_protected_real	db	'  [timing protected/real switch]', 0Dh, 0Ah, 24h
m_timing_code_9	db	'  [timing code 9]', 0Dh, 0Ah, 24h
m_timing_code_a	db	'  [timing code A]', 0Dh, 0Ah, 24h
m_timing_code_9p	db	'  [timing code 9P]', 0Dh, 0Ah, 24h
m_timing_code_touchdown	db	'  [timing code touchdown]', 0Dh, 0Ah, 24h
m_timing_protected_real2	db	'Timing protected/real switch.', 0Dh, 0Ah, 24h
m_timing_386_switch	db	'  [timing 386 switch]', 0Dh, 0Ah, 24h
m_9bc	db	20h, 0Dh, 0Ah, 24h
m_please_enter_comment	db	'Please enter comment for database file:', 0Dh, 0Ah, 24h
m_9ea	db	20h, 0Dh, 0Ah, 24h
m_9ee	db	20h, 0Dh, 0Ah, 24h
m_this_machine_is	db	'  This machine is running an expanded memory manager', 0Dh, 0Ah
	db	24h
m_that_supports_the	db	'  that supports the Virtual Control Program Interface.', 0Dh
	db	0Ah, 24h
m_as_long_as	db	'  As long as that program (QEMM, 386max) remains in', 0Dh, 0Ah
	db	24h
m_the_system_you	db	'  the system, you do not need to configure TKERNEL.', 0Dh, 0Ah
	db	24h
m_ace	db	20h, 0Dh, 0Ah, 24h
m_this_machine_is2	db	'  This machine is running an expanded memory manager', 0Dh, 0Ah
	db	24h
m_that_does_not	db	'  that does not support the Virtual Control Program', 0Dh, 0Ah
	db	24h
m_interface_tkernel_cannot	db	'  Interface.  TKERNEL cannot be run out of', 0Dh, 0Ah, 24h
m_extended_memory_while	db	'  extended memory while this driver is active. You', 0Dh, 0Ah
	db	24h
m_must_remove_the	db	'  must remove the expanded memory manager from your', 0Dh, 0Ah
	db	24h
m_config_sys_file	db	'  config.sys file and then reboot in order to use the', 0Dh, 0Ah
	db	24h
m_protected_mode_kernels	db	'  protected mode kernels.', 0Dh, 0Ah, 24h
m_c2b	db	20h, 0Dh, 0Ah, 24h
ANALYZE_MSG	ends

ANALYZE_STACK	segment para public 'STACK'
	db	200h dup (?)
ANALYZE_STACK	ends

ANALYZE_TEXT	segment para public 'CODE'
	assume	ds:ANALYZE_DATA
	assume	cs:ANALYZE_TEXT

; int analyze(unsigned char far *entry, unsigned char far *db, int count)
; Works out this machine's characteristics (how to switch A20, how to get back from
; protected mode, whether that is safe) and fills in *entry. With count 0 it only
; analyzes; otherwise it looks for the machine in db first. Returns 0 when it filled in
; entry, 1 when the machine is already in db, 2 to stop quietly, and -1 when the
; analysis was inconclusive.
; It runs on its own stack and writes a checkpoint file between tests, so that a test
; that hangs the machine is skipped when TKINST is run again.
_analyze:	push	bp
	mov	bp, sp
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	push	es
	push	ds
	mov	word ptr cs:savess, ss
	mov	word ptr cs:savesp, sp
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, word ptr [bp+0Ch]
	mov	word ptr v_EC, ax
	mov	ax, word ptr [bp+0Ah]
	mov	word ptr dbptr, ax
	mov	ax, word ptr [bp+0Eh]
	mov	word ptr dbcount, ax
	cli
	mov	ax, ANALYZE_STACK
	mov	ss, ax
	mov	sp, 200h
	sti
	call	setupgdt
	call	readcheckpoint
	call	get8259
	mov	word ptr v_D1, bx
	mov	ax, word ptr v_20
	cmp	ax, 0
	je	@@1
	push	cx
	push	dx
	mov	dx, offset m_restarting_after_checkpoin
	call	print
	pop	dx
	mov	cx, ax
	call	printnum
	push	dx
	mov	dx, offset m_01d
	call	print
	pop	dx
	pop	cx
	call	pressspace2
@@1:	cmp	word ptr v_22, 0
	je	@@2
	jmp	word ptr v_22
@@2:	mov	ax, ANALYZE_DATA
	mov	es, ax
	mov	di, 0
	call	romsum
	mov	word ptr v_07, dx
	mov	word ptr v_09, bx
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	findentry
	jae	@@3
	push	ds
	push	si
	mov	ax, seg _dbname
	mov	ds, ax
	mov	si, offset _dbname
	xor	ax, ax
	mov	word ptr [si], ax
	mov	word ptr [si+2], ax
	pop	si
	pop	ds
	mov	word ptr cs:cleared, 1
	jmp	@@32
@@3:	call	L04101
	cmp	ah, 0
	jne	@@4
	call	vcpimsg
	push	ds
	push	ds
	pop	es
	lds	si, dword ptr [bp+6]
	mov	di, 0
	mov	cx, 10h
	cld
	rep movsb
	pop	ds
	mov	word ptr cs:cleared, 2
	jmp	@@32
@@4:	smsw	ax
	test	ax, 1
	je	@@5
	call	emsmsg
	mov	word ptr cs:cleared, 2
	jmp	@@32
@@5:	call	L04058
	jae	@@6
	push	dx
	mov	dx, offset m_known_machine_vectra
	call	print
	pop	dx
	mov	word ptr cs:cleared, 0
	jmp	@@32
@@6:	call	warnuser
	call	getcomment
	call	L050B6
	cmp	byte ptr v_00, 0FFh
	jne	@@9
	cmp	sp, 200h
	je	@@7
	push	dx
	mov	dx, offset m_error_cannot_checkpoint
	call	print
	pop	dx
	jmp	@@8
@@7:	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, 134h
	mov	word ptr v_22, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@8:	call	findenable
@@9:	mov	al, byte ptr v_00
	cmp	al, 0FFh
	jne	@@10
	push	dx
	mov	dx, offset m_cannot_find_method
	call	print
	pop	dx
	jmp	@@33
@@10:	mov	byte ptr v_10, al
	cmp	byte ptr v_01, 0FFh
	jne	@@13
	cmp	sp, 200h
	je	@@11
	push	dx
	mov	dx, offset m_error_cannot_checkpoint2
	call	print
	pop	dx
	jmp	@@12
@@11:	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, 176h
	mov	word ptr v_22, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@12:	call	finddisable
@@13:	mov	al, byte ptr v_01
	cmp	al, 0FFh
	jne	@@14
	push	dx
	mov	dx, offset m_cannot_find_method2
	call	print
	pop	dx
	jmp	@@33
@@14:	mov	byte ptr v_11, al
	cmp	byte ptr v_02, 0FFh
	je	@@15
	jmp	@@26
@@15:	cmp	sp, 200h
	je	@@16
	push	dx
	mov	dx, offset m_error_cannot_checkpoint3
	call	print
	pop	dx
	jmp	@@17
@@16:	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, 1BBh
	mov	word ptr v_22, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@17:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@18
	push	dx
	mov	dx, offset m_about_to_analyze
	call	print
	pop	dx
@@18:	popf
	call	switchtests
	jae	@@19
	jmp	@@26
@@19:	cmp	sp, 200h
	je	@@20
	push	dx
	mov	dx, offset m_error_cannot_checkpoint4
	call	print
	pop	dx
	jmp	@@21
@@20:	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, 1F8h
	mov	word ptr v_22, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@21:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@22
	push	dx
	mov	dx, offset m_about_to_check
	call	print
	pop	dx
@@22:	popf
	call	checksafety
	jb	@@26
	cmp	sp, 200h
	je	@@23
	push	dx
	mov	dx, offset m_error_cannot_checkpoint5
	call	print
	pop	dx
	jmp	@@24
@@23:	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, 232h
	mov	word ptr v_22, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@24:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@25
	push	dx
	mov	dx, offset m_about_to_time
	call	print
	pop	dx
@@25:	popf
	call	timeswitch
	jb	@@26
	call	L043D7
@@26:	cmp	sp, 200h
	je	@@27
	push	dx
	mov	dx, offset m_error_cannot_checkpoint6
	call	print
	pop	dx
	jmp	@@28
@@27:	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, 26Fh
	mov	word ptr v_22, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@28:	cmp	byte ptr v_00, 0FFh
	jne	@@29
	jmp	@@33
@@29:	cmp	byte ptr v_01, 0FFh
	jne	@@30
	jmp	@@33
@@30:	cmp	byte ptr v_02, 0FFh
	jne	@@31
	jmp	@@33
@@31:	mov	word ptr cs:cleared, 0
@@32:	mov	bx, word ptr v_D1
	call	set8259
	cli
	mov	ss, word ptr cs:savess
	mov	sp, word ptr cs:savesp
	sti
	les	di, dword ptr [bp+6]
	mov	si, 0
	mov	cx, 10h
	cld
	rep movsb
	mov	ax, word ptr cs:cleared
	pop	ds
	pop	es
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	bp
	retf
@@33:	mov	word ptr cs:cleared, 0FFFFh
	jmp	@@32
savess:	add	byte ptr [bx+si], al
savesp:	add	byte ptr [bx+si], al
cleared:	add	byte ptr [bx+si], al
_quiet:	add	byte ptr [bx+si], al

; the ROM checksum in DX:BX
romsum:	push	ax
	push	cx
	push	ds
	push	si
	mov	cx, 4000h
	mov	ax, 0F000h
	mov	ds, ax
	mov	si, 8000h
	xor	bx, bx
	xor	dx, dx
	cld
@@1:	lodsw
	rol	dx, 1
	rcl	bx, 1
	add	dx, ax
	adc	bx, 0
	loop	@@1
	pop	si
	pop	ds
	pop	cx
	pop	ax
	ret

; explains the key presses and asks to proceed
warnuser:	push	dx
	mov	dx, offset m_1fd
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_tkinst_will_periodically
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_to_verify_that
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_keyboard_appears_to
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_and_run_tkinst
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_restart_tkinst_beyond
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_317
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_proceed_space_to
	call	print
	pop	dx
	call	getkey
	push	dx
	mov	dx, offset m_proceeding
	call	print
	pop	dx
	ret
L04022:	mov	ah, 4Ch
	int	21h
findentry:	push	ax
	push	cx
	push	ds
	push	si
	mov	cx, word ptr dbcount
	jcxz	@@3
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	lds	si, dword ptr dbptr
@@1:	cmp	word ptr [si+7], dx
	jne	@@2
	cmp	word ptr [si+9], bx
	jne	@@2
	mov	cx, 10h
	cld
	rep movsb
	stc
	jmp	@@4
@@2:	add	si, 10h
	loop	@@1
@@3:	clc
@@4:	pop	si
	pop	ds
	pop	cx
	pop	ax
	ret
L04058:	call	L04156
	jae	@@3
	mov	byte ptr es:[di], 3
	mov	byte ptr es:[di+1], 3
	call	is286
	jae	@@1
	mov	byte ptr es:[di+2], 4
	jmp	@@2
@@1:	mov	byte ptr es:[di+2], 2
@@2:	jmp	@@6
@@3:	call	L04184
	jae	@@4
	mov	byte ptr es:[di], 2
	mov	byte ptr es:[di+1], 2
	mov	byte ptr es:[di+2], 3
	or	word ptr es:[di+5], 8
	jmp	@@8
@@4:	call	L04160
	jae	@@5
	mov	byte ptr es:[di], 1
	mov	byte ptr es:[di+1], 1
	mov	byte ptr es:[di+2], 3
	jmp	@@8
@@5:	clc
	jmp	@@7
@@6:	call	romsum
	mov	word ptr es:[di+7], dx
	mov	word ptr es:[di+9], bx
	stc
@@7:	ret
@@8:	call	is286
	jae	@@9
	mov	byte ptr es:[di+2], 4
@@9:	stc
	jmp	@@6

; int checkcpu(void): 0 on an 8086 or 8088 (no protected mode)
_checkcpu:	call	is286
	jae	@@1
	mov	ax, 1
	jmp	@@2
@@1:	mov	ax, 0
@@2:	retf

; carry set on an 8086/8088: SIDT stores a limit whose top byte is FFh there
is286:	push	ax
	sidt	fword ptr idtr
	mov	al, byte ptr v_59
	cbw
	cmp	ax, 0
	jne	@@1
	jmp	short @@2
	jmp	@@2
@@1:	jmp	short @@3
@@2:	stc
	jmp	short @@4
@@3:	clc
@@4:	pop	ax
	ret
L040F5:	push	sp
	pop	ax
	cmp	ax, sp
	je	@@1
	stc
	jmp	@@2
@@1:	clc
@@2:	ret
L04101:	push	bx
	push	cx
	push	dx
	push	es
	mov	dx, 0DFh
	xor	al, al
	xor	bx, bx
	mov	ah, 3Dh
	int	21h
	jae	@@1
	mov	ah, 0FFh
	jmp	@@2
@@1:	mov	bx, ax
	mov	al, 0
	mov	ah, 44h
	int	21h
	jb	@@3
	test	dx, 80h
	je	@@3
	mov	ah, 3Eh
	int	21h
	mov	al, 67h
	mov	ah, 35h
	int	21h
	mov	ax, es
	or	ax, bx
	je	@@3
	mov	ah, 43h
	mov	bx, 1
	int	67h
	mov	ax, 0DE00h
	int	67h
	push	ax
	mov	ah, 45h
	int	67h
	pop	ax
@@2:	pop	es
	pop	dx
	pop	cx
	pop	bx
	ret
@@3:	mov	ah, 3Eh
	int	21h
	mov	ah, 0FFh
	jmp	@@2
L04156:	push	ax
	mov	ax, 0C300h
	stc
	int	15h
	cmc
	pop	ax
	ret
L04160:	push	es
	push	ax
	mov	ax, 0F000h
	mov	es, ax
	mov	ax, word ptr es:[0F8h]
	cmp	ax, 5048h
	je	@@1
	clc
	jmp	@@3
@@1:	mov	al, byte ptr es:[63h]
	cmp	al, 41h
	jbe	@@2
	stc
	jmp	@@3
@@2:	clc
@@3:	pop	ax
	pop	es
	ret
L04184:	push	es
	push	ax
	mov	ax, 0F000h
	mov	es, ax
	mov	ax, word ptr es:[0F8h]
	cmp	ax, 5048h
	je	@@1
	clc
	jmp	@@3
@@1:	mov	al, byte ptr es:[63h]
	cmp	al, 41h
	jne	@@2
	stc
	jmp	@@3
@@2:	clc
@@3:	pop	ax
	pop	es
	ret

; reads __CFGCK.DAT, if a previous run left one
readcheckpoint:	push	bx
	push	cx
	push	dx
	mov	ax, 3D00h
	mov	dx, 0D3h
	int	21h
	jae	@@1
	jmp	@@5
@@1:	mov	bx, ax
	push	bx
	mov	ah, 3Fh
	mov	cx, 0C9h
	mov	dx, offset m_restarting_after_checkpoin
	int	21h
	jae	@@2
	push	dx
	mov	dx, offset m_error_reading_checkpoint
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@2:	cmp	ax, cx
	je	@@3
	push	dx
	mov	dx, offset m_error_reading_checkpoint2
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@3:	pop	bx
	mov	ah, 3Eh
	int	21h
	call	romsum
	cmp	bx, word ptr v_09
	je	@@4
	mov	word ptr v_22, 0
@@4:	cmp	dx, word ptr v_07
	je	@@5
	mov	word ptr v_22, 0
@@5:	pop	dx
	pop	cx
	pop	bx
	ret

; writes __CFGCK.DAT before a risky test
writecheckpoint:	push	bx
	push	cx
	push	dx
	inc	word ptr v_20
	mov	ah, 3Ch
	xor	cx, cx
	mov	dx, 0D3h
	int	21h
	jae	@@1
	push	dx
	mov	dx, offset m_error_creating_checkpoint
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@1:	mov	bx, ax
	mov	ah, 40h
	mov	cx, 0C9h
	mov	dx, offset m_restarting_after_checkpoin
	int	21h
	jae	@@2
	push	dx
	mov	dx, offset m_error_writing_checkpoint
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@2:	cmp	ax, cx
	je	@@3
	push	dx
	mov	dx, offset m_error_writing_checkpoint2
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@3:	mov	ah, 3Eh
	int	21h
	pop	dx
	pop	cx
	pop	bx
	ret
findenable:	cmp	byte ptr v_2A, 0FFh
	jne	@@1
	mov	byte ptr v_2A, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_10, 2
	call	testenable
	jae	@@1
	mov	byte ptr v_2A, 1
	mov	byte ptr v_00, 2
	jmp	@@4
@@1:	cmp	byte ptr v_29, 0FFh
	jne	@@2
	mov	byte ptr v_29, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_10, 1
	call	testenable
	jae	@@2
	mov	byte ptr v_29, 1
	mov	byte ptr v_00, 1
	jmp	@@4
@@2:	cmp	byte ptr v_2B, 0FFh
	jne	@@3
	mov	byte ptr v_2B, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_10, 3
	call	testenable
	jae	@@3
	mov	byte ptr v_2B, 1
	mov	byte ptr v_00, 3
	jmp	@@4
@@3:	cmp	byte ptr v_2C, 0FFh
	jne	@@4
	mov	byte ptr v_2C, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_10, 4
	call	testenable
	jae	@@4
	mov	byte ptr v_2C, 1
	mov	byte ptr v_00, 4
	jmp	@@4
@@4:	ret
finddisable:	cmp	byte ptr v_2E, 0FFh
	jne	@@1
	mov	byte ptr v_2E, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_11, 2
	call	testdisable
	jae	@@1
	mov	byte ptr v_2E, 1
	mov	byte ptr v_01, 2
	jmp	@@4
@@1:	cmp	byte ptr v_2D, 0FFh
	jne	@@2
	mov	byte ptr v_2D, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_11, 1
	call	testdisable
	jae	@@2
	mov	byte ptr v_2D, 1
	mov	byte ptr v_01, 1
	jmp	@@4
@@2:	cmp	byte ptr v_2F, 0FFh
	jne	@@3
	mov	byte ptr v_2F, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_11, 3
	call	testdisable
	jae	@@3
	mov	byte ptr v_2F, 1
	mov	byte ptr v_01, 3
	jmp	@@4
@@3:	cmp	byte ptr v_30, 0FFh
	jne	@@4
	mov	byte ptr v_30, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	mov	byte ptr v_11, 4
	call	testdisable
	jae	@@4
	mov	byte ptr v_30, 1
	mov	byte ptr v_01, 4
	jmp	@@4
@@4:	ret
	ret
L043D7:	mov	byte ptr v_44, 0FFh
	mov	word ptr _switchtime, 0FFFFh
	cmp	byte ptr v_25, 1
	jne	@@1
	mov	byte ptr v_44, 2
	mov	ax, word ptr v_3A
	mov	word ptr _switchtime, ax
@@1:	cmp	byte ptr v_24, 1
	jne	@@2
	mov	ax, word ptr v_3C
	cmp	ax, word ptr _switchtime
	jae	@@2
	mov	byte ptr v_44, 1
	mov	word ptr _switchtime, ax
@@2:	cmp	byte ptr v_26, 1
	jne	@@3
	mov	ax, word ptr v_3E
	cmp	ax, word ptr _switchtime
	jae	@@3
	mov	byte ptr v_44, 3
	mov	word ptr _switchtime, ax
@@3:	cmp	byte ptr v_28, 1
	jne	@@4
	mov	byte ptr v_44, 4
@@4:	mov	al, byte ptr v_44
	cmp	al, 2
	jne	@@8
	mov	byte ptr v_02, 2
	cmp	byte ptr v_35, 1
	jne	@@5
	or	word ptr v_03, 4
@@5:	cmp	byte ptr v_34, 1
	jne	@@6
	or	word ptr v_03, 2
@@6:	cmp	byte ptr v_36, 1
	jne	@@7
	or	word ptr v_03, 8
@@7:	jmp	@@18
@@8:	cmp	al, 1
	jne	@@12
	mov	byte ptr v_02, 1
	cmp	byte ptr v_32, 1
	jne	@@9
	or	word ptr v_03, 4
@@9:	cmp	byte ptr v_31, 1
	jne	@@10
	or	word ptr v_03, 2
@@10:	cmp	byte ptr v_33, 1
	jne	@@11
	or	word ptr v_03, 8
@@11:	jmp	@@18
@@12:	cmp	al, 3
	jne	@@16
	mov	byte ptr v_02, 3
	cmp	byte ptr v_38, 1
	jne	@@13
	or	word ptr v_03, 4
@@13:	cmp	byte ptr v_37, 1
	jne	@@14
	or	word ptr v_03, 2
@@14:	cmp	byte ptr v_39, 1
	jne	@@15
	or	word ptr v_03, 8
@@15:	jmp	@@18
@@16:	cmp	al, 4
	jne	@@17
	mov	ax, word ptr v_42
	mov	word ptr _switchtime, ax
	mov	byte ptr v_02, 4
	jmp	@@18
@@17:	mov	byte ptr v_02, 0FFh
@@18:	ret
testenable:	call	L04685
	jae	@@1
	push	dx
	mov	dx, offset m_a20_was_already
	call	print
	pop	dx
	jmp	@@2
@@1:	call	doenable
	jae	@@2
	push	dx
	mov	dx, offset m_a20_enabled
	call	print
	pop	dx
	call	pressspace
	jmp	@@3
@@2:	clc
	jmp	short @@4
@@3:	stc
@@4:	ret
testdisable:	call	enablea20
	call	dodisable
	jae	@@1
	push	dx
	mov	dx, offset m_a20_disabled_now
	call	print
	pop	dx
	call	pressspace
	jmp	@@2
@@1:	clc
	jmp	short @@3
@@2:	stc
@@3:	ret
enablea20:	push	ax
	call	L04685
	jae	@@1
	jmp	@@2
@@1:	mov	al, byte ptr v_00
	mov	byte ptr v_10, al
	call	doenable
	jb	@@2
	push	dx
	mov	dx, offset m_cannot_enable_a20
	call	print
	pop	dx
	jmp	short @@3
@@2:	clc
	jmp	short @@4
@@3:	stc
@@4:	pop	ax
	ret
doenable:	push	ax
	push	bx
	push	cx
	push	dx
	pushf
	cli
	mov	al, byte ptr v_10
	cmp	al, 1
	jne	@@1
	mov	al, 1
	mov	ah, 0DFh
	call	kbca20
	jmp	@@8
@@1:	cmp	al, 2
	jne	@@2
	mov	al, 0
	mov	ah, 0DFh
	call	kbca20
	jmp	@@8
@@2:	cmp	al, 3
	jne	@@6
	in	al, 92h
	jmp	@@3
@@3:	jmp	@@4
@@4:	jmp	@@5
@@5:	or	al, 2
	out	92h, al
	jmp	@@8
@@6:	cmp	al, 4
	jne	@@7
	mov	al, 0
	out	0F2h, al
	jmp	@@8
@@7:	push	dx
	mov	dx, offset m_unknown_a20_enable
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@8:	xor	bx, bx
@@9:	call	L04685
	jb	@@11
	dec	bx
	cmp	bx, 0
	jne	@@10
	jmp	@@12
	jmp	@@11
@@10:	jmp	@@9
@@11:	popf
	stc
	jmp	@@13
@@12:	popf
	clc
@@13:	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
dodisable:	push	ax
	push	bx
	push	cx
	push	dx
	pushf
	cli
	mov	al, byte ptr v_11
	cmp	al, 2
	jne	@@1
	mov	al, 0
	mov	ah, 0DDh
	call	kbca20
	jmp	@@9
@@1:	cmp	al, 1
	jne	@@2
	mov	al, 1
	mov	ah, 0DDh
	call	kbca20
	jmp	@@9
@@2:	cmp	al, 3
	jne	@@6
	in	al, 92h
	jmp	@@3
@@3:	jmp	@@4
@@4:	jmp	@@5
@@5:	and	al, 0FDh
	out	92h, al
	jmp	@@9
@@6:	cmp	al, 4
	jne	@@7
	jmp	@@9
@@7:	cmp	al, 7
	jne	@@8
	jmp	@@9
@@8:	push	dx
	mov	dx, offset m_unknown_a20_disable
	call	print
	pop	dx
	mov	al, 1
	call	L04022
@@9:	xor	bx, bx
@@10:	call	L04685
	jae	@@12
	dec	bx
	cmp	bx, 0
	jne	@@11
	jmp	@@13
	jmp	@@12
@@11:	jmp	@@10
@@12:	popf
	stc
	jmp	@@14
@@13:	popf
	clc
@@14:	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; switches A20 through the keyboard controller (8042)
kbca20:	push	ax
	push	bx
	mov	bx, ax
	call	@@11
	jne	@@10
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	jmp	@@4
@@4:	jmp	@@5
@@5:	jmp	@@6
@@6:	mov	al, 0D1h
	out	64h, al
	call	@@11
	jne	@@10
	jmp	@@7
@@7:	jmp	@@8
@@8:	jmp	@@9
@@9:	mov	al, ah
	out	60h, al
	call	@@11
	jne	@@10
	cmp	bl, 1
	jne	@@10
	mov	al, 0FFh
	out	64h, al
	call	@@11
@@10:	pop	bx
	pop	ax
	ret
@@11:	push	cx
	xor	cx, cx
@@12:	in	al, 64h
	test	al, 2
	loopne	@@12
	pop	cx
	ret
L0467D:	and	byte ptr [bx+si], al
	add	byte ptr [bx+si], al
L04681:	xor	byte ptr [bx+si], al
	db	0FFh
	db	0FFh
L04685:	push	ds
	push	es
	push	cx
	push	si
	push	di
	lds	si, dword ptr cs:L0467D
	les	di, dword ptr cs:L04681
	mov	cx, 8
	cld
	repe cmpsw
	jcxz	@@1
	stc
	jmp	short @@2
@@1:	clc
@@2:	pop	di
	pop	si
	pop	cx
	pop	es
	pop	ds
	ret
pressspace:	push	dx
	mov	dx, offset m_please_press_the
	call	print
	pop	dx
	call	getkey
	push	dx
	mov	dx, offset m_proceeding2
	call	print
	pop	dx
	ret
pressspace2:	push	dx
	mov	dx, offset m_please_press_the2
	call	print
	pop	dx
	call	getkey
	push	dx
	mov	dx, offset m_proceeding3
	call	print
	pop	dx
	ret
getkey:	push	ax
	mov	ax, 0C01h
	int	21h
	pop	ax
	ret
switchtests:	push	ax
	push	bx
	push	cx
	push	dx
	push	es
	push	ds
	push	si
	push	di
	call	L04101
	cmp	ah, 0
	jne	@@2
	cmp	word ptr v_E8, 0
	je	@@1
	mov	byte ptr v_28, 1
	mov	byte ptr v_24, 0
	mov	byte ptr v_26, 0
	mov	byte ptr v_25, 0
	jmp	@@16
	jmp	@@2
@@1:	push	dx
	mov	dx, offset m_530
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_can_t_analyze
	call	print
	pop	dx
	jmp	@@18
@@2:	call	L040F5
	jae	@@3
	push	dx
	mov	dx, offset m_56d
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_tkinst_protected_mode
	call	print
	pop	dx
	mov	al, 1
	jmp	L04022
@@3:	call	is286
	jae	@@5
	mov	byte ptr v_12, 4
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@4
	push	dx
	mov	dx, offset m_attempt_386_switch
	call	print
	pop	dx
@@4:	popf
	call	@@19
	mov	byte ptr v_28, 1
	mov	byte ptr v_24, 0
	mov	byte ptr v_26, 0
	mov	byte ptr v_25, 0
@@5:	cmp	byte ptr v_49, 1
	jne	@@7
	mov	byte ptr v_12, 5
	mov	word ptr v_13, 0
	mov	byte ptr v_27, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@6
	push	dx
	mov	dx, offset m_attempt_touchdown_switch
	call	print
	pop	dx
@@6:	popf
	call	@@19
	mov	byte ptr v_27, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@7:	cmp	byte ptr v_24, 0FFh
	jne	@@9
	mov	byte ptr v_12, 1
	mov	word ptr v_13, 6
	mov	byte ptr v_24, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@8
	push	dx
	mov	dx, offset m_attempt_code_9
	call	print
	pop	dx
@@8:	popf
	call	@@19
	mov	byte ptr v_24, 1
	mov	byte ptr v_26, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@9:	cmp	byte ptr v_25, 0FFh
	je	@@10
	jmp	@@14
@@10:	mov	byte ptr v_12, 2
	mov	word ptr v_13, 6
	mov	byte ptr v_25, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@11
	push	dx
	mov	dx, offset m_attempt_code_a
	call	print
	pop	dx
@@11:	popf
	call	@@19
	push	dx
	mov	dx, offset m_press_and_hold
	call	print
	pop	dx
	call	getkey
	push	dx
	mov	dx, offset m_proceeding4
	call	print
	pop	dx
	mov	byte ptr v_12, 2
	mov	word ptr v_13, 6
	mov	cx, 4000h
	call	L05082
	push	dx
	mov	dx, offset m_you_may_release
	call	print
	pop	dx
	push	cx
	push	dx
	mov	dx, 14h
@@12:	xor	cx, cx
@@13:	loop	@@13
	dec	dx
	ja	@@12
	pop	dx
	pop	cx
	push	dx
	mov	dx, offset m_back_in_real
	call	print
	pop	dx
	call	pressspace
	mov	byte ptr v_25, 1
	mov	byte ptr v_26, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@14:	cmp	byte ptr v_26, 0FFh
	jne	@@16
	mov	byte ptr v_12, 3
	mov	word ptr v_13, 6
	mov	byte ptr v_26, 0
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@15
	push	dx
	mov	dx, offset m_attempt_code_9p
	call	print
	pop	dx
@@15:	popf
	call	@@19
	mov	byte ptr v_26, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
@@16:	clc
@@17:	pop	di
	pop	si
	pop	ds
	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
@@18:	stc
	jmp	@@17
@@19:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@20
	push	dx
	mov	dx, offset m_about_to_enter
	call	print
	pop	dx
@@20:	popf
	mov	cx, 1
	call	L05082
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@21
	push	dx
	mov	dx, offset m_back_in_real2
	call	print
	pop	dx
@@21:	popf
	push	dx
	mov	dx, offset m_back_in_real3
	call	print
	pop	dx
	call	pressspace
	ret

; builds the descriptor tables for the switch tests
setupgdt:	push	es
	push	ax
	mov	ax, ANALYZE_GDT
	mov	es, ax
	mov	ax, ANALYZE_GDT
	shl	ax, 4
	mov	word ptr es:[0Ah], ax
	mov	ax, ANALYZE_GDT
	shr	ax, 0Ch
	mov	byte ptr es:[0Ch], al
	mov	ax, ANALYZE_BUF
	shl	ax, 4
	mov	word ptr es:[12h], ax
	mov	ax, ANALYZE_BUF
	shr	ax, 0Ch
	mov	byte ptr es:[14h], al
	mov	ax, ANALYZE_STACK
	shl	ax, 4
	mov	word ptr es:[1Ah], ax
	mov	ax, ANALYZE_STACK
	shr	ax, 0Ch
	mov	byte ptr es:[1Ch], al
	mov	ax, ANALYZE_TEXT
	shl	ax, 4
	mov	word ptr es:[22h], ax
	mov	ax, ANALYZE_TEXT
	shr	ax, 0Ch
	mov	byte ptr es:[24h], al
	mov	ax, ANALYZE_TEXT
	shl	ax, 4
	mov	word ptr es:[2Ah], ax
	mov	ax, ANALYZE_TEXT
	shr	ax, 0Ch
	mov	byte ptr es:[2Ch], al
	mov	ax, ANALYZE_DATA
	shl	ax, 4
	mov	word ptr es:[32h], ax
	mov	ax, ANALYZE_DATA
	shr	ax, 0Ch
	mov	byte ptr es:[34h], al
	mov	ax, 0
	shl	ax, 4
	mov	word ptr es:[3Ah], ax
	mov	ax, 0
	shr	ax, 0Ch
	mov	byte ptr es:[3Ch], al
	mov	ax, 0F000h
	shl	ax, 4
	mov	word ptr es:[42h], ax
	mov	ax, 0F000h
	shr	ax, 0Ch
	mov	byte ptr es:[44h], al
	mov	ax, 7000h
	shl	ax, 4
	mov	word ptr es:[4Ah], ax
	mov	ax, 7000h
	shr	ax, 0Ch
	mov	byte ptr es:[4Ch], al
	pop	ax
	pop	es
	ret

; enters protected mode (LMSW) and comes back
protmode:	cli
	mov	ax, ANALYZE_GDT
	mov	es, ax
	mov	bx, 8
	lgdt	fword ptr es:[bx]
	mov	bx, 10h
	lidt	fword ptr es:[bx]
	mov	ax, 3
	lmsw	ax
	db	0EAh			; jmp far ptr 20h:the next instruction (selector 20h is this code)
	dw	$+4, 20h
	mov	ax, 18h
	mov	ss, ax
	nop
	mov	ax, 30h
	mov	ds, ax
	mov	ax, 30h
	mov	es, ax
	ret
checksafety:	push	ax
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@1
	push	dx
	mov	dx, offset m_check_safety_across
	call	print
	pop	dx
@@1:	popf
	cmp	byte ptr v_24, 1
	je	@@2
	jmp	@@9
@@2:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@3
	push	dx
	mov	dx, offset m_checking_code_9
	call	print
	pop	dx
@@3:	popf
	mov	byte ptr v_12, 1
	cmp	byte ptr v_32, 0FFh
	jne	@@6
	mov	byte ptr v_32, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	@@34
	cmp	al, 1
	jne	@@5
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@4
	push	dx
	mov	dx, offset m_interrupts_were_enabled
	call	print
	pop	dx
@@4:	popf
	mov	byte ptr v_31, 1
@@5:	mov	byte ptr v_32, al
@@6:	cmp	byte ptr v_31, 0FFh
	jne	@@8
	mov	byte ptr v_31, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	@@26
	mov	byte ptr v_31, al
	cmp	al, 1
	jne	@@8
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@7
	push	dx
	mov	dx, offset m_8259_save_required
	call	print
	pop	dx
@@7:	popf
@@8:	mov	byte ptr v_33, 0
	call	@@39
	mov	byte ptr v_33, al
@@9:	cmp	byte ptr v_25, 1
	je	@@10
	jmp	@@17
@@10:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@11
	push	dx
	mov	dx, offset m_checking_code_a
	call	print
	pop	dx
@@11:	popf
	mov	byte ptr v_12, 2
	cmp	byte ptr v_35, 0FFh
	jne	@@14
	mov	byte ptr v_35, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	@@34
	cmp	al, 1
	jne	@@13
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@12
	push	dx
	mov	dx, offset m_interrupts_were_enabled2
	call	print
	pop	dx
@@12:	popf
	mov	byte ptr v_31, 1
@@13:	mov	byte ptr v_35, al
@@14:	cmp	byte ptr v_34, 0FFh
	jne	@@16
	mov	byte ptr v_34, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	@@26
	mov	byte ptr v_34, al
	cmp	al, 1
	jne	@@16
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@15
	push	dx
	mov	dx, offset m_8259_save_required2
	call	print
	pop	dx
@@15:	popf
@@16:	mov	byte ptr v_36, 0
	call	@@39
	mov	byte ptr v_36, al
@@17:	cmp	byte ptr v_26, 1
	je	@@18
	jmp	@@25
@@18:	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@19
	push	dx
	mov	dx, offset m_checking_code_9p
	call	print
	pop	dx
@@19:	popf
	mov	byte ptr v_12, 3
	cmp	byte ptr v_38, 0FFh
	jne	@@22
	mov	byte ptr v_38, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	@@34
	cmp	al, 1
	jne	@@21
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@20
	push	dx
	mov	dx, offset m_interrupts_were_enabled3
	call	print
	pop	dx
@@20:	popf
	mov	byte ptr v_31, 1
@@21:	mov	byte ptr v_38, al
@@22:	cmp	byte ptr v_37, 0FFh
	jne	@@24
	mov	byte ptr v_37, 1
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	call	writecheckpoint
	pop	ds
	pop	ax
	call	@@26
	mov	byte ptr v_37, al
	cmp	al, 1
	jne	@@24
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@23
	push	dx
	mov	dx, offset m_8259_save_required3
	call	print
	pop	dx
@@23:	popf
@@24:	mov	byte ptr v_39, 0
	call	@@39
	mov	byte ptr v_39, al
@@25:	clc
	pop	ax
	ret
@@26:	push	bx
	push	cx
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@27
	push	dx
	mov	dx, offset m_check_save_8259
	call	print
	pop	dx
@@27:	popf
	mov	al, 0
	call	get8259
	call	@@31
	jae	@@28
	mov	al, 1
@@28:	cmp	al, 0
	jne	@@29
	xor	bx, bx
	call	@@31
	jae	@@29
	mov	al, 1
@@29:	cmp	al, 0
	jne	@@30
	mov	bx, 0FFFFh
	call	@@31
	jae	@@30
	mov	al, 1
@@30:	call	pressspace2
	pop	cx
	pop	bx
	ret
@@31:	push	ax
	push	bx
	push	cx
	push	dx
	and	word ptr v_13, -7
	mov	ax, bx
	call	get8259
	mov	dx, bx
	mov	bx, ax
	call	set8259
	mov	cx, 10h
	call	L05082
	call	get8259
	mov	cx, bx
	mov	bx, dx
	call	set8259
	cmp	cx, ax
	je	@@32
	stc
	jmp	@@33
@@32:	clc
@@33:	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
@@34:	push	cx
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@35
	push	dx
	mov	dx, offset m_check_disable_8259
	call	print
	pop	dx
@@35:	popf
	and	word ptr v_13, -7
	pushf
	cli
	call	L0535C
	mov	cx, 10h
	call	L05082
	cmp	word ptr v_47, 0
	jne	@@36
	mov	cx, 800h
	call	L05082
@@36:	cmp	word ptr v_47, 0
	jne	@@37
	mov	al, 0
	jmp	@@38
@@37:	mov	al, 1
@@38:	call	L0538D
	popf
	call	pressspace2
	pop	cx
	ret
@@39:	push	cx
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@40
	push	dx
	mov	dx, offset m_check_save_npx
	call	print
	pop	dx
@@40:	popf
	mov	al, 0
	pop	cx
	ret
L04CC1:	mov	byte ptr v_12, 1
	mov	word ptr v_13, 0
	cmp	byte ptr v_32, 1
	jne	@@1
	or	word ptr v_13, 4
@@1:	cmp	byte ptr v_31, 1
	jne	@@2
	or	word ptr v_13, 2
@@2:	cmp	byte ptr v_33, 1
	jne	@@3
	or	word ptr v_13, 8
@@3:	ret
L04CF1:	mov	byte ptr v_12, 2
	mov	word ptr v_13, 0
	cmp	byte ptr v_35, 1
	jne	@@1
	or	word ptr v_13, 4
@@1:	cmp	byte ptr v_34, 1
	jne	@@2
	or	word ptr v_13, 2
@@2:	cmp	byte ptr v_36, 1
	jne	@@3
	or	word ptr v_13, 8
@@3:	ret
L04D21:	mov	byte ptr v_12, 3
	mov	word ptr v_13, 0
	cmp	byte ptr v_38, 1
	jne	@@1
	or	word ptr v_13, 4
@@1:	cmp	byte ptr v_37, 1
	jne	@@2
	or	word ptr v_13, 2
@@2:	cmp	byte ptr v_39, 1
	jne	@@3
	or	word ptr v_13, 8
@@3:	ret
showprogress:	push	bx
	push	cx
	push	dx
	mov	ah, 2
	int	1Ah
	push	cx
	push	dx
	push	dx
	mov	dx, offset m_8a3
	call	print
	pop	dx
	mov	al, 0Dh
	call	putch
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8c4
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8c6
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8c8
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8ca
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8cc
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8ce
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8d0
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8d2
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8d4
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8d6
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8d8
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8da
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8dc
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8de
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8e0
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8e2
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8e4
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8e6
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8e8
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8ea
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8ec
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8ee
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8f0
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8f2
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8f4
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8f6
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8f8
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8fa
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8fc
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_8fe
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_900
	call	print
	pop	dx
	mov	cx, 3E8h
	call	L05082
	push	dx
	mov	dx, offset m_902
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_904
	call	print
	pop	dx
	mov	ah, 2
	int	1Ah
	pop	bx
	pop	ax
	call	L05099
	xchg	al, ah
	call	L05099
	xchg	ah, al
	xchg	al, bh
	call	L05099
	xchg	bh, al
	xchg	al, bl
	call	L05099
	xchg	bl, al
	xchg	al, ch
	call	L05099
	xchg	ch, al
	xchg	al, cl
	call	L05099
	xchg	cl, al
	xchg	al, dh
	call	L05099
	xchg	dh, al
	xchg	al, dl
	call	L05099
	xchg	dl, al
	cmp	ch, ah
	jbe	@@1
	add	cl, 3Ch
@@1:	mov	bl, bh
	mov	dl, dh
	xor	bh, bh
	xor	dh, dh
@@2:	cmp	cl, al
	jbe	@@3
	add	dx, 3Ch
	dec	cl
	jmp	@@2
@@3:	sub	dx, bx
	mov	ax, dx
	pop	dx
	pop	cx
	pop	bx
	ret
timeswitch:	cmp	byte ptr v_28, 1
	je	@@2
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@1
	push	dx
	mov	dx, offset m_timing_protected_real
	call	print
	pop	dx
@@1:	popf
@@2:	cmp	byte ptr v_24, 1
	jne	@@4
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@3
	push	dx
	mov	dx, offset m_timing_code_9
	call	print
	pop	dx
@@3:	popf
	call	L04CC1
	call	showprogress
	mov	word ptr v_3C, ax
@@4:	cmp	byte ptr v_25, 1
	jne	@@6
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@5
	push	dx
	mov	dx, offset m_timing_code_a
	call	print
	pop	dx
@@5:	popf
	call	L04CF1
	call	showprogress
	mov	word ptr v_3A, ax
@@6:	cmp	byte ptr v_26, 1
	jne	@@8
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@7
	push	dx
	mov	dx, offset m_timing_code_9p
	call	print
	pop	dx
@@7:	popf
	call	L04D21
	call	showprogress
	mov	word ptr v_3E, ax
@@8:	cmp	byte ptr v_27, 1
	jne	@@10
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@9
	push	dx
	mov	dx, offset m_timing_code_touchdown
	call	print
	pop	dx
@@9:	popf
	mov	byte ptr v_12, 5
	mov	word ptr v_13, 0
	call	showprogress
	mov	word ptr v_40, ax
@@10:	cmp	byte ptr v_28, 1
	jne	@@12
	push	es
	push	di
	mov	di, seg _reporttime
	mov	es, di
	mov	di, offset _reporttime
	cmp	word ptr es:[di], 0
	pop	di
	pop	es
	je	@@12
	call	L04101
	cmp	ah, 0
	je	@@12
	push	dx
	mov	dx, offset m_timing_protected_real2
	call	print
	pop	dx
	pushf
	cmp	word ptr cs:_quiet, 0
	jne	@@11
	push	dx
	mov	dx, offset m_timing_386_switch
	call	print
	pop	dx
@@11:	popf
	mov	byte ptr v_12, 4
	mov	word ptr v_13, 0
	call	showprogress
	mov	word ptr v_42, ax
@@12:	clc
	ret
L05082:	push	es
	push	ds
	pusha
@@1:	push	cx
	call	enablea20
	call	protmode
	call	L050EF
	pop	cx
	loop	@@1
	call	dodisable
	popa
	pop	ds
	pop	es
	ret
L05099:	push	bx
	push	cx
	xor	cx, cx
	mov	cx, ax
	and	cx, 0Fh
	mov	bl, al
	shr	bx, 3
	and	bx, 1Eh
	add	cx, bx
	shl	bx, 2
	add	cx, bx
	mov	al, cl
	pop	cx
	pop	bx
	ret
L050B6:	push	es
	push	ax
	push	bx
	pushf
	cli
	mov	ax, 0F000h
	mov	es, ax
	mov	bx, word ptr es:[0FFF4h]
	mov	ax, word ptr es:[8000h]
	mov	ax, word ptr es:[0E000h]
	mov	ax, word ptr es:[8000h]
	mov	ax, word ptr es:[0E000h]
	mov	ax, word ptr es:[0FFF4h]
	cmp	ax, bx
	je	@@1
	mov	byte ptr v_49, 1
	jmp	@@2
@@1:	mov	byte ptr v_49, 0
@@2:	popf
	pop	bx
	pop	ax
	pop	es
	ret
L050EF:	test	word ptr v_13, 6
	je	@@1
	call	L0531B
@@1:	test	word ptr v_13, 4
	je	@@2
	call	L0533D
@@2:	mov	al, byte ptr v_12
	cmp	al, 4
	jne	@@3
	call	@@9
	jmp	@@7
@@3:	cmp	al, 1
	jne	@@4
	call	L051B5
	jmp	@@7
@@4:	cmp	al, 2
	jne	@@5
	call	L05166
	jmp	@@7
@@5:	cmp	al, 3
	jne	@@6
	call	L051FF
	jmp	@@7
@@6:	cmp	al, 5
	jne	@@7
	call	L0524A
	jmp	@@7
@@7:	test	word ptr v_13, 6
	je	@@8
	call	L05331
@@8:	ret
@@9:	inc	dx
	.386p
	mov	eax, cr0
	.286p
	and	al, 0F4h
	inc	dx
	.386p
	mov	cr0, eax
	.286p
	db	0EAh			; jmp far ptr to the next instruction (clears the prefetch queue)
	dw	$+4, ANALYZE_TEXT
L05155:	mov	ax, ANALYZE_STACK
	mov	ss, ax
	nop
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	lidt	fword ptr v_F0
	ret
L05166:	pusha
	mov	word ptr v_C4, sp
	mov	ax, 38h
	mov	es, ax
	mov	ax, ANALYZE_TEXT
	mov	word ptr es:[469h], ax
	mov	word ptr es:[467h], 14C3h
	mov	al, 8Fh
	out	70h, al
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	mov	al, 0Ah
	out	71h, al
	jmp	@@4
@@4:	jmp	@@5
@@5:	jmp	@@6
@@6:	mov	bx, 4Ah
	lidt	fword ptr cs:[bx]
	int	3
@@7:	hlt
	jmp	@@7
	cli
	cld
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, ANALYZE_STACK
	mov	ss, ax
	mov	sp, word ptr v_C4
	popa
	ret
L051B5:	pushf
	push	ANALYZE_TEXT
	push	1517h
	pusha
	push	0
	push	0
	mov	ax, 38h
	mov	es, ax
	mov	ax, ANALYZE_STACK
	mov	word ptr es:[469h], ax
	mov	word ptr es:[467h], sp
	mov	al, 8Fh
	out	70h, al
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	mov	al, 9
	out	71h, al
	jmp	@@4
@@4:	jmp	@@5
@@5:	jmp	@@6
@@6:	mov	bx, 4Ah
	lidt	fword ptr cs:[bx]
	int	3
@@7:	hlt
	jmp	@@7
	cli
	cld
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	ret
L051FF:	pushf
	push	ANALYZE_TEXT
	push	1562h
	push	ax
	push	0
	pusha
	push	0
	mov	ax, 38h
	mov	es, ax
	mov	ax, ANALYZE_STACK
	mov	word ptr es:[469h], ax
	mov	word ptr es:[467h], sp
	mov	al, 8Fh
	out	70h, al
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	mov	al, 9
	out	71h, al
	jmp	@@4
@@4:	jmp	@@5
@@5:	jmp	@@6
@@6:	mov	bx, 4Ah
	lidt	fword ptr cs:[bx]
	int	3
@@7:	hlt
	jmp	@@7
	cli
	cld
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	ret
L0524A:	cli
	mov	al, 8Fh
	out	70h, al
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	mov	ax, 40h
	mov	es, ax
	mov	di, word ptr es:[0FFF1h]
	mov	ax, 48h
	mov	es, ax
	mov	ax, word ptr es:[di]
	mov	word ptr v_BE, ax
	mov	ax, word ptr es:[di+2]
	mov	word ptr v_C0, ax
	mov	ax, word ptr es:[di+4]
	mov	word ptr v_C2, ax
	mov	byte ptr es:[di], 0EAh
	mov	word ptr es:[di+1], 15D3h
	mov	ax, ANALYZE_TEXT
	mov	word ptr es:[di+3], ax
	mov	word ptr v_C4, sp
	mov	ax, 40h
	mov	es, ax
	mov	ax, word ptr es:[8000h]
	mov	ax, word ptr es:[0E000h]
	mov	ax, word ptr es:[8000h]
	mov	ax, word ptr es:[0E000h]
	mov	word ptr v_C4, sp
	mov	bx, 4Ah
	lidt	fword ptr [bx]
	int	3
@@4:	hlt
	jmp	@@4
	cli
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	mov	ax, ANALYZE_STACK
	mov	ss, ax
	mov	sp, word ptr v_C4
	mov	ax, 0F000h
	mov	es, ax
	mov	di, word ptr es:[0FFF1h]
	mov	ax, 7000h
	mov	es, ax
	mov	ax, word ptr v_C2
	mov	word ptr es:[di+4], ax
	mov	ax, word ptr v_C0
	mov	word ptr es:[di+2], ax
	mov	ax, word ptr v_BE
	mov	word ptr es:[di], ax
	mov	al, 0Fh
	out	70h, al
	jmp	@@5
@@5:	jmp	@@6
@@6:	jmp	@@7
@@7:	ret

; BX = the two 8259 interrupt masks; set8259 puts them back
get8259:	push	ax
	in	al, 21h
	mov	bh, al
	in	al, 0A1h
	mov	bl, al
	pop	ax
	ret
set8259:	push	ax
	mov	al, bh
	out	21h, al
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	mov	al, bl
	out	0A1h, al
	jmp	@@4
@@4:	jmp	@@5
@@5:	jmp	@@6
@@6:	pop	ax
	ret
L0531B:	push	ax
	push	bx
	call	get8259
	mov	word ptr v_C6, bx
	pop	bx
	pop	ax
	ret
	push	bx
	mov	bx, word ptr v_D1
	call	set8259
	pop	bx
	ret
L05331:	push	ax
	push	bx
	mov	bx, word ptr v_C6
	call	set8259
	pop	bx
	pop	ax
	ret
L0533D:	push	ax
	mov	al, 0FFh
	out	21h, al
	jmp	@@1
@@1:	jmp	@@2
@@2:	jmp	@@3
@@3:	out	0A1h, al
	jmp	@@4
@@4:	jmp	@@5
@@5:	jmp	@@6
@@6:	pop	ax
	ret
L05358:	add	byte ptr [bx+si], al
L0535A:	add	byte ptr [bx+si], al
L0535C:	push	ax
	push	bx
	push	dx
	push	ds
	push	es
	mov	ah, 35h
	mov	al, 8
	int	21h
	mov	word ptr cs:L05358, bx
	mov	bx, es
	mov	word ptr cs:L0535A, bx
	mov	word ptr v_47, 0
	mov	ax, ANALYZE_TEXT
	mov	ds, ax
	mov	dx, 16BFh
	mov	ah, 25h
	mov	al, 8
	int	21h
	pop	es
	pop	ds
	pop	dx
	pop	bx
	pop	ax
	ret
L0538D:	push	ax
	push	dx
	push	ds
	mov	ah, 25h
	mov	al, 8
	lds	dx, dword ptr cs:L05358
	int	21h
	pop	ds
	pop	dx
	pop	ax
	ret
	push	ax
	push	ds
	mov	ax, ANALYZE_DATA
	mov	ds, ax
	cmp	word ptr v_47, -1
	je	@@1
	inc	word ptr v_47
@@1:	pop	ds
	pop	ax
	jmp	dword ptr cs:L05358
getcomment:	push	si
	push	dx
	push	es
	mov	dx, seg _dbname
	mov	es, dx
	mov	si, offset _dbname
	cmp	word ptr es:[si], 0
	jne	@@1
	cmp	word ptr es:[si+2], 0
	je	@@2
@@1:	push	dx
	mov	dx, offset m_9bc
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_please_enter_comment
	call	print
	pop	dx
	mov	dx, 5Ch
	mov	ah, 0Ah
	int	21h
	push	dx
	mov	dx, offset m_9ea
	call	print
	pop	dx
@@2:	pop	es
	pop	dx
	pop	si
	ret

; long bioschecksum(void): a checksum of the BIOS ROM from F000:8000
_bioschecksum:	push	bx
	push	cx
	push	si
	push	di
	push	es
	push	ds
	call	romsum
	mov	ax, bx
	xchg	ax, dx
	pop	ds
	pop	es
	pop	di
	pop	si
	pop	cx
	pop	bx
	retf
vcpimsg:	push	es
	push	di
	push	ds
	push	si
	push	cx
	push	dx
	mov	dx, offset m_9ee
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_this_machine_is
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_that_supports_the
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_as_long_as
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_the_system_you
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_ace
	call	print
	pop	dx
	mov	di, 5Eh
	mov	si, 0AFh
	mov	cx, 0Fh
	push	ds
	pop	es
	cld
	rep movsb
	pop	cx
	pop	si
	pop	ds
	pop	di
	pop	es
	ret
emsmsg:	push	dx
	mov	dx, offset m_this_machine_is2
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_that_does_not
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_interface_tkernel_cannot
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_extended_memory_while
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_must_remove_the
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_config_sys_file
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_protected_mode_kernels
	call	print
	pop	dx
	push	dx
	mov	dx, offset m_c2b
	call	print
	pop	dx
	ret
printnum:	push	ax
	push	bx
	push	cx
	push	dx
	push	ds
	mov	ax, cx
	mov	cx, 0FFFFh
	push	cx
	mov	cx, 0Ah
@@1:	cmp	ax, cx
	jae	@@2
	add	ax, 30h
	push	ax
	jmp	@@3
@@2:	xor	dx, dx
	div	cx
	add	dx, 30h
	push	dx
	jmp	@@1
@@3:	pop	ax
	cmp	ax, 0FFFFh
	jne	@@4
	jmp	@@5
@@4:	call	putch
	jmp	@@3
@@5:	pop	ds
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
	push	ax
	push	bx
	push	cx
	push	dx
	push	ds
	mov	al, ch
	shr	al, 1
	shr	al, 1
	shr	al, 1
	shr	al, 1
	call	@@6
	mov	al, ch
	call	@@6
	mov	al, cl
	shr	al, 1
	shr	al, 1
	shr	al, 1
	shr	al, 1
	call	@@6
	mov	al, cl
	call	@@6
	mov	al, 20h
	call	putch
	pop	ds
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
@@6:	push	cx
	push	ax
	and	al, 0Fh
	cmp	al, 9
	jg	@@7
	add	al, 30h
	jmp	@@8
@@7:	sub	al, 0Ah
	add	al, 41h
@@8:	call	putch
	pop	ax
	pop	cx
	ret
putch:	push	ax
	push	bx
	push	cx
	push	dx
	push	ds
	mov	dl, al
	mov	ah, 2
	int	21h
	pop	ds
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; prints the $-terminated message at ANALYZE_MSG:DX
print:	push	ds
	push	ax
	mov	ax, ANALYZE_MSG
	mov	ds, ax
	mov	ah, 9
	int	21h
	pop	ax
	pop	ds
	ret
@@1:	push	ax
	push	cx
	xor	ah, ah
	mov	al, ch
	shr	al, 4
	call	@@3
	call	@@6
	mov	al, ch
	call	@@3
	call	@@6
	mov	al, cl
	shr	al, 4
	call	@@3
	call	@@6
	mov	al, cl
	call	@@3
	call	@@6
	mov	al, 20h
	call	@@6
	pop	cx
	pop	ax
	ret
@@2:	push	ax
	push	cx
	xor	ah, ah
	mov	al, ch
	shr	al, 4
	call	@@3
	call	@@9
	mov	al, ch
	call	@@3
	call	@@9
	mov	al, cl
	shr	al, 4
	call	@@3
	call	@@9
	mov	al, cl
	call	@@3
	call	@@9
	mov	al, 20h
	call	@@9
	pop	cx
	pop	ax
	ret
@@3:	and	al, 0Fh
	cmp	al, 9
	jg	@@4
	add	al, 30h
	jmp	@@5
@@4:	add	al, 37h
@@5:	ret
@@6:	pushf
	push	es
	push	di
	push	bx
	mov	di, word ptr v_C9
	mov	bx, word ptr v_CB
	mov	es, word ptr v_CD
	push	ax
	mov	ah, 78h
	mov	word ptr es:[di], ax
	add	di, 2
	cmp	di, bx
	jbe	@@7
	xor	di, di
@@7:	mov	word ptr v_C9, di
	pop	ax
	cmp	ah, 1
	jne	@@8
	call	@@1
	mov	di, word ptr v_C9
@@8:	mov	word ptr es:[di], 7DBh
	pop	bx
	pop	di
	pop	es
	popf
	ret
@@9:	pushf
	push	es
	push	di
	push	bx
	mov	es, word ptr v_CF
	mov	bx, word ptr v_CB
	mov	di, word ptr v_C9
	push	ax
	mov	ah, 7
	mov	word ptr es:[di], ax
	add	di, 2
	cmp	di, bx
	jbe	@@10
	xor	di, di
@@10:	mov	word ptr v_C9, di
	pop	ax
	cmp	ah, 1
	jne	@@11
	call	@@2
	mov	di, word ptr v_C9
@@11:	mov	word ptr [di], 7DBh
	pop	bx
	pop	di
	pop	es
	popf
	ret
ANALYZE_TEXT	ends
	end

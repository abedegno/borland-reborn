; OVRDATA.ASM: the two far data segments of the overlay library's EMS and extended-memory
; support (OVREXMEM.ASM; bcc20 calls them BCC_SEG_46 and BCC_SEG_50 after their places in
; BCC.EXE).  The bytes are TLINK.EXE's.  FAR46 starts with 'VDISK', the name the VDISK
; check of DETECT_EXTENDED_MEMORY looks for, and holds the state of both memories; the
; field names are bcc20's:
;   20h OVR_EMS_FRAME_SEG     the EMS page frame segment
;   22h OVR_EMS_HANDLE        our EMS handle (FFFFh: none)
;   26h OVR_EMS_PAGE_COUNT    free EMS pages found
;   2Ah OVR_EXT_MEMORY_START  extended memory we may use, linear start
;   2Eh OVR_EXT_MEMORY_END    and end
; FAR50 holds the fake VDISK header ('VDISK FAKE') put at 1M when extended memory is
; claimed the VDISK way, and the int 19h hook's data.

FAR46		segment para public 'FAR_DATA'
		public	BCC_SEG_46
		public	OVR_EMS_FRAME_SEG
		public	OVR_EMS_HANDLE
		public	OVR_EMS_PAGE_COUNT
		public	OVR_EXT_MEMORY_START
		public	OVR_EXT_MEMORY_END
BCC_SEG_46	label	byte
		db	56h,44h,49h,53h,4Bh,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0FFh,0FFh,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,93h,0,0,0,0,0,0,0,93h,0,0,0FFh,0FFh,0
		db	0,0,92h,0,0,0FFh,0FFh,0,0,0,92h,0,0,0,0,0
		db	0,0,93h,0,0,0,0,0,0,0,93h,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		org	20h
OVR_EMS_FRAME_SEG	label	word
		org	22h
OVR_EMS_HANDLE		label	word
		org	26h
OVR_EMS_PAGE_COUNT	label	word
		org	2Ah
OVR_EXT_MEMORY_START	label	dword
		org	2Eh
OVR_EXT_MEMORY_END	label	dword
FAR46		ends

FAR50		segment para public 'FAR_DATA'
		public	BCC_SEG_50
BCC_SEG_50	label	byte
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,56h,44h,49h,53h,4Bh,20h,46h,41h,4Bh,45h,0,0,0,0
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,2Eh
		db	0FFh,2Eh,2Fh,0,0,0,0,0,0,0,0,0,0,0,0,0
FAR50		ends
		end

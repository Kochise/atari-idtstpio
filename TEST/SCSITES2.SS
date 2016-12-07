; /// >  - KOSS 2002 < ///

	OPT	p=68030/68882
	comment	HEAD=7	; FastLoad

; --- EQUATE ASSEMBLY (EA) ---

STST_EA_200HZ:	EQU	$000004BA	; RW : l

STST_EA_SCSI_DR:	EQU	$FFFF8604	; RW : w
STST_EA_SCSI_RS:	EQU	$FFFF8606	;  W : w

; --- EQUATE DATA (ED) ---

STST_ED_DEVICE_FALC:	EQU	1<<0	; SCSI 0
STST_ED_DEVICE_TEST:	EQU	1<<4	; SCSI 4

; --- EQUATE INDEX (EI) ---

STST_EI_REG_ODR:	EQU	0|$88	;  W
STST_EI_REG_CSD:	EQU	0|$88	; R
STST_EI_REG_ICR:	EQU	1|$88	; RW
STST_EI_REG_MR2:	EQU	2|$88	; RW
STST_EI_REG_TCR:	EQU	3|$88	; RW
STST_EI_REG_SER:	EQU	4|$88	;  W
STST_EI_REG_CSB:	EQU	4|$88	; R
STST_EI_REG_BSR:	EQU	5|$88	; R
STST_EI_REG_SDS:	EQU	5|$88	;  W
STST_EI_REG_SDT:	EQU	6|$88	;  W
STST_EI_REG_IDR:	EQU	6|$88	; R
STST_EI_REG_SDI:	EQU	7|$88	;  W
STST_EI_REG_RPI:	EQU	7|$88	; R

STST_EI_BIT_ICR_xRST:	EQU	7	; ICR
STST_EI_BIT_ICR_TEST:	EQU	6	; ICR
STST_EI_BIT_ICR_LADIFF:	EQU	5	; ICR
STST_EI_BIT_ICR_xACK:	EQU	4	; ICR
STST_EI_BIT_ICR_xBSY:	EQU	3	; ICR
STST_EI_BIT_ICR_xSEL:	EQU	2	; ICR
STST_EI_BIT_ICR_xATN:	EQU	1	; ICR
STST_EI_BIT_ICR_DBUS:	EQU	0	; ICR
STST_EI_BIT_MR2_BLK:	EQU	7	; MR2
STST_EI_BIT_MR2_TARG:	EQU	6	; MR2
STST_EI_BIT_MR2_PCHK:	EQU	5	; MR2
STST_EI_BIT_MR2_PINT:	EQU	4	; MR2
STST_EI_BIT_MR2_EOP:	EQU	3	; MR2
STST_EI_BIT_MR2_BSY:	EQU	2	; MR2
STST_EI_BIT_MR2_DMA:	EQU	1	; MR2
STST_EI_BIT_MR2_ARB:	EQU	0	; MR2
STST_EI_BIT_TCR_xREQ:	EQU	3	; TCR
STST_EI_BIT_TCR_xMSG:	EQU	2	; TCR
STST_EI_BIT_TCR_xCD:	EQU	1	; TCR
STST_EI_BIT_TCR_xIO:	EQU	0	; TCR
STST_EI_BIT_CSB_xRST:	EQU	7	; CSB
STST_EI_BIT_CSB_xBSY:	EQU	6	; CSB
STST_EI_BIT_CSB_xREQ:	EQU	5	; CSB
STST_EI_BIT_CSB_xMSG:	EQU	4	; CSB
STST_EI_BIT_CSB_xCD:	EQU	3	; CSB
STST_EI_BIT_CSB_xIO:	EQU	2	; CSB
STST_EI_BIT_CSB_xSEL:	EQU	1	; CSB
STST_EI_BIT_CSB_xDBP:	EQU	0	; CSB
STST_EI_BIT_BSR_EDMA:	EQU	7	; BSR
STST_EI_BIT_BSR_DRQ:	EQU	6	; BSR
STST_EI_BIT_BSR_SPER:	EQU	5	; BSR
STST_EI_BIT_BSR_INT:	EQU	4	; BSR
STST_EI_BIT_BSR_PHSM:	EQU	3	; BSR
STST_EI_BIT_BSR_BSY:	EQU	2	; BSR
STST_EI_BIT_BSR_xATN:	EQU	1	; BSR
STST_EI_BIT_BSR_xACK:	EQU	0	; BSR

STST_EI_MSK_ICR_xRST:	EQU	1<<STST_EI_BIT_ICR_xRST
STST_EI_MSK_ICR_TEST:	EQU	1<<STST_EI_BIT_ICR_TEST
STST_EI_MSK_ICR_LADIFF:	EQU	1<<STST_EI_BIT_ICR_LADIFF
STST_EI_MSK_ICR_xACK:	EQU	1<<STST_EI_BIT_ICR_xACK
STST_EI_MSK_ICR_xBSY:	EQU	1<<STST_EI_BIT_ICR_xBSY
STST_EI_MSK_ICR_xSEL:	EQU	1<<STST_EI_BIT_ICR_xSEL
STST_EI_MSK_ICR_xATN:	EQU	1<<STST_EI_BIT_ICR_xATN
STST_EI_MSK_ICR_DBUS:	EQU	1<<STST_EI_BIT_ICR_DBUS
STST_EI_MSK_MR2_BLK:	EQU	1<<STST_EI_BIT_MR2_BLK
STST_EI_MSK_MR2_TARG:	EQU	1<<STST_EI_BIT_MR2_TARG
STST_EI_MSK_MR2_PCHK:	EQU	1<<STST_EI_BIT_MR2_PCHK
STST_EI_MSK_MR2_PINT:	EQU	1<<STST_EI_BIT_MR2_PINT
STST_EI_MSK_MR2_EOP:	EQU	1<<STST_EI_BIT_MR2_EOP
STST_EI_MSK_MR2_BSY:	EQU	1<<STST_EI_BIT_MR2_BSY
STST_EI_MSK_MR2_DMA:	EQU	1<<STST_EI_BIT_MR2_DMA
STST_EI_MSK_MR2_ARB:	EQU	1<<STST_EI_BIT_MR2_ARB
STST_EI_MSK_TCR_xREQ:	EQU	1<<STST_EI_BIT_TCR_xREQ
STST_EI_MSK_TCR_xMSG:	EQU	1<<STST_EI_BIT_TCR_xMSG
STST_EI_MSK_TCR_xCD:	EQU	1<<STST_EI_BIT_TCR_xCD
STST_EI_MSK_TCR_xIO:	EQU	1<<STST_EI_BIT_TCR_xIO
STST_EI_MSK_CSB_xRST:	EQU	1<<STST_EI_BIT_CSB_xRST
STST_EI_MSK_CSB_xBSY:	EQU	1<<STST_EI_BIT_CSB_xBSY
STST_EI_MSK_CSB_xREQ:	EQU	1<<STST_EI_BIT_CSB_xREQ
STST_EI_MSK_CSB_xMSG:	EQU	1<<STST_EI_BIT_CSB_xMSG
STST_EI_MSK_CSB_xCD:	EQU	1<<STST_EI_BIT_CSB_xCD
STST_EI_MSK_CSB_xIO:	EQU	1<<STST_EI_BIT_CSB_xIO
STST_EI_MSK_CSB_xSEL:	EQU	1<<STST_EI_BIT_CSB_xSEL
STST_EI_MSK_CSB_xDBP:	EQU	1<<STST_EI_BIT_CSB_xDBP
STST_EI_MSK_BSR_EDMA:	EQU	1<<STST_EI_BIT_BSR_EDMA
STST_EI_MSK_BSR_DRQ:	EQU	1<<STST_EI_BIT_BSR_DRQ
STST_EI_MSK_BSR_SPER:	EQU	1<<STST_EI_BIT_BSR_SPER
STST_EI_MSK_BSR_INT:	EQU	1<<STST_EI_BIT_BSR_INT
STST_EI_MSK_BSR_PHSM:	EQU	1<<STST_EI_BIT_BSR_PHSM
STST_EI_MSK_BSR_BSY:	EQU	1<<STST_EI_BIT_BSR_BSY
STST_EI_MSK_BSR_xATN:	EQU	1<<STST_EI_BIT_BSR_xATN
STST_EI_MSK_BSR_xACK:	EQU	1<<STST_EI_BIT_BSR_xACK

; --- EQUATE SYSTEM (ES) ---

; /////////////////////////////////////////////////////////////////////////////	
	SECTION	TEXT
; /////////////////////////////////////////////////////////////////////////////	
	
; --- TEXT USER INIT (TUI) ---
	
	clr.l	-(SP)
	move.w	#$20,-(SP)	; - SUPER -
	TRAP	#1	; *** GEMDOS ***
	addq.l	#6,SP
	move.l	D0,STST_BDB_SYS_OLD_USP

; --- TEXT USER MAIN (TUM) ---

	BSR	STST_TSM_SCSI_TEST

; --- TEXT USER EXIT (TUE) ---

	move.l	STST_BDB_SYS_OLD_USP,-(SP)
	move.w	#$20,-(SP)	; - SUPER -
	TRAP	#1	; *** GEMDOS ***
	addq.l	#6,SP

PROG_TUE_PTERM0:	clr.w	-(SP)	; - P_TERM0 -
	TRAP	#1	; *** GEMDOS ***

; --- TEXT USER SUB (TUS) ---

; -----------------------------------------------------------------------------

; --- TEXT SUPER MAIN (TSM) ---
	
STST_TSM_SCSI_TEST:	move.w	#STST_ED_DEVICE_TEST,D1
	BSR	scuzzy_select
	tst.w	D0
	BEQ	STST_TSM_SCSI_TEST
	
	RTS

STST_TSM_SCSI_NEXT:	BSR	scuzzy_deselect

	RTS

;Subroutine scuzzy_select selects the target specified by D1.
;Once this routine is called, you must not perform any "normal"
;SCSI operations until you call scuzzy-deselect.
;On entry, D1 contains expanded target ID, e.g. if ID = 2, D1 = 00000100.
;On return, D0 contains error code:
;0 = no error, 1 = SCSI bus occupied, 2 = target not responding

scuzzy_select:	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_MR2,STST_EA_SCSI_RS.w
	move.w	#$40,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_CSB,STST_EA_SCSI_RS.w
	move.w	STST_EA_SCSI_DR.w,D2
	btst.l	#6,D2
	BEQ	busfree	;jump if bus free 
	move.w	#1,D0	;Someone else is on the bus, set
	BRA	restore_scsi	;error code to 1 and return.
	
	;Nobody will reselect, bus is all ours.
busfree:
	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$01,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ODR,STST_EA_SCSI_RS.w
	move.w	D1,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$05,STST_EA_SCSI_DR.w
	move.w	#10,D0

	move.w	#STST_EI_REG_CSB,STST_EA_SCSI_RS.w
select_lp:	move.w	STST_EA_SCSI_DR.w,D2
	btst.l	#6,D2	;look for BSY asserted 
	BNE	selected	;jump if it is
	DBRA	D0,select_lp	;if not, loop up to 10 times	

	;If timed out, set error code to
timeout:	move.w	#2,D0	;target not responding.
	BRA	restore_scsi	;return
	
selected:	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w

	RTS	;return.  Target now on SCSI bus

;Subroutine write_address updates the interface address register with the
;8-bit address passed in D0.

write_address:	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$03,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$01,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ODR,STST_EA_SCSI_RS.w
	move.w	D0,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$0B,STST_EA_SCSI_DR.w
	move.w	#$03,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w

	RTS

;Subroutine write_data writes the 8-bit data in D0 to the interface.

write_data:	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$01,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$01,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ODR,STST_EA_SCSI_RS.w
	move.w	D0,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$09,STST_EA_SCSI_DR.w
	move.w	#$01,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w

	RTS

;Subroutine read_data reads the 8-bit data from the interface to D0.

read_data:	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w
	move.w	#$08,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_CSD,STST_EA_SCSI_RS.w
	move.w	STST_EA_SCSI_DR.w,D0
	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w

	RTS

;Subroutine scuzzy-deselect removes the interface from the scsi bus,
;and returns the bus to normal operation.
;On entry, A0 contains base address of 5380
;	0 = no error, 3 = target stuck on bus.

scuzzy_deselect:	move.b	#0,D0	;set return error to 0
	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$02,STST_EA_SCSI_DR.w
	move.w	#$0A,STST_EA_SCSI_DR.w
	move.w	#$02,STST_EA_SCSI_DR.w
	nop	;give BSY time to
	nop	;get off the bus
	nop
	nop
	move.w	#STST_EI_REG_CSB,STST_EA_SCSI_RS.w
	move.w	STST_EA_SCSI_DR.w,D2
	btst.l	#6,D2	;look for BSY still asserted 
	BEQ	restore_scsi	;jump if it is not
	move.b	#3,D0	;it is, target stuck on bus

restore_scsi:	move.w	#STST_EI_REG_ICR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_MR2,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_TCR,STST_EA_SCSI_RS.w
	move.w	#$07,STST_EA_SCSI_DR.w
	move.w	#STST_EI_REG_ODR,STST_EA_SCSI_RS.w
	move.w	#$00,STST_EA_SCSI_DR.w
	
STST_TSM_EXIT:	RTS

; --- TEXT SUPER SUB (TSS) ---

; /////////////////////////////////////////////////////////////////////////////	
	SECTION	DATA
; /////////////////////////////////////////////////////////////////////////////	
	
; --- DATA ADDRESS TABLE (DAT) ---
	
; --- DATA DEFINED ARRAY (DDA) ---
	
STST_DDA_IDENTIFY_CMD:	dc.w	1	; Message lenght
	dc.b	%10000011
	
STST_DDA_INQUIRY_CMD:	dc.w	6	; Message lenght
	dc.b	$12	; INQUIRY
	dc.b	3<<4	; LUN
	dc.b	0	; PAGE CODE
	dc.b	0
	dc.b	0	; ALLOC LENGHT
	dc.b	0	; CONTROL

; /////////////////////////////////////////////////////////////////////////////	
	SECTION	BSS
; /////////////////////////////////////////////////////////////////////////////	

; --- BSS DATA BUFFER (BDB) ---

STST_BDB_SYS_OLD_USP:	ds.l	1

STST_BDB_DEV_ID_BUFFER:	ds.b	96

; --- BSS FLAG BUFFER (BFB) ---

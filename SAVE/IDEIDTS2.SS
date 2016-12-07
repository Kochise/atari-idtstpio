; /// IDE/SCSI IDENTIFY TEST - KOSS 2001 ///

	OPT	p=68030/68882
	OPT	AUTOPC
	OPT	BDW
	OPT	O+
	OPT	OW-
	COMMENT	HEAD=7	; FastLoad
	OUTPUT	\IDEIDTS2.PRG

BS:	EQU	1
WS:	EQU	2
LS:	EQU	4

BB:	EQU	BS*8
WB:	EQU	WS*8
LB:	EQU	LS*8

; --- EQUATE ASSEMBLY ---

; --- EQUATE DATA ---

TIDE_ED_DAY:	EQU	21	; Binary Date Format
TIDE_ED_MONTH:	EQU	12	;  FEDC BA98 7654 3210
TIDE_ED_YEAR:	EQU	2001	; %YYYY YYYM MMMD DDDD
TIDE_ED_DATE:	EQU	((TIDE_ED_YEAR-1980)<<9)|(TIDE_ED_MONTH<<5)|(TIDE_ED_DAY)

TIDE_ED_AT_CMD_ID_DEV:	EQU	$EC	; IDENTIFY DEVICE
TIDE_ED_AT_CMD_ID_PDEV:	EQU	$A1	; IDENTIFY PACKET DEVICE

TIDE_ED_AT_CLK_WAIT:	EQU	1	; 1 second


; --- EQUATE INDEX ---

TIDE_EI_AT_REG_ASR:	EQU	8*4
TIDE_EI_AT_REG_CR:	EQU	7*4
TIDE_EI_AT_REG_CHR:	EQU	5*4
TIDE_EI_AT_REG_CLR:	EQU	4*4
TIDE_EI_AT_REG_DP:	EQU	0*4
TIDE_EI_AT_REG_DR:	EQU	0*4
TIDE_EI_AT_REG_DCR:	EQU	8*4
TIDE_EI_AT_REG_DHR:	EQU	6*4
TIDE_EI_AT_REG_ER:	EQU	1*4
TIDE_EI_AT_REG_FR:	EQU	1*4
TIDE_EI_AT_REG_SCR:	EQU	2*4
TIDE_EI_AT_REG_SNR:	EQU	3*4
TIDE_EI_AT_REG_SR:	EQU	7*4
TIDE_EI_AT_REG_LBA0700:	EQU	3*4
TIDE_EI_AT_REG_LBA1508:	EQU	4*4
TIDE_EI_AT_REG_LBA2316:	EQU	5*4
TIDE_EI_AT_REG_LBA2724:	EQU	6*4

TIDE_EI_AT_BIT_SRTS:	EQU	2	; DCR
TIDE_EI_AT_BIT_nIEN:	EQU	1	; DCR
TIDE_EI_AT_BIT_DEV:	EQU	4	; DHR
TIDE_EI_AT_BIT_ABRT:	EQU	2	; ER
TIDE_EI_AT_BIT_BSY:	EQU	7	; SR
TIDE_EI_AT_BIT_DRDY:	EQU	6	; SR
TIDE_EI_AT_BIT_DRQ:	EQU	3	; SR
TIDE_EI_AT_BIT_ERR:	EQU	0	; SR

TIDE_EI_AT_MSK_SRTS:	EQU	1<<TIDE_EI_AT_BIT_SRTS	; DCR
TIDE_EI_AT_MSK_nIEN:	EQU	1<<TIDE_EI_AT_BIT_nIEN	; DCR
TIDE_EI_AT_MSK_DEV:	EQU	1<<TIDE_EI_AT_BIT_DEV	; DHR
TIDE_EI_AT_MSK_ABRT:	EQU	1<<TIDE_EI_AT_BIT_ABRT	; ER
TIDE_EI_AT_MSK_BSY:	EQU	1<<TIDE_EI_AT_BIT_BSY	; SR
TIDE_EI_AT_MSK_DRDY:	EQU	1<<TIDE_EI_AT_BIT_DRDY	; SR
TIDE_EI_AT_MSK_DRQ:	EQU	1<<TIDE_EI_AT_BIT_DRQ	; SR
TIDE_EI_AT_MSK_ERR:	EQU	1<<TIDE_EI_AT_BIT_ERR	; SR

; --- EQUATE SYSTEM ---

; /////////////////////////////////////////////////////////////////////////////	
	SECTION	TEXT
; /////////////////////////////////////////////////////////////////////////////	

;	BRA	TIDE_TUI_START
	
;	dc.b	"ProgHEAD"	; ProgHEADER
;	dc.w	$0101	; ProgVERSION
;	dc.w	TIDE_ED_DATE	; ProgDATE
;	dc.b	"IDE TEST",0	; ProgNAME
;	dc.b	"Kochise",0	; ProgAUTHOR
	
; --- TEXT USER INIT ---
	
TIDE_TUI_START:	pea	TIDE_DDA_AT_TITLE
	move.w	#9,-(SP)	; - C_CONWS -
	TRAP	#1	; *** GEMDOS ***
	addq.l	#6,SP

; --- TEXT USER MAIN ---

	pea	TIDE_DDA_AT_INFO_LINE
	move.w	#9,-(SP)	; - C_CONWS -
	TRAP	#1	; *** GEMDOS ***
	addq.l	#6,SP

	move.w	#0,TIDE_BFB_AT_DEV_NUMB	; DEV 0

	pea	TIDE_TSM_TestStart
	move.w	#$26,-(SP)	; - SUPEXEC -
	TRAP	#14	; *** XBIOS ***
	addq.l	#6,SP

	BSR	TIDE_TUS_PrintInfos

	move.w	#1,TIDE_BFB_AT_DEV_NUMB	; DEV 1

	pea	TIDE_TSM_TestStart
	move.w	#$26,-(SP)	; - SUPEXEC -
	TRAP	#14	; *** XBIOS ***
	addq.l	#6,SP

	BSR	TIDE_TUS_PrintInfos

	move.w	#7,-(SP)	; - C_RAWCIN -
	TRAP	#1	; *** GEMDOS ***
	addq.l	#2,SP

; --- TEXT USER EXIT ---

	clr.w	-(SP)	; - P_TERM0 -
	TRAP	#1	; *** GEMDOS ***

; --- TEXT USER SUB ---

TIDE_TUS_PrintInfos:	move.w	TIDE_BFB_AT_DEV_NUMB,D0

	lea	(TIDE_DDA_AT_DEV_NUMBER.l,D0.w*8),A0
	lea	TIDE_DDA_AT_DEV_LINE,A1

	move.w	#8-1,D1
	BSR	TIDE_TUS_CopyInfos

	; ----------------------

	move.w	(TIDE_BFB_AT_DEV_TYPE.l,D0.w*2),D2
	andi.w	#%1,D2	; #%11
	lea	(TIDE_DDA_AT_ATA_TYPE.l,D2.w*8),A0
	lea	TIDE_DDA_AT_TYPE_LINE,A1

	move.w	#8-1,D1
	BSR	TIDE_TUS_CopyInfos

	; ----------------------

	cmpi.w	#2,D2
	BGE	TIDE_TUS_NoSerialCopy

	lea	TIDE_BDB_AT_ID_DRV,A0
	lea	(20,A0),A0

	BRA	TIDE_TUS_SerialCopy

TIDE_TUS_NoSerialCopy:	lea	TIDE_DDA_AT_NO_SERIAL,A0

TIDE_TUS_SerialCopy:	lea	TIDE_DDA_AT_SER_LINE,A1

	move.w	#20-1,D1
	BSR	TIDE_TUS_CopyInfos

	; ----------------------

	cmpi.w	#2,D2
	BGE	TIDE_TUS_NoFirmwCopy

	lea	TIDE_BDB_AT_ID_DRV,A0
	lea	(46,A0),A0

	BRA	TIDE_TUS_FirmwCopy

TIDE_TUS_NoFirmwCopy:	andi.w	#%1,D2	; #%11
	lea	(TIDE_DDA_AT_ATA_TYPE.l,D2.w*8),A0

TIDE_TUS_FirmwCopy:	lea	TIDE_DDA_AT_FIRM_LINE,A1

	move.w	#8-1,D1
	BSR	TIDE_TUS_CopyInfos

	; ----------------------

	cmpi.w	#2,D2
	BGE	TIDE_TUS_NoModelCopy

	lea	TIDE_BDB_AT_ID_DRV,A0
	lea	(54,A0),A0

	BRA	TIDE_TUS_ModelCopy

TIDE_TUS_NoModelCopy:	andi.w	#1,D2
	move.l	(TIDE_DAT_AT_NO_MODEL.l,D2.w*4),A0

TIDE_TUS_ModelCopy:	lea	TIDE_DDA_AT_MODEL_LINE,A1

	move.w	#40-1,D1
	BSR	TIDE_TUS_CopyInfos

	; ----------------------

	pea	TIDE_DDA_AT_DEV_LINE
	move.w	#9,-(SP)	; - C_CONWS -
	TRAP	#1	; *** GEMDOS ***
	addq.l	#6,SP

	RTS

TIDE_TUS_CopyInfos:	move.b	(A0)+,(A1)+
	DBF	D1,TIDE_TUS_CopyInfos

	RTS

; --- TEXT SUPER MAIN ---

TIDE_TSM_TestStart:	lea	TIDE_DAT_AT_REG,A6
	move.b	#TIDE_EI_AT_MSK_nIEN,([TIDE_EI_AT_REG_DHR,A6])

	move.w	TIDE_BFB_AT_DEV_NUMB,D0
	asl.w	#TIDE_EI_AT_BIT_DEV,D0
	move.b	D0,([TIDE_EI_AT_REG_DHR,A6])

TIDE_TSM_ATP_ChkStatus:	move.b	([TIDE_EI_AT_REG_SR,A6]),D0

	move.b	D0,D1
	andi.b	#$F0,D1
	cmpi.b	#$F0,D1
	BEQ	TIDE_TSM_ATP_NoDevice

	andi.b	#(TIDE_EI_AT_MSK_BSY|TIDE_EI_AT_MSK_DRQ),D0
	BNE	TIDE_TSM_ATP_ChkStatus

	move.w	TIDE_BFB_AT_DEV_NUMB,D0
	move.w	(TIDE_BFB_AT_DEV_TYPE.l,D0.w*2),D0

	lea	TIDE_DDA_AT_ID_DEV_CMD,A0
	move.w	(A0,D0.w*2),D0

TIDE_TSM_ATP_WriteCmd:	move.b	D0,([TIDE_EI_AT_REG_CR,A6])

TIDE_TSM_ATP_SetClock:	lea	$4BA.w,A5
	move.l	(A5),D5
	add.l	#200*TIDE_ED_AT_CLK_WAIT,D5
	SCS	TIDE_BFB_AT_OVER_CLK
	
TIDE_TSM_ATP_PIODI_ChkS: move.b	([TIDE_EI_AT_REG_SR,A6]),D0

	btst.l	#TIDE_EI_AT_BIT_ERR,D0
	BNE	TIDE_TSM_ATP_ChkPktDev

	andi.b	#(TIDE_EI_AT_MSK_BSY|TIDE_EI_AT_MSK_DRQ),D0
	BEQ	TIDE_TSM_ATP_DevNoResp

	cmpi.b	#TIDE_EI_AT_MSK_DRQ,D0
	BNE	TIDE_TSM_ATP_PIODI_ChkS

	lea	TIDE_BDB_AT_ID_DRV,A0
	move.w	#256-1,D0

TIDE_TSM_ATP_FetchData:	move.w	([TIDE_EI_AT_REG_DR,A6]),(A0)+
	DBF	D0,TIDE_TSM_ATP_FetchData

TIDE_TSM_ATP_Exit:	RTS

; ----------------------

TIDE_TSM_ATP_DevNoResp:	tst.w	TIDE_BFB_AT_OVER_CLK
	BEQ	TIDE_TSM_ATP_WaitClk

	tst.l	(A5)
	BMI	TIDE_TSM_ATP_PIODI_ChkS

TIDE_TSM_ATP_WaitClk:	cmp.l	(A5),D5
	BGT	TIDE_TSM_ATP_PIODI_ChkS

	move.w	TIDE_BFB_AT_DEV_NUMB,D0
	move.w	#2,(TIDE_BFB_AT_DEV_TYPE.l,D0.w*2)

	RTS

TIDE_TSM_ATP_NoDevice:	move.w	TIDE_BFB_AT_DEV_NUMB,D0
	move.w	#3,(TIDE_BFB_AT_DEV_TYPE.l,D0.w*2)

	RTS

; ----------------------

TIDE_TSM_ATP_ChkPktDev:	btst.b	#TIDE_EI_AT_BIT_ABRT,([TIDE_EI_AT_REG_ER,A6])
	BEQ	TIDE_TSM_ATP_DevNoResp

	cmpi.b	#$14,([TIDE_EI_AT_REG_CLR,A6])
	BNE	TIDE_TSM_ATP_DevNoResp

	cmpi.b	#$EB,([TIDE_EI_AT_REG_CHR,A6])
	BNE	TIDE_TSM_ATP_DevNoResp

	lea	TIDE_BFB_AT_DEV_TYPE,A0
	move.w	TIDE_BFB_AT_DEV_NUMB,D0
	tst.w	(A0,D0.w*2)
	BNE	TIDE_TSM_ATP_DevNoResp

	move.w	#1,(A0,D0.w*2)
	
	BRA	TIDE_TSM_ATP_ChkStatus

; --- TEXT SUPER SUB ---

; /////////////////////////////////////////////////////////////////////////////
	SECTION	DATA
; /////////////////////////////////////////////////////////////////////////////

; --- DATA ADDRESS TABLE ---

TIDE_DAT_AT_REG:	dc.l	$00F00000	; DP/DR
	dc.l	$00F00005	; ER/FR
	dc.l	$00F00009	; SCR
	dc.l	$00F0000D	; SNR/LBA0700
	dc.l	$00F00011	; CLR/LBA1508
	dc.l	$00F00015	; CHR/LBA2316
	dc.l	$00F00019	; DHR/LBA2724
	dc.l	$00F0001D	; CR/SR
	dc.l	$00F00039	; ASR/DCR
	
TIDE_DAT_AT_NO_MODEL:	dc.l	TIDE_DDA_AT_DEV_NOT_R
	dc.l	TIDE_DDA_AT_NO_DEV_C

; --- DATA DEFINED ARRAY ---

TIDE_DDA_AT_ID_DEV_CMD:	dc.w	TIDE_ED_AT_CMD_ID_DEV	; ATA
	dc.w	TIDE_ED_AT_CMD_ID_PDEV	; ATAPI

TIDE_DDA_AT_DEV_NUMBER:	dc.b	" IDE 0  "
	dc.b	" IDE 1  "

	EVEN

TIDE_DDA_AT_ATA_TYPE:	dc.b	"ATA     "
	dc.b	"ATAPI   "

	EVEN

TIDE_DDA_AT_INFO_LINE:	dc.b	"DEVICE    "
	dc.b	"TYPE      "
	dc.b	"SERIAL                "
	dc.b	"FIRMWARE  "
	dc.b	"MODEL                                     "
	dc.b	13,10
	dc.b	13,10
	dc.b	0

	EVEN

TIDE_DDA_AT_NO_SERIAL:	dc.b	"NONE                  "

	EVEN

TIDE_DDA_AT_DEV_NOT_R:	dc.b	"Device Not Responding...                  "
TIDE_DDA_AT_NO_DEV_C:	dc.b	"No Device Connected...                    "

	EVEN

TIDE_DDA_AT_DEV_LINE:	dc.b	"          "
TIDE_DDA_AT_TYPE_LINE:	dc.b	"          "
TIDE_DDA_AT_SER_LINE:	dc.b	"                      "
TIDE_DDA_AT_FIRM_LINE:	dc.b	"          "
TIDE_DDA_AT_MODEL_LINE:	dc.b	"                                          "
	dc.b	13,10,0

	EVEN

TIDE_DDA_AT_TITLE:	dc.b	27,"E","/// IDE/SCSI IDENTIFY TEST - KOSS 2001 ///",13,10
	dc.b	13,10,0

	EVEN

; /////////////////////////////////////////////////////////////////////////////	
	SECTION	BSS
; /////////////////////////////////////////////////////////////////////////////	

; --- BSS DATA BUFFER ---

TIDE_BDB_AT_ID_DRV:	ds.w	256

; --- BSS FLAG BUFFER ---

TIDE_BFB_AT_DEV_NUMB:	ds.w	1
TIDE_BFB_AT_DEV_TYPE:	ds.w	2

TIDE_BFB_AT_OVER_CLK:	ds.w	1
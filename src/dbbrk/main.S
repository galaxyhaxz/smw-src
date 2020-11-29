.INCLUDE "cpureg.i"
.INCLUDE "ppureg.i"

.STRUCT CRASH_DUMP
A_REG		DW ; 00
X_REG		DW ; 02
Y_REG		DW ; 04
D_REG		DW ; 06
B_REG		DB ; 08
P_REG		DB ; 09
PC_ADD		DS 0 ; 0A
PC_ADDL		DB ; 0A
PC_ADDM		DB ; 0B
PC_ADDH		DB ; 0C
STACK		DW ; 0D
JOYDATA		DW ; 0F
TRIG_BUF	DB ; 11
CURSOR_MIR	DS 0 ; 12
ADD_BUF		DS 0 ; 12
ADD_BUFL	DB ; 12
ADD_BUFM	DB ; 13
LAST_JOY1	DS 0 ; 14
ADD_BUFH	DB ; 14
LAST_JOY2	DB ; 15
TEXT_BUF	DS 32 ; 16
CUR_ADD		DS 0 ; 36
CUR_ADDL	DB ; 36
CUR_ADDM	DB ; 37
CUR_ADDH	DB ; 38
CUR_ROW		DB ; 39
CURSOR		DB ; 3A
ASC_HEX		DB ; 3B
.ENDST

.ENUM $1FC4
RAM_DbBrk	INSTANCEOF CRASH_DUMP
.ENDE

.DEFINE DBBRK_ADDR_ON	%00000001	;(1 << 0)
.DEFINE DBBRK_ADDR_OFF	%00000000	;(0 << 0)
.DEFINE DBBRK_INIT_ASC	%00000010	;(1 << 1)
.DEFINE DBBRK_INIT_HEX	%00000000	;(0 << 1)
.DEFINE DBBRK_MSG_ON	%10000000	;(1 << 7)
.DEFINE DBBRK_MSG_OFF	%00000000	;(0 << 7)

.SECTION "DBBRK"

.INDEX 16
_DrawTiles:
	STX VMADDL
	LDX #$001F
-	LDA $0000,Y
	BPL +
	LDX #$0000
+	AND #$7F
	CMP #$60
	BCC +
	AND #$DF
+	SEC
	SBC #$20
	AND #$3F
	STA VMDATAWL
	STZ VMDATAWH
	INY
	DEX
	BPL -
	RTS

_DrawStrBuf:
	DEX
	LDA $16,X
	ORA #$80
	STA $16,X
	TYX
	LDY #RAM_DbBrk+22
	JMP _DrawTiles

_GetHexValue:
	PHA
	XBA
	LDA #$00
	XBA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR _GetHexHigh
	PLA
	AND #$0F
_GetHexHigh:
	TAY
	LDA _HexMap.W,Y
	STA $16,X
	INX
	RTS

_HexMap:	.DB "0123456789ABCDEF"

_GetHexWord:
	PHA
	XBA
	JSR _GetHexValue
	PLA
	JSR _GetHexValue
	RTS

.ACCU 8
_ReadRow:
	LDA $39
	CMP #$10
	BCS _AllRowsDrawn
	ASL A
	ASL A
	ASL A
	CLC
	ADC $36
	STA $12
	LDA $37
	ADC #$00
	STA $13
	LDA $38
	ADC #$00
	STA $14
	LDX #$0000
	JSR _GetHexValue
	LDA #':'
	STA $16,X
	INX
	REP #$20
	LDA $12
	SEP #$20
	JSR _GetHexWord
	LDY #$0000
	LDA $3B
	BNE _GetByteAscii
-	LDA #' '
	STA $16,X
	INX
	LDA [$12],Y
	PHY
	JSR _GetHexValue
	PLY
	INY
	CPY #$0008
	BNE -
	SEC
	RTS

_AllRowsDrawn:
	CLC
	RTS

_GetByteAscii:
	LDA #' '
	STA $16,X
	STA $18,X
	LDA [$12],Y
	AND #$7F
	CMP #$20
	BCS +
	LDA #'.'
+	STA $17,X
	INX
	INX
	INX
	INY
	CPY #$0008
	BNE _GetByteAscii
	SEC
	RTS

_GetBrkSig:
	PHB
	LDA $0C
	PHA
	PLB
	LDY $0A
	DEY
	LDA $0000,Y
	STA $12
	INY
	LSR $12
	BCC +
	JSR _SetAddress
+	LSR $12
	BCC +
	JSR _StartInAscii
+	LSR $12
	BCC +
	JSR _NoBrkOp
+	LSR $12
	BCC +
	JSR _NoBrkOp
+	LSR $12
	BCC +
	JSR _NoBrkOp
+	LSR $12
	BCC +
	JSR _NoBrkOp
+	LSR $12
	BCC +
	JSR _NoBrkOp
+	LSR $12
	BCC +
	JSR _DrawDbgMsg
+	PLB
	RTS

_StartInAscii:
	INC $3B
	RTS

_SetAddress:
	LDA $0000,Y
	STA $36
	INY
	LDA $0000,Y
	STA $37
	INY
	LDA $0000,Y
	STA $38
	INY
	RTS

_DrawDbgMsg:
	LDX #$0520
	JMP _DrawTiles

_NoBrkOp:	RTS

.ACCU 8
_HandleJoypad:
	LDX $0F
	STX $14
-	LDA HVBJOY
	AND #$01
	BNE -
	LDX JOY1L
	STX $0F
	CPX $14
	BEQ +
	STZ $11
+	LDA $11
	BEQ +
	DEC $11
	BNE ++
+	REP #$20
	LDX #$0000
-	LDA _JoyExeTbl.W,X
	BEQ ++
	INX
	INX
	INX
	INX
	CMP $0F
	BNE -
	SEP #$20
	JSR _JmpJoyTbl
	LDX $0F
	CPX $14
	BEQ ++
	ASL $11
	ASL $11
++	SEP #$20
	RTS

_JmpJoyTbl:	JMP (_JoyExeTbl.W-2,X)

_JoyExeTbl:
	.DW $0400,_DecCursAdd ; Down
	.DW $0800,_IncCursAdd ; Up
	.DW $0200,_DecAddOne ; Left
	.DW $0100,_IncAddOne ; Right
	.DW $0020,_DecCursPos ; TL
	.DW $0010,_IncCursPos ; TR
	.DW $9000,_ToggleRomRam ; Start+B
	.DW $A000,_ResetLowHigh ; Select+B
	.DW $2080,_IncByRegA ; Select+A
	.DW $2040,_IncByRegX ; Select+X
	.DW $6000,_IncByRegY ; Select+Y
	.DW $1080,_ToggleCharType ; Start+A
	.DW 0

_ToggleCharType:
	LDA $3B
	EOR #$01
	STA $3B
	BRA _ExitJoyTbl

_ResetLowHigh:
	STZ $36
	STZ $37
	BRA _ExitJoyTbl

_ToggleRomRam:
	LDA $38
	BEQ _SwitchToRam
	STZ $38
	BRA _ExitJoyTbl

.ACCU 8
_SwitchToRam:
	LDA #$7E
	STA $38
_ExitJoyTbl:
	SEP #$20
	LDA #$FF
	STA $11
	STZ $39
	RTS

.ACCU 16
_IncByRegX:
	REP #$20
	CLC
	LDA $02
	ADC $36
	STA $36
	BRA _ExitJoyTbl

.ACCU 16
_IncByRegY:
	REP #$20
	CLC
	LDA $04
	ADC $36
	STA $36
	BRA _ExitJoyTbl

.ACCU 16
_IncByRegA:
	REP #$20
	CLC
	LDA $00
	ADC $36
	STA $36
	BRA _ExitJoyTbl

.ACCU 8
_IncCursAdd:
	STZ $39
	LDA $3A
	BEQ _IncCursBank
	DEC A
	BEQ _IncCursLow
	DEC A
	BEQ _IncCursHigh
	LDA $36
	CLC
	ADC #$10
	STA $36
	BRA _CursorAddTmp

_DecCursAdd:
	STZ $39
	LDA $3A
	BEQ _DecCursBank
	DEC A
	BEQ _DecCursLow
	DEC A
	BEQ _DecCursHigh
	LDA $36
	SEC
	SBC #$10
	STA $36
	BRA _CursorAddTmp

_IncCursBank:
	INC $38
	INC $38
_DecCursBank:
	DEC $38
_CursorAddTmp:
	LDA #$02
	STA $11
	RTS

_DecCursLow:
	LDA $37
	SEC
	SBC #$10
	STA $37
	BRA _CursorAddTmp

_DecCursHigh:
	LDA $37
	AND #$F0
	STA $12
	LDA $37
	DEC A
	AND #$0F
	ORA $12
	STA $37
	BRA _CursorAddTmp

_IncCursLow:
	LDA $37
	CLC
	ADC #$10
	STA $37
	BRA _CursorAddTmp

_IncCursHigh:
	LDA $37
	AND #$F0
	STA $12
	LDA $37
	INC A
	AND #$0F
	ORA $12
	STA $37
	BRA _CursorAddTmp

_DecCursPos:
	LDA $3A
	BEQ _CursorPosTmp
	DEC $3A
_CursorPosTmp:
	LDA #$02
	STA $11
	RTS

_IncCursPos:
	LDA $3A
	CMP #$03
	BEQ _CursorPosTmp
	INC $3A
	JMP _CursorPosTmp

_DecAddOne:
	LDX $36
	DEX
	STX $36
	STZ $39
	LDA #$02
	STA $11
	RTS

_IncAddOne:
	LDX $36
	INX
	STX $36
	STZ $39
	LDA #$02
	STA $11
	RTS

.ACCU 16
.INDEX 16
StartDBBRK:
	REP #$20
	PHB
	PHD
	PHA
	SEP #$20
	PHK
	PLB
	STZ NMITIMEN
	STZ HDMAEN
	REP #$30
	LDA #RAM_DbBrk
	TCD
	PLA
	STA $00
	PLA
	STA $06
	STX $02
	STY $04
	SEP #$20
	LDX #$0000
-	PLA
	STA $08,X
	INX
	CPX #$0005
	BNE -
	TSX
	STX $0D
	STX $36
	LDA #$7E
	STA $38
	STZ $3B
	JSR _SetupScreen
	JSR _UploadTilemap
	STZ $39
	LDA #$01
	STA NMITIMEN
	STZ $11
	STZ $3A
_LoopDBBRK:
	JSR _ReadRow
	PHP
-	LDA HVBJOY
	BMI -
-	LDA HVBJOY
	BPL -
	PLP
	BCC +
	LDA $39
	REP #$20
	XBA
	AND #$FF00
	LSR A
	LSR A
	LSR A
	ADC #$0560
	TAY
	SEP #$20
	JSR _DrawStrBuf
	INC $39
+	LDA $3A
	BEQ +
	INC A
+	STA $12
	STZ $13
	REP #$20
	LDA #_CursorStr.W+4
	SEC
	SBC $12
	TAY
	LDX #$0541
	SEP #$20
	JSR _DrawTiles
	JSR _HandleJoypad
	JMP _LoopDBBRK

_CursorStr:	.DB "    V  \n"

.ACCU 8
.INDEX 16
_UploadTilemap:
	REP #$10
	SEP #$20
	LDA #$00
	STA VMADDL
	LDA #$40
	STA VMADDH
	LDA #$80
	STA VMAINC
	LDX #$0000
-	LDA _CharMap.L,X
	STA VMDATAWL
	STA VMDATAWH
	INX
	CPX #$0200
	BNE -
	LDA #$04
	STA BG12NBA
	LDA #$04
	STA BG1SC
	LDA #$00
	STA VMADDL
	LDA #$04
	STA VMADDH
	LDX #$03FF
-	STZ VMDATAWL
	STZ VMDATAWH
	DEX
	BPL -
	STZ CGADD
	STZ CGDATAW
	STZ CGDATAW
	LDA #$03
	STA CGADD
	LDA #$FF
	STA CGDATAW
	STA CGDATAW
	LDA #$01
	STA TM
	LDY #_StringsDBBRK.W
-	REP #$20
	LDA $0000,Y
	BEQ _ReadStackDump
	TAX
	INY
	INY
	SEP #$20
	JSR _DrawTiles
	BRA -

.ACCU 8
.INDEX 16
_ReadStackDump:
	SEP #$20
	LDA $09
	STA $12
	LDY #$0008
	LDX #$0000
-	ASL $12
	LDA #$18
	ROL A
	STA $16,X
	INX
	DEY
	BNE -
	SEP #$10
	LDY $19
	LDA _FlagsWB.W-48,Y ; X
	STA $19
	LDY $18
	LDA _FlagsWB.W-48,Y ; M
	STA $18
	LDY $1B
	LDA _FlagsED.W-48,Y ; I
	STA $1B
	REP #$10
	LDY #$0490
	JSR _DrawStrBuf
	LDX #$0000
	LDA $01
	JSR _GetHexValue
	LDA $09
	AND #$20
	BEQ +
	JSR _DrawColon
+	LDA $00
	JSR _GetHexValue
	LDY #$0488
	JSR _DrawStrBuf
	LDX #$0000
	LDA $03
	JSR _GetHexValue
	LDA $09
	AND #$10
	BEQ +
	JSR _DrawColon
+	LDA $02
	JSR _GetHexValue
	LDY #$04A8
	JSR _DrawStrBuf
	LDX #$0000
	LDA $05
	JSR _GetHexValue
	LDA $09
	AND #$10
	BEQ +
	JSR _DrawColon
+	LDA $04
	JSR _GetHexValue
	LDY #$04C8
	JSR _DrawStrBuf
	LDX #$0000
	REP #$20
	LDA $0D
	SEP #$20
	JSR _GetHexWord
	LDY #$04E8
	JSR _DrawStrBuf
	LDX #$0000
	REP #$20
	LDA $06
	SEP #$20
	JSR _GetHexWord
	LDY #$04F2
	JSR _DrawStrBuf
	LDX #$0000
	LDA $08
	JSR _GetHexValue
	LDY #$04D2
	JSR _DrawStrBuf
	LDX #$0000
	LDA $0C
	JSR _GetHexValue
	JSR _DrawColon
	REP #$20
	LDA $0A
	SEP #$20
	JSR _GetHexWord
	LDY #$04B2
	JSR _DrawStrBuf
	JSR _GetBrkSig
	LDA #$0F
	STA INIDISP
	RTS

_FlagsWB:	.DB "WB" ; WORD ? BYTE
_FlagsED:	.DB "ED" ; ENABLED ? DISABLED

_DrawColon:
	LDA #':'
	STA $16,X
	INX
	RTS

_StringsDBBRK:
	.DB $23,$04,"*** DBBRK VERSION 1.0 ***\n"
	.DB $68,$04,"H  L\n"
	.DB $86,$04,"A\n"
	.DB $A6,$04,"X\n"
	.DB $C6,$04,"Y\n"
	.DB $E2,$04,"STACK\n"
	.DB $70,$04,"NVMXDIZC\n"
	.DB $AF,$04,"PC\n"
	.DB $D0,$04,"B\n"
	.DB $F0,$04,"D\n"
	.DW 0

.ACCU 8
.INDEX 8
_SetupScreen:
	SEP #$30
	LDA #$80
	STA INIDISP
	LDX #$02
-	STZ OBJSEL,X
	STZ VMAINC,X
	DEX
	BPL -
	LDX #$07
-	STZ BGMODE,X
	STZ BG1HOFS,X
	STZ BG1HOFS,X
	DEX
	BPL -
	STZ CGADD
	STZ SETINI
	LDX #$0E
-	STZ W12SEL,X
	STZ NMITIMEN,X
	DEX
	BPL -
	LDA #$30
	STA CGSWSEL
	RTS

_CharMap:	.INCBIN "characters.map"

.ENDS

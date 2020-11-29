CODE_05BC00:
	PHB
	PHK
	PLB
	JSR CODE_05BC76
	JSR CODE_05BCA5
	JSR CODE_05BC4A
	LDA wm_L1NextPosX
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC wm_L1CurXChange
	STA wm_L1CurXChange
	LDA wm_L1NextPosY
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC wm_L1CurYChange
	STA wm_L1CurYChange
	LDA wm_L2NextPosX
	SEC
	SBC wm_Bg2HOfs
	LDY wm_ScrollSprL2
	DEY
	BNE +
	TYA
+	STA wm_L2CurXChange
	LDA wm_L2NextPosY
	SEC
	SBC wm_Bg2VOfs
	STA wm_L2CurYChange
	LDA wm_L3ScrollFlag
	BNE +
	JSR CODE_05C40C
+	PLB
	RTL

Return05BC49:
	RTS

CODE_05BC4A:
	REP #$20
	LDY wm_L3TideSetting
	BNE CODE_05BC5F
	LDA wm_L2NextPosX
	SEC
	SBC wm_L1NextPosX
	STA wm_26
	LDA wm_L2NextPosY
	BRA _05BC69

CODE_05BC5F:
	LDA wm_Bg3HOfs
	SEC
	SBC wm_L1NextPosX
	STA wm_26
	LDA wm_Bg3VOfs
_05BC69:
	SEC
	SBC wm_L1NextPosY
	STA wm_28
	SEP #$20
	RTS

CODE_05BC72:
	JSR CODE_05BC4A
	RTL

CODE_05BC76:
	STZ wm_ScrollSprIndex
	LDA.W wm_SpritesLocked
	BNE Return05BC49
	LDA wm_ScrollSprNum
	BEQ Return05BC49
	JSL ExecutePtr

Ptrs05BC87:
	.DW CODE_05C04D
	.DW CODE_05C04D
	.DW Return05BC49
	.DW Return05BC49
	.DW ADDR_05C283
	.DW ADDR_05C69E
	.DW Return05BC49
	.DW _Return05BFF5
	.DW CODE_05C51F
	.DW Return05BC49
	.DW ADDR_05C32E
	.DW CODE_05C727
	.DW CODE_05C787
	.DW Return05BC49
	.DW Return05BC49

CODE_05BCA5:
	LDA #$04
	STA wm_ScrollSprIndex
	LDA wm_ScrollSprL2
	BEQ Return05BC49
	LDY.W wm_SpritesLocked
	BNE Return05BC49
	JSL ExecutePtr

Ptrs05BCB8:
	.DW CODE_05C04D
	.DW CODE_05C198
	.DW CODE_05C955
	.DW CODE_05C5BB
	.DW ADDR_05C283
	.DW Return05BC49
	.DW ADDR_05C659
	.DW _Return05BFF5
	.DW CODE_05C51F
	.DW _05C7C1
	.DW ADDR_05C32E
	.DW CODE_05C727
	.DW CODE_05C787
	.DW CODE_05C7BC
	.DW CODE_05C81C

CODE_05BCD6:
	PHB
	PHK
	PLB
	STZ wm_ScrollSprIndex
	JSR CODE_05BCE9
	LDA #$04
	STA wm_ScrollSprIndex
	JSR CODE_05BD0E
	PLB
	RTL

CODE_05BCE9:
	LDA wm_ScrollSprNum
	JSL ExecutePtr

Ptrs05BCF0:
	.DW CODE_05BD36
	.DW CODE_05BD36
	.DW CODE_05BF6A
	.DW CODE_05BF0A
	.DW ADDR_05BDDD
	.DW ADDR_05BFBA
	.DW ADDR_05BF97
	.DW Return05BD35
	.DW CODE_05BEA6
	.DW Return05BC49
	.DW ADDR_05BE3A
	.DW CODE_05BFF6
	.DW CODE_05C005
	.DW CODE_05C01A
	.DW CODE_05C036

CODE_05BD0E:
	LDA wm_ScrollSprL2
	BEQ Return05BD35
	JSL ExecutePtr

Ptrs05BD17:
	.DW _05BD4C
	.DW _05BD4C
	.DW Return05BC49
	.DW _05BF20
	.DW _05BDF0
	.DW Return05BC49
	.DW Return05BC49
	.DW Return05BD35
	.DW _05BEC6
	.DW _05C022
	.DW _05BE4D
	.DW Return05BC49
	.DW Return05BC49
	.DW Return05BC49
	.DW Return05BC49

Return05BD35:
	RTS

CODE_05BD36:
	STZ wm_HorzScrollHead
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA DATA_05C9D1,Y
	STA wm_ScrollSprNum
	LDA DATA_05C9DB,Y
	STA wm_InitYScrollL1
_05BD4C:
	LDX wm_ScrollSprIndex
	REP #$20
	STZ wm_ScrollSpeedL1X,X
	STZ wm_ScrollSpeedL1Y,X
	STZ wm_SprScrollL1X,X
	STZ wm_SprScrollL1Y,X
	SEP #$20
	TXA
	LSR
	LSR
	TAX
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	BEQ +
	LDY wm_InitYScrollL2
+	LDA DATA_05CA61,Y
	STA wm_ScrollTypeL1,X
	LDA DATA_05CA68,Y
	STA wm_ScrollTimerL1,X
	RTS

ADDR_05BD7B: ; unreachable
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA UNK_05C9E5,Y
	STA wm_ScrollSprNum
	LDA UNK_05C9E7,Y
	STA wm_InitYScrollL1
	REP #$20
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDY wm_InitYScrollL2
+	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA UNK_05C9E9,Y
	STA wm_ScrollTypeL1,X
	LDA UNK_05CBC7,Y
	AND #$00FF
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	CLC
	ADC wm_L1NextPosY,X
	AND #$00FF
	STA wm_SprScrollL1X,X
	STZ wm_SprScrollL1Y,X
_05BDC9:
	STZ wm_ScrollSpeedL1X,X
	STZ wm_ScrollSpeedL1Y,X
_05BDCF:
	SEP #$20
	TXA
	LSR
	LSR
	AND #$FF
	TAX
	LDA #$FF
	STA wm_ScrollTimerL1,X
	RTS

ADDR_05BDDD:
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA DATA_05CA08,Y
	STA wm_ScrollSprNum
	LDA DATA_05CA0C,Y
	STA wm_InitYScrollL1
_05BDF0:
	REP #$20
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDY wm_InitYScrollL2
+	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA DATA_05CA10,Y
	STA wm_ScrollTypeL1,X
	PHA
	TYA
	ASL
	TAY
	LDA DATA_05CA12,Y
	STA m0
	PLA
	TAY
	LDX wm_ScrollSprIndex
	LDA m0
	CPY #$01
	BEQ +
	EOR #$FFFF
	INC A
+	CLC
	ADC wm_L1NextPosY,X
	STA wm_SprScrollL1X,X
	STZ wm_ScrollSpeedL1X,X
	STZ wm_ScrollSpeedL1Y,X
	STZ wm_SprScrollL1Y,X
	SEP #$20
	RTS

ADDR_05BE3A:
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA DATA_05CA16,Y
	STA wm_ScrollSprNum
	LDA DATA_05CA1E,Y
	STA wm_InitYScrollL1
_05BE4D:
	REP #$20
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDY wm_InitYScrollL2
+	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA DATA_05CA26,Y
	STA wm_ScrollTypeL1,X
	TAY
	LDX wm_ScrollSprIndex
	LDA #$0F17
	CPY #$01
	BEQ +
	EOR #$FFFF
	INC A
+	STA wm_SprScrollL1Y,X
	STZ wm_ScrollSpeedL1X,X
	STZ wm_ScrollSpeedL1Y,X
	STZ wm_SprScrollL1X,X
	SEP #$20
	RTS

CODE_05BE8A:
	PHB
	PHK
	PLB
	REP #$20
	LDA.W DATA_05CA26
	STA wm_L3ScrollDir
	STZ wm_XSpeedL3
	STZ wm_YSpeedL3
	STZ wm_AccSpeedL3
	LDA wm_Bg1VOfs
	STA wm_Bg3VOfs
	SEP #$20
	PLB
	RTL

CODE_05BEA6:
	STZ wm_HorzScrollHead
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA DATA_05CA3E,Y
	STA wm_ScrollSprNum
	LDA DATA_05CA42,Y
	STA wm_InitYScrollL1
	STZ wm_Bg1HOfs
	STZ wm_L1NextPosX
	STZ wm_Bg2HOfs
	STZ wm_L2NextPosX
_05BEC6:
	REP #$20
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDY wm_InitYScrollL2
+	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA DATA_05CA46,Y
	STA wm_ScrollTypeL1,X
	TAX
	TYA
	ASL
	TAY
	LDA DATA_05CBED,Y
	AND #$00FF
	CPX #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	CLC
	ADC wm_L1NextPosX,X
	AND #$00FF
	STA wm_SprScrollL1Y,X
	STZ wm_SprScrollL1X,X
	JMP _05BDC9

CODE_05BF0A:
	STZ wm_VertScrollLyr2
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA DATA_05CA48,Y
	STA wm_ScrollSprNum
	LDA DATA_05CA52,Y
	STA wm_InitYScrollL1
_05BF20:
	REP #$20
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDY wm_InitYScrollL2
+	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA DATA_05CA5C,Y
	STA wm_ScrollTypeL1,X
	TAX
	TYA
	ASL
	TAY
	LDA DATA_05CBF5,Y
	AND #$00FF
	CPX #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	CLC
	ADC wm_L1NextPosY,X
	AND #$00FF
	STA wm_SprScrollL1X,X
	STZ wm_SprScrollL1Y,X
	STZ wm_ScrollSpeedL1Y,X
	STZ wm_ScrollSpeedL1Y,X
	JMP _05BDCF

CODE_05BF6A:
	LDY wm_InitYScrollL1
	LDA DATA_05C94F,Y
	STA wm_InitYScrollL1
	LDA DATA_05C952,Y
	STA wm_InitYScrollL2
	REP #$20
	LDA #$0200
	JSR _05BFD2
	LDA wm_InitYScrollL1
	CLC
	ADC.B #$0A
	TAX
	LDY #$01
	JSR _05C95B
	REP #$20
	LDA wm_L2NextPosY
	STA wm_Bg2VOfs
	JMP _05C32B

ADDR_05BF97:
	STZ wm_HorzScrollHead
	REP #$20
	STZ wm_Bg1HOfs
	STZ wm_L1NextPosX
	STZ wm_Bg2HOfs
	STZ wm_L2NextPosX
	LDA #$0600
	STA wm_ScrollSprNum
	STZ wm_ScrollSpeedL2Y
	STZ wm_SprScrollL2Y
	SEP #$20
	LDA #$60
	STA wm_InitYScrollL2
	RTS

ADDR_05BFBA:
	STZ wm_HorzScrollHead
	REP #$20
	STZ wm_Bg2HOfs
	STZ wm_L2NextPosX
	LDA #$03C0
	STA wm_Bg2VOfs
	STA wm_L2NextPosY
	STZ wm_InitYScrollL1
	LDA #$0005
_05BFD2:
	STZ wm_ScrollTimerL1
_05BFD5:
	STZ wm_ScrollTypeL1
	STA wm_ScrollSprNum
	STZ wm_ScrollSpeedL1X
	STZ wm_ScrollSpeedL1Y
	STZ wm_SprScrollL1X
	STZ wm_SprScrollL1Y
	STZ wm_ScrollSpeedL2X
	STZ wm_ScrollSpeedL2Y
	STZ wm_SprScrollL2X
	STZ wm_SprScrollL2Y
	SEP #$20
_Return05BFF5:
	RTS

CODE_05BFF6:
	REP #$20
	LDA #$0B00
	BRA _05BFD2

DATA_05BFFD:	.DB $00,$00,$02,$00

DATA_05C001:	.DB $80,$00,$00,$01

CODE_05C005:
	STZ wm_HorzScrollHead
	LDA wm_InitYScrollL1
	ASL
	TAY
	REP #$20
	LDA DATA_05BFFD,Y
	STA wm_InitYScrollL1
	LDA #$000C
	BRA _05BFD2

CODE_05C01A:
	REP #$20
	LDA #$0D00
	JSR _05BFD2
_05C022:
	STZ wm_HorzScrollLyr2
	REP #$20
	STZ wm_ScrollSpeedL2X
	STZ wm_ScrollSpeedL2Y
	STZ wm_SprScrollL2X
	STZ wm_SprScrollL2Y
	SEP #$20
	RTS

CODE_05C036:
	LDY wm_InitYScrollL1
	LDA DATA_05C808,Y
	STA wm_ScrollTimerL1
	LDA DATA_05C80B,Y
	STA wm_ScrollTimerL2
	REP #$20
	LDA #$0E00
	JMP _05BFD5

CODE_05C04D:
	LDA wm_ScrollSprIndex
	LSR
	LSR
	TAX
	LDA wm_ScrollTimerL1,X
	BNE CODE_05C05F
	LDX wm_ScrollSprIndex
	STZ wm_ScrollSpeedL1X,X
	RTS

CODE_05C05F:
	REP #$20
	LDA wm_ScrollTypeL1,X
	TAY
	LDA DATA_05CA6F-1,Y
	AND #$00FF
	STA m4
	LDA DATA_05CABF-1,Y
	AND #$00FF
	STA m6
	LDA wm_ScrollSprIndex
	AND #$00FF
	TAX
	LDA wm_L1NextPosX,X
	STA m0
	LDA wm_L1NextPosY,X
	STA m2
	LDX #$02
	LDA DATA_05CA6F,Y
	AND #$00FF
	CMP m4
	BNE CODE_05C098
	STZ m4
	STX m8
	BRA _05C0AD

CODE_05C098:
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC m0
	STA m0
	BPL +
	LDX #$00
	EOR #$FFFF
	INC A
+	STA m4
	STX m8
_05C0AD:
	LDX #$00
	LDA DATA_05CABF,Y
	AND #$00FF
	CMP m6
	BNE CODE_05C0BD
	STZ m6
	BRA _05C0D0

CODE_05C0BD:
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC m2
	STA m2
	BPL +
	LDX #$02
	EOR #$FFFF
	INC A
+	STA m6
_05C0D0:
	LDA wm_IsVerticalLvl
	LSR
	BCS +
	LDX m8
+	STX wm_Layer1ScrollDir
	LDA #$FFFF
	STA m8
	LDA m4
	STA m10
	LDA m6
	STA m12
	CMP m4
	BCC +
	STA m10
	LDA m4
	STA m12
	LDA #$0001
	STA m8
+	LDA m10
	STA WRDIVL
	SEP #$20
	LDA DATA_05CB0F,Y
	STA WRDIVB
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA RDDIVL
	BNE CODE_05C123
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	INC wm_ScrollTypeL1,X
	SEP #$20
	DEC wm_ScrollTimerL1,X
	JMP CODE_05C04D

CODE_05C123:
	STA m10
	LDA m12
	ASL
	ASL
	ASL
	ASL
	STA m12
	LDY #$10
	LDA.W #$0000
	STA m14
-	ASL m12
	ROL
	CMP m10
	BCC +
	SBC m10
+	ROL m14
	DEY
	BNE -
	LDA wm_ScrollSprIndex
	AND.W #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	TAY
	LDA DATA_05CB0F,Y
	AND.W #$00FF
	ASL
	ASL
	ASL
	ASL
	STA m10
	LDX #$02
_05C15D:
	LDA m8
	BMI CODE_05C165
	LDA m10
	BRA _05C167

CODE_05C165:
	LDA m14
_05C167:
	BIT m0,X
	BPL +
	EOR.W #$FFFF
	INC A
+	PHX
	PHA
	TXA
	CLC
	ADC wm_ScrollSprIndex
	TAX
	PLA
	LDY #$00
	CMP wm_ScrollSpeedL1X,X
	BEQ ++
	BPL +
	LDY #$02
+	LDA wm_ScrollSpeedL1X,X
	CLC
	ADC DATA_05CB5F,Y
	STA wm_ScrollSpeedL1X,X
++	JSR CODE_05C4F9
	PLX
	DEX
	DEX
	BPL _05C15D
	SEP #$20
	RTS

CODE_05C198:
	JSR CODE_05C04D
	REP #$20
	LDA wm_L2NextPosX
	STA wm_L1NextPosX
	LDA wm_Bg2VOfs
	CLC
	ADC wm_Layer1DispYLo
	STA wm_Bg2VOfs
	SEP #$20
	RTS

ADDR_05C1AE: ; unreachable
	LDA wm_ScrollSprIndex
	LSR
	LSR
	TAX
	LDA wm_ScrollTimerL1,X
	BMI ADDR_05C1D4
	DEC wm_ScrollTimerL1,X
	LDA wm_ScrollTimerL1,X
	CMP #$20
	BCC +
	REP #$20
	LDX wm_ScrollSprIndex
	LDA wm_L1NextPosY,X
	EOR #$0001
	STA wm_L1NextPosY,X
+	JMP _05C32B

ADDR_05C1D4: ; unused
	REP #$30
	LDY wm_ScrollSprIndex
	LDA wm_SprScrollL1X,Y
	TAX
	LDA wm_L1NextPosY,Y
	CMP wm_SprScrollL1X,Y
	BCC ADDR_05C1EB
	STA m4
	STX m2
	BRA _05C1EF

ADDR_05C1EB: ; unused
	STA m2
	STX m4
_05C1EF:
	SEP #$10
	LDA m2
	CMP m4
	BCC ++
	SEP #$20
	LDA wm_ScrollSprIndex
	AND #$FF
	LSR
	LSR
	TAX
	LDA #$30
	STA wm_ScrollTimerL1,X
	REP #$20
	LDX wm_ScrollSprIndex
	STZ wm_ScrollSpeedL1Y,X
	STZ wm_SprScrollL1Y,X
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDY wm_InitYScrollL2
+	LDA UNK_05CBC7,Y
	AND #$00FF
	STA m0
	TXA
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	EOR #$0001
	STA wm_ScrollTypeL1,X
	AND #$00FF
	BNE +
	LDA m0
	EOR #$FFFF
	INC A
	STA m0
+	LDX wm_ScrollSprIndex
	LDA m0
	CLC
	ADC wm_SprScrollL1X,X
	STA wm_SprScrollL1X,X
++	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAY
	LDA wm_ScrollTypeL1,Y
	TAX
	LDA.W UNK_05CBC7+1,X
	AND #$00FF
	CPX #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	LDY #$00
	CMP wm_ScrollSpeedL1Y,X
	BEQ ++
	BPL +
	LDY #$02
+	LDA wm_ScrollSpeedL1Y,X
	CLC
	ADC DATA_05CB7B,Y
	STA wm_ScrollSpeedL1Y,X
++	JMP _05C31D

ADDR_05C283:
	REP #$20
	LDY wm_ScrollSprIndex
	LDA wm_SprScrollL1X,Y
	SEC
	SBC wm_L1NextPosY,Y
	BPL +
	EOR #$FFFF
	INC A
+	STA m2
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	AND #$00FF
	TAY
	LSR
	TAX
	LDA m2
	STA WRDIVL
	SEP #$20
	LDA.W DATA_05CBE3,X
	STA WRDIVB
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA RDDIVL
	BNE ++
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	TAY
	LDX wm_ScrollSprIndex
	LDA #$0200
	CPY #$01
	BNE +
	EOR #$FFFF
	INC A
+	CLC
	ADC wm_L1NextPosY,X
	STA wm_L1NextPosY,X
++	LDX wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDX wm_InitYScrollL2
+	LDA.W DATA_05CBE3,X
	AND #$00FF
	ASL
	ASL
	ASL
	ASL
	CPY #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	LDY #$00
	CMP wm_ScrollSpeedL1Y,X
	BEQ _05C31D
	BPL +
	LDY #$02
+	LDA wm_ScrollSpeedL1Y,X
	CLC
	ADC DATA_05CB9B,Y
	STA wm_ScrollSpeedL1Y,X
_05C31D:
	LDA wm_ScrollSprIndex
	AND #$00FF
	CLC
	ADC #$0002
	TAX
_05C328:
	JSR CODE_05C4F9
_05C32B:
	SEP #$20
	RTS

ADDR_05C32E:
	REP #$20
	LDY wm_ScrollSprIndex
	LDA wm_SprScrollL1Y,Y
	SEC
	SBC wm_L1NextPosX,Y
	BPL +
	EOR #$FFFF
	INC A
+	STA m2
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	AND #$00FF
	TAY
	LSR
	TAX
	LDA m2
	STA WRDIVL
	SEP #$20
	LDA.W DATA_05CBE5,X
	STA WRDIVB
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA RDDIVL
	BNE ++
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	TAY
	LDX wm_ScrollSprIndex
	LDA #$0600
	CPY #$01
	BNE +
	EOR #$FFFF
	INC A
+	CLC
	ADC wm_L1NextPosX,X
	STA wm_L1NextPosX,X
	LDA #$FFF8
	STA.W wm_Map16L1UploadLU,X
	LDA #$0017
	STA.W wm_Map16L1UploadRD,X
	STZ.W wm_MarioXPos+1
++	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	AND #$00FF
	PHA
	SEP #$20
	LDX #$02
	LDY #$00
	CMP #$01
	BEQ +
	LDX #$00
	LDY #$01
+	TXA
	STA.W wm_Layer1ScrollDir,Y
	REP #$20
	PLA
	TAY
	LDX wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	AND #$00FF
	BEQ +
	LDX wm_InitYScrollL2
+	LDA.W DATA_05CBE5,X
	AND #$00FF
	ASL
	ASL
	ASL
	ASL
	CPY #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	LDY #$00
	CMP wm_ScrollSpeedL1X,X
	BEQ ++
	BPL +
	LDY #$02
+	LDA wm_ScrollSpeedL1X,X
	CLC
	ADC DATA_05CBA3,Y
	STA wm_ScrollSpeedL1X,X
++	LDX wm_ScrollSprIndex
	JSR CODE_05C4F9
	SEP #$20
	RTS

DATA_05C406:	.DB $FF,$01

DATA_05C408:	.DB $FC,$04

DATA_05C40A:	.DB $30,$A0

CODE_05C40C:
	LDA wm_L3TideSetting
	BEQ CODE_05C414
	JMP CODE_05C494

CODE_05C414:
	REP #$20
	LDY wm_LvHeadTileset
	CPY #$01
	BEQ +
	CPY #$03
	BNE CODE_05C428
+	LDA wm_Bg1HOfs
	LSR
	STA wm_Bg3HOfs
	BRA _05C491

CODE_05C428:
	LDY.W wm_SpritesLocked
	BNE +++
	LDA wm_L3ScrollDir
	AND #$00FF
	TAY
	LDA.W DATA_05CBEB
	AND #$00FF
	ASL
	ASL
	ASL
	ASL
	CPY #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDY #$00
	CMP wm_XSpeedL3
	BEQ ++
	BPL +
	LDY #$02
+	LDA wm_XSpeedL3
	CLC
	ADC DATA_05CBBB,Y
	STA wm_XSpeedL3
++	LDA wm_AccSpeedL3
	AND #$00FF
	CLC
	ADC wm_XSpeedL3
	STA wm_AccSpeedL3
	AND #$FF00
	BPL +
	ORA #$00FF
+	XBA
	CLC
	ADC wm_Bg3HOfs
	STA wm_Bg3HOfs
	LDA wm_L1CurXChange
	AND #$00FF
	CMP #$0080
	BCC +
	ORA #$FF00
+	STA m0
	LDA wm_Bg3HOfs
	CLC
	ADC m0
	STA wm_Bg3HOfs
+++	LDA wm_Bg1VOfs
	STA wm_Bg3VOfs
_05C491:
	SEP #$20
	RTS

CODE_05C494:
	DEC A
	BNE +++
	LDA.W wm_SpritesLocked
	BNE +++
	LDY wm_L3ScrollDir
	LDA wm_FrameB
	AND #$03
	BNE ++
	LDA wm_YSpeedL3
	BNE +
	DEC wm_L3TideTimer
	BNE +++
+	CMP DATA_05C408,Y
	BEQ +
	CLC
	ADC DATA_05C406,Y
	STA wm_YSpeedL3
+	LDA #$4B
	STA wm_L3TideTimer
++	LDA wm_Bg3VOfs
	CMP DATA_05C40A,Y
	BNE +
	TYA
	EOR #$01
	STA wm_L3ScrollDir
+	LDA wm_YSpeedL3
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_AccSpeedL3
	STA wm_AccSpeedL3
	LDA wm_YSpeedL3
	PHP
	LSR
	LSR
	LSR
	LSR
	PLP
	BPL +
	ORA #$F0
+	ADC wm_Bg3VOfs
	STA wm_Bg3VOfs
+++	LDA wm_Bg3HOfs
	SEC
	ADC wm_L1CurXChange
	STA wm_Bg3HOfs
	LDA #$01
	STA wm_Bg3HOfs+1
	RTS

CODE_05C4F9:
	LDA wm_SprScrollL1X,X
	AND.W #$00FF
	CLC
	ADC wm_ScrollSpeedL1X,X
	STA wm_SprScrollL1X,X
	AND.W #$FF00
	BPL +
	ORA.W #$00FF
+	XBA
	CLC
	ADC wm_L1NextPosX,X
	STA wm_L1NextPosX,X
	LDA m8
	EOR.W #$FFFF
	INC A
	STA m8
	RTS

CODE_05C51F:
	REP #$30
	LDY wm_ScrollSprIndex
	REP #$30
	LDA wm_SprScrollL1Y,Y
	TAX
	LDA wm_L1NextPosX,Y
	CMP wm_SprScrollL1Y,Y
	BCC CODE_05C538
	STA m4
	STX m2
	BRA _05C53C

CODE_05C538:
	STA m2
	STX m4
_05C53C:
	SEP #$10
	LDA m2
	CMP m4
	BCC ++
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	BEQ +
	LDY wm_InitYScrollL2
+	TYA
	ASL
	TAY
	LDA DATA_05CBEE,Y
	AND #$00FF
	STA m0
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	EOR #$0001
	STA wm_ScrollTypeL1,X
	AND #$00FF
	BNE +
	LDA m0
	EOR #$FFFF
	INC A
	STA m0
+	LDX wm_ScrollSprIndex
	LDA m0
	CLC
	ADC wm_SprScrollL1Y,X
	STA wm_SprScrollL1Y,X
++	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	TAX
	LDA.W DATA_05CBF1,X
	AND #$00FF
	CPX #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	LDY #$00
	CMP wm_ScrollSpeedL1X,X
	BEQ ++
	BPL +
	LDY #$02
+	LDA wm_ScrollSpeedL1X,X
	CLC
	ADC DATA_05CBC3,Y
	STA wm_ScrollSpeedL1X,X
++	JMP _05C328

CODE_05C5BB:
	REP #$30
	LDY wm_ScrollSprIndex
	REP #$30
	LDA wm_SprScrollL1X,Y
	TAX
	LDA wm_L1NextPosY,Y
	CMP wm_SprScrollL1X,Y
	BCC CODE_05C5D4
	STA m4
	STX m2
	BRA _05C5D8

CODE_05C5D4:
	STA m2
	STX m4
_05C5D8:
	SEP #$10
	LDA m2
	CMP m4
	BCC ++
	LDY wm_InitYScrollL1
	LDA wm_ScrollSprIndex
	BEQ +
	LDY wm_InitYScrollL2
+	TYA
	ASL
	TAY
	LDA DATA_05CBF6,Y
	AND #$00FF
	STA m0
	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	EOR #$0001
	STA wm_ScrollTypeL1,X
	AND #$00FF
	BNE +
	LDA m0
	EOR #$FFFF
	INC A
	STA m0
+	LDX wm_ScrollSprIndex
	LDA m0
	CLC
	ADC wm_SprScrollL1X,X
	STA wm_SprScrollL1X,X
++	LDA wm_ScrollSprIndex
	AND #$00FF
	LSR
	LSR
	TAX
	LDA wm_ScrollTypeL1,X
	TAX
	LDA.W DATA_05CBF1,X
	AND #$00FF
	CPX #$01
	BEQ +
	EOR #$FFFF
	INC A
+	LDX wm_ScrollSprIndex
	LDY #$00
	CMP wm_ScrollSpeedL1Y,X
	BEQ ++
	BPL +
	LDY #$02
+	LDA wm_ScrollSpeedL1Y,X
	CLC
	ADC DATA_05CBC3,Y
	STA wm_ScrollSpeedL1Y,X
++	INX
	INX
	JMP _05C328

ADDR_05C659: ; not dis correctly in all.log
	LDA wm_InitYScrollL2
	BEQ ADDR_05C674
	DEC wm_InitYScrollL2
	CMP.B #$20
	BCS +
	LDA wm_FrameB
	AND.B #$01
	BNE +
	LDA wm_L1NextPosY
	EOR.B #$01
	STA wm_L1NextPosY
+	RTS

ADDR_05C674:
	STZ wm_Layer2ScrollDir
	REP #$20
	LDA wm_ScrollSpeedL2Y
	CMP #$FFC0
	BEQ +
	DEC A
	STA wm_ScrollSpeedL2Y
+	LDA wm_L2NextPosY
	CMP #$0031
	BPL +
	STZ wm_ScrollSpeedL2Y
+	BNE +
	LDY #$20
	STY wm_InitYScrollL2
+	LDX #$06
	JSR CODE_05C4F9
	JMP _05C32B

ADDR_05C69E: ; not dis correctly in all.log
	LDA.B #$02
	STA wm_Layer1ScrollDir
	STZ wm_Layer2ScrollDir
	REP #$20
	LDX wm_InitYScrollL1
	BNE ADDR_05C6CD
	LDA wm_ScrollSpeedL1X
	CMP #$0080
	BEQ +
	INC A
+	STA wm_ScrollSpeedL1X
	LDY wm_LastScreenHorz
	DEY
	CPY wm_L1NextPosX+1
	BNE _05C6EC
	INC wm_InitYScrollL1
	STZ wm_ScrollSpeedL1X
	LDA #$FCF0
	STA wm_1B97
	BRA _05C6EC

ADDR_05C6CD:
	LDY #$16
	STY TM
	LDA wm_ScrollSpeedL2Y
	CMP #$FF80
	BEQ +
	DEC A
+	STA wm_ScrollSpeedL2Y
	STA wm_ScrollSpeedL1Y
	LDA wm_L2NextPosY
	BNE _05C6EC
	STZ wm_ScrollSpeedL2Y
	STZ wm_ScrollSpeedL1Y
_05C6EC:
	LDX #$06
-	JSR CODE_05C4F9
	DEX
	DEX
	BPL -
	SEP #$20
	LDA wm_L1NextPosX+1
	SEC
	SBC wm_LastScreenHorz
	INC A
	INC A
	XBA
	LDA wm_L1NextPosX
	REP #$20
	LDY #$82
	CMP #$0000
	BPL +
	LDA #$0000
	LDY #$02
+	STA wm_L2NextPosX
	STA wm_Bg2HOfs
	STY wm_IsVerticalLvl
	JMP _05C32B

DATA_05C71B:	.DB $20,$00,$C1,$00

DATA_05C71F:	.DB $C0,$FF,$40,$00

DATA_05C723:	.DB $FF,$FF,$01,$00

CODE_05C727:
	LDX wm_OnOffStatus
	BEQ +
	LDX #$02
+	CPX wm_ScrollTypeL2
	BEQ CODE_05C74A
	DEC wm_ScrollTimerL2
	BPL +
	STX wm_ScrollTypeL2
+	LDA wm_L2NextPosY
	EOR.B #$01
	STA wm_L2NextPosY
	STZ wm_ScrollSpeedL2Y
	STZ wm_ScrollSpeedL2Y+1
	RTS

CODE_05C74A:
	LDA.B #$10
	STA wm_ScrollTimerL2
	REP #$20
	LDA wm_L2NextPosY
	CMP.W DATA_05C71B,X
	BNE CODE_05C770
	CPX #$00
	BNE +
	LDA #$0009
	STA wm_SoundCh3
	LDA #$0020
	STA wm_ShakeGrndTimer
+	LDX #$00
	STX wm_OnOffStatus
	BRA _05C784

CODE_05C770:
	LDA wm_ScrollSpeedL2Y
	CMP.W DATA_05C71F,X
	BEQ +
	CLC
	ADC.W DATA_05C723,X
	STA wm_ScrollSpeedL2Y
+	LDX #$06
	JSR CODE_05C4F9
_05C784:
	JMP _05C32B

CODE_05C787:
	LDA.B #$02
	STA wm_Layer1ScrollDir
	STA wm_Layer2ScrollDir
	LDA wm_ScrollSprIndex
	LSR
	LSR
	TAX
	LDY wm_InitYScrollL1,X
	LDX wm_ScrollSprIndex
	REP #$20
	LDA wm_ScrollSpeedL1X,X
	CMP DATA_05C001,Y
	BEQ +
	INC A
+	STA wm_ScrollSpeedL1X,X
	LDA wm_LastScreenHorz
	DEC A
	XBA
	AND #$FF00
	CMP wm_L1NextPosX,X
	BNE +
	STZ wm_ScrollSpeedL1X,X
+	JSR CODE_05C4F9
	JMP _05C32B

CODE_05C7BC:
	LDA wm_BGScrollFlag
	BEQ ++
_05C7C1:
	LDA.B #$02
	STA wm_Layer2ScrollDir
	REP #$20
	LDA wm_ScrollSpeedL2X
	CMP #$0400
	BEQ +
	INC A
+	STA wm_ScrollSpeedL2X
	LDX #$04
	JSR CODE_05C4F9
	LDA wm_L1CurXChange
	AND #$00FF
	CMP #$0080
	BCC +
	ORA #$FF00
+	CLC
	ADC wm_L2NextPosX
	STA wm_L2NextPosX
++	JMP _05C32B

DATA_05C7F0:
	.DB $00,$00,$F0,$02,$B0,$08,$00,$00
	.DB $00,$00,$70,$03

DATA_05C7FC:
	.DB $D0,$00,$50,$03,$30,$0A,$08,$00
	.DB $40,$00,$80,$03

DATA_05C808:	.DB $00,$06,$08

DATA_05C80B:	.DB $03,$01,$02

DATA_05C80E:	.DB $C0,$00

DATA_05C810:	.DB $00,$00,$B0,$00

DATA_05C814:	.DB $80,$FF,$C0,$00

DATA_05C818:	.DB $FF,$FF,$01,$00

CODE_05C81C:
	REP #$20
	STZ m0
	LDY wm_ScrollTimerL2
	STY m0
	LDY #$00
	LDX wm_ScrollTimerL1
	CPX #$08
	BCC _f
	LDY #$02
__	LDA wm_L2NextPosX
	CMP.W DATA_05C7F0,X
	BCC +
	CMP.W DATA_05C7FC,X
	BCS +
	STZ wm_ScrollTypeL1
	LDA DATA_05C80E,Y
	STA wm_L2NextPosY
	STZ wm_ScrollSpeedL2Y
	STZ wm_SprScrollL2Y
+	INX
	INX
	DEC m0
	BNE _b
	SEP #$20
	LDA wm_ScrollTypeL1
	ORA wm_IsTouchLayer2
	STA wm_ScrollTypeL1
	BEQ +
	REP #$20
	LDA wm_L2NextPosY
	CMP DATA_05C810,Y
	BEQ +
	LDA wm_ScrollSpeedL2Y
	CMP DATA_05C814,Y
	BEQ _05C875
	CLC
	ADC DATA_05C818,Y
_05C875:
	STA wm_ScrollSpeedL2Y
	LDX #$06
	JSR CODE_05C4F9
+	SEP #$20
	RTS

DATA_05C880:
	.DB $00,$00,$C0,$01,$00,$03,$00,$08
	.DB $38,$08,$00,$0A,$00,$00,$80,$03
	.DB $50,$04,$90,$08,$60,$09,$80,$0E
	.DB $00,$40,$00,$40,$00,$40,$00,$40
	.DB $00,$40,$00,$00

DATA_05C8A4:
	.DB $08,$00,$00,$03,$10,$04,$38,$08
	.DB $70,$08,$00,$0B,$08,$00,$50,$04
	.DB $A0,$04,$60,$09,$40,$0A,$FF,$0F
	.DB $00,$50,$00,$50,$00,$50,$00,$50
	.DB $00,$50,$80,$00

DATA_05C8C8:
	.DB $C0,$00,$B0,$00,$70,$00,$C0,$00
	.DB $C0,$00,$C0,$00,$00,$00,$00,$00
	.DB $C0,$00,$B0,$00,$A0,$00,$70,$00
	.DB $B0,$00,$B0,$00,$B0,$00,$00,$00
	.DB $00,$00,$B0,$00,$20,$00,$20,$00
	.DB $20,$00,$10,$00,$10,$00,$10,$00
	.DB $00,$00,$00,$00,$10,$00

DATA_05C8FE:
	.DB $00,$01,$00,$01,$00,$08,$00,$01
	.DB $00,$01,$00,$08,$00,$00,$00,$00
	.DB $80,$01,$00,$FF,$00,$FF,$00,$00
	.DB $00,$FF,$00,$FF,$00,$FF,$00,$FF
	.DB $00,$FF,$00,$FF,$00,$F8,$00,$F8
	.DB $00,$F8,$00,$F8,$00,$F8,$00,$F8
	.DB $00,$00,$00,$00,$40,$FE

DATA_05C934:
	.DB $80,$40,$01,$80,$00,$00,$80,$00
	.DB $40,$00,$00,$20,$40,$00,$20,$00
	.DB $00,$20,$80,$80,$20,$80,$80,$20
	.DB $00,$00,$A0

DATA_05C94F:	.DB $00,$0C,$18

DATA_05C952:	.DB $05,$05,$05

CODE_05C955:
	LDX wm_InitYScrollL1
	LDY wm_InitYScrollL2
_05C95B:
	REP #$20
-	LDA wm_L2NextPosX
	CMP.W DATA_05C880,X
	BCC +
	CMP.W DATA_05C8A4,X
	BCS +
	TXA
	LSR
	AND #$00FE
	STA wm_ScrollTypeL1
	LDA #$00C1
	STA wm_L2NextPosY
	STZ wm_ScrollTimerL1
+	INX
	INX
	DEY
	BNE -
	SEP #$20
	LDA wm_ScrollTimerL1
	BEQ CODE_05C98B
	DEC wm_ScrollTimerL1
	RTS

CODE_05C98B:
	LDA wm_ScrollTypeL1
	CLC
	ADC wm_ScrollTypeL2
	TAY
	LSR
	TAX
	REP #$20
	LDA wm_L2NextPosY
	SEC
	SBC DATA_05C8C8,Y
	EOR DATA_05C8FE,Y
	BPL CODE_05C9A9
	LDA DATA_05C8FE,Y
	JMP _05C875

CODE_05C9A9:
	LDA DATA_05C8C8,Y
	STA wm_L2NextPosY
	SEP #$20
	LDA.W DATA_05C934,X
	STA wm_ScrollTimerL1
	LDA wm_ScrollTypeL2
	CLC
	ADC #$12
	CMP #$36
	BCC +
	LDA #$09
	STA wm_SoundCh3
	LDA #$20
	STA wm_ShakeGrndTimer
	LDA #$00
+	STA wm_ScrollTypeL2
	RTS

DATA_05C9D1:	.DB $01,$01,$01,$00,$01,$01,$01,$00,$01,$09
DATA_05C9DB:	.DB $01,$00,$02,$00,$04,$03,$05,$00,$06,$00

UNK_05C9E5:	.DB $00,$01
UNK_05C9E7:	.DB $00,$00

UNK_05C9E9:
	.DB $00,$00,$02,$02,$02,$00,$02,$05
	.DB $02,$02,$05,$00,$00,$02,$01,$00
	.DB $03,$02,$03,$04,$03,$01,$00,$01
	.DB $00,$00,$03,$00,$00,$00,$00

DATA_05CA08:	.DB $00,$04,$00,$04
DATA_05CA0C:	.DB $00,$00,$00,$01
DATA_05CA10:	.DB $00,$01
DATA_05CA12:	.DB $40,$01,$E0,$00
DATA_05CA16:	.DB $05,$00,$00,$05,$05,$02,$02,$05
DATA_05CA1E:	.DB $00,$00,$00,$01,$02,$03,$04,$03

DATA_05CA26:
	.DB $01,$00,$01,$01,$00,$06,$00,$06
	.DB $00,$00,$00,$01,$00,$01,$08,$00
	.DB $00,$08,$00,$00,$00,$01,$01,$00

DATA_05CA3E:	.DB $00,$08,$00,$08
DATA_05CA42:	.DB $00,$00,$00,$01
DATA_05CA46:	.DB $01,$01
DATA_05CA48:	.DB $00,$03,$00,$03,$00,$03,$00,$03,$00,$03
DATA_05CA52:	.DB $00,$00,$00,$01,$00,$02,$00,$03,$00,$04
DATA_05CA5C:	.DB $01,$00,$00,$00,$00
DATA_05CA61:	.DB $01,$18,$1E,$29,$2D,$35,$47
DATA_05CA68:	.DB $16,$05,$0A,$03,$07,$11,$09

DATA_05CA6F:
	.DB $00,$09,$14,$1C,$24,$28,$33,$3C
	.DB $43,$4B,$54,$60,$67,$74,$77,$7B
	.DB $83,$8A,$8D,$90,$99,$A0,$B0,$00
	.DB $09,$14,$2C,$3C,$B0,$00,$09,$11
	.DB $1D,$2C,$32,$41,$48,$63,$6B,$70
	.DB $00,$27,$37,$70,$00,$07,$12,$27
	.DB $32,$48,$5B,$70,$00,$20,$28,$3A
	.DB $40,$5F,$66,$6B,$6B,$80,$80,$89
	.DB $92,$96,$9A,$9E,$A0,$B0,$00,$10
	.DB $1A,$20,$2B,$30,$3B,$40,$4B,$50

DATA_05CABF:
	.DB $0C,$0C,$06,$0B,$08,$0C,$03,$02
	.DB $09,$03,$09,$02,$06,$06,$07,$05
	.DB $08,$05,$0A,$04,$08,$04,$04,$0C
	.DB $0C,$07,$07,$05,$05,$0C,$0C,$08
	.DB $0C,$0C,$07,$07,$0A,$0A,$0C,$0C
	.DB $00,$00,$0A,$0A,$00,$00,$09,$09
	.DB $03,$03,$0C,$0C,$0C,$0C,$08,$08
	.DB $05,$05,$02,$02,$09,$09,$01,$01
	.DB $01,$02,$03,$07,$08,$08,$0C,$0C
	.DB $02,$02,$0A,$0A,$02,$02,$0A,$0A

DATA_05CB0F:
	.DB $07,$07,$07,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$08,$08,$08,$08
	.DB $08,$08,$10,$08,$40,$08,$04,$08
	.DB $10,$08,$08,$10,$10,$08,$08,$08
	.DB $08,$08,$08,$08,$08,$08,$08,$08

DATA_05CB5F:	.DW 1,-1,1,-1,1,-1,1,-1,1,-1,1,-1,1,-1
DATA_05CB7B:	.DW 1,-1,1,-1,1,-1,1,-1,1,-1,1,-1,1,-1,4,-4
DATA_05CB9B:	.DW 1,-1,1,-1
DATA_05CBA3:	.DW 4,-4,4,-4,4,-4,4,-4,1,-1,1,-1
DATA_05CBBB:	.DW 4,-4,4,-4
DATA_05CBC3:	.DW 1,-1

UNK_05CBC7:
	.DB $30,$70,$80,$10,$28,$30,$30,$30
	.DB $30,$14,$02,$30,$30,$30,$30,$70
	.DB $80,$70,$80,$70,$80,$70,$80,$70
	.DB $80,$70,$80,$18

DATA_05CBE3:	.DB $18,$18
DATA_05CBE5:	.DB $18,$18,$08,$20,$06,$06
DATA_05CBEB:	.DB $04,$04
DATA_05CBED:	.DB $60
DATA_05CBEE:	.DB $42,$D0,$B2
DATA_05CBF1:	.DB $80,$80,$80,$80
DATA_05CBF5:	.DB $90
DATA_05CBF6:	.DB $72,$60,$42,$20,$10,$40,$22,$20,$10

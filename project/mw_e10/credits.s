DATA_0C9380:	.INCBIN "images/other/black.bin"

CODE_0C938D:
	PHB
	PHK
	PLB
	SEP #$30
	JSR CODE_0C9F6A
	JSR CODE_0CAB1F
	PLB
	RTL

CODE_0C939A:
	PHB
	PHK
	PLB
	JSR CODE_0CA0E3
	JSR CODE_0CA1D4
	PLB
	RTL

CODE_0C93A5:
	PHB
	PHK
	PLB
	JSR CODE_0CAEAD
	PLB
	RTL

CODE_0C93AD:
	PHB
	PHK
	PLB
	DEC wm_YSpeedL3+1
	BNE +
	LDA #$23
	STA wm_GameMode
	LDA #$FF
	STA wm_CreditsEnemyNum
+	PLB
	RTL

DATA_0C93C1:
	.DB $5A,$F4,$C0,$E7,$82,$EC,$44,$DD
	.DB $00,$D9,$59,$DF,$54,$DE

DATA_0C93CF:
	.DB $FF,$FF,$FF,$FE,$FF,$FE,$FF,$FE
	.DB $FF,$FF,$FF,$FE,$FF,$FE

CODE_0C93DD:
	REP #$30
	STZ wm_LvLoadScreen
-	LDA wm_LvLoadScreen
	AND #$00FF
	ASL
	TAX
	LDA.L DATA_0C93C1,X
	STA wm_Bg2Ptr
	LDA.L DATA_0C93CF,X
	STA wm_Bg1Ptr
	SEP #$20
	LDY #$0000
	LDX wm_Bg2Ptr
	CPX #Layer2Cave
	BCC +
	LDY #$0001
+	LDX #$0000
	TYA
--	STA wm_L2TilesHi,X
	STA wm_L2TilesHi+$0200,X
	INX
	CPX #$0200
	BNE --
	LDA #:Layer2BGBank
	STA wm_Bg2Ptr+2
	LDX #wm_L2TilesLo&$FFFF
	STX m13
	REP #$20
	JSR CODE_0C944C
	JSR CODE_0C94C0
	INC wm_LvLoadScreen
	LDA wm_LvLoadScreen
	CMP #$0007
	BNE -
	LDA #$5840
	STA wm_Bg1Ptr
	SEP #$30
	STZ wm_Bg1Ptr+2
	STZ wm_LvLoadScreen
	JSL CODE_0C9567
	JSR CODE_0CA051
	LDA #$09
	STA wm_MusicCh1
	RTL

CODE_0C944C:
	REP #$30
	LDY #$0000
	STY m3
	STY m5
	SEP #$20
	LDA #$7E
	STA m15
_0C945B:
	LDY m3
	LDA [wm_Bg2Ptr],Y
	STA m7
	INY
	STY m3
	AND #$80
	BEQ CODE_0C9480
	LDA m7
	AND #$7F
	STA m7
	LDA [wm_Bg2Ptr],Y
	INY
	STY m3
	LDY m5
-	STA [m13],Y
	INY
	DEC m7
	BPL -
	STY m5
	BRA _0C9492

CODE_0C9480:
	LDY m3
	LDA [wm_Bg2Ptr],Y
	INY
	STY m3
	LDY m5
	STA [m13],Y
	INY
	STY m5
	DEC m7
	BPL CODE_0C9480
_0C9492:
	LDY m3
	LDA [wm_Bg2Ptr],Y
	CMP #$FF
	BNE _0C945B
	INY
	LDA [wm_Bg2Ptr],Y
	CMP #$FF
	BNE _0C945B
	REP #$20
	LDA.W #DATA_0D9100
	STA m0
	LDX #$0000
-	LDA m0
	STA wm_Map16TilePtrs,X
	LDA m0
	CLC
	ADC #$0008
	STA m0
	INX
	INX
	CPX #$0400
	BNE -
	RTS

CODE_0C94C0:
	SEP #$20
	REP #$10
	LDX #wm_L2TilesLo&$FFFF
	STX wm_Map16BlkPtrL
	LDA #wm_L2TilesLo>>16
	STA wm_Map16BlkPtrL+2
	STA wm_Map16BlkPtrH+2
	LDX #wm_L2TilesHi&$FFFF
	STX wm_Map16BlkPtrH
	LDA #:Map16TilesBank
	STA wm_Bg2Ptr+2
	LDY #$00F0
	STY m4
	LDA wm_LvLoadScreen
	XBA
	AND #$00
	TAX
	STX m0
	LDX #$007F
	STX m8
-	SEP #$20
	LDY m4
	LDA [wm_Map16BlkPtrL],Y
	STA m2
	LDA [wm_Map16BlkPtrH],Y
	STA m3
	REP #$20
	LDA m2
	ASL
	TAX
	LDA wm_Map16TilePtrs,X
	STA wm_Bg2Ptr
	LDY #$0000
	LDA m0
	ASL
	ASL
	PHA
	AND #$003F
	STA m6
	PLA
	AND #$FFC0
	ASL
	ORA m6
	TAX
	LDA [wm_Bg2Ptr],Y
	AND wm_Bg1Ptr
	STA wm_OW_L2Tiles,X
	INY
	INY
	LDA [wm_Bg2Ptr],Y
	AND wm_Bg1Ptr
	STA wm_OW_L2Tiles+64,X
	INY
	INY
	LDA [wm_Bg2Ptr],Y
	AND wm_Bg1Ptr
	STA wm_OW_L2Tiles+2,X
	INY
	INY
	LDA [wm_Bg2Ptr],Y
	AND wm_Bg1Ptr
	STA wm_OW_L2Tiles+64+2,X
	INC m0
	INC m4
	DEC m8
	BPL -
	LDA #$007F
	STA m8
	LDA m4
	CMP #$0170
	BNE Return0C9558
	LDA #$02A0
	STA m4
	BRA -

Return0C9558:
	RTS

PARAMS_0C9559:
	.DB $01,$18
	.DL wm_OW_L2Tiles
	.DB $00,$04

PARAMS_0C9560:
	.DB $01,$18
	.DL wm_OW_L2SubTiles
	.DB $00,$04

CODE_0C9567:
	SEP #$30
	PHB
	PHK
	PLB
	LDA #$80
	STA VMAINC
	LDA #$C0
	STA VMADDL
	LDA #$30
	STA VMADDH
	LDY #$06
-	LDA PARAMS_0C9559,Y
	STA CH1.PARAM,Y
	DEY
	BPL -
	LDA wm_LvLoadScreen
	ASL
	ASL
	ASL
	ORA CH1.ADDA1M
	STA CH1.ADDA1M
	LDA #$02
	STA MDMAEN
	LDA #$80
	STA VMAINC
	LDA #$C0
	STA VMADDL
	LDA #$34
	STA VMADDH
	LDY #$06
-	LDA PARAMS_0C9560,Y
	STA CH1.PARAM,Y
	DEY
	BPL -
	LDA wm_LvLoadScreen
	ASL
	ASL
	ASL
	ORA CH1.ADDA1M
	STA CH1.ADDA1M
	LDA #$02
	STA MDMAEN
	STZ wm_UpdateCreditBG
	PLB
	RTL

DATA_0C95C7:	.DB $07 ; todo: check

DATA_0C95C8:	.INCLUDE "images/ending/credit_data.a"

DATA_0C9D18:	.INCLUDE "images/ending/credit_pointers.a"

DATA_0C9EAC:	.DB $40,$3E,$FC,$00,$FF

CODE_0C9EB1:
	REP #$30
	LDA wm_ImageIndex
	TAX
	LDY #$0000
	SEP #$20
	LDA wm_Bg1Ptr+1
	STA wm_ImageTable,X
	LDA wm_Bg1Ptr
	STA wm_ImageTable.1.ImgH,X
	INX
	INX
-	LDA DATA_0C9EAC,Y
	STA wm_ImageTable,X
	INX
	INY
	CPY #$0005
	BNE -
	REP #$20
	DEX
	TXA
	STA wm_ImageIndex
	LDA wm_Bg1Ptr+2
	AND #$00FF
	ASL
	TAY
	LDA DATA_0C9D18,Y
	TAY
	SEP #$20
	INC wm_Bg1Ptr+2
	LDA DATA_0C95C7,Y
	CMP #$FF
	BEQ +
	LDA DATA_0C95C7,Y
	STA m2
	LDA DATA_0C95C8,Y
	STA m0
	STZ m1
	INY
	INY
	LDA wm_Bg1Ptr+1
	STA wm_ImageTable,X
	LDA wm_Bg1Ptr
	CLC
	ADC m2
	STA wm_ImageTable.1.ImgH,X
	INX
	INX
	LDA m1
	STA wm_ImageTable,X
	LDA m0
	STA wm_ImageTable.1.ImgH,X
	INX
	INX
	REP #$20
-	LDA DATA_0C95C7,Y
	STA wm_ImageTable,X
	INX
	INX
	INY
	INY
	DEC m0
	DEC m0
	BPL -
	LDA #$00FF
	STA wm_ImageTable,X
	TXA
	STA wm_ImageIndex
+	REP #$20
	SEP #$10
	LDA wm_Bg1Ptr
	CLC
	ADC #$0020
	STA wm_Bg1Ptr
	AND #$03FF
	BNE +
	LDA wm_Bg1Ptr
	EOR #$0C00
	STA wm_Bg1Ptr
+	RTS

DATA_0C9F5C:
	.DB $C0,$00,$80,$01,$40,$02,$00,$03
	.DB $C0,$03,$80,$04,$59,$05

CODE_0C9F6A:
	REP #$20
	LDX #$00
	LDA #$FF80
	STA wm_ScrollSpeedL1X,X
	LDA wm_Bg2HOfs,X
	STA m0,X
	JSR CODE_0C9FCB
	LDA m0,X
	STA wm_Bg2HOfs,X
	LDA wm_Bg3VOfs
	CMP #$0559
	BCS +
	LDX #$02
	LDA #$0040
	STA wm_ScrollSpeedL1X,X
	LDA wm_Bg3VOfs
	STA m0,X
	STA m4
	JSR CODE_0C9FCB
	LDA m0,X
	CMP m4
	BEQ +
	STA wm_Bg3VOfs
	LDA wm_Bg3VOfs
	AND #$0007
	CMP #$0001
	BNE +
	JSR CODE_0C9EB1
+	LDX #$0C
-	LDA wm_Bg3VOfs
	CMP.W DATA_0C9F5C,X
	BEQ CODE_0C9FBB
	DEX
	DEX
	BPL -
	BRA _0C9FC6

CODE_0C9FBB:
	LDA wm_MsgBoxActionFlag
	AND #$00FF
	BNE _0C9FC6
	INC wm_MsgBoxActionFlag
_0C9FC6:
	SEP #$20
	BRL CODE_0C9FEA

CODE_0C9FCB:
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
	ADC m0,X
	STA m0,X
	RTS

DATA_0C9FE7:	.DB $00,$FF,$00

CODE_0C9FEA:
	REP #$20
	LDA #$0038
	STA wm_MarioXPos
	LDA #$008F
	STA wm_MarioYPos
	SEP #$20
	LDA #$01
	STA wm_MarioPowerUp
	LDA #$08
	STA.W wm_MarioSpeedX
	JSR CODE_0CA75A
	LDA #$52
	STA wm_SpriteXLo
	STZ wm_SpriteXHi
	LDA #$8F
	STA wm_SpriteYLo
	STZ wm_SpriteYHi
	LDA #$A0
	STA wm_SprOAMIndex
	JSR CODE_0CA778
	LDX wm_SpriteGfxTbl
	LDA #$51
	STA m0
	STZ m1
	LDA.W DATA_0C9FE7,X
	CLC
	ADC #$85
	STA m2
	TXA
	ASL
	ASL
	TAY
	LDX #$00
	JSR CODE_0CA821
	LDA #$A0
	STA m14
	JSR CODE_0CA8A3
	LDA #$10
	STA m2
	JSR CODE_0CA8DF
	RTS

DATA_0CA043:	.DB $63,$73,$83,$93,$A3,$B3,$C3

DATA_0CA04A:	.DB $A0,$9C,$A0,$9C,$A0,$9C,$A0

CODE_0CA051:
	PHB
	PHK
	PLB
	LDX #$0E
-	STZ wm_0AF6+45,X
	STZ wm_0AF6+60,X
	DEX
	BPL -
	LDX #$0D
	LDY #$06
-	LDA DATA_0CA04A,Y
	STA wm_0AF6+75,X
	STZ wm_0AF6+105,X
	LDA DATA_0CA043,Y
	STA wm_0AF6+90,X
	STZ wm_0AF6+120,X
	LDA DATA_0CA3C2,Y
	STA wm_0AF6+15,X
	LDA #$01
	STA wm_0AF6,X
	DEY
	DEX
	CPX #$06
	BNE -
	STZ wm_MarioDirection
	LDA #$E2
	STA wm_MsgBoxActionTimer
	PLB
	RTS

DATA_0CA08F:
	.DB $FF,$02,$04,$06,$08,$06,$08,$06
	.DB $08,$06,$08,$04,$02,$FF,$20,$22
	.DB $24,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$24,$22,$20,$40,$42,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $42,$40

DATA_0CA0B9:
	.DB $FF,$37,$37,$35,$35,$37,$37,$39
	.DB $39,$3B,$3B,$77,$77,$FF,$37,$37
	.DB $37,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$77,$77,$77,$37,$37,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $77,$77

CODE_0CA0E3:
	LDA #$10
	STA m0
	STA m2
	LDA #$2F
	STA m1
	LDX #$90
	LDY #$00
-	LDA DATA_0CA08F,Y
	CMP #$FF
	BEQ +
	STA wm_OamSlot.1.Tile,X
	LDA DATA_0CA0B9,Y
	STA wm_OamSlot.1.Prop,X
	LDA m0
	STA wm_OamSlot.1.XPos,X
	LDA m1
	STA wm_OamSlot.1.YPos,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.1,X
	PLX
	INX
	INX
	INX
	INX
+	LDA m0
	CLC
	ADC #$10
	STA m0
	CMP #$F0
	BNE +
	LDA m2
	STA m0
	LDA m1
	CLC
	ADC #$10
	STA m1
+	INY
	CPY #$2A
	BNE -
	RTS

DATA_0CA136:
	.DB $26,$28,$2A,$2C,$46,$48,$4A,$4C
	.DB $60,$62,$64,$66,$6A,$6C,$6E,$0A

CODE_0CA146:
	REP #$20
	LDA #$003F
	STA m8
	STA m10
	STZ m0
	STZ m2
	STZ m4
	LDY #$00
	LDX #$50
_0CA159:
	REP #$20
	LDA m0
	CLC
	ADC #$0080
	STA m0
	STA m2
	SEP #$20
	JSR _0CA183
	REP #$20
	LDA #$0080
	SEC
	SBC m4
	SEC
	SBC #$0040
	STA m0
	STA m2
	LDA #$003F
	STA m8
	STA m10
	SEP #$20
_0CA183:
	LDA m1
	BNE +
	LDA DATA_0CA136,Y
	STA wm_OamSlot.1.Tile,X
	LDA #$35
	STA wm_OamSlot.1.Prop,X
	LDA m0
	STA wm_OamSlot.1.XPos,X
	LDA m8
	STA wm_OamSlot.1.YPos,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.1,X
	PLX
	INX
	INX
	INX
	INX
+	REP #$20
	LDA m0
	CLC
	ADC #$0010
	STA m0
	SEP #$20
	TYA
	AND #$07
	CMP #$03
	BNE +
	LDA m2
	STA m0
	LDA m3
	STA m1
	LDA m8
	CLC
	ADC #$10
	STA m8
+	INY
	TYA
	AND #$07
	BNE _0CA183
	RTS

CODE_0CA1D4:
	JSR CODE_0CAB1F
	LDA wm_ScrollTypeL1
	JSL ExecutePtrLong

PtrsLong0CA1DE:
	.DL CODE_0CA1ED
	.DL CODE_0CA43C
	.DL CODE_0CA532
	.DL CODE_0CA65B
	.DL CODE_0CA6B0

CODE_0CA1ED:
	JSR CODE_0CA315
	LDA wm_MsgBoxActionTimer
	BEQ CODE_0CA1F6
	RTS

CODE_0CA1F6:
	LDA #$60
	STA wm_MarioYPos
	LDA #$01
	STA wm_MarioYPos+1
	LDX #$00
	LDA wm_0AF6+90,X
	CMP #$70
	BNE CODE_0CA24F
	STZ wm_LooseYoshiFlag
	LDA #$0F
	STA wm_MarioFrame
	JSR _0CA764
	JSR _0CA7B4
	LDA wm_ScrollTypeL1
	BNE +
	LDA wm_SpriteXLo
	STA m0
	LDA #$9F
	STA m2
	LDY #$00
	LDX #$B4
	LDA #$01
	STA m14
	JSR CODE_0CAA15
+	STZ m1
	LDA wm_0AF6+90
	CLC
	ADC #$10
	STA m0
	LDA wm_0AF6+120
	ADC #$00
	STA m1
	LDA #$9F
	STA m2
	LDA #$03
	ASL
	ASL
	TAY
	LDX #$A4
	JSR CODE_0CA821
	BRL _0CA2C3

CODE_0CA24F:
	LDA #$F8
	STA wm_0AF6+30,X
	JSR CODE_0CA74F
	LDA wm_0AF6+90,X
	STA wm_MarioXPos
	LDA wm_0AF6+120,X
	STA wm_MarioXPos+1
	LDA #$01
	STA wm_MarioPowerUp
	LDA #$08
	STA.W wm_MarioSpeedX
	JSR CODE_0CA75A
	LDA wm_0AF6+90
	CLC
	ADC #$30
	STA wm_SpriteXLo
	LDA wm_0AF6+120
	ADC #$00
	STA wm_SpriteXHi
	LDA #$60
	STA wm_SpriteYLo
	LDA #$01
	STA wm_SpriteYHi
	LDA #$30
	STA wm_SprOAMIndex
	JSR CODE_0CA778
	STZ m1
	LDA wm_0AF6+90
	CLC
	ADC #$10
	STA m0
	LDA wm_0AF6+120
	ADC #$00
	STA m1
	LDA #$9F
	STA m2
	DEC wm_SprScrollL1X
	BPL +
	LDA #$06
	STA wm_SprScrollL1X
	LDA wm_SprScrollL1X+1
	EOR #$01
	STA wm_SprScrollL1X+1
+	LDA wm_SprScrollL1X+1
	CLC
	ADC #$03
	ASL
	ASL
	TAY
	LDX #$A4
	JSR CODE_0CA821
_0CA2C3:
	LDA wm_0AF6+97
	STA m0
	LDA wm_0AF6+127
	STA m1
	REP #$20
	LDA m0
	CMP #$0030
	BNE CODE_0CA2E0
	LDA wm_ScrollTypeL1
	BNE _0CA2FC
	INC wm_ScrollTypeL1
	BRA _0CA2FC

CODE_0CA2E0:
	SEP #$20
	LDX #$0D
-	CPX #$0B
	BCC +
	LDA wm_0AF6+101
	CMP #$98
	BEQ ++
+	LDA #$F8
	STA wm_0AF6+30,X
	JSR CODE_0CA74F
++	DEX
	CPX #$06
	BNE -
_0CA2FC:
	SEP #$20
	LDA #$AF
	STA m14
	JSR CODE_0CA8A3
	LDA #$88
	STA m2
	JSR CODE_0CA8DF
	RTS

DATA_0CA30D:	.DB $00,$01,$02,$01

DATA_0CA311:	.DB $00,$01,$01,$01

CODE_0CA315:
	LDX #$01
	LDA wm_0AF6+15,X
	CLC
	ADC #$01
	STA wm_0AF6+15,X
	JSR CODE_0CA721
	LDA wm_0AF6+75,X
	CMP #$9F
	BCC +
	LDA #$F0
	STA wm_0AF6+15,X
	LDA #$9F
	STA wm_0AF6+75,X
+	LDY #$00
	LDA wm_0AF6+16
	BPL CODE_0CA349
	CMP #$F4
	BCC _0CA355
	LDY #$01
	CMP #$F8
	BCC _0CA355
	LDY #$02
	BRA CODE_0CA349 ; bra to next instruction...

CODE_0CA349:
	CMP #$0C
	BCS _0CA355
	LDY #$01
	CMP #$08
	BCS _0CA355
	LDY #$02
_0CA355:
	STY wm_XSpeedL3
	LDA wm_YoshisRescued
	BEQ +
	CMP #$01
	BNE +
	LDA #$18
	STA m0
	STZ m1
	LDA wm_0AF6+76
	STA m2
	LDY wm_XSpeedL3
	LDA DATA_0CA30D,Y
	CLC
	ADC #$07
	ASL
	ASL
	TAY
	LDX #$D0
	JSR CODE_0CA821
	LDA #$D4
	STA m0
	STZ m1
	LDA wm_0AF6+76
	STA m2
	LDY wm_XSpeedL3
	LDA DATA_0CA30D,Y
	CLC
	ADC #$0A
	ASL
	ASL
	TAY
	LDX #$F0
	JSR CODE_0CA821
	LDY wm_XSpeedL3
	LDA DATA_0CA311,Y
	ASL
	TAY
	LDA #$50
	STA m0
	LDA wm_0AF6+76
	STA m2
	LDX #$F0
	LDA #$00
	STA m14
	JSR CODE_0CAA15
+	RTS

DATA_0CA3B4:	.DB $40,$50,$60,$70,$80,$90,$A0

DATA_0CA3BB:	.DB $AF,$AB,$AF,$AB,$AF,$AB,$AF

DATA_0CA3C2:	.DB $F6,$00,$F6,$00,$F6,$00,$F6

CODE_0CA3C9:
	PHB
	PHK
	PLB
	LDA #$01
	STA wm_YoshisRescued
	STZ wm_MarioDirection
	STZ wm_ScrollTypeL1
	LDA #$00
	STA wm_0AF6+90
	LDA #$01
	STA wm_0AF6+120
	STZ wm_0AF6+60
	STZ wm_0AF6+61
	STZ wm_0AF6+67
	LDA #$06
	STA wm_SprScrollL1X
	STZ wm_SprScrollL1X+1
	STZ wm_XSpeedL3
	LDA #$06
	STA wm_XSpeedL3+1
	LDA #$F0
	STA wm_0AF6+16
	LDA #$9F
	STA wm_0AF6+76
	LDA #$E2
	STA wm_MsgBoxActionTimer
	STA wm_LvLoadScreen
	LDA #$0A
	STA wm_MusicCh1
	LDX #$0D
	LDY #$06
-	LDA DATA_0CA3BB,Y
	STA wm_0AF6+75,X
	STZ wm_0AF6+105,X
	LDA DATA_0CA3B4,Y
	STA wm_0AF6+90,X
	LDA DATA_0CA3C2,Y
	STA wm_0AF6+15,X
	LDA #$01
	STA wm_0AF6,X
	STA wm_0AF6+120,X
	DEY
	DEX
	CPX #$06
	BNE -
	PLB
	RTL

DATA_0CA439:	.DB $00,$02,$02

CODE_0CA43C:
	LDA wm_XSpeedL3
	CMP #$08
	BCS CODE_0CA45C
	JSR CODE_0CA315
	LDA wm_XSpeedL3
	BNE +
	LDA wm_0AF6+76
	CMP #$9F
	BNE +
	LDA #$08
	STA wm_XSpeedL3
+	LDY #$00
	BRL _0CA510

CODE_0CA45C:
	DEC wm_XSpeedL3+1
	BPL _0CA478
	LDA #$06
	STA wm_XSpeedL3+1
	INC wm_XSpeedL3
	LDA wm_XSpeedL3
	CMP #$0B
	BNE _0CA478
	LDA #$0A
	STA wm_XSpeedL3
	INC wm_ScrollTypeL1
_0CA478:
	LDA wm_XSpeedL3
	AND #$03
	BNE CODE_0CA4B6
	LDA #$18
	STA m0
	STZ m1
	LDA #$9F
	STA m2
	LDA wm_XSpeedL3
	AND #$03
	CLC
	ADC #$07
	ASL
	ASL
	TAY
	LDX #$D0
	JSR CODE_0CA821
	LDA #$D4
	STA m0
	STZ m1
	LDA #$9F
	STA m2
	LDA wm_XSpeedL3
	AND #$03
	CLC
	ADC #$0A
	ASL
	ASL
	TAY
	LDX #$F0
	JSR CODE_0CA821
	BRL _0CA4E9

CODE_0CA4B6:
	LDA #$18
	STA m0
	STZ m1
	LDA #$A7
	STA m2
	LDA wm_XSpeedL3
	AND #$03
	DEC A
	ASL
	ASL
	TAY
	LDX #$C0
	JSR CODE_0CA99E
	LDA #$CC
	STA m0
	STZ m1
	LDA #$A7
	STA m2
	LDA wm_XSpeedL3
	AND #$03
	DEC A
	CLC
	ADC #$02
	ASL
	ASL
	TAY
	LDX #$D8
	JSR CODE_0CA99E
_0CA4E9:
	LDA wm_XSpeedL3
	AND #$03
	TAY
	LDA DATA_0CA439,Y
	ASL
	TAY
	LDA #$50
	STA m0
	LDA #$9F
	STA m2
	LDX #$F0
	LDA #$00
	STA m14
	JSR CODE_0CAA15
	LDA wm_XSpeedL3
	AND #$03
	TAY
	LDA DATA_0CA439,Y
	ASL
	TAY
_0CA510:
	LDA wm_SpriteXLo
	STA m0
	LDA #$9F
	STA m2
	LDX #$B4
	LDA #$01
	STA m14
	JSR CODE_0CAA15
	BRL CODE_0CA1F6

DATA_0CA524:	.DB $20,$01,$10,$40,$08,$02,$04

DATA_0CA52B:	.DB $10,$60,$20,$00,$30,$50,$40

CODE_0CA532:
	LDA wm_AccSpeedL3
	BEQ CODE_0CA53A
	BRL CODE_0CA5CB

CODE_0CA53A:
	LDA #$98
	STA wm_0AF6+18
	STA wm_0AF6+19
	LDA #$D4
	STA wm_0AF6+20
	STA wm_0AF6+21
	LDY wm_YSpeedL3+1
	LDA DATA_0CA52B,Y
	LSR
	LSR
	LSR
	LSR
	TAX
	INC A
	STA wm_AccSpeedL3
	LDA #$C0
	STA wm_0AF6+22,X
	LDA #$04
	STA wm_0AF6+7,X
	LDA wm_0AF6+82,X
	STA wm_0AF6+78
	STA wm_0AF6+79
	CLC
	ADC #$08
	STA wm_0AF6+80
	STA wm_0AF6+81
	STZ wm_0AF6+108
	STZ wm_0AF6+109
	STZ wm_0AF6+110
	STZ wm_0AF6+111
	LDA wm_0AF6+97,X
	STA wm_0AF6+93
	STA wm_0AF6+95
	CLC
	ADC #$08
	STA wm_0AF6+94
	STA wm_0AF6+96
	STZ wm_0AF6+123
	STZ wm_0AF6+124
	STZ wm_0AF6+125
	STZ wm_0AF6+126
	LDA DATA_0CA524,Y
	TSB wm_YSpeedL3
	INC wm_YSpeedL3+1
	LDA wm_YSpeedL3+1
	CMP #$08
	BEQ CODE_0CA5B6
	LDA #$0A
	STA wm_SoundCh3
	BRA CODE_0CA5CB

CODE_0CA5B6:
	STZ wm_0AF6+122
	LDA #$80
	STA wm_0AF6+92
	STZ wm_0AF6+32
	LDA #$0B
	STA wm_MusicCh1
	INC wm_ScrollTypeL1
	BRA _0CA5CE

CODE_0CA5CB:
	JSR CODE_0CA5DE
_0CA5CE:
	JSR CODE_0CA4B6
	RTS

DATA_0CA5D2:	.DB $C8,$C8,$D8,$D8

DATA_0CA5D6:	.DB $26,$66,$26,$66

DATA_0CA5DA:	.DB $E8,$18,$F4,$0C

CODE_0CA5DE:
	LDA wm_AccSpeedL3
	BEQ ++
	LDX #$06
-	LDA wm_0AF6+15,X
	CLC
	ADC #$06
	CMP #$70
	BEQ +
	STA wm_0AF6+15,X
+	TXA
	SEC
	SBC #$03
	TAY
	LDA DATA_0CA5DA,Y
	STA wm_0AF6+30,X
	JSR CODE_0CA721
	JSR CODE_0CA74F
	DEX
	CPX #$02
	BNE -
	LDA wm_0AF6+78
	AND #$F0
	CMP #$F0
	BNE +
	STZ wm_AccSpeedL3
+	LDX #$00
	LDY #$06
-	LDA wm_0AF6+120,Y
	BNE +
	LDA wm_0AF6+105,Y
	BNE +
	LDA wm_0AF6+75,Y
	CMP #$F0
	BCS +
	LDA wm_0AF6+90,Y
	STA wm_ExOamSlot.1.XPos,X
	LDA wm_0AF6+75,Y
	STA wm_ExOamSlot.1.YPos,X
	PHY
	TYA
	SEC
	SBC #$03
	TAY
	LDA DATA_0CA5D2,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CA5D6,Y
	STA wm_ExOamSlot.1.Prop,X
	PLY
	PHX
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
	PLX
	INX
	INX
	INX
	INX
+	DEY
	CPY #$02
	BNE -
++	RTS

CODE_0CA65B:
	LDX #$02
	LDA wm_0AF6+30,X
	SEC
	SBC #$04
	STA wm_0AF6+30,X
	JSR CODE_0CA74F
	LDA wm_0AF6+90,X
	CMP #$F8
	BCC +
	INC wm_ScrollTypeL1
	LDA #$F0
	STA wm_YoshiCreditTimer
	LDA #$00
+	STA m0
	STA m2
	STA m4
	STZ m1
	STZ m3
	STZ m5
	LDA #$3F
	STA m8
	STA m10
	LDY #$00
	LDX #$50
	JSR _0CA159
	DEC wm_XSpeedL3+1
	BPL +
	LDA #$06
	STA wm_XSpeedL3+1
	DEC wm_XSpeedL3
	LDA wm_XSpeedL3
	CMP #$07
	BNE +
	LDA #$08
	STA wm_XSpeedL3
+	JSR _0CA478
	RTS

CODE_0CA6B0:
	JSR CODE_0CA146
	JSR CODE_0CA315
	JSR _0CA2FC
	LDA #$60
	STA wm_MarioYPos
	LDA #$01
	STA wm_MarioYPos+1
	STZ wm_LooseYoshiFlag
	LDA #$26
	STA wm_MarioFrame
	JSR _0CA764
	JSR _0CA7B4
	LDY wm_XSpeedL3
	LDA DATA_0CA311,Y
	ASL
	TAY
	LDA wm_SpriteXLo
	STA m0
	LDA wm_0AF6+76
	STA m2
	LDX #$B4
	LDA #$01
	STA m14
	JSR CODE_0CAA15
	STZ m1
	LDA wm_0AF6+90
	CLC
	ADC #$10
	STA m0
	LDA wm_0AF6+120
	ADC #$00
	STA m1
	LDA #$9F
	STA m2
	LDA wm_FrameA
	AND #$08
	LSR
	LSR
	LSR
	CLC
	ADC #$05
	ASL
	ASL
	TAY
	LDX #$A4
	JSR CODE_0CA821
	DEC wm_YoshiCreditTimer
	LDA wm_YoshiCreditTimer
	BNE +
	INC wm_GameMode
	LDA #$40
	STA wm_YSpeedL3+1
+	RTS

CODE_0CA721:
	LDA wm_0AF6+15,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_0AF6+45,X
	STA wm_0AF6+45,X
	PHP
	LDA wm_0AF6+15,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	LDY #$00
	BCC +
	ORA #$F0
	DEY
+	PLP
	ADC wm_0AF6+75,X
	STA wm_0AF6+75,X
	TYA
	ADC wm_0AF6+105,X
	STA wm_0AF6+105,X
	RTS

CODE_0CA74F:
	PHX
	TXA
	CLC
	ADC #$0F
	TAX
	JSR CODE_0CA721
	PLX
	RTS

CODE_0CA75A:
	PHB
	LDA #:CODE_00CEB1
	PHA
	PLB
	JSL CODE_00CEB1
	PLB
_0CA764:
	STZ wm_IsBehindScenery
	LDA wm_PlayerAnimTimer
	BEQ +
	DEC wm_PlayerAnimTimer
+	LDA wm_CapeWaveTimer
	BEQ +
	DEC wm_CapeWaveTimer
+	RTS

CODE_0CA778:
	LDX #$00
	STX wm_SprProcessIndex
	LDA #$35
	STA wm_SpriteNum
	LDA wm_SpriteGfxTbl
	PHA
	JSL InitSpriteTables
	PLA
	STA wm_SpriteGfxTbl
	LDA #$02
	STA wm_SpriteState
	LDA #$01
	STA wm_SpriteDir
	LDA wm_ScrollSprIndex
	CLC
	ADC #$38
	STA wm_ScrollSprIndex
	BCC +
	LDA wm_SpriteGfxTbl
	INC A
	STA wm_SpriteGfxTbl
	CMP #$03
	BCC +
	STZ wm_SpriteGfxTbl
+	LDA #$01
	STA wm_LooseYoshiFlag
_0CA7B4:
	JSL CODE_00E2BD
	RTS

DATA_0CA7B9:
	.DB $63,$64,$68,$69,$63,$64,$68,$69
	.DB $4B,$4C,$6B,$6C,$8A,$8B,$AA,$68
	.DB $8D,$8E,$AD,$AE,$8A,$00,$AA,$44
	.DB $8A,$0E,$AA,$2E,$81,$80,$A1,$A0
	.DB $84,$83,$A4,$A3,$87,$86,$A7,$A6
	.DB $80,$81,$A0,$A1,$83,$84,$A3,$A4
	.DB $86,$87,$A6,$A7

DATA_0CA7ED:
	.DB $21,$21,$21,$21,$21,$21,$21,$21
	.DB $21,$21,$21,$21,$21,$21,$21,$21
	.DB $20,$20,$20,$20,$21,$21,$21,$21
	.DB $21,$21,$21,$21,$78,$78,$78,$78
	.DB $78,$78,$78,$78,$78,$78,$78,$78
	.DB $34,$34,$34,$34,$34,$34,$34,$34
	.DB $34,$34,$34,$34

CODE_0CA821:
	REP #$30
	TXA
	AND #$00FF
	TAX
	TYA
	AND #$00FF
	CMP #$0028
	BCC +
	TXA
	ORA #$0100
	TAX
+	SEP #$20
	LDA #$01
	STA m4
-	LDA m1
	BNE ++
	LDA #$02
	STA m10
	LDA m0
	STA wm_ExOamSlot.2.XPos,X
	CLC
	ADC #$08
	STA wm_ExOamSlot.1.XPos,X
	BCC +
	LDA #$01
	STA m10
+	LDA m2
	STA wm_ExOamSlot.1.YPos,X
	STA wm_ExOamSlot.2.YPos,X
	LDA DATA_0CA7B9,Y
	STA wm_ExOamSlot.2.Tile,X
	LDA DATA_0CA7B9+1,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CA7ED,Y
	STA wm_ExOamSlot.2.Prop,X
	LDA DATA_0CA7ED+1,Y
	STA wm_ExOamSlot.1.Prop,X
	LDA m2
	CLC
	ADC #$10
	STA m2
	PHX
	REP #$20
	TXA
	LSR
	LSR
	TAX
	SEP #$20
	LDA #$02
	STA wm_ExOamSize.2,X
	LDA m10
	STA wm_ExOamSize.1,X
	PLX
	REP #$20
	TXA
	CLC
	ADC #$0008
	TAX
	SEP #$20
	INY
	INY
	DEC m4
	BPL -
++	SEP #$30
	RTS

CODE_0CA8A3:
	LDX #$0D
-	LDA wm_0AF6+15,X
	CLC
	ADC wm_0AF6,X
	STA wm_0AF6+15,X
	JSR CODE_0CA721
	LDA wm_0AF6+75,X
	CMP m14
	BCC +
	STZ wm_0AF6+45,X
	LDA #$F6
	STA wm_0AF6+15,X
	LDA #$01
	STA wm_0AF6,X
	LDA m14
	STA wm_0AF6+75,X
+	DEX
	CPX #$06
	BNE -
	RTS

UNK_0CA8D1:	.DB $00,$10,$20,$30,$40,$50,$60 ; unused, was probably tiles

DATA_0CA8D8:	.DB $68,$26,$24,$6A,$28,$64,$26

CODE_0CA8DF:
	LDA wm_YSpeedL3
	STA m14
	LDY #$0D
_0CA8E6:
	LDA wm_0AF6+120,Y
	BNE _0CA934
	LDA wm_0AF6+90,Y
	STA m0
	LDA wm_0AF6+75,Y
	STA m1
	LDX m2
	LDA m0
	STA wm_ExOamSlot.1.XPos,X
	LDA m1
	STA wm_ExOamSlot.1.YPos,X
	LSR m14
	BCS CODE_0CA911
	LDA #$86
	STA wm_ExOamSlot.1.Tile,X
	LDA #$21
	STA wm_ExOamSlot.1.Prop,X
	BRA _0CA923

CODE_0CA911:
	PHY
	TYA
	SEC
	SBC #$07
	TAY
	LDA #$EA
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CA8D8,Y
	STA wm_ExOamSlot.1.Prop,X
	PLY
_0CA923:
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	INC m2
	INC m2
	INC m2
	INC m2
_0CA934:
	DEY
	CPY #$06
	BNE _0CA8E6
	RTS

DATA_0CA93A:
	.DB $BB,$B9,$DC,$DB,$DA,$D9,$8B,$89
	.DB $AC,$AB,$AA,$A9,$B9,$BB,$D9,$DA
	.DB $DB,$DC,$89,$8B,$A9,$AA,$AB,$AC

DATA_0CA952:
	.DB $78,$78,$78,$78,$78,$78,$78,$78
	.DB $78,$78,$78,$78,$34,$34,$34,$34
	.DB $34,$34,$34,$34,$34,$34,$34,$34

DATA_0CA96A:
	.DB $00,$10,$00,$08,$10,$18,$00,$10
	.DB $00,$08,$10,$18,$00,$10,$00,$08
	.DB $10,$18,$00,$10,$00,$08,$10,$18

DATA_0CA982:
	.DB $00,$00,$10,$10,$10,$10,$00,$00
	.DB $10,$10,$10,$10,$00,$00,$10,$10
	.DB $10,$10,$00,$00,$10,$10,$10,$10

DATA_0CA99A:	.DB $00,$06,$0C,$12

CODE_0CA99E:
	TYA
	LSR
	LSR
	TAY
	LDA DATA_0CA99A,Y
	TAY
	LDA #$02
	STA m4
-	LDA DATA_0CA96A,Y
	CLC
	ADC m0
	STA wm_ExOamSlot.1.XPos,X
	LDA DATA_0CA96A+1,Y
	CLC
	ADC m0
	STA wm_ExOamSlot.2.XPos,X
	LDA DATA_0CA982,Y
	CLC
	ADC m2
	STA wm_ExOamSlot.1.YPos,X
	LDA DATA_0CA982+1,Y
	CLC
	ADC m2
	STA wm_ExOamSlot.2.YPos,X
	LDA DATA_0CA93A,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CA93A+1,Y
	STA wm_ExOamSlot.2.Tile,X
	LDA DATA_0CA952,Y
	STA wm_ExOamSlot.1.Prop,X
	LDA DATA_0CA952+1,Y
	STA wm_ExOamSlot.2.Prop,X
	PHY
	PHX
	TXA
	LSR
	LSR
	TAX
	LDY #$02
	LDA m4
	AND #$02
	BNE +
	LDY #$00
+	TYA
	STA wm_ExOamSize.1,X
	STA wm_ExOamSize.2,X
	PLX
	PLY
	TXA
	CLC
	ADC #$08
	TAX
	INY
	INY
	DEC m4
	BPL -
	RTS

DATA_0CAA0B:	.DB $C4,$E4,$E6,$E8,$CE,$EE

DATA_0CAA11:	.DB $36,$36,$3A,$3A

CODE_0CAA15:
	PHY
	LDA m14
	ASL
	TAY
	LDA DATA_0CAA11,Y
	STA wm_ExOamSlot.1.Prop,X
	LDA DATA_0CAA11+1,Y
	STA wm_ExOamSlot.2.Prop,X
	PLY
	LDA m0
	STA wm_ExOamSlot.1.XPos,X
	STA wm_ExOamSlot.2.XPos,X
	LDA m2
	STA wm_ExOamSlot.1.YPos,X
	CLC
	ADC #$10
	STA wm_ExOamSlot.2.YPos,X
	LDA DATA_0CAA0B,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CAA0B+1,Y
	STA wm_ExOamSlot.2.Tile,X
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	STA wm_ExOamSize.2,X
	RTS

DATA_0CAA53:
	.DB $53,$6A,$80,$3C,$63,$6A,$82,$3C
	.DB $53,$7A,$A0,$3C,$63,$7A,$A2,$3C
	.DB $53,$8A,$84,$3C,$63,$8A,$86,$3C
	.DB $53,$9A,$A4,$3C,$63,$9A,$A6,$3C
	.DB $53,$AA,$88,$3C,$63,$AA,$8A,$3C
	.DB $8D,$5A,$A8,$3A,$9D,$5A,$AA,$3A
	.DB $8D,$6A,$8C,$3A,$9D,$6A,$8E,$3A
	.DB $8D,$7A,$AC,$3A,$9D,$7A,$AE,$3A
	.DB $8D,$8A,$63,$3A,$9D,$8A,$65,$3A
	.DB $8D,$9A,$48,$3A,$9D,$9A,$68,$3A
	.DB $8D,$AA,$6B,$3A,$9D,$AA,$6D,$3A
	.DB $78,$58,$4D,$3E,$70,$68,$E0,$3F
	.DB $80,$68,$C4,$3F,$70,$78,$4A,$3F
	.DB $80,$78,$4C,$3F,$70,$88,$6A,$3F
	.DB $80,$88,$6C,$3F,$68,$98,$AB,$3F
	.DB $78,$98,$C8,$3F,$88,$98,$E6,$3F
	.DB $68,$A8,$E8,$3F,$78,$A8,$EA,$3F
	.DB $88,$A8,$EC,$3F

CODE_0CAADF:
	PHB
	PHK
	PLB
	LDX #$00
	TXY
-	LDA DATA_0CAA53,Y
	STA wm_ExOamSlot.1.XPos,X
	LDA DATA_0CAA53+1,Y
	STA wm_ExOamSlot.1.YPos,X
	LDA DATA_0CAA53+2,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CAA53+3,Y
	STA wm_ExOamSlot.1.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	PLX
	INX
	INX
	INX
	INX
	TXY
	CPY #$8C
	BNE -
	PLB
	RTL

CODE_0CAB13:
	PHB
	PHK
	PLB
	JSR CODE_0CAB1F
	PLB
	RTL

DATA_0CAB1B:	.DB $FE,$02

DATA_0CAB1D:	.DB $00,$E0

CODE_0CAB1F:
	LDX wm_MsgBoxActionFlag
	LDA #$33
	STA wm_W12Sel
	LDY wm_LvLoadScreen
	BNE +
	CPX #$00
	BEQ ++
+	CPY #$06
	BCC +
	BNE ++
	CPX #$00
	BNE ++
+	LDA #$30
++	STA wm_WObjSel
	LDA wm_MsgBoxActionTimer
	CMP.W DATA_0CAB1D,X
	BNE _0CAB64
	CPX #$00
	BEQ _0CAB6B
	LDX #$00
	STX wm_MsgBoxActionFlag
	CPY #$06
	BCC CODE_0CAB57
	INC wm_GameMode
	BRA _0CAB6B

CODE_0CAB57:
	PHA
	PHX
	INC wm_UpdateCreditBG
	INC wm_LvLoadScreen
	JSR CODE_0CABB2
	PLX
	PLA
_0CAB64:
	CLC
	ADC.W DATA_0CAB1B,X
	STA wm_MsgBoxActionTimer
_0CAB6B:
	REP #$20
	LDX #$00
	LDY #$E0
	LDA #$00FF
-	CPX wm_MsgBoxActionTimer
	BCC +
	LDA #$FF00
+	STA wm_HDMAWindowsTbl,X
	STA wm_HDMAWindowsTbl+222,Y
	INX
	INX
	DEY
	DEY
	BNE -
	SEP #$20
	LDA #$13
	STA TMW
	STA TSW
	LDA #$22
	STA wm_CgSwSel
	LDA #$80
	STA wm_HDMAEn
	RTS

DATA_0CAB9C:	.DB $00,$18,$30,$48,$60,$78,$90,$A8

DATA_0CABA4:	.DB $06,$00,$00,$02,$05,$06,$00

DATA_0CABAB:	.DB $03,$03,$07,$00,$01,$02,$00

CODE_0CABB2:
	SEP #$30
	LDA #$0C
	STA wm_PalUplSize
	STA wm_PalColData.7.ColL
	LDA #$02
	STA wm_PalColNum
	LDA #$12
	STA wm_PalColData.7.ColH
	REP #$30
	LDA wm_LvLoadScreen
	AND #$00FF
	TAY
	LDA DATA_0CABA4,Y
	AND #$000F
	ASL
	TAX
	LDA.L PALETTE_Sky,X
	STA wm_LvBgColor
	LDA.W #PALETTE_Background
	STA m0
	LDA DATA_0CABAB,Y
	AND #$000F
	TAX
	LDA.W DATA_0CAB9C,X
	AND #$00FF
	CLC
	ADC m0
	STA m0
	STZ m2 ; #BANK_0
	LDA #$0000
	STA m4
	LDA #$0001
	STA m8
-	LDX m4
	LDY #$0005
--	LDA [m0]
	STA wm_PalColData,X
	INC m0
	INC m0
	INX
	INX
	DEY
	BPL --
	LDA m4
	CLC
	ADC #$000E
	STA m4
	DEC m8
	BPL -
	LDA #$0000
	STA wm_PalColData,X
	SEP #$30
	RTS

.INCDIR "images/ending"

EndingEnemyL1:
@1:		.INCBIN "1/layer1.bin"
@2:		.INCBIN "2/layer1.bin"
@3:		.INCBIN "3/layer1.bin"
@4:		.INCBIN "4/layer1.bin"
@5:		.INCBIN "5/layer1.bin"
@6:		.INCBIN "6/layer1.bin"
@7:		.INCBIN "7/layer1.bin"
@8:		.INCBIN "8/layer1.bin"
@9:		.INCBIN "9/layer1.bin"
@10:	.INCBIN "10/layer1.bin"
@11:	.INCBIN "11/layer1.bin"
@12:	.INCBIN "12/layer1.bin"
@13:	.INCBIN "13/layer1.bin" ; also used for layer 2

.INCDIR ""

EndEnemyL1Ptrs:
	.DW EndingEnemyL1@1,EndingEnemyL1@2,EndingEnemyL1@3,EndingEnemyL1@4
	.DW EndingEnemyL1@5,EndingEnemyL1@6,EndingEnemyL1@7,EndingEnemyL1@8
	.DW EndingEnemyL1@9,EndingEnemyL1@10,EndingEnemyL1@11,EndingEnemyL1@12
	.DW EndingEnemyL1@13

EndEnemyL2Ptrs:
	.DW Layer2Forest,Layer2Clouds,Layer2Rocks2,Layer2Mountains
	.DW Layer2SmallHills,Layer2Cave,Layer2Water,Layer2GhostHouse
	.DW Layer2Castle,Layer2Castle2,Layer2Castle,Layer2Castle2
	.DW EndingEnemyL1@13

CODE_0CAD8C:
	PHB
	PHK
	PLB
	INC wm_CreditsEnemyNum
	LDX #$FF
	LDA wm_CreditsEnemyNum
	CMP #$0C
	BNE +
	LDX #:Layer2BGBank
+	ASL
	TAY
	LDA #:Layer2BGBank
	STA wm_Bg1Ptr+2
	STX wm_Bg2Ptr+2
	REP #$20
	LDA EndEnemyL1Ptrs,Y
	STA wm_Bg1Ptr
	LDA EndEnemyL2Ptrs,Y
	STA wm_Bg2Ptr
	SEP #$20
	PLB
	RTL

DATA_0CADB5:
	.DB $28,$28,$44,$28,$38,$20,$28,$20
	.DB $08,$28,$7C,$68,$28

DATA_0CADC2:
	.DB $00,$00,$88,$00,$E0,$00,$C0,$00
	.DB $E8,$00,$00,$00,$A0,$00,$50,$00
	.DB $B0,$00,$E0,$00,$18,$00,$E0,$00
	.DB $00,$00

DATA_0CADDC:
	.DB $49,$FE,$4B,$FE,$5F,$FE,$71,$FE
	.DB $73,$FE,$8F,$FE,$91,$FE,$93,$FE
	.DB $95,$FE,$97,$FE,$99,$FE,$9B,$FE
	.DB $9D,$FE

CODE_0CADF6:
	PHB
	PHK
	PLB
	LDA wm_CreditsEnemyNum
	TAY
	ASL
	TAX
	CLC
	ADC wm_CreditsEnemyNum
	CLC
	ADC #$D8
	STA wm_ImageLoader
	PHY
	PHX
	JSL CODE_0084C8
	LDA wm_MapData.OwLvFlags.Lv125
	BPL +
	LDA wm_CreditsEnemyNum
	ASL
	TAY
	LDA DATA_0CADDC,Y
	STA.W m0
	LDA DATA_0CADDC+1,Y
	STA.W m1
	LDA #:EndingScene ; Pretty sure this is correct BANK_D
	STA.W m2
	LDY #$00
	LDA wm_ImageIndex
	TAX
-	REP #$20
	LDA [m0],Y
	STA wm_ImageTable,X
	INY
	INY
	INX
	INX
	CMP #$FFFF
	BNE -
	TXA
	STA wm_ImageIndex
	SEP #$20
+	PLX
	PLY
	LDA DATA_0CADB5,Y
	STA wm_HDMAWindowsTbl+3
	STA wm_HDMAWindowsTbl+13
	STA wm_HDMAWindowsTbl+23
	LDA #$88
	SEC
	SBC DATA_0CADB5,Y
	STA wm_HDMAWindowsTbl+6
	STA wm_HDMAWindowsTbl+16
	STA wm_HDMAWindowsTbl+26
	REP #$20
	LDA.W DATA_0CADC2,X
	STA wm_Bg2VOfs
	LDA wm_CreditsEnemyNum
	AND #$00FF
	CMP #$000C
	BNE CODE_0CAE88
	STZ wm_Bg1HOfs
	STZ wm_Bg2HOfs
	STZ wm_Bg3HOfs
	STZ wm_L1NextPosX
	STZ wm_L2NextPosX
	STZ wm_L3CurXMoved
	BRA _0CAEA3

CODE_0CAE88:
	LDA #$FF00
	STA wm_Bg1HOfs
	STA wm_Bg3HOfs
	LDA #$0100
	STA wm_L1NextPosX
	STA wm_L3CurXMoved
	LDA #$FF80
	STA wm_Bg2HOfs
	LDA #$0080
	STA wm_L2NextPosX
_0CAEA3:
	LDA #$00FF
	STA wm_YSpeedL3+1
	SEP #$20
	PLB
	RTL

CODE_0CAEAD:
	SEP #$20
	LDA wm_CreditsEnemyNum
	CMP #$0C
	BNE CODE_0CAEBC
	DEC wm_YSpeedL3+1
	JMP _0CAEF8

CODE_0CAEBC:
	REP #$20
	LDA wm_Bg1HOfs
	CMP wm_L1NextPosX
	BNE CODE_0CAED0
	LDA wm_YSpeedL3+1
	BEQ CODE_0CAED0
	DEC wm_YSpeedL3+1
	JMP _0CAF0C

CODE_0CAED0:
	LDA wm_Bg1HOfs
	CLC
	ADC #$0002
	STA wm_Bg1HOfs
	STA wm_Bg3HOfs
	LDA wm_L1NextPosX
	SEC
	SBC #$0002
	STA wm_L1NextPosX
	STA wm_L3CurXMoved
	INC wm_Bg2HOfs
	DEC wm_L2NextPosX
	LDA wm_Bg1HOfs
	AND wm_L1NextPosX
	AND #$00FF
	SEP #$20
	BNE _0CAF0C
_0CAEF8:
	LDA wm_YSpeedL3+1
	BNE _0CAF0C
	INC wm_GameMode
	LDA wm_CreditsEnemyNum
	CMP #$0C
	BEQ _0CAF0C
	LDA #$22
	STA wm_GameMode
_0CAF0C:
	SEP #$20
	JMP CODE_0CB5BC

EndingEnemySP:

;base $0000

.INCDIR "images/ending"

@5:		.INCBIN "5/sprites.bin"
@6:		.INCBIN "6/sprites.bin"
@9:		.INCBIN "9/sprites.bin"
@12:	.INCBIN "12/sprites.bin"
@2:		.INCBIN "2/sprites.bin"
@3:		.INCBIN "3/sprites.bin"
@4:		.INCBIN "4/sprites.bin"
@7:		.INCBIN "7/sprites.bin"
@1:		.INCBIN "1/sprites.bin"
@8:		.INCBIN "8/sprites.bin"
@10:	.INCBIN "10/sprites.bin"
@11:	.INCBIN "11/sprites.bin"
@13:	.INCBIN "13/sprites.bin"

.INCDIR ""

;base off

EndEnemySPPtrs:
	.DW EndingEnemySP@1-EndingEnemySP
	.DW EndingEnemySP@2-EndingEnemySP
	.DW EndingEnemySP@3-EndingEnemySP
	.DW EndingEnemySP@4-EndingEnemySP
	.DW EndingEnemySP@5-EndingEnemySP
	.DW EndingEnemySP@6-EndingEnemySP
	.DW EndingEnemySP@7-EndingEnemySP
	.DW EndingEnemySP@8-EndingEnemySP
	.DW EndingEnemySP@9-EndingEnemySP
	.DW EndingEnemySP@10-EndingEnemySP
	.DW EndingEnemySP@11-EndingEnemySP
	.DW EndingEnemySP@12-EndingEnemySP
	.DW EndingEnemySP@13-EndingEnemySP

CODE_0CB5BC:
	LDA #$00
	XBA
	LDY #$20
	LDA wm_CreditsEnemyNum
	CMP #$05
	BNE +
	LDY #$30
+	STY m0
	ASL
	REP #$10
	TAY
	LDX.W EndEnemySPPtrs,Y
	LDY #$007F
	STY m1
	LDY #$01FC
-	PHY
	LDY wm_Bg1HOfs
	LDA.W EndingEnemySP+3,X
	AND #$20
	BEQ +
	LDY wm_L1NextPosX
+	STY m3
	PLY
	LDA.W EndingEnemySP,X
	CMP #$FF
	BEQ CODE_0CB633
	SEC
	SBC m3
	STA wm_ExOamSlot.1.XPos,Y
	LDA #$00
	SBC m4
	AND #$01
	STA m4
	LDA.W EndingEnemySP+3,X
	AND #$10
	LSR
	LSR
	LSR
	ORA m4
	PHY
	LDY m1
	STA wm_ExOamSize.1,Y
	PLY
	LDA.W EndingEnemySP+1,X
	STA wm_ExOamSlot.1.YPos,Y
	LDA.W EndingEnemySP+2,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA.W EndingEnemySP+3,X
	AND #$CF
	ORA m0
	STA wm_ExOamSlot.1.Prop,Y
	DEY
	DEY
	DEY
	DEY
	INX
	INX
	INX
	INX
	DEC m1
	BRA -

CODE_0CB633:
	SEP #$10
	RTS

DATA_0CB636:	.INCBIN "images/ending/the_end.stim"

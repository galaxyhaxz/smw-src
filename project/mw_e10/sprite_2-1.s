PokeyClipIndex:	.DB $1B,$1B,$1A,$19,$18,$17

PokeyMain:
	PHB
	PHK
	PLB
	JSR PokeyMainRt
	LDA wm_SpriteState,X
	PHX
	LDX #$04
	LDY #$00
-	LSR
	BCC +
	INY
+	DEX
	BPL -
	PLX
	LDA PokeyClipIndex,Y
	STA wm_Tweaker1662,X
	PLB
	RTL

DATA_02B653:	.DB $01,$02,$04,$08

DATA_02B657:	.DB $00,$01,$03,$07

DATA_02B65B:	.DB $FF,$FE,$FC,$F8

PokeyTileDispX:	.DB $00,$01,$00,$FF

PokeySpeed:	.DB $02,$FE

DATA_02B665:
	.DB $00,$05,$09,$0C,$0E,$0F,$10,$10
	.DB $10,$10,$10,$10,$10

PokeyMainRt:
	LDA wm_SpriteMiscTbl5,X
	BNE CODE_02B681
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_02B6A7
	JMP _02B726

CODE_02B681:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteState,X
	CMP #$01
	LDA #$8A
	BCC +
	LDA #$E8
+	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE +
	JSR UpdateYPosNoGrvty2
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
	JSR SubOffscreen0Bnk2
+	RTS

CODE_02B6A7:
	LDA wm_SpriteState,X
	BNE PokeyAlive
_02B6AB:
	STZ wm_SpriteStatus,X
	RTS

PokeyAlive:
	CMP #$20
	BCS _02B6AB
	LDA wm_SpritesLocked
	BNE _02B726
	JSR SubOffscreen0Bnk2
	JSL MarioSprInteract
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	AND #$7F
	BNE +
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
+	LDY wm_SpriteDir,X
	LDA PokeySpeed,Y
	STA wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
+	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteSpeedY,X
+	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
+	JSR CODE_02B7AC
	LDY #$00
-	LDA wm_SpriteState,X
	AND DATA_02B653,Y
	BNE +
	LDA wm_SpriteState,X
	PHA
	AND DATA_02B657,Y
	STA m0
	PLA
	LSR
	AND DATA_02B65B,Y
	ORA m0
	STA wm_SpriteState,X
+	INY
	CPY #$04
	BNE -
_02B726:
	JSR GetDrawInfo2
	LDA m1
	CLC
	ADC #$40
	STA m1
	LDA wm_SpriteState,X
	STA m2
	STA m7
	LDA wm_SpriteMiscTbl3,X
	STA m4
	LDY wm_SpriteDecTbl1,X
	LDA DATA_02B665,Y
	STA m3
	STZ m5
	LDY wm_SprOAMIndex,X
	PHX
	LDX #$04
-	STX m6
	LDA wm_FrameB
	LSR
	LSR
	LSR
	CLC
	ADC m6
	AND #$03
	TAX
	LDA m7
	CMP #$01
	BNE +
	LDX #$00
+	LDA m0
	CLC
	ADC.W PokeyTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDX m6
	LDA m1
	LSR m2
	BCC ++
	LSR m4
	BCS +
	PHA
	LDA m3
	STA m5
	PLA
+	SEC
	SBC m5
	STA wm_OamSlot.1.YPos,Y
++	LDA m1
	SEC
	SBC #$10
	STA m1
	LDA m2
	LSR
	LDA #$E8
	BCS +
	LDA #$8A
+	STA wm_OamSlot.1.Tile,Y
	LDA #$05
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDA #$04
	LDY #$02
_02B7A7:
	JSL FinishOAMWrite
	RTS

CODE_02B7AC:
	LDY #$09
-	TYA
	EOR wm_FrameA
	LSR
	BCS +
	LDA wm_SpriteStatus,Y
	CMP #$0A
	BNE +
	PHB
	LDA #:GetSpriteClippingB ; Also for the following 2 functions
	PHA
	PLB
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	JSL GetSpriteClippingA
	JSL CheckForContact
	PLB
	BCS CODE_02B7D6
+	DEY
	BPL -
_Return02B7D5:
	RTS

CODE_02B7D6:
	LDA wm_SpriteDecTbl3,X
	BNE _Return02B7D5
	LDA.W wm_SpriteYLo,Y
	SEC
	SBC wm_SpriteYLo,X
	PHY
	STY wm_CheckSprInter
	JSR RemovePokeySgmntRt
	PLY
	JSR CODE_02B82E
	RTS

RemovePokeySgmntRt:
	LDY #$00
	CMP #$09
	BMI +
	INY
	CMP #$19
	BMI +
	INY
	CMP #$29
	BMI +
	INY
	CMP #$39
	BMI +
	INY
+	LDA wm_SpriteState,X
	AND PokeyUnsetBit,Y
	STA wm_SpriteState,X
	STA wm_SpriteMiscTbl3,X
	LDA DATA_02B829,Y
	STA m13
	LDA #$0C
	STA wm_SpriteDecTbl1,X
	ASL
	STA wm_SpriteDecTbl3,X
	RTS

RemovePokeySegment:
	PHB
	PHK
	PLB
	JSR RemovePokeySgmntRt
	PLB
	RTL

PokeyUnsetBit:	.DB $EF,$F7,$FB,$FD,$FE

DATA_02B829:	.DB $E0,$F0,$F8,$FC,$FE

CODE_02B82E:
	JSL FindFreeSprSlot
	BMI +
	LDA #$02
	STA wm_SpriteStatus,Y
	LDA #$70
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDX wm_CheckSprInter
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	LDA wm_SpriteSpeedX,X
	STA m0
	ASL
	ROR m0
	LDA m0
	STA.W wm_SpriteSpeedX,Y
	LDA #$E0
	STA.W wm_SpriteSpeedY,Y
	PLX
	LDA wm_SpriteState,X
	AND m13
	STA.W wm_SpriteState,Y
	LDA #$01
	STA wm_SpriteMiscTbl5,Y
	LDA #$01
	JSL CODE_02ACE1
+	RTS

TorpedoTedMain:
	PHB
	PHK
	PLB
	JSR CODE_02B88A
	PLB
	RTL

CODE_02B88A:
	LDA wm_SpriteProp
	PHA
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LDA #$10
	STA wm_SpriteProp
+	JSR TorpedoGfxRt
	PLA
	STA wm_SpriteProp
	LDA wm_SpritesLocked
	BNE +
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02B8BC
	LDA #$08
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	LDA #$10
	STA wm_SpriteSpeedY,X
+	RTS

TorpedoMaxSpeed:	.DB $20,$F0

TorpedoAccel:	.DB $01,$FF

CODE_02B8BC:
	LDA wm_FrameA
	AND #$03
	BNE +
	LDY wm_SpriteDir,X
	LDA wm_SpriteSpeedX,X
	CMP TorpedoMaxSpeed,Y
	BEQ +
	CLC
	ADC TorpedoAccel,Y
	STA wm_SpriteSpeedX,X
+	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteSpeedY,X
	BEQ +
	LDA wm_FrameA
	AND #$01
	BNE +
	DEC wm_SpriteSpeedY,X
+	TXA
	CLC
	ADC wm_FrameB
	AND #$07
	BNE +
	JSR CODE_02B952
+	RTS

DATA_02B8F0:	.DB $10

DATA_02B8F1:	.DB $00,$10,$80,$82

DATA_02B8F5:	.DB $40,$00

TorpedoGfxRt:
	JSR GetDrawInfo2
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	PHX
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA m2
	LDA wm_SpriteDir,X
	TAX
	LDA m0
	CLC
	ADC.W DATA_02B8F0,X
	STA wm_OamSlot.1.XPos,Y
	LDA m0
	CLC
	ADC.W DATA_02B8F1,X
	STA wm_OamSlot.2.XPos,Y
	LDA.W DATA_02B8F5,X
	ORA m2
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	PLX
	LDA #$80
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteDecTbl1,X
	CMP #$01
	LDA #$82
	BCS +
	LDA wm_FrameB
	LSR
	LSR
	LDA #$A0
	BCC +
	LDA #$82
+	STA wm_OamSlot.2.Tile,Y
	LDA #$01
	LDY #$02
	JMP _02B7A7

DATA_02B94E:	.DB $F4,$1C

DATA_02B950:	.DB $FF,$00

CODE_02B952:
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ ++
	DEY
	BPL -
	DEC wm_OldSmokeIndex
	BPL +
	LDA #$03
	STA wm_OldSmokeIndex
+	LDY wm_OldSmokeIndex
++	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	PHX
	LDA wm_SpriteDir,X
	TAX
	LDA m0
	CLC
	ADC.W DATA_02B94E,X
	STA m2
	LDA m1
	ADC.W DATA_02B950,X
	PHA
	LDA m2
	CMP wm_Bg1HOfs
	PLA
	PLX
	SBC wm_Bg1HOfs+1
	BNE +
	LDA #$01
	STA wm_SmokeSprite,Y
	LDA m2
	STA wm_SmokeXPos,Y
	LDA wm_SpriteYLo,X
	STA wm_SmokeYPos,Y
	LDA #$0F
	STA wm_SmokeTimer,Y
+	RTS

GenTileFromSpr0: ; unreachable
	STA wm_BlockId
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	JSL GenerateTile
	RTL

CODE_02B9BD:
	LDA #$02
	STA wm_SilverCoins
	LDY #$09
-	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC +
	LDA wm_Tweaker190F,Y
	AND #$40
	BNE +
	JSR CODE_02B9D9
+	DEY
	BPL -
	RTL

CODE_02B9D9:
	LDA #$21
	STA.W wm_SpriteNum,Y
	LDA #$08
	STA wm_SpriteStatus,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDA wm_SpritePal,X
	AND #$F1
	ORA #$02
	STA wm_SpritePal,X
	LDA #$D8
	STA.W wm_SpriteSpeedY,X
	PLX
	RTS

CODE_02B9FA:
	STZ m15
	BRA CODE_02BA48

ADDR_02B9FE: ; unreachable similar to below
	LDA m1
	AND #$F0
	STA m4
	LDA m9
	CMP wm_ScreensInLvl
	BCS Return02BA47
	STA m5
	LDA m0
	STA m7
	LDA m8
	CMP #$02
	BCS Return02BA47
	STA m10
	LDA m7
	LSR
	LSR
	LSR
	LSR
	ORA m4
	STA m4
	LDX m5
	LDA.L DATA_00BA80,X
	LDY m15
	BEQ +
	LDA.L DATA_00BA8E,X
+	CLC
	ADC m4
	STA m5
	LDA.L DATA_00BABC,X
	LDY m15
	BEQ +
	LDA.L DATA_00BACA,X
+	ADC m10
	STA m6
	BRA _02BA92

Return02BA47:
	RTL

CODE_02BA48:
	LDA m1
	AND #$F0
	STA m4
	LDA m9
	CMP #$02
	BCS Return02BA47
	STA m13
	STA wm_YoshiBerryWalkY+1
	LDA m0
	STA m6
	LDA m8
	CMP wm_ScreensInLvl
	BCS Return02BA47
	STA m7
	LDA m6
	LSR
	LSR
	LSR
	LSR
	ORA m4
	STA m4
	LDX m7
	LDA.L DATA_00BA60,X
	LDY m15
	BEQ +
	LDA.L DATA_00BA70,X
+	CLC
	ADC m4
	STA m5
	LDA.L DATA_00BA9C,X
	LDY m15
	BEQ +
	LDA.L DATA_00BAAC,X
+	ADC m13
	STA m6
_02BA92:
	LDX wm_SprProcessIndex
	LDA #$7E
	STA m7
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	BNE +
	LDA wm_Map16NumLo
	CMP #$45
	BCC +
	CMP #$48
	BCS +
	SEC
	SBC #$44
	STA wm_BerryEatenType
	LDY #$0B
-	LDA wm_SpriteStatus,Y
	BEQ CODE_02BAC0
	DEY
	BPL -
+	RTL

CODE_02BAC0:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$74
	STA.W wm_SpriteNum,Y
	LDA m0
	STA.W wm_SpriteXLo,Y
	STA wm_BlockYPos
	LDA m8
	STA wm_SpriteXHi,Y
	STA wm_BlockYPos+1
	LDA m1
	STA.W wm_SpriteYLo,Y
	STA wm_BlockXPos
	LDA m9
	STA wm_SpriteYHi,Y
	STA wm_BlockXPos+1
	PHX
	TYX
	JSL InitSpriteTables
	INC wm_SpriteMiscTbl8,X
	LDA wm_Tweaker1662,X
	AND #$F0
	ORA #$0C
	STA wm_Tweaker1662,X
	LDA wm_Tweaker167A,X
	AND #$BF
	STA wm_Tweaker167A,X
	PLX
	LDA #$04
	STA wm_BlockId
	JSL GenerateTile
	RTL

DATA_02BB0B:	.DB $02,$FA,$06,$06

DATA_02BB0F:	.DB $00,$FF,$00,$00

DATA_02BB13:	.DB $10,$08,$10,$08

YoshiWingsTiles:	.DB $5D,$C6,$5D,$C6

YoshiWingsGfxProp:	.DB $46,$46,$06,$06

YoshiWingsSize:	.DB $00,$02,$00,$02

CODE_02BB23:
	STA m2
	JSR IsSprOffScreenBnk2
	BNE ++
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m4
	LDA wm_SpriteYLo,X
	STA m1
	LDY #$F8
	PHX
	LDA wm_SpriteDir,X
	ASL
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.L DATA_02BB0B,X
	STA m0
	LDA m4
	ADC.L DATA_02BB0F,X
	PHA
	LDA m0
	SEC
	SBC wm_Bg1HOfs
	STA wm_ExOamSlot.1.XPos,Y
	PLA
	SBC wm_Bg1HOfs+1
	BNE +
	LDA m1
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC.L DATA_02BB13,X
	STA wm_ExOamSlot.1.YPos,Y
	LDA.L YoshiWingsTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA.L YoshiWingsGfxProp,X
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA.L YoshiWingsSize,X
	STA wm_ExOamSize.1,Y
+	PLX
++	RTL

DATA_02BB88:	.DB $FF,$01,$FF,$01,$00,$00

DATA_02BB8E:	.DB $E8,$18,$F8,$08,$00,$00

DolphinMain:
	JSR CODE_02BC14
	LDA wm_SpritesLocked
	BNE +++
	JSR SubOffscreen1Bnk2
	JSR UpdateYPosNoGrvty2
	JSR UpdateXPosNoGrvty2
	STA wm_SpriteMiscTbl4,X
	LDA wm_FrameB
	AND #$00
	BNE ++
	LDA wm_SpriteSpeedY,X
	BMI +
	CMP #$3F
	BCS ++
+	INC wm_SpriteSpeedY,X
++	TXA
	EOR wm_FrameA
	LSR
	BCC +
	JSL CODE_019138
+	LDA wm_SpriteSpeedY,X
	BMI ++
	LDA wm_SprInWaterTbl,X
	BEQ ++
	LDA wm_SpriteSpeedY,X
	BEQ +
	SEC
	SBC #$08
	STA wm_SpriteSpeedY,X
	BPL +
	STZ wm_SpriteSpeedY,X
+	LDA wm_SpriteMiscTbl3,X
	BNE +
	LDA wm_SpriteState,X
	LSR
	PHP
	LDA wm_SpriteNum,X
	SEC
	SBC #$41
	PLP
	ROL
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_02BB88,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_02BB8E,Y
	BNE ++
	INC wm_SpriteState,X
+	LDA #$C0
	STA wm_SpriteSpeedY,X
++	JSL InvisBlkMainRt
+++	RTL

CODE_02BC00:
	LDA wm_FrameB
	AND #$04
	LSR
	LSR
	STA wm_SpriteDir,X
	JSL GenericSprGfxRt1
	RTS

DolphinTiles1:	.DB $E2,$88

DolphinTiles2:	.DB $E7,$A8

DolphinTiles3:	.DB $E8,$A9

CODE_02BC14:
	LDA wm_SpriteNum,X
	CMP #$43
	BNE CODE_02BC1D
	JMP CODE_02BC00

CODE_02BC1D:
	JSR GetDrawInfo2
	LDA wm_SpriteSpeedX,X
	STA m2
	LDA m0
	ASL m2
	PHP
	BCC CODE_02BC3C
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.3.XPos,Y
	BRA _02BC4E

CODE_02BC3C:
	CLC
	ADC #$18
	STA wm_OamSlot.1.XPos,Y
	SEC
	SBC #$10
	STA wm_OamSlot.2.XPos,Y
	SEC
	SBC #$08
	STA wm_OamSlot.3.XPos,Y
_02BC4E:
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	STA wm_OamSlot.3.YPos,Y
	PHX
	LDA wm_FrameB
	AND #$08
	LSR
	LSR
	LSR
	TAX
	LDA.W DolphinTiles1,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DolphinTiles2,X
	STA wm_OamSlot.2.Tile,Y
	LDA.W DolphinTiles3,X
	STA wm_OamSlot.3.Tile,Y
	PLX
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	PLP
	BCS +
	ORA #$40
+	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	LDA #$02
	LDY #$02
	JMP _02B7A7

DATA_02BC8F:	.DB $08,$00,$F8,$00,$F8,$00,$08,$00

DATA_02BC97:	.DB $00,$08,$00,$F8,$00,$08,$00,$F8

DATA_02BC9F:	.DB $01,$FF,$FF,$01,$FF,$01,$01,$FF

DATA_02BCA7:	.DB $01,$01,$FF,$FF,$01,$01,$FF,$FF

DATA_02BCAF:	.DB $01,$04,$02,$08,$02,$04,$01,$08

DATA_02BCB7:
	.DB $00,$02,$00,$02,$00,$02,$00,$02
	.DB $05,$04,$05,$04,$05,$04,$05,$04

DATA_02BCC7:
	.DB $00,$C0,$C0,$00,$40,$80,$80,$40
	.DB $80,$C0,$40,$00,$C0,$80,$00,$40

DATA_02BCD7:	.DB $00,$01,$02,$01

WallFollowersMain:
	JSL SprSprInteract
	JSL GetRand
	AND #$FF
	ORA wm_SpritesLocked
	BNE +
	LDA #$0C
	STA wm_SpriteDecTbl3,X
+	LDA wm_SpriteNum,X
	CMP #$2E
	BNE CODE_02BD23
	LDY wm_SpriteState,X
	LDA wm_SpriteDecTbl4,X
	BEQ CODE_02BD04
	TYA
	CLC
	ADC #$08
	TAY
	LDA #$00
	BRA _02BD0B

CODE_02BD04:
	LDA wm_FrameB
	LSR
	LSR
	LSR
	AND #$01
_02BD0B:
	CLC
	ADC DATA_02BCB7,Y
	STA wm_SpriteGfxTbl,X
	LDA wm_SpritePal,X
	AND #$3F
	ORA DATA_02BCC7,Y
	STA wm_SpritePal,X
	JSL GenericSprGfxRt2
	BRA _02BD2F

CODE_02BD23:
	CMP #$A5
	BCC CODE_02BD2C
	JSR CODE_02BE4E
	BRA _02BD2F

CODE_02BD2C:
	JSR CODE_02BF5C
_02BD2F:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_02BD3F
	STZ wm_SpriteMiscTbl4,X
	LDA #$FF
	STA wm_SpriteDecTbl3,X
	RTL

CODE_02BD3F:
	LDA wm_SpritesLocked
	BNE _Return02BD74
	JSR SubOffscreen3Bnk2
	JSL MarioSprInteract
	LDA wm_SpriteNum,X
	CMP #$2E
	BEQ CODE_02BDA7
	CMP #$3C
	BEQ _02BDB3
	CMP #$A5
	BEQ _02BDB3
	CMP #$A6
	BEQ _02BDB3
	LDA wm_SpriteState,X
	AND #$01
	JSL ExecutePtr

UrchinPtrs:
	.DW CODE_02BD68
	.DW CODE_02BD75

CODE_02BD68:
	LDA wm_SpriteDecTbl1,X
	BNE _Return02BD74
	LDA #$80
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
_Return02BD74:
	RTL

CODE_02BD75:
	LDA wm_SpriteNum,X
	CMP #$3B
	BEQ +
	LDA wm_SpriteDecTbl1,X
	BEQ ++
+	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$0F
	BEQ +
++	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedY,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedY,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
+	RTL

CODE_02BDA7:
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$E0
	BCC _02BDB3
	STZ wm_SpriteStatus,X
_02BDB3:
	LDA wm_SpriteDecTbl1,X
	BNE ++
	LDY wm_SpriteState,X
	LDA DATA_02BCA7,Y
	STA wm_SpriteSpeedY,X
	LDA DATA_02BC9F,Y
	STA wm_SpriteSpeedX,X
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$0F
	BNE ++
	LDA #$08
	STA wm_SpriteDecTbl4,X
	LDA #$38
	LDY wm_SpriteNum,X
	CPY #$3C
	BEQ +
	LDA #$1A
	CPY #$A5
	BNE +
	LSR
	NOP
+	STA wm_SpriteDecTbl1,X
++	LDA #$20
	LDY wm_SpriteNum,X
	CPY #$3C
	BEQ +
	LDA #$10
	CPY #$A5
	BNE +
	LSR
	NOP
+	CMP wm_SpriteDecTbl1,X
	BNE ++
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	CMP #$04
	BNE +
	STZ wm_SpriteState,X
+	CMP #$08
	BNE ++
	LDA #$04
	STA wm_SpriteState,X
++	LDY wm_SpriteState,X
	LDA wm_SprObjStatus,X
	AND DATA_02BCAF,Y
	BEQ _02BE2F
	LDA #$08
	STA wm_SpriteDecTbl4,X
	DEC wm_SpriteState,X
	LDA wm_SpriteState,X
	BPL CODE_02BE27
	LDA #$03
	BRA _02BE2D

CODE_02BE27:
	CMP #$03
	BNE _02BE2F
	LDA #$07
_02BE2D:
	STA wm_SpriteState,X
_02BE2F:
	LDY wm_SpriteState,X
	LDA DATA_02BC97,Y
	STA wm_SpriteSpeedY,X
	LDA DATA_02BC8F,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteNum,X
	CMP #$A5
	BNE +
	ASL wm_SpriteSpeedX,X
	ASL wm_SpriteSpeedY,X
+	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	RTL

DATA_02BE4C:	.DB $05,$45

CODE_02BE4E:
	LDA wm_SpriteNum,X
	CMP #$A5
	BNE CODE_02BEB5
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_CurSprGfx
	CMP #$02
	BNE CODE_02BE79
	PHX
	LDA wm_FrameB
	LSR
	LSR
	AND #$01
	TAX
	LDA #$C8
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02BE4C,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	RTS

CODE_02BE79:
	LDA #$0A
	STA wm_OamSlot.1.Tile,Y
	LDA wm_FrameB
	AND #$0C
	ASL
	ASL
	ASL
	ASL
	EOR wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.1.Prop,Y
	RTS

DATA_02BE8D:	.DB $F8,$08,$F8,$08

DATA_02BE91:	.DB $F8,$F8,$08,$08

HotheadTiles:	.DB $0C,$0E,$0E,$0C,$0E,$0C,$0C,$0E

DATA_02BE9D:	.DB $05,$05,$C5,$C5,$45,$45,$85,$85

DATA_02BEA5:	.DB $07,$07,$01,$01,$01,$01,$07,$07

DATA_02BEAD:	.DB $00,$08,$08,$00,$00,$08,$08,$00

CODE_02BEB5:
	JSR GetDrawInfo2
	TYA
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	TAY
	LDA wm_FrameB
	AND #$04
	STA m3
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_02BE8D,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02BE91,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	TXA
	ORA m3
	TAX
	LDA.W HotheadTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02BE9D,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDA m0
	PHA
	LDA m1
	PHA
	LDY #$02
	LDA #$03
	JSR _02B7A7
	PLA
	STA m1
	PLA
	STA m0
	LDA #$09
	LDY wm_SpriteDecTbl3,X
	BEQ +
	LDA #$19
+	STA m2
	LDA wm_SprOAMIndex,X
	SEC
	SBC #$04
	STA wm_SprOAMIndex,X
	TAY
	PHX
	LDA wm_SpriteState,X
	TAX
	LDA m0
	CLC
	ADC.W DATA_02BEA5,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02BEAD,X
	STA wm_OamSlot.1.YPos,Y
	LDA m2
	STA wm_OamSlot.1.Tile,Y
	LDA #$05
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	LDY #$00
	LDA #$00
	JMP _02B7A7

DATA_02BF49:	.DB $08,$00,$10,$00,$10

DATA_02BF4E:	.DB $08,$00,$00,$10,$10

DATA_02BF53:	.DB $37,$37,$77,$B7,$F7

UrchinTiles:	.DB $C4,$C6,$C8,$C6

CODE_02BF5C:
	LDA wm_SpriteDecTbl6,X
	BNE +
	INC wm_SpriteMiscTbl4,X
	LDA #$0C
	STA wm_SpriteDecTbl6,X
+	LDA wm_SpriteMiscTbl4,X
	AND #$03
	TAY
	LDA DATA_02BCD7,Y
	STA wm_SpriteGfxTbl,X
	JSR GetDrawInfo2
	STZ m5
	LDA wm_SpriteGfxTbl,X
	STA m2
	LDA wm_SpriteDecTbl3,X
	STA m3
_02BF84:
	LDX m5
	LDA m0
	CLC
	ADC.W DATA_02BF49,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02BF4E,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_02BF53,X
	STA wm_OamSlot.1.Prop,Y
	CPX #$00
	BNE CODE_02BFAC
	LDA #$CA
	LDX m3
	BEQ +
	LDA #$CC
+	BRA _02BFB1

CODE_02BFAC:
	LDX m2
	LDA.W UrchinTiles,X
_02BFB1:
	STA wm_OamSlot.1.Tile,Y
	INY
	INY
	INY
	INY
	INC m5
	LDA m5
	CMP #$05
	BNE _02BF84
	LDX wm_SprProcessIndex
	LDY #$02
	JMP _02C82B

DATA_02BFC8:	.DB $10,$F0

DATA_02BFCA:	.DB $01,$FF

Return02BFCC:
	RTL

RipVanFishMain:
	JSL GenericSprGfxRt2
	LDA wm_SpritesLocked
	BNE Return02BFCC
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	LDA wm_SpriteSpeedX,X
	PHA
	LDA wm_SpriteSpeedY,X
	PHA
	LDY wm_StarPowerTimer
	BEQ +
	EOR #$FF
	INC A
	STA wm_SpriteSpeedY,X
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
+	JSR CODE_02C126
	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	JSL CODE_019138
	PLA
	STA wm_SpriteSpeedY,X
	PLA
	STA wm_SpriteSpeedX,X
	INC wm_SpriteMiscTbl6,X
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	STZ wm_SpriteSpeedX,X
+	LDA wm_SprObjStatus,X
	AND #$0C
	BEQ +
	STZ wm_SpriteSpeedY,X
+	LDA wm_SprInWaterTbl,X
	BNE +
	LDA #$10
	STA wm_SpriteSpeedY,X
+	LDA wm_SpriteState,X
	JSL ExecutePtr

RipVanFishPtrs:
	.DW CODE_02C02E
	.DW CODE_02C08A

CODE_02C02E:
	LDA #$02
	STA wm_SpriteSpeedY,X
	LDA wm_FrameA
	AND #$03
	BNE _02C044
	LDA wm_SpriteSpeedX,X
	BEQ _02C044
	BPL CODE_02C042
	INC wm_SpriteSpeedX,X
	BRA _02C044

CODE_02C042:
	DEC wm_SpriteSpeedX,X
_02C044:
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteYLo,X
	AND #$F0
	STA wm_SpriteYLo,X
+	JSL CODE_02C0D9
	LDA wm_ChuckWhistles
	BNE +
	JSR CODE_02D4FA
	LDA m15
	ADC #$30
	CMP #$60
	BCS CODE_02C07B
	JSR CODE_02D50C
	LDA m14
	ADC #$30
	CMP #$60
	BCS CODE_02C07B
+	INC wm_SpriteState,X
	LDA #$FF
	STA wm_SpriteMiscTbl3,X
	BRA CODE_02C08A

CODE_02C07B:
	LDY #$02
	LDA wm_SpriteMiscTbl6,X
	AND #$30
	BNE +
	INY
+	TYA
	STA wm_SpriteGfxTbl,X
	RTL

CODE_02C08A:
	LDA wm_FrameA
	AND #$01
	BNE +
	DEC wm_SpriteMiscTbl3,X
	BEQ CODE_02C0CA
+	LDA wm_FrameA
	AND #$07
	BNE ++
	JSR CODE_02D4FA
	LDA wm_SpriteSpeedX,X
	CMP DATA_02BFC8,Y
	BEQ +
	CLC
	ADC DATA_02BFCA,Y
	STA wm_SpriteSpeedX,X
+	JSR CODE_02D50C
	LDA wm_SpriteSpeedY,X
	CMP DATA_02BFC8,Y
	BEQ ++
	CLC
	ADC DATA_02BFCA,Y
	STA wm_SpriteSpeedY,X
++	LDY #$00
	LDA wm_SpriteMiscTbl6,X
	AND #$04
	BEQ +
	INY
+	TYA
	STA wm_SpriteGfxTbl,X
	RTL

CODE_02C0CA:
	STZ wm_SpriteState,X
	JMP CODE_02C02E

ADDR_02C0CF: ; unreachable
	LDA #$08
	LDY wm_SpriteDir,X
	BEQ +
	INC A
+	BRA _02C0DB

CODE_02C0D9:
	LDA #$06
_02C0DB:
	TAY
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE +++
	TYA
	DEC wm_SpriteMiscTbl4,X
	BPL +++
	PHA
	LDA #$28
	STA wm_SpriteMiscTbl4,X
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ ++
	DEY
	BPL -
	DEC wm_DelOldExSpr
	BPL +
	LDA #$0B
	STA wm_DelOldExSpr
+	LDY wm_DelOldExSpr
++	PLA
	STA wm_MExSprNum,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$06
	STA wm_MExSprXLo,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$00
	STA wm_MExSprYLo,Y
	LDA #$7F
	STA wm_MExSprTimer,Y
	LDA #$FA
	STA wm_MExSprXSpeed,Y
+++	RTL

CODE_02C126:
	LDY #$00
	LDA wm_SpriteSpeedX,X
	BPL +
	INY
+	TYA
	STA wm_SpriteDir,X
	RTS

DATA_02C132:	.DB $30,$20,$0A,$30

DATA_02C136:	.DB $05,$0E,$0F,$10

CODE_02C13A:
	LDA wm_SpriteDecTbl3,X
	BEQ CODE_02C156
	CMP #$01
	BNE +
	LDA #$30
	STA wm_SpriteDecTbl1,X
	LDA #$04
	STA wm_SpriteMiscTbl5,X
	STZ wm_SpriteMiscTbl6,X
+	LDA #$02
	STA wm_SpriteMiscTbl3,X
	RTS

CODE_02C156:
	LDA wm_SpriteDecTbl1,X
	BNE _02C181
	INC wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl5,X
	AND #$03
	STA wm_SpriteMiscTbl6,X
	TAY
	LDA DATA_02C132,Y
	STA wm_SpriteDecTbl1,X
	CPY #$01
	BNE _02C181
	LDA wm_SpriteMiscTbl5,X
	AND #$0C
	BNE CODE_02C17E
	LDA #$40
	STA wm_SpriteDecTbl3,X
	RTS

CODE_02C17E:
	JSR CODE_02C19A
_02C181:
	LDY wm_SpriteMiscTbl6,X
	LDA DATA_02C136,Y
	STA wm_SpriteGfxTbl,X
	LDY wm_SpriteDir,X
	LDA DATA_02C1F3,Y
	STA wm_SpriteMiscTbl3,X
	RTS

DATA_02C194:	.DB $14,$EC

DATA_02C196:	.DB $00,$FF

DATA_02C198:	.DB $08,$F8

CODE_02C19A:
	JSL FindFreeSprSlot
	BMI +
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$48
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteDir,X
	STA m2
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	PHX
	TYX
	JSL InitSpriteTables
	LDX m2
	LDA m0
	CLC
	ADC.W DATA_02C194,X
	STA.W wm_SpriteXLo,Y
	LDA m1
	ADC.W DATA_02C196,X
	STA wm_SpriteXHi,Y
	LDA.W DATA_02C198,X
	STA.W wm_SpriteSpeedX,Y
	PLX
	LDA wm_SpriteYLo,X
	CLC
	ADC #$0A
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,Y
	LDA #$C0
	STA.W wm_SpriteSpeedY,Y
	LDA #$2C
	STA wm_SpriteDecTbl1,Y
+	RTS

DATA_02C1F3:	.DB $01,$03

ChucksMain:
	PHB
	PHK
	PLB
	LDA wm_SprStompImmuneTbl,X
	PHA
	JSR CODE_02C22C
	PLA
	BNE +
	CMP wm_SprStompImmuneTbl,X
	BEQ +
	LDA wm_SpriteDecTbl6,X
	BNE +
	LDA #$28
	STA wm_SpriteDecTbl6,X
+	PLB
	RTL

DATA_02C213:	.DB $01,$02,$03,$02

CODE_02C217:
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_02C213,Y
	STA wm_SpriteMiscTbl3,X
	JSR CODE_02C81A
	RTS

DATA_02C228:	.DB $40,$10

DATA_02C22A:	.DB $03,$01

CODE_02C22C:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE CODE_02C217
	LDA wm_SpriteDecTbl5,X
	BEQ +
	LDA #$05
	STA wm_SpriteGfxTbl,X
+	LDA wm_SprObjStatus,X
	AND #$04
	BNE +
	LDA wm_SpriteSpeedY,X
	BPL +
	LDA wm_SpriteState,X
	CMP #$05
	BCS +
	LDA #$06
	STA wm_SpriteGfxTbl,X
+	JSR CODE_02C81A
	LDA wm_SpritesLocked
	BEQ CODE_02C25B
	RTS

CODE_02C25B:
	JSR SubOffscreen0Bnk2
	JSR CODE_02C79D
	JSL SprSprInteract
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$08
	BEQ +
	LDA #$10
	STA wm_SpriteSpeedY,X
+	LDA wm_SprObjStatus,X
	AND #$03
	BEQ CODE_02C2F4
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE CODE_02C2E4
	LDA wm_SprStompImmuneTbl,X
	BEQ CODE_02C2E4
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$14
	CMP #$1C
	BCC CODE_02C2E4
	LDA wm_SprObjStatus,X
	AND #$40
	BNE CODE_02C2E4
	LDA wm_MirBlkCheck
	CMP #$2E
	BEQ +
	CMP #$1E
	BNE CODE_02C2E4
+	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _02C2F7
	LDA wm_BlockYPos+1
	PHA
	LDA wm_BlockYPos
	PHA
	LDA wm_BlockXPos+1
	PHA
	LDA wm_BlockXPos
	PHA
	JSL ShatterBlock
	LDA #$02
	STA wm_BlockId
	JSL GenerateTile
	PLA
	SEC
	SBC #$10
	STA wm_BlockXPos
	PLA
	SBC #$00
	STA wm_BlockXPos+1
	PLA
	STA wm_BlockYPos
	PLA
	STA wm_BlockYPos+1
	JSL ShatterBlock
	LDA #$02
	STA wm_BlockId
	JSL GenerateTile
	BRA CODE_02C2F4

CODE_02C2E4:
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _02C2F7
	LDA #$C0
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	BRA _02C301

CODE_02C2F4:
	JSR UpdateXPosNoGrvty2
_02C2F7:
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _02C301
	JSR _02C579
_02C301:
	JSR UpdateYPosNoGrvty2
	LDY wm_SprInWaterTbl,X
	CPY #$01
	LDY #$00
	LDA wm_SpriteSpeedY,X
	BCC +
	INY
	CMP #$00
	BPL +
	CMP #$E0
	BCS +
	LDA #$E0
+	CLC
	ADC DATA_02C22A,Y
	BMI +
	CMP DATA_02C228,Y
	BCC +
	LDA DATA_02C228,Y
+	TAY
	BMI +
	LDY wm_SpriteState,X
	CPY #$07
	BNE +
	CLC
	ADC #$03
+	STA wm_SpriteSpeedY,X
	LDA wm_SpriteState,X
	JSL ExecutePtr

ChuckPtrs:
	.DW CODE_02C63B
	.DW CODE_02C6A7
	.DW CODE_02C726
	.DW CODE_02C74A
	.DW CODE_02C13A
	.DW CODE_02C582
	.DW CODE_02C53C
	.DW CODE_02C564
	.DW CODE_02C4E3
	.DW CODE_02C4BD
	.DW CODE_02C3CB
	.DW CODE_02C356
	.DW CODE_02C37B

CODE_02C356:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	LDA wm_SprInWaterTbl,X
	BEQ +
	JSR CODE_02D4FA
	LDA m15
	CLC
	ADC #$30
	CMP #$60
	BCS +
	LDA #$0C
	STA wm_SpriteState,X
+	JMP CODE_02C556

DATA_02C373:	.DB $05,$05,$05,$02,$02,$06,$06,$06

CODE_02C37B:
	LDA wm_FrameB
	AND #$3F
	BNE +
	LDA #$1E
	STA wm_SoundCh3
+	LDY #$03
	LDA wm_FrameB
	AND #$30
	BEQ +
	LDY #$06
+	TYA
	STA wm_SpriteGfxTbl,X
	LDA wm_FrameB
	LSR
	LSR
	AND #$07
	TAY
	LDA DATA_02C373,Y
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	LSR
	LDA #$09
	BCC +
	STA wm_GeneratorNum
+	STA wm_ChuckWhistles
	RTS

DATA_02C3B3:	.DB $7F,$BF,$FF,$DF

DATA_02C3B7:	.DB $18,$19,$14,$14

DATA_02C3BB:
	.DB $18,$18,$18,$18,$17,$17,$17,$17
	.DB $17,$17,$16,$15,$15,$16,$16,$16

CODE_02C3CB:
	LDA wm_SpriteMiscTbl5,X
	BNE CODE_02C43A
	JSR CODE_02D50C
	LDA m14
	BPL +
	CMP #$D0
	BCS +
	LDA #$C8
	STA wm_SpriteSpeedY,X
	LDA #$3E
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteMiscTbl5,X
+	LDA wm_FrameA
	AND #$07
	BNE +
	LDA wm_SpriteDecTbl1,X
	BEQ +
	INC wm_SpriteDecTbl1,X
+	LDA wm_FrameB
	AND #$3F
	BNE +
	JSR CODE_02C556
+	LDA wm_SpriteDecTbl1,X
	BNE +
	LDY wm_SprStompImmuneTbl,X
	LDA DATA_02C3B3,Y
	STA wm_SpriteDecTbl1,X
+	LDA wm_SpriteDecTbl1,X
	CMP #$40
	BCS CODE_02C419
	LDA #$00
	STA wm_SpriteGfxTbl,X
	RTS

CODE_02C419:
	SEC
	SBC #$40
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_02C3B7,Y
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	AND #$1F
	CMP #$06
	BNE _Return02C439
	JSR CODE_02C466
	LDA #$08
	STA wm_SpriteDecTbl3,X
_Return02C439:
	RTS

CODE_02C43A:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02C45C
	PHA
	CMP #$20
	BCC +
	CMP #$30
	BCS +
	STZ wm_SpriteSpeedY,X
+	LSR
	LSR
	TAY
	LDA DATA_02C3BB,Y
	STA wm_SpriteGfxTbl,X
	PLA
	CMP #$26
	BNE +
	JSR CODE_02C466
+	RTS

CODE_02C45C:
	STZ wm_SpriteMiscTbl5,X
	RTS

BaseballTileDispX:	.DB $10,$F8

DATA_02C462:	.DB $00,$FF

BaseballSpeed:	.DB $18,$E8

CODE_02C466:
	LDA wm_SpriteDecTbl3,X
	ORA wm_OffscreenVert,X
	BNE _Return02C439
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_02C479
	DEY
	BPL -
	RTS

CODE_02C479:
	LDA #$0D
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	LDA wm_SpriteYLo,X
	CLC
	ADC #$00
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_ExSpriteYHi,Y
	PHX
	LDA wm_SpriteDir,X
	TAX
	LDA m0
	CLC
	ADC.W BaseballTileDispX,X
	STA wm_ExSpriteXLo,Y
	LDA m1
	ADC.W DATA_02C462,X
	STA wm_ExSpriteXHi,Y
	LDA.W BaseballSpeed,X
	STA wm_ExSprSpeedX,Y
	PLX
	RTS

DATA_02C4B5:	.DB $00,$00,$11,$11,$11,$11,$00,$00

CODE_02C4BD:
	STZ wm_SpriteGfxTbl,X
	TXA
	ASL
	ASL
	ASL
	ADC wm_FrameA
	AND #$7F
	CMP #$00
	BNE +
	PHA
	JSR CODE_02C556
	JSL CODE_03CBB3
	PLA
+	CMP #$20
	BCS +
	LSR
	LSR
	TAY
	LDA DATA_02C4B5,Y
	STA wm_SpriteGfxTbl,X
+	RTS

CODE_02C4E3:
	JSR CODE_02C556
	LDA #$06
	LDY wm_SpriteSpeedY,X
	CPY #$F0
	BMI ++
	LDY wm_SpriteMiscTbl8,X
	BEQ ++
	LDA wm_DisSprCapeContact,X
	BNE +
	LDA #$19
	STA wm_SoundCh3
	LDA #$20
	STA wm_DisSprCapeContact,X
+	LDA #$07
++	STA wm_SpriteGfxTbl,X
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteMiscTbl8,X
	LDA #$04
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$20
	STA wm_SpriteDecTbl1,X
	LDA #$F0
	STA wm_SpriteSpeedY,X
	JSR CODE_02D50C
	LDA m14
	BPL +
	CMP #$D0
	BCS +
	LDA #$C0
	STA wm_SpriteSpeedY,X
	INC wm_SpriteMiscTbl8,X
_02C536:
	LDA #$08
	STA wm_SoundCh3
+	RTS

CODE_02C53C:
	LDA #$06
	STA wm_SpriteGfxTbl,X
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	JSR _02C579
	JSR CODE_02C556
	LDA #$08
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
+	RTS

CODE_02C556:
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
	LDA DATA_02C639,Y
	STA wm_SpriteMiscTbl3,X
	RTS

CODE_02C564:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BNE _02C579
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	LDA #$05
	STA wm_SpriteState,X
_02C579:
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
+	RTS

DATA_02C57E:	.DB $10,$F0

DATA_02C580:	.DB $20,$E0

CODE_02C582:
	JSR CODE_02C556
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02C602
	CMP #$01
	BNE _02C5FC
	LDA wm_SpriteNum,X
	CMP #$93
	BNE CODE_02C5A7
	JSR CODE_02D4FA
	LDA DATA_02C580,Y
	STA wm_SpriteSpeedX,X
	LDA #$B0
	STA wm_SpriteSpeedY,X
	LDA #$06
	STA wm_SpriteState,X
	JMP _02C536

CODE_02C5A7:
	STZ wm_SpriteState,X
	LDA #$50
	STA wm_SpriteDecTbl1,X
	LDA #$10
	STA wm_SoundCh1
	STZ wm_TempTileGen
	JSR _02C5BC
	INC wm_TempTileGen
_02C5BC:
	JSL FindFreeSprSlot
	BMI _02C5FC
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$91
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDX wm_TempTileGen
	LDA.W DATA_02C57E,X
	STA.W wm_SpriteSpeedX,Y
	PLX
	LDA #$C8
	STA.W wm_SpriteSpeedY,Y
	LDA #$50
	STA wm_SpriteDecTbl1,Y
_02C5FC:
	LDA #$09
	STA wm_SpriteGfxTbl,X
	RTS

CODE_02C602:
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
	LDA m15
	CLC
	ADC #$50
	CMP #$A0
	BCS CODE_02C618
	LDA #$40
	STA wm_SpriteDecTbl1,X
	RTS

CODE_02C618:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	LDA wm_FrameA
	AND #$3F
	BNE +
	LDA #$E0
	STA wm_SpriteSpeedY,X
+	RTS

CODE_02C628:
	LDA #$08
	STA wm_SpriteDecTbl5,X
	RTS

DATA_02C62E:
	.DB $00,$00,$00,$00,$01,$02,$03,$04
	.DB $04,$04,$04

DATA_02C639:	.DB $00,$04

CODE_02C63B:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	STZ wm_SprStompImmuneTbl,X
	LDA wm_SpriteDecTbl1,X
	AND #$0F
	BNE CODE_02C668
	JSR CODE_02D50C
	LDA m14
	CLC
	ADC #$28
	CMP #$50
	BCS CODE_02C668
	JSR CODE_02C556
	INC wm_SprStompImmuneTbl,X
_02C65C:
	LDA #$02
	STA wm_SpriteState,X
	LDA #$18
	STA wm_SpriteDecTbl1,X
	RTS

DATA_02C666:	.DB $01,$FF

CODE_02C668:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02C677
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
	BRA _02C65C

CODE_02C677:
	LDA wm_FrameB
	AND #$03
	BNE +
	LDA wm_SpriteMiscTbl5,X
	AND #$01
	TAY
	LDA wm_SpriteMiscTbl7,X
	CLC
	ADC DATA_02C666,Y
	CMP #$0B
	BCS CODE_02C69B
	STA wm_SpriteMiscTbl7,X
+	LDY wm_SpriteMiscTbl7,X
	LDA DATA_02C62E,Y
	STA wm_SpriteMiscTbl3,X
	RTS

CODE_02C69B:
	INC wm_SpriteMiscTbl5,X
	RTS

DATA_02C69F:	.DB $10,$F0,$18,$E8

DATA_02C6A3:	.DB $12,$13,$12,$13

CODE_02C6A7:
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _02C6BA
	LDA wm_SpriteDecTbl6,X
	CMP #$01
	BRA _02C6BA

ADDR_02C6B5: ; unreachable, aha the unused sfx 24
	LDA #$24
	STA wm_SoundCh1
_02C6BA:
	JSR CODE_02D50C
	LDA m14
	CLC
	ADC #$30
	CMP #$60
	BCS +
	JSR CODE_02D4FA
	TYA
	CMP wm_SpriteDir,X
	BNE +
	LDA #$20
	STA wm_SpriteDecTbl1,X
	STA wm_SprStompImmuneTbl,X
+	LDA wm_SpriteDecTbl1,X
	BNE +
	STZ wm_SpriteState,X
	JSR CODE_02C628
	JSL GetRand
	AND #$3F
	ORA #$40
	STA wm_SpriteDecTbl1,X
+	LDY wm_SpriteDir,X
	LDA DATA_02C639,Y
	STA wm_SpriteMiscTbl3,X
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +++
	LDA wm_SprStompImmuneTbl,X
	BEQ ++
	LDA wm_FrameB
	AND #$07
	BNE +
	LDA #$01
	STA wm_SoundCh1
+	INY
	INY
++	LDA DATA_02C69F,Y
	STA wm_SpriteSpeedX,X
+++	LDA wm_FrameA
	LDY wm_SprStompImmuneTbl,X
	BNE +
	LSR
+	LSR
	AND #$03
	TAY
	LDA DATA_02C6A3,Y
	STA wm_SpriteGfxTbl,X
	RTS

CODE_02C726:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	JSR CODE_02C628
	LDA #$01
	STA wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
+	RTS

DATA_02C73D:	.DB $0A,$0B,$0A,$0C,$0D,$0C

DATA_02C743:	.DB $0C,$10,$10,$04,$08,$10,$18

CODE_02C74A:
	LDY wm_SpriteMiscTbl6,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteMiscTbl6,X
	INY
	CPY #$07
	BEQ CODE_02C777
	LDA DATA_02C743,Y
	STA wm_SpriteDecTbl1,X
+	LDA DATA_02C73D,Y
	STA wm_SpriteGfxTbl,X
	LDA #$02
	CPY #$05
	BNE +
	LDA wm_FrameB
	LSR
	NOP
	AND #$02
	INC A
+	STA wm_SpriteMiscTbl3,X
	RTS

CODE_02C777:
	LDA wm_SpriteNum,X
	CMP #$94
	BEQ CODE_02C794
	CMP #$46
	BNE +
	LDA #$91
	STA wm_SpriteNum,X
+	LDA #$30
	STA wm_SpriteDecTbl1,X
	LDA #$02
	STA wm_SpriteState,X
	INC wm_SprStompImmuneTbl,X
	JMP CODE_02C556

CODE_02C794:
	LDA #$0C
	STA wm_SpriteState,X
	RTS

UNK_02C799:	.DB $F0,$10

DATA_02C79B:	.DB $20,$E0

CODE_02C79D:
	LDA wm_SpriteDecTbl4,X
	BNE _Return02C80F
	JSL MarioSprInteract
	BCC _Return02C80F
	LDA wm_StarPowerTimer
	BEQ CODE_02C7C4
	LDA #$D0
	STA wm_SpriteSpeedY,X
_02C7B1:
	STZ wm_SpriteSpeedX,X
	LDA #$02
	STA wm_SpriteStatus,X
	LDA #$03
	STA wm_SoundCh1
	LDA #$03
	JSL GivePoints
	RTS

CODE_02C7C4:
	JSR CODE_02D50C
	LDA m14
	CMP #$EC
	BPL CODE_02C810
	LDA #$05
	STA wm_SpriteDecTbl4,X
	LDA #$02
	STA wm_SoundCh1
	JSL DisplayContactGfx
	JSL BoostMarioSpeed
	STZ wm_SpriteDecTbl6,X
	LDA wm_SpriteState,X
	CMP #$03
	BEQ _Return02C80F
	INC wm_SpriteMiscTbl4,X
	LDA wm_SpriteMiscTbl4,X
	CMP #$03
	BCC CODE_02C7F6
	STZ wm_SpriteSpeedY,X
	BRA _02C7B1

CODE_02C7F6:
	LDA #$28
	STA wm_SoundCh3
	LDA #$03
	STA wm_SpriteState,X
	LDA #$03
	STA wm_SpriteDecTbl1,X
	STZ wm_SpriteMiscTbl6,X
	JSR CODE_02D4FA
	LDA DATA_02C79B,Y
	STA wm_MarioSpeedX
_Return02C80F:
	RTS

CODE_02C810:
	LDA wm_OnYoshi
	BNE +
	JSL HurtMario
+	RTS

CODE_02C81A:
	JSR GetDrawInfo2
	JSR CODE_02C88C
	JSR CODE_02CA27
	JSR CODE_02CA9D
	JSR CODE_02CBA1
	LDY #$FF
_02C82B:
	LDA #$04
	JMP _02B7A7

DATA_02C830:
	.DB $F8,$F8,$F8,$00,$00,$FE,$00,$00
	.DB $FA,$00,$00,$00,$00,$00,$00,$FD
	.DB $FD,$F9,$F6,$F6,$F8,$FE,$FC,$FA
	.DB $F8,$FA

DATA_02C84A:
	.DB $F8,$F9,$F7,$F8,$FC,$F8,$F4,$F5
	.DB $F5,$FC,$FD,$00,$F9,$F5,$F8,$FA
	.DB $F6,$F6,$F4,$F4,$F8,$F6,$F6,$F8
	.DB $F8,$F5

DATA_02C864:
	.DB $08,$08,$08,$00,$00,$00,$08,$08
	.DB $08,$00,$08,$08,$00,$00,$00,$00
	.DB $00,$08,$10,$10,$0C,$0C,$0C,$0C
	.DB $0C,$0C

ChuckHeadTiles:	.DB $06,$0A,$0E,$0A,$06,$4B,$4B

DATA_02C885:	.DB $40,$40,$00,$00,$00,$00,$40

CODE_02C88C:
	STZ m7
	LDY wm_SpriteGfxTbl,X
	STY m4
	CPY #$09
	CLC
	BNE +
	LDA wm_SpriteDecTbl1,X
	SEC
	SBC #$20
	BCC +
	PHA
	LSR
	LSR
	LSR
	LSR
	LSR
	STA m7
	PLA
	LSR
	LSR
+	LDA m0
	ADC #$00
	STA m0
	LDA wm_SpriteMiscTbl3,X
	STA m2
	LDA wm_SpriteDir,X
	STA m3
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA m8
	LDA wm_SprOAMIndex,X
	STA m5
	CLC
	ADC DATA_02C864,Y
	TAY
	LDX m4
	LDA.W DATA_02C830,X
	LDX m3
	BNE +
	EOR #$FF
	INC A
+	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	LDX m4
	LDA m1
	CLC
	ADC.W DATA_02C84A,X
	SEC
	SBC m7
	STA wm_OamSlot.1.YPos,Y
	LDX m2
	LDA.W DATA_02C885,X
	ORA m8
	STA wm_OamSlot.1.Prop,Y
	LDA.W ChuckHeadTiles,X
	STA wm_OamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	LDX wm_SprProcessIndex
	RTS

DATA_02C909:
	.DB $F8,$F8,$F8,$FC,$FC,$FC,$FC,$F8
	.DB $01,$FC,$FC,$FC,$FC,$FC,$FC,$FC
	.DB $FC,$F8,$F8,$F8,$F8,$08,$06,$F8
	.DB $F8,$01,$10,$10,$10,$04,$04,$04
	.DB $04,$08,$07,$04,$04,$04,$04,$04
	.DB $04,$04,$04,$10,$08,$08,$10,$00
	.DB $02,$10,$10,$07

DATA_02C93D:
	.DB $00,$00,$00,$04,$04,$04,$04,$08
	.DB $00,$04,$04,$04,$04,$04,$04,$04
	.DB $04,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$FC,$FC,$FC
	.DB $FC,$F8,$00,$FC,$FC,$FC,$FC,$FC
	.DB $FC,$FC,$FC,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00

DATA_02C971:
	.DB $06,$06,$06,$00,$00,$00,$00,$00
	.DB $F8,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$03,$00,$00,$06,$F8,$F8,$00
	.DB $00,$F8

ChuckBody1:
	.DB $0D,$34,$35,$26,$2D,$28,$40,$42
	.DB $5D,$2D,$64,$64,$64,$64,$E7,$28
	.DB $82,$CB,$23,$20,$0D,$0C,$5D,$BD
	.DB $BD,$5D

ChuckBody2:
	.DB $4E,$0C,$22,$26,$2D,$29,$40,$42
	.DB $AE,$2D,$64,$64,$64,$64,$E8,$29
	.DB $83,$CC,$24,$21,$4E,$A0,$A0,$A2
	.DB $A4,$AE

DATA_02C9BF:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$40,$00,$00
	.DB $00,$00

DATA_02C9D9:
	.DB $00,$00,$00,$40,$40,$00,$40,$40
	.DB $00,$40,$40,$40,$40,$40,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00

DATA_02C9F3:
	.DB $00,$00,$00,$02,$02,$02,$02,$02
	.DB $00,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$00,$02,$02,$00,$00,$00,$00
	.DB $00,$00

DATA_02CA0D:
	.DB $00,$00,$00,$04,$04,$04,$0C,$0C
	.DB $00,$08,$00,$00,$04,$04,$04,$04
	.DB $04,$00,$08,$08,$00,$00,$00,$00
	.DB $00,$00

CODE_02CA27:
	STZ m6
	LDA m4
	LDY m3
	BNE +
	CLC
	ADC #$1A
	LDX #$40
	STX m6
+	TAX
	LDY m4
	LDA DATA_02CA0D,Y
	CLC
	ADC m5
	TAY
	LDA m0
	CLC
	ADC.W DATA_02C909,X
	STA wm_OamSlot.1.XPos,Y
	LDA m0
	CLC
	ADC.W DATA_02C93D,X
	STA wm_OamSlot.2.XPos,Y
	LDX m4
	LDA m1
	CLC
	ADC.W DATA_02C971,X
	STA wm_OamSlot.1.YPos,Y
	LDA m1
	STA wm_OamSlot.2.YPos,Y
	LDA.W ChuckBody1,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W ChuckBody2,X
	STA wm_OamSlot.2.Tile,Y
	LDA m8
	ORA m6
	PHA
	EOR.W DATA_02C9BF,X
	STA wm_OamSlot.1.Prop,Y
	PLA
	EOR.W DATA_02C9D9,X
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_02C9F3,X
	STA wm_OamSize.1,Y
	LDA #$02
	STA wm_OamSize.2,Y
	LDX wm_SprProcessIndex
	RTS

DATA_02CA93:	.DB $FA,$00

DATA_02CA95:	.DB $0E,$00

ClappinChuckTiles:	.DB $0C,$44

DATA_02CA99:	.DB $F8,$F0

DATA_02CA9B:	.DB $00,$02

CODE_02CA9D:
	LDA m4
	CMP #$14
	BCC CODE_02CAA6
	JMP CODE_02CB53

CODE_02CAA6:
	CMP #$12
	BEQ CODE_02CAFC
	CMP #$13
	BEQ CODE_02CAFC
	SEC
	SBC #$06
	CMP #$02
	BCS +
	TAX
	LDY m5
	LDA m0
	CLC
	ADC.W DATA_02CA93,X
	STA wm_OamSlot.1.XPos,Y
	LDA m0
	CLC
	ADC.W DATA_02CA95,X
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02CA99,X
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA.W ClappinChuckTiles,X
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA m8
	STA wm_OamSlot.1.Prop,Y
	ORA #$40
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_02CA9B,X
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	LDX wm_SprProcessIndex
+	RTS

ChuckGfxProp:	.DB $47,$07 ; BUG-FIX: ID 005-00

CODE_02CAFC:
	LDY m5
	LDA wm_SpriteDir,X
	PHX
	TAX
	ASL
	ASL
	ASL
	PHA
	EOR #$08
	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	PLA
	CLC
	ADC m0
	STA wm_OamSlot.2.XPos,Y
	LDA #$1C
	STA wm_OamSlot.1.Tile,Y
	INC A
	STA wm_OamSlot.2.Tile,Y
	LDA m1
	SEC
	SBC #$08
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA.W ChuckGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAX
	STZ wm_OamSize.1,X
	STZ wm_OamSize.2,X
	PLX
	RTS

DATA_02CB41:
	.DB $FA,$0A,$06,$00,$00,$01,$0E,$FE
	.DB $02,$00,$00,$09,$08,$F4,$F4,$00
	.DB $00,$F4

CODE_02CB53:
	PHX
	STA m2
	LDY wm_SpriteDir,X
	BNE +
	CLC
	ADC #$06
+	TAX
	LDA m5
	CLC
	ADC #$08
	TAY
	LDA m0
	CLC
	ADC.W DATA_02CB41-20,X
	STA wm_OamSlot.1.XPos,Y
	LDX m2
	LDA.W DATA_02CB41-8,X
	BEQ +
	CLC
	ADC m1
	STA wm_OamSlot.1.YPos,Y
	LDA #$AD
	STA wm_OamSlot.1.Tile,Y
	LDA #$09
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAX
	STZ wm_OamSize.1,X
+	PLX
	RTS

DigChuckTileDispX:	.DB $FC,$04,$10,$F0,$12,$EE

DigChuckTileProp:	.DB $47,$07

DigChuckTileDispY:	.DB $F8,$00,$F8

DigChuckTiles:	.DB $CA,$E2,$A0

DigChuckTileSize:	.DB $00,$02,$02

CODE_02CBA1:
	LDA wm_SpriteNum,X
	CMP #$46
	BNE _Return02CBFB
	LDA wm_SpriteGfxTbl,X
	CMP #$05
	BNE CODE_02CBB2
	LDA #$01
	BRA _02CBB9

CODE_02CBB2:
	CMP #$0E
	BCC _Return02CBFB
	SEC
	SBC #$0E
_02CBB9:
	STA m2
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$0C
	TAY
	PHX
	LDA m2
	ASL
	ORA wm_SpriteDir,X
	TAX
	LDA m0
	CLC
	ADC.W DigChuckTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	TXA
	AND #$01
	TAX
	LDA.W DigChuckTileProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDX m2
	LDA m1
	CLC
	ADC.W DigChuckTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DigChuckTiles,X
	STA wm_OamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA.W DigChuckTileSize,X
	STA wm_OamSize.1,Y
	PLX
_Return02CBFB:
	RTS

Return02CBFC:
	RTS ; unused

Return02CBFD:
	RTL

WingedCageMain:
	LDA wm_SpritesLocked
	BNE +
	INC wm_SpriteMiscTbl6,X
+	JSR ADDR_02CCB9
	PHX
	JSL ADDR_00FF32
	PLX
	LDA wm_SpriteXLo,X
	CLC
	ADC wm_L1CurXChange
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,X
	LDA wm_MarioAnimation
	CMP #$01
	BCS Return02CBFD
	LDA wm_FollowCage
	BEQ +
	JSL ADDR_00FF07
+	LDY #$00
	LDA wm_L1CurYChange
	BPL +
	DEY
+	CLC
	ADC wm_SpriteYLo,X
	STA wm_SpriteYLo,X
	TYA
	ADC wm_SpriteYHi,X
	STA wm_SpriteYHi,X
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	LDA wm_SpriteYLo,X
	STA m2
	LDA wm_SpriteYHi,X
	STA m3
	REP #$20
	LDA m0
	LDY wm_MarioSpeedX
	DEY
	BPL ADDR_02CC6C
	CLC
	ADC #$0000
	CMP wm_MarioXPos
	BCC _02CC7F
	STA wm_MarioXPos
	LDY #$00
	STY wm_MarioSpeedX
	BRA _02CC7F

ADDR_02CC6C:
	CLC
	ADC #$0090
	CMP wm_MarioXPos
	BCS _02CC7F
	LDA m0
	ADC #$0091
	STA wm_MarioXPos
	LDY #$00
	STY wm_MarioSpeedX
_02CC7F:
	LDA m2
	LDY wm_MarioSpeedY
	BPL ADDR_02CC93
	CLC
	ADC #$0020
	CMP wm_MarioYPos
	BCC _02CCAE
	LDY #$00
	STY wm_MarioSpeedY
	BRA _02CCAE

ADDR_02CC93:
	CLC
	ADC #$0060
	CMP wm_MarioYPos
	BCS _02CCAE
	LDA m2
	ADC #$0061
	STA wm_MarioYPos
	LDY #$00
	STY wm_MarioSpeedY
	LDY #$01
	STY wm_IsOnSolidSpr
	STY wm_FollowCage
_02CCAE:
	SEP #$20
	RTL

CageWingTileDispX:	.DB $00,$30,$60,$90

CageWingTileDispY:	.DB $F8,$00,$F8,$00

ADDR_02CCB9:
	LDA #$03
	STA m8
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDY wm_SprOAMIndex,X
	STY m2
-	LDY m2
	LDX m8
	LDA m0
	CLC
	ADC.W CageWingTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	CLC
	ADC.W CageWingTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.2.YPos,Y
	LDX wm_SprProcessIndex
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	LSR
	EOR m8
	LSR
	LDA #$C6
	BCC +
	LDA #$81
+	STA wm_OamSlot.1.Tile,Y
	LDA #$D6
	BCC +
	LDA #$D7
+	STA wm_OamSlot.2.Tile,Y
	LDA #$70
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	LDA m2
	CLC
	ADC #$08
	STA m2
	DEC m8
	BPL -
	RTS

CODE_02CD2D:
	PHB
	PHK
	PLB
	JSR CODE_02CD59
	PLB
	RTL

DATA_02CD35:	.DB $00,$08,$10,$18,$00,$08,$10,$18

DATA_02CD3D:	.DB $00,$00,$00,$00,$08,$08,$08,$08

DATA_02CD45:	.DB $00,$01,$01,$00,$10,$11,$11,$10

DATA_02CD4D:	.DB $31,$31,$71,$71,$31,$31,$71,$71

DATA_02CD55:	.DB $0A,$04,$06,$08

CODE_02CD59:
	LDA wm_SpriteDecTbl1,X
	CMP #$5E
	BNE +
	LDA #$1B
	STA wm_BlockId
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	SEC
	SBC #$10
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_BlockXPos+1
	JSL GenerateTile
+	JSL InvisBlkMainRt
	JSR GetDrawInfo2
	PHX
	LDX wm_FlatSwitchType
	LDA.W DATA_02CD55,X
	STA m2
	LDX #$07
-	LDA m0
	CLC
	ADC.W DATA_02CD35,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02CD3D,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_02CD45,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02CD4D,X
	CPX #$04
	BCS +
	ORA m2
+	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$00
	LDA #$07
	JMP _02B7A7

Return02CDC4:
	RTS ; unused

UNK_02CDC5:	.DB $00,$07,$F9,$00,$01,$FF

PeaBouncerMain:
	JSR SubOffscreen0Bnk2
	JSR CODE_02CEE0
	LDA wm_SpritesLocked
	BNE Return02CDFE
	LDA wm_SpriteMiscTbl5,X
	BEQ +
	DEC wm_SpriteMiscTbl5,X
	BIT wm_JoyPadA
	BPL +
	STZ wm_SpriteMiscTbl5,X
	LDY wm_SpriteMiscTbl3,X
	LDA DATA_02CDFF,Y
	STA wm_MarioSpeedY
	LDA #$08
	STA wm_SoundCh3
+	LDA wm_SpriteMiscTbl4,X
	JSL ExecutePtr

PeaBouncerPtrs:
	.DW Return02CDFE
	.DW CODE_02CE0F
	.DW CODE_02CE3A

Return02CDFE:
	RTL

DATA_02CDFF:	.DB $B6,$B4,$B0,$A8,$A0,$98,$90,$88

DATA_02CE07:	.DB $00,$00,$E8,$E0,$D0,$C8,$C0,$B8

CODE_02CE0F:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02CE20
	DEC A
	BNE +
	INC wm_SpriteMiscTbl4,X
	LDA #$01
	STA wm_SpriteDir,X
+	RTL

CODE_02CE20:
	LDA wm_SpriteState,X
	BMI +
	CMP wm_SpriteMiscTbl3,X
	BCS CODE_02CE2F
+	CLC
	ADC #$01
	STA wm_SpriteState,X
	RTL

CODE_02CE2F:
	LDA wm_SpriteMiscTbl3,X
	STA wm_SpriteState,X
	LDA #$08
	STA wm_SpriteDecTbl1,X
	RTL

CODE_02CE3A:
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	AND #$03
	BNE +
	DEC wm_SpriteMiscTbl3,X
	BEQ CODE_02CE86
+	LDA wm_SpriteMiscTbl3,X
	EOR #$FF
	INC A
	STA m0
	LDA wm_SpriteDir,X
	AND #$01
	BNE CODE_02CE70
	LDA wm_SpriteState,X
	CLC
	ADC #$04
	STA wm_SpriteState,X
	BMI +
	CMP wm_SpriteMiscTbl3,X
	BCS CODE_02CE67
+	RTL

CODE_02CE67:
	LDA wm_SpriteMiscTbl3,X
	STA wm_SpriteState,X
	INC wm_SpriteDir,X
	RTL

CODE_02CE70:
	LDA wm_SpriteState,X
	SEC
	SBC #$04
	STA wm_SpriteState,X
	BPL +
	CMP m0
	BCC CODE_02CE7E
+	RTL

CODE_02CE7E:
	LDA m0
	STA wm_SpriteState,X
	INC wm_SpriteDir,X
	RTL

CODE_02CE86:
	STZ wm_SpriteState,X
	STZ wm_SpriteMiscTbl4,X
	RTL

ADDR_02CE8C: ; unreachable
	JSR CODE_02CEE0
	RTL

DATA_02CE90:
	.DB $00,$08,$10,$18,$20,$00,$08,$10
	.DB $18,$20,$00,$08,$10,$18,$20,$00
	.DB $08,$10,$18,$1F,$00,$08,$10,$17
	.DB $1E,$00,$08,$0F,$16,$1D,$00,$07
	.DB $0F,$16,$1C,$00,$07,$0E,$15,$1B

DATA_02CEB8:
	.DB $00,$00,$00,$00,$00,$00,$01,$01
	.DB $01,$02,$00,$00,$01,$02,$04,$00
	.DB $01,$02,$04,$06,$00,$01,$03,$06
	.DB $08,$00,$02,$04,$08,$0A,$00,$02
	.DB $05,$07,$0C,$00,$02,$05,$09,$0E

CODE_02CEE0:
	JSR GetDrawInfo2
	LDA #$04
	STA m2
	LDA wm_SpriteNum,X
	SEC
	SBC #$6B
	STA m5
	LDA wm_SpriteState,X
	STA m3
	BPL +
	EOR #$FF
	INC A
+	STA m4
	LDY wm_SprOAMIndex,X
_02CEFC:
	LDA m4
	ASL
	ASL
	ADC m4
	ADC m2
	TAX
	LDA m5
	LSR
	LDA.W DATA_02CE90,X
	BCC +
	EOR #$FF
	INC A
+	STA m8
	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	LDA m3
	ASL
	LDA.W DATA_02CEB8,X
	BCC +
	EOR #$FF
	INC A
+	STA m9
	CLC
	ADC m1
	STA wm_OamSlot.1.YPos,Y
	LDA #$3D
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA #$0A
	STA wm_OamSlot.1.Prop,Y
	LDX wm_SprProcessIndex
	PHY
	JSR CODE_02CF52
	PLY
	INY
	INY
	INY
	INY
	DEC m2
	BMI CODE_02CF4A
	JMP _02CEFC

CODE_02CF4A:
	LDY #$00
	LDA #$04
	JMP _02B7A7

Return02CF51:
	RTS

CODE_02CF52:
	LDA wm_MarioAnimation
	CMP #$01
	BCS Return02CF51
	LDA wm_MarioScrPosY+1
	ORA wm_MarioScrPosX+1
	ORA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE Return02CF51
	LDA wm_MarioScrPosX
	CLC
	ADC #$02
	STA m10
	LDA wm_OnYoshi
	CMP #$01
	LDA #$10
	BCC +
	LDA #$20
+	CLC
	ADC wm_MarioScrPosY
	STA m11
	LDA wm_OamSlot.1.XPos,Y
	SEC
	SBC m10
	CLC
	ADC #$08
	CMP #$14
	BCS _Return02CFFD
	LDA wm_MarioPowerUp
	CMP #$01
	LDA #$1A
	BCS +
	LDA #$1C
+	STA m15
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC m11
	CLC
	ADC #$08
	CMP m15
	BCS _Return02CFFD
	LDA wm_MarioSpeedY
	BMI _Return02CFFD
	LDA #$1F
	PHX
	LDX wm_OnYoshi
	BEQ +
	LDA #$2F
+	STA m15
	PLX
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC m15
	PHP
	CLC
	ADC wm_Bg1VOfs
	STA wm_MarioYPos
	LDA wm_Bg1VOfs+1
	ADC #$00
	PLP
	SBC #$00
	STA wm_MarioYPos+1
	STZ wm_IsFlying
	LDA #$02
	STA wm_IsOnSolidSpr
	LDA wm_SpriteMiscTbl4,X
	BEQ CODE_02CFEB
	CMP #$02
	BEQ CODE_02CFEB
	LDA wm_SpriteDecTbl1,X
	CMP #$01
	BNE +
	LDA #$08
	STA wm_SpriteMiscTbl5,X
	LDY wm_SpriteState,X
	LDA DATA_02CE07,Y
	STA wm_MarioSpeedY
+	RTS

CODE_02CFEB:
	STZ wm_MarioSpeedX
	LDY m2
	LDA PeaBouncerPhysics,Y
	STA wm_SpriteMiscTbl3,X
	LDA #$01
	STA wm_SpriteMiscTbl4,X
	STZ wm_SpriteMiscTbl6,X
_Return02CFFD:
	RTS

PeaBouncerPhysics:	.DB $01,$01,$03,$05,$07

DATA_02D003:	.DB $40,$B0

DATA_02D005:	.DB $01,$FF

DATA_02D007:	.DB $30,$C0,$A0,$C0,$A0,$70,$60,$B0

DATA_02D00F:	.DB $01,$FF,$01,$FF,$01,$FF,$01,$FF

SubOffscreen3Bnk2: ; todo: merge dupe if possible
	LDA #$06
	BRA _02D021

SubOffscreen2Bnk2:
	LDA #$04
	BRA _02D021

SubOffscreen1Bnk2:
	LDA #$02
_02D021:
	STA m3
	BRA _02D027

SubOffscreen0Bnk2:
	STZ m3
_02D027:
	JSR IsSprOffScreenBnk2
	BEQ _Return02D090
	LDA wm_IsVerticalLvl
	AND #$01
	BNE VerticalLevelBnk2
	LDA m3
	CMP #$04
	BEQ +
	LDA wm_SpriteYLo,X
	CLC
	ADC #$50
	LDA wm_SpriteYHi,X
	ADC #$00
	CMP #$02
	BPL _OffScrEraseSprBnk2
	LDA wm_Tweaker167A,X
	AND #$04
	BNE _Return02D090
+	LDA wm_FrameA
	AND #$01
	ORA m3
	STA m1
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_02D007,Y
	ROL m0
	CMP wm_SpriteXLo,X
	PHP
	LDA wm_Bg1HOfs+1
	LSR m0
	ADC DATA_02D00F,Y
	PLP
	SBC wm_SpriteXHi,X
	STA m0
	LSR m1
	BCC +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return02D090
_OffScrEraseSprBnk2:
	LDA wm_SpriteStatus,X
	CMP #$08
	BCC +
	LDY wm_SprIndexInLvl,X
	CPY #$FF
	BEQ +
	LDA #$00
	STA wm_SprLoadStatus,Y
+	STZ wm_SpriteStatus,X
_Return02D090:
	RTS

VerticalLevelBnk2:
	LDA wm_Tweaker167A,X
	AND #$04
	BNE _Return02D090
	LDA wm_FrameA
	LSR
	BCS _Return02D090
	AND #$01
	STA m1
	TAY
	LDA wm_Bg1VOfs
	CLC
	ADC DATA_02D003,Y
	ROL m0
	CMP wm_SpriteYLo,X
	PHP
	LDA.W wm_Bg1VOfs+1
	LSR m0
	ADC DATA_02D005,Y
	PLP
	SBC wm_SpriteYHi,X
	STA m0
	LDY m1
	BEQ +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return02D090
	BMI _OffScrEraseSprBnk2 ; [BRA FIX]

IsSprOffScreenBnk2:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	RTS

DATA_02D0D0:	.DB $14,$FC

DATA_02D0D2:	.DB $00,$FF

CODE_02D0D4:
	LDA wm_SpriteDecTbl4,X
	BNE +
	LDA wm_SpriteMiscTbl8,X
	BPL +
	PHB
	PHK
	PLB
	JSR CODE_02D0E6
	PLB
+	RTL

CODE_02D0E6:
	STZ m15
	BRA CODE_02D149

ADDR_02D0EA: ; unreachable yoshi?
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	AND #$F0
	STA m0
	LDA wm_SpriteYHi,X
	ADC #$00
	CMP wm_ScreensInLvl
	BCS Return02D148
	STA m3
	AND #$10
	STA m8
	LDY wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_02D0D0,Y
	STA m1
	LDA wm_SpriteXHi,X
	ADC DATA_02D0D2,Y
	CMP #$02
	BCS Return02D148
	STA m2
	LDA m1
	LSR
	LSR
	LSR
	LSR
	ORA m0
	STA m0
	LDX m3
	LDA.L DATA_00BA80,X
	LDY m15
	BEQ +
	LDA.L DATA_00BA8E,X
+	CLC
	ADC m0
	STA m5
	LDA.L DATA_00BABC,X
	LDY m15
	BEQ +
	LDA.L DATA_00BACA,X
+	ADC m2
	STA m6
	BRA _02D1AD

Return02D148:
	RTS

CODE_02D149:
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	STA wm_YoshiBerryWalkY
	AND #$F0
	STA m0
	LDA wm_SpriteYHi,X
	ADC #$00
	CMP #$02
	BCS Return02D148
	STA m2
	STA wm_YoshiBerryWalkY+1
	LDY wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_02D0D0,Y
	STA m1
	STA wm_YoshiBerryWalkX
	LDA wm_SpriteXHi,X
	ADC DATA_02D0D2,Y
	CMP wm_ScreensInLvl
	BCS Return02D148
	STA wm_YoshiBerryWalkX+1
	STA m3
	LDA m1
	LSR
	LSR
	LSR
	LSR
	ORA m0
	STA m0
	LDX m3
	LDA.L DATA_00BA60,X
	LDY m15
	BEQ +
	LDA.L DATA_00BA70,X
+	CLC
	ADC m0
	STA m5
	LDA.L DATA_00BA9C,X
	LDY m15
	BEQ +
	LDA.L DATA_00BAAC,X
+	ADC m2
	STA m6
_02D1AD:
	LDA #$7E
	STA m7
	LDX wm_SprProcessIndex
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	BNE +
	LDA wm_Map16NumLo
	CMP #$45
	BCC +
	CMP #$48
	BCS +
	SEC
	SBC #$44
	STA wm_BerryEatenType
	STZ wm_YoshiTongueTimer
	LDY wm_IsYoshiDucking
	LDA DATA_02D1F1,Y
	STA wm_SpriteGfxTbl,X
	LDA #$22
	STA wm_SpriteDecTbl4,X
	LDA wm_MarioYPos
	CLC
	ADC #$08
	AND #$F0
	STA wm_MarioYPos
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_MarioYPos+1
+	RTS

DATA_02D1F1:	.DB $00,$04

SetTreeTile:
	LDA wm_YoshiBerryWalkX
	STA wm_BlockYPos
	LDA wm_YoshiBerryWalkX+1
	STA wm_BlockYPos+1
	LDA wm_YoshiBerryWalkY
	STA wm_BlockXPos
	LDA wm_YoshiBerryWalkY+1
	STA wm_BlockXPos+1
	LDA #$04
	STA wm_BlockId
	JSL GenerateTile
	RTL

DATA_02D210:	.DB $01,$FF

DATA_02D211:	.DB $10,$F0

ControlSprCarried:
	LDA wm_JoyPadA
	AND #$03
	BNE CscGoLeftOrRight
_CscSlowSpeedX:
	LDA wm_SpriteSpeedX,X
	BEQ ++
	BPL +
	INC wm_SpriteSpeedX,X
	INC wm_SpriteSpeedX,X
+	DEC wm_SpriteSpeedX,X
++	BRA _CscDecideY

CscGoLeftOrRight:
	TAY
	CPY #$01
	BNE CscGoRight
	LDA wm_SpriteSpeedX,X
	CMP DATA_02D211-1,Y
	BEQ _CscDecideY
	BPL _CscSlowSpeedX
	BRA _CscUnderLimitX

CscGoRight:
	LDA wm_SpriteSpeedX,X
	CMP DATA_02D211-1,Y
	BEQ _CscDecideY
	BMI _CscSlowSpeedX
_CscUnderLimitX:
	CLC
	ADC DATA_02D210-1,Y
	STA wm_SpriteSpeedX,X
_CscDecideY:
	LDY #$00
	LDA wm_SpriteNum,X
	CMP #$87
	BNE CscNotLakituCloud
	LDA wm_JoyPadA
	AND #$0C
	BEQ _CscHandleY
	LDY #$10
	AND #$08
	BEQ _CscHandleY
	LDY #$F0
	BRA _CscHandleY

CscNotLakituCloud:
	LDY #$F8
	LDA wm_JoyPadA
	AND #$0C
	BEQ _CscHandleY
	LDY #$F0
	AND #$08
	BNE _CscHandleY
	LDY #$08
_CscHandleY:
	STY m0
	LDA wm_SpriteSpeedY,X
	CMP m0
	BEQ ++
	BPL +
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
+	DEC wm_SpriteSpeedY,X
++	LDA wm_SpriteSpeedX,X
	STA wm_MarioSpeedX
	LDA wm_SpriteSpeedY,X
	STA wm_MarioSpeedY
	RTL

UpdateXPosNoGrvty2:
	TXA
	CLC
	ADC #$0C
	TAX
	JSR UpdateYPosNoGrvty2
	LDX wm_SprProcessIndex
	RTS

UpdateYPosNoGrvty2:
	LDA wm_SpriteSpeedY,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpriteYAcc,X
	STA wm_SpriteYAcc,X
	PHP
	PHP
	LDY #$00
	LDA wm_SpriteSpeedY,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	BCC +
	ORA #$F0
	DEY
+	PLP
	PHA
	ADC wm_SpriteYLo,X
	STA wm_SpriteYLo,X
	TYA
	ADC wm_SpriteYHi,X
	STA wm_SpriteYHi,X
	PLA
	PLP
	ADC #$00
	STA wm_SprPixelMove
	RTS

ADDR_02D2C7: ; unreachable
	STA m0
	LDA wm_MarioXPos
	PHA
	LDA wm_MarioXPos+1
	PHA
	LDA wm_MarioYPos
	PHA
	LDA wm_MarioYPos+1
	PHA
	LDA.W wm_SpriteXLo,Y
	STA wm_MarioXPos
	LDA wm_SpriteXHi,Y
	STA wm_MarioXPos+1
	LDA.W wm_SpriteYLo,Y
	STA wm_MarioYPos
	LDA wm_SpriteYHi,Y
	STA wm_MarioYPos+1
	LDA m0
	JSR CODE_02D2FB
	PLA
	STA wm_MarioYPos+1
	PLA
	STA wm_MarioYPos
	PLA
	STA wm_MarioXPos+1
	PLA
	STA wm_MarioXPos
	RTS

CODE_02D2FB:
	STA m1
	PHX
	PHY
	JSR CODE_02D50C
	STY m2
	LDA m14
	BPL +
	EOR #$FF
	CLC
	ADC #$01
+	STA m12
	JSR CODE_02D4FA
	STY m3
	LDA m15
	BPL +
	EOR #$FF
	CLC
	ADC #$01
+	STA m13
	LDY #$00
	LDA m13
	CMP m12
	BCS +
	INY
	PHA
	LDA m12
	STA m13
	PLA
	STA m12
+	LDA #$00
	STA m11
	STA m0
	LDX m1
-	LDA m11
	CLC
	ADC m12
	CMP m13
	BCC +
	SBC m13
	INC m0
+	STA m11
	DEX
	BNE -
	TYA
	BEQ +
	LDA m0
	PHA
	LDA m1
	STA m0
	PLA
	STA m1
+	LDA m0
	LDY m2
	BEQ +
	EOR #$FF
	CLC
	ADC #$01
	STA m0
+	LDA m1
	LDY m3
	BEQ +
	EOR #$FF
	CLC
	ADC #$01
	STA m1
+	PLY
	PLX
	RTS

DATA_02D374:	.DB $0C,$1C

DATA_02D376:	.DB $01,$02

GetDrawInfo2:
	STZ wm_OffscreenVert,X
	STZ wm_OffscreenHorz,X
	LDA wm_SpriteXLo,X
	CMP wm_Bg1HOfs
	LDA wm_SpriteXHi,X
	SBC wm_Bg1HOfs+1
	BEQ +
	INC wm_OffscreenHorz,X
+	LDA wm_SpriteXHi,X
	XBA
	LDA wm_SpriteXLo,X
	REP #$20
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$0040
	CMP #$0180
	SEP #$20
	ROL
	AND #$01
	STA wm_SpriteOffTbl,X
	BNE CODE_02D3E7
	LDY #$00
	LDA wm_Tweaker1662,X
	AND #$20
	BEQ _f
	INY
__	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_02D374,Y
	PHP
	CMP wm_Bg1VOfs
	ROL m0
	PLP
	LDA wm_SpriteYHi,X
	ADC #$00
	LSR m0
	SBC wm_Bg1VOfs+1
	BEQ +
	LDA wm_OffscreenVert,X
	ORA DATA_02D376,Y
	STA wm_OffscreenVert,X
+	DEY
	BPL _b
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	RTS

CODE_02D3E7:
	PLA
	PLA
	RTS

Layer3SmashMain:
	JSL CODE_00FF61
	LDA wm_SpritesLocked
	BNE _Return02D444
	JSR CODE_02D49C
	LDY #$00
	LDA wm_L1CurXChange
	BPL +
	DEY
+	CLC
	ADC wm_SpriteXLo,X
	STA wm_SpriteXLo,X
	TYA
	ADC wm_SpriteXHi,X
	STA wm_SpriteXHi,X
	LDA wm_SpriteState,X
	JSL ExecutePtr

Layer3SmashPtrs:
	.DW CODE_02D419
	.DW CODE_02D445
	.DW CODE_02D455
	.DW CODE_02D481
	.DW CODE_02D489

CODE_02D419:
	LDA wm_AppearSprTimer
	BEQ CODE_02D422
	JSR _OffScrEraseSprBnk2
	RTS

CODE_02D422:
	LDA wm_SpriteDecTbl1,X
	BNE _Return02D444
	INC wm_SpriteState,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
	JSL GetRand
	AND #$3F
	ORA #$80
	STA wm_SpriteXLo,X
	LDA #$FF
	STA wm_SpriteXHi,X
	STZ wm_SpriteYLo,X
	STZ wm_SpriteYHi,X
	STZ wm_SpriteSpeedY,X
_Return02D444:
	RTL

CODE_02D445:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02D452
	LDA #$04
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	RTL

CODE_02D452:
	INC wm_SpriteState,X
	RTL

CODE_02D455:
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteSpeedY,X
	BMI +
	CMP #$40
	BCS ++
+	CLC
	ADC #$07
	STA wm_SpriteSpeedY,X
++	LDA wm_SpriteYLo,X
	CMP #$A0
	BCC +
	AND #$F0
	STA wm_SpriteYLo,X
	LDA #$50
	STA wm_ShakeGrndTimer
	LDA #$09
	STA wm_SoundCh3
	LDA #$30
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
+	RTL

CODE_02D481:
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
+	RTL

CODE_02D489:
	LDA #$E0
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteYLo,X
	BNE +
	STZ wm_SpriteState,X
	LDA #$A0
	STA wm_SpriteDecTbl1,X
+	RTL

CODE_02D49C:
	LDA #$00
	LDY wm_MarioPowerUp
	BEQ +
	LDY wm_IsDucking
	BNE +
	LDA #$10
+	CLC
	ADC wm_SpriteYLo,X
	CMP wm_MarioScrPosY
	BCC _02D4EF
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	REP #$20
	LDA wm_MarioScrPosX
	CLC
	ADC m0
	SEC
	SBC #$0030
	CMP #$0090
	BCS _02D4EF
	SEC
	SBC #$0008
	CMP #$0080
	SEP #$20
	BCS CODE_02D4E5
	LDA wm_IsFlying
	BNE CODE_02D4DC
	JSL HurtMario
	RTS

CODE_02D4DC:
	STZ wm_MarioSpeedY
	LDA wm_SpriteSpeedY,X
	BMI +
	STA wm_MarioSpeedY
+	RTS

CODE_02D4E5:
	PHP
	LDA #$08
	PLP
	BPL +
	LDA #$F8
+	STA wm_MarioSpeedX
_02D4EF:
	SEP #$20
	RTS

UNK_02D4F2:	.DB $80,$40,$20,$10,$08,$04,$02,$01 ; unused bits

CODE_02D4FA:
	LDY #$00
	LDA wm_MarioXPos
	SEC
	SBC wm_SpriteXLo,X
	STA m15
	LDA wm_MarioXPos+1
	SBC wm_SpriteXHi,X
	BPL +
	INY
+	RTS

CODE_02D50C:
	LDY #$00
	LDA wm_MarioYPos
	SEC
	SBC wm_SpriteYLo,X
	STA m14
	LDA wm_MarioYPos+1
	SBC wm_SpriteYHi,X
	BPL +
	INY
+	RTS

ADDR_00FA10: ;unreachable function
	LDX #$0B
-	STZ wm_SpriteStatus,X
	DEX
	BPL -
	RTL

CODE_00FA19:
	LDY #<DATA_00E632
	STY m5
	LDY #>DATA_00E632
	STY m6
	LDY #:DATA_00E632
	STY m7
	SEC
	SBC #$6E
	TAY
	LDA [wm_SlopeSteepness],Y
	STA m8
	ASL
	ASL
	ASL
	ASL
	STA m1
	BCC +
	INC m6
+	LDA m12
	AND #$0F
	STA m0
	LDA m10
	AND #$0F
	ORA m1
	TAY
	RTL

FlatPalaceSwitch:
	LDA #$20
	STA wm_ShakeGrndTimer
	LDY #$02
	LDA #$60
	STA.W wm_SpriteNum,Y
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA wm_BlockYPos
	AND #$F0
	STA.W wm_SpriteXLo,Y
	LDA wm_BlockYPos+1
	STA wm_SpriteXHi,Y
	LDA wm_BlockXPos
	AND #$F0
	CLC
	ADC #$10
	STA.W wm_SpriteYLo,Y
	LDA wm_BlockXPos+1
	ADC #$00
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	LDA #$5F
	STA wm_SpriteDecTbl1,Y
	RTS

TriggerGoalTape:
	STZ wm_PBalloonFrame
	STZ wm_BalloonTimer
	STZ wm_TimeTillRespawn
	STZ wm_GeneratorNum
	STZ wm_SilverCoins
	LDY #$0B
_LvlEndSprLoopStrt:
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC _LvlEndNextSprite
	CMP #$0B
	BNE CODE_00FAA3
	PHX
	JSR LvlEndPowerUp
	PLX
	BRA _LvlEndNextSprite

CODE_00FAA3:
	LDA.W wm_SpriteNum,Y
	CMP #$7B
	BEQ +
	LDA wm_OffscreenHorz,Y
	ORA wm_OffscreenVert,Y
	BNE CODE_00FAC5
+	LDA wm_Tweaker1686,Y
	AND #$20
	BNE CODE_00FAC5
	LDA #$10
	STA wm_SpriteDecTbl1,Y
	LDA #$06
	STA wm_SpriteStatus,Y
	BRA _LvlEndNextSprite

CODE_00FAC5:
	LDA wm_Tweaker190F,Y
	AND #$02
	BNE _LvlEndNextSprite
	LDA #$00
	STA wm_SpriteStatus,Y
_LvlEndNextSprite:
	DEY
	BPL _LvlEndSprLoopStrt
	LDY #$07
	LDA #$00
-	STA wm_ExSpriteNum,Y
	DEY
	BPL -
	RTL

DATA_00FADF:
	.DB $74,$74,$77,$75,$76,$E0,$F0,$74
	.DB $74,$77,$75,$76,$E0,$F1,$F0,$F0
	.DB $F0,$F0,$F1,$E0,$F2,$E0,$E0,$E0
	.DB $E0,$F1,$E0,$E4

DATA_00FAFB:	.DB $FF,$74,$75,$76,$77

LvlEndPowerUp:
	LDX wm_MarioPowerUp
	LDA wm_StarPowerTimer ; unused goal star
	BEQ + ;
	LDX #$04 ;
+	LDA wm_OnYoshi
	BEQ +
	LDX #$05
+	LDA.W wm_SpriteNum,Y
	CMP #$2F
	BEQ ++
	CMP #$3E
	BEQ ++
	CMP #$80
	BEQ +
	CMP #$2D
	BNE +++
	TXA
	CLC
	ADC #$07
	TAX
+	TXA
	CLC
	ADC #$07
	TAX
++	TXA
	CLC
	ADC #$07
	TAX
+++	LDA.L DATA_00FADF,X
	LDX wm_ItemInBox
	CMP.L DATA_00FAFB,X
	BNE +
	LDA #$78
+	STZ m15
	CMP #$E0
	BCC +
	PHA
	AND #$0F
	STA m15
	PLA
	CMP #$F0
	LDA #$78
	BCS +
	LDA #$78
+	STA.W wm_SpriteNum,Y
	CMP #$76 ; unused star prize
	BNE + ;
	INC wm_LvEndStarPrize ;
+	TYX
	JSL InitSpriteTables
	LDA m15
	STA wm_SpriteMiscTbl7,Y
	LDA #$0C
	STA wm_SpriteStatus,Y
	LDA #$D0
	STA.W wm_SpriteSpeedY,Y
	LDA #$05
	STA.W wm_SpriteSpeedX,Y
	LDA #$20
	STA wm_SpriteDecTbl2,Y
	LDA #$0C
	STA wm_SoundCh1
	LDX #$03
-	LDA wm_SmokeSprite,X
	BEQ CODE_00FB8D
	DEX
	BPL -
	RTS

CODE_00FB8D:
	LDA #$01
	STA wm_SmokeSprite,X
	LDA.W wm_SpriteYLo,Y
	STA wm_SmokeYPos,X
	LDA.W wm_SpriteXLo,Y
	STA wm_SmokeXPos,X
	LDA #$1B
	STA wm_SmokeTimer,X
	RTS

LvlEndSmokeTiles:	.DB $66,$64,$62,$60,$E8,$EA,$EC,$EA

LvlEndSprCoins:
	PHB
	PHK
	PLB
	JSR LvlEndSprCoinsRt
	PLB
	RTL

LvlEndSprCoinsRt:
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
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_00FBF0
	CMP #$01
	BNE +
	LDA #$D0
	STA wm_SpriteSpeedY,X
+	PHX
	LDA #$04
	STA wm_SpritePal,X
	JSL GenericSprGfxRt2
	LDA wm_SpriteDecTbl1,X
	LSR
	LSR
	LDY wm_SprOAMIndex,X
	TAX
	LDA.W LvlEndSmokeTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	RTS

CODE_00FBF0:
	INC wm_SpriteMiscTbl6,X
	JSL UpdateYPosNoGrvty
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
	LDA wm_SpriteSpeedY,X
	CMP #$20
	BMI ++
	JSL CODE_05B34A
	LDA wm_SilverCoins
	CMP #$0D
	BCC +
	LDA #$0D
+	JSL GivePoints
	LDA wm_SilverCoins
	CLC
	ADC #$02
	STA wm_SilverCoins
	STZ wm_SpriteStatus,X
++	JSL CoinSprGfx
	RTS

ADDR_00FC23: ;unreachable function
	LDY #$0B
_00FC25:
	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE ADDR_00FC73
	LDA.W wm_SpriteNum,Y
	CMP #$35
	BNE ADDR_00FC73
	LDA #$01
	STA wm_OWHasYoshi
	STZ wm_YoshiHasWings
	LDA wm_SpritePal,Y
	AND #$F1
	ORA #$0A
	STA wm_SpritePal,Y
	LDA wm_OnYoshi
	BNE +
	LDA wm_Bg1HOfs
	SEC
	SBC #$10
	STA.W wm_SpriteXLo,Y
	LDA wm_Bg1HOfs+1
	SBC #$00
	STA wm_SpriteXHi,Y
	LDA wm_MarioYPos
	STA.W wm_SpriteYLo,Y
	LDA wm_MarioYPos+1
	STA wm_SpriteYHi,Y
	LDA #$03
	STA.W wm_SpriteState,Y
	LDA #$00
	STA wm_SpriteDir,Y
	LDA #$10
	STA.W wm_SpriteSpeedX,Y
+	RTL

ADDR_00FC73: ;unreachable function
	DEY
	BPL _00FC25
	STZ wm_OWHasYoshi
	RTL

CODE_00FC7A:
	LDA #$02
	STA wm_SoundCh2
	LDX #$00
	LDA wm_NoBonusGameFlag
	BNE +
	LDX #$05
	LDA wm_SpriteMemory
	CMP #$0A
	BEQ +
	JSL FindFreeSprSlot
	TYX
	BPL +
	LDX #$03
+	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$35
	STA wm_SpriteNum,X
	LDA wm_MarioXPos
	STA wm_SpriteXLo,X
	LDA wm_MarioXPos+1
	STA wm_SpriteXHi,X
	LDA wm_MarioYPos
	SEC
	SBC #$10
	STA wm_MarioYPos
	STA wm_SpriteYLo,X
	LDA wm_MarioYPos+1
	SBC #$00
	STA wm_MarioYPos+1
	STA wm_SpriteYHi,X
	JSL InitSpriteTables
	LDA #$04
	STA wm_DisSprCapeContact,X
	LDA wm_YoshiColor
	STA wm_SpritePal,X
	LDA wm_YoshiWingsAboveGrnd
	BEQ +
	LDA #$06
	STA wm_SpritePal,X
+	INC wm_OnYoshi
	INC wm_SpriteState,X
	LDA wm_MarioDirection
	EOR #$01
	STA wm_SpriteDir,X
	DEC wm_SpriteMiscTbl8,X
	INX
	STX wm_YoshiSlot
	STX wm_LooseYoshiFlag
	RTL

CODE_00FCEC: ; dupe ADDR_00FA10 RTL version
	LDX #$0B
-	STZ wm_SpriteStatus,X
	DEX
	BPL -
	RTS

CODE_00FCF5:
	LDA #$A0
	STA wm_SpriteXLo,X
	LDA #$00
	STA wm_SpriteXHi,X
	LDA #$00
	STA wm_SpriteYLo,X
	LDA #$00
	STA wm_SpriteYHi,X
	RTL

CODE_00FD08:
	LDY #$3F
	LDA wm_JoyPadA
	AND #$83
	BNE +
	LDY #$7F
+	TYA
	AND wm_FrameB
	ORA wm_SpritesLocked
	BNE +
	LDX #$07
-	LDA wm_ExSpriteNum,X
	BEQ CODE_00FD26
	DEX
	BPL -
+	RTS

DATA_00FD24:	.DB 2,10

CODE_00FD26:
	LDA #$12
	STA wm_ExSpriteNum,X
	LDY wm_MarioDirection
	LDA wm_MarioXPos
	CLC
	ADC DATA_00FD24,Y
	STA wm_ExSpriteXLo,X
	LDA wm_MarioXPos+1
	ADC #$00
	STA wm_ExSpriteXHi,X
	LDA wm_MarioPowerUp
	BEQ +
	LDA #$04
	LDY wm_IsDucking
	BEQ ++
+	LDA #$0C
++	CLC
	ADC wm_MarioYPos
	STA wm_ExSpriteYLo,X
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_ExSpriteYHi,X
	STZ wm_ExSpriteTbl2,X
	RTS

CODE_00FD5A:
	LDA wm_MarioScrPosX+1
	ORA wm_MarioScrPosY+1
	BNE +
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_00FD6B
	DEY
	BPL -
+	RTS

CODE_00FD6B:
	LDA #$05
	STA wm_SmokeSprite,Y
	LDA wm_BlockYPos
	AND #$F0
	STA wm_SmokeXPos,Y
	LDA wm_BlockXPos
	AND #$F0
	STA wm_SmokeYPos,Y
	LDA wm_LayerInProcess
	BEQ +
	LDA wm_BlockYPos
	SEC
	SBC wm_26
	AND #$F0
	STA wm_SmokeXPos,Y
	LDA wm_BlockXPos
	SEC
	SBC wm_28
	AND #$F0
	STA wm_SmokeYPos,Y
+	LDA #$10
	STA wm_SmokeTimer,Y
	RTS

DATA_00FD9D:	.DB 8,-4,16,4

DATA_00FDA1:	.DB 0,-1,0,0

CODE_00FDA5:
	LDA wm_IsFlying
	BEQ +
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ ++
	DEY
	BPL -
+	INY
++	PHX
	LDX #$00
	LDA wm_MarioPowerUp
	BEQ +
	INX
+	LDA wm_OnYoshi
	BEQ +
	INX
	INX
+	LDA wm_MarioYPos
	CLC
	ADC.W DATA_00FD9D,X
	PHP
	AND #$F0
	CLC
	ADC #$03
	STA wm_MExSprYLo,Y
	LDA wm_MarioYPos+1
	ADC #$00
	PLP
	ADC.W DATA_00FDA1,X
	STA wm_MExSprYHi,Y
	PLX
	LDA wm_MarioXPos
	STA wm_MExSprXLo,Y
	LDA wm_MarioXPos+1
	STA wm_MExSprXHi,Y
	LDA #$07
	STA wm_MExSprNum,Y
	LDA #$00
	STA wm_MExSprTimer,Y
	LDA wm_MarioSpeedY
	BMI ++
	STZ wm_MarioSpeedY
	LDY wm_IsFlying
	BEQ +
	STZ wm_MarioSpeedX
+	LDY #$03
	LDA wm_MarioPowerUp
	BNE _f
	DEY
__	LDA wm_ExSpriteNum,Y
	BEQ CODE_00FE16
_00FE0A:
	DEY
	BPL _b
++	RTS

DATA_00FE0E:	.DB 16,22,19,28

DATA_00FE12:	.DB 0,4,10,7

CODE_00FE16:
	LDA #$12
	STA wm_ExSpriteNum,Y
	TYA
	ASL
	ASL
	ASL
	ADC #$F7
	STA wm_ExSpriteTbl1,Y
	LDA wm_MarioYPos
	ADC DATA_00FE0E,Y
	STA wm_ExSpriteYLo,Y
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_ExSpriteYHi,Y
	LDA wm_MarioXPos
	ADC DATA_00FE12,Y
	STA wm_ExSpriteXLo,Y
	LDA wm_MarioXPos+1
	ADC #$00
	STA wm_ExSpriteXHi,Y
	LDA #$00
	STA wm_ExSpriteTbl2,Y
	JMP _00FE0A

CODE_00FE4A:
	LDA wm_FrameA
	AND #$03
	ORA wm_IsFlying
	ORA wm_MarioScrPosX+1
	ORA wm_MarioScrPosY+1
	ORA wm_SpritesLocked
	BNE ++
	LDA wm_JoyPadA
	AND #$04
	BEQ +
	LDA wm_MarioSpeedX
	CLC
	ADC #$08
	CMP #$10
	BCC ++
+	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_00FE72
	DEY
	BNE -
++	RTS

CODE_00FE72:
	LDA #$03
	STA wm_SmokeSprite,Y
	LDA wm_MarioXPos
	ADC #$04
	STA wm_SmokeXPos,Y
	LDA wm_MarioYPos
	ADC #$1A
	PHX
	LDX wm_OnYoshi
	BEQ +
	ADC #$10
+	STA wm_SmokeYPos,Y
	PLX
	LDA #$13
	STA wm_SmokeTimer,Y
	RTS

DATA_00FE94:	.DB -3,3

DATA_00FE96:	.DB 0,8,-8,16,-8,16

DATA_00FE9C:	.DB 0,0,-1,0,-1,0

DATA_00FEA2:	.DB 8,8,12,12,20,20

ShootFireball:
	LDX #$09
-	LDA wm_ExSpriteNum,X
	BEQ CODE_00FEB5
	DEX
	CPX #$07
	BNE -
	RTS

CODE_00FEB5:
	LDA #$06
	STA wm_SoundCh3
	LDA #$0A
	STA wm_FireballImgTimer
	LDA #$05
	STA wm_ExSpriteNum,X
	LDA #$30
	STA wm_ExSprSpeedY,X
	LDY wm_MarioDirection
	LDA DATA_00FE94,Y
	STA wm_ExSprSpeedX,X
	LDA wm_OnYoshi
	BEQ +
	INY
	INY
	LDA wm_IsYoshiDucking
	BEQ +
	INY
	INY
+	LDA wm_MarioXPos
	CLC
	ADC DATA_00FE96,Y
	STA wm_ExSpriteXLo,X
	LDA wm_MarioXPos+1
	ADC DATA_00FE9C,Y
	STA wm_ExSpriteXHi,X
	LDA wm_MarioYPos
	CLC
	ADC DATA_00FEA2,Y
	STA wm_ExSpriteYLo,X
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_ExSpriteYHi,X
	LDA wm_IsBehindScenery
	STA wm_ExSprBehindTbl,X
	RTS

ADDR_00FF07:
	REP #$20
	LDA wm_L1CurYChange
	AND #$FF00
	BPL +
	ORA #$00FF
+	XBA
	CLC
	ADC wm_MarioXPos
	STA wm_MarioXPos
	LDA wm_17BB
	AND #$FF00
	BPL +
	ORA #$00FF
+	XBA
	EOR #$FFFF
	INC A
	CLC
	ADC wm_MarioYPos
	STA wm_MarioYPos
	SEP #$20
	RTL

ADDR_00FF32:
	LDA wm_SpriteXHi,X
	XBA
	LDA wm_SpriteXLo,X
	REP #$20
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA #$0030
	SEC
	SBC m0
	STA wm_Bg3HOfs
	SEP #$20
	LDA wm_SpriteYHi,X
	XBA
	LDA wm_SpriteYLo,X
	REP #$20
	SEC
	SBC wm_Bg1VOfs
	STA m0
	LDA #$0100
	SEC
	SBC m0
	STA wm_Bg3VOfs
	SEP #$20
	RTL

CODE_00FF61:
	LDA wm_SpriteXHi,X
	XBA
	LDA wm_SpriteXLo,X
	REP #$20
	CMP #$FF00
	BMI +
	CMP #$0100
	BMI ++
+	LDA #$0100
++	STA wm_Bg3HOfs
	SEP #$20
	LDA wm_SpriteYHi,X
	XBA
	LDA wm_SpriteYLo,X
	REP #$20
	STA m0
	LDA #$00A0
	SEC
	SBC m0
	CLC
	ADC wm_Layer1DispYLo
	STA wm_Bg3VOfs
	SEP #$20
	RTL

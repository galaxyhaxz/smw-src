UNK_028000:	.DB $80,$40,$20,$10,$08,$04,$02,$01 ; unused bits

DropReservedItem:
	PHX
	LDA wm_ItemInBox
	BEQ +++
	STZ wm_ItemInBox
	PHA
	LDA #$0C
	STA wm_SoundCh3
	LDX #$0B
-	LDA wm_SpriteStatus,X
	BEQ ++
	DEX
	BPL -
	DEC wm_FullSprDelete
	BPL +
	LDA #$01
	STA wm_FullSprDelete
+	LDA wm_FullSprDelete
	CLC
	ADC #$0A
	TAX
	LDA wm_SpriteNum,X
	CMP #$7D
	BNE ++
	LDA wm_SpriteStatus,X
	CMP #$0B
	BNE ++
	STZ wm_PBalloonFrame
++	LDA #$08
	STA wm_SpriteStatus,X
	PLA
	CLC
	ADC #$73
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA #$78
	CLC
	ADC wm_Bg1HOfs
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_SpriteXHi,X
	LDA #$20
	CLC
	ADC wm_Bg1VOfs
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	INC wm_SpriteMiscTbl5,X
+++	PLX
	RTL

BombExplosionX:
	.DB $00,$08,$06,$FA,$F8,$06,$08,$00
	.DB $F8,$FA

BombExplosionY:
	.DB $F8,$FE,$06,$06,$FE,$FA,$02,$08
	.DB $02,$FA

ExplodeBombRt:
	JSR ExplodeBombSubRt
	RTL

ExplodeBombSubRt:
	STZ wm_Tweaker1656,X
	LDA #$11
	STA wm_Tweaker1662,X
	JSR GetDrawInfo2
	LDA wm_SpritesLocked
	BNE +
	INC wm_SpriteMiscTbl6,X
+	LDA wm_SpriteDecTbl1,X
	BNE ExplodeBombGfx
	STZ wm_SpriteStatus,X
	RTS

ExplodeBombGfx:
	LDA wm_SpriteDecTbl1,X
	LSR
	AND #$03
	CMP #$03
	BNE +
	JSR ExplodeSprites
	LDA wm_SpriteDecTbl1,X
	SEC
	SBC #$10
	CMP #$20
	BCS +
	JSL MarioSprInteract
+	LDY #$04
	STY m15
-	LDA wm_SpriteDecTbl1,X
	LSR
	PHA
	AND #$03
	STA m2
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$04
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC #$04
	STA m1
	LDY m15
	PLA
	AND #$04
	BEQ _f
	TYA
	CLC
	ADC #$05
	TAY
__	LDA m0
	CLC
	ADC BombExplosionX,Y
	STA m0
	LDA m1
	CLC
	ADC BombExplosionY,Y
	STA m1
	DEC m2
	BPL _b
	LDA m15
	ASL
	ASL
	ADC wm_SprOAMIndex,X
	TAY
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA #$BC
	STA wm_OamSlot.1.Tile,Y
	LDA wm_FrameA
	LSR
	LSR
	AND #$03
	SEC
	ROL
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	DEC m15
	BPL -
	LDY #$00
	LDA #$04
	JMP _02B7A7

ExplodeSprites:
	LDY #$09
-	CPY wm_SprProcessIndex
	BEQ ++
	PHY
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC +
	JSR ExplodeKillSpr
+	PLY
++	DEY
	BPL -
	RTS

ExplodeKillSpr:
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC +
	LDA wm_Tweaker167A,Y
	AND #$02
	BNE +
	LDA #$02
	STA wm_SpriteStatus,Y
	LDA #$C0
	STA.W wm_SpriteSpeedY,Y
	LDA #$00
	STA.W wm_SpriteSpeedX,Y
+	RTS

DATA_028178:
	.DB $F8,$38,$78,$B8,$00,$10,$20,$D0
	.DB $E0,$10,$40,$80,$C0,$10,$10,$20
	.DB $B0,$20,$50,$60,$C0,$F0,$80,$B0
	.DB $20,$60,$A0,$E0,$70,$F0,$70,$B0
	.DB $F0,$10,$20,$50,$60,$90,$A0,$D0
	.DB $E0,$10,$20,$50,$60,$90,$A0,$D0
	.DB $E0,$10,$20,$50,$60,$90,$A0,$D0
	.DB $E0,$50,$60,$C0,$D0,$30,$40,$70
	.DB $80,$B0,$C0,$30,$40,$70,$80,$B0
	.DB $C0,$40,$50,$80,$90,$C8,$D8,$30
	.DB $40,$A0,$B0,$58,$68,$B0,$C0

DATA_0281CF:
	.DB $70,$70,$70,$70,$20,$20,$20,$20
	.DB $20,$30,$30,$30,$30,$70,$80,$80
	.DB $80,$90,$90,$90,$A0,$50,$60,$60
	.DB $70,$70,$70,$70,$60,$60,$70,$70
	.DB $70,$40,$40,$40,$40,$40,$40,$40
	.DB $40,$50,$50,$50,$50,$50,$50,$50
	.DB $50,$60,$60,$60,$60,$60,$60,$60
	.DB $60,$30,$30,$30,$30,$48,$48,$48
	.DB $48,$48,$48,$58,$58,$58,$58,$58
	.DB $58,$70,$70,$78,$78,$70,$70,$80
	.DB $80,$88,$88,$A0,$A0,$A0,$A0

DATA_028226:
	.DB $E8,$E8,$E8,$E8,$E4,$E4,$E4,$E4
	.DB $E4,$E4,$E4,$E4,$E4,$E4,$E4,$E4
	.DB $E4,$E4,$E4,$E4,$E4,$E4,$E4,$E4
	.DB $E4,$E4,$E4,$E4,$EE,$EE,$EE,$EE
	.DB $EE,$C0,$C2,$C0,$C2,$C0,$C2,$C0
	.DB $C2,$E0,$E2,$E0,$E2,$E0,$E2,$E0
	.DB $E2,$C4,$A4,$C4,$A4,$C4,$A4,$C4
	.DB $A4,$CC,$CE,$CC,$CE,$C8,$CA,$C8
	.DB $CA,$C8,$CA,$CA,$C8,$CA,$C8,$CA
	.DB $C8,$CC,$CE,$CC,$CE,$CC,$CE,$CC
	.DB $CE,$CC,$CE,$CC,$CE,$CC,$CE

CODE_02827D:
	LDA wm_Bg1HOfs
	STA wm_BossBgXPos
	EOR #$FF
	INC A
	STA m5
	LDA wm_Bg1HOfs+1
	LSR
	ROR wm_BossBgXPos
	PHA
	LDA wm_BossBgXPos
	EOR #$FF
	INC A
	STA m6
	PLA
	LSR
	ROR wm_BossBgXPos
	LDA wm_BossBgXPos
	EOR #$FF
	INC A
	STA wm_BossBgXPos
	REP #$10
	LDY #$0164
	LDA #$66
	STY m3
	LDA #$F0
-	STA wm_ExOamSlot.4.YPos,Y
	INY
	INY
	INY
	INY
	CPY #$018C
	BCC -
	LDX #$0000
	STX m12
	LDX #$0038
	LDY #$00E0
	LDA wm_SprStompImmuneTbl.Spr10
	CMP #$01
	BNE _0282D8
	LDX #$0039
	STX m12
	LDX #$001D
	LDY #$00FC
_0282D8:
	STX m0
	REP #$20
	TXA
	CLC
	ADC m12
	STA m10
	SEP #$20
	LDA m6
	CLC
	LDX m10
	ADC.L DATA_028178,X
	STA wm_ExOamSlot.4.XPos,Y
	STA m2
	LDA wm_Layer1DispYLo
	STA m7
	ASL
	ROR m7
	LDA.L DATA_0281CF,X
	DEC A
	SEC
	SBC m7
	STA wm_ExOamSlot.4.YPos,Y
	LDX m10
	LDA wm_UpdateBossTiles
	BNE +
	LDA.L DATA_028226,X
	STA wm_ExOamSlot.4.Tile,Y
	LDA #$0D
	STA wm_ExOamSlot.4.Prop,Y
+	REP #$20
	PHY
	TYA
	LSR
	LSR
	TAY
	SEP #$20
	LDA #$02
	STA wm_ExOamSize.4,Y
	LDA m2
	CMP #$F0
	BCC +
	LDA wm_SprStompImmuneTbl.Spr10
	CMP #$01
	BEQ +
	PLY
	PHY
	LDX m3
	LDA wm_ExOamSlot.4.XPos,Y
	STA wm_ExOamSlot.4.XPos,X
	LDA wm_ExOamSlot.4.YPos,Y
	STA wm_ExOamSlot.4.YPos,X
	LDA wm_ExOamSlot.4.Tile,Y
	STA wm_ExOamSlot.4.Tile,X
	LDA wm_ExOamSlot.4.Prop,Y
	STA wm_ExOamSlot.4.Prop,X
	REP #$20
	TXA
	LSR
	LSR
	TAY
	SEP #$20
	LDA #$03
	STA wm_ExOamSize.4,Y
	LDA m3
	CLC
	ADC #$04
	STA m3
	BCC +
	INC m4
+	PLY
	LDX m0
	DEY
	DEY
	DEY
	DEY
	DEX
	BMI CODE_028374
	JMP _0282D8

CODE_028374:
	SEP #$10
	LDA #$01
	STA wm_UpdateBossTiles
	LDA wm_SprStompImmuneTbl.Spr10
	CMP #$01
	BNE CODE_028398
	LDA #$CD
	STA wm_ExOamSlot.48.Prop
	STA wm_ExOamSlot.49.Prop
	STA wm_ExOamSlot.50.Prop
	STA wm_ExOamSlot.51.Prop
	STA wm_ExOamSlot.52.Prop
	STA wm_ExOamSlot.53.Prop
	BRA _0283C4

CODE_028398:
	LDA wm_FrameB
	AND #$03
	BNE _0283C4
	STZ m0
-	LDX m0
	LDA.L DATA_0283C8,X
	TAY
	JSL GetRand
	AND #$01
	BNE +
	LDA wm_ExOamSlot.4.Tile,Y
	EOR #$02
	STA wm_ExOamSlot.4.Tile,Y
+	LDA #$09
	STA wm_ExOamSlot.4.Prop,Y
	INC m0
	LDA m0
	CMP #$04
	BNE -
_0283C4:
	JSR CODE_0283CE
	RTL

DATA_0283C8:	.DB $00,$04,$08,$0C

DATA_0283CC:	.DB $0C,$30

CODE_0283CE:
	LDA wm_SpriteMiscTbl5.Spr10
	SEC
	SBC #$1E
	STA m12
	LDA wm_SpriteMiscTbl8.Spr10
	CLC
	ADC #$10
	STA m13
	LDX #$01
-	STX m15
	LDA wm_BossLPillarStat,X
	BEQ ++
	BMI +
	STA wm_IsFrozen
	STA wm_SpritesLocked
	JSR CODE_0283F8
+	JSR CODE_028439
++	DEX
	BPL -
	RTS

CODE_0283F8:
	LDA wm_BossLPillarYPos,X
	LSR
	LSR
	LSR
	LSR
	LSR
	SEC
	ADC wm_BossLPillarYPos,X
	CMP #$B0
	BCC _028435
	ASL wm_BossLPillarStat,X
	SEC
	ROR wm_BossLPillarStat,X
	LDA #$30
	STA wm_ShakeGrndTimer
	LDA #$09
	STA wm_SoundCh3
	CPX #$00
	BNE CODE_02842A
	LDA wm_BossRPillarStat
	BNE CODE_02842A
	INC wm_BossRPillarStat
	STZ wm_BossRPillarYPos
	BRA _028433

CODE_02842A:
	CPX #$01
	BNE _028433
	STZ wm_SpritesLocked
	STZ wm_IsFrozen
_028433:
	LDA #$B0
_028435:
	STA wm_BossLPillarYPos,X
	RTS

CODE_028439:
	LDA.L DATA_0283CC,X
	TAY
	STZ m0
-	LDA #$F0
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_BossLPillarYPos,X
	SEC
	SBC wm_Bg1VOfs
	SEC
	SBC wm_Layer1DispYLo
	SEC
	SBC m0
	CMP #$20
	BCC ++
	CMP #$A4
	BCS +
	STA wm_ExOamSlot.1.YPos,Y
+	LDA m12,X
	STA wm_ExOamSlot.1.XPos,Y
	LDA #$E6
	LDX m0
	BEQ +
	LDA #$08
+	STA wm_ExOamSlot.1.Tile,Y
	LDA #$0D
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	LDX m15
	INY
	INY
	INY
	INY
	LDA m0
	CLC
	ADC #$10
	STA m0
	CMP #$90
	BCC -
++	RTS

SubHorzPosBnk2:
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

IsOffScreenBnk2:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	RTS

CODE_0284A6:
	STA m3
	LDA #$02
	STA m1
-	JSL CODE_0284D8
	LDA m2
	CLC
	ADC m3
	STA m2
	DEC m1
	BPL -
	RTL

CODE_0284BC:
	LDA #$12
	BRA _0284C2

CODE_0284C0:
	LDA #$00
_0284C2:
	STA m0
	STZ m2
	LDA wm_SpriteNum,X
	CMP #$41
	BEQ +
	CMP #$42
	BNE CODE_0284D8
+	LDA wm_SpriteSpeedY,X
	BPL _Return0284E7
	LDA #$0A
	BRA CODE_0284A6

CODE_0284D8:
	JSR IsOffScreenBnk2
	BNE _Return0284E7
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ CODE_0284E8
	DEY
	BPL -
_Return0284E7:
	RTL

CODE_0284E8:
	LDA wm_SpriteYLo,X
	CLC
	ADC #$00
	AND #$F0
	CLC
	ADC #$03
	STA wm_MExSprYLo,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC m2
	STA wm_MExSprXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_MExSprXHi,Y
	LDA #$07
	STA wm_MExSprNum,Y
	LDA m0
	STA wm_MExSprTimer,Y
	RTL

DATA_028510:	.DB $04,$FC,$06,$FA,$08,$F8,$0A,$F6

DATA_028518:	.DB $E0,$E1,$E2,$E3,$E4,$E6,$E8,$EA

DATA_028520:	.DB $1F,$13,$10,$1C,$17,$1A,$0F,$1E

CODE_028528:
	JSR IsOffScreenBnk2
	LDA wm_OffscreenVert,X
	BNE _Return0284E7
	LDA #$04
	STA m0
	LDY #$07
_028536:
	LDA wm_ExSpriteNum,Y
	BEQ CODE_02853F
	DEY
	BPL _028536
	RTL

CODE_02853F:
	LDA #$07
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_ExSpriteYHi,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	JSL GetRand
	PHX
	AND #$07
	TAX
	LDA.L DATA_028510,X
	STA wm_ExSprSpeedX,Y
	LDA wm_RandomByte2
	AND #$07
	TAX
	LDA.L DATA_028518,X
	STA wm_ExSprSpeedY,Y
	JSL GetRand
	AND #$07
	TAX
	LDA.L DATA_028520,X
	STA wm_ExSpriteTbl2,Y
	PLX
	DEC m0
	BPL _028536
	RTL

CODE_02858F:
	LDY #$1F
	LDX #$00
	LDA wm_MarioPowerUp
	BNE +
	LDY #$0F
	LDX #$10
+	STX m1
	JSL GetRand
	TYA
	AND wm_RandomByte1
	CLC
	ADC m1
	CLC
	ADC wm_MarioYPos
	STA m0
	LDA wm_RandomByte2
	AND #$0F
	CLC
	ADC #$FE
	CLC
	ADC wm_MarioXPos
	STA m2
_0285BA:
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ CODE_0285C5
	DEY
	BPL -
	RTL

CODE_0285C5:
	LDA #$05
	STA wm_MExSprNum,Y
	LDA #$00
	STA wm_MExSprYSpeed,Y
	LDA m0
	STA wm_MExSprYLo,Y
	LDA m2
	STA wm_MExSprXLo,Y
	LDA #$17
	STA wm_MExSprTimer,Y
	RTL

CODE_0285DF:
	JSR IsOffScreenBnk2
	BNE +
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ CODE_0285EF
	DEY
	BPL -
+	RTL

CODE_0285EF:
	JSL GetRand
	LDA #$04
	STA wm_MExSprNum,Y
	LDA #$00
	STA wm_MExSprYSpeed,Y
	LDA wm_RandomByte1
	AND #$0F
	SEC
	SBC #$03
	CLC
	ADC wm_SpriteXLo,X
	STA wm_MExSprXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_MExSprXHi,Y
	LDA wm_RandomByte2
	AND #$07
	CLC
	ADC #$07
	CLC
	ADC wm_SpriteYLo,X
	STA wm_MExSprYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_MExSprYHi,Y
	LDA #$17
	STA wm_MExSprTimer,Y
	RTL

CODE_02862F:
	JSL FindFreeSprSlot
	BMI +
	TYX
	LDA #$0B
	STA wm_SpriteStatus,X
	LDA wm_MarioYPos
	STA wm_SpriteYLo,X
	LDA wm_MarioYPos+1
	STA wm_SpriteYHi,X
	LDA wm_MarioXPos
	STA wm_SpriteXLo,X
	LDA wm_MarioXPos+1,X
	STA wm_SpriteXHi,X
	LDA #$53
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA #$FF
	STA wm_SpriteDecTbl1,X
	LDA #$08
	STA wm_PickUpImgTimer
	STA wm_IsCarrying2
+	RTL

ShatterBlock:
	PHX
	STA m0
	LDY #$03
	LDX #$0B
-	LDA wm_MExSprNum,X
	BEQ ++
--	DEX
	BPL -
	DEC wm_DelOldExSpr
	BPL +
	LDA #$0B
	STA wm_DelOldExSpr
+	LDX wm_DelOldExSpr
++	LDA #$07
	STA wm_SoundCh3
	LDA #$01
	STA wm_MExSprNum,X
	LDA wm_BlockYPos
	CLC
	ADC DATA_028746,Y
	STA wm_MExSprXLo,X
	LDA wm_BlockYPos+1
	ADC #$00
	STA wm_MExSprXHi,X
	LDA wm_BlockXPos
	CLC
	ADC DATA_028742,Y
	STA wm_MExSprYLo,X
	LDA wm_BlockXPos+1
	ADC #$00
	STA wm_MExSprYHi,X
	LDA DATA_02874A,Y
	STA wm_MExSprYSpeed,X
	LDA DATA_02874E,Y
	STA wm_MExSprXSpeed,X
	LDA m0
	STA wm_MExSprTimer,X
	DEY
	BPL --
	PLX
	RTL

YoshiStompRoutine:
	LDA wm_SprChainStomped
	BNE +
	PHB
	PHK
	PLB
	JSR SprBlkInteract
	LDA #$02
	STA wm_BouncBlkStatus,Y
	LDA wm_MarioXPos
	STA wm_BounceSprInterXLo,Y
	LDA wm_MarioXPos+1
	STA wm_BounceSprInterYHi,Y
	LDA wm_MarioYPos
	CLC
	ADC #$20
	STA wm_BounceSprInterYLo,Y
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_BounceSprInterYHi,Y
	JSR CODE_029BE4
	PLB
+	RTL

SprBlkInteract:
	LDY #$03
-	LDA wm_BouncBlkStatus,Y
	BEQ +
	DEY
	BPL -
	INY
+	LDA wm_BlockYPos
	STA wm_BounceSprInterXLo,Y
	LDA wm_BlockYPos+1
	STA wm_BounceSprInterXHi,Y
	LDA wm_BlockXPos
	STA wm_BounceSprInterYLo,Y
	LDA wm_BlockXPos+1
	STA wm_BounceSprInterYHi,Y
	LDA wm_LayerInProcess
	BEQ +
	LDA wm_BlockYPos
	SEC
	SBC wm_26
	STA wm_BounceSprInterXLo,Y
	LDA wm_BlockYPos+1
	SBC wm_27
	STA wm_BounceSprInterXHi,Y
	LDA wm_BlockXPos
	SEC
	SBC wm_28
	STA wm_BounceSprInterYLo,Y
	LDA wm_BlockXPos+1
	SBC wm_29
	STA wm_BounceSprInterYHi,Y
+	LDA #$01
	STA wm_BouncBlkStatus,Y
	LDA #$06
	STA wm_BounceSprInterTime,Y
	RTS

BlockBounceSpeedY:	.DB $C0,$00,$00,$40

BlockBounceSpeedX:	.DB $00,$40,$C0,$00

DATA_028742:	.DB $00,$00,$08,$08

DATA_028746:	.DB $00,$08,$00,$08

DATA_02874A:	.DB $FB,$FB,$FD,$FD

DATA_02874E:	.DB $FF,$01,$FF,$01

CODE_028752:
	LDA m4
	CMP #$07
	BNE NotBreakable
	LDA wm_OWCharA
	ASL
	ADC wm_OWCharA
	TAX
	LDA wm_MarioScoreHi,X
	CLC
	ADC #$05
	STA wm_MarioScoreHi,X
	BCC +
	INC wm_MarioScoreMid,X
	BNE +
	INC wm_MarioScoreLo,X
+	LDA #$D0
	STA wm_MarioSpeedY
	LDA #$00
	JSL ShatterBlock
	JSR SprBlkInteract
	LDA #$02
	STA wm_BlockId
	JSL GenerateTile
	RTL

BlockBounce:
	.DB $00,$03,$00,$00,$01,$07,$00,$04
	.DB $0A

NotBreakable:
	LDY #$03
-	LDA wm_BounceSprNum,Y
	BEQ ++
	DEY
	BPL -
	DEC wm_BounceSprAltIndex
	BPL +
	LDA #$03
	STA wm_BounceSprAltIndex
+	LDY wm_BounceSprAltIndex
	LDA wm_BounceSprNum,Y
	CMP #$07
	BNE +
	LDA wm_BlockYPos
	PHA
	LDA wm_BlockYPos+1
	PHA
	LDA wm_BlockXPos
	PHA
	LDA wm_BlockXPos+1
	PHA
	LDA wm_BounceSprYLo,Y
	STA wm_BlockYPos
	LDA wm_BounceSprYHi,Y
	STA wm_BlockYPos+1
	LDA wm_BounceSprXLo,Y
	CLC
	ADC #$0C
	AND #$F0
	STA wm_BlockXPos
	LDA wm_BounceSprXHi,Y
	ADC #$00
	STA wm_BlockXPos+1
	LDA wm_BounceSprBlock,Y
	STA wm_BlockId
	LDA m4
	PHA
	LDA m5
	PHA
	LDA m6
	PHA
	LDA m7
	PHA
	JSL GenerateTile
	PLA
	STA m7
	PLA
	STA m6
	PLA
	STA m5
	PLA
	STA m4
	PLA
	STA wm_BlockXPos+1
	PLA
	STA wm_BlockXPos
	PLA
	STA wm_BlockYPos+1
	PLA
	STA wm_BlockYPos
+	LDY wm_BounceSprAltIndex
++	LDA m4
	CMP #$10
	BCC CODE_028818
	STZ m4
	TAX
	LDA.W BlockBounce-9,X
	STA wm_BounceBlkData,Y
	BRA _02882A

CODE_028818:
	LDA m4
	CMP #$05
	BNE +
	LDX #$0B
	STX wm_SoundCh1
+	TAX
	LDA.W BlockBounce,X
	STA wm_BounceBlkData,Y
_02882A:
	LDA m4
	INC A
	STA wm_BounceSprNum,Y
	LDA #$00
	STA wm_BounceSprInit,Y
	LDA wm_BlockYPos
	STA wm_BounceSprYLo,Y
	LDA wm_BlockYPos+1
	STA wm_BounceSprYHi,Y
	LDA wm_BlockXPos
	STA wm_BounceSprXLo,Y
	LDA wm_BlockXPos+1
	STA wm_BounceSprXHi,Y
	LDA wm_LayerInProcess
	LSR
	ROR
	STA m8
	LDX m6
	LDA.W BlockBounceSpeedY,X
	STA wm_BouncBlkSpeedX,Y
	LDA.W BlockBounceSpeedX,X
	STA wm_BouncBlkSpeedY,Y
	TXA
	ORA m8
	STA wm_BounceSprTable,Y
	LDA m7
	STA wm_BounceSprBlock,Y
	LDA #$08
	STA wm_BounceSprTimer,Y
	LDA wm_BounceSprNum,Y
	CMP #$07
	BNE +
	LDA #$FF
	STA wm_SpinBlockTimer,Y
+	JSR SprBlkInteract
_02887D:
	LDA m5
	BEQ ++
	CMP #$0A
	BNE + ; branch to next instruction
+	LDA m5
	CMP #$08
	BCS CODE_0288DC
	CMP #$06
	BCC CODE_0288DC
	CMP #$07
	BNE _02889D
	LDA wm_MultiCoinBlkTimer
	BNE _02889D
	LDA #$FF
	STA wm_MultiCoinBlkTimer
_02889D:
	JSR CODE_028A66
++	RTL

DATA_0288A1:	.DB $35,$78

SpriteInBlock:
	.DB $00,$74,$75,$76,$77,$78,$00,$00
	.DB $79,$00,$3E,$7D,$2C,$04,$81,$45
	.DB $80

UNK_SpriteInBlockPow: ; Clone of above, but unused
	.DB $00,$74,$75,$76,$77,$78,$00,$00
	.DB $79,$00,$3E,$7D,$2C,$04,$81,$45
	.DB $80

StatusOfSprInBlk:
	.DB $00,$08,$08,$08,$08,$08,$00,$00
	.DB $08,$00,$09,$08,$09,$09,$08,$08
	.DB $09

DATA_0288D6:	.DB $80,$7E,$7D

DATA_0288D9:	.DB $09,$08,$08

CODE_0288DC:
	LDY m5
	CPY #$0B
	BNE +
	LDA wm_BlockYPos
	AND #$30
	CMP #$20
	BEQ GenSpriteFromBlk
+	CPY #$10
	BEQ _0288FD
	CPY #$08
	BNE CODE_0288F9
	LDA wm_SpriteMemory
	BEQ GenSpriteFromBlk
	BNE _0288FD ; [BRA FIX]

CODE_0288F9:
	CPY #$0C
	BNE GenSpriteFromBlk
_0288FD:
	JSL FindFreeSprSlot
	TYX
	BPL _028922
	RTL

GenSpriteFromBlk:
	LDX #$0B
-	LDA wm_SpriteStatus,X
	BEQ _028922
	DEX
	CPX #$FF
	BNE -
	DEC wm_FullSprDelete
	BPL +
	LDA #$01
	STA wm_FullSprDelete
+	LDA wm_FullSprDelete
	CLC
	ADC #$0A
	TAX
_028922:
	STX wm_TempTileGen
	LDY m5
	LDA StatusOfSprInBlk,Y
	STA wm_SpriteStatus,X
	LDA wm_LooseYoshiFlag
	BEQ +
	TYA
	CLC
	ADC #$11
	TAY
+	STY wm_CheckSprInter
	LDA SpriteInBlock,Y
	STA wm_SpriteNum,X
	STA m14
	LDY #$02
	CMP #$81
	BCS +
	CMP #$79
	BCC +
	INY
+	STY wm_SoundCh3
	JSL InitSpriteTables
	INC wm_OffscreenHorz,X
	LDA wm_SpriteNum,X
	CMP #$45
	BNE _028972
	LDA wm_DirCoinActivate
	BEQ CODE_028967
	STZ wm_SpriteStatus,X
	JMP _02889D

CODE_028967:
	LDA #$0E
	STA wm_MusicCh1
	INC wm_DirCoinActivate
	STZ wm_DirCoinTimer
_028972:
	LDA wm_BlockYPos
	STA wm_SpriteXLo,X
	LDA wm_BlockYPos+1
	STA wm_SpriteXHi,X
	LDA wm_BlockXPos
	STA wm_SpriteYLo,X
	LDA wm_BlockXPos+1
	STA wm_SpriteYHi,X
	LDA wm_LayerInProcess
	BEQ +
	LDA wm_BlockYPos
	SEC
	SBC wm_26
	STA wm_SpriteXLo,X
	LDA wm_BlockYPos+1
	SBC wm_27
	STA wm_SpriteXHi,X
	LDA wm_BlockXPos
	SEC
	SBC wm_28
	STA wm_SpriteYLo,X
	LDA wm_BlockXPos+1
	SBC wm_29
	STA wm_SpriteYHi,X
+	LDA wm_SpriteNum,X
	CMP #$7D
	BNE CODE_0289D3
	LDA wm_SpriteXLo,X
	AND #$30
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA DATA_0288D9,Y
	STA wm_SpriteStatus,X
	LDA DATA_0288D6,Y
	STA wm_SpriteNum,X
	PHA
	JSL InitSpriteTables
	PLA
	CMP #$7D
	BNE CODE_0289CD
	INC wm_SpriteDir,X
	RTL

CODE_0289CD:
	CMP #$7E
	BEQ CODE_028A03
	BRA _028A01

CODE_0289D3:
	CMP #$04
	BEQ ADDR_028A08
	CMP #$3E
	BEQ CODE_028A2A
	CMP #$2C
	BNE CODE_028A11
	LDY #$0B
_0289E1:
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC CODE_0289F3
	LDA.W wm_SpriteNum,Y
	CMP #$2D
	BNE CODE_0289F3
_0289EF:
	LDY #$01
	BRA _0289FB

CODE_0289F3:
	DEY
	BPL _0289E1
	LDY wm_LooseYoshiFlag
	BNE _0289EF
_0289FB:
	LDA DATA_0288A1,Y
	STA wm_SpriteMiscTbl3,X
_028A01:
	BRA _028A0D

CODE_028A03:
	INC wm_SpriteState,X
	INC wm_SpriteState,X
	RTL

ADDR_028A08:
	LDA #$FF
	STA wm_SpriteDecTbl1,X
_028A0D:
	LDA #$D0
	BRA _028A18

CODE_028A11:
	LDA #$3E
	STA wm_SpriteDecTbl1,X
	LDA #$D0
_028A18:
	STA wm_SpriteSpeedY,X
	LDA #$2C
	STA wm_SpriteDecTbl2,X
	LDA wm_Tweaker190F,X
	BPL +
	LDA #$10
	STA wm_SpriteDecTbl5,X
+	RTL

CODE_028A2A:
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	AND #$01
	STA wm_SpriteMiscTbl3,X
	TAY
	LDA DATA_028A42,Y
	STA wm_SpritePal,X
	JSL CODE_028A44
	BRA _028A0D

DATA_028A42:	.DB $06,$02

CODE_028A44:
	PHX
	LDX #$03
-	LDA wm_SmokeSprite,X
	BEQ +
	DEX
	BPL -
	INX
+	LDA #$01
	STA wm_SmokeSprite,X
	LDA wm_BlockXPos
	STA wm_SmokeYPos,X
	LDA wm_BlockYPos
	STA wm_SmokeXPos,X
	LDA #$1B
	STA wm_SmokeTimer,X
	PLX
	RTL

CODE_028A66:
	LDX #$03
-	LDA wm_SpinCoinSlot,X
	BEQ ++
	DEX
	BPL -
	DEC wm_SpinCoinIndex
	BPL +
	LDA #$03
	STA wm_SpinCoinIndex
+	LDX wm_SpinCoinIndex
++	JSL CODE_05B34A
	INC wm_SpinCoinSlot,X
	LDA wm_BlockYPos
	STA wm_SpinCoinXLo,X
	LDA wm_BlockYPos+1
	STA wm_SpinCoinXHi,X
	LDA wm_BlockXPos
	SEC
	SBC #$10
	STA wm_SpinCoinYLo,X
	LDA wm_BlockXPos+1
	SBC #$00
	STA wm_SpinCoinYHi,X
	LDA wm_LayerInProcess
	STA wm_SpinCoinTbl,X
	LDA #$D0
	STA wm_SpinCoinYSpeed,X
	RTS

DATA_028AA9:	.DB $07,$03,$03,$01,$01,$01,$01,$01

CODE_028AB1:
	PHB
	PHK
	PLB
	LDA wm_GiveLives
	BEQ _028AD5
	LDA wm_GiveLifeTimer
	BEQ CODE_028AC3
	DEC wm_GiveLifeTimer
	BRA _028AD5

CODE_028AC3:
	DEC wm_GiveLives
	BEQ +
	LDA #$23
	STA wm_GiveLifeTimer
+	LDA #$05
	STA wm_SoundCh3
	INC wm_StatusLives
_028AD5:
	LDA wm_StarPowerTimer
	BEQ CODE_028AEB
	CMP #$08
	BCC CODE_028AEB
	LSR
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA wm_FrameA
	AND DATA_028AA9,Y
	BRA _028AF5

CODE_028AEB:
	LDA wm_SparkleTimer
	BEQ +
	DEC wm_SparkleTimer
	AND #$01
_028AF5:
	ORA wm_MarioScrPosX+1
	ORA wm_MarioScrPosY+1
	BNE +
	LDA wm_MarioScrPosY
	CMP #$D0
	BCS +
	JSL CODE_02858F
+	JSR CODE_028B67
	JSR CODE_02902D
	JSR ScoreSprGfx
	JSR CODE_029B0A
	JSR CODE_0299D2
	JSR CODE_02B387
	JSR CallGenerator
	JSR CODE_0294F5
	JSR LoadSprFromLevel
	LDA wm_TimeTillRespawn
	BEQ +
	LDA wm_FrameA
	AND #$01
	ORA wm_SpritesLocked
	ORA wm_AppearSprTimer
	BNE +
	DEC wm_TimeTillRespawn
	BNE +
	JSL FindFreeSprSlot
	BMI +
	TYX
	LDA #$01
	STA wm_SpriteStatus,X
	LDA wm_SpriteToRespawn
	STA wm_SpriteNum,X
	LDA wm_Bg1HOfs
	SEC
	SBC #$20
	AND #$EF
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	SBC #$00
	STA wm_SpriteXHi,X
	LDA wm_RespawnSprYPos
	STA wm_SpriteYLo,X
	LDA wm_RespawnSprYPos+1
	STA wm_SpriteYHi,X
	JSL InitSpriteTables
+	PLB
	RTL

CODE_028B67:
	LDX #$0B
-	LDA wm_MExSprNum,X
	BEQ +
	STX wm_ExSprIndexM
	JSR CODE_028B94
+	DEX
	BPL -
_Return028B77:
	RTS

BrokenBlock:
	.DB $50,$54,$58,$5C,$60,$64,$68,$6C
	.DB $70,$74,$78,$7C

BrokenBlock2:	.DB $3C,$3D,$3D,$3C,$3C,$3D,$3D,$3C

DATA_028B8C:	.DB $00,$00,$80,$80,$80,$C0,$40,$00

CODE_028B94:
	JSL ExecutePtr

Ptrs028B98:
	.DW _Return028B77
	.DW CODE_028F8B
	.DW CODE_028ED2
	.DW CODE_028E7E
	.DW CODE_028F2F
	.DW CODE_028ED2
	.DW CODE_028DDB
	.DW CODE_028D4F
	.DW CODE_028DDB
	.DW CODE_028DDB
	.DW CODE_028CC4
	.DW ADDR_028C0F

DisabledAddSmokeRt:
	PHB
	PHK
	PLB
	JSR Return028BB8
	PLB
	RTL

Return028BB8:
	RTS

UnusedYoshiSmoke: ; Unreachable, smoke when on yoshi
	STZ m0
	JSR _028BC0
	INC m0
_028BC0:
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ ADDR_028BCB
	DEY
	BPL -
	RTS

ADDR_028BCB:
	LDA #$0B
	STA wm_MExSprNum,Y
	LDA #$00
	STA wm_MExSprTimer,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$1C
	STA wm_MExSprYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_MExSprYHi,Y
	LDA wm_MarioXPos
	STA m2
	LDA wm_MarioXPos+1
	STA m3
	PHX
	LDX m0
	LDA.W DATA_028C09,X
	STA wm_MExSprXSpeed,Y
	LDA m2
	CLC
	ADC.W DATA_028C0B,X
	STA wm_MExSprXLo,Y
	LDA m3
	ADC.W DATA_028C0D,X
	STA wm_MExSprXHi,Y
	PLX
	RTS

DATA_028C09:	.DB $40,$C0

DATA_028C0B:	.DB $0C,$FC

DATA_028C0D:	.DB $00,$FF

ADDR_028C0F:
	LDA wm_MExSprTimer,X
	BNE ADDR_028C61
	LDA wm_MExSprXSpeed,X
	BEQ _028C66
	BPL ADDR_028C20
	CLC
	ADC #$08
	BRA _028C23

ADDR_028C20:
	SEC
	SBC #$08
_028C23:
	STA wm_MExSprXSpeed,X
	JSR CODE_02B5BC
	TXA
	EOR wm_FrameA
	AND #$03
	BNE _Return028C60
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ ADDR_028C3B
	DEY
	BPL -
	RTS

ADDR_028C3B:
	LDA #$0B
	STA wm_MExSprNum,Y
	STA wm_MExSprYSpeed,Y
	LDA wm_MExSprXLo,X
	STA wm_MExSprXLo,Y
	LDA wm_MExSprXHi,X
	STA wm_MExSprXHi,Y
	LDA wm_MExSprYLo,X
	STA wm_MExSprYLo,Y
	LDA wm_MExSprYHi,X
	STA wm_MExSprYHi,Y
	LDA #$10
	STA wm_MExSprTimer,Y
_Return028C60:
	RTS

ADDR_028C61:
	DEC wm_MExSprTimer,X
	BNE ADDR_028C6E
_028C66:
	STZ wm_MExSprNum,X
	RTS

DATA_028C6A:	.DB $66,$66,$64,$62

ADDR_028C6E:
	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_MExSprXHi,X
	SBC wm_Bg1HOfs+1
	BNE _028C66
	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_MExSprYHi,X
	SBC wm_Bg1VOfs+1
	BNE _028C66
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA m1
	STA wm_ExOamSlot.1.YPos,Y
	PHX
	LDA wm_MExSprTimer,X
	LSR
	LSR
	TAX
	LDA.W DATA_028C6A,X
	STA wm_ExOamSlot.1.Tile,Y
	PLX
	LDA wm_SpriteProp
	ORA #$08
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

BooStreamTiles:
	.DB $88,$A8,$AA,$8C,$8E,$AE,$88,$A8
	.DB $AA,$8C,$8E,$AE

CODE_028CC4:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_MExSprXLo,X
	CLC
	ADC #$04
	STA m4
	LDA wm_MExSprXHi,X
	ADC #$00
	STA m10
	LDA wm_MExSprYLo,X
	CLC
	ADC #$04
	STA m5
	LDA wm_MExSprYHi,X
	ADC #$00
	STA m11
	LDA #$08
	STA m6
	STA m7
	JSL GetMarioClipping
	JSL CheckForContact
	BCC +
	JSL HurtMario
+	DEC wm_MExSprTimer,X
	BEQ _028D62
++	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_MExSprXHi,X
	SBC wm_Bg1HOfs+1
	BNE +
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS _028D62
	STA wm_ExOamSlot.1.YPos,Y
	LDA.W BooStreamTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_MExSprXSpeed,X
	LSR
	AND #$40
	EOR #$40
	ORA wm_SpriteProp
	ORA #$0F
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
+	RTS

WaterSplashTiles:
	.DB $68,$68,$6A,$6A,$6A,$62,$62,$62
	.DB $64,$64,$64,$64,$66

CODE_028D4F:
	LDA wm_MExSprXLo,X
	CMP wm_Bg1HOfs
	LDA wm_MExSprXHi,X
	SBC wm_Bg1HOfs+1
	BNE _028D62
	LDA wm_MExSprTimer,X
	CMP #$20
	BNE CODE_028D66
_028D62:
	STZ wm_MExSprNum,X
	RTS

CODE_028D66:
	STZ m0
	CMP #$10
	BCC ++
	AND #$01
	ORA wm_SpritesLocked
	BNE +
	INC wm_MExSprYLo,X
+	LDA wm_MExSprTimer,X
	SEC
	SBC #$10
	LSR
	LSR
	STA m2
	LDA wm_FrameA
	LSR
	LDA m2
	BCC +
	EOR #$FF
	INC A
+	STA m0
++	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	CLC
	ADC m0
	SEC
	SBC wm_Bg1HOfs
	CMP #$F0
	BCS _028D62
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$E8
	BCS _028D62
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_MExSprTimer,X
	LSR
	TAX
	CPX #$0C
	BCC +
	LDX #$0C
+	LDA.W WaterSplashTiles,X
	LDX wm_ExSprIndexM
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA #$02
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	LDA wm_SpritesLocked
	BNE +
	INC wm_MExSprTimer,X
+	RTS

RipVanFishZsTiles:	.DB $F1,$F0,$E1,$E0

CODE_028DDB:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_MExSprTimer,X
	BEQ +
	DEC wm_MExSprTimer,X
+	LDA wm_MExSprTimer,X
	AND #$00
	BNE +
	LDA wm_MExSprTimer,X
	INC wm_MExSprXSpeed,X
	AND #$10
	BNE +
	DEC wm_MExSprXSpeed,X
	DEC wm_MExSprXSpeed,X
+	LDA wm_MExSprXSpeed,X
	PHA
	LDY wm_MExSprNum,X
	CPY #$09
	BNE +
	EOR #$FF
	INC A
	STA wm_MExSprXSpeed,X
+	JSR CODE_02B5BC
	PLA
	STA wm_MExSprXSpeed,X
	LDA wm_MExSprTimer,X
	AND #$03
	BNE ++
	DEC wm_MExSprYLo,X
++	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$08
	BCC CODE_028E76
	CMP #$FC
	BCS CODE_028E76
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS CODE_028E76
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_SpriteProp
	ORA #$03
	STA wm_ExOamSlot.1.Prop,Y
	LDA wm_MExSprTimer,X
	CMP #$14
	BEQ CODE_028E76
	LDA wm_MExSprNum,X
	CMP #$08
	LDA #$7F
	BCS +
	LDA wm_MExSprTimer,X
	LSR
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAX
	LDA.W RipVanFishZsTiles,X
+	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	LDX wm_ExSprIndexM
	RTS

CODE_028E76:
	STZ wm_MExSprNum,X
	RTS

UNK_028E7A:	.DB $03,$43,$83,$C3

CODE_028E7E:
	DEC wm_MExSprTimer,X
	LDA wm_MExSprTimer,X
	AND #$3F
	BEQ _028ED7
	JSR CODE_02B5BC
	JSR CODE_02B5C8
	INC wm_MExSprYSpeed,X
	INC wm_MExSprYSpeed,X
	LDY.W BrokenBlock,X
	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS _028ED7
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F8
	BCS _028ED7
	STA wm_ExOamSlot.1.XPos,Y
	LDA #$6F
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_MExSprTimer,X
	AND #$C0
	ORA #$03
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

StarSparkleTiles:	.DB $66,$6E,$FF,$6D,$6C,$5C

CODE_028ED2:
	LDA wm_MExSprTimer,X
	BNE CODE_028EDA
_028ED7:
	JMP CODE_028F87

CODE_028EDA:
	LDY wm_SpritesLocked
	BNE +
	DEC wm_MExSprTimer,X
+	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F0
	BCS _028ED7
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS _028ED7
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_MExSprNum,X
	PHA
	LDA wm_MExSprTimer,X
	LSR
	LSR
	LSR
	TAX
	PLA
	CMP #$05
	BNE +
	INX
	INX
	INX
+	LDA.W StarSparkleTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA #$06
	STA wm_ExOamSlot.1.Prop,Y
	LDX wm_ExSprIndexM
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

LavaSplashTiles:	.DB $D7,$C7,$D6,$C6

CODE_028F2F:
	LDA wm_MExSprXLo,X
	CMP wm_Bg1HOfs
	LDA wm_MExSprXHi,X
	SBC wm_Bg1HOfs+1
	BNE CODE_028F87
	LDA wm_MExSprTimer,X
	BEQ CODE_028F87
	LDY wm_SpritesLocked
	BNE +
	DEC wm_MExSprTimer,X
	JSR CODE_02B5C8
	INC wm_MExSprYSpeed,X
+	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_MExSprYLo,X
	CMP #$F0
	BCS CODE_028F87
	SEC
	SBC wm_Bg1VOfs
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_MExSprTimer,X
	LSR
	LSR
	LSR
	TAX
	LDA.W LavaSplashTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA #$05
	STA wm_ExOamSlot.1.Prop,Y
	LDX wm_ExSprIndexM
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

CODE_028F87:
	STZ wm_MExSprNum,X
	RTS

CODE_028F8B:
	LDA wm_SpritesLocked
	BNE +++
	LDA wm_FrameA
	AND #$03
	BEQ ++
	LDY #$00
	LDA wm_MExSprXSpeed,X
	BPL +
	DEY
+	CLC
	ADC wm_MExSprXLo,X
	STA wm_MExSprXLo,X
	TYA
	ADC wm_MExSprXHi,X
	STA wm_MExSprXHi,X
++	LDY #$00
	LDA wm_MExSprYSpeed,X
	BPL +
	DEY
+	CLC
	ADC wm_MExSprYLo,X
	STA wm_MExSprYLo,X
	TYA
	ADC wm_MExSprYHi,X
	STA wm_MExSprYHi,X
	LDA wm_FrameA
	AND #$03
	BNE +++
	INC wm_MExSprYSpeed,X
+++	LDA wm_MExSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m0
	LDA wm_MExSprYHi,X
	SBC wm_Bg1VOfs+1
	BEQ CODE_028FDD
	BPL CODE_028F87
	BMI _Return02902C ; [BRA FIX]

CODE_028FDD:
	LDY.W BrokenBlock,X
	LDA wm_MExSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m1
	LDA wm_MExSprXHi,X
	SBC wm_Bg1HOfs+1
	BNE CODE_028F87
	LDA m1
	STA wm_ExOamSlot.1.XPos,Y
	LDA m0
	CMP #$F0
	BCS CODE_028F87
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_MExSprTimer,X
	PHA
	LDA wm_FrameB
	LSR
	CLC
	ADC wm_ExSprIndexM
	AND #$07
	TAX
	LDA.W BrokenBlock2,X
	STA wm_ExOamSlot.1.Tile,Y
	PLA
	BEQ +
	LDA wm_FrameA
	AND #$0E
+	EOR.W DATA_028B8C,X
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	LDX wm_ExSprIndexM
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
_Return02902C:
	RTS

CODE_02902D:
	LDA wm_MultiCoinBlkTimer
	CMP #$02
	BCC +
	LDA wm_SpritesLocked
	BNE +
	DEC wm_MultiCoinBlkTimer
+	LDX #$03
-	STX wm_ExSprIndexM
	JSR CODE_02904D
	JSR CODE_029398
	JSR CODE_0296C0
	DEX
	BPL -
_Return02904C:
	RTS

CODE_02904D:
	LDA wm_BounceSprNum,X
	BEQ _Return02904C
	LDY wm_SpritesLocked
	BNE +
	LDY wm_BounceSprTimer,X
	BEQ +
	DEC wm_BounceSprTimer,X
+	JSL ExecutePtr

BounceSpritePtrs:
	.DW _Return02904C
	.DW BounceBlockSpr
	.DW BounceBlockSpr
	.DW BounceBlockSpr
	.DW BounceBlockSpr
	.DW BounceBlockSpr
	.DW BounceBlockSpr
	.DW TurnBlockSpr

DATA_029072:	.DB $13,$00,$00,$ED

TurnBlockSpr:
	LDA wm_SpritesLocked
	BNE _Return0290CD
	LDA wm_BounceSprInit,X
	BNE +
	INC wm_BounceSprInit,X
	JSR InvisSldFromBncSpr
+	LDA wm_BounceSprTimer,X
	BEQ _0290BB
	CMP #$01
	BNE CODE_0290A8
	LDA wm_BounceSprXLo,X
	CLC
	ADC #$08
	AND #$F0
	STA wm_BounceSprXLo,X
	LDA wm_BounceSprXHi,X
	ADC #$00
	STA wm_BounceSprXHi,X
	LDA #$05
	JSR _TileFromBounceSpr1
	BRA _0290BB

CODE_0290A8:
	JSR CODE_02B526
	LDY wm_BounceSprTable,X
	LDA wm_BouncBlkSpeedX,X
	CLC
	ADC DATA_029072,Y
	STA wm_BouncBlkSpeedX,X
	JSR BounceSprGfx
_0290BB:
	LDA wm_SpinBlockTimer,X
	BEQ CODE_0290C4
	DEC wm_SpinBlockTimer,X
	RTS

CODE_0290C4:
	LDA wm_BounceSprBlock,X
	JSR _TileFromBounceSpr1
	STZ wm_BounceSprNum,X
_Return0290CD:
	RTS

DATA_0290CE:	.DB $10,$00,$00,$F0

DATA_0290D2:	.DB $00,$F0,$10,$00

DATA_0290D6:	.DB $80,$80,$80,$00

DATA_0290DA:	.DB $80,$E0,$20,$80

BounceBlockSpr:
	JSR BounceSprGfx
	LDA wm_SpritesLocked
	BNE _Return0290CD
	LDA wm_BounceSprInit,X
	BNE ++
	INC wm_BounceSprInit,X
	JSR CODE_029265
	JSR InvisSldFromBncSpr
	LDA wm_BounceSprTable,X
	AND #$03
	TAY
	LDA DATA_0290D6,Y
	CMP #$80
	BEQ +
	STA wm_MarioSpeedY
+	LDA DATA_0290DA,Y
	CMP #$80
	BEQ ++
	STA wm_MarioSpeedX
++	JSR CODE_02B526
	JSR CODE_02B51A
	LDA wm_BounceSprTable,X
	AND #$03
	TAY
	LDA wm_BouncBlkSpeedX,X
	CLC
	ADC DATA_0290CE,Y
	STA wm_BouncBlkSpeedX,X
	LDA wm_BouncBlkSpeedY,X
	CLC
	ADC DATA_0290D2,Y
	STA wm_BouncBlkSpeedY,X
	LDA wm_BounceSprTable,X
	AND #$03
	CMP #$03
	BNE ++
	LDA wm_MarioAnimation
	CMP #$01
	BCS ++
	LDA #$20
	LDY wm_OnYoshi
	BEQ +
	LDA #$30
+	STA m0
	LDA wm_BounceSprXLo,X
	SEC
	SBC m0
	STA wm_MarioYPos
	LDA wm_BounceSprXHi,X
	SBC #$00
	STA wm_MarioYPos+1
	LDA #$01
	STA wm_IsOnSolidSpr
	STA wm_NoteBlkBounceFlag
	STZ wm_MarioSpeedY
++	LDA wm_BounceSprTimer,X
	BNE ++
	LDA wm_BounceSprTable,X
	AND #$03
	CMP #$03
	BNE +
	LDA #$A0
	STA wm_MarioSpeedY
	LDA wm_MarioYPos
	SEC
	SBC #$02
	STA wm_MarioYPos
	LDA wm_MarioYPos+1
	SBC #$00
	STA wm_MarioYPos+1
	LDA #$08
	STA wm_SoundCh3
+	JSR TileFromBounceSpr0
	LDY wm_BounceSprNum,X
	CPY #$06
	BCC +
	LDA #$0B
	STA wm_SoundCh1
	LDA wm_OnOffStatus
	EOR #$01
	STA wm_OnOffStatus
+	STZ wm_BounceSprNum,X
++	RTS

UNK_02919D:	.DB $01,$00

TileFromBounceSpr0:
	LDA wm_BounceSprBlock,X
	CMP #$0A
	BEQ +
	CMP #$0B
	BNE ++
+	LDY wm_MultiCoinBlkTimer
	CPY #$01
	BNE ++
	STZ wm_MultiCoinBlkTimer
	LDA #$0D
++	BRA _TileFromBounceSpr1

InvisSldFromBncSpr:
	LDA #$09
_TileFromBounceSpr1:
	STA wm_BlockId
	LDA wm_BounceSprYLo,X
	CLC
	ADC #$08
	AND #$F0
	STA wm_BlockYPos
	LDA wm_BounceSprYHi,X
	ADC #$00
	STA wm_BlockYPos+1
	LDA wm_BounceSprXLo,X
	CLC
	ADC #$08
	AND #$F0
	STA wm_BlockXPos
	LDA wm_BounceSprXHi,X
	ADC #$00
	STA wm_BlockXPos+1
	LDA wm_BounceSprTable,X
	ASL
	ROL
	AND #$01
	STA wm_LayerInProcess
	JSL GenerateTile
_Return0291EC:
	RTS

DATA_0291ED:	.DB $10,$14,$18

BounceSpriteTiles:	.DB $1C,$40,$6B,$2A,$42,$EA,$8A,$40

BounceSprGfx:
	LDY #$00
	LDA wm_BounceSprTable,X
	BPL +
	LDY #$04
+	LDA.W wm_Bg1VOfs,Y
	STA m2
	LDA.W wm_Bg1HOfs,Y
	STA m3
	LDA.W wm_Bg1VOfs+1,Y
	STA m4
	LDA.W wm_Bg1HOfs+1,Y
	STA m5
	LDA wm_BounceSprXLo,X
	CMP m2
	LDA wm_BounceSprXHi,X
	SBC m4
	BNE _Return0291EC
	LDA wm_BounceSprYLo,X
	CMP m3
	LDA wm_BounceSprYHi,X
	SBC m5
	BNE _Return0291EC
	LDY.W DATA_0291ED,X
	LDA wm_BounceSprXLo,X
	SEC
	SBC m2
	STA m1
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_BounceSprYLo,X
	SEC
	SBC m3
	STA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_BounceBlkData,X
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	LDA wm_BounceSprNum,X
	TAX
	LDA.W BounceSpriteTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	LDX wm_ExSprIndexM
	RTS

CODE_029265:
	LDA #$01
	LDY wm_BounceSprTable,X
	STY m15
	BPL +
	ASL
+	AND wm_IsVerticalLvl
	BEQ CODE_0292CA
	LDA wm_BounceSprXLo,X
	SEC
	SBC #$03
	AND #$F0
	STA m0
	LDA wm_BounceSprXHi,X
	SBC #$00
	CMP wm_ScreensInLvl
	BCS Return0292C9
	STA m3
	AND #$10
	STA m8
	LDA wm_BounceSprYLo,X
	STA m1
	LDA wm_BounceSprYHi,X
	CMP #$02
	BCS Return0292C9
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
	BRA _02931A

Return0292C9:
	RTS

CODE_0292CA:
	LDA wm_BounceSprXLo,X
	SEC
	SBC #$03
	AND #$F0
	STA m0
	LDA wm_BounceSprXHi,X
	SBC #$00
	CMP #$02
	BCS Return0292C9
	STA m2
	LDA wm_BounceSprYLo,X
	STA m1
	LDA wm_BounceSprYHi,X
	CMP wm_ScreensInLvl
	BCS Return0292C9
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
_02931A:
	LDA #$7E
	STA m7
	LDX wm_ExSprIndexM
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	BNE +
	LDA wm_Map16NumLo
	CMP #$2B
	BNE +
	LDA wm_BounceSprXLo,X
	PHA
	SBC #$03
	AND #$F0
	STA wm_BounceSprXLo,X
	LDA wm_BounceSprXHi,X
	PHA
	SBC #$00
	STA wm_BounceSprXHi,X
	JSR InvisSldFromBncSpr
	JSR ADDR_029356
	PLA
	STA wm_BounceSprXHi,X
	PLA
	STA wm_BounceSprXLo,X
+	RTS

ADDR_029356:
	LDY #$03
-	LDA wm_SpinCoinSlot,Y
	BEQ +
	DEY
	BPL -
	INY
+	LDA #$01
	STA wm_SpinCoinSlot,Y
	JSL CODE_05B34A
	LDA wm_BounceSprYLo,X
	STA wm_SpinCoinXLo,Y
	LDA wm_BounceSprYHi,X
	STA wm_SpinCoinXHi,Y
	LDA wm_BounceSprXLo,X
	STA wm_SpinCoinYLo,Y
	LDA wm_BounceSprXHi,X
	STA wm_SpinCoinYHi,Y
	LDA wm_BounceSprTable,X
	ASL
	ROL
	AND #$01
	STA wm_SpinCoinTbl,Y
	LDA #$D0
	STA wm_SpinCoinYSpeed,Y
_Return029391:
	RTS

DATA_029392:	.DB $F8,$08

CODE_029394:
	STZ wm_BouncBlkStatus,X
_Return029397:
	RTS

CODE_029398:
	LDA wm_BouncBlkStatus,X
	BEQ _Return029397
	DEC wm_BounceSprInterTime,X
	BEQ CODE_029394
	LDA wm_BounceSprInterTime,X
	CMP #$03
	BCS _Return029391
	LDY wm_ExSprIndexM
	STZ m14
_0293AE:
	LDX #$0B
_0293B0:
	STX wm_SprProcessIndex
	LDA wm_SpriteStatus,X
	CMP #$0B
	BEQ _0293F7
	CMP #$08
	BCC _0293F7
	LDA wm_Tweaker166E,X
	AND #$20
	ORA wm_SpriteEatenTbl,X
	ORA wm_SpriteDecTbl2,X
	ORA wm_DisSprCapeContact,X
	BNE _0293F7
	LDA wm_SprBehindScrn,X
	PHY
	LDY wm_IsClimbing
	BEQ +
	EOR #$01
+	PLY
	EOR wm_IsBehindScenery
	BNE _0293F7
	JSL GetSpriteClippingA
	LDA m14
	BEQ CODE_0293EB
	JSR CODE_029696
	BRA _0293EE

CODE_0293EB:
	JSR CODE_029663
_0293EE:
	JSL CheckForContact
	BCC _0293F7
	JSR CODE_029404
_0293F7:
	LDY wm_ExSprIndexM
	DEX
	BMI CODE_029400
	JMP _0293B0

CODE_029400:
	LDX wm_ExSprIndexM
	RTS

CODE_029404:
	LDA #$08
	STA wm_SpriteDecTbl2,X
	LDA wm_SpriteNum,X
	CMP #$81
	BNE CODE_029427
	LDA wm_SpriteState,X
	BEQ +
	STZ wm_SpriteState,X
	LDA #$C0
	STA wm_SpriteSpeedY,X
	LDA #$10
	STA wm_SpriteDecTbl1,X
	STZ wm_SpriteDir,X
	LDA #$20
	STA wm_SpriteDecTbl3,X
+	RTS

CODE_029427:
	CMP #$2D
	BEQ ++
	LDA wm_Tweaker167A,X
	AND #$02
	BNE +++
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ +
	LDA wm_SpriteNum,X
	CMP #$0D
	BEQ ++
	LDA wm_SpriteState,X
	BEQ ++
+	LDA #$FF
	STA wm_SpriteDecTbl1,X
++	STZ wm_SpriteDecTbl3,X
	LDA m14
	CMP #$35
	BEQ +
	JSL CODE_01AB6F
+	LDA #$00
	JSL GivePoints
	LDA #$02
	STA wm_SpriteStatus,X
	LDA wm_SpriteNum,X
	CMP #$1E
	BNE +
	LDA #$1F
	STA wm_SpriteDecTbl1.Spr10
+	LDA wm_Tweaker1662,X
	AND #$80
	BNE +++
	LDA wm_Tweaker1656,X
	AND #$10
	BEQ +++
	LDA wm_Tweaker1656,X
	AND #$20
	BNE +++
	LDA #$09
	STA wm_SpriteStatus,X
	ASL wm_SpritePal,X
	SEC
	ROR wm_SpritePal,X
	LDA wm_Tweaker1686,X
	AND #$40
	BEQ +++
	PHX
	LDA wm_SpriteNum,X
	TAX
	LDA.L SpriteToSpawn,X
	PLX
	STA wm_SpriteNum,X
	JSL LoadSpriteTables
+++	LDA #$C0
	LDY m14
	BEQ +
	LDA #$B0
	CPY #$02
	BNE +
	LDA #$C0
+	STA wm_SpriteSpeedY,X
	JSR SubHorzPosBnk2
	LDA DATA_029392,Y
	STA wm_SpriteSpeedX,X
	TYA
	EOR #$01
	STA wm_SpriteDir,X
	RTS

GroundPound:
	LDA #$30
	STA wm_ShakeGrndTimer
	STZ wm_14A9
	PHB
	PHK
	PLB
	LDX #$09
-	LDA wm_SpriteStatus,X
	CMP #$08
	BCC +
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	LDA wm_Tweaker166E,X
	AND #$20
	ORA wm_SpriteEatenTbl,X
	ORA wm_SpriteDecTbl2,X
	BNE +
	LDA #$35
	STA m14
	JSR CODE_029404
+	DEX
	BPL -
	PLB
	RTL

CODE_0294F5:
	LDA wm_CapeCanHurt
	BEQ ++
	STA m14
	LDA wm_FrameA
	LSR
	BCC +
	JSR _0293AE
	JSR CODE_029631
+	JSR CODE_02950B
++	RTS

CODE_02950B:
	STZ m15
	JSR CODE_029540
	LDA wm_IsVerticalLvl
	BPL +
	INC m15
	LDA wm_CapeXPos
	CLC
	ADC wm_26
	STA wm_CapeXPos
	LDA wm_CapeXPos+1
	ADC wm_27
	STA wm_CapeXPos+1
	LDA wm_CapeYPos
	CLC
	ADC wm_28
	STA wm_CapeYPos
	LDA wm_CapeYPos+1
	ADC wm_29
	STA wm_CapeYPos+1
	JSR CODE_029540
+	RTS

DATA_02953C:	.DB $08,$08

DATA_02953E:	.DB $02,$0E

CODE_029540:
	LDA wm_FrameA
	AND #$01
	TAY
	LDA m15
	INC A
	AND wm_IsVerticalLvl
	BEQ CODE_0295AE
	LDA wm_CapeYPos
	CLC
	ADC DATA_02953C,Y
	AND #$F0
	STA m0
	STA wm_BlockXPos
	LDA wm_CapeYPos+1
	ADC #$00
	CMP wm_ScreensInLvl
	BCS Return0295AD
	STA m3
	STA wm_BlockXPos+1
	LDA wm_CapeXPos
	CLC
	ADC DATA_02953E,Y
	STA m1
	STA wm_BlockYPos
	LDA wm_CapeXPos+1
	ADC #$00
	CMP #$02
	BCS Return0295AD
	STA m2
	STA wm_BlockYPos+1
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
	BRA _02960D

Return0295AD:
	RTS

CODE_0295AE:
	LDA wm_CapeYPos
	CLC
	ADC DATA_02953C,Y
	AND #$F0
	STA m0
	STA wm_BlockXPos
	LDA wm_CapeYPos+1
	ADC #$00
	CMP #$02
	BCS Return0295AD
	STA m2
	STA wm_BlockXPos+1
	LDA wm_CapeXPos
	CLC
	ADC DATA_02953E,Y
	STA m1
	STA wm_BlockYPos
	LDA wm_CapeXPos+1
	ADC #$00
	CMP wm_ScreensInLvl
	BCS Return0295AD
	STA m3
	STA wm_BlockYPos+1
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
_02960D:
	LDA #$7E
	STA m7
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	JSL CODE_00F545
	CMP #$00
	BEQ +
	LDA m15
	STA wm_LayerInProcess
	LDA wm_Map16NumLo
	LDY #$00
	JSL _00F160
+	RTS

CODE_029631:
	LDX #$07
-	STX wm_SprProcessIndex
	LDA wm_ExSpriteNum,X
	CMP #$02
	BCC +
	JSR CODE_02A519
	JSR CODE_029696
	JSL CheckForContact
	BCC +
	LDA wm_ExSpriteNum,X
	CMP #$12
	BEQ +
	JSR _02A4DE
+	DEX
	BPL -
	RTS

DATA_029657:	.DB $FC,$E0

DATA_029658:	.DB $FF,$FF

DATA_02965A:	.DB $18,$50

DATA_02965C:	.DB $FC,$F8

DATA_02965E:	.DB $FF,$FF

DATA_029660:	.DB $18,$10

CODE_029663:
	PHX
	LDA wm_BouncBlkStatus,Y
	TAX
	LDA wm_BounceSprInterXLo,Y
	CLC
	ADC.W DATA_029657-1,X
	STA m0
	LDA wm_BounceSprInterXHi,Y
	ADC.W DATA_029658-1,X
	STA m8
	LDA.W DATA_02965A-1,X
	STA m2
	LDA wm_BounceSprInterYLo,Y
	CLC
	ADC.W DATA_02965C-1,X
	STA m1
	LDA wm_BounceSprInterYHi,Y
	ADC.W DATA_02965E-1,X
	STA m9
	LDA.W DATA_029660-1,X
	STA m3
	PLX
	RTS

CODE_029696:
	LDA wm_CapeXPos
	SEC
	SBC #$02
	STA m0
	LDA wm_CapeXPos+1
	SBC #$00
	STA m8
	LDA #$14
	STA m2
	LDA wm_CapeYPos
	STA m1
	LDA wm_CapeYPos+1
	STA m9
	LDA #$10
	STA m3
	RTS

DATA_0296B8:	.DB $20,$24,$28,$2C

DATA_0296BC:	.DB $90,$94,$98,$9C

CODE_0296C0:
	LDA wm_SmokeSprite,X
	BEQ Return0296D7
	AND #$7F
	JSL ExecutePtr

Ptrs0296CB:
	.DW Return0296D7
	.DW CODE_0296E3
	.DW CODE_029797
	.DW CODE_029927
	.DW Return0296D7
	.DW CODE_0298CA

Return0296D7:
	RTS

DATA_0296D8:	.DB $66,$66,$64,$62,$60,$62,$60

CODE_0296DF:
	STZ wm_SmokeSprite,X
	RTS

CODE_0296E3:
	LDA wm_SmokeTimer,X
	BEQ CODE_0296DF
	LDA wm_SmokeSprite,X
	BMI +
	LDA wm_SpritesLocked
	BNE ++
+	DEC wm_SmokeTimer,X
++	LDA wm_SpriteNum+7
	CMP #$A9
	BEQ CODE_02974A
	LDA wm_LevelMode
	AND #$40
	BEQ CODE_02974A
	LDY.W DATA_0296BC,X
	LDA wm_SmokeXPos,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F4
	BCS CODE_0296DF
	STA wm_OamSlot.1.XPos,Y
	LDA wm_SmokeYPos,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$E0
	BCS CODE_0296DF
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SmokeTimer,X
	CMP #$08
	LDA #$00
	BCS +
	ASL
	ASL
	ASL
	ASL
	AND #$40
+	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA wm_SmokeTimer,X
	PHY
	LSR
	LSR
	TAY
	LDA DATA_0296D8,Y
	PLY
	STA wm_OamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	RTS

CODE_02974A:
	LDY.W DATA_0296B8,X
	LDA wm_SmokeXPos,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F4
	BCS CODE_029793
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_SmokeYPos,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$E0
	BCS CODE_029793
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_SmokeTimer,X
	CMP #$08
	LDA #$00
	BCS +
	ASL
	ASL
	ASL
	ASL
	AND #$40
+	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	LDA wm_SmokeTimer,X
	PHY
	LSR
	LSR
	TAY
	LDA DATA_0296D8,Y
	PLY
	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	RTS

CODE_029793:
	STZ wm_SmokeSprite,X
	RTS

CODE_029797:
	LDA wm_SmokeTimer,X
	BEQ CODE_029793
	LDY wm_SpritesLocked
	BNE +
	DEC wm_SmokeTimer,X
+	BIT wm_LevelMode
	BVC CODE_0297B2
	LDA wm_LevelMode
	CMP #$C1
	BEQ CODE_0297B2
	JMP CODE_029838

CODE_0297B2:
	LDY #$F0
	LDA wm_SmokeXPos,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F0
	BCS CODE_029793
	STA wm_ExOamSlot.1.XPos,Y
	STA wm_ExOamSlot.3.XPos,Y
	CLC
	ADC #$08
	STA wm_ExOamSlot.2.XPos,Y
	STA wm_ExOamSlot.4.XPos,Y
	LDA wm_SmokeYPos,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_ExOamSlot.1.YPos,Y
	STA wm_ExOamSlot.2.YPos,Y
	CLC
	ADC #$08
	STA wm_ExOamSlot.3.YPos,Y
	STA wm_ExOamSlot.4.YPos,Y
	LDA wm_SmokeTimer,X
	ASL
	ASL
	ASL
	ASL
	ASL
	AND #$40
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	STA wm_ExOamSlot.2.Prop,Y
	EOR #$C0
	STA wm_ExOamSlot.3.Prop,Y
	STA wm_ExOamSlot.4.Prop,Y
	LDA wm_SmokeTimer,X
	AND #$02
	BNE CODE_029815
	LDA #$7C
	STA wm_ExOamSlot.1.Tile,Y
	STA wm_ExOamSlot.4.Tile,Y
	LDA #$7D
	STA wm_ExOamSlot.2.Tile,Y
	STA wm_ExOamSlot.3.Tile,Y
	BRA _029825

CODE_029815:
	LDA #$7D
	STA wm_ExOamSlot.1.Tile,Y
	STA wm_ExOamSlot.4.Tile,Y
	LDA #$7C
	STA wm_ExOamSlot.2.Tile,Y
	STA wm_ExOamSlot.3.Tile,Y
_029825:
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	STA wm_ExOamSize.2,Y
	STA wm_ExOamSize.3,Y
	STA wm_ExOamSize.4,Y
	RTS

CODE_029838:
	LDY #$90
	LDA wm_SmokeXPos,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F0
	BCS CODE_0298BE
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.3.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.2.XPos,Y
	STA wm_OamSlot.4.XPos,Y
	LDA wm_SmokeYPos,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.3.YPos,Y
	STA wm_OamSlot.4.YPos,Y
	LDA wm_SmokeTimer,X
	ASL
	ASL
	ASL
	ASL
	ASL
	AND #$40
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	EOR #$C0
	STA wm_OamSlot.3.Prop,Y
	STA wm_OamSlot.4.Prop,Y
	LDA wm_SmokeTimer,X
	AND #$02
	BNE CODE_02989B
	LDA #$7C
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.4.Tile,Y
	LDA #$7D
	STA wm_OamSlot.2.Tile,Y
	STA wm_OamSlot.3.Tile,Y
	BRA _0298AB

CODE_02989B:
	LDA #$7D
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.4.Tile,Y
	LDA #$7C
	STA wm_OamSlot.2.Tile,Y
	STA wm_OamSlot.3.Tile,Y
_0298AB:
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	STA wm_OamSize.3,Y
	STA wm_OamSize.4,Y
	RTS

CODE_0298BE:
	STZ wm_SmokeSprite,X
	RTS

DATA_0298C2:	.DB $04,$08,$04,$00

DATA_0298C6:	.DB $FC,$04,$0C,$04

CODE_0298CA:
	LDA wm_SmokeTimer,X
	BEQ CODE_0298BE
	LDY wm_SpritesLocked
	BNE +++
	DEC wm_SmokeTimer,X
	AND #$03
	BNE +++
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
++	LDA #$02
	STA wm_MExSprNum,Y
	LDA wm_SmokeYPos,X
	STA m1
	LDA wm_SmokeXPos,X
	STA m0
	LDA wm_SmokeTimer,X
	LSR
	LSR
	AND #$03
	PHX
	TAX
	LDA.W DATA_0298C2,X
	CLC
	ADC m0
	STA wm_MExSprXLo,Y
	LDA.W DATA_0298C6,X
	CLC
	ADC m1
	STA wm_MExSprYLo,Y
	PLX
	LDA #$17
	STA wm_MExSprTimer,Y
+++	RTS

DATA_029922:	.DB $66,$66,$64,$62,$62

CODE_029927:
	LDA wm_SmokeTimer,X
	BNE CODE_029941
	BIT wm_LevelMode
	BVC +
	LDA wm_ReznorSmokeFlag
	BNE +
	LDY.W DATA_0296BC,X
	LDA #$F0
	STA wm_OamSlot.1.YPos,Y
+	JMP CODE_029793

CODE_029941:
	LDY wm_SpritesLocked
	BNE +
	DEC wm_SmokeTimer,X
	AND #$07
	BNE +
	DEC wm_SmokeYPos,X
+	LDA wm_SpriteNum+7
	CMP #$A9
	BEQ CODE_02996C
	LDA wm_ReznorSmokeFlag
	BNE CODE_02996C
	LDA wm_LevelMode
	BPL CODE_02996C
	CMP #$C1
	BEQ +
	AND #$40
	BNE CODE_02999F
+	LDY.W DATA_0296BC,X
	BRA _02996F

CODE_02996C:
	LDY.W DATA_0296B8,X
_02996F:
	LDA wm_SmokeXPos,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_SmokeYPos,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	LDA wm_SmokeTimer,X
	LSR
	LSR
	TAX
	LDA.W DATA_029922,X
	LDX wm_ExSprIndexM
	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

CODE_02999F:
	LDY.W DATA_0296BC,X
	LDA wm_SmokeXPos,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	LDA wm_SmokeYPos,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA wm_SmokeTimer,X
	LSR
	LSR
	TAX
	LDA.W DATA_029922,X
	LDX wm_ExSprIndexM
	STA wm_OamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	RTS

CODE_0299D2:
	LDX #$03
-	STX wm_SprProcessIndex
	LDA wm_SpinCoinSlot,X
	BEQ +
	JSR CODE_0299F1
+	DEX
	BPL -
	RTS

CODE_0299E3:
	LDA #$00
	STA wm_SpinCoinSlot,X
	RTS

DATA_0299E9:	.DB $30,$38,$40,$48,$EC,$EA,$E8,$EC

CODE_0299F1:
	LDA wm_SpritesLocked
	BNE CODE_029A08
	JSR CODE_02B58E
	LDA wm_SpinCoinYSpeed,X
	CLC
	ADC #$03
	STA wm_SpinCoinYSpeed,X
	CMP #$20
	BMI CODE_029A08
	JMP CODE_029AA8

CODE_029A08:
	LDA wm_SpinCoinTbl,X
	ASL
	ASL
	TAY
	LDA.W wm_Bg1VOfs,Y
	STA m2
	LDA.W wm_Bg1HOfs,Y
	STA m3
	LDA.W wm_Bg1VOfs+1,Y
	STA m4
	LDA wm_SpinCoinYLo,X
	CMP m2
	LDA wm_SpinCoinYHi,X
	SBC m4
	BNE +
	LDA wm_SpinCoinXLo,X
	SEC
	SBC m3
	CMP #$F8
	BCS CODE_0299E3
	STA m0
	LDA wm_SpinCoinYLo,X
	SEC
	SBC m2
	STA m1
	LDY.W DATA_0299E9,X
	STY m15
	LDY m15
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA m1
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$E8
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$04
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	TXA
	CLC
	ADC wm_FrameB
	LSR
	LSR
	AND #$03
	BNE CODE_029A71
+	RTS

RollingCoinTiles:	.DB $EA,$FA,$EA

CODE_029A71:
	LDY m15
	PHX
	TAX
	LDA m0
	CLC
	ADC #$04
	STA wm_ExOamSlot.1.XPos,Y
	STA wm_ExOamSlot.2.XPos,Y
	LDA m1
	CLC
	ADC #$08
	STA wm_ExOamSlot.2.YPos,Y
	LDA.L RollingCoinTiles-1,X
	STA wm_ExOamSlot.1.Tile,Y
	STA wm_ExOamSlot.2.Tile,Y
	LDA wm_ExOamSlot.1.Prop,Y
	ORA #$80
	STA wm_ExOamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	STA wm_ExOamSize.2,Y
	PLX
	RTS

CODE_029AA8:
	JSL CODE_02AD34
	LDA #$01
	STA wm_ScoreSprNum,Y
	LDA wm_SpinCoinYLo,X
	STA wm_ScoreSprYLo,Y
	LDA wm_SpinCoinYHi,X
	STA wm_ScoreSprYHi,Y
	LDA wm_SpinCoinXLo,X
	STA wm_ScoreSprXLo,Y
	LDA wm_SpinCoinXHi,X
	STA wm_ScoreSprXHi,Y
	LDA #$30
	STA wm_ScoreSprSpeedY,Y
	LDA wm_SpinCoinTbl,X
	STA wm_ScoreSprLayer,Y
	JSR CODE_029ADA
	JMP CODE_0299E3

CODE_029ADA:
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_029AE5
	DEY
	BPL -
	RTS

CODE_029AE5:
	LDA #$05
	STA wm_SmokeSprite,Y
	LDA wm_SpinCoinTbl,X
	LSR
	PHP
	LDA wm_SpinCoinXLo,X
	BCC +
	SBC wm_26
+	STA wm_SmokeXPos,Y
	LDA wm_SpinCoinYLo,X
	PLP
	BCC +
	SBC wm_28
+	STA wm_SmokeYPos,Y
	LDA #$10
	STA wm_SmokeTimer,Y
	RTS

CODE_029B0A:
	LDX #$09
-	STX wm_SprProcessIndex
	JSR CODE_029B16
	DEX
	BPL -
_Return029B15:
	RTS

CODE_029B16:
	LDA wm_ExSpriteNum,X
	BEQ _Return029B15
	LDY wm_SpritesLocked
	BNE +
	LDY wm_ExSpriteTbl2,X
	BEQ +
	DEC wm_ExSpriteTbl2,X
+	JSL ExecutePtr

ExtendedSpritePtrs:
	.DW _Return029B15
	.DW SmokePuff
	.DW ReznorFireball
	.DW FlameRemnant
	.DW Hammer
	.DW MarioFireball
	.DW Baseball
	.DW LavaSplash
	.DW LauncherArm
	.DW UnusedExtendedSpr
	.DW CloudCoin
	.DW Hammer
	.DW VolcanoLotusFire
	.DW Baseball
	.DW CloudCoin
	.DW SmokeTrail
	.DW SpinJumpStars
	.DW YoshiFireball
	.DW WaterBubble

VolcanoLotusFire:
	LDY.W DATA_02A153,X
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_ExSpriteXHi,X
	SBC wm_Bg1HOfs+1
	BNE CODE_029BDA
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_ExSpriteYHi,X
	SBC wm_Bg1VOfs+1
	BEQ CODE_029B76
	BMI _029BA5
	BPL CODE_029BDA ; [BRA FIX]

CODE_029B76:
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA m1
	CMP #$F0
	BCS _029BA5
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$09
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	LDA wm_FrameB
	LSR
	EOR wm_SprProcessIndex
	LSR
	LSR
	LDA #$A6
	BCC +
	LDA #$B6
+	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
_029BA5:
	LDA wm_SpritesLocked
	BNE ++
	JSR CODE_02A3F6
	JSR CODE_02B554
	JSR CODE_02B560
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_ExSprSpeedY,X
	CMP #$18
	BPL +
	INC wm_ExSprSpeedY,X
+	LDA wm_ExSprSpeedY,X
	BMI ++
	TXA
	ASL
	ASL
	ASL
	ADC wm_FrameA
	LDY #$08
	AND #$08
	BNE +
	LDY #$F8
+	TYA
	STA wm_ExSprSpeedX,X
++	RTS

CODE_029BDA:
	STZ wm_ExSpriteNum,X
	RTS

DATA_029BDE:	.DB $08,$F8

DATA_029BE0:	.DB $00,$FF

DATA_029BE2:	.DB $18,$E8

CODE_029BE4:
	LDA #$05
	STA wm_ShakeGrndTimer
	LDA #$09
	STA wm_SoundCh3
	STZ m0
	JSR _029BF5
	INC m0
_029BF5:
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_029C00
	DEY
	BPL -
	RTS

CODE_029C00:
	LDA #$0F
	STA wm_ExSpriteNum,Y
	LDA wm_MarioYPos
	CLC
	ADC #$28
	STA wm_ExSpriteYLo,Y
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_ExSpriteYHi,Y
	LDX m0
	LDA wm_MarioXPos
	CLC
	ADC.W DATA_029BDE,X
	STA wm_ExSpriteXLo,Y
	LDA wm_MarioXPos+1
	ADC.W DATA_029BE0,X
	STA wm_ExSpriteXHi,Y
	LDA.W DATA_029BE2,X
	STA wm_ExSprSpeedX,Y
	LDA #$15
	STA wm_ExSpriteTbl2,Y
	RTS

SmokeTrailTiles:
	.DB $66,$64,$62,$60,$60,$60,$60,$60
	.DB $60,$60,$60

SmokeTrail:
	JSR CODE_02A1A4
	LDY.W DATA_02A153,X
	LDA wm_ExSpriteTbl2,X
	LSR
	PHX
	TAX
	LDA wm_FrameB
	ASL
	ASL
	ASL
	ASL
	AND #$C0
	ORA #$32
	STA wm_ExOamSlot.1.Prop,Y
	LDA.W SmokeTrailTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	PLX
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_ExSpriteTbl2,X
	BEQ CODE_029C7F
	CMP #$06
	BNE +
	LDA wm_ExSprSpeedX,X
	ASL
	ROR wm_ExSprSpeedX,X
+	JSR CODE_02B554
++	RTS

CODE_029C7F:
	STZ wm_ExSpriteNum,X
	RTS

SpinJumpStars:
	LDA wm_ExSpriteTbl2,X
	BEQ CODE_029C7F
	JSR CODE_02A1A4
	LDY.W DATA_02A153,X
	LDA #$34
	STA wm_ExOamSlot.1.Prop,Y
	LDA #$EF
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_SpritesLocked
	BNE +
	LDA wm_ExSpriteTbl2,X
	LSR
	LSR
	TAY
	LDA wm_FrameA
	AND DATA_029CB0,Y
	BNE +
	JSR CODE_02B554
	JSR CODE_02B560
+	RTS

DATA_029CB0:	.DB $FF,$07,$01,$00,$00

CloudCoin:
	LDA wm_SpritesLocked
	BNE _029CF8
	JSR CODE_02B560
	LDA wm_ExSprSpeedY,X
	CMP #$30
	BPL +
	CLC
	ADC #$02
	STA wm_ExSprSpeedY,X
+	LDA wm_ExSpriteNum,X
	CMP #$0E
	BNE ADDR_029CE3
	LDY #$08
	LDA wm_FrameB
	AND #$08
	BEQ +
	LDY #$F8
+	TYA
	STA wm_ExSprSpeedX,X
	JSR CODE_02B554
	BRA _029CF8

ADDR_029CE3:
	LDA wm_ExSpriteTbl1,X
	BNE +
	JSR CODE_02A56E
	BCC +
	LDA #$D0
	STA wm_ExSprSpeedY,X
	INC wm_ExSpriteTbl1,X
+	JSR CODE_02A3F6
_029CF8:
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS CODE_029D5A
	STA m1
	LDA wm_ExSpriteXLo,X
	CMP wm_Bg1HOfs
	LDA wm_ExSpriteXHi,X
	SBC wm_Bg1HOfs+1
	BNE _Return029D5D
	LDY.W DATA_02A153,X
	STY m15
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExSpriteNum,X
	CMP #$0E
	BNE ADDR_029D45
	LDA m1
	SEC
	SBC #$05
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$98
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$0B
_029D36:
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

ADDR_029D45:
	LDA m1
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$C2
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$04
	JSR _029D36
	LDA #$02
	STA wm_ExOamSize.1,Y
	RTS

CODE_029D5A:
	STZ wm_ExSpriteNum,X
_Return029D5D:
	RTS

DATA_029D5E:
	.DB $00,$01,$02,$03,$02,$03,$02,$03
	.DB $03,$02,$03,$02,$03,$02,$01,$00

UnusedExSprDispX:
	.DB $10,$F8,$03,$10,$F8,$03,$10,$F0
	.DB $FF,$10,$F0,$FF

UnusedExSprDispY:
	.DB $02,$02,$EE,$02,$02,$EE,$FE,$FE
	.DB $E6,$FE,$FE,$E6

UnusedExSprTiles:
	.DB $B3,$B3,$B1,$B2,$B2,$B0,$8E,$8E
	.DB $A8,$8C,$8C,$88

UnusedExSprGfxProp:	.DB $69,$29,$29

UnusedExSprTileSize:	.DB $00,$00,$02,$02

ADDR_029D99:
	STZ wm_ExSpriteNum,X
	RTS

UnusedExtendedSpr:
	JSR CODE_02A3F6
	LDY wm_ExSprSpeedX,X
	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE ADDR_029D99
	LDA wm_ExSpriteTbl2,X
	BEQ ADDR_029D99
	LSR
	LSR
	NOP
	NOP
	TAY
	LDA DATA_029D5E,Y
	STA m15
	ASL
	ADC m15
	STA m2
	LDA wm_ExSpriteTbl1,X
	CLC
	ADC m2
	TAY
	STY m3
	LDA wm_ExSpriteXLo,X
	CLC
	ADC UnusedExSprDispX,Y
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_ExSpriteYLo,X
	CLC
	ADC UnusedExSprDispY,Y
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDY.W DATA_02A153,X
	CMP #$F0
	BCS CODE_029E39
	STA wm_ExOamSlot.1.YPos,Y
	LDA m0
	CMP #$10
	BCC CODE_029E39
	CMP #$F0
	BCS CODE_029E39
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExSpriteTbl1,X
	TAX
	LDA.W UnusedExSprGfxProp,X
	STA wm_ExOamSlot.1.Prop,Y
	LDX m3
	LDA.W UnusedExSprTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDX m15
	LDA.W UnusedExSprTileSize,X
	STA wm_ExOamSize.1,Y
	LDX wm_SprProcessIndex
	LDA m0
	SEC
	SBC wm_MarioScrPosX
	CLC
	ADC #$04
	CMP #$08
	BCS Return029E35
	LDA m1
	SEC
	SBC wm_MarioScrPosY
	SEC
	SBC #$10
	CLC
	ADC #$10
	CMP #$10
	BCS Return029E35
	JMP CODE_02A469

Return029E35:
	RTS

DATA_029E36:	.DB $08,$00,$F8

CODE_029E39:
	STZ wm_ExSpriteNum,X
	RTS

LauncherArm:
	LDY #$00
	LDA wm_ExSpriteTbl2,X
	BEQ CODE_029E39
	CMP #$60
	BCS +
	INY
	CMP #$30
	BCS +
	INY
+	PHY
	LDA wm_SpritesLocked
	BNE +
	LDA DATA_029E36,Y
	STA wm_ExSprSpeedY,X
	JSR CODE_02B560
+	JSR CODE_02A1A4
	LDY.W DATA_02A153,X
	PLA
	CMP #$01
	LDA #$84
	BCC +
	LDA #$A4
+	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_ExOamSlot.1.Prop,Y
	AND #$00
	ORA #$13
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	RTS

LavaSplashTiles2:	.DB $D7,$C7,$D6,$C6

LavaSplash:
	LDA wm_SpritesLocked
	BNE +
	JSR CODE_02B554
	JSR CODE_02B560
	LDA wm_ExSprSpeedY,X
	CLC
	ADC #$02
	STA wm_ExSprSpeedY,X
	CMP #$30
	BPL CODE_029EE6
+	LDY.W DATA_02A153,X
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_ExSpriteXHi,X
	SBC wm_Bg1HOfs+1
	BNE CODE_029EE6
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS CODE_029EE6
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_ExSpriteTbl2,X
	LSR
	LSR
	LSR
	NOP
	NOP
	AND #$03
	TAX
	LDA.W LavaSplashTiles2,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA #$05
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	LDX wm_SprProcessIndex
	RTS

CODE_029EE6:
	STZ wm_ExSpriteNum,X
	RTS

DATA_029EEA:	.DB $00,$01,$00,$FF

WaterBubble:
	LDA wm_SpritesLocked
	BNE CODE_029F2A
	INC wm_ExSpriteTbl1,X
	LDA wm_ExSpriteTbl1,X
	AND #$30
	BEQ +
	DEC wm_ExSpriteYLo,X
	LDY wm_ExSpriteYLo,X
	INY
	BNE +
	DEC wm_ExSpriteYHi,X
+	TXA
	EOR wm_FrameA
	LSR
	BCS CODE_029F2A
	JSR CODE_02A56E
	BCS _029F27
	LDA wm_IsWaterLevel
	BNE CODE_029F2A
	LDA m12
	CMP #$06
	BCC CODE_029F2A
	LDA m15
	BEQ _029F27
	LDA m13
	CMP #$06
	BCC CODE_029F2A
_029F27:
	JMP CODE_02A211

CODE_029F2A:
	LDA wm_ExSpriteYLo,X
	CMP wm_Bg1VOfs
	LDA wm_ExSpriteYHi,X
	SBC wm_Bg1VOfs+1
	BNE _029F27
	JSR CODE_02A1A4
	LDA wm_ExSpriteTbl1,X
	AND #$0C
	LSR
	LSR
	TAY
	LDA DATA_029EEA,Y
	STA m0
	LDY.W DATA_02A153,X
	LDA wm_ExOamSlot.1.XPos,Y
	CLC
	ADC m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExOamSlot.1.YPos,Y
	CLC
	ADC #$05
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$1C
	STA wm_ExOamSlot.1.Tile,Y
	RTS

YoshiFireball:
	LDA wm_SpritesLocked
	BNE +
	JSR CODE_02B554
	JSR CODE_02B560
	JSR ProcessFireball
+	JSR CODE_02A1A4
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LDY.W DATA_02A153,X
	LDA #$04
	BCC +
	LDA #$2B
+	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_ExSprSpeedX,X
	AND #$80
	EOR #$80
	LSR
	ORA #$35
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	RTS

DATA_029F99:
	.DB $00,$B8,$C0,$C8,$D0,$D8,$E0,$E8
	.DB $F0

DATA_029FA2:	.DB $00

DATA_029FA3:	.DB $05,$03

DATA_029FA5:
	.DB $02,$02,$02,$02,$02,$02,$F8,$FC
	.DB $A0,$A4

MarioFireball:
	LDA wm_SpritesLocked
	BNE _02A02C
	LDA wm_ExSpriteYLo,X
	CMP wm_Bg1VOfs
	LDA wm_ExSpriteYHi,X
	SBC wm_Bg1VOfs+1
	BEQ CODE_029FC2
	JMP CODE_02A211

CODE_029FC2:
	INC wm_ExSpriteTbl1,X
	JSR ProcessFireball
	LDA wm_ExSprSpeedY,X
	CMP #$30
	BPL +
	LDA wm_ExSprSpeedY,X
	CLC
	ADC #$04
	STA wm_ExSprSpeedY,X
+	JSR CODE_02A56E
	BCC CODE_02A010
	INC wm_ExSprAccX,X
	LDA wm_ExSprAccX,X
	CMP #$02
	BCS CODE_02A042
	LDA wm_ExSprSpeedX,X
	BPL +
	LDA m11
	EOR #$FF
	INC A
	STA m11
+	LDA m11
	CLC
	ADC #$04
	TAY
	LDA DATA_029F99,Y
	STA wm_ExSprSpeedY,X
	LDA wm_ExSpriteYLo,X
	SEC
	SBC DATA_029FA2,Y
	STA wm_ExSpriteYLo,X
	BCS +
	DEC wm_ExSpriteYHi,X
+	BRA _02A013

CODE_02A010:
	STZ wm_ExSprAccX,X
_02A013:
	LDY #$00
	LDA wm_ExSprSpeedX,X
	BPL +
	DEY
+	CLC
	ADC wm_ExSpriteXLo,X
	STA wm_ExSpriteXLo,X
	TYA
	ADC wm_ExSpriteXHi,X
	STA wm_ExSpriteXHi,X
	JSR CODE_02B560
_02A02C:
	LDA wm_SpriteNum+7
	CMP #$A9
	BEQ +
	LDA wm_LevelMode
	BPL +
	AND #$40
	BNE ADDR_02A04F
+	LDY.W DATA_029FA3,X
	JSR _02A1A7
	RTS

CODE_02A042:
	JSR _02A02C
_02A045:
	LDA #$01
	STA wm_SoundCh1
	LDA #$0F
	JMP _02A4E0

ADDR_02A04F:
	LDY.W DATA_029FA5,X
	LDA wm_ExSprSpeedX,X
	AND #$80
	LSR
	STA m0
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F8
	BCS ADDR_02A0A9
	STA wm_OamSlot.1.XPos,Y
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS ADDR_02A0A9
	STA wm_OamSlot.1.YPos,Y
	LDA wm_ExSprBehindTbl,X
	STA m1
	LDA wm_ExSpriteTbl1,X
	LSR
	LSR
	AND #$03
	TAX
	LDA.W FireballTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02A15F,X
	EOR m0
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDX m1
	BEQ +
	AND #$CF
	ORA #$10
	STA wm_OamSlot.1.Prop,Y
+	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	LDX wm_SprProcessIndex
_Return02A0A8:
	RTS

ADDR_02A0A9:
	JMP CODE_02A211

ProcessFireball:
	TXA
	EOR wm_FrameA
	AND #$03
	BNE _Return02A0A8
	PHX
	TXY
	STY wm_TempTileGen
	LDX #$09
_FireRtLoopStart:
	STX wm_SprProcessIndex
	LDA wm_SpriteStatus,X
	CMP #$08
	BCC _FireRtNextSprite
	LDA wm_Tweaker167A,X
	AND #$02
	ORA wm_SpriteEatenTbl,X
	ORA wm_SprBehindScrn,X
	EOR wm_ExSprBehindTbl,Y
	BNE _FireRtNextSprite
	JSL GetSpriteClippingA
	JSR CODE_02A547
	JSL CheckForContact
	BCC _FireRtNextSprite
	LDA wm_ExSpriteNum,Y
	CMP #$11
	BEQ +
	PHX
	TYX
	JSR _02A045
	PLX
+	LDA wm_Tweaker166E,X
	AND #$10
	BNE _FireRtNextSprite
	LDA wm_Tweaker190F,X
	AND #$08
	BEQ TurnSpriteToCoin
	INC wm_SpriteMiscTbl4,X
	LDA wm_SpriteMiscTbl4,X
	CMP #$05
	BCC _FireRtNextSprite
	LDA #$02
	STA wm_SoundCh1
	LDA #$02
	STA wm_SpriteStatus,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	JSR SubHorzPosBnk2
	LDA FireKillSpeedX,Y
	STA wm_SpriteSpeedX,X
	LDA #$04
	JSL GivePoints
	BRA _FireRtNextSprite

TurnSpriteToCoin:
	LDA #$03
	STA wm_SoundCh1
	LDA #$21
	STA wm_SpriteNum,X
	LDA #$08
	STA wm_SpriteStatus,X
	JSL InitSpriteTables
	LDA #$D0
	STA wm_SpriteSpeedY,X
	JSR SubHorzPosBnk2
	TYA
	EOR #$01
	STA wm_SpriteDir,X
_FireRtNextSprite:
	LDY wm_TempTileGen
	DEX
	BMI CODE_02A14C
	JMP _FireRtLoopStart

CODE_02A14C:
	PLX
	STX wm_SprProcessIndex
	RTS

FireKillSpeedX:	.DB $F0,$10

DATA_02A153:	.DB $90,$94,$98,$9C,$A0,$A4,$A8,$AC

FireballTiles:	.DB $2C,$2D,$2C,$2D

DATA_02A15F:	.DB $04,$04,$C4,$C4

ReznorFireTiles:	.DB $26,$2A,$26,$2A

DATA_02A167:	.DB $35,$35,$F5,$F5

ReznorFireball:
	LDA wm_SpritesLocked
	BNE _02A178
	JSR CODE_02B554
	JSR CODE_02B560
	JSR CODE_02A3F6
_02A178:
	LDA wm_LevelMode
	BPL CODE_02A1A4
	JSR CODE_02A1A4
	LDY.W DATA_02A153,X
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	PHX
	TAX
	LDA.W ReznorFireTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA.W DATA_02A167,X
	EOR m0
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	PLX
	RTS

CODE_02A1A4:
	LDY.W DATA_02A153,X
_02A1A7:
	LDA wm_ExSprSpeedX,X
	AND #$80
	EOR #$80
	LSR
	STA m0
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m1
	LDA wm_ExSpriteXHi,X
	SBC wm_Bg1HOfs+1
	BNE CODE_02A211
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m2
	LDA wm_ExSpriteYHi,X
	SBC wm_Bg1VOfs+1
	BNE CODE_02A211
	LDA m2
	CMP #$F0
	BCS CODE_02A211
	STA wm_ExOamSlot.1.YPos,Y
	LDA m1
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExSprBehindTbl,X
	STA m1
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	TAX
	LDA.W FireballTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA.W DATA_02A15F,X
	EOR m0
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	LDX m1
	BEQ +
	AND #$CF
	ORA #$10
	STA wm_ExOamSlot.1.Prop,Y
+	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	LDX wm_SprProcessIndex
	RTS

CODE_02A211:
	LDA #$00
	STA wm_ExSpriteNum,X
	RTS

SmallFlameTiles:	.DB $AC,$AD

FlameRemnant:
	LDA wm_SpritesLocked
	BNE CODE_02A22F
	INC wm_ExSpriteTbl1,X
	LDA wm_ExSpriteTbl2,X
	BEQ CODE_02A211
	CMP #$50
	BCS CODE_02A22F
	AND #$01
	BNE _Return02A253
	BEQ _02A232 ; [BRA FIX]

CODE_02A22F:
	JSR CODE_02A3F6
_02A232:
	JSR CODE_02A1A4
	LDY.W DATA_02A153,X
	LDA wm_ExSpriteTbl1,X
	LSR
	LSR
	AND #$01
	TAX
	LDA.W SmallFlameTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_ExOamSlot.1.Prop,Y
	AND #$3F
	ORA #$05
	STA wm_ExOamSlot.1.Prop,Y
	LDX wm_SprProcessIndex
_Return02A253:
	RTS

Baseball:
	LDA wm_SpritesLocked
	BNE ++
	JSR CODE_02B554
	INC wm_ExSpriteTbl1,X
	LDA wm_FrameA
	AND #$01
	BNE +
	INC wm_ExSpriteTbl1,X
+	JSR CODE_02A3F6
++	LDA wm_ExSpriteNum,X
	CMP #$0D
	BNE CODE_02A2C3
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_ExSpriteXHi,X
	SBC wm_Bg1HOfs+1
	BEQ CODE_02A287
	EOR wm_ExSprSpeedX,X
	BPL CODE_02A2BF
	BMI _Return02A2BE ; [BRA FIX]

CODE_02A287:
	LDY.W DATA_02A153,X
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_ExSpriteYHi,X
	SBC wm_Bg1VOfs+1
	BNE CODE_02A2BF
	LDA m1
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$AD
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_FrameB
	ASL
	ASL
	ASL
	ASL
	AND #$C0
	ORA #$39
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
_Return02A2BE:
	RTS

CODE_02A2BF:
	STZ wm_ExSpriteNum,X
	RTS

CODE_02A2C3:
	JSR CODE_02A317
	LDA wm_ExOamSlot.1.Tile,Y
	CMP #$26
	LDA #$80
	BCS +
	LDA #$82
+	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_ExOamSlot.1.Prop,Y
	AND #$F1
	ORA #$02
	STA wm_ExOamSlot.1.Prop,Y
	RTS

HammerTiles:	.DB $08,$6D,$6D,$08,$08,$6D,$6D,$08

HammerGfxProp:	.DB $47,$47,$07,$07,$87,$87,$C7,$C7

Hammer:
	LDA wm_SpritesLocked
	BNE ++
	JSR CODE_02B554
	JSR CODE_02B560
	LDA wm_ExSprSpeedY,X
	CMP #$40
	BPL +
	INC wm_ExSprSpeedY,X
	INC wm_ExSprSpeedY,X
+	JSR CODE_02A3F6
	INC wm_ExSpriteTbl1,X
++	LDA wm_ExSpriteNum,X
	CMP #$0B
	BNE CODE_02A317
	JSR _02A178
	RTS

CODE_02A317:
	JSR CODE_02A1A4
	LDY.W DATA_02A153,X
	LDA wm_ExSpriteTbl1,X
	LSR
	LSR
	LSR
	AND #$07
	PHX
	TAX
	LDA.W HammerTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA.W HammerGfxProp,X
	EOR m0
	EOR #$40
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	PLX
	RTS

CODE_02A344:
	JMP CODE_02A211

DustCloudTiles:	.DB $66,$64,$60,$62

DATA_02A34B:	.DB $00,$40,$C0,$80

SmokePuff:
	LDA wm_ExSpriteTbl2,X
	BEQ CODE_02A344
	LDA wm_ReznorSmokeFlag
	BNE +
	LDA wm_LevelMode
	BPL +
	AND #$40
	BNE ADDR_02A3B1
+	LDY.W DATA_02A153,X
	CPX #$08
	BCC +
	LDY.W DATA_029FA3,X
+	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F8
	BCS CODE_02A3AE
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS CODE_02A3AE
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_ExSpriteTbl2,X
	LSR
	LSR
	TAX
	LDA.W DustCloudTiles,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	TAX
	LDA.W DATA_02A34B,X
	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	LDX wm_SprProcessIndex
	RTS

CODE_02A3AE:
	JMP CODE_02A211

ADDR_02A3B1:
	LDY.W DATA_029FA5,X
	LDA wm_ExSpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$F8
	BCS CODE_02A3AE
	STA wm_OamSlot.1.XPos,Y
	LDA wm_ExSpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS CODE_02A3AE
	STA wm_OamSlot.1.YPos,Y
	LDA wm_ExSpriteTbl2,X
	LSR
	LSR
	TAX
	LDA.W DustCloudTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	TAX
	LDA.W DATA_02A34B,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDX wm_SprProcessIndex
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	RTS

CODE_02A3F6:
	LDA wm_IsBehindScenery
	EOR wm_ExSprBehindTbl,X
	BNE ++
	JSL GetMarioClipping
	JSR CODE_02A519
	JSL CheckForContact
	BCC ++
	LDA wm_ExSpriteNum,X
	CMP #$0A
	BNE CODE_02A469
	JSL CODE_05B34A
	INC wm_CoinGameCoins
	STZ wm_ExSpriteNum,X
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ +
	DEY
	BPL -
	INY
+	LDA #$05
	STA wm_SmokeSprite,Y
	LDA wm_ExSpriteXLo,X
	STA wm_SmokeXPos,Y
	LDA wm_ExSpriteYLo,X
	STA wm_SmokeYPos,Y
	LDA #$0A
	STA wm_SmokeTimer,Y
	JSL CODE_02AD34
	LDA #$05
	STA wm_ScoreSprNum,Y
	LDA wm_ExSpriteYLo,X
	STA wm_ScoreSprYLo,Y
	LDA wm_ExSpriteYHi,X
	STA wm_ScoreSprYHi,Y
	LDA wm_ExSpriteXLo,X
	STA wm_ScoreSprXLo,Y
	LDA wm_ExSpriteXHi,X
	STA wm_ScoreSprXHi,Y
	LDA #$30
	STA wm_ScoreSprSpeedY,Y
	LDA #$00
	STA wm_ScoreSprLayer,Y
++	RTS

CODE_02A469:
	LDA wm_StarPowerTimer
	BNE CODE_02A4B5
	LDA wm_OnYoshi
	BEQ CODE_02A4AE
_02A473:
	PHX
	LDX wm_YoshiSlot
	LDA #$10
	STA wm_SprBehindScrn.Spr12,X
	LDA #$03
	STA wm_SoundCh2
	LDA #$13
	STA wm_SoundCh3
	LDA #$02
	STA wm_SpriteSpeedX+11,X
	STZ wm_OnYoshi
	STZ wm_OWHasYoshi
	LDA #$C0
	STA wm_MarioSpeedY
	STZ wm_MarioSpeedX
	LDY wm_SpriteMiscTbl6.Spr12,X
	LDA DATA_02A4B3,Y
	STA wm_SpriteSpeedY+11,X
	STZ wm_SprObjStatus.Spr12,X
	STZ wm_SpriteMiscTbl2.Spr12,X
	STZ wm_YoshiWhipTimer
	LDA #$30
	STA wm_PlayerHurtTimer
	PLX
	RTS

CODE_02A4AE:
	JSL HurtMario
	RTS

DATA_02A4B3:	.DB $10,$F0

CODE_02A4B5:
	LDA wm_ExSpriteNum,X
	CMP #$04
	BEQ _02A4DE
	LDA wm_ExSpriteXLo,X
	SEC
	SBC #$04
	STA wm_ExSpriteXLo,X
	LDA wm_ExSpriteXHi,X
	SBC #$00
	STA wm_ExSpriteXHi,X
	LDA wm_ExSpriteYLo,X
	SEC
	SBC #$04
	STA wm_ExSpriteYLo,X
	LDA wm_ExSpriteYHi,X
	SBC #$00
	STA wm_ExSpriteYHi,X
_02A4DE:
	LDA #$07
_02A4E0:
	STA wm_ExSpriteTbl2,X
	LDA #$01
	STA wm_ExSpriteNum,X
	RTS

DATA_02A4E9:
	.DB $03,$03,$04,$03,$04,$00
	.DB $00,$00,$04,$03,$03,$03

DATA_02A4F3:
	.DB $03,$03,$04,$03,$04,$00
	.DB $00,$00,$02,$03,$03,$03

DATA_02A4FF:
	.DB $01,$01,$08,$01,$08,$00
	.DB $00,$0F,$08,$01,$01,$01

DATA_02A50B:
	.DB $01,$01,$08,$01,$08,$00
	.DB $00,$0F,$0C,$01,$01,$01

CODE_02A519:
	LDY wm_ExSpriteNum,X
	LDA wm_ExSpriteXLo,X
	CLC
	ADC DATA_02A4E9-2,Y
	STA m4
	LDA wm_ExSpriteXHi,X
	ADC #$00
	STA m10
	LDA DATA_02A4FF-2,Y
	STA m6
	LDA wm_ExSpriteYLo,X
	CLC
	ADC DATA_02A4F3-2,Y
	STA m5
	LDA wm_ExSpriteYHi,X
	ADC #$00
	STA m11
	LDA DATA_02A50B-2,Y
	STA m7
	RTS

CODE_02A547:
	LDA wm_ExSpriteXLo,Y
	SEC
	SBC #$02
	STA m0
	LDA wm_ExSpriteXHi,Y
	SBC #$00
	STA m8
	LDA #$0C
	STA m2
	LDA wm_ExSpriteYLo,Y
	SEC
	SBC #$04
	STA m1
	LDA wm_ExSpriteYHi,Y
	SBC #$00
	STA m9
	LDA #$13
	STA m3
	RTS

CODE_02A56E:
	STZ m15
	STZ m14
	STZ m11
	STZ wm_SprMoveDownPixels
	LDA wm_ReznorSmokeFlag
	BNE CODE_02A5BC
	LDA wm_LevelMode
	BPL CODE_02A5BC
	AND #$40
	BEQ CODE_02A592
	LDA wm_LevelMode
	CMP #$C1
	BEQ CODE_02A5BC
	LDA wm_ExSpriteYLo,X
	CMP #$A8
	RTS

CODE_02A592:
	LDA wm_ExSpriteXLo,X
	CLC
	ADC #$04
	STA wm_ChainCosX
	LDA wm_ExSpriteXHi,X
	ADC #$00
	STA wm_BowserHurtTimer
	LDA wm_ExSpriteYLo,X
	CLC
	ADC #$08
	STA wm_ChainSinY
	LDA wm_ExSpriteYHi,X
	ADC #$00
	STA wm_BowserFireX
	JSL CODE_01CC9D
	LDX wm_SprProcessIndex
	RTS

CODE_02A5BC:
	JSR CODE_02A611
	ROL m14
	LDA wm_Map16NumLo
	STA m12
	LDA wm_IsVerticalLvl
	BPL +
	INC m15
	LDA wm_ExSpriteXLo,X
	PHA
	CLC
	ADC wm_26
	STA wm_ExSpriteXLo,X
	LDA wm_ExSpriteXHi,X
	PHA
	ADC wm_27
	STA wm_ExSpriteXHi,X
	LDA wm_ExSpriteYLo,X
	PHA
	CLC
	ADC wm_28
	STA wm_ExSpriteYLo,X
	LDA wm_ExSpriteYHi,X
	PHA
	ADC wm_29
	STA wm_ExSpriteYHi,X
	JSR CODE_02A611
	ROL m14
	LDA wm_Map16NumLo
	STA m13
	PLA
	STA wm_ExSpriteYHi,X
	PLA
	STA wm_ExSpriteYLo,X
	PLA
	STA wm_ExSpriteXHi,X
	PLA
	STA wm_ExSpriteXLo,X
+	LDA m14
	CMP #$01
	RTS

CODE_02A611:
	LDA m15
	INC A
	AND wm_IsVerticalLvl
	BEQ CODE_02A679
	LDA wm_ExSpriteYLo,X
	CLC
	ADC #$08
	STA wm_BlockXPos
	AND #$F0
	STA m0
	LDA wm_ExSpriteYHi,X
	ADC #$00
	CMP wm_ScreensInLvl
	BCS CODE_02A677
	STA m3
	STA wm_BlockXPos+1
	LDA wm_ExSpriteXLo,X
	CLC
	ADC #$04
	STA m1
	STA wm_BlockYPos
	LDA wm_ExSpriteXHi,X
	ADC #$00
	CMP #$02
	BCS CODE_02A677
	STA m2
	STA wm_BlockYPos+1
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
	BRA _02A6DB

CODE_02A677:
	CLC
	RTS

CODE_02A679:
	LDA wm_ExSpriteYLo,X
	CLC
	ADC #$08
	STA wm_BlockXPos
	AND #$F0
	STA m0
	LDA wm_ExSpriteYHi,X
	ADC #$00
	STA m2
	STA wm_BlockXPos+1
	LDA m0
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCS CODE_02A677
	LDA wm_ExSpriteXLo,X
	CLC
	ADC #$04
	STA m1
	STA wm_BlockYPos
	LDA wm_ExSpriteXHi,X
	ADC #$00
	CMP wm_ScreensInLvl
	BCS CODE_02A677
	STA m3
	STA wm_BlockYPos+1
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
_02A6DB:
	LDA #$7E
	STA m7
	LDX wm_SprProcessIndex
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	JSL CODE_00F545
	CMP #$00
	BEQ CODE_02A729
	LDA wm_Map16NumLo
	CMP #$11
	BCC CODE_02A72B
	CMP #$6E
	BCC ++
	CMP #$D8
	BCS CODE_02A735
	LDY wm_BlockYPos
	STY m10
	LDY wm_BlockXPos
	STY m12
	JSL CODE_00FA19
	LDA m0
	CMP #$0C
	BCS +
	CMP [m5],Y
	BCC CODE_02A729
+	LDA [m5],Y
	STA wm_SprMoveDownPixels
	PHX
	LDX m8
	LDA.L DATA_00E53D,X
	PLX
	STA m11
++	SEC
	RTS

CODE_02A729:
	CLC
	RTS

CODE_02A72B:
	LDA wm_BlockXPos
	AND #$0F
	CMP #$06
	BCS CODE_02A729
	SEC
	RTS

CODE_02A735:
	LDA wm_BlockXPos
	AND #$0F
	CMP #$06
	BCS CODE_02A729
	LDA wm_ExSpriteYLo,X
	SEC
	SBC #$02
	STA wm_ExSpriteYLo,X
	LDA wm_ExSpriteYHi,X
	SBC #$00
	STA wm_ExSpriteYHi,X
	JMP CODE_02A611

CODE_02A751:
	PHB
	PHK
	PLB
	JSR CODE_02ABF2
	JSR CODE_02AC5C
	LDA wm_LevelMode
	BMI +
	JSL CODE_01808C
+	LDA wm_OWHasYoshi
	BEQ +
	LDA wm_DisableYoshiFlag
	BNE +
	JSL CODE_00FC7A
+	PLB
	RTL

SpriteSlotMax:
	.DB $09,$05,$07,$07,$07,$06,$07,$06
	.DB $06,$09,$08,$04,$07,$07,$07,$08
	.DB $09,$05,$05

SpriteSlotMax1:
	.DB $09,$07,$07,$01,$00,$01,$07,$06
	.DB $06,$00,$02,$00,$07,$01,$07,$08
	.DB $09,$07,$05

SpriteSlotMax2:
	.DB $09,$07,$07,$01,$00,$06,$07,$06
	.DB $06,$00,$02,$00,$07,$01,$07,$08
	.DB $09,$07,$05

SpriteSlotStart:
	.DB $FF,$FF,$00,$01,$00,$01,$FF,$01
	.DB $FF,$00,$FF,$00,$FF,$01,$FF,$FF
	.DB $FF,$FF,$FF

SpriteSlotStart1:
	.DB $FF,$05,$FF,$FF,$FF,$FF,$FF,$01
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$05,$FF

ReservedSprite1:
	.DB $FF,$5F,$54,$5E,$60,$28,$88,$FF
	.DB $FF,$C5,$86,$28,$FF,$90,$FF,$FF
	.DB $FF,$AE

ReservedSprite2:
	.DB $FF,$64,$FF,$FF,$9F,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$9F,$FF,$FF
	.DB $FF,$FF

DATA_02A7F6:	.DB $D0,$00,$20

DATA_02A7F9:	.DB $FF,$00,$01

LoadSprFromLevel:
	LDA wm_FrameA
	AND #$01
	BNE Return02A84B
_02A802:
	LDY wm_Layer1ScrollDir
	LDA wm_IsVerticalLvl
	LSR
	BCC CODE_02A817
	LDA wm_Bg1VOfs
	CLC
	ADC DATA_02A7F6,Y
	AND #$F0
	STA m0
	LDA wm_Bg1VOfs+1
	BRA _02A823

CODE_02A817:
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_02A7F6,Y
	AND #$F0
	STA m0
	LDA wm_Bg1HOfs+1
_02A823:
	ADC DATA_02A7F9,Y
	BMI Return02A84B
	STA m1
	LDX #$00
	LDY #$01
_LoadSpriteLoopStrt:
	LDA [wm_SprPtr],Y
	CMP #$FF
	BEQ Return02A84B
	ASL
	ASL
	ASL
	AND #$10
	STA m2
	INY
	LDA [wm_SprPtr],Y
	AND #$0F
	ORA m2
	CMP m1
	BCS CODE_02A84C
_LoadNextSprite:
	INY
	INY
	INX
	BRA _LoadSpriteLoopStrt

Return02A84B:
	RTS

CODE_02A84C:
	BNE Return02A84B
	LDA [wm_SprPtr],Y
	AND #$F0
	CMP m0
	BNE _LoadNextSprite
	LDA wm_SprLoadStatus,X
	BNE _LoadNextSprite
	STX m2
	INC wm_SprLoadStatus,X
	INY
	LDA [wm_SprPtr],Y
	STA m5
	DEY
	CMP #$E7
	BCC CODE_02A88C
	LDA wm_ScrollSprNum
	ORA wm_ScrollSprL2
	BNE +
	PHY
	PHX
	LDA m5
	SEC
	SBC #$E7
	STA wm_ScrollSprNum
	DEY
	LDA [wm_SprPtr],Y
	LSR
	LSR
	STA wm_InitYScrollL1
	JSL CODE_05BCD6
	PLX
	PLY
+	BRA _LoadNextSprite

CODE_02A88C:
	CMP #$DE
	BNE CODE_02A89C
	PHY
	PHX
	DEY
	STY m3
	JSR Load5Eeries
	PLX
	PLY
_02A89A:
	BRA _LoadNextSprite

CODE_02A89C:
	CMP #$E0
	BNE CODE_02A8AC
	PHY
	PHX
	DEY
	STY m3
	JSR Load3Platforms
	PLX
	PLY
	BRA _02A89A

CODE_02A8AC:
	CMP #$CB
	BCC CODE_02A8D4
	CMP #$DA
	BCS CODE_02A8C0
	SEC
	SBC #$CB
	INC A
	STA wm_GeneratorNum
	STZ wm_SprLoadStatus,X
	BRA _02A89A

CODE_02A8C0:
	CMP #$E1
	BCC CODE_02A8D0
	PHX
	PHY
	DEY
	STY m3
	JSR CODE_02AAC0
	PLY
	PLX
	BRA _02A89A

CODE_02A8D0:
	LDA #$09
	BRA _02A8DF

CODE_02A8D4:
	CMP #$C9
	BCC LoadNormalSprite
	JSR LoadShooter
	BRA _02A89A

LoadNormalSprite:
	LDA #$01
_02A8DF:
	STA m4
	DEY
	STY m3
	LDY wm_SpriteMemory
	LDX.W SpriteSlotMax,Y
	LDA SpriteSlotStart,Y
	STA m6
	LDA m5
	CMP ReservedSprite1,Y
	BNE +
	LDX.W SpriteSlotMax1,Y
	LDA SpriteSlotStart1,Y
	STA m6
+	LDA m5
	CMP ReservedSprite2,Y
	BNE ++
	CMP #$64
	BNE +
	LDA m0
	AND #$10
	BEQ ++
+	LDX.W SpriteSlotMax2,Y
	LDA #$FF
	STA m6
++	STX m15
-	LDA wm_SpriteStatus,X
	BEQ CODE_02A93C
	DEX
	CPX m6
	BNE -
	LDA m5
	CMP #$7B
	BNE +
	LDX m15
-	LDA wm_Tweaker167A,X
	AND #$02
	BEQ CODE_02A93C
	DEX
	CPX m6
	BNE -
+	LDX m2
	STZ wm_SprLoadStatus,X
	RTS

CODE_02A93C:
	LDY m3
	LDA wm_IsVerticalLvl
	LSR
	BCC CODE_02A95B
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA wm_SpriteXLo,X
	PLA
	AND #$0D
	STA wm_SpriteXHi,X
	LDA m0
	STA wm_SpriteYLo,X
	LDA m1
	STA wm_SpriteYHi,X
	BRA _02A971

CODE_02A95B:
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA wm_SpriteYLo,X
	PLA
	AND #$0D
	STA wm_SpriteYHi,X
	LDA m0
	STA wm_SpriteXLo,X
	LDA m1
	STA wm_SpriteXHi,X
_02A971:
	INY
	INY
	LDA m4
	STA wm_SpriteStatus,X
	CMP #$09
	LDA [wm_SprPtr],Y
	BCC +
	SEC
	SBC #$DA
	CLC
	ADC #$04
+	PHY
	LDY wm_MapData.OwLvFlags.Lv125
	BPL ++
	CMP #$04
	BNE +
	LDA #$07
+	CMP #$05
	BNE ++
	LDA #$06
++	STA wm_SpriteNum,X
	PLY
	LDA m2
	STA wm_SprIndexInLvl,X
	LDA wm_SilverPowTimer
	BEQ CODE_02A9C9
	PHX
	LDA wm_SpriteNum,X
	TAX
	LDA.L Sprite190FVals,X
	PLX
	AND #$40
	BNE CODE_02A9C9
	LDA #$21
	STA wm_SpriteNum,X
	LDA #$08
	STA wm_SpriteStatus,X
	JSL InitSpriteTables
	LDA wm_SpritePal,X
	AND #$F1
	ORA #$02
	STA wm_SpritePal,X
	BRA _02A9CD

CODE_02A9C9:
	JSL InitSpriteTables
_02A9CD:
	LDA #$01
	STA wm_OffscreenHorz,X
	LDA #$04
	STA wm_DisSprCapeContact,X
	INY
	LDX m2
	INX
	JMP _LoadSpriteLoopStrt

FindFreeSlotLowPri:
	LDA #$02
	STA m14
	BRA _02A9E6

FindFreeSprSlot:
	STZ m14
_02A9E6:
	PHB
	PHK
	PLB
	JSR FindFreeSlotRt
	PLB
	TYA
	RTL

FindFreeSlotRt:
	LDY wm_SpriteMemory
	LDA SpriteSlotStart,Y
	STA m15
	LDA SpriteSlotMax,Y
	SEC
	SBC m14
	TAY
-	LDA wm_SpriteStatus,Y
	BEQ +
	DEY
	CPY m15
	BNE -
	LDY #$FF
+	RTS

DATA_02AA0B:
	.DB $31,$71,$A1,$43,$93,$C3,$14,$65
	.DB $E5,$36,$A7,$39,$99,$F9,$1A,$7A
	.DB $DA,$4C,$AD,$ED

DATA_02AA1F:
	.DB $01,$51,$91,$D1,$22,$62,$A2,$73
	.DB $E3,$C7,$88,$29,$5A,$AA,$EB,$2C
	.DB $8C,$CC,$FC,$5D

ADDR_02AA33: ; unreachable
	LDX #$0E
-	STZ wm_ClusBooFrame1X,X
	STZ wm_ClusterSpriteTbl3,X
	LDA #$08
	STA wm_ClustSprNum,X
	JSL GetRand
	CLC
	ADC wm_Bg1HOfs
	STA wm_ClusterSprXLo,X
	STA wm_ClusterSpriteTbl1,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_ClusterSprXHi,X
	LDY m3
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA wm_ClusterSprYLo,X
	PLA
	AND #$01
	STA wm_ClusterSprYHi,X
	DEX
	BPL -
	RTS

DATA_02AA68:	.DB $50,$90,$D0,$10

CODE_02AA6C:
	LDA #$07
	STA wm_SpriteStatus.Spr4
	LDX #$03
-	LDA #$05
	STA wm_ClustSprNum,X
	LDA.W DATA_02AA68,X
	STA wm_ClusterSprXLo,X
	LDA #$F0
	STA wm_ClusterSprYLo,X
	TXA
	ASL
	ASL
	STA wm_ClusterSpriteTbl1,X
	DEX
	BPL -
	RTS

CODE_02AA8D:
	STZ wm_AppearBooCounter
	LDX #$13
-	LDA #$07
	STA wm_ClustSprNum,X
	LDA.W DATA_02AA0B,X
	PHA
	AND #$F0
	STA wm_ClusBooFrame1X,X
	PLA
	ASL
	ASL
	ASL
	ASL
	STA wm_ClusBooFrame1Y,X
	LDA.W DATA_02AA1F,X
	PHA
	AND #$F0
	STA wm_ClusBooFrame2X,X
	PLA
	ASL
	ASL
	ASL
	ASL
	STA wm_ClusBooFrame2Y,X
	DEX
	BPL -
	RTS

DATA_02AABD:	.DB $4C,$33,$AA

CODE_02AAC0:
	LDY #$01
	STY wm_AllowClusterSpr
	CMP #$E4
	BEQ DATA_02AABD
	CMP #$E6
	BEQ CODE_02AA6C
	CMP #$E5
	BEQ CODE_02AA8D
	CMP #$E2
	BCS CODE_02AB11
	LDX #$13
-	STZ wm_ClusBooFrame1X,X
	STZ wm_ClusterSpriteTbl3,X
	LDA #$03
	STA wm_ClustSprNum,X
	JSL GetRand
	CLC
	ADC wm_Bg1HOfs
	STA wm_ClusterSprXLo,X
	STA wm_ClusterSpriteTbl1,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_ClusterSprXHi,X
	LDA wm_RandomByte2
	AND #$3F
	ADC #$08
	CLC
	ADC wm_Bg1VOfs
	STA wm_ClusterSprYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_ClusterSprYHi,X
	DEX
	BPL -
	INC wm_BooRingAltIndex
	RTS

CODE_02AB11:
	LDY wm_BooRingAltIndex
	CPY #$02
	BCS +++
	LDY #$01
	CMP #$E2
	BEQ +
	LDY #$FF
+	STY m15
	LDA #$09
	STA m14
	LDX #$13
-	LDA wm_ClustSprNum,X
	BNE ++
	LDA #$04
	STA wm_ClustSprNum,X
	LDA wm_BooRingAltIndex
	STA wm_ClusterSpriteTbl3,X
	LDA m14
	STA wm_ClusterSpriteTbl2,X
	LDA m15
	STA wm_ClusterSpriteTbl1,X
	STZ m15
	BEQ +
	LDY m3
	LDA [wm_SprPtr],Y
	LDY wm_BooRingAltIndex
	PHA
	AND #$F0
	STA wm_BooRingYLo,Y
	PLA
	AND #$01
	STA wm_BooRingYHi,Y
	LDA m0
	STA wm_BooRingXLo,Y
	LDA m1
	STA wm_BooRingXHi,Y
	LDA #$00
	STA wm_BooRingOffscreen,Y
	LDA m2
	STA wm_BooRingIndex,Y
+	DEC m14
	BMI +
++	DEX
	BPL -
+	INC wm_BooRingAltIndex
+++	RTS

LoadShooter:
	STX m2
	DEY
	STY m3
	STA m4
	LDX #$07
-	LDA wm_ShooterSprNum,X
	BEQ ++
	DEX
	BPL -
	DEC wm_ShooterIndex
	BPL +
	LDA #$07
	STA wm_ShooterIndex
+	LDX wm_ShooterIndex
	LDY wm_ShooterLvIndex,X
	LDA #$00
	STA wm_SprLoadStatus,Y
++	LDY m3
	LDA m4
	SEC
	SBC #$C8
	STA wm_ShooterSprNum,X
	LDA wm_IsVerticalLvl
	LSR
	BCC CODE_02ABC7
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA wm_ShooterXLo,X
	PLA
	AND #$01
	STA wm_ShooterXHi,X
	LDA m0
	STA wm_ShooterYLo,X
	LDA m1
	STA wm_ShooterYHi,X
	BRA _02ABDF

CODE_02ABC7:
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA wm_ShooterYLo,X
	PLA
	AND #$01
	STA wm_ShooterYHi,X
	LDA m0
	STA wm_ShooterXLo,X
	LDA m1
	STA wm_ShooterXHi,X
_02ABDF:
	LDA m2
	STA wm_ShooterLvIndex,X
	LDA #$10
	STA wm_ShooterTimer,X
	INY
	INY
	INY
	LDX m2
	INX
	JMP _LoadSpriteLoopStrt

CODE_02ABF2:
	LDX #$3F
-	STZ wm_SprLoadStatus,X
	DEX
	BPL -
	LDA #$FF
	STA m0
	LDX #$0B
_02AC00:
	LDA #$FF
	STA wm_SprIndexInLvl,X
	LDA wm_SpriteStatus,X
	CMP #$0B
	BEQ CODE_02AC11
	STZ wm_SpriteStatus,X
	BRA _02AC13

CODE_02AC11:
	STX m0
_02AC13:
	DEX
	BPL _02AC00
	LDX m0
	BMI +
	STZ wm_SpriteStatus,X
	LDA #$0B
	STA wm_SpriteStatus
	LDA wm_SpriteNum,X
	STA wm_SpriteNum
	LDA wm_SpriteXLo,X
	STA wm_SpriteXLo
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi
	LDA wm_SpriteYLo,X
	STA wm_SpriteYLo
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi
	LDA wm_SpritePal,X
	PHA
	LDX #$00
	JSL InitSpriteTables
	PLA
	STA wm_SpritePal
+	REP #$10
	LDX #$027A
-	STZ wm_Map16NumLo,X
	DEX
	BPL -
	SEP #$10
	STZ wm_ScrollSprNum
	STZ wm_ScrollSprL2
	RTS

CODE_02AC5C:
	LDA wm_IsVerticalLvl
	LSR
	BCC CODE_02ACA1
	LDA wm_Layer1ScrollDir
	PHA
	LDA #$01
	STA wm_Layer1ScrollDir
	LDA wm_Bg1VOfs
	PHA
	SEC
	SBC #$60
	STA wm_Bg1VOfs
	LDA wm_Bg1VOfs+1
	PHA
	SBC #$00
	STA wm_Bg1VOfs+1
	STZ wm_18B6
-	JSR _02A802
	JSR _02A802
	LDA wm_Bg1VOfs
	CLC
	ADC #$10
	STA wm_Bg1VOfs
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_Bg1VOfs+1
	INC wm_18B6
	LDA wm_18B6
	CMP #$20
	BCC -
	PLA
	STA wm_Bg1VOfs+1
	PLA
	STA wm_Bg1VOfs
	PLA
	STA wm_Layer1ScrollDir
	RTS

CODE_02ACA1:
	LDA wm_Layer1ScrollDir
	PHA
	LDA #$01
	STA wm_Layer1ScrollDir
	LDA wm_Bg1HOfs
	PHA
	SEC
	SBC #$60
	STA wm_Bg1HOfs
	LDA wm_Bg1HOfs+1
	PHA
	SBC #$00
	STA wm_Bg1HOfs+1
	STZ wm_18B6
-	JSR _02A802
	JSR _02A802
	LDA wm_Bg1HOfs
	CLC
	ADC #$10
	STA wm_Bg1HOfs
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_Bg1HOfs+1
	INC wm_18B6
	LDA wm_18B6
	CMP #$20
	BCC -
	PLA
	STA wm_Bg1HOfs+1
	PLA
	STA wm_Bg1HOfs
	PLA
	STA wm_Layer1ScrollDir
	RTS

CODE_02ACE1:
	PHX
	TYX
	BRA _02ACE6

GivePoints:
	PHX
_02ACE6:
	CLC
	ADC #$05
	JSL CODE_02ACEF
	PLX
	RTL

CODE_02ACEF:
	PHY
	PHA
	JSL CODE_02AD34
	PLA
	STA wm_ScoreSprNum,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC #$08
	STA wm_ScoreSprYLo,Y
	PHA
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_ScoreSprYHi,Y
	PLA
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCC +
	LDA wm_ScoreSprYLo,Y
	ADC #$10
	STA wm_ScoreSprYLo,Y
	LDA wm_ScoreSprYHi,Y
	ADC #$00
	STA wm_ScoreSprYHi,Y
+	LDA wm_SpriteXLo,X
	STA wm_ScoreSprXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_ScoreSprXHi,Y
	LDA #$30
	STA wm_ScoreSprSpeedY,Y
	PLY
	RTL

CODE_02AD34:
	LDY #$05
-	LDA wm_ScoreSprNum,Y
	BEQ ++
	DEY
	BPL -
	DEC wm_ScoreSprIndex
	BPL +
	LDA #$05
	STA wm_ScoreSprIndex
+	LDY wm_ScoreSprIndex
++	RTL

PointTile1:
	.DB $00,$83,$83,$83,$83,$44,$54,$46
	.DB $47,$44,$54,$46,$47,$56,$29,$39
	.DB $38,$5E,$5E,$5E,$5E,$5E

PointTile2:
	.DB $00,$44,$54,$46,$47,$45,$45,$45
	.DB $45,$55,$55,$55,$55,$57,$57,$57
	.DB $57,$4E,$44,$4F,$54,$5D

PointMultiplierLo:
	.DB $00,$01,$02,$04,$08,$0A,$14,$28
	.DB $50,$64,$C8,$90,$20,$00,$00,$00
	.DB $00

PointMultiplierHi:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$01,$03,$00,$00,$00
	.DB $00

PointSpeedY:	.DB $03,$01,$00,$00

DATA_02AD9E:	.DB $B0,$B8,$C0,$C8,$D0,$D8

ScoreSprGfx:
	BIT wm_LevelMode
	BVC +
	LDA wm_LevelMode
	CMP #$C1
	BEQ ++
	LDA #$F0
	STA wm_ExOamSlot.2.YPos
	STA wm_ExOamSlot.3.YPos
+	LDX #$05
-	STX wm_SprProcessIndex
	LDA wm_ScoreSprNum,X
	BEQ +
	JSR CODE_02ADC9
+	DEX
	BPL -
++	RTS

CODE_02ADC9:
	LDA wm_SpritesLocked
	BEQ CODE_02ADD0
	JMP _02AE5B

CODE_02ADD0:
	LDA wm_ScoreSprSpeedY,X
	BNE CODE_02ADE4
	STZ wm_ScoreSprNum,X
	RTS

CoinsToGive:
	.DB $01,$02,$03,$05,$05,$0A,$0F,$14
	.DB $19

The2Up3UpAttr:	.DB $04,$06 ; BUG-FIX: ID 002-00

CODE_02ADE4:
	DEC wm_ScoreSprSpeedY,X
	CMP #$2A
	BNE _02AE38
	LDY wm_ScoreSprNum,X
	CPY #$0D
	BCC CODE_02AE12
	CPY #$11
	BCC CODE_02AE03
	PHX
	PHY
	LDA CoinsToGive-13,Y
	JSL ADDR_05B329
	PLY
	PLX
	BRA CODE_02AE12

CODE_02AE03:
	LDA CoinsToGive-13,Y
	CLC
	ADC wm_GiveLives
	STA wm_GiveLives
	STZ wm_GiveLifeTimer
	BRA _02AE35

CODE_02AE12:
	LDA wm_OWCharA
	ASL
	ADC wm_OWCharA
	TAX
	LDA wm_MarioScoreHi,X
	CLC
	ADC PointMultiplierLo,Y
	STA wm_MarioScoreHi,X
	LDA wm_MarioScoreMid,X
	ADC PointMultiplierHi,Y
	STA wm_MarioScoreMid,X
	LDA wm_MarioScoreLo,X
	ADC #$00
	STA wm_MarioScoreLo,X
_02AE35:
	LDX wm_SprProcessIndex
_02AE38:
	LDA wm_ScoreSprSpeedY,X
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA wm_FrameA
	AND PointSpeedY,Y
	BNE _02AE5B
	LDA wm_ScoreSprYLo,X
	TAY
	SEC
	SBC wm_Bg1VOfs
	CMP #$04
	BCC _02AE5B
	DEC wm_ScoreSprYLo,X
	TYA
	BNE _02AE5B
	DEC wm_ScoreSprYHi,X
_02AE5B:
	LDA wm_ScoreSprLayer,X
	ASL
	ASL
	TAY
	REP #$20
	LDA.W wm_Bg1VOfs,Y
	STA m2
	LDA.W wm_Bg1HOfs,Y
	STA m4
	SEP #$20
	LDA wm_ScoreSprXLo,X
	CLC
	ADC #$0C
	PHP
	SEC
	SBC m4
	LDA wm_ScoreSprXHi,X
	SBC m5
	PLP
	ADC #$00
	BNE ++
	LDA wm_ScoreSprXLo,X
	CMP m4
	LDA wm_ScoreSprXHi,X
	SBC m5
	BNE ++
	LDA wm_ScoreSprYLo,X
	CMP m2
	LDA wm_ScoreSprYHi,X
	SBC m3
	BNE ++
	LDY.W DATA_02AD9E,X
	BIT wm_LevelMode
	BVC +
	LDY #$04
+	LDA wm_ScoreSprYLo,X
	SEC
	SBC m2
	STA wm_ExOamSlot.1.YPos,Y
	STA wm_ExOamSlot.2.YPos,Y
	LDA wm_ScoreSprXLo,X
	SEC
	SBC m4
	STA wm_ExOamSlot.1.XPos,Y
	CLC
	ADC #$08
	STA wm_ExOamSlot.2.XPos,Y
	PHX
	LDA wm_ScoreSprNum,X
	TAX
	LDA.W PointTile1,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA.W PointTile2,X
	STA wm_ExOamSlot.2.Tile,Y
	PLX
	PHY
	LDY wm_ScoreSprNum,X
	CPY #$0E
	LDA #$08
	BCC +
	LDA The2Up3UpAttr-14,Y
+	PLY
	ORA #$30
	STA wm_ExOamSlot.1.Prop,Y
	STA wm_ExOamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	STA wm_ExOamSize.2,Y
	LDA wm_ScoreSprNum,X
	CMP #$11
	BCS ADDR_02AEFC
++	RTS

ADDR_02AEFC:
	LDY #$4C
	LDA wm_ScoreSprXLo,X
	SEC
	SBC m4
	SEC
	SBC #$08
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ScoreSprYLo,X
	SEC
	SBC m2
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$5F
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$04
	ORA #$30
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

ADDR_02AF29: ; unreachable
	STZ wm_ScoreSprNum,X
	RTS

DATA_02AF2D:	.DB $00,$AA,$54

DATA_02AF30:	.DB $00,$00,$01

Load3Platforms:
	LDY m3
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA m8
	PLA
	AND #$01
	STA m9
	LDA #$02
	STA m4
-	JSL FindFreeSprSlot
	BMI ++
	TYX
	LDA #$01
	STA wm_SpriteStatus,X
	LDA #$A3
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA m0
	STA wm_SpriteXLo,X
	LDA m1
	STA wm_SpriteXHi,X
	LDA m8
	STA wm_SpriteYLo,X
	LDA m9
	STA wm_SpriteYHi,X
	LDY m4
	LDA DATA_02AF2D,Y
	STA wm_SpriteGfxTbl,X
	LDA DATA_02AF30,Y
	STA wm_SpriteMiscTbl3,X
	CPY #$02
	BNE +
	LDA m2
	STA wm_SprIndexInLvl,X
+	DEC m4
	BPL -
++	RTS

EerieGroupDispXLo:	.DB $E0,$F0,$00,$10,$20

EerieGroupDispXHi:	.DB $FF,$FF,$00,$00,$00

EerieGroupSpeedY:	.DB $17,$E9,$17,$E9,$17

EerieGroupState:	.DB $00,$01,$00,$01,$00

EerieGroupSpeedX:	.DB $10,$F0

Load5Eeries:
	LDY m3
	LDA [wm_SprPtr],Y
	PHA
	AND #$F0
	STA m8
	PLA
	AND #$01
	STA m9
	LDA #$04
	STA m4
-	JSL FindFreeSprSlot
	BMI ++
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$39
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDY m4
	LDA m0
	CLC
	ADC EerieGroupDispXLo,Y
	STA wm_SpriteXLo,X
	LDA m1
	ADC EerieGroupDispXHi,Y
	STA wm_SpriteXHi,X
	LDA m8
	STA wm_SpriteYLo,X
	LDA m9
	STA wm_SpriteYHi,X
	LDA EerieGroupSpeedY,Y
	STA wm_SpriteSpeedY,X
	LDA EerieGroupState,Y
	STA wm_SpriteState,X
	CPY #$04
	BNE +
	LDA m2
	STA wm_SprIndexInLvl,X
+	JSR SubHorzPosBnk2
	LDA EerieGroupSpeedX,Y
	STA wm_SpriteSpeedX,X
	DEC m4
	BPL -
++	RTS

CallGenerator:
	LDA wm_GeneratorNum
	BEQ Return02B02A
	LDY wm_SpritesLocked
	BNE Return02B02A
	DEC A
	JSL ExecutePtr

GeneratorPtrs:
	.DW GenerateEerie
	.DW GenParaEnemy
	.DW GenParaEnemy
	.DW GenParaEnemy
	.DW GenerateDolphin
	.DW GenerateDolphin
	.DW GenerateFish
	.DW TurnOffGen2
	.DW GenSuperKoopa
	.DW GenerateBubble
	.DW GenerateBullet
	.DW GenMultiBullets
	.DW GenMultiBullets
	.DW GenerateFire
	.DW TurnOffGenerators

Return02B02A:
	RTS

TurnOffGen2:
	INC wm_AppearSprTimer
	STZ wm_TimeTillRespawn
	RTS

TurnOffGenerators:
	STZ wm_GeneratorNum
	RTS

GenerateFire:
	LDA wm_FrameB
	AND #$7F
	BNE +
	JSL FindFreeSlotLowPri
	BMI +
	TYX
	LDA #$17
	STA wm_SoundCh3
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$B3
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSL GetRand
	AND #$7F
	ADC #$20
	ADC wm_Bg1VOfs
	AND #$F0
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	LDA wm_Bg1HOfs
	CLC
	ADC #$FF
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_SpriteXHi,X
	INC wm_SpriteDir,X
+	RTS

GenerateBullet:
	LDA wm_FrameB
	AND #$7F
	BNE +
	JSL FindFreeSlotLowPri
	BMI +
	LDA #$09
	STA wm_SoundCh3
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$1C
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSL GetRand
	PHA
	AND #$7F
	ADC #$20
	ADC wm_Bg1VOfs
	AND #$F0
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	PLA
	AND #$01
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC SIDE_ENTER_XGEN,Y
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC DATA_02B1BA,Y
	STA wm_SpriteXHi,X
	TYA
	STA wm_SpriteState,X
+	RTS

DATA_02B0C9:	.DB $04,$08

DATA_02B0CB:	.DB $04,$03

GenMultiBullets:
	LDA wm_FrameB
	LSR
	BCS +
	LDA wm_ExBulletBillTimer
	INC wm_ExBulletBillTimer
	CMP #$A0
	BNE +
	STZ wm_ExBulletBillTimer
	LDA #$09
	STA wm_SoundCh3
	LDY wm_GeneratorNum
	LDA DATA_02B0C9-12,Y
	LDX.W DATA_02B0CB-12,Y
	STA m13
-	PHX
	JSR GEN_MULTI_BULLET
	DEC m13
	PLX
	DEX
	BPL -
+	RTS

DATA_02B0FA:
	.DB $00,$00,$40,$C0,$F0,$00,$00,$F0
	.DB $F0

DATA_02B103:
	.DB $50,$B0,$E0,$E0,$80,$00,$E0,$E0
	.DB $00

DATA_02B10C:
	.DB $00,$00,$02,$02,$01,$05,$04,$07
	.DB $06

GEN_MULTI_BULLET:
	JSL FindFreeSlotLowPri
	BMI +
	LDA #$1C
	STA.W wm_SpriteNum,Y
	LDA #$08
	STA wm_SpriteStatus,Y
	TYX
	JSL InitSpriteTables
	LDX m13
	LDA.W DATA_02B0FA,X
	CLC
	ADC wm_Bg1HOfs
	STA.W wm_SpriteXLo,Y
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_SpriteXHi,Y
	LDA.W DATA_02B103,X
	CLC
	ADC wm_Bg1VOfs
	STA.W wm_SpriteYLo,Y
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,Y
	LDA.W DATA_02B10C,X
	STA.W wm_SpriteState,Y
+	RTS

DATA_02B153:	.DB $10,$18,$20,$28

DATA_02B157:	.DB $18,$1A,$1C,$1E

GenerateFish:
	LDA wm_FrameB
	AND #$1F
	BNE ++
	JSL FindFreeSlotLowPri
	BMI ++
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$17
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA wm_Bg1VOfs
	CLC
	ADC #$C0
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	JSL GetRand
	CMP #$00
	PHP
	PHP
	AND #$03
	TAY
	LDA DATA_02B153,Y
	PLP
	BPL +
	EOR #$FF
+	CLC
	ADC wm_Bg1HOfs
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_SpriteXHi,X
	LDA wm_RandomByte2
	AND #$03
	TAY
	LDA DATA_02B157,Y
	PLP
	BPL +
	EOR #$FF
	INC A
+	STA wm_SpriteSpeedX,X
	LDA #$B8
	STA wm_SpriteSpeedY,X
++	RTS

SIDE_ENTER_XGEN:	.DB $E0,$10

DATA_02B1BA:	.DB $FF,$01

GenSuperKoopa:
	LDA wm_FrameB
	AND #$3F
	BNE +
	JSL FindFreeSlotLowPri
	BMI +
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$71
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSL GetRand
	PHA
	AND #$3F
	ADC #$20
	ADC wm_Bg1VOfs
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	LDA #$28
	STA wm_SpriteSpeedY,X
	PLA
	AND #$01
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC SIDE_ENTER_XGEN,Y
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC DATA_02B1BA,Y
	STA wm_SpriteXHi,X
	TYA
	STA wm_SpriteDir,X
+	RTS

GenerateBubble:
	LDA wm_FrameB
	AND #$7F
	BNE +
	JSL FindFreeSlotLowPri
	BMI +
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$9D
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSL GetRand
	PHA
	AND #$3F
	ADC #$20
	ADC wm_Bg1VOfs
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	PLA
	AND #$01
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC SIDE_ENTER_XGEN,Y
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC DATA_02B1BA,Y
	STA wm_SpriteXHi,X
	TYA
	STA wm_SpriteDir,X
	JSL GetRand
	AND #$03
	TAY
	LDA DATA_02B25A,Y
	STA wm_SpriteState,X
+	RTS

DATA_02B25A:	.DB $00 ; todo: fix these

DATA_02B25B:	.DB $01,$02

DATA_02B25D:	.DB $00,$10,$E0,$01,$FF,$E8

DATA_02B263:	.DB $18

DATA_02B264:	.DB $F0

DATA_02B265:	.DB $E0,$00,$10,$04,$09,$FF,$04

GenerateDolphin:
	LDA wm_FrameB
	AND #$1F
	BNE _Return02B2CF
	LDY wm_GeneratorNum
	LDX.W DATA_02B263,Y
	LDA DATA_02B265,Y
	STA m0
-	LDA wm_SpriteStatus,X
	BEQ CODE_02B288
	DEX
	CPX m0
	BNE -
	RTS

CODE_02B288:
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$41
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSL GetRand
	AND #$7F
	ADC #$40
	ADC wm_Bg1VOfs
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	JSL GetRand
	AND #$03
	TAY
	LDA DATA_02B264,Y
	STA wm_SpriteSpeedY,X
	LDY wm_GeneratorNum
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_02B25A-1,Y
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC DATA_02B25B,Y
	STA wm_SpriteXHi,X
	LDA DATA_02B25D,Y
	STA wm_SpriteSpeedX,X
	INC wm_SpriteMiscTbl3,X
_Return02B2CF:
	RTS

DATA_02B2D0:	.DB $F0,$FF

DATA_02B2D2:	.DB $FF,$00

DATA_02B2D4:	.DB $10,$F0

GenerateEerie:
	LDA wm_FrameB
	AND #$3F
	BNE +
	JSL FindFreeSlotLowPri
	BMI +
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$38
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSL GetRand
	AND #$7F
	ADC #$40
	ADC wm_Bg1VOfs
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	LDA wm_RandomByte2
	AND #$01
	TAY
	LDA DATA_02B2D0,Y
	CLC
	ADC wm_Bg1HOfs
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC DATA_02B2D2,Y
	STA wm_SpriteXHi,X
	LDA DATA_02B2D4,Y
	STA wm_SpriteSpeedX,X
+	RTS

DATA_02B31F:	.DB $3F,$40,$3F,$3F,$40,$40

DATA_02B325:	.DB $FA,$FB,$FC,$FD

GenParaEnemy:
	LDA wm_FrameB
	AND #$7F
	BNE ++
	JSL FindFreeSlotLowPri
	BMI ++
	TYX
	LDA #$08
	STA wm_SpriteStatus,X
	JSL GetRand
	LSR
	LDY wm_GeneratorNum
	BCC +
	INY
	INY
	INY
+	LDA DATA_02B31F-2,Y
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA wm_Bg1VOfs
	SEC
	SBC #$20
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	SBC #$00
	STA wm_SpriteYHi,X
	LDA wm_RandomByte1
	AND #$FF
	CLC
	ADC #$30
	PHP
	ADC wm_Bg1HOfs
	STA wm_SpriteXLo,X
	PHP
	AND #$0E
	STA wm_SpriteMiscTbl6,X
	LSR
	AND #$03
	TAY
	LDA DATA_02B325,Y
	STA wm_SpriteSpeedX,X
	LDA wm_Bg1HOfs+1
	PLP
	ADC #$00
	PLP
	ADC #$00
	STA wm_SpriteXHi,X
++	RTS

CODE_02B387:
	LDA wm_SpritesLocked
	BNE _Return02B3AA
	LDX #$07
-	STX wm_SprProcessIndex
	LDA wm_ShooterSprNum,X
	BEQ +++
	LDY wm_ShooterTimer,X
	BEQ ++
	PHA
	LDA wm_FrameA
	LSR
	BCC +
	DEC wm_ShooterTimer,X
+	PLA
++	JSR CODE_02B3AB
+++	DEX
	BPL -
_Return02B3AA:
	RTS

CODE_02B3AB:
	DEC A
	JSL ExecutePtr

ShooterPtrs:
	.DW ShootBullet
	.DW LaunchTorpedo
	.DW _Return02B3AA

LaunchTorpedo:
	LDA wm_ShooterTimer,X
	BNE +
	LDA #$50
	STA wm_ShooterTimer,X
	LDA wm_ShooterYLo,X
	CMP wm_Bg1VOfs
	LDA wm_ShooterYHi,X
	SBC wm_Bg1VOfs+1
	BNE _Return02B3AA
	LDA wm_ShooterXLo,X
	CMP wm_Bg1HOfs
	LDA wm_ShooterXHi,X
	SBC wm_Bg1HOfs+1
	BNE _Return02B3AA
	LDA wm_ShooterXLo,X
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$10
	CMP #$20
	BCC +
	JSL FindFreeSlotLowPri
	BMI +
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$44
	STA.W wm_SpriteNum,Y
	LDA wm_ShooterXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_ShooterXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_ShooterYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_ShooterYHi,X
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	JSR SubHorzPosBnk2
	TYA
	STA wm_SpriteDir,X
	STA m0
	LDA #$30
	STA wm_SpriteDecTbl1,X
	PLX
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_02B42D
	DEY
	BPL -
+	RTS

CODE_02B42D:
	LDA #$08
	STA wm_ExSpriteNum,Y
	LDA wm_ShooterXLo,X
	CLC
	ADC #$08
	STA wm_ExSpriteXLo,Y
	LDA wm_ShooterXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	LDA wm_ShooterYLo,X
	SEC
	SBC #$09
	STA wm_ExSpriteYLo,Y
	LDA wm_ShooterYHi,X
	SBC #$00
	STA wm_ExSpriteYHi,Y
	LDA #$90
	STA wm_ExSpriteTbl2,Y
	PHX
	LDX m0
	LDA.W DATA_02B464,X
	STA wm_ExSprSpeedX,Y
	PLX
	RTS

DATA_02B464:	.DB $01,$FF

ShootBullet:
	LDA wm_ShooterTimer,X
	BNE +
	LDA #$60
	STA wm_ShooterTimer,X
	LDA wm_ShooterYLo,X
	CMP wm_Bg1VOfs
	LDA wm_ShooterYHi,X
	SBC wm_Bg1VOfs+1
	BNE +
	LDA wm_ShooterXLo,X
	CMP wm_Bg1HOfs
	LDA wm_ShooterXHi,X
	SBC wm_Bg1HOfs+1
	BNE +
	LDA wm_ShooterXLo,X
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$10
	CMP #$10
	BCC +
	LDA wm_MarioXPos
	SBC wm_ShooterXLo,X
	CLC
	ADC #$11
	CMP #$22
	BCC +
	JSL FindFreeSlotLowPri
	BMI +
	LDA #$09
	STA wm_SoundCh3
	LDA #$01
	STA wm_SpriteStatus,Y
	LDA #$1C
	STA.W wm_SpriteNum,Y
	LDA wm_ShooterXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_ShooterXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_ShooterYLo,X
	SEC
	SBC #$01
	STA.W wm_SpriteYLo,Y
	LDA wm_ShooterYHi,X
	SBC #$00
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	JSR ShowShooterSmoke
+	RTS

ShowShooterSmoke:
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ SetShooterSmoke
	DEY
	BPL -
	RTS

ShooterSmokeDispX:	.DB $F4,$0C

SetShooterSmoke:
	LDA #$01
	STA wm_SmokeSprite,Y
	LDA wm_ShooterYLo,X
	STA wm_SmokeYPos,Y
	LDA #$1B
	STA wm_SmokeTimer,Y
	LDA wm_ShooterXLo,X
	PHA
	LDA wm_MarioXPos
	CMP wm_ShooterXLo,X
	LDA wm_MarioXPos+1
	SBC wm_ShooterXHi,X
	LDX #$00
	BCC +
	INX
+	PLA
	CLC
	ADC.W ShooterSmokeDispX,X
	STA wm_SmokeXPos,Y
	LDX wm_SprProcessIndex
	RTS

CODE_02B51A:
	TXA
	CLC
	ADC #$04
	TAX
	JSR CODE_02B526
	LDX wm_ExSprIndexM
	RTS

CODE_02B526:
	LDA wm_BouncBlkSpeedX,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_BouncBlkAccX,X
	STA wm_BouncBlkAccX,X
	PHP
	LDA wm_BouncBlkSpeedX,X
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
	ADC wm_BounceSprXLo,X
	STA wm_BounceSprXLo,X
	TYA
	ADC wm_BounceSprXHi,X
	STA wm_BounceSprXHi,X
	RTS

CODE_02B554:
	TXA
	CLC
	ADC #$0A
	TAX
	JSR CODE_02B560
	LDX wm_SprProcessIndex
	RTS

CODE_02B560:
	LDA wm_ExSprSpeedY,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_ExSprAccY,X
	STA wm_ExSprAccY,X
	PHP
	LDY #$00
	LDA wm_ExSprSpeedY,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	BCC +
	ORA #$F0
	DEY
+	PLP
	ADC wm_ExSpriteYLo,X
	STA wm_ExSpriteYLo,X
	TYA
	ADC wm_ExSpriteYHi,X
	STA wm_ExSpriteYHi,X
	RTS

CODE_02B58E:
	LDA wm_SpinCoinYSpeed,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpinCoinYAcc,X
	STA wm_SpinCoinYAcc,X
	PHP
	LDY #$00
	LDA wm_SpinCoinYSpeed,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	BCC +
	ORA #$F0
	DEY
+	PLP
	ADC wm_SpinCoinYLo,X
	STA wm_SpinCoinYLo,X
	TYA
	ADC wm_SpinCoinYHi,X
	STA wm_SpinCoinYHi,X
	RTS

CODE_02B5BC:
	TXA
	CLC
	ADC #$0C
	TAX
	JSR CODE_02B5C8
	LDX wm_ExSprIndexM
	RTS

CODE_02B5C8:
	LDA wm_MExSprYSpeed,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_MExSprYAcc,X
	STA wm_MExSprYAcc,X
	PHP
	LDA wm_MExSprYSpeed,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	BCC +
	ORA #$F0
+	PLP
	ADC wm_MExSprYLo,X
	STA wm_MExSprYLo,X
	RTS

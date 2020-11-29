DATA_02D580:	.DB $13,$14,$15,$16,$17,$18,$19

CODE_02D587:
	JSR CODE_02D5E4
	LDA wm_SpriteStatus,X
	CMP #$02
	BEQ +
	LDA wm_SpritesLocked
	BNE +
	JSR SubOffscreen0Bnk2
	LDA #$E8
	STA wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
	JSL MarioSprInteract
+	RTS

DATA_02D5A4:
	.DB $00,$10,$20,$30,$00,$10,$20,$30
	.DB $00,$10,$20,$30,$00,$10,$20,$30

DATA_02D5B4:
	.DB $00,$00,$00,$00,$10,$10,$10,$10
	.DB $20,$20,$20,$20,$30,$30,$30,$30

BanzaiBillTiles:
	.DB $80,$82,$84,$86,$A0,$88,$CE,$EE
	.DB $C0,$C2,$CE,$EE,$8E,$AE,$84,$86

DATA_02D5D4:
	.DB $33,$33,$33,$33,$33,$33,$33,$33
	.DB $33,$33,$33,$33,$33,$33,$B3,$B3

CODE_02D5E4:
	JSR GetDrawInfo2
	PHX
	LDX #$0F
-	LDA m0
	CLC
	ADC.W DATA_02D5A4,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02D5B4,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W BanzaiBillTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02D5D4,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$0F
	JMP _02B7A7

BanzaiRotating:
	PHB
	PHK
	PLB
	LDA wm_SpriteNum,X
	CMP #$9F
	BNE CODE_02D625
	JSR CODE_02D587
	BRA _02D628

CODE_02D625:
	JSR CODE_02D62A
_02D628:
	PLB
	RTL

CODE_02D62A:
	JSR SubOffscreen3Bnk2
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteXLo,X
	LDY #$02
	AND #$10
	BNE +
	LDY #$FE
+	TYA
	LDY #$00
	CMP #$00
	BPL +
	DEY
+	CLC
	ADC wm_SpriteGfxTbl,X
	STA wm_SpriteGfxTbl,X
	TYA
	ADC wm_SpriteMiscTbl3,X
	AND #$01
	STA wm_SpriteMiscTbl3,X
++	LDA wm_SpriteMiscTbl3,X
	STA m1
	LDA wm_SpriteGfxTbl,X
	STA m0
	REP #$30
	LDA m0
	CLC
	ADC #$0080
	AND #$01FF
	STA m2
	LDA m0
	AND #$00FF
	ASL
	TAX
	LDA.L CircleCoords,X
	STA m4
	LDA m2
	AND #$00FF
	ASL
	TAX
	LDA.L CircleCoords,X
	STA m6
	SEP #$30
	LDX wm_SprProcessIndex
	LDA m4
	STA WRMPYA
	LDA wm_SprStompImmuneTbl,X
	LDY m5
	BNE +
	STA WRMPYB
	JSR DoNothing6Times
	ASL RDMPYL
	LDA RDMPYH
	ADC #$00
+	LSR m1
	BCC +
	EOR #$FF
	INC A
+	STA m4
	LDA m6
	STA WRMPYA
	LDA wm_SprStompImmuneTbl,X
	LDY m7
	BNE +
	STA WRMPYB
	JSR DoNothing6Times
	ASL RDMPYL
	LDA RDMPYH
	ADC #$00
+	LSR m3
	BCC +
	EOR #$FF
	INC A
+	STA m6
	LDA wm_SpriteXLo,X
	PHA
	LDA wm_SpriteXHi,X
	PHA
	LDA wm_SpriteYLo,X
	PHA
	LDA wm_SpriteYHi,X
	PHA
	LDY wm_ClusterSpriteTbl3,X
	STZ m0
	LDA m4
	BPL +
	DEC m0
+	CLC
	ADC wm_SpriteXLo,X
	STA wm_SpriteXLo,X
	PHP
	PHA
	SEC
	SBC wm_SpriteMiscTbl5,X
	STA wm_SpriteMiscTbl4,X
	PLA
	STA wm_SpriteMiscTbl5,X
	PLP
	LDA wm_SpriteXHi,X
	ADC m0
	STA wm_SpriteXHi,X
	STZ m1
	LDA m6
	BPL +
	DEC m1
+	CLC
	ADC wm_SpriteYLo,X
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC m1
	STA wm_SpriteYHi,X
	LDA wm_SpriteNum,X
	CMP #$9E
	BEQ CODE_02D750
	JSL InvisBlkMainRt
	BCC CODE_02D73D
	LDA #$03
	STA wm_SpriteMiscTbl8,X
	STA wm_IsOnSolidSpr
	LDA wm_OnYoshi
	BNE _02D74B
	PHX
	JSL CODE_00E2BD
	PLX
	LDA #$FF
	STA wm_HidePlayer
	BRA _02D74B

CODE_02D73D:
	LDA wm_SpriteMiscTbl8,X
	BEQ _02D74B
	STZ wm_SpriteMiscTbl8,X
	PHX
	JSL CODE_00E2BD
	PLX
_02D74B:
	JSR CODE_02D848
	BRA _02D757

CODE_02D750:
	JSL MarioSprInteract
	JSR CODE_02D813
_02D757:
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	LDA m0
	CLC
	ADC wm_Bg1HOfs
	SEC
	SBC wm_SpriteXLo,X
	JSR CODE_02D870
	CLC
	ADC wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA m1
	CLC
	ADC wm_Bg1VOfs
	SEC
	SBC wm_SpriteYLo,X
	JSR CODE_02D870
	CLC
	ADC wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_SpriteOffTbl,X
	BNE _Return02D806
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$10
	TAY
	PHX
	LDA wm_SpriteXLo,X
	STA m10
	LDA wm_SpriteYLo,X
	STA m11
	LDA wm_SpriteNum,X
	TAX
	LDA #$E8
	CPX #$9E
	BEQ +
	LDA #$A2
+	STA m8
	LDX #$01
-	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA m8
	STA wm_OamSlot.1.Tile,Y
	LDA #$33
	STA wm_OamSlot.1.Prop,Y
	LDA m0
	CLC
	ADC wm_Bg1HOfs
	SEC
	SBC m10
	STA m0
	ASL
	ROR m0
	LDA m0
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC m10
	STA m0
	LDA m1
	CLC
	ADC wm_Bg1VOfs
	SEC
	SBC m11
	STA m1
	ASL
	ROR m1
	LDA m1
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC m11
	STA m1
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$05
	JMP _02B7A7

DoNothing6Times:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
_Return02D806:
	RTS

DATA_02D807:	.DB $F8,$08,$F8,$08

DATA_02D80B:	.DB $F8,$F8,$08,$08

DATA_02D80F:	.DB $33,$73,$B3,$F3

CODE_02D813:
	JSR GetDrawInfo2
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_02D807,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02D80B,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DoNothing6Times,X ; FIX! uses $EA 4 times Nintendo saved bytes by using NOP's
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02D80F,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	RTS

DATA_02D840:	.DB $00,$F0,$00,$10

WoodPlatformTiles:	.DB $A2,$60,$61,$62

CODE_02D848:
	JSR GetDrawInfo2
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_02D840,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA.W WoodPlatformTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$33
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	RTS

CODE_02D870:
	PHP
	BPL +
	EOR #$FF
	INC A
+	STA WRDIVH
	STZ WRDIVL
	LDA wm_SprStompImmuneTbl,X
	LSR
	STA WRDIVB
	JSR DoNothing6Times
	LDA RDDIVL
	STA m14
	LDA RDDIVH
	ASL m14
	ROL
	ASL m14
	ROL
	ASL m14
	ROL
	ASL m14
	ROL
	PLP
	BPL +
	EOR #$FF
	INC A
+	RTS

BubbleSprTiles1:	.DB $A8,$CA,$67,$24

BubbleSprTiles2:	.DB $AA,$CC,$69,$24

BubbleSprGfxProp1:	.DB $84,$85,$05,$08

BubbleSpriteMain:
	PHB
	PHK
	PLB
	JSR CODE_02D8BB
	PLB
	RTL

BubbleSprGfxProp2:	.DB $08,$F8

BubbleSprGfxProp3:	.DB $01,$FF

BubbleSprGfxProp4:	.DB $0C,$F4

CODE_02D8BB:
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$14
	STA wm_SprOAMIndex,X
	JSL GenericSprGfxRt2
	PHX
	LDA wm_SpriteState,X
	LDY wm_SprOAMIndex,X
	TAX
	LDA.W BubbleSprGfxProp1,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA wm_FrameB
	ASL
	ASL
	ASL
	LDA.W BubbleSprTiles1,X
	BCC +
	LDA.W BubbleSprTiles2,X
+	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA wm_SpriteMiscTbl5,X
	CMP #$60
	BCS +
	AND #$02
	BEQ ++
+	JSR CODE_02D9D6
++	LDA wm_SpriteStatus,X
	CMP #$02
	BNE CODE_02D904
	LDA #$08
	STA wm_SpriteStatus,X
	BRA _02D96B

CODE_02D904:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_FrameA
	AND #$01
	BNE +
	DEC wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl5,X
	CMP #$04
	BNE +
	LDA #$19
	STA wm_SoundCh3
+	LDA wm_SpriteMiscTbl5,X
	DEC A
	BEQ CODE_02D978
	CMP #$07
	BCC ++
	JSR SubOffscreen0Bnk2
	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	JSL CODE_019138
	LDY wm_SpriteDir,X
	LDA BubbleSprGfxProp2,Y
	STA wm_SpriteSpeedX,X
	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC BubbleSprGfxProp3,Y
	STA wm_SpriteSpeedY,X
	CMP BubbleSprGfxProp4,Y
	BNE +
	INC wm_SpriteMiscTbl3,X
+	LDA wm_SprObjStatus,X
	BNE _02D96B
	JSL SprSprInteract
	JSL MarioSprInteract
	BCC _Return02D9A0
	STZ wm_MarioSpeedY
	STZ wm_MarioSpeedX
_02D96B:
	LDA wm_SpriteMiscTbl5,X
	CMP #$07
	BCC ++
	LDA #$06
	STA wm_SpriteMiscTbl5,X
++	RTS

CODE_02D978:
	LDY wm_SpriteState,X
	LDA BubbleSprites,Y
	STA wm_SpriteNum,X
	PHA
	JSL InitSpriteTables
	PLY
	LDA #$20
	CPY #$74
	BNE +
	LDA #$04
+	STA wm_SpriteDecTbl2,X
	LDA wm_SpriteNum,X
	CMP #$0D
	BNE +
	DEC wm_SpriteDecTbl1,X
+	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
_Return02D9A0:
	RTS

BubbleSprites:	.DB $0F,$0D,$15,$74

BubbleTileDispX:
	.DB $F8,$08,$F8,$08,$FF,$F9,$07,$F9
	.DB $07,$00,$FA,$06,$FA,$06,$00

BubbleTileDispY:
	.DB $F6,$F6,$02,$02,$FC,$F5,$F5,$03
	.DB $03,$FC,$F4,$F4,$04,$04,$FB

BubbleTiles:	.DB $A0,$A0,$A0,$A0,$99

BubbleGfxProp:	.DB $07,$47,$87,$C7,$03

BubbleSize:	.DB $02,$02,$02,$02,$00

DATA_02D9D2:	.DB $00,$05,$0A,$05

CODE_02D9D6:
	JSR GetDrawInfo2
	LDA wm_FrameB
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_02D9D2,Y
	STA m2
	LDA wm_SprOAMIndex,X
	SEC
	SBC #$14
	STA wm_SprOAMIndex,X
	TAY
	PHX
	LDA wm_SpriteMiscTbl5,X
	STA m3
	LDX #$04
-	PHX
	TXA
	CLC
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W BubbleTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W BubbleTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	PLX
	LDA.W BubbleTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W BubbleGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA m3
	CMP #$06
	BCS ++
	CMP #$03
	LDA #$02
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA #$64
	BCS +
	LDA #$66
+	STA wm_OamSlot.1.Tile,Y
++	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W BubbleSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$FF
	LDA #$04
	JMP _02B7A7

HammerBrotherMain:
	PHB
	PHK
	PLB
	JSR CODE_02DA5A
	PLB
_Return02DA59:
	RTL

CODE_02DA5A:
	STZ wm_SpriteDir,X
	LDA wm_SpriteStatus,X
	CMP #$02
	BNE CODE_02DA6E
	JMP HammerBroGfx

HammerFreq:	.DB $1F,$0F,$0F,$0F,$0F,$0F,$0F

CODE_02DA6E:
	LDA wm_SpritesLocked
	BNE _Return02DAE8
	JSL SprSprMarioSprRts
	JSR SubOffscreen1Bnk2
	LDY wm_OWCharA
	LDA wm_MapData.MarioMap,Y
	TAY
	LDA wm_FrameA
	AND #$03
	BEQ +
	INC wm_SpriteMiscTbl6,X
+	LDA wm_SpriteMiscTbl6,X
	ASL
	CPY #$00
	BEQ +
	ASL
+	AND #$40
	STA wm_SpriteDir,X
	LDA wm_SpriteMiscTbl6,X
	AND HammerFreq,Y
	ORA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	ORA wm_SpriteDecTbl1,X
	BNE _Return02DAE8
	LDA #$03
	STA wm_SpriteDecTbl1,X
	LDY #$10
	LDA wm_SpriteDir,X
	BNE +
	LDY #$F0
+	STY m0
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ GenerateHammer
	DEY
	BPL -
	RTS

GenerateHammer:
	LDA #$04
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_ExSpriteYHi,Y
	LDA #$D0
	STA wm_ExSprSpeedY,Y
	LDA m0
	STA wm_ExSprSpeedX,Y
_Return02DAE8:
	RTS

HammerBroDispX:	.DB $08,$10,$00,$10

HammerBroDispY:	.DB $F8,$F8,$00,$00

HammerBroTiles:	.DB $5A,$4A,$46,$48,$4A,$5A,$48,$46

HammerBroTileSize:	.DB $00,$00,$02,$02

HammerBroGfx:
	JSR GetDrawInfo2
	LDA wm_SpriteDir,X
	STA m2
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W HammerBroDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W HammerBroDispY,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA m2
	PHA
	ORA #$37
	STA wm_OamSlot.1.Prop,Y
	PLA
	BEQ +
	INX
	INX
	INX
	INX
+	LDA.W HammerBroTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W HammerBroTileSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
_02DB44:
	PLX
	LDY #$FF
	LDA #$03
	JMP _02B7A7

FlyingPlatformMain:
	PHB
	PHK
	PLB
	JSR CODE_02DB5C
	PLB
	RTL

DATA_02DB54:	.DB $01,$FF

DATA_02DB56:	.DB $20,$E0

DATA_02DB58:	.DB $02,$FE

DATA_02DB5A:	.DB $20,$E0

CODE_02DB5C:
	JSR FlyingPlatformGfx
	LDA #$FF
	STA wm_SpriteMiscTbl7,X
	LDY #$09
-	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE +
	LDA.W wm_SpriteNum,Y
	CMP #$9B
	BEQ PutHammerBroOnPlat
+	DEY
	BPL -
	BRA _02DB9E

PutHammerBroOnPlat:
	TYA
	STA wm_SpriteMiscTbl7,X
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC #$10
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSR HammerBroGfx
	PLX
_02DB9E:
	LDA wm_SpritesLocked
	BNE +++
	JSR SubOffscreen1Bnk2
	LDA wm_FrameA
	AND #$01
	BNE ++
	LDA wm_SpriteMiscTbl5,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_02DB54,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_02DB56,Y
	BNE +
	INC wm_SpriteMiscTbl5,X
+	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_02DB58,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_02DB5A,Y
	BNE ++
	INC wm_SpriteMiscTbl3,X
++	JSR UpdateYPosNoGrvty2
	JSR UpdateXPosNoGrvty2
	STA wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
	LDA wm_SpriteDecTbl3,X
	BEQ +++
	LDA #$01
	STA wm_SpriteState,X
	JSR CODE_02D4FA
	LDA m15
	CMP #$08
	BMI +
	INC wm_SpriteState,X
+	LDY wm_SpriteMiscTbl7,X
	BMI +++
	LDA #$02
	STA wm_SpriteStatus,Y
	LDA #$C0
	STA.W wm_SpriteSpeedY,Y
	PHX
	TYX
	JSL CODE_01AB6F
	PLX
+++	RTS

DATA_02DC0F:	.DB $00,$10,$F2,$1E,$00,$10,$FA,$1E

DATA_02DC17:	.DB $00,$00,$F6,$F6,$00,$00,$FE,$FE

HmrBroPlatTiles:	.DB $40,$40,$C6,$C6,$40,$40,$5D,$5D

DATA_02DC27:	.DB $32,$32,$72,$32,$32,$32,$72,$32

DATA_02DC2F:	.DB $02,$02,$02,$02,$02,$02,$00,$00

DATA_02DC37:	.DB $00,$04,$06,$08,$08,$06,$04,$00

FlyingPlatformGfx:
	JSR GetDrawInfo2
	LDA wm_SpriteState,X
	STA m7
	LDA wm_SpriteDecTbl3,X
	LSR
	TAY
	LDA DATA_02DC37,Y
	STA m5
	LDY wm_SprOAMIndex,X
	PHX
	LDA wm_FrameB
	LSR
	AND #$04
	STA m2
	LDX #$03
-	STX m6
	TXA
	ORA m2
	TAX
	LDA m0
	CLC
	ADC.W DATA_02DC0F,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02DC17,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDX m6
	CPX #$02
	BCS +
	INX
	CPX m7
	BNE +
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC m5
	STA wm_OamSlot.1.YPos,Y
+	PLX
	LDA.W HmrBroPlatTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02DC27,X
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_02DC2F,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	LDX m6
	DEX
	BPL -
	JMP _02DB44

SumoBrotherMain:
	PHB
	PHK
	PLB
	JSR CODE_02DCB7
	PLB
	RTL

CODE_02DCB7:
	JSR SumoBroGfx
	LDA wm_SpritesLocked
	BNE Return02DCE9
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE Return02DCE9
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
+	LDA wm_SpriteState,X
	JSL ExecutePtr

SumoBroPtrs:
	.DW CODE_02DCEA
	.DW CODE_02DCFF
	.DW CODE_02DD0E
	.DW CODE_02DD4B

Return02DCE9:
	RTS

CODE_02DCEA:
	LDA #$01
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	STZ wm_SpriteGfxTbl,X
	LDA #$03
_02DCF9:
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
+	RTS

CODE_02DCFF:
	LDA wm_SpriteDecTbl1,X
	BNE Return02DD0B
	INC wm_SpriteGfxTbl,X
	LDA #$03
	BRA _02DCF9

Return02DD0B:
	RTS

DATA_02DD0C:	.DB $20,$E0

CODE_02DD0E:
	LDA wm_SpriteDecTbl3,X
	BNE CODE_02DD45
	LDY wm_SpriteDir,X
	LDA DATA_02DD0C,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteDecTbl1,X
	BNE _Return02DD44
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	AND #$01
	BNE +
	LDA #$20
	STA wm_SpriteDecTbl3,X
+	LDA wm_SpriteMiscTbl6,X
	CMP #$03
	BNE CODE_02DD3D
	STZ wm_SpriteMiscTbl6,X
	LDA #$70
	BRA _02DCF9

CODE_02DD3D:
	LDA #$03
_02DD3F:
	JSR _02DCF9
	STZ wm_SpriteState,X
_Return02DD44:
	RTS

CODE_02DD45:
	LDA #$01
	STA wm_SpriteGfxTbl,X
	RTS

CODE_02DD4B:
	LDA #$03
	LDY wm_SpriteDecTbl1,X
	BEQ CODE_02DD81
	CPY #$2E
	BNE ++
	PHA
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE +
	LDA #$30
	STA wm_ShakeGrndTimer
	LDA #$09
	STA wm_SoundCh3
	PHY
	JSR GenSumoLightning
	PLY
+	PLA
++	CPY #$30
	BCC +
	CPY #$50
	BCS +
	INC A
	CPY #$44
	BCS +
	INC A
+	STA wm_SpriteGfxTbl,X
	RTS

CODE_02DD81:
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
	LDA #$40
	JSR _02DD3F
	RTS

GenSumoLightning:
	JSL FindFreeSprSlot
	BMI +
	LDA #$2B
	STA.W wm_SpriteNum,Y
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA wm_SpriteXLo,X
	ADC #$04
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDA #$10
	STA wm_DisSprCapeContact,X
	PLX
+	RTS

SumoBrosDispX:
	.DB $FF,$07,$FC,$04,$FF,$07,$FC,$04
	.DB $FF,$FF,$FC,$04,$FF,$FF,$FC,$04
	.DB $02,$02,$F4,$04,$02,$02,$F4,$04
	.DB $09,$01,$04,$FC,$09,$01,$04,$FC
	.DB $01,$01,$04,$FC,$01,$01,$04,$FC
	.DB $FF,$FF,$0C,$FC,$FF,$FF,$0C,$FC

SumoBrosDispY:
	.DB $F8,$F8,$00,$00,$F8,$F8,$00,$00
	.DB $F8,$F0,$00,$00,$F8,$F8,$00,$00
	.DB $F8,$F8,$01,$00,$F8,$F8,$FF,$00

SumoBrosTiles:
	.DB $98,$99,$A7,$A8,$98,$99,$AA,$AB
	.DB $8A,$66,$AA,$AB,$EE,$EE,$C5,$C6
	.DB $80,$80,$C1,$C3,$80,$80,$C1,$C3

SumoBrosTileSize:
	.DB $00,$00,$02,$02,$00,$00,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02

SumoBroGfx:
	JSR GetDrawInfo2
	LDA wm_SpriteDir,X
	LSR
	ROR
	ROR
	AND #$40
	EOR #$40
	STA m2
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	PHX
	TAX
	LDA #$03
	STA m5
-	PHX
	LDA m2
	BEQ +
	TXA
	CLC
	ADC #$18
	TAX
+	LDA m0
	CLC
	ADC.W SumoBrosDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA m1
	CLC
	ADC.W SumoBrosDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W SumoBrosTiles,X
	STA wm_OamSlot.1.Tile,Y
	CMP #$66
	SEC
	BNE +
	CLC
+	LDA #$34
	ADC m2
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W SumoBrosTileSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	INX
	DEC m5
	BPL -
	PLX
	LDY #$FF
	LDA #$03
	JMP _02B7A7

SumosLightningMain:
	PHB
	PHK
	PLB
	JSR CODE_02DEB0
	PLB
	RTL

CODE_02DEB0:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02DEFC
	LDA #$30
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	LDA wm_DisSprCapeContact,X
	BNE +
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	LDA #$17
	STA wm_SoundCh3
	LDA #$22
	STA wm_SpriteDecTbl1,X
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE +
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	JSL CODE_028A44
+	LDA #$00
	JSL GenericSprGfxRt0
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.2.Prop,Y
	EOR #$C0
	STA wm_OamSlot.2.Prop,Y
	RTS

CODE_02DEFC:
	STA m2
	CMP #$01
	BNE +
	STZ wm_SpriteStatus,X
+	AND #$0F
	CMP #$01
	BNE +
	STA wm_AllowClusterSpr
	JSR CODE_02DF2C
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$01
	BEQ +
	JSR CODE_02DF2C
	INC wm_SpriteMiscTbl6,X
+	RTS

DATA_02DF22:	.DB $FC,$0C,$EC,$1C,$DC

DATA_02DF27:	.DB $FF,$00,$FF,$00,$FF

CODE_02DF2C:
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	LDY #$09
-	LDA wm_ClustSprNum,Y
	BEQ ++
	DEY
	BPL -
	DEC wm_SumoFlameIndex
	BPL +
	LDA #$09
	STA wm_SumoFlameIndex
+	LDY wm_SumoFlameIndex
++	PHX
	LDA wm_SpriteMiscTbl6,X
	TAX
	LDA m0
	CLC
	ADC.W DATA_02DF22,X
	STA wm_ClusterSprXLo,Y
	LDA m1
	ADC.W DATA_02DF27,X
	STA wm_ClusterSprXHi,Y
	PLX
	LDA wm_SpriteYLo,X
	SEC
	SBC #$10
	STA wm_ClusterSprYLo,Y
	LDA wm_SpriteYHi,X
	SEC
	SBC #$00
	STA wm_ClusterSprYHi,Y
	LDA #$7F
	STA wm_ClusterSpriteTbl1,Y
	LDA wm_ClusterSprXLo,Y
	CMP wm_Bg1HOfs
	LDA wm_ClusterSprXHi,Y
	SBC wm_Bg1HOfs+1
	BNE +
	LDA #$06
	STA wm_ClustSprNum,Y
+	RTS

VolcanoLotusMain:
	PHB
	PHK
	PLB
	JSR CODE_02DF93
	PLB
	RTL

CODE_02DF93:
	JSR VolcanoLotusGfx
	LDA wm_SpritesLocked
	BNE Return02DFC8
	STZ wm_SpriteMiscTbl3,X
	JSL SprSprMarioSprRts
	JSR SubOffscreen0Bnk2
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	INC wm_SpriteSpeedY,X
+	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteSpeedY,X
+	LDA wm_SpriteState,X
	JSL ExecutePtr

VolcanoLotusPtrs:
	.DW CODE_02DFC9
	.DW CODE_02DFDF
	.DW CODE_02DFEF

Return02DFC8:
	RTS

CODE_02DFC9:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02DFD6
	LDA #$40
_02DFD0:
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
	RTS

CODE_02DFD6:
	LSR
	LSR
	LSR
	AND #$01
	STA wm_SpriteGfxTbl,X
	RTS

CODE_02DFDF:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02DFE8
	LDA #$40
	BRA _02DFD0

CODE_02DFE8:
	LSR
	AND #$01
	STA wm_SpriteMiscTbl3,X
	RTS

CODE_02DFEF:
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$80
	JSR _02DFD0
	STZ wm_SpriteState,X
+	CMP #$38
	BNE +
	JSR CODE_02E079
+	LDA #$02
	STA wm_SpriteGfxTbl,X
	RTS

VolcanoLotusTiles:	.DB $8E,$9E,$E2

VolcanoLotusGfx:
	JSR MushroomScaleGfx
	LDY wm_SprOAMIndex,X
	LDA #$CE
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$30
	ORA #$0B
	STA wm_OamSlot.1.Prop,Y
	ORA #$40
	STA wm_OamSlot.2.Prop,Y
	LDA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.3.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.4.XPos,Y
	LDA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.3.YPos,Y
	STA wm_OamSlot.4.YPos,Y
	PHX
	LDA wm_SpriteGfxTbl,X
	TAX
	LDA.W VolcanoLotusTiles,X
	STA wm_OamSlot.3.Tile,Y
	INC A
	STA wm_OamSlot.4.Tile,Y
	PLX
	LDA wm_SpriteMiscTbl3,X
	CMP #$01
	LDA #$39
	BCC +
	LDA #$35
+	STA wm_OamSlot.3.Prop,Y
	STA wm_OamSlot.4.Prop,Y
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$08
	STA wm_SprOAMIndex,X
	LDY #$00
	LDA #$01
	JMP _02B7A7

DATA_02E071:	.DB $10,$F0,$06,$FA

DATA_02E075:	.DB $EC,$EC,$E8,$E8

CODE_02E079:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE _Return02E0C4
	LDA #$03
	STA m0
_02E085:
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_02E090
	DEY
	BPL -
	RTS

CODE_02E090:
	LDA #$0C
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_ExSpriteYHi,Y
	PHX
	LDX m0
	LDA.W DATA_02E071,X
	STA wm_ExSprSpeedX,Y
	LDA.W DATA_02E075,X
	STA wm_ExSprSpeedY,Y
	PLX
	DEC m0
	BPL _02E085
_Return02E0C4:
	RTS

JumpingPiranhaMain:
	PHB
	PHK
	PLB
	JSR CODE_02E0CD
	PLB
	RTL

CODE_02E0CD:
	JSL LoadSpriteTables
	LDA wm_SpriteProp
	PHA
	LDA #$10
	STA wm_SpriteProp
	LDA wm_SpriteMiscTbl6,X
	AND #$08
	LSR
	LSR
	EOR #$02
	STA wm_SpriteGfxTbl,X
	JSL GenericSprGfxRt2
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	LDA wm_SpriteMiscTbl3,X
	AND #$04
	LSR
	LSR
	INC A
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteYLo,X
	PHA
	CLC
	ADC #$08
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	ADC #$00
	STA wm_SpriteYHi,X
	LDA #$0A
	STA wm_SpritePal,X
	LDA #$01
	JSL GenericSprGfxRt0
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteProp
	LDA wm_SpritesLocked
	BNE _Return02E158
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteState,X
	JSL ExecutePtr

JumpingPiranhaPtrs:
	.DW CODE_02E13C
	.DW CODE_02E159
	.DW CODE_02E177

CODE_02E13C:
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteDecTbl1,X
	BNE _Return02E158
	JSR CODE_02D4FA
	LDA m15
	CLC
	ADC #$1B
	CMP #$37
	BCC _Return02E158
	LDA #$C0
	STA wm_SpriteSpeedY,X
	INC wm_SpriteState,X
	STZ wm_SpriteGfxTbl,X
_Return02E158:
	RTS

CODE_02E159:
	LDA wm_SpriteSpeedY,X
	BMI +
	CMP #$40
	BCS ++
+	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
++	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteSpeedY,X
	CMP #$F0
	BMI _Return02E176
	LDA #$50
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
_Return02E176:
	RTS

CODE_02E177:
	INC wm_SpriteMiscTbl3,X
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02E1A4
_02E17F:
	INC wm_SpriteMiscTbl6,X
	LDA wm_FrameB
	AND #$03
	BNE +
	LDA wm_SpriteSpeedY,X
	CMP #$08
	BPL +
	INC A
	STA wm_SpriteSpeedY,X
+	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _Return02E176
	STZ wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	RTS

CODE_02E1A4:
	LDY wm_SpriteNum,X
	CPY #$50
	BNE _02E1F7
	STZ wm_SpriteMiscTbl6,X
	CMP #$40
	BNE _02E1F7
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE _02E1F7
	LDA #$10
	JSR _02E1C0
	LDA #$F0
_02E1C0:
	STA m0
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_02E1CD
	DEY
	BPL -
	RTS

CODE_02E1CD:
	LDA #$0B
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_ExSpriteYHi,Y
	LDA #$D0
	STA wm_ExSprSpeedY,Y
	LDA m0
	STA wm_ExSprSpeedX,Y
_02E1F7:
	BRA _02E17F

DATA_02E1F9:	.DB $00,$00,$F0,$10

DATA_02E1FD:	.DB $F0,$10,$00,$00

DATA_02E201:
	.DB $00,$03,$02,$00,$01,$03,$02,$00
	.DB $00,$03,$02,$00,$00,$00,$00,$00

DATA_02E211:	.DB $01,$00,$03,$02

DirectionCoinsMain:
	PHB
	PHK
	PLB
	JSR CODE_02E21D
	PLB
	RTL

CODE_02E21D:
	LDA wm_SpriteProp
	PHA
	LDA wm_SpriteDecTbl1,X
	CMP #$30
	BCC +
	LDA #$10
	STA wm_SpriteProp
+	LDA wm_Bg1VOfs
	PHA
	CLC
	ADC #$01
	STA wm_Bg1VOfs
	LDA wm_Bg1VOfs+1
	PHA
	ADC #$00
	STA wm_Bg1VOfs+1
	LDA wm_BluePowTimer
	BNE CODE_02E245
	JSL CoinSprGfx
	BRA _02E259

CODE_02E245:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA #$2E
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$3F
	STA wm_OamSlot.1.Prop,Y
_02E259:
	PLA
	STA wm_Bg1VOfs+1
	PLA
	STA wm_Bg1VOfs
	PLA
	STA wm_SpriteProp
	LDA wm_SpritesLocked
	BNE CODE_02E2DE
	LDA wm_FrameA
	AND #$03
	BNE CODE_02E288
	DEC wm_DirCoinTimer
	BNE CODE_02E288
_02E271:
	STZ wm_DirCoinTimer
	STZ wm_SpriteStatus,X
	LDA wm_BluePowTimer
	ORA wm_SilverPowTimer
	BNE +
	LDA wm_LevelMusicMod
	BMI +
	STA wm_MusicCh1
+	RTS

CODE_02E288:
	LDY wm_SpriteState,X
	LDA DATA_02E1F9,Y
	STA wm_SpriteSpeedX,X
	LDA DATA_02E1FD,Y
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	JSR UpdateXPosNoGrvty2
	LDA wm_JoyPadA
	AND #$0F
	BEQ +
	TAY
	LDA DATA_02E201,Y
	TAY
	LDA DATA_02E211,Y
	CMP wm_SpriteState,X
	BEQ +
	TYA
	STA wm_SpriteMiscTbl3,X
+	LDA wm_SpriteYLo,X
	AND #$0F
	STA m0
	LDA wm_SpriteXLo,X
	AND #$0F
	ORA m0
	BNE CODE_02E2DE
	LDA wm_SpriteMiscTbl3,X
	STA wm_SpriteState,X
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	LDA #$06
	STA wm_BlockId
	JSL GenerateTile
	RTS

CODE_02E2DE:
	JSL CODE_019138
	LDA wm_SpriteSpeedX,X
	BNE CODE_02E2F3
	LDA wm_SprOnTileYHi
	BNE _02E2FF
	LDA wm_SprOnTileYLo
	CMP #$25
	BNE _02E2FF
	RTS

CODE_02E2F3:
	LDA wm_SprOnTileXHi
	BNE _02E2FF
	LDA wm_SprOnTileXLo
	CMP #$25
	BEQ +
_02E2FF:
	JSR _02E271
+	RTS

GasBubbleMain:
	PHB
	PHK
	PLB
	JSR CODE_02E311
	PLB
	RTL

DATA_02E30B:	.DB $10,$F0

DATA_02E30D:	.DB $01,$FF

DATA_02E30F:	.DB $10,$F0

CODE_02E311:
	JSR GasBubbleGfx
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	LDY wm_SpriteDir,X
	LDA DATA_02E30B,Y
	STA wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_02E30D,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_02E30F,Y
	BNE +
	INC wm_SpriteState,X
+	JSR UpdateYPosNoGrvty2
	INC wm_SpriteMiscTbl6,X
	JSR SubOffscreen0Bnk2
	JSL MarioSprInteract
++	RTS

DATA_02E352:
	.DB $00,$10,$20,$30,$00,$10,$20,$30
	.DB $00,$10,$20,$30,$00,$10,$20,$30

DATA_02E362:
	.DB $00,$00,$00,$00,$10,$10,$10,$10
	.DB $20,$20,$20,$20,$30,$30,$30,$30

DATA_02E372:
	.DB $80,$82,$84,$86,$A0,$A2,$A4,$A6
	.DB $A0,$A2,$A4,$A6,$80,$82,$84,$86

DATA_02E382:
	.DB $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
	.DB $BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB

DATA_02E392:
	.DB $00,$00,$02,$02,$00,$00,$02,$02
	.DB $01,$01,$03,$03,$01,$01,$03,$03

DATA_02E3A2:	.DB $00,$01,$02,$01

DATA_02E3A6:	.DB $02,$01,$00,$01

GasBubbleGfx:
	JSR GetDrawInfo2
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_02E3A2,Y
	STA m2
	LDA DATA_02E3A6,Y
	STA m3
	LDY wm_SprOAMIndex,X
	PHX
	LDX #$0F
_02E3C6:
	LDA m0
	CLC
	ADC.W DATA_02E352,X
	PHA
	LDA.W DATA_02E392,X
	AND #$02
	BNE CODE_02E3DA
	PLA
	CLC
	ADC m2
	BRA _02E3DE

CODE_02E3DA:
	PLA
	SEC
	SBC m2
_02E3DE:
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_02E362,X
	PHA
	LDA.W DATA_02E392,X
	AND #$01
	BNE CODE_02E3F5
	PLA
	CLC
	ADC m3
	BRA _02E3F9

CODE_02E3F5:
	PLA
	SEC
	SBC m3
_02E3F9:
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_02E372,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02E382,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL _02E3C6
	PLX
	LDY #$02
	LDA #$0F
	JMP _02B7A7

ExplodingBlkMain:
	PHB
	PHK
	PLB
	JSR CODE_02E41F
	PLB
	RTL

CODE_02E41F:
	JSL GenericSprGfxRt2
	LDA wm_SpritesLocked
	BNE _Return02E462
	BRA _02E42D

ADDR_02E429: ; unreachable, sleeping music notes for exploding blocks
	JSL ADDR_02C0CF
_02E42D:
	LDY #$00
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	AND #$40
	BEQ +
	LDY #$04
	LDA wm_SpriteMiscTbl6,X
	AND #$04
	BEQ +
	LDY #$FC
+	STY wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
	JSL SprSprMarioSprRts
	JSR CODE_02D4FA
	LDA m15
	CLC
	ADC #$60
	CMP #$C0
	BCS _Return02E462
	LDY wm_OffscreenHorz,X
	BNE _Return02E462
	JSL CODE_02E463
_Return02E462:
	RTS

CODE_02E463:
	LDA wm_SpriteState,X
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA #$D0
	STA wm_SpriteSpeedY,X
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	PHB
	LDA #:ShatterBlock
	PHA
	PLB
	LDA #$00
	JSL ShatterBlock
	PLB
	RTL

ScalePlatformMain:
	LDA wm_SprOAMIndex,X
	PHA
	PHB
	PHK
	PLB
	JSR CODE_02E4A5
	PLB
	PLA
	STA wm_SprOAMIndex,X
	RTL

CODE_02E4A5:
	JSR SubOffscreen2Bnk2
	STZ wm_TempTileGen
	LDA wm_SpriteXLo,X
	PHA
	LDA wm_SpriteXHi,X
	PHA
	LDA wm_SpriteYLo,X
	PHA
	LDA wm_SpriteYHi,X
	PHA
	LDA wm_SpriteMiscTbl3,X
	STA wm_SpriteYHi,X
	LDA wm_SpriteMiscTbl5,X
	STA wm_SpriteYLo,X
	LDA wm_SpriteState,X
	STA wm_SpriteXLo,X
	LDA wm_SpriteGfxTbl,X
	STA wm_SpriteXHi,X
	LDY #$02
	JSR CODE_02E524
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	BCC +
	INC wm_TempTileGen
	LDA #$F8
	JSR CODE_02E559
+	LDA wm_SprOAMIndex,X
	CLC
	ADC #$08
	STA wm_SprOAMIndex,X
	LDY #$00
	JSR CODE_02E524
	BCC +
	INC wm_TempTileGen
	LDA #$08
	JSR CODE_02E559
+	LDA wm_TempTileGen
	BNE ++
	LDY #$02
	LDA wm_SpriteYLo,X
	CMP wm_SpriteMiscTbl5,X
	BEQ ++
	LDA wm_SpriteYHi,X
	SBC wm_SpriteMiscTbl3,X
	BMI +
	LDY #$FE
+	TYA
	JSR CODE_02E559
++	RTS

MushrmScaleTiles:	.DB $02,$07,$07,$02

CODE_02E524:
	LDA wm_SpriteYLo,X
	AND #$0F
	BNE ++
	LDA wm_SpriteSpeedY,X
	BEQ ++
	LDA wm_SpriteSpeedY,X
	BPL +
	INY
+	LDA MushrmScaleTiles,Y
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
++	JSR MushroomScaleGfx
	STZ wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
	RTS

CODE_02E559:
	LDY wm_SpritesLocked
	BNE ++
	PHA
	JSR UpdateYPosNoGrvty2
	PLA
	STA wm_SpriteSpeedY,X
	LDY #$00
	LDA wm_SprPixelMove
	EOR #$FF
	INC A
	BPL +
	DEY
+	CLC
	ADC wm_SpriteMiscTbl5,X
	STA wm_SpriteMiscTbl5,X
	TYA
	ADC wm_SpriteMiscTbl3,X
	STA wm_SpriteMiscTbl3,X
++	RTS

MushroomScaleGfx:
	JSR GetDrawInfo2
	LDA m0
	SEC
	SBC #$08
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	DEC A
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA #$80
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	ORA #$40
	STA wm_OamSlot.2.Prop,Y
	LDA #$01
	LDY #$02
	JMP _02B7A7

MovingLedgeMain:
	PHB
	PHK
	PLB
	JSR CODE_02E5BC
	PLB
	RTL

CODE_02E5BC:
	JSR SubOffscreen0Bnk2
	LDA wm_SpritesLocked
	BNE ++
	INC wm_SpriteMiscTbl6,X
	LDY #$10
	LDA wm_SpriteMiscTbl6,X
	AND #$80
	BNE +
	LDY #$F0
+	TYA
	STA wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
++	JSR CODE_02E637
	JSR CODE_02E5F7
	LDA wm_FallThroughFlag
	BEQ +
	DEC A
	CMP wm_SprProcessIndex
	BNE ++
+	JSL MarioSprInteract
	STZ wm_FallThroughFlag
	BCC ++
	INX
	STX wm_FallThroughFlag
	DEX
++	RTS

CODE_02E5F7:
	LDY #$0B
-	CPY wm_SprProcessIndex
	BEQ ++
	TYA
	EOR wm_FrameA
	AND #$03
	BNE ++
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC ++
	LDA wm_SpriteInterTbl,Y
	BEQ +
	DEC A
	CMP wm_SprProcessIndex
	BNE ++
+	TYX
	JSL GetSpriteClippingB
	LDX wm_SprProcessIndex
	JSL GetSpriteClippingA
	JSL CheckForContact
	LDA #$00
	STA wm_SpriteInterTbl,Y
	BCC ++
	TXA
	INC A
	STA wm_SpriteInterTbl,Y
++	DEY
	BPL -
	RTS

CODE_02E637:
	JSR GetDrawInfo2
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_02E666,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA.W MovingHoleTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02E66E,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDA #$03
	LDY #$02
	JMP _02B7A7

DATA_02E666:	.DB $00,$08,$18,$20

MovingHoleTiles:	.DB $EB,$EA,$EA,$EB

DATA_02E66E:	.DB $71,$31,$31,$31

CODE_02E672:
	PHB
	PHK
	PLB
	JSR CODE_02E67A
	PLB
	RTL

CODE_02E67A:
	JSR GetDrawInfo2
	TYA
	CLC
	ADC #$08
	STA wm_SprOAMIndex,X
	TAY
	LDA m0
	SEC
	SBC #$0D
	STA wm_OamSlot.1.XPos,Y
	SEC
	SBC #$08
	STA wm_TempTileGen
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	CLC
	ADC #$02
	STA wm_OamSlot.1.YPos,Y
	STA wm_18B6
	CLC
	ADC #$40
	STA wm_OamSlot.2.YPos,Y
	LDA #$AA
	STA wm_OamSlot.1.Tile,Y
	LDA #$24
	STA wm_OamSlot.2.Tile,Y
	LDA #$35
	STA wm_OamSlot.1.Prop,Y
	LDA #$3A
	STA wm_OamSlot.2.Prop,Y
	LDA #$01
	LDY #$02
	JSR _02B7A7
	LDA wm_OffscreenHorz,X
	BNE +
	LDY wm_SprOAMIndex,X
	LDA wm_MarioScrPosX
	SEC
	SBC wm_OamSlot.2.XPos,Y
	CLC
	ADC #$0C
	CMP #$18
	BCS +
	LDA wm_MarioScrPosY
	SEC
	SBC wm_OamSlot.2.YPos,Y
	CLC
	ADC #$0C
	CMP #$18
	BCS +
	STZ wm_SpriteMiscTbl3,X
	JSL CODE_00F388
+	PHX
	LDA #$38
	STA wm_SprOAMIndex,X
	TAY
	LDX #$07
-	LDA wm_TempTileGen
	STA wm_OamSlot.1.XPos,Y
	LDA wm_18B6
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$08
	STA wm_18B6
	LDA #$89
	STA wm_OamSlot.1.Tile,Y
	LDA #$35
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDA #$07
	LDY #$00
	JMP _02B7A7

SwimJumpFishMain:
	PHB
	PHK
	PLB
	JSR CODE_02E727
	PLB
	RTL

CODE_02E727:
	JSL GenericSprGfxRt2
	LDA wm_SpritesLocked
	BNE Return02E74B
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	JSL CODE_019138
	LDY #$00
	JSR _02EB3D
	LDA wm_SpriteState,X
	AND #$01
	JSL ExecutePtr

FishPtrs:
	.DW CODE_02E74E
	.DW CODE_02E788

Return02E74B:
	RTS

DATA_02E74C:	.DB $14,$EC

CODE_02E74E:
	LDY wm_SpriteDir,X
	LDA DATA_02E74C,Y
	STA wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
	LDA wm_SpriteDecTbl1,X
	BNE ++
	INC wm_SpriteMiscTbl6,X
	LDY wm_SpriteMiscTbl6,X
	CPY #$04
	BEQ CODE_02E77C
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
	LDA #$20
	CPY #$03
	BEQ +
	LDA #$40
+	STA wm_SpriteDecTbl1,X
++	RTS

CODE_02E77C:
	INC wm_SpriteState,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
	LDA #$A0
	STA wm_SpriteSpeedY,X
	RTS

CODE_02E788:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02E7A4
	CMP #$70
	BCS ++
	STZ wm_SpriteSpeedX,X
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteSpeedY,X
	BMI +
	CMP #$30
	BCS ++
+	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
++	RTS

CODE_02E7A4:
	LDA wm_SpriteYLo,X
	AND #$F0
	STA wm_SpriteYLo,X
	INC wm_SpriteState,X
	STZ wm_SpriteMiscTbl6,X
	LDA #$20
	STA wm_SpriteDecTbl1,X
	RTS

ChucksRockMain:
	PHB
	PHK
	PLB
	JSR CODE_02E7BD
	PLB
	RTL

CODE_02E7BD:
	LDA wm_SpriteProp
	PHA
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LDA #$10
	STA wm_SpriteProp
+	JSL GenericSprGfxRt2
	PLA
	STA wm_SpriteProp
	LDA wm_SpritesLocked
	BNE +++
	LDA wm_SpriteDecTbl1,X
	CMP #$08
	BCS +++
	LDY #$00
	LDA wm_FrameA
	LSR
	JSR _02EB3D
	JSR SubOffscreen0Bnk2
	JSL UpdateSpritePos
	LDA wm_SpriteDecTbl1,X
	BNE ++
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
+	LDA wm_SprObjStatus,X
	AND #$08
	BEQ +
	LDA #$10
	STA wm_SpriteSpeedY,X
+	LDA wm_SprObjStatus,X
	AND #$04
	BEQ ++
	LDA wm_SpriteSpeedY,X
	CMP #$38
	LDA #$E0
	BCC +
	LDA #$D0
+	STA wm_SpriteSpeedY,X
	LDA #$08
	LDY wm_SpriteSlopeTbl,X
	BEQ ++
	BPL +
	LDA #$F8
+	STA wm_SpriteSpeedX,X
++	JSL SprSprMarioSprRts
+++	RTS

GrowingPipeMain:
	PHB
	PHK
	PLB
	JSR CODE_02E845
	PLB
	RTL

DATA_02E835:	.DB $00,$F0,$00,$10

DATA_02E839:	.DB $20,$40,$20,$40

GrowingPipeTiles1:	.DB $00,$14,$00,$02

GrowingPipeTiles2:	.DB $00,$15,$00,$02

CODE_02E845:
	LDA wm_SpriteMiscTbl5,X
	BMI CODE_02E872
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC wm_SpriteMiscTbl5,X
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	LDY #$03
	JSR GrowingPipeGfx
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	LDA wm_SpriteMiscTbl5,X
	SEC
	SBC #$10
	STA wm_SpriteMiscTbl5,X
	RTS

CODE_02E872:
	JSR CODE_02E902
	JSR SubOffscreen0Bnk2
	LDA wm_SpritesLocked
	ORA wm_OffscreenHorz,X
	BNE _02E8B5
	JSR CODE_02D4FA
	LDA m15
	CLC
	ADC #$50
	CMP #$A0
	BCS _02E8B5
	LDA wm_SpriteState,X
	AND #$03
	TAY
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP DATA_02E839,Y
	BNE CODE_02E8A2
	STZ wm_SpriteMiscTbl6,X
	INC wm_SpriteState,X
	BRA _02E8B5

CODE_02E8A2:
	LDA DATA_02E835,Y
	STA wm_SpriteSpeedY,X
	BEQ +
	LDA wm_SpriteYLo,X
	AND #$0F
	BNE +
	JSR GrowingPipeGfx
+	JSR UpdateYPosNoGrvty2
_02E8B5:
	JSL InvisBlkMainRt
	RTS

GrowingPipeGfx:
	LDA GrowingPipeTiles1,Y
	STA wm_TempTileGen
	LDA GrowingPipeTiles2,Y
	STA wm_18B6
	LDA wm_TempTileGen
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
	LDA wm_18B6
	STA wm_BlockId
	LDA wm_SpriteXLo,X
	CLC
	ADC #$10
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	JSL GenerateTile
	RTS

CODE_02E902:
	JSR GetDrawInfo2
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	DEC A
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA #$A4
	STA wm_OamSlot.1.Tile,Y
	LDA #$A6
	STA wm_OamSlot.2.Tile,Y
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
_02E92E:
	LDA #$01
	LDY #$02
	JMP _02B7A7

PipeLakituMain:
	PHB
	PHK
	PLB
	JSR CODE_02E93D
	PLB
	RTL

CODE_02E93D:
	LDA wm_SpriteStatus,X
	CMP #$02
	BNE CODE_02E94C
	LDA #$02
	STA wm_SpriteGfxTbl,X
	JMP CODE_02E9EC

CODE_02E94C:
	JSR CODE_02E9EC
	LDA wm_SpritesLocked
	BNE _Return02E985
	STZ wm_SpriteGfxTbl,X
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	LDA wm_SpriteState,X
	JSL ExecutePtr

PipeLakituPtrs:
	.DW CODE_02E96D
	.DW CODE_02E986
	.DW CODE_02E9B4
	.DW CODE_02E9BD
	.DW CODE_02E9D5

CODE_02E96D:
	LDA wm_SpriteDecTbl1,X
	BNE _Return02E985
	JSR CODE_02D4FA
	LDA m15
	CLC
	ADC #$13
	CMP #$36
	BCC _Return02E985
	LDA #$90
_02E980:
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
_Return02E985:
	RTS

CODE_02E986:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02E996
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
	LDA #$0C
	BRA _02E980

CODE_02E996:
	CMP #$7C
	BCC CODE_02E9A2
_02E99A:
	LDA #$F8
_02E99C:
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	RTS

CODE_02E9A2:
	CMP #$50
	BCS ++
	LDY #$00
	LDA wm_FrameA
	AND #$20
	BEQ +
	INY
+	TYA
	STA wm_SpriteDir,X
++	RTS

CODE_02E9B4:
	LDA wm_SpriteDecTbl1,X
	BNE _02E99A
	LDA #$80
	BRA _02E980

CODE_02E9BD:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02E9C6
	LDA #$20
	BRA _02E980

CODE_02E9C6:
	CMP #$40
	BNE CODE_02E9CF
	JSL CODE_01EA19
	RTS

CODE_02E9CF:
	BCS +
	INC wm_SpriteGfxTbl,X
+	RTS

CODE_02E9D5:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_02E9E2
	LDA #$50
	JSR _02E980
	STZ wm_SpriteState,X
	RTS

CODE_02E9E2:
	LDA #$08
	BRA _02E99C

PipeLakitu1:	.DB $EC,$A8,$CE

PipeLakitu2:	.DB $EE,$EE,$EE

CODE_02E9EC:
	JSR GetDrawInfo2
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.YPos,Y
	PHX
	LDA wm_SpriteGfxTbl,X
	TAX
	LDA.W PipeLakitu1,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W PipeLakitu2,X
	STA wm_OamSlot.2.Tile,Y
	PLX
	LDA wm_SpriteDir,X
	LSR
	ROR
	LSR
	EOR #$5B
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	JMP _02E92E

CODE_02EA25:
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.Tile,Y
	STA m0
	STZ m1
	LDA #$06
	STA wm_OamSlot.1.Tile,Y
	REP #$20
	LDA m0
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC #$8500
	STA wm_0D85+6
	CLC
	ADC #$0200
	STA wm_0D85+16
	SEP #$20
	RTL

CODE_02EA4E:
	LDY #$0B
-	TYA
	CMP wm_SpriteMiscTbl8,X
	BEQ ++
	EOR wm_FrameA
	LSR
	BCS ++
	CPY wm_SprProcessIndex
	BEQ ++
	STY wm_CheckSprInter
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC ++
	LDA.W wm_SpriteNum,Y
	CMP #$70
	BEQ ++
	CMP #$0E
	BEQ ++
	CMP #$1D
	BCC +
	LDA wm_Tweaker1686,Y
	AND #$03
	ORA wm_YoshiGrowTimer
	BNE ++
+	JSR CODE_02EA8A
++	DEY
	BPL -
	RTL

CODE_02EA8A:
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC ++
	LDA wm_SpriteDecTbl6,X
	BEQ +
	JSL CODE_03C023
	LDA wm_YoshiGrowTimer
	BNE ADDR_02EACE
+	LDA #$37
	STA wm_SpriteDecTbl6,X
	LDY wm_CheckSprInter
	STA wm_SprBehindScrn,Y
	LDA wm_CheckSprInter
	STA wm_SpriteMiscTbl8,X
	STZ wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	CMP.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	SBC wm_SpriteXHi,Y
	BCC ++
	INC wm_SpriteDir,X
++	RTS

ADDR_02EACE:
	STZ wm_SpriteDecTbl6,X
	RTS

WarpBlocksMain:
	PHB
	PHK
	PLB
	JSR CODE_02EADA
	PLB
	RTL

CODE_02EADA:
	JSL MarioSprInteract
	BCC +
	STZ wm_MarioSpeedX
	LDA wm_SpriteXLo,X
	CLC
	ADC #$0A
	STA wm_MarioXPos
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_MarioXPos+1
+	RTS

Return02EAF1:
	RTS ; unused

CODE_02EAF2:
	JSL FindFreeSprSlot
	BMI +
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$77
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	TYX
	JSL InitSpriteTables
	LDA #$30
	STA wm_SpriteDecTbl2,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
+	RTL

SuperKoopaMain:
	PHB
	PHK
	PLB
	JSR CODE_02EB31
	PLB
	RTL

DATA_02EB2F:	.DB $18,$E8

CODE_02EB31:
	JSR CODE_02ECDE
	LDA wm_SpriteStatus,X
	CMP #$02
	BNE CODE_02EB49
	LDY #$04
_02EB3D:
	LDA wm_FrameB
	AND #$04
	BEQ +
	INY
+	TYA
	STA wm_SpriteGfxTbl,X
	RTS

CODE_02EB49:
	LDA wm_SpritesLocked
	BNE +
	JSR SubOffscreen0Bnk2
	JSL SprSprMarioSprRts
	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteNum,X
	CMP #$73
	BEQ CODE_02EB7D
	LDY wm_SpriteDir,X
	LDA DATA_02EB2F,Y
	STA wm_SpriteSpeedX,X
	JSR _02EBF8
	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpriteSpeedY,X
	CMP #$F0
	BMI +
	CLC
	ADC #$FF
	STA wm_SpriteSpeedY,X
+	RTS

CODE_02EB7D:
	LDA wm_SpriteState,X
	JSL ExecutePtr

SuperKoopaPtrs:
	.DW CODE_02EB8D
	.DW CODE_02EBD1
	.DW CODE_02EBE7

DATA_02EB89:	.DB $18,$E8

DATA_02EB8B:	.DB $01,$FF

CODE_02EB8D:
	LDA wm_FrameA
	AND #$00
	STA m1
	STZ m0
	LDY wm_SpriteDir,X
	LDA wm_SpriteSpeedX,X
	CMP DATA_02EB89,Y
	BEQ ++
	CLC
	ADC DATA_02EB8B,Y
	LDY m1
	BNE +
	STA wm_SpriteSpeedX,X
+	INC m0
++	INC wm_SpriteMiscTbl3,X
	LDA wm_SpriteMiscTbl3,X
	CMP #$30
	BEQ CODE_02EBCA
_02EBB5:
	LDY #$00
	LDA wm_FrameA
	AND #$04
	BEQ +
	INY
+	TYA
	LDY m0
	BNE +
	CLC
	ADC #$06
+	STA wm_SpriteGfxTbl,X
	RTS

CODE_02EBCA:
	INC wm_SpriteState,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	RTS

CODE_02EBD1:
	LDA wm_SpriteSpeedY,X
	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
	CMP #$14
	BMI +
	INC wm_SpriteState,X
+	STZ m0
	JSR _02EBB5
	INC wm_SpriteGfxTbl,X
	RTS

CODE_02EBE7:
	LDY wm_SpriteDir,X
	LDA DATA_02EB89,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedY,X
	BEQ _02EBF8
	CLC
	ADC #$FF
	STA wm_SpriteSpeedY,X
_02EBF8:
	LDY #$02
	LDA wm_FrameA
	AND #$04
	BEQ +
	INY
+	TYA
	STA wm_SpriteGfxTbl,X
	RTS

DATA_02EC06:
	.DB $08,$08,$10,$00,$08,$08,$10,$00
	.DB $08,$10,$10,$00,$08,$10,$10,$00
	.DB $09,$09,$00,$00,$09,$09,$00,$00
	.DB $08,$10,$00,$00,$08,$10,$00,$00
	.DB $08,$10,$00,$00,$00,$00,$F8,$00
	.DB $00,$00,$F8,$00,$00,$F8,$F8,$00
	.DB $00,$F8,$F8,$00,$FF,$FF,$00,$00
	.DB $FF,$FF,$00,$00,$00,$F8,$00,$00
	.DB $00,$F8,$00,$00,$00,$F8,$00,$00

DATA_02EC4E:
	.DB $00,$08,$08,$00,$00,$08,$08,$00
	.DB $03,$03,$08,$00,$03,$03,$08,$00
	.DB $FF,$07,$00,$00,$FF,$07,$00,$00
	.DB $FD,$FD,$00,$00,$FD,$FD,$00,$00
	.DB $FD,$FD,$00,$00

SuperKoopaTiles:
	.DB $C8,$D8,$D0,$E0,$C9,$D9,$C0,$E2
	.DB $E4,$E5,$F2,$E0,$F4,$F5,$F2,$E0
	.DB $DA,$CA,$E0,$CF,$DB,$CB,$E0,$CF
	.DB $E4,$E5,$E0,$CF,$F4,$F5,$E2,$CF
	.DB $E4,$E5,$E2,$CF

DATA_02EC96:
	.DB $03,$03,$03,$00,$03,$03,$03,$00
	.DB $03,$03,$01,$01,$03,$03,$01,$01
	.DB $83,$83,$80,$00,$83,$83,$80,$00
	.DB $03,$03,$00,$01,$03,$03,$00,$01
	.DB $03,$03,$00,$01

DATA_02ECBA:
	.DB $00,$00,$00,$02,$00,$00,$00,$02
	.DB $00,$00,$00,$02,$00,$00,$00,$02
	.DB $00,$00,$02,$00,$00,$00,$02,$00
	.DB $00,$00,$02,$00,$00,$00,$02,$00
	.DB $00,$00,$02,$00

CODE_02ECDE:
	JSR GetDrawInfo2
	LDA wm_SpriteDir,X
	STA m2
	LDA wm_SpritePal,X
	AND #$0E
	STA m5
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	STA m3
	PHX
	STZ m4
_02ECF7:
	LDA m3
	CLC
	ADC m4
	TAX
	LDA m1
	CLC
	ADC.W DATA_02EC4E,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W SuperKoopaTiles,X
	STA wm_OamSlot.1.Tile,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_02ECBA,X
	STA wm_OamSize.1,Y
	PLY
	LDA m2
	LSR
	LDA.W DATA_02EC96,X
	AND #$02
	BEQ CODE_02ED4D
	PHP
	PHX
	LDX wm_SprProcessIndex
	LDA wm_SpriteMiscTbl5,X
	BEQ CODE_02ED3B
	LDA wm_FrameB
	LSR
	AND #$01
	PHY
	TAY
	LDA DATA_02ED39,Y
	PLY
	BRA _02ED44

DATA_02ED39:	.DB $10,$0A

CODE_02ED3B:
	LDA wm_SpriteNum,X
	CMP #$72
	LDA #$08
	BCC _02ED44
	LSR
_02ED44:
	PLX
	PLP
	ORA.W DATA_02EC96,X
	AND #$FD
	BRA _02ED52

CODE_02ED4D:
	LDA.W DATA_02EC96,X
	ORA m5
_02ED52:
	ORA wm_SpriteProp
	BCS +
	PHA
	TXA
	CLC
	ADC #$24
	TAX
	PLA
	ORA #$40
+	STA wm_OamSlot.1.Prop,Y
	LDA m0
	CLC
	ADC.W DATA_02EC06,X
	STA wm_OamSlot.1.XPos,Y
	INY
	INY
	INY
	INY
	INC m4
	LDA m4
	CMP #$04
	BNE _02ECF7
	PLX
	LDY #$FF
	LDA #$03
	JMP _02B7A7

DATA_02ED7F:	.DB $10,$20,$30

FloatingSkullInit:
	PHB
	PHK
	PLB
	JSR CODE_02ED8A
	PLB
	RTL

CODE_02ED8A:
	STZ wm_SkullFloatSpeed
	INC wm_SpriteState,X
	LDA #$02
	STA m0
-	JSL FindFreeSprSlot
	BMI +
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$61
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	LDX m0
	LDA.W DATA_02ED7F,X
	LDX wm_SprProcessIndex
	CLC
	ADC wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
+	DEC m0
	BPL -
	RTS

FloatingSkullMain:
	PHB
	PHK
	PLB
	JSR CODE_02EDD8
	PLB
	RTL

CODE_02EDD8:
	LDA wm_SpriteState,X
	BEQ CODE_02EDF6
	JSR SubOffscreen0Bnk2
	LDA wm_SpriteStatus,X
	BNE CODE_02EDF6
	LDY #$09
-	LDA.W wm_SpriteNum,Y
	CMP #$61
	BNE +
	LDA #$00
	STA wm_SpriteStatus,Y
+	DEY
	BPL -
_Return02EDF5:
	RTS

CODE_02EDF6:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LSR
	LDA #$E0
	BCC +
	LDA #$E2
+	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.YPos,Y
	CMP #$F0
	BCS +
	CLC
	ADC #$03
	STA wm_OamSlot.1.YPos,Y
+	LDA wm_SpritesLocked
	BNE _Return02EDF5
	STZ m0
	LDY #$09
-	LDA wm_SpriteStatus,Y
	BEQ +
	LDA.W wm_SpriteNum,Y
	CMP #$61
	BNE +
	LDA wm_SprObjStatus,Y
	AND #$0F
	BEQ +
	STA m0
+	DEY
	BPL -
	LDA wm_SkullFloatSpeed
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedY,X
	CMP #$20
	BMI +
	LDA #$20
	STA wm_SpriteSpeedY,X
+	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	LDA #$10
	STA wm_SpriteSpeedY,X
+	JSL MarioSprInteract
	BCC ++
	LDA wm_MarioSpeedY
	BMI ++
	LDA #$0C
	STA wm_SkullFloatSpeed
	LDA wm_SprOAMIndex,X
	TAX
	INC wm_OamSlot.1.YPos,X
	LDX wm_SprProcessIndex
	LDA #$01
	STA wm_IsOnSolidSpr
	STZ wm_IsFlying
	LDA #$1C
	LDY wm_OnYoshi
	BEQ +
	LDA #$2C
+	STA m1
	LDA wm_SpriteYLo,X
	SEC
	SBC m1
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_MarioYPos+1
	LDA wm_MarioObjStatus
	AND #$01
	BNE ++
	LDY #$00
	LDA wm_SprPixelMove
	BPL +
	DEY
+	CLC
	ADC wm_MarioXPos
	STA wm_MarioXPos
	TYA
	ADC wm_MarioXPos+1
	STA wm_MarioXPos+1
++	RTS

CoinCloudMain:
	PHB
	PHK
	PLB
	JSR ADDR_02EEB5
	PLB
	RTL

DATA_02EEB1:	.DB $01,$FF

DATA_02EEB3:	.DB $10,$F0

ADDR_02EEB5:
	LDA wm_SpriteState,X
	BNE +
	INC wm_SpriteState,X
	STZ wm_CoinGameCoins
+	LDA wm_SpritesLocked
	BNE +++
	LDA wm_FrameB
	AND #$7F
	BNE +
	LDA wm_SpriteMiscTbl6,X
	CMP #$0B
	BCS +
	INC wm_SpriteMiscTbl6,X
	JSR ADDR_02EF67
+	LDA wm_FrameB
	AND #$01
	BNE ++
	LDA wm_SpriteYLo,X
	STA m0
	LDA wm_SpriteYHi,X
	STA m1
	LDA #$10
	STA m2
	LDA #$01
	STA m3
	REP #$20
	LDA m0
	CMP m2
	SEP #$20
	LDY #$00
	BCC +
	INY
+	LDA wm_SpriteMiscTbl6,X
	CMP #$0B
	BCC +
	JSR SubOffscreen0Bnk2
	LDY #$01
+	LDA wm_SpriteSpeedY,X
	CMP DATA_02EEB3,Y
	BEQ ++
	CLC
	ADC DATA_02EEB1,Y
	STA wm_SpriteSpeedY,X
++	JSR UpdateYPosNoGrvty2
	LDA #$08
	STA wm_SpriteSpeedX,X
	JSR UpdateXPosNoGrvty2
+++	LDA wm_SprOAMIndex,X
	PHA
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA #$60
	STA wm_OamSlot.1.Tile,Y
	LDA wm_FrameB
	ASL
	ASL
	ASL
	AND #$C0
	ORA #$30
	STA wm_OamSlot.1.Prop,Y
	PLA
	STA wm_SprOAMIndex,X
	JSR GetDrawInfo2
	LDA m0
	CLC
	ADC #$04
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC #$04
	STA wm_OamSlot.1.YPos,Y
	LDA #$4D
	STA wm_OamSlot.1.Tile,Y
	LDA #$39
	STA wm_OamSlot.1.Prop,Y
	LDY #$00
	LDA #$00
	JSR _02B7A7
	RTS

ADDR_02EF67:
	LDA wm_CoinGameCoins
	CMP #$0A
	BCC ADDR_02EFAA
	LDY #$0B
-	LDA wm_SpriteStatus,Y
	BEQ ADDR_02EF7B
	DEY
	CPY #$09
	BNE -
	RTS

ADDR_02EF7B:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$78
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
	LDA #$E0
	STA wm_SpriteSpeedY,X
	INC wm_SpriteDir,X
	PLX
	RTS

ADDR_02EFAA:
	LDA wm_SpriteMiscTbl6,X
	CMP #$0B
	BCS +
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ ADDR_02EFBC
	DEY
	BPL -
+	RTS

ADDR_02EFBC:
	LDA #$0A
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_ExSpriteYHi,Y
	LDA #$D0
	STA wm_ExSprSpeedY,Y
	LDA #$00
	STA wm_ExSprSpeedX,Y
	STA wm_ExSpriteTbl1,Y
	RTS

DATA_02EFEA:	.DB $00,$80,$00,$80

DATA_02EFEE:	.DB $00,$00,$01,$01

WigglerInit:
	PHB
	PHK
	PLB
	JSR CODE_02F011
	LDY #$7E
-	LDA wm_SpriteXLo,X
	STA [wm_WigglerPosPtr],Y
	LDA wm_SpriteYLo,X
	INY
	STA [wm_WigglerPosPtr],Y
	DEY
	DEY
	DEY
	BPL -
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
	PLB
	RTL

CODE_02F011:
	TXA
	AND #$03
	TAY
	LDA #<wm_WigglerSegments
	CLC
	ADC DATA_02EFEA,Y
	STA wm_WigglerPosPtr
	LDA #>wm_WigglerSegments
	ADC DATA_02EFEE,Y
	STA wm_WigglerPosPtr+1
	LDA #wm_WigglerSegments>>16
	STA wm_WigglerPosPtr+2
	RTS

WigglerMain:
	PHB
	PHK
	PLB
	JSR WigglerMainRt
	PLB
	RTL

WigglerSpeed:	.DB $08,$F8,$10,$F0

WigglerMainRt:
	JSR CODE_02F011
	LDA wm_SpritesLocked
	BEQ CODE_02F03F
	JMP _02F0D8

CODE_02F03F:
	JSL SprSprInteract
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02F061
	CMP #$01
	BNE CODE_02F050
	LDA #$08
	BRA _02F052

CODE_02F050:
	AND #$0E
_02F052:
	STA m0
	LDA wm_SpritePal,X
	AND #$F1
	ORA m0
	STA wm_SpritePal,X
	JMP _02F0D8

CODE_02F061:
	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	JSR SubOffscreen0Bnk2
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl3,X
	BEQ +
	INC wm_SpriteMiscTbl6,X
	INC wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl5,X
	AND #$3F
	BNE +
	JSR CODE_02D4FA
	TYA
	STA wm_SpriteDir,X
+	LDY wm_SpriteDir,X
	LDA wm_SpriteMiscTbl3,X
	BEQ +
	INY
	INY
+	LDA WigglerSpeed,Y
	STA wm_SpriteSpeedX,X
	INC wm_SpriteSpeedY,X
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$03
	BNE CODE_02F0AE
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ CODE_02F0AE
	JSR CODE_02FFD1
	BRA _02F0C3

CODE_02F0AE:
	LDA wm_SpriteDecTbl5,X
	BNE _02F0C3
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
	STZ wm_SpriteGfxTbl,X
	LDA #$08
	STA wm_SpriteDecTbl5,X
_02F0C3:
	JSR CODE_02F0DB
	LDA wm_SpriteGfxTbl,X
	INC wm_SpriteGfxTbl,X
	AND #$07
	BNE _02F0D8
	LDA wm_SpriteState,X
	ASL
	ORA wm_SpriteDir,X
	STA wm_SpriteState,X
_02F0D8:
	JMP CODE_02F110

CODE_02F0DB:
	PHX
	PHB
	REP #$30
	LDA wm_WigglerPosPtr
	CLC
	ADC #$007D
	TAX
	LDA wm_WigglerPosPtr
	CLC
	ADC #$007F
	TAY
	LDA #$007D
	MVP wm_WigglerSegments>>16,wm_WigglerSegments>>16
	SEP #$30
	PLB
	PLX
	LDY #$00
	LDA wm_SpriteXLo,X
	STA [wm_WigglerPosPtr],Y
	LDA wm_SpriteYLo,X
	INY
	STA [wm_WigglerPosPtr],Y
	RTS

DATA_02F103:	.DB $00,$1E,$3E,$5E,$7E

DATA_02F108:	.DB $00,$01,$02,$01

WigglerTiles:	.DB $C4,$C6,$C8,$C6

CODE_02F110:
	JSR GetDrawInfo2
	LDA wm_SpriteMiscTbl6,X
	STA m3
	LDA wm_SpritePal,X
	STA m7
	LDA wm_SpriteMiscTbl3,X
	STA m8
	LDA wm_SpriteState,X
	STA m2
	TYA
	CLC
	ADC #$04
	TAY
	LDX #$00
-	PHX
	STX m5
	LDA m3
	LSR
	LSR
	LSR
	NOP
	NOP
	NOP
	NOP
	CLC
	ADC m5
	AND #$03
	STA m6
	PHY
	LDY.W DATA_02F103,X
	LDA m8
	BEQ +
	TYA
	LSR
	AND #$FE
	TAY
+	STY m9
	LDA [wm_WigglerPosPtr],Y
	PLY
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	PHY
	LDY m9
	INY
	LDA [wm_WigglerPosPtr],Y
	PLY
	SEC
	SBC wm_Bg1VOfs
	LDX m6
	SEC
	SBC.W DATA_02F108,X
	STA wm_OamSlot.1.YPos,Y
	PLX
	PHX
	LDA #$8C
	CPX #$00
	BEQ +
	LDX m6
	LDA.W WigglerTiles,X
+	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA m7
	ORA wm_SpriteProp
	LSR m2
	BCS +
	ORA #$40
+	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	INX
	CPX #$05
	BNE -
	LDX wm_SprProcessIndex
	LDA m8
	BEQ CODE_02F1C7
	PHX
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDir,X
	TAX
	LDA wm_OamSlot.2.XPos,Y
	CLC
	ADC.W WigglerEyesX,X
	PLX
	STA wm_OamSlot.1.XPos,Y
	LDA wm_OamSlot.2.YPos,Y
	STA wm_OamSlot.1.YPos,Y
	LDA #$88
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.2.Prop,Y
	BRA _02F1EF

CODE_02F1C7:
	PHX
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDir,X
	TAX
	LDA wm_OamSlot.2.XPos,Y
	CLC
	ADC.W DATA_02F2D3,X
	PLX
	STA wm_OamSlot.1.XPos,Y
	LDA wm_OamSlot.2.YPos,Y
	SEC
	SBC #$08
	STA wm_OamSlot.1.YPos,Y
	LDA #$98
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.2.Prop,Y
	AND #$F1
	ORA #$0A
_02F1EF:
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	LDA #$05
	LDY #$FF
	JSR _02B7A7
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	REP #$20
	LDA m0
	SEC
	SBC wm_MarioXPos
	CLC
	ADC #$0050
	CMP #$00A0
	SEP #$20
	BCS ++
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	LDA #$04
	STA m0
	LDY wm_SprOAMIndex,X
_02F22B:
	LDA wm_OamSlot.2.XPos,Y
	SEC
	SBC wm_MarioScrPosX
	ADC #$0C
	CMP #$18
	BCS CODE_02F29B
	LDA wm_OamSlot.2.YPos,Y
	SEC
	SBC wm_MarioScrPosY
	SBC #$10
	PHY
	LDY wm_OnYoshi
	BEQ +
	SBC #$10
+	PLY
	CLC
	ADC #$0C
	CMP #$18
	BCS CODE_02F29B
	LDA wm_StarPowerTimer
	BNE ADDR_02F29D
	LDA wm_SpriteDecTbl2,X
	ORA wm_MarioScrPosY+1
	BNE CODE_02F29B
	LDA #$08
	STA wm_SpriteDecTbl2,X
	LDA wm_SprChainStomped
	BNE +
	LDA wm_MarioSpeedY
	CMP #$08
	BMI CODE_02F296
+	LDA #$03
	STA wm_SoundCh1
	JSL BoostMarioSpeed
	LDA wm_SpriteMiscTbl3,X
	ORA wm_SpriteEatenTbl,X
	BNE ++
	JSL DisplayContactGfx
	LDA wm_SprChainStomped
	INC wm_SprChainStomped ; BUG-FIX: ID 003-00
	JSL GivePoints
	LDA #$40
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteMiscTbl3,X
	JSR CODE_02F2D7
++	RTS

CODE_02F296:
	JSL HurtMario
	RTS

CODE_02F29B:
	BRA CODE_02F2C7

ADDR_02F29D:
	LDA #$02
	STA wm_SpriteStatus,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	INC wm_StarKillPoints
	LDA wm_StarKillPoints
	CMP #$09
	BCC +
	LDA #$09
	STA wm_StarKillPoints
+	JSL GivePoints
	LDY wm_StarKillPoints
	CPY #$08
	BCS +
	LDA DATA_02D580-1,Y
	STA wm_SoundCh1
+	RTS

CODE_02F2C7:
	INY
	INY
	INY
	INY
	DEC m0
	BMI Return02F2D2
	JMP _02F22B

Return02F2D2:
	RTS

DATA_02F2D3:	.DB $00,$08

WigglerEyesX:	.DB $04,$04

CODE_02F2D7:
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_02F2E2
	DEY
	BPL -
	RTS

CODE_02F2E2:
	LDA #$0E
	STA wm_ExSpriteNum,Y
	LDA #$01
	STA wm_ExSpriteTbl1,Y
	LDA wm_SpriteXLo,X
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYHi,Y
	LDA #$D0
	STA wm_ExSprSpeedY,Y
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_ExSprSpeedX,Y
	RTS

BirdsMain:
	PHB
	PHK
	PLB
	JSR CODE_02F317
	PLB
	RTL

CODE_02F317:
	LDA wm_SpriteDecTbl5,X
	BEQ +
	LDA #$04
	STA wm_SpriteGfxTbl,X
+	JSR CODE_02F3EA
	JSR UpdateXPosNoGrvty2
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteSpeedY,X
	CLC
	ADC #$03
	STA wm_SpriteSpeedY,X
	LDA wm_SpriteState,X
	JSL ExecutePtr

BirdsPtrs:
	.DW CODE_02F342
	.DW CODE_02F38F

Return02F33B:
	RTS ; unused

DATA_02F33C:	.DB $02,$03,$05,$01

DATA_02F340:	.DB $08,$F8

CODE_02F342:
	LDY wm_SpriteDir,X
	LDA DATA_02F340,Y
	STA wm_SpriteSpeedX,X
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteSpeedY,X
	BMI +
	LDA wm_SpriteYLo,X
	CMP #$E8
	BCC +
	AND #$F8
	STA wm_SpriteYLo,X
	LDA #$F0
	STA wm_SpriteSpeedY,X
	LDA wm_SpriteXLo,X
	CLC
	ADC #$30
	CMP #$60
	BCC CODE_02F381
	LDA wm_SpriteMiscTbl6,X
	BEQ CODE_02F371
	DEC wm_SpriteMiscTbl6,X
+	RTS

CODE_02F371:
	INC wm_SpriteState,X
	JSL GetRand
	AND #$03
	TAY
	LDA DATA_02F33C,Y
	STA wm_SpriteMiscTbl6,X
	RTS

CODE_02F381:
	LDA wm_SpriteDecTbl2,X
	BNE +
	JSR _02F3C1
	LDA #$10
	STA wm_SpriteDecTbl2,X
+	RTS

CODE_02F38F:
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_02F3A3
	CMP #$08
	BCS +
	INC wm_SpriteGfxTbl,X
+	RTS

CODE_02F3A3:
	LDA wm_SpriteMiscTbl6,X
	BEQ CODE_02F3B7
	DEC wm_SpriteMiscTbl6,X
	JSL GetRand
	AND #$1F
	ORA #$0A
	STA wm_SpriteDecTbl1,X
	RTS

CODE_02F3B7:
	STZ wm_SpriteState,X
	JSL GetRand
	AND #$01
	BNE +
_02F3C1:
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
	LDA #$0A
	STA wm_SpriteDecTbl5,X
+	JSL GetRand
	AND #$03
	CLC
	ADC #$02
	STA wm_SpriteMiscTbl6,X
	RTS

BirdsTilemap:	.DB $D2,$D3,$D0,$D1,$9B

BirdsFlip:	.DB $71,$31

BirdsPal:	.DB $08,$04,$06,$0A

FireplaceTilemap:	.DB $30,$34,$48,$3C

CODE_02F3EA:
	TXA
	AND #$03
	TAY
	LDA BirdsPal,Y
	LDY wm_SpriteDir,X
	ORA BirdsFlip,Y
	STA m2
	TXA
	AND #$03
	TAY
	LDA FireplaceTilemap,Y
	TAY
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_ExOamSlot.1.YPos,Y
	PHX
	LDA wm_SpriteGfxTbl,X
	TAX
	LDA.W BirdsTilemap,X
	STA wm_ExOamSlot.1.Tile,Y
	PLX
	LDA m2
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	RTS

SmokeMain:
	PHB
	PHK
	PLB
	JSR CODE_02F434
	PLB
	RTL

CODE_02F434:
	INC wm_SpriteMiscTbl6,X
	LDY #$04
	LDA wm_SpriteMiscTbl6,X
	AND #$40
	BEQ +
	LDY #$FE
+	STY wm_SpriteSpeedX,X
	LDA #$FC
	STA wm_SpriteSpeedY,X
	JSR UpdateYPosNoGrvty2
	LDA wm_SpriteDecTbl1,X
	BNE +
	JSR UpdateXPosNoGrvty2
+	JSR CODE_02F47C
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BNE +
	STZ wm_SpriteStatus,X
+	RTS

DATA_02F463:
	.DB $03,$04,$05,$04,$05,$06,$05,$06
	.DB $07,$06,$07,$08,$07,$08,$07,$08
	.DB $07,$08,$07,$08,$07,$08,$07,$08
	.DB $07

CODE_02F47C:
	LDA wm_FrameB
	AND #$0F
	BNE +
	INC wm_SpriteMiscTbl3,X
+	LDY wm_SpriteMiscTbl3,X
	LDA DATA_02F463,Y
	STA m0
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	PHA
	SEC
	SBC m0
	STA wm_OamSlot.1.XPos,Y
	PLA
	CLC
	ADC m0
	STA wm_OamSlot.2.XPos,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA #$C5
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA #$05
	STA wm_OamSlot.1.Prop,Y
	ORA #$40
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	RTS

SideExitMain:
	PHB
	PHK
	PLB
	JSR CODE_02F4D5
	PLB
	RTL

CODE_02F4D5:
	LDA #$01
	STA wm_SideExitFlag
	LDA wm_SpriteXLo,X
	AND #$10
	BNE +
	JSR CODE_02F4EB
	JSR CODE_02F53E
+	RTS

DATA_02F4E7:	.DB $D4,$AB

DATA_02F4E9:	.DB $BB,$9A

CODE_02F4EB:
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$08
	TAY
	LDA #$B8
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA #$B0
	STA wm_OamSlot.1.YPos,Y
	LDA #$B8
	STA wm_OamSlot.2.YPos,Y
	LDA wm_FrameA
	AND #$03
	BNE +
	PHY
	JSL GetRand
	PLY
	AND #$03
	BNE +
	INC wm_SpriteState,X
+	PHX
	LDA wm_SpriteState,X
	AND #$01
	TAX
	LDA.W DATA_02F4E7,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02F4E9,X
	STA wm_OamSlot.2.Tile,Y
	LDA #$35
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	PLX
	RTS

CODE_02F53E:
	LDA wm_FrameB
	AND #$3F
	BNE +
	JSR CODE_02F548
+	RTS

CODE_02F548:
	LDY #$09
-	LDA wm_SpriteStatus,Y
	BEQ CODE_02F553
	DEY
	BPL -
	RTS

CODE_02F553:
	LDA #$8B
	STA.W wm_SpriteNum,Y
	LDA #$08
	STA wm_SpriteStatus,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDA #$BB
	STA wm_SpriteXLo,X
	LDA #$00
	STA wm_SpriteXHi,X
	LDA #$00
	STA wm_SpriteYHi,X
	LDA #$E0
	STA wm_SpriteYLo,X
	LDA #$20
	STA wm_SpriteDecTbl1,X
	PLX
	RTS

CODE_02F57C:
	PHB
	PHK
	PLB
	JSR CODE_02F759
	PLB
	RTL

CODE_02F584:
	PHB
	PHK
	PLB
	JSR CODE_02F66E
	PLB
	RTL

ADDR_02F58C:
	PHB
	PHK
	PLB
	JSR ADDR_02F639
	PLB
	RTL

GhostExitMain:
	PHB
	PHK
	PLB
	PHX
	JSR CODE_02F5D0
	PLX
	PLB
	RTL

DATA_02F59E:
	.DB $08,$18,$F8,$F8,$F8,$F8,$28,$28
	.DB $28,$28

DATA_02F5A8:
	.DB $00,$00,$FF,$FF,$FF,$FF,$00,$00
	.DB $00,$00

DATA_02F5B2:
	.DB $5F,$5F,$8F,$97,$A7,$AF,$8F,$97
	.DB $A7,$AF

DATA_02F5BC:
	.DB $9C,$9E,$A0,$B0,$B0,$A0,$A0,$B0
	.DB $B0,$A0

DATA_02F5C6:
	.DB $23,$23,$2D,$2D,$AD,$AD,$6D,$6D
	.DB $ED,$ED

CODE_02F5D0:
	LDA wm_Bg1HOfs
	CMP #$46
	BCS ++
	LDX #$09
	LDY #$A0
-	STZ m2
	LDA.W DATA_02F59E,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA.W DATA_02F5A8,X
	SBC wm_Bg1HOfs+1
	BEQ +
	INC m2
+	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA.W DATA_02F5B2,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_02F5BC,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02F5C6,X
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	ORA m2
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
++	RTS

DATA_02F619:	.DB $F8,$08,$F8,$08,$00,$00,$00,$00

DATA_02F621:	.DB $00,$00,$10,$10,$20,$30,$40,$08

DATA_02F629:	.DB $C7,$A7,$A7,$C7,$A9,$C9,$C9,$E0

DATA_02F631:	.DB $A9,$69,$A9,$69,$29,$29,$29,$6B

ADDR_02F639:
	LDX #$07
	LDY #$B0
-	LDA #$C0
	CLC
	ADC.W DATA_02F619,X
	STA wm_OamSlot.1.XPos,Y
	LDA #$70
	CLC
	ADC.W DATA_02F621,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_02F629,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_02F631,X
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
	RTS

CODE_02F66E:
	LDA wm_DoorIntroTimer
	BEQ +
	DEC wm_DoorIntroTimer
+	CMP #$B0
	BNE +
	LDY #$0F
	STY wm_SoundCh3
+	CMP #$01
	BNE +
	LDY #$10
	STY wm_SoundCh3
+	CMP #$30
	BCC _02F69A
	CMP #$81
	BCC CODE_02F698
	CLC
	ADC #$4F
	EOR #$FF
	INC A
	BRA _02F69A

CODE_02F698:
	LDA #$30
_02F69A:
	STA m0
	JSR CODE_02F6B8
	RTS

DATA_02F6A0:
	.DB $00,$10,$20,$00,$10,$20,$00,$10
	.DB $20,$00,$10,$20

DATA_02F6AC:
	.DB $00,$00,$00,$10,$10,$10,$20,$20
	.DB $20,$30,$30,$30

CODE_02F6B8:
	LDX #$0B
	LDY #$B0
-	LDA #$B8
	CLC
	ADC.W DATA_02F6A0,X
	STA wm_ExOamSlot.1.XPos,Y
	LDA #$50
	SEC
	SBC wm_Bg1VOfs
	SEC
	SBC m0
	CLC
	ADC.W DATA_02F6AC,X
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$A5
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$21
	STA wm_ExOamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
	RTS

DATA_02F6F1:
	.DB $00,$00,$00,$00,$10,$10,$10,$10
	.DB $00,$00,$00,$00,$10,$10,$10,$10
	.DB $00,$00,$00,$00,$10,$10,$10,$10
	.DB $F2,$F2,$F2,$F2,$1E,$1E,$1E,$1E

DATA_02F711:	.DB $00,$08,$18,$20,$00,$08,$18,$20

DATA_02F719:	.DB $7D,$7D,$FD,$FD,$3D,$3D,$BD,$BD

DATA_02F721:
	.DB $A0,$B0,$B0,$A0,$A0,$B0,$B0,$A0
	.DB $A3,$B3,$B3,$A3,$A3,$B3,$B3,$A3
	.DB $A2,$B2,$B2,$A2,$A2,$B2,$B2,$A2
	.DB $A3,$B3,$B3,$A3,$A3,$B3,$B3,$A3

DATA_02F741:	.DB $40,$44,$48,$4C,$F0,$F4,$F8,$FC

DATA_02F749:
	.DB $00,$01,$02,$03,$03,$03,$03,$03
	.DB $03,$03,$03,$03,$03,$02,$01,$00

CODE_02F759:
	LDA wm_DoorIntroTimer
	BEQ +
	DEC wm_DoorIntroTimer
+	CMP #$76
	BNE +
	LDY #$0F
	STY wm_SoundCh3
+	CMP #$08
	BNE +
	LDY #$10
	STY wm_SoundCh3
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_02F749,Y
	STA m3
	LDX #$07
	LDA #$B8
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA #$60
	SEC
	SBC wm_Bg1VOfs
	STA m1
_02F78C:
	STX m2
	LDY.W DATA_02F741,X
	LDA m3
	ASL
	ASL
	ASL
	CLC
	ADC m2
	TAX
	TYA
	BMI CODE_02F7D0
	LDA m0
	CLC
	ADC.W DATA_02F6F1,X
	STA wm_OamSlot.1.XPos,Y
	LDA.W DATA_02F721,X
	STA wm_OamSlot.1.Tile,Y
	LDX m2
	LDA m1
	CLC
	ADC.W DATA_02F711,X
	STA wm_OamSlot.1.YPos,Y
	LDA m3
	CMP #$03
	LDA.W DATA_02F719,X
	BCC +
	EOR #$40
+	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	BRA _02F801

CODE_02F7D0:
	LDA m0
	CLC
	ADC.W DATA_02F6F1,X
	STA wm_ExOamSlot.1.XPos,Y
	LDA.W DATA_02F721,X
	STA wm_ExOamSlot.1.Tile,Y
	LDX m2
	LDA m1
	CLC
	ADC.W DATA_02F711,X
	STA wm_ExOamSlot.1.YPos,Y
	LDA m3
	CMP #$03
	LDA.W DATA_02F719,X
	BCC +
	EOR #$40
+	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
_02F801:
	DEX
	BMI Return02F807
	JMP _02F78C

Return02F807:
	RTS

CODE_02F808:
	PHB
	PHK
	PLB
	JSR CODE_02F810
	PLB
	RTL

CODE_02F810:
	LDX #$13
-	STX wm_SprProcessIndex
	LDA wm_ClustSprNum,X
	BEQ +
	JSR CODE_02F821
+	DEX
	BPL -
_Return02F820:
	RTS

CODE_02F821:
	JSL ExecutePtr

Ptrs02F825:
	.DW _Return02F820
	.DW CODE_02FDBC
	.DW $0000
	.DW CODE_02FBC7
	.DW CODE_02FA98
	.DW CODE_02FA16
	.DW CODE_02F91C
	.DW CODE_02F83D
	.DW CODE_02FBC7

DATA_02F837:	.DB $01,$FF

DATA_02F839:	.DB $00,$FF,$02,$0E

CODE_02F83D:
	LDA wm_AppearBooCounter
	STA wm_TempTileGen
	TXY
	BNE +
	DEC wm_AppearBooCounter
	CMP #$00
	BNE +
	INC wm_BooRingAltIndex
	LDY #$FF
	STY wm_AppearBooCounter
+	CMP #$00
	BNE _02F89E
	LDA wm_AppearSprTimer
	BEQ CODE_02F865
	STZ wm_ClustSprNum,X
	STZ wm_BooRingAltIndex
	RTS

CODE_02F865:
	LDA wm_ClusBooFrame1X,X
	STA m0
	LDA wm_ClusBooFrame1Y,X
	STA m1
	LDA wm_BooRingAltIndex
	AND #$01
	BNE +
	LDA wm_ClusBooFrame2X,X
	STA m0
	LDA wm_ClusBooFrame2Y,X
	STA m1
+	LDA m0
	CLC
	ADC wm_Bg1HOfs
	STA wm_ClusterSprXLo,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_ClusterSprXHi,X
	LDA m1
	CLC
	ADC wm_Bg1VOfs
	STA wm_ClusterSprYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_ClusterSprYHi,X
_02F89E:
	TXA
	ASL
	ASL
	ADC wm_FrameB
	STA m0
	AND #$07
	ORA wm_SpritesLocked
	BNE +
	LDA m0
	AND #$20
	LSR
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA wm_ClusterSprYLo,X
	CLC
	ADC DATA_02F837,Y
	STA wm_ClusterSprYLo,X
	LDA wm_ClusterSprYHi,X
	ADC DATA_02F839,Y
	STA wm_ClusterSprYHi,X
+	LDY wm_TempTileGen
	CPY #$20
	BCC _Return02F8FB
	CPY #$40
	BCS CODE_02F8D8
	TYA
	SBC #$1F
	BRA _02F8E2

CODE_02F8D8:
	CPY #$E0
	BCC CODE_02F8E6
	TYA
	SBC #$E0
	EOR #$1F
	INC A
_02F8E2:
	LSR
	LSR
	BRA _02F8EB

CODE_02F8E6:
	JSR _02FBB0
	LDA #$08
_02F8EB:
	STA wm_BooBossPal
	CPX #$00
	BNE +
	JSL CODE_038239
+	LDA #$0F
	JSR _02FD48
_Return02F8FB:
	RTS

DATA_02F8FC:	.DB $00,$10,$00,$10,$08,$10,$FF,$10

SumoBroFlameTiles:	.DB $DC,$EC,$CC,$EC,$CC,$DC,$00,$CC

DATA_02F90C:
	.DB $03,$03,$03,$03,$02,$01,$00,$00
	.DB $00,$00,$00,$00,$01,$02,$03,$03

CODE_02F91C:
	LDA wm_ClusterSpriteTbl1,X
	BEQ CODE_02F93C
	LDY wm_SpritesLocked
	BNE +
	DEC wm_ClusterSpriteTbl1,X
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_02F90C,Y
	ASL
	STA wm_TempTileGen
	JSR CODE_02F9AE
	PHX
	JSR CODE_02F940
	PLX
	RTS

CODE_02F93C:
	STZ wm_ClustSprNum,X
	RTS

CODE_02F940:
	TXA
	ASL
	TAY
	LDA DATA_02FF50,Y
	STA wm_SprOAMIndex
	LDA wm_ClusterSprXLo,X
	STA wm_SpriteXLo
	LDA wm_ClusterSprXHi,X
	STA wm_SpriteXHi
	LDA wm_ClusterSprYLo,X
	STA wm_SpriteYLo
	LDA wm_ClusterSprYHi,X
	STA wm_SpriteYHi
	TAY
	LDX #$00
	JSR GetDrawInfo2
	LDX #$01
-	PHX
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	TXA
	ORA wm_TempTileGen
	TAX
	LDA.W DATA_02F8FC,X
	BMI +
	CLC
	ADC m1
	STA wm_OamSlot.1.YPos,Y
	LDA.W SumoBroFlameTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA wm_FrameB
	AND #$04
	ASL
	ASL
	ASL
	ASL
	NOP
	ORA wm_SpriteProp
	ORA #$05
	STA wm_OamSlot.1.Prop,Y
+	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	LDX #$00
	LDY #$02
	LDA #$01
	JSL FinishOAMWrite
	RTS

ADDR_02F9A6:
	STZ wm_ClustSprNum,X
	RTS

DATA_02F9AA:	.DB $02,$0A,$12,$1A

CODE_02F9AE:
	TXA
	EOR wm_FrameA
	AND #$03
	BNE +
	LDA wm_ClusterSpriteTbl1,X
	CMP #$10
	BCC +
	LDA wm_ClusterSprXLo,X
	CLC
	ADC #$02
	STA m4
	LDA wm_ClusterSprXHi,X
	ADC #$00
	STA m10
	LDA #$0C
	STA m6
	LDY wm_TempTileGen
	LDA wm_ClusterSprYLo,X
	CLC
	ADC DATA_02F9AA,Y
	STA m5
	LDA #$14
	STA m7
	LDA wm_ClusterSprYHi,X
	ADC #$00
	STA m11
	JSL GetMarioClipping
	JSL CheckForContact
	BCC +
	LDA wm_StarPowerTimer
	BNE ADDR_02F9A6
_02F9F5:
	LDA wm_OnYoshi
	BNE CODE_02F9FF
	JSL HurtMario
+	RTS

CODE_02F9FF:
	JMP _02A473

DATA_02FA02:	.DB $03,$07,$07,$07,$0F,$07,$07,$0F

DATA_02FA0A:	.DB $F0,$F4,$F8,$FC

CastleFlameTiles:	.DB $E2,$E4,$E2,$E4

CastleFlameGfxProp:	.DB $09,$09,$49,$49

CODE_02FA16:
	LDA wm_SpritesLocked
	BNE +
	JSL GetRand
	AND #$07
	TAY
	LDA wm_FrameA
	AND DATA_02FA02,Y
	BNE +
	INC wm_ClusterSpriteTbl1,X
+	LDY.W DATA_02FA0A,X
	LDA wm_ClusterSprXLo,X
	SEC
	SBC wm_Bg2HOfs
	STA wm_OamSlot.1.XPos,Y
	LDA wm_ClusterSprYLo,X
	SEC
	SBC wm_Bg2VOfs
	STA wm_OamSlot.1.YPos,Y
	PHY
	PHX
	LDA wm_ClusterSpriteTbl1,X
	AND #$03
	TAX
	LDA.W CastleFlameTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W CastleFlameGfxProp,X
	STA wm_OamSlot.1.Prop,Y
	PLX
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	PLY
	LDA wm_OamSlot.1.XPos,Y
	CMP #$F0
	BCC +
	LDA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.60.XPos
	LDA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.60.YPos
	LDA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.60.Tile
	LDA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.60.Prop
	LDA #$03
	STA wm_OamSize.60
+	RTS

DATA_02FA84:
	.DB $00,$00,$28,$00,$50,$00,$78,$00
	.DB $A0,$00,$C8,$00,$F0,$00,$18,$01
	.DB $40,$01,$68,$01

CODE_02FA98:
	LDY wm_ClusterSpriteTbl3,X
	LDA wm_BooRingOffscreen,Y
	BEQ CODE_02FAA4
	STZ wm_ClustSprNum,X
	RTS

CODE_02FAA4:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_ClusterSpriteTbl1,X
	BEQ ++
	STZ m0
	BPL +
	DEC m0
+	CLC
	ADC wm_BooRingLo,Y
	STA wm_BooRingLo,Y
	LDA wm_BooRingHi,Y
	ADC m0
	AND #$01
	STA wm_BooRingHi,Y
	LDA wm_BooRingXLo,Y
	STA m0
	LDA wm_BooRingXHi,Y
	STA m1
	REP #$20
	LDA m0
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$0080
	CMP #$0200
	SEP #$20
	BCC ++
	LDA #$01
	STA wm_BooRingOffscreen,Y
	PHX
	LDX wm_BooRingIndex,Y
	STZ wm_SprLoadStatus,X
	PLX
	DEC wm_BooRingAltIndex
++	PHX
	LDA wm_ClusterSpriteTbl2,X
	ASL
	TAX
	LDA.W DATA_02FA84,X
	CLC
	ADC wm_BooRingLo,Y
	STA m0
	LDA.W DATA_02FA84+1,X
	ADC wm_BooRingHi,Y
	AND #$01
	STA m1
	PLX
	REP #$30
	LDA m0
	CLC
	ADC #$0080
	AND #$01FF
	STA m2
	LDA m0
	AND #$00FF
	ASL
	TAX
	LDA.L CircleCoords,X
	STA m4
	LDA m2
	AND #$00FF
	ASL
	TAX
	LDA.L CircleCoords,X
	STA m6
	SEP #$30
	LDA m4
	STA WRMPYA
	LDA #$50
	LDY m5
	BNE +
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	ASL RDMPYL
	LDA RDMPYH
	ADC #$00
+	LSR m1
	BCC +
	EOR #$FF
	INC A
+	STA m4
	LDA m6
	STA WRMPYA
	LDA #$50
	LDY m7
	BNE +
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	ASL RDMPYL
	LDA RDMPYH
	ADC #$00
+	LSR m3
	BCC +
	EOR #$FF
	INC A
+	STA m6
	LDX wm_SprProcessIndex
	LDY wm_ClusterSpriteTbl3,X
	STZ m0
	LDA m4
	BPL +
	DEC m0
+	CLC
	ADC wm_BooRingXLo,Y
	STA wm_ClusterSprXLo,X
	LDA wm_BooRingXHi,Y
	ADC m0
	STA wm_ClusterSprXHi,X
	STZ m1
	LDA m6
	BPL +
	DEC m1
+	CLC
	ADC wm_BooRingYLo,Y
	STA wm_ClusterSprYLo,X
	LDA wm_BooRingYHi,Y
	ADC m1
	STA wm_ClusterSprYHi,X
	JSR _02FC8D
_02FBB0:
	TXA
	EOR wm_FrameA
	AND #$03
	BNE +
	JSR CODE_02FE71
+	RTS

DATA_02FBBB:	.DB $01,$FF

DATA_02FBBD:	.DB $08,$F8

BooRingTiles:	.DB $88,$8C,$A8,$8E,$AA,$AE,$88,$8C

CODE_02FBC7:
	CPX #$00
	BEQ CODE_02FBCE
	JMP _02FC41

CODE_02FBCE:
	LDA wm_FrameA
	AND #$07
	ORA wm_SpritesLocked
	BNE ++
	JSL GetRand
	AND #$1F
	CMP #$14
	BCC +
	SBC #$14
+	TAX
	LDA wm_ClusterSpriteTbl3,X
	BNE ++
	INC wm_ClusterSpriteTbl3,X
	LDA #$20
	STA wm_ClusterSpriteTbl4,X
	STZ m0
	LDA wm_ClusterSprXLo,X
	SBC wm_Bg1HOfs
	ADC wm_Bg1HOfs
	PHP
	ADC m0
	STA wm_ClusterSprXLo,X
	STA wm_SpriteXLo
	LDA wm_Bg1HOfs+1
	ADC #$00
	PLP
	ADC #$00
	STA wm_ClusterSprXHi,X
	STA wm_SpriteXHi
	LDA wm_ClusterSprYLo,X
	SBC wm_Bg1VOfs
	ADC wm_Bg1VOfs
	STA wm_ClusterSprYLo,X
	STA wm_SpriteYLo
	AND #$FC
	STA wm_ClusterSpriteTbl2,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_ClusterSprYHi,X
	STA wm_SpriteYHi
	PHX
	LDX #$00
	LDA #$10
	JSR CODE_02D2FB
	PLX
	LDA m0
	ADC #$09
	STA wm_ClusBooFrame1Y,X
	LDA m1
	STA wm_ClusBooFrame1X,X
++	LDX wm_SprProcessIndex
_02FC41:
	LDA wm_SpritesLocked
	BNE +
	LDA wm_ClusterSpriteTbl4,X
	BEQ +
	DEC wm_ClusterSpriteTbl4,X
+	LDA wm_ClusterSpriteTbl3,X
	BNE CODE_02FC55
	JMP CODE_02FCE2

CODE_02FC55:
	LDA wm_SpritesLocked
	BNE _02FC8D
	LDA wm_ClusterSpriteTbl4,X
	BNE +
	JSR CODE_02FF98
	JSR CODE_02FFA3
	TXA
	EOR wm_FrameA
	AND #$03
	BNE +
	JSR CODE_02FE71
	LDA wm_ClusBooFrame1Y,X
	CMP #$E1
	BMI +
	DEC wm_ClusBooFrame1Y,X
+	LDA wm_ClusterSprYLo,X
	AND #$FC
	CMP wm_ClusterSpriteTbl2,X
	BNE _02FC8D
	LDA wm_ClusBooFrame1Y,X
	BPL _02FC8D
	STZ wm_ClusterSpriteTbl3,X
	STZ wm_ClusBooFrame1X,X
_02FC8D:
	LDA wm_ClusterSprXLo,X
	STA m0
	LDA wm_ClusterSprXHi,X
	STA m1
	REP #$20
	LDA m0
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$0040
	CMP #$0180
	SEP #$20
	BCS +
	LDA #$02
	JSR _02FD48
	LDA wm_ClusterSprYLo,X
	CLC
	ADC #$10
	PHP
	CMP wm_Bg1VOfs
	LDA wm_ClusterSprYHi,X
	SBC wm_Bg1VOfs+1
	PLP
	ADC #$00
	BNE CODE_02FCD9
	LDA wm_ClusterSprXLo,X
	CMP wm_Bg1HOfs
	LDA wm_ClusterSprXHi,X
	SBC wm_Bg1HOfs+1
	BEQ +
	LDA.W DATA_02FF50,X
	LSR
	LSR
	TAY
	LDA #$03
	STA wm_OamSize.1,Y
+	RTS

CODE_02FCD9:
	LDY.W DATA_02FF50,X
	LDA #$F0
	STA wm_OamSlot.1.YPos,Y
	RTS

CODE_02FCE2:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_ClustSprNum,X
	CMP #$08
	BEQ ++
	LDA wm_ClusterSpriteTbl4,X
	BNE +
	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_ClusterSpriteTbl1,X
	AND #$01
	TAY
	LDA wm_ClusBooFrame1X,X
	CLC
	ADC DATA_02FBBB,Y
	STA wm_ClusBooFrame1X,X
	CMP DATA_02FBBD,Y
	BNE +
	INC wm_ClusterSpriteTbl1,X
	LDA wm_RandomByte1
	AND #$FF
	ORA #$3F
	STA wm_ClusterSpriteTbl4,X
+	JSR CODE_02FF98
	TXA
	EOR wm_FrameA
	AND #$03
	BNE ++
	STZ m0
	LDY #$01
	TXA
	ASL
	ASL
	ASL
	ADC wm_FrameA
	AND #$40
	BEQ +
	LDY #$FF
	DEC m0
+	TYA
	CLC
	ADC wm_ClusterSprYLo,X
	STA wm_ClusterSprYLo,X
	LDA m0
	ADC wm_ClusterSprYHi,X
	STA wm_ClusterSprYHi,X
++	LDA #$0E
_02FD48:
	STA m2
	LDY.W DATA_02FF50,X
	LDA wm_ClusterSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	LDA wm_ClusterSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	LDA wm_FrameB
	LSR
	LSR
	LSR
	AND #$01
	STA m0
	TXA
	AND #$03
	ASL
	ADC m0
	PHX
	TAX
	LDA.W BooRingTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA wm_ClusBooFrame1X,X
	ASL
	LDA #$00
	BCS +
	LDA #$40
+	ORA #$31
	ORA m2
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	LDA wm_ClustSprNum,X
	CMP #$08
	BNE +
	LDY.W DATA_02FF50,X
	LDA wm_FrameB
	LSR
	LSR
	AND #$01
	STA m0
	LDA wm_ClusterSpriteTbl3,X
	ASL
	ORA m0
	PHX
	TAX
	LDA.W BatCeilingTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$37
	STA wm_OamSlot.1.Prop,Y
	PLX
+	RTS

BatCeilingTiles:	.DB $AE,$AE,$C0,$EB

CODE_02FDBC:
	JSR CODE_02FFA3
	LDA wm_ClusBooFrame1Y,X
	CMP #$40
	BPL +
	CLC
	ADC #$03
	STA wm_ClusBooFrame1Y,X
+	LDA wm_ClusterSprYHi,X
	BEQ +
	LDA wm_ClusterSprYLo,X
	CMP #$80
	BCC +
	AND #$F0
	STA wm_ClusterSprYLo,X
	STZ wm_ClusBooFrame1Y,X
+	TXA
	EOR wm_FrameA
	LSR
	BCC ++
	LDA wm_ClusBooFrame1Y,X
	BNE +
	LDA wm_ClusBooFrame1X,X
	CLC
	ADC wm_ClusterSprXLo,X
	STA wm_ClusterSprXLo,X
	LDA wm_ClusterSprXLo,X
	EOR wm_ClusBooFrame1X,X
	BPL +
	LDA wm_ClusterSprXLo,X
	CLC
	ADC #$20
	CMP #$30
	BCS +
	LDA wm_ClusBooFrame1X,X
	EOR #$FF
	INC A
	STA wm_ClusBooFrame1X,X
+	LDA wm_MarioXPos
	SEC
	SBC wm_ClusterSprXLo,X
	CLC
	ADC #$0C
	CMP #$1E
	BCS ++
	LDA #$20
	LDY wm_IsDucking
	BNE +
	LDY wm_MarioPowerUp
	BEQ +
	LDA #$30
+	STA m0
	LDA wm_MarioYPos
	SEC
	SBC wm_ClusterSprYLo,X
	CLC
	ADC #$20
	CMP m0
	BCS ++
	STZ wm_ClustSprNum,X
	JSR CODE_02FF6C
	DEC wm_Bonus1UpsRemaining
	BNE ++
	LDA #$58
	STA wm_BonusGameEndTimer
++	LDY.W DATA_02FF64,X
	LDA wm_ClusterSprXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_ClusterSprYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$24
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$3A
	STA wm_ExOamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
	RTS

CODE_02FE71:
	LDA #$14
	BRA _02FE77

ADDR_02FE75: ; unreachable, 0c instead of 14??
	LDA #$0C
_02FE77:
	STA m2
	STZ m3
	LDA wm_ClusterSprXLo,X
	STA m0
	LDA wm_ClusterSprXHi,X
	STA m1
	REP #$20
	LDA wm_MarioXPos
	SEC
	SBC m0
	CLC
	ADC #$000A
	CMP m2
	SEP #$20
	BCS ++
	LDA wm_ClusterSprYLo,X
	ADC #$03
	STA m2
	LDA wm_ClusterSprYHi,X
	ADC #$00
	STA m3
	REP #$20
	LDA #$0014
	LDY wm_MarioPowerUp
	BEQ +
	LDA #$0020
+	STA m4
	LDA wm_MarioYPos
	SEC
	SBC m2
	CLC
	ADC #$001C
	CMP m4
	SEP #$20
	BCS ++
	JSR _02F9F5
++	RTS

DATA_02FEC5:	.DB $40,$B0 ; unused

DATA_02FEC7:	.DB $01,$FF ; unused

DATA_02FEC9:	.DB $30,$C0 ; unused

DATA_02FECB:	.DB $01,$FF ; unused

ADDR_02FECD: ; unreachable
	LDA wm_IsVerticalLvl
	AND #$01
	BNE ADDR_02FF1E
	LDA wm_ClusterSprYLo,X
	CLC
	ADC #$50
	LDA wm_ClusterSprYHi,X
	ADC #$00
	CMP #$02
	BPL _02FF0E
	LDA wm_FrameA
	AND #$01
	STA m1
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_02FEC9,Y
	ROL m0
	CMP wm_ClusterSprXLo,X
	PHP
	LDA wm_Bg1HOfs+1
	LSR m0
	ADC DATA_02FECB,Y
	PLP
	SBC wm_ClusterSprXHi,X
	STA m0
	LSR m1
	BCC +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return02FF1D
_02FF0E:
	LDY wm_ClusterSpriteTbl3,X
	CPY #$FF
	BEQ +
	LDA #$00
	STA wm_SprLoadStatus,Y
+	STZ wm_ClustSprNum,X
_Return02FF1D:
	RTS

ADDR_02FF1E: ; unreachable
	LDA wm_FrameA
	LSR
	BCS _Return02FF1D
	AND #$01
	STA m1
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_02FEC5,Y
	ROL m0
	CMP wm_ClusterSprYLo,X
	PHP
	LDA.W wm_Bg1VOfs+1
	LSR m0
	ADC DATA_02FEC7,Y
	PLP
	SBC wm_ClusterSprYHi,X
	STA m0
	LDY m1
	BEQ +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return02FF1D
	BMI _02FF0E ; [BRA FIX]

DATA_02FF50:
	.DB $E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC
	.DB $5C,$58,$54,$50,$4C,$48,$44,$40
	.DB $3C,$38,$34,$30

DATA_02FF64:	.DB $90,$94,$98,$9C,$A0,$A4,$A8,$AC

CODE_02FF6C:
	JSL CODE_02AD34
	LDA #$0D
	STA wm_ScoreSprNum,Y
	LDA wm_ClusterSprYLo,X
	SEC
	SBC #$08
	STA wm_ScoreSprYLo,Y
	LDA wm_ClusterSprYHi,X
	SBC #$00
	STA wm_ScoreSprYHi,Y
	LDA wm_ClusterSprXLo,X
	STA wm_ScoreSprXLo,Y
	LDA wm_ClusterSprXHi,X
	STA wm_ScoreSprXHi,Y
	LDA #$30
	STA wm_ScoreSprSpeedY,Y
	RTS

CODE_02FF98:
	PHX
	TXA
	CLC
	ADC #$14
	TAX
	JSR CODE_02FFA3
	PLX
	RTS

CODE_02FFA3:
	LDA wm_ClusBooFrame1Y,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_ClusBooFrame2Y,X
	STA wm_ClusBooFrame2Y,X
	PHP
	LDA wm_ClusBooFrame1Y,X
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
	ADC wm_ClusterSprYLo,X
	STA wm_ClusterSprYLo,X
	TYA
	ADC wm_ClusterSprYHi,X
	STA wm_ClusterSprYHi,X
	RTS

CODE_02FFD1:
	LDA wm_SprObjStatus,X
	BMI +
	LDA #$00
	LDY wm_SpriteSlopeTbl,X
	BEQ ++
+	LDA #$18
++	STA wm_SpriteSpeedY,X
	RTS

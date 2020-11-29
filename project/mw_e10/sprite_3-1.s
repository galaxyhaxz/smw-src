DATA_038000:	.DB $13,$14,$15,$16,$17,$18,$19

DATA_038007:	.DB $F0,$F8,$FC,$00,$04,$08,$10

DATA_03800E:	.DB $A0,$D0,$C0,$D0

Football:
	JSL GenericSprGfxRt2
	LDA wm_SpritesLocked
	BNE _Return038086
	JSR SubOffscreen0Bnk3
	JSL SprSprMarioSprRts
	LDA wm_SpriteDecTbl1,X
	BEQ +
	DEC A
	BNE ++
	JSL CODE_01AB6F
+	JSL UpdateSpritePos
++	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
+	LDA wm_SprObjStatus,X
	AND #$08
	BEQ +
	STZ wm_SpriteSpeedY,X
+	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _Return038086
	LDA wm_SpriteDecTbl1,X
	BNE _Return038086
	LDA wm_SpritePal,X
	EOR #$40
	STA wm_SpritePal,X
	JSL GetRand
	AND #$03
	TAY
	LDA DATA_03800E,Y
	STA wm_SpriteSpeedY,X
	LDY wm_SpriteSlopeTbl,X
	INY
	INY
	INY
	LDA DATA_038007,Y
	CLC
	ADC wm_SpriteSpeedX,X
	BPL CODE_03807E
	CMP #$E0
	BCS _038084
	LDA #$E0
	BRA _038084

CODE_03807E:
	CMP #$20
	BCC _038084
	LDA #$20
_038084:
	STA wm_SpriteSpeedX,X
_Return038086:
	RTS

BigBooBoss:
	JSL CODE_038398
	JSL CODE_038239
	LDA wm_SpriteStatus,X
	BNE CODE_0380A2
	INC wm_CutsceneNum
	LDA #$FF
	STA wm_EndLevelTimer
	LDA #$0B
	STA wm_MusicCh1
	RTS

CODE_0380A2:
	CMP #$08
	BNE _Return0380D4
	LDA wm_SpritesLocked
	BNE _Return0380D4
	LDA wm_SpriteState,X
	JSL ExecutePtr

BooBossPtrs:
	.DW CODE_0380BE
	.DW CODE_0380D5
	.DW CODE_038119
	.DW CODE_03818B
	.DW CODE_0381BC
	.DW CODE_038106
	.DW CODE_0381D3

CODE_0380BE:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$90
	BNE _Return0380D4
	LDA #$08
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
_Return0380D4:
	RTS

CODE_0380D5:
	LDA wm_SpriteDecTbl1,X
	BNE ++
	LDA #$08
	STA wm_SpriteDecTbl1,X
	INC wm_BooBossPal
	LDA wm_BooBossPal
	CMP #$02
	BNE +
	LDY #$10
	STY wm_SoundCh1
+	CMP #$07
	BNE ++
	INC wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
++	RTS

DATA_0380FA:	.DB $FF,$01

DATA_0380FC:	.DB $F0,$10

DATA_0380FE:	.DB $0C,$F4

DATA_038100:	.DB $01,$FF

DATA_038102:	.DB $01,$02,$02,$01

CODE_038106:
	LDA wm_SpriteDecTbl1,X
	BNE +
	STZ wm_SpriteState,X
	LDA #$40
	STA wm_SpriteMiscTbl6,X
+	LDA #$03
	STA wm_SpriteGfxTbl,X
	BRA _03811F

CODE_038119:
	STZ wm_SpriteGfxTbl,X
	JSR CODE_0381E4
_03811F:
	LDA wm_SpriteDecTbl5,X
	BNE +
	JSR SubHorzPosBnk3
	TYA
	CMP wm_SpriteDir,X
	BEQ ++
	LDA #$1F
	STA wm_SpriteDecTbl5,X
+	CMP #$10
	BNE +
	PHA
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
	PLA
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_038102,Y
	STA wm_SpriteGfxTbl,X
++	LDA wm_FrameB
	AND #$07
	BNE +
	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_0380FA,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_0380FC,Y
	BNE +
	INC wm_SpriteMiscTbl3,X
+	LDA wm_FrameB
	AND #$07
	BNE +
	LDA wm_SpriteMiscTbl4,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_038100,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_0380FE,Y
	BNE +
	INC wm_SpriteMiscTbl4,X
+	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty
	RTS

CODE_03818B:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_0381AE
	INC wm_SpriteState,X
	LDA #$08
	STA wm_SpriteDecTbl1,X
	JSL LoadSpriteTables
	INC wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl5,X
	CMP #$03
	BNE +
	LDA #$06
	STA wm_SpriteState,X
	JSL KillMostSprites
+	RTS

CODE_0381AE:
	AND #$0E
	EOR wm_SpritePal,X
	STA wm_SpritePal,X
	LDA #$03
	STA wm_SpriteGfxTbl,X
	RTS

CODE_0381BC:
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$08
	STA wm_SpriteDecTbl1,X
	DEC wm_BooBossPal
	BNE +
	INC wm_SpriteState,X
	LDA #$C0
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_0381D3:
	LDA #$02
	STA wm_SpriteStatus,X
	STZ wm_SpriteSpeedX,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	LDA #$23
	STA wm_SoundCh1
	RTS

CODE_0381E4:
	LDY #$0B
-	LDA wm_SpriteStatus,Y
	CMP #$09
	BEQ CODE_0381F5
	CMP #$0A
	BEQ CODE_0381F5
_0381F1:
	DEY
	BPL -
	RTS

CODE_0381F5:
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC _0381F1
	LDA #$03
	STA wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	PHX
	TYX
	STZ wm_SpriteStatus,X
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
	LDA #$FF
	JSL ShatterBlock
	PLB
	PLX
	LDA #$28
	STA wm_SoundCh3
	RTS

CODE_038239:
	LDY #$24
	STY wm_CgAdSub
	LDA wm_BooBossPal
	CMP #$08
	DEC A
	BCS +
	LDY #$34
	STY wm_CgAdSub
	INC A
+	ASL
	ASL
	ASL
	ASL
	TAX
	STZ m0
	LDY wm_PalSprIndex
-	LDA.L BooBossPals,X
	STA wm_PalColData,Y
	INY
	INX
	INC m0
	LDA m0
	CMP #$10
	BNE -
	LDX wm_PalSprIndex
	LDA #$10
	STA wm_PalUplSize,X
	LDA #$F0
	STA wm_PalColNum,X
	STZ wm_PalColTerm,X
	TXA
	CLC
	ADC #$12
	STA wm_PalSprIndex
	LDX wm_SprProcessIndex
	RTL

BigBooDispX:
	.DB $08,$08,$20,$00,$00,$00,$00,$10
	.DB $10,$10,$10,$20,$20,$20,$20,$30
	.DB $30,$30,$30,$FD,$0C,$0C,$27,$00
	.DB $00,$00,$00,$10,$10,$10,$10,$1F
	.DB $20,$20,$1F,$2E,$2E,$2C,$2C,$FB
	.DB $12,$12,$30,$00,$00,$00,$00,$10
	.DB $10,$10,$10,$1F,$20,$20,$1F,$2E
	.DB $2E,$2E,$2E,$F8,$11,$FF,$08,$08
	.DB $00,$00,$00,$00,$10,$10,$10,$10
	.DB $20,$20,$20,$20,$30,$30,$30,$30

BigBooDispY:
	.DB $12,$22,$18,$00,$10,$20,$30,$00
	.DB $10,$20,$30,$00,$10,$20,$30,$00
	.DB $10,$20,$30,$18,$16,$16,$12,$22
	.DB $00,$10,$20,$30,$00,$10,$20,$30
	.DB $00,$10,$20,$30,$00,$10,$20,$30

BigBooTiles:
	.DB $C0,$E0,$E8,$80,$A0,$A0,$80,$82
	.DB $A2,$A2,$82,$84,$A4,$C4,$E4,$86
	.DB $A6,$C6,$E6,$E8,$C0,$E0,$E8,$80
	.DB $A0,$A0,$80,$82,$A2,$A2,$82,$84
	.DB $A4,$C4,$E4,$86,$A6,$C6,$E6,$E8
	.DB $C0,$E0,$E8,$80,$A0,$A0,$80,$82
	.DB $A2,$A2,$82,$84,$A4,$A4,$84,$86
	.DB $A6,$A6,$86,$E8,$E8,$E8,$C2,$E2
	.DB $80,$A0,$A0,$80,$82,$A2,$A2,$82
	.DB $84,$A4,$C4,$E4,$86,$A6,$C6,$E6

BigBooGfxProp:
	.DB $00,$00,$40,$00,$00,$80,$80,$00
	.DB $00,$80,$80,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$40,$00
	.DB $00,$80,$80,$00,$00,$80,$80,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$40,$00,$00,$80,$80,$00
	.DB $00,$80,$80,$00,$00,$80,$80,$00
	.DB $00,$80,$80,$00,$00,$40,$00,$00
	.DB $00,$00,$80,$80,$00,$00,$80,$80
	.DB $00,$00,$00,$00,$00,$00,$00,$00

CODE_038398:
	PHB
	PHK
	PLB
	JSR CODE_0383A0
	PLB
	RTL

CODE_0383A0:
	LDA wm_SpriteNum,X
	CMP #$37
	BNE CODE_0383C2
	LDA #$00
	LDY wm_SpriteState,X
	BEQ +
	LDA #$06
	LDY wm_SpriteDecTbl3,X
	BEQ +
	TYA
	AND #$04
	LSR
	LSR
	ADC #$02
+	STA wm_SpriteGfxTbl,X
	JSL GenericSprGfxRt2
	RTS

CODE_0383C2:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteGfxTbl,X
	STA m6
	ASL
	ASL
	STA m3
	ASL
	ASL
	ADC m3
	STA m2
	LDA wm_SpriteDir,X
	STA m4
	LDA wm_SpritePal,X
	STA m5
	LDX #$00
-	PHX
	LDX m2
	LDA.W BigBooTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA m4
	LSR
	LDA.W BigBooGfxProp,X
	ORA m5
	BCS +
	EOR #$40
+	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA.W BigBooDispX,X
	BCS +
	EOR #$FF
	INC A
	CLC
	ADC #$28
+	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	PLX
	PHX
	LDA m6
	CMP #$03
	BCC +
	TXA
	CLC
	ADC #$14
	TAX
+	LDA m1
	CLC
	ADC.W BigBooDispY,X
	STA wm_OamSlot.1.YPos,Y
	PLX
	INY
	INY
	INY
	INY
	INC m2
	INX
	CPX #$14
	BNE -
	LDX wm_SprProcessIndex
	LDA wm_SpriteGfxTbl,X
	CMP #$03
	BNE +
	LDA wm_SpriteDecTbl3,X
	BEQ +
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$05
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
+	LDA #$13
	LDY #$02
	JSL FinishOAMWrite
	RTS

GreyFallingPlat:
	JSR CODE_038492
	LDA wm_SpritesLocked
	BNE +++
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteSpeedY,X
	BEQ ++
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
+	JSL UpdateYPosNoGrvty
++	JSL InvisBlkMainRt
	BCC +++
	LDA wm_SpriteSpeedY,X
	BNE +++
	LDA #$03
	STA wm_SpriteSpeedY,X
	LDA #$18
	STA wm_SpriteDecTbl1,X
+++	RTS

FallingPlatDispX:	.DB $00,$10,$20,$30

FallingPlatTiles:	.DB $60,$61,$61,$62

CODE_038492:
	JSR GetDrawInfoBnk3
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W FallingPlatDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA.W FallingPlatTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$03
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$03
	JSL FinishOAMWrite
	RTS

BlurpMaxSpeedY:	.DB $04,$FC

BlurpSpeedX:	.DB $08,$F8

BlurpAccelY:	.DB $01,$FF

Blurp:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA.W wm_FrameB
	LSR
	LSR
	LSR
	CLC
	ADC wm_SprProcessIndex
	LSR
	LDA #$A2
	BCC +
	LDA #$EC
+	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_0384F5
_0384EC:
	LDA wm_OamSlot.1.Prop,Y
	ORA #$80
	STA wm_OamSlot.1.Prop,Y
	RTS

CODE_0384F5:
	LDA wm_SpritesLocked
	BNE ++
	JSR SubOffscreen0Bnk3
	LDA wm_FrameB
	AND #$03
	BNE +
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC BlurpAccelY,Y
	STA wm_SpriteSpeedY,X
	CMP BlurpMaxSpeedY,Y
	BNE +
	INC wm_SpriteState,X
+	LDY wm_SpriteDir,X
	LDA BlurpSpeedX,Y
	STA wm_SpriteSpeedX,X
	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty
	JSL SprSprMarioSprRts
++	RTS

PorcuPuffAccel:	.DB $01,$FF

PorcuPuffMaxSpeed:	.DB $10,$F0

PorcuPuffer:
	JSR CODE_0385A3
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	JSR SubOffscreen0Bnk3
	JSL SprSprMarioSprRts
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	LDA wm_FrameB
	AND #$03
	BNE +
	LDA wm_SpriteSpeedX,X
	CMP PorcuPuffMaxSpeed,Y
	BEQ +
	CLC
	ADC PorcuPuffAccel,Y
	STA wm_SpriteSpeedX,X
+	LDA wm_SpriteSpeedX,X
	PHA
	LDA wm_L1CurXChange
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpriteSpeedX,X
	STA wm_SpriteSpeedX,X
	JSL UpdateXPosNoGrvty
	PLA
	STA wm_SpriteSpeedX,X
	JSL CODE_019138
	LDY #$04
	LDA wm_SprInWaterTbl,X
	BEQ +
	LDY #$FC
+	STY wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
++	RTS

PocruPufferDispX:	.DB $F8,$08,$F8,$08,$08,$F8,$08,$F8

PocruPufferDispY:	.DB $F8,$F8,$08,$08

PocruPufferTiles:	.DB $86,$C0,$A6,$C2,$86,$C0,$A6,$8A

PocruPufferGfxProp:	.DB $0D,$0D,$0D,$0D,$4D,$4D,$4D,$4D

CODE_0385A3:
	JSR GetDrawInfoBnk3
	LDA wm_FrameB
	AND #$04
	STA m3
	LDA wm_SpriteDir,X
	STA m2
	PHX
	LDX #$03
-	LDA m1
	CLC
	ADC.W PocruPufferDispY,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA m2
	BNE +
	TXA
	ORA #$04
	TAX
+	LDA m0
	CLC
	ADC.W PocruPufferDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA.W PocruPufferGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLA
	PHA
	ORA m3
	TAX
	LDA.W PocruPufferTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$03
	JSL FinishOAMWrite
	RTS

FlyingBlockSpeedY:	.DB $08,$F8

FlyingTurnBlocks:
	JSR CODE_0386A8
	LDA wm_SpritesLocked
	BNE +++
	LDA wm_BGScrollFlag
	BEQ ++
	LDA wm_SpriteMiscTbl5,X
	INC wm_SpriteMiscTbl5,X
	AND #$01
	BNE +
	DEC wm_SpriteGfxTbl,X
	LDA wm_SpriteGfxTbl,X
	CMP #$FF
	BNE +
	LDA #$FF
	STA wm_SpriteGfxTbl,X
	INC wm_SpriteDir,X
+	LDA wm_SpriteDir,X
	AND #$01
	TAY
	LDA FlyingBlockSpeedY,Y
	STA wm_SpriteSpeedY,X
++	LDA wm_SpriteSpeedY,X
	PHA
	LDY wm_SpriteMiscTbl3,X
	BNE +
	EOR #$FF
	INC A
	STA wm_SpriteSpeedY,X
+	JSL UpdateYPosNoGrvty
	PLA
	STA wm_SpriteSpeedY,X
	LDA wm_BGScrollFlag
	STA wm_SpriteSpeedX,X
	JSL UpdateXPosNoGrvty
	STA wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
	BCC +++
	LDA wm_BGScrollFlag
	BNE +++
	LDA #$08
	STA wm_BGScrollFlag
	LDA #$7F
	STA wm_SpriteGfxTbl,X
	LDY #$09
-	CPY wm_SprProcessIndex
	BEQ +
	LDA.W wm_SpriteNum,Y
	CMP #$C1
	BEQ ++
+	DEY
	BPL -
	INY
++	LDA #$7F
	STA wm_SpriteGfxTbl,Y
+++	RTS

ForestPlatDispX:
	.DB $00,$10,$20,$F2,$2E,$00,$10,$20
	.DB $FA,$2E

ForestPlatDispY:
	.DB $00,$00,$00,$F6,$F6,$00,$00,$00
	.DB $FE,$FE

ForestPlatTiles:
	.DB $40,$40,$40,$C6,$C6,$40,$40,$40
	.DB $5D,$5D

ForestPlatGfxProp:
	.DB $32,$32,$32,$72,$32,$32,$32,$32
	.DB $72,$32

ForestPlatTileSize:
	.DB $02,$02,$02,$02,$02,$02,$02,$02
	.DB $00,$00

CODE_0386A8:
	JSR GetDrawInfoBnk3
	LDY wm_SprOAMIndex,X
	LDA wm_FrameB
	LSR
	AND #$04
	BEQ +
	INC A
+	STA m2
	PHX
	LDX #$04
-	STX m6
	TXA
	CLC
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W ForestPlatDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W ForestPlatDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W ForestPlatTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W ForestPlatGfxProp,X
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W ForestPlatTileSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	LDX m6
	DEX
	BPL -
	PLX
	LDY #$FF
	LDA #$04
	JSL FinishOAMWrite
	RTS

GrayLavaPlatform:
	JSR CODE_03873A
	LDA wm_SpritesLocked
	BNE _Return038733
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteDecTbl1,X
	DEC A
	BNE CODE_03871B
	LDY wm_SprIndexInLvl,X
	LDA #$00
	STA wm_SprLoadStatus,Y
	STZ wm_SpriteStatus,X
	RTS

CODE_03871B:
	JSL UpdateYPosNoGrvty
	JSL InvisBlkMainRt
	BCC _Return038733
	LDA wm_SpriteDecTbl1,X
	BNE _Return038733
	LDA #$06
	STA wm_SpriteSpeedY,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
_Return038733:
	RTS

LavaPlatTiles:	.DB $85,$86,$85

DATA_038737:	.DB $43,$03,$03

CODE_03873A:
	JSR GetDrawInfoBnk3
	PHX
	LDX #$02
-	LDA m0
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA m0
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA.W LavaPlatTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_038737,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$02
	JSL FinishOAMWrite
	RTS

MegaMoleSpeed:	.DB $10,$F0

MegaMole:
	JSR MegaMoleGfxRt
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _Return038733
	JSR SubOffscreen3Bnk3
	LDY wm_SpriteDir,X
	LDA MegaMoleSpeed,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpritesLocked
	BNE _Return038733
	LDA wm_SprObjStatus,X
	AND #$04
	PHA
	JSL UpdateSpritePos
	JSL SprSprInteract
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ MegaMoleInAir
	STZ wm_SpriteSpeedY,X
	PLA
	BRA _MegaMoleOnGround

MegaMoleInAir:
	PLA
	BEQ +
	LDA #$0A
	STA wm_SpriteDecTbl1,X
+	LDA wm_SpriteDecTbl1,X
	BEQ _MegaMoleOnGround
	STZ wm_SpriteSpeedY,X
_MegaMoleOnGround:
	LDY wm_SpriteDecTbl5,X
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ ++
	CPY #$00
	BNE +
	LDA #$10
	STA wm_SpriteDecTbl5,X
+	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
++	CPY #$00
	BNE +
	LDA wm_SpriteDir,X
	STA wm_SpriteMiscTbl3,X
+	JSL MarioSprInteract
	BCC _Return03882A
	JSR SubVertPosBnk3
	LDA m14
	CMP #$D8
	BPL MegaMoleContact
	LDA wm_MarioSpeedY
	BMI _Return03882A
	LDA #$01
	STA wm_IsOnSolidSpr
	LDA #$06
	STA wm_SpriteDecTbl2,X
	STZ wm_MarioSpeedY
	LDA #$D6
	LDY wm_OnYoshi
	BEQ +
	LDA #$C6
+	CLC
	ADC wm_SpriteYLo,X
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	ADC #$FF
	STA wm_MarioYPos+1
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
	RTS

MegaMoleContact:
	LDA wm_SpriteDecTbl2,X
	ORA wm_SpriteEatenTbl,X
	BNE _Return03882A
	JSL HurtMario
_Return03882A:
	RTS

MegaMoleTileDispX:	.DB $00,$10,$00,$10,$10,$00,$10,$00

MegaMoleTileDispY:	.DB $F0,$F0,$00,$00

MegaMoleTiles:	.DB $C6,$C8,$E6,$E8,$CA,$CC,$EA,$EC

MegaMoleGfxRt:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteMiscTbl3,X
	STA m2
	LDA wm_FrameB
	LSR
	LSR
	NOP
	CLC
	ADC wm_SprProcessIndex
	AND #$01
	ASL
	ASL
	STA m3
	PHX
	LDX #$03
-	PHX
	LDA m2
	BNE +
	INX
	INX
	INX
	INX
+	LDA m0
	CLC
	ADC.W MegaMoleTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA m1
	CLC
	ADC.W MegaMoleTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	TXA
	CLC
	ADC m3
	TAX
	LDA.W MegaMoleTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$01
	LDX m2
	BNE +
	ORA #$40
+	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$03
	JSL FinishOAMWrite
	RTS

BatTiles:	.DB $AE,$C0,$E8

Swooper:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	PHX
	LDA wm_SpriteGfxTbl,X
	TAX
	LDA.W BatTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_0388C0
	JMP _0384EC

CODE_0388C0:
	LDA wm_SpritesLocked
	BNE Return0388DF
	JSR SubOffscreen0Bnk3
	JSL SprSprMarioSprRts
	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty
	LDA wm_SpriteState,X
	JSL ExecutePtr

SwooperPtrs:
	.DW CODE_0388E4
	.DW CODE_038905
	.DW CODE_038936

Return0388DF:
	RTS

DATA_0388E0:	.DB $10,$F0

DATA_0388E2:	.DB $01,$FF

CODE_0388E4:
	LDA wm_OffscreenHorz,X
	BNE +
	JSR SubHorzPosBnk3
	LDA m15
	CLC
	ADC #$50
	CMP #$A0
	BCS +
	INC wm_SpriteState,X
	TYA
	STA wm_SpriteDir,X
	LDA #$20
	STA wm_SpriteSpeedY,X
	LDA #$26
	STA wm_SoundCh3
+	RTS

CODE_038905:
	LDA wm_FrameA
	AND #$03
	BNE _038915
	LDA wm_SpriteSpeedY,X
	BEQ _038915
	DEC wm_SpriteSpeedY,X
	BNE _038915
	INC wm_SpriteState,X
_038915:
	LDA wm_FrameA
	AND #$03
	BNE +
	LDY wm_SpriteDir,X
	LDA wm_SpriteSpeedX,X
	CMP DATA_0388E0,Y
	BEQ +
	CLC
	ADC DATA_0388E2,Y
	STA wm_SpriteSpeedX,X
+	LDA wm_FrameB
	AND #$04
	LSR
	LSR
	INC A
	STA wm_SpriteGfxTbl,X
	RTS

CODE_038936:
	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC BlurpAccelY,Y
	STA wm_SpriteSpeedY,X
	CMP BlurpMaxSpeedY,Y
	BNE +
	INC wm_SpriteMiscTbl3,X
+	BRA _038915

DATA_038954:	.DB $20,$E0

DATA_038956:	.DB $02,$FE

SlidingKoopa:
	LDA #$00
	LDY wm_SpriteSpeedX,X
	BEQ ++
	BPL +
	INC A
+	STA wm_SpriteDir,X
++	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDecTbl3,X
	CMP #$01
	BNE +
	LDA wm_SpriteDir,X
	PHA
	LDA #$02
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	PLA
	STA wm_SpriteDir,X
	SEC
+	LDA #$86
	BCC +
	LDA #$E0
+	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _Return0389FE
	JSR SubOffscreen0Bnk3
	JSL SprSprMarioSprRts
	LDA wm_SpritesLocked
	ORA wm_SpriteDecTbl1,X
	ORA wm_SpriteDecTbl3,X
	BNE _Return0389FE
	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _Return0389FE
	JSR CODE_0389FF
	LDY #$00
	LDA wm_SpriteSpeedX,X
	BEQ ++
	BPL +
	EOR #$FF
	INC A
+	STA m0
	LDA wm_SpriteSlopeTbl,X
	BEQ ++
	LDY m0
	EOR wm_SpriteSpeedX,X
	BPL ++
	LDY #$D0
++	STY wm_SpriteSpeedY,X
	LDA wm_FrameA
	AND #$01
	BNE _Return0389FE
	LDA wm_SpriteSlopeTbl,X
	BNE CODE_0389EC
	LDA wm_SpriteSpeedX,X
	BNE CODE_0389E3
	LDA #$20
	STA wm_SpriteDecTbl3,X
	RTS

CODE_0389E3:
	BPL +
	INC wm_SpriteSpeedX,X
	INC wm_SpriteSpeedX,X
+	DEC wm_SpriteSpeedX,X
	RTS

CODE_0389EC:
	ASL
	ROL
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CMP DATA_038954,Y
	BEQ _Return0389FE
	CLC
	ADC DATA_038956,Y
	STA wm_SpriteSpeedX,X
_Return0389FE:
	RTS

CODE_0389FF:
	LDA wm_SpriteSpeedX,X
	BEQ +
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA #$04
	STA m0
	LDA #$0A
	STA m1
	JSR IsSprOffScreenBnk3
	BNE +
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_038A21
	DEY
	BPL -
+	RTS

CODE_038A21:
	LDA #$03
	STA wm_SmokeSprite,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC m0
	STA wm_SmokeXPos,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC m1
	STA wm_SmokeYPos,Y
	LDA #$13
	STA wm_SmokeTimer,Y
	RTS

BowserStatue:
	JSR BowserStatueGfx
	LDA wm_SpritesLocked
	BNE _Return038A68
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteState,X
	JSL ExecutePtr

BowserStatuePtrs:
	.DW _038A57
	.DW CODE_038A54
	.DW CODE_038A69
	.DW CODE_038A54

CODE_038A54:
	JSR CODE_038ACB
_038A57:
	JSL InvisBlkMainRt
	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _Return038A68
	STZ wm_SpriteSpeedY,X
_Return038A68:
	RTS

CODE_038A69:
	ASL wm_Tweaker167A,X
	LSR wm_Tweaker167A,X
	JSL MarioSprInteract
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteSpeedY,X
	CMP #$10
	BPL +
	INC wm_SpriteGfxTbl,X
+	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
+	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _Return038AC6
	LDA #$10
	STA wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_038AC1
	DEC A
	BNE _Return038AC6
	LDA #$C0
	STA wm_SpriteSpeedY,X
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	LDA BwsrStatueSpeed,Y
	STA wm_SpriteSpeedX,X
	RTS

BwsrStatueSpeed:	.DB $10,$F0

CODE_038AC1:
	LDA #$30
	STA wm_SpriteDecTbl1,X
_Return038AC6:
	RTS

BwserFireDispXLo:	.DB $10,$F0

BwserFireDispXHi:	.DB $00,$FF

CODE_038ACB:
	TXA
	ASL
	ASL
	ADC wm_FrameA
	AND #$7F
	BNE +
	JSL FindFreeSprSlot
	BMI +
	LDA #$17
	STA wm_SoundCh3
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$B3
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	PHX
	LDA wm_SpriteDir,X
	TAX
	LDA m0
	CLC
	ADC.W BwserFireDispXLo,X
	STA.W wm_SpriteXLo,Y
	LDA m1
	ADC.W BwserFireDispXHi,X
	STA wm_SpriteXHi,Y
	TYX
	JSL InitSpriteTables
	PLX
	LDA wm_SpriteYLo,X
	SEC
	SBC #$02
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,Y
	LDA wm_SpriteDir,X
	STA wm_SpriteDir,Y
+	RTS

BwsrStatueDispX:	.DB $08,$F8,$00,$00,$08,$00

BwsrStatueDispY:	.DB $10,$F8,$00

BwsrStatueTiles:	.DB $56,$30,$41,$56,$30,$35

BwsrStatueTileSize:	.DB $00,$02,$02

BwsrStatueGfxProp:	.DB $00,$00,$00,$40,$40,$40

BowserStatueGfx:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteGfxTbl,X
	STA m4
	EOR #$01
	DEC A
	STA m3
	LDA wm_SpritePal,X
	STA m5
	LDA wm_SpriteDir,X
	STA m2
	PHX
	LDX #$02
-	PHX
	LDA m2
	BNE +
	INX
	INX
	INX
+	LDA m0
	CLC
	ADC.W BwsrStatueDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA.W BwsrStatueGfxProp,X
	ORA m5
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	LDA m1
	CLC
	ADC.W BwsrStatueDispY,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA m4
	BEQ +
	INX
	INX
	INX
+	LDA.W BwsrStatueTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W BwsrStatueTileSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	CPX m3
	BNE -
	PLX
	LDY #$FF
	LDA #$02
	JSL FinishOAMWrite
	RTS

DATA_038BAA:
	.DB $20,$20,$20,$20,$20,$20,$20,$20
	.DB $20,$20,$20,$20,$20,$20,$20,$20
	.DB $20,$1F,$1E,$1D,$1C,$1B,$1A,$19
	.DB $18,$17,$16,$15,$14,$13,$12,$11
	.DB $10,$0F,$0E,$0D,$0C,$0B,$0A,$09
	.DB $08,$07,$06,$05,$04,$03,$02,$01
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $01,$02,$03,$04,$05,$06,$07,$08
	.DB $09,$0A,$0B,$0C,$0D,$0E,$0F,$10
	.DB $11,$12,$13,$14,$15,$16,$17,$18
	.DB $19,$1A,$1B,$1C,$1D,$1E,$1F,$20
	.DB $20,$20,$20,$20,$20,$20,$20,$20
	.DB $20,$20,$20,$20,$20,$20,$20,$20

DATA_038C2A:	.DB $00,$F8,$00,$08

Return038C2E:
	RTS

CarrotTopLift:
	JSR CarrotTopLiftGfx
	LDA wm_SpritesLocked
	BNE Return038C2E
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
+	LDA wm_SpriteState,X
	AND #$03
	TAY
	LDA DATA_038C2A,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedX,X
	LDY wm_SpriteNum,X
	CPY #$B8
	BEQ +
	EOR #$FF
	INC A
+	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	LDA wm_SpriteXLo,X
	STA wm_SpriteMiscTbl3,X
	JSL UpdateXPosNoGrvty
	JSR CODE_038CE4
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC ++
	LDA wm_MarioSpeedY
	BMI ++
	LDA wm_MarioXPos
	SEC
	SBC wm_SpriteMiscTbl3,X
	CLC
	ADC #$1C
	LDY wm_SpriteNum,X
	CPY #$B8
	BNE +
	CLC
	ADC #$38
+	TAY
	LDA wm_OnYoshi
	CMP #$01
	LDA #$20
	BCC +
	LDA #$30
+	CLC
	ADC wm_MarioYPos
	STA m0
	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_038BAA,Y
	CMP m0
	BPL ++
	LDA wm_OnYoshi
	CMP #$01
	LDA #$1D
	BCC +
	LDA #$2D
+	STA m0
	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_038BAA,Y
	PHP
	SEC
	SBC m0
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	SBC #$00
	PLP
	ADC #$00
	STA wm_MarioYPos+1
	STZ wm_MarioSpeedY
	LDA #$01
	STA wm_IsOnSolidSpr
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

CODE_038CE4:
	LDA wm_MarioXPos
	CLC
	ADC #$04
	STA m0
	LDA wm_MarioXPos+1
	ADC #$00
	STA m8
	LDA #$08
	STA m2
	STA m3
	LDA #$20
	LDY wm_OnYoshi
	BEQ +
	LDA #$30
+	CLC
	ADC wm_MarioYPos
	STA m1
	LDA wm_MarioYPos+1
	ADC #$00
	STA m9
	RTS

DiagPlatDispX:	.DB $10,$00,$10,$00,$10,$00

DiagPlatDispY:	.DB $00,$10,$10,$00,$10,$10

DiagPlatTiles2:	.DB $E4,$E0,$E2,$E4,$E0,$E2

DiagPlatGfxProp:	.DB $0B,$0B,$0B,$4B,$4B,$4B

CarrotTopLiftGfx:
	JSR GetDrawInfoBnk3
	PHX
	LDA wm_SpriteNum,X
	CMP #$B8
	LDX #$02
	STX m2
	BCC _f
	LDX #$05
__	LDA m0
	CLC
	ADC.W DiagPlatDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DiagPlatDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DiagPlatTiles2,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DiagPlatGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	DEC m2
	BPL _b
	PLX
	LDY #$02
	TYA
	JSL FinishOAMWrite
	RTS

DATA_038D66:
	.DB $00,$04,$07,$08,$08,$07,$04,$00
	.DB $00

InfoBox:
	JSL InvisBlkMainRt
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteDecTbl3,X
	CMP #$01
	BNE +
	LDA #$22
	STA wm_SoundCh3
	STZ wm_SpriteDecTbl3,X
	STZ wm_SpriteState,X
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	AND #$01
	INC A
	STA wm_MsgBoxTrig
+	LDA wm_SpriteDecTbl3,X
	LSR
	TAY
	LDA wm_Bg1VOfs
	PHA
	CLC
	ADC DATA_038D66,Y
	STA wm_Bg1VOfs
	LDA wm_Bg1VOfs+1
	PHA
	ADC #$00
	STA wm_Bg1VOfs+1
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA #$C0
	STA wm_OamSlot.1.Tile,Y
	PLA
	STA wm_Bg1VOfs+1
	PLA
	STA wm_Bg1VOfs
	RTS

TimedLift:
	JSR TimedPlatformGfx
	LDA wm_SpritesLocked
	BNE ++
	JSR SubOffscreen0Bnk3
	LDA wm_FrameA
	AND #$00
	BNE +
	LDA wm_SpriteState,X
	BEQ +
	LDA wm_SpriteMiscTbl6,X
	BEQ +
	DEC wm_SpriteMiscTbl6,X
+	LDA wm_SpriteMiscTbl6,X
	BEQ CODE_038DF0
	JSL UpdateXPosNoGrvty
	STA wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
	BCC ++
	LDA #$10
	STA wm_SpriteSpeedX,X
	STA wm_SpriteState,X
++	RTS

CODE_038DF0:
	JSL UpdateSpritePos
	LDA wm_SprPixelMove
	STA wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
	RTS

TimedPlatDispX:	.DB $00,$10,$0C

TimedPlatDispY:	.DB $00,$00,$04

TimedPlatTiles:	.DB $C4,$C4,$00

TimedPlatGfxProp:	.DB $0B,$4B,$0B

TimedPlatTileSize:	.DB $02,$02,$00

TimedPlatNumTiles:	.DB $B6,$B5,$B4,$B3

TimedPlatformGfx:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteMiscTbl6,X
	PHX
	PHA
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.W TimedPlatNumTiles,X
	STA m2
	LDX #$02
	PLA
	CMP #$08
	BCS _f
	DEX
__	LDA m0
	CLC
	ADC.W TimedPlatDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W TimedPlatDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W TimedPlatTiles,X
	CPX #$02
	BNE +
	LDA m2
+	STA wm_OamSlot.1.Tile,Y
	LDA.W TimedPlatGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W TimedPlatTileSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL _b
	PLX
	LDY #$FF
	LDA #$02
	JSL FinishOAMWrite
	RTS

GreyMoveBlkSpeed:	.DB $00,$F0,$00,$10

GreyMoveBlkTiming:	.DB $40,$50,$40,$50

GreyCastleBlock:
	JSR CODE_038EB4
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	AND #$03
	TAY
	LDA GreyMoveBlkTiming,Y
	STA wm_SpriteDecTbl1,X
+	LDA wm_SpriteState,X
	AND #$03
	TAY
	LDA GreyMoveBlkSpeed,Y
	STA wm_SpriteSpeedX,X
	JSL UpdateXPosNoGrvty
	STA wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
++	RTS

GreyMoveBlkDispX:	.DB $00,$10,$00,$10

GreyMoveBlkDispY:	.DB $00,$00,$10,$10

GreyMoveBlkTiles:	.DB $CC,$CE,$EC,$EE

CODE_038EB4:
	JSR GetDrawInfoBnk3
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W GreyMoveBlkDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W GreyMoveBlkDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W GreyMoveBlkTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$03
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$03
	JSL FinishOAMWrite
	RTS

StatueFireSpeed:	.DB $10,$F0

StatueFireball:
	JSR StatueFireballGfx
	LDA wm_SpritesLocked
	BNE +
	JSR SubOffscreen0Bnk3
	JSL MarioSprInteract
	LDY wm_SpriteDir,X
	LDA StatueFireSpeed,Y
	STA wm_SpriteSpeedX,X
	JSL UpdateXPosNoGrvty
+	RTS

StatueFireDispX:	.DB $08,$00,$00,$08

StatueFireTiles:	.DB $32,$50,$33,$34,$32,$50,$33,$34

StatueFireGfxProp:	.DB $09,$09,$09,$09,$89,$89,$89,$89

StatueFireballGfx:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDir,X
	ASL
	STA m2
	LDA wm_FrameB
	LSR
	AND #$03
	ASL
	STA m3
	PHX
	LDX #$01
-	LDA m1
	STA wm_OamSlot.1.YPos,Y
	PHX
	TXA
	ORA m2
	TAX
	LDA m0
	CLC
	ADC.W StatueFireDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLA
	PHA
	ORA m3
	TAX
	LDA.W StatueFireTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W StatueFireGfxProp,X
	LDX m2
	BNE +
	EOR #$40
+	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$00
	LDA #$01
	JSL FinishOAMWrite
	RTS

BooStreamFrntTiles:	.DB $88,$8C,$8E,$A8,$AA,$AE,$88,$8C

ReflectingFireball:
	JSR CODE_038FF2
	BRA _038FA4

BooStream:
	LDA #$00
	LDY wm_SpriteSpeedX,X
	BPL +
	INC A
+	STA wm_SpriteDir,X
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LSR
	AND #$01
	STA m0
	TXA
	AND #$03
	ASL
	ORA m0
	PHX
	TAX
	LDA.W BooStreamFrntTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
_038FA4:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	LDA wm_SpritesLocked
	BNE ++
	TXA
	EOR wm_FrameB
	AND #$07
	ORA wm_OffscreenVert,X
	BNE +
	LDA wm_SpriteNum,X
	CMP #$B0
	BNE +
	JSR CODE_039020
+	JSL UpdateYPosNoGrvty
	JSL UpdateXPosNoGrvty
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
+	LDA wm_SprObjStatus,X
	AND #$0C
	BEQ +
	LDA wm_SpriteSpeedY,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedY,X
+	JSL MarioSprInteract
	JSR SubOffscreen0Bnk3
++	RTS

CODE_038FF2:
	JSL GenericSprGfxRt2
	LDA wm_FrameB
	LSR
	LSR
	LDA #$04
	BCC +
	ASL
+	LDY wm_SpriteSpeedX,X
	BPL +
	EOR #$40
+	LDY wm_SpriteSpeedY,X
	BMI +
	EOR #$80
+	STA m0
	LDY wm_SprOAMIndex,X
	LDA #$AC
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$31
	ORA m0
	STA wm_OamSlot.1.Prop,Y
	RTS

CODE_039020:
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
++	LDA #$0A
	STA wm_MExSprNum,Y
	LDA wm_SpriteXLo,X
	STA wm_MExSprXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_MExSprXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_MExSprYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_MExSprYHi,Y
	LDA #$30
	STA wm_MExSprTimer,Y
	LDA wm_SpriteSpeedX,X
	STA wm_MExSprXSpeed,Y
	RTS

FishinBooAccelX:	.DB $01,$FF

FishinBooMaxSpeedX:	.DB $20,$E0

FishinBooAccelY:	.DB $01,$FF

FishinBooMaxSpeedY:	.DB $10,$F0

FishinBoo:
	JSR FishinBooGfx
	LDA wm_SpritesLocked
	BNE ++
	JSL MarioSprInteract
	JSR SubHorzPosBnk3
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl5,X
	BEQ +
	INC wm_SpriteGfxTbl,X
	CMP #$10
	BNE +
	TYA
	STA wm_SpriteDir,X
+	TXA
	ASL
	ASL
	ASL
	ASL
	ADC wm_FrameA
	AND #$3F
	ORA wm_SpriteDecTbl5,X
	BNE +
	LDA #$20
	STA wm_SpriteDecTbl5,X
+	LDA wm_AppearSprTimer
	BEQ +
	TYA
	EOR #$01
	TAY
+	LDA wm_SpriteSpeedX,X
	CMP FishinBooMaxSpeedX,Y
	BEQ +
	CLC
	ADC FishinBooAccelX,Y
	STA wm_SpriteSpeedX,X
+	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC FishinBooAccelY,Y
	STA wm_SpriteSpeedY,X
	CMP FishinBooMaxSpeedY,Y
	BNE +
	INC wm_SpriteState,X
+	LDA wm_SpriteSpeedX,X
	PHA
	LDY wm_AppearSprTimer
	BNE +
	LDA wm_L1CurXChange
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpriteSpeedX,X
	STA wm_SpriteSpeedX,X
+	JSL UpdateXPosNoGrvty
	PLA
	STA wm_SpriteSpeedX,X
	JSL UpdateYPosNoGrvty
	JSR CODE_0390F3
++	RTS

DATA_0390EB:	.DB $1A,$14,$EE,$F8

DATA_0390EF:	.DB $00,$00,$FF,$FF

CODE_0390F3:
	LDA wm_SpriteDir,X
	ASL
	ADC wm_SpriteGfxTbl,X
	TAY
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_0390EB,Y
	STA m4
	LDA wm_SpriteXHi,X
	ADC DATA_0390EF,Y
	STA m10
	LDA #$04
	STA m6
	STA m7
	LDA wm_SpriteYLo,X
	CLC
	ADC #$47
	STA m5
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m11
	JSL GetMarioClipping
	JSL CheckForContact
	BCC +
	JSL HurtMario
+	RTS

FishinBooDispX:
	.DB $FB,$05,$00,$F2,$FD,$03,$EA,$EA
	.DB $EA,$EA,$FB,$05,$00,$FA,$FD,$03
	.DB $F2,$F2,$F2,$F2,$FB,$05,$00,$0E
	.DB $03,$FD,$16,$16,$16,$16,$FB,$05
	.DB $00,$06,$03,$FD,$0E,$0E,$0E,$0E

FishinBooDispY:
	.DB $0B,$0B,$00,$03,$0F,$0F,$13,$23
	.DB $33,$43

FishinBooTiles1:
	.DB $60,$60,$64,$8A,$60,$60,$AC,$AC
	.DB $AC,$CE

FishinBooGfxProp:
	.DB $04,$04,$0D,$09,$04,$04,$0D,$0D
	.DB $0D,$07

FishinBooTiles2:	.DB $CC,$CE,$CC,$CE

DATA_039178:	.DB $00,$00,$40,$40

DATA_03917C:	.DB $00,$40,$C0,$80

FishinBooGfx:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteGfxTbl,X
	STA m4
	LDA wm_SpriteDir,X
	STA m2
	PHX
	PHY
	LDX #$09
-	LDA m1
	CLC
	ADC.W FishinBooDispY,X
	STA wm_OamSlot.1.YPos,Y
	STZ m3
	LDA.W FishinBooTiles1,X
	CPX #$09
	BNE +
	LDA wm_FrameB
	LSR
	LSR
	PHX
	AND #$03
	TAX
	LDA.W DATA_039178,X
	STA m3
	LDA.W FishinBooTiles2,X
	PLX
+	STA wm_OamSlot.1.Tile,Y
	LDA m2
	CMP #$01
	LDA.W FishinBooGfxProp,X
	EOR m3
	ORA wm_SpriteProp
	BCS +
	EOR #$40
+	STA wm_OamSlot.1.Prop,Y
	PHX
	LDA m4
	BEQ +
	TXA
	CLC
	ADC #$0A
	TAX
+	LDA m2
	BNE +
	TXA
	CLC
	ADC #$14
	TAX
+	LDA m0
	CLC
	ADC.W FishinBooDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	LDA wm_FrameB
	LSR
	LSR
	LSR
	AND #$03
	TAX
	PLY
	LDA.W DATA_03917C,X
	EOR wm_OamSlot.5.Prop,Y
	STA wm_OamSlot.5.Prop,Y
	STA wm_OamSlot.10.Prop,Y
	EOR #$C0
	STA wm_OamSlot.6.Prop,Y
	STA wm_OamSlot.9.Prop,Y
	PLX
	LDY #$02
	LDA #$09
	JSL FinishOAMWrite
	RTS

FallingSpike:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA #$E0
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.YPos,Y
	DEC A
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LSR
	LSR
	AND #$01
	CLC
	ADC wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.1.XPos,Y
+	LDA wm_SpritesLocked
	BNE CODE_03926C
	JSR SubOffscreen0Bnk3
	JSL UpdateSpritePos
	LDA wm_SpriteState,X
	JSL ExecutePtr

FallingSpikePtrs:
	.DW CODE_03924C
	.DW CODE_039262

CODE_03924C:
	STZ wm_SpriteSpeedY,X
	JSR SubHorzPosBnk3
	LDA m15
	CLC
	ADC #$40
	CMP #$80
	BCS +
	INC wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_039262:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_03926C
	JSL MarioSprInteract
	RTS

CODE_03926C:
	STZ wm_SpriteSpeedY,X
	RTS

CrtEatBlkSpeedX:	.DB $10,$F0,$00,$00,$00

CrtEatBlkSpeedY:	.DB $00,$00,$10,$F0,$00

DATA_039279:
	.DB $00,$00,$01,$00,$02,$00,$00,$00
	.DB $03,$00,$00

CreateEatBlock:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.YPos,Y
	DEC A
	STA wm_OamSlot.1.YPos,Y
	LDA #$2E
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$3F
	STA wm_OamSlot.1.Prop,Y
	LDY #$02
	LDA #$00
	JSL FinishOAMWrite
	LDY #$04
	LDA wm_RunEaterBlock
	CMP #$FF
	BEQ ++
	LDA wm_FrameA
	AND #$03
	ORA wm_SpritesLocked
	BNE +
	LDA #$04
	STA wm_SoundCh2
+	LDY wm_SpriteDir,X
++	LDA wm_SpritesLocked
	BNE +++
	LDA CrtEatBlkSpeedX,Y
	STA wm_SpriteSpeedX,X
	LDA CrtEatBlkSpeedY,Y
	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	JSL UpdateXPosNoGrvty
	STZ wm_SpriteMiscTbl4,X
	JSL InvisBlkMainRt
	LDA wm_RunEaterBlock
	CMP #$FF
	BEQ +++
	LDA wm_SpriteYLo,X
	ORA wm_SpriteXLo,X
	AND #$0F
	BNE +++
	LDA wm_SpriteMiscTbl3,X
	BNE CODE_03932C
	DEC wm_SpriteMiscTbl6,X
	BMI +
	BNE ++
+	LDY wm_OWCharA
	LDA wm_MapData.MarioMap,Y
	CMP #$01
	LDY wm_SpriteMiscTbl5,X
	INC wm_SpriteMiscTbl5,X
	LDA CrtEatBlkData1,Y
	BCS +
	LDA CrtEatBlkData2,Y
+	STA wm_SpriteGfxTbl,X
	PHA
	LSR
	LSR
	LSR
	LSR
	STA wm_SpriteMiscTbl6,X
	PLA
	AND #$03
	STA wm_SpriteDir,X
++	LDA #$0D
	JSR GenTileFromSpr1
	LDA wm_SpriteGfxTbl,X
	CMP #$FF
	BEQ CODE_039387
+++	RTS

CODE_03932C:
	LDA #$02
	JSR GenTileFromSpr1
	LDA #$01
	STA wm_SpriteSpeedX,X
	STA wm_SpriteSpeedY,X
	JSL CODE_019138
	LDA wm_SprObjStatus,X
	PHA
	LDA #$FF
	STA wm_SpriteSpeedX,X
	STA wm_SpriteSpeedY,X
	LDA wm_SpriteXLo,X
	PHA
	SEC
	SBC #$01
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	SBC #$00
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC #$01
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	JSL CODE_019138
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	PLA
	ORA wm_SprObjStatus,X
	BEQ CODE_039387
	TAY
	LDA DATA_039279,Y
	STA wm_SpriteDir,X
	RTS

CODE_039387:
	STZ wm_SpriteStatus,X
	RTS

GenTileFromSpr1:
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
	RTS

CrtEatBlkData1:
	.DB $10,$13,$10,$13,$10,$13,$10,$13
	.DB $10,$13,$10,$13,$10,$13,$10,$13
	.DB $F0,$F0,$20,$12,$10,$12,$10,$12
	.DB $10,$12,$10,$12,$10,$12,$10,$12
	.DB $D0,$C3,$F1,$21,$22,$F1,$F1,$51
	.DB $43,$10,$13,$10,$13,$10,$13,$F0
	.DB $F0,$F0,$60,$32,$60,$32,$71,$32
	.DB $60,$32,$61,$32,$70,$33,$10,$33
	.DB $10,$33,$10,$33,$10,$33,$F0,$10
	.DB $F2,$52,$FF

CrtEatBlkData2:
	.DB $80,$13,$10,$13,$10,$13,$10,$13
	.DB $60,$23,$20,$23,$B0,$22,$A1,$22
	.DB $A0,$22,$A1,$22,$C0,$13,$10,$13
	.DB $10,$13,$10,$13,$10,$13,$10,$13
	.DB $10,$13,$F0,$F0,$F0,$52,$50,$33
	.DB $50,$32,$50,$33,$50,$22,$50,$33
	.DB $F0,$50,$82,$FF

WoodenSpike:
	JSR WoodSpikeGfx
	LDA wm_SpritesLocked
	BNE Return039440
	JSR SubOffscreen0Bnk3
	JSR CODE_039488
	LDA wm_SpriteState,X
	AND #$03
	JSL ExecutePtr

WoodenSpikePtrs:
	.DW CODE_039458
	.DW CODE_03944E
	.DW CODE_039441
	.DW CODE_03946B

Return039440:
	RTS

CODE_039441:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_03944A
	LDA #$20
	BRA CODE_039475

CODE_03944A:
	LDA #$30
	BRA _SetTimerNextState

CODE_03944E:
	LDA wm_SpriteDecTbl1,X
	BNE Return039457
	LDA #$18
	BRA _SetTimerNextState

Return039457:
	RTS

CODE_039458:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_039463
	LDA #$F0
	JSR CODE_039475
	RTS

CODE_039463:
	LDA #$30
_SetTimerNextState:
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
	RTS

CODE_03946B:
	LDA wm_SpriteDecTbl1,X
	BNE Return039474
	LDA #$2F
	BRA _SetTimerNextState

Return039474:
	RTS

CODE_039475:
	LDY wm_SpriteMiscTbl3,X
	BEQ +
	EOR #$FF
	INC A
+	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	RTS

DATA_039484:	.DB $01,$FF

DATA_039486:	.DB $00,$FF

CODE_039488:
	JSL MarioSprInteract
	BCC _Return0394B0
	JSR SubHorzPosBnk3
	LDA m15
	CLC
	ADC #$04
	CMP #$08
	BCS CODE_03949F
	JSL HurtMario
	RTS

CODE_03949F:
	LDA wm_MarioXPos
	CLC
	ADC DATA_039484,Y
	STA wm_MarioXPos
	LDA wm_MarioXPos+1
	ADC DATA_039486,Y
	STA wm_MarioXPos+1
	STZ wm_MarioSpeedX
_Return0394B0:
	RTS

WoodSpikeDispY:
	.DB $00,$10,$20,$30,$40,$40,$30,$20
	.DB $10,$00

WoodSpikeTiles:
	.DB $6A,$6A,$6A,$6A,$4A,$6A,$6A,$6A
	.DB $6A,$4A

WoodSpikeGfxProp:
	.DB $81,$81,$81,$81,$81,$01,$01,$01
	.DB $01,$01

WoodSpikeGfx:
	JSR GetDrawInfoBnk3
	STZ m2
	LDA wm_SpriteNum,X
	CMP #$AD
	BNE +
	LDA #$05
	STA m2
+	PHX
	LDX #$04
-	PHX
	TXA
	CLC
	ADC m2
	TAX
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W WoodSpikeDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W WoodSpikeTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W WoodSpikeGfxProp,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	PLX
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$04
	JSL FinishOAMWrite
	RTS

RexSpeed:	.DB $08,$F8,$10,$F0

RexMainRt:
	JSR RexGfxRt
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE +
	LDA wm_SpritesLocked
	BNE +
	LDA wm_SpriteDecTbl3,X
	BEQ RexAlive
	STA wm_SpriteEatenTbl,X
	DEC A
	BNE +
	STZ wm_SpriteStatus,X
+	RTS

RexAlive:
	JSR SubOffscreen0Bnk3
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	LDY wm_SpriteState,X
	BEQ CODE_03954A
	AND #$01
	CLC
	ADC #$03
	BRA _03954D

CODE_03954A:
	LSR
	AND #$01
_03954D:
	STA wm_SpriteGfxTbl,X
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ ++
	LDA #$10
	STA wm_SpriteSpeedY,X
	LDY wm_SpriteDir,X
	LDA wm_SpriteState,X
	BEQ +
	INY
	INY
+	LDA RexSpeed,Y
	STA wm_SpriteSpeedX,X
++	LDA wm_DisSprCapeContact,X
	BNE +
	JSL UpdateSpritePos
+	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
+	JSL SprSprInteract
	JSL MarioSprInteract
	BCC _NoRexContact
	LDA wm_StarPowerTimer
	BNE RexStarKill
	LDA wm_SpriteDecTbl2,X
	BNE _NoRexContact
	LDA #$08
	STA wm_SpriteDecTbl2,X
	LDA wm_MarioSpeedY
	CMP #$10
	BMI RexWins
	JSR RexPoints
	JSL BoostMarioSpeed
	JSL DisplayContactGfx
	LDA wm_IsSpinJump
	ORA wm_OnYoshi
	BNE RexSpinKill
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	CMP #$02
	BNE SmushRex
	LDA #$20
	STA wm_SpriteDecTbl3,X
	RTS

SmushRex:
	LDA #$0C
	STA wm_DisSprCapeContact,X
	STZ wm_Tweaker1662,X
	RTS

RexWins:
	LDA wm_PlayerHurtTimer
	ORA wm_OnYoshi
	BNE _NoRexContact
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	JSL HurtMario
_NoRexContact:
	RTS

RexSpinKill:
	LDA #$04
	STA wm_SpriteStatus,X
	LDA #$1F
	STA wm_SpriteDecTbl1,X
	JSL CODE_07FC3B
	LDA #$08
	STA wm_SoundCh1
	RTS

RexStarKill:
	LDA #$02
	STA wm_SpriteStatus,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	JSR SubHorzPosBnk3
	LDA RexKilledSpeed,Y
	STA wm_SpriteSpeedX,X
	INC wm_StarKillPoints
	LDA wm_StarKillPoints
	CMP #$08
	BCC +
	LDA #$08
	STA wm_StarKillPoints
+	JSL GivePoints
	LDY wm_StarKillPoints
	CPY #$08
	BCS +
	LDA DATA_038000-1,Y
	STA wm_SoundCh1
+	RTS

Return039624:
	RTS ; unused

RexKilledSpeed:	.DB $F0,$10

Return039627:
	RTS ; unused

RexPoints:
	PHY
	LDA wm_SprChainStomped
	CLC
	ADC wm_SprChainKillTbl,X
	INC wm_SprChainStomped
	TAY
	INY
	CPY #$08
	BCS +
	LDA DATA_038000-1,Y
	STA wm_SoundCh1
+	TYA
	CMP #$08
	BCC +
	LDA #$08
+	JSL GivePoints
	PLY
	RTS

RexTileDispX:
	.DB $FC,$00,$FC,$00,$FE,$00,$00,$00
	.DB $00,$00,$00,$08,$04,$00,$04,$00
	.DB $02,$00,$00,$00,$00,$00,$08,$00

RexTileDispY:
	.DB $F1,$00,$F0,$00,$F8,$00,$00,$00
	.DB $00,$00,$08,$08

RexTiles:
	.DB $8A,$AA,$8A,$AC,$8A,$AA,$8C,$8C
	.DB $A8,$A8,$A2,$B2

RexGfxProp:	.DB $47,$07

RexGfxRt:
	LDA wm_SpriteDecTbl3,X
	BEQ +
	LDA #$05
	STA wm_SpriteGfxTbl,X
+	LDA wm_DisSprCapeContact,X
	BEQ +
	LDA #$02
	STA wm_SpriteGfxTbl,X
+	JSR GetDrawInfoBnk3
	LDA wm_SpriteGfxTbl,X
	ASL
	STA m3
	LDA wm_SpriteDir,X
	STA m2
	PHX
	LDX #$01
-	PHX
	TXA
	ORA m3
	PHA
	LDX m2
	BNE +
	CLC
	ADC #$0C
+	TAX
	LDA m0
	CLC
	ADC.W RexTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA m1
	CLC
	ADC.W RexTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W RexTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDX m2
	LDA.W RexGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	LDX m3
	CPX #$0A
	TAX
	LDA #$00
	BCS +
	LDA #$02
+	STA wm_OamSize.1,X
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$FF
	LDA #$01
	JSL FinishOAMWrite
	RTS

Fishbone:
	JSR FishboneGfx
	LDA wm_SpritesLocked
	BNE Return03972A
	JSR SubOffscreen0Bnk3
	JSL MarioSprInteract
	JSL UpdateXPosNoGrvty
	TXA
	ASL
	ASL
	ASL
	ASL
	ADC wm_FrameA
	AND #$7F
	BNE +
	JSL GetRand
	AND #$01
	BNE +
	LDA #$0C
	STA wm_SpriteDecTbl3,X
+	LDA wm_SpriteState,X
	JSL ExecutePtr

FishbonePtrs:
	.DW CODE_03972F
	.DW CODE_03975E

Return03972A:
	RTS

FishboneMaxSpeed:	.DB $10,$F0

FishboneAcceler:	.DB $01,$FF

CODE_03972F:
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	NOP
	LSR
	AND #$01
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_039756
	AND #$01
	BNE +
	LDY wm_SpriteDir,X
	LDA wm_SpriteSpeedX,X
	CMP FishboneMaxSpeed,Y
	BEQ +
	CLC
	ADC FishboneAcceler,Y
	STA wm_SpriteSpeedX,X
+	RTS

CODE_039756:
	INC wm_SpriteState,X
	LDA #$30
	STA wm_SpriteDecTbl1,X
	RTS

CODE_03975E:
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_039776
	AND #$03
	BNE _Return039775
	LDA wm_SpriteSpeedX,X
	BEQ _Return039775
	BPL CODE_039773
	INC wm_SpriteSpeedX,X
	RTS

CODE_039773:
	DEC wm_SpriteSpeedX,X
_Return039775:
	RTS

CODE_039776:
	STZ wm_SpriteState,X
	LDA #$30
	STA wm_SpriteDecTbl1,X
	RTS

FishboneDispX:	.DB $F8,$F8,$10,$10

FishboneDispY:	.DB $00,$08

FishboneGfxProp:	.DB $4D,$CD,$0D,$8D

FishboneTailTiles:	.DB $A3,$A3,$B3,$B3

FishboneGfx:
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDecTbl3,X
	CMP #$01
	LDA #$A6
	BCC +
	LDA #$A8
+	STA wm_OamSlot.1.Tile,Y
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDir,X
	ASL
	STA m2
	LDA wm_SpriteGfxTbl,X
	ASL
	STA m3
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	TAY
	PHX
	LDX #$01
-	LDA m1
	CLC
	ADC.W FishboneDispY,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	TXA
	ORA m2
	TAX
	LDA m0
	CLC
	ADC.W FishboneDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA.W FishboneGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLA
	PHA
	ORA m3
	TAX
	LDA.W FishboneTailTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$00
	LDA #$02
	JSL FinishOAMWrite
	RTS

CODE_0397F9:
	STA m1
	PHX
	PHY
	JSR SubVertPosBnk3
	STY m2
	LDA m14
	BPL +
	EOR #$FF
	CLC
	ADC #$01
+	STA m12
	JSR SubHorzPosBnk3
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

ReznorInit:
	CPX #$07
	BNE +
	LDA #$04
	STA wm_SpriteState,X
	JSL CODE_03DD7D
+	JSL GetRand
	STA wm_SpriteMiscTbl6,X
	RTL

ReznorStartPosLo:	.DB $00,$80,$00,$80

ReznorStartPosHi:	.DB $00,$00,$01,$01

ReboundSpeedX:	.DB $20,$E0

Reznor:
	INC wm_ReznorSmokeFlag
	LDA wm_SpritesLocked
	BEQ ReznorNotLocked
	JMP _DrawReznor

ReznorNotLocked:
	CPX #$07
	BNE _039910
	PHX
	JSL CODE_03D70C
	LDA #$80
	STA wm_M7X
	STZ wm_M7X+1
	LDX #$00
	LDA #$C0
	STA wm_SpriteXLo
	STZ wm_SpriteXHi
	LDA #$B2
	STA wm_SpriteYLo
	STZ wm_SpriteYHi
	LDA #$2C
	STA wm_M7BossProp
	JSL CODE_03DEDF
	PLX
	REP #$20
	LDA wm_M7Rotate
	CLC
	ADC #$0001
	AND #$01FF
	STA wm_M7Rotate
	SEP #$20
	CPX #$07
	BNE _039910
	LDA wm_SpriteDecTbl6,X
	BEQ ReznorNoLevelEnd
	DEC A
	BNE _039910
	DEC wm_CutsceneNum
	LDA #$FF
	STA wm_EndLevelTimer
	LDA #$0B
	STA wm_MusicCh1
	RTS

ReznorNoLevelEnd:
	LDA wm_SpriteMiscTbl3.Spr8 ; reznor dead
	CLC
	ADC wm_SpriteMiscTbl3.Spr7
	ADC wm_SpriteMiscTbl3.Spr6
	ADC wm_SpriteMiscTbl3.Spr5
	CMP #$04
	BNE _039910
	LDA #$90
	STA wm_SpriteDecTbl6,X
	JSL KillMostSprites
	LDY #$07
	LDA #$00
-	STA wm_ExSpriteNum,Y
	DEY
	BPL -
_039910:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_03991A
	JMP _DrawReznor

CODE_03991A:
	TXA
	AND #$03
	TAY
	LDA wm_M7Rotate
	CLC
	ADC ReznorStartPosLo,Y
	STA m0
	LDA wm_M7Rotate+1
	ADC ReznorStartPosHi,Y
	AND #$01
	STA m1
	REP #$30
	LDA m0
	EOR #$01FF
	INC A
	STA m0
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
	LDA #$38
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
	LDA #$38
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
	LDA wm_SpriteXLo,X
	PHA
	STZ m0
	LDA m4
	BPL +
	DEC m0
+	CLC
	ADC wm_M7X
	PHP
	CLC
	ADC #$40
	STA wm_SpriteXLo,X
	LDA wm_M7X+1
	ADC #$00
	PLP
	ADC m0
	STA wm_SpriteXHi,X
	PLA
	SEC
	SBC wm_SpriteXLo,X
	EOR #$FF
	INC A
	STA wm_SpriteMiscTbl4,X
	STZ m1
	LDA m6
	BPL +
	DEC m1
+	CLC
	ADC wm_M7Y
	PHP
	ADC #$20
	STA wm_SpriteYLo,X
	LDA wm_M7Y+1
	ADC #$00
	PLP
	ADC m1
	STA wm_SpriteYHi,X
	LDA wm_SpriteMiscTbl3,X
	BEQ ReznorAlive
	JSL InvisBlkMainRt
	JMP _DrawReznor

ReznorAlive:
	LDA wm_FrameA
	AND #$00
	ORA wm_SpriteDecTbl5,X
	BNE +
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$00
	BNE +
	STZ wm_SpriteMiscTbl6,X
	LDA #$40
	STA wm_SpriteDecTbl3,X
+	TXA
	ASL
	ASL
	ASL
	ASL
	ADC wm_FrameB
	AND #$3F
	ORA wm_SpriteDecTbl3,X
	ORA wm_SpriteDecTbl5,X
	BNE +
	LDA wm_SpriteDir,X
	PHA
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	PLA
	CMP wm_SpriteDir,X
	BEQ +
	LDA #$0A
	STA wm_SpriteDecTbl5,X
+	LDA wm_SpriteDecTbl2,X
	BNE _DrawReznor
	JSL MarioSprInteract
	BCC _DrawReznor
	LDA #$08
	STA wm_SpriteDecTbl2,X
	LDA wm_MarioYPos
	SEC
	SBC wm_SpriteYLo,X
	CMP #$ED
	BMI HitReznor
	CMP #$F2
	BMI HitPlatSide
	LDA wm_MarioSpeedY
	BPL HitPlatSide
	LDA #$29
	STA wm_Tweaker1662,X
	LDA #$0F
	STA wm_SpriteDecTbl4,X
	LDA #$10
	STA wm_MarioSpeedY
	LDA #$01
	STA wm_SoundCh1
	BRA _DrawReznor

HitPlatSide:
	JSR SubHorzPosBnk3
	LDA ReboundSpeedX,Y
	STA wm_MarioSpeedX
	BRA _DrawReznor

HitReznor:
	JSL HurtMario
_DrawReznor:
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteDir,X
	PHA
	LDY wm_SpriteDecTbl5,X
	BEQ ++
	CPY #$05
	BCC +
	EOR #$01
	STA wm_SpriteDir,X
+	LDA #$02
	STA wm_SpriteGfxTbl,X
++	LDA wm_SpriteDecTbl3,X
	BEQ ++
	CMP #$20
	BNE +
	JSR ReznorFireRt
+	LDA #$01
	STA wm_SpriteGfxTbl,X
++	JSR ReznorGfxRt
	PLA
	STA wm_SpriteDir,X
	LDA wm_SpritesLocked
	ORA wm_SpriteMiscTbl3,X
	BNE +
	LDA wm_SpriteDecTbl4,X
	CMP #$0C
	BNE +
	LDA #$03
	STA wm_SoundCh1
	STZ wm_SpriteDecTbl3,X
	INC wm_SpriteMiscTbl3,X
	JSL FindFreeSprSlot
	BMI +
	LDA #$02
	STA wm_SpriteStatus,Y
	LDA #$A9
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
	LDA #$C0
	STA wm_SpriteSpeedY,X
	PLX
+	RTS

ReznorFireRt:
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ FoundRznrFireSlot
	DEY
	BPL -
	RTS

FoundRznrFireSlot:
	LDA #$10
	STA wm_SoundCh1
	LDA #$02
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	PHA
	SEC
	SBC #$08
	STA wm_ExSpriteXLo,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	SBC #$00
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC #$14
	STA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_ExSpriteYHi,Y
	STA wm_SpriteYHi,X
	LDA #$10
	JSR CODE_0397F9
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXLo,X
	LDA m0
	STA wm_ExSprSpeedY,Y
	LDA m1
	STA wm_ExSprSpeedX,Y
	RTS

ReznorTileDispX:	.DB $00,$F0,$00,$F0,$F0,$00,$F0,$00

ReznorTileDispY:	.DB $E0,$E0,$F0,$F0

ReznorTiles:
	.DB $40,$42,$60,$62,$44,$46,$64,$66
	.DB $28,$28,$48,$48

ReznorPal:
	.DB $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F
	.DB $7F,$3F,$7F,$3F

ReznorGfxRt:
	LDA wm_SpriteMiscTbl3,X
	BNE ++
	JSR GetDrawInfoBnk3
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	STA m3
	LDA wm_SpriteDir,X
	ASL
	ASL
	STA m2
	PHX
	LDX #$03
-	PHX
	LDA m3
	CMP #$08
	BCS +
	TXA
	ORA m2
	TAX
+	LDA m0
	CLC
	ADC.W ReznorTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA m1
	CLC
	ADC.W ReznorTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	PHX
	TXA
	ORA m3
	TAX
	LDA.W ReznorTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W ReznorPal,X
	CPX #$08
	BCS +
	LDX m2
	BNE +
	EOR #$40
+	STA wm_OamSlot.1.Prop,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$03
	JSL FinishOAMWrite
	LDA wm_SpriteStatus,X
	CMP #$02
	BEQ +
++	JSR ReznorPlatGfxRt
+	RTS

ReznorPlatDispY:	.DB $00,$03,$04,$05,$05,$04,$03,$00

ReznorPlatGfxRt:
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$10
	STA wm_SprOAMIndex,X
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDecTbl4,X
	LSR
	PHY
	TAY
	LDA ReznorPlatDispY,Y
	STA m2
	PLY
	LDA m0
	STA wm_OamSlot.2.XPos,Y
	SEC
	SBC #$10
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	SEC
	SBC m2
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA #$4E
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA #$33
	STA wm_OamSlot.1.Prop,Y
	ORA #$40
	STA wm_OamSlot.2.Prop,Y
	LDY #$02
	LDA #$01
	JSL FinishOAMWrite
	RTS

InvisBlkDinosMain:
	LDA wm_SpriteNum,X
	CMP #$6D
	BNE DinoMainRt
	JSL InvisBlkMainRt
	RTL

DinoMainRt:
	PHB
	PHK
	PLB
	JSR DinoMainSubRt
	PLB
	RTL

DinoMainSubRt:
	JSR DinoGfxRt
	LDA wm_SpritesLocked
	BNE _Return039CA3
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _Return039CA3
	JSR SubOffscreen0Bnk3
	JSL MarioSprInteract
	JSL UpdateSpritePos
	LDA wm_SpriteState,X
	JSL ExecutePtr

RhinoStatePtrs:
	.DW CODE_039CA8
	.DW CODE_039D41
	.DW CODE_039D41
	.DW CODE_039C74

DATA_039C6E:	.DB $00,$FE,$02

DATA_039C71:	.DB $00,$FF,$00

CODE_039C74:
	LDA wm_SpriteSpeedY,X
	BMI _039C89
	STZ wm_SpriteState,X
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ _039C89
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
_039C89:
	STZ wm_SpriteGfxTbl,X
	LDA wm_SprObjStatus,X
	AND #$03
	TAY
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_039C6E,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC DATA_039C71,Y
	STA wm_SpriteXHi,X
_Return039CA3:
	RTS

DinoSpeed:	.DB $08,$F8,$10,$F0

CODE_039CA8:
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ _039C89
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA wm_SpriteNum,X
	CMP #$6E
	BEQ +
	LDA #$FF
	STA wm_SpriteDecTbl1,X
	JSL GetRand
	AND #$01
	INC A
	STA wm_SpriteState,X
+	TXA
	ASL
	ASL
	ASL
	ASL
	ADC wm_FrameB
	AND #$3F
	BNE +
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
+	LDA #$10
	STA wm_SpriteSpeedY,X
	LDY wm_SpriteDir,X
	LDA wm_SpriteNum,X
	CMP #$6E
	BEQ +
	INY
	INY
+	LDA DinoSpeed,Y
	STA wm_SpriteSpeedX,X
	JSR DinoSetGfxFrame
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA #$C0
	STA wm_SpriteSpeedY,X
	LDA #$03
	STA wm_SpriteState,X
+	RTS

DinoFlameTable:
	.DB $41,$42,$42,$32,$22,$12,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$12
	.DB $22,$32,$42,$42,$42,$42,$41,$41
	.DB $41,$43,$43,$33,$23,$13,$03,$03
	.DB $03,$03,$03,$03,$03,$03,$03,$03
	.DB $03,$03,$03,$03,$03,$03,$03,$13
	.DB $23,$33,$43,$43,$43,$43,$41,$41

CODE_039D41:
	STZ wm_SpriteSpeedX,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	STZ wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	LDA #$00
+	CMP #$C0
	BNE +
	LDY #$17
	STY wm_SoundCh3
+	LSR
	LSR
	LSR
	LDY wm_SpriteState,X
	CPY #$02
	BNE +
	CLC
	ADC #$20
+	TAY
	LDA DinoFlameTable,Y
	PHA
	AND #$0F
	STA wm_SpriteGfxTbl,X
	PLA
	LSR
	LSR
	LSR
	LSR
	STA wm_SpriteMiscTbl3,X
	BNE +
	LDA wm_SpriteNum,X
	CMP #$6E
	BEQ +
	TXA
	EOR wm_FrameA
	AND #$03
	BNE +
	JSR DinoFlameClipping
	JSL GetMarioClipping
	JSL CheckForContact
	BCC +
	LDA wm_StarPowerTimer
	BNE +
	JSL HurtMario
+	RTS

DinoFlame1:	.DB $DC,$02,$10,$02

DinoFlame2:	.DB $FF,$00,$00,$00

DinoFlame3:	.DB $24,$0C,$24,$0C

DinoFlame4:	.DB $02,$DC,$02,$DC

DinoFlame5:	.DB $00,$FF,$00,$FF

DinoFlame6:	.DB $0C,$24,$0C,$24

DinoFlameClipping:
	LDA wm_SpriteGfxTbl,X
	SEC
	SBC #$02
	TAY
	LDA wm_SpriteDir,X
	BNE +
	INY
	INY
+	LDA wm_SpriteXLo,X
	CLC
	ADC DinoFlame1,Y
	STA m4
	LDA wm_SpriteXHi,X
	ADC DinoFlame2,Y
	STA m10
	LDA DinoFlame3,Y
	STA m6
	LDA wm_SpriteYLo,X
	CLC
	ADC DinoFlame4,Y
	STA m5
	LDA wm_SpriteYHi,X
	ADC DinoFlame5,Y
	STA m11
	LDA DinoFlame6,Y
	STA m7
	RTS

DinoSetGfxFrame:
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	AND #$08
	LSR
	LSR
	LSR
	STA wm_SpriteGfxTbl,X
	RTS

DinoTorchTileDispX:
	.DB $D8,$E0,$EC,$F8,$00,$FF,$FF,$FF
	.DB $FF,$00

DinoTorchTileDispY:
	.DB $00,$00,$00,$00,$00,$D8,$E0,$EC
	.DB $F8,$00

DinoFlameTiles:
	.DB $80,$82,$84,$86,$00,$88,$8A,$8C
	.DB $8E,$00

DinoTorchGfxProp:	.DB $09,$05,$05,$05,$0F

DinoTorchTiles:	.DB $EA,$AA,$C4,$C6

DinoRhinoTileDispX:	.DB $F8,$08,$F8,$08,$08,$F8,$08,$F8

DinoRhinoGfxProp:	.DB $2F,$2F,$2F,$2F,$6F,$6F,$6F,$6F

DinoRhinoTileDispY:	.DB $F0,$F0,$00,$00

DinoRhinoTiles:
	.DB $C0,$C2,$E4,$E6,$C0,$C2,$E0,$E2
	.DB $C8,$CA,$E8,$E2,$CC,$CE,$EC,$EE

DinoGfxRt:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDir,X
	STA m2
	LDA wm_SpriteGfxTbl,X
	STA m4
	LDA wm_SpriteNum,X
	CMP #$6F
	BEQ CODE_039EA9
	PHX
	LDX #$03
-	STX m15
	LDA m2
	CMP #$01
	BCS +
	TXA
	CLC
	ADC #$04
	TAX
+	LDA.W DinoRhinoGfxProp,X
	STA wm_OamSlot.1.Prop,Y
	LDA.W DinoRhinoTileDispX,X
	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	LDA m4
	CMP #$01
	LDX m15
	LDA.W DinoRhinoTileDispY,X
	ADC m1
	STA wm_OamSlot.1.YPos,Y
	LDA m4
	ASL
	ASL
	ADC m15
	TAX
	LDA.W DinoRhinoTiles,X
	STA wm_OamSlot.1.Tile,Y
	INY
	INY
	INY
	INY
	LDX m15
	DEX
	BPL -
	PLX
	LDA #$03
	LDY #$02
	JSL FinishOAMWrite
	RTS

CODE_039EA9:
	LDA wm_SpriteMiscTbl3,X
	STA m3
	LDA wm_SpriteGfxTbl,X
	STA m4
	PHX
	LDA wm_FrameB
	AND #$02
	ASL
	ASL
	ASL
	ASL
	ASL
	LDX m4
	CPX #$03
	BEQ +
	ASL
+	STA m5
	LDX #$04
_039EC8:
	STX m6
	LDA m4
	CMP #$03
	BNE +
	TXA
	CLC
	ADC #$05
	TAX
+	PHX
	LDA.W DinoTorchTileDispX,X
	LDX m2
	BNE +
	EOR #$FF
	INC A
+	PLX
	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	LDA.W DinoTorchTileDispY,X
	CLC
	ADC m1
	STA wm_OamSlot.1.YPos,Y
	LDA m6
	CMP #$04
	BNE CODE_039EFD
	LDX m4
	LDA.W DinoTorchTiles,X
	BRA _039F00

CODE_039EFD:
	LDA.W DinoFlameTiles,X
_039F00:
	STA wm_OamSlot.1.Tile,Y
	LDA #$00
	LDX m2
	BNE +
	ORA #$40
+	LDX m6
	CPX #$04
	BEQ +
	EOR m5
+	ORA.W DinoTorchGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	CPX m3
	BPL _039EC8
	PLX
	LDY wm_SpriteMiscTbl3,X
	LDA DinoTilesWritten,Y
	LDY #$02
	JSL FinishOAMWrite
	RTS

DinoTilesWritten:	.DB $04,$03,$02,$01,$00

Return039F37:
	RTS ; unused

Blargg:
	JSR CODE_03A062
	LDA wm_SpritesLocked
	BNE Return039F56
	JSL MarioSprInteract
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteState,X
	JSL ExecutePtr

BlarggPtrs:
	.DW CODE_039F57
	.DW CODE_039F8B
	.DW CODE_039FA4
	.DW CODE_039FC8
	.DW CODE_039FEF

Return039F56:
	RTS

CODE_039F57:
	LDA wm_OffscreenHorz,X
	ORA wm_SpriteDecTbl1,X
	BNE +
	JSR SubHorzPosBnk3
	LDA m15
	CLC
	ADC #$70
	CMP #$E0
	BCS +
	LDA #$E3
	STA wm_SpriteSpeedY,X
	LDA wm_SpriteXHi,X
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteXLo,X
	STA wm_SpriteMiscTbl4,X
	LDA wm_SpriteYHi,X
	STA wm_SpriteMiscTbl5,X
	LDA wm_SpriteYLo,X
	STA wm_SpriteMiscTbl7,X
	JSR CODE_039FC0
	INC wm_SpriteState,X
+	RTS

CODE_039F8B:
	LDA wm_SpriteSpeedY,X
	CMP #$10
	BMI CODE_039F9B
	LDA #$50
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
	STZ wm_SpriteSpeedY,X
	RTS

CODE_039F9B:
	JSL UpdateYPosNoGrvty
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
	RTS

CODE_039FA4:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_039FB1
	INC wm_SpriteState,X
	LDA #$0A
	STA wm_SpriteDecTbl1,X
	RTS

CODE_039FB1:
	CMP #$20
	BCC CODE_039FC0
	AND #$1F
	BNE _Return039FC7
	LDA wm_SpriteDir,X
	EOR #$01
	BRA _039FC4

CODE_039FC0:
	JSR SubHorzPosBnk3
	TYA
_039FC4:
	STA wm_SpriteDir,X
_Return039FC7:
	RTS

CODE_039FC8:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_039FD6
	LDA #$20
	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	RTS

CODE_039FD6:
	LDA #$20
	STA wm_SpriteDecTbl1,X
	LDY wm_SpriteDir,X
	LDA DATA_039FED,Y
	STA wm_SpriteSpeedX,X
	LDA #$E2
	STA wm_SpriteSpeedY,X
	JSR CODE_03A045
	INC wm_SpriteState,X
	RTS

DATA_039FED:	.DB $10,$F0

CODE_039FEF:
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BEQ +
	DEC A
	BNE _03A038
	LDA #$25
	STA wm_SoundCh1
	JSR CODE_03A045
+	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty
	LDA wm_FrameA
	AND #$00
	BNE +
	INC wm_SpriteSpeedY,X
+	LDA wm_SpriteSpeedY,X
	CMP #$20
	BMI _03A038
	JSR CODE_03A045
	STZ wm_SpriteState,X
	LDA wm_SpriteMiscTbl3,X
	STA wm_SpriteXHi,X
	LDA wm_SpriteMiscTbl4,X
	STA wm_SpriteXLo,X
	LDA wm_SpriteMiscTbl5,X
	STA wm_SpriteYHi,X
	LDA wm_SpriteMiscTbl7,X
	STA wm_SpriteYLo,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
_03A038:
	LDA wm_SpriteSpeedY,X
	CLC
	ADC #$06
	CMP #$0C
	BCS +
	INC wm_SpriteGfxTbl,X
+	RTS

CODE_03A045:
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC #$0C
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	JSL CODE_028528
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	RTS

CODE_03A062:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteState,X
	BEQ _03A038
	CMP #$04
	BEQ CODE_03A09D
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA #$A0
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$CF
	STA wm_OamSlot.1.Prop,Y
	RTS

DATA_03A082:
	.DB $F8,$08,$F8,$08,$18,$08,$F8,$08
	.DB $F8,$E8

DATA_03A08C:	.DB $F8,$F8,$08,$08,$08

BlarggTilemap:
	.DB $A2,$A4,$C2,$C4,$A6,$A2,$A4,$E6
	.DB $C8,$A6

DATA_03A09B:	.DB $45,$05

CODE_03A09D:
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	ADC wm_SpriteGfxTbl,X
	STA m3
	LDA wm_SpriteDir,X
	STA m2
	PHX
	LDX #$04
-	PHX
	PHX
	LDA m1
	CLC
	ADC.W DATA_03A08C,X
	STA wm_OamSlot.1.YPos,Y
	LDA m2
	BNE +
	TXA
	CLC
	ADC #$05
	TAX
+	LDA m0
	CLC
	ADC.W DATA_03A082,X
	STA wm_OamSlot.1.XPos,Y
	PLA
	CLC
	ADC m3
	TAX
	LDA.W BlarggTilemap,X
	STA wm_OamSlot.1.Tile,Y
	LDX m2
	LDA.W DATA_03A09B,X
	STA wm_OamSlot.1.Prop,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$04
	JSL FinishOAMWrite
	RTS

CODE_03A0F1:
	JSL InitSpriteTables
	STZ wm_OffscreenHorz,X
	LDA #$80
	STA wm_SpriteYLo,X
	LDA #$FF
	STA wm_SpriteYHi,X
	LDA #$D0
	STA wm_SpriteXLo,X
	LDA #$00
	STA wm_SpriteXHi,X
	LDA #$02
	STA wm_SprStompImmuneTbl,X
	LDA #$03
	STA wm_SpriteState,X
	JSL CODE_03DD7D
	RTL

Bnk3CallSprMain:
	PHB
	PHK
	PLB
	LDA wm_SpriteNum,X
	CMP #$C8
	BNE CODE_03A126
	JSR LightSwitch
	PLB
	RTL

CODE_03A126:
	CMP #$C7
	BNE CODE_03A12F
	JSR InvisMushroom
	PLB
	RTL

CODE_03A12F:
	CMP #$51
	BNE CODE_03A138
	JSR Ninji
	PLB
	RTL

CODE_03A138:
	CMP #$1B
	BNE CODE_03A141
	JSR Football
	PLB
	RTL

CODE_03A141:
	CMP #$C6
	BNE CODE_03A14A
	JSR DarkRoomWithLight
	PLB
	RTL

CODE_03A14A:
	CMP #$7A
	BNE CODE_03A153
	JSR Firework
	PLB
	RTL

CODE_03A153:
	CMP #$7C
	BNE CODE_03A15C
	JSR PrincessPeach
	PLB
	RTL

CODE_03A15C:
	CMP #$C5
	BNE CODE_03A165
	JSR BigBooBoss
	PLB
	RTL

CODE_03A165:
	CMP #$C4
	BNE CODE_03A16E
	JSR GreyFallingPlat
	PLB
	RTL

CODE_03A16E:
	CMP #$C2
	BNE CODE_03A177
	JSR Blurp
	PLB
	RTL

CODE_03A177:
	CMP #$C3
	BNE CODE_03A180
	JSR PorcuPuffer
	PLB
	RTL

CODE_03A180:
	CMP #$C1
	BNE CODE_03A189
	JSR FlyingTurnBlocks
	PLB
	RTL

CODE_03A189:
	CMP #$C0
	BNE CODE_03A192
	JSR GrayLavaPlatform
	PLB
	RTL

CODE_03A192:
	CMP #$BF
	BNE CODE_03A19B
	JSR MegaMole
	PLB
	RTL

CODE_03A19B:
	CMP #$BE
	BNE CODE_03A1A4
	JSR Swooper
	PLB
	RTL

CODE_03A1A4:
	CMP #$BD
	BNE CODE_03A1AD
	JSR SlidingKoopa
	PLB
	RTL

CODE_03A1AD:
	CMP #$BC
	BNE CODE_03A1B6
	JSR BowserStatue
	PLB
	RTL

CODE_03A1B6:
	CMP #$B8
	BEQ +
	CMP #$B7
	BNE CODE_03A1C3
+	JSR CarrotTopLift
	PLB
	RTL

CODE_03A1C3:
	CMP #$B9
	BNE CODE_03A1CC
	JSR InfoBox
	PLB
	RTL

CODE_03A1CC:
	CMP #$BA
	BNE CODE_03A1D5
	JSR TimedLift
	PLB
	RTL

CODE_03A1D5:
	CMP #$BB
	BNE CODE_03A1DE
	JSR GreyCastleBlock
	PLB
	RTL

CODE_03A1DE:
	CMP #$B3
	BNE CODE_03A1E7
	JSR StatueFireball
	PLB
	RTL

CODE_03A1E7:
	LDA wm_SpriteNum,X
	CMP #$B2
	BNE CODE_03A1F2
	JSR FallingSpike
	PLB
	RTL

CODE_03A1F2:
	CMP #$AE
	BNE CODE_03A1FB
	JSR FishinBoo
	PLB
	RTL

CODE_03A1FB:
	CMP #$B6
	BNE CODE_03A204
	JSR ReflectingFireball
	PLB
	RTL

CODE_03A204:
	CMP #$B0
	BNE CODE_03A20D
	JSR BooStream
	PLB
	RTL

CODE_03A20D:
	CMP #$B1
	BNE CODE_03A216
	JSR CreateEatBlock
	PLB
	RTL

CODE_03A216:
	CMP #$AC
	BEQ +
	CMP #$AD
	BNE CODE_03A223
+	JSR WoodenSpike
	PLB
	RTL

CODE_03A223:
	CMP #$AB
	BNE CODE_03A22C
	JSR RexMainRt
	PLB
	RTL

CODE_03A22C:
	CMP #$AA
	BNE CODE_03A235
	JSR Fishbone
	PLB
	RTL

CODE_03A235:
	CMP #$A9
	BNE CODE_03A23E
	JSR Reznor
	PLB
	RTL

CODE_03A23E:
	CMP #$A8
	BNE CODE_03A247
	JSR Blargg
	PLB
	RTL

CODE_03A247:
	CMP #$A1
	BNE CODE_03A250
	JSR BowserBowlingBall
	PLB
	RTL

CODE_03A250:
	CMP #$A2
	BNE BowserFight
	JSR MechaKoopa
	PLB
	RTL

BowserFight:
	JSL CODE_03DFCC
	JSR CODE_03A279
	JSR CODE_03B43C
	PLB
	RTL

DATA_03A265:
	.DB $04,$03,$02,$01,$00,$01,$02,$03
	.DB $04,$05,$06,$07,$07,$07,$07,$07
	.DB $07,$07,$07,$07

CODE_03A279:
	LDA wm_M7Scale
	LSR
	LSR
	LSR
	TAY
	LDA DATA_03A265,Y
	STA wm_BowserPaletteIndex
	LDA wm_SpriteMiscTbl6,X
	CLC
	ADC #$1E
	ORA wm_SpriteDir,X
	STA wm_M7BossProp
	LDA wm_FrameB
	LSR
	AND #$03
	STA wm_BowserPropellerIndex
	LDA #$90
	STA wm_M7X
	LDA #$C8
	STA wm_M7Y
	JSL CODE_03DEDF
	LDA wm_BowserHurtTimer
	BEQ +
	JSR CODE_03AF59
+	LDA wm_SpriteDecTbl4,X
	BEQ +
	JSR CODE_03A3E2
+	LDA wm_SpriteMiscTbl7,X
	BEQ +
	DEC A
	LSR
	LSR
	PHA
	LSR
	TAY
	LDA DATA_03A8BE,Y
	STA m2
	PLA
	AND #$03
	STA m3
	JSR CODE_03AA6E
	NOP
+	LDA wm_SpritesLocked
	BNE Return03A340
	STZ wm_SpriteMiscTbl7,X
	LDA #$30
	STA wm_SpriteProp
	LDA wm_M7Scale
	CMP #$20
	BCS +
	STZ wm_SpriteProp
+	JSR CODE_03A661
	LDA wm_ChainCentX
	BEQ +
	LDA wm_FrameA
	AND #$03
	BNE +
	DEC wm_ChainCentX
+	LDA wm_FrameA
	AND #$7F
	BNE +
	JSL GetRand
	AND #$01
	BNE +
	LDA #$0C
	STA wm_SpriteDecTbl3,X
+	JSR CODE_03B078
	LDA wm_SpriteMiscTbl3,X
	CMP #$09
	BEQ +
	STZ wm_BowserClownImage
	LDA wm_SpriteDecTbl3,X
	BEQ +
	INC wm_BowserClownImage
+	JSR CODE_03A5AD
	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty
	LDA wm_SpriteMiscTbl3,X
	JSL ExecutePtr

BowserFightPtrs:
	.DW CODE_03A441
	.DW CODE_03A6F8
	.DW CODE_03A84B
	.DW CODE_03A7AD
	.DW CODE_03AB9F
	.DW CODE_03ABBE
	.DW CODE_03AC03
	.DW CODE_03A49C
	.DW CODE_03AB21
	.DW CODE_03AB64

Return03A340:
	RTS

DATA_03A341:
	.DB $D5,$DD,$23,$2B,$D5,$DD,$23,$2B
	.DB $D5,$DD,$23,$2B,$D5,$DD,$23,$2B
	.DB $D6,$DE,$22,$2A,$D6,$DE,$22,$2A
	.DB $D7,$DF,$21,$29,$D7,$DF,$21,$29
	.DB $D8,$E0,$20,$28,$D8,$E0,$20,$28
	.DB $DA,$E2,$1E,$26,$DA,$E2,$1E,$26
	.DB $DC,$E4,$1C,$24,$DC,$E4,$1C,$24
	.DB $E0,$E8,$18,$20,$E0,$E8,$18,$20
	.DB $E8,$F0,$10,$18,$E8,$F0,$10,$18

DATA_03A389:
	.DB $DD,$D5,$D5,$DD,$23,$2B,$2B,$23
	.DB $DD,$D5,$D5,$DD,$23,$2B,$2B,$23
	.DB $DE,$D6,$D6,$DE,$22,$2A,$2A,$22
	.DB $DF,$D7,$D7,$DF,$21,$29,$29,$21
	.DB $E0,$D8,$D8,$E0,$20,$28,$28,$20
	.DB $E2,$DA,$DA,$E2,$1E,$26,$26,$1E
	.DB $E4,$DC,$DC,$E4,$1C,$24,$24,$1C
	.DB $E8,$E0,$E0,$E8,$18,$20,$20,$18
	.DB $F0,$E8,$E8,$F0,$10,$18,$18,$10

DATA_03A3D1:	.DB $80,$40,$00,$C0,$00,$C0,$80,$40

DATA_03A3D9:
	.DB $E3,$ED,$ED,$EB,$EB,$E9,$E9,$E7
	.DB $E7

CODE_03A3E2:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDecTbl4,X
	DEC A
	LSR
	STA m3
	ASL
	ASL
	ASL
	STA m2
	LDA #$70
	STA wm_SprOAMIndex,X
	TAY
	PHX
	LDX #$07
-	PHX
	TXA
	ORA m2
	TAX
	LDA m0
	CLC
	ADC.W DATA_03A341,X
	CLC
	ADC #$08
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_03A389,X
	CLC
	ADC #$30
	STA wm_OamSlot.1.YPos,Y
	LDX m3
	LDA.W DATA_03A3D9,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA.W DATA_03A3D1,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	LDY #$02
	LDA #$07
	JSL FinishOAMWrite
	RTS

DATA_03A437:
	.DB $00,$00,$00,$00,$02,$04,$06,$08
	.DB $0A,$0E

CODE_03A441:
	LDA wm_SpriteDecTbl2,X
	BNE CODE_03A482
	LDA wm_SpriteDecTbl1,X
	BNE CODE_03A465
	LDA #$0E
	STA wm_SpriteMiscTbl6,X
	LDA #$04
	STA wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$10
	BNE +
	LDA #$A4
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_03A465:
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
	CMP #$01
	BEQ CODE_03A47C
	CMP #$40
	BCS +
	LSR
	LSR
	LSR
	TAY
	LDA DATA_03A437,Y
	STA wm_SpriteMiscTbl6,X
+	RTS

CODE_03A47C:
	LDA #$24
	STA wm_SpriteDecTbl2,X
	RTS

CODE_03A482:
	DEC A
	BNE +
	LDA #$07
	STA wm_SpriteMiscTbl3,X
	LDA #$78
	STA wm_ChainCentX
+	RTS

DATA_03A490:	.DB $FF,$01

DATA_03A492:	.DB $C8,$38

DATA_03A494:	.DB $01,$FF

DATA_03A496:	.DB $1C,$E4

DATA_03A498:	.DB $00,$02,$04,$02

CODE_03A49C:
	JSR CODE_03A4D2
	JSR CODE_03A4FD
	JSR CODE_03A4ED
	LDA wm_SpriteMiscTbl4,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_03A490,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_03A492,Y
	BNE +
	INC wm_SpriteMiscTbl4,X
+	LDA wm_SpriteMiscTbl5,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_03A494,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_03A496,Y
	BNE +
	INC wm_SpriteMiscTbl5,X
+	RTS

CODE_03A4D2:
	LDY #$00
	LDA wm_FrameA
	AND #$E0
	BNE +
	LDA wm_FrameA
	AND #$18
	LSR
	LSR
	LSR
	TAY
	LDA DATA_03A498,Y
	TAY
+	TYA
	STA wm_SpriteMiscTbl6,X
	RTS

DATA_03A4EB:	.DB $80,$00

CODE_03A4ED:
	LDA wm_FrameA
	AND #$1F
	BNE +
	JSR SubHorzPosBnk3
	LDA DATA_03A4EB,Y
	STA wm_SpriteDir,X
+	RTS

CODE_03A4FD:
	LDA wm_ChainCentX
	BNE _Return03A52C
	LDA wm_SpriteMiscTbl3,X
	CMP #$08
	BNE CODE_03A51A
	INC wm_ChainFirstX
	LDA wm_ChainFirstX
	CMP #$03
	BEQ CODE_03A51A
	LDA #$FF
	STA wm_ChainSinY
	BRA _Return03A52C

CODE_03A51A:
	STZ wm_ChainFirstX
	LDA wm_SpriteStatus
	BEQ +
	LDA wm_SpriteStatus.Spr2
	BNE _Return03A52C
+	LDA #$FF
	STA wm_BowserMechTimer
_Return03A52C:
	RTS

DATA_03A52D:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$02,$04,$06,$08,$0A,$0E,$0E
	.DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.DB $0E,$0E,$0A,$08,$06,$04,$02,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00

DATA_03A56D:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$10,$20,$30,$40,$50,$60
	.DB $80,$A0,$C0,$E0,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$C0,$80,$60
	.DB $40,$30,$20,$10,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00

CODE_03A5AD:
	LDA wm_BowserMechTimer
	BEQ CODE_03A5D8
	DEC wm_BowserMechTimer
	BNE CODE_03A5BD
	LDA #$54
	STA wm_ChainCentX
	RTS

CODE_03A5BD:
	LSR
	LSR
	TAY
	LDA DATA_03A52D,Y
	STA wm_SpriteMiscTbl6,X
	LDA wm_BowserMechTimer
	CMP #$80
	BNE +
	JSR CODE_03B019
	LDA #$08
	STA wm_SoundCh3
+	PLA
	PLA
	RTS

CODE_03A5D8:
	LDA wm_ChainSinY
	BEQ ++
	DEC wm_ChainSinY
	BEQ CODE_03A60E
	LSR
	LSR
	TAY
	LDA DATA_03A52D,Y
	STA wm_SpriteMiscTbl6,X
	LDA DATA_03A56D,Y
	STA wm_M7Rotate
	STZ wm_M7Rotate+1
	CMP #$FF
	BNE +
	STZ wm_M7Rotate
	INC wm_M7Rotate+1
	STZ wm_SpriteProp
+	LDA wm_ChainSinY
	CMP #$80
	BNE +
	LDA #$09
	STA wm_SoundCh3
	JSR CODE_03A61D
+	PLA
	PLA
++	RTS

CODE_03A60E:
	LDA #$60
	LDY wm_ChainFirstX
	CPY #$02
	BEQ +
	LDA #$20
+	STA wm_ChainCentX
	RTS

CODE_03A61D:
	LDA #$08
	STA wm_SpriteStatus.Spr9
	LDA #$A1
	STA wm_SpriteNum+8
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_SpriteXLo+8
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi.Spr9
	LDA wm_SpriteYLo,X
	CLC
	ADC #$40
	STA wm_SpriteYLo+8
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi.Spr9
	PHX
	LDX #$08
	JSL InitSpriteTables
	PLX
	RTS

DATA_03A64D:
	.DB $00,$00,$00,$00,$FC,$F8,$F4,$F0
	.DB $F4,$F8,$FC,$00,$04,$08,$0C,$10
	.DB $0C,$08,$04,$00

CODE_03A661:
	LDA wm_BowserHurtTimer
	BEQ ++
	STZ wm_BowserMechTimer
	STZ wm_ChainSinY
	DEC wm_BowserHurtTimer
	BNE +
	LDA #$50
	STA wm_ChainCentX
	DEC wm_SprStompImmuneTbl,X
	BNE +
	LDA wm_SpriteMiscTbl3,X
	CMP #$09
	BEQ CODE_03A6C0
	LDA #$02
	STA wm_SprStompImmuneTbl,X
	LDA #$01
	STA wm_SpriteMiscTbl3,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
+	PLY
	PLY
	PHA
	LDA wm_BowserHurtTimer
	LSR
	LSR
	TAY
	LDA DATA_03A64D,Y
	STA wm_M7Rotate
	STZ wm_M7Rotate+1
	BPL +
	INC wm_M7Rotate+1
+	PLA
	LDY #$0C
	CMP #$40
	BCS +
_03A6AC:
	LDA wm_FrameA
	LDY #$10
	AND #$04
	BEQ +
	LDY #$12
+	TYA
	STA wm_SpriteMiscTbl6,X
	LDA #$02
	STA wm_BowserClownImage
++	RTS

CODE_03A6C0:
	LDA #$04
	STA wm_SpriteMiscTbl3,X
	STZ wm_SpriteSpeedX,X
	RTS

KillMostSprites:
	LDY #$09
-	LDA wm_SpriteStatus,Y
	BEQ +
	LDA.W wm_SpriteNum,Y
	CMP #$A9
	BEQ +
	CMP #$29
	BEQ +
	CMP #$A0
	BEQ +
	CMP #$C5
	BEQ +
	LDA #$04
	STA wm_SpriteStatus,Y
	LDA #$1F
	STA wm_SpriteDecTbl1,Y
+	DEY
	BPL -
	RTL

DATA_03A6F0:	.DB $0E,$0E,$0A,$08,$06,$04,$02,$00

CODE_03A6F8:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_03A731
	CMP #$01
	BNE +
	LDY #$17
	STY wm_MusicCh1
+	LSR
	LSR
	LSR
	LSR
	TAY
	LDA DATA_03A6F0,Y
	STA wm_SpriteMiscTbl6,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteMiscTbl4,X
	STZ wm_SpriteMiscTbl5,X
	STZ wm_ChainCentY
	RTS

DATA_03A71F:	.DB $01,$FF

DATA_03A721:	.DB $10,$80

DATA_03A723:	.DB $07,$03

DATA_03A725:	.DB $FF,$01

DATA_03A727:	.DB $F0,$08

DATA_03A729:	.DB $01,$FF

DATA_03A72B:	.DB $03,$03

DATA_03A72D:	.DB $60,$02

DATA_03A72F:	.DB $01,$01

CODE_03A731:
	LDY wm_SpriteMiscTbl4,X
	CPY #$02
	BCS +
	LDA wm_FrameA
	AND DATA_03A723,Y
	BNE +
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_03A71F,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_03A721,Y
	BNE +
	INC wm_SpriteMiscTbl4,X
+	LDY wm_SpriteMiscTbl5,X
	CPY #$02
	BCS +
	LDA wm_FrameA
	AND DATA_03A72B,Y
	BNE +
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_03A725,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_03A727,Y
	BNE +
	INC wm_SpriteMiscTbl5,X
+	LDY wm_ChainCentY
	CPY #$02
	BEQ ++
	LDA wm_FrameA
	AND DATA_03A72F,Y
	BNE +
	LDA wm_M7Scale
	CLC
	ADC DATA_03A729,Y
	STA wm_M7Scale
	STA wm_M7Scale+1
	CMP DATA_03A72D,Y
	BNE +
	INC wm_ChainCentY
+	LDA wm_SpriteXHi,X
	CMP #$FE
	BNE +
++	LDA #$03
	STA wm_SpriteMiscTbl3,X
	LDA #$80
	STA wm_ChainCentX
	JSL GetRand
	AND #$F0
	STA wm_BowserFireX
	LDA #$1D
	STA wm_MusicCh1
+	RTS

CODE_03A7AD:
	LDA #$60
	STA wm_M7Scale
	STA wm_M7Scale+1
	LDA #$FF
	STA wm_SpriteXHi,X
	LDA #$60
	STA wm_SpriteXLo,X
	LDA wm_ChainCentX
	BNE CODE_03A7DF
	LDA #$18
	STA wm_MusicCh1
	LDA #$02
	STA wm_SpriteMiscTbl3,X
	LDA #$18
	STA wm_SpriteYLo,X
	LDA #$00
	STA wm_SpriteYHi,X
	LDA #$08
	STA wm_M7Scale
	STA wm_M7Scale+1
	LDA #$64
	STA wm_SpriteSpeedX,X
	RTS

CODE_03A7DF:
	CMP #$60
	BCS _Return03A840
	LDA wm_FrameA
	AND #$1F
	BNE _Return03A840
	LDY #$07
-	LDA wm_SpriteStatus,Y
	BEQ CODE_03A7F6
	DEY
	CPY #$01
	BNE -
	RTS

CODE_03A7F6:
	LDA #$17
	STA wm_SoundCh3
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$33
	STA.W wm_SpriteNum,Y
	LDA wm_BowserFireX
	PHA
	STA.W wm_SpriteXLo,Y
	CLC
	ADC #$20
	STA wm_BowserFireX
	LDA #$00
	STA wm_SpriteXHi,Y
	LDA #$00
	STA.W wm_SpriteYLo,Y
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	INC wm_SpriteState,X
	ASL wm_Tweaker1686,X
	LSR wm_Tweaker1686,X
	LDA #$39
	STA wm_Tweaker1662,X
	PLX
	PLA
	LSR
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA BowserSound,Y
	STA wm_SoundCh3
_Return03A840:
	RTS

BowserSound:	.DB $2D,$2E,$2F,$30,$31,$32,$33,$34

BowserSoundMusic:	.DB $19,$1A

CODE_03A84B:
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteDecTbl1,X
	BNE CODE_03A86E
	LDA wm_SpriteSpeedX,X
	BEQ +
	DEC wm_SpriteSpeedX,X
+	LDA wm_FrameA
	AND #$03
	BNE +
	INC wm_M7Scale
	INC wm_M7Scale+1
	LDA wm_M7Scale
	CMP #$20
	BNE +
	LDA #$FF
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_03A86E:
	CMP #$A0
	BNE +
	PHA
	JSR CODE_03A8D6
	PLA
+	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	CMP #$01
	BEQ CODE_03A89D
	CMP #$40
	BCS CODE_03A8AE
	CMP #$3F
	BNE +
	PHA
	LDY wm_ChainCosX
	LDA BowserSoundMusic-7,Y
	STA wm_MusicCh1
	PLA
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_03A437,Y
	STA wm_SpriteMiscTbl6,X
	RTS

CODE_03A89D:
	LDA wm_ChainCosX
	INC A
	STA wm_SpriteMiscTbl3,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	LDA #$80
	STA wm_ChainCentX
	RTS

CODE_03A8AE:
	CMP #$E8
	BNE +
	LDY #$2A
	STY wm_SoundCh1
+	SEC
	SBC #$3F
	STA wm_SpriteMiscTbl7,X
	RTS

DATA_03A8BE:
	.DB $00,$00,$00,$08,$10,$14,$14,$16
	.DB $16,$18,$18,$17,$16,$16,$17,$18
	.DB $18,$17,$14,$10,$0C,$08,$04,$00

CODE_03A8D6:
	LDY #$07
-	LDA wm_SpriteStatus,Y
	BEQ CODE_03A8E3
	DEY
	CPY #$01
	BNE -
	RTS

CODE_03A8E3:
	LDA #$10
	STA wm_SoundCh1
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$74
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$18
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDA #$C0
	STA wm_SpriteSpeedY,X
	STZ wm_SpriteDir,X
	LDY #$0C
	LDA wm_SpriteXLo,X
	BPL +
	LDY #$F4
	INC wm_SpriteDir,X
+	STY wm_SpriteSpeedX,X
	PLX
	RTS

DATA_03A92E:
	.DB $00,$08,$00,$08,$00,$08,$00,$08
	.DB $00,$08,$00,$08,$00,$08,$00,$08
	.DB $00,$08,$00,$08,$00,$08,$00,$08
	.DB $00,$08,$00,$08,$00,$08,$00,$08
	.DB $00,$08,$00,$08,$00,$08,$00,$08
	.DB $00,$08,$00,$08,$00,$08,$00,$08
	.DB $08,$00,$08,$00,$08,$00,$08,$00
	.DB $08,$00,$08,$00,$08,$00,$08,$00
	.DB $08,$00,$08,$00,$08,$00,$08,$00
	.DB $08,$00,$08,$00,$08,$00,$08,$00

DATA_03A97E:
	.DB $00,$00,$08,$08,$00,$00,$08,$08
	.DB $00,$00,$08,$08,$00,$00,$08,$08
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10
	.DB $00,$00,$10,$10,$00,$00,$10,$10

DATA_03A9CE:
	.DB $05,$06,$15,$16,$9D,$9E,$4E,$AE
	.DB $06,$05,$16,$15,$9E,$9D,$AE,$4E
	.DB $8A,$8B,$AA,$68,$83,$84,$AA,$68
	.DB $8A,$8B,$80,$81,$83,$84,$80,$81
	.DB $85,$86,$A5,$A6,$83,$84,$A5,$A6
	.DB $82,$83,$A2,$A3,$82,$83,$A2,$A3
	.DB $8A,$8B,$AA,$68,$83,$84,$AA,$68
	.DB $8A,$8B,$80,$81,$83,$84,$80,$81
	.DB $85,$86,$A5,$A6,$83,$84,$A5,$A6
	.DB $82,$83,$A2,$A3,$82,$83,$A2,$A3

DATA_03AA1E:
	.DB $01,$01,$01,$01,$01,$01,$01,$01
	.DB $41,$41,$41,$41,$41,$41,$41,$41
	.DB $01,$01,$01,$01,$01,$01,$01,$01
	.DB $01,$01,$01,$01,$01,$01,$01,$01
	.DB $00,$00,$00,$00,$01,$01,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $41,$41,$41,$41,$41,$41,$41,$41
	.DB $41,$41,$41,$41,$41,$41,$41,$41
	.DB $40,$40,$40,$40,$41,$41,$40,$40
	.DB $40,$40,$40,$40,$40,$40,$40,$40

CODE_03AA6E:
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	CLC
	ADC #$20
	SEC
	SBC m2
	SEC
	SBC wm_Bg1VOfs
	STA m1
	CPY #$08
	BCC +
	CPY #$10
	BCS +
	LDA m0
	SEC
	SBC #$04
	STA wm_ExOamSlot.41.XPos
	CLC
	ADC #$10
	STA wm_ExOamSlot.42.XPos
	LDA m1
	SEC
	SBC #$18
	STA wm_ExOamSlot.41.YPos
	STA wm_ExOamSlot.42.YPos
	LDA #$20
	STA wm_ExOamSlot.41.Tile
	LDA #$22
	STA wm_ExOamSlot.42.Tile
	LDA wm_FrameB
	LSR
	AND #$06
	INC A
	INC A
	INC A
	STA wm_ExOamSlot.41.Prop
	STA wm_ExOamSlot.42.Prop
	LDA #$02
	STA wm_ExOamSize.41
	STA wm_ExOamSize.42
+	LDY #$70
_03AAC8:
	LDA m3
	ASL
	ASL
	STA m4
	PHX
	LDX #$03
-	PHX
	TXA
	CLC
	ADC m4
	TAX
	LDA m0
	CLC
	ADC.W DATA_03A92E,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_03A97E,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_03A9CE,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_03AA1E,X
	PHX
	LDX wm_SprProcessIndex
	CPX #$09
	BEQ +
	ORA #$30
+	STA wm_OamSlot.1.Prop,Y
	PLX
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
	PLX
	DEX
	BPL -
	PLX
	RTS

DATA_03AB15:	.DB $01,$FF

DATA_03AB17:	.DB $20,$E0

DATA_03AB19:	.DB $02,$FE

DATA_03AB1B:	.DB $20,$E0,$01,$FF,$10,$F0

CODE_03AB21:
	JSR CODE_03A4FD
	JSR CODE_03A4D2
	JSR CODE_03A4ED
	LDA wm_FrameA
	AND #$00
	BNE ++
	LDY #$00
	LDA wm_SpriteXLo,X
	CMP wm_MarioXPos
	LDA wm_SpriteXHi,X
	SBC wm_MarioXPos+1
	BMI +
	INY
+	LDA wm_SpriteSpeedX,X
	CMP DATA_03AB17,Y
	BEQ ++
	CLC
	ADC DATA_03AB15,Y
	STA wm_SpriteSpeedX,X
++	LDY #$00
	LDA wm_SpriteYLo,X
	CMP #$10
	BMI +
	INY
+	LDA wm_SpriteSpeedY,X
	CMP DATA_03AB1B,Y
	BEQ +
	CLC
	ADC DATA_03AB19,Y
	STA wm_SpriteSpeedY,X
+	RTS

DATA_03AB62:	.DB $10,$F0

CODE_03AB64:
	LDA #$03
	STA wm_BowserClownImage
	JSR CODE_03A4FD
	JSR CODE_03A4D2
	JSR CODE_03A4ED
	LDA wm_SpriteSpeedY,X
	CLC
	ADC #$03
	STA wm_SpriteSpeedY,X
	LDA wm_SpriteYLo,X
	CMP #$64
	BCC +
	LDA wm_SpriteYHi,X
	BMI +
	LDA #$64
	STA wm_SpriteYLo,X
	LDA #$A0
	STA wm_SpriteSpeedY,X
	LDA #$09
	STA wm_SoundCh3
	JSR SubHorzPosBnk3
	LDA DATA_03AB62,Y
	STA wm_SpriteSpeedX,X
	LDA #$20
	STA wm_ShakeGrndTimer
+	RTS

CODE_03AB9F:
	JSR _03A6AC
	LDA wm_SpriteYHi,X
	BMI +
	BNE ++
	LDA wm_SpriteYLo,X
	CMP #$10
	BCS ++
+	LDA #$05
	STA wm_SpriteMiscTbl3,X
	LDA #$60
	STA wm_SpriteDecTbl1,X
++	LDA #$F8
	STA wm_SpriteSpeedY,X
	RTS

CODE_03ABBE:
	JSR _03A6AC
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteDecTbl1,X
	BNE CODE_03ABEB
	LDA wm_M7Rotate
	CLC
	ADC #$0A
	STA wm_M7Rotate
	LDA wm_M7Rotate+1
	ADC #$00
	STA wm_M7Rotate+1
	BEQ +
	STZ wm_M7Rotate
	LDA #$20
	STA wm_SpriteDecTbl2,X
	LDA #$60
	STA wm_SpriteDecTbl1,X
	LDA #$06
	STA wm_SpriteMiscTbl3,X
+	RTS

CODE_03ABEB:
	CMP #$40
	BCC ++
	CMP #$5E
	BNE +
	LDY #$1B
	STY wm_MusicCh1
+	LDA wm_SpriteDecTbl4,X
	BNE ++
	LDA #$12
	STA wm_SpriteDecTbl4,X
++	RTS

CODE_03AC03:
	JSR _03A6AC
	LDA wm_SpriteDecTbl2,X
	CMP #$01
	BNE +
	LDA #$0B
	STA wm_MarioAnimation
	INC wm_BowserFinalScene
	STZ wm_LvBgColor
	STZ wm_LvBgColor+1
	LDA #$03
	STA wm_IsBehindScenery
	JSR CODE_03AC63
+	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$FA
	STA wm_SpriteSpeedX,X
	LDA #$FC
	STA wm_SpriteSpeedY,X
	LDA wm_M7Rotate
	CLC
	ADC #$05
	STA wm_M7Rotate
	LDA wm_M7Rotate+1
	ADC #$00
	STA wm_M7Rotate+1
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_M7Scale
	CMP #$80
	BCS CODE_03AC4D
	INC wm_M7Scale
	INC wm_M7Scale+1
+	RTS

CODE_03AC4D:
	LDA wm_SprInWaterTbl,X
	BNE +
	LDA #$1C
	STA wm_MusicCh1
	INC wm_SprInWaterTbl,X
+	LDA #$FE
	STA wm_SpriteXHi,X
	STA wm_SpriteYHi,X
	RTS

CODE_03AC63:
	LDA #$08
	STA wm_SpriteStatus.Spr9
	LDA #$7C
	STA wm_SpriteNum+8
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_SpriteXLo+8
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi.Spr9
	LDA wm_SpriteYLo,X
	CLC
	ADC #$47
	STA wm_SpriteYLo+8
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi.Spr9
	PHX
	LDX #$08
	JSL InitSpriteTables
	PLX
	RTS

BlushTileDispY:	.DB $01,$11

BlushTiles:	.DB $6E,$88

PrincessPeach:
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_FrameA
	AND #$7F
	BNE +
	JSL GetRand
	AND #$07
	BNE +
	LDA #$0C
	STA wm_SpriteDecTbl2,X
+	LDY wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl2,X
	BEQ +
	INY
+	LDA wm_SpriteDir,X
	BNE +
	TYA
	CLC
	ADC #$08
	TAY
+	STY m3
	LDA #$D0
	STA wm_SprOAMIndex,X
	TAY
	JSR _03AAC8
	LDY #$02
	LDA #$03
	JSL FinishOAMWrite
	LDA wm_SpriteDecTbl3,X
	BEQ ++
	PHX
	LDX #$00
	LDA wm_MarioPowerUp
	BNE +
	INX
+	LDY #$4C
	LDA wm_MarioScrPosX
	STA wm_OamSlot.1.XPos,Y
	LDA wm_MarioScrPosY
	CLC
	ADC.W BlushTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W BlushTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA wm_MarioDirection
	CMP #$01
	LDA #$31
	BCC +
	ORA #$40
+	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
++	STZ wm_SpriteSpeedX,X
	STZ wm_MarioSpeedX
	LDA #$04
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteState,X
	JSL ExecutePtr

PeachPtrs:
	.DW CODE_03AD37
	.DW CODE_03ADB3
	.DW CODE_03ADDD
	.DW CODE_03AE25
	.DW CODE_03AE32
	.DW CODE_03AEAF
	.DW CODE_03AEE8
	.DW CODE_03C796

CODE_03AD37:
	LDA #$06
	STA wm_SpriteGfxTbl,X
	JSL UpdateYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$08
	BCS +
	CLC
	ADC #$01
	STA wm_SpriteSpeedY,X
+	LDA wm_SpriteYHi,X
	BMI +
	LDA wm_SpriteYLo,X
	CMP #$A0
	BCC +
	LDA #$A0
	STA wm_SpriteYLo,X
	STZ wm_SpriteSpeedY,X
	LDA #$A0
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
+	LDA wm_FrameA
	AND #$07
	BNE +
	LDY #$0B
-	LDA wm_MExSprNum,Y
	BEQ CODE_03AD74
	DEY
	BPL -
+	RTS

CODE_03AD74:
	LDA #$05
	STA wm_MExSprNum,Y
	JSL GetRand
	STZ m0
	AND #$1F
	CLC
	ADC #$F8
	BPL +
	DEC m0
+	CLC
	ADC wm_SpriteXLo,X
	STA wm_MExSprXLo,Y
	LDA wm_SpriteXHi,X
	ADC m0
	STA wm_MExSprXHi,Y
	LDA wm_RandomByte2
	AND #$1F
	ADC wm_SpriteYLo,X
	STA wm_MExSprYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_MExSprYHi,Y
	LDA #$00
	STA wm_MExSprYSpeed,Y
	LDA #$17
	STA wm_MExSprTimer,Y
	RTS

CODE_03ADB3:
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
	JSR CODE_03ADCC
	BCC +
	INC wm_SpriteMiscTbl3,X
+	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	STA wm_MarioDirection
	RTS

CODE_03ADCC:
	JSL GetSpriteClippingA
	JSL GetMarioClipping
	JSL CheckForContact
	RTS

DATA_03ADD9:	.DB $08,$F8,$F8,$08

CODE_03ADDD:
	LDA wm_FrameB
	AND #$08
	BNE +
	LDA #$08
	STA wm_SpriteGfxTbl,X
+	JSR CODE_03ADCC
	PHP
	JSR SubHorzPosBnk3
	PLP
	LDA wm_SpriteMiscTbl3,X
	BNE ADDR_03ADF9
	BCS CODE_03AE14
	BRA _03ADFF

ADDR_03ADF9:
	BCC CODE_03AE14
	TYA
	EOR #$01
	TAY
_03ADFF:
	LDA DATA_03ADD9,Y
	STA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_MarioSpeedX
	TYA
	STA wm_SpriteDir,X
	STA wm_MarioDirection
	JSL UpdateXPosNoGrvty
	RTS

CODE_03AE14:
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	STA wm_MarioDirection
	INC wm_SpriteState,X
	LDA #$60
	STA wm_SpriteDecTbl1,X
	RTS

CODE_03AE25:
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
	LDA #$A0
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_03AE32:
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
	STZ wm_188A
	STZ wm_PlayerImgYPos
+	CMP #$50
	BCC ++
	PHA
	BNE +
	LDA #$14
	STA wm_SpriteDecTbl2,X
+	LDA #$0A
	STA wm_SpriteGfxTbl,X
	PLA
	CMP #$68
	BNE ++
	LDA #$80
	STA wm_SpriteDecTbl3,X
++	RTS

DATA_03AE5B:
	.DB $08,$08,$08,$08,$08,$08,$18,$08
	.DB $08,$08,$08,$08,$08,$08,$08,$08
	.DB $08,$08,$08,$08,$08,$08,$20,$08
	.DB $08,$08,$08,$08,$20,$08,$08,$10
	.DB $08,$08,$08,$08,$08,$08,$08,$08
	.DB $20,$08,$08,$08,$08,$08,$20,$08
	.DB $04,$20,$08,$08,$08,$08,$08,$08
	.DB $08,$08,$08,$08,$08,$08,$10,$08
	.DB $08,$08,$08,$08,$08,$08,$08,$08
	.DB $08,$08,$10,$08,$08,$08,$08,$08
	.DB $08,$08,$08,$40

CODE_03AEAF:
	JSR CODE_03D674
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDY wm_EndMsgLetter
	CPY #$54
	BEQ CODE_03AEC8
	INC wm_EndMsgLetter
	LDA DATA_03AE5B,Y
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_03AEC8:
	INC wm_SpriteState,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	RTS

CODE_03AED0:
	INC wm_SpriteState,X
	LDA #$80
	STA wm_DisSprCapeContact.Spr10
	RTS

UNK_03AED8: ; unused?
	.DB $00,$00,$94,$18,$18,$9C,$9C,$FF
	.DB $00,$00,$52,$63,$63,$73,$73,$7F

CODE_03AEE8:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_03AED0
	LSR
	STA m0
	STZ m1
	REP #$20
	LDA m0
	ASL
	ASL
	ASL
	ASL
	ASL
	ORA m0
	STA m0
	ASL
	ASL
	ASL
	ASL
	ASL
	ORA m0
	STA m0
	SEP #$20
	PHX
	TAX
	LDY wm_PalSprIndex
	LDA #$02
	STA wm_PalUplSize,Y
	LDA #$F1
	STA wm_PalColNum,Y
	LDA m0
	STA wm_PalColData,Y
	LDA m1
	STA wm_PalColData.1.ColH,Y
	LDA #$00
	STA wm_PalColData.2.ColL,Y
	TYA
	CLC
	ADC #$04
	STA wm_PalSprIndex
	PLX
	JSR CODE_03D674
	RTS

DATA_03AF34:	.DB $F4,$FF,$0C,$19,$24,$19,$0C,$FF

DATA_03AF3C:	.DB $FC,$F6,$F4,$F6,$FC,$02,$04,$02

DATA_03AF44:	.DB $05,$05,$05,$05,$45,$45,$45,$45

DATA_03AF4C:
	.DB $34,$34,$34,$35,$35,$36,$36,$37
	.DB $38,$3A,$3E,$46,$54

CODE_03AF59:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDir,X
	STA m4
	LDA wm_FrameB
	LSR
	LSR
	AND #$07
	STA m2
	LDA #$EC
	STA wm_SprOAMIndex,X
	TAY
	PHX
	LDX #$03
-	PHX
	TXA
	ASL
	ASL
	ADC m2
	AND #$07
	TAX
	LDA m0
	CLC
	ADC.W DATA_03AF34,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_03AF3C,X
	STA wm_OamSlot.1.YPos,Y
	LDA #$59
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_03AF44,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	LDA wm_BowserTearYPos
	INC wm_BowserTearYPos
	LSR
	LSR
	LSR
	CMP #$0D
	BCS +
	TAX
	LDY #$FC
	LDA m4
	ASL
	ROL
	ASL
	ASL
	ASL
	ADC m0
	CLC
	ADC #$15
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.L DATA_03AF4C,X
	STA wm_OamSlot.1.YPos,Y
	LDA #$49
	STA wm_OamSlot.1.Tile,Y
	LDA #$07
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
+	PLX
	LDY #$00
	LDA #$04
	JSL FinishOAMWrite
	LDY wm_SprOAMIndex,X
	PHX
	LDX #$04
-	LDA wm_OamSlot.1.XPos,Y
	STA wm_ExOamSlot.1.XPos,Y
	LDA wm_OamSlot.1.YPos,Y
	STA wm_ExOamSlot.1.YPos,Y
	LDA wm_OamSlot.1.Tile,Y
	STA wm_ExOamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	STA wm_ExOamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA wm_OamSize.1,Y
	STA wm_ExOamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	RTS

DATA_03B013:	.DB $00,$10

DATA_03B015:	.DB $00,$00

DATA_03B017:	.DB $F8,$08

CODE_03B019:
	STZ m2
	JSR _03B020
	INC m2
_03B020:
	LDY #$01
-	LDA wm_SpriteStatus,Y
	BEQ CODE_03B02B
	DEY
	BPL -
	RTS

CODE_03B02B:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$A2
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$10
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,Y
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	PHX
	LDX m2
	LDA m0
	CLC
	ADC.W DATA_03B013,X
	STA.W wm_SpriteXLo,Y
	LDA m1
	ADC.W DATA_03B015,X
	STA wm_SpriteXHi,Y
	TYX
	JSL InitSpriteTables
	LDY m2
	LDA DATA_03B017,Y
	STA wm_SpriteSpeedX,X
	LDA #$C0
	STA wm_SpriteSpeedY,X
	PLX
	RTS

DATA_03B074:	.DB $40,$C0

DATA_03B076:	.DB $10,$F0

CODE_03B078:
	LDA wm_M7Scale
	CMP #$20
	BNE _Return03B0DB
	LDA wm_SpriteMiscTbl3,X
	CMP #$07
	BCC _Return03B0F2
	LDA wm_M7Rotate
	ORA wm_M7Rotate+1
	BNE _Return03B0F2
	JSR CODE_03B0DC
	LDA wm_SpriteDecTbl2,X
	BNE _Return03B0DB
	LDA #$24
	STA wm_Tweaker1662,X
	JSL MarioSprInteract
	BCC _03B0BD
	JSR _03B0D6
	STZ wm_MarioSpeedY
	JSR SubHorzPosBnk3
	LDA wm_BowserMechTimer
	ORA wm_ChainSinY
	BEQ CODE_03B0B3
	LDA DATA_03B076,Y
	BRA _03B0B6

CODE_03B0B3:
	LDA DATA_03B074,Y
_03B0B6:
	STA wm_MarioSpeedX
	LDA #$01
	STA wm_SoundCh1
_03B0BD:
	INC wm_Tweaker1662,X
	JSL MarioSprInteract
	BCC +
	JSR _03B0D2
+	INC wm_Tweaker1662,X
	JSL MarioSprInteract
	BCC _Return03B0DB
_03B0D2:
	JSL HurtMario
_03B0D6:
	LDA #$20
	STA wm_SpriteDecTbl2,X
_Return03B0DB:
	RTS

CODE_03B0DC:
	LDY #$01
-	PHY
	LDA wm_SpriteStatus,Y
	CMP #$09
	BNE +
	LDA wm_OffscreenHorz,Y
	BNE +
	JSR CODE_03B0F3
+	PLY
	DEY
	BPL -
_Return03B0F2:
	RTS

CODE_03B0F3:
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	LDA #$24
	STA wm_Tweaker1662,X
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCS +
	INC wm_Tweaker1662,X
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC ++
	LDA wm_BowserHurtTimer
	BNE ++
	LDA #$4C
	STA wm_BowserHurtTimer
	STZ wm_BowserTearYPos
	LDA wm_SpriteMiscTbl3,X
	STA wm_ChainCosX
	LDA #$28
	STA wm_SoundCh3
	LDA wm_SpriteMiscTbl3,X
	CMP #$09
	BNE +
	LDA wm_SprStompImmuneTbl,X
	CMP #$01
	BNE +
	PHY
	JSL KillMostSprites
	PLY
+	LDA #$00
	STA.W wm_SpriteSpeedX,Y
	PHX
	LDX #$10
	LDA.W wm_SpriteSpeedY,Y
	BMI +
	LDX #$D0
+	TXA
	STA.W wm_SpriteSpeedY,Y
	LDA #$02
	STA wm_SpriteStatus,Y
	TYX
	JSL CODE_01AB6F
	PLX
++	RTS

BowserBallSpeed:	.DB $10,$F0

BowserBowlingBall:
	JSR BowserBallGfx
	LDA wm_SpritesLocked
	BNE _Return03B1D4
	JSR SubOffscreen0Bnk3
	JSL MarioSprInteract
	JSL UpdateXPosNoGrvty
	JSL UpdateYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL CODE_03B186
	CLC
	ADC #$03
	STA wm_SpriteSpeedY,X
	BRA _03B18A

CODE_03B186:
	LDA #$40
	STA wm_SpriteSpeedY,X
_03B18A:
	LDA wm_SpriteSpeedY,X
	BMI ++
	LDA wm_SpriteYHi,X
	BMI ++
	LDA wm_SpriteYLo,X
	CMP #$B0
	BCC ++
	LDA #$B0
	STA wm_SpriteYLo,X
	LDA wm_SpriteSpeedY,X
	CMP #$3E
	BCC +
	LDY #$25
	STY wm_SoundCh3
	LDY #$20
	STY wm_ShakeGrndTimer
+	CMP #$08
	BCC +
	LDA #$01
	STA wm_SoundCh1
+	JSR CODE_03B7F8
	LDA wm_SpriteSpeedX,X
	BNE ++
	JSR SubHorzPosBnk3
	LDA BowserBallSpeed,Y
	STA wm_SpriteSpeedX,X
++	LDA wm_SpriteSpeedX,X
	BEQ _Return03B1D4
	BMI +
	DEC wm_SpriteMiscTbl6,X
	DEC wm_SpriteMiscTbl6,X
+	INC wm_SpriteMiscTbl6,X
_Return03B1D4:
	RTS

BowserBallDispX:
	.DB $F0,$00,$10,$F0,$00,$10,$F0,$00
	.DB $10,$00,$00,$F8

BowserBallDispY:
	.DB $E2,$E2,$E2,$F2,$F2,$F2,$02,$02
	.DB $02,$02,$02,$EA

BowserBallTiles:
	.DB $45,$47,$45,$65,$66,$65,$45,$47
	.DB $45,$39,$38,$63

BowserBallGfxProp:
	.DB $0D,$0D,$4D,$0D,$0D,$4D,$8D,$8D
	.DB $CD,$0D,$0D,$0D

BowserBallTileSize:
	.DB $02,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$00,$00,$02

BowserBallDispX2:	.DB $04,$0D,$10,$0D,$04,$FB,$F8,$FB

BowserBallDispY2:	.DB $00,$FD,$F4,$EB,$E8,$EB,$F4,$FD

BowserBallGfx:
	LDA #$70
	STA wm_SprOAMIndex,X
	JSR GetDrawInfoBnk3
	PHX
	LDX #$0B
-	LDA m0
	CLC
	ADC.W BowserBallDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W BowserBallDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W BowserBallTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W BowserBallGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W BowserBallTileSize,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	BPL -
	PLX
	PHX
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	LSR
	AND #$07
	PHA
	TAX
	LDA wm_OamSlot.2.XPos,Y
	CLC
	ADC.W BowserBallDispX2,X
	STA wm_OamSlot.2.XPos,Y
	LDA wm_OamSlot.2.YPos,Y
	CLC
	ADC.W BowserBallDispY2,X
	STA wm_OamSlot.2.YPos,Y
	PLA
	CLC
	ADC #$02
	AND #$07
	TAX
	LDA wm_OamSlot.3.XPos,Y
	CLC
	ADC.W BowserBallDispX2,X
	STA wm_OamSlot.3.XPos,Y
	LDA wm_OamSlot.3.YPos,Y
	CLC
	ADC.W BowserBallDispY2,X
	STA wm_OamSlot.3.YPos,Y
	PLX
	LDA #$0B
	LDY #$FF
	JSL FinishOAMWrite
	RTS

MechakoopaSpeed:	.DB $08,$F8

MechaKoopa:
	JSL CODE_03B307
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	LDA wm_SpritesLocked
	BNE ++
	JSR SubOffscreen0Bnk3
	JSL SprSprMarioSprRts
	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteSpeedY,X
	LDY wm_SpriteDir,X
	LDA MechakoopaSpeed,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteState,X
	INC wm_SpriteState,X
	AND #$3F
	BNE +
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
+	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
+	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	AND #$0C
	LSR
	LSR
	STA wm_SpriteGfxTbl,X
++	RTS

CODE_03B307:
	PHB
	PHK
	PLB
	JSR MechaKoopaGfx
	PLB
	RTL

MechakoopaDispX:	.DB $F8,$08,$F8,$00,$08,$00,$10,$00

MechakoopaDispY:
	.DB $F8,$F8,$08,$00,$F9,$F9,$09,$00
	.DB $F8,$F8,$08,$00,$F9,$F9,$09,$00
	.DB $FD,$00,$05,$00,$00,$00,$08,$00

MechakoopaTiles:
	.DB $40,$42,$60,$51,$40,$42,$60,$0A
	.DB $40,$42,$60,$0C,$40,$42,$60,$0E
	.DB $00,$02,$10,$01,$00,$02,$10,$01

MechakoopaGfxProp:	.DB $00,$00,$00,$00,$40,$40,$40,$40

MechakoopaTileSize:	.DB $02,$00,$00,$02

MechakoopaPalette:	.DB $0B,$05

MechaKoopaGfx:
	LDA #$0B
	STA wm_SpritePal,X
	LDA wm_SpriteDecTbl1,X
	BEQ +++
	LDY #$05
	CMP #$05
	BCC +
	CMP #$FA
	BCC ++
+	LDY #$04
++	TYA
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	CMP #$30
	BCS +++
	AND #$01
	TAY
	LDA MechakoopaPalette,Y
	STA wm_SpritePal,X
+++	JSR GetDrawInfoBnk3
	LDA wm_SpritePal,X
	STA m4
	TYA
	CLC
	ADC #$0C
	TAY
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	STA m3
	LDA wm_SpriteDir,X
	ASL
	ASL
	EOR #$04
	STA m2
	PHX
	LDX #$03
-	PHX
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W MechakoopaTileSize,X
	STA wm_OamSize.1,Y
	PLY
	PLA
	PHA
	CLC
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W MechakoopaDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA.W MechakoopaGfxProp,X
	ORA m4
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLA
	PHA
	CLC
	ADC m3
	TAX
	LDA.W MechakoopaTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA m1
	CLC
	ADC.W MechakoopaDispY,X
	STA wm_OamSlot.1.YPos,Y
	PLX
	DEY
	DEY
	DEY
	DEY
	DEX
	BPL -
	PLX
	LDY #$FF
	LDA #$03
	JSL FinishOAMWrite
	JSR MechaKoopaKeyGfx
	RTS

MechaKeyDispX:	.DB $F9,$0F

MechaKeyGfxProp:	.DB $4D,$0D

MechaKeyTiles:	.DB $70,$71,$72,$71

MechaKoopaKeyGfx:
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$10
	STA wm_SprOAMIndex,X
	JSR GetDrawInfoBnk3
	PHX
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	AND #$03
	STA m2
	LDA wm_SpriteDir,X
	TAX
	LDA m0
	CLC
	ADC.W MechaKeyDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	SEC
	SBC #$00
	STA wm_OamSlot.1.YPos,Y
	LDA.W MechaKeyGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDX m2
	LDA.W MechaKeyTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDY #$00
	LDA #$00
	JSL FinishOAMWrite
	RTS

CODE_03B43C:
	JSR BowserItemBoxGfx
	JSR BowserSceneGfx
	RTS

BowserItemBoxPosX:	.DB $70,$80,$70,$80

BowserItemBoxPosY:	.DB $07,$07,$17,$17

BowserItemBoxProp:	.DB $37,$77,$B7,$F7

BowserItemBoxGfx:
	LDA wm_BowserFinalScene
	BEQ +
	STZ wm_ItemInBox
+	LDA wm_ItemInBox
	BEQ +
	PHX
	LDX #$03
	LDY #$04
-	LDA.W BowserItemBoxPosX,X
	STA wm_ExOamSlot.1.XPos,Y
	LDA.W BowserItemBoxPosY,X
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$43
	STA wm_ExOamSlot.1.Tile,Y
	LDA.W BowserItemBoxProp,X
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
	PLX
+	RTS

BowserRoofPosX:
	.DB $00,$30,$60,$90,$C0,$F0,$00,$30
	.DB $40,$50,$60,$90,$A0,$B0,$C0,$F0

BowserRoofPosY:
	.DB $B0,$B0,$B0,$B0,$B0,$B0,$D0,$D0
	.DB $D0,$D0,$D0,$D0,$D0,$D0,$D0,$D0

BowserSceneGfx:
	PHX
	LDY #$BC
	STZ m1
	LDA wm_BowserFinalScene
	STA m15
	CMP #$01
	LDX #$10
	BCC _f
	LDY #$90
	DEX
__	LDA #$C0
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	LDA m1
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA m1
	LDA #$08
	STA wm_OamSlot.1.Tile,Y
	LDA #$0D
	ORA wm_SpriteProp
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
	BPL _b
	LDX #$0F
	LDA m15
	BNE CODE_03B532
	LDY #$14
-	LDA.W BowserRoofPosX,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_ExOamSlot.1.XPos,Y
	LDA.W BowserRoofPosY,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$08
	CPX #$06
	BCS +
	LDA #$03
+	STA wm_ExOamSlot.1.Tile,Y
	LDA #$0D
	ORA wm_SpriteProp
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
	BRA _03B56A

CODE_03B532:
	LDY #$50
-	LDA.W BowserRoofPosX,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	LDA.W BowserRoofPosY,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	LDA #$08
	CPX #$06
	BCS +
	LDA #$03
+	STA wm_OamSlot.1.Tile,Y
	LDA #$0D
	ORA wm_SpriteProp
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
_03B56A:
	PLX
	RTS

SprClippingDispX:
	.DB $02,$02,$10,$14,$00,$00,$01,$08
	.DB $F8,$FE,$03,$06,$01,$00,$06,$02
	.DB $00,$E8,$FC,$FC,$04,$00,$FC,$02
	.DB $02,$02,$02,$02,$00,$02,$E0,$F0
	.DB $FC,$FC,$00,$F8,$F4,$F2,$00,$FC
	.DB $F2,$F0,$02,$00,$F8,$04,$02,$02
	.DB $08,$00,$00,$00,$FC,$03,$08,$00
	.DB $08,$04,$F8,$00

SprClippingWidth:
	.DB $0C,$0C,$10,$08,$30,$50,$0E,$28
	.DB $20,$14,$01,$03,$0D,$0F,$14,$24
	.DB $0F,$40,$08,$08,$18,$0F,$18,$0C
	.DB $0C,$0C,$0C,$0C,$0A,$1C,$30,$30
	.DB $08,$08,$10,$20,$38,$3C,$20,$18
	.DB $1C,$20,$0C,$10,$10,$08,$1C,$1C
	.DB $10,$30,$30,$40,$08,$12,$34,$0F
	.DB $20,$08,$20,$10

SprClippingDispY:
	.DB $03,$03,$FE,$08,$FE,$FE,$02,$08
	.DB $FE,$08,$07,$06,$FE,$FC,$06,$FE
	.DB $FE,$E8,$10,$10,$02,$FE,$F4,$08
	.DB $13,$23,$33,$43,$0A,$FD,$F8,$FC
	.DB $E8,$10,$00,$E8,$20,$04,$58,$FC
	.DB $E8,$FC,$F8,$02,$F8,$04,$FE,$FE
	.DB $F2,$FE,$FE,$FE,$FC,$00,$08,$F8
	.DB $10,$03,$10,$00

SprClippingHeight:
	.DB $0A,$15,$12,$08,$0E,$0E,$18,$30
	.DB $10,$1E,$02,$03,$16,$10,$14,$12
	.DB $20,$40,$34,$74,$0C,$0E,$18,$45
	.DB $3A,$2A,$1A,$0A,$30,$1B,$20,$12
	.DB $18,$18,$10,$20,$38,$14,$08,$18
	.DB $28,$1B,$13,$4C,$10,$04,$22,$20
	.DB $1C,$12,$12,$12,$08,$20,$2E,$14
	.DB $28,$0A,$10,$0D

MarioClipDispY:	.DB $06,$14,$10,$18

MarioClippingHeight:	.DB $1A,$0C,$20,$18

GetMarioClipping:
	PHX
	LDA wm_MarioXPos
	CLC
	ADC #$02
	STA m0
	LDA wm_MarioXPos+1
	ADC #$00
	STA m8
	LDA #$0C
	STA m2
	LDX #$00
	LDA wm_IsDucking
	BNE +
	LDA wm_MarioPowerUp
	BNE ++
+	INX
++	LDA wm_OnYoshi
	BEQ +
	INX
	INX
+	LDA.L MarioClippingHeight,X
	STA m3
	LDA wm_MarioYPos
	CLC
	ADC.L MarioClipDispY,X
	STA m1
	LDA wm_MarioYPos+1
	ADC #$00
	STA m9
	PLX
	RTL

GetSpriteClippingA:
	PHY
	PHX
	TXY
	LDA wm_Tweaker1662,X
	AND #$3F
	TAX
	STZ m15
	LDA.L SprClippingDispX,X
	BPL +
	DEC m15
+	CLC
	ADC.W wm_SpriteXLo,Y
	STA m4
	LDA wm_SpriteXHi,Y
	ADC m15
	STA m10
	LDA.L SprClippingWidth,X
	STA m6
	STZ m15
	LDA.L SprClippingDispY,X
	BPL +
	DEC m15
+	CLC
	ADC.W wm_SpriteYLo,Y
	STA m5
	LDA wm_SpriteYHi,Y
	ADC m15
	STA m11
	LDA.L SprClippingHeight,X
	STA m7
	PLX
	PLY
	RTL

GetSpriteClippingB:
	PHY
	PHX
	TXY
	LDA wm_Tweaker1662,X
	AND #$3F
	TAX
	STZ m15
	LDA.L SprClippingDispX,X
	BPL +
	DEC m15
+	CLC
	ADC.W wm_SpriteXLo,Y
	STA m0
	LDA wm_SpriteXHi,Y
	ADC m15
	STA m8
	LDA.L SprClippingWidth,X
	STA m2
	STZ m15
	LDA.L SprClippingDispY,X
	BPL +
	DEC m15
+	CLC
	ADC.W wm_SpriteYLo,Y
	STA m1
	LDA wm_SpriteYHi,Y
	ADC m15
	STA m9
	LDA.L SprClippingHeight,X
	STA m3
	PLX
	PLY
	RTL

CheckForContact:
	PHX
	LDX #$01
-	LDA m0,X
	SEC
	SBC m4,X
	PHA
	LDA m8,X
	SBC m10,X
	STA m12
	PLA
	CLC
	ADC #$80
	LDA m12
	ADC #$00
	BNE +
	LDA m4,X
	SEC
	SBC m0,X
	CLC
	ADC m6,X
	STA m15
	LDA m2,X
	CLC
	ADC m6,X
	CMP m15
	BCC +
	DEX
	BPL -
+	PLX
	RTL

DATA_03B75C:	.DB $0C,$1C

DATA_03B75E:	.DB $01,$02

GetDrawInfoBnk3:
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
	BNE CODE_03B7CF
	LDY #$00
	LDA wm_Tweaker1662,X
	AND #$20
	BEQ _f
	INY
__	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_03B75C,Y
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
	ORA DATA_03B75E,Y
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

CODE_03B7CF:
	PLA
	PLA
	RTS

DATA_03B7D2:
	.DB $00,$00,$00,$F8,$F8,$F8,$F8,$F8
	.DB $F8,$F7,$F6,$F5,$F4,$F3,$F2,$E8
	.DB $E8,$E8,$E8,$00,$00,$00,$00,$FE
	.DB $FC,$F8,$EC,$EC,$EC,$E8,$E4,$E0
	.DB $DC,$D8,$D4,$D0,$CC,$C8

CODE_03B7F8:
	LDA wm_SpriteSpeedY,X
	PHA
	STZ wm_SpriteSpeedY,X
	PLA
	LSR
	LSR
	TAY
	LDA wm_SpriteNum,X
	CMP #$A1
	BNE +
	TYA
	CLC
	ADC #$13
	TAY
+	LDA DATA_03B7D2,Y
	LDY wm_SprObjStatus,X
	BMI +
	STA wm_SpriteSpeedY,X
+	RTS

SubHorzPosBnk3:
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

SubVertPosBnk3:
	LDY #$00
	LDA wm_MarioYPos
	SEC
	SBC wm_SpriteYLo,X
	STA m15
	LDA wm_MarioYPos+1
	SBC wm_SpriteYHi,X
	BPL +
	INY
+	RTS

DATA_03B83B:	.DB $40,$B0

DATA_03B83D:	.DB $01,$FF

DATA_03B83F:	.DB $30,$C0,$A0,$80,$A0,$40,$60,$B0

DATA_03B847:	.DB $01,$FF,$01,$FF,$01,$00,$01,$FF

SubOffscreen3Bnk3:
	LDA #$06
	BRA _03B859

UNK_SubOffscreen2Bnk3: ; unreachable
	LDA #$04
	BRA _03B859

UNK_SubOffscreen1Bnk3: ; unreachable
	LDA #$02
_03B859:
	STA m3
	BRA _03B85F

SubOffscreen0Bnk3:
	STZ m3
_03B85F:
	JSR IsSprOffScreenBnk3
	BEQ _Return03B8C2
	LDA wm_IsVerticalLvl
	AND #$01
	BNE VerticalLevelBnk3
	LDA wm_SpriteYLo,X
	CLC
	ADC #$50
	LDA wm_SpriteYHi,X
	ADC #$00
	CMP #$02
	BPL _OffScrEraseSprBnk3
	LDA wm_Tweaker167A,X
	AND #$04
	BNE _Return03B8C2
	LDA wm_FrameA
	AND #$01
	ORA m3
	STA m1
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_03B83F,Y
	ROL m0
	CMP wm_SpriteXLo,X
	PHP
	LDA wm_Bg1HOfs+1
	LSR m0
	ADC DATA_03B847,Y
	PLP
	SBC wm_SpriteXHi,X
	STA m0
	LSR m1
	BCC +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return03B8C2
_OffScrEraseSprBnk3:
	LDA wm_SpriteStatus,X
	CMP #$08
	BCC +
	LDY wm_SprIndexInLvl,X
	CPY #$FF
	BEQ +
	LDA #$00
	STA wm_SprLoadStatus,Y
+	STZ wm_SpriteStatus,X
_Return03B8C2:
	RTS

VerticalLevelBnk3:
	LDA wm_Tweaker167A,X
	AND #$04
	BNE _Return03B8C2
	LDA wm_FrameA
	LSR
	BCS _Return03B8C2
	AND #$01
	STA m1
	TAY
	LDA wm_Bg1VOfs
	CLC
	ADC DATA_03B83B,Y
	ROL m0
	CMP wm_SpriteYLo,X
	PHP
	LDA.W wm_Bg1VOfs+1
	LSR m0
	ADC DATA_03B83D,Y
	PLP
	SBC wm_SpriteYHi,X
	STA m0
	LDY m1
	BEQ +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return03B8C2
	BMI _OffScrEraseSprBnk3 ; [BRA FIX]

IsSprOffScreenBnk3:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	RTS

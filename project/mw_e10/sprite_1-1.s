InitFlyingBlock:
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	AND #$03
	STA wm_SpriteMiscTbl3,X
	INC wm_SpriteDir,X
	RTS

DATA_01AD68:	.DB -1,1

DATA_01AD6A:	.DB -12,12

DATA_01AD6C:	.DB -16,16

FlyingBlock:
	LDA wm_SpriteDecTbl6,X
	BEQ +
	STZ wm_SprOAMIndex,X
	LDA wm_OnYoshi
	BNE +
	LDA #$04
	STA wm_SprOAMIndex,X
+	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.YPos,Y
	DEC A
	STA wm_OamSlot.1.YPos,Y
	STZ wm_SpriteMiscTbl4,X
	LDA wm_SpriteState,X
	BNE _01ADF8
	JSR CODE_019E95
	LDA wm_SpritesLocked
	BNE _01ADF8
	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpriteMiscTbl7,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_01AD68,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_01AD6A,Y
	BNE +
	INC wm_SpriteMiscTbl7,X
+	JSR SubSprYPosNoGrvty
	LDA wm_SpriteNum,X
	CMP #$83
	BEQ CODE_01ADE8
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_SpriteMiscTbl5,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_01AD68,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_01AD6C,Y
	BNE +
	INC wm_SpriteMiscTbl5,X
	LDA #$20
	STA wm_SpriteDecTbl1,X
+	BRA _01ADEC

CODE_01ADE8:
	LDA #$F4
	STA wm_SpriteSpeedX,X
_01ADEC:
	JSR SubSprXPosNoGrvty
	LDA wm_SprPixelMove
	STA wm_SpriteMiscTbl4,X
	INC wm_SpriteMiscTbl6,X
_01ADF8:
	JSR SubSprSprInteract
	JSR CODE_01B457
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteDecTbl3,X
	CMP #$08
	BNE ++
	LDY wm_SpriteState,X
	CPY #$02
	BEQ ++
	PHA
	INC wm_SpriteState,X
	LDA #$50
	STA wm_SpriteDecTbl6,X
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	LDA #$FF
	STA wm_SprIndexInLvl,X
	LDY wm_SpriteMiscTbl3,X
	LDA wm_MarioPowerUp
	BNE +
	INY
	INY
	INY
	INY
+	LDA DATA_01AE88,Y
	STA m5
	PHB
	LDA #:_02887D
	PHA
	PLB
	PHX
	JSL _02887D
	PLX
	LDY wm_TempTileGen
	LDA #$01
	STA wm_SpriteMiscTbl4,Y
	LDA.W wm_SpriteNum,Y
	CMP #$75
	BNE +
	LDA #$FF
	STA.W wm_SpriteState,Y
+	PLB
	PLA
++	LSR
	TAY
	LDA DATA_01AE7F,Y
	STA m0
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC m0
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SpriteState,X
	CMP #$01
	LDA #$2A
	BCC +
	LDA #$2E
+	STA wm_OamSlot.1.Tile,Y
	RTS

DATA_01AE7F:
	.DB $00,$03,$05,$07,$08,$08,$07,$05
	.DB $03

DATA_01AE88:	.DB $06,$02,$04,$05,$06,$01,$01,$05

Return01AE90:
	RTS

PalaceSwitch:
	JSL CODE_02CD2D
	RTS

InitThwomp:
	LDA wm_SpriteYLo,X
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_SpriteXLo,X
_Return01AEA2:
	RTS

Thwomp:
	JSR ThwompGfx
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _Return01AEA2
	LDA wm_SpritesLocked
	BNE _Return01AEA2
	JSR SubOffscreen0Bnk1
	JSR MarioSprInteractRt
	LDA wm_SpriteState,X
	JSL ExecutePtr

ThwompStatePtrs:
	.DW CODE_01AEC3
	.DW CODE_01AEFA
	.DW CODE_01AF24

CODE_01AEC3:
	LDA wm_OffscreenVert,X
	BNE ++
	LDA wm_OffscreenHorz,X
	BNE +++
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
	STZ wm_SpriteMiscTbl4,X
	LDA m15
	CLC
	ADC #$40
	CMP #$80
	BCS +
	LDA #$01
	STA wm_SpriteMiscTbl4,X
+	LDA m15
	CLC
	ADC #$24
	CMP #$50
	BCS +++
++	LDA #$02
	STA wm_SpriteMiscTbl4,X
	INC wm_SpriteState,X
	LDA #$00
	STA wm_SpriteSpeedY,X
+++	RTS

CODE_01AEFA:
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$3E
	BCS +
	ADC #$04
	STA wm_SpriteSpeedY,X
+	JSR CODE_019140
	JSR IsOnGround
	BEQ +
	JSR SetSomeYSpeed
	LDA #$18
	STA wm_ShakeGrndTimer
	LDA #$09
	STA wm_SoundCh3
	LDA #$40
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
+	RTS

CODE_01AF24:
	LDA wm_SpriteDecTbl1,X
	BNE _Return01AF3F
	STZ wm_SpriteMiscTbl4,X
	LDA wm_SpriteYLo,X
	CMP wm_SpriteMiscTbl3,X
	BNE CODE_01AF38
	LDA #$00
	STA wm_SpriteState,X
	RTS

CODE_01AF38:
	LDA #$F0
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
_Return01AF3F:
	RTS

ThwompDispX:	.DB -4,4,-4,4,0

ThwompDispY:	.DB 0,0,16,16,8

ThwompTiles:	.DB $8E,$8E,$AE,$AE,$C8

ThwompGfxProp:	.DB $03,$43,$03,$43,$03

ThwompGfx:
	JSR GetDrawInfoBnk1
	LDA wm_SpriteMiscTbl4,X
	STA m2
	PHX
	LDX #$03
	CMP #$00
	BEQ _f
	INX
__	LDA m0
	CLC
	ADC.W ThwompDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W ThwompDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W ThwompGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA.W ThwompTiles,X
	CPX #$04
	BNE ++
	PHX
	LDX m2
	CPX #$02
	BNE +
	LDA #$CA
+	PLX
++	STA wm_OamSlot.1.Tile,Y
	INY
	INY
	INY
	INY
	DEX
	BPL _b
	PLX
	LDA #$04
	JMP _01B37E

Thwimp:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _01B006
	LDA wm_SpritesLocked
	BNE _01B006
	JSR SubOffscreen0Bnk1
	JSR MarioSprInteractRt
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	JSR CODE_019140
	LDA wm_SpriteSpeedY,X
	BMI +
	CMP #$40
	BCS CODE_01AFC8
	ADC #$05
+	CLC
	ADC #$03
	BRA _01AFCA

CODE_01AFC8:
	LDA #$40
_01AFCA:
	STA wm_SpriteSpeedY,X
	JSR IsTouchingCeiling
	BEQ +
	LDA #$10
	STA wm_SpriteSpeedY,X
+	JSR IsOnGround
	BEQ _01B006
	JSR SetSomeYSpeed
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01AFFC
	DEC A
	BNE _01B006
	LDA #$A0
	STA wm_SpriteSpeedY,X
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	LSR
	LDA #$10
	BCC +
	LDA #$F0
+	STA wm_SpriteSpeedX,X
	BRA _01B006

CODE_01AFFC:
	LDA #$01
	STA wm_SoundCh1
	LDA #$40
	STA wm_SpriteDecTbl1,X
_01B006:
	LDA #$01
	JMP SubSprGfx0Entry0

InitVerticalFish:
	JSR _FaceMario
	INC wm_SpriteMiscTbl3,X
_Return01B011:
	RTS

DATA_01B012:	.DB 16,-16

InitFish:
	JSR SubHorizPos
	LDA DATA_01B012,Y
	STA wm_SpriteSpeedX,X
	RTS

DATA_01B01D:	.DB 8,-8

DATA_01B01F:	.DB 0,0,8,-8

DATA_01B023:	.DB -16,16

DATA_01B025:	.DB -32,-24,-48,-40

DATA_01B029:	.DB 8,-8,16,-16,4,-4,20,-20

DATA_01B031:	.DB 3,12

Fish:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE +
	LDA wm_SpritesLocked
	BEQ CODE_01B041
+	JMP _01B10A

CODE_01B041:
	JSR SetAnimationFrame
	LDA wm_SprInWaterTbl,X
	BNE CODE_01B0A7
	JSR SubUpdateSprPos
	JSR IsTouchingObjSide
	BEQ +
	JSR FlipSpriteDir
+	JSR IsOnGround
	BEQ ++
	LDA wm_SpriteBuoyancy
	BEQ +
	JSL CODE_0284BC
+	JSL GetRand
	ADC wm_FrameA
	AND #$07
	TAY
	LDA DATA_01B029,Y
	STA wm_SpriteSpeedX,X
	JSL GetRand
	LDA wm_RandomByte2
	AND #$03
	TAY
	LDA DATA_01B025,Y
	STA wm_SpriteSpeedY,X
	LDA wm_RandomByte1
	AND #$40
	BNE +
	LDA wm_SpritePal,X
	EOR #$80
	STA wm_SpritePal,X
+	JSL GetRand
	LDA wm_RandomByte1
	AND #$80
	BNE ++
	JSR UpdateDirection
++	LDA wm_SpriteGfxTbl,X
	CLC
	ADC #$02
	STA wm_SpriteGfxTbl,X
	BRA _01B0EA

CODE_01B0A7:
	JSR CODE_019140
	JSR UpdateDirection
	ASL wm_SpritePal,X
	LSR wm_SpritePal,X
	LDA wm_SprObjStatus,X
	LDY wm_SpriteMiscTbl3,X
	AND DATA_01B031,Y
	BNE +
	LDA wm_SpriteDecTbl1,X
	BNE ++
+	LDA #$80
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
++	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteMiscTbl3,X
	BEQ +
	INY
	INY
+	LDA DATA_01B01D,Y
	STA wm_SpriteSpeedX,X
	LDA DATA_01B01F,Y
	STA wm_SpriteSpeedY,X
	JSR SubSprXPosNoGrvty
	AND #$0C
	BNE _01B0EA
	JSR SubSprYPosNoGrvty
_01B0EA:
	JSR SubSprSprInteract
	JSR MarioSprInteractRt
	BCC _01B10A
	LDA wm_SprInWaterTbl,X
	BEQ CODE_01B107
	LDA wm_StarPowerTimer
	BNE CODE_01B107
	LDA wm_OnYoshi
	BNE _01B10A
	JSL HurtMario
	BRA _01B10A

CODE_01B107:
	JSR CODE_01B12A
_01B10A:
	LDA wm_SpriteGfxTbl,X
	LSR
	EOR #$01
	STA m0
	LDA wm_SpritePal,X
	AND #$FE
	ORA m0
	STA wm_SpritePal,X
	JSR SubSprGfx2Entry1
	JSR SubOffscreen0Bnk1
	LSR wm_SpritePal,X
	SEC
	ROL wm_SpritePal,X
	RTS

CODE_01B12A:
	LDA #$10
	STA wm_KickImgTimer
	LDA #$03
	STA wm_SoundCh1
	JSR SubHorizPos
	LDA DATA_01B023,Y
	STA wm_SpriteSpeedX,X
	LDA #$E0
	STA wm_SpriteSpeedY,X
	LDA #$02
	STA wm_SpriteStatus,X
	STY wm_MarioDirection
	LDA #$01
	JSL GivePoints
	RTS

CODE_01B14E:
	LDA wm_FrameA
	AND #$03
_01B152:
	ORA wm_OffscreenVert,X
	ORA wm_SpritesLocked
	BNE ++
	JSL GetRand
	AND #$0F
	CLC
	LDY #$00
	ADC #$FC
	BPL +
	DEY
+	CLC
	ADC wm_SpriteXLo,X
	STA m2
	TYA
	ADC wm_SpriteXHi,X
	PHA
	LDA m2
	CMP wm_Bg1HOfs
	PLA
	SBC wm_Bg1HOfs+1
	BNE ++
	LDA wm_RandomByte2
	AND #$0F
	CLC
	ADC #$FE
	ADC wm_SpriteYLo,X
	STA m0
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m1
	JSL _0285BA
++	RTS

GeneratedFish:
	JSR _01B209
	LDA wm_SpritesLocked
	BNE ++
	JSR SetAnimationFrame
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	JSR CODE_019140
	LDA wm_SpriteSpeedY,X
	CMP #$20
	BPL +
	CLC
	ADC #$01
+	STA wm_SpriteSpeedY,X
++	RTS

DATA_01B1B1:	.DB -48,-48,-80

JumpingFish:
	LDA wm_SpritesLocked
	BNE _01B209
	LDA wm_SprInWaterTbl,X
	STA wm_SpriteMiscTbl3,X
	JSR SubUpdateSprPos
	LDA wm_SprInWaterTbl,X
	BEQ CODE_01B1EA
	LDA wm_SpriteState,X
	CMP #$03
	BEQ CODE_01B1DE
	INC wm_SpriteState,X
	TAY
	LDA DATA_01B1B1,Y
	STA wm_SpriteSpeedY,X
	LDA #$10
	STA wm_SpriteDecTbl1,X
	STZ wm_SprInWaterTbl,X
	BRA _01B206

CODE_01B1DE:
	DEC wm_SpriteSpeedY,X
	LDA wm_FrameA
	AND #$03
	BNE +
	DEC wm_SpriteSpeedY,X
+	BRA _01B206

CODE_01B1EA:
	INC wm_SpriteMiscTbl6,X
	INC wm_SpriteMiscTbl6,X
	CMP wm_SpriteMiscTbl3,X
	BEQ _01B206
	LDA #$10
	STA wm_SpriteDecTbl1,X
	LDA wm_SpriteState,X
	CMP #$03
	BNE _01B206
	STZ wm_SpriteState,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
_01B206:
	JSR SetAnimationFrame
_01B209:
	JSR _SubSprSprMarioSpr
	JSR UpdateDirection
	JMP _01B10A

DATA_01B212:	.DB 8,-8,16,-16

InitFloatSpkBall:
	JSR _FaceMario
	LDY wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	AND #$10
	BEQ +
	INY
	INY
+	LDA DATA_01B212,Y
	STA wm_SpriteSpeedX,X
	BRA InitFloatingPlat

InitFallingPlat:
	INC wm_SpriteGfxTbl,X
_InitOrangePlat:
	LDA wm_SpriteBuoyancy
	BNE InitFloatingPlat
	INC wm_SpriteState,X
	RTS

InitFloatingPlat:
	LDA #$03
	STA wm_SpriteMiscTbl3,X
-	JSR CODE_019140
	LDA wm_SprInWaterTbl,X
	BNE Return01B25D
	DEC wm_SpriteMiscTbl3,X
	BMI CODE_01B262
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,X
	CMP #$02
	BCS Return01B25D
	BRA -

Return01B25D:
	RTS

InitChckbrdPlat:
	INC wm_SpriteGfxTbl,X
	RTS

CODE_01B262:
	LDA #$01
	STA wm_SpriteStatus,X
_Return01B267:
	RTS

DATA_01B268:	.DB -1,1

DATA_01B26A:	.DB -16,16

Platforms:
	JSR CODE_01B2D1
	LDA wm_SpritesLocked
	BNE _Return01B2C2
	LDA wm_SpriteDecTbl1,X
	BNE ++
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	AND #$03
	BNE ++
	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_01B268,Y
	STA wm_SpriteSpeedY,X
	STA wm_SpriteSpeedX,X
	CMP DATA_01B26A,Y
	BNE ++
	INC wm_SpriteMiscTbl3,X
	LDA #$18
	LDY wm_SpriteNum,X
	CPY #$55
	BNE +
	LDA #$08
+	STA wm_SpriteDecTbl1,X
++	LDA wm_SpriteNum,X
	CMP #$57
	BCS CODE_01B2B0
	JSR SubSprXPosNoGrvty
	BRA _01B2B6

CODE_01B2B0:
	JSR SubSprYPosNoGrvty
	STZ wm_SprPixelMove
_01B2B6:
	LDA wm_SprPixelMove
	STA wm_SpriteMiscTbl4,X
	JSR CODE_01B457
	JSR SubOffscreen1Bnk1
_Return01B2C2:
	RTS

DATA_01B2C3:
	.DB $00,$01,$00,$01,$00,$00,$00,$00
	.DB $01,$01,$00,$00,$00,$00

CODE_01B2D1:
	LDA wm_SpriteNum,X
	SEC
	SBC #$55
	TAY
	LDA DATA_01B2C3,Y
	BEQ CODE_01B2DF
	JMP CODE_01B395

CODE_01B2DF:
	JSR GetDrawInfoBnk1
	LDA wm_SpriteGfxTbl,X
	STA m1
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	STA wm_OamSlot.3.YPos,Y
	LDX m1
	BEQ +
	STA wm_OamSlot.4.YPos,Y
	STA wm_OamSlot.5.YPos,Y
+	LDX wm_SprProcessIndex
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.XPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.3.XPos,Y
	LDX m1
	BEQ +
	CLC
	ADC #$10
	STA wm_OamSlot.4.XPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.5.XPos,Y
+	LDX wm_SprProcessIndex
	LDA m1
	BEQ CODE_01B344
	LDA #$EA
	STA wm_OamSlot.1.Tile,Y
	LDA #$EB
	STA wm_OamSlot.2.Tile,Y
	STA wm_OamSlot.3.Tile,Y
	STA wm_OamSlot.4.Tile,Y
	LDA #$EC
	STA wm_OamSlot.5.Tile,Y
	BRA _01B359

CODE_01B344:
	LDA #$60
	STA wm_OamSlot.1.Tile,Y
	LDA #$61
	STA wm_OamSlot.2.Tile,Y
	STA wm_OamSlot.3.Tile,Y
	STA wm_OamSlot.4.Tile,Y
	LDA #$62
	STA wm_OamSlot.5.Tile,Y
_01B359:
	LDA wm_SpriteProp
	ORA wm_SpritePal,X
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	STA wm_OamSlot.4.Prop,Y
	STA wm_OamSlot.5.Prop,Y
	LDA m1
	BNE +
	LDA #$62
	STA wm_OamSlot.3.Tile,Y
+	LDA #$04
	LDY m1
	BNE _01B37E
	LDA #$02
_01B37E:
	LDY #$02
	JMP FinishOAMWriteRt

DiagPlatTiles:
	.DB $CB,$E4,$CC,$E5,$CC,$E5,$CC,$E4
	.DB $CB

UNK_FlyRockPlatTiles:
	.DB $85,$88,$86,$89,$86,$89,$86,$88
	.DB $85

CODE_01B395:
	JSR GetDrawInfoBnk1
	PHY
	LDY #$00
	LDA wm_SpriteNum,X
	CMP #$5E
	BNE +
	INY
+	STY m0
	PLY
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.3.YPos,Y
	STA wm_OamSlot.5.YPos,Y
	LDX m0
	BEQ +
	STA wm_OamSlot.7.YPos,Y
	STA wm_OamSlot.9.YPos,Y
+	CLC
	ADC #$10
	STA wm_OamSlot.2.YPos,Y
	STA wm_OamSlot.4.YPos,Y
	LDX m0
	BEQ +
	STA wm_OamSlot.6.YPos,Y
	STA wm_OamSlot.8.YPos,Y
+	LDA #$08
	LDX m0
	BNE +
	LDA #$04
+	STA m1
	DEC A
	STA m2
	LDX wm_SprProcessIndex
	LDA wm_SpritePal,X
	STA m3
	LDA wm_SpriteNum,X
	CMP #$5B
	LDA #$00
	BCS +
	LDA #$09
+	PHA
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	PLX
-	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$08
	PHA
	LDA.W DiagPlatTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA m3
	PHX
	LDX m1
	CPX m2
	PLX
	BCS +
	ORA #$40
+	STA wm_OamSlot.1.Prop,Y
	PLA
	INY
	INY
	INY
	INY
	INX
	DEC m1
	BPL -
	LDX wm_SprProcessIndex
	LDY wm_SprOAMIndex,X
	LDA m0
	BNE _01B444
	LDA wm_SpriteNum,X
	CMP #$5B
	BCS CODE_01B43A
	LDA #$85
	STA wm_OamSlot.5.Tile,Y
	LDA #$88
	STA wm_OamSlot.4.Tile,Y
	BRA _01B444

CODE_01B43A:
	LDA #$CB
	STA wm_OamSlot.5.Tile,Y
	LDA #$E4
	STA wm_OamSlot.4.Tile,Y
_01B444:
	LDA #$08
	LDY m0
	BNE +
	LDA #$04
+	JMP _01B37E

InvisBlkMainRt:
	PHB
	PHK
	PLB
	JSR CODE_01B457
	PLB
	RTL

CODE_01B457:
	JSR ProcessInteract
	BCC CODE_01B4B2
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m0
	LDA wm_MarioScrPosY
	CLC
	ADC #$18
	CMP m0
	BPL CODE_01B4B4
	LDA wm_MarioSpeedY
	BMI CODE_01B4B2
	LDA wm_MarioObjStatus
	AND #$08
	BNE CODE_01B4B2
	LDA #$10
	STA wm_MarioSpeedY
	LDA #$01
	STA wm_IsOnSolidSpr
	LDA #$1F
	LDY wm_OnYoshi
	BEQ +
	LDA #$2F
+	STA m1
	LDA wm_SpriteYLo,X
	SEC
	SBC m1
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_MarioYPos+1
	LDA wm_MarioObjStatus
	AND #$03
	BNE ++
	LDY #$00
	LDA wm_SpriteMiscTbl4,X
	BPL +
	DEY
+	CLC
	ADC wm_MarioXPos
	STA wm_MarioXPos
	TYA
	ADC wm_MarioXPos+1
	STA wm_MarioXPos+1
++	SEC
	RTS

CODE_01B4B2:
	CLC
	RTS

CODE_01B4B4:
	LDA wm_Tweaker190F,X
	LSR
	BCS CODE_01B4B2
	LDA #$00
	LDY wm_IsDucking
	BNE +
	LDY wm_MarioPowerUp
	BNE ++
+	LDA #$08
++	LDY wm_OnYoshi
	BEQ +
	ADC #$08
+	CLC
	ADC wm_MarioScrPosY
	CMP m0
	BCC CODE_01B505
	LDA wm_MarioSpeedY
	BPL ++
	LDA #$10
	STA wm_MarioSpeedY
	LDA wm_SpriteNum,X
	CMP #$83
	BCC +
_01B4E2:
	LDA #$0F
	STA wm_SpriteDecTbl4,X
	LDA wm_SpriteState,X
	BNE +
	INC wm_SpriteState,X
	LDA #$10
	STA wm_SpriteDecTbl3,X
+	LDA #$01
	STA wm_SoundCh1
++	CLC
	RTS

DATA_01B4F9:	.DB 14,-15,16,-32,31,-15

DATA_01B4FF:	.DB 0,-1,0,-1,0,-1

CODE_01B505:
	JSR SubHorizPos
	LDA wm_SpriteNum,X
	CMP #$A9
	BEQ ++
	CMP #$9C
	BEQ +
	CMP #$BB
	BEQ +
	CMP #$60
	BEQ +
	CMP #$49
	BNE +++
+	INY
	INY
++	INY
	INY
+++	LDA DATA_01B4F9,Y
	CLC
	ADC wm_SpriteXLo,X
	STA wm_MarioXPos
	LDA DATA_01B4FF,Y
	ADC wm_SpriteXHi,X
	STA wm_MarioXPos+1
	STZ wm_MarioSpeedX
	CLC
	RTS

OrangePlatform:
	LDA wm_SpriteState,X
	BEQ Platforms2
	JSR CODE_01B2D1
	LDA wm_SpritesLocked
	BNE +
	JSR SubSprXPosNoGrvty
	LDA wm_SprPixelMove
	STA wm_SpriteMiscTbl4,X
	JSR CODE_01B457
	BCC +
	LDA #$01
	STA wm_BGScrollFlag
	LDA #$08
	STA wm_SpriteSpeedX,X
+	RTS

FloatingSpikeBall:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ Platforms2
	JMP CODE_01B666

Platforms2:
	LDA wm_SpritesLocked
	BEQ CODE_01B56A
	JMP _01B64E

CODE_01B56A:
	LDA wm_SprObjStatus,X
	AND #$0C
	BNE +
	JSR SubSprYPosNoGrvty
+	STZ wm_SprPixelMove
	LDA wm_SpriteNum,X
	CMP #$A4
	BNE +
	JSR SubSprXPosNoGrvty
+	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	INC wm_SpriteSpeedY,X
+	LDA wm_SprInWaterTbl,X
	BEQ ++
	LDY #$F8
	LDA wm_SpriteNum,X
	CMP #$5D
	BCC +
	LDY #$FC
+	STY m0
	LDA wm_SpriteSpeedY,X
	BPL +
	CMP m0
	BCC ++
+	SEC
	SBC #$02
	STA wm_SpriteSpeedY,X
++	LDA wm_MarioSpeedY
	PHA
	LDA wm_SpriteNum,X
	CMP #$A4
	BNE CODE_01B5B5
	JSR MarioSprInteractRt
	CLC
	BRA _01B5B8

CODE_01B5B5:
	JSR CODE_01B457
_01B5B8:
	PLA
	STA m0
	STZ wm_TempTileGen
	BCC +++
	LDA wm_SpriteNum,X
	CMP #$5D
	BCC ++
	LDY #$03
	LDA wm_MarioPowerUp
	BNE +
	DEY
+	STY m0
	LDA wm_SpriteSpeedY,X
	CMP m0
	BPL ++
	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
++	INC wm_TempTileGen
	LDA m0
	CMP #$20
	BCC +++
	LSR
	LSR
	STA wm_SpriteSpeedY,X
+++	LDA wm_TempTileGen
	CMP wm_SpriteMiscTbl3,X
	STA wm_SpriteMiscTbl3,X
	BEQ ++
	LDA wm_TempTileGen
	BNE ++
	LDA wm_MarioSpeedY
	BPL ++
	LDY #$08
	LDA wm_MarioPowerUp
	BNE +
	LDY #$06
+	STY m0
	LDA wm_SpriteSpeedY,X
	CMP #$20
	BPL ++
	CLC
	ADC m0
	STA wm_SpriteSpeedY,X
++	LDA #$01
	AND wm_FrameA
	BNE _01B64E
	LDA wm_SpriteSpeedY,X
	BEQ ++
	BPL +
	CLC
	ADC #$02
+	SEC
	SBC #$01
	STA wm_SpriteSpeedY,X
++	LDY wm_TempTileGen
	BEQ +
	LDY #$05
	LDA wm_MarioPowerUp
	BNE +
	LDY #$02
+	STY m0
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC m0
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	JSR CODE_019140
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
_01B64E:
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteNum,X
	CMP #$A4
	BEQ CODE_01B666
	JMP CODE_01B2D1

DATA_01B65A:	.DB -8,8,-8,8

DATA_01B65E:	.DB -8,-8,8,8

FloatMineGfxProp:	.DB $31,$71,$A1,$F1

CODE_01B666:
	JSR GetDrawInfoBnk1
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_01B65A,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_01B65E,X
	STA wm_OamSlot.1.YPos,Y
	LDA wm_FrameB
	LSR
	LSR
	AND #$04
	LSR
	ADC #$AA
	STA wm_OamSlot.1.Tile,Y
	LDA.W FloatMineGfxProp,X
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
	JMP FinishOAMWriteRt

BlkBridgeLength:	.DB 32,0

TurnBlkBridgeSpeed:	.DB 1,-1

BlkBridgeTiming:	.DB 64,64

TurnBlockBridge:
	JSR SubOffscreen0Bnk1
	JSR CODE_01B710
	JSR CODE_01B852
	JSR CODE_01B6B2
	RTS

CODE_01B6B2:
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteMiscTbl3,X
	CMP BlkBridgeLength,Y
	BEQ CODE_01B6D1
	LDA wm_SpriteDecTbl1,X
	ORA wm_SpritesLocked
	BNE +
	LDA wm_SpriteMiscTbl3,X
	CLC
	ADC TurnBlkBridgeSpeed,Y
	STA wm_SpriteMiscTbl3,X
+	RTS

CODE_01B6D1:
	LDA BlkBridgeTiming,Y
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
	RTS

HorzTurnBlkBridge:
	JSR SubOffscreen0Bnk1
	JSR CODE_01B710
	JSR CODE_01B852
	JSR CODE_01B6E7
	RTS

CODE_01B6E7:
	LDY wm_SpriteState,X
	LDA wm_SpriteMiscTbl3,X
	CMP BlkBridgeLength,Y
	BEQ CODE_01B703
	LDA wm_SpriteDecTbl1,X
	ORA wm_SpritesLocked
	BNE +
	LDA wm_SpriteMiscTbl3,X
	CLC
	ADC TurnBlkBridgeSpeed,Y
	STA wm_SpriteMiscTbl3,X
+	RTS

CODE_01B703:
	LDA BlkBridgeTiming,Y
	STA wm_SpriteDecTbl1,X
	LDA wm_SpriteState,X
	EOR #$01
	STA wm_SpriteState,X
	RTS

CODE_01B710:
	JSR GetDrawInfoBnk1
	STZ m0
	STZ m1
	STZ m2
	STZ m3
	LDA wm_SpriteState,X
	AND #$02
	TAY
	LDA wm_SpriteMiscTbl3,X
	STA.W m0,Y
	LSR
	STA.W m1,Y
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.5.YPos,Y
	PHA
	PHA
	PHA
	SEC
	SBC m2
	STA wm_OamSlot.3.YPos,Y
	PLA
	SEC
	SBC m3
	STA wm_OamSlot.4.YPos,Y
	PLA
	CLC
	ADC m2
	STA wm_OamSlot.1.YPos,Y
	PLA
	CLC
	ADC m3
	STA wm_OamSlot.2.YPos,Y
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.5.XPos,Y
	PHA
	PHA
	PHA
	SEC
	SBC m0
	STA wm_OamSlot.3.XPos,Y
	PLA
	SEC
	SBC m1
	STA wm_OamSlot.4.XPos,Y
	PLA
	CLC
	ADC m0
	STA wm_OamSlot.1.XPos,Y
	PLA
	CLC
	ADC m1
	STA wm_OamSlot.2.XPos,Y
	LDA wm_SpriteState,X
	LSR
	LSR
	LDA #$40
	STA wm_OamSlot.2.Tile,Y
	STA wm_OamSlot.4.Tile,Y
	STA wm_OamSlot.5.Tile,Y
	STA wm_OamSlot.3.Tile,Y
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteProp
	STA wm_OamSlot.4.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	STA wm_OamSlot.5.Prop,Y
	ORA #$60
	STA wm_OamSlot.1.Prop,Y
	LDA m0
	PHA
	LDA m2
	PHA
	LDA #$04
	JSR _01B37E
	PLA
	STA m2
	PLA
	STA m0
	RTS

FinishOAMWrite:
	PHB
	PHK
	PLB
	JSR FinishOAMWriteRt
	PLB
	RTL

FinishOAMWriteRt:
	STY m11
	STA m8
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteYLo,X
	STA m0
	SEC
	SBC wm_Bg1VOfs
	STA m6
	LDA wm_SpriteYHi,X
	STA m1
	LDA wm_SpriteXLo,X
	STA m2
	SEC
	SBC wm_Bg1HOfs
	STA m7
	LDA wm_SpriteXHi,X
	STA m3
_01B7DE:
	TYA
	LSR
	LSR
	TAX
	LDA m11
	BPL CODE_01B7F0
	LDA wm_OamSize.1,X
	AND #$02
	STA wm_OamSize.1,X
	BRA _01B7F3

CODE_01B7F0:
	STA wm_OamSize.1,X
_01B7F3:
	LDX #$00
	LDA wm_OamSlot.1.XPos,Y
	SEC
	SBC m7
	BPL +
	DEX
+	CLC
	ADC m2
	STA m4
	TXA
	ADC m3
	STA m5
	JSR CODE_01B844
	BCC +
	TYA
	LSR
	LSR
	TAX
	LDA wm_OamSize.1,X
	ORA #$01
	STA wm_OamSize.1,X
+	LDX #$00
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC m6
	BPL +
	DEX
+	CLC
	ADC m0
	STA m9
	TXA
	ADC m1
	STA m10
	JSR CODE_01C9BF
	BCC +
	LDA #$F0
	STA wm_OamSlot.1.YPos,Y
+	INY
	INY
	INY
	INY
	DEC m8
	BPL _01B7DE
	LDX wm_SprProcessIndex
	RTS

CODE_01B844:
	REP #$20
	LDA m4
	SEC
	SBC wm_Bg1HOfs
	CMP #$0100
	SEP #$20
	RTS

Return01B851:
	RTS ; Unused

CODE_01B852:
	LDA wm_SpriteOffTbl,X
	BNE ++
	LDA wm_MarioAnimation
	CMP #$01
	BCS ++
	JSR CODE_01B8FF
	BCC ++
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m2
	SEC
	SBC m13
	STA m9
	LDA wm_MarioScrPosY
	CLC
	ADC #$18
	CMP m9
	BCS ADDR_01B8B2
	LDA wm_MarioSpeedY
	BMI ++
	STZ wm_MarioSpeedY
	LDA #$01
	STA wm_IsOnSolidSpr
	LDA m13
	CLC
	ADC #$1F
	LDY wm_OnYoshi
	BEQ +
	CLC
	ADC #$10
+	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC m0
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	SBC #$00
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
++	RTS

ADDR_01B8B2:
	LDA m2
	CLC
	ADC m13
	STA m2
	LDA #$FF
	LDY wm_IsDucking
	BNE +
	LDY wm_MarioPowerUp
	BNE ++
+	LDA #$08
++	CLC
	ADC wm_MarioScrPosY
	CMP m2
	BCC ADDR_01B8D5
	LDA wm_MarioSpeedY
	BPL +
	LDA #$10
	STA wm_MarioSpeedY
+	RTS

ADDR_01B8D5:
	LDA m14
	CLC
	ADC #$10
	STA m0
	LDY #$00
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CMP wm_MarioScrPosX
	BCC +
	LDA m0
	EOR #$FF
	INC A
	STA m0
	DEY
+	LDA wm_SpriteXLo,X
	CLC
	ADC m0
	STA wm_MarioXPos
	TYA
	ADC wm_SpriteXHi,X
	STA wm_MarioXPos+1
	STZ wm_MarioSpeedX
	RTS

CODE_01B8FF:
	LDA m0
	STA m14
	LDA m2
	STA m13
	LDA wm_SpriteXLo,X
	SEC
	SBC m0
	STA m4
	LDA wm_SpriteXHi,X
	SBC #$00
	STA m10
	LDA m0
	ASL
	CLC
	ADC #$10
	STA m6
	LDA wm_SpriteYLo,X
	SEC
	SBC m2
	STA m5
	LDA wm_SpriteYHi,X
	SBC #$00
	STA m11
	LDA m2
	ASL
	CLC
	ADC #$10
	STA m7
	JSL GetMarioClipping
	JSL CheckForContact
	RTS

HorzNetKoopaSpeed:	.DB 8,-8

InitHorzNetKoopa:
	JSR SubHorizPos
	LDA HorzNetKoopaSpeed,Y
	STA wm_SpriteSpeedX,X
	BRA _01B950

InitVertNetKoopa:
	INC wm_SpriteState,X
	INC wm_SpriteSpeedX,X
	LDA #$F8
	STA wm_SpriteSpeedY,X
_01B950:
	LDA wm_SpriteXLo,X
	LDY #$00
	AND #$10
	BNE +
	INY
+	TYA
	STA wm_SprBehindScrn,X
	LDA wm_SpritePal,X
	AND #$02
	BNE +
	ASL wm_SpriteSpeedX,X
	ASL wm_SpriteSpeedY,X
+	RTS

DATA_01B969:
	.DB $02,$02,$03,$04,$03,$02,$02,$02
	.DB $01,$02

DATA_01B973:
	.DB $01,$01,$00,$00,$00,$01,$01,$01
	.DB $01,$01

DATA_01B97D:	.DB 3,12

ClimbingKoopa:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01B9FB
	CMP #$30
	BCC +
	CMP #$40
	BCC CODE_01B9A3
	BNE +
	LDY wm_SpritesLocked
	BNE +
	LDA wm_SprBehindScrn,X
	EOR #$01
	STA wm_SprBehindScrn,X
	JSR FlipSpriteDir
	JSR CODE_01BA7F
+	JMP _01BA37

CODE_01B9A3:
	LDY wm_SpriteYLo,X
	PHY
	LDY wm_SpriteYHi,X
	PHY
	LDY #$00
	CMP #$38
	BCC +
	INY
+	LDA wm_SpriteState,X
	BEQ +
	INY
	INY
	LDA wm_SpriteYLo,X
	SEC
	SBC #$0C
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
	LDA wm_SprBehindScrn,X
	BEQ +
	INY
+	LDA wm_MapData.OwLvFlags.Lv125
	BPL +
	INY
	INY
	INY
	INY
	INY
+	LDA DATA_01B969,Y
	STA wm_SpriteGfxTbl,X
	LDA DATA_01B973,Y
	STA m0
	LDA wm_SpritePal,X
	PHA
	AND #$FE
	ORA m0
	STA wm_SpritePal,X
	JSR SubSprGfx1
	PLA
	STA wm_SpritePal,X
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	RTS

CODE_01B9FB:
	LDA wm_SpritesLocked
	BNE _01BA53
	JSR CODE_019140
	LDY wm_SpriteState,X
	LDA wm_SprObjStatus,X
	AND DATA_01B97D,Y
	BEQ CODE_01BA14
_01BA0C:
	JSR FlipSpriteDir
	JSR CODE_01BA7F
	BRA _01BA37

CODE_01BA14:
	LDA wm_SprOnTileYLo
	LDY wm_SpriteSpeedY,X
	BEQ _01BA27
	BPL CODE_01BA1F
	BMI _01BA2A ; [BRA FIX]

CODE_01BA1F:
	CMP #$07
	BCC _01BA0C
	CMP #$1D
	BCS _01BA0C
_01BA27:
	LDA wm_SprOnTileXLo
_01BA2A:
	CMP #$07
	BCC +
	CMP #$1D
	BCC _01BA37
+	LDA #$50
	STA wm_SpriteDecTbl1,X
_01BA37:
	LDA wm_SpritesLocked
	BNE _01BA53
	INC wm_SpriteMiscTbl6,X
	JSR UpdateDirection
	LDA wm_SpriteState,X
	BNE CODE_01BA4A
	JSR SubSprXPosNoGrvty
	BRA _01BA4D

CODE_01BA4A:
	JSR SubSprYPosNoGrvty
_01BA4D:
	JSR MarioSprInteractRt
	JSR SubOffscreen0Bnk1
_01BA53:
	LDA wm_SpriteDir,X
	PHA
	LDA wm_SpriteMiscTbl6,X
	AND #$08
	LSR
	LSR
	LSR
	STA wm_SpriteDir,X
	LDA wm_SpriteProp
	PHA
	LDA wm_SprBehindScrn,X
	STA wm_SpriteGfxTbl,X
	LDA wm_SprBehindScrn,X
	BEQ +
	LDA #$10
	STA wm_SpriteProp
+	JSR SubSprGfx1
	PLA
	STA wm_SpriteProp
	PLA
	STA wm_SpriteDir,X
	RTS

CODE_01BA7F:
	LDA wm_SpriteSpeedY,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedY,X
	RTS

InitClimbingDoor:
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_SpriteXLo,X
	LDA wm_SpriteYLo,X
	ADC #$07
	STA wm_SpriteYLo,X
	RTS

UNK_01BA95:	.DB $30,$54

DATA_01BA97:
	.DB $00,$01,$02,$04,$06,$09,$0C,$0D
	.DB $14,$0D,$0C,$09,$06,$04,$02,$01

DATA_01BAA7:
	.DB $00,$00,$00,$00,$00,$01,$01,$01
	.DB $02,$01,$01,$01,$00,$00,$00,$00

DATA_01BAB7:
	.DB $00,$10,$00,$00,$10,$00,$01,$11
	.DB $01,$05,$15,$05,$05,$15,$05,$00
	.DB $00,$00,$03,$13,$03

Return01BACC:
	RTS

ClimbingDoor:
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteDecTbl2,X
	CMP #$01
	BNE +
	LDA #$0F
	STA wm_SoundCh1
	LDA #$19
	JSL GenTileFromSpr2
	LDA #$1F
	STA wm_SpriteDecTbl1,X
	STA wm_NetSideTimer
	LDA wm_MarioXPos
	SEC
	SBC #$10
	SEC
	SBC wm_SpriteXLo,X
	STA wm_PlayerNetDoorX
+	LDA wm_SpriteDecTbl1,X
	ORA wm_SpriteDecTbl2,X
	BNE +
	JSL GetSpriteClippingA
	JSR CODE_01BC1D
	JSL CheckForContact
	BCC +
	LDA wm_NetPunchTimer
	CMP #$01
	BNE +
	LDA #$06
	STA wm_SpriteDecTbl2,X
+	LDA wm_SpriteDecTbl1,X
	BEQ Return01BACC
	CMP #$01
	BNE +
	PHA
	LDA #$1A
	JSL GenTileFromSpr2
	PLA
+	CMP #$10
	BNE +
	LDA wm_IsBehindScenery
	EOR #$01
	STA wm_IsBehindScenery
+	LDA #$30
	STA wm_SprOAMIndex,X
	STA m3
	TAY
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_SpriteDecTbl1,X
	LSR
	STA m2
	TAX
	LDA.W DATA_01BAA7,X
	STA m6
	LDA m0
	CLC
	ADC.W DATA_01BA97,X
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	STA wm_OamSlot.3.XPos,Y
	LDA m6
	CMP #$02
	BEQ +
	LDA m0
	CLC
	ADC #$20
	SEC
	SBC.W DATA_01BA97,X
	STA wm_OamSlot.4.XPos,Y
	STA wm_OamSlot.5.XPos,Y
	STA wm_OamSlot.6.XPos,Y
	LDA m6
	BNE +
	LDA m0
	CLC
	ADC #$10
	STA wm_OamSlot.7.XPos,Y
	STA wm_OamSlot.8.XPos,Y
	STA wm_OamSlot.9.XPos,Y
+	LDA m1
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.4.YPos,Y
	STA wm_OamSlot.7.YPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.YPos,Y
	STA wm_OamSlot.5.YPos,Y
	STA wm_OamSlot.8.YPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.3.YPos,Y
	STA wm_OamSlot.6.YPos,Y
	STA wm_OamSlot.9.YPos,Y
	LDA #$08
	STA m7
	LDA m6
	ASL
	ASL
	ASL
	ADC m6
	TAX
-	LDA.W DATA_01BAB7,X
	STA wm_OamSlot.1.Tile,Y
	INY
	INY
	INY
	INY
	INX
	DEC m7
	BPL -
	LDY m3
	LDX #$08
-	LDA wm_SpriteProp
	ORA #$09
	CPX #$06
	BCS +
	ORA #$40
+	CPX #$00
	BEQ +
	CPX #$03
	BEQ +
	CPX #$06
	BNE ++
+	ORA #$80
++	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	LDA m6
	PHA
	LDX wm_SprProcessIndex
	LDA #$08
	JSR _01B37E
	LDY #$0C
	PLA
	BEQ ++
	CMP #$02
	BNE +
	LDA #$03
	STA wm_OamSize.4,Y
	STA wm_OamSize.5,Y
	STA wm_OamSize.6,Y
+	LDA #$03
	STA wm_OamSize.7,Y
	STA wm_OamSize.8,Y
	STA wm_OamSize.9,Y
++	RTS

CODE_01BC1D:
	LDA wm_MarioXPos
	STA m0
	LDA wm_MarioYPos
	STA m1
	LDA #$10
	STA m2
	STA m3
	LDA wm_MarioXPos+1
	STA m8
	LDA wm_MarioYPos+1
	STA m9
	RTS

MagiKoopasMagicPals:	.DB $05,$07,$09,$0B

MagikoopasMagic:
	LDA wm_SpritesLocked
	BEQ CODE_01BC3F
	JMP CODE_01BCBD

CODE_01BC3F:
	JSR CODE_01B14E
	JSR SubSprYPosNoGrvty
	JSR SubSprXPosNoGrvty
	LDA wm_SpriteSpeedY,X
	PHA
	LDA #$FF
	STA wm_SpriteSpeedY,X
	JSR CODE_019140
	PLA
	STA wm_SpriteSpeedY,X
	JSR IsTouchingCeiling
	BEQ CODE_01BCBD
	LDA wm_OffscreenHorz,X
	BNE CODE_01BCBD
	LDA #$01
	STA wm_SoundCh1
	STZ wm_SpriteStatus,X
	LDA wm_SprOnTileYLo
	SEC
	SBC #$11
	CMP #$1D
	BCS ++
	JSL GetRand
	ADC wm_RandomByte2
	ADC wm_MarioSpeedX
	ADC wm_FrameA
	LDY #$78
	CMP #$35
	BEQ +
	LDY #$21
	CMP #$08
	BCC +
	LDY #$27
	CMP #$F7
	BCS +
	LDY #$07
+	STY wm_SpriteNum,X
	LDA #$08
	STA wm_SpriteStatus,X
	JSL InitSpriteTables
	LDA wm_BlockYPos+1
	STA wm_SpriteXHi,X
	LDA wm_BlockYPos
	AND #$F0
	STA wm_SpriteXLo,X
	LDA wm_BlockXPos+1
	STA wm_SpriteYHi,X
	LDA wm_BlockXPos
	AND #$F0
	STA wm_SpriteYLo,X
	LDA #$02
	STA wm_BlockId
	JSL GenerateTile
++	JSR CODE_01BD98
	RTS

CODE_01BCBD:
	JSR _SubSprSprMarioSpr
	LDA wm_FrameA
	LSR
	LSR
	AND #$03
	TAY
	LDA MagiKoopasMagicPals,Y
	STA wm_SpritePal,X
	JSR MagiKoopasMagicGfx
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$E0
	BCC +
	STZ wm_SpriteStatus,X
+	RTS

MagiKoopasMagicDisp:
	.DB $00,$01,$02,$05,$08,$0B,$0E,$0F
	.DB $10,$0F,$0E,$0B,$08,$05,$02,$01

MagiKoopasMagicGfx:
	JSR GetDrawInfoBnk1
	LDA wm_FrameB
	LSR
	AND #$0F
	STA m3
	CLC
	ADC #$0C
	AND #$0F
	STA m2
	LDA m1
	SEC
	SBC #$04
	STA m1
	LDA m0
	SEC
	SBC #$04
	STA m0
	LDX m2
	LDA m1
	CLC
	ADC.W MagiKoopasMagicDisp,X
	STA wm_OamSlot.1.YPos,Y
	LDX m3
	LDA m0
	CLC
	ADC.W MagiKoopasMagicDisp,X
	STA wm_OamSlot.1.XPos,Y
	LDA m2
	CLC
	ADC #$05
	AND #$0F
	STA m2
	TAX
	LDA m1
	CLC
	ADC.W MagiKoopasMagicDisp,X
	STA wm_OamSlot.2.YPos,Y
	LDA m3
	CLC
	ADC #$05
	AND #$0F
	STA m3
	TAX
	LDA m0
	CLC
	ADC.W MagiKoopasMagicDisp,X
	STA wm_OamSlot.2.XPos,Y
	LDA m2
	CLC
	ADC #$05
	AND #$0F
	STA m2
	TAX
	LDA m1
	CLC
	ADC.W MagiKoopasMagicDisp,X
	STA wm_OamSlot.3.YPos,Y
	LDA m3
	CLC
	ADC #$05
	AND #$0F
	STA m3
	TAX
	LDA m0
	CLC
	ADC.W MagiKoopasMagicDisp,X
	STA wm_OamSlot.3.XPos,Y
	LDX wm_SprProcessIndex
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	LDA #$88
	STA wm_OamSlot.1.Tile,Y
	LDA #$89
	STA wm_OamSlot.2.Tile,Y
	LDA #$98
	STA wm_OamSlot.3.Tile,Y
	LDY #$00
	LDA #$02
	JMP FinishOAMWriteRt

CODE_01BD98:
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_01BDA3
	DEY
	BPL -
	RTS

CODE_01BDA3:
	LDA #$01
	STA wm_SmokeSprite,Y
	LDA wm_SpriteXLo,X
	STA wm_SmokeXPos,Y
	LDA wm_SpriteYLo,X
	STA wm_SmokeYPos,Y
	LDA #$1B
	STA wm_SmokeTimer,Y
	RTS

InitMagikoopa:
	LDY #$09
_01BDBA:
	CPY wm_SprProcessIndex
	BEQ CODE_01BDCF
	LDA wm_SpriteStatus,Y
	BEQ CODE_01BDCF
	LDA.W wm_SpriteNum,Y
	CMP #$1F
	BNE CODE_01BDCF
	STZ wm_SpriteStatus,X
	RTS

CODE_01BDCF:
	DEY
	BPL _01BDBA
	STZ wm_AppearSprTimer
	RTS

Magikoopa:
	LDA #$01
	STA wm_SpriteEatenTbl,X
	LDA wm_OffscreenHorz,X
	BEQ +
	STZ wm_SpriteState,X
+	LDA wm_SpriteState,X
	AND #$03
	JSL ExecutePtr

MagiKoopaPtrs:
	.DW CODE_01BDF2
	.DW CODE_01BE5F
	.DW CODE_01BE6E
	.DW CODE_01BF16

CODE_01BDF2:
	LDA wm_AppearSprTimer
	BEQ CODE_01BDFB
	STZ wm_SpriteStatus,X
	RTS

CODE_01BDFB:
	LDA wm_SpritesLocked
	BNE +
	LDY #$24
	STY wm_CgAdSub
	LDA wm_SpriteDecTbl1,X
	BNE +
	JSL GetRand
	CMP #$D1
	BCS +
	CLC
	ADC wm_Bg1VOfs
	AND #$F0
	STA wm_SpriteYLo,X
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,X
	JSL GetRand
	CLC
	ADC wm_Bg1HOfs
	AND #$F0
	STA wm_SpriteXLo,X
	LDA wm_Bg1HOfs+1
	ADC #$00
	STA wm_SpriteXHi,X
	JSR SubHorizPos
	LDA m15
	CLC
	ADC #$20
	CMP #$40
	BCC +
	STZ wm_SpriteSpeedY,X
	LDA #$01
	STA wm_SpriteSpeedX,X
	JSR CODE_019140
	JSR IsOnGround
	BEQ +
	LDA wm_SprOnTileXHi
	BNE +
	INC wm_SpriteState,X
	STZ wm_SpriteMiscTbl6,X
	JSR _01BE82
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
+	RTS

CODE_01BE5F:
	JSR CODE_01C004
	STZ wm_SpriteGfxTbl,X
	JSR SubSprGfx1
	RTS

DATA_01BE69:	.DB $04,$02,$00

DATA_01BE6C:	.DB 16,-8

CODE_01BE6E:
	STZ wm_SpriteEatenTbl,X
	JSR _SubSprSprMarioSpr
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
_01BE82:
	LDY #$34
	STY wm_CgAdSub
+	CMP #$40
	BNE ++
	PHA
	LDA wm_SpritesLocked
	ORA wm_OffscreenHorz,X
	BNE +
	JSR CODE_01BF1D
+	PLA
++	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	TAY
	PHY
	LDA wm_SpriteDecTbl1,X
	LSR
	LSR
	LSR
	AND #$01
	ORA DATA_01BE69,Y
	STA wm_SpriteGfxTbl,X
	JSR SubSprGfx1
	LDA wm_SpriteGfxTbl,X
	SEC
	SBC #$02
	CMP #$02
	BCC +
	LSR
	BCC +
	LDA wm_SprOAMIndex,X
	TAX
	INC wm_OamSlot.1.YPos,X
	LDX wm_SprProcessIndex
+	PLY
	CPY #$01
	BNE +
	JSR CODE_01B14E
+	LDA wm_SpriteGfxTbl,X
	CMP #$04
	BCC ++
	LDY wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_01BE6C,Y
	SEC
	SBC wm_Bg1HOfs
	LDY wm_SprOAMIndex,X
	STA wm_OamSlot.3.XPos,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC #$10
	STA wm_OamSlot.3.YPos,Y
	LDA wm_SpriteDir,X
	LSR
	LDA #$00
	BCS +
	ORA #$40
+	ORA wm_SpriteProp
	ORA wm_SpritePal,X
	STA wm_OamSlot.3.Prop,Y
	LDA #$99
	STA wm_OamSlot.3.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	ORA wm_OffscreenHorz,X
	STA wm_OamSize.3,Y
++	RTS

CODE_01BF16:
	JSR CODE_01BFE3
	JSR SubSprGfx1
	RTS

CODE_01BF1D:
	LDY #$09
-	LDA wm_SpriteStatus,Y
	BEQ CODE_01BF28
	DEY
	BPL -
	RTS

CODE_01BF28:
	LDA #$10
	STA wm_SoundCh1
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$20
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$0A
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,Y
	TYX
	JSL InitSpriteTables
	LDA #$20
	JSR CODE_01BF6A
	LDX wm_SprProcessIndex
	LDA m0
	STA.W wm_SpriteSpeedY,Y
	LDA m1
	STA.W wm_SpriteSpeedX,Y
	RTS

CODE_01BF6A:
	STA m1
	PHX
	PHY
	JSR CODE_01AD42
	STY m2
	LDA m14
	BPL +
	EOR #$FF
	CLC
	ADC #$01
+	STA m12
	JSR SubHorizPos
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

CODE_01BFE3:
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$02
	STA wm_SpriteDecTbl1,X
	DEC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$00
	BNE CODE_01C001
	INC wm_SpriteState,X
	LDA #$10
	STA wm_SpriteDecTbl1,X
	PLA
	PLA
+	RTS

CODE_01C001:
	JMP CODE_01C028

CODE_01C004:
	LDA wm_SpriteDecTbl1,X
	BNE _01C05E
	LDA #$04
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$09
	BNE +
	LDY #$24
	STY wm_CgAdSub
+	CMP #$09
	BNE CODE_01C028
	INC wm_SpriteState,X
	LDA #$70
	STA wm_SpriteDecTbl1,X
	RTS

CODE_01C028:
	LDA wm_SpriteMiscTbl6,X
	DEC A
	ASL
	ASL
	ASL
	ASL
	TAX
	STZ m0
	LDY wm_PalSprIndex
-	LDA.L MagiKoopaPals,X
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
_01C05E:
	LDX wm_SprProcessIndex
	RTS

ADDR_01C062: ; Unreachable
	JSR InitGoalTape
	LDA wm_SpriteYLo,X
	SEC
	SBC #$4C
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
	RTS

InitGoalTape:
	LDA wm_SpriteXLo,X
	SEC
	SBC #$08
	STA wm_SpriteState,X
	LDA wm_SpriteXHi,X
	SBC #$00
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteYLo,X
	STA wm_SpriteMiscTbl4,X
	LDA wm_SpriteYHi,X
	STA wm_SprStompImmuneTbl,X
	AND #$01
	STA wm_SpriteYHi,X
	STA wm_SpriteMiscTbl5,X
	RTS

GoalTape:
	JSR CODE_01C12D
	LDA wm_SpritesLocked
	BNE +
	LDA wm_SpriteGfxTbl,X
	BEQ CODE_01C0A7
+	RTS

DATA_01C0A5:	.DB 16,-16

CODE_01C0A7:
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$7C
	STA wm_SpriteDecTbl1,X
	INC wm_SprObjStatus,X
+	LDA wm_SprObjStatus,X
	AND #$01
	TAY
	LDA DATA_01C0A5,Y
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteState,X
	STA m0
	LDA wm_SpriteMiscTbl3,X
	STA m1
	REP #$20
	LDA wm_MarioXPos
	SEC
	SBC m0
	CMP #$0010
	SEP #$20
	BCS _Return01C12C
	LDA wm_SpriteMiscTbl4,X
	CMP wm_MarioYPos
	LDA wm_SpriteMiscTbl5,X
	AND #$01
	SBC wm_MarioYPos+1
	BCC _Return01C12C
	LDA wm_SprStompImmuneTbl,X
	LSR
	LSR
	STA wm_SecretGoalSprite
	LDA #$0C
	STA wm_MusicCh1
	LDA #$FF
	STA wm_LevelMusicMod
	LDA #$FF
	STA wm_EndLevelTimer
	STZ wm_StarPowerTimer
	INC wm_SpriteGfxTbl,X
	JSR MarioSprInteractRt
	BCC CODE_01C125
	LDA #$09
	STA wm_SoundCh3
	INC wm_SpriteMiscTbl8,X
	LDA wm_SpriteMiscTbl4,X
	SEC
	SBC wm_SpriteYLo,X
	STA wm_SpriteMiscTbl7,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
	JSL CODE_07F252
	BRA _01C128

CODE_01C125:
	STZ wm_Tweaker1686,X
_01C128:
	JSL TriggerGoalTape
_Return01C12C:
	RTS

CODE_01C12D:
	LDA wm_SpriteMiscTbl8,X
	BNE CODE_01C175
	JSR GetDrawInfoBnk1
	LDA m0
	SEC
	SBC #$08
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.2.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.3.XPos,Y
	LDA m1
	CLC
	ADC #$08
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	STA wm_OamSlot.3.YPos,Y
	LDA #$D4
	STA wm_OamSlot.1.Tile,Y
	INC A
	STA wm_OamSlot.2.Tile,Y
	STA wm_OamSlot.3.Tile,Y
	LDA #$32
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	LDY #$00
	LDA #$02
	JMP FinishOAMWriteRt

CODE_01C175:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01C17F
	JSL CODE_07F1CA
	RTS

CODE_01C17F:
	STZ wm_SpriteStatus,X
	RTS

GrowingVine:
	LDA wm_SpriteProp
	PHA
	LDA wm_SpriteDecTbl1,X
	CMP #$20
	BCC +
	LDA #$10
	STA wm_SpriteProp
+	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LSR
	LDA #$AC
	BCC +
	LDA #$AE
+	STA wm_OamSlot.1.Tile,Y
	PLA
	STA wm_SpriteProp
	LDA wm_SpritesLocked
	BNE _Return01C1ED
	LDA #$F0
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteDecTbl1,X
	CMP #$20
	BCS CODE_01C1CB
	JSR CODE_019140
	LDA wm_SprObjStatus,X
	BNE +
	LDA wm_SpriteYHi,X
	BPL CODE_01C1CB
+	JMP _OffScrEraseSprite

CODE_01C1CB:
	LDA wm_SpriteYLo,X
	AND #$0F
	CMP #$00
	BNE _Return01C1ED
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	LDA #$03
	STA wm_BlockId
	JSL GenerateTile
_Return01C1ED:
	RTS

DATA_01C1EE:	.DB -1,1

DATA_01C1F0:	.DB -16,16

BalloonKeyFlyObjs:
	LDA wm_SpriteStatus,X
	CMP #$0C
	BEQ _01C255
	LDA wm_SpritesLocked
	BNE _01C255
	LDA wm_SpriteNum,X
	CMP #$7D
	BNE CODE_01C21D
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01C21D
	LDA wm_SpriteProp
	PHA
	LDA #$10
	STA wm_SpriteProp
	JSR CODE_01C61A
	PLA
	STA wm_SpriteProp
	LDA #$F8
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
	RTS

CODE_01C21D:
	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_01C1EE,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_01C1F0,Y
	BNE +
	INC wm_SpriteMiscTbl3,X
+	LDA #$0C
	STA wm_SpriteSpeedX,X
	JSR SubSprXPosNoGrvty
	LDA wm_SpriteSpeedY,X
	PHA
	CLC
	SEC
	SBC #$02
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
	PLA
	STA wm_SpriteSpeedY,X
	JSR SubOffscreen0Bnk1
	INC wm_SpriteMiscTbl6,X
_01C255:
	LDA wm_SpriteNum,X
	CMP #$7D
	BNE CODE_01C262
	LDA #$01
	STA wm_SpriteDir,X
	BRA _01C27F

CODE_01C262:
	LDA wm_SpriteState,X
	CMP #$02
	BNE ++
	LDA wm_FrameA
	AND #$03
	BNE +
	JSR CODE_01B14E
+	LDA wm_FrameB
	LSR
	AND #$0E
	EOR wm_SpritePal,X
	STA wm_SpritePal,X
++	JSR CODE_019E95
_01C27F:
	LDA wm_SpriteState,X
	BEQ CODE_01C287
	JSR GetDrawInfoBnk1
	RTS

CODE_01C287:
	JSR CODE_01C61A
	JSR MarioSprInteractRt
	BCC _Return01C2D2
	LDA wm_SpriteNum,X
	CMP #$7E
	BNE CODE_01C2A6
	JSR _01C4F0
	LDA #$05
	JSL ADDR_05B329
	LDA #$03
	JSL GivePoints
	BRA ADDR_01C30F

CODE_01C2A6:
	CMP #$7F
	BNE CODE_01C2AF
	JSR GiveMario1Up
	BRA ADDR_01C30F

CODE_01C2AF:
	CMP #$80
	BNE CODE_01C2CE
	LDA wm_MarioSpeedY
	BMI _Return01C2D2
	LDA #$09
	STA wm_SpriteStatus,X
	LDA #$D0
	STA wm_MarioSpeedY
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteDecTbl1,X
	LDA wm_Tweaker167A,X
	AND #$7F
	STA wm_Tweaker167A,X
	RTS

CODE_01C2CE:
	CMP #$7D
	BEQ CODE_01C2D3
_Return01C2D2:
	RTS

CODE_01C2D3:
	LDY #$0B
-	LDA wm_SpriteStatus,Y
	CMP #$0B
	BNE +
	LDA.W wm_SpriteNum,Y
	CMP #$7D
	BEQ +
	LDA #$09
	STA wm_SpriteStatus,Y
+	DEY
	BPL -
	LDA #$00
	LDY wm_PBalloonFrame
	BNE +
	LDA #$0B
+	STA wm_SpriteStatus,X
	LDA wm_MarioSpeedY
	STA wm_SpriteSpeedY,X
	LDA wm_MarioSpeedX
	STA wm_SpriteSpeedX,X
	LDA #$09
	STA wm_PBalloonFrame
	LDA #$FF
	STA wm_BalloonTimer
	LDA #$1E
	STA wm_SoundCh1
	RTS

ADDR_01C30F:
	STZ wm_SpriteStatus,X
	RTS

ChangingItemSprite:	.DB $74,$75,$77,$76

ChangingItem:
	LDA #$01
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteEatenTbl,X
	BNE +
	INC wm_SprStompImmuneTbl,X
+	LDA wm_SprStompImmuneTbl,X
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA ChangingItemSprite,Y
	STA wm_SpriteNum,X
	JSL LoadSpriteTables
	JSR _PowerUpRt
	LDA #$81
	STA wm_SpriteNum,X
	JSL LoadSpriteTables
	RTS

EatenBerryGfxProp:	.DB $02,$02,$04,$06

FireFlower:
	LDA wm_FrameB
	AND #$08
	LSR
	LSR
	LSR
	STA wm_SpriteDir,X
_PowerUpRt:
	LDA wm_SpriteMiscTbl8,X
	BEQ CODE_01C371
	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA #$80
	STA wm_OamSlot.1.Tile,Y
	PHX
	LDX wm_BerryEatenType
	LDA.W EatenBerryGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	RTS

CODE_01C371:
	LDA wm_SpriteProp
	PHA
	JSR CODE_01C4AC
	LDA wm_SpriteMiscTbl5,X
	BEQ CODE_01C38F
	LDA wm_SpritesLocked
	BNE +
	LDA #$10
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
+	LDA wm_FrameB
	AND #$0C
	BNE _01C3AB
	PLA
	RTS

CODE_01C38F:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01C3AE
	JSR CODE_019140
	LDA wm_SpriteMiscTbl4,X
	BNE +
	LDA #$10
	STA wm_SpriteProp
+	LDA wm_SpritesLocked
	BNE _01C3AB
	LDA #$FC
	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
_01C3AB:
	JMP _01C48D

CODE_01C3AE:
	LDA wm_SpritesLocked
	BNE _01C3AB
	LDA wm_SpriteStatus,X
	CMP #$0C
	BEQ _01C3AB
	LDA wm_SpriteNum,X
	CMP #$76
	BNE + ; Now Nintendo what is this?
+	INC wm_SpriteMiscTbl6,X
	JSR CODE_018DBB
	LDA wm_SpriteNum,X
	CMP #$75
	BNE +
	LDA wm_SpriteMiscTbl3,X
	BNE +
	STZ wm_SpriteSpeedX,X
+	CMP #$76
	BEQ +
	CMP #$21
	BEQ +
	LDA wm_SpriteMiscTbl3,X
	BNE +
	ASL wm_SpriteSpeedX,X
+	LDA wm_SpriteState,X
	BEQ CODE_01C3F3
	BMI +
	JSR CODE_019140
	LDA wm_SprObjStatus,X
	BNE +
	STZ wm_SpriteState,X
+	BRA _01C437

CODE_01C3F3:
	LDA wm_LevelMode
	CMP #$C1
	BEQ CODE_01C42C
	BIT wm_LevelMode
	BVC CODE_01C42C
	STZ wm_SprObjStatus,X
	STZ wm_SpriteSpeedX,X
	LDA wm_SpriteYHi,X
	BNE +
	LDA wm_SpriteYLo,X
	CMP #$A0
	BCC +
	AND #$F0
	STA wm_SpriteYLo,X
	LDA wm_SprObjStatus,X
	ORA #$04
	STA wm_SprObjStatus,X
	JSR CODE_018DBB
+	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
	BRA _01C42F

CODE_01C42C:
	JSR SubUpdateSprPos
_01C42F:
	LDA wm_FrameA
	AND #$03
	BEQ _01C437
	DEC wm_SpriteSpeedY,X
_01C437:
	JSR SubOffscreen0Bnk1
	JSR IsTouchingCeiling
	BEQ +
	LDA #$00
	STA wm_SpriteSpeedY,X
+	JSR IsOnGround
	BNE CODE_01C44A
	BRA _01C47E

CODE_01C44A:
	LDA wm_SpriteNum,X
	CMP #$21
	BNE CODE_01C46C
	JSR CODE_018DBB
	LDA wm_SpriteSpeedY,X
	INC A
	PHA
	JSR SetSomeYSpeed
	PLA
	LSR
	JSR CODE_01CCEC
	CMP #$FC
	BCS +
	LDY wm_SprObjStatus,X
	BMI +
	STA wm_SpriteSpeedY,X
+	BRA _01C47E

CODE_01C46C:
	JSR SetSomeYSpeed
	LDA wm_SpriteMiscTbl3,X
	BNE +
	LDA wm_SpriteNum,X
	CMP #$76
	BNE _01C47E
+	LDA #$C8
	STA wm_SpriteSpeedY,X
_01C47E:
	LDA wm_SpriteDecTbl3,X
	ORA wm_SpriteState,X
	BNE _01C48D
	JSR IsTouchingObjSide
	BEQ _01C48D
	JSR FlipSpriteDir
_01C48D:
	LDA wm_SpriteDecTbl1,X
	CMP #$36
	BCS +++
	LDA wm_SpriteState,X
	BEQ +
	CMP #$FF
	BNE ++
+	LDA wm_SprBehindScrn,X
	BEQ +
++	LDA #$10
	STA wm_SpriteProp
+	JSR CODE_01C61A
+++	PLA
	STA wm_SpriteProp
_Return01C4AB:
	RTS

CODE_01C4AC:
	JSR _01A80F
	BCC _Return01C4AB
	LDA wm_SpriteMiscTbl3,X
	BEQ +
	LDA wm_SpriteState,X
	BNE _Return01C4FA
+	LDA wm_SpriteDecTbl2,X
	BNE _Return01C4FA
_01C4BF:
	LDA wm_SpriteDecTbl1,X
	CMP #$18
	BCS _Return01C4FA
	STZ wm_SpriteStatus,X
	LDA wm_SpriteNum,X
	CMP #$21
	BNE TouchedPowerUp
	JSL CODE_05B34A
	LDA wm_SpritePal,X
	AND #$0E
	CMP #$02
	BEQ CODE_01C4E0
	LDA #$01
	BRA _01C4EC

CODE_01C4E0:
	LDA wm_SilverCoins
	INC wm_SilverCoins
	CMP #$0A
	BCC _01C4EC
	LDA #$0A
_01C4EC:
	JSL GivePoints
_01C4F0:
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_01C4FB
	DEY
	BPL -
_Return01C4FA:
	RTS

CODE_01C4FB:
	LDA #$05
	STA wm_SmokeSprite,Y
	LDA wm_SpriteXLo,X
	STA wm_SmokeXPos,Y
	LDA wm_SpriteYLo,X
	STA wm_SmokeYPos,Y
	LDA #$10
	STA wm_SmokeTimer,Y
	RTS

ItemBoxSprite:
	.DB $00,$01,$01,$01,$00,$01,$04,$02
	.DB $00,$00,$00,$00,$00,$01,$04,$02
	.DB $00,$00,$00,$00

GivePowerPtrIndex:
	.DB $00,$01,$01,$01,$04,$04,$04,$01
	.DB $02,$02,$02,$02,$03,$03,$01,$03
	.DB $05,$05,$05,$05

TouchedPowerUp:
	SEC
	SBC #$74
	ASL
	ASL
	ORA wm_MarioPowerUp
	TAY
	LDA ItemBoxSprite,Y
	BEQ +
	STA wm_ItemInBox
	LDA #$0B
	STA wm_SoundCh3
+	LDA GivePowerPtrIndex,Y
	JSL ExecutePtr

HandlePowerUpPtrs:
	.DW GiveMarioMushroom
	.DW CODE_01C56F
	.DW GiveMarioStar
	.DW GiveMarioCape
	.DW GiveMarioFire
	.DW GiveMario1Up

Return01C560:
	RTS ; Unused

GiveMarioMushroom:
	LDA #$02
	STA wm_MarioAnimation
	LDA #$2F
	STA wm_PlayerAnimTimer,Y
	STA wm_SpritesLocked
	JMP CODE_01C56F ; Jump to next instruction...

CODE_01C56F:
	LDA #$04
	LDY wm_SpriteMiscTbl5,X
	BNE +
	JSL GivePoints
+	LDA #$0A
	STA wm_SoundCh1
	RTS

CODE_01C580:
	LDA #$FF
	STA wm_StarPowerTimer
	LDA #$0D
	STA wm_MusicCh1
	ASL wm_LevelMusicMod
	SEC
	ROR wm_LevelMusicMod
	RTL

GiveMarioStar:
	JSL CODE_01C580
	BRA CODE_01C56F

GiveMarioCape:
	LDA #$02
	STA wm_MarioPowerUp
	LDA #$0D
	STA wm_SoundCh1
	LDA #$04
	JSL GivePoints
	JSL CODE_01C5AE
	INC wm_SpritesLocked
	RTS

CODE_01C5AE:
	LDA wm_MarioScrPosY+1
	ORA wm_MarioScrPosX+1
	BNE +++
	LDA #$03
	STA wm_MarioAnimation
	LDA #$18
	STA wm_PlayerAnimTimer
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ ++
	DEY
	BPL -
	DEC wm_SmokeSprIndex
	BPL +
	LDA #$03
	STA wm_SmokeSprIndex
+	LDY wm_SmokeSprIndex
++	LDA #$81
	STA wm_SmokeSprite,Y
	LDA #$1B
	STA wm_SmokeTimer,Y
	LDA wm_MarioYPos
	CLC
	ADC #$08
	STA wm_SmokeYPos,Y
	LDA wm_MarioXPos
	STA wm_SmokeXPos,Y
+++	RTL

GiveMarioFire:
	LDA #$20
	STA wm_FlashingPalTimer
	STA wm_SpritesLocked
	LDA #$04
	STA wm_MarioAnimation
	LDA #$03
	STA wm_MarioPowerUp
	JMP CODE_01C56F

GiveMario1Up:
	LDA #$08
	CLC
	ADC wm_SpriteMiscTbl7,X
	JSL GivePoints
	RTS

PowerUpTiles:
	.DB $24,$26,$48,$0E,$24,$00,$00,$00
	.DB $00,$E4,$E8,$24,$EC

StarPalValues:	.DB $00,$04,$08,$04

CODE_01C61A:
	JSR GetDrawInfoBnk1
	STZ m10
	LDA wm_ReznorSmokeFlag
	BNE +
	LDA wm_LevelMode
	CMP #$C1
	BEQ +
	BIT wm_LevelMode
	BVC +
	LDA #$D8
	STA wm_SprOAMIndex,X
	TAY
+	LDA wm_SpriteNum,X
	CMP #$21
	BNE PowerUpGfxRt
	JSL CoinSprGfx
	RTS

CoinSprGfx:
	JSR CoinSprGfxSub
	RTL

CoinSprGfxSub:
	JSR GetDrawInfoBnk1
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA #$E8
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	TXA
	CLC
	ADC wm_FrameB
	LSR
	LSR
	AND #$03
	BNE CODE_01C670
	LDY #$02
	BRA _01C69A

MovingCoinTiles:	.DB $EA,$FA,$EA

CODE_01C670:
	PHX
	TAX
	LDA m0
	CLC
	ADC #$04
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	CLC
	ADC #$08
	STA wm_OamSlot.2.YPos,Y
	LDA.L MovingCoinTiles-1,X
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	ORA #$80
	STA wm_OamSlot.2.Prop,Y
	PLX
	LDY #$00
_01C69A:
	LDA #$01
	JSL FinishOAMWrite
	RTS

PowerUpGfxRt:
	CMP #$76
	BNE +
	LDA wm_FrameA
	LSR
	AND #$03
	PHY
	TAY
	LDA StarPalValues,Y
	PLY
	STA m10
+	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	DEC A
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SpriteDir,X
	LSR
	LDA #$00
	BCS +
	ORA #$40
+	ORA wm_SpriteProp
	ORA wm_SpritePal,X
	EOR m10
	STA wm_OamSlot.1.Prop,Y
	LDA wm_SpriteNum,X
	SEC
	SBC #$74
	TAX
	LDA.W PowerUpTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDX wm_SprProcessIndex
	LDA #$00
	JSR _01B37E
	RTS

DATA_01C6E6:	.DB 2,-2

DATA_01C6E8:	.DB 32,-32

DATA_01C6EA:	.DB 10,-10,8

Feather:
	LDA wm_SpritesLocked
	BNE _01C744
	LDA wm_SpriteState,X
	BEQ CODE_01C701
	JSR CODE_019140
	LDA wm_SprObjStatus,X
	BNE +
	STZ wm_SpriteState,X
+	BRA _01C741

CODE_01C701:
	LDA wm_SpriteStatus,X
	CMP #$0C
	BEQ _01C744
	LDA wm_SpriteDecTbl2,X
	BEQ CODE_01C715
	JSR SubSprYPosNoGrvty
	INC wm_SpriteSpeedY,X
	JMP _01C741

CODE_01C715:
	LDA wm_SpriteMiscTbl4,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_01C6E6,Y
	STA wm_SpriteSpeedX,X
	CMP DATA_01C6E8,Y
	BNE +
	INC wm_SpriteMiscTbl4,X
+	LDA wm_SpriteSpeedX,X
	BPL +
	INY
+	LDA DATA_01C6EA,Y
	CLC
	ADC #$06
	STA wm_SpriteSpeedY,X
	JSR SubOffscreen0Bnk1
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
_01C741:
	JSR UpdateDirection
_01C744:
	JSR CODE_01C4AC
	JMP CODE_01C61A

InitBrwnChainPlat:
	LDA #$80
	STA wm_SpriteMiscTbl3,X
	LDA #$01
	STA wm_SpriteMiscTbl4,X
	LDA wm_SpriteXLo,X
	CLC
	ADC #$78
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	CLC
	ADC #$68
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,X
	RTS

BrownChainedPlat:
	JSR SubOffscreen2Bnk1
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_FrameA
	AND #$03
	ORA wm_SpriteGfxTbl,X
	BNE ++
	LDA #$01
	LDY wm_SpriteMiscTbl1,X
	BEQ ++
	BMI +
	LDA #$FF
+	CLC
	ADC wm_SpriteMiscTbl1,X
	STA wm_SpriteMiscTbl1,X
++	LDA wm_SpriteMiscTbl3,X
	PHA
	LDA wm_SpriteMiscTbl4,X
	PHA
	LDA #$00
	SEC
	SBC wm_SpriteMiscTbl3,X
	STA wm_SpriteMiscTbl3,X
	LDA #$02
	SBC wm_SpriteMiscTbl4,X
	AND #$01
	STA wm_SpriteMiscTbl4,X
	JSR CODE_01CACB
	JSR CODE_01CB20
	JSR CODE_01CB53
	PLA
	STA wm_SpriteMiscTbl4,X
	PLA
	STA wm_SpriteMiscTbl3,X
	LDA wm_ChainFirstX
	PHA
	SEC
	SBC wm_SpriteState,X
	STA wm_SprPixelMove
	PLA
	STA wm_SpriteState,X
	LDY wm_SprOAMIndex,X
	LDA wm_ChainFirstY
	SEC
	SBC wm_Bg1VOfs
	SEC
	SBC #$08
	STA wm_OamSlot.1.YPos,Y
	LDA wm_ChainFirstX
	SEC
	SBC wm_Bg1HOfs
	SEC
	SBC #$08
	STA wm_OamSlot.1.XPos,Y
	LDA #$A2
	STA wm_OamSlot.1.Tile,Y
	LDA #$31
	STA wm_OamSlot.1.Prop,Y
	LDY #$00
	LDA wm_ChainFirstY
	SEC
	SBC wm_ChainCentY
	BPL +
	EOR #$FF
	INC A
	INY
+	STY m0
	STA WRDIVH
	STZ WRDIVL
	LDA #$05
	STA WRDIVB
	JSR DoNothing
	LDA RDDIVL
	STA m2
	STA m6
	LDA RDDIVH
	STA m3
	STA m7
	LDY #$00
	LDA wm_ChainFirstX
	SEC
	SBC wm_ChainCentX
	BPL +
	EOR #$FF
	INC A
	INY
+	STY m1
	STA WRDIVH
	STZ WRDIVL
	LDA #$05
	STA WRDIVB
	JSR DoNothing
	LDA RDDIVL
	STA m4
	STA m8
	LDA RDDIVH
	STA m5
	STA m9
	LDY wm_SprOAMIndex,X
	INY
	INY
	INY
	INY
	LDA wm_ChainCentY
	SEC
	SBC wm_Bg1VOfs
	SEC
	SBC #$08
	STA m10
	STA wm_OamSlot.1.YPos,Y
	LDA wm_ChainCentX
	SEC
	SBC wm_Bg1HOfs
	SEC
	SBC #$08
	STA m11
	STA wm_OamSlot.1.XPos,Y
	LDA #$A2
	STA wm_OamSlot.1.Tile,Y
	LDA #$31
	STA wm_OamSlot.1.Prop,Y
	LDX #$03
_01C87C:
	INY
	INY
	INY
	INY
	LDA m0
	BNE CODE_01C88E
	LDA m10
	CLC
	ADC m7
	STA wm_OamSlot.1.YPos,Y
	BRA _01C896

CODE_01C88E:
	LDA m10
	SEC
	SBC m7
	STA wm_OamSlot.1.YPos,Y
_01C896:
	LDA m6
	CLC
	ADC m2
	STA m6
	LDA m7
	ADC m3
	STA m7
	LDA m1
	BNE CODE_01C8B1
	LDA m11
	CLC
	ADC m9
	STA wm_OamSlot.1.XPos,Y
	BRA _01C8B9

CODE_01C8B1:
	LDA m11
	SEC
	SBC m9
	STA wm_OamSlot.1.XPos,Y
_01C8B9:
	LDA m8
	CLC
	ADC m4
	STA m8
	LDA m9
	ADC m5
	STA m9
	LDA #$A2
	STA wm_OamSlot.1.Tile,Y
	LDA #$31
	STA wm_OamSlot.1.Prop,Y
	DEX
	BPL _01C87C
	LDX #$03
-	STX m2
	INY
	INY
	INY
	INY
	LDA wm_ChainFirstY
	SEC
	SBC wm_Bg1VOfs
	SEC
	SBC #$10
	STA wm_OamSlot.1.YPos,Y
	LDA wm_ChainFirstX
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC.W DATA_01C9B7,X
	STA wm_OamSlot.1.XPos,Y
	LDA.W BrwnChainPlatTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$31
	STA wm_OamSlot.1.Prop,Y
	DEX
	BPL -
	LDX wm_SprProcessIndex
	LDA #$09
	STA m8
	LDA wm_ChainCentY
	SEC
	SBC #$08
	STA m0
	LDA wm_BowserTearYPos
	SBC #$00
	STA m1
	LDA wm_ChainCentX
	SEC
	SBC #$08
	STA m2
	LDA wm_BowserMechTimer
	SBC #$00
	STA m3
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.2.YPos,Y
	STA m6
	LDA wm_OamSlot.2.XPos,Y
	STA m7
-	TYA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.1,X
	LDX #$00
	LDA wm_OamSlot.1.XPos,Y
	SEC
	SBC m7
	BPL +
	DEX
+	CLC
	ADC m2
	STA m4
	TXA
	ADC m3
	STA m5
	JSR CODE_01B844
	BCC +
	TYA
	LSR
	LSR
	TAX
	LDA #$03
	STA wm_OamSize.1,X
+	LDX #$00
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC m6
	BPL +
	DEX
+	CLC
	ADC m0
	STA m9
	TXA
	ADC m1
	STA m10
	JSR CODE_01C9BF
	BCC +
	LDA #$F0
	STA wm_OamSlot.1.YPos,Y
+	LDA m8
	CMP #$09
	BNE +
	LDA m4
	STA wm_ChainFirstX
	LDA m5
	STA wm_ChainFirstX+1
	LDA m9
	STA wm_ChainFirstY
	LDA m10
	STA wm_ChainFirstY+1
+	INY
	INY
	INY
	INY
	DEC m8
	BPL -
	LDX wm_SprProcessIndex
	LDY wm_SprOAMIndex,X
	LDA #$F0
	STA wm_OamSlot.2.YPos,Y
	LDA wm_SpritesLocked
	BNE Return01C9B6
	JSR CODE_01CCF0
	JMP CODE_01C9EC

Return01C9B6:
	RTS

DATA_01C9B7:	.DB -32,-16,0,16

BrwnChainPlatTiles:	.DB $60,$61,$61,$62

CODE_01C9BF:
	REP #$20
	LDA m9
	PHA
	CLC
	ADC #$0010
	STA m9
	SEC
	SBC wm_Bg1VOfs
	CMP #$0100
	PLA
	STA m9
	SEP #$20
_Return01C9D5:
	RTS

DATA_01C9D6:	.DB 1,-1

DATA_01C9D8:	.DB 64,-64

CODE_01C9DA:
	LDA wm_SpriteMiscTbl8,X
	BEQ +
	STZ wm_SpriteMiscTbl8,X
_01C9E2:
	PHX
	JSL CODE_00E2BD
	PLX
	STX wm_SprProcessIndex
+	RTS

CODE_01C9EC:
	LDA wm_ChainFirstX+1
	XBA
	LDA wm_ChainFirstX
	REP #$20
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$0010
	CMP #$0120
	SEP #$20
	ROL
	AND #$01
	ORA wm_SpritesLocked
	STA wm_SpriteOffTbl,X
	BNE _Return01C9D5
	JSR CODE_01CA9C
	STZ wm_SpriteGfxTbl,X
	BCC CODE_01C9DA
	LDA #$01
	STA wm_SpriteMiscTbl8,X
	LDA wm_ChainFirstY
	SEC
	SBC wm_Bg1VOfs
	STA m3
	SEC
	SBC #$08
	STA m14
	LDA wm_MarioScrPosY
	CLC
	ADC #$18
	CMP m14
	BCS +++
	LDA wm_MarioSpeedY
	BMI _01C9E2
	STZ wm_MarioSpeedY
	LDA #$03
	STA wm_IsOnSolidSpr
	STA wm_SpriteGfxTbl,X
	LDA #$28
	LDY wm_OnYoshi
	BEQ +
	LDA #$38
+	STA m15
	LDA wm_ChainFirstY
	SEC
	SBC m15
	STA wm_MarioYPos
	LDA wm_ChainFirstY+1
	SBC #$00
	STA wm_MarioYPos+1
	LDA wm_MarioObjStatus
	AND #$03
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
++	JSR _01C9E2
	LDA wm_JoyFrameA
	BMI +
	LDA #$FF
	STA wm_HidePlayer
+	LDA wm_FrameA
	LSR
	BCC +++
	LDA wm_SpriteMiscTbl3,X
	CLC
	ADC #$80
	LDA wm_SpriteMiscTbl4,X
	ADC #$00
	AND #$01
	TAY
	LDA wm_SpriteMiscTbl1,X
	CMP DATA_01C9D8,Y
	BEQ +++
	CLC
	ADC DATA_01C9D6,Y
	STA wm_SpriteMiscTbl1,X
+++	RTS

CODE_01CA9C:
	LDA wm_ChainFirstX
	SEC
	SBC #$18
	STA m4
	LDA wm_ChainFirstX+1
	SBC #$00
	STA m10
	LDA #$40
	STA m6
	LDA wm_ChainFirstY
	SEC
	SBC #$0C
	STA m5
	LDA wm_ChainFirstY+1
	SBC #$00
	STA m11
	LDA #$13
	STA m7
	JSL GetMarioClipping
	JSL CheckForContact
	RTS

CODE_01CACB:
	LDA #$50
	STA wm_ChainRadiusX
	STZ wm_ChainRadiusY
	STZ wm_ChainRadiusX+1
	STZ wm_ChainRadiusY+1
	LDA wm_SpriteXLo,X
	STA wm_ChainCosX
	LDA wm_SpriteXHi,X
	STA wm_BowserHurtTimer
	LDA wm_ChainCosX
	SEC
	SBC wm_ChainRadiusX
	STA wm_ChainCentX
	LDA wm_BowserHurtTimer
	SBC wm_ChainRadiusX+1
	STA wm_BowserMechTimer
	LDA wm_SpriteYLo,X
	STA wm_ChainSinY
	LDA wm_SpriteYHi,X
	STA wm_BowserFireX
	LDA wm_ChainSinY
	SEC
	SBC wm_ChainRadiusY
	STA wm_ChainCentY
	LDA wm_BowserFireX
	SBC wm_ChainRadiusY+1
	STA wm_BowserTearYPos
	LDA wm_SpriteMiscTbl3,X
	STA wm_M7Rotate
	LDA wm_SpriteMiscTbl4,X
	STA wm_M7Rotate+1
	RTS

CODE_01CB20:
	LDA wm_M7Rotate+1
	STA wm_ChainAngleNeg
	PHX
	REP #$30
	LDA wm_M7Rotate
	ASL
	AND #$01FF
	TAX
	LDA.L CircleCoords,X
	STA wm_ChainCurSin
	LDA wm_M7Rotate
	CLC
	ADC #$0080
	STA m0
	ASL
	AND #$01FF
	TAX
	LDA.L CircleCoords,X
	STA wm_ChainCurCos
	SEP #$30
	LDA m1
	STA wm_ChainAngleNeg+1
	PLX
	RTS

CODE_01CB53:
	REP #$20
	LDA wm_ChainCurCos
	STA m2
	LDA wm_ChainRadiusX
	STA m0
	SEP #$20
	JSR CODE_01CC28
	LDA wm_ChainAngleNeg+1
	LSR
	REP #$20
	LDA m4
	BCC +
	EOR #$FFFF
	INC A
+	STA m8
	LDA m6
	BCC +
	EOR #$FFFF
	INC A
+	STA m10
	LDA wm_ChainCurSin
	STA m2
	LDA wm_ChainRadiusY
	STA m0
	SEP #$20
	JSR CODE_01CC28
	LDA wm_ChainAngleNeg
	LSR
	REP #$20
	LDA m4
	BCC +
	EOR #$FFFF
	INC A
+	STA m4
	LDA m6
	BCC +
	EOR #$FFFF
	INC A
+	STA m6
	LDA m4
	CLC
	ADC m8
	STA m4
	LDA m6
	ADC m10
	STA m6
	LDA m5
	CLC
	ADC wm_ChainCentX
	STA wm_ChainFirstX
	LDA wm_ChainCurCos
	STA m2
	LDA wm_ChainRadiusY
	STA m0
	SEP #$20
	JSR CODE_01CC28
	LDA wm_ChainAngleNeg+1
	LSR
	REP #$20
	LDA m4
	BCC +
	EOR #$FFFF
	INC A
+	STA m8
	LDA m6
	BCC +
	EOR #$FFFF
	INC A
+	STA m10
	LDA wm_ChainCurSin
	STA m2
	LDA wm_ChainRadiusX
	STA m0
	SEP #$20
	JSR CODE_01CC28
	LDA wm_ChainAngleNeg
	LSR
	REP #$20
	LDA m4
	BCC +
	EOR #$FFFF
	INC A
+	STA m4
	LDA m6
	BCC +
	EOR #$FFFF
	INC A
+	STA m6
	LDA m4
	SEC
	SBC m8
	STA m4
	LDA m6
	SBC m10
	STA m6
	LDA wm_ChainCentY
	SEC
	SBC m5
	STA wm_ChainFirstY
	SEP #$20
	RTS

CODE_01CC28:
	LDA m0
	STA WRMPYA
	LDA m2
	STA WRMPYB
	JSR DoNothing
	LDA RDMPYL
	STA m4
	LDA RDMPYH
	STA m5
	LDA m0
	STA WRMPYA
	LDA m3
	STA WRMPYB
	JSR DoNothing
	LDA RDMPYL
	CLC
	ADC m5
	STA m5
	LDA RDMPYH
	ADC #$00
	STA m6
	LDA m1
	STA WRMPYA
	LDA m2
	STA WRMPYB
	JSR DoNothing
	LDA RDMPYL
	CLC
	ADC m5
	STA m5
	LDA RDMPYH
	ADC m6
	STA m6
	LDA m1
	STA WRMPYA
	LDA m3
	STA WRMPYB
	JSR DoNothing
	LDA RDMPYL
	CLC
	ADC m6
	STA m6
	LDA RDMPYH
	ADC #$00
	STA m7
	RTS

DoNothing:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RTS

CODE_01CC9D:
	LDA wm_BowserHurtTimer
	ORA wm_BowserFireX
	BNE CODE_01CCC5
	JSR CODE_01CCC7
	JSR CODE_01CB20
	JSR CODE_01CB53
	LDA wm_ChainFirstY
	AND #$F0
	STA m0
	LDA wm_ChainFirstX
	LSR
	LSR
	LSR
	LSR
	ORA m0
	TAY
	LDA wm_0AF6,Y
	CMP #$15
	RTL

CODE_01CCC5:
	CLC
	RTL

CODE_01CCC7:
	REP #$20
	LDA wm_M7X
	STA wm_ChainCentX
	LDA wm_M7Y
	STA wm_ChainCentY
	LDA wm_ChainCosX
	SEC
	SBC wm_ChainCentX
	STA wm_ChainRadiusX
	LDA wm_ChainSinY
	SEC
	SBC wm_ChainCentY
	STA wm_ChainRadiusY
	SEP #$20
	RTS

Return01CCEA:
	RTS ; Unused

Return01CCEB:
	RTS ; Unused

CODE_01CCEC:
	EOR #$FF
	INC A
	RTS

CODE_01CCF0:
	LDA wm_SpriteMiscTbl1,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpriteMiscTbl2,X
	STA wm_SpriteMiscTbl2,X
	PHP
	LDY #$00
	LDA wm_SpriteMiscTbl1,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	BCC +
	ORA #$F0
	DEY
+	PLP
	ADC wm_SpriteMiscTbl3,X
	STA wm_SpriteMiscTbl3,X
	TYA
	ADC wm_SpriteMiscTbl4,X
	STA wm_SpriteMiscTbl4,X
	RTS

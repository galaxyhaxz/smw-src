UNK_01E2C8:	.DB $13,$14,$15,$16,$17,$18,$19 ; Possibly stomp sounds?

MontyMole:
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteState,X
	JSL ExecutePtr

Ptrs01E2D8:
	.DW CODE_01E2E0
	.DW CODE_01E309
	.DW CODE_01E37F
	.DW CODE_01E393

CODE_01E2E0:
	JSR SubHorizPos
	LDA m15
	CLC
	ADC #$60
	CMP #$C0
	BCS ++
	LDA wm_OffscreenHorz,X
	BNE ++
	INC wm_SpriteState,X
	LDY wm_OWCharA
	LDA wm_MapData.MarioMap,Y
	TAY
	LDA #$68
	CPY #$01
	BEQ +
	LDA #$20
+	STA wm_SpriteDecTbl1,X
++	JSR GetDrawInfoBnk1
	RTS

CODE_01E309:
	LDA wm_SpriteDecTbl1,X
	ORA wm_SpriteEatenTbl,X
	BNE ++
	INC wm_SpriteState,X
	LDA #$B0
	STA wm_SpriteSpeedY,X
	JSR IsSprOffScreen
	BNE +
	TAY
	JSR _0199E1
+	JSR _FaceMario
	LDA wm_SpriteNum,X
	CMP #$4E
	BNE ++
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	LDA #$08
	STA wm_BlockId
	JSL GenerateTile
++	LDA wm_SpriteNum,X
	CMP #$4D
	BNE CODE_01E363
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LSR
	AND #$01
	TAY
	LDA DATA_01E35F,Y
	STA wm_SpriteGfxTbl,X
	LDA DATA_01E361,Y
	JSR SubSprGfx0Entry0
	RTS

DATA_01E35F:	.DB 1,2

DATA_01E361:	.DB 0,5

CODE_01E363:
	LDA wm_FrameB
	ASL
	ASL
	AND #$C0
	ORA #$31
	STA wm_SpritePal,X
	LDA #$03
	STA wm_SpriteGfxTbl,X
	JSR SubSprGfx2Entry1
	LDA wm_SpritePal,X
	AND #$3F
	STA wm_SpritePal,X
	RTS

CODE_01E37F:
	JSR CODE_01E3EF
	LDA #$02
	STA wm_SpriteGfxTbl,X
	JSR IsOnGround
	BEQ +
	INC wm_SpriteState,X
+	RTS

DATA_01E38F:	.DB 16,-16

DATA_01E391:	.DB 24,-24

CODE_01E393:
	JSR CODE_01E3EF
	LDA wm_SpriteMiscTbl3,X
	BNE CODE_01E3C7
	JSR SetAnimationFrame
	JSR SetAnimationFrame
	JSL GetRand
	AND #$01
	BNE +
	JSR _FaceMario
	LDA wm_SpriteSpeedX,X
	CMP DATA_01E391,Y
	BEQ +
	CLC
	ADC DATA_01EBB4,Y
	STA wm_SpriteSpeedX,X
	TYA
	LSR
	ROR
	EOR wm_SpriteSpeedX,X
	BPL +
	JSR CODE_01804E
	JSR SetAnimationFrame
+	RTS

CODE_01E3C7:
	JSR IsOnGround
	BEQ CODE_01E3E9
	JSR SetAnimationFrame
	JSR SetAnimationFrame
	LDY wm_SpriteDir,X
	LDA DATA_01E38F,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteDecTbl3,X
	BNE +
	LDA #$50
	STA wm_SpriteDecTbl3,X
	LDA #$D8
	STA wm_SpriteSpeedY,X
+	RTS

CODE_01E3E9:
	LDA #$01
	STA wm_SpriteGfxTbl,X
	RTS

CODE_01E3EF:
	LDA wm_SpriteProp
	PHA
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LDA #$10
	STA wm_SpriteProp
+	JSR SubSprGfx2Entry1
	PLA
	STA wm_SpriteProp
	LDA wm_SpritesLocked
	BNE CODE_01E41C
	JSR _SubSprSprMarioSpr
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ +
	JSR SetSomeYSpeed
+	JSR IsTouchingObjSide
	BEQ +
	JSR FlipSpriteDir
+	RTS

CODE_01E41C:
	PLA
	PLA
	RTS

DATA_01E41F:	.DB 8,-8

DATA_01E421:	.DB $02,$03,$04,$04,$04,$04,$04,$04,$04,$04

DryBonesAndBeetle:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01E43E
	ASL wm_SpritePal,X
	SEC
	ROR wm_SpritePal,X
	JMP _01E5BF

DATA_01E43C:	.DB 8,-8

CODE_01E43E:
	LDA wm_SpriteMiscTbl5,X
	BEQ CODE_01E4C0
	JSR SubSprGfx2Entry1
	LDY wm_SpriteDecTbl1,X
	BNE +
	STZ wm_SpriteMiscTbl5,X
	PHY
	JSR _FaceMario
	PLY
+	LDA #$48
	CPY #$10
	BCC +
	CPY #$F0
	BCS +
	LDA #$2E
+	LDY wm_SprOAMIndex,X
	STA wm_OamSlot.1.Tile,Y
	TYA
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	PHX
	LDA wm_SpriteDir,X
	TAX
	LDA wm_OamSlot.1.XPos,Y
	CLC
	ADC.W DATA_01E43C,X
	PLX
	STA wm_OamSlot.2.XPos,Y
	LDA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	LDA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	LDA wm_OamSlot.1.Tile,Y
	DEC A
	STA wm_OamSlot.2.Tile,Y
	LDA wm_SpriteDecTbl1,X
	BEQ +
	CMP #$40
	BCS +
	LSR
	LSR
	PHP
	LDA wm_OamSlot.1.XPos,Y
	ADC #$00
	STA wm_OamSlot.1.XPos,Y
	PLP
	LDA wm_OamSlot.2.XPos,Y
	ADC #$00
	STA wm_OamSlot.2.XPos,Y
+	LDY #$02
	LDA #$01
	JSR FinishOAMWriteRt
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ +
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
+	RTS

CODE_01E4C0:
	LDA wm_SpritesLocked
	ORA wm_SpriteDecTbl6,X
	BEQ CODE_01E4CA
	JMP _01E5B6

CODE_01E4CA:
	LDY wm_SpriteDir,X
	LDA DATA_01E421-2,Y
	EOR wm_SpriteSlopeTbl,X
	ASL
	LDA DATA_01E41F,Y
	BCC +
	CLC
	ADC wm_SpriteSlopeTbl,X
+	STA wm_SpriteSpeedX,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	TYA
	INC A
	AND wm_SprObjStatus,X
	AND #$03
	BEQ ++
+	STZ wm_SpriteSpeedX,X
++	JSR IsTouchingCeiling
	BEQ +
	STZ wm_SpriteSpeedY,X
+	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos
	LDA wm_SpriteNum,X
	CMP #$31
	BNE CODE_01E51E
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01E542
	LDY #$00
	CMP #$70
	BCS +
	INY
	INY
	CMP #$08
	BCC +
	CMP #$68
	BCS +
	INY
+	TYA
	STA wm_SpriteGfxTbl,X
	BRA CODE_01E563

CODE_01E51E:
	CMP #$30
	BEQ +
	CMP #$32
	BNE CODE_01E542
	LDA wm_TransLvNum
	CMP #$31
	BNE CODE_01E542
+	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01E542
	CMP #$01
	BNE +
	JSL CODE_03C44E
+	LDA #$02
	STA wm_SpriteGfxTbl,X
	JMP _01E5B6

CODE_01E542:
	JSR IsOnGround
	BEQ CODE_01E563
	JSR SetSomeYSpeed
	JSR SetAnimationFrame
	LDA wm_SpriteNum,X
	CMP #$32
	BNE CODE_01E557
	STZ wm_SpriteState,X
	BRA _01E561

CODE_01E557:
	LDA wm_SpriteMiscTbl6,X
	AND #$7F
	BNE _01E561
	JSR _FaceMario
_01E561:
	BRA _01E57B

CODE_01E563:
	STZ wm_SpriteMiscTbl6,X
	LDA wm_SpriteNum,X
	CMP #$32
	BNE _01E57B
	LDA wm_SpriteState,X
	BNE _01E57B
	INC wm_SpriteState,X
	JSR FlipSpriteDir
	JSR SubSprXPosNoGrvty
	JSR SubSprXPosNoGrvty
_01E57B:
	LDA wm_SpriteNum,X
	CMP #$31
	BNE CODE_01E598
	LDA wm_FrameA
	LSR
	BCC +
	INC wm_SpriteMiscTbl4,X
+	LDA wm_SpriteMiscTbl4,X
	BNE _01E5B6
	INC wm_SpriteMiscTbl4,X
	LDA #$A0
	STA wm_SpriteDecTbl1,X
	BRA _01E5B6

CODE_01E598:
	CMP #$30
	BEQ +
	CMP #$32
	BNE _01E5B6
	LDA wm_TransLvNum
	CMP #$31
	BNE _01E5B6
+	LDA wm_SpriteMiscTbl6,X
	CLC
	ADC #$40
	AND #$7F
	BNE _01E5B6
	LDA #$3F
	STA wm_SpriteDecTbl1,X
_01E5B6:
	JSR CODE_01E5C4
	JSR SubSprSprInteract
	JSR FlipIfTouchingObj
_01E5BF:
	JSL CODE_03C390
	RTS

CODE_01E5C4:
	JSR MarioSprInteractRt
	BCC _Return01E610
	LDA wm_PlayerYPosLv
	CLC
	ADC #$14
	CMP wm_SpriteYLo,X
	BPL CODE_01E604
	LDA wm_SprChainStomped
	BNE +
	LDA wm_MarioSpeedY
	BMI CODE_01E604
+	LDA wm_SpriteNum,X
	CMP #$31
	BNE +
	LDA wm_SpriteDecTbl1,X
	SEC
	SBC #$08
	CMP #$60
	BCC CODE_01E604
+	JSR CODE_01AB46
	JSL DisplayContactGfx
	LDA #$07
	STA wm_SoundCh1
	JSL BoostMarioSpeed
	INC wm_SpriteMiscTbl5,X
	LDA #$FF
	STA wm_SpriteDecTbl1,X
	RTS

CODE_01E604:
	JSL HurtMario
	LDA wm_PlayerHurtTimer
	BNE _Return01E610
	JSR _FaceMario
_Return01E610:
	RTS

DATA_01E611:
	.DB $00,$01,$02,$02,$02,$01,$01,$00
	.DB $00

DATA_01E61A:
	.DB $1E,$1B,$18,$18,$18,$1A,$1C,$1D
	.DB $1E

SpringBoard:
	LDA wm_SpritesLocked
	BEQ CODE_01E62A
	JMP _01E6F0

CODE_01E62A:
	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ +
	JSR CODE_0197D5
+	JSR IsTouchingObjSide
	BEQ +
	JSR FlipSpriteDir
	LDA wm_SpriteSpeedX,X
	ASL
	PHP
	ROR wm_SpriteSpeedX,X
	PLP
	ROR wm_SpriteSpeedX,X
+	JSR IsTouchingCeiling
	BEQ +
	STZ wm_SpriteSpeedY,X
+	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01E6B0
	LSR
	TAY
	LDA wm_OnYoshi
	CMP #$01
	LDA DATA_01E61A,Y
	BCC +
	CLC
	ADC #$12
+	STA m0
	LDA DATA_01E611,Y
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteYLo,X
	SEC
	SBC m0
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_MarioYPos+1
	STZ wm_IsFlying
	STZ wm_MarioSpeedX
	LDA #$02
	STA wm_IsOnSolidSpr
	LDA wm_SpriteDecTbl1,X
	CMP #$07
	BCS _01E6AE
	STZ wm_IsOnSolidSpr
	LDY #$B0
	LDA wm_JoyPadB
	BPL CODE_01E69A
	LDA #$01
	STA wm_IsSpinJump
	BRA _01E69E

CODE_01E69A:
	LDA wm_JoyPadA
	BPL +
_01E69E:
	LDA #$0B
	STA wm_IsFlying
	LDY #$80
	STY wm_BouncingWithYoshi
+	STY wm_MarioSpeedY
	LDA #$08
	STA wm_SoundCh3
_01E6AE:
	BRA _01E6F0

CODE_01E6B0:
	JSR ProcessInteract
	BCC _01E6F0
	STZ wm_SpriteDecTbl2,X
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_MarioYPos
	CLC
	ADC #$04
	CMP #$1C
	BCC CODE_01E6CE
	BPL CODE_01E6E7
	LDA wm_MarioSpeedY
	BPL _01E6F0
	STZ wm_MarioSpeedY
	BRA _01E6F0

CODE_01E6CE:
	BIT wm_JoyPadA
	BVC +
	LDA wm_IsCarrying
	ORA wm_OnYoshi
	BNE +
	LDA #$0B
	STA wm_SpriteStatus,X
	STZ wm_SpriteGfxTbl,X
+	JSR CODE_01AB31
	BRA _01E6F0

CODE_01E6E7:
	LDA wm_MarioSpeedY
	BMI _01E6F0
	LDA #$11
	STA wm_SpriteDecTbl1,X
_01E6F0:
	LDY wm_SpriteGfxTbl,X
	LDA DATA_01E6FD,Y
	TAY
	LDA #$02
	JSR _SubSprGfx0Entry1
	RTS

DATA_01E6FD:	.DB 0,2,0

SmushedGfxRt:
	JSR GetDrawInfoBnk1
	JSR IsSprOffScreen
	BNE ++
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	CLC
	ADC #$08
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	PHX
	LDA wm_SpriteNum,X
	TAX
	LDA #$FE
	CPX #$3E
	BEQ +
	LDA #$EE
	CPX #$BD
	BEQ +
	CPX #$04
	BCC +
	LDA #$C7
	CPX #$0F
	BCS +
	LDA #$4D
+	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	PLX
	LDA wm_SpriteProp
	ORA wm_SpritePal,X
	STA wm_OamSlot.1.Prop,Y
	ORA #$40
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
++	RTS

PSwitch:
	LDA wm_SpriteDecTbl4,X
	CMP #$01
	BNE ++
	STA wm_MapData.MarioMap
	STA wm_MapSave.MarioMap
	STZ wm_SpriteStatus,X
	INC wm_MsgBoxTrig
++	RTS

DATA_01E76F:
	.DB -4,4,-2,2,-5,5,-3,3
	.DB -6,6,-4,4,-5,5,-3,3

DATA_01E77F:
	.DB 0,-1,3,4,-1,-2,4,3
	.DB -2,-1,3,3,-1,0,3,3
	.DB -8,-4,0,4

DATA_01E793:
	.DB $0E,$0F,$10,$11,$12,$11,$10,$0F
	.DB $1A,$1B,$1C,$1D,$1E,$1D,$1C,$1B
	.DB $1A

LakituCloud:
	LDA wm_SpritesLocked
	BEQ NoCloudGfx
_01E7A8:
	JMP _LakituCloudGfx

NoCloudGfx:
	LDY wm_StolenCloudTimer
	BEQ +
	LDA wm_FrameB
	AND #$03
	BNE +
	LDA wm_StolenCloudTimer
	BEQ +
	DEC wm_StolenCloudTimer
	BNE +
	LDA #$1F
	STA wm_SpriteDecTbl1,X
+	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01E7DB
	DEC A
	BNE _01E7A8
	STZ wm_SpriteStatus,X
	LDA #$FF
	STA wm_TimeTillRespawn
	LDA #$1E
	STA wm_SpriteToRespawn
	RTS

CODE_01E7DB:
	LDY #$09
_01E7DD:
	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE CODE_01E7F2
	LDA.W wm_SpriteNum,Y
	CMP #$1E
	BNE CODE_01E7F2
	TYA
	STA wm_SpriteMiscTbl8,X
	JMP CODE_01E898

CODE_01E7F2:
	DEY
	BPL _01E7DD
	LDA wm_SpriteState,X
	BNE CODE_01E840
	LDA wm_SpriteMiscTbl3,X
	BEQ +
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
+	LDA wm_SpriteDecTbl2,X
	BNE ++
	JSR ProcessInteract
	BCC ++
	LDA wm_MarioSpeedY
	BMI ++
	INC wm_SpriteState,X
	LDA #$11
	LDY wm_OnYoshi
	BEQ +
	LDA #$22
+	CLC
	ADC wm_PlayerYPosLv
	STA wm_SpriteYLo,X
	LDA wm_PlayerYPosLv+1
	ADC #$00
	STA wm_SpriteYHi,X
	LDA wm_PlayerXPosLv
	STA wm_SpriteXLo,X
	LDA wm_PlayerXPosLv+1
	STA wm_SpriteXHi,X
	LDA #$10
	STA wm_SpriteSpeedY,X
	STA wm_SpriteMiscTbl3,X
	LDA wm_MarioSpeedX
	STA wm_SpriteSpeedX,X
++	JMP _LakituCloudGfx

CODE_01E840:
	JSR _LakituCloudGfx
	PHB
	LDA #:ControlSprCarried
	PHA
	PLB
	JSL ControlSprCarried
	PLB
	LDA wm_SpriteSpeedY,X
	CLC
	ADC #$03
	STA wm_MarioSpeedY
	LDA wm_FrameB
	LSR
	LSR
	LSR
	AND #$07
	TAY
	LDA wm_OnYoshi
	BEQ +
	TYA
	CLC
	ADC #$08
	TAY
+	LDA wm_PlayerXPosLv
	STA wm_SpriteXLo,X
	LDA wm_PlayerXPosLv+1
	STA wm_SpriteXHi,X
	LDA wm_PlayerYPosLv
	CLC
	ADC DATA_01E793,Y
	STA wm_SpriteYLo,X
	LDA wm_PlayerYPosLv+1
	ADC #$00
	STA wm_SpriteYHi,X
	STZ wm_IsFlying
	INC wm_IsOnSolidSpr
	INC wm_IsInLakituCloud
	LDA wm_JoyFrameA
	AND #$80
	BEQ _Return01E897
	LDA #$C0
	STA wm_MarioSpeedY
	LDA #$10
	STA wm_SpriteDecTbl2,X
	STZ wm_SpriteState,X
_Return01E897:
	RTS

CODE_01E898:
	PHY
	JSR CODE_01E98D
	LDA wm_FrameB
	LSR
	LSR
	LSR
	AND #$07
	TAY
	LDA DATA_01E793,Y
	STA m0
	PLY
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC m0
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,Y
	LDA #$10
	STA wm_SpriteDecTbl2,X
_LakituCloudGfx:
	JSR GetDrawInfoBnk1
	LDA wm_OffscreenVert,X
	BNE _Return01E897
	LDA #$F8
	STA m12
	LDA #$FC
	STA m13
	LDA #$00
	LDY wm_SpriteState,X
	BNE +
	LDA #$30
+	STA m14
	STA wm_18B6
	ORA #$04
	STA m15
	LDA m0
	STA wm_ChainCentX
	LDA m1
	STA wm_ChainCentY
	LDA wm_FrameB
	LSR
	LSR
	AND #$0C
	STA m2
	LDA #$03
	STA m3
-	LDA m3
	TAX
	LDY m12,X
	CLC
	ADC m2
	TAX
	LDA.W DATA_01E76F,X
	CLC
	ADC wm_ChainCentX
	STA wm_OamSlot.1.XPos,Y
	LDA.W DATA_01E77F,X
	CLC
	ADC wm_ChainCentY
	STA wm_OamSlot.1.YPos,Y
	LDX wm_SprProcessIndex
	LDA #$60
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LSR
	LSR
	LSR
	TAX
	LDA.W CloudTiles,X
	STA wm_OamSlot.1.Tile,Y
+	LDA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEC m3
	BPL -
	LDX wm_SprProcessIndex
	LDA #$F8
	STA wm_SprOAMIndex,X
	LDY #$02
	LDA #$01
	JSR FinishOAMWriteRt
	LDA wm_18B6
	STA wm_SprOAMIndex,X
	LDY #$02
	LDA #$01
	JSR FinishOAMWriteRt
	LDA wm_OffscreenHorz,X
	BNE _Return01E984
	LDA wm_ChainCentX
	CLC
	ADC #$04
	STA wm_ExOamSlot.3.XPos
	LDA wm_ChainCentY
	CLC
	ADC #$07
	STA wm_ExOamSlot.3.YPos
	LDA #$4D
	STA wm_ExOamSlot.3.Tile
	LDA #$39
	STA wm_ExOamSlot.3.Prop
	LDA #$00
	STA wm_ExOamSize.3
_Return01E984:
	RTS

CloudTiles:	.DB $66,$64,$62,$60

DATA_01E989:	.DB 32,-32

DATA_01E98B:	.DB 16,-16

CODE_01E98D:
	LDA wm_SpritesLocked
	BNE _Return01E984
	JSR SubHorizPos
	TYA
	LDY wm_SpriteMiscTbl8,X
	STA wm_SpriteDir,Y
	STA m0
	LDY m0
	LDA wm_AppearSprTimer
	BEQ ++
	PHY
	PHX
	LDA wm_SpriteMiscTbl8,X
	TAX
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteStatus,X
	PLX
	CMP #$00
	BNE +
	STZ wm_SpriteStatus,X
+	PLY
	TYA
	EOR #$01
	TAY
++	LDA wm_FrameA
	AND #$01
	BNE ++
	LDA wm_SpriteSpeedX,X
	CMP DATA_01E989,Y
	BEQ +
	CLC
	ADC DATA_01EBB4,Y
	STA wm_SpriteSpeedX,X
+	LDA wm_SpriteMiscTbl5,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_01EBBC-8,Y
	STA wm_SpriteSpeedY,X
	CMP DATA_01E98B,Y
	BNE ++
	INC wm_SpriteMiscTbl5,X
++	LDA wm_SpriteSpeedX,X
	PHA
	LDY wm_AppearSprTimer
	BNE ++
	LDA wm_L1CurXChange
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpriteSpeedX,X
	STA wm_SpriteSpeedX,X
++	JSR SubSprXPosNoGrvty
	PLA
	STA wm_SpriteSpeedX,X
	JSR SubSprYPosNoGrvty
	LDY wm_SpriteMiscTbl8,X
	LDA wm_FrameA
	AND #$7F
	ORA wm_SpriteMiscTbl3,Y
	BNE +
	LDA #$20
	STA wm_SpriteDecTbl3,Y
	JSR CODE_01EA21
+	RTS

DATA_01EA17:	.DB 16,-16

CODE_01EA19:
	PHB
	PHK
	PLB
	JSR CODE_01EA21
	PLB
	RTL

CODE_01EA21:
	JSL FindFreeSprSlot
	BMI ++
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA wm_SilverPowTimer
	CMP #$01
	LDA #$14
	BCC +
	LDA #$21
+	STA.W wm_SpriteNum,Y
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
	LDA #$D8
	STA wm_SpriteSpeedY,X
	JSR SubHorizPos
	LDA DATA_01EA17,Y
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteNum,X
	CMP #$21
	BNE +
	LDA #$02
	STA wm_SpritePal,X
+	TXY
	PLX
++	RTS

CODE_01EA70:
	LDX wm_LooseYoshiFlag
	BEQ +
	STZ wm_PlayerImgYPos
	STZ wm_YoshiHasKey
	LDA wm_SprProcessIndex
	PHA
	DEX
	STX wm_SprProcessIndex
	PHB
	PHK
	PLB
	JSR CODE_01EA8F
	PLB
	PLA
	STA wm_SprProcessIndex
+	RTL

CODE_01EA8F:
	LDA wm_YoshiGrowTimer
	ORA wm_CutsceneNum
	BEQ CODE_01EA9A
	JMP _01EB48

CODE_01EA9A:
	STZ wm_IsYoshiDucking
	LDA wm_SpriteState,X
	CMP #$02
	BCC CODE_01EAA7
	LDA #$30
	BRA _01EAB2

CODE_01EAA7:
	LDY #$00
	LDA wm_MarioSpeedX
	BEQ CODE_01EADF
	BPL _01EAB2
	EOR #$FF
	INC A
_01EAB2:
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA wm_SpritesLocked
	BNE +
	DEC wm_SpriteMiscTbl6,X
	BPL +
	LDA DATA_01EDF5,Y
	STA wm_SpriteMiscTbl6,X
	DEC wm_YoshiWalkFrames
	BPL +
	LDA #$02
	STA wm_YoshiWalkFrames
+	LDY wm_YoshiWalkFrames
	LDA YoshiWalkFrames,Y
	TAY
	LDA wm_SpriteState,X
	CMP #$02
	BCS _01EB2E
	BRA _01EAE2

CODE_01EADF:
	STZ wm_SpriteMiscTbl6,X
_01EAE2:
	LDA wm_IsFlying
	BEQ CODE_01EAF0
	LDY #$02
	LDA wm_MarioSpeedY
	BPL CODE_01EAF0
	LDY #$05
	BRA CODE_01EAF0

CODE_01EAF0:
	LDA wm_SpriteDecTbl5,X
	BEQ +
	LDY #$03
+	LDA wm_IsFlying
	BNE _01EB21
	LDA wm_SpriteMiscTbl3,X
	BEQ CODE_01EB0C
	LDY #$07
	LDA wm_JoyPadA
	AND #$08
	BEQ +
	LDY #$06
+	BRA _01EB21

CODE_01EB0C:
	LDA wm_YoshiSquatTimer
	BEQ CODE_01EB16
	DEC wm_YoshiSquatTimer
	BRA _01EB1C

CODE_01EB16:
	LDA wm_JoyPadA
	AND #$04
	BEQ _01EB21
_01EB1C:
	LDY #$04
	INC wm_IsYoshiDucking
_01EB21:
	LDA wm_SpriteState,X
	CMP #$01
	BEQ _01EB2E
	LDA wm_SpriteMiscTbl3,X
	BNE _01EB2E
	LDY #$04
_01EB2E:
	LDA wm_OnYoshi
	BEQ +
	LDA wm_YoshiInPipe
	CMP #$01
	BNE +
	LDA wm_FrameA
	AND #$08
	LSR
	LSR
	LSR
	ADC #$08
	TAY
+	TYA
	STA wm_SpriteGfxTbl,X
_01EB48:
	LDA wm_SpriteState,X
	CMP #$01
	BNE ++
	LDY wm_SpriteDir,X
	LDA wm_MarioXPos
	CLC
	ADC YoshiPositionX,Y
	STA wm_SpriteXLo,X
	LDA wm_MarioXPos+1
	ADC DATA_01EDF3,Y
	STA wm_SpriteXHi,X
	LDY wm_SpriteGfxTbl,X
	LDA wm_MarioYPos
	CLC
	ADC #$10
	STA wm_SpriteYLo,X
	LDA wm_MarioYPos+1
	ADC #$00
	STA wm_SpriteYHi,X
	LDA DATA_01EDE4,Y
	STA wm_PlayerImgYPos
	LDA #$01
	LDY wm_SpriteGfxTbl,X
	CPY #$03
	BNE +
	INC A
+	STA wm_OnYoshi
	LDA #$01
	STA wm_OWHasYoshi
	LDA wm_SpritePal,X
	STA wm_YoshiColor
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_MarioDirection
++	LDA wm_SpriteProp
	PHA
	LDA wm_OnYoshi
	BEQ +
	LDA wm_YoshiInPipe
	BEQ +
	LDA wm_WarpingWithYoshi
	BNE ++
	LDA #$10
	STA wm_SpriteProp
+	JSR HandleOffYoshi
++	PLA
	STA wm_SpriteProp
	RTS

DATA_01EBB4:	.DB 1,-1,1,0,-1,0,32,-32

DATA_01EBBC:	.DB 10,14

DATA_01EBBE:	.DB -24,24

DATA_01EBC0:	.DB 16,-16

GrowingAniSequence:	.DB $0C,$0B,$0C,$0B,$0A,$0B,$0A,$0B

Yoshi:
	STZ wm_IsFrozen
	LDA wm_YoshiHasWings
	STA wm_YoshiHasWingsB
	STZ wm_YoshiHasWings
	STZ wm_YoshiHasStomp
	STZ wm_191B
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01EBE9
	STZ wm_OWHasYoshi
	JMP HandleOffYoshi

CODE_01EBE9:
	TXA
	INC A
	STA wm_YoshiSlot
	LDA wm_OnYoshi
	BNE CODE_01EC04
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteStatus,X
	BNE CODE_01EC04
	LDA wm_YoshiWingsAboveGrnd
	BNE +
	STZ wm_OWHasYoshi
+	RTS

CODE_01EC04:
	LDA wm_OnYoshi
	BEQ +
	LDA wm_YoshiInPipe
	BNE CODE_01EC61
+	LDA wm_YoshiLayTimer
	BNE CODE_01EC61
	LDA wm_YoshiGrowTimer
	BEQ CODE_01EC4C
	DEC wm_YoshiGrowTimer
	STA wm_SpritesLocked
	STA wm_IsFrozen
	CMP #$01
	BNE +
	STZ wm_SpritesLocked
	STZ wm_IsFrozen
	LDY wm_OWCharA
	LDA wm_MapData.MarioMap,Y
	DEC A
	ORA wm_YoshiSavedFlag
	ORA wm_ForceLoadLevel
	BNE +
	INC wm_YoshiSavedFlag
	LDA #$03
	STA wm_MsgBoxTrig
+	DEC A
	LSR
	LSR
	LSR
	TAY
	LDA GrowingAniSequence,Y
	STA wm_SpriteGfxTbl,X
	RTS

CODE_01EC4C:
	LDA wm_SpritesLocked
	BEQ CODE_01EC61
_01EC50:
	LDY wm_OnYoshi
	BEQ +
	LDY #$06
	STY wm_PlayerImgYPos
+	RTS

DATA_01EC5B:	.DB -16,16

DATA_01EC5D:	.DB -6,6

DATA_01EC5F:	.DB -1,0

CODE_01EC61:
	LDA wm_IsFlying
	BNE _01EC6A
	LDA wm_YoshiLayTimer
	BNE CODE_01EC6D
_01EC6A:
	JMP CODE_01ECE1

CODE_01EC6D:
	DEC wm_YoshiLayTimer
	CMP #$01
	BNE CODE_01EC78
	STZ wm_SpritesLocked
	BRA _01EC6A

CODE_01EC78:
	INC wm_IsFrozen
	JSR _01EC50
	STY wm_SpritesLocked
	CMP #$02
	BNE +
	JSL FindFreeSprSlot
	BPL CODE_01EC8B
+	RTS

CODE_01EC8B:
	LDA #$09
	STA wm_SpriteStatus,Y
	LDA #$2C
	STA.W wm_SpriteNum,Y
	PHY
	PHY
	LDY wm_SpriteDir,X
	STY m15
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_01EC5D,Y
	PLY
	STA.W wm_SpriteXLo,Y
	LDY wm_SpriteDir,X
	LDA wm_SpriteXHi,X
	ADC DATA_01EC5F,Y
	PLY
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDY m15
	LDA DATA_01EC5B,Y
	STA wm_SpriteSpeedX,X
	LDA #$F0
	STA wm_SpriteSpeedY,X
	LDA #$10
	STA wm_SpriteDecTbl2,X
	LDA wm_YoshiLaysSpr
	STA wm_SpriteMiscTbl3,X
	PLX
	RTS

CODE_01ECE1:
	LDA wm_SpriteState,X
	CMP #$01
	BNE CODE_01ECEA
	JMP _01ED70

CODE_01ECEA:
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ +
	JSR SetSomeYSpeed
	LDA wm_SpriteState,X
	CMP #$02
	BCS +
	STZ wm_SpriteSpeedX,X
	LDA #$F0
	STA wm_SpriteSpeedY,X
+	JSR UpdateDirection
	JSR IsTouchingObjSide
	BEQ +
	JSR _0190A2
+	LDA #$04
	CLC
	ADC wm_SpriteXLo,X
	STA m4
	LDA wm_SpriteXHi,X
	ADC #$00
	STA m10
	LDA #$13
	CLC
	ADC wm_SpriteYLo,X
	STA m5
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m11
	LDA #$08
	STA m7
	STA m6
	JSL GetMarioClipping
	JSL CheckForContact
	BCC _01ED70
	LDA wm_IsFlying
	BEQ _01ED70
	LDA wm_IsCarrying
	ORA wm_OnYoshi
	BNE _01ED70
	LDA wm_MarioSpeedY
	BMI _01ED70
	LDY #$01
	JSR _01EDCE
	STZ wm_MarioSpeedX
	STZ wm_MarioSpeedY
	LDA #$0C
	STA wm_YoshiSquatTimer
	LDA #$01
	STA wm_SpriteState,X
	LDA #$02
	STA wm_SoundCh2
	LDA #$1F
	STA wm_SoundCh3
	JSL DisabledAddSmokeRt
	LDA #$20
	STA wm_SpriteDecTbl6,X
	INC wm_SprChainStomped
_01ED70:
	LDA wm_SpriteState,X
	CMP #$01
	BNE ++
	JSR CODE_01F622
	LDA wm_JoyPadA
	AND #$03
	BEQ +
	DEC A
	CMP wm_SpriteDir,X
	BEQ +
	LDA wm_SpriteDecTbl5,X
	ORA wm_SpriteMiscTbl3,X
	ORA wm_IsYoshiDucking
	BNE +
	LDA #$10
	STA wm_SpriteDecTbl5,X
+	LDA wm_PBalloonFrame
	BNE +
	BIT wm_JoyFrameB
	BPL ++
+	LDA #$02
	STA wm_DisSprCapeContact,X
	STZ wm_SpriteState,X
	LDA #$03
	STA wm_SoundCh2
	STZ wm_OWHasYoshi
	LDA wm_MarioSpeedX
	STA wm_SpriteSpeedX,X
	LDA #$A0
	LDY wm_IsFlying
	BNE +
	JSR SubHorizPos
	LDA DATA_01EBC0,Y
	STA wm_MarioSpeedX
	LDA #$C0
+	STA wm_MarioSpeedY
	STZ wm_OnYoshi
	STZ wm_SpriteSpeedY,X
	JSR CODE_01EDCC
++	RTS

CODE_01EDCC:
	LDY #$00
_01EDCE:
	LDA wm_SpriteYLo,X
	SEC
	SBC DATA_01EDE2,Y
	STA wm_MarioYPos
	STA wm_PlayerYPosLv
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_MarioYPos+1
	STA wm_PlayerYPosLv+1
	RTS

DATA_01EDE2:	.DB 4,16

DATA_01EDE4:
	.DB 6,5,5,5,10,5,5,10
	.DB 10,11

YoshiWalkFrames:	.DB 2,1,0

YoshiPositionX:	.DB 2,-2

DATA_01EDF3:	.DB 0,-1

DATA_01EDF5:	.DB 3,2,1,0

YoshiHeadTiles:
	.DB $00,$01,$02,$03,$02,$10,$04,$05
	.DB $00,$00,$FF,$FF,$00

YoshiBodyTiles:
	.DB $06,$07,$08,$09,$0A,$0B,$06,$0C
	.DB $0A,$0D,$0E,$0F,$0C

YoshiHeadDispX:
	.DB 10,9,10,6,10,10,10,16
	.DB 10,10,0,0,10,-10,-9,-10
	.DB -6,-10,-10,-10,-16,-10,-10,0
	.DB 0,-10

DATA_01EE2D:
	.DB 0,0,0,0,0,0,0,0
	.DB 0,0,0,0,0,-1,-1,-1
	.DB -1,-1,-1,-1,-1,-1,-1,0
	.DB 0,-1

YoshiPositionY:
	.DB 0,1,1,0,4,0,0,4
	.DB 3,3,0,0,4

YoshiHeadDispY:
	.DB 0,0,1,0,0,0,0,8
	.DB 0,0,0,0,5

HandleOffYoshi:
	LDA wm_SpriteGfxTbl,X
	PHA
	LDY wm_SpriteDecTbl5,X
	CPY #$08
	BNE +
	LDA wm_YoshiInPipe
	ORA wm_SpritesLocked
	BNE +
	LDA wm_SpriteDir,X
	STA wm_MarioDirection
	EOR #$01
	STA wm_SpriteDir,X
+	LDA wm_YoshiInPipe
	BMI +
	CMP #$02
	BNE +
	INC A
	STA wm_SpriteGfxTbl,X
+	JSR CODE_01EF18
	LDY m14
	LDA wm_OamSlot.1.Tile,Y
	STA m0
	STZ m1
	LDA #$06
	STA wm_OamSlot.1.Tile,Y
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.Tile,Y
	STA m2
	STZ m3
	LDA #$08
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
	LDA m2
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC #$8500
	STA wm_0D85+8
	CLC
	ADC #$0200
	STA wm_0D85+18
	SEP #$20
	PLA
	STA wm_SpriteGfxTbl,X
	JSR CODE_01F0A2
	LDA wm_YoshiHasWingsB
	CMP #$02
	BCC _Return01EF17
	LDA wm_OnYoshi
	BEQ _01EF13
	LDA wm_IsFlying
	BNE CODE_01EF00
	LDA wm_MarioSpeedX
	BPL +
	EOR #$FF
	INC A
+	CMP #$28
	LDA #$01
	BCS _01EF13
	LDA #$00
	BRA _01EF13

CODE_01EF00:
	LDA wm_FrameB
	LSR
	LSR
	LDY wm_MarioSpeedY
	BMI +
	LSR
	LSR
+	AND #$01
	BNE _01EF13
	LDY #$21
	STY wm_SoundCh3
_01EF13:
	JSL CODE_02BB23
_Return01EF17:
	RTS

CODE_01EF18:
	LDY wm_SpriteGfxTbl,X
	STY wm_TempTileGen
	LDA YoshiHeadTiles,Y
	STA wm_SpriteGfxTbl,X
	STA m15
	LDA wm_SpriteYLo,X
	PHA
	CLC
	ADC YoshiPositionY,Y
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	ADC #$00
	STA wm_SpriteYHi,X
	TYA
	LDY wm_SpriteDir,X
	BEQ +
	CLC
	ADC #$0D
+	TAY
	LDA wm_SpriteXLo,X
	PHA
	CLC
	ADC YoshiHeadDispX,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	ADC DATA_01EE2D,Y
	STA wm_SpriteXHi,X
	LDA wm_SprOAMIndex,X
	PHA
	LDA wm_SpriteDecTbl5,X
	ORA wm_YoshiInPipe
	BEQ +
	LDA #$04
	STA wm_SprOAMIndex,X
+	LDA wm_SprOAMIndex,X
	STA m14
	JSR SubSprGfx2Entry1
	PHX
	LDY wm_SprOAMIndex,X
	LDX wm_TempTileGen
	LDA wm_OamSlot.1.YPos,Y
	CLC
	ADC.W YoshiHeadDispY,X
	STA wm_OamSlot.1.YPos,Y
	PLX
	PLA
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	LDY wm_TempTileGen
	LDA YoshiBodyTiles,Y
	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteYLo,X
	CLC
	ADC #$10
	STA wm_SpriteYLo,X
	BCC +
	INC wm_SpriteYHi,X
+	JSR SubSprGfx2Entry1
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	LDY m14
	LDA m15
	BPL +
	LDA #$F0
	STA wm_OamSlot.1.YPos,Y
+	LDA wm_SpriteState,X
	BNE CODE_01EFC6
	LDA wm_FrameB
	AND #$30
	BNE CODE_01EFDB
	LDA #$2A
	BRA _01EFFA

CODE_01EFC6:
	CMP #$02
	BNE CODE_01EFDB
	LDA wm_SpriteMiscTbl3,X
	ORA wm_CutsceneNum
	BNE CODE_01EFDB
	LDA wm_FrameB
	AND #$10
	BEQ _01EFFD
	BRA _01EFF8

Return01EFDA:
	RTS

CODE_01EFDB:
	LDA wm_SpriteMiscTbl7,X
	CMP #$03
	BEQ +
	LDA wm_SpriteMiscTbl3,X
	BEQ ++
	LDA wm_OamSlot.1.Tile,Y
	CMP #$24
	BEQ ++
+	LDA #$2A
	STA wm_OamSlot.1.Tile,Y
++	LDA wm_YoshiWhipTimer
	BEQ _01EFFD
_01EFF8:
	LDA #$0C
_01EFFA:
	STA wm_OamSlot.1.Tile,Y
_01EFFD:
	LDA wm_SpriteDecTbl4,X
	LDY wm_YoshiSwallowTimer
	BEQ +
	CPY #$26
	BCS CODE_01F038
	LDA wm_FrameB
	AND #$18
	BNE CODE_01F038
+	LDA wm_SpriteDecTbl4,X
	CMP #$00
	BEQ Return01EFDA
	LDY #$00
	CMP #$0F
	BCC _01F03A
	CMP #$1C
	BCC CODE_01F038
	BNE +
	LDA m14
	PHA
	JSL SetTreeTile
	JSR CODE_01F0D3
	PLA
	STA m14
+	INC wm_IsFrozen
	LDA #$00
	LDY #$2A
	BRA _01F03A

CODE_01F038:
	LDY #$04
_01F03A:
	PHA
	TYA
	LDY m14
	STA wm_OamSlot.1.Tile,Y
	PLA
	CMP #$0F
	BCS ++
	CMP #$05
	BCC ++
	SBC #$05
	LDY wm_SpriteDir,X
	BEQ +
	CLC
	ADC #$0A
+	LDY wm_SpriteGfxTbl,X
	CPY #$0A
	BNE +
	CLC
	ADC #$14
+	STA m2
	JSR IsSprOffScreen
	BNE ++
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	PHX
	LDX m2
	LDA m0
	CLC
	ADC.L DATA_03C176,X
	STA wm_OamSlot.1.XPos
	LDA m1
	CLC
	ADC.L DATA_03C19E,X
	STA wm_OamSlot.1.YPos
	LDA #$3F
	STA wm_OamSlot.1.Tile
	PLX
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.Prop,Y
	ORA #$01
	STA wm_OamSlot.1.Prop
	LDA #$00
	STA wm_OamSize.1
++	RTS

Return01F0A1:
	RTS

CODE_01F0A2:
	LDA wm_SpriteState,X
	CMP #$01
	BNE +
	JSL CODE_02D0D4
+	LDA wm_YoshiHasWingsB
	CMP #$01
	BEQ Return01F0A1
	LDA wm_YoshiTongueTimer
	CMP #$10
	BNE +
	LDA wm_YoshiWhipTimer
	BNE +
	LDA #$06
	STA wm_YoshiWhipTimer
+	LDA wm_SpriteMiscTbl7,X
	JSL ExecutePtr

Ptrs01F0CB:
	.DW CODE_01F14B
	.DW CODE_01F314
	.DW CODE_01F332
	.DW CODE_01F12E

CODE_01F0D3:
	LDA #$06
	STA wm_SoundCh1
	JSL CODE_05B34A
	LDA wm_BerryEatenType
	BEQ _Return01F12D
	STZ wm_BerryEatenType
	CMP #$01
	BNE CODE_01F0F9
	INC wm_RedBerriesAte
	LDA wm_RedBerriesAte
	CMP #$0A
	BNE _Return01F12D
	STZ wm_RedBerriesAte
	LDA #$74
	BRA _01F125

CODE_01F0F9:
	CMP #$03
	BNE CODE_01F116
	LDA #$29
	STA wm_SoundCh3
	LDA wm_TimerTens
	CLC
	ADC #$02
	CMP #$0A
	BCC +
	SBC #$0A
	INC wm_TimerHundreds
+	STA wm_TimerTens
	BRA _Return01F12D

CODE_01F116:
	INC wm_PinkBerriesAte
	LDA wm_PinkBerriesAte
	CMP #$02
	BNE _Return01F12D
	STZ wm_PinkBerriesAte
	LDA #$6A
_01F125:
	STA wm_YoshiLaysSpr
	LDY #$20
	STY wm_YoshiLayTimer
_Return01F12D:
	RTS

CODE_01F12E:
	LDA wm_SpriteDecTbl3,X
	BNE +
	STZ wm_SpriteMiscTbl7,X
+	RTS

YoshiShellAbility:
	.DB $00,$00,$01,$02,$00,$00,$01,$02
	.DB $01,$01,$01,$03,$02,$02

YoshiAbilityIndex:	.DB $03,$02,$02,$03,$01,$00

CODE_01F14B:
	LDA wm_YoshiWingsAboveGrnd
	BEQ +
	LDA #$02
	STA wm_YoshiHasWings
+	LDA wm_YoshiSwallowTimer
	BEQ ++
	LDY wm_SpriteMiscTbl8,X
	LDA.W wm_SpriteNum,Y
	CMP #$80
	BNE +
	INC wm_YoshiHasKey
+	CMP #$0D
	BCS ++
	PHY
	LDA wm_SprStompImmuneTbl,Y
	CMP #$01
	LDA #$03
	BCS +
	LDA wm_SpritePal,X
	LSR
	AND #$07
	TAY
	LDA YoshiAbilityIndex,Y
	ASL
	ASL
	STA m0
	PLY
	PHY
	LDA wm_SpritePal,Y
	LSR
	AND #$07
	TAY
	LDA YoshiAbilityIndex,Y
	ORA m0
	TAY
	LDA YoshiShellAbility,Y
+	PHA
	AND #$02
	STA wm_YoshiHasWings
	PLA
	AND #$01
	STA wm_YoshiHasStomp
	PLY
++	LDA wm_FrameB
	AND #$03
	BNE CODE_01F1C6
	LDA wm_YoshiSwallowTimer
	BEQ CODE_01F1C6
	DEC wm_YoshiSwallowTimer
	BNE CODE_01F1C6
	LDY wm_SpriteMiscTbl8,X
	LDA #$00
	STA wm_SpriteStatus,Y
	DEC A
	STA wm_SpriteMiscTbl8,X
	LDA #$1B
	STA wm_SpriteDecTbl4,X
	JMP CODE_01F0D3

CODE_01F1C6:
	LDA wm_YoshiWhipTimer
	BEQ CODE_01F1DF
	DEC wm_YoshiWhipTimer
	BNE _Return01F1DE
	INC wm_SpriteMiscTbl7,X
	STZ wm_SpriteMiscTbl3,X
	LDA #$FF
	STA wm_SpriteMiscTbl8,X
	STZ wm_SpriteDecTbl4,X
_Return01F1DE:
	RTS

CODE_01F1DF:
	LDA wm_SpriteState,X
	CMP #$01
	BNE _Return01F1DE
	BIT wm_JoyFrameA
	BVC _Return01F1DE
	LDA wm_YoshiSwallowTimer
	BNE CODE_01F1F1
	JMP CODE_01F309

CODE_01F1F1:
	STZ wm_YoshiSwallowTimer
	LDY wm_SpriteMiscTbl8,X
	PHY
	PHY
	LDY wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_01F305,Y
	PLY
	STA.W wm_SpriteXLo,Y
	LDY wm_SpriteDir,X
	LDA wm_SpriteXHi,X
	ADC DATA_01F307,Y
	PLY
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	LDA #$00
	STA.W wm_SpriteState,Y
	STA wm_SpriteEatenTbl,Y
	STA wm_SprChainKillTbl,Y
	LDA wm_IsYoshiDucking
	CMP #$01
	LDA #$0A
	BCC +
	LDA #$09
+	STA wm_SpriteStatus,Y
	PHX
	LDA wm_SpriteDir,X
	STA wm_SpriteDir,Y
	TAX
	BCC +
	INX
	INX
+	LDA.W DATA_01F2FF+2,X
	STA.W wm_SpriteSpeedX,Y
	LDA #$00
	STA.W wm_SpriteSpeedY,Y
	PLX
	LDA #$10
	STA wm_SpriteDecTbl3,X
	LDA #$03
	STA wm_SpriteMiscTbl7,X
	LDA #$FF
	STA wm_SpriteMiscTbl8,X
	LDA.W wm_SpriteNum,Y
	CMP #$0D
	BCS CODE_01F2DF
	LDA wm_SprStompImmuneTbl,Y
	BNE +
	LDA wm_SpritePal,Y
	AND #$0E
	CMP #$08
	BEQ +
	LDA wm_SpritePal,X
	AND #$0E
	CMP #$08
	BNE CODE_01F2DF
+	PHX
	TYX
	STZ wm_SpriteStatus,X
	LDA #$02
	STA m0
	JSR CODE_01F295
	JSR CODE_01F295
	JSR CODE_01F295
	PLX
	LDA #$17
	STA wm_SoundCh3
	RTS

CODE_01F295:
	JSR CODE_018EEF
	LDA #$11
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteXLo,X
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_ExSpriteYHi,Y
	LDA #$00
	STA wm_ExSprBehindTbl,Y
	PHX
	LDA wm_SpriteDir,X
	LSR
	LDX m0
	LDA.W DATA_01F2D9,X
	BCC +
	EOR #$FF
	INC A
+	STA wm_ExSprSpeedX,Y
	LDA.W DATA_01F2DC,X
	STA wm_ExSprSpeedY,Y
	LDA #$A0
	STA wm_ExSpriteTbl2,Y
	PLX
	DEC m0
	RTS

DATA_01F2D9:	.DB 40,36,36

DATA_01F2DC:	.DB 0,-8,8

CODE_01F2DF:
	LDA #$20
	STA wm_SoundCh1
	LDA wm_Tweaker1686,Y
	AND #$40
	BEQ +
	PHX
	LDX.W wm_SpriteNum,Y
	LDA.L SpriteToSpawn,X
	PLX
	STA.W wm_SpriteNum,Y
	PHX
	TYX
	JSL LoadSpriteTables
	PLX
+	RTS

DATA_01F2FF:	.DB 32,-32,48,-48,16,-16

DATA_01F305:	.DB 16,-16

DATA_01F307:	.DB 0,-1

CODE_01F309:
	LDA #$12
	STA wm_YoshiTongueTimer
	LDA #$21
	STA wm_SoundCh3
	RTS

CODE_01F314:
	LDA wm_SpriteMiscTbl3,X
	CLC
	ADC #$03
	STA wm_SpriteMiscTbl3,X
	CMP #$20
	BCS CODE_01F328
_01F321:
	JSR CODE_01F3FE
	JSR CODE_01F4B2
	RTS

CODE_01F328:
	LDA #$08
	STA wm_SpriteDecTbl3,X
	INC wm_SpriteMiscTbl7,X
	BRA _01F321

CODE_01F332:
	LDA wm_SpriteDecTbl3,X
	BNE _01F321
	LDA wm_SpriteMiscTbl3,X
	SEC
	SBC #$04
	BMI CODE_01F344
	STA wm_SpriteMiscTbl3,X
	BRA _01F321

CODE_01F344:
	STZ wm_SpriteMiscTbl3,X
	STZ wm_SpriteMiscTbl7,X
	LDY wm_SpriteMiscTbl8,X
	BMI +
	LDA wm_Tweaker1686,Y
	AND #$02
	BEQ CODE_01F373
	LDA #$07
	STA wm_SpriteStatus,Y
	LDA #$FF
	STA wm_YoshiSwallowTimer
	LDA.W wm_SpriteNum,Y
	CMP #$0D
	BCS +
	PHX
	TAX
	LDA.W SpriteToSpawn,X
	STA.W wm_SpriteNum,Y
	PLX
+	JMP _01F3FA

CODE_01F373:
	LDA #$00
	STA wm_SpriteStatus,Y
	LDA #$1B
	STA wm_SpriteDecTbl4,X
	LDA #$FF
	STA wm_SpriteMiscTbl8,X
	STY m0
	LDA.W wm_SpriteNum,Y
	CMP #$9D
	BNE +
	LDA.W wm_SpriteState,Y
	CMP #$03
	BNE +
	LDA #$74
	STA.W wm_SpriteNum,Y
	LDA wm_Tweaker167A,Y
	ORA #$40
	STA wm_Tweaker167A,Y
+	LDA.W wm_SpriteNum,Y
	CMP #$81
	BNE +
	LDA wm_SprStompImmuneTbl,Y
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA ChangingItemSprite,Y
	LDY m0
	STA.W wm_SpriteNum,Y
+	PHA
	LDY m0
	LDA wm_Tweaker167A,Y
	ASL
	ASL
	PLA
	BCC CODE_01F3DB
	PHX
	TYX
	STZ wm_SpriteState,X
	JSR _01C4BF
	PLX
	LDY wm_IsYoshiDucking
	LDA DATA_01F3D9,Y
	STA wm_SpriteGfxTbl,X
	JMP _01F321

DATA_01F3D9:	.DB 0,4

CODE_01F3DB:
	CMP #$7E
	BNE CODE_01F3F7
	LDA.W wm_SpriteState,Y
	BEQ CODE_01F3F7
	CMP #$02
	BNE +
	LDA #$08
	STA wm_MarioAnimation
	LDA #$03
	STA wm_SoundCh3
+	JSR _01F6CD
	JMP _01F321

CODE_01F3F7:
	JSR CODE_01F0D3
_01F3FA:
	JMP _01F321

Return01F3FD:
	RTS

CODE_01F3FE:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	ORA wm_YoshiInPipe
	BNE Return01F3FD
	LDY wm_SpriteGfxTbl,X
	LDA DATA_01F61A,Y
	STA wm_TempTileGen
	CLC
	ADC wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	LDA wm_SpriteDir,X
	BNE +
	TYA
	CLC
	ADC #$08
	TAY
+	LDA DATA_01F60A,Y
	STA m13
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC m13
	STA m0
	LDA wm_SpriteDir,X
	BNE CODE_01F43C
	BCS Return01F3FD
	BRA _01F43E

CODE_01F43C:
	BCC Return01F3FD
_01F43E:
	LDA wm_SpriteMiscTbl3,X
	STA WRDIVH
	STZ WRDIVL
	LDA #$04
	STA WRDIVB
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LDA wm_SpriteDir,X
	STA m7
	LSR
	LDA RDDIVH
	BCC +
	EOR #$FF
	INC A
+	STA m5
	LDA #$04
	STA m6
	LDY #$0C
_01F46A:
	LDA m0
	STA wm_ExOamSlot.1.XPos,Y
	CLC
	ADC m5
	STA m0
	LDA m5
	BPL CODE_01F47C
	BCC _Return01F4B1
	BRA _01F47E

CODE_01F47C:
	BCS _Return01F4B1
_01F47E:
	LDA m1
	STA wm_ExOamSlot.1.YPos,Y
	LDA m6
	CMP #$01
	LDA #$76
	BCS +
	LDA #$66
+	STA wm_ExOamSlot.1.Tile,Y
	LDA m7
	LSR
	LDA #$09
	BCS +
	ORA #$40
+	ORA wm_SpriteProp
	STA wm_ExOamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEC m6
	BPL _01F46A
_Return01F4B1:
	RTS

CODE_01F4B2:
	LDA wm_SpriteMiscTbl8,X
	BMI CODE_01F524
	LDY #$00
	LDA m13
	BMI CODE_01F4C3
	CLC
	ADC wm_SpriteMiscTbl3,X
	BRA _01F4CC

CODE_01F4C3:
	LDA wm_SpriteMiscTbl3,X
	EOR #$FF
	INC A
	CLC
	ADC m13
_01F4CC:
	SEC
	SBC #$04
	BPL +
	DEY
+	PHY
	CLC
	ADC wm_SpriteXLo,X
	LDY wm_SpriteMiscTbl8,X
	STA.W wm_SpriteXLo,Y
	PLY
	TYA
	ADC wm_SpriteXHi,X
	LDY wm_SpriteMiscTbl8,X
	STA wm_SpriteXHi,Y
	LDA #$FC
	STA m0
	LDA wm_Tweaker1662,Y
	AND #$40
	BNE +
	LDA wm_Tweaker190F,Y
	AND #$20
	BEQ +
	LDA #$F8
	STA m0
+	STZ m1
	LDA m0
	CLC
	ADC wm_TempTileGen
	BPL +
	DEC m1
+	CLC
	ADC wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC m1
	STA wm_SpriteYHi,Y
	LDA #$00
	STA.W wm_SpriteSpeedY,Y
	STA.W wm_SpriteSpeedX,Y
	INC A
	STA wm_SpriteEatenTbl,Y
	RTS

CODE_01F524:
	PHY
	LDY #$00
	LDA m13
	BMI CODE_01F531
	CLC
	ADC wm_SpriteMiscTbl3,X
	BRA _01F53A

CODE_01F531:
	LDA wm_SpriteMiscTbl3,X
	EOR #$FF
	INC A
	CLC
	ADC m13
_01F53A:
	CLC
	ADC #$00
	BPL +
	DEY
+	CLC
	ADC wm_SpriteXLo,X
	STA m0
	TYA
	ADC wm_SpriteXHi,X
	STA m8
	PLY
	LDA wm_TempTileGen
	CLC
	ADC #$02
	CLC
	ADC wm_SpriteYLo,X
	STA m1
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m9
	LDA #$08
	STA m2
	LDA #$04
	STA m3
	LDY #$0B
-	STY wm_CheckSprInter
	CPY wm_SprProcessIndex
	BEQ +
	LDA wm_SpriteMiscTbl8,X
	BPL +
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC +
	LDA wm_SprBehindScrn,Y
	BNE +
	PHY
	JSR TryEatSprite
	PLY
+	DEY
	BPL -
	JSL CODE_02B9FA
	RTS

TryEatSprite:
	PHX
	TYX
	JSL GetSpriteClippingA
	PLX
	JSL CheckForContact
	BCC _Return01F609
	LDA wm_Tweaker1686,Y
	LSR
	BCC EatSprite
	LDA #$01
	STA wm_SoundCh1
	RTS

EatSprite:
	LDA.W wm_SpriteNum,Y
	CMP #$70
	BNE +
	STY wm_TempTileGen
	LDA m1
	SEC
	SBC.W wm_SpriteYLo,Y
	CLC
	ADC #$00
	PHX
	TYX
	JSL RemovePokeySegment
	PLX
	JSL FindFreeSprSlot
	BMI _Return01F609
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$70
	STA.W wm_SpriteNum,Y
	LDA m0
	STA.W wm_SpriteXLo,Y
	LDA m8
	STA wm_SpriteXHi,Y
	LDA m1
	STA.W wm_SpriteYLo,Y
	LDA m9
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	LDX wm_TempTileGen
	LDA wm_SpriteState,X
	AND m13
	STA.W wm_SpriteState,Y
	LDA #$01
	STA wm_SpriteMiscTbl5,Y
	PLX
+	TYA
	STA wm_SpriteMiscTbl8,X
	LDA #$02
	STA wm_SpriteMiscTbl7,X
	LDA #$0A
	STA wm_SpriteDecTbl3,X
_Return01F609:
	RTS

DATA_01F60A:
	.DB $F5,$F5,$F5,$F5,$F5,$F5,$F5,$F0
	.DB $13,$13,$13,$13,$13,$13,$13,$18

DATA_01F61A:	.DB $08,$08,$08,$08,$08,$08,$08,$13

CODE_01F622:
	LDA wm_SpriteDecTbl6,X
	ORA wm_SpritesLocked
	BNE _Return01F667
	LDY #$0B
-	STY wm_CheckSprInter
	TYA
	EOR wm_FrameA
	AND #$01
	BNE +
	TYA
	CMP wm_SpriteMiscTbl8,X
	BEQ +
	CPY wm_SprProcessIndex
	BEQ +
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC +
	LDA.W wm_SpriteNum,Y ; fix, overwrite accumulator nintendo?
	LDA wm_SpriteStatus,Y
	CMP #$09
	BEQ +
	LDA wm_Tweaker167A,Y
	AND #$02
	ORA wm_SpriteEatenTbl,Y
	ORA wm_SprBehindScrn,Y
	BNE +
	JSR CODE_01F668
+	LDY wm_CheckSprInter
	DEY
	BPL -
_Return01F667:
	RTS

CODE_01F668:
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC _Return01F667
	LDA.W wm_SpriteNum,Y
	CMP #$9D
	BEQ _Return01F667
	CMP #$15
	BEQ CODE_01F69E
	CMP #$16
	BEQ CODE_01F69E
	CMP #$04
	BCS _01F6A3
	CMP #$02
	BEQ _01F6A3
	LDA wm_SpriteDecTbl6,Y
	BPL _01F6A3
_01F695:
	PHY
	PHX
	TYX
	JSR CODE_01B12A
	PLX
	PLY
	RTS

CODE_01F69E:
	LDA wm_SprInWaterTbl,Y
	BEQ _01F695
_01F6A3:
	LDA.W wm_SpriteNum,Y
	CMP #$BF
	BNE +
	LDA wm_MarioYPos
	SEC
	SBC.W wm_SpriteYLo,Y
	CMP #$E8
	BMI _Return01F6DC
+	LDA.W wm_SpriteNum,Y
	CMP #$7E
	BNE CODE_01F6DD
	LDA.W wm_SpriteState,Y
	BEQ _Return01F6DC
	CMP #$02
	BNE _01F6CD
	LDA #$08
	STA wm_MarioAnimation
	LDA #$03
	STA wm_SoundCh3
_01F6CD:
	LDA #$40
	STA wm_14AA
	LDA #$02
	STA wm_YoshiHasWings
	LDA #$00
	STA wm_SpriteStatus,Y
_Return01F6DC:
	RTS

CODE_01F6DD:
	CMP #$4E
	BEQ +
	CMP #$4D
	BNE ++
+	LDA.W wm_SpriteState,Y
	CMP #$02
	BCC _Return01F6DC
++	LDA m5
	CLC
	ADC #$0D
	CMP m1
	BMI ++
	LDA wm_SpriteStatus,Y
	CMP #$0A
	BNE +
	PHX
	TYX
	JSR SubHorizPos
	STY m0
	LDA wm_SpriteSpeedX,X
	PLX
	ASL
	ROL
	AND #$01
	CMP m0
	BNE ++
+	LDA wm_StarPowerTimer
	BNE ++
	LDA #$10
	STA wm_SpriteDecTbl6,X
	LDA #$03
	STA wm_SoundCh2
	LDA #$13
	STA wm_SoundCh3
	LDA #$02
	STA wm_SpriteState,X
	STZ wm_OnYoshi
	LDA #$C0
	STA wm_MarioSpeedY
	STZ wm_MarioSpeedX
	JSR SubHorizPos
	LDA DATA_01EBBE,Y
	STA wm_SpriteSpeedX,X
	STZ wm_SpriteMiscTbl7,X
	STZ wm_SpriteMiscTbl3,X
	STZ wm_YoshiWhipTimer
	STZ wm_OWHasYoshi
	LDA #$30
	STA wm_PlayerHurtTimer
	JSR CODE_01EDCC
++	RTS

CODE_01F74C:
	LDA #$08
	STA wm_SpriteStatus,X
_01F751:
	LDA #$20
	STA wm_SpriteDecTbl1,X
	LDA #$0A
	STA wm_SoundCh3
	RTL

DATA_01F75C:	.DB $00,$01,$01,$01

YoshiEggTiles:	.DB $62,$02,$02,$00

YoshiEgg:
	LDA wm_SprStompImmuneTbl,X
	BEQ CODE_01F799
	JSR IsSprOffScreen
	BNE ++
	JSR SubHorizPos
	LDA m15
	CLC
	ADC #$20
	CMP #$40
	BCS ++
	STZ wm_SprStompImmuneTbl,X
	JSL _01F751
	LDA #$2D
	LDY wm_LooseYoshiFlag
	BEQ +
	LDA #$78
+	STA wm_SpriteMiscTbl3,X
++	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA #$00
	STA wm_OamSlot.1.Tile,Y
	RTS

CODE_01F799:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01F7C2
	LSR
	LSR
	LSR
	TAY
	LDA YoshiEggTiles,Y
	PHA
	LDA DATA_01F75C,Y
	PHA
	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	PLA
	STA m0
	LDA wm_OamSlot.1.Prop,Y
	AND #$FE
	ORA m0
	STA wm_OamSlot.1.Prop,Y
	PLA
	STA wm_OamSlot.1.Tile,Y
	RTS

CODE_01F7C2:
	JSR CODE_01F7C8
	JMP CODE_01F83D

CODE_01F7C8:
	JSR IsSprOffScreen
	BNE +++
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteYLo,X
	STA m2
	LDA wm_SpriteYHi,X
	STA m3
	PHX
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
++	LDA #$03
	STA wm_MExSprNum,X
	LDA m0
	CLC
	ADC DATA_01F831,Y
	STA wm_MExSprXLo,X
	LDA m2
	CLC
	ADC DATA_01F82D,Y
	STA wm_MExSprYLo,X
	LDA m3
	STA wm_MExSprYHi,X
	LDA DATA_01F835,Y
	STA wm_MExSprYSpeed,X
	LDA DATA_01F839,Y
	STA wm_MExSprXSpeed,X
	TYA
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	ORA #$28
	STA wm_MExSprTimer,X
	DEY
	BPL --
	PLX
+++	RTS

DATA_01F82D:	.DB 0,0,8,8

DATA_01F831:	.DB 0,8,0,8

DATA_01F835:	.DB -24,-24,-12,-12

DATA_01F839:	.DB -6,6,-3,3

CODE_01F83D:
	LDA wm_SpriteMiscTbl3,X
	STA wm_SpriteNum,X
	CMP #$35
	BEQ CODE_01F86C
	CMP #$2D
	BNE CODE_01F867
	LDA #$09
	STA wm_SpriteStatus,X
	LDA wm_SpritePal,X
	AND #$0E
	PHA
	JSL InitSpriteTables
	PLA
	STA m0
	LDA wm_SpritePal,X
	AND #$F1
	ORA m0
	STA wm_SpritePal,X
	RTS

CODE_01F867:
	JSL InitSpriteTables
	RTS

CODE_01F86C:
	JSL InitSpriteTables
	JMP _01A2B5

UNK_01F873:	.DB 8,-8

UnusedInit:
	JSR _FaceMario
	STA wm_SpriteMiscTbl5,X
_Return01F87B:
	RTS

InitEerie:
	JSR SubHorizPos
	LDA EerieSpeedX,Y
	STA wm_SpriteSpeedX,X
_InitBigBoo:
	JSL GetRand
	STA wm_SpriteMiscTbl6,X
	RTS

EerieSpeedX:	.DB 16,-16

EerieSpeedY:	.DB 24,-24

Eerie:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _01F8C9
	LDA wm_SpritesLocked
	BNE _01F8C9
	JSR SubSprXPosNoGrvty
	LDA wm_SpriteNum,X
	CMP #$39
	BNE CODE_01F8C0
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_01EBBC-8,Y
	STA wm_SpriteSpeedY,X
	CMP EerieSpeedY,Y
	BNE +
	INC wm_SpriteState,X
+	JSR SubSprYPosNoGrvty
	JSR SubOffscreen3Bnk1
	BRA _01F8C3

CODE_01F8C0:
	JSR SubOffscreen0Bnk1
_01F8C3:
	JSR MarioSprInteractRt
	JSR SetAnimationFrame
_01F8C9:
	JSR UpdateDirection
	JMP SubSprGfx2Entry1

DATA_01F8CF:	.DB 8,-8

DATA_01F8D1:	.DB 1,2,2,1

BigBoo:
	JSR SubOffscreen1Bnk1
	LDA #$20
	BRA _01F8E1

BooBooBlock:
	JSR SubOffscreen0Bnk1
	LDA #$10
_01F8E1:
	STA wm_18B6
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE +
	LDA wm_SpritesLocked
	BEQ CODE_01F8F2
+	JMP _01F9CE

CODE_01F8F2:
	JSR SubHorizPos
	LDA wm_SpriteDecTbl1,X
	BNE ++
	LDA #$20
	STA wm_SpriteDecTbl1,X
	LDA wm_SpriteState,X
	BEQ +
	LDA m15
	CLC
	ADC #$0A
	CMP #$14
	BCC CODE_01F92F
+	STZ wm_SpriteState,X
	CPY wm_MarioDirection
	BNE ++
	INC wm_SpriteState,X
++	LDA m15
	CLC
	ADC #$0A
	CMP #$14
	BCC CODE_01F92F
	LDA wm_SpriteDecTbl5,X
	BNE CODE_01F971
	TYA
	CMP wm_SpriteDir,X
	BEQ CODE_01F92F
	LDA #$1F
	STA wm_SpriteDecTbl5,X
	BRA CODE_01F971

CODE_01F92F:
	STZ wm_SpriteGfxTbl,X
	LDA wm_SpriteState,X
	BEQ _01F989
	LDA #$03
	STA wm_SpriteGfxTbl,X
	LDY wm_SpriteNum,X
	CPY #$28
	BEQ +
	LDA #$00
	CPY #$AF
	BEQ +
	INC A
+	AND wm_FrameA
	BNE +++
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	BNE +
	LDA #$20
	STA wm_SpriteDecTbl3,X
+	LDA wm_SpriteSpeedX,X
	BEQ ++
	BPL +
	INC A
	INC A
+	DEC A
++	STA wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedY,X
	BEQ ++
	BPL +
	INC A
	INC A
+	DEC A
++	STA wm_SpriteSpeedY,X
+++	BRA _01F9C8

CODE_01F971:
	CMP #$10
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
	LDA DATA_01F8D1,Y
	STA wm_SpriteGfxTbl,X
_01F989:
	STZ wm_SpriteMiscTbl6,X
	LDA wm_FrameA
	AND #$07
	BNE _01F9C8
	JSR SubHorizPos
	LDA wm_SpriteSpeedX,X
	CMP DATA_01F8CF,Y
	BEQ +
	CLC
	ADC DATA_01EBB4,Y
	STA wm_SpriteSpeedX,X
+	LDA wm_PlayerYPosLv
	PHA
	SEC
	SBC wm_18B6
	STA wm_PlayerYPosLv
	LDA wm_PlayerYPosLv+1
	PHA
	SBC #$00
	STA wm_PlayerYPosLv+1
	JSR CODE_01AD42
	PLA
	STA wm_PlayerYPosLv+1
	PLA
	STA wm_PlayerYPosLv
	LDA wm_SpriteSpeedY,X
	CMP DATA_01F8CF,Y
	BEQ _01F9C8
	CLC
	ADC DATA_01EBBC-8,Y
	STA wm_SpriteSpeedY,X
_01F9C8:
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
_01F9CE:
	LDA wm_SpriteNum,X
	CMP #$AF
	BNE CODE_01FA3D
	LDA wm_SpriteSpeedX,X
	BPL +
	EOR #$FF
	INC A
+	LDY #$00
	CMP #$08
	BCS CODE_01FA09
	PHA
	LDA wm_Tweaker1662,X
	PHA
	LDA wm_Tweaker167A,X
	PHA
	ORA #$80
	STA wm_Tweaker167A,X
	LDA #$0C
	STA wm_Tweaker1662,X
	JSR CODE_01B457
	PLA
	STA wm_Tweaker167A,X
	PLA
	STA wm_Tweaker1662,X
	PLA
	LDY #$01
	CMP #$04
	BCS _01FA15
	INY
	BRA _01FA15

CODE_01FA09:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE _01FA15
	PHY
	JSR MarioSprInteractRt
	PLY
_01FA15:
	TYA
	STA wm_SpriteGfxTbl,X
	JSR SubSprGfx2Entry1
	LDA wm_SpriteGfxTbl,X
	LDY wm_SprOAMIndex,X
	PHX
	TAX
	LDA.W BooBlockTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$F1
	ORA.W BooBlockGfxProp,X
	STA wm_OamSlot.1.Prop,Y
	PLX
	RTS

BooBlockTiles:	.DB $8C,$C8,$CA

BooBlockGfxProp:	.DB $0E,$02,$02

CODE_01FA3D:
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE +
	JSR MarioSprInteractRt
+	JSL CODE_038398
	RTS

DATA_01FA4C:	.DB $40,$00

IggyBallTiles:	.DB $4A,$4C,$4A,$4C

DATA_01FA52:	.DB $35,$35,$F5,$F5

DATA_01FA56:	.DB 16,-16

IggysBall:
	JSR SubSprGfx2Entry1
	LDY wm_SpriteDir,X
	LDA DATA_01FA4C,Y
	STA m0
	LDY wm_SprOAMIndex,X
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	PHX
	TAX
	LDA.W IggyBallTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_01FA52,X
	EOR m0
	STA wm_OamSlot.1.Prop,Y
	PLX
	LDA wm_SpritesLocked
	BNE ++
	LDY wm_SpriteDir,X
	LDA DATA_01FA56,Y
	STA wm_SpriteSpeedX,X
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	CLC
	ADC #$04
	STA wm_SpriteSpeedY,X
+	JSR CODE_01FF98
	BCC +
	LDA #$F0
	STA wm_SpriteSpeedY,X
+	JSR MarioSprInteractRt
	LDA wm_SpriteYLo,X
	CMP #$44
	BCC ++
	CMP #$50
	BCS ++
	JSR _019ACB
++	RTS

UNK_01FAB4:
	.DB $FF,$01,$00,$80,$60,$A0,$40,$D0
	.DB $D8,$C0,$C8,$0C,$F4

KoopaKid:
	LDA wm_SpriteState,X
	JSL ExecutePtr

KoopaKidPtrs:
	.DW WallKoopaKids
	.DW WallKoopaKids
	.DW WallKoopaKids
	.DW PlatformKoopaKids
	.DW PlatformKoopaKids
	.DW PipeKoopaKids
	.DW PipeKoopaKids

DATA_01FAD5:
	.DB 0,-4,-8,-8,-8,-8,-8,-8
	.DB -8,-8,-8,-12,-16,-16,-20,-20

DATA_01FAE5:
	.DB $00,$01,$02,$00,$01,$02,$00,$01
	.DB $02,$00,$01,$02,$00,$01,$02,$01

PlatformKoopaKids:
	LDA wm_SpritesLocked
	ORA wm_SpriteDecTbl2,X
	BNE +
	JSR SubHorizPos
	STY m0
	LDA wm_M7Rotate
	ASL
	ROL
	AND #$01
	CMP m0
	BNE +
	INC wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl5,X
	AND #$7F
	BNE +
	LDA #$7F
	STA wm_SpriteDecTbl4,X
+	STZ wm_OffscreenHorz,X
	LDA wm_SpriteDecTbl6,X
	BEQ CODE_01FB36
	DEC A
	BNE +
	INC wm_CutsceneNum
	LDA #$FF
	STA wm_EndLevelTimer
	LDA #$0B
	STA wm_MusicCh1
	STZ wm_SpriteStatus,X
+	RTS

CODE_01FB36:
	JSL LoadTweakerBytes
	LDA wm_SpritesLocked
	BEQ CODE_01FB41
	JMP _01FC08

CODE_01FB41:
	LDA wm_SpriteMiscTbl8,X
	BEQ CODE_01FB7B
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	INC wm_SpriteSpeedY,X
	INC wm_SpriteSpeedY,X
+	LDA wm_SpriteYLo,X
	CMP #$58
	BCC +
	CMP #$80
	BCS +
	LDA #$20
	STA wm_SoundCh3
	LDA #$50
	STA wm_SpriteDecTbl6,X
	JSL KillMostSprites
+	LDA wm_SpriteXLo,X
	STA wm_ChainFirstX
	LDA wm_SpriteYLo,X
	STA wm_ChainFirstY
	JMP _01FC0E

CODE_01FB7B:
	JSR SubSprXPosNoGrvty
	LDA wm_FrameA
	AND #$1F
	ORA wm_SpriteDecTbl4,X
	BNE +
	LDA wm_SpriteDir,X
	PHA
	JSR _FaceMario
	PLA
	CMP wm_SpriteDir,X
	BEQ +
	LDA #$10
	STA wm_SpriteDecTbl5,X
+	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteSpeedX,X
	LDA wm_M7Rotate
	BPL +
	CLC
	ADC #$08
+	LSR
	LSR
	LSR
	LSR
	TAY
	STY m0
	EOR #$FF
	INC A
	AND #$0F
	STA m1
	LDA wm_SpriteDecTbl2,X
	BNE CODE_01FBD9
	LDA wm_M7Rotate+1
	BNE CODE_01FBC9
	LDA wm_SpriteXLo,X
	CMP #$78
	BCC CODE_01FBC5
	LDA #$FF
	BRA _01FBEE

CODE_01FBC5:
	LDA #$01
	BRA _01FBEE

CODE_01FBC9:
	LDY m1
	LDA wm_SpriteXLo,X
	CMP #$78
	BCS CODE_01FBD5
	LDA #$01
	BRA _01FBEE

CODE_01FBD5:
	LDA #$FF
	BRA _01FBEE

CODE_01FBD9:
	LDA wm_M7Rotate+1
	BNE CODE_01FBE7
	LDY m0
	LDA DATA_01FAD5+8,Y
	EOR #$FF
	INC A
	BRA _01FBEC

CODE_01FBE7:
	LDY m1
	LDA DATA_01FAD5+8,Y
_01FBEC:
	ASL
	ASL
_01FBEE:
	STA wm_SpriteSpeedX,X
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteSpeedX,X
	BEQ +
	INC wm_SpriteMiscTbl6,X
+	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	AND #$0F
	TAY
	LDA DATA_01FAE5,Y
	STA wm_SpriteGfxTbl,X
_01FC08:
	JSR CODE_01FD50
	JSR CODE_01FC62
_01FC0E:
	LDA wm_SpriteDecTbl2,X
	BNE CODE_01FC4E
	LDA wm_SpriteDir,X
	PHA
	LDY wm_SpriteDecTbl5,X
	BEQ ++
	CPY #$08
	BCC +
	EOR #$01
	STA wm_SpriteDir,X
+	LDA #$06
	STA wm_SpriteGfxTbl,X
++	LDA wm_SpriteDecTbl4,X
	BEQ +
	PHA
	LSR
	LSR
	LSR
	TAY
	LDA DATA_01FD95,Y
	STA wm_SpriteGfxTbl,X
	PLA
	CMP #$28
	BNE +
	LDA wm_SpritesLocked
	BNE +
	JSR ThrowBall
+	JSR CODE_01FEBC
	PLA
	STA wm_SpriteDir,X
	RTS

CODE_01FC4E:
	CMP #$10
	BCC CODE_01FC5A
_01FC52:
	LDA #$03
	STA wm_SpriteGfxTbl,X
	JMP CODE_01FEBC

CODE_01FC5A:
	CMP #$08
	BCC _01FC52
	JSR CODE_01FF5B
_Return01FC61:
	RTS

CODE_01FC62:
	LDA wm_MarioAnimation
	CMP #$01
	BCS _Return01FC61
	LDA wm_SpriteMiscTbl8,X
	BNE _Return01FC61
	LDA wm_SpriteXLo,X
	CMP #$20
	BCC +
	CMP #$D8
	BCC ++
+	LDA wm_ChainFirstX
	STA wm_SpriteXLo,X
	LDA wm_ChainFirstY
	STA wm_SpriteYLo,X
	INC wm_SpriteMiscTbl8,X
++	LDA wm_ChainFirstX
	SEC
	SBC #$08
	STA m0
	LDA wm_ChainFirstY
	CLC
	ADC #$60
	STA m1
	LDA #$0F
	STA m2
	LDA #$0C
	STA m3
	STZ m8
	STZ m9
	LDA wm_MarioScrPosX
	CLC
	ADC #$02
	STA m4
	LDA wm_MarioScrPosY
	CLC
	ADC #$10
	STA m5
	LDA #$0C
	STA m6
	LDA #$0E
	STA m7
	STZ m10
	STZ m11
	JSL CheckForContact
	BCC CODE_01FD0A
	LDA wm_SpriteDecTbl3,X
	BNE _Return01FD09
	LDA #$08
	STA wm_SpriteDecTbl3,X
	LDA wm_IsFlying
	BEQ CODE_01FD05
	LDA #$28
	STA wm_SoundCh3
	JSL BoostMarioSpeed
	LDA wm_SpriteXLo,X
	PHA
	LDA wm_SpriteYLo,X
	PHA
	LDA wm_ChainFirstX
	SEC
	SBC #$08
	STA wm_SpriteXLo,X
	LDA wm_ChainFirstY
	SEC
	SBC #$10
	STA wm_SpriteYLo,X
	STZ wm_OffscreenHorz,X
	JSL DisplayContactGfx
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXLo,X
	LDA wm_SpriteDecTbl2,X
	BNE _Return01FD09
	LDA #$18
	STA wm_SpriteDecTbl2,X
	RTS

CODE_01FD05:
	JSL HurtMario
_Return01FD09:
	RTS

CODE_01FD0A:
	LDY #$0A
-	STY wm_CheckSprInter
	LDA wm_ExSpriteNum,Y
	CMP #$05
	BNE +
	LDA wm_ExSpriteXLo,Y
	SEC
	SBC wm_Bg1HOfs
	STA m4
	STZ m10
	LDA wm_ExSpriteYLo,Y
	SEC
	SBC wm_Bg1VOfs
	STA m5
	STZ m11
	LDA #$08
	STA m6
	STA m7
	JSL CheckForContact
	BCC +
	LDA #$01
	STA wm_ExSpriteNum,Y
	LDA #$0F
	STA wm_ExSpriteTbl2,Y
	LDA #$01
	STA wm_SoundCh1
	LDA #$10
	STA wm_SpriteDecTbl2,X
+	DEY
	CPY #$07
	BNE -
	RTS

CODE_01FD50:
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_ChainCosX
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_BowserHurtTimer
	LDA wm_SpriteYLo,X
	CLC
	ADC #$2F
	STA wm_ChainSinY
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_BowserFireX
	REP #$20
	LDA wm_M7Rotate
	EOR #$01FF
	INC A
	AND #$01FF
	STA wm_M7Rotate
	SEP #$20
	PHX
	JSL CODE_01CC9D
	PLX
	REP #$20
	LDA wm_M7Rotate
	EOR #$01FF
	INC A
	AND #$01FF
	STA wm_M7Rotate
	SEP #$20
	RTS

DATA_01FD95:
	.DB $04,$0B,$0B,$0B,$0B,$0A,$0A,$09
	.DB $09,$08,$08,$07,$04,$05,$05,$05

BallPositionDispX:	.DB 8,-8

ThrowBall:
	LDY #$05
-	LDA wm_SpriteStatus,Y
	BEQ GenerateBall
	DEY
	BPL -
	RTS

GenerateBall:
	LDA #$20
	STA wm_SoundCh1
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$A7
	STA.W wm_SpriteNum,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	PHX
	LDA wm_SpriteDir,X
	STA wm_SpriteDir,Y
	TAX
	LDA wm_ChainFirstX
	SEC
	SBC #$08
	ADC.W BallPositionDispX,X
	STA.W wm_SpriteXLo,Y
	LDA #$00
	STA wm_SpriteXHi,Y
	LDA wm_ChainFirstY
	SEC
	SBC #$18
	STA.W wm_SpriteYLo,Y
	LDA #$00
	SBC #$00
	STA wm_SpriteYHi,Y
	PLX
	RTS

DATA_01FDF3:
	.DB $F7,$FF,$00,$F8,$F7,$FF,$00,$F8
	.DB $F8,$00,$00,$F8,$FB,$03,$00,$F8
	.DB $F8,$00,$00,$F8,$FA,$02,$00,$F8
	.DB $00,$00,$F8,$00,$00,$F8,$00,$F8
	.DB $00,$00,$00,$00,$FB,$F8,$00,$F8
	.DB $F4,$F8,$00,$F8,$00,$F8,$00,$F8
	.DB $09,$09,$00,$10,$09,$09,$00,$10
	.DB $08,$08,$00,$10,$05,$05,$00,$10
	.DB $08,$08,$00,$10,$06,$06,$00,$10
	.DB $00,$08,$08,$08,$00,$10,$00,$10
	.DB $00,$08,$00,$08,$05,$10,$00,$10
	.DB $0C,$10,$00,$10,$00,$10,$00,$10

DATA_01FE53:
	.DB $FA,$F2,$00,$09,$F9,$F1,$00,$08
	.DB $F8,$F0,$00,$08,$FE,$F6,$00,$08
	.DB $FC,$F4,$00,$08,$FF,$F7,$00,$08
	.DB $00,$F0,$F8,$F0,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$FC,$00,$00,$00
	.DB $F9,$00,$00,$00,$00,$08,$00,$08

DATA_01FE83:
	.DB $00,$0C,$02,$0A,$00,$0C,$22,$0A
	.DB $00,$0C,$20,$0A,$00,$0C,$20,$0A
	.DB $00,$0C,$20,$0A,$00,$0C,$20,$0A
	.DB $24,$1C,$04,$1C,$0E,$0D,$0E,$0D
	.DB $0E,$1D,$0E,$1D,$4A,$0D,$0E,$0D
	.DB $4A,$0D,$0E,$0D,$20,$0A,$20,$0A

DATA_01FEB3:	.DB $06,$02,$08

DATA_01FEB6:	.DB $02

DATA_01FEB7:	.DB $00,$02,$00,$37,$3B

CODE_01FEBC:
	LDY wm_SpriteState,X
	LDA DATA_01FEB7,Y
	STA m13
	STY m5
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDir,X
	LSR
	ROR
	LSR
	AND #$40
	EOR #$40
	STA m2
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	STA m3
	PHX
	LDX #$03
-	PHX
	TXA
	CLC
	ADC m3
	TAX
	PHX
	LDA m2
	BEQ +
	TXA
	CLC
	ADC #$30
	TAX
+	LDA wm_ChainFirstX
	SEC
	SBC #$08
	CLC
	ADC.W DATA_01FDF3,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA wm_ChainFirstY
	CLC
	ADC #$60
	CLC
	ADC.W DATA_01FE53,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_01FE83,X
	STA wm_OamSlot.1.Tile,Y
	PHX
	LDX m5
	CPX #$03
	BNE +
	CMP #$05
	BCS +
	LSR
	TAX
	LDA.W DATA_01FEB3,X
	STA wm_OamSlot.1.Tile,Y
+	LDA wm_OamSlot.1.Tile,Y
	CMP #$4A
	LDA m13
	BCC +
	LDA #$35
+	ORA m2
	STA wm_OamSlot.1.Prop,Y
	PLA
	AND #$03
	TAX
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_01FEB6,X
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
	LDY #$FF
	LDA #$03
	JSR FinishOAMWriteRt
	RTS

DATA_01FF53:	.DB $2C,$2E,$2C,$2E

DATA_01FF57:	.DB $00,$00,$40,$00

CODE_01FF5B:
	PHX
	LDY wm_SpriteState,X
	LDA DATA_01FEB7,Y
	STA m13
	LDY #$70
	LDA wm_ChainFirstX
	SEC
	SBC #$08
	STA wm_OamSlot.1.XPos,Y
	LDA wm_ChainFirstY
	CLC
	ADC #$60
	STA wm_OamSlot.1.YPos,Y
	LDA wm_FrameB
	LSR
	AND #$03
	TAX
	LDA.W DATA_01FF53,X
	STA wm_OamSlot.1.Tile,Y
	LDA #$30
	ORA.W DATA_01FF57,X
	ORA m13
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	PLX
	RTS

CODE_01FF98:
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_ChainCosX
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_BowserHurtTimer
	LDA wm_SpriteYLo,X
	CLC
	ADC #$0F
	STA wm_ChainSinY
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_BowserFireX
	PHX
	JSL CODE_01CC9D
	PLX
	RTS

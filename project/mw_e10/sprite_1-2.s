PipeKoopaKids:
	JSL CODE_03CC09
	RTS

InitKoopaKid:
	LDA wm_SpriteYLo,X
	LSR
	LSR
	LSR
	LSR
	STA wm_SpriteState,X
	CMP #$05
	BCC CODE_01CD4E
	LDA #$78
	STA wm_SpriteXLo,X
	LDA #$40
	STA wm_SpriteYLo,X
	LDA #$01
	STA wm_SpriteYHi,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
	RTS

CODE_01CD4E:
	LDY #$90
	STY wm_SpriteYLo,X
	CMP #$03
	BCC CODE_01CD5E
	JSL CODE_00FCF5
	JSR _FaceMario
	RTS

CODE_01CD5E:
	LDA #$01
	STA wm_SpriteDir,X
	LDA #$20
	STA wm_M7Scale
	STA wm_M7Scale+1
	JSL CODE_03DD7D
	LDY wm_SpriteState,X
	LDA DATA_01CD92,Y
	STA wm_SprStompImmuneTbl,X
	CMP #$01
	BEQ CODE_01CD87
	CMP #$00
	BNE +
	LDA #$70
	STA wm_SpriteXLo,X
+	LDA #$01
	STA wm_SpriteXHi,X
	RTS

CODE_01CD87:
	LDA #$26
	STA wm_SpriteMiscTbl5,X
	LDA #$D8
	STA wm_SpriteMiscTbl8,X
	RTS

DATA_01CD92:	.DB $01,$01,$00,$02,$02,$03,$03

DATA_01CD99:	.DB $00,$09,$12

DATA_01CD9C:
	.DB $00,$01,$02,$03,$04,$05,$06,$07
	.DB $08

DATA_01CDA5:	.DB $00,$80

CODE_01CDA7: ; Why not just JSR it in the main function?
	JSR GetDrawInfoBnk1
	RTS

WallKoopaKids:
	STZ wm_IsFrozen
	LDA wm_SpriteGfxTbl,X
	CMP #$1B
	BCS ++
	LDA wm_SpriteDecTbl5,X
	CMP #$08
	LDY wm_SpriteDir,X
	LDA DATA_01CDA5,Y
	BCS +
	EOR #$80
+	STA m0
	LDY wm_SpriteState,X
	LDA DATA_01CD99,Y
	LDY wm_SpriteGfxTbl,X
	CLC
	ADC DATA_01CD9C,Y
	CLC
	ADC m0
++	STA wm_M7BossProp
	JSL CODE_03DEDF
	JSR CODE_01CDA7
	LDA wm_SpritesLocked
	BNE _Return01CE3D
	JSR CODE_01D2A8
	JSR CODE_01D3B1
	LDA wm_SprStompImmuneTbl,X
	CMP #$01
	BEQ +
	LDA wm_SpriteDecTbl6,X
	BNE +
	LDA wm_SpriteDir,X
	PHA
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
	PLA
	CMP wm_SpriteDir,X
	BEQ +
	LDA #$10
	STA wm_SpriteDecTbl5,X
+	LDA wm_SpriteMiscTbl3,X
	JSL ExecutePtr

MortonPtrs1:
	.DW CODE_01CE1E
	.DW CODE_01CE3E
	.DW CODE_01CE5F
	.DW CODE_01CF7D
	.DW CODE_01CFE0
	.DW CODE_01D043

CODE_01CE1E:
	LDA wm_SprStompImmuneTbl,X
	CMP #$01
	BNE CODE_01CE34
	STZ wm_HorzScrollHead
	INC wm_BossLPillarStat
	STZ wm_BossLPillarYPos
	INC wm_SpritesLocked
	INC wm_SpriteMiscTbl3,X
	RTS

CODE_01CE34:
	LDA wm_Bg1HOfs
	CMP #$7E
	BCC _Return01CE3D
	INC wm_SpriteMiscTbl3,X
_Return01CE3D:
	RTS

CODE_01CE3E:
	STZ wm_MarioSpeedX
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	CLC
	ADC #$03
+	STA wm_SpriteSpeedY,X
	JSR CODE_01D0C0
	BCC _Return01CE3D
	INC wm_SpriteMiscTbl3,X
	LDA wm_SpriteState,X
	CMP #$02
	BCC _Return01CE3D
	JMP _01CEA8

CODE_01CE5F:
	LDA wm_SpriteState,X
	JSL ExecutePtr

MortonPtrs2:
	.DW CODE_01D116
	.DW CODE_01D116
	.DW CODE_01CE6B

CODE_01CE6B:
	LDA wm_SpriteMiscTbl4,X
	JSL ExecutePtr

Ptrs01CE72:
	.DW CODE_01CE78
	.DW CODE_01CEB6
	.DW CODE_01CEFD

CODE_01CE78:
	STZ wm_M7Rotate
	STZ wm_M7Rotate+1
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01CEA5
	LDY #$03
	AND #$30
	BNE +
	INY
+	TYA
	LDY wm_SpriteDecTbl5,X
	BEQ +
	LDA #$05
+	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	AND #$3F
	CMP #$2E
	BNE +
	LDA #$30
	STA wm_SpriteDecTbl6,X
	JSR CODE_01D059
+	RTS

CODE_01CEA5:
	INC wm_SpriteMiscTbl4,X
_01CEA8:
	LDA #$FF
	STA wm_SpriteDecTbl1,X
	RTS

DATA_01CEAE:	.DB 48,-48

DATA_01CEB0:	.DB $1B,$1C,$1D,$1B

DATA_01CEB4:	.DB 20,-20

CODE_01CEB6:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_01CEDC
	JSR SubHorizPos
	TYA
	CMP wm_SpriteXHi,X
	BNE CODE_01CEDC
	INC wm_SpriteMiscTbl4,X
	LDA DATA_01CEB4,Y
	STA wm_SpriteMiscTbl8,X
	LDA #$30
	STA wm_SpriteDecTbl1,X
	LDA #$60
	STA wm_SpriteDecTbl3,X
	LDA #$D8
	STA wm_SpriteSpeedY,X
	RTS

CODE_01CEDC:
	JSR SubHorizPos
	LDA wm_SpriteSpeedX,X
	CMP DATA_01CEAE,Y
	BEQ +
	CLC
	ADC DATA_01D4E7,Y
	STA wm_SpriteSpeedX,X
+	JSR SubSprXPosNoGrvty
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_01CEB0,Y
	STA wm_SpriteGfxTbl,X
	RTS

CODE_01CEFD:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01CF1C
	DEC A
	BNE +
	LDA wm_SpriteMiscTbl8,X
	STA wm_SpriteSpeedX,X
	LDA #$08
	STA wm_SoundCh3
+	LDA wm_SpriteSpeedX,X
	BEQ ++
	BPL +
	INC wm_SpriteSpeedX,X
	INC wm_SpriteSpeedX,X
+	DEC wm_SpriteSpeedX,X
++	RTS

CODE_01CF1C:
	JSR CODE_01D0C0
	BCC CODE_01CF2F
	LDA wm_SpriteSpeedY,X
	BMI CODE_01CF2F
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteMiscTbl4,X
	JMP _01CEA8

CODE_01CF2F:
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	LDA wm_FrameA
	LSR
	BCS ++
	LDA wm_SpriteSpeedY,X
	BMI +
	CMP #$70
	BCS ++
+	INC wm_SpriteSpeedY,X
++	LDA wm_SpriteDecTbl3,X
	BNE +
	LDA wm_M7Rotate
	ORA wm_M7Rotate+1
	BEQ ++
+	LDA wm_SpriteSpeedX,X
	ASL
	LDA #$04
	LDY #$00
	BCC +
	LDA #$FC
	DEY
+	CLC
	ADC wm_M7Rotate
	STA wm_M7Rotate
	TYA
	ADC wm_M7Rotate+1
	AND #$01
	STA wm_M7Rotate+1
++	LDA #$06
	LDY wm_SpriteSpeedY,X
	BMI +
	CPY #$08
	BCC +
	LDA #$05
	CPY #$10
	BCC +
	LDA #$02
+	STA wm_SpriteGfxTbl,X
	RTS

CODE_01CF7D:
	JSR SubSprYPosNoGrvty
	INC wm_SpriteSpeedY,X
	JSR CODE_01D0C0
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01CFB7
	CMP #$40
	BCC CODE_01CF9E
	BEQ CODE_01CFC6
	LDY #$06
	LDA wm_FrameB
	AND #$04
	BEQ +
	INY
+	TYA
	STA wm_SpriteGfxTbl,X
	RTS

CODE_01CF9E:
	LDY wm_18A6
	LDA wm_M7Scale
	CMP #$20
	BEQ +
	INC wm_M7Scale
+	LDA wm_M7Scale+1
	CMP #$20
	BEQ +
	DEC wm_M7Scale+1
+	LDA #$07
	STA wm_SpriteGfxTbl,X
	RTS

CODE_01CFB7:
	LDA #$02
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteState,X
	BEQ +
	LDA #$20
	STA wm_SprInWaterTbl,X
+	RTS

CODE_01CFC6:
	INC wm_SprChainKillTbl,X
	LDA wm_SprChainKillTbl,X
	CMP #$03
	BCC +
_01CFD0:
	LDA #$1F
	STA wm_SoundCh1
	LDA #$04
	STA wm_SpriteMiscTbl3,X
	LDA #$13
	STA wm_SpriteDecTbl1,X
+	RTS

CODE_01CFE0:
	LDY wm_SpriteDecTbl1,X
	BEQ CODE_01CFFC
	LDA wm_SpriteYLo,X
	SEC
	SBC #$01
	STA wm_SpriteYLo,X
	BCS +
	DEC wm_SpriteYHi,X
+	DEC wm_M7Scale+1
	TYA
	AND #$03
	BEQ +
	DEC wm_M7Scale
+	BRA _01D00F

CODE_01CFFC:
	LDA wm_M7Rotate
	CLC
	ADC #$06
	STA wm_M7Rotate
	LDA wm_M7Rotate+1
	ADC #$00
	AND #$01
	STA wm_M7Rotate+1
	INC wm_M7Scale
	INC wm_M7Scale+1
_01D00F:
	LDA wm_M7Scale+1
	CMP #$A0
	BCC ++
	LDA wm_OffscreenHorz,X
	BNE +
	LDA #$01
	STA wm_SmokeSprite
	LDA wm_SpriteXLo,X
	SBC #$08
	STA wm_SmokeXPos
	LDA wm_SpriteYLo,X
	ADC #$08
	STA wm_SmokeYPos
	LDA #$1B
	STA wm_SmokeTimer
+	LDA #$D0
	STA wm_SpriteYLo,X
	JSL CODE_03DEDF
	INC wm_SpriteMiscTbl3,X
	LDA #$30
	STA wm_SpriteDecTbl1,X
++	RTS

CODE_01D043:
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_CutsceneNum
	DEC wm_EndLevelTimer
	LDA #$0B
	STA wm_MusicCh1
	STZ wm_SpriteStatus,X
+	RTS

DATA_01D057:	.DB -1,-15

CODE_01D059:
	LDA #$17
	STA wm_SoundCh3
	LDY #$04
-	LDA wm_SpriteStatus,Y
	BEQ CODE_01D069
	DEY
	BPL -
	RTS

CODE_01D069:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$34
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	LDA wm_SpriteYLo,X
	CLC
	ADC #$03
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,Y
	LDA wm_SpriteDir,X
	PHX
	TAX
	LDA m0
	CLC
	ADC.W DATA_01D057,X
	STA.W wm_SpriteXLo,Y
	LDA m1
	ADC #$FF
	STA wm_SpriteXHi,Y
	PLX
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	PHX
	LDA wm_SpriteDir,X
	STA wm_SpriteDir,Y
	TAX
	LDA.W DATA_01D0BE,X
	STA.W wm_SpriteSpeedX,Y
	LDA #$30
	STA wm_SpriteDecTbl1,Y
	PLX
	RTS

DATA_01D0BE:	.DB 32,-32

CODE_01D0C0:
	LDA wm_SpriteSpeedY,X
	BMI CODE_01D0DC
	LDA wm_SpriteYHi,X
	BNE CODE_01D0DC
	LDA wm_M7Scale+1
	LSR
	TAY
	LDA wm_SpriteYLo,X
	CMP DATA_01D0DE-8,Y
	BCC CODE_01D0DC
	LDA DATA_01D0DE-8,Y
	STA wm_SpriteYLo,X
	STZ wm_SpriteSpeedY,X
	RTS

CODE_01D0DC:
	CLC
	RTS

DATA_01D0DE:
	.DB $80,$83,$85,$88,$8A,$8B,$8D,$8F
	.DB $90,$91,$91,$92,$92,$93,$93,$94
	.DB $94,$95,$95,$96,$96,$97,$97,$98
	.DB $98,$98,$99,$99,$9A,$9A,$9B,$9B
	.DB $9C,$9C,$9C,$9C,$9D,$9D,$9D,$9D
	.DB $9E,$9E,$9E,$9E,$9E,$9F,$9F,$9F
	.DB $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F

CODE_01D116:
	LDA wm_SpriteMiscTbl4,X
	JSL ExecutePtr

MortonPtrs3:
	.DW CODE_01D146
	.DW CODE_01D23F

Return01D121:
	RTS ; Unused

DATA_01D122:
	.DB -16,0,16,0,-16,0,16,0
	.DB -24,0,24,0

DATA_01D12E:
	.DB 0,-16,0,16,0,-16,0,16
	.DB 0,-24,0,24,38,38,-40,-40

DATA_01D13E:	.DB $90,$30,$30,$90

DATA_01D142:	.DB $00,$01,$02,$01

CODE_01D146:
	LDA wm_FrameB
	LSR
	LDY wm_SprChainKillTbl,X
	CPY #$02
	BCS +
	LSR
+	AND #$03
	TAY
	LDA DATA_01D142,Y
	LDY wm_SpriteDecTbl5,X
	BEQ +
	LDA #$05
+	STA wm_SpriteGfxTbl,X
	LDA wm_SprInWaterTbl,X
	BEQ +
	LDY wm_SpriteXLo,X
	CPY #$50
	BCC +
	CPY #$80
	BCS +
	DEC wm_SprInWaterTbl,X
	LSR
	BCS +
	INC wm_SpriteMiscTbl5,X
	DEC wm_SpriteMiscTbl8,X
+	LDA wm_SpriteMiscTbl5,X
	STA m5
	STA m6
	STA m11
	STA m12
	LDA wm_SpriteMiscTbl8,X
	STA m7
	STA m8
	STA m9
	STA m10
	LDA wm_M7Rotate
	ASL
	BEQ CODE_01D19A
	JMP _01D224

CODE_01D19A:
	LDY wm_SpriteMiscTbl7,X
	TYA
	LSR
	BCS CODE_01D1B5
	LDA wm_SpriteXLo,X
	CPY #$00
	BNE CODE_01D1AE
	CMP wm_SpriteMiscTbl5,X
	BCC CODE_01D215
	BRA _01D1D8

CODE_01D1AE:
	CMP wm_SpriteMiscTbl8,X
	BCS CODE_01D215
	BRA _01D1D8

CODE_01D1B5:
	LDA wm_SpriteDir,X
	BNE +
	INY
	INY
	INY
	INY
+	LDA.W m5,Y
	STA wm_SpriteXLo,X
	LDY wm_SpriteMiscTbl7,X
	LDA wm_SpriteYLo,X
	CPY #$03
	BEQ ADDR_01D1D3
	CMP DATA_01D13E,Y
	BCC CODE_01D215
	BRA _01D1D8

ADDR_01D1D3:
	CMP DATA_01D13E,Y
	BCS CODE_01D215
_01D1D8:
	LDA wm_SprChainKillTbl,X
	CMP #$02
	BCC +
	LDA #$02
+	ASL
	ASL
	ADC wm_SpriteMiscTbl7,X
	TAY
	LDA DATA_01D122,Y
	STA wm_SpriteSpeedX,X
	LDA DATA_01D12E,Y
	STA wm_SpriteSpeedY,X
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteMiscTbl7,X
	LDY wm_SpriteDir,X
	BNE +
	EOR #$02
+	CMP #$02
	BNE +
	JSR SubHorizPos
	LDA m15
	CLC
	ADC #$10
	CMP #$20
	BCS +
	INC wm_SpriteMiscTbl4,X
+	RTS

CODE_01D215:
	LDY wm_SpriteDir,X
	LDA wm_SpriteMiscTbl7,X
	CLC
	ADC DATA_01D23D,Y
	AND #$03
	STA wm_SpriteMiscTbl7,X
_01D224:
	LDY wm_SpriteDir,X
	LDA wm_M7Rotate
	CLC
	ADC DATA_01D239,Y
	STA wm_M7Rotate
	LDA wm_M7Rotate+1
	ADC DATA_01D23B,Y
	AND #$01
	STA wm_M7Rotate+1
	RTS

DATA_01D239:	.DB -4,4

DATA_01D23B:	.DB -1,0

DATA_01D23D:	.DB -1,1

CODE_01D23F:
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01D25E
	CMP #$01
	BNE _Return01D2A7
	STZ wm_SpriteMiscTbl4,X
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
	ASL
	EOR #$02
	STA wm_SpriteMiscTbl7,X
	LDA #$0A
	STA wm_SpriteDecTbl5,X
	RTS

CODE_01D25E:
	LDA #$06
	STA wm_SpriteGfxTbl,X
	JSR SubSprYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$70
	BCS +
	CLC
	ADC #$04
	STA wm_SpriteSpeedY,X
+	LDA wm_M7Rotate
	ORA wm_M7Rotate+1
	BEQ +
	LDA wm_M7Rotate
	CLC
	ADC #$08
	STA wm_M7Rotate
	LDA wm_M7Rotate+1
	ADC #$00
	AND #$01
	STA wm_M7Rotate+1
+	JSR CODE_01D0C0
	BCC _Return01D2A7
	LDA #$20
	STA wm_ShakeGrndTimer
	LDA wm_IsFlying
	BNE +
	LDA #$28
	STA wm_LockMarioTimer
+	LDA #$09
	STA wm_SoundCh3
	LDA #$28
	STA wm_SpriteDecTbl1,X
	STZ wm_M7Rotate
	STZ wm_M7Rotate+1
_Return01D2A7:
	RTS

CODE_01D2A8:
	LDA wm_SpriteMiscTbl3,X
	CMP #$03
	BCS ++
	LDA wm_SprStompImmuneTbl,X
	CMP #$03
	BNE +
	LDA wm_SpriteMiscTbl4,X
	CMP #$03
	BCS ++
+	JSL GetMarioClipping
	JSR CODE_01D40B
	JSL CheckForContact
	BCC ++
	LDA wm_DisSprCapeContact,X
	BNE ++
	LDA #$08
	STA wm_DisSprCapeContact,X
	LDA wm_IsFlying
	BEQ CODE_01D319
	LDA wm_SpriteGfxTbl,X
	CMP #$10
	BCS +
	CMP #$06
	BCS ADDR_01D31E
+	LDA wm_MarioYPos
	CLC
	ADC #$08
	CMP wm_SpriteYLo,X
	BCS ADDR_01D31E
	LDA wm_SpriteMiscTbl7,X
	LSR
	BCS CODE_01D334
	LDA wm_MarioSpeedY
	BMI _Return01D31D
	JSR CODE_01D351
	LDA #$D0
	STA wm_MarioSpeedY
	LDA #$02
	STA wm_SoundCh1
	LDA wm_SpriteGfxTbl,X
	CMP #$1B
	BCC CODE_01D379
_01D309:
	LDY #$20
	LDA wm_SpriteXLo,X
	SEC
	SBC #$08
	CMP wm_MarioXPos
	BMI +
	LDY #$E0
+	STY wm_MarioSpeedX
++	RTS

CODE_01D319:
	JSL HurtMario
_Return01D31D:
	RTS

ADDR_01D31E:
	LDA #$01
	STA wm_SoundCh1
	LDA wm_MarioSpeedY
	BPL ADDR_01D32C
	LDA #$10
	STA wm_MarioSpeedY
	RTS

ADDR_01D32C:
	JSR _01D309
	LDA #$D0
	STA wm_MarioSpeedY
	RTS

CODE_01D334:
	LDA #$01
	STA wm_SoundCh1
	LDA wm_MarioSpeedY
	BPL CODE_01D342
	LDA #$20
	STA wm_MarioSpeedY
	RTS

CODE_01D342:
	LDY #$20
	LDA wm_SpriteXLo,X
	BPL +
	LDY #$E0
+	STY wm_MarioSpeedX
	LDA #$B0
	STA wm_MarioSpeedY
	RTS

CODE_01D351:
	LDA wm_SpriteXLo,X
	PHA
	SEC
	SBC #$08
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	SBC #$00
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	PHA
	CLC
	ADC #$08
	STA wm_SpriteYLo,X
	JSL DisplayContactGfx
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	RTS

CODE_01D379:
	LDA #$18
	STA wm_M7Scale
	PHX
	LDA wm_M7Scale+1
	LSR
	TAX
	LDA #$28
	STA wm_M7Scale+1
	LSR
	TAY
	LDA DATA_01D0DE-8,Y
	SEC
	SBC.W DATA_01D0DE-8,X
	PLX
	CLC
	ADC wm_SpriteYLo,X
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
	LDA #$03
	STA wm_SpriteMiscTbl3,X
	LDA #$28
	STA wm_SoundCh3
	RTS

CODE_01D3B1:
	LDA wm_SpriteMiscTbl3,X
	CMP #$03
	BCS ++
	LDY #$0A
-	STY wm_CheckSprInter
	LDA wm_ExSpriteNum,Y
	CMP #$05
	BNE +
	LDA wm_ExSpriteXLo,Y
	STA m0
	LDA wm_ExSpriteXHi,Y
	STA m8
	LDA wm_ExSpriteYLo,Y
	STA m1
	LDA wm_ExSpriteYHi,Y
	STA m9
	LDA #$08
	STA m2
	STA m3
	PHY
	JSR CODE_01D40B
	PLY
	JSL CheckForContact
	BCC +
	LDA #$01
	STA wm_ExSpriteNum,Y
	LDA #$0F
	STA wm_ExSpriteTbl2,Y
	LDA #$01
	STA wm_SoundCh1
	INC wm_SprChainKillTbl,X
	LDA wm_SprChainKillTbl,X
	CMP #$0C
	BCC +
	JSR _01CFD0
+	DEY
	CPY #$07
	BNE -
++	RTS

CODE_01D40B:
	LDA wm_SpriteXLo,X
	SEC
	SBC #$08
	STA m4
	LDA wm_SpriteXHi,X
	SBC #$00
	STA m10
	LDA #$10
	STA m6
	LDA #$10
	STA m7
	LDA wm_SpriteGfxTbl,X
	CMP #$69
	LDA #$08
	BCC +
	ADC #$0A
+	CLC
	ADC wm_SpriteYLo,X
	STA m5
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m11
	RTS

DATA_01D439:	.DB $A8,$B0,$B8,$C0,$C8

ADDR_01D43E: ; Unreachable, might be oam index data
	STZ wm_SpriteStatus,X
	RTS

DATA_01D442:	.DB 0,-16,0,16

LudwigFireTiles:	.DB $4A,$4C,$6A,$6C

DATA_01D44A:	.DB $45,$45,$05,$05

BossFireball:
	LDA wm_SpritesLocked
	ORA wm_IsFrozen
	BNE ++
	LDA wm_SpriteDecTbl1,X
	CMP #$10
	BCS ++
	TAY
	BNE +
	JSR SetAnimationFrame
	JSR SetAnimationFrame
	JSR MarioSprInteractRt
+	JSR SubSprXPosNoGrvty
	LDA wm_SpriteXLo,X
	CLC
	ADC #$20
	STA m0
	LDA wm_SpriteXHi,X
	ADC #$00
	STA m1
	REP #$20
	LDA m0
	CMP #$0230
	SEP #$20
	BCC ++
	STZ wm_SpriteStatus,X
++	JSR GetDrawInfoBnk1
	LDA wm_SpriteGfxTbl,X
	ASL
	STA m3
	LDA wm_SpriteDir,X
	ASL
	STA m2
	LDA.W DATA_01D439,X
	STA wm_SprOAMIndex,X
	TAY
	PHX
	LDA wm_SpriteDecTbl1,X
	LDX #$01
	CMP #$08
	BCC _f
	DEX
__	PHX
	PHX
	TXA
	CLC
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W DATA_01D442,X
	STA wm_OamSlot.1.XPos,Y
	LDA wm_FrameB
	LSR
	LSR
	ROR
	AND #$80
	ORA.W DATA_01D44A,X
	STA wm_OamSlot.1.Prop,Y
	LDA m1
	INC A
	INC A
	STA wm_OamSlot.1.YPos,Y
	PLA
	CLC
	ADC m3
	TAX
	LDA.W LudwigFireTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL _b
	PLX
	LDY #$02
	LDA #$01
	JMP FinishOAMWriteRt

DATA_01D4E7:	.DB 1,-1

DATA_01D4E9:	.DB $0F,$00

DATA_01D4EB:
	.DB $00,$02,$04,$06,$08,$0A,$0C,$0E
	.DB $0E,$0C,$0A,$08,$06,$04,$02,$00

ParachuteSprites:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01D505
	JMP _01D671

CODE_01D505:
	LDA wm_SpritesLocked
	BNE CODE_01D558
	LDA wm_SpriteDecTbl1,X
	BNE CODE_01D558
	LDA wm_FrameA
	LSR
	BCC +
	INC wm_SpriteYLo,X
	BNE +
	INC wm_SpriteYHi,X
+	LDA wm_SpriteMiscTbl3,X
	BNE CODE_01D558
	LDA wm_FrameA
	LSR
	BCC +
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA wm_SpriteMiscTbl6,X
	CLC
	ADC DATA_01D4E7,Y
	STA wm_SpriteMiscTbl6,X
	CMP DATA_01D4E9,Y
	BNE +
	INC wm_SpriteState,X
+	LDA wm_SpriteSpeedX,X
	PHA
	LDY wm_SpriteMiscTbl6,X
	LDA wm_SpriteState,X
	LSR
	LDA DATA_01D4EB,Y
	BCC +
	EOR #$FF
	INC A
+	CLC
	ADC wm_SpriteSpeedX,X
	STA wm_SpriteSpeedX,X
	JSR SubSprXPosNoGrvty
	PLA
	STA wm_SpriteSpeedX,X
	BRA CODE_01D558

CODE_01D558:
	JSR SubOffscreen0Bnk1
	JMP CODE_01D5B3

DATA_01D55E:
	.DB 13,13,13,13,12,12,12,12
	.DB 12,12,12,12,13,13,13,13

DATA_01D56E:
	.DB 0,0,0,0,0,0,0,0
	.DB 1,1,1,1,1,1,1,1

DATA_01D57E:
	.DB -8,-8,-6,-6,-4,-4,-2,-2
	.DB 2,2,4,4,6,6,8,8

DATA_01D58E:
	.DB -1,-1,-1,-1,-1,-1,-1,-1
	.DB 0,0,0,0,0,0,0,0

DATA_01D59E:
	.DB 14,14,15,15,16,16,16,16
	.DB 16,16,16,16,15,15,14,14

DATA_01D5AE:	.DB 15,13

DATA_01D5B0:	.DB 1,5,0

CODE_01D5B3:
	STZ wm_TempTileGen
	LDY #$F0
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LSR
	EOR #$0F
	STA wm_TempTileGen
	CLC
	ADC #$F0
	TAY
+	STY m0
	LDA wm_SpriteYLo,X
	PHA
	CLC
	ADC m0
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	ADC #$FF
	STA wm_SpriteYHi,X
	LDA wm_SpritePal,X
	PHA
	AND #$F1
	ORA #$06
	STA wm_SpritePal,X
	LDY wm_SpriteMiscTbl6,X
	LDA DATA_01D55E,Y
	STA wm_SpriteGfxTbl,X
	LDA DATA_01D56E,Y
	STA wm_SpriteDir,X
	JSR SubSprGfx2Entry1
	PLA
	STA wm_SpritePal,X
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	LDY wm_SpriteMiscTbl6,X
	LDA wm_SpriteXLo,X
	PHA
	CLC
	ADC DATA_01D57E,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	ADC DATA_01D58E,Y
	STA wm_SpriteXHi,X
	STZ m0
	LDA DATA_01D59E,Y
	SEC
	SBC wm_TempTileGen
	BPL +
	DEC m0
+	CLC
	ADC wm_SpriteYLo,X
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC m0
	STA wm_SpriteYHi,X
	LDA wm_SpriteGfxTbl,X
	SEC
	SBC #$0C
	CMP #$01
	BNE +
	CLC
	ADC wm_SpriteDir,X
+	STA wm_SpriteGfxTbl,X
	LDA wm_SpriteDecTbl1,X
	BEQ +
	STZ wm_SpriteGfxTbl,X
+	LDY wm_SpriteGfxTbl,X
	LDA DATA_01D5B0,Y
	JSR SubSprGfx0Entry0
	JSR _SubSprSprMarioSpr
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01D693
	DEC A
	BNE CODE_01D681
	STZ wm_SpriteSpeedY,X
	PLA
	PLA
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
_01D671:
	LDA wm_SpriteNum,X
	SEC
	SBC #$3F
	TAY
	LDA DATA_01D5AE,Y
	STA wm_SpriteNum,X
	JSL LoadSpriteTables
	RTS

CODE_01D681:
	JSR CODE_019140
	JSR IsOnGround
	BEQ +
	JSR SetSomeYSpeed
+	JSR SubSprYPosNoGrvty
	INC wm_SpriteSpeedY,X
	BRA _01D6B5

CODE_01D693:
	TXA
	EOR wm_FrameA
	LSR
	BCC _01D6B5
	JSR CODE_019140
	JSR IsTouchingObjSide
	BEQ +
	LDA #$01
	STA wm_SpriteMiscTbl3,X
	LDA #$07
	STA wm_SpriteMiscTbl6,X
+	JSR IsOnGround
	BEQ _01D6B5
	LDA #$20
	STA wm_SpriteDecTbl1,X
_01D6B5:
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
_Return01D6C3:
	RTS

InitLineRope:
	CPX #$06
	BCC _01D6E0
	LDA wm_SpriteMemory
	BEQ _01D6E0
	INC wm_Tweaker1662,X
	BRA _01D6E0

InitLinePlat:
	LDA wm_SpriteXLo,X
	AND #$10
	EOR #$10
	STA wm_SpriteGfxTbl,X
	BEQ _01D6E0
	INC wm_Tweaker1662,X
_01D6E0:
	INC wm_SpriteDecTbl1,X
	JSR _LineFuzzyPlats
	JSR _LineFuzzyPlats
	INC wm_SprChainKillTbl,X
_Return01D6EC:
	RTS

InitLineGuidedSpr:
	INC wm_SprStompImmuneTbl,X
	LDA wm_SpriteXLo,X
	AND #$10
	BNE CODE_01D707
	LDA wm_SpriteXLo,X
	SEC
	SBC #$40
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	SBC #$01
	STA wm_SpriteXHi,X
	BRA _InitLineBrwnPlat

CODE_01D707:
	INC wm_SpriteDir,X
	LDA wm_SpriteXLo,X
	CLC
	ADC #$0F
	STA wm_SpriteXLo,X
_InitLineBrwnPlat:
	LDA #$02
	STA wm_SpriteDecTbl1,X
	RTS

DATA_01D717:	.DB -8,0

LineRopeChainsaw:
	TXA
	ASL
	ASL
	EOR wm_FrameB
	STA m2
	AND #$07
	ORA wm_SpritesLocked
	BNE _LineGrinder
	LDA m2
	LSR
	LSR
	LSR
	AND #$01
	TAY
	LDA DATA_01D717,Y
	STA m0
	LDA #$F2
	STA m1
	JSR _018063
_LineGrinder:
	LDA wm_FrameA
	AND #$07
	ORA wm_SprChainKillTbl,X
	ORA wm_SpritesLocked
	BNE _LineFuzzyPlats
	LDA #$04
	STA wm_SoundCh2
_LineFuzzyPlats:
	JMP CODE_01D9A7

CODE_01D74D:
	JSR SubOffscreen1Bnk1
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA wm_SpritesLocked
	ORA wm_SprChainKillTbl,X
	BNE _Return01D6EC
+	LDA wm_SpriteState,X
	JSL ExecutePtr

Ptrs01D762:
	.DW CODE_01D7F4
	.DW CODE_01D768
	.DW CODE_01DB44

CODE_01D768:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteDir,X
	BNE CODE_01D792
	LDY wm_SpriteMiscTbl5,X
	JSR CODE_01D7B0
	INC wm_SpriteMiscTbl5,X
	LDA wm_SprStompImmuneTbl,X
	BEQ +
	LDA wm_FrameA
	LSR
	BCC +
	INC wm_SpriteMiscTbl5,X
+	LDA wm_SpriteMiscTbl5,X
	CMP wm_SpriteMiscTbl6,X
	BCC ++
	STZ wm_SpriteState,X
++	RTS

CODE_01D792:
	LDY wm_SpriteMiscTbl6,X
	DEY
	JSR CODE_01D7B0
	DEC wm_SpriteMiscTbl6,X
	BEQ +
	LDA wm_SprStompImmuneTbl,X
	BEQ ++
	LDA wm_FrameA
	LSR
	BCC ++
	DEC wm_SpriteMiscTbl6,X
	BNE ++
+	STZ wm_SpriteState,X
++	RTS

CODE_01D7B0:
	PHB
	LDA #:GuidedLine ; Pretty sure here
	PHA
	PLB
	LDA wm_SpriteMiscTbl3,X
	STA m4
	LDA wm_SpriteMiscTbl4,X
	STA m5
	LDA (m4),Y
	AND #$0F
	STA m6
	LDA (m4),Y
	PLB
	LSR
	LSR
	LSR
	LSR
	STA m7
	LDA wm_SpriteYLo,X
	AND #$F0
	CLC
	ADC m7
	STA wm_SpriteYLo,X
	LDA wm_SpriteXLo,X
	AND #$F0
	CLC
	ADC m6
	STA wm_SpriteXLo,X
	RTS

DATA_01D7E1:	.DB -4,4,-4,4

DATA_01D7E5:	.DB -1,0,-1,0

DATA_01D7E9:	.DB -4,-4,4,4

DATA_01D7ED:	.DB -1,-1,0,0

CODE_01D7F1:
	JMP _01D89F

CODE_01D7F4:
	LDY #$03
_01D7F6:
	STY wm_CheckSprInter
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_01D7E1,Y
	STA m2
	LDA wm_SpriteXHi,X
	ADC DATA_01D7E5,Y
	STA m3
	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_01D7E9,Y
	STA m0
	LDA wm_SpriteYHi,X
	ADC DATA_01D7ED,Y
	STA m1
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA m0
	AND #$F0
	STA m4
	LDA wm_SpriteYLo,X
	AND #$F0
	CMP m4
	BNE +
	LDA m2
	AND #$F0
	STA m5
	LDA wm_SpriteXLo,X
	AND #$F0
	CMP m5
	BEQ _01D861
+	JSR CODE_01D94D
	BNE CODE_01D7F1
	LDA wm_Map16NumLo
	CMP #$94
	BEQ CODE_01D851
	CMP #$95
	BNE _01D856
	LDA wm_OnOffStatus
	BEQ _01D861
	BNE _01D856 ; [BRA FIX]

CODE_01D851:
	LDA wm_OnOffStatus
	BNE _01D861
_01D856:
	LDA wm_Map16NumLo
	CMP #$76
	BCC _01D861
	CMP #$9A
	BCC CODE_01D895
_01D861:
	LDY wm_CheckSprInter
	DEY
	BPL _01D7F6
	LDA wm_SpriteState,X
	CMP #$02
	BEQ ++
	LDA #$02
	STA wm_SpriteState,X
	LDY wm_SpriteMiscTbl8,X
	LDA wm_SpriteDir,X
	BEQ +
	TYA
	CLC
	ADC #$20
	TAY
+	LDA DATA_01DD11,Y
	BPL +
	ASL
+	PHY
	ASL
	STA wm_SpriteSpeedY,X
	PLY
	LDA DATA_01DD51,Y
	ASL
	STA wm_SpriteSpeedX,X
	LDA #$10
	STA wm_SpriteDecTbl1,X
++	RTS

CODE_01D895:
	PHA
	SEC
	SBC #$76
	TAY
	PLA
	CMP #$96
	BCC CODE_01D8A4
_01D89F:
	LDY wm_SpriteMiscTbl8,X
	BRA _01D8C8

CODE_01D8A4:
	LDA wm_SpriteYLo,X
	STA m8
	LDA wm_SpriteYHi,X
	STA m9
	LDA wm_SpriteXLo,X
	STA m10
	LDA wm_SpriteXHi,X
	STA m11
	LDA m0
	STA wm_SpriteYLo,X
	LDA m1
	STA wm_SpriteYHi,X
	LDA m2
	STA wm_SpriteXLo,X
	LDA m3
	STA wm_SpriteXHi,X
_01D8C8:
	PHB
	LDA #:GuidedLine
	PHA
	PLB
	LDA.W GuidedLine@Ptrs@L,Y
	STA wm_SpriteMiscTbl3,X
	LDA.W GuidedLine@Ptrs@H,Y
	STA wm_SpriteMiscTbl4,X
	PLB
	LDA DATA_01DCD1,Y
	STA wm_SpriteMiscTbl6,X
	STZ wm_SpriteMiscTbl5,X
	TYA
	STA wm_SpriteMiscTbl8,X
	LDA wm_SpriteDecTbl1,X
	BNE _01D933
	STZ wm_SpriteDir,X
	LDA DATA_01DCF1,Y
	BEQ CODE_01D8FF
	TAY
	LDA wm_SpriteYLo,X
	CPY #$01
	BNE +
	EOR #$0F
+	BRA _01D901

CODE_01D8FF:
	LDA wm_SpriteXLo,X
_01D901:
	AND #$0F
	CMP #$0A
	BCC +
	LDA wm_SpriteState,X
	CMP #$02
	BEQ +
	INC wm_SpriteDir,X
+	LDA wm_SpriteYLo,X
	STA m12
	LDA wm_SpriteXLo,X
	STA m13
	JSR CODE_01D768
	LDA m12
	SEC
	SBC wm_SpriteYLo,X
	CLC
	ADC #$08
	CMP #$10
	BCS CODE_01D938
	LDA m13
	SEC
	SBC wm_SpriteXLo,X
	CLC
	ADC #$08
	CMP #$10
	BCS CODE_01D938
_01D933:
	LDA #$01
	STA wm_SpriteState,X
	RTS

CODE_01D938:
	LDA m8
	STA wm_SpriteYLo,X
	LDA m9
	STA wm_SpriteYHi,X
	LDA m10
	STA wm_SpriteXLo,X
	LDA m11
	STA wm_SpriteXHi,X
	JMP _01D861

CODE_01D94D:
	LDA m0
	AND #$F0
	STA m6
	LDA m2
	LSR
	LSR
	LSR
	LSR
	PHA
	ORA m6
	PHA
	LDA wm_IsVerticalLvl
	AND #$01
	BEQ CODE_01D977
	PLA
	LDX m1
	CLC
	ADC.L DATA_00BA80,X
	STA m5
	LDA.L DATA_00BABC,X
	ADC m3
	STA m6
	BRA _01D989

CODE_01D977:
	PLA
	LDX m3
	CLC
	ADC.L DATA_00BA60,X
	STA m5
	LDA.L DATA_00BA9C,X
	ADC m1
	STA m6
_01D989:
	LDA #$7E
	STA m7
	LDX wm_SprProcessIndex
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	PLY
	STY m5
	PHA
	LDA m5
	AND #$07
	TAY
	PLA
	AND DATA_018000,Y
	RTS

CODE_01D9A7:
	LDA wm_SpriteNum,X
	CMP #$64
	BEQ CODE_01D9D3
	CMP #$65
	BCC CODE_01D9D0
	CMP #$68
	BNE CODE_01D9BA
	JSR CODE_01DBD4
	BRA _01D9C1

CODE_01D9BA:
	CMP #$67
	BNE CODE_01D9C6
	JSR CODE_01DC0B
_01D9C1:
	JSR MarioSprInteractRt
	BRA _01D9CD

CODE_01D9C6:
	JSR MarioSprInteractRt
	JSL CODE_03C263
_01D9CD:
	JMP CODE_01D74D

CODE_01D9D0:
	JMP CODE_01DAA2

CODE_01D9D3:
	JSR CODE_01DC54
	LDA wm_SpriteXLo,X
	PHA
	LDA wm_SpriteYLo,X
	PHA
	JSR CODE_01D74D
	PLA
	SEC
	SBC wm_SpriteYLo,X
	EOR #$FF
	INC A
	STA wm_TempTileGen
	PLA
	SEC
	SBC wm_SpriteXLo,X
	EOR #$FF
	INC A
	STA wm_18B6
	LDA wm_MarioObjStatus
	AND #$03
	BNE +
	JSR _01A80F
	BCS CODE_01DA0A
_01D9FE:
	LDA wm_SpriteDecTbl6,X
	BEQ +
	STZ wm_SpriteDecTbl6,X
	STZ wm_CanClimbAir
+	RTS

CODE_01DA0A:
	LDA wm_SpriteStatus,X
	BEQ ++
	LDA wm_IsCarrying
	ORA wm_OnYoshi
	BNE _01D9FE
	LDA #$03
	STA wm_SpriteDecTbl6,X
	LDA wm_SpriteDecTbl2,X
	BNE _Return01DA8F
	LDA wm_CanClimbAir
	BNE +
	LDA wm_JoyPadA
	AND #$08
	BEQ _Return01DA8F
	STA wm_CanClimbAir
+	BIT wm_JoyFrameA
	BPL +
	LDA #$B0
	STA wm_MarioSpeedY
++	STZ wm_CanClimbAir
	LDA #$10
	STA wm_SpriteDecTbl2,X
+	LDY #$00
	LDA wm_TempTileGen
	BPL +
	DEY
+	CLC
	ADC wm_MarioYPos
	STA wm_MarioYPos
	TYA
	ADC wm_MarioYPos+1
	STA wm_MarioYPos+1
	LDA wm_SpriteYLo,X
	STA m0
	LDA wm_SpriteYHi,X
	STA m1
	REP #$20
	LDA wm_MarioYPos
	SEC
	SBC m0
	CMP #$0000
	BPL +
	INC wm_MarioYPos
+	SEP #$20
	LDA wm_18B6
	JSR CODE_01DA90
	LDA wm_SpriteXLo,X
	SEC
	SBC #$08
	CMP wm_MarioXPos
	BEQ _01DA84
	BPL CODE_01DA7F
	LDA #$FF
	BRA _01DA81

CODE_01DA7F:
	LDA #$01
_01DA81:
	JSR CODE_01DA90
_01DA84:
	LDA wm_SprChainKillTbl,X
	BEQ _Return01DA8F
	STZ wm_SprChainKillTbl,X
	STZ wm_SpriteDecTbl1,X
_Return01DA8F:
	RTS

CODE_01DA90:
	LDY #$00
	CMP #$00
	BPL +
	DEY
+	CLC
	ADC wm_MarioXPos
	STA wm_MarioXPos
	TYA
	ADC wm_MarioXPos+1
	STA wm_MarioXPos+1
	RTS

CODE_01DAA2:
	LDY #$18
	LDA wm_SpriteGfxTbl,X
	BEQ +
	LDY #$28
+	STY m0
	LDA wm_SpriteXLo,X
	PHA
	SEC
	SBC m0
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	SBC #$00
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC #$08
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	JSR CODE_01B2DF
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	LDA wm_SpriteXLo,X
	PHA
	JSR CODE_01D74D
	PLA
	SEC
	SBC wm_SpriteXLo,X
	LDY wm_SpriteMiscTbl4,X
	PHY
	EOR #$FF
	INC A
	STA wm_SpriteMiscTbl4,X
	LDY #$18
	LDA wm_SpriteGfxTbl,X
	BEQ +
	LDY #$28
+	STY m0
	LDA wm_SpriteXLo,X
	PHA
	SEC
	SBC m0
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	SBC #$00
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	PHA
	SEC
	SBC #$08
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	JSR CODE_01B457
	BCC +
	LDA wm_SprChainKillTbl,X
	BEQ +
	STZ wm_SprChainKillTbl,X
	STZ wm_SpriteDecTbl1,X
+	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	PLA
	STA wm_SpriteMiscTbl4,X
	RTS

CODE_01DB44:
	LDA wm_SpritesLocked
	BNE +
	JSR SubUpdateSprPos
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA wm_SpriteSpeedY,X
	CMP #$20
	BMI +
	JSR CODE_01D7F4
+	RTS

DATA_01DB5A:	.DB 24,-24

Grinder:
	JSR CODE_01DBA2
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA #$04
	STA wm_SoundCh2
+	JSR SubOffscreen0Bnk1
	JSR MarioSprInteractRt
	LDY wm_SpriteDir,X
	LDA DATA_01DB5A,Y
	STA wm_SpriteSpeedX,X
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ +
	STZ wm_SpriteSpeedY,X
+	JSR IsTouchingObjSide
	BEQ ++
	JSR FlipSpriteDir
++	RTS

DATA_01DB96:	.DB -8,8,-8,8

DATA_01DB9A:	.DB 0,0,16,16

DATA_01DB9E:	.DB $03,$43,$83,$C3

CODE_01DBA2:
	JSR GetDrawInfoBnk1
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_01DB96,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_01DB9A,X
	STA wm_OamSlot.1.YPos,Y
	LDA wm_FrameB
	AND #$02
	ORA #$6C
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_01DB9E,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
_01DBD0:
	LDA #$03
	BRA _01DC03

CODE_01DBD4:
	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.XPos,Y
	SEC
	SBC #$08
	STA wm_OamSlot.1.XPos,Y
	LDA wm_OamSlot.1.YPos,Y
	SEC
	SBC #$08
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA wm_FrameB
	LSR
	LSR
	AND #$01
	TAX
	LDA #$C8
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_01DC09,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	LDA #$00
_01DC03:
	PLX
_01DC04:
	LDY #$02
	JMP FinishOAMWriteRt

DATA_01DC09:	.DB $05,$45

CODE_01DC0B:
	JSR GetDrawInfoBnk1
	PHX
	LDX #$03
-	LDA m0
	CLC
	ADC.W DATA_01DC3B,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_01DC3F,X
	STA wm_OamSlot.1.YPos,Y
	LDA wm_FrameB
	AND #$02
	ORA #$6C
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_01DC43,X
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEX
	BPL -
	BRA _01DBD0

DATA_01DC3B:	.DB -16,0,-16,0

DATA_01DC3F:	.DB -16,-16,0,0

DATA_01DC43:	.DB $33,$73,$B3,$F3

RopeMotorTiles:	.DB $C0,$C2,$E0,$C2

LineGuideRopeTiles:
	.DB $C0,$CE,$CE,$CE,$CE,$CE,$CE,$CE
	.DB $CE

CODE_01DC54:
	JSR GetDrawInfoBnk1
	LDA m0
	SEC
	SBC #$08
	STA m0
	LDA m1
	SEC
	SBC #$08
	STA m1
	TXA
	ASL
	ASL
	EOR wm_FrameB
	LSR
	LSR
	LSR
	AND #$03
	STA m2
	LDA #$05
	CPX #$06
	BCC +
	LDY wm_SpriteMemory
	BEQ +
	LDA #$09
+	STA m3
	LDY wm_SprOAMIndex,X
	LDX #$00
-	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$10
	STA m1
	LDA.W LineGuideRopeTiles,X
	CPX #$00
	BNE +
	PHX
	LDX m2
	LDA.W RopeMotorTiles,X
	PLX
+	STA wm_OamSlot.1.Tile,Y
	LDA #$37
	CPX #$01
	BCC +
	LDA #$31
+	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	INX
	CPX m3
	BNE -
	LDA #$DE
	STA wm_ExOamSlot.64.Tile,Y
	LDX wm_SprProcessIndex
	LDA #$04
	CPX #$06
	BCC +
	LDY wm_SpriteMemory
	BEQ +
	LDA #$08
+	JMP _01DC04

DATA_01DCD1:
	.DB $15,$15,$15,$15,$0C,$10,$10,$10
	.DB $10,$0C,$0C,$10,$10,$10,$10,$0C
	.DB $15,$15,$10,$10,$10,$10,$10,$10
	.DB $10,$10,$10,$10,$10,$10,$15,$15

DATA_01DCF1:
	.DB $00,$00,$00,$00,$00,$00,$01,$02
	.DB $00,$00,$00,$00,$02,$01,$00,$00
	.DB $00,$00,$01,$02,$01,$02,$00,$00
	.DB $00,$00,$02,$02,$00,$00,$00,$00

DATA_01DD11:
	.DB 0,16,0,-16,-12,-4,-16,16
	.DB 4,12,12,0,16,-16,-4,-12
	.DB -16,16,-16,16,-16,16,-8,-8
	.DB 8,8,16,16,0,0,-16,16
	.DB 16,0,-16,-16,12,4,16,-16
	.DB 0,-12,-12,-4,-16,16,0,12
	.DB 16,-16,16,0,16,-16,8,8
	.DB -8,-8,-16,-16,0,0,16,-16

DATA_01DD51:
	.DB 16,0,16,0,12,16,4,0
	.DB 16,12,12,16,4,0,16,12
	.DB 16,16,8,8,8,8,16,16
	.DB 16,16,0,0,16,16,16,16
	.DB 0,-16,0,-16,-12,-16,0,-4
	.DB -16,-12,-12,-16,0,-4,-16,-12
	.DB -16,-16,-8,-8,-8,-8,-16,-16
	.DB -16,-16,0,0,-16,-16,-16,-16

DATA_01DD91:	.DB 80,120,-96,-96,-96,120,80,80,120

DATA_01DD9B:	.DB -16,-16,-16,24,64,64,64,24,24

DATA_01DDA3:	.DB 3,0,0,1,1,2,2,3,-1

InitBonusGame:
	LDA wm_NoBonusGameFlag
	BEQ CODE_01DDB5
	STZ wm_SpriteStatus,X
	RTS

CODE_01DDB5:
	LDX #$09
-	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$82
	STA.W wm_SpriteNum,X
	LDA.W DATA_01DD91-1,X
	STA wm_SpriteXLo,X
	LDA #$00
	STA wm_SpriteXHi,X
	LDA.W DATA_01DD9B-1,X
	STA wm_SpriteYLo,X
	ASL
	LDA #$00
	BCS +
	INC A
+	STA wm_SpriteYHi,X
	JSL InitSpriteTables
	LDA.W DATA_01DDA3-1,X
	STA wm_SpriteDir,X
	TXA
	CLC
	ADC wm_FrameA
	AND #$07
	STA wm_SpriteMiscTbl6,X
	DEX
	BNE -
	STZ wm_BonusHasEnded
	STZ wm_Bonus1UpCount
	JSL GetRand
	EOR wm_FrameA
	ADC wm_FrameB
	AND #$07
	TAY
	LDA DATA_01DE21,Y
	STA wm_SpriteMiscTbl6.Spr10
	LDA #$01
	STA wm_SpriteState+9
	INC wm_NoBonusGameFlag
	LDX wm_SprProcessIndex
	RTS

DATA_01DE11:	.DB 16,0,-16,0

DATA_01DE15:	.DB 0,16,0,-16

DATA_01DE19:	.DB -96,-96,80,80

DATA_01DE1D:	.DB -16,64,64,-16

DATA_01DE21:
	.DB $01,$01,$01,$04,$04,$04,$07,$07
	.DB $07

BonusGame:
	STZ wm_OffscreenHorz,X
	CPX #$01
	BNE +
	JSR CODE_01E26A
+	JSR CODE_01DF19
	LDA wm_SpritesLocked
	BNE +
	LDA wm_BonusHasEnded
	BEQ CODE_01DE41
+	RTS

CODE_01DE41:
	LDA wm_SpriteState,X
	BNE ++
	LDA wm_FrameB
	AND #$03
	BNE +
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$09
	BNE +
	STZ wm_SpriteMiscTbl6,X
+	JSR MarioSprInteractRt
	BCC ++
	LDA wm_MarioSpeedY
	BPL ++
	LDA #$F4
	LDY wm_MarioPowerUp
	BEQ +
	LDA #$00
+	CLC
	ADC wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP wm_MarioScrPosY
	BCS ++
	LDA #$10
	STA wm_MarioSpeedY
	LDA #$0B
	STA wm_SoundCh1
	INC wm_SpriteState,X
	LDY wm_SpriteMiscTbl6,X
	LDA DATA_01DE21,Y
	STA wm_SpriteMiscTbl6,X
	LDA #$10
	STA wm_SpriteDecTbl1,X
++	LDY wm_SpriteDir,X
	BMI +
	LDA wm_SpriteXLo,X
	CMP DATA_01DE19,Y
	BNE _01DE9F
	LDA wm_SpriteYLo,X
	CMP DATA_01DE1D,Y
	BEQ CODE_01DEB0
_01DE9F:
	LDA DATA_01DE11,Y
	STA wm_SpriteSpeedX,X
	LDA DATA_01DE15,Y
	STA wm_SpriteSpeedY,X
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
+	RTS

CODE_01DEB0:
	LDY #$09
-	LDA.W wm_SpriteState,Y
	BEQ CODE_01DED7
	LDA.W wm_SpriteYLo,Y
	CLC
	ADC #$04
	AND #$F8
	STA.W wm_SpriteYLo,Y
	LDA.W wm_SpriteXLo,Y
	CLC
	ADC #$04
	AND #$F8
	STA.W wm_SpriteXLo,Y
	DEY
	BNE -
	INC wm_BonusHasEnded
	JSR CODE_01DFD9
	RTS

CODE_01DED7:
	LDA wm_SpriteDir,X
	INC A
	AND #$03
	TAY
	STA wm_SpriteDir,X
	BRA _01DE9F

DATA_01DEE3:
	.DB $58,$59,$83,$83,$48,$49,$58,$59
	.DB $83,$83,$48,$49,$34,$35,$83,$83
	.DB $24,$25,$34,$35,$83,$83,$24,$25
	.DB $36,$37,$83,$83,$26,$27,$36,$37
	.DB $83,$83,$26,$27

DATA_01DF07:
	.DB $04,$04,$04,$08,$08,$08,$0A,$0A
	.DB $0A

DATA_01DF10:
	.DB $00,$03,$05,$07,$08,$08,$07,$05
	.DB $03

CODE_01DF19:
	LDA wm_SpriteDecTbl1,X
	LSR
	TAY
	LDA DATA_01DF10,Y
	STA m0
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.5.XPos,Y
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.3.XPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.2.XPos,Y
	STA wm_OamSlot.4.XPos,Y
	LDA wm_SpriteDecTbl2,X
	CLC
	BEQ _01DF4E
	LSR
	LSR
	LSR
	LSR
	BRA _01DF4D

ADDR_01DF49: ; Unreachable
	CLC
	ADC wm_SprProcessIndex
_01DF4D:
	LSR
_01DF4E:
	PHP
	LDA wm_SpriteYLo,X
	SEC
	SBC m0
	SEC
	SBC wm_Bg1VOfs
	STA wm_OamSlot.5.YPos,Y
	PLP
	BCS +
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.3.YPos,Y
	STA wm_OamSlot.4.YPos,Y
+	LDA wm_SpriteMiscTbl6,X
	PHX
	PHA
	ASL
	ASL
	TAX
	LDA.W DATA_01DEE3,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_01DEE3+1,X
	STA wm_OamSlot.2.Tile,Y
	LDA.W DATA_01DEE3+2,X
	STA wm_OamSlot.3.Tile,Y
	LDA.W DATA_01DEE3+3,X
	STA wm_OamSlot.4.Tile,Y
	LDA #$E4
	STA wm_OamSlot.5.Tile,Y
	PLX
	LDA wm_SpriteProp
	ORA.W DATA_01DF07,X
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	STA wm_OamSlot.4.Prop,Y
	ORA #$01
	STA wm_OamSlot.5.Prop,Y
	PLX
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	STA wm_OamSize.3,Y
	STA wm_OamSize.4,Y
	LDA #$02
	STA wm_OamSize.5,Y
	RTS

DATA_01DFC1:
	.DB 0,1,2,2,3,4,4,5
	.DB 6,6,7,0,0,8,4,2
	.DB 8,6,3,8,7,1,8,5

CODE_01DFD9:
	LDA #$07
	STA m0
-	LDX #$02
--	STX m1
	LDA m0
	ASL
	ADC m0
	CLC
	ADC m1
	TAY
	LDA DATA_01DFC1,Y
	TAY
	LDA DATA_01DD9B,Y
	STA m2
	LDA DATA_01DD91,Y
	STA m3
	LDY #$09
---	LDA.W wm_SpriteYLo,Y
	CMP m2
	BNE +
	LDA.W wm_SpriteXLo,Y
	CMP m3
	BEQ ++
+	DEY
	CPY #$01
	BNE ---
++	LDA wm_SpriteMiscTbl6,Y
	STA m4,X
	STY m7,X
	DEX
	BPL --
	LDA m4
	CMP m5
	BNE +
	CMP m6
	BNE +
	INC wm_Bonus1UpCount
	LDA #$70
	LDY m7
	STA wm_SpriteDecTbl2,Y
	LDY m8
	STA wm_SpriteDecTbl2,Y
	LDY m9
	STA wm_SpriteDecTbl2,Y
+	DEC m0
	BPL -
	LDX wm_SprProcessIndex
	LDY #$29
	LDA wm_Bonus1UpCount
	STA wm_Bonus1UpsRemaining
	BNE +
	LDA #$58
	STA wm_BonusGameEndTimer
	INY
+	STY wm_SoundCh3
	RTS

InitFireball:
	LDA wm_SpriteYLo,X
	STA wm_SpriteMiscTbl4,X
	LDA wm_SpriteYHi,X
	STA wm_SpriteMiscTbl3,X
-	LDA wm_SpriteYLo,X
	CLC
	ADC #$10
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_SpriteYHi,X
	JSR CODE_019140
	LDA wm_SprInWaterTbl,X
	BEQ -
	JSR _01E0E2
	LDA #$20
	STA wm_SpriteDecTbl1,X
	RTS

DATA_01E07B:
	.DB $F0,$DC,$D0,$C8,$C0,$B8,$B2,$AC
	.DB $A6,$A0,$9A,$96,$92,$8C,$88,$84
	.DB $80,$04,$08,$0C,$10,$14

DATA_01E091:	.DB $70,$20

Fireballs:
	STZ wm_SpriteEatenTbl,X
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01E0A7
	STA wm_SpriteEatenTbl,X
	DEC A
	BNE +
	LDA #$27
	STA wm_SoundCh3
+	RTS

CODE_01E0A7:
	LDA wm_SpritesLocked
	BEQ CODE_01E0AE
	JMP _01E12D

CODE_01E0AE:
	JSR MarioSprInteractRt
	JSR SetAnimationFrame
	JSR SetAnimationFrame
	LDA wm_SpritePal,X
	AND #$7F
	LDY wm_SpriteSpeedY,X
	BMI +
	INC wm_SpriteGfxTbl,X
	INC wm_SpriteGfxTbl,X
	ORA #$80
+	STA wm_SpritePal,X
	JSR CODE_019140
	LDA wm_SprInWaterTbl,X
	BEQ CODE_01E106
	LDA wm_SpriteSpeedY,X
	BMI CODE_01E106
	JSL GetRand
	AND #$3F
	ADC #$60
	STA wm_SpriteDecTbl1,X
_01E0E2:
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_SpriteMiscTbl4,X
	STA m0
	LDA wm_SpriteYHi,X
	SBC wm_SpriteMiscTbl3,X
	LSR
	ROR m0
	LDA m0
	LSR
	LSR
	LSR
	TAY
	LDA DATA_01E07B,Y
	BMI +
	STA wm_SpriteDecTbl4,X
	LDA #$80
+	STA wm_SpriteSpeedY,X
	RTS

CODE_01E106:
	JSR SubSprYPosNoGrvty
	LDA wm_FrameB
	AND #$07
	ORA wm_SpriteState,X
	BNE +
	JSL CODE_0285DF
+	LDA wm_SpriteDecTbl4,X
	BNE ++
	LDA wm_SpriteSpeedY,X
	BMI +
	LDY wm_SpriteState,X
	CMP DATA_01E091,Y
	BCS ++
+	CLC
	ADC #$02
	STA wm_SpriteSpeedY,X
++	JSR SubOffscreen0Bnk1
_01E12D:
	LDA wm_SpriteState,X
	BEQ CODE_01E198
	LDY wm_SpritesLocked
	BNE _01E164
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ CODE_01E151
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteDecTbl3,X
	BEQ CODE_01E14A
	CMP #$01
	BNE _01E14F
	JMP _019ACB

CODE_01E14A:
	LDA #$80
	STA wm_SpriteDecTbl3,X
_01E14F:
	BRA _01E164

CODE_01E151:
	TXA
	ASL
	ASL
	CLC
	ADC wm_FrameA
	LDY #$F0
	AND #$04
	BEQ +
	LDY #$10
+	STY wm_SpriteSpeedX,X
	JSR SubSprXPosNoGrvty
_01E164:
	LDA wm_SpriteYLo,X
	CMP #$F0
	BCC +
	STZ wm_SpriteStatus,X
+	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	PHX
	LDA wm_FrameB
	AND #$0C
	LSR
	ADC wm_SprProcessIndex
	LSR
	AND #$03
	TAX
	LDA.W BowserFlameTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_01E194,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLX
	RTS

BowserFlameTiles:	.DB $2A,$2C,$2A,$2C

DATA_01E194:	.DB $05,$05,$45,$45

CODE_01E198:
	LDA #$01
	JSR SubSprGfx0Entry0
	REP #$20
	LDA #$0008
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
	RTS

InitKeyHole:
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,X
	RTS

Keyhole:
	LDY #$0B
-	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC +
	LDA.W wm_SpriteNum,Y
	CMP #$80
	BEQ ++
+	DEY
	BPL -
++	LDA wm_OnYoshi
	BEQ +
	LDA wm_YoshiHasKey
	BNE CODE_01E1ED
+	TYA
	STA wm_SpriteMiscTbl3,X
	BMI _01E23A
	BRA CODE_01E1F3

CODE_01E1ED:
	JSL GetMarioClipping
	BRA _01E201

CODE_01E1F3:
	LDA wm_SpriteStatus,Y
	CMP #$0B
	BNE _01E23A
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
_01E201:
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC _01E23A
	LDA wm_SpriteDecTbl2,X
	BNE _01E23A
	LDA #$30
	STA wm_KeyHoleTimer
	LDA #$10
	STA wm_MusicCh1
	INC wm_IsFrozen
	INC wm_SpritesLocked
	LDA wm_SpriteXHi,X
	STA wm_KeyHolePos1+1
	LDA wm_SpriteXLo,X
	STA wm_KeyHolePos1
	LDA wm_SpriteYHi,X
	STA wm_KeyHolePos2+1
	LDA wm_SpriteYLo,X
	STA wm_KeyHolePos2
	LDA #$30
	STA wm_SpriteDecTbl2,X
_01E23A:
	JSR GetDrawInfoBnk1
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$08
	STA wm_OamSlot.2.YPos,Y
	LDA #$EB
	STA wm_OamSlot.1.Tile,Y
	LDA #$FB
	STA wm_OamSlot.2.Tile,Y
	LDA #$30
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	LDY #$00
	LDA #$01
	JSR FinishOAMWriteRt
	RTS

CODE_01E26A:
	LDA wm_FrameA
	AND #$3F
	BNE +
	LDA wm_Bonus1UpCount
	BEQ +
	DEC wm_Bonus1UpCount
	JSR CODE_01E281
+	LDA #$01
	STA wm_AllowClusterSpr
	RTS

CODE_01E281:
	LDY #$07
-	LDA wm_ClustSprNum,Y
	BEQ CODE_01E28C
	DEY
	BPL -
	RTS

CODE_01E28C:
	LDA #$01
	STA wm_ClustSprNum,Y
	LDA #$00
	STA wm_ClusterSprYLo,Y
	LDA #$01
	STA wm_ClusterSprYHi,Y
	LDA #$18
	STA wm_ClusterSprXLo,Y
	LDA #$00
	STA wm_ClusterSprXHi,Y
	LDA #$01
	STA wm_ClusBooFrame1X,Y
	LDA #$10
	STA wm_ClusBooFrame1Y,Y
	RTS

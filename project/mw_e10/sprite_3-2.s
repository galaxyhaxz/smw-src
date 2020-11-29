GenTileFromSpr2:
	STA wm_BlockId
	LDA wm_SpriteXLo,X
	SEC
	SBC #$08
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	SBC #$00
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_BlockXPos+1
	JSL GenerateTile
	RTL

CODE_03C023:
	PHB
	PHK
	PLB
	JSR CODE_03C02F
	PLB
	RTL

DATA_03C02B:	.DB $74,$75,$77,$76

CODE_03C02F:
	LDY wm_SpriteMiscTbl8,X
	LDA #$00
	STA wm_SpriteStatus,Y
	LDA #$06
	STA wm_SoundCh1
	LDA wm_SpriteMiscTbl8,Y
	BNE CODE_03C09B
	LDA.W wm_SpriteNum,Y
	CMP #$81
	BNE +
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_03C02B,Y
+	CMP #$74
	BCC CODE_03C09B
	CMP #$78
	BCS CODE_03C09B
_03C05C:
	STZ wm_YoshiSwallowTimer
	STZ wm_YoshiHasWings
	LDA #$35
	STA.W wm_SpriteNum,X
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$1F
	STA wm_SoundCh3
	LDA wm_SpriteYLo,X
	SBC #$10
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
	LDA wm_SpritePal,X
	PHA
	JSL InitSpriteTables
	PLA
	AND #$FE
	STA wm_SpritePal,X
	LDA #$0C
	STA wm_SpriteGfxTbl,X
	DEC wm_SpriteMiscTbl8,X
	LDA #$40
	STA wm_YoshiGrowTimer
	RTS

CODE_03C09B:
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$05
	BNE CODE_03C0A7
	BRA _03C05C

CODE_03C0A7:
	JSL CODE_05B34A
	LDA #$01
	JSL GivePoints
	RTS

DATA_03C0B2:	.DB $68,$6A,$6C,$6E

DATA_03C0B6:
	.DB $00,$03,$01,$02,$04,$02,$00,$01
	.DB $00,$04,$00,$02,$00,$03,$04,$01

CODE_03C0C6:
	LDA wm_SpritesLocked
	BNE +
	JSR CODE_03C11E
+	STZ m0
	LDX #$13
	LDY #$B0
-	STX m2
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$10
	STA m0
	LDA #$C4
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SpriteProp
	ORA #$09
	STA wm_OamSlot.1.Prop,Y
	PHX
	LDA wm_FrameB
	LSR
	LSR
	LSR
	CLC
	ADC.L DATA_03C0B6,X
	AND #$03
	TAX
	LDA.L DATA_03C0B2,X
	STA wm_OamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.1,X
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
	RTL

IggyPlatSpeed:	.DB $FF,$01,$FF,$01

DATA_03C116:	.DB $FF,$00,$FF,$00

IggyPlatBounds:	.DB $E7,$18,$D7,$28

CODE_03C11E:
	LDA wm_SpritesLocked
	ORA wm_EndLevelTimer
	BNE ++
	LDA wm_IggyPlatTimer
	BEQ +
	DEC wm_IggyPlatTimer
+	LDA wm_FrameA
	AND #$01
	ORA wm_IggyPlatTimer
	BNE ++
	LDA wm_IggyPlatTilts
	AND #$01
	TAX
	LDA wm_IggyPlatCounter
	CMP #$04
	BCC +
	INX
	INX
+	LDA wm_M7Rotate
	CLC
	ADC.L IggyPlatSpeed,X
	STA wm_M7Rotate
	PHA
	LDA wm_M7Rotate+1
	ADC.L DATA_03C116,X
	AND #$01
	STA wm_M7Rotate+1
	PLA
	CMP.L IggyPlatBounds,X
	BNE ++
	INC wm_IggyPlatTilts
	LDA #$40
	STA wm_IggyPlatTimer
	INC wm_IggyPlatCounter
	LDA wm_IggyPlatCounter
	CMP #$06
	BNE ++
	STZ wm_IggyPlatCounter
++	RTS

DATA_03C176:
	.DB $0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D
	.DB $0D,$0D,$FC,$FC,$FC,$FC,$FC,$FC
	.DB $FB,$FB,$FB,$FB,$0C,$0C,$0C,$0C
	.DB $0C,$0C,$0D,$0D,$0D,$0D,$FC,$FC
	.DB $FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB

DATA_03C19E:
	.DB $0E,$0E,$0E,$0D,$0D,$0D,$0C,$0C
	.DB $0B,$0B,$0E,$0E,$0E,$0D,$0D,$0D
	.DB $0C,$0C,$0B,$0B,$12,$12,$12,$11
	.DB $11,$11,$10,$10,$0F,$0F,$12,$12
	.DB $12,$11,$11,$11,$10,$10,$0F,$0F

DATA_03C1C6:	.DB $02,$FE

DATA_03C1C8:	.DB $00,$FF

CODE_03C1CA:
	PHB
	PHK
	PLB
	LDY #$00
	LDA wm_SpriteSlopeTbl,X
	BPL +
	INY
+	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_03C1C6,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC DATA_03C1C8,Y
	STA wm_SpriteXHi,X
	LDA #$18
	STA wm_SpriteSpeedY,X
	PLB
	RTL

DATA_03C1EC:
	.DB $00,$04,$07,$08,$08,$07,$04,$00
	.DB $00

LightSwitch:
	LDA wm_SpritesLocked
	BNE ++
	JSL InvisBlkMainRt
	JSR SubOffscreen0Bnk3
	LDA wm_SpriteDecTbl3,X
	CMP #$05
	BNE ++
	STZ wm_SpriteState,X
	LDY #$0B
	STY wm_SoundCh1
	PHA
	LDY #$09
-	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE +
	LDA.W wm_SpriteNum,Y
	CMP #$C6
	BNE +
	LDA.W wm_SpriteState,Y
	EOR #$01
	STA.W wm_SpriteState,Y
+	DEY
	BPL -
	PLA
++	LDA wm_SpriteDecTbl3,X
	LSR
	TAY
	LDA wm_Bg1VOfs
	PHA
	CLC
	ADC DATA_03C1EC,Y
	STA wm_Bg1VOfs
	LDA wm_Bg1VOfs+1
	PHA
	ADC #$00
	STA wm_Bg1VOfs+1
	JSL GenericSprGfxRt2
	LDY wm_SprOAMIndex,X
	LDA #$2A
	STA wm_OamSlot.1.Tile,Y
	LDA wm_OamSlot.1.Prop,Y
	AND #$BF
	STA wm_OamSlot.1.Prop,Y
	PLA
	STA wm_Bg1VOfs+1
	PLA
	STA wm_Bg1VOfs
	RTS

ChainsawMotorTiles:	.DB $E0,$C2,$C0,$C2

DATA_03C25F:	.DB $F2,$0E

DATA_03C261:	.DB $33,$B3

CODE_03C263:
	PHB
	PHK
	PLB
	JSR ChainsawGfx
	PLB
	RTL

ChainsawGfx:
	JSR GetDrawInfoBnk3
	PHX
	LDA wm_SpriteNum,X
	SEC
	SBC #$65
	TAX
	LDA.W DATA_03C25F,X
	STA m3
	LDA.W DATA_03C261,X
	STA m4
	PLX
	LDA wm_FrameB
	AND #$02
	STA m2
	LDA m0
	SEC
	SBC #$08
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	STA wm_OamSlot.3.XPos,Y
	LDA m1
	SEC
	SBC #$08
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC m3
	CLC
	ADC m2
	STA wm_OamSlot.2.YPos,Y
	CLC
	ADC m3
	STA wm_OamSlot.3.YPos,Y
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	PHX
	TAX
	LDA.W ChainsawMotorTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA #$AE
	STA wm_OamSlot.2.Tile,Y
	LDA #$8E
	STA wm_OamSlot.3.Tile,Y
	LDA #$37
	STA wm_OamSlot.1.Prop,Y
	LDA m4
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	LDY #$02
	TYA
	JSL FinishOAMWrite
	RTS

TriggerInivis1Up:
	PHX
	LDX #$0B
-	LDA wm_SpriteStatus,X
	BEQ Generate1Up
	DEX
	BPL -
	PLX
	RTL

Generate1Up:
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$78
	STA wm_SpriteNum,X
	LDA wm_MarioXPos
	STA wm_SpriteXLo,X
	LDA wm_MarioXPos+1
	STA wm_SpriteXHi,X
	LDA wm_MarioYPos
	STA wm_SpriteYLo,X
	LDA wm_MarioYPos+1
	STA wm_SpriteYHi,X
	JSL InitSpriteTables
	LDA #$10
	STA wm_SpriteDecTbl2,X
	JSR _PopupMushroom
	PLX
	RTL

InvisMushroom:
	JSR GetDrawInfoBnk3
	JSL MarioSprInteract
	BCC ++
	LDA #$74
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	LDA #$20
	STA wm_SpriteDecTbl2,X
	LDA wm_SpriteYLo,X
	SEC
	SBC #$0F
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
_PopupMushroom:
	LDA #$00
	LDY wm_MarioSpeedX
	BPL +
	INC A
+	STA wm_SpriteDir,X
	LDA #$C0
	STA wm_SpriteSpeedY,X
	LDA #$02
	STA wm_SoundCh3
++	RTS

NinjiSpeedY:	.DB $D0,$C0,$B0,$D0

Ninji:
	JSL GenericSprGfxRt2
	LDA wm_SpritesLocked
	BNE ++
	JSR SubHorzPosBnk3
	TYA
	STA wm_SpriteDir,X
	JSR SubOffscreen0Bnk3
	JSL SprSprMarioSprRts
	JSL UpdateSpritePos
	LDA wm_SprObjStatus,X
	AND #$04
	BEQ +
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$60
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	AND #$03
	TAY
	LDA NinjiSpeedY,Y
	STA wm_SpriteSpeedY,X
+	LDA #$00
	LDY wm_SpriteSpeedY,X
	BMI +
	INC A
+	STA wm_SpriteGfxTbl,X
++	RTS

CODE_03C390:
	PHB
	PHK
	PLB
	LDA wm_SpriteDir,X
	PHA
	LDY wm_SpriteDecTbl5,X
	BEQ +
	CPY #$05
	BCC +
	EOR #$01
	STA wm_SpriteDir,X
+	JSR CODE_03C3DA
	PLA
	STA wm_SpriteDir,X
	PLB
	RTL

CODE_03C3AE:
	JSL GenericSprGfxRt2
	RTS

DryBonesTileDispX:
	.DB $00,$08,$00,$00,$F8,$00,$00,$04
	.DB $00,$00,$FC,$00

DryBonesGfxProp:	.DB $43,$43,$43,$03,$03,$03

DryBonesTileDispY:
	.DB $F4,$F0,$00,$F4,$F1,$00,$F4,$F0
	.DB $00

DryBonesTiles:
	.DB $00,$64,$66,$00,$64,$68,$82,$64
	.DB $E6

DATA_03C3D7:	.DB $00,$00,$FF

CODE_03C3DA:
	LDA wm_SpriteNum,X
	CMP #$31
	BEQ CODE_03C3AE
	JSR GetDrawInfoBnk3
	LDA wm_SpriteDecTbl5,X
	STA m5
	LDA wm_SpriteDir,X
	ASL
	ADC wm_SpriteDir,X
	STA m2
	PHX
	LDA wm_SpriteGfxTbl,X
	PHA
	ASL
	ADC wm_SpriteGfxTbl,X
	STA m3
	PLX
	LDA.W DATA_03C3D7,X
	STA m4
	LDX #$02
-	PHX
	TXA
	CLC
	ADC m2
	TAX
	PHX
	LDA m5
	BEQ +
	TXA
	CLC
	ADC #$06
	TAX
+	LDA m0
	CLC
	ADC.W DryBonesTileDispX,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA.W DryBonesGfxProp,X
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	PLA
	PHA
	CLC
	ADC m3
	TAX
	LDA m1
	CLC
	ADC.W DryBonesTileDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DryBonesTiles,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	INY
	INY
	INY
	INY
	DEX
	CPX m4
	BNE -
	PLX
	LDY #$02
	TYA
	JSL FinishOAMWrite
	RTS

CODE_03C44E:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	BNE +
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_03C461
	DEY
	BPL -
+	RTL

CODE_03C461:
	LDA #$06
	STA wm_ExSpriteNum,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC #$10
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_ExSpriteYHi,Y
	LDA wm_SpriteXLo,X
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteDir,X
	LSR
	LDA #$18
	BCC +
	LDA #$E8
+	STA wm_ExSprSpeedX,Y
	RTL

DATA_03C48F:	.DB $01,$FF

DATA_03C491:	.DB $FF,$90

DiscoBallTiles:
	.DB $80,$82,$84,$86,$88,$8C,$C0,$C2
	.DB $C2

DATA_03C49C:
	.DB $31,$33,$35,$37,$31,$33,$35,$37
	.DB $39

CODE_03C4A5:
	LDY wm_SprOAMIndex,X
	LDA #$78
	STA wm_OamSlot.1.XPos,Y
	LDA #$28
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA wm_SpriteState,X
	LDX #$08
	AND #$01
	BEQ +
	LDA wm_FrameA
	LSR
	AND #$07
	TAX
+	LDA.W DiscoBallTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W DATA_03C49C,X
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.1,Y
	PLX
	RTS

DATA_03C4D8:	.DB $10,$8C

DATA_03C4DA:	.DB $42,$31

DarkRoomWithLight:
	LDA wm_SpriteMiscTbl5,X
	BNE _03C500
	LDY #$09
_03C4E3:
	CPY wm_SprProcessIndex
	BEQ CODE_03C4FA
	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE CODE_03C4FA
	LDA.W wm_SpriteNum,Y
	CMP #$C6
	BNE CODE_03C4FA
	STZ wm_SpriteStatus,X
_Return03C4F9:
	RTS

CODE_03C4FA:
	DEY
	BPL _03C4E3
	INC wm_SpriteMiscTbl5,X
_03C500:
	JSR CODE_03C4A5
	LDA #$FF
	STA wm_CgAdSub
	LDA #$20
	STA wm_CgSwSel
	LDA #$20
	STA wm_WObjSel
	LDA #$80
	STA wm_HDMAEn
	LDA wm_SpriteState,X
	AND #$01
	TAY
	LDA DATA_03C4D8,Y
	STA wm_LvBgColor
	LDA DATA_03C4DA,Y
	STA wm_LvBgColor+1
	LDA wm_SpritesLocked
	BNE _Return03C4F9
	LDA wm_InitSpotlight
	BNE +
	LDA #$00
	STA wm_SpotlightLowLXPos
	LDA #$90
	STA wm_SpotlightLowRXPos
	LDA #$78
	STA wm_SpotlightLXPos
	LDA #$87
	STA wm_SpotlightRXPos
	LDA #$01
	STA wm_1486
	STZ wm_SpotlightDir
	INC wm_InitSpotlight
+	LDY wm_SpotlightDir
	LDA wm_SpotlightLowLXPos
	CLC
	ADC DATA_03C48F,Y
	STA wm_SpotlightLowLXPos
	LDA wm_SpotlightLowRXPos
	CLC
	ADC DATA_03C48F,Y
	STA wm_SpotlightLowRXPos
	CMP DATA_03C491,Y
	BNE +
	LDA wm_SpotlightDir
	INC A
	AND #$01
	STA wm_SpotlightDir
+	LDA wm_FrameA
	AND #$03
	BNE _Return03C4F9
	LDY #$00
	LDA wm_SpotlightLXPos
	STA wm_SpotlightTmpLXPos
	SEC
	SBC wm_SpotlightLowLXPos
	BCS +
	INY
	EOR #$FF
	INC A
+	STA wm_SpotlightLWidth
	STY wm_SpotlightLSide
	STZ wm_SpotlightMvLeft
	LDY #$00
	LDA wm_SpotlightRXPos
	STA wm_SpotlightTmpRXPos
	SEC
	SBC wm_SpotlightLowRXPos
	BCS +
	INY
	EOR #$FF
	INC A
+	STA wm_SpotlightRWidth
	STY wm_SpotlightRSide
	STZ wm_SpotlightMvRight
	LDA wm_SpriteState,X
	STA m15
	PHX
	REP #$10
	LDX #$0000
_03C5B8:
	CPX #$005F
	BCC +++
	LDA wm_SpotlightMvLeft
	CLC
	ADC wm_SpotlightLWidth
	STA wm_SpotlightMvLeft
	BCS +
	CMP #$CF
	BCC ++
+	SBC #$CF
	STA wm_SpotlightMvLeft
	INC wm_SpotlightTmpLXPos
	LDA wm_SpotlightLSide
	BNE ++
	DEC wm_SpotlightTmpLXPos
	DEC wm_SpotlightTmpLXPos
++	LDA wm_SpotlightMvRight
	CLC
	ADC wm_SpotlightRWidth
	STA wm_SpotlightMvRight
	BCS +
	CMP #$CF
	BCC ++
+	SBC #$CF
	STA wm_SpotlightMvRight
	INC wm_SpotlightTmpRXPos
	LDA wm_SpotlightRSide
	BNE ++
	DEC wm_SpotlightTmpRXPos
	DEC wm_SpotlightTmpRXPos
++	LDA m15
	BNE CODE_03C60F
+++	LDA #$01
	STA wm_HDMAWindowsTbl,X
	DEC A
	BRA _03C618

CODE_03C60F:
	LDA wm_SpotlightTmpLXPos
	STA wm_HDMAWindowsTbl,X
	LDA wm_SpotlightTmpRXPos
_03C618:
	STA wm_HDMAWindowsTbl+1,X
	INX
	INX
	CPX #$01C0
	BNE _03C5B8
	SEP #$10
	PLX
	RTS

DATA_03C626:
	.DB $14,$28,$38,$20,$30,$4C,$40,$34
	.DB $2C,$1C,$08,$0C,$04,$0C,$1C,$24
	.DB $2C,$38,$40,$48,$50,$5C,$5C,$6C
	.DB $4C,$58,$24,$78,$64,$70,$78,$7C
	.DB $70,$68,$58,$4C,$40,$34,$24,$04
	.DB $18,$2C,$0C,$0C,$14,$18,$1C,$24
	.DB $2C,$28,$24,$30,$30,$34,$38,$3C
	.DB $44,$54,$48,$5C,$68,$40,$4C,$40
	.DB $3C,$40,$50,$54,$60,$54,$4C,$5C
	.DB $5C,$68,$74,$6C,$7C,$78,$68,$80
	.DB $18,$48,$2C,$1C

DATA_03C67A:
	.DB $1C,$0C,$08,$1C,$14,$08,$14,$24
	.DB $28,$2C,$30,$3C,$44,$4C,$44,$34
	.DB $40,$34,$24,$1C,$10,$0C,$18,$18
	.DB $2C,$28,$68,$28,$34,$34,$38,$40
	.DB $44,$44,$38,$3C,$44,$48,$4C,$5C
	.DB $5C,$54,$64,$74,$74,$88,$80,$94
	.DB $8C,$78,$6C,$64,$70,$7C,$8C,$98
	.DB $90,$98,$84,$84,$88,$78,$78,$6C
	.DB $5C,$50,$50,$48,$50,$5C,$64,$64
	.DB $74,$78,$74,$64,$60,$58,$54,$50
	.DB $50,$58,$30,$34

DATA_03C6CE:
	.DB $20,$30,$39,$47,$50,$60,$70,$7C
	.DB $7B,$80,$7D,$78,$6E,$60,$4F,$47
	.DB $41,$38,$30,$2A,$20,$10,$04,$00
	.DB $00,$08,$10,$20,$1A,$10,$0A,$06
	.DB $0F,$17,$16,$1C,$1F,$21,$10,$18
	.DB $20,$2C,$2E,$3B,$30,$30,$2D,$2A
	.DB $34,$36,$3A,$3F,$45,$4D,$5F,$54
	.DB $4E,$67,$70,$67,$70,$5C,$4E,$40
	.DB $48,$56,$57,$5F,$68,$72,$77,$6F
	.DB $66,$60,$67,$5C,$57,$4B,$4D,$54
	.DB $48,$43,$3D,$3C

DATA_03C722:
	.DB $18,$1E,$25,$22,$1A,$17,$20,$30
	.DB $41,$4F,$61,$70,$7F,$8C,$94,$92
	.DB $A0,$86,$93,$88,$88,$78,$66,$50
	.DB $40,$30,$22,$20,$2C,$30,$40,$4F
	.DB $59,$51,$3F,$39,$4C,$5F,$6A,$6F
	.DB $77,$7E,$6C,$60,$58,$48,$3D,$2F
	.DB $28,$38,$44,$30,$36,$27,$21,$2F
	.DB $39,$2A,$2F,$39,$40,$3F,$49,$50
	.DB $60,$59,$4C,$51,$48,$4F,$56,$67
	.DB $5B,$68,$75,$7D,$87,$8A,$7A,$6B
	.DB $70,$82,$73,$92

DATA_03C776:	.DB $60,$B0,$40,$80

FireworkSfx1:	.DB $26,$00,$26,$28

FireworkSfx2:	.DB $00,$2B,$00,$00

FireworkSfx3:	.DB $27,$00,$27,$29

FireworkSfx4:	.DB $00,$2C,$00,$00

DATA_03C78A:	.DB $00,$AA,$FF,$AA

DATA_03C78E:	.DB $00,$7E,$27,$7E

DATA_03C792:	.DB $C0,$C0,$FF,$C0

CODE_03C796:
	LDA wm_SpriteDecTbl4,X
	BEQ CODE_03C7A7
	DEC A
	BNE +
	INC wm_CutsceneNum
	LDA #$FF
	STA wm_EndLevelTimer
+	RTS

CODE_03C7A7:
	LDA wm_SpriteDecTbl4.Spr10
	AND #$03
	TAY
	LDA DATA_03C78A,Y
	STA wm_LvBgColor
	LDA DATA_03C78E,Y
	STA wm_LvBgColor+1
	LDA wm_DisSprCapeContact.Spr10
	BNE _Return03C80F
	LDA wm_SpriteMiscTbl5,X
	CMP #$04
	BEQ CODE_03C810
	LDY #$01
-	LDA wm_SpriteStatus,Y
	BEQ CODE_03C7D0
	DEY
	BPL -
	RTS

CODE_03C7D0:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$7A
	STA.W wm_SpriteNum,Y
	LDA #$00
	STA wm_SpriteXHi,Y
	LDA #$A8
	CLC
	ADC wm_Bg1VOfs
	STA.W wm_SpriteYLo,Y
	LDA wm_Bg1VOfs+1
	ADC #$00
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	PHX
	LDA wm_SpriteMiscTbl5,X
	AND #$03
	STA wm_SpriteMiscTbl5,Y
	TAX
	LDA.W DATA_03C792,X
	STA wm_DisSprCapeContact.Spr10
	LDA.W DATA_03C776,X
	STA.W wm_SpriteXLo,Y
	PLX
	INC wm_SpriteMiscTbl5,X
_Return03C80F:
	RTS

CODE_03C810:
	LDA #$70
	STA wm_SpriteDecTbl4,X
	RTS

Firework:
	LDA wm_SpriteState,X
	JSL ExecutePtr

FireworkPtrs:
	.DW CODE_03C828
	.DW CODE_03C845
	.DW CODE_03C88D
	.DW CODE_03C941

FireworkSpeedY:	.DB $E4,$E6,$E4,$E2

CODE_03C828:
	LDY wm_SpriteMiscTbl5,X
	LDA FireworkSpeedY,Y
	STA wm_SpriteSpeedY,X
	LDA #$25
	STA wm_SoundCh3
	LDA #$10
	STA wm_SpriteDecTbl4,X
	INC wm_SpriteState,X
	RTS

DATA_03C83D:	.DB $14,$0C,$10,$15

DATA_03C841:	.DB $08,$10,$0C,$05

CODE_03C845:
	LDA wm_SpriteDecTbl4,X
	CMP #$01
	BNE +
	LDY wm_SpriteMiscTbl5,X
	LDA FireworkSfx1,Y
	STA wm_SoundCh1
	LDA FireworkSfx2,Y
	STA wm_SoundCh3
+	JSL UpdateYPosNoGrvty
	INC wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedX,X
	AND #$03
	BNE +
	INC wm_SpriteSpeedY,X
+	LDA wm_SpriteSpeedY,X
	CMP #$FC
	BNE +
	INC wm_SpriteState,X
	LDY wm_SpriteMiscTbl5,X
	LDA DATA_03C83D,Y
	STA wm_SpriteMiscTbl3,X
	LDA DATA_03C841,Y
	STA wm_SpriteDecTbl5,X
	LDA #$08
	STA wm_SpriteDecTbl4.Spr10
+	JSR CODE_03C96D
	RTS

DATA_03C889:	.DB $FF,$80,$C0,$FF

CODE_03C88D:
	LDA wm_SpriteDecTbl5,X
	DEC A
	BNE +
	LDY wm_SpriteMiscTbl5,X
	LDA FireworkSfx3,Y
	STA wm_SoundCh1
	LDA FireworkSfx4,Y
	STA wm_SoundCh3
+	JSR CODE_03C8B1
	LDA wm_SpriteState,X
	CMP #$02
	BNE +
	JSR CODE_03C8B1
+	JMP CODE_03C9E9

CODE_03C8B1:
	LDY wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl6,X
	CLC
	ADC wm_SpriteMiscTbl3,X
	STA wm_SpriteMiscTbl6,X
	BCS ADDR_03C8DB
	CMP DATA_03C889,Y
	BCS _03C8E0
	LDA wm_SpriteMiscTbl3,X
	CMP #$02
	BCC +
	SEC
	SBC #$01
	STA wm_SpriteMiscTbl3,X
	BCS _03C8E4
+	LDA #$01
	STA wm_SpriteMiscTbl3,X
	BRA _03C8E4

ADDR_03C8DB:
	LDA #$FF
	STA wm_SpriteMiscTbl6,X
_03C8E0:
	INC wm_SpriteState,X
	STZ wm_SpriteSpeedY,X
_03C8E4:
	LDA wm_SpriteMiscTbl3,X
	AND #$FF
	TAY
	LDA DATA_03C8F1,Y
	STA wm_SpriteGfxTbl,X
	RTS

DATA_03C8F1:
	.DB $06,$05,$04,$03,$03,$03,$03,$02
	.DB $02,$02,$02,$02,$02,$02,$01,$01
	.DB $01,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $03,$03,$03,$03,$03,$03,$03,$03
	.DB $03,$03,$02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02

CODE_03C941:
	LDA wm_FrameA
	AND #$07
	BNE +
	INC wm_SpriteSpeedY,X
+	JSL UpdateYPosNoGrvty
	LDA #$07
	LDY wm_SpriteSpeedY,X
	CPY #$08
	BNE +
	STZ wm_SpriteStatus,X
+	CPY #$03
	BCC +
	INC A
	CPY #$05
	BCC +
	INC A
+	STA wm_SpriteGfxTbl,X
	JSR CODE_03C9E9
	RTS

DATA_03C969:	.DB $EC,$8E,$EC,$EC

CODE_03C96D:
	TXA
	EOR wm_FrameA
	AND #$03
	BNE +
	JSR GetDrawInfoBnk3
	LDY #$00
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA wm_SpriteMiscTbl5,X
	TAX
	LDA wm_FrameA
	LSR
	LSR
	AND #$02
	LSR
	ADC.W DATA_03C969,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA wm_FrameA
	ASL
	AND #$0E
	STA m2
	LDA wm_FrameA
	ASL
	ASL
	ASL
	ASL
	AND #$40
	ORA m2
	ORA #$31
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
+	RTS

DATA_03C9B9:
	.DB $36,$35,$C7,$34,$34,$34,$34,$24
	.DB $03,$03,$36,$35,$C7,$34,$34,$24
	.DB $24,$24,$24,$03,$36,$35,$C7,$34
	.DB $34,$34,$24,$24,$03,$24,$36,$35
	.DB $C7,$34,$24,$24,$24,$24,$24,$03

DATA_03C9E1:	.DB $00,$01,$01,$00,$00,$FF,$FF,$00

CODE_03C9E9:
	TXA
	EOR wm_FrameA
	STA m5
	LDA wm_SpriteMiscTbl6,X
	STA m6
	LDA wm_SpriteGfxTbl,X
	STA m7
	LDA wm_SpriteXLo,X
	STA m8
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m9
	LDA wm_SpriteMiscTbl5,X
	STA m10
	PHX
	LDX #$3F
	LDY #$00
_03CA0D:
	STX m4
	LDA m10
	CMP #$03
	LDA.W DATA_03C626,X
	BCC +
	LDA.W DATA_03C6CE,X
+	SEC
	SBC #$40
	STA m0
	PHY
	LDA m10
	CMP #$03
	LDA.W DATA_03C67A,X
	BCC +
	LDA.W DATA_03C722,X
+	SEC
	SBC #$50
	STA m1
	LDA m0
	BPL +
	EOR #$FF
	INC A
+	STA WRMPYA
	LDA m6
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	LDY m0
	BPL +
	EOR #$FF
	INC A
+	STA m2
	LDA m1
	BPL +
	EOR #$FF
	INC A
+	STA WRMPYA
	LDA m6
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	LDY m1
	BPL +
	EOR #$FF
	INC A
+	STA m3
	LDY #$00
	LDA m7
	CMP #$06
	BCC +
	LDA m5
	CLC
	ADC m4
	LSR
	LSR
	AND #$07
	TAY
+	LDA DATA_03C9E1,Y
	PLY
	CLC
	ADC m2
	CLC
	ADC m8
	STA wm_ExOamSlot.1.XPos,Y
	LDA m3
	CLC
	ADC m9
	STA wm_ExOamSlot.1.YPos,Y
	PHX
	LDA m5
	AND #$03
	STA m15
	ASL
	ASL
	ASL
	ADC m15
	ADC m15
	ADC m7
	TAX
	LDA.W DATA_03C9B9,X
	STA wm_ExOamSlot.1.Tile,Y
	PLX
	LDA m5
	LSR
	NOP
	NOP
	PHX
	LDX m10
	CPX #$03
	BEQ +
	EOR m4
+	AND #$0E
	ORA #$31
	STA wm_ExOamSlot.1.Prop,Y
	PLX
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
	DEX
	BMI CODE_03CADA
	JMP _03CA0D

CODE_03CADA:
	LDX #$53
_03CADC:
	STX m4
	LDA m10
	CMP #$03
	LDA.W DATA_03C626,X
	BCC +
	LDA.W DATA_03C6CE,X
+	SEC
	SBC #$40
	STA m0
	LDA m10
	CMP #$03
	LDA.W DATA_03C67A,X
	BCC +
	LDA.W DATA_03C722,X
+	SEC
	SBC #$50
	STA m1
	PHY
	LDA m0
	BPL +
	EOR #$FF
	INC A
+	STA WRMPYA
	LDA m6
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	LDY m0
	BPL +
	EOR #$FF
	INC A
+	STA m2
	LDA m1
	BPL +
	EOR #$FF
	INC A
+	STA WRMPYA
	LDA m6
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	LDY m1
	BPL +
	EOR #$FF
	INC A
+	STA m3
	LDY #$00
	LDA m7
	CMP #$06
	BCC +
	LDA m5
	CLC
	ADC m4
	LSR
	LSR
	AND #$07
	TAY
+	LDA DATA_03C9E1,Y
	PLY
	CLC
	ADC m2
	CLC
	ADC m8
	STA wm_OamSlot.1.XPos,Y
	LDA m3
	CLC
	ADC m9
	STA wm_OamSlot.1.YPos,Y
	PHX
	LDA m5
	AND #$03
	STA m15
	ASL
	ASL
	ASL
	ADC m15
	ADC m15
	ADC m7
	TAX
	LDA.W DATA_03C9B9,X
	STA wm_OamSlot.1.Tile,Y
	PLX
	LDA m5
	LSR
	NOP
	NOP
	PHX
	LDX m10
	CPX #$03
	BEQ +
	EOR m4
+	AND #$0E
	ORA #$31
	STA wm_OamSlot.1.Prop,Y
	PLX
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	DEX
	CPX #$3F
	BEQ CODE_03CBAB
	JMP _03CADC

CODE_03CBAB:
	PLX
	RTS

ChuckSprGenDispX:	.DB $14,$EC

ChuckSprGenSpeedHi:	.DB $00,$FF

ChuckSprGenSpeedLo:	.DB $18,$E8

CODE_03CBB3:
	JSL FindFreeSprSlot
	BMI +
	LDA #$1B
	STA.W wm_SpriteNum,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	LDA wm_SpriteXLo,X
	STA m1
	LDA wm_SpriteXHi,X
	STA m0
	PHX
	LDA wm_SpriteDir,X
	TAX
	LDA m1
	CLC
	ADC.L ChuckSprGenDispX,X
	STA.W wm_SpriteXLo,Y
	LDA m0
	ADC.L ChuckSprGenSpeedHi,X
	STA wm_SpriteXHi,Y
	LDA.L ChuckSprGenSpeedLo,X
	STA.W wm_SpriteSpeedX,Y
	LDA #$E0
	STA.W wm_SpriteSpeedY,Y
	LDA #$10
	STA wm_SpriteDecTbl1,Y
	PLX
+	RTL

CODE_03CC09:
	PHB
	PHK
	PLB
	STZ wm_Tweaker1662,X
	JSR CODE_03CC14
	PLB
	RTL

CODE_03CC14:
	JSR CODE_03D484
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE Return03CC37
	LDA wm_SpritesLocked
	BNE Return03CC37
	LDA wm_SpriteMiscTbl3,X
	JSL ExecutePtr

PipeKoopaPtrs:
	.DW CODE_03CC8A
	.DW CODE_03CD21
	.DW CODE_03CDC7
	.DW CODE_03CDEF
	.DW CODE_03CE0E
	.DW CODE_03CE5A
	.DW CODE_03CE89

Return03CC37:
	RTS

DATA_03CC38:	.DB $18,$38,$58,$78,$98,$B8,$D8,$78

DATA_03CC40:	.DB $40,$50,$50,$40,$30,$40,$50,$40

DATA_03CC48:
	.DB $50,$4A,$50,$4A,$4A,$40,$4A,$48
	.DB $4A

DATA_03CC51:
	.DB $02,$04,$06,$08,$0B,$0C,$0E,$10
	.DB $13

DATA_03CC5A:
	.DB $00,$01,$02,$03,$04,$05,$06,$00
	.DB $01,$02,$03,$04,$05,$06,$00,$01
	.DB $02,$03,$04,$05,$06,$00,$01,$02
	.DB $03,$04,$05,$06,$00,$01,$02,$03
	.DB $04,$05,$06,$00,$01,$02,$03,$04
	.DB $05,$06,$00,$01,$02,$03,$04,$05

CODE_03CC8A:
	LDA wm_SpriteDecTbl1,X
	BNE ++
	LDA wm_SpriteMiscTbl6,X
	BNE +
	JSL GetRand
	AND #$0F
	STA wm_SpriteMiscTbl8,X
+	LDA wm_SpriteMiscTbl8,X
	ORA wm_SpriteMiscTbl6,X
	TAY
	LDA DATA_03CC5A,Y
	TAY
	LDA DATA_03CC38,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteState,X
	CMP #$06
	LDA DATA_03CC40,Y
	BCC +
	LDA #$50
+	STA wm_SpriteYLo,X
	LDA #$08
	LDY wm_SpriteMiscTbl6,X
	BNE +
	JSR CODE_03CCE2
	JSL GetRand
	LSR
	LSR
	AND #$07
+	STA wm_SpriteMiscTbl4,X
	TAY
	LDA DATA_03CC48,Y
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteMiscTbl3,X
	LDA DATA_03CC51,Y
	STA wm_SpriteGfxTbl,X
++	RTS

DATA_03CCE0:	.DB $10,$20

CODE_03CCE2:
	LDY #$01
	JSR _03CCE8
	DEY
_03CCE8:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$29
	STA.W wm_SpriteNum,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	LDA DATA_03CCE0,Y
	STA wm_SpriteMiscTbl6,Y
	LDA wm_SpriteState,X
	STA.W wm_SpriteState,Y
	LDA wm_SpriteMiscTbl8,X
	STA wm_SpriteMiscTbl8,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	RTS

CODE_03CD21:
	LDA wm_SpriteDecTbl1,X
	BNE +
	LDA #$40
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteMiscTbl3,X
+	LDA #$F8
	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	RTS

DATA_03CD37:
	.DB $02,$02,$02,$02,$03,$03,$03,$03
	.DB $03,$03,$03,$03,$02,$02,$02,$02
	.DB $04,$04,$04,$04,$05,$05,$04,$05
	.DB $05,$04,$05,$05,$04,$04,$04,$04
	.DB $06,$06,$06,$06,$07,$07,$07,$07
	.DB $07,$07,$07,$07,$06,$06,$06,$06
	.DB $08,$08,$08,$08,$08,$09,$09,$08
	.DB $08,$09,$09,$08,$08,$08,$08,$08
	.DB $0B,$0B,$0B,$0B,$0B,$0A,$0B,$0A
	.DB $0B,$0A,$0B,$0A,$0B,$0B,$0B,$0B
	.DB $0C,$0C,$0C,$0C,$0D,$0C,$0D,$0C
	.DB $0D,$0C,$0D,$0C,$0D,$0D,$0D,$0D
	.DB $0E,$0E,$0E,$0E,$0E,$0F,$0E,$0F
	.DB $0E,$0F,$0E,$0F,$0E,$0E,$0E,$0E
	.DB $10,$10,$10,$10,$11,$12,$11,$10
	.DB $11,$12,$11,$10,$11,$11,$11,$11
	.DB $13,$13,$13,$13,$13,$13,$13,$13
	.DB $13,$13,$13,$13,$13,$13,$13,$13

CODE_03CDC7:
	JSR CODE_03CEA7
	LDA wm_SpriteDecTbl1,X
	BNE CODE_03CDDA
_03CDCF:
	LDA #$24
	STA wm_SpriteDecTbl1,X
	LDA #$03
	STA wm_SpriteMiscTbl3,X
	RTS

CODE_03CDDA:
	LSR
	LSR
	STA m0
	LDA wm_SpriteMiscTbl4,X
	ASL
	ASL
	ASL
	ASL
	ORA m0
	TAY
	LDA DATA_03CD37,Y
	STA wm_SpriteGfxTbl,X
	RTS

CODE_03CDEF:
	LDA wm_SpriteDecTbl1,X
	BNE _03CE05
	LDA wm_SpriteMiscTbl6,X
	BEQ CODE_03CDFD
	STZ wm_SpriteStatus,X
	RTS

CODE_03CDFD:
	STZ wm_SpriteMiscTbl3,X
	LDA #$30
	STA wm_SpriteDecTbl1,X
_03CE05:
	LDA #$10
	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	RTS

CODE_03CE0E:
	LDA wm_SpriteDecTbl1,X
	BNE CODE_03CE2A
	INC wm_SpriteMiscTbl5,X
	LDA wm_SpriteMiscTbl5,X
	CMP #$03
	BNE _03CDCF
	LDA #$05
	STA wm_SpriteMiscTbl3,X
	STZ wm_SpriteSpeedY,X
	LDA #$23
	STA wm_SoundCh1
	RTS

CODE_03CE2A:
	LDY wm_SpriteMiscTbl6,X
	BNE CODE_03CE42
_03CE2F:
	CMP #$24
	BNE +
	LDY #$29
	STY wm_SoundCh3
+	LDA wm_FrameB
	LSR
	LSR
	AND #$01
	STA wm_SpriteGfxTbl,X
	RTS

CODE_03CE42:
	CMP #$10
	BNE +
	LDY #$2A
	STY wm_SoundCh3
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_03CE56,Y
	STA wm_SpriteGfxTbl,X
	RTS

DATA_03CE56:	.DB $16,$16,$15,$14

CODE_03CE5A:
	JSL UpdateYPosNoGrvty
	LDA wm_SpriteSpeedY,X
	CMP #$40
	BPL +
	CLC
	ADC #$03
	STA wm_SpriteSpeedY,X
+	LDA wm_SpriteYHi,X
	BEQ +
	LDA wm_SpriteYLo,X
	CMP #$85
	BCC +
	LDA #$06
	STA wm_SpriteMiscTbl3,X
	LDA #$80
	STA wm_SpriteDecTbl1,X
	LDA #$20
	STA wm_SoundCh3
	JSL CODE_028528
+	BRA _03CE2F

CODE_03CE89:
	LDA wm_SpriteDecTbl1,X
	BNE +
	STZ wm_SpriteStatus,X
	INC wm_CutsceneNum
	LDA #$FF
	STA wm_EndLevelTimer
	LDA #$0B
	STA wm_MusicCh1
+	LDA #$04
	STA wm_SpriteSpeedY,X
	JSL UpdateYPosNoGrvty
	RTS

CODE_03CEA7:
	JSL MarioSprInteract
	BCC _Return03CEF1
	LDA wm_MarioSpeedY
	CMP #$10
	BMI CODE_03CEED
	JSL DisplayContactGfx
	LDA #$02
	JSL GivePoints
	JSL BoostMarioSpeed
	LDA #$02
	STA wm_SoundCh1
	LDA wm_SpriteMiscTbl6,X
	BNE +
	LDA #$28
	STA wm_SoundCh3
	LDA wm_SpriteMiscTbl5,X
	CMP #$02
	BNE +
	JSL KillMostSprites
+	LDA #$04
	STA wm_SpriteMiscTbl3,X
	LDA #$50
	LDY wm_SpriteMiscTbl6,X
	BEQ +
	LDA #$1F
+	STA wm_SpriteDecTbl1,X
	RTS

CODE_03CEED:
	JSL HurtMario
_Return03CEF1:
	RTS

DATA_03CEF2:
	.DB $F8,$08,$F8,$08,$00,$00,$F8,$08
	.DB $F8,$08,$00,$00,$F8,$00,$00,$00
	.DB $00,$00,$FB,$00,$FB,$03,$00,$00
	.DB $F8,$08,$00,$00,$08,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$00,$00,$00
	.DB $00,$00,$F8,$00,$08,$00,$00,$00
	.DB $F8,$08,$00,$06,$00,$00,$F8,$08
	.DB $00,$02,$00,$00,$F8,$08,$00,$04
	.DB $00,$08,$F8,$08,$00,$00,$08,$00
	.DB $F8,$08,$00,$00,$00,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$08,$00,$00
	.DB $08,$00,$F8,$08,$00,$00,$08,$00
	.DB $F8,$08,$00,$00,$00,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$08,$00,$00
	.DB $00,$00,$F8,$08,$00,$00,$08,$00
	.DB $F8,$08,$00,$00,$00,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$08,$00,$00
	.DB $00,$00

DATA_03CF7C:
	.DB $F8,$08,$F8,$08,$00,$00,$F8,$08
	.DB $F8,$08,$00,$00,$F8,$00,$08,$00
	.DB $00,$00,$FB,$00,$FB,$03,$00,$00
	.DB $F8,$08,$00,$00,$08,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$00,$08,$00
	.DB $00,$00,$F8,$00,$08,$00,$00,$00
	.DB $F8,$08,$00,$06,$00,$08,$F8,$08
	.DB $00,$02,$00,$08,$F8,$08,$00,$04
	.DB $00,$08,$F8,$08,$00,$00,$08,$00
	.DB $F8,$08,$00,$00,$00,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$08,$00,$00
	.DB $08,$00,$F8,$08,$00,$00,$08,$00
	.DB $F8,$08,$00,$00,$00,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$08,$00,$00
	.DB $00,$00,$F8,$08,$00,$00,$08,$00
	.DB $F8,$08,$00,$00,$00,$00,$F8,$08
	.DB $00,$00,$00,$00,$F8,$08,$00,$00
	.DB $00,$00

DATA_03D006:
	.DB $04,$04,$14,$14,$00,$00,$04,$04
	.DB $14,$14,$00,$00,$00,$08,$F8,$00
	.DB $00,$00,$00,$08,$F8,$F8,$00,$00
	.DB $05,$05,$00,$F8,$F8,$00,$05,$05
	.DB $00,$00,$00,$00,$00,$08,$F8,$00
	.DB $00,$00,$00,$08,$00,$00,$00,$00
	.DB $05,$05,$00,$F8,$00,$00,$05,$05
	.DB $00,$F8,$00,$00,$05,$05,$00,$0F
	.DB $F8,$F8,$05,$05,$00,$F8,$F8,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$05,$05,$00,$F8
	.DB $F8,$00,$05,$05,$00,$F8,$F8,$00
	.DB $04,$04,$02,$00,$00,$00,$04,$04
	.DB $01,$00,$00,$00,$04,$04,$00,$00
	.DB $00,$00,$05,$05,$00,$F8,$F8,$00
	.DB $05,$05,$00,$00,$00,$00,$05,$05
	.DB $03,$00,$00,$00,$05,$05,$04,$00
	.DB $00,$00

DATA_03D090:
	.DB $04,$04,$14,$14,$00,$00,$04,$04
	.DB $14,$14,$00,$00,$00,$08,$00,$00
	.DB $00,$00,$00,$08,$F8,$F8,$00,$00
	.DB $05,$05,$00,$F8,$F8,$00,$05,$05
	.DB $00,$00,$00,$00,$00,$08,$00,$00
	.DB $00,$00,$00,$08,$08,$00,$00,$00
	.DB $05,$05,$00,$F8,$F8,$00,$05,$05
	.DB $00,$F8,$F8,$00,$05,$05,$00,$0F
	.DB $F8,$F8,$05,$05,$00,$F8,$F8,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$05,$05,$00,$F8
	.DB $F8,$00,$05,$05,$00,$F8,$F8,$00
	.DB $04,$04,$02,$00,$00,$00,$04,$04
	.DB $01,$00,$00,$00,$04,$04,$00,$00
	.DB $00,$00,$05,$05,$00,$F8,$F8,$00
	.DB $05,$05,$00,$00,$00,$00,$05,$05
	.DB $03,$00,$00,$00,$05,$05,$04,$00
	.DB $00,$00

DATA_03D11A:
	.DB $20,$20,$26,$26,$08,$00,$2E,$2E
	.DB $24,$24,$08,$00,$00,$28,$02,$00
	.DB $00,$00,$04,$28,$12,$12,$00,$00
	.DB $22,$22,$04,$12,$12,$00,$20,$20
	.DB $08,$00,$00,$00,$00,$28,$02,$00
	.DB $00,$00,$0A,$28,$13,$00,$00,$00
	.DB $20,$20,$0C,$02,$00,$00,$20,$20
	.DB $0C,$02,$00,$00,$22,$22,$06,$03
	.DB $12,$12,$20,$20,$06,$12,$12,$00
	.DB $2A,$2A,$00,$00,$00,$00,$2C,$2C
	.DB $00,$00,$00,$00,$20,$20,$06,$12
	.DB $12,$00,$20,$20,$06,$12,$12,$00
	.DB $22,$22,$08,$00,$00,$00,$20,$20
	.DB $08,$00,$00,$00,$2E,$2E,$08,$00
	.DB $00,$00,$4E,$4E,$60,$43,$43,$00
	.DB $4E,$4E,$64,$00,$00,$00,$62,$62
	.DB $64,$00,$00,$00,$62,$62,$64,$00
	.DB $00,$00

DATA_03D1A4:
	.DB $20,$20,$26,$26,$48,$00,$2E,$2E
	.DB $24,$24,$48,$00,$40,$28,$42,$00
	.DB $00,$00,$44,$28,$52,$52,$00,$00
	.DB $22,$22,$44,$52,$52,$00,$20,$20
	.DB $48,$00,$00,$00,$40,$28,$42,$00
	.DB $00,$00,$4A,$28,$53,$00,$00,$00
	.DB $20,$20,$4C,$1E,$1F,$00,$20,$20
	.DB $4C,$1F,$1E,$00,$22,$22,$44,$03
	.DB $52,$52,$20,$20,$44,$52,$52,$00
	.DB $2A,$2A,$00,$00,$00,$00,$2C,$2C
	.DB $00,$00,$00,$00,$20,$20,$46,$52
	.DB $52,$00,$20,$20,$46,$52,$52,$00
	.DB $22,$22,$48,$00,$00,$00,$20,$20
	.DB $48,$00,$00,$00,$2E,$2E,$48,$00
	.DB $00,$00,$4E,$4E,$66,$68,$68,$00
	.DB $4E,$4E,$6A,$00,$00,$00,$62,$62
	.DB $6A,$00,$00,$00,$62,$62,$6A,$00
	.DB $00,$00

LemmyGfxProp:
	.DB $05,$45,$05,$45,$05,$00,$05,$45
	.DB $05,$45,$05,$00,$05,$05,$05,$00
	.DB $00,$00,$05,$05,$05,$45,$00,$00
	.DB $05,$45,$05,$05,$45,$00,$05,$45
	.DB $05,$00,$00,$00,$05,$05,$05,$00
	.DB $00,$00,$05,$05,$05,$00,$00,$00
	.DB $05,$45,$05,$05,$00,$00,$05,$45
	.DB $45,$45,$00,$00,$05,$45,$05,$05
	.DB $05,$45,$05,$45,$45,$05,$45,$00
	.DB $05,$45,$00,$00,$00,$00,$05,$45
	.DB $00,$00,$00,$00,$05,$45,$45,$05
	.DB $45,$00,$05,$45,$05,$05,$45,$00
	.DB $05,$45,$05,$00,$00,$00,$05,$45
	.DB $05,$00,$00,$00,$05,$45,$05,$00
	.DB $00,$00,$07,$47,$07,$07,$47,$00
	.DB $07,$47,$07,$00,$00,$00,$07,$47
	.DB $07,$00,$00,$00,$07,$47,$07,$00
	.DB $00,$00

WendyGfxProp:
	.DB $09,$49,$09,$49,$09,$00,$09,$49
	.DB $09,$49,$09,$00,$09,$09,$09,$00
	.DB $00,$00,$09,$09,$09,$49,$00,$00
	.DB $09,$49,$09,$09,$49,$00,$09,$49
	.DB $09,$00,$00,$00,$09,$09,$09,$00
	.DB $00,$00,$09,$09,$09,$00,$00,$00
	.DB $09,$49,$09,$09,$09,$00,$09,$49
	.DB $49,$49,$49,$00,$09,$49,$09,$09
	.DB $09,$49,$09,$49,$49,$09,$49,$00
	.DB $09,$49,$00,$00,$00,$00,$09,$49
	.DB $00,$00,$00,$00,$09,$49,$49,$09
	.DB $49,$00,$09,$49,$09,$09,$49,$00
	.DB $09,$49,$09,$00,$00,$00,$09,$49
	.DB $09,$00,$00,$00,$09,$49,$09,$00
	.DB $00,$00,$05,$45,$05,$05,$45,$00
	.DB $05,$45,$05,$00,$00,$00,$05,$45
	.DB $05,$00,$00,$00,$05,$45,$05,$00
	.DB $00,$00

DATA_03D342:
	.DB $02,$02,$02,$02,$02,$04,$02,$02
	.DB $02,$02,$02,$04,$02,$02,$00,$04
	.DB $04,$04,$02,$02,$00,$00,$04,$04
	.DB $02,$02,$02,$00,$00,$04,$02,$02
	.DB $02,$04,$04,$04,$02,$02,$00,$04
	.DB $04,$04,$02,$02,$00,$04,$04,$04
	.DB $02,$02,$02,$00,$04,$04,$02,$02
	.DB $02,$00,$04,$04,$02,$02,$02,$00
	.DB $00,$00,$02,$02,$02,$00,$00,$04
	.DB $02,$02,$04,$04,$04,$04,$02,$02
	.DB $04,$04,$04,$04,$02,$02,$02,$00
	.DB $00,$04,$02,$02,$02,$00,$00,$04
	.DB $02,$02,$02,$04,$04,$04,$02,$02
	.DB $02,$04,$04,$04,$02,$02,$02,$04
	.DB $04,$04,$02,$02,$02,$00,$00,$04
	.DB $02,$02,$02,$04,$04,$04,$02,$02
	.DB $02,$04,$04,$04,$02,$02,$02,$04
	.DB $04,$04

DATA_03D3CC:
	.DB $02,$02,$02,$02,$02,$04,$02,$02
	.DB $02,$02,$02,$04,$02,$02,$00,$04
	.DB $04,$04,$02,$02,$00,$00,$04,$04
	.DB $02,$02,$02,$00,$00,$04,$02,$02
	.DB $02,$04,$04,$04,$02,$02,$00,$04
	.DB $04,$04,$02,$02,$00,$04,$04,$04
	.DB $02,$02,$02,$00,$00,$04,$02,$02
	.DB $02,$00,$00,$04,$02,$02,$02,$00
	.DB $00,$00,$02,$02,$02,$00,$00,$04
	.DB $02,$02,$04,$04,$04,$04,$02,$02
	.DB $04,$04,$04,$04,$02,$02,$02,$00
	.DB $00,$04,$02,$02,$02,$00,$00,$04
	.DB $02,$02,$02,$04,$04,$04,$02,$02
	.DB $02,$04,$04,$04,$02,$02,$02,$04
	.DB $04,$04,$02,$02,$02,$00,$00,$04
	.DB $02,$02,$02,$04,$04,$04,$02,$02
	.DB $02,$04,$04,$04,$02,$02,$02,$04
	.DB $04,$04

DATA_03D456:
	.DB $04,$04,$02,$03,$04,$02,$02,$02
	.DB $03,$03,$05,$04,$01,$01,$04,$04
	.DB $02,$02,$02,$04,$02,$02,$02

DATA_03D46D:
	.DB $04,$04,$02,$03,$04,$02,$02,$02
	.DB $04,$04,$05,$04,$01,$01,$04,$04
	.DB $02,$02,$02,$04,$02,$02,$02

CODE_03D484:
	JSR GetDrawInfoBnk3
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	ADC wm_SpriteGfxTbl,X
	ADC wm_SpriteGfxTbl,X
	STA m2
	LDA wm_SpriteState,X
	CMP #$06
	BEQ CODE_03D4DF
	PHX
	LDA wm_SpriteGfxTbl,X
	TAX
	LDA.W DATA_03D456,X
	TAX
-	PHX
	TXA
	CLC
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W DATA_03CEF2,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_03D006,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_03D11A,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W LemmyGfxProp,X
	ORA #$10
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_03D342,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	PLX
	DEX
	BPL -
_03D4DD:
	PLX
	RTS

CODE_03D4DF:
	PHX
	LDA wm_SpriteGfxTbl,X
	TAX
	LDA.W DATA_03D46D,X
	TAX
-	PHX
	TXA
	CLC
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W DATA_03CF7C,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_03D090,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W DATA_03D1A4,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W WendyGfxProp,X
	ORA #$10
	STA wm_OamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W DATA_03D3CC,X
	STA wm_OamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	PLX
	DEX
	BPL -
	BRA _03D4DD

DATA_03D524:
	.DB $18,$20,$A1,$0E,$20,$20,$88,$0E
	.DB $28,$20,$AB,$0E,$30,$20,$99,$0E
	.DB $38,$20,$A8,$0E,$40,$20,$BF,$0E
	.DB $48,$20,$AC,$0E,$58,$20,$88,$0E
	.DB $60,$20,$8B,$0E,$68,$20,$AF,$0E
	.DB $70,$20,$8C,$0E,$78,$20,$9E,$0E
	.DB $80,$20,$AD,$0E,$88,$20,$AE,$0E
	.DB $90,$20,$AB,$0E,$98,$20,$8C,$0E
	.DB $A8,$20,$99,$0E,$B0,$20,$AC,$0E
	.DB $C0,$20,$A8,$0E,$C8,$20,$AF,$0E
	.DB $D0,$20,$8C,$0E,$D8,$20,$AB,$0E
	.DB $E0,$20,$BD,$0E,$18,$30,$A1,$0E
	.DB $20,$30,$88,$0E,$28,$30,$AB,$0E
	.DB $30,$30,$99,$0E,$38,$30,$A8,$0E
	.DB $40,$30,$BE,$0E,$48,$30,$AD,$0E
	.DB $50,$30,$98,$0E,$58,$30,$8C,$0E
	.DB $68,$30,$A0,$0E,$70,$30,$AB,$0E
	.DB $78,$30,$99,$0E,$80,$30,$9E,$0E
	.DB $88,$30,$8A,$0E,$90,$30,$8C,$0E
	.DB $98,$30,$AC,$0E,$A0,$30,$AC,$0E
	.DB $A8,$30,$BE,$0E,$B0,$30,$B0,$0E
	.DB $B8,$30,$A8,$0E,$C0,$30,$AC,$0E
	.DB $C8,$30,$98,$0E,$D0,$30,$99,$0E
	.DB $D8,$30,$BE,$0E,$18,$40,$88,$0E
	.DB $20,$40,$9E,$0E,$28,$40,$8B,$0E
	.DB $38,$40,$98,$0E,$40,$40,$99,$0E
	.DB $48,$40,$AC,$0E,$58,$40,$8D,$0E
	.DB $60,$40,$AB,$0E,$68,$40,$99,$0E
	.DB $70,$40,$8C,$0E,$78,$40,$9E,$0E
	.DB $80,$40,$8B,$0E,$88,$40,$AC,$0E
	.DB $98,$40,$88,$0E,$A0,$40,$AB,$0E
	.DB $A8,$40,$8C,$0E,$B8,$40,$8E,$0E
	.DB $C0,$40,$A8,$0E,$C8,$40,$99,$0E
	.DB $D0,$40,$9E,$0E,$D8,$40,$8E,$0E
	.DB $18,$50,$AD,$0E,$20,$50,$A8,$0E
	.DB $30,$50,$AD,$0E,$38,$50,$88,$0E
	.DB $40,$50,$9B,$0E,$48,$50,$8C,$0E
	.DB $58,$50,$88,$0E,$68,$50,$AF,$0E
	.DB $70,$50,$88,$0E,$78,$50,$8A,$0E
	.DB $80,$50,$88,$0E,$88,$50,$AD,$0E
	.DB $90,$50,$99,$0E,$98,$50,$A8,$0E
	.DB $A0,$50,$9E,$0E,$A8,$50,$BD,$0E

CODE_03D674:
	PHX
	REP #$30
	LDX wm_EndMsgLetter
	BEQ +
	DEX
	LDY #$0000
-	PHX
	TXA
	ASL
	ASL
	TAX
	LDA.W DATA_03D524,X
	STA wm_ExOamSlot.1.XPos,Y
	LDA.W DATA_03D524+2,X
	STA wm_ExOamSlot.1.Tile,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	SEP #$20
	LDA #$00
	STA wm_ExOamSize.1,Y
	REP #$20
	PLY
	PLX
	INY
	INY
	INY
	INY
	DEX
	BPL -
+	SEP #$30
	PLX
	RTS

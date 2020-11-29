DATA_04F280:	.DB $00,$D8,$28,$D0,$30,$D8,$28,$00

DATA_04F288:	.DB $D0,$D8,$D8,$00,$00,$28,$28,$30

CODE_04F290:
	LDY wm_KeyHolePos2+1
	CPY.B #$0C
	BCC CODE_04F29B
	STZ wm_SwitchPalaceCol
	RTS

CODE_04F29B:
	LDA wm_KeyHolePos1+1
	BNE _04F314
	CPY.B #$08
	BCS +++
	LDA.B #$1C
	STA wm_SoundCh3
	LDA.B #$07
	STA m0
	LDX wm_KeyHolePos1
-	LDY wm_OWCharB
	LDA wm_MapData.MarioXPos,Y
	STA wm_L2TilesLo+120,X
	LDA wm_MapData.MarioXPos+1,Y
	STA wm_L2TilesLo,X
	LDA wm_MapData.MarioYPos,Y
	STA wm_L2TilesLo+160,X
	LDA wm_MapData.MarioYPos+1,Y
	STA wm_L2TilesLo+40,X
	LDA.B #$00
	STA wm_L2TilesLo+200,X
	STA wm_L2TilesLo+80,X
	LDY m0
	LDA DATA_04F280,Y
	STA wm_L2TilesLo+240,X
	LDA DATA_04F288,Y
	STA wm_L2TilesLo+280,X
	LDA.B #$D0
	STA wm_L2TilesLo+320,X
	INX
	DEC m0
	BPL -
	CPX.B #$28
	BCC ++
	LDA wm_KeyHolePos2
	CLC
	ADC.B #$20
	CMP.B #$A0
	BCC +
	LDA.B #$00
+	STA wm_KeyHolePos2
	LDX.B #$00
++	STX wm_KeyHolePos1
+++	LDA.B #$10
	STA wm_KeyHolePos1+1
	INC wm_KeyHolePos2+1
_04F314:
	DEC wm_KeyHolePos1+1
	LDA wm_KeyHolePos2
	STA m15
	LDX.B #$00
-	PHX
	LDY.B #$00
	JSR _04F39C
	JSR CODE_04F397
	JSR CODE_04F397
	PLX
	LDA wm_L2TilesLo+320,X
	CLC
	ADC.B #$01
	BMI +
	CMP.B #$40
	BCC +
	LDA.B #$40
+	STA wm_L2TilesLo+320,X
	LDA wm_L2TilesLo+80,X
	XBA
	LDA wm_L2TilesLo+200,X
	REP #$20
	CLC
	ADC m2
	STA m2
	SEP #$20
	XBA
	ORA m1
	BNE +
	LDY m15
	XBA
	STA wm_OamSlot.17.YPos,Y
	LDA m0
	STA wm_OamSlot.17.XPos,Y
	LDA #$E6
	STA wm_OamSlot.17.Tile,Y
	LDA wm_SwitchPalaceCol
	DEC A
	ASL
	ORA #$30
	STA wm_OamSlot.17.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_OamSize.17,Y
+	LDA m15
	CLC
	ADC #$04
	CMP #$A0
	BCC +
	LDA #$00
+	STA m15
	INX
	CPX wm_KeyHolePos1
	BCC -
	LDA wm_KeyHolePos2+1
	CMP #$05
	BCC +
	CPX.B #$28
	BCC -
+	RTS

CODE_04F397:
	TXA
	CLC
	ADC #$28
	TAX
_04F39C:
	PHY
	LDA wm_L2TilesLo+240,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_L2TilesLo+360,X
	STA wm_L2TilesLo+360,X
	LDA wm_L2TilesLo+240,X
	PHP
	LSR
	LSR
	LSR
	LSR
	LDY.B #$00
	PLP
	BPL +
	ORA #$F0
	DEY
+	ADC wm_L2TilesLo+120,X
	STA wm_L2TilesLo+120,X
	XBA
	TYA
	ADC wm_L2TilesLo,X
	STA wm_L2TilesLo,X
	XBA
	PLY
	REP #$20
	SEC
	SBC.W wm_Bg1HOfs,Y
	SEC
	SBC #$0008
	STA.W m0,Y
	SEP #$20
	INY
	INY
	RTS

CODE_04F3E5:
	DEC A
	JSL ExecutePtr

Ptrs04F3EA:
	.DW CODE_04F3FF
	.DW CODE_04F415
	.DW CODE_04F513
	.DW CODE_04F415
	.DW CODE_04F3FF
	.DW CODE_04F415
	.DW CODE_04F3FA
	.DW CODE_04F415

CODE_04F3FA:
	JSL CODE_009BA8
	RTS

CODE_04F3FF:
	LDA #$22
	STA wm_SoundCh3
	INC wm_OWPromptTrig
_04F407:
	STZ wm_W12Sel
	STZ wm_W34Sel
	STZ wm_WObjSel
	STZ wm_HDMAEn
	RTS

DATA_04F411:	.DB $04,$FC

DATA_04F413:	.DB $68,$00

CODE_04F415:
	LDX.B #$00
	LDA wm_2PMarioLives
	CMP wm_2PLuigiLives
	BPL +
	INX
+	STX wm_OWGiveLifeFrom
	LDX wm_MsgBoxActionFlag
	LDA wm_MsgBoxActionTimer
	CMP.L DATA_04F413,X
	BNE CODE_04F44B
	INC wm_OWPromptTrig
	LDA wm_OWPromptTrig
	CMP #$07
	BNE +
	LDY.B #$1E
	STY wm_ImageLoader
+	DEC A
	AND #$03
	BNE Return04F44A
	STZ wm_OWPromptTrig
	STZ wm_MsgBoxActionFlag
	BRA _04F407

Return04F44A:
	RTS

CODE_04F44B:
	CLC
	ADC.L DATA_04F411,X
	STA wm_MsgBoxActionTimer
	CLC
	ADC #$80
	XBA
	REP #$10
	LDX #$016E
	LDA #$FF
-	STA wm_HDMAWindowsTbl+80,X
	STZ wm_HDMAWindowsTbl+81,X
	DEX
	DEX
	BPL -
	SEP #$10
	LDA wm_MsgBoxActionTimer
	LSR
	ADC wm_MsgBoxActionTimer
	LSR
	AND #$FE
	TAX
	LDA #$80
	SEC
	SBC wm_MsgBoxActionTimer
	REP #$20
	LDY #$48
-	STA wm_HDMAWindowsTbl+168,Y
	STA wm_HDMAWindowsTbl+240,X
	DEY
	DEY
	DEX
	DEX
	BPL -
	STZ wm_LvBgColor
	SEP #$20
	LDA #$22
	STA wm_W12Sel
	LDA #$20
	JMP _04DB95

DATA_04F499:	.INCBIN "images/menus/nomenu.stim"

DATA_04F4B2:	.INCBIN "images/menus/mario_luigi.stim"

DATA_04F503:	.DB $7D,$38,$7E,$78

DATA_04F507:	.DB $7E,$38,$7D,$78

DATA_04F50B:	.DB $7D,$B8,$7E,$F8

DATA_04F50F:	.DB $7E,$B8,$7D,$F8

CODE_04F513:
	LDA wm_JoyFrameAP1
	ORA wm_JoyFrameAP2
	AND #$10
	BEQ CODE_04F52B
	LDX wm_OWCharA
	LDA wm_2PMarioLives,X
	STA wm_StatusLives
	JSL CODE_009C13
	RTS

CODE_04F52B:
	LDA wm_JoyFrameAP1
	AND #$C0
	BNE +
	LDA wm_JoyFrameAP2
	AND #$C0
	BEQ ++
	EOR #$C0
+	LDX #$01
	ASL
	BCS +
	DEX
+	CPX wm_OWGiveLifeFrom
	BEQ +
	LDA #$18
	STA wm_OWGiveLifeTimer
+	STX wm_OWGiveLifeFrom
	TXA
	EOR #$01
	TAY
	LDA wm_2PMarioLives,X
	BEQ ++
	BMI ++
	LDA wm_2PMarioLives,Y
	CMP #$62
	BPL ++
	INC A
	STA wm_2PMarioLives,Y
	DEC wm_2PMarioLives,X
	LDA #$23
	STA wm_SoundCh3
++	REP #$20
	LDA #$7848
	STA wm_ExOamSlot.40.XPos
	LDA #$7890
	STA wm_ExOamSlot.41.XPos
	LDA #$340A
	STA wm_ExOamSlot.40.Tile
	LDA #$360A
	STA wm_ExOamSlot.41.Tile
	SEP #$20
	LDA #$02
	STA wm_ExOamSize.40
	STA wm_ExOamSize.41
	JSL CODE_05DBF2
	LDY #$50
	TYA
	CLC
	ADC wm_ImageIndex
	STA wm_ImageIndex
	TAX
-	LDA DATA_04F4B2,Y
	STA wm_ImageTable,X
	DEX
	DEY
	BPL -
	INX
	REP #$20
	LDY wm_2PMarioLives
	BMI +
	LDA #$38FC
	STA wm_ImageTable.35.ImgL,X
	STA wm_ImageTable.36.ImgL,X
+	LDY wm_2PLuigiLives
	BMI +
	LDA #$38FC
	STA wm_ImageTable.39.ImgL,X
	STA wm_ImageTable.40.ImgL,X
+	SEP #$20
	INC wm_OWGiveLifeTimer
	LDA wm_OWGiveLifeTimer
	AND #$18
	BEQ +
	LDA wm_OWGiveLifeFrom
	ASL
	TAY
	REP #$20
	LDA DATA_04F503,Y
	STA wm_ImageTable.27.ImgL,X
	LDA DATA_04F507,Y
	STA wm_ImageTable.28.ImgL,X
	LDA DATA_04F50B,Y
	STA wm_ImageTable.31.ImgL,X
	LDA DATA_04F50F,Y
	STA wm_ImageTable.32.ImgL,X
	SEP #$20
+	LDA wm_2PMarioLives
	JSR _04F60E
	TXA
	CLC
	ADC #$0A
	TAX
	LDA wm_2PLuigiLives
_04F60E:
	INC A
	PHX
	JSL CODE_00974C
	TXY
	BNE +
	LDX #$FC
+	TXY
	PLX
	STA wm_ImageTable.19.ImgL,X
	TYA
	STA wm_ImageTable.18.ImgL,X
	RTS

DATA_04F625:
	.DB $00
	.DW 256,224
	.DB $00
	.DW 256,96
	.DB $06
	.DW 368,32
	.DB $07
	.DW 56,394
	.DB $00
	.DW 88,122
	.DB $08
	.DW 392,24
	.DB $09
	.DW 328,-4
	.DB $00
	.DW 128,256

DATA_04F64D:
	.DB $00
	.DW 80,320

DATA_04F652:
	.DB $03
	.DW 0,0
	.DB $0A
	.DW 64,152
	.DB $0A
	.DW 96,248
	.DB $0A
	.DW 320,344

DATA_04F666:
	.DW 48,256,-240
	.DW 32,-144,16
	.DB $01,$40,$80

CODE_04F675:
	PHB
	PHK
	PLB
	LDX #$0C
	LDY #$4B
-	LDA DATA_04F625-15,Y
	STA wm_OWSpriteNum.Spr4,X
	CMP #$01
	BEQ +
	CMP #$02
	BNE ++
+	LDA #$40
	STA wm_OWSpriteZLo.Spr4,X
++	LDA DATA_04F625-14,Y
	STA wm_OWSpriteXLo.Spr4,X
	LDA DATA_04F625-13,Y
	STA wm_OWSpriteXHi.Spr4,X
	LDA DATA_04F625-12,Y
	STA wm_OWSpriteYLo.Spr4,X
	LDA DATA_04F625-11,Y
	STA wm_OWSpriteYHi.Spr4,X
	TYA
	SEC
	SBC #$05
	TAY
	DEX
	BPL -
	LDX #$0D
-	STZ wm_OWSpriteTbl4,X
	LDA.W DATA_04FD22
	DEC A
	STA wm_OWSpriteZSpeed,X
	LDA.W DATA_04F666-1,X
--	PHA
	STX wm_OWSpriteIndex
	JSR CODE_04F853 ; BUG-FIX: ID 000-00
	PLA
	DEC A
	BNE --
	INX
	CPX #$10
	BCC -
	PLB
	RTL

DATA_04F6D0:	.DB $70,$7F,$78,$7F,$70,$7F,$78,$7F

DATA_04F6D8:	.DW -16,32,192,-16,-16,128,-16,0

DATA_04F6E8:	.DW 112,352,344,176,352,352,112,352

DATA_04F6F8:	.DB $20,$58,$43,$CF,$18,$34,$A2,$5E

DATA_04F700:	.DB $07,$05,$06,$07,$04,$06,$07,$05

CODE_04F708:
	LDA #$F7
	JSR _04F882
	BNE ++
	LDY wm_LightFlashPal
	BNE +
	LDA wm_FrameA
	LSR
	BCC ++
	DEC wm_LightFlashNext
	BNE ++
	TAY
	LDA DATA_04F700+8,Y
	AND #$07
	TAX
	LDA.W DATA_04F6F8,X
	STA wm_LightFlashNext
	LDY.W DATA_04F700,X
	STY wm_LightFlashPal
	LDA #$08
	STA wm_LightFlashDur
	LDA #$18
	STA wm_SoundCh3
+	DEC wm_LightFlashDur
	BPL +
	DEC wm_LightFlashPal
	LDA #$04
	STA wm_LightFlashDur
+	TYA
	ASL
	TAY
	LDX wm_PalSprIndex
	LDA #$02
	STA wm_PalUplSize,X
	LDA #$47
	STA wm_PalColNum,X
	LDA wm_Palette.41.ColL,Y
	STA wm_PalColData.1.ColL,X
	LDA wm_Palette.41.ColH,Y
	STA wm_PalColData.1.ColH,X
	STZ wm_PalColData.2.ColL,X
	TXA
	CLC
	ADC #$04
	STA wm_PalSprIndex
++	LDX #$02
-	LDA wm_OWSpriteNum,X
	BNE +
	LDA #$05
	STA wm_OWSpriteNum,X
	JSR CODE_04FE5B
	AND #$07
	TAY
	LDA DATA_04F6D0,Y
	STA wm_OWSpriteZLo,X
	TYA
	ASL
	TAY
	REP #$20
	LDA wm_Bg1HOfs
	CLC
	ADC DATA_04F6D8,Y
	SEP #$20
	STA wm_OWSpriteXLo,X
	XBA
	STA wm_OWSpriteXHi,X
	REP #$20
	LDA wm_Bg1VOfs
	CLC
	ADC DATA_04F6E8,Y
	SEP #$20
	STA wm_OWSpriteYLo,X
	XBA
	STA wm_OWSpriteYHi,X
+	DEX
	BPL -
	LDX #$04
-	TXA
	STA wm_OWCloudSpeedChk,X
	DEX
	BPL -
	LDX #$04
-	STX m0
--	STX m1
	LDX m0
	LDY wm_OWCloudSpeedChk,X
	LDA wm_OWSpriteYLo,Y
	STA m2
	LDA wm_OWSpriteYHi,Y
	STA m3
	LDX m1
	LDY wm_OWSpriteInitOam,X
	LDA wm_OWSpriteYHi,Y
	XBA
	LDA wm_OWSpriteYLo,Y
	REP #$20
	CMP m2
	SEP #$20
	BPL +
	PHY
	LDY m0
	LDA wm_OWCloudSpeedChk,Y
	STA wm_OWSpriteInitOam,X
	PLA
	STA wm_OWCloudSpeedChk,Y
+	DEX
	BNE --
	LDX m0
	DEX
	BNE -
	LDA #$30
	STA wm_OWSpriteInitOam
	STZ wm_OWEnterLevel
	LDX #$0F
	LDY #$2D
_04F801:
	CPX #$0D
	BCS +
	LDA wm_OWSpriteTbl4,X
	BEQ +
	DEC wm_OWSpriteTbl4,X
+	CPX #$05
	BCC CODE_04F819
	STX wm_OWSpriteIndex
	JSR CODE_04F853
	BRA _04F825

CODE_04F819:
	PHX
	LDA wm_OWCloudSpeedChk,X
	TAX
	STX wm_OWSpriteIndex
	JSR CODE_04F853
	PLX
_04F825:
	DEX
	BPL _04F801
_OW_Return:
	RTS

; %ABCDEFGH 0 Enables sprite, 1 disables
; A -> Main Area
; B -> Yoshi's Island
; C -> Vanilla Dome
; D -> Forest of Illusion
; E -> Valley of Bowser
; F -> Special World
; G -> Star Road
; H -> Unused

DATA_04F829:
	.DB %01111111 ; Lakitu
	.DB %00100001 ; Blue Bird
	.DB %01111111 ; Fish
	.DB %01111111 ; Piranha
	.DB %01111111 ; Cloud
	.DB %01110111 ; Koopa Kid
	.DB %00111111 ; Smoke
	.DB %11110111 ; Bowser Sign
	.DB %11110111 ; Bowser
	.DB %00000000 ; Ghost

DATA_04F833:
	.DB $00,$52,$31,$19,$45,$2A,$03,$8B
	.DB $94,$3C,$78,$0D,$36,$5E,$87,$1F

DATA_04F843:
	.DB $F4,$F4,$F4,$F4,$F4,$9C,$3C,$48
	.DB $C8,$CC,$A0,$A4,$D8,$DC,$E0,$E4

CODE_04F853:
	JSR CODE_04F87C
	BNE _OW_Return
	LDA wm_OWSpriteNum,X
	JSL ExecutePtr

OWSprites:
	.DW _OW_Return
	.DW OW_Lakitu
	.DW OW_BlueBird
	.DW OW_Fish
	.DW OW_Piranha
	.DW OW_Cloud
	.DW OW_KoopaKid
	.DW OW_Smoke
	.DW OW_BowserSign
	.DW OW_Bowser
	.DW OW_Ghost

OW_SpriteFlags:	.DB $80,$40,$20,$10,$08,$04,$02

CODE_04F87C:
	LDY wm_OWSpriteNum,X
	LDA DATA_04F829-1,Y
_04F882:
	STA m0
	LDY wm_OWProcessPtr
	CPY #$0A
	BNE +
	LDY wm_OWSubmapSwitchIndex
	CPY #$01
	BNE ++
+	LDA wm_OWCharB
	LSR
	LSR
	TAY
	LDA wm_MapData.MarioMap,Y
	TAY
	LDA OW_SpriteFlags,Y
	AND m0
	BEQ +
++	LDA #$01
+	RTS

DATA_04F8A6:	.DB $01,$01,$03,$01,$01,$01,$01,$02

DATA_04F8AE:	.DB $0C,$0C,$12,$12,$12,$12,$0C,$0C

DATA_04F8B6:	.DB $10,$00,$08,$00,$20,$00,$20,$00

DATA_04F8BE:	.DB $10,$00,$30,$00,$08,$00,$10,$00

DATA_04F8C6:	.DB $01,$FF

DATA_04F8C8:	.DB $10,$F0

DATA_04F8CA:	.DB $10,$F0

OW_Lakitu:
	JSR CODE_04FE90
	CLC
	JSR ADDR_04FE00
	JSR CODE_04FE62
	REP #$20
	LDA m2
	STA m4
	SEP #$20
	JSR CODE_04FE5B
	LDX #$06
	AND #$10
	BEQ _f
	INX
__	STX m6
	LDA m0
	CLC
	ADC.W DATA_04F8A6,X
	STA m0
	BCC +
	INC m1
+	LDA m4
	CLC
	ADC.W DATA_04F8AE,X
	STA m2
	LDA m5
	ADC #$00
	STA m3
	LDA #$32
	XBA
	LDA #$28
	JSR _04FB7B
	LDX m6
	DEX
	DEX
	BPL _b
	LDX wm_OWSpriteIndex
	JSR CODE_04FE62
	LDA #$32
	XBA
	LDA #$26
	JSR _04FB7A
	LDA wm_OWSpriteTbl3,X
	BEQ ADDR_04F928
	JMP ADDR_04FF2E

ADDR_04F928:
	LDA wm_OWSpriteTbl2,X
	AND #$01
	TAY
	LDA wm_OWSpriteZSpeed,X
	CLC
	ADC DATA_04F8C6,Y
	STA wm_OWSpriteZSpeed,X
	CMP DATA_04F8CA,Y
	BNE +
	LDA wm_OWSpriteTbl2,X
	EOR #$01
	STA wm_OWSpriteTbl2,X
+	JSR ADDR_04FEEF
	LDY wm_OWSpriteTbl1,X
	LDA wm_OWSpriteTbl1.Spr16,X
	ASL
	EOR m0
	BPL +
	LDA m6
	CMP DATA_04F8B6,Y
	LDA.W #$0040
	BCS ++
+	LDA wm_OWSpriteTbl1.Spr16,X
	EOR m2
	ASL
	BCC ++
	LDA m8
	CMP DATA_04F8BE,Y
	LDA.W #$0080
++	SEP #$20
	BCC +
	EOR wm_OWSpriteTbl2,X
	STA wm_OWSpriteTbl2,X
	JSR CODE_04FE5B
	AND #$06
	STA wm_OWSpriteTbl1,X
+	TXA
	CLC
	ADC #$10
	TAX
	LDA wm_OWSpriteTbl1,X
	ASL
	JSR _04F993
	LDX wm_OWSpriteIndex
	LDA wm_OWSpriteTbl2,X
	ASL
	ASL
_04F993:
	LDY #$00
	BCS +
	INY
+	LDA wm_OWSpriteXSpeed,X
	CLC
	ADC DATA_04F8C6,Y
	CMP DATA_04F8C8,Y
	BEQ +
	STA wm_OWSpriteXSpeed,X
+	RTS

DATA_04F9A8:	.DB $4E,$4F,$5E,$4F

DATA_04F9AC:	.DB $08,$07,$04,$07

DATA_04F9B0:	.DB $00,$01,$04,$01

DATA_04F9B4:	.DB $01,$07,$09,$07

OW_BlueBird:
	CLC
	JSR ADDR_04FE00
	JSR ADDR_04FEEF
	SEP #$20
	LDY #$00
	LDA m1
	BMI +
	INY
+	LDA wm_OWSpriteXSpeed,X
	CLC
	ADC DATA_04F8C6,Y
	CMP DATA_04F8C8,Y
	BEQ +
	STA wm_OWSpriteXSpeed,X
+	LDY wm_OWCharB
	LDA wm_MapData.MarioYPos,Y
	STA wm_OWSpriteYLo,X
	LDA wm_MapData.MarioYPos+1,Y
	STA wm_OWSpriteYHi,X
	JSR CODE_04FE90
	JSR CODE_04FE62
	LDA #$36
	LDY wm_OWSpriteXSpeed,X
	BMI +
	ORA #$40
+	PHA
	XBA
	LDA #$4C
	JSR _04FB7A
	PLA
	XBA
	JSR CODE_04FE5B
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_04F9AC,Y
	BIT wm_OWSpriteXSpeed,X
	BMI +
	LDA DATA_04F9B0,Y
+	CLC
	ADC m0
	STA m0
	BCC +
	INC m1
+	LDA DATA_04F9B4,Y
	CLC
	ADC m2
	STA m2
	BCC +
	INC m3
+	LDA DATA_04F9A8,Y
	CLC
	JMP _04FB7B

DATA_04FA2E:	.DB $70,$50,$B0

DATA_04FA31:	.DB $00,$01,$00

DATA_04FA34:	.DB $CF,$8F,$7F

DATA_04FA37:	.DB $00,$00,$01

DATA_04FA3A:	.DB $73,$72,$63,$62

OW_Fish:
	LDA wm_OWSpriteTbl1,X
	BNE CODE_04FA83
	LDA wm_OWPlayerTile
	SEC
	SBC #$4E
	CMP #$03
	BCS _Return04FA82
	TAY
	LDA DATA_04FA2E,Y
	STA wm_OWSpriteXLo,X
	LDA DATA_04FA31,Y
	STA wm_OWSpriteXHi,X
	LDA DATA_04FA34,Y
	STA wm_OWSpriteYLo,X
	LDA DATA_04FA37,Y
	STA wm_OWSpriteYHi,X
	JSR CODE_04FE5B
	LSR
	ROR
	LSR
	AND #$40
	ORA #$12
	STA wm_OWSpriteTbl1,X
	LDA #$24
	STA wm_OWSpriteZSpeed,X
	LDA #$0E
	STA wm_SoundCh1
_04FA7D:
	LDA #$0F
	STA wm_OWSpriteTbl4,X
_Return04FA82:
	RTS

CODE_04FA83:
	DEC wm_OWSpriteZSpeed,X
	LDA wm_OWSpriteZSpeed,X
	CMP #$E4
	BNE +
	JSR _04FA7D
+	JSR CODE_04FE90
	LDA wm_OWSpriteZLo,X
	ORA wm_OWSpriteTbl4,X
	BNE +
	STZ wm_OWSpriteTbl1,X
+	JSR CODE_04FE62
	LDA wm_OWSpriteTbl1,X
	LDY #$08
	BIT wm_OWSpriteZSpeed,X
	BPL +
	EOR #$C0
	LDY #$10
+	XBA
	TYA
	LDY #$4A
	AND wm_FrameA
	BEQ +
	LDY #$48
+	TYA
	JSR _04FB06
	JSR CODE_04FE4E
	SEC
	SBC #$08
	STA m2
	BCS +
	DEC m3
+	LDA #$36
	XBA
	LDA wm_OWSpriteTbl4,X
	BEQ _Return04FA82
	LSR
	LSR
	PHY
	TAY
	LDA DATA_04FA3A,Y
	PLY
	PHA
	JSR _04FAED
	REP #$20
	LDA m0
	CLC
	ADC #$0008
	STA m0
	SEP #$20
	LDA #$76
	XBA
	PLA
_04FAED:
	CLC
	JMP _04FB0A

OW_Piranha:
	JSR ADDR_04FED7
	JSR CODE_04FE62
	JSR CODE_04FE5B
	LDY #$2A
	AND #$08
	BEQ +
	LDY #$2C
+	LDA #$32
	XBA
	TYA
_04FB06:
	SEC
	LDY.W DATA_04F843,X
_04FB0A:
	STA wm_ExOamSlot.17.Tile,Y
	XBA
	STA wm_ExOamSlot.17.Prop,Y
	LDA m1
	BNE +
	LDA m0
	STA wm_ExOamSlot.17.XPos,Y
	LDA m3
	BNE +
	PHP
	LDA m2
	STA wm_ExOamSlot.17.YPos,Y
	TYA
	LSR
	LSR
	PLP
	PHY
	TAY
	ROL
	ASL
	AND #$03
	STA wm_ExOamSize.17,Y
	PLY
	DEY
	DEY
	DEY
	DEY
+	RTS

OW_Cloud:
	LDA #$02
	STA wm_OWSpriteXSpeed,X
	LDA #$FF
	STA wm_OWSpriteYSpeed,X
	JSR CODE_04FE90
	JSR CODE_04FE62
	REP #$20
	LDA m0
	CLC
	ADC #$0020
	CMP #$0140
	BCS +
	LDA m2
	CLC
	ADC #$0080
	CMP #$01A0
+	SEP #$20
	BCC +
	STZ wm_OWSpriteNum,X
+	LDA #$32
	JSR _04FB77
	REP #$20
	LDA m0
	CLC
	ADC #$0010
	STA m0
	SEP #$20
	LDA #$72
_04FB77:
	XBA
	LDA #$44
_04FB7A:
	SEC
_04FB7B:
	LDY wm_OWSpriteInitOam
	JSR _04FB0A
	STY wm_OWSpriteInitOam
_Return04FB84:
	RTS

DATA_04FB85:	.DB $80,$40,$20

DATA_04FB88:	.DB $30,$10,$C0

DATA_04FB8B:	.DB $01,$01,$01

DATA_04FB8E:	.DB $7F,$7F,$8F

DATA_04FB91:	.DB $01,$00,$01

DATA_04FB94:	.DB $08,$02

DATA_04FB96:	.DB $0F,$00

OW_KoopaKid:
	LDA wm_OWSpriteTbl1,X
	BNE +
	LDA wm_OWPlayerTile
	SEC
	SBC #$49
	CMP #$03
	BCS _Return04FB84
	TAY
	STA wm_KoopaKidTileIndex
	LDA wm_KoopaKidTrig
	AND DATA_04FB85,Y
	BNE _Return04FB84
	LDA DATA_04FB88,Y
	STA wm_OWSpriteXLo,X
	LDA DATA_04FB8B,Y
	STA wm_OWSpriteXHi,X
	LDA DATA_04FB8E,Y
	STA wm_OWSpriteYLo,X
	LDA DATA_04FB91,Y
	STA wm_OWSpriteYHi,X
	LDA #$02
	STA wm_OWSpriteTbl1,X
	LDA #$F0
	STA wm_OWSpriteXSpeed,X
	STZ wm_OWSpriteTbl4,X
+	JSR CODE_04FE62
	LDA wm_OWSpriteTbl4,X
	BNE +
	INC wm_OWSpriteTbl2,X
	JSR _04FEAB
	LDY wm_OWSpriteTbl1,X
	LDA wm_OWSpriteXLo,X
	AND #$0F
	CMP DATA_04FB96-1,Y
	BNE +
	DEC wm_OWSpriteTbl1,X
	LDA #$04
	STA wm_OWSpriteXSpeed,X
	LDA #$60
	STA wm_OWSpriteTbl4,X
+	LDA DATA_04FB94-1,Y
	LDY #$22
	AND wm_OWSpriteTbl2,X
	BNE +
	LDY #$62
+	TYA
	XBA
	LDA #$6A
	JSR _04FB06
	JSR ADDR_04FED7
	BCS +
	ORA #$80
	STA wm_OWEnterLevel
+	RTS

DATA_04FC1E:	.DB $38,$00,$68,$00

DATA_04FC22:	.DB $8A,$01,$6A,$00

DATA_04FC26:
	.DB $01,$02,$03,$04,$03,$02,$01,$00
	.DB $01,$02,$03,$04,$03,$02,$01,$00

DATA_04FC36:
	.DB $FF,$FF,$FE,$FD,$FD,$FC,$FB,$FB
	.DB $FA,$F9,$F9,$F8,$F7,$F7,$F6,$F5

OW_Smoke:
	LDA wm_OWCharB
	LSR
	LSR
	TAY
	LDA wm_MapData.MarioMap,Y
	ASL
	TAY
	LDA DATA_04FC1E,Y
	STA wm_OWSpriteXLo,X
	LDA DATA_04FC1E+1,Y
	STA wm_OWSpriteXHi,X
	LDA DATA_04FC22,Y
	STA wm_OWSpriteYLo,X
	LDA DATA_04FC22+1,Y
	STA wm_OWSpriteYHi,X
	LDA wm_FrameA
	AND #$0F
	BNE ++
	LDA wm_OWSpriteTbl1,X
	INC A
	CMP #$0C
	BCC +
	LDA #$00
+	STA wm_OWSpriteTbl1,X
++	LDA #$03
	STA m4
	LDA wm_FrameA
	STA m6
	STZ m7
	LDY.W DATA_04F843,X
	LDA wm_OWSpriteTbl1,X
	TAX
-	PHY
	PHX
	LDX wm_OWSpriteIndex
	JSR CODE_04FE62
	PLX
	LDA m7
	CLC
	ADC.W DATA_04FC36,X
	CLC
	ADC m2
	STA m2
	BCS +
	DEC m3
+	LDA m0
	CLC
	ADC.W DATA_04FC26,X
	STA m0
	BCC +
	INC m1
+	TXA
	CLC
	ADC #$0C
	CMP #$10
	AND #$0F
	TAX
	BCC +
	LDA m7
	SBC #$0C
	STA m7
+	LDA #$30
	XBA
	LDY #$28
	LDA m6
	CLC
	ADC #$0A
	STA m6
	AND #$20
	BEQ +
	LDY #$5F
+	TYA
	PLY
	JSR _04FAED
	DEC m4
	BNE -
	LDX wm_OWSpriteIndex
	RTS

OW_BowserSign:
	JSR CODE_04FE62
	LDA #$04
	STA m4
	LDA #$6F
	STA m5
	LDY.W DATA_04F843,X
-	LDA wm_FrameA
	LSR
	AND #$06
	ORA #$30
	XBA
	LDA m5
	JSR _04FAED
	LDA m0
	SEC
	SBC #$08
	STA m0
	DEC m5
	DEC m4
	BNE -
	RTS

DATA_04FD0A:	.DB $07,$07,$03,$03,$5F,$5F

DATA_04FD10:
	.DB $01,$FF,$01,$FF,$01,$FF,$01,$FF
	.DB $01,$FF

DATA_04FD1A:	.DB $18,$E8,$0A,$F6,$08,$F8,$03,$FD

DATA_04FD22:	.DB $01,$FF

OW_Bowser:
	JSR CODE_04FE90
	JSR CODE_04FE62
	JSR CODE_04FE62
	LDA #$00
	LDY wm_OWSpriteXSpeed,X
	BMI +
	LDA #$40
+	XBA
	LDA #$68
	JSR _04FB06
	INC wm_OWSpriteTbl3,X
	LDA wm_OWSpriteTbl3,X
	LSR
	BCS ++
	LDA wm_OWSpriteTbl2,X
	ORA #$02
	TAY
	TXA
	ADC #$10
	TAX
	JSR _04FD55
	LDY wm_OWSpriteTbl1,X
_04FD55:
	LDA wm_OWSpriteXSpeed,X
	CLC
	ADC DATA_04FD10,Y
	STA wm_OWSpriteXSpeed,X
	CMP DATA_04FD1A,Y
	BNE _04FD68
	TYA
	EOR #$01
	TAY
_04FD68:
	TYA
	STA wm_OWSpriteTbl1,X
	LDX wm_OWSpriteIndex
++	RTS

OW_Ghost:
	JSR CODE_04FE90
	JSR CODE_04FE62
	JSR CODE_04FE62
	LDY wm_OWCharA
	LDA wm_MapData.MarioMap,Y
	BEQ ++
	CPX #$0F
	BNE +
	LDA wm_MapData.OwEventFlags+5
	AND #$12
	BNE +
	STX m3
+	TXA
	ASL
	TAY
	REP #$20
	LDA m0
	CLC
	ADC DATA_04F64D-1,Y
	STA m0
	LDA m2
	CLC
	ADC DATA_04F652,Y
	STA m2
	SEP #$20
++	LDA #$34
	LDY wm_OWSpriteXSpeed,X
	BMI +
	LDA #$44
+	XBA
	LDA #$60
	JSR _04FB06
	LDA wm_OWSpriteTbl4,X
	STA m0
	INC wm_OWSpriteTbl4,X
	TXA
	CLC
	ADC #$20
	TAX
	LDA #$08
	JSR _04FDD2
	TXA
	CLC
	ADC #$10
	TAX
	LDA #$06
	JSR _04FDD2
	LDA #$04
_04FDD2:
	ORA wm_OWSpriteTbl1,X
	TAY
	LDA DATA_04FD0A-4,Y
	AND m0
	BNE _04FD68
	JMP _04FD55

DATA_04FDE0:
	.DB $00,$00,$00,$00,$01,$02,$02,$02
	.DB $00,$00,$01,$01,$02,$02,$03,$03

DATA_04FDF0:
	.DB $08,$08,$08,$08,$07,$06,$05,$05
	.DB $00,$00,$0E,$0E,$0C,$0C,$0A,$0A

ADDR_04FE00:
	ROR m4
	JSR CODE_04FE62
	JSR CODE_04FE4E
	LDA wm_OWSpriteZLo,X
	LSR
	LSR
	LSR
	LSR
	LDY #$29
	BIT m4
	BPL +
	LDY #$2E
	CLC
	ADC #$08
+	STY m5
	TAY
	STY m6
	LDA m0
	CLC
	ADC DATA_04FDE0,Y
	STA m0
	BCC +
	INC m1
+	LDA #$32
	LDY.W DATA_04F843,X
	JSR _04FE45
	PHY
	LDY m6
	LDA m0
	CLC
	ADC DATA_04FDF0,Y
	STA m0
	BCC +
	INC m1
+	LDA #$72
	PLY
_04FE45:
	XBA
	LDA m4
	ASL
	LDA m5
	JMP _04FB0A

CODE_04FE4E:
	LDA m2
	CLC
	ADC wm_OWSpriteZLo,X
	STA m2
	BCC +
	INC m3
+	RTS

CODE_04FE5B:
	LDA wm_FrameA
	CLC
	ADC.W DATA_04F833,X
	RTS

CODE_04FE62:
	TXA
	CLC
	ADC #$10
	TAX
	LDY #$02
	JSR _04FE7D
	LDX wm_OWSpriteIndex
	LDA m2
	SEC
	SBC wm_OWSpriteZLo,X
	STA m2
	BCS +
	DEC m3
+	LDY #$00
_04FE7D:
	LDA wm_OWSpriteXHi,X
	XBA
	LDA wm_OWSpriteXLo,X
	REP #$20
	SEC
	SBC.W wm_Bg1HOfs,Y
	STA.W m0,Y
	SEP #$20
	RTS

CODE_04FE90:
	TXA
	CLC
	ADC #$20
	TAX
	JSR _04FEAB
	LDA wm_OWSpriteXLo,X
	BPL +
	STZ wm_OWSpriteXLo,X
+	TXA
	SEC
	SBC #$10
	TAX
	JSR _04FEAB
	LDX wm_OWSpriteIndex
_04FEAB:
	LDA wm_OWSpriteXSpeed,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_OWSpriteXAcc,X
	STA wm_OWSpriteXAcc,X
	LDA wm_OWSpriteXSpeed,X
	PHP
	LSR
	LSR
	LSR
	LSR
	LDY #$00
	PLP
	BPL +
	ORA #$F0
	DEY
+	ADC wm_OWSpriteXLo,X
	STA wm_OWSpriteXLo,X
	TYA
	ADC wm_OWSpriteXHi,X
	STA wm_OWSpriteXHi,X
	RTS

ADDR_04FED7:
	JSR ADDR_04FEEF
	LDA m6
	CMP.W #$0008
	BCS +
	LDA m8
	CMP.W #$0008
+	SEP #$20
	TXA
	BCS +
	STA wm_OWEnterLevel
+	RTS

ADDR_04FEEF:
	LDA wm_OWSpriteXHi,X
	XBA
	LDA wm_OWSpriteXLo,X
	REP #$20
	CLC
	ADC #$0008
	LDY wm_OWCharB
	SEC
	SBC wm_MapData.MarioXPos,Y
	STA m0
	BPL +
	EOR #$FFFF
	INC A
+	STA m6
	SEP #$20
	LDA wm_OWSpriteYHi,X
	XBA
	LDA wm_OWSpriteYLo,X
	REP #$20
	CLC
	ADC #$0008
	LDY wm_OWCharB
	SEC
	SBC wm_MapData.MarioYPos,Y
	STA m2
	BPL +
	EOR #$FFFF
	INC A
+	STA m8
	RTS

ADDR_04FF2E:
	JSR ADDR_04FEEF
	LSR m6
	LSR m8
	SEP #$20
	LDA wm_OWSpriteZLo,X
	LSR
	STA m10
	STZ m5
	LDY #$04
	CMP m8
	BCS +
	LDY #$02
	LDA m8
+	CMP m6
	BCS +
	LDY #$00
	LDA m6
+	CMP #$01
	BCS ADDR_04FF67
	STZ wm_OWSpriteTbl3,X
	STZ wm_OWSpriteXSpeed,X
	STZ wm_OWSpriteYSpeed,X
	STZ wm_OWSpriteZSpeed,X
	LDA #$40
	STA wm_OWSpriteZLo,X
	RTS

ADDR_04FF67:
	STY m12
	LDX #$04
_04FF6B:
	CPX m12
	BNE ADDR_04FF73
	LDA #$20
	BRA _04FF91

ADDR_04FF73:
	STZ WRDIVL
	LDA m6,X
	STA WRDIVH
	LDA.W m6,Y
	STA WRDIVB
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA RDDIVL
	LSR
	LSR
	LSR
	SEP #$20
_04FF91:
	BIT m1,X
	BMI +
	EOR #$FF
	INC A
+	STA m0,X
	DEX
	DEX
	BPL _04FF6B
	LDX wm_OWSpriteIndex
	LDA m0
	STA wm_OWSpriteXSpeed,X
	LDA m2
	STA wm_OWSpriteYSpeed,X
	LDA m4
	STA wm_OWSpriteZSpeed,X
	RTS

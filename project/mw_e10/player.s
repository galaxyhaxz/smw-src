DATA_00C460: ;unused
	.DB $80,$40,$20,$10,$08,$04,$02,$01
	.DB $80,$40,$20,$10,$08,$04,$02,$01

DATA_00C470:	.DB $90,$00,$90,$00

DATA_00C474:	.DB $04,$FC,$04,$FC

DATA_00C478:	.DB $30,$33,$33,$30,$01,$00

CODE_00C47E:
	STZ wm_HidePlayer
	LDA wm_LvEndStarPrize
	BPL +
	JSL CODE_01C580
	STZ wm_LvEndStarPrize
+	LDY wm_KeyHoleTimer
	BEQ ++
	STY wm_IsFrozen
	STY wm_SpritesLocked
	LDX wm_KeyHoleOpeningFlag
	LDA wm_HdmaWindowScaling
	CMP.W DATA_00C470,X
	BNE CODE_00C4BC
	DEY
	BNE +
	INC wm_KeyHoleOpeningFlag
	TXA
	LSR
	BCC _00C4F8
	JSR CODE_00FCEC
	LDA.B #$02
	LDY.B #$0B
	JSR _00C9FE
	LDY.B #$00
+	STY wm_KeyHoleTimer
++	BRA _00C4F8

CODE_00C4BC:
	CLC
	ADC.W DATA_00C474,X
	STA wm_HdmaWindowScaling
	LDA.B #$22
	STA wm_W12Sel
	LDA.B #$02
	STA wm_W34Sel
	LDA.W DATA_00C478,X
	STA wm_WObjSel
	LDA.B #$12
	STA wm_CgSwSel
	REP #$20
	LDA.W #DATA_00CB93
	STA m4
	STZ m6
	SEP #$20
	LDA wm_KeyHolePos1
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$04
	STA m0
	LDA wm_KeyHolePos2
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC #$10
	STA m1
	JSR _00CA88
_00C4F8:
	LDA wm_IsFrozen
	BEQ CODE_00C500
	JMP _00C58F

CODE_00C500:
	LDA wm_SpritesLocked
	BNE +++
	INC wm_FrameB
	LDX.B #$13
-	LDA wm_ColorFadeTimer,X
	BEQ +
	DEC wm_ColorFadeTimer,X
+	DEX
	BNE -
	LDA wm_FrameB
	AND #$03
	BNE +++
	LDA wm_BonusGameFlag
	BEQ ++
	LDA wm_BonusGameEndTimer
	CMP #$44
	BNE +
	LDY.B #$14
	STY wm_MusicCh1
+	CMP #$01
	BNE ++
	LDY.B #$0B
	STY wm_GameMode
++	LDY wm_BluePowTimer
	CPY wm_SilverPowTimer
	BCS +
	LDY wm_SilverPowTimer
+	LDA wm_LevelMusicMod
	BMI +
	CPY.B #$01
	BNE +
	LDY wm_DirCoinTimer
	BNE +
	STA wm_MusicCh1
+	CMP #$FF
	BEQ +
	CPY.B #$1E
	BNE +
	LDA #$24
	STA wm_SoundCh3
+	LDX.B #$06
-	LDA wm_14A8,X
	BEQ +
	DEC wm_14A8,X
+	DEX
	BNE -
+++	JSR CODE_00C593
	LDA wm_JoyFrameA
	AND #$20
	BEQ _00C58F
	LDA wm_JoyPadA
	AND #$08
.IFDEF dbg_SelectPowerUp
	BEQ CODE_00C585
.ELSE
	BRA CODE_00C585
.ENDIF
	LDA wm_MarioPowerUp
	INC A
	CMP #$04
	BCC +
	LDA #$00
+	STA wm_MarioPowerUp
	BRA _00C58F

CODE_00C585:
.IFDEF dbg_SelectItemBox
	LDA wm_JoyPadA
	AND #$04
	BEQ @NoDbgItemBox
	LDA wm_ItemInBox
	INC A
	CMP #$05
	BCC +
	LDA #$00
+	STA wm_ItemInBox
	BRA _00C58F
@NoDbgItemBox:
.ENDIF
	PHB
	LDA #:DropReservedItem
	PHA
	PLB
	JSL DropReservedItem
	PLB
_00C58F:
	STZ wm_NoteBlkBounceFlag
_Return00C592:
	RTS

CODE_00C593:
	LDA wm_MarioAnimation
	JSL ExecutePtr

AnimationSeqPtr:
	.DW ResetAni
	.DW PowerDownAni
	.DW MushroomAni
	.DW CapeAni
	.DW FlowerAni
	.DW DoorPipeAni
	.DW VertPipeAni
	.DW PipeCannonAni
	.DW YoshiWingsAni
	.DW MarioDeathAni
	.DW EnterCastleAni
	.DW UnknownAniB
	.DW UnknownAniC
	.DW _Return00C592

UnknownAniB:
	STZ wm_OWCreditsPose
	STZ wm_PlayerSlopePose
	LDA wm_EndLevelTimer
	BEQ CODE_00C5CE
	JSL CODE_0CAB13
	LDA wm_GameMode
	CMP #$14
	BEQ _00C5D1
	JMP _00C95B

CODE_00C5CE:
	STZ wm_HDMAEn
_00C5D1:
	LDA #$01
	STA wm_MsgBoxActionFlag
	LDA #$07
	STA wm_LvLoadScreen
	JSR _NoButtons
	JMP CODE_00CD24

DATA_00C5E1:	.DB $10,$30,$31,$32,$33,$34,$0E

DATA_00C5E8:	.DB $26

DATA_00C5E9:
	.DB $11,$02,$48,$00,$60,$01,$09,$80
	.DB $08,$00,$20,$04,$60,$00,$01,$FF
	.DB $01,$02,$48,$00,$60,$41,$2C,$C1
	.DB $04,$27,$04,$2F,$08,$25,$01,$2F
	.DB $04,$27,$04,$00,$08,$41,$1B,$C1
	.DB $04,$27,$04,$2F,$08,$25,$01,$2F
	.DB $04,$27,$04,$00,$04,$01,$08,$20
	.DB $01,$01,$10,$00,$08,$41,$12,$81
	.DB $0A,$00,$40,$82,$10,$02,$20,$00
	.DB $30,$01,$01,$00,$50,$22,$01,$FF
	.DB $01,$02,$48,$00,$60,$01,$09,$80
	.DB $08,$00,$20,$04,$60,$00,$20,$10
	.DB $20,$01,$58,$00,$2C,$31,$01,$3A
	.DB $10,$31,$01,$3A,$10,$31,$01,$3A
	.DB $20,$28,$A0,$28,$40,$29,$04,$28
	.DB $04,$29,$04,$28,$04,$29,$04,$28
	.DB $40,$22,$01,$FF,$01,$02,$48,$00
	.DB $60,$01,$09,$80,$08,$00,$20,$04
	.DB $60,$10,$20,$31,$01,$18,$60,$31
	.DB $01,$3B,$80,$31,$01,$3C,$40,$FF
	.DB $01,$02,$48,$00,$60,$02,$30,$01
	.DB $84,$00,$20,$23,$01,$01,$16,$02
	.DB $20,$20,$01,$01,$20,$02,$20,$01
	.DB $02,$00,$80,$FF,$01,$02,$48,$00
	.DB $60,$02,$28,$01,$83,$00,$28,$24
	.DB $01,$02,$01,$00,$FF,$00,$40,$20
	.DB $01,$00,$40,$02,$60,$00,$30,$FF
	.DB $01,$02,$48,$00,$60,$01,$4E,$00
	.DB $40,$26,$01,$00,$1E,$20,$01,$00
	.DB $20,$08,$10,$20,$01,$2D,$18,$00
	.DB $A0,$20,$01,$2E,$01,$FF

DATA_00C6DF:	.DB $01,$00,$10,$A0,$84,$50,$BC,$D8

UnknownAniC:
	JSR _NoButtons
	STZ wm_OWCreditsPose
	JSR CODE_00DC2D
	LDA wm_MarioSpeedY
	BMI _00C73F
	LDA wm_MarioYPos
	CMP #$58
	BCS CODE_00C739
	LDY wm_MarioXPos
	CPY.B #$40
	BCC _00C73F
	CPY.B #$60
	BCC CODE_00C71C
	LDY wm_Bg1VOfs
	BEQ _00C73F
	CLC
	ADC wm_Bg1VOfs
	CMP #$1C
	BMI _00C73F
	SEC
	SBC wm_Bg1VOfs
	LDX.B #$D0
	LDY wm_MarioDirection
	BEQ _00C730
	LDY.B #$00
	BRA _00C72E

CODE_00C71C:
	CMP #$4C
	BCC _00C73F
	LDA #$1B
	STA wm_SoundCh3
	INC wm_ScrollSprNum
	LDA #$4C
	LDY.B #$F4
	LDX.B #$C0
_00C72E:
	STY wm_MarioSpeedX
_00C730:
	STX wm_MarioSpeedY
	LDX.B #$01
	STX wm_SoundCh1
	BRA _00C73D

CODE_00C739:
	STZ wm_IsFlying
	LDA #$58
_00C73D:
	STA wm_MarioYPos
_00C73F:
	LDX wm_CutsceneNum
	LDA wm_8F
	CLC
	ADC.W DATA_00C6DF,X
	TAX
	LDA wm_PipeWarpTimer
	BNE +
	INC wm_8F
	INC wm_8F
	INX
	INX
	LDA.W DATA_00C5E9,X
	STA wm_PipeWarpTimer
	LDA.W DATA_00C5E8,X
	CMP #$2D
	BNE +
	LDA #$1E
	STA wm_SoundCh1
+	LDA.W DATA_00C5E8,X
	CMP #$FF
	BNE CODE_00C76E
	JMP _Return00C7F8

CODE_00C76E:
	PHA
	AND #$10
	BEQ +
	JSL CODE_0CD4A4
+	PLA
	TAY
	AND #$20
	BNE CODE_00C789
	STY wm_JoyPadA
	TYA
	AND #$BF
	STA wm_JoyFrameA
	JSR _00CD39
	BRA _00C7F6

CODE_00C789:
	TYA
	AND #$0F
	CMP #$07
	BCS CODE_00C7E9
	DEC A
	BPL CODE_00C7A2
	LDA wm_PickUpImgTimer
	BEQ _00C79D
	LDA #$09
	STA wm_SoundCh1
_00C79D:
	INC wm_ScrollSprNum
	BRA _00C7F6

CODE_00C7A2:
	BNE CODE_00C7A9
	INC wm_ScrollTimerL2
	BRA _00C7F6

CODE_00C7A9:
	DEC A
	BNE CODE_00C7B6
	LDA #$0E
	STA wm_SoundCh1
	INC wm_ScrollSpeedL1X
	BRA _00C7F6

CODE_00C7B6:
	DEC A
	BNE CODE_00C7C0
	LDY.B #$88
	STY wm_ScrollTimerL2
	BRA _00C7F6

CODE_00C7C0:
	DEC A
	BNE CODE_00C7CE
	LDA #$38
	STA wm_ScrollSpeedL1X
	LDA #$07
	TRB wm_MarioXPos
	BRA _00C7F6

CODE_00C7CE:
	DEC A
	BNE CODE_00C7DF
	LDA #$09
	STA wm_SoundCh3
	LDA #$D8
	STA wm_MarioSpeedX
	INC wm_ScrollSprNum
	BRA _00C79D

CODE_00C7DF:
	LDA #$20
	STA wm_PickUpImgTimer
	INC wm_IsCarrying2
	BRA _00C7F6

CODE_00C7E9:
	TAY
	LDA DATA_00C5E1-7,Y
	STA wm_MarioFrame
	STZ wm_IsCarrying2
	JSR CODE_00D7E4
_00C7F6:
	DEC wm_PipeWarpTimer
_Return00C7F8:
	RTS

DATA_00C7F9:	.DB $C0,$FF,$A0,$00

YoshiWingsAni:
	JSR _NoButtons
	LDA #$0B
	STA wm_IsFlying
	JSR CODE_00D7E4
	LDA wm_MarioSpeedY
	BPL +
	CMP #$90
	BCC ++
+	SEC
	SBC #$0D
	STA wm_MarioSpeedY
++	LDA #$02
	LDY wm_MarioSpeedX
	BEQ ++
	BMI +
	LDA #$FE
+	CLC
	ADC wm_MarioSpeedX
	STA wm_MarioSpeedX
	BVC ++
	STZ wm_MarioSpeedX
++	JSR CODE_00DC2D
	REP #$20
	LDY wm_YoshiWingsAboveGrnd
	LDA wm_MarioScrPosY
	CMP DATA_00C7F9,Y
	SEP #$20
	BPL +
	STZ wm_MarioAnimation
	TYA
	BNE +
	INY
	INY
	STY wm_YoshiWingsAboveGrnd
	JSR CODE_00D273
+	JMP _00CD8F

DATA_00C848:
	.DB $01,$5F,$00,$30,$08,$30,$00,$20
	.DB $40,$01,$00,$30,$01,$80,$FF,$01
	.DB $3F,$00,$30,$20,$01,$80,$06,$00
	.DB $3A,$01,$38,$00,$30,$08,$30,$00
	.DB $20,$40,$01,$00,$30,$01,$80,$FF

EnterCastleAni:
	STZ wm_SpinFireTimer
	LDX wm_LvHeadTileset
	BIT.W DATA_00A625,X
	BMI CODE_00C889
	BVS ADDR_00C883
	JSL CODE_02F57C
	BRA _00C88D

ADDR_00C883:
	JSL ADDR_02F58C
	BRA _00C88D

CODE_00C889:
	JSL CODE_02F584
_00C88D:
	LDX wm_PipeWarpTimer
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	JSR _NoButtons
	BMI CODE_00C8FB
	STZ wm_OWCreditsPose
	DEC wm_PipeAction
	BNE +
	INX
	INX
	STX wm_PipeWarpTimer
	LDA.W DATA_00C848-1,X
	STA wm_PipeAction
+	LDA.W DATA_00C848-2,X
	CMP #$FF
	BEQ CODE_00C8FB
	AND #$DF
	STA wm_JoyPadA
	CMP.W DATA_00C848-2,X
	BEQ +
	LDY.B #$80
	STY wm_JoyFrameB
+	ASL
	BPL ++
	JSR _NoButtons
	LDY.B #$B0
	LDX wm_LvHeadTileset
	BIT.W DATA_00A625,X
	BMI +
	LDY.B #$7F
+	STY wm_DoorIntroTimer
++	JSR CODE_00DC2D
	LDA #$24
	STA wm_IsFlying
	LDA #$6F
	LDY wm_OnYoshi
	BEQ +
	LDA #$5F
+	LDX wm_LvHeadTileset
	BIT.W DATA_00A625,X
	BVC +
	SEC
	SBC #$10
+	CMP wm_MarioYPos
	BCS +
	INC A
	STA wm_MarioYPos
	STZ wm_IsFlying
	STZ wm_IsSpinJump
+	JMP CODE_00CD82

CODE_00C8FB:
	INC wm_ShowMarioStart
	LDA #$0F
	STA wm_GameMode
	CPX.B #$11
	BCC _00C90A
	INC wm_OWHasYoshi
_00C90A:
	LDA #$01
	STA wm_DisableYoshiFlag
	LDA #$03
	STA wm_SoundCh2
	RTS

CODE_00C915:
	JSR _NoButtons
	STZ wm_IsInLakituCloud
	STZ wm_OWCreditsPose
	STZ wm_PlayerSlopePose
	LDA wm_IsVerticalLvl
	LSR
	BCS ++
	LDA wm_CutsceneNum
	ORA wm_SwitchPalaceCol
	BEQ CODE_00C96B
	LDA wm_IsFlying
	BEQ +
	JSR CODE_00CCE0
+	LDA wm_SwitchPalaceCol
	BNE +++
	JSR CODE_00B03E
	LDA wm_ColorFadeTimer
	CMP #$40
	BCC _Return00C96A
++	JSL CODE_05CBFF
+++	LDY.B #$01
	STY wm_SpritesLocked
	LDA wm_FrameA
	LSR
	BCC _Return00C96A
	DEC wm_EndLevelTimer
	BNE _Return00C96A
	LDA wm_SwitchPalaceCol
	BNE CODE_00C962
_00C95B:
	LDY.B #$0B
	LDA #$01
	JMP _00C9FE

CODE_00C962:
	LDA #$A0
	STA wm_IntroCtrlSeqFrame
	INC wm_MsgBoxTrig
_Return00C96A:
	RTS

CODE_00C96B:
	JSR CODE_00AF17
	LDA wm_GoalFadeFlag
	BNE CODE_00C9AF
	LDA wm_EndLevelTimer
	CMP #$28
	BCC +
	LDA #$01
	STA wm_MarioDirection
	STA wm_JoyPadA
	LDA #$05
	STA wm_MarioSpeedX
+	LDA wm_IsFlying
	BEQ +
	JSR _00D76B
+	LDA wm_MarioSpeedX
	BNE +
	STZ wm_HorzScrollHead
	JSR CODE_00CA3E
	INC wm_GoalFadeFlag
	LDA #$40
	STA wm_PeaceImgTimer
	ASL
	STA wm_ColorFadeEndDir
	STZ wm_ColorFadeTimer
+	JMP CODE_00CD24

DATA_00C9A7:	.DB $25,$07,$40,$0E,$20,$1A,$34,$32

CODE_00C9AF:
	JSR SetMarioPeaceImg
	LDA wm_PeaceImgTimer
	BEQ CODE_00C9C2
	DEC wm_PeaceImgTimer
	BNE +
	LDA #$11
	STA wm_MusicCh1
+	RTS

CODE_00C9C2:
	JSR CODE_00CA44
	LDA #$01
	STA wm_JoyPadA
	JSR CODE_00CD24
	LDA wm_HdmaWindowScaling
	BNE _Return00CA30
	LDA wm_SecretGoalSprite
	INC A
	CMP #$03
	BNE +
	LDA #$01
	STA wm_MapData.MarioMap
	LSR
+	LDY.B #$0C
	LDX wm_BonusGameFlag
	BEQ +
	LDX.B #$FF
	STX wm_BonusGameFlag
	LDX.B #$F0
	STX wm_MosaicSize
	STZ wm_EndLevelTimer
	STZ wm_LevelMusicMod
	LDY.B #$10
+	STZ wm_IniDisp
	STZ wm_MosaicDir
_00C9FE:
	STA wm_LevelEndFlag
	LDA wm_CutsceneNum
	BEQ _00CA25
	LDX.B #$08
	LDA wm_TransLvNum
	CMP #$13
	BNE +
	INC wm_LevelEndFlag
+	CMP #$31
	BEQ CODE_00CA20
-	CMP.W DATA_00C9A7-1,X
	BEQ CODE_00CA20
	DEX
	BNE -
	BRA _00CA25

CODE_00CA20:
	STX wm_CutsceneNum
	LDY.B #$18
_00CA25:
	STY wm_GameMode
	INC wm_CreditsEnemyNum
_00CA2B:
	LDA #$01
	STA wm_MidwayPointFlag
_Return00CA30:
	RTS

SetMarioPeaceImg:
	LDA #$26
	LDY wm_OnYoshi
	BEQ +
	LDA #$14
+	STA wm_MarioFrame
	RTS

CODE_00CA3E:
	LDA #$F0
	STA wm_HdmaWindowScaling
	RTS

CODE_00CA44:
	LDA wm_HdmaWindowScaling
	BNE CODE_00CA4A
	RTS

CODE_00CA4A:
	JSR CODE_00CA61
	LDA #$FC
	JSR CODE_00CA6D
	LDA #$33
	STA wm_W12Sel
	STA wm_WObjSel
	LDA #$03
	STA wm_W34Sel
	LDA #$22
	STA wm_CgSwSel
	RTS

CODE_00CA61:
	REP #$20
	LDA.W #DATA_00CB12
	STA m4
	STA m6
	SEP #$20
	RTS

CODE_00CA6D:
	CLC
	ADC wm_HdmaWindowScaling
	STA wm_HdmaWindowScaling
	LDA wm_MarioScrPosX
	CLC
	ADC #$08
	STA m0
	LDA #$18
	LDY wm_MarioPowerUp
	BEQ +
	LDA #$10
+	CLC
	ADC wm_MarioScrPosY
	STA m1
_00CA88:
	REP #$30
	AND #$00FF
	ASL
	DEC A
	ASL
	TAY
	SEP #$20
	LDX #$0000
-	LDA m1
	CMP wm_HdmaWindowScaling
	BCC CODE_00CABD
	LDA #$FF
	STA wm_HDMAWindowsTbl,X
	STZ wm_HDMAWindowsTbl+1,X
	CPY #$01C0
	BCS +
	STA wm_HDMAWindowsTbl,Y
	INC A
	STA wm_HDMAWindowsTbl+1,Y
+	INX
	INX
	DEY
	DEY
	LDA m1
	BEQ _00CB0A
	DEC m1
	BRA -

CODE_00CABD:
	JSR CODE_00CC14
	CLC
	ADC m0
	BCC +
	LDA #$FF
+	STA wm_HDMAWindowsTbl+1,X
	LDA m0
	SEC
	SBC m2
	BCS +
	LDA #$00
+	STA wm_HDMAWindowsTbl,X
	CPY #$01E0
	BCS _00CAFE
	LDA m7
	BNE CODE_00CAE7
	LDA #$00
	STA wm_HDMAWindowsTbl+1,Y
	DEC A
	BRA _00CAFB

CODE_00CAE7:
	LDA m3
	ADC m0
	BCC +
	LDA #$FF
+	STA wm_HDMAWindowsTbl+1,Y
	LDA m0
	SEC
	SBC m3
	BCS _00CAFB
	LDA #$00
_00CAFB:
	STA wm_HDMAWindowsTbl,Y
_00CAFE:
	INX
	INX
	DEY
	DEY
	LDA m1
	BEQ _00CB0A
	DEC m1
	BNE CODE_00CABD
_00CB0A:
	LDA #$80
	STA wm_HDMAEn
	SEP #$10
	RTS

DATA_00CB12:
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE
	.DB $FD,$FD,$FD,$FD,$FC,$FC,$FC,$FB
	.DB $FB,$FB,$FA,$FA,$F9,$F9,$F8,$F8
	.DB $F7,$F7,$F6,$F6,$F5,$F5,$F4,$F3
	.DB $F3,$F2,$F1,$F1,$F0,$EF,$EE,$EE
	.DB $ED,$EC,$EB,$EA,$E9,$E9,$E8,$E7
	.DB $E6,$E5,$E4,$E3,$E2,$E1,$DF,$DE
	.DB $DD,$DC,$DB,$DA,$D8,$D7,$D6,$D5
	.DB $D3,$D2,$D0,$CF,$CD,$CC,$CA,$C9
	.DB $C7,$C6,$C4,$C2,$C1,$BF,$BD,$BB
	.DB $B9,$B7,$B6,$B4,$B1,$AF,$AD,$AB
	.DB $A9,$A7,$A4,$A2,$9F,$9D,$9A,$97
	.DB $95,$92,$8F,$8C,$89,$86,$82,$7F
	.DB $7B,$78,$74,$70,$6C,$67,$63,$5E
	.DB $59,$53,$4D,$46,$3F,$37,$2D,$1F
	.DB $00

DATA_00CB93:
	.DB $54,$53,$52,$52,$51,$50,$50,$4F
	.DB $4E,$4E,$4D,$4C,$4C,$4B,$4A,$4A
	.DB $4B,$48,$48,$47,$46,$46,$45,$44
	.DB $44,$43,$42,$42,$41,$40,$40,$3F
	.DB $3E,$3E,$3D,$3C,$3C,$3B,$3A,$3A
	.DB $39,$38,$38,$37,$36,$36,$35,$34
	.DB $34,$33,$32,$32,$31,$33,$35,$38
	.DB $3A,$3C,$3E,$3F,$41,$43,$44,$45
	.DB $47,$48,$49,$4A,$4B,$4C,$4D,$4E
	.DB $4E,$4F,$50,$50,$51,$51,$52,$52
	.DB $53,$53,$53,$53,$53,$53,$53,$53
	.DB $53,$53,$53,$53,$53,$52,$52,$51
	.DB $51,$50,$50,$4F,$4E,$4E,$4D,$4C
	.DB $4B,$4A,$49,$48,$47,$45,$44,$43
	.DB $41,$3F,$3E,$3C,$3A,$38,$35,$33
	.DB $30,$2D,$2A,$26,$23,$1E,$18,$11
	.DB $00

CODE_00CC14:
	PHY
	LDA m1
	STA WRDIVH
	STZ WRDIVL
	LDA wm_HdmaWindowScaling
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
	TAY
	SEP #$20
	LDA (m6),Y
	STA WRMPYA
	LDA wm_HdmaWindowScaling
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	STA m3
	LDA (m4),Y
	STA WRMPYA
	LDA wm_HdmaWindowScaling
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	STA m2
	PLY
	RTS

DATA_00CC5C:	.DW 0,0,2,6,-2,-6

ResetAni:
	LDA wm_JoyPadB
	AND #$20
	BEQ +
	LDA wm_JoyFrameB
	CMP #$80
	BNE +
	INC wm_FreeMovement
	LDA wm_FreeMovement
	CMP #$03
	BCC +
	STZ wm_FreeMovement
+	LDA wm_FreeMovement
.IFDEF dbg_FreeMovement
	BEQ _00CCBB
.ELSE
	BRA _00CCBB
.ENDIF
	LSR
	BEQ ADDR_00CCB3
	LDA #$FF
	STA wm_PlayerHurtTimer
	LDA wm_JoyPadA
	AND #$03
	ASL
	ASL
	LDX #$00
	JSR _00CC9F
	LDA wm_JoyPadA
	AND #$0C
	LDX #$02
_00CC9F:
	BIT wm_JoyPadA
	BVC +
	ORA #$02
+	TAY
	REP #$20
	LDA wm_MarioXPos,X
	CLC
	ADC DATA_00CC5C,Y
	STA wm_MarioXPos,X
	SEP #$20
	RTS

ADDR_00CCB3:
	LDA #$70
	STA wm_PlayerDashTimer
	STA wm_GlideTimer
_00CCBB:
	LDA wm_EndLevelTimer
	BEQ CODE_00CCC3
	JMP CODE_00C915

CODE_00CCC3:
	JSR CODE_00CDDD
	LDA wm_SpritesLocked
	BNE +
	STZ wm_CapeCanHurt
	STZ wm_OWCreditsPose
	LDA wm_LockMarioTimer
	BEQ CODE_00CCE0
	DEC wm_LockMarioTimer
	STZ wm_MarioSpeedX
	LDA #$0F
	STA wm_MarioFrame
+	RTS

CODE_00CCE0:
	LDA wm_LevelMode
	BPL CODE_00CD24
	LSR
	BCS CODE_00CD24
	BIT wm_LevelMode
	BVS CODE_00CD1C
	LDA wm_IsFlying
	BNE CODE_00CD1C
	REP #$20
	LDA wm_KeyHolePos1
	STA wm_MarioXPos
	LDA wm_KeyHolePos2
	STA wm_MarioYPos
	SEP #$20
	JSR CODE_00DC2D
	REP #$20
	LDA wm_MarioXPos
	STA wm_KeyHolePos1
	STA wm_ChainCosX
	LDA wm_MarioYPos
	AND #$FFF0
	STA wm_KeyHolePos2
	STA wm_ChainSinY
	JSR CODE_00F9C9
	BRA _00CD1F

CODE_00CD1C:
	JSR CODE_00DC2D
_00CD1F:
	JSR CODE_00F8F2
	BRA _00CD36

CODE_00CD24:
	LDA wm_MarioSpeedY
	BPL +
	LDA wm_MarioObjStatus
	AND.B #$08
	BEQ +
	STZ wm_MarioSpeedY
+	JSR CODE_00DC2D
	JSR CODE_00E92B
_00CD36:
	JSR CODE_00F595
_00CD39:
	STZ wm_PlayerTurningPose
	LDY wm_PBalloonFrame
	BNE CODE_00CD95
	LDA wm_CanClimbAir
	BEQ +
	LDA.B #$1F
	STA wm_8B
+	LDA wm_IsClimbing
	BNE +
	LDA wm_IsCarrying2
	ORA wm_OnYoshi
	BNE CODE_00CD79
	LDA wm_8B
	AND.B #$1B
	CMP.B #$1B
	BNE CODE_00CD79
	LDA wm_JoyPadA
	AND.B #$0C
	BEQ CODE_00CD79
	LDY wm_IsFlying
	BNE +
	AND.B #$08
	BNE +
	LDA wm_8B
	AND.B #$04
	BEQ CODE_00CD79
+	LDA wm_8B
	STA wm_IsClimbing
	JMP CODE_00DB17

CODE_00CD79:
	LDA wm_IsSwimming
	BEQ CODE_00CD82
	JSR CODE_00D988
	BRA _00CD8F

CODE_00CD82:
	JSR CODE_00D5F2
	JSR CODE_00D062
	JSR CODE_00D7E4
_00CD8B:
	JSL CODE_00CEB1
_00CD8F:
	LDY wm_OnYoshi
	BNE CODE_00CDAD
	RTS

CODE_00CD95:
	LDA.B #$42
	LDX wm_MarioPowerUp
	BEQ +
	LDA.B #$43
+	DEY
	BEQ +
	STY wm_PBalloonFrame
	LDA.B #$0F
+	STA wm_MarioFrame
	RTS

OnYoshiAnimations:	.DB $20,$21,$27,$28

CODE_00CDAD:
	LDX wm_YoshiTongueTimer
	BEQ +
	LDY #$03
	CPX #$0C
	BCS +
	LDY #$04
+	LDA OnYoshiAnimations-1,Y
	DEY
	BNE +
	LDY wm_IsDucking
	BEQ +
	LDA.B #$1D
+	STA wm_MarioFrame
	LDA wm_YoshiHasWings
	CMP.B #$01
	BNE _Return00CDDC ;Unused yoshi fireball
	BIT wm_JoyFrameA
	BVC _Return00CDDC
	LDA.B #$08
	STA wm_18DB
	JSR ShootFireball
_Return00CDDC:
	RTS

CODE_00CDDD:
	LDA wm_HorzScrollHead
	BEQ _Return00CDDC
	LDY wm_LRScrollDir
	LDA wm_LRScrollFlag
	STA wm_SpritesLocked
	BNE _00CE4C
	LDA wm_LRMoveCamera
	BEQ CODE_00CDF6
	STZ wm_LRScrollDir
	BRA _00CE48

CODE_00CDF6:
	LDA wm_JoyPadB
	AND.B #$CF
	ORA wm_JoyPadA
	BNE ++
	LDA wm_JoyPadB
	AND.B #$30
	BEQ ++
	CMP.B #$30
	BEQ ++
	LSR
	LSR
	LSR
	INC wm_LRFrameTimer
	LDX wm_LRFrameTimer
	CPX #$10
	BCC _00CE4C
	TAX
	REP #$20
	LDA wm_PosToScrollScreen
	CMP.W DATA_00F6CB,X
	SEP #$20
	BEQ _00CE4C
	LDA #$01
	TRB wm_PosToScrollScreen
	INC wm_LRScrollFlag
	LDA #$00
	CPX #$02
	BNE +
	LDA wm_LastScreenHorz
	DEC A
+	REP #$20
	XBA
	AND #$FF00
	CMP wm_Bg1HOfs
	SEP #$20
	BEQ +
	LDY #$0E
	STY wm_SoundCh3
+	TXA
	STA wm_LRScrollDir
_00CE48:
	TAY
++	STZ wm_LRFrameTimer
_00CE4C:
	LDX #$00
	LDA wm_MarioDirection
	ASL
	STA wm_LRScrollStop
	REP #$20
	LDA wm_PosToScrollScreen
	CMP DATA_00F6CB,Y
	BEQ +
	CLC
	ADC DATA_00F6BF,Y
	LDY wm_LRScrollStop
	CMP DATA_00F6B3,Y
	BNE ++
	STX wm_LRScrollDir
+	STX wm_LRScrollFlag
++	STA wm_PosToScrollScreen
	STX wm_LRMoveCamera
	SEP #$20
	RTS

DATA_00CE79:
	.DB $2A,$2B,$2C,$2D,$2E,$2F,$2C,$2C
	.DB $2C,$2B,$2B,$2C,$2C,$2B,$2B,$2C
	.DB $2D,$2A,$2A,$2D,$2D,$2A,$2A,$2D
	.DB $2D,$2A,$2A,$2D,$2E,$2A,$2A,$2E

DATA_00CE99:	.DB $00,$00,$25,$44,$00,$00,$0F,$45

DATA_00CEA1:	.DB $00,$00,$00,$00,$01,$01,$01,$01

DATA_00CEA9:	.DB $02,$07,$06,$09,$02,$07,$06,$09

CODE_00CEB1:
	LDA wm_CapeWaveTimer
	BNE _lbl14A2Not0
	LDX wm_CapeImage
	LDA wm_IsFlying
	BEQ MarioAnimAir
	LDY #$04
	BIT wm_MarioSpeedY
	BPL CODE_00CECD
	CMP #$0C
	BEQ _00CEFD
	LDA wm_IsSwimming
	BNE _00CEFD
	BRA _MrioNtInWtr

CODE_00CECD:
	INX
	CPX #$05
	BCS CODE_00CED6
	LDX #$05
	BRA _00CF0A

CODE_00CED6:
	CPX #$0B
	BCC _00CF0A
	LDX #$07
	BRA _00CF0A

MarioAnimAir:
	LDA wm_MarioSpeedX
	BNE CODE_00CEF0
	LDY #$08
_MrioNtInWtr:
	TXA
	BEQ _00CF0A
	DEX
	CPX #$03
	BCC _00CF0A
	LDX #$02
	BRA _00CF0A

CODE_00CEF0:
	BPL +
	EOR #$FF
	INC A
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_00DC7C,Y
	TAY
_00CEFD:
	INX
	CPX #$03
	BCS +
	LDX #$05
+	CPX #$07
	BCC _00CF0A
	LDX #$03
_00CF0A:
	STX wm_CapeImage
	TYA
	LDY wm_IsSwimming
	BEQ +
	ASL
+	STA wm_CapeWaveTimer
_lbl14A2Not0:
	LDA wm_IsSpinJump
	ORA wm_CapeSpinTimer
	BEQ CODE_00CF4E
	STZ wm_IsDucking
	LDA wm_FrameB
	AND #$06
	TAX
	TAY
	LDA wm_IsFlying
	BEQ +
	LDA wm_MarioSpeedY
	BMI +
	INY
+	LDA DATA_00CEA9,Y
	STA wm_CapeImage
	LDA wm_MarioPowerUp
	BEQ +
	INX
+	LDA.W DATA_00CEA1,X
	STA wm_MarioDirection
	LDY wm_MarioPowerUp
	CPY #$02
	BNE +
	JSR CODE_00D044
+	LDA.W DATA_00CE99,X
	JMP _00D01A

CODE_00CF4E:
	LDA wm_PlayerSlopePose
	BEQ CODE_00CF62
	BPL _00CF85
	LDA wm_OnSlopeTypeB
	LSR
	LSR
	ORA wm_MarioDirection
	TAY
	LDA DATA_00CE79+6,Y
	BRA _00CF85

CODE_00CF62:
	LDA #$3C
	LDY wm_IsCarrying2
	BEQ +
	LDA #$1D
+	LDY wm_IsDucking
	BNE _00CF85
	LDA wm_FireballImgTimer
	BEQ CODE_00CF7E
	LDA #$3F
	LDY wm_IsFlying
	BEQ _00CF85
	LDA #$16
	BRA _00CF85

CODE_00CF7E:
	LDA #$0E
	LDY wm_KickImgTimer
	BEQ CODE_00CF88
_00CF85:
	JMP _00D01A

CODE_00CF88:
	LDA #$1D
	LDY wm_PickUpImgTimer
	BNE _00CF85
	LDA #$0F
	LDY wm_FaceCamImgTimer
	BNE _00CF85
	LDA #$00
	LDX wm_IsInLakituCloud
	BNE _MarioAnimNoAbs1
	LDA wm_IsFlying
	BEQ CODE_00CFB7
	LDY wm_RunCapeTimer
	BNE _00CFBC
	LDY wm_CapeGlidePhase
	BEQ +
	LDA DATA_00CE79-1,Y
+	LDY wm_IsCarrying2
	BEQ _00D01A
	LDA #$09
	BRA _00D01A

CODE_00CFB7:
	LDA wm_PlayerTurningPose
	BNE _00D01A
_00CFBC:
	LDA wm_MarioSpeedX
	BPL _MarioAnimNoAbs1
	EOR #$FF
	INC A
_MarioAnimNoAbs1:
	TAX
	BNE CODE_00CFD4
	XBA
	LDA wm_JoyPadA
	AND #$08
	BEQ _00D002
	LDA #$03
	STA wm_OWCreditsPose
	BRA _00D002

CODE_00CFD4:
	LDA wm_IsSlipperyLevel
	BEQ +
	LDA wm_JoyPadA
	AND #$03
	BEQ ++
	LDA #$68
	STA wm_PlayerFrameIndex
+	LDA wm_PlayerWalkPose
	LDY wm_PlayerAnimTimer
	BNE ++
	DEC A
	BPL +
	LDY wm_MarioPowerUp
	LDA NumWalkingFrames,Y
+	XBA
	TXA
	LSR
	LSR
	LSR
	ORA wm_PlayerFrameIndex
	TAY
	LDA DATA_00DC7C,Y
	STA wm_PlayerAnimTimer
_00D002:
	XBA
++	STA wm_PlayerWalkPose
	CLC
	ADC wm_OWCreditsPose
	LDY wm_IsCarrying2
	BEQ CODE_00D014
	CLC
	ADC #$07
	BRA _00D01A

CODE_00D014:
	CPX #$2F
	BCC _00D01A
	ADC #$03
_00D01A:
	LDY wm_WallWalkStatus
	BEQ +
	TYA
	AND #$01
	STA wm_MarioDirection
	LDA #$10
	CPY #$06
	BCC +
	LDA wm_PlayerWalkPose
	CLC
	ADC #$11
+	STA wm_MarioFrame
	RTL

DATA_00D034:	.DW 12,-12,8,-8

DATA_00D03C:	.DW 16,16,2,2

CODE_00D044:
	LDY #$01
	STY wm_CapeCanHurt
	ASL
	TAY
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC DATA_00D034,Y
	STA wm_CapeXPos
	LDA wm_MarioYPos
	CLC
	ADC DATA_00D03C,Y
	STA wm_CapeYPos
	SEP #$20
	RTS

CODE_00D062:
	LDA wm_MarioPowerUp
	CMP #$02
	BNE CODE_00D081
	BIT wm_JoyFrameA
	BVC _Return00D0AD
	LDA wm_IsDucking
	ORA wm_OnYoshi
	ORA wm_IsSpinJump
	BNE _Return00D0AD
	LDA #$12
	STA wm_CapeSpinTimer
	LDA #$04
	STA wm_SoundCh3
	RTS

CODE_00D081:
	CMP #$03
	BNE _Return00D0AD
	LDA wm_IsDucking
	ORA wm_OnYoshi
	BNE _Return00D0AD
	BIT wm_JoyFrameA
	BVS ++
	LDA wm_IsSpinJump
	BEQ _Return00D0AD
	INC wm_SpinFireTimer
	LDA wm_SpinFireTimer
	AND #$0F
	BNE _Return00D0AD
	TAY
	LDA wm_SpinFireTimer
	AND #$10
	BEQ +
	INY
+	STY wm_MarioDirection
++	JSR ShootFireball
_Return00D0AD:
	RTS

UNK_00D0AE:	.DB $7C,$00,$80,$00,$00,$06,$00,$01

MarioDeathAni:
	STZ wm_MarioPowerUp
	LDA #$3E
	STA wm_MarioFrame
	LDA wm_FrameA
	AND #$03
	BNE +
	DEC wm_PlayerAnimTimer
+	LDA wm_PlayerAnimTimer
	BNE DeathNotDone
	LDA #$80
	STA wm_LevelEndFlag
	LDA wm_DisableYoshiFlag
	BNE +
	STZ wm_OWHasYoshi
+	DEC wm_StatusLives
	BPL DeathNotGameOver
	LDA #$0A
	STA wm_MusicCh1
	LDX #$14
	BRA _DeathShowMessage

DeathNotGameOver:
	LDY #$0B
	LDA wm_TimerHundreds
	ORA wm_TimerTens
	ORA wm_TimerOnes
	BNE +
	LDX #$1D
_DeathShowMessage:
	STX wm_DeathMsgType
	LDA #$C0
	STA wm_DeathMsgAnim
	LDA #$FF
	STA wm_DeathMsgTimer
	LDY #$15
+	STY wm_GameMode
	RTS

DeathNotDone:
	CMP #$26
	BCS +
	STZ wm_MarioSpeedX
	JSR CODE_00DC2D
	JSR _00D92E
	LDA wm_FrameA
	LSR
	LSR
	AND #$01
	STA wm_MarioDirection
+	RTS

GrowingAniImgs:
	.DB $00,$3D,$00,$3D,$00,$3D,$46,$3D
	.DB $46,$3D,$46,$3D

PowerDownAni:
	LDA wm_PlayerAnimTimer
	BEQ CODE_00D140
	LSR
	LSR
_00D130:
	TAY
	LDA GrowingAniImgs,Y
	STA wm_MarioFrame
_00D137:
	LDA wm_PlayerAnimTimer
	BEQ +
	DEC wm_PlayerAnimTimer
+	RTS

CODE_00D140:
	LDA #$7F
	STA wm_PlayerHurtTimer
	BRA _00D158

MushroomAni:
	LDA wm_PlayerAnimTimer
	BEQ CODE_00D156
	LSR
	LSR
	EOR #$FF
	INC A
	CLC
	ADC #$0B
	BRA _00D130

CODE_00D156:
	INC wm_MarioPowerUp
_00D158:
	LDA #$00
	STA wm_MarioAnimation
	STZ wm_SpritesLocked
_Return00D15E:
	RTS

CapeAni:
	LDA #$7F
	STA wm_HidePlayer
	DEC wm_PlayerAnimTimer
	BNE _Return00D15E
	LDA wm_MarioPowerUp
	LSR
	BEQ CODE_00D140
	BNE _00D158 ; [BRA FIX]

FlowerAni:
	LDA wm_PlayerSlopePose
	AND #$80
	ORA wm_CapeGlidePhase
	BEQ +
	STZ wm_CapeGlidePhase
	LDA wm_PlayerSlopePose
	AND #$7F
	STA wm_PlayerSlopePose
	STZ wm_MarioFrame
+	DEC wm_FlashingPalTimer
	BEQ _00D158
	RTS

PipeSpeedX:	.DB -8,8

PipeSpeedY:	.DB 0,0,-16,16

HIDEPIPESETS:	.DB $00,$63,$1C,$00

DoorPipeAni:
	JSR _NoButtons
	STZ wm_OWCreditsPose
	JSL CODE_00CEB1
	JSL _00CFBC
	JSR CODE_00D1F4
	LDA wm_OnYoshi
	BEQ +
	LDA #$29
	STA wm_MarioFrame
+	REP #$20
	LDA wm_MarioYPos
	SEC
	SBC #$0008
	AND #$FFF0
	ORA #$000E
	STA wm_MarioYPos
	SEP #$20
	LDA wm_PipeAction
	LSR
	TAY
	INY
	LDA HIDEPIPESETS-1,Y
	LDX wm_IsCarrying2
	BEQ +
	EOR #$1C
	DEC wm_FaceCamImgTimer
	BPL +
	INC wm_FaceCamImgTimer
+	LDX wm_PipeWarpTimer
	CPX #$1D
	BCS ++
	CPY #$03
	BCC +
	REP #$20
	INC wm_MarioYPos
	INC wm_MarioYPos
	SEP #$20
+	LDA HIDEPIPESETS,Y
++	STA wm_HidePlayer
	BRA _00D22D

CODE_00D1F4:
	LDA wm_CapeWaveTimer
	BEQ +
	DEC wm_CapeWaveTimer
+	JMP _00D137

PipeCntrBoundryX:	.DB 10,6

PipeCntringSpeed:	.DB -1,1

VertPipeAni:
	JSR _NoButtons
	STZ wm_CapeImage
	LDA #$0F
	LDY wm_OnYoshi
	BEQ +++
	LDX #$00
	LDY wm_MarioDirection
	LDA wm_MarioXPos
	AND #$0F
	CMP PipeCntrBoundryX,Y
	BEQ ++
	BPL +
	INX
+	LDA wm_MarioXPos
	CLC
	ADC.W PipeCntringSpeed,X
	STA wm_MarioXPos
++	LDA #$21
+++	STA wm_MarioFrame
_00D22D:
	LDA #$40
	STA wm_JoyPadA
	LDA #$02
	STA wm_IsBehindScenery
	LDA wm_PipeAction
	CMP #$04
	LDY wm_PipeWarpTimer
	BEQ CODE_00D268
	AND #$03
	TAY
	DEC wm_PipeWarpTimer
	BNE +
	BCS +
	LDA #$7F
	STA wm_HidePlayer
	INC wm_WarpingWithYoshi
+	LDA wm_MarioSpeedX
	ORA wm_MarioSpeedY
	BNE +
	LDA #$04
	STA wm_SoundCh1
+	LDA PipeSpeedX,Y
	STA wm_MarioSpeedX
	LDA PipeSpeedY,Y
	STA wm_MarioSpeedY
	STZ wm_IsFlying
	JMP CODE_00DC2D

CODE_00D268:
	BCC CODE_00D273
_00D26A:
	STZ wm_IsBehindScenery
	STZ wm_YoshiInPipe
	JMP _00D158

CODE_00D273:
	INC wm_NumSubLvEntered
	LDA #$0F
	STA wm_GameMode
	RTS

ADDR_00D27C:
	LDA wm_MarioYPos ;unreachable routine
	SEC
	SBC wm_PlayerYPosLv
	CLC
	ADC wm_PipeWarpTimer
	STA wm_PipeWarpTimer
	RTS

PipeCannonAni:
	JSR _NoButtons
	LDA #$02
	STA wm_IsBehindScenery
	LDA #$0C
	STA wm_IsFlying
	JSR _00CD8B
	DEC wm_PipeWarpTimer
	BNE CODE_00D29D
	JMP _00D26A

CODE_00D29D:
	LDA wm_PipeWarpTimer
	CMP #$18
	BCC +
	BNE ++
	LDA #$09
	STA wm_SoundCh3
+	STZ wm_IsBehindScenery
	STZ wm_YoshiInPipe
	STZ wm_SpritesLocked
++	LDA #$40
	STA wm_MarioSpeedX
	LDA #$C0
	STA wm_MarioSpeedY
	JMP CODE_00DC2D

DATA_00D2BD:
	.DB $B0,$B6,$AE,$B4,$AB,$B2,$A9,$B0
	.DB $A6,$AE,$A4,$AB,$A1,$A9,$9F,$A6

DATA_00D2CD:
	.DB 0,-1,0,1,0,-1,0,1
	.DB 0,-1,0,1,128,-2,-64,0
	.DB 64,-1,128,1,0,-2,64,0
	.DB -64,-1,0,2,0,-2,64,0
	.DB 0,-2,64,0,-64,-1,0,2
	.DB -64,-1,0,2,0,-4,0,-1
	.DB 0,1,0,4,0,-1,0,1
	.DB 0,-1,0,1

DATA_00D309:
	.DB -32,-1,32,0,-32,-1,32,0
	.DB -32,-1,32,0,-64,-1,32,0
	.DB -32,-1,64,0,128,-1,32,0
	.DB -32,-1,128,0,128,-1,32,0
	.DB 128,-1,32,0,-32,-1,128,0
	.DB -32,-1,128,0,0,-2,128,-1
	.DB 128,0,0,2,0,-1,0,1
	.DB 0,-1,0,1

MarioAccel:
	.DB 128,-2,128,-2,128,1,128,1
	.DB 128,-2,128,-2,128,1,128,1
	.DB 128,-2,128,-2,128,1,128,1
	.DB 128,-2,128,-2,64,1,64,1
	.DB -64,-2,-64,-2,128,1,128,1
	.DB 128,-2,128,-2,0,1,0,1
	.DB 0,-1,0,-1,128,1,128,1
	.DB 128,-2,128,-2,0,1,0,1
	.DB 128,-2,128,-2,0,1,0,1
	.DB 0,-1,0,-1,128,1,128,1
	.DB 0,-1,0,-1,128,1,128,1
	.DB 0,-4,0,-4,0,-3,0,-3
	.DB 0,3,0,3,0,4,0,4
	.DB 0,-4,0,-4,0,6,0,6
	.DB 0,-6,0,-6,0,4,0,4
	.DB 128,-1,128,0,0,-1,0,1
	.DB 128,-2,128,1,128,-2,128,-2
	.DB 128,1,128,1,128,-2,128,2
	.DB 128,-3,0,-5,128,2,0,5
	.DB 128,-3,0,-5,128,2,0,5
	.DB 128,-3,0,-5,128,2,0,5
	.DB 64,-3,128,-6,64,2,128,4
	.DB -64,-3,128,-5,-64,2,128,5
	.DB 0,-3,0,-6,0,2,0,4
	.DB 0,-2,0,-4,0,3,0,6
	.DB 0,-3,0,-6,0,2,0,4
	.DB 0,-3,0,-6,0,2,0,4
	.DB 0,-2,0,-4,0,3,0,6
	.DB 0,-2,0,-4,0,3,0,6
	.DB 0,-3,0,-6,0,-3,0,-6
	.DB 0,3,0,6,0,3,0,6

DATA_00D43D:
	.DB 128,-1,128,-2,128,0,128,1
	.DB 128,-1,128,-2,128,0,128,1
	.DB 128,-1,128,-2,128,0,128,1
	.DB 128,-2,128,-2,128,0,64,1
	.DB 128,-1,-64,-2,128,1,128,1
	.DB 128,-2,128,-2,128,0,0,1
	.DB 128,-1,0,-1,128,1,128,1
	.DB 128,-2,128,-2,128,0,0,1
	.DB 128,-2,128,-2,128,0,0,1
	.DB 128,-1,0,-1,128,1,128,1
	.DB 128,-1,0,-1,128,1,128,1
	.DB 0,-4,0,-4,0,-2,0,-3
	.DB 0,3,0,3,0,4,0,4
	.DB 0,-4,0,-4,128,0,128,0
	.DB 128,-1,128,-1,0,4,0,4
	.DB 128,-1,128,0,0,-1,0,1
	.DB 128,-2,128,1,128,-2,128,-2
	.DB 128,1,128,1,128,-2,128,2
	.DB -64,-1,128,-3,64,0,128,2
	.DB -64,-1,128,-3,64,0,128,2
	.DB -64,-1,128,-3,64,0,128,2
	.DB 128,-1,64,-3,64,0,64,2
	.DB -64,-1,-64,-3,128,0,-64,2
	.DB 0,-3,0,-3,64,0,0,2
	.DB -64,-1,0,-2,0,3,0,3
	.DB 0,-3,0,-3,64,0,0,2
	.DB 0,-3,0,-3,64,0,0,2
	.DB -64,-1,0,-2,0,3,0,3
	.DB -64,-1,0,-2,0,3,0,3
	.DB 0,-3,0,-3,0,-3,0,-3
	.DB 0,3,0,3,0,3,0,3

DATA_00D535:
	.DB -20,20,-36,36,-36,36,-48,48
	.DB -20,20,-36,36,-36,36,-48,48
	.DB -20,20,-36,36,-36,36,-48,48
	.DB -24,18,-36,32,-36,32,-48,44
	.DB -18,24,-32,36,-32,36,-44,48
	.DB -36,16,-36,28,-36,28,-48,40
	.DB -16,36,-28,36,-28,36,-40,48
	.DB -36,16,-36,28,-36,28,-48,40
	.DB -36,16,-36,28,-36,28,-48,40
	.DB -16,36,-28,36,-28,36,-40,48
	.DB -16,36,-28,36,-28,36,-40,48
	.DB -36,-16,-36,-8,-36,-8,-48,-4
	.DB 16,36,8,36,8,36,4,48
	.DB -48,8,-48,8,-48,8,-48,8
	.DB -8,48,-8,48,-8,48,-8,48
	.DB -8,8,-16,16,-12,4,-24,8
	.DB -16,16,-32,32,-20,12,-40,24
	.DB -40,40,-44,44,-48,48,-48,-48
	.DB 48,48,-32,32

DATA_00D5C9:
	.DB 0,0,0,0,0,0,0,0
	.DB 0,0,0,-16,0,16,0,0
	.DB 0,0,0,0,0,0,0,-32
	.DB 0,32,0,0,0,0,0,-16
	.DB 0,-8

DATA_00D5EB:	.DB -1,-1,2

DATA_00D5EE:	.DB $68,$70

DATA_00D5F0:	.DB $1C,$0C

CODE_00D5F2:
	LDA wm_IsFlying
	BEQ CODE_00D5F9
	JMP _00D682

CODE_00D5F9:
	STZ wm_IsDucking
	LDA wm_PlayerSlopePose
	BNE +
	LDA wm_JoyPadA
	AND #$04
	BEQ +
	STA wm_IsDucking
	STZ wm_CapeCanHurt
+	LDA wm_IsOnSolidSpr
	CMP #$02
	BEQ +
	LDA wm_MarioObjStatus
	AND #$08
	BNE +
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	BMI CODE_00D630
+	LDA wm_IsDucking
	BEQ _00D682
	LDA wm_MarioSpeedX
	BEQ +
	LDA wm_IsSlipperyLevel
	BNE +
	JSR CODE_00FE4A
+	JMP CODE_00D764

CODE_00D630:
	LDA wm_MarioSpeedX
	BPL +
	EOR #$FF
	INC A
+	LSR
	LSR
	AND #$FE
	TAX
	LDA wm_JoyFrameB
	BPL CODE_00D65E
	LDA wm_IsCarrying2
	BNE CODE_00D65E
	INC A
	STA wm_IsSpinJump
	LDA #$04
	STA wm_SoundCh3
	LDY wm_MarioDirection
	LDA DATA_00D5F0,Y
	STA wm_SpinFireTimer
	LDA wm_OnYoshi
	BNE _00D682
	INX
	BRA _00D663

CODE_00D65E:
	LDA #$01
	STA wm_SoundCh2
_00D663:
	LDA.W DATA_00D2BD,X
	STA wm_MarioSpeedY
	LDA #$0B
	LDY wm_PlayerDashTimer
	CPY #$70
	BCC ++
	LDA wm_GlideTimer
	BNE +
	LDA #$50
	STA wm_GlideTimer
+	LDA #$0C
++	STA wm_IsFlying
	STZ wm_PlayerSlopePose
_00D682:
	LDA wm_PlayerSlopePose
	BMI +
	LDA wm_JoyPadA
	AND #$03
	BNE CODE_00D6B1
_00D68D:
	LDA wm_PlayerSlopePose
	BEQ CODE_00D6AE
+	JSR CODE_00FE4A
	LDA wm_OnSlopeTypeA
	BEQ CODE_00D6AE
	JSR CODE_00D968
	LDA wm_OnSlopeTypeB
	LSR
	LSR
	TAY
	ADC #$76
	TAX
	TYA
	LSR
	ADC #$87
	TAY
	JMP _00D742

CODE_00D6AE:
	JMP CODE_00D764

CODE_00D6B1:
	STZ wm_PlayerSlopePose
	AND #$01
	LDY wm_CapeGlidePhase
	BEQ CODE_00D6D5
	CMP wm_MarioDirection
	BEQ +
	LDY wm_JoyFrameA
	BPL _00D68D
+	LDX wm_MarioDirection
	LDY.W DATA_00D5EE,X
	STY wm_OnSlopeTypeB
	STA m1
	ASL
	ASL
	ORA wm_OnSlopeTypeB
	TAX
	BRA _00D713

CODE_00D6D5:
	LDY wm_MarioDirection
	CMP wm_MarioDirection
	BEQ ++
	LDY wm_IsCarrying2
	BEQ +
	LDY wm_FaceCamImgTimer
	BNE ++
	LDY #$08
	STY wm_FaceCamImgTimer
+	STA wm_MarioDirection
++	STA m1
	ASL
	ASL
	ORA wm_OnSlopeTypeB
	TAX
	LDA wm_MarioSpeedX
	BEQ _00D713
	EOR.W MarioAccel+1,X
	BPL _00D713
	LDA wm_SlideImgTimer
	BNE _00D713
	LDA wm_IsSlipperyLevel
	BNE +
	LDA #$0D
	STA wm_PlayerTurningPose
	JSR CODE_00FE4A
+	TXA
	CLC
	ADC #$90
	TAX
_00D713:
	LDY #$00
	BIT wm_JoyPadA
	BVC _00D737
	INX
	INX
	INY
	LDA wm_MarioSpeedX
	BPL +
	EOR #$FF
	INC A
+	CMP #$23
	BMI _00D737
	LDA wm_IsFlying
	BNE CODE_00D732
	LDA #$10
	STA wm_RunCapeTimer
	BRA _00D736

CODE_00D732:
	CMP #$0C
	BNE _00D737
_00D736:
	INY
_00D737:
	JSR _00D96A
	TYA
	ASL
	ORA wm_OnSlopeTypeB
	ORA m1
	TAY
_00D742:
	LDA wm_MarioSpeedX
	SEC
	SBC DATA_00D535,Y
	BEQ _00D76B
	EOR DATA_00D535,Y
	BPL _00D76B
	REP #$20
	LDA.W MarioAccel,X
	LDY wm_IsSlipperyLevel
	BEQ +
	LDY wm_IsFlying
	BNE +
	LDA.W DATA_00D43D,X
+	CLC
	ADC wm_MarioAccSpeedX
	BRA _00D7A0

CODE_00D764:
	JSR CODE_00D968
	LDA wm_IsFlying
	BNE +++
_00D76B:
	LDA wm_OnSlopeTypeB
	LSR
	TAY
	LSR
	TAX
_00D772:
	LDA wm_MarioSpeedX
	SEC
	SBC.W DATA_00D5C9+1,X
	BPL +
	INY
	INY
+	LDA wm_EndLevelTimer
	ORA wm_IsFlying
	REP #$20
	BNE +
	LDA DATA_00D309,Y
	BIT wm_IsWaterLevel
	BMI ++
+	LDA DATA_00D2CD,Y
++	CLC
	ADC wm_MarioAccSpeedX
	STA wm_MarioAccSpeedX
	SEC
	SBC.W DATA_00D5C9,X
	EOR DATA_00D2CD,Y
	BMI +
	LDA.W DATA_00D5C9,X
_00D7A0:
	STA wm_MarioAccSpeedX
+	SEP #$20
+++	RTS

DATA_00D7A5:	.DB 6,3,4,16,-12,1,3,4,5,6

DATA_00D7AF:	.DB 64,64,32,64,64,64,64,64,64,64

DATA_00D7B9:	.DB 16,-56,-32,2,3,3,4,3,2,0,1,0,0,0,0

DATA_00D7C8:	.DB 1,16,48,48,56,56,64

CapeSpeed:	.DB -1,1,1,-1,-1

DATA_00D7D4:	.DB 1,6,3,1,0

DATA_00D7D9:	.DB 0,0,0,-8,-8,-8,-12,-16,-56,2,1

CODE_00D7E4:
	LDY wm_CapeGlidePhase
	BNE CODE_00D824
	LDA wm_IsFlying
	BEQ ++
	LDA wm_IsCarrying2
	ORA wm_OnYoshi
	ORA wm_IsSpinJump
	BNE ++
	LDA wm_PlayerSlopePose
	BMI +
	BNE ++
+	STZ wm_PlayerSlopePose
	LDX wm_MarioPowerUp
	CPX #$02
	BNE ++
	LDA wm_MarioSpeedY
	BMI ++
	LDA wm_GlideTimer
	BNE CODE_00D814
++	JMP CODE_00D8CD

CODE_00D814:
	STZ wm_IsDucking
	LDA #$0B
	STA wm_IsFlying
	STZ wm_CapeDivePhase
	JSR CODE_00D94F
	LDX #$02
	BRA _00D85B

CODE_00D824:
	CPY #$02
	BCC +
	JSR CODE_00D94F
+	LDX wm_CapeGlideIndex
	CPX #$04
	BEQ _00D856
	LDX #$03
	LDY wm_MarioSpeedY
	BMI _00D856
	LDA wm_JoyPadA
	AND #$03
	TAY
	BNE CODE_00D849
	LDA wm_CapeGlidePhase
	CMP #$04
	BCS _00D856
	DEX
	BRA _00D856

CODE_00D849:
	LSR
	LDY wm_MarioDirection
	BEQ +
	EOR #$01
+	TAX
	CPX wm_CapeGlideIndex
	BNE _00D85B
_00D856:
	LDA wm_DivingTimer
	BNE ++
_00D85B:
	BIT wm_JoyPadA
	BVS +
	LDX #$04
+	LDA wm_CapeGlidePhase
	CMP.W DATA_00D7D4,X
	BEQ ++
	CLC
	ADC.W CapeSpeed,X
	STA wm_CapeGlidePhase
	LDA #$08
	LDY wm_CapeDivePhase
	CPY #$C8
	BNE +
	LDA #$02
+	STA wm_DivingTimer
++	STX wm_CapeGlideIndex
	LDY wm_CapeGlidePhase
	BEQ CODE_00D8CD
	LDA wm_MarioSpeedY
	BPL CODE_00D892
	CMP #$C8
	BCS _00D89A
	LDA #$C8
	BRA _00D89A

CODE_00D892:
	CMP DATA_00D7C8,Y
	BCC _00D89A
	LDA DATA_00D7C8,Y
_00D89A:
	PHA
	CPY #$01
	BNE _00D8C6
	LDX wm_CapeDivePhase
	BEQ _00D8C4
	LDA wm_MarioSpeedY
	BMI CODE_00D8AF
	LDA #$09
	STA wm_SoundCh1
	BRA _00D8B9

CODE_00D8AF:
	CMP wm_CapeDivePhase
	BCS _00D8B9
	STX wm_MarioSpeedY
	STZ wm_CapeDivePhase
_00D8B9:
	LDX wm_MarioDirection
	LDA wm_MarioSpeedX
	BEQ _00D8C4
	EOR.W DATA_00D535,X
	BPL _00D8C6
_00D8C4:
	LDY #$02
_00D8C6:
	PLA
	INY
	INY
	INY
	JMP _00D948

CODE_00D8CD:
	LDA wm_IsFlying
	BEQ _00D928
	LDX #$00
	LDA wm_OnYoshi
	BEQ CODE_00D8E7
	LDA wm_YoshiHasWings
	LSR
	BEQ CODE_00D8E7
	LDY #$02
	CPY wm_MarioPowerUp
	BEQ +
	INX
+	BRA _00D8FF

CODE_00D8E7:
	LDA wm_MarioPowerUp
	CMP #$02
	BNE _00D928
	LDA wm_IsFlying
	CMP #$0C
	BNE +
	LDY #$01
	CPY wm_GlideTimer
	BCC _00D8FF
	INC wm_GlideTimer
+	LDY #$00
_00D8FF:
	LDA wm_FloatingTimer
	BNE +
	LDA wm_JoyPadA,X
	BPL ++
	LDA #$10
	STA wm_FloatingTimer
+	LDA wm_MarioSpeedY
	BPL +
	LDX.W DATA_00D7B9,Y
	BPL ++
	CMP DATA_00D7B9,Y
	BCC ++
+	LDA DATA_00D7B9,Y
	CMP wm_MarioSpeedY
	BEQ +++
	BMI +++
++	CPY #$02
	BEQ +
_00D928:
	LDY #$01
	LDA wm_JoyPadA
	BMI +
_00D92E:
	LDY #$00
+	LDA wm_MarioSpeedY
	BMI _00D948 ; BUG-FIX: ID 004-00
	CMP DATA_00D7AF,Y
	BCC +
	LDA DATA_00D7AF,Y
+	LDX wm_IsFlying
	BEQ _00D948
	CPX #$0B
	BNE _00D948
	LDX #$24
	STX wm_IsFlying
_00D948:
	CLC ; BUG-FIX: ID 004-01
	ADC DATA_00D7A5,Y
+++	STA wm_MarioSpeedY
	RTS

CODE_00D94F:
	STZ wm_140A
	LDA wm_MarioSpeedY
	BPL +
	LDA #$00
+	LSR
	LSR
	LSR
	TAY
	LDA DATA_00D7D9,Y
	CMP wm_CapeDivePhase
	BPL +
	STA wm_CapeDivePhase
+	RTS

CODE_00D968:
	LDY #$00
_00D96A:
	LDA wm_PlayerDashTimer
	CLC
	ADC DATA_00D5EB,Y
	BPL +
	LDA #$00
+	CMP #$70
	BCC +
	INY
	LDA #$70
+	STA wm_PlayerDashTimer
	RTS

DATA_00D980:	.DB $16,$1A,$1A,$18

DATA_00D984:	.DB -24,-8,-48,-48

CODE_00D988:
	STZ wm_PlayerSlopePose
	STZ wm_IsDucking
	STZ wm_CapeGlidePhase
	STZ wm_IsSpinJump
	LDY wm_MarioSpeedY
	LDA wm_IsCarrying2
	BEQ CODE_00D9EB
	LDA wm_IsFlying
	BNE CODE_00D9AF
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	BPL CODE_00D9AF
	LDA #$0B
	STA wm_IsFlying
	STZ wm_PlayerSlopePose
	LDY #$F0
	BRA _00D9B5

CODE_00D9AF:
	LDA wm_JoyPadA
	AND #$04
	BEQ +
_00D9B5:
	JSR CODE_00DAA9
	TYA
	CLC
	ADC #$08
	TAY
+	INY
	LDA wm_IsOnWaterTop
	BNE +
	DEY
	LDA wm_FrameB
	AND #$03
	BNE +
	DEY
	DEY
+	TYA
	BMI CODE_00D9D7
	CMP #$10
	BCC _00D9DD
	LDA #$10
	BRA _00D9DD

CODE_00D9D7:
	CMP #$F0
	BCS _00D9DD
	LDA #$F0
_00D9DD:
	STA wm_MarioSpeedY
	LDY #$80
	LDA wm_JoyPadA
	AND #$03
	BNE _00DA48
	LDA wm_MarioDirection
	BRA _00DA46

CODE_00D9EB:
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	BPL ++
	LDA wm_IsOnWaterTop
	BNE ++
	JSR CODE_00DAA9
	LDA wm_IsFlying
	BNE +
	LDA #$0B
	STA wm_IsFlying
	STZ wm_PlayerSlopePose
	LDY #$F0
+	TYA
	SEC
	SBC #$20
	TAY
++	LDA wm_FrameB
	AND #$03
	BNE +
	INY
	INY
+	LDA wm_JoyPadA
	AND #$0C
	LSR
	LSR
	TAX
	TYA
	BMI CODE_00DA25
	CMP #$40
	BCC _00DA2D
	LDA #$40
	BRA _00DA2D

CODE_00DA25:
	CMP.W DATA_00D984,X
	BCS _00DA2D
	LDA.W DATA_00D984,X
_00DA2D:
	STA wm_MarioSpeedY
	LDA wm_IsFlying
	BNE CODE_00DA40
	LDA wm_JoyPadA
	AND #$04
	BEQ CODE_00DA40
	STZ wm_CapeCanHurt
	INC wm_IsDucking
	BRA CODE_00DA69

CODE_00DA40:
	LDA wm_JoyPadA
	AND #$03
	BEQ CODE_00DA69
_00DA46:
	LDY #$78
_00DA48:
	STY m0
	AND #$01
	STA wm_MarioDirection
	PHA
	ASL
	ASL
	TAX
	PLA
	ORA m0
	LDY wm_L3TideSetting
	BEQ +
	CLC
	ADC #$04
+	TAY
	LDA wm_IsFlying
	BEQ +
	INY
	INY
+	JSR _00D742
	BRA _00DA7C

CODE_00DA69:
	LDY #$00
	TYX
	LDA wm_L3TideSetting
	BEQ +
	LDX #$1E
	LDA wm_IsFlying
	BNE +
	INX
	INX
+	JSR _00D772
_00DA7C:
	JSR CODE_00D062
	JSL CODE_00CEB1
	LDA wm_CapeSpinTimer
	BNE +
	LDA wm_IsFlying
	BNE CODE_00DA8D
+	RTS

CODE_00DA8D:
	LDA #$18
	LDY wm_FireballImgTimer
	BNE +
	LDA wm_PlayerAnimTimer
	LSR
	LSR
	AND #$03
	TAY
	LDA DATA_00D980,Y
+	LDY wm_IsCarrying2
	BEQ +
	INC A
+	STA wm_MarioFrame
	RTS

CODE_00DAA9:
	LDA #$0E
	STA wm_SoundCh1
	LDA wm_PlayerAnimTimer
	ORA #$10
	STA wm_PlayerAnimTimer
	RTS

DATA_00DAB7:	.DB 16,8,-16,-8

DATA_00DABB:	.DB -80,-16

DATA_00DABD:	.DB 0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1

DATA_00DACD:
	.DB $22,$15,$22,$15,$21,$1F,$20,$20
	.DB $20,$20,$1F,$21,$1F,$21

ClimbingImgs:	.DB $15,$22

ClimbPunchingImgs:	.DB $1E,$23

DATA_00DADF:
	.DB 16,15,14,13,12,11,10,9
	.DB 8,7,6,5,5,5,5,5
	.DB 5,5

DATA_00DAF1:
	.DW $0120,$0140,$012A,$012A,$0130,$0133,$0132,$0134
	.DW $0136,$0138,$013A,$013B,$0145,$0145,$0145,$0145
	.DW $0145,$0145

UNK_00DB15:	.DB 8,-8

CODE_00DB17:
	STZ wm_IsFlying
	STZ wm_MarioSpeedY
	STZ wm_CapeImage
	STZ wm_IsSpinJump
	LDY wm_NetSideTimer
	BEQ CODE_00DB7D
	LDA wm_PlayerNetDoorX
	BPL +
	EOR #$FF
	INC A
+	TAX
	CPY #$1E
	BCC ++
	LDA.W DATA_00DADF,X
	BIT wm_PlayerNetDoorX
	BPL +
	EOR #$FF
	INC A
+	STA wm_MarioSpeedX
	STZ wm_MarioAccSpeedX
	STZ wm_PlayerXAccFixed
++	TXA
	ASL
	TAX
	LDA wm_PlayerNetDoorX
	CPY #$08
	BCS +
	EOR #$80
+	ASL
	REP #$20
	LDA.W DATA_00DAF1,X
	BCS +
	EOR #$FFFF
	INC A
+	CLC
	ADC wm_MarioAccSpeedX
	STA wm_MarioAccSpeedX
	SEP #$20
	TYA
	LSR
	AND #$0E
	ORA wm_NetFaceDirection
	TAY
	LDA DATA_00DABD,Y
	BIT wm_PlayerNetDoorX
	BMI +
	EOR #$01
+	STA wm_MarioDirection
	LDA DATA_00DACD,Y
	BRA _00DB92

CODE_00DB7D:
	STZ wm_MarioSpeedX
	STZ wm_MarioAccSpeedX
	LDX wm_IsBehindScenery
	LDA wm_NetPunchTimer
	BEQ CODE_00DB96
	TXA
	INC A
	INC A
	JSR CODE_00D044
	LDA.W ClimbPunchingImgs,X
_00DB92:
	STA wm_MarioFrame
	RTS

CODE_00DB96:
	LDY wm_IsSwimming
	BIT wm_JoyFrameA
	BPL CODE_00DBAC
	LDA #$0B
	STA wm_IsFlying
	LDA DATA_00DABB,Y
	STA wm_MarioSpeedY
	LDA #$01
	STA wm_SoundCh2
	BRA _00DC00

CODE_00DBAC:
	BVC +
	LDA wm_IsClimbing
	BPL +
	LDA #$01
	STA wm_SoundCh1
	STX wm_NetFaceDirection
	LDA wm_MarioXPos
	AND #$08
	LSR
	LSR
	LSR
	EOR #$01
	STA wm_MarioDirection
	LDA #$08
	STA wm_NetPunchTimer
+	LDA.W ClimbingImgs,X
	STA wm_MarioFrame
	LDA wm_JoyPadA
	AND #$03
	BEQ ++
	LSR
	TAX
	LDA wm_8B
	AND #$18
	CMP #$18
	BEQ +
	LDA wm_IsClimbing
	BPL _00DC00
	CPX wm_8C
	BEQ ++
+	TXA
	ASL
	ORA wm_IsSwimming
	TAX
	LDA.W DATA_00DAB7,X
	STA wm_MarioSpeedX
++	LDA wm_JoyPadA
	AND #$0C
	BEQ _00DC16
	AND #$08
	BNE CODE_00DC03
	LSR wm_8B
	BCS _00DC0B
_00DC00:
	STZ wm_IsClimbing
	RTS

CODE_00DC03:
	INY
	INY
	LDA wm_8B
	AND #$02
	BEQ _00DC16
_00DC0B:
	LDA wm_IsClimbing
	BMI +
	STZ wm_MarioSpeedX
+	LDA DATA_00DAB7,Y
	STA wm_MarioSpeedY
_00DC16:
	ORA wm_MarioSpeedX
	BEQ +
	LDA wm_PlayerAnimTimer
	ORA #$08
	STA wm_PlayerAnimTimer
	AND #$07
	BNE +
	LDA wm_MarioDirection
	EOR #$01
	STA wm_MarioDirection
+	RTS

CODE_00DC2D:
	LDA wm_MarioSpeedY
	STA wm_8A
	LDA wm_WallWalkStatus
	BEQ ++
	LSR
	LDA wm_MarioSpeedX
	BCC +
	EOR #$FF
	INC A
+	STA wm_MarioSpeedY
++	LDX #$00
	JSR CODE_00DC4F
	LDX #$02
	JSR CODE_00DC4F
	LDA wm_8A
	STA wm_MarioSpeedY
	RTS

CODE_00DC4F:
	LDA wm_MarioSpeedX,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_PlayerXAccFixed,X
	STA wm_PlayerXAccFixed,X
	REP #$20
	PHP
	LDA wm_MarioSpeedX,X
	LSR
	LSR
	LSR
	LSR
	AND #$000F
	CMP #$0008
	BCC +
	ORA #$FFF0
+	PLP
	ADC wm_MarioXPos,X
	STA wm_MarioXPos,X
	SEP #$20
	RTS

NumWalkingFrames:	.DB $01,$02,$02,$02

DATA_00DC7C:
	.DB 10,8,6,4,3,2,1,1
	.DB 10,8,6,4,3,2,1,1
	.DB 10,8,6,4,3,2,1,1
	.DB 8,6,4,3,2,1,1,1
	.DB 8,6,4,3,2,1,1,1
	.DB 5,4,3,2,1,1,1,1
	.DB 5,4,3,2,1,1,1,1
	.DB 5,4,3,2,1,1,1,1
	.DB 5,4,3,2,1,1,1,1
	.DB 5,4,3,2,1,1,1,1
	.DB 5,4,3,2,1,1,1,1
	.DB 4,3,2,1,1,1,1,1
	.DB 4,3,2,1,1,1,1,1
	.DB 2,2,2,2,2,2,2,2

DATA_00DCEC:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $02,$04,$04,$04,$0E,$08,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$08,$08
	.DB $08,$08,$08,$08,$00,$00,$00,$00
	.DB $0C,$10,$12,$14,$16,$18,$1A,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$06,$00,$00
	.DB $00,$00,$00,$0A,$00,$00

DATA_00DD32:
	.DB $00,$08,$10,$14,$18,$1E,$24,$24
	.DB $28,$30,$38,$3E,$44,$4A,$50,$54
	.DB $58,$58,$5C,$60,$64,$68,$6C,$70
	.DB $74,$78,$7C,$80

DATA_00DD4E:
	.DW 0,0,16,16
	.DW 0,0,-8,-8
	.DW 14,6,-14,-6
	.DW 23,7,15,-22
	.DW -6,-6,0,0
	.DW 0,0,16,16
	.DW 0,0,-8,-8
	.DW 0,-8,8,0
	.DW 8,-8,0,0
	.DW -8,0,0,16
	.DW 2,0,-2,0
	.DW 0,0,-4,5
	.DW 4,-5,-5,6
	.DW 5,-6,-7,9
	.DW 7,-9,-3,-3
	.DW 3,3,-1,7
	.DW 1,-7,10,-10
	.DW 8,-8,8,-8
	.DW 0,4,-4,-2
	.DW 2,11,-11,20
	.DW -20,14,-13,8
	.DW -8,12,20,-3
	.DW -12,-12,11,11
	.DW 3,19,-11,5
	.DW -11,9,1,1
	.DW -9,7,7,5
	.DW 13,13,-5,-5
	.DW -5,-1,15,1
	.DW -7,0

DATA_00DE32:
	.DW 1,17,17,25
	.DW 1,17,17,25
	.DW 12,20,12,20
	.DW 24,24,40,24
	.DW 24,40,6,22
	.DW 1,17,9,17
	.DW 1,17,9,17
	.DW 1,17,17,1
	.DW 17,17,1,17
	.DW 17,1,17,17
	.DW 1,17,1,17
	.DW 17,5,4,20
	.DW 4,20,12,20
	.DW 12,20,16,16
	.DW 16,16,16,0
	.DW 16,0,16,0
	.DW 16,0,11,11
	.DW 17,17,-1,-1
	.DW 16,16,16,16
	.DW 16,16,16,21
	.DW 21,37,37,4
	.DW 4,4,20,20
	.DW 4,20,20,4
	.DW 4,20,4,4
	.DW 20,0,8,0
	.DW 0,8,0,0
	.DW 16,24,0,16
	.DW 24,0,16,0
	.DW 16,-8

TilesetIndex:	.DB $00,$46,$83,$46

TileExpansion:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$28,$00,$00,$00,$00
	.DB $00,$00,$04,$04,$04,$00,$00,$00
	.DB $00,$00,$08,$00,$00,$00,$00,$0C
	.DB $0C,$0C,$00,$00,$10,$10,$14,$14
	.DB $18,$18,$00,$00,$1C,$00,$00,$00
	.DB $00,$20,$00,$00,$00,$00,$24,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$04
	.DB $04,$04,$00,$00,$00,$00,$00,$08
	.DB $00,$00,$00,$00,$0C,$0C,$0C,$00
	.DB $00,$10,$10,$14,$14,$18,$18,$00
	.DB $00,$1C,$00,$00,$00,$00,$20,$00
	.DB $00,$00,$00,$24,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00

Mario8x8Tiles:
	.DB $00,$02,$80,$80,$00,$02,$0C,$80
	.DB $00,$02,$1A,$1B,$00,$02,$0D,$80
	.DB $00,$02,$22,$23,$00,$02,$32,$33
	.DB $00,$02,$0A,$0B,$00,$02,$30,$31
	.DB $00,$02,$20,$21,$00,$02,$7E,$80
	.DB $00,$02,$02,$80,$04,$7F,$4A,$5B
	.DB $4B,$5A

DATA_00E00C:
	.DB $50,$50,$50,$09,$50,$50,$50,$50
	.DB $50,$50,$09,$2B,$50,$2D,$50,$D5
	.DB $2E,$C4,$C4,$C4,$D6,$B6,$50,$50
	.DB $50,$50,$50,$50,$50,$C5,$D7,$2A
	.DB $E0,$50,$D5,$29,$2C,$B6,$D6,$28
	.DB $E0,$E0,$C5,$C5,$C5,$C5,$C5,$C5
	.DB $5C,$5C,$50,$5A,$B6,$50,$28,$28
	.DB $C5,$D7,$28,$70,$C5,$70,$1C,$93
	.DB $C5,$C5,$0B,$85,$90,$84,$70,$70
	.DB $70,$A0,$70,$70,$70,$70,$70,$70
	.DB $A0,$74,$70,$80,$70,$84,$17,$A4
	.DB $A4,$A4,$B3,$B0,$70,$70,$70,$70
	.DB $70,$70,$70,$E2,$72,$0F,$61,$70
	.DB $63,$82,$C7,$90,$B3,$D4,$A5,$C0
	.DB $08,$54,$0C,$0E,$1B,$51,$49,$4A
	.DB $48,$4B,$4C,$5D,$5E,$5F,$E3,$90
	.DB $5F,$5F,$C5,$70,$70,$70,$A0,$70
	.DB $70,$70,$70,$70,$70,$A0,$74,$70
	.DB $80,$70,$84,$17,$A4,$A4,$A4,$B3
	.DB $B0,$70,$70,$70,$70,$70,$70,$70
	.DB $E2,$72,$0F,$61,$70,$63,$82,$C7
	.DB $90,$B3,$D4,$A5,$C0,$08,$64,$0C
	.DB $0E,$1B,$51,$49,$4A,$48,$4B,$4C
	.DB $5D,$5E,$5F,$E3,$90,$5F,$5F,$C5

DATA_00E0CC:
	.DB $71,$60,$60,$19,$94,$96,$96,$A2
	.DB $97,$97,$18,$3B,$B4,$3D,$A7,$E5
	.DB $2F,$D3,$C3,$C3,$F6,$D0,$B1,$81
	.DB $B2,$86,$B4,$87,$A6,$D1,$F7,$3A
	.DB $F0,$F4,$F5,$39,$3C,$C6,$E6,$38
	.DB $F1,$F0,$C5,$C5,$C5,$C5,$C5,$C5
	.DB $6C,$4D,$71,$6A,$6B,$60,$38,$F1
	.DB $5B,$69,$F1,$F1,$4E,$E1,$1D,$A3
	.DB $C5,$C5,$1A,$95,$10,$07,$02,$01
	.DB $00,$02,$14,$13,$12,$30,$27,$26
	.DB $30,$03,$15,$04,$31,$07,$E7,$25
	.DB $24,$23,$62,$36,$33,$91,$34,$92
	.DB $35,$A1,$32,$F2,$73,$1F,$C0,$C1
	.DB $C2,$83,$D2,$10,$B7,$E4,$B5,$61
	.DB $0A,$55,$0D,$75,$77,$1E,$59,$59
	.DB $58,$02,$02,$6D,$6E,$6F,$F3,$68
	.DB $6F,$6F,$06,$02,$01,$00,$02,$14
	.DB $13,$12,$30,$27,$26,$30,$03,$15
	.DB $04,$31,$07,$E7,$25,$24,$23,$62
	.DB $36,$33,$91,$34,$92,$35,$A1,$32
	.DB $F2,$73,$1F,$C0,$C1,$C2,$83,$D2
	.DB $10,$B7,$E4,$B5,$61,$0A,$55,$0D
	.DB $75,$77,$1E,$59,$59,$58,$02,$02
	.DB $6D,$6E,$6F,$F3,$68,$6F,$6F,$06

MarioPalIndex:	.DB $00,$40

DATA_00E18E:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$0D,$00,$10
	.DB $13,$22,$25,$28,$00,$16,$00,$00
	.DB $00,$00,$00,$00,$00,$08,$19,$1C
	.DB $04,$1F,$10,$10,$00,$16,$10,$06
	.DB $04,$08,$2B,$30,$35,$3A,$3F,$43
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $16,$16,$00,$00,$08,$00,$00,$00
	.DB $00,$00,$00,$10,$04,$00

DATA_00E1D4:	.DB $06

DATA_00E1D5:	.DB $00

DATA_00E1D6:	.DB $06

DATA_00E1D7:	.DB $00

DATA_00E1D8:
	.DB $86,$02,$06,$03,$06,$01,$06,$CE
	.DB $06,$06,$40,$00,$06,$2C,$06,$06
	.DB $44,$0E,$86,$2C,$06,$86,$2C,$0A
	.DB $86,$84,$08,$06,$0A,$02,$06,$AC
	.DB $10,$06,$CC,$10,$06,$AE,$10,$00
	.DB $8C,$14,$80,$2E,$00,$CA,$16,$91
	.DB $2F,$00,$8E,$18,$81,$30,$00,$EB
	.DB $1A,$90,$31,$04,$ED,$1C,$82,$06
	.DB $92,$1E

DATA_00E21A:
	.DB $84,$86,$88,$8A,$8C,$8E,$90,$90
	.DB $92,$94,$96,$98,$9A,$9C,$9E,$A0
	.DB $A2,$A4,$A6,$A8,$AA,$B0,$B6,$BC
	.DB $C2,$C8,$CE,$D4,$DA,$DE,$E2,$E2

DATA_00E23A:
	.DB $0A,$0A,$84,$0A,$88,$88,$88,$88
	.DB $8A,$8A,$8A,$8A,$44,$44,$44,$44
	.DB $42,$42,$42,$42,$40,$40,$40,$40
	.DB $22,$22,$22,$22,$A4,$A4,$A4,$A4
	.DB $A6,$A6,$A6,$A6,$86,$86,$86,$86
	.DB $6E,$6E,$6E,$6E

DATA_00E266:
	.DB $02,$02,$02,$0C,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$04,$12,$04,$04
	.DB $04,$12,$04,$04,$04,$12,$04,$04
	.DB $04,$12,$04,$04

DATA_00E292:
	.DB 1,1,1,1,2,2,2,2
	.DB 4,4,4,4,8,8,8,8

DATA_00E2A2:
	.DW PALETTE_Mario
	.DW PALETTE_Luigi
	.DW PALETTE_Mario
	.DW PALETTE_Luigi
	.DW PALETTE_Mario
	.DW PALETTE_Luigi
	.DW PALETTE_MarioFire
	.DW PALETTE_LuigiFire

DATA_00E2B2:	.DB 16,-44,16,-24

DATA_00E2B6:	.DB $08,$CC,$08

DATA_00E2B9:	.DB -32,16,16,48

CODE_00E2BD:
	PHB
	PHK
	PLB
	LDA wm_HidePlayer
	CMP #$FF
	BEQ +
	JSL CODE_01EA70
+	LDY wm_FlashingPalTimer
	BNE ++
	LDY wm_StarPowerTimer
	BEQ CODE_00E314
	LDA wm_HidePlayer
	CMP #$FF
	BEQ +
	LDA wm_FrameB
	AND #$03
	BNE +
	DEC wm_StarPowerTimer
+	LDA wm_FrameA
	CPY #$1E
	BCC +++
	BNE _00E30C
	LDA wm_LevelMusicMod
	CMP #$FF
	BEQ ++
	AND #$7F
	STA wm_LevelMusicMod
	TAX
	LDA wm_BluePowTimer
	ORA wm_SilverPowTimer
	ORA wm_DirCoinTimer
	BEQ +
	LDX #$0E
+	STX wm_MusicCh1
++	LDA wm_FrameA
+++	LSR
	LSR
_00E30C:
	AND #$03
	INC A
	INC A
	INC A
	INC A
	BRA _00E31A

CODE_00E314:
	LDA wm_MarioPowerUp
	ASL
	ORA wm_OWCharA
_00E31A:
	ASL
	TAY
	REP #$20
	LDA DATA_00E2A2,Y
	STA wm_PlayerPalPtr
	SEP #$20
	LDX wm_MarioFrame
	LDA #$05
	CMP wm_WallWalkStatus
	BCS +++
	LDA wm_WallWalkStatus
	LDY wm_MarioPowerUp
	BEQ +
	CPX #$13
	BNE ++
+	EOR #$01
++	LSR
+++	REP #$20
	LDA wm_MarioXPos
	SBC wm_Bg1HOfs
	STA wm_MarioScrPosX
	LDA wm_PlayerImgYPos
	AND #$00FF
	CLC
	ADC wm_MarioYPos
	LDY wm_MarioPowerUp
	CPY #$01
	LDY #$01
	BCS +
	DEC A
	DEY
+	CPX #$0A
	BCS +
	CPY wm_PlayerWalkPose
+	SBC wm_Bg1VOfs
	CPX #$1C
	BNE +
	ADC #$0001
+	STA wm_MarioScrPosY
	SEP #$20
	LDA wm_PlayerHurtTimer
	BEQ CODE_00E385
	LSR
	LSR
	LSR
	TAY
	LDA DATA_00E292,Y
	AND wm_PlayerHurtTimer
	ORA wm_SpritesLocked
	ORA wm_IsFrozen
	BNE CODE_00E385
	PLB
	RTL

CODE_00E385:
	LDA #$C8
	CPX #$43
	BNE +
	LDA #$E8
+	STA m4
	CPX #$29
	BNE +
	LDA wm_MarioPowerUp
	BNE +
	LDX #$20
+	LDA.W DATA_00DCEC,X
	ORA wm_MarioDirection
	TAY
	LDA DATA_00DD32,Y
	STA m5
	LDY wm_MarioPowerUp
	LDA wm_MarioFrame
	CMP #$3D
	BCS +
	ADC TilesetIndex,Y
+	TAY
	LDA TileExpansion,Y
	STA m6
	LDA DATA_00E00C,Y
	STA m10
	LDA DATA_00E0CC,Y
	STA m11
	LDA wm_SpriteProp
	LDX wm_IsBehindScenery
	BEQ +
	LDA.W DATA_00E2B9,X
+	LDY.W DATA_00E2B2,X
	LDX wm_MarioDirection
	ORA.W MarioPalIndex,X
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	STA wm_OamSlot.4.Prop,Y
	STA wm_OamSlot.5.Prop,Y
	STA wm_ExOamSlot.63.Prop,Y
	STA wm_ExOamSlot.64.Prop,Y
	LDX m4
	CPX #$E8
	BNE +
	EOR #$40
+	STA wm_OamSlot.3.Prop,Y
	JSR CODE_00E45D
	JSR CODE_00E45D
	JSR CODE_00E45D
	JSR CODE_00E45D
	LDA wm_MarioPowerUp
	CMP #$02
	BNE _00E458
	PHY
	LDA #$2C
	STA m6
	LDX wm_MarioFrame
	LDA.W DATA_00E18E,X
	TAX
	LDA.W DATA_00E1D7,X
	STA m13
	LDA.W DATA_00E1D8,X
	STA m14
	LDA.W DATA_00E1D5,X
	STA m12
	CMP #$04
	BCS CODE_00E432
	LDA wm_CapeImage
	ASL
	ASL
	ORA m12
	TAY
	LDA DATA_00E23A,Y
	STA m12
	LDA DATA_00E266,Y
	BRA _00E435

CODE_00E432:
	LDA.W DATA_00E1D6,X
_00E435:
	ORA wm_MarioDirection
	TAY
	LDA DATA_00E21A,Y
	STA m5
	PLY
	LDA.W DATA_00E1D4,X
	TSB wm_HidePlayer
	BMI +
	JSR CODE_00E45D
+	LDX wm_IsBehindScenery
	LDY.W DATA_00E2B6,X
	JSR CODE_00E45D
	LDA m14
	STA m6
	JSR CODE_00E45D
_00E458:
	JSR CODE_00F636
	PLB
	RTL

CODE_00E45D:
	LSR wm_HidePlayer
	BCS +
	LDX m6
	LDA.W Mario8x8Tiles,X
	BMI +
	STA wm_OamSlot.1.Tile,Y
	LDX m5
	REP #$20
	LDA wm_MarioScrPosY
	CLC
	ADC.W DATA_00DE32,X
	PHA
	CLC
	ADC #$0010
	CMP #$0100
	PLA
	SEP #$20
	BCS +
	STA wm_OamSlot.1.YPos,Y
	REP #$20
	LDA wm_MarioScrPosX
	CLC
	ADC.W DATA_00DD4E,X
	PHA
	CLC
	ADC #$0080
	CMP #$0200
	PLA
	SEP #$20
	BCS +
	STA wm_OamSlot.1.XPos,Y
	XBA
	LSR
+	PHP
	TYA
	LSR
	LSR
	TAX
	ASL m4
	ROL
	PLP
	ROL
	AND #$03
	STA wm_OamSize.1,X
	INY
	INY
	INY
	INY
	INC m5
	INC m5
	INC m6
	RTS

DATA_00E4B9:
	.DB 8,8,8,8,16,16,16,16
	.DB 24,24,32,32,40,48,8,16
	.DB 0,0,40,0,0,0,0,0
	.DB 56,80,72,64,88,88,96,96
	.DB 0

DATA_00E4DA:
	.DB 16,16,16,16,16,16,16,16
	.DB 32,32,32,32,48,48,64,48
	.DB 48,48,48,0,0,0,0,0
	.DB 48,48,48,48,64,64,64,64
	.DB 0

DATA_00E4FB:
	.DB 0,0,0,0,0,0,0,0
	.DB -20,-20,-18,-18,-38,-38,0,0
	.DB 0,0,0,0,0,0,0,0
	.DB -38,-38,-38,-38,0,0,0,0
	.DB 0

DATA_00E51C:
	.DB 8,8,8,8,8,8,8,8
	.DB 9,9,9,9,11,11,11,11
	.DB 11,11,11,0,0,0,0,0
	.DB 11,11,11,11,20,20,20,20
	.DB 6

DATA_00E53D:
	.DB -1,-1,-1,-1,1,1,1,1
	.DB -2,-2,2,2,-3,3,-3,3
	.DB -3,3,-3,0,0,0,0,0
	.DB 8,8,-8,-8,-4,-4,4,4
	.DB 0

DATA_00E55E:
	.DB $00,$00,$00,$00,$00,$01,$01,$01
	.DB $01,$01,$02,$02,$02,$02,$02,$03
	.DB $03,$03,$03,$03,$04,$04,$04,$04
	.DB $04,$05,$05,$05,$05,$05,$06,$06
	.DB $06,$06,$06,$07,$07,$07,$07,$07
	.DB $08,$08,$08,$08,$08,$09,$09,$09
	.DB $09,$09,$0A,$0A,$0A,$0A,$0A,$0B
	.DB $0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C
	.DB $0C,$0D,$0D,$0D,$0D,$0D,$0E,$0F
	.DB $10,$11,$03,$03,$04,$04,$09,$09
	.DB $0A,$0A,$0C,$0C,$0D,$0D,$12,$13
	.DB $14,$15,$16,$17,$1C,$1D,$1E,$1F
	.DB $18,$19,$1A,$1B,$08,$09,$0A,$0B
	.DB $0C,$0D

DATA_00E5C8:
	.DB $00,$00,$00,$00,$00,$01,$01,$01
	.DB $01,$01,$02,$02,$02,$02,$02,$03
	.DB $03,$03,$03,$03,$04,$04,$04,$04
	.DB $04,$05,$05,$05,$05,$05,$06,$06
	.DB $06,$06,$06,$07,$07,$07,$07,$07
	.DB $08,$08,$08,$08,$08,$09,$09,$09
	.DB $09,$09,$0A,$0A,$0A,$0A,$0A,$0B
	.DB $0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C
	.DB $0C,$0D,$0D,$0D,$0D,$0D,$0E,$0F
	.DB $10,$11,$03,$03,$04,$04,$09,$09
	.DB $0A,$0A,$0C,$0C,$0D,$0D,$0C,$0D
	.DB $0D,$0C,$16,$17,$1C,$1D,$1E,$1F
	.DB $18,$19,$1A,$1B,$08,$09,$0A,$0B
	.DB $0C,$0D

DATA_00E632:
	.DB $0F,$0F,$0F,$0F,$0E,$0E,$0E,$0E
	.DB $0D,$0D,$0D,$0D,$0C,$0C,$0C,$0C
	.DB $0B,$0B,$0B,$0B,$0A,$0A,$0A,$0A
	.DB $09,$09,$09,$09,$08,$08,$08,$08
	.DB $07,$07,$07,$07,$06,$06,$06,$06
	.DB $05,$05,$05,$05,$04,$04,$04,$04
	.DB $03,$03,$03,$03,$02,$02,$02,$02
	.DB $01,$01,$01,$01,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$01,$01,$01,$01
	.DB $02,$02,$02,$02,$03,$03,$03,$03
	.DB $04,$04,$04,$04,$05,$05,$05,$05
	.DB $06,$06,$06,$06,$07,$07,$07,$07
	.DB $08,$08,$08,$08,$09,$09,$09,$09
	.DB $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B
	.DB $0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D
	.DB $0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F
	.DB $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C
	.DB $0B,$0B,$0A,$0A,$09,$09,$08,$08
	.DB $07,$07,$06,$06,$05,$05,$04,$04
	.DB $03,$03,$02,$02,$01,$01,$00,$00
	.DB $00,$00,$01,$01,$02,$02,$03,$03
	.DB $04,$04,$05,$05,$06,$06,$07,$07
	.DB $08,$08,$09,$09,$0A,$0A,$0B,$0B
	.DB $0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F
	.DB $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	.DB $07,$06,$05,$04,$03,$02,$01,$00
	.DB $00,$01,$02,$03,$04,$05,$06,$07
	.DB $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	.DB $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	.DB $07,$06,$05,$04,$03,$02,$01,$00
	.DB $00,$01,$02,$03,$04,$05,$06,$07
	.DB $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	.DB $08,$06,$04,$03,$02,$02,$01,$01
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $01,$01,$02,$02,$03,$04,$06,$08
	.DB $FF,$FE,$FD,$FC,$FB,$FA,$F9,$F8
	.DB $F7,$F6,$F5,$F4,$F3,$F2,$F1,$F0
	.DB $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7
	.DB $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF
	.DB $FF,$FF,$FE,$FE,$FD,$FD,$FC,$FC
	.DB $FB,$FB,$FA,$FA,$F9,$F9,$F8,$F8
	.DB $F7,$F7,$F6,$F6,$F5,$F5,$F4,$F4
	.DB $F3,$F3,$F2,$F2,$F1,$F1,$F0,$F0
	.DB $F0,$F0,$F1,$F1,$F2,$F2,$F3,$F3
	.DB $F4,$F4,$F5,$F5,$F6,$F6,$F7,$F7
	.DB $F8,$F8,$F9,$F9,$FA,$FA,$FB,$FB
	.DB $FC,$FC,$FD,$FD,$FE,$FE,$FF,$FF
	.DB $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	.DB $07,$06,$05,$04,$03,$02,$01,$00
	.DB $00,$01,$02,$03,$04,$05,$06,$07
	.DB $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	.DB $00,$01,$02,$03,$04,$05,$06,$07
	.DB $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	.DB $0F,$0E,$0D,$0C,$0B,$0A,$09,$08
	.DB $07,$06,$05,$04,$03,$02,$01,$00
	.DB $10,$10,$10,$10,$10,$10,$10,$10
	.DB $0E,$0C,$0A,$08,$06,$04,$02,$00
	.DB $0E,$0C,$0A,$08,$06,$04,$02,$00
	.DB $FE,$FC,$FA,$F8,$F6,$F4,$F2,$F0
	.DB $00,$02,$04,$06,$08,$0A,$0C,$0E
	.DB $10,$10,$10,$10,$10,$10,$10,$10
	.DB $F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE
	.DB $00,$02,$04,$06,$08,$0A,$0C,$0E

DATA_00E832:
	.DW 8,14,14,8
	.DW 5,11,8,2
	.DW 2,8,11,5
	.DW 8,14,14,8
	.DW 5,11,8,2
	.DW 2,8,11,5
	.DW 8,14,14,8
	.DW 5,11,8,2
	.DW 2,8,11,5
	.DW 8,14,14,8
	.DW 5,11,8,2
	.DW 2,8,11,5
	.DW 16,32,7,0
	.DW -16

DATA_00E89C:
	.DW $08,$18,$1A,$16
	.DW $10,$20,$20,$18
	.DW $1A,$16,$10,$20
	.DW $20,$12,$1A,$0F
	.DW $08,$20,$20,$12
	.DW $1A,$0F,$08,$20
	.DW $20,$1D,$28,$19
	.DW $13,$30,$30,$1D
	.DW $28,$19,$13,$30
	.DW $30,$1A,$28,$16
	.DW $10,$30,$30,$1A
	.DW $28,$16,$10,$30
	.DW $30,$18,$18,$18
	.DW $18,$18,$18

DATA_00E90A:	.DB $01,$02,$11

DATA_00E90D:	.DB -1,-1,1,0

DATA_00E911:	.DB $02,$0D

DATA_00E913:	.DW 1,-1,1,1,-1,-1

DATA_00E91F:	.DW 0,0,-1,1,-1,1

CODE_00E92B:
	JSR CODE_00EAA6
	LDA wm_FallThroughFlag
	BEQ CODE_00E938
	JSR _00EE1D
	BRA _00E98C

CODE_00E938:
	LDA wm_IsOnGround
	STA wm_8D
	STZ wm_IsOnGround
	LDA wm_IsFlying
	STA wm_8F
	LDA wm_IsVerticalLvl
	BPL +
	AND #$82
	STA wm_8E
	LDA #$01
	STA wm_LayerInProcess
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC wm_26
	STA wm_MarioXPos
	LDA wm_MarioYPos
	CLC
	ADC wm_28
	STA wm_MarioYPos
	SEP #$20
	JSR CODE_00EADB
	REP #$20
	LDA wm_MarioXPos
	SEC
	SBC wm_26
	STA wm_MarioXPos
	LDA wm_MarioYPos
	SEC
	SBC wm_28
	STA wm_MarioYPos
	SEP #$20
+	ASL wm_IsOnGround
	LDA wm_IsVerticalLvl
	AND #$41
	STA wm_8E
	ASL
	BMI _00E98C
	STZ wm_LayerInProcess
	ASL wm_8D
	JSR CODE_00EADB
_00E98C:
	LDA wm_SideExitFlag
	BEQ CODE_00E9A1
	REP #$20
	LDA wm_MarioScrPosX
	CMP #$00FA
	SEP #$20
	BCC _00E9FB
	JSL _SubSideExit
	RTS

CODE_00E9A1:
	LDA wm_MarioScrPosX
	CMP #$F0
	BCS ++
	LDA wm_MarioObjStatus
	AND #$03
	BNE _00E9FB
	REP #$20
	LDY #$00
	LDA wm_L1NextPosX
	CLC
	ADC #$00E8
	CMP wm_MarioXPos
	BEQ _00E9C8
	BMI _00E9C8
	INY
	LDA wm_MarioXPos
	SEC
	SBC #$0008
	CMP wm_L1NextPosX
_00E9C8:
	SEP #$20
	BEQ _00E9FB
	BPL _00E9FB
	LDA wm_HorzScrollHead
	BNE +
	LDA #$80
	TSB wm_MarioObjStatus
	REP #$20
	LDA wm_ScrollSpeedL1X
	LSR
	LSR
	LSR
	LSR
	SEP #$20
	STA m0
	SEC
	SBC wm_MarioSpeedX
	EOR DATA_00E90D+1,Y
	BMI +
	LDA m0
	STA wm_MarioSpeedX
	LDA wm_SprScrollL1X
	STA wm_PlayerXAccFixed
+	LDA DATA_00E90A,Y
	TSB wm_MarioObjStatus
_00E9FB:
	LDA wm_MarioObjStatus
	AND #$1C
	CMP #$1C
	BNE CODE_00EA0D
	LDA wm_IsOnSolidSpr
	BNE CODE_00EA0D
++	JSR CODE_00F629
	BRA _00EA32

CODE_00EA0D:
	LDA wm_MarioObjStatus
	AND #$03
	BEQ +
	AND #$02
	TAY
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC DATA_00E90D,Y
	STA wm_MarioXPos
	SEP #$20
	LDA wm_MarioObjStatus
	BMI +
	LDA #$03
	STA wm_PlayerFrameIndex
	LDA wm_MarioSpeedX
	EOR DATA_00E90D,Y
	BPL +
_00EA32:
	STZ wm_MarioSpeedX
+	LDA wm_IsBehindScenery
	CMP #$01
	BNE +
	LDA wm_8B
	BNE +
	STZ wm_IsBehindScenery
+	STZ wm_IsOnWaterTop
	LDA wm_IsWaterLevel
	BNE _00EA5E
	LSR wm_8A
	BCC _00EAA3
	LDA wm_IsSwimming
	BNE CODE_00EA65
	LDA wm_MarioSpeedY
	BMI CODE_00EA65
	LSR wm_8A
	BCC _Return00EAA5
	JSR CODE_00FDA5
	STZ wm_MarioSpeedY
_00EA5E:
	LDA #$01
	STA wm_IsSwimming
_00EA62:
	JMP CODE_00FD08

CODE_00EA65:
	LSR wm_8A
	BCS _00EA5E
	LDA wm_IsSwimming
	BEQ _Return00EAA5
	LDA #$FC
	CMP wm_MarioSpeedY
	BMI +
	STA wm_MarioSpeedY
+	INC wm_IsOnWaterTop
	LDA wm_JoyPadA
	AND #$88
	CMP #$88
	BNE _00EA62
	LDA wm_JoyPadB
	BPL +
	LDA wm_IsCarrying2
	BNE +
	INC A
	STA wm_IsSpinJump
	LDA #$04
	STA wm_SoundCh3
+	LDA wm_MarioObjStatus
	AND #$08
	BNE _00EA62
	JSR CODE_00FDA5
	LDA #$0B
	STA wm_IsFlying
	LDA #$AA
	STA wm_MarioSpeedY
_00EAA3:
	STZ wm_IsSwimming
_Return00EAA5:
	RTS

CODE_00EAA6:
	STZ wm_PlayerFrameIndex
	STZ wm_MarioObjStatus
	STZ wm_OnSlopeTypeB
	STZ wm_OnSlopeTypeA
	STZ wm_8A
	STZ wm_8B
	STZ wm_IsTouchLayer2
	RTS

DATA_00EAB9:	.DB -34,35

DATA_00EABB:	.DB 32,-32

DATA_00EABD:	.DB 8,0,-8,-1

DATA_00EAC1:
	.DB $71,$72,$76,$77,$7B,$7C,$81,$86
	.DB $8A,$8B,$8F,$90,$94,$95,$99,$9A
	.DB $9E,$9F,$A3,$A4,$A8,$A9,$AD,$AE
	.DB $B2,$B3

CODE_00EADB:
	LDA wm_MarioYPos
	AND #$0F
	STA wm_PlayerBlkPosY
	LDA wm_WallWalkStatus
	BNE CODE_00EAE9
	JMP CODE_00EB77

CODE_00EAE9:
	AND #$01
	TAY
	LDA wm_MarioSpeedX
	SEC
	SBC DATA_00EAB9,Y
	EOR DATA_00EAB9,Y
	BMI _00EB48
	LDA wm_IsFlying
	ORA wm_IsCarrying2
	ORA wm_IsDucking
	ORA wm_OnYoshi
	BNE _00EB48
	LDA wm_WallWalkStatus
	CMP #$06
	BCS CODE_00EB22
	LDX wm_PlayerBlkPosY
	CPX #$08
	BCC _Return00EB76
	CMP #$04
	BCS _00EB73
	ORA #$04
	STA wm_WallWalkStatus
_00EB19:
	LDA wm_MarioXPos
	AND #$F0
	ORA #$08
	STA wm_MarioXPos
	RTS

CODE_00EB22:
	LDX #$60
	TYA
	BEQ +
	LDX #$66
+	JSR CODE_00EFE8
	LDA wm_MarioPowerUp
	BNE CODE_00EB34
	INX
	INX
	BRA _00EB37

CODE_00EB34:
	JSR CODE_00EFE8
_00EB37:
	JSR CODE_00F44D
	BNE _00EB19
	LDA #$02
	TRB wm_WallWalkStatus
	RTS

ADDR_00EB42:
	LDA wm_WallWalkStatus
	AND #$01
	TAY
_00EB48:
	LDA DATA_00EABB,Y
	STA wm_MarioSpeedX
	TYA
	ASL
	TAY
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC DATA_00EABD,Y
	STA wm_MarioXPos
	LDA #$0008
	LDY wm_MarioPowerUp
	BEQ +
	LDA #$0010
+	CLC
	ADC wm_MarioYPos
	STA wm_MarioYPos
	SEP #$20
	LDA #$24
	STA wm_IsFlying
	LDA #$E0
	STA wm_MarioSpeedY
_00EB73:
	STZ wm_WallWalkStatus
_Return00EB76:
	RTS

CODE_00EB77:
	LDX #$00
	LDA wm_MarioPowerUp
	BEQ +
	LDA wm_IsDucking
	BNE +
	LDX #$18
+	LDA wm_OnYoshi
	BEQ +
	TXA
	CLC
	ADC #$30
	TAX
+	LDA wm_MarioXPos
	AND #$0F
	TAY
	CLC
	ADC #$08
	AND #$0F
	STA wm_PlayerBlkPosX
	STZ wm_PlayerBlkSide
	CPY #$08
	BCC +
	TXA
	ADC #$0B
	TAX
	INC wm_PlayerBlkSide
+	LDA wm_PlayerBlkPosY
	CLC
	ADC.W DATA_00E89C+8,X
	AND #$0F
	STA wm_PlayerExitBlkPos
	JSR CODE_00F44D
	BEQ CODE_00EBDD
	CPY #$11
	BCC _00EC24
	CPY #$6E
	BCC CODE_00EBC9
	TYA
	JSL CODE_00F04D
	BCC _00EC24
	LDA #$01
	TSB wm_8A
	BRA _00EC24

CODE_00EBC9:
	INX
	INX
	INX
	INX
	TYA
	LDY #$00
	CMP #$1E
	BEQ +
	CMP #$52
	BEQ +
	LDY #$02
+	JMP _00EC6F

CODE_00EBDD:
	CPY #$9C
	BNE +
	LDA wm_LvHeadTileset
	CMP #$01
	BEQ +++
+	CPY #$20
	BEQ ++
	CPY #$1F
	BEQ +
	LDA wm_BluePowTimer
	BEQ CODE_00EC21
	CPY #$28
	BEQ ++
	CPY #$27
	BNE CODE_00EC21
+	LDA wm_MarioPowerUp
	BNE _00EC24
++	JSR CODE_00F443
	BCS _00EC24
+++	LDA wm_8F
	BNE _00EC24
	LDA wm_JoyFrameA
	AND #$08
	BEQ _00EC24
	LDA #$0F
	STA wm_SoundCh3
	JSR CODE_00D273
	LDA #$0D
	STA wm_MarioAnimation
	JSR _NoButtons
	BRA _00EC24

CODE_00EC21:
	JSR CODE_00F28C
_00EC24:
	JSR CODE_00F44D
	BEQ CODE_00EC35
	CPY #$11
	BCC _00EC3A
	CPY #$6E
	BCS _00EC3A
	INX
	INX
	BRA _00EC4E

CODE_00EC35:
	LDA #$10
	JSR CODE_00F2C9
_00EC3A:
	JSR CODE_00F44D
	BNE CODE_00EC46
	LDA #$08
	JSR CODE_00F2C9
	BRA _00EC8A

CODE_00EC46:
	CPY #$11
	BCC _00EC8A
	CPY #$6E
	BCS _00EC8A
_00EC4E:
	LDA wm_MarioDirection
	CMP wm_PlayerBlkSide
	BEQ +
	JSR CODE_00F3C4
	PHX
	JSR CODE_00F267
	LDY wm_Map16NumLo
	PLX
+	LDA #$03
	STA wm_PlayerFrameIndex
	LDY wm_PlayerBlkSide
	LDA wm_MarioXPos
	AND #$0F
	CMP DATA_00E911,Y
	BEQ _00EC8A
_00EC6F:
	LDA wm_NoteBlkBounceFlag
	BEQ +
	LDA wm_Map16NumLo
	CMP #$52
	BEQ _00EC8A
+	LDA DATA_00E90A,Y
	TSB wm_MarioObjStatus
	AND #$03
	TAY
	LDA wm_Map16NumLo
	JSL _00F127
_00EC8A:
	JSR CODE_00F44D
	BNE CODE_00ECB1
	LDA #$02
	JSR _00F2C2
	LDY wm_MarioSpeedY
	BPL _00ECA3
	LDA wm_Map16NumLo
	CMP #$21
	BCC _00ECA3
	CMP #$25
	BCC CODE_00ECA6
_00ECA3:
	JMP _00ED4A

CODE_00ECA6:
	SEC
	SBC #$04
	LDY #$00
	JSL _00F17F
	BRA _00ED0D

CODE_00ECB1:
	CPY #$11
	BCC _00ECA3
	CPY #$6E
	BCC CODE_00ECFA
	CPY #$D8
	BCC +
	REP #$20
	LDA wm_BlockXPos
	CLC
	ADC #$0010
	STA wm_BlockXPos
	JSR _00F461
	BEQ ++
	CPY #$6E
	BCC _00ED4A
	CPY #$D8
	BCS _00ED4A
	LDA wm_PlayerExitBlkPos
	SBC.B #$0F
	STA wm_PlayerExitBlkPos
+	TYA
	SEC
	SBC.B #$6E
	TAY
	REP #$20
	LDA [wm_SlopeSteepness],Y
	AND #$00FF
	ASL
	ASL
	ASL
	ASL
	SEP #$20
	ORA wm_PlayerBlkPosX
	REP #$10
	TAY
	LDA DATA_00E632,Y
	SEP #$10
	BMI _00ED0F
++	BRA _00ED4A

CODE_00ECFA:
	LDA #$02
	JSR CODE_00F3E9
	TYA
	LDY #$00
	JSL _00F127
	LDA wm_Map16NumLo
	CMP #$1E
	BEQ _00ED3B
_00ED0D:
	LDA #$F0
_00ED0F:
	CLC
	ADC wm_PlayerExitBlkPos
	BPL _00ED4A
	CMP #$F9
	BCS CODE_00ED28
	LDY wm_IsFlying
	BNE CODE_00ED28
	LDA wm_MarioObjStatus
	AND #$FC
	ORA #$09
	STA wm_MarioObjStatus
	STZ wm_MarioSpeedX
	BRA _00ED3B

CODE_00ED28:
	LDY wm_IsFlying
	BEQ +
	EOR #$FF
	CLC
	ADC wm_MarioYPos
	STA wm_MarioYPos
	BCC +
	INC wm_MarioYPos+1
+	LDA #$08
	TSB wm_MarioObjStatus
_00ED3B:
	LDA wm_MarioSpeedY
	BPL _00ED4A
	STZ wm_MarioSpeedY
	LDA wm_SoundCh1
	BNE _00ED4A
	INC A
	STA wm_SoundCh1
_00ED4A:
	JSR CODE_00F44D
	BNE CODE_00ED52
	JMP CODE_00EDDB

CODE_00ED52:
	CPY #$6E
	BCS CODE_00ED5E
	LDA #$03
	JSR CODE_00F3E9
	JMP _00EDF7

CODE_00ED5E:
	CPY #$D8
	BCC _00ED86
	CPY #$FB
	BCC CODE_00ED69
	JMP CODE_00F629

CODE_00ED69:
	REP #$20
	LDA wm_BlockXPos
	SEC
	SBC #$0010
	STA wm_BlockXPos
	JSR _00F461
	BEQ _00EDE9
	CPY #$6E
	BCC _00EDE9
	CPY #$D8
	BCS _00EDE9
	LDA wm_PlayerBlkPosY
	ADC.B #$10
	STA wm_PlayerBlkPosY
_00ED86:
	LDA wm_LvHeadTileset
	CMP.B #$03
	BEQ +
	CMP.B #$0E
	BNE ++
+	CPY #$D2
	BCS _00EDE9
++	TYA
	SEC
	SBC.B #$6E
	TAY
	LDA [wm_SlopeSteepness],Y
	PHA
	REP #$20
	AND #$00FF
	ASL
	ASL
	ASL
	ASL
	SEP #$20
	ORA wm_PlayerBlkPosX
	PHX
	REP #$10
	TAX
	LDA wm_PlayerBlkPosY
	SEC
	SBC.W DATA_00E632,X
	BPL +
	INC wm_IsOnGround
+	SEP #$10
	PLX
	PLY
	CMP DATA_00E51C,Y
	BCS _00EDE9
	STA wm_PlayerExitBlkPos
	STZ wm_PlayerBlkPosY
	JSR CODE_00F005
	CPY #$1C
	BCC CODE_00EDD5
	LDA #$08
	STA wm_SlideImgTimer
	JMP _00EED1

CODE_00EDD5:
	JSR CODE_00EFBC
	JMP _00EE85

CODE_00EDDB:
	CPY #$05
	BNE CODE_00EDE4
	JSR CODE_00F629
	BRA _00EDE9

CODE_00EDE4:
	LDA #$04
	JSR _00F2C2
_00EDE9:
	JSR CODE_00F44D
	BNE CODE_00EDF3
	JSR CODE_00F309
	BRA _00EE1D

CODE_00EDF3:
	CPY #$6E
	BCS _00EE1D
_00EDF7:
	LDA wm_MarioSpeedY
	BMI _Return00EE39
	LDA wm_LvHeadTileset
	CMP #$03
	BEQ +
	CMP #$0E
	BNE ++
+	LDY wm_Map16NumLo
	CPY #$59
	BCC ++
	CPY #$5C
	BCC _00EE1D
++	LDA wm_PlayerBlkPosY
	AND #$0F
	STZ wm_PlayerBlkPosY
	CMP #$08
	STA wm_PlayerExitBlkPos
	BCC CODE_00EE3A
_00EE1D:
	LDA wm_IsOnSolidSpr
	BEQ CODE_00EE2D
	LDA wm_MarioSpeedY
	BMI CODE_00EE2D
	STZ wm_8E
	LDY #$20
	JMP _00EEE1

CODE_00EE2D:
	LDA wm_MarioObjStatus
	AND #$04
	ORA wm_IsFlying
	BNE _Return00EE39
_00EE35:
	LDA #$24
	STA wm_IsFlying
_Return00EE39:
	RTS

CODE_00EE3A:
	LDY wm_Map16NumLo
	LDA wm_LvHeadTileset
	CMP #$02
	BEQ +
	CMP #$08
	BNE CODE_00EE57
+	TYA
	SEC
	SBC #$0C
	CMP #$02
	BCS CODE_00EE57
	ASL
	TAX
	JSR _00EFCD
	BRA _00EE83

CODE_00EE57:
	JSR CODE_00F267
	LDY #$03
	LDA wm_Map16NumLo
	CMP #$1E
	BNE CODE_00EE78
	LDX wm_8F
	BEQ _00EE83
	LDX wm_MarioPowerUp
	BEQ _00EE83
	LDX wm_IsSpinJump
	BEQ _00EE83
	LDA #$21
	JSL _00F17F
	BRA _00EE1D

CODE_00EE78:
	CMP #$32
	BNE +
	STZ wm_RunEaterBlock
+	JSL CODE_00F120
_00EE83:
	LDY #$20
_00EE85:
	LDA wm_MarioSpeedY
	BPL +
	LDA wm_8D
	CMP #$02
	BCC _Return00EE39
+	LDX wm_WhichSwitchPressed
	BEQ _00EED1
	DEX
	TXA
	AND #$03
	BEQ +
	CMP #$02
	BCS _00EED1
	REP #$20
	LDA wm_BlockYPos
	SEC
	SBC #$0010
	STA wm_BlockYPos
	SEP #$20
+	TXA
	LSR
	LSR
	TAX
	LDA wm_MapData.SwitchBlkFlags,X
	BNE _00EED1
	INC A
	STA wm_MapData.SwitchBlkFlags,X
	STA wm_SwitchPalaceCol
	PHY
	STX wm_FlatSwitchType
	JSR FlatPalaceSwitch
	PLY
	LDA #$0C
	STA wm_MusicCh1
	LDA #$FF
	STA wm_LevelMusicMod
	LDA #$08
	STA wm_EndLevelTimer
_00EED1:
	INC wm_IsOnGround
	LDA wm_MarioYPos
	SEC
	SBC wm_PlayerExitBlkPos
	STA wm_MarioYPos
	LDA wm_MarioYPos+1
	SBC wm_PlayerBlkPosY
	STA wm_MarioYPos+1
_00EEE1:
	LDA DATA_00E53D,Y
	BNE +
	LDX wm_PlayerSlopePose
	BEQ +++
	LDX wm_MarioSpeedX
	BEQ ++
+	STA wm_OnSlopeTypeA
	LDA wm_JoyPadA
	AND #$04
	BEQ +++
	LDA wm_IsCarrying2
	ORA wm_PlayerSlopePose
	BNE +++
	LDX #$1C
++	STX wm_PlayerSlopePose
+++	LDX.W DATA_00E4B9,Y
	STX wm_OnSlopeTypeB
	CPY #$1C
	BCS _00EF38
	LDA wm_MarioSpeedX
	BEQ _00EF31
	LDA DATA_00E53D,Y
	BEQ _00EF31
	EOR wm_MarioSpeedX
	BPL _00EF31
	STX wm_PlayerFrameIndex
	LDA wm_MarioSpeedX
	BPL +
	EOR #$FF
	INC A
+	CMP #$28
	BCC CODE_00EF2F
	LDA DATA_00E4FB,Y
	BRA _00EF60

CODE_00EF2F:
	LDY #$20
_00EF31:
	LDA wm_MarioSpeedY
	CMP DATA_00E4DA,Y
	BCC +
_00EF38:
	LDA DATA_00E4DA,Y
+	LDX wm_8E
	BPL _00EF60
	INC wm_IsTouchLayer2
	PHA
	REP #$20
	LDA wm_L2CurYChange
	AND #$FF00
	BPL +
	ORA #$00FF
+	XBA
	EOR #$FFFF
	INC A
	CLC
	ADC wm_MarioXPos
	STA wm_MarioXPos
	SEP #$20
	PLA
	CLC
	ADC #$28
_00EF60:
	STA wm_MarioSpeedY
	TAX
	BPL +
	INC wm_IsOnGround
+	STZ wm_FollowCage
	STZ wm_IsFlying
	STZ wm_IsClimbing
	STZ wm_BouncingWithYoshi
	STZ wm_IsSpinJump
	LDA #$04
	TSB wm_MarioObjStatus
	LDY wm_CapeGlidePhase
	BNE CODE_00EF99
	LDA wm_OnYoshi
	BEQ +
	LDA wm_8F
	BEQ +
	LDA wm_YoshiHasStomp
	BEQ +
	JSL YoshiStompRoutine
	LDA #$25
	STA wm_SoundCh3
+	STZ wm_SprChainStomped
	RTS

CODE_00EF99:
	STZ wm_SprChainStomped
	STZ wm_CapeGlidePhase
	CPY #$05
	BCS CallGroundPound
	LDA wm_MarioPowerUp
	CMP #$02
	BNE +
	SEC
	ROR wm_PlayerSlopePose
+	RTS

CallGroundPound:
	LDA wm_8F
	BEQ +
	JSL GroundPound
	LDA #$09
	STA wm_SoundCh3
+	RTS

CODE_00EFBC:
	LDX wm_Map16NumLo
	CPX #$CE
	BCC +
	CPX #$D2
	BCS +
	TXA
	SEC
	SBC #$CC
	ASL
	TAX
_00EFCD:
	LDA wm_FrameA
	AND #$03
	BNE +
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC.W DATA_00E913,X
	STA wm_MarioXPos
	LDA wm_MarioYPos
	CLC
	ADC.W DATA_00E91F,X
	STA wm_MarioYPos
	SEP #$20
+	RTS

CODE_00EFE8:
	JSR CODE_00F44D
	BNE ADDR_00EFF0
	JMP CODE_00F309

ADDR_00EFF0:
	CPY #$11
	BCC Return00F004
	CPY #$6E
	BCS Return00F004
	TYA
	LDY #$00
	JSL _00F160
	PLA
	PLA
	JMP ADDR_00EB42

Return00F004:
	RTS

CODE_00F005:
	TYA
	SEC
	SBC #$0E
	CMP #$02
	BCS _Return00F04C
	EOR #$01
	CMP wm_MarioDirection
	BNE _Return00F04C
	TAX
	LSR
	LDA wm_PlayerBlkPosX
	BCC +
	EOR #$0F
+	CMP #$08
	BCS _Return00F04C
	LDA wm_OnYoshi
	BEQ CODE_00F035
	LDA #$08
	STA wm_SoundCh3
	LDA #$80
	STA wm_MarioSpeedY
	STA wm_BouncingWithYoshi
	PLA
	PLA
	JMP _00EE35

CODE_00F035:
	LDA wm_MarioSpeedX
	SEC
	SBC.W DATA_00EAB9,X
	EOR.W DATA_00EAB9,X
	BMI _Return00F04C
	LDA wm_IsCarrying2
	ORA wm_IsDucking
	BNE _Return00F04C
	INX
	INX
	STX wm_WallWalkStatus
_Return00F04C:
	RTS

CODE_00F04D:
	PHX
	LDX #$19
-	CMP.L DATA_00EAC1,X
	BEQ +
	DEX
	BPL -
	CLC
+	PLX
	RTL

DATA_00F05C:
	.DB $01,$05,$01,$02,$01,$01,$00,$00
	.DB $00,$00,$00,$00,$00,$06,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$02,$02
	.DB $02,$03,$03,$04,$02,$02,$02,$01
	.DB $01,$07,$11,$10

DATA_00F080:
	.DB $80,$00,$00,$1E,$00,$00,$05,$09
	.DB $06,$81,$0E,$0C,$14,$00,$05,$09
	.DB $06,$07,$0E,$0C,$16,$18,$1A,$1A
	.DB $00,$09,$00,$00,$FF,$0C,$0A,$00
	.DB $00,$00,$08,$02

DATA_00F0A4:
	.DB $0C,$08,$0C,$08,$0C,$0F,$08,$08
	.DB $08,$08,$08,$08,$08,$08,$08,$08
	.DB $08,$08,$08,$08,$08,$08,$08,$08
	.DB $08,$03,$03,$08,$08,$08,$08,$08
	.DB $08,$04,$08,$08

DATA_00F0C8:
	.DB $0E,$13,$0E,$0D,$0E,$10,$0D,$0D
	.DB $0D,$0D,$0A,$0D,$0D,$0C,$0D,$0D
	.DB $0D,$0D,$0B,$0D,$0D,$16,$0D,$0D
	.DB $0D,$11,$11,$12,$0D,$0D,$0D,$0E
	.DB $0F,$0C,$0D,$0D

DATA_00F0EC:
	.DB $08,$01,$02,$04,$ED,$F6,$00,$7D
	.DB $BE,$00,$6F,$B7

DATA_00F0F8:	.DB $40,$50,$00,$70,$80,$00,$A0,$B0

DATA_00F100:
	.DB $05,$09,$06,$05,$09,$06,$05,$09
	.DB $06,$05,$09,$06,$05,$09,$06,$05
	.DB $07,$0A,$10,$07,$0A,$10,$07,$0A
	.DB $10,$07,$0A,$10,$07,$0A,$10,$07

CODE_00F120:
	XBA
	LDA wm_OnYoshi
	BNE CODE_00F15F
	XBA
_00F127:
	CMP #$2F
	BEQ +++
	CMP #$59
	BCC ++
	CMP #$5C
	BCS +
	XBA
	LDA wm_LvHeadTileset
	CMP #$05
	BEQ +++
	CMP #$0D
	BEQ +++
	XBA
+	CMP #$5D
	BCC +
++	CMP #$66
	BCC _00F160
	CMP #$6A
	BCS _00F160
+	XBA
	LDA wm_LvHeadTileset
	CMP #$01
	BNE CODE_00F15F
+++	PHB
	LDA #:HurtMario+1 ; I'm not sure if this is correct BANK_1
	PHA
	PLB
	JSL HurtMario
	PLB
	RTL

CODE_00F15F:
	XBA
_00F160:
	SEC
	SBC #$11
	CMP #$1D
	BCC _00F17F
	XBA
	PHX
	LDX wm_LvHeadTileset
	LDA.L DATA_00A625,X
	PLX
	AND #$03
	BEQ CODE_00F176
	RTL

CODE_00F176:
	XBA
	SBC #$59
	CMP #$02
	BCS _Return00F1F8
	ADC #$22
_00F17F:
	PHX
	PHA
	TYX
	LDA.L DATA_00F0EC,X
	PLX
	AND.L DATA_00F0A4,X
	BEQ _00F1F6
	STY m6
	LDA.L DATA_00F0C8,X
	STA m7
	LDA.L DATA_00F05C,X
	STA m4
	LDA.L DATA_00F080,X
	BPL _00F1BA
	CMP #$FF
	BNE CODE_00F1AE
	LDA #$05
	LDY wm_GreenStarCoins
	BEQ _00F1D0
	BRA _00F1CE

CODE_00F1AE:
	LSR
	LDA wm_BlockYPos
	ROR
	LSR
	LSR
	LSR
	TAX
	LDA.L DATA_00F100,X
_00F1BA:
	LSR
	BCC _00F1D0
	CMP #$03
	BEQ CODE_00F1C9
	LDY wm_MarioPowerUp
	BNE _00F1D0
	LDA #$01
	BRA _00F1D0

CODE_00F1C9:
	LDY wm_StarPowerTimer
	BNE _00F1D0
_00F1CE:
	LDA #$06
_00F1D0:
	STA m5
	CMP #$05
	BNE +
	LDA #$16
	STA m7
+	TAY
	LDA #$0F
	TRB wm_BlockYPos
	TRB wm_BlockXPos
	CPY #$06
	BNE _00F1EC
	LDY wm_LvHeadTileset
	CPY #$04
	BEQ CODE_00F1F9
_00F1EC:
	PHB
	LDA #:CODE_028752
	PHA
	PLB
	JSL CODE_028752
	PLB
_00F1F6:
	PLX
	CLC
_Return00F1F8:
	RTL

CODE_00F1F9:
	LDA wm_BlockXPos+1
	LSR
	LDA wm_BlockXPos
	AND #$C0
	ROL
	ROL
	ROL
	TAY
	LDA wm_BlockYPos
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA wm_PBalloonFrame,Y
	ORA.L DATA_00F0EC,X
	LDX wm_PBalloonFrame,Y
	STA wm_PBalloonFrame,Y
	CMP #$FF
	BNE CODE_00F226
	LDA #$05
	STA m5
_00F220:
	LDA #$17
	STA m7
	BRA _00F1EC

CODE_00F226:
	LDA wm_StartedBonusGame
	BNE ++
	TXA
	BEQ +
	LDA #$02
+	EOR #$03
	AND wm_FrameA
	BNE _00F220
++	LDA #$2A
	STA wm_SoundCh3
	PHY
	STZ m5
	PHB
	LDA #:CODE_028752
	PHA
	PLB
	JSL CODE_028752
	PLB
	PLY
	LDX #$07
	LDA wm_PBalloonFrame,Y
-	LSR
	BCS +
	PHA
	LDA #$0D
	STA wm_BlockId
	LDA.L DATA_00F0F8,X
	STA wm_BlockYPos
	JSL GenerateTile
	PLA
+	DEX
	BPL -
	JMP _00F1F6

CODE_00F267:
	CPY #$2E
	BNE ++
	BIT wm_JoyFrameA
	BVC ++
	LDA wm_IsCarrying2
	ORA wm_OnYoshi
	BNE ++
	LDA #:CODE_02862F
	PHA
	PLB
	JSL CODE_02862F
	BMI +
	LDA #$02
	STA wm_BlockId
	JSL GenerateTile
+	PHK
	PLB
++	RTS

CODE_00F28C:
	TYA
	SEC
	SBC #$6F
	CMP #$04
	BCS CODE_00F2C0
	CMP wm_1UpInvsCheckPts
	BEQ +
	INC A
	CMP wm_1UpInvsCheckPts
	BEQ ++
	LDA wm_1UpInvsCheckPts
	CMP #$04
	BCS ++
	LDA #$FF
+	INC A
	STA wm_1UpInvsCheckPts
	CMP #$04
	BNE ++
	PHX
	JSL TriggerInivis1Up
	JSR CODE_00F3B2
	ORA wm_1UpInvsCollected,Y
	STA wm_1UpInvsCollected,Y
	PLX
++	RTS

CODE_00F2C0:
	LDA #$01
_00F2C2:
	CPY #$06
	BCS CODE_00F2C9
	TSB wm_8A
	RTS

CODE_00F2C9:
	CPY #$38
	BNE CODE_00F2EE
	LDA #$02
	STA wm_BlockId
	JSL GenerateTile
	JSR CODE_00FD5A
	LDA wm_DisableMidPoint
	BEQ +
	JSR _00CA2B
+	LDA wm_MarioPowerUp
	BNE +
	LDA #$01
	STA wm_MarioPowerUp
+	LDA #$05
	STA wm_SoundCh1
	RTS

CODE_00F2EE:
	CPY #$06
	BEQ +
	CPY #$07
	BCC CODE_00F309
	CPY #$1D
	BCS CODE_00F309
	ORA #$80
+	CMP #$01
	BNE +
	ORA #$18
+	TSB wm_8B
	LDA wm_PlayerBlkSide
	STA wm_8C
	RTS

CODE_00F309:
	CPY #$2F
	BCS +
	CPY #$2A
	BCS CODE_00F32B
+	CPY #$6E
	BNE _Return00F376
	LDA #$0F
	JSL _00F38A
	INC wm_3UpMoonsCol
	PHX
	JSR CODE_00F3B2
	ORA wm_3UpMoonsCollected,Y
	STA wm_3UpMoonsCollected,Y
	PLX
	BRA _00F36B

CODE_00F32B:
	BNE +
	LDA wm_BluePowTimer
	BEQ _Return00F376
+	CPY #$2D
	BEQ +
	BCC CODE_00F367
	LDA wm_BlockXPos
	SEC
	SBC #$10
	STA wm_BlockXPos
+	JSL CODE_00F377
	INC wm_YoshiCoinsDisp
	LDA wm_YoshiCoinsDisp
	CMP #$05
	BCC +
	PHX
	JSR CODE_00F3B2
	ORA wm_5YoshiCoins,Y
	STA wm_5YoshiCoins,Y
	PLX
+	LDA #$1C
	STA wm_SoundCh1
	LDA #$01
	JSL _05B330
	LDY #$18
	BRA _00F36D

CODE_00F367:
	JSL CODE_05B34A
_00F36B:
	LDY #$01
_00F36D:
	STY wm_BlockId
	JSL GenerateTile
	JSR CODE_00FD5A
_Return00F376:
	RTS

CODE_00F377:
	LDA wm_YoshiCoinsCollected
	INC wm_YoshiCoinsCollected
	CLC
	ADC #$09
	CMP #$0D
	BCC +
	LDA #$0D
+	BRA _00F38A

CODE_00F388:
	LDA #$0D
_00F38A:
	PHA
	JSL CODE_02AD34
	PLA
	STA wm_ScoreSprNum,Y
	LDA wm_MarioXPos
	STA wm_ScoreSprXLo,Y
	LDA wm_MarioXPos+1
	STA wm_ScoreSprXHi,Y
	LDA wm_MarioYPos
	STA wm_ScoreSprYLo,Y
	LDA wm_MarioYPos+1
	STA wm_ScoreSprYHi,Y
	LDA #$30
	STA wm_ScoreSprSpeedY,Y
	LDA #$00
	STA wm_ScoreSprLayer,Y
	RTL

CODE_00F3B2:
	LDA wm_TransLvNum
	LSR
	LSR
	LSR
	TAY
	LDA wm_TransLvNum
	AND #$07
	TAX
	LDA.L DATA_05B35B,X
	RTS

CODE_00F3C4:
	CPY #$3F
	BNE _Return00F376
	LDY wm_8F
	BEQ CODE_00F3CF
	JMP _00F43F

CODE_00F3CF:
	PHX
	TAX
	LDA wm_MarioXPos
	TXY
	BEQ +
	EOR #$FF
	INC A
+	AND #$0F
	ASL
	CLC
	ADC #$20
	LDY #$05
	BRA _00F40A

DATA_00F3E3:	.DB 10,-1

PIPE_BUTTONS:	.DB JoyLeft,JoyRight,JoyUp,JoyDown

CODE_00F3E9:
	XBA
	TYA
	SEC
	SBC #$37
	CMP #$02
	BCS +++
	TAY
	LDA wm_PlayerBlkPosX
	SBC DATA_00F3E3,Y
	CMP #$05
	BCS _00F43F
	PHX
	XBA
	TAX
	LDA #$20
	LDY wm_OnYoshi
	BEQ +
	LDA #$30
+	LDY #$06
_00F40A:
	STA wm_PipeWarpTimer
	LDA wm_JoyPadA
	AND.W PIPE_BUTTONS,X
	BEQ ++
	STA wm_SpritesLocked
	AND #$01
	STA wm_MarioDirection
	STX wm_PipeAction
	TXA
	LSR
	TAX
	BNE +
	LDA wm_IsCarrying2
	BEQ +
	LDA wm_MarioDirection
	EOR #$01
	STA wm_MarioDirection
	LDA #$08
	STA wm_FaceCamImgTimer
+	INX
	STX wm_YoshiInPipe
	STY wm_MarioAnimation
	JSR _NoButtons
	LDA #$04
	STA wm_SoundCh1
++	PLX
_00F43F:
	LDY wm_Map16NumLo
+++	RTS

CODE_00F443:
	LDA wm_MarioXPos
	CLC
	ADC #$04
	AND #$0F
	CMP #$08
	RTS

CODE_00F44D:
	INX
	INX
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC.W DATA_00E832-2,X
	STA wm_BlockYPos
	LDA wm_MarioYPos
	CLC
	ADC.W DATA_00E89C,X
	STA wm_BlockXPos
_00F461:
	JSR CODE_00F465
	RTS

CODE_00F465:
	SEP #$20
	STZ wm_WhichSwitchPressed
	PHX
	LDA wm_8E
	BPL CODE_00F472
	JMP CODE_00F4EC

CODE_00F472:
	BNE CODE_00F4A6
	REP #$20
	LDA wm_BlockXPos
	CMP #$01B0
	SEP #$20
	BCS CODE_00F4A0
	AND #$F0
	STA m0
	LDX wm_BlockYPos+1
	CPX wm_ScreensInLvl
	BCS CODE_00F4A0
	LDA wm_BlockYPos
	LSR
	LSR
	LSR
	LSR
	ORA m0
	CLC
	ADC.L DATA_00BA60,X
	STA m0
	LDA wm_BlockXPos+1
	ADC.L DATA_00BA9C,X
	BRA _00F4CD

CODE_00F4A0:
	PLX
	LDY #$25
_00F4A3:
	LDA #$00
	RTS

CODE_00F4A6:
	LDA wm_BlockYPos+1
	CMP #$02
	BCS CODE_00F4E7
	LDX wm_BlockXPos+1
	CPX wm_ScreensInLvl
	BCS CODE_00F4E7
	LDA wm_BlockXPos
	AND #$F0
	STA m0
	LDA wm_BlockYPos
	LSR
	LSR
	LSR
	LSR
	ORA m0
	CLC
	ADC.L DATA_00BA80,X
	STA m0
	LDA wm_BlockYPos+1
	ADC.L DATA_00BABC,X
_00F4CD:
	STA m1
	LDA #$7E
	STA m2
	LDA [m0]
	STA wm_Map16NumLo
	INC m2
	PLX
	LDA [m0]
	JSL CODE_00F545
	LDY wm_Map16NumLo
	CMP #$00
	RTS

CODE_00F4E7:
	PLX
	LDY #$25
	BRA _00F4A3

CODE_00F4EC:
	ASL
	BNE CODE_00F51B
	REP #$20
	LDA wm_BlockXPos
	CMP #$01B0
	SEP #$20
	BCS CODE_00F4E7
	AND #$F0
	STA m0
	LDX wm_BlockYPos+1
	CPX #$10
	BCS CODE_00F4E7
	LDA wm_BlockYPos
	LSR
	LSR
	LSR
	LSR
	ORA m0
	CLC
	ADC.L DATA_00BA70,X
	STA m0
	LDA wm_BlockXPos+1
	ADC.L DATA_00BAAC,X
	BRA _00F4CD

CODE_00F51B:
	LDA wm_BlockYPos+1
	CMP #$02
	BCS CODE_00F4E7
	LDX wm_BlockXPos+1
	CPX #$0E
	BCS CODE_00F4E7
	LDA wm_BlockXPos
	AND #$F0
	STA m0
	LDA wm_BlockYPos
	LSR
	LSR
	LSR
	LSR
	ORA m0
	CLC
	ADC.L DATA_00BA8E,X
	STA m0
	LDA wm_BlockYPos+1
	ADC.L DATA_00BACA,X
	JMP _00F4CD

CODE_00F545:
	TAY
	BNE CODE_00F577
	LDY wm_Map16NumLo
	CPY #$29
	BNE PSwitchNotInvQBlk
	LDY wm_BluePowTimer
	BEQ _Return00F594
	LDA #$24
	STA wm_Map16NumLo
	RTL

PSwitchNotInvQBlk:
	CPY #$2B
	BEQ PSwitchCoinBrown
	TYA
	SEC
	SBC #$EC
	CMP #$10
	BCS _00F592
	INC A
	STA wm_WhichSwitchPressed
	BRA _00F571

PSwitchCoinBrown:
	LDY wm_BluePowTimer
	BEQ _Return00F594
_00F571:
	LDA #$32
	STA wm_Map16NumLo
	RTL

CODE_00F577:
	LDY wm_Map16NumLo
	CPY #$32
	BNE CODE_00F584
	LDY wm_BluePowTimer
	BNE _00F58D
	RTL

CODE_00F584:
	CPY #$2F
	BNE _Return00F594
	LDY wm_SilverPowTimer
	BEQ _Return00F594
_00F58D:
	LDY #$2B
	STY wm_Map16NumLo
_00F592:
	LDA #$00
_Return00F594:
	RTL

CODE_00F595:
	REP #$20
	LDA #$FF80
	CLC
	ADC wm_Bg1VOfs
	CMP wm_MarioYPos
	BMI +
	STA wm_MarioYPos
+	SEP #$20
	LDA wm_MarioScrPosY+1
	DEC A
	BMI _Return00F5B6
	LDA wm_YoshiWingsAboveGrnd
	BEQ CODE_00F5B2
	JMP _00C95B

CODE_00F5B2:
	JSL _00F60A
_Return00F5B6:
	RTS

HurtMario:
	LDA wm_MarioAnimation
	BNE _Return00F628
	LDA wm_PlayerHurtTimer
	ORA wm_StarPowerTimer
	ORA wm_EndLevelTimer
	BNE _Return00F628
	STZ wm_CoinGameCoins
	LDA wm_WallWalkStatus
	BEQ +
	PHB
	PHK
	PLB
	JSR ADDR_00EB42
	PLB
+	LDA wm_MarioPowerUp
	BEQ KillMario
	CMP #$02
	BNE PowerDown
	LDA wm_CapeGlidePhase
	BEQ PowerDown
	LDY #$0F
	STY wm_SoundCh1
	LDA #$01
	STA wm_IsSpinJump
	LDA #$30
	STA wm_PlayerHurtTimer
	BRA _00F622

PowerDown:
	LDY #$04
	STY wm_SoundCh1
	JSL DropReservedItem
	LDA #$01
	STA wm_MarioAnimation
	STZ wm_MarioPowerUp
	LDA #$2F
	BRA _00F61D

KillMario:
	LDA #$90
	STA wm_MarioSpeedY
_00F60A:
	LDA #$09
	STA wm_MusicCh1
	LDA #$FF
	STA wm_LevelMusicMod
	LDA #$09
	STA wm_MarioAnimation
	STZ wm_IsSpinJump
	LDA #$30
_00F61D:
	STA wm_PlayerAnimTimer
	STA wm_SpritesLocked
_00F622:
	STZ wm_CapeGlidePhase
	STZ wm_188A
_Return00F628:
	RTL

CODE_00F629:
	JSL KillMario
_NoButtons:
	STZ wm_JoyPadA
	STZ wm_JoyFrameA
	STZ wm_JoyPadB
	STZ wm_JoyFrameB
	RTS

CODE_00F636:
	REP #$20
	LDX #$00
	LDA m9
	ORA #$0800
	CMP m9
	BEQ +
	CLC
+	AND #$F700
	ROR
	LSR
	ADC #$2000
	STA wm_0D85
	CLC
	ADC #$0200
	STA wm_0D85+10
	LDX #$00
	LDA m10
	ORA #$0800
	CMP m10
	BEQ +
	CLC
+	AND #$F700
	ROR
	LSR
	ADC #$2000
	STA wm_0D85+2
	CLC
	ADC #$0200
	STA wm_0D85+12
	LDA m11
	AND #$FF00
	LSR
	LSR
	LSR
	ADC #$2000
	STA wm_0D85+4
	CLC
	ADC #$0200
	STA wm_0D85+14
	LDA m12
	AND #$FF00
	LSR
	LSR
	LSR
	ADC #$2000
	STA wm_Tile7FPtr
	SEP #$20
	LDA #$0A
	STA wm_PlayerDmaTiles
	RTS

DATA_00F69F:	.DW 100,124

DATA_00F6A3:	.DW 0,-1

DATA_00F6A7:	.DW -3,5,-6

DATA_00F6AD:	.DW 0,0,192

DATA_00F6B3:	.DW 144,96,0,0,0,0

DATA_00F6BF:	.DW 0,-2,2,0,-2,2

DATA_00F6CB:	.DB 0,0,32,0

DATA_00F6CF:	.DW 208,0,32,208,1,-1

CODE_00F6DB:
	PHB
	PHK
	PLB
	REP #$20
	LDA wm_PosToScrollScreen
	SEC
	SBC #$000C
	STA wm_CanScrollScreen
	CLC
	ADC #$0018
	STA wm_CanScrollScreen+2
	LDA wm_L1NextPosX
	STA wm_Bg1HOfs
	LDA wm_L1NextPosY
	STA wm_Bg1VOfs
	LDA wm_L2NextPosX
	STA wm_Bg2HOfs
	LDA wm_L2NextPosY
	STA wm_Bg2VOfs
	LDA wm_IsVerticalLvl
	LSR
	BCC CODE_00F70D
	JMP CODE_00F75C

CODE_00F70D:
	LDA #$00C0
	JSR CODE_00F7F4
	LDY wm_HorzScrollHead
	BEQ ++
	LDY #$02
	LDA wm_MarioXPos
	SEC
	SBC wm_Bg1HOfs
	STA m0
	CMP wm_PosToScrollScreen
	BPL +
	LDY #$00
+	STY wm_Layer1ScrollDir
	STY wm_Layer2ScrollDir
	SEC
	SBC wm_CanScrollScreen,Y
	BEQ ++
	STA m2
	EOR DATA_00F6A3,Y
	BPL ++
	JSR CODE_00F8AB
	LDA m2
	CLC
	ADC wm_Bg1HOfs
	BPL +
	LDA #$0000
+	STA wm_Bg1HOfs
	LDA wm_LastScreenHorz
	DEC A
	XBA
	AND #$FF00
	BPL +
	LDA #$0080
+	CMP wm_Bg1HOfs
	BPL ++
	STA wm_Bg1HOfs
++	BRA _00F79D

CODE_00F75C:
	LDA wm_LastScreenVert
	DEC A
	XBA
	AND #$FF00
	JSR CODE_00F7F4
	LDY wm_HorzScrollHead
	BEQ _00F79D
	LDY #$00
	LDA wm_MarioXPos
	SEC
	SBC wm_Bg1HOfs
	STA m0
	CMP wm_PosToScrollScreen
	BMI +
	LDY #$02
+	SEC
	SBC wm_CanScrollScreen,Y
	STA m2
	EOR DATA_00F6A3,Y
	BPL _00F79D
	JSR CODE_00F8AB
	LDA m2
	CLC
	ADC wm_Bg1HOfs
	BPL +
	LDA #$0000
+	CMP #$0101
	BMI +
	LDA #$0100
+	STA wm_Bg1HOfs
_00F79D:
	LDY wm_HorzScrollLyr2
	BEQ ++
	LDA wm_Bg1HOfs
	DEY
	BEQ +
	LSR
+	STA wm_Bg2HOfs
++	LDY wm_VertScrollLyr2
	BEQ ++
	LDA wm_Bg1VOfs
	DEY
	BEQ +
	LSR
	DEY
	BEQ +
	LSR
	LSR
	LSR
	LSR
+	CLC
	ADC wm_VertL2ScrollLength
	STA wm_Bg2VOfs
++	SEP #$20
	LDA wm_Bg1HOfs
	SEC
	SBC wm_L1NextPosX
	STA wm_L1CurXChange
	LDA wm_Bg1VOfs
	SEC
	SBC wm_L1NextPosY
	STA wm_L1CurYChange
	LDA wm_Bg2HOfs
	SEC
	SBC wm_L2NextPosX
	STA wm_L2CurXChange
	LDA wm_Bg2VOfs
	SEC
	SBC wm_L2NextPosY
	STA wm_L2CurYChange
	LDX #$07
-	LDA wm_Bg1HOfs,X
	STA wm_L1NextPosX,X
	DEX
	BPL -
	PLB
	RTL

CODE_00F7F4:
	LDX wm_VertScrollHead
	BNE CODE_00F7FA
	RTS

CODE_00F7FA:
	STA m4
	LDY #$00
	LDA wm_MarioYPos
	SEC
	SBC wm_Bg1VOfs
	STA m0
	CMP.W #$0070
	BMI +
	LDY #$02
+	STY wm_Layer1ScrollDir
	STY wm_Layer2ScrollDir
	SEC
	SBC DATA_00F69F,Y
	STA m2
	EOR DATA_00F6A3,Y
	BMI +
	LDY #$02
	STZ m2
+	LDA m2
	BMI CODE_00F82A
	LDX #$00
	STX wm_ScrScrollToPlayer
	BRA _00F883

CODE_00F82A:
	SEP #$20
	LDA wm_WallWalkStatus
	CMP #$06
	BCS +
	LDA wm_YoshiHasWingsB
	LSR
	ORA wm_GlideTimer
	ORA wm_IsClimbing
	ORA wm_PBalloonFrame
	ORA wm_IsInLakituCloud
	ORA wm_BouncingWithYoshi
+	TAX
	REP #$20
	BNE ++
	LDX wm_OnYoshi
	BEQ +
	LDX wm_YoshiHasWings
	CPX #$02
	BCS ++
+	LDX wm_IsSwimming
	BEQ +
	LDX wm_IsFlying
	BNE ++
+	LDX wm_VertScrollHead
	DEX
	BEQ CODE_00F875
	LDX wm_EnableVertScroll
	BNE CODE_00F875
++	STX wm_EnableVertScroll
	LDX wm_EnableVertScroll
	BNE _00F881
	LDY #$04
	BRA _00F881

CODE_00F875:
	LDX wm_ScrScrollToPlayer
	BNE _00F881
	LDX wm_IsFlying
	BNE ++
	INC wm_ScrScrollToPlayer
_00F881:
	LDA m2
_00F883:
	SEC
	SBC DATA_00F6A7,Y
	EOR DATA_00F6A7,Y
	ASL
	LDA m2
	BCS +
	LDA DATA_00F6A7,Y
+	CLC
	ADC wm_Bg1VOfs
	CMP DATA_00F6AD,Y
	BPL +
	LDA DATA_00F6AD,Y
+	STA wm_Bg1VOfs
	LDA m4
	CMP wm_Bg1VOfs
	BPL ++
	STA wm_Bg1VOfs
	STZ wm_EnableVertScroll
++	RTS

CODE_00F8AB:
	LDY wm_LRScrollFlag
	BNE ++
	SEP #$20
	LDX wm_LRScrollStop
	REP #$20
	LDY #$08
	LDA wm_PosToScrollScreen
	CMP.W DATA_00F6B3,X
	BPL +
	LDY #$0A
+	LDA DATA_00F6BF,Y
	EOR m2
	BPL ++
	LDA.W DATA_00F6BF,X
	EOR m2
	BPL ++
	LDA m2
	CLC
	ADC DATA_00F6CF,Y
	BEQ ++
	STA m2
	STY wm_LRMoveCamera
++	RTS

DATA_00F8DF:
	.DB $0C,$0C,$08,$00,$20,$04,$0A,$0D
	.DB $0D

DATA_00F8E8:	.DW 42,42,18,0,-19

CODE_00F8F2:
	JSR CODE_00EAA6
	BIT wm_LevelMode
	BVC CODE_00F94E
	JSR CODE_00E92B
	LDA wm_M7BossGfxIndex
	ASL
	TAX
	PHX
	LDY wm_MarioSpeedY
	BPL +
	REP #$20
	LDA wm_MarioYPos
	CMP.W DATA_00F8E8,X
	BPL +
	LDA.W DATA_00F8E8,X
	STA wm_MarioYPos
	SEP #$20
	STZ wm_MarioSpeedY
	LDA #$01
	STA wm_SoundCh1
+	SEP #$20
	PLX
	LDA.W DATA_00F8E8,X
	CMP #$2A
	BNE Return00F94D
	REP #$20
	LDY #$00
	LDA wm_SpriteMiscTbl8.Spr10
	AND #$00FF
	INC A
	CMP wm_MarioXPos
	BEQ +
	BMI +
	LDA wm_SpriteMiscTbl5.Spr10
	AND #$00FF
	STA m0
	INY
	LDA wm_MarioXPos
	CLC
	ADC #$000F
	CMP m0
+	JMP _00E9C8

Return00F94D:
	RTS

CODE_00F94E:
	LDY #$00
	LDA wm_MarioSpeedY
	BPL CODE_00F957
	JMP _00F997

CODE_00F957:
	JSR CODE_00F9A8
	BCS CODE_00F962
	JSR _00EE1D
	JMP _00F997

CODE_00F962:
	LDA wm_IsFlying
	BEQ +
	REP #$20
	LDA wm_ChainFirstX
	AND #$00FF
	STA wm_ChainCosX
	STA wm_KeyHolePos1
	LDA wm_ChainFirstY
	AND #$00F0
	STA wm_ChainSinY
	STA wm_KeyHolePos2
	JSR CODE_00F9C9
+	LDA wm_M7Rotate
	CLC
	ADC.B #$48
	LSR
	LSR
	LSR
	LSR
	TAX
	LDY.W DATA_00F8DF,X
	LDA.B #$80
	STA wm_8E
	JSR _00EEE1
_00F997:
	REP #$20
	LDA wm_MarioScrPosY
	CMP #$00AE
	SEP #$20
	BMI +
	JSR CODE_00F629
+	JMP _00E98C

CODE_00F9A8:
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC #$0008
	STA wm_ChainCosX
	LDA wm_MarioYPos
	CLC
	ADC #$0020
	STA wm_ChainSinY
_00F9BC:
	SEP #$20
	PHB
	LDA #:CODE_01CC9D
	PHA
	PLB
	JSL CODE_01CC9D
	PLB
	RTS

CODE_00F9C9:
	LDA wm_M7Rotate
	PHA
	EOR.W #$FFFF
	INC A
	STA wm_M7Rotate
	JSR _00F9BC
	REP #$20
	PLA
	STA wm_M7Rotate
	LDA wm_ChainFirstX
	AND #$00FF
	SEC
	SBC #$0008
	STA wm_MarioXPos
	LDA wm_ChainFirstY
	AND #$00FF
	SEC
	SBC #$0020
	STA wm_MarioYPos
	SEP #$20
	RTS

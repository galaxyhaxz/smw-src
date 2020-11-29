DATA_05A580:
	.DB $51,$A7,$51,$87,$51,$67,$51,$47
	.DB $51,$27,$51,$07,$50,$E7,$50,$C7

DATA_05A590:
	.DB $14,$45,$3F,$08,$00,$29,$AA,$27
	.DB $26,$84,$95,$A9,$15,$13,$CE,$A7
	.DB $A4,$25,$A5,$05,$A6,$2A,$28

DATA_05A5A7:
	.DW LevelMsg01-DATA_05A5D9
	.DW LevelMsg01-DATA_05A5D9
	.DW LevelMsg01-DATA_05A5D9
	.DW LevelMsg01-DATA_05A5D9
	.DW LevelMsg00-DATA_05A5D9
	.DW LevelMsg05-DATA_05A5D9
	.DW LevelMsg08-DATA_05A5D9
	.DW LevelMsg0A-DATA_05A5D9
	.DW LevelMsg0C-DATA_05A5D9
	.DW LevelMsg11-DATA_05A5D9
	.DW LevelMsg0F-DATA_05A5D9
	.DW LevelMsg06-DATA_05A5D9
	.DW LevelMsg10-DATA_05A5D9
	.DW LevelMsg13-DATA_05A5D9
	.DW LevelMsg15-DATA_05A5D9
	.DW LevelMsg09-DATA_05A5D9
	.DW LevelMsg14-DATA_05A5D9
	.DW LevelMsg0D-DATA_05A5D9
	.DW LevelMsg0E-DATA_05A5D9
	.DW LevelMsg12-DATA_05A5D9
	.DW LevelMsg0B-DATA_05A5D9
	.DW LevelMsg07-DATA_05A5D9
	.DW LevelMsg02-DATA_05A5D9
	.DW LevelMsg04-DATA_05A5D9
	.DW LevelMsg03-DATA_05A5D9

DATA_05A5D9:
;	base $0000
	.INCLUDE "strings/level_messages.a"
;	base off

DATA_05B0FF:	.INCBIN "images/menus/notext.stim"

DATA_05B106:	.DB $4C,$50

DATA_05B108:	.DB $50,$00

DATA_05B10A:	.DB $04,$FC

CODE_05B10C:
	PHB
	PHK
	PLB
	LDX wm_MsgBoxActionFlag
	LDA wm_MsgBoxActionTimer
	CMP.W DATA_05B108,X
	BNE CODE_05B191
	TXA
	BEQ CODE_05B132
	STZ wm_MsgBoxTrig
	STZ wm_MsgBoxActionFlag
	STZ wm_W12Sel
	STZ wm_W34Sel
	STZ wm_WObjSel
	STZ wm_HDMAEn
	LDA.B #$02
	STA wm_CgSwSel
	BRA _05B18E

CODE_05B132:
	LDA wm_ForceLoadLevel
	ORA wm_SwitchPalaceCol
	BEQ CODE_05B16E
	LDA wm_IntroCtrlSeqFrame
	BEQ CODE_05B16E
	LDA wm_FrameA
	AND.B #$03
	BNE _05B18E
	DEC wm_IntroCtrlSeqFrame
	BNE _05B18E
	LDA wm_SwitchPalaceCol
	BEQ CODE_05B16E
	PLB
	INC wm_CreditsEnemyNum
	LDA.B #$01
	STA wm_MidwayPointFlag
	BRA _05B165

CODE_05B15A:
	PLB
	LDA.B #$8E
	STA wm_MapData.MarioYPos
_SubSideExit:
	STZ wm_ForceLoadLevel
	LDA.B #$00
_05B165:
	STA wm_LevelEndFlag
	LDA.B #$0B
	STA wm_GameMode
	RTL

CODE_05B16E:
	LDA wm_JoyPadA
	AND.B #$F0
	BEQ _05B18E
	EOR wm_JoyFrameA
	AND.B #$F0
	BEQ +
	LDA wm_JoyPadB
	AND.B #$C0
	BEQ _05B18E
	EOR wm_JoyFrameB
	AND.B #$C0
	BNE _05B18E
+	LDA wm_ForceLoadLevel
	BNE CODE_05B15A
	INC wm_MsgBoxActionFlag
_05B18E:
	JMP _05B299

CODE_05B191:
	CMP.W DATA_05B106,X
	BNE +
	TXA
	BEQ CODE_05B1A3
	JSR CODE_05B31B
	LDA.B #$09
	STA wm_ImageLoader
+	JMP _05B250

CODE_05B1A3:
	LDX.B #$16
-	LDY.B #$01
	LDA.W DATA_05A590,X
	BPL +
	INY
	AND.B #$7F
+	CPY wm_MsgBoxTrig
	BNE +
	CMP wm_TransLvNum
	BEQ ++
+	DEX
	BNE -
++	LDY wm_MsgBoxTrig
	CPY.B #$03
	BNE +
	LDX.B #$18
+	CPX.B #$04
	BCS +
	INX
	STX wm_SwitchPalaceCol
	DEX
	JSR CODE_05B2EB
+	CPX.B #$16
	BNE +
	LDA wm_OnYoshi
	BEQ +
	INX
+	TXA
	ASL
	TAX
	REP #$20
	LDA.W DATA_05A5A7,X
	STA m0
	REP #$10
	LDA wm_ImageIndex
	TAX
	LDY #$000E
-	LDA DATA_05A580,Y
	STA wm_ImageTable,X
	LDA #$2300
	STA wm_ImageTable.2.ImgL,X
	PHY
	SEP #$20
	LDA #$12
	STA m2
	STZ m3
	LDY m0
--	LDA #$1F
	BIT.W m3
	BMI +
	LDA DATA_05A5D9,Y
	STA.W m3
	AND #$7F
	INY
+	STA wm_ImageTable.3.ImgL,X
	LDA #$39
	STA wm_ImageTable.3.ImgH,X
	INX
	INX
	DEC m2
	BNE --
	STY m0
	REP #$20
	INX
	INX
	INX
	INX
	PLY
	DEY
	DEY
	BPL -
	LDA #$00FF
	STA wm_ImageTable,X
	TXA
	STA wm_ImageIndex
	SEP #$30
	LDA #$01
	STA wm_L3ScrollFlag
	STZ wm_Bg3HOfs
	STZ wm_Bg3HOfs+1
	STZ wm_Bg3VOfs
	STZ wm_Bg3VOfs+1
_05B250:
	LDX wm_MsgBoxActionFlag
	LDA wm_MsgBoxActionTimer
	CLC
	ADC.W DATA_05B10A,X
	STA wm_MsgBoxActionTimer
	CLC
	ADC #$80
	XBA
	LDA #$80
	SEC
	SBC wm_MsgBoxActionTimer
	REP #$20
	LDX #$00
	LDY #$50
-	CPX wm_MsgBoxActionTimer
	BCC +
	LDA #$00FF
+	STA wm_HDMAWindowsTbl+76,Y
	STA wm_HDMAWindowsTbl+156,X
	INX
	INX
	DEY
	DEY
	BNE -
	SEP #$20
	LDA #$22
	STA wm_W12Sel
	LDY wm_SwitchPalaceCol
	BEQ +
	LDA #$20
+	STA wm_WObjSel
	LDA #$22
	STA wm_CgSwSel
	LDA #$80
	STA wm_HDMAEn
_05B299:
	PLB
	RTL

DATA_05B29B:
	.DB $AD,$35,$AD,$75,$AD,$B5,$AD,$F5
	.DB $A7,$35,$A7,$75,$B7,$35,$B7,$75
	.DB $BD,$37,$BD,$77,$BD,$B7,$BD,$F7
	.DB $A7,$37,$A7,$77,$B7,$37,$B7,$77
	.DB $AD,$39,$AD,$79,$AD,$B9,$AD,$F9
	.DB $A7,$39,$A7,$79,$B7,$39,$B7,$79
	.DB $BD,$3B,$BD,$7B,$BD,$BB,$BD,$FB
	.DB $A7,$3B,$A7,$7B,$B7,$3B,$B7,$7B

DATA_05B2DB:
	.DB $50,$4F,$58,$4F,$50,$57,$58,$57
	.DB $92,$4F,$9A,$4F,$92,$57,$9A,$57

CODE_05B2EB:
	PHX
	TXA
	ASL
	ASL
	ASL
	ASL
	TAX
	STZ m0
	REP #$20
	LDY #$1C
-	LDA.W DATA_05B29B,X
	STA wm_ExOamSlot.1.Tile,Y
	PHX
	LDX m0
	LDA.W DATA_05B2DB,X
	STA wm_ExOamSlot.1.XPos,Y
	PLX
	INX
	INX
	INC m0
	INC m0
	DEY
	DEY
	DEY
	DEY
	BPL -
	STZ wm_OamHiX
	SEP #$20
	PLX
	RTS

CODE_05B31B:
	LDY #$1C
	LDA #$F0
-	STA wm_ExOamSlot.1.YPos,Y
	DEY
	DEY
	DEY
	DEY
	BPL -
	RTS

ADDR_05B329:
	PHA
	LDA #$01
	STA wm_SoundCh3
	PLA
_05B330:
	STA m0
	CLC
	ADC wm_CoinAdder
	STA wm_CoinAdder
	LDA wm_GreenStarCoins
	BEQ _Return05B35A
	SEC
	SBC m0
	BPL +
	LDA #$00
+	STA wm_GreenStarCoins
	BRA _Return05B35A

CODE_05B34A:
	INC wm_CoinAdder
	LDA #$01
	STA wm_SoundCh3
	LDA wm_GreenStarCoins
	BEQ _Return05B35A
	DEC wm_GreenStarCoins
_Return05B35A:
	RTL

DATA_05B35B:	.DB $80,$40,$20,$10,$08,$04,$02,$01

ADDR_05B363: ; unreachable
	TYA
	AND #$07
	PHA
	TYA
	LSR
	LSR
	LSR
	TAX
	LDA wm_MapData.OwEventFlags,X
	PLX
	AND.L DATA_05B35B,X
	RTL

DATA_05B375:	.INCBIN "images/other/titlescreen.stim"

DATA_05B6FE:
	.INCBIN "images/menus/erase.stim"
	.INCBIN "images/menus/load.stim"

DATA_05B872:	.INCBIN "images/menus/x_player_game.stim"

DATA_05B8C7:	.INCBIN "images/menus/save.stim"

DATA_05B91C:	.INCBIN "images/menus/end.stim"

DATA_05B93B:
	.DB $00,$06,$40,$06,$80,$06,$40,$07
	.DB $A0,$0E,$00,$08,$00,$05,$40,$05
	.DB $80,$05,$C0,$05,$80,$07,$C0,$07
	.DB $A0,$0D,$C0,$06,$00,$07,$C0,$04
	.DB $40,$04,$80,$04,$00,$04,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00

DATA_05B96B:
	.DB $00,$00,$00,$00,$00,$00,$01,$01
	.DB $01,$01,$01,$01,$01,$01,$02,$02
	.DB $02,$02

DATA_05B97D:
	.DB $02,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$01,$00,$02,$02,$00

DATA_05B98B:
	.DB $00,$05,$0A,$0F,$14,$14,$19,$14
	.DB $0A,$14,$00,$05,$00,$14

AnimatedTileData:
	.DB $00,$95,$00,$97,$00,$99,$00,$9B
	.DB $80,$95,$80,$97,$80,$99,$80,$9B
	.DB $00,$96,$00,$96,$00,$96,$00,$96
	.DB $80,$9D,$80,$9F,$80,$A1,$80,$A3
	.DB $00,$96,$00,$98,$00,$9A,$00,$9C
	.DB $80,$6D,$80,$6F,$00,$7C,$80,$7C
	.DB $20,$AC,$20,$AC,$20,$AC,$20,$AC
	.DB $20,$AC,$20,$AC,$20,$AC,$20,$AC
	.DB $80,$93,$80,$93,$80,$93,$80,$93
	.DB $00,$A4,$80,$A4,$00,$A4,$80,$A4
	.DB $20,$AC,$20,$AC,$20,$AC,$20,$AC
	.DB $00,$AC,$00,$AC,$00,$AC,$00,$AC
	.DB $00,$91,$00,$91,$00,$91,$00,$91
	.DB $80,$96,$80,$98,$80,$9A,$80,$9C
	.DB $00,$9D,$00,$9F,$00,$A1,$00,$A3
	.DB $80,$8E,$80,$90,$80,$92,$80,$94
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $00,$9D,$00,$9F,$00,$A1,$00,$A3

DATA_05BA39:
	.DB $80,$8E,$80,$90,$80,$92,$80,$94
	.DB $00,$7D,$00,$7F,$00,$81,$00,$83
	.DB $00,$83,$00,$81,$00,$7F,$00,$7D
	.DB $00,$9E,$00,$A0,$00,$A2,$00,$A0
	.DB $00,$9D,$00,$9F,$00,$A1,$00,$A3
	.DB $00,$A5,$00,$A7,$00,$A9,$00,$AB
	.DB $80,$A5,$80,$A7,$80,$A9,$80,$AB
	.DB $80,$AB,$80,$A9,$80,$A7,$80,$A5
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $80,$9E,$80,$A0,$80,$A2,$80,$A0
	.DB $80,$7D,$80,$7F,$80,$81,$80,$83
	.DB $00,$7E,$00,$80,$00,$82,$00,$84
	.DB $80,$7E,$80,$80,$80,$82,$80,$84
	.DB $80,$83,$80,$81,$80,$7F,$80,$7D
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $80,$A6,$80,$A8,$80,$AA,$80,$A8
	.DB $00,$8E,$00,$90,$00,$92,$00,$94
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $80,$9E,$80,$A0,$80,$A2,$80,$A0
	.DB $00,$A6,$00,$A8,$00,$AA,$00,$A8
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $00,$95,$00,$95,$00,$95,$00,$95
	.DB $80,$91,$80,$91,$80,$91,$80,$91
	.DB $80,$96,$80,$98,$80,$9A,$80,$9C
	.DB $80,$96,$80,$98,$80,$9A,$80,$9C
	.DB $80,$96,$80,$98,$80,$9A,$80,$9C
	.DB $00,$95,$00,$97,$00,$99,$00,$9B
	.DB $80,$AC,$80,$AC,$80,$AC,$80,$AC
	.DB $00,$93,$00,$93,$00,$93,$00,$93
	.DB $80,$93,$80,$93,$80,$93,$80,$93

CODE_05BB39:
	PHB
	PHK
	PLB
	LDA wm_FrameB
	AND #$07
	STA m0
	ASL
	ADC m0
	TAY
	ASL
	TAX
	REP #$20
	LDA wm_FrameB
	AND #$0018
	LSR
	LSR
	STA m0
	LDA.W DATA_05B93B,X
	STA wm_GfxAnimVma3
	LDA.W DATA_05B93B+2,X
	STA wm_GfxAnimVma2
	LDA.W DATA_05B93B+4,X
	STA wm_GfxAnimVma1
	LDX #$04
_05BB67:
	PHY
	PHX
	SEP #$20
	TYA
	LDX.W DATA_05B96B,Y
	BEQ _05BB88
	DEX
	BNE CODE_05BB81
	LDX.W DATA_05B97D,Y
	LDY.W wm_BluePowTimer,X
	BEQ _05BB88
	CLC
	ADC #$26
	BRA _05BB88

CODE_05BB81:
	LDY wm_LvHeadTileset
	CLC
	ADC DATA_05B98B,Y
_05BB88:
	REP #$30
	AND #$00FF
	ASL
	ASL
	ASL
	ORA m0
	TAY
	LDA AnimatedTileData,Y
	SEP #$10
	PLX
	STA wm_GfxAnimFrame1,X
	PLY
	INY
	DEX
	DEX
	BPL _05BB67
	SEP #$20
	PLB
	RTL

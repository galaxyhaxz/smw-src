CODE_05CBFF:
	PHB
	PHK
	PLB
	JSR CODE_05CC07
	PLB
	RTL

CODE_05CC07:
	LDA wm_OWProcessPtr
	JSL ExecutePtr

Ptrs05CC0E:
	.DW CODE_05CC66
	.DW CODE_05CD76
	.DW CODE_05CECA
	.DW _Return05CFE9

DATA_05CC16:	.INCBIN "images/levels/course_clear.stim"

DATA_05CC61:	.DB $40,$41,$42,$43,$44

CODE_05CC66:
	LDY #$00
	LDX wm_OWCharA
	LDA wm_PlayerBonusStars,X
-	CMP #$0A
	BCC CODE_05CC77
	SBC #$0A
	INY
	BRA -

CODE_05CC77:
	CPY wm_TimerTens
	BNE +
	CPY wm_TimerOnes
	BNE +
	INC wm_GiveLives
+	LDA #$01
	STA wm_L3ScrollFlag
	LDA #$08
	TSB wm_BgMode
	REP #$30
	STZ wm_Bg3HOfs
	STZ wm_Bg3VOfs
	LDY #$004A
	TYA
	CLC
	ADC wm_ImageIndex
	TAX
-	LDA DATA_05CC16,Y
	STA wm_ImageTable,X
	DEX
	DEX
	DEY
	DEY
	BPL -
	LDA wm_ImageIndex
	TAX
	SEP #$20
	LDA wm_OWCharA
	BEQ +
	LDY #$0000
-	LDA DATA_05CC61,Y
	STA wm_ImageTable.3.ImgL,X
	INX
	INX
	INY
	CPY #$0005
	BNE -
+	LDY #$0002
	LDA #$04
	CLC
	ADC wm_ImageIndex
	TAX
-	LDA wm_TimerHundreds,Y
	STA wm_ImageTable.26.ImgL,X
	DEY
	DEX
	DEX
	BPL -
	LDA wm_ImageIndex
	TAX
-	LDA wm_ImageTable.26.ImgL,X
	AND #$0F
	BNE +
	LDA #$FC
	STA wm_ImageTable.26.ImgL,X
	INX
	INX
	CPX #$0004
	BNE -
+	SEP #$10
	JSR CODE_05CE4C
	REP #$20
	STZ m0
	LDA m2
	STA wm_ScoreAdder
	LDX #$42
	LDY #$00
	JSR CODE_05CDFD
	LDX #$00
-	LDA wm_ImageTable.33.ImgL,X
	AND #$000F
	BNE +
	LDA #$38FC
	STA wm_ImageTable.33.ImgL,X
	INX
	INX
	CPX #$08
	BNE -
+	SEP #$20
	INC wm_OWProcessPtr
	LDA #$28
	STA wm_DispBonusStars
	LDA #$4A
	CLC
	ADC wm_ImageIndex
	INC A
	STA wm_ImageIndex
	SEP #$30
	RTS

DATA_05CD3F:	.INCBIN "images/levels/bonus.stim"

DATA_05CD62:
	.DB $B7,$C3,$B8,$B9,$BA,$BB,$BA,$BF
	.DB $BC,$BD,$BE,$BF,$C0,$C3,$C1,$B9
	.DB $C2,$C4,$B7,$C5

CODE_05CD76:
	LDA wm_BonusStarsGained
	BEQ ++
	DEC wm_DispBonusStars
	BPL +++
	LDY #$22
	TYA
	CLC
	ADC wm_ImageIndex
	TAX
-	LDA DATA_05CD3F,Y
	STA wm_ImageTable,X
	DEX
	DEY
	BPL -
	LDA wm_ImageIndex
	TAX
	LDA wm_BonusStarsGained
	AND #$0F
	ASL
	TAY
	LDA DATA_05CD62+1,Y
	STA wm_ImageTable.13.ImgL,X
	LDA DATA_05CD62,Y
	STA wm_ImageTable.17.ImgL,X
	LDA wm_BonusStarsGained
	AND #$F0
	LSR
	LSR
	LSR
	LSR
	BEQ +
	ASL
	TAY
	LDA DATA_05CD62+1,Y
	STA wm_ImageTable.12.ImgL,X
	LDA DATA_05CD62,Y
	STA wm_ImageTable.16.ImgL,X
+	LDA #$22
	CLC
	ADC wm_ImageIndex
	INC A
	STA wm_ImageIndex
++	DEC wm_ScoreDrumroll
	BPL +++
	LDA wm_BonusStarsGained
	STA wm_DispBonusStars
	INC wm_OWProcessPtr
	LDA #$11
	STA wm_SoundCh3
+++	RTS

DATA_05CDE9:
	.DB $00,$00,$10,$27,$00,$00,$E8,$03
	.DB $00,$00,$64,$00,$00,$00,$0A,$00
	.DB $00,$00,$01,$00

CODE_05CDFD:
	LDA wm_ImageIndex,X
	AND.W #$FF00
	STA wm_ImageIndex,X
-	PHX
	TYX
	LDA m2
	SEC
	SBC.W DATA_05CDE9+2,X
	STA m6
	LDA m0
	SBC.W DATA_05CDE9,X
	STA m4
	PLX
	BCC CODE_05CE2F
	LDA m6
	STA m2
	LDA m4
	STA m0
	LDA wm_ImageIndex,X
	INC A
	STA wm_ImageIndex,X
	BRA -

CODE_05CE2F:
	INX
	INX
	INY
	INY
	INY
	INY
	CPY #$14
	BNE CODE_05CDFD
	RTS

DATA_05CE3A:	.DB $00,$00,$64,$00,$C8,$00,$2C,$01

DATA_05CE42:
	.DB $00,$0A,$14,$1E,$28,$32,$3C,$46
	.DB $50,$5A

CODE_05CE4C:
	REP #$20
	LDA wm_TimerHundreds
	ASL
	TAX
	LDA.W DATA_05CE3A,X
	STA m0
	LDA wm_TimerTens
	TAX
	LDA.W DATA_05CE42,X
	AND #$00FF
	CLC
	ADC m0
	STA m0
	LDA wm_TimerOnes
	AND #$00FF
	CLC
	ADC m0
	STA m0
	SEP #$20
	LDA m0
	STA WRMPYA
	LDA #$32
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYL
	STA m2
	LDA RDMPYH
	STA m3
	LDA m1
	STA WRMPYA
	LDA #$32
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYL
	CLC
	ADC m3
	STA m3
	RTS

DATA_05CEA3:	.INCBIN "images/levels/nobonus.stim"

DATA_05CEC2:	.DB $0A,$00,$64,$00

DATA_05CEC6:	.DB $01,$00,$0A,$00

CODE_05CECA:
	PHB
	PHK
	PLB
	REP #$20
	LDX #$00
	LDA wm_OWCharA
	AND #$00FF
	BEQ +
	LDX #$03
+	LDY #$02
	LDA wm_ScoreAdder
	BEQ ++
	CMP #$0063
	BCS +
	LDY #$00
+	SEC
	SBC DATA_05CEC2,Y
	STA wm_ScoreAdder
	STA m2
	LDA DATA_05CEC6,Y
	CLC
	ADC wm_MarioScoreHi,X
	STA wm_MarioScoreHi,X
	LDA wm_MarioScoreLo,X
	ADC #$0000
	STA wm_MarioScoreLo,X
++	LDX wm_BonusStarsGained
	BEQ ++
	SEP #$20
	LDA wm_FrameA
	AND #$03
	BNE +
	LDX wm_OWCharA
	LDA wm_PlayerBonusStars,X
	CLC
	ADC #$01
	STA wm_PlayerBonusStars,X
	LDA wm_BonusStarsGained
	DEC A
	STA wm_BonusStarsGained
	AND #$0F
	CMP #$0F
	BNE +
	LDA wm_BonusStarsGained
	SEC
	SBC #$06
	STA wm_BonusStarsGained
+	REP #$20
++	LDA wm_ScoreAdder
	BNE +
	LDX wm_BonusStarsGained
	BNE +
	LDX #$30
	STX wm_ScoreDrumroll
	INC wm_OWProcessPtr
	LDX #$12
	STX wm_SoundCh3
+	LDY #$1E
	TYA
	CLC
	ADC wm_ImageIndex
	TAX
	INC A
	STA m10
-	LDA DATA_05CEA3,Y
	STA wm_ImageTable,X
	DEX
	DEX
	DEY
	DEY
	BPL -
	LDA wm_ScoreAdder
	BEQ +
	STZ m0
	LDA wm_ImageIndex
	CLC
	ADC #$0006
	TAX
	LDY #$00
	JSR CODE_05CDFD
	LDA wm_ImageIndex
	CLC
	ADC #$0008
	STA m0
	LDA wm_ImageIndex
	TAX
-	LDA wm_ImageTable.3.ImgL,X
	AND #$000F
	BNE +
	LDA #$38FC
	STA wm_ImageTable.3.ImgL,X
	INX
	INX
	CPX m0
	BNE -
+	SEP #$20
	REP #$10
	LDA wm_DispBonusStars
	BEQ +
	LDA wm_ImageIndex
	TAX
	LDA wm_BonusStarsGained
	AND #$0F
	ASL
	TAY
	LDA DATA_05CD62,Y
	STA wm_ImageTable.11.ImgL,X
	LDA DATA_05CD62+1,Y
	STA wm_ImageTable.15.ImgL,X
	LDA wm_BonusStarsGained
	AND #$F0
	LSR
	LSR
	LSR
	BEQ +
	TAY
	LDA DATA_05CD62,Y
	STA wm_ImageTable.10.ImgL,X
	LDA DATA_05CD62+1,Y
	STA wm_ImageTable.14.ImgL,X
+	REP #$20
	SEP #$10
	LDA m10
	STA wm_ImageIndex
	SEP #$30
	PLB
_Return05CFE9:
	RTS

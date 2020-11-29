.INCDIR "images/cutscenes"

CutsceneBG:
@CookieMtn:		.INCBIN "cookiemountain.bin"
@Castle:		.INCBIN "castle.bin"
@Cave:			.INCBIN "cave.bin"
@ChocoIsland:	.INCBIN "chocolateisland.bin"
@Overworld:		.INCBIN "overworld.bin"

Cutscene1:
@Line1:	.INCBIN "1/line1.stim"
@Line2:	.INCBIN "1/line2.stim"
@Line3:	.INCBIN "1/line3.stim"
@Line4:	.INCBIN "1/line4.stim"
@Line5:	.INCBIN "1/line5.stim"
@Line6:	.INCBIN "1/line6.stim"
@Line7:	.INCBIN "1/line7.stim" ; last byte '$FF' used for blank lines

Cutscene2:
@Line1:	.INCBIN "2/line1.stim"
@Line2:	.INCBIN "2/line2.stim"
@Line3:	.INCBIN "2/line3.stim"
@Line4:	.INCBIN "2/line4.stim"
@Line5:	.INCBIN "2/line5.stim"
@Line6:	.INCBIN "2/line6.stim"
@Line7:	.INCBIN "2/line7.stim"
@Line8:	.INCBIN "2/line8.stim"

Cutscene3:
@Line1:	.INCBIN "3/line1.stim"
@Line2:	.INCBIN "3/line2.stim"
@Line3:	.INCBIN "3/line3.stim"
@Line4:	.INCBIN "3/line4.stim"
@Line5:	.INCBIN "3/line5.stim"
@Line6:	.INCBIN "3/line6.stim"
@Line7:	.INCBIN "3/line7.stim"

Cutscene4:
@Line1:	.INCBIN "4/line1.stim"
@Line2:	.INCBIN "4/line2.stim"
@Line3:	.INCBIN "4/line3.stim"
@Line4:	.INCBIN "4/line4.stim"
@Line5:	.INCBIN "4/line5.stim"
@Line6:	.INCBIN "4/line6.stim"
@Line7:	.INCBIN "4/line7.stim"
@Line8:	.INCBIN "4/line8.stim"

Cutscene5:
@Line1:	.INCBIN "5/line1.stim"
@Line2:	.INCBIN "5/line2.stim"
@Line3:	.INCBIN "5/line3.stim"
@Line4:	.INCBIN "5/line4.stim"
@Line5:	.INCBIN "5/line5.stim"
@Line6:	.INCBIN "5/line6.stim"
@Line7:	.INCBIN "5/line7.stim"

Cutscene6:
@Line1:	.INCBIN "6/line1.stim"
@Line2:	.INCBIN "6/line2.stim"
@Line3:	.INCBIN "6/line3.stim"
@Line4:	.INCBIN "6/line4.stim"
@Line5:	.INCBIN "6/line5.stim"
@Line6:	.INCBIN "6/line6.stim"
@Line7:	.INCBIN "6/line7.stim"
@Line8:	.INCBIN "6/line8.stim"

Cutscene7:
@Line1:	.INCBIN "7/line1.stim"
@Line2:	.INCBIN "7/line2.stim"
@Line3:	.INCBIN "7/line3.stim"
@Line4:	.INCBIN "7/line4.stim"
@Line5:	.INCBIN "7/line5.stim"
@Line6:	.INCBIN "7/line6.stim"
@Line7:	.INCBIN "7/line7.stim"
@Line8:	.INCBIN "7/line8.stim"

.INCDIR ""

CODE_0CC94E:
	LDA wm_ScrollTypeL2
	BEQ +
	DEC wm_ScrollTypeL2
	LDA wm_ScrollTypeL2
	AND #$1F
	BNE +
	LDA wm_CutsceneNum
	DEC A
	ASL
	ASL
	ASL
	STA m0
	LDA wm_ScrollTypeL2
	AND #$E0
	LSR
	LSR
	LSR
	LSR
	LSR
	ORA m0
	STA m0
	ASL
	CLC
	ADC m0
	CLC
	ADC #$21
	STA wm_ImageLoader
+	RTS

CODE_0CC97E:
	PHB
	PHK
	PLB
	JSR CODE_0CC94E
	JSR CODE_0CCA8F
	JSR CODE_0CC98C
	PLB
	RTL

CODE_0CC98C:
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_ScrollSpeedL2Y+1
	BEQ +
	DEC wm_ScrollSpeedL2Y+1
+	JSR CODE_0CD803
	LDA wm_CutsceneNum
	DEC A
	JSL ExecutePtr

Ptrs0CC9A5:
	.DW CODE_0CC9B3
	.DW CODE_0CC9CC
	.DW CODE_0CCA2F
	.DW CODE_0CCA04
	.DW CODE_0CC9E0
	.DW CODE_0CCA51
	.DW CODE_0CCA72

CODE_0CC9B3:
	JSR CODE_0CCB5B
	JSR CODE_0CCACE
	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CC9C0:
	.DW CODE_0CCB1C
	.DW CODE_0CD295
	.DW CODE_0CCC51
	.DW CODE_0CD2B2
	.DW CODE_0CCD23
	.DW CODE_0CCFDE

CODE_0CC9CC:
	JSR CODE_0CCACE
	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CC9D6:
	.DW CODE_0CD003
	.DW CODE_0CD2B2
	.DW CODE_0CCD23
	.DW CODE_0CD557
	.DW CODE_0CCFDE

CODE_0CC9E0:
	JSR CODE_0CCB5B
	JSR CODE_0CCACE
	JSR CODE_0CD4F8
	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CC9F0:
	.DW CODE_0CCB1C
	.DW CODE_0CD2D0
	.DW CODE_0CCF72
	.DW CODE_0CCFC5
	.DW CODE_0CD295
	.DW CODE_0CCC51
	.DW CODE_0CD2B2
	.DW CODE_0CCD23
	.DW CODE_0CCFF7
	.DW CODE_0CCFDE

CODE_0CCA04:
	JSR CODE_0CCB5B
	LDA wm_ScrollTypeL1
	BNE +
	LDY #$04
	STY wm_ScrollTimerL2
+	CMP #$07
	BNE +
	JSR CODE_0CCF49
+	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CCA1F:
	.DW CODE_0CCB1C
	.DW CODE_0CD295
	.DW CODE_0CCC51
	.DW CODE_0CD2BD
	.DW CODE_0CCDA1
	.DW CODE_0CD2E6
	.DW CODE_0CCEE2
	.DW CODE_0CCFDE

CODE_0CCA2F:
	JSR CODE_0CD65B
	JSR CODE_0CCACE
	LDA wm_ScrollTypeL1
	CMP #$03
	BEQ +
	JSR CODE_0CD3A6
+	JSR CODE_0CD3F4
	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CCA49:
	.DW CODE_0CD0BC
	.DW CODE_0CD2B2
	.DW CODE_0CCD23
	.DW CODE_0CCFDE

CODE_0CCA51:
	JSR CODE_0CD6EC
	LDA wm_ScrollTimerL1
	BEQ +
	LDX #$30
	LDA #$B0
	STA m0
	LDA #$68
	STA wm_0AF6+91
	JSR CODE_0CCAFD
+	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CCA6E:
	.DW CODE_0CD0C9
	.DW CODE_0CCFDE

CODE_0CCA72:
	LDA wm_ScrollTypeL1
	JSL ExecutePtr

Ptrs0CCA79:
	.DW CODE_0CD0D2
	.DW CODE_0CD108
	.DW CODE_0CD16F
	.DW CODE_0CD19C
	.DW CODE_0CCFDE

DATA_0CCA83:
	.DB $20,$48,$A6,$18,$30,$48,$A8,$18,$28,$58,$8D
	.DB $08

CODE_0CCA8F:
	LDA wm_ScrollSpeedL2X
	BEQ +
	LDY #$00
	TYX
-	LDA DATA_0CCA83,Y
	STA wm_OamSlot.57.XPos,X
	LDA DATA_0CCA83+1,Y
	STA wm_OamSlot.57.YPos,X
	LDA DATA_0CCA83+2,Y
	STA wm_OamSlot.57.Tile,X
	LDA DATA_0CCA83+3,Y
	AND #$CF
	ORA #$20
	STA wm_OamSlot.57.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA DATA_0CCA83+3,Y
	AND #$10
	LSR
	LSR
	LSR
	STA wm_OamSize.57,X
	PLX
	INX
	INX
	INX
	INX
	TXY
	CPY #$0C
	BNE -
+	RTS

CODE_0CCACE:
	LDA wm_ScrollTypeL1
	BNE CODE_0CCADD
	STZ wm_ScrollTimerL1
	LDA #$98
	STA wm_0AF6+91
	BRA Return0CCAFC

CODE_0CCADD:
	LDA wm_ScrollTimerL1
	BEQ Return0CCAFC
	LDA wm_0AF6+91
	CMP #$5C
	BCC +
	LDX #$01
	LDA #$F0
	STA wm_0AF6+30,X
	JSR CODE_0CD368
+	LDX #$30
	LDA #$AB
	STA m0
	BRL CODE_0CCAFD

Return0CCAFC:
	RTS

CODE_0CCAFD:
	LDA m0
	STA wm_OamSlot.33.XPos,X
	LDA wm_0AF6+91
	STA wm_OamSlot.33.YPos,X
	LDA #$E6
	STA wm_OamSlot.33.Tile,X
	LDA #$21
	STA wm_OamSlot.33.Prop,X
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.33,X
	RTS

CODE_0CCB1C:
	LDA wm_ScrollSprNum
	BNE CODE_0CCB30
	LDA #$60
	STA wm_0AF6+90
	LDA #$01
	STA wm_ScrollSprL2
	STZ wm_InitYScrollL1
	BRA _0CCB55

CODE_0CCB30:
	LDX #$00
	LDY #$30
	LDA wm_CutsceneNum
	DEC A
	BNE +
	LDY #$18
+	TYA
	STA wm_0AF6+30,X
	JSR CODE_0CD368
	DEC wm_ScrollSprL2
	BPL _0CCB55
	LDA #$01
	STA wm_ScrollSprL2
	LDA wm_InitYScrollL1
	EOR #$01
	STA wm_InitYScrollL1
_0CCB55:
	JSR CODE_0CCBFA
	BRL CODE_0CCB80

CODE_0CCB5B:
	LDY #$E0
	LDA wm_ScrollSprNum
	BEQ +
	LDY #$E2
+	STY wm_ExOamSlot.1.Tile
	LDA #$39
	STA wm_ExOamSlot.1.Prop
	LDA #$50
	STA wm_ExOamSlot.1.XPos
	LDA #$67
	STA wm_ExOamSlot.1.YPos
	LDA #$02
	STA wm_ExOamSize.1
	RTS

DATA_0CCB7C:	.DB $86,$87,$96,$97

CODE_0CCB80:
	LDX #$60
	LDA wm_ScrollSprNum
	BEQ +
	LDX wm_0AF6+90
+	STX m0
	LDA #$67
	STA m1
	LDX #$14
-	LDA m0
	CMP #$B0
	BCS +
	STA wm_OamSlot.33.XPos,X
	LDA m1
	STA wm_OamSlot.33.YPos,X
	LDA #$E4
	STA wm_OamSlot.33.Tile,X
	LDA #$3F
	STA wm_OamSlot.33.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.33,X
	PLX
+	LDA m0
	CLC
	ADC #$10
	STA m0
	INX
	INX
	INX
	INX
	CPX #$28
	BNE -
	LDA wm_ScrollSprNum
	BEQ _Return0CCBF9
	LDA wm_0AF6+90
	SEC
	SBC #$08
	CMP #$B0
	BCC CODE_0CCBD8
	INC wm_ScrollTypeL1
	BRA _Return0CCBF9

CODE_0CCBD8:
	STA wm_OamSlot.33.XPos,X
	LDA #$6F
	STA wm_OamSlot.33.YPos,X
	LDY #$85
	LDA wm_InitYScrollL1
	BEQ +
	LDY #$95
+	TYA
	STA wm_OamSlot.33.Tile,X
	LDA #$35
	STA wm_OamSlot.33.Prop,X
	TXA
	LSR
	LSR
	TAX
	STZ wm_OamSize.33,X
_Return0CCBF9:
	RTS

CODE_0CCBFA:
	LDX #$04
_0CCBFC:
	LDA #$A8
	STA m0
	STA m2
	LDA #$5F
	STA m1
_0CCC06:
	LDY #$00
-	LDA m0
	STA wm_OamSlot.33.XPos,X
	LDA m1
	STA wm_OamSlot.33.YPos,X
	LDA DATA_0CCB7C,Y
	STA wm_OamSlot.33.Tile,X
	LDA #$2D
	STA wm_OamSlot.33.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_OamSize.33,X
	PLX
	INY
	LDA m0
	CLC
	ADC #$08
	STA m0
	TYA
	AND #$01
	BNE +
	LDA m2
	STA m0
	LDA m1
	CLC
	ADC #$08
	STA m1
+	INX
	INX
	INX
	INX
	CPY #$04
	BNE -
	RTS

DATA_0CCC49:	.DB $03,$01,$03,$01

DATA_0CCC4D:	.DB $93,$73,$FF,$7F

CODE_0CCC51:
	LDA wm_FrameA
	AND #$02
	TAX
	REP #$20
	LDA.W DATA_0CCC4D,X
	STA wm_LvBgColor
	SEP #$20
	DEC wm_InitYScrollL2
	BPL CODE_0CCC82
	JSR CODE_0CD373
	LDX wm_CutsceneNum
	LDA.L CutsceneBgColor-1,X
	ASL
	TAX
	REP #$20
	LDA.L PALETTE_Sky,X
	STA wm_LvBgColor
	SEP #$20
	INC wm_ScrollTypeL1
	BRL _0CCC9A

CODE_0CCC82:
	DEC wm_ScrollSprL2
	BPL +
	LDA wm_InitYScrollL1
	INC A
	AND #$03
	STA wm_InitYScrollL1
	TAX
	LDA.W DATA_0CCC49,X
	STA wm_ScrollSprL2
+	JSR CODE_0CCCB6
_0CCC9A:
	LDX #$1C
	BRL _0CCBFC

DATA_0CCC9F:
	.DB $A0,$A4,$00,$C0,$C4,$00,$A0,$A2
	.DB $A4,$C0,$C2,$C4,$00,$00,$00,$00
	.DB $00,$00

DATA_0CCCB1:	.DB $00,$06,$0C,$06,$0C

CODE_0CCCB6:
	LDA wm_InitYScrollL1
	INC A
	TAX
	LDA.W DATA_0CCCB1,X
	STA m8
	LDY #$A0
	CPX #$00
	BNE +
	LDY #$A8
+	STY m0
	STY m4
	LDA #$57
	STA m2
	LDX #$00
-	LDY m8
	LDA DATA_0CCC9F,Y
	BEQ ++
	STA wm_ExOamSlot.2.Tile,X
	LDY #$35
	LDA wm_InitYScrollL1
	BMI +
	AND #$02
	BEQ +
	LDY #$39
+	TYA
	STA wm_ExOamSlot.2.Prop,X
	LDA m0
	STA wm_ExOamSlot.2.XPos,X
	LDA m2
	STA wm_ExOamSlot.2.YPos,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.2,X
	PLX
++	INC m8
	LDA m0
	CLC
	ADC #$10
	STA m0
	INX
	INX
	INX
	INX
	CPX #$0C
	BNE +
	LDA m4
	STA m0
	LDA m2
	CLC
	ADC #$10
	STA m2
+	CPX #$18
	BNE -
	RTS

CODE_0CCD23:
	LDX #$00
	LDA wm_Bg1VOfs
	CMP #$C0
	BNE CODE_0CCD31
	STZ wm_Bg1HOfs
	STZ wm_Bg1HOfs+1
	BRA _0CCD75

CODE_0CCD31:
	STA wm_0AF6+75,X
	LDA wm_Bg1VOfs+1
	STA wm_0AF6+105,X
	LDA #$F0
	STA wm_0AF6+15,X
	JSR CODE_0CD33A
	JSR CODE_0CD283
	SEP #$20
	LDA wm_0AF6+105,X
	STA wm_Bg1VOfs+1
	LDA wm_0AF6+75,X
	STA wm_Bg1VOfs
	CMP #$FD
	BNE +
	LDA #$01
	STA wm_ScrollTimerL1
+	LDA wm_Bg1VOfs
	CMP #$E8
	BNE +
	JSR _0CD5C9
+	LDA wm_Bg1VOfs
	CMP #$C0
	BNE _0CCD75
	LDA #$22 ; unused sfx 22
	STA wm_SoundCh1
	JSR CODE_0CD1D0
	LDA #$08
	STA wm_0AF6+16
_0CCD75:
	LDX #$01
	LDA wm_0AF6+15,X
	BPL CODE_0CCD85
	LDA wm_0AF6+75,X
	CMP #$68
	BCS CODE_0CCD91
	BRA _0CCD94

CODE_0CCD85:
	LDA wm_0AF6+75,X
	CMP #$78
	BNE CODE_0CCD91
	INC wm_ScrollTypeL1
	BRA _0CCD9E

CODE_0CCD91:
	JSR CODE_0CD33A
_0CCD94:
	LDX #$00
	LDA #$04
	STA wm_0AF6+30,X
	JSR CODE_0CD368
_0CCD9E:
	BRL _0CCE2A

CODE_0CCDA1:
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_ScrollSpeedL1X+1
	CLC
	ADC #$02
	STA wm_ScrollSpeedL1X+1
	CMP #$80
	BCC +
	LDA #$7F
	STA wm_ScrollSpeedL1X+1
+	LDX #$00
	LDA wm_Bg1VOfs
	STA wm_0AF6+75,X
	LDA wm_Bg1VOfs+1
	STA wm_0AF6+105,X
	LDA wm_ScrollSpeedL1X+1
	STA wm_0AF6+15,X
	JSR CODE_0CD33A
	LDA wm_0AF6+75,X
	BEQ +
	CMP #$20
	BCS ++
+	JSR CODE_0CD283
++	LDA wm_0AF6+105,X
	STA wm_Bg1VOfs+1
	LDA wm_0AF6+75,X
	STA wm_Bg1VOfs
	BEQ +
	CMP #$20
	BCC +
	LDA #$08
	STA wm_0AF6+16
+	LDA wm_0AF6+75,X
	BEQ CODE_0CCE02
	CMP #$A8
	BCC CODE_0CCE02
	LDA #$7F
	STA wm_ScrollSprL2
	INC wm_ScrollTypeL1
	BRA _0CCE1E

CODE_0CCE02:
	SEP #$20
	LDX #$01
	LDA wm_0AF6+15,X
	BPL CODE_0CCE14
	LDA wm_0AF6+75,X
	CMP #$68
	BCS _0CCE1B
	BRA _0CCE1E

CODE_0CCE14:
	LDA wm_0AF6+75,X
	CMP #$78
	BCS _0CCE1E
_0CCE1B:
	JSR CODE_0CD33A
_0CCE1E:
	LDA #$77
	SEC
	SBC wm_0AF6+75
	STA wm_0AF6+77
	JSR CODE_0CCEAB
_0CCE2A:
	JSR CODE_0CCE48
	LDX #$14
	LDA #$A8
	STA m0
	STA m2
	LDA #$5F
	SEC
	SBC wm_0AF6+75
	STA m1
	BRL _0CCC06

DATA_0CCE40:	.DB $80,$81,$82,$83,$83,$82,$81,$80

CODE_0CCE48:
	DEC wm_ScrollSprL2
	BPL +
	LDA #$05
	STA wm_ScrollSprL2
	LDA wm_InitYScrollL1
	EOR #$01
	STA wm_InitYScrollL1
+	LDA #$98
	STA m0
	LDY #$21
	LDA wm_InitYScrollL1
	BEQ +
	LDY #$61
+	STY m4
	LDA wm_InitYScrollL1
	ASL
	ASL
	TAY
	LDX #$00
-	LDA m0
	STA wm_ExOamSlot.2.XPos,X
	LDA wm_0AF6+76
	STA wm_ExOamSlot.2.YPos,X
	LDA DATA_0CCE40,Y
	STA wm_ExOamSlot.2.Tile,X
	LDA m4
	STA wm_ExOamSlot.2.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.2,X
	PLX
	LDA m0
	CLC
	ADC #$10
	STA m0
	INY
	INX
	INX
	INX
	INX
	CPX #$10
	BNE -
	RTS

DATA_0CCEA3:	.DB $C6,$C8,$C6,$C8

DATA_0CCEA7:	.DB $25,$25,$65,$65

CODE_0CCEAB:
	LDX #$30
	LDA #$B0
	STA wm_ExOamSlot.1.XPos,X
	LDA wm_0AF6+77
	STA wm_ExOamSlot.1.YPos,X
	LDA wm_FrameA
	AND #$06
	LSR
	TAY
	LDA DATA_0CCEA3,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CCEA7,Y
	STA wm_ExOamSlot.1.Prop,X
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	RTS

DATA_0CCED4:	.DB $02,$FF,$02,$03,$04,$05,$06

DATA_0CCEDB:	.DB $03,$01,$07,$07,$07,$07,$07

CODE_0CCEE2:
	LDA wm_InitYScrollL1
	CMP #$02
	BCS CODE_0CCF0F
	LDA wm_FrameA
	AND #$01
	BEQ +
	LDA wm_InitYScrollL1
	EOR #$01
	STA wm_InitYScrollL1
+	LDX #$02
	JSR CODE_0CD33A
	JSR CODE_0CD368
	LDA wm_0AF6+77
	CMP #$5C
	BCC CODE_0CCF0D
	LDA #$02
	STA wm_InitYScrollL1
	BRA CODE_0CCF0F

CODE_0CCF0D:
	BRA _0CCF38

CODE_0CCF0F:
	DEC wm_ScrollSprL2
	BPL _0CCF38
	LDA wm_ScrollSpeedL1X+1
	INC A
	STA wm_ScrollSpeedL1X+1
	TAX
	LDA.W DATA_0CCED4,X
	STA wm_InitYScrollL1
	LDA.W DATA_0CCEDB,X
	STA wm_ScrollSprL2
	CPX #$01
	BNE +
	LDA #$08
	STA wm_SoundCh1
+	CPX #$06
	BNE _0CCF38
	JSR CODE_0CD5C6
_0CCF38:
	BRL CODE_0CCF49

DATA_0CCF3B:	.DB $B7,$B8,$89,$99,$A9,$B9,$E8

DATA_0CCF42:	.DB $25,$25,$23,$23,$23,$23,$23

CODE_0CCF49:
	LDY wm_InitYScrollL1
	CPY #$FF
	BEQ +
	LDX #$04
	LDA wm_0AF6+92
	STA wm_ExOamSlot.1.XPos,X
	LDA wm_0AF6+77
	STA wm_ExOamSlot.1.YPos,X
	LDA DATA_0CCF3B,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CCF42,Y
	STA wm_ExOamSlot.1.Prop,X
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
+	RTS

CODE_0CCF72:
	DEC wm_ScrollSprL2
	BPL CODE_0CCF8B
	LDA #$03
	STA wm_ScrollSprL2
	INC wm_InitYScrollL1
	LDA wm_InitYScrollL1
	CMP #$04
	BNE CODE_0CCF8B
	INC wm_ScrollTypeL1
	BRA _0CCF90

CODE_0CCF8B:
	LDX #$04
	JSR CODE_0CCFA3
_0CCF90:
	LDX #$08
	LDA #$A8
	STA m0
	STA m2
	LDA #$5F
	STA m1
	BRL _0CCC06

DATA_0CCF9F:	.DB $60,$62,$64,$66

CODE_0CCFA3:
	LDY wm_InitYScrollL1
	LDA DATA_0CCF9F,Y
	STA wm_ExOamSlot.1.Tile,X
	LDY #$21
	STA wm_ExOamSlot.1.Prop,X
	LDA #$AC
	STA wm_ExOamSlot.1.XPos,X
	LDA #$63
	STA wm_ExOamSlot.1.YPos,X
	TXA
	LSR
	LSR
	TAX
	LDA #$02
	STA wm_ExOamSize.1,X
	RTS

CODE_0CCFC5:
	LDA wm_ScrollTimerL2
	CMP #$03
	BEQ CODE_0CCFD3
	LDA #$08
	STA wm_ScrollSprL2
	BRA _0CCFDB

CODE_0CCFD3:
	DEC wm_ScrollSprL2
	BPL _0CCFDB
	INC wm_ScrollTypeL1
_0CCFDB:
	BRL _0CCF90

CODE_0CCFDE:
	LDA wm_ScrollTypeL2
	ORA wm_ScrollSpeedL2Y+1
	BNE +
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	AND #$C0
	BEQ +
	STZ wm_ScrollTypeL1
	LDA #$0B
	STA wm_GameMode
+	RTS

CODE_0CCFF7:
	LDA wm_ScrollTypeL2
	BEQ Return0CD002
	INC wm_ScrollTypeL1
	BRL CODE_0CCFDE

Return0CD002:
	RTS

CODE_0CD003:
	LDA wm_ScrollSprNum
	CMP #$01
	BEQ CODE_0CD034
	CMP #$02
	BEQ CODE_0CD019
	CMP #$03
	BEQ _0CD03E
	LDA #$10
	STA wm_ScrollSprL2
	BRA _0CD046

CODE_0CD019:
	LDA wm_ScrollSprL2
	AND #$F8
	BEQ +
	JSR CODE_0CD069
+	JSR CODE_0CD283
	DEC wm_ScrollSprL2
	BPL _0CD046
	STZ wm_ScrollSprNum
	STZ wm_Bg1HOfs
	STZ wm_Bg1HOfs+1
	BRA _0CD046

CODE_0CD034:
	LDA #$3F
	STA wm_ScrollSprL2
	LDA #$03
	STA wm_ScrollSprNum
_0CD03E:
	DEC wm_ScrollSprL2
	BPL _0CD046
	INC wm_ScrollTypeL1
_0CD046:
	LDX #$A8
	LDA wm_Bg1HOfs
	BEQ _0CD054
	BPL CODE_0CD052
	LDX #$A9
	BRA _0CD054

CODE_0CD052:
	LDX #$A7
_0CD054:
	STX m0
	STX m2
	LDA #$5F
	STA m1
	LDX #$08
	BRL _0CCC06

DATA_0CD061:	.DB $7C,$7D,$7D,$7C

DATA_0CD065:	.DB $30,$30,$F0,$F0

CODE_0CD069:
	LDY #$00
	LDX #$04
	LDA wm_MarioXPos
	CLC
	ADC #$10
	STA m0
	STA m2
	LDA wm_MarioYPos
	CLC
	ADC #$10
	STA m1
-	LDA m0
	STA wm_ExOamSlot.1.XPos,X
	LDA m1
	STA wm_ExOamSlot.1.YPos,X
	LDA DATA_0CD061,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA DATA_0CD065,Y
	STA wm_ExOamSlot.1.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
	PLX
	LDA m0
	CLC
	ADC #$08
	STA m0
	INY
	CPY #$02
	BNE +
	LDA m2
	STA m0
	LDA m1
	CLC
	ADC #$08
	STA m1
+	INX
	INX
	INX
	INX
	CPY #$04
	BNE -
	RTS

CODE_0CD0BC:
	LDA wm_ScrollSprNum
	CMP #$01
	BNE +
	INC wm_ScrollTypeL1
+	BRL _0CCF90

CODE_0CD0C9:
	LDA wm_ScrollSprNum
	BEQ +
	JSR CODE_0CD5C6
+	RTS

CODE_0CD0D2:
	LDA wm_ScrollSprNum
	CMP #$01
	BNE _Return0CD107
	LDX #$00
	LDA wm_Bg1VOfs
	STA wm_0AF6+75,X
	LDA wm_Bg1VOfs+1
	STA wm_0AF6+105,X
	LDA #$08
	STA wm_0AF6+15,X
	JSR CODE_0CD33A
	LDA wm_0AF6+75,X
	BEQ CODE_0CD100
	CMP #$09
	BCC CODE_0CD100
	INC wm_ScrollTypeL1
	LDA #$28
	STA wm_ScrollSpeedL1X+1
	BRA _Return0CD107

CODE_0CD100:
	STA wm_Bg1VOfs
	LDA wm_0AF6+105,X
	STA wm_Bg1VOfs+1
_Return0CD107:
	RTS

CODE_0CD108:
	LDA wm_ScrollSprNum
	CMP #$02
	BNE _Return0CD16E
	DEC wm_ScrollSpeedL1X+1
	LDA wm_ScrollSpeedL1X+1
	BMI +
	CMP #$24
	BCC +
	JSR CODE_0CD069
+	LDA wm_ScrollSpeedL1X+1
	CMP #$C8
	BNE CODE_0CD133
	LDA #$40
	STA wm_ScrollSprL2
	LDA #$1A
	STA wm_SoundCh3
	INC wm_ScrollTypeL1
	RTS

CODE_0CD133:
	LDX #$00
	LDA wm_Bg1VOfs
	STA wm_0AF6+75,X
	LDA wm_Bg1VOfs+1
	STA wm_0AF6+105,X
	LDA wm_Bg1HOfs
	STA wm_0AF6+90,X
	LDA wm_Bg1HOfs+1
	STA wm_0AF6+120,X
	LDA wm_ScrollSpeedL1X+1
	STA wm_0AF6+15,X
	LDA #$E8
	STA wm_0AF6+30,X
	JSR CODE_0CD33A
	JSR CODE_0CD368
	LDA wm_0AF6+75,X
	STA wm_Bg1VOfs
	LDA wm_0AF6+105,X
	STA wm_Bg1VOfs+1
	LDA wm_0AF6+90,X
	STA wm_Bg1HOfs
	LDA wm_0AF6+120,X
	STA wm_Bg1HOfs+1
_Return0CD16E:
	RTS

CODE_0CD16F:
	LDA wm_FrameA
	AND #$02
	BEQ CODE_0CD183
	REP #$20
	LDA wm_Bg2VOfs
	SEC
	SBC #$0001
	STA wm_Bg2VOfs
	SEP #$20
	BRA _0CD18F

CODE_0CD183:
	REP #$20
	LDA wm_Bg2VOfs
	CLC
	ADC #$0001
	STA wm_Bg2VOfs
	SEP #$20
_0CD18F:
	DEC wm_ScrollSprL2
	BPL +
	STZ wm_Bg2VOfs
	STZ wm_Bg2VOfs+1
	INC wm_ScrollTypeL1
+	RTS

CODE_0CD19C:
	LDA wm_ScrollSprNum
	CMP #$03
	BNE +
	JSR CODE_0CD5C6
+	RTS

DATA_0CD1A7:
	.DB $20,$B3,$00,$0F,$C0,$01,$C1,$01
	.DB $C2,$01,$C3,$01,$C4,$01,$C5,$01
	.DB $C1,$41,$C0,$41,$20,$D3,$00,$0F
	.DB $D0,$01,$D1,$01,$D2,$01,$D3,$01
	.DB $D4,$01,$D5,$01,$D1,$41,$D0,$41
	.DB $FF

CODE_0CD1D0:
	LDY #$28
	TYA
	CLC
	ADC wm_ImageIndex
	TAX
-	LDA DATA_0CD1A7,Y
	STA wm_ImageTable,X
	DEX
	DEY
	BPL -
	LDA #$28
	CLC
	ADC wm_ImageIndex
	STA wm_ImageIndex
	RTS

DATA_0CD1F0:
	.DB $20,$F4,$40,$02,$F8,$00,$21,$14
	.DB $40,$02,$F8,$00,$FF

DATA_0CD1FD:
	.DB $20,$F4,$21,$14,$21,$34,$21,$54
	.DB $21,$74,$21,$94,$21,$B4,$21,$D4
	.DB $20,$F6,$21,$16,$21,$36,$21,$56
	.DB $21,$76,$21,$96,$21,$B6,$21,$D6
	.DB $20,$F8,$21,$18,$21,$38,$21,$58
	.DB $21,$78,$21,$98,$21,$B8,$21,$D8

CODE_0CD22D:
	LDA wm_ImageIndex
	STA m1
	LDY #$0C
	TYA
	CLC
	ADC wm_ImageIndex
	TAX
-	LDA DATA_0CD1F0,Y
	STA wm_ImageTable,X
	DEX
	DEY
	BPL -
	LDA #$0C
	CLC
	ADC wm_ImageIndex
	STA wm_ImageIndex
	LDA wm_MarioXPos
	SEC
	SBC #$A0
	STA m0
	LDA wm_ScrollSpeedL1X
	SEC
	SBC #$38
	LSR
	LSR
	CLC
	ADC m0
	TAY
	LDX m1
	REP #$20
	LDA DATA_0CD1FD,Y
	STA wm_ImageTable,X
	LDA DATA_0CD1FD+2,Y
	STA wm_ImageTable.4.ImgL,X
	SEP #$20
	CPY #$1C
	BNE +
	LDA #$01
	STA wm_ScrollTimerL1
+	RTS

CODE_0CD283:
	REP #$20
	LDA wm_FrameA
	AND #$0001
	BEQ CODE_0CD290
	INC wm_Bg1HOfs
	BRA _0CD292

CODE_0CD290:
	DEC wm_Bg1HOfs
_0CD292:
	SEP #$20
	RTS

CODE_0CD295:
	LDA #$1A
	STA wm_SoundCh3
	LDA #$FF
	STA wm_InitYScrollL1
	LDA #$30
	STA wm_InitYScrollL2
	LDA #$01
	STA wm_ScrollSprL2
	INC wm_ScrollTypeL1
	JSR CODE_0CCBFA
	BRL CODE_0CCC51

CODE_0CD2B2:
	LDA #$21
	STA wm_SoundCh1
	JSR CODE_0CD31A
	BRL CODE_0CCD23

CODE_0CD2BD:
	LDA #$17
	STA wm_SoundCh3
	LDA #$77
	STA wm_0AF6+77
	STZ wm_ScrollSpeedL1X+1
	JSR CODE_0CD31A
	BRL CODE_0CCDA1

CODE_0CD2D0:
	LDA #$03
	STA wm_ScrollSprL2
	STZ wm_InitYScrollL1
	LDA #$19
	STA wm_SoundCh3
	INC wm_ScrollTypeL1
	JSR CODE_0CCBFA
	BRL CODE_0CCF72

CODE_0CD2E6:
	DEC wm_ScrollSprL2
	BMI CODE_0CD2EC
	RTS

CODE_0CD2EC:
	JSR CODE_0CD373
	LDA #$0F
	STA wm_0AF6+77
	STZ wm_0AF6+107
	LDA #$90
	STA wm_0AF6+92
	STZ wm_0AF6+122
	LDA #$08
	STA wm_0AF6+17
	LDA #$FF
	STA wm_0AF6+32
	LDA #$02
	STA wm_ScrollSprL2
	STZ wm_InitYScrollL1
	STZ wm_ScrollSpeedL1X+1
	INC wm_ScrollTypeL1
	BRL CODE_0CCEE2

CODE_0CD31A:
	LDA #$77
	STA wm_0AF6+76
	LDA #$5F
	STA wm_0AF6+90
	LDA #$F8
	STA wm_0AF6+16
	STZ wm_InitYScrollL1
	LDA #$05
	STA wm_ScrollSprL2
	INC wm_ScrollTypeL1
	JSR CODE_0CD373
	BRL CODE_0CCBFA

CODE_0CD33A:
	LDA wm_0AF6+15,X
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_0AF6+45,X
	STA wm_0AF6+45,X
	PHP
	LDA wm_0AF6+15,X
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
	ADC wm_0AF6+75,X
	STA wm_0AF6+75,X
	TYA
	ADC wm_0AF6+105,X
	STA wm_0AF6+105,X
	RTS

CODE_0CD368:
	PHX
	TXA
	CLC
	ADC #$0F
	TAX
	JSR CODE_0CD33A
	PLX
	RTS

CODE_0CD373:
	STZ wm_0AF6+45
	STZ wm_0AF6+60
	STZ wm_0AF6+46
	STZ wm_0AF6+61
	STZ wm_0AF6+62
	STZ wm_0AF6+62
	RTS

DATA_0CD386:
	.DB $C8,$C0,$C4,$C8,$C0,$B4,$C8,$B8
	.DB $C6,$B7,$C4,$B0,$C8,$C0,$C8,$C4

DATA_0CD396:
	.DB $18,$F8,$0A,$20,$E8,$1A,$EA,$08
	.DB $F0,$18,$E0,$2A,$F8,$20,$FA,$18

CODE_0CD3A6:
	LDA wm_ScrollTimerL2
	DEC A
	CMP #$E7
	BCS _Return0CD3F3
	LDA wm_FrameA
	AND #$01
	BNE _Return0CD3F3
	LDX #$0E
_0CD3B6:
	LDA wm_0AF6+150,X
	BNE CODE_0CD3EE
	LDA #$01
	STA wm_0AF6+150,X
	LDA #$04
	STA wm_0AF6+135,X
	LDA.W DATA_0CD386,X
	STA wm_0AF6+15,X
	LDA.W DATA_0CD396,X
	STA wm_0AF6+30,X
	LDA wm_MarioXPos
	CLC
	ADC #$18
	STA wm_0AF6+90,X
	LDA wm_MarioYPos
	CLC
	ADC #$20
	STA wm_0AF6+75,X
	LDA wm_FrameA
	AND #$02
	BNE _Return0CD3F3
	LDA #$07
	STA wm_SoundCh3
	BRA _Return0CD3F3

CODE_0CD3EE:
	DEX
	CPX #$03
	BNE _0CD3B6
_Return0CD3F3:
	RTS

CODE_0CD3F4:
	LDX #$0E
-	LDA wm_0AF6+150,X
	BEQ +++
	LDA wm_0AF6+15,X
	BMI +
	CMP #$40
	BCS ++
+	CLC
	ADC wm_0AF6+135,X
	STA wm_0AF6+15,X
++	JSR CODE_0CD33A
	JSR CODE_0CD368
	LDA wm_0AF6+75,X
	CMP #$80
	BCC +++
	STZ wm_0AF6+150,X
+++	DEX
	CPX #$03
	BNE -
	BRL CODE_0CD425

DATA_0CD423:	.DB $3C,$3D

CODE_0CD425:
	LDY #$0E
	LDX #$14
-	LDA wm_0AF6+150,Y
	BEQ +
	LDA wm_0AF6+90,Y
	CMP #$50
	BCC +
	STA wm_ExOamSlot.1.XPos,X
	LDA wm_0AF6+75,Y
	STA wm_ExOamSlot.1.YPos,X
	PHY
	LDA wm_FrameA
	AND #$02
	LSR
	TAY
	LDA DATA_0CD423,Y
	STA wm_ExOamSlot.1.Tile,X
	PLY
	LDA #$22
	STA wm_ExOamSlot.1.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
	PLX
+	INX
	INX
	INX
	INX
	DEY
	CPY #$03
	BNE -
	RTS

DATA_0CD464:
	.DB $F8,$80,$80,$80,$FA,$80,$80,$80
	.DB $FA,$FC,$80,$80,$FA,$FC,$04,$80
	.DB $F8,$80,$80,$80,$F9,$80,$80,$80
	.DB $FA,$80,$80,$80,$FA,$80,$80,$80

DATA_0CD484:
	.DB $08,$80,$80,$80,$09,$80,$80,$80
	.DB $09,$FF,$80,$80,$09,$FF,$F6,$80
	.DB $04,$80,$80,$80,$00,$80,$80,$80
	.DB $FF,$80,$80,$80,$00,$80,$80,$80

CODE_0CD4A4:
	PHB
	PHK
	PLB
	LDX #$00
	LDA wm_MarioPowerUp
	BNE +
	LDX #$08
+	STX m2
	LDX #$40
	LDA #$02
	STA m0
	LDA wm_ScrollTimerL2
	ASL
	ASL
	TAY
-	LDA DATA_0CD484,Y
	CMP #$80
	BEQ +
	CLC
	ADC wm_MarioXPos
	STA wm_ExOamSlot.1.XPos,X
	LDA DATA_0CD464,Y
	CLC
	ADC wm_MarioYPos
	CLC
	ADC m2
	STA wm_ExOamSlot.1.YPos,X
	LDA #$B6
	STA wm_ExOamSlot.1.Tile,X
	LDA #$31
	STA wm_ExOamSlot.1.Prop,X
	PHX
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
	PLX
	INX
	INX
	INX
	INX
+	INY
	DEC m0
	BPL -
	PLB
	RTL

DATA_0CD4F4:	.DB $89,$99,$A9,$B9

CODE_0CD4F8:
	LDA wm_ScrollSpeedL1X
	BNE CODE_0CD502
	STZ wm_0AF6+77
	BRA _Return0CD556

CODE_0CD502:
	LDX #$02
	LDA #$FD
	STA wm_0AF6+15,X
	JSR CODE_0CD33A
	LDA wm_0AF6+75,X
	EOR #$FF
	INC A
	CMP #$0D
	BCC CODE_0CD51B
	STZ wm_ScrollSpeedL1X
	BRA _Return0CD556

CODE_0CD51B:
	LDX #$00
	LDA wm_MarioPowerUp
	BNE +
	LDX #$08
+	STX m0
	LDX #$34
	LDA #$04
	CLC
	ADC wm_MarioXPos
	STA wm_ExOamSlot.1.XPos,X
	LDA wm_0AF6+77
	CLC
	ADC wm_MarioYPos
	CLC
	ADC m0
	STA wm_ExOamSlot.1.YPos,X
	LDA wm_0AF6+77
	EOR #$FF
	INC A
	LSR
	LSR
	TAY
	LDA DATA_0CD4F4,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA #$33
	STA wm_ExOamSlot.1.Prop,X
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
_Return0CD556:
	RTS

CODE_0CD557:
	LDA wm_ScrollSpeedL1X
	BNE CODE_0CD564
	STZ wm_0AF6+78
	STZ wm_0AF6+93
	BRA _Return0CD5C5

CODE_0CD564:
	LDX #$03
	LDA #$06
	STA wm_0AF6+30,X
	LDA #$01
	STA wm_0AF6+15,X
	JSR CODE_0CD33A
	JSR CODE_0CD368
	LDA wm_0AF6+90,X
	CMP #$0D
	BCC CODE_0CD585
	STZ wm_ScrollSpeedL1X
	INC wm_ScrollTypeL1
	BRA _Return0CD5C5

CODE_0CD585:
	LDX #$0F
	LDY #$0C
	LDA wm_MarioPowerUp
	BNE +
	LDX #$13
+	STX m0
	STY m1
	LDX #$34
	LDA wm_0AF6+93
	CLC
	ADC wm_MarioXPos
	CLC
	ADC m1
	STA wm_ExOamSlot.1.XPos,X
	LDA wm_0AF6+78
	CLC
	ADC wm_MarioYPos
	CLC
	ADC m0
	STA wm_ExOamSlot.1.YPos,X
	LDA wm_0AF6+93
	LSR
	LSR
	TAY
	LDA DATA_0CD4F4,Y
	STA wm_ExOamSlot.1.Tile,X
	LDA #$33
	STA wm_ExOamSlot.1.Prop,X
	TXA
	LSR
	LSR
	TAX
	STZ wm_ExOamSize.1,X
_Return0CD5C5:
	RTS

CODE_0CD5C6:
	INC wm_ScrollTypeL1
_0CD5C9:
	LDA #$FF
	STA wm_ScrollTypeL2
	LDA #$D0
	STA wm_ScrollSpeedL2Y+1
	LDA #$13
	STA wm_MusicCh1
	RTS

DATA_0CD5D9:
	.DB $35,$36,$36,$36,$37,$37,$37,$37
	.DB $37,$37,$37,$36,$36,$35,$35,$35

DATA_0CD5E9:
	.DB $8B,$8B,$8B,$AA,$8A,$CE,$CE,$8A
	.DB $8A,$AA,$AA,$8A,$AA,$8A,$CE,$8A
	.DB $AA,$8A,$8A

DATA_0CD5FC:
	.DB $61,$61,$61,$61,$61,$61,$61,$21
	.DB $21,$21,$21,$A1,$21,$21,$61,$61
	.DB $61,$E1,$E1

DATA_0CD60F:
	.DB $FA,$FA,$F9,$FB,$F9,$FA,$F0,$F0
	.DB $F4,$F4,$FD,$FF,$FD,$FF,$0A,$0D
	.DB $0A,$0D,$0E,$10,$0E,$10,$0D,$0E
	.DB $0E,$10,$0A,$0D,$FD,$FF,$F4,$F4
	.DB $F0,$F0,$F3,$F0,$F3,$F0

DATA_0CD635:
	.DB $06,$03,$07,$00,$07,$01,$0D,$08
	.DB $02,$FB,$FF,$F6,$FF,$F6,$03,$FD
	.DB $03,$FD,$0A,$06,$0A,$06,$12,$0F
	.DB $0A,$06,$03,$FD,$FF,$F6,$02,$FB
	.DB $0D,$08,$15,$10,$15,$10

CODE_0CD65B:
	LDA wm_ScrollSpeedL2X
	LSR
	BEQ _Return0CD6C3
	LDA wm_ScrollTimerL2
	BNE CODE_0CD66B
	LDX wm_PlayerWalkPose
	BRA _0CD680

CODE_0CD66B:
	DEC wm_ScrollTimerL2
	CMP #$F0
	BCC +
	LDA #$0F
+	AND #$0F
	CLC
	ADC #$03
	TAX
	LDA.W DATA_0CD5D9-3,X
	STA wm_MarioFrame
_0CD680:
	LDY #$00
	LDA.W DATA_0CD5E9,X
	LSR
	BCC +
	LDY #$30
+	ASL
	STA wm_ExOamSlot.64.Tile,Y
	LDA wm_MarioDirection
	LSR
	ROR
	LSR
	EOR.W DATA_0CD5FC,X
	STA wm_ExOamSlot.64.Prop,Y
	TXA
	ASL
	TAX
	LDA wm_MarioPowerUp
	BEQ +
	INX
+	LDA wm_MarioYPos
	CLC
	ADC.W DATA_0CD635,X
	STA wm_ExOamSlot.64.YPos,Y
	LDA.W DATA_0CD60F,X
	LDX wm_MarioDirection
	BNE +
	EOR #$FF
	INC A
+	CLC
	ADC wm_MarioXPos
	STA wm_ExOamSlot.64.XPos,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.64,Y
_Return0CD6C3:
	RTS

DATA_0CD6C4:	.DB $E7,$E6,$E6,$EA,$E6,$E7

DATA_0CD6CA:	.DB $F6,$F1,$F3,$F3,$F3,$F4

DATA_0CD6D0:	.DB $1B,$0E,$00

DATA_0CD6D3:	.DB $15,$08,$00

DATA_0CD6D6:	.DB $8E,$8E,$8C

DATA_0CD6D9:	.DB $FC,$04,$FC,$04,$FC,$04,$FC

DATA_0CD6E0:	.DB $34,$68,$34,$68,$34

DATA_0CD6E5:	.DB $68,$34,$B0,$00,$C0,$00,$C0

CODE_0CD6EC:
	LDA wm_ScrollSpeedL2X
	LSR
	BEQ ++
	LDY #$04
	LDA #$02
-	STA wm_OamSize.17,Y
	DEY
	BPL -
	LDA wm_ScrollSpeedL1X
	BNE CODE_0CD752
	LDA wm_PlayerWalkPose
	ASL
	LDY wm_MarioPowerUp
	BEQ +
	INC A
+	TAY
	LDA DATA_0CD6C4,Y
	STA m0
	LDA DATA_0CD6CA,Y
	STA m1
	LDA wm_MarioDirection
	LSR
	ROR
	LSR
	EOR #$61
	STA m2
	LDX #$02
-	TXA
	ASL
	ASL
	TAY
	LDA m0
	CLC
	ADC.W DATA_0CD6D0,X
	BIT m2
	BVC +
	EOR #$FF
	INC A
+	CLC
	ADC wm_MarioXPos
	STA wm_OamSlot.17.XPos,Y
	LDA m1
	CLC
	ADC.W DATA_0CD6D3,X
	CLC
	ADC wm_MarioYPos
	STA wm_OamSlot.17.YPos,Y
	LDA.W DATA_0CD6D6,X
	STA wm_OamSlot.17.Tile,Y
	LDA m2
	STA wm_OamSlot.17.Prop,Y
	DEX
	BPL -
++	RTS

CODE_0CD752:
	AND #$07
	BNE +
	JSR CODE_0CD22D
+	LDY #$25
	LDA wm_ScrollSpeedL1X
	CMP #$4C
	BCC +
	LDY #$38
+	STY wm_MarioFrame
	LDY #$00
	DEC A
	STA m0
	LDA #$AC
-	STA wm_OamSlot.17.Tile,Y
	LDA #$21
	STA wm_OamSlot.17.Prop,Y
	LDA wm_MarioXPos
	STA wm_OamSlot.17.XPos,Y
	LDA m0
	STA wm_OamSlot.17.YPos,Y
	CLC
	ADC #$10
	CMP #$68
	BCC +
	LDA #$68
+	STA m0
	INY
	INY
	INY
	INY
	LDA #$AE
	CPY #$14
	BCC -
	LDX wm_ScrollTimerL2
	LDA wm_ScrollSpeedL1X
	CMP.W DATA_0CD6E0,X
	BNE CODE_0CD7DE
	LDA wm_ScrollSpeedL1Y+1
	BEQ CODE_0CD7A9
	DEC wm_ScrollSpeedL1Y+1
	RTS

CODE_0CD7A9:
	TXA
	BEQ CODE_0CD7C9
	LSR
	BCS CODE_0CD7C9
	LDA wm_FrameA
	AND #$04
	BEQ +
	LDA #$39
	STA wm_MarioFrame
+	LDA wm_MarioXPos
	CMP.W DATA_0CD6E5,X
	BEQ CODE_0CD7C9
	INC A
	STA wm_MarioXPos
	AND #$0F
	BEQ _0CD7E5
	RTS

CODE_0CD7C9:
	INC wm_ScrollTimerL2
	CPX #$06
	BCC CODE_0CD7D4
	STZ wm_ScrollSpeedL1X
	RTS

CODE_0CD7D4:
	TXA
	LSR
	BCS +
	LDA #$0F
	STA wm_SoundCh1
+	RTS

CODE_0CD7DE:
	CLC
	ADC.W DATA_0CD6D9,X
	STA wm_ScrollSpeedL1X
_0CD7E5:
	LDA #$10
	STA wm_ScrollSpeedL1Y+1
	RTS

DATA_0CD7EB:	.DB $F7,$F6

DATA_0CD7ED:	.DB $63,$5F,$62,$5F,$62,$5E

DATA_0CD7F3:
	.DB $67,$66,$65,$65,$64,$64,$64,$64
	.DB $64,$64,$64,$64,$65,$65,$66,$67

CODE_0CD803:
	LDX wm_ScrollSpeedL2X
	BNE _0CD83D
	LDA wm_PickUpImgTimer
	BEQ CODE_0CD812
	LSR
	BEQ _0CD849
	BRA _0CD84F

CODE_0CD812:
	LDY wm_MarioPowerUp
	BEQ +
	LDY #$01
+	LDA wm_MarioXPos
	CLC
	ADC DATA_0CD7EB,Y
	STA wm_ScrollSpeedL2Y
	TYA
	LSR
	LDA wm_PlayerWalkPose
	ROL
	TAY
	LDA DATA_0CD7ED,Y
	LDY wm_MarioXPos
	CPY #$40
	BCS ++
	LDY wm_MarioSpeedX
	BNE ++
	LDA #$10
	STA wm_PickUpImgTimer
	STZ wm_IsCarrying2
_0CD83D:
	LDA #$05
	CMP wm_MarioXPos
	BCC +
	STA wm_MarioXPos
	LDA wm_MarioSpeedX
	BMI +
_0CD849:
	INC wm_ScrollSpeedL2X
+	INC wm_ScrollSpeedL2X+1
_0CD84F:
	LDA wm_ScrollSpeedL2X+1
	AND #$0F
	TAY
	LDA DATA_0CD7F3,Y
++	STA wm_OamSlot.33.YPos
	LDA wm_ScrollSpeedL2Y
	STA wm_OamSlot.33.XPos
	STZ wm_OamSlot.33.Tile
	LDA #$21
	STA wm_OamSlot.33.Prop
	LDA #$02
	STA wm_OamSize.33
	RTS

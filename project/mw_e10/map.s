DATA_048000:
.REPEAT 3 INDEX COUNT
	.DW (wm_OwGfxBuf+$18*(COUNT+16))&$FFFF
.ENDR

DATA_048006:
.REPEAT 64 INDEX COUNT
	.DW (wm_OwGfxBuf+$18*COUNT)&$FFFF
.ENDR

CODE_048086:
	REP #$30
	STZ m3
	STZ m5
-	LDX m3
	LDA.W DATA_048000,X
	STA m0
	SEP #$10
	LDY #wm_OwGfxBuf>>16
	STY m2
	REP #$10
	LDX m5
	JSR CODE_0480B9
	LDA m5
	CLC
	ADC #$0020
	STA m5
	LDA m3
	INC A
	INC A
	STA m3
	AND #$00FF
	CMP #$0006
	BNE -
	SEP #$30
	RTS

CODE_0480B9:
	LDY.W #$0000
	LDA.W #$0008
	STA m7
	STA m9
-	LDA [m0],Y
	STA wm_0AF6,X
	INY
	INY
	INX
	INX
	DEC m7
	BNE -
-	LDA [m0],Y
	AND.W #$00FF
	STA wm_0AF6,X
	INY
	INX
	INX
	DEC m9
	BNE -
	RTS

OW_Tile_Animation:
	LDA wm_FrameA
	AND #$07
	BNE _048101
	LDX #$1F
_0480E8:
	LDA wm_0AF6,X
	STA m0
	TXA
	AND #$08
	BNE CODE_0480F9
	ASL m0
	ROL wm_0AF6,X
	BRA _0480FE

CODE_0480F9:
	LSR m0
	ROR wm_0AF6,X
_0480FE:
	DEX
	BPL _0480E8
_048101:
	LDA wm_FrameA
	AND #$07
	BNE +
	LDX #$20
	JSR CODE_048172
+	LDA wm_FrameA
	AND #$07
	BNE +
	LDX #$1F
-	LDA wm_0AF6+64,X
	ASL
	ROL wm_0AF6+64,X
	DEX
	BPL -
	LDX #$40
	JSR CODE_048172
+	REP #$30
	LDA #$0060
	STA m13
	STZ m11
-	LDX #$0038
	LDA m11
	CMP #$0020
	BCS +
	LDX #$0070
+	TXA
	AND wm_FrameA
	LSR
	LSR
	CPX #$0038
	BEQ +
	LSR
+	CLC
	ADC m11
	TAX
	LDA.W DATA_048006,X
	STA m0
	SEP #$10
	LDY #wm_OwGfxBuf>>16
	STY m2
	REP #$10
	LDX m13
	JSR CODE_0480B9
	LDA m13
	CLC
	ADC #$0020
	STA m13
	LDA m11
	CLC
	ADC #$0010
	STA m11
	CMP #$0080
	BNE -
	SEP #$30
	RTS

CODE_048172:
	REP #$20
	LDY #$00
-	PHX
	TXA
	CLC
	ADC #$000E
	TAX
	LDA wm_0AF6,X
	STA m0
	PLX
--	LDA wm_0AF6,X
	STA m2
	LDA m0
	STA wm_0AF6,X
	LDA m2
	STA m0
	INX
	INX
	INY
	CPY #$08
	BEQ -
	CPY #$10
	BNE --
	SEP #$20
	RTS

DATA_04819F:	.INCBIN "images/overworld/scrollarrows.stim"

DATA_0481E0:	.INCBIN "images/overworld/noscrollarrows.stim"

DATA_048211:
	.DB $00,$00,$02,$00,$FE,$FF,$02,$00
	.DB $00,$00,$02,$00,$FE,$FF,$02,$00

DATA_048221:
	.DB $00,$00,$11,$01,$EF,$FF,$11,$01
	.DB $00,$00,$32,$01,$D7,$FF,$32,$01

DATA_048231:
	.DB $0F,$0F,$07,$07,$07,$03,$03,$03
	.DB $01,$01,$03,$03,$03,$07,$07,$07

GameMode_0E_Prim:
	PHB
	PHK
	PLB
	LDX #$01
-	LDA wm_JoyFrameAP1,X
	AND #$20
.IFDEF dbg_SelectYoshi
	BEQ ++
.ELSE
	BRA ++
.ENDIF
	LDA wm_PlyrYoshiColor,X
	INC A
	INC A
	CMP #$04
	BCS +
	LDA #$04
+	CMP #$0B
	BCC +
	LDA #$00
+	STA wm_PlyrYoshiColor,X
++	DEX
	BPL -
	JSR _0485A7
	JSR OW_Tile_Animation
	LDA wm_SwitchPalaceCol
	BEQ CODE_048275
	JSR CODE_04F290
	JMP _04840D

CODE_048275:
	LDA wm_ShowEndMenu
	BEQ CODE_048281
	JSL CODE_009B80
	JMP _048410

CODE_048281:
	LDA wm_OWPromptTrig
	BEQ CODE_048295
	CMP #$05
	BCS +
	LDY wm_2PlayerGame
	BEQ CODE_048295
+	JSR CODE_04F3E5
	JMP _048413

CODE_048295:
	LDA wm_PauseLookFlag
	LSR
	BNE CODE_04829E
	JMP CODE_048356

CODE_04829E:
	REP #$20
	LDA wm_OWScrollY
	SEC
	SBC wm_Bg1VOfs
	STA m1
	BPL +
	EOR #$FFFF
	INC A
+	LSR
	SEP #$20
	STA m5
	REP #$20
	LDA wm_OWScrollX
	SEC
	SBC wm_Bg1HOfs
	STA m0
	BPL +
	EOR #$FFFF
	INC A
+	LSR
	SEP #$20
	STA m4
	LDX #$01
	CMP m5
	BCS +
	DEX
	LDA m5
+	CMP #$02
	BCS CODE_0482ED
	REP #$20
	LDA wm_OWScrollX
	STA wm_Bg1HOfs
	STA wm_Bg2HOfs
	LDA wm_OWScrollY
	STA wm_Bg1VOfs
	STA wm_Bg2VOfs
	SEP #$20
	STZ wm_PauseLookFlag
	JMP _0483BD

CODE_0482ED:
	STZ WRDIVL
	LDY m4,X
	STY WRDIVH
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
	SEP #$20
	LDY m1,X
	BPL +
	EOR #$FF
	INC A
+	STA m1,X
	TXA
	EOR #$01
	TAX
	LDA #$40
	LDY m1,X
	BPL +
	LDA #$C0
+	STA m1,X
	LDY #$01
-	TYA
	ASL
	TAX
	LDA.W m1,Y
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_OWL1XAcc,Y
	STA wm_OWL1XAcc,Y
	LDA.W m1,Y
	PHY
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
+	ADC wm_Bg1HOfs,X
	STA wm_Bg1HOfs,X
	STA wm_Bg2HOfs,X
	TYA
	ADC wm_Bg1HOfs+1,X
	STA wm_Bg1HOfs+1,X
	STA wm_Bg2HOfs+1,X
	PLY
	DEY
	BPL -
	JMP _04840D

CODE_048356:
	LDA wm_OWProcessPtr
	CMP #$03
	BEQ +
	CMP #$04
	BNE ++
	LDA wm_OWIsSwitching
	BNE ++
+	LDA wm_JoyFrameBP1
	ORA wm_JoyFrameBP2
	AND #$30
	BEQ +
	LDA #$01
	STA wm_OWPromptTrig
+	LDX wm_OWCharA
	LDA wm_MapData.MarioMap,X
	BNE ++
	LDA wm_JoyFrameA
	AND #$10
	BEQ ++
	INC wm_PauseLookFlag
	LDA wm_PauseLookFlag
	LSR
	BNE ++
	REP #$20
	LDA wm_Bg1HOfs
	STA wm_OWScrollX
	LDA wm_Bg1VOfs
	STA wm_OWScrollY
	SEP #$20
++	LDA wm_PauseLookFlag
	BEQ CODE_0483C3
	LDX #$00
	LDA wm_JoyPadA
	AND #$03
	ASL
	JSR CODE_048415
	LDX #$02
	LDA wm_JoyPadA
	AND #$0C
	ORA #$10
	LSR
	JSR CODE_048415
	LDY #$15
	LDA wm_FrameA
	AND #$18
	BNE +
_0483BD:
	LDY #$18
+	STY wm_ImageLoader
	BRA _04840D

CODE_0483C3:
	LDX wm_OWBowserTimer
	BEQ CODE_04840A
	CPX #$FE
	BNE +
	LDA #$21
	STA wm_SoundCh1
	LDA #$08
	STA wm_MusicCh1
+	TXA
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA wm_FrameA
	AND DATA_048231,Y
	BNE +
	LDA wm_Bg1HOfs
	EOR #$01
	STA wm_Bg1HOfs
	STA wm_Bg2HOfs
	LDA wm_Bg1VOfs
	EOR #$01
	STA wm_Bg1VOfs
	STA wm_Bg2VOfs
+	CPX #$80
	BCS +
	LDA wm_OWProcessPtr
	CMP #$02
	BNE CODE_04840A
+	DEC wm_OWBowserTimer
	BNE _04840D
	LDA #$22
	STA wm_SoundCh1
	BRA _04840D

CODE_04840A:
	JSR CODE_048576
_04840D:
	JSR CODE_04F708
_048410:
	JSR CODE_04862E
_048413:
	PLB
	RTL

CODE_048415:
	TAY
	REP #$20
	LDA wm_Bg1HOfs,X
	CLC
	ADC DATA_048211,Y
	PHA
	SEC
	SBC DATA_048221,Y
	EOR DATA_048211,Y
	ASL
	PLA
	BCC +
	STA wm_Bg1HOfs,X
	STA wm_Bg2HOfs,X
+	SEP #$20
	RTS

DATA_048431:
	.DB $11,$00,$0A,$00,$09,$00,$0B,$00
	.DB $12,$00,$0A,$00,$07,$00,$0A,$02
	.DB $03,$02,$10,$04,$12,$04,$1C,$04
	.DB $14,$04,$12,$06,$00,$02,$12,$06
	.DB $10,$00,$17,$06,$14,$00,$1C,$06
	.DB $14,$00,$1C,$06,$17,$06,$11,$05
	.DB $11,$05,$14,$04,$06,$01

DATA_048467:
	.DB $07,$00,$03,$00,$10,$00,$0E,$00
	.DB $17,$00,$18,$00,$12,$00,$14,$00
	.DB $0B,$00,$03,$00,$01,$00,$09,$00
	.DB $09,$00,$1D,$00,$0E,$00,$18,$00
	.DB $0F,$00,$16,$00,$10,$00,$18,$00
	.DB $02,$00,$1D,$00,$18,$00,$13,$00
	.DB $11,$00,$03,$00,$07,$00

DATA_04849D:
	.DB $A8,$04,$38,$04,$08,$09,$28,$09
	.DB $C8,$09,$48,$09,$28,$0D,$18,$01
	.DB $A8,$00,$98,$00,$B8,$00,$28,$01
	.DB $A8,$00,$78,$00,$28,$0D,$08,$04
	.DB $78,$0D,$08,$01,$C8,$0D,$48,$01
	.DB $C8,$0D,$48,$09,$18,$0B,$78,$0D
	.DB $68,$02,$C8,$0D,$28,$0D

DATA_0484D3:
	.DB $48,$01,$B8,$00,$38,$00,$18,$00
	.DB $98,$00,$98,$00,$D8,$01,$78,$00
	.DB $38,$00,$08,$01,$E8,$00,$78,$01
	.DB $88,$01,$28,$01,$88,$01,$E8,$00
	.DB $68,$01,$F8,$00,$88,$01,$08,$01
	.DB $D8,$01,$38,$00,$38,$01,$88,$01
	.DB $78,$00,$D8,$01,$D8,$01

CODE_048509:
	LDY wm_OWCharA
	LDA wm_MapData.MarioMap,Y
	STA m1
	STZ m0
	REP #$20
	LDX wm_OWCharB
	LDY #$34
-	LDA DATA_048431,Y
	EOR m0
	CMP #$0200
	BCS +
	CMP wm_MapData.MarioXPtr,X
	BNE +
	LDA wm_MapData.MarioYPtr,X
	CMP DATA_048467,Y
	BEQ ++
+	DEY
	DEY
	BPL -
++	STY wm_OWWarpIndex
	SEP #$20
	RTS

CODE_04853B:
	PHB
	PHK
	PLB
	REP #$20
	LDX wm_OWCharB
	LDY wm_OWWarpIndex
	LDA DATA_04849D,Y
	PHA
	AND #$01FF
	STA wm_MapData.MarioXPos,X
	LSR
	LSR
	LSR
	LSR
	STA wm_MapData.MarioXPtr,X
	LDA DATA_0484D3,Y
	STA wm_MapData.MarioYPos,X
	LSR
	LSR
	LSR
	LSR
	STA wm_MapData.MarioYPtr,X
	PLA
	LSR
	XBA
	AND #$000F
	STA wm_OWPlayerMap
	REP #$10
	JSR CODE_049A93
	SEP #$30
	PLB
	RTL

CODE_048576:
	LDA wm_OWProcessPtr
	JSL ExecutePtrLong

PtrsLong04857D: ; long pointers used in same bank, nice one
	.DL CODE_048EF1
	.DL CODE_04E570
	.DL CODE_048F87
	.DL CODE_049120
	.DL CODE_04945D
	.DL CODE_049D9A
	.DL CODE_049E22
	.DL CODE_049DD1
	.DL CODE_049E22
	.DL CODE_049E4C
	.DL CODE_04DAEF
	.DL CODE_049E52
	.DL CODE_0498C6

DrawOWBoarder:
	JSR CODE_04862E
_0485A7:
	REP #$20
	LDA #$001E
	CLC
	ADC wm_Bg1HOfs
	STA wm_MarioXPos
	LDA #$0006
	CLC
	ADC wm_Bg1VOfs
	STA wm_MarioYPos
	SEP #$20
	LDA #$08
	STA.W wm_MarioSpeedX
	PHB
	LDA #:CODE_00CEB1
	PHA
	PLB
	JSL CODE_00CEB1
	PLB
	LDA #$03
	STA wm_IsBehindScenery
	JSL CODE_00E2BD
	LDA #$06
	STA wm_PlayerDmaTiles
	LDA wm_PlayerAnimTimer
	BEQ +
	DEC wm_PlayerAnimTimer
+	LDA wm_CapeWaveTimer
	BEQ +
	DEC wm_CapeWaveTimer
+	LDA #$18
	STA m0
	LDA #$07
	STA m1
	LDY #$00
	TYX
-	LDA m0
	STA wm_ExOamSlot.1.XPos,X
	CLC
	ADC #$08
	STA m0
	LDA m1
	STA wm_ExOamSlot.1.YPos,X
	LDA #$7E
	STA wm_ExOamSlot.1.Tile,X
	LDA #$36
	STA wm_ExOamSlot.1.Prop,X
	PHX
	TYX
	LDA #$00
	STA wm_ExOamSize.1,X
	PLX
	INY
	TYA
	AND #$03
	BNE +
	LDA #$18
	STA m0
	LDA m1
	CLC
	ADC #$08
	STA m1
+	INX
	INX
	INX
	INX
	CPY #$10
	BNE -
	RTS

CODE_04862E:
	REP #$30
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$0100
	BCS +
	STA m0
	STA m8
	LDA wm_MapData.MarioYPos,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$0100
	BCC ++
+	LDA #$00F0
++	STA m2
	STA m10
	TXA
	EOR #$0004
	TAX
	LDA wm_MapData.MarioXPos,X
	SEC
	SBC wm_Bg1HOfs
	CMP #$0100
	BCS +
	STA m4
	STA m12
	LDA wm_MapData.MarioYPos,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$0100
	BCC ++
+	LDA #$00F0
++	STA m6
	STA m14
	SEP #$30
	LDA m0
	SEC
	SBC #$08
	STA m0
	LDA m2
	SEC
	SBC #$09
	STA m1
	LDA m4
	SEC
	SBC #$08
	STA m2
	LDA m6
	SEC
	SBC #$09
	STA m3
	LDA #$03
	STA wm_8C
	LDA m0
	STA m6
	STA wm_8A
	LDA m1
	STA m7
	STA wm_8B
	LDA wm_OWCharB
	LSR
	TAY
	LDA wm_MapData.PlayerAnim,Y
	CMP #$12
	BEQ ++
	CMP #$07
	BCC +
	CMP #$0F
	BCC ++
+	LDA wm_8B
	SEC
	SBC #$05
	STA wm_8B
	STA m7
++	REP #$30
	LDA wm_OWCharB
	XBA
	LSR
	STA m4
	LDX #$0000
	JSR CODE_048789
	LDA wm_OWCharB
	LSR
	TAY
	LDX #$0000
	JSR CODE_04894F
	SEP #$30
	STZ wm_ExOamSize.40
	STZ wm_ExOamSize.41
	STZ wm_ExOamSize.42
	STZ wm_ExOamSize.43
	STZ wm_ExOamSize.44
	STZ wm_ExOamSize.45
	STZ wm_ExOamSize.46
	STZ wm_ExOamSize.47
	LDA #$03
	STA wm_8C
	LDA wm_MapData.MarioMap
	LDY wm_OWProcessPtr
	CPY #$0A
	BNE +
	EOR #$01
+	CMP wm_MapData.LuigiMap
	BNE +++
	LDA m2
	STA m6
	STA wm_8A
	LDA m3
	STA m7
	STA wm_8B
	LDA wm_OWCharB
	LSR
	EOR #$02
	TAY
	LDA wm_MapData.PlayerAnim,Y
	CMP #$12
	BEQ ++
	CMP #$07
	BCC +
	CMP #$0F
	BCC ++
+	LDA wm_8B
	SEC
	SBC #$05
	STA wm_8B
	STA m7
++	REP #$30
	LDA wm_2PlayerGame
	AND #$00FF
	BEQ +++
	LDA m12
	CMP #$00F0
	BCS +++
	LDA m14
	CMP #$00F0
	BCS +++
	LDA m4
	EOR #$0200
	STA m4
	LDX #$0020
	JSR CODE_048789
	LDA wm_OWCharB
	LSR
	EOR #$0002
	TAY
	LDX #$0020
	JSR CODE_04894F
	SEP #$30
	STZ wm_ExOamSize.48
	STZ wm_ExOamSize.49
	STZ wm_ExOamSize.50
	STZ wm_ExOamSize.51
	STZ wm_ExOamSize.52
	STZ wm_ExOamSize.53
	STZ wm_ExOamSize.54
	STZ wm_ExOamSize.55
+++	SEP #$30
	RTS

CODE_048789:
	LDA wm_8A
	PHA
	PHX
	LDA m4
	XBA
	LSR
	TAX
	LDA wm_OWCharA,X
	PLX
	AND.W #$FF00
	BPL +
	SEP #$20
	LDA wm_8A
	STA wm_ExOamSlot.46.XPos,X
	CLC
	ADC #$08
	STA wm_ExOamSlot.47.XPos,X
	LDA wm_8B
	CLC
	ADC #$F9
	STA wm_ExOamSlot.46.YPos,X
	STA wm_ExOamSlot.47.YPos,X
	LDA #$7C
	STA wm_ExOamSlot.46.Tile,X
	STA wm_ExOamSlot.47.Tile,X
	LDA #$20
	STA wm_ExOamSlot.46.Prop,X
	LDA #$60
	STA wm_ExOamSlot.47.Prop,X
	REP #$20
+	PLA
	STA wm_8A
	RTS

DATA_0487CB:	.INCBIN "overworld/tilemaps/player.bin"

DATA_04894B:	.DB $20,$60,$00,$40

CODE_04894F:
	SEP #$30
	PHY
	TYA
	LSR
	TAY
	LDA wm_PlyrYoshiColor,Y
	BEQ CODE_048962
	STA m14
	STZ m15
	PLY
	JMP CODE_048CE6

CODE_048962:
	PLY
	REP #$30
	LDA wm_MapData.PlayerAnim,Y
	ASL
	ASL
	ASL
	ASL
	STA m0
	LDA wm_FrameA
	AND #$0018
	CLC
	ADC m0
	TAY
	PHX
	LDA m4
	XBA
	LSR
	TAX
	LDA wm_OWCharA,X
	PLX
	AND #$FF00
	BPL CODE_04898B
	LDA m0
	TAY
	BRA _0489A7

CODE_04898B:
	CPX #$0000
	BNE _0489A7
	LDA wm_OWProcessPtr
	CMP #$000B
	BNE _0489A7
	LDA wm_FrameA
	AND #$000C
	LSR
	LSR
	TAY
	LDA DATA_04894B,Y
	AND #$00FF
	TAY
_0489A7:
	REP #$20
	LDA wm_8A
	STA wm_ExOamSlot.40.XPos,X
	LDA DATA_0487CB,Y
	CLC
	ADC m4
	STA wm_ExOamSlot.40.Tile,X
	SEP #$20
	INX
	INX
	INX
	INX
	INY
	INY
	LDA wm_8A
	CLC
	ADC #$08
	STA wm_8A
	DEC wm_8C
	LDA wm_8C
	AND #$01
	BEQ +
	LDA m6
	STA wm_8A
	LDA wm_8B
	CLC
	ADC #$08
	STA wm_8B
+	LDA wm_8C
	BPL _0489A7
	RTS

DATA_0489DE:	.INCBIN "overworld/tilemaps/player_yoshi.bin"

DATA_048B5E:	.INCBIN "overworld/tilemaps/player_yoshi_x.bin"

DATA_048C1E:	.INCBIN "overworld/tilemaps/player_yoshi_y.bin"

DATA_048CDE:	.DB $00,$00,$00,$02,$00,$04,$00,$06

CODE_048CE6:
	LDA #$07
	STA wm_8C
	REP #$30
	LDA wm_MapData.PlayerAnim,Y
	ASL
	ASL
	ASL
	ASL
	STA m0
	LDA wm_FrameA
	AND #$0008
	ASL
	CLC
	ADC m0
	TAY
	CPX #$0000
	BNE _048D1B
	LDA wm_OWProcessPtr
	CMP #$000B
	BNE _048D1B
	LDA wm_FrameA
	AND #$000C
	LSR
	LSR
	TAY
	LDA DATA_04894B,Y
	AND #$00FF
	TAY
_048D1B:
	REP #$20
	PHY
	TYA
	LSR
	TAY
	SEP #$20
	LDA DATA_048B5E,Y
	CLC
	ADC wm_8A
	STA wm_ExOamSlot.40.XPos,X
	LDA DATA_048C1E,Y
	CLC
	ADC wm_8B
	STA wm_ExOamSlot.40.YPos,X
	PLY
	REP #$20
	LDA DATA_0489DE,Y
	CMP #$FFFF
	BEQ _048D67
	PHA
	AND #$0F00
	CMP #$0200
	BNE CODE_048D5E
	STY m8
	LDA m14
	SEC
	SBC #$0004
	TAY
	PLA
	AND #$F0FF
	ORA DATA_048CDE,Y
	PHA
	LDY m8
	BRA _048D63

CODE_048D5E:
	PLA
	CLC
	ADC m4
	PHA
_048D63:
	PLA
	STA wm_ExOamSlot.40.Tile,X
_048D67:
	SEP #$20
	INX
	INX
	INX
	INX
	INY
	INY
	DEC wm_8C
	BPL _048D1B
	RTS

DATA_048D74:
	.DB $0B,$00,$13,$00,$1A,$00,$1B,$00
	.DB $1F,$00,$20,$00,$31,$00,$32,$00
	.DB $34,$00,$35,$00,$40,$00

DATA_048D8A:	.DB $02,$03,$04,$06,$07,$09,$05

CODE_048D91:
	PHB
	PHK
	PLB
	STZ wm_OWAlterMusicFlag
	LDA #$0F
	STA wm_SprScrollL1X
	LDX.B #$02
	LDA wm_MapData.PlayerAnim
	CMP #$12
	BEQ +
	AND #$08
	BEQ ++
+	LDX.B #$0A
++	STX wm_MapData.PlayerAnim
	LDX.B #$02
	LDA wm_MapData.PlayerAnim+2
	CMP #$12
	BEQ +
	AND #$08
	BEQ ++
+	LDX.B #$0A
++	STX wm_MapData.PlayerAnim+2
	SEP #$10
	JSR CODE_048E55
	REP #$30
	LDA wm_UnkLevelEndFlag
	AND #$FF00
	BEQ CODE_048DDF
	BMI CODE_048DDF
	LDA wm_TransLvNum
	AND #$00FF
	CMP #$0018
	BNE CODE_048DDF
	BRL _048E34

CODE_048DDF:
	LDA wm_CutsceneNum
	AND #$00FF
	BEQ CODE_048E38
	LDA wm_CutsceneNum
	AND #$FF00
	STA wm_CutsceneNum
	SEP #$10
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	LSR
	LSR
	LSR
	LSR
	STA m0
	LDA wm_MapData.MarioYPos,X
	LSR
	LSR
	LSR
	LSR
	STA m2
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	REP #$10
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	TAX
	LDA wm_MapData.OwLvFlags,X
	AND #$0080
	BNE CODE_048E38
	LDY #$0014
-	LDA wm_TransLvNum
	AND #$00FF
	CMP DATA_048D74,Y
	BEQ CODE_048E38
	DEY
	DEY
	BPL -
_048E34:
	SEP #$30
	BRA _048E47

CODE_048E38:
	SEP #$30
	LDX wm_OWCharA
	LDA wm_MapData.MarioMap,X
	TAX
	LDA.W DATA_048D8A,X
	STA wm_MusicCh1
_048E47:
	PLB
	RTL

DATA_048E49:	.DW $0128,$0000,$0188

DATA_048E4F:	.DW $01C8,$0000,$01D8

CODE_048E55:
	REP #$30
	LDA wm_OWCharA
	AND #$00FF
	ASL
	ASL
	STA wm_OWCharB
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPtr,X
	STA m0
	LDA wm_MapData.MarioYPtr,X
	STA m2
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	STZ m0
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	ASL
	TAX
	LDA.W LevelNames,X
	STA m0
	JSR CODE_049D07
	LDX m4
	BMI +
	CPX #$0800
	BCS +
	LDA wm_Map16PageL,X
	AND #$00FF
	STA wm_OWPlayerTile
+	SEP #$30
	LDX wm_OWEnterLevel
	BEQ _048EE1
	BPL ADDR_048ED9
	TXA
	AND #$7F
	TAX
	STZ wm_OWSpriteTbl1,X
	LDA wm_KoopaKidTileIndex
	LDX wm_LevelEndFlag
	BPL ADDR_048ECD
	ASL
	TAX
	REP #$20
	LDY wm_OWCharB
	LDA.W DATA_048E49,X
	STA wm_MapData.MarioXPos,Y
	LDA.W DATA_048E4F,X
	STA wm_MapData.MarioYPos,Y
	SEP #$20
	BRA _048EE1

ADDR_048ECD:
	TAX
	LDA.W DATA_04FB85,X
	ORA wm_KoopaKidTrig
	STA wm_KoopaKidTrig
	BRA _048EE1

ADDR_048ED9:
	LDA wm_LevelEndFlag
	BMI _048EE1
	STZ wm_OWSpriteNum,X
_048EE1:
	REP #$30
	JSR _049831
	SEP #$30
	JSR DrawOWBoarder
	JSR CODE_048086
	JMP OW_Tile_Animation

CODE_048EF1:
	LDA #$08
	STA wm_KeepGameActive
	LDA wm_MapData.MarioMap
	CMP #$01
	BNE CODE_048F13
	LDA wm_MapData.MarioXPos
	CMP #$68
	BNE CODE_048F13
	LDA wm_MapData.MarioYPos
	CMP #$8E
	BNE CODE_048F13
	LDA #$0C
	STA wm_OWProcessPtr
	BRL _048F7A

CODE_048F13:
	REP #$20
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	LSR
	LSR
	LSR
	LSR
	STA m0
	LDA wm_MapData.MarioYPos,X
	LSR
	LSR
	LSR
	LSR
	STA m2
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	REP #$10
	SEP #$20
	LDA wm_MidwayPointFlag
	BEQ +
	LDA wm_LevelEndFlag
	BEQ +
	BPL CODE_048F5F
	REP #$20
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	TAX
	LDA wm_MapData.OwLvFlags,X
	ORA #$0040
	STA wm_MapData.OwLvFlags,X
+	SEP #$20
	LDA #$05
	STA wm_OWProcessPtr
	BRA _048F7A

CODE_048F5F:
	REP #$20
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	TAX
	LDA wm_MapData.OwLvFlags,X
	ORA #$0080
	AND #$FFBF
	STA wm_MapData.OwLvFlags,X
	INC wm_OWProcessPtr
_048F7A:
	REP #$30
	JMP _049831

DATA_048F7F:	.DB $58,$59,$5D,$63,$77,$79,$7E,$80

CODE_048F87:
	JSR CODE_049903
	LDX.B #$07
_048F8C:
	LDA wm_OWPlayerTile
	CMP.W DATA_048F7F,X
	BNE CODE_049000
	LDX.B #$2C
-	LDA wm_MapData.OwEventFlags,X
	STA wm_MapSave.OwEventFlags,X
	DEX
	BPL -
	REP #$30
	LDX wm_OWCharB
	TXA
	EOR #$0004
	TAY
	LDA wm_MapSave.MarioXPos,X
	STA wm_MapSave.MarioXPos,Y
	LDA wm_MapSave.MarioYPos,X
	STA wm_MapSave.MarioYPos,Y
	LDA wm_MapSave.MarioXPtr,X
	STA wm_MapSave.MarioXPtr,Y
	LDA wm_MapSave.MarioYPtr,X
	STA wm_MapSave.MarioYPtr,Y
	TXA
	LSR
	TAX
	EOR #$0002
	TAY
	LDA wm_MapSave.PlayerAnim,X
	STA wm_MapSave.PlayerAnim,Y
	TXA
	SEP #$30
	LSR
	TAX
	EOR #$01
	TAY
	LDA wm_MapSave.MarioMap,X
	STA wm_MapSave.MarioMap,Y
	LDA wm_LevelEndFlag
	CMP #$E0
	BNE CODE_048FFB
	DEC wm_KeepGameActive
	BMI ADDR_048FE9
	RTS

ADDR_048FE9:
	INC wm_OWSavePromptFlag
	JSR CODE_049037
	LDA #$02
	STA wm_KeepGameActive
	LDA #$04
	STA wm_OWProcessPtr
	BRA _049003

CODE_048FFB:
	INC wm_OWSavePromptFlag
	BRA _049003

CODE_049000:
	DEX
	BPL _048F8C
_049003:
	REP #$20
	STZ m6
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	LSR
	LSR
	LSR
	LSR
	STA m0
	LDA wm_MapData.MarioYPos,X
	LSR
	LSR
	LSR
	LSR
	STA m2
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	REP #$10
	LDX m4
	LDA wm_Map16PageL,X
	AND #$00FF
	STA wm_OWPlayerTile
	SEP #$30
	INC wm_OWProcessPtr
	RTS

CODE_049037:
	PHX
	PHY
	PHP
	SEP #$30
	LDA wm_OWSavePromptFlag
	BEQ +
	LDX #$5F
-	LDA wm_MapData.OwLvFlags,X
	STA wm_MapSave,X
	DEX
	BPL -
	STZ wm_OWSavePromptFlag
	LDA #$05
	STA wm_OWPromptTrig
+	PLP
	PLY
	PLX
	RTS

DATA_049058:	.DB $FF,$FF,$01,$00,$FF,$FF,$01,$00

DATA_049060:	.DB $05,$03,$01,$00

DATA_049064:	.DB $00,$00,$02,$00,$04,$00,$06,$00

DATA_04906C:
	.DB $28,$00,$08,$00,$14,$00,$36,$00
	.DB $3F,$00,$45,$00

HardCodedOWPaths:
	.DB $09,$15,$23,$1B,$43,$44,$24,$FF
	.DB $30,$31

DATA_049082:	.DB $78,$01

DATA_049084:	.DB $28,$01

DATA_049086:
	.DB $10,$10,$1E,$19,$16,$66,$16,$19
	.DB $1E,$10,$10,$66,$04,$04,$04,$58
	.DB $04,$04,$04,$66,$04,$04,$04,$04
	.DB $04,$6A,$04,$04,$04,$04,$04,$66
	.DB $1E,$19,$06,$09,$0F,$20,$1A,$21
	.DB $1A,$14,$19,$18,$1F,$17,$82,$17
	.DB $1F,$18,$19,$14,$1A,$21,$1A,$20
	.DB $0F,$09,$06,$19,$1E,$66,$04,$04
	.DB $58,$04,$04,$5F

DATA_0490CA:
	.DB $02,$02,$02,$02,$06,$06,$04,$04
	.DB $00,$00,$00,$00,$04,$04,$04,$04
	.DB $06,$06,$06,$06,$06,$06,$06,$06
	.DB $06,$06,$04,$04,$04,$04,$04,$04
	.DB $02,$02,$06,$06,$00,$00,$00,$04
	.DB $00,$04,$04,$00,$04,$00,$04,$06
	.DB $02,$06,$02,$06,$06,$02,$06,$02
	.DB $02,$02,$04,$04,$00,$00,$06,$06
	.DB $06,$04,$04,$04

DATA_04910E:
	.DB $00,$06,$0C,$10,$14,$1A,$20,$2F
	.DB $3E,$41,$08,$00,$04,$00,$02,$00
	.DB $01,$00

CODE_049120:
	STZ wm_OWIsSwitching
	LDY wm_OWEnterLevel
	BMI OWPU_NotOnPipe
	LDA wm_LevelEndFlag
	BMI CODE_049132
	BEQ CODE_049132
	BRL CODE_0491E9

CODE_049132:
	LDA wm_JoyFrameA
	AND #$20
.IFDEF dbg_StarRoadWarp
	BEQ +
.ELSE
	BRA +
.ENDIF
	LDA wm_OWPlayerTile
	BEQ _049165
	CMP #$56
	BEQ _049165
+	LDA wm_JoyPadB
	AND #$30
	CMP #$30
	BNE +
	LDA wm_OWPlayerTile
	CMP #$81
	BEQ _OWPU_EnterLevel
+	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	AND #$C0
	BNE OWPU_ABXY
	BRL CODE_0491E9

OWPU_ABXY:
	STZ wm_OWAlterMusicFlag
	LDA wm_OWPlayerTile
	CMP #$5F
	BNE OWPU_NotOnStar
_049165:
	JSR CODE_048509
	BNE _OWPU_IsOnPipeRTS
	STZ wm_StarWarpSpeed
	STZ wm_StarWarpTimer
	LDA #$0D
	STA wm_SoundCh1
	LDA #$0B
	STA wm_OWProcessPtr
	JMP CODE_049E52

OWPU_NotOnStar:
	LDA wm_OWPlayerTile
	CMP #$82
	BEQ +
	CMP #$5B
	BNE OWPU_NotOnPipe
+	JSR CODE_048509
	BNE _OWPU_IsOnPipeRTS
_04918D:
	INC wm_OWWarpFlag
	STZ wm_LevelEndFlag
	LDA #$0B
	STA wm_GameMode
_OWPU_IsOnPipeRTS:
	RTS

OWPU_NotOnPipe:
	CMP #$81
	BEQ CODE_0491E9
	BCS CODE_0491E9
_OWPU_EnterLevel:
	LDA wm_OWCharB
	LSR
	AND #$02
	TAX
	LDY #$10
	LDA wm_MapData.PlayerAnim,X
	AND #$08
	BEQ +
	LDY #$12
+	TYA
	STA wm_MapData.PlayerAnim,X
	LDX wm_OWCharA
	LDA wm_2PlayerCoins,X
	STA wm_StatusCoins
	LDA wm_2PMarioLives,X
	STA wm_StatusLives
	LDA wm_2PlayerPowerUp,X
	STA wm_MarioPowerUp
	LDA wm_PlyrYoshiColor,X
	STA wm_OWHasYoshi
	STA wm_YoshiColor
	STA wm_OnYoshi
	LDA wm_ItemInMarioBox,X
	STA wm_ItemInBox
	LDA #$02
	STA wm_KeepGameActive
	LDA #$80
	STA wm_MusicCh1
	INC wm_GameMode
	RTS

CODE_0491E9:
	REP #$20
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	LSR
	LSR
	LSR
	LSR
	STA m0
	STA wm_MapData.MarioXPtr,X
	LDA wm_MapData.MarioYPos,X
	LSR
	LSR
	LSR
	LSR
	STA m2
	STA wm_MapData.MarioYPtr,X
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	SEP #$20
	LDX wm_LevelEndFlag
	BEQ OWPU_NotAutoWalk
	DEX
	LDA.W DATA_049060,X
	STA m8
	STZ m9
	REP #$30
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	LDY #$000A
_04922A:
	CMP DATA_04906C,Y
	BNE CODE_04923B
	LDA #$0005
	STA wm_OWProcessPtr
	JSR CODE_049037
	BRL _049411

CODE_04923B:
	DEY
	DEY
	BPL _04922A
	LDA wm_Map16PageL.9,X
	AND #$00FF
	LDX m8
	BEQ +
-	LSR
	DEX
	BPL -
+	AND #$0003
	ASL
	TAX
	LDA.W DATA_049064,X
	TAY
	JMP _0492BC

OWPU_NotAutoWalk:
	SEP #$30
	STZ wm_LevelEndFlag
	LDA wm_JoyFrameA
	AND #$0F
	BEQ CODE_04926E
	LDX wm_OWPlayerTile
	CPX #$82
	BEQ CODE_0492AD
	BRA CODE_04928C

CODE_04926E:
	DEC wm_SprScrollL1X
	BPL +
	STZ wm_SprScrollL1X
	LDA wm_OWCharB
	LSR
	AND #$02
	TAX
	LDA wm_MapData.PlayerAnim,X
	AND #$08
	ORA #$02
	STA wm_MapData.PlayerAnim,X
+	REP #$30
	JMP _049831

CODE_04928C:
	REP #$30
	AND #$00FF
.IFDEF dbg_FreeOverworld
	JMP _0492B2
.ELSE
	NOP
	NOP
	NOP
.ENDIF
	PHA
	STZ m6
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	TAX
	PLA
	AND wm_MapData.OwLvFlags,X
	AND #$000F
	BNE CODE_0492AD
	JMP _049411

CODE_0492AD:
	REP #$30
	AND #$00FF
_0492B2:
	LDY #$0006
-	LSR
	BCS _0492BC
	DEY
	DEY
	BPL -
_0492BC:
	TYA
	STA wm_OWPlayerDirection
	LDX #$0000
	CPY #$0004
	BCS +
	LDX #$0002
+	LDA m4
	STA m8
	LDA m0,X
	CLC
	ADC DATA_049058,Y
	STA m0,X
	LDA wm_OWCharB
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	LDX m4
	BMI CODE_049301
	CMP #$0800
	BCS CODE_049301
	LDA wm_Map16PageL,X
	AND #$00FF
	BEQ CODE_049301
	CMP #$0056
	BCC CODE_0492FE
	CMP #$0087
	BCC CODE_0492FE
	BRA CODE_049301

CODE_0492FE:
	BRL CODE_049384

CODE_049301:
	STZ wm_OWUseHardPath
	STZ wm_OWHardTile
	LDX m8
	LDA wm_Map16PageL.5,X
	AND #$00FF
	STA m0
	LDX #$0009
_049315:
	LDA.W HardCodedOWPaths,X
	AND #$00FF
	CMP #$00FF
	BNE CODE_049349
	PHX
	LDX wm_OWCharB
	LDA wm_MapData.MarioYPos,X
	CMP.W DATA_049082
	BNE CODE_049346
	LDA wm_MapData.MarioXPos,X
	CMP.W DATA_049084
	BNE CODE_049346
	LDA wm_OWCharA
	AND #$00FF
	TAX
	LDA wm_MapData.MarioMap,X
	AND #$00FF
	BNE CODE_049346
	PLX
	BRA _04934D

CODE_049346:
	PLX
	BRA CODE_049374

CODE_049349:
	CMP m0
	BNE CODE_049374
_04934D:
	STX m0
	LDA.W DATA_04910E,X
	AND #$00FF
	TAX
	DEC A
	STA wm_OWHardTile
	STY m2
	LDA.W DATA_0490CA,X
	AND #$00FF
	CMP m2
	BNE CODE_04937A
	LDA #$0001
	STA wm_OWUseHardPath
	LDA.W DATA_049086,X
	AND #$00FF
	BRA CODE_049384

CODE_049374:
	DEX
	BMI CODE_04937A
	BRL _049315

CODE_04937A:
	SEP #$20
	STZ wm_LevelEndFlag
	REP #$20
	JMP _049411

CODE_049384:
	STA wm_OWPlayerTile
	STA m0
	STZ m2
	LDX #$0017
_04938E:
	LDA.W DATA_04A03C,X
	AND #$00FF
	CMP m0
	BNE CODE_0493B5
	LDA.W DATA_04A0E4,X
	CLC
	ADC wm_OWCharB
	PHA
	TXA
	ASL
	ASL
	TAX
	LDA.W DATA_04A084,X
	STA m0
	LDA.W DATA_04A084+2,X
	STA m2
	PLA
	AND #$00FF
	TAX
	BRA _0493DA

CODE_0493B5:
	DEX
	BPL _04938E
	LDX #$0008
	TYA
	AND #$0002
	BNE +
	TXA
	EOR #$FFFF
	INC A
	TAX
+	STX m0
	LDX #$0000
	CPY #$0004
	BCS +
	LDX #$0002
+	TXA
	CLC
	ADC wm_OWCharB
	TAX
_0493DA:
	LDA m0
	CLC
	ADC wm_MapData.MarioXPos,X
	STA wm_OWMarioXDest,X
	TXA
	EOR #$0002
	TAX
	LDA m2
	CLC
	ADC wm_MapData.MarioXPos,X
	STA wm_OWMarioXDest,X
	TXA
	LSR
	AND #$0002
	TAX
	TYA
	STA m0
	LDA wm_MapData.PlayerAnim,X
	AND #$0008
	ORA m0
	STA wm_MapData.PlayerAnim,X
	LDA #$000F
	STA wm_SprScrollL1X
	INC wm_OWProcessPtr
	STZ wm_ScrollTimerL1
_049411:
	JMP _049831

DATA_049414:	.DB $0D,$08

DATA_049416:	.DB $EF,$FF,$D7,$FF

DATA_04941A:	.DB $11,$01,$31,$01

DATA_04941E:	.DB $08,$00,$04,$00,$02,$00,$01,$00

DATA_049426:
	.DB $44,$43,$45,$46,$47,$48,$25,$40
	.DB $42,$4D

DATA_049430:
	.DB $0C,$00,$0E,$00,$10,$06,$12,$00
	.DB $18,$04,$1A,$02,$20,$06,$42,$06
	.DB $4E,$04,$50,$02,$58,$06,$5A,$00
	.DB $70,$06,$90,$00,$A0,$06

DATA_04944E:
	.DB $01,$01,$00,$01,$01,$00,$00,$00
	.DB $01,$00,$00,$01,$00,$01,$00

CODE_04945D:
	LDA wm_OWIsSwitching
	BEQ CODE_049468
	LDA.B #$08
	STA wm_OWProcessPtr
	RTS

CODE_049468:
	REP #$30
	LDA wm_OWCharB
	CLC
	ADC #$0002
	TAY
	LDX #$0002
-	LDA wm_OWMarioXDest,Y
	SEC
	SBC wm_MapData.MarioXPos,Y
	STA m0,X
	BPL +
	EOR #$FFFF
	INC A
+	STA m4,X
	DEY
	DEY
	DEX
	DEX
	BPL -
	LDY #$FFFF
	LDA m4
	STA m10
	LDA m6
	STA m12
	CMP m4
	BCC +
	STA m10
	LDA m4
	STA m12
	LDY #$0001
+	STY m8
	SEP #$20
	LDX wm_OWIsClimbing
	LDA.W DATA_049414,X
	ASL
	ASL
	ASL
	ASL
	STA WRMPYA
	LDA m12
	BEQ +
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA RDMPYL
	STA WRDIVL
	SEP #$20
	LDA m10
	STA WRDIVB
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA RDDIVL
+	REP #$20
	STA m14
	LDX wm_OWIsClimbing
	LDA.W DATA_049414,X
	AND #$00FF
	ASL
	ASL
	ASL
	ASL
	STA m10
	LDX #$0002
_0494F0:
	LDA m8
	BMI CODE_0494F8
	LDA m10
	BRA _0494FA

CODE_0494F8:
	LDA m14
_0494FA:
	BIT m0,X
	BPL +
	EOR #$FFFF
	INC A
+	STA wm_OWPlayerXSpeed,X
	LDA m8
	EOR #$FFFF
	INC A
	STA m8
	DEX
	DEX
	BPL _0494F0
	LDX #$0000
	LDA m8
	BMI +
	LDX #$0002
+	LDA m0,X
	BEQ CODE_049522
	JMP CODE_049801

CODE_049522:
	LDA wm_ScrollTimerL1
	BEQ CODE_04955C
	STZ wm_OWUseHardPath
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPtr,X
	STA m0
	LDA wm_MapData.MarioYPtr,X
	STA m2
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	STZ m0
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	ASL
	TAX
	LDA.W LevelNames,X
	STA m0
	JSR CODE_049D07
	INC wm_OWProcessPtr
	JSR CODE_049037
	JMP _049831

CODE_04955C:
	LDA wm_OWPlayerTile
	STA wm_OWOnCurvyTile
	LDA #$0008
	STA m8
	LDY wm_OWPlayerDirection
	TYA
	AND #$00FF
	EOR #$0002
	STA m10
	BRA _049582

ADDR_049575:
	LDA m8
	SEC
	SBC #$0002
	STA m8
	CMP m10
	BEQ ADDR_049575
	TAY
_049582:
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPtr,X
	STA m0
	LDA wm_MapData.MarioYPtr,X
	STA m2
	LDX #$0000
	CPY #$0004
	BCS +
	LDX #$0002
+	LDA m0,X
	CLC
	ADC DATA_049058,Y
	STA m0,X
	LDA wm_OWCharB
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	LDA wm_OWUseHardPath
	BEQ +
	STY m6
	LDX wm_OWHardTile
	INX
	LDA.W DATA_0490CA,X
	AND #$00FF
	CMP m6
	BNE ADDR_049575
	STX wm_OWHardTile
	LDA.W DATA_049086,X
	AND #$00FF
	CMP #$0058
	BNE ++
+	LDX m4
	BMI ADDR_049575
	CMP #$0800
	BCS ADDR_049575
	LDA wm_Map16PageL,X
	AND #$00FF
++	STA wm_OWPlayerTile
	BEQ ADDR_049575
	CMP #$0087
	BCS ADDR_049575
	PHA
	PHY
	TAX
	DEX
	LDY #$0000
	LDA.W DATA_049FEB,X
	STA m14
	AND #$00FF
	CMP #$0014
	BNE +
	LDY #$0001
+	STY wm_OWIsClimbing
	LDX wm_OWCharB
	LDA m0
	STA wm_MapData.MarioXPtr,X
	LDA m2
	STA wm_MapData.MarioYPtr,X
	PLY
	PLA
	PHA
	SEP #$30
	LDX #$09
_049616:
	CMP.W DATA_049426,X
	BNE CODE_049645
	PHY
	JSR CODE_049A24
	PLY
	LDA #$01
	STA wm_OWAlterMusicFlag
	JSR _04F407
	STZ wm_OWFadeFlag
	REP #$20
	STZ wm_LvBgColor
	LDA #$7000
	STA wm_OWFadeMathX
	LDA #$5400
	STA wm_OWFadeMathY
	SEP #$20
	LDA #$0A
	STA wm_OWProcessPtr
	BRA _049648

CODE_049645:
	DEX
	BPL _049616
_049648:
	REP #$30
	PLA
	PHA
	CMP #$0056
	BCS CODE_049654
	JMP CODE_04971D

CODE_049654:
	CMP #$0080
	BEQ +
	CMP #$006A
	BCC CODE_049676
	CMP #$006E
	BCS CODE_049676
+	LDA wm_OWCharB
	LSR
	AND #$0002
	TAX
	LDA wm_MapData.PlayerAnim,X
	ORA #$0008
	STA wm_MapData.PlayerAnim,X
	BRA _049687

CODE_049676:
	LDA wm_OWCharB
	LSR
	AND #$0002
	TAX
	LDA wm_MapData.PlayerAnim,X
	AND #$00F7
	STA wm_MapData.PlayerAnim,X
_049687:
	LDA #$0001
	STA wm_ScrollTimerL1
	LDA wm_OWPlayerTile
	CMP #$005F
	BEQ +
	CMP #$005B
	BEQ +
	CMP #$0082
	BEQ +
	LDA #$0023
	STA wm_SoundCh3
+	NOP ; unused sound possibly
	NOP
	NOP
	LDA wm_OWPlayerTile
	AND #$00FF
	CMP #$0082
	BEQ +
	PHY
	TYA
	AND #$00FF
	EOR #$0002
	TAY
	STZ m6
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	TAX
	LDA DATA_04941E,Y
	ORA wm_MapData.OwLvFlags,X
	STA wm_MapData.OwLvFlags,X
	PLY
+	LDA wm_OWCharB
	LSR
	AND #$0002
	TAX
	LDA wm_MapData.PlayerAnim,X
	AND #$000C
	STA m14
	LDA #$0001
	STA m4
	LDA wm_OWOnCurvyTile
	AND #$00FF
	STA m0
	LDX #$0017
_0496F2:
	LDA.W DATA_04A03C,X
	AND #$00FF
	CMP m0
	BNE CODE_049704
	TXA
	ASL
	TAX
	LDA.W DATA_04A054,X
	BRA _049718

CODE_049704:
	DEX
	BPL _0496F2
	LDA #$0000
	ORA #$0800
	CPY #$0004
	BCC _049718
	LDA #$0000
	ORA #$0008
_049718:
	LDX #$0000
	BRA _049728

CODE_04971D:
	DEC A
	ASL
	TAX
	LDA.W DATA_049F49,X
	STA m4
	LDA.W DATA_049EA7,X
_049728:
	STA m0
	TXA
	SEP #$20
	LDX #$001C
-	CMP.W DATA_049430,X
	BEQ CODE_04973B
	DEX
	DEX
	BPL -
	BRA CODE_04974A

CODE_04973B:
	TYA
	CMP.W DATA_049430+1,X
	BEQ CODE_04974A
	TXA
	LSR
	TAX
	LDA.W DATA_04944E,X
	TAX
	BRA _049755

CODE_04974A:
	LDX #$0000
	TYA
	AND #$02
	BEQ _049755
	LDX #$0001
_049755:
	LDA m4,X
	BEQ +
	LDA m0
	EOR #$FF
	INC A
	STA m0
	LDA m1
	EOR #$FF
	INC A
	STA m1
+	REP #$20
	PLA
	LDX #$0000
	LDA m14
	AND #$0007
	BNE +
	LDX #$0001
+	LDA m14
	AND #$00FF
	STA m4
	LDA m0,X
	AND #$00FF
	CMP #$0080
	BCS +
	LDA m4
	CLC
	ADC #$0002
	STA m4
+	LDA wm_OWCharB
	LSR
	AND #$0002
	TAX
	LDA m4
	STA wm_MapData.PlayerAnim,X
	LDX wm_OWCharB
	LDA m0
	AND #$00FF
	CMP #$0080
	BCC +
	ORA #$FF00
+	CLC
	ADC wm_MapData.MarioXPos,X
	AND #$FFFC
	STA wm_OWMarioXDest,X
	LDA m1
	AND #$00FF
	CMP #$0080
	BCC +
	ORA #$FF00
+	CLC
	ADC wm_MapData.MarioYPos,X
	AND #$FFFC
	STA wm_OWMarioYDest,X
	SEP #$20
	LDA wm_OWMarioXDest,X
	AND #$0F
	BNE CODE_0497E3
	LDY #$0004
	LDA m0
	BMI +
	LDY #$0006
+	BRA _0497F4

CODE_0497E3:
	LDA wm_OWMarioYDest,X
	AND #$0F
	BNE _0497F4
	LDY #$0000
	LDA m1
	BMI _0497F4
	LDY #$0002
_0497F4:
	STY wm_OWPlayerDirection
	LDA wm_OWProcessPtr
	CMP #$0A
	BEQ _049831
	JMP CODE_04945D

CODE_049801:
	REP #$20
	LDA wm_OWCharB
	CLC
	ADC #$0002
	TAX
	LDY #$0002
-	LDA wm_L3ScrollFlag,Y
	AND #$00FF
	CLC
	ADC wm_OWPlayerXSpeed,Y
	STA wm_L3ScrollFlag,Y
	AND #$FF00
	BPL +
	ORA #$00FF
+	XBA
	CLC
	ADC wm_MapData.MarioXPos,X
	STA wm_MapData.MarioXPos,X
	DEX
	DEX
	DEY
	DEY
	BPL -
_049831:
	SEP #$20
	LDA wm_OWProcessPtr
	CMP #$0A
	BEQ _049882
	LDA wm_OWBowserTimer
	BNE _049882
_04983F:
	REP #$30
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	STA m0
	LDA wm_MapData.MarioYPos,X
	STA m2
	TXA
	LSR
	LSR
	TAX
	LDA wm_MapData.MarioMap,X
	AND #$00FF
	BNE _049882
	LDX #$0002
	TXY
_04985E:
	LDA m0,X
	SEC
	SBC #$0080
	BPL CODE_049870
	CMP DATA_049416,Y
	BCS _049878
	LDA DATA_049416,Y
	BRA _049878

CODE_049870:
	CMP DATA_04941A,Y
	BCC _049878
	LDA DATA_04941A,Y
_049878:
	STA wm_Bg1HOfs,X
	STA wm_Bg2HOfs,X
	DEY
	DEY
	DEX
	DEX
	BPL _04985E
_049882:
	SEP #$30
	RTS

OW_TilePos_Calc:
	LDA m0
	AND.W #$000F
	STA m4
	LDA m0
	AND.W #$0010
	ASL
	ASL
	ASL
	ASL
	ADC m4
	STA m4
	LDA m2
	ASL
	ASL
	ASL
	ASL
	AND.W #$00FF
	ADC m4
	STA m4
	LDA m2
	AND.W #$0010
	BEQ +
	LDA m4
	CLC
	ADC.W #$0200
	STA m4
+	LDA wm_MapData.MarioMap,X
	AND.W #$00FF
	BEQ _Return0498C5
	LDA m4
	CLC
	ADC.W #$0400
	STA m4
_Return0498C5:
	RTS

CODE_0498C6:
	STZ wm_MapData.PlayerAnim
	LDA #$80
	CLC
	ADC wm_YoshisHouseYAcc
	STA wm_YoshisHouseYAcc
	PHP
	LDA #$0F
	CMP #$08
	LDY #$00
	BCC +
	ORA #$F0
	DEY
+	PLP
	ADC wm_MapData.MarioYPos
	STA wm_MapData.MarioYPos
	TYA
	ADC wm_MapData.MarioYPos+1
	STA wm_MapData.MarioYPos+1
	LDA wm_MapData.MarioYPos
	CMP #$78
	BNE +
	STZ wm_OWProcessPtr
	JSL CODE_009BC9
+	RTS

UNK_0498FB:	.DB $08,$00,$04,$00,$02,$00,$01,$00 ; unused tile settings?

CODE_049903:
	LDX wm_LevelEndFlag
	BEQ _Return0498C5
	BMI _Return0498C5
	DEX
	LDA.W DATA_049060,X
	STA m8
	STZ m9
	REP #$20
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPos,X
	LSR
	LSR
	LSR
	LSR
	STA m0
	STA wm_MapData.MarioXPtr,X
	LDA wm_MapData.MarioYPos,X
	LSR
	LSR
	LSR
	LSR
	STA m2
	STA wm_MapData.MarioYPtr,X
	TXA
	LSR
	LSR
	TAX
	JSR OW_TilePos_Calc
	REP #$10
	LDX m4
	LDA wm_Map16PageL.9,X
	AND #$00FF
	LDX m8
	BEQ +
-	LSR
	DEX
	BPL -
+	AND #$0003
	ASL
	TAY
	LDX m4
	LDA wm_Map16PageL.5,X
	AND #$00FF
	TAX
	LDA DATA_04941E,Y
	ORA wm_MapData.OwLvFlags,X
	STA wm_MapData.OwLvFlags,X
	SEP #$30
	RTS

DATA_049964:
	.DB $40,$01,$28,$00,$00
	.DB $50,$01,$58,$00,$00
	.DB $10,$00,$48,$00,$01
	.DB $10,$00,$98,$00,$01
	.DB $A0,$00,$D8,$00,$00
	.DB $40,$01,$58,$00,$02
	.DB $90,$00,$E8,$01,$04
	.DB $60,$01,$E8,$00,$00
	.DB $A0,$00,$C8,$01,$00
	.DB $60,$01,$88,$00,$03
	.DB $08,$01,$90,$01,$00
	.DB $E8,$01,$10,$00,$03
	.DB $10,$01,$C8,$01,$00
	.DB $F0,$01,$88,$00,$03

DATA_0499AA:
	.DB $00,$00,$48,$00,$01
	.DB $00,$00,$98,$00,$01
	.DB $50,$01,$28,$00,$00
	.DB $60,$01,$58,$00,$00
	.DB $50,$01,$58,$00,$02
	.DB $90,$00,$D8,$00,$00
	.DB $50,$01,$E8,$00,$00
	.DB $A0,$00,$E8,$01,$04
	.DB $50,$01,$88,$00,$03
	.DB $B0,$00,$C8,$01,$00
	.DB $E8,$01,$00,$00,$03
	.DB $08,$01,$A0,$01,$00
	.DB $00,$02,$88,$00,$03
	.DB $00,$01,$C8,$01,$00

DATA_0499F0:
	.DB $00,$04,$00,$09,$14,$02,$15,$05
	.DB $14,$05,$09,$0D,$15,$0E,$09,$1E
	.DB $15,$08,$0A,$1C,$1E,$00,$10,$19
	.DB $1F,$08,$10,$1C

DATA_049A0C:
	.DB $EF,$FF,$D8,$FF,$EF,$FF,$80,$00
	.DB $EF,$FF,$28,$01,$F0,$00,$D8,$FF
	.DB $F0,$00,$80,$00,$F0,$00,$28,$01

CODE_049A24:
	REP #$20
	LDA wm_OWCharB
	LSR
	LSR
	TAX
	LDA wm_MapData.MarioMap,X
	AND #$00FF
	STA wm_OWPlayerMap
	LDA #$001A
	STA m2
	LDY #$41
	LDX wm_OWCharB
_049A3F:
	LDA wm_MapData.MarioYPos,X
	CMP DATA_049964,Y
	BNE CODE_049A85
	LDA wm_MapData.MarioXPos,X
	CMP DATA_049964+2,Y
	BNE CODE_049A85
	LDA DATA_049964+4,Y
	AND #$00FF
	CMP wm_OWPlayerMap
	BNE CODE_049A85
	LDA DATA_0499AA,Y
	STA wm_MapData.MarioYPos,X
	LDA DATA_0499AA+2,Y
	STA wm_MapData.MarioXPos,X
	LDA DATA_0499AA+4,Y
	AND #$00FF
	STA wm_OWPlayerMap
	LDY m2
	LDA DATA_0499F0,Y
	AND #$00FF
	STA wm_MapData.MarioYPtr,X
	LDA DATA_0499F0+1,Y
	AND #$00FF
	STA wm_MapData.MarioXPtr,X
	BRA _049A90

CODE_049A85:
	DEC m2
	DEC m2
	DEY
	DEY
	DEY
	DEY
	DEY
	BPL _049A3F
_049A90:
	SEP #$20
	RTS

CODE_049A93:
	LDA wm_OWCharB
	AND.W #$00FF
	LSR
	LSR
	TAX
	LDA wm_MapData.MarioMap,X
	AND.W #$FF00
	ORA wm_OWPlayerMap
	STA wm_MapData.MarioMap,X
	AND.W #$00FF
	BNE CODE_049AB0
	JMP _04983F

CODE_049AB0:
	DEC A
	ASL
	ASL
	TAY
	LDA DATA_049A0C,Y
	STA wm_Bg1HOfs
	STA wm_Bg2HOfs
	LDA DATA_049A0C+2,Y
	STA wm_Bg1VOfs
	STA wm_Bg2VOfs
	SEP #$30
	RTS

LevelNameStrings:
;	base $0000
	.INCLUDE "strings/level_names.a"
;	base off
LevelNameStringsEnd:

DATA_049C91:
	.DW LevelStr_None-LevelNameStrings
	.DW LevelStr_0100-LevelNameStrings
	.DW LevelStr_0200-LevelNameStrings
	.DW LevelStr_0300-LevelNameStrings
	.DW LevelStr_0400-LevelNameStrings
	.DW LevelStr_0500-LevelNameStrings
	.DW LevelStr_0600-LevelNameStrings
	.DW LevelStr_0700-LevelNameStrings
	.DW LevelStr_0800-LevelNameStrings
	.DW LevelStr_0900-LevelNameStrings
	.DW LevelStr_0A00-LevelNameStrings
	.DW LevelStr_0B00-LevelNameStrings
	.DW LevelStr_0C00-LevelNameStrings
	.DW LevelStr_0D00-LevelNameStrings
	.DW LevelStr_0E00-LevelNameStrings
	.DW LevelStr_0F00-LevelNameStrings
	.DW LevelStr_1000-LevelNameStrings
	.DW LevelStr_1100-LevelNameStrings
	.DW LevelStr_1200-LevelNameStrings
	.DW LevelStr_1300-LevelNameStrings
	.DW LevelStr_1400-LevelNameStrings
	.DW LevelStr_1500-LevelNameStrings
	.DW LevelStr_1600-LevelNameStrings
	.DW LevelStr_1700-LevelNameStrings
	.DW LevelStr_1800-LevelNameStrings
	.DW LevelStr_1900-LevelNameStrings
	.DW LevelStr_1A00-LevelNameStrings
	.DW LevelStr_1B00-LevelNameStrings
	.DW LevelStr_1C00-LevelNameStrings
	.DW LevelStr_1D00-LevelNameStrings
	.DW LevelStr_1E00-LevelNameStrings

DATA_049CCF:
	.DW LevelStr_None-LevelNameStrings
	.DW LevelStr_0010-LevelNameStrings
	.DW LevelStr_0020-LevelNameStrings
	.DW LevelStr_0030-LevelNameStrings
	.DW LevelStr_0040-LevelNameStrings
	.DW LevelStr_0050-LevelNameStrings
	.DW LevelStr_0060-LevelNameStrings
	.DW LevelStr_0070-LevelNameStrings
	.DW LevelStr_0080-LevelNameStrings
	.DW LevelStr_0090-LevelNameStrings
	.DW LevelStr_00A0-LevelNameStrings
	.DW LevelStr_00B0-LevelNameStrings
	.DW LevelStr_00C0-LevelNameStrings
	.DW LevelStr_00D0-LevelNameStrings
	.DW LevelStr_00E0-LevelNameStrings

DATA_049CED:
	.DW LevelStr_None-LevelNameStrings
	.DW LevelStr_0001-LevelNameStrings
	.DW LevelStr_0002-LevelNameStrings
	.DW LevelStr_0003-LevelNameStrings
	.DW LevelStr_0004-LevelNameStrings
	.DW LevelStr_0005-LevelNameStrings
	.DW LevelStr_0006-LevelNameStrings
	.DW LevelStr_0007-LevelNameStrings
	.DW LevelStr_0008-LevelNameStrings
	.DW LevelStr_0009-LevelNameStrings
	.DW LevelStr_000A-LevelNameStrings
	.DW LevelStr_000B-LevelNameStrings
	.DW LevelStr_000C-LevelNameStrings

CODE_049D07:
	LDA wm_ImageIndex
	TAX
	CLC
	ADC.W #$0026
	STA m2
	CLC
	ADC.W #$0004
	STA wm_ImageIndex
	LDA.W #$2500
	STA wm_ImageTable.2.ImgL,X
	LDA.W #$8B50
	STA wm_ImageTable,X
	LDA m1
	AND.W #$007F
	ASL
	TAY
	LDA DATA_049C91,Y
	TAY
	SEP #$20
	LDA LevelNameStrings,Y
	BMI +
	JSR CODE_049D7F
+	REP #$20
	LDA m0
	AND.W #$00F0
	LSR
	LSR
	LSR
	TAY
	LDA DATA_049CCF,Y
	TAY
	SEP #$20
	LDA LevelNameStrings,Y
	CMP #$9F
	BEQ +
	JSR CODE_049D7F
+	REP #$20
	LDA m0
	AND #$000F
	ASL
	TAY
	LDA DATA_049CED,Y
	TAY
	SEP #$20
	JSR CODE_049D7F
-	CPX m2
	BCS CODE_049D76
	LDY.W #LevelNameStringsEnd-LevelNameStrings-1
	JSR CODE_049D7F
	BRA -

CODE_049D76:
	LDA #$FF
	STA wm_ImageTable.3.ImgL,X
	REP #$20
	RTS

CODE_049D7F:
	LDA LevelNameStrings,Y
	PHP
	CPX m2
	BCS +
	AND.B #$7F
	STA wm_ImageTable.3.ImgL,X
	LDA.B #$39
	STA wm_ImageTable.3.ImgH,X
	INX
	INX
+	INY
	PLP
	BPL CODE_049D7F
	RTS

CODE_049D9A:
	LDA wm_2PlayerGame
	BEQ +
	LDA wm_OWCharA
	EOR.B #$01
	TAX
	LDA wm_2PMarioLives,X
	BMI +
	LDA wm_LevelEndFlag
	BNE CODE_049DBC
+	LDA.B #$03
	STA wm_OWProcessPtr
	STZ wm_LevelEndFlag
	REP #$30
	JMP _049831

CODE_049DBC:
	DEC wm_KeepGameActive
	BPL +
	LDA.B #$02
	STA wm_KeepGameActive
	STZ wm_LevelEndFlag
	INC wm_OWProcessPtr
+	REP #$30
	JMP _049831

CODE_049DD1:
	LDA wm_OWCharA
	EOR.B #$01
	STA wm_OWCharA
	TAX
	LDA wm_2PlayerCoins,X
	STA wm_StatusCoins
	LDA wm_2PMarioLives,X
	STA wm_StatusLives
	LDA wm_2PlayerPowerUp,X
	STA wm_MarioPowerUp
	LDA wm_PlyrYoshiColor,X
	STA wm_OWHasYoshi
	STA wm_YoshiColor
	STA wm_OnYoshi
	LDA wm_ItemInMarioBox,X
	STA wm_ItemInBox
	JSL CODE_05DBF2
	REP #$20
	JSR CODE_048E55
	SEP #$20
	LDX wm_OWCharA
	LDA wm_MapData.MarioMap,X
	STA wm_OWPlayerMap
	STZ wm_OWPlayerMap+1
	LDA #$02
	STA wm_KeepGameActive
	LDA #$0A
	STA wm_OWProcessPtr
	INC wm_OWIsSwitching
	RTS

CODE_049E22:
	DEC wm_KeepGameActive
	BPL +
	LDA #$02
	STA wm_KeepGameActive
	LDX wm_MosaicDir
	LDA wm_IniDisp
	CLC
	ADC.L DATA_009F2F,X
	STA wm_IniDisp
	CMP.L DATA_009F33,X
	BNE +
	INC wm_OWProcessPtr
	LDA wm_MosaicDir
	EOR #$01
	STA wm_MosaicDir
+	RTS

CODE_049E4C:
	LDA #$03
	STA wm_OWProcessPtr
	RTS

CODE_049E52:
	LDA wm_StarWarpSpeed
	BNE CODE_049E63
	INC wm_StarWarpTimer
	LDA wm_StarWarpTimer
	CMP #$31
	BNE _049E93
	BRA _049E69

CODE_049E63:
	LDA wm_FrameA
	AND #$07
	BNE +
_049E69:
	INC wm_StarWarpSpeed
	LDA wm_StarWarpSpeed
	CMP #$05
	BNE +
	LDA #$04
	STA wm_StarWarpSpeed
+	REP #$20
	LDA wm_StarWarpSpeed
	AND #$00FF
	STA m0
	LDX wm_OWCharB
	LDA wm_MapData.MarioYPos,X
	SEC
	SBC m0
	STA wm_MapData.MarioYPos,X
	SEC
	SBC wm_Bg1VOfs
	BMI CODE_049E96
_049E93:
	SEP #$20
	RTS

CODE_049E96:
	SEP #$20
	JMP _04918D

ADDR_049E9B: ; unreachable hex to dec
	LDY.B #$00
-	CMP #$0A
	BCC Return049EA6
	SBC #$0A
	INY
	BRA -

Return049EA6:
	RTS ; unused

DATA_049EA7:
	.DB $10,$F8,$10,$00,$10,$FC,$10,$00
	.DB $10,$FC,$10,$00,$08,$FC,$0C,$F4
	.DB $FC,$04,$04,$FC,$F8,$10,$00,$10
	.DB $FC,$08,$FC,$08,$FC,$10,$00,$10
	.DB $F8,$04,$FC,$10,$00,$10,$10,$08
	.DB $10,$04,$10,$04,$08,$04,$0C,$0C
	.DB $04,$04,$04,$04,$08,$10,$FC,$F8
	.DB $FC,$F8,$04,$10,$F8,$FC,$04,$10
	.DB $F4,$F4,$0C,$F4,$10,$00,$00,$10
	.DB $00,$10,$10,$00,$10,$00,$FC,$08
	.DB $FC,$08,$00,$10,$10,$FC,$10,$FC
	.DB $FC,$04,$04,$FC,$F8,$10,$00,$10
	.DB $FC,$10,$10,$04,$10,$00,$04,$10
	.DB $04,$04,$FC,$F8,$04,$04,$10,$08
	.DB $0C,$F4,$00,$10,$FC,$10,$10,$00
	.DB $04,$10,$10,$F8,$00,$10,$00,$10
	.DB $FC,$10,$10,$00,$00,$10,$00,$10
	.DB $00,$10,$00,$10,$00,$10,$00,$10
	.DB $04,$FC,$04,$04,$04,$04,$00,$10
	.DB $00,$10,$10,$00,$10,$00,$FC,$10
	.DB $FC,$04

DATA_049F49:
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$00,$01,$00,$01
	.DB $00,$01,$00,$01,$01,$00,$01,$00
	.DB $00,$01,$01,$00,$01,$00,$01,$00
	.DB $00,$01,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$00,$01
	.DB $00,$01,$01,$00,$00,$01,$01,$00
	.DB $00,$01,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$00,$01
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $00,$01,$00,$01,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$00,$01,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $00,$01,$01,$00,$01,$00,$01,$00
	.DB $01,$00,$01,$00,$01,$00,$01,$00
	.DB $00,$01

DATA_049FEB:
	.DB $04,$04,$04,$04,$04,$04,$04,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $04,$00,$00,$04,$04,$04,$04,$00
	.DB $00,$00,$00,$00,$00,$00,$04,$00
	.DB $00,$00,$04,$00,$00,$04,$04,$08
	.DB $08,$08,$0C,$0C,$08,$08,$08,$08
	.DB $08,$0C,$0C,$08,$08,$08,$08,$0C
	.DB $08,$08,$08,$0C,$08,$0C,$14,$14
	.DB $14,$04,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$04,$04,$08
	.DB $00

DATA_04A03C:
	.DB $07,$09,$0A,$0D,$0E,$11,$17,$19
	.DB $1A,$1C,$1D,$1F,$28,$29,$2D,$2E
	.DB $35,$36,$37,$49,$4A,$4B,$4D,$51

DATA_04A054:
	.DB $08,$FC,$FC,$08,$FC,$08,$FC,$08
	.DB $FC,$08,$04,$00,$08,$04,$04,$08
	.DB $04,$08,$04,$00,$04,$08,$04,$00
	.DB $FC,$08,$00,$00,$FC,$08,$FC,$08
	.DB $04,$00,$04,$00,$00,$00,$08,$FC
	.DB $08,$04,$08,$04,$FC,$08,$08,$FC

DATA_04A084:
	.DB $04,$00,$F8,$FF,$08,$00,$FC,$FF
	.DB $F8,$FF,$04,$00,$F8,$FF,$04,$00
	.DB $08,$00,$FC,$FF,$04,$00,$04,$00
	.DB $04,$00,$08,$00,$08,$00,$04,$00
	.DB $F8,$FF,$FC,$FF,$00,$00,$00,$00
	.DB $08,$00,$04,$00,$04,$00,$04,$00
	.DB $F8,$FF,$04,$00,$04,$00,$04,$00
	.DB $08,$00,$FC,$FF,$F8,$FF,$04,$00
	.DB $04,$00,$04,$00,$00,$00,$00,$00
	.DB $04,$00,$04,$00,$04,$00,$F8,$FF
	.DB $04,$00,$08,$00,$FC,$FF,$F8,$FF
	.DB $F8,$FF,$04,$00,$FC,$FF,$08,$00

DATA_04A0E4:
	.DB $02,$02,$02,$02,$02,$00,$02,$02
	.DB $02,$00,$02,$00,$02,$00,$02,$02
	.DB $00,$00,$00,$02,$02,$02,$02,$02

; Overworld level names
; Format: $XXYZ
; XX -> Prefix, Y -> Suffix, Z -> Misc
LevelNames:
	.DW $0000,$0D72,$0D73,$0C00,$0A60,$0A53,$0A54,$0440 ; 000-007
	.DW $0B30,$0A52,$0A71,$0D90,$1101,$1102,$0640,$1207 ; 008-00F
	.DW $1400,$1300,$02C0,$0A7C,$0E33,$0A51,$02C0,$0453 ; 010-017
	.DW $1800,$0453,$0840,$1690,$1625,$1624,$02C0,$1590 ; 018-01F
	.DW $0740,$1700,$1621,$1623,$1622 ; 020-024
	.DW $0340,$0124,$0123,$0110,$0121,$0122,$0D60,$02C0 ; 101-108
	.DW $0D71,$0D83,$0A72,$02C0,$1B00,$1A00,$19B4,$0940 ; 109-110
	.DW $1990,$0000,$19B3,$1960,$19B2,$19B1,$1670,$0D82 ; 111-118
	.DW $0D84,$0D81,$0F30,$0540,$1560,$15A1,$15A4,$15A2 ; 119-120
	.DW $1030,$1577,$15A3,$02C0,$000B,$000A,$0009,$0008 ; 121-128
	.DW $02C0,$1C00,$1D00,$1E00,$00E0,$02C0,$02C0,$02D2 ; 129-130
	.DW $02C0,$02D3,$02C0,$02D1,$02D4,$02D5,$02C0,$02C0 ; 131-138

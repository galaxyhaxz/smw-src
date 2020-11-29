DATA_05D000:	.INCBIN "overworld/layer1/tiles.bin"

DATA_05D608:
	.DB $FF,$1F,$20,$FF,$0B,$0D,$0E,$0F
	.DB $28,$09,$10,$21,$22,$23,$24,$25
	.DB $27,$60,$FF,$12,$02,$07,$FF,$FF
	.DB $4E,$FF,$4D,$4A,$4C,$4B,$36,$35
	.DB $61,$63,$62,$48,$46,$06,$05,$04
	.DB $00,$01,$03,$19,$FF,$1D,$1A,$14
	.DB $44,$45,$42,$3E,$40,$41,$43,$3D
	.DB $3B,$39,$38,$4F,$17,$1B,$15,$29
	.DB $1C,$30,$2A,$32,$2C,$37,$34,$2E
	.DB $6D,$6C,$6B,$6A,$69,$64,$65,$66
	.DB $67,$68,$56,$53,$54,$5F,$57,$59
	.DB $51,$5A,$5D,$50,$5C,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; \
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; | Unused events
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; |
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; /

DATA_05D708:	.DB $00,$60,$C0,$00

DATA_05D70C:	.DB $60,$90,$C0,$00

L2VertScrollSettings:
	.DB $03,$01,$01,$00,$00,$02,$02,$01
	.DB $00,$00,$00,$00,$00,$00,$00,$00

L2HorzScrollSettings:
	.DB $02,$02,$01,$00,$01,$02,$01,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00

DATA_05D730:
	.DB $00,$30,$60,$80,$A0,$B0,$C0,$E0
	.DB $10,$30,$50,$60,$70,$90,$00,$00

DATA_05D740:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $01,$01,$01,$01,$01,$01,$01,$01

DATA_05D750:	.DB $10,$80,$00,$E0,$10,$70,$00,$E0

DATA_05D758:	.DB $00,$00,$00,$00,$01,$01,$01,$01

LevelEntranceTileset:	.DB $05,$01,$02,$06,$08,$01

LevelEntranceLayer1:
	.DL LEVEL_L1_GhostHouseEntrance
	.DL LEVEL_L1_CastleEntrance
	.DL LEVEL_L1_NoYoshiEntrance1
	.DL LEVEL_L1_NoYoshiEntrance2
	.DL LEVEL_L1_NoYoshiEntrance3
	.DL LEVEL_L1_CastleEntrance2

LevelEntranceLayer2:
	.DL LEVEL_L1_BlankEntrance
	.DL Layer2Mountains
	.DL Layer2Mountains
	.DL Layer2Stars
	.DL Layer2Rocks2
	.DL Layer2Black

LevelEntranceLayer3:	.DB $03,$00,$00,$00,$00,$00

LevelEntranceYPos:	.DB $70,$70,$60,$70,$70,$70

CODE_05D796:
	PHB
	PHK
	PLB
	SEP #$30
	STZ wm_ForceNoLevelIntro
	LDA wm_YoshiWingsAboveGrnd
	BNE +
	LDY wm_BonusGameFlag
	BEQ ++
+	JSR CODE_05DBAC
++	LDA wm_NumSubLvEntered
	BNE CODE_05D7B3
	JMP CODE_05D83E

CODE_05D7B3:
	LDX wm_MarioXPos+1
	LDA wm_IsVerticalLvl
	AND #$01
	BEQ +
	LDX wm_MarioYPos+1
+	LDA wm_ExitNumTbl,X
	STA wm_17BB
	STA m14
	LDA wm_OWCharB
	LSR
	LSR
	TAY
	LDA wm_MapData.MarioMap,Y
	BEQ +
	LDA #$01
+	STA m15
	LDA wm_Use2ndExitFlag
	BEQ +
	REP #$30
	LDA #$0000
	SEP #$20
	LDY m14
	LDA DATA_05F800,Y
	STA m14
	STA wm_17BB
	LDA DATA_05FA00,Y
	STA m0
	AND #$0F
	TAX
	LDA.L DATA_05D730,X
	STA wm_MarioYPos
	LDA.L DATA_05D740,X
	STA wm_MarioYPos+1
	LDA m0
	AND #$30
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.L DATA_05D708,X
	STA wm_Bg1VOfs
	LDA m0
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.L DATA_05D70C,X
	STA wm_Bg2VOfs
	LDA DATA_05FC00,Y
	STA m1
	LSR
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.L DATA_05D750,X
	STA wm_MarioXPos
	LDA.L DATA_05D758,X
	STA wm_MarioXPos+1
	LDA DATA_05FE00,Y
	AND #$07
	STA wm_LevelHeaderByte
+	JMP _05D8B7

CODE_05D83E:
	STZ m15
	LDY.B #$00
	LDA wm_ForceLoadLevel
	BNE ++
	REP #$30
	STZ wm_Bg1HOfs
	STZ wm_Bg2HOfs
	LDX wm_OWCharB
	LDA wm_MapData.MarioXPtr,X
	AND #$000F
	STA m0
	LDA wm_MapData.MarioYPtr,X
	AND #$000F
	ASL
	ASL
	ASL
	ASL
	STA m2
	LDA wm_MapData.MarioXPtr,X
	AND #$0010
	ASL
	ASL
	ASL
	ASL
	ORA m0
	STA m0
	LDA wm_MapData.MarioYPtr,X
	AND #$0010
	ASL
	ASL
	ASL
	ASL
	ASL
	ORA m2
	ORA m0
	TAX
	LDA wm_OWCharB
	AND #$00FF
	LSR
	LSR
	TAY
	LDA wm_MapData.MarioMap,Y
	AND #$000F
	BEQ +
	TXA
	CLC
	ADC #$0400
	TAX
+	SEP #$20
	LDA wm_Map16PageL.5,X
	STA wm_TransLvNum
++	CMP #$25
	BCC +
	SEC
	SBC #$24
+	STA wm_17BB
	STA m14
	LDA wm_MapData.MarioMap,Y
	BEQ +
	LDA #$01
+	STA m15
_05D8B7:
	REP #$30
	LDA m14
	ASL
	CLC
	ADC m14
	TAY
	SEP #$20
	LDA Layer1Ptrs,Y
	STA wm_Bg1Ptr
	LDA Layer1Ptrs+1,Y
	STA wm_Bg1Ptr+1
	LDA Layer1Ptrs+2,Y
	STA wm_Bg1Ptr+2
	LDA Layer2Ptrs,Y
	STA wm_Bg2Ptr
	LDA Layer2Ptrs+1,Y
	STA wm_Bg2Ptr+1
	LDA Layer2Ptrs+2,Y
	STA wm_Bg2Ptr+2
	REP #$20
	LDA m14
	ASL
	TAY
	LDA #$0000
	SEP #$20
	LDA SpritePtrs,Y
	STA wm_SprPtr
	LDA SpritePtrs+1,Y
	STA wm_SprPtr+1
	LDA #:SpriteDataBank
	STA wm_SprPtr+2
	LDA [wm_SprPtr]
	AND #$3F
	STA wm_SpriteMemory
	LDA [wm_SprPtr]
	AND #$C0
	STA wm_SpriteBuoyancy
	REP #$10
	SEP #$20
	LDY m14
	LDA DATA_05F000,Y
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.L L2HorzScrollSettings,X
	STA wm_HorzScrollLyr2
	LDA.L L2VertScrollSettings,X
	STA wm_VertScrollLyr2
	LDA #$01
	STA wm_HorzScrollHead
	LDA DATA_05F200,Y
	AND #$C0
	CLC
	ASL
	ROL
	ROL
	STA wm_L3Settings
	STZ wm_Bg1VOfs+1
	STZ wm_Bg2VOfs+1
	LDA DATA_05F600,Y
	AND #$80
	STA wm_DisableNoYoshiIntro
	LDA DATA_05F600,Y
	AND #$60
	LSR
	LSR
	LSR
	LSR
	LSR
	STA wm_IsVerticalLvl
	LDA wm_Use2ndExitFlag
	BNE +
	LDA DATA_05F000,Y
	AND #$0F
	TAX
	LDA.L DATA_05D730,X
	STA wm_MarioYPos
	LDA.L DATA_05D740,X
	STA wm_MarioYPos+1
	LDA DATA_05F200,Y
	STA m2
	AND #$07
	TAX
	LDA.L DATA_05D750,X
	STA wm_MarioXPos
	LDA.L DATA_05D758,X
	STA wm_MarioXPos+1
	LDA m2
	AND #$38
	LSR
	LSR
	LSR
	STA wm_LevelHeaderByte
	LDA DATA_05F400,Y
	STA m2
	AND #$03
	TAX
	LDA.L DATA_05D70C,X
	STA wm_Bg2VOfs
	LDA m2
	AND #$0C
	LSR
	LSR
	TAX
	LDA.L DATA_05D708,X
	STA wm_Bg1VOfs
	LDA DATA_05F600,Y
	STA m1
+	LDA wm_IsVerticalLvl
	AND #$01
	BEQ +
	LDY #$0000
	LDA [wm_Bg1Ptr],Y
	AND #$1F
	STA wm_MarioYPos+1
	INC A
	STA wm_LastScreenVert
	LDA #$01
	STA wm_VertScrollHead
+	LDA wm_NumSubLvEntered
	BNE CODE_05D9EC
	LDA m2
	LSR
	LSR
	LSR
	LSR
	STA wm_DisableMidPoint
	STZ wm_MidwayPointFlag
	LDY wm_TransLvNum
	LDA DATA_05D608,Y
	STA wm_OWLvEndEvent
	SEP #$10
	LDX wm_TransLvNum
	LDA wm_MapData.OwLvFlags,X
	AND #$40
	BEQ CODE_05D9EC
	STA wm_ForceNoLevelIntro
	LDA m2
	LSR
	LSR
	LSR
	LSR
	STA wm_MarioXPos+1
	JMP _05DA17

CODE_05D9EC:
	REP #$10
	LDA m1
	AND #$1F
	STA m1
	LDA wm_IsVerticalLvl
	AND #$01
	BNE CODE_05DA01
	LDA m1
	STA wm_MarioXPos+1
	JMP _05DA17

CODE_05DA01:
	LDA m1
	STA wm_MarioYPos+1
	STA wm_Bg1VOfs+1
	SEP #$10
	LDY wm_VertScrollLyr2
	CPY #$03
	BEQ +
	STA wm_Bg2VOfs+1
+	LDA #$01
	STA wm_VertScrollHead
_05DA17:
	SEP #$30
	LDA wm_TransLvNum
	CMP #$52
	BCC CODE_05DA24
	LDX #$03
	BRA CODE_05DA38

CODE_05DA24:
	LDX #$04
	LDY #$04
	LDA [wm_Bg1Ptr],Y
	AND #$0F
-	CMP.L LevelEntranceTileset,X
	BEQ CODE_05DA38
	DEX
	BPL -
_05DA35:
	JMP _05DAD7

CODE_05DA38:
	LDA wm_NumSubLvEntered
	BNE _05DA35
	LDA wm_ShowMarioStart
	BNE _05DA35
	LDA wm_DisableNoYoshiIntro
	BNE _05DA35
	LDA wm_TransLvNum
	CMP #$31
	BEQ +
	CMP #$32
	BEQ +
	CMP #$34
	BEQ +
	CMP #$35
	BEQ +
	CMP #$40
	BNE ++
+	LDX #$05
++	LDA wm_ForceNoLevelIntro
	BNE +
	LDA.L LevelEntranceYPos,X
	STA wm_MarioYPos
	LDA #$01
	STA wm_MarioYPos+1
	LDA #$30
	STA wm_MarioXPos
	STZ wm_MarioXPos+1
	LDA #$C0
	STA wm_Bg1VOfs
	STA wm_Bg2VOfs
	STZ wm_LevelHeaderByte
	LDA #<LEVEL_SP_0BD
	STA wm_SprPtr
	LDA #>LEVEL_SP_0BD
	STA wm_SprPtr+1
	LDA #:LEVEL_SP_0BD
	STA wm_SprPtr+2
	LDA [wm_SprPtr]
	AND #$3F
	STA wm_SpriteMemory
	LDA [wm_SprPtr]
	AND #$C0
	STA wm_SpriteBuoyancy
	STZ wm_HorzScrollLyr2
	STZ wm_VertScrollLyr2
	STZ wm_HorzScrollHead
	STZ wm_IsVerticalLvl
	LDA.L LevelEntranceLayer3,X
	STA wm_L3Settings
	STX m0
	TXA
	ASL
	CLC
	ADC m0
	TAY
	LDA LevelEntranceLayer1,Y
	STA wm_Bg1Ptr
	LDA LevelEntranceLayer1+1,Y
	STA wm_Bg1Ptr+1
	LDA LevelEntranceLayer1+2,Y
	STA wm_Bg1Ptr+2
	LDA LevelEntranceLayer2,Y
	STA wm_Bg2Ptr
	LDA LevelEntranceLayer2+1,Y
	STA wm_Bg2Ptr+1
	LDA LevelEntranceLayer2+2,Y
	STA wm_Bg2Ptr+2
+	LDA.L LevelEntranceTileset,X
	STA wm_LvHeadTileset
_05DAD7:
	LDA wm_NumSubLvEntered
	BEQ +
	LDA wm_BonusGameFlag
	BNE +
	LDA wm_TransLvNum
	CMP #$24
	BNE +
	JSR CODE_05DAEF
+	PLB
	SEP #$30
	RTL

CODE_05DAEF:
	SEP #$30
	LDY #$04
	LDA [wm_Bg1Ptr],Y
	AND #$C0
	CLC
	ROL
	ROL
	ROL
	JSL ExecutePtrLong

PtrsLong05DAFF:
	.DL CODE_05DB3E
	.DL CODE_05DB6E
	.DL CODE_05DB82

ChocIsld2Layer1:
	.DW LEVEL_L1_0CD
	.DW LEVEL_L1_024_5
	.DW LEVEL_L1_024_5
	.DW LEVEL_L1_0CF
	.DW LEVEL_L1_024_1
	.DW LEVEL_L1_024_2
	.DW LEVEL_L1_0CE
	.DW LEVEL_L1_024_3
	.DW LEVEL_L1_024_4

ChocIsld2Sprites:
	.DW LEVEL_SP_0CD
	.DW LEVEL_SP_024_5
	.DW LEVEL_SP_024_5
	.DW LEVEL_SP_0CF
	.DW LEVEL_SP_024_1
	.DW LEVEL_SP_024_2
	.DW LEVEL_SP_0CE
	.DW LEVEL_SP_024_3
	.DW LEVEL_SP_024_4

ChocIsld2Layer2:
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2
	.DW Layer2Rocks2

CODE_05DB3E:
	LDX #$00
	LDA wm_YoshiCoinsDisp
	CMP #$04
	BEQ _05DB49
	LDX #$02
_05DB49:
	REP #$20
	LDA.L ChocIsld2Layer1,X
	STA wm_Bg1Ptr
	LDA.L ChocIsld2Sprites,X
	STA wm_SprPtr
	LDA.L ChocIsld2Layer2,X
	STA wm_Bg2Ptr
	SEP #$20
	LDA [wm_SprPtr]
	AND #$7F
	STA wm_SpriteMemory
	LDA [wm_SprPtr]
	AND #$80
	STA wm_SpriteBuoyancy
	RTS

CODE_05DB6E:
	LDX #$0A
	LDA wm_GreenStarCoins
	CMP #$16
	BPL +
	LDX #$08
	CMP #$0A
	BPL +
	LDX #$06
+	JMP _05DB49

CODE_05DB82:
	LDX #$0C
	LDA wm_TimerHundreds
	CMP #$02
	BMI ++
	LDA wm_TimerTens
	CMP #$03
	BMI ++
	BNE +
	LDA wm_TimerOnes
	CMP #$05
	BMI ++
+	LDX #$0E
	LDA wm_TimerTens
	CMP #$05
	BMI ++
	LDX #$10
++	JMP _05DB49

DATA_05DBA9:	.DB $00,$C8,$00

CODE_05DBAC:
	LDY #$00
	LDA wm_YoshiWingsAboveGrnd
	BEQ +
	LDY #$01
+	LDX wm_MarioXPos+1
	LDA wm_IsVerticalLvl
	AND #$01
	BEQ +
	LDX wm_MarioYPos+1
+	LDA DATA_05DBA9,Y
	STA wm_ExitNumTbl,X
	INC wm_NumSubLvEntered
	RTS

DATA_05DBC9:	.INCBIN "images/overworld/lifecounter.stim"

UNK_05DBD2: ; unused giant numbers 1-8, beta smw world numbers
	.DB $B8,$3C,$B9,$3C,$BA,$3C,$BB,$3C
	.DB $BA,$3C,$BA,$BC,$BC,$3C,$BD,$3C
	.DB $BE,$3C,$BF,$3C,$C0,$3C,$B7,$BC
	.DB $C1,$3C,$B9,$3C,$C2,$3C,$C2,$BC

CODE_05DBF2:
	PHB
	PHK
	PLB
	LDX #$08
-	LDA.W DATA_05DBC9,X
	STA wm_ImageTable,X
	DEX
	BPL -
	LDX #$00
	LDA wm_OWCharA
	BEQ +
	LDX #$01
+	LDA wm_2PMarioLives,X
	INC A
	JSR CODE_05DC3A
	CPX #$00
	BEQ +
	CLC
	ADC #$22
	STA wm_ImageTable.4.ImgL
	LDA #$39
	STA wm_ImageTable.4.ImgH
	TXA
+	CLC
	ADC #$22
	STA wm_ImageTable.3.ImgL
	LDA #$39
	STA wm_ImageTable.3.ImgH
	LDA #$08
	STA wm_ImageIndex
	SEP #$20
	PLB
	RTL

CODE_05DC3A: ; hex to dec
	LDX #$00
-	CMP #$0A
	BCC Return05DC45
	SBC #$0A
	INX
	BRA -

Return05DC45:
	RTS

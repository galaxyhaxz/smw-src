TilesetMAP16Loc:
	.DW DATA_0D8B70 ; 0 - Normal 1
	.DW DATA_0DBC00 ; 1 - Castle 1
	.DW DATA_0DC800 ; 2 - Rope 1
	.DW DATA_0DD400 ; 3 - Underground 1
	.DW DATA_0DE300 ; 4 - Switch Palace 1
	.DW DATA_0DE300 ; 5 - Ghost House 1
	.DW DATA_0DC800 ; 6 - Rope 2
	.DW DATA_0D8B70 ; 7 - Normal 2
	.DW DATA_0DC800 ; 8 - Rope 3
	.DW DATA_0DD400 ; 9 - Underground 2
	.DW DATA_0DD400 ; A - Switch Palace 2
	.DW DATA_0DD400 ; B - Castle 2
	.DW DATA_0D8B70 ; C - Cloud/Forest
	.DW DATA_0DE300 ; D - Ghost House 2
	.DW DATA_0DD400 ; E - Underground 3

CODE_05801E:
	PHP
	SEP #$20
	REP #$10
	LDX #$0000
-	LDA #$25
	STA wm_L2TilesLo,X
	STA wm_L2TilesLo+$0200,X
	INX
	CPX #$0200
	BNE -
	STZ wm_LvLoadScreen
	LDA wm_Bg2Ptr+2
	CMP #$FF
	BNE ++
	REP #$10
	LDY #$0000
	LDX wm_Bg2Ptr
	CPX #Layer2Cave
	BCC +
	LDY #$0001
+	LDX #$0000
	TYA
-	STA wm_L2TilesHi,X
	STA wm_L2TilesHi+$0200,X
	INX
	CPX #$0200
	BNE -
	LDA #:Layer2BGBank
	STA wm_Bg2Ptr+2
	STZ wm_1932
	STZ wm_LvHeadTileset
	LDX #wm_L2TilesLo&$FFFF
	STX m13
	REP #$20
	JSR CODE_058126
++	SEP #$20
	LDX #$0000
-	LDA #$00
	JSR CODE_05833A
	DEX
	LDA #$25
	JSR CODE_0582C8
	CPX #$0200
	BNE -
	STZ wm_LvLoadScreen
	JSR LoadLevel
	SEP #$30
	LDA wm_GameMode
	CMP #$22
	BPL +
	JSL CODE_02A751
+	PLP
	RTL

CODE_05809E:
	PHP
	SEP #$20
	STZ wm_LvLoadScreen
	REP #$30
	LDA #$FFFF
	STA wm_Map16L1LastLU
	STA wm_Map16L1LastRD
	JSR CODE_05877E
	LDA wm_Map16L1UploadLU
	STA wm_Map16L1UploadRD
	LDA wm_Map16L2UploadLU
	STA wm_Map16L2UploadRD
	LDA #$0202
	STA wm_Layer1ScrollDir
-	REP #$30
	JSL CODE_0588EC
	JSL CODE_058955
	JSL CODE_0087AD
	REP #$30
	INC wm_Map16L1UploadRD
	INC wm_Map16L2UploadRD
	SEP #$30
	LDA wm_Map16L1UploadRD
	LSR
	LSR
	LSR
	REP #$30
	AND #$0006
	TAX
	LDA #$0133
	ASL
	TAY
	LDA #$0007
	STA m0
	LDA.L MAP16AppTable,X
--	STA wm_Map16TilePtrs,Y
	INY
	INY
	CLC
	ADC #$0008
	DEC m0
	BPL --
	SEP #$20
	INC wm_LvLoadScreen
	LDA wm_LvLoadScreen
	CMP #$20
	BNE -
	LDA wm_TM_TMW
	STA TM
	STA TMW
	LDA wm_TS_TSW
	STA TS
	STA TSW
	REP #$20
	LDA #$FFFF
	STA wm_Map16L1LastLU
	STA wm_Map16L1LastRD
	STA wm_Map16L2LastLU
	STA wm_Map16L2LastRD
	PLP
	RTL

CODE_058126:
	PHP
	REP #$30
	LDY #$0000
	STY m3
	STY m5
	SEP #$30
	LDA #$7E
	STA m15
_058136:
	SEP #$20
	REP #$10
	LDY m3
	LDA [wm_Bg2Ptr],Y
	STA m7
	INY
	REP #$20
	STY m3
	SEP #$20
	AND #$80
	BEQ CODE_05816A
	LDA m7
	AND #$7F
	STA m7
	LDA [wm_Bg2Ptr],Y
	INY
	REP #$20
	STY m3
	LDY m5
-	SEP #$20
	STA [m13],Y
	INY
	DEC m7
	BPL -
	REP #$20
	STY m5
	JMP _058188

CODE_05816A:
	REP #$20
	LDY m3
	SEP #$20
	LDA [wm_Bg2Ptr],Y
	INY
	REP #$20
	STY m3
	LDY m5
	SEP #$20
	STA [m13],Y
	REP #$20
	INY
	STY m5
	SEP #$20
	DEC m7
	BPL CODE_05816A
_058188:
	REP #$20
	LDY m3
	SEP #$20
	LDA [wm_Bg2Ptr],Y
	CMP #$FF
	BNE _058136
	INY
	LDA [wm_Bg2Ptr],Y
	CMP #$FF
	BNE _058136
	REP #$20
	LDA.W #DATA_0D9100
	STA m0
	LDX #$0000
-	LDA m0
	STA wm_Map16TilePtrs,X
	LDA m0
	CLC
	ADC #$0008
	STA m0
	INX
	INX
	CPX #$0400
	BNE -
	PLP
	RTS

DATA_0581BB:
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$E0,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $FE,$00,$7F,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$E0,$00,$00,$03,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

CODE_0581FB:
	SEP #$30
	LDA wm_LvHeadTileset
	ASL
	TAX
	LDA #:DATA_0581BB
	STA m15
	LDA #:DATA_00E55E
	STA wm_SlopePart
	LDA #$C4
	STA wm_LowestSolidSprTile
	LDA #$CA
	STA wm_HighestSolidSprTile
	REP #$20
	LDA.W #DATA_00E55E
	STA wm_SlopeSteepness
	LDA.L TilesetMAP16Loc,X
	STA m0
	LDA.W #DATA_0D8000
	STA m2
	LDA.W #DATA_0581BB
	STA m13
	STZ m4
	STZ m9
	STZ m11
	REP #$10
	LDY #$0000
	TYX
_058237:
	SEP #$20
	LDA [m13],Y
	STA m12
_05823D:
	ASL m12
	BCC CODE_058253
	REP #$20
	LDA m2
	STA wm_Map16TilePtrs,X
	LDA m2
	CLC
	ADC #$0008
	STA m2
	JMP _058262

CODE_058253:
	REP #$20
	LDA m0
	STA wm_Map16TilePtrs,X
	LDA m0
	CLC
	ADC #$0008
	STA m0
_058262:
	SEP #$20
	INX
	INX
	INC m9
	INC m11
	LDA m11
	CMP #$08
	BNE _05823D
	STZ m11
	INY
	CPY #$0040
	BNE _058237
	LDA wm_LvHeadTileset
	BEQ +
	CMP #$07
	BNE ++
+	LDA #$FF
	STA wm_LowestSolidSprTile
	STA wm_HighestSolidSprTile
	REP #$30
	LDA.W #DATA_00E5C8
	STA wm_SlopeSteepness
	LDA #$01C4
	ASL
	TAY
	LDA.W #DATA_0D8A70
	STA m0
	LDX #$0003
-	LDA m0
	STA wm_Map16TilePtrs,Y
	CLC
	ADC #$0008
	STA m0
	INY
	INY
	DEX
	BPL -
	LDA #$01EC
	ASL
	TAY
	LDX #$0003
-	LDA m0
	STA wm_Map16TilePtrs,Y
	CLC
	ADC #$0008
	STA m0
	INY
	INY
	DEX
	BPL -
++	SEP #$30
	RTS

CODE_0582C8:
.REPEAT 28 INDEX COUNT
	STA wm_Map16PageL+(COUNT*$0200),X
.ENDR
	INX
	RTS

CODE_05833A:
.REPEAT 28 INDEX COUNT
	STA wm_Map16PageH+(COUNT*$0200),X
.ENDR
	INX
	RTS

LoadLevel:
	PHP
	SEP #$30
	STZ wm_LayerInProcess
	JSR CODE_0584E3
	JSR CODE_0581FB
_LoadAgain:
	LDA wm_LevelHeaderMode
	CMP #$09
	BEQ LoadLevelDone
	CMP #$0B
	BEQ LoadLevelDone
	CMP #$10
	BEQ LoadLevelDone
	LDY #$00
	LDA [wm_Bg1Ptr],Y
	CMP #$FF
	BEQ +
	JSR LoadLevelData
+	SEP #$30
	LDA wm_LevelHeaderMode
	BEQ LoadLevelDone
	CMP #$0A
	BEQ LoadLevelDone
	CMP #$0C
	BEQ LoadLevelDone
	CMP #$0D
	BEQ LoadLevelDone
	CMP #$0E
	BEQ LoadLevelDone
	CMP #$11
	BEQ LoadLevelDone
	CMP #$1E
	BEQ LoadLevelDone
	INC wm_LayerInProcess
	LDA wm_LayerInProcess
	CMP #$02
	BEQ LoadLevelDone
	LDA wm_Bg2Ptr
	CLC
	ADC #$05
	STA wm_Bg1Ptr
	LDA wm_Bg2Ptr+1
	ADC #$00
	STA wm_Bg1Ptr+1
	LDA wm_Bg2Ptr+2
	STA wm_Bg1Ptr+2
	STZ wm_LvLoadScreen
	JMP _LoadAgain

LoadLevelDone:
	STZ wm_LayerInProcess
	PLP
	RTS

VerticalTable:
	.DB $00,$00,$80,$01,$81,$02,$82,$03
	.DB $83,$00,$01,$00,$00,$01,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$80

LevMainScrnTbl:
	.DB $15,$15,$17,$15,$15,$15,$17,$15
	.DB $17,$15,$15,$15,$15,$15,$04,$04
	.DB $15,$17,$15,$15,$15,$15,$15,$15
	.DB $15,$15,$15,$15,$15,$15,$01,$02

LevSubScrnTbl:
	.DB $02,$02,$00,$02,$02,$02,$00,$02
	.DB $00,$00,$02,$00,$02,$02,$13,$13
	.DB $00,$00,$02,$02,$02,$02,$02,$02
	.DB $02,$02,$02,$02,$02,$02,$16,$15

LevCGADSUBtable:
	.DB $24,$24,$24,$24,$24,$24,$20,$24
	.DB $24,$20,$24,$20,$70,$70,$24,$24
	.DB $20,$FF,$24,$24,$24,$24,$24,$24
	.DB $24,$24,$24,$24,$24,$24,$21,$22

SpecialLevTable:
	.DB $00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$C0,$00,$80,$00,$00,$00,$00
	.DB $C1,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00

LevXYPPCCCTtbl:
	.DB $20,$20,$20,$30,$30,$30,$30,$30
	.DB $30,$30,$30,$30,$30,$30,$20,$20
	.DB $30,$30,$30,$30,$30,$30,$30,$30
	.DB $30,$30,$30,$30,$30,$30,$30,$30

TimerTable:	.DB $00,$02,$03,$04

LevelMusicTable:	.DB $02,$06,$01,$08,$07,$03,$05,$12

CODE_0584E3:
	LDY #$00
	LDA [wm_Bg1Ptr],Y
	TAX
	AND #$1F
	INC A
	STA wm_ScreensInLvl
	TXA
	LSR
	LSR
	LSR
	LSR
	LSR
	STA wm_LvHeadBgPal
	INY
	LDA [wm_Bg1Ptr],Y
	AND #$1F
	STA wm_LevelHeaderMode
	TAX
	LDA.L LevXYPPCCCTtbl,X
	STA wm_SpriteProp
	LDA.L LevMainScrnTbl,X
	STA wm_TM_TMW
	LDA.L LevSubScrnTbl,X
	STA wm_TS_TSW
	LDA.L LevCGADSUBtable,X
	STA wm_CgAdSub
	LDA.L SpecialLevTable,X
	STA wm_LevelMode
	LDA.L VerticalTable,X
	STA wm_IsVerticalLvl
	LSR
	LDA wm_ScreensInLvl
	LDX #$01
	BCC +
	TAX
	LDA #$01
+	STA wm_LastScreenHorz
	STX wm_LastScreenVert
	LDA [wm_Bg1Ptr],Y
	LSR
	LSR
	LSR
	LSR
	LSR
	STA wm_LvHeadBgCol
	INY
	LDA [wm_Bg1Ptr],Y
	STA m0
	TAX
	AND #$0F
	STA wm_CurSprGfx
	TXA
	LSR
	LSR
	LSR
	LSR
	AND #$07
	TAX
	LDA.L LevelMusicTable,X
	LDX wm_LevelMusicMod
	BPL +
	ORA #$80
+	CMP wm_LevelMusicMod
	BNE +
	ORA #$40
+	STA wm_LevelMusicMod
	LDA m0
	AND #$80
	LSR
	LSR
	LSR
	LSR
	ORA #$01
	STA wm_BgMode
	INY
	LDA [wm_Bg1Ptr],Y
	STA m0
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA wm_NumSubLvEntered
	BNE +
	LDA.L TimerTable,X
	STA wm_TimerHundreds
	STZ wm_TimerTens
	STZ wm_TimerOnes
+	LDA m0
	AND #$07
	STA wm_LvHeadFgPal
	LDA m0
	AND #$38
	LSR
	LSR
	LSR
	STA wm_LvHeadSprPal
	INY
	LDA [wm_Bg1Ptr],Y
	AND #$0F
	STA wm_LvHeadTileset
	STA wm_1932
	LDA [wm_Bg1Ptr],Y
	AND #$C0
	ASL
	ROL
	ROL
	STA wm_ItemMemHead
	LDA [wm_Bg1Ptr],Y
	AND #$30
	LSR
	LSR
	LSR
	LSR
	CMP #$03
	BNE +
	STZ wm_HorzScrollHead
	LDA #$00
+	STA wm_VertScrollHead
	LDA wm_Bg1Ptr
	CLC
	ADC #$05
	STA wm_Bg1Ptr
	LDA wm_Bg1Ptr+1
	ADC #$00
	STA wm_Bg1Ptr+1
	RTS

CODE_0585D8:
	LDA wm_BlockNum
	BNE +
	LDA wm_BlockSizeType
	CMP #$02
	BCC ++
+	LDA m10
	AND #$0F
	STA m0
	LDA m11
	AND #$0F
	STA m1
	LDA m10
	AND #$F0
	ORA m1
	STA m10
	LDA m11
	AND #$F0
	ORA m0
	STA m11
++	RTS

LoadLevelData:
	SEP #$30
	LDY #$00
	LDA [wm_Bg1Ptr],Y
	STA m10
	INY
	LDA [wm_Bg1Ptr],Y
	STA m11
	INY
	LDA [wm_Bg1Ptr],Y
	STA wm_BlockSizeType
	INY
	TYA
	CLC
	ADC wm_Bg1Ptr
	STA wm_Bg1Ptr
	LDA wm_Bg1Ptr+1
	ADC #$00
	STA wm_Bg1Ptr+1
	LDA m11
	LSR
	LSR
	LSR
	LSR
	STA wm_BlockNum
	LDA m10
	AND #$60
	LSR
	ORA wm_BlockNum
	STA wm_BlockNum
	LDA wm_IsVerticalLvl
	LDY wm_LayerInProcess
	BEQ +
	LSR
+	AND #$01
	BEQ +
	JSR CODE_0585D8
+	LDA m10
	AND #$0F
	ASL
	ASL
	ASL
	ASL
	STA wm_BlockSubScrPos
	LDA m11
	AND #$0F
	ORA wm_BlockSubScrPos
	STA wm_BlockSubScrPos
	REP #$20
	LDA wm_LayerInProcess
	AND #$00FF
	ASL
	TAX
	LDA.L LoadBlkPtrs,X
	STA m3
	LDA.L LoadBlkTable2,X
	STA m6
	LDA wm_LevelHeaderMode
	AND #$001F
	ASL
	TAY
	SEP #$20
	LDA #:LoadBlkTable2 ; I think these are the right order BANK_0
	STA m5
	STA m8
	LDA [m3],Y
	STA m0
	LDA [m6],Y
	STA m13
	INY
	LDA [m3],Y
	STA m1
	LDA [m6],Y
	STA m14
	LDA #:LoadBlkPtrs
	STA m2
	STA m15
	LDA m10
	AND #$80
	ASL
	ADC wm_LvLoadScreen
	STA wm_LvLoadScreen
	STA wm_MirrorScrnNum
	ASL
	CLC
	ADC wm_LvLoadScreen
	TAY
	LDA [m0],Y
	STA wm_Map16BlkPtrL
	LDA [m13],Y
	STA wm_Map16BlkPtrH
	INY
	LDA [m0],Y
	STA wm_Map16BlkPtrL+1
	LDA [m13],Y
	STA wm_Map16BlkPtrH+1
	INY
	LDA [m0],Y
	STA wm_Map16BlkPtrL+2
	LDA [m13],Y
	STA wm_Map16BlkPtrH+2
	LDA m10
	AND #$10
	BEQ +
	INC wm_Map16BlkPtrL+1
	INC wm_Map16BlkPtrH+1
+	LDA wm_BlockNum
	BNE LevLoadJsrNrm
	JSR LevLoadExtObj
	JMP _LevLoadContinue

LevLoadJsrNrm:
	JSR LevLoadNrmObj
_LevLoadContinue:
	SEP #$20
	REP #$10
	LDY #$0000
	LDA [wm_Bg1Ptr],Y
	CMP #$FF
	BEQ LevelDataEnd
	JMP LoadLevelData

LevelDataEnd:
	RTS

LevLoadExtObj:
	SEP #$30
	JSL CODE_0DA100
	RTS

LevLoadNrmObj:
	SEP #$30
	JSL CODE_0DA40F
	RTS

CODE_0586F1:
	PHP
	REP #$30
	JSR CODE_05877E
	SEP #$20
	LDA wm_IsVerticalLvl
	AND #$01
	BNE CODE_058713
	REP #$20
	LDA wm_Layer1ScrollDir
	AND #$00FF
	TAX
	LDA wm_Bg1HOfs
	AND #$FFF0
	CMP wm_Map16L1LastLU,X
	BEQ CODE_058737
	JMP _058724

CODE_058713:
	REP #$20
	LDA wm_Layer1ScrollDir
	AND #$00FF
	TAX
	LDA wm_Bg1VOfs
	AND #$FFF0
	CMP wm_Map16L1LastLU,X
	BEQ CODE_058737
_058724:
	STA wm_Map16L1LastLU,X
	TXA
	EOR #$0002
	TAX
	LDA #$FFFF
	STA wm_Map16L1LastLU,X
	JSL CODE_05881A
	JMP _058774

CODE_058737:
	SEP #$20
	LDA wm_IsVerticalLvl
	AND #$02
	BNE CODE_058753
	REP #$20
	LDA wm_Layer2ScrollDir
	AND #$00FF
	TAX
	LDA wm_Bg2HOfs
	AND #$FFF0
	CMP wm_Map16L2LastLU,X
	BEQ _058774
	JMP _058764

CODE_058753:
	REP #$20
	LDA wm_Layer2ScrollDir
	AND #$00FF
	TAX
	LDA wm_Bg2VOfs
	AND #$FFF0
	CMP wm_Map16L2LastLU,X
	BEQ _058774
_058764:
	STA wm_Map16L2LastLU,X
	TXA
	EOR #$0002
	TAX
	LDA #$FFFF
	STA wm_Map16L2LastLU,X
	JSL CODE_058883
_058774:
	PLP
	RTL

MAP16AppTable:
	.DW DATA_0D8AB0
	.DW Blocks111_152+$22*8 ; 111+22 = block 133
	.DW DATA_0D8AF0
	.DW DATA_0D8B30

CODE_05877E:
	PHP
	SEP #$20
	LDA wm_IsVerticalLvl
	AND #$01
	BNE CODE_0587CB
	REP #$20
	LDA wm_Bg1HOfs
	LSR
	LSR
	LSR
	LSR
	TAY
	SEC
	SBC #$0008
	STA wm_Map16L1UploadLU
	TYA
	CLC
	ADC #$0017
	STA wm_Map16L1UploadRD
	SEP #$30
	LDA wm_Layer1ScrollDir
	TAX
	LDA wm_Map16L1UploadLU,X
	LSR
	LSR
	LSR
	REP #$30
	AND #$0006
	TAX
	LDA #$0133
	ASL
	TAY
	LDA #$0007
	STA m0
	LDA.L MAP16AppTable,X
-	STA wm_Map16TilePtrs,Y
	INY
	INY
	CLC
	ADC #$0008
	DEC m0
	BPL -
	JMP _0587E1

CODE_0587CB:
	REP #$20
	LDA wm_Bg1VOfs
	LSR
	LSR
	LSR
	LSR
	TAY
	SEC
	SBC #$0008
	STA wm_Map16L1UploadLU
	TYA
	CLC
	ADC #$0017
	STA wm_Map16L1UploadRD
_0587E1:
	SEP #$20
	LDA wm_IsVerticalLvl
	AND #$02
	BNE CODE_058802
	REP #$20
	LDA wm_Bg2HOfs
	LSR
	LSR
	LSR
	LSR
	TAY
	SEC
	SBC #$0008
	STA wm_Map16L2UploadLU
	TYA
	CLC
	ADC #$0017
	STA wm_Map16L2UploadRD
	JMP _058818

CODE_058802:
	REP #$20
	LDA wm_Bg2VOfs
	LSR
	LSR
	LSR
	LSR
	TAY
	SEC
	SBC #$0008
	STA wm_Map16L2UploadLU
	TYA
	CLC
	ADC #$0017
	STA wm_Map16L2UploadRD
_058818:
	PLP
	RTS

CODE_05881A:
	SEP #$30
	LDA wm_LevelHeaderMode
	JSL ExecutePtrLong

PtrsLong058823:
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL CODE_058A9B
	.DL CODE_058A9B
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL CODE_058A9B
	.DL CODE_058A9B
	.DL _Return058A9A
	.DL CODE_058A9B
	.DL _Return058A9A
	.DL CODE_0589CE
	.DL CODE_058A9B
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL _Return058A9A
	.DL CODE_0589CE
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL CODE_0589CE
	.DL CODE_0589CE

CODE_058883:
	SEP #$30
	LDA wm_LevelHeaderMode
	JSL ExecutePtrLong

PtrsLong05888C:
	.DL _Return058C70
	.DL CODE_058B8D
	.DL CODE_058B8D
	.DL CODE_058B8D
	.DL CODE_058B8D
	.DL CODE_058C71
	.DL CODE_058C71
	.DL CODE_058C71
	.DL CODE_058C71
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL CODE_058B8D
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL CODE_058B8D

CODE_0588EC:
	SEP #$30
	LDA wm_LevelHeaderMode
	JSL ExecutePtrLong

PtrsLong0588F5:
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL CODE_058A9B
	.DL CODE_058A9B
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL CODE_058A9B
	.DL CODE_058A9B
	.DL _Return058A9A
	.DL CODE_058A9B
	.DL _Return058A9A
	.DL CODE_0589CE
	.DL CODE_058A9B
	.DL CODE_0589CE
	.DL CODE_0589CE
	.DL _Return058A9A
	.DL CODE_0589CE
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL _Return058A9A
	.DL CODE_0589CE
	.DL CODE_0589CE

CODE_058955:
	SEP #$30
	LDA wm_LevelHeaderMode
	JSL ExecutePtrLong

PtrsLong05895E:
	.DL CODE_058D7A
	.DL CODE_058B8D
	.DL CODE_058B8D
	.DL CODE_058B8D
	.DL CODE_058B8D
	.DL CODE_058C71
	.DL CODE_058C71
	.DL CODE_058C71
	.DL CODE_058C71
	.DL _Return058C70
	.DL CODE_058D7A
	.DL _Return058C70
	.DL CODE_058D7A
	.DL CODE_058D7A
	.DL CODE_058D7A
	.DL CODE_058B8D
	.DL _Return058C70
	.DL CODE_058D7A
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL _Return058C70
	.DL CODE_058D7A
	.DL CODE_058B8D

UNK_0589BE: ; unused
	.DB $80,$00,$40,$00,$20,$00,$10,$00
	.DB $08,$00,$04,$00,$02,$00,$01,$00

CODE_0589CE:
	PHP
	REP #$30
	LDA wm_LevelHeaderMode
	AND #$00FF
	ASL
	TAX
	SEP #$20
	LDA.L Ptrs00BDA8,X
	STA m10
	LDA.L Ptrs00BDA8+1,X
	STA m11
	LDA.L Ptrs00BE28,X
	STA m13
	LDA.L Ptrs00BE28+1,X
	STA m14
	LDA #:PtrsGenTileB
	STA m12
	STA m15
	LDA wm_Layer1ScrollDir
	TAX
	LDA wm_Map16L1UploadLU,X
	AND #$0F
	ASL
	STA wm_L1VramUploadAddrH
	LDY #$0020
	LDA wm_Map16L1UploadLU,X
	AND #$10
	BEQ +
	LDY #$0024
+	TYA
	STA wm_L1VramUploadAddrL
	REP #$20
	LDA wm_Map16L1UploadLU,X
	AND #$01F0
	LSR
	LSR
	LSR
	LSR
	STA m0
	ASL
	CLC
	ADC m0
	TAY
	LDA [m10],Y
	STA wm_Map16BlkPtrL
	LDA [m13],Y
	STA wm_Map16BlkPtrH
	SEP #$20
	INY
	INY
	LDA [m10],Y
	STA wm_Map16BlkPtrL+2
	LDA [m13],Y
	STA wm_Map16BlkPtrH+2
	SEP #$10
	LDY #:Map16TilesBank
	LDA wm_LvHeadTileset
	CMP #$10
	BMI +
	LDY #:TilesetMAP16Loc
+	STY m12
	REP #$30
	LDA wm_Map16L1UploadLU,X
	AND #$000F
	STA m8
	LDX #$0000
-	LDY m8
	LDA [wm_Map16BlkPtrL],Y
	AND #$00FF
	STA m0
	LDA [wm_Map16BlkPtrH],Y
	STA m1
	LDA m0
	ASL
	TAY
	LDA wm_Map16TilePtrs,Y
	STA m10
	LDY #$0000
	LDA [m10],Y
	STA wm_OWTilesOnRowL1,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL1.TopLeft+2,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL1.BottomLeft,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL1.BottomLeft+2,X
	INX
	INX
	INX
	INX
	LDA m8
	CLC
	ADC #$0010
	STA m8
	CMP #$01B0
	BCC -
	PLP
_Return058A9A:
	RTL

CODE_058A9B:
	PHP
	REP #$30
	LDA wm_LevelHeaderMode
	AND #$00FF
	ASL
	TAX
	SEP #$20
	LDA.L Ptrs00BDA8,X
	STA m10
	LDA.L Ptrs00BDA8+1,X
	STA m11
	LDA.L Ptrs00BE28,X
	STA m13
	LDA.L Ptrs00BE28+1,X
	STA m14
	LDA #:PtrsGenTileB
	STA m12
	STA m15
	LDA wm_Layer1ScrollDir
	TAX
	LDY #$0020
	LDA wm_Map16L1UploadLU,X
	AND #$10
	BEQ +
	LDY #$0028
+	TYA
	STA m0
	LDA wm_Map16L1UploadLU,X
	LSR
	LSR
	AND #$03
	ORA m0
	STA wm_L1VramUploadAddrL
	LDA wm_Map16L1UploadLU,X
	AND #$03
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	STA wm_L1VramUploadAddrH
	REP #$20
	LDA wm_Map16L1UploadLU,X
	AND #$01F0
	LSR
	LSR
	LSR
	LSR
	STA m0
	ASL
	CLC
	ADC m0
	TAY
	LDA [m10],Y
	STA wm_Map16BlkPtrL
	LDA [m13],Y
	STA wm_Map16BlkPtrH
	SEP #$20
	INY
	INY
	LDA [m10],Y
	STA wm_Map16BlkPtrL+2
	LDA [m13],Y
	STA wm_Map16BlkPtrH+2
	SEP #$10
	LDY #:Map16TilesBank
	LDA wm_LvHeadTileset
	CMP #$10
	BMI +
	LDY #:TilesetMAP16Loc
+	STY m12
	REP #$30
	LDA wm_Map16L1UploadLU,X
	AND #$000F
	ASL
	ASL
	ASL
	ASL
	STA m8
	LDX #$0000
-	LDY m8
	LDA [wm_Map16BlkPtrL],Y
	AND #$00FF
	STA m0
	LDA [wm_Map16BlkPtrH],Y
	STA m1
	LDA m0
	ASL
	TAY
	LDA wm_Map16TilePtrs,Y
	STA m10
	LDY #$0000
	LDA [m10],Y
	STA wm_OWTilesOnRowL1,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL1.BottomLeft,X
	INX
	INX
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL1,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL1.BottomLeft,X
	INX
	INX
	LDA m8
	TAY
	CLC
	ADC #$0001
	STA m8
	AND #$000F
	BNE +
	TYA
	AND #$FFF0
	CLC
	ADC #$0100
	STA m8
+	LDA m8
	AND #$010F
	BNE -
	PLP
	RTL

CODE_058B8D:
	PHP
	REP #$30
	LDA wm_LevelHeaderMode
	AND #$00FF
	ASL
	TAX
	SEP #$20
	LDY #$0000
	LDA wm_LvHeadTileset
	CMP #$03
	BNE +
	LDY #$1000
+	STY m3
	LDA.L Ptrs00BDE8,X
	STA m10
	LDA.L Ptrs00BDE8+1,X
	STA m11
	LDA.L Ptrs00BE68,X
	STA m13
	LDA.L Ptrs00BE68+1,X
	STA m14
	LDA #:PtrsGenTileB
	STA m12
	STA m15
	LDA wm_Layer2ScrollDir
	TAX
	LDA wm_Map16L2UploadLU,X
	AND #$0F
	ASL
	STA wm_L2VramUploadAddrH
	LDY #$0030
	LDA wm_Map16L2UploadLU,X
	AND #$10
	BEQ +
	LDY #$0034
+	TYA
	STA wm_L2VramUploadAddrL
	REP #$30
	LDA wm_Map16L2UploadLU,X
	AND #$01F0
	LSR
	LSR
	LSR
	LSR
	STA m0
	ASL
	CLC
	ADC m0
	TAY
	LDA [m10],Y
	STA wm_Map16BlkPtrL
	LDA [m13],Y
	STA wm_Map16BlkPtrH
	SEP #$20
	INY
	INY
	LDA [m10],Y
	STA wm_Map16BlkPtrL+2
	LDA [m13],Y
	STA wm_Map16BlkPtrH+2
	SEP #$10
	LDY #:Map16TilesBank
	LDA wm_LvHeadTileset
	CMP #$10
	BMI +
	LDY #:TilesetMAP16Loc
+	STY m12
	REP #$30
	LDA wm_Map16L2UploadLU,X
	AND #$000F
	STA m8
	LDX #$0000
-	LDY m8
	LDA [wm_Map16BlkPtrL],Y
	AND #$00FF
	STA m0
	LDA [wm_Map16BlkPtrH],Y
	STA m1
	LDA m0
	ASL
	TAY
	LDA wm_Map16TilePtrs,Y
	STA m10
	LDY #$0000
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2,X
	INY
	INY
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2.TopLeft+2,X
	INY
	INY
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2.BottomLeft,X
	INY
	INY
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2.BottomLeft+2,X
	INX
	INX
	INX
	INX
	LDA m8
	CLC
	ADC #$0010
	STA m8
	CMP #$01B0
	BCC -
	PLP
_Return058C70:
	RTL

CODE_058C71:
	PHP
	REP #$30
	LDA wm_LevelHeaderMode
	AND #$00FF
	ASL
	TAX
	SEP #$20
	LDY #$0000
	LDA wm_LvHeadTileset
	CMP #$03
	BNE +
	LDY #$1000
+	STY m3
	LDA.L Ptrs00BDE8,X
	STA m10
	LDA.L Ptrs00BDE8+1,X
	STA m11
	LDA.L Ptrs00BE68,X
	STA m13
	LDA.L Ptrs00BE68+1,X
	STA m14
	LDA #:PtrsGenTileB
	STA m12
	STA m15
	LDA wm_Layer2ScrollDir
	TAX
	LDY #$0030
	LDA wm_Map16L2UploadLU,X
	AND #$10
	BEQ +
	LDY #$0038
+	TYA
	STA m0
	LDA wm_Map16L2UploadLU,X
	LSR
	LSR
	AND #$03
	ORA m0
	STA wm_L2VramUploadAddrL
	LDA wm_Map16L2UploadLU,X
	AND #$03
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	STA wm_L2VramUploadAddrH
	REP #$20
	LDA wm_Map16L2UploadLU,X
	AND #$01F0
	LSR
	LSR
	LSR
	LSR
	STA m0
	ASL
	CLC
	ADC m0
	TAY
	LDA [m10],Y
	STA wm_Map16BlkPtrL
	LDA [m13],Y
	STA wm_Map16BlkPtrH
	SEP #$20
	INY
	INY
	LDA [m10],Y
	STA wm_Map16BlkPtrL+2
	LDA [m13],Y
	STA wm_Map16BlkPtrH+2
	SEP #$10
	LDY #:Map16TilesBank
	LDA wm_LvHeadTileset
	CMP #$10
	BMI +
	LDY #:TilesetMAP16Loc
+	STY m12
	REP #$30
	LDA wm_Map16L2UploadLU,X
	AND #$000F
	ASL
	ASL
	ASL
	ASL
	STA m8
	LDX #$0000
-	LDY m8
	LDA [wm_Map16BlkPtrL],Y
	AND #$00FF
	STA m0
	LDA [wm_Map16BlkPtrH],Y
	STA m1
	LDA m0
	ASL
	TAY
	LDA wm_Map16TilePtrs,Y
	STA m10
	LDY #$0000
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2,X
	INY
	INY
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2.BottomLeft,X
	INX
	INX
	INY
	INY
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2,X
	INY
	INY
	LDA [m10],Y
	ORA m3
	STA wm_OWTilesOnRowL2.BottomLeft,X
	INX
	INX
	LDA m8
	TAY
	CLC
	ADC #$0001
	STA m8
	AND #$000F
	BNE +
	TYA
	AND #$FFF0
	CLC
	ADC #$0100
	STA m8
+	LDA m8
	AND #$010F
	BNE -
	PLP
	RTL

CODE_058D7A:
	PHP
	SEP #$30
	LDA wm_LvLoadScreen
	AND #$0F
	ASL
	STA wm_L2VramUploadAddrH
	LDY #$30
	LDA wm_LvLoadScreen
	AND #$10
	BEQ +
	LDY #$34
+	TYA
	STA wm_L2VramUploadAddrL
	REP #$20
	LDA #wm_L2TilesLo&$FFFF
	STA wm_Map16BlkPtrL
	LDA #wm_L2TilesHi&$FFFF
	STA wm_Map16BlkPtrH
	LDA.W #DATA_0D9100
	STA m10
	LDA wm_LvLoadScreen
	AND #$00F0
	BEQ +
	LDA wm_Map16BlkPtrL
	CLC
	ADC #$01B0
	STA wm_Map16BlkPtrL
	LDA wm_Map16BlkPtrH
	CLC
	ADC #$01B0
	STA wm_Map16BlkPtrH
+	SEP #$20
	LDA #$7E
	STA wm_Map16BlkPtrL+2
	LDA #$7E
	STA wm_Map16BlkPtrH+2
	LDY #:DATA_0D9100
	STY m12
	REP #$30
	LDA wm_LvLoadScreen
	AND #$000F
	STA m8
	LDX #$0000
-	LDY m8
	LDA [wm_Map16BlkPtrL],Y
	AND #$00FF
	STA m0
	LDA [wm_Map16BlkPtrH],Y
	STA m1
	LDA m0
	ASL
	ASL
	ASL
	TAY
	LDA [m10],Y
	STA wm_OWTilesOnRowL2,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL2.TopLeft+2,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL2.BottomLeft,X
	INY
	INY
	LDA [m10],Y
	STA wm_OWTilesOnRowL2.BottomLeft+2,X
	INX
	INX
	INX
	INX
	LDA m8
	CLC
	ADC #$0010
	STA m8
	CMP #$01B0
	BCC -
	PLP
	RTL

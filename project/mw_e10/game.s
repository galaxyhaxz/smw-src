Start:
	SEI
	STZ NMITIMEN
	STZ HDMAEN
	STZ MDMAEN
	STZ APUIO0
	STZ APUIO1
	STZ APUIO2
	STZ APUIO3
	LDA #$80
	STA INIDISP
	CLC
	XCE
	REP #$38
	LDA #$0000
	TCD
	LDA #$01FF
	TCS
	LDA #$F0A9
	STA wm_ClearOam.LoadYPos
	LDX #$017D
	LDY #$03FD
-	LDA #$008D
	STA wm_ClearOam.ExOam1,X
	TYA
	STA wm_ClearOam.ExOam1+1,X
	SEC
	SBC #$0004
	TAY
	DEX
	DEX
	DEX
	BPL -
	SEP #$30
	LDA #$6B
	STA wm_ClearOam.Return
	JSR UploadSPCEngine
	STZ wm_GameMode
	STZ wm_ForceLoadLevel
	JSR ClearStack
	JSR UploadSamples
	JSR CODE_009250
	LDA #$03
	STA OBJSEL
	INC wm_ExecuteGame
-	LDA wm_ExecuteGame
	BEQ -
	CLI
	INC wm_FrameA
	JSR GetGameMode
	STZ wm_ExecuteGame
	BRA -

SPC700UploadLoop:
	PHP
	REP #$30
	LDY #$0000
	LDA #$BBAA
-	CMP APUIO0
	BNE -
	SEP #$20
	LDA #$CC
	BRA _0080B3

CODE_00808D:
	LDA [m0],Y
	INY
	XBA
	LDA #$00
	BRA _0080A0

CODE_008095:
	XBA
	LDA [m0],Y
	INY
	XBA
-	CMP APUIO0
	BNE -
	INC A
_0080A0:
	REP #$20
	STA APUIO0
	SEP #$20
	DEX
	BNE CODE_008095
-	CMP APUIO0
	BNE -
-	ADC #$03
	BEQ -
_0080B3:
	PHA
	REP #$20
	LDA [m0],Y
	INY
	INY
	TAX
	LDA [m0],Y
	INY
	INY
	STA APUIO2
	SEP #$20
	CPX #$0001
	LDA #$00
	ROL
	STA APUIO1
	ADC #$7F
	PLA
	STA APUIO0
-	CMP APUIO0
	BNE -
	BVS CODE_00808D
	STZ APUIO0
	STZ APUIO1
	STZ APUIO2
	STZ APUIO3
	PLP
	RTS

UploadSPCEngine:
	LDA #<SPC700_Engine
	STA.W m0
	LDA #>SPC700_Engine
	STA.W m1
	LDA #:SPC700_Engine
	STA.W m2
_UploadDataToSPC:
	SEI
	JSR SPC700UploadLoop
	CLI
	RTS

UploadSamples:
	LDA #<SPC700_Samples
	STA.W m0
	LDA #>SPC700_Samples
	STA.W m1
	LDA #:SPC700_Samples
	STA.W m2
	BRA _StrtSPCMscUpld

UploadMusicBank1:
	LDA #<SPC700_Music0
	STA.W m0
	LDA #>SPC700_Music0
	STA.W m1
	LDA #:SPC700_Music0
	STA.W m2
_StrtSPCMscUpld:
	LDA #$FF
	STA APUIO1
	JSR _UploadDataToSPC
	LDX.B #$03
-	STZ APUIO0,X
	STZ wm_SoundCh1,X
	STZ wm_1DFD,X
	DEX
	BPL -
_008133:
	RTS

CODE_008134:
	LDA wm_BonusGameFlag
	BNE +
	LDA wm_ForceLoadLevel
	CMP #$E9
	BEQ +
	ORA wm_NumSubLvEntered
	ORA wm_ShowMarioStart
	BNE _008133
+	LDA #<SPC700_Music1
	STA.W m0
	LDA #>SPC700_Music1
	STA.W m1
	LDA #:SPC700_Music1
	STA.W m2
	BRA _StrtSPCMscUpld

UploadMusicBank3:
	LDA #<SPC700_Music2
	STA.W m0
	LDA #>SPC700_Music2
	STA.W m1
	LDA #:SPC700_Music2
	STA.W m2
	BRA _StrtSPCMscUpld

VBlank:
	SEI
	PHP
	REP #$30
	PHA
	PHX
	PHY
	PHB
	PHK
	PLB
	SEP #$30
	LDA RDNMI
	LDA wm_MusicCh1
	BNE +
	LDY APUIO2
	CPY wm_MirrorMusicCh
	BNE ++
+	STA APUIO2
	STA wm_MirrorMusicCh
	STZ wm_MusicCh1
++	LDA wm_SoundCh1
	STA APUIO0
	LDA wm_SoundCh2
	STA APUIO1
	LDA wm_SoundCh3
	STA APUIO3
	STZ wm_SoundCh1
	STZ wm_SoundCh2
	STZ wm_SoundCh3
	LDA #$80
	STA INIDISP
	STZ HDMAEN
	LDA wm_W12Sel
	STA W12SEL
	LDA wm_W34Sel
	STA W34SEL
	LDA wm_WObjSel
	STA WOBJSEL
	LDA wm_CgSwSel
	STA CGSWSEL
	LDA wm_LevelMode
	BPL CODE_0081CE
	JMP CODE_0082C4

CODE_0081CE:
	LDA wm_CgAdSub
	AND #$FB
	STA CGADSUB
	LDA #$09
	STA BGMODE
	LDA wm_ExecuteGame
	BEQ CODE_0081E7
	LDA wm_LevelMode
	LSR
	BEQ _NMINotSpecialLv
	JMP _00827A

CODE_0081E7:
	INC wm_ExecuteGame
	JSR MoreDMA
	LDA wm_LevelMode
	LSR
	BNE CODE_008222
	BCS +
	JSR DrawStatusBar
+	LDA wm_CutsceneNum
	CMP #$08
	BNE CODE_008209
	LDA wm_UpdateCreditBG
	BEQ _00821A
	JSL CODE_0C9567
	BRA _00821A

CODE_008209:
	JSL CODE_0087AD
	LDA wm_UseBigMsg
	BEQ CODE_008217
	JSR CODE_00A7C2
	BRA _00823D

CODE_008217:
	JSR CODE_00A390
_00821A:
	JSR CODE_00A436
	JSR MarioGFXDMA
	BRA _00823D

CODE_008222:
	LDA wm_OWProcessPtr
	CMP #$0A
	BNE CODE_008237
	LDY wm_OWSubmapSwitchIndex
	DEY
	DEY
	CPY #$04
	BCS CODE_008237
	JSR CODE_00A529
	BRA _008243

CODE_008237:
	JSR CODE_00A4E3
	JSR MarioGFXDMA
_00823D:
	JSR LoadScrnImage
	JSR DoSomeSpriteDMA
_008243:
	JSR ControllerUpdate
_NMINotSpecialLv:
	LDA wm_Bg1HOfs
	STA BG1HOFS
	LDA wm_Bg1HOfs+1
	STA BG1HOFS
	LDA wm_Bg1VOfs
	CLC
	ADC wm_Layer1DispYLo
	STA BG1VOFS
	LDA wm_Bg1VOfs+1
	ADC wm_Layer1DispYHi
	STA BG1VOFS
	LDA wm_Bg2HOfs
	STA BG2HOFS
	LDA wm_Bg2HOfs+1
	STA BG2HOFS
	LDA wm_Bg2VOfs
	STA BG2VOFS
	LDA wm_Bg2VOfs+1
	STA BG2VOFS
	LDA wm_LevelMode
	BEQ CODE_008292
_00827A:
	LDA #$81
	LDY wm_CutsceneNum
	CPY #$08
	BNE _0082A1
	LDY wm_IniDisp
	STY INIDISP
	LDY wm_HDMAEn
	STY HDMAEN
	JMP _IRQNMIEnding

CODE_008292:
	LDY #$24
_008294:
	LDA TIMEUP
	STY VTIMEL
	STZ VTIMEH
	STZ wm_IRQMode
	LDA #$A1
_0082A1:
	STA NMITIMEN
	STZ BG3HOFS
	STZ BG3HOFS
	STZ BG3VOFS
	STZ BG3VOFS
	LDA wm_IniDisp
	STA INIDISP
	LDA wm_HDMAEn
	STA HDMAEN
	REP #$30
	PLB
	PLY
	PLX
	PLA
	PLP
EmptyHandler:
	RTI

CODE_0082C4:
	LDA wm_ExecuteGame
	BNE _0082F7
	INC wm_ExecuteGame
	LDA wm_UseBigMsg
	BEQ CODE_0082D4
	JSR CODE_00A7C2
	BRA _0082E8

CODE_0082D4:
	JSR CODE_00A436
	JSR MarioGFXDMA
	BIT wm_LevelMode
	BVC _0082E8
	JSR CODE_0098A9
	LDA wm_LevelMode
	LSR
	BCS +
_0082E8:
	JSR DrawStatusBar
+	JSR MoreDMA
	JSR LoadScrnImage
	JSR DoSomeSpriteDMA
	JSR ControllerUpdate
_0082F7:
	LDA.B #$09
	STA BGMODE
	LDA wm_M7X
	CLC
	ADC.B #$80
	STA M7X
	LDA wm_M7X+1
	ADC.B #$00
	STA M7X
	LDA wm_M7Y
	CLC
	ADC.B #$80
	STA M7Y
	LDA wm_M7Y+1
	ADC.B #$00
	STA M7Y
	LDA wm_M7A
	STA M7A
	LDA wm_M7A+1
	STA M7A
	LDA wm_M7B
	STA M7B
	LDA wm_M7B+1
	STA M7B
	LDA wm_M7C
	STA M7C
	LDA wm_M7C+1
	STA M7C
	LDA wm_M7D
	STA M7D
	LDA wm_M7D+1
	STA M7D
	JSR SETL1SCROLL
	LDA wm_LevelMode
	LSR
	BCC CODE_00835C
	LDA wm_IniDisp
	STA INIDISP
	LDA wm_HDMAEn
	STA HDMAEN
	LDA.B #$81
	JMP CODE_0083F3

CODE_00835C:
	LDY.B #$24
	BIT wm_LevelMode
	BVC +
	LDA wm_M7BossGfxIndex
	ASL
	TAX
	LDA.W DATA_00F8E8,X
	CMP.B #$2A
	BNE +
	LDY.B #$2D
+	JMP _008294

IRQBlank:
	SEI
	PHP
	REP #$30
	PHA
	PHX
	PHY
	PHB
	PHK
	PLB
	SEP #$30
	LDA TIMEUP
	BPL _0083B2
	LDA #$81
	LDY wm_LevelMode
	BMI CODE_0083BA
_IRQNMIEnding:
	STA NMITIMEN
	LDY #$1F
	JSR _WaitForHBlank
	LDA wm_Bg3HOfs
	STA BG3HOFS
	LDA wm_Bg3HOfs+1
	STA BG3HOFS
	LDA wm_Bg3VOfs
	STA BG3VOFS
	LDA wm_Bg3VOfs+1
	STA BG3VOFS
_0083A8:
	LDA wm_BgMode
	STA BGMODE
	LDA wm_CgAdSub
	STA CGADSUB
_0083B2:
	REP #$30
	PLB
	PLY
	PLX
	PLA
	PLP
	RTI

CODE_0083BA:
	BIT wm_LevelMode
	BVC _0083E3
	LDY wm_IRQMode
	BEQ CODE_0083D0
	STA NMITIMEN
	LDY.B #$14
	JSR _WaitForHBlank
	JSR SETL1SCROLL
	BRA _0083A8

CODE_0083D0:
	INC wm_IRQMode
	LDA TIMEUP
	LDA.B #$AE
	SEC
	SBC wm_Layer1DispYLo
	STA VTIMEL
	STZ VTIMEH
	LDA.B #$A1
_0083E3:
	LDY wm_EndLevelTimer
	BEQ CODE_0083F3
	LDY wm_ColorFadeTimer
	CPY.B #$40
	BCC CODE_0083F3
	LDA.B #$81
	BRA _IRQNMIEnding

CODE_0083F3:
	STA NMITIMEN
	JSR CODE_008439
	NOP
	NOP
	LDA.B #$07
	STA BGMODE
	LDA wm_M7Bg1HOfs
	STA BG1HOFS
	LDA wm_M7Bg1HOfs+1
	STA BG1HOFS
	LDA wm_M7Bg1VOfs
	STA BG1VOFS
	LDA wm_M7Bg1VOfs+1
	STA BG1VOFS
	BRA _0083B2

SETL1SCROLL:
	LDA.B #$59
	STA BG1SC
	LDA.B #$07
	STA BG12NBA
	LDA wm_Bg1HOfs
	STA BG1HOFS
	LDA wm_Bg1HOfs+1
	STA BG1HOFS
	LDA wm_Bg1VOfs
	CLC
	ADC wm_Layer1DispYLo
	STA BG1VOFS
	LDA wm_Bg1VOfs+1
	STA BG1VOFS
	RTS

CODE_008439:
	LDY.B #$20
_WaitForHBlank:
	BIT HVBJOY
	BVS CODE_008439
-	BIT HVBJOY
	BVC -
-	DEY
	BNE -
	RTS

DoSomeSpriteDMA:
	STZ CH0.PARAM
	REP #$20
	STZ OAMADDL
	LDA #$0004
	STA CH0.ADDB
	LDA #$0002
	STA CH0.ADDA1M
	LDA #$0220
	STA CH0.DATAL
	LDY.B #$01
	STY MDMAEN
	SEP #$20
	LDA #$80
	STA OAMADDH
	LDA wm_OAMAddL
	STA OAMADDL
	RTS

DATA_008475:
	.DW $00,$08,$10,$18,$20,$28,$30,$38
	.DW $40,$48,$50,$58,$60,$68,$70
	.DB $78 ; High byte of following code not used

CODE_008494:
	LDY.B #$1E
-	LDX.W DATA_008475,Y
	LDA wm_ExOamSize.4,X
	ASL
	ASL
	ORA wm_ExOamSize.3,X
	ASL
	ASL
	ORA wm_ExOamSize.2,X
	ASL
	ASL
	ORA wm_ExOamSize.1,X
	STA wm_OamHiX,Y
	LDA wm_ExOamSize.8,X
	ASL
	ASL
	ORA wm_ExOamSize.7,X
	ASL
	ASL
	ORA wm_ExOamSize.6,X
	ASL
	ASL
	ORA wm_ExOamSize.5,X
	STA wm_OamHiX+1,Y
	DEY
	DEY
	BPL -
	RTS

CODE_0084C8:
	PHB
	PHK
	PLB
	JSR LoadScrnImage
	PLB
	RTL

ImagePointers:
	.DL wm_ImageTable
	.DL DATA_05B375 ; Title screen
	.DL DATA_04A400 ; OW border
	.DL DATA_05B0FF ; Remove text box
	.DL DATA_05B91C ; CONTINUE/END
	.DL CutsceneBG@CookieMtn
	.DL DATA_05B872 ; 1 PLAYER GAME/2 PLAYER GAME
	.DL DATA_04819F ; OW scroll arrows
	.DL DATA_0481E0 ; Remove OW scroll arrows
	.DL DATA_04F499 ; Remove menu
	.DL DATA_05B8C7 ; CONTINUE AND SAVE
	.DL Cutscene2@Line1-1,Cutscene1@Line7,Cutscene1@Line6,Cutscene1@Line5,Cutscene1@Line4,Cutscene1@Line3,Cutscene1@Line2,Cutscene1@Line1
	.DL Cutscene2@Line8,Cutscene2@Line7,Cutscene2@Line6,Cutscene2@Line5,Cutscene2@Line4,Cutscene2@Line3,Cutscene2@Line2,Cutscene2@Line1
	.DL Cutscene2@Line1-1,Cutscene3@Line7,Cutscene3@Line6,Cutscene3@Line5,Cutscene3@Line4,Cutscene3@Line3,Cutscene3@Line2,Cutscene3@Line1
	.DL Cutscene4@Line8,Cutscene4@Line7,Cutscene4@Line6,Cutscene4@Line5,Cutscene4@Line4,Cutscene4@Line3,Cutscene4@Line2,Cutscene4@Line1
	.DL Cutscene2@Line1-1,Cutscene5@Line7,Cutscene5@Line6,Cutscene5@Line5,Cutscene5@Line4,Cutscene5@Line3,Cutscene5@Line2,Cutscene5@Line1
	.DL Cutscene6@Line8,Cutscene6@Line7,Cutscene6@Line6,Cutscene6@Line5,Cutscene6@Line4,Cutscene6@Line3,Cutscene6@Line2,Cutscene6@Line1
	.DL Cutscene7@Line8,Cutscene7@Line7,Cutscene7@Line6,Cutscene7@Line5,Cutscene7@Line4,Cutscene7@Line3,Cutscene7@Line2,Cutscene7@Line1
	.DL CutsceneBG@Cave
	.DL CutsceneBG@ChocoIsland
	.DL CutsceneBG@Castle
	.DL DATA_0C9380 ; Black
	.DL DATA_0CB636 ; Ending: THE END
	.DL EndingScene@1 ; Lakitu
	.DL EndingScene@2 ; Hammer Bro.
	.DL EndingScene@3 ; Pokey
	.DL EndingScene@4 ; Rex
	.DL EndingScene@5 ; Dino-Rhino
	.DL EndingScene@6 ; Blargg
	.DL EndingScene@7 ; Urchin
	.DL EndingScene@8 ; Boo
	.DL EndingScene@9 ; Dry Bones
	.DL EndingScene@10 ; Grinder
	.DL EndingScene@11 ; Reznor
	.DL EndingScene@12 ; Mechakoopa
	.DL EndingScene@13 ; Bowser
	.DL CutsceneBG@Overworld ; Cutscene border, overworld

LoadScrnImage:
	LDY wm_ImageLoader
	LDA ImagePointers,Y
	STA m0
	LDA ImagePointers+1,Y
	STA m1
	LDA ImagePointers+2,Y
	STA m2
	JSR CODE_00871E
	LDA wm_ImageLoader
	BNE +
	STA wm_ImageIndex
	STA wm_ImageIndex+1
	DEC A
	STA wm_ImageTable
+	STZ wm_ImageLoader
	RTS

CODE_0085FA:
	JSR TurnOffIO
	LDA #$FC
	STA m0
	STZ VMAINC
	STZ VMADDL
	LDA #$50
	STA VMADDH
	LDX.B #$06
-	LDA.W PARAMS_008649,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDY.B #$02
	STY MDMAEN
	LDA #$38
	STA m0
	LDA #$80
	STA VMAINC
	STZ VMADDL
	LDA #$50
	STA VMADDH
	LDX.B #$06
-	LDA.W PARAMS_008649,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$19
	STA CH1.ADDB
	STY MDMAEN
	STZ wm_OAMAddL
	JSL wm_ClearOam
	JMP DoSomeSpriteDMA

PARAMS_008649:
	.DB $08,$18
	.DL $000000
	.DB $00,$10

ControllerUpdate:
	LDA JOY1L
	AND #$F0
	STA wm_JoyPadBP1
	TAY
	EOR wm_JoyDisP1H
	AND wm_JoyPadBP1
	STA wm_JoyFrameBP1
	STY wm_JoyDisP1H
	LDA JOY1H
	STA wm_JoyPadAP1
	TAY
	EOR wm_JoyDisP1L
	AND wm_JoyPadAP1
	STA wm_JoyFrameAP1
	STY wm_JoyDisP1L
	LDA JOY2L
	AND #$F0
	STA wm_JoyPadBP2
	TAY
	EOR wm_JoyDisP2H
	AND wm_JoyPadBP2
	STA wm_JoyFrameBP2
	STY wm_JoyDisP2H
	LDA JOY2H
	STA wm_JoyPadAP2
	TAY
	EOR wm_JoyDisP2L
	AND wm_JoyPadAP2
	STA wm_JoyFrameAP2
	STY wm_JoyDisP2L
	LDX wm_JoyPort
	BPL +
	LDX wm_OWCharA
+	LDA wm_JoyPadBP1,X
	AND #$C0
	ORA wm_JoyPadAP1,X
	STA wm_JoyPadA
	LDA wm_JoyPadBP1,X
	STA wm_JoyPadB
	LDA wm_JoyFrameBP1,X
	AND #$40
	ORA wm_JoyFrameAP1,X
	STA wm_JoyFrameA
	LDA wm_JoyFrameBP1,X
	STA wm_JoyFrameB
	RTS

CODE_0086C7:
	REP #$30
	LDX #$0062
	LDA #$0202
-	STA wm_ExOamSize.1,X
	DEX
	DEX
	BPL -
	SEP #$30
	LDA #$F0
	JSL wm_ClearOam.Oam37
	RTS

ExecutePtr:
	STY m3
	PLY
	STY m0
	REP #$30
	AND #$00FF
	ASL
	TAY
	PLA
	STA m1
	INY
	LDA [m0],Y
	STA m0
	SEP #$30
	LDY m3
	JMP [m0]

ExecutePtrLong:
	STY m5
	PLY
	STY m2
	REP #$30
	AND #$00FF
	STA m3
	ASL
	ADC m3
	TAY
	PLA
	STA m3
	INY
	LDA [m2],Y
	STA m0
	INY
	LDA [m2],Y
	STA m1
	SEP #$30
	LDY m5
	JMP [m0]

CODE_00871E:
	REP #$10
	STA CH1.ADDA1H
	LDY #$0000
_008726:
	LDA [m0],Y
	BPL CODE_00872D
	SEP #$30
	RTS

CODE_00872D:
	STA m4
	INY
	LDA [m0],Y
	STA m3
	INY
	LDA [m0],Y
	STZ m7
	ASL
	ROL m7
	LDA #$18
	STA CH1.ADDB
	LDA [m0],Y
	AND #$40
	LSR
	LSR
	LSR
	STA m5
	STZ m6
	ORA #$01
	STA CH1.PARAM
	REP #$20
	LDA m3
	STA VMADDL
	LDA [m0],Y
	XBA
	AND #$3FFF
	TAX
	INX
	INY
	INY
	TYA
	CLC
	ADC m0
	STA CH1.ADDA1L
	STX CH1.DATAL
	LDA m5
	BEQ +
	SEP #$20
	LDA m7
	STA VMAINC
	LDA #$02
	STA MDMAEN
	LDA #$19
	STA CH1.ADDB
	REP #$21
	LDA m3
	STA VMADDL
	TYA
	ADC m0
	INC A
	STA CH1.ADDA1L
	STX CH1.DATAL
	LDX.W #$02
+	STX m3
	TYA
	CLC
	ADC m3
	TAY
	SEP #$20
	LDA m7
	ORA #$80
	STA VMAINC
	LDA #$02
	STA MDMAEN
	JMP _008726

CODE_0087AD:
	SEP #$30
	LDA wm_L1VramUploadAddrL
	BNE CODE_0087B7
	JMP _0088DD

CODE_0087B7:
	LDA wm_IsVerticalLvl
	AND #$01
	BEQ CODE_0087C0
	JMP CODE_008849

CODE_0087C0:
	LDY #$81
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A16,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	CLC
	ADC #$08
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A1D,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	INC A
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A24,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	INC A
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	CLC
	ADC #$08
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A2B,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	JMP _0088DD

CODE_008849:
	LDY #$80
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A16,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	CLC
	ADC #$04
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A1D,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$40
	STA CH1.DATAL
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	CLC
	ADC #$20
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A24,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L1VramUploadAddrH
	CLC
	ADC #$20
	STA VMADDL
	LDA wm_L1VramUploadAddrL
	CLC
	ADC #$04
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A2B,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$40
	STA CH1.DATAL
	LDA #$02
	STA MDMAEN
_0088DD:
	LDA #$00
	STA wm_L1VramUploadAddrL
	LDA wm_L2VramUploadAddrL
	BNE CODE_0088EA
	JMP _008A10

CODE_0088EA:
	LDA wm_IsVerticalLvl
	AND #$02
	BEQ CODE_0088F3
	JMP CODE_00897C

CODE_0088F3:
	LDY #$81
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A32,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	CLC
	ADC #$08
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A39,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	INC A
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A40,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	INC A
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	CLC
	ADC #$08
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A47,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	JMP _008A10

CODE_00897C:
	LDY #$80
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A32,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	CLC
	ADC #$04
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A39,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$40
	STA CH1.DATAL
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	CLC
	ADC #$20
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A40,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	STY VMAINC
	LDA wm_L2VramUploadAddrH
	CLC
	ADC #$20
	STA VMADDL
	LDA wm_L2VramUploadAddrL
	CLC
	ADC #$04
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008A47,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$40
	STA CH1.DATAL
	LDA #$02
	STA MDMAEN
_008A10:
	LDA #$00
	STA wm_L2VramUploadAddrL
	RTL

PARAMS_008A16:
	.DB $01,$18
	.DL wm_OWTilesOnRowL1
	.DB $40,$00

PARAMS_008A1D:
	.DB $01,$18
	.DL wm_OWTilesOnRowL1.TopRight
	.DB $2C,$00

PARAMS_008A24:
	.DB $01,$18
	.DL wm_OWTilesOnRowL1.BottomLeft
	.DB $40,$00

PARAMS_008A2B:
	.DB $01,$18
	.DL wm_OWTilesOnRowL1.BottomRight
	.DB $2C,$00

PARAMS_008A32:
	.DB $01,$18
	.DL wm_OWTilesOnRowL2
	.DB $40,$00

PARAMS_008A39:
	.DB $01,$18
	.DL wm_OWTilesOnRowL2.TopRight
	.DB $2C,$00

PARAMS_008A40:
	.DB $01,$18
	.DL wm_OWTilesOnRowL2.BottomLeft
	.DB $40,$00

PARAMS_008A47:
	.DB $01,$18
	.DL wm_OWTilesOnRowL2.BottomRight
	.DB $2C,$00

ClearStack:
	REP #$30
	LDX #$1FFE
-	STZ m0,X
--	DEX
	DEX
	CPX #$01FF
	BPL +
	CPX #$0100
	BPL --
+	CPX #$FFFE
	BNE -
	LDA #$0000
	STA wm_ImageIndex
	STZ wm_PalSprIndex
	SEP #$30
	LDA #$FF
	STA wm_ImageTable
	RTS

SetUpScreen:
	STZ SETINI
	STZ MOSAIC
	LDA #$23
	STA BG1SC
	LDA #$33
	STA BG2SC
	LDA #$53
	STA BG3SC
	LDA #$00
	STA BG12NBA
	LDA #$04
	STA BG34NBA
	STZ wm_W12Sel
	STZ wm_W34Sel
	STZ wm_WObjSel
	STZ WBGLOG
	STZ WOBJLOG
	STZ TMW
	STZ TSW
	LDA #$02
	STA wm_CgSwSel
	LDA #$80
	STA M7SEL
	RTS

DATA_008AB4:	.DB 0,0,-2,0,0,0,-2,0

DATA_008ABC:	.DB 0,0,2,0,0,0,2,0,0,0,0,1,-1,-1,0,16,-16

CODE_008ACD:
	LDA wm_M7Scale+1
	STA m0
	REP #$30
	JSR _008AE8
	LDA wm_M7Scale
	STA m0
	REP #$30
	LDA wm_M7A
	STA wm_M7D
	LDA wm_M7B
	EOR #$FFFF
	INC A
	STA wm_M7C
_008AE8:
	LDA wm_M7Rotate
	ASL
	PHA
	XBA
	AND #$0003
	ASL
	TAY
	PLA
	AND #$00FE
	EOR DATA_008AB4,Y
	CLC
	ADC DATA_008ABC,Y
	TAX
	JSR CODE_008B2B
	CPY #$0004
	BCC +
	EOR #$FFFF
	INC A
+	STA wm_M7B
	TXA
	EOR #$00FE
	CLC
	ADC #$0002
	AND #$01FF
	TAX
	JSR CODE_008B2B
	DEY
	DEY
	CPY #$0004
	BCS +
	EOR #$FFFF
	INC A
+	STA wm_M7A
	SEP #$30
	RTS

CODE_008B2B:
	SEP #$20
	LDA.W DATA_008B57+1,X
	BEQ +
	LDA m0
+	STA m1
	LDA.W DATA_008B57,X
	STA WRMPYA
	LDA m0
	STA WRMPYB
	NOP
	NOP
	NOP
	NOP
	LDA RDMPYH
	CLC
	ADC m1
	XBA
	LDA RDMPYL
	REP #$20
	LSR
	LSR
	LSR
	LSR
	LSR
	RTS

DATA_008B57:
	.DW $00,$03,$06,$09,$0C,$0F,$12,$15
	.DW $19,$1C,$1F,$22,$25,$28,$2B,$2E
	.DW $31,$35,$38,$3B,$3E,$41,$44,$47
	.DW $4A,$4D,$50,$53,$56,$59,$5C,$5F
	.DW $61,$64,$67,$6A,$6D,$70,$73,$75
	.DW $78,$7B,$7E,$80,$83,$86,$88,$8B
	.DW $8E,$90,$93,$95,$98,$9B,$9D,$9F
	.DW $A2,$A4,$A7,$A9,$AB,$AE,$B0,$B2
	.DW $B5,$B7,$B9,$BB,$BD,$BF,$C1,$C3
	.DW $C5,$C7,$C9,$CB,$CD,$CF,$D1,$D3
	.DW $D4,$D6,$D8,$D9,$DB,$DD,$DE,$E0
	.DW $E1,$E3,$E4,$E6,$E7,$E8,$EA,$EB
	.DW $EC,$ED,$EE,$EF,$F1,$F2,$F3,$F4
	.DW $F4,$F5,$F6,$F7,$F8,$F9,$F9,$FA
	.DW $FB,$FB,$FC,$FC,$FD,$FD,$FE,$FE
	.DW $FE,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DW $0100

UNK_008C59: ; unused big numbers 0-9
	.DB $B7,$3C,$B7,$BC,$B8,$3C,$B9,$3C
	.DB $BA,$3C,$BB,$3C,$BA,$3C,$BA,$BC
	.DB $BC,$3C,$BD,$3C,$BE,$3C,$BF,$3C
	.DB $C0,$3C,$B7,$BC,$C1,$3C,$B9,$3C
	.DB $C2,$3C,$C2,$BC,$B7,$3C,$C0,$FC

DATA_008C81:	.DB $3A,$38,$3B,$38,$3B,$38,$3A,$78

DATA_008C89:
	.DB $30,$28,$31,$28,$32,$28,$33,$28
	.DB $34,$28,$FC,$38,$FC,$3C,$FC,$3C
	.DB $FC,$3C,$FC,$3C,$FC,$38,$FC,$38
	.DB $4A,$38,$FC,$38,$FC,$38,$4A,$78
	.DB $FC,$38,$3D,$3C,$3E,$3C,$3F,$3C
	.DB $FC,$38,$FC,$38,$FC,$38,$2E,$3C
	.DB $26,$38,$FC,$38,$FC,$38,$00,$38

DATA_008CC1:
	.DB $26,$38,$FC,$38,$00,$38,$FC,$38
	.DB $FC,$38,$FC,$38,$64,$28,$26,$38
	.DB $FC,$38,$FC,$38,$FC,$38,$4A,$38
	.DB $FC,$38,$FC,$38,$4A,$78,$FC,$38
	.DB $FE,$3C,$FE,$3C,$00,$3C,$FC,$38
	.DB $FC,$38,$FC,$38,$FC,$38,$FC,$38
	.DB $FC,$38,$FC,$38,$00,$38

DATA_008CF7:	.DB $3A,$B8,$3B,$B8,$3B,$B8,$3A,$F8

GM04DoDMA:
	LDA.B #$80
	STA VMAINC
	LDA.B #$2E
	STA VMADDL
	LDA.B #$50
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008D90,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA.B #$02
	STA MDMAEN
	LDA.B #$80
	STA VMAINC
	LDA.B #$42
	STA VMADDL
	LDA.B #$50
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008D97,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA.B #$02
	STA MDMAEN
	LDA.B #$80
	STA VMAINC
	LDA.B #$63
	STA VMADDL
	LDA.B #$50
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008D9E,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA.B #$02
	STA MDMAEN
	LDA.B #$80
	STA VMAINC
	LDA.B #$8E
	STA VMADDL
	LDA.B #$50
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_008DA5,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA.B #$02
	STA MDMAEN
	LDX #$36
	LDY #$6C
-	LDA DATA_008C89,Y
	STA wm_StatusBar,X
	DEY
	DEY
	DEX
	BPL -
	LDA.B #$28
	STA wm_TimerFrameCounter
	RTS

PARAMS_008D90:
	.DB $01,$18
	.DL DATA_008C81
	.DB $08,$00

PARAMS_008D97:
	.DB $01,$18
	.DL DATA_008C89
	.DB $38,$00

PARAMS_008D9E:
	.DB $01,$18
	.DL DATA_008CC1
	.DB $36,$00

PARAMS_008DA5:
	.DB $01,$18
	.DL DATA_008CF7
	.DB $08,$00

DrawStatusBar:
	STZ VMAINC
	LDA.B #$42
	STA VMADDL
	LDA.B #$50
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_StBr1,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA.B #$02
	STA MDMAEN
	STZ VMAINC
	LDA.B #$63
	STA VMADDL
	LDA.B #$50
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_StBr2,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA.B #$02
	STA MDMAEN
	RTS

PARAMS_StBr1:
	.DB $00,$18
	.DL wm_StatusBar.L1
	.DB $1C,$00

PARAMS_StBr2:
	.DB $00,$18
	.DL wm_StatusBar.L2
	.DB $1B,$00

DATA_008DF5:	.DB $40,$41,$42,$43,$44

DATA_008DFA:	.DB $24,$26,$48,$0E

DATA_008DFE:	.DB $00,$02,$04,$02

DATA_008E02:	.DB $08,$0A,$00,$04

DATA_008E06:
	.DB $B7,$C3,$B8,$B9,$BA,$BB,$BA,$BF
	.DB $BC,$BD,$BE,$BF,$C0,$C3,$C1,$B9
	.DB $C2,$C4,$B7,$C5

CODE_008E1A:
	LDA wm_EndLevelTimer
	ORA wm_SpritesLocked
	BNE ++
	LDA wm_LevelMode
	CMP.B #$C1
	BEQ ++
	DEC wm_TimerFrameCounter
	BPL ++
	LDA.B #$28
	STA wm_TimerFrameCounter
	LDA wm_TimerHundreds
	ORA wm_TimerTens
	ORA wm_TimerOnes
	BEQ ++
	LDX #$02
-	DEC wm_TimerHundreds,X
	BPL +
	LDA.B #$09
	STA wm_TimerHundreds,X
	DEX
	BPL -
+	LDA wm_TimerHundreds
	BNE +
	LDA wm_TimerTens
	AND wm_TimerOnes
	CMP.B #$09
	BNE +
	LDA.B #$FF
	STA wm_SoundCh1
+	LDA wm_TimerHundreds
	ORA wm_TimerTens
	ORA wm_TimerOnes
	BNE ++
	JSL KillMario
++	LDA wm_TimerHundreds
	STA wm_StatusBar.Time
	LDA wm_TimerTens
	STA wm_StatusBar.Time+1
	LDA wm_TimerOnes
	STA wm_StatusBar.Time+2
	LDX #$10
	LDY #$00
-	LDA wm_TimerHundreds,Y
	BNE +
	LDA.B #$FC
	STA wm_StatusBar.L2,X
	INY
	INX
	CPY #$02
	BNE -
+	LDX #$03
-	LDA wm_MarioScoreLo,X
	STA m0
	STZ m1
	REP #$20
	LDA wm_MarioScoreHi,X
	SEC
	SBC #$423F
	LDA m0
	SBC #$000F
	BCC +
	SEP #$20
	LDA #$0F
	STA wm_MarioScoreLo,X
	LDA #$42
	STA wm_MarioScoreMid,X
	LDA #$3F
	STA wm_MarioScoreHi,X
+	SEP #$20
	DEX
	DEX
	DEX
	BPL -
	LDA wm_MarioScoreLo
	STA m0
	STZ m1
	LDA wm_MarioScoreMid
	STA m3
	LDA wm_MarioScoreHi
	STA m2
	LDX #$14
	LDY #$00
	JSR CODE_009012
	LDX #$00
-	LDA wm_StatusBar.Score,X
	BNE +
	LDA #$FC
	STA wm_StatusBar.Score,X
	INX
	CPX #$06
	BNE -
+	LDA wm_OWCharA
	BEQ +
	LDA wm_LuigiScoreLo
	STA m0
	STZ m1
	LDA wm_LuigiScoreMid
	STA m3
	LDA wm_LuigiScoreHi
	STA m2
	LDX #$14
	LDY #$00
	JSR CODE_009012
	LDX #$00
-	LDA wm_StatusBar.Score,X
	BNE +
	LDA #$FC
	STA wm_StatusBar.Score,X
	INX
	CPX #$06
	BNE -
+	LDA wm_CoinAdder
	BEQ +
	DEC wm_CoinAdder
	INC wm_StatusCoins
	LDA wm_StatusCoins
	CMP #$64
	BCC +
	INC wm_GiveLives
	LDA wm_StatusCoins
	SEC
	SBC #$64
	STA wm_StatusCoins
+	LDA wm_StatusLives
	BMI +
	CMP #$62
	BCC +
	LDA #$62
	STA wm_StatusLives
+	LDA wm_StatusLives
	INC A
	JSR HexToDec
	TXY
	BNE +
	LDX #$FC
+	STX wm_StatusBar.Lives
	STA wm_StatusBar.Lives+1
	LDX wm_OWCharA
	LDA wm_PlayerBonusStars,X
	CMP #$64
	BCC +
	LDA #$FF
	STA wm_BonusGameFlag
	LDA wm_PlayerBonusStars,X
	SEC
	SBC #$64
	STA wm_PlayerBonusStars,X
+	LDA wm_StatusCoins
	JSR HexToDec
	TXY
	BNE +
	LDX #$FC
+	STA wm_StatusBar.Coins+1
	STX wm_StatusBar.Coins
	SEP #$20
	LDX wm_OWCharA
	STZ m0
	STZ m1
	STZ m3
	LDA wm_PlayerBonusStars,X
	STA m2
	LDX #$09
	LDY #$10
	JSR CODE_009051
	LDX #$00
-	LDA wm_StatusBar.BonusStarsB,X
	BNE _f
	LDA #$FC
	STA wm_StatusBar.BonusStarsB,X
	STA wm_StatusBar.BonusStarsT,X
	INX
	CPX #$01
	BNE -
__	LDA wm_StatusBar.BonusStarsB,X
	ASL
	TAY
	LDA DATA_008E06,Y
	STA wm_StatusBar.BonusStarsT,X
	LDA DATA_008E06+1,Y
	STA wm_StatusBar.BonusStarsB,X
	INX
	CPX #$02
	BNE _b
	JSR CODE_009079
	LDA wm_OWCharA
	BEQ +
	LDX #$04
-	LDA.W DATA_008DF5,X
	STA wm_StatusBar,X
	DEX
	BPL -
+	LDA wm_YoshiCoinsDisp
	CMP #$05
	BCC +
	LDA #$00
+	DEC A
	STA m0
	LDX #$00
-	LDY #$FC
	LDA m0
	BMI +
	LDY #$2E
+	TYA
	STA wm_StatusBar.YoshiCoins,X
	DEC m0
	INX
	CPX #$04
	BNE -
	RTS

DATA_008FFA:
	.DW $0001,$86A0,$0000,$2710
	.DW $0000,$03E8,$0000,$0064
	.DW $0000,$000A,$0000,$0001

CODE_009012:
	SEP #$20
	STZ wm_StatusBar.L2,X
-	REP #$20
	LDA m2
	SEC
	SBC DATA_008FFA+2,Y
	STA m6
	LDA m0
	SBC DATA_008FFA,Y
	STA m4
	BCC CODE_009039
	LDA m6
	STA m2
	LDA m4
	STA m0
	SEP #$20
	INC wm_StatusBar.L2,X
	BRA -

CODE_009039:
	INX
	INY
	INY
	INY
	INY
	CPY #$18
	BNE CODE_009012
	SEP #$20
	RTS

HexToDec:
	LDX #$00
-	CMP #$0A
	BCC Return009050
	SBC #$0A
	INX
	BRA -

Return009050:
	RTS

CODE_009051:
	SEP #$20
	STZ wm_StatusBar.L2,X
-	REP #$20
	LDA m2
	SEC
	SBC DATA_008FFA+2,Y
	STA m6
	BCC CODE_00906D
	LDA m6
	STA m2
	SEP #$20
	INC wm_StatusBar.L2,X
	BRA -

CODE_00906D:
	INX
	INY
	INY
	INY
	INY
	CPY #$18
	BNE CODE_009051
	SEP #$20
	RTS

CODE_009079:
	LDY #$E0
	BIT wm_LevelMode
	BVC +
	LDY #$00
	LDA wm_LevelMode
	CMP #$C1
	BEQ +
	LDA #$F0
	STA wm_ExOamSlot.1.YPos,Y
+	STY m1
	LDY wm_ItemInBox
	BEQ ++
	LDA DATA_008E02-1,Y
	STA m0
	CPY #$03
	BNE +
	LDA wm_FrameA
	LSR
	AND #$03
	PHY
	TAY
	LDA DATA_008DFE,Y
	PLY
	STA m0
+	LDY m1
	LDA #$78
	STA wm_ExOamSlot.1.XPos,Y
	LDA #$0F
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$30
	ORA m0
	STA wm_ExOamSlot.1.Prop,Y
	LDX wm_ItemInBox
	LDA.W DATA_008DFA-1,X
	STA wm_ExOamSlot.1.Tile,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	STA wm_ExOamSize.1,Y
++	RTS

DATA_0090D1:
	.DB $00,$FF,$4D,$4C,$03,$4D,$5D,$FF
	.DB $03,$00,$4C,$03,$04,$15,$00,$02
	.DB $00,$4A,$4E,$FF,$4C,$4B,$4A,$03
	.DB $5F,$05,$04,$03,$02,$00,$FF,$01
	.DB $4A,$5F,$05,$04,$00,$4D,$5D,$03
	.DB $02,$01,$00,$FF,$5B,$14,$5F,$01
	.DB $5E,$FF,$FF,$FF

DATA_009105:
	.DB $10,$FF,$00,$5C,$13,$00,$5D,$FF
	.DB $03,$00,$5C,$13,$14,$15,$00,$12
	.DB $00,$03,$5E,$FF,$5C,$4B,$5A,$03
	.DB $5F,$05,$14,$13,$12,$10,$FF,$11
	.DB $03,$5F,$05,$14,$00,$00,$5D,$03
	.DB $12,$11,$10,$FF,$5B,$01,$5F,$01
	.DB $5E,$FF,$FF,$FF

DATA_009139:
	.DB $34,$00,$34,$34,$34,$34,$30,$00 ; BUG-FIX: ID 006-00
	.DB $34,$34,$34,$34,$74,$34,$34,$34
	.DB $34,$34,$34,$00,$34,$34,$34,$34
	.DB $34,$34,$34,$34,$34,$34,$00,$34
	.DB $34,$34,$34,$34,$34,$34,$34,$34
	.DB $34,$34,$34,$34,$34,$34,$34,$34
	.DB $34

DATA_00916A:
	.DB $34,$00,$B4,$34,$34,$B4,$F0,$00 ; BUG-FIX: ID 006-01
	.DB $B4,$B4,$34,$34,$74,$B4,$B4,$34
	.DB $B4,$B4,$34,$00,$34,$B4,$34,$B4
	.DB $B4,$B4,$34,$34,$34,$34,$00,$34
	.DB $B4,$B4,$B4,$34,$B4,$B4,$B4,$B4
	.DB $34,$34,$34,$34,$F4,$B4,$F4,$B4
	.DB $B4

CODE_00919B:
	LDA wm_MarioAnimation
	CMP #$0A
	BNE CODE_0091A6
	JSR CODE_00C593
	BRA _Return0091B0

CODE_0091A6:
	LDA wm_NumSubLvEntered
	BNE _Return0091B0
	LDA #$1E
	STA wm_GreenStarCoins
_Return0091B0:
	RTS

CODE_0091B1:
	JSR CODE_00A82D
	LDX #$00
	LDA #$B0
	LDY wm_BonusGameFlag
	BEQ +
	STZ wm_TimerHundreds
	STZ wm_TimerTens
	STZ wm_TimerOnes
	LDX #$26
	LDA #$A4
+	STA m0
	STZ m1
	LDY #$70
-	JSR CODE_0091E9
	INX
	CPX #$08
	BNE +
	LDA wm_OWCharA
	BEQ +
	LDX #$0E
+	TYA
	SEC
	SBC #$08
	TAY
	BNE -
	JMP CODE_008494

CODE_0091E9:
	LDA.W DATA_009139,X
	STA wm_OamSlot.3.Prop,Y
	LDA.W DATA_00916A,X
	STA wm_OamSlot.4.Prop,Y
	LDA m0
	STA wm_OamSlot.3.XPos,Y
	STA wm_OamSlot.4.XPos,Y
	SEC
	SBC #$08
	STA m0
	BCS +
	DEC m1
+	PHY
	TYA
	LSR
	LSR
	TAY
	LDA m1
	AND #$01
	STA wm_OamSize.3,Y
	STA wm_OamSize.4,Y
	PLY
	LDA.W DATA_0090D1,X
	BMI +
	STA wm_OamSlot.3.Tile,Y
	LDA.W DATA_009105,X
	STA wm_OamSlot.4.Tile,Y
	LDA #$68
	STA wm_OamSlot.3.YPos,Y
	LDA #$70
	STA wm_OamSlot.4.YPos,Y
+	RTS

NintenDMAINIT:
	STZ wm_Palette.1.ColL
	STZ wm_Palette.1.ColH
	STZ CGADD
	LDX #$06
-	LDA.W PARAMS_009249,X
	STA CH2.PARAM,X
	DEX
	BPL -
	LDA #$04
	STA MDMAEN
	RTS

PARAMS_009249:
	.DB $00,$22
	.DL wm_Palette
	.DB $00,$02

CODE_009250:
	LDX #$04
-	LDA.W PARAMS_009277,X
	STA CH7.PARAM,X
	DEX
	BPL -
	LDA #$00
	STA CH7.DATAH
_009260:
	STZ wm_HDMAEn
_009263:
	REP #$10
	LDX #$01BE
	LDA #$FF
-	STA wm_HDMAWindowsTbl,X
	STZ wm_HDMAWindowsTbl+1,X
	DEX
	DEX
	BPL -
	SEP #$10
	RTS

PARAMS_009277:
	.DB $41,$26
	.DL DATA_00927C

DATA_00927C:
	.DB $F0
	.DW wm_HDMAWindowsTbl
	.DB $F0
	.DW wm_HDMAWindowsTbl+224
	.DB $00

CODE_009283:
	JSR _009263
	LDA wm_LevelMode
	LSR
	BCS _0092A0
	REP #$10
	LDX #$01BE
_WindowHDMAenable:
	STZ wm_HDMAWindowsTbl,X
	LDA #$FF
	STA wm_HDMAWindowsTbl+1,X
	INX
	INX
	CPX #$01C0
	BCC _WindowHDMAenable
_0092A0:
	LDA #$80
	STA wm_HDMAEn
	SEP #$10
	RTS

CODE_0092A8:
	JSR _009263
	REP #$10
	LDX #$0198
	BRA _WindowHDMAenable

CODE_0092B2:
	LDA #$58
	STA wm_HDMAWindowsTbl
	STA wm_HDMAWindowsTbl+10
	STA wm_HDMAWindowsTbl+20
	STZ wm_HDMAWindowsTbl+9
	STZ wm_HDMAWindowsTbl+19
	STZ wm_HDMAWindowsTbl+29
	LDX.B #$04
-	LDA.W PARAMS_009313,X
	STA CH5.PARAM,X
	LDA.W PARAMS_009318,X
	STA CH6.PARAM,X
	LDA.W PARAMS_00931D,X
	STA CH7.PARAM,X
	DEX
	BPL -
	LDA #$00
	STA CH5.DATAH
	STA CH6.DATAH
	STA CH7.DATAH
	LDA #$E0
	STA wm_HDMAEn
_0092ED:
	REP #$30
	LDY #$0008
	LDX #$0014
-	LDA.W wm_Bg1HOfs,Y
	STA wm_HDMAWindowsTbl+1,X
	STA wm_HDMAWindowsTbl+4,X
	LDA wm_L1NextPosX,Y
	STA wm_HDMAWindowsTbl+7,X
	TXA
	SEC
	SBC #$000A
	TAX
	DEY
	DEY
	DEY
	DEY
	BPL -
	SEP #$30
	RTS

PARAMS_009313:
	.DB $02,$0D
	.DL wm_HDMAWindowsTbl

PARAMS_009318:
	.DB $02,$0F
	.DL wm_HDMAWindowsTbl+10

PARAMS_00931D:
	.DB $02,$11
	.DL wm_HDMAWindowsTbl+20

GetGameMode:
	LDA wm_GameMode
	JSL ExecutePtr

POINTERS_GameMode:
	.DW GAMEMODE_LoadIntro
	.DW GAMEMODE_ShowIntro
	.DW GAMEMODE_Fade
	.DW GAMEMODE_LoadTitleScreen
	.DW GAMEMODE_PrepareTitleScreen
	.DW GAMEMODE_Fade
	.DW GAMEMODE_CircleEffect
	.DW GAMEMODE_ShowTitleScreen
	.DW GAMEMODE_FileSelect
	.DW GAMEMODE_FileDelete
	.DW GAMEMODE_PlayerSelect
	.DW GAMEMODE_Fade
	.DW GAMEMODE_LoadOverworld
	.DW GAMEMODE_Fade
	.DW GAMEMODE_ShowOverworld
	.DW GAMEMODE_Mosaic
	.DW GAMEMODE_Black
	.DW _GAMEMODE_LoadLevel
	.DW GAMEMODE_PrepareLevel
	.DW GAMEMODE_Mosaic
	.DW GAMEMODE_ShowLevel
	.DW GAMEMODE_Fade
	.DW GAMEMODE_LoadGameOver
	.DW GAMEMODE_ShowGameOver
	.DW GAMEMODE_Fade
	.DW GAMEMODE_Cutscene
	.DW GAMEMODE_Fade
	.DW _GAMEMODE_EndingCinema
	.DW GAMEMODE_Fade
	.DW GAMEMODE_LoadYoshisHouse
	.DW GAMEMODE_Fade
	.DW _GAMEMODE_ShowYoshisHouse
	.DW GAMEMODE_Fade
	.DW GAMEMODE_LoadEndingEnemies
	.DW GAMEMODE_Fade
	.DW GAMEMODE_ShowEndingEnemies
	.DW GAMEMODE_Fade
	.DW GAMEMODE_NextEndingEnemies
	.DW GAMEMODE_Fade
	.DW GAMEMODE_LoadTheEnd
	.DW GAMEMODE_ShowTheEnd
	.DW GAMEMODE_Return

TurnOffIO:
	STZ NMITIMEN
	STZ HDMAEN
	LDA #$80
	STA INIDISP
	RTS

NintendoPos:	.DB $60,$70,$80,$90

NintendoTile:	.DB $02,$04,$06,$08

GAMEMODE_LoadIntro:
	JSR CODE_0085FA
	JSR SetUpScreen
	JSR CODE_00A993
	LDY #$0C
	LDX #$03
-	LDA.W NintendoPos,X
	STA wm_ExOamSlot.1.XPos,Y
	LDA #$70
	STA wm_ExOamSlot.1.YPos,Y
	LDA.W NintendoTile,X
	STA wm_ExOamSlot.1.Tile,Y
	LDA #$30
	STA wm_ExOamSlot.1.Prop,Y
	DEY
	DEY
	DEY
	DEY
	DEX
	BPL -
	LDA #$AA
	STA wm_OamHiX
	LDA #$01
	STA wm_SoundCh3
	LDA #$40
	STA wm_IntroCtrlSeqFrame
_0093CA:
	LDA #$0F
	STA wm_IniDisp
	LDA #$01
	STA wm_MosaicDir
	STZ wm_LvHeadSprPal
	JSR LoadPalette
	STZ wm_LvBgColor
	STZ wm_LvBgColor+1
	JSR NintenDMAINIT
	STZ wm_CursorPos
	LDX #$10
	LDY #$04
_0093EA:
	LDA #$01
	STA wm_LevelMode
	LDA #$20
	JSR ScreenSettings
_0093F4:
	INC wm_GameMode
_Mode04Finish:
	LDA #$81
	STA NMITIMEN
	RTS

ScreenSettings:
	STA CGADSUB
	STA wm_CgAdSub
	STX TM
	STY TS
	STZ TMW
	STZ TSW
	RTS

GAMEMODE_ShowIntro:
	DEC wm_IntroCtrlSeqFrame
	BNE _Return00941A
	JSR CODE_00B888
_009417:
	INC wm_GameMode
_Return00941A:
	RTS

GAMEMODE_CircleEffect:
	JSR SetUp0DA0GM4
	JSR CODE_009CBE
	BEQ CODE_00942E
	LDA #$EC
	JSR _009440
	INC wm_GameMode
	JMP CODE_009C9F

CODE_00942E:
	DEC wm_IntroCtrlSeqFrame
	BNE _Return00941A
	INC wm_IntroCtrlSeqFrame
	LDA wm_HdmaWindowScaling
	CLC
	ADC #$04
	CMP #$F0
	BCS _009417
_009440:
	STA wm_HdmaWindowScaling
_009443:
	JSR CODE_00CA61
	LDA #$80
	STA m0
	LDA #$70
	STA m1
	JMP _00CA88

CutsceneBgColor:	.DB $02,$00,$04,$01,$00,$06,$04

CutsceneCastlePal:	.DB $03,$06,$05,$06,$03,$03,$06,$06

DATA_009460:	.DB $03,$FF,$FF,$C9,$0F,$FF,$CC,$C9

GAMEMODE_Cutscene:
	JSR CODE_0085FA
	JSR Clear_1A_13D3
	JSR SetUpScreen
	LDX wm_CutsceneNum
	LDA #$18
	STA wm_LvHeadTileset
	LDA #$14
	STA wm_CurSprGfx
	LDA.W CutsceneBgColor-1,X
	STA wm_LvHeadBgCol
	LDA.W CutsceneCastlePal,X
	STA wm_LvHeadBgPal
	STZ wm_LvHeadSprPal
	LDA #$01
	STA wm_LvHeadFgPal
	CPX #$08
	BNE CODE_0094B2
	JSR CODE_00955E
	LDA #$D2
	STA wm_ImageLoader
	JSR LoadScrnImage
	JSR UploadMusicBank3
	JSL CODE_0C93DD
	JSR _009260
	INC wm_LvHeadTileset
	INC wm_CurSprGfx
	BRA _0094D7

CODE_0094B2:
	LDA #$15
	STA wm_MusicCh1
	LDA.W DATA_009460,X
	STA wm_ImageLoader
	JSR LoadScrnImage
	LDA #$CF
	STA wm_ImageLoader
	JSR LoadScrnImage
	REP #$20
	LDA #$0090
	STA wm_MarioXPos
	LDA #$0058
	STA wm_MarioYPos
	SEP #$20
	INC wm_IsCarrying2
_0094D7:
	JSR UploadSpriteGFX
	JSR LoadPalette
	JSR NintenDMAINIT
	LDX #$0B
-	STZ wm_Bg1HOfs,X
	DEX
	BPL -
	LDA #$20
	STA wm_SpriteProp
	JSR CODE_00A635
	STZ wm_MarioDirection
	STZ wm_IsFlying
	JSL CODE_00CEB1
	LDX #$17
	LDY #$00
	JSR _009622
_GAMEMODE_EndingCinema:
	JSL wm_ClearOam
	LDA wm_CutsceneNum
	CMP #$08
	BEQ CODE_009557
	LDA wm_JoyPadB
.IFDEF dbg_SelectCinema
	AND #$30
.ELSE
	AND #$00
.ENDIF
	CMP #$30
	BNE CODE_009529
	LDA wm_JoyPadA
	AND #$08
	BEQ ++
	LDA wm_CutsceneNum
	INC A
	CMP #$09
	BCC +
	LDA #$01
+	STA wm_CutsceneNum
++	LDA #$18
	STA wm_GameMode
	RTS

CODE_009529:
	JSL CODE_0CC97E
	REP #$20
	LDA wm_Bg1HOfs
	PHA
	LDA wm_Bg1VOfs
	PHA
	LDA wm_Bg2HOfs
	STA wm_Bg1HOfs
	LDA wm_Bg2VOfs
	STA wm_Bg1VOfs
	SEP #$20
	JSL CODE_00E2BD
	REP #$20
	PLA
	STA wm_Bg1VOfs
	PLA
	STA wm_Bg1HOfs
	SEP #$20
	LDA #$0C
	STA wm_MarioAnimation
	JSR CODE_00C47E
	JMP CODE_008494

CODE_009557:
	JSL CODE_0C938D
	JMP CODE_008494

CODE_00955E:
	LDY #$2F
	JSL CODE_00BA28
	LDA #$80
	STA VMAINC
	REP #$30
	LDA #$4600
	STA VMADDL
	LDX #$0200
-	LDA [m0]
	STA VMDATAWL
	INC m0
	INC m0
	DEX
	BNE -
	SEP #$30
	RTS

GAMEMODE_LoadYoshisHouse:
	INC wm_CutsceneNum
	LDA #$28
	LDY #$01
	JSR _0096CF
	DEC wm_GameMode
	LDA #$16
	STA wm_CurSprGfx
	JSR GAMEMODE_PrepareLevel
	DEC wm_GameMode
	JSR TurnOffIO
	JSR CODE_0085FA
	JSR CODE_00A993
	JSL CODE_0CA3C9
	JSR _00961E
_GAMEMODE_ShowYoshisHouse:
	JSL wm_ClearOam
	JSL CODE_0C939A
	INC wm_FrameB
	JSL CODE_05BB39
	JMP CODE_008494

GAMEMODE_LoadEndingEnemies:
	JSL CODE_0C93AD
	RTS

GAMEMODE_ShowEndingEnemies:
	JSR CODE_0085FA
	JSR Clear_1A_13D3
	JSR SetUpScreen
	JSL CODE_0CAD8C
	JSL CODE_05801E
	LDA wm_CreditsEnemyNum
	CMP #$0A
	BNE CODE_0095E0
	LDA #$13
	STA wm_CurSprGfx
	BRA _0095E9

CODE_0095E0:
	CMP #$0C
	BNE _0095E9
	LDA #$17
	STA wm_CurSprGfx
_0095E9:
	JSR UploadSpriteGFX
	JSR LoadPalette
	JSL CODE_05809E
	JSR CODE_00A5F9
	JSL CODE_0CADF6
	LDA wm_CreditsEnemyNum
	CMP #$0C
	BNE +
	LDX #$0B
-	LDA.W BowserEndPalette,X
	STA wm_Palette.131.Col,X
	LDA.W BowserEndPalette+12,X
	STA wm_Palette.147.Col,X
	DEX
	BPL -
+	JSR NintenDMAINIT
	JSR CODE_0092B2
	JSR LoadScrnImage
	JSR GAMEMODE_NextEndingEnemies
_00961E:
	LDX #$15
	LDY #$02
_009622:
	JSR KeepModeActive
	LDA #$09
	STA wm_BgMode
	JMP _0093EA

GAMEMODE_NextEndingEnemies:
	STZ wm_PlayerDmaTiles
	JSR _0092ED
	JSL wm_ClearOam
	JSL CODE_0C93A5
	JMP CODE_008494

GAMEMODE_LoadTheEnd:
	JSR CODE_0085FA
	JSR Clear_1A_13D3
	JSR SetUpScreen
	JSR CODE_00955E
	LDA #$19
	STA wm_CurSprGfx
	LDA #$03
	STA wm_LvHeadBgCol
	LDA #$03
	STA wm_LvHeadBgPal
	JSR UploadSpriteGFX
	JSR LoadPalette
	LDX #$0B
-	LDA.W PALETTE_EndingLuigi,X
	STA wm_Palette.211.Col,X
	LDA.W PALETTE_EndingMario,X
	STA wm_Palette.227.Col,X
	LDA.W PALETTE_EndingToadstool,X
	STA wm_Palette.243.Col,X
	DEX
	BPL -
	JSR NintenDMAINIT
	LDA #$D5
	STA wm_ImageLoader
	JSR LoadScrnImage
	JSL CODE_0CAADF
	JSR CODE_008494
	LDX #$14
	LDY #$00
	JMP _009622

GAMEMODE_Return:
	RTS

GAMEMODE_Black:
	JSR CODE_0085FA
	LDA wm_BonusGameFlag
	BNE +
	LDA wm_NumSubLvEntered
	ORA wm_ShowMarioStart
	ORA wm_ForceLoadLevel
	BNE ++
	LDA wm_OWPlayerTile
	CMP #$56
	BEQ ++
+	JSR CODE_0091B1
++	JMP _0093CA

GAMEMODE_LoadTitleScreen:
	STZ NMITIMEN
	JSR ClearStack
	LDX #$07
	LDA #$FF
-	STA wm_SpriteGfxSet,X
	DEX
	BPL -
	LDA wm_ForceLoadLevel
	BNE +
	JSR UploadMusicBank1
	LDA #$01
	STA wm_MusicCh1
+	LDA #$EB
	LDY #$00
_0096CF:
	STA wm_ForceLoadLevel
	STY wm_MapData.MarioMap
_GAMEMODE_LoadLevel:
	STZ NMITIMEN
	JSR _NoButtons
	LDA wm_NumSubLvEntered
	BNE +
	LDA wm_ShowMarioStart
	BEQ +
	JSL CODE_04DC09
+	STZ wm_L3ScrollFlag
	STZ wm_OWProcessPtr
	LDA #$50
	STA wm_ScoreDrumroll
	JSL CODE_05D796
	LDX #$07
-	LDA wm_Bg1HOfs,X
	STA wm_L1NextPosX,X
	DEX
	BPL -
	JSR CODE_008134
	JSR CODE_00A635
	LDA #$20
	STA wm_LastScreenHorz
	JSR CODE_00A796
	INC wm_ScrScrollToPlayer
	JSL CODE_00F6DB
	JSL CODE_05801E
	LDA wm_ForceLoadLevel
	BEQ +
	CMP #$E9
	BNE +++
	LDA #$13
	STA wm_LevelMusicMod
+	LDA wm_LevelMusicMod
	CMP #$40
	BCS ++
	LDY wm_LevelMode
	CPY #$C1
	BNE +
	LDA #$16
+	STA wm_MusicCh1
++	AND #$BF
	STA wm_LevelMusicMod
+++	STZ wm_IniDisp
	STZ wm_MosaicDir
	INC wm_GameMode
	JMP _Mode04Finish

CODE_00974C:
	JSR HexToDec
	RTL

GAMEMODE_LoadGameOver:
	JSR CODE_0085FA
	JSR CODE_00A82D
	JMP _0093CA

GAMEMODE_ShowGameOver:
	JSL wm_ClearOam
	LDA wm_DeathMsgAnim
	BNE CODE_00978B
	DEC wm_DeathMsgTimer
	BNE _00978E
	LDA wm_StatusLives
	BPL +
	STZ wm_OWHasYoshi
	LDA wm_2PMarioLives
	ORA wm_2PLuigiLives
	BPL +
	LDX #$0C
-	STZ wm_5YoshiCoins,X
	STZ.W m6,X
	STZ wm_3UpMoonsCollected,X
	DEX
	BPL -
	INC wm_ShowEndMenu
+	JMP _009E62

CODE_00978B:
	SEC
	SBC #$04
_00978E:
	STA wm_DeathMsgAnim
	CLC
	ADC #$A0
	STA m0
	ROL m1
	LDX wm_DeathMsgType
	LDY #$48
-	CPY #$28
	BNE +
	LDA #$78
	SEC
	SBC wm_DeathMsgAnim
	STA m0
	ROL
	EOR #$01
	STA m1
+	JSR CODE_0091E9
	INX
	TYA
	SEC
	SBC #$08
	TAY
	BNE -
	JMP CODE_008494

CODE_0097BC:
	LDA #$0F
	STA wm_IniDisp
	STZ wm_MosaicSize
	JSR _GMMosaic
	LDA #$20
	STA wm_M7Scale
	STA wm_M7Scale+1
	STZ wm_Layer1DispYLo
	JSR CODE_0085FA
	LDA #$FF
	STA wm_LvHeadTileset
	JSL CODE_03D958
	BIT wm_LevelMode
	BVC CODE_009801
	JSR CODE_009925
	LDY wm_M7BossGfxIndex
	CPY #$03
	BCC CODE_0097F1
	BNE _00983B
	LDA #$18
	BRA _0097FC

CODE_0097F1:
	LDA #$03
	STA wm_IsBehindScenery
	LDA #$C8
	STA wm_OAMAddL
	LDA #$12
_0097FC:
	DEC wm_LvHeadTileset
	BRA _00983D

CODE_009801:
	JSR CODE_00ADD9
	JSR CODE_0092A8
	LDX #$50
	JSR _009A3D
	REP #$20
	LDA #$0050
	STA wm_MarioXPos
	LDA #$FFD0
	STA wm_MarioYPos
	STZ wm_Bg1HOfs
	STZ wm_L1NextPosX
	LDA #$FF90
	STA wm_Bg1VOfs
	STA wm_L1NextPosY
	LDA #$0080
	STA wm_M7X
	LDA #$0050
	STA wm_M7Y
	LDA #$0080
	STA wm_M7Bg1HOfs
	LDA #$0010
	STA wm_M7Bg1VOfs
	SEP #$20
_00983B:
	LDA #$13
_00983D:
	STA wm_CurSprGfx
	JSR UploadSpriteGFX
	LDA #$11
	STA TMW
	STZ TS
	STZ TSW
	LDA #$02
	STA wm_W12Sel
	LDA #$32
	STA wm_WObjSel
	LDA #$20
	STA wm_CgSwSel
	JSR GM04DoDMA
	JSR CODE_008ACD
_009860:
	JSL CODE_00E2BD
	JSR CODE_00A2F3
	JSR CODE_00C593
	STZ wm_MarioSpeedY
	JSL CODE_01808C
	JSL wm_ClearOam
	RTS

UNK_009875:	.DW 1,-1,64,64*7

CODE_00987D:
	JSR CODE_008ACD
	BIT wm_LevelMode
	BVC CODE_009888
	JMP CODE_009A52

CODE_009888:
	JSL wm_ClearOam
	JSL CODE_03C0C6
	RTS

DATA_009891:
	.DW $129E,$121E,$119E,$111E,$161E,$159E
	.DW $151E,$149E,$141E,$139E,$131E,$169E

CODE_0098A9:
	LDA wm_LevelMode
	LSR
	BCS +
	LDA wm_FrameB
	LSR
	LSR
	AND #$06
	TAX
	REP #$20
	LDY #$80
	STY VMAINC
	LDA #$1801
	STA CH2.PARAM
	LDA #$7800
	STA VMADDL
	LDA.L DATA_05BA39,X
	STA CH2.ADDA1L
	LDY #$7E
	STY CH2.ADDA1H
	LDA #$0080
	STA CH2.DATAL
	LDY #$04
	STY MDMAEN
	CLC
+	REP #$20
	LDA #$0004
	LDY #$06
	BCC +
	LDA #$0008
	LDY #$16
+	STA m0
	LDA #wm_M7BossTiles&$FFFF
	STA m2
	STZ VMAINC
	LDA #$1800
	STA CH2.PARAM
	LDX #wm_M7BossTiles>>16
	STX CH2.ADDA1H
	LDX #$04
-	LDA DATA_009891,Y
	STA VMADDL
	LDA m2
	STA CH2.ADDA1L
	CLC
	ADC m0
	STA m2
	LDA m0
	STA CH2.DATAL
	STX MDMAEN
	DEY
	DEY
	BPL -
	SEP #$20
	RTS

CODE_009925:
	STZ wm_MarioYPos+1
	REP #$20
	LDA #$0020
	STA wm_MarioXPos
	STZ wm_Bg1HOfs
	STZ wm_L1NextPosX
	STZ wm_Bg1VOfs
	STZ wm_L1NextPosY
	LDA #$0080
	STA wm_M7X
	LDA #$00A0
	STA wm_M7Y
	SEP #$20
	JSR CODE_00AE15
	JSL CODE_01808C
	LDA wm_LevelMode
	LSR
	LDX #$C0
	LDA #$A0
	BCC CODE_00995B
	STZ wm_HorzScrollHead
	JMP _009A17

CODE_00995B:
	REP #$30
	LDA wm_M7BossGfxIndex
	AND #$00FF
	ASL
	TAX
	LDY #$02C0
	LDA.W DATA_00F8E8,X
	BPL +
	LDY #$FB80
+	CMP #$0012
	BNE +
	LDY #$0320
+	STY m0
	LDX #$0000
	LDA #$C05A
_009980:
	STA wm_ImageTable,X
	XBA
	CLC
	ADC #$0080
	XBA
	STA wm_ImageTable.67.ImgL,X
	XBA
	SEC
	SBC m0
	XBA
	STA wm_ImageTable.133.ImgL,X
	LDA #$7F00
	STA wm_ImageTable.2.ImgL,X
	STA wm_ImageTable.68.ImgL,X
	STA wm_ImageTable.134.ImgL,X
	LDY #$0010
-	LDA #$38A2
	STA wm_ImageTable.3.ImgL,X
	INC A
	STA wm_ImageTable.4.ImgL,X
	LDA #$38B2
	STA wm_ImageTable.35.ImgL,X
	INC A
	STA wm_ImageTable.36.ImgL,X
	LDA #$2C80
	STA wm_ImageTable.69.ImgL,X
	INC A
	STA wm_ImageTable.70.ImgL,X
	INC A
	STA wm_ImageTable.101.ImgL,X
	INC A
	STA wm_ImageTable.102.ImgL,X
	LDA #$28A0
	STA wm_ImageTable.135.ImgL,X
	INC A
	STA wm_ImageTable.136.ImgL,X
	LDA #$28B0
	STA wm_ImageTable.167.ImgL,X
	INC A
	STA wm_ImageTable.168.ImgL,X
	INX
	INX
	INX
	INX
	DEY
	BNE -
	TXA
	CLC
	ADC #$014C
	TAX
	LDA #$C05E
	CPX #$0318
	BCS CODE_009A07
	JMP _009980

CODE_009A07:
	LDA #$00FF
	STA wm_ImageTable,X
	SEP #$30
	JSR LoadScrnImage
	LDX #$B0
	LDA #$90
_009A17:
	STA wm_MarioYPos
	JSR CODE_009A1F
	JMP CODE_009283

CODE_009A1F:
	LDY #$10
	LDA #$32
-	STA wm_Map16SetL.1,X
	STA wm_Map16SetL.2,X
	STA wm_Map16SetH.1,X
	STA wm_Map16SetH.2,X
	INX
	DEY
	BNE -
	CPX #$C0
	BNE +
	LDX #$D0
_009A3D:
	LDY #$10
	LDA #$05
-	STA wm_Map16SetL.1,X
	STA wm_Map16SetL.2,X
	INX
	DEY
	BNE -
+	RTS

UNK_009A4E:	.DB -1,1,24,48

CODE_009A52:
	LDA wm_LevelMode
	LSR
	BCS CODE_009A6F
	JSL CODE_00F6DB
	JSL CODE_05BC00
	LDA wm_M7BossGfxIndex
	CMP #$04
	BEQ CODE_009A6F
	JSR CODE_0086C7
	JSL CODE_02827D
	RTS

CODE_009A6F:
	JSL wm_ClearOam
	RTS

SetUp0DA0GM4:
	LDA JOYA
	LSR
	LDA JOYB
	ROL
	AND #$03
	BEQ ++
	CMP #$03
	BNE +
	ORA #$80
+	DEC A
++	STA wm_JoyPort
	RTS

GAMEMODE_PrepareTitleScreen:
	JSR SetUp0DA0GM4
	JSR GAMEMODE_PrepareLevel
	STZ wm_TimerHundreds
	JSR CODE_0085FA
	LDA #$03
	STA wm_ImageLoader
	JSR LoadScrnImage
	JSR CODE_00ADA6
	JSR NintenDMAINIT
	JSL CODE_04F675
	LDA #$01
	STA wm_LevelMode
	LDA #$33
	STA wm_W12Sel
	LDA #$00
	STA wm_W34Sel
	LDA #$23
	STA wm_WObjSel
	LDA #$12
	STA wm_CgSwSel
	JSR _009443
	LDA #$10
	STA wm_IntroCtrlSeqFrame
	JMP _Mode04Finish

DATA_009AC8:	.DB 1,-1,-1

CODE_009ACB:
	PHY
	JSR SetUp0DA0GM4
	PLY
_009AD0:
	INC wm_CursorBlinking
	JSR CODE_009E82
	LDX wm_CursorPos
	LDA wm_JoyFrameA
	AND #$90
	BNE +
	LDA wm_JoyFrameB
	BPL CODE_009AEA
+	LDA #$01
	STA wm_SoundCh3
	BRA _009B11

CODE_009AEA:
	PLA
	PLA
	LDA wm_JoyFrameA
	AND #$20
	LSR
	LSR
	LSR
	ORA wm_JoyFrameA
	AND #$0C
	BEQ ++
	LDY #$06
	STY wm_SoundCh3
	STZ wm_CursorBlinking
	LSR
	LSR
	TAY
	TXA
	ADC DATA_009AC8-1,Y
	BPL +
	LDA wm_8A
	DEC A
+	CMP wm_8A
	BCC +
_009B11:
	LDA #$00
+	STA wm_CursorPos
++	RTS

DATA_009B17:	.DB $04,$02,$01

GAMEMODE_FileDelete:
	REP #$20
	LDA #$39C9
	LDY #$60
	JSR CODE_009D30
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	AND.B #$40
	BEQ CODE_009B38
_009B2C:
	DEC wm_GameMode
	DEC wm_GameMode
	JSR _009B11
	JMP _009CB0

CODE_009B38:
	LDY #$08
	JSR _009AD0
	CPX #$03
	BNE CODE_009B6D
	LDY #$02
-	LSR wm_OWSpriteIndex
	BCC +
	PHY
	LDA DATA_009CCB,Y
	XBA
	LDA DATA_009CCE,Y
	REP #$10
	TAX
	LDY #_sizeof_SAVE_SLOT
	LDA.B #$00
--	STA sm_Main,X
	STA sm_Copy,X
	INX
	DEY
	BNE --
	SEP #$10
	PLY
+	DEY
	BPL -
	JMP _009C89

CODE_009B6D:
	STX wm_CursorPos
	LDA.W DATA_009B17,X
	ORA wm_OWSpriteIndex
	STA wm_OWSpriteIndex
	STA m5
	LDX #$00
	JMP _009D3C

CODE_009B80:
	PHB
	PHK
	PLB
	JSR CODE_009B88
	PLB
	RTL

CODE_009B88:
	DEC A
	JSL ExecutePtr

Ptrs009B8D:
	.DW CODE_009B91
	.DW CODE_009B9A

CODE_009B91:
	LDY #$0C
	JSR _009D29
	INC wm_ShowEndMenu
	RTS

CODE_009B9A:
	LDY #$00
	JSR _009AD0
	TXA
	BNE ADDR_009BA5
	JMP _009E17

ADDR_009BA5:
	JMP _009C89

CODE_009BA8:
	PHB
	PHK
	PLB
	JSR CODE_009BB0
	PLB
	RTL

CODE_009BB0:
	LDY #$06
	JSR _009AD0
	TXA
	BNE +
	STZ wm_SoundCh3
	LDA.B #$05
	STA wm_SoundCh1
	JSL CODE_009BC9
+	JSL CODE_009C13
	RTS

CODE_009BC9:
	PHB
	PHK
	PLB
	LDX wm_SaveFile
	LDA.W DATA_009CCB,X
	XBA
	LDA.W DATA_009CCE,X
	REP #$10
	TAX
-	LDY #$0000
	STY wm_8A
--	LDA wm_MapSave,Y
	STA sm_Main,X
	CLC
	ADC wm_8A
	STA wm_8A
	BCC +
	INC wm_8B
+	INX
	INY
	CPY #_sizeof_OW_DATA_BUFFER
	BCC --
	REP #$20
	LDA #$5A5A
	SEC
	SBC wm_8A
	STA sm_Main,X
	CPX #_sizeof_SAVE_SLOT*3
	BCS CODE_009C0F
	TXA
	ADC #_sizeof_SAVE_SLOT*2+2
	TAX
	SEP #$20
	BRA -

CODE_009C0F:
	SEP #$30
	PLB
	RTL

CODE_009C13:
	INC wm_OWPromptTrig
	INC wm_MsgBoxActionFlag
	LDY #$1B
	JSR _009D29
	RTL

; Select denotes that the JoyPad is used for one frame only
DemoJoyPad:
	.DB JoyY+JoyRight,15
	.DB JoyB+JoyY+JoyRight,48
	.DB 0,16
	.DB JoyY+JoyLeft,32
	.DB JoyY+JoyRight,112
	.DB JoyB+JoyRight,17
	.DB 0,128
	.DB JoyB+JoyLeft,12
	.DB 0,48
	.DB JoyB+JoyY+JoyRight,48
	.DB JoyY+JoyRight,96
	.DB JoyB+JoyY+JoyRight,16
	.DB 0,64
	.DB JoyRight,48
	.DB JoyB+JoyY+JoySelect+JoyRight,1
	.DB 0,96
	.DB JoyY+JoyRight,78
	.DB JoyB,16
	.DB 0,48
	.DB JoyY+JoyRight,88
	.DB 0,32
	.DB JoyY+JoySelect,1
	.DB 0,48
	.DB JoyY+JoySelect,1
	.DB 0,48
	.DB JoyY+JoySelect,1
	.DB 0,48
	.DB JoyY+JoySelect,1
	.DB 0,48
	.DB JoyY+JoySelect,1
	.DB 0,48
	.DB JoyY+JoyRight,26
	.DB JoyB+JoyY+JoyRight,48
	.DB 0,48
	.DB -1

GAMEMODE_ShowTitleScreen:
	JSR SetUp0DA0GM4
	JSR CODE_009CBE
	BNE CODE_009C9F
	JSR _NoButtons
	LDX wm_IntroCtrlSeqIndex
	DEC wm_IntroCtrlSeqFrame
	BNE +
	LDA.W DemoJoyPad+1,X
	STA wm_IntroCtrlSeqFrame
	INX
	INX
	STX wm_IntroCtrlSeqIndex
+	LDA.W DemoJoyPad-2,X
	CMP #$FF
	BNE CODE_009C8F
_009C89:
	LDY #$02
_009C8B:
	STY wm_GameMode
	RTS

CODE_009C8F:
	AND #$DF
	STA wm_JoyPadA
	CMP.W DemoJoyPad-2,X
	BNE +
	AND #$9F
+	STA wm_JoyFrameA
	JMP GAMEMODE_ShowLevel

CODE_009C9F:
	JSL wm_ClearOam
	LDA #$04
	STA TM
	LDA #$13
	STA TS
	STZ wm_HDMAEn
_009CB0:
	LDA #$E9
	STA wm_ForceLoadLevel
	JSR CODE_WRITEOW
	JSR CODE_009D38
	JMP _009417

CODE_009CBE:
	LDA wm_JoyPadB
	AND #$C0
	BNE +
	LDA wm_JoyPadA
	AND #$F0
	BNE +
+	RTS

DATA_009CCB:	.DB >sm_Main.1,>sm_Main.2,>sm_Main.3

DATA_009CCE:	.DB <sm_Main.1,<sm_Main.2,<sm_Main.3

GAMEMODE_FileSelect:
	REP #$20
	LDA #$7393
	LDY #$20
	JSR CODE_009D30
	LDY #$02
	JSR CODE_009ACB
	INC wm_GameMode
	CPX #$03
	BNE CODE_009CEF
	STZ wm_OWSpriteIndex
	LDX #$00
	JMP _009D3A

CODE_009CEF:
	STX wm_SaveFile
	JSR CODE_009DB5
	BNE +
	PHX
	STZ wm_ForceLoadLevel
	LDA.B #_sizeof_SAVE_SLOT
	STA m0
-	LDA sm_Main,X
	PHX
	TYX
	STA sm_Main,X
	PLX
	INX
	INY
	DEC m0
	BNE -
	PLX
	LDY.W #$0000
-	LDA sm_Main,X
	STA wm_MapSave,Y
	INX
	INY
	CPY.W #_sizeof_OW_DATA_BUFFER
	BCC -
+	SEP #$10
	LDY #$12
	INC wm_GameMode
_009D29:
	STY wm_ImageLoader
	LDX #$00
	JMP _009ED4

CODE_009D30:
	STA wm_LvBgColor
	STY wm_CgAdSub
	SEP #$20
	RTS

CODE_009D38:
	LDX #$CB
_009D3A:
	STZ m5
_009D3C:
	REP #$10
	LDY #$0000
-	LDA.L DATA_05B6FE,X
	PHX
	TYX
	STA wm_ImageTable,X
	PLX
	INX
	INY
	CPY #$00CC
	BNE -
	SEP #$10
	LDA #$84
	STA m0
	LDX #$02
_009D5B:
	STX m4
	LSR m5
	BCS _009DA6
	JSR CODE_009DB5
	BNE _009DA6
	LDA sm_Main.Data.EventsTriggered,X
	SEP #$10
	CMP #$60
	BCC CODE_009D76
	LDY #$87
	LDA #$88
	BRA _009D7A

CODE_009D76:
	JSR HexToDec
	TXY
_009D7A:
	LDX m0
	STA wm_ImageTable.3.ImgL,X
	TYA
	BNE +
	LDY #$FC
+	TYA
	STA wm_ImageTable.2.ImgL,X
	LDA #$38
	STA wm_ImageTable.2.ImgH,X
	STA wm_ImageTable.3.ImgH,X
	REP #$20
	LDY #$03
-	LDA #$38FC
	STA wm_ImageTable.4.ImgL,X
	INX
	INX
	DEY
	BNE -
	SEP #$20
_009DA6:
	SEP #$10
	LDA m0
	SEC
	SBC #$24
	STA m0
	LDX m4
	DEX
	BPL _009D5B
	RTS

CODE_009DB5:
	LDA.W DATA_009CCB,X
	XBA
	LDA.W DATA_009CCE,X
	REP #$30
	TAX
	CLC
	ADC #_sizeof_SAVE_SLOT*3
	TAY
-	PHX
	PHY
	LDA sm_Main.Checksum,X
	STA wm_8A
	SEP #$20
	LDY #_sizeof_OW_DATA_BUFFER
--	LDA sm_Main,X
	CLC
	ADC wm_8A
	STA wm_8A
	BCC +
	INC wm_8B
+	INX
	DEY
	BNE --
	REP #$20
	PLY
	PLX
	LDA wm_8A
	CMP #$5A5A
	BEQ CODE_009DF7
	CPX #_sizeof_SAVE_SLOT*3-1
	BCS CODE_009DF7
	PHX
	TYX
	PLY
	BRA -

CODE_009DF7:
	SEP #$20
	RTS

GAMEMODE_PlayerSelect:
	LDA wm_JoyFrameA
	ORA wm_JoyFrameB
	AND #$40
	BEQ CODE_009E08
	DEC wm_GameMode
	JMP _009B2C

CODE_009E08:
	LDY.B #$04
	JSR CODE_009ACB
	STX wm_2PlayerGame
	JSR ConfMapFromSave
	JSL CODE_04DAAD
_009E17:
	LDA #$80
	STA wm_MusicCh1
	LDA #$FF
	STA wm_2PLuigiLives
	LDX wm_2PlayerGame
	LDA #$04
-	STA wm_2PMarioLives,X
	DEX
	BPL -
	STA wm_StatusLives
	STZ wm_StatusCoins
	STZ wm_OWHasYoshi
	STZ wm_MarioPowerUp
	STZ wm_ItemInBox
	STZ wm_ShowEndMenu
	REP #$20
	STZ wm_2PlayerCoins
	STZ wm_2PlayerPowerUp
	STZ wm_PlyrYoshiColor
	STZ wm_ItemInBox
	STZ wm_PlayerBonusStars
	STZ wm_MarioScoreHi
	STZ wm_LuigiScoreHi
	SEP #$20
	STZ wm_MarioScoreLo
	STZ wm_LuigiScoreLo
	STZ wm_LevelEndFlag
	STZ wm_OWCharA
_009E62:
	JSR KeepModeActive
	LDY.B #$0B
	JMP _009C8B

DATA_009E6A:	.DW $02,$04,$02,$02,$04

DATA_009E74:	.DW $51CB,$51E8,$5208,$51C4,$51E5

DATA_009E7E:	.DB $01,$02,$04,$08

CODE_009E82:
	LDX wm_CursorPos
	LDA.W DATA_009E7E,X
	TAX
	LDA wm_CursorBlinking
	EOR #$1F
	AND #$18
	BNE +
	LDX.B #$00
+	STX m0
	LDA wm_ImageIndex
	TAX
	REP #$20
	LDA DATA_009E6A,Y
	STA wm_8A
	STA m2
	LDA DATA_009E74,Y
-	XBA
	STA wm_ImageTable,X
	XBA
	CLC
	ADC #$0040
	PHA
	LDA #$0100
	STA wm_ImageTable.2.ImgL,X
	LDA #$38FC
	LSR m0
	BCC +
	LDA #$3D2E
+	STA wm_ImageTable.3.ImgL,X
	PLA
	INX
	INX
	INX
	INX
	INX
	INX
	DEC m2
	BNE -
	SEP #$20
_009ED4:
	TXA
	STA wm_ImageIndex
	LDA #$FF
	STA wm_ImageTable,X
	RTS

DATA_009EE0:	.DW $0328,$014D,$0152,$0153,$085B,$025C,$0457,$0130

DATA_009EF0:	.DW $0101,$02,$02,$68,$78,$68,$78,$06,$07,$06,$07

CODE_WRITEOW:
	LDX.B #_sizeof_OW_DATA_BUFFER
-	STZ wm_1F48,X
	DEX
	BNE -
	LDX.B #$0E
-	LDY.W DATA_009EE0,X
	LDA.W DATA_009EE0+1,X
	STA wm_MapSave,Y
	DEX
	DEX
	BPL -
	LDX.B #$15
-	LDA.W DATA_009EF0,X
	STA wm_MapSave.MarioMap,X
	DEX
	BPL -
	RTS

KeepModeActive:
	LDA #$01
_009F2B:
	STA wm_KeepGameActive
	RTS

DATA_009F2F:	.DB 1,-1

DATA_009F31:	.DB -16,16

DATA_009F33:	.DB 15,0,0,-16

GAMEMODE_Mosaic:
	DEC wm_KeepGameActive
	BPL _Return009F6E
	JSR KeepModeActive
	LDY wm_MosaicDir
	LDA wm_MosaicSize
	CLC
	ADC DATA_009F31,Y
	STA wm_MosaicSize
_009F4C:
	LDA wm_IniDisp
	CLC
	ADC DATA_009F2F,Y
	STA wm_IniDisp
	CMP DATA_009F33,Y
	BNE +
_GMMosaic:
	INC wm_GameMode
	LDA wm_MosaicDir
	EOR #$01
	STA wm_MosaicDir
+	LDA #$03
	ORA wm_MosaicSize
	STA MOSAIC
_Return009F6E:
	RTS

GAMEMODE_Fade:
	DEC wm_KeepGameActive
	BPL _Return009F6E
	JSR KeepModeActive
_009F77:
	LDY wm_MosaicDir
	BRA _009F4C

GAMEMODE_ShowTheEnd:
	DEC wm_KeepGameActive
	BPL _Return009F6E
	LDA #$08
	JSR _009F2B
	BRA _009F77

DATA_009F88:
	.DB 1,2,192
	.DB 1,128,129
	.DB 1,2,192
	.DB 1,2,129
	.DB 1,2,128
	.DB 1,2,129
	.DB 1,2,129
	.DB 1,2,192
	.DB 1,2,192
	.DB 1,2,129
	.DB 1,2,128
	.DB 1,2,128
	.DB 1,2,128
	.DB 1,2,129
	.DB 1,2,129
	.DB 1,2,128

CODE_009FB8:
	LDA wm_LvHeadTileset
	ASL
	CLC
	ADC wm_LvHeadTileset
	STA m0
	LDA wm_L3Settings
	BEQ _00A012
	DEC A
	CLC
	ADC m0
	TAX
	LDA.W DATA_009F88,X
	BMI CODE_009FEA
	STA wm_L3TideSetting
	LSR
	PHP
	JSR CODE_00A045
	LDA #$70
	PLP
	BEQ +
	LDA #$40
+	STA wm_Bg3VOfs
	STZ wm_Bg3VOfs+1
	JSL CODE_05BC72
	BRA _00A01B

CODE_009FEA:
	ASL
	BMI _00A012
	BEQ CODE_00A007
	LDA wm_LvHeadTileset
	CMP #$01
	BEQ +
	CMP #$03
	BNE _00A01F
+	REP #$20
	LDA wm_Bg1HOfs
	LSR
	STA wm_Bg3HOfs
	SEP #$20
	LDA #$C0
	BRA _00A017

CODE_00A007:
	LDX.B #$07
-	LDA.W PALETTE_Layer3Smasher,X
	STA wm_Palette.13.Col,X
	DEX
	BPL -
_00A012:
	INC wm_L3ScrollFlag
	LDA #$D0
_00A017:
	STA wm_Bg3VOfs
	STZ wm_Bg3VOfs+1
_00A01B:
	LDA #$04
	TRB wm_CgAdSub
_00A01F:
	LDA wm_L3Settings
	BEQ +
	DEC A
	CLC
	ADC m0
	STA m1
	ASL
	CLC
	ADC m1
	TAX
	LDA.L Layer3Ptr,X
	STA m0
	LDA.L Layer3Ptr+1,X
	STA m1
	LDA.L Layer3Ptr+2,X
	STA m2
	JSR CODE_00871E
+	RTS

CODE_00A045:
	REP #$30
	LDX #$0100
-	LDY #$0058
	LDA #$0000
--	STA wm_Map16SetL.17,X
	INX
	INX
	DEY
	BNE --
	TXA
	CLC
	ADC #$0100
	TAX
	CPX #$1B00
	BCC -
	SEP #$30
	LDA #$80
	TSB wm_IsVerticalLvl
	RTS

DATA_00A06B:	.DW 0,-17,-17,-17,240,240,240

DATA_00A079:	.DW 0,-40,128,296,-40,128,296

GAMEMODE_LoadOverworld:
	JSR TurnOffIO
	LDA wm_OWWarpFlag
	BEQ +
	JSL CODE_04853B
+	JSR Clear_1A_13D3
	LDA wm_ForceLoadLevel
	BEQ CODE_00A0B0
	LDA #$B0
	STA wm_IntroCtrlSeqFrame
	STZ wm_MapData.MarioMap
	LDA #$F0
	STA wm_MosaicSize
	LDA #$10
	STA wm_GameMode
	JMP _Mode04Finish

CODE_00A0B0:
	JSR CODE_0085FA
	JSR UploadMusicBank1
	JSR SetUpScreen
	STZ wm_LevelMusicMod
	LDX wm_OWCharA
	LDA wm_StatusLives
	BPL +
	INC wm_OWPromptTrig
+	STA wm_2PMarioLives,X
	LDA wm_MarioPowerUp
	STA wm_2PlayerPowerUp,X
	LDA wm_StatusCoins
	STA wm_2PlayerCoins,X
	LDA wm_OWHasYoshi
	BEQ +
	LDA wm_YoshiColor
+	STA wm_PlyrYoshiColor,X
	LDA wm_ItemInBox
	STA wm_ItemInMarioBox,X
	LDA #$03
	STA wm_CgSwSel
	LDA #$30
	LDX #$15
	LDY wm_ShowEndMenu
	BEQ _00A11B
	JSR ConfMapFromSave
	LDA wm_MapData.EventsTriggered
	BNE CODE_00A101
	JSR _009C89
	JMP _0093F4

CODE_00A101:
	JSL CODE_04DAAD
	REP #$20
	LDA #$318C
	STA wm_LvBgColor
	SEP #$20
	LDA #$30
	STA wm_WObjSel
	LDA #$20
	STA wm_CgSwSel
	LDA #$B3
	LDX #$17
_00A11B:
	LDY #$02
	JSR ScreenSettings
	STX TMW
	STY TSW
	JSL CODE_04DC09
	LDX wm_OWCharA
	LDA wm_MapData.MarioMap,X
	ASL
	TAX
	REP #$20
	LDA.W DATA_00A06B,X
	STA wm_Bg1HOfs
	STA wm_Bg2HOfs
	LDA.W DATA_00A079,X
	STA wm_Bg1VOfs
	STA wm_Bg2VOfs
	SEP #$20
	JSR UploadSpriteGFX
	LDY #$14
	JSL CODE_00BA28
	JSR CODE_00AD25
	JSR NintenDMAINIT
	LDA #$06
	STA wm_ImageLoader
	JSR LoadScrnImage
	JSL CODE_05DBF2
	JSR LoadScrnImage
	JSL CODE_048D91
	JSL CODE_04D6E9
	LDA #$F0
	STA wm_OAMAddL
	JSR CODE_008494
	JSR LoadScrnImage
	STZ wm_OWProcessPtr
	JSR KeepModeActive
	LDA #$02
	STA wm_LevelMode
	REP #$10
	LDX #$01BE
	LDA #$FF
-	STZ wm_HDMAWindowsTbl,X
	STA wm_HDMAWindowsTbl+1,X
	DEX
	DEX
	BPL -
	JSR _0092A0
	JMP _0093F4

ConfMapFromSave:
	REP #$10
	LDX #_sizeof_OW_DATA_BUFFER-1
-	LDA wm_MapSave,X
	STA wm_MapData.OwLvFlags,X
	DEX
	BPL -
	SEP #$10
	RTS

Clear_1A_13D3:
	REP #$10
	SEP #$20
	LDX #$00BD
-	STZ wm_Bg1HOfs,X
	DEX
	BPL -
	LDX #$07CE
-	STZ wm_PauseTimer,X
	DEX
	BPL -
	SEP #$10
	RTS

GAMEMODE_ShowOverworld:
	JSR SetUp0DA0GM4
	INC wm_FrameB
	JSL wm_ClearOam
	JSL GameMode_0E_Prim
	JMP CODE_008494

GrndShakeDispYLo:	.DB -2,0,2,0

GrndShakeDispYHi:	.DB -1,0,0,0

UNK_00A1D6:	.DB $12,$22,$12,$02

GAMEMODE_ShowLevel:
	LDA wm_MsgBoxTrig
	BEQ CODE_00A1E4
	JSL CODE_05B10C
	RTS

CODE_00A1E4:
	LDA wm_BonusGameFlag
	BEQ +
	LDA wm_BonusGameEndTimer
	BEQ +
	CMP #$40
	BCS +
	JSR _NoButtons
	CMP #$1C
	BCS +
	JSR SetMarioPeaceImg
	LDA #$0D
	STA wm_MarioAnimation
+	ORA wm_MarioAnimation
	ORA wm_EndLevelTimer
	BEQ +
	LDA #$04
	TRB wm_JoyPadA
	LDA #$40
	TRB wm_JoyFrameA
	TRB wm_JoyFrameB
+	LDA wm_PauseTimer
	BEQ CODE_00A21B
	DEC wm_PauseTimer
	BRA _00A242

CODE_00A21B:
	LDA wm_JoyFrameA
	AND #$10
	BEQ _00A242
	LDA wm_EndLevelTimer
	BNE _00A242
	LDA wm_MarioAnimation
	CMP #$09
	BCS _00A242
	LDA #$3C
	STA wm_PauseTimer
	LDY #$12
	LDA wm_PauseLookFlag
	EOR #$01
	STA wm_PauseLookFlag
	BEQ +
	LDY #$11
+	STY wm_SoundCh1
_00A242:
	LDA wm_PauseLookFlag
	BEQ CODE_00A28A
.IFDEF dbg_AdvanceFrame
	NOP
	NOP
.ELSE
	BRA CODE_00A25B
.ENDIF
	BIT wm_JoyFrameAP2
	BVS +
	LDA wm_JoyPadAP2
	BPL CODE_00A25B
	LDA wm_FrameA
	AND #$0F
	BNE CODE_00A25B
+	BRA CODE_00A28A

CODE_00A25B:
	LDA wm_JoyPadA
	AND #$20
	BEQ +++
	LDY wm_TransLvNum
	LDA wm_MapData.OwLvFlags,Y
.IFDEF dbg_EndLevel
	NOP
	NOP
.ELSE
	BPL +++
.ENDIF
	LDA wm_LevelEndFlag
	BEQ +
	BPL +++
+	LDA #$80
.IFDEF dbg_EndLevel
	NOP
	NOP
.ELSE
	BRA ++
.ENDIF
	LDA #$01
	BIT wm_JoyPadA
	BPL +
	INC A
+	STA wm_MidwayPointFlag
++	STA wm_LevelEndFlag
	INC wm_CreditsEnemyNum
	LDA #$0B
	STA wm_GameMode
+++	RTS

CODE_00A28A:
	LDA wm_LevelMode
	BPL CODE_00A295
	JSR CODE_00987D
	JMP _00A2A9

CODE_00A295:
	JSL wm_ClearOam
	JSL CODE_00F6DB
	JSL CODE_05BC00
	JSL CODE_0586F1
	JSL CODE_05BB39
_00A2A9:
	LDA wm_Bg1VOfs
	PHA
	LDA wm_Bg1VOfs+1
	PHA
	STZ wm_Layer1DispYLo
	STZ wm_Layer1DispYHi
	LDA wm_ShakeGrndTimer
	BEQ +
	DEC wm_ShakeGrndTimer
	AND #$03
	TAY
	LDA GrndShakeDispYLo,Y
	STA wm_Layer1DispYLo
	CLC
	ADC wm_Bg1VOfs
	STA wm_Bg1VOfs
	LDA GrndShakeDispYHi,Y
	STA wm_Layer1DispYHi
	ADC wm_Bg1VOfs+1
	STA wm_Bg1VOfs+1
+	JSR CODE_008E1A
	JSL CODE_00E2BD
	JSR CODE_00A2F3
	JSR CODE_00C47E
	JSL CODE_01808C
	JSL CODE_028AB1
	PLA
	STA wm_Bg1VOfs+1
	PLA
	STA wm_Bg1VOfs
	JMP CODE_008494

CODE_00A2F3:
	REP #$20
	LDA wm_MarioXPos
	STA wm_PlayerXPosLv
	LDA wm_MarioYPos
	STA wm_PlayerYPosLv
	SEP #$20
	RTS

MarioGFXDMA:
	REP #$20
	LDX #$04
	LDY wm_PlayerDmaTiles
	BEQ +
	LDY #$86
	STY CGADD
	LDA #$2200
	STA CH2.PARAM
	LDA wm_PlayerPalPtr
	STA CH2.ADDA1L
	LDY #:PaletteBank
	STY CH2.ADDA1H
	LDA #$0014
	STA CH2.DATAL
	STX MDMAEN
+	LDY #$80
	STY VMAINC
	LDA #$1801
	STA CH2.PARAM
	LDA #$67F0
	STA VMADDL
	LDA wm_Tile7FPtr
	STA CH2.ADDA1L
	LDY #$7E
	STY CH2.ADDA1H
	LDA #$0020
	STA CH2.DATAL
	STX MDMAEN
	LDA #$6000
	STA VMADDL
	LDX #$00
-	LDA wm_0D85,X
	STA CH2.ADDA1L
	LDA #$0040
	STA CH2.DATAL
	LDY #$04
	STY MDMAEN
	INX
	INX
	CPX wm_PlayerDmaTiles
	BCC -
	LDA #$6100
	STA VMADDL
	LDX #$00
-	LDA wm_0D85+10,X
	STA CH2.ADDA1L
	LDA #$0040
	STA CH2.DATAL
	LDY #$04
	STY MDMAEN
	INX
	INX
	CPX wm_PlayerDmaTiles
	BCC -
	SEP #$20
	RTS

CODE_00A390:
	REP #$20
	LDY #$80
	STY VMAINC
	LDA #$1801
	STA CH2.PARAM
	LDY #$7E
	STY CH2.ADDA1H
	LDX #$04
	LDA wm_GfxAnimVma3
	BEQ +
	STA VMADDL
	LDA wm_GfxAnimFrame3
	STA CH2.ADDA1L
	LDA #$0080
	STA CH2.DATAL
	STX MDMAEN
+	LDA wm_GfxAnimVma2
	BEQ +
	STA VMADDL
	LDA wm_GfxAnimFrame2
	STA CH2.ADDA1L
	LDA #$0080
	STA CH2.DATAL
	STX MDMAEN
+	LDA wm_GfxAnimVma1
	BEQ _00A418
	STA VMADDL
	CMP #$0800
	BEQ CODE_00A3F0
	LDA wm_GfxAnimFrame1
	STA CH2.ADDA1L
	LDA #$0080
	STA CH2.DATAL
	STX MDMAEN
	BRA _00A418

CODE_00A3F0:
	LDA wm_GfxAnimFrame1
	STA CH2.ADDA1L
	LDA #$0040
	STA CH2.DATAL
	STX MDMAEN
	LDA #$0900
	STA VMADDL
	LDA wm_GfxAnimFrame1
	CLC
	ADC #$0040
	STA CH2.ADDA1L
	LDA #$0040
	STA CH2.DATAL
	STX MDMAEN
_00A418:
	SEP #$20
	LDA #$64
_00A41C:
	STZ m0
_00A41E:
	STA CGADD
	LDA wm_FrameB
	AND #$1C
	LSR
	ADC m0
	TAY
	LDA PALETTE_Flashing,Y
	STA CGDATAW
	LDA PALETTE_Flashing+1,Y
	STA CGDATAW
	RTS

CODE_00A436:
	LDA wm_WriteMarioStart
	BEQ +
	STZ wm_WriteMarioStart
	REP #$20
	LDY #$80
	STY VMAINC
	LDA #$64A0
	STA VMADDL
	LDA #$1801
	STA CH2.PARAM
	LDA #wm_Sp1GfxDecomp
	STA CH2.ADDA1L
	LDY #$00
	STY CH2.ADDA1H
	LDA #$00C0
	STA CH2.DATAL
	LDX #$04
	STX MDMAEN
	LDA #$65A0
	STA VMADDL
	LDA #wm_Sp1GfxDecomp+192
	STA CH2.ADDA1L
	LDA #$00C0
	STA CH2.DATAL
	STX MDMAEN
	SEP #$20
+	RTS

DATA_00A47F:	.DL wm_PalUplSize,wm_PaletteCopy,wm_Palette

MoreDMA:
	LDY wm_PalUploadIndex
	LDX.W DATA_00A47F+2,Y
	STX m2
	STZ m1
	STZ m0
	STZ m4
	LDA DATA_00A47F+1,Y
	XBA
	LDA DATA_00A47F,Y
	REP #$10
	TAY
-	LDA [m0],Y
	BEQ CODE_00A4CF
	STX CH2.ADDA1H
	STA CH2.DATAL
	STA m3
	STZ CH2.DATAM
	INY
	LDA [m0],Y
	STA CGADD
	REP #$20
	LDA #$2200
	STA CH2.PARAM
	INY
	TYA
	STA CH2.ADDA1L
	CLC
	ADC m3
	TAY
	SEP #$20
	LDA #$04
	STA MDMAEN
	BRA -

CODE_00A4CF:
	SEP #$10
	JSR CODE_00AE47
	LDA wm_PalUploadIndex
	BNE +
	STZ wm_PalSprIndex
	STZ wm_PalUplSize
+	STZ wm_PalUploadIndex
_Return00A4E2:
	RTS

CODE_00A4E3:
	REP #$10
	LDA #$80
	STA VMAINC
	LDY #$0750
	STY VMADDL
	LDY #$1801
	STY CH2.PARAM
	LDY #wm_0AF6
	STY CH2.ADDA1L
	STZ CH2.ADDA1H
	LDY #$0160
	STY CH2.DATAL
	LDA #$04
	STA MDMAEN
	SEP #$10
	LDA wm_OWProcessPtr
	CMP #$0A
	BEQ _Return00A4E2
	LDA #$6D
	JSR _00A41C
	LDA #$10
	STA m0
	LDA #$7D
	JMP _00A41E

DATA_00A521:	.DB $00,$04,$08,$0C

DATA_00A525:	.DB $00,$08,$10,$18

CODE_00A529:
	LDA #$80
	STA VMAINC
	STZ VMADDL
	LDA #$30
	CLC
	ADC DATA_00A521,Y
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_00A586,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA wm_OWCharB
	LSR
	LSR
	TAX
	LDA wm_MapData.MarioMap,X
	BEQ +
	LDA #$60
	STA CH1.ADDA1M
+	LDA CH1.ADDA1M
	CLC
	ADC DATA_00A525,Y
	STA CH1.ADDA1M
	LDA #$02
	STA MDMAEN
	LDA #$80
	STA VMAINC
	STZ VMADDL
	LDA #$20
	CLC
	ADC DATA_00A521,Y
	STA VMADDH
	LDX #$06
-	LDA.W PARAMS_00A58D,X
	STA CH1.PARAM,X
	DEX
	BPL -
	LDA #$02
	STA MDMAEN
	RTS

PARAMS_00A586:
	.DB $01,$18
	.DL wm_OW_L2Tiles
	.DB $00,$08

PARAMS_00A58D:
	.DB $01,$18
	.DL wm_Map16PageL.15
	.DB $00,$08

CODE_00A594:
	PHB
	PHK
	PLB
	JSR CODE_00AD25
	PLB
	RTL

GAMEMODE_PrepareLevel:
	JSR CODE_0085FA
	JSR _NoButtons
	STZ wm_UseBigMsg
	JSR SetUpScreen
	JSR GM04DoDMA
	JSL CODE_05809E
	LDA wm_LevelMode
	BPL CODE_00A5B9
	JSR CODE_0097BC
	BRA _00A5CF

CODE_00A5B9:
	JSR UploadSpriteGFX
	JSR LoadPalette
	JSL CODE_05BE8A
	JSR CODE_009FB8
	JSR CODE_00A5F9
	JSR _009260
	JSR _009860
_00A5CF:
	JSR NintenDMAINIT
	JSR KeepModeActive
	JSR CODE_008E1A
	REP #$30
	PHB
	LDX.W #wm_Palette
	LDY.W #wm_PaletteCopy
	LDA #$01EF
	MVN wm_PaletteCopy>>16,wm_Palette>>16
	PLB
	LDX wm_LvBgColor
	STX wm_LvBgColorCopy
	SEP #$30
	JSR CODE_00919B
	JSR CODE_008494
	JMP _0093F4

CODE_00A5F9:
	LDA #$E7
	TRB wm_FrameB
-	JSL CODE_05BB39
	JSR CODE_00A390
	INC wm_FrameB
	LDA wm_FrameB
	AND #$07
	BNE -
	RTS

DATA_00A60D:	.DB $00,$01,$01,$01

DATA_00A611:	.DW 13,-13,-2,-2,0,0

DATA_00A61D:	.DB $0A,$00,$00,$00,$1A,$1A,$0A,$0A

DATA_00A625:
	.DB $00,$80,$40,$00,$01,$02,$40,$00
	.DB $40,$00,$00,$00,$00,$02,$00,$00

CODE_00A635:
	LDA wm_BluePowTimer
	ORA wm_SilverPowTimer
	ORA wm_DirCoinTimer
	BNE +
	LDA wm_StarPowerTimer
	BEQ +++
	LDA wm_LevelMusicMod
	BPL ++
+	LDA wm_LevelMusicMod
	AND #$7F
++	ORA #$40
	STA wm_LevelMusicMod
	STZ wm_BluePowTimer
	STZ wm_SilverPowTimer
	STZ wm_DirCoinTimer
	STZ wm_StarPowerTimer
+++	LDA wm_CoinBonusBlock1
	ORA wm_CoinBonusBlock2
	ORA wm_CoinBonusBlock3
	ORA wm_CoinBonusBlock4
	ORA wm_CoinBonusBlock5
	BEQ +
	STA wm_StartedBonusGame
+	LDX #$23
-	STZ wm_Map16BlkPtrH+2,X
	DEX
	BNE -
	LDX #$37
-	STZ wm_OWProcessPtr,X
	DEX
	BNE -
	ASL wm_LvEndStarPrize
	STZ wm_KickImgTimer
	STZ wm_PickUpImgTimer
	STZ wm_ColorFadeTimer
	STZ wm_YoshiInPipe
	LDY #$01
	LDX wm_LvHeadTileset
	CPX #$10
	BCS CODE_00A6CC
	LDA.W DATA_00A625,X
	LSR
	BEQ CODE_00A6CC
	LDA wm_ShowMarioStart
	ORA wm_NumSubLvEntered
	ORA wm_DisableNoYoshiIntro
	BNE CODE_00A6CC
	LDA wm_ForceNoLevelIntro
	BEQ CODE_00A6B6
	JSR _00C90A
	BRA CODE_00A6CC

CODE_00A6B6:
	STZ wm_IsFlying
	STY wm_MarioDirection
	STY wm_PipeAction
	LDX #$0A
	LDY #$00
	LDA wm_OWHasYoshi
	BEQ _00A6C7
	LDY #$0F
_00A6C7:
	STX wm_MarioAnimation
	STY wm_PipeWarpTimer
	RTS

CODE_00A6CC:
	LDA wm_Bg1VOfs
	CMP #$C0
	BEQ +
	INC wm_EnableVertScroll
+	LDA wm_LevelHeaderByte
	BEQ _00A6E0
	CMP #$05
	BNE CODE_00A716
	ROR wm_IsSlipperyLevel
_00A6E0:
	STY wm_MarioDirection
	LDA #$24
	STA wm_IsFlying
	STZ wm_SpritesLocked
	LDA wm_KeyHoleTimer
	BEQ +
	LDA wm_LevelMusicMod
	ORA #$7F
	STA wm_LevelMusicMod
	LDA wm_MarioXPos
	ORA #$04
	STA wm_KeyHolePos1
	LDA wm_MarioYPos
	CLC
	ADC #$10
	STA wm_KeyHolePos2
+	LDA wm_YoshiWingsAboveGrnd
	BEQ +
	LDA #$08
	STA wm_MarioAnimation
	LDA #$A0
	STA wm_MarioYPos
	LDA #$90
	STA wm_MarioSpeedY
+	RTS

CODE_00A716:
	CMP #$06
	BCC _00A740
	BNE CODE_00A734
	STY wm_MarioDirection
	STY wm_CapeImage
	LDA #$FF
	STA wm_YoshiInPipe
	LDA #$08
	TSB wm_MarioXPos
	LDA #$02
	TSB wm_MarioYPos
	LDX #$07
	LDY #$20
	BRA _00A6C7

CODE_00A734:
	STY wm_IsWaterLevel
	LDA wm_ForceNoLevelIntro
	ORA wm_KeyHoleTimer
	BNE _00A6E0
	LDA #$04
_00A740:
	CLC
	ADC #$03
	STA wm_PipeAction
	TAY
	LSR
	DEC A
	STA wm_YoshiInPipe
	LDA DATA_00A60D-4,Y
	STA wm_MarioDirection
	LDX #$05
	CPY #$06
	BCC +
	LDA #$08
	TSB wm_MarioXPos
	LDX #$06
	CPY #$07
	LDY #$1E
	BCC ++
	LDY #$0F
	LDA wm_MarioPowerUp
	BEQ ++
+	LDY #$1C
++	STY wm_MarioSpeedY
	JSR _00A6C7
	LDA wm_OnYoshi
	BEQ +
	LDX wm_PipeAction
	LDA wm_PipeWarpTimer
	CLC
	ADC.W DATA_00A61D,X
	STA wm_PipeWarpTimer
	TXA
	ASL
	TAX
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC.W DATA_00A60D-4,X
	STA wm_MarioXPos
	LDA wm_MarioYPos
	CLC
	ADC.W DATA_00A611,X
	STA wm_MarioYPos
	SEP #$20
+	RTS

CODE_00A796:
	REP #$20
	LDY wm_VertScrollLyr2
	BEQ _00A7B9
	DEY
	BNE CODE_00A7A7
	LDA wm_Bg2VOfs
	SEC
	SBC wm_Bg1VOfs
	BRA _00A7B6

CODE_00A7A7:
	LDA wm_Bg1VOfs
	LSR
	DEY
	BEQ +
	LSR
	LSR
+	EOR #$FFFF
	INC A
	CLC
	ADC wm_Bg2VOfs
_00A7B6:
	STA wm_VertL2ScrollLength
_00A7B9:
	LDA #$0080
	STA wm_PosToScrollScreen
	SEP #$20
	RTS

CODE_00A7C2:
	REP #$20
	LDX #$80
	STX VMAINC
	LDA #$6000
	STA VMADDL
	LDA #$1801
	STA CH2.PARAM
	LDA #wm_MsgGFXDecomp.Buf1&$FFFF
	STA CH2.ADDA1L
	LDX #wm_MsgGFXDecomp>>16
	STX CH2.ADDA1H
	LDA #$00C0
	STA CH2.DATAL
	LDX #$04
	STX MDMAEN
	LDA #$6100
	STA VMADDL
	LDA #wm_MsgGFXDecomp.Buf2&$FFFF
	STA CH2.ADDA1L
	LDA #$00C0
	STA CH2.DATAL
	STX MDMAEN
	LDA #$64A0
	STA VMADDL
	LDA #wm_MsgGFXDecomp.Buf3&$FFFF
	STA CH2.ADDA1L
	LDA #$00C0
	STA CH2.DATAL
	STX MDMAEN
	LDA #$65A0
	STA VMADDL
	LDA #wm_MsgGFXDecomp.Buf4&$FFFF
	STA CH2.ADDA1L
	LDA #$00C0
	STA CH2.DATAL
	STX MDMAEN
	SEP #$20
	RTS

CODE_00A82D:
	LDY #$0F
	JSL CODE_00BA28
	LDA wm_BonusGameFlag
	REP #$30
	BEQ +
	LDA m0
	CLC
	ADC #$0030
	STA m0
+	LDX #$0000
-	LDY #$0008
--	LDA [m0]
	STA wm_MsgGFXDecomp,X
	INX
	INX
	INC m0
	INC m0
	DEY
	BNE --
	LDY #$0008
---	LDA [m0]
	AND #$00FF
	STA wm_MsgGFXDecomp,X
	INX
	INX
	INC m0
	DEY
	BNE ---
	CPX #$0300
	BCC -
	SEP #$30
	LDY #$00
	JSL CODE_00BA28
	REP #$30
	LDA #$B3F0
	STA m0
	LDA #$7EB3
	STA m1
	LDX #$0000
-	LDY #$0008
--	LDA [m0]
	STA wm_Sp1GfxDecomp,X
	INX
	INX
	INC m0
	INC m0
	DEY
	BNE --
	LDY #$0008
---	LDA [m0]
	AND #$00FF
	STA wm_Sp1GfxDecomp,X
	INX
	INX
	INC m0
	DEY
	BNE ---
	CPX #$00C0
	BNE +
	LDA #$B570
	STA m0
+	CPX #$0180
	BCC -
	SEP #$30
	LDA #$01
	STA wm_UseBigMsg
	STA wm_WriteMarioStart
	RTS

SPRITEGFXLIST:
	.DB $00,$01,$13,$02,$00,$01,$12,$03
	.DB $00,$01,$13,$05,$00,$01,$13,$04
	.DB $00,$01,$13,$06,$00,$01,$13,$09
	.DB $00,$01,$13,$04,$00,$01,$06,$11
	.DB $00,$01,$13,$20,$00,$01,$13,$0F
	.DB $00,$01,$13,$23,$00,$01,$0D,$14
	.DB $00,$01,$24,$0E,$00,$01,$0A,$22
	.DB $00,$01,$13,$0E,$00,$01,$13,$14
	.DB $00,$00,$00,$08,$10,$0F,$1C,$1D
	.DB $00,$01,$24,$22,$00,$01,$25,$22
	.DB $00,$22,$13,$2D,$00,$01,$0F,$22
	.DB $00,$26,$2E,$22,$21,$0B,$25,$0A
	.DB $00,$0D,$24,$22,$2C,$30,$2D,$0E

OBJECTGFXLIST:
	.DB $14,$17,$19,$15,$14,$17,$1B,$18
	.DB $14,$17,$1B,$16,$14,$17,$0C,$1A
	.DB $14,$17,$1B,$08,$14,$17,$0C,$07
	.DB $14,$17,$0C,$16,$14,$17,$1B,$15
	.DB $14,$17,$19,$16,$14,$17,$0D,$1A
	.DB $14,$17,$1B,$08,$14,$17,$1B,$18
	.DB $14,$17,$19,$1F,$14,$17,$0D,$07
	.DB $14,$17,$19,$1A,$14,$17,$14,$14
	.DB $0E,$0F,$17,$17,$1C,$1D,$08,$1E
	.DB $1C,$1D,$08,$1E,$1C,$1D,$08,$1E
	.DB $1C,$1D,$08,$1E,$1C,$1D,$08,$1E
	.DB $1C,$1D,$08,$1E,$1C,$1D,$08,$1E
	.DB $14,$17,$19,$2C,$19,$17,$1B,$18

CODE_00A993:
	STZ VMADDL
	LDA #$40
	STA VMADDH
	LDA #$03
	STA m15
	LDA #$28
	STA m14
-	LDA m14
	TAY
	JSL CODE_00BA28
	REP #$30
	LDX #$03FF
	LDY #$0000
--	LDA [m0],Y
	STA VMDATAWL
	INY
	INY
	DEX
	BPL --
	SEP #$30
	INC m14
	DEC m15
	BPL -
	STZ VMADDL
	LDA #$60
	STA VMADDH
	LDY #$00
	JSR UploadGFXFile
	RTS

DATA_00A9D2:	.DB $78,$70,$68,$60

DATA_00A9D6:	.DB $18,$10,$08,$00

UploadSpriteGFX:
	LDA #$80
	STA VMAINC
	LDX #$03
	LDA wm_CurSprGfx
	ASL
	ASL
	TAY
-	LDA SPRITEGFXLIST,Y
	STA m4,X
	INY
	DEX
	BPL -
	LDA #$03
	STA m15
-	LDX m15
	STZ VMADDL
	LDA.W DATA_00A9D2,X
	STA VMADDH
	LDY m4,X
	LDA wm_SpriteGfxSet,X
	CMP m4,X
	BEQ +
	JSR UploadGFXFile
+	DEC m15
	BPL -
	LDX #$03
-	LDA m4,X
	STA wm_SpriteGfxSet,X
	DEX
	BPL -
	LDA wm_LvHeadTileset
	CMP #$FE
	BCS SetallFGBG80
	LDX #$03
	LDA wm_LvHeadTileset
	ASL
	ASL
	TAY
-	LDA OBJECTGFXLIST,Y
	STA m4,X
	INY
	DEX
	BPL -
	LDA #$03
	STA m15
-	LDX m15
	STZ VMADDL
	LDA.W DATA_00A9D6,X
	STA VMADDH
	LDY m4,X
	LDA wm_LayerGfxSet,X
	CMP m4,X
	BEQ +
	JSR UploadGFXFile
+	DEC m15
	BPL -
	LDX #$03
-	LDA m4,X
	STA wm_LayerGfxSet,X
	DEX
	BPL -
	RTS

SetallFGBG80:
	BEQ +
	JSR CODE_00AB42
+	LDX #$03
	LDA #$80
-	STA wm_LayerGfxSet,X
	DEX
	BPL -
	RTS

UploadGFXFile:
	JSL CODE_00BA28
	CPY #$01
	BNE +
	LDA wm_MapData.OwLvFlags.Lv125
	BPL +
	LDY #$31
	JSL CODE_00BA28
	LDY #$01
+	REP #$20
	LDA #$0000
	LDX wm_LvHeadTileset
	CPX #$11
	BCC +
	CPY #$08
	BEQ CODE_00AA96
+	CPY #$1E
	BEQ CODE_00AA96
	BNE CODE_00AA99 ; [BRA FIX]

CODE_00AA96:
	JMP FilterSomeRAM

CODE_00AA99:
	STA m10
	LDA #$FFFF
	CPY #$01
	BEQ +
	CPY #$17
	BEQ +
	LDA #$0000
+	STA wm_1BBC
	LDY #$7F
-	LDA wm_1BBC
	BEQ ++
	CPY #$7E
	BCC +
--	LDA #$FF00
	STA m10
	BNE ++
+	CPY #$6E
	BCC CODE_00AAC8
	CPY #$70
	BCS CODE_00AAC8
	BCC -- ; [BRA FIX]

CODE_00AAC8:
	LDA #$0000
	STA m10
++	LDX #$07
--	LDA [m0]
	STA VMDATAWL
	XBA
	ORA [m0]
	STA wm_1BB2,X
	INC m0
	INC m0
	DEX
	BPL --
	LDX #$07
--	LDA [m0]
	AND #$00FF
	STA m12
	LDA [m0]
	XBA
	ORA wm_1BB2,X
	AND m10
	ORA m12
	STA VMDATAWL
	INC m0
	DEX
	BPL --
	DEY
	BPL -
	SEP #$20
	RTS

FilterSomeRAM:
	LDA.W #$FF00
	STA m10
	LDY #$7F
-	CPY #$08
	BCS + ;Useless
+	LDX #$07
--	LDA [m0]
	STA VMDATAWL
	XBA
	ORA [m0]
	STA wm_1BB2,X
	INC m0
	INC m0
	DEX
	BPL --
	LDX #$07
--	LDA [m0]
	AND.W #$00FF
	STA m12
	LDA [m0]
	XBA
	ORA wm_1BB2,X
	AND m10
	ORA m12
	STA VMDATAWL
	INC m0
	DEX
	BPL --
	DEY
	BPL -
	SEP #$20
	RTS

CODE_00AB42:
	LDY #$27
	JSL CODE_00BA28
	REP #$10
	LDY #$0000
	LDX #$03FF
-	LDA [m0],Y
	STA m15
	JSR CODE_00ABC4
	LDA m4
	STA VMDATAWH
	JSR CODE_00ABC4
	LDA m4
	STA VMDATAWH
	STZ m4
	ROL m15
	ROL m4
	ROL m15
	ROL m4
	INY
	LDA [m0],Y
	STA m15
	ROL m15
	ROL m4
	LDA m4
	STA VMDATAWH
	JSR CODE_00ABC4
	LDA m4
	STA VMDATAWH
	JSR CODE_00ABC4
	LDA m4
	STA VMDATAWH
	STZ m4
	ROL m15
	ROL m4
	INY
	LDA [m0],Y
	STA m15
	ROL m15
	ROL m4
	ROL m15
	ROL m4
	LDA m4
	STA VMDATAWH
	JSR CODE_00ABC4
	LDA m4
	STA VMDATAWH
	JSR CODE_00ABC4
	LDA m4
	STA VMDATAWH
	INY
	DEX
	BPL -
	LDX #$2000
-	STZ VMDATAWH
	DEX
	BNE -
	SEP #$10
	RTS

CODE_00ABC4:
	STZ m4
	ROL m15
	ROL m4
	ROL m15
	ROL m4
	ROL m15
	ROL m4
	RTS

DATA_00ABD3:
	.DB $00,$18,$30,$48,$60,$78,$90,$A8
	.DB $00,$14,$28,$3C

DATA_00ABDF:
	.DW PALETTE_OW_Areas@YI-PALETTE_OW_Areas
	.DW PALETTE_OW_Areas@MA-PALETTE_OW_Areas
	.DW PALETTE_OW_Areas@Star-PALETTE_OW_Areas
	.DW PALETTE_OW_Areas@VD_VB-PALETTE_OW_Areas
	.DW PALETTE_OW_Areas@FI-PALETTE_OW_Areas
	.DW PALETTE_OW_Areas@Special-PALETTE_OW_Areas
	.DW PALETTE_OW_Areas@None-PALETTE_OW_Areas ; Probably used by Valley of Bowser before it had the same palette as Vanilla Dome

LoadPalette:
	REP #$30
	LDA #$7FDD
	STA m4
	LDX #$0002
	JSR LoadCol8Pal
	LDA #$7FFF
	STA m4
	LDX #$0102
	JSR LoadCol8Pal
	LDA.W #PALETTE_Layer3
	STA m0
	LDA #$0010
	STA m4
	LDA #$0007
	STA m6
	LDA #$0001
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_Objects
	STA m0
	LDA #$0084
	STA m4
	LDA #$0005
	STA m6
	LDA #$0009
	STA m8
	JSR LoadColors
	LDA wm_LvHeadBgCol
	AND #$000F
	ASL
	TAY
	LDA PALETTE_Sky,Y
	STA wm_LvBgColor
	LDA.W #PALETTE_Foreground
	STA m0
	LDA wm_LvHeadFgPal
	AND #$000F
	TAY
	LDA DATA_00ABD3,Y
	AND #$00FF
	CLC
	ADC m0
	STA m0
	LDA #$0044
	STA m4
	LDA #$0005
	STA m6
	LDA #$0001
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_Sprites
	STA m0
	LDA wm_LvHeadSprPal
	AND #$000F
	TAY
	LDA DATA_00ABD3,Y
	AND #$00FF
	CLC
	ADC m0
	STA m0
	LDA #$01C4
	STA m4
	LDA #$0005
	STA m6
	LDA #$0001
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_Background
	STA m0
	LDA wm_LvHeadBgPal
	AND #$000F
	TAY
	LDA DATA_00ABD3,Y
	AND #$00FF
	CLC
	ADC m0
	STA m0
	LDA #$0004
	STA m4
	LDA #$0005
	STA m6
	LDA #$0001
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_YoshiBerry
	STA m0
	LDA #$0052
	STA m4
	LDA #$0006
	STA m6
	LDA #$0002
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_YoshiBerry
	STA m0
	LDA #$0132
	STA m4
	LDA #$0006
	STA m6
	LDA #$0002
	STA m8
	JSR LoadColors
	SEP #$30
	RTS

LoadCol8Pal:
	LDY.W #$0007
-	LDA m4
	STA wm_Palette,X
	TXA
	CLC
	ADC.W #$0020
	TAX
	DEY
	BPL -
	RTS

LoadColors:
	LDX m4
	LDY m6
-	LDA (m0)
	STA wm_Palette,X
	INC m0
	INC m0
	INX
	INX
	DEY
	BPL -
	LDA m4
	CLC
	ADC.W #$0020
	STA m4
	DEC m8
	BPL LoadColors
	RTS

DATA_00AD1E:
	.DB $01 ; Main Area
	.DB $00 ; Yoshi's Island
	.DB $03 ; Vanilla Dome
	.DB $04 ; Forest of Illusion
	.DB $03 ; Valley of Bowser
	.DB $05 ; Special World
	.DB $02 ; Star World

CODE_00AD25:
	REP #$30
	LDY.W #PALETTE_OW_Areas
	LDA wm_MapData.OwLvFlags.Lv124
	BPL +
	LDY.W #PALETTE_OW_AreasPassed
+	STY m0
	LDA wm_LvHeadTileset
	AND #$000F
	DEC A
	TAY
	LDA DATA_00AD1E,Y
	AND #$00FF
	ASL
	TAY
	LDA DATA_00ABDF,Y
	CLC
	ADC m0
	STA m0
	LDA #$0082
	STA m4
	LDA #$0006
	STA m6
	LDA #$0003
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_OW_Objects
	STA m0
	LDA #$0052
	STA m4
	LDA #$0006
	STA m6
	LDA #$0005
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_OW_Sprites
	STA m0
	LDA #$0102
	STA m4
	LDA #$0006
	STA m6
	LDA #$0007
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_OW_Layer3
	STA m0
	LDA #$0010
	STA m4
	LDA #$0007
	STA m6
	LDA #$0001
	STA m8
	JSR LoadColors
	SEP #$30
	RTS

CODE_00ADA6:
	REP #$30
	LDA.W #DATA_B63C
	STA m0
	LDA #$0010
	STA m4
	LDA #$0007
	STA m6
	LDA #$0000
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_TS_Layer3
	STA m0
	LDA #$0030
	STA m4
	LDA #$0007
	STA m6
	LDA #$0000
	STA m8
	JSR LoadColors
	SEP #$30
	RTS

CODE_00ADD9:
	JSR LoadPalette
	REP #$30
	LDA #$0017
	STA wm_LvBgColor
	LDA.W #PALETTE_Layer3
	STA m0
	LDA #$0010
	STA m4
	LDA #$0007
	STA m6
	LDA #$0001
	STA m8
	JSR LoadColors
	LDA.W #PALETTE_IggyLarryPlatform
	STA m0
	LDA #$0000
	STA m4
	LDA #$0007
	STA m6
	LDA #$0000
	STA m8
	JSR LoadColors
	SEP #$30
	RTS

CODE_00AE15:
	LDA #$02
	STA wm_LvHeadSprPal
	LDA #$07
	STA wm_LvHeadFgPal
	JSR LoadPalette
	REP #$30
	LDA #$0017
	STA wm_LvBgColor
	LDA.W #DATA_B5F4
	STA m0
	LDA #$0018
	STA m4
	LDA #$0003
	STA m6
	STZ m8
	JSR LoadColors
	SEP #$30
	RTS

DATA_00AE41:	.DB $00,$05,$0A

DATA_00AE44:	.DB $20,$40,$80

CODE_00AE47:
	LDX #$02
_00AE49:
	REP #$20
	LDA wm_LvBgColor
	LDY.W DATA_00AE41,X
-	DEY
	BMI CODE_00AE57
	LSR
	BRA -

CODE_00AE57:
	SEP #$20
	AND #$1F
	ORA.W DATA_00AE44,X
	STA COLDATA
	DEX
	BPL _00AE49
	RTS

DATA_00AE65:	.DW $001F,$03E0,$7C00

DATA_00AE6B:	.DW $FFFF,$FFE0,$FC00

DATA_00AE71:	.DW $0001,$0020,$0400

DATA_00AE77:
	.DW $0000,$0000,$0001,$0000
	.DW $8000,$8000,$8020,$0400
	.DW $8080,$8080,$8208,$1040
	.DW $8420,$8420,$8844,$2210
	.DW $8888,$8888,$9122,$4488
	.DW $9248,$9248,$A492,$4924
	.DW $A4A4,$A4A4,$A949,$5294
	.DW $AAAA,$5294,$AAAA,$5554
	.DW $AAAA,$AAAA,$D5AA,$AAAA
	.DW $D5AA,$D5AA,$D6B5,$AD6A
	.DW $DADA,$DADA,$DB6D,$B6DA
	.DW $EDB6,$EDB6,$EEDD,$BB76
	.DW $EEEE,$EEEE,$F7BB,$DDEE
	.DW $FBDE,$FBDE,$FDF7,$EFBE
	.DW $FEFE,$FEFE,$FFDF,$FBFE
	.DW $FFFE,$FFFE,$FFFF,$FFFE

DATA_00AEF7:
	.DW $8000,$4000,$2000,$1000
	.DW $0800,$0400,$0200,$0100
	.DW $0080,$0040,$0020,$0010
	.DW $0008,$0004,$0002,$0001

CODE_00AF17:
	LDY wm_EndLevelTimer
	LDA wm_FrameA
	LSR
	BCC +
	DEY
	BEQ +
	STY wm_EndLevelTimer
+	CPY #$A0
	BCS _00AF35
	LDA #$04
	TRB wm_CgAdSub
	LDA #$09
	STA wm_BgMode
	JSL CODE_05CBFF
_00AF35:
	LDA wm_FrameA
	AND #$03
	BNE +
	LDA wm_ColorFadeTimer
	CMP #$40
	BCS +
	JSR CODE_00AFA3
	LDA.W #$01FE
	STA wm_PaletteCopy
	LDX.W #$00EE
-	LDA.W #$0007
	STA m0
--	LDA wm_PaletteCopy,X
	STA m2
	LDA wm_Palette,X
	JSR CODE_00AFC0
	LDA m4
	STA wm_PaletteCopy,X
	DEX
	DEX
	DEC m0
	BNE --
	TXA
	SEC
	SBC.W #$0012
	TAX
	BPL -
	LDX.W #$0004
-	LDA wm_PaletteCopy.14.Col,X
	STA m2
	LDA wm_Palette.14.Col,X
	JSR CODE_00AFC0
	LDA m4
	STA wm_PaletteCopy.14.Col,X
	DEX
	DEX
	BPL -
	LDA wm_LvBgColor
	STA m2
	LDA wm_LvBgColorCopy
	JSR CODE_00AFC0
	LDA m4
	STA wm_LvBgColor
	SEP #$30
	STZ wm_PaletteCopy.129.Col
	LDA #$03
	STA wm_PalUploadIndex
+	RTS

CODE_00AFA3:
	TAY
	INC A
	INC A
	STA wm_ColorFadeTimer
	TYA
	LSR
	LSR
	LSR
	LSR
	REP #$30
	AND #$0002
	STA m12
	TYA
	AND #$001E
	TAY
	LDA DATA_00AEF7,Y
	STA m14
	RTS

CODE_00AFC0:
	STA m10
	AND #$001F
	ASL
	ASL
	STA m6
	LDA m10
	AND #$03E0
	LSR
	LSR
	LSR
	STA m8
	LDA m11
	AND #$007C
	STA m10
	STZ m4
	LDY #$0004
-	PHY
	LDA.W m6,Y
	ORA m12
	TAY
	LDA DATA_00AE77,Y
	PLY
	AND m14
	BEQ +
	LDA DATA_00AE6B,Y
	BIT wm_EndLevelTimer
	BPL +
	LDA DATA_00AE71,Y
+	CLC
	ADC m2
	AND DATA_00AE65,Y
	TSB m4
	DEY
	DEY
	BPL -
	RTS

CODE_00B006:
	PHB
	PHK
	PLB
	JSR CODE_00AFA3
	LDX #$006E
-	LDY #$0008
--	LDA wm_PaletteCopy.2.Col,X
	STA m2
	LDA wm_Palette.65.Col,X
	PHY
	JSR CODE_00AFC0
	PLY
	LDA m4
	STA wm_PaletteCopy.2.Col,X
	LDA wm_Palette.65.Col,X
	SEC
	SBC m4
	STA wm_PaletteCopy.59.Col,X
	DEX
	DEX
	DEY
	BNE --
	TXA
	SEC
	SBC #$0010
	TAX
	BPL -
	SEP #$30
	PLB
	RTL

CODE_00B03E:
	JSR _00AF35
	LDA wm_PalUploadIndex
	CMP #$03
	BNE +
	LDA #:PaletteBank
	STA m2
	REP #$30
	LDA wm_PlayerPalPtr
	STA m0
	LDY #$0014
-	LDA [m0],Y
	STA wm_PaletteCopy.135.Col,Y
	DEY
	DEY
	BPL -
	LDA #$81EE
	STA wm_PaletteCopy.129.Col
	LDX #$00CE
-	LDA #$0007
	STA m0
--	LDA wm_PaletteCopy.145.Col,X
	STA m2
	LDA wm_Palette.145.Col,X
	JSR CODE_00AFC0
	LDA m4
	STA wm_PaletteCopy.145.Col,X
	DEX
	DEX
	DEC m0
	BNE --
	TXA
	SEC
	SBC #$0012
	TAX
	BPL -
	SEP #$30
	STZ wm_0AF5
+	RTS

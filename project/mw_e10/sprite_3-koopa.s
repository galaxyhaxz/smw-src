DATA_03D700:
	.DB $B0,$A0,$90,$80,$70,$60,$50,$40
	.DB $30,$20,$10,$00

CODE_03D70C:
	PHX
	LDA wm_SpriteMiscTbl3.Spr5 ; reznor dead
	CLC
	ADC wm_SpriteMiscTbl3.Spr6
	ADC wm_SpriteMiscTbl3.Spr7
	ADC wm_SpriteMiscTbl3.Spr8
	CMP #$02
	BCC _03D757
	LDX wm_ReznorBrokenTiles
	CPX #$0C
	BCS _03D757
	LDA.L DATA_03D700,X
	STA wm_BlockYPos
	STZ wm_BlockYPos+1
	LDA #$B0
	STA wm_BlockXPos
	STZ wm_BlockXPos+1
	LDA wm_ReznorBridgeTimer
	BEQ CODE_03D74A
	CMP #$3C
	BNE _03D757
	JSR CODE_03D77F
	JSR CODE_03D759
	JSR CODE_03D77F
	INC wm_ReznorBrokenTiles
	BRA _03D757

CODE_03D74A:
	JSR CODE_03D766
	LDA #$40
	STA wm_ReznorBridgeTimer
	LDA #$07
	STA wm_SoundCh3
_03D757:
	PLX
	RTL

CODE_03D759:
	REP #$20
	LDA #$0170
	SEC
	SBC wm_BlockYPos
	STA wm_BlockYPos
	SEP #$20
	RTS

CODE_03D766:
	JSR _03D76C
	JSR CODE_03D759
_03D76C:
	REP #$20
	LDA wm_BlockYPos
	SEC
	SBC wm_Bg1HOfs
	CMP #$0100
	SEP #$20
	BCS +
	JSL CODE_028A44
+	RTS

CODE_03D77F:
	LDA wm_BlockYPos
	LSR
	LSR
	LSR
	STA m1
	LSR
	ORA wm_BlockXPos
	REP #$20
	AND #$00FF
	LDX wm_BlockYPos+1
	BEQ +
	CLC
	ADC #$01B0
	LDX #$04
+	STX m0
	REP #$10
	TAX
	SEP #$20
	LDA #$25
	STA wm_Map16PageL,X
	LDA #$00
	STA wm_Map16PageH,X
	REP #$20
	LDA wm_ImageIndex
	TAX
	LDA #$C05A
	CLC
	ADC m0
	STA wm_ImageTable,X
	ORA #$2000
	STA wm_ImageTable.4.ImgL,X
	LDA #$0240
	STA wm_ImageTable.2.ImgL,X
	STA wm_ImageTable.5.ImgL,X
	LDA #$38FC
	STA wm_ImageTable.3.ImgL,X
	STA wm_ImageTable.6.ImgL,X
	LDA #$00FF
	STA wm_ImageTable.7.ImgL,X
	TXA
	CLC
	ADC #$000C
	STA wm_ImageIndex
	SEP #$30
	RTS

IggyPlatformTiles:
	.DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$15,$16,$17,$18,$17,$18,$17,$18,$17,$18,$19,$1A,$00,$00
	.DB $00,$00,$01,$02,$03,$04,$03,$04,$03,$04,$03,$04,$05,$12,$00,$00
	.DB $00,$00,$00,$07,$04,$03,$04,$03,$04,$03,$04,$03,$08,$00,$00,$00
	.DB $00,$00,$00,$09,$0A,$04,$03,$04,$03,$04,$03,$0B,$0C,$00,$00,$00
	.DB $00,$00,$00,$00,$0D,$0E,$04,$03,$04,$03,$0F,$10,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$11,$02,$03,$04,$03,$04,$05,$12,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$07,$04,$03,$04,$03,$08,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$09,$0A,$04,$03,$0B,$0C,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$13,$03,$04,$14,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$13,$14,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

DATA_03D8EC:
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$24,$34
	.DB $25,$0B,$26,$36,$0E,$1B,$0C,$1C
	.DB $0D,$1D,$0E,$1E,$29,$39,$2A,$3A
	.DB $2B,$3B,$26,$38,$20,$30,$21,$31
	.DB $27,$37,$28,$38,$FF,$FF,$22,$32
	.DB $0E,$33,$0C,$1C,$0D,$1D,$0E,$3C
	.DB $2D,$3D,$FF,$FF,$07,$17,$0E,$23
	.DB $0E,$04,$0C,$1C,$0D,$1D,$0E,$09
	.DB $0E,$2C,$0A,$1A,$FF,$FF,$24,$34
	.DB $2B,$3B,$FF,$FF,$07,$17,$0E,$18
	.DB $0E,$19,$0A,$1A,$02,$12,$03,$13
	.DB $03,$08,$03,$05,$03,$05,$03,$14
	.DB $03,$15,$03,$05,$03,$05,$03,$08
	.DB $03,$06,$0F,$1F

CODE_03D958:
	REP #$10
	STZ VMAINC
	STZ VMADDL
	STZ VMADDH
	LDX #$4000
	LDA #$FF
-	STA VMDATAWL
	DEX
	BNE -
	SEP #$10
	BIT wm_LevelMode
	BVS +
	PHB
	PHK
	PLB
	LDA #<IggyPlatformTiles
	STA m5
	LDA #>IggyPlatformTiles
	STA m6
	LDA #:IggyPlatformTiles
	STA m7
	LDA #$10
	STA m0
	LDA #$08
	STA m1
	JSR CODE_03D991
	PLB
+	RTL

CODE_03D991:
	STZ VMAINC
	LDY #$00
-	STY m2
	LDA #$00
--	STA m3
	LDA m0
	STA VMADDL
	LDA m1
	STA VMADDH
	LDY m2
	LDA #$10
	STA m4
---	LDA [m5],Y
	STA wm_0AF6,Y
	ASL
	ASL
	ORA m3
	TAX
	LDA.L DATA_03D8EC,X
	STA VMDATAWL
	LDA.L DATA_03D8EC+2,X
	STA VMDATAWL
	INY
	DEC m4
	BNE ---
	LDA m0
	CLC
	ADC #$80
	STA m0
	BCC +
	INC m1
+	LDA m3
	EOR #$01
	BNE --
	TYA
	BNE -
	RTS

DATA_03D9DE:
; Morton
	.DB $FF,$00,$FF,$FF,$02,$04,$06,$FF
	.DB $08,$0A,$0C,$FF,$0E,$10,$12,$FF
	.DB $FF,$00,$FF,$FF,$02,$04,$06,$FF
	.DB $08,$0A,$0C,$FF,$0E,$14,$16,$FF
	.DB $FF,$00,$FF,$FF,$02,$04,$06,$FF
	.DB $08,$0A,$0C,$FF,$0E,$18,$1A,$FF
	.DB $46,$48,$4A,$FF,$4C,$4E,$50,$FF
	.DB $52,$54,$0C,$FF,$0E,$18,$1A,$FF
	.DB $FF,$FF,$FF,$FF,$B2,$B4,$06,$FF
	.DB $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF
	.DB $FF,$1C,$FF,$FF,$1E,$20,$22,$FF
	.DB $24,$26,$28,$FF,$FF,$2A,$2C,$FF
	.DB $FF,$2E,$30,$FF,$32,$34,$35,$33
	.DB $36,$38,$39,$37,$42,$44,$45,$43
	.DB $FF,$2E,$30,$FF,$32,$34,$35,$33
	.DB $36,$38,$39,$37,$42,$44,$45,$43
	.DB $FF,$2E,$30,$FF,$32,$34,$35,$33
	.DB $36,$38,$39,$37,$3E,$40,$41,$3F
; Roy
	.DB $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF
	.DB $08,$0A,$0C,$FF,$0E,$10,$12,$FF
	.DB $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF
	.DB $08,$0A,$0C,$FF,$0E,$14,$16,$FF
	.DB $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF
	.DB $08,$0A,$0C,$FF,$0E,$18,$1A,$FF
	.DB $6C,$6E,$FF,$FF,$72,$74,$50,$FF
	.DB $52,$54,$0C,$FF,$0E,$18,$1A,$FF
	.DB $FF,$BE,$FF,$FF,$DC,$DE,$06,$FF
	.DB $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF
	.DB $60,$62,$FF,$FF,$64,$66,$22,$FF
	.DB $24,$26,$28,$FF,$FF,$2A,$2C,$FF
	.DB $FF,$68,$69,$FF,$32,$6A,$6B,$33
	.DB $36,$38,$39,$37,$42,$44,$45,$43
	.DB $FF,$68,$69,$FF,$32,$6A,$6B,$33
	.DB $36,$38,$39,$37,$42,$44,$45,$43
	.DB $FF,$68,$69,$FF,$32,$6A,$6B,$33
	.DB $36,$38,$39,$37,$3E,$40,$41,$3F
; Ludwig
	.DB $7A,$7C,$FF,$FF,$7E,$80,$82,$FF
	.DB $84,$86,$0C,$FF,$0E,$10,$12,$FF
	.DB $7A,$7C,$FF,$FF,$7E,$80,$06,$FF
	.DB $84,$86,$0C,$FF,$0E,$14,$16,$FF
	.DB $7A,$7C,$FF,$FF,$7E,$80,$06,$FF
	.DB $84,$86,$0C,$FF,$0E,$18,$1A,$FF
	.DB $A0,$A2,$A4,$FF,$A6,$A8,$AA,$FF
	.DB $52,$54,$0C,$FF,$0E,$18,$1A,$FF
	.DB $FF,$B8,$FF,$FF,$D6,$D8,$DA,$FF
	.DB $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF
	.DB $88,$8A,$8C,$FF,$8E,$90,$92,$FF
	.DB $94,$96,$28,$FF,$FF,$2A,$2C,$FF
	.DB $98,$9A,$9B,$99,$9C,$9E,$9F,$9D
	.DB $36,$38,$39,$37,$42,$44,$45,$43
	.DB $98,$9A,$9B,$99,$9C,$9E,$9F,$9D
	.DB $36,$38,$39,$37,$42,$44,$45,$43
	.DB $98,$9A,$9B,$99,$9C,$9E,$9F,$9D
	.DB $36,$38,$39,$37,$3E,$40,$41,$3F
	.DB $FF,$FF,$FF,$FF,$FF,$CC,$FF,$FF
	.DB $C0,$C2,$C4,$FF,$E0,$E2,$E4,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$CC,$FF,$FF
	.DB $C6,$C8,$CA,$FF,$E6,$E8,$EA,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$CD,$FF,$FF
	.DB $C5,$C3,$C1,$FF,$E5,$E3,$E1,$FF
; Bowser
	.DB $FF,$90,$92,$94,$96,$FF,$FF,$FF
	.DB $FF,$B0,$B2,$B4,$B6,$38,$FF,$FF
	.DB $FF,$D0,$D2,$D4,$D6,$58,$5A,$FF
	.DB $FF,$F0,$F2,$F4,$F6,$78,$7A,$FF
	.DB $FF,$90,$92,$94,$96,$FF,$FF,$FF
	.DB $FF,$98,$9A,$9C,$B6,$38,$FF,$FF
	.DB $FF,$D0,$D2,$D4,$D6,$58,$5A,$FF
	.DB $FF,$F0,$F2,$F4,$F6,$78,$7A,$FF
	.DB $FF,$90,$92,$94,$96,$FF,$FF,$FF
	.DB $FF,$98,$BA,$BC,$B6,$38,$FF,$FF
	.DB $FF,$D8,$DA,$DC,$D6,$58,$5A,$FF
	.DB $FF,$F8,$FA,$FC,$F6,$78,$7A,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$90,$92,$94,$96,$FF,$FF
	.DB $FF,$FF,$98,$BA,$BC,$B6,$38,$FF
	.DB $FF,$FF,$D8,$DA,$DC,$D6,$58,$5A
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$90,$92,$94,$96,$FF,$FF
	.DB $FF,$FF,$98,$BA,$BC,$B6,$38,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$90,$92,$94,$96,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$90,$92,$94,$96,$FF,$FF,$FF
	.DB $FF,$98,$BA,$BC,$B6,$38,$FF,$FF
	.DB $FF,$D8,$DA,$DC,$D6,$58,$5A,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $04,$06,$08,$0A,$0B,$09,$07,$05
	.DB $24,$26,$28,$2A,$2C,$29,$27,$25
	.DB $FF,$84,$86,$88,$89,$87,$85,$FF
	.DB $FF,$A4,$A6,$A8,$A9,$A7,$A5,$FF
	.DB $04,$06,$08,$0A,$0B,$09,$07,$05
	.DB $24,$26,$28,$2D,$2B,$29,$27,$25
	.DB $FF,$84,$86,$88,$89,$87,$85,$FF
	.DB $FF,$A4,$A6,$0C,$0D,$A7,$A5,$FF
	.DB $80,$82,$83,$8A,$82,$83,$8C,$8E
	.DB $A0,$A2,$A3,$C4,$A2,$A3,$AC,$AE
	.DB $80,$8A,$8A,$8A,$8A,$8A,$8C,$8E
	.DB $A0,$60,$61,$C4,$60,$61,$AC,$AE
	.DB $80,$03,$01,$8A,$00,$02,$8C,$8E
	.DB $A0,$23,$21,$C4,$20,$22,$AC,$AE
	.DB $80,$00,$02,$8A,$03,$01,$AA,$8E
	.DB $A0,$20,$22,$C4,$23,$21,$AC,$AE
	.DB $C0,$C2,$C4,$C4,$C4,$CA,$CC,$CE
	.DB $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
	.DB $40,$42,$44,$46,$48,$4A,$4C,$4E
	.DB $FF,$62,$64,$66,$68,$6A,$6C,$FF
	.DB $10,$12,$14,$16,$18,$1A,$1C,$1E
	.DB $10,$30,$32,$34,$36,$1A,$1C,$1E

KoopaPalPtrLo:	.DB <DATA_B2BC,<DATA_B2A4,<DATA_B298,<DATA_B378,<DATA_B36C

KoopaPalPtrHi:	.DB >DATA_B2BC,>DATA_B2A4,>DATA_B298,>DATA_B378,>DATA_B36C

DATA_03DD78:	.DB $0B,$0B,$0B,$21,$00

CODE_03DD7D:
	PHX
	PHB
	PHK
	PLB
	LDY wm_SpriteState,X
	STY wm_M7BossGfxIndex
	CPY #$04
	BNE +
	JSR CODE_03DE8E
	LDA #$48
	STA wm_M7Y
	LDA #$14
	STA wm_M7Scale
	STA wm_M7Scale+1
+	LDA #$FF
	STA wm_ScreensInLvl
	INC A
	STA wm_LastScreenHorz
	LDY wm_M7BossGfxIndex
	LDX.W DATA_03DD78,Y
	LDA KoopaPalPtrLo,Y
	STA m0
	LDA KoopaPalPtrHi,Y
	STA m1
	STZ m2 ; #BANK_0
	LDY #$0B
-	LDA [m0],Y
	STA wm_Palette.3.Col,Y
	DEY
	BPL -
	LDA #$80
	STA VMAINC
	STZ VMADDL
	STZ VMADDH
	TXY
	BEQ +
	JSL CODE_00BA28
	LDA #$80
	STA m3
-	JSR CODE_03DDE5
	DEC m3
	BNE -
+	LDX #$5F
-	LDA #$FF
	STA wm_M7BossTiles,X
	DEX
	BPL -
	PLB
	PLX
	RTL

CODE_03DDE5:
	LDX #$00
	TXY
	LDA #$08
	STA m5
-	JSR CODE_03DE39
	PHY
	TYA
	LSR
	CLC
	ADC #$0F
	TAY
	JSR _03DE3C
	LDY #$08
--	LDA wm_M7VramBuffer,X
	ASL
	ROL
	ROL
	ROL
	AND #$07
	STA wm_M7VramBuffer,X
	STA VMDATAWH
	INX
	DEY
	BNE --
	PLY
	DEC m5
	BNE -
	LDA #$07
-	TAX
	LDY #$08
	STY m5
--	LDY wm_M7VramBuffer,X
	STY VMDATAWH
	DEX
	DEC m5
	BNE --
	CLC
	ADC #$08
	CMP #$40
	BCC -
	REP #$20
	LDA m0
	CLC
	ADC #$0018
	STA m0
	SEP #$20
	RTS

CODE_03DE39:
	JSR _03DE3C ; jsr to next instruction
_03DE3C:
	PHX
	LDA [m0],Y
	PHY
	LDY #$08
-	ASL
	ROR wm_M7VramBuffer,X
	INX
	DEY
	BNE -
	PLY
	INY
	PLX
	RTS

DATA_03DE4E:
	.DB $40,$41,$42,$43,$44,$45,$46,$47
	.DB $50,$51,$52,$53,$54,$55,$56,$57
	.DB $60,$61,$62,$63,$64,$65,$66,$67
	.DB $70,$71,$72,$73,$74,$75,$76,$77
	.DB $48,$49,$4A,$4B,$4C,$4D,$4E,$4F
	.DB $58,$59,$5A,$5B,$5C,$5D,$5E,$5F
	.DB $68,$69,$6A,$6B,$6C,$6D,$6E,$6F
	.DB $78,$79,$7A,$7B,$7C,$7D,$7E,$3F

CODE_03DE8E:
	STZ VMAINC
	REP #$20
	LDA #$0A1C
	STA m0
	LDX #$00
-	REP #$20
	LDA m0
	CLC
	ADC #$0080
	STA m0
	STA VMADDL
	SEP #$20
	LDY #$08
--	LDA.L DATA_03DE4E,X
	STA VMDATAWL
	INX
	DEY
	BNE --
	CPX #$40
	BCC -
	RTS

DATA_03DEBB:	.DB $00,$01,$10,$01

DATA_03DEBF:	.DB $6E,$70,$FF,$50,$FE,$FE,$FF,$57

DATA_03DEC7:	.DB $72,$74,$52,$54,$3C,$3E,$55,$53

DATA_03DECF:	.DB $76,$56,$56,$FF,$FF,$FF,$51,$FF

DATA_03DED7:	.DB $20,$03,$30,$03,$40,$03,$50,$03

CODE_03DEDF:
	PHB
	PHK
	PLB
	LDA wm_SpriteXHi,X
	XBA
	LDA wm_SpriteXLo,X
	LDY #$00
	JSR CODE_03DFAE
	LDA wm_SpriteYHi,X
	XBA
	LDA wm_SpriteYLo,X
	LDY #$02
	JSR CODE_03DFAE
	PHX
	REP #$30
	STZ m6
	LDY #$0003
	LDA wm_LevelMode
	LSR
	BCC ++
	LDA wm_BowserPropellerIndex
	AND #$0003
	ASL
	TAX
	LDA.L DATA_03DEBF,X
	STA wm_M7BossTiles+1
	LDA.L DATA_03DEC7,X
	STA wm_M7BossTiles+3
	LDA.L DATA_03DECF,X
	STA wm_M7BossTiles+5
	LDA #$0008
	STA m6
	LDX #$0380
	LDA wm_M7BossProp
	AND #$007F
	CMP #$002C
	BCC +
	LDX #$0388
+	TXA
	LDX #$000A
	LDY #$0007
	SEC
++	STY m0
	BCS _f
-	LDA wm_M7BossProp
	AND #$007F
	ASL
	ASL
	ASL
	ASL
	LDX #$0003
__	STX m2
	PHA
	LDY wm_MirrorScrnNum
	BPL +
	CLC
	ADC m0
+	TAY
	SEP #$20
	LDX m6
	LDA m0
	STA m4
--	LDA DATA_03D9DE,Y
	INY
	BIT wm_M7BossProp
	BPL +
	EOR #$01
	DEY
	DEY
+	STA wm_M7BossTiles,X
	INX
	DEC m4
	BPL --
	STX m6
	REP #$20
	PLA
	SEC
	ADC m0
	LDX m2
	CPX #$0004
	BEQ -
	CPX #$0008
	BNE +
	LDA #$0360
+	CPX #$000A
	BNE +
	LDA wm_BowserClownImage
	AND #$0003
	ASL
	TAY
	LDA DATA_03DED7,Y
+	DEX
	BPL _b
	SEP #$30
	PLX
	PLB
	RTL

CODE_03DFAE:
	PHX
	TYX
	REP #$20
	EOR #$FFFF
	INC A
	CLC
	ADC.L DATA_03DEBB,X
	CLC
	ADC wm_Bg1HOfs,X
	STA wm_M7Bg1HOfs,X
	SEP #$20
	PLX
	RTS

DATA_03DFC4:	.DB $00,$0E,$1C,$2A,$38,$46,$54,$62

CODE_03DFCC:
	PHX
	LDX wm_PalSprIndex
	LDA #$10
	STA wm_PalUplSize,X
	STZ wm_PalColNum,X
	STZ wm_PalColData,X
	STZ wm_PalColData.1.ColH,X
	TXY
	LDX wm_LightFlashPal
	BNE _03E01B
	LDA wm_BowserFinalScene
	BEQ CODE_03DFF0
	REP #$20
	LDA wm_LvBgColor
	BRA _03E031

CODE_03DFF0:
	LDA wm_FrameB
	LSR
	BCC ++
	DEC wm_LightFlashNext
	BNE ++
	TAX
	LDA.L DATA_04F700+8,X
	AND.B #$07
	TAX
	LDA.L DATA_04F6F8,X
	STA wm_LightFlashNext
	LDA.L DATA_04F700,X
	STA wm_LightFlashPal
	TAX
	LDA.B #$08
	STA wm_LightFlashDur
	LDA.B #$18
	STA wm_SoundCh3
_03E01B:
	DEC wm_LightFlashDur
	BPL +
	DEC wm_LightFlashPal
	LDA.B #$04
	STA wm_LightFlashDur
+	TXA
	ASL
	TAX
	REP #$20
	LDA.L DATA_00B5DE,X
_03E031:
	STA wm_PalColData,Y
	SEP #$20
++	LDX wm_BowserPaletteIndex
	LDA.L DATA_03DFC4,X
	TAX
	LDA #$0E
	STA m0
-	LDA.L PALETTE_Bowser,X
	STA wm_PalColData.2.ColL,Y
	INX
	INY
	DEC m0
	BNE -
	TYX
	STZ wm_PalColData.2.ColL,X
	INX
	INX
	INX
	INX
	STX wm_PalSprIndex
	PLX
	RTL

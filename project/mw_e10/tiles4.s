DATA_0DE300:
	.INCBIN "tilemaps/set_4/073-0FF.bin"
	.INCBIN "tilemaps/set_4/107-110.bin"
	.INCBIN "tilemaps/set_4/153-16D.bin"

CODE_0DE890:
	SEP #$30
	LDX wm_BlockNum
	DEX
	TXA
	JSL ExecutePtrLong

	.DL CODE_0DA8C3 ; Water (Blue)
	.DL CODE_0DA8C3 ; Invisible coin blocks
	.DL CODE_0DA8C3 ; Invisible note blocks
	.DL CODE_0DA8C3 ; Invisible POW coins
	.DL CODE_0DA8C3 ; Coins
	.DL CODE_0DA8C3 ; Walk-through dirt
	.DL CODE_0DA8C3 ; Water (Other color)
	.DL CODE_0DA8C3 ; Note blocks
	.DL CODE_0DA8C3 ; Turn blocks
	.DL CODE_0DA8C3 ; Coin ? blocks
	.DL CODE_0DA8C3 ; Throw blocks
	.DL CODE_0DA8C3 ; Black piranha plants
	.DL CODE_0DA8C3 ; Cement blocks
	.DL CODE_0DA8C3 ; Brown blocks
	.DL CODE_0DAA26 ; Vertical pipes
	.DL CODE_0DAAB4 ; Horizontal pipes
	.DL CODE_0DAB0D ; Bullet shooter
	.DL CODE_0DAB3E ; Slopes
	.DL CODE_0DB075 ; Ledge edges
	.DL CODE_0DB1D4 ; Ground ledge
	.DL CODE_0DB224 ; Midway/Goal point
	.DL ADDR_0DB336 ; Blue coins
	.DL CODE_0DB3BD ; Rope/Clouds
	.DL CODE_0DB3E3 ; Water surface (ani)
	.DL CODE_0DB3E3 ; Water surface (not ani)
	.DL CODE_0DB3E3 ; Lava surface (ani)
	.DL CODE_0DB3E3 ; Net top edge
	.DL CODE_0DB42D ; Donut bridge
	.DL CODE_0DB461 ; Net bottom edge
	.DL CODE_0DB49E ; Net vertical edge
	.DL CODE_0DB51F ; Vert. Pipe/Bone/Log
	.DL CODE_0DB547 ; Horiz. Pipe/Bone/Log
	.DL CODE_0DB1C8 ; Long ground ledge
	.DL CODE_0DB3E3 ;\
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; | Unused (LM will declare these to be "reserved" and won't let you use them)
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ;/
	.DL CODE_0DF06C ; Thin horizontal upward spikes
	.DL CODE_0DF066 ; Log background
	.DL CODE_0DF02B ; Grass ledge 1
	.DL CODE_0DEFA8 ; Wooden crate
	.DL CODE_0DEF67 ; Grass ledge 2
	.DL CODE_0DEF45 ; Cloud ledge (I wonder why it's called "ledge" when you can't stand on it)
	.DL CODE_0DEEC0 ; Wood ledge on column
	.DL CODE_0DECC9 ; Grey bricks background
	.DL CODE_0DECC9 ; Wooden blocks
	.DL CODE_0DED12 ; Horizontal log background and hand rails
	.DL CODE_0DED43 ; Wood ledge without column
	.DL CODE_0DED6B ; Some vertical log backgrounds
	.DL CODE_0DED99 ; Solid vertical brick edges, vertical rows of spikes, and some likely unused things
	.DL CODE_0DEDB9 ; Another ledge (the wood thingies seen in the bonus rooms, like level FD)
	.DL CODE_0DEDDB ; Upside down ledge (switch palace)
	.DL CODE_0DEE17 ; Ledge (switch palace)
	.DL CODE_0DEE52 ; Right facing edge (switch palace)
	.DL CODE_0DEE89 ; Left facing edge (switch palace)

DATA_0DE957:	.DB $73,$74,$75,$76,$93,$94,$95,$96

CODE_0DE95F:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$57
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DE957,X
	STA [wm_Map16BlkPtrL],Y
	RTS

ADDR_0DE971:
	LDA #$03
	STA m0
	LDY #$00
-	JSR BlockIsPage1
	LDA #$77
	STA [wm_Map16BlkPtrL],Y
	INY
	BNE -
	LDA wm_Map16BlkPtrL+1
	CLC
	ADC #$01
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	DEC m0
	BPL -
	RTS

DATA_0DE98F:
	.DB $97,$98,$99
	.DB $9A,$9B,$9C
	.DB $9D,$9E,$9F
	.DB $86,$87,$25
	.DB $25,$86,$87
	.DB $25,$25,$86
	.DB $25,$84,$85
	.DB $84,$85,$25
	.DB $85,$25,$25

CODE_0DE9AA:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$61
	STA m0
	ASL
	ASL
	ASL
	CLC
	ADC m0
	TAX
	LDA #$02
	STA m0
	STA m1
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA.L DATA_0DE98F,X
	JSR CODE_0DA95B
	INX
	DEC m0
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA #$02
	STA m0
	DEC m1
	BPL -
	RTS

DATA_0DE9E1:
	.DB $8C,$8D
	.DB $25,$8E
	.DB $90,$91
	.DB $8F,$25
	.DB $FC,$FD
	.DB $FE,$FF

CODE_0DE9ED:
	LDA wm_BlockSizeType
	SEC
	SBC #$64
	ASL
	ASL
	TAX
_0DE9F5:
	LDY wm_BlockSubScrPos
	LDA #$01
	STA m0
	STA m1
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA.L DATA_0DE9E1,X
	JSR CODE_0DA95B
	INX
	DEC m0
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA #$01
	STA m0
	DEC m1
	BPL -
	RTS

DATA_0DEA1E:
	.DB $25,$25,$7A,$7B
	.DB $25,$7C,$7D,$25
	.DB $7C,$7D,$25,$25
	.DB $7D,$25,$25,$25
	.DB $7E,$7F,$25,$25
	.DB $25,$80,$81,$25
	.DB $25,$25,$80,$81
	.DB $25,$25,$25,$80

ADDR_0DEA3E:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$66
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA #$03
	STA m0
	STA m1
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA.L DATA_0DEA1E,X
	JSR CODE_0DA95B
	INX
	DEC m0
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA #$03
	STA m0
	DEC m1
	BPL -
	RTS

DATA_0DEA71:
	.DB $A5,$A5,$A4,$A5,$A5,$A4
	.DB $A7,$A8,$A4,$A7,$A8,$A4
	.DB $AC,$AD,$A4,$AC,$AD,$A4
	.DB $AE,$AF,$A4,$AE,$AF,$A4
	.DB $B0,$B1,$A4,$B0,$B1,$A4
	.DB $A7,$A8,$A4,$A7,$A8,$A4
	.DB $A5,$A5,$A5,$A5,$A5,$A4
	.DB $B4,$B4,$B4,$B4,$B4,$A4
	.DB $AC,$B2,$AD,$B4,$B4,$A4
	.DB $B0,$B3,$B1,$B4,$B4,$A4
	.DB $C1,$C2,$C6,$B4,$B4,$A4
	.DB $C1,$C2,$C6,$A5,$A5,$A4
	.DB $C1,$C2,$C6,$A7,$A8,$A4

CODE_0DEABF:
	LDY wm_BlockSubScrPos
	LDX #$00
-	LDA #$05
	STA m0
--	JSR BlockIsPage1
	LDA.L DATA_0DEA71,X
	JSR CODE_0DA95B
	INX
	DEC m0
	BPL --
	JSR CODE_0DA97D
	CPX #$4E
	BNE -
	RTS

DATA_0DEADE:
	.DB $A4,$A6,$A9,$A9,$A9,$A9,$A9,$A9,$A9,$A9
	.DB $A4,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5
	.DB $A4,$C0,$A8,$A8,$A8,$A8,$AB,$AB,$A8,$A8
	.DB $A4,$A6,$AC,$AD,$C0,$AC,$AD,$A6,$AC,$AD
	.DB $A4,$A6,$AE,$AF,$A6,$AE,$AF,$BF,$AE,$AF
	.DB $A4,$BF,$B0,$B1,$AB,$B0,$B1,$A6,$B0,$B1
	.DB $A4,$A6,$AB,$A8,$A9,$A8,$AB,$A9,$A8,$A8
	.DB $A4,$A5,$A5,$A5,$B5,$B6,$B7,$B8,$B9,$A5
	.DB $A4,$A7,$A8,$AB,$BA,$BB,$BC,$BD,$BE,$A8
	.DB $A4,$C0,$AC,$AD,$A6,$AC,$B2,$AD,$BF,$AC
	.DB $A4,$A7,$AE,$AF,$C0,$AE,$B3,$AF,$AB,$AE
	.DB $A4,$BF,$B0,$B1,$A6,$C1,$C2,$C3,$A6,$B0
	.DB $A4,$A5,$A5,$A5,$A5,$C1,$C2,$C3,$C4,$C4
	.DB $A4,$B4,$B4,$B4,$B4,$C1,$C2,$C3,$C5,$C5

CODE_0DEB6A:
	LDY wm_BlockSubScrPos
	LDX #$00
-	LDA #$09
	STA m0
--	JSR BlockIsPage1
	LDA.L DATA_0DEADE,X
	JSR CODE_0DA95B
	INX
	DEC m0
	BNE --
	JSR BlockIsPage1
	LDA.L DATA_0DEADE,X
	STA [wm_Map16BlkPtrL],Y
	INX
	JSR CODE_0DA97D
	CPX #$8C
	BNE -
	RTS

DATA_0DEB93:
	.DB $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$CB,$CC,$25,$25,$25
	.DB $25,$CD,$CE,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF,$D0,$D1,$25
	.DB $25,$D2,$EB,$D3,$D3,$D3,$EB,$D3,$D3,$D3,$D3,$EB,$D3,$D3,$D4,$25
	.DB $25,$D5,$D3,$EB,$D3,$D3,$D3,$D3,$D3,$EB,$D3,$D3,$D3,$EB,$D6,$25
	.DB $25,$D5,$D3,$D3,$D3,$D3,$D3,$EB,$D3,$D3,$D3,$D3,$D3,$D3,$D6,$25
	.DB $25,$D7,$D8,$D9,$D8,$D8,$D9,$D8,$D8,$D9,$D8,$DA,$DB,$D8,$DC,$25
	.DB $25,$25,$25,$DD,$25,$25,$DD,$25,$25,$DD,$25,$CB,$CC,$25,$25,$25
	.DB $25,$25,$DE,$DD,$25,$25,$DD,$25,$25,$DD,$25,$CB,$CC,$25,$25,$25
	.DB $25,$DF,$E0,$E1,$25,$25,$DD,$25,$25,$DD,$25,$E2,$E3,$E4,$25,$25
	.DB $E5,$E5,$E6,$DD,$E5,$E5,$DD,$E5,$E5,$DD,$E5,$E7,$E8,$E9,$E5,$E5

CODE_0DEC33:
	LDY wm_BlockSubScrPos
	LDX #$00
-	LDA #$0F
	STA m0
--	JSR BlockIsPage1
	LDA.L DATA_0DEB93,X
	JSR CODE_0DA95B
	INX
	DEC m0
	BNE --
	JSR BlockIsPage1
	LDA.L DATA_0DEB93,X
	STA [wm_Map16BlkPtrL],Y
	INX
	JSR CODE_0DA97D
	CPX #$A0
	BNE -
	RTS

CODE_0DEC5C:
	LDY wm_BlockSubScrPos
	JSR BlockIsPage2
	LDA #$10
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DEC66:
	.DB $C9
	.DB $CA

ADDR_0DEC68:
	LDY wm_BlockSubScrPos
	LDX #$00
-	JSR BlockIsPage1
	LDA.L DATA_0DEC66,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	INX
	CPX #$02
	BNE -
	RTS

DATA_0DEC7E:
	.DB $EC,$ED
	.DB $EE,$EF
	.DB $F0,$F1
	.DB $F2,$F3
	.DB $F4,$F5
	.DB $F6,$F7
	.DB $F8,$F9
	.DB $FA,$FB

CODE_0DEC8E:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$8A
	TAX
	LDA.L wm_MapData.SwitchBlkFlags,X
	BNE +
	TXA
	ASL
	ASL
	TAX
	LDA #$01
	STA m0
	STA m1
-	LDA m0
	STA m2
--	JSR BlockIsPage1
	LDA.L DATA_0DEC7E,X
	JSR CODE_0DA95B
	INX
	DEC m2
	BPL --
	JSR CODE_0DA97D
	DEC m1
	BPL -
+	RTS

CODE_0DECC1:
	LDX #$08
	JMP _0DE9F5

DATA_0DECC6:	.DB $92,$5E,$82

CODE_0DECC9:
	TXA
	SEC
	SBC #$34
	TAX
_0DECCE:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	STA m2
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	CPX #$01
	BNE +
	JSR BlockIsPage2
+	LDA.L DATA_0DECC6,X
	JSR CODE_0DA95B
	DEC m2
	LDA m2
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA m0
	STA m2
	DEC m1
	BPL -
	RTS

DATA_0DED09:	.DB $82,$89,$88

DATA_0DED0C:	.DB $82,$8A,$88

DATA_0DED0F:	.DB $82,$8B,$88

CODE_0DED12:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DED09,X
	JMP _0DED32

CODE_0DED2B:
	JSR BlockIsPage1
	LDA.L DATA_0DED0C,X
_0DED32:
	JSR CODE_0DA95B
	DEC m0
	BNE CODE_0DED2B
	JSR BlockIsPage1
	LDA.L DATA_0DED0F,X
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DED43:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
_0DED4A:
	JSR BlockIsPage2
	LDA #$0A
	JMP _0DED57

CODE_0DED52:
	JSR BlockIsPage2
	LDA #$0B
_0DED57:
	JSR CODE_0DA95B
	DEX
	BNE CODE_0DED52
	JSR BlockIsPage2
	LDA #$0C
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DED65:	.DB $83,$78,$79

DATA_0DED68:	.DB $83,$79,$79

CODE_0DED6B:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DED65,X
	JMP _0DED8B

CODE_0DED84:
	JSR BlockIsPage1
	LDA.L DATA_0DED68,X
_0DED8B:
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL CODE_0DED84
	RTS

DATA_0DED95:	.DB $5F,$60,$5A,$5B

CODE_0DED99:
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
-	JSR BlockIsPage2
	LDA.L DATA_0DED95,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL -
	RTS

CODE_0DEDB9:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	JSR BlockIsPage2
	LDA #$07
	JMP _0DEDCD

CODE_0DEDC8:
	JSR BlockIsPage2
	LDA #$08
_0DEDCD:
	JSR CODE_0DA95B
	DEX
	BNE CODE_0DEDC8
	JSR BlockIsPage2
	LDA #$09
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DEDDB:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
	LDX m0
	LDA m1
	BEQ _f
-	JSR BlockIsPage2
	LDA #$53
	JSR CODE_0DA95B
	DEX
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m1
	BNE -
__	JSR BlockIsPage2
	LDA #$54
	JSR CODE_0DA95B
	DEX
	BPL _b
	RTS

CODE_0DEE17:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
	LDX m0
-	JSR BlockIsPage2
	LDA #$5D
	JSR CODE_0DA95B
	DEX
	BPL -
	JMP _0DEE45

CODE_0DEE3A:
	JSR BlockIsPage2
	LDA #$53
	JSR CODE_0DA95B
	DEX
	BPL CODE_0DEE3A
_0DEE45:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m1
	BPL CODE_0DEE3A
	RTS

CODE_0DEE52:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
-	LDX m0
	BEQ +
--	JSR BlockIsPage2
	LDA #$53
	JSR CODE_0DA95B
	DEX
	BNE --
+	JSR BlockIsPage2
	LDA #$55
	JSR CODE_0DA95B
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m1
	BPL -
	RTS

CODE_0DEE89:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
-	JSR BlockIsPage2
	LDA #$5C
	JSR CODE_0DA95B
	LDX m0
	BEQ +
--	JSR BlockIsPage2
	LDA #$53
	JSR CODE_0DA95B
	DEX
	BPL --
+	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m1
	BPL -
	RTS

CODE_0DEEC0:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	ASL
	ASL
	CLC
	ADC #$02
	TAX
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
	JSR _0DED4A
	JSR CODE_0DA6BA
	LDA wm_BlockSubScrPos
	CLC
	ADC #$01
	TAY
	AND #$0F
	BNE +
	LDA wm_BlockSubScrPos
	AND #$F0
	TAY
	JSR CODE_0DA9EF
+	TYA
	CLC
	ADC #$10
	STA wm_BlockSubScrPos
	TAY
	BCC _0DEEFD
	JSR _0DA987
_0DEEFD:
	JSR CODE_0DA6BA
	LDX m1
	JSR BlockIsPage1
	LDA #$78
	JMP _0DEF0F

CODE_0DEF0A:
	JSR BlockIsPage1
	LDA #$79
_0DEF0F:
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	LDA wm_Map16BlkPtrL+1
	CLC
	ADC #$01
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
+	DEX
	BNE CODE_0DEF0A
	JSR CODE_0DA6BA
	LDA wm_BlockSubScrPos
	CLC
	ADC #$04
	TAY
	AND #$0F
	CMP #$04
	BPL +
	TYA
	SEC
	SBC #$10
	TAY
	JSR CODE_0DA9EF
+	STY wm_BlockSubScrPos
	DEC m0
	BMI Return0DEF44
	JMP _0DEEFD

Return0DEF44:
	RTS

CODE_0DEF45:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	JSR BlockIsPage1
	LDA #$A0
	JMP _0DEF59

CODE_0DEF54:
	JSR BlockIsPage1
	LDA #$A1
_0DEF59:
	JSR CODE_0DA95B
	DEX
	BNE CODE_0DEF54
	JSR BlockIsPage1
	LDA #$A2
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DEF67:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	LDX m0
	JSR CODE_0DA6B1
-	JSR BlockIsPage2
	LDA #$0E
	JSR CODE_0DA95B
	DEX
	BPL -
_0DEF87:
	DEC m1
	BMI Return0DEFA1
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
-	JSR BlockIsPage1
	LDA #$A3
	JSR CODE_0DA95B
	DEX
	BPL -
	JMP _0DEF87

Return0DEFA1:
	RTS

DATA_0DEFA2:	.DB $63,$65

DATA_0DEFA4:	.DB $C7,$C8

DATA_0DEFA6:	.DB $64,$6A

CODE_0DEFA8:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
	LDA m0
	STA m2
	JSR BlockIsPage2
	LDA #$61
	BNE +
-	JSR BlockIsPage2
	LDA #$0D
+	JSR CODE_0DA95B
	DEC m2
	BNE -
	JSR BlockIsPage2
	LDA #$62
	STA [wm_Map16BlkPtrL],Y
	LDX #$01
	JMP _0DEFFE

CODE_0DEFDE:
	JSR BlockIsPage2
	LDA.L DATA_0DEFA2,X
	BNE +
-	JSR BlockIsPage1
	LDA.L DATA_0DEFA4,X
+	JSR CODE_0DA95B
	DEC m2
	BNE -
	JSR BlockIsPage2
	LDA.L DATA_0DEFA6,X
	STA [wm_Map16BlkPtrL],Y
_0DEFFE:
	JSR CODE_0DA6BA
	LDA m0
	STA m2
	TXA
	EOR #$01
	TAX
	JSR CODE_0DA97D
	DEC m1
	BNE CODE_0DEFDE
	JSR BlockIsPage2
	LDA #$6B
	BNE +
-	JSR BlockIsPage2
	LDA #$6C
+	JSR CODE_0DA95B
	DEC m0
	BNE -
	JSR BlockIsPage2
	LDA #$6D
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DF02B:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
	LDX m0
-	JSR BlockIsPage2
	LDA #$0F
	JSR CODE_0DA95B
	DEX
	BPL -
	JMP _0DF05B

CODE_0DF04E:
	LDX m0
-	JSR BlockIsPage1
	LDA #$EA
	JSR CODE_0DA95B
	DEX
	BPL -
_0DF05B:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m1
	BPL CODE_0DF04E
	RTS

CODE_0DF066:
	LDX #$02
	JMP _0DECCE

DATA_0DF06B:	.DB $59

CODE_0DF06C:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
-	JSR BlockIsPage2
	LDA.L DATA_0DF06B,X
	JSR CODE_0DA95B
	DEC m0
	BPL -
	RTS

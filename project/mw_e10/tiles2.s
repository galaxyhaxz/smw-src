DATA_0DC800:
	.INCBIN "tilemaps/set_2/073-0FF.bin"
	.INCBIN "tilemaps/set_2/107-110.bin"
	.INCBIN "tilemaps/set_2/153-16D.bin"

CODE_0DCD90:
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
	.DL CODE_0DB3E3 ;\
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; | These could've been tileset specific, but Nintendo didn't have that many ideas for them.
	.DL CODE_0DB3E3 ;/
	.DL CODE_0DD24E ; Log bridge
	.DL CODE_0DB916 ; Blue switch blocks
	.DL CODE_0DB91E ; Red switch blocks
	.DL CODE_0DD1D9 ; Plants on columns
	.DL ADDR_0DCEF2 ; Horizontal conveyors
	.DL CODE_0DC341 ; Diagonal conveyors
	.DL CODE_0DCF12 ; Horizontal guide lines
	.DL CODE_0DCF33 ; Vertical guide lines / vertical column
	.DL CODE_0DCF53 ; Normal/steep/ON/OFF guide lines
	.DL ADDR_0DD070 ; Very steep guide lines
	.DL CODE_0DD103 ; Mushroom ledge
	.DL CODE_0DD145 ; Mushroom column
	.DL ADDR_0DD182 ; Horizontal log
	.DL ADDR_0DD1A5 ; Vertical log

DATA_0DCE57:
	.DB $7A,$7B
	.DB $7C,$25
	.DB $7E,$7F
	.DB $25,$7D
	.DB $82,$25
	.DB $80,$81
	.DB $25,$83
	.DB $84,$85

CODE_0DCE67:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$4D
	ASL
	ASL
	TAX
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA.L DATA_0DCE57,X
	JSR CODE_0DA95B
	INX
	TXA
	AND #$01
	BNE -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	TXA
	AND #$03
	BNE -
	RTS

DATA_0DCE90:	.DB $76,$77,$78,$79

CODE_0DCE94:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$51
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DCE90,X
	STA [wm_Map16BlkPtrL],Y
	RTS

ADDR_0DCEA6:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$51
	TAX
	JSR BlockIsPage1
	LDA #$84
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$85
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DCEBE:
	.DB $96
	.DB $97

CODE_0DCEC0:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LDX #$00
-	JSR BlockIsPage1
	LDA.L DATA_0DCEBE,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	INX
	CPX #$02
	BNE -
	RTS

DATA_0DCED8:	.DB $98,$99

CODE_0DCEDA:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LDX #$00
-	JSR BlockIsPage1
	LDA.L DATA_0DCED8,X
	JSR CODE_0DA95B
	INX
	CPX #$02
	BNE -
	RTS

DATA_0DCEF0:	.DB $0C,$0D

ADDR_0DCEF2:
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
	LDA.L DATA_0DCEF0,X
	JSR CODE_0DA95B
	DEC m0
	BPL -
	RTS

DATA_0DCF10:	.DB $92,$93

CODE_0DCF12:
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
-	JSR BlockIsPage1
	LDA.L DATA_0DCF10,X
	JSR CODE_0DA95B
	DEC m0
	BPL -
	RTS

DATA_0DCF30:	.DB $90,$91,$A2

CODE_0DCF33:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
-	JSR BlockIsPage1
	LDA.L DATA_0DCF30,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL -
	RTS

CODE_0DCF53:
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	JSL ExecutePtrLong

PtrsLong0DCF5C:
	.DL CODE_0DCF6E
	.DL CODE_0DCFB1
	.DL ADDR_0DCFF0
	.DL CODE_0DD034
	.DL CODE_0DCFB1
	.DL CODE_0DD034

CODE_0DCF6E:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA #$8C
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$8D
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA6BA
	LDA wm_BlockSubScrPos
	CLC
	ADC #$0E
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$0E
	BMI ++
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	JSR CODE_0DA9D6
++	STY wm_BlockSubScrPos
	DEX
	BPL -
	RTS

CODE_0DCFB1:
	LDA #$86
	CPX #$04
	BNE +
	LDA #$94
+	STA m0
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
-	JSR BlockIsPage1
	LDA m0
	STA [wm_Map16BlkPtrL],Y
	LDA wm_BlockSubScrPos
	CLC
	ADC #$0F
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$0F
	BMI ++
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	JSR CODE_0DA9D6
++	STY wm_BlockSubScrPos
	DEX
	BPL -
	RTS

ADDR_0DCFF0:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA #$8E
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$8F
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA6BA
	LDA wm_BlockSubScrPos
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	TYA
	CLC
	ADC #$02
	TAY
	AND #$0F
	CMP #$02
	BPL +
	TYA
	SEC
	SBC #$10
	AND #$F1
	TAY
	JSR CODE_0DA9EF
+	STY wm_BlockSubScrPos
	DEX
	BPL -
	RTS

CODE_0DD034:
	LDA #$87
	CPX #$05
	BNE +
	LDA #$95
+	STA m0
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
-	JSR BlockIsPage1
	LDA m0
	STA [wm_Map16BlkPtrL],Y
	LDA wm_BlockSubScrPos
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	TYA
	CLC
	ADC #$01
	TAY
	AND #$0F
	BNE +
	DEY
	TYA
	AND #$F0
	TAY
	JSR CODE_0DA9EF
+	STY wm_BlockSubScrPos
	DEX
	BPL -
	RTS

ADDR_0DD070:
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	JSL ExecutePtrLong

PtrsLong0DD07A:
	.DL ADDR_0DD080
	.DL ADDR_0DD0C3

ADDR_0DD080:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
-	JSR BlockIsPage1
	LDA #$88
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	JSR BlockIsPage1
	LDA #$8A
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$0F
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$0F
	BNE ++
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	JSR CODE_0DA9D6
++	STY wm_BlockSubScrPos
	DEX
	BPL -
	RTS

ADDR_0DD0C3:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
-	JSR BlockIsPage1
	LDA #$89
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	JSR BlockIsPage1
	LDA #$8B
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	TYA
	CLC
	ADC #$01
	TAY
	AND #$0F
	BNE +
	DEY
	TYA
	AND #$F0
	TAY
	JSR CODE_0DA9EF
+	STY wm_BlockSubScrPos
	DEX
	BPL -
	RTS

CODE_0DD103:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	JSR BlockIsPage2
	LDX #$07
	LDA [wm_Map16BlkPtrL],Y
	CMP #$73
	BMI +
	CMP #$76
	BPL +
	LDX #$0A
+	TXA
	JSR CODE_0DA95B
	JMP _0DD12B

CODE_0DD123:
	JSR BlockIsPage2
	LDA #$08
	JSR CODE_0DA95B
_0DD12B:
	DEC m0
	BNE CODE_0DD123
	JSR BlockIsPage2
	LDX #$09
	LDA [wm_Map16BlkPtrL],Y
	CMP #$73
	BMI +
	CMP #$76
	BPL +
	LDX #$0B
+	TXA
	JSR CODE_0DA95B
	RTS

CODE_0DD145:
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
_0DD158:
	LDX m0
	JSR BlockIsPage1
	LDA #$73
	JMP _0DD167

CODE_0DD162:
	JSR BlockIsPage1
	LDA #$74
_0DD167:
	JSR CODE_0DA95B
	DEX
	BNE CODE_0DD162
	JSR BlockIsPage1
	LDA #$75
	JSR CODE_0DA95B
	JSR CODE_0DA6BA
	LDX m0
	JSR CODE_0DA97D
	DEC m1
	BPL _0DD158
	RTS

ADDR_0DD182:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	JSR BlockIsPage2
	LDA #$59
	JMP _0DD196

ADDR_0DD191:
	JSR BlockIsPage2
	LDA #$5A
_0DD196:
	JSR CODE_0DA95B
	DEX
	BNE ADDR_0DD191
	JSR BlockIsPage2
	LDA #$5B
	JSR CODE_0DA95B
	RTS

ADDR_0DD1A5:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR BlockIsPage2
	LDA #$5C
	JMP _0DD1BB

ADDR_0DD1B6:
	JSR BlockIsPage2
	LDA #$5D
_0DD1BB:
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEX
	BNE ADDR_0DD1B6
	JSR BlockIsPage2
	LDA #$5E
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DD1CB:	.DB $9A,$9C,$9E,$A0

DATA_0DD1CF:	.DB $9B,$9D,$9F,$A1

DATA_0DD1D3:	.DB $61,$62,$63,$64,$65,$66

CODE_0DD1D9:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	JSR CODE_0DA6B1
	JSR BlockIsPage1
	LDA.L DATA_0DD1CB,X
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA.L DATA_0DD1CF,X
	STA [wm_Map16BlkPtrL],Y
	DEC m0
	BPL CODE_0DD205
	JMP _Return0DD24B

CODE_0DD205:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	JSR BlockIsPage2
	LDA #$5F
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$60
	STA [wm_Map16BlkPtrL],Y
	DEC m0
	BMI _Return0DD24B
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX #$00
-	JSR BlockIsPage2
	LDA.L DATA_0DD1D3,X
	JSR CODE_0DA95B
	INX
	JSR BlockIsPage2
	LDA.L DATA_0DD1D3,X
	STA [wm_Map16BlkPtrL],Y
	INX
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	CPX #$06
	BNE +
	LDX #$00
+	DEC m0
	BPL -
_Return0DD24B:
	RTS

DATA_0DD24C:	.DB $A3,$0E

CODE_0DD24E:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	STA m1
	JSR CODE_0DA6B1
	LDX #$00
-	JSR BlockIsPage1
	CPX #$00
	BEQ +
	JSR BlockIsPage2
+	LDA.L DATA_0DD24C,X
	JSR CODE_0DA95B
	DEC m1
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA m0
	STA m1
	INX
	CPX #$02
	BNE -
	RTS

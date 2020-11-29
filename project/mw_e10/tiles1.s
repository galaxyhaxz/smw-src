DATA_0DBC00:
	.INCBIN "tilemaps/set_1/073-0FF.bin"
	.INCBIN "tilemaps/set_1/107-110.bin"
	.INCBIN "tilemaps/set_1/153-16D.bin"

CODE_0DC190:
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
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ; | These could've been tileset specific, but Nintendo didn't have that many ideas for them.
	.DL CODE_0DB3E3 ; |
	.DL CODE_0DB3E3 ;/
	.DL CODE_0DC5D8 ; Those weird double ended pipes that Mario can walk through the middles of
	.DL CODE_0DC58A ; Rock wall background
	.DL CODE_0DC4EF ; Large spikes
	.DL CODE_0DCF12 ; Horizontal line guide lines
	.DL CODE_0DCF33 ; Vertical line guide lines
	.DL CODE_0DB916 ; Blue switch blocks
	.DL CODE_0DB91E ; Red switch blocks
	.DL CODE_0DC4C9 ; Ledge
	.DL CODE_0DC478 ; Stone block wall
	.DL CODE_0DC341 ; Conveyors
	.DL CODE_0DC42E ; Horizontal rows of spikes
	.DL CODE_0DC44F ; Vertical rows of spikes / vertical columns

DATA_0DC257:	.DB $07,$08

CODE_0DC259:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$4B
	TAX
	JSR BlockIsPage2
	LDA.L DATA_0DC257,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DC26B:
	.DB $73,$74,$75,$73,$74,$74,$7B,$79,$7A
	.DB $79,$7A,$7B,$79,$7A,$7B,$73,$74,$75
	.DB $73,$74,$74,$74,$75,$73,$77,$77,$78
	.DB $76,$77,$77,$7A,$7B,$79,$7A,$7A,$7B
	.DB $79,$7A,$7B,$73,$74,$74,$75,$73,$74
	.DB $73,$75,$73,$77,$7A,$7A,$7B,$79,$7A
	.DB $79,$7B,$79,$7B,$7C,$7D,$7D,$7D,$7D
	.DB $25,$73,$74,$75,$7E,$7F,$7F,$7F,$7F
	.DB $25,$76,$77,$78,$80,$81,$81,$81,$81
	.DB $25,$76,$77,$78,$82,$82,$82,$82,$7C
	.DB $25,$79,$7A,$7B,$83,$84,$84,$85,$80
	.DB $25,$73,$74,$75,$83,$84,$84,$85,$7C
	.DB $25,$76,$77,$78,$83,$84,$84,$85,$7E
	.DB $25,$79,$7A,$7B,$83,$84,$84,$85,$80

CODE_0DC2E9:
	LDY wm_BlockSubScrPos
	LDX #$00
-	LDA #$08
	STA m0
--	JSR BlockIsPage1
	LDA.L DATA_0DC26B,X
	CMP #$25
	BEQ +
	STA [wm_Map16BlkPtrL],Y
+	JSR _0DA95D
	INX
	DEC m0
	BNE --
	JSR BlockIsPage1
	LDA.L DATA_0DC26B,X
	STA [wm_Map16BlkPtrL],Y
	INX
	JSR CODE_0DA97D
	CPX #$7E
	BNE -
	RTS

DATA_0DC318:
	.DB $98,$99
	.DB $9A,$9B
	.DB $9C,$9C

CODE_0DC31E:
	LDY wm_BlockSubScrPos
	LDX #$00
	LDA #$01
	STA m0
-	LDA m0
	STA m1
--	JSR BlockIsPage1
	LDA.L DATA_0DC318,X
	JSR CODE_0DA95B
	INX
	DEC m1
	BPL --
	JSR CODE_0DA97D
	CPX #$06
	BNE -
	RTS

CODE_0DC341:
	LDA wm_BlockSizeType
	AND #$02
	LSR
	JSL ExecutePtrLong

PtrsLong0DC34A:
	.DL CODE_0DC358
	.DL CODE_0DC3D8

DATA_0DC350:	.DB $CE,$D1,$CF,$D0

DATA_0DC354:	.DB $F3,$F6,$F4,$F5

CODE_0DC358:
	LDY wm_BlockSubScrPos
	LDA #$00
	STA m2
	LDA wm_BlockSizeType
	AND #$03
	TAX
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
_0DC370:
	LDA m2
	STA m3
	JSR BlockIsPage2
	LDA.L DATA_0DC350,X
	JSR CODE_0DA95B
_0DC37E:
	DEC m3
	BMI _0DC39B
	JSR BlockIsPage2
	LDA.L DATA_0DC354,X
	JSR CODE_0DA95B
	JMP _0DC397

CODE_0DC38F:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DC397:
	DEC m3
	BPL CODE_0DC38F
_0DC39B:
	JSR CODE_0DA6BA
	INC m2
	DEC m0
	BEQ CODE_0DC3CD
	BPL CODE_0DC3A9
	JMP Return0DC3D7

CODE_0DC3A9:
	LDA wm_BlockSubScrPos
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
	JMP _0DC370

CODE_0DC3CD:
	LDA m2
	STA m3
	JSR CODE_0DA97D
	JMP _0DC37E

Return0DC3D7:
	RTS

CODE_0DC3D8:
	LDY wm_BlockSubScrPos
	LDA #$00
	STA m2
	LDA wm_BlockSizeType
	AND #$03
	TAX
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
	JMP _0DC40D

CODE_0DC3F3:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
	DEC m3
-	LDA m3
	CMP #$01
	BNE CODE_0DC3F3
	JSR BlockIsPage2
	LDA.L DATA_0DC354,X
	JSR CODE_0DA95B
_0DC40D:
	LDA m0
	BEQ +
	JSR BlockIsPage2
	LDA.L DATA_0DC350,X
	JSR CODE_0DA95B
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	INC m2
	LDA m2
	STA m3
	DEC m0
	BPL -
+	RTS

DATA_0DC42C:	.DB $5A,$59

CODE_0DC42E:
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
	LDA.L DATA_0DC42C,X
	JSR CODE_0DA95B
	DEC m0
	BPL -
	RTS

DATA_0DC44C:	.DB $5B,$5C,$53

CODE_0DC44F:
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
-	JSR BlockIsPage2
	LDA.L DATA_0DC44C,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL -
	RTS

DATA_0DC46F:	.DB $5D,$60,$63

DATA_0DC472:	.DB $5E,$61,$64

DATA_0DC475:	.DB $5F,$62,$65

CODE_0DC478:
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
	LDX #$00
_0DC48D:
	LDA m0
	STA m2
	JSR BlockIsPage2
	LDA.L DATA_0DC46F,X
	JSR CODE_0DA95B
	JMP _0DC4A8

CODE_0DC49E:
	JSR BlockIsPage2
	LDA.L DATA_0DC472,X
	JSR CODE_0DA95B
_0DC4A8:
	DEC m2
	BNE CODE_0DC49E
	JSR BlockIsPage2
	LDA.L DATA_0DC475,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX #$01
	DEC m1
	BMI Return0DC4C8
	BNE +
	LDX #$02
+	JMP _0DC48D

Return0DC4C8:
	RTS

CODE_0DC4C9:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDX m0
-	JSR BlockIsPage2
	LDA #$09
	JSR CODE_0DA95B
	DEX
	BPL -
	JSR CODE_0DA97D
	LDX m0
-	JSR BlockIsPage1
	LDA #$86
	JSR CODE_0DA95B
	DEX
	BPL -
	RTS

CODE_0DC4EF:
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
	CPX #$00
	BEQ _f
	JSR _0DA95D
	JSR BlockIsPage1
	LDA #$87
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$88
	JSR CODE_0DA95B
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
__	JSR BlockIsPage1
	LDA #$89
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$66
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$67
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$8A
	JSR CODE_0DA95B
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m0
	BMI +
	JSR BlockIsPage1
	LDA #$8B
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$68
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$69
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$8C
	JSR CODE_0DA95B
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m0
	BPL _b
+	CPX #$00
	BNE +
	JSR _0DA95D
	JSR BlockIsPage1
	LDA #$8D
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$8E
	JSR CODE_0DA95B
+	RTS

CODE_0DC58A:
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
--	JSR BlockIsPage1
	LDA #$94
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$95
	JSR CODE_0DA95B
	DEX
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
---	JSR BlockIsPage1
	LDA #$96
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$97
	JSR CODE_0DA95B
	DEX
	BPL ---
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m1
	BPL -
	RTS

CODE_0DC5D8:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	JSR CODE_0DA6B1
	JSR BlockIsPage2
	LDA #$33
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$34
	STA [wm_Map16BlkPtrL],Y
	JMP _0DC606

CODE_0DC5F7:
	JSR BlockIsPage1
	LDA #$9D
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$9E
	STA [wm_Map16BlkPtrL],Y
_0DC606:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m0
	BNE CODE_0DC5F7
	JSR BlockIsPage2
	LDA #$33
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$34
	STA [wm_Map16BlkPtrL],Y
	RTS

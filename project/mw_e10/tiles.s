Map16TilesBank:

.INCDIR "tilemaps"

DATA_0D8000:
	.INCBIN "000-072.bin"
	.INCBIN "100-106.bin"
Blocks111_152:
	.INCBIN "111-152.bin"
	.INCBIN "16E-1C3.bin"
	.INCBIN "1C4-1C7.bin"
	.INCBIN "1C8-1EB.bin"
	.INCBIN "1EC-1EF.bin"
	.INCBIN "1F0-1FF.bin"

DATA_0D8A70:
	.INCBIN "1C4-1C7_2.bin"
	.INCBIN "1EC-1EF_2.bin"

DATA_0D8AB0:
	.INCBIN "pipes/1.bin"

DATA_0D8AF0:
	.INCBIN "pipes/2.bin"

DATA_0D8B30:
	.INCBIN "pipes/3.bin"

DATA_0D8B70:
	.INCBIN "set_0/073-0FF.bin"
	.INCBIN "set_0/107-110.bin"
	.INCBIN "set_0/153-16D.bin"

DATA_0D9100:
	.INCBIN "background.bin"

.INCDIR ""

CODE_0DA100:
	SEP #$30
	JSR CODE_0DA106
	RTL

CODE_0DA106:
	SEP #$30
	LDA wm_BlockSizeType
	TAX
	JSL ExecutePtrLong

	.DL CODE_0DA512 ; Screen exit
	.DL CODE_0DA53D ; Screen jump
	.DL $000000     ;\
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; | Unused (LM will declare these to be fatal errors and change them to doors)
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ; |
	.DL $000000     ;/
	.DL CODE_0DA57B ; Small door
	.DL CODE_0DA57B ; Invisible ? block (1-UP)
	.DL CODE_0DA57B ; Invisible note block
	.DL CODE_0DA57B ; Top left corner edge tile 1
	.DL CODE_0DA57B ; Top right corner edge tile 1
	.DL CODE_0DA57B ; Small POW door
	.DL CODE_0DA57B ; Invisible POW ? block
	.DL CODE_0DA64D ; Green star block
	.DL CODE_0DA57B ; 3-UP moon
	.DL CODE_0DA57B ; Invisible 1-UP #1
	.DL CODE_0DA57B ; Invisible 1-UP #2
	.DL CODE_0DA57B ; Invisible 1-UP #3
	.DL CODE_0DA57B ; Invisible 1-UP #4
	.DL CODE_0DA57B ; Red berry
	.DL CODE_0DA57B ; Pink berry
	.DL CODE_0DA57B ; Green berry
	.DL CODE_0DA57B ; Always turning block
	.DL CODE_0DA57B ; Bottom right of midway point (unused)
	.DL CODE_0DA57B ; Bottom right of midway point (unused)
	.DL CODE_0DA57B ; Note block (flower/feather/star)
	.DL CODE_0DA57B ; ON/OFF block
	.DL CODE_0DA57B ; Direction coins ? block
	.DL CODE_0DA57B ; Note block
	.DL CODE_0DA57B ; Note block, bounce on all sides
	.DL CODE_0DA57B ; Turn block (Flower)
	.DL CODE_0DA57B ; Turn block (Feather)
	.DL CODE_0DA57B ; Turn block (Star)
	.DL CODE_0DA57B ; Turn block (Star 2/1-UP/Vine)
	.DL CODE_0DA57B ; Turn block (Multiple coins)
	.DL CODE_0DA57B ; Turn block (Coin)
	.DL CODE_0DA57B ; Turn block (Nothing)
	.DL CODE_0DA57B ; Turn block (POW)
	.DL CODE_0DA57B ; ? block (Flower)
	.DL CODE_0DA57B ; ? block (Feather)
	.DL CODE_0DA57B ; ? block (Star)
	.DL CODE_0DA57B ; ? block (Star 2)
	.DL CODE_0DA57B ; ? block (Multiple coins)
	.DL CODE_0DA57B ; ? block (Key/Wings/Balloon/Shell)
	.DL CODE_0DA57B ; ? block (Yoshi)
	.DL CODE_0DA57B ; ? block (Shell)
	.DL CODE_0DA57B ; ? block (Shell)
	.DL CODE_0DA57B ; Turn block, unbreakable (Feather)
	.DL CODE_0DA57B ; Top left corner edge tile 2
	.DL CODE_0DA57B ; Top right corner edge tile 2
	.DL CODE_0DA57B ; Top left corner edge tile 3
	.DL CODE_0DA57B ; Top right corner edge tile 3
	.DL CODE_0DA57B ; Top left corner edge tile 4
	.DL CODE_0DA57B ; Top right corner edge tile 4
	.DL CODE_0DA57B ; Transculent block
	.DL CODE_0DB2CA ; Yoshi Coin
	.DL ADDR_0DA656 ; Top left slope
	.DL ADDR_0DA656 ; Top right slope
	.DL CODE_0DA673 ; Purple triangle, left
	.DL CODE_0DA673 ; Purple triangle, right
	.DL CODE_0DA68E ; Midway point rope
	.DL CODE_0DA6D1 ; Door
	.DL CODE_0DA6D1 ; Invisible POW door
	.DL CODE_0DEABF ; Ghost house exit
	.DL CODE_0DA7C1 ; Climbing net door
	.DL CODE_0DC259 ; Conveyor end tile 1
	.DL CODE_0DC259 ; Conveyor end tile 2
	.DL CODE_0DCE67 ; Line guide, top left 1/4 large circle
	.DL CODE_0DCE67 ; Line guide, top right 1/4 large circle
	.DL CODE_0DCE67 ; Line guide, bottom left 1/4 large circle
	.DL CODE_0DCE67 ; Line guide, bottom right 1/4 large circle
	.DL CODE_0DCE94 ; Line guide, top left 1/4 small circle
	.DL CODE_0DCE94 ; Line guide, top right 1/4 small circle
	.DL CODE_0DCE94 ; Line guide, bottom left 1/4 small circle
	.DL CODE_0DCE94 ; Line guide, bottom right 1/4 small circle
	.DL CODE_0DCEC0 ; Line guide end, for horizontal line
	.DL CODE_0DCEDA ; Line guide end, for vertical line
	.DL CODE_0DE95F ; Switch palace bottom right corner tile
	.DL CODE_0DE95F ; Switch palace bottom left corner tile
	.DL CODE_0DE95F ; Switch palace top right corner tile
	.DL CODE_0DE95F ; Switch palace top left corner tile
	.DL CODE_0DE95F ; Bit of brick background tile 1
	.DL CODE_0DE95F ; Bit of brick background tile 2
	.DL CODE_0DE95F ; Bit of brick background tile 3
	.DL CODE_0DE95F ; Bit of brick background tile 4
	.DL ADDR_0DE971 ; Large background area
	.DL CODE_0DDA57 ; Lava/mud top right corner edge
	.DL CODE_0DE9AA ; Ghost house clock
	.DL CODE_0DE9AA ; Ghost house top left to bottom right beam 1
	.DL CODE_0DE9AA ; Ghost house top right to bottom left beam 1
	.DL CODE_0DE9ED ; Ghost house cobweb, top right
	.DL CODE_0DE9ED ; Ghost house cobweb, top left
	.DL ADDR_0DEA3E ; Ghost house top right to bottom left beam 2
	.DL ADDR_0DEA3E ; Ghost house top left to bottom right beam 2
	.DL ADDR_0DB571 ; Cloud fringe, bottom and right edge
	.DL ADDR_0DB571 ; Cloud fringe, bottom and left edge
	.DL ADDR_0DB571 ; Cloud fringe, bottom right
	.DL ADDR_0DB571 ; Cloud fringe, bottom left
	.DL ADDR_0DB571 ; Cloud fringe on white, bottom and right edge
	.DL ADDR_0DB571 ; Cloud fringe on white, bottom and left edge
	.DL ADDR_0DB571 ; Cloud fringe on white, bottom right
	.DL ADDR_0DB571 ; Cloud fringe on white, bottom left
	.DL ADDR_0DCEA6 ; Bit of canvass 1
	.DL CODE_0DE0AE ; Canvass 1
	.DL CODE_0DE0AE ; Canvass 2
	.DL CODE_0DE0AE ; Canvass 3
	.DL CODE_0DE0AE ; Canvass 4
	.DL CODE_0DDA68 ; Canvass tile 1
	.DL CODE_0DDA68 ; Canvass tile 2
	.DL CODE_0DDA68 ; Canvass tile 3
	.DL CODE_0DDA68 ; Canvass tile 4
	.DL CODE_0DDA68 ; Canvass tile 5
	.DL CODE_0DDA68 ; Canvass tile 6
	.DL CODE_0DDA68 ; Canvass tile 7
	.DL CODE_0DDA80 ; Bit of canvas 2
	.DL CODE_0DDA80 ; Bit of canvas 3
	.DL CODE_0DDA80 ; Bit of canvas 4
	.DL CODE_0DDAA2 ; Torpedo launcher
	.DL CODE_0DEB6A ; Ghost house entrance
	.DL ADDR_0DEC68 ; Water weed
	.DL CODE_0DA71B ; Big bush 1
	.DL CODE_0DA760 ; Big bush 2
	.DL CODE_0DC2E9 ; Castle entrance
	.DL CODE_0DEC33 ; Yoshi's house
	.DL CODE_0DA7E7 ; Arrow sign
	.DL CODE_0DB58B ; ! block, green
	.DL CODE_0DB6E3 ; Tree branch, left
	.DL CODE_0DB6E3 ; Tree branch, right
	.DL CODE_0DEC8E ; Switch, green
	.DL CODE_0DEC8E ; Switch, yellow
	.DL CODE_0DEC8E ; Switch, blue
	.DL CODE_0DEC8E ; Switch, red
	.DL CODE_0DB583 ; ! block, yellow
	.DL CODE_0DECC1 ; Ghost house window
	.DL CODE_0DC31E ; Boss door
	.DL CODE_0DA80D ; Steep left slope (vert. lev.)
	.DL CODE_0DA80D ; Steep right slope (vert. lev.)
	.DL CODE_0DA846 ; Normal left slope (vert. lev.)
	.DL CODE_0DA846 ; Normal right slope (vert. lev.)
	.DL CODE_0DA87D ; Very steep left slope (vert. lev.)
	.DL CODE_0DA87D ; Very steep right slope (vert. lev.)
	.DL CODE_0DEC5C ; Switch palace right and bottom edge tile
	.DL CODE_0DA6D1 ;\
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; | Unused (will create two garbage tiles each)
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ; |
	.DL CODE_0DA6D1 ;/

CODE_0DA40F:
	SEP #$30
	JSR CODE_0DA415
	RTL

CODE_0DA415:
	SEP #$30
	LDA wm_LvHeadTileset
	JSL ExecutePtrLong

PtrsLong0DA41E:
	.DL CODE_0DA44B ; 0 - Normal 1
	.DL CODE_0DC190 ; 1 - Castle 1
	.DL CODE_0DCD90 ; 2 - Rope 1
	.DL CODE_0DD990 ; 3 - Underground 1
	.DL CODE_0DE890 ; 4 - Switch Palace 1
	.DL CODE_0DE890 ; 5 - Ghost House 1
	.DL CODE_0DCD90 ; 6 - Rope 2
	.DL CODE_0DA44B ; 7 - Normal 2
	.DL CODE_0DCD90 ; 8 - Rope 3
	.DL CODE_0DD990 ; 9 - Underground 2
	.DL CODE_0DD990 ; A - Switch Palace 2
	.DL CODE_0DD990 ; B - Castle 2
	.DL CODE_0DA44B ; C - Cloud/Forest
	.DL CODE_0DE890 ; D - Ghost House 2
	.DL CODE_0DD990 ; E - Underground 3

CODE_0DA44B:
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
	.DL CODE_0DB3E3 ;/ These could've been tileset specific, but Nintendo didn't have that many ideas for them.
	.DL CODE_0DBB2C ; Ice blue vertical pipe
	.DL CODE_0DBB63 ; Ice blue turn tiles
	.DL CODE_0DB916 ; Blue switch blocks
	.DL CODE_0DBADC ; Forest tree top
	.DL CODE_0DBA4C ; Solid left/right and top edge (forest)
	.DL CODE_0DBA0A ; Ledge (forest)
	.DL CODE_0DB9C0 ; Large tree trunk (forest)
	.DL CODE_0DB966 ; Small tree trunk (forest)
	.DL CODE_0DB91E ; Red switch blocks
	.DL CODE_0DB73F ; Right facing diagonal pipe
	.DL CODE_0DB7AA ; Left facing diagonal ledge
	.DL CODE_0DB863 ; Right facing diagonal ledge
	.DL CODE_0DB604 ; Arch ledge
	.DL CODE_0DB6C3 ; Top cloud fringe
	.DL ADDR_0DB705 ; Left/right cloud fringe
	.DL CODE_0DB5B7 ; Bushes 1 through 5

CODE_0DA512:
	LDY #$00
	LDA [wm_Bg1Ptr],Y
	STA wm_BlockNum
	INY
	TYA
	CLC
	ADC wm_Bg1Ptr
	STA wm_Bg1Ptr
	LDA wm_Bg1Ptr+1
	ADC #$00
	STA wm_Bg1Ptr+1
	LDA m10
	AND #$1F
	TAX
	LDA wm_BlockNum
	STA wm_ExitNumTbl,X
	LDA m11
	AND #$01
	STA wm_ExitFlagsTbl,X
	LDA m11
	LSR
	STA wm_Use2ndExitFlag
	RTS

CODE_0DA53D:
	LDA m10
	AND #$1F
	STA wm_LvLoadScreen
	STA wm_MirrorScrnNum
	RTS

DATA_0DA548:
	.DB $1F,$22,$24,$42,$43,$27,$29,$25
	.DB $6E,$6F,$70,$71,$72,$45,$46,$47
	.DB $48,$36,$37,$11,$12,$14,$15,$16
	.DB $17,$18,$19,$1A,$1B,$1C,$29,$1D
	.DB $1F,$20,$21,$22,$23,$25,$26,$27
	.DB $28,$2A,$DE,$E0,$E2,$E4,$EC,$ED
	.DB $2C,$25,$2D

CODE_0DA57B:
	TXA
	SEC
	SBC #$10
_0DA57F:
	STA m0
	CPX #$18
	BCC CODE_0DA5B1
	CPX #$1D
	BCS CODE_0DA5B1
	LDA wm_TransLvNum
	LSR
	LSR
	LSR
	TAY
	LDA wm_TransLvNum
	AND #$07
	TAX
	LDA m0
	CMP #$08
	BNE CODE_0DA5A7
	LDA wm_3UpMoonsCollected,Y
	AND.L DATA_0DA8A6,X
	BEQ CODE_0DA5B1
	BRA _Return0DA5B0

CODE_0DA5A7:
	LDA wm_1UpInvsCollected,Y
	AND.L DATA_0DA8A6,X
	BEQ CODE_0DA5B1
_Return0DA5B0:
	RTS

CODE_0DA5B1:
	LDY wm_BlockSubScrPos
	JSR BlockIsPage1
	LDX m0
	CPX #$13
	BMI +
	JSR BlockIsPage2
+	LDA.L DATA_0DA548,X
	STA m12
	CPX #$01
	BEQ +
	CPX #$07
	BEQ +
	CPX #$32
	BEQ +
	CPX #$26
	BEQ +
	CPX #$1B
	BNE ++
	TYA
	AND #$0F
	CMP #$01
	BEQ +
	CMP #$04
	BEQ +
	CMP #$07
	BEQ +
	CMP #$0A
	BEQ +
	CMP #$0D
	BNE ++
+	TXA
	PHA
	TYA
	PHA
	LDX wm_ItemMemHead
	LDA #$F8
	CLC
	ADC.L DATA_0DA8AE,X
	STA m8
	LDA #$19
	ADC.L DATA_0DA8B1,X
	STA m9
	LDA wm_MirrorScrnNum
	ASL
	ASL
	STA m14
	LDA m10
	AND #$10
	BEQ +
	LDA m14
	ORA #$02
	STA m14
+	TYA
	AND #$08
	BEQ +
	LDA m14
	ORA #$01
	STA m14
+	LDA wm_BlockSubScrPos
	AND #$07
	TAX
	LDY m14
	LDA (m8),Y
	AND.L DATA_0DA8A6,X
	STA m15
	PLA
	TAY
	PLA
	TAX
	LDA m15
	BEQ ++
	CPX #$07
	BEQ +
	JSR BlockIsPage2
	LDA #$32
	STA m12
++	LDA m12
	STA [wm_Map16BlkPtrL],Y
+	RTS

CODE_0DA64D:
	LDA #$32
	JMP _0DA57F

DATA_0DA652:	.DB $D8,$DB

DATA_0DA654:	.DB $DA,$DC

ADDR_0DA656:
	LDY wm_BlockSubScrPos
	TXA
	SEC
	SBC #$42
	TAX
	JSR BlockIsPage2
	LDA.L DATA_0DA652,X
	JSR CODE_0DA95B
	LDA.L DATA_0DA654,X
	STA [wm_Map16BlkPtrL],Y
	JSR BlockIsPage2
	RTS

DATA_0DA671:	.DB $B4,$B5

CODE_0DA673:
	LDY wm_BlockSubScrPos
	TXA
	SEC
	SBC #$44
	TAX
	LDA.L DATA_0DA671,X
	STA [wm_Map16BlkPtrL],Y
	JSR BlockIsPage2
	JSR CODE_0DA97D
	LDA #$EB
	STA [wm_Map16BlkPtrL],Y
	JSR BlockIsPage2
	RTS

CODE_0DA68E:
	LDX wm_TransLvNum
	LDA.L wm_MapData.OwLvFlags,X
	AND #$40
	BNE +
	LDA wm_MidwayPointFlag
	BNE +
	LDY wm_BlockSubScrPos
	DEY
	JSR BlockIsPage1
	LDA #$35
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$38
	STA [wm_Map16BlkPtrL],Y
+	RTS

CODE_0DA6B1:
	LDA wm_Map16BlkPtrL
	STA m4
	LDA wm_Map16BlkPtrL+1
	STA m5
	RTS

CODE_0DA6BA:
	LDA m4
	STA wm_Map16BlkPtrL
	STA wm_Map16BlkPtrH
	LDA m5
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	LDA wm_LvLoadScreen
	STA wm_MirrorScrnNum
	RTS

DATA_0DA6CD:	.DB $1F,$27

DATA_0DA6CF:	.DB $20,$28

CODE_0DA6D1:
	LDY wm_BlockSubScrPos
	TXA
	SEC
	SBC #$47
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DA6CD,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	JSR BlockIsPage1
	LDA.L DATA_0DA6CF,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DA6EE:
	.DB $25,$25,$25,$4B,$4D,$4E,$25,$25,$25
	.DB $25,$25,$54,$49,$49,$5F,$63,$25,$25
	.DB $25,$25,$57,$49,$49,$52,$4A,$5D,$25
	.DB $25,$5A,$49,$49,$50,$51,$4A,$60,$25
	.DB $5A,$49,$49,$49,$53,$4A,$4A,$4A,$63

CODE_0DA71B:
	LDY wm_BlockSubScrPos
	LDA #$08
	STA m0
	LDA #$04
	STA m1
	LDX #$00
	JSR CODE_0DA6B1
-	LDA m0
	STA m2
--	JSR BlockIsPage1
	LDA.L DATA_0DA6EE,X
	JSR CODE_0DA78D
	INX
	DEC m2
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m1
	BPL -
	RTS

DATA_0DA748:
	.DB $25,$25,$4B,$4C,$25,$25
	.DB $25,$54,$49,$5F,$63,$25
	.DB $25,$57,$49,$52,$4A,$5D
	.DB $5A,$49,$49,$49,$4F,$60

CODE_0DA760:
	LDY wm_BlockSubScrPos
	LDA #$05
	STA m0
	LDA #$03
	STA m1
	LDX #$00
	JSR CODE_0DA6B1
-	LDA m0
	STA m2
--	JSR BlockIsPage1
	LDA.L DATA_0DA748,X
	JSR CODE_0DA78D
	INX
	DEC m2
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m1
	BPL -
	RTS

CODE_0DA78D:
	STA m15
	CMP #$25
	BNE CODE_0DA796
	JMP _0DA95D

CODE_0DA796:
	CMP #$49
	BCC ++
	CMP #$54
	BCC ++
	LDA [wm_Map16BlkPtrL],Y
	CMP #$25
	BEQ ++
	CMP #$49
	BEQ +
	INC m15
+	INC m15
++	LDA m15
	JMP CODE_0DA95B

DATA_0DA7B1:
	.DB $10,$11,$11,$12
	.DB $13,$0B,$0B,$15
	.DB $13,$0B,$0B,$15
	.DB $16,$17,$17,$18

CODE_0DA7C1:
	LDY wm_BlockSubScrPos
	LDX #$00
	JSR CODE_0DA6B1
-	LDA #$03
	STA m2
--	LDA.L DATA_0DA7B1,X
	JSR CODE_0DA95B
	INX
	DEC m2
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	CPX #$10
	BNE -
	RTS

DATA_0DA7E3:
	.DB $66,$67
	.DB $68,$69

CODE_0DA7E7:
	LDY wm_BlockSubScrPos
	LDX #$00
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA.L DATA_0DA7E3,X
	JSR CODE_0DA95B
	INX
	TXA
	AND #$01
	BNE -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	CPX #$04
	BNE -
	RTS

DATA_0DA809:	.DB $AA,$AF

DATA_0DA80B:	.DB $E2,$E4

CODE_0DA80D:
	LDY wm_BlockSubScrPos
	TXA
	SEC
	SBC #$91
	TAX
	JSR BlockIsPage2
	LDA.L DATA_0DA809,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA82A
	JSR BlockIsPage2
	LDA.L DATA_0DA80B,X
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DA82A:
	LDA wm_BlockSubScrPos
	CLC
	ADC #$10
	STA wm_BlockSubScrPos
	TAY
	BCC +
	LDA wm_Map16BlkPtrL+1
	CLC
	ADC #$02
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
+	RTS

DATA_0DA83E:	.DB $96,$A0

DATA_0DA840:	.DB $9B,$A5

DATA_0DA842:	.DB $DE,$E6

DATA_0DA844:	.DB $E6,$E0

CODE_0DA846:
	LDY wm_BlockSubScrPos
	TXA
	SEC
	SBC #$93
	TAX
	JSR BlockIsPage2
	LDA.L DATA_0DA83E,X
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA.L DATA_0DA840,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA82A
	JSR BlockIsPage2
	LDA.L DATA_0DA842,X
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA.L DATA_0DA844,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DA877:	.DB $CA,$CC

DATA_0DA879:	.DB $CB,$CD

DATA_0DA87B:	.DB $F1,$F2

CODE_0DA87D:
	LDY wm_BlockSubScrPos
	TXA
	SEC
	SBC #$95
	TAX
	JSR BlockIsPage2
	LDA.L DATA_0DA877,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA82A
	JSR BlockIsPage2
	LDA.L DATA_0DA879,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA82A
	JSR BlockIsPage2
	LDA.L DATA_0DA87B,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DA8A6:	.DB $80,$40,$20,$10,$08,$04,$02,$01

DATA_0DA8AE:	.DB $00,$80,$00

DATA_0DA8B1:	.DB $00,$00,$01

DATA_0DA8B4:
	.DB $02,$21,$23,$2A,$2B,$3F,$03,$13
	.DB $1E,$24,$2E,$2F,$30,$32,$65

CODE_0DA8C3:
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
_0DA8D8:
	CPX #$04
	BNE CODE_0DA92E
	TXA
	PHA
	TYA
	PHA
	LDX wm_ItemMemHead
	LDA #$F8
	CLC
	ADC.L DATA_0DA8AE,X
	STA m8
	LDA #$19
	ADC.L DATA_0DA8B1,X
	STA m9
	LDA wm_MirrorScrnNum
	ASL
	ASL
	STA m14
	LDA m10
	AND #$10
	BEQ +
	LDA m14
	ORA #$02
	STA m14
+	TYA
	AND #$08
	BEQ +
	LDA m14
	ORA #$01
	STA m14
+	TYA
	AND #$07
	TAX
	LDY m14
	LDA (m8),Y
	AND.L DATA_0DA8A6,X
	STA m15
	PLA
	TAY
	PLA
	TAX
	LDA m15
	BEQ CODE_0DA92E
	JSR _0DA95D
	JMP _0DA943

CODE_0DA92E:
	LDA.L DATA_0DA8B4,X
	STA m12
	JSR BlockIsPage1
	CPX #$07
	BMI +
	JSR BlockIsPage2
+	LDA m12
	JSR CODE_0DA95B
_0DA943:
	DEC m2
	LDA m2
	BPL _0DA8D8
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA m0
	STA m2
	DEC m1
	BMI Return0DA95A
	JMP _0DA8D8

Return0DA95A:
	RTS

CODE_0DA95B:
	STA [wm_Map16BlkPtrL],Y
_0DA95D:
	INY
	TYA
	AND #$0F
	BNE +
	LDA wm_Map16BlkPtrL
	CLC
	ADC #$B0
	STA wm_Map16BlkPtrL
	STA wm_Map16BlkPtrH
	LDA wm_Map16BlkPtrL+1
	ADC #$01
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	INC wm_MirrorScrnNum
	LDA wm_BlockSubScrPos
	AND #$F0
	TAY
+	RTS

CODE_0DA97D:
	LDA wm_BlockSubScrPos
	CLC
	ADC #$10
	STA wm_BlockSubScrPos
	TAY
	BCC +
_0DA987:
	LDA wm_Map16BlkPtrL+1
	ADC #$00
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	STA m5
+	RTS

CODE_0DA992:
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
	RTS

CODE_0DA9B4:
	LDA wm_BlockSubScrPos
	CLC
	ADC #$11
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$01
	BPL ++
	TYA
	SEC
	SBC #$10
	TAY
	BCS +
	JSR _0DA987
+	JSR CODE_0DA9EF
++	STY wm_BlockSubScrPos
	RTS

CODE_0DA9D6:
	LDA wm_Map16BlkPtrL
	SEC
	SBC #$B0
	STA wm_Map16BlkPtrL
	STA wm_Map16BlkPtrH
	STA m4
	LDA wm_Map16BlkPtrL+1
	SBC #$01
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	STA m5
	DEC wm_MirrorScrnNum
	RTS

CODE_0DA9EF:
	LDA wm_Map16BlkPtrL
	CLC
	ADC #$B0
	STA wm_Map16BlkPtrL
	STA wm_Map16BlkPtrH
	STA m4
	LDA wm_Map16BlkPtrL+1
	ADC #$01
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	STA m5
	INC wm_MirrorScrnNum
	RTS

BlockIsPage2:
	LDA #$01
	STA [wm_Map16BlkPtrH],Y
	RTS

BlockIsPage1:
	LDA #$00
	STA [wm_Map16BlkPtrH],Y
	RTS

DATA_0DAA12:	.DB $33,$37,$39,$00,$00

DATA_0DAA17:	.DB $34,$38,$3A,$00,$00

DATA_0DAA1C:	.DB $00,$00,$39,$33,$37

DATA_0DAA21:	.DB $00,$00,$3A,$34,$38

CODE_0DAA26:
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
	JSR CODE_0DA6B1
	CPX #$03
	BPL CODE_0DAA52
	JSR BlockIsPage2
	LDA.L DATA_0DAA12,X
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA.L DATA_0DAA17,X
	STA [wm_Map16BlkPtrL],Y
	JMP _0DAA77

CODE_0DAA52:
	CPX #$05
	BNE CODE_0DAA68
	JSR BlockIsPage2
	LDA #$68
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$69
	STA [wm_Map16BlkPtrL],Y
	JMP _0DAA77

CODE_0DAA68:
	JSR BlockIsPage2
	LDA #$35
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$36
	STA [wm_Map16BlkPtrL],Y
_0DAA77:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	CPX #$05
	BEQ +
	CPX #$02
	BPL CODE_0DAA8C
+	DEC m0
	BPL CODE_0DAA52
	JMP _Return0DAAA3

CODE_0DAA8C:
	DEC m0
	BNE CODE_0DAA68
	JSR BlockIsPage2
	LDA.L DATA_0DAA1C,X
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA.L DATA_0DAA21,X
	STA [wm_Map16BlkPtrL],Y
_Return0DAAA3:
	RTS

DATA_0DAAA4:
	.DB $3B,$3C
	.DB $3B,$3F
	.DB $3B,$3C
	.DB $3B,$3F

DATA_0DAAAC:
	.DB $3D,$3E
	.DB $3D,$3E
	.DB $3D,$3E
	.DB $3D,$3E

CODE_0DAAB4:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	STA m1
	LDA wm_BlockSizeType
	AND #$F0
	LSR
	LSR
	LSR
	TAX
	JSR CODE_0DA6B1
_0DAAC9:
	CPX #$04
	BPL CODE_0DAADA
	JSR BlockIsPage2
	LDA.L DATA_0DAAA4,X
	JSR CODE_0DA95B
	JMP _0DAAE4

CODE_0DAADA:
	JSR BlockIsPage2
	LDA.L DATA_0DAAAC,X
	JSR CODE_0DA95B
_0DAAE4:
	CPX #$04
	BPL CODE_0DAAEF
	DEC m1
	BPL CODE_0DAADA
	JMP _0DAAFC

CODE_0DAAEF:
	DEC m1
	BNE _0DAAC9
	JSR BlockIsPage2
	LDA.L DATA_0DAAA4,X
	STA [wm_Map16BlkPtrL],Y
_0DAAFC:
	LDA m0
	STA m1
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	INX
	TXA
	AND #$01
	BNE _0DAAC9
	RTS

CODE_0DAB0D:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR BlockIsPage2
	LDA #$41
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEX
	BMI +
	JSR BlockIsPage2
	LDA #$42
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEX
	BMI +
-	JSR BlockIsPage2
	LDA #$43
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEX
	BPL -
+	RTS

CODE_0DAB3E:
	LDA wm_BlockSizeType
	AND #$0F
_0DAB42:
	CMP #$0A
	BMI CODE_0DAB4C
	SEC
	SBC #$0A
	JMP _0DAB42

CODE_0DAB4C:
	JSL ExecutePtrLong

PtrsLong0DAB50:
	.DL CODE_0DAB6E
	.DL CODE_0DAC21
	.DL CODE_0DAC92
	.DL CODE_0DAD44
	.DL CODE_0DADA3
	.DL CODE_0DADEB
	.DL CODE_0DAE6D
	.DL CODE_0DAEFC
	.DL CODE_0DAF61
	.DL CODE_0DAFEA

CODE_0DAB6E:
	LDY wm_BlockSubScrPos
	LDA #$01
	STA m2
	STA m0
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
_0DAB83:
	LDX m2
	JSR BlockIsPage2
	LDA #$96
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$9B
	JSR CODE_0DABFD
	DEX
	DEX
	BMI _0DABB8
_0DAB99:
	JSR BlockIsPage2
	LDA #$DE
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$E6
	JSR CODE_0DA95B
	DEX
	JMP _0DABB5

CODE_0DABAD:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DABB5:
	DEX
	BPL CODE_0DABAD
_0DABB8:
	JSR CODE_0DA6BA
	INC m2
	INC m2
	DEC m0
	BEQ CODE_0DABEC
	BPL CODE_0DABC8
	JMP Return0DABF6

CODE_0DABC8:
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
	JMP _0DAB83

CODE_0DABEC:
	LDX m2
	DEX
	DEX
	JSR CODE_0DA97D
	JMP _0DAB99

Return0DABF6:
	RTS

DATA_0DABF7:	.DB $3F,$01,$03

DATA_0DABFA:	.DB $01,$03,$04

CODE_0DABFD:
	STA m12
	TXA
	PHA
	LDX #$02
	LDA [wm_Map16BlkPtrL],Y
-	CMP.L DATA_0DABF7,X
	BEQ CODE_0DAC11
	DEX
	BPL -
	JMP _0DAC1A

CODE_0DAC11:
	LDA m12
	CLC
	ADC.L DATA_0DABFA,X
	STA m12
_0DAC1A:
	PLA
	TAX
	LDA m12
	JMP CODE_0DA95B

CODE_0DAC21:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
	LDA #$00
	STA m2
	JSR CODE_0DA6B1
_0DAC34:
	LDX m2
	JSR BlockIsPage2
	LDA #$AA
	JSR CODE_0DABFD
_0DAC3E:
	DEX
	BMI _0DAC57
	JSR BlockIsPage2
	LDA #$E2
	JSR CODE_0DA95B
	JMP _0DAC54

CODE_0DAC4C:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DAC54:
	DEX
	BPL CODE_0DAC4C
_0DAC57:
	JSR CODE_0DA6BA
	INC m2
	DEC m0
	BEQ CODE_0DAC89
	BPL CODE_0DAC65
	JMP Return0DAC91

CODE_0DAC65:
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
	JMP _0DAC34

CODE_0DAC89:
	LDX m2
	JSR CODE_0DA97D
	JMP _0DAC3E

Return0DAC91:
	RTS

CODE_0DAC92:
	LDY wm_BlockSubScrPos
	LDA #$03
	STA m2
	STA m0
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
_0DACA7:
	LDX m2
	JSR BlockIsPage2
	LDA #$6E
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$73
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$78
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$7D
	JSR CODE_0DABFD
	DEX
	DEX
	DEX
	DEX
	BMI _0DAD00
_0DACCF:
	JSR BlockIsPage2
	LDA #$D8
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$DA
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$E6
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$E6
	JSR CODE_0DA95B
	DEX
	DEX
	DEX
	JMP _0DACFD

CODE_0DACF5:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DACFD:
	DEX
	BPL CODE_0DACF5
_0DAD00:
	JSR CODE_0DA6BA
	LDA m2
	CLC
	ADC #$04
	STA m2
	DEC m0
	BEQ CODE_0DAD37
	BPL CODE_0DAD13
	JMP Return0DAD43

CODE_0DAD13:
	LDA wm_BlockSubScrPos
	CLC
	ADC #$0C
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$0C
	BMI ++
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	JSR CODE_0DA9D6
++	STY wm_BlockSubScrPos
	JMP _0DACA7

CODE_0DAD37:
	LDX m2
	DEX
	DEX
	DEX
	DEX
	JSR CODE_0DA97D
	JMP _0DACCF

Return0DAD43:
	RTS

CODE_0DAD44:
	LDY wm_BlockSubScrPos
	LDX #$01
	STX m2
	STX m0
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
	JMP _0DAD7F

CODE_0DAD5C:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
	DEX
_0DAD65:
	CPX #$03
	BNE CODE_0DAD5C
	JSR BlockIsPage2
	LDA #$E6
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$E0
	JSR CODE_0DA95B
	DEX
	DEX
	LDA m0
	BEQ +
_0DAD7F:
	JSR BlockIsPage2
	LDA #$A0
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$A5
	JSR CODE_0DABFD
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	INC m2
	INC m2
	LDX m2
	DEC m0
	BPL CODE_0DADA0
+	RTS

CODE_0DADA0:
	JMP _0DAD65

CODE_0DADA3:
	LDY wm_BlockSubScrPos
	LDX #$00
	STX m2
	STX m0
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
	JMP _0DADD0

CODE_0DADBB:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
	DEX
-	CPX #$01
	BNE CODE_0DADBB
	JSR BlockIsPage2
	LDA #$E4
	JSR CODE_0DA95B
_0DADD0:
	LDA m0
	BEQ +
	JSR BlockIsPage2
	LDA #$AF
	JSR CODE_0DABFD
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	INC m2
	LDX m2
	DEC m0
	BPL -
+	RTS

CODE_0DADEB:
	LDY wm_BlockSubScrPos
	LDX #$03
	STX m2
	JSR CODE_0DA6B1
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	INC m0
	JMP _0DAE36

CODE_0DAE01:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
	DEX
_0DAE0A:
	CPX #$07
	BNE CODE_0DAE01
	JSR BlockIsPage2
	LDA #$E6
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$E6
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$DB
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$DC
	JSR CODE_0DA95B
	DEX
	DEX
	DEX
	DEX
	LDA m0
	BEQ +
_0DAE36:
	JSR BlockIsPage2
	LDA #$82
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$87
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$8C
	JSR CODE_0DABFD
	JSR BlockIsPage2
	LDA #$91
	JSR CODE_0DABFD
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA m2
	CLC
	ADC #$04
	STA m2
	LDX m2
	DEC m0
	BPL CODE_0DAE6A
+	RTS

CODE_0DAE6A:
	JMP _0DAE0A

CODE_0DAE6D:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	ASL
	STA m2
	DEC m2
	LDA #$00
	STA m1
	LDX m2
	JSR CODE_0DA6B1
	JMP _0DAE9E

CODE_0DAE88:
	LDX m2
	JSR BlockIsPage2
	LDA #$C6
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$C7
	JSR CODE_0DA95B
	DEX
	DEX
	BMI _0DAEBD
_0DAE9E:
	JSR BlockIsPage2
	LDA #$EE
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$F0
	JSR CODE_0DA95B
	DEX
	JMP _0DAEBA

CODE_0DAEB2:
	JSR BlockIsPage2
	LDA #$65
	JSR CODE_0DA95B
_0DAEBA:
	DEX
	BPL CODE_0DAEB2
_0DAEBD:
	JSR CODE_0DA6BA
	LDA m1
	BNE CODE_0DAECC
	INC m1
	JSR CODE_0DA97D
	JMP _0DAEF2

CODE_0DAECC:
	LDA m2
	SEC
	SBC #$02
	STA m2
	LDA wm_BlockSubScrPos
	CLC
	ADC #$12
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$02
	BPL _0DAEF2
	TYA
	SEC
	SBC #$10
	TAY
	BCS +
	JSR _0DA987
+	JSR CODE_0DA9EF
_0DAEF2:
	STY wm_BlockSubScrPos
	DEC m0
	BMI Return0DAEFB
	JMP CODE_0DAE88

Return0DAEFB:
	RTS

CODE_0DAEFC:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	ASL
	STA m2
	INC m2
	LDA #$00
	STA m1
	JSR CODE_0DA6B1
	LDX m2
	JMP _0DAF20

CODE_0DAF17:
	JSR BlockIsPage2
	LDA #$65
	JSR CODE_0DA95B
	DEX
_0DAF20:
	CPX #$04
	BPL CODE_0DAF17
	CPX #$02
	BMI +
	JSR BlockIsPage2
	LDA #$F0
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$EF
	JSR CODE_0DA95B
	LDA m1
	BEQ ++
+	JSR BlockIsPage2
	LDA #$C8
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$C9
	JSR CODE_0DA95B
++	JSR CODE_0DA6BA
	LDA m2
	SEC
	SBC #$02
	STA m2
	TAX
	INC m1
	JSR CODE_0DA97D
	DEC m0
	BPL _0DAF20
	RTS

CODE_0DAF61:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	STA m2
	DEC m2
	LDA #$00
	STA m1
	LDX m2
	JSR CODE_0DA6B1
	JMP _0DAF88

CODE_0DAF7B:
	LDX m2
	JSR BlockIsPage2
	LDA #$C4
	JSR CODE_0DA95B
	DEX
	BMI _0DAF9E
_0DAF88:
	JSR BlockIsPage2
	LDA #$EC
	JSR CODE_0DA95B
	JMP _0DAF9B

CODE_0DAF93:
	JSR BlockIsPage2
	LDA #$65
	JSR CODE_0DA95B
_0DAF9B:
	DEX
	BPL CODE_0DAF93
_0DAF9E:
	JSR CODE_0DA6BA
	LDA m1
	BNE CODE_0DAFAF
	INC m1
	LDX m2
	JSR CODE_0DA97D
	JMP _0DAFD5

CODE_0DAFAF:
	LDA m2
	SEC
	SBC #$01
	STA m2
	LDA wm_BlockSubScrPos
	CLC
	ADC #$11
	TAY
	BCC +
	JSR _0DA987
+	TYA
	AND #$0F
	CMP #$01
	BPL _0DAFD5
	TYA
	SEC
	SBC #$10
	TAY
	BCS +
	JSR CODE_0DAFDF
+	JSR CODE_0DA9EF
_0DAFD5:
	STY wm_BlockSubScrPos
	DEC m0
	BMI Return0DAFDE
	JMP CODE_0DAF7B

Return0DAFDE:
	RTS

CODE_0DAFDF:
	LDA wm_Map16BlkPtrL+1
	SBC #$00
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	STA m5
	RTS

CODE_0DAFEA:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	STA m2
	LDA #$00
	STA m1
	JSR CODE_0DA6B1
	LDX m2
	JMP _0DB00B

CODE_0DB002:
	JSR BlockIsPage2
	LDA #$65
	JSR CODE_0DA95B
	DEX
_0DB00B:
	CPX #$02
	BPL CODE_0DB002
	CPX #$01
	BMI +
	JSR BlockIsPage2
	LDA #$ED
	JSR CODE_0DA95B
	LDA m1
	BEQ ++
+	JSR BlockIsPage2
	LDA #$C5
	JSR CODE_0DA95B
++	JSR CODE_0DA6BA
	LDX m2
	DEX
	STX m2
	INC m1
	JSR CODE_0DA97D
	DEC m0
	BPL _0DB00B
	RTS

DATA_0DB039:
	.DB $40,$41,$06,$45,$4B,$48,$4C,$01
	.DB $03,$B6,$B7,$45,$4B,$48,$4C

DATA_0DB048:
	.DB $40,$41,$06,$4B,$4B,$4C,$4C,$40
	.DB $41,$4B,$4C,$4B,$4B,$4C,$4C

DATA_0DB057:
	.DB $40,$41,$06,$4B,$4B,$4C,$4C,$40
	.DB $41,$4B,$4C,$4B,$4B,$4C,$4C

DATA_0DB066:
	.DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DB $FF,$FF,$FF,$E2,$E2,$E4,$E4

CODE_0DB075:
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
	CPX #$03
	BMI +
	JSR BlockIsPage2
+	LDA.L DATA_0DB039,X
	JSR CODE_0DB114
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BMI +++
	JSR BlockIsPage1
	CPX #$09
	BPL +
	CPX #$07
	BPL ++
	CPX #$03
	BMI ++
+	JSR BlockIsPage2
++	LDA.L DATA_0DB048,X
	JSR CODE_0DB198
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BMI +++
-	JSR BlockIsPage1
	CPX #$09
	BPL +
	CPX #$07
	BPL ++
	CPX #$03
	BMI ++
+	JSR BlockIsPage2
++	LDA.L DATA_0DB057,X
	JSR CODE_0DB198
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL -
+++	CPX #$0B
	BMI +
	JSR BlockIsPage2
	LDA.L DATA_0DB066,X
	STA [wm_Map16BlkPtrL],Y
+	RTS

DATA_0DB0F0:
	.DB $7D,$7E,$82,$83,$9B,$9C,$A0,$A1
	.DB $AA,$AB,$AF,$B0,$D8,$DC,$DE,$E0
	.DB $E2,$E4

DATA_0DB102:
	.DB $B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
	.DB $C0,$C1,$C2,$C3,$D9,$DD,$DF,$E1
	.DB $E3,$E5

CODE_0DB114:
	CPX #$03
	BMI +
	CPX #$09
	BMI +
	CPX #$0B
	BMI _Return0DB15B
+	CPX #$02
	BEQ _Return0DB15B
	STX m11
	STA m12
	LDX #$11
	LDA [wm_Map16BlkPtrL],Y
-	CMP.L DATA_0DB0F0,X
	BEQ CODE_0DB152
	DEX
	BPL -
	CMP #$25
	BEQ ++
	LDA m12
	CMP #$01
	BEQ +
	CMP #$03
	BEQ +
	CMP #$45
	BEQ +
	CMP #$48
	BNE ++
+	INC m12
++	LDA m12
	JMP _0DB159

CODE_0DB152:
	JSR BlockIsPage2
	LDA.L DATA_0DB102,X
_0DB159:
	LDX m11
_Return0DB15B:
	RTS

DATA_0DB15C:
	.DB $6E,$6F,$73,$74,$78,$79,$7D,$7E
	.DB $82,$83,$87,$88,$8C,$8D,$91,$92
	.DB $96,$97,$9B,$9C,$A0,$A1,$A5,$A6
	.DB $AA,$AB,$AF,$B0,$E2,$E4

DATA_0DB17A:
	.DB $70,$70,$75,$75,$7A,$7A,$7F,$7F
	.DB $84,$84,$89,$89,$8E,$8E,$93,$93
	.DB $98,$98,$9D,$9D,$A2,$A2,$A7,$A7
	.DB $AC,$AC,$B1,$B1,$E9,$EA

CODE_0DB198:
	CPX #$03
	BMI +
	CPX #$07
	BMI _Return0DB1C7
	CPX #$09
	BPL _Return0DB1C7
+	CPX #$02
	BEQ _Return0DB1C7
	STX m11
	STA m12
	LDX #$1D
	LDA [wm_Map16BlkPtrL],Y
-	CMP.L DATA_0DB15C,X
	BEQ CODE_0DB1BE
	DEX
	BPL -
	LDA m12
	JMP _0DB1C5

CODE_0DB1BE:
	JSR BlockIsPage2
	LDA.L DATA_0DB17A,X
_0DB1C5:
	LDX m11
_Return0DB1C7:
	RTS

CODE_0DB1C8:
	LDA wm_BlockSizeType
	STA m0
	TAX
	LDA #$02
	STA m2
	JMP _0DB1E3

CODE_0DB1D4:
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	TAX
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m2
_0DB1E3:
	JSR CODE_0DA6B1
	LDY wm_BlockSubScrPos
-	JSR BlockIsPage2
	LDA #$00
	JSR CODE_0DA95B
	DEX
	CPX #$FF
	BNE -
	JMP _0DB205

CODE_0DB1F8:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
	DEX
	CPX #$FF
	BNE CODE_0DB1F8
_0DB205:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m2
	BPL CODE_0DB1F8
	RTS

DATA_0DB212:	.DB $2F,$25,$32

DATA_0DB215:	.DB $30,$25,$33

DATA_0DB218:	.DB $31,$25,$34

DATA_0DB21B:	.DB $39,$25,$3C

DATA_0DB21E:	.DB $3A,$25,$3D

DATA_0DB221:	.DB $3B,$25,$3E

CODE_0DB224:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m2
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	STA m1
	JSR CODE_0DA6B1
	LDX #$00
_0DB23B:
	LDA.L DATA_0DB212,X
	STA m3
	LDA m2
	BEQ +
	LDA.L DATA_0DB21B,X
	STA m3
+	JSR BlockIsPage1
	LDA m3
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	LDA wm_Map16BlkPtrL+1
	ADC #$00
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
+	DEC m1
	BEQ ++
-	LDA.L DATA_0DB215,X
	STA m3
	LDA m2
	BEQ +
	LDA.L DATA_0DB21E,X
	STA m3
+	JSR BlockIsPage1
	LDA m3
	STA [wm_Map16BlkPtrL],Y
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	LDA wm_Map16BlkPtrL+1
	ADC #$00
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
+	DEC m1
	BNE -
++	LDA.L DATA_0DB218,X
	STA m3
	LDA m2
	BEQ +
	LDA.L DATA_0DB221,X
	STA m3
+	JSR BlockIsPage1
	LDA m3
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA6BA
	LDA wm_BlockSubScrPos
	CLC
	ADC #$01
	TAY
	AND #$0F
	BNE +
	JSR CODE_0DA9EF
	LDA wm_BlockSubScrPos
	AND #$F0
	TAY
+	STY wm_BlockSubScrPos
	LDA m0
	STA m1
	INX
	CPX #$03
	BEQ Return0DB2C9
	JMP _0DB23B

Return0DB2C9:
	RTS

CODE_0DB2CA:
	LDA wm_TransLvNum
	LSR
	LSR
	LSR
	TAY
	LDA wm_TransLvNum
	AND #$07
	TAX
	LDA wm_5YoshiCoins,Y
	AND.L DATA_0DA8A6,X
	BNE Return0DB2C9
	LDX wm_ItemMemHead
	LDA #$F8
	CLC
	ADC.L DATA_0DA8AE,X
	STA m8
	LDA #$19
	ADC.L DATA_0DA8B1,X
	STA m9
	LDA wm_MirrorScrnNum
	ASL
	ASL
	STA m14
	LDA m10
	AND #$10
	BEQ +
	LDA m14
	ORA #$02
	STA m14
+	LDY wm_BlockSubScrPos
	TYA
	AND #$08
	BEQ +
	LDA m14
	ORA #$01
	STA m14
+	TYA
	AND #$07
	TAX
	LDY m14
	LDA (m8),Y
	AND.L DATA_0DA8A6,X
	BNE +
	LDY wm_BlockSubScrPos
	JSR BlockIsPage1
	LDA #$2D
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	JSR BlockIsPage1
	LDA #$2E
	STA [wm_Map16BlkPtrL],Y
+	RTS

ADDR_0DB336:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	TAX
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
_0DB34A:
	TYA
	PHA
	TXA
	PHA
	LDX wm_ItemMemHead
	LDA #$F8
	CLC
	ADC.L DATA_0DA8AE,X
	STA m8
	LDA #$19
	ADC.L DATA_0DA8B1,X
	STA m9
	LDA wm_MirrorScrnNum
	ASL
	ASL
	STA m14
	LDA m10
	AND #$10
	BEQ +
	LDA m14
	ORA #$02
	STA m14
+	TYA
	AND #$08
	BEQ +
	LDA m14
	ORA #$01
	STA m14
+	TYA
	AND #$07
	TAX
	LDY m14
	LDA (m8),Y
	AND.L DATA_0DA8A6,X
	STA m15
	PLA
	TAX
	PLA
	TAY
	JSR BlockIsPage1
	LDA #$2C
	STA m12
	LDA m15
	BEQ ADDR_0DB3A3
	JSR _0DA987
	JMP _0DB3A8

ADDR_0DB3A3:
	LDA m12
	JSR CODE_0DA95B
_0DB3A8:
	DEX
	BPL _0DB34A
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m1
	BMI Return0DB3BA
	JMP _0DB34A

Return0DB3BA:
	RTS

DATA_0DB3BB:	.DB $05,$06

CODE_0DB3BD:
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
	LDA.L DATA_0DB3BB,X
	JSR CODE_0DA95B
	DEC m0
	BPL -
	RTS

DATA_0DB3DB:	.DB $00,$01,$04,$08

DATA_0DB3DF:	.DB $02,$03,$05,$0B

CODE_0DB3E3:
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
	TXA
	SEC
	SBC #$17
	TAX
	JSR CODE_0DA6B1
-	JSR BlockIsPage1
	LDA.L DATA_0DB3DB,X
	JSR CODE_0DA95B
	DEC m2
	BPL -
	JMP _0DB41C

CODE_0DB40E:
	JSR BlockIsPage1
	LDA.L DATA_0DB3DF,X
	JSR CODE_0DA95B
	DEC m2
	BPL CODE_0DB40E
_0DB41C:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDA m0
	STA m2
	DEC m1
	BPL CODE_0DB40E
	RTS

DATA_0DB42B:
	.DB $26
	.DB $44

CODE_0DB42D:
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
+	LDA.L DATA_0DB42B,X
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

CODE_0DB461:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	LDA wm_BlockSizeType
	AND #$0F
	STA m1
	TAX
	JSR CODE_0DA6B1
	LDA m0
	BEQ _f
-	JSR BlockIsPage1
	LDA #$0B
	JSR CODE_0DA95B
	DEX
	BPL -
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m1
	DEC m0
	BNE -
__	JSR BlockIsPage1
	LDA #$0E
	JSR CODE_0DA95B
	DEX
	BPL _b
	RTS

DATA_0DB49C:	.DB $0A,$0C

CODE_0DB49E:
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
	LDA.L DATA_0DB49C,X
	JSR CODE_0DB4D9
	JMP _0DB4C0

CODE_0DB4B7:
	JSR BlockIsPage1
	LDA.L DATA_0DB49C,X
	STA [wm_Map16BlkPtrL],Y
_0DB4C0:
	TYA
	CLC
	ADC #$10
	TAY
	BCC +
	JSR _0DA987
+	DEC m0
	BNE CODE_0DB4B7
	LDA.L DATA_0DB49C,X
	JMP CODE_0DB4FE

DATA_0DB4D5:	.DB $07,$09

DATA_0DB4D7:	.DB $1A,$19

CODE_0DB4D9:
	STA m12
	LDA [wm_Map16BlkPtrL],Y
	CMP #$08
	BNE CODE_0DB4E8
	LDA.L DATA_0DB4D5,X
	JMP _0DB4F0

CODE_0DB4E8:
	CMP #$0E
	BNE +
	LDA.L DATA_0DB4D7,X
_0DB4F0:
	STA m12
+	JSR BlockIsPage1
	LDA m12
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DB4FA:	.DB $0D,$0F

DATA_0DB4FC:	.DB $1C,$1B

CODE_0DB4FE:
	STA m12
	LDA [wm_Map16BlkPtrL],Y
	CMP #$0E
	BNE CODE_0DB50D
	LDA.L DATA_0DB4FA,X
	JMP _0DB515

CODE_0DB50D:
	CMP #$08
	BNE +
	LDA.L DATA_0DB4FC,X
_0DB515:
	STA m12
+	JSR BlockIsPage1
	LDA m12
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DB51F:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$F0
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR BlockIsPage2
	LDA #$53
	JMP _0DB537

CODE_0DB532:
	JSR BlockIsPage2
	LDA #$54
_0DB537:
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEX
	BNE CODE_0DB532
	JSR BlockIsPage2
	LDA #$55
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DB547:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	TAX
	JSR BlockIsPage2
	LDA #$56
	JMP _0DB55B

CODE_0DB556:
	JSR BlockIsPage2
	LDA #$57
_0DB55B:
	JSR CODE_0DA95B
	DEX
	BNE CODE_0DB556
	JSR BlockIsPage2
	LDA #$58
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DB569:	.DB $91,$92,$96,$97,$9A,$9B,$9F,$A0

ADDR_0DB571:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$68
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DB569,X
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DB583:
	LDX #$01
	BNE _0DB58D ; [BRA FIX]

DATA_0DB587:	.DB $6A,$6B ; two same tables?

DATA_0DB589:	.DB $6A,$6B ; different in beta?

CODE_0DB58B:
	LDX #$00
_0DB58D:
	LDY wm_BlockSubScrPos
	LDA wm_MapData.SwitchBlkFlags,X
	BNE CODE_0DB59E
	JSR BlockIsPage1
	LDA.L DATA_0DB589,X
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DB59E:
	JSR BlockIsPage2
	LDA.L DATA_0DB587,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DB5A8:	.DB $73,$7A,$85,$88,$C3

DATA_0DB5AD:	.DB $74,$7B,$86,$89,$C3

DATA_0DB5B2:	.DB $79,$80,$87,$8E,$C3

CODE_0DB5B7:
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
	LDA.L DATA_0DB5A8,X
	JMP _0DB5D7

CODE_0DB5D0:
	JSR BlockIsPage1
	LDA.L DATA_0DB5AD,X
_0DB5D7:
	JSR CODE_0DA95B
	DEC m0
	BNE CODE_0DB5D0
	JSR BlockIsPage1
	LDA.L DATA_0DB5B2,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DB5E8:
	.DB $07,$0A,$0A,$08,$0A,$0A,$09
	.DB $81,$82,$83,$81,$82,$83,$81
	.DB $81,$25,$84,$81,$25,$84,$81
	.DB $81,$25,$84,$81,$25,$84,$81

CODE_0DB604:
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	LDA #$03
	STA m3
	LDX #$00
	JSR CODE_0DA6B1
	LDY wm_BlockSubScrPos
	LDA m0
	STA m2
	LDA #$02
	STA m1
-	JSR BlockIsPage2
	LDA.L DATA_0DB5E8,X
	JSR CODE_0DA95B
	INX
	DEC m1
	BPL -
	DEC m2
	BEQ +
-	JSR BlockIsPage2
	LDA.L DATA_0DB5E8,X
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA.L DATA_0DB5E8+1,X
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA.L DATA_0DB5E8+2,X
	JSR CODE_0DA95B
	DEC m2
	BNE -
+	TXA
	CLC
	ADC #$03
	TAX
	JSR BlockIsPage2
	LDA.L DATA_0DB5E8,X
	JSR CODE_0DA95B
	JMP _0DB6B2

CODE_0DB664:
	LDY wm_BlockSubScrPos
	LDA m0
	STA m2
	LDA #$02
	STA m1
-	JSR BlockIsPage1
	LDA.L DATA_0DB5E8,X
	JSR CODE_0DA95B
	INX
	DEC m1
	BPL -
	DEC m2
	BEQ +
-	JSR BlockIsPage1
	LDA.L DATA_0DB5E8,X
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA.L DATA_0DB5E8+1,X
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA.L DATA_0DB5E8+2,X
	JSR CODE_0DA95B
	DEC m2
	BNE -
+	TXA
	CLC
	ADC #$03
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DB5E8,X
	JSR CODE_0DA95B
_0DB6B2:
	INX
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m3
	BMI Return0DB6C0
	JMP CODE_0DB664

Return0DB6C0:
	RTS

DATA_0DB6C1:	.DB $93,$9C

CODE_0DB6C3:
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
	LDA.L DATA_0DB6C1,X
	JSR CODE_0DA95B
	DEC m0
	BPL -
	RTS

DATA_0DB6E1:	.DB $C1,$C2

CODE_0DB6E3:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	SEC
	SBC #$88
	TAX
	JSR BlockIsPage1
	LDA.L DATA_0DB6E1,X
	STA [wm_Map16BlkPtrL],Y
	RTS

DATA_0DB6F5:	.DB $94,$8F,$9D,$98,$95,$90,$9E,$99

DATA_0DB6FD:	.DB $8F,$8F,$98,$98,$90,$90,$99,$99

ADDR_0DB705:
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
	LDA.L DATA_0DB6F5,X
	JMP _0DB725

ADDR_0DB71E:
	JSR BlockIsPage1
	LDA.L DATA_0DB6FD,X
_0DB725:
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL ADDR_0DB71E
	RTS

DATA_0DB72F:
	.DB $C4,$C5
	.DB $C7,$EC,$ED,$C6
	.DB $C7,$EE,$59,$5A,$EF
	.DB $C7,$EE,$59,$5B,$5C

CODE_0DB73F:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
	LDA #$01
	STA m1
	LDX #$00
	JSR CODE_0DA6B1
-	LDA m1
	STA m2
--	JSR BlockIsPage2
	LDA.L DATA_0DB72F,X
	JSR CODE_0DA95B
	INX
	DEC m2
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA992
	INC m1
	INC m1
	DEC m0
	BMI ++
	CPX #$06
	BNE -
	DEC m1
-	LDA m1
	STA m2
--	JSR BlockIsPage2
	LDA.L DATA_0DB72F,X
	JSR CODE_0DA95B
	INX
	DEC m2
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA992
	CPX #$10
	BNE +
	TXA
	SEC
	SBC #$05
	TAX
+	DEC m0
	BPL -
++	JSR _0DA95D
	JSR BlockIsPage2
	LDA #$EB
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DB7AA:
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
	STA m3
	LDX #$01
	STX m1
	JSR CODE_0DA6B1
	JSR BlockIsPage2
	LDA #$AA
	JSR CODE_0DABFD
	LDA.W BlockIsPage1 ; FIX SHOULD BE JSR NINTENDO
	LDA #$A1
	JSR CODE_0DB84E
	JMP _0DB7FD

CODE_0DB7D6:
	JSR BlockIsPage2
	LDA #$AA
	JSR CODE_0DABFD
	DEX
	JSR BlockIsPage2
	LDA #$E2
	JSR CODE_0DA95B
	JMP _0DB7F2

CODE_0DB7EA:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DB7F2:
	DEX
	BNE CODE_0DB7EA
	JSR BlockIsPage1
	LDA #$A6
	JSR CODE_0DB84E
_0DB7FD:
	JSR CODE_0DA6BA
	JSR CODE_0DA992
	INC m1
	INC m1
	LDX m1
	DEC m2
	BPL CODE_0DB7D6
	JSR _0DA95D
	STY wm_BlockSubScrPos
	JSR CODE_0DA6B1
	DEX
	STX m1
	JSR BlockIsPage2
	LDA #$F7
	JSR CODE_0DABFD
	JMP _0DB836

CODE_0DB823:
	JSR BlockIsPage1
	LDA #$A3
	JSR CODE_0DB84E
	JMP _0DB836

CODE_0DB82E:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DB836:
	DEX
	BNE CODE_0DB82E
	JSR BlockIsPage1
	LDA #$A6
	JSR CODE_0DB84E
	JSR CODE_0DA6BA
	JSR CODE_0DA9B4
	LDX m1
	DEC m3
	BPL CODE_0DB823
	RTS

CODE_0DB84E:
	STA m15
	LDA [wm_Map16BlkPtrL],Y
	CMP #$25
	BEQ ++
	CMP #$3F
	BEQ +
	INC m15
+	INC m15
++	LDA m15
	JMP CODE_0DA95B

CODE_0DB863:
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
	STA m3
	LDX #$01
	STX m1
	JSR CODE_0DA6B1
	LDA.W BlockIsPage1 ; FIX SHOULD BE JSR NINTENDO
	LDA #$AF
	JSR CODE_0DB84E
	JSR BlockIsPage2
	LDA #$AF
	JSR CODE_0DABFD
	JMP _0DB8B7

CODE_0DB88F:
	JSR BlockIsPage1
	LDA #$A9
	JSR CODE_0DB84E
	JMP _0DB8A2

CODE_0DB89A:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DB8A2:
	DEX
	CPX #$01
	BNE CODE_0DB89A
	JSR BlockIsPage2
	LDA #$E4
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$AF
	JSR CODE_0DABFD
_0DB8B7:
	JSR CODE_0DA6BA
	JSR CODE_0DA992
	INC m1
	INC m1
	LDX m1
	DEC m2
	BPL CODE_0DB88F
	DEX
	STX m1
	JSR BlockIsPage1
	LDA #$A9
	JSR CODE_0DB84E
	JMP _0DB8DD

CODE_0DB8D5:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DB8DD:
	DEX
	BNE CODE_0DB8D5
	JSR BlockIsPage2
	LDA #$F9
	JSR CODE_0DB84E
	JMP _0DB909

CODE_0DB8EB:
	JSR BlockIsPage1
	LDA #$A9
	JSR CODE_0DB84E
	JMP _0DB8FE

CODE_0DB8F6:
	JSR BlockIsPage1
	LDA #$3F
	JSR CODE_0DA95B
_0DB8FE:
	DEX
	BNE CODE_0DB8F6
	JSR BlockIsPage1
	LDA #$AC
	JSR CODE_0DB84E
_0DB909:
	JSR CODE_0DA6BA
	JSR CODE_0DA992
	LDX m1
	DEC m3
	BPL CODE_0DB8EB
	RTS

CODE_0DB916:
	LDX #$00
	BEQ _0DB920 ; [BRA FIX]

DATA_0DB91A:	.DB $6C,$6D ; again same

DATA_0DB91C:	.DB $6C,$6D

CODE_0DB91E:
	LDX #$01
_0DB920:
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
-	LDA m0
	STA m2
	JSR CODE_0DA6B1
--	JSR BlockIsPage1
	LDA.L DATA_0DB91A,X
	STA m15
	LDA wm_MapData.SwitchBlkFlags+2,X
	BEQ +
	JSR BlockIsPage2
	LDA.L DATA_0DB91C,X
	STA m15
+	LDA m15
	JSR CODE_0DA95B
	DEC m2
	BPL --
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m1
	BPL -
	RTS

DATA_0DB962:	.DB $BD,$BF

DATA_0DB964:	.DB $BE,$C0

CODE_0DB966:
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
	LDA.L DATA_0DB962,X
	JSR CODE_0DB997
	JSR CODE_0DA97D
	DEC m0
	BMI +
	JSR BlockIsPage1
	LDA.L DATA_0DB964,X
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA97D
	DEC m0
	BPL -
+	RTS

CODE_0DB997:
	STA m15
	CPX #$01
	BNE CODE_0DB9AE
	LDA [wm_Map16BlkPtrL],Y
	CMP #$B1
	BEQ +
	CMP #$B6
	BNE _0DB9BB
+	STA m15
	INC m15
	JMP _0DB9BB

CODE_0DB9AE:
	LDA [wm_Map16BlkPtrL],Y
	CMP #$0E
	BNE _0DB9BB
	JSR BlockIsPage2
	LDA #$0D
	STA m15
_0DB9BB:
	LDA m15
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DB9C0:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m0
-	JSR CODE_0DA6B1
	LDX #$B9
	JSR CODE_0DB9F6
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m0
	BMI +
	JSR BlockIsPage1
	LDA #$BB
	JSR CODE_0DA95B
	JSR BlockIsPage1
	LDA #$BC
	STA [wm_Map16BlkPtrL],Y
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEC m0
	BPL -
+	RTS

CODE_0DB9F6:
	LDA [wm_Map16BlkPtrL],Y
	CMP #$0E
	BNE +
	JSR BlockIsPage2
	LDX #$0B
+	TXA
	JSR CODE_0DA95B
	INX
	TXA
	STA [wm_Map16BlkPtrL],Y
	RTS

CODE_0DBA0A:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	AND #$0F
	STA m0
	TAX
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	STA m1
	JSR CODE_0DA6B1
-	JSR BlockIsPage2
	LDA #$0E
	JSR CODE_0DA95B
	DEX
	BPL -
	JMP _0DBA37

CODE_0DBA2C:
	JSR BlockIsPage1
	LDA #$B8
	JSR CODE_0DA95B
	DEX
	BPL CODE_0DBA2C
_0DBA37:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	LDX m0
	DEC m1
	BPL CODE_0DBA2C
	RTS

DATA_0DBA44:	.DB $5F,$5E,$10,$0F

DATA_0DBA48:	.DB $60,$5D,$C5,$C4

CODE_0DBA4C:
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
	JSR BlockIsPage2
	LDA.L DATA_0DBA44,X
	STA [wm_Map16BlkPtrL],Y
	JMP _0DBA74

CODE_0DBA67:
	CPX #$02
	BPL +
	JSR BlockIsPage2
+	LDA.L DATA_0DBA48,X
	STA [wm_Map16BlkPtrL],Y
_0DBA74:
	JSR CODE_0DA97D
	DEC m0
	BPL CODE_0DBA67
	RTS

DATA_0DBA7C:
	.DB $B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4
	.DB $B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4
	.DB $B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B5,$B3,$B5,$B3
	.DB $B3,$B4,$B4,$B5,$B3,$B4,$B4,$B4,$B4,$B5,$B3,$B5,$B6,$B1,$B6,$B1
	.DB $B1,$B3,$B5,$B6,$B1,$B3,$B5,$B3,$B5,$B6,$B1,$B6,$25,$25,$25,$25
	.DB $25,$B1,$B6,$25,$25,$B1,$B6,$B1,$B6,$25,$25,$25,$25,$25,$25,$25

CODE_0DBADC:
	LDA wm_BlockSizeType
	STA m15
-	LDA wm_BlockSubScrPos
	STA m14
	TAY
	LDX #$00
	LDA #$05
	STA m1
	LDA #$0F
	STA m0
	JSR CODE_0DA6B1
--	LDA m0
	STA m2
---	LDA.L DATA_0DBA7C,X
	JSR CODE_0DA95B
	INX
	DEC m2
	BPL ---
	JSR CODE_0DA6BA
	LDA m14
	CLC
	ADC #$10
	STA m14
	TAY
	BCC +
	JSR _0DA987
+	DEC m1
	BPL --
	LDA wm_Map16BlkPtrL
	CLC
	ADC #$B0
	STA wm_Map16BlkPtrL
	STA wm_Map16BlkPtrH
	LDA wm_Map16BlkPtrL+1
	ADC #$00
	STA wm_Map16BlkPtrL+1
	STA wm_Map16BlkPtrH+1
	DEC m15
	BPL -
	RTS

CODE_0DBB2C:
	LDY wm_BlockSubScrPos
	LDA wm_BlockSizeType
	LSR
	LSR
	LSR
	LSR
	TAX
	JSR CODE_0DA6B1
	JSR BlockIsPage2
	LDA #$61
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$62
	STA [wm_Map16BlkPtrL],Y
	JMP _0DBB59

CODE_0DBB4A:
	JSR BlockIsPage2
	LDA #$63
	JSR CODE_0DA95B
	JSR BlockIsPage2
	LDA #$64
	STA [wm_Map16BlkPtrL],Y
_0DBB59:
	JSR CODE_0DA6BA
	JSR CODE_0DA97D
	DEX
	BPL CODE_0DBB4A
	RTS

CODE_0DBB63:
	LDX #$0E
	JMP CODE_0DA8C3

DATA_018000:	.DB $80,$40,$20,$10,$08,$04,$02,$01

IsTouchingObjSide:
	LDA wm_SprObjStatus,X
	AND #$03
	RTS

IsOnGround:
	LDA wm_SprObjStatus,X
	AND #$04
	RTS

IsTouchingCeiling:
	LDA wm_SprObjStatus,X
	AND #$08
	RTS

UpdateYPosNoGrvty:
	PHB
	PHK
	PLB
	JSR SubSprYPosNoGrvty
	PLB
	RTL

UpdateXPosNoGrvty:
	PHB
	PHK
	PLB
	JSR SubSprXPosNoGrvty
	PLB
	RTL

UpdateSpritePos:
	PHB
	PHK
	PLB
	JSR SubUpdateSprPos
	PLB
	RTL

SprSprInteract:
	PHB
	PHK
	PLB
	JSR SubSprSprInteract
	PLB
	RTL

SprSprMarioSprRts:
	PHB
	PHK
	PLB
	JSR _SubSprSprMarioSpr
	PLB
	RTL

GenericSprGfxRt0:
	PHB
	PHK
	PLB
	JSR SubSprGfx0Entry0
	PLB
	RTL

InvertAccum:
	EOR #$FF
	INC A
	RTS

CODE_01804E:
	LDA wm_SprObjStatus,X
	BEQ +
	LDA wm_FrameA
	AND #$03
	ORA wm_IsSlipperyLevel
	BNE +
	LDA #$04
	STA m0
	LDA #$0A
	STA m1
_018063:
	JSR IsSprOffScreen
	BNE +
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ CODE_018073
	DEY
	BPL -
+	RTS

CODE_018073:
	LDA #$03
	STA wm_SmokeSprite,Y
	LDA wm_SpriteXLo,X
	ADC m0
	STA wm_SmokeXPos,Y
	LDA wm_SpriteYLo,X
	ADC m1
	STA wm_SmokeYPos,Y
	LDA #$13
	STA wm_SmokeTimer,Y
	RTS

CODE_01808C:
	PHB
	PHK
	PLB
	LDA wm_IsCarrying2
	STA wm_IsCarrying
	STZ wm_IsCarrying2
	STZ wm_IsOnSolidSpr
	STZ wm_IsInLakituCloud
	LDA wm_YoshiSlot
	STA wm_LooseYoshiFlag
	STZ wm_YoshiSlot
	LDX #$0B
-	STX wm_SprProcessIndex
	JSR CODE_0180D2
	JSR HandleSprite
	DEX
	BPL -
	LDA wm_AllowClusterSpr
	BEQ +
	JSL CODE_02F808
+	LDA wm_YoshiSlot
	BNE +
	STZ wm_OnYoshi
	STZ wm_PlayerImgYPos
+	PLB
	RTL

IsSprOffScreen:
	LDA wm_OffscreenHorz,X
	ORA wm_OffscreenVert,X
	RTS

CODE_0180D2:
	PHX
	TXA
	LDX wm_SpriteMemory
	CLC
	ADC.L DATA_07F0B4,X
	TAX
	LDA.L DATA_07F000,X
	PLX
	STA wm_SprOAMIndex,X
	LDA wm_SpriteStatus,X
	BEQ ++
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteDecTbl1,X
	BEQ +
	DEC wm_SpriteDecTbl1,X
+	LDA wm_SpriteDecTbl2,X
	BEQ +
	DEC wm_SpriteDecTbl2,X
+	LDA wm_SpriteDecTbl3,X
	BEQ +
	DEC wm_SpriteDecTbl3,X
+	LDA wm_SpriteDecTbl4,X
	BEQ +
	DEC wm_SpriteDecTbl4,X
+	LDA wm_DisSprCapeContact,X
	BEQ +
	DEC wm_DisSprCapeContact,X
+	LDA wm_SpriteDecTbl5,X
	BEQ +
	DEC wm_SpriteDecTbl5,X
+	LDA wm_SpriteDecTbl6,X
	BEQ ++
	DEC wm_SpriteDecTbl6,X
++	RTS

HandleSprite:
	LDA wm_SpriteStatus,X
	BEQ EraseSprite
	CMP #$08
	BNE CODE_018133
	JMP CallSpriteMain

CODE_018133:
	JSL ExecutePtr

SpriteStatusRtPtr:
	.DW EraseSprite
	.DW CallSpriteInit
	.DW _HandleSprKilled
	.DW HandleSprSmushed
	.DW HandleSprSpinJump
	.DW CODE_019A7B
	.DW HandleSprLvlEnd
	.DW _Return018156
	.DW _Return0185C2
	.DW HandleSprStunned
	.DW HandleSprKicked
	.DW HandleSprCarried
	.DW HandleGoalPowerup

EraseSprite:
	LDA #$FF
	STA wm_SprIndexInLvl,X
_Return018156:
	RTS

HandleGoalPowerup:
	JSR CallSpriteMain
	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos
	DEC wm_SpriteSpeedY,X
	DEC wm_SpriteSpeedY,X
	JSR IsOnGround
	BEQ +
	JSR SetSomeYSpeed
+	RTS

HandleSprLvlEnd:
	JSL LvlEndSprCoins
	RTS

CallSpriteInit:
	LDA #$08
	STA wm_SpriteStatus,X
	LDA wm_SpriteNum,X
	JSL ExecutePtr

	.DW _InitStandardSprite	; 00 - Green Koopa, no shell
	.DW _InitStandardSprite	; 01 - Red Koopa, no shell
	.DW _InitStandardSprite	; 02 - Blue Koopa, no shell
	.DW _InitStandardSprite	; 03 - Yellow Koopa, no shell
	.DW _InitStandardSprite	; 04 - Green Koopa
	.DW _InitStandardSprite	; 05 - Red Koopa
	.DW _InitStandardSprite	; 06 - Blue Koopa
	.DW _InitStandardSprite	; 07 - Yellow Koopa
	.DW _InitStandardSprite	; 08 - Green Koopa, flying left
	.DW InitGrnBounceKoopa	; 09 - Green bouncing Koopa
	.DW _InitStandardSprite	; 0A - Red vertical flying Koopa
	.DW _InitStandardSprite	; 0B - Red horizontal flying Koopa
	.DW _InitStandardSprite	; 0C - Yellow Koopa with wings
	.DW _InitBomb			; 0D - Bob-omb
	.DW InitKeyHole			; 0E - Keyhole
	.DW _InitStandardSprite	; 0F - Goomba
	.DW _InitStandardSprite	; 10 - Bouncing Goomba with wings
	.DW _InitStandardSprite	; 11 - Buzzy Beetle
	.DW UnusedInit			; 12 - Unused
	.DW _InitStandardSprite	; 13 - Spiny
	.DW _InitStandardSprite	; 14 - Spiny falling
	.DW _Return01B011		; 15 - Fish, horizontal
	.DW InitVerticalFish	; 16 - Fish, vertical
	.DW InitFish			; 17 - Fish, created from generator
	.DW InitFish			; 18 - Surface jumping fish
	.DW InitMsgSideExit		; 19 - Display text from level Message Box #1
	.DW _InitPiranha		; 1A - Classic Piranha Plant
	.DW _Return0185C2		; 1B - Bouncing football in place
	.DW InitBulletBill		; 1C - Bullet Bill
	.DW _InitStandardSprite	; 1D - Hopping flame
	.DW InitLakitu			; 1E - Lakitu
	.DW InitMagikoopa		; 1F - Magikoopa
	.DW _Return018583		; 20 - Magikoopa's magic
	.DW _FaceMario			; 21 - Moving coin
	.DW InitVertNetKoopa	; 22 - Green vertical net Koopa
	.DW InitVertNetKoopa	; 23 - Red vertical net Koopa
	.DW InitHorzNetKoopa	; 24 - Green horizontal net Koopa
	.DW InitHorzNetKoopa	; 25 - Red horizontal net Koopa
	.DW InitThwomp			; 26 - Thwomp
	.DW _Return01AEA2		; 27 - Thwimp
	.DW _InitBigBoo			; 28 - Big Boo
	.DW InitKoopaKid		; 29 - Koopa Kid
	.DW InitDownPiranha		; 2A - Upside down Piranha Plant
	.DW _Return0185C2		; 2B - Sumo Brother's fire lightning
	.DW InitYoshiEgg		; 2C - Yoshi egg
	.DW InitKeyBabyYoshi	; 2D - Baby green Yoshi
	.DW InitSpikeTop		; 2E - Spike Top
	.DW _Return0185C2		; 2F - Portable spring board
	.DW _FaceMario			; 30 - Dry Bones, throws bones
	.DW _FaceMario			; 31 - Bony Beetle
	.DW _FaceMario			; 32 - Dry Bones, stay on ledge
	.DW InitFireball		; 33 - Fireball
	.DW _Return0185C2		; 34 - Boss fireball
	.DW InitYoshi			; 35 - Green Yoshi
	.DW _Return0185C2		; 36 - Unused
	.DW _InitBigBoo			; 37 - Boo
	.DW InitEerie			; 38 - Eerie
	.DW InitEerie			; 39 - Eerie, wave motion
	.DW InitUrchin			; 3A - Urchin, fixed
	.DW InitUrchin			; 3B - Urchin, wall detect
	.DW InitUrchinWallFllw	; 3C - Urchin, wall follow
	.DW _InitRipVanFish		; 3D - Rip Van Fish
	.DW InitPSwitch			; 3E - POW
	.DW _Return0185C2		; 3F - Para-Goomba
	.DW _Return0185C2		; 40 - Para-Bomb
	.DW _Return01843D		; 41 - Dolphin, horizontal
	.DW _Return01843D		; 42 - Dolphin2, horizontal
	.DW _Return01843D		; 43 - Dolphin, vertical
	.DW _Return01843D		; 44 - Torpedo Ted
	.DW _Return0185C2		; 45 - Directional coins
	.DW InitDigginChuck		; 46 - Diggin' Chuck
	.DW _Return0183EE		; 47 - Swimming/Jumping fish
	.DW _Return0183EE		; 48 - Diggin' Chuck's rock
	.DW InitGrowingPipe		; 49 - Growing/shrinking pipe end
	.DW _Return0183EE		; 4A - Goal Point Question Sphere
	.DW _InitPiranha		; 4B - Pipe dwelling Lakitu
	.DW InitExplodingBlk	; 4C - Exploding Block
	.DW _InitMontyMole		; 4D - Ground dwelling Monty Mole
	.DW _InitMontyMole		; 4E - Ledge dwelling Monty Mole
	.DW _InitPiranha		; 4F - Jumping Piranha Plant
	.DW _InitPiranha		; 50 - Jumping Piranha Plant, spit fire
	.DW _FaceMario			; 51 - Ninji
	.DW InitMovingLedge		; 52 - Moving ledge hole in ghost house
	.DW _Return0185C2		; 53 - Throw block sprite
	.DW InitClimbingDoor	; 54 - Climbing net door
	.DW InitChckbrdPlat		; 55 - Checkerboard platform, horizontal
	.DW Return01B25D		; 56 - Flying rock platform, horizontal
	.DW InitChckbrdPlat		; 57 - Checkerboard platform, vertical
	.DW Return01B25D		; 58 - Flying rock platform, vertical
	.DW _Return01B267		; 59 - Turn block bridge, horizontal and vertical
	.DW _Return01B267		; 5A - Turn block bridge, horizontal
	.DW InitFloatingPlat	; 5B - Brown platform floating in water
	.DW InitFallingPlat		; 5C - Checkerboard platform that falls
	.DW InitFloatingPlat	; 5D - Orange platform floating in water
	.DW _InitOrangePlat		; 5E - Orange platform, goes on forever
	.DW InitBrwnChainPlat	; 5F - Brown platform on a chain
	.DW Return01AE90		; 60 - Flat green switch palace switch
	.DW InitFloatingSkull	; 61 - Floating skulls
	.DW _InitLineBrwnPlat	; 62 - Brown platform, line-guided
	.DW InitLinePlat		; 63 - Checker/brown platform, line-guided
	.DW InitLineRope		; 64 - Rope mechanism, line-guided
	.DW InitLineGuidedSpr	; 65 - Chainsaw, line-guided
	.DW InitLineGuidedSpr	; 66 - Upside down chainsaw, line-guided
	.DW InitLineGuidedSpr	; 67 - Grinder, line-guided
	.DW InitLineGuidedSpr	; 68 - Fuzz ball, line-guided
	.DW _Return01D6C3		; 69 - Unused
	.DW _Return0185C2		; 6A - Coin game cloud
	.DW _Return01843D		; 6B - Spring board, left wall
	.DW InitPeaBouncer		; 6C - Spring board, right wall
	.DW _Return0185C2		; 6D - Invisible solid block
	.DW InitDinos			; 6E - Dino Rhino
	.DW InitDinos			; 6F - Dino Torch
	.DW InitPokey			; 70 - Pokey
	.DW InitSuperKoopa		; 71 - Super Koopa, red cape
	.DW InitSuperKoopa		; 72 - Super Koopa, yellow cape
	.DW InitSuperKoopaFthr	; 73 - Super Koopa, feather
	.DW InitPowerUp			; 74 - Mushroom
	.DW InitPowerUp			; 75 - Flower
	.DW InitPowerUp			; 76 - Star
	.DW InitPowerUp			; 77 - Feather
	.DW InitPowerUp			; 78 - 1-Up
	.DW _Return018583		; 79 - Growing Vine
	.DW _Return018583		; 7A - Firework
	.DW InitGoalTape		; 7B - Goal Point
	.DW _Return0185C2		; 7C - Princess Peach
	.DW _Return0185C2		; 7D - Balloon
	.DW _Return0185C2		; 7E - Flying Red coin
	.DW _Return0185C2		; 7F - Flying yellow 1-Up
	.DW InitKeyBabyYoshi	; 80 - Key
	.DW InitChangingItem	; 81 - Changing item from translucent block
	.DW InitBonusGame		; 82 - Bonus game sprite
	.DW InitFlyingBlock		; 83 - Left flying question block
	.DW InitFlyingBlock		; 84 - Flying question block
	.DW _Return0185C2		; 85 - Unused (Pretty sure)
	.DW InitWiggler			; 86 - Wiggler
	.DW _Return0185C2		; 87 - Lakitu's cloud
	.DW InitWingedCage		; 88 - Unused (Winged cage sprite)
	.DW _Return01843D		; 89 - Layer 3 smash
	.DW _Return0185C2		; 8A - Bird from Yoshi's house
	.DW _Return0185C2		; 8B - Puff of smoke from Yoshi's house
	.DW InitMsgSideExit		; 8C - Fireplace smoke/exit from side screen
	.DW _Return0185C2		; 8D - Ghost house exit sign and door
	.DW _Return0185C2		; 8E - Invisible "Warp Hole" blocks
	.DW InitScalePlats		; 8F - Scale platforms
	.DW _FaceMario			; 90 - Large green gas bubble
	.DW Return018869		; 91 - Chargin' Chuck
	.DW InitChuck			; 92 - Splittin' Chuck
	.DW InitChuck			; 93 - Bouncin' Chuck
	.DW InitWhistlinChuck	; 94 - Whistlin' Chuck
	.DW InitClappinChuck	; 95 - Clapin' Chuck
	.DW Return018869		; 96 - Unused (Chargin' Chuck clone)
	.DW InitPuntinChuck		; 97 - Puntin' Chuck
	.DW InitPitchinChuck	; 98 - Pitchin' Chuck
	.DW _Return0183EE		; 99 - Volcano Lotus
	.DW InitSumoBrother		; 9A - Sumo Brother
	.DW InitHammerBrother	; 9B - Hammer Brother
	.DW _Return0185C2		; 9C - Flying blocks for Hammer Brother
	.DW InitBubbleSpr		; 9D - Bubble with sprite
	.DW InitBallNChain		; 9E - Ball and Chain
	.DW InitBanzai			; 9F - Banzai Bill
	.DW InitBowserScene		; A0 - Activates Bowser scene
	.DW _Return0185C2		; A1 - Bowser's bowling ball
	.DW _Return0185C2		; A2 - MechaKoopa
	.DW InitGreyChainPlat	; A3 - Grey platform on chain
	.DW InitFloatSpkBall	; A4 - Floating Spike ball
	.DW _InitFuzzBallSpark	; A5 - Fuzzball/Sparky, ground-guided
	.DW _InitFuzzBallSpark	; A6 - HotHead, ground-guided
	.DW _Return0185C2		; A7 - Iggy's ball
	.DW _Return0185C2		; A8 - Blargg
	.DW InitReznor			; A9 - Reznor
	.DW InitFishbone		; AA - Fishbone
	.DW _FaceMario			; AB - Rex
	.DW InitWoodSpike		; AC - Wooden Spike, moving down and up
	.DW InitWoodSpike2		; AD - Wooden Spike, moving up/down first
	.DW _Return0185C2		; AE - Fishin' Boo
	.DW _Return0185C2		; AF - Boo Block
	.DW InitDiagBouncer		; B0 - Reflecting stream of Boo Buddies
	.DW InitCreateEatBlk	; B1 - Creating/Eating block
	.DW _Return0185C2		; B2 - Falling Spike
	.DW InitBowsersFire		; B3 - Bowser statue fireball
	.DW _FaceMario			; B4 - Grinder, non-line-guided
	.DW _Return0185C2		; B5 - Sinking fireball used in boss battles
	.DW InitDiagBouncer		; B6 - Reflecting fireball
	.DW _Return0185C2		; B7 - Carrot Top lift, upper right
	.DW _Return0185C2		; B8 - Carrot Top lift, upper left
	.DW _Return0185C2		; B9 - Info Box
	.DW InitTimedPlat		; BA - Timed lift
	.DW _Return0185C2		; BB - Grey moving castle block
	.DW InitBowserStatue	; BC - Bowser statue
	.DW InitSlidingKoopa	; BD - Sliding Koopa without a shell
	.DW _Return0185C2		; BE - Swooper bat
	.DW _FaceMario			; BF - Mega Mole
	.DW InitGreyLavaPlat	; C0 - Grey platform on lava
	.DW _InitMontyMole		; C1 - Flying grey turnblocks
	.DW _FaceMario			; C2 - Blurp fish
	.DW _FaceMario			; C3 - Porcu-Puffer fish
	.DW _Return0185C2		; C4 - Grey platform that falls
	.DW _FaceMario			; C5 - Big Boo Boss
	.DW _Return018313		; C6 - Dark room with spot light
	.DW _Return0185C2		; C7 - Invisible mushroom
	.DW _Return0185C2		; C8 - Light switch block for dark room 

InitGreyLavaPlat:
	INC wm_SpriteYLo,X
	INC wm_SpriteYLo,X
_Return018313:
	RTS

InitBowserStatue:
	INC wm_SpriteDir,X
	JSR InitExplodingBlk
	STY wm_SpriteState,X
	CPY #$02
	BNE +
	LDA #$01
	STA wm_SpritePal,X
+	RTS

InitTimedPlat:
	LDY #$3F
	LDA wm_SpriteXLo,X
	AND #$10
	BNE +
	LDY #$FF
+	TYA
	STA wm_SpriteMiscTbl6,X
	RTS

YoshiPal:	.DB $09,$07,$05,$07

InitYoshiEgg:
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA YoshiPal,Y
	STA wm_SpritePal,X
	INC wm_SprStompImmuneTbl,X
	RTS

DiagBounceInitSpeed:	.DB 16,-16

InitDiagBouncer:
	JSR _FaceMario
	LDA DiagBounceInitSpeed,Y
	STA wm_SpriteSpeedX,X
	LDA #$F0
	STA wm_SpriteSpeedY,X
	RTS

InitWoodSpike:
	LDA wm_SpriteYLo,X
	SEC
	SBC #$40
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
	RTS

InitWoodSpike2:
	JMP _InitMontyMole

InitBowserScene:
	JSL CODE_03A0F1
	RTS

InitSumoBrother:
	LDA #$03
	STA wm_SpriteState,X
	LDA #$70
_018379:
	STA wm_SpriteDecTbl1,X
	RTS

InitSlidingKoopa:
	LDA #$04
	BRA _018379

InitGrowingPipe:
	LDA #$40
	STA wm_SpriteMiscTbl5,X
	RTS

InitBanzai:
	JSR SubHorizPos
	TYA
	BNE CODE_018390
	JMP _OffScrEraseSprite

CODE_018390:
	LDA #$09
	STA wm_SoundCh3
	RTS

InitBallNChain:
	LDA #$38
	BRA _01839C

InitGreyChainPlat:
	LDA #$30
_01839C:
	STA wm_SprStompImmuneTbl,X
	RTS

ExplodingBlkSpr:	.DB $15,$0F,$00,$04

InitExplodingBlk:
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA ExplodingBlkSpr,Y
	STA wm_SpriteState,X
	RTS

ScalePlatWidth:	.DB $80,$40

InitScalePlats:
	LDA wm_SpriteYLo,X
	STA wm_SpriteMiscTbl5,X
	LDA wm_SpriteYHi,X
	STA wm_SpriteMiscTbl3,X
	LDA wm_SpriteXLo,X
	AND #$10
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA wm_SpriteXLo,X
	CLC
	ADC ScalePlatWidth,Y
	STA wm_SpriteState,X
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteGfxTbl,X
	RTS

InitMsgSideExit:
	LDA #$28
	STA wm_SpriteDecTbl4,X
	RTS

InitYoshi:
	DEC wm_SpriteMiscTbl8,X
	INC wm_SpriteDir,X
	LDA wm_OWHasYoshi
	BEQ _Return0183EE
	STZ wm_SpriteStatus,X
_Return0183EE:
	RTS

DATA_0183EF:	.DB 8

DATA_0183F0:	.DB 0,8

InitSpikeTop:
	JSR SubHorizPos
	TYA
	EOR #$01
	ASL
	ASL
	ASL
	ASL
	JSR _01841D
	STZ wm_SprInWaterTbl,X
	BRA _01840E

InitUrchinWallFllw:
	INC wm_SpriteYLo,X
	BNE _InitFuzzBallSpark
	INC wm_SpriteYHi,X
_InitFuzzBallSpark:
	JSR InitUrchin
_01840E:
	LDA wm_SpriteMiscTbl3,X
	EOR #$10
	STA wm_SpriteMiscTbl3,X
	LSR
	LSR
	STA wm_SpriteState,X
	RTS

InitUrchin:
	LDA wm_SpriteXLo,X
_01841D:
	LDY #$00
	AND #$10
	STA wm_SpriteMiscTbl3,X
	BNE +
	INY
+	LDA DATA_0183EF,Y
	STA wm_SpriteSpeedX,X
	LDA DATA_0183F0,Y
	STA wm_SpriteSpeedY,X
_InitRipVanFish:
	INC wm_SprInWaterTbl,X
	RTS

InitKeyBabyYoshi:
	LDA #$09
	STA wm_SpriteStatus,X
	RTS

InitChangingItem:
	INC wm_SpriteState,X
_Return01843D:
	RTS

InitPeaBouncer:
	LDA wm_SpriteXLo,X
	SEC
	SBC #$08
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	SBC #$00
	STA wm_SpriteXHi,X
	RTS

InitPSwitch:
	LDA wm_SpriteXLo,X
	LSR
	LSR
	LSR
	LSR
	AND #$01
	STA wm_SpriteMiscTbl3,X
	TAY
	LDA PSwitchPal,Y
	STA wm_SpritePal,X
	LDA #$09
	STA wm_SpriteStatus,X
	RTS

PSwitchPal:	.DB $06,$02

ADDR_018468:
	JMP _OffScrEraseSprite

InitLakitu:
	LDY #$09
-	CPY wm_SprProcessIndex
	BEQ +
	LDA wm_SpriteStatus,Y
	CMP #$08
	BNE +
	LDA.W wm_SpriteNum,Y
	CMP #$87
	BEQ ADDR_018468
	CMP #$1E
	BEQ ADDR_018468
+	DEY
	BPL -
	STZ wm_TimeTillRespawn
	STZ wm_AppearSprTimer
	STZ wm_GeneratorNum
	LDA wm_SpriteYLo,X
	STA wm_RespawnSprYPos
	LDA wm_SpriteYHi,X
	STA wm_RespawnSprYPos+1
	JSL FindFreeSprSlot
	BMI _InitMontyMole
	STY wm_LakituCloudSlot
	LDA #$87
	STA.W wm_SpriteNum,Y
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	STZ wm_StolenCloudTimer
_InitMontyMole:
	LDA wm_SpriteXLo,X
	AND #$10
	STA wm_SpriteMiscTbl3,X
	RTS

InitCreateEatBlk:
	LDA #$FF
	STA wm_RunEaterBlock
	BRA _InitMontyMole

InitBulletBill:
	JSR SubHorizPos
	TYA
	STA wm_SpriteState,X
	LDA #$10
	STA wm_SpriteDecTbl1,X
	RTS

InitClappinChuck:
	LDA #$08
	BRA _01851A

InitPitchinChuck:
	LDA wm_SpriteXLo,X
	AND #$30
	LSR
	LSR
	LSR
	LSR
	STA wm_SprStompImmuneTbl,X
	LDA #$0A
	BRA _01851A

InitPuntinChuck:
	LDA #$09
	BRA _01851A

InitWhistlinChuck:
	LDA #$0B
	BRA _01851A

InitChuck:
	LDA #$05
	BRA _01851A

InitDigginChuck:
	LDA #$30
	STA wm_SpriteDecTbl1,X
	LDA wm_SpriteXLo,X
	AND #$10
	LSR
	LSR
	LSR
	LSR
	STA wm_SpriteDir,X
	LDA #$04
_01851A:
	STA wm_SpriteState,X
	JSR _FaceMario
	LDA DATA_018526,Y
	STA wm_SpriteMiscTbl3,X
	RTS

DATA_018526:	.DB $00,$04

InitSuperKoopa:
	LDA #$28
	STA wm_SpriteSpeedY,X
	BRA _FaceMario

InitSuperKoopaFthr:
	JSR _FaceMario
	LDA wm_SpriteXLo,X
	AND #$10
	BEQ CODE_018547
	LDA #$10
	STA wm_Tweaker1656,X
	LDA #$80
	STA wm_Tweaker1662,X
	LDA #$10
	STA wm_Tweaker1686,X
	RTS

CODE_018547:
	INC wm_SpriteMiscTbl5,X
	RTS

InitPokey:
	LDA #$1F
	LDY wm_OnYoshi
	BNE +
	LDA #$07
+	STA wm_SpriteState,X
	BRA _FaceMario

InitDinos:
	LDA #$04
	STA wm_SpriteMiscTbl3,X
_InitBomb:
	LDA #$FF
	STA wm_SpriteDecTbl1,X
	BRA _FaceMario

InitBubbleSpr:
	JSR InitExplodingBlk
	STY wm_SpriteState,X
	DEC wm_SpriteMiscTbl5,X
	BRA _FaceMario

InitGrnBounceKoopa:
	LDA wm_SpriteYLo,X
	AND #$10
	STA wm_SpriteMiscTbl8,X
_InitStandardSprite:
	JSL GetRand
	STA wm_SpriteMiscTbl6,X
_FaceMario:
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
_Return018583:
	RTS

InitBowsersFire:
	LDA #$17
	STA wm_SoundCh3
	BRA _FaceMario

InitPowerUp:
	INC wm_SpriteState,X
	RTS

InitFishbone:
	JSL GetRand
	AND #$1F
	STA wm_SpriteDecTbl1,X
	JMP _FaceMario

InitDownPiranha:
	ASL wm_SpritePal,X
	SEC
	ROR wm_SpritePal,X
	LDA wm_SpriteYLo,X
	SEC
	SBC #$10
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
_InitPiranha:
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_SpriteXLo,X
	DEC wm_SpriteYLo,X
	LDA wm_SpriteYLo,X
	CMP #$FF
	BNE _Return0185C2
	DEC wm_SpriteYHi,X
_Return0185C2:
	RTS

CallSpriteMain:
	STZ wm_SprPixelMove
	LDA wm_SpriteNum,X
	JSL ExecutePtr

	.DW ShellessKoopas		; 00 - Green Koopa, no shell
	.DW ShellessKoopas		; 01 - Red Koopa, no shell
	.DW ShellessKoopas		; 02 - Blue Koopa, no shell
	.DW ShellessKoopas		; 03 - Yellow Koopa, no shell
	.DW Spr0to13Start		; 04 - Green Koopa
	.DW Spr0to13Start		; 05 - Red Koopa
	.DW Spr0to13Start		; 06 - Blue Koopa
	.DW Spr0to13Start		; 07 - Yellow Koopa
	.DW GreenParaKoopa		; 08 - Green Koopa, flying left
	.DW GreenParaKoopa		; 09 - Green bouncing Koopa
	.DW RedVertParaKoopa	; 0A - Red vertical flying Koopa
	.DW RedHorzParaKoopa	; 0B - Red horizontal flying Koopa
	.DW Spr0to13Start		; 0C - Yellow Koopa with wings
	.DW Bobomb				; 0D - Bob-omb
	.DW Keyhole				; 0E - Keyhole
	.DW Spr0to13Start		; 0F - Goomba
	.DW WingedGoomba		; 10 - Bouncing Goomba with wings
	.DW Spr0to13Start		; 11 - Buzzy Beetle
	.DW _Return01F87B		; 12 - Unused
	.DW Spr0to13Start		; 13 - Spiny
	.DW SpinyEgg			; 14 - Spiny falling
	.DW Fish				; 15 - Fish, horizontal
	.DW Fish				; 16 - Fish, vertical
	.DW GeneratedFish		; 17 - Fish, created from generator
	.DW JumpingFish			; 18 - Surface jumping fish
	.DW PSwitch				; 19 - Display text from level Message Box #1
	.DW ClassicPiranhas		; 1A - Classic Piranha Plant
	.DW Bank3SprHandler		; 1B - Bouncing football in place
	.DW BulletBill			; 1C - Bullet Bill
	.DW HoppingFlame		; 1D - Hopping flame
	.DW Lakitu				; 1E - Lakitu
	.DW Magikoopa			; 1F - Magikoopa
	.DW MagikoopasMagic		; 20 - Magikoopa's magic
	.DW _PowerUpRt			; 21 - Moving coin
	.DW ClimbingKoopa		; 22 - Green vertical net Koopa
	.DW ClimbingKoopa		; 23 - Red vertical net Koopa
	.DW ClimbingKoopa		; 24 - Green horizontal net Koopa
	.DW ClimbingKoopa		; 25 - Red horizontal net Koopa
	.DW Thwomp				; 26 - Thwomp
	.DW Thwimp				; 27 - Thwimp
	.DW BigBoo				; 28 - Big Boo
	.DW KoopaKid			; 29 - Koopa Kid
	.DW ClassicPiranhas		; 2A - Upside down Piranha Plant
	.DW SumosLightning		; 2B - Sumo Brother's fire lightning
	.DW YoshiEgg			; 2C - Yoshi egg
	.DW _Return0185C2		; 2D - Baby green Yoshi
	.DW WallFollowers		; 2E - Spike Top
	.DW SpringBoard			; 2F - Portable spring board
	.DW DryBonesAndBeetle	; 30 - Dry Bones, throws bones
	.DW DryBonesAndBeetle	; 31 - Bony Beetle
	.DW DryBonesAndBeetle	; 32 - Dry Bones, stay on ledge
	.DW Fireballs			; 33 - Fireball
	.DW BossFireball		; 34 - Boss fireball
	.DW Yoshi				; 35 - Green Yoshi
	.DW DATA_01E41F			; 36 - Unused
	.DW BooBooBlock			; 37 - Boo
	.DW Eerie				; 38 - Eerie
	.DW Eerie				; 39 - Eerie, wave motion
	.DW WallFollowers		; 3A - Urchin, fixed
	.DW WallFollowers		; 3B - Urchin, wall detect
	.DW WallFollowers		; 3C - Urchin, wall follow
	.DW RipVanFish			; 3D - Rip Van Fish
	.DW PSwitch				; 3E - POW
	.DW ParachuteSprites	; 3F - Para-Goomba
	.DW ParachuteSprites	; 40 - Para-Bomb
	.DW Dolphin				; 41 - Dolphin, horizontal
	.DW Dolphin				; 42 - Dolphin2, horizontal
	.DW Dolphin				; 43 - Dolphin, vertical
	.DW TorpedoTed			; 44 - Torpedo Ted
	.DW DirectionalCoins	; 45 - Directional coins
	.DW DigginChuck			; 46 - Diggin' Chuck
	.DW SwimJumpFish		; 47 - Swimming/Jumping fish
	.DW DigginChucksRock	; 48 - Diggin' Chuck's rock
	.DW GrowingPipe			; 49 - Growing/shrinking pipe end
	.DW GoalSphere			; 4A - Goal Point Question Sphere
	.DW PipeLakitu			; 4B - Pipe dwelling Lakitu
	.DW ExplodingBlock		; 4C - Exploding Block
	.DW MontyMole			; 4D - Ground dwelling Monty Mole
	.DW MontyMole			; 4E - Ledge dwelling Monty Mole
	.DW JumpingPiranha		; 4F - Jumping Piranha Plant
	.DW JumpingPiranha		; 50 - Jumping Piranha Plant, spit fire
	.DW Bank3SprHandler		; 51 - Ninji
	.DW MovingLedge			; 52 - Moving ledge hole in ghost house
	.DW _Return0185C2		; 53 - Throw block sprite
	.DW ClimbingDoor		; 54 - Climbing net door
	.DW Platforms			; 55 - Checkerboard platform, horizontal
	.DW Platforms			; 56 - Flying rock platform, horizontal
	.DW Platforms			; 57 - Checkerboard platform, vertical
	.DW Platforms			; 58 - Flying rock platform, vertical
	.DW TurnBlockBridge		; 59 - Turn block bridge, horizontal and vertical
	.DW HorzTurnBlkBridge	; 5A - Turn block bridge, horizontal
	.DW Platforms2			; 5B - Brown platform floating in water
	.DW Platforms2			; 5C - Checkerboard platform that falls
	.DW Platforms2			; 5D - Orange platform floating in water
	.DW OrangePlatform		; 5E - Orange platform, goes on forever
	.DW BrownChainedPlat	; 5F - Brown platform on a chain
	.DW PalaceSwitch		; 60 - Flat green switch palace switch
	.DW FloatingSkulls		; 61 - Floating skulls
	.DW _LineFuzzyPlats		; 62 - Brown platform, line-guided
	.DW _LineFuzzyPlats		; 63 - Checker/brown platform, line-guided
	.DW LineRopeChainsaw	; 64 - Rope mechanism, line-guided
	.DW LineRopeChainsaw	; 65 - Chainsaw, line-guided
	.DW LineRopeChainsaw	; 66 - Upside down chainsaw, line-guided
	.DW _LineGrinder		; 67 - Grinder, line-guided
	.DW _LineFuzzyPlats		; 68 - Fuzz ball, line-guided
	.DW _Return01D6C3		; 69 - Unused
	.DW CoinCloud			; 6A - Coin game cloud
	.DW PeaBouncer			; 6B - Spring board, left wall
	.DW PeaBouncer			; 6C - Spring board, right wall
	.DW InvisSolidDinos		; 6D - Invisible solid block
	.DW InvisSolidDinos		; 6E - Dino Rhino
	.DW InvisSolidDinos		; 6F - Dino Torch
	.DW Pokey				; 70 - Pokey
	.DW RedSuperKoopa		; 71 - Super Koopa, red cape
	.DW YellowSuperKoopa	; 72 - Super Koopa, yellow cape
	.DW FeatherSuperKoopa	; 73 - Super Koopa, feather
	.DW _PowerUpRt			; 74 - Mushroom
	.DW FireFlower			; 75 - Flower
	.DW _PowerUpRt			; 76 - Star
	.DW Feather				; 77 - Feather
	.DW _PowerUpRt			; 78 - 1-Up
	.DW GrowingVine			; 79 - Growing Vine
	.DW Bank3SprHandler		; 7A - Firework
	.DW GoalTape			; 7B - Goal Point
	.DW Bank3SprHandler		; 7C - Princess Peach
	.DW BalloonKeyFlyObjs	; 7D - Balloon
	.DW BalloonKeyFlyObjs	; 7E - Flying Red coin
	.DW BalloonKeyFlyObjs	; 7F - Flying yellow 1-Up
	.DW BalloonKeyFlyObjs	; 80 - Key
	.DW ChangingItem		; 81 - Changing item from translucent block
	.DW BonusGame			; 82 - Bonus game sprite
	.DW FlyingBlock			; 83 - Left flying question block
	.DW FlyingBlock			; 84 - Flying question block
	.DW InitFlyingBlock		; 85 - Unused (Pretty sure)
	.DW Wiggler				; 86 - Wiggler
	.DW LakituCloud			; 87 - Lakitu's cloud
	.DW WingedCage			; 88 - Unused (Winged cage sprite)
	.DW Layer3Smash			; 89 - Layer 3 smash
	.DW YoshisHouseBirds	; 8A - Bird from Yoshi's house
	.DW YoshisHouseSmoke	; 8B - Puff of smoke from Yoshi's house
	.DW SideExit			; 8C - Fireplace smoke/exit from side screen
	.DW GhostHouseExit		; 8D - Ghost house exit sign and door
	.DW WarpBlocks			; 8E - Invisible "Warp Hole" blocks
	.DW ScalePlatforms		; 8F - Scale platforms
	.DW GasBubble			; 90 - Large green gas bubble
	.DW Chucks				; 91 - Chargin' Chuck
	.DW Chucks				; 92 - Splittin' Chuck
	.DW Chucks				; 93 - Bouncin' Chuck
	.DW Chucks				; 94 - Whistlin' Chuck
	.DW Chucks				; 95 - Clapin' Chuck
	.DW Chucks				; 96 - Unused (Chargin' Chuck clone)
	.DW Chucks				; 97 - Puntin' Chuck
	.DW Chucks				; 98 - Pitchin' Chuck
	.DW VolcanoLotus		; 99 - Volcano Lotus
	.DW SumoBrother			; 9A - Sumo Brother
	.DW HammerBrother		; 9B - Hammer Brother
	.DW FlyingPlatform		; 9C - Flying blocks for Hammer Brother
	.DW BubbleWithSprite	; 9D - Bubble with sprite
	.DW BanzaiBnCGrayPlat	; 9E - Ball and Chain
	.DW BanzaiBnCGrayPlat	; 9F - Banzai Bill
	.DW Bank3SprHandler		; A0 - Activates Bowser scene
	.DW Bank3SprHandler		; A1 - Bowser's bowling ball
	.DW Bank3SprHandler		; A2 - MechaKoopa
	.DW BanzaiBnCGrayPlat	; A3 - Grey platform on chain
	.DW FloatingSpikeBall	; A4 - Floating Spike ball
	.DW WallFollowers		; A5 - Fuzzball/Sparky, ground-guided
	.DW WallFollowers		; A6 - HotHead, ground-guided
	.DW IggysBall			; A7 - Iggy's ball
	.DW Bank3SprHandler		; A8 - Blargg
	.DW Bank3SprHandler		; A9 - Reznor
	.DW Bank3SprHandler		; AA - Fishbone
	.DW Bank3SprHandler		; AB - Rex
	.DW Bank3SprHandler		; AC - Wooden Spike, moving down and up
	.DW Bank3SprHandler		; AD - Wooden Spike, moving up/down first
	.DW Bank3SprHandler		; AE - Fishin' Boo
	.DW BooBooBlock			; AF - Boo Block
	.DW Bank3SprHandler		; B0 - Reflecting stream of Boo Buddies
	.DW Bank3SprHandler		; B1 - Creating/Eating block
	.DW Bank3SprHandler		; B2 - Falling Spike
	.DW Bank3SprHandler		; B3 - Bowser statue fireball
	.DW Grinder				; B4 - Grinder, non-line-guided
	.DW Fireballs			; B5 - Sinking fireball used in boss battles
	.DW Bank3SprHandler		; B6 - Reflecting fireball
	.DW Bank3SprHandler		; B7 - Carrot Top lift, upper right
	.DW Bank3SprHandler		; B8 - Carrot Top lift, upper left
	.DW Bank3SprHandler		; B9 - Info Box
	.DW Bank3SprHandler		; BA - Timed lift
	.DW Bank3SprHandler		; BB - Grey moving castle block
	.DW Bank3SprHandler		; BC - Bowser statue
	.DW Bank3SprHandler		; BD - Sliding Koopa without a shell
	.DW Bank3SprHandler		; BE - Swooper bat
	.DW Bank3SprHandler		; BF - Mega Mole
	.DW Bank3SprHandler		; C0 - Grey platform on lava
	.DW Bank3SprHandler		; C1 - Flying grey turnblocks
	.DW Bank3SprHandler		; C2 - Blurp fish
	.DW Bank3SprHandler		; C3 - Porcu-Puffer fish
	.DW Bank3SprHandler		; C4 - Grey platform that falls
	.DW Bank3SprHandler		; C5 - Big Boo Boss
	.DW Bank3SprHandler		; C6 - Dark room with spot light
	.DW Bank3SprHandler		; C7 - Invisible mushroom
	.DW Bank3SprHandler		; C8 - Light switch block for dark room 

InvisSolidDinos:
	JSL InvisBlkDinosMain
	RTS

GoalSphere:
	JSR SubSprGfx2Entry1
	LDA wm_SpritesLocked
	BNE +
	LDA wm_FrameA
	AND #$1F
	ORA wm_SpritesLocked
	JSR _01B152
	JSR MarioSprInteractRt
	BCC +
	STZ wm_SpriteStatus,X
	LDA #$FF
	STA wm_EndLevelTimer
	STA wm_LevelMusicMod
	LDA #$0B
	STA wm_MusicCh1
+	RTS

InitReznor:
	JSL ReznorInit
	RTS

Bank3SprHandler:
	JSL Bnk3CallSprMain
	RTS

BanzaiBnCGrayPlat:
	JSL BanzaiRotating
	RTS

BubbleWithSprite:
	JSL BubbleSpriteMain
	RTS

HammerBrother:
	JSL HammerBrotherMain
	RTS

FlyingPlatform:
	JSL FlyingPlatformMain
	RTS

InitHammerBrother:
	JSL _Return02DA59 ; may as well omit this
	RTS

VolcanoLotus:
	JSL VolcanoLotusMain
	RTS

SumoBrother:
	JSL SumoBrotherMain
	RTS

SumosLightning:
	JSL SumosLightningMain
	RTS

JumpingPiranha:
	JSL JumpingPiranhaMain
	RTS

GasBubble:
	JSL GasBubbleMain
	RTS

Unused0187C5:
	JSL SumoBrotherMain
	RTS

DirectionalCoins:
	JSL DirectionCoinsMain
	RTS

ExplodingBlock:
	JSL ExplodingBlkMain
	RTS

ScalePlatforms:
	JSL ScalePlatformMain
	RTS

InitFloatingSkull:
	JSL FloatingSkullInit
	RTS

FloatingSkulls:
	JSL FloatingSkullMain
	RTS

GhostHouseExit:
	JSL GhostExitMain
	RTS

WarpBlocks:
	JSL WarpBlocksMain
	RTS

Pokey:
	JSL PokeyMain
	RTS

RedSuperKoopa:
	JSL SuperKoopaMain
	RTS

YellowSuperKoopa:
	JSL SuperKoopaMain
	RTS

FeatherSuperKoopa:
	JSL SuperKoopaMain
	RTS

PipeLakitu:
	JSL PipeLakituMain
	RTS

DigginChuck:
	JSL ChucksMain
	RTS

SwimJumpFish:
	JSL SwimJumpFishMain
	RTS

DigginChucksRock:
	JSL ChucksRockMain
	RTS

GrowingPipe:
	JSL GrowingPipeMain
	RTS

YoshisHouseBirds:
	JSL BirdsMain
	RTS

YoshisHouseSmoke:
	JSL SmokeMain
	RTS

SideExit:
	JSL SideExitMain
	RTS

InitWiggler:
	JSL WigglerInit
	RTS

Wiggler:
	JSL WigglerMain
	RTS

CoinCloud:
	JSL CoinCloudMain
	RTS

TorpedoTed:
	JSL TorpedoTedMain
	RTS

Layer3Smash:
	PHB
	LDA #:Layer3SmashMain
	PHA
	PLB
	JSL Layer3SmashMain
	PLB
	RTS

PeaBouncer:
	PHB
	LDA #:PeaBouncerMain
	PHA
	PLB
	JSL PeaBouncerMain
	PLB
	RTS

RipVanFish:
	PHB
	LDA #:RipVanFishMain
	PHA
	PLB
	JSL RipVanFishMain
	PLB
	RTS

WallFollowers:
	PHB
	LDA #:WallFollowersMain
	PHA
	PLB
	JSL WallFollowersMain
	PLB
	RTS

Return018869:
	RTS

Chucks:
	JSL ChucksMain
	RTS

InitWingedCage:
	PHB
	LDA #:Return02CBFD
	PHA
	PLB
	JSL Return02CBFD
	PLB
	RTS

WingedCage:
	PHB
	LDA #:WingedCageMain
	PHA
	PLB
	JSL WingedCageMain
	PLB
	RTS

Dolphin:
	PHB
	LDA #:DolphinMain
	PHA
	PLB
	JSL DolphinMain
	PLB
	RTS

InitMovingLedge:
	DEC wm_SpriteYLo,X
	RTS

MovingLedge:
	JSL MovingLedgeMain
	RTS

JumpOverShells:
	TXA
	EOR wm_FrameA
	AND #$03
	BNE +
	LDY #$09
-	LDA wm_SpriteStatus,Y
	CMP #$0A
	BEQ HandleJumpOver
_JumpLoopNext:
	DEY
	BPL -
+	RTS

HandleJumpOver:
	LDA.W wm_SpriteXLo,Y
	SEC
	SBC #$1A
	STA m0
	LDA wm_SpriteXHi,Y
	SBC #$00
	STA m8
	LDA #$44
	STA m2
	LDA.W wm_SpriteYLo,Y
	STA m1
	LDA wm_SpriteYHi,Y
	STA m9
	LDA #$10
	STA m3
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC _JumpLoopNext
	JSR IsOnGround
	BEQ _JumpLoopNext
	LDA wm_SpriteDir,Y
	CMP wm_SpriteDir,X
	BEQ +
	LDA #$C0
	STA wm_SpriteSpeedY,X
	STZ wm_SpriteDecTbl6,X
+	RTS

Spr0to13SpeedX:	.DB 8,-8,12,-12

Spr0to13Prop:
	.DB $00,$02,$03,$0D,$40,$42,$43,$45
	.DB $50,$50,$50,$5C,$DD,$05,$00,$20
	.DB $20,$00,$00,$00

ShellessKoopas:
	LDA wm_SpritesLocked
	BEQ CODE_018952
_018908:
	LDA wm_SpriteDecTbl6,X
	CMP #$80
	BCC +
	LDA wm_SpritesLocked
	BNE +
_018913:
	JSR SetAnimationFrame
	LDA wm_SpriteGfxTbl,X
	CLC
	ADC #$05
	STA wm_SpriteGfxTbl,X
+	JSR CODE_018931
	JSR SubUpdateSprPos
	STZ wm_SpriteSpeedX,X
	JSR IsOnGround
	BEQ +
	STZ wm_SpriteSpeedY,X
+	JMP _018B03

CODE_018931:
	LDA wm_SpriteNum,X
	CMP #$02
	BNE CODE_01893C
	JSR MarioSprInteractRt
	BRA _Return018951

CODE_01893C:
	ASL wm_Tweaker167A,X
	SEC
	ROR wm_Tweaker167A,X
	JSR MarioSprInteractRt
	BCC +
	JSR CODE_01B12A
+	ASL wm_Tweaker167A,X
	LSR wm_Tweaker167A,X
_Return018951:
	RTS

CODE_018952:
	LDA wm_SpriteDecTbl6,X
	BEQ +++
	CMP #$80
	BNE ++
	JSR _FaceMario
	LDA wm_SpriteNum,X
	CMP #$02
	BEQ +
	LDA #$E0
	STA wm_SpriteSpeedY,X
+	STZ wm_SpriteDecTbl6,X
++	CMP #$01
	BNE _018908
	LDY wm_SpriteMiscTbl8,X
	LDA wm_SpriteStatus,Y
	CMP #$09
	BNE _018908
	LDA wm_SpriteXLo,X
	SEC
	SBC.W wm_SpriteXLo,Y
	CLC
	ADC #$12
	CMP #$24
	BCS _018908
	JSR PlayKickSfx
	JSR _01A755
	LDY wm_SpriteDir,X
	LDA DATA_01A6D7,Y
	LDY wm_SpriteMiscTbl8,X
	STA.W wm_SpriteSpeedX,Y
	LDA #$0A
	STA wm_SpriteStatus,Y
	LDA wm_SpriteDecTbl1,Y
	STA.W wm_SpriteState,Y
	LDA #$08
	STA wm_SpriteDecTbl4,Y
	LDA wm_Tweaker167A,Y
	AND #$10
	BEQ +++
	LDA #$E0
	STA.W wm_SpriteSpeedY,Y
+++	LDA wm_SpriteMiscTbl4,X
	BEQ CODE_018A15
	JSR IsTouchingObjSide
	BEQ +
	STZ wm_SpriteSpeedX,X
+	JSR IsOnGround
	BEQ ++
	LDA wm_IsSlipperyLevel
	CMP #$01
	LDA #$02
	BCC +
	LSR
+	STA m0
	LDA wm_SpriteSpeedX,X
	CMP #$02
	BCC CODE_0189FD
	BPL +
	CLC
	ADC m0
	CLC
	ADC m0
+	SEC
	SBC m0
	STA wm_SpriteSpeedX,X
	JSR CODE_01804E
++	STZ wm_SpriteMiscTbl6,X
	JSR _018B43
	LDA #$E6
	LDY wm_SpriteNum,X
	CPY #$02
	BEQ +
	LDA #$86
+	LDY wm_SprOAMIndex,X
	STA wm_OamSlot.1.Tile,Y
	RTS

CODE_0189FD:
	JSR IsOnGround
	BEQ ++
	LDA #$FF
	LDY wm_SpriteNum,X
	CPY #$02
	BNE +
	LDA #$A0
+	STA wm_SpriteDecTbl6,X
++	STZ wm_SpriteMiscTbl4,X
	JMP _018913

CODE_018A15:
	LDA wm_SpriteMiscTbl5,X
	BEQ _018A88
	LDY wm_SpriteMiscTbl8,X
	LDA wm_SpriteStatus,Y
	CMP #$0A
	BEQ CODE_018A29
	STZ wm_SpriteMiscTbl5,X
	BRA _018A62

CODE_018A29:
	STA wm_SpriteMiscTbl4,Y
	JSR IsTouchingObjSide
	BEQ +
	LDA #$00
	STA.W wm_SpriteSpeedX,Y
	STA wm_SpriteSpeedX,X
+	JSR IsOnGround
	BEQ _018A62
	LDA wm_IsSlipperyLevel
	CMP #$01
	LDA #$02
	BCC +
	LSR
+	STA m0
	LDA.W wm_SpriteSpeedX,Y
	CMP #$02
	BCC CODE_018A69
	BPL +
	CLC
	ADC m0
	CLC
	ADC m0
+	SEC
	SBC m0
	STA.W wm_SpriteSpeedX,Y
	STA wm_SpriteSpeedX,X
	JSR CODE_01804E
_018A62:
	STZ wm_SpriteMiscTbl6,X
	JSR _018B43
	RTS

CODE_018A69:
	LDA #$00
	STA wm_SpriteSpeedX,X
	STA.W wm_SpriteSpeedX,Y
	STZ wm_SpriteMiscTbl5,X
	LDA #$09
	STA wm_SpriteStatus,Y
	PHX
	TYX
	JSR _01AA0B
	LDA wm_SpriteDecTbl1,X
	BEQ +
	LDA #$FF
	STA wm_SpriteDecTbl1,X
+	PLX
_018A88:
	LDA wm_SpriteState,X
	BEQ CODE_018A9B
	DEC wm_SpriteState,X
	CMP #$08
	LDA #$04
	BCS +
	LDA #$00
+	STA wm_SpriteGfxTbl,X
	BRA _018B00

CODE_018A9B:
	LDA wm_SpriteDecTbl3,X
	CMP #$01
	BNE Spr0to13Main
	LDY wm_SpriteMiscTbl7,X
	LDA wm_SpriteStatus,Y
	CMP #$08
	BCC +
	LDA.W wm_SpriteSpeedY,Y
	BMI +
	LDA.W wm_SpriteNum,Y
	CMP #$21
	BEQ +
	JSL GetSpriteClippingA
	PHX
	TYX
	JSL GetSpriteClippingB
	PLX
	JSL CheckForContact
	BCC +
	JSR _OffScrEraseSprite
	LDY wm_SpriteMiscTbl7,X
	LDA #$10
	STA wm_SpriteDecTbl3,Y
	LDA wm_SpriteNum,X
	STA wm_SpriteMiscTbl8,Y
+	RTS

ExplodeBomb:
	PHB
	LDA #:ExplodeBombRt
	PHA
	PLB
	JSL ExplodeBombRt
	PLB
	RTS

Bobomb:
	LDA wm_SpriteMiscTbl5,X
	BNE ExplodeBomb
	LDA wm_SpriteDecTbl1,X
	BNE Spr0to13Start
	LDA #$09
	STA wm_SpriteStatus,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	JMP SubSprGfx2Entry1

Spr0to13Start:
	LDA wm_SpritesLocked
	BEQ Spr0to13Main
_018B00:
	JSR MarioSprInteractRt
_018B03:
	JSR SubSprSprInteract
	JSR _Spr0to13Gfx
	RTS

Spr0to13Main:
	JSR IsOnGround
	BEQ ++
	LDY wm_SpriteNum,X
	LDA Spr0to13Prop,Y
	LSR
	LDY wm_SpriteDir,X
	BCC +
	INY
	INY
+	LDA Spr0to13SpeedX,Y
	EOR wm_SpriteSlopeTbl,X
	ASL
	LDA Spr0to13SpeedX,Y
	BCC +
	CLC
	ADC wm_SpriteSlopeTbl,X
+	STA wm_SpriteSpeedX,X
++	LDY wm_SpriteDir,X
	TYA
	INC A
	AND wm_SprObjStatus,X
	AND #$03
	BEQ +
	STZ wm_SpriteSpeedX,X
+	JSR IsTouchingCeiling
	BEQ _018B43
	STZ wm_SpriteSpeedY,X
_018B43:
	JSR SubOffscreen0Bnk1
	JSR SubUpdateSprPos
	JSR SetAnimationFrame
	JSR IsOnGround
	BEQ SpriteInAir
	JSR SetSomeYSpeed
	STZ wm_SpriteMiscTbl3,X
	LDY wm_SpriteNum,X
	LDA Spr0to13Prop,Y
	PHA
	AND #$04
	BEQ +
	LDA wm_SpriteMiscTbl6,X
	AND #$7F
	BNE +
	LDA wm_SpriteDir,X
	PHA
	JSR _FaceMario
	PLA
	CMP wm_SpriteDir,X
	BEQ +
	LDA #$08
	STA wm_SpriteDecTbl5,X
+	PLA
	AND #$08
	BEQ +
	JSR JumpOverShells
+	BRA _018BB0

SpriteInAir:
	LDY wm_SpriteNum,X
	LDA Spr0to13Prop,Y
	BPL CODE_018B90
	JSR SetAnimationFrame
	BRA _018B93

CODE_018B90:
	STZ wm_SpriteMiscTbl6,X
_018B93:
	LDA Spr0to13Prop,Y
	AND #$02
	BEQ _018BB0
	LDA wm_SpriteMiscTbl3,X
	ORA wm_SpriteDecTbl3,X
	ORA wm_SpriteMiscTbl4,X
	ORA wm_SpriteMiscTbl5,X
	BNE _018BB0
	JSR FlipSpriteDir
	LDA #$01
	STA wm_SpriteMiscTbl3,X
_018BB0:
	LDA wm_SpriteMiscTbl4,X
	BEQ CODE_018BBA
	JSR CODE_018931
	BRA _018BBD

CODE_018BBA:
	JSR MarioSprInteractRt
_018BBD:
	JSR SubSprSprInteract
	JSR FlipIfTouchingObj
_Spr0to13Gfx:
	LDA wm_SpriteDir,X
	PHA
	LDY wm_SpriteDecTbl5,X
	BEQ ++
	LDA #$02
	STA wm_SpriteGfxTbl,X
	LDA #$00
	CPY #$05
	BCC +
	INC A
+	EOR wm_SpriteDir,X
	STA wm_SpriteDir,X
++	LDY wm_SpriteNum,X
	LDA Spr0to13Prop,Y
	AND #$40
	BNE CODE_018BEC
	JSR SubSprGfx2Entry1
	BRA _DoneWithSprite

CODE_018BEC:
	LDA wm_SpriteGfxTbl,X
	LSR
	LDA wm_SpriteYLo,X
	PHA
	SBC #$0F
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	SBC #$00
	STA wm_SpriteYHi,X
	JSR SubSprGfx1
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	LDA wm_SpriteNum,X
	CMP #$08
	BCC _DoneWithSprite
	JSR KoopaWingGfxRt
_DoneWithSprite:
	PLA
	STA wm_SpriteDir,X
	RTS

SpinyEgg:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteStatus,X
	CMP #$08
	BNE ++
	JSR SetAnimationFrame
	JSR SubUpdateSprPos
	DEC wm_SpriteSpeedY,X
	JSR IsOnGround
	BEQ +
	LDA #$13
	STA wm_SpriteNum,X
	JSL InitSpriteTables
	JSR _FaceMario
	JSR CODE_0197D5
+	JSR FlipIfTouchingObj
	JSR _SubSprSprMarioSpr
++	JSR SubOffscreen0Bnk1
	LDA #$02
	JSR SubSprGfx0Entry0
	RTS

GreenParaKoopa:
	LDA wm_SpritesLocked
	BNE _018CB7
	LDY wm_SpriteDir,X
	LDA Spr0to13SpeedX,Y
	EOR wm_SpriteSlopeTbl,X
	ASL
	LDA Spr0to13SpeedX,Y
	BCC +
	CLC
	ADC wm_SpriteSlopeTbl,X
+	STA wm_SpriteSpeedX,X
	TYA
	INC A
	AND wm_SprObjStatus,X
	AND #$03
	BEQ +
	STZ wm_SpriteSpeedX,X
+	LDA wm_SpriteNum,X
	CMP #$08
	BNE CODE_018C8C
	JSR SubSprXPosNoGrvty
	LDY #$FC
	LDA wm_SpriteMiscTbl6,X
	AND #$20
	BEQ +
	LDY #$04
+	STY wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
	BRA _018C91

CODE_018C8C:
	JSR SubUpdateSprPos
	DEC wm_SpriteSpeedY,X
_018C91:
	JSR _SubSprSprMarioSpr
	JSR IsTouchingCeiling
	BEQ +
	STZ wm_SpriteSpeedY,X
+	JSR IsOnGround
	BEQ ++
	JSR SetSomeYSpeed
	LDA #$D0
	LDY wm_SpriteMiscTbl8,X
	BNE +
	LDA #$B0
+	STA wm_SpriteSpeedY,X
++	JSR FlipIfTouchingObj
	JSR SetAnimationFrame
	JSR SubOffscreen0Bnk1
_018CB7:
	JMP _Spr0to13Gfx

DATA_018CBA:	.DB -1,1

DATA_018CBC:	.DB -16,16

RedHorzParaKoopa:
	JSR SubOffscreen1Bnk1
	BRA _018CC6

RedVertParaKoopa:
	JSR SubOffscreen0Bnk1
_018CC6:
	LDA wm_SpritesLocked
	BNE _018D2A
	LDA wm_SpriteDir,X
	PHA
	JSR UpdateDirection
	PLA
	CMP wm_SpriteDir,X
	BEQ +
	LDA #$08
	STA wm_SpriteDecTbl5,X
+	JSR SetAnimationFrame
	LDA wm_SpriteNum,X
	CMP #$0A
	BNE CODE_018CEA
	JSR SubSprYPosNoGrvty
	BRA _018CFD

CODE_018CEA:
	LDY #$FC
	LDA wm_SpriteMiscTbl6,X
	AND #$20
	BEQ +
	LDY #$04
+	STY wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
	JSR SubSprXPosNoGrvty
_018CFD:
	LDA wm_SpriteDecTbl1,X
	BNE +
	INC wm_SpriteState,X
	LDA wm_SpriteState,X
	AND #$03
	BNE +
	LDA wm_SpriteMiscTbl3,X
	AND #$01
	TAY
	LDA wm_SpriteSpeedX,X
	CLC
	ADC DATA_018CBA,Y
	STA wm_SpriteSpeedY,X
	STA wm_SpriteSpeedX,X
	CMP DATA_018CBC,Y
	BNE +
	INC wm_SpriteMiscTbl3,X
	LDA #$30
	STA wm_SpriteDecTbl1,X
+	JSR _SubSprSprMarioSpr
_018D2A:
	JSR _018CB7
	RTS

WingedGoomba:
	JSR SubOffscreen0Bnk1
	LDA wm_SpritesLocked
	BEQ CODE_018D39
	JSR CODE_018DAC
	RTS

CODE_018D39:
	JSR CODE_018DBB
	JSR SubUpdateSprPos
	DEC wm_SpriteSpeedY,X
	LDA wm_SpriteState,X
	LSR
	LSR
	LSR
	AND #$01
	STA wm_SpriteGfxTbl,X
	JSR CODE_018DAC
	INC wm_SpriteState,X
	LDA wm_SpriteMiscTbl3,X
	BNE +
	LDA wm_SpriteSpeedY,X
	BPL +
	INC wm_SpriteMiscTbl6,X
	INC wm_SpriteMiscTbl6,X
+	INC wm_SpriteMiscTbl6,X
	JSR IsTouchingCeiling
	BEQ +
	STZ wm_SpriteSpeedY,X
+	JSR IsOnGround
	BEQ ++
	LDA wm_SpriteState,X
	AND #$3F
	BNE +
	JSR _FaceMario
+	JSR SetSomeYSpeed
	LDA wm_SpriteMiscTbl3,X
	BNE +
	STZ wm_SpriteMiscTbl6,X
+	LDA wm_SpriteDecTbl1,X
	BNE ++
	INC wm_SpriteMiscTbl3,X
	LDY #$F0
	LDA wm_SpriteMiscTbl3,X
	CMP #$04
	BNE +
	STZ wm_SpriteMiscTbl3,X
	JSL GetRand
	AND #$3F
	ORA #$50
	STA wm_SpriteDecTbl1,X
	LDY #$D0
+	STY wm_SpriteSpeedY,X
++	JSR FlipIfTouchingObj
	JSR _SubSprSprMarioSpr
	RTS

CODE_018DAC:
	JSR GoombaWingGfxRt
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	JMP SubSprGfx2Entry1

CODE_018DBB:
	LDA #$F8
	LDY wm_SpriteDir,X
	BNE +
	LDA #$08
+	STA wm_SpriteSpeedX,X
	RTS

DATA_018DC7:
	.DB $F7,$0B,$F6,$0D,$FD,$0C,$FC,$0D
	.DB $0B,$F5,$0A,$F3,$0B,$FC,$0C,$FB

DATA_018DD7:	.DB $F7,$F7,$F8,$F8,$01,$01,$02,$02

GoombaWingGfxProp:	.DB $46,$06

GoombaWingTiles:	.DB $C6,$C6,$5D,$5D

GoombaWingTileSize:	.DB $02,$02,$00,$00

GoombaWingGfxRt:
	JSR GetDrawInfoBnk1
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	AND #$02
	CLC
	ADC wm_SpriteGfxTbl,X
	STA m5
	ASL
	STA m2
	LDA wm_SpriteDir,X
	STA m4
	LDY wm_SprOAMIndex,X
	PHX
	LDX #$01
-	STX m3
	TXA
	CLC
	ADC m2
	PHA
	LDX m4
	BNE +
	CLC
	ADC #$08
+	TAX
	LDA m0
	CLC
	ADC.W DATA_018DC7,X
	STA wm_OamSlot.1.XPos,Y
	PLX
	LDA m1
	CLC
	ADC.W DATA_018DD7,X
	STA wm_OamSlot.1.YPos,Y
	LDX m5
	LDA.W GoombaWingTiles,X
	STA wm_OamSlot.1.Tile,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.W GoombaWingTileSize,X
	STA wm_OamSize.1,Y
	PLY
	LDX m3
	LDA m4
	LSR
	LDA.W GoombaWingGfxProp,X
	BCS +
	EOR #$40
+	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	TYA
	CLC
	ADC #$08
	TAY
	DEX
	BPL -
	PLX
	LDY #$FF
	LDA #$02
	JSR FinishOAMWriteRt
	RTS

SetAnimationFrame:
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	LSR
	AND #$01
	STA wm_SpriteGfxTbl,X
	RTS

PiranhaSpeed:	.DB 0,-16,0,16

PiranTimeInState:	.DB 32,48,32,48

ClassicPiranhas:
	LDA wm_SpriteMiscTbl7,X
	BNE ++
	LDA wm_SpriteProp
	PHA
	LDA wm_SpriteEatenTbl,X
	BNE +
	LDA #$10
	STA wm_SpriteProp
+	JSR SubSprGfx1
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.3.Prop,Y ; BUG-FIX: ID 001-00
	AND #$F1
	ORA #$0B
	STA wm_OamSlot.3.Prop,Y
	PLA
	STA wm_SpriteProp
++	JSR SubOffscreen0Bnk1
	LDA wm_SpritesLocked
	BNE ++
	JSR SetAnimationFrame
	LDA wm_SpriteMiscTbl7,X
	BNE +
	JSR _SubSprSprMarioSpr
+	LDA wm_SpriteState,X
	AND #$03
	TAY
	LDA wm_SpriteDecTbl1,X
	BEQ ChangePiranhaState
	LDA PiranhaSpeed,Y
	LDY wm_SpriteNum,X
	CPY #$2A
	BNE +
	EOR #$FF
	INC A
+	STA wm_SpriteSpeedY,X
	JSR SubSprYPosNoGrvty
++	RTS

ChangePiranhaState:
	LDA wm_SpriteState,X
	AND #$03
	STA m0
	BNE +
	JSR SubHorizPos
	LDA m15
	CLC
	ADC #$1B
	CMP #$37
	LDA #$01
	STA wm_SpriteMiscTbl7,X
	BCC ++
+	STZ wm_SpriteMiscTbl7,X
	LDY m0
	LDA PiranTimeInState,Y
	STA wm_SpriteDecTbl1,X
	INC wm_SpriteState,X
++	RTS

CODE_018EEF:
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_018F07
	DEY
	BPL -
	DEC wm_AltExSprIndex
	BPL +
	LDA #$07
	STA wm_AltExSprIndex
+	LDY wm_AltExSprIndex
_Return018F06:
	RTS

CODE_018F07:
	LDA wm_OffscreenHorz,X
	BNE _Return018F06 ; return or return??
	RTS

HoppingFlame:
	LDA wm_SpritesLocked
	BNE _018F49
	INC wm_SpriteGfxTbl,X
	JSR SetAnimationFrame
	JSR SubUpdateSprPos
	DEC wm_SpriteSpeedY,X
	JSR CODE_018DBB
	ASL wm_SpriteSpeedX,X
	JSR IsOnGround
	BEQ _018F43
	STZ wm_SpriteSpeedX,X
	JSR SetSomeYSpeed
	LDA wm_SpriteDecTbl1,X
	BEQ CODE_018F38
	DEC A
	BNE _018F43
	JSR CODE_018F50
	BRA _018F43

CODE_018F38:
	JSL GetRand
	AND #$1F
	ORA #$20
	STA wm_SpriteDecTbl1,X
_018F43:
	JSR FlipIfTouchingObj
	JSR MarioSprInteractRt
_018F49:
	JSR SubOffscreen0Bnk1
	JSR SubSprGfx2Entry1
	RTS

CODE_018F50:
	JSL GetRand
	AND #$0F
	ORA #$D0
	STA wm_SpriteSpeedY,X
	LDA wm_RandomByte1
	AND #$03
	BNE +
	JSR _FaceMario
+	JSR IsSprOffScreen
	BNE +
	JSR CODE_018EEF
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_ExSpriteYHi,Y
	LDA #$03
	STA wm_ExSpriteNum,Y
	LDA #$FF
	STA wm_ExSpriteTbl2,Y
+	RTS

Lakitu:
	LDY #$00
	LDA wm_SpriteDecTbl3,X
	BEQ +
	LDY #$02
+	TYA
	STA wm_SpriteGfxTbl,X
	JSR SubSprGfx1
	LDA wm_SpriteDecTbl3,X
	BEQ +
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.2.YPos,Y
	SEC
	SBC #$03
	STA wm_OamSlot.2.YPos,Y
+	LDA wm_SpriteMiscTbl3,X
	BEQ _SubSprSprMarioSpr
	JSL CODE_02E672
_SubSprSprMarioSpr:
	JSR SubSprSprInteract
	JMP MarioSprInteractRt

BulletGfxProp:	.DB $42,$02,$03,$83,$03,$43,$03,$43

DATA_018FCF:	.DB 0,0,1,1,2,3,3,2

BulletSpeedX:	.DB 32,-32,0,0,24,24,-24,-24

BulletSpeedY:	.DB 0,0,-32,32,-24,24,24,-24

BulletBill:
	LDA #$01
	STA wm_SpriteDir,X
	LDA wm_SpritesLocked
	BNE +
	LDY wm_SpriteState,X
	LDA BulletGfxProp,Y
	STA wm_SpritePal,X
	LDA DATA_018FCF,Y
	STA wm_SpriteGfxTbl,X
	LDA BulletSpeedX,Y
	STA wm_SpriteSpeedX,X
	LDA BulletSpeedY,Y
	STA wm_SpriteSpeedY,X
	JSR SubSprXPosNoGrvty
	JSR SubSprYPosNoGrvty
	JSR CODE_019140
	JSR _SubSprSprMarioSpr
+	JSR SubOffscreen0Bnk1
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	CMP #$F0
	BCC +
	STZ wm_SpriteStatus,X
+	LDA wm_SpriteDecTbl1,X
	BEQ CODE_01902B
	JMP _019546

CODE_01902B:
	JMP SubSprGfx2Entry1

DATA_01902E:	.DB 64,16

DATA_019030:	.DB 3,1

SubUpdateSprPos:
	JSR SubSprYPosNoGrvty
	LDY #$00
	LDA wm_SprInWaterTbl,X
	BEQ +
	INY
	LDA wm_SpriteSpeedY,X
	BPL +
	CMP #$E8
	BCS +
	LDA #$E8
	STA wm_SpriteSpeedY,X
+	LDA wm_SpriteSpeedY,X
	CLC
	ADC DATA_019030,Y
	STA wm_SpriteSpeedY,X
	BMI +
	CMP DATA_01902E,Y
	BCC +
	LDA DATA_01902E,Y
	STA wm_SpriteSpeedY,X
+	LDA wm_SpriteSpeedX,X
	PHA
	LDY wm_SprInWaterTbl,X
	BEQ +
	ASL
	ROR wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedX,X
	PHA
	STA m0
	ASL
	ROR m0
	PLA
	CLC
	ADC m0
	STA wm_SpriteSpeedX,X
+	JSR SubSprXPosNoGrvty
	PLA
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteInterTbl,X
	BNE ADDR_019085
	JSR CODE_019140
	RTS

ADDR_019085:
	STZ wm_SprObjStatus,X
	RTS

FlipIfTouchingObj:
	LDA wm_SpriteDir,X
	INC A
	AND wm_SprObjStatus,X
	AND #$03
	BEQ +
	JSR FlipSpriteDir
+	RTS

FlipSpriteDir:
	LDA wm_SpriteDecTbl5,X
	BNE +
	LDA #$08
	STA wm_SpriteDecTbl5,X
_0190A2:
	LDA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA wm_SpriteSpeedX,X
	LDA wm_SpriteDir,X
	EOR #$01
	STA wm_SpriteDir,X
+	RTS

GenericSprGfxRt2:
	PHB
	PHK
	PLB
	JSR SubSprGfx2Entry1
	PLB
	RTL

SpriteObjClippingX:
	.DB 14,2,8,8,14,2,7,7
	.DB 7,7,7,7,14,2,8,8
	.DB 16,0,8,8,13,2,8,8
	.DB 7,0,4,4,31,1,16,16
	.DB 15,0,8,8,16,0,8,8
	.DB 13,2,8,8,14,2,8,8
	.DB 13,2,8,8,16,0,8,8
	.DB 31,0,16,16,8

SpriteObjClippingY:
	.DB 8,8,16,2,18,18,32,2
	.DB 7,7,7,7,16,16,32,11
	.DB 18,18,32,2,24,24,32,16
	.DB 4,4,8,0,16,16,31,1
	.DB 8,8,15,0,8,8,16,0
	.DB 72,72,80,66,4,4,8,0
	.DB 0,0,0,0,8,8,16,0
	.DB 8,8,16,0,4

DATA_019134:	.DB $01,$02,$04,$08

CODE_019138:
	PHB
	PHK
	PLB
	JSR CODE_019140
	PLB
	RTL

CODE_019140:
	STZ wm_SprMoveDownPixels
	STZ wm_SprObjStatus,X
	STZ wm_SpriteSlopeTbl,X
	STZ wm_TempTileGen
	LDA wm_SprInWaterTbl,X
	STA wm_CheckSprInter
	STZ wm_SprInWaterTbl,X
	JSR CODE_019211
	LDA wm_IsVerticalLvl
	BPL ++
	INC wm_TempTileGen
	LDA wm_SpriteXLo,X
	CLC
	ADC wm_26
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC wm_27
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	CLC
	ADC wm_28
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	ADC wm_29
	STA wm_SpriteYHi,X
	JSR CODE_019211
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_26
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	SBC wm_27
	STA wm_SpriteXHi,X
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_28
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC wm_29
	STA wm_SpriteYHi,X
	LDA wm_SprObjStatus,X
	BPL ++
	AND #$03
	BNE ++
	LDY #$00
	LDA wm_L2CurXChange
	EOR #$FF
	INC A
	BPL +
	DEY
+	CLC
	ADC wm_SpriteXLo,X
	STA wm_SpriteXLo,X
	TYA
	ADC wm_SpriteXHi,X
	STA wm_SpriteXHi,X
++	LDA wm_Tweaker190F,X
	BPL +
	LDA wm_SprObjStatus,X
	AND #$03
	BEQ +
	TAY
	LDA wm_SpriteEatenTbl,X
	BNE +
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_019284-1,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC DATA_019285-1,Y
	STA wm_SpriteXHi,X
	LDA wm_SpriteSpeedX,X
	BNE +
	LDA wm_SprObjStatus,X
	AND #$FC
	STA wm_SprObjStatus,X
+	LDA wm_SprInWaterTbl,X
	EOR wm_CheckSprInter
	BEQ _Return019210
	ASL
	LDA wm_Tweaker166E,X
	AND #$40
	ORA wm_DisSprCapeContact,X
	BNE _Return019210
	BCS CODE_01920C
	BIT wm_LevelMode
	BMI CODE_01920C
	JSL CODE_0284C0
	RTS

CODE_01920C:
	JSL CODE_028528
_Return019210:
	RTS

CODE_019211:
	LDA wm_SpriteBuoyancy
	BEQ _01925B
	LDA wm_IsWaterLevel
	BNE _019258
	LDY #$3C
	JSR _01944D
	BEQ CODE_019233
	LDA wm_Map16NumLo
	CMP #$6E
	BCC _01925B
	JSL CODE_00F04D
	LDA wm_Map16NumLo
	BCC _01925B
	BCS _01923A ; [BRA FIX]

CODE_019233:
	LDA wm_Map16NumLo
	CMP #$06
	BCS _01925B
_01923A:
	TAY
	LDA wm_SprInWaterTbl,X
	ORA #$01
	CPY #$04
	BNE _019258
	PHA
	LDA wm_SpriteNum,X
	CMP #$35
	BEQ +
	LDA wm_Tweaker167A,X
	AND #$02
	BNE ++
+	JSR _019330
++	PLA
	ORA #$80
_019258:
	STA wm_SprInWaterTbl,X
_01925B:
	LDA wm_Tweaker1686,X
	BMI _Return019210
	LDA wm_TempTileGen
	BEQ +
	BIT wm_SpriteBuoyancy
	BVS _Return0192C0
	LDA wm_Tweaker166E,X
	BMI _Return0192C0
+	JSR CODE_0192C9
	LDA wm_Tweaker190F,X
	BPL CODE_019288
	LDA wm_SpriteSpeedX,X
	ORA wm_SpriteDecTbl5,X
	BNE CODE_019288
	LDA wm_FrameA
	JSR _01928E
	RTS

DATA_019284:	.DB -4,4

DATA_019285:	.DB -1,0

CODE_019288:
	LDA wm_SpriteSpeedX,X
	BEQ _Return0192C0
	ASL
	ROL
_01928E:
	AND #$01
	TAY
	JSR CODE_019441
	STA wm_SprOnTileXHi
	BEQ +
	LDA wm_Map16NumLo
	CMP #$11
	BCC +
	CMP #$6E
	BCS +
	JSR CODE_019425
	LDA wm_Map16NumLo
	STA wm_MirBlkCheck
	LDA wm_TempTileGen
	BEQ +
	LDA wm_SprObjStatus,X
	ORA #$40
	STA wm_SprObjStatus,X
+	LDA wm_Map16NumLo
	STA wm_SprOnTileXLo
_Return0192C0:
	RTS

DATA_0192C1:	.DB -2,2,-1,0

DATA_0192C5:	.DB 1,-1

DATA_0192C7:	.DB 0,-1

CODE_0192C9:
	LDY #$02
	LDA wm_SpriteSpeedY,X
	BPL +
	INY
+	JSR CODE_019441
	STA wm_SprOnTileYHi
	PHP
	LDA wm_Map16NumLo
	STA wm_SprOnTileYLo
	PLP
	BEQ ++
	LDA wm_Map16NumLo
	CPY #$02
	BEQ CODE_019310
	CMP #$11
	BCC ++
	CMP #$6E
	BCC +
	CMP wm_LowestSolidSprTile
	BCC ++
	CMP wm_HighestSolidSprTile
	BCS ++
+	JSR CODE_019425
	LDA wm_Map16NumLo
	STA wm_SprOnBreakableBlk
	LDA wm_TempTileGen
	BEQ ++
	LDA wm_SprObjStatus,X
	ORA #$20
	STA wm_SprObjStatus,X
++	RTS

CODE_019310:
	CMP #$59
	BCC CODE_01933B
	CMP #$5C
	BCS CODE_01933B
	LDY wm_LvHeadTileset
	CPY #$0E
	BEQ +
	CPY #$03
	BNE CODE_01933B
+	LDA wm_SpriteNum,X
	CMP #$35
	BEQ _019330
	LDA wm_Tweaker167A,X
	AND #$02
	BNE CODE_01933B
_019330:
	LDA #$05
	STA wm_SpriteStatus,X
	LDA #$40
	STA wm_SpriteDecTbl3,X
	RTS

CODE_01933B:
	CMP #$11
	BCC CODE_0193B0
	CMP #$6E
	BCC _0193B8
	CMP #$D8
	BCS CODE_019386
	JSL CODE_00FA19
	LDA [m5],Y
	CMP #$10
	BEQ _Return0193AF
	BCS CODE_019386
	LDA m0
	CMP #$0C
	BCS +
	CMP [m5],Y
	BCC _Return0193AF
+	LDA [m5],Y
	STA wm_SprMoveDownPixels
	PHX
	LDX m8
	LDA.L DATA_00E53D,X
	PLX
	STA wm_SpriteSlopeTbl,X
	CMP #$04
	BEQ +
	CMP #$FC
	BNE ++
+	EOR wm_SpriteSpeedX,X
	BPL +
	LDA wm_SpriteSpeedX,X
	BEQ +
	JSR FlipSpriteDir
+	JSL CODE_03C1CA
++	BRA _0193B8

CODE_019386:
	LDA m12
	AND #$0F
	CMP #$05
	BCS _Return0193AF
	LDA wm_SpriteStatus,X
	CMP #$02
	BEQ _Return0193AF
	CMP #$05
	BEQ _Return0193AF
	CMP #$0B
	BEQ _Return0193AF
	LDA wm_SpriteYLo,X
	SEC
	SBC #$01
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
	JSR CODE_0192C9
_Return0193AF:
	RTS

CODE_0193B0:
	LDA m12
	AND #$0F
	CMP #$05
	BCS _Return019424
_0193B8:
	LDA wm_Tweaker1686,X
	AND #$04
	BNE +++
	LDA wm_SpriteStatus,X
	CMP #$02
	BEQ _Return019424
	CMP #$05
	BEQ _Return019424
	CMP #$0B
	BEQ _Return019424
	LDY wm_Map16NumLo
	CPY #$0C
	BEQ +
	CPY #$0D
	BNE ++
+	LDA wm_FrameA
	AND #$03
	BNE ++
	JSR IsTouchingObjSide
	BNE ++
	LDA wm_LvHeadTileset
	CMP #$02
	BEQ +
	CMP #$08
	BNE ++
+	TYA
	SEC
	SBC #$0C
	TAY
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_0192C5,Y
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC DATA_0192C7,Y
	STA wm_SpriteXHi,X
++	LDA wm_SpriteEatenTbl,X
	BNE +++
	LDA wm_SpriteYLo,X
	AND #$F0
	CLC
	ADC wm_SprMoveDownPixels
	STA wm_SpriteYLo,X
+++	JSR _019435
	LDA wm_TempTileGen
	BEQ _Return019424
	LDA wm_SprObjStatus,X
	ORA #$80
	STA wm_SprObjStatus,X
_Return019424:
	RTS

CODE_019425:
	LDA m10
	STA wm_BlockYPos
	LDA m11
	STA wm_BlockYPos+1
	LDA m12
	STA wm_BlockXPos
	LDA m13
	STA wm_BlockXPos+1
_019435:
	LDY m15
	LDA wm_SprObjStatus,X
	ORA DATA_019134,Y
	STA wm_SprObjStatus,X
	RTS

CODE_019441:
	STY m15
	LDA wm_Tweaker1656,X
	AND #$0F
	ASL
	ASL
	ADC m15
	TAY
_01944D:
	LDA wm_TempTileGen
	INC A
	AND wm_IsVerticalLvl
	BEQ CODE_0194BF
	LDA wm_SpriteYLo,X
	CLC
	ADC SpriteObjClippingY,Y
	STA m12
	AND #$F0
	STA m0
	LDA wm_SpriteYHi,X
	ADC #$00
	CMP wm_ScreensInLvl
	BCS CODE_0194B4
	STA m13
	LDA wm_SpriteXLo,X
	CLC
	ADC SpriteObjClippingX,Y
	STA m10
	STA m1
	LDA wm_SpriteXHi,X
	ADC #$00
	CMP #$02
	BCS CODE_0194B4
	STA m11
	LDA m1
	LSR
	LSR
	LSR
	LSR
	ORA m0
	STA m0
	LDX m13
	LDA.L DATA_00BA80,X
	LDY wm_TempTileGen
	BEQ +
	LDA.L DATA_00BA8E,X
+	CLC
	ADC m0
	STA m5
	LDA.L DATA_00BABC,X
	LDY wm_TempTileGen
	BEQ +
	LDA.L DATA_00BACA,X
+	ADC m11
	STA m6
	JSR _019523
	RTS

CODE_0194B4:
	LDY m15
	LDA #$00
	STA wm_Map16NumLo
	STA wm_SprMoveDownPixels
	RTS

CODE_0194BF:
	LDA wm_SpriteYLo,X
	CLC
	ADC SpriteObjClippingY,Y
	STA m12
	AND #$F0
	STA m0
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m13
	REP #$20
	LDA m12
	CMP #$01B0
	SEP #$20
	BCS CODE_0194B4
	LDA wm_SpriteXLo,X
	CLC
	ADC SpriteObjClippingX,Y
	STA m10
	STA m1
	LDA wm_SpriteXHi,X
	ADC #$00
	STA m11
	BMI CODE_0194B4
	CMP wm_ScreensInLvl
	BCS CODE_0194B4
	LDA m1
	LSR
	LSR
	LSR
	LSR
	ORA m0
	STA m0
	LDX m11
	LDA.L DATA_00BA60,X
	LDY wm_TempTileGen
	BEQ +
	LDA.L DATA_00BA70,X
+	CLC
	ADC m0
	STA m5
	LDA.L DATA_00BA9C,X
	LDY wm_TempTileGen
	BEQ +
	LDA.L DATA_00BAAC,X
+	ADC m13
	STA m6
_019523:
	LDA #$7E
	STA m7
	LDX wm_SprProcessIndex
	LDA [m5]
	STA wm_Map16NumLo
	INC m7
	LDA [m5]
	JSL CODE_00F545
	LDY m15
	CMP #$00
	RTS

HandleSprStunned:
	LDA wm_SpriteNum,X
	CMP #$2C
	BNE CODE_019554
	LDA wm_SpriteState,X
	BEQ CODE_01956A
_019546:
	LDA wm_SpriteProp
	PHA
	LDA #$10
	STA wm_SpriteProp
	JSR SubSprGfx2Entry1
	PLA
	STA wm_SpriteProp
	RTS

CODE_019554:
	CMP #$2F
	BEQ _SetNormalStatus2
	CMP #$85
	BEQ _SetNormalStatus2
	CMP #$7D
	BNE CODE_01956A
	STZ wm_SpriteSpeedY,X
_SetNormalStatus2:
	LDA #$08
	STA wm_SpriteStatus,X
	JMP CODE_01A187

CODE_01956A:
	LDA wm_SpritesLocked
	BEQ CODE_019571
	JMP _0195F5

CODE_019571:
	JSR CODE_019624
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ _019598
	JSR CODE_0197D5
	LDA wm_SpriteNum,X
	CMP #$16
	BEQ +
	CMP #$15
	BNE CODE_01958C
+	JMP _SetNormalStatus2

CODE_01958C:
	CMP #$2C
	BNE _019598
	LDA #$F0
	STA wm_SpriteSpeedY,X
	JSL CODE_01F74C
_019598:
	JSR IsTouchingCeiling
	BEQ +
	LDA #$10
	STA wm_SpriteSpeedY,X
	JSR IsTouchingObjSide
	BNE +
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	AND #$F0
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	LDA wm_SprObjStatus,X
	AND #$20
	ASL
	ASL
	ASL
	ROL
	AND #$01
	STA wm_LayerInProcess
	LDY #$00
	LDA wm_SprOnBreakableBlk
	JSL _00F160
	LDA #$08
	STA wm_DisSprCapeContact,X
+	JSR IsTouchingObjSide
	BEQ ++
	LDA wm_SpriteNum,X
	CMP #$0D
	BCC +
	JSR CODE_01999E
+	LDA wm_SpriteSpeedX,X
	ASL
	PHP
	ROR wm_SpriteSpeedX,X
	PLP
	ROR wm_SpriteSpeedX,X
++	JSR _SubSprSprMarioSpr
_0195F5:
	JSR CODE_01A187
	JSR SubOffscreen0Bnk1
	RTS

UNK_0195FC:
	.DB $00,$00,$00,$00,$04,$05,$06,$07
	.DB $00,$00,$00,$00,$04,$05,$06,$07
	.DB $00,$00,$00,$00,$04,$05,$06,$07
	.DB $00,$00,$00,$00,$04,$05,$06,$07

SpriteKoopasSpawn:	.DB $00,$00,$00,$00,$00,$01,$02,$03

CODE_019624:
	LDA wm_SpriteNum,X
	CMP #$0D
	BNE CODE_01965C
	LDA wm_SpriteDecTbl1,X
	CMP #$01
	BNE CODE_01964E
	LDA #$09
	STA wm_SoundCh3
	LDA #$01
	STA wm_SpriteMiscTbl5,X
	LDA #$40
	STA wm_SpriteDecTbl1,X
	LDA #$08
	STA wm_SpriteStatus,X
	LDA wm_Tweaker1686,X
	AND #$F7
	STA wm_Tweaker1686,X
	RTS

CODE_01964E:
	CMP #$40
	BCS +
	ASL
	AND #$0E
	EOR wm_SpritePal,X
	STA wm_SpritePal,X
+	RTS

CODE_01965C:
	LDA wm_SpriteDecTbl1,X
	ORA wm_SpriteDecTbl3,X
	STA wm_SpriteState,X
	LDA wm_SpriteDecTbl3,X
	BEQ CODE_01969C
	CMP #$01
	BNE CODE_01969C
	LDY wm_SpriteMiscTbl7,X
	LDA wm_SpriteEatenTbl,Y
	BNE CODE_01969C
	JSL LoadSpriteTables
	JSR _FaceMario
	ASL wm_SpritePal,X
	LSR wm_SpritePal,X
	LDY wm_SpriteMiscTbl8,X
	LDA #$08
	CPY #$03
	BNE +
	INC wm_SprStompImmuneTbl,X
	LDA wm_Tweaker166E,X
	ORA #$30
	STA wm_Tweaker166E,X
	LDA #$0A
+	STA wm_SpriteStatus,X
_Return01969B:
	RTS

CODE_01969C:
	LDA wm_SpriteDecTbl1,X
	BEQ _Return01969B
	CMP #$03
	BEQ +
	CMP #$01
	BNE IncrmntStunTimer
+	LDA wm_SpriteNum,X
	CMP #$11
	BEQ SetNormalStatus
	CMP #$2E
	BEQ SetNormalStatus
	CMP #$2D
	BEQ _Return0196CA
	CMP #$A2
	BEQ SetNormalStatus
	CMP #$0F
	BEQ SetNormalStatus
	CMP #$2C
	BEQ _Return0196CA
	CMP #$53
	BNE GeneralResetSpr
	JSR _019ACB
_Return0196CA:
	RTS

SetNormalStatus:
	LDA #$08
	STA wm_SpriteStatus,X
	ASL wm_SpritePal,X
	LSR wm_SpritePal,X
	RTS

IncrmntStunTimer:
	LDA wm_FrameA
	AND #$01
	BNE +
	INC wm_SpriteDecTbl1,X
+	RTS

GeneralResetSpr:
	JSL FindFreeSprSlot
	BMI _Return0196CA
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA wm_SpriteNum,X
	TAX
	LDA.W SpriteKoopasSpawn,X
	STA.W wm_SpriteNum,Y
	TYX
	JSL InitSpriteTables
	LDX wm_SprProcessIndex
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	LDA #$00
	STA wm_SpriteDir,Y
	LDA #$10
	STA wm_SpriteDecTbl4,Y
	LDA wm_SprInWaterTbl,X
	STA wm_SprInWaterTbl,Y
	LDA wm_SpriteDecTbl1,X
	STZ wm_SpriteDecTbl1,X
	CMP #$01
	BEQ CODE_019747
	LDA #$D0
	STA.W wm_SpriteSpeedY,Y
	PHY
	JSR SubHorizPos
	TYA
	EOR #$01
	PLY
	STA wm_SpriteDir,Y
	PHX
	TAX
	LDA.W Spr0to13SpeedX,X
	STA.W wm_SpriteSpeedX,Y
	PLX
	RTS

CODE_019747:
	PHY
	JSR SubHorizPos
	LDA DATA_0197AD,Y
	STY m0
	PLY
	STA.W wm_SpriteSpeedX,Y
	LDA m0
	EOR #$01
	STA wm_SpriteDir,Y
	STA m1
	LDA #$10
	STA wm_SpriteDecTbl2,Y
	STA wm_SpriteMiscTbl4,Y
	LDA wm_SpriteNum,X
	CMP #$07
	BNE +
	LDY #$08
-	LDA wm_SpriteStatus,Y
	BEQ SpawnMovingCoin
	DEY
	BPL -
+	RTS

SpawnMovingCoin:
	LDA #$08
	STA wm_SpriteStatus,Y
	LDA #$21
	STA.W wm_SpriteNum,Y
	LDA wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	STA wm_SpriteYHi,Y
	PHX
	TYX
	JSL InitSpriteTables
	PLX
	LDA #$D0
	STA.W wm_SpriteSpeedY,Y
	LDA m1
	STA wm_SpriteDir,Y
	LDA #$20
	STA wm_SpriteDecTbl2,Y
	RTS

DATA_0197AD:	.DB -64,64

DATA_0197AF:
	.DB 0,0,0,-8,-8,-8,-8,-8
	.DB -8,-9,-10,-11,-12,-13,-14,-24
	.DB -24,-24,-24,0,0,0,0,-2
	.DB -4,-8,-20,-20,-20,-24,-28,-32
	.DB -36,-40,-44,-48,-52,-56

CODE_0197D5:
	LDA wm_SpriteSpeedX,X
	PHP
	BPL +
	JSR InvertAccum
+	LSR
	PLP
	BPL +
	JSR InvertAccum
+	STA wm_SpriteSpeedX,X
	LDA wm_SpriteSpeedY,X
	PHA
	JSR SetSomeYSpeed
	PLA
	LSR
	LSR
	TAY
	LDA wm_SpriteNum,X
	CMP #$0F
	BNE +
	TYA
	CLC
	ADC #$13
	TAY
+	LDA DATA_0197AF,Y
	LDY wm_SprObjStatus,X
	BMI +
	STA wm_SpriteSpeedY,X
+	RTS

CODE_019806:
	LDA #$06
	LDY wm_SprOAMIndex,X
	BNE _01980F
	LDA #$08
_01980F:
	STA wm_SpriteGfxTbl,X
	LDA wm_SprOAMIndex,X
	PHA
	BEQ +
	CLC
	ADC #$08
+	STA wm_SprOAMIndex,X
	JSR SubSprGfx2Entry1
	PLA
	STA wm_SprOAMIndex,X
	LDA wm_MapData.OwLvFlags.Lv125
	BMI +++
	LDA wm_SpriteGfxTbl,X
	CMP #$06
	BNE +++
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDecTbl3,X
	BNE +
	LDA wm_SpriteDecTbl1,X
	BEQ +++
	CMP #$30
	BCS ++
+	LSR
	LDA wm_OamSlot.3.XPos,Y
	ADC #$00
	BCS ++
	STA wm_OamSlot.3.XPos,Y
++	LDA wm_SpriteNum,X
	CMP #$11
	BEQ +++
	JSR IsSprOffScreen
	BNE +++
	LDA wm_SpritePal,X
	ASL
	LDA #$08
	BCC +
	LDA #$00
+	STA m0
	LDA wm_OamSlot.3.XPos,Y
	CLC
	ADC #$02
	STA wm_OamSlot.1.XPos,Y
	CLC
	ADC #$04
	STA wm_OamSlot.2.XPos,Y
	LDA wm_OamSlot.3.YPos,Y
	CLC
	ADC m0
	STA wm_OamSlot.1.YPos,Y
	STA wm_OamSlot.2.YPos,Y
	PHY
	LDY #$64
	LDA wm_FrameB
	AND #$F8
	BNE +
	LDY #$4D
+	TYA
	PLY
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.2.Tile,Y
	LDA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
+++	RTS

DATA_0198A7:	.DB -32,32

CODE_0198A9:
	LDA wm_SpritesLocked
	BEQ CODE_0198B0
	JMP CODE_019A2A

CODE_0198B0:
	JSR SubUpdateSprPos
	LDA wm_SpriteMiscTbl3,X
	AND #$1F
	BNE +
	JSR _FaceMario
+	LDA wm_SpriteSpeedX,X
	LDY wm_SpriteDir,X
	CPY #$00
	BNE CODE_0198D0
	CMP #$20
	BPL _0198D8
	INC wm_SpriteSpeedX,X
	INC wm_SpriteSpeedX,X
	BRA _0198D8

CODE_0198D0:
	CMP #$E0
	BMI _0198D8
	DEC wm_SpriteSpeedX,X
	DEC wm_SpriteSpeedX,X
_0198D8:
	JSR IsTouchingObjSide
	BEQ +
	PHA
	JSR CODE_01999E
	PLA
	AND #$03
	TAY
	LDA DATA_0198A7-1,Y
	STA wm_SpriteSpeedX,X
+	JSR IsOnGround
	BEQ +
	JSR SetSomeYSpeed
	LDA #$10
	STA wm_SpriteSpeedY,X
+	JSR IsTouchingCeiling
	BEQ +
	STZ wm_SpriteSpeedY,X
+	LDA wm_FrameA
	AND #$01
	BNE +
	LDA wm_SpritePal,X
	INC A
	INC A
	AND #$CF
	STA wm_SpritePal,X
+	JMP _01998C

UNK_019910:	.DB -16,-18,-20

HandleSprKicked:
	LDA wm_SprStompImmuneTbl,X
	BEQ CODE_01991B
	JMP CODE_0198A9

CODE_01991B:
	LDA wm_Tweaker167A,X
	AND #$10
	BEQ CODE_019928
	JSR _01AA0B
	JMP CODE_01A187

CODE_019928:
	LDA wm_SpriteMiscTbl4,X
	BNE +
	LDA wm_SpriteSpeedX,X
	CLC
	ADC #$20
	CMP #$40
	BCS +
	JSR _01AA0B
+	STZ wm_SpriteMiscTbl4,X
	LDA wm_SpritesLocked
	ORA wm_SpriteDecTbl6,X
	BEQ CODE_019946
	JMP _01998F

CODE_019946:
	JSR UpdateDirection
	LDA wm_SpriteSlopeTbl,X
	PHA
	JSR SubUpdateSprPos
	PLA
	BEQ CODE_019969
	STA m0
	LDY wm_SprInWaterTbl,X
	BNE CODE_019969
	CMP wm_SpriteSlopeTbl,X
	BEQ CODE_019969
	EOR wm_SpriteSpeedX,X
	BMI CODE_019969
	LDA #$F8
	STA wm_SpriteSpeedY,X
	BRA _019975

CODE_019969:
	JSR IsOnGround
	BEQ ++
	JSR SetSomeYSpeed
	LDA #$10
	STA wm_SpriteSpeedY,X
_019975:
	LDA wm_SprOnTileXLo
	CMP #$B5
	BEQ +
	CMP #$B4
	BNE ++
+	LDA #$B8
	STA wm_SpriteSpeedY,X
++	JSR IsTouchingObjSide
	BEQ _01998C
	JSR CODE_01999E
_01998C:
	JSR _SubSprSprMarioSpr
_01998F:
	JSR SubOffscreen0Bnk1
	LDA wm_SpriteNum,X
	CMP #$53
	BEQ CODE_01999B
	JMP CODE_019A2A

CODE_01999B:
	JMP StunThrowBlock

CODE_01999E:
	LDA #$01
	STA wm_SoundCh1
	JSR _0190A2
	LDA wm_OffscreenHorz,X
	BNE +
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$14
	CMP #$1C
	BCC +
	LDA wm_SprObjStatus,X
	AND #$40
	ASL
	ASL
	ROL
	AND #$01
	STA wm_LayerInProcess
	LDY #$00
	LDA wm_MirBlkCheck
	JSL _00F160
	LDA #$05
	STA wm_DisSprCapeContact,X
+	LDA wm_SpriteNum,X
	CMP #$53
	BNE +
	JSR BreakThrowBlock
+	RTS

BreakThrowBlock:
	STZ wm_SpriteStatus,X
	LDY #$FF
_0199E1:
	JSR IsSprOffScreen
	BNE +
	LDA wm_SpriteXLo,X
	STA wm_BlockYPos
	LDA wm_SpriteXHi,X
	STA wm_BlockYPos+1
	LDA wm_SpriteYLo,X
	STA wm_BlockXPos
	LDA wm_SpriteYHi,X
	STA wm_BlockXPos+1
	PHB
	LDA #:ShatterBlock
	PHA
	PLB
	TYA
	JSL ShatterBlock
	PLB
+	RTS

SetSomeYSpeed:
	LDA wm_SprObjStatus,X
	BMI +
	LDA #$00
	LDY wm_SpriteSlopeTbl,X
	BEQ ++
+	LDA #$18
++	STA wm_SpriteSpeedY,X
	RTS

UpdateDirection:
	LDA #$00
	LDY wm_SpriteSpeedX,X
	BEQ ++
	BPL +
	INC A
+	STA wm_SpriteDir,X
++	RTS

ShellAniTiles:	.DB $06,$07,$08,$07

ShellGfxProp:	.DB $00,$00,$00,$40

CODE_019A2A:
	LDA wm_SpriteState,X
	STA wm_SpriteDecTbl3,X
	LDA wm_FrameB
	LSR
	LSR
	AND #$03
	TAY
	PHY
	LDA ShellAniTiles,Y
	JSR _01980F
	STZ wm_SpriteDecTbl3,X
	PLY
	LDA ShellGfxProp,Y
	LDY wm_SprOAMIndex,X
	EOR wm_OamSlot.3.Prop,Y
	STA wm_OamSlot.3.Prop,Y
	RTS

SpinJumpSmokeTiles:	.DB $64,$62,$60,$62

HandleSprSpinJump:
	LDA wm_SpriteDecTbl1,X
	BEQ SpinJumpEraseSpr
	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteDecTbl1,X
	LSR
	LSR
	LSR
	AND #$03
	PHX
	TAX
	LDA.W SpinJumpSmokeTiles,X
	PLX
	STA wm_OamSlot.1.Tile,Y
	STA wm_OamSlot.1.Prop,Y
	AND #$30
	STA wm_OamSlot.1.Prop,Y
	RTS

SpinJumpEraseSpr:
	JSR _OffScrEraseSprite
	RTS

CODE_019A7B:
	LDA wm_SpriteDecTbl3,X
	BEQ SpinJumpEraseSpr
	LDA #$04
	STA wm_SpriteSpeedY,X
	ASL wm_Tweaker190F,X
	LSR wm_Tweaker190F,X
	LDA wm_SpriteSpeedX,X
	BEQ _019A9D
	BPL CODE_019A94
	INC wm_SpriteSpeedX,X
	BRA _019A9D

CODE_019A94:
	DEC wm_SpriteSpeedX,X
	JSR IsTouchingObjSide
	BEQ _019A9D
	STZ wm_SpriteSpeedX,X
_019A9D:
	LDA #$01
	STA wm_SprBehindScrn,X
_HandleSprKilled:
	LDA wm_SpriteNum,X
	CMP #$86
	BNE CODE_019AAB
	JMP CallSpriteMain

CODE_019AAB:
	CMP #$1E
	BNE +
	LDY #$FF
	STY wm_StolenCloudTimer
+	CMP #$53
	BNE CODE_019ABC
	JSR BreakThrowBlock
	RTS

CODE_019ABC:
	CMP #$4C
	BNE +
	JSL CODE_02E463
+	LDA wm_Tweaker1656,X
	AND #$80
	BEQ CODE_019AD6
_019ACB:
	LDA #$04
	STA wm_SpriteStatus,X
	LDA #$1F
	STA wm_SpriteDecTbl1,X
	RTS

CODE_019AD6:
	LDA wm_SpritesLocked
	BNE +
	JSR SubUpdateSprPos
+	JSR SubOffscreen0Bnk1
	JSR HandleSpriteDeath
	RTS

HandleSprSmushed:
	LDA wm_SpritesLocked
	BNE _019AFE
	LDA wm_SpriteDecTbl1,X
	BNE ShowSmushedGfx
	STZ wm_SpriteStatus,X
	RTS

ShowSmushedGfx:
	JSR SubUpdateSprPos
	JSR IsOnGround
	BEQ _019AFE
	JSR SetSomeYSpeed
	STZ wm_SpriteSpeedX,X
_019AFE:
	LDA wm_SpriteNum,X
	CMP #$6F
	BNE CODE_019B10
	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA #$AC
	STA wm_OamSlot.1.Tile,Y
	RTS

CODE_019B10:
	JMP SmushedGfxRt

HandleSpriteDeath:
	LDA wm_Tweaker167A,X
	AND #$01
	BEQ CODE_019B1D
	JMP CallSpriteMain

CODE_019B1D:
	STZ wm_SpriteGfxTbl,X
	LDA wm_Tweaker190F,X
	AND #$20
	BEQ _019B64
	LDA wm_Tweaker1662,X
	AND #$40
	BNE CODE_019B5F
	LDA wm_SpriteNum,X
	CMP #$1E
	BEQ +
	CMP #$4B
	BNE CODE_019B44
	LDA #$01
	STA wm_SprBehindScrn,X
+	LDA #$01
	STA wm_SpriteGfxTbl,X
	BRA _019B4C

CODE_019B44:
	LDA wm_SpritePal,X
	ORA #$80
	STA wm_SpritePal,X
_019B4C:
	LDA wm_SpriteProp
	PHA
	LDY wm_SprBehindScrn,X
	BEQ +
	LDA #$10
+	STA wm_SpriteProp
	JSR SubSprGfx1
	PLA
	STA wm_SpriteProp
	RTS

CODE_019B5F:
	LDA #$06
	STA wm_SpriteGfxTbl,X
_019B64:
	LDA #$00
	CPY #$1C
	BEQ +
	LDA #$80
+	STA m0
	LDA wm_SpriteProp
	PHA
	LDY wm_SprBehindScrn,X
	BEQ +
	LDA #$10
+	STA wm_SpriteProp
	LDA m0
	JSR SubSprGfx2Entry0
	PLA
	STA wm_SpriteProp
	RTS

SprTilemap:
	.DB $82,$A0,$82,$A2,$84,$A4,$8C,$8A
	.DB $8E,$C8,$CA,$CA,$CE,$CC,$86,$4E
	.DB $E0,$E2,$E2,$CE,$E4,$E0,$E0,$A3
	.DB $A3,$B3,$B3,$E9,$E8,$F9,$F8,$E8
	.DB $E9,$F8,$F9,$E2,$E6,$AA,$A8,$A8
	.DB $AA,$A2,$A2,$B2,$B2,$C3,$C2,$D3
	.DB $D2,$C2,$C3,$D2,$D3,$E2,$E6,$CA
	.DB $CC,$CA,$AC,$CE,$AE,$CE,$83,$83
	.DB $C4,$C4,$83,$83,$C5,$C5,$8A,$A6
	.DB $A4,$A6,$A8,$80,$82,$80,$84,$84
	.DB $84,$84,$94,$94,$94,$94,$A0,$B0
	.DB $A0,$D0,$82,$80,$82,$00,$00,$00
	.DB $86,$84,$88,$EC,$8C,$A8,$AA,$8E
	.DB $AC,$AE,$8E,$EC,$EE,$CE,$EE,$A8
	.DB $EE,$40,$40,$A0,$C0,$A0,$C0,$A4
	.DB $C4,$A4,$C4,$A0,$C0,$A0,$C0,$40
	.DB $07,$27,$4C,$29,$4E,$2B,$82,$A0
	.DB $84,$A4,$67,$69,$88,$CE,$8E,$AE
	.DB $A2,$A2,$B2,$B2,$00,$40,$44,$42
	.DB $2C,$42,$28,$28,$28,$28,$4C,$4C
	.DB $4C,$4C,$83,$83,$6F,$6F,$AC,$BC
	.DB $AC,$A6,$8C,$AA,$86,$84,$DC,$EC
	.DB $DE,$EE,$06,$06,$16,$16,$07,$07
	.DB $17,$17,$16,$16,$06,$06,$17,$17
	.DB $07,$07,$84,$86,$00,$00,$00,$0E
	.DB $2A,$24,$02,$06,$0A,$20,$22,$28
	.DB $26,$2E,$40,$42,$0C,$04,$2B,$6A
	.DB $ED,$88,$8C,$A8,$8E,$AA,$AE,$8C
	.DB $88,$A8,$AE,$AC,$8C,$8E,$CE,$EE
	.DB $C4,$C6,$82,$84,$86,$8C,$CE,$CE
	.DB $88,$89,$CE,$CE,$89,$88,$F3,$CE
	.DB $F3,$CE,$A7,$A9

SprTilemapOffset:
	.DB $09,$09,$10,$09,$00,$00,$00,$00
	.DB $00,$00,$00,$00,$00,$37,$00,$25
	.DB $25,$5A,$00,$4B,$4E,$8A,$8A,$8A
	.DB $8A,$56,$3A,$46,$47,$69,$6B,$73
	.DB $00,$00,$80,$80,$80,$80,$8E,$90
	.DB $00,$00,$3A,$F6,$94,$95,$63,$9A
	.DB $A6,$AA,$AE,$B2,$C2,$C4,$D5,$D9
	.DB $D7,$D7,$E6,$E6,$E6,$E2,$99,$17
	.DB $29,$E6,$E6,$E6,$00,$E8,$00,$8A
	.DB $E8,$00,$ED,$EA,$7F,$EA,$EA,$3A
	.DB $3A,$FA,$71,$7F

GeneralSprDispX:	.DB 0,8,0,8

GeneralSprDispY:	.DB 0,0,8,8

GeneralSprGfxProp:
	.DB $00,$00,$00,$00,$00,$40,$00,$40
	.DB $00,$40,$80,$C0,$40,$40,$00,$00
	.DB $40,$00,$C0,$80,$40,$40,$40,$40

SubSprGfx0Entry0:
	LDY #$00
_SubSprGfx0Entry1:
	STA m5
	STY m15
	JSR GetDrawInfoBnk1
	LDY m15
	TYA
	CLC
	ADC m1
	STA m1
	LDY wm_SpriteNum,X
	LDA wm_SpriteGfxTbl,X
	ASL
	ASL
	ADC SprTilemapOffset,Y
	STA m2
	LDA wm_SpritePal,X
	ORA wm_SpriteProp
	STA m3
	LDY wm_SprOAMIndex,X
	LDA #$03
	STA m4
	PHX
-	LDX m4
	LDA m0
	CLC
	ADC.W GeneralSprDispX,X
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	CLC
	ADC.W GeneralSprDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA m2
	CLC
	ADC m4
	TAX
	LDA.W SprTilemap,X
	STA wm_OamSlot.1.Tile,Y
	LDA m5
	ASL
	ASL
	ADC m4
	TAX
	LDA.W GeneralSprGfxProp,X
	ORA m3
	STA wm_OamSlot.1.Prop,Y
	INY
	INY
	INY
	INY
	DEC m4
	BPL -
	PLX
	LDA #$03
	LDY #$00
	JSR FinishOAMWriteRt
	RTS

GenericSprGfxRt1:
	PHB
	PHK
	PLB
	JSR SubSprGfx1
	PLB
	RTL

SubSprGfx1:
	LDA wm_SpritePal,X
	BPL SubSprGfx1Hlpr0
	JSR SubSprGfx1Hlpr1
	RTS

SubSprGfx1Hlpr0:
	JSR GetDrawInfoBnk1
	LDA wm_SpriteDir,X
	STA m2
	TYA
	LDY wm_SpriteNum,X
	CPY #$0F
	BCS +
	ADC #$04
+	TAY
	PHY
	LDY wm_SpriteNum,X
	LDA wm_SpriteGfxTbl,X
	ASL
	CLC
	ADC SprTilemapOffset,Y
	TAX
	PLY
	LDA.W SprTilemap,X
	STA wm_OamSlot.1.Tile,Y
	LDA.W SprTilemap+1,X
	STA wm_OamSlot.2.Tile,Y
	LDX wm_SprProcessIndex
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.YPos,Y
_019DA9:
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	STA wm_OamSlot.2.XPos,Y
	LDA wm_SpriteDir,X
	LSR
	LDA #$00
	ORA wm_SpritePal,X
	BCS +
	ORA #$40
+	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	STA wm_OamSlot.2.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	ORA wm_OffscreenHorz,X
	STA wm_OamSize.1,Y
	STA wm_OamSize.2,Y
	JSR CODE_01A3DF
	RTS

SubSprGfx1Hlpr1:
	JSR GetDrawInfoBnk1
	LDA wm_SpriteDir,X
	STA m2
	TYA
	CLC
	ADC #$08
	TAY
	PHY
	LDY wm_SpriteNum,X
	LDA wm_SpriteGfxTbl,X
	ASL
	CLC
	ADC SprTilemapOffset,Y
	TAX
	PLY
	LDA.W SprTilemap,X
	STA wm_OamSlot.2.Tile,Y
	LDA.W SprTilemap+1,X
	STA wm_OamSlot.1.Tile,Y
	LDX wm_SprProcessIndex
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	CLC
	ADC #$10
	STA wm_OamSlot.2.YPos,Y
	JMP _019DA9

KoopaWingDispXLo:	.DB -1,-9,9,9

KoopaWingDispXHi:	.DB -1,-1,0,0

KoopaWingDispY:	.DB -4,-12,-4,-12

KoopaWingTiles:	.DB $5D,$C6,$5D,$C6

KoopaWingGfxProp:	.DB $46,$46,$06,$06

KoopaWingTileSize:	.DB $00,$02,$00,$02

KoopaWingGfxRt:
	LDY #$00
	JSR IsOnGround
	BNE _019E35
	LDA wm_SpriteGfxTbl,X
	AND #$01
	TAY
_019E35:
	STY m2
_019E37:
	LDA wm_OffscreenVert,X
	BNE ++
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m4
	LDA wm_SpriteYLo,X
	STA m1
	LDY wm_SprOAMIndex,X
	PHX
	LDA wm_SpriteDir,X
	ASL
	ADC m2
	TAX
	LDA m0
	CLC
	ADC.W KoopaWingDispXLo,X
	STA m0
	LDA m4
	ADC.W KoopaWingDispXHi,X
	PHA
	LDA m0
	SEC
	SBC wm_Bg1HOfs
	STA wm_OamSlot.1.XPos,Y
	PLA
	SBC wm_Bg1HOfs+1
	BNE +
	LDA m1
	SEC
	SBC wm_Bg1VOfs
	CLC
	ADC.W KoopaWingDispY,X
	STA wm_OamSlot.1.YPos,Y
	LDA.W KoopaWingTiles,X
	STA wm_OamSlot.1.Tile,Y
	LDA wm_SpriteProp
	ORA.W KoopaWingGfxProp,X
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA.W KoopaWingTileSize,X
	STA wm_OamSize.1,Y
+	PLX
++	RTS

CODE_019E95:
	LDA wm_SpriteYLo,X
	PHA
	CLC
	ADC #$02
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	PHA
	ADC #$00
	STA wm_SpriteYHi,X
	LDA wm_SpriteXLo,X
	PHA
	SEC
	SBC #$02
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	PHA
	SBC #$00
	STA wm_SpriteXHi,X
	LDA wm_SprOAMIndex,X
	PHA
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	LDA wm_SpriteDir,X
	PHA
	STZ wm_SpriteDir,X
	LDA wm_SpriteMiscTbl6,X
	LSR
	LSR
	LSR
	AND #$01
	TAY
	JSR _019E35
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_SpriteXLo,X
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_SpriteXHi,X
	LDA wm_SprOAMIndex,X
	CLC
	ADC #$04
	STA wm_SprOAMIndex,X
	INC wm_SpriteDir,X
	JSR _019E37
	PLA
	STA wm_SpriteDir,X
	PLA
	STA wm_SprOAMIndex,X
	PLA
	STA wm_SpriteXHi,X
	PLA
	STA wm_SpriteXLo,X
	PLA
	STA wm_SpriteYHi,X
	PLA
	STA wm_SpriteYLo,X
	RTS

SubSprGfx2Entry0:
	STA m4
	BRA _019F0F

SubSprGfx2Entry1:
	STZ m4
_019F0F:
	JSR GetDrawInfoBnk1
	LDA wm_SpriteDir,X
	STA m2
	LDY wm_SpriteNum,X
	LDA wm_SpriteGfxTbl,X
	CLC
	ADC SprTilemapOffset,Y
	LDY wm_SprOAMIndex,X
	TAX
	LDA.W SprTilemap,X
	STA wm_OamSlot.1.Tile,Y
	LDX wm_SprProcessIndex
	LDA m0
	STA wm_OamSlot.1.XPos,Y
	LDA m1
	STA wm_OamSlot.1.YPos,Y
	LDA wm_SpriteDir,X
	LSR
	LDA #$00
	ORA wm_SpritePal,X
	BCS +
	EOR #$40
+	ORA m4
	ORA wm_SpriteProp
	STA wm_OamSlot.1.Prop,Y
	TYA
	LSR
	LSR
	TAY
	LDA #$02
	ORA wm_OffscreenHorz,X
	STA wm_OamSize.1,Y
	JSR CODE_01A3DF
	RTS

DATA_019F5B:	.DB 11,-11,4,-4,4,0

DATA_019F61:	.DB 0,-1,0,-1,0,0

DATA_019F67:	.DB -13,13

DATA_019F69:	.DB -1,0

ShellSpeedX:	.DB -46,46,-52,52

UNK_019F6F:	.DB 0,16

HandleSprCarried:
	JSR CODE_019F9B
	LDA wm_PlayerTurningPose
	BNE +
	LDA wm_YoshiInPipe
	BNE +
	LDA wm_FaceCamImgTimer
	BEQ ++
+	STZ wm_SprOAMIndex,X
++	LDA wm_SpriteProp
	PHA
	LDA wm_YoshiInPipe
	BEQ +
	LDA #$10
	STA wm_SpriteProp
+	JSR CODE_01A187
	PLA
	STA wm_SpriteProp
	RTS

DATA_019F99:	.DB -4,4

CODE_019F9B:
	LDA wm_SpriteNum,X
	CMP #$7D
	BNE NotCarryingBalloon
	LDA wm_FrameA
	AND #$03
	BNE ++
	DEC wm_BalloonTimer
	BEQ +++
	LDA wm_BalloonTimer
	CMP #$30
	BCS ++
	LDY #$01
	AND #$04
	BEQ +
	LDY #$09
+	STY wm_PBalloonFrame
++	LDA wm_MarioAnimation
	CMP #$01
	BCC BalloonActive
+++	STZ wm_PBalloonFrame
	JMP _OffScrEraseSprite

BalloonActive:
	PHB
	LDA #:ControlSprCarried
	PHA
	PLB
	JSL ControlSprCarried
	PLB
	JSR CODE_01A0B1
	LDY wm_SprOAMIndex,X
	LDA #$F0
	STA wm_OamSlot.1.YPos,Y
	RTS

NotCarryingBalloon:
	JSR CODE_019140
	LDA wm_MarioAnimation
	CMP #$01
	BCC CODE_019FF4
	LDA wm_YoshiInPipe
	BNE CODE_019FF4
	LDA #$09
	STA wm_SpriteStatus,X
	RTS

CODE_019FF4:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ _Return01A014
	LDA wm_SpritesLocked
	BEQ CODE_01A002
	JMP CODE_01A0B1

CODE_01A002:
	JSR CODE_019624
	JSR SubSprSprInteract
	LDA wm_YoshiInPipe
	BNE +
	BIT wm_JoyPadA
	BVC ReleaseSprCarried
+	JSR CODE_01A0B1
_Return01A014:
	RTS

ReleaseSprCarried:
	STZ wm_SprChainKillTbl,X
	LDY #$00
	LDA wm_SpriteNum,X
	CMP #$0F
	BNE +
	LDA wm_IsFlying
	BNE +
	LDY #$EC
+	STY wm_SpriteSpeedY,X
	LDA #$09
	STA wm_SpriteStatus,X
	LDA wm_JoyPadA
	AND #$08
	BNE TossUpSprCarried
	LDA wm_SpriteNum,X
	CMP #$15
	BCS CODE_01A041
	LDA wm_JoyPadA
	AND #$04
	BEQ KickSprCarried
	BRA _01A047

CODE_01A041:
	LDA wm_JoyPadA
	AND #$03
	BNE KickSprCarried
_01A047:
	LDY wm_MarioDirection
	LDA wm_PlayerXPosLv
	CLC
	ADC DATA_019F67,Y
	STA wm_SpriteXLo,X
	LDA wm_PlayerXPosLv+1
	ADC DATA_019F69,Y
	STA wm_SpriteXHi,X
	JSR SubHorizPos
	LDA DATA_019F99,Y
	CLC
	ADC wm_MarioSpeedX
	STA wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	BRA _StartKickPose

TossUpSprCarried:
	JSL CODE_01AB6F
	LDA #$90
	STA wm_SpriteSpeedY,X
	LDA wm_MarioSpeedX
	STA wm_SpriteSpeedX,X
	ASL
	ROR wm_SpriteSpeedX,X
	BRA _StartKickPose

KickSprCarried:
	JSL CODE_01AB6F
	LDA wm_SpriteDecTbl1,X
	STA wm_SpriteState,X
	LDA #$0A
	STA wm_SpriteStatus,X
	LDY wm_MarioDirection
	LDA wm_OnYoshi
	BEQ +
	INY
	INY
+	LDA ShellSpeedX,Y
	STA wm_SpriteSpeedX,X
	EOR wm_MarioSpeedX
	BMI _StartKickPose
	LDA wm_MarioSpeedX
	STA m0
	ASL m0
	ROR
	CLC
	ADC ShellSpeedX,Y
	STA wm_SpriteSpeedX,X
_StartKickPose:
	LDA #$10
	STA wm_SpriteDecTbl2,X
	LDA #$0C
	STA wm_KickImgTimer
	RTS

CODE_01A0B1:
	LDY #$00
	LDA wm_MarioDirection
	BNE +
	INY
+	LDA wm_FaceCamImgTimer
	BEQ +
	INY
	INY
	CMP #$05
	BCC +
	INY
+	LDA wm_YoshiInPipe
	BEQ +
	CMP #$02
	BEQ ++
+	LDA wm_PlayerTurningPose
	ORA wm_IsClimbing
	BEQ +
++	LDY #$05
+	PHY
	LDY #$00
	LDA wm_IsOnSolidSpr
	CMP #$03
	BEQ +
	LDY #$3D
+	LDA.W wm_MarioXPos,Y
	STA m0
	LDA.W wm_MarioXPos+1,Y
	STA m1
	LDA.W wm_MarioYPos,Y
	STA m2
	LDA.W wm_MarioYPos+1,Y
	STA m3
	PLY
	LDA m0
	CLC
	ADC DATA_019F5B,Y
	STA wm_SpriteXLo,X
	LDA m1
	ADC DATA_019F61,Y
	STA wm_SpriteXHi,X
	LDA #$0D
	LDY wm_IsDucking
	BNE +
	LDY wm_MarioPowerUp
	BNE ++
+	LDA #$0F
++	LDY wm_PickUpImgTimer
	BEQ +
	LDA #$0F
+	CLC
	ADC m2
	STA wm_SpriteYLo,X
	LDA m3
	ADC #$00
	STA wm_SpriteYHi,X
	LDA #$01
	STA wm_IsCarrying2
	STA wm_IsCarrying
	RTS

StunGoomba:
	LDA wm_FrameB
	LSR
	LSR
	LDY wm_SpriteDecTbl1,X
	CPY #$30
	BCC +
	LSR
+	AND #$01
	STA wm_SpriteGfxTbl,X
	CPY #$08
	BNE +
	JSR IsOnGround
	BEQ +
	LDA #$D8
	STA wm_SpriteSpeedY,X
+	LDA #$80
	JMP SubSprGfx2Entry0

StunMechaKoopa:
	LDA wm_Bg1HOfs
	PHA
	LDA wm_SpriteDecTbl1,X
	CMP #$30
	BCS +
	AND #$01
	EOR wm_Bg1HOfs
	STA wm_Bg1HOfs
+	JSL CODE_03B307
	PLA
	STA wm_Bg1HOfs
_01A169:
	LDA wm_SpriteStatus,X
	CMP #$0B
	BNE +
	LDA wm_MarioDirection
	EOR #$01
	STA wm_SpriteDir,X
+	RTS

StunFish:
	JSR SetAnimationFrame
	LDA wm_SpritePal,X
	ORA #$80
	STA wm_SpritePal,X
	JSR SubSprGfx2Entry1
	RTS

CODE_01A187:
	LDA wm_Tweaker167A,X
	AND #$08
	BEQ CODE_01A1D0
	LDA wm_SpriteNum,X
	CMP #$A2
	BEQ StunMechaKoopa
	CMP #$15
	BEQ StunFish
	CMP #$16
	BEQ StunFish
	CMP #$0F
	BEQ StunGoomba
	CMP #$53
	BEQ StunThrowBlock
	CMP #$2C
	BEQ _StunYoshiEgg
	CMP #$80
	BEQ StunKey
	CMP #$7D
	BEQ _Return01A1D3
	CMP #$3E
	BEQ StunPow
	CMP #$2F
	BEQ StunSpringBoard
	CMP #$0D
	BEQ StunBomb
	CMP #$2D
	BEQ StunBabyYoshi
	CMP #$85
	BNE CODE_01A1D0
	JSR SubSprGfx2Entry1
	LDY wm_SprOAMIndex,X
	LDA #$47
	STA wm_OamSlot.1.Tile,Y
	RTS

CODE_01A1D0:
	JSR CODE_019806
_Return01A1D3:
	RTS

StunThrowBlock:
	LDA wm_SpriteDecTbl1,X
	CMP #$40
	BCS +
	LSR
	BCS _StunYoshiEgg
+	LDA wm_SpritePal,X
	INC A
	INC A
	AND #$0F
	STA wm_SpritePal,X
_StunYoshiEgg:
	JSR SubSprGfx2Entry1
	RTS

StunBomb:
	JSR SubSprGfx2Entry1
	LDA #$CA
	BRA _01A222

StunKey:
	JSR _01A169
	JSR SubSprGfx2Entry1
	LDA #$EC
	BRA _01A222

StunPow:
	LDY wm_SpriteDecTbl6,X
	BEQ CODE_01A218
	CPY #$01
	BNE CODE_01A209
	JMP _019ACB

CODE_01A209:
	JSR SmushedGfxRt
	LDY wm_SprOAMIndex,X
	LDA wm_OamSlot.1.Prop,Y
	AND #$FE
	STA wm_OamSlot.1.Prop,Y
	RTS

CODE_01A218:
	LDA #$01
	STA wm_SpriteDir,X
	JSR SubSprGfx2Entry1
	LDA #$42
_01A222:
	LDY wm_SprOAMIndex,X
	STA wm_OamSlot.1.Tile,Y
	RTS

StunSpringBoard:
	JMP _01E6F0

StunBabyYoshi:
	LDA wm_SpritesLocked
	BNE ++
	LDA wm_SpriteXLo,X
	CLC
	ADC #$08
	STA m0
	LDA wm_SpriteXHi,X
	ADC #$00
	STA m8
	LDA wm_SpriteYLo,X
	CLC
	ADC #$08
	STA m1
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m9
	JSL CODE_02B9FA
	JSL CODE_02EA4E
	LDA wm_SpriteDecTbl6,X
	BNE CODE_01A27E
	DEC A
	STA wm_SpriteMiscTbl8,X
	LDA wm_SpriteStatus,X
	CMP #$09
	BNE +
	JSR IsOnGround
	BEQ +
	LDA #$F0
	STA wm_SpriteSpeedY,X
+	LDY #$00
	LDA wm_FrameB
	AND #$18
	BNE +
	LDY #$03
+	TYA
	STA wm_SpriteGfxTbl,X
++	JMP _01A34F

CODE_01A27E:
	STZ wm_SprOAMIndex,X
	CMP #$20
	BEQ CODE_01A288
	JMP _01A30A

CODE_01A288:
	LDY wm_SpriteMiscTbl8,X
	LDA #$00
	STA wm_SpriteStatus,Y
	LDA #$06
	STA wm_SoundCh1
	LDA wm_SpriteMiscTbl8,Y
	BNE CODE_01A2F4
	LDA.W wm_SpriteNum,Y
	CMP #$81
	BNE +
	LDA wm_FrameB
	LSR
	LSR
	LSR
	LSR
	AND #$03
	TAY
	LDA ChangingItemSprite,Y
+	CMP #$74
	BCC CODE_01A2F4
	CMP #$78
	BCS CODE_01A2F4
_01A2B5:
	STZ wm_YoshiSwallowTimer
	STZ wm_YoshiHasWings
	LDA #$35
	STA.W wm_SpriteNum,X
	LDA #$08
	STA wm_SpriteStatus,X
	LDA #$1F
	STA wm_SoundCh3
	LDA wm_SpriteYLo,X
	SBC #$10
	STA wm_SpriteYLo,X
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,X
	LDA wm_SpritePal,X
	PHA
	JSL InitSpriteTables
	PLA
	AND #$FE
	STA wm_SpritePal,X
	LDA #$0C
	STA wm_SpriteGfxTbl,X
	DEC wm_SpriteMiscTbl8,X
	LDA #$40
	STA wm_YoshiGrowTimer
	RTS

CODE_01A2F4:
	INC wm_SpriteMiscTbl6,X
	LDA wm_SpriteMiscTbl6,X
	CMP #$05
	BNE CODE_01A300
	BRA _01A2B5

CODE_01A300:
	JSL CODE_05B34A
	LDA #$01
	JSL GivePoints
_01A30A:
	LDA wm_SpriteDecTbl6,X
	LSR
	LSR
	LSR
	TAY
	LDA DATA_01A35A,Y
	STA wm_SpriteGfxTbl,X
	STZ m1
	LDA wm_SpriteDecTbl6,X
	CMP #$20
	BCC _01A34F
	SBC #$10
	LSR
	LSR
	LDY wm_SpriteDir,X
	BEQ +
	EOR #$FF
	INC A
	DEC m1
+	LDY wm_SpriteMiscTbl8,X
	CLC
	ADC wm_SpriteXLo,X
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC m1
	STA wm_SpriteXHi,Y
	LDA wm_SpriteYLo,X
	SEC
	SBC #$02
	STA.W wm_SpriteYLo,Y
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_SpriteYHi,Y
_01A34F:
	JSR _01A169
	JSR SubSprGfx2Entry1
	JSL CODE_02EA25
	RTS

DATA_01A35A:	.DB 0,3,2,2,1,1,1

DATA_01A361:	.DB 16,32

DATA_01A363:	.DB 1,2

GetDrawInfoBnk1:
	STZ wm_OffscreenVert,X
	STZ wm_OffscreenHorz,X
	LDA wm_SpriteXLo,X
	CMP wm_Bg1HOfs
	LDA wm_SpriteXHi,X
	SBC wm_Bg1HOfs+1
	BEQ +
	INC wm_OffscreenHorz,X
+	LDA wm_SpriteXHi,X
	XBA
	LDA wm_SpriteXLo,X
	REP #$20
	SEC
	SBC wm_Bg1HOfs
	CLC
	ADC #$0040
	CMP #$0180
	SEP #$20
	ROL
	AND #$01
	STA wm_SpriteOffTbl,X
	BNE CODE_01A3CB
	LDY #$00
	LDA wm_SpriteStatus,X
	CMP #$09
	BEQ _f
	LDA wm_Tweaker190F,X
	AND #$20
	BEQ _f
	INY
__	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_01A361,Y
	PHP
	CMP wm_Bg1VOfs
	ROL m0
	PLP
	LDA wm_SpriteYHi,X
	ADC #$00
	LSR m0
	SBC wm_Bg1VOfs+1
	BEQ +
	LDA wm_OffscreenVert,X
	ORA DATA_01A363,Y
	STA wm_OffscreenVert,X
+	DEY
	BPL _b
	BRA _01A3CD

CODE_01A3CB:
	PLA
	PLA
_01A3CD:
	LDY wm_SprOAMIndex,X
	LDA wm_SpriteXLo,X
	SEC
	SBC wm_Bg1HOfs
	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_Bg1VOfs
	STA m1
	RTS

CODE_01A3DF:
	LDA wm_OffscreenVert,X
	BEQ _Return01A40A
	PHX
	LSR
	BCC +
	PHA
	LDA #$01
	STA wm_OamSize.1,Y
	TYA
	ASL
	ASL
	TAX
	LDA #$80
	STA wm_OamSlot.1.XPos,X
	PLA
+	LSR
	BCC +
	LDA #$01
	STA wm_OamSize.2,Y
	TYA
	ASL
	ASL
	TAX
	LDA #$80
	STA wm_OamSlot.2.XPos,X
+	PLX
_Return01A40A:
	RTS

DATA_01A40B:	.DB 2,10

SubSprSprInteract:
	TXA
	BEQ _Return01A40A
	TAY
	EOR wm_FrameA
	LSR
	BCC _Return01A40A
	DEX
_01A417:
	LDA wm_SpriteStatus,X
	CMP #$08
	BCS CODE_01A421
	JMP _01A4B0

CODE_01A421:
	LDA wm_Tweaker1686,X
	ORA wm_Tweaker1686,Y
	AND #$08
	ORA wm_SpriteDecTbl4,X
	ORA wm_SpriteDecTbl4,Y
	ORA wm_SpriteEatenTbl,X
	ORA wm_SprBehindScrn,X
	EOR wm_SprBehindScrn,Y
	BNE _01A4B0
	STX wm_CheckSprInter
	LDA wm_SpriteXLo,X
	STA m0
	LDA wm_SpriteXHi,X
	STA m1
	LDA.W wm_SpriteXLo,Y
	STA m2
	LDA wm_SpriteXHi,Y
	STA m3
	REP #$20
	LDA m0
	SEC
	SBC m2
	CLC
	ADC #$0010
	CMP #$0020
	SEP #$20
	BCS _01A4B0
	LDY #$00
	LDA wm_Tweaker1662,X
	AND #$0F
	BEQ +
	INY
+	LDA wm_SpriteYLo,X
	CLC
	ADC DATA_01A40B,Y
	STA m0
	LDA wm_SpriteYHi,X
	ADC #$00
	STA m1
	LDY wm_SprProcessIndex
	LDX #$00
	LDA wm_Tweaker1662,Y
	AND #$0F
	BEQ +
	INX
+	LDA.W wm_SpriteYLo,Y
	CLC
	ADC.W DATA_01A40B,X
	STA m2
	LDA wm_SpriteYHi,Y
	ADC #$00
	STA m3
	LDX wm_CheckSprInter
	REP #$20
	LDA m0
	SEC
	SBC m2
	CLC
	ADC #$000C
	CMP #$0018
	SEP #$20
	BCS _01A4B0
	JSR CODE_01A4BA
_01A4B0:
	DEX
	BMI CODE_01A4B6
	JMP _01A417

CODE_01A4B6:
	LDX wm_SprProcessIndex
	RTS

CODE_01A4BA:
	LDA wm_SpriteStatus,Y
	CMP #$08
	BEQ CODE_01A4CE
	CMP #$09
	BEQ CODE_01A4E2
	CMP #$0A
	BEQ CODE_01A506
	CMP #$0B
	BEQ CODE_01A51A
	RTS

CODE_01A4CE:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01A53D
	CMP #$09
	BEQ CODE_01A540
	CMP #$0A
	BEQ CODE_01A537
	CMP #$0B
	BEQ CODE_01A534
	RTS

CODE_01A4E2:
	LDA wm_SprObjStatus,Y
	AND #$04
	BNE CODE_01A4F2
	LDA.W wm_SpriteNum,Y
	CMP #$0F
	BEQ CODE_01A534
	BRA CODE_01A506

CODE_01A4F2:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01A540
	CMP #$09
	BEQ _01A555
	CMP #$0A
	BEQ ADDR_01A53A
	CMP #$0B
	BEQ CODE_01A534
	RTS

CODE_01A506:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01A52E
	CMP #$09
	BEQ CODE_01A531
	CMP #$0A
	BEQ CODE_01A534
	CMP #$0B
	BEQ CODE_01A534
	RTS

CODE_01A51A:
	LDA wm_SpriteStatus,X
	CMP #$08
	BEQ CODE_01A534
	CMP #$09
	BEQ CODE_01A534
	CMP #$0A
	BEQ CODE_01A534
	CMP #$0B
	BEQ CODE_01A534
	RTS

CODE_01A52E:
	JMP CODE_01A625

CODE_01A531:
	JMP CODE_01A642

CODE_01A534:
	JMP CODE_01A685

CODE_01A537:
	JMP CODE_01A5C4

ADDR_01A53A:
	JMP CODE_01A5C4

CODE_01A53D:
	JMP CODE_01A56D

CODE_01A540:
	JSR CODE_01A6D9
	PHX
	PHY
	TYA
	TXY
	TAX
	JSR CODE_01A6D9
	PLY
	PLX
	LDA wm_SpriteDecTbl3,X
	ORA wm_SpriteDecTbl3,Y
	BNE _Return01A5C3
_01A555:
	LDA wm_SpriteStatus,X
	CMP #$09
	BNE CODE_01A56D
	JSR IsOnGround
	BNE CODE_01A56D
	LDA wm_SpriteNum,X
	CMP #$0F
	BNE CODE_01A56A
	JMP CODE_01A685

CODE_01A56A:
	JMP CODE_01A5C4

CODE_01A56D:
	LDA wm_SpriteXLo,X
	SEC
	SBC.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	SBC wm_SpriteXHi,Y
	ROL
	AND #$01
	STA m0
	LDA wm_Tweaker1686,Y
	AND #$10
	BNE +
	LDY wm_SprProcessIndex
	LDA wm_SpriteDir,Y
	PHA
	LDA m0
	STA wm_SpriteDir,Y
	PLA
	CMP wm_SpriteDir,Y
	BEQ +
	LDA wm_SpriteDecTbl5,Y
	BNE +
	LDA #$08
	STA wm_SpriteDecTbl5,Y
+	LDA wm_Tweaker1686,X
	AND #$10
	BNE _Return01A5C3
	LDA wm_SpriteDir,X
	PHA
	LDA m0
	EOR #$01
	STA wm_SpriteDir,X
	PLA
	CMP wm_SpriteDir,X
	BEQ _Return01A5C3
	LDA wm_SpriteDecTbl5,X
	BNE _Return01A5C3
	LDA #$08
	STA wm_SpriteDecTbl5,X
_Return01A5C3:
	RTS

CODE_01A5C4:
	LDA.W wm_SpriteNum,Y
	SEC
	SBC #$83
	CMP #$02
	BCS CODE_01A5DA
	JSR FlipSpriteDir
	STZ wm_SpriteSpeedY,X
_01A5D3:
	PHX
	TYX
	JSR _01B4E2
	PLX
	RTS

CODE_01A5DA:
	LDX wm_SprProcessIndex
	LDY wm_CheckSprInter
	JSR CODE_01A77C
	LDA #$02
	STA wm_SpriteStatus,Y
	PHX
	TYX
	JSL _01AB72
	PLX
	LDA wm_SpriteSpeedX,X
	ASL
	LDA #$10
	BCC +
	LDA #$F0
+	STA.W wm_SpriteSpeedX,Y
	LDA #$D0
	STA.W wm_SpriteSpeedY,Y
	PHY
	INC wm_SprChainKillTbl,X
	LDY wm_SprChainKillTbl,X
	CPY #$08
	BCS +
	LDA DATA_01A61E-1,Y
	STA wm_SoundCh1
+	TYA
	CMP #$08
	BCC +
	LDA #$08
+	PLY
	JSL CODE_02ACE1
	RTS

DATA_01A61E:	.DB $13,$14,$15,$16,$17,$18,$19

CODE_01A625:
	LDA wm_SpriteNum,X
	SEC
	SBC #$83
	CMP #$02
	BCS CODE_01A63D
	PHX
	TYX
	JSR FlipSpriteDir
	PLX
	LDA #$00
	STA.W wm_SpriteSpeedY,Y
	JSR _01B4E2
	RTS

CODE_01A63D:
	JSR CODE_01A77C
	BRA CODE_01A64A

CODE_01A642:
	JSR IsOnGround
	BNE CODE_01A64A
	JMP CODE_01A685

CODE_01A64A:
	PHX
	LDA wm_SprChainKillTbl,Y
	INC A
	STA wm_SprChainKillTbl,Y
	LDX wm_SprChainKillTbl,Y
	CPX #$08
	BCS +
	LDA.W DATA_01A61E-1,X
	STA wm_SoundCh1
+	TXA
	CMP #$08
	BCC +
	LDA #$08
+	PLX
	JSL GivePoints
	LDA #$02
	STA wm_SpriteStatus,X
	JSL _01AB72
	LDA.W wm_SpriteSpeedX,Y
	ASL
	LDA #$10
	BCC +
	LDA #$F0
+	STA wm_SpriteSpeedX,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	RTS

CODE_01A685:
	LDA wm_SpriteNum,X
	CMP #$83
	BEQ ADDR_01A69A
	CMP #$84
	BEQ ADDR_01A69A
	LDA #$02
	STA wm_SpriteStatus,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	BRA _01A69D

ADDR_01A69A:
	JSR _01B4E2
_01A69D:
	LDA.W wm_SpriteNum,Y
	CMP #$80
	BEQ _01A6BB
	CMP #$83
	BEQ ADDR_01A6B8
	CMP #$84
	BEQ ADDR_01A6B8
	LDA #$02
	STA wm_SpriteStatus,Y
	LDA #$D0
	STA.W wm_SpriteSpeedY,Y
	BRA _01A6BB

ADDR_01A6B8:
	JSR _01A5D3
_01A6BB:
	JSL CODE_01AB6F
	LDA #$04
	JSL GivePoints
	LDA wm_SpriteSpeedX,X
	ASL
	LDA #$10
	BCS +
	LDA #$F0
+	STA wm_SpriteSpeedX,X
	EOR #$FF
	INC A
	STA.W wm_SpriteSpeedX,Y
	RTS

DATA_01A6D7:	.DB 48,-48

CODE_01A6D9:
	STY m0
	JSR IsOnGround
	BEQ _Return01A72D
	LDA wm_SprObjStatus,Y
	AND #$04
	BEQ _Return01A72D
	LDA wm_Tweaker1656,X
	AND #$40
	BEQ _Return01A72D
	LDA wm_SpriteDecTbl3,Y
	ORA wm_SpriteDecTbl3,X
	BNE _Return01A72D
	STZ m2
	LDA wm_SpriteXLo,X
	SEC
	SBC.W wm_SpriteXLo,Y
	BMI +
	INC m2
+	CLC
	ADC #$08
	CMP #$10
	BCC _Return01A72D
	LDA wm_SpriteDir,X
	CMP m2
	BNE _Return01A72D
	LDA wm_SpriteNum,X
	CMP #$02
	BNE HopIntoShell
	LDA #$20
	STA wm_SpriteDecTbl6,X
	STA wm_SpriteDecTbl3,X
	LDA #$23
	STA wm_SpriteDecTbl4,X
	TYA
	STA wm_SpriteMiscTbl8,X
	RTS

PlayKickSfx:
	LDA #$03
	STA wm_SoundCh1
_Return01A72D:
	RTS

HopIntoShell:
	LDA wm_SpriteDecTbl1,Y
	BNE _Return01A777
	LDA.W wm_SpriteNum,Y
	CMP #$0F
	BCS _Return01A777
	LDA wm_SprObjStatus,Y
	AND #$04
	BEQ _Return01A777
	LDA wm_SpritePal,Y
	BPL CODE_01A75D
	AND #$7F
	STA wm_SpritePal,Y
	LDA #$E0
	STA.W wm_SpriteSpeedY,Y
	LDA #$20
	STA wm_SpriteDecTbl4,Y
_01A755:
	LDA #$20
	STA wm_SpriteState,X
	STA wm_SpriteDecTbl3,X
	RTS

CODE_01A75D:
	LDA #$E0
	STA wm_SpriteSpeedY,X
	LDA wm_SprInWaterTbl,X
	CMP #$01
	LDA #$18
	BCC +
	LDA #$2C
+	STA wm_SpriteDecTbl3,X
	TXA
	STA wm_SpriteMiscTbl7,Y
	TYA
	STA wm_SpriteMiscTbl7,X
_Return01A777:
	RTS

DATA_01A778:	.DB 16,-16

DATA_01A77A:	.DB 0,-1

CODE_01A77C:
	LDA wm_SpriteNum,X
	CMP #$02
	BNE ++
	LDA wm_SprStompImmuneTbl,Y
	BNE ++
	LDA wm_SpriteDir,X
	CMP wm_SpriteDir,Y
	BEQ ++
	STY m1
	LDY wm_SpriteMiscTbl5,X
	BNE +
	STZ wm_SpriteMiscTbl4,X
	STZ wm_SpriteDecTbl6,X
	TAY
	STY m0
	LDA wm_SpriteXLo,X
	CLC
	ADC DATA_01A778,Y
	LDY m1
	STA.W wm_SpriteXLo,Y
	LDA wm_SpriteXHi,X
	LDY m0
	ADC DATA_01A77A,Y
	LDY m1
	STA wm_SpriteXHi,Y
	TYA
	STA wm_SpriteMiscTbl8,X
	LDA #$01
	STA wm_SpriteMiscTbl5,X
+	PLA
	PLA
++	LDX wm_CheckSprInter
	LDY wm_SprProcessIndex
	RTS

SpriteToSpawn:
	.DB $00,$01,$02,$03,$04,$05,$06,$07
	.DB $04,$04,$05,$05,$07,$00,$00,$0F
	.DB $0F,$0F,$0D

MarioSprInteract:
	PHB
	PHK
	PLB
	JSR MarioSprInteractRt
	PLB
	RTL

MarioSprInteractRt:
	LDA wm_Tweaker167A,X
	AND #$20
	BNE ProcessInteract
	TXA
	EOR wm_FrameA
	AND #$01
	ORA wm_OffscreenHorz,X
	BEQ ProcessInteract
_ReturnNoContact:
	CLC
	RTS

ProcessInteract:
	JSR SubHorizPos
	LDA m15
	CLC
	ADC #$50
	CMP #$A0
	BCS _ReturnNoContact
	JSR CODE_01AD42
	LDA m14
	CLC
	ADC #$60
	CMP #$C0
	BCS _ReturnNoContact
_01A80F:
	LDA wm_MarioAnimation
	CMP #$01
	BCS _ReturnNoContact
	LDA #$00
	BIT wm_LevelMode
	BVS +
	LDA wm_IsBehindScenery
	EOR wm_SprBehindScrn,X
+	BNE _ReturnNoContact2
	JSL GetMarioClipping
	JSL GetSpriteClippingA
	JSL CheckForContact
	BCC _ReturnNoContact2
	LDA wm_Tweaker167A,X
	BPL DefaultInteractR
	SEC
	RTS

DATA_01A839:	.DB -16,16

DefaultInteractR:
	LDA wm_StarPowerTimer
	BEQ CODE_01A87E
	LDA wm_Tweaker167A,X
	AND #$02
	BNE CODE_01A87E
_01A847:
	JSL CODE_01AB6F
	INC wm_StarKillPoints
	LDA wm_StarKillPoints
	CMP #$08
	BCC +
	LDA #$08
	STA wm_StarKillPoints
+	JSL GivePoints
	LDY wm_StarKillPoints
	CPY #$08
	BCS +
	LDA DATA_01A61E-1,Y
	STA wm_SoundCh1
+	LDA #$02
	STA wm_SpriteStatus,X
	LDA #$D0
	STA wm_SpriteSpeedY,X
	JSR SubHorizPos
	LDA DATA_01A839,Y
	STA wm_SpriteSpeedX,X
_ReturnNoContact2:
	CLC
	RTS

CODE_01A87E:
	STZ wm_StarKillPoints
	LDA wm_SpriteDecTbl2,X
	BNE +
	LDA #$08
	STA wm_SpriteDecTbl2,X
	LDA wm_SpriteStatus,X
	CMP #$09
	BNE CODE_01A897
	JSR CODE_01AA42
+	CLC
	RTS

CODE_01A897:
	LDA #$14
	STA m1
	LDA m5
	SEC
	SBC m1
	ROL m0
	CMP wm_PlayerYPosLv
	PHP
	LSR m0
	LDA m11
	SBC #$00
	PLP
	SBC wm_PlayerYPosLv+1
	BMI CODE_01A8E6
	LDA wm_MarioSpeedY
	BPL +
	LDA wm_Tweaker190F,X
	AND #$10
	BNE +
	LDA wm_SprChainStomped
	BEQ CODE_01A8E6
+	JSR IsOnGround
	BEQ +
	LDA wm_IsFlying
	BEQ CODE_01A8E6
+	LDA wm_Tweaker1656,X
	AND #$10
	BNE CODE_01A91C
	LDA wm_IsSpinJump
	ORA wm_OnYoshi
	BEQ CODE_01A8E6
_01A8D8:
	LDA #$02
	STA wm_SoundCh1
	JSL BoostMarioSpeed
	JSL DisplayContactGfx
	RTS

CODE_01A8E6:
	LDA wm_PlayerSlopePose
	BEQ CODE_01A8F9
	LDA wm_Tweaker190F,X
	AND #$04
	BNE CODE_01A8F9
	JSR PlayKickSfx
	JSR _01A847
	RTS

CODE_01A8F9:
	LDA wm_PlayerHurtTimer
	BNE ++
	LDA wm_OnYoshi
	BNE ++
	LDA wm_Tweaker1686,X
	AND #$10
	BNE +
	JSR SubHorizPos
	TYA
	STA wm_SpriteDir,X
+	LDA wm_SpriteNum,X
	CMP #$53
	BEQ ++
	JSL HurtMario
++	RTS

CODE_01A91C:
	LDA wm_IsSpinJump
	ORA wm_OnYoshi
	BEQ CODE_01A947
_01A924:
	JSL DisplayContactGfx
	LDA #$F8
	STA wm_MarioSpeedY
	LDA wm_OnYoshi
	BEQ +
	JSL BoostMarioSpeed
+	JSR _019ACB
	JSL CODE_07FC3B
	JSR CODE_01AB46
	LDA #$08
	STA wm_SoundCh1
	JMP _01A9F2

CODE_01A947:
	JSR _01A8D8
	LDA wm_SprStompImmuneTbl,X
	BEQ CODE_01A95D
	JSR SubHorizPos
	LDA #$18
	CPY #$00
	BEQ +
	LDA #$E8
+	STA wm_MarioSpeedX
	RTS

CODE_01A95D:
	JSR CODE_01AB46
	LDY wm_SpriteNum,X
	LDA wm_Tweaker1686,X
	AND #$40
	BEQ CODE_01A9BE
	CPY #$72
	BCC CODE_01A979
	PHX
	PHY
	JSL CODE_02EAF2
	PLY
	PLX
	LDA #$02
	BRA _01A99B

CODE_01A979:
	CPY #$6E
	BNE CODE_01A98A
	LDA #$02
	STA wm_SpriteState,X
	LDA #$FF
	STA wm_SpriteDecTbl1,X
	LDA #$6F
	BRA _01A99B

CODE_01A98A:
	CPY #$3F
	BCC CODE_01A998
	LDA #$80
	STA wm_SpriteDecTbl1,X
	LDA SpriteToSpawn-46,Y
	BRA _01A99B

CODE_01A998:
	LDA SpriteToSpawn,Y
_01A99B:
	STA wm_SpriteNum,X
	LDA wm_SpritePal,X
	AND #$0E
	STA m15
	JSL LoadSpriteTables
	LDA wm_SpritePal,X
	AND #$F1
	ORA m15
	STA wm_SpritePal,X
	STZ wm_SpriteSpeedY,X
	LDA wm_SpriteNum,X
	CMP #$02
	BNE +
	INC wm_SpriteMiscTbl3,X
+	RTS

CODE_01A9BE:
	LDA wm_SpriteNum,X
	SEC
	SBC #$04
	CMP #$0D
	BCS +
	LDA wm_CapeGlidePhase
	BNE ++
+	LDA wm_Tweaker1656,X
	AND #$20
	BEQ CODE_01A9E2
++	LDA #$03
	STA wm_SpriteStatus,X
	LDA #$20
	STA wm_SpriteDecTbl1,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
	RTS

CODE_01A9E2:
	LDA wm_Tweaker1662,X
	AND #$80
	BEQ CODE_01AA01
	LDA #$02
	STA wm_SpriteStatus,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteSpeedY,X
_01A9F2:
	LDA wm_SpriteNum,X
	CMP #$1E
	BNE +
	LDY wm_LakituCloudSlot
	LDA #$1F
	STA wm_SpriteDecTbl1,Y
+	RTS

CODE_01AA01:
	LDY wm_SpriteStatus,X
	STZ wm_SprChainKillTbl,X
	CPY #$08
	BEQ SetStunnedTimer
_01AA0B:
	LDA wm_SpriteState,X
	BNE SetStunnedTimer
	STZ wm_SpriteDecTbl1,X
	BRA _SetAsStunned

SetStunnedTimer:
	LDA #$02
	LDY wm_SpriteNum,X
	CPY #$0F
	BEQ +
	CPY #$11
	BEQ +
	CPY #$A2
	BEQ +
	CPY #$0D
	BNE ++
+	LDA #$FF
++	STA wm_SpriteDecTbl1,X
_SetAsStunned:
	LDA #$09
	STA wm_SpriteStatus,X
	RTS

BoostMarioSpeed:
	LDA wm_IsClimbing
	BNE ++
	LDA #$D0
	BIT wm_JoyPadA
	BPL +
	LDA #$A8
+	STA wm_MarioSpeedY
++	RTL

CODE_01AA42:
	LDA wm_IsSpinJump
	ORA wm_OnYoshi
	BEQ CODE_01AA58
	LDA wm_MarioSpeedY
	BMI CODE_01AA58
	LDA wm_Tweaker1656,X
	AND #$10
	BEQ CODE_01AA58
	JMP _01A924

CODE_01AA58:
	LDA wm_JoyPadA
	AND #$40
	BEQ CODE_01AA74
	LDA wm_IsCarrying
	ORA wm_OnYoshi
	BNE CODE_01AA74
	LDA #$0B
	STA wm_SpriteStatus,X
	INC wm_IsCarrying
	LDA #$08
	STA wm_PickUpImgTimer
	RTS

CODE_01AA74:
	LDA wm_SpriteNum,X
	CMP #$80
	BEQ _01AAB7
	CMP #$3E
	BEQ CODE_01AAB2
	CMP #$0D
	BEQ _01AA97
	CMP #$2D
	BEQ _01AA97
	CMP #$A2
	BEQ _01AA97
	CMP #$0F
	BNE CODE_01AA94
	LDA #$F0
	STA wm_SpriteSpeedY,X
	BRA _01AA97

CODE_01AA94:
	JSR CODE_01AB46
_01AA97:
	JSR PlayKickSfx
	LDA wm_SpriteDecTbl1,X
	STA wm_SpriteState,X
	LDA #$0A
	STA wm_SpriteStatus,X
	LDA #$10
	STA wm_SpriteDecTbl2,X
	JSR SubHorizPos
	LDA ShellSpeedX,Y
	STA wm_SpriteSpeedX,X
	RTS

CODE_01AAB2:
	LDA wm_SpriteDecTbl6,X
	BNE _Return01AB2C
_01AAB7:
	STZ wm_SpriteDecTbl2,X
	LDA wm_SpriteYLo,X
	SEC
	SBC wm_PlayerYPosLv
	CLC
	ADC #$08
	CMP #$20
	BCC CODE_01AB31
	BPL CODE_01AACD
	LDA #$10
	STA wm_MarioSpeedY
	RTS

CODE_01AACD:
	LDA wm_MarioSpeedY
	BMI _Return01AB2C
	STZ wm_MarioSpeedY
	STZ wm_IsFlying
	INC wm_IsOnSolidSpr
	LDA #$1F
	LDY wm_OnYoshi
	BEQ +
	LDA #$2F
+	STA m0
	LDA wm_SpriteYLo,X
	SEC
	SBC m0
	STA wm_MarioYPos
	LDA wm_SpriteYHi,X
	SBC #$00
	STA wm_MarioYPos+1
	LDA wm_SpriteNum,X
	CMP #$3E
	BNE _Return01AB2C
	ASL wm_Tweaker167A,X
	LSR wm_Tweaker167A,X
	LDA #$0B
	STA wm_SoundCh1
	LDA wm_LevelMusicMod
	BMI +
	LDA #$0E
	STA wm_MusicCh1
+	LDA #$20
	STA wm_SpriteDecTbl6,X
	LSR wm_SpritePal,X
	ASL wm_SpritePal,X
	LDY wm_SpriteMiscTbl3,X
	LDA #$B0
	STA wm_BluePowTimer,Y
	LDA #$20
	STA wm_ShakeGrndTimer
	CPY #$01
	BNE _Return01AB2C
	JSL CODE_02B9BD
_Return01AB2C:
	RTS

DATA_01AB2D:	.DW 1,-1

CODE_01AB31:
	STZ wm_MarioSpeedX
	JSR SubHorizPos
	TYA
	ASL
	TAY
	REP #$20
	LDA wm_MarioXPos
	CLC
	ADC DATA_01AB2D,Y
	STA wm_MarioXPos
	SEP #$20
	RTS

CODE_01AB46:
	PHY
	LDA wm_SprChainStomped
	CLC
	ADC wm_SprChainKillTbl,X
	INC wm_SprChainStomped
	TAY
	INY
	CPY #$08
	BCS +
	LDA DATA_01A61E-1,Y
	STA wm_SoundCh1
+	TYA
	CMP #$08
	BCC +
	LDA #$08
+	JSL GivePoints
	PLY
	RTS

UNK_01AB6A:	.DB $0C,$FC,$EC,$DC,$CC

CODE_01AB6F:
	JSR PlayKickSfx
_01AB72:
	JSR IsSprOffScreen
	BNE ++
	PHY
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ +
	DEY
	BPL -
	INY
+	LDA #$02
	STA wm_SmokeSprite,Y
	LDA wm_SpriteXLo,X
	STA wm_SmokeXPos,Y
	LDA wm_SpriteYLo,X
	STA wm_SmokeYPos,Y
	LDA #$08
	STA wm_SmokeTimer,Y
	PLY
++	RTL

DisplayContactGfx:
	JSR IsSprOffScreen
	BNE ++
	PHY
	LDY #$03
-	LDA wm_SmokeSprite,Y
	BEQ +
	DEY
	BPL -
	INY
+	LDA #$02
	STA wm_SmokeSprite,Y
	LDA wm_MarioXPos
	STA wm_SmokeXPos,Y
	LDA wm_OnYoshi
	CMP #$01
	LDA #$14
	BCC +
	LDA #$1E
+	CLC
	ADC wm_MarioYPos
	STA wm_SmokeYPos,Y
	LDA #$08
	STA wm_SmokeTimer,Y
	PLY
++	RTL

SubSprXPosNoGrvty:
	TXA
	CLC
	ADC #$0C
	TAX
	JSR SubSprYPosNoGrvty
	LDX wm_SprProcessIndex
	RTS

SubSprYPosNoGrvty:
	LDA wm_SpriteSpeedY,X
	BEQ ++
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC wm_SpriteYAcc,X
	STA wm_SpriteYAcc,X
	PHP
	PHP
	LDY #$00
	LDA wm_SpriteSpeedY,X
	LSR
	LSR
	LSR
	LSR
	CMP #$08
	BCC +
	ORA #$F0
	DEY
+	PLP
	PHA
	ADC wm_SpriteYLo,X
	STA wm_SpriteYLo,X
	TYA
	ADC wm_SpriteYHi,X
	STA wm_SpriteYHi,X
	PLA
	PLP
	ADC #$00
++	STA wm_SprPixelMove
	RTS

SpriteOffScreen1:	.DB 64,-80

SpriteOffScreen2:	.DB 1,-1

SpriteOffScreen3:	.DB 48,-64,-96,-64,-96,-16,96,-112

SpriteOffScreen4:	.DB 1,-1,1,-1,1,-1,1,-1

SubOffscreen3Bnk1:
	LDA #$06
	STA m3
	BRA _01AC2D

SubOffscreen2Bnk1:
	LDA #$04
	BRA _01AC2D

SubOffscreen1Bnk1:
	LDA #$02
_01AC2D:
	STA m3
	BRA _01AC33

SubOffscreen0Bnk1:
	STZ m3
_01AC33:
	JSR IsSprOffScreen
	BEQ _Return01ACA4
	LDA wm_IsVerticalLvl
	AND #$01
	BNE VerticalLevel
	LDA wm_SpriteYLo,X
	CLC
	ADC #$50
	LDA wm_SpriteYHi,X
	ADC #$00
	CMP #$02
	BPL _OffScrEraseSprite
	LDA wm_Tweaker167A,X
	AND #$04
	BNE _Return01ACA4
	LDA wm_FrameA
	AND #$01
	ORA m3
	STA m1
	TAY
	LDA wm_Bg1HOfs
	CLC
	ADC SpriteOffScreen3,Y
	ROL m0
	CMP wm_SpriteXLo,X
	PHP
	LDA wm_Bg1HOfs+1
	LSR m0
	ADC SpriteOffScreen4,Y
	PLP
	SBC wm_SpriteXHi,X
	STA m0
	LSR m1
	BCC +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return01ACA4
_OffScrEraseSprite:
	LDA wm_SpriteNum,X
	CMP #$1F
	BNE +
	STA wm_SpriteToRespawn
	LDA #$FF
	STA wm_TimeTillRespawn
+	LDA wm_SpriteStatus,X
	CMP #$08
	BCC +
	LDY wm_SprIndexInLvl,X
	CPY #$FF
	BEQ +
	LDA #$00
	STA wm_SprLoadStatus,Y
+	STZ wm_SpriteStatus,X
_Return01ACA4:
	RTS

VerticalLevel:
	LDA wm_Tweaker167A,X
	AND #$04
	BNE _Return01ACA4
	LDA wm_FrameA
	LSR
	BCS _Return01ACA4
	LDA wm_SpriteXLo,X
	CMP #$00
	LDA wm_SpriteXHi,X
	SBC #$00
	CMP #$02
	BCS _OffScrEraseSprite
	LDA wm_FrameA
	LSR
	AND #$01
	STA m1
	TAY
	BEQ +
	LDA wm_SpriteNum,X
	CMP #$22
	BEQ _Return01ACA4
	CMP #$24
	BEQ _Return01ACA4
+	LDA wm_Bg1VOfs
	CLC
	ADC SpriteOffScreen1,Y
	ROL m0
	CMP wm_SpriteYLo,X
	PHP
	LDA.W wm_Bg1VOfs+1
	LSR m0
	ADC SpriteOffScreen2,Y
	PLP
	SBC wm_SpriteYHi,X
	STA m0
	LDY m1
	BEQ +
	EOR #$80
	STA m0
+	LDA m0
	BPL _Return01ACA4
	BMI _OffScrEraseSprite ; [BRA FIX]

GetRand:
	PHY
	LDY #$01
	JSL CODE_01AD07
	DEY
	JSL CODE_01AD07
	PLY
	RTL

CODE_01AD07:
	LDA wm_RandomByteNext
	ASL
	ASL
	SEC
	ADC wm_RandomByteNext
	STA wm_RandomByteNext
	ASL wm_RandomByteNext+1
	LDA #$20
	BIT wm_RandomByteNext+1
	BCC CODE_01AD21
	BEQ _01AD26
	BNE _01AD23 ; [BRA FIX]

CODE_01AD21:
	BNE _01AD26
_01AD23:
	INC wm_RandomByteNext+1
_01AD26:
	LDA wm_RandomByteNext+1
	EOR wm_RandomByteNext
	STA wm_RandomByte1,Y
	RTL

SubHorizPos:
	LDY #$00
	LDA wm_PlayerXPosLv
	SEC
	SBC wm_SpriteXLo,X
	STA m15
	LDA wm_PlayerXPosLv+1
	SBC wm_SpriteXHi,X
	BPL +
	INY
+	RTS

CODE_01AD42:
	LDY #$00
	LDA wm_PlayerYPosLv
	SEC
	SBC wm_SpriteYLo,X
	STA m14
	LDA wm_PlayerYPosLv+1
	SBC wm_SpriteYHi,X
	BPL +
	INY
+	RTS

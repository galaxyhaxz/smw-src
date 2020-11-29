; Structures
.STRUCT MAP16_PAGE
Page					DS $0200
.ENDST

.STRUCT MAP16_SET
Set						DS $01B0
.ENDST

.STRUCT MSG_BUF
Buf1					DS $C0
Buf2					DS $C0
Buf3					DS $C0
Buf4					DS $C0
.ENDST

.STRUCT OAM_SLOT
XPos					DB
YPos					DB
Tile					DB
Prop					DB
.ENDST

.STRUCT OAM_SIZE
Size					DB
.ENDST

.STRUCT SPR_TBL
Spr1					DB
Spr2					DB
Spr3					DB
Spr4					DB
Spr5					DB
Spr6					DB
Spr7					DB
Spr8					DB
Spr9					DB
Spr10					DB
Spr11					DB
Spr12					DB
.ENDST

.STRUCT OW_SPR_TBL
Spr1					DB
Spr2					DB
Spr3					DB
Spr4					DB
Spr5					DB
Spr6					DB
Spr7					DB
Spr8					DB
Spr9					DB
Spr10					DB
Spr11					DB
Spr12					DB
Spr13					DB
Spr14					DB
Spr15					DB
Spr16					DB
.ENDST

.STRUCT CLUS_SPR_TBL
Spr1					DB
Spr2					DB
Spr3					DB
Spr4					DB
Spr5					DB
Spr6					DB
Spr7					DB
Spr8					DB
Spr9					DB
Spr10					DB
Spr11					DB
Spr12					DB
Spr13					DB
Spr14					DB
Spr15					DB
Spr16					DB
Spr17					DB
Spr18					DB
Spr19					DB
Spr20					DB
.ENDST

.STRUCT LAYER_TILES
TopLeft					DS 64
TopRight				DS 64
BottomLeft				DS 64
BottomRight				DS 64
.ENDST

.STRUCT OW_LV_FLAGS
Lv000					DB
Lv001					DB
Lv002					DB
Lv003					DB
Lv004					DB
Lv005					DB
Lv006					DB
Lv007					DB
Lv008					DB
Lv009					DB
Lv00A					DB
Lv00B					DB
Lv00C					DB
Lv00D					DB
Lv00E					DB
Lv00F					DB
Lv010					DB
Lv011					DB
Lv012					DB
Lv013					DB
Lv014					DB
Lv015					DB
Lv016					DB
Lv017					DB
Lv018					DB
Lv019					DB
Lv01A					DB
Lv01B					DB
Lv01C					DB
Lv01D					DB
Lv01E					DB
Lv01F					DB
Lv020					DB
Lv021					DB
Lv022					DB
Lv023					DB
Lv024					DB
Lv101					DB
Lv102					DB
Lv103					DB
Lv104					DB
Lv105					DB
Lv106					DB
Lv107					DB
Lv108					DB
Lv109					DB
Lv10A					DB
Lv10B					DB
Lv10C					DB
Lv10D					DB
Lv10E					DB
Lv10F					DB
Lv110					DB
Lv111					DB
Lv112					DB
Lv113					DB
Lv114					DB
Lv115					DB
Lv116					DB
Lv117					DB
Lv118					DB
Lv119					DB
Lv11A					DB
Lv11B					DB
Lv11C					DB
Lv11D					DB
Lv11E					DB
Lv11F					DB
Lv120					DB
Lv121					DB
Lv122					DB
Lv123					DB
Lv124					DB
Lv125					DB
Lv126					DB
Lv127					DB
Lv128					DB
Lv129					DB
Lv12A					DB
Lv12B					DB
Lv12C					DB
Lv12D					DB
Lv12E					DB
Lv12F					DB
Lv130					DB
Lv131					DB
Lv132					DB
Lv133					DB
Lv134					DB
Lv135					DB
Lv136					DB
Lv137					DB
Lv138					DB
Lv139					DB
Lv13A					DB
Lv13B					DB
.ENDST

.STRUCT SUB_CLEAR_OAM
LoadYPos				DW ; LDA #$F0
ExOam1					DS 3 ; STA $0201
ExOam2					DS 3 ; STA $0205
ExOam3					DS 3 ; STA $0209 (...)
ExOam4					DS 3
ExOam5					DS 3
ExOam6					DS 3
ExOam7					DS 3
ExOam8					DS 3
ExOam9					DS 3
ExOam10					DS 3
ExOam11					DS 3
ExOam12					DS 3
ExOam13					DS 3
ExOam14					DS 3
ExOam15					DS 3
ExOam16					DS 3
ExOam17					DS 3
ExOam18					DS 3
ExOam19					DS 3
ExOam20					DS 3
ExOam21					DS 3
ExOam22					DS 3
ExOam23					DS 3
ExOam24					DS 3
ExOam25					DS 3
ExOam26					DS 3
ExOam27					DS 3
ExOam28					DS 3
ExOam29					DS 3
ExOam30					DS 3
ExOam31					DS 3
ExOam32					DS 3
ExOam33					DS 3
ExOam34					DS 3
ExOam35					DS 3
ExOam36					DS 3
ExOam37					DS 3
ExOam38					DS 3
ExOam39					DS 3
ExOam40					DS 3
ExOam41					DS 3
ExOam42					DS 3
ExOam43					DS 3
ExOam44					DS 3
ExOam45					DS 3
ExOam46					DS 3
ExOam47					DS 3
ExOam48					DS 3
ExOam49					DS 3
ExOam50					DS 3
ExOam51					DS 3
ExOam52					DS 3
ExOam53					DS 3
ExOam54					DS 3
ExOam55					DS 3
ExOam56					DS 3
ExOam57					DS 3
ExOam58					DS 3
ExOam59					DS 3
ExOam60					DS 3
ExOam61					DS 3
ExOam62					DS 3
ExOam63					DS 3
ExOam64					DS 3
Oam1					DS 3 ; STA $0301
Oam2					DS 3 ; STA $0305
Oam3					DS 3 ; STA $0309 (...)
Oam4					DS 3
Oam5					DS 3
Oam6					DS 3
Oam7					DS 3
Oam8					DS 3
Oam9					DS 3
Oam10					DS 3
Oam11					DS 3
Oam12					DS 3
Oam13					DS 3
Oam14					DS 3
Oam15					DS 3
Oam16					DS 3
Oam17					DS 3
Oam18					DS 3
Oam19					DS 3
Oam20					DS 3
Oam21					DS 3
Oam22					DS 3
Oam23					DS 3
Oam24					DS 3
Oam25					DS 3
Oam26					DS 3
Oam27					DS 3
Oam28					DS 3
Oam29					DS 3
Oam30					DS 3
Oam31					DS 3
Oam32					DS 3
Oam33					DS 3
Oam34					DS 3
Oam35					DS 3
Oam36					DS 3
Oam37					DS 3
Oam38					DS 3
Oam39					DS 3
Oam40					DS 3
Oam41					DS 3
Oam42					DS 3
Oam43					DS 3
Oam44					DS 3
Oam45					DS 3
Oam46					DS 3
Oam47					DS 3
Oam48					DS 3
Oam49					DS 3
Oam50					DS 3
Oam51					DS 3
Oam52					DS 3
Oam53					DS 3
Oam54					DS 3
Oam55					DS 3
Oam56					DS 3
Oam57					DS 3
Oam58					DS 3
Oam59					DS 3
Oam60					DS 3
Oam61					DS 3
Oam62					DS 3
Oam63					DS 3
Oam64					DS 3
Return					DB ; RTL
.ENDST

.STRUCT VRAM_IMG
Img						DS 0
ImgL					DB
ImgH					DB
.ENDST

.STRUCT COL_DATA
Col						DS 0
ColL					DB
ColH					DB
.ENDST

.STRUCT OW_DATA_BUFFER
OwLvFlags				INSTANCEOF OW_LV_FLAGS
OwEventFlags			DS 15
MarioMap				DB
LuigiMap				DB
PlayerAnim				DS 4
MarioXPos				DW
MarioYPos				DW
LuigiXPos				DW
LuigiYPos				DW
MarioXPtr				DW
MarioYPtr				DW
LuigiXPtr				DW
LuigiYPtr				DW
SwitchBlkFlags			DS 4
Empty					DS 3
EventsTriggered			DB
.ENDST

.STRUCT STAT_BAR
L1						DS 0
Player					DS 5
Blank1					DB
YoshiCoins				DS 4
BonusStarsT				DW
ItemBoxT				DS 4
Blank2					DB
TimeTiles				DS 3
Blank3					DS 3
CoinTile				DW
Blank4					DB
Coins					DW
L2						DS 0
LifeTile				DB
Lives					DW
Blank5					DS 3
BonusStarTiles			DW
Blank6					DB
BonusStarsB				DW
ItemBoxB				DS 4
Blank7					DB
Time					DS 3
Blank8					DB
Score					DS 6
ScoreZero				DB
.ENDST

; Variable RAM, used for temporary storage.
.ENUM $00
m0						DB ; $00
m1						DB ; $01
m2						DB ; $02
m3						DB ; $03
m4						DB ; $04
m5						DB ; $05
m6						DB ; $06
m7						DB ; $07
m8						DB ; $08
m9						DB ; $09
m10						DB ; $0A
m11						DB ; $0B
m12						DB ; $0C
m13						DB ; $0D
m14						DB ; $0E
m15						DB ; $0F
.ENDE

; [ZERO PAGE] Main RAM, used for everything else.
.ENUM $10
wm_ExecuteGame			DB ; $10
wm_IRQMode				DB ; $11
wm_ImageLoader			DB ; $12
wm_FrameA				DB ; $13
wm_FrameB				DB ; $14
wm_JoyPadA				DB ; $15
wm_JoyFrameA			DB ; $16
wm_JoyPadB				DB ; $17
wm_JoyFrameB			DB ; $18
wm_MarioPowerUp			DB ; $19
wm_Bg1HOfs				DW ; $1A
wm_Bg1VOfs				DW ; $1C
wm_Bg2HOfs				DW ; $1E
wm_Bg2VOfs				DW ; $20
wm_Bg3HOfs				DW ; $22
wm_Bg3VOfs				DW ; $24
wm_26					DB ; $26
wm_27					DB ; $27
wm_28					DB ; $28
wm_29					DB ; $29
wm_M7X					DW ; $2A
wm_M7Y					DW ; $2C
wm_M7A					DW ; $2E
wm_M7B					DW ; $30
wm_M7C					DW ; $32
wm_M7D					DW ; $34
wm_M7Rotate				DW ; $36
wm_M7Scale				DW ; $38
wm_M7Bg1HOfs			DW ; $3A
wm_M7Bg1VOfs			DW ; $3C
wm_BgMode				DB ; $3E
wm_OAMAddL				DB ; $3F
wm_CgAdSub				DB ; $40
wm_W12Sel				DB ; $41
wm_W34Sel				DB ; $42
wm_WObjSel				DB ; $43
wm_CgSwSel				DB ; $44
wm_Map16L1UploadLU		DW ; $45
wm_Map16L1UploadRD		DW ; $47
wm_Map16L2UploadLU		DW ; $49
wm_Map16L2UploadRD		DW ; $4B
wm_Map16L1LastLU		DW ; $4D
wm_Map16L1LastRD		DW ; $4F
wm_Map16L2LastLU		DW ; $51
wm_Map16L2LastRD		DW ; $53
wm_Layer1ScrollDir		DB ; $55
wm_Layer2ScrollDir		DB ; $56
wm_BlockSubScrPos		DW ; $57
wm_BlockSizeType		DB ; $59
wm_BlockNum				DB ; $5A
wm_IsVerticalLvl		DW ; $5B
wm_ScreensInLvl			DB ; $5D
wm_LastScreenHorz		DB ; $5E
wm_LastScreenVert		DB ; $5F
wm_unk60				DS 4 ; $60
wm_SpriteProp			DB ; $64
wm_Bg1Ptr				DL ; $65
wm_Bg2Ptr				DL ; $68
wm_Map16BlkPtrL			DL ; $6B
wm_Map16BlkPtrH			DL ; $6E
wm_MarioAnimation		DB ; $71
wm_IsFlying				DB ; $72
wm_IsDucking			DB ; $73
wm_IsClimbing			DB ; $74
wm_IsSwimming			DB ; $75
wm_MarioDirection		DB ; $76
wm_MarioObjStatus		DB ; $77
wm_HidePlayer			DB ; $78
wm_unk79				DB ; $79
wm_MarioAccSpeedX		DB ; $7A
wm_MarioSpeedX			DB ; $7B
wm_unk7C				DB ; $7C
wm_MarioSpeedY			DB ; $7D
wm_MarioScrPosX			DW ; $7E
wm_MarioScrPosY			DW ; $80
wm_SlopeSteepness		DW ; $82
wm_SlopePart			DB ; $84
wm_IsWaterLevel			DB ; $85
wm_IsSlipperyLevel		DB ; $86
wm_unk87				DB ; $87
wm_PipeWarpTimer		DB ; $88
wm_PipeAction			DB ; $89
wm_8A					DB ; $8A
wm_8B					DB ; $8B
wm_8C					DB ; $8C
wm_8D					DB ; $8D
wm_8E					DB ; $8E
wm_8F					DB ; $8F
wm_PlayerBlkPosY		DB ; $90
wm_PlayerExitBlkPos		DB ; $91
wm_PlayerBlkPosX		DB ; $92
wm_PlayerBlkSide		DB ; $93
wm_MarioXPos			DW ; $94
wm_MarioYPos			DW ; $96
wm_BlockXPos			DW ; $98
wm_BlockYPos			DW ; $9A
wm_BlockId				DB ; $9C
wm_SpritesLocked		DB ; $9D
wm_SpriteNum			INSTANCEOF SPR_TBL ; $9E
wm_SpriteSpeedY			INSTANCEOF SPR_TBL ; $AA
wm_SpriteSpeedX			INSTANCEOF SPR_TBL ; $B6
wm_SpriteState			INSTANCEOF SPR_TBL ; $C2
wm_SprPtr				DL ; $CE
wm_PlayerXPosLv			DW ; $D1
wm_PlayerYPosLv			DW ; $D3
wm_WigglerPosPtr		DL ; $D5
wm_SpriteYLo			INSTANCEOF SPR_TBL ; $D8
wm_SpriteXLo			INSTANCEOF SPR_TBL ; $E4
wm_unkF0				DS 16 ; $F0-$FF empty
.ENDE

; [DIRECT PAGE]
.ENUM $0100
wm_GameMode				DB ; $0100
wm_SpriteGfxSet			DS 4 ; $0101
wm_LayerGfxSet			DS 4 ; $0105
wm_ForceLoadLevel		DB ; $0109
wm_SaveFile				DB ; $010A
wm_Stack				DS 245 ; $010B-$01FF
wm_ExOamSlot			INSTANCEOF OAM_SLOT 64 ; $0200-$02FF
wm_OamSlot				INSTANCEOF OAM_SLOT 64 ; $0300-$03FF
wm_OamHiX				DS 32 ; $0400-$041F
wm_ExOamSize			INSTANCEOF OAM_SIZE 64 ; $0420-$045F
wm_OamSize				INSTANCEOF OAM_SIZE 64 ; $0460-$049F
wm_HDMAWindowsTbl		DS 480 ; $04A0 FIX make table!!! ; BUGFIX -> should be 512 bytes (DS 512) to prevent overwriting palette data
wm_PalUploadIndex		DB ; $0680
wm_PalSprIndex			DB ; $0681
wm_PalUplSize			DB ; $0682
wm_PalColNum			DB ; $0683
wm_PalColData			INSTANCEOF COL_DATA 8 ; $0684-$0693
wm_PalColTerm			DB ; $0694
wm_unk0695				DS 108 ; $0695
wm_LvBgColor			DW ; $0701
wm_Palette				INSTANCEOF COL_DATA 256 ; $0703-$0902
wm_LvBgColorCopy		DW ; $0903
wm_PaletteCopy			INSTANCEOF COL_DATA 248 ; $0905 ; $0905-$0AF4
wm_0AF5					DB ; $0AF5 ; unused boss battle beaten
wm_0AF6					DS 256 ; $0AF6 ; $0AF6-$0BF5 FIX make table?
wm_Sp1GfxDecomp			DS 384 ; $0BF6 ; $0BF6-$0D75
wm_GfxAnimFrame1		DW ; $0D76
wm_GfxAnimFrame2		DW ; $0D78
wm_GfxAnimFrame3		DW ; $0D7A
wm_GfxAnimVma1			DW ; $0D7C
wm_GfxAnimVma2			DW ; $0D7E
wm_GfxAnimVma3			DW ; $0D80
wm_PlayerPalPtr			DW ; $0D82
wm_PlayerDmaTiles		DB ; $0D84
wm_0D85					DS 20 ; $0D85 ; $0D85-$0D98 yoshi/podoboo/player tiles MAKE TABLE FIX
wm_Tile7FPtr			DW ; $0D99
wm_LevelMode			DB ; $0D9B
wm_unk0D9C				DB ; $0D9C empty
wm_TM_TMW				DB ; $0D9D
wm_TS_TSW				DB ; $0D9E
wm_HDMAEn				DB ; $0D9F
wm_JoyPort				DB ; $0DA0
wm_0DA1					DB ; $0DA1 empty
wm_JoyPadAP1			DB ; $0DA2
wm_JoyPadAP2			DB ; $0DA3
wm_JoyPadBP1			DB ; $0DA4
wm_JoyPadBP2			DB ; $0DA5
wm_JoyFrameAP1			DB ; $0DA6
wm_JoyFrameAP2			DB ; $0DA7
wm_JoyFrameBP1			DB ; $0DA8
wm_JoyFrameBP2			DB ; $0DA9
wm_JoyDisP1L			DB ; $0DAA
wm_JoyDisP2L			DB ; $0DAB
wm_JoyDisP1H			DB ; $0DAC
wm_JoyDisP2H			DB ; $0DAD
wm_IniDisp				DB ; $0DAE
wm_MosaicDir			DB ; $0DAF
wm_MosaicSize			DB ; $0DB0
wm_KeepGameActive		DB ; $0DB1
wm_2PlayerGame			DB ; $0DB2
wm_OWCharA				DB ; $0DB3
wm_2PMarioLives			DB ; $0DB4
wm_2PLuigiLives			DB ; $0DB5
wm_2PlayerCoins			DW ; $0DB6
wm_2PlayerPowerUp		DW ; $0DB8
wm_PlyrYoshiColor		DW ; $0DBA
wm_ItemInMarioBox		DB ; $0DBC
wm_ItemInLuigiBox		DB ; $0DBD
wm_StatusLives			DB ; $0DBE
wm_StatusCoins			DB ; $0DBF
wm_GreenStarCoins		DB ; $0DC0
wm_OWHasYoshi			DB ; $0DC1
wm_ItemInBox			DB ; $0DC2
wm_unk0DC3				DS 4 ; $0DC3-$0DC6 empty cleared on player select
wm_OWMarioXDest			DW ; $0DC7
wm_OWMarioYDest			DW ; $0DC9
wm_OWLuigiXDest			DW ; $0DCB ; unreferenced
wm_OWLuigiYDest			DW ; $0DCD ; unreferenced
wm_OWPlayerXSpeed		DW ; $0DCF
wm_OWPlayerYSpeed		DW ; $0DD1 ; unreferenced
wm_OWPlayerDirection	DB ; $0DD3
wm_UnkLevelEndFlag		DB ; $0DD4 ; unused
wm_LevelEndFlag			DB ; $0DD5
wm_OWCharB				DW ; $0DD6
wm_OWIsSwitching		DB ; $0DD8
wm_unk0DD9				DB ; $0DD9 empty
wm_LevelMusicMod		DB ; $0DDA
wm_unk0DDB				DS 3 ; $0DDB-$0DDD empty
wm_OWSpriteIndex		DB ; $0DDE
wm_OWSpriteInitOam		DB ; $0DDF
wm_OWCloudSpeedChk		DS 5 ; $0DE0 $0DE0-$0DE4
wm_OWSpriteNum			INSTANCEOF OW_SPR_TBL ; $0DE5
wm_OWSpriteTbl1			INSTANCEOF OW_SPR_TBL ; $0DF5
wm_OWSpriteTbl2			INSTANCEOF OW_SPR_TBL ; $0E05
wm_OWSpriteTbl3			INSTANCEOF OW_SPR_TBL ; $0E15
wm_OWSpriteTbl4			INSTANCEOF OW_SPR_TBL ; $0E25
wm_OWSpriteXLo			INSTANCEOF OW_SPR_TBL ; $0E35
wm_OWSpriteYLo			INSTANCEOF OW_SPR_TBL ; $0E45
wm_OWSpriteZLo			INSTANCEOF OW_SPR_TBL ; $0E55
wm_OWSpriteXHi			INSTANCEOF OW_SPR_TBL ; $0E65
wm_OWSpriteYHi			INSTANCEOF OW_SPR_TBL ; $0E75
wm_OWSpriteZHi			INSTANCEOF OW_SPR_TBL ; $0E85 ; unreferenced
wm_OWSpriteXSpeed		INSTANCEOF OW_SPR_TBL ; $0E95
wm_OWSpriteYSpeed		INSTANCEOF OW_SPR_TBL ; $0EA5
wm_OWSpriteZSpeed		INSTANCEOF OW_SPR_TBL ; $0EB5
wm_OWSpriteXAcc			INSTANCEOF OW_SPR_TBL ; $0EC5
wm_OWSpriteYAcc			INSTANCEOF OW_SPR_TBL ; $0ED5 ; unreferenced
wm_OWSpriteZAcc			INSTANCEOF OW_SPR_TBL ; $0EE5 ; unreferenced
wm_KoopaKidTrig			DB ; $0EF5
wm_KoopaKidTileIndex	DB ; $0EF6
wm_OWEnterLevel			DB ; $0EF7
wm_YoshiSavedFlag		DB ; $0EF8
wm_StatusBar			INSTANCEOF STAT_BAR ; $0EF9
wm_TimerFrameCounter	DB ; $0F30
wm_TimerHundreds		DB ; $0F31
wm_TimerTens			DB ; $0F32
wm_TimerOnes			DB ; $0F33
wm_MarioScoreHi			DB ; $0F34
wm_MarioScoreMid		DB ; $0F35
wm_MarioScoreLo			DB ; $0F36
wm_LuigiScoreHi			DB ; $0F37
wm_LuigiScoreMid		DB ; $0F38
wm_LuigiScoreLo			DB ; $0F39
wm_unk0F3A				DS 6 ; $0F3A
wm_ScoreAdder			DW ; $0F40
wm_unk0F42				DS 6 ; $0F42-$0F47 empty
wm_PlayerBonusStars		DB ; $0F48
wm_LuigiBonusStars		DB ; $0F49 unreferenced
wm_ClusterSpriteTbl1	INSTANCEOF CLUS_SPR_TBL ; $0F4A ; 20 bytes
wm_unk0F5E				INSTANCEOF CLUS_SPR_TBL ; $0F5E-$0F71 empty
wm_ClusterSpriteTbl2	INSTANCEOF CLUS_SPR_TBL ; $0F72 ; 20 bytes
wm_ClusterSpriteTbl3	INSTANCEOF CLUS_SPR_TBL ; $0F86 ; 20 bytes
wm_ClusterSpriteTbl4	INSTANCEOF CLUS_SPR_TBL ; $0F9A ; 20 bytes
wm_BooRingLo			DW ; $0FAE
wm_BooRingHi			DW ; $0FB0
wm_BooRingXLo			DW ; $0FB2
wm_BooRingXHi			DW ; $0FB4
wm_BooRingYLo			DW ; $0FB6
wm_BooRingYHi			DW ; $0FB8
wm_BooRingOffscreen		DW ; $0FBA
wm_BooRingIndex			DW ; $0FBC
wm_Map16TilePtrs		DS 1024 ; $0FBE $0FBE-$13BD 1024 bytes
wm_ItemMemHead			DB ; $13BE
wm_TransLvNum			DW ; $13BF
wm_OWPlayerTile			DW ; $13C1 $13C2 when above is 16bit
wm_OWPlayerMap			DW ; $13C3 $13C4 when above is 16bit
wm_3UpMoonsCol			DB ; $13C5
wm_CutsceneNum			DB ; $13C6
wm_YoshiColor			DB ; $13C7
wm_unk13C8				DB ; $13C8 empty
wm_ShowEndMenu			DB ; $13C9
wm_OWSavePromptFlag		DB ; $13CA
wm_LvEndStarPrize		DB ; $13CB ; unused star feature
wm_CoinAdder			DB ; $13CC
wm_DisableMidPoint		DB ; $13CD ; unused, beta [CODE_05D9B8]? if no sublevels entered a value is stored here. disable on zero
wm_MidwayPointFlag		DB ; $13CE
wm_ForceNoLevelIntro	DB ; $13CF
wm_LvDestructionIndex	DB ; $13D0
wm_LvDestructionTile	DB ; $13D1
wm_SwitchPalaceCol		DB ; $13D2
wm_PauseTimer			DB ; $13D3
wm_PauseLookFlag		DB ; $13D4
wm_L3ScrollFlag			DB ; $13D5
wm_ScoreDrumroll		DB ; $13D6
wm_YoshisHouseYAcc		DW ; $13D7 $13D8 when above is 16bit
wm_OWProcessPtr			DB ; $13D9
wm_PlayerXAccFixed		DB ; $13DA
wm_PlayerWalkPose		DB ; $13DB
wm_PlayerYAccFixed		DB ; $13DC unreferenced
wm_PlayerTurningPose	DB ; $13DD
wm_OWCreditsPose		DB ; $13DE
wm_CapeImage			DB ; $13DF
wm_MarioFrame			DB ; $13E0
wm_OnSlopeTypeB			DB ; $13E1
wm_SpinFireTimer		DB ; $13E2
wm_WallWalkStatus		DB ; $13E3
wm_PlayerDashTimer		DB ; $13E4
wm_PlayerFrameIndex		DB ; $13E5
wm_unk13E6				DW ; $13E6-13E7 empty
wm_CapeCanHurt			DB ; $13E8
wm_CapeXPos				DW ; $13E9
wm_CapeYPos				DW ; $13EB
wm_PlayerSlopePose		DB ; $13ED
wm_OnSlopeTypeA			DB ; $13EE
wm_IsOnGround			DB ; $13EF
wm_NetFaceDirection		DB ; $13F0
wm_EnableVertScroll		DW ; $13F1 $13F2 cleared when above is 16bit
wm_PBalloonFrame		DB ; $13F3
wm_CoinBonusBlock1		DB ; $13F4
wm_CoinBonusBlock2		DB ; $13F5
wm_CoinBonusBlock3		DB ; $13F6
wm_CoinBonusBlock4		DB ; $13F7
wm_CoinBonusBlock5		DB ; $13F8
wm_IsBehindScenery		DB ; $13F9
wm_IsOnWaterTop			DB ; $13FA
wm_IsFrozen				DB ; $13FB
wm_M7BossGfxIndex		DB ; $13FC
wm_LRScrollFlag			DB ; $13FD
wm_LRScrollDir			DB ; $13FE
wm_LRScrollStop			DB ; $13FF
wm_LRMoveCamera			DB ; $1400
wm_LRFrameTimer			DB ; $1401
wm_NoteBlkBounceFlag	DB ; $1402
wm_L3TideSetting		DB ; $1403
wm_ScrScrollToPlayer	DB ; $1404
wm_WarpingWithYoshi		DB ; $1405
wm_BouncingWithYoshi	DB ; $1406
wm_CapeGlidePhase		DB ; $1407
wm_CapeGlideIndex		DB ; $1408
wm_CapeDivePhase		DB ; $1409
wm_140A					DB ; $140A ; unused cleared on cape flight
wm_unk140B				DW ; $140B-$140C empty
wm_IsSpinJump			DB ; $140D
wm_IsTouchLayer2		DB ; $140E
wm_ReznorSmokeFlag		DB ; $140F
wm_YoshiHasWingsB		DB ; $1410
wm_HorzScrollHead		DB ; $1411
wm_VertScrollHead		DB ; $1412
wm_HorzScrollLyr2		DB ; $1413
wm_VertScrollLyr2		DB ; $1414
wm_unk1415				DW ; $1415-$1416 empty
wm_VertL2ScrollLength	DW ; $1417
wm_YoshiInPipe			DB ; $1419
wm_NumSubLvEntered		DB ; $141A
wm_StartedBonusGame		DB ; $141B
wm_SecretGoalSprite		DB ; $141C
wm_ShowMarioStart		DB ; $141D
wm_YoshiHasWings		DB ; $141E
wm_DisableNoYoshiIntro	DB ; $141F
wm_YoshiCoinsCollected	DB ; $1420
wm_1UpInvsCheckPts		DB ; $1421
wm_YoshiCoinsDisp		DB ; $1422
wm_WhichSwitchPressed	DB ; $1423
wm_DispBonusStars		DB ; $1424
wm_BonusGameFlag		DB ; $1425
wm_MsgBoxTrig			DB ; $1426
wm_BowserClownImage		DB ; $1427
wm_BowserPropellerIndex	DB ; $1428
wm_BowserPaletteIndex	DB ; $1429
wm_PosToScrollScreen	DW ; $142A
wm_CanScrollScreen		DS 4 ; $142C
wm_LowestSolidSprTile	DB ; $1430
wm_HighestSolidSprTile	DB ; $1431
wm_DirCoinActivate		DB ; $1432
wm_HdmaWindowScaling	DB ; $1433
wm_KeyHoleTimer			DB ; $1434
wm_KeyHoleOpeningFlag	DB ; $1435
wm_KeyHolePos1			DW ; $1436
wm_KeyHolePos2			DW ; $1438
wm_UseBigMsg			DB ; $143A
wm_DeathMsgType			DB ; $143B
wm_DeathMsgAnim			DB ; $143C
wm_DeathMsgTimer		DB ; $143D
wm_ScrollSprNum			DB ; $143E
wm_ScrollSprL2			DB ; $143F
wm_InitYScrollL1		DB ; $1440
wm_InitYScrollL2		DB ; $1441
wm_ScrollTypeL1			DB ; $1442
wm_ScrollTypeL2			DB ; $1443
wm_ScrollTimerL1		DB ; $1444
wm_ScrollTimerL2		DB ; $1445
wm_ScrollSpeedL1X		DW ; $1446
wm_ScrollSpeedL1Y		DW ; $1448
wm_ScrollSpeedL2X		DW ; $144A
wm_ScrollSpeedL2Y		DW ; $144C
wm_SprScrollL1X			DW ; $144E
wm_SprScrollL1Y			DW ; $1450
wm_SprScrollL2X			DW ; $1452
wm_SprScrollL2Y			DW ; $1454
wm_ScrollSprIndex		DB ; $1456
wm_YoshisRescued		DB ; $1457
wm_XSpeedL3				DW ; $1458
wm_YSpeedL3				DW ; $145A
wm_AccSpeedL3			DB ; $145C
wm_YoshiCreditTimer		DB ; $145D
wm_unk145E				DW ; 145E-145F unused
wm_L3ScrollDir			DW ; $1460 1461 unused high byte
wm_L1NextPosX			DW ; $1462
wm_L1NextPosY			DW ; $1464
wm_L2NextPosX			DW ; $1466
wm_L2NextPosY			DW ; $1468
wm_L3CurXMoved			DW ; $146A
wm_unk146C				DS 4 ; 146C-146F unused
wm_IsCarrying			DB ; $1470
wm_IsOnSolidSpr			DB ; $1471
wm_SpotlightLXPos		DB ; $1472
wm_unk1473				DB ; 1473 unused
wm_SpotlightRXPos		DB ; $1474
wm_unk1475				DB ; 1475 unused
wm_SpotlightLowLXPos	DB ; $1476
wm_unk1477				DB ; 1477 unused
wm_SpotlightLowRXPos	DB ; $1478
wm_unk1479				DB ; 1479 unused
wm_SpotlightTmpLXPos	DB ; $147A
wm_unk147B				DB ; 147B unused
wm_SpotlightTmpRXPos	DB ; $147C
wm_unk147D				DB ; 147D unused
wm_SpotlightMvLeft		DB ; $147E
wm_SpotlightMvRight		DB ; $147F
wm_SpotlightLWidth		DB ; $1480
wm_SpotlightRWidth		DB ; $1481
wm_InitSpotlight		DB ; $1482
wm_SpotlightDir			DB ; $1483
wm_SpotlightLSide		DB ; $1484
wm_SpotlightRSide		DB ; $1485
wm_1486					DB ; $1486 ; set to 01 in spotlight sprite
wm_unk1487				DS 4 ; 1487-148A unused 4 bytes
wm_RandomByteNext		DW ; $148B
wm_RandomByte1			DB ; $148D
wm_RandomByte2			DB ; $148E
wm_IsCarrying2			DB ; $148F
wm_StarPowerTimer		DB ; $1490
wm_SprPixelMove			DB ; $1491
wm_PeaceImgTimer		DB ; $1492
wm_EndLevelTimer		DB ; $1493
wm_ColorFadeEndDir		DB ; $1494
wm_ColorFadeTimer		DB ; $1495
wm_PlayerAnimTimer		DB ; $1496
wm_PlayerHurtTimer		DB ; $1497
wm_PickUpImgTimer		DB ; $1498
wm_FaceCamImgTimer		DB ; $1499
wm_KickImgTimer			DB ; $149A
wm_FlashingPalTimer		DB ; $149B
wm_FireballImgTimer		DB ; $149C
wm_NetSideTimer			DB ; $149D
wm_NetPunchTimer		DB ; $149E
wm_GlideTimer			DB ; $149F
wm_RunCapeTimer			DB ; $14A0
wm_SlideImgTimer		DB ; $14A1
wm_CapeWaveTimer		DB ; $14A2
wm_YoshiTongueTimer		DB ; $14A3
wm_DivingTimer			DB ; $14A4
wm_FloatingTimer		DB ; $14A5
wm_CapeSpinTimer		DB ; $14A6
wm_ReznorBridgeTimer	DB ; $14A7
wm_14A8					DB ; $14A8 ; Unused, dec every frame until 0
wm_14A9					DB ; $14A9 ; Unused, zero on cape ground pound
wm_14AA					DB ; $14AA ; Unused, $40 when yoshi gets wings
wm_BonusGameEndTimer	DB ; $14AB
wm_unk14AC				DB ; 14AC unused dec until 0
wm_BluePowTimer			DB ; $14AD
wm_SilverPowTimer		DB ; $14AE
wm_OnOffStatus			DB ; $14AF
wm_ChainCentX			DB ; $14B0
wm_BowserMechTimer		DB ; $14B1
wm_ChainCentY			DB ; $14B2
wm_BowserTearYPos		DB ; $14B3
wm_ChainCosX			DB ; $14B4
wm_BowserHurtTimer		DB ; $14B5
wm_ChainSinY			DB ; $14B6
wm_BowserFireX			DB ; $14B7
wm_ChainFirstX			DW ; $14B8
wm_ChainFirstY			DW ; $14BA
wm_ChainRadiusX			DW ; $14BC
wm_unk14BE				DB ; 14BE unused
wm_ChainRadiusY			DW ; $14BF
wm_unk14C1				DB ; 14C1 unused
wm_ChainCurSin			DW ; $14C2
wm_unk14C4				DB ; 14C4 unused
wm_ChainCurCos			DW ; $14C5
wm_unk14C7				DB ; 14C7 unused
wm_SpriteStatus			INSTANCEOF SPR_TBL ; $14C8
wm_SpriteYHi			INSTANCEOF SPR_TBL ; $14D4
wm_SpriteXHi			INSTANCEOF SPR_TBL ; $14E0
wm_SpriteYAcc			INSTANCEOF SPR_TBL ; $14EC
wm_SpriteXAcc			INSTANCEOF SPR_TBL ; $14F8
wm_SpriteMiscTbl1		INSTANCEOF SPR_TBL ; $1504
wm_SpriteMiscTbl2		INSTANCEOF SPR_TBL ; $1510
wm_SpriteMiscTbl3		INSTANCEOF SPR_TBL ; $151C
wm_SpriteMiscTbl4		INSTANCEOF SPR_TBL ; $1528
wm_SpriteMiscTbl5		INSTANCEOF SPR_TBL ; $1534
wm_SpriteDecTbl1		INSTANCEOF SPR_TBL ; $1540
wm_SpriteDecTbl2		INSTANCEOF SPR_TBL ; $154C
wm_SpriteDecTbl3		INSTANCEOF SPR_TBL ; $1558
wm_SpriteDecTbl4		INSTANCEOF SPR_TBL ; $1564
wm_SpriteMiscTbl6		INSTANCEOF SPR_TBL ; $1570
wm_SpriteDir			INSTANCEOF SPR_TBL ; $157C
wm_SprObjStatus			INSTANCEOF SPR_TBL ; $1588
wm_SpriteMiscTbl7		INSTANCEOF SPR_TBL ; $1594
wm_OffscreenHorz		INSTANCEOF SPR_TBL ; $15A0
wm_SpriteDecTbl5		INSTANCEOF SPR_TBL ; $15AC
wm_SpriteSlopeTbl		INSTANCEOF SPR_TBL ; $15B8
wm_SpriteOffTbl			INSTANCEOF SPR_TBL ; $15C4
wm_SpriteEatenTbl		INSTANCEOF SPR_TBL ; $15D0
wm_SpriteInterTbl		INSTANCEOF SPR_TBL ; $15DC
wm_unk15E8				DB ; $15E8 unused
wm_SprProcessIndex		DB ; $15E9
wm_SprOAMIndex			INSTANCEOF SPR_TBL ; $15EA
wm_SpritePal			INSTANCEOF SPR_TBL ; $15F6
wm_SpriteGfxTbl			INSTANCEOF SPR_TBL ; $1602
wm_SpriteMiscTbl8		INSTANCEOF SPR_TBL ; $160E
wm_SprIndexInLvl		INSTANCEOF SPR_TBL ; $161A
wm_SprChainKillTbl		INSTANCEOF SPR_TBL ; $1626
wm_SprBehindScrn		INSTANCEOF SPR_TBL ; $1632
wm_SpriteDecTbl6		INSTANCEOF SPR_TBL ; $163E
wm_SprInWaterTbl		INSTANCEOF SPR_TBL ; $164A
wm_Tweaker1656			INSTANCEOF SPR_TBL ; $1656
wm_Tweaker1662			INSTANCEOF SPR_TBL ; $1662
wm_Tweaker166E			INSTANCEOF SPR_TBL ; $166E
wm_Tweaker167A			INSTANCEOF SPR_TBL ; $167A
wm_Tweaker1686			INSTANCEOF SPR_TBL ; $1686
wm_SpriteMemory			DB ; $1692
wm_Map16NumLo			DB ; $1693
wm_SprMoveDownPixels	DB ; $1694
wm_CheckSprInter		DB ; $1695
wm_unk1696				DB ; $1696 unused
wm_SprChainStomped		DB ; $1697
wm_ExSprIndexM			DB ; $1698
wm_BounceSprNum			DS 4 ; $1699
wm_BounceSprInit		DS 4 ; $169D
wm_BounceSprXLo			DS 4 ; $16A1
wm_BounceSprYLo			DS 4 ; $16A5
wm_BounceSprXHi			DS 4 ; $16A9
wm_BounceSprYHi			DS 4 ; $16AD
wm_BouncBlkSpeedX		DS 4 ; $16B1
wm_BouncBlkSpeedY		DS 4 ; $16B5
wm_BouncBlkAccX			DS 4 ; $16B9
wm_BouncBlkAccY			DS 4 ; $16BD unreferenced
wm_BounceSprBlock		DS 4 ; $16C1
wm_BounceSprTimer		DS 4 ; $16C5
wm_BounceSprTable		DS 4 ; $16C9
wm_BouncBlkStatus		DS 4 ; $16CD
wm_BounceSprInterXLo	DS 4 ; $16D1
wm_BounceSprInterXHi	DS 4 ; $16D5
wm_BounceSprInterYLo	DS 4 ; $16D9
wm_BounceSprInterYHi	DS 4 ; $16DD
wm_ScoreSprNum			DS 6 ; $16E1
wm_ScoreSprYLo			DS 6 ; $16E7
wm_ScoreSprXLo			DS 6 ; $16ED
wm_ScoreSprXHi			DS 6 ; $16F3
wm_ScoreSprYHi			DS 6 ; $16F9
wm_ScoreSprSpeedY		DS 6 ; $16FF
wm_ScoreSprLayer		DS 6 ; $1705
wm_ExSpriteNum			DS 10 ; $170B
wm_ExSpriteYLo			DS 10 ; $1715
wm_ExSpriteXLo			DS 10 ; $171F
wm_ExSpriteYHi			DS 10 ; $1729
wm_ExSpriteXHi			DS 10 ; $1733
wm_ExSprSpeedY			DS 10 ; $173D
wm_ExSprSpeedX			DS 10 ; $1747
wm_ExSprAccY			DS 10 ; $1751
wm_ExSprAccX			DS 10 ; $175B
wm_ExSpriteTbl1			DS 10 ; $1765
wm_ExSpriteTbl2			DS 10 ; $176F
wm_ExSprBehindTbl		DS 10 ; $1779
wm_ShooterSprNum		DS 8 ; $1783
wm_ShooterYLo			DS 8 ; $178B
wm_ShooterYHi			DS 8 ; $1793
wm_ShooterXLo			DS 8 ; $179B
wm_ShooterXHi			DS 8 ; $17A3
wm_ShooterTimer			DS 8 ; $17AB
wm_ShooterLvIndex		DS 8 ; $17B3
wm_17BB					DB ; $17BB ; empty, level high stored
wm_L1CurYChange			DB ; $17BC
wm_L1CurXChange			DB ; $17BD
wm_L2CurYChange			DB ; $17BE
wm_L2CurXChange			DB ; $17BF
wm_SmokeSprite			DS 4 ; $17C0
wm_SmokeYPos			DS 4 ; $17C4
wm_SmokeXPos			DS 4 ; $17C8
wm_SmokeTimer			DS 4 ; $17CC
wm_SpinCoinSlot			DS 4 ; $17D0
wm_SpinCoinYLo			DS 4 ; $17D4
wm_SpinCoinYSpeed		DS 4 ; $17D8
wm_SpinCoinYAcc			DS 4 ; $17DC
wm_SpinCoinXLo			DS 4 ; $17E0
wm_SpinCoinTbl			DS 4 ; $17E4
wm_SpinCoinYHi			DS 4 ; $17E8
wm_SpinCoinXHi			DS 4 ; $17EC
wm_MExSprNum			INSTANCEOF SPR_TBL ; $17F0
wm_MExSprYLo			INSTANCEOF SPR_TBL ; $17FC
wm_MExSprXLo			INSTANCEOF SPR_TBL ; $1808
wm_MExSprYHi			INSTANCEOF SPR_TBL ; $1814
wm_MExSprYSpeed			INSTANCEOF SPR_TBL ; $1820
wm_MExSprXSpeed			INSTANCEOF SPR_TBL ; $182C
wm_MExSprYAcc			INSTANCEOF SPR_TBL ; $1838
wm_MExSprXAcc			INSTANCEOF SPR_TBL ; $1844 unreferenced
wm_MExSprTimer			INSTANCEOF SPR_TBL ; $1850
wm_FallThroughFlag		DB ; $185C
wm_DelOldExSpr			DB ; $185D
wm_TempTileGen			DB ; $185E
wm_SprOnTileYLo			DB ; $185F
wm_SprOnTileXLo			DB ; $1860
wm_FullSprDelete		DB ; $1861
wm_SprOnTileXHi			DB ; $1862
wm_SmokeSprIndex		DB ; $1863
wm_unk1864				DB ; $1864 empty
wm_SpinCoinIndex		DB ; $1865
wm_ChainAngleNeg		DW ; $1866
wm_SprOnBreakableBlk	DB ; $1868
wm_unk1869				DW ; $1869/186A unused
wm_MultiCoinBlkTimer	DB ; $186B
wm_OffscreenVert		INSTANCEOF SPR_TBL ; $186C
wm_PlayerNetDoorX		DB ; $1878
wm_unk1879				DB ; $1879 unused
wm_OnYoshi				DB ; $187A
wm_SprStompImmuneTbl	INSTANCEOF SPR_TBL ; $187B
wm_ShakeGrndTimer		DB ; $1887
wm_Layer1DispYLo		DB ; $1888
wm_Layer1DispYHi		DB ; $1889
wm_188A					DB ; $188A ; unused cleared twice
wm_PlayerImgYPos		DB ; $188B
wm_UpdateBossTiles		DB ; $188C
wm_BossBgXPos			DB ; $188D
wm_unk188E				DB ; $188E unused
wm_BonusHasEnded		DB ; $188F
wm_Bonus1UpCount		DB ; $1890
wm_BalloonTimer			DB ; $1891
wm_ClustSprNum			INSTANCEOF CLUS_SPR_TBL ; $1892
wm_18A6					DB ; $18A6 ; unused ref once
wm_MirBlkCheck			DB ; $18A7
wm_BossLPillarStat		DB ; $18A8
wm_BossRPillarStat		DB ; $18A9
wm_BossLPillarYPos		DB ; $18AA
wm_BossRPillarYPos		DB ; $18AB
wm_YoshiSwallowTimer	DB ; $18AC
wm_YoshiWalkFrames		DB ; $18AD
wm_YoshiWhipTimer		DB ; $18AE
wm_YoshiSquatTimer		DB ; $18AF
wm_YoshiBerryWalkX		DW ; $18B0
wm_YoshiBerryWalkY		DW ; $18B2
wm_unk18B4				DB ; $18B4 unused
wm_FollowCage			DB ; $18B5
wm_18B6					DB ; $18B6
wm_unk18B7				DB ; $18B7 unused
wm_AllowClusterSpr		DB ; $18B8
wm_GeneratorNum			DB ; $18B9
wm_BooRingAltIndex		DB ; $18BA
wm_unk18BB				DB ; $18BB unused
wm_SkullFloatSpeed		DB ; $18BC
wm_LockMarioTimer		DB ; $18BD
wm_CanClimbAir			DB ; $18BE
wm_AppearSprTimer		DB ; $18BF
wm_TimeTillRespawn		DB ; $18C0
wm_SpriteToRespawn		DB ; $18C1
wm_IsInLakituCloud		DB ; $18C2
wm_RespawnSprYPos		DW ; $18C3
wm_unk18C5				DS 8 ; 18C5-18CC unused
wm_BounceSprAltIndex	DB ; $18CD
wm_SpinBlockTimer		DS 4 ; $18CE
wm_StarKillPoints		DB ; $18D2
wm_SparkleTimer			DB ; $18D3 ; unused
wm_RedBerriesAte		DB ; $18D4
wm_PinkBerriesAte		DB ; $18D5
wm_BerryEatenType		DB ; $18D6
wm_SprOnTileYHi			DB ; $18D7
wm_unk18D8				DB ; $18D8 unused
wm_DoorIntroTimer		DB ; $18D9
wm_YoshiLaysSpr			DB ; $18DA
wm_18DB					DB ; $18DB ; unused ref once
wm_IsYoshiDucking		DB ; $18DC
wm_SilverCoins			DB ; $18DD
wm_YoshiLayTimer		DB ; $18DE
wm_YoshiSlot			DB ; $18DF
wm_StolenCloudTimer		DB ; $18E0
wm_LakituCloudSlot		DB ; $18E1
wm_LooseYoshiFlag		DB ; $18E2
wm_CoinGameCoins		DB ; $18E3
wm_GiveLives			DB ; $18E4
wm_GiveLifeTimer		DB ; $18E5
wm_unk18E6				DB ; $18E6 unused
wm_YoshiHasStomp		DB ; $18E7
wm_YoshiGrowTimer		DB ; $18E8
wm_OldSmokeIndex		DB ; $18E9
wm_MExSprXHi			INSTANCEOF SPR_TBL ; $18EA ; weird spot for this?
wm_unk18F6				DB ; $18F6 unused
wm_ScoreSprIndex		DB ; $18F7
wm_BounceSprInterTime	DS 4 ; $18F8
wm_AltExSprIndex		DB ; $18FC
wm_ChuckWhistles		DB ; $18FD
wm_ExBulletBillTimer	DB ; $18FE
wm_ShooterIndex			DB ; $18FF
wm_BonusStarsGained		DB ; $1900
wm_BounceBlkData		DS 4 ; $1901
wm_IggyPlatTilts		DB ; $1905
wm_IggyPlatTimer		DB ; $1906
wm_IggyPlatCounter		DB ; $1907
wm_unk1908				DB ; $1908 unused
wm_RunEaterBlock		DB ; $1909
wm_AppearBooCounter		DB ; $190A
wm_BooBossPal			DB ; $190B
wm_DirCoinTimer			DB ; $190C
wm_BowserFinalScene		DB ; $190D
wm_SpriteBuoyancy		DB ; $190E
wm_Tweaker190F			INSTANCEOF SPR_TBL ; $190F
wm_191B					DB ; $191B ; cleared when yoshi
wm_YoshiHasKey			DB ; $191C
wm_SumoFlameIndex		DB ; $191D
wm_FlatSwitchType		DB ; $191E
wm_unk191F				DB ; $191F unused
wm_Bonus1UpsRemaining	DB ; $1920
wm_EndMsgLetter			DW ; $1921 1922 unused high byte
wm_unk1923				DW ; $1923/1924 unused
wm_LevelHeaderMode		DB ; $1925
wm_unk1926				DW ; $1926/1927 unused
wm_LvLoadScreen			DB ; $1928
wm_unk1929				DB ; $1929 unused
wm_LevelHeaderByte		DB ; $192A
wm_CurSprGfx			DB ; $192B
wm_unk192C				DB ; $192C unused
wm_LvHeadFgPal			DB ; $192D
wm_LvHeadSprPal			DB ; $192E
wm_LvHeadBgCol			DB ; $192F
wm_LvHeadBgPal			DB ; $1930
wm_LvHeadTileset		DB ; $1931
wm_1932					DB ; $1932 ; copy of 1931
wm_LayerInProcess		DW ; $1933 1934 unused high byte
wm_WriteMarioStart		DB ; $1935
wm_unk1936				DW ; $1936/1937 unused
wm_SprLoadStatus		DS 128 ; $1938
wm_ExitNumTbl			DS 32 ; $19B8
wm_ExitFlagsTbl			DS 32 ; $19D8 ; unused without LM
wm_ItemsCollected		DS 384 ; $19F8
wm_OWUseHardPath		DW ; $1B78
wm_OWHardTile			DW ; $1B7A
wm_OWL1XAcc				DB ; $1B7C
wm_OWL1YAcc				DB ; $1B7D unreferenced
wm_OWOnCurvyTile		DW ; $1B7E 1B7F unused high byte
wm_OWIsClimbing			DW ; $1B80 1B81 unused high byte
wm_OWDestructXPos		DB ; $1B82
wm_OWDestructYPos		DB ; $1B83
wm_OWEventTileSize		DW ; $1B84
wm_OWEventPtr			DB ; $1B86
wm_OWPromptTrig			DB ; $1B87
wm_MsgBoxActionFlag		DB ; $1B88
wm_MsgBoxActionTimer	DB ; $1B89
wm_OWGiveLifeFrom		DB ; $1B8A
wm_OWGiveLifeTimer		DB ; $1B8B
wm_OWFadeFlag			DB ; $1B8C
wm_OWFadeMathX			DW ; $1B8D
wm_OWFadeMathY			DW ; $1B8F
wm_CursorBlinking		DB ; $1B91
wm_CursorPos			DB ; $1B92
wm_Use2ndExitFlag		DB ; $1B93
wm_NoBonusGameFlag		DB ; $1B94
wm_YoshiWingsAboveGrnd	DB ; $1B95
wm_SideExitFlag			DB ; $1B96
wm_1B97					DW ; $1B97 ; unused scrolling effect
wm_GoalFadeFlag			DB ; $1B99
wm_BGScrollFlag			DB ; $1B9A
wm_DisableYoshiFlag		DB ; $1B9B
wm_OWWarpFlag			DB ; $1B9C
wm_L3TideTimer			DB ; $1B9D
wm_OWAlterMusicFlag		DB ; $1B9E
wm_ReznorBrokenTiles	DB ; $1B9F
wm_OWBowserTimer		DB ; $1BA0
wm_MirrorScrnNum		DB ; $1BA1
wm_M7BossProp			DB ; $1BA2
wm_M7VramBuffer			DS 15 ; $1BA3 FIX!!!
wm_1BB2					DS 10 ; $1BB2 FIX!!!
wm_1BBC					DS 39 ; $1BBC FIX!!!
wm_L3Settings			DB ; $1BE3
wm_L1VramUploadAddrL	DB ; $1BE4
wm_L1VramUploadAddrH	DB ; $1BE5
wm_OWTilesOnRowL1		INSTANCEOF LAYER_TILES ; $1BE6 ; layer 1 tiles
wm_L2VramUploadAddrL	DB ; $1CE6
wm_L2VramUploadAddrH	DB ; $1CE7
wm_OWTilesOnRowL2		INSTANCEOF LAYER_TILES ; $1CE8 ; layer 2 tiles
wm_OWSubmapSwitchIndex	DB ; $1DE8
wm_CreditsEnemyNum		DB ; $1DE9
wm_OWLvEndEvent			DB ; $1DEA
wm_OWFirstEventTile		DW ; $1DEB
wm_OWLastEventTile		DW ; $1DED
wm_unk1DEF				DB ; $1DEF unused
wm_OWScrollX			DW ; $1DF0
wm_OWScrollY			DW ; $1DF2
wm_IntroCtrlSeqIndex	DB ; $1DF4
wm_IntroCtrlSeqFrame	DB ; $1DF5
wm_OWWarpIndex			DB ; $1DF6
wm_StarWarpSpeed		DB ; $1DF7
wm_StarWarpTimer		DB ; $1DF8
wm_SoundCh1				DB ; $1DF9
wm_SoundCh2				DB ; $1DFA
wm_MusicCh1				DB ; $1DFB
wm_SoundCh3				DB ; $1DFC
wm_1DFD					DW ; $1DFD 1DFE unused high byte
wm_MirrorMusicCh		DW ; $1DFF 1E00 unused high byte
wm_FreeMovement			DB ; $1E01
wm_ClusterSprYLo		INSTANCEOF CLUS_SPR_TBL ; $1E02
wm_ClusterSprXLo		INSTANCEOF CLUS_SPR_TBL ; $1E16
wm_ClusterSprYHi		INSTANCEOF CLUS_SPR_TBL ; $1E2A
wm_ClusterSprXHi		INSTANCEOF CLUS_SPR_TBL ; $1E3E
wm_ClusBooFrame1Y		INSTANCEOF CLUS_SPR_TBL ; $1E52
wm_ClusBooFrame1X		INSTANCEOF CLUS_SPR_TBL ; $1E66
wm_ClusBooFrame2Y		INSTANCEOF CLUS_SPR_TBL ; $1E7A
wm_ClusBooFrame2X		INSTANCEOF CLUS_SPR_TBL ; $1E8E
wm_MapData				INSTANCEOF OW_DATA_BUFFER ; $1EA2
wm_5YoshiCoins			DS 12 ; $1F2F
wm_unk1F3B				DB ; $1F3B unused
wm_1UpInvsCollected		DS 12 ; $1F3C
wm_1F48					DB ; $1F48 unused
wm_MapSave				INSTANCEOF OW_DATA_BUFFER ; $1F49
wm_1FD6					INSTANCEOF SPR_TBL ; $1FD6 ; unused sprite table
wm_DisSprCapeContact	INSTANCEOF SPR_TBL ; $1FE2
wm_3UpMoonsCollected	DS 12 ; $1FEE
wm_unk1FFA				DB ; $1FFA unused
wm_LightFlashPal		DB ; $1FFB
wm_LightFlashNext		DB ; $1FFC
wm_LightFlashDur		DB ; $1FFD
wm_UpdateCreditBG		DB ; $1FFE
wm_unk1FFF				DB ; $1FFF unused
.ENDE

; [FULL BANK]
.ENUM $7E2000
wm_GFX32Decomp			DS 32*1128 ; $7E2000 [4bpp 1128 chunks]
wm_GFXBuffer			DS 24*64 ; $7EAD00 [3bpp 64 chunks]
wm_OwGfxBuf				DS 24*64 ; $7EB300 [3bpp 64 chunks]
wm_L2TilesLo			DS 1024 ; $7EB900 ; FIX create struct
wm_L2TilesHi			DS 1024 ; $7EBD00
wm_unk7EC100			DS 1408 ; C100-C67F unused
wm_M7BossTiles			DS 96 ; $7EC680 ; FIX create struct
wm_unk7EC6E0			DS 288 ; C6E0-C7FF unused
wm_Map16PageL			INSTANCEOF MAP16_PAGE 32 ; $7EC800
.ENDE

.ENUM $7EC800
wm_Map16SetL			INSTANCEOF MAP16_SET 32 ; $7EC800
.ENDE

.ENUM $7F0000
wm_OW_L2EventTiles		DS 16384 ; $7F0000
wm_OW_L2Tiles			DS 1024 ; $7F4000
wm_OW_L2SubTiles		DS 15360 ; $7F4400
wm_ClearOam				INSTANCEOF SUB_CLEAR_OAM ; $7F8000
wm_unk7F8183			DS 504 ; 7F8183-7F837A unused
wm_ImageIndex			DW ; $7F837B
wm_ImageTable			INSTANCEOF VRAM_IMG 2559 ; $7F837D
wm_MsgGFXDecomp			INSTANCEOF MSG_BUF ; $7F977B
wm_WigglerSegments		DS 512 ; $7F9A7B
wm_unk7F9C7B			DS 11141 ; $7F9C7B
wm_Map16PageH			INSTANCEOF MAP16_PAGE 32 ; $7FC800
.ENDE

.ENUM $7FC800
wm_Map16SetH			INSTANCEOF MAP16_SET 32
.ENDE

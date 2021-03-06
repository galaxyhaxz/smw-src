.MEMORYMAP
SLOTSIZE $10000
DEFAULTSLOT 0
SLOT 0 $1360-4
.ENDME

.ROMBANKMAP
BANKSTOTAL 1
BANKSIZE $10000
BANKS 1
.ENDRO

.INCLUDE "macros.i"

.BANK 0 SLOT 0
.ORG 0

	BASE_START $1360

MusicPtrs:
	.DW MUSIC_Credits1 ; $01
	.DW MUSIC_Credits2 ; $02
	.DW MUSIC_Credits3 ; $03
	.DW MUSIC_Credits4 ; $04
	.DW MUSIC_Credits1 ; $05
	.DW MUSIC_Credits2 ; $06
	.DW MUSIC_Credits3 ; $07
	.DW MUSIC_Credits4 ; $08
	.DW MUSIC_Credits1 ; $09
	.DW MUSIC_Credits2 ; $0A
	.DW MUSIC_Credits3 ; $0B
	.DW MUSIC_Credits4 ; $0C

MUSIC_Credits1: ; all credits share data together
	.DW DATA_139E,DATA_13AE,DATA_13BE,DATA_13DE
	.DW DATA_13CE,DATA_13EE,DATA_13FE,DATA_140E
	.DW DATA_141E,DATA_142E,DATA_143E,DATA_144E
	.DW DATA_145E,DATA_146E,DATA_147E,DATA_148E
	.DW DATA_149E,DATA_14AE
	.DW $0000

DATA_139E:	.DW DATA_2194,$0000,$0000,$0000,$0000,$0000,$0000,$0000
DATA_13AE:	.DW DATA_2197,DATA_21BB,DATA_2251,DATA_21F7,DATA_2233,DATA_2215,DATA_21D9,DATA_2273
DATA_13BE:	.DW DATA_2292,DATA_23B4,DATA_23E2,$0000,$0000,$0000,DATA_23CC,DATA_240F
DATA_13CE:	.DW DATA_22C9,DATA_23B4,DATA_23E2,DATA_2300,$0000,DATA_231A,DATA_23CC,DATA_240F
DATA_13DE:	.DW DATA_2444,DATA_246B,DATA_24AF,$0000,$0000,$0000,DATA_248E,DATA_24DF
DATA_13EE:	.DW DATA_2535,DATA_256E,DATA_25B2,DATA_255C,$0000,DATA_250F,DATA_2591,DATA_25E2
DATA_13FE:	.DW DATA_2612,DATA_268D,DATA_26B1,DATA_2661,$0000,DATA_263A,DATA_26A0,DATA_26E1
DATA_140E:	.DW DATA_2711,DATA_277E,DATA_27A8,DATA_2754,$0000,DATA_2733,DATA_2794,DATA_240F
DATA_141E:	.DW DATA_22D1,DATA_23B4,DATA_23E2,DATA_2300,DATA_237E,DATA_2350,DATA_23CC,DATA_240F
DATA_142E:	.DW DATA_2814,DATA_2854,DATA_2880,DATA_284C,DATA_282C,DATA_27FD,DATA_286B,DATA_28A4
DATA_143E:	.DW DATA_28C8,DATA_28E7,DATA_297D,DATA_2923,DATA_295F,DATA_2941,DATA_2905,DATA_299F
DATA_144E:	.DW DATA_22D1,DATA_29BE,DATA_23E2,DATA_2300,DATA_237E,DATA_2350,DATA_23CC,DATA_240F
DATA_145E:	.DW DATA_2814,DATA_29F5,DATA_2A0D,DATA_284C,DATA_282C,DATA_27FD,DATA_286B,DATA_28A4
DATA_146E:	.DW DATA_2A47,DATA_2A66,DATA_2B00,DATA_2AA2,DATA_2AE0,DATA_2AC0,DATA_2A84,DATA_2B24
DATA_147E:	.DW DATA_2B79,DATA_2B43,DATA_23E2,DATA_2300,DATA_2BE2,DATA_2BAE,DATA_23CC,DATA_240F
DATA_148E:	.DW DATA_2C47,DATA_2C18,DATA_2A0D,DATA_284C,DATA_2C5F,DATA_2C30,DATA_286B,DATA_28A4
DATA_149E:	.DW DATA_2A25,DATA_2A66,DATA_2B00,DATA_2AA2,DATA_2AE0,DATA_2AC0,DATA_2A84,DATA_2B24
DATA_14AE:	.DW DATA_2C7F,DATA_2C98,DATA_2D0C,DATA_2CC8,DATA_2CF6,DATA_2CE0,DATA_2CB0,$0000

MUSIC_Credits2:
	.DW DATA_14C2
	.DW $0000

DATA_14C2:	.DW DATA_1E76,DATA_1EC5,DATA_1EF0,DATA_1EA2,DATA_1F03,DATA_1F2A,DATA_1F49,DATA_1F68
DATA_14D2:	.DW DATA_1FA4,DATA_200A,DATA_204C,DATA_1FE9,DATA_1FC8,DATA_1F83,DATA_202C,DATA_207B
DATA_14E2:	.DW DATA_20A6,DATA_20C8,DATA_215A,DATA_2104,DATA_213E,DATA_2122,DATA_20E6,DATA_217A

MUSIC_Credits3:
	.DW DATA_14D2,DATA_14E2,DATA_152C,DATA_154C
	.DW DATA_153C,DATA_155C,DATA_156C,DATA_157C
	.DW DATA_158C,DATA_159C,DATA_15AC,DATA_15CC
	.DW DATA_15BC,DATA_15DC,DATA_15EC,DATA_13AE
	.DW DATA_144E,DATA_145E,DATA_146E,DATA_147E
	.DW DATA_148E,DATA_146E,DATA_15FC,DATA_146E
	.DW DATA_147E,DATA_148E,DATA_149E,DATA_160C
	.DW $0000

DATA_152C:	.DW DATA_163D,DATA_1793,DATA_17BD,DATA_171B,DATA_1757,DATA_1699,$0000,DATA_17E7
DATA_153C:	.DW DATA_163D,DATA_1793,DATA_17BD,DATA_171B,DATA_1757,DATA_16DE,$0000,DATA_17E7
DATA_154C:	.DW DATA_1800,DATA_18EF,DATA_1910,DATA_1889,DATA_18BC,DATA_1855,$0000,DATA_17E7
DATA_155C:	.DW DATA_1931,DATA_19E4,DATA_1A05,DATA_198A,DATA_19B7,DATA_195F,$0000,DATA_17E7
DATA_156C:	.DW DATA_1AC8,DATA_1BAB,DATA_1BCC,DATA_1B3F,DATA_1B77,DATA_1B91,$0000,DATA_17E7
DATA_157C:	.DW DATA_1BED,DATA_1C6E,DATA_1C8F,DATA_1C1B,DATA_1C48,DATA_1C5B,$0000,DATA_17E7
DATA_158C:	.DW DATA_1AC8,DATA_1BAB,DATA_1BCC,DATA_1B3F,DATA_1B77,DATA_1B91,DATA_1B01,DATA_17E7
DATA_159C:	.DW DATA_1CB0,DATA_1D70,DATA_1D90,DATA_1D19,DATA_1D4A,DATA_1D5D,DATA_1CE2,DATA_1DAE
DATA_15AC:	.DW DATA_163D,DATA_1793,DATA_17BD,DATA_171B,DATA_1757,DATA_1699,DATA_167C,DATA_17E7
DATA_15BC:	.DW DATA_163D,DATA_1793,DATA_17BD,DATA_171B,DATA_1757,DATA_16DE,DATA_167C,DATA_17E7
DATA_15CC:	.DW DATA_1800,DATA_18EF,DATA_1910,DATA_1889,DATA_18BC,DATA_1855,DATA_1834,DATA_17E7
DATA_15DC:	.DW DATA_1A26,DATA_1AA6,DATA_1AB7,DATA_1A4E,DATA_1A67,DATA_1A80,DATA_1A40,DATA_17E7
DATA_15EC:	.DW DATA_1632,$0000,$0000,$0000,$0000,$0000,$0000,$0000
DATA_15FC:	.DW DATA_163A,$0000,$0000,$0000,$0000,$0000,$0000,$0000
DATA_160C:	.DW DATA_1DC1,DATA_1DD4,DATA_1E58,DATA_1DF8,DATA_1E3E,DATA_1E0A,DATA_1DE6,DATA_1E24

MUSIC_Credits4:
	.DW DATA_152C,DATA_154C,DATA_152C,DATA_155C
	.DW DATA_156C,DATA_157C,DATA_156C,DATA_159C
	.DW $00FF
	.DW MUSIC_Credits4
	.DW $0000

.INCDIR "music2"

.INCLUDE "credits.a"

.INCDIR ""

	BASE_END $1360

.DW $0000
.DW $0500

;garbage
.DW $00E8
.REPT 16
	.DB $00
.ENDR

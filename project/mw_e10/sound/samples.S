.MEMORYMAP
SLOTSIZE $10000
DEFAULTSLOT 0
SLOT 0 $8000
SLOT 1 $80A8
.ENDME

.ROMBANKMAP
BANKSTOTAL 1
BANKSIZE $10000
BANKS 1
.ENDRO

.INCLUDE "macros.i"

.BANK 0 SLOT 0
.ORG 0
.SECTION "Pointers" FORCE

	BASE_START $8000

	.DW SPC700_Sample00,SPC700_Sample00+9*4
	.DW SPC700_Sample01,SPC700_Sample01+9*4
	.DW SPC700_Sample02,SPC700_Sample02+9*26
	.DW SPC700_Sample03,SPC700_Sample03+9*33
	.DW SPC700_Sample04,SPC700_Sample04+9*4
	.DW SPC700_Sample05,SPC700_Sample05+9*33
	.DW SPC700_Sample06,SPC700_Sample06
	.DW SPC700_Sample07,SPC700_Sample07+9*175
	.DW SPC700_Sample08,SPC700_Sample08+9*4
	.DW SPC700_Sample09,SPC700_Sample09+9*346
	.DW SPC700_Sample0A,SPC700_Sample0A
	.DW SPC700_Sample0B,SPC700_Sample0B
	.DW SPC700_Sample0C,SPC700_Sample0C+9*4
	.DW SPC700_Sample0D,SPC700_Sample0D+9*74
	.DW SPC700_Sample0E,SPC700_Sample0E+9*297
	.DW SPC700_Sample0F,SPC700_Sample0F
	.DW SPC700_Sample10,SPC700_Sample10
	.DW SPC700_Sample11,SPC700_Sample11+9*144
	.DW SPC700_Sample12,SPC700_Sample12
	.DW SPC700_Sample13,SPC700_Sample13

	BASE_END $8000

.ENDS

.BANK 0 SLOT 1
.ORG 0
.SECTION "Samples" SEMIFREE

	BASE_START $8100

.INCDIR "samples"

SPC700_Sample00:	.INCBIN "flute.brr"
SPC700_Sample01:	.INCBIN "violin.brr"
SPC700_Sample02:	.INCBIN "glockenspiel.brr"
SPC700_Sample03:	.INCBIN "xylophone.brr"
SPC700_Sample04:	.INCBIN "cello.brr"
SPC700_Sample05:	.INCBIN "acoustic_bass.brr"
SPC700_Sample06:	.INCBIN "cymbal.brr"
SPC700_Sample07:	.INCBIN "steel_guitar.brr"
SPC700_Sample08:	.INCBIN "trumpet.brr"
SPC700_Sample09:	.INCBIN "steel_drum.brr"
SPC700_Sample0A:	.INCBIN "acoustic_piano.brr"
SPC700_Sample0B:	.INCBIN "snare_drum.brr"
SPC700_Sample0C:	.INCBIN "electric_piano.brr"
SPC700_Sample0D:	.INCBIN "slap_bass.brr"
SPC700_Sample0E:	.INCBIN "woodblock.brr"
SPC700_Sample0F:	.INCBIN "bass_drum.brr"
SPC700_Sample10:	.INCBIN "bongo.brr"
SPC700_Sample11:	.INCBIN "distortion_guitar.brr"
SPC700_Sample12:	.INCBIN "orchestra_hit.brr"
SPC700_Sample13:	.INCBIN "thunder.brr"

.INCDIR ""

.REPT 8
.DB $FF
.ENDR

	BASE_END $8100

.DW $0000
.DW $0500

;garbage
.DW $0018
.REPT 18
.DB $00
.ENDR

.ENDS

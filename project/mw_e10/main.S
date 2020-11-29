.INCLUDE "cpureg.i"
.INCLUDE "ppureg.i"
.INCLUDE "joypad.i"

.INCLUDE "program.i"
.INCLUDE "equates/memory.i"
.INCLUDE "equates/save.i"
.INCLUDE "equates/debug.i"

.BANK 0 SLOT 0
.ORG 0
	.INCLUDE "game.s" ; FREE BYTES 15
.ORG $30A0
	.INCLUDE "palettes/palettes.a"
	.INCLUDE "graphics.s" ; FREE BYTES 19
.ORG $3A60
	.INCLUDE "gen_tile.s" ; FREE BYTES 13
.ORG $4460
	.INCLUDE "player.s" ; FREE BYTES 27
.ORG $7A10
	.INCLUDE "ex_sprite.s" ; FREE BYTES 45

.BANK 1 SLOT 0
.ORG 0
	.INCLUDE "sprite_1-main.s" ; FREE BYTES 5
.ORG $2D59
	.INCLUDE "sprite_1-1.s" ; FREE BYTES 12
.ORG $4D2A
	.INCLUDE "sprite_1-2.s" ; FREE BYTES 24
.ORG $62C8
	.INCLUDE "sprite_1-3.s" ; FREE BYTES 65

.BANK 2 SLOT 0
.ORG 0
	.INCLUDE "sprite_2-clus.s" ; FREE BYTES 68
.ORG $3630
	.INCLUDE "sprite_2-1.s" ; FREE BYTES 98
.ORG $5580
	.INCLUDE "sprite_2-2.s" ; FREE BYTES 30

.BANK 3 SLOT 0
.ORG 0
	.INCLUDE "sprite_3-1.s" ; FREE BYTES 1534
	.INCLUDE "palettes/sprites.a"
.ORG $4000
	.INCLUDE "sprite_3-2.s" ; FREE BYTES 84
.ORG $5700
	.INCLUDE "sprite_3-koopa.s" ; FREE BYTES 932
.ORG $6400
SPC700_Music2:	.INCBIN "sound/music2.bin" READ $19E0 ; FREE BYTES 544

.BANK 4 SLOT 0
.ORG 0
	.INCLUDE "map.s" ; FREE BYTES 586
.ORG $2400
	.INCLUDE "map_l2.s" ; FREE BYTES 834
.ORG $7280
	.INCLUDE "map_sprites.s" ; FREE BYTES 79

.BANK 5 SLOT 0
.ORG 0
	.INCLUDE "lv_read.s" ; FREE BYTES 487
.ORG $1000
	.INCLUDE "images/layer3.a" ; FREE BYTES 30
.ORG $2580
	.INCLUDE "dialog.s" ; FREE BYTES 90
.ORG $3C00
	.INCLUDE "lv_scroll.s" ; FREE BYTES 22
	.INCLUDE "lv_end_seq.s"
.ORG $5000
	.INCLUDE "map_l1.s" ; FREE BYTES 954
.ORG $6000
	.INCLUDE "levels/tables.a" ; FREE BYTES 0

.BANK 6 SLOT 0
.ORG 0
	.INCLUDE "levels/obj-1.a" ; FREE BYTES 71
.ORG $2600
	.INCLUDE "levels/obj-2.a" ; FREE BYTES 1692
.ORG $5000
	.INCLUDE "levels/obj-3.a" ; FREE BYTES 2759

.BANK 7 SLOT 0
.ORG 0
	.INCLUDE "levels/obj-4.a" ; FREE BYTES 19
.ORG $0100
	.INCLUDE "levels/obj-5.a" ; FREE BYTES 1159
.ORG $2600
	.INCLUDE "levels/obj-6.a" ; FREE BYTES 218
.ORG $4300
SpriteDataBank:
	.INCLUDE "levels/spr.a" ; FREE BYTES 2193
.ORG $7000
	.INCLUDE "sprite_tables.s" ; FREE BYTES 880

.BANK 8 SLOT 0
.ORG 0
.INCDIR "graphics"
GFX32:	.INCBIN "chr.lz2"
GFX33:	.INCBIN "anim.lz2"
GFX00:	.INCBIN "spr-1.lz2"
GFX01:	.INCBIN "spr-2.lz2"
GFX02:	.INCBIN "spr-3.lz2"
GFX03:	.INCBIN "spr-4.lz2"
GFX04:	.INCBIN "spr-5.lz2" READ $83
.INCDIR ""

.BANK 9 SLOT 0
.ORG 0
.INCDIR "graphics"
		.INCBIN "spr-5.lz2" SKIP $83
GFX05:	.INCBIN "spr-6.lz2"
GFX06:	.INCBIN "spr-7.lz2"
GFX07:	.INCBIN "obj-1.lz2"
GFX08:	.INCBIN "map-1.lz2"
GFX09:	.INCBIN "spr-8.lz2"
GFX0A:	.INCBIN "boss-1.lz2"
GFX0B:	.INCBIN "boss-2.lz2"
GFX0C:	.INCBIN "bg-1.lz2"
GFX0D:	.INCBIN "cin-1.lz2"
GFX0E:	.INCBIN "spr-9.lz2"
GFX0F:	.INCBIN "cin-2.lz2"
GFX10:	.INCBIN "map-2.lz2"
GFX11:	.INCBIN "spr-10.lz2"
GFX12:	.INCBIN "spr-11.lz2" READ $43
.INCDIR ""

.BANK 10 SLOT 0
.ORG 0
.INCDIR "graphics"
		.INCBIN "spr-11.lz2" SKIP $43
GFX13:	.INCBIN "spr-12.lz2"
GFX14:	.INCBIN "obj-2.lz2"
GFX15:	.INCBIN "obj-3.lz2"
GFX16:	.INCBIN "obj-4.lz2"
GFX17:	.INCBIN "obj-5.lz2"
GFX18:	.INCBIN "obj-6.lz2"
GFX19:	.INCBIN "bg-2.lz2"
GFX1A:	.INCBIN "obj-7.lz2"
GFX1B:	.INCBIN "bg-3.lz2"
GFX1C:	.INCBIN "map-3.lz2"
GFX1D:	.INCBIN "map-4.lz2"
GFX1E:	.INCBIN "map-5.lz2"
GFX1F:	.INCBIN "obj-8.lz2"
GFX20:	.INCBIN "spr-13.lz2"
GFX21:	.INCBIN "boss-3.lz2" READ $9B
.INCDIR ""

.BANK 11 SLOT 0
.ORG 0
.INCDIR "graphics"
		.INCBIN "boss-3.lz2" SKIP $9B
GFX22:	.INCBIN "cin-3.lz2"
GFX23:	.INCBIN "spr-14.lz2"
GFX24:	.INCBIN "boss-4.lz2"
GFX25:	.INCBIN "boss-5.lz2"
GFX26:	.INCBIN "cin-4.lz2"
GFX27:	.INCBIN "boss-6.lz2"
GFX28:	.INCBIN "gb-1.lz2"
GFX29:	.INCBIN "gb-2.lz2"
GFX2A:	.INCBIN "gb-3.lz2"
GFX2B:	.INCBIN "gb-4.lz2"
GFX2C:	.INCBIN "cin-5.lz2"
GFX2D:	.INCBIN "cin-6.lz2"
GFX2E:	.INCBIN "cin-7.lz2"
GFX2F:	.INCBIN "gb-5.lz2"
GFX30:	.INCBIN "cin-8.lz2"
GFX31:	.INCBIN "spr-15.lz2" ; FREE BYTES 755
.INCDIR ""

.BANK 12 SLOT 0
.ORG 0
DATA_0C8000:	.INCBIN "overworld/layer2/events/tiles.bin"
DATA_0C8D00:	.INCBIN "overworld/layer2/events/properties.bin" ; FREE BYTES 22
.ORG $1380
	.INCLUDE "credits.s" ; FREE BYTES 401
.ORG $3800
	.INCLUDE "cinema.s" ; FREE BYTES 145
.ORG $5900
Layer2BGBank:
.BASE $FF-12
	.INCLUDE "levels/bg.a"
.BASE 0
DATA_0CF7DF:	.INCBIN "overworld/layer1/levels.bin" ; FREE BYTES 33

.BANK 13 SLOT 0
.ORG 0
	.INCLUDE "tiles.s" ; FREE BYTES 152
.ORG $3C00
	.INCLUDE "tiles1.s" ; FREE BYTES 480
.ORG $4800
	.INCLUDE "tiles2.s" ; FREE BYTES 382
.ORG $5400
	.INCLUDE "tiles3.s" ; FREE BYTES 378
.ORG $6300
	.INCLUDE "tiles4.s" ; FREE BYTES 630
.ORG $7300
	.INCLUDE "images/credits.a" ; FREE BYTES 353

.BANK 14 SLOT 0
.ORG 0
SPC700_Engine:	.INCBIN "sound/engine.bin" READ $18B1
SPC700_Music0:	.INCBIN "sound/music0.bin" READ $1625
SPC700_Music1:	.INCBIN "sound/music1.bin" READ $421A ; FREE BYTES 3856

.BANK 15 SLOT 0
.ORG 0
SPC700_Samples:	.INCBIN "sound/samples.bin" READ $6F90 ; FREE BYTES 4208

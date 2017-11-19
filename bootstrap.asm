/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    bootstrap.asm

    this module will initialize the game
    engine and prepare the computer
*/

#import "include.asm"

#import "lib/vic2.lib"
#import "lib/raster.lib"
#import "lib/common.lib"

BasicUpstart2(BS) 

* = $0810   "BOOTSTRAP"

BS: {

    reset_memory()
    clear_bit0 $01  //  KERNAL ROM at $e000-$ffff

    //  initialize the raster interrupt
    init_game_raster()

    //  initialize the music
    lda #$00
    jsr MUSIC_INIT

    //  select bank 2
    lda $dd00
    and #%11111100
    ora #%00000001
    sta $dd00

    clear_screen($8000, 0)
    clear_color(1)

    //  show a sprite
    lda #$00
    sta $d010
    lda #$01
    sta $d015
    lda #$80
    sta $d000
    sta $d001
    lda #$ff
    sta $d01c
    lda #$01
    sta $d027
    lda #COLOR_PURPLE
    sta $d026
    lda #COLOR_GREEN
    sta $d025

    lda #$c3
    sta $83f8

    wait_raster()
    jsr MAIN.start

    reset_memory()
}

//  MUSIC DATA

* = MEM_MUSIC "MUSIC"
.import binary "audio/temp_music.bin"

* = $0900 "VARS"

#import "vars.asm"

* = $2800 "PROGRAM"

#import "main.asm"
#import "game.asm"
#import "title.asm"
#import "help.asm"
#import "intro.asm"
#import "hiscore.asm"
#import "raster.asm"

* = MEM_MAPS "MAPS"
.import binary "maps/map.bin"

* = MEM_MAP_CHARSET "MAP CHARSET"
.import binary "maps/map_charset.bin"
.label MEM_MAP_CHARSET_ATTR = *
.import binary "maps/map_charset_attr.bin"
.label MEM_MAP_CHARSET_TILE = *
.import binary "maps/map_charset_tileset.bin"

* = MEM_GAME_CHARSET "GAME CHARSET"
.import binary "charset/game_charset.bin"

* = MEM_SPRITES "SPRITES"
//* = $3000 "SPRITES"
.import binary "sprites/sprites.bin"


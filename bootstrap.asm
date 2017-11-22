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

    jsr MAIN.start

    reset_memory()

    jmp $fce2
}

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
#import "keyboard.asm"
#import "input.asm"

#import "data.asm"

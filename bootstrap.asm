/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    bootstrap.asm

    this module will initialize the game
    engine and prepare the computer
*/

#import "lib/vic2.lib"
#import "lib/common.lib"

BasicUpstart2(Main) 

* = $0810   "MAIN"

Main:

    lda #COLOR_BLACK
    sta VIC_BGCOL0
    jsr InitGame
    rts

#import "game.asm" 


    
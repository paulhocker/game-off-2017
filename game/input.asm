/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    raster.asm

    raster interrupts
*/

#importonce

#import "game.lib"
#import "../vars.asm"

GAME_INPUT: {

    debug_address("GAME_INPUT.start:")

start:

    jsr INPUT.read
    lda inputMove

    cmp #$00
    beq exit

    sta moveDirection

exit:

    rts


}
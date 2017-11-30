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

    //  ignore when nothing is returned
    
    cmp #$00
    beq exit

    //  TODO: store the movement commands into a queue

    sta nextMove

exit:

    rts


}
/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    help.asm

    help screen

*/
#importonce

#import "include.asm"

HELP: {

start:

    lda #STATE_TITLE
    sta GAME_STATE

    rts
    
}

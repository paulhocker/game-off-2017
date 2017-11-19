/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    intro.asm

    this screen will be used to introduce
    the player to the characters of the
    game

*/
#importonce

#import "include.asm"

INTRO: {

start:

    lda #STATE_TITLE
    sta GAME_STATE

    rts
}
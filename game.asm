/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    game.asm

    game screen
*/
#importonce

#import "include.asm"


/*
    location of the screen and
    screen buffer
*/

.label GAME_SCREEN = $9800
.label GAME_BUFFER = $9c00

GAME: {

start:

    lda #COLOR_GREEN
    sta $d021

    change_game_state(STATE_TITLE)
    rts
    
}

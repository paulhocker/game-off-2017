/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    main.asm

    controls the state of the game


*/
#importonce

#import "include.asm"

MAIN: {

start:

    change_game_state(STATE_INTRO)

    loop:

    jmp *

}

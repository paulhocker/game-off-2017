/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    bootstrap.asm

    this module will initialize the game
    engine and prepare the computer
*/

BasicUpstart2(Main)

* = $0810   "MAIN"

Main:

    jsr InitGame
    rts

#import "game.asm"

#import "lib/common.lib"

    
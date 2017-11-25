/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    vars.asm

    game variables

*/
#importonce

//  VARIABLES

.print "rasterCount: " + toHexString(*)
rasterCount:   .byte 0

.print "systemState:" + toHexString(*)
systemState:    .byte 0

.print "gameState: " + toHexString(*)
gameState:     .byte 0

.print "inputMode: " + toHexString(*)
inputMode:      .byte 0

.print "inputMove: " + toHexString(*)
inputMove:      .byte 0

.print "inputKey: " + toHexString(*)
inputKey:       .byte 0

.print "lives: " + toHexString(*)
lives:          .byte 0

.print "score: " + toHexString(*)
score:          .byte 0,0,0

.print "hiscore: " + toHexString(*)
hiscore:        .byte 0,0,0

.print "bRandom: " + toHexString(*)
bRandom:        .byte 0

.print "level:" + toHexString(*)
level:          .byte 0
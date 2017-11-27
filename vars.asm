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

.print "nextMove:" + toHexString(*)
nextMove:       .byte 0

.print "playerX:" + toHexString(*)
playerX:        .byte 0

.print "playerY:" + toHexString(*)
playerY:        .byte 0

.print "moveDirection:" + toHexString(*)
moveDirection:  .byte 0

.print "enemy1X:" + toHexString(*)
enemy1X:        .byte 0

.print "enemy2X:" + toHexString(*)
enemy2X:        .byte 0

.print "enemy3X:" + toHexString(*)
enemy3X:        .byte 0

.print "enemy4X:" + toHexString(*)
enemy4X:        .byte 0

.print "nextTile:" + toHexString(*)
nextTile:       .byte 0

.print "nextX:" + toHexString(*)
nextX:          .byte 0

.print "nextY:" + toHexString(*)
nextY:          .byte 0

.print "playerMoving:" + toHexString(*)
playerMoving:   .byte 0
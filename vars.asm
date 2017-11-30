/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    vars.asm

    game variables

*/
#importonce

#import "lib/common.lib"

//#define DEBUG

//  VARIABLES

.print "rasterCount: " + toHexString(*)
rasterCount:    .byte $00

.print "systemState:" + toHexString(*)
systemState:    .byte $00

.print "gameState: " + toHexString(*)
gameState:      .byte $00

.print "inputMode: " + toHexString(*)
inputMode:      .byte $00

.print "inputMove: " + toHexString(*)
inputMove:      .byte $00

.print "inputKey: " + toHexString(*)
inputKey:       .byte $00

.print "lives: " + toHexString(*)
lives:          .byte $00

.print "score: " + toHexString(*)
score:          .byte $00,$00,$00

.print "hiscore: " + toHexString(*)
hiscore:        .byte $00,$00,$00

.print "bRandom: " + toHexString(*)
bRandom:        .byte $00

.print "level:" + toHexString(*)
level:          .byte $00

.print "nextMove:" + toHexString(*)
nextMove:       .byte $00

.print "playerX:" + toHexString(*)
playerX:        .word $0000

.print "playerY:" + toHexString(*)
playerY:        .word $0000

.print "moveDirection:" + toHexString(*)
moveDirection:  .byte $00

.print "enemy1X:" + toHexString(*)
enemy1X:        .byte $00

.print "enemy2X:" + toHexString(*)
enemy2X:        .byte $00

.print "enemy3X:" + toHexString(*)
enemy3X:        .byte $00

.print "enemy4X:" + toHexString(*)
enemy4X:        .byte $00

.print "nextTile:" + toHexString(*)
nextTile:       .byte $00

.print "nextX:" + toHexString(*)
nextX:          .byte $00

.print "nextY:" + toHexString(*)
nextY:          .byte $00

//  is the player moving?
.print "playerMoving:" + toHexString(*)
playerMoving:   .byte $00

.print "playerSpeed:" + toHexString(*)
playerSpeed:    .word $0100

.print "spriteMsb:" + toHexString(*)
spriteMsb:      .byte $00

.print ""

//  5 actors, including the player
.print "actors"
v_actors: {
    .print "  x:" + toHexString(*)
    x:          .fill 10, $00
    .print "  y:" + toHexString(*)
    y:          .fill 10, $00
    .print "  speed:" + toHexString(*)
    speed:      .fill 10, $00
    .print "  dir:" + toHexString(*)
    dir:        .fill 5, $00
    .print "  tile:" + toHexString(*)
    tile:       .fill 5, $00
    .print "  tileX:" + toHexString(*)
    tileX:      .fill 5, $00
    .print "  tileY:" + toHexString(*)
    tileY:      .fill 5, $00
    .print "  nextX:" + toHexString(*)
    nextX:      .fill 10, $00
    .print "  nextY:" + toHexString(*)
    nextY:      .fill 10, $00
    .print "  color:" + toHexString(*)
    color:      .fill 5, $00
    .print "  sprite:" + toHexString(*)
    sprite:     .fill 5, $00
    .print "  isMoving:" + toHexString(*)
    isMoving:   .fill 5, $00
    .print "  lastTile:" + toHexString(*)
    lastTile:   .fill 5, $00
    .print "  nextTile:" + toHexString(*)
    nextTile:   .fill 5, $00
}

.print ""

//  12 possible collectibles on the screen
.print "collectibles"
v_collectibles: {
    .print "  x:" + toHexString(*)
    x:      .fill 24, $00
    .print "  y:" + toHexString(*)
    y:      .fill 24, $00
    .print "  type:" + toHexString(*)
    type:   .fill 12, $00
    .print "  life:" + toHexString(*)
    life:   .fill 12, $00
    .print "  value:" + toHexString(*)
    value:  .fill 24, $00
    .print "  sprite:" + toHexString(*)
    sprite: .fill 12, $00
}

.print ""

//  6 possible traps on the screen
.print "traps"
v_traps: {
    .print "  x:" + toHexString(*)
    x:      .fill 24, $00
    .print "  y:" + toHexString(*)
    y:      .fill 24, $00
    .print "  type:" + toHexString(*)
    type:   .fill 12, $00
    .print "  life:" + toHexString(*)
    delay:  .fill 12, $00
}

.print ""

.print "t_actors"
t_actors: {
    .print "  teddy"
    teddy: {
        nameHi: .byte >t_actor_names.teddy
        nameLo: .byte <t_actor_names.teddy
        sprite: .byte $00
        color:  .byte $01
    }
}

.print ""

.print "t_collectibles"
t_collectibles: {

    .print "  knife"
    grenade: {
        .print "    nameHi:" + toHexString(*)
        nameHi: .byte >t_collectible_names.knife
        nameLo: .byte <t_collectible_names.knife
        sprite: .byte $00
        color:  .byte $00    
        value:  .word $0000
        delay:  .word $0000
    }
}

.print ""

t_actor_names: {

    teddy:      .text "teddy*"

}

t_collectible_names: {

    knife:      .text "knife*"
}
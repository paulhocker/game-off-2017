/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    vars.asm

    game variables

*/
#importonce

//  GAME VARIABLES
.print "JOYSTICK: " + toHexString(*)
JOYSTICK:       .byte 0
.print "JOYSTICK_LAST: " + toHexString(*)
JOYSTICK_LAST:  .byte 0
.print "RASTER_COUNT: " + toHexString(*)
RASTER_COUNT:   .byte 0
.print "GAME_STATE: " + toHexString(*)
GAME_STATE:     .byte 0
.print "LAST_KEY: " + toHexString(*)
LAST_KEY:       .byte 0


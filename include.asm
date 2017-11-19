/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    include.asm

    include file for all screens

*/
#importonce

/*
    these are the locations in memory
    where data will be mapped in the
    game
*/

.label MEM_SPRITES          = $b000 
.label MEM_GAME_CHARSET     = $a800
.label MEM_MAP_CHARSET      = $a000
.label MEM_MUSIC            = $1000
.label MEM_MAPS             = $c000 
.label MEM_SCREEN           = $8000
.label MEM_SCREEN_BUFFER    = $8800
.label MEM_SCREEN_COLOR     = $d800

//  ZERO PAGE STORAGE
.label SOMETHING            = zero_page_start

//  MUSIC
.label MUSIC_INIT = MEM_MUSIC
.label MUSIC_PLAY = MEM_MUSIC + 3

//  RASTER STUFF
.var rasterPos1 = 0
.var rasterPos2 = 226
.var rasterPos3 = 250

//  GAME STATES
.const STATE_INTRO      = 0
.const STATE_TITLE      = 1
.const STATE_HELP       = 2
.const STATE_HISCORE    = 3
.const STATE_GAME       = 4

.macro change_game_state(state) {
    lda #state
    sta GAME_STATE
}
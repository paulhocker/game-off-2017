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

//  GAME STATE
.const GAME_STATE_INPUT     = 5
.const GAME_STATE_LOGIC     = 4
.const GAME_STATE_MOVE      = 3
.const GAME_STATE_DRAW      = 2
.const GAME_STATE_EFFECT    = 1
.const GAME_STATE_MANAGE    = 0

.const MAX_GAME_STATE       = 5
.const MIN_GAME_STATE       = 0

//  SYSTEM STATES
.const SYS_STATE_TITLE      = 1
.const SYS_STATE_HELP       = 2
.const SYS_STATE_HISCORE    = 3
.const SYS_STATE_GAME       = 4
.const SYS_STATE_INTRO      = 5
.const SYS_STATE_QUIT       = 0
.const SYS_STATE_DEBUG      = 99

.macro change_system_state(state) {
    lda #state
    sta gameState
}


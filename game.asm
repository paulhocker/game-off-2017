/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    game.asm

    game screen
*/
#importonce

#import "include.asm"
#import "lib/vic2.lib"
#import "lib/raster.lib"
#import "lib/common.lib"


/*
    location of the screen and
    screen buffer
*/

.label GAME_SCREEN = $9800
.label GAME_BUFFER = $9c00

GAME: {

start:

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    clear_screen(32, 0)
    clear_color(1)
    print_text(TITLE, $8000+(40*22), "@")

    //  show a sprite
    lda #$00
    sta $d010
    lda #$01
    sta $d015
    lda #$80
    sta $d000
    sta $d001
    lda #$ff
    sta $d01c
    lda #$01
    sta $d027
    lda #COLOR_PURPLE
    sta $d026
    lda #COLOR_GREEN
    sta $d025

    lda #$c3
    sta $83f8

loop:

    keyboard_read()
    lda LAST_KEY
    cmp #$20
    bne loop

    change_game_state(STATE_TITLE)
    lda #$00
    sta LAST_KEY

    jmp MAIN.loop

TITLE: .text "game@"

}

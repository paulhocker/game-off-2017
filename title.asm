/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    input.asm

    title screen

*/
#importonce

#import "include.asm"


TITLE: {

start:

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    clear_screen(32, 0)
    clear_color(1)
    print_text(TITLE, $8000+(40*22), "@")

loop:

    keyboard_read()
    lda LAST_KEY
    cmp #$20
    bne loop

    change_game_state(STATE_GAME)
    lda #$00
    sta LAST_KEY

    jmp MAIN.loop

TITLE: .text "title@"

}
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

    debug_address("TITLE.loop:")

    keyboard_read(inputKey)
    lda inputKey
    cmp #$20
    bne loop

    change_system_state(SYS_STATE_GAME)
    lda #$00
    sta inputKey

    jmp MAIN.loop

TITLE: .text "title@"

}
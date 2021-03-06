/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    intro.asm

    this screen will be used to introduce
    the player to the characters of the
    game

*/
#importonce

//#import "include.asm"
//#import "keyboard.asm"
#import "lib/common.lib"
#import "lib/vic2.lib"

INTRO: {

start:

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    clear_screen(32, 0)
    clear_color(COLOR_WHITE)
    print_text(TITLE, $8000+(40*22), "@")

loop:

    debug_address("INTRO.loop:")

    jsr INPUT.read
    lda inputMove
    cmp #GAME_MOVE_FIRE
    beq next_state

    lda inputKey
    cmp #$20
    bne loop

next_state:

    change_system_state(SYS_STATE_TITLE)
    lda #$00
    sta inputKey

    jmp MAIN.loop

TITLE: .text "intro@"

}


/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    hiscore.asm

    show hiscores

*/#importonce

//#import "include.asm"

HISCORE: {

start:

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    clear_screen(32, 0)
    clear_color(1)
    print_text(TITLE, $8000+(40*22), "@")

loop:

    debug_address("HISCORE.loop:")

    keyboard_read(inputKey)
    lda inputKey
    cmp #$20
    bne loop

    change_system_state(SYS_STATE_TITLE)
    lda #$00
    sta inputKey

    jmp MAIN.loop

TITLE: .text "hiscore@"

}

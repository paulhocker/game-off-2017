/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    hiscore.asm

    show hiscores

*/#importonce

#import "include.asm"

HISCORE: {

start:

    lda #COLOR_GREEN
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    jmp MAIN.start

}

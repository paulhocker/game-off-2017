/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    help.asm

    help screen

*/
#importonce

#import "include.asm"

HELP: {

start:

    lda #COLOR_YELLOW
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    jmp MAIN.start

}

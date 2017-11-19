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

    lda #$00
    sta $d021

    jmp *
    
}
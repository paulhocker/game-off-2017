/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    hiscore.asm

    show hiscores

*/#importonce

#import "include.asm"

HISCORE: {

start:

    lda #STATE_TITLE
    sta GAME_STATE

    rts
}

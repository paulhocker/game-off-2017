/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    raster.asm

    raster interrupts
*/

#importonce

#import "include.asm"
#import "vars.asm"
#import "lib/raster.lib"
#import "lib/vic2.lib"
#import "lib/common.lib"

.macro init_game_raster() {

    init_raster_interrupt(rasterPos1, RASTER_1)

}

//  main game interrupt
RASTER_1: {

    start_interrupt()

    //  set screen and char memory
    lda #%00001000
    sta $d018

    lda #$18
    sta $d016
    lda #$10
    sta VIC2_BGCOL1
    lda #$11
    sta VIC2_BGCOL2

    //jsr MUSIC_PLAY

    set_interrupt_vector(rasterPos2, RASTER_2)

    end_interrupt()
}

//  lower panel interrupt
RASTER_2: {

    start_interrupt()

    //  set screen and char memory
    lda #%00001010
    sta $d018

    lda #$08
    sta $d016

    jsr DEBUG.show

    set_interrupt_vector(rasterPos3, RASTER_3)

    end_interrupt() 
}

//  non viewable interrupt
RASTER_3: {

    start_interrupt()

    //  set screen and char memory
    lda #%00001010
    sta $d018

    set_interrupt_vector(rasterPos1, RASTER_1)

    inc rasterCount

    end_interrupt()
}

WAIT_RASTER: {
    lda rasterCount
    cmp #$01
    bcc WAIT_RASTER
    lda #$00
    sta rasterCount
    rts
}

DEBUG: {

    show: {

        debug_address("DEBUG.show:")

        ldy #$02
        ldx #$02

        !:

        lda score, x

        lsr
        lsr 
        lsr
        lsr 

        clc
        adc #27
        
        sta MEM_SCREEN + 24 * 40, y

        iny 

        lda score, x
        and #$0f 
        clc
        adc #27
        sta MEM_SCREEN + 24 * 40, y 
        iny 

        dex 
        bpl !-
        ldx #$02
        ldy #34

        rts
    }
}

.macro wait_raster() {
    jsr WAIT_RASTER
}


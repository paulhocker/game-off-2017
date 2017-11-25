/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    raster.asm

    raster interrupts
*/

#importonce

//#import "include.asm"
//#import "vars.asm"
#import "lib/raster.lib"
#import "lib/vic2.lib"
#import "lib/common.lib"

.var raster_split = 36
.var sprite_buffer = 8
.var sprite_margin = 4

.macro init_game_raster() {

    init_raster_interrupt(rasterPos1, RASTER_1)

}

//  main game interrupt
RASTER_1: {

    start_interrupt()

    //  set screen and char memory
    lda #%00001000
    sta $d018

    //lda #$18
    //sta $d016

    //lda #$10
    //sta VIC2_BGCOL1
    //lda #$11
    //sta VIC2_BGCOL2

    set_interrupt_vector(rasterPos1 + (1 * raster_split), RASTER_SPRITE_0)
    //set_interrupt_vector(rasterPos2, RASTER_2)

    end_interrupt()
}

RASTER_SPRITE_0: {

    start_interrupt()
    .var raster =rasterPos1 + 2 + (1 * raster_split);
    raster_wait(raster)
    draw_all_sprites(raster + sprite_buffer + sprite_margin, 0)
    set_interrupt_vector(rasterPos1 + (2 * raster_split), RASTER_SPRITE_1)
    end_interrupt()

}

RASTER_SPRITE_1: {

    start_interrupt()
    .var raster = rasterPos1 + 2 + (2 * raster_split);
    raster_wait(raster)
    draw_all_sprites(raster + sprite_buffer + sprite_margin, 1)
    set_interrupt_vector(rasterPos1 + (3 * raster_split), RASTER_SPRITE_2)
    end_interrupt()

}

RASTER_SPRITE_2: {

    start_interrupt()
    .var raster = rasterPos1 + 2 + (3 * raster_split);
    raster_wait(raster)
    draw_all_sprites(raster + sprite_buffer + sprite_margin, 0)
    set_interrupt_vector(rasterPos1 + (4 * raster_split), RASTER_SPRITE_3)
    end_interrupt()

}

RASTER_SPRITE_3: {

    start_interrupt()
    .var raster = rasterPos1 + 2 + (4 * raster_split);
    raster_wait(raster)
    draw_all_sprites(raster + sprite_buffer + sprite_margin, 1)
    set_interrupt_vector(rasterPos1 + (5 * raster_split), RASTER_SPRITE_4)
    end_interrupt()

}

RASTER_SPRITE_4: {

    start_interrupt()
    .var raster = rasterPos1 + 2 + (5 * raster_split);
    raster_wait(raster)
    draw_all_sprites(raster + sprite_buffer + sprite_margin, 0)
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

    inc rasterCount

    set_interrupt_vector(rasterPos1, RASTER_1)

    end_interrupt() 
}

//  non viewable interrupt
RASTER_3: {

    start_interrupt()

    //  set screen and char memory
    lda #%00001010
    sta $d018

    jsr MUSIC_PLAY
    
    set_interrupt_vector(rasterPos1, RASTER_1)


    end_interrupt()
}

.macro raster_wait(line_number) {
!wait:
  lda #line_number
  cmp $d012
  bne !wait-
  bit $d011
  .if (line_number <= 255) {
    bmi !wait-
  } else {
    bpl !wait-
  }
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

.macro border(color) {
  lda #color
  sta $d020
}

.macro background(color) {
  lda #color
  sta $d021
}

.macro draw_all_sprites(position_y, rev) {
  ldy #position_y
  .for (var i = 5; i < 8; i++) {

    tya
    sta VIC2_SP0X + 2*i + 1
    .var position_x = 0
    .if (rev == 0) {
        .eval position_x = 45 + 35*i }
  

  .if (rev == 1) {
        .eval position_x = 344 - 35*i }
  

    lda #position_x
    sta VIC2_SP0X + 2*i
  .if (position_x >= 256) {
    sec
  } else {
    clc
  }
    bcc no_overflow
  overflow:
    lda VIC2_MSGIX
    ora #1<<i
    jmp overflow_end
  no_overflow:
    lda VIC2_MSGIX
    and #255 - [1<<i] 
  overflow_end:
    sta VIC2_MSGIX

    //lda #SPRITE_BITMAPS + i
    //sta sprites.pointers + i

  }
}

